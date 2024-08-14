Return-Path: <linux-kernel+bounces-287077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501CC9522A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A371C21F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCF51BE864;
	Wed, 14 Aug 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="o7E1VZmn"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1F1B1505
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663585; cv=none; b=TnIIN4PBXQlPHc8gKAlKbg5vNjqBE3EDeOT2nzLLM8AhedoYF8iuM1MNfjh/SxgSKwvQI5PQ0O4/CuWBaYWg3kA7Ie+z+6YmEMsgF8DvjCpqzk86qRJOxTqKDDA8E//4wnBhhzOglEqLyDYLiAeCjKDsN3jA3OanTroFHFd1Cec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663585; c=relaxed/simple;
	bh=X5k43UmXO+Oox+xquAGWcpfpuqgnORzhkAT7Tv+A/A8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oSN1ZawWxgItcp3qLXLr2+5tw+8Qi4+oQAeJhiUSFW4JdNGBEbWL+sXCo2NKvMvB3zN4c/0dk9/EymJS977oZnY88gOq0w5XCRlav28yIcr/36dsHuh2m4QFejgeGA65N33P7eY8Qpw0veAm5txL5Db943v8mXvwAX02WfURQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=o7E1VZmn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37182eee02dso95310f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723663581; x=1724268381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rOXkKU2W9D9rNgyzn1pK2KXlz25F7zmkDN5gNLIerY=;
        b=o7E1VZmngxBOV52wxqiVqoBr2iaktt343Fwt3oFNuxZ886axKEy0JJ/Mv+05y1p0/5
         eq7I07yUi5BpKw23Wea4Bl0AeY5SSyNXzzRbEwA1JSHBmzweXGR1e4DbF6vtb7G+Suko
         Z3/HmxxdeRZ5FmHZ6cePmk4e3i5y1eB66Ix91ekABHQ0s3QC2SygYuSFz6qqeejv8Tmc
         eeiRI9TDD8MaJj7kleLfeUUONPvcpLADl3Th8FGmgGbr3IWbhlObLuOPobTOMM88B9ve
         QwsNG8O5uqfJ4gcC8QvAe2lhiCYlAgtJT5tU/+/9l42xdGaoSRkPIn9bkvAQICIptl9N
         KU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723663581; x=1724268381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rOXkKU2W9D9rNgyzn1pK2KXlz25F7zmkDN5gNLIerY=;
        b=Qj6lVmGVz8V2EQ3SLeW/vLzbA91rBPQDjirrKgpsRG4l1dLjELrpXgVnNcYbHHXvKt
         S+l8I3+Eo3+1XxcAcsfXkeeHpGIFkShVhNfdwRHe0MBabiDyS4/PKzJXwS2ZIvLVWnES
         GeQvZLRjwH33YQ/psD/kRhJTsUCzAuXkO7djJ9TMwzrsrOkolDniCiBiDIyaRTdm+5/9
         GoV2Jg/IePb1nblajLWgzHiBdDmtug4ZWir4LSxR4eIE5/3CpFPaQc2A8JycevCAhy4A
         oc4BlwJAhbFNEPURccgNN61Im4PjSLcZQF75jD3KXuGDyfQ5046WnaX2vPH1TMoTzIJn
         IHJw==
X-Forwarded-Encrypted: i=1; AJvYcCV5jYblJbeIxyyPvIupbJHiSRnaoaqd/JbvqjMDmIx9FXIxaTiGX/4NucLeXcQDUtFNvAB7PIooq9tSoqp+2IXl45HQKOlmxeMD6wRg
X-Gm-Message-State: AOJu0YwDGw7E8OjF1B8aFK4jUACiB29YtCTjMAlrhvk2gVbTycpX34B+
	M2pPXQzA9+9cWGaZmeMOIRey7sLsugh1FrsfvFq1rOvYHQSZz5s7eZIL46XqhN0=
X-Google-Smtp-Source: AGHT+IHUnDWpVPfNpPkJ+/ynQ0mR1yA85wCz/I8P8Q8Je8RxXlJ7pr4pT2cjP14L/DBSxoHXE4qMpw==
X-Received: by 2002:adf:f7cf:0:b0:366:595c:ca0c with SMTP id ffacd0b85a97d-37186c091f8mr395135f8f.24.1723663581314;
        Wed, 14 Aug 2024 12:26:21 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4f0a6f6fsm13589689f8f.116.2024.08.14.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:26:20 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -fixes v2] riscv: Fix out-of-bounds when accessing Andes per hart vendor extension array
Date: Wed, 14 Aug 2024 21:26:19 +0200
Message-Id: <20240814192619.276794-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The out-of-bounds access is reported by UBSAN:

[    0.000000] UBSAN: array-index-out-of-bounds in ../arch/riscv/kernel/vendor_extensions.c:41:66
[    0.000000] index -1 is out of range for type 'riscv_isavendorinfo [32]'
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2ubuntu-defconfig #2
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] Call Trace:
[    0.000000] [<ffffffff94e078ba>] dump_backtrace+0x32/0x40
[    0.000000] [<ffffffff95c83c1a>] show_stack+0x38/0x44
[    0.000000] [<ffffffff95c94614>] dump_stack_lvl+0x70/0x9c
[    0.000000] [<ffffffff95c94658>] dump_stack+0x18/0x20
[    0.000000] [<ffffffff95c8bbb2>] ubsan_epilogue+0x10/0x46
[    0.000000] [<ffffffff95485a82>] __ubsan_handle_out_of_bounds+0x94/0x9c
[    0.000000] [<ffffffff94e09442>] __riscv_isa_vendor_extension_available+0x90/0x92
[    0.000000] [<ffffffff94e043b6>] riscv_cpufeature_patch_func+0xc4/0x148
[    0.000000] [<ffffffff94e035f8>] _apply_alternatives+0x42/0x50
[    0.000000] [<ffffffff95e04196>] apply_boot_alternatives+0x3c/0x100
[    0.000000] [<ffffffff95e05b52>] setup_arch+0x85a/0x8bc
[    0.000000] [<ffffffff95e00ca0>] start_kernel+0xa4/0xfb6

The dereferencing using cpu should actually not happen, so remove it.

Fixes: 23c996fc2bc1 ("riscv: Extend cpufeature.c to detect vendor extensions")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vendor_extensions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
index b6c1e7b5d34b..a8126d118341 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -38,7 +38,7 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
 	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
 	case ANDES_VENDOR_ID:
 		bmap = &riscv_isa_vendor_ext_list_andes.all_harts_isa_bitmap;
-		cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
+		cpu_bmap = riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap;
 		break;
 	#endif
 	default:
-- 
2.39.2


