Return-Path: <linux-kernel+bounces-210316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF4904241
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349EC1C243BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CB4644C;
	Tue, 11 Jun 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tP5/ARHx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0295820E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126197; cv=none; b=EF8Q/X7y92Ahfex5L4PzCZsnRIWqC98+xELE6Zm/HSve6fXMPX1YML+FXcSStORsu5b+tYfkrxeBkfZqZY5sddfGXl5DfSpF2ES7HY4Bx33VI72WXqnVEXwAFv+xh9cY9+6UJipP3CxthIMtuDrWv4MbTTlS0/Hyt1hSVzRH2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126197; c=relaxed/simple;
	bh=ItN7sUriAhVplO52bKTv4k3DGMtoiNHzlLUeJevwpTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KAGLxe0IHu9jGWBrwEvm5L/fvBavPQUDA5V351FLoyEAUr2sU61kNbEDrmv5AwP7WDg/HO2dLaqfR3HXlx42GQXEtW4TMRm06bcP5HBEO3REnWhxffq4FuC1tjXF3iB8Hf0KpD1d7y6ldEn10woCqnn9wGcGvSGUTZX1oh61Ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tP5/ARHx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d032a07a9so23739507b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718126195; x=1718730995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/DGU+PznyeuU3c5ytQHTeE+L+VrUtxcZcMVxa+OmY4=;
        b=tP5/ARHxIaAt3xaPerPVus1vXd0ci7sGFdhoOpF9FVO7U1Gbh70WrwxvM6fIMSKKWF
         TUS2QWjkk/iTvW4JCVqRQ6IUjdF9GlSfSJNNgw9YuISacDCd7d4DPLt5I8qioNSDm+Gt
         ZbptIZ8CDUJ5k0tdmlmsdFA90sguo9+wx0t7QJqz1JGr7Fwyi4WJLdqausOT1kpxCKPB
         DvWydfEDdQHN2kzD6vgCkioKjBhWtZ8XJFecbYbPTDkdPzHNVSjZXh9KPphSSx4VO4dl
         P+yyZd9vAUrw/jor+pSoSf5ItUMRxvzk7jtT8Eh789rb/Gb6i3XEADm7GgX/VG4RGFh2
         v5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126195; x=1718730995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/DGU+PznyeuU3c5ytQHTeE+L+VrUtxcZcMVxa+OmY4=;
        b=kpbFrofE07hJcHDnKMgI/SMe8fwcJOPhwGpmouq5XgKtMywpm2UetTkF/qFe1hRklH
         iarMjCaeFYfFkCuM0EEstEOK/ykG4AMTCP/AEIAScMrSleutSqoYvs95OccMsZs30bAy
         qNcX0w9BzQzI7Shzh0h4rDXe3dH+ehiludcNqCQnIL5Tjf5puch7TRPvgW4k7cIOPBvb
         FY9+TnXwdfJKBss4yy5QGXxYcEhPQXak+q/pJkZwzu9dQ7Il2/NvZM/GFcDFN5V8ybSZ
         gorgASXmY9tWpR4wV1ktsgiIN7hcfXAM6vKgwNHgt4nGh6uHKARfH/opBMuH7ymuOzzV
         YELA==
X-Forwarded-Encrypted: i=1; AJvYcCUYbivW/RuAP/qeRroYt7INIf8OWqzY/4pXKbz4ifZJUPhX4qXHx4d/sDwJvSXdT8KaaPf+eJBdyS3+DztSBkkUxQKsxr5YTm+vN7Ni
X-Gm-Message-State: AOJu0YzrOSG28pxE0GgyspsQDlv2xA/BADpS8BH1jcZNGPmn2TbtjcJN
	batXcRLqeAl+zvrstUqO5BGDxHy05U/xrA0PovI1TJJjL7OJPHrhv6xDFor2qZ/m+lEkY6HxOPj
	fuSL5baDA192WA9tkgRP+8UeBQQ==
X-Google-Smtp-Source: AGHT+IHBusrZw8MLw8qciIrjtjK+WEfeMpPS8uwfN1BpXvw/8erhWM1AECRWM2Fcvj0GiFs+YyHVKKN4D1UD+9niggI=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:10c1:b0:de5:2694:45ba with
 SMTP id 3f1490d57ef6-dfaf636bf55mr3809274276.0.1718126194618; Tue, 11 Jun
 2024 10:16:34 -0700 (PDT)
Date: Tue, 11 Jun 2024 17:15:59 +0000
In-Reply-To: <20240611171600.1105124-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611171600.1105124-2-aniketmaurya@google.com>
Subject: [PATCH 1/2] dt-bindings: i3c: dw: Add clock binding
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Add dt binding for optional apb clock.
Core clock is mandatory. Also add
an example.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 .../bindings/i3c/snps,dw-i3c-master.yaml      | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index c0e805e531be..7e3d4f308477 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -20,7 +20,16 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Core interface clock
+      - description: APB interface clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core_clk
+      - const: pclk
 
   interrupts:
     maxItems: 1
@@ -49,4 +58,12 @@ examples:
             pagesize = <0x8>;
         };
     };
+  - |
+    i3c@10400 {
+      compatible = "snps,dw-i3c-master-1.00a";
+      reg = <0x10400 0x1000>;
+      interrupts = <8>;
+      clocks = <&i3c0_cclk>,<&i3c0_pclk>;
+      clock-names = "core_clk", "pclk";
+    };
 ...
-- 
2.45.2.505.gda0bf45e8d-goog


