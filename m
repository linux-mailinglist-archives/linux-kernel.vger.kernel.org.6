Return-Path: <linux-kernel+bounces-511946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8FA331DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E1B188ADC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546CA2036ED;
	Wed, 12 Feb 2025 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RwrY2tJW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DA1EBA0C;
	Wed, 12 Feb 2025 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397772; cv=none; b=OjBUX5uch+RuW+F5b2YYVPtZUZ8M+FcmRU17V9W80vkYoFpmI5zFyPQvbZKFezVU/Ky1NnzXtYsI/ly6abmro2Ueerqaquad6G8AEgP+K8dQA0B8+FmtPtIiKnXl1c+9iF+klsn1LAYGzREG+WvyzvUI8aZJv5MRex26naZ3ACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397772; c=relaxed/simple;
	bh=2uo7IfeiuOXUi0myVVwnmI+JmegC4mWq+V748nOaNYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WlT9UrGO9CDEnCPn9l+tWwGjhRdB2uYz0dzQbFEr3g7IWOjvA85E9iD+u8+5R4Cs4hqtMv63TUx/p7oOV6tcoAjCGDnjYYa7Cg/SAS1PXIupKZcBG6cjn5EJNxkm+Kq214ZsWDEKiYT+XyD1bTp9P8ER3FxFix0pbIMe6Nt9gt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RwrY2tJW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739397768;
	bh=2uo7IfeiuOXUi0myVVwnmI+JmegC4mWq+V748nOaNYs=;
	h=From:To:Cc:Subject:Date:From;
	b=RwrY2tJWxCkgV7LvDs4ThiXuOybb7OsYoH8G4TA67PXuqzXDswZfaaA8A30b9VN37
	 DprhJ84emcYIM7VnkpHgI0cDNjohzqFNBCofH57DYu2sgepvTJunDoN3hf0qMi9rC9
	 s7RkI7pmeUrQ4Q2s15qK5elzbvAj65dODWbFCQk8amHzZTsCwW3N4c1v9DFGslvgQi
	 oEqLc3Qh657novN9qi8L17Zx0+TRm9gLnowfe4QuFizbIpVnb2FwPl5a2/zFA87mkg
	 3KuNgqaquA59148HTMB39OyNzXA6pYQFozmdoTKXCZB04wrsOPPOk13jpdE50jR6V0
	 MVDVawmnT5PFA==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3565417E01B3;
	Wed, 12 Feb 2025 23:02:46 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chris Morgan <macromorgan@hotmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Stephen Chen <stephen@radxa.com>,
	Weizhao Ouyang <weizhao.ouyang@arm.com>,
	Alexey Charkov <alchark@gmail.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/1] Add Radxa Rock 4D support
Date: Wed, 12 Feb 2025 16:56:48 -0500
Message-ID: <20250212220236.116383-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the basic support for the board. (Not officially released yet)
It is based on the Rockchip rk3576 SoC, so I haven't added the
following devices yet:
 - VOP/HDMI
 - UFS
as the support for those has not been merged yet, but are close to be
and I already validated that they work.
It will come with another patch set.

The following devices are supported and working:
 - UART
 - SD Card
 - Ethernet
 - USB
 - RTC

Stephen Chen (1):
  arm64: dts: rockchip: Add Radxa ROCK 4D device tree

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 649 ++++++++++++++++++
 2 files changed, 650 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts

-- 
2.48.1


