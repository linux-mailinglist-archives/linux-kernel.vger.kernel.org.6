Return-Path: <linux-kernel+bounces-351869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772FB991715
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BF8B20C19
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C41509BF;
	Sat,  5 Oct 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBQChYhl"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5A13C8F6
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728136382; cv=none; b=l2OwPqpbEdj6z5wvkWVDmHvfJStN8rtUbtKr9MLwnAkyeeEtQKS7Y3giw2sSHab3CyziDQphMJ4Eiz6IVHShy2e5O8Pa0cOJhlAxNGogkr40zsI+Tw3kJw9MC5jW5z6dUNlnUEKlM2YkkRUWm9O4ttkAuNCik9XwH2CYGd8B8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728136382; c=relaxed/simple;
	bh=Ajlem6k/uodZKw91vdPW9aYla6FAURsqWh/JStw+YtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqPAlRC7kdpiASomOZ1drS+Y615KEWttwU76hRlWw9RD8GdRTNZl7hDgq0/GHFDNlQpI0IU0OHpD5RKLCmvB8JlKJDNtoIpu8RgumnwxI00RKKxcgnTFpcup5jekPktGpyhqMTHOwKTP/LYd1KSfFIx5JKgb58HS09CHU0xN6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBQChYhl; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2144643a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728136380; x=1728741180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbLT/T70VsNnTE26uE1848ixYQonI10aMF4BdG+3s58=;
        b=jBQChYhlfoB7/7Fhd9AtbfwP7HuBTn6x66QjBsvtn6e2vAWLXsnF2t3pXQBCfYSu9b
         ASGiHuOcqBor95zrh30yBQqDnFjvlZbo7EOdBA22QL5eibs43cROBR5bpT2/0kv2HE1b
         6ijcb+Mici8FXMw3P6sER/ArThnKIO7XxNtEMlQpcsOQDTNIz3MYDg0yFfxwSO43o7io
         3gv5O9g2WxkVIL2C7/AClFsN+D59CVoE2XcNUqGUR13CcmUskgZ8WwsfH5ihww6OBM+Z
         cK0IQsf6HiFSqof2V4/enCXI1izvXQcRhTFvp/3TjHQg0g/PdTWRgw5WXUCJBfj7PgG4
         B7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728136380; x=1728741180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbLT/T70VsNnTE26uE1848ixYQonI10aMF4BdG+3s58=;
        b=QVBHhAwIUsp9Dc4phB/Dq11Y5feM7ALNIqd/H/UWk+xiIgNlG5xxP9fGNGoJ1mTJKQ
         L6b80rvifuk3mnB1KjyWrALaCMHa+G8CHg8JL5duPeg73G66rBUr69p5QGK2TTmj3WlD
         wrli/7uRljB1cKidzWFhrdDbX6HjTGatIgWu6MQP4pw3s64XBAme+EO2vBru+7xi1hhS
         6MO6Kg3dD3WrNHeRoBfzzZi/N5naXQOi1viHEDJ6RbcGyojD1lyQapOBM4666y4v5nXC
         nJVjgyZf4nbABXz6cywjbpDKc6uv2j1r9W0Kn9GYbE3S1D2CAPjN/Tt5WMdkwKhY7gp+
         s6Xg==
X-Gm-Message-State: AOJu0Yz1DwdzsSoZ7UmL+V3s51I+dxYLel9UnzTmvRyncj9kpGXAPUt9
	4nq4u9cmcCKRcH29irb0x9ZJwQlh2ngzG04ISNx/WOboPSwWAKJJVQ7Vf8sPJ0wLuw==
X-Google-Smtp-Source: AGHT+IEOU8ZTa2vAAW1GLQr/bRHJ0H4/WNcbceO9WPtKl6744NFNbN4Rwpw7YmJHr6dQ2jTZ0UyRzA==
X-Received: by 2002:a17:90a:ec07:b0:2e0:8095:98d9 with SMTP id 98e67ed59e1d1-2e1e6222221mr6574534a91.11.1728136379993;
        Sat, 05 Oct 2024 06:52:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a74:2681:86c0:b921:7e4f:199e:c149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d959dsm3576169a91.26.2024.10.05.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:52:59 -0700 (PDT)
From: Xiaofeng Lian <1198715581lxf@gmail.com>
To: lkp@intel.com
Cc: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	stefani@seibold.net,
	Xiaofeng Lian <1198715581lxf@gmail.com>
Subject: [PATCH v3 1/2] include/linux/kfifo.h: fix some IDEs Intelligence errors
Date: Sat,  5 Oct 2024 21:52:49 +0800
Message-ID: <20241005135250.121964-1-1198715581lxf@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <202410051712.VDmFpiVZ-lkp@intel.com>
References: <202410051712.VDmFpiVZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  - In some IDEs, when using the ARRAY_SIZE macro to calculate the
    buf size of kfifo, an error occurs (using incomplete types),
    which belongs to the compiler INTELLIGENCE reporting error,
    and can be compiled normally, specifically due to the gcc
    compiler's __builtin_types_compatible_p function. Because the
    KFIFO_PTR type uses a zero-length array and the macro definition
    is a simple substitution, the ARRAY_SIZE macro will report
    an error because of the zero-length array when calculating
    __kfifo_esize in the INIT_KFIFO macro. Notice that the difference
    between KFIFO and KFIFO_PTR is only whether or not the buf is inlined,
    so (sizeof(KFIFO) - sizeof(KFIFO_PTR)) / sizeof(type_of_kfifo_member)
    will give you the size of the buf of the kfifo, which bypasses the
    compiler! Intelligence and bypasses the possibility that
    ARRAY_SIZE may be passed in as a pointer, resulting in a compilation
    error.

Signed-off-by: Xiaofeng Lian <1198715581lxf@gmail.com>
---
 include/linux/kfifo.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 564868bdce89..66eb1b8971f7 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -123,6 +123,21 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
  */
 #define DECLARE_KFIFO(fifo, type, size)	STRUCT_KFIFO(type, size) fifo
 
+/**
+ * get_kfifo_data_type - macro to get type of kfifo's member
+ * @fifo: pointer of kfifo
+ */
+#define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
+
+/**
+ * __KFIFO_SIZE - macro to calculate kfifo's buffer size
+ * @fifo: pointer of kfifo
+ */
+#define __KFIFO_SIZE(fifo)\
+	({\
+		DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
+		(sizeof(*(fifo)) - sizeof(__tmp_kfifo)) / sizeof(get_kfifo_data_type(fifo));\
+	 })
 /**
  * INIT_KFIFO - Initialize a fifo declared by DECLARE_KFIFO
  * @fifo: name of the declared fifo datatype
@@ -133,7 +148,7 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	__kfifo->in = 0; \
 	__kfifo->out = 0; \
-	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
+	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
 	__kfifo->esize = sizeof(*__tmp->buf); \
 	__kfifo->data = __is_kfifo_ptr(__tmp) ?  NULL : __tmp->buf; \
 })
-- 
2.45.2


