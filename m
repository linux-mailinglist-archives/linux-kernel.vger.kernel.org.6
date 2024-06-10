Return-Path: <linux-kernel+bounces-207741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8FC901B53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB76B23A40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB28A208B0;
	Mon, 10 Jun 2024 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEamhiTa"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64E628
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001207; cv=none; b=l1HOoRj4CM32Wm94xatQ9ahOUQNokXScq4jg/mKQR8dSq+nlmd5LlYilXLumm0Q11U3cnrNuyawmJTRuLHXlpP6zYO4RbKzXU6o++QEyEjo+YBpjfkvWgVy2ArK3j1oHHpK4Vz+ACvxFRmnoO6ntcOi8WjI4ETLLGIlrUhnYqZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001207; c=relaxed/simple;
	bh=3GEEKaNRr4/oruHtaq3+7nIuJ2iAjEYceDiAt+oneM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cpegnbpr0rZqyZpq0MhjKn+PASbCaSkYxdyLFH+m7ceOpB9SPB01T3NKHBcTb4P0eP9MNTWHmuKLRX84LJWabu8K1/imVtBDmlkInnvx6MllI0EERq2e8SYFCTRA6A3D4hD/jBqZw8WxPthCVue29mDg/BTAN4ItFidIc1480Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEamhiTa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42121d27861so35072255e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 23:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718001204; x=1718606004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gK6zqTgKpjlACg4h6HavLGiLDLBpp/UYAUaHXrcTgs=;
        b=EEamhiTagPFDS+1bisWHhNaToQxgVJqFNDomud43LYa/dRBMIw3T527JVtYO0RwUBF
         G3EyDE2Hspvnn4jvfcYXGWG066WFfM5ADbQ4FvHh7c4A1VbsVpPEcg3vGNeDoc36xu2q
         4GhwK7Lipco5YUBP3aemcv9fxtsdN9EdLVaFWTbPbvWCreYpU3ZgSEGq+UyBnzVDReK9
         gfH1biiQXPYZfqfrdjkzoEeY1NVKOphgaQXi7v2bf/9W0P5hJDNqoK4Y5arBonF/uQZp
         kst9w5No6NZ4ckcBfbPq5sECZyNjPpMSQ5Nedd9t8S1M8SLEKzmZx4ji3DiZ6k0cXD9W
         vXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718001204; x=1718606004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gK6zqTgKpjlACg4h6HavLGiLDLBpp/UYAUaHXrcTgs=;
        b=mxR49CAcx3hMwNs4hDjkwhRWtXGTaQ1zUkpe+8n9/LrEOUKx0cVYYlE1mz+grV5zAw
         8uaWiIp8qnir+xeKXLuYnPvQdxML5WfHpTQg9RG+aUjY86XbViYwAkTjVk0j7T0kYAfU
         6cckaqZII/1zxSi834r/1tWnoX7odhtBCyXG6/n1tY+wi1PhtTPxmbF5ErO6Q1ns+moN
         g7wIfR+Dg9ejOw7WXX59Six20ENX7b8vcr0fuLGyqOWRYc37tjgn1cUXJkpCvAdLhTb3
         llG8YSrEmw5w2jsiTTICDvSOh5AT1ePmpfJzeFpoZzIszrMjbhU1QQN9QQKQUdRIsY5i
         lWMg==
X-Forwarded-Encrypted: i=1; AJvYcCUAmonBAsLIJpYB1j3BMqxq9LrohoAQ3zwcsHiwBTbIUFgrCrAdDVGpqYxKCUedJJy/yxxF+FOd7RzVYtOOGp7amVzZ/S+weUKDhoBy
X-Gm-Message-State: AOJu0YzcXe63rmFwXl4Eb3kBxezMMcnl3hOzLx2w49C2uWQTBInCUTS8
	9pynqiIkJdZ24/xyIsKfKCPc8TcMiSlBC2jCxG4uSzKQ441l+BMN
X-Google-Smtp-Source: AGHT+IE4PgCLDptw5Ma68CssX1LOhrsjIOV7PZMFDb+09RpgYoNOthdv8HAHnHZSj2IKK550s9peLA==
X-Received: by 2002:a05:600c:154a:b0:421:7e88:821 with SMTP id 5b1f17b1804b1-4217e883770mr30775375e9.32.1718001203532;
        Sun, 09 Jun 2024 23:33:23 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421e91c47b4sm15246425e9.35.2024.06.09.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:33:23 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH RESEND -tip] x86/percpu: Fix "multiple identical address spaces specified for type" clang warning
Date: Mon, 10 Jun 2024 08:32:52 +0200
Message-ID: <20240610063310.4498-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clang build with named address spaces enabled currently fails with:

error: multiple identical address spaces specified for type [-Werror,-Wduplicate-decl-specifier]

The warning is emitted when accessing const_pcpu_hot structure,
which is already declared in __seg_gs named address space.

Use specialized accessor for __raw_cpu_read_const() instead, avoiding
redeclaring __seg_gs named address space via __raw_cpu_read().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
---
 arch/x86/include/asm/percpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..aeea5c8a17de 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -160,7 +160,10 @@ do {									\
 	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
 } while (0)
 
-#define __raw_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
+#define __raw_cpu_read_const(pcp)					\
+({									\
+	*(typeof(pcp) *)(__force uintptr_t)(&(pcp));			\
+})
 
 #else /* !CONFIG_USE_X86_SEG_SUPPORT: */
 
-- 
2.45.2


