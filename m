Return-Path: <linux-kernel+bounces-286078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5695163C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD841F22121
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E513D502;
	Wed, 14 Aug 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AJbpQQj+"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428AB13D28A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623091; cv=none; b=j9DKNT/8HT5RELaiEp1cupgDOnX6bw9bTTP5SvykdWZQCoiVrbbtA+W3Mju5o6bYmkfg1iNL60FHBUzReJBlhYruOYe/nF5x5S9+4lVM3DbacfqAh5Qg8lRhDAWR316bcOfGPJp8SWNswgcjYxymYQkW+H1Y+10avEVTU2QFidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623091; c=relaxed/simple;
	bh=T7YUGKLnPVL2PZfmRYneouV9sITFUpm9RZwFSn2Twmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An0rOiFzb2qqa4Xwaulf6F5zKIaensL+bTpKMfBtNzlvQSK2toIzCwh7fsM/jBNjD0GABwmIMyKNbnvWa9g7J+RSB7wnkHjNhxgrfQ5UCaZTdpRuPaa/B6y5v9N9qABZxXaxprBY+5g8urYq+GiRkVHFCoySeGMXtnGLZAneULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AJbpQQj+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so4512089b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723623089; x=1724227889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9csSOaQjk+D5knfqXhaywQ5Jf4PXMtmR5mb/k/VxzE=;
        b=AJbpQQj+VUWuADPQh1mcVg5+b+fy95pwgfB6xhmMHL3zHi5Xw+u5Uly3no4ffVLPPx
         xlEcBYgDFl7iM8pCpKRDOr97AJgIHEzOAxyMDTfmb+77BK9zHyoL10RLI8uGDMwxShKa
         pk+tSZigTrYrWlfLmoz8zdH0CuIlt3m9KcCBqCai02+PJ3AI2QOk/+IzIsF4Kt/xhezY
         VsDCxLbeI6+1f8w8Go9l/htIdA7SBx4m4O6AUju3exmqZtDH7d18Ar8DqRBj89q/jcgh
         HWsAlLOI/omSrHStWuCo/YFnOPFXlFa3xLZwViqCy5waDwRA8fWpJO8y0vJS93dz8qUT
         g1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623089; x=1724227889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9csSOaQjk+D5knfqXhaywQ5Jf4PXMtmR5mb/k/VxzE=;
        b=nySGv281GPRDwIXfxNTv2LCcV5389gUfQpqHdSTlQdHXo0WobTVlOs9YBhwA9339QT
         cXJ5o7fEFMfy6tjkXf8ZpQ0W0giG6STg8MVT5rhReG6gF8Mkbt3j4O6QELKHc0AHAOl9
         jTG3xqhbdWAdi38cZ2SLIM8y0m3XFv/ywuKBEH3TzSaX8ihE9UrJu435kiazNmBaCvUJ
         1OG3Mlb/ngG7Q8DisacEfQQRK/6xpAt7t/fNNCajdtXd4cAMdt0fE9mtxZUsM2j9O/Pw
         BZzg7wkQNAs+k2azgUscDONSqMmA5XNo143kAOQ0L+Lm2YhCRIbAqHde0NoiWF+eAiJ4
         daKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3hbY0nTmw5IL4fLh+Uz52OZiv38Wp08Ra6keeOxJjtjEwQFHJ1mH4tgw8aVsh7NE9okQLa60x6o6fJo4uW9oce/LWKIVNUu0zcfJz
X-Gm-Message-State: AOJu0Yxb+Yqg2O7krg20iqlDzD68u1Hb3OM5yAF7cDpEMuQURogoYT2u
	PJYVeaAiQeii/MHyGiRs2upae4dam+jvaYi9s7gExPw+YD602IJp5ifyQJaCELc=
X-Google-Smtp-Source: AGHT+IH+z9GtXP0j3ifWM3c3Z3a2K9fF3Xmtqa9Q7oc8AId3QDYK1kLAdUBc/ST1j5TIFCX6+ap++Q==
X-Received: by 2002:a05:6a21:b8a:b0:1c0:e68a:9876 with SMTP id adf61e73a8af0-1c8eaf8eb81mr2488803637.50.1723623089406;
        Wed, 14 Aug 2024 01:11:29 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a94d2sm24559955ad.127.2024.08.14.01.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:11:28 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Guo Ren <guoren@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Zhao Ke <ke.zhao@shingroup.cn>
Subject: [PATCH v4 0/3] riscv: Per-thread envcfg CSR support
Date: Wed, 14 Aug 2024 01:10:53 -0700
Message-ID: <20240814081126.956287-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series (or equivalent) is a prerequisite for both user-mode pointer
masking and CFI support, as both of those are per-thread features and
are controlled by fields in the envcfg CSR. These patches are based on
v1 of the pointer masking series[1], with significant input from both
Deepak and Andrew.

[1]: https://lore.kernel.org/linux-riscv/20240319215915.832127-6-samuel.holland@sifive.com/

Changes in v4:
 - Rebase on riscv/for-next (v6.11-rc)
 - Add Conor's Reviewed-by tags from v2 (missed in v3)

Changes in v3:
 - Rebase on riscv/for-next
 - Drop use of __initdata due to conflicts with cpufeature.c refactoring

Changes in v2:
 - Rebase on riscv/for-next

Samuel Holland (3):
  riscv: Enable cbo.zero only when all harts support Zicboz
  riscv: Add support for per-thread envcfg CSR values
  riscv: Call riscv_user_isa_enable() only on the boot hart

 arch/riscv/include/asm/cpufeature.h |  2 +-
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/include/asm/switch_to.h  |  8 ++++++++
 arch/riscv/kernel/cpufeature.c      | 11 ++++++++---
 arch/riscv/kernel/smpboot.c         |  2 --
 arch/riscv/kernel/suspend.c         |  4 ++--
 6 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.45.1


