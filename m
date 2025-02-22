Return-Path: <linux-kernel+bounces-527434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9155AA40B23
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BDB3B7AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55142215177;
	Sat, 22 Feb 2025 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh6AU6Nw"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D8215076
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251222; cv=none; b=PP12En1pQoomIPEB2gnX3qX8Vihnc0v8FGMFVKNIfCCw5LjtG4MRxuqHs9zLiwFXGCsbZuqqSxPIQEwExGPYzK07z+Mej8vC1KH+bWt3nYqu3nZg2fuAwahsEEpl3P6uFtBYzXTQOpNb+pviVzl+KNmt0mY2pVG7l5/Rls5ZkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251222; c=relaxed/simple;
	bh=X8MAwkoRH0yXAmQO/36vaJ4i6hRN9Fj5GOq28mCWY5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0K+zPuKFEq2snQHtlH4C9fwRJp+oO3VIcNGiJrmFIJl7ecfp45h+JRMG+68cAnCYYvDheoT4Nt/6dZDLGzv+7IHMjSBRcvBPQ02ypwj6+vi6ZZgKXyUND6R8M6QoX04yXVwl7UGh9hIkCE7WpvbtiRGcMNH5opQgOmdGlJfNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh6AU6Nw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0892e4b19so381121885a.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251220; x=1740856020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o/duRurpHnQEbVsb8P75VsPCfHKRQsuOowLrKQw3bQ=;
        b=Eh6AU6NwEH/auz7h1KyxZYqxddDpPvi07gAmUZX2d9KAEJZG8HSIf55jLrloG1inEH
         /wIBmVqConzyaiHOQNdNe51lJdXnOSTz6FMqyLtLfniQ0eJO8lJo6RFYp1bfp9seSoEK
         5EvjAi4jp1Ul+FnsNdW2OhD7Tm1HeVmIRN9zs7LY+cAa0q2FYUGF7cc+L2OqneE7KFSO
         tZlRxZO2l0oQqJQcnWOV38Kufy/dgXyzKAn8YG6vsgcOrqL7CLL7L6BoM/K9N0FuYu7W
         G09jXp6QCgt+oRZHoq0E/6h/wP02vpXnMWeEzrbrCnrF5O5+MCQFWM3Xb7wdQ58tnCbu
         JPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251220; x=1740856020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o/duRurpHnQEbVsb8P75VsPCfHKRQsuOowLrKQw3bQ=;
        b=MLn4g/uSkVowCIi27F/l+erIzyzyN4IhouCUIapWgN3gCiUJmi1SoDwmTr7b44PZ0z
         ZxhEBD7AcRRkz59JjQSc5p+HwfJJ2cB6qRqf9YQo5GE5SqINIapI1/XbsIVcbM6F/b6H
         x3XHf6sTltwXprOj4Cu4qRCrHz1/9zUyph5728ql2LAEdQGF0PFdLG3G1Y6LsTIBF/30
         orycMVSs1hDRheZjoKzvHGIxjc/4rr10nJoPQWAHzYDFU/Qr7nyjrkbL5AfZPubhXq32
         T+4Tg0oWcbaj0Rn2xuh4sxAR7UNVb7LJQWs0SIoSOWspBPDeEK8DZ0/NHJfugegUBsrU
         QAvw==
X-Gm-Message-State: AOJu0YycWnywNGSblnw+sZu6BonZKDyfGgctPztlJ/3jvbqIhWGEoPrL
	AGIRn6CJ2rSfmP+4TXNjiLKVayHUU1Yhx63Bx6OETNa1YQ+s2WonUGXx
X-Gm-Gg: ASbGncsq/MIFRMww6dAxYXOQUI9eL+K0F6hSbarf01Hib5oBpGb11LP0bhLbVhh4VVS
	LsdZ4CMvCfmB1cU2y1pzozyJPJNWOzsevTxNtfmFUBl/a4+svn+y0W2FzU9Y3RVsR4vGlKrhhgx
	3QEfPEGQvGQNkbudSoo6JipEYpX7iqVsRLxLg9FTknqaVTQkH4hh2ZnI6iGjJH5VZltzgbNQZxl
	8h11YG+1rLVzCvmAfRLTtbKaDDdQ3nazXB4/O8uBXAeb4wAsUag8OJl7DNRHJ85g2qY6Gvnlsrr
	ysS8B+w=
X-Google-Smtp-Source: AGHT+IEN9Oft8opTgV3t5xrlwmgByvZQSwsi59N/jdqt8UilfHYnK/teAp5I297RXJw4NsWcEV1eKg==
X-Received: by 2002:a05:620a:4891:b0:7c0:a1ca:93b6 with SMTP id af79cd13be357-7c0cef7b052mr1176808485a.50.1740251219662;
        Sat, 22 Feb 2025 11:06:59 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:58 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 11/11] x86/smp: Move this_cpu_off to percpu hot section
Date: Sat, 22 Feb 2025 14:06:23 -0500
Message-ID: <20250222190623.262689-12-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
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
index 370778c55091..e8034fe81ec1 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -595,7 +595,7 @@ do {									\
 #include <asm-generic/percpu.h>
 
 /* We can use this directly for local CPU (faster). */
-DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DECLARE_PER_CPU_HOT(unsigned long, this_cpu_off);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 0ea3443433c5..11a81e2a9675 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,7 +26,7 @@
 DEFINE_PER_CPU_HOT(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DEFINE_PER_CPU_HOT(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
 unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
-- 
2.48.1


