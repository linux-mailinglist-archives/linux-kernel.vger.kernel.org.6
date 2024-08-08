Return-Path: <linux-kernel+bounces-278994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1DA94B779
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8981C203B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167018FDB0;
	Thu,  8 Aug 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z+UWNq8u"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9018F2DF;
	Thu,  8 Aug 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101127; cv=none; b=jhJXy0NyR8KMRnjx+D4YkAuLsSjruE91P/2bfwYVszoEhO9fKfnHEJ2t9EGwQdfae36wvO7OOozguLnwh58iNl765/JgEvd3kmS8g3wxH8yi9HSBuK5JH96Qg9aaH4RrUl23g8F4mGmGanbIPH1szvE2XcQP5DUfXEUV8QNn1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101127; c=relaxed/simple;
	bh=3+qtmqX+chTgMnupCp4PL29bqLHG+9zZC2Ulx4NMLh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfDjUCzYu6JdONhwYFe93/OyuMJ6HedQY8WhCyDhtmqvpQx58SVEaC2LjldUqQb0tmcaPOcgLqZLTGOVG25vk4PpMgcsnYLxS4djIjM7+v4xbbWdowB6CFxDQ+5US5QLExN3qmWOwR5RkPuZzjkUYY3Z9a/ue0Y5oayx8exzTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z+UWNq8u; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5885CC0005;
	Thu,  8 Aug 2024 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvEzUuiCOfnh2DPlfnjuHlcRxA+Sue8P0D/mhBqQDnk=;
	b=Z+UWNq8uv1pq0TUX4H5voOmDBVl8x/MPz9w6l3L73FHIuPMV9YtfiOEZepyXONGiCvZ1vk
	6aDR5KYETFA+53l4xc1z7CH115CfwjBE/Af+cHa53Bl1kxqf+DnE2+47dd2EWzLmWO2Q+n
	OwXAVVUEmukYtqLZrvLREcmQpD+lmNU7csWV0nlqRapnsDMduIIFV4rkNLifRRYeygfXaj
	aRUQgJVbzh+h8yrYOR02YwJQpZrekJTq1iaFzNveLuEP0fQbX7zyL/TKZ44gzVN1fY/mqs
	x7wmX3+pKUqzRTyQiPEV069cgBbry1xY4llc7Xni/uzfZQifSf2qhpf53deGmA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 33/36] soc: fsl: qe: Add missing PUSHSCHED command
Date: Thu,  8 Aug 2024 09:11:26 +0200
Message-ID: <20240808071132.149251-34-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The PUSHSCHED command is missing in the QE header file.

This command is supported on MPC8321 and is used to modify the start
address for the task running on a given peripheral. It is needed for the
QMC in order to perform the re-initialization procedure and so, ensure
the correct UCC setup in that case.

Simply add the missing command in the commands list available in the QE
header file.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/soc/fsl/qe/qe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 629835b6c71d..8f967d15e479 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -469,6 +469,7 @@ enum comm_dir {
 #define QE_QMC_STOP_TX			0x0000000c
 #define QE_QMC_STOP_RX			0x0000000d
 #define QE_SS7_SU_FIL_RESET		0x0000000e
+#define QE_PUSHSCHED			0x0000000f
 /* jonathbr added from here down for 83xx */
 #define QE_RESET_BCS			0x0000000a
 #define QE_MCC_INIT_TX_RX_16		0x00000003
-- 
2.45.0


