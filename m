Return-Path: <linux-kernel+bounces-203737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 918AF8FDFBB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0CF1C20A77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8213E05E;
	Thu,  6 Jun 2024 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="MdlHOmuo"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9113C807;
	Thu,  6 Jun 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658901; cv=none; b=iV22yNaKOB7PdrZBNzgU6uzg+errR93awFv+9cugse7MLpd8xozfKjJhze0YITcaxWe4Z3Xtz7PczV8QyMRdlgifabI+2Vt4CQBDtaoU1ZmAglyu3Wd0Ub0KSS1gN44a1Drqm3xpPy1ALmKqR96h/3fudVznf6H1UfMnpwrLS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658901; c=relaxed/simple;
	bh=91U8d6XGFGMs5bVYzAwQ0jYV92fNyrArs0g7d4M38nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7bkTTj/ynviVrcmtIyDnFygbbQaDVRYDeFUoh0Qa+nTpEVoOlKqvUdmL5TjbBTyIMskb2jC07Vk2bIrfYlt5ljd3fZegINILX4M+kiIMBXXvGa9s/50OkqC95LUyYR5G5cdGQswiGS8tbO/9v00N6v3bMWw0Y4Kcx7BuojX3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=MdlHOmuo; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qk5XBpJZsmWxEerw/vUtoOH9YiI6LGwabiXYhIMtEQ0=; b=MdlHOmuoYWLbcshD8+145c5uO7
	DsVpJTNnr0LIdQDzY0l5PPgTRKGGA2fz2tAO3hZDzyuk/5ywl1sJiBG59aQR/uD4ZvZXD1TTmCB+i
	g3dI0EcjwGJhVQdBhE7bXO/jSRjlmVqiqzRpxNm//+e7QVe2p6oMJIrWbcrfbZ38eFsGEmdYP0Rb+
	SRYpO3AQxi8GbTpt65EyXJ2C+Ik4/3yE3tUzH/4PpMQ8rr6GCcbrURmrhaiTyyqRvw65u0kaOsdRb
	MvXCMDHj3FgVMVejSp9SobYWYjlOwYmT5vdl1CY+L/d/jBD6ljEpkr1EDFs5Hqxy2zHpRw3pbUu6E
	ytXcJB9A==;
Received: from [89.212.21.243] (port=52108 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF7Xl-00BQOL-2T;
	Thu, 06 Jun 2024 09:28:17 +0200
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
Subject: [PATCH 2/3] dt-bindings: display: simple: Add PrimeView PM070WL4 panel
Date: Thu,  6 Jun 2024 09:28:13 +0200
Message-Id: <20240606072814.3572965-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606072814.3572965-1-primoz.fiser@norik.com>
References: <20240606072814.3572965-1-primoz.fiser@norik.com>
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

Add PrimeView PM070WL4 7.0" 800x480 TFT LCD panel compatible string.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5067f5c0a272..671da4991a5d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -276,6 +276,8 @@ properties:
       - osddisplays,osd070t1718-19ts
         # One Stop Displays OSD101T2045-53TS 10.1" 1920x1200 panel
       - osddisplays,osd101t2045-53ts
+        # PrimeView PM070WL4 7.0" 800x480 TFT LCD panel
+      - primeview,pm070wl4
         # POWERTIP PH128800T006-ZHC01 10.1" WXGA TFT LCD panel
       - powertip,ph128800t006-zhc01
         # POWERTIP PH800480T013-IDF2 7.0" WVGA TFT LCD panel
-- 
2.25.1


