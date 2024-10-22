Return-Path: <linux-kernel+bounces-376929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05399AB7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4171C22FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6291CC16E;
	Tue, 22 Oct 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ywSIYnVb"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCE1CB30C;
	Tue, 22 Oct 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629304; cv=none; b=QIC0nJxh0nZI+kKKET9tHQvdgzi2EwxSB5HhS3Y4o6AWYCwREckFEyV/n3o5GR+I93yRiP7vjrF9VWXk1+p5VxpGevFYhCW4SRchdltINwnOzb2bwRRrQKko7r7RokB7t9thuQ6w9Kh2FWcAum8B/Mg4ycPgzuB1OmbUNo6MC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629304; c=relaxed/simple;
	bh=OiUWg3Pn95PdkrUBQ5T6WGMbu1yA2LaiJIgmYPzXOjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzYsXciMnZSfjArC25ToBuG8OlIAWrdCAINOrxzxYO+CxNFBZ8OzZhSbtexRYWG4fChQ/7mv3M65VftOf0qWloljKMvEt70S3mIKc56v1jaevNs22bSyioQkm3xxwyD51aRKNu5qWT5JGWgIQyMkGoJceDH6IupmS11edT/UYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ywSIYnVb; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m0Gs6f86g6ugZlujb8KQk26o9qJc7j+Ro8eH92L7lo4=; b=ywSIYnVbFesb3ZAfUBmu30D8wn
	bPBG20T5dToSMGDFIObyWgTvmJ5EAMI/nTuBC7bsNrH3IIQc/tcr/niYGrZj6NmV5ad6oZfeMLIsJ
	tt0coaYoWX6XrgDxYNGeLtGIPdZcelCU33f5SfR+5bOh/kt7HUXD41t1S5t5kZEkgwxceWXKakdjN
	iMCChOYObEtBWt/JzKWY+IJ6s7NiWfoCEBUNN5A0zifxOenqhC/AoxYZ3fnQDj+mOR2QACy5n7+vC
	mLhdbozP/vVX13scrrLPG/H25REIxB/iRqgOyspT+vAmErH2BVhI0LMpyiwrYV5QWRM0YWbssH1Gd
	sWyJCXTw==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3LaX-0001tt-BZ; Tue, 22 Oct 2024 22:34:45 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Jagan Teki <jagan@edgeble.ai>, Rob Herring <robh@kernel.org>,
 Andy Yan <andyshrk@163.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi R3S
Date: Tue, 22 Oct 2024 22:34:45 +0200
Message-ID: <2629917.Lt9SDvczpP@diego>
In-Reply-To: <8684a5a3-48d0-4acf-9ed7-a035fca15119@kwiboo.se>
References:
 <20241020173946.225960-1-cnsztl@gmail.com>
 <172960632903.1476617.9941592027677995572.b4-ty@sntech.de>
 <8684a5a3-48d0-4acf-9ed7-a035fca15119@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 22. Oktober 2024, 19:07:43 CEST schrieb Jonas Karlman:
> Hi Heiko,
> 
> On 2024-10-22 16:12, Heiko Stuebner wrote:
> > On Mon, 21 Oct 2024 01:39:45 +0800, Tianling Shen wrote:
> >> Add devicetree binding for FriendlyARM NanoPi R3S.
> >>
> >>
> > 
> > Applied, thanks!
> > 
> > [1/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi R3S
> >       commit: 1e94bfea52bee081c42ab922c19156dd3d2bade8
> > [2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
> >       commit: 50decd493c8394c52d04561fe4ede34df27a46ba
> 
> I just sent out a review on this patch [1], please leave more then a day
> or two to finish up a review ;-)

Hehe, yeah might be better ... somehow that small board dts looked so
innocent though - aka what could go wrong ;-) ... obviously something.

> [1] https://lore.kernel.org/r/13bb8657-f048-4f79-a2c1-3680445f2bef@kwiboo.se/
> 
> Regards,
> Jonas
> 
> > 
> > Best regards,
> 
> 





