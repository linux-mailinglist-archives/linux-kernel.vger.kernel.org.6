Return-Path: <linux-kernel+bounces-517181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A096A37D68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8FC7A3ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F31ADFEB;
	Mon, 17 Feb 2025 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P7a1/1M1"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160301AAE08
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781917; cv=none; b=ERbiNoyqTVDVg9prJRIXl6quUM0TGLe6S5VLim6TPE9DOMXJT5gUSUqIv5N8de0tfo//SHRpzXwpR++3dNFyCsML/EIJjC7j5OT9sTa7eMjTXlAxceG9JQQvLuHYDjcE099qSe255yclLHfwN3k4RfAG56CkaLl7iSqhxN4Gi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781917; c=relaxed/simple;
	bh=TsyxZ34/uk8jH+7pi9gkNKFwME87qom8rRAB+x7I9U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/SaqRE+nOHyOc5q5xM49zXvFNU3bIkp048stzcPghBk6fI423kbY6LXwdUp2Qxf8trRaZOegXswpfM3nQodQqdIs9j5VMCeAyax1ElRTdibMhCPl4K7AzMmUEUSnZ3TDBfMXH9c7pQffX79OovhDF9c6ldvHoMfJ449FPPLj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P7a1/1M1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so4454594f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739781913; x=1740386713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPqGeqDxSe+aOIAEww9m1M//H8GA90MJiJy6W/MxoXw=;
        b=P7a1/1M1pYDRLeKVNPY0ep4MJaHT2Jhcs8cF7xKDEaPngx4NcBtJk4h9uv8HlC9qVc
         S6vHpkjQrouh/7iELXVSacCqyRbmRlWBpBC/7z+oQuTcS5zrAufDChgovbV+AhZ7Wk81
         IKmi36GG4iWtQxsN708WH4RSlQGKiQ9XhcQnA3+95ANm9CtOlqTKoQHeyVNQOC2ZVVrv
         1ZqevJCTwgYCUQ+j1JVEewKVVr7dEkDhGZa44yBcSZwJBaGjC89Kyzg974EmymOTRMfS
         zSUXrjlg8O5v03KqwMdig2MkBVNUxg/HSZvCezaa8H0Q2Z2iGxO1NlCELmdmSEO3lq2y
         mBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739781913; x=1740386713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPqGeqDxSe+aOIAEww9m1M//H8GA90MJiJy6W/MxoXw=;
        b=NcEQWnqLz2kGn6csZUBx2HCAHmIKJwYYp4+HEoZ336u25SnsrVXRXL4MDxWNbOBvPX
         LX59sH1pkNOEPaUXK8Kz8hiAPBQtd0ZYaX3cmmINIkKeTyg6qD0ySmJFeLPbEWTAoap6
         OTnWlcd6fcYqURwTLVGAkXGbKAtyRHkr44Um8nvhxJY2oW/274vb6t/R35OGntgSwvxX
         GrFsBo+xktMxXXWzUxjuEiNDCiP3m5mshVdm09iz3tgBiBDqXKrWGK+9vH1lGLHaOFa/
         B7egtyPimu61btGZMaKWUBFExTvwNqPFqVe8xKbMC6L1UPiI2ELU0HSDrVubWYl+zQtt
         um7g==
X-Forwarded-Encrypted: i=1; AJvYcCUxCBP06kxnbtt0AYZRrlV1foYwn7ifC9UUSjTXPDZhvHK4xcIHaiCG0ltMPnP/7nA4g9298vA1br/o9bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+86g6hntokkGoZvyImKpsU7FS0f7X8g0IDDIO+zHxouVaqm2
	dNlzPz3oMauc43+iYRtY66dOrczP0VFXCGurr1vcoqlLFp/uOf2w7o5TYa7R3JU=
X-Gm-Gg: ASbGncuJVJLXdCdwkRkVu8Ry8+UdHF6oQYboOj8TwDMnUH1XL2PsSxzgezi7xl+KFwt
	l2CJYw/iisO3KoxzdwObGV7EPJ4eG6yUUGIquaDY7A5gr19UC+45PqvRQzjyrE2f2/07X0Kz3EF
	1GwKRY4qsLtgDToj1rwP01L89gJ9ltzFAvAadDJd9ur+TkIN/YckoPXG5SBEhfUwKlk2a8I0xLd
	5EGp9ChwCnfA5MKilDcbr6jpQkAFlIAs4rjPBfSI7eEBeKLLOG8/4byZVnf7iLyW62sTYvNgUTN
	dl0=
X-Google-Smtp-Source: AGHT+IFw2SQlG3mEiHsZKLXfCIe42+z2FtTbwXKzNb64tTScHuV6pXuwf02llElP/bUJfKsa7cfpqA==
X-Received: by 2002:a5d:648b:0:b0:38f:31fe:6d12 with SMTP id ffacd0b85a97d-38f33f295f7mr8268862f8f.19.1739781913174;
        Mon, 17 Feb 2025 00:45:13 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccdccsm11661079f8f.24.2025.02.17.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:45:12 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cleger@rivosinc.com
Subject: [PATCH 4/5] riscv: KVM: Fix SBI TIME error generation
Date: Mon, 17 Feb 2025 09:45:11 +0100
Message-ID: <20250217084506.18763-11-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217084506.18763-7-ajones@ventanamicro.com>
References: <20250217084506.18763-7-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an invalid function ID of an SBI extension is used we should
return not-supported, not invalid-param.

Fixes: 5f862df5585c ("RISC-V: KVM: Add v0.1 replacement SBI extensions defined in v0.2")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_sbi_replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 74e3a38c6a29..5fbf3f94f1e8 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -21,7 +21,7 @@ static int kvm_sbi_ext_time_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	u64 next_cycle;
 
 	if (cp->a6 != SBI_EXT_TIME_SET_TIMER) {
-		retdata->err_val = SBI_ERR_INVALID_PARAM;
+		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 		return 0;
 	}
 
-- 
2.48.1


