Return-Path: <linux-kernel+bounces-337153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8F79845FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37A61F213A9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD41A7AF5;
	Tue, 24 Sep 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg5xyrGB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373192907
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181163; cv=none; b=q7LIEzNUnzDyJOpo8vnv0Bex3nEtFL9bv54aaF0fGZwWLSJb80/k8RdGSf4cjhZvMACJLtMEPIJ5v/Ejx8pm8UCjUURtnJGmuyKJ9N9bU8boingXU0WwTg35ButFr8psVS0ZvkncerNc/8KLJXJepHaQLzpTY8FztJwdsmyWjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181163; c=relaxed/simple;
	bh=p+SlC9+iWsoYOkzR6USkIX63Q4voGnHbuqMuTP5Qk6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7qISKNWFPAIZUpcuiI/vTdjjm0mcNAMZp1TzpaOpAtk9uLq99CWRNemcYcNLEUJzGNY2jrGwc0OfIhGk242Jrn3Q5+LpOXlmAIuTDibrmfCuPmyFNZ//6sZ7uCegRfHLP0uXDekybUqYsMx5kcXR1Gj/9CUamMQfXDlRY6OW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg5xyrGB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71b070ff24dso114194b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727181160; x=1727785960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2CQ3g+a9Pxs3bYyycBG+VPiOxu/RQcJ2VdogNTviFY=;
        b=jg5xyrGBHT3DIGyvTvleYW6tz1THZZhtdnYFyuzpLIIwwKpsnDoPt65QYG6a618E7E
         jU8trfJAIV7hMbomUUM0KemDQ/Y55UL0X8kB56wt/52di7RTkhSh77Oc3e9rFe00gXhF
         xn+OdcKO6LzUZxx1PsIR8kRBvcK1HxklLsKPXYQXWDpV0TY/sT208qFP6EOOR6x9VZfS
         LnfWVe1sbkQM7F0KEoc323i15cBJgLJ7SM0a0QKuXM+IsL81S0kUJuY3QWuRJzcgfOiv
         n6VkdTim4h+9Qfy+IVAnFyGkZF0+JnKd8rURF4B2Ew2rI9dofdWhBDZskTIDaAFUPjQ3
         xRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727181160; x=1727785960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2CQ3g+a9Pxs3bYyycBG+VPiOxu/RQcJ2VdogNTviFY=;
        b=ug+0UaAPRn3Or3WDfi2vY5zPF5VnO4b9QcgN85W8uc8ywrpz/PTAIhc8RuZhP23aru
         5rF6CAy8GZ+9pj7WUc1X2nk4b5prw7dyUj6YcIRWM039ILCOaekw0Q6lPmCpjMH1R0ld
         1E/4/HfmegS4oXPPoBmwRBWiSDgLdTsufK2sOCFuGnu6Mu22rmpY4OKb/LAEX7K8qY1Q
         O1BZZz5a8drWC93jzfN2uW5Ipq+MF3CXuNlAiD89Gs2wawz+TlG0h4KAjeYMV4PVAfrC
         if2Dj8kM3XzQzY+shT89eAyG/Y2zK9nuM7MdCLFhqWG8Z+THB8/lI1d5S4CU+1n5UWO7
         UbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz74V+D4der33227g8unthYI7bP3fQ1JtCybJoveHZg7FUhGIenp7bTQGyWlkYEc08JqliJSVbAuTH1LU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsfx5720xg/o0llcJD/i6cWo2DVcv0cQMdt2JPqOt7RLK4ujHi
	GO2eBjsW9ZF9ZFeewhA819AforHnDOM3uExDW+FlAn/8QCQJV0pS
X-Google-Smtp-Source: AGHT+IEmU39wcdMD7Hu+761mCwaWe1nxzhCQtivLc6GjEntFU8SDmx+NYyq927LMPvKJT+boqhoojg==
X-Received: by 2002:a05:6a00:4650:b0:717:8d81:e548 with SMTP id d2e1a72fcca58-7199c939056mr22079935b3a.1.1727181160349;
        Tue, 24 Sep 2024 05:32:40 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c5ad4sm1115566b3a.188.2024.09.24.05.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:32:39 -0700 (PDT)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH 4/5] rslib: Improve the performance of encode_rs.c
Date: Tue, 24 Sep 2024 20:31:40 +0800
Message-Id: <20240924123141.16962-5-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240924123141.16962-1-zhangboyang.id@gmail.com>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances the performance of RS encoder by following points:

1) Avoid memmove(). The shifting operation done by memmove() can be
   merged into the calculation loop above.

2) Introduce rs_modnn_fast(). The original rs_modnn() contains a loop
   which may be slow. Since (fb + genpoly[...]) is always strictly less
   than (2 * rs->nn), we can use a ternary operator to do the same
   calculation. The new faster function is named rs_modnn_fast(). The
   new rs_modnn_fast(x) requires 0 <= x < 2*nn, in contrast, original
   rs_modnn(x) only requires x >= 0. To make things clear, the
   documentation of original rs_modnn() is also updated.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h        | 15 ++++++++++++++-
 lib/reed_solomon/encode_rs.c | 21 ++++++++++-----------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 908bf7d0eb58..d228ece01069 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -110,7 +110,7 @@ void free_rs(struct rs_control *rs);
  * rs_modnn() - Modulo replacement for galois field arithmetics
  *
  *  @rs:	Pointer to the RS codec
- *  @x:		the value to reduce
+ *  @x:		the value to reduce (requires x >= 0)
  *
  *  where
  *  rs->mm = number of bits per symbol
@@ -127,4 +127,17 @@ static inline int rs_modnn(struct rs_codec *rs, int x)
 	return x;
 }
 
+/**
+ * rs_modnn_fast() - Modulo replacement for galois field arithmetics
+ *
+ *  @rs:	Pointer to the RS codec
+ *  @x:		the value to reduce (requires 0 <= x < 2*nn)
+ *
+ *  Same as rs_modnn(x), but faster, at the cost of limited value range of @x
+*/
+static inline int rs_modnn_fast(struct rs_codec *rs, int x)
+{
+	return x - rs->nn < 0 ? x : x - rs->nn;
+}
+
 #endif
diff --git a/lib/reed_solomon/encode_rs.c b/lib/reed_solomon/encode_rs.c
index 9112d46e869e..6e3847b17ad4 100644
--- a/lib/reed_solomon/encode_rs.c
+++ b/lib/reed_solomon/encode_rs.c
@@ -27,19 +27,18 @@
 
 	for (i = 0; i < len; i++) {
 		fb = index_of[((((uint16_t) data[i])^invmsk) & msk) ^ par[0]];
-		/* feedback term is non-zero */
 		if (fb != nn) {
-			for (j = 1; j < nroots; j++) {
-				par[j] ^= alpha_to[rs_modnn(rs, fb +
-							 genpoly[nroots - j])];
-			}
-		}
-		/* Shift */
-		memmove(&par[0], &par[1], sizeof(uint16_t) * (nroots - 1));
-		if (fb != nn) {
-			par[nroots - 1] = alpha_to[rs_modnn(rs,
-							    fb + genpoly[0])];
+			/* feedback term is non-zero */
+			for (j = 1; j < nroots; j++)
+				par[j - 1] = par[j] ^ alpha_to[rs_modnn_fast(rs,
+						      fb +
+						      genpoly[nroots - j])];
+			par[nroots - 1] = alpha_to[rs_modnn_fast(rs,
+					  fb +
+					  genpoly[0])];
 		} else {
+			for (j = 1; j < nroots; j++)
+				par[j - 1] = par[j];
 			par[nroots - 1] = 0;
 		}
 	}
-- 
2.30.2


