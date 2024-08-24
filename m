Return-Path: <linux-kernel+bounces-300133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9C95DF2D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B063A1F21C39
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358A46434;
	Sat, 24 Aug 2024 17:24:55 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A81625
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724520295; cv=none; b=im1gFACm6CbWAj6aANKDX0MzmI5K9MMLoXd3MKu4yNZrBhICyF81mdcMHZqvVCCOo0GCngDIwzsNlm8E9yJI7DC3s8PrTOJmI5yU/cg/kXUMBHQwLThCkyie92lKsBYuvTHBv5tVVwEB8xI8gYe5pJkZA4rim2cFCOqlZPJWiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724520295; c=relaxed/simple;
	bh=WTG6pKxnPVG/JkfzyWXzvFlMWfg5neUBcHvY3y3dhtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooVbkVjEiWvoVGQihKqWnVYoMpd8osA5MEUavu2rIf5Avqvh7lzsZKzVY/oO5ldaOXBKLAf+EXKolJEMblUCNPPvwaBK/nNnIj8yrHqAzR0crmoT82nibetxk+zdXQnrNO4mgriZSqd/NAZMqSRAKgxIDigB5nmDy5zde2ckJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47OHI0J9004252;
	Sat, 24 Aug 2024 12:18:00 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47OHHveN004249;
	Sat, 24 Aug 2024 12:17:57 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Sat, 24 Aug 2024 12:17:57 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Stan Johnson <userm57@yahoo.com>, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in kernel mode
Message-ID: <20240824171757.GL28254@gate.crashing.org>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu> <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de> <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com> <20240822053238.GA2028@lst.de> <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com> <20240823130600.GI28254@gate.crashing.org> <20240823135459.GA28487@lst.de> <20240823191924.GK28254@gate.crashing.org> <c8127b03-245b-4eaa-98f5-6e14df094669@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8127b03-245b-4eaa-98f5-6e14df094669@cs-soprasteria.com>
User-Agent: Mutt/1.4.2.3i

On Sat, Aug 24, 2024 at 09:01:33AM +0000, LEROY Christophe wrote:
> Le 23/08/2024 à 21:19, Segher Boessenkool a écrit :
> > The memset() code itself could chech for the storage attributes, but
> > that is probably more expensive than just assuming the happy case.
> > Maybe someone could try it out though!
> 
> But is it only memset() the problem ?
> 
> dcbz instruction is also used in:
> - memcpy()
> - csum_partial_copy_generic()
> - clear_page()
> - copy_page()
> - clear_user()
> - copy_to_user()
> - copy_from_user()

That is just a handful of functions.  Not sure about the _user things,
and the _page things for that matter, but the rest is certainly
measurable in real-life conditions.  So if we can avoid the problems
completely, and cheaply, we probably should.

I'm not so sure about the cheaply though :-/

> Are these functions also used on DMA coherent memory ?

Most won't show up high on most profiles, heh.  Which you already
can see from the problem not being attacked yet: if it was so obviously
a problem, some people would have wanted to do something about it :-)


Segher

