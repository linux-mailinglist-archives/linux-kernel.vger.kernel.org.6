Return-Path: <linux-kernel+bounces-256777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A2937019
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6496F1C21C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258D7C6DF;
	Thu, 18 Jul 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YiQiKeiU"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BF3D575
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338216; cv=none; b=cOWSZQbcP+YibFvoDAjRGpKP7MpzQqv2n8X6TiVhNwfCG+s3qKfzJEKpCULZVayqwt0fLfrxWXQCouQZzctoxwVQd7xTrtFINuSlNqUVtxkWb/zCpQ1ZL/scOlxkR+tPS8opTF4BDxhlWU38isGmHUCCOiBqssCk2cUpLJM9wrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338216; c=relaxed/simple;
	bh=Pl7/r7DnhfzLPc3Gn6W/1F678cOmERZZJgBf+9liqFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKmMOcsk66BMyeb6AuSKXC+JXP529vmhgvpNeYvXyBkDGtt6mq0DdpP+qPNeF9TsUQZyKpjQr3woRwvIP9B6EJq7m6GEAebzVJH0ipfG3/gyrdub0KyOYFJcZtkhPlF2FkMkh5ZUMOtLwQmx8ZsW91UOe7RaEge3bbJUWNtcJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YiQiKeiU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc49c1f3e5so12423775ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721338214; x=1721943014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQATAomh3oMordhqCE1xgMTp4P8G2Bzv2s8BgrxXwdg=;
        b=YiQiKeiUlckJn9QuLOJExRf5sy0Xq67gKCJccNTD1EWf01VJ33c+IGlplUxrYm0dSU
         kL4mNqO6MrAMI+wHEkqtXNfEUMUohkjIaM+EVnWrvOytpGeWDPFCA3U5Sb36+QpTxhWr
         Z6TLkfE85PHlpfB8ENqUJe6sNxWEViLzsOeMW5vMV2DdSH2KUSjGz7zIfxyYXg+Mf9rS
         jmIBsUgH5dvhfyoGEiEQni7hEWl9gHdjNGZy5CfturoXOSY6HA6Sx+dlzXwGXUbMwpaP
         gfvSLG/k+uARrTBsBo2F9TYTAIId2jnUbEqj1ugz3pfU1AezF0EZney1GP89/LYZyfXg
         EiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721338214; x=1721943014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQATAomh3oMordhqCE1xgMTp4P8G2Bzv2s8BgrxXwdg=;
        b=cJ/V2xrLE8CSDD8kdVpGY86Lb2qmeKcBsXmxp5ldOy7M3rG2QVa3N5gMpgxf11sGB0
         WC6z19+Gr9y9gz6VpSVDfJ0LXdw+ylId8EhhHvn3lnvskfXR/RoborcbEQEloS4CG9ht
         r9M9zyNTzpP9/XXBUmwbG0VuV15Qh8vp063QptCICvWj+JoHnbf5Cc4Pz/VKQBDjuUJ1
         ijkgTKGIYH0SyajaKUjODWWYM5/r3pswlmXko0ImVUq6pdobM2YUCtnmgWNz36zTk7QC
         2uVxGCJMgxaUtZrRKwhTx24ahjHZWGvnlA2TVWI7lIxt+2/FHL6HeNl2+Um4yaEoZ+pJ
         UTnw==
X-Forwarded-Encrypted: i=1; AJvYcCVdmYJRWYGEZeUM+gPiXLB4BqqlmTHhbtE+OesbgrF9NLDMLDwNISLoD9Lq7Lc+kdoW8/jnEn2P4E0XX6sFk6W/c8S5C4DKolGlWypd
X-Gm-Message-State: AOJu0YxzH2S5FGQBDsyA18oDDsZsEFQQtL+eLLznvJ8xW8WQTpP0U5NT
	qWdjt2+3AaXKH8mKScWhjvKUSGjHJJDuHh2KnfL1uvMssJd7zcKkZxf9JNpJdhk=
X-Google-Smtp-Source: AGHT+IHD6wgOvrlgEKckIcPuHnHz5I62mcvWorh7TX0JSsIO8SzWHfMN3uJvQG/y2O99WXw9rRA3KA==
X-Received: by 2002:a17:903:32c1:b0:1fc:3600:5ce7 with SMTP id d9443c01a7336-1fc4e134b59mr58715475ad.17.1721338214259;
        Thu, 18 Jul 2024 14:30:14 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d1a18dsm231735ad.207.2024.07.18.14.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 14:30:13 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor@kernel.org>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: cpufeature: Do not drop Linux-internal extensions
Date: Thu, 18 Jul 2024 14:29:59 -0700
Message-ID: <20240718213011.2600150-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux-internal Xlinuxenvcfg ISA extension is omitted from the
riscv_isa_ext array because it has no DT binding and should not appear
in /proc/cpuinfo. The logic added in commit 625034abd52a ("riscv: add
ISA extensions validation callback") assumes all extensions are included
in riscv_isa_ext, and so riscv_resolve_isa() wrongly drops Xlinuxenvcfg
from the final ISA string. Instead, accept such Linux-internal ISA
extensions as if they have no validation callback.

Fixes: 625034abd52a ("riscv: add ISA extensions validation callback")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/cpufeature.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 0366dc3baf33..dd25677d60de 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -457,28 +457,26 @@ static void __init riscv_resolve_isa(unsigned long *source_isa,
 		bitmap_copy(prev_resolved_isa, resolved_isa, RISCV_ISA_EXT_MAX);
 		for_each_set_bit(bit, source_isa, RISCV_ISA_EXT_MAX) {
 			ext = riscv_get_isa_ext_data(bit);
-			if (!ext)
-				continue;
 
-			if (ext->validate) {
+			if (ext && ext->validate) {
 				ret = ext->validate(ext, resolved_isa);
 				if (ret == -EPROBE_DEFER) {
 					loop = true;
 					continue;
 				} else if (ret) {
 					/* Disable the extension entirely */
-					clear_bit(ext->id, source_isa);
+					clear_bit(bit, source_isa);
 					continue;
 				}
 			}
 
-			set_bit(ext->id, resolved_isa);
+			set_bit(bit, resolved_isa);
 			/* No need to keep it in source isa now that it is enabled */
-			clear_bit(ext->id, source_isa);
+			clear_bit(bit, source_isa);
 
 			/* Single letter extensions get set in hwcap */
-			if (ext->id < RISCV_ISA_EXT_BASE)
-				*this_hwcap |= isa2hwcap[ext->id];
+			if (bit < RISCV_ISA_EXT_BASE)
+				*this_hwcap |= isa2hwcap[bit];
 		}
 	} while (loop && memcmp(prev_resolved_isa, resolved_isa, sizeof(prev_resolved_isa)));
 }
-- 
2.45.1


