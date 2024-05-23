Return-Path: <linux-kernel+bounces-187477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD80C8CD255
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7983D282013
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272381482EB;
	Thu, 23 May 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nho/kuZV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22011E4A0
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467782; cv=none; b=T7CWI0h2YdNShO671AJ32MXSQZLC6/aI2yL027pcBTeAjNb2V/szZ2dPTCQr2XWYLV2gloKdfCzt5EsSss8kkdtpkFKqo/WcY+iOoMojDJ7+Qfplash6cjDUKYXXqPPPGtKus+KedYr9tRnWCDK5IDJyMr44tj8teyrvptN17QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467782; c=relaxed/simple;
	bh=m6UgnpbMbTrWQXZDKtHkcHfxNFrx8RIBUE5CV8NUdwQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=j4qZDEopgnDLdJOKUFQnC2SObvbcfA+ldsjBDUlGPnQqQzO7mhDQWG3t1HvFA1/ckiRemLYAUIIsKJrjsbdA3bdZJ+DRD6v3dwuJ73Qfl/VsMGh8bKVJNKFzCDkQZR/jAQBwOjXKbGftjaB4Oz8m+08LJgIWchlqIaCfZtmBCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nho/kuZV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so6646485e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716467779; x=1717072579; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8lRq3lXsKaaPmtAV1QU0P9el+kdsmzCNC+w8uH7qfk=;
        b=Nho/kuZVCueIRFvS5mYOvkIpRwRZlavQL01TI2hNjavZRDAhnUQwJ0P/wCZN7AeFQJ
         T10PrUfKxcKbTwjh4MuacTy0gFFAuWbw8A1grJVypC4RY35idwwyEFy0DYd5NsxHz31K
         /f/EeQGwPOxmdZADZXmAq9TkAVCPVXELej/pc8/OkBisZA7d93TSpq0BA3JMW+s5EEL1
         0LOYaKN0rYrU6QuxpSgxvZfxQXsVPDGqp8S5hT8D9tR8EUzt8U9rcbX4bIJKjHrHsMso
         CUhUNIvVtl8bqQmqyi2i/37iGjb/Pijnz1xxgLzSWbll61a2RibPvwIxmtV5ZH3CBJou
         TOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716467779; x=1717072579;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8lRq3lXsKaaPmtAV1QU0P9el+kdsmzCNC+w8uH7qfk=;
        b=JFsgGTwXG5NSr95z4sUbqXyQn1taLo43G7SFsDihV4VU4s9gFyIoE8FDS0BYVevJwl
         yhP3UDDiORCeujnPz9L1aK5jP9YyvibITyxqdojFqmmlyPt5/CM0jLTqxaV+Atck39CF
         4lZowevynn76EtwvP5NGiaAk0uz49MGKIKJmui64Q19OVJXazptefilutTtEHXskDpkc
         SyNczmy2/6g7Qm8sjY9xJXyAE8Jk+mRBpyT/bRGb0bG65Wf5HhFK8Zl31djLx6mrcJNE
         /VNwZ+E43qkg87ZXxr1WZYlZJzanQLbUJSUj31jBkzyPsOZr8JzvNkPnjr6vSD3YZWKr
         RoRw==
X-Forwarded-Encrypted: i=1; AJvYcCWnwGdUx42DKHJk7svRfamREHO/HDV9kCt6HDm5izaTevnyFa96eT8rFQuEHttxzUbspAeamL3Vc0sOKMW7xd9Wjd8pkFPCBCcAqIMh
X-Gm-Message-State: AOJu0Yw4701Kk6YaQu/lKJxrllktMYyO5WE4VFMs76HCg71VXOMCo2ta
	axRRMB7ebgHZEFDp4IlHkz7MoVaXTTWtTOhIgXptwblA5QrvT6km
X-Google-Smtp-Source: AGHT+IGTi2EkzmV53tv/VPuEYvVAiRUh6FoyVlq2SqgaxVOnc556D9mbr1HGWrV7XXHBopeoqrkJ/g==
X-Received: by 2002:a19:7511:0:b0:523:e756:2838 with SMTP id 2adb3069b0e04-526bdc5255fmr2777702e87.39.1716467778569;
        Thu, 23 May 2024 05:36:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578366176e9sm2388421a12.74.2024.05.23.05.36.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2024 05:36:18 -0700 (PDT)
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
Subject: [Patch v3] x86/head/64: remove redundant check on level2_kernel_pgt's _PAGE_PRESENT bit
Date: Thu, 23 May 2024 12:35:39 +0000
Message-Id: <20240523123539.14260-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove a redundant check on kernel code's PMD _PAGE_PRESENT attribute
before fix up.

Current process looks like this:

    pmd in [0, _text)
        unset _PAGE_PRESENT
    pmd in [_text, _end]
        if (_PAGE_PRESENT)
            fix up delta
    pmd in (_end, 512)
        unset _PAGE_PRESENT

level2_kernel_pgt compiled with _PAGE_PRESENT set. The check is
redundant

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
CC: Ingo Molnar <mingo@kernel.org>
CC: Steve Wahl <steve.wahl@hpe.com>

---
v3: refine the change log per kirill's comment
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


