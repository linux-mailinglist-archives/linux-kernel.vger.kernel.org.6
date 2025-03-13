Return-Path: <linux-kernel+bounces-560249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EBFA600E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581A03B9D01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9611EF0AC;
	Thu, 13 Mar 2025 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8aGs9zv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00578C9C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893519; cv=none; b=tjMmZ9IsM2q6eNq3oaZQZndsAjb1EZW+sFWV67fFZXFnnTPh8Q+no+EbqjbHYNSlDrjSrHwXoKMpc9PbWtreEMaQHBCVkv6iquZYDL9/BTLd+Y3bwyoH5+7RR2fvtPmhJKrnwNx4GHXNSXK2DBAltm3flX0Uj2A15P9ISlsDsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893519; c=relaxed/simple;
	bh=zyd3wfrqeA51j92jPdAmVNyeubowO7IMOJmbCkaz26w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0dx6Gqt4/3nx7xcKEb/cPK/5IdVV8PIuSWs/nZxJbMYwIL0b9sPUS/h8KbKRXFZWAxIBkgt+MlZFXDoe8BaO+0gvHoao3Q6oCTkilYyEs67ilEsxGq8BbE+pOq68Zhm2i9Fax2eCQ7gufqVOGV+itSyJ6UTuW++iR2bBdV1838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8aGs9zv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso4341309a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741893516; x=1742498316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UlfrwtCi4oKjPorzQpE56B5Hyzvi3SXFdkx/VMTk44=;
        b=k8aGs9zv6PCIKglggaFAPn3W2d3ZGOSp7L0YmZKHmUSFsdccOSENLHTHEbSRi+ZOhr
         f/8W02tFlKxYN1LQG4xtLutWgbWOOwB6TyFsy0REta8OZn38TX6obEPgtoRUez8gQpBU
         wp259175HxSgRdidxSB8c/jwLnlCYBfCnyRJVy89uNGtpGsexKvtOWbUsOE/aP5qsdSn
         cr0gkcaHuCaGjTUGxxOMnzWdlEJASQiaSDoXyHqvrlqqQsxpBGAr8q74FniYgJuxfPdB
         ENlPBsKDNUsMHf6vRIaoOuN39+hiBmh3gw23jRP7lCrNVLf6jMwM4c6rUteyLyeaKMdu
         +GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741893516; x=1742498316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UlfrwtCi4oKjPorzQpE56B5Hyzvi3SXFdkx/VMTk44=;
        b=M235waZMhDyFZKhoPOz/JJ/W1PULaS0h2MdRbs5HR0B2VFxFVjQodPHO8EUUFZiJ3T
         W2OGH/++RkbN1xaLh8TO/1XJ+f74ArzDrr4bY3Kkr5p0SWXGUfujyCa1557l9TQGHhC5
         wrWPI0oPswFygjojx8xdWTP2fVfljmWkFB1F93PFRkRPysxnTN3isW9vKDhFEt9N5CFS
         7PwbJWRWztjuYsl1yRat2cL8iV3HEviQh8P0Lc5ZCAFBDBu1dLcIV4KgJEzNxqaHJQgU
         ZSOjP7f8ro51vQaReqTvG5qcPs/Dg8KYJo0DHvyt4+KkPHr+InBtDDEZAJmHM8hx9AGc
         IugQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5j0bdxuOlx08ihw82bPJCF8Ke0Omts71L326+5R+++fd5pXDatowYxcJlIC9KzcpvW8dAa5YeyHx4adI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0pq1b1EVx2vy/C8HQA6qfTFsyeIZtGonLC3jf5LIkyG+CWa4y
	D+RS4Nrkx7EYiVYNXDnHmdke0rAiq/kLlpUpMLALCoElwvU/OAlN/bX7yUSQ
X-Gm-Gg: ASbGnctrEsGHbLI1KKHM3wMn5GWFUcbHTpsGUJB/Doy7oV/iAFFioygoYUAb+1jh/Nd
	nfspmwKUCbG/HntYYAwzknuHXe6+Lr8Ws0rHFrBf6NpC+197+mSa2Bugznr+Mvuz11jQY19b3iy
	KVI31MHPAkFPXkdXSjERz7d/nK0PTJiQm+YjRB5wmdbmt4JfIUVptulaB6jXTUY5BhPvUDJoD8x
	P6n8aaJlEZ1NaEBtby0d7uMQWVdX1c9ROVyvqyIRiR5cOggscCX9Xzw9NUD/1wOr4z0mWOrsDFO
	t3fRt24Hs1CIqK+TnqHaErx19OPtr1RFnEL5ICQrszeNoio+1MmHbPPmVke4KWdU
X-Google-Smtp-Source: AGHT+IH5gRZ4B79MTLl+F5wXhD3+OXMScw3jhZEjIwjjyI0/q45vZMKYlIvZaoeB68q2wsRV1z/tQg==
X-Received: by 2002:a17:907:2d0e:b0:ac3:2747:9fe with SMTP id a640c23a62f3a-ac327470c30mr89121066b.13.1741893515936;
        Thu, 13 Mar 2025 12:18:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ce8efsm115518666b.102.2025.03.13.12.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:18:35 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/asm: Use asm_inline() instead of asm() in amd_clear_divider()
Date: Thu, 13 Mar 2025 20:18:09 +0100
Message-ID: <20250313191828.83855-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use asm_inline() to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

bloat-o-meter reports no code size changes.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5d2f7e5aff26..06e499ba4fe8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -707,7 +707,7 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
  */
 static __always_inline void amd_clear_divider(void)
 {
-	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
+	asm_inline volatile(ALTERNATIVE("", "div %2", X86_BUG_DIV0)
 		     :: "a" (0), "d" (0), "r" (1));
 }
 
-- 
2.42.0


