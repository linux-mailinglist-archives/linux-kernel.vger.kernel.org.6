Return-Path: <linux-kernel+bounces-523061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18343A3D18A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE457A5374
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9834A1E3DE8;
	Thu, 20 Feb 2025 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6yMDkzH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AE1A7264;
	Thu, 20 Feb 2025 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034120; cv=none; b=FsAVBHkEikn+9h6WhydQK5UdYqbK+002iSgEGvTxfZX+l8FcZkCbmt0ptt/i1V/3rKTgUS8J3cQasFaN18ziKDZX6Jl4qIgF92VSRv65RZ4IqMhCB3aIj/mDk3xEQtg/MJA0luM8SdLG07ecdyTMUv7SyQ52S2NOUk8T+I3ChIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034120; c=relaxed/simple;
	bh=ma1+2NPWeiQAUPzYxW89ys227e0RgD2/vdzE/Vr0Dc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfEW5yANV4/NxuK9SXVHi3I8hfg9fg/wNQSLSDDYRhpdZTaUPC7yqa31J5aKWCyK25LMKtk3hBxK0/HSFJNRpbL/fbulJu9U6XEMGNfpo4qlAt6qnC9NbpfFB5876+TJuTtqzLPd5JbFU9qhu3/x9muHePG3T9UeDLcvcxyJigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E6yMDkzH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3PfY6wxBqI2r/3j6sSUYczo/UJ69N0WoAeQbPbuqS80=; b=E6yMDkzHD3JzfSI1jze69wgZaR
	ErTRyPq0PSNbF7KEt06gypJ3dFzV1UCKWyCtkPhivlkED5ivxx6ybnJwuBBbW17I+kN53hPVxQIR3
	kR0jEtNO+/JzYxGLxu3aHzMeTNM/OKLMkIoMaziB/CQe2uqpw9XVhrAuiuBWT1PCjfnuGxZT3DXpB
	tTatoGFh9prA6JcKzpjHVsFttDo4uD/B21W5q26bdjVkzYm6QNSSJcEzwOyb0ajLqflyOy/MEuVi2
	DUxG1LnNHbMmjfQSl4eyt1trBz2X4Apx06Po9GF4KFNvVsqj+B+QqNWCXyooJk+wb+bniJvDGGz1B
	vTsi8HsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tl0MQ-0000000H0Z7-0VpJ;
	Thu, 20 Feb 2025 06:48:38 +0000
Date: Wed, 19 Feb 2025 22:48:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7bQRvHNcK_MmDQn@infradead.org>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
 <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
 <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 19, 2025 at 11:03:28AM -0500, James Bottomley wrote:
> > This has come up a few times, and we indeed would like to have some
> > annotations in the C headers so that we can generate more (and to
> > keep the information local).
> > 
> > For instance, it would be nice to have bindgen's `__opaque` near the
> > C items, or being able to mark functions as `__safe`, or to have
> > other `enum`s-related annotations, or even custom attributes, as well
> > as "formatted-formally-enough" docs so that can be rendered properly
> > on the Rust side, or even references/lifetimes with an eventual "Safe
> > C"-like approach, and so on and so forth.
> > 
> > However, even if we automate more and even reach a point where most C
> > APIs are e.g. "safe" (which would be great),
> 
> I wouldn't say C API safety would be the main goal, although it might
> be a nice add on feature.

Why not?  Why is safety suddenly less a goal when you don't use the
right syntactic sugar?


