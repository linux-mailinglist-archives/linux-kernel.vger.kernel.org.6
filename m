Return-Path: <linux-kernel+bounces-338319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C3985664
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79341281BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1415C15A;
	Wed, 25 Sep 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3WHxoMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362315C122
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256720; cv=none; b=GLTMbhJ3XX6+Ya0n4STkQMkHhnKOULWRK0KA/aKNPmxrUTwwCwIQm4eMgngV9ehMSr2lNSxNUIdZ4SJmLroiR03vjC3Exm0rCkrpg9jJLyi1UAg5+4CRezF7uwc7gF5AKovXBupnwYrFD/x/oJcQ9G/oWD7Yev+ggOQ15ZAYBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256720; c=relaxed/simple;
	bh=X7wHJJlQGTqEuthpuVb29KmqlKJoK5uc7L0Yi8DfPB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWnwhXwtYlNLy8WxK5EJ1X3BVk7d5qYur+9j4Jzz8g4160wZwdgAnq3kcJ2cM2Ip61ta1RTPrnGcoS2XjUbguuRqC8XpB80LIwsEDReH22Hd/fm3vYKynwMoeOZpg1rPpPTIQQ+IyZYjtrpW1OJeHymgilGBJiqHTyO3Tf0Mzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3WHxoMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D49C4CEC3;
	Wed, 25 Sep 2024 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727256720;
	bh=X7wHJJlQGTqEuthpuVb29KmqlKJoK5uc7L0Yi8DfPB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3WHxoMFGNVzLEjZIvwIK0aD/Bn3yY99UjH3Kphkn/YZ8dnqP9FKuu/JG9OMycPkl
	 ui9ItvwXXDevvxCpuKa0bEI700Qf0wzBdt2UwUWDrhjhtwcDTENHtlHvpoUcXU16nx
	 8cTHjIAImIiTh0Yj3ZJU7gJdcLJkM+mQAwpsbeGEeHNm1K7vsXTKp3JYviYP+htq4S
	 88XDRZkgd2kGz7FmEDxpbZS5i8mR/yk2SY4Ebigy3geHY3Gw2SrZXtbbi5fwn6J6k9
	 vzovHbca+EtAbnqQVtjW6j9Gf87D5Hdd7NmZAVIua9fN/y6J7CMlZ1NfZ2Prkworxn
	 tXxb0CW6ZWkVw==
Date: Wed, 25 Sep 2024 12:28:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Bruno Faccini <bfaccini@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/fake-numa: per-phys node fake size
Message-ID: <ZvPX2J7D9w0EJTUo@kernel.org>
References: <20240921081348.10016-1-bfaccini@nvidia.com>
 <ZvKXFnriMlH2y5Oo@kernel.org>
 <A846613E-A2B4-4B56-B368-5786F572F168@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A846613E-A2B4-4B56-B368-5786F572F168@nvidia.com>

Hi Bruno,

Please reply inline to the mails on Linux kernel mailing lists.

On Tue, Sep 24, 2024 at 03:27:52PM +0000, Bruno Faccini wrote:
> On 24/09/2024 12:43, "Mike Rapoport" <rppt@kernel.org> wrote:

> > On Sat, Sep 21, 2024 at 01:13:49AM -0700, Bruno Faccini wrote:
> > > Determine fake numa node size on a per-phys node basis to
> > > handle cases where there are big differences of reserved
> > > memory size inside physical nodes, this will allow to get
> > > the expected number of nodes evenly interleaved.
> > >
> > > Consider a system with 2 physical Numa nodes where almost
> > > all reserved memory sits into a single node, computing the
> > > fake-numa nodes (fake=N) size as the ratio of all
> > > available/non-reserved memory can cause the inability to
> > > create N/2 fake-numa nodes in the physical node.
> > 
> > 
> > I'm not sure I understand the problem you are trying to solve.
> > Can you provide more specific example?
>
> I will try to be more precise about the situation I have encountered with
> your original set of patches and how I thought it could be solved.
> 
> On a system with 2 physical Numa nodes each with 480GB local memory,
> where the biggest part of reserved memory (~ 309MB) is from node 0 with a
> small part (~ 51MB) from node 1, leading to the fake node size of ~<120GB
> being determined.
>
> But when allocating fake nodes from physical nodes, with let say fake=8
> boot parameter being used, we ended with less (7) than expected, because
> there was not enough room to allocate 8/2 fake nodes in physical node 0,
> due to too big size evaluation.

The ability to split a physical node to emulated nodes depends not only on
the node sizes and hole sizes, but also where the holes are located inside
the nodes and it's quite possible that for some memory layouts
split_nodes_interleave() will fail to create the requested number of the
emulated nodes.

> I don't think that fake=N allocation method is intended to get fake nodes
> with equal size, but to get this exact number of nodes.  This is why I
> think we should use a per-phys node size for the fake nodes it will host.

IMO your change adds to much complexity for a feature that by definition
should be used only for debugging.

Also, there is a variation numa=fake=<N>U of numa=fake parameter that
divides each node into N emulated nodes.
 
> Hope this clarifies the reason and intent for my patch, have a good day,
> Bruno 
> 
> 
> > Signed-off-by: Bruno Faccini <bfaccini@nvidia.com>
> > ---
> > mm/numa_emulation.c | 66 ++++++++++++++++++++++++++-------------------
> > 1 file changed, 39 insertions(+), 27 deletions(-)

-- 
Sincerely yours,
Mike.

