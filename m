Return-Path: <linux-kernel+bounces-415864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484689D3D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2033B2DB75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE69F1BBBD8;
	Wed, 20 Nov 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KGrIHSs1"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8841D63DC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111792; cv=none; b=tAXeguqd0wGXNZcioau8jTiR81qmiBuCRFyPwYXkCvsOwnSN6wjz4EyXY+NY4NY+6pBTl8yU92Df3TA+yEzBKp+GIBoLNNyXP3LF87Icb04x9pMnvl56XjACTPlB2mzFxN4cqF85yztgBBlVZiOE4/q4NzbEcuUSD71ZU11xLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111792; c=relaxed/simple;
	bh=kquTSCG6ldl8Jsr1Yyg5zz3XR4Ry7zAqV4fXZmtCDZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOLxeqsxCQSgpBNd9eveBlkH8l0gruJ8dDfLaoR4GpA5NzK8IfbCjr6zO8D8gYJoHlNfX61gQbCbzeboXQvB+Ut1m4g88r7Vd9pNtmr95aWxLlJL7ViFOOsSZHljYP7Xlrfk7440EaKxK3GAmi8VaAhluYmSNsSk+JkgaGHs0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KGrIHSs1; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e467c3996so1707740b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1732111791; x=1732716591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HiZ5B1+Hi9dts06uRmUFzh40lIglAJLzfcQl+niZxQ=;
        b=KGrIHSs10UWEJLj+4M947ZtToYfZ2mNyNVnVrbpguN35/vbFXGsimmaksaPT14Akh+
         qBiVn08cW+KglO8QbNWePjteMC1RQK4NtDLi2fsPuw/DACM+6H4JelpU51pzHKTxKffU
         gohT0xzD6iDb0YHJN0JH9XV2ARGwpRnkCQDrrqikspsXStt9EJVJ0KsG7S9isJUsO0Wu
         TQTST8GeOhLjrNM+VBJrMXNVlirptOWydm/8fge5jTyeZz4MXsGj9yHbfrsdslSE2u7g
         YmljSwO8fSRcpB+IIGjxv/+RcWKNFFXMKMcUF32071elCTywNXUeVczi/k3FvQmfzDYX
         8jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732111791; x=1732716591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HiZ5B1+Hi9dts06uRmUFzh40lIglAJLzfcQl+niZxQ=;
        b=Y9pe73WKVg2tZ6Q926upyBUS/zoR+MQe+/S3ZwAqZao1VA2/a6MitdtkZ8uhp3WvFf
         Q1TEJj+eidoyUfl2hU7p8kRvbvOp1Q1sLvR2J346dhNRZkiQk6HpVb7Saf9jiiUF5vuO
         d5QjYJ8txPLGEAKYMvO/gpdmy6RYBqodrfeDkInkEVnwEAJkQutaXyctPFZ9lS8+H9ka
         4WZ3jMG0YtsWll2dqJED1f0GQk01QzFwrgrX8ENVyZdPcxTWaSD6xwfFx4HdGSomuCn3
         utts0rVbBGOypjI8rJ/lHRmLfrIy4Y95xOjRNJogOz3OfMTjqZ42NChO9dINbowbLkt+
         hhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpkuuEhYUQGOeSpqfsCKWN5rqFdCu6mGsm9f8fMbziEiXnGsK/W2r+sjSg2JRP6qT4oyHxA6p/y88PGeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdxEmuZBX3cDEjGH6V75vq/XJbLYtYsasTwBLfcmET9Ai2f0M
	bsDhKSgFMkpDFnEJjbN+P8hy2NmoEjL/C1ZHL0uUoXGvh4qW4+ykQNhjla/iSvg=
X-Google-Smtp-Source: AGHT+IENrSz65ancGchI+RHAOkUIUZtI0x71mxt8UzBTQ5e4W/m5EYNF2C+k64+tvhVagvHee3ibxg==
X-Received: by 2002:a17:902:ccc6:b0:212:51ba:cbd3 with SMTP id d9443c01a7336-2126a3bc80bmr34655035ad.30.1732111790594;
        Wed, 20 Nov 2024 06:09:50 -0800 (PST)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f474fcsm92502505ad.213.2024.11.20.06.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:09:50 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Wed, 20 Nov 2024 22:09:33 +0800
Subject: [PATCH RFC v3 2/3] riscv: Add Svukte extension support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-dev-maxh-svukte-v3-v3-2-1e533d41ae15@sifive.com>
References: <20241120-dev-maxh-svukte-v3-v3-0-1e533d41ae15@sifive.com>
In-Reply-To: <20241120-dev-maxh-svukte-v3-v3-0-1e533d41ae15@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 Max Hsu <max.hsu@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=kquTSCG6ldl8Jsr1Yyg5zz3XR4Ry7zAqV4fXZmtCDZs=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBnPe2kCySnhiICdX2FOUve6ohMWBNinXyZuOSER
 TmwTRZU4NeJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCZz3tpAAKCRDSA/2dB3lA
 vQmxDACFDP3s/vWUFpUHlP87/uUPfleS9wQf2NhdzuRJWsDsduU2xxQhqEam/z0lAI0wqvR1DJl
 PyP3S/5v5NjRgpOwVC/NbwybscDQaz80y6p6BMOpwbpm+NON5pE8ZHEZz/sglp2wdMIYgSS+D9E
 ZlY4FYlnyJmU2EOuap5LE2mpW+YpKjIpD73bSULkLpIQpioRJY4B1ErwWLFPiqA3zwrpSMogbLR
 5n8HjWry7LU4vE2M0y1n/3AKkNhlG2kn7vAPqKcH9xA42vKCZUK8wOiVYjwJz6ZTf0tP0OFCgGL
 0cw/TDn1891BWiRDICzNaa1hfhGR/WuuJJsf/ANrmhyeWYQcHiP8dvGYUrEtQYJukfNrGqz8pvi
 vXq4W9bNG9oenwdz7/sa+HJ0Hn3FKLwWU6CBAq37WIti5aFXs+1HKpNaCF3ANZX72J5RZ30xDnR
 p5q264P1pYt8wQ9CzpTKFNXiln9VdNY1lRxY1wPxDOcYtUaM8Ufx3SLHKFrQ6hnUq8+nE=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD

Svukte extension introduce senvcfg.UKTE, hstatus.HUKTE.

This patch add CSR bit definition, and detects if Svukte ISA extension
is available, cpufeature will set the correspond bit field so the
svukte-qualified memory accesses are protected in a manner that is
timing-independent of the faulting virtual address.

Since hstatus.HU is not enabled by linux, enabling hstatus.HUKTE will
not be affective.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/include/asm/csr.h   | 2 ++
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index fe5d4eb9adea1d4e3065a4d6e2ff361a52aecc44..67ff78f7e480bcbfef04e58191ef85d5434f427e 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -126,6 +126,7 @@
 #define HSTATUS_VSXL		_AC(0x300000000, UL)
 #define HSTATUS_VSXL_SHIFT	32
 #endif
+#define HSTATUS_HUKTE		_AC(0x01000000, UL)
 #define HSTATUS_VTSR		_AC(0x00400000, UL)
 #define HSTATUS_VTW		_AC(0x00200000, UL)
 #define HSTATUS_VTVM		_AC(0x00100000, UL)
@@ -203,6 +204,7 @@
 #define ENVCFG_PMM_PMLEN_0		(_AC(0x0, ULL) << 32)
 #define ENVCFG_PMM_PMLEN_7		(_AC(0x2, ULL) << 32)
 #define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
+#define ENVCFG_UKTE			(_AC(1, UL) << 8)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
 #define ENVCFG_CBIE_SHIFT		4
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 08d2a5697466d07fe2319a2423f04657177db37f..98488d8ebf528ff5cd494ab753d91b77accd2488 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -98,6 +98,7 @@
 #define RISCV_ISA_EXT_SSNPM		89
 #define RISCV_ISA_EXT_ZABHA		90
 #define RISCV_ISA_EXT_ZICCRSE		91
+#define RISCV_ISA_EXT_SVUKTE		92
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index eb904ca64ad03565c6d521350f5e6b4c5cb9c6d9..a38e40477f0123eb7e80b096a38e0f956c9d4bc0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -389,6 +389,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_SUPERSET(svukte, RISCV_ISA_EXT_SVUKTE, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
 };
 
@@ -931,6 +932,10 @@ void __init riscv_user_isa_enable(void)
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
+
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SVUKTE))
+		current->thread.envcfg |= ENVCFG_UKTE;
+
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE

-- 
2.43.2


