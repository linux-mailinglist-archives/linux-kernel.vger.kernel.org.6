Return-Path: <linux-kernel+bounces-181568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBED8C7DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E09F1C21356
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC8157E74;
	Thu, 16 May 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+UM4qUh"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56032139F;
	Thu, 16 May 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892085; cv=none; b=sOVTwzb/iVu+2Jk2jBoYBbVLL1Uqqq7L9weLjN4s/19IVTnoLJac98vRnJ7UJLhjdkMl76hiXXQT02Lles0ZvFnQgabAzjHp5e0vGyML16nJAd208RYYCC9Wa3D+zUnlZakuvPZfl4SKdo6IVXYrMCnnSSOtLED5VqtiP2oI6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892085; c=relaxed/simple;
	bh=qRyVDG9XREkfXRtKtAq1+qOIBN+sICTKn2RdcjtLrms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkbI1noiedil155pWk4MsemEDYLDBJDUgYbvpFbqIdeB60jpvqp/WslibX1Fvu+CLFa36g8Gt8CruTJBtTnRD5ZbxfyRX9/E/S59eau+ROnSYXUNkBWbSrJ+V53SOoO5x/fVuuTOHNDgkKh1YWMM5mRIbVkTx0VSdmIaeCFP+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+UM4qUh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so7113671a12.0;
        Thu, 16 May 2024 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715892083; x=1716496883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfEGtxZOwWbYAEnG2Y0hgMrgm7NoPpGTjppO5Go7vv8=;
        b=A+UM4qUhKOXPUguCpxCDt2IShSR/5MLX9r8BAl/uBIQa1HYt2blcO4VA+dzhxjsVrW
         yUL9zEGw1rT7TNvMV1BC1V6QZJbuej2OiJGHYMbOk2loiK+1AqD3m/eIBCuwdPziGMqf
         avY96FXDmqNw4Cz7ub+Dhu3ZQuNLKnz3eocYlh2m7BD74Ju5pBKfmJPyPcOSi0YRidEb
         OwCqtYT0OngtiKF4wwcqBPp2GAuI9hU9JOia+um9+ZIuzlrQLpB0ZBNcJdVIK5Ow9Ruw
         hf29e7sEQxwvgZ0aqAcooTzSC3oELwhGztI6BT9+Zo7c8RnQM4ykOzxBNMf1tp/SzrJ7
         CE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715892083; x=1716496883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfEGtxZOwWbYAEnG2Y0hgMrgm7NoPpGTjppO5Go7vv8=;
        b=dWzvy2XMrhoc7lsyc3npRI7lb3QSnC1qvo2iaMs+Vy0tjIU7+oYlcepVy2YLrpwNVu
         0zIhCaRUEkFhzoV3Tc3ntp3tpjxV7ztF7zUGJvtIbWxlPPLz+dqkdVjK2ngGrf0Vvue/
         KPsl78zj3xwhBpAga0lOvx1YYWOW2DXL0OSdw+81CknbeGywdiKzOQChqX4z7oIGGmwG
         9z9Nmd7zeYtjR3NnlsknvC+uAtlhtQj7EFL+/CqEc7OzToef7B2iZ/aiKdhkR9F1DreH
         pb1zbnNx72X5yJ8AhOO9FHtoFBN2a8OKd1eyQD22CqIuOJiHc+f38tu1f1ib1Ql1342E
         yDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxldLnx+DxB6NLhKH8MjIafrXYoXWRtftJM1RSMQInimmxhBDfWLxzjv8qrcg9aANKi6YV3WhK4ErDxTqGhdAJ0lAqvE9/oCfLvDYYzlhXYSVYOX2WpvdP1FbEUFyGD2ZzXQfunOwAMg==
X-Gm-Message-State: AOJu0Yz5SDcHHEvxKeY9tkFIOGU6MYLN5aarX/kSQXLwySnKWKovvnwn
	rW3g0Kh0OgO5LyBlHxDyNu2OqefNrhz/Vtn+Q3KjdCzOSecY6sTj
X-Google-Smtp-Source: AGHT+IFjova7aUv21pnribbviNXI9uhtkJ+qKzW6NfePPjfYjxJ1ILWWZ0Ax5zrU68mh6c4a6ARE2g==
X-Received: by 2002:a50:c18a:0:b0:571:bf62:81ce with SMTP id 4fb4d7f45d1cf-5734d5e35c5mr17006879a12.9.1715892082576;
        Thu, 16 May 2024 13:41:22 -0700 (PDT)
Received: from localhost.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2b8f7fsm10859828a12.66.2024.05.16.13.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:41:21 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add support for imx8ulp's SIM
Date: Thu, 16 May 2024 23:40:27 +0300
Message-Id: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

i.MX8ULP's SIM (System Integration Module) allows
control and configuration of certain components
from the domain it's assigned to. Add DT node
and schema for it. The children shall also be
included. For the reset controller child, this
also includes a schema and a driver.

Laurentiu Mihalcea (4):
  dt-bindings: reset: add schema for imx8ulp SIM reset
  reset: add driver for imx8ulp SIM reset controller
  dt-bindings: mfd: add schema for 8ulp's SIM
  arm64: dts: imx8ulp: add AVD-SIM node

 .../bindings/mfd/nxp,imx8ulp-sim.yaml         | 71 ++++++++++++++
 .../bindings/reset/nxp,imx8ulp-sim-reset.yaml | 43 ++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 17 ++++
 drivers/reset/Kconfig                         |  7 ++
 drivers/reset/Makefile                        |  1 +
 drivers/reset/reset-imx8ulp-sim.c             | 98 +++++++++++++++++++
 include/dt-bindings/reset/imx8ulp-sim-reset.h | 16 +++
 7 files changed, 253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
 create mode 100644 drivers/reset/reset-imx8ulp-sim.c
 create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h

-- 
2.34.1


