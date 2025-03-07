Return-Path: <linux-kernel+bounces-550513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C150A5609F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B5D189671D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C13C19CD0B;
	Fri,  7 Mar 2025 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE5jM0QO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E495198E6F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327939; cv=none; b=FLVCzyEmW/1M6wy7bvtWcLRrJ1qmmhTX56GtFDEDrSJF3qfKuFc8fuyzyRgeW4bjQh2DRj/IPt9gbJQ0DFBACdzKZGErkWoFefSIPeVXeW2QdEMEiPNvd/OQykzIa9Bzh8QI3F3aLC1f1UT8zyLr7LeNkMbrVCFsBdC8r+D5oUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327939; c=relaxed/simple;
	bh=vCyddJ0D95OwxDUR6U/Pbrt+ThF/e5dJerWiPBwzDmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljqQZHiIayUzJMgd2KZlvMfauY329Dvbo2bx1MzSiq4C9s9KzrW6mxqvVCl26bk03QiVgekrodJspGVyDbqnuKA9Of6Qt3i9iZKjsVoQPvM6cgoB2TdtAXYk14UXUQCpsfgUdTzjX5sRfawvfJihHtU4/wlDKXzTyuxldTobU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE5jM0QO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abec8b750ebso256110866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 22:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741327936; x=1741932736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRUzzQ97ZwMPSXtyuJFQxmEmoL1y54SwlS9TQS3XfIk=;
        b=XE5jM0QOHNAPGPOPewwX6jSs/7nf0TLfdd+S2/j43k5sa4H0sGieM4pKqBo7sZbkdR
         Mgo80C214qGSgpZRfCDsjLY195zK1EwDuJNi/AJqXozE0VOHuQRjrc7I3dOElG5Jb+Ev
         Dk9cfLbEaSzyZe4s0ZmmEKskrEAzu1hdyQ5nqbRnflnvenZc1DnetnzXSN+edhIYWpQc
         Ec0vWX0iK+wFjmKQseNy/5JIiM5V5qQ6wmH3fTvz/XCWNiM9tATxWACNe4M9LQeAR+fr
         LnWN6QaN3ZxQlm7wIF7lqNmqGpB5f0IY7UFsej4SEZrq/5vSZZd6VXPs+1Q3TGiHSrxB
         YoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741327936; x=1741932736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRUzzQ97ZwMPSXtyuJFQxmEmoL1y54SwlS9TQS3XfIk=;
        b=Bi3F68iCEdUWH5J+TlEC0J+Cp7bYkI6qh5LZjXVFL1JHUAwAIxT8AgiMv0nanDzjXN
         bl4eWtcRUwWuDRIwozK8W3w59C1OSVFTJsPRIFvCXQOkeRrDtVmRtLKKY8pwBloYVTbN
         ejcV4AEIgtZ7Hk3GqEBlE/Fl3C0/ptJr2qpWyEj+71q5c21l9HSbNim//AOOvCNxoXsR
         Qwff0wy93QBRK+oF2IQf9PgHNK43ZEzKHbc1sRjRYvAT/1mVRbHUX6w+aK5+X4reIxUG
         +XbcaW5tJplnYZYJ1E7fhsWXMFIeS+2avdPT20Mp0RP5MdYJxjLJzvojG+PSo4PKAWgA
         2iwA==
X-Forwarded-Encrypted: i=1; AJvYcCV8l3SbewYpYetR0aThOYVMlZmszgF8nT3/322bnPDzU0Odl7Jc/K4Gi+pz+VGl9XKvEcPnjDbBSwgneJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMQc2zhGLAYJATo3Ohgw4POVO+aMKJ0OulAyMjjbXt6B2UOdG
	8zAKalpPaT35Bg8QNEnkUd1z9deRyfZrI/eIpAMNg6RkXgzhtWM=
X-Gm-Gg: ASbGncvMZQlJUlk+kDurui+s75rfTruF3++p/IiRW77k2dCOOKQhCpXhdodfxF4aCnn
	eCuBBF9dsNMAUV49S+ErNNvQjxSO5V6Vmc6q5dmqixUTy8iWE7QRbzZXcgWJTQxyzZQe/xhB25P
	C9hiECX0JPkQHU7a89r9Uw17h9anLxQi8ZAB4SB0M+XihYtYCIIhIjFNwyFnuk14V1e5g8de4Fe
	GZro/LwDDh8hc95o5+3rh+KKEoeoU7ukFPhSG+d2RbOlfjP4E2eExH30X7iHrf+42zEP2phWN+c
	zeNlQuwItCi7DNaryrjANu+fPb/KLY9mU+4r6GqdmpK0NqEtlvk9K4Uq
X-Google-Smtp-Source: AGHT+IH3FqFDOrTYacaH+NQOlfi+rO3IvHAZkyEssU04D2Pzk3ADoYv1vgUSWkh3iKa+tXJ+J8EPxg==
X-Received: by 2002:a17:907:94ce:b0:ac1:e1e1:1f37 with SMTP id a640c23a62f3a-ac25273af3dmr227721566b.10.1741327936139;
        Thu, 06 Mar 2025 22:12:16 -0800 (PST)
Received: from localhost.localdomain ([178.172.147.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdd8sm216824166b.138.2025.03.06.22.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 22:12:15 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 2/4] x86/asm: delete dummy variable in clwb()
Date: Fri,  7 Mar 2025 09:12:01 +0300
Message-ID: <20250307061203.3281-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250307061203.3281-1-adobriyan@gmail.com>
References: <20250307061203.3281-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cast to pointer-to-array instead.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/include/asm/special_insns.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 494a1aa19f05..d349aa0f0a83 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -179,17 +179,15 @@ static inline void clflushopt(volatile void *__p)
 		       "+m" (*(volatile char __force *)__p));
 }
 
-static inline void clwb(volatile void *__p)
+static inline void clwb(volatile void *p)
 {
-	volatile struct { char x[64]; } *p = __p;
-
 	asm volatile(ALTERNATIVE_2(
 		".byte 0x3e; clflush (%[pax])",
 		".byte 0x66; clflush (%[pax])", /* clflushopt (%%rax) */
 		X86_FEATURE_CLFLUSHOPT,
 		".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
 		X86_FEATURE_CLWB)
-		: [p] "+m" (*p)
+		: [p] "+m" (*(volatile char(*)[64])p)
 		: [pax] "a" (p));
 }
 
-- 
2.45.3


