Return-Path: <linux-kernel+bounces-266442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C393FFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1629CB2203C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065118D4AA;
	Mon, 29 Jul 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="addq9PRX"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96B18A95A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286813; cv=none; b=YWPWOHsh1CqgLlom4ZdvzRw2TtvshIAb0DlNtsLV4MothOIrhfOAQeC2uZCgkj+gVcdoL/1yfBVgvLKizyUDXz8T4kqBDnEK+EgW1DiSLgxmsVQkTCKS0a7NSAZAEocoJxMyg5erfanNYB2xfrVgKcWuk2BT8TRfH88WIGaXPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286813; c=relaxed/simple;
	bh=KLZOPxSIPFADWanc8+KTUi5BYPXEMMvuVPtNYrhJHTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+3BeJFbkqCKPWnEgjUpnuQbr40gfwhu6CH4XXcAy+vIfc5qhPquwyl+lcE9D3xZ3amMfFzdPRYp+mBrsF8IO6oJ9s1CBMr9NGB/tzltIbKddIfiEbhiU4jc5f5YRipMiZTJT/xX828ltkWEdcgnRxqMaNpLFz+X4qctJz9yIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=addq9PRX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc52394c92so30800495ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722286810; x=1722891610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRgJIV1cTDPBS5NKysD3spMfMdec84tFxkNVs2v3aFc=;
        b=addq9PRXwb2o24cxz527sikL3Tw3iVDClr+ZWHFyN5dAtPTZv5Wnzt56Tz3Mme1ZTm
         xoOCZKKFSy843E0CJ+QR5xRs+Wa4xjitshrfwjDMbn8XZC683Oi7D5iQnp3kKSNIfAPA
         eWnw546RtfJCJdb0mbTjtsJSfdjU41Ms9iVHlukC3zQzh4DiwMGmBKjBLOGtBJ1hQOTA
         vCWITPzHNQNqXZmDDncy6B63cNfsSjlFVoXOoP2+AiwgCL10z/+j2g2INIChSv2kAVmf
         V7hBUB9NATXX5j9WyicV+WWtzJ2D6rQO3kPxVUeAHUw1iPGZNMLZhv1XT+4rbks/TIGA
         CbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286810; x=1722891610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRgJIV1cTDPBS5NKysD3spMfMdec84tFxkNVs2v3aFc=;
        b=bZSJ5bD3bUmv86zt+O3II+heUFhJvB+pBvP7kNAGY7LY1d4DcxQzXvdUe75/eLqLdp
         ufE3ZzweHuUMFJS0lSOHuX28rQ0MD9TaflWdQ8ajjgwOWVMu+s6gUU/NyXmdkqM0YqX3
         bU2CdhFfpc2wtEKnHqX/2fYjxgeR6x+ie0OhT0Y+SPeYRsFl5n4fLKJZYDAiG3aDE5Jn
         AJ36plErOfSayhXotRuM71qLBI+o7Ahw16TwOFwkD15c+dU7iXTuTPz0pMu4Fpez7RXW
         KsE4LN44wi9+flUbG1acoqsFCDvnm/ho0+YKZ2nnSbFas3nBCkLIldzeMfKH2YPXw+dt
         ZTRA==
X-Forwarded-Encrypted: i=1; AJvYcCWWj04ELlMYs/vhHYwJEKUvtVSBxVxuSUaYv18gF81qn+2RnGqemAu0p/2pZsyqx+KglXoLcOO7I5fY3HRwWq4vVXA8lzY+mv1cSoMe
X-Gm-Message-State: AOJu0YxIh28ps6GuFlqajSy7CteM0QeZOzh9iHPLpKzYvB/NH4dRAHs5
	QH2M2hCJPtUO1nTVMSSZrmrP7gffV/IQiPtNASD1Xng7IlH3hZWaPHg/TXQX7xM=
X-Google-Smtp-Source: AGHT+IEqv2wM0QP/vtvMFjcXLVCXqZ3EczLUQnCDQX1jaxebQ0tOwZa5TBFWE47h/eDPqFkV6Vnecg==
X-Received: by 2002:a17:902:f811:b0:1fd:9b96:32f5 with SMTP id d9443c01a7336-1ff0483e1f2mr89994395ad.31.1722286810331;
        Mon, 29 Jul 2024 14:00:10 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f71d61sm87341745ad.225.2024.07.29.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:00:09 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jul 2024 14:00:02 -0700
Subject: [PATCH 1/2] riscv: Add license to fence.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-riscv_fence_license-v1-1-7d5648069640@rivosinc.com>
References: <20240729-riscv_fence_license-v1-0-7d5648069640@rivosinc.com>
In-Reply-To: <20240729-riscv_fence_license-v1-0-7d5648069640@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722286807; l=505;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=KLZOPxSIPFADWanc8+KTUi5BYPXEMMvuVPtNYrhJHTs=;
 b=KiHexqfK0b0CM+McxiebOkChmmVRLM0YTyR4PhvF580R72jwXt2SwLepwmfmi+ylEfie9cYp+
 nG/8+TCh3mnBD68DrSHQwWI08b7KxYE/vr+MDXqzMCfccxLca+W+EIB
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add a missing license to fence.h.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/fence.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index 6bcd80325dfc..182db7930edc 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef _ASM_RISCV_FENCE_H
 #define _ASM_RISCV_FENCE_H
 

-- 
2.44.0


