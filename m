Return-Path: <linux-kernel+bounces-261442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF5593B763
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FA9B24BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55C17109D;
	Wed, 24 Jul 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="J+Xhmu2r"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AD16F8F8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848457; cv=none; b=kkm13kexmNgig+hh7NsJS23/HL7y1O6uQUN8Y+mvgq7gt6h4IbIx3BW6F1wFwqpPQNEuQXw9wE9OWYl/l2NKlY2IM/+XfHVjttj0gxBPTCwSkpxojFXqa9xwsWV40xgUhkHqim78xPB/0eSGH0OwvXYldfeZ+hGuQztXskhxzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848457; c=relaxed/simple;
	bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2Wz7PxRixlz1SYxqQ9oHcLVJvpOv/Pggci62LkMLmF8oKPkINWxoaN+pNexPWVfkSXeC47bA8KdKlDYHg94LmOv21AgJMaDMgNghAXBoOX/VEiHETxrOB1QuS2pSzSN3xWo0LlMkOaBMNnU2pWLTtAqusfEKaQxbK1qeVlnh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=J+Xhmu2r; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7515437ff16so107600a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848456; x=1722453256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=J+Xhmu2rESwyyIJgQEJhWmOG3pzx9yHJ5ZYa/BZnQsfyIGoD+8wB/CRc9OJAQoXQEZ
         T6/Z/266b4cW2g7ph6ADSQaLBU+Bxhr+vg3fX5uOb+83iXeOsdEcoTeQA8si2WnQUwaU
         8iZKGmRfpOjpCR+hVC+PVY3UdAkBV5k0VTYpHFr/BdoxBMtRVOYVhd0GHRt94iNXC6Hn
         S2H/ZMacp2z2Eg/JpL0pCuOb9RGyg3HOlNgXKQW57Ss6zpL1NpqlP5/oMYD0Cv/DNg+K
         DmDXNC5MHy7ZDMGDPhgPwERf2Zeoud/L3SC43/Z6Pnid6n7i4ZFO9jH25H8MOhIXj1nj
         uD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848456; x=1722453256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=xBuo9u/SS9saEdS2cv27s2vIjlOLWe/idf4p8U7HLxFSudrCdcy20oEih0kOpxFo2/
         Vfj+mcozvtoAVG/G8Cnkdn1vnc0k72XnKZKni/va6ZltoWqGczrLptCaBiKH/9sfW8UW
         EJMMWvJEh87G5PhkM+03Q5uNuAGzq8c2lQ97azYwCSuqh/obFKnW/jAiFvjpc7PGl9Gn
         xLKNw2BI9WCj2AY6plBRvDI2AKPWezjA3sDxAyYStjsK5z632UWwMfv4ZrztBgOpONYG
         meFslHxR8u1hcDova3Sz6dVdopvG3zWWUbi/FzCju7ypZ6MJttTMpghuWSyr5hWCPgY0
         5Ltw==
X-Forwarded-Encrypted: i=1; AJvYcCWKnrB1dQwTh4055qq+a0jgh51wuqoiMkQ+QbvwyJR0OE7AUJYzeqI+2lBfnbi9bIcyI2XRgT4uLUTuPLJAYP/cy+ZkEMw4oiaiSTgp
X-Gm-Message-State: AOJu0YzFJbJVs5wE9umDywM+ffGVzWOeLWHVVlYgmdSoP1oRcu+Cqq49
	oSK8KNNxjveW/IxehAP+MRUqqwtVhfYxlYQnsJ3bUgUJ9cr8o8ID3m/oWtDzXgo=
X-Google-Smtp-Source: AGHT+IHM6DqXQtPEXppJ3aycA0czFjz3SvIwtqm0HVLAzyK2dKWOJoAUvM42Mr9lb2mEpm7qNAw14A==
X-Received: by 2002:a17:90b:4b08:b0:2c9:5a8b:ff7e with SMTP id 98e67ed59e1d1-2cf2382423emr637505a91.25.1721848455838;
        Wed, 24 Jul 2024 12:14:15 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:14:15 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 12:13:58 -0700
Subject: [PATCH v7 07/13] riscv: csr: Add CSR encodings for
 CSR_VXRM/CSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v7-7-b741910ada3e@rivosinc.com>
References: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=1045;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
 b=mFNQM462PKZEuSW3HptdZK6/CQsO67lOD5RsetDVD+WRlhwpK+vODv/EyhBnqV5liMBBS393P
 nw9B/WYHqviD1ErzwhdLGYADQyi6xtbrp6tRku2blFzOw6KqtMxtyIb
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 3eeb07d73065..c0a60c4ed911 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -300,9 +300,14 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
-#define VCSR_VXRM_MASK			3
-#define VCSR_VXRM_SHIFT			1
-#define VCSR_VXSAT_MASK			1
+/* xtheadvector symbolic CSR names */
+#define CSR_VXSAT		0x9
+#define CSR_VXRM		0xa
+
+/* xtheadvector CSR masks */
+#define CSR_VXRM_MASK		3
+#define CSR_VXRM_SHIFT		1
+#define CSR_VXSAT_MASK		1
 
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150

-- 
2.44.0


