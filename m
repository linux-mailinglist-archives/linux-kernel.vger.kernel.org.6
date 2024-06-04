Return-Path: <linux-kernel+bounces-200624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7958FB287
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D98EB24D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E31465A7;
	Tue,  4 Jun 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZZ9gtc+H"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525814658B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505174; cv=none; b=bxSlY//Uev+sTMoOumCjD3/2X/9xbYbtLrAOkHJS6rBc30FNOxH5jWoBQZ09aavQ905WAjFmnFUMPw6+C5lm7DXFpaiFexwRXK4PnbajsP+B6XyDFHBEsEIvQC6W3fcGrHceLbkQp86fBl1Fc2eHY2Lxa+CgmDIYG1rsoyX2X1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505174; c=relaxed/simple;
	bh=rXkB9HSCpKxWLSjih7qqbvvJKhAnmk8tL5d1yBuTZvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V79jHEARZ5c/iv0U0z+bPvfw5nnV50cdv5FLHV5oNOtoftPAZ3n32bPV6ikeN/wLAA85J9wQmXB3qf0IrjDio1vC/LrDOBRHpfYJYAxeL3gIEw2k0Tzu4+KMkmEsJg+XbHTqu3hipYaJroBjDiLQcQ9Noxxoz+CN9TjUdGAscRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZZ9gtc+H; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f64a3e5d6fso781745ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717505170; x=1718109970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RlFfGyvlYpwu5mumxxHK+PtmO5s3+buvtb+SvPxc6V0=;
        b=ZZ9gtc+HzFnFoM18eou/rOcC3NuD4FVSM/dEi8JicBScNDcQrq+bw+4b0PlcchXbcJ
         Es+wj3Zsf0jnCklYbhskBaJIqBBW9kwgkV/qoUgxySJ5t+seyFhQEFscN3u3CZqERisw
         XtTsa04EFvTWu/faxFMeiQsK4r63Q4WMVTCZQpZVFI2fascUv0bW0qlvlFb6A7WDeXR4
         k1zQw8XY9TI4O0ki2x8QW4vq/HdIG7a7DODs8tqOFulQ3YfWoM5qiGBmnhx910yQed71
         Ml8l6ilx05hOOGkLF3BgcYu7MmJB6DvC22dxAKFEuCm/3Gn2aYDo1DwPlY9EGgtsvY5T
         iMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505170; x=1718109970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlFfGyvlYpwu5mumxxHK+PtmO5s3+buvtb+SvPxc6V0=;
        b=Y6aXEmuRmEVTAgTOmWuu29yIthrzFaMkBrec+G3izD3cuSQrDYYpwAfRHMjovFTswo
         NwdWdQEH9aOeODZgt0Pl7SoRjcxB7s2oqL5etfz8URPyIj6jJT3SxeKTcWlS0W5dHPRn
         zSaCn5IeWpbhXQXoiFlIScYsCbC+QKf9F53plPdm5Uu8an3jgbfeS5RFxCdftSh9+wUJ
         xg+05I3wkPKBmFSjT6U1+htw1Hr/UUjwXdDelpJvw8aZOsNmuqVk6651xOTLXTh5P/Hc
         nbik54bhep0bbVbm9doX49S+w3IelFa5RB3fAVyvQYvo3LtogdkGHD9AmXrlgtoxqaue
         ukkg==
X-Forwarded-Encrypted: i=1; AJvYcCUc7M2G80AdH5Z6kamCrmyjCXgdN4UhoztDBzfHcobntjKLvFXOQMOXYHOa+d/fv7Owl6l73AA5ALGsx83UvbYsWcNWZYENa6ci5v4b
X-Gm-Message-State: AOJu0YzCO9RmFWlwttUMg3ksVyPNnmTaDQqODMetkhLaUrkIGhgdP+Lx
	4qvWcRkqPiR/FrLs8vlw28+ris6eYYgJT7kTrxbbL0AYQyC1jk+lvAWqO9wmeHY=
X-Google-Smtp-Source: AGHT+IHYa0Aw6/ZCoGM1K6W/t5DQ4yQlSVhFECl9FxLx/IWFviwLhyvqWExcUz4B81YUgol+CdCuQw==
X-Received: by 2002:a17:902:ea0e:b0:1f2:fbc8:643c with SMTP id d9443c01a7336-1f6370f2847mr137326235ad.3.1717505170463;
        Tue, 04 Jun 2024 05:46:10 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:327b:5ba3:8154:37ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ebc69sm83042885ad.211.2024.06.04.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:46:09 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 00/16] Add support for a few Zc* extensions, Zcmop and Zimop
Date: Tue,  4 Jun 2024 14:45:32 +0200
Message-ID: <20240604124550.3214710-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for (yet again) more RVA23U64 missing extensions. Add
support for Zimop, Zcmop, Zca, Zcf, Zcd and Zcb extensions ISA string
parsing, hwprobe and kvm support. Zce, Zcmt and Zcmp extensions have
been left out since they target microcontrollers/embedded CPUs and are
not needed by RVA23U64.

Since Zc* extensions states that C implies Zca, Zcf (if F and RV32), Zcd
(if D), this series modifies the way ISA string is parsed and now does
it in two phases. First one parses the string and the second one
validates it for the final ISA description.

Link: https://lore.kernel.org/linux-riscv/20240404103254.1752834-1-cleger@rivosinc.com/ [1]
Link: https://lore.kernel.org/all/20240409143839.558784-1-cleger@rivosinc.com/ [2]

---

v6:
 - Rebased on riscv/for-next
 - Remove ternary operator to use 'if()' instead in extension checks
 - v5: https://lore.kernel.org/all/20240517145302.971019-1-cleger@rivosinc.com/

v5:
 - Merged in Zimop to avoid any uneeded series dependencies
 - Rework dependency resolution loop to loop on source isa first rather
   than on all extension.
 - Disabled extensions in source isa once set in resolved isa
 - Rename riscv_resolve_isa() parameters
 - v4: https://lore.kernel.org/all/20240429150553.625165-1-cleger@rivosinc.com/

v4:
 - Modify validate() callbacks to return 0, -EPROBEDEFER or another
   error.
 - v3: https://lore.kernel.org/all/20240423124326.2532796-1-cleger@rivosinc.com/

v3:
 - Fix typo "exists" -> "exist"
 - Remove C implies Zca, Zcd, Zcf, dt-bindings rules
 - Rework ISA string resolver to handle dependencies
 - v2: https://lore.kernel.org/all/20240418124300.1387978-1-cleger@rivosinc.com/

v2:
 - Add Zc* dependencies validation in dt-bindings
 - v1: https://lore.kernel.org/lkml/20240410091106.749233-1-cleger@rivosinc.com/

Clément Léger (16):
  dt-bindings: riscv: add Zimop ISA extension description
  riscv: add ISA extension parsing for Zimop
  riscv: hwprobe: export Zimop ISA extension
  RISC-V: KVM: Allow Zimop extension for Guest/VM
  KVM: riscv: selftests: Add Zimop extension to get-reg-list test
  dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension
    description
  riscv: add ISA extensions validation callback
  riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
  riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
  RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
  KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
  dt-bindings: riscv: add Zcmop ISA extension description
  riscv: add ISA extension parsing for Zcmop
  riscv: hwprobe: export Zcmop ISA extension
  RISC-V: KVM: Allow Zcmop extension for Guest/VM
  KVM: riscv: selftests: Add Zcmop extension to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |  28 ++
 .../devicetree/bindings/riscv/extensions.yaml |  95 ++++++
 arch/riscv/include/asm/cpufeature.h           |   1 +
 arch/riscv/include/asm/hwcap.h                |   7 +-
 arch/riscv/include/uapi/asm/hwprobe.h         |   6 +
 arch/riscv/include/uapi/asm/kvm.h             |   6 +
 arch/riscv/kernel/cpufeature.c                | 278 ++++++++++++------
 arch/riscv/kernel/sys_hwprobe.c               |   6 +
 arch/riscv/kvm/vcpu_onereg.c                  |  12 +
 .../selftests/kvm/riscv/get-reg-list.c        |  24 ++
 10 files changed, 375 insertions(+), 88 deletions(-)

-- 
2.45.1


