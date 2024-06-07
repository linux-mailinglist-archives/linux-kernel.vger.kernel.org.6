Return-Path: <linux-kernel+bounces-206312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8039007B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF361C20CCF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA6619A2A5;
	Fri,  7 Jun 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="XeJ6qHkZ"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5F18732F;
	Fri,  7 Jun 2024 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771947; cv=none; b=PHTPL9/RTfCHQf8GHaXgYTkqbOCGM7Tc7ChMHKKKcXCj5fQZKV5BhbFB2fuggq8cN72ic9qEZj8YS7961gwG6vz5RKgYY4zSCapexFk1z4YzJUBdxF+6XtltHNrFWb8Ig65NH5b32LBOObw/K2b5oO0zmu09BQFd6h5ycsiIJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771947; c=relaxed/simple;
	bh=XnAVDqZ1qHhk96UN2DNbw5yduFoizuZok6ZFRVmcL2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q52HSd++mdWYwv3noYjzSP/TnHxhczAn/Ngisih+RPONAAGQJgDMsJYg50cF2IX7o24rsU3War3O1o6IO6IlQR34Y/zQ6ciTjAeOhdKNm1avx1q1zMbwaT2lqDQznbCcLIMCOmayGrcA+kBmsXoBG7YoHyfgZlAvfKEMdYhNPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=XeJ6qHkZ; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65F35105BBC;
	Fri,  7 Jun 2024 17:52:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1717771941; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5khaxnHYfgBWx++I3wa8hd9Z9yMzi3N1PuwxaE8FZq0=;
	b=XeJ6qHkZAv6+/JzlFBWahb7E8Q2T1lZ1OkfTWW2A3Aa4T2wG02Gm9ubXWtYosJTxlr6DE+
	tEw07zA2LWf+42VtT9YpCIX2dJIjKvTcXinqf6vWsnCn0v/C/CVeHr2948U4XjJvUprupC
	80NiAWVbWFX9yqG0GtTQIku7eRG8QQ9klVScTVsY3CTS7mTGt1aWKG9aVwIuTgvg2HFVpo
	TdwZSRBVV4giH8ae5DJ5zh1uLAIfNygRhADt9+WIIhqW/ApD3MmbZWR6lpF6ws2hbvMZpp
	cnDznzEp69+5dieB/rgsF2qwEB0SjgfhBInR5Wkm4gwFCOcRt5+xSsoNTIsucQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: arm: amlogic: add binding for JetHome JetHub D2
Date: Fri,  7 Jun 2024 17:50:03 +0300
Message-ID: <20240607145148.2246990-2-adeep@lexina.in>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607145148.2246990-1-adeep@lexina.in>
References: <20240607145148.2246990-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

JetHome JetHub D2 is a home automation controller, based on
Amlogic S905X3 SoC

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index a374b98080fe..1acfb184aa9e 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -190,6 +190,7 @@ properties:
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
               - haochuangyi,h96-max
+              - jethome,jethub-j200
               - khadas,vim3l
               - libretech,aml-s905d3-cc
               - seirobotics,sei610
-- 
2.45.2


