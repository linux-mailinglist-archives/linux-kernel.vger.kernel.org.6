Return-Path: <linux-kernel+bounces-187185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702928CCE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D601C217E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F203413C914;
	Thu, 23 May 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7p4bkBV"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5946AF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453521; cv=none; b=FyoAjAujQy0hBECTFf9W7iFC9HaUomqW77tFqNgTJdO2A/VQ1PhloITtpJrBTyK0mEoYqsexRcXRj/w/jY9LZ4ce4dn4fMPkE+osrd1NoI0G3V7NV/qfKti/Ej3buqTi5znAJ4clKClmbqajcVyfKhMbLPB1EdYyuU/CqT4CUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453521; c=relaxed/simple;
	bh=2DnbGNeUW0lSTQX9F9+cvJ1Q17iPqnIj6m/nEOR0fO8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WyQJgqsEc2O4t9mnIey/NsJwR6qm59Q+dicSXKTXsRLC3+ZSe/TESUTkREX9GyXuDDm3gSZvGLNcIyldZG8yB4MC3o2UJqUarVZastb5HgVqAH4oovtyYT0BinN9UnShaXTThSR0ifhHW92ZwiIIQF+Oa4VVXGZPO+ferGjzV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7p4bkBV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e428242a38so108449991fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716453518; x=1717058318; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+IfxCQKHgdpqayrcGkCebIoovoMyjlXzAhylrymxYs=;
        b=P7p4bkBVBFSgowO/BZDRPwbYPznf0Iqh9rbIQ8Ro+iVDJoMHuKCVCN/kOUZQCAscf0
         vpOsPOJM7i9N15OUppUCO5tnRfKK/QCZvvEinYIiHLhbOBNiExrK/ZwKvkHJV9/+6s+2
         oUfb2OZrbG4znrX5EuWTwYCxxANL1xedat361Ju81yg9kyOzBTNdcYp54pX67w1hSzD9
         pyTkcUmYAH1vhoQB6Qa7zEe8NjSSuHp6IM9s9C6VqelvSSGeBhTzcZPkey8Ai/YM3S4B
         0k/kVer2IfaRTvpP2NIZ2b/hYXn8YiD7V/6xZx4Du2OXHlw7kyLQP3j2uRXz31YovDfZ
         KgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716453518; x=1717058318;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+IfxCQKHgdpqayrcGkCebIoovoMyjlXzAhylrymxYs=;
        b=os6gf2QgTaYsDLnwcmTgwDeckgyhJO1+93yLrVfZ9k50A9EIRP48vcs2ZbXnd70Os4
         cPJo0G0Ct12rzsaHU1jylqKGgzzB4tqoExbj5sLN+3aLmYRg3nDC6Yc7K5tOzdaAz/0Q
         nvuAI2gBWUCcgju0p7j2961UnJXsqd+3MQ/sk0Qe8K1vI81jyowAE8D/EwW1ZucPGZfX
         4WjpdKhX923PJubjKb4C4Cj+IFrHIRWoK4syjplg/mgZo22tO+ZAWmm7JKQc2+vzzQC5
         QCjIubyMs4rXDYzMAARgiKO1KVeswnOWR+JyiVTMaNJh+eHL63VR78+lt5mbUkLWQEJa
         JGpA==
X-Forwarded-Encrypted: i=1; AJvYcCXHJJh+tNatXfyP+vUU+dQ4j5zjmKlr7vJ9tiWZki5G3BRRWPM2GySr8MPs44KAH9GjLhACAI3EAy5NOXHUXJ2BBOnHbcSyzbaXCbHi
X-Gm-Message-State: AOJu0Yx1V8YCwQIsY/7c0OHWdBbG2s1bY6LTBHIpJHzJFmXHgx1ZKZiF
	Q8Th4YvrIEVZ/MP8N6kWcSN2cXUi8LTritlenSfdJgQsxFrJnDpB
X-Google-Smtp-Source: AGHT+IGrwaCwqrnB+RJXN11CZWo4LGz/prpwCmDh8L7GoYjkPsW/bHLRvKd/2z1j7SFLnbG1JGrrwA==
X-Received: by 2002:a2e:2c16:0:b0:2e0:6313:fe3a with SMTP id 38308e7fff4ca-2e949540d05mr35003951fa.35.1716453517388;
        Thu, 23 May 2024 01:38:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a51eea36dsm1655552466b.58.2024.05.23.01.38.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2024 01:38:36 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Steve Wahl <steve.wahl@hpe.com>
Subject: [Patch v2] x86/head/64: remove redundant check on level2_kernel_pgt's _PAGE_PRESENT bit
Date: Thu, 23 May 2024 08:37:52 +0000
Message-Id: <20240523083752.11426-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch tries to remove a redundant check on kernel code's PMD
_PAGE_PRESENT attribute before fix up.

Current process looks like this:

    pmd in [0, _text)
        unset _PAGE_PRESENT
    pmd in [_text, _end]
        if (_PAGE_PRESENT)
            fix up delta
    pmd in (_end, 512)
        unset _PAGE_PRESENT

Since we have compiled in _PAGE_PRESENT in this page table, it is not
necessary to check _PAGE_PRESENT again before fixing up delta

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
CC: Ingo Molnar <mingo@kernel.org>
CC: Steve Wahl <steve.wahl@hpe.com>

---
v2: adjust the change log to emphasize the redundant check
---
 arch/x86/kernel/head64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0724d1..bac33ec19aa2 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -260,8 +260,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* fixup pages that are part of the kernel image */
 	for (; i <= pmd_index((unsigned long)_end); i++)
-		if (pmd[i] & _PAGE_PRESENT)
-			pmd[i] += load_delta;
+		pmd[i] += load_delta;
 
 	/* invalidate pages after the kernel image */
 	for (; i < PTRS_PER_PMD; i++)
-- 
2.34.1


