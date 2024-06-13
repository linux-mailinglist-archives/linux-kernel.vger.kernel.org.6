Return-Path: <linux-kernel+bounces-213722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E390797F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185741F23957
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E97C1494AB;
	Thu, 13 Jun 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QpddC6yf"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5774C6B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298891; cv=none; b=WCImv0a0+pGE/HQcmLC3x3p/qEFvvtJRgKwo45240RVLCghb3bKFnXv0j79CFWEEulMWNV0NWQ1CAPpcpVkX58vz28aHazac65BiWoRPPk0teicd42/DqsGzoEw8RYRmq3/t9RjNLprKeFY/VNltusjViA8lB17t4yiUPn4OZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298891; c=relaxed/simple;
	bh=YO3rlPDuCKwDnknJMMsexdEzGenYOU89DObNKzc6uK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWexMdEUS271tKM8hzPv9x+hE+RV3vzWPbGWk2C4MGgb/pJ+JeUVVTk5yRODK5ReNN76LCos8gUPIH10Dgb6lxaxnq5wwBL1SpRJJZ0NI30muRZQTR12Mhz5aQ1TqQ3kvmkc1fHVazgAbIisikIaxLC9a3tzbKHo3TqhvX65Ipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QpddC6yf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a5344ec7so9382565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718298890; x=1718903690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2wDR/+ZeAebK5DODzchlpSntyjHtjLusR3FVcp8fSQ=;
        b=QpddC6yfN7nJbbsEqYTLEMorn0Z/KfF8e3EwhedInulA7NWAJnRduWptj7DmAJgGPW
         C1//VX9045Pp9agoVK9tZQNfAgY4OuJZUvnrmSxWsV2NPqkYVAxNT/5bwZtBDdUTLtfW
         VUBUQM2F8CSvXzPCo0z1v+IFXxYZw/r1K53RCO0uurJom51Sb+wsKgqEiEg89nUf1AU4
         XcZnpzKHUgypVf4q/ulXKhBpY0wDIj39HdoP8myNfuZGlZbyOd+ZOySLjZgi5TZhDOCN
         IcVcpQnxb8scy45tTD8Rk5B6ouGURXkmxnd+U5zMonegWh7FmtAGlo833bD9p0jcULFa
         Dc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298890; x=1718903690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2wDR/+ZeAebK5DODzchlpSntyjHtjLusR3FVcp8fSQ=;
        b=JDmBzuEE2NG4qFpzqy4rNQEWIWtKBN5xGiL7cvdBwre3eNE/bnUAkUjQNo/EXO1aKK
         jm104Dqx+ZQ/UkNnpjlW+A/GK/tCipPBHeEuxTeaThchckRLcSzrdTI3vOvhtToiuamU
         BcjePw/RA6UBaYiRYXfVGzXB8J5L7vfbwA/ZTXbW3V1Cl1/6U3L9JDCec6ADtLbK/9vx
         5/sdO+B9Rp5smHPRX5xgyZYXe0ZAxIl2CeI/ca6dnmpEF3DzXravBPrwSn95KkX0JyHm
         qLh2gh3r7+HCIhbjOO6enotp99FOn5n19BxUsOGNoT5jPY1OzrwJ1Qw54uYK+G6h2izt
         ai5w==
X-Forwarded-Encrypted: i=1; AJvYcCX4mrwX5mZT2A42buSRMgB4jxADlv2YSv1cZeC/auzsWXNf874oUsQvWxsTfipIKbCTsPX7tHLLBEXfWHKiiWtYxX8OOXBYBRZWuuPk
X-Gm-Message-State: AOJu0YxwkEpdJhchoCmCd4UaukM9tn2bLjBTzXUTqjbMbne3x1l0U+AJ
	oi+s67FL9QLxQM5D1L2mBZbDHeJQ8aQSJucJX6z86ZTxUOygdvnyIW5kNq/cpN4=
X-Google-Smtp-Source: AGHT+IG37+Td9DpTmKs5rXmk9tbMejKMmjWuqEkRqpWcHWftONKXSPsxc0L3z6Ewm5r4pqA+GEmWrw==
X-Received: by 2002:a17:902:ab8c:b0:1f6:dccd:c6db with SMTP id d9443c01a7336-1f84e532b17mr35415865ad.30.1718298889625;
        Thu, 13 Jun 2024 10:14:49 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55eb0sm16445035ad.18.2024.06.13.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:14:49 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 0/3] riscv: Per-thread envcfg CSR support
Date: Thu, 13 Jun 2024 10:14:38 -0700
Message-ID: <20240613171447.3176616-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series (or equivalent) is a prerequisite for both user-mode pointer
masking and CFI support, as those are per-thread features are controlled
by fields in the envcfg CSR. These patches are based on v1 of the
pointer masking series[1], with significant input from both Deepak and
Andrew. By sending this as a separate series, hopefully we can converge
on a single implementation of this functionality.

[1]: https://lore.kernel.org/linux-riscv/20240319215915.832127-6-samuel.holland@sifive.com/

Changes in v2:
 - Rebase on riscv/linux.git for-next

Samuel Holland (3):
  riscv: Enable cbo.zero only when all harts support Zicboz
  riscv: Add support for per-thread envcfg CSR values
  riscv: Call riscv_user_isa_enable() only on the boot hart

 arch/riscv/include/asm/cpufeature.h |  2 +-
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/include/asm/switch_to.h  |  8 ++++++++
 arch/riscv/kernel/cpufeature.c      | 13 +++++++++----
 arch/riscv/kernel/smpboot.c         |  2 --
 arch/riscv/kernel/suspend.c         |  4 ++--
 6 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.44.1


