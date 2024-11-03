Return-Path: <linux-kernel+bounces-393727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C199BA479
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ED71C21157
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB88158A36;
	Sun,  3 Nov 2024 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX2PsHRJ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E4433AB;
	Sun,  3 Nov 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730620237; cv=none; b=H2Ukeg7Opa8B3WuNQkyMLt0KANZMqBveHmZ3EQ2ffaXHRwwzhk3U0lqqi+R4FwppJj0y5674p2w7LL+GJ8dgSZY1GeDyaz6mXSXL/oBgO116MUFl7MV622D43lZ5VMio7O1Xm2UfQ4i0l/0Of65QaG1EODoUd17g6BAujdhmrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730620237; c=relaxed/simple;
	bh=TYmacKwsHFNa+eR/Z+3ChHTgibm3tT8QvSDZMUALl+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOn3pBDYcbldrFpvQveG5BD7BmfOg2cP3oRrv+MTDqmYe11aQ607gDZoJekAk6ec1eqdTwwEqBnBTaYMzaOgwMgWdgGBGQrv4YUBjs1NawHlmC0h3k4DUd3k5+xDkZ9P6uvHfzijk1IU/OZIzHjzY9sNiaZInIU57FVnTM1+UPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX2PsHRJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72041ff06a0so2775812b3a.2;
        Sun, 03 Nov 2024 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730620235; x=1731225035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=82bL6EfqhZebZA3MSW+F+KvuGIbomic+Z5nBkECZIRE=;
        b=fX2PsHRJXHwnOm8AjygIfF3tjUteCpY23HMVcxyTZ9IlUlBCLB4vh/mZeF/SpkPI3G
         nJIqWbsvZsy/CGK7W/mTKScF3b6aMlaRqGhWX+7lxzrgiZ0mTuiWLw0OJEUe2MLb5gYs
         ZysY6q0LJKoiijK3jj7VvP0YJhzyZE9zVgfAkFoiU0BaHhNazFLJI4tUMBvm2m9Mz4nK
         +pcrGw3jK7P8PKJ9AwfOwEhgV0EIBVDySUaCdbGpME7GEUTfbtUulGocrpecN5QnXZaJ
         cZTgN1RKUzVfH1glar2aDh2M71O1FdveLUB8qMkC/E1ukNjHbRatjCDxUnzhL7fWRuXa
         TtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730620235; x=1731225035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82bL6EfqhZebZA3MSW+F+KvuGIbomic+Z5nBkECZIRE=;
        b=NsgTvz1TFGlo/6B4wJGm9FJuVPni0uRdkOjyHfAhIwu2SK+G+/dT1JiFVWpkrQp2A9
         Z/OiDQrTq5vKYTg1fSGTyKdata5iul0QkkGfLUNSloZ3onYHELeZgE7zkCCu6t0kdMhS
         +rqwzop+eSI6Me08fZ4SW+t+S2W0Kab24yTwMx/+WHUVPqXRpa3bhmo00OlReojt3rn9
         btGd3rnkf0NbIrqYdImt0qyeGaMEDjIPhwjTdTwv2uvauaCvZtrUPHV9HBO0WXwuYjaS
         AiiUY5UPeUIcmig4gFyhqk31XHz1WJ27fSNXrp8+6C4Ud14ryncNDPV4ual3umAFu2wI
         yATQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWwWLpNTVsNT2ot0UbMnEyFskGlOx1awRLh+6H6gr8yObicteztjkyKJl8tBecTIXYTXAwVrdLfOa0@vger.kernel.org, AJvYcCUky7u3SU6+MWyf7+6hF9jo0ff/gJ4YnqvmEG6vRFlAgAluuFv+uWpLwD1HSw+6yAUyLPIgCaNExb3UROFm@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJrX9hpVnoIgc+cq5EATzp0K8CV8QNskE2CK1uL+q0UrS2bt8
	5/f3oxjymoaGjwL48u/mqVuTws6doGGO/0fl8Z//MIvY1JMBvS9M
X-Google-Smtp-Source: AGHT+IGNqdouYxdkDsVliutvXVfWyle9vrcba18CRK5k+mamY2ZvMxPTcLzeO3RmTrXDAE4yyxkH6g==
X-Received: by 2002:a05:6a21:6d96:b0:1d9:76a3:a208 with SMTP id adf61e73a8af0-1dba553b9b6mr14226296637.47.1730620235136;
        Sun, 03 Nov 2024 00:50:35 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31874bsm5201367b3a.213.2024.11.03.00.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 00:50:34 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/3] riscv: Add bfloat16 instruction support
Date: Sun,  3 Nov 2024 15:49:54 +0800
Message-ID: <20241103074959.1135240-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the BFloat16 precision Floating-Point ISA extension,
(Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
("Added Chapter title to BF16") of the riscv-isa-manual.

Changed from v1:
1. add missing code in sys_hwprobe.c

Inochi Amaoto (3):
  dt-bindings: riscv: add bfloat16 ISA extension description
  riscv: add ISA extension parsing for bfloat16 ISA extension
  riscv: hwprobe: export bfloat16 ISA extension

 Documentation/arch/riscv/hwprobe.rst          | 12 +++++
 .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                |  3 ++
 arch/riscv/include/uapi/asm/hwprobe.h         |  3 ++
 arch/riscv/kernel/cpufeature.c                |  3 ++
 arch/riscv/kernel/sys_hwprobe.c               |  3 ++
 6 files changed, 69 insertions(+)

--
2.47.0


