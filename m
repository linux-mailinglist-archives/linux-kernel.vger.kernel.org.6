Return-Path: <linux-kernel+bounces-512107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C57A3341C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69525167CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3386B4F218;
	Thu, 13 Feb 2025 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9qJdpiq"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6142F44;
	Thu, 13 Feb 2025 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407142; cv=none; b=rJXKbM/Pcu3omegKAf1+BZI363gnP6D9qEa/FVmkGCNLJWuMO7Nms7VT3n+q39e8H79KBFR5ua7hD4hEvwozq0N8t7+1F0DylevcRZ+peB3qeq2npi1kng+AV7Id/EXRw+4Pjs554yFWhdvhXS0kylxeIPtHvH1blQfuI3OgiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407142; c=relaxed/simple;
	bh=ga/IOc7uLTg3IBgWOX8zypqySo2qZSM+QL53DLL3Gr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhQy2z1Ovqo8m/mQBfSk3BgZMLel+grdPNmGBNYJ6s4QNH/ALeYlKe4zGp8Q12aF7K+1wUpVT/iYKzZpqGd/64+6YOkhLYJnVKTRcYWQQE7ACye++DXC+ZNRZ6h1G81eSwtas7jSD5XOGw0kbwIToeY+DO1ghuVwPuKIFxmDQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9qJdpiq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd1962a75bso2810516d6.3;
        Wed, 12 Feb 2025 16:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407140; x=1740011940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwWt+I1q21nIuXT9naaaYFBUTlLCTvDz09ET5qP1riw=;
        b=m9qJdpiqCz8M7l5/UMBTK++cc5Tc0O8LMOkI31XeB1oRkOaGHBG5zcNkjZmS8L/lft
         PtvJrpCZxPMwEkPuqOcAIj9MvYO5vDSFX51v5vQnEhevK4MRpVsKGfHCp91V8fUCcQZc
         8lrgBd3TWt6izoY78ZnxNSiXq4IWjCcvVNnWHJ+PiyPjCPiVYx3OVDLkYekk8V1VKr67
         Hs+RYlajAo02ElYp7MtEhjC1YTUhH7TxGjnAfRe7TucJXjXZvdUCYbl7Adiu2BFO0xbb
         g9B1EsfuX6Arpnjn+WBomajOuap+hrJNpKaWgMPrT+U1c0pRrc8y+1G0MtaW3XPGC6Fh
         JijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407140; x=1740011940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwWt+I1q21nIuXT9naaaYFBUTlLCTvDz09ET5qP1riw=;
        b=q0u+BnyBmMbB9tdZdVWKikRDFCpEoKVJ0cigIE/JBAchKifZ0FQZcCDG9+dAQ+zqMH
         rTFpwN0/0eu+QgRBzsBiW13xSlenBUP4Isu2cJu74UpxZm1+xiNg4sx/YTmTOT6GPdyY
         n1rw28s8ie553oet+seQEZAL3qh8oEDpQFYxfM+nnwLzYd80k7XthKN8khOVgJkmNR+2
         luvY95uDaa+FN/lx2AJ8K6Kk04cHFYIC+d0OH+iouUJIHPJIN5WqLjS//w+boDdtJ9UR
         0s+1ydFMAWAeM/84zBrXIkcNgf+g7cDBWKUy4Mipyth7n4aiY+uT9p16eb7ixmzBYtqE
         qywg==
X-Forwarded-Encrypted: i=1; AJvYcCUC4XSxJu7jAtrqgGqDETLc8Elrw7fSPDAaBsiI56pIJKiW8UzhELrsRkV7llvnek/VL84VYhlfZ3Ok3v6m@vger.kernel.org, AJvYcCUEdFuHQ/xEeKqhi2ZPVTi//7wQ7RCmTrj79++aeu8XLXj4haiQ0omXrr1TObUkI/vLEuRE7VMgqXU2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzja1GjTdaVpdQYCJWhlK9Rhf9bUxXw9/JO9GjfS9YJd3iSincF
	vcj89sx9uMcBVNQHqcTdEhBo0gU4uf/2sglpwYmXgpZ1fsNq5udC
X-Gm-Gg: ASbGncucgi0WzNUaonw/r8BP5xuBNPCJCRnwX8TK0vlDHdEFEoAssAIBLV9ityJbv5z
	v2EfK1InGoJkDhYjR4cL3aw+NMAQlyVfNEQ/NjuBmpci5VgekL3rip4f5WJx2CtGCQD9DupCYMk
	PhPzlI9wXUPIr+4GiHCb/4VTanNkyz6LFa4SoKen+02ZP3ddvWlWdOZkIDSexlfuzuvuW/LELEM
	htTHjn9MjJlPhuidZqHuwWro65Sw+66F5wZEcSco24yxt7nOPr3aCsIRBJNx0K9YHs=
X-Google-Smtp-Source: AGHT+IHHLL9ioBnDiGzkp+YhmlUcXtvqasDdyzPDZX4jep5Ey+c2ghcL5FH1R5QcGMY236A6mcEUuQ==
X-Received: by 2002:a05:6214:410:b0:6d8:9b20:64e8 with SMTP id 6a1803df08f44-6e46ed82f7fmr97469676d6.10.1739407139724;
        Wed, 12 Feb 2025 16:38:59 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d9f3498sm1406996d6.84.2025.02.12.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:38:59 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 0/3] riscv: Add bfloat16 instruction support
Date: Thu, 13 Feb 2025 08:38:44 +0800
Message-ID: <20250213003849.147358-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description for the BFloat16 precision Floating-Point ISA extension,
(Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
("Added Chapter title to BF16") of the riscv-isa-manual.

Changed from v3:
1. rebase for v6.14-rc1
2. patch2: add validate for zfbfmin, zvfbfmin, zvfbfwma
3. patch2: apply Clément's tag

Changed from v2:
1. rebase for v6.13-rc1

Changed from v1:
1. patch3: add missing code in sys_hwprobe.c

Inochi Amaoto (3):
  dt-bindings: riscv: add bfloat16 ISA extension description
  riscv: add ISA extension parsing for bfloat16 ISA extension
  riscv: hwprobe: export bfloat16 ISA extension

 Documentation/arch/riscv/hwprobe.rst          | 12 +++++
 .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                |  3 ++
 arch/riscv/include/uapi/asm/hwprobe.h         |  3 ++
 arch/riscv/kernel/cpufeature.c                | 35 +++++++++++++++
 arch/riscv/kernel/sys_hwprobe.c               |  3 ++
 6 files changed, 101 insertions(+)

--
2.48.1


