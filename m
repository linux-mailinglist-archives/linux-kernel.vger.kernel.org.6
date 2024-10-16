Return-Path: <linux-kernel+bounces-367610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209AE9A046D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2131C24A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0431FCC6E;
	Wed, 16 Oct 2024 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d6V1vFxc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1F1F80C7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067852; cv=none; b=ueh/FVD8ND+e/bZ1TmVZYxEDWuPfPVu2J1EYH2cwpfYH4pf+ch3ZQ09DbBuQyut11lxZWHA4qY8rp8XRSRVVHyTMMrcSIx4f5Mxq0orMx7qD/u+gS2RhhbyGlsb90G8LGZKWb5lPC3Pese91hrR1buOt9dQSKx9u/vzW1o/Yl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067852; c=relaxed/simple;
	bh=ELkP+/LlvaLc+XLPJhx3hY+pNjpVHD4I9RrhF1TIZYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMI2gcw0XGQSC9Ylh0v7tTYwZiq/imABTFS8LbqrAiyq2wkWofTma3KLyscVE7F1WXiiZ9p/rQjUurEbN3rg00oOCrebP72Gi5BoH1OfrvUfEnc0tG06pkYE+0t3bK6XSiLhEYQzhjQFkvK8q+aNfGSXhP+jM6yZTX9JCn/zW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d6V1vFxc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4305413aec9so60661415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729067849; x=1729672649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jJdJXmZIFUypkGDe9/4mfd3DKdJwjPw93ZM7h9RdKg=;
        b=d6V1vFxcP538ogDKAAHC4xvcXZRQXTQvBNCbXNBn/b4/fStwl6so3RghLXkRFjVvfi
         23QtqR5py/tqNhgvi44yU59YDUc8xTJOvtcilMKDEobJCHXbnvGzfMQQIuzytpwtjnpZ
         OKMtpHxFoJLAgLQ98kvcr/4fmo468qDj4YS9JPNXi9RxWzfKCtCxG07F80k+L59c++V5
         XYC68xCIXR00yE7NT/R49+PP23Y47n34avGf5wI7Xk6HqgFuJziKaDjia/+hPQHt56CB
         Zdqn80r+YSsPSQBmVy+O21XYxzzTZ+uvwwvXobH3dtxcSN+V3ds1A0DBeoFPmNp177Pe
         ZqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067849; x=1729672649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jJdJXmZIFUypkGDe9/4mfd3DKdJwjPw93ZM7h9RdKg=;
        b=XWKAubLbwB5s/g8MZ+wrQ//B03DVDajJP/VOPhYzf1YJkPyaep6pA6jCBs1y7A9hLs
         Afr9knUEmRM4OX1gcGuH8Y+5W4UCnYT8IJXuuOLFUCE2GeC8vFwdstL9AtBOgLujvlm3
         Bljc1LB2UT25oDkLV0bGYSclogCs0Zsl/Gols/wqdaSyijp4IkwDw+ye00jquQcGaYiP
         Wk5CGzTYLCKbpxysvkgVkqFJl3aQie4UoSRuGbgoxtdhHvLfmkDYBBkdfpqgyuPIirzx
         LV470HnIP0iwrUeeAycrqNbUhpuK7bdpwbBjyhSpZLBi9gD1h//R7zZytmRiYwrpuFJN
         VJTw==
X-Forwarded-Encrypted: i=1; AJvYcCWWbWCJmM28/UUWbpYyWpjzv9+wvFmgaC4rLVwH8EXPhrF4D8YK5HS+0RDCOxzrZImdGuSKkMBBHfzq9sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/mS0w7zXW3LaIu6cMsNvzBH43aF6PQ6T7z+MtR2Tf53O6X8T
	VnPShDH438H8GPZwCh77fPUdaoci8UQ4WRyxmh0n2HWkvDtWT1YDe+6y/qjKjmo=
X-Google-Smtp-Source: AGHT+IFp3TkzbiKrwAorGoZodCtXXr7F5FcNaRIdRFI7+3ysQVBFKjSKd4I+hM6P7+iGyX8KPTwG+g==
X-Received: by 2002:a05:600c:1c98:b0:431:150e:4e8d with SMTP id 5b1f17b1804b1-4314a31da99mr27011475e9.21.1729067848919;
        Wed, 16 Oct 2024 01:37:28 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b1e9esm42168205e9.37.2024.10.16.01.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:37:28 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>,
	Roman Artemev <roman.artemev@syntacore.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] riscv: vdso: Prevent the compiler from inserting calls to memset()
Date: Wed, 16 Oct 2024 10:36:24 +0200
Message-Id: <20241016083625.136311-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016083625.136311-1-alexghiti@rivosinc.com>
References: <20241016083625.136311-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler is smart enough to insert a call to memset() in
riscv_vdso_get_cpus(), which generates a dynamic relocation.

So prevent this by using -fno-builtin option.

Fixes: e2c0cdfba7f6 ("RISC-V: User-facing API")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 960feb1526ca..3f1c4b2d0b06 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -fno-builtin
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
-- 
2.39.2


