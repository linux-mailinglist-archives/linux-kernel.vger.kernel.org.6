Return-Path: <linux-kernel+bounces-409345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8E9C8BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3327CB24CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D4B1FB74E;
	Thu, 14 Nov 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GcuLMt8q"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232041FB3C8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589892; cv=none; b=J7vJN++tEDgw5/3LIVat5sGRLRO4CL+JRtiW/if/j2+P7Zmhu/wUg4VMU67GoH+piqgwzYWYA8JduuxJ/kHQaeK+O2KeACG++OCERomZKn1Pa8HBiwzys6143Mkw9VARNEjoHBWdNrgsliQErzwNx4FGg7CfOwVxTosII/pMTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589892; c=relaxed/simple;
	bh=JEQFB/z2hNlie1SztjEeGI/G+tH85U7TiDPd64mZoqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdhtjSAUW27HAUOBTXs/NhB0/4cB0VeWKYI3kPEbSG7Kj3E1gvWd24BB4N+o0Xz16i7KitxRrUfK6uoo6QLt2uAJOw1fIKij9MDgWGKUtTBHTynpk5vgTOsqj06HfjEB+fQ9WiSe2h0CoTV3KUrRbDqd77+IZD7W2LuLqcN0GaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=GcuLMt8q; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731589884;
	bh=iKQ3hFaNj1tO8Sd5kK/B33uo0idb6gnoDTS3R6ggsjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcuLMt8q33FJ4E/hQygjJHhuuxmwIacc66hzuqQHcREYEbgobABlaAa7MR+0xyQaZ
	 96QopqKl2B94GAm9JxSfAK+RnA+AUE/hxTYT16lYMpmDmRfenR8OHgRZBVBGbGmWe1
	 8psvLci8I+5nbYulCLhxLTvn1x5WdNxN7FfNUVEs54cbZqkvRpOfKDsWPDRlmN33PS
	 656ejgFOSSDWVzxzsSgS98WaRKDGUDNduJvJdQzeJ23FLrS6z/Iy2Eq8w3e8xJbNwV
	 ty185Kad4eapmmLxmXE4EXBp04HCmZDktAwKYB0wzgS4rSWnkuVzZA9NLQWj6+6gX/
	 v6U4AoZM8f+Zw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0sS4Hkqz4xD7;
	Fri, 15 Nov 2024 00:11:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<geert@linux-m68k.org>,
	<arnd@arndb.de>
Subject: [RFC PATCH 07/10] powerpc: Remove CONFIG_ISA
Date: Fri, 15 Nov 2024 00:11:10 +1100
Message-ID: <20241114131114.602234-7-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ISA support depended on PPC_CHRP which has now been removed, making
ISA unselectable, so remove it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                  | 11 -----------
 arch/powerpc/configs/chrp32_defconfig |  1 -
 arch/powerpc/configs/ppc6xx_defconfig |  1 -
 3 files changed, 13 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f79e28f47dea..958e227a3cbf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1083,17 +1083,6 @@ config ISA_DMA_API
 
 menu "Bus options"
 
-config ISA
-	bool "Support for ISA-bus hardware"
-	depends on PPC_CHRP
-	select PPC_I8259
-	help
-	  Find out whether you have ISA slots on your motherboard.  ISA is the
-	  name of a bus system, i.e. the way the CPU talks to the other stuff
-	  inside your box.  If you have an Apple machine, say N here; if you
-	  have an IBM RS/6000 or pSeries machine, say Y.  If you have an
-	  embedded board, consult your board documentation.
-
 config GENERIC_ISA_DMA
 	bool
 	depends on ISA_DMA_API
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index fb314f75ad4b..88eae3fae0fb 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -20,7 +20,6 @@ CONFIG_GEN_RTC=y
 CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=y
 CONFIG_IRQ_ALL_CPUS=y
-CONFIG_ISA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index c06344db0eb3..350167bf6d00 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -66,7 +66,6 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BINFMT_MISC=y
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
-CONFIG_ISA=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
 CONFIG_PCCARD=y
-- 
2.47.0


