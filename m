Return-Path: <linux-kernel+bounces-229335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57649916E75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892A61C21BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE92176FC9;
	Tue, 25 Jun 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yS+0m+Dr"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87656176ACC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334298; cv=none; b=Mm02AbzxwzXRm59+1B+xfph+QEFwnDeSp1iY9KLU9Xb1q9wF01KMq5FkymvMn1enwTVBmkp6UxV8R7IPezJVDV9VpF53G0al37MgCtMmPuil7sZfwZ97qcUZZr3jfmp0HGqi85hlaosMnStxhLpFt92e6k2jFjBDxchrvtvSCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334298; c=relaxed/simple;
	bh=VbQJ+9OJwbV0Bm9LzghQnyawcJ4Nbd37jO/zq2vW6U4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gmsVqkvMDDEvRc71UeXVU305clY/jfl6ZxR/QsBJDB804TiqFUJVztwWfIHDp54oF4qFBABN0Msh7HQ/CZzhceD5iyqiIs8XW7oAe+kRAVZc3X6urTa/d0DtF2KagRzMAiH294bnccJ1aXH4ZX0bLpUqU4w+zjakzmRt496hlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yS+0m+Dr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e3741519d7so3934334a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719334296; x=1719939096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DHb9nEZIyQ9TZyVFBVE55L2or4EVbNlnKkt0llmzhQ=;
        b=yS+0m+DrYw9a6YIwoGDQoSocBBZ2qZeeGhdqkTl+F4StqcHrUutsfBMmRMuRep2SQu
         NlZNeetbfOfOf4nn5zGN/fz8dSU5qERjuodqKpM587TUpEkB3QRc1JthewxcGBMnwQ1o
         Id4cs/bG/haisCckHZMrMr0Wy6iCml8cbkyEZ2LO9zU8Z0Hg+TWAgyhspbFag50E69N+
         orV2eoaiJO5gQSs76X0ClS6gmGrFBk6OGmtxDxve6WzjDt7DSw8qMm883manea8sMXch
         QlAcuqxwarVQ/a3wURJEClYuoajzt1QHyPNypQAkdga1kgpqWvezySNhiLWZQfnoRp87
         cN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334296; x=1719939096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DHb9nEZIyQ9TZyVFBVE55L2or4EVbNlnKkt0llmzhQ=;
        b=J9m/9TAtz2fA4/8G7gssMFghyh73hmcpzSmGmf/STLFrINLjXB6uQqGlsjLYRXLk79
         mr5LlmUyoocmCtseiakAMo+QcY5d2aCH2SXC915E05CS05HCWdjl9KEJeAhC0HAbnta2
         UcVE4WOytPiyWUYbuVk7qOe4KHJaXzP55uDLiqCne2VjPeutcGAKS8qNbyQE1C3bnXfp
         JVivJPLUwcikJdam1AbdD4APUuaRBqSSG4ri00wNDpvYJwLOmO0i5g03BBHzh1Y1c3b4
         Nq+QioBTY64uqnaJgJnCd90DBZuVdo1sq8YKtPF13g98Yy+nrySarbU/i2pvW4akVx4G
         3WYg==
X-Forwarded-Encrypted: i=1; AJvYcCXWYTaKsXzPhlsRoaZaqVbc0rafQSmxOCaqCm4i8jsbRng2hVeyYhvoNfxYX/WeOocS/iGmSk+zGJdZN7X/ILJdlQ/cSvRglXuS5kZ2
X-Gm-Message-State: AOJu0YxuwugkGf8LmjFIXbfnnsscILWNYkw9K6mFF4Ynd6IMGdBRANzk
	Sw02JTG8NtmoimhdGSRbGSUNIer9X88kU5k//V5pzbYGi2WQjOVnD8YEIyH8Ryk=
X-Google-Smtp-Source: AGHT+IEr5KdO47tCR36GyprkazgZVE78Pudd+YyNM8RkVP6FfAqnuG0pdu9FULtAHnIWPsI0hDA1/w==
X-Received: by 2002:a05:6a20:341c:b0:1b8:5967:45bc with SMTP id adf61e73a8af0-1bcee98ab11mr7553809637.61.1719334295798;
        Tue, 25 Jun 2024 09:51:35 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a623a3sm8991226a91.5.2024.06.25.09.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:51:35 -0700 (PDT)
From: Evan Green <evan@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Yangyu Chen <cyy@cyyself.name>,
	Evan Green <evan@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Erick Archer <erick.archer@gmx.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] RISC-V: hwprobe: Misaligned scalar perf fix and rename
Date: Tue, 25 Jun 2024 09:51:19 -0700
Message-Id: <20240625165121.2160354-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The CPUPERF0 hwprobe key was documented and identified in code as
a bitmask value, but its contents were an enum. This produced
incorrect behavior in conjunction with the WHICH_CPUS hwprobe flag.
The first patch in this series fixes the bitmask/enum problem by
creating a new hwprobe key that returns the same data, but is
properly described as a value instead of a bitmask. The second patch
renames the value definitions in preparation for adding vector misaligned
access info. The second patch has the side effect of causing users
using the old key values to fail to compile, which may allow them
to see and update to the new key without breaking binary compatibility
with old programs.


Changes in v2:
 - Clarified the distinction of slow and fast refers to misaligned word
   accesses. Previously it just said misaligned accesses, leaving it
   ambiguous as to which type of access was measured.
 - Removed shifts in values (Andrew)
 - Renamed key to RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF (Palmer)
 - Added patch to rename misaligned perf key values (Palmer)

Evan Green (2):
  RISC-V: hwprobe: Add MISALIGNED_PERF key
  RISC-V: hwprobe: Add SCALAR to misaligned perf defines

 Documentation/arch/riscv/hwprobe.rst       | 29 +++++++++++++---------
 arch/riscv/include/asm/hwprobe.h           |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h      | 13 +++++-----
 arch/riscv/kernel/sys_hwprobe.c            | 11 ++++----
 arch/riscv/kernel/traps_misaligned.c       |  6 ++---
 arch/riscv/kernel/unaligned_access_speed.c | 12 ++++-----
 6 files changed, 40 insertions(+), 33 deletions(-)

-- 
2.34.1


