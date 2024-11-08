Return-Path: <linux-kernel+bounces-402500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CA9C2868
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6181C2245C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67BA1DE881;
	Fri,  8 Nov 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1OoGn5ie"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD851E0DB2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109675; cv=none; b=hc/XlLhiURsMkGvdaZUZO/573lwNUaaOpZxx8btCT5EgHEk84Ri+TVizHC804+z0/E81+a5RfdfzTGI0oOsf9cn+dfqkcUzLtDihFv6EP6XH47buuHlBZWz+wXmsGWXAViSculw5Q+8dZ9/vMau0NCTo34kT8Zx5pxUbn8bU8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109675; c=relaxed/simple;
	bh=ffwfWA/+f1ixyduX5KwLaumFNq5ov3RSm3STfwiajJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rq8VCgTHdyUcQFWpkLcwgAPP63KxkLvUYKPQJJ/n5UG1iDLoxoHDQyLeINUXq5DxgUon55TKyjGZOV54k7zL+YlrHESte9NJUeCb93sqCY0K4np+7MiyKyIuuVJI1NRYBlXjWxUEplEZKhSWOBENieEZnHtYRPWTeEHite4rOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1OoGn5ie; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso2117363b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731109672; x=1731714472; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLT8y+Br7ZOzC38CGdRLNZ2zunKzFtQpFi1e/g4uRn0=;
        b=1OoGn5iegmY35TFDeVItbH6+iv9AgyIDcwSRMrYL++5lbihmU4vg1yHC5or0zNuoq6
         eQ+IfRspeD+g/tw6nvyumUBj83poxXyFG53yHjonvdTitPviEcYjkrFyWIVX4px8aQyv
         kgN7BCowq29sWxsRfl7hDBT4NGtnCjFZOgiL8sG4vYAHHh/NdUVZhGthUolxeG5Ike5G
         kHXCpsAxd5GaGBglUMtncXn3ZTKk+sCECKVJXLOkwCLDcwTkk4q6Hyv6Q5t0SvjdQg4g
         DcgwCVNz4QB5awFra12/AWJx3DScGMeFOnZl3C1Fa67pjExxE0XfD+WlEO/y8w+08znI
         7Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109672; x=1731714472;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLT8y+Br7ZOzC38CGdRLNZ2zunKzFtQpFi1e/g4uRn0=;
        b=Z8oxGljnjMjKwW1x16Igs+4qG1LYINpmczwmEv9hL1eyG/EOWP+Kq3mNqDAk/CnlTU
         PonsDDe9MPFj/AehDGAvwkFj1hXUtTw3Yu31mdS1pjqD+fH3WWEPxabgU2YMHG+o3ltQ
         dgRf1wom3g5deqD3ltueYUT+1ngHuJTwLYTomzO0mdyMOFtGZnbmVZOFB+akzPg+9FJ6
         fquQ45LZfFBtrRCLZmCp9imbEUF0nkIRm24UjXPQLoUtAyJD7EXS67L3EHLF08BxSxSP
         5mjJplwG/LBn+fioYPH03QkpQeSmohlErh2GBG1XJRPrKyLa65WbisQwAzJjGR/3esPm
         fEdw==
X-Forwarded-Encrypted: i=1; AJvYcCWkQlAMOOmYoQlIxSiiucRrFzxTNSHt92KvFn/9WjSxtZRkhADNPfHCfRi8A8khU5DXnSik8e/tGtIRXvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQxNMJ1PifSOjmjHqZHo2cPKIWwqNlbKdcjU9VN8KXt8/cIY7
	8UIN0KGhb4yW98RlQDS3hwcnQIUxuPa6jtjceI/VijZA7WW36KEZZbJ3gUFAvw4=
X-Google-Smtp-Source: AGHT+IG3/42zTy6o/j0Vb6GpHhmw+p9iTLxozbfpy14GTVUlms+HosrVJ4hPPfRbbps9yC1k8ErBoA==
X-Received: by 2002:a05:6a00:14d2:b0:71e:cb:e7bf with SMTP id d2e1a72fcca58-724133625a2mr5595089b3a.18.1731109671901;
        Fri, 08 Nov 2024 15:47:51 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a56048sm4376576b3a.174.2024.11.08.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 15:47:50 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 08 Nov 2024 15:47:36 -0800
Subject: [PATCH for-next v2] riscv: Fix default misaligned access trap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-fix_handle_misaligned_load-v2-1-91d547ce64db@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIABejLmcC/42NQQqDMBBFryKzbkoSWhO76j2KiCajDmgiiQSLe
 PeGnKDLz/u8d0LEQBjhVZ0QMFEk7/KQtwrM3LsJGdm8QXL5EIIrNtLRZWAX7FaK/UKTQ9stvrd
 MD6hrM3DNa4Qs2ALmd5F/YPSBOTx2aDOZKe4+fEs1icL/CSTBBOPKKv2Upmka8Q6UfCRn7sav0
 F7X9QPChXlO0QAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jesse Taube <Mr.Bossman075@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ffwfWA/+f1ixyduX5KwLaumFNq5ov3RSm3STfwiajJA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7reYjnNpxUrJr++e6n/RMb6tN63Lybf3/Hl3b2V/6YzM
 F78eCXiY0cpC4MYB4OsmCILz7UG5tY7+mVHRcsmwMxhZQIZwsDFKQATKepgZLiUezQlZf9TJ5n5
 CsVl7Hn3JyqvfxrzZ3vAupCc6ezrvlxgZPguIMoSvefezYVpIlcFLD/xv+P/zFh0YqLzKrkny38
 uD+YDAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Commit d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses
supported") removed the default handlers for handle_misaligned_load()
and handle_misaligned_store(). When the kernel is compiled without
RISCV_SCALAR_MISALIGNED, these handlers are never defined, causing
compilation errors.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses supported")
---
Changes in v2:
- Change CONFIG_RISCV_SCALAR_MISALIGNED to CONFIG_RISCV_MISALIGNED
  (Jesse)
- Link to v1: https://lore.kernel.org/r/20241107-fix_handle_misaligned_load-v1-1-07d7852c9991@rivosinc.com
---
 arch/riscv/include/asm/entry-common.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 7b32d2b08bb6..b28ccc6cdeea 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -25,7 +25,19 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
 
+#ifdef CONFIG_RISCV_MISALIGNED
 int handle_misaligned_load(struct pt_regs *regs);
 int handle_misaligned_store(struct pt_regs *regs);
+#else
+static inline int handle_misaligned_load(struct pt_regs *regs)
+{
+	return -1;
+}
+
+static inline int handle_misaligned_store(struct pt_regs *regs)
+{
+	return -1;
+}
+#endif
 
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */

---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20241107-fix_handle_misaligned_load-8be86cb0806e
-- 
- Charlie


