Return-Path: <linux-kernel+bounces-381333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C29AFDB9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A721C22BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAFC1D31A9;
	Fri, 25 Oct 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="TywMtwh5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUZ7jcUJ"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB11D221C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847568; cv=none; b=OmYZxIk5O0AcVDdmc1crjIhn72Mp08W0U9pW5IaJq2aCmeDYz+VoZRqvHdUZ+fU3BVqq7FjrhxsyvZfmnQWmTXuM17oBxCDJmONxLkkAESNyBKHKAGzcA3NjOvZQIQV2r/c9ztavFnfAaEbSsaIV5ahQI7eARd4Rgr0EWAn5LbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847568; c=relaxed/simple;
	bh=mtEHJyRB6xeh/c/dEIRzHBcfXjAZsF2QUuQLansLhAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faNbFwNzRYpvOjhzDW8iZlloKdR8EGppjJW2tFzdnDXGlOo3i7jscrCOlZIxd2iDJE5VKOD1cKz6U1NTbuuvZMtxJ0cQZ0SiRI2XF++4f77vBDWEPiCKash8wDHj37k3+bNcjbSRA0LpatIxSzrrPYCcWX8k70zPWVI+Eb8Mebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=TywMtwh5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUZ7jcUJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9781413801ED;
	Fri, 25 Oct 2024 05:12:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 25 Oct 2024 05:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729847564; x=
	1729933964; bh=w90BgXkrFsRin3ZA0UiaoPIiEDD9yrDl2zP9wy6weXY=; b=T
	ywMtwh5pNjPoXvkaWMViB0gurqQzbKQ1WduZfHd36oRSIfwSHF8u7gsG8hic2Dqe
	ffyRZMvsyghPb5CL6Bfq35flzxkmLK87v113FAoaOe2lPrqa4P60gq4njnwYfGx7
	QLyOtnOlCupjalbjJQpNnxjZA1yNS3W/drgiOGfRb3xefDnps5U9DmegGSk24a3E
	CJuBIp9vFav6UFwxqCJokRvOJ/A0zQJGv91WzTXAKyG5bOhq4brFQ8wCwtLwsAVd
	dyHppE1rQYv3M1X0XI0hSis5UFxgpL/oZjFmSDjFfOybgSHhhQsbVcGanXteTPZi
	Anwn1Q/7eemNnRo7chFow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729847564; x=1729933964; bh=w90BgXkrFsRin3ZA0UiaoPIiEDD9
	yrDl2zP9wy6weXY=; b=iUZ7jcUJnGnhD6ztMNffjtXlr5FNyl2M3x5QHOhQvTas
	GvB1E06inePh/QxpufqBZr8HkdSIIuMnAwJtrjsxpMitGFq7XPxgB8NPvkLcBxCk
	ugOzjvDzF/R+mDl+NRaocTCzlqFHut5VfPK6z1yySA6vg1LsWGFKD0IwHwn1HWTJ
	1kbCbVyDcaVUVPCpe9EPoZmBtCImVAk1pPabXaEapsKcksNs+o+Z6zxpveW6T9Le
	rDGlJcl5Fy3TARkccl04UXYUpPHe3QXO8EM8twRU+FHkYrND+fuHqWeLUtitPhds
	KuJDE2wxCrg6Sy7OmfZKgQUNVTrIY2yf+tMuWvaICg==
X-ME-Sender: <xms:CmEbZ6mvkDPXr_r2fsU-O3pLVjK4syV2QbMIPbObDX_fDx7eOnm1Ow>
    <xme:CmEbZx29Lriu_uFhHDcT_X-th1y54kGroshGZxhXczTkajRO_DNQToBXu7GXSXb7B
    _vVtnCrO8FN0W6EYBY>
X-ME-Received: <xmr:CmEbZ4rr6t0QQMOpqnvsYwwsDicbLjIlnhWnyhykU27x4_kIDoYzYdetX9PNAY42UjkFZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegthhgvnhhrihguohhngheshhhurgifvghitghlohhuugdrtghomhdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epuggrvhhiugesfhhrohhmohhrsghithdrtghomhdprhgtphhtthhopeiihhgvnhhgqhhi
    rdgrrhgthhessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehrohhmrghnrdhguh
    hshhgthhhinheslhhinhhugidruggvvhdprhgtphhtthhopehmuhgthhhunhdrshhonhhg
    sehlihhnuhigrdguvghvpdhrtghpthhtoheprghnshhhuhhmrghnrdhkhhgrnhguuhgrlh
    esrghrmhdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtiidprhgtphht
    thhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:C2EbZ-mxv6B4lFuCK4TKuy6uAdhDb2answ8NTr1x1XaIfmrvppo2Ww>
    <xmx:C2EbZ43ahfiEE7tT-4scyDaQrAfiQUurNJAGpHT7Vy2lAihKNHwocA>
    <xmx:C2EbZ1tYO1SjfHB2GsSdbtJovanf_Y4mMLbJXSLIq0B8YZI0lSXZIA>
    <xmx:C2EbZ0XyJ__PrZ0K2OpMoI5Lr6p9_ENbdsK1ixSdLzpKuZ_tzbOs5w>
    <xmx:DGEbZ-MN-WbhzDBtWAKkLFZ7wQ_5eNgyN9-OvEmK76FSS7YQlFUjdT-0>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 05:12:38 -0400 (EDT)
Date: Fri, 25 Oct 2024 12:12:34 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com, 
	zhengqi.arch@bytedance.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	anshuman.khandual@arm.com, vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] mm: shrinker: avoid memleak in alloc_shrinker_info
Message-ID: <nfxjrdg36rykyjeit7o7jdxaf7h2ta2wbixktf3g6a25vr3qyi@yfcjctjt67g3>
References: <20241025060942.1049263-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025060942.1049263-1-chenridong@huaweicloud.com>

On Fri, Oct 25, 2024 at 06:09:42AM +0000, Chen Ridong wrote:
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

This dump doesn't add much value to the commit message.

> In the alloc_shrinker_info function, when shrinker_unit_alloc return
> err, the info won't be freed. Just fix it.
> 
> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

