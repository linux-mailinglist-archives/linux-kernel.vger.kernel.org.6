Return-Path: <linux-kernel+bounces-203735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAD98FDFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303401C20EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F713D25D;
	Thu,  6 Jun 2024 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="guksln58"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4813C3CF;
	Thu,  6 Jun 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658900; cv=none; b=VYgDb/M+rvoltJP4kVdqhgLTpbMfix3dI2SyuASCMT16tjg79f2aamabR92bhayzk0egGR4WZgdCLQXHzTqRLKqQ7/HBERsrulVaKOC7FQ8luzPfinkReH7sJjWOeK4jAE0Ftc3sokDRGAJ+hJEFySz8kqKny69aSNfpI3tU1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658900; c=relaxed/simple;
	bh=MBoGtXGw67Bq/9cr/0MdyV6ELHHCe1Xnvy2AOKwv5C4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fvzSXAv+VyhBYhJusscllaEMj3ypixObqt4y1YyDpoWjG02RYSSDfnsCBdZ1wOrXRdh9thKQoY3mIdpID4jfwolE7woYhfYgiUv3SP/VU7KUuMxHqoB9AyUMFTo29RR9Mks7Wg7O+RanCG6/Ur4rxO3Gc0e6VaJW93Knq4WBhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=guksln58; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gBqBMEdpgSWaaWwBLc5khMuiytPxATXod4rTVijqgY4=; b=guksln58r54I04NYiWoMUl0V4R
	pCDiwlA8jyLRRLoivVyXybmV9n+JYTFUd68C0CbL+PpNtVWCrmPbz5XzJRwB3hpvJsTTdPN+Rlqmq
	Gf0JcluLl/NNm2x9jI9EbOFsJ1azWXGmu0j2s9OB3f4beDN+59cVloz8dEGS6u9fgyHZlZOhRDqyU
	bCoz46D/PUlnEiAZ9id6eFAXLQQIHqFfhKQoAcnUTK+kWmKIhMbN24PkNoWR/aVVzh+SE+gspOFYR
	Hkm/6FOy4MPgA1HFjvrLybbaTGOTagnRcgRbsLqnDccy+Q/YsOOc15lrq07p69kUPMGY4cQamZh01
	I05tkzzw==;
Received: from [89.212.21.243] (port=52108 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF7Xl-00BQOL-1w;
	Thu, 06 Jun 2024 09:28:16 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for PrimeView
Date: Thu,  6 Jun 2024 09:28:12 +0200
Message-Id: <20240606072814.3572965-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

The Prime View International (PVI) is a LCD panel manufacturer.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..2bdfeaa3cc8f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1154,6 +1154,8 @@ patternProperties:
     description: Poslab Technology Co., Ltd.
   "^pov,.*":
     description: Point of View International B.V.
+  "^primeview,.*":
+    description: Prime View International (PVI)
   "^powertip,.*":
     description: Powertip Tech. Corp.
   "^powervr,.*":
-- 
2.25.1


