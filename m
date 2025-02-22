Return-Path: <linux-kernel+bounces-526851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9BBA40461
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD8270360E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACD138389;
	Sat, 22 Feb 2025 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EKpE9QCu"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37C4A01
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185342; cv=none; b=bqac0Cg/auQywjSE/CJusC1bQxuxB82AySLTdvICx6mbPuF9vfZPEHbOOiFY1bam/h0anNdJKJG58uHbT5RZqsTijM4uq8D72z0OmRP2+3Y4eDIqfHKBiSqfS6SqlXGw96gXQncDpOFf0Oy7bedW0fcJERvL6Rb4QeAPmno9deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185342; c=relaxed/simple;
	bh=0MWV2m0La6Zk3eE/f8ukJR9um6xaHgGpoIBCI9DjuTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huoAB/HgC4Mrr92Cn0yiIa6LTmEXofxdAVxUJkT99rgomN+3R/XfYI6kXK3GNYkzVnLwq4M9m4arkwPFifKLsBbYPq/OdhDNLAdysoCEhPs4X/TnHgifNnx7Z7nGyZiWlgYj2O40qPEKON244mrJAbFThZdXT6pgXDLdlVWBnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EKpE9QCu; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 00:48:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740185337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4Zst46Y7pj1nzoh7gV1XNEH5xnb01/ZQglbBvg9mw0=;
	b=EKpE9QCuth3FK6o61yyUqeyKAPhA00/7ADQUR9v8193RzSpKlzdjxgWPUfacvo7zElF8oM
	nvUPPeCgOoacI43Lg9vpl+g0kSx8+zijAmxLgqDfsctdKKhS3z8oA5xcDKTiJfvJ4uTXQt
	kYpMMq4H4+5bItmteexJDETFIJnrOS0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Ira Weiny <ira.weiny@intel.com>
Cc: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
Message-ID: <Z7ke871WFkYuwYl1@google.com>
References: <20240318204212.36505-1-21cnbao@gmail.com>
 <0000000000009221d60613f58726@google.com>
 <CAGsJ_4xdKbH8v0WaBFo_kDOHPXQnX7zrc43D=+irfzM-=2RxGw@mail.gmail.com>
 <CAJD7tkYA0ZjdjXAx3ZcFtFzAAbZ2+57QLh99o3JVBVSWNtZM7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYA0ZjdjXAx3ZcFtFzAAbZ2+57QLh99o3JVBVSWNtZM7A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 12, 2025 at 09:20:24AM -0800, Yosry Ahmed wrote:
> On Mon, Mar 18, 2024 at 2:03 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Tue, Mar 19, 2024 at 9:52 AM syzbot
> > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > WARNING in __kmap_to_page
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 3529 at mm/highmem.c:167 __kmap_to_page+0x100/0x194 mm/highmem.c:167
> > > Modules linked in:
> >
> > + Ira
> >
> > Hi Ira,
> >
> > I noticed this warning is coming from commit ef6e06b2ef87077.
> >
> > you have a commit message like
> > "    Because it is intended to remove kmap_to_page() add a warn on once to
> >     the kmap checks to flag potential issues early.
> > "
> >
> > Do we have a replacement for kmap_to_page()? The background is that we
> > want to pass a highmem buffer to sg_set_page() but we only know its virt
> > address.
> 
> I am reviving this thread because new zsmalloc changes will make
> mappings sleepable, which will allow zswap to drop the memcpy() in
> zswap_decompress() -- except for the !virt_addr_valid() case. We can
> get rid of that too if we can use kmap_tp_page() in the scatterlist
> code.
> 
> Ira, could you please answer Barry's question above about
> kmap_to_page()? It has been a year and kmap_to_page() is still around.

(Trying again with Ira as the main recepient just in case)

Ira, could you please help us out here? :)

> 
> Thanks.

