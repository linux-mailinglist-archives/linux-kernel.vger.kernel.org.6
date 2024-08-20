Return-Path: <linux-kernel+bounces-294240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD665958B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CC2B21B75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77CC1946B4;
	Tue, 20 Aug 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lRXLgSCF"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3719412E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167481; cv=none; b=h2VDKZqbV2Kks6QSSRNceVPuHlMlGdnwiQzGLNbJvAZUytwx7AJ2OPydz3L7mSgx1thRPbnYmd1Mia52vp1Bo2gUcVTi4PaClGm4fpWTj282f2pGrOKpasCqDrjeDGctTM4btX5K36lTrAf+8WPFov5ENeAv+L4IrxE54QNyrZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167481; c=relaxed/simple;
	bh=2rc8FU9M+fSW+QkKpagTjuE9uoduYcxat2+eo3FYBq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fImxHklPR6oKIkTcCvHYjw98vits3lgLVhz7ZR3uYaEDvhPA4QthMmez4vANCSYWok/tNZ7u2ir+GPEXPwQIe4yPKzTED9MEexEvNjp7PESI3nvIjb+7IJ8h9IIQOfpgB77hfQA3HtCzf1MZxdwHYuGjasvCeEj5H9sZl058KXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lRXLgSCF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso3393978a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724167479; x=1724772279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcWMRJ0Y65fLMG5U9Pko1FotKijofEtRgUtr9N2ekns=;
        b=lRXLgSCFkVpYU5kVoYMWnzwyodepKebc5VKCtoyHZnaxDhkVBOjQp9TiDFr3gcNo1X
         Lbnvvv3Pw5lG//OG4+70k++UQis0Y7nrJoOj44i+CCOC7aBv0A8EXgMQzWKW44sD5NS1
         VSTRQN4/RMQeLrXb+fpxmEvzUCqtYgzb7dWT2WIC22o+F7kkH1fFovXJ/obrtkj+fGkn
         Azv/AB17QAs6WRgpTKRzFUW+/zMqj1jdP+xMkwMsJ67z6mF/oriQybqxal9PXyS+6qbt
         icAo6uSt4Eq74vmSsw/zW0G+CcbqigK+Rxja3+wWKWkbZxpGsiDy4NnISvjfMPxSyGv6
         3tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167479; x=1724772279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcWMRJ0Y65fLMG5U9Pko1FotKijofEtRgUtr9N2ekns=;
        b=DCg1OAW82bNotycO3+XD0gEf6CFrpOKONhdgwe9oTN82XrdfhabSSukvpLxhB66FbR
         pqASGDyxWNfSt0MXL3xmsELnQZinaO0kxEs1RUVF0tf6Cq3sLtRkfpcfrMflIt9F9P9F
         9zslS8Adq6eoiuA174MhbscgYLb162H1b1PSRQgzrnVsjcwhKIgncRWeq/vAbPtebU0o
         Ba1gqOjsp8Tc5eRRAJx/HLhd+OylEGkUoT6CSQi202SsvsPzMOaQQb9ky2Qc5grUiiFz
         KFGO6iv1ldtmprTD/kMb/6ug6u6D/yyzWx4w73tffFqQbJkcmqoSlLejNZhjMp8IIseP
         lNaA==
X-Forwarded-Encrypted: i=1; AJvYcCXU4jncdJ2QJu/c3mdpG3EwLFqshwsBZCKrZom0ooM3I1holCeqPm7T9YZSJ/USCvAnHeahat+JPMn7fm5/G7qBJkBuWrfVM8ssVJQT
X-Gm-Message-State: AOJu0YzQXuuNTE6irbihDHtsE8tfN3ltPzFYksYTpH/6zSlo0IsYYqAO
	rs+WLXAQAq9wPV72S6umzZdlyTrPglp8GJOvkm913ZI6xXqACm5qt2zbf2+fXcI=
X-Google-Smtp-Source: AGHT+IE+Km4Z4Uzp0Ic/89irlMkCcLxwcNYIyvvdXIzqeBq5tarmpBAMzPn+ZBc205ATxzcUSAGINA==
X-Received: by 2002:a17:90b:1086:b0:2cd:4100:ef17 with SMTP id 98e67ed59e1d1-2d3dfff6674mr13170727a91.31.1724167478774;
        Tue, 20 Aug 2024 08:24:38 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d40bea7cb3sm7258157a91.25.2024.08.20.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:24:38 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v9 2/6] RISC-V: Scalar unaligned access emulated on hotplug CPUs
Date: Tue, 20 Aug 2024 11:24:20 -0400
Message-ID: <20240820152424.1973078-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820152424.1973078-1-jesse@rivosinc.com>
References: <20240820152424.1973078-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check_unaligned_access_emulated() function should have been called
during CPU hotplug to ensure that if all CPUs had emulated unaligned
accesses, the new CPU also does.

This patch adds the call to check_unaligned_access_emulated() in
the hotplug path.

Fixes: 55e0bf49a0d0 ("RISC-V: Probe misaligned access speed in parallel")
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Cc: stable@vger.kernel.org
---
V5 -> V6:
 - New patch
V6 -> V7:
 - No changes
V7 -> V8:
 - Rebase onto fixes
V8 -> V9:
 - No changes
---
 arch/riscv/kernel/unaligned_access_speed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 160628a2116d..f3508cc54f91 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -191,6 +191,7 @@ static int riscv_online_cpu(unsigned int cpu)
 	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
 		goto exit;
 
+	check_unaligned_access_emulated(NULL);
 	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
 	if (!buf) {
 		pr_warn("Allocation failure, not measuring misaligned performance\n");
-- 
2.45.2


