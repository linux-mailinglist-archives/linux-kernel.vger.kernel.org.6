Return-Path: <linux-kernel+bounces-534446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A8A466E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF5F3AC0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A3222577;
	Wed, 26 Feb 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eJfriWQZ"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D72222DA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588337; cv=none; b=KXVPwhEbRx9BfFW66uQCk7ExRl59wz/mKNYxscVRojWePe5G6M1ESVG1b1Dj/Dicrs3O5j9N0fInUx0yBo7bSBfGkrqVywK1BLP3k/YpeAr+vbrg+LCc2W68Af84bgvyMpnAYf2b6HXgSRLEYxXoAceGfbKuaxNw5TQzzXp8LvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588337; c=relaxed/simple;
	bh=2/+05jNcv76conrOixRNbdzI4AA76ECx6T1ZK+IlIZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxa1B1BG/Vrz9FSy4OKDATJfp4XBHu4D8NNJPYsGQPTe1bgcjrbceybiG8aa2QtJWi5nsLLX1dr6+KJRnppV74p/XJkXoxZXzUeVEV/Kq2FloVAxtNhLVw5iUQP7fjHN8vGgcz4WjLuNMqqiTWIdSzKLX31qw70JpKa8jUfMVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eJfriWQZ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 16:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740588332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ltc6Nrepc04jaCjrI+QJSTPw7Gz4OtZN8fv65LynWE=;
	b=eJfriWQZf4Tt/jOznTwKWWClO5fXKDgVtMW2VCBjL8QeyXfFyVPKNeSZtu18grXZGhPqha
	+3FWLN0NkTDQ3p8bJb5sVm+wvsDyOiNBTuHs6HK9cjYJRtJ++veq8Q/3N662VT95zC807K
	HIKj+HZeA/olEAX2Ru0ext5IFRSO5AQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Ira Weiny <ira.weiny@intel.com>
Cc: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
Message-ID: <Z79FJ5t5Ed60w--U@google.com>
References: <20240318204212.36505-1-21cnbao@gmail.com>
 <0000000000009221d60613f58726@google.com>
 <CAGsJ_4xdKbH8v0WaBFo_kDOHPXQnX7zrc43D=+irfzM-=2RxGw@mail.gmail.com>
 <CAJD7tkYA0ZjdjXAx3ZcFtFzAAbZ2+57QLh99o3JVBVSWNtZM7A@mail.gmail.com>
 <Z7ke871WFkYuwYl1@google.com>
 <67bf3ad9ac2df_41ae42942@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67bf3ad9ac2df_41ae42942@iweiny-mobl.notmuch>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 10:01:29AM -0600, Ira Weiny wrote:
> Yosry Ahmed wrote:
> > On Wed, Feb 12, 2025 at 09:20:24AM -0800, Yosry Ahmed wrote:
> > > On Mon, Mar 18, 2024 at 2:03 PM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 19, 2024 at 9:52 AM syzbot
> > > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > WARNING in __kmap_to_page
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > WARNING: CPU: 0 PID: 3529 at mm/highmem.c:167 __kmap_to_page+0x100/0x194 mm/highmem.c:167
> > > > > Modules linked in:
> > > >
> > > > + Ira
> > > >
> > > > Hi Ira,
> > > >
> > > > I noticed this warning is coming from commit ef6e06b2ef87077.
> > > >
> > > > you have a commit message like
> > > > "    Because it is intended to remove kmap_to_page() add a warn on once to
> > > >     the kmap checks to flag potential issues early.
> > > > "
> > > >
> > > > Do we have a replacement for kmap_to_page()? The background is that we
> > > > want to pass a highmem buffer to sg_set_page() but we only know its virt
> > > > address.
> > > 
> > > I am reviving this thread because new zsmalloc changes will make
> > > mappings sleepable, which will allow zswap to drop the memcpy() in
> > > zswap_decompress() -- except for the !virt_addr_valid() case. We can
> > > get rid of that too if we can use kmap_tp_page() in the scatterlist
> > > code.
> > > 
> > > Ira, could you please answer Barry's question above about
> > > kmap_to_page()? It has been a year and kmap_to_page() is still around.
> > 
> > (Trying again with Ira as the main recepient just in case)
> > 
> > Ira, could you please help us out here? :)
> 
> Apologies,
> 
> No there is no alternative to kmap_to_page().  The work I was doing has
> stalled out and I really don't know if it will resume.
> 
> There are a few folks, like me, who would like to remove highmem but every
> time the subject comes up someone speaks up about a rare (mostly embedded)
> platform which really needs it.  So I don't see it going away soon.
> 
> Removing the warning could be justified by saying that highmem removal can
> be done completely within the kmap calls and only when that has been
> completed can these calls go away.  But generally kmap_to_page() is not a
> popular call and it might be seen as a step backwards by some.
> 
> For example:
> 	https://lore.kernel.org/linux-mm/20221216070621.GA24832@lst.de/
> 
> The patch with the warnings was a stop gap to ensure current users did not
> break.
> 
> Do you have evidence that the extra memcpy is bad enough performance that
> you could justify using kmap_to_page?

It's not about performance, it's about cleaning up the code. Currently
we have a special memcpy path [1] with a huge comment in
zswap_decompress() to handle zsmalloc not being sleepable and the kmap
case. The zsmalloc case is going away soon, and we'd like to remove the
special handling completely.

Using kmap_to_page() will allow us to do so. As you mentioned, this
would not be blocking to removing highmem. The call can just be replaced
with virt_to_page() once this is done.

If this is okay with you I can send a patch removing the warnings in
__kmap_to_page() when I start using the function.

[1]https://elixir.bootlin.com/linux/v6.13.4/source/mm/zswap.c#L1012
 
> Ira
> 
> > 
> > > 
> > > Thanks.
> > 
> 
> 

