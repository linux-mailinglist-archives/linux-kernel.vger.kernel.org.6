Return-Path: <linux-kernel+bounces-574912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08CEA6EB82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448ED169A32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083D253F2F;
	Tue, 25 Mar 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="audrdITL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E51A08DF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891230; cv=none; b=FGjua1OHafT18ypalLHEzQhZkKJ5KKSsR5cbQ6ElUvx4s/J7Dz+mrGmpQ/0X/QcfOMjGrizP+dbIej3oF3De6oEILHFwYCQ1uo0gcVZYZ6NJDGi+4i5+1vnjD12bdJIHvgJHVfPkgTQvVI4QgyTm1KNi44/uAPpmYcrfSASfAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891230; c=relaxed/simple;
	bh=SPqlnkjtrS5DVFkshdhSurAaxj8Nd6Gmu/f6A5AIxGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T86w9da1Lcw+yXaOYZAi8z+wIwae7Dbhos7rojZGfBHWPe4aQTUcDM0y8J6oPYb/1AkYK46J5daLO2LHEHcIsho50hs3z6bYBM+MsfII6ySg6EwdgGffSg8Vht3zfWvYV4+PHQy1aKqyn+2jBkC+yO/3BcTI5hWpn4HGMKe8DuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=audrdITL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so6957003a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742891227; x=1743496027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6hGtk8l3NJ5m0ZZ1f8dhJbnrFpOfREyFqNdfBX5qs4=;
        b=audrdITL+3JD0qjIVIRgUWyS8b6jX7sm9yXG/1MFXs3U2QlOh9v1y9c3P9kozkKtDS
         ZnP+aZYmF02Ep4Xb+HIxg7sleFZZTQxJei205UvCICrM3DTPbfan2E2apI/cE0EPeMb5
         zKUd5jMRjhTYUTjqfqetEPUlDbfgITeFxcxc8c7Lfvo/BGzR/SbW6DhZhFCUZaEFt4sh
         GLF3aBxYusNBB5h9dsfP4RjFQwg3NedQg1SiAnbQkbw7Oy9AsV2Qb8Oz8TCWC1LjHpDo
         AaQE7wQ4G6QBG/uh7pvua1kfBH6+MY5oGNguecz6RV+tJx8f3Lr17eTNn8cxrSvBQimh
         RFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742891227; x=1743496027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6hGtk8l3NJ5m0ZZ1f8dhJbnrFpOfREyFqNdfBX5qs4=;
        b=Ro6VsOAmdge5lF5OeM8CO8h51ACVtZIRRIZcQtT4OlA85SJqEy5DD67YQyKGdryau7
         HlJkPZkepCf9Fu6ZowWj0KBty9GhcSgFhO1F3Hk6Yau7jInfzhCYLcnV0EZHx8N22AKf
         vDs4OBjesICZjVV+0I3wlktVV2dIA6AjdOt4XzJGOlk098rLf2/foIFT6OwvQrW+dZ9o
         qR9D+2xSSFOSlhac4HtY3PCOd1nG22t9wZxk6CTAA1Dly+QKkBxsDSps7BCFoSdm+4Cz
         V1CuRTBC3vmLioAM4Q28KnhpuXogNFMggj3Dw8ReXJL9FWSoM/p2ODRaQBcpnfbyP3JN
         KpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2v1VysCm0CiFtXb8SbPtPIPK0q+9QJz85WeYBvImDEQHzFvFlxpAcy9+u81mJtm2srOU+EPx3B8HWZy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlMUJjAW/u0GTbBjT3fT6CEuURlPhkBzFlbqJS/QsSWcTX69d
	2VYj99CIMFTpdpKrerZyalzERQJrKRdto1rQ82bnHk+MVDk3tngGAxF4ecn84Rg=
X-Gm-Gg: ASbGncuqqrwo5fmuJePdU1lGo/FQV2+PcVx6hCGsZN4PwzcMGCBtF+fCIQcV0KyQ1x7
	ptD+Kv/Iv/UVuXW/O/v6jFXqPDdEWrJka9UY0oI8AgHvGQBtHQbbxAS3zpTt9G758aSBmPmVb+o
	mTreeHzdp+oljV99kJJeJWq/cnn4Ubsp0h4y8pB6TofZBM741pr9Af8CaonEaRBASJgDRws0nmt
	dRmXsgQUUyWFVsdp6+1WmwZeCzOO10POFS3+mLtdHqJewRh0PxcFRO070hDQAyLTljMCVQophBQ
	LKeKxp+PvWVwen60KtAkkhVswFruka3Wk9kZPMZwkq1NmUx6yufCoZRzmFuynJeNuZcAfn0okGw
	UzOCsxcGHdKNFladbFmMinHZTlJPC
X-Google-Smtp-Source: AGHT+IHsx90NaiqQbXCOGp0fcibvruE9A5P7xlNyFKRVB8QYQJ3nkOK83Yyo533oiwE+WjcVKloNsQ==
X-Received: by 2002:a05:6402:5243:b0:5dc:7643:4f3d with SMTP id 4fb4d7f45d1cf-5ebcd40aff7mr14451507a12.1.1742891227067;
        Tue, 25 Mar 2025 01:27:07 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcce36d66sm7377366a12.0.2025.03.25.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:27:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 08:27:03 +0000
Subject: [PATCH v6 2/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-max77759-mfd-v6-2-c0870ca662ba@linaro.org>
References: <20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org>
In-Reply-To: <20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes its storage module (NVMEM).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
* drop example as the MFD binding has a complete one (Rob)

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1e3bd4433007341a11040f513bf444866b9e38a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/maxim,max77759-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 Non Volatile Memory
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This module is part of the MAX77759 PMIC. For additional information, see
+  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
+
+  The MAX77759 is a PMIC integrating, amongst others, Non Volatile Memory
+  (NVMEM) with 30 bytes of storage which can be used by software to store
+  information or communicate with a boot loader.
+
+properties:
+  compatible:
+    const: maxim,max77759-nvmem
+
+  wp-gpios: false
+
+required:
+  - compatible
+
+allOf:
+  - $ref: nvmem.yaml#
+
+unevaluatedProperties: false

-- 
2.49.0.395.g12beb8f557-goog


