Return-Path: <linux-kernel+bounces-362040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA68F99B036
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E8EB21C7C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECFC1799F;
	Sat, 12 Oct 2024 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GSisi06m"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB910940
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701025; cv=none; b=CmiUHcAASJNy7x4nFJv/Pv1p0XlKvtOaSQXWl7fltknVU3fC8rfGHPgS79TSx4yO069br9KumeH2ck/CqvZE/NJeQ8SPE/sUfsxPqXe24mtbBrwbU4D8v6WJiNtAHdUlWzrw4eP4c6U1k6kp5+sk9WO0Hd0eVCq8Nq5nPIBr8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701025; c=relaxed/simple;
	bh=ETG6es4LYnOKjvPoafCe3E53dgmEX7Vn9LX2MaiyQ40=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QYgdcKdpCIvSSXXngLaXFD3FEQvmniV2EkPgMD+vRwBEjNytOzLsqMuy2hCXyMuIlWaDADC55+CojlClp+/59A+G7f0oH5lM9bR5aktQ2iFiYUqTS3XPDc+G2JFf+M6R5CvLkfi1W2uzVM0qMXvtGD3ce9EAMga3E+N5Xt4nouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GSisi06m; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728701020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmcrt7U3ZF2GZVkRUj69jQ8X2zDyWcY2mYXTszBBFwY=;
	b=GSisi06m315dLYfNpbTGWOhZdm/bxa8ZTCfBuEMvN6D1G7MltFacsUMj+cO0HczBsia0tS
	TuVHLZ6W/T47quDACtOuZw2D7/glacw49xjNJatK8IT9zZWME7ZPhxnkk8ymQ+taiDSOJO
	wX+t2EsiXvXnnbtnX8knf/VB5B1+f8c=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] mm: shrinker: avoid memleak in alloc_shrinker_info
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241011142105.391157-1-chenridong@huaweicloud.com>
Date: Sat, 12 Oct 2024 10:42:52 +0800
Cc: akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 chenridong@huawei.com,
 wangweiyang2@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <63593DC0-21DD-40C1-A4D8-6082F2BB4222@linux.dev>
References: <20241011142105.391157-1-chenridong@huaweicloud.com>
To: Chen Ridong <chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 11, 2024, at 22:21, Chen Ridong <chenridong@huaweicloud.com> =
wrote:
>=20
> From: Chen Ridong <chenridong@huawei.com>
>=20
> A memleak was found as bellow:
>=20
> unreferenced object 0xffff8881010d2a80 (size 32):
>  comm "mkdir", pid 1559, jiffies 4294932666
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>  backtrace (crc 2e7ef6fa):
>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>    [<ffffffff81198dd9>] online_css+0x29/0xa0
>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> In the alloc_shrinker_info function, when shrinker_unit_alloc return
> err, the info won't be freed. Just fix it.
>=20
> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for =
shrinker_info::{map, nr_deferred}")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
> mm/shrinker.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..e4b795ee6d2e 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> 		if (!info)
> 			goto err;
> 		info->map_nr_max =3D shrinker_nr_max;
> - 		if (shrinker_unit_alloc(info, NULL, nid))
> + 		if (shrinker_unit_alloc(info, NULL, nid)) {
> + 			kvfree(info);
> 			goto err;

Since we already use goto to do the cleanup for failure, I don't like
to mix two different ways to do the similar thing. I suggest adding
the kvfree (BTW, it could handle NULL argument) to the label of err.

Muchun,
Thanks.

> + 		}
> 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, =
info);
> 	}
> 	mutex_unlock(&shrinker_mutex);
> --=20
> 2.34.1
>=20


