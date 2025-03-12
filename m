Return-Path: <linux-kernel+bounces-557714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520DA5DCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010691897553
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107DF243379;
	Wed, 12 Mar 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q22eZFYo"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A643398A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783134; cv=none; b=h/gn2O4xLpdPjH0c/UlD+VHsVrwFUjNp6/XAykc/6y6+DpWrs215FncGjQV/Bw+z+z846cE2sRfQka7kRIU5GGHpaVqYU6ckSTl029q5Yrzx5/vtwZvUIz4wNH0Jypohb1965RmS9Pye88Ue/eMIaGi6gML1usVLJhzk9t+xLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783134; c=relaxed/simple;
	bh=vd3c1IZPGJlxnIHsIcVv8VJvhpnm9yl2/DJkXH8YbIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCQDdX/QNIK+5efkUZzVWvX9NhGvNJi1PGE4fvIaNPUPTbJ2Bg7AlDvptFIdeqNsInF2nY5/VxH016FUePpVUkx7ympFNqNTv3CefuiEDeVOp4n89XIfB/Mlen3VjTr8OgFHWJ7mWuHWzG9XsEzpHn4d3ZkWe4/E50Bm7j/vy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q22eZFYo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so12287941a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741783131; x=1742387931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w88DaH1Fvhv99WXffAKIm9FUiu/4JSuvF0T304l8kk=;
        b=Q22eZFYovo8y5+hTMvN1zhASUz1ys6AjweL5jLuLR6B/ojCFV9HkhJsyMzYJa7pzgA
         JXKl/qAJr6bg7D8EifW94TT3RrdesAdQhiQwmW+IDpmqdzu/zHrIlFygvPjoc8dUnbRZ
         l01DZLeSDTiBa9+Us0oTo8FZu3rDO04pPYRZgkn3hJ60TcJ7x5as/+CGwRNACO5I31yZ
         2i3hWN0yDmf2ZOIrvO7Zox50bu/7Gkjx8oG2d3oKtNF+JHas1lLYGscbwudOKomfw39f
         U80z8TJEZgxIzwCJWa/KJm/dSzaJSSh1M1fKS47J/ZBAmYf4SO7TLmQBXfnWs9diq/NU
         nukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783131; x=1742387931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w88DaH1Fvhv99WXffAKIm9FUiu/4JSuvF0T304l8kk=;
        b=hM9EgQuyAUa/wRBW88+7jL5PLgkqOqMgv5hY976GSGIwqQWsliACovG5l11dT1ixkE
         prvesR5IQnZ5Od6ufCG0DP0AA8Wp32Gz21gLSy2QRnBfSIlDkSNoTY3NJygQ0ZLTcJDY
         +Ensxiv7R48G2PH3YzZPwA/KD7jExYudzbJPdCo2NytLZbmB+TIwon8La1SL2umoJ9UJ
         TKDDSHygAvjcTfwdKzpGi+884EkkSFj56mslvFvvwsjcSUd5ErYDBS5hdEEo+g9JYwN0
         SeaYuBg5dkEVx61P/VKc63hZdlkD35ax47pPUimGrZa9K6LN0646L2Z7qbJTZS2kRIWl
         m2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOWMHrBNJRhQqV/gzdT1Aaz3kpf2bkocb4YdB6wjmWLyod5oFL3ihvwmFyIK4fvL6a53dKDwp3jHZQAmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09k7/d6ESfBSDIBMScGWgC8DsfAcIX1h6IL15FNpTChxfy7J8
	3DqTo/NqiNUjsPK4/kQ22lmjA2JlJgOMdq5ARqfGK3S2scWWVAqf
X-Gm-Gg: ASbGnctI5p6t2i3XO6y6Ml3ABlAk7d2eL6wQBSz2MIxPO4L4o95VTza02i55pggCwUa
	0Qd+Ap0XkerYk4h63J/Dmwh+KrX2rQS2Qy/+c9cTTB+ILyWIrYUZ9XxPuL9HIKEFJxoybEjn+1l
	mQ2OGiF/yQRb6cqTo46cbewtIj0f95hiBv6ZX04y8Oq87UruhLk99aZaAe19aXN+PpdIF+T+m2/
	JGRObQcLQPcd1gzD1j0cDD4tW3N55X7mwOjt3ryqEP9noW3eAXY6i17V3YGdzd8cf7oChc+i9XH
	V8VmfeYJvboNbjNu9IJbUDi5dbdsLEi5Akv4
X-Google-Smtp-Source: AGHT+IEigzJ1YCuuGvXnvrqDKW40268NY4iw4dbTWTWS6DNrFBoJ6QIEeJ1Z4qZbXUVr5C+vP6oTmw==
X-Received: by 2002:a05:6402:254d:b0:5de:dfd0:9d20 with SMTP id 4fb4d7f45d1cf-5e5e24ad82emr27695422a12.24.1741783130861;
        Wed, 12 Mar 2025 05:38:50 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f4c3sm10077100a12.14.2025.03.12.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:38:50 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 2/3] x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()
Date: Wed, 12 Mar 2025 13:38:44 +0100
Message-ID: <20250312123905.149298-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312123905.149298-1-ubizjak@gmail.com>
References: <20250312123905.149298-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
instruction from being scheduled before the frame pointer gets set
up by the containing function. This unconstrained scheduling might
cause objtool to print a "call without frame pointer save/setup"
warning. Current versions of compilers don't seem to trigger this
condition, but without this constraint there's nothing to prevent
the compiler from scheduling the insn in front of frame creation.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: Expand ASM_CALL_CONSTRANT commit message to mention that
    current compilers don't schedule insn before freame creation.
v3: Split patch into three separate patches.
---
 arch/x86/include/asm/arch_hweight.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index a11bb841c434..f233eb00f41f 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -17,7 +17,7 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 	unsigned int res;
 
 	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
-			 : [cnt] "=" REG_OUT (res)
+			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
 	return res;
@@ -45,7 +45,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	unsigned long res;
 
 	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
-			 : [cnt] "=" REG_OUT (res)
+			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
 	return res;
-- 
2.48.1


