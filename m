Return-Path: <linux-kernel+bounces-575883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168B3A70893
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0258C3A55D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC461263F41;
	Tue, 25 Mar 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCA8xW0f"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D601A5B90
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925150; cv=none; b=bJ7ZhuM4VtCXDdAaAhWn7G9DOqH8iigATAyJQ+eO6qn8/Z9I/HoaTLtupR2ab6x+XJL+WapCkuicrtOi5jwEv+sf0LUCuF0fR1fLx/CdN75yB4iWMb1ecbz9JOiNwg3lMpqBDxLoVpDmTVOdyvCWntPz2EDqKw9gNasJ9uGDL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925150; c=relaxed/simple;
	bh=qt+t+hpIf9yZe0jac0bkQxRgXTjYdEPTnxka4vAJER4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1LRK9ERuokQKDGZrkdfkx1r18w8SL7wI2+u/r5mEJ+eoyIyUYA+Tzb7AKE4DkYUupOUpEVmdxIJdqntQuUiufRl8QmoLfdhekPluRqvgk4QAMuGsT54XBOIi68wEeafFckNB/DlzllCSkdy6AGVP0Q8gbms6cTMVAwAUuZFLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCA8xW0f; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso133256a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925147; x=1743529947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9Y/tC4F4E3aswb49cFrwTppIz6ZAOOiz75v7l8znNg=;
        b=PCA8xW0fUG9+YwjBNjHOOWtYoC2YFZUgdPWRaMjcIc6b8GH6NWtbL3aTTtsshshzYD
         Ogm62i/0vSdgnCNEM5pNEq+eirwup2BmWYRImdO74o4uOP/s/l1ln22FeUds33WWMvfi
         6m9kekie6kszLl+QpObFJIK3UUkJUnVn/W+HuADRNQpeT1a0yEAdqbjmB+ddWrVWUj8w
         ZORn9+6XyIdnzio4pJLYtWiALrvYN4YsOTR/WwC6/UnI36xrkQ7tbSiLnXyfwxwORJ5K
         5xUZAZIersNqFbhyP8so2zIGYwiHlo4TSaxXUueSgd9d4dxjZQfcM4WJ3Dfwkz++Vmk0
         dGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925147; x=1743529947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9Y/tC4F4E3aswb49cFrwTppIz6ZAOOiz75v7l8znNg=;
        b=G7yikjNUD2lsQrPxWgE4RXZ+wwkQbGqi0l6HiiycJ3TejwmjBPBuyvFD2JBcSc7dAW
         CQTimvROVN0MIWuyKfLyydhp9IS7znJhMYSwL11l+hVS6Td+10f9+le6aSAihr40YzbZ
         GIkBpDEjm/qv7Yg2HVvvDUrmef2kHM56Tqj9A7rcDm437fqtDdVMu1gdN01QmFqq8Obv
         fnHk623XkgKKUIPajxMBlcXqwPXixvgTPdqR2u5QrR2GDJ+47pIYNOFlHPpvqjHrmS4F
         pdiA8CjWtr8JHTsmfNPKUp/ws8JVnHg7uJHOs3WiiyvoHHL+6xMUyqxAGll/Iw7ldfaP
         mQHw==
X-Forwarded-Encrypted: i=1; AJvYcCXoaoQ6cqdrY5gaSdMbdmQxQG0P0wPaxy2qps6X+B5lEYldVwRVdLy/tgJqJEgTxpY+x2b2UMPA7BEgT28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHwumaEqLHa30ChOVZMTW1mqkE1fXEH/hU6vnVA91jYrNAm3u
	0rtnYJltR0UsScc21DSNksMsZs7jXqdehL5Ad4DsCRFCaZFG4lLW
X-Gm-Gg: ASbGncu/8bE5dv8QiYxQOljn3fNQLjqK0MTIbS4zUcbojVJWMsnrqjyq8s8R7k6bSkw
	rj4Sfr/uV51d96MuhZbSxdwW14XuuLnulRvEAQuOvAhVF4YozJAIoJhSgA7SbvpboY+8DGzaWXV
	JdU8IFssJAPUc+CgGBnS6UGmP0dqfmDvs/gi8Mk8nngeWwfFJfN/mkgQQBiw2qtLvSlFzeLzjbO
	eAvKWrHbqY139f7YfoO1BSYLy/bJQ8Dm13z4oTHI5SEOAqs+kfKl4hlZx6wMevs9JaysfKg8PDI
	bkVAFTP6x4igxc7Jm/qynZ7fF+cWkHSn6VfTB8oFz2Y+uiGqr2bHog==
X-Google-Smtp-Source: AGHT+IFd5JclF/LsCSjXAvSzpV4xufYyEcKZ2oP0uvl6RGVWptcpoN13+cyqv8Ie45eYULWn6xTwDg==
X-Received: by 2002:a05:6402:2349:b0:5e4:95fc:d748 with SMTP id 4fb4d7f45d1cf-5ed4349a520mr783779a12.5.1742925146556;
        Tue, 25 Mar 2025 10:52:26 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0cefdcsm8027789a12.58.2025.03.25.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:52:26 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/bitops: Use TZCNT mnemonic in <asm/bitops.h>
Date: Tue, 25 Mar 2025 18:52:01 +0100
Message-ID: <20250325175215.330659-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current minimum required version of binutils is 2.25,
which supports TZCNT instruction mnemonic.

Replace "REP; BSF" in variable__{ffs,ffz}() function
with this proper mnemonic.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 100413aff640..bbaf75ea6703 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -248,7 +248,7 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
 
 static __always_inline unsigned long variable__ffs(unsigned long word)
 {
-	asm("rep; bsf %1,%0"
+	asm("tzcnt %1,%0"
 		: "=r" (word)
 		: ASM_INPUT_RM (word));
 	return word;
@@ -267,7 +267,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 
 static __always_inline unsigned long variable_ffz(unsigned long word)
 {
-	asm("rep; bsf %1,%0"
+	asm("tzcnt %1,%0"
 		: "=r" (word)
 		: "r" (~word));
 	return word;
-- 
2.42.0


