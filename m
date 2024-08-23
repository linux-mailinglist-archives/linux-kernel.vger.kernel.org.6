Return-Path: <linux-kernel+bounces-299210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4396595D191
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7634F1C220CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BAE18A94F;
	Fri, 23 Aug 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="h58cQZqW"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BAA18892E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427362; cv=none; b=XJ6xwh1GVWXl1iId6vv4jlZ5lVgVTjOvEtvWscnt/IefXNkkfwQvQ0M0FR6jYhzN9Lal2y54pPN2ljjPP21aIp0vq0IzAr+THLZ7CYvRzH7xM8sKnXMge2VFb5kMY6Ukozy3OyfZTXYKBwCKIHEwL4hinaf45TeVh9tFz7KD31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427362; c=relaxed/simple;
	bh=NdEvoB57CFSCUVslQzJFyW04yg8jIdDlAxY/1vtsX9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OymKyIMroAbCQH7zXDnq/UCwQjKg/l0khc/8FS30vmFovh5m9VeOz20hW9BdBGJnJBxsGmFDva0IpX5WyxplKgjtwJbKiRpPfr3bQQFpZLglemFxsEZZHSlU/oa0OuBv0FMToCAYi6bKMcfRCRxFhA6Q6OUSYo/ddXrL13emiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=h58cQZqW; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id hEuZssVVEvH7lhWKXsSFN1; Fri, 23 Aug 2024 15:36:01 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id hWKUsnsYFeCxMhWKWsnG9d; Fri, 23 Aug 2024 15:36:00 +0000
X-Authority-Analysis: v=2.4 cv=M/yGKDws c=1 sm=1 tr=0 ts=66c8ac60
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=yoJbH4e0A30A:10 a=vU9dKmh3AAAA:8 a=4uBLznlVahHWhnoGBvoA:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GFh4qRuUJB0rrMs4T9RVkJerrRO8OYO4En9jGqxlD3Y=; b=h58cQZqWgaqWJE2GIGhYjwwR8B
	wDTc4ZTzz+PMaPqUrJbGHtVMbfXdWqcv6dnoZdcD1um3PjeBVjV6N76bHopmZiQ9dItC9KXVvov2y
	Khg6Rme5M2xenJM+VmlM6Rzv4/DS6lP5wDLaUp7sb9M1su22AyEODNBBCAt87D6rmvi/KA43R+i5K
	q9THMY4EdyTCgGCRgyDC53j8wN8QlgTzv57OJSC4UBjHe6Aj7vrEce2HH6FIFjkUZP3p0MrZ9ZPgQ
	vYAhPsow0dMui7/nWglpBgL8J6bBB0nT9hjy3TqrjnDNrLJHkl1Tk+ttgBozx7ePI9cpoPaIXTMvR
	qX7/uGlQ==;
Received: from [122.165.245.213] (port=53684 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1shWKT-000GB4-0J;
	Fri, 23 Aug 2024 21:05:57 +0530
From: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
Subject: [PATCH 7/8] dt-bindings: arm: rockchip: Add Relfor Saib
Date: Fri, 23 Aug 2024 21:05:27 +0530
Message-Id: <20240823153528.3863993-8-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240823153528.3863993-1-karthikeyan@linumiz.com>
References: <20240823153528.3863993-1-karthikeyan@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1shWKT-000GB4-0J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:53684
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 72
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLNkMlAGXKobAQmCLA2HWhy5/xNnyCif/j8FWvIngh3lOsdlgDun3/MVpuw8iWr0THVIe0IW5yx5fosDZQuYpYecvgSL1dEq9g6KJM+QVrdS53SmkbgK
 XS1L++c1QmOp4S3Sx06XnswSAQM8P7q4NKiF2/YGwVK/895YKXGGtik+B+jQmfTT+t36CmAO0WByfeU6GzYbxT78ls4g8FsFPWu2j7M31+tB4UkSRIaOmtH4

Add devicetree binding documentation for Relfor Saib
board which uses Rockchip RV1109 SoC

Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..29f7e09ae443 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -848,6 +848,12 @@ properties:
               - radxa,zero-3w
           - const: rockchip,rk3566
 
+      - description: Relfor SAIB board
+        items:
+          - const: relfor,saib
+          - enum:
+              - rockchip,rv1109
+
       - description: Rikomagic MK808 v1
         items:
           - const: rikomagic,mk808
-- 
2.39.2


