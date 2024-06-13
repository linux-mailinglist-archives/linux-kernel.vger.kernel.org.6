Return-Path: <linux-kernel+bounces-213895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F14907C28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE5EB22D95
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75D2F50;
	Thu, 13 Jun 2024 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LEnauKVe"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F62914B064
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306226; cv=none; b=OmdRjHMc0BPdkH8jIU9u1Iv0aZ2ICQ5sLTyLYF7K+jqhiqbJ6Xi2m2RTEKXhEWK8/Smzo5Rm/EKK65KLgXgTfZQMwpp33vGYgOaVEL/iszZe/YkeuyS2lfPwMWal2f4HdWv70tIxZLK+pvh3DFkbo72P/7LZXdrPD0WlQyasJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306226; c=relaxed/simple;
	bh=SV+MkVPA7IjipbxXq9CYQ51R+m8bJWkmFeRtI4XsMPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IATeFItlMr1niwJw756b4mXnCuvp88/9Tzp+JMOgHV7DawfCPTaDZlV+4LEnLXIjHWRt3M/CvG8J6HOFi0bB0VB3cmmJz8vv++f7tJUOv9K2JS2p8U56WQiI602OBaIRhc+ZWVDvp1yWuPXvCpr7nyGaSkVmNIboP1v6JCgB17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LEnauKVe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6fada63a6so12052725ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718306224; x=1718911024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpE2Ww+0dze0r9EN+Ae4oSiwfKGmmGKW1FHSshUbIM8=;
        b=LEnauKVeetD1sZlkRpPpsMHTrPbS+TqXrZocfREPhDTr7AfLrpre5nqNFjdF3LcWj/
         pfJeo8G2qa/DmRxS0QWSB4XNjzQkRSTPGGL3BfYD1gqwaxp7tSiwIPpL0XNO6biUoSur
         GezYDspBKwx2RYUUX3LcLC2DvKZ5KTgW6oTROkI3JZ+VcnL80MGfQO+a5O4lhQyl8qbd
         ADNa6yZZjtrT2y5Ze+kyDAy4IAJgji7lYWuC2qfFKlkRjzkRKhjX3VpHkEyhEI3bmSgH
         gLoqLviQMaQav4tuS7+3J0cZEVm4Qbda0s+S06VIzPu3szLsAyv2Z+j6m17sZKPanrXQ
         tcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306224; x=1718911024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpE2Ww+0dze0r9EN+Ae4oSiwfKGmmGKW1FHSshUbIM8=;
        b=W51WzF1t+YZ4Y1dcQjdkkiAnKhNTp/ytAuqP6js9V8pLGIq/sbDxBTzYJG/A9m0R4a
         n3Ql422QxHJLFxfQBT+n631V+/wNlzOWB8+FVpJ0ilGI1KsAtMZKnLJyrbHmN+kiPLmk
         fPfFX+qpOPLF6jeO7Tpk60zGrUiR4lI5xQ0zODhyqpqmTqA9VL5qNymOMCR/GZpUwJwu
         I56sBKvLYppvMX3qAC08J2KDjXk+8B5dtHLm6NWmRZsYmWx7iuT0cA+uZuaUORlbgnF6
         94jINu5ilLVOGW4+ncGWKPKkSpA9+pOombr5hjLfqZDslJBiQdL1yLuvtjqoOlyM0QBw
         dQLw==
X-Forwarded-Encrypted: i=1; AJvYcCWAlQeiJ6Gz98JdpZQOeXK7KiUCxY+zIu9BtjIsJJJl+yopZpIyOTVjnRxVdTAZaSSo6LFeZ4Rpfg7kXedk2PzN5dn1RiKTwUHhTDGi
X-Gm-Message-State: AOJu0YyBKjOkrV7ZRi5cN/OnrxU4SPT2ziiYA+NR2EtX5GSuWpKoXB6G
	oOOsy7WL3d2zD9Phb1SNlS1B4u2riURmZpt3qzUadwKRioOBXSJbNFnDFvADT50=
X-Google-Smtp-Source: AGHT+IEBHUiOGS6vq7hxV351Pocq5uf+7spoaKHpPHfr2Yp/P2zIdVv4yVxvGq5/azSD93awMnHT+g==
X-Received: by 2002:a17:903:228f:b0:1f7:317f:5454 with SMTP id d9443c01a7336-1f862804bb9mr8516685ad.51.1718306224484;
        Thu, 13 Jun 2024 12:17:04 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7ca78sm17471015ad.106.2024.06.13.12.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:04 -0700 (PDT)
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
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/6] dt-bindings: riscv: Add Zicclsm ISA extension description.
Date: Thu, 13 Jun 2024 15:16:11 -0400
Message-ID: <20240613191616.2101821-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613191616.2101821-1-jesse@rivosinc.com>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for Zicclsm ISA extension.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
V1 -> V2:
 - New patch
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cfed80ad5540..9f6aae1f5b65 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -317,6 +317,13 @@ properties:
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
2.43.0


