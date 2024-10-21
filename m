Return-Path: <linux-kernel+bounces-373871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE79A5E36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C923280DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4F1E1C08;
	Mon, 21 Oct 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEUuKrXr"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE71D0F6C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498145; cv=none; b=Qty9MMq54eeVSM6ST+FC2YWGkXN6R2acU9f0b5QJeUYUBY5VICdKhFlnIqEUW6MKxqD29TKmOjGUGRku6ZIEGpPeh6W1TufD8B6P6Pl7aQRdhzJJTX7DTakAHl05o8Kc6zmCJVqoXoAOSGENefqlQnRU7jhfbYEoa2nVrDKCpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498145; c=relaxed/simple;
	bh=txP70k+gixXThghHfdqAVd4Gy9OU5nBLNFhKa5oiZdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ib0ys/XxEpxUf0mNZ8+gVXwa1KYGAS8hA3MqrkPhaTcMsrbXEqYfTWogWj5HgLLwSJHrIGx4H8Nw/OR5Twb3S7+9O9hZNcI4mjYT+DysxPgdh7yVtv7dQiL+Km9DDcvofNnOQtVKL+woGep7X2Ypg8b5EpzIx4BCw8lXUaBADxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEUuKrXr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0f198d38so579308166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729498141; x=1730102941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTgNpqhipVGwhNAGQddK2AXXajHj1yP80Vug7RbRg/Y=;
        b=AEUuKrXrfpbW5QtPT2LiabVzD4YJnwiYROCVRo32MR0jSgLLkICBvRTgN5/L/SChv7
         LIwEinYj5BzhpxNB38U3rqA1PyKuvfJl11sNQJUZ8g5rqVIFmHvzeQCeZh1j7TZHarP8
         GgnFNZCs9xnyeuFjSv6Ax9wbk8duofPG4VRPUpxXlWL7vyLwh2TTDxEFWDvAxDYUXaP2
         joxS5Fygi1h0AbNb56WXq4sKjNTtfOQahzSifpgxLSN8t1PtkUMejBk1pbP955SkQ2ZO
         Iml1MrDmzUV/nhuxPh28UGobbLOGk+KLg23rSFafjBQ+Tl5KrYtkwcDXCXnVsUVC/XRF
         ldzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498141; x=1730102941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTgNpqhipVGwhNAGQddK2AXXajHj1yP80Vug7RbRg/Y=;
        b=IpUOsCyPrlgSjE941eRgKjzb1+UQUJAEjni50CcHRJWKgxfz2owBumuT6VUdbkHjot
         gckH2nc/4HPsqTfkIXg1EuZFbhthUzsf5UjZOuGDD46dn3txwbOseoZTZdj05EVMNgrP
         IUbkWqq6mXCouBQA92eyRSxPkkfQIhZanT2Tm0EIapiGdG7gMOCX5+3c1FN20TkyyKqm
         ExXfILhwco7IHVOuNPWfr61IOV+5FKMMTcunLFkgGasdL9DBKZ+BvBgTGPZ08RifKkmP
         a2d7/eiCwcd4FnyOKR4JzxiunkTHgRvxJ/8PAv/25mhplsjunVys+qEpXShpOp0t4970
         oYkg==
X-Forwarded-Encrypted: i=1; AJvYcCXs1QXyXILCD9eGx4NqF1Ss7oGDPdmGcpZaLHZTN3lvWs9p2MfxCyweUUavhXjpU+fG1b4iC9E2Rzo5/uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGM+ssR7VxyYX2/DzWDXUWOhkCK1LC+Thusj6mo/GC9GMXtTQN
	rC9mIDzBffBThAj/PCsDeFUlC8oUR+qOYlXooPQgU23yzLyabWCT
X-Google-Smtp-Source: AGHT+IFr6qF5yVsAlRtiA6VJhMs6VUjMqn5VZl2LAiGXV+yzR5IZMR5hiN+C58YaTrZuTIRNejvYIQ==
X-Received: by 2002:a17:906:c150:b0:a9a:a32:bbe4 with SMTP id a640c23a62f3a-a9a69773838mr978103766b.12.1729498140818;
        Mon, 21 Oct 2024 01:09:00 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913706a7sm175925366b.141.2024.10.21.01.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:09:00 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] percpu: Introduce PERCPU_PTR() macro
Date: Mon, 21 Oct 2024 10:07:37 +0200
Message-ID: <20241021080856.48746-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021080856.48746-1-ubizjak@gmail.com>
References: <20241021080856.48746-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce PERCPU_PTR() macro to cast the percpu pointer from
the percpu address space to a generic (kernel) address space.
Use it in per_cpu_ptr() and related SHIFT_PERCPU_PTR() macros.

Also remove common knowledge from SHIFT_PERCPU_PTR() comment,
"weird cast" is just a standard way to inform sparse of a cast
from the percpu address space to a generic address space.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/percpu-defs.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 7fa88c5f4b26..e1cf7982424f 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -220,15 +220,17 @@ do {									\
 	(void)__vpp_verify;						\
 } while (0)
 
+#define PERCPU_PTR(__p)							\
+	(typeof(*(__p)) __force __kernel *)(__p);
+
 #ifdef CONFIG_SMP
 
 /*
- * Add an offset to a pointer but keep the pointer as-is.  Use RELOC_HIDE()
- * to prevent the compiler from making incorrect assumptions about the
- * pointer value.  The weird cast keeps both GCC and sparse happy.
+ * Add an offset to a pointer.  Use RELOC_HIDE() to prevent the compiler
+ * from making incorrect assumptions about the pointer value.
  */
 #define SHIFT_PERCPU_PTR(__p, __offset)					\
-	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
+	RELOC_HIDE(PERCPU_PTR(__p), (__offset))
 
 #define per_cpu_ptr(ptr, cpu)						\
 ({									\
@@ -258,7 +260,7 @@ do {									\
 ({									\
 	(void)(cpu);							\
 	__verify_pcpu_ptr(ptr);						\
-	(typeof(*(ptr)) __kernel __force *)(ptr);			\
+	PERCPU_PTR(ptr);						\
 })
 
 #define raw_cpu_ptr(ptr)	per_cpu_ptr(ptr, 0)
-- 
2.47.0


