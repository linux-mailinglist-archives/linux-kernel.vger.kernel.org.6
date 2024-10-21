Return-Path: <linux-kernel+bounces-373935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373A9A5F82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2FD281CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D91E25E2;
	Mon, 21 Oct 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="DHj68RMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofKdN0yS"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A7200CD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500877; cv=none; b=goe+s3TZpr5JXOb6bD+LYpxz/QKnN0g6+PWKA378stzwvt+2xRRVzD7gaeu4JzPB1lNjWV1dsICAsiV2gaG6+sOqZVxh1isF/YUivcZHexZwYk+ViVpN8AL03L/Lp0yjbp8AsjpTJGIikxXtIeStnZ4Pn/dF1zEZ5TlTstVyAkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500877; c=relaxed/simple;
	bh=BKf6w51qkrVlvmldYSdANlkWkwb4c6SIDJeBLnZy0Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyxavDMBPQIcXbCgz9u3rBPJhcBf1YWrW39sCs55oq4pv+PTQMSTHmAwehx3rziC+Wyl241utJbZyZeZI41qUN2/cpBaw6vDd0wcf7gKbRB2tpOAhG+uiVFzZpGn5k9Wp1XJTyZch7MGY/tlg9lajOVNygSVecuWUC84F3NPRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=DHj68RMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofKdN0yS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FA6A1380554;
	Mon, 21 Oct 2024 04:54:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Oct 2024 04:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1729500874; x=1729587274; bh=2nFOUP3L/JFeGH6ny3i7Lq6eOxO/RiE0
	p8DPNMqCbBU=; b=DHj68RMig054JMkDk1FB4rjGTzLx/xc4CiJtmC8m4HRkV9Vy
	jD7yfD6r4LnumAIvRk1Z4IKEZk3EIGHqSzRn1oeS027me0BtT0/kaJX0uIaeCeg9
	gzU3SZewfDhUnesHIR3Ew26WMGxmullyMrmpzrO7p5/TxwEvpUbCX+/WtvdTXz7I
	kJI8FQR0Xofykq+Ls8oEP9qOAYCq6jB0UaKy74wTO5izYigAo3RYHLcfNP5FYurP
	3ASFapXLgc9ihBtfFe20ZQ1ixVJKinKZGueYMmFdHvL39ECCj9UJOaFzRHXm9DA9
	1QqGo6BPQOmBfBkhZECsBJxqRjTZeRcPUadcTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729500874; x=
	1729587274; bh=2nFOUP3L/JFeGH6ny3i7Lq6eOxO/RiE0p8DPNMqCbBU=; b=o
	fKdN0ySqaDL+Ot+gs682rq1QvoaJ4OwPAR45qjVuUzNymqgfXS6FTRoGiEzy2G+F
	6muDvnpdU3Y9PLp05B7XwEFfZNom0+NEukc3AVx1x4g7QifgpoGFgeEp898mqWti
	EnevqVeaKxz0JvLuKABPAStu/oO9EQ3YlPzIq7UpyEQ57OVjD7DsRfR1A0fs4yon
	syURcGOYoFF+hcGFSfUnQChxuhnyBlFroSim5TnqHFKwPRsHtzGifcJHmO1BOgsc
	qEQ5kziRd58cDvlKk1MWzx2paEaR+a2IPGh/+aPU9cFS+CgIa5itVWEbOHXgVVxj
	c6rE2Mzk5tWWt15kWFWRA==
X-ME-Sender: <xms:yBYWZx7ykjQF99aOKN0Ap1cHXW5n91u9rdXQMDjf7KO-PHkbyFYSug>
    <xme:yBYWZ-4mtueAT6zIYAvyP142ylgGfaiFwhRPgHr8IMNk1wnMJPvVzC3i26eOmo38W
    sEsSt4rJGe6-xzbwZY>
X-ME-Received: <xmr:yBYWZ4e_UI75mBkiOy8bjx6J-R0va2IePBuR-eQaFXjJw9FOADkIRyVohWKVoLPg-d-Qew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdej
    necuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepudeffeetffegteef
    jeetvdekgeelveeiheeiffeltddtgeeuffevvdehveevheffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdp
    rhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprg
    hkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehhuhhg
    hhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopeifrghnghhkvghfvghnghdrfigrnhhgsehhuhgrfigvihdrtgho
    mhdprhgtphhtthhopedvudgtnhgsrghosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprh
    ihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtohepihhofihorhhkvghr
    tdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:yBYWZ6JCzAsB2wqT9sgrHE8LmIljLMdPnpxXE3TAnkJQXHOSeqAbhA>
    <xmx:yBYWZ1Kvca_akn5pdngpOewxZIaI1Tt5k5zABJTKoHIikSiXZaWNkg>
    <xmx:yBYWZzzuaRM8BPKJdEz0g6GvNlltGEC0FF1BUKLn56yA0Aflv0OYKQ>
    <xmx:yBYWZxLpEYrZNXTu8TMiGSXlGbaNVRyA_HTQdSvBkm19oOc73vCX9g>
    <xmx:yhYWZ8b-q-_lZbDlj28nhJt138quBjktxFQjJEahFdKqlwZo8-s-__2L>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 04:54:28 -0400 (EDT)
Date: Mon, 21 Oct 2024 11:54:23 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	hughd@google.com, david@redhat.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com, 
	ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
Message-ID: <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>

On Mon, Oct 21, 2024 at 02:24:18PM +0800, Baolin Wang wrote:
> 
> 
> On 2024/10/17 19:26, Kirill A. Shutemov wrote:
> > On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
> > > + Kirill
> > > 
> > > On 2024/10/16 22:06, Matthew Wilcox wrote:
> > > > On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
> > > > > Considering that tmpfs already has the 'huge=' option to control the THP
> > > > > allocation, it is necessary to maintain compatibility with the 'huge='
> > > > > option, as well as considering the 'deny' and 'force' option controlled
> > > > > by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
> > > > 
> > > > No, it's not.  No other filesystem honours these settings.  tmpfs would
> > > > not have had these settings if it were written today.  It should simply
> > > > ignore them, the way that NFS ignores the "intr" mount option now that
> > > > we have a better solution to the original problem.
> > > > 
> > > > To reiterate my position:
> > > > 
> > > >    - When using tmpfs as a filesystem, it should behave like other
> > > >      filesystems.
> > > >    - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED, it should
> > > >      behave like anonymous memory.
> > > 
> > > I do agree with your point to some extent, but the ‘huge=’ option has
> > > existed for nearly 8 years, and the huge orders based on write size may not
> > > achieve the performance of PMD-sized THP in some scenarios, such as when the
> > > write length is consistently 4K. So, I am still concerned that ignoring the
> > > 'huge' option could lead to compatibility issues.
> > 
> > Yeah, I don't think we are there yet to ignore the mount option.
> 
> OK.
> 
> > Maybe we need to get a new generic interface to request the semantics
> > tmpfs has with huge= on per-inode level on any fs. Like a set of FADV_*
> > handles to make kernel allocate PMD-size folio on any allocation or on
> > allocations within i_size. I think this behaviour is useful beyond tmpfs.
> > 
> > Then huge= implementation for tmpfs can be re-defined to set these
> > per-inode FADV_ flags by default. This way we can keep tmpfs compatible
> > with current deployments and less special comparing to rest of
> > filesystems on kernel side.
> 
> I did a quick search, and I didn't find any other fs that require PMD-sized
> huge pages, so I am not sure if FADV_* is useful for filesystems other than
> tmpfs. Please correct me if I missed something.

What do you mean by "require"? THPs are always opportunistic.

IIUC, we don't have a way to hint kernel to use huge pages for a file on
read from backing storage. Readahead is not always the right way.

> > If huge= is not set, tmpfs would behave the same way as the rest of
> > filesystems.
> 
> So if 'huge=' is not set, tmpfs write()/fallocate() can still allocate large
> folios based on the write size? If yes, that means it will change the
> default huge behavior for tmpfs. Because previously having 'huge=' is not
> set means the huge option is 'SHMEM_HUGE_NEVER', which is similar to what I
> mentioned:
> "Another possible choice is to make the huge pages allocation based on write
> size as the *default* behavior for tmpfs, ..."

I am more worried about breaking existing users of huge pages. So changing
behaviour of users who don't specify huge is okay to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

