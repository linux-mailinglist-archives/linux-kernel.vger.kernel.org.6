Return-Path: <linux-kernel+bounces-363281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA7299BFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5676281B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E21422B8;
	Mon, 14 Oct 2024 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZcqnzl7"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A122318
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887157; cv=none; b=p84eF1ohZJrIm6KhzPMMAk9Y69FD11w2ytbFNT2aPp/wIVs6rbzQx8fPBJVtVFIPZHIbvA1bHkleXE0HbEFRc/I34rghwmFfwqgclXcMSXdA96XMovDyFdm1ZjJx2oA3VqNgHMFUqun8fE1kwQZrMmTmTdbw1zhl2CzoIWo0baI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887157; c=relaxed/simple;
	bh=+koo6QFKHCOd2RdK0fcAsnUb3mglWLegbw1X29P8XrY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SwaswMDd7fBL53JZcD2LQkQS/yIQTmfCx7GdeXKzShYhD/a8Dpt440gFgwombxfQIQ3enEoGW+2XYp/rh15HR4hbGc9uxPF7a+iuaP6Rdkg4z4M6NMv9kRVv5TMsJ9fUYbmf+AdujU/ECOLqvcBuXT9P/13V8IiPQeZfrAIw7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZcqnzl7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728887153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2alqM5wMLrvrHUM45E9EVij6kVf1hx5mqn5x6ULr8Vo=;
	b=sZcqnzl7JiISCJ5+wBJaMA00C70UmiXVqminBAjxWzUh4MbS3t8pN/2gF+tqiQBgrvFMgT
	LMjCeA8MsWCR8kL+fTSuHaRTgpe5Eay+3EddrF46qf/4AA+cnAd6IZHMV1yJ6RTpVzXuke
	uVba9mWolMweaf6bwZVREGFz3Xi+krU=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241014032336.482088-1-chenridong@huaweicloud.com>
Date: Mon, 14 Oct 2024 14:25:04 +0800
Cc: akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 chenridong@huawei.com,
 wangweiyang2@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABC60698-90FC-4F91-A25E-AF30640B38A9@linux.dev>
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
To: Chen Ridong <chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 14, 2024, at 11:23, Chen Ridong <chenridong@huaweicloud.com> =
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
> mm/shrinker.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..92270413190d 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>=20
> err:
> 	mutex_unlock(&shrinker_mutex);
> + 	kvfree(info);

Please transpose kvfree() to the place above mutex_unlock().
We should release the resources in the order which is inverse
to the that of acquiring resources.

Thanks.

> 	free_shrinker_info(memcg);
> 	return -ENOMEM;
> }
> --=20
> 2.34.1
>=20


