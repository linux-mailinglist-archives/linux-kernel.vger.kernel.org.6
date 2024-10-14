Return-Path: <linux-kernel+bounces-363952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B2299C8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABDE1C2225B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF91194ACD;
	Mon, 14 Oct 2024 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Js1J+5FR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5nfif1v"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A21802DD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905408; cv=none; b=T5xutZPFIL3XxkmFhj2kixO/mcOTVa4/H8qAl4km6DzInmn1+DMs4awE7N2Q+M4e/POhPHWl5MOJ+iW9LouaCONG4Wpp9deUStYLtkIsAWL4emA3uSHylDMang9yI3kkO0p+cfycGxSVKiRtuCBjpUxhuk2v+8Zwsb8RrFfDQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905408; c=relaxed/simple;
	bh=Yd/wa+kJFJdIbwoso15lME9CyV/MYi2Z5nJJvR1ma5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi62Fv3su84ymruHg3uakroszlSpBeAV+7DRKywu3mSuvmRFB5wcCU4q7smy5Y7b7GL/J6ybIxKUj5ZfwvW+6IYPGm9Yp+INBHNl7LeR6L7MLEhbuBWHgqP7WsuYl6Ivi56/WcmXzfnkLCcmZrqLh6RUweBCKc/ljMsHt83iKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Js1J+5FR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5nfif1v; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EFCB13804A4;
	Mon, 14 Oct 2024 07:30:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 14 Oct 2024 07:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728905405; x=
	1728991805; bh=Nkaa57U1k6kPFROOwcTpg/meaVbmUL23D4tfu0N0is8=; b=J
	s1J+5FRFHAllmksl2lZxwmDKUmxnAXKpLs2vHpPM1IsawKDs8ZqtBm5Dn9lwclWx
	TPP1sSFhw6zj2sgHekFtC1jS0fYte6SB17BL0lK1ZBryfQdpx6tuwBR/4aq2ps/2
	XgXRlJYxT47+JP7SOkwQjcBuDSLeAix7VdfPHZD0PJFNxu0ODz4D5i8q6rh55uCr
	fBnjA3eY1FGt7guQRmsUsJepqvcxJyJR1s6cKy9NZRnOGEAPfFbMdou1L17NuDop
	BVzrJrtNVtuk69W1qnDv5fFycgcLP7F4jSAVNfcHfJhfFM9s5w9bbbIiaMLl98mX
	r1Lv9Gp2qbnpSYAPsBuOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728905405; x=1728991805; bh=Nkaa57U1k6kPFROOwcTpg/meaVbm
	UL23D4tfu0N0is8=; b=E5nfif1vHDNBBBlrQjZaXOA3zaMl4H36FzydAX2LKcE+
	wVe+CS+bMFT6tS5zDL3bsh5xrbY9Sk7zItFEFYhHeaioHClsCJ6cdzKGHMDAo8k6
	YorrCBdU1IgIgDE4SPe+tgCLzyVapnyvDEuRG7p/X9a8Hdw7UdJ8Gk67RrJePgcy
	6ioxRIMBvTKXZFKlVe7sDlM8Ke7vN8C1FWhvOdV835A+Ru4zSi9xfXID0e7zUrSy
	cK8N51aU+rBds5XY/VsqSJeuxGaDDPDFYouc6qL0U8ChBt7WEuZT+DyUyTlFM6tI
	MXm6IaMbRAzOaNe+PjPlMCIsiGABlWMHzKCEMIMQEA==
X-ME-Sender: <xms:vAANZ4c_hHK6TXmoNoy4y-NzGwPD-co7Vu7x3BvE7utPzkXCMKrheA>
    <xme:vAANZ6NyzH0Z0cCj9p60mZRFmNLu4OgrhBsv1IEMZfAMJnj_maICu5GNeJ6r1CLru
    m80AlE4A9sVWliyLPo>
X-ME-Received: <xmr:vAANZ5iZrz6vlUEVbmyWjdUy-OvzUe8lC5wWSQ5yWlfl8aJ2QcnGPgeB2aaczT531Qwikw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegthhgvnhhrihguohhngheshhhurgifvghitghlohhuugdrtghomhdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epuggrvhhiugesfhhrohhmohhrsghithdrtghomhdprhgtphhtthhopeiihhgvnhhgqhhi
    rdgrrhgthhessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehrohhmrghnrdhguh
    hshhgthhhinheslhhinhhugidruggvvhdprhgtphhtthhopehmuhgthhhunhdrshhonhhg
    sehlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhvghnrhhiughonhhgsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:vAANZ99hxiExS1snXwH1TGOxx3WxgjFKoeU82w4xONV9y5WIwlrsWA>
    <xmx:vAANZ0vKPXW17AjyQRuHNmxKLbqLirAkJy6pEObqKxRdeX7dpJi_Og>
    <xmx:vAANZ0EgGXdZ5oFjoRZF5azrzhis38KYVoh8znm4e9DNbqE8BRX80w>
    <xmx:vAANZzOzNtVKRpESDVJL_MZ2aP-xqossNugP5qNqYEsUeqIIWObbtg>
    <xmx:vQANZ1mFp5qlbCeizVGK5GaJE531B0FiQIHw8c75VjGJq-6T6lAdv2qf>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 07:29:59 -0400 (EDT)
Date: Mon, 14 Oct 2024 14:29:55 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com, 
	zhengqi.arch@bytedance.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
Message-ID: <m3cjozicivz4ydv6ovzkupuzpcvc7uptlhjd3bndpsak3z7ill@6txhj7tpejir>
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014032336.482088-1-chenridong@huaweicloud.com>

On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A memleak was found as bellow:
> 
> unreferenced object 0xffff8881010d2a80 (size 32):
>   comm "mkdir", pid 1559, jiffies 4294932666
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>   backtrace (crc 2e7ef6fa):
>     [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>     [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>     [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>     [<ffffffff81198dd9>] online_css+0x29/0xa0
>     [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>     [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>     [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>     [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>     [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>     [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>     [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>     [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> In the alloc_shrinker_info function, when shrinker_unit_alloc return
> err, the info won't be freed. Just fix it.
> 
> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/shrinker.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..92270413190d 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  
>  err:
>  	mutex_unlock(&shrinker_mutex);
> +	kvfree(info);
>  	free_shrinker_info(memcg);
>  	return -ENOMEM;
>  }

NAK. If in the future there going to one more error case after
rcu_assign_pointer() we will end up with double free.

This should be safer:

diff --git a/mm/shrinker.c b/mm/shrinker.c
index dc5d2a6fcfc4..763fd556bc7d 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 		if (!info)
 			goto err;
 		info->map_nr_max = shrinker_nr_max;
-		if (shrinker_unit_alloc(info, NULL, nid))
+		if (shrinker_unit_alloc(info, NULL, nid)) {
+			kvfree(info);
 			goto err;
+		}
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	mutex_unlock(&shrinker_mutex);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

