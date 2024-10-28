Return-Path: <linux-kernel+bounces-384231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407E9B289D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2997A280D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B902190063;
	Mon, 28 Oct 2024 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZu8cMSj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC957C9F;
	Mon, 28 Oct 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099894; cv=none; b=BHR10Nx6CWuFHHYRrPlXCjmzMfUEQD/grfSnMrhyNUNd6jWLoVJl5YGsZ5PDWIKriZDIfk+taki7Ra17zfPlZRyxPmNdd/Tyj3yb/Cd/RSxwtaTu5BBF0xpu3BOm4+XrEbgu5CaOily7U0Qx8I17sHRGEG+yl8bmV6pcOnkTSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099894; c=relaxed/simple;
	bh=K5+vT6z5A9iSg1GNnnXg/DAHNSTzyAGR2j4YWRCVGv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qv0qkgbviP1uh8ejv/1jIWhoqOVUfkLSDcoOIpirXQCRgm0xFpbQtBzkUGaq51eBADgV1kk6WcjssFexZMcRuWyKqhKTM2m2aYFzpgPeo5CSlxDy/5GkMBa0jF9QBnKrdCGxWekfQeipDvFXMK45MtwyBWju9WlShBp1ncV/Y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZu8cMSj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c714cd9c8so37995665ad.0;
        Mon, 28 Oct 2024 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730099892; x=1730704692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFK9QgQch5Y1qO3mwflyMJcISzoRrthQ8irm9r5w8xg=;
        b=nZu8cMSjN/3CdA+hibMC+wmzDLIsKOQiJDbOVRtVpG3mahrFHSHen735JKv9Iiu+BU
         8P3yI2hE3SOz0R3AokgbAUjX6P6Q7Jl9Z2I5CzBU+zH9z1FH22m2ln1mXVwmCLw2T6nZ
         V58hnMVxgWg+gEtd2IqCPA6Hnfp2scumSpxCTUQcx6+yv4L8uuTTIn8uia9jzE01Aw2b
         a/aqSH0C4K0G2mrDUveaSP55jDLqj8gtGAjt1+vXQ/56kujXbesfNbR50QlICmAykt6B
         145RG7xUdERAoSplYjc8XIFgyBdRB6W/8e6g0mBo2VaOG7HkgOdv/ax8Al1W7SXy9ZPQ
         PykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730099892; x=1730704692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFK9QgQch5Y1qO3mwflyMJcISzoRrthQ8irm9r5w8xg=;
        b=tmWsxa9J3X/7Goi226U+PTRO7LauMxz83b8AkRaV+Rn9MOK8tFTQAPKQqZTKk9SOlJ
         USijUp3viGW+OXRlWQFzTYlsF38W8E8FCGxtFjdywke7JmNCrnobpA0KBes6BQU8ZzYQ
         a4WqXRV6AzU+gU2bV/jDcXMY3f1dlfb6cUF6BGLs3z5UnSc3mE5BOxwAbmMuGHVpsEi5
         8TwG6JoSF7NIUdyvv/nmyCDXMui6MpXTLqHXl8muZxRbgym4i7sfsn2Oq13ImBVxdjoo
         N3g5+UPYj0LBKHowMx6lwhRVylPPdDMizuPmbDyd6YFBu5R2OVLkKa5VCvPgo8oKz3tu
         NXiA==
X-Forwarded-Encrypted: i=1; AJvYcCU4YAvShi1M1VYGxpIwAHwObcPdkEyYq8iAhWoiLg2BaHG4L5IMv5SCq1E55HdwIf2RcEr8qXpxhDrd@vger.kernel.org, AJvYcCW74sI0P0eGVImh3AfRFlwwFv9h4jAGC9/InXIDrFfOpSOqQ3g9ODyORwnssDA5NiPr02tfCF8xYyXAK8gd@vger.kernel.org
X-Gm-Message-State: AOJu0YzNntVG1M3U+yDwNBuTd5iACcerq8kFNAxqYA9kNSXdfjCPmZvh
	R3oPTc9hlaHV1zL+XpjNJiHc/7BU+Xy4CvyJ20zPY9cT/Ox+gP6w
X-Google-Smtp-Source: AGHT+IF5zvjva63HLowzIR2L4PHJfI+OR3LvQ6Kj85nWhHFdlhTKwCdt+x7mVDWbi9gzrdD9pLMkMw==
X-Received: by 2002:a17:903:124b:b0:20b:b455:eb4f with SMTP id d9443c01a7336-210c68d2932mr99261095ad.25.1730099892430;
        Mon, 28 Oct 2024 00:18:12 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc044f82sm44974355ad.258.2024.10.28.00.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:18:12 -0700 (PDT)
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
	devicetree@vger.kernel.org
Subject: [PATCH 0/3] riscv: Add bfloat16 instruction support
Date: Mon, 28 Oct 2024 15:17:40 +0800
Message-ID: <20241028071746.869740-1-inochiama@gmail.com>
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

Inochi Amaoto (3):
  dt-bindings: riscv: add bfloat16 ISA extension description
  riscv: add ISA extension parsing for bfloat16 ISA extension
  riscv: hwprobe: export bfloat16 ISA extension

 Documentation/arch/riscv/hwprobe.rst          | 12 +++++
 .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                |  3 ++
 arch/riscv/include/uapi/asm/hwprobe.h         |  3 ++
 arch/riscv/kernel/cpufeature.c                |  3 ++
 5 files changed, 66 insertions(+)

--
2.47.0


