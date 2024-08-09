Return-Path: <linux-kernel+bounces-281227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF32A94D498
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A91F22B6A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B068199225;
	Fri,  9 Aug 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GfAjM6/N"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C4199223
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220577; cv=none; b=ZpysNpHbUD/rWeDNX8EgH6xryDQTqi3Mnm3i+t/N103GtrWDiiedQxdPpj05cyG/oBprcxuCTC56WoBErpeFqhVdSpe7JPdawOikABofQh11q9qoaYlxZPPoqoB6yUZUpmrfTPmdVlA0aowNxMCyF1azH0Yu+iL/bW5cgiOS5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220577; c=relaxed/simple;
	bh=Q7+mHfaG/gPeyphnTcK6yRgJq6izjUUPKdZlakTOdNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOWxIe/e0Iazf8M2uaOGWa89yBHx6LhQd2ALmq2BDotqksgw5QIQS4qz9c8CoJESHcvWF9K+B2RXIV4v+XKjQsf3RX+xDGJ7KxPLYsyO0eGM/RsNsSKEd+0pYbkzy1UVa1i3ajKqCNKJTxL/9vYkET6wMLefn7L45n/FzOmt378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GfAjM6/N; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso1561626a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723220575; x=1723825375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9KwuCeskSHSsK6Ge80MByzX2lckhBzz4l4UPkzzqNs=;
        b=GfAjM6/Ne+yZDIGc7Hh3LvhCoHfcA6Xu11M902TZPpip/79PHPtf7g48DWwCivUens
         BKVtBJf+/8KKgbuBiZIuziE3ekpIpF5BD0cbWK6Q9x7UmPI1Tk7EWls1Sx5mP6RaPpZ9
         FTE4VAarfotAaHN49Ky4DTTbP/s3OIKP0olG+6hI58cctg8qxPn9hhD+Mr/dl5TqQEZM
         q5TyNgf8ZUy/5vpTD26BJrGeEfvbnMaaQuENuh/PNIRdId3LhfudYZqLgNeW8oh6xPMo
         Q8kUPlC8Q5ggQWiFFjrM5x/QM7+n/FHwfWXPZknCxbWLm3YCbPM/jDDQdRA1arFmkCa8
         wM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220575; x=1723825375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9KwuCeskSHSsK6Ge80MByzX2lckhBzz4l4UPkzzqNs=;
        b=ryj3ABrXt0/UHwkj3kGv+Efx0n22rEyH9N8pf0uV414rErjHhzQMYSXBOJJfokqKSS
         NBp6p9hB/PJi2amoBXbVHiFi6HGgSJVRwVsPLRaD6DOIElcIlvc2BGo7njMW05vAyns2
         UpHsH62jobChamb7Wy3XnmPAxsCDB+LZnLKs8ml/K77hv6lOEstJ9tIXMTiJmP+8Z0Z9
         ch3h3Mbkme8kFsZSf2DcWdu/O09wc5qe/DNqhKPyMAE6d1rDS8ssaHV9lSlIz6v9k9p4
         8/shRBs7E/YbWiRoenA7i+bkiiSHcz3LEGdz+eqbgt8MIw8+U63IQQoR24x1hzpPjlxk
         z91w==
X-Forwarded-Encrypted: i=1; AJvYcCXmei7WTUJylDBNRWL7/SZTBSqbv97xdDy8vJ73UPaJGexFiZUvQLju3rXRNTpCF0Xp5g+jLmlzwhhd/6KYoMEgfgX1s6tRgY7frfR6
X-Gm-Message-State: AOJu0YzN5ba8BYW1nOWvpTWl+oyiKljWKggfV9GwHSeg+wY9JwlajxDj
	abHnUEGJBQCY8zzVIF4Iu+vJemuP0jGWxNH5NI10FA5iKcXjJT4NhjTf6wtBbiA=
X-Google-Smtp-Source: AGHT+IHp8h7nr4BcWcXSmFlRdpIdfs78+tQ8JlqIPTYsDMyESOd63kL6pHIyup+248wklqPMUEbOiw==
X-Received: by 2002:a17:903:944:b0:1f7:3a4:f66f with SMTP id d9443c01a7336-200ae59b5e2mr19226275ad.43.1723220575225;
        Fri, 09 Aug 2024 09:22:55 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200668fc398sm100414505ad.207.2024.08.09.09.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:22:54 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 2/2] dt-bindings: riscv: Add Zicclsm ISA extension description.
Date: Fri,  9 Aug 2024 12:22:40 -0400
Message-ID: <20240809162240.1842373-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809162240.1842373-1-jesse@rivosinc.com>
References: <20240809162240.1842373-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for Zicclsm ISA extension.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
V1 -> V2:
 - New patch
V2 -> V3:
 - No changes
V3 -> V4:
 - No changes
V4 -> V5:
 - No changes
V5 -> V6:
 - No changes
V6 -> V7:
 - No changes
V7 -> V8:
 - Rebase onto 2d1f51d8a4b0 (palmer/for-next)
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..d06ee82abcc1 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -361,6 +361,13 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicclsm
+          description:
+            The standard Zicclsm extension for misaligned support for all regular
+            load and store instructions (including scalar and vector) but not AMOs
+            or other specialized forms of memory access. Defined in the
+            RISC-V RVA Profiles Specification.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as
-- 
2.45.2


