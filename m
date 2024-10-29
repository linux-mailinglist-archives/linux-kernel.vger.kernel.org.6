Return-Path: <linux-kernel+bounces-387890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94E9B5756
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98232B20B58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4F620E32C;
	Tue, 29 Oct 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qhGalQZQ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B220E028
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245474; cv=none; b=Gm/8JpjgNh74m4zsoKAGCkUsjZ4iUqsNl/4HnztShF+EVOf+MY360iyG4vV4YXeRTUk/eYBXqa4ImyTp5Kl34KQU7Lc5N+dV0J5nQzxNURaNvCw2qpeVfhPoqGP+g+Jdata/hKiEU22AH6YK+DaRA9w2lig/KC/xxBgjAG64qWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245474; c=relaxed/simple;
	bh=35FkYSG+J4y3QJq1mLXVeHO3QekabQvwyuf6ZmAOm28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDBDROeNl79Fl7+NxXIgIVhWGLQUain7OTL/mOMvNnepdaC4M37qVjyS31IMG3MkpIFFBhUTQfduspIlpXlEjW639clRP2nRqQEYqVO/G7eeCm7ntSuXxErr6GlXv66wCeUYFlFflA0ntFiAEv1ahp6o4GeVPspHuOnQMmlIonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qhGalQZQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7eda47b7343so3884392a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245471; x=1730850271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqlGzJEOA0rIxMbra4aAEQkUCqIib9RSzM8TmOHOkBA=;
        b=qhGalQZQlDRpden4R+Tx+1CiX38EywVzIoTXYgCbuR9ui1kquD1aLE5p5Bfpt+Dh9n
         MB694030YvczW6QW7mf/6kjL+vV46wMHUFDSL0JQxPI7wESg7YxdxoukStjbuDA9G4ci
         n9DfnhboYYq0bFQ3IugCc5tNw4HS4FVCvo2PAysLF/DilBk8EeTJpTr/ONpUAoESx6tu
         ycKvcR+uheLC83+V/8cLQMJz8OL3Zsx6Gf4vj+di0WFWeh+pt3egJuFhLH3op3JDIalh
         Ocu6C8PJf6OHvdzDKagtcH+u7g/cU+HvL8XL7yftRI8u2V9xNkZUwiw32/Om+LjEgvk+
         +8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245471; x=1730850271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqlGzJEOA0rIxMbra4aAEQkUCqIib9RSzM8TmOHOkBA=;
        b=TnPwc84XewyalimTtpC4JJkZY0PTxM++8rkMPM3KgQ+sFxNz+BGkJkKejT8pzbKh0o
         QV1UmwNMIiLrdAHP+hKajyqGhchqcb5yJsmdc3XgNl0BaxRXYJPvf5bfVlbWqO+lbuX3
         6Olh/NuOPH3hDnUwHowR4Y1Iw6hwz9z3MjX2SXQ4n3EmYdm2O4TuZn6zRlAwrgbu4/Ka
         KrwWH+zt0EIL5Gl0RFTd1qI+M1zKA8soI5lrmLISWet3rWJTPBT69d6v/2ID4TJ1EaVA
         MVeST1ACljaCSP80YgzXgNzEXdYZFMBQDJPATNxR55Xc56xu+wtr5/gHj4kpqYgFEQxi
         0QsQ==
X-Gm-Message-State: AOJu0YzoBTpwJsfMI60rei19/59Cg/fdIGeMb23vpthY9cMjeEFVhMKd
	MusoCnvcVMmtsT0HC8lFoN5FUVMAB9SXQRqIYmmpN6sTateohCF6gsIju6y4JJ0=
X-Google-Smtp-Source: AGHT+IHPZtS5V83Y7JMjzODTd/hxnTyAzMxstiwXVpmrwh9UhJDy1/DHcrx/nIgBTJ/vKGmAOmeiGw==
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:b78:2dd3 with SMTP id adf61e73a8af0-1d9a840aaf4mr18555145637.26.1730245471399;
        Tue, 29 Oct 2024 16:44:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:44:30 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:06 -0700
Subject: [PATCH v7 06/32] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-6-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 2cf2026cff57..356c60fd6cc8 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -368,6 +368,20 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description: |
+            The standard Zicfilp extension for enforcing forward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
+        - const: zicfiss
+          description: |
+            The standard Zicfiss extension for enforcing backward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as

-- 
2.34.1


