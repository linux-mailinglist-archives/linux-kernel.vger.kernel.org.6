Return-Path: <linux-kernel+bounces-576503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE2EA71012
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236DC7A4EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462D161321;
	Wed, 26 Mar 2025 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="GlKGdtJP"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942CC1F16B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742966133; cv=none; b=MFUmikuHG9LuQeCkchoVyFtv7COdKEp/gc5NpMR7VAHcMaXcs0lRmfZcGLhxeWGCZkIeLXZ2WTrzPA6pO8wIuc0QH5yeZZCGRUi+czrV7ffLnKEDc9QTN5pX+xCx+1Z09fzK6Lrux6PzMwsRP5FvDD5QbrteKcM2FlMNbOM+yoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742966133; c=relaxed/simple;
	bh=+LJCCKn0opKh5cFi0ybzchKJT1o2HCUGFb7DQNDom4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXHh+hHlL9ZMd+RNdYOnQ5pICaRnMNpaMCUDfjSYymoulDkAzZSvUMgbSjnUNYDwfPEIyg4ftmVZHOYLO7JJ3BC7XFaJRwOc9fAJUqc1hoIgx83ccT+AARFEcPkNdamaNCsE7vzWHiJhk8X6JbvVz7osoIs9gPjINVAMvHxVsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=GlKGdtJP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5FFEF25C5C;
	Wed, 26 Mar 2025 06:15:27 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZlOByq6gm0eH; Wed, 26 Mar 2025 06:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742966126; bh=+LJCCKn0opKh5cFi0ybzchKJT1o2HCUGFb7DQNDom4k=;
	h=From:To:Cc:Subject:Date;
	b=GlKGdtJPQuAkjEi/XT/OFxcpclRpWYtA+k9DvLM7Znud+qCNCBJqJn4mp9BJy6W+/
	 PomhJVkhxGJKLP8LAlrm9XScPlP5VTtYtjhjGpx9YkeR4p1KMfJX180d2EwxFYHD2T
	 0IzNoCmqEb2pJ+mUhGXQYH7whcB5OWyTLmJR3dWroRa6tiFUN5A5jgBrr98PeXO5MA
	 VFVNCJJkqS4lCzymu76ghsLOxnSHIEW1Ghzy1ZPgm0yDgzs+wucD4cB41/zVC+SfWD
	 5UqH8SJUxkCZbUeziR9YOI7+q+N2CzzQbQjihnw8oELA/KqCKpPRZgXNHwKRjOKn5l
	 icyajgZHihFEw==
From: Yao Zi <ziyao@disroot.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Ying Sun <sunying@isrc.iscas.ac.cn>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] riscv/kexec_file: Handle R_RISCV_64 in purgatory relocator
Date: Wed, 26 Mar 2025 05:14:46 +0000
Message-ID: <20250326051445.55131-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 58ff537109ac ("riscv: Omit optimized string routines when
using KASAN") introduced calls to EXPORT_SYMBOL() in assembly string
routines, which result in R_RISCV_64 relocations against
.export_symbol section. As these rountines are reused by RISC-V
purgatory and our relocator doesn't recognize these relocations, this
fails kexec-file-load with dmesg like

	[   11.344251] kexec_image: Unknown rela relocation: 2
	[   11.345972] kexec_image: Error loading purgatory ret=-8

Let's support R_RISCV_64 relocation to fix kexec on 64-bit RISC-V.
32-bit variant isn't covered since KEXEC_FILE and KEXEC_PURGATORY isn't
available.

Fixes: 58ff537109ac ("riscv: Omit optimized string routines when using KASAN")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---

I noticed RISC-V support hasn't been merged into kexec-tools, so this
patch is tested with this dowmstream branch[1].

Thanks for your time and review.

[1]: https://github.com/ziyao233/kexec-tools/tree/rv-Image

 arch/riscv/kernel/elf_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 3c37661801f9..e783a72d051f 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -468,6 +468,9 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		case R_RISCV_ALIGN:
 		case R_RISCV_RELAX:
 			break;
+		case R_RISCV_64:
+			*(u64 *)loc = val;
+			break;
 		default:
 			pr_err("Unknown rela relocation: %d\n", r_type);
 			return -ENOEXEC;
-- 
2.49.0


