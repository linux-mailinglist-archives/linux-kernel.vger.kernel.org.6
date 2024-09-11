Return-Path: <linux-kernel+bounces-324670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7714974F83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0441C21D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E413186611;
	Wed, 11 Sep 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xC74QNDJ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE847185928
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049996; cv=none; b=SAhOevF57gUT+813vdqyV08tjbHiZkhU+rRDF5i63A9lyVPK9LXKghWB2sGTuzJ3tO2V0VcYg6o8WqxcXRzYtsCFP0zi5iefQkW15sdOjHlh2pJBBoVK6vPzxOhSh+PTmFFS2xu5pHdDzW1vkbh+Eq3SKceNf429hXCtlNIKIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049996; c=relaxed/simple;
	bh=3rqB+QfGX7ZNjnSd/wuOaHFj5dZkI907fn9bX+xLKhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXQevdpIU+oCXytlLEmB1J5t293okEGtq+/ljpkm9Poxm1HwpTKKLYuI3vc1o7kQjmUFLpzTf+yUwx0zJVsfNjTMcCklRFfnOG7J2megH7AVC27Gxa/iFDLVu6lrurtIY4ekD4XvTitvxSHHqFLIAgosLPYdW3xefVvZVM8BL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xC74QNDJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so4515605e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049993; x=1726654793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r96gtSeyw8hgkasAvqFOFnv2ushN5suY6xplKdH+xFs=;
        b=xC74QNDJFdmDV66MHvLngK1Cyv1movSJPJA6+UN2I84jjwr0wOzTVPVgCPj793p9De
         ayM2eiOljtzvZKgOQuZClCKmlaM8tdCdqukDZzLP04PL8xrUoRzKj7LhCz2UdyQELd/i
         zDEIe2x4QoSJfTmNvWLwKVvou9twu0sJM6V5aTrrGIxipaotWNqHKQg99WE9N26FVzfQ
         q9nM0nDS3W2KyiD+QgkLAXjOIS+jn3/Y786+p1Fq9NZ+Gf7ydaQsAkgSAQZdqoxAx0r9
         RtMrHlER8Y4bfaJ18u/3pkUoLFjGbmjuPG/J8akXWw7IONPVipIjD+c41w/Gxm83IIKI
         LIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049993; x=1726654793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r96gtSeyw8hgkasAvqFOFnv2ushN5suY6xplKdH+xFs=;
        b=X6E9b8wRPG6PjOCf+7U5Io594uCB4bJy1Zn61IAUIn55bqXug2f21T6JYmxo4oyJNQ
         K/buSAqK7FCnlI9P/QvYnlU1vvbaX/nGQF11/bgimuSzzSeHHVn4Xx9+yxsp0RviMyD7
         GySaYVlw/s54di3x6W5yLZGv2T/MAM3ACrVK7f9j0OYtCIRwwDdobMMbOrC4LFoW5+58
         RFOdZVFk6QVZ66akGrQWzwETTB64V2fMDDySTwmUMRhutwGx+CBd+La8bKkdHQFJA1zq
         XTqOJM9/K1/NqygRk4qVqEi1JMPVZiBOKRfwKderAtD7iN4hCVqt1gPaBA4Wd+9KBuae
         dXtA==
X-Forwarded-Encrypted: i=1; AJvYcCW/SpuGFGvrQqixzEMIDFT16EBkn41F1fpesr8XQ3aFIpQOpBWnQVnnL8+6BYFkkw++TlLJnsJKitmZ9is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAsFk4iabi3SZxpIkyJWZGCcUUZVAkcrLGxVnUPsgInDBOKGW
	HRKjM4xMlSRMC9r3FbN55zp/BfdttFN147ENYODc7fmQ59iZRjbk26Qau+UPgJ0=
X-Google-Smtp-Source: AGHT+IHvTvCBeGTxd8AjI2Dpw7LegdyVfXJm7IbEkorFtXOOEPpp+W+ARvYtiFYskxEgIK4YgMynnA==
X-Received: by 2002:a05:600c:1d18:b0:42c:b98d:b993 with SMTP id 5b1f17b1804b1-42cbddbd807mr36188205e9.2.1726049992750;
        Wed, 11 Sep 2024 03:19:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a4esm139349125e9.7.2024.09.11.03.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:19:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 12:19:42 +0200
Subject: [PATCH 3/7] ARM: dts: amlogic: meson8: fix ao_arc_sram node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-3-feaabb45916b@linaro.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3rqB+QfGX7ZNjnSd/wuOaHFj5dZkI907fn9bX+xLKhw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4W7CvnflnGeOULFzAjmTVYGP2qlu7ntsCVKLVvpH
 rsmwVHCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuFuwgAKCRB33NvayMhJ0fHtD/
 9WS5zVJp37hJTZ1PEf4TMC9YFrVJb0rBBF8D/0Fe0+9XuanYQcaSJsdd3ocA3kY0VC7iJG4VHVjm79
 IXn21Xa9VFEI14XuDUr8oqiviR3gMJCgEJEso9X7JY5xfvEqKrjp/RTjCngIwLtoZHwQr0p1ILMzXL
 xe3ryaBok7CfI8CyRwRQUdbNvtOx+gFt6GOsGDy/nN1YzBhg1ZCSBwgTn4/ZMz9bTFyYyeyZK/oZyE
 ghQs3V1Tk/Pma8J+rozQkxOepsMWibpVt0etYHb9eSFKQ73TvJ15/63fPOXp7J3Hw9OEElGHPOhKTk
 CSnkqxmYtNT0ZRW9KkNED98kYN92TFXnVncxY9WSagMiS70Nr2XE5TuysnWd849bDM8Sia1zh7L9F0
 h267dnAIVdfnvUAHVafRIc/e5olKXHhuCSywrSi/3TVRWGylvJJislrcJ8tIdqlbckvIW023xTcu4O
 HvCONVgjeapLs13FvOJR/aaaKbU3RYm3sWCTymTvI0p+eOziKR66qk2y5k/VTzF78gwRQn5elt7SFg
 oqm0CmNK1QbaOfyiK5FN3KBjsqu/i8YFbYUi/tbq/T4P3awwcrsXk8TAqBo5v57rid76wdV6BusIag
 7+xpS0XL4h9m+dvgRr1yBJTZRkU06CQDTLB2ATwQELjJ/Q9tS/CQ+9Lx8QEQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Use the proper node name for the sram, fixing:
sram@d9000000: 'ao-arc-sram@0' does not match any of the regexes: '^([a-z0-9]*-)?sram(-section)?@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson8.dtsi  | 2 +-
 arch/arm/boot/dts/amlogic/meson8b.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index 06174d8df789..1023ff0a4f9f 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -589,7 +589,7 @@ mux {
 };
 
 &ahb_sram {
-	ao_arc_sram: ao-arc-sram@0 {
+	ao_arc_sram: aoarc-sram@0 {
 		compatible = "amlogic,meson8-ao-arc-sram";
 		reg = <0x0 0x8000>;
 		pool;
diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index a3669025d8da..641cd60781a3 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -535,7 +535,7 @@ mux {
 };
 
 &ahb_sram {
-	ao_arc_sram: ao-arc-sram@0 {
+	ao_arc_sram: aoarc-sram@0 {
 		compatible = "amlogic,meson8b-ao-arc-sram";
 		reg = <0x0 0x8000>;
 		pool;

-- 
2.34.1


