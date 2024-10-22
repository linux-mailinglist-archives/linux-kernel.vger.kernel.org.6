Return-Path: <linux-kernel+bounces-375394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C39A956A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A427281268
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54012FF72;
	Tue, 22 Oct 2024 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2WuTW48"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73785C5E;
	Tue, 22 Oct 2024 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560205; cv=none; b=gohiIuNjk3VQqUdZaYbVOVhCU3rlPzRvCBgvJcvOWW2D4y6WCBPKtaZKdrs+5GbXSKtsjPyrNSBfTk5CjhGh2Z5xj1RWkHNSG4nY6kgPmVVMGL2UQRqsvsvZzpLJgs30Ud+LPyvC8lRi83bPhAyNQaj1vVegkftyD5EPa3hf3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560205; c=relaxed/simple;
	bh=nn2Rxbzki8aH4042gmU46/WUTDCnn3JnpSpUDXByOCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNWQR4hVbNPhX5Zohj8ZCTlIIXA2Mhi9D/6q+clQz23plDPlU6k2AMmlh2zXd5wf8MEgtBWY7vdqGuIe71xIf2CuFCm7FT0kzUNjXeh24SYHspDRDSFoIZOrWKHTUdklnzirNe/lDLny7+zkydNe3uNmlURA39NXwmZ3fRET+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2WuTW48; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso3348901a91.3;
        Mon, 21 Oct 2024 18:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729560204; x=1730165004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxtXGGp+IPO+JLVgjZAJAUQ+Dzcq0V5RhM6NRuq/n0k=;
        b=U2WuTW48vPEafYREG4ORlw9Ar+iPgjTK0H8vGYmL9gAgPjXoy1ijuKOaVoru2q8CM7
         MpS/ngaJKI8Zh3CHgzx4WnliS/AaRJ2Bd70E4ziLHpqeWtNKsv6RCDIjIe1Pg0je22wi
         Arz9vCM6yeXOpSZP/KRHXiASVEGn/SwKipHNoAmpy4DyC8j2ZHKIOYqkb/ecCKw469B8
         dCLEE6xqx3juFCXPvkoOlmvEO4iFEHlqxcl1UT+a91j5mAfAuoBAFWT5wyusvFsY67mu
         BaFtL+mnlgUBCtB6KLz/3rbtyumS2rwhPTzJZBC7QT4UvPVRGB2VI+8uPJBziVXQgstZ
         cumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729560204; x=1730165004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxtXGGp+IPO+JLVgjZAJAUQ+Dzcq0V5RhM6NRuq/n0k=;
        b=vM+tGGfYokAuGUHrRvj7QRsts/g6DvtdJo9edBGizao5flFOzU3XULdEXtyIRjY+L7
         EbunUpN9lSht18RRE9zlvLPEh8psCbCxB6kZaVohI9+TEwetcXrejNORZsUmZEgXrCdU
         Zs21cNcMAxu0AXQtk/go/iOUlRBH31nk8XTM5ySw1gGUq0gB9ReLxEjJq8b59O/JbSDt
         tWIQTzW/c1D606C/vZUvEe8+v8vGGhk4aQGUMwK8QDRRTi95k/gsfr9cY0bs9j2fVbf8
         YwrEoUKTKdVEdxq/SWpgYvnKtMtNsMMJZXGJyH8llBpHnuqjKXKPH+tMHaKgcIjjUkgb
         PDlg==
X-Forwarded-Encrypted: i=1; AJvYcCUp/TxzbbuAlrq+5MS/SLfJjHQJhcLkZVG+U2XEVxNHNoD6hPi+UWO/yO051Wf31rvXu0SpuKgeTkWtiUT4@vger.kernel.org, AJvYcCWe0J7qmgI7vZhZsO3DJfmjOWKqFU1+GzaAawhS5fRf73mWYfAqnlDeC/bVp3WH5KKTkSOG8fhVeYy7@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVVPpeEH6uHo+DqPRHeyDc0jqmo23zQlayUFOf7QR+rlp9uFy
	pSS2JkVJiYGhJjbIXIObr0TWz0c+v548A9hQNvt7orrpxY6DL/2EWHqjUw==
X-Google-Smtp-Source: AGHT+IGEcA425R+zt7O3mhkGya1ytfmxp/EH1+frDZZC/31L7dOO7/HqcpoC1ICNuNvhynWfycL5WQ==
X-Received: by 2002:a17:90a:d90c:b0:2e5:5ab5:ba52 with SMTP id 98e67ed59e1d1-2e56165ea76mr16533853a91.20.1729560203752;
        Mon, 21 Oct 2024 18:23:23 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d14sm4718919a91.13.2024.10.21.18.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:23:23 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 22 Oct 2024 09:20:46 +0800
Subject: [PATCH v2 1/2] bindings: ipmi: Add alert GPIO enhancement for SSIF
 BMC driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-ssif-alert-gpios-v2-1-c7dd6dd17a7e@gmail.com>
References: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
In-Reply-To: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
To: Corey Minyard <minyard@acm.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quan Nguyen <quan@os.amperecomputing.com>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729560198; l=1245;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=nn2Rxbzki8aH4042gmU46/WUTDCnn3JnpSpUDXByOCQ=;
 b=HwcYWWEZRDQhw8ANje8Mjiy2UnduAhS0y+SPltj9xaSY/Bfrd4THWJtvnIZNOU9IFMTUcMHVn
 3w2/K7UFoQaD+KjlbUYoHCi4s159GrnsOPBBSoDM6ISpSc6LhdzE/PZ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Introduce the `alert-gpios` property to define an alert pin, enabling
the BMC to notify the host when a response is available.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml b/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
index 02b662d780bb..7142151a3787 100644
--- a/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
+++ b/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
@@ -19,6 +19,12 @@ properties:
   reg:
     maxItems: 1
 
+  alert-gpios:
+    description:
+      GPIO pin designated for SSIF alert, used by the BMC to notify the
+      host when a response is available.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -27,6 +33,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -34,5 +41,6 @@ examples:
         ssif-bmc@10 {
             compatible = "ssif-bmc";
             reg = <0x10>;
+            alert-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
         };
     };

-- 
2.31.1


