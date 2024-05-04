Return-Path: <linux-kernel+bounces-168835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF968BBE4D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 23:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E41E1F21A35
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221784DFF;
	Sat,  4 May 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UAyFJTvW"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33584A3B;
	Sat,  4 May 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859640; cv=none; b=uNE/naIdN7rFBRrwpWVf92NNTYabK0FjkYAwHfA0l7rSKkDgWNagLKcaskpMe/WCeO9CYmxdwQCeYOX6hCv1lCHO5PSPFgedHgC8K0UB2h5/W9iTFlKgWHyppnYkKq+HXOFwVJ9g1XNxS4gRYPqZXJjaEq7qyQT27EM578L0Ks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859640; c=relaxed/simple;
	bh=Lbd9h9fyf6qjaznMGYu8NxemuE2XQ2+xuJbphMSkPgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P5nHNgSPik5oL135HZjcp4gCS4FB+oKj4Y7RgSOLMWdHKOXDw46zDML0CZ6HBko0fmb50BDRz5G7Nurz+yT5fqBqtY5FU8RCpTXwg2GpjvjksWfpqB6oco/5APSlfgZtiMMCKiGIyTV4RmqY918jgHq/4jBNBLS+bKIGKhjQhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UAyFJTvW; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKH-005iKn-1n;
	Sat, 04 May 2024 23:53:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xvYaGTuF/6wQRn8KjheRFB/DLsoyzjpsksw7wGYd7jQ=; b=UAyFJTvWgpoK8/3xLGb+pVk5nA
	6uYt6Egv7WGQGA5HFkz+AkJfgPDmL8UhMqsaFOuud0hkFffZoub/SgBGBBFkwWPLnZ+37Ns0tkUs1
	a/bjKStf+UPg/ltvZYTvxCxCZN4YlAzYbzKl/VBxPzPFTaih5V8KK8VUG56unyVUxP6FxNzPa79E0
	VHfV/8u1EN27DfnxIfZrts6xvhg3RKh2QgmKpi2KSw85Xx5dze2uBLPN84rfxE5Vbc8WK4I8KIYvJ
	fBT+QzXVhDb3/UT2fTuS1qHOM6YdYTgtlYh3oQRIbtJKs7NdHxbsBkZdQNOh/pWqo0U8CDRBiiZw0
	5ue35iUg==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKF-000aXe-02;
	Sat, 04 May 2024 23:53:48 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKF-003c4b-3D;
	Sat, 04 May 2024 23:53:48 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add Kobo Clara HD rev B
Date: Sat,  4 May 2024 23:53:43 +0200
Message-Id: <20240504215344.861327-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240504215344.861327-1-andreas@kemnade.info>
References: <20240504215344.861327-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a board revision of the Kobo Clara HD with different regulator
setup. Since the original compatible seems to be found in userspace
in the wild, keep it as a fallback compatible.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0027201e19f8b..8dda627cffd84 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -609,6 +609,12 @@ properties:
               - kobo,librah2o
           - const: fsl,imx6sll
 
+      - description: i.IMX6SLL Kobo Clara variants
+        items:
+          - const: kobo,clarahd-b # variant wit different regulator setup
+          - const: kobo,clarahd
+          - const: fsl,imx6sll
+
       - description: i.MX6SX based Boards
         items:
           - enum:
-- 
2.39.2


