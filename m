Return-Path: <linux-kernel+bounces-575428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03657A7023C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BCE19A44A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829525A63D;
	Tue, 25 Mar 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dxreNc9c"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8625A321;
	Tue, 25 Mar 2025 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909437; cv=none; b=Jj6KmT4MgtNCH2RDkF73N8ABPLVWrZzlw5IOtnIg66+6CYKgxzjGisFcUu8HxUfCgwDKimnWzpeVUa/z2gMcB+JXFD6SndU63ZwKdVCncX3pAHdhZGY3B1Z5Ui5M6p+db5rZn2oRH3zXGyue2TYos8GWAivIWhXoZ+HMip4LNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909437; c=relaxed/simple;
	bh=OU/efJ9Il/WVme8B/pCmQ/KSNe5EBz1xOBv4e+2M7mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnFLz8iwwyH3uaYzbfmff8DNrmvO0LPnneDnDkeaBsbyIsC9Jb14IVSUouMY+LWwtKhOtB0NLYQ4v67ZDorDbmiP4okcJbeQPTs5vHYnDAJmpLGE6OMglxlWHkXv1KBU8ql3l9O5U5J44nnZl7KvfB9WewgpWGM2cNADlhPp188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dxreNc9c; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=3ucf6
	AoqLVgzdE7q3wAWYQlze/5NWs4H0gsNuLMxD1E=; b=dxreNc9ccopxYG01xgXf4
	/H+rax6ja1dbu4x7Tml1Gi1mxwvl30pxLoNj8lu5dvHci2tyvABU8VUrjHWs3gO3
	G640giOhtilpMw/LxyvgFB05eTSoSBwoUP7oZ5Tm6xPGTKminiwCeq6njim3Yozm
	+3B1a/roYWau4zgGiwIEzQ=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnc2bLr+JnWNnrAA--.35530S2;
	Tue, 25 Mar 2025 21:29:51 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	hjc@rock-chips.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 0/6] Two fixes of RK3036 HDMI
Date: Tue, 25 Mar 2025 21:29:34 +0800
Message-ID: <20250325132944.171111-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnc2bLr+JnWNnrAA--.35530S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF47WFy5uF1rJF4fGr48JFb_yoW8XF1kpa
	98Ca98Xrn7G3WSqrnIyF4kAFWYyF95Gan5GrWfJw1xAr4Ygw1IvryagwsYvFn8C3WxZasF
	yw18KFWUCrs7Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1HqcUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0g0bXmfirF9iZQAAsr

From: Andy Yan <andy.yan@rock-chips.com>

When preparing to convert the current inno hdmi driver into a bridge driver,
I found that there are several issues currently existing with it:

1. When the system starts up, the first time it reads the EDID, it will
   fail.
   This is because RK3036 HDMI DDC bus requires it's PHY's reference clock
   to be enabled first before normal DDC communication can be carried out.

2. The signal is unstable. When running the glmark2 test on the screen,
   there is a small probability of seeing some screen flickering.
   This is because The HSYNC/VSYNC polarity of rk3036 HDMI are controlled
   by GRF. This part is missing in the current driver.

This series first try to Fix Document in the dt-binding, then add the
missing part in driver and dts.

Changes in v2:
- Included the HSYNC/VSYNC polarity fix

Andy Yan (6):
  dt-bindings: display: rockchip,inno-hdmi: Fix Document of RK3036
    compatible
  dt-bindings: display: rockchip,inno-hdmi: Document GRF for RK3036 HDMI
  drm/rockchip: inno-hdmi: Simplify error handler with dev_err_probe
  drm/rockchip: inno-hdmi: Fix video timing HSYNC/VSYNC polarity setting
    for rk3036
  ARM: dts: rockchip: Add ref clk for hdmi
  Revert "ARM: dts: rockchip: drop grf reference from rk3036 hdmi"

 .../display/rockchip/rockchip,inno-hdmi.yaml  | 20 ++++---
 arch/arm/boot/dts/rockchip/rk3036.dtsi        |  5 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c          | 55 ++++++++++++++-----
 3 files changed, 55 insertions(+), 25 deletions(-)

-- 
2.43.0


