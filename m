Return-Path: <linux-kernel+bounces-282294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9594E1BD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04F81C20ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086A14A4DC;
	Sun, 11 Aug 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qtuG2Zgu"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2BB64E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723388556; cv=none; b=u4Wj1dzWumw4Y0v9g8D3Yqf8KE2wksEYqJr3IT5P59ESLfqR9SZUpFe9C4Rh5ghCtA+gkIypqYToNoPk+1zvr33t8TBmIKTlXWRaUoSak/DkewkDBhsewmMLo9MDHsox5aKLu13eQrqLUoKdpJToWrkx1CVb1bmsac5AAQHLLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723388556; c=relaxed/simple;
	bh=jQWRBifP3hn2MLO3T+N+xofhWxRbJBmY0S9EDLKMbAs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YqD0zW9SGNrjEdx4fhAl8kKhSIe5fpBmHXNgioJ4kuYJAo9oC4/IKbXbvovS08HP6/Qo/spbl9e9GREnpmwdJLSR8nYomRKt2i/Zi2ZKpRu6II9/j4o050uK0vm742JpfVvR1cmVm3iGZ55qOkCuc+VPdwnZsFeFRspGDynrS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qtuG2Zgu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f1870c355cso34704771fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723388552; x=1723993352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPwjDhi7KuLfP5w2qSCJy9Pe3ty8wsK+Of52u0lxUqk=;
        b=qtuG2Zgu6h2PNwfZ3feUZvw9TqZEhuv5UCBpCRJALFRd8FuORbYq56sO/de2zSBcWp
         IXFfAeCdJWdoOoWvwQdZcAUXuKKf+HXhLWOYdZBHY6mpvJx0EcM9rjDSKa99xnLX7zW3
         L0N5jSzf9ku/TxgIo1dXyf40nR0/6+5TIM2jw41U/OOuicZClBGIzGj3DR7iE5cLhW1w
         aL+/1Te4s2qTRov/++PgndmoJzb01nJzbotkRGA2k0WjpqGbB3EDk9NrW/B6CikM7HTr
         IOCD2QOvHoWswJuttNbNtBI6hsLI/Atygllw+9gCVUpSeRrmQ8hQEOLU5pu5AMBMDUun
         NDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723388552; x=1723993352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPwjDhi7KuLfP5w2qSCJy9Pe3ty8wsK+Of52u0lxUqk=;
        b=NEoPuP7VXzmIKWKkHYhTcHLnoWNooOSOUdCuZr6JFMofL/6Vz5HBvM4CeH9QwUC7l6
         lY2HXs8tTSohu8CIJpdBJ+r3uFkcWs4vMMbgYo5amm0CXxYjZBuXj1V1RR63DEwfbGO/
         /OCvqbeoJfYo7DPn4S2WuBbqKtVzD6SI51QMG4fLXmmRop4UKvCqU3oXeSPb4wPFE92G
         9SdiS6ra0oubHzZMONyvQ9mqwrVruAMtBAh1eo1vaZc34RUNkNvtw0SNtXaWBrgqg3m9
         sfnoEUZlf89m2/EH5XxTPEnNDLJSafGyLRwtYySMnc4ytdGQ4wVQornpbe9XwGkyPKmy
         fa5A==
X-Forwarded-Encrypted: i=1; AJvYcCVA+AE6+ufBK8H6YJqh8liMY4445BNwhRjnv1B6bnOigBsb0xe5PE44pWr8WpmBFs4gvKu8jkxaGmSX8D11dSy8xDX6RZKn5kZquvcZ
X-Gm-Message-State: AOJu0YxcT+vasCElL5dy4NACeeq3qFiKaosj6JdiUt7eEStK1LeRosNL
	kpo9JeFSi4Fmx1CRklbzCzJRPGMuNYOuYuHHYSpYoq7m1h/XQ7bNBF8JqnK/PGrvOlZezXzKSRm
	D
X-Google-Smtp-Source: AGHT+IFvk8ykrXwv5JN7Ut+OBiNYWgGRWCFMRTpXj8rPw95TTv9BOxj1UW1uuL24C6SjPGc/jTFePg==
X-Received: by 2002:a2e:f1a:0:b0:2ef:2c87:3bd7 with SMTP id 38308e7fff4ca-2f1a6ce6ea0mr45870891fa.37.1723388551654;
        Sun, 11 Aug 2024 08:02:31 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738e01sm152901205e9.11.2024.08.11.08.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:02:31 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: Fix out-of-bounds when accessing Andes per hart vendor extension array
Date: Sun, 11 Aug 2024 17:02:29 +0200
Message-Id: <20240811150229.82321-1-alexghiti@rivosinc.com>
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

This happens because we unconditionally use the cpu parameter to access
this array. But if -1 is passed, that means we should not and we don't
need to access this array, so simply prevent accessing the array in that case.

Fixes: 23c996fc2bc1 ("riscv: Extend cpufeature.c to detect vendor extensions")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vendor_extensions.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
index b6c1e7b5d34b..01dc79b1d17b 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -27,7 +27,7 @@ const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_li
  * @bit: bit position of the desired extension
  * Return: true or false
  *
- * NOTE: When cpu is -1, will check if extension is available on all cpus
+ * NOTE: When cpu is VENDOR_EXT_ALL_CPUS, will check if extension is available on all cpus
  */
 bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit)
 {
@@ -38,14 +38,15 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
 	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
 	case ANDES_VENDOR_ID:
 		bmap = &riscv_isa_vendor_ext_list_andes.all_harts_isa_bitmap;
-		cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
+		if (cpu != VENDOR_EXT_ALL_CPUS)
+			cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
 		break;
 	#endif
 	default:
 		return false;
 	}
 
-	if (cpu != -1)
+	if (cpu != VENDOR_EXT_ALL_CPUS)
 		bmap = &cpu_bmap[cpu];
 
 	if (bit >= RISCV_ISA_VENDOR_EXT_MAX)
-- 
2.39.2


