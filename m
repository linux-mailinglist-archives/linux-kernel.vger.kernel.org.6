Return-Path: <linux-kernel+bounces-202025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6918FC6BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6781F227F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308DE1946D0;
	Wed,  5 Jun 2024 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="n/Tx3AfR"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8611946AE;
	Wed,  5 Jun 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576797; cv=none; b=JCf4x2Bj1YtikhstIL/jQQrZt85B5nb5IlYV+JC3UcPk++Sfim7Mq7iXOHJ9Kfw7W30QgYM2ZKgHooGe2DErD2zqGo9XpC7CBItVDMNLDYhfBvsxRf+nVA8okcIo7z4JUjOMyKgTsOOwBiFR7uGvb8+7OO85exQq72w1cNRnhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576797; c=relaxed/simple;
	bh=22MaBtZi5AInBLEVS80SS3Joqf+eQ6RctsUOZeLFvmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mo1ux9NnpE/L0gU+UddKifgXJciezGbWtCWYaZNmRiSWlvZ6tvscVh0htlsN2RNQjiC/v+fugj+F4wUBVrOCATJc8e71Yh2KgttoLzGunMHnr55ecUC5ZIgyG5/r9FbHEwsOg/xmUMokQZEq1iGGZ1Ycy5IJl/TtO57Py6hEjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=n/Tx3AfR; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sEmBU-008sYN-2y;
	Wed, 05 Jun 2024 10:39:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s1Dqt3Ik0d9VyS97+X6CEVzkr11OOcW3uaWdRrpb+wA=; b=n/Tx3AfR+zPH2/oex4MrmkIDxk
	0IYxBvtJwLGL9XVkk1xxuyW7Fxx+CbgsgTNVmAw7osMA2ax7ylm28WkA+AanzstKLs3HOudHJNUN1
	OdhGDCPU/07SZqr7oaUmzVNtiY5bdM8iJcH1JHJD+k/kZR4KDCseoR8kazkxPD8Fru+5unrQ+JDjj
	5i1c49w2kSQvdaGzVbeINuvf+EHQGK5SF9HxPto1uvVphpoUaOqS60VqrkBfjf6VN279kcGkuLfzc
	UiItU4Dgv9Pj21vxjo+SawsB9acFUrvXrd6uUZ9ogcF/zNdhGdAD7aR8lWlgdO+oKCA4/7IH5Kpex
	LDokabzw==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sEmBT-002fSw-2J;
	Wed, 05 Jun 2024 10:39:52 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sEmBU-000YzE-2N;
	Wed, 05 Jun 2024 10:39:52 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: e60k02: fix aliases for mmc
Date: Wed,  5 Jun 2024 10:39:50 +0200
Message-Id: <20240605083950.134479-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit fa2d0aa96941
("mmc: core: Allow setting slot index via device tree alias")
mmc numbering are changed, confusing boot scripts. Fix that by adding
proper aliases

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Well, this has lingered around a long time in my branches and probably
used by virtually everyone using this devicetree.

 arch/arm/boot/dts/nxp/imx/e60k02.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/e60k02.dtsi b/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
index 13756d39fb7b..0029c12f16c8 100644
--- a/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
@@ -14,6 +14,10 @@
 #include <dt-bindings/input/input.h>
 
 / {
+	aliases {
+		mmc0 = &usdhc2;
+		mmc1 = &usdhc3;
+	};
 
 	chosen {
 		stdout-path = &uart1;
-- 
2.39.2


