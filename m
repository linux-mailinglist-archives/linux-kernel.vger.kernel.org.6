Return-Path: <linux-kernel+bounces-364524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F5499D5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E68283FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A41C6886;
	Mon, 14 Oct 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVJidN8v"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30831BFE10;
	Mon, 14 Oct 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927554; cv=none; b=YoLGmVCouJVSwDHEynavEul7bx2e4zmxFCXx9urGNmAieMF7n3jU6DHZv2HkkvFMUSVhqn1zz1PKSt3fno7F4JbJpLAtKnCLuo4iXgXPo49XaguZpI6g7ACC+eZW/k1a58KKH38sr7Lbos1E493xEC8a3zPNqOfChTZkfnaVf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927554; c=relaxed/simple;
	bh=BiWAn6AqL8nUbF7YupmT9miDzo9h2ugqfnahYsV0y+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wurg9riAac/jJzLxo2Wg6SbO9h8a/X03i3A4dQkSpbPAE2qdExoJm2lNgFzUPaX7CuwUvoQv5BuMxnY09+kWv17zxK81KN5zW0Ombg49jbCRF1D7bjy++r0AqEASeB0MjWJocYa7AT+sYex+VIoNnnlJDdPIxr4ed2uAHopd/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVJidN8v; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d5aedd177so2113540f8f.1;
        Mon, 14 Oct 2024 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728927551; x=1729532351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex9dSK9Fr9Mrms2dZEi46OXusqhHyEOAsbZ50rRI7gk=;
        b=NVJidN8vvQuiVEAUto0JstURxOp5ZeKvxZsZSVMTt+G5ycDgwmqln70bXo75Jq7TcR
         uaS2Z+7cdtcAo8Q9dMDnoV08UKaT5sSeUtyAAWKGD8a8TiVnHleTi9/yJB2OxcVrkJtJ
         swjIy5xudNZs75SoR+3lEBRC+JdEaSJpfDfKbIZwYIY8uHoTrzPEqByWHTaOwuZaJUPj
         7vPUXSOsmkrUiQN0zHP9O9yytnoCJT9fjM3110m+9vgsXVIDo2dyIh1VPIOz+nn6jl+a
         Ssb6XwctijrHw+PIkJ5EC4zh6t8XXr91guPxdbwXRhST9b+5sZG9PL/eBYArt287TCfd
         CZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728927551; x=1729532351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ex9dSK9Fr9Mrms2dZEi46OXusqhHyEOAsbZ50rRI7gk=;
        b=Q3a2w+w66VRF3bI7XansnR/OQwnFARQxz/e7b9jp9nCXTDEVElKCSnm8ywQmTCd/yc
         YazOSYl4TweUFNNuE78gWLrfb38vLxeBzd/gwkfxHOOKs8PzhRzneEhnfRHseDmlgakR
         EqmJ1zoAC8/QtkvJmsYnonO7XcwvmenW6IiLTOnuatPc7O8RORQ5/n8pPh8goQkGiwdT
         Cxx8mp/yGzlHUb/TAJN3MArnSurauxDjPfaJSDCQrX+qMZ9zSpD3zvm7ISyN7TOJPft6
         D8kHJelWS8xaNA/4oI0ttjwfZMBScQGU0s9/gyFs5Q2jGFbbZT6s/2KbH7dmfyuQYClu
         O+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQm7MH1/Y2NkPaNaO7pzTBaTqnXwBzXCrd8QfqXQud0m/QBR4w7Pc6PtapmxB6IYWMkWBflcto46nf@vger.kernel.org, AJvYcCWOvkX+hTl/UpwhoLcAtjCzewdaRK8SvQOgyK39veQikfeUnu5DZgzgAv5jLeDzy1GhrVQpm42GB76P4OeL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2v18G+MIKr73dpQxXsAa2AeffxvPnzJNqvgdMAeHazy2/sdIz
	87GNBiKWYFezSIVCJV1v+UC/LzU7Og5SXPnxh7V9ccOFnUrPnLSckp2+zNc9PfZ6Qki2idGKI09
	KPMFvoEFtiGAyNMpdS9+UfAcpz78=
X-Google-Smtp-Source: AGHT+IG8Ioyzz6mOTNODHp+6JGPrDIqTDoYoXcA8KANumMT330PJOmG1Ry29YovlxV6hBGItqkJAhM6agEIpW0+j5LI=
X-Received: by 2002:adf:ea45:0:b0:37d:2e78:8875 with SMTP id
 ffacd0b85a97d-37d552ce636mr9080330f8f.56.1728927550932; Mon, 14 Oct 2024
 10:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014113026.78853-1-cenk.uluisik@googlemail.com> <172891445477.1127378.13874736914700071280.robh@kernel.org>
In-Reply-To: <172891445477.1127378.13874736914700071280.robh@kernel.org>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Mon, 14 Oct 2024 12:38:59 -0500
Message-ID: <CALWfF7JNcNi5Gs04V5arJQEw89MJKPy6oRDxh-jdtmo-oCAu0A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: rockchip: Add rk3588-orangepi-5b
 device tree and refactor
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andyshrk@163.com>, 
	Jagan Teki <jagan@edgeble.ai>, linux-arm-kernel@lists.infradead.org, 
	Tim Lunn <tim@feathertop.org>, linux-rockchip@lists.infradead.org, 
	Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Michael Riesch <michael.riesch@wolfvision.net>, Jing Luo <jing@jing.rocks>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	"Rob Herring (Arm)" <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> New warnings running 'make CHECK_DTBS=y rockchip/rk3588s-orangepi-5.dtb rockchip/rk3588s-orangepi-5b.dtb' for 20241014113026.78853-1-cenk.uluisik@googlemail.com:
>
> arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dtb: gpio-func: leds-gpio: {'rockchip,pins': [[0, 2, 0, 245]], 'phandle': 253} is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
Regarding the "leds-gpio" warning, DTS checking script might not like
that id. You could probably avoid it by naming it "green-led". Similar
to what the Orange Pi 5 Plus does. This would be a separate bugfix
commit before any of the other changes in this series.

> arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dtb: vcc-3v3-sd-s0-regulator: Unevaluated properties are not allowed ('enable-active-low' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#
The enable-active-low has already been addressed in
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.12-armsoc/dtsfixes&id=f4d29bebaa6118c1e51e8f1c21ce2b34f43e1479
So you can avoid the error if you start with v6.12-armsoc as your baseline.

Regarding the "leds-gpio" warning, DTS checking script might not like
that id. You could probably avoid it by naming it "green-led". Similar
to what the Orange Pi 5 Plus does. This would be a separate bugfix
commit before any of the other changes.

Jimmy

