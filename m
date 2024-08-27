Return-Path: <linux-kernel+bounces-302770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32A960311
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6045C1C222B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA2F156653;
	Tue, 27 Aug 2024 07:29:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63814F9FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743792; cv=none; b=UCXCHLk4fXvha8VGiXsn90RmnyZnOSUq3ivj/u9G3zmrMzDZi+4ihySHaKhUkUjiTHtG8q2MMwdMvjP5ljnC5KkZUUCk7icFztRE/EHXA36NQptfR+kzQNPC5jej/onWUMiMtW/Zf468PRmYp+Ax3fWqRuOBM0BpnLirVTmmY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743792; c=relaxed/simple;
	bh=VD8YpsoYcj3Tmhe1x27pcMIaD7i1mBM8NRefDinq2FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMq2IF+GoIRXUS/HUDqQgZpXWzjuJ3Vq0ycLaeQrji5LT6ZytIMWetV6TNiJbyFJZaahgl1EFsJlisK4Im+pNIE/ZEaLbKCrdQOwEHSj9UAaI7rwWHVjCepiFrGVZardD6NLl6IQGY+xmPTQcWPRd0dbIqXB1kJLJpv4fHADPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC3AE68BEB; Tue, 27 Aug 2024 09:29:46 +0200 (CEST)
Date: Tue, 27 Aug 2024 09:29:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	Christoph Hellwig <hch@lst.de>,
	Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
Message-ID: <20240827072946.GB13080@lst.de>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu> <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de> <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com> <20240822053238.GA2028@lst.de> <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com> <20240823130600.GI28254@gate.crashing.org> <20240823135459.GA28487@lst.de> <20240823191924.GK28254@gate.crashing.org> <c8127b03-245b-4eaa-98f5-6e14df094669@cs-soprasteria.com> <20240824171757.GL28254@gate.crashing.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824171757.GL28254@gate.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Aug 24, 2024 at 12:17:57PM -0500, Segher Boessenkool wrote:
> > Are these functions also used on DMA coherent memory ?
> 
> Most won't show up high on most profiles, heh.  Which you already
> can see from the problem not being attacked yet: if it was so obviously
> a problem, some people would have wanted to do something about it :-)

Most drivers try to avoid coherent allocations in the fast path if
they can.  Another good option for Christians problem would be
to switch the the dmaengine driver to use dma_alloc_pages - it doesn't
actually need uncached memory as far as I can, dma_alloc_coherent is
just the only API we had to allocate guaranteed DMAable memory for most
of Linux's existence.


