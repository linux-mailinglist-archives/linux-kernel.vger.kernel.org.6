Return-Path: <linux-kernel+bounces-543903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC4A4DB42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582361882DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BD21FDE1A;
	Tue,  4 Mar 2025 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="c8zaq5o0"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F71FC7F8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085314; cv=none; b=piwT97eqYCexWckSPkwEuSOSfQ22PNpBOU07yvhi+suh67VPCY+Tk8CmampOgOpEzH2Penx4cBVRj2X0b21tAlj2y9dRWA40TWrQY4q+NWIPdlkjg6Whp+IHlIz1OI8oMbu0rS2+6v38uHi5QCso1guYCNkZjpfpx2b1oVjkPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085314; c=relaxed/simple;
	bh=xkWdbiE5pDA61A/wnO9/ukqrTGMw8FiyU8xHAw9+pqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOuVgpyfj2uiuljd+zSL+NRMoL/B1gzxXRTeL1ZAqYTwuUTZWoXtT+6sR1SX5+JtCNt9DOjYQbEEtePEYLlqpCho1WXiaply3UonhhloSaNmVwc+aFEz2GQW+YFeSwN22RXf0IAie7+I5JgXRt60j5yrZDbpkdFrpDSIVcnegNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=c8zaq5o0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3911748893aso384673f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1741085310; x=1741690110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XPB1HGwlRjHpgwyLpPMHl+9QLJ8Tbr4jECS3aE3w44=;
        b=c8zaq5o0GWmARYH+vGwIpqIf3n/TAeygB8v/v1ddG441JtsE5nQ9EKOK852iDO+rEr
         2gm4M3eUjD6WalkjaUIUbKOiArF7aC3lCOzFvikwWQwROffuI6yrhL2ZRo8AyryM9UEI
         Xf5oy/XTDwVK9mNtJwkXMaXMBLof7RKr144xqvBEfM9QrUdjr6ZHFhJ2mhSK+krotjjg
         gzVBXmrN71922E88ahSHBz3DT1bq6RmFPr/VI2GaToMCL5ujOP+nwVZH3AEcqqdNMLj5
         jjiP8kggZMc9SQUgq6j621rDM3HllJG7AQ2Oxcz4rkxcW83pwTnvfc5YZGzbf7siPJ5P
         Gx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085310; x=1741690110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XPB1HGwlRjHpgwyLpPMHl+9QLJ8Tbr4jECS3aE3w44=;
        b=JySh9Tc3F9gfzVJnv0ELTTtBQ4Ds/0rQHoMhWEvw4JWiBn1I+012tb8pjlaP3COEFM
         zKXgCdSQwmiOWTGbVPRCEOfdDLMcOMR/Ql7WL3zJJz/MAjWxRuLyuaa5GDWM7kjL9bv7
         AUqvzoubmWfajFutLblXpU9SSCUz7XkkbMHMJ9wOSgj78s5c4fCWIZckazxjJiosHkKi
         +6mDhYNewBDWonU1YnVxW0Pxk8123M6Ab5/pSTiPbtt0WhBtQPJvSyEqmZzzMQ0IBnBh
         8Kej9+Fv6MbiEE55NYEYOmYgzYnIygF0vNZDczQqUWoAKxFf5JvaIs1jsmqUSJAr0swd
         ATiA==
X-Forwarded-Encrypted: i=1; AJvYcCXs9l4Xk6MTJIftWXkGf3MiM7GkG2rsguLObTVe6aihd82AyEdltjnqUPWYXaXq/vOXvSo5pwfVGWhXc4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ialFdtleaVkZnK0iCqKjE7bDP33ooJyGB8exJ8lrb07eKes8
	RpbTcrUrpMuIBQyEkcnT8Nn4wLR2ucGBY3leJik75WznAR8bQAP4dHA28l1A6ic=
X-Gm-Gg: ASbGnctoOpQwRnJLajvsSDoFq75ZDzrJC+6WdZwSh2SBNKYVcIZzXxQjee6UPf6cG2v
	HZLPH6aOOaOzdUmUPQ1C7eOMU/NQXNP33hIm2NvJsRUY876TZ35onVpYiH/6M3dl3kYO6TZIdTn
	TBAAWWpnJnO/MaoISpcaGwbnFW3dVdG9qEbQ4+0xbiSVXq/7fcFKdwB9rjaxPF/5M/xLUMhg6oM
	07ZPrhmFCXkHWofluAPFY1ygqDPVvuNWhhe4UQYs1NO+ZXfKTW7gEivjDX9aNgHiYgPmfNIbxVS
	gdAgWWRkx6fCs+LXncyQx0fYDsX/fI89+boySSJZajrimAX5IEfhZt7yRYDOYzfKEW2nxMSjMmA
	=
X-Google-Smtp-Source: AGHT+IFVrf0sQSW1RaHIuqMe1zsgZYOxQjalOSZJpBfpyvJNxn0RgZcyjbBC1AuujFsNmEiAisqIpA==
X-Received: by 2002:a5d:5f93:0:b0:38f:23f4:2d7a with SMTP id ffacd0b85a97d-390eca070a7mr13797386f8f.40.1741085310559;
        Tue, 04 Mar 2025 02:48:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a38sm17445161f8f.75.2025.03.04.02.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:48:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/5] phy: renesas: rcar-gen3-usb2: Fixes for Renesas RZ/G3S
Date: Tue,  4 Mar 2025 12:48:21 +0200
Message-ID: <20250304104826.4173394-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series add fixes for the Renesas USB2 PHY driver identified while
working on the Renesas RZ/G3S USB support. These changes are
needed for the upcomming RZ/G3S USB support (especially for the
power management support).

Series (with [1] on top) was tested on Renesas RZ/G3S with consecutive
unbind/bind and data transfer tests before/after the unbind/bind.

The unbind/bind was also tested on the devices with the following
device trees but w/o checking the data transfer (as I only had
remote access w/o USB devices connected):
- r8a7742-iwg21d-q7.dts
- r8a7743-iwg20d-q7.dts
- r8a7744-iwg20d-q7.dts
- r8a7745-iwg22d-sodimm.dts
- r8a77470-iwg23s-sbc.dts
- r8a774a1-hihope-rzg2m-ex.dts
- r8a774b1-hihope-rzg2n-ex.dts
- r8a774e1-hihope-rzg2h-ex.dts
- r9a07g043u11-smarc.dts
- r9a07g044c2-smarc.dts
- r9a07g044l2-smarc.dts
- r9a07g054l2-smarc.dts
- r9a07g043f01-smarc.dts

Thank you,
Claudiu Beznea

Changes in v3:
- collected tags
- improve the validation on the code that requests the
  optional IRQ as suggested in the review process

Changes in v2:
- dropped RFT
- collected tags
- fixed checkpatch.pl warnings

[1] https://lore.kernel.org/all/20250219161239.1751756-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (5):
  phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
  phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
  phy: renesas: rcar-gen3-usb2: Lock around hardware registers and
    driver data
  phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
  phy: renesas: rcar-gen3-usb2: Set timing registers only once

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 135 +++++++++++++----------
 1 file changed, 75 insertions(+), 60 deletions(-)

-- 
2.43.0


