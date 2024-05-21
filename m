Return-Path: <linux-kernel+bounces-185173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B489B8CB18E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EF0B23012
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C83147C79;
	Tue, 21 May 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceYz5xjd"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E81474DF
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306059; cv=none; b=VTobpsnAgluNyZsAH7wByxHw5k1db+aGIDV8ieuI4BCQcoVePQRRlPs9tMpILCSzFuRoSl8b3Pm39qId3kMs5jjNo5SS+kJ9aiZJ987159QwVNbYFW10aM2nKb7oJznpWm275aJlPjm1tP+MDeZaWtv4P8k3tIAZfxtap4W9lb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306059; c=relaxed/simple;
	bh=lD/VvV5cQNmX9lBlY4Rg/253A8Uo2p6wQBL/wkK5+Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UN3QX0Jm8SM1eHJwItBKU44Y0x9f85jy9UCcn0vkdAvc1TsQWU8kJ6gmfZ/Dp9QgVVdUfvyymGuM3IAna6s0raQTE9bMAH9WEemN2o+DbheEfh4vBoPpmDAhF9Jg40RlTuUQMq0LO7DyD+ZHVZIfdOkDybluXdvhQsodbdxmXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceYz5xjd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a352bbd9so1247056866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716306056; x=1716910856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TeellwoKZ0zlrV7V+ziWlsye10PSNVrXFNVzLtw7K9I=;
        b=ceYz5xjdkpA4bB5FMCLvhdX/kQhGOB8SWh5YUzwqe/u59fjehD7Kfn5YWhNqpZnD3p
         O7ZEuYvNrcxYajaK2J0/052Dg+iyviiZqGDZePJ/cbuki04dip9gyi1Wp1a14FAz8mmc
         ujfla/3X1NNudCq4KO3OZBUNqL2bdKnoULJd29O1dsyZ9URxzxHgwDeHavqf66gT959A
         XrECqI5ZIx2gd0hCvTUu9mCwsVAEe1P5NWH09PRYh8jgtD5c9kUycQvLVHkYAyuZKD1W
         tIQJglQD+tEU+xdlH7buVeQ5PR0d0USVTy4X7zYXozncquBS0jNfCnoWzEcb1YU3f4Ou
         N2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306056; x=1716910856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeellwoKZ0zlrV7V+ziWlsye10PSNVrXFNVzLtw7K9I=;
        b=eey+pE7gzOKK6xlusm4Iaq+e+9L6y1VtdTZvZR9FM3IKCXrMEkDWvMQBTpS/e/oSp0
         MgzgR43hZgiWoaxtvoXhc2JaM5SngqXKrwLzrjLp73j5G/epdBGW0ZZG7LaAUTTRMKz3
         eOOF7pF6TZeXdB8ACBAby50O0HnXqZoLG5k0ZgayEPYK6A2JTKkGlQINIc5+/nMrHV74
         xoxD11wXF98qV0kI4YbwlyrNh5k482mM5fBu8+N9rPI4Mwf6WoG7eslZZDrVWNsoztPW
         Z4CIkvYoCa0ew6IT/gmL6PRuDLfpY0MBcPv84WZAdkHGYjDLjusRs93oAHFdI6S6CHNI
         guCA==
X-Forwarded-Encrypted: i=1; AJvYcCVXLO52xhhHjsufbv3iNv+Ko8FGebptCnY0koWWtazEw6f0FJzHNEmlpYKgYKvlNRSrQyByJEaN2K2f8npP2fScOWJj9bpG4LF/Q64y
X-Gm-Message-State: AOJu0Yze+GE9PI2V0e4wYOu4xm2aboPMhn5X/egkl4/p1T4mMC9bgWWZ
	SPOHwvHw29nKxaVrmIE4zBmQVuSLDgG4vOct0kgl+gVtd6yYgn5n
X-Google-Smtp-Source: AGHT+IEZEx9Wz7G4PuQYNRLQPFSeQ9/gTXCPVZ0CMTxzx2nZiD56ar6wcv9+oByUdaWkmSqvIP8zCg==
X-Received: by 2002:a17:906:1f42:b0:a62:196e:ef45 with SMTP id a640c23a62f3a-a62196ef14cmr110706066b.19.1716306055331;
        Tue, 21 May 2024 08:40:55 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7ddfsm1625157966b.121.2024.05.21.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:40:54 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] locking/atomic/x86: Introduce read64_nonatomic macro to x86_32 with cx8
Date: Tue, 21 May 2024 17:40:32 +0200
Message-ID: <20240521154047.47972-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in:

  commit e73c4e34a0e9 ("locking/atomic/x86: Introduce arch_atomic64_read_nonatomic() to x86_32")

the value preload before the cmpxchg loop does not need to be atomic.
Introduce read64_nonatomic macro to load the value from atomic_t
location in a faster non-atomic way and use it in atomic64_cx8_32.S.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/lib/atomic64_cx8_32.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/atomic64_cx8_32.S b/arch/x86/lib/atomic64_cx8_32.S
index 90afb488b396..b2eff07d65e4 100644
--- a/arch/x86/lib/atomic64_cx8_32.S
+++ b/arch/x86/lib/atomic64_cx8_32.S
@@ -16,6 +16,11 @@
 	cmpxchg8b (\reg)
 .endm
 
+.macro read64_nonatomic reg
+	movl (\reg), %eax
+	movl 4(\reg), %edx
+.endm
+
 SYM_FUNC_START(atomic64_read_cx8)
 	read64 %ecx
 	RET
@@ -51,7 +56,7 @@ SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	movl %edx, %edi
 	movl %ecx, %ebp
 
-	read64 %ecx
+	read64_nonatomic %ecx
 1:
 	movl %eax, %ebx
 	movl %edx, %ecx
@@ -79,7 +84,7 @@ addsub_return sub sub sbb
 SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	pushl %ebx
 
-	read64 %esi
+	read64_nonatomic %esi
 1:
 	movl %eax, %ebx
 	movl %edx, %ecx
-- 
2.42.0


