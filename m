Return-Path: <linux-kernel+bounces-415575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D809D3858
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECAE1F23D49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D0219D063;
	Wed, 20 Nov 2024 10:27:57 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA919C561
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098477; cv=none; b=NocBxFfnHw/DiqvkBajmtMgMMtJ91uvnhnjEYMdtdwh97mpdIJ9iOseZW6rBLsLyf3+reHUFrVk55yPQS/FsmMSn/Sp0Uj758MxCCWDBiIpoE2mg4eaKsttUhVxllVneAFeRDxv8KyRmvnyLI+u5fuukqb5tirOw/1jCBXm4Sp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098477; c=relaxed/simple;
	bh=8znUTrcJ10aGDjGTQ502ZNZo0QnZtBBWFxtfF0TTNpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cja8uypwkO6U5xsxqVk1tmdMUL/rKIoKwxjaJmFzzhNCyZwdvV7JlVe30dg1ba3grNuzq7exo1rCMf9a0oOXE3eax4/mm60OCUKWDjHl4d4dw7xdNITRe0RgcrEKN32h06b8+yr3u0RmEtaU/o0Jin/fkiBVDlZXyIZ5wIpjwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:35da:ab43:467b:7991])
	by xavier.telenet-ops.be with cmsmtp
	id eyTr2D0153gUftr01yTrbZ; Wed, 20 Nov 2024 11:27:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tDhvk-007bjq-FD;
	Wed, 20 Nov 2024 11:27:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tDhw7-005PUd-NR;
	Wed, 20 Nov 2024 11:27:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-riscv@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] riscv: defconfig: Disable Renesas SoC support
Date: Wed, 20 Nov 2024 11:27:50 +0100
Message-Id: <d33c9e3245c0bd3073d9618fcd014ba37e90e6bd.1732098271.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up to commit e36ddf3226864e09 ("riscv: defconfig: Disable RZ/Five
peripheral support") in v6.12-rc1:

  - Disable ARCH_RENESAS, too, as currently RZ/Five is the sole Renesas
    RISC-V SoC,
  - Drop no longer needed explicit disable of USB_XHCI_RCAR, which
    depends on ARCH_RENESAS.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Apparently I forgot to submit this, probably due to Palmer's version
https://lore.kernel.org/all/20240917131936.18980-1-palmer@rivosinc.com

 arch/riscv/configs/defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index b4a37345703eb357..db0ce2c2c766ac15 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -27,7 +27,6 @@ CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
 CONFIG_PROFILING=y
 CONFIG_ARCH_MICROCHIP=y
-CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_SIFIVE=y
 CONFIG_ARCH_SOPHGO=y
 CONFIG_SOC_STARFIVE=y
@@ -201,7 +200,6 @@ CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PLATFORM=y
-# CONFIG_USB_XHCI_RCAR is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.34.1


