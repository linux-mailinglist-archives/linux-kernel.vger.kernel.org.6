Return-Path: <linux-kernel+bounces-254723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24F9336D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A31F23C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3831803A;
	Wed, 17 Jul 2024 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="v5D9HJzy"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A2171D8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197326; cv=none; b=A19YxoO6tEXuML7iCsW5tqTSaInHmJtAp9Xg8ZyEKgx4ryf9s/sUtLTbsLuQAR2iwdNoYfMWjirSC0Dq3ge2FtuuLyIPiYG9yEC0RHMxPI4Q9YO+dztB3+38PrbmY13WnOL0fmL10WRt4OujqUsNL0VdGpb1sDJeQTUWR7aJupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197326; c=relaxed/simple;
	bh=tYSKztlvYXjqrUVGqUlFZcjNQFbhaN4iVt2oyZFJdVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QE7YqV78+zgM25UuZ8wz1skgtPqM1IxbUOArYJie2vIIt/NhX35t7iaGrwkAsn36mH3qnXvG4QZGHyvj9mGq/zu66V3SyFJk+b1VY0ZzWEm+NnB09AUSJa6AL0lOtP0kIh4h/EigMG0BZSgI8cvGYC2FPC9XQd9DjWC+7EohpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=v5D9HJzy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-426717a2d12so2369525e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721197322; x=1721802122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6LJZCR61gmm4dvekAa0Q1TIoLF/ScrG5TtOv9gDZ/w=;
        b=v5D9HJzykvK6DabPsxgMNqvbW0n51rd+JSbAtFnwceusBsHjz2wdH3U9KMJgg3pTYg
         9P5/rvGxRfjFwCgfF95hHSw5MNO1o3vxeI5y7/Q7OsDEjsWa/QCBSlDLLd9MY5C+4fzd
         tQOzriEYeDbL5YxKpZNKLnu6M9ZaC1TQU2jxFcbbIZ5njJ63yV42BlukYZ6TMnf5xnzz
         1e7u0W+ilvjaa6skOURXZN+VWVX/I6DE4TvKHnbqWTHquufyqGhCtDX5w+6bc1kzVeMN
         Vk+hywQr5W4Ks2X5sZ5soeFKqK5pBFef6h9N8BVcfm5pvn2c1SEsNQb4M+yx4+QGWunA
         PCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197322; x=1721802122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6LJZCR61gmm4dvekAa0Q1TIoLF/ScrG5TtOv9gDZ/w=;
        b=j5Bbl5GYg8ejziIaHoQqEDj/zZIMui5sRD4EHupmvPPK3Ylrave3RPDDU1QogvzlyX
         R/lppPNfjOtSZHi6q7jgYaVjW8+Vmml6InxJh9FHRYLxMl7pctjulXNh9FsmljstkGp4
         00YwcRN7/MBDWlGn3b2jmWPZUpFkEm31zX5oYnXa9V3px2ikPkCjDo5TtBg1WSI1utVj
         7UuBpSIMBeb73bqjWXwC3VY2l05aY9bAxX5MIIh3EP6iZcim8pblC+IO/3E4/eOfujl2
         rCMXbfgj9X36bkqycFf39XEKe43d5lgaq6dGY8pYIdhp1ChRHueMvbT9TI2NiSyd4Qcb
         XC5g==
X-Forwarded-Encrypted: i=1; AJvYcCURdtEgx6nqZiBD6cNQo/jYj6a1xXcqWPvGCZx8us+qHaSU8Go+Ri4amY77Vlsd0wkMKozKwRnq1p+nmgeiDlETxQnT+RFYX/QEFjJl
X-Gm-Message-State: AOJu0Yw1DAIpQSl3P6O4F+h8Q2AtLE+w2y8jjOI6TBLf0C2hJ+l+yZvg
	4ELIZfnZmUt2p07YO6YzN7tDc8h5kV2Rml1c4Gz3CX6fcsdabiHL7G+4/UlNbPg=
X-Google-Smtp-Source: AGHT+IFU9J5ZIoNE9rhylPtawNo/bVXV/Y54qi/t2Pf5eJSgSGKg9qXAA/fSZkpR14Z9Af1ks6C3xQ==
X-Received: by 2002:a05:600c:1d28:b0:426:6981:1bd with SMTP id 5b1f17b1804b1-427c28fa6a5mr5014165e9.5.1721197322313;
        Tue, 16 Jul 2024 23:22:02 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23a000sm194474825e9.5.2024.07.16.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:22:01 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 02/11] dt-bindings: riscv: Add Zabha ISA extension description
Date: Wed, 17 Jul 2024 08:19:48 +0200
Message-Id: <20240717061957.140712-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717061957.140712-1-alexghiti@rivosinc.com>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
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
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..e6436260bdeb 100644
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


