Return-Path: <linux-kernel+bounces-343830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451498A009
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F432872D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361A18DF83;
	Mon, 30 Sep 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cSN/3WpB"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC218C90C;
	Mon, 30 Sep 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693987; cv=none; b=UrjfcMCKkPGs+kgpd+kX6AhCk6oI44Sz6ZvksLVpVRPpNUh9PN5jCYu1Cw9CAOgr0LC1kHbQ/v5BQelhLDkwXtUgnixZpRGWjbmZoG+e8mcLSwrkRRc89QrjgExKtpwVb45VS9yRJR8KSBKKJq6Ism8Xc8Wnhad+ESyb8td9Uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693987; c=relaxed/simple;
	bh=WOc97UCCGyQRfx7LAEB431Lrt7TpwBgdtVrjwn7RTo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ee4X73z0HthDdVXQvrn2ZzzNK5/PFWQikz9w9JyjXkxwx1dXi0Pv0vQ5xjD+ALiwAUXUIrNzBRyyEo9S3IJRdpAXHxYEQ1NQ3vfE/zHoqPSHIcZzq54Qe6fepfXnguKVQ7qJ3uya9r36XZ4Zkm3FXjXVh4IY2ERYiMOXPjsfrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cSN/3WpB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s/tFBH3w644dH2BiF2kIdHGJ0YUc1jK2OUYdmfOhNhE=; b=cSN/3WpBNS/Bws30ayJ61/aJSc
	16KqsPgoI4vZWbH9OoNggjy5Gm6BP5rJ91dciyOWBZGfra3dkk59GL37fHr7WA+YM1oo8HD6adRKz
	4XFBPhMKXvFhQCb/a6AHSkdieM14WAs546AAPhN9+JDNh5kCdqD4G7BTbfbTNmdkK8+AgWJy/MwQD
	5wDdTO8U2RZ5paS9DRuROBRu/zVkhwXFChW7PLlWhGUgxbEoCGiFj6iQ5uEgAA5R/IUgWEBhkJDQr
	TlTxkonf9Sl7FpEYM5mECsB048Wl5KEvXlLAAerbIVeNfSEGv3u4GGBXa2gd769zA/u32jpshwk7A
	X1lJ+ltw==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4H-0004Xd-Ei; Mon, 30 Sep 2024 12:55:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 0/3] Add support for ArmSoM LM7 SoM
Date: Mon, 30 Sep 2024 12:55:42 +0200
Message-ID: <172769365132.1880381.4548404807222807004.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918165008.169917-1-liujianfeng1994@gmail.com>
References: <20240918165008.169917-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Sep 2024 00:50:05 +0800, Jianfeng Liu wrote:
> This series add support for ArmSoM RK3588 based SoM and carrier board.
> Devicetree is split into .dtsi (LM7 SoM) and .dts (W3 Board).
> 
> Info of SoM and carrier board can be found at:
> https://docs.armsom.org/armsom-lm7
> https://docs.armsom.org/armsom-w3
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: rockchip: Add ArmSoM LM7 SoM
      commit: 7ad3206b822a69208a4ea47cc1f2cc69b120b513
[2/3] arm64: dts: rockchip: Add ArmSoM LM7 SoM
      commit: 4b6167b3a00fc0eab259484a052be6d53df9b827
[3/3] arm64: dts: rockchip: Add ArmSoM W3 board
      commit: 50c51bc28a7d7e7bb28b40ec3948ae73410bc2fc

With some modifications:
- convert underscore to dash in leds
- some reordering


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

