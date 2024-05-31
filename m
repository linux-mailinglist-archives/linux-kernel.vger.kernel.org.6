Return-Path: <linux-kernel+bounces-196641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84778D5F35
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12DA1C21C89
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56CD1422DA;
	Fri, 31 May 2024 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md9JtWLb"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648741422DF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149858; cv=none; b=Ed8Hiciy1NPNgtgqeQ0uOU0UpSQ87ysBBKwnKNNq3kb+9CXjUyaOgQx5Af7LZUyGUwgGh22pWav6hGdfQpOKZk9a8jP0zbdsx87OST4WlH3BIBSkVpX8gXczNgyAunzQZ9m2dRuUoWRCC+dX1YHIevcaDd/bGrh5yHcAlwErqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149858; c=relaxed/simple;
	bh=NX8R36GS4x0+6QTiQ+GRyfausU+sRedhCbOOetHX69A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fvMAJdXFCn1Gqqmwx/ATV88kCzkK7juFQgLya6FB/ixGb4+HacRcOnbTX5b4iSF9/JtJe98bpwRd3F5bSI3+aFX/amp+LDfTfw0kPaYzw+h22KFwNjcRTaVB7T8IY7qr3zPw15ncsybIc4fx3fLNtynkMPwfnwxNYPg+bl9pUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md9JtWLb; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b9706c84e5so1090038eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717149855; x=1717754655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s940/bF+Rjt/1+PI1jPUWGPmA+YmQXsAS03jzjf6Uz0=;
        b=md9JtWLbSFfYUq+P/wZI3Kk60AXzadWb7bXguoGz8MYGq6H+0koA1ye3NBAvppE8nw
         hsku03Y+4ppg2V8pfb5Uc+3gpjkWhX7fhOflZFo6p6HkAIYqlERLp8lv5H1DvdtccJBT
         Ki0LxusLt55dM46vllQHnjpKENTqX8uWXyqGvHtIKKUQGjETSTcDuVLPTvkF9u0rgNrr
         lW0dexz8zfV+X2FjFsKycgvoWrZSueuMEpdOa/BAE/6CBatxlZ1Rr1J/MGZsZN67MOAQ
         lZmp6i23dNktKehV1uaQG50cRoh/g1V+sFxgIG0zOjXNnzwbB9ZnGHVwgZb6yTqslagY
         +2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717149855; x=1717754655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s940/bF+Rjt/1+PI1jPUWGPmA+YmQXsAS03jzjf6Uz0=;
        b=L4tJCUEwU3Vn4HUZAsCaqT55rCUZ9H/H+3TL0uly7K5z3FE4wN7dyp6B+PYQPClblt
         HmHLc6S5xgygDRG3AzTV8GvM7/W4e/CHomSoxaFjLZK7/WI8ug7PP88Ax7cfSMD/U4CJ
         WlLJbNKhYEG3xf1BuSwf/kNbcMHi3FXFOCDREK66aiRQg7EOMLpTz8wvbmH8JnA9HCVc
         neEj6TCj52kcbfwX2FeFktIRwOOn44zdXQVF/9FHepYEJrLLMWDbL0SVPDQi/dbOhyTA
         I6pH20I/Tx25+4ci4+WqRUkhGvVTM2PkyLBUVwrQ+/6SjvUVnRDbLwPEgoeMBIn5XOGE
         jwVA==
X-Forwarded-Encrypted: i=1; AJvYcCWWcBwE3dF9Xojg3W6gdF+gFelmePC/y/NTXP3eIhC9Yavf6/+dgs+v3iqUjlwbI6vrDnTBq3z55X027edGyiT/rYjbUdbmedYxD2qC
X-Gm-Message-State: AOJu0Yyk7xu6KnlXO09zdzVtGk0WAGXrMaesc/Gq+nxk/WIApf3J6I/Y
	8GivB/NzN7c1RNoe/wXcgeGU62I+TKNkyGLz0OL/TaDv2IAvxSGU
X-Google-Smtp-Source: AGHT+IEw8GHLkK3sXjfVt8Htx/1lJA4GJtSDwqUWaE2zFfPxDCJUxl3XrtzTQcSBHNtd2tXrRfEEzg==
X-Received: by 2002:a05:6359:45a3:b0:18d:8f73:348 with SMTP id e5c5f4694b2df-19b484c7115mr186018755d.0.1717149855279;
        Fri, 31 May 2024 03:04:15 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:80c9:183c::26a:4f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c355ec306fsm1002339a12.54.2024.05.31.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:04:14 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	Eric Chan <ericchancf@google.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: Implement ioremap_wc/wt
Date: Fri, 31 May 2024 18:04:06 +0800
Message-Id: <20240531100407.282-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

Currently on RISC-V, ioremap_wc/wt uses the default ioremap
implementation, which maps the memory as strongly-ordered non-cacheable
IO memory on systems with Svpbmt.

To improve performance, map the memory as weakly-ordered non-cacheable
normal memory.

Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 arch/riscv/include/asm/io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1c5c641075d2..582503e0f508 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -133,6 +133,14 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
 #endif
 
+#ifdef CONFIG_MMU
+#define ioremap_wc(addr, size) \
+	ioremap_prot((addr), (size), \
+		     (_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_NOCACHE)
+
+#define ioremap_wt ioremap_wc
+#endif
+
 #include <asm-generic/io.h>
 
 #ifdef CONFIG_MMU
-- 
2.34.1


