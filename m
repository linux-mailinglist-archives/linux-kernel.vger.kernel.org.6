Return-Path: <linux-kernel+bounces-548713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B17A54881
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050CD18950F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F89209F44;
	Thu,  6 Mar 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fN5c6zP2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE0204686
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258587; cv=none; b=lkgwFILGhWo0X9nVvxBKJ0TvZDEKdp0oj03H1zz448ZJ+AJ0iCURtCqbFi8JUQsuDIFnO7a/HlYZ8LGBxA3vyAlesR9hHX/xWRPO9n8IoN6lCG+JSv1UGRi8QoNLiKO+lueDq6jp3SACr92X5vq6ZdOXisqKdlHLGoat5BuwwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258587; c=relaxed/simple;
	bh=P71o+WVhxYn8Se0AGo5XXf4Chk/tu5d7gpsoPtCEyy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jC4byaWt6Zt3fjVqLXwkdN7qfcyRS+ONpSB15ywy88LNecLlo6z/Qkw8qDFJKRTeUrl9cgZKchgf22wRJA9KmmX9eUL0WYmC6LES1ZBgtuigvoL10Nv74hEjS18BW/Q/auAt96cPBiYwR2+BPRI2vTobk/nC4EbMzeFmJkaLXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fN5c6zP2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a39e659cso2642655e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258584; x=1741863384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxBaNed9RSMl/yW/MAlaQb2l44+yRXzgp7zH4r9ij/k=;
        b=fN5c6zP2ff/XI10MuSKo/u2HPpgI+MqN5mZrRquTHW/fS6Kk1TwbeYhbwEN0bHDxlv
         yLvsYK0aw3BHSzOittEyyQV1s+MQN4qHNzK1hdYHPi0YtOG0rXMNmYWcp5wa7qqT44b2
         ZldUvHkPykJ62pG+iZERELMKFzQKIVwVfhfhmdrnCEv5yFkIkPQyKmElLbHK0F42QhxC
         xKdtg65/ygpHBOk+y6uBhNeQHqv5aw9hjBFOAKuAi+GxeqltvusNsj9EZpq0izxdVI8B
         LOOK7tiImFRRzBHyxkj23csieuZR1U3Z7owzpSsCSPYubdtawVqlOPm7kDN9J2SBXq1c
         jqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258584; x=1741863384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxBaNed9RSMl/yW/MAlaQb2l44+yRXzgp7zH4r9ij/k=;
        b=rezYGgOssSecIIJcCr5eDjHnFCJomek8qG7v1GTVUjTZthOC24WvL8s6iv2gEgTqTw
         9vChYQkS0CAyI+Lt5cbP8z1SPaIpHv4LQy91CzBVwJrJk6AelBh49SU+5R/6jIVLq3LS
         gpYTwwQos60jS1Gu5mbOfI2xzIY4uCWdTmzc30xC9Kd0XCc3hrtXBr+K5oUE/1H3C1Bp
         miJmkJsUyK94AFQSvQ4Jd6DkNFtI59oilbQOVKXwZRX5fv5tSkuLRYzzpLynYFAaXMiK
         1TsfxjD2zm5xQ/z1KV1WJoBh+10w2Yyts+9xtDRfwy9G84sIYBxutxKsnWgKguhVsudM
         +vZw==
X-Forwarded-Encrypted: i=1; AJvYcCU2WDipzVDEVOdzs1xs9BzE5lKG5mDaDXsqXDHS+/tmcmEFoc+DBquzsIQ6Y4RwHF20E9ugp9SufobMbYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2X9r9UAUsBaAzMQ5Ozut0a0YF3xPoIQ5gOXO1hDQAvCr35Fky
	flDuBK33qkxQI1cfLHGE+6nMJ1i9AEEDzFWN3/hw3tKnBcu+URhE4C41cPzoipg=
X-Gm-Gg: ASbGncuX1BwsWMxTNJBFotHI2tCKE/AtluikRhotqXd+uAIAYGgQbcIFzDJB7zAMPcl
	qLGz5DZ+Zj+oo/9qKng9B9U0JqrbLN53DeC3Jj7CBIdsZ/LO+Cl6jnNCAVkBTFPa3lkQIrN7oAJ
	VGTicELMXiQLAFWNlf9Ang7KpIxs8rtOwnj9RcgTlzHrFcM1OJsh4qqAPu5ClZfN6E6a6wIm2MB
	3pfWDxm6FEohniiMw/2A9DbYtCrpLpT/mzFpW6ro4CO4tMnuH/nfnAQKg9zftOfHGeEKBhwA0Bo
	n4yDrAW6VRwSl8XLrljcJrqmi5zbF3F6N1+41S+VOREKnSDiIxbk+qv/+xOPaZSL5w==
X-Google-Smtp-Source: AGHT+IECRN+bvTx+8pm4GOrYZ5/1UypaJFOSp9E9046SWdeMqENayv/oHV7TP5Iul0p4eNzKyHKWUg==
X-Received: by 2002:a5d:6da2:0:b0:38f:451b:653c with SMTP id ffacd0b85a97d-3911f72fe43mr5103677f8f.7.1741258584233;
        Thu, 06 Mar 2025 02:56:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd831719sm17406675e9.0.2025.03.06.02.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:56:23 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Mar 2025 11:56:20 +0100
Subject: [PATCH v4 2/2] MAINTAINERS: update dlg,da72??.txt to yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-misc-da7280-convert-v4-2-2972c4e81cb5@linaro.org>
References: <20250306-topic-misc-da7280-convert-v4-0-2972c4e81cb5@linaro.org>
In-Reply-To: <20250306-topic-misc-da7280-convert-v4-0-2972c4e81cb5@linaro.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roy Im <roy.im.opensource@diasemi.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=P71o+WVhxYn8Se0AGo5XXf4Chk/tu5d7gpsoPtCEyy4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnyX9VcGMUWuU5jZ1YXvxkpZFrAABVDhICGdek8KCx
 BPGWbWaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ8l/VQAKCRB33NvayMhJ0YNMEA
 CWQ0pe8i+7H7rezUyIlfPbhcXFUmUor+5YvJ8DcfHAhHZ3hKAGtCbpIkjGeGH5E88m5EgnH4AprVCl
 +B78O9t1OB4tXX/uFchdJTdybm1Rmrn50HPEuqXbuww2mIKnvvXUY44qz96r1irR8Q7OtfGcH0Jonl
 +7RpVfvwfw2afEVhP/1vTWJ7p5PZLkrBHDw/IDuR+Ut+UqZkaQD2vnzubKvmZZVj9evyhzuj0ae8oc
 cH6X8sYFRx4ItwRRpy3dKU73hD74GuKmwSkYdwoEzyddksKfbYj+zfjLjvVHEGo3eondbK7VU1kauG
 WDUV3zjIPHlCRzFreXGXxomGILTKn81qBxv9rcZrVC2xig+locIeq0zhcrT9Y01gMdUlQTmHQ/0tQy
 BHuF/y+XAQW4CcHwoOQMw9pwyNMIAkEkGgopRZYYzc1rt/yVxA7/pAacrH+Z+n8joo2cPBv1GM2nOF
 hmBk8Fg6luOAcByOhRDLw36bsGXgEdttPowaotKTmHxywvc2znNcIKW98n7vOJA94mlM4R9pmO1W9/
 RtYNaj7wO7pUJGLJ8uZK7Co+CE3I2MpWHr1ep61v2DeKiz5xVSDnwugmaF/gn5B12DS5REDmrEAIJ2
 m3WBmtFMHCdQ1OVd1YHwvmS8yVANYssFYHgtyAbhyILfJ1Kx9Qrbje3csEFA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Now the dlg,da7280.txt file has been converted to dt-schema,
update the corresponding MAINTAINERS entry.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412070625.zZpw80SM-lkp@intel.com/
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7109a562c96fe22314201f691f1d3d8e8b231f0a..302c27df1b94d5fd579c2855a6ba57be8b34db17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6808,7 +6808,7 @@ DIALOG SEMICONDUCTOR DRIVERS
 M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
-F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.yaml
 F:	Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml

-- 
2.34.1


