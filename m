Return-Path: <linux-kernel+bounces-207632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20C9019F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FDE1C20FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8183CF65;
	Mon, 10 Jun 2024 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CwyKWGpa"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89826101CA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994751; cv=none; b=lqoCUDUC60aEJ5Wg41a49u5+Kze+uVUJwd2AgxKevZNnZPSDc8ffx1i5hMLeAdCX122USNwF4fecS0r6R3Rp6VZuu+amYDb+YWyt1hzVxkC1iPWQ8ED1LFojTIA9qzwvsqbCv45UAdaq5g5by6ymYtqF0mGWnYzrSHx/lwOqdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994751; c=relaxed/simple;
	bh=YRbwjAEMooOC1Wqfne0YGBAOlvdWm2exzND7IqGSDDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4RYYaSPYMNnj5Clj8KPMXiKplauXHQChktrXLKrdo+toTy/VBdc99pGVVJu/f4p9YG06PNwRCA+ZPsHRXauY9x9OInYdoImGdzOE8/VvnTuttRNCKnvrO7VfOcZYNT1bU3hyMwoUjx8qz981Kln1PgvRZ7vvc8BrI8S9hVKB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CwyKWGpa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f7028196f2so6326735ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994750; x=1718599550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HBSOfNpcERRo+IfFfSUzbZmQ8OANKCSab29OA8NgQg=;
        b=CwyKWGpaCevBq3LY6tPDvBUN6kbs1o2VRTRwceAAm9mvNClJqwMtBmtWZz0txBVJUd
         qLtmK5PTEDH21Wvapy8rZY+drGlU55GApyVOaik+F6FNoLdEGzEGsEEEQ2i01WOxxjaf
         h11qh1D+q5BzAKeHpuVi+3aJqgIXxKXv4F5INwKUP1bOr04PdG1n9ivVXn54Le0SfyHI
         Mrm9V4JnivwIo7+wjobPSRa/V9RaPi3w2UM1Bj89P1+8mu6TdvglKYTifomalRIcexIv
         ASAIg8QZdXIhqFngYcBo9uEXWs4uRz9jL3iG5h5Fm4yLU65sZhFYdClhOyGzHNXAnazV
         s5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994750; x=1718599550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HBSOfNpcERRo+IfFfSUzbZmQ8OANKCSab29OA8NgQg=;
        b=XmWOgxHXkdpiby1q5VBUy7ASAaQWBo51LH5rAmUD0SoRzSCycBPurLVPw02S0xvrYN
         U9haDYG3sb7Og3WRQFsUvIj5CH5Z8hHCWD92GxP9jprrvt9z+2USpLXB8wh34cPqH6CU
         nUpIoYdZ0lpAVBHLBkomWUGqsGW4OSxse+HCGYklc7g6K+guB1/qKYbkX0bkJh3MuATw
         P3/KjIG1z8ht3vEToW5XHAF+hHCqKfahk5NGNSC/pWvfwsTykcH0EtanWCatvOTw0bLX
         O9M6m7WfK32TcVxvj1K3yBYy9NRXZKHlVGA1IAc6+UZU0GlFaZvHo2fizdAmfH9zd431
         /D0w==
X-Forwarded-Encrypted: i=1; AJvYcCVfjNcDQHNc1OzXiyoImtp9YPdYZNkWh3cPQFKZ4tTSjxDw4+u6l1lX7hFfxtnQJFhUsO/ROiqWsR7QAMLm/x+L+QXeDgPVc4Y2yDen
X-Gm-Message-State: AOJu0Yz3VQsWrXXhq1RfL57oudroKc0oJwNKsz3GrtokgTBNjtXMft1b
	5Erp55IccbtkvYMaO7CaMziiC4G9+PFs3sN3ya+XhwDoliCTMETPlWd82RTrcVU=
X-Google-Smtp-Source: AGHT+IFokGlovp2IkNoCK67wcj7YPJ3AH98Sp2QxsCqsaBawuDAm3x3I7E9iE5QWcbZgk110G1+MgQ==
X-Received: by 2002:a17:902:d4c3:b0:1f6:326b:cde0 with SMTP id d9443c01a7336-1f6d02f98ebmr107670705ad.31.1717994749999;
        Sun, 09 Jun 2024 21:45:49 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76ce8asm73124095ad.77.2024.06.09.21.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:45:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:45:12 -0700
Subject: [PATCH 07/13] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-xtheadvector-v1-7-3fe591d7f109@rivosinc.com>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
In-Reply-To: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994732; l=706;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=YRbwjAEMooOC1Wqfne0YGBAOlvdWm2exzND7IqGSDDM=;
 b=99wn/niA0cQScW2RZHdAYs/G3d+6fucqbAlEziDCOsNFlslIJ1kTJdSJRonbVlLwckEyjZYSv
 oLpqsYahmVoCslt9Y6Si3QOPyFQR5kdwcQuHfdy3fJPz51XrWIzyAzd
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 18e178d83401..9086639a3dde 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -220,6 +220,8 @@
 #define VCSR_VXRM_MASK			3
 #define VCSR_VXRM_SHIFT			1
 #define VCSR_VXSAT_MASK			1
+#define VCSR_VXSAT			0x9
+#define VCSR_VXRM			0xa
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00

-- 
2.44.0


