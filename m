Return-Path: <linux-kernel+bounces-396737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5919BD167
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E861D2842D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8311E0DC7;
	Tue,  5 Nov 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWmA1e8n"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164221DD0D7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822315; cv=none; b=J7mIxZawzTpoBGjyA+udUJfDOxrpLeNtL4lf09vjn5HXw8FKfMPZCZnHW9hfOCJPVIVS9fS2yxycgDr1cS56ANX87oKAeTO6aRAdNNlz6KAnfxJKfHGT9G3zZSZ/4mK5diNb2lCQwkvLQpwJOQeg7nQgzXXTb6pxDV0/ql2QjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822315; c=relaxed/simple;
	bh=ddD8kOgUySWXU+t1Fz3l0vCDJIILQOK7HJ5sY7qrQm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYfTPKwfy1W9nen33M0NLXvTQd37n0lPGDiIz/4HhaWb11Y2zSY7yZHykKRuOtj4AVYo8W+eT/H/Rp0PG3YSiKZcUva94jgxFseRgMqewewUnTDVz7EWYQz3dxpHWAI6W1qIIo6ky2yCoZ3qL9U6GZCFnoxyslN4Mlb06D+CH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWmA1e8n; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbd092f7f0so42075336d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822311; x=1731427111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goZZ5I0gFUaUWAFAFqOvJ466XiJgft1xakHpTSDyHJk=;
        b=WWmA1e8nYmmoj294mjYTmsN4QMUhNi7tXd49FyH/Tl6Z1u9o133RX0QQ4qMf6hcCuH
         DuOQV7nZBDk2tpRgHOWntUkZczQmIEHmumDr28qRbg8X/ZGoyz8n3TnCx4JuNBu4RLfA
         XnuLOdCfNYxGosP7oYYHwp0i0cWRCEqfHmJWs8Za2g0VYT5z5z3ctsT1uP2hR9qMs/Fn
         AXBYbJNi4ZDHPKogGCM3coNGd3E9G0UKT9EbgfTCPZR5gXfbBhBXbB8zTX9j3kOHoWTg
         qK56/MZVxXIU+60h8hiLFP2GY2xoPGHgbwHNYBxeoDVgydgzoGNG+ZmVfhj0P4yqoVI4
         32ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822311; x=1731427111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goZZ5I0gFUaUWAFAFqOvJ466XiJgft1xakHpTSDyHJk=;
        b=lcu1UJTALp8YXh2VGBk3wysQegrUDRPfdQfxVKdvpuSE/1xBbwuExevacj/g+7pYYE
         lPWR11rmS+uwrUK/29Yg6ZHAfHkCLuQvsqlhEk+t5+4ss7eqf/rc7v7jUZGvEKU1Euot
         zCAU3I+MuMb25UnnGp8A8BSyYum4J0IbZTu2WfEbSmjElbdGqQqfj29VHPwWf9yBd4O+
         txbbZeIV5ZLcOTZmXEo2tk4QDRVhUe3tu2DNSpbotAQEeJ5DvA29m8dQuQeRwUzvnfaQ
         2LjdAH01pOqjquS68xYWCbtGSlrFdqCGkhw6Eok5n+fIty2AzLLNFpOreNjKuKWHEjb9
         GrvA==
X-Gm-Message-State: AOJu0YzsGQ53Tc9p8G9Gll0GJr7/u1SVqhjmMyVP1WpRNFLrcR71LdJY
	AqmrcNwfhubNdIk8LNDzwxEE+8u6GFT/Fn6J3G1q4xoG91H9XjQ+5v1q
X-Google-Smtp-Source: AGHT+IFjy/esWih/0PGZx+J4+QC6QO6d5iSL4yfzftri975vhwe9rTrUjJM8TRltshPZH+YPRKN/Rg==
X-Received: by 2002:a05:6214:33c6:b0:6cc:578:7aa1 with SMTP id 6a1803df08f44-6d3460bee4amr309789816d6.49.1730822311515;
        Tue, 05 Nov 2024 07:58:31 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:31 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 15/16] percpu: Remove __per_cpu_load
Date: Tue,  5 Nov 2024 10:58:00 -0500
Message-ID: <20241105155801.1779119-16-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__per_cpu_load is now always equal to __per_cpu_start.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/sections.h    | 2 +-
 include/asm-generic/vmlinux.lds.h | 1 -
 mm/percpu.c                       | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index c768de6f19a9..0755bc39b0d8 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -39,7 +39,7 @@ extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
 extern char __start_ro_after_init[], __end_ro_after_init[];
 extern char _end[];
-extern char __per_cpu_load[], __per_cpu_start[], __per_cpu_end[];
+extern char __per_cpu_start[], __per_cpu_end[];
 extern char __kprobes_text_start[], __kprobes_text_end[];
 extern char __entry_text_start[], __entry_text_end[];
 extern char __start_rodata[], __end_rodata[];
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f53915f4e777..889f5885e346 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1056,7 +1056,6 @@
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
 	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
-		__per_cpu_load = .;					\
 		PERCPU_INPUT(cacheline)					\
 	}
 
diff --git a/mm/percpu.c b/mm/percpu.c
index da21680ff294..6ed8ba67d1d9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3098,7 +3098,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 				continue;
 			}
 			/* copy and return the unused part */
-			memcpy(ptr, __per_cpu_load, ai->static_size);
+			memcpy(ptr, __per_cpu_start, ai->static_size);
 			pcpu_fc_free(ptr + size_sum, ai->unit_size - size_sum);
 		}
 	}
@@ -3281,7 +3281,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t
 		flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
 
 		/* copy static data */
-		memcpy((void *)unit_addr, __per_cpu_load, ai->static_size);
+		memcpy((void *)unit_addr, __per_cpu_start, ai->static_size);
 	}
 
 	/* we're ready, commit */
-- 
2.47.0


