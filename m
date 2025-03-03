Return-Path: <linux-kernel+bounces-542382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9878A4C917
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1CD1782EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E58260398;
	Mon,  3 Mar 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgtPtWl2"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16525FA37
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020815; cv=none; b=ZW51zS8galFsuhxUUUH1Rcjydbhv9pN5HKZHBo15IGQt4PPbcf8TVxV6Dx7FYe9ehlX0I4BWq2WXb71PV/eSY8x1nwp3HZC76rz4AZpxcouZprV/+tWMufNy241r3MvIPj3UDJmsqqMmM7sg+9y0aWbspRleTiAqCCxw/6NXzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020815; c=relaxed/simple;
	bh=06vTaM7HaBP9okDJnr14KC6PDjelCZttFmu/VK1ruJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kuij/N+6wAa0DfhfyyICfmZlHTEbRO1SHEAMeJMY8rr1R74L1Hvo5xNiHV+Nnj/b+dZfBCsvmH4Q4pVYRimVEa4POj+Weu0/aXM6KFVHodBCM69Z4lHZ/bOTqd9hbI6LSkBWsMrLOnU6CsIQL8GkmyuzB3epCSNd0+RAbgTNI6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgtPtWl2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd420f82e2so66102886d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020812; x=1741625612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4xtjojYc6P0PlWvEYiKTJXNUUZ/ZAA/9CxpmtDG08o=;
        b=cgtPtWl2sEkfQawG9qLvqXxma8bTmSVlVEUN7Di9et6GB+h1FHslYW/RhEb42fWBZQ
         fOqbLVpYVQjjVsZQUU6/JyrAXMUaDJEEywURWFKUKH2kw1e9a/WqNkgcnYXESrMJ/LgV
         nsmRYDFgab4uIxBeXbL+fca6wekJlD8OmLgx6Io8TK+F4sHVGKOrIVhpSQrPpPvhwPJt
         1gOkJOmKJoOYAVOyoMAVMlPhCfn96jdJTHZQAJ9uz+GVTaWudCG7KzCQ+TueXDlGgJa7
         rTc85s67scG6oyhTnuXCa+wtboye0+z4iejG3WvE7+v2GsVy4QafnH/4ryosTK+bY200
         BTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020812; x=1741625612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4xtjojYc6P0PlWvEYiKTJXNUUZ/ZAA/9CxpmtDG08o=;
        b=h8kuRJgM650JhZsS0xH0YF9+Cp54aOuYqS9e5wjKB+kZQjYFSWdinzKzBo07pXo7y4
         U7xUeodV7uKWh9XbYam+lTzf9kODQASm65AnBLwbMvQPB+Y6yzVl3trD9vxAUxtmTnyR
         LP98iTXb9TISPsBUChUco96X4gL+2Lj1Wa9o+p/Si9/+MXm63WWLTla+oEOCFubD1MkV
         Vs4jJy4SDv7qvJb02CjrWCAOrWAeKO3omucYwGkGwsaG/Sv5ekzuA9xAKxPRfFE7GoAa
         qICvQTUS2RVPfbgcjPOVFNUYUfi0oe4K80n1f7gCqESBPpnvOxfqY8aDSwelew/KiiXw
         SvAg==
X-Gm-Message-State: AOJu0YzFkA22jlHkc3DxSixX3QVAZRDby2VhWVAg48j5i4wZto7PYqeV
	iqSKfFtiaNkp9ahk/bxNsjq+uaQN+YiR/JOGdwf+ctfTFsHw8HTpsx5N
X-Gm-Gg: ASbGnctcewl/IF4KBWT21v+hz/b4FUaFHd6W2S/UmAkGbht3LAbzkav+omJ0ewu4ZN9
	4N3hVXh1zLoPVNOBapSF1icxM5rmX0xctNYCIOKUX+Qo4zq9CmH4kR2DmxLc1YBwWF4Q5kEb+v3
	cYp+FlF9oAItE/nqIE79iD5TkSA34GYJzmEIcxIIq5av+0gUPgM0Uja2FpPs8XTX4chMZu/RAdW
	mVyzZN1x9twEoM5UsCuBjHeR1Zvd/LbvpCj2DmAf6nReZHFiPcPb9HNaMnGuEhGbhr0bH/MBQo8
	WTTRa0WPHajqOeSv0QphKadiyA==
X-Google-Smtp-Source: AGHT+IEYE5cFUiLtXqat9nxpR923QMPswei83U+8MlDcXO/t+prqkhRskS787ORdMRfS4mxYxouMuw==
X-Received: by 2002:ad4:5ec9:0:b0:6d4:c6d:17fe with SMTP id 6a1803df08f44-6e8a0d066f7mr248820926d6.25.1741020811718;
        Mon, 03 Mar 2025 08:53:31 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:30 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 11/11] x86/smp: Move this_cpu_off to percpu hot section
Date: Mon,  3 Mar 2025 11:52:46 -0500
Message-ID: <20250303165246.2175811-12-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h  | 2 +-
 arch/x86/kernel/setup_percpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 6fbb52abb594..4f202cdd503d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -584,7 +584,7 @@ do {									\
 #include <asm-generic/percpu.h>
 
 /* We can use this directly for local CPU (faster). */
-DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 175afc3ffb12..bfa48e7a32a2 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,7 +26,7 @@
 DEFINE_PER_CPU_CACHE_HOT(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
 unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
-- 
2.48.1


