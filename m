Return-Path: <linux-kernel+bounces-289477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC54395469B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BCE1F21D84
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5618D64B;
	Fri, 16 Aug 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LtSknKU6"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1116F85E;
	Fri, 16 Aug 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803422; cv=none; b=IZHxXbfFAgAPu2fcCERcuQ5QtfxG2q+thrPdsClS0RNUrXf+max2jHfe4qMzxAl9zUzYyyn9d3w81+3a+U9huSel0Un2ERINhDmKkmf6l5TELiDPERLJXsYeBKMG3rY9mWx7SYMcdXxbHUBe0ZFag+ySCjag96/XVjAYzndvao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803422; c=relaxed/simple;
	bh=UJlNBvivWgb0cdk3h7CCw0C2sTxDVM53ZCye4avukrs=;
	h=From:To:Cc:Subject:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=hJFaK8Rn5Ev2Fuj2pz3v/ZMebdFrph2k43ZcQE8IgCJGslgK4Uek9k7jOgKjpc6Gr+KATCXMkUdhyUuLt7smoAagJHMipDkIYUppWs81Zyy7+0K17l1NCXtUOCRuf2VogIRpJiLtnyjQRB83m6jcmZphLi1JfmNO7LFfkShG4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LtSknKU6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1srJQU9Lp6EXV/TNHEJRaeCIzq3POh/wVkC52KKLehw=; b=LtSknKU6PVF+UNOREKxl+Fdrhv
	aUDPr8I0BJhIZJ8DHgpwTASmCUS4B+wu8mAQ9PC0iie9WRb4KMyxO7b9uQ8MDwHokGeLczF/kbggL
	s2+TqXK2OOAMAUe0SX0rEg2cIdWYZWkLUgtQDk/S2GB2qkxOwV1Y8MmJUSddbMSkpaMtBFIZv22WZ
	Imj9fvkx3boMFdA6MFjOqI8zayDdiQ57rJbAGNZlF6piK/tB9wcFcuVti+mMGMDfd8/Sw5UPUQ7Z5
	xT+oG/a6B4hGZa3VDYeAVupo/V++pzLXqg2JEo3qmN0JRXW5XcVm+8OL532zVpBBels9DoQrcG8ez
	gloZEYtg==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seu0m-0000Ra-Ag; Fri, 16 Aug 2024 12:16:48 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>,
 Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 3/3] arm64: dts: rockchip: improve eMMC speed on NanoPi R2S
 Plus
Date: Fri, 16 Aug 2024 12:16:47 +0200
Message-ID: <2743124.mvXUDI8C0e@diego>
References:
 <20240814170048.23816-1-jin@mediatomb.cc>
 <002107db3dcf3f1d1d1a767f049b5b79@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 16. August 2024, 12:10:18 CEST schrieb Sergey 'Jin' Bostandzhyan:
> Hi,
> 
> On Fri, Aug 16, 2024 at 08:51:40AM +0200, Dragan Simic wrote:
> > On 2024-08-14 19:00, Sergey Bostandzhyan wrote:
> > >This change has been suggested by Daniel Golle during patch review,
> > >adding mmc-hs200-1_8v; makes sure that eMMC gets detected as HS200
> > >which improves it's performance.
> > 
> > Describing who suggested the patch in the patch description looks
> > out of place.  Instead, you should add a Suggested-by tag, whose
> > purpose is exactly to describe who suggested the patch.
> 
> thank you for the pointer, I guess I missed that, I generally had a hard time to 
> come to grips with the hole process as there are so many details and nuances.
> 
> Heiko, I guess it is too late to fix that now, sine you wrote that the
> patch has been applied?

correct ... and also folded into the first devicetree patch.
So no worries :-) .


Heiko



