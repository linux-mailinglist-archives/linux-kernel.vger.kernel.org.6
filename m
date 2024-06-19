Return-Path: <linux-kernel+bounces-221874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE190F9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CAB1F2263B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2072F15CD51;
	Wed, 19 Jun 2024 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Xgsy5uC/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828615B574
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841450; cv=none; b=coqLCjwVwIYUj53J6aqHCdmEcrEzx2IjFpgwDrwkF40+pBURqiZRVnDor1VGpnJ8nL++At5+jnz0Lk2gk76PmmR0UUSUO81/paMDeJuG7xO8abqKsTY93ceVUJKM6/xYE7Szulbl0EqvRvm1lK6FTcGgxYOW0aGot/BGD4ms1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841450; c=relaxed/simple;
	bh=3836YWi/G0y0HoDOgn/r1Zd1I60a7KUp+hbcm5o7LsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKPSxMMQlJ6JJXM2O4SbOUBZY+TQxdOP7UhehgSY8ms+U/7kARUkwwJAArqAhNy4jfRPESE6q59UyI4RCpAFVtLQwskwOLW93NlVf+dp+0Rox6wK6Yt+ZXdk9UTGh1rtqdMU9vhBZBacgod2iDVK5ceVPF48jxyBU55NfjIBPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Xgsy5uC/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9bf484d9fso4344935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718841448; x=1719446248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SzWiEwW0/6v9yw3GFd06xxYJICcnKoBYDsv9+ZmJTE=;
        b=Xgsy5uC/IHMF24wiWfwvnITDsD5kGLZ2XSNsehYTGiX+tBSI6DY/D3S94BUk9UynqR
         odSU8ddK+nYZxVNW6EuHBJNy2qFDk9v20xwORcjDszqutO69rfldHV5C3/QKMEB1hoX2
         7S0h+Obo8VG0BaEmuvYEpJFJks7zbZPtI+KpfWPEXcC7ceE/zMfgV8ikbcadmEVQ5Oxu
         Yi3q+akTeETiIpkbAqynWLkMz854MlPKk6SxpYmIVb0eTJm7w39qr8gcOBFzf2ZSFxge
         SQfLuAw9RNK7Ft/CTCeIu8+fVZD/Tg21deSRU2B3XeXnB+fLwXdGb5VjoMk6mMwibzbS
         UlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841448; x=1719446248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SzWiEwW0/6v9yw3GFd06xxYJICcnKoBYDsv9+ZmJTE=;
        b=rKdMF+Kot8Ih1syDSiUoHddT0xf18dJ3mJswn+yhAopBbCpaNaFCyAaSHuY0RHWOeX
         tPiTXf7V7f0Ti6tjbfoh7Ko76cLsUUq1OXoV0z+fvc4LMHQ/l8yChhY66BK6YTSOxIhi
         v9dSyyRd1yqvcs0N0KXg+w5mksB2D4Rzb+RGSs1EX8m3bi2ixwlujUKuf5G8flkHE6P6
         fk3ffIt6+c+u/QdHbE/EJjdoQzRBb7umr6cDn3QtYyh//fvXRHNzucapQn8Pa8cjRblf
         mA7Oh4XD2sLsB7FLj3YEiIbdQRqu6rLM2OSHc6nUY7aID8bMlsvGIMKas2L69tImkV2X
         Ua5A==
X-Forwarded-Encrypted: i=1; AJvYcCVSuj5Eg3qUcVFqtkXLVAOACrDsILCbh/L1zs/2cScDnzq77NyIguza57sgswwHejXeF9lYe4jy40oQSi1m7PjqYl0HzZPRVKlLjr3h
X-Gm-Message-State: AOJu0Yxs28RXWjlBCkyDdFSfAEQ/lvGP+4F/Klcu2ITG8PgWBZ0Sqfoq
	3wLsJsEKvZri6aKqw2rMaXR+XAwvf/vw3MO+xUFm1d5ga3KWOZFG56+LAI/+1/o=
X-Google-Smtp-Source: AGHT+IH+QkL4Wax7Iz6ZjMzlBJ+NY/+kG7ao8BQlvVNYsHfQl/4lBf2h+1KR/Feyc0Lz3mIrU+SpIA==
X-Received: by 2002:a17:902:fc4f:b0:1f9:ab44:9ee8 with SMTP id d9443c01a7336-1f9ab44a162mr47756485ad.32.1718841448335;
        Wed, 19 Jun 2024 16:57:28 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e70ae6sm123620745ad.71.2024.06.19.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:57:27 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 19 Jun 2024 16:57:14 -0700
Subject: [PATCH v3 01/13] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-xtheadvector-v3-1-bff39eb9668e@rivosinc.com>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
In-Reply-To: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718841444; l=1767;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=3836YWi/G0y0HoDOgn/r1Zd1I60a7KUp+hbcm5o7LsI=;
 b=dxvIYZiYAo2bW4UaX18zfCfCMPsGP1evBuld1bU4PKIqRPf2Gl68exv5TCJ4Pi5lSo4z4ODdY
 8CbUqKuD4U+B09ilUmny4YjtLfW4jJCTJJV6grwtenwPBStUvUY15hX
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The xtheadvector ISA extension is described on the T-Head extension spec
Github page [1] at commit 95358cb2cca9.

Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..99d2a9e8c52d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -477,6 +477,10 @@ properties:
             latency, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        # vendor extensions, each extension sorted alphanumerically under the
+        # vendor they belong to. Vendors are sorted alphanumerically as well.
+
+        # Andes
         - const: xandespmu
           description:
             The Andes Technology performance monitor extension for counter overflow
@@ -484,5 +488,11 @@ properties:
             Registers in the AX45MP datasheet.
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
+        # T-HEAD
+        - const: xtheadvector
+          description:
+            The T-HEAD specific 0.7.1 vector implementation as written in
+            https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
+
 additionalProperties: true
 ...

-- 
2.34.1


