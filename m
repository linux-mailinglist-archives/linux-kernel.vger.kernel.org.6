Return-Path: <linux-kernel+bounces-304961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE741962765
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB70B230F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69717BB1A;
	Wed, 28 Aug 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="FEPyz775"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DB178383;
	Wed, 28 Aug 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848854; cv=pass; b=D6SWXn6HiLSKkkc9Rgh9VidhN4UlhZHRu6QPzUoNasiQrNhp87OuVCvbm43OpuUvqOrYdxg5S4vsD2sWdkCq+7QCZm629GkUEI+/NgE0FYtX1qVM9abq6aMkZ0eTmxP+5jrsn5jw+2LwHgzjUQh8ngPJcIlNdKQhKVN7CPLw60s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848854; c=relaxed/simple;
	bh=ly386uZKvwMCUniCy4/RBHSAePPwp4Nx84G/Nm7PUYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlV/I1iHXihgt9hu06VBBpkehDKU4REb2epamaJLVTd+DBi0h7vRmf5ZB96x49t+aKwKZMsmXSfzXrT+PJUnvWzIcYTPFm2hHLYxSHWJ6b3SjPfeDfPiRNDKwPS14bkLo6Xcs1sidF/lhueIYzTO5wPFLENtbo5waxr8Kga7Kiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=FEPyz775; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724848842; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fj8QCPMlTuhAhciY9yA8jYfRYlrFS5TTRIOUaAw6zpEqpja1/dkFycefmRCiZexgZMiPrcWmeRWVu7m/3F4roNOsEBrrbaMwdleASrG9xQzh/n9LcK7c+gGSnopvjnR1HmUlMoRAdGPr16Dd7f3evC/M80QhsOAgypOh/BtCQUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724848842; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1xNtIytLwgeU6cjbUOfYF1MZAIhmIBCrj4xmGawRSRY=; 
	b=ECvRlOebMrLEjkJ7621Cwl6D9LIqpbZJoK5CuoXVyrPUbq9WnWa6mlVBnicoVavRIWSs/sGfvpe2hcXcOJhaWR/tX+jFHaUn4LWWOFbRDnOEe0tUVZtruyWQ7Y9Rln1YDZBj3f6kBVRILzXKsKPLvxh0xKEf8sssUtF/rqY2lUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724848842;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=1xNtIytLwgeU6cjbUOfYF1MZAIhmIBCrj4xmGawRSRY=;
	b=FEPyz775lC9vPTSgjU37j8PYzwZWYZ55Zx/aI5QPakvO9P6EkQrYsxNPwEHIRuqv
	vIb9ABmlQxqqRlju/zaciaVz1YDd8TQLV7/+Wh5fqks8j6lCVpoGxirGIMLn4LyVq/m
	bcCgGmQru8pvlF4rxDpYDm758dtsZxZ1txcv0PII=
Received: by mx.zohomail.com with SMTPS id 1724848840222821.6532213316729;
	Wed, 28 Aug 2024 05:40:40 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 28 Aug 2024 15:40:08 +0300
Subject: [PATCH v2 1/2] dt-bindings: soc: rockchip: Fix compatibles for
 RK3588 VO{0,1}_GRF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-rk3588-vo-grf-compat-v2-1-4db2f791593f@collabora.com>
References: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>
In-Reply-To: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

According to RK3588 TRM, VO0_GRF and VO1_GRF have a similar layout, but
definitely not an identical one, therefore sharing the compatible is not
really justified.

Since currently there is no user of this, hence no ABI break, let's fix
it by providing dedicated compatibles while deprecating the old one.

Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 78c6d5b64138..35b20e53b513 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -31,10 +31,16 @@ properties:
               - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rk3588-usb-grf
               - rockchip,rk3588-usbdpphy-grf
-              - rockchip,rk3588-vo-grf
+              - rockchip,rk3588-vo0-grf
+              - rockchip,rk3588-vo1-grf
               - rockchip,rk3588-vop-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
+      - items:
+          - const: rockchip,rk3588-vo-grf
+          - const: syscon
+        deprecated: true
+        description: Use rockchip,rk3588-vo{0,1}-grf instead.
       - items:
           - enum:
               - rockchip,px30-grf
@@ -262,6 +268,8 @@ allOf:
           contains:
             enum:
               - rockchip,rk3588-vo-grf
+              - rockchip,rk3588-vo0-grf
+              - rockchip,rk3588-vo1-grf
 
     then:
       required:

-- 
2.46.0


