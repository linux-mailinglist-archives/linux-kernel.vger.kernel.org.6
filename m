Return-Path: <linux-kernel+bounces-324672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A0974F87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142351F24FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0784B187343;
	Wed, 11 Sep 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="As7CaD0y"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C27185B7C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049998; cv=none; b=LpEkctJCTQB+FpTmhnBdVibvPJMeHGZNPUIPP9j2UNt/biPSKPBKdxlb0pNqEBlRytjyoCAvQGYwA1PD7rwZeiDiLrICo814xOUO/TXiomeX60YTd9dwlCCMw3RvyCpa3oDkMuZAShDu9CWEJXdGBnXxpw2q7C8GZNOzu2w6xqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049998; c=relaxed/simple;
	bh=uv4i9SmouGtJ0V9Qz+F5rvo3z7uERMZwd+jUcyFBUu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QE7Yt5RSgvNKewpfPPBIqE0oWJNBR138z2+2z0P9BQ0E9m3z3SWsPUoZWAUbA7Nf761+6qdgtokXo/Lf9upyo/h83SQ1x8Z7/4mIPjMUU6rEX+nWfBsK0NkPdeo1y+iSlDnJw4Pu+yzn2N1gerUmrLm2iz21wlJ2sREwSpirkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=As7CaD0y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbaf9bfdbso22626625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049995; x=1726654795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OW9k0g2tfwUk0MHcVot7EYfM55mJC939zhR5ttTV7QY=;
        b=As7CaD0y/dP/lEj7V/j2x5Xr6dX6RN82Z02r/CKYOY1iTbDyQtEeyFkm166mpw8wbh
         ZFQiFScYKMq+PHAiA36faFK82tYHsCWB1VekrtcGZIChchX7kO204J9jxPCQ1JrA9YlD
         SgITvYw65Z1bYIy0cab+gJMXmwYlwCL/s6e9ir/l3+NRXKNm8bdDf1wfU72itdX6L7oC
         RkFGQD91Fk3he/WGu9qDKxjoZhZfUTqqYqUPHE32ZzTzD4cHh8LKth6EeBw9jS+JHYVH
         yStQ3xMmaXPCZGbEIlq7+u+XuTrSq2qIp3H9d2NGehMmX/XIEg8n7YltUpHBI21N32k4
         50Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049995; x=1726654795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW9k0g2tfwUk0MHcVot7EYfM55mJC939zhR5ttTV7QY=;
        b=wfJhW6B4qJUq1n7DTlI+zvCHaYl4wWbMSc8zQ5eKFSu2X+PihdbzgaeD4JgesEnLgC
         iDRzXG49ktyDqiHfKQ/L7GtVClTe57pzR11KcEjgm95MJWaQgyNI1E/nYmLUsfik1gxY
         vaznHHCJw71/+WJ0qd1YbeulewxXxbByGuliN49srbgmeY4v7ab1uX4LNtww//zrG8xM
         rIumniwMK6pHSr559dh4PEJMD/9PJUmmZsWJEgGaXY00HaknY0LKZxYAwYtiypy6M/3H
         yCTlpPwdyCfZfL5uoGOAhx1D0DC+VTgqQ2E/ExJDEmVlW5Lqn87BcABbBdWgX1isjnsZ
         ELBA==
X-Forwarded-Encrypted: i=1; AJvYcCWCtVAYfyaw7j9eA40sSg7WvjMoZkpbZZ6tN5rlK4F7ZcaoF6Tv2DZUVbSm5vgXDSMIyb1cCeB4Z8TYh/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfwYvjh7w9ijIZrkp7k3AB365Dy4Gi1ZrD7Qu6lmaYFzJvFOe
	qeGAtqBvvvahletQWwlY+2k6MpNzL7qm3WXHZGZzKQis3uqmW/SWqExUvUc22bA=
X-Google-Smtp-Source: AGHT+IGrJGBuHgROvclb3h/nO/LGhzV/XK0f6cl++KBn+b6C03IxfuW1vJXiIWPu/d/KF2KMFQu6hg==
X-Received: by 2002:a05:6000:128d:b0:374:ba23:4b3f with SMTP id ffacd0b85a97d-378895b798emr11675957f8f.9.1726049994587;
        Wed, 11 Sep 2024 03:19:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a4esm139349125e9.7.2024.09.11.03.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:19:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 12:19:44 +0200
Subject: [PATCH 5/7] ARM: dts: amlogic: meson8b-odroidc1: fix invalid
 reset-gpio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-5-feaabb45916b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uv4i9SmouGtJ0V9Qz+F5rvo3z7uERMZwd+jUcyFBUu4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4W7D6c5Gvswd2thOKfgBZi2LX9Hg/v4Z3U8me1LD
 humsYiuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuFuwwAKCRB33NvayMhJ0Q5iEA
 CWyAKW39xTrIbOrS/9yxHdmFChZiOnWCHK0t0u678bXrJrAFlYWL3fctioo/scXiSLEeOqQC9eBvsf
 y1vibfY26/lu6ix/4m2iyl1iJJ8XIU7z/8qAqjeEA5pbtOIkQH/i/oX84Ux1ohCD1K1UI570kGLA8G
 MNqLDJQqi1YBaN71X7q8BbyR+konjx6oHITw6v4BXfbkxSnU6OLv6Z3+sgp35CcZfzs1/nYiUw0rKi
 amv6r5y2ztVUc84Zv7tVkodbGmcXaKRMKZ8LTpeHoW6SsotIst+bbOWUknIWjflYOLPPPtkISVbpfe
 6jO7t41MJ9lDlkw9UOFzfsIfZ/ue7oB79hBrwEmEjiDTIXZ0S1IHyTMsVbqFsY3FxVB7acjTaUtIVa
 +XQaUbFfgIpO1axqnWlgIeSYJYOAKMgs+DlvMYAYHjhO+SNCX2unwq6XGYDdSk0a2Z1WDXuY0Ch6Vu
 byoCso3I6sIWNf6iURV6Z4y59ZKIzlhba4q11kAZUTwgqmfgdP4T8L/khSByhPXfYgKk1dJWihUv5i
 05rzNxRzVLbGqpLqLaSXfYG/ikyXDhkU7hEJBsxuYSdog2xLktcQRO1CUMAJQ58bdwR5ZkUwl+Vm3F
 M96bM+AF9YGJRi4qFni7rkKXfYq4dRit4koGHcZUgffqJh0Z9G/RltXk+I/Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Use the proper "-gpios" property name, fixing:
hub@1: 'reset-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
index 941682844faf..962bbe3337db 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
@@ -378,6 +378,6 @@ hub@1 {
 		compatible = "usb5e3,610";
 		reg = <1>;
 		vdd-supply = <&p5v0>;
-		reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
 	};
 };

-- 
2.34.1


