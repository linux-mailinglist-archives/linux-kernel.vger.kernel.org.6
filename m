Return-Path: <linux-kernel+bounces-187288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7068CCF85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29EC2838F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9FD13D28F;
	Thu, 23 May 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UACOWmmc"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472B4685
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457416; cv=none; b=KAk4SsiTT+vtzSBh8sBC4ogpF542yNDSUEtSCjOSKkBoGZGM17F7RCk3oxgTwfowGCpv6OGIT0yaWXSdGr10NzkrSPrmymP/X0HtiRrISSGkBvv6tGZoiQdDkY5yIlhEaeSxPEERxJTwbVcM48VGVX17gsTbtPbGQqsd0uF2o2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457416; c=relaxed/simple;
	bh=nA1Zf/kgSsU6UpZUR2FlaBVKB2tbpqFGLzwaZl6BRd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAdWU/+o7jj77KIGHHJ7h0dfE3HYwoSbUEqQ1xa2juihYTz5FOY1ea7kvNSV+D92OzNMRFgeU6/acnFeIixHcWNcS2KxgHXIyVKWVEeo4oWfn+K3FYcFGHCwrskZAtTqwKWmUpSD4D3eq+lfjdvNEyy36f+qJzHxXjrUfgDeD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UACOWmmc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f2ecea41deso114363235ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716457415; x=1717062215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLzDnmvqDgSFmrLKy4OzG8kv1xRa1IoHZC1hMXaY53Y=;
        b=UACOWmmcH9Xzs+F8LUQH8DYQGey8R2Gj4W4U9Bwi6MtRHTfJy/FdwkEI/2QAAwkPrS
         AaYLj2avRNOX/EJWEBRLax63UmgrGQ6oaohFSuPeLgVnUJ4a84RQ7bc1vqDivhRC1qmQ
         jhrwE9vZmjVZYkYawaoYYRmaJcnRXao2lEi85Qa0u+e+Oa+7QDaeRAW9dSngl8/ZQEJa
         mXohlTQOmJkDL2UF4hj1qdwXnRMlUrjYyFY1ZfbW2zs57Q6hk99yMD5sX5f+dLqJHoRP
         6Nl0on3D9AQ4mqqXD0TU5sSgZUhiZrooBxptMOqYe1E5izYOTWK30bjeuRnU8MMC9fFJ
         wzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716457415; x=1717062215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLzDnmvqDgSFmrLKy4OzG8kv1xRa1IoHZC1hMXaY53Y=;
        b=drAm0gZ3HNtQzyU0ObpvoClxh690VMCNS9RcgwRfc7OrEIp7S70QW7WWVKN0pVLsoa
         5i/iDsK+5bKiLo25TXaosY4hHPM/UpFtAG9ctAjT9eqDtOpvHGKX+bwk2EEaWFYQosjm
         +bGwvrIzLu9VQko4gi+9zNwSyFq3CJNLs0JK8RoWXOWaarxWPTHELATttEAl7q/u9usd
         HaSAk+6G24QOqv9lAJYuU56yhrIk0R6CuDxgcE8LTLG4tslguVcuCeJGODp97AmtSAiS
         QA1UXNBkZ/Um6xmkTPM/fsMxaBSwyZ34yBc9JNhJW2uF8ekkueL2cvyOT6rTNj8ka3+w
         bVXg==
X-Forwarded-Encrypted: i=1; AJvYcCW8L9dFAeWUeawIRt3niyX0M9Nn97tHoYkDR8v4x88ji5qU/EGkS/mAQ+030t5Oj+ZSW80idQ+zqzlkaxSEk/C/bkBXq00t81Z+kynr
X-Gm-Message-State: AOJu0Yztyorp2YXj4Wy5ItO/rxUAYhT2zwt1R36WH8wnaFidhmODajlM
	rB3qd3KeWsd4lB8ZrQj+8oLwEBkLlRPukIpA2U1L1TNkIeiKb6h/
X-Google-Smtp-Source: AGHT+IEAU0OshgEKaoU32gTdPHX8D7QDVD1bKWrWAjLH6mLhA8ftQ4r/dhtz/a1/jyxEPLqOWA6CRg==
X-Received: by 2002:a17:902:e3c2:b0:1eb:3d68:fc2d with SMTP id d9443c01a7336-1f31c997f10mr32554475ad.34.1716457414397;
        Thu, 23 May 2024 02:43:34 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:6249:183c::26a:4f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fb7a1ae3sm74139295ad.299.2024.05.23.02.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:43:33 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Xiao Wang <xiao.w.wang@intel.com>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: [PATCH] riscv: hweight: relax assembly constraints
Date: Thu, 23 May 2024 17:43:25 +0800
Message-Id: <20240523094325.3514-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

rd and rs don't have to be the same.

Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 arch/riscv/include/asm/arch_hweight.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 85b2c443823e..613769b9cdc9 100644
--- a/arch/riscv/include/asm/arch_hweight.h
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -26,9 +26,9 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 
 	asm (".option push\n"
 	     ".option arch,+zbb\n"
-	     CPOPW "%0, %0\n"
+	     CPOPW "%0, %1\n"
 	     ".option pop\n"
-	     : "+r" (w) : :);
+	     : "=r" (w) : "r" (w) :);
 
 	return w;
 
@@ -57,9 +57,9 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 
 	asm (".option push\n"
 	     ".option arch,+zbb\n"
-	     "cpop %0, %0\n"
+	     "cpop %0, %1\n"
 	     ".option pop\n"
-	     : "+r" (w) : :);
+	     : "=r" (w) : "r" (w) :);
 
 	return w;
 
-- 
2.34.1


