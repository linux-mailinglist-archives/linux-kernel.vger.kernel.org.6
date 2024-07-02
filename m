Return-Path: <linux-kernel+bounces-237453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5089238E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9F71C2029F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612114F9F5;
	Tue,  2 Jul 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IeFIP8cB"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916F14F111
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910380; cv=none; b=A/Uc9mVAyga1+ysLEl15WPR0+I2GwljLO/9c12Ykalxbt6it3x2GZieLQJCm9ue7ZWStTCKYfFNzJFBvdDCveKxRv8lVXN9wtgIcgJol86lw/5C7C+CkMlZ9w4aYphvvBCuTMI8lq4ebUM35w9Zgkh7iW9PgQxvdHPzEyOszuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910380; c=relaxed/simple;
	bh=+JvUDoeNSyvi+ZJSJiTWzNfp9Z1R07b8HKUoZPogfYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKHTYk0LX4FZS8NVyPztkuu4cAW3pVWOLdHhN2QNw6CG6511F7DLm7/hN4AXI7RBI/xLzwaJ3Ld1dHGEGFyosOvJ2ZINZTnSXzQWex8wIHldxz9B5ZpyhS5ncXQKHMlwV2fNxL1JsHyg7cmNA3l5Vt7jIKqy3Ad/VNSrTx5gfF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IeFIP8cB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36703b0f914so2414097f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719910377; x=1720515177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBblSarVHgMFr1VSeSy1dk9YozNFS90bm9c7S+clMb8=;
        b=IeFIP8cBsnOevcNJEwqi49zqXpZTdPq62triCBSkkPXc8pSSsL2x3fhEvIc5ObKx8/
         G3jdw0HdBskdSDdkpppik0MnP9dZ4xqXFuT/yvi5VK7rziUrWkqUVdLzwvxBO0pTtbpP
         fdIOTbyLRdDKNZyrbqY+obyYwKDGq1eQfGAAUdYGhCW7+OsHxCL0R2KpoQRwHSMebvH7
         GS2n0+eFyUXzSEhSFpTmEuUEtKSuGi3o0WgoFeqWCs7EywLhaARMPDG1oDlo2YE1nVjl
         +6LttyB6qM61Ms4T/EbwynHBqCHU9eRoYnnV7BNSuzYVC5nBZ/xG1zzEzZ3KFmd/kY8l
         m4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719910377; x=1720515177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBblSarVHgMFr1VSeSy1dk9YozNFS90bm9c7S+clMb8=;
        b=MBujkac6bUJdPhQyQnb7vaOnmeA7H1ULkWzLe+oHefj+GJcempWC0aF0ubS3n3vK+p
         41Qj4x9QdtbMFZRUrTT6oZ/gIFXmS1sW7HRk9DvU07F8fyVdT86VpzBOuZnzCmLfG/fA
         7m4viSoQ/ZGg6bbcgsQ4ByaPawSZb1tKOiKGB9Nko99pjlfaiwEsh/bZqWoh4aKoI4WO
         sTnZfcyEcz5Tytac/1fF7lLAt79fUdaFJRgLUWxeXxMAE62yKz1sbNkntTjVh/qmgzz5
         w+MPwnhA19zuW6S/sR4ODS37wEwvmcGZqtZOJATCzFFb7Y/HjneS2kQQEMQzryIaxhdn
         RXOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrDIvxPIdJ3YqlB9S3EhaXie+brYYhEhO22HXA0zhTGxdQDYa8Y+NU+ZcKw8hZvfFUL1TXq5H4KYSeSdD3GgaNg9zm2ecgYj/FZbob
X-Gm-Message-State: AOJu0YwmuknokNxvYlEeLHVrlSZdiWwtP4pmVPTuuDPxemF20F9YBjNG
	hxzHeRcBSqmAWdE9MXetX13ZSFKvX2gbpgpUTJJFf6PPaBgdj1iGbu8wQ8siIlg=
X-Google-Smtp-Source: AGHT+IFhEaBGka3Ti+hlZOEC6CfbyAu8S9sImqvjdSOCqz/0wRb9B50fIT/vKC7eV3aR2yOVb8VmLg==
X-Received: by 2002:a05:6000:2a7:b0:361:94d9:1e9f with SMTP id ffacd0b85a97d-36760a62e0dmr10948760f8f.7.1719910376818;
        Tue, 02 Jul 2024 01:52:56 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a828sm190852585e9.37.2024.07.02.01.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:52:56 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 2/4] dt-bindings: riscv: Add Svvptc ISA extension description
Date: Tue,  2 Jul 2024 10:50:32 +0200
Message-Id: <20240702085034.48395-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702085034.48395-1-alexghiti@rivosinc.com>
References: <20240702085034.48395-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Svvptc ISA extension which was ratified recently.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..b52375bea512 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -171,6 +171,13 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
+        - const: svvptc
+          description:
+            The standard Svvptc supervisor-level extension for
+            address-translation cache behaviour with respect to invalid entries
+            as ratified at commit 4a69197e5617 ("Update to ratified state") of
+            riscv-svvptc.
+
         - const: zacas
           description: |
             The Zacas extension for Atomic Compare-and-Swap (CAS) instructions
-- 
2.39.2


