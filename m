Return-Path: <linux-kernel+bounces-367746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7B9A062F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE1DB2434F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D720605E;
	Wed, 16 Oct 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0tssgJ1"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F91B78F3;
	Wed, 16 Oct 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072595; cv=none; b=Ldoq1NLzJymi8ZpKW4EEpJO+6ONOdHz5XBlmyOngM+aMIZtO3w+W52lDAJW+l79MnrgB89Tadu7f9ijipZcJfpcqHcM9vLVXhFKK7QMJr4uGhKzpd7ThM7YxwVp0zpmtKxhzDJWQVYk7vtausSCV9rk3OAa31IGcomlUeuZWKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072595; c=relaxed/simple;
	bh=nITX4l5cqP0y7EEZ7tQeL0WLMHfL/LyZRt/gFUg95m8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2jiT9AilAGhK0YBgHHt+KyZc6BP1vgNW3zplnqoHxBIpKGQ0ytJu125TYR82wiqp7h6+XjNqHvQgMoafjBouLsrNGv2pYBJKzCsd/eUIzz/F7oKClqM5ev2gOWCS0Lpy7uPCicIypn1s2wfoqQdhkjd4D8ewQY5Q3EGufSw0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0tssgJ1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso3418760b3a.2;
        Wed, 16 Oct 2024 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729072593; x=1729677393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3yNxgct7QY44bG7w60XotfbN9PqaxadBpIDEsrxKZI=;
        b=d0tssgJ1E+B3h+Kmc1Arm/Eweaa46ZDyfzmwsVODFp6G5fO9Tp1Z3qI0qtcykj47V5
         lU1OBCxEmDQKl0ZWrMVaKqVUQokMdCPyhuOARiMOHosDS7hNoVq5c0PYIqUukdoIDg1m
         xTW2nNuDfM5iESRAQV99ZkmdoV1S2+Q4PugpDaVQXokmTWvRz+VRLBLgtxiyi19+X9tk
         b98vRXn5rPAHNwP0s/EdTDz2cu2UBe5hRARTcUwwufmUxnzumgqb2btPUeRyoMiujqun
         SxXruPSITtgXW8so4GDsLqAPrQ/dMGA5r+oOjc+r3H/pKFEEz+c0NdnlTXlECl7sTHox
         L1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072593; x=1729677393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3yNxgct7QY44bG7w60XotfbN9PqaxadBpIDEsrxKZI=;
        b=AONlypKpQ1GX/1H/KzU201THnRL+9E1xygbXYouDw0Q8RB4j2TDDFgBkAw7THDucag
         XRToNOqFs4VrTwCpb3m5HuV5Wax3DWWiR3ovAQVkn1fzjNTQ98u+4JQX+hD6hue1WIKC
         CNVlgQtlFwhsIZh9XIDY+3U5BktFH58/5aC0BqrWbwMUZQQ/pY3qPCNuj4LeoW4yFPRe
         T4ewQH49q9ZGmnbZf4d8AxMjAalj6mdS2vPpVVsGloMXfCNbPgPKzFcn8QJfp5CsdO8Q
         X44tv8DLMHvq0tJs8b1e7ae4j2R0t/TxyH0XNS36ocH6bYO7+P7ct/F29vMBvUhFc0zl
         jEPw==
X-Forwarded-Encrypted: i=1; AJvYcCU52ttHO/krGz18ajvoX5hkH8jQbU1ZBw0dusjRpbbbrzxMve80TYTqv8SbzUcuXEjVWrwwTQSx70uwxWQ9@vger.kernel.org, AJvYcCWZQNuvrT9UOGNUeD23G3Odn408vVD1bulLO8sEV7AA87VUsa7yuJOgVJUOuhHY5MVP5PQLRd81pnht@vger.kernel.org
X-Gm-Message-State: AOJu0YwaF5jRemv+DYR0+lt5i18b/yvlqZGgF/sJr22p1TaX6YElslqs
	4Xpx8nSMNDa8y4xcRaxktGCV5GbmRO40ysgErT7oi7MmBd2wYUx1
X-Google-Smtp-Source: AGHT+IFcz0yc81Apz/niZRH1c8GvcpfAlXt/Rr+JESn0CLZRy9SMDtYy1hlbLHmPYLcM9H2gyiJwOg==
X-Received: by 2002:aa7:88cf:0:b0:71e:4c86:6594 with SMTP id d2e1a72fcca58-71e4c866d85mr22837310b3a.10.1729072592864;
        Wed, 16 Oct 2024 02:56:32 -0700 (PDT)
Received: from localhost ([202.85.210.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e84982905sm763996b3a.96.2024.10.16.02.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:56:32 -0700 (PDT)
From: Yang Li <yang.li85200@gmail.com>
To: yang.li85200@gmail.com
Cc: guoren@kernel.org,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] csky: fix csky_cmpxchg_fixup not working
Date: Wed, 16 Oct 2024 17:56:26 +0800
Message-Id: <20241016095626.8162-1-yang.li85200@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008054615.43062-1-yang.li85200@gmail.com>
References: <20241008054615.43062-1-yang.li85200@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the csky_cmpxchg_fixup function, it is incorrect to use the global
 variable csky_cmpxchg_stw to determine the address where the exception
 occurred.The global variable csky_cmpxchg_stw stores the opcode at the
 time of the exception, while &csky_cmpxchg_stw shows the address where
 the exception occurred.

Signed-off-by: Yang Li <yang.li85200@gmail.com>
---
V1 -> V2:Eliminate compilation warnings

 arch/csky/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index a885518ce1dd..5226bc08c336 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -45,8 +45,8 @@ static inline void csky_cmpxchg_fixup(struct pt_regs *regs)
 	if (trap_no(regs) != VEC_TLBMODIFIED)
 		return;
 
-	if (instruction_pointer(regs) == csky_cmpxchg_stw)
-		instruction_pointer_set(regs, csky_cmpxchg_ldw);
+	if (instruction_pointer(regs) == (unsigned long)&csky_cmpxchg_stw)
+		instruction_pointer_set(regs, (unsigned long)&csky_cmpxchg_ldw);
 	return;
 }
 #endif
-- 
2.34.1


