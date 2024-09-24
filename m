Return-Path: <linux-kernel+bounces-337116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B702F984598
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C503281034
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F2C1A7249;
	Tue, 24 Sep 2024 12:09:45 +0000 (UTC)
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579211A7065
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179785; cv=none; b=oN+Bg0ZDsTBoACECAgY/cHAdHrMp0R4yTi2nFEk4VtkLa+B0G2bxp0m2VVuOc+lOZ+OfdAmBUHigcbnsTTFk3AwpLYc0YQUcMbk1/WV7SGBbdiMvPP2wv7FnJgFPHuGs4ySN9la6UZlFJbMcUbSw4cLGqZGeO80XaFO6j7nV9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179785; c=relaxed/simple;
	bh=veKkp8CG3VFXFr0Z3odf3+jzGjGnsTggAkUJYuMiK0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lfDUFM6/XIVAknunxGXexiZA44eDEqDD7WUMaXSiV8ISkKhV6HrabxzbYsbHROmYnARZbWnMcfW6gliswIhMm6qNHDmL6pxmLVuAJ1o7Aohh01I7ALf/L24LMgR5ZKUw8fVnDnVcU5os3i2oian9WZMB1KmgI2KeH0WSuU4z7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4XCdvn2SyYz4x9fm
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:09:41 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:beb3:bbd4:b9cd:84ae])
	by andre.telenet-ops.be with cmsmtp
	id GC9Z2D0033rtkie01C9Zk1; Tue, 24 Sep 2024 14:09:34 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st4MD-000Suq-77;
	Tue, 24 Sep 2024 14:09:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st4MH-005j2d-2R;
	Tue, 24 Sep 2024 14:09:33 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Seth Forshee <sforshee@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] brcm80211: BRCM_TRACING should depend on TRACING
Date: Tue, 24 Sep 2024 14:09:32 +0200
Message-Id: <81a29b15eaacc1ac1fb421bdace9ac0c3385f40f.1727179742.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing is disabled, there is no point in asking the user about
enabling Broadcom wireless device tracing.

Fixes: f5c4f10852d42012 ("brcm80211: Allow trace support to be enabled separately from debug")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/net/wireless/broadcom/brcm80211/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
index 3a1a35b5672f1a27..19d0c003f6262675 100644
--- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig"
 config BRCM_TRACING
 	bool "Broadcom device tracing"
 	depends on BRCMSMAC || BRCMFMAC
+	depends on TRACING
 	help
 	  If you say Y here, the Broadcom wireless drivers will register
 	  with ftrace to dump event information into the trace ringbuffer.
-- 
2.34.1


