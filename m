Return-Path: <linux-kernel+bounces-276984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC94949AC1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD711B220E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA06F176AC1;
	Tue,  6 Aug 2024 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JFiLmT9F"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C92176240
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981696; cv=none; b=K9SHZIt44ZDB8dOZ6JbSvJOdhRJc8+PliiNjZroIwvfiY0/a1sffo/pVaut6GCe7dTU1xbn4lImIKweoOPspIe5+lNlowrSgl41Fotqj9uInOT+aA1F4IWk5mXpAz+SU6eY04vkJJnUtKyUAz8B+glVf9YqZUzJsWQGT1ulPC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981696; c=relaxed/simple;
	bh=JuRtxgHas7qW8HbkyhiDj2rMQVPrQdaqrYeR7vQQjjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VB2KjeSjZUcjI1QRK9vpqCZv4byMoS7UbNj76EANmo/IJBrcofufsqqU5ynJkOBC9/t9ruW/REX32eDjtnUv2uWq/atqfn+aC4OsRYwuXuvS7wKB1ay/Z2SB+v8UQAPGV5rJTDVMwTNXSShxFpZwZvA+9wYiiBcWvqyV/mNNbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JFiLmT9F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc47abc040so9337905ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722981693; x=1723586493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJmmhRnSimDCA0DfhllOkj12P3+KFgh5jbLsFm9m3KY=;
        b=JFiLmT9Fz9A38w5eod7CaAsave5oCWvTZjEv/NmlRguh1Yr9DeDS+mtvFLogUqCSGs
         ADGQa5FkQCvoqnEc0StY63SyOSAu9+k0mI6ZX5//iIHA/via6hcrJBSqv8JUp6L59JaK
         eExIIGnMSikAapP50sI7CecYpHemoIOytO/Dw4URzfArmfoQ3l0VCBZm7kaW6b9E/SkY
         e7dAITM9b2V0FKZiCIDMLaKy0+ImI+EWrhCA411kqZKnTotA2FbucTnuIaXZzy8L3xKM
         ilQzzWIXclBvy8Fo07L3ieBtWs1BHpM9HTCkLPTasw7QPWd2CR1//esYlgdpkMNyYK/h
         jwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981693; x=1723586493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJmmhRnSimDCA0DfhllOkj12P3+KFgh5jbLsFm9m3KY=;
        b=E5yhiQPZ5SZpe/Ah2pFwCTAy2JQ8QOYG10hKffU7cUPQwYhGXPiyiClVR0D8xXPra8
         Rld7m9PCL2RKgXqMpTqlyJ+CSMUH02504yy+7GhtmHMY0tPilUapbzV2y6+mm0lUf4Jn
         1R1QubzBSL4ye/XWKHZHeHA/8vplZb2eHxEwATl5UAfEIPtYkjA4re8KFeWk1PWImp0a
         fzmoj3b2XBUgjzUF17u7p3jORBXcNAfT5Y6O26h0Q10a2NK6JHZzhZBqAXt6hNMwA/L+
         FZ9D1I4Ot0HqYA1Y01woCO5Mc6r7XBZQ/7L9gpquOw5AjqQh2yeJOFr80jOkts/owR1P
         CG0A==
X-Gm-Message-State: AOJu0YyF5yT8zYt3NtALRAMXBP8Uz8A3Zf7eP3j2Cwb7pWzlnYDZ3DBM
	lmsKrnTHUNyd3U6Blyh2CMzBwTQZ866yjb8NQw/ZLv2xTYWTcdshzkIT89MWccg=
X-Google-Smtp-Source: AGHT+IEWeETuurba3ThRvk61Rcu8424k5tbYlxPJmgWMim8efAQl2JQ7VbuZiF1Qw0KHvZ58myqB1g==
X-Received: by 2002:a17:902:ce86:b0:1fd:a043:e3fb with SMTP id d9443c01a7336-1ff574e385dmr148056055ad.63.1722981693336;
        Tue, 06 Aug 2024 15:01:33 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f27340sm92578425ad.17.2024.08.06.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:01:32 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 06 Aug 2024 15:01:24 -0700
Subject: [PATCH v2 2/2] tools: Optimize ring buffer for riscv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-optimize_ring_buffer_read_riscv-v2-2-ca7e193ae198@rivosinc.com>
References: <20240806-optimize_ring_buffer_read_riscv-v2-0-ca7e193ae198@rivosinc.com>
In-Reply-To: <20240806-optimize_ring_buffer_read_riscv-v2-0-ca7e193ae198@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722981688; l=988;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=JuRtxgHas7qW8HbkyhiDj2rMQVPrQdaqrYeR7vQQjjA=;
 b=L4G828in6P4VvsPDE9SYnotwcp2IAxWNTSxHkka7w/LXWCcJztnlELCpYajDBeGp0Om7i0Sis
 YWMQr6+ro6VBGAOmcJ4u/yy+EXWBEh/BiHRKIXXYnUxsgZ5ETVbauth
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Now that the riscv tools tree supports optimized barriers, use them in
the ring buffer.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 tools/include/linux/ring_buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/ring_buffer.h b/tools/include/linux/ring_buffer.h
index 6c02617377c2..a74c397359c7 100644
--- a/tools/include/linux/ring_buffer.h
+++ b/tools/include/linux/ring_buffer.h
@@ -55,7 +55,7 @@ static inline u64 ring_buffer_read_head(struct perf_event_mmap_page *base)
  * READ_ONCE() + smp_mb() pair.
  */
 #if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__) || \
-    defined(__ia64__) || defined(__sparc__) && defined(__arch64__)
+    defined(__ia64__) || defined(__sparc__) && defined(__arch64__) || defined(__riscv)
 	return smp_load_acquire(&base->data_head);
 #else
 	u64 head = READ_ONCE(base->data_head);

-- 
2.34.1


