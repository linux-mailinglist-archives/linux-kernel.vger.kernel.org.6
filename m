Return-Path: <linux-kernel+bounces-393870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0019BA68C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 17:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D58B212DB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C617E187342;
	Sun,  3 Nov 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO9wxE+u"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800287081E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650207; cv=none; b=cldhGel+D3wP0sapP9TJjSqUEFUMW3AAv1vKDh53+OnvkpmFmdihv1y5ykuCvqPQAISie5IDYjyX65oI8Ni5O58eTIfGee5q+MVQQ5/Tr0f+O8qCIFX1L96gvW+YdqutzHpApcFI4IYH8L6Fkx4KFQRW0d8nWWO9ZGaw87GXqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650207; c=relaxed/simple;
	bh=jgXDDY66xkwZqnx0PKdy+koUfHv7eGgknvbyo6DKg5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqMJmYP4u2N/ZkoJzRt32diJieojwtz5kmGysR/D5zU/X3vUKOcwqr9Lnip1hnomN+JBp2UrXndA0m4DmzlcD/FEw5HuIu9gWed34i59soysCYdt2qD5Ggo2PXYdT5fKXbEUfORJkXcdvc5xkosJp47Wd+QK0PQcRQAm9I4jyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO9wxE+u; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9aa8895facso607218866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730650204; x=1731255004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRmjyqqk2ptbrhD8Vj667D+8j73hKmf+jVIUfqeNMvA=;
        b=gO9wxE+uMWwxYlO5kDfOYcPAXBso3zZ7lYw4+VyV1jvQVoADB83h7msBTqOiaK1dRd
         awAiwin9TSLuiB64+XDqexC1vXVdo+WQK6T1LwcBQyKxbphTeK4kchZFKjZ/Rw9Czp/l
         yIDhcx827U1AFMJOsrGI7vO1gzXWk0MPycG/IY7tGZxzIJXR9n8pjenXyfYbVTI2oxp/
         4qmQAjoyc/kRXYSEnLSbUhLRH90xbvtsRw5fRKfCTl7rnWJ0pxHOa9qqkMi7QZmqjYi+
         cjvqhkf81ES/SyyN+Fj8804J09K6sWUVmeEYmngRqQ2FR8GMYew5/834s+ekOUo/AbvF
         w1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730650204; x=1731255004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRmjyqqk2ptbrhD8Vj667D+8j73hKmf+jVIUfqeNMvA=;
        b=uIhwaXWW/B1TZ9C3ILqo2HCJ1TSMjqCfi4DHBcJI0eHa/URnBFBlDfn4uABX9hlICT
         oSxRRgw8nnrRoFy/3D0V5bb7R7D4FiSmPg+HYvk4sTc9l3vzR59I1A3TsADRud3wuw5h
         q+JF7l6on63lKVRscsgpQgrVdvRuguhUIFyfNYrihSWXKdCUxJC0zydC1OcVithy729G
         m6cEr9WFsFLfVFWBaf+n4PRmwypOc3pL3AIxtvLpeQtCMMNHmbnrM0cuJbsGr+49zZ/s
         ehlG4Y3Ak0Ib8Yla02dSnNdo6m876WuXoQepiu2RxSlUISSt+kxi1Oe6BX5vVUXPB0RC
         302A==
X-Forwarded-Encrypted: i=1; AJvYcCVJCG0XAgJ4lIsFXPcdQvC+becT+Jd0cs/v32XHfZfRxhQHhBvbvkUO1vw+OEJrVrGJYdShJFvgv2bk95g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFIEfyT5KarXvDAc3qV5ACWcf3YVmZXIZEP9Ua7AKmVJpjiGF
	PCMHhUtjE6ggwefsfUYE6d7DqRnhXDZlRRCTKSsoVKwdEr0dSbb7Qt/lq3W2
X-Google-Smtp-Source: AGHT+IFLpz46qvYN1MbfUy2BVb5GiF9Mv5JW0iKMTOJt2+aP5nU57ThzoFDB+UgtDVYxEP9SMQbMHg==
X-Received: by 2002:a17:906:f5a8:b0:a99:f0cf:f571 with SMTP id a640c23a62f3a-a9de5f6ddb5mr2877083566b.33.1730650203521;
        Sun, 03 Nov 2024 08:10:03 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e0a84sm435718766b.138.2024.11.03.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 08:10:02 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Beulich <JBeulich@suse.com>
Subject: [PATCH RESEND 1/2] locking/atomic/x86: Use ALT_OUTPUT_SP() for __alternative_atomic64()
Date: Sun,  3 Nov 2024 17:09:31 +0100
Message-ID: <20241103160954.3329-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_X86_CMPXCHG64 variant of x86_32 __alternative_atomic64()
macro uses CALL instruction inside asm statement. Use
ALT_OUTPUT_SP() macro to add required dependence on %esp register.

Fixes: 819165fb34b9 ("x86: Adjust asm constraints in atomic64 wrappers")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Beulich <JBeulich@suse.com>
---
 arch/x86/include/asm/atomic64_32.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 1f650b4dde50..6c6e9b9f98a4 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -51,7 +51,8 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 #ifdef CONFIG_X86_CMPXCHG64
 #define __alternative_atomic64(f, g, out, in...) \
 	asm volatile("call %c[func]" \
-		     : out : [func] "i" (atomic64_##g##_cx8), ## in)
+		     : ALT_OUTPUT_SP(out) \
+		     : [func] "i" (atomic64_##g##_cx8), ## in)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
 #else
-- 
2.42.0


