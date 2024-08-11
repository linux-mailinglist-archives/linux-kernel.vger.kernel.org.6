Return-Path: <linux-kernel+bounces-282195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6C94E0AF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 11:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CB11F21685
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666C381BA;
	Sun, 11 Aug 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEq9b/WD"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838F8F70
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723368309; cv=none; b=ILJIxavBEdV7KYxgY39Hxb5f9lN5fwkujSJaqxLPMHylG3P+Xt4ATPdzg5e3fsNOSTwXew3XpgvhsJLuDbrapoL0e8lY+CtNKTrzqMZvjKbkjFYDZ5bjGmEezpLxlFyJRuU5GhP/icJAbt2b0BSp5YMZlQ8ScgV0cO0wM8rVVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723368309; c=relaxed/simple;
	bh=s5EOxWPBW2cOnQr5KUN3wvCVINoq9XaqynnriLDSpg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I/nSIt+D1GB6c5q65pUqfMWFq9HEncpKIf0UT+nE7YMlYJJyHnhO9LrstkpTyHhweueTjrVXREjq4FBNRq/fWLtVe71LNtmaeW7eg3Vf9yMhVtx05VjK2/dCiErYyO29g+cQczauhiaSA62AX6+haNks7qAg8+rWwoCSfAO6zOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEq9b/WD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d21a652107so100079a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723368307; x=1723973107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=frrpN+m3gMmqKsOI96fqGv3fhIwLzZc9F2Y2cWSIilo=;
        b=gEq9b/WDl2lq0ILCBuGvx93LhxSCx7v3YkRF6fOAtXaRHO64rA8U/f1C9ACG0rNBsU
         IgbuxdRD7dFkI1VeZDNn5gjbQWA8oEvu5YIWuN/EO1c6VUa/Vfj30L68jpfdbPLsoPdi
         Jo0AbbTws86wwVlyZZXpqU32zqiGeKa7v88NBd/PzEI/GP8yi/BZPqkPQ0ZMlrRtuFWs
         8B9qGfs0gyZHjr5VpW49EqkzS7x67dhm7naVG/CTwMFAsfcels2pA3RZs+BltyF5URmJ
         9q2wOpqUQu+PnqfU868t4ncAOWBbRg9Rt3zGeJ1KN7PkO2UColmP9HRilmBr0tzuaQ1R
         nnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723368307; x=1723973107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frrpN+m3gMmqKsOI96fqGv3fhIwLzZc9F2Y2cWSIilo=;
        b=q2BCfjF3mz28eaOIu1OFFR+wPtrtkP6LQtg2amCEMVPcitGcymeGzPHOrrfNRi1nJA
         rVDtzcDMgla+Hjgxlickx7ounfs/C/Ss2YIlI5eHmayRHKB8gM1qribSY26ScFqnuXkd
         U4fKdy7lGEC6g/xplbz21N74QPeeIJFSW/iuYJf39+rj2VmV8Tm0frjY/p+QNafXKC/G
         KiC/PKoKLwSiin4M1Sf09FUIRiK3HVCcd5wTDrlguZlk+AvZ8LCq7haywOaoO0VZzkLv
         85OwFfdvQoKbCrrJnq58Rn4UtvUbVy53J7z3eQeY5xt0A42mQDhgTNyheT5cUwZ9S05W
         DpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9En1iRCv0bxYUOHxjLzMEn9kLDuu1xNM+4+2lGUrPRUXvWyqRx9t6X8pigLueHl9CFUgUlsGrc14haZO8QizHv5UKps6r1rYG3lNG
X-Gm-Message-State: AOJu0Yw6LVeTSjDAORra/loZF9gMRO99mNH+sXoForhOltr9aEALJKfJ
	jJkJ2kjE5c9UBRK/updujn8eQhuVwLVjqt1PdBJ/j5t6serFl3JhL7zqX3LZ
X-Google-Smtp-Source: AGHT+IHeMq++OLofod9u13STLy/QzQckqsQYcyBh2IUeDHKzYrZu45zYrV9aVTcqoFE5qnpVX2FR7w==
X-Received: by 2002:a05:6a20:6a20:b0:1c6:bed1:bbd0 with SMTP id adf61e73a8af0-1c89f7f45demr6245042637.0.1723368307037;
        Sun, 11 Aug 2024 02:25:07 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:40a9:60e2:c14a:3ef8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a438a4sm2176033b3a.108.2024.08.11.02.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 02:25:06 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: yury.norov@gmail.com
Cc: andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] cpumask: Ensure the visibility of set_nr_cpu_ids
Date: Sun, 11 Aug 2024 17:25:01 +0800
Message-Id: <20240811092501.87653-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable "nr_cpu_ids" is a system-wide variable which should be seen
as consistent all the time. For example it's set in one of the kernel
setup procedure "prefill_possible_map", the operations here should
happens before all the code after setup, which means the operations here
should be visible to all the code after setup.

set_cpu_possible() ensure it's visibility because it eventually falls
into an atomic instruction, however the function "set_nr_cpu_ids()"
fails to make the guarantee since it only performs a normal write
operations.

Adding the macro "WRITE_ONCE()" will prevent the compiler from re-order
the instruction of the write operation for "nr_cpu_ids", so we can
guarantee the operation is visible to all the codes coming after it.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f10fb87d4..3731f5e43 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -46,7 +46,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
 #if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
 	WARN_ON(nr != nr_cpu_ids);
 #else
-	nr_cpu_ids = nr;
+	WRITE_ONCE(nr_cpu_ids, nr);
 #endif
 }
 
-- 
2.34.1


