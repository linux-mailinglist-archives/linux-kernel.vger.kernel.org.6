Return-Path: <linux-kernel+bounces-545188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B18A4E9EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB7F7A19CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D828F951;
	Tue,  4 Mar 2025 17:31:57 +0000 (UTC)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7528F94C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109517; cv=fail; b=lr9WLhIsAsTO2+LzBNQIglXyQ3RZ3saigRnm4QEJT44zQTfkfxUAwjLHissFWpeYBt8S+JO3lV9e2vapGQWUy14I/d4l0+U7FNaCwX6ogqYejsQH2hdBjJicd32ar9I+vnPr5muADdaSzXlbyo0vV9jU5t3Nnb8CocdSOvljgzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109517; c=relaxed/simple;
	bh=g4TURbv4nGbpbAVC8U4BErPeeKYK1y/c3s2spOFnum8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZT+OgnEomHRcs8N+rQ0udbdcDS09D/DKVOMUiydUcgzjA2Krp1g8cSEr6IicTe40odafa2ezPapOOmbUuJlyySFkDRy09qDPUF+uJ44ra4EmWHUrpWN5rnqwE2m++jR+ky55Rfp/1UzUeLqJ3+SNGDa+HbOdxYRq7B7a/LBdxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 04AB640D2059
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:31:54 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fcD0c1vzG0KH
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:24:28 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 09D594274B; Tue,  4 Mar 2025 18:24:21 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541842-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 6E62841F4D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:43:59 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id DFFC83063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:43:58 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFC93A8083
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839B212FAD;
	Mon,  3 Mar 2025 13:43:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CAF8634C;
	Mon,  3 Mar 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009420; cv=none; b=IvLMYGxo4k6255crXmoa595c9tN1i3rFrO0ruohVQOOZW8u8/Mm8BbitK6hbqdsBUNGXaEqNjwY/cP+8FFEMNyaFrWWqMNyMa4/OGlZUEcZk9yzz1AMkDdE58SokU6gdRV9TdKh3q4xv0uEbOe+GDb3vANtdTWowkSIKitDGSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009420; c=relaxed/simple;
	bh=EC3LnVqPbgmcXuI5roGeL5xwiC6iDSLY8CiY9mZTp8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyiQeKZNMVBezMyBBq9yneBOrr6ZY8BJ2YTf+813qBVVkdyHVplro3aBjF3skDCczE5MrQv/M6cPBNDxegZCyhbCQ03YLIYqm2WEVvXwjCW63cf4yZz5l1dRj205kDCmogXAPKXd5VTVSq+QbCXnh58S5Wb4yaqfICzOnF+zwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0855F106F;
	Mon,  3 Mar 2025 05:43:51 -0800 (PST)
Received: from [10.57.66.216] (unknown [10.57.66.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8123F673;
	Mon,  3 Mar 2025 05:43:35 -0800 (PST)
Message-ID: <7778df43-5169-4d1c-9fe6-44bee39edfc1@arm.com>
Date: Mon, 3 Mar 2025 13:43:33 +0000
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: fix an API misuse issue in em_create_pd()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Haoxiang Li <haoxiang_li2024@163.com>
Cc: len.brown@intel.com, pavel@kernel.org, dietmar.eggemann@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250303034337.3868497-1-haoxiang_li2024@163.com>
 <CAJZ5v0g5RJaHeYqiP3khp2vPyVHj0W35ab4gtBJ0R14nhSqa_A@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g5RJaHeYqiP3khp2vPyVHj0W35ab4gtBJ0R14nhSqa_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fcD0c1vzG0KH
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714217.75866@Ten/x9RIt52FXe49wu6bGw
X-ITU-MailScanner-SpamCheck: not spam



On 3/3/25 12:38, Rafael J. Wysocki wrote:
> On Mon, Mar 3, 2025 at 4:43=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163=
.com> wrote:
>>
>> Replace kfree() with em_table_free() to free
>> the memory allocated by em_table_alloc().
>=20
> Ostensibly, this is fixing a problem, but there's no problem described
> above.  Please describe it.

Thank Rafael for adding me on CC.

>=20
>> Fixes: 24e9fb635df2 ("PM: EM: Remove old table")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
>> ---
>>   kernel/power/energy_model.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 3874f0e97651..71b60aa20227 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -447,7 +447,7 @@ static int em_create_pd(struct device *dev, int nr=
_states,
>>          return 0;
>>
>>   free_pd_table:
>> -       kfree(em_table);
>> +       em_table_free(em_table);
>>   free_pd:
>>          kfree(pd);
>>          return -EINVAL;
>> --
>> 2.25.1
>>

IMO there is no need to use RCU freeing mechanism, since
this table is not used yet. We failed in the initialization
steps, so we can simply call kfree() on that memory.

That 'free_pd_table' goto label is triggered before the call to:

rcu_assign_pointer(pd->em_table, em_table);

IMO this is even dangerous in the patch to abuse RCU free for such case.

Regards,
Lukasz


