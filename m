Return-Path: <linux-kernel+bounces-186442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C78CC43C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3011F23CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF55F7D3F6;
	Wed, 22 May 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esN5HlMs"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD021171C;
	Wed, 22 May 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392342; cv=none; b=nWUknEMIA/CkAxSjmihEztLWoj9b2C+qagwyFj0T1mFylLZ5CkO9nXarqdTtTvh51STgqAM84KypPOt81ibzuernqFqZG6BwKUQ27QxVSDJnODNoF2LSAwi3ZKO83GgY1qZWzxWEfNAmXA9fwC5lgLQzG/yb77uOzlCJWPQuJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392342; c=relaxed/simple;
	bh=ZSYK8GzR1WOQTrURwzwVnh6kIaTU/EDR55tf9SzxSIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WeGAt6AiNChW42g+nGoumYgKQe/nS8u2ISykmRRiEhZPAvO43b4TrGgFZSVaV6SLu6q78aheZWWgTQhBeIlvuDH7NV2XoAwHnH70AXXbSfOBKt/eVKEBDtGa59O94fB8hlPJa2eVSujdM0xlUGAX40sHQ4+DkGNnZU520mpvX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esN5HlMs; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2283512a12.1;
        Wed, 22 May 2024 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716392340; x=1716997140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5AAweMi/Cc3C6ihqSri4sNCdqB5j4IpEH4KDrJTTyE=;
        b=esN5HlMsOEIqs17NmOS3sqCBCfF85BsdZDFwxPMzxB9b4X8dvorFg8irR4PqrG6H+w
         8NG6wL/Y9ah7lGkQ1D6pR9OpN7gHb7ZH0i7MvQt+sxfVWIhLOw/0X/aSLMDEWoUgaZTj
         ezhNTVoSebuGLWPMEToXM7IiN5PWp7gEcGTZpFrRumiNIr//D/QRcg0Vg70e0YT3LNQm
         Ei7MYPxYksV1YlaVc2p/Jny/CtvNkupIx+GV+/I4MzJkVZcoFf4JkB+UTaXda8dCGRf3
         s9TtO558X+mmZFMbTCF1glX8xMXGsrbemo9KS1ir+s4G/ckymOUHNmF2A0pq7F6S8yzR
         BN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392340; x=1716997140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5AAweMi/Cc3C6ihqSri4sNCdqB5j4IpEH4KDrJTTyE=;
        b=adwCuZF1j1o5SlvFHPP4hJDN/BVJH4WT5C6kHIaEeOm5dWB8KrY7Sb7WrcJEVpeIMB
         30MWQpULbp9aNliWnAkTtNt2/i76HkdLYckXQKwzHX1WgdE1igbdQaCKhOgXgueZ3i4z
         vGPRo49M3z0xDbTEegIiy5y8q4PPkGEv6vlf20gPXTMuiH+HcVQdb/2WBUnzJH84eDaD
         leIq32mT0gZZDdx0FDavECKiFxkUFS3TOu86gy1LB9w2PA7u+3XU74o1U2WuxxlFhJhA
         iQn/VlGviQrsdXwI9iwCLE4b1KxlVFfPPID41DrmquOYi83usNfxuMAj72o6dBCP6ZIJ
         hImQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMAkpDejiC5haNC0vB+DH6+xsIR5w2EfJ7ri4kJ/rFILUBPqSqGgMZVycnd2132HR+3ybG2XxLBHKRdy1NwbxDIPgmWb0oxlXwN7AFic3ep+/NNl/gn6mfHitZb+sFuDKJJ7DwOG+sRQ==
X-Gm-Message-State: AOJu0Yy5ltptS2bwL4YaMrEasqnF9kmkkSgvWw8JOdmDfDwx6y0Btv14
	5xMO1Hl9Bj+Vun4Y7N8gefdH+TtY0u4zj0F9QMxuidrrcTyINrrj
X-Google-Smtp-Source: AGHT+IG7LfLB2krVUQyQMdVgWaqot3nEz6SRzSR0447sVsZOi3VS9XyroxKBGu5xwHGXLl54QsTP/w==
X-Received: by 2002:a17:90a:8d16:b0:2bd:92e7:e085 with SMTP id 98e67ed59e1d1-2bd9f46e390mr2242146a91.19.1716392340301;
        Wed, 22 May 2024 08:39:00 -0700 (PDT)
Received: from localhost.localdomain ([223.178.84.74])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2b628ea59absm25574077a91.47.2024.05.22.08.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:38:59 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc
Date: Wed, 22 May 2024 21:08:34 +0530
Message-Id: <20240522153835.22712-1-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches converts the RISC-V CPU interrupt controller to
the newer dt-schema binding.

Patch 1:
This patch is currently at v3 as it has been previously rolled out.
Contains the bindings for the interrupt controller.

Patch 2:
This patch is currently at v2.
Contains the reference to the above interrupt controller. Thus, making
all the RISC-V interrupt controller bindings in a centralized place.

These patches are interdependent.

Kanak Shilledar (2):
  dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
  dt-bindings: riscv: cpus: add ref to interrupt-controller

 .../interrupt-controller/riscv,cpu-intc.txt   | 52 -------------
 .../interrupt-controller/riscv,cpu-intc.yaml  | 73 +++++++++++++++++++
 .../devicetree/bindings/riscv/cpus.yaml       | 21 +-----
 3 files changed, 74 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml


base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
-- 
2.34.1


