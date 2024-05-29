Return-Path: <linux-kernel+bounces-193525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A268D2D69
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EA51C225D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92A15F41B;
	Wed, 29 May 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xt76iB82"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F115B111;
	Wed, 29 May 2024 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964778; cv=none; b=FA4x2wdQ4jWmp0HIVFCIGXd7aGImsf/V/Et08nvYSiKneW72iVf4LGQ/6l8yIndze1KMzGMqr7cBJPDuANjcczCYiR31lb2VFA7feUO32fh7C3z93QteCioUFa47HDstl8Ok6ddLYH3mlKvVInWiXTokVPhCQlkBp0sqINsfbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964778; c=relaxed/simple;
	bh=c7vsMmkRkQR457AIbiTAbmeqKjK6C48DBrwt8IXm3GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsaBjLpTqbt9JWwOVPG6ynzTpuoMGsZwfRepH1/rVGL59rljLxBTYHJDkmGVz2p1vQ89iC0BpcxUqnoiLE14lq90RjTEdlR1/sYrd/ycgwQ2DTfXQxnQndLz+RiY5tXUfvR3XdbhD/ndbkrrCl/EkQpNFISShj2f3LIIX+i1pAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Xt76iB82; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jqFwIexOOQubX3YN7HAsecUfsApstuKXfCuYEz3boRs=; b=Xt76iB82qgmw8BmC/lYvCAlW4c
	YFTbfeQR0xmdqNAOSA+3RXlA0QkXATAwtjTdp68G7XixUte3X65m2eVFJ4RwIsswaAETcJn0zEINq
	5/AX2yohJa6d9gjzRl8g07NyJx0ZRSSCqRpvjC8AXkxOInii49qDKK7plvjTF5Sd0O8TEfuYMlt57
	kNGYMUryy1cq9XfoyLnK2t8Fs+AI18hoZv4QeNDzVM3psgT5lcd3kmmNJokA4wBiMhn+eV34zRjZi
	e+uRGFejOsuzlux5I3ef3nkCmaEB6IxnJqlCrXufC5sMNi8EMZuUPTw8aKu8TJbMMLGFlunWX/aKX
	k/lKeZfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sCCyF-002CiM-1H;
	Wed, 29 May 2024 06:39:35 +0000
Date: Wed, 29 May 2024 07:39:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Alexey Gladkov <legion@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: PROBLEM: kbd busted in linux 6.10-rc1 (regression)
Message-ID: <20240529063935.GN2118490@ZenIV>
References: <ad4e561c-1d49-4f25-882c-7a36c6b1b5c0@draconx.ca>
 <20240529052543.GL2118490@ZenIV>
 <d7412ef9-8e25-4f55-aac9-8ec479fb6775@draconx.ca>
 <20240529063648.GM2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529063648.GM2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 29, 2024 at 07:36:48AM +0100, Al Viro wrote:
> not "none").  Uses the fact that "none" does not combine with
> "read" or "write", so we can treat 011.... as "write with argument
                                                 ^^^^^ read, that is.
> size in range 8K..16K".

