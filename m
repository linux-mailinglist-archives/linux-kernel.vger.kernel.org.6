Return-Path: <linux-kernel+bounces-261435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C9093B74A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADE2285A13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1716CD12;
	Wed, 24 Jul 2024 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FstU5z+v"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FE16B399
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848446; cv=none; b=a5ZRXYavOSR4sav3/vvSoJK6HcDjI2XWXh9B/UWg35s01p2y5VDzfK4/ZeRsS1CgNRvGabD1dMC+b3oeJUcWrfURADpgyci480qWAs53xlQZCA7FlXC1+2NqnyJCbXTvBHR6yWDAWyPSs2GxHMtVvYupu8SCkgsDd5qd0Wo0/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848446; c=relaxed/simple;
	bh=ZzH0VgSdYutk/uKY2omj651o9v+E5HP1BijtgXJzAp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8RVXkCnlwZNPVJ/yNioCHSHG3HQR+62OgACpQ+KODNfyS3fn3RHu/sGiWHVuZLb5FPwaAjVQZiVw1c5qlG0e2IxN8Gax6JVWqNTTjPzW4YAJgsH3e2dOIVv8W5xhMIt6zzmDHKLzWdHuZENCGeE3wYOg9yrM0TgsExZQ1H3MS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FstU5z+v; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a1215dd114so105163a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848443; x=1722453243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWtR9ZjYZiSKNZtqnpkUxp+qNZzbKrCzo+6HVfyCbsc=;
        b=FstU5z+v2EZl6TQEkx8Luhv1wm6HxXInyCHHaie92Cp6oyFICuWMLWFJsKijwLIgla
         jtAFLIikCyf4kmCr8Y7orjLvDvFldULXOnEoTTY0n85BAynfRBCmQmflWWAIXSJGBsdE
         TJEve7meNdNkjU1QiAjqKuTbbvkUQjdJUGhgC3+Ft8o6f+lqqWkw3GQWSYvA7Fm0FBmH
         lzZi1P5bYRp5/609Jl3ahCQ1G154WEsGSzpi/eB7nzowh+tfRjFJvMdiKZLtHuhzzbr7
         DDE2YbwbkABlEBAjlw+6OPOlPxNtbRLkx9eJzQ0K5szNJoUz9biIpUvgIhj7qGad7T/N
         giMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848443; x=1722453243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWtR9ZjYZiSKNZtqnpkUxp+qNZzbKrCzo+6HVfyCbsc=;
        b=TeG3ykGi0h905UVsPROJA4/IEBUs3WP0xNvAD38mQ78eOttCXI4K6iLADr2+knHc6X
         mzAkAYyLXjUWaG5t2rEgNce6oGG6hAAq0M6pWURm3o2e502II8icIqGiEp9XgM97hJtm
         xUn7MgOuxV0UfXCgMDsTYWhGmRQjI+O+zQ1s3R1/B+PnNZ3M/IWQi2Ag01SznL/M8gYf
         AmEougOI9xzaBRv06Hhxww5biV0GQNnxOUrjr9+yfdyx+OYAD3xJ0vQJwuyB4oCltaPL
         RX23ebVu79Bg3E43ncY6ehp/aBMxL0glzCgyq38Ds2k7v9xOnRmWe2FS93kyoMvdUuS9
         3a9A==
X-Forwarded-Encrypted: i=1; AJvYcCVrVFAIngsOR2bYWKSTv9ILgSBWoDaUORBk8ZGo2x14U+VEE/L/oZ2GmUe0vyLZI0eE1NsuvcX0zyms7TjSdNNsLJhAkPUu+bCvgsgL
X-Gm-Message-State: AOJu0YyAhRMnc/gqaTVNzdfPGjSbbj0WzWjI32XkPBfEiGirkD3mTAdT
	XipFoAslH8VRegcYpNjlhmgb2f9A4neh2YRzs/Ocn2hAbvVuwv0d6Uv+PXnaa78=
X-Google-Smtp-Source: AGHT+IH05meby4+2EXjFgjam7LAliTRmTubnFATA6oDUhsso55xLxKhzyGK68nAM9BHIX9A04skdVA==
X-Received: by 2002:a05:6a20:72ac:b0:1c3:b0d4:3e8f with SMTP id adf61e73a8af0-1c472fb13d8mr1037520637.14.1721848442605;
        Wed, 24 Jul 2024 12:14:02 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:14:01 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 12:13:52 -0700
Subject: [PATCH v7 01/13] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v7-1-b741910ada3e@rivosinc.com>
References: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=1788;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ZzH0VgSdYutk/uKY2omj651o9v+E5HP1BijtgXJzAp0=;
 b=dR5c7ckZTs1cKin6Lbis5zjwQCaBrNTRDODqsLLnFPnwcJ2p+c7cE5w58tm9O4LgIawNkO0cT
 pquX6jLm+C4AKGK5w/+LXn1eHmAkdm1FU3PKqEqJgnv3qi//AIF3pgV
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
index a06dbc6b4928..1a3d01aedde6 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -556,6 +556,10 @@ properties:
             latency, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        # vendor extensions, each extension sorted alphanumerically under the
+        # vendor they belong to. Vendors are sorted alphanumerically as well.
+
+        # Andes
         - const: xandespmu
           description:
             The Andes Technology performance monitor extension for counter overflow
@@ -563,6 +567,12 @@ properties:
             Registers in the AX45MP datasheet.
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
+        # T-HEAD
+        - const: xtheadvector
+          description:
+            The T-HEAD specific 0.7.1 vector implementation as written in
+            https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
+
     allOf:
       # Zcb depends on Zca
       - if:

-- 
2.44.0


