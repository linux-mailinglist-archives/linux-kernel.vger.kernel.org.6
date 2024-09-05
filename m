Return-Path: <linux-kernel+bounces-317226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3D96DB26
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809141F234D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B7619DFAB;
	Thu,  5 Sep 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UTx7jycs"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4E19DF69;
	Thu,  5 Sep 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545180; cv=none; b=ZeQNzY6Dc1rgLgnOQzOVGfr1WrrFTJw6FSbwk+EVwZ8B540i0ImnwZzQqqsT90kcEbbprxruh11GHbqGYcyQzSTUkRWVhCE7uGWZhBPy8DGIiHTXwhTm3PS9j4tXP/LL7iZEHnIWGcZYZzyYKhtPko3l3XHflLyKyBdkXL3GT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545180; c=relaxed/simple;
	bh=PjNAReI+MSycnexQJzdUXf7WOh5LiWIe4UgL8Cg3xNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCKv5gdephDEXkqU+d2QU9++SYIKS5GlkRD/nEfi2JQgqaTpVvDeiPuOREw8n5acF6zB+QSMLdSEp7w0+xCp1I22ZJ6yLI+KWscFawOSlbmygnWb+gbhzM+lPQgKXAeO2Q7sP7ship+QCSV2xc5vJaGnwVbciC5o1LUeSzU5ONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UTx7jycs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GUXEpp2c2ARyLgOrUAyoNaSPEKrwdOLv9hGqE+A2ciI=; b=UTx7jycsYBnCRh+5njyIXgy5FC
	4XsU61PAuQ92AXKdGzHoAdP+7Ihixls/mxk5nAmSDHnACwdBRKb/3P3kPyOLxwNu7L2/uPSEoTIkw
	aGdZjMPmzKrjLTppnDlt7SVhyZsQSOaP7cr4/hZHSi3Ouau9rDce+d2kEt66vltXOAO8pVqEUj6Ra
	lDKgJT+b+GbxdLyEQw1Rn3/ShNCYBj0MD93G4uvFo01s8jC+P1rgUrk9OSfTBZBusr+zcMg/s1XWh
	KvbeU5kIWwEmFn3Dv/IsK74Ae1ypTYFAM1BRUyKHJMqF8GP7rGtkHJVoCgUmdWkIVqCbT0OEZiZK/
	PrN9vO2A==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1smD7i-000225-N9; Thu, 05 Sep 2024 16:06:10 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, Diederik de Haas <didi.debian@cknow.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Add a few aliases to the PineTab2 dtsi
Date: Thu, 05 Sep 2024 16:08:05 +0200
Message-ID: <2089090.o4kTbAZ4gJ@diego>
In-Reply-To: <D3YCHAOLOU6W.3B8MJYAYWOEGK@cknow.org>
References:
 <987e68d1c5e9a0cc56d730aec87246aa5ab8ea14.1725535770.git.dsimic@manjaro.org>
 <c820085c-a4f4-4d03-9df8-733a79e911c0@kernel.org>
 <D3YCHAOLOU6W.3B8MJYAYWOEGK@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 5. September 2024, 14:21:12 CEST schrieb Diederik de Haas:
> On Thu Sep 5, 2024 at 1:39 PM CEST, Krzysztof Kozlowski wrote:
> > On 05/09/2024 13:32, Dragan Simic wrote:
> > > Sprinkle a few commonly used aliases onto the PineTab2 dtsi file, to improve
> > > its readability a bit, to make it easier to refer to the actual nodes later,
> > > if needed, and to add a bit more detail to some of the labels.
> > > 
> > > Suggested-by: Diederik de Haas <didi.debian@cknow.org>
> > > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >
> > Unused aliases do not improve readability, so for me this change is
> > making code worse without valid reason.
> 
> This came forth by a question from me to Dragan about a patch for
> another board which doesn't have a charger defined at all (yet).
> I actually have that patch (but not the HW) for a while (~1.5 year)
> now and I had used `rk817_charger: charger` for that, probably because
> I saw that being used everywhere else.
> 
> Then I compared it to the PineTab2 and noticed it had only `charger`, so
> I asked "What should I use? With or without the alias?"
> In this case the inconsistency is causing confusion (with me).
> 
> So: What should be used for that other/new board(s)?

As Krzysztof said, having a phandle that is never going to be used is
somewhat pointless.

Having a phandle defined for a node does not hurt anything, so having
some in a board dts is not catastrophically bad, but there is no reason
to add or remove unused ones for no reason - especially as it affects
git blame .

So in short, if you see an unused phandle in a dts _patch_, just point it
out in review.


Heiko



