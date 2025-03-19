Return-Path: <linux-kernel+bounces-568595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBEFA6981C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D91D17E8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB2220B1F4;
	Wed, 19 Mar 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jRXGJ4Wf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB91DE3C5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409332; cv=none; b=RZYeYLD2lztXtR/NqYeEkWecrj9N7adQ2jVCufK+uLos7j92Wx2VIHTyJq/uJ6n1HMqe/IfBcd8G/UlgKh07eGpDQSxcQ9J4WXMclHOr2BPIJRekZbtMQxT6nvJtqP0xKHwx6QaPViczh4/nfskjHXetf2uWP6VN9bZ7JuD/qUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409332; c=relaxed/simple;
	bh=W5HAab9oDLuYRICYvlEMdiuN+/zGZj7GP8xToCVp9CQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Afr1apiEukrC41ZdNHwzk7l0kjJ7CQPpQKO95Bzqb5Jt6ZrKwY6X5/7E690yK4skmkDpgeWYljp9VYmV37I7WJn2PUuUOzR2LOLUsKZE6tQltlySBqJinTwf4rLKMi8UyKJz6CKmk7jKEuU/gviDyISi56uT297NhQLYsoY1374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jRXGJ4Wf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240b4de12bso55093675ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742409330; x=1743014130; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLB94k0pWwcNjDTf4HpckyyyYqaKP2kOAdvgI5dwRD0=;
        b=jRXGJ4WfWTm9LASP0UvenWq4ViVW1HhYnusFn0J9ycLLNdB5rgvODkcnOoqG+Ljx3v
         zcjX9s0qVMOqcXZzG3mn1+yGlw/+55PLFgZnwkIIjK8fNi+nRn6kFVXnbmcC+igoVQwo
         fAt4sm3ndgfJHfHJ8LcKtwpfmdEL+oeFFaN4eCRAFU1jOq6Zc1BhCkE49RJF8doBnYpz
         p73IkW06CPAnwD/GDVa2PPsSDRh/wuQL4CWheLtTSpxYfGDaPEwlDL8OeX2u86baf5ut
         SyG7QZN6ftQV+BtCdYJi3BeGNEvDFX8Yz4KflnUMy2xx7PpBUQsCce9iLKi5mINyGLwm
         L+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409330; x=1743014130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLB94k0pWwcNjDTf4HpckyyyYqaKP2kOAdvgI5dwRD0=;
        b=PJ/8QK6fbpTJo8hGoulGfF/ROyQNzo77xuYDCLiteDVykFyGZE6aQr6oE0zlnK9orq
         8MFYTowMpg3z011W13HB8hJsRJf2nynyTzVbjTRgUnS3t0eK5sRM50B3GPNcTE43e7Rc
         1qgJ8qHfHLWGdJ+pm0wwYiXt4A2mHXqMwI8hH633a1tn7jhVu8gERxOzvjretDoOm9gx
         nMhm9ls1AGpd0w5swcAVUqnaIBI81kwSujIaXaehG8O1vIFOB4gFPqVbP2/wb3quuvTy
         PrBjzaOj+/v1iTlO8Fie+IKL8siKqqbmrHYy/AS9/iRLC/MzScem/7sSRDemimaMUSM1
         RITg==
X-Forwarded-Encrypted: i=1; AJvYcCVKbhMZdy8RxD11xGyIQlI4eEUN6OMAy10wrtVanF/U2q2QjeM/l5Pp24kcGqgsRQaR5Y2oXXxt0qp0B50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnW3m+S7tSVnYdcvXtFX1IENwxtnp4wciG1dDpyyWT/3M+jZB
	WIqzZJV1o55js8aR77CS6WzQWRi/4l72jVehwQVZNnW7LnIk46QHXH+3JljY3VQ=
X-Gm-Gg: ASbGncvwpBGfw3ujyRtMqk5OKJzmOuRosmAfYhh7Ia/27Ll8YHnrx46qmrU2I1QrzUh
	WRPjJ3C5m8lzvasR9pbbZd2iINnmuX2qbiOqtjKD5VAZw/blNY1BfcFmg2L7pajuT1/XnNtloTN
	eJUiA8ToXBROzHQdqVmFpDQ+27PfXBEHlw+VwpsZqp6+Q/Y04Q/Udjva1SHizcklSJgDn7arp8O
	MdT2oS3lL5/7Q2xvb8MlGfcu94yGiZtmiOKpNY8yOv2fRtsbjQ3vV4CFjOKatv7kSaIUxoC+u2O
	N5JZYGIbWhaVVTQ70tn2ZfPcBUprRYb6IqpjRoLKXXuv7K2nHsjgKQ4GPp38
X-Google-Smtp-Source: AGHT+IFVencsDHsxhBLdjviuxV/nTve4fWCDhTlSSgoJ73p52e8QK2ha6x6mXRahaOg9bIfOX//V7Q==
X-Received: by 2002:a05:6a00:98f:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-7376d631f92mr6684951b3a.11.1742409329749;
        Wed, 19 Mar 2025 11:35:29 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e109sm11993844b3a.115.2025.03.19.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:35:28 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v10 0/2] riscv: Add runtime constant support
Date: Wed, 19 Mar 2025 11:35:18 -0700
Message-Id: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYO22cC/43Q3UoDMRAF4Fcpe20kk8mvV76HSMkmE5sLdyWpQ
 Sl9d9OCdJEUvJwD881wTlOlkqlOT7vTVKjlmtelD8AfdlM4+OWNWI49mAQXioNAVj6XY36nfVi
 XetyXXENjOkSrJJGwYKa++VEo5a8r+/La50Oux7V8X680uKS/nhl6DRgw49TMBZIXfH4uua01L
 +ExrO/ThWziH4zojFOeTEjOeHQDBreMHTPYGQAnhLOORMQBIzcM8jEjO9O3dZAwm9mFAaNujOD
 jrpvqzBw0GNQe+08DRm8YEGNGdwYpcZB6RhhWbLbMnW5MZ0giGI2gTEoDxt4Y5GrM2M4kr3VCq
 W30o27chrn3jWOcxRhRoYxIlv4w5/P5BxAjYmzyAgAA
X-Change-ID: 20250123-runtime_const_riscv-6cd854ee2817
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Pasha Bouzarjomehri <pasha@rivosinc.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3346; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=W5HAab9oDLuYRICYvlEMdiuN+/zGZj7GP8xToCVp9CQ=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/ptvowLqtdfbshw2Xz1884ba15c+cgRezlkuu4FO1W36
 aKfreM0O0pZGMS4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZiI/VaGX8yPm1Yw+srpR2+S
 UOWcsf+wpuWmw5vrDrFWLjRsbTNQ38/wv3jV4Q3lDLNsDe/Lzp8W9W1yyZLzYlciOiulzndtmG5
 lzgsA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Ard brought this to my attention in this patch [1].

I benchmarked this patch on the Nezha D1 (which does not contain Zba or
Zbkb so it uses the default algorithm) by navigating through a large
directory structure. I created a 1000-deep directory structure and then
cd and ls through it. With this patch there was a 0.57% performance
improvement.

[1] https://lore.kernel.org/lkml/CAMj1kXE4DJnwFejNWQu784GvyJO=aGNrzuLjSxiowX_e7nW8QA@mail.gmail.com/

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v10:
- Use _AC() instead of just adding U to the end of a constant
- Link to v9: https://lore.kernel.org/r/20250318-runtime_const_riscv-v9-0-ddd3534d3e8e@rivosinc.com

Changes in v9:
- Fix bug where stale register data may be used when an lui is replaced
  with a nop. In the following addiw, add to register x0 instead of the
  stale register to resolve.
- Add locks for text_mutex before using patch_insn_write()
- Link to v8: https://lore.kernel.org/r/20250305-runtime_const_riscv-v8-1-fa66f3468dac@rivosinc.com

Changes in v8:
- Rebase to linux v6.14-rc5
- Link to v7: https://lore.kernel.org/r/20250218-runtime_const_riscv-v7-1-e431763157ff@rivosinc.com

Changes in v7:
- Added benchmarking info
- Added CONFIG_RISCV_ISA_ZBA and CONFIG_RISCV_ISA_ZBKB to check that the
  compiler supports the extensions.
- Link to v6: https://lore.kernel.org/r/20250212-runtime_const_riscv-v6-1-3ef0146b310b@rivosinc.com

Changes in v6:
- .option arch only became officially supported by clang in version 17.
  Add a config to check that and guard the alternatives uses .option
  arch.
- Link to v5: https://lore.kernel.org/r/20250203-runtime_const_riscv-v5-1-bc61736a3229@rivosinc.com

Changes in v5:
- Split instructions into 16-bit parcels to avoid alignment (Emil)
- Link to v4: https://lore.kernel.org/r/20250130-runtime_const_riscv-v4-1-2d36c41b7b9c@rivosinc.com

Changes in v4:
- Add newlines after riscv32 assembler directives
- Align instructions along 32-bit boundary (Emil)
- Link to v3: https://lore.kernel.org/r/20250128-runtime_const_riscv-v3-1-11922989e2d3@rivosinc.com

Changes in v3:
- Leverage "pack" instruction for runtime_const_ptr() to reduce hot path
  by 3 instructions if Zbkb is supported. Suggested by Pasha Bouzarjomehri (pasha@rivosinc.com)
- Link to v2: https://lore.kernel.org/r/20250127-runtime_const_riscv-v2-1-95ae7cf97a39@rivosinc.com

Changes in v2:
- Treat instructions as __le32 and do proper conversions (Ben)
- Link to v1: https://lore.kernel.org/r/20250127-runtime_const_riscv-v1-1-795b023ea20b@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Move nop definition to insn-def.h
      riscv: Add runtime constant support

 arch/riscv/Kconfig                     |  22 +++
 arch/riscv/include/asm/asm.h           |   1 +
 arch/riscv/include/asm/ftrace.h        |   1 -
 arch/riscv/include/asm/insn-def.h      |   3 +
 arch/riscv/include/asm/runtime-const.h | 265 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/ftrace.c             |   6 +-
 arch/riscv/kernel/jump_label.c         |   4 +-
 arch/riscv/kernel/vmlinux.lds.S        |   3 +
 8 files changed, 299 insertions(+), 6 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250123-runtime_const_riscv-6cd854ee2817
-- 
- Charlie


