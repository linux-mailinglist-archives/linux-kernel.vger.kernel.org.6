Return-Path: <linux-kernel+bounces-209022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C2902BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA22824A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5615251C;
	Mon, 10 Jun 2024 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="txk7Z8am"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A8152170
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060210; cv=none; b=WxOxa2FRAmVW5wM4ufZrwpVewBEn7PNfvHhQrLrgya7fLbZyDRMm49Di93s7ucXfKbX3XeJeOlA/0HEpsQGIRlfO7hEKzk9Lcl99p+OR7MVdEKTik8gGDcSExVP/o0P5xsOypR334wfzp5LSH8l/+ZEyITtWmt3qMK9dhB9HJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060210; c=relaxed/simple;
	bh=BFeF/rMqjmAL/T3qO395y21tghoeF4vuGyaBxCV02tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gX21HsF8vaEE7osXKF2pcb6TxX3lsE4jomWDVuAq3aVQ+Ibtx5KLq6epNSlegt72WUZh9TtHPxOPE1qaz24/ziWNNZWZZnnsda/W5Urc4XlbWTD6qITp5s6Gpyhi6Ln5J/zJ2UMQPy83mGE4u4vTfTaH8XGnocfRNxrjn3a6nbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=txk7Z8am; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-704261a1f67so551053b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718060208; x=1718665008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gP3BTCO/eMabIcPEHZlkkrT/LBtjjbwR/exXvwDsR0=;
        b=txk7Z8amtZTt9hQNy0rAMb4E5PfIbZ0LIXqsp3kePKxipgCBTIeB6L57YnBs6jNJYt
         /wcQUIFKhT2HRRQhJ4vNqH9tIlTkxEdxKDENJvqg3YacgWHW7AOXfRRyhCU2l0gBp51M
         ofz11mZdAUHLvkkYB7kF0OBBnrRp7pSpYVEcN9Q8ECE0RHrBGtm/nwhwPT+KhAiBEDUq
         N7M7YjS+/tdUuSelxYFkDePMc2/BEKbpIsYpGk8AgZ+3dX0i7AlyGxGT7bBVDMztI92c
         504066bGYxzI53IeZM7H5H3jKiz9z6Sr3AGshbNbqpfPH8pG326+KDXlqKnQVtMn3iTB
         41jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060208; x=1718665008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gP3BTCO/eMabIcPEHZlkkrT/LBtjjbwR/exXvwDsR0=;
        b=tXraO36IysbYPOgf1Sj7A70qaOmkAc9PLsUKlTwwVMY+kMUuMafu9HNBeTB26JwSJg
         fC/v3wYO/+jKAsLIAaJ00V8IYtphxqob7dEr0mnyqbhzE1PyewYl8Y1PwKLvEMzoxBfV
         3wTWRa/iR2t/m1n10aOrRjTVybK3AdtelFDg4852Am79bJC/2DtaLwNG9EO+yJMPYIem
         ubX9L/VoIXy3QYwzX+m9Nu26N7bWK8vskDoKYVxihc7C33k5kt85KMJZpb4GaR6rKmiL
         utOJXrnZfj+vndyDJGkeIscENTKxGqiMR7+dN8VY3odHZni3HIeOn1ZkkYFYoQ5nXja+
         bkDA==
X-Forwarded-Encrypted: i=1; AJvYcCXqvhEvkmM2qYFszcnkGQKtUAndrJPtQxvjrcR5Mg+7d3Hb5YJcVcpe8cxuwQDeKYalInonXciDG5JgslSmk9254hVz446QRWd10lfo
X-Gm-Message-State: AOJu0YyQu39fhi2n5Zp6D9DbaxXFzYjLq8avwlSj+0hhcQ2G1/tjdld2
	LlQSOPtuAoWPLz+K/QS1DhGLvamCKvFmxKEBpcpWO3bPUcSA8amCPDHrZsJtD6Q=
X-Google-Smtp-Source: AGHT+IHTScRC6npLyMuiznHwgZ/G81KfDT5NElI6OEIE3NMqZ0s8az3fTA0+aduaOIuSYA45KLIADw==
X-Received: by 2002:a05:6a20:9c91:b0:1b8:6383:dee9 with SMTP id adf61e73a8af0-1b86383e2c6mr1326576637.47.1718060208075;
        Mon, 10 Jun 2024 15:56:48 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm18355865ad.99.2024.06.10.15.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:56:47 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 10 Jun 2024 15:56:38 -0700
Subject: [PATCH v2 01/13] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-xtheadvector-v2-1-97a48613ad64@rivosinc.com>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
In-Reply-To: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718060203; l=1767;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BFeF/rMqjmAL/T3qO395y21tghoeF4vuGyaBxCV02tk=;
 b=mbyCO06LEziXabJRwA0QrR1tvxFI1gB5h8SNd3p3WMt0inTqc+ASsfLiJiyJb5P5ynG4xIGKs
 L3OoiPaYjkdC5ZD3vvpW0fx5bUdLT6GOM5axMfpSweVCy2O9ODt8uud
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
2.44.0


