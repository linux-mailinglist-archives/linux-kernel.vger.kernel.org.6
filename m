Return-Path: <linux-kernel+bounces-235902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A091DB15
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EEE2826EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C884FDF;
	Mon,  1 Jul 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="oOVgyjTY"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4722B5C614
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824893; cv=none; b=l0CHQXqtoz+oTUKs1cUOqlvF28iBGt/R7wzOUkekaTOaHDIZm64OnL96UwcL09opTdUFuPNiM3csQ15wKDGH2k9IvyhUsgeQfDZgo6WdniDlIs5xkXQw5iSIIcLv3KUlmBeanV85TPtJ93jTDnRRcwYecsjSapqWVmhpZudgKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824893; c=relaxed/simple;
	bh=d/GvZXopd7RBz/FCC7jXfhZ5u9rRAmTJc+KP116yoXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/P5/MSYzLxodJ0bqOO6AmTRhfrARxZ/j2sr1BlyfXalFUUTGgHqcnGkio7IC1oGeR8Hr++sWZA+LvB90y2TdOoU0azkgMXI2kWBdwY3KdfdDq1mc2xIGpNzR5zVfqOb8MVNvcxbhwVkk1mlm8QEC6q5G64PXIHCSQlpy2k0Cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=oOVgyjTY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1719824884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWkD76VR7famEn8Nbe0wkLmIlzygXCHVCmau7jj4g+s=;
	b=oOVgyjTY4hXNXt3d48GL4BdGmMVTjrOg1/GHXbiO+wXTF7dgcS74XcXdgs4UR2eVSOuqkL
	lZt4E3IYv3zIA26m2e2B91XNpj1vL3X1jrpl/a9aHmTBpoikf8SpVeaxxajabkclUgNctv
	y9u/UjqaYWXR0PiEwxR3D5uDmEaWJQJ2diOoqRorX4H1SWReuNX76tYjfgVOWqeJnZAsWm
	azJkxZF7N6JWaKOiyP8rqmlVVo/VYD4Z3/1h9amxpkX7y+O0b6HYtb1Nz6+2q9UZHOCdHr
	SpfvAHF2DPWL//afSG+P6vnbQN0p1B3PW7saz2/QNfcCb6CYv2429OgHT5answ==
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
 Jonas Karlman <jonas@kwiboo.se>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH 00/13] rockchip: Enable 4K@60Hz mode on RK3228, RK3328,
 RK3399 and RK356x
Date: Mon, 01 Jul 2024 11:07:50 +0200
Message-ID: <2528743.FZeJfPzi8P@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6101972.8Rv6zO9TrO";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart6101972.8Rv6zO9TrO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Mon, 01 Jul 2024 11:07:50 +0200
Message-ID: <2528743.FZeJfPzi8P@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
MIME-Version: 1.0

Hi Jonas,

On Saturday, 15 June 2024 19:03:51 CEST Jonas Karlman wrote:
> This prepares and enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228,
> RK3328, RK3399 and RK356x.
> ...
> This series may not fully depend on but was only tested together with
> the series "drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID
> cleanup" at [1].
> [1] https://patchwork.freedesktop.org/series/134727/

I only just now realized this part of your message and consequently
I had NOT applied the referenced patch set.

> I have tested 4K modes on following devices:
> - Asus TinkerBoard (RK3288)
> - Pine64 Rock64 (RK3328)
> - Radxa ROCK Pi 4 (RK3399)
> - Radxa ROCK 3A (RK3568)

And I can confirm that this patch set enables 4K(@60Hz) resolution when
connecting my Rock64 to my 4K TV with my self-build 6.10-rc5 kernel.
It selected the 3840x2160@60Hz resolution, but ``swaymsg -t get_outputs``
also reported a range of 4096x2160 resolutions.

In contrast, my 6.10-rc2 kernel which is quite similar, except for this
patch set, does not mention any 4K resolution at all.

So AFAIC you can already include:
Tested-by: Diederik de Haas <didi.debian@cknow.org>

Next up will be a test with my Quartz64 Model B (RK3566).

Not caused by this patch set, but I did encounter several 'interesting'
issues while testing it. As most do involve display/hdmi, I'll mention
them to have it at least publicly documented.

Summary of those:
1) With Debian's 6.8.12-1 kernel I got a stack trace and (initially) no
output at all. After some time (due to no signal) my TV turned itself
off (standby) and when I turned it on, I did see a console...
First line of stack trace:
WARNING: CPU: 0 PID: 432 at drivers/media/cec/core/cec-adap.c:1085 cec_received_msg_ts+0x52c/0xbb8 [cec]

2) The 6.9.7 Debian kernel I then installed did not have the stack
trace and did show a console, but in 1080p. But I have a 'vague'
recollection that the stack trace issue only happens sometimes.

3) All the kernels I tested had the following errors:

rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack on domain 'hevc', val=0x88220
gpio-syscon ff100000.syscon:gpio: can't read the data register offset!
hdmi-audio-codec hdmi-audio-codec.9.auto: Only one simultaneous stream supported!
hdmi-audio-codec hdmi-audio-codec.9.auto: ASoC: error at snd_soc_dai_startup on i2s-hifi: -22

4) And they also had the following warnings:

rockchip-spi ff190000.spi: Runtime PM usage count underflow!
dwc2 ff580000.usb: supply vusb_d not found, using dummy regulator
dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
hdmi-audio-codec hdmi-audio-codec.9.auto: Only one simultaneous stream supported!
hdmi-audio-codec hdmi-audio-codec.9.auto: ASoC: error at snd_soc_dai_startup on i2s-hifi: -22

Those 'dummy regulator' messages got repeated numerous of times, 36 in total.
The hdmi-audio-codec only appeared after logging in, so likely 'triggered'
by the start of pipewire.

Cheers,
  Diederik

PS: and now Q64-B is really up, will report that separately
--nextPart6101972.8Rv6zO9TrO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZoJx5gAKCRDXblvOeH7b
bkliAPQLar1+3rYv8f7tdO2HFwuvGYEydoJbxV2lyIWeArMCAP9L9r5vAsl9k9fH
qizWhtOGi2kgAjnCmKgjh1LZrH1VAQ==
=CEwJ
-----END PGP SIGNATURE-----

--nextPart6101972.8Rv6zO9TrO--




