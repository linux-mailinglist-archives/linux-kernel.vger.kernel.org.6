Return-Path: <linux-kernel+bounces-185174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FB98CB18F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A1B1C21A59
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC41482E4;
	Tue, 21 May 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrL65rz1"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2378289
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306059; cv=none; b=FStuaec3MbMG536wp0VobS1Hb3q6Uq4nCvg7h2bOa/NpGdJ4K9Odk4OrPObF3LIbdvwNPGscz0zxstMT3UF6QsSLO05V/sz54NAakwbszWHetLq5VsXDzQZcQ00G3iqYdvpooNceuKgZkrsKPDmrkiQP1V58Qe5xpP2aXqfk+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306059; c=relaxed/simple;
	bh=5QY5pCKyodXCSWYUDdOpsPjnRNF7cN6ofBZZxKuLfzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYbqV8jZm5YY1gLUbIwZuLFV8ZqotBI3U36Z7rEbnLYR+ZUIEGqjeuj+1106ri5t+UJDszBH4jLbpLNyj+wLOhnx536BR66WBxGiDHou9Q9W0+0nX5vqPi5FCycdGM8cRy2q0av55deHYWUiAJu8xm/faL4/5cLy8D5AmDGDQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrL65rz1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5d67064885so418704466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716306056; x=1716910856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLHG6dPtj3Cex6vJDN4EiASkGZtmU8H4G5lGm1pnEKs=;
        b=TrL65rz1BYBDBuJgX3CSVYzAg70qPbGt45kBkOOhw43KetRlF5qTyjSVwsaveyvi4V
         5d11pQPWipywyG4ewLUB7ObUBHDNSYTN1Am0PblWmLeJ1rcwONwi9dJTo0n8e9DojISG
         /cKpN5/O7KDFlEKZgTCZd7svgWMKF1scwby+WiYCsExVRSUqN4uM3TPb8KyuL5rHbk4q
         LSZO6ZZoFMQOpP2OGtOx75+QIM01txk6m/6BUE/t/3ebxWlUndws4cdwFTKRPa6Z4W+J
         USy06bhDejllFMuT+Dm3xhAi62pNiM7RAf6+FHcFmKFmb619bU/S7KCzT2IRk0zblwV/
         o39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306056; x=1716910856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLHG6dPtj3Cex6vJDN4EiASkGZtmU8H4G5lGm1pnEKs=;
        b=kYX/VoqGnPBkaKxY61+xhT7ODmKb0hKb1wLx0S8qvaONW4KTPNLdDCOZQFzw6Gis3m
         T8u9of98yMsAd+WEMGtrwc4A3jb64rEgSjrEs0QxFoI5/7pdFq9sUzXJeU3Eo4sgYb9c
         LZ5bPOknlRVpN9VQDaJGgnWOEeuGjuTU0+W6fz8vtpJXRluYT5Dgzm5lkep34Dqvpjc0
         GBUv2w0rvHRLVyYQMoHeTblqQroabJZlaNb3HGjusUcj0CAW2nx0f7PikuVc+Upl8JPg
         A7sPWZMK0evDdghRroUaMwg5d/6TjbmjAxtE0og9izQh+3nmq/+Rtu+a+zBXuiOEStel
         lQmg==
X-Forwarded-Encrypted: i=1; AJvYcCUbuBSOO8s0l6FYs6xlNBEuPpd9KTrfiSzM0dClpQJQJBuItk6/AbIycKZPTc/E/ItPSwrDu5a8wS9s64EQGVzOdBEgMWUS+RIsQ1v5
X-Gm-Message-State: AOJu0YzwvD3gkgFiun/qmqXOmUONI8B8qWk78YrITJR5qIC4vijOxuUs
	pcWf/L7UyhZeu2Ec6fACbLLxVEaGHk/UBncO8LsMYC9fr56LpWm4
X-Google-Smtp-Source: AGHT+IG6WUwlwgfkhJ7ynu4TuZA2J6cPdvi1E1eAo+HmeWoHdX6mDiaaWLi2MMc4ZYpc6wz70kqSMA==
X-Received: by 2002:a17:907:9446:b0:a59:afdd:590a with SMTP id a640c23a62f3a-a5a2d65d66dmr3819661366b.56.1716306056134;
        Tue, 21 May 2024 08:40:56 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7ddfsm1625157966b.121.2024.05.21.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:40:55 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] locking/atomic/x86: Redeclare x86_32 arch_atomic64_{add,sub}() as void
Date: Tue, 21 May 2024 17:40:33 +0200
Message-ID: <20240521154047.47972-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240521154047.47972-1-ubizjak@gmail.com>
References: <20240521154047.47972-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the return type of x86_32 arch_atomic64_add() and
arch_atomic64_sub() functions to void and remove redundant return.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/atomic64_32.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 8db2ec4d6cda..1f650b4dde50 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -163,20 +163,18 @@ static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 }
 #define arch_atomic64_dec_return arch_atomic64_dec_return
 
-static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
 			       ASM_NO_INPUT_CLOBBER("memory"));
-	return i;
 }
 
-static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
 			       ASM_NO_INPUT_CLOBBER("memory"));
-	return i;
 }
 
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
-- 
2.42.0


