Return-Path: <linux-kernel+bounces-268691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F041D9427E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F91C214F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351971A76CE;
	Wed, 31 Jul 2024 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZcfM32kq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760B1A720F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410896; cv=none; b=fQqVxIuDe1+czZAf545/7/wZzjvXReQszeuYXoBLxFcODI/H6Nh+ILf+AEWlKXDG9IjqSXgVRdPeS8UzTyiOP8VBIvugaoRlU2wdY8QpwNFzo9PXg4Yu21cRDXOyDYXUWPINJKo1XY60weQtW3+6uTaBNeTU4q6NUG6DqUr7JVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410896; c=relaxed/simple;
	bh=CmTtLX5RKwq4LF8rnnTG1fDkLvs6br7ryZDyRU7huqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFfNpra7ugoZNIeCDJcJvwLGXKDicMZFJBtD45ugKmBVUTeIVsnSs5ugp+ml0bfB5fZpHQ/igXzX5vKjtbzp8nH+X01hfvdpRaPG2SaxDOBJVYuyOoW5tftfrMooR6gpx2NUoXScbFIfFiL2n1I/8nvv7ruq+UtorEgUq4tIPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZcfM32kq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ef95ec938so6663784e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722410893; x=1723015693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttjywx6Mo1/3X2D9jge6HvTlgUDsJ3yzsugn6JInGgA=;
        b=ZcfM32kqfqq3puQI2vnxu6q1EZ0wDSDuHIWKlnZI1HRnKOeTq9f6YXEf+vBrPw1gb2
         laKur3vznCeRwfX8Sa5U+uR5GK5smS0YfmgxWtCvpk10uLEJKw5yJe9JlTApg9OMb80t
         CtdeYwbeTHUYHoecBQ5jZzJEfNlFgfLG6/L+fAly7sGZG8gkKPhakkIYrZQZBVIwx9x8
         k26YyVumDYtJInhq9LCcjC7q+y+eAVz0VXhHWpBDPdlOi3l5pShNIgrC7SZpOgIj6pC1
         du2y/v0n1Zo7DeWw8nB3m4HxsLPSlteUMLVK0e8yu8TwmViRHwcHklwtLl/YlSADJ9qo
         KxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722410893; x=1723015693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttjywx6Mo1/3X2D9jge6HvTlgUDsJ3yzsugn6JInGgA=;
        b=i6q93qWfGlAVbghxwD9iw/xiYaRd0THuHxSEtDe/uXhxqMu3KU+4ZXMzCcWEBdWwBJ
         TWVxi4jWhZvHt/a4R0ceUPeF8lJRtOyqJGPtV54j+B+rmLmewhVDrF1NXKpell6GVio+
         JdDdScitGHdfAoukQ6zH+dHwjrTwPGliUHy4giFB574pFqErpZRajMuaek2+CWABrpUf
         IpNQGNhDXNNlapHG5ptSKJsik0uiUHSSHhmEax7MFVAA5aPbXcvt0+pj5xd8wD1il7ga
         j+HtQUm1MB/GXACOiBWze/ZZRw0/kLHAI1+JlSCQt2clOLoDCWSAveOWOkVuSN2jLCyP
         W5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5JN+o3nBbpXozWZWxnF3QZzhqP+uC7BJ2UJzj7WWD3GJTz3bTrocSX5G14OPqYreqVVS4/FSzXBA9qJDenRlU5AZ7l7Xi4xkJVikZ
X-Gm-Message-State: AOJu0YxlR9dyxjwOBAi6XSq5berarZPUTHPCtbZWr2gSUJgZMtbxg29T
	wn8PzDbzoIH58VA4WpkmB/lVYiSJ+n4c7VlChefrhmTt4z21fhOj1NiBgNLdWoo=
X-Google-Smtp-Source: AGHT+IGwuD5WOsjtT2bfQ2zXne4CrgHWP6AcnVi1hE62VKVHJr7T6wk/7agmQ1tHhyxNcI20/8ivqg==
X-Received: by 2002:ac2:5690:0:b0:52c:ebd0:609 with SMTP id 2adb3069b0e04-5309b259bb9mr12112105e87.7.1722410892990;
        Wed, 31 Jul 2024 00:28:12 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282babaab3sm10562035e9.28.2024.07.31.00.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:28:12 -0700 (PDT)
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
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 04/13] dt-bindings: riscv: Add Zabha ISA extension description
Date: Wed, 31 Jul 2024 09:23:56 +0200
Message-Id: <20240731072405.197046-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731072405.197046-1-alexghiti@rivosinc.com>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zabha ISA extension which was ratified in April
2024.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..a63578b95c4a 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -171,6 +171,12 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
+        - const: zabha
+          description: |
+            The Zabha extension for Byte and Halfword Atomic Memory Operations
+            as ratified at commit 49f49c842ff9 ("Update to Rafified state") of
+            riscv-zabha.
+
         - const: zacas
           description: |
             The Zacas extension for Atomic Compare-and-Swap (CAS) instructions
-- 
2.39.2


