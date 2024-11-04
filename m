Return-Path: <linux-kernel+bounces-394969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A37A9BB6A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC99F1C227B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0FF433D1;
	Mon,  4 Nov 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODZUPZxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5418BEE;
	Mon,  4 Nov 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728218; cv=none; b=gsSLwrTCfVDH4EX6oiGpVcYysGvlpsGeVSzS77v2i8hvvQNC9EXGrgOw10ClXsX/wpxZ/2HnPyMJolCcjEsM8TEfVX2jq87AuN2U445mA6PBckWfPh7BoO9iVlFlTbFXODoEjd8R6AHVLa5wMbhO8Zo/wN9OY5+EN8axsZHGLpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728218; c=relaxed/simple;
	bh=gHreMDif9HESvX6AXP7OsdTpnwAWyyEiLjrEvTpLHVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s41LcjV6l5mTaxxgMU7N6pnME8cT29DSzL7O9jQZ1XGy+KfCfB95OKvKmSx5oNxQ9bIFZV6fcQ7ioLKT+86wv39uc+PfqmwP1nDFrn7dxiUCBcBT4BT1ZTEqF+Y5s7bwC3UZ/0OL8FSh4d1PYSQ0MrQGy+53S6uFGt0DwzjE3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODZUPZxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FABC4CECE;
	Mon,  4 Nov 2024 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730728218;
	bh=gHreMDif9HESvX6AXP7OsdTpnwAWyyEiLjrEvTpLHVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODZUPZxAxatXofqe2Bld8arK3JWihWtKbNZfcXqX1Qf87UMLWi3hF/TzVU959+6em
	 fM185BPRmGZp26BoXlrsTz610JqrwDi0WcRxnPrsP6ToWjoeft2AbY3ew4lJVvjYLh
	 b3UsoWIw+j2Ee8wSQLuN11csURoY/J+vxNvd+/OCTj3WAYEq6JlEJULA/ex4wqUfXB
	 vON8dyM58tsQTjxhAuZ7kksGBxhcdFgtGzesTATQbB9zAIieSHFnasG5fVTZEzvLcu
	 2EYAFZcBWUjRisQxl3Th16iOEEIZHoWmT+UzvffCOYLTZsRoWSJ7W8/Xb6xfgD8bM4
	 cfxzweH6TjX0Q==
Date: Mon, 4 Nov 2024 15:47:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <ZyjQfG2YakYXLUdS@kernel.org>
References: <8e02f3a4-d498-401d-aaba-e53ed2ac6a3a@lucifer.local>
 <20241101234832.56873-1-sj@kernel.org>
 <b5fcdae7-8918-451c-ab7a-de7136e5dbe3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fcdae7-8918-451c-ab7a-de7136e5dbe3@lucifer.local>

On Mon, Nov 04, 2024 at 01:02:19PM +0000, Lorenzo Stoakes wrote:
> On Fri, Nov 01, 2024 at 04:48:32PM -0700, SeongJae Park wrote:
> >
> > This is the "Unsorted Documentation" section.  If the document is really for
> > the section, I'd suggest putting it in alphabetically sorted order, for the
> > consistency.  However, if putting the document under the section is not your
> > real intention, I think it might be better to be put under "Process Addresses"
> > section above.  What do you think?
> 
> Well, at the moment it's sort of a WIP thing that we may want to put under
> another section, was just putting there somewhat arbitrarily for now.
> 
> I also wanted to avoid too much debate about what to put where :P
> 
> But absolutely, ack, will either sort it there or put it somewhere more
> sensible, thanks!

Don't mean to bikeshed, but it would make sense to put it to the "Process
Address (space)" part :) 

-- 
Sincerely yours,
Mike.

