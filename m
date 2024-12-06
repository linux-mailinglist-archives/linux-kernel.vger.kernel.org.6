Return-Path: <linux-kernel+bounces-435319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8D9E760F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2623816F8F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6332135CE;
	Fri,  6 Dec 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fYTtm78p"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A86E2063C3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502673; cv=none; b=GplzzuBJjqT+CMn/tzb7DgLiSq6T0JjNNfY4kSIQk//lr84X0kky+aRi8K0cT3r13I695WTfSOkGD9QOPH/0N8GrtZ6f9enBVQGqSjela+wuhXLgs3gU4JKtel4ACNPe5z/M+4gmQwkA0jtltLhzU3P8fK0q4eutBuLyhjtHpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502673; c=relaxed/simple;
	bh=6Fm4NeBHbaq1NbSykI3ME8M5+4HqsOC5thepiUGEagU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiMpbnUmAOGheDNVyUahmjqDUWpviNlMlAyHt07f0ShJ3Ju3xUw9bW5CBLNpLE2nJZzGbeRzvrUkJ9BqfV4rq8ah/xe+okuxYew8+M08HaR8Ej0f+WMTg7/+7/H7hhDhIzj6ex2wnmvvGjI7aj4mOX+MLwmexA9cWGiVsVLqYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fYTtm78p; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385deda28b3so1768666f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733502670; x=1734107470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rih2z+q1Taz5W9gbG28kyjqjg/d4/wnIMKspBHeQrDw=;
        b=fYTtm78pRQZ/otd2NCJKX44z9seiRxxPFi3/631LyOGnB2vnTWZpT9dNGff10/Vefu
         vYw/jC87yR0RnLZcf+UNPw+sKPgtuABWrRozQi8qdlYKgcLuPXpbv2Zdcjl6ItNKQqar
         wHPHFtkaPM/fGjT+yCJ/mSC0/mlURYINJ+pZZ1Px0pTJSL5IvYgN9nxvvEpuwJdMRcbA
         n7OHdpxG2Atw8rK0CXILu4j/1bLc8EPekG2V6Cg7L5cgojUSJvHSL/Em+zIlu/YxA6t3
         5+Q0JcVrs3LRyyO8ak5g0/w9EElw+M6OwnyvnrgdEPLL/HjqLvTsnRRr00L6wFm0qVy1
         wp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502670; x=1734107470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rih2z+q1Taz5W9gbG28kyjqjg/d4/wnIMKspBHeQrDw=;
        b=X7Dx8z5weinZJkDIXlqAo172GFsq6b7LHQtCQQqYsc0cXiurVds7XO+aE8Hwi/BJ3K
         gbyaiC4vQ663Z2U7yM+1Gg7pUTiHUCeDsU+d3ZTsY+U/4RPALWyXMp1srn0Lx7kzWI80
         zVFOdt3eNBCTArDrfmUcyTqeB/2uRotA0DMKf9FLh7vCMk4zYEx6zrEzabRhCDkug43a
         Hkoj30JtuHManoyBbIzdwK9XlQJmqK0xXKh0dasGkjB7iANa0vVCgqPfxS8cYm66BBr5
         7Ek374+caL823NEUISRJJYyivG8LS8CCS8NQ68bAM8E53Xwvdi4SDSe58oP4Dt3NIjjn
         RyYg==
X-Forwarded-Encrypted: i=1; AJvYcCWOYAG9lqKJSGuBAtdeOZFrhfL8fwK3QCKdQtZL4sSOp6TCgukPpOchAQymvtBqwTW7aDW6SxNOUreYwLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WoqlSCu3oDTTRI4zccDh74eYbyaY3DtxbhOb51mJ9MVryOpo
	UZrnk27n9sgM+u8m2jTMt5Bw+1NWw3jN7JKgp4b6y+BZo4QyK/63pIOFGVs3C3M=
X-Gm-Gg: ASbGncur7fXY/WGPrkYpe/pD5V/42X2e2N+Tqb2EOotIZHUy9bzw8+E0O+rDYb61Pf7
	DCnySskMhIOED7QbAs6awYfJMCgO00m10e/REtcEtp699xug39H8xSX3T/cXDFcbHA9y5aMMRZW
	LcvErY+TQFoSmSvWTsVENnpOPxVeW3L6EaD+u63ZBOKFREgjYOifXQgSEsSybmVY0IPoiFIah4b
	Uyxs9xMXWjic/wdEJP1lBY9vDOZb91mcM3TceAhISw6pZ6UID8=
X-Google-Smtp-Source: AGHT+IFZNS/vLYTFlhcpAiQaF2L19OGIDhrILZwk3DfUtSNiJLmw56KxCqGdAEFEOkAw7CQrELObyw==
X-Received: by 2002:a5d:64c3:0:b0:385:f7d2:7e29 with SMTP id ffacd0b85a97d-3862b35d19fmr3174954f8f.15.1733502669549;
        Fri, 06 Dec 2024 08:31:09 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862f02f5c3sm1151942f8f.65.2024.12.06.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:31:08 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>,
	Atish Patra <atishp@atishpatra.org>
Subject: [PATCH v3 1/4] riscv: add SBI SSE extension definitions
Date: Fri,  6 Dec 2024 17:30:57 +0100
Message-ID: <20241206163102.843505-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206163102.843505-1-cleger@rivosinc.com>
References: <20241206163102.843505-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add needed definitions for SBI Supervisor Software Events extension [1].
This extension enables the SBI to inject events into supervisor software
much like ARM SDEI.

[1] https://lists.riscv.org/g/tech-prs/message/515

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6c82318065cf..032dde350d40 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_SSE = 0x535345,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -401,6 +402,63 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
 
+enum sbi_ext_sse_fid {
+	SBI_SSE_EVENT_ATTR_READ = 0,
+	SBI_SSE_EVENT_ATTR_WRITE,
+	SBI_SSE_EVENT_REGISTER,
+	SBI_SSE_EVENT_UNREGISTER,
+	SBI_SSE_EVENT_ENABLE,
+	SBI_SSE_EVENT_DISABLE,
+	SBI_SSE_EVENT_COMPLETE,
+	SBI_SSE_EVENT_SIGNAL,
+	SBI_SSE_EVENT_HART_UNMASK,
+	SBI_SSE_EVENT_HART_MASK,
+};
+
+enum sbi_sse_state {
+	SBI_SSE_STATE_UNUSED     = 0,
+	SBI_SSE_STATE_REGISTERED = 1,
+	SBI_SSE_STATE_ENABLED    = 2,
+	SBI_SSE_STATE_RUNNING    = 3,
+};
+
+/* SBI SSE Event Attributes. */
+enum sbi_sse_attr_id {
+	SBI_SSE_ATTR_STATUS		= 0x00000000,
+	SBI_SSE_ATTR_PRIO		= 0x00000001,
+	SBI_SSE_ATTR_CONFIG		= 0x00000002,
+	SBI_SSE_ATTR_PREFERRED_HART	= 0x00000003,
+	SBI_SSE_ATTR_ENTRY_PC		= 0x00000004,
+	SBI_SSE_ATTR_ENTRY_ARG		= 0x00000005,
+	SBI_SSE_ATTR_INTERRUPTED_SEPC	= 0x00000006,
+	SBI_SSE_ATTR_INTERRUPTED_FLAGS	= 0x00000007,
+	SBI_SSE_ATTR_INTERRUPTED_A6	= 0x00000008,
+	SBI_SSE_ATTR_INTERRUPTED_A7	= 0x00000009,
+
+	SBI_SSE_ATTR_MAX		= 0x0000000A
+};
+
+#define SBI_SSE_ATTR_STATUS_STATE_OFFSET	0
+#define SBI_SSE_ATTR_STATUS_STATE_MASK		0x3
+#define SBI_SSE_ATTR_STATUS_PENDING_OFFSET	2
+#define SBI_SSE_ATTR_STATUS_INJECT_OFFSET	3
+
+#define SBI_SSE_ATTR_CONFIG_ONESHOT	(1 << 0)
+
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPP	(1 << 0)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPIE	(1 << 1)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPV	(1 << 2)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPVP	(1 << 3)
+
+#define SBI_SSE_EVENT_LOCAL_RAS		0x00000000
+#define SBI_SSE_EVENT_GLOBAL_RAS	0x00008000
+#define SBI_SSE_EVENT_LOCAL_PMU		0x00010000
+#define SBI_SSE_EVENT_LOCAL_SOFTWARE	0xffff0000
+#define SBI_SSE_EVENT_GLOBAL_SOFTWARE	0xffff8000
+
+#define SBI_SSE_EVENT_PLATFORM		(1 << 14)
+#define SBI_SSE_EVENT_GLOBAL		(1 << 15)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
@@ -418,6 +476,8 @@ enum sbi_ext_nacl_feature {
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
 #define SBI_ERR_NO_SHMEM	-9
+#define SBI_ERR_INVALID_STATE	-10
+#define SBI_ERR_BAD_RANGE	-11
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
@@ -504,6 +564,8 @@ static inline int sbi_err_map_linux_errno(int err)
 	case SBI_ERR_DENIED:
 		return -EPERM;
 	case SBI_ERR_INVALID_PARAM:
+	case SBI_ERR_BAD_RANGE:
+	case SBI_ERR_INVALID_STATE:
 		return -EINVAL;
 	case SBI_ERR_INVALID_ADDRESS:
 		return -EFAULT;
-- 
2.45.2


