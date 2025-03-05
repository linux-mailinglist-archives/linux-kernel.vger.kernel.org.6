Return-Path: <linux-kernel+bounces-546021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23817A4F545
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521AF16D07E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7FA139CF2;
	Wed,  5 Mar 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KP+rbTv7"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921DE2E3383
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144727; cv=none; b=W9diEV6sZkXcoYA+ZboCK8vIz10vbA/bDK+9fWS45BUn2eC4wcbe/1Epd7qHcZ1PyqWxcptzMhchqZPZNdqZD6vXgEgaNiISu4/opKYUy1jOyQoPZD1KKX1VztROpTzbpajT3TEyP/6gOkKkck8eR18ksGba0XtjzYHaNAV90GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144727; c=relaxed/simple;
	bh=HnJ8/ZOPK8vTGJQ47TkxduYzmam+ARptSBFlthQ+pbw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i8OBlKsyKwh2evU+phcQAy3xg8zEuVS6oT+BYM8NhYIl+YCJJaT9eGDHcOEqg86jwvSGCXtUynCat2Ql6WLEZPHnJn2eBHyZ3bHUqMxcX3Ro9HkeMXvOT/mlgkta9XXktN8YXHKakZNwxfAZtATFaZLB/0zzI7KubzqKCo0PlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KP+rbTv7; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741144722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aw3iDT/PkuvbilfEibwylx5xq+5vaoH00LShFW/cxdY=;
	b=KP+rbTv7YlmSKajvTg9ibpLiBycvjkoWYS6EPpl0pbmcSlWRSNLaoGNW8Q7a4JKulUbf7D
	udxOxQ2F/Dc7tebAb2sRVPnubSqBNb/+QfHztrOmNNMZUD8hZsJF/8ZJ+Y8GLEJ5fyNbI1
	CR2LObZCy7SmMzMlT5xR7+b43ZhqH9M=
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
In-Reply-To: <20250305020123.605496-1-liuye@kylinos.cn>
Date: Wed, 5 Mar 2025 11:17:48 +0800
Cc: akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <99A7645C-B8FB-4F28-B4B8-D5372F4C001E@linux.dev>
References: <20250305020123.605496-1-liuye@kylinos.cn>
To: Liu Ye <liuye@kylinos.cn>
X-Migadu-Flow: FLOW_OUT



> On Mar 5, 2025, at 10:01, Liu Ye <liuye@kylinos.cn> wrote:
>=20
> After calling debugfs_change_name function, the return value should be
> checked and the old name restored. If debugfs_change_name fails, the =
new
> name memory should be freed.

Seems it is not a big problem, no memory leak at least. The effect is =
that
the shrinker->name is not consistent with the name displayed in debugfs.
Right? But the improvement LGTM. So:

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

>=20
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
> mm/shrinker_debug.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> index 794bd433cce0..20eaee3e97f7 100644
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c
> @@ -214,10 +214,14 @@ int shrinker_debugfs_rename(struct shrinker =
*shrinker, const char *fmt, ...)
> ret =3D debugfs_change_name(shrinker->debugfs_entry, "%s-%d",
> shrinker->name, shrinker->debugfs_id);
>=20
> + 	if (ret) {
> + 		shrinker->name =3D old;
> + 		kfree_const(new);
> + 	} else {
> + 		kfree_const(old);
> + 	}
> 	mutex_unlock(&shrinker_mutex);
>=20
> - 	kfree_const(old);
> -
> 	return ret;
> }
> EXPORT_SYMBOL(shrinker_debugfs_rename);
> --=20
> 2.25.1
>=20


