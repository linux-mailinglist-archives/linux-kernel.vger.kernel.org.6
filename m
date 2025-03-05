Return-Path: <linux-kernel+bounces-546183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF5A4F76F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29ABF16DCB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03E1E5B8E;
	Wed,  5 Mar 2025 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="muwW+n/e"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12791CAA62
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741157211; cv=none; b=N1UyN1rpUR75kJ9Ub51qDhb6xCQYfR+Kredprwa0whzm4MO+m6gjwOqwYb2EJPHDtMchmgQ5W6rpwbNLcfkQsna4F3L0jcm0HOhAg9SJe+tWLMouDHr/QxfN/zkDZmPYDNPhICQYPfklF+e6rssbyWd1Y4cCx5j5lQv5kQ8DOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741157211; c=relaxed/simple;
	bh=NaAakKV9oZ0BzkhQ8FGMgWGHaOXk9oBddWWP3BgtQNA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FWLAfT+rIvEf80AP1aS5q3deD483GLZCEew0a/itqSnsR6huZEAJGlmQ1hiDaMThACs9m9o/sUwStrt4v88yI14gXBe/dprssDSWA0kpPoU7XgbwwQ6STwZ95fUFSB53dEP3eant4ZoccqMPzyLNrKjRWcTvyYpenfsGkkXnKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=muwW+n/e; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741157207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+m6YT78B+/+5RlCixAp+h1XWT7IH5zdv2Uk3SxKPrjw=;
	b=muwW+n/eSvSFfa8gITkkPTVVsFzqMGTg/ADeTNnT/JVWMBax+FxcE081POnd7PojxZCrYB
	dwDAkdeaNgl6Kg+vLwZ6W4y8RFXqi7sngMe792oKrIl+SodMBMQmbOj4LHd81R3DrvQzrp
	kkOld2Q/mP8QGeNaFZX5iOnqCKAM9gk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] mm/shrinker_debug: Fix possible memory leak in
 shrinker_debugfs_rename function.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <875d80ee-d99a-4580-8648-36adb1e8591c@kylinos.cn>
Date: Wed, 5 Mar 2025 14:46:02 +0800
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <451E5C9A-F7FB-41DD-B760-25E4883B0861@linux.dev>
References: <20250305020123.605496-1-liuye@kylinos.cn>
 <99A7645C-B8FB-4F28-B4B8-D5372F4C001E@linux.dev>
 <a2b3609c-9907-4ee6-a0df-6b4c84100d33@bytedance.com>
 <875d80ee-d99a-4580-8648-36adb1e8591c@kylinos.cn>
To: liuye <liuye@kylinos.cn>
X-Migadu-Flow: FLOW_OUT



> On Mar 5, 2025, at 14:10, liuye <liuye@kylinos.cn> wrote:
>=20
>=20
> =E5=9C=A8 2025/3/5 11:26, Qi Zheng =E5=86=99=E9=81=93:
>>=20
>>=20
>> On 3/5/25 11:17 AM, Muchun Song wrote:
>>>=20
>>>=20
>>>> On Mar 5, 2025, at 10:01, Liu Ye <liuye@kylinos.cn> wrote:=20
>>>>=20
>>>> After calling debugfs_change_name function, the return value should =
be=20
>>>> checked and the old name restored. If debugfs_change_name fails, =
the new=20
>>>> name memory should be freed.
>>>=20
>>> Seems it is not a big problem, no memory leak at least. The effect =
is that=20
>>> the shrinker->name is not consistent with the name displayed in =
debugfs.=20
>>> Right? But the improvement LGTM. So:
>>=20
>> Right, so the subject needs to be changed.=20
>>=20
>> Maybe:=20
>>=20
>> mm: shrinker: fix name consistency issue in shrinker_debugfs_rename()
>>=20
>> ?
>  I will send a new patch using this subject later.

Please update the commit message as well to include the effect.

> And add  Reviewed-by=EF=BC=9AQi Zheng <zhengqi.arch@bytedance.com> =EF=BC=
=9F
>=20
>>=20
>> BTW, it seems that the callers of shrinker_debugfs_rename() did not=20=

>> process the return value of the function?
>=20
> Yes,  At the same time, I also found that many positions using=20
> debugfs_change_name did not determine the return value.
>=20
>>=20
>>>=20
>>> Reviewed-by: Muchun Song <muchun.song@linux.dev>=20
>>>=20
>>> Thanks.
> Thanks.
>>>=20
>>>>=20
>>>> Signed-off-by: Liu Ye <liuye@kylinos.cn>=20
>>>> ---=20
>>>> mm/shrinker_debug.c | 8 ++++++--=20
>>>> 1 file changed, 6 insertions(+), 2 deletions(-)=20
>>>>=20
>>>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c=20
>>>> index 794bd433cce0..20eaee3e97f7 100644=20
>>>> --- a/mm/shrinker_debug.c=20
>>>> +++ b/mm/shrinker_debug.c=20
>>>> @@ -214,10 +214,14 @@ int shrinker_debugfs_rename(struct shrinker =
*shrinker, const char *fmt, ...)=20
>>>> ret =3D debugfs_change_name(shrinker->debugfs_entry, "%s-%d",=20
>>>> shrinker->name, shrinker->debugfs_id);=20
>>>>=20
>>>> +     if (ret) {=20
>>>> +         shrinker->name =3D old;=20
>>>> +         kfree_const(new);=20
>>>> +     } else {=20
>>>> +         kfree_const(old);=20
>>>> +     }=20
>>>>     mutex_unlock(&shrinker_mutex);=20
>>>>=20
>>>> -     kfree_const(old);=20
>>>> -=20
>>>>     return ret;=20
>>>> }=20
>>>> EXPORT_SYMBOL(shrinker_debugfs_rename);=20
>>>> --=20
>>>> 2.25.1=20
>>>>=20
>>>=20
>>=20


