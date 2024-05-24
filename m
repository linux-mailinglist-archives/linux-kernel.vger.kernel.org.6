Return-Path: <linux-kernel+bounces-188606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD948CE444
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310AC1F21BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEDF8627E;
	Fri, 24 May 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HEYO/aHD"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7486628
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546813; cv=none; b=mdV0SMtm77KZsRoHzBQR1o9oFKhC4Dl0Agjls4KtMbvV1NlkoJhnESVgfSBRHkfvVNDPIKmcXIlhos1aS2apQ0UZeounQXFsDdIdAals6+s7qRCkyxJlVTH/foGqGNWM0YCk/8cEvnyHasxAwlO2tEgNr2Q/JIaSzMGcFaO/pck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546813; c=relaxed/simple;
	bh=ebtVeCnssg8Ja7qxL27lGhEYvxpCJBglPrv0beQGGHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=frDvbnNezMepYU4zxwekOd3EVNE5ZhIP2RlVjmWwoMtebYUIMuOYSyblM/vu14qo5d2h8FSqoeD1YAzdLYXxCi1HejWTF75L5t4xXvd2DJqKnt3nPC7m709Cs6zQbKb81QJfuoyVm7jZCg6d3O3NKk6kaHHauOetZ7+pO9BHP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HEYO/aHD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bf5e0de37bso488674a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1716546811; x=1717151611; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jd1Ys62vbvg6Kc0O0Y86nMWaJ5oNcjAjjfmW/HddUAI=;
        b=HEYO/aHDDBm//TSFfLUIP0CayPLRVN+54SUQb0KlwHmM9tfw5MZv9MUyc/hVi+wn3Z
         h9uGrHsQ16nxbBqL4qpCG3ywRzdZLGHXxrm3O9FpLENIhY9gGfVW1flyXvI+LPJdnZUZ
         n2MFh9UyNhwWHfW6dCgoZ8K3XU9trCgZOjEzoHzNImq4PsC1EjR23aVb3pJK+G6BaX0x
         OXr0TAqKKuuz/qF6svZofpZKGx5MtW2K/42VgDwqK450De9G2Zeov12e5oS7Lch9/t2v
         NWYvzLZg5mtgKRcbyhc7S6FwPzZEY7qT4NK5wKcsNj459fYXUIlqlVDVfk8GRF4wuy/t
         hTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716546811; x=1717151611;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jd1Ys62vbvg6Kc0O0Y86nMWaJ5oNcjAjjfmW/HddUAI=;
        b=ozFO59joLTM1C/kGIF4veHf6CUXHnTj0juu6Iox8yQJGbKI1AQ9Fkv4XYr2Lu90Kml
         Y94T5m3D07zRhiPbeLe2cHLw68H6DizEZlRdE3437cdYTVoGFc7aO+fJvO1UJW6wPmTX
         GHfMeb2t0TwEfSTIcNWfX3gh4dkvBu0dwH3aqofA12Sd7aCCkcdhIBeAXD6echnWXSCT
         2RYv8Z9GDdBq+/dgAYmxAVfii1p40DGGnJBJgxCDlUL6+DGqbSJz79ewmGW3hWQYjVaK
         IIhuEd6AD5X77vJmZHoo50BbRtbnxQxgRm9QFz1cpDUnrLDsdnCujXNsj+xSB1wF7nVl
         7rYA==
X-Forwarded-Encrypted: i=1; AJvYcCUbGwzJQVX/GFmoNsHsoVTZM2242DihzFA0OVHwRggeUKrg/xQ/PCAa+chbGVwRIX9Cd+J1Oo90ciiD+o5JPx24EhGGF8rZddSsGN9c
X-Gm-Message-State: AOJu0Yy45HqA54Y7CZDLwbbpqEEIjS8MusbbsA4fXYfAsOwRGLZ9DlKK
	mQB/oMZNO0iMHEh0QuTpLfG+zpzFw+FrUsaMWW/Jfg0NsZP1AgCnOsmxzLCb8ho=
X-Google-Smtp-Source: AGHT+IEqHFEgIIblN+tGvoPCOSPByLGwZDHSVVvoF8yH7h0Gq/GADB1ishTF2VIIM9YemQrEgoARmQ==
X-Received: by 2002:a17:90a:db54:b0:2be:d1:e7e1 with SMTP id 98e67ed59e1d1-2bf5e173c71mr1678283a91.10.1716546811417;
        Fri, 24 May 2024 03:33:31 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c756996sm10936625ad.8.2024.05.24.03.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:33:31 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 3/5] RISC-V: KVM: Add Svadu Extension Support for Guest/VM
Date: Fri, 24 May 2024 18:33:03 +0800
Message-Id: <20240524103307.2684-4-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240524103307.2684-1-yongxuan.wang@sifive.com>
References: <20240524103307.2684-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We extend the KVM ISA extension ONE_REG interface to allow VMM tools to
detect and enable Svadu extension for Guest/VM. The ADUE bit in henvcfg
is cleared by default for backward-compatibility.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index a59a8448deea..bcf99264560d 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -167,6 +167,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZFA,
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
+	KVM_RISCV_ISA_EXT_SVADU,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 994adc26db4b..4166665e215d 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -37,6 +37,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(SMSTATEEN),
 	KVM_ISA_EXT_ARR(SSAIA),
 	KVM_ISA_EXT_ARR(SSTC),
+	KVM_ISA_EXT_ARR(SVADU),
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVNAPOT),
 	KVM_ISA_EXT_ARR(SVPBMT),
-- 
2.17.1


