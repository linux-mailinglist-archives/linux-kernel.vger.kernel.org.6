Return-Path: <linux-kernel+bounces-324668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10F974F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51342877FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8A185922;
	Wed, 11 Sep 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZSJw5OT"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B41165EFC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049994; cv=none; b=Ua0/3/yDlOjpxp+J01zRWVSFNH0dwP+TtzUXTtVB1Y2kNn4Z398vLa/inWIY/uFgH0QxbMHda0i1arn2lPOPwJEtg8Eo/6tsuvJz7REwcP1/b8Cvmse1mDPNlq+nMITbOFQmrLz0g+M8fhlfs9P/KriZ0i6Fn584z+dI1YC/+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049994; c=relaxed/simple;
	bh=pMewlYYDF9agGKPA3HCGL/qAhfwWWF/OUrcnBP2XiME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0frMca4EykgeUfETopRD7zMPPHXQw4kjb1DNDWDviWkjYhQACDBHbGw0Jk2yqp89Xqe2x82bsRbz1UmCEG1jw0Jw0+rChKvR/gasEoVeZMJzXj4C+aPNNp/kjeI6bkEqZCNjcyC2IOfVyjaYdNrwXnVXUAJFcZx9w4PdGZoB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QZSJw5OT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so1569125e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049991; x=1726654791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rsbSiyM71mODHTPu9JLHGloK45uN6FAOdQl+nPVppY=;
        b=QZSJw5OT2Ye+hKMfLnwFdplHMqtp55u0NGaHLIA4C8W+h+H11oILfyrRdu5OkiGZsx
         gX4/pmGyn0TyzfxS9PjGruSafvst+nZbAVuaP8MMUe+nM7hJS7gjz79J5qQuiqAFz8us
         feBEZv34LckvTAsOIltqzgu20K2FuWEqtWUlBoriNlPz8rg8YGYJhEYImHu95QMK9vt0
         DnWqirkk2jIUfP0RUt2PYwzUbLJt5o7laCsi7Bv6D7k/96NqZITNXvwqhahUPdJft6+v
         1ew4asMtQM3VkNQ6II635xWD7bneLIp7QpvIPYwRvVgf1xiGTkUTKvpCBBUX9MouMjg1
         w5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049991; x=1726654791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rsbSiyM71mODHTPu9JLHGloK45uN6FAOdQl+nPVppY=;
        b=FQpLTh1sjuGrXSMuPDWd+WcDPqhdpnzlmxlPkpSHQsCQRZF2eoYF1p2ASbBlC0hxW2
         HDokPw2GFb2RDaLNsLtoeSKyPD0a1EIzNz4gnYcV28JrACKPlu9AE/7LO2kZkR7KTO9w
         zlvfMvk8CV1lfy0v4GKsUEtG3t920QMzWpvNpBKbh/BlwKCBoQ6A5zcb4npoXbbuKezl
         oz3NicCqGUpXIaQdy9Mz0gOVw2oCITYbbkvJws0mQ6+3tBNcJj5nKqA9vgpu3s+ILdwp
         WLGA9LMwkhTKjwqkvJoeiusvJVKghtJOsTBKr2/+jq0oeSv1IjgRMf9dQx8kvxKhNWrY
         Ahew==
X-Forwarded-Encrypted: i=1; AJvYcCUsATF20xKivS1hqANUQLEO9emmZ0NvWa8ncz1cZ/60fA1iqHdpLti+pSnTYZaCDzOPVZbwuvGPfgqBwdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhFQis8ZHKMX8FOM2wHL9gEzgKiRfe+cXsZ7fHEDdFA3AUvFa
	f3zN4m/UwGH0nJCr784Lpdq/3WSWwPRA9qT31zyD6r7ba62t0rEfYpgK3L9MeN8=
X-Google-Smtp-Source: AGHT+IHOmZQW97APpOJq8ZXf25e/+UVrWZ4mm4OzPbzXjCPjUnvBy6UlRCzzMumWzaBMjPHGS7EvDw==
X-Received: by 2002:a05:600c:450f:b0:42c:be90:fa23 with SMTP id 5b1f17b1804b1-42ccd30c13dmr21835785e9.2.1726049990742;
        Wed, 11 Sep 2024 03:19:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a4esm139349125e9.7.2024.09.11.03.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:19:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 12:19:40 +0200
Subject: [PATCH 1/7] ARM: dts: amlogic: meson6: fix clk81 node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-1-feaabb45916b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=885;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pMewlYYDF9agGKPA3HCGL/qAhfwWWF/OUrcnBP2XiME=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4W7CAUtbmQZ6Iaz++U2H1cY8WkP1YFJGNRGgAQQH
 v++TdaqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuFuwgAKCRB33NvayMhJ0QQUD/
 9Y/RSQtbW8UkCfoEUha1rdfpkcWbPH9iDVW1744HyRtQT2ugSQgVRcJlhibv/7iuX8DcmQAi4+usE4
 pxOp3DWYO+B5HhMZ/PwJqN3DLgCS/2249YpMRO4IXEABTx/85oVCVuZ3E/BoF6yRHGQiaJBVrmFblo
 IfDvxTex8/y/5co8dN/CzZ49kR7mHJytoSYBOt6I5pqo4fpwpg4tLhrPw6BmRxM2fNG5oTYwnN8uUS
 gksgjc0PSqZ4B7qAv0EWl7OmPI3be/+vrJa52V4k261cvjuXzvcoI+RXSbzR+kU5GK0MyZbaHZwtej
 yOsl0bo0nSdqU6zdB1EjKCLKxaAGrHhWDQFB/z4Hmt9cSiZrR8FpfSVdQi6FgqJHiYlu63zIn1wBUL
 5m20iF+IknnsBre9qUng+RuStgFBQFJIp0SRzuU6F3AyTubFwHfPaz5i1D8rmVG3qgoxZTiFPLO47g
 uQbQi3qeN+zv2y9O5cfzHus9RJCS+PywOOF8NtqLSfTNH46cBWEbkIYuJ+kWMmOkJs44RhSccjb1V/
 WNDFfRTuGGXHnn0jFNhzFNxQ6xFCjav9mpzsZao+1aB3vO3J+VSULA2ExbUKGcexl2eUvnRtx024YW
 ZPBxmDosXIeOJNieP7XjiFeeRchZ0isnH6I/htHq1cZxOm6eRuvs5yeZJQfg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Use the proper node name, fixing:
arch/arm/boot/dts/amlogic/meson6-atv1200.dtb: /: clk@0: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/amlogic/meson6.dtsi b/arch/arm/boot/dts/amlogic/meson6.dtsi
index 4716030a48d0..1c4ea7266f66 100644
--- a/arch/arm/boot/dts/amlogic/meson6.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson6.dtsi
@@ -36,7 +36,7 @@ apb2: bus@d0000000 {
 		ranges = <0x0 0xd0000000 0x40000>;
 	};
 
-	clk81: clk@0 {
+	clk81: clk81 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <200000000>;

-- 
2.34.1


