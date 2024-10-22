Return-Path: <linux-kernel+bounces-376071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96D79A9F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E942D1C23F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB2198E91;
	Tue, 22 Oct 2024 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="kBiS6gJM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aENQevxc"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABED145B24
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591596; cv=none; b=u/BGjqAp7pZBba5PK2IIxQjeYe7iwxIP/UZ/c2vUj/6hvo9Liy7N9/sGqXjgrHoQ0/X51/KmfvmGIChlSJX4cZ4gWmGRCWFKBh/jRvXmSQaA6cOSlB4wkdPS2zAhtGBk4Eq2zvZxviJYb5N+V0ssDUW0+FEYgLU5rTNOSYah1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591596; c=relaxed/simple;
	bh=HTDy0LNESDiKQUdE7xjEV63uP8unleccTkzReT0fYXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do0TgRgT6rMZotkBScollE2AeXSv+3s70N/1gWwbvWL4bzYwy2BbYLKLh/3awwb0qKRq6JZb+8GPrHkedSIYY/K5ojfnlNe/S+M7QKkGrxy3MIQBPO2ABaz4WZ37RyUFlIW5pDtxXGrCKB0niO6hMw42EXBLrtRuJvrLKSboqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=kBiS6gJM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aENQevxc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7ED425400F6;
	Tue, 22 Oct 2024 06:06:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 22 Oct 2024 06:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729591592; x=
	1729677992; bh=5QWoIbdMUqDbjfUSfA9GFg2c/tcYnvOouZVnzt0I38I=; b=k
	BiS6gJMzvS4e8Y6Dwjs/IAMkDNFJQXUxUITG/1C6JibfcmLIecws4cjc9jaK9frr
	6OwJODHCIZFWM8ggPmDHbYj2hTus13Zhn0j2ayURLRd5CXVJSmPxk1HU9TmSXV0n
	s9kt+2FI7dMuv9MTRV4W8Nh4HNLUr9EiEZe+vulfCnloKcwCTIJzC6PivT6N4HMy
	rieg/Iy87NYnt+vv6ao0ARdzFQbhlFXC/SPv3j8pgKhmEUQo4IVlnS8nvTMDy4Ws
	M2QWxIPQw4TDMS4P2UpOw1pxzwWo2SZDfw2LplPkDQDj+ss7R1rHsQRdnGVyvX06
	ncREE3Pz0JLs190vvUWEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729591592; x=1729677992; bh=5QWoIbdMUqDbjfUSfA9GFg2c/tcY
	nvOouZVnzt0I38I=; b=aENQevxca3/ONAanmj3EZj2shX2gKjZJx4EEiXMaOFtL
	d+9IjUi+qyggpNm9TldOBIysVqWxEvF93X94+/1Zc9MwwjGt5EuL+pLi9xPc/8Kb
	Si6Zqc91J41FQaNpTb6EqBqzhACre1sfo2qwt08uq/tVLTEii6jQxBroXIHyA6Eh
	2m0WSx0p9GVp588ctFcE47tenDqKFdRVbG48FUKx6a21DuC2cp9T5oJZFFXZ+FBu
	fy01MHbb3Pej2v0nUdOCtCY53XTycqqM2xiee2qeJXtadBCOga/Dkglq6T5VJkfM
	o3yTYBlM+yb5eWeTFOreYXpZNcV386Z5RLTjYi/sUw==
X-ME-Sender: <xms:J3kXZ_SpByc3Bcn0XhRbnixpJvADLmHACaym-pVxlDC2niEid-Apqg>
    <xme:J3kXZwyx2g0Cu005b9Wu5gJ6QXtLTfxOf1WCQ48lIMPedLVasrY5KlCH5Pgh7RzXe
    Xr17oBEDRDZtIpU7-Q>
X-ME-Received: <xmr:J3kXZ02Cnvcs4wxLmcsJRRFFPfAQr3J6cF9WZwQxIv2OuPs7GrutECWFvLVX3Yd3GoYYzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegsrgholhhinhdrfigrnhhgsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhr
    tghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrkh
    hpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhhughhh
    ugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepfigrnhhgkhgvfhgvnhhgrdifrghngheshhhurgifvghirdgtohhm
    pdhrtghpthhtohepvddutghnsggrohesghhmrghilhdrtghomhdprhgtphhtthhopehrhi
    grnhdrrhhosggvrhhtshesrghrmhdrtghomhdprhgtphhtthhopehiohifohhrkhgvrhdt
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:J3kXZ_AUbgEU1KZlwMk-CAuN7PSHwhlKrqdhYzyKVGCqJQROdho0qw>
    <xmx:J3kXZ4hOMizXPv-5wpSZ1oqSXrIbj72rTfwEIfVpUTnoRA6EDG1-hg>
    <xmx:J3kXZzo8QNrzOp5KdfKyM5Lt7aUzvBYs6S8rKQQnqld6nF2Kv_yw3g>
    <xmx:J3kXZzhSi-chehrtmWGpQs2vMw4Z3R1Ei8EIkUKMuFnS0uIKvx3S4w>
    <xmx:KHkXZ3SPAg0AgtwR2iaWpF_LVPag-FFa0QpcKEKw4IFiWp37zxhiV6t1>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 06:06:27 -0400 (EDT)
Date: Tue, 22 Oct 2024 13:06:22 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	hughd@google.com, david@redhat.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com, 
	ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
Message-ID: <5p22lehyjjzxvohppdmt2vkkplrrd6ss6tev2px6troxyii4ab@eaphjvxiwrfc>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <2c6b7456-8846-44b0-8e58-158c480aaead@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6b7456-8846-44b0-8e58-158c480aaead@linux.alibaba.com>

On Tue, Oct 22, 2024 at 11:34:14AM +0800, Baolin Wang wrote:
> IIUC, most file systems use method similar to iomap buffered IO (see
> iomap_get_folio()) to allocate huge pages. What I mean is that, it would be
> better to have a real use case to add a hint for allocating THP (other than
> tmpfs).

I would be nice to hear from folks who works with production what the
actual needs are.

But I find asymmetry between MADV_ hints and FADV_ hints wrt huge pages
not justified. I think it would be easy to find use-cases for
FADV_HUGEPAGE/FADV_NOHUGEPAGE.

Furthermore I think it would be useful to have some kind of mechanism to
make these hints persistent: any open of a file would have these hints set
by default based on inode metadata on backing storage. Although, I am not
sure what the right way to archive that. xattrs?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

