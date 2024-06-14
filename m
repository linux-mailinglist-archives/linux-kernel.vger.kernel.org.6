Return-Path: <linux-kernel+bounces-215430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9565190929B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E2C1F22802
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891B1A0AF1;
	Fri, 14 Jun 2024 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="D1SQpY5Q"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B619FA84;
	Fri, 14 Jun 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391233; cv=none; b=DOAJNA+ZleYzPrrThFzs5AtaWs53B/vVL5c9+LUOLws3KnYnI3L8QLo2U+VJn4yzXkmjkIMDHm8bpMJjByLBf2qUI5zDtyWwXfnO84e11TTkQkf1TmLaoletKINU//BK/UQiCYAqFZ4HyV50kgniKCMHETXmFJENN9tLr+6dhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391233; c=relaxed/simple;
	bh=X4on6X+88uTtA052hLd8IsojhN2ZO9yOasjMNwEvFjo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=CHPL8eQeLcuf+xxTbOFsQfEYrv80dh2pS7Bw3rh3Y2U7xelZtsWtQRVj5295cu8/ZCbIQ6fBlj7hwSBzL8DspQyZnvLxIIvTJUdBS/7SnLmE354EtzlXLU+89bRSw8DpRZ44XbFNKQqrh3FcqSk5MElz+1R7thizGpzNDFQYPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=D1SQpY5Q; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QENhb9HFgTzguovvznEeWYIHmMFEH/ZbGTpLCqvvbY0=; b=D1SQpY5Q3iU5y6hS8x3yCA2fCw
	Xefzm8C0+45Bsx/hdgDkRNbsSx/QEswS5UQ34JGXS6GhfYViD98oyeBpeza3esE6hVmq+sMfSpn8T
	MJJI+G8UJ9YF3ttwRvN2GliXh7gTihyr1Teipx7qAcKSLC9+xmPwqQ3M4P902G7Q4kAbEikSprWDp
	e8SrOyC+SUT00xqTD9EEtEC3l5gsMjEhnROTiPfNaL+m4kFPdK9Qw69K0E4pVp5Kbca6f05ZV1gNU
	Yp3CcMz1SO/a4C5cqCgerfhV3SGCbSYwDnIxP5DmaKdXcDjCMjkPzH9zKrlNe0dUYFb8725cOivwN
	3AkQUWVQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1sIBkj-000LiY-5F; Fri, 14 Jun 2024 20:34:21 +0200
Received: from [185.213.155.213] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1sIBkh-000GCY-3A;
	Fri, 14 Jun 2024 20:34:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Jun 2024 18:34:19 +0000
Message-Id: <D1ZYFRA8S0KC.3GG78DB9BA5AG@folker-schwesinger.de>
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe
 line
Cc: "Vinod Koul" <vkoul@kernel.org>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>, "Chris Ruehl" <chris.ruehl@gtsys.com.hk>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Christopher Obbard" <chris.obbard@collabora.com>, "Doug Anderson"
 <dianders@chromium.org>, "Brian Norris" <briannorris@chromium.org>, "Jensen
 Huang" <jensenhuang@friendlyarm.com>, <linux-phy@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Alban Browaeys" <alban.browaeys@gmail.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Conor Dooley"
 <conor@kernel.org>
X-Mailer: aerc 0.17.0-152-g73bcb4661460
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de> <313d5a24b6cffa1a9160e624bb6855aa7f66589e.camel@gmail.com> <20240411-mushily-pucker-732583c1d340@spud> <2192003.Icojqenx9y@diego> <2427291970ac0962bf56b2455e5cb26e49d42c51.camel@gmail.com>
In-Reply-To: <2427291970ac0962bf56b2455e5cb26e49d42c51.camel@gmail.com>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27306/Fri Jun 14 10:28:44 2024)

Hi Alban,

thanks for aggregating all the background information about the issue.

On Tue Jun 11, 2024 at 9:38 PM CEST, Alban Browaeys wrote:
>
> Could you test the enable-strobe property on all the dts that  disabled
> hs400es due to this new default (I lack the hardware to test the
> patches).
> At least arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> and ping the board tester for other boards to test if they require
> "rockchip,enable-strobe-pulldown" for EMMC HS400 write support (read is
> fine even with the new default).
>

I tested some of the boards that include rk3399-rock-pi-4.dtsi (see
below).

> On Tue, 2024-02-27 at 10:11 +0000, Folker Schwesinger wrote:
> > with the following applied, the EMMC related errors are gone. dmesg
> > only
> > shows "Purging ... bytes" during my tests:
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> > index f2279aa6ca9e..ae0fb87e1a8b 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> > @@ -647,8 +647,10 @@ &saradc {
> >  &sdhci {
> >         max-frequency =3D <150000000>;
> >         bus-width =3D <8>;
> > -       mmc-hs200-1_8v;
> > +       mmc-hs400-1_8v;
> > +       mmc-hs400-enhanced-strobe;
> >         non-removable;
> > +       rockchip,enable-strobe-pulldown;
> >         status =3D "okay";
> >  };
> >=20
> > For testing I ran dd three times in a row:
> >=20
> > dd if=3D/dev/zero of=3D./zero.bin bs=3D1M count=3D5000
> >=20
> > I tested this on both a Rock 4SE board and a Rock Pi 4B+ board with
> > the
> > same results.
>
> Folker, are you confident "Rock 4SE board and Rock Pi 4B+" were fixed
> with above patch?
> Ie the "rockchip,enable-strobe-pulldown;" should be under an
> "rockchip,rk3399-emmc-phy" compaible node, that is &emmc_phy in
> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi, not sdhci.
>

The above diff was just a quick shot at testing the
"rockchip,enable-strobe-pulldown" property when I first learned about
it. I later realized that the property belongs under the &emmc_phy node
as you suggested. That's what I did in the other patchset I sent a bit
later, which was accepted and applied:

https://lists.infradead.org/pipermail/linux-rockchip/2024-March/045723.html
f720dd9b8b6d8b2160beda789429d5489ce8a099
c1b1f340dd7db11f273e426e110697551c9f501f

So yes, the Rock 4SE, Rock Pi 4B and Rock Pi 4B+ boards all were fixed
with the patch. I regularly have the Rock 4SE and Rock 4B running from
EMMC, always with the patch applied since I sent it.


