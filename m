Return-Path: <linux-kernel+bounces-425859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E49DEBF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A5AB21B48
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0531A0BC5;
	Fri, 29 Nov 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNdvwgpO"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4C1A0B13;
	Fri, 29 Nov 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903957; cv=none; b=jy0g8grycV3l+AwpMgfQsK+1OKrc2BeTtPA+hEBtkWUeL53YZhtKwAsNPyxDwYiS14xwGEzKQaHsbcKGstgJtJFCqQ2uzhpBxEZWcLMeycLuI4wruhuN3evPLJUMDgTyec7KPgBnbqCQxNiZBswNO+3/Revli50o58WXsmPwsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903957; c=relaxed/simple;
	bh=hFqaZCuzLCN/kjh0t2Lm5R741ch19PL2+BxpRQEIaLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DmmCwB62eJ2i5klbt+Q2Xe2f34pqOPNzHwVr8EvyjOssA6wSdrG8TsiEhYC9Y8aAhPV+sOpX+qJwVQWc2o8id3c1sV4Mo0DECTeGhLK8SgrjOSO4gaxQmGZO/7afXIek5UXIeQquD6wO8cvwiWlNTSUk89Run2P14da+rsKjtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNdvwgpO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e9e377aeadso1760553a91.1;
        Fri, 29 Nov 2024 10:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732903954; x=1733508754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9SB3AMYPBQXj0bhHp6Yep5+PKQx14JSqL2FKuHdcys=;
        b=kNdvwgpOeozmh7ofVuoM1foWiGdrip8bSqj0Vudyc/26rSP5Ibj75P56gnCWbnBPSs
         IH5BXu7+yC7kjXUpu647lTSrDQDFDiyxknyOURSgn3B3u4PrZ1AvrXUyBxla/otK17A6
         PlQa1foKnBq5TJgqkDStnUYnhOlxlTBhaYYYWu/eMmj1E9jYTMamqM8/8ASffFq2PNTL
         NirvTuXTv41BQHiAaKkWVA7ImcSu34w2uJcplPVPJV2SACErs/nN/cy/Mm32ol/gTfOt
         LdrdZpSdKtxFMnpiwtJLhqevcsmn6GqbaHQRRPXRoQTZu5PVGBPE3TnjFBHe6eJsw0+8
         23pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732903954; x=1733508754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9SB3AMYPBQXj0bhHp6Yep5+PKQx14JSqL2FKuHdcys=;
        b=btj/mxzv0uWIlmra2VMCSY419k2UYqQWPrGfznUDPlG/chAA3dS4Obo4I0OKkpt1d/
         c1znufiyXD1dL5tSSsp8IMVMUmBW22Rfz7fgT2qjS9dGM/UKsHqkiSy2HiwGO0sTZCC1
         0sbHI+gMDDHstlUBuF/lpogbxTxiYydmuqv2fDJ7BR7+ec7ywHH2kDD2BrAWBUFXauVk
         6RDTpgoHqlq96OFZLGn99hpDVG9dw1Cdh3JWoJ79KS7oICYKGvL4T3uySdqazVTik1aN
         zb+KFfk93rBAllwNFBajfkSugedg2LugfWGqalZV8oPfV8znY+MEzTgRtT5HnpGCiRbD
         8ibQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD8gGpM2l4ZbpDLjTctT9j5dlHbIlMEGIjlTbwh3BPft2+yzoZdIeaMZPIV4AvhYpSLIT6pjTE99AxDNh+@vger.kernel.org, AJvYcCVfZk7wGNniu0632V0uJPon1Y3UYfRyIbYwtQD1C0yemlXZ4O8kW35dZY08Apolo7DM0XtI+nAaSDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhmbus3TWicJniPcRK5gSRN+Q6utilK362h4jwlXj9jf+9Hl9s
	fqYs/YNU7qxAuanuJRmTsE1kNJr3N+IzhUtnomkhUHwKdTd7vSzB
X-Gm-Gg: ASbGncuK/Z8/FJvUXIGtw1+XULMqgGRltOJ818VMf2S4Pmzzisb3zEJPdrQPB1X5/dS
	zd/vRN4niGKUZQrYK3iWhdSdJh/9v1gZ8qOj4jRQO2eafeUB64MltQcxleKn6wkUN/hd3hoflgk
	mkAdVARYzmKEN308Gtmn7pO+KNjP4rl0Prd9GP/yDyNg9tIYCc8wegYmXKjKcWgPXFjBlvL+48T
	fGOS+qVAFS8yyoMlcYNu65a7fYb3cpAt8R4rZ3F6p9ywakdqvjdzXE+2HqTt1rOMP3JLDD/w76T
	0mqM
X-Google-Smtp-Source: AGHT+IF9+ka++uUfxI6HLpg+2EhSqcfv9jDWHZ7yUXX1CkBbTaU+ULP5gNn47y3LwHnLdC75bYUmNg==
X-Received: by 2002:a17:90b:4c4d:b0:2ea:6d98:b499 with SMTP id 98e67ed59e1d1-2ee097e5252mr13802967a91.36.1732903954196;
        Fri, 29 Nov 2024 10:12:34 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761474sm3760595b3a.32.2024.11.29.10.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:12:33 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	corbet@lwn.net
Cc: geert@linux-m68k.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/4] lib min_heap: Improve type safety in min_heap macros by using container_of
Date: Sat, 30 Nov 2024 02:12:19 +0800
Message-Id: <20241129181222.646855-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129181222.646855-1-visitorckw@gmail.com>
References: <20241129181222.646855-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of min_heap macros uses explicit casting to
min_heap_char *, which prevents the compiler from detecting incorrect
pointer types. This can lead to errors if non-min_heap pointers are
passed inadvertently.

To enhance safety, replace all explicit casts to min_heap_char * with
the use of container_of(&(_heap)->nr, min_heap_char, nr). This approach
ensures that the _heap parameter is indeed a min_heap_char-compatible
structure, allowing the compiler to catch improper usages.

Link: https://lore.kernel.org/lkml/CAMuHMdVO5DPuD9HYWBFqKDHphx7+0BEhreUxtVC40A=8p6VAhQ@mail.gmail.com
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/min_heap.h | 61 +++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index e781727c8916..456cfbc1b8f5 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -218,7 +218,7 @@ void __min_heap_init_inline(min_heap_char *heap, void *data, int size)
 }
 
 #define min_heap_init_inline(_heap, _data, _size)	\
-	__min_heap_init_inline((min_heap_char *)_heap, _data, _size)
+	__min_heap_init_inline(container_of(&(_heap)->nr, min_heap_char, nr), _data, _size)
 
 /* Get the minimum element from the heap. */
 static __always_inline
@@ -228,7 +228,8 @@ void *__min_heap_peek_inline(struct min_heap_char *heap)
 }
 
 #define min_heap_peek_inline(_heap)	\
-	(__minheap_cast(_heap) __min_heap_peek_inline((min_heap_char *)_heap))
+	(__minheap_cast(_heap)	\
+	 __min_heap_peek_inline(container_of(&(_heap)->nr, min_heap_char, nr)))
 
 /* Check if the heap is full. */
 static __always_inline
@@ -238,7 +239,7 @@ bool __min_heap_full_inline(min_heap_char *heap)
 }
 
 #define min_heap_full_inline(_heap)	\
-	__min_heap_full_inline((min_heap_char *)_heap)
+	__min_heap_full_inline(container_of(&(_heap)->nr, min_heap_char, nr))
 
 /* Sift the element at pos down the heap. */
 static __always_inline
@@ -277,8 +278,8 @@ void __min_heap_sift_down_inline(min_heap_char *heap, int pos, size_t elem_size,
 }
 
 #define min_heap_sift_down_inline(_heap, _pos, _func, _args)	\
-	__min_heap_sift_down_inline((min_heap_char *)_heap, _pos, __minheap_obj_size(_heap),	\
-				    _func, _args)
+	__min_heap_sift_down_inline(container_of(&(_heap)->nr, min_heap_char, nr), _pos,	\
+				    __minheap_obj_size(_heap), _func, _args)
 
 /* Sift up ith element from the heap, O(log2(nr)). */
 static __always_inline
@@ -304,8 +305,8 @@ void __min_heap_sift_up_inline(min_heap_char *heap, size_t elem_size, size_t idx
 }
 
 #define min_heap_sift_up_inline(_heap, _idx, _func, _args)	\
-	__min_heap_sift_up_inline((min_heap_char *)_heap, __minheap_obj_size(_heap), _idx,	\
-				  _func, _args)
+	__min_heap_sift_up_inline(container_of(&(_heap)->nr, min_heap_char, nr),	\
+				  __minheap_obj_size(_heap), _idx, _func, _args)
 
 /* Floyd's approach to heapification that is O(nr). */
 static __always_inline
@@ -319,7 +320,8 @@ void __min_heapify_all_inline(min_heap_char *heap, size_t elem_size,
 }
 
 #define min_heapify_all_inline(_heap, _func, _args)	\
-	__min_heapify_all_inline((min_heap_char *)_heap, __minheap_obj_size(_heap), _func, _args)
+	__min_heapify_all_inline(container_of(&(_heap)->nr, min_heap_char, nr),	\
+				 __minheap_obj_size(_heap), _func, _args)
 
 /* Remove minimum element from the heap, O(log2(nr)). */
 static __always_inline
@@ -340,7 +342,8 @@ bool __min_heap_pop_inline(min_heap_char *heap, size_t elem_size,
 }
 
 #define min_heap_pop_inline(_heap, _func, _args)	\
-	__min_heap_pop_inline((min_heap_char *)_heap, __minheap_obj_size(_heap), _func, _args)
+	__min_heap_pop_inline(container_of(&(_heap)->nr, min_heap_char, nr),	\
+			      __minheap_obj_size(_heap), _func, _args)
 
 /*
  * Remove the minimum element and then push the given element. The
@@ -356,8 +359,8 @@ void __min_heap_pop_push_inline(min_heap_char *heap, const void *element, size_t
 }
 
 #define min_heap_pop_push_inline(_heap, _element, _func, _args)	\
-	__min_heap_pop_push_inline((min_heap_char *)_heap, _element, __minheap_obj_size(_heap),	\
-				   _func, _args)
+	__min_heap_pop_push_inline(container_of(&(_heap)->nr, min_heap_char, nr), _element,	\
+				   __minheap_obj_size(_heap), _func, _args)
 
 /* Push an element on to the heap, O(log2(nr)). */
 static __always_inline
@@ -382,8 +385,8 @@ bool __min_heap_push_inline(min_heap_char *heap, const void *element, size_t ele
 }
 
 #define min_heap_push_inline(_heap, _element, _func, _args)	\
-	__min_heap_push_inline((min_heap_char *)_heap, _element, __minheap_obj_size(_heap),	\
-			       _func, _args)
+	__min_heap_push_inline(container_of(&(_heap)->nr, min_heap_char, nr), _element,	\
+					    __minheap_obj_size(_heap), _func, _args)
 
 /* Remove ith element from the heap, O(log2(nr)). */
 static __always_inline
@@ -411,8 +414,8 @@ bool __min_heap_del_inline(min_heap_char *heap, size_t elem_size, size_t idx,
 }
 
 #define min_heap_del_inline(_heap, _idx, _func, _args)	\
-	__min_heap_del_inline((min_heap_char *)_heap, __minheap_obj_size(_heap), _idx,	\
-			      _func, _args)
+	__min_heap_del_inline(container_of(&(_heap)->nr, min_heap_char, nr),	\
+			      __minheap_obj_size(_heap), _idx, _func, _args)
 
 void __min_heap_init(min_heap_char *heap, void *data, int size);
 void *__min_heap_peek(struct min_heap_char *heap);
@@ -433,25 +436,31 @@ bool __min_heap_del(min_heap_char *heap, size_t elem_size, size_t idx,
 		    const struct min_heap_callbacks *func, void *args);
 
 #define min_heap_init(_heap, _data, _size)	\
-	__min_heap_init((min_heap_char *)_heap, _data, _size)
+	__min_heap_init(container_of(&(_heap)->nr, min_heap_char, nr), _data, _size)
 #define min_heap_peek(_heap)	\
-	(__minheap_cast(_heap) __min_heap_peek((min_heap_char *)_heap))
+	(__minheap_cast(_heap) __min_heap_peek(container_of(&(_heap)->nr, min_heap_char, nr)))
 #define min_heap_full(_heap)	\
-	__min_heap_full((min_heap_char *)_heap)
+	__min_heap_full(container_of(&(_heap)->nr, min_heap_char, nr))
 #define min_heap_sift_down(_heap, _pos, _func, _args)	\
-	__min_heap_sift_down((min_heap_char *)_heap, _pos, __minheap_obj_size(_heap), _func, _args)
+	__min_heap_sift_down(container_of(&(_heap)->nr, min_heap_char, nr), _pos,	\
+			     __minheap_obj_size(_heap), _func, _args)
 #define min_heap_sift_up(_heap, _idx, _func, _args)	\
-	__min_heap_sift_up((min_heap_char *)_heap, __minheap_obj_size(_heap), _idx, _func, _args)
+	__min_heap_sift_up(container_of(&(_heap)->nr, min_heap_char, nr),	\
+			   __minheap_obj_size(_heap), _idx, _func, _args)
 #define min_heapify_all(_heap, _func, _args)	\
-	__min_heapify_all((min_heap_char *)_heap, __minheap_obj_size(_heap), _func, _args)
+	__min_heapify_all(container_of(&(_heap)->nr, min_heap_char, nr),	\
+			  __minheap_obj_size(_heap), _func, _args)
 #define min_heap_pop(_heap, _func, _args)	\
-	__min_heap_pop((min_heap_char *)_heap, __minheap_obj_size(_heap), _func, _args)
+	__min_heap_pop(container_of(&(_heap)->nr, min_heap_char, nr),	\
+		       __minheap_obj_size(_heap), _func, _args)
 #define min_heap_pop_push(_heap, _element, _func, _args)	\
-	__min_heap_pop_push((min_heap_char *)_heap, _element, __minheap_obj_size(_heap),	\
-			    _func, _args)
+	__min_heap_pop_push(container_of(&(_heap)->nr, min_heap_char, nr), _element,	\
+			    __minheap_obj_size(_heap), _func, _args)
 #define min_heap_push(_heap, _element, _func, _args)	\
-	__min_heap_push((min_heap_char *)_heap, _element, __minheap_obj_size(_heap), _func, _args)
+	__min_heap_push(container_of(&(_heap)->nr, min_heap_char, nr), _element,	\
+			__minheap_obj_size(_heap), _func, _args)
 #define min_heap_del(_heap, _idx, _func, _args)	\
-	__min_heap_del((min_heap_char *)_heap, __minheap_obj_size(_heap), _idx, _func, _args)
+	__min_heap_del(container_of(&(_heap)->nr, min_heap_char, nr),	\
+		       __minheap_obj_size(_heap), _idx, _func, _args)
 
 #endif /* _LINUX_MIN_HEAP_H */
-- 
2.34.1


