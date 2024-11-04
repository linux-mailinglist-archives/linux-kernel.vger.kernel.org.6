Return-Path: <linux-kernel+bounces-395120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A029BB8CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD917B233D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB521B6D14;
	Mon,  4 Nov 2024 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtgqT1uu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC033985
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733718; cv=none; b=pZiUzC2p+OigBm5PeLQPjVBm9uLcFqrM44zTBXyPC0CDUyp+2hQxQZIwuGXetyFLMC3JDQBtn2F1eTFS1GCuF/ls2qJQvIB+wl32ZQuvKER2BEa5OLfBjsWd3b0oHApGMabKTXNYyE8CF55kOH6gwb36mKq19Yu8WZFWrjqQ5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733718; c=relaxed/simple;
	bh=oBYUN9j1BO+q23M2y1oS+AkreaMduAa607+U0E1Z1hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAuN4+XBmW6fPur7sEor1E+RvUVWzggUq7y8PJ/lWxNxypRi5MA8zlEr06Ej3muuwQymcjB97cdxdfxbq9fkX4oUNRyo7RLYoaqREJuzeAAl+mfEB8UmufYr4AwdQu5wQimNhM3XqKp7V7OSbOJqlZ/cZt/je512akFreNOQ+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtgqT1uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB7DC4CECE;
	Mon,  4 Nov 2024 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730733717;
	bh=oBYUN9j1BO+q23M2y1oS+AkreaMduAa607+U0E1Z1hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtgqT1uuFQtPbxTjdgfVroBbcew1hX1L4HXAYMwMvXqPJ18WEY6oODnfvOB6bQAJK
	 4+Xl7+vcOQvCPumVZIWftglnvulteTpcVVEm/tOgUiPbnTtrxftytpApvosRn0Hm0Z
	 2wvsXGqazeJ4x6XVqlHg+MIfo54JO3Enphh9kZi8LbkhSMbOYizHmpGhBVgzPbYQBh
	 Fk7BQneqHsYhLD9RxUybWeqwSFpHsYQxR1pOGDmFSywrtkavG9TI+vZNxW3cRGuG9V
	 fgGid78B4qQdjQZP0HAM3r93gMa5Vp2b96U/sHvV5Yx2E4zgOLASHSwsD/GW1dYpYQ
	 6Lfm+B3h4HYMQ==
Date: Mon, 4 Nov 2024 17:19:21 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <Zyjl-YxldU7EQAdv@kernel.org>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <ZyXqJNIqIx97Y0To@kernel.org>
 <164796a6-c9aa-423b-ba2e-5c6093e3d559@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164796a6-c9aa-423b-ba2e-5c6093e3d559@lucifer.local>

On Mon, Nov 04, 2024 at 02:17:36PM +0000, Lorenzo Stoakes wrote:
> On Sat, Nov 02, 2024 at 11:00:20AM +0200, Mike Rapoport wrote:
> > > +
> > > +The table specifies which write locks must be held to write to the field.
> > > +
> > > +.. list-table::
> > > +   :widths: 20 10 22 5 20
> > > +   :header-rows: 1
> >
> > And use .. table here as well, e.g
> 
> Hm this one is a little less clearly worth it because not only will that take me
> ages but it'll be quite difficult to read in a sensible editor. I can if you
> insist though?

With spaces it will look just fine in a text editor and IMHO better than
list-table, but I don't insist.
 
> > .. table::
> >
> >     ======== ======== ========================== ================== ==========
> >     Field    Config   Description                Unstable RCU read? Write lock
> >     ======== ======== ========================== ================== ==========
> >     vm_start          Inclusive start virtual                       mmap write,
> >                       address of range VMA                          VMA write
> >                       describes
> >
> >     vm_end            Exclusive end virtual                         mmap write,
> >                       address of range VMA                          VMA write
> >                       describes
> >
> >     vm_rcu   vma_lock RCU list head, in union    N/A                N/A
> >                       with vma_start, vma_end.
> >                       RCU implementation detail
> >     ======== ======== ========================== ================== ==========

-- 
Sincerely yours,
Mike.

