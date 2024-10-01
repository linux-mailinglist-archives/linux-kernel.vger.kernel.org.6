Return-Path: <linux-kernel+bounces-345370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E816098B552
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1400A1C22E24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B6F1BCA00;
	Tue,  1 Oct 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z39LzbLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685803307B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767137; cv=none; b=Qz7BnHF5m9kimJsVacR2fWSf317GWNDbGzh1yPS53boHglOBFF9W7OH+p0TAXMToC00PTE7QFWnmBSz6la/Urg99RVLfbBWdY9Vpr/7hQ10DlNi+X6NZe2FOEGqDydwQ+yfSq6hIOclVrBD492c8BgX02ljK2hnuT1l0+xejZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767137; c=relaxed/simple;
	bh=hHvw4rvvTLAn5PFdhwtgWaWgXl+dEkiAGCiJw1l2A54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLGrOC24dY3Mjt2WX40SnP03L0VI6w+KA86lr6+JeIUX4z1+/3G+W+ZstqUeQ8X9xZc6SPaSNEhVMb8bc/D8HbRiGuLi8ZqJL4SSdELs+k2lh4k/CWG1F0abSEg5YUI5nboh11OcyvqMs/GZuMPDki+TnLCax5jtVAhGiog4OJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z39LzbLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A60C4CEC7;
	Tue,  1 Oct 2024 07:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727767137;
	bh=hHvw4rvvTLAn5PFdhwtgWaWgXl+dEkiAGCiJw1l2A54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z39LzbLVpvagQs41yjEgupVeHDouFrPnwhL8DPPxVKC03DBey9StqC/oalSRWHhJ6
	 FqyVhsGTg9+3+yDh5wahTYIobStsAYg5xTSssQ3CZwb+xrLoO9ouE56GWYwx7Cz5Pi
	 5ezsgsjjYpDfjtLJSy1zZzmhpUUQkt8AXAMQfR3yKzWnhBvX8bRSaGKYSWpsvP4gop
	 obhJaegucY8/ZSHebwKzSVbkLZxzBdBCdNhz+NZ1N2zruB/TUQj/esF6MjsLA20J14
	 imTK2ZMQ6V1JhYsMdKtpqn6NGInqiOxy/5QwBdtAAqdEdI1n+A5IQnXH/dyKKy77ni
	 pCe0POsfkPvCg==
Date: Tue, 1 Oct 2024 10:15:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Bruno Faccini <bfaccini@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/fake-numa: per-phys node fake size
Message-ID: <Zvuhmv7exzL8sMoW@kernel.org>
References: <20240921081348.10016-1-bfaccini@nvidia.com>
 <ZvKXFnriMlH2y5Oo@kernel.org>
 <A846613E-A2B4-4B56-B368-5786F572F168@nvidia.com>
 <ZvPX2J7D9w0EJTUo@kernel.org>
 <9759DD75-5DA6-4C3A-8300-CD8EA8353BAF@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9759DD75-5DA6-4C3A-8300-CD8EA8353BAF@nvidia.com>

On Sun, Sep 29, 2024 at 03:43:50PM +0000, Bruno Faccini wrote:
> 
> On 25/09/2024 11:32, "Mike Rapoport" <rppt@kernel.org <mailto:rppt@kernel.org>> wrote:
> > On Tue, Sep 24, 2024 at 03:27:52PM +0000, Bruno Faccini wrote:
> > > On 24/09/2024 12:43, "Mike Rapoport" <rppt@kernel.org <mailto:rppt@kernel.org>> wrote:
> >
> > > I don't think that fake=N allocation method is intended to get fake nodes
> > > with equal size, but to get this exact number of nodes. This is why I
> > > think we should use a per-phys node size for the fake nodes it will host.
> >
> > IMO your change adds to much complexity for a feature that by definition
> > should be used only for debugging.
> 
> Well it is only executed once during boot, and as you said for debugging,
> so I believe when the boot speed is not a requirement.  And my testing on
> our fat Numa nodes did not show a real difference.

I meant code complexity, not the execution complexity.
 
> > Also, there is a variation numa=fake=<N>U of numa=fake parameter that
> > divides each node into N emulated nodes.
> 
> Right, but both methods should work as expected, is'nt it ?
> And one allocates emulated nodes interleaved on physical nodes when the
> second is doing allocation serially.

I think we can just bail out with an error if we fail to create the
requested emulated nodes.

-- 
Sincerely yours,
Mike.

