Return-Path: <linux-kernel+bounces-373981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9C9A602D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C202863C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FF11E411D;
	Mon, 21 Oct 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="FcTQec5S"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72301E3DC9;
	Mon, 21 Oct 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503239; cv=none; b=bXtnFXe+VAYTBjO42Jh4ZN0SQdzlRDIryFiZ8SfGoc+lJshAPWUQ1VHDi5/qCPf8cJ+FqyEqHdWAc57//NPHJDHGikPn2UNhRZJ3cw64DSDU4tGLt+hfCEke9kNBAaB57f6+xl3Q9DD+I9DQhgTF4YoRSjWCJi1vVt+nMZKidQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503239; c=relaxed/simple;
	bh=lt4MyRKSRDATgIILLvQBERHTvt0iMENs897PEB75t5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6OOJ0MGmtfqg8KUyxhbBrzVixZ7JXsnIFiZ0KUXk2mIed5TDPUudnZMeRxBb0RE0KvdN8b+coJrwC6/0N0+qhYJj0eThdn4kOQFpUZbB8OZYzAA8BAu1tzq+vmhh8eyQ/ku0+CUX3XcsgYynAtL1976Xe7q5eDMmeddZZ+s+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=FcTQec5S; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E662F1F910;
	Mon, 21 Oct 2024 11:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729503235;
	bh=eJXnu31+KUwObtPMQI/tdF00wkFhCU+yalKssA5xKhc=;
	h=Received:From:To:Subject;
	b=FcTQec5SbDkOpuLJvOFzdYzEGGCZOQ13xmRb/wCI0Av+k2ODoqIF1UMOmiWxP07/8
	 h4CsGMHrmLHmjSzEJHgvcEbBQIXQ8LdmP6NTI1HO6TcPEhpqEAYrG7oeg5koxoUTnq
	 OexK1UhlZNGTihs447k1jPpF4VWksMqfsz3zHqY/kHNYNFmFr8keEJ+hoJfidoVmsU
	 MWTxTgcLkyeWOR+wpQXT6MrMaMDglJSOWAD+xSV7Bv9XsWT5lELWEhPwpiW+inWSZj
	 Hveb9xxsGR7d3sCCFciVQ5HjzN0rESESM9oKQn1K4TtII7YiI1dlMjYnPuIdPKF+38
	 sH1PibwksrkMA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id A0AE97FA52; Mon, 21 Oct 2024 11:33:54 +0200 (CEST)
Date: Mon, 21 Oct 2024 11:33:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Conor Dooley <conor@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: drop usage of Toradex SOMs
 compatible alone
Message-ID: <ZxYgAijbgKJyKpkC@gaggiata.pivistrello.it>
References: <20241004160842.110079-1-francesco@dolcini.it>
 <20241004-enforcer-absently-e3a056284991@spud>
 <ZxYfHMViwfCQEdNY@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxYfHMViwfCQEdNY@dragon>

On Mon, Oct 21, 2024 at 05:30:04PM +0800, Shawn Guo wrote:
> On Fri, Oct 04, 2024 at 05:24:11PM +0100, Conor Dooley wrote:
> > On Fri, Oct 04, 2024 at 06:08:42PM +0200, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > The Toradex SOMs cannot be used alone without a carrier board, so drop
> > > the usage of its compatible alone.
> > 
> > FYI, alot of what you're removing here appears in the $som.dtsi files.
> > I don't think that matters at all, since the dtsi files need to be
> > included somewhere - but figured I'd point it out in case the platform
> > maintainer for fsl cares.
> 
> Thanks for pointing it out, Conor!
> 
> I would say we should remove the compatible from dtsi files before
> dropping it from bindings.

I'll send a v2 to address this.

Francesco


