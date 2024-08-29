Return-Path: <linux-kernel+bounces-307780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD39652E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C553E1C20F89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FCA1BA88A;
	Thu, 29 Aug 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRnLKAC4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397C1B5EDB;
	Thu, 29 Aug 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970552; cv=none; b=AwRmxhtDLCy4DuZZVqpx5HkqQZwxCaYOs41INhUeoyW/6MD5laBwBTqozYcsttmyw0sfCJwmEugDafMUaQXKurQ7T9D6qInasPSjLOnV7bxw98raWv+7BqwknqvZ8WREsasmowTluzzOGKbng4PbAbzPWedo+sBKKtWxLoJ7FDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970552; c=relaxed/simple;
	bh=Tw5rg3SsYeGdNH8H/SojvzU2mY4Enp6rJZHNecxbN/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQBcTe6NQRCqPo9GHxL1b0cbop44YKZnz5SrSD+1fk7Zrg2OEtA4VUEL1CANpG297e1bTa8H/wBRRVB3rzM9Ji9L2GxwJsCNzY1ZvjgshLlJdRQ3QoD62NEKTTefAKNSV6FqvDG14DEI3VIh97jvX/WkhTQi96V2Q+JF0fTeG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iRnLKAC4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lb1pyj5zxbGFHDqjyX82l5HJgvNKijLaWdmPvU8hETY=; b=iRnLKAC4B8wm5XBnfdv0OVgM/d
	cEEof1zWyfZzKsn0z3w44QW/32Zhgbp812aBTx+jhTo+SftWEQApD0+ZV+zNUGEWAShj/Vw2N8APd
	BiwXdVrkHv1Qp8VeZ0AkV+9CB6Q2ARQARu80xwEvI6Bc+QqUo9kej01g5gZEcEdB6OlMafb9uy2r9
	m+bB++s/vJjuRvxLRhC/NhftzSfzj4lu6tJfEQRVAZhpHm85EhddPn4mJAk4s9E8IpqkpiyL6lEkj
	/qzv/vZTrSa37pIunplwVC0J1ymXvsPyufqiCrCu0UZGrHONGNZBBtOBhmLEZYRKL2tlsihuSU3TR
	c+J0Mcbg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sjndZ-00000002aLf-1Xma;
	Thu, 29 Aug 2024 22:29:05 +0000
Date: Thu, 29 Aug 2024 23:29:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
Message-ID: <ZtD2McWko3uobU-B@casper.infradead.org>
References: <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com>
 <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com>
 <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
 <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com>
 <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>

On Thu, Aug 29, 2024 at 02:54:25PM -0700, Yosry Ahmed wrote:
> Looking at the zswap commits between 6.8 and 6.9, ignoring cleanups
> and seemingly irrelevant patches (e.g. swapoff fixups), I think the
> some likely candidates could be the following, but this is not really
> based on any scientific methodology:
> 
> 44c7c734a5132 mm/zswap: split zswap rb-tree
> c2e2ba770200b mm/zswap: only support zswap_exclusive_loads_enabled
> a230c20e63efe mm/zswap: zswap entry doesn't need refcount anymore
> 8409a385a6b41 mm/zswap: improve with alloc_workqueue() call
> 0827a1fb143fa mm/zswap: invalidate zswap entry when swap entry free
> 
> I also noticed that you are using z3fold as the zpool. Is the problem
> reproducible with zsmalloc? I wouldn't be surprised if there's a
> z3fold bug somewhere.

You're assuming that it's a zswap/zsmalloc/... bug.  If it's a random
scribble, as suggested by Takero Funaki:

https://lore.kernel.org/linux-mm/CAPpoddere2g=kkMzrxuJ1KCG=0Hg1-1v=ppg4dON9wK=pKq2uQ@mail.gmail.com/

then focusing on zswap will not be fruitful.

