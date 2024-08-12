Return-Path: <linux-kernel+bounces-283038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C475494EC39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC67B21D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC26117A93F;
	Mon, 12 Aug 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRfgxWuk"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D817A588
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464007; cv=none; b=VcmMJ4clfGvxY6mSsME7ANrUrDZDA+z0SGP0yWLS6XkFTYytyOReCshgn1jdNDHNNPH79ebQ17ae4Eht2Abjxeal/57RQFQsA421hnUCVfs6S6EUXMx+82mqW0WhUEHQAF/kn7XK6U1+NjXnrLr4Go4r1J34vMHMGZkI4OL9+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464007; c=relaxed/simple;
	bh=tA4SiORwu8uHyYqQ7ye+y4E02/avmDo7X6E7ktKohLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av7sLEjtkDG7fShI+dPLz2PRJDQFzGaP3LeWL/BacmCVXkW2V2KZnFMHxM+zpQKt/JfR/+Yis9oUlDKkbbCycd0qpoM4rVCeA9xvPBTmS9cxx8qHUb1IiaGGINQh7ssDxUCGchY/anMcBCXkYB3DW4qN+o0TzSGJzotub4kHHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRfgxWuk; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f15790b472so53121211fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723464003; x=1724068803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3uJRiNLLgOcZsmmzORMPDWc5fHy9y5CyFJXSzVXE+M=;
        b=nRfgxWukfDLNKufVHZI6iJodcBMcQErIl3eoV2XyxlbIYJuHlkUXpk1p7cXupZISXc
         A7vdX/jNOKDmXYf92+E2SWeyX4uOejhbeh3jq9Jipr4I5Xgo1yI6vs+m75rvuhg1mkNw
         p9NjXNgMROXyOGoSPw9JJirOEfGvi96s3I4PQiS4R3NYC7GqBAdOBbKXak8+ZTMPEEH/
         2essmTPuVn7+6n44NeZHPWmNSfW/ihYHaL/TtlZDryYYNrz8fQ7hknLkjCe0FmPgA/j5
         320oAjoHYFdhWKjvD6Ngsp35EKTGkQUE8vrzGc2vTjJXXNDwJHBqCMkOHSxXrSB+MGvM
         D4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723464003; x=1724068803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3uJRiNLLgOcZsmmzORMPDWc5fHy9y5CyFJXSzVXE+M=;
        b=LLYF69Ya/E2KYuqMWHs5FOdpVef8Fd+Wj8JPECtCPPHGyTtaesnv7yZq+XhDz3UKd6
         G31TxjbCoj5ZUgWBCdjP18wBwoum9ntQz48pxOvqI3dSeZf/7SCqAVOWOJQ7XsRyHob1
         YlhTQciSUYLbdcss51SSbscM5L6vovcK2PN/8Wwn4OUNhLdX2au8Gwyo4HR3/Cb95+we
         ECHNfJQ2WTF7pZhn2c5UEYbH6aAvvuMz9eC23v7RSeLFshHCb78sa1hrOiwDx1R9WauB
         K629xzataxvw1xZIXkf0DkGsXAu1F5VDYTS0YPKBKy4RnDJeDqH1H3rZm5QOCYACBgQT
         ttOw==
X-Forwarded-Encrypted: i=1; AJvYcCV+RUgPuCL5k+oCY5P7bHqgwbOeaIiJ4RIllm2+9V8ZAJ9Zjfi07Ltni3q81JwJyB6dBTGzC1ShzJQzM0Faoc+GSx7tBzsnp18zZ+ku
X-Gm-Message-State: AOJu0Yx1fTUpThJ76O2WE4QckMb5wopzoK9EzgXmGpxEuj8jhrD1MswA
	nyhYrc6UzLwpSEEeTWlY0LNvAlWv7yCYDxxfsd+V0SYiZEtD7zJm
X-Google-Smtp-Source: AGHT+IHKlXKj0B7JY5kmC2Q2zZaBnmA29zjjoQCSZ3jusm9LFJTTfxdKLemTAAxWJakoGZgPOzvHiQ==
X-Received: by 2002:a05:651c:545:b0:2ef:c281:54f7 with SMTP id 38308e7fff4ca-2f1a6cf52a4mr60754621fa.37.1723464002929;
        Mon, 12 Aug 2024 05:00:02 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e04aesm2055970a12.76.2024.08.12.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:00:01 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH v2 4/4] percpu/x86: Enable strict percpu checks via named AS qualifiers
Date: Mon, 12 Aug 2024 13:57:38 +0200
Message-ID: <20240812115945.484051-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812115945.484051-1-ubizjak@gmail.com>
References: <20240812115945.484051-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare percpu variables in __seg_gs/__seg_fs named AS and keep
them named AS qualified until they are dereferenced with percpu
accessor. This approach enables various compiler check
for cross-namespace variable assignments.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/x86/include/asm/percpu.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 4ab4ad60d767..b54119398c4b 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -95,9 +95,18 @@
 
 #endif /* CONFIG_SMP */
 
-#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+#if defined(CONFIG_USE_X86_SEG_SUPPORT) && defined(CONFIG_CC_HAS_TYPEOF_UNQUAL)
+# define __my_cpu_type(var)	typeof(var)
+# define __my_cpu_ptr(ptr)	(ptr)
+# define __my_cpu_var(var)	(var)
+
+# define __per_cpu_qual		__percpu_seg_override
+#else
+# define __my_cpu_type(var)	typeof(var) __percpu_seg_override
+# define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
+# define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+#endif
+
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
-- 
2.46.0


