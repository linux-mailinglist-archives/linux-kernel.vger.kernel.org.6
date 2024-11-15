Return-Path: <linux-kernel+bounces-411099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA69CF2F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7292F1F223D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0405315573A;
	Fri, 15 Nov 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="mZqLSjUc"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D41BF311
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691854; cv=none; b=CTeuW8Yx3KgTGutYjFP7PASPJGTKskdT8OeiRfYvh+1KZdOZr0XxAbPu9wlzCRiORVxjPOjT1smxez5s5Q93hXFIWCkxtHh6p/4PJAP++pID4pZTIJHODL0p+c/MmTJhieEeZh2UdRzjPTb9fjjbDqSyjsYRqyhuoaJY2nmBfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691854; c=relaxed/simple;
	bh=QGPlCyDba96NxxNK4andssJYx/ysTcYWRnL35S1XWOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5c59nHu4Un6031+baOteyFX5CRtOSkFZr4MJmjPo8bcKY9OGnFRv5WYH49UDtxJ4UzLRci09/D3Obv2muCI7YOcQFtHiM3DhyAdTL0PGCYhHXwk+++6BQ1dxUxtlHxvdGWJAKGMMTnSRDHyyLyc8a7qeVS8JqCtKyEvJi5boCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=mZqLSjUc; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 205F11770E5; Fri, 15 Nov 2024 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731691852; bh=QGPlCyDba96NxxNK4andssJYx/ysTcYWRnL35S1XWOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZqLSjUcv6CzP0F/OzjExK0sQszuCMrMHWLI2Ea5ij3z117Cb4LPDhMI98OM1MzXx
	 /c61fS8zdVnYZ6/AldG7ApvYOHFg6wAloM3jTAtU6VDVldBCCR5Mr17s/ykOjjI918
	 8zvejjyJZMPIDfoGTNe3isohda9hLuSDHm6vfuHH90U61HoCNsl/dC7JquNI5SvFV3
	 eQ7MXsYkOihZDto87rxgRn4ILu2N1J9Pz1U+1EhikgwohZLwBYOm8tx8BSm1xzFzEu
	 8d+uKagvPDNQt7Qk5j5VjMFPDZn91z+0JkzS2Vy+Zul1w9qTlUteCHBWJfq3eWbN9E
	 YGVPnBWaCRgWQ==
Date: Fri, 15 Nov 2024 17:30:52 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com,
	kees@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: refactor an invalid executable check to use isprint
Message-ID: <20241115173052.GA209502@lichtman.org>
References: <20241115165351.GA209124@lichtman.org>
 <20241115170447.GX3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115170447.GX3387508@ZenIV>

On Fri, Nov 15, 2024 at 05:04:47PM +0000, Al Viro wrote:
> On Fri, Nov 15, 2024 at 04:53:51PM +0000, Nir Lichtman wrote:
> > Remove private printable macro that is defined in exec.c and migrate to
> > using the public isprint macro instead
> 
> 
> > -#define printable(c) (((c)=='\t') || ((c)=='\n') || (0x20<=(c) && (c)<=0x7e))
> 
> > -		if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
> > -		    printable(bprm->buf[2]) && printable(bprm->buf[3]))
> > +		if (isprint(bprm->buf[0]) && isprint(bprm->buf[1]) &&
> > +		    isprint(bprm->buf[2]) && isprint(bprm->buf[3]))
> 
> RTFM(isprint).  Or run a trivial loop and check what it does, for that
> matter.
> 
> isprint('\t') is false.  So's isprint('\n').

Right my bad I read _SP as _S by mistake, I'll send out another version with a fix considering the spaces

