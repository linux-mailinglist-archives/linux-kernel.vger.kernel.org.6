Return-Path: <linux-kernel+bounces-275905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE06948BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A361F226BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378BC1BDAB6;
	Tue,  6 Aug 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n5A361sf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D491BDAA4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934504; cv=none; b=sx0ii6yuxmg2Z13s3fJr7mT3pFKugCDk7Zn6fDPsA+H2zdJkEuF83xDklTkHYQBwyND6mWelkZ/oPfXViiQOaQ8rvvcH5wNdyQ4NbmB0IlsnhRqdDoqHv+mDxStsWL+CRFISEy6pX+8x3IjgBb2B2Octq0dyOn1xzctp1CyJFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934504; c=relaxed/simple;
	bh=KVp/7QHAm64lJNet4/OKS5Y0F74l7MEm7GnBgfqleug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEacncBQGsOyXY9TMyewRgfy2yZZTzKwFCUU5yC8HSI7cJrrefFvsKmZQVb2Bk8Xxg2uD2fJQ23Yy0Dr4NaEPsLcJxUkxvAJiEdTLRRuFjgAf7Wc78lvTqZd0cgr0pf31VzSrVJAn9ZcoS4AIDwGFLDchizwdkzA/MD0MXTeWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n5A361sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70772C32786;
	Tue,  6 Aug 2024 08:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722934503;
	bh=KVp/7QHAm64lJNet4/OKS5Y0F74l7MEm7GnBgfqleug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5A361sfdeIbYeJW+vwPHi54hFdqukWKKC8O+DuTd4GXvMXAGQei2Rvx2zvsFMX9F
	 /SFSyRy4ToiYBHsinlBExb8qLxCACuqDE0y0NTA9heBmaPQsFZmE0Vul/k1v7V37m3
	 VgnG4WeZ9S8RkZ4EZFHUA4KAlbJxrh9L7m/0TOdY=
Date: Tue, 6 Aug 2024 10:55:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-42082: xdp: Remove WARN() from __xdp_reg_mem_model()
Message-ID: <2024080634-electable-foyer-ad3c@gregkh>
References: <2024072956-CVE-2024-42082-8411@gregkh>
 <25rzouzv3bf4opsbgcbwjn3ycip5s75awl5muu5fzcibwjnv4b@4khlyuarrnl5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25rzouzv3bf4opsbgcbwjn3ycip5s75awl5muu5fzcibwjnv4b@4khlyuarrnl5>

On Tue, Aug 06, 2024 at 04:48:56PM +0800, Shung-Hsi Yu wrote:
> On Mon, Jul 29, 2024 at 05:53:11PM GMT, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > xdp: Remove WARN() from __xdp_reg_mem_model()
> > 
> > syzkaller reports a warning in __xdp_reg_mem_model().
> > 
> > The warning occurs only if __mem_id_init_hash_table() returns an error. It
> > returns the error in two cases:
> > 
> >   1. memory allocation fails;
> >   2. rhashtable_init() fails when some fields of rhashtable_params
> >      struct are not initialized properly.
> > 
> > The second case cannot happen since there is a static const rhashtable_params
> > struct with valid fields. So, warning is only triggered when there is a
> > problem with memory allocation.
> > 
> > Thus, there is no sense in using WARN() to handle this error and it can be
> > safely removed.
> [...]
> 
> The mention fix (below) simply removed a WARN_ON(1) call, so I believe
> there's no security implication here.

If memory allocation fails, and panic-on-warn is enabled, this will
cause the machine to reboot, hence the need for a CVE allocation.

thanks,

greg k-h

