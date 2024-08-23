Return-Path: <linux-kernel+bounces-299214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF28495D19D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26A01C22716
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6052189529;
	Fri, 23 Aug 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="gan9XfQ+"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2318BC13
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427367; cv=none; b=tmOlzZJ7lOpAM4kgqjA0ja0ZngGxZn7SprBEtXTRcx2sKw0HL5XrAsBKlOn9hJRaItKqRANpevuMOBHpUyV8gcwbzXh/HxT3KMGtr0KzYTKo5OSRT3ENTRpAig3Z6P52VxXgCntVH2WJWfl+655zAHEmEW3V8kXntp+FvWdZln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427367; c=relaxed/simple;
	bh=RWcsPcdAqSTQ8FCPvKUEjAG/CSPBS3D/NNk9b0oSTxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRzEXGchJ/aT8mr7Xd1duZtsGC8UIMaUPW9ToXDtwBnxvFFyjQODe20tIqqu1CYhoTA+0vcJE4QkUCudjeFNbG6Ho1tSH9Ta2Rywd/IHbw6ZexQAqMaVgvW+OyMtiLfsPTMMS8Buumt9lE5K/7TkMLuedNWNXjYGI46nalfSPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=gan9XfQ+; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id hUbxsoqT01zuHhWKVsUFnT; Fri, 23 Aug 2024 15:35:59 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id hWKSsr4OJmqhihWKUs7O4g; Fri, 23 Aug 2024 15:35:58 +0000
X-Authority-Analysis: v=2.4 cv=NdEt1HD4 c=1 sm=1 tr=0 ts=66c8ac5e
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=yoJbH4e0A30A:10 a=vU9dKmh3AAAA:8 a=Kb_rVgeVel1wak-Xqx8A:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nqWL8jBxFHYZamQffy5P+pzLgJszdIlE2k6Pctncqvk=; b=gan9XfQ+FPKlJQViHy7oe/svde
	KEqV+axl3tQmJQmV3on823mfVI+jvZUTFaSufzEsojlZU9ENnKaDts5g8Ltz/qgvVrJFZnQfD7HjI
	9A3RyfFpbTC/fUkI1HL9myUcppKMFaG5XsDTZRywCCX3jnktHiLp/+OC5a1qLGWhwBOFuKfHAF4Dw
	GAlx3up7Yjd8UWBMr5QyWLjcx9BL6pXYK3pBIKS9lHNhnHKmis/NEYTGQ+5lcHP197WH1mi4bnZbB
	5wPyuA2D1eo6J0cB2IdNemP1oW6AT5rxum7lGN7XfDti5Za+AyRtLMrW9RxDW4Dm6qoSEQ7+jDPsC
	0sdVsaVA==;
Received: from [122.165.245.213] (port=53684 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1shWKQ-000GB4-0o;
	Fri, 23 Aug 2024 21:05:54 +0530
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
Subject: [PATCH 5/8] Documentation: bindings: rtc: add clock-cells property
Date: Fri, 23 Aug 2024 21:05:25 +0530
Message-Id: <20240823153528.3863993-6-karthikeyan@linumiz.com>
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
X-Exim-ID: 1shWKQ-000GB4-0o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:53684
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 49
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJcJIBM+mZEI478Y/PyPSUM/6+c6Laz0eANtk5woXCYt/6dNqzKI1lKKjMCzeWzjaZ3kH0mKVtneoRF0XUjmCK44gcEuFFMp+Gl4VyGm4yijGwOaUBVk
 xlu7Pzr9Vh+KhDZgiGzgcNCy6lWd8p6fPqLeJtwcmzPil266dpQNNdEZTK9aYls+96Z9LVn8MssQG1+wtVeF634ZoU4vfpYL/79wZZDkcxnZcfGhWs2yRZIw

consume clkout from rv3028 rtc which is able to provide
different clock frequency upon configuration

Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---
 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
index 5ade5dfad048..cda8ad7c1203 100644
--- a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
+++ b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
@@ -22,6 +22,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  "#clock-cells":
+    const: 0
+
   trickle-resistor-ohms:
     enum:
       - 3000
-- 
2.39.2


