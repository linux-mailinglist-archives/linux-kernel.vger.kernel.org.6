Return-Path: <linux-kernel+bounces-393850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3119BA641
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B46F1C20CAC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD7171E6E;
	Sun,  3 Nov 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vEo2u1/S"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B417DE15
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646255; cv=none; b=loDbvZKVBXW3/2MPiTHw79E51rd64vu+Ya30jWk40HRzomZcqGpLuMLveTpiyFkEwIXegPZx9FSkHwCB9SWnnR00Ds3DqUOmKQpUkHBedZwrm9KFsTvKU9Pbwwmk+83UlJb6LfKIW8Z18EyYDq8PURZaXRelIjOtbnh9GFuHP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646255; c=relaxed/simple;
	bh=DDI2zIjw9AIG8rhpAgDtY+aKq0SOPiidb9JfsFGBdSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UblJkY2Yk7oaOq3IIEoizxr08RoGGa4L/OPm/gZZ4bfI06+IihPWULsBZI2HOfS+rUycSX10KpHiAf4qIj/HxViudYQufn1BUkl3o8wg/0r3WeQJ/D3R/fXVoLveRZc2ldQjkUxu9Av9J1A1iBQiedgmUkbZ+nCwZaFbaD4QIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vEo2u1/S; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43193678216so29773315e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 07:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730646252; x=1731251052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYOR6ehP8ZUAtZy2SlX+P5w8jiHdus9J4uApBvZwtJU=;
        b=vEo2u1/SsXzwb6c1sxGlxeEGJO3XSMf6TUC4IpOAU6NTove6jX6XfgQ0DK3L7quoKc
         fVO4LdDRytFgoLxE2GgfJbUzaBmV4HLpsw0ZlstCZtxyA+xbvU80+nDqOg8HCnjEvjDC
         ujqbaROapfIS1DqDVvd9ZzRura7stsd86lVDomuRO6yMK3dXtAB/dNN8IzBW+u/bM95I
         ifTTEfRSjMCGxTC3h90sfXYeUJoDOaBDtGL48gMB4pdtjuQI29yc/OFE6k2PaaBXrOIQ
         kz4/bMwNFcP0oF+XF9BoiJKmRpO6C8Wuov9SEsjwgJ4PZHxWF2OjfFqX9Q6MZUvyJKb1
         GxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730646252; x=1731251052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYOR6ehP8ZUAtZy2SlX+P5w8jiHdus9J4uApBvZwtJU=;
        b=CBx50TpnjKEa/WXsFqZSOKN6auU1nFX+sx9r+mJITv9mCn6iOB2hueRWW5eTktcH57
         dDQNnMbo86R19G5/DsPaNbVKcQfAOHoZJsnrGnhFIimWzWLEU+BjxOidkI0dcvGvR/Lg
         duQUymaAeOuOOwfYKbP6LT21h6GA4U8OUcCMBw8JjcnJ3v1yHePKXe2P9VrucEeODQoQ
         s1PD85CEJIXFcKjnMW2jpZOFBPlr7DhLTgFZzKJBsUa16bLjhfxBPIgYfI/+VYn75+Tb
         VFwlGQpiLRPvVRS2Qa7c8+jZa2LHtzUL/kl1jwi+bF+wE3VP+y2GPEjbqVZIa6h0nxpm
         L8AA==
X-Forwarded-Encrypted: i=1; AJvYcCWAAqBckrC0Qr0dJt+Y23QK70kFwNoNuNH+XOqBWICp3/CX+rFhKkhT7l+zoO0eQC2NZvlCbTZbp7lQFzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6FufiYMLJhjhV4UmPjsvQ+jaQgl/fqxjY3W7TV6Y65IGZeei
	ET0+3tmwjsMzYlo+LenIzG+6B4nh/pgxKCFYezxrnazeU2C/97oH9lTdLEQnpv4=
X-Google-Smtp-Source: AGHT+IHLb+bX4JOWUSFmTs6UYPJV8WTvK/tBJRvIgcA7ae04ZGiofBjbX29h/oO76eksCbmobaHszg==
X-Received: by 2002:a05:600c:4fcb:b0:426:5269:1a50 with SMTP id 5b1f17b1804b1-4319ac9c15fmr240004605e9.11.1730646251731;
        Sun, 03 Nov 2024 07:04:11 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b32sm10858711f8f.18.2024.11.03.07.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:04:11 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 12/13] dt-bindings: riscv: Add Ziccrse ISA extension description
Date: Sun,  3 Nov 2024 15:51:52 +0100
Message-Id: <20241103145153.105097-13-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241103145153.105097-1-alexghiti@rivosinc.com>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Ziccrse ISA extension which was ratified in
the riscv profiles specification v1.0.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index db062107823b..35a9ad1d7e63 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -296,6 +296,12 @@ properties:
             in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
             riscv-isa-manual.
 
+        - const: ziccrse
+          description:
+            The standard Ziccrse extension which provides forward progress
+            guarantee on LR/SC sequences, as ratified in commit b1d806605f87
+            ("Updated to ratified state.") of the riscv profiles specification.
+
         - const: zk
           description:
             The standard Zk Standard Scalar cryptography extension as ratified
-- 
2.39.2


