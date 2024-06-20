Return-Path: <linux-kernel+bounces-223338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD04B911150
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5531C215ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5731BBBDB;
	Thu, 20 Jun 2024 18:42:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B31B47DE;
	Thu, 20 Jun 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908970; cv=none; b=BiG3FcEI8LcgjYFUZMoOb2K3l0UcQblZSOOimHAh2TwJ2hOptXzYHlo/t/ZtOXGGMDU7DXCk7/VDjjus6qtfx3/x4SfKsEDrXvZQFH0ydj93IHZiSP/cRzNfjPoeI/AYxcIhzvXXjkGK9f9MubSJDXI0WbIJKp1m6tXx1PgwZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908970; c=relaxed/simple;
	bh=LvnaCPxKoIZfQ4R88XqAC/V17BVWq6QoYfODJKaC0tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F08d//MeDB29Cd43TyBOItD4OrcHdeGoEb9PmBUhfEQLdzQakMBCxYNl0YMkGsEKYy7MPLs0tHw167L1YqA75iHAJqdK9/stB35JoQrcCe69XjV6wTr1+gkURJIMipZHhy1eby6Rh7HpGQ+gkErCgelYO59vSHERYFK6/Sy55gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cc8.versanet.de ([94.134.12.200] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sKMk6-0000XY-Qs; Thu, 20 Jun 2024 20:42:42 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sebastian Kropatsch <seb-dev@mail.de>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Improve LEDs on NanoPi R6C/R6S
Date: Thu, 20 Jun 2024 20:42:42 +0200
Message-ID: <2564239.kdYZ1jHi8b@diego>
In-Reply-To: <20240612205056.397204-4-seb-dev@mail.de>
References:
 <20240612205056.397204-1-seb-dev@mail.de>
 <20240612205056.397204-4-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 12. Juni 2024, 22:48:12 CEST schrieb Sebastian Kropatsch:
> Move led-3 node into NanoPi R6C/R6S's source files since they have
> different functionalities on each board: On the R6S this LED is used
> to signal LAN2 link up, while on the R6C this LED does not have a
> pre-defined purpose.
> 
> In addition to that:
>     - Remove deprecated label property
>     - Add color and function properties
>     - Add linux,default-trigger to trigger on Ethernet link

Again, please don't group unrelated changes together into one patch.
It makes things hard to read and hard to follow the changes.

> 
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
> ---
> 
> DT validation doesn't like the 'linux,default-trigger = "stmmac-0:01:link"'
> properties, since "*:link" is not a valid value according to
> [Documentation/devicetree/bindings/leds/common.yaml]. These LEDs do
> have the specific purpose to show if an Ethernet link is up though.
> There is one LED for each Ethernet port and they are labeled WAN and
> LAN.
> Using the 'linux,default-trigger' like this does work perfectly fine
> with this solution. I could not find another way to achieve this. Please
> let me know if there is a better way.
> Maybe it would also be valid to add an entry to the DT bindings file to
> allow "*:link" as a value for 'linux,default-trigger'?

correct. If needed, things should be added to binding.


Heiko



