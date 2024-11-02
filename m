Return-Path: <linux-kernel+bounces-393059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD49B9B74
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A305C1C212CB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FCA14A4DF;
	Sat,  2 Nov 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V2q5SS4z"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F34140E50
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506135; cv=none; b=tUUk+7in2jil3t8k6lEQJGO9JGX2IzFJtpwtC0Uf/FdrRepQb+2L0eyL1kI3kZHo0W+0U9czeC79Hf0b5y2VV3xm24SNjsiRHqOVGApQpiDL83r/JUNL40UqujCnfOCvck/L2S8X0nessfyIRls8+i5U3AwT5MiwBJLijUzrOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506135; c=relaxed/simple;
	bh=Esqvb8XTtz8KDAVXrjRDBkMExGaysFhCT21Y3EvyG3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwaOBosoiLxtO7Pq4FmwAa6/RPxcS+9HRN3Hs74nQl2I17pZWiIZm8Bvxod4BKDPhD3dd3xhc3IXaclpGOKeG87G8S2h/CPUSXlMlXxc/nriEwIe3PdfXRl6dCzGlzaxU5t8ABuidxOelvRRNWFG35P0VrCssgrBdoY3ECz4Pvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=V2q5SS4z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so1980908a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730506133; x=1731110933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f0bfv/UG/JqamBlr6Ml5vEqFTtFdcwNeUu8mlrjgUs=;
        b=V2q5SS4z16QhtOrgIABzWclv8nq1iDCOyxaPUADKm3t4Wzln9rVR7Z4AQofVHGKel9
         Jjq4pMxxa5/mCjmr3nrVNKqs9IbbjteQn8XGwATnbJDdbC+FyYjpD6VXd80J183EcaKM
         WfufT61YkSHcAiwx8kllKpy+t2N74mN3K91HRE0ViltSk/XHf0wxLbPsw9Yv2C1EgNtu
         CQexe6G9IX2lQJ43iTVH6EZ3AwNLmVlvcgf/WoN02WClnYIJv/Y2bKGswycEB20MXv+f
         hYDeA5dRy7kbmnveWCUEKf6qexEaxVMh7zqhHpM/w/RrC0iKTQj6IN6XvqlWj/0z2TMw
         hSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506133; x=1731110933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f0bfv/UG/JqamBlr6Ml5vEqFTtFdcwNeUu8mlrjgUs=;
        b=WTgvHkAZ+hb+lsN+ckrQt+v9xReMQNWv3EoNKLtuPb2ayJPRXcSAV4Xgzma6QmKlC9
         U83LXxCoiXSbXih61QgkDkonN2nTaaMDTVj1rJ3mYM+Qxzeb3SqqnQBH6fzVmgUKnwL0
         iJNm98gdpEznlZwSc8XkAM2dxDCLuIIAopon0kaYQpJNqDMeddxl5EcT29Zh/0fbtUBR
         0PNbbd17LClzCqZgCSbqecOWMOV/QZd/nWa26e0/mW39XxAkgtJZfWlhZiMDiIyMssYS
         QQtfaJ4zUMW2WUttXzU5xfTCkSy+AGR8afBqdvMmCrKOstO6pl/qhVhoANpDKTgULT03
         IoUg==
X-Forwarded-Encrypted: i=1; AJvYcCVNdfkw8tCh5AwwGTi+Cn8a1th5WZT28FRXd2sKtj3FLQMW/7Mgg1UYYCzaulhLdZI5VTazAn3+oI5Cmdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6+cLBGwat2wrprgvtMb4V8itMUx8VHCUVHTP7TIVabaj2vgyH
	/Pm5YsFyecV2KvyvRNShc75+FumpITdfLOJrPmtpOcjugtgq/f241bKyH5jQXO4=
X-Google-Smtp-Source: AGHT+IFzEa5gdEJWrmZ3qEErWiVz4Nclj5KffdLeaW0o88JxBl0OqASLc7B/YtrAYBvQuvsBiZVowQ==
X-Received: by 2002:a17:90a:7c03:b0:2e2:e6fa:cfef with SMTP id 98e67ed59e1d1-2e8f11bad3emr24772724a91.25.1730506133062;
        Fri, 01 Nov 2024 17:08:53 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc00856sm5505749a91.54.2024.11.01.17.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:08:52 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 05/11] riscv: ptdump: Only show N and MT bits when enabled in the kernel
Date: Fri,  1 Nov 2024 17:07:59 -0700
Message-ID: <20241102000843.1301099-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241102000843.1301099-1-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the Svnapot or Svpbmt extension is not implemented, the
corresponding page table bits are reserved, and must be zero. There is
no need to show them in the ptdump output.

When the Kconfig option for an extension is disabled, we assume it is
not implemented. In that case, the kernel may provide a fallback
definition for the fields, like how _PAGE_MTMASK is defined on riscv32.
Using those fallback definitions in ptdump would produce incorrect
results. To avoid this, hide the fields from the ptdump output.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/mm/ptdump.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 9d5f657a251b..58a7322e9a82 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -135,11 +135,13 @@ struct prot_bits {
 
 static const struct prot_bits pte_bits[] = {
 	{
-#ifdef CONFIG_64BIT
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
 		.mask = _PAGE_NAPOT,
 		.set = "N",
 		.clear = ".",
 	}, {
+#endif
+#ifdef CONFIG_RISCV_ISA_SVPBMT
 		.mask = _PAGE_MTMASK_SVPBMT,
 		.set = "MT(%s)",
 		.clear = "  ..  ",
@@ -215,7 +217,7 @@ static void dump_prot(struct pg_state *st)
 		if (val) {
 			if (pte_bits[i].mask == _PAGE_SOFT)
 				sprintf(s, pte_bits[i].set, val >> 8);
-#ifdef CONFIG_64BIT
+#ifdef CONFIG_RISCV_ISA_SVPBMT
 			else if (pte_bits[i].mask == _PAGE_MTMASK_SVPBMT) {
 				if (val == _PAGE_NOCACHE_SVPBMT)
 					sprintf(s, pte_bits[i].set, "NC");
-- 
2.45.1


