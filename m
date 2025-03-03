Return-Path: <linux-kernel+bounces-541015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614DA4B777
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE13AEF85
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098021EA7C8;
	Mon,  3 Mar 2025 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lowmE10z"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF101EA7C1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978585; cv=none; b=MMbYqPI7ivYRfwNgk83DiHVdIvjTXjFaAVk7+gKbKVcPmm3aCz75ckQzNnnCrhZZ4e44J61OjOf25mMMSr0PpiacgDYafecNZVRqHG7QcxLdXDEWvRyscmnuE+WmBMEZiA96K9kKZBNmnJn0Jhd/Q8hn8OBEWuYTbymkR/jRKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978585; c=relaxed/simple;
	bh=6u+r0ovtm0jW5YjCvNxc1YcxBTXJYiyjcM76RIX7sIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVdhlOzgRZ5TSZLexPOPzyX56pMbw3ZQ4i5h041UXmJLcKvotrd+G9r9pDvq0ShpymwC9RsT+7V/zCNtYwTZtlL6efLQfJc2XTHeBc7Q7HaruCiJBlQEUS+1nYaxMF4KdzeJbWQGULzHhltGeuqvnFasySUJUENZu0OpMUGDB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lowmE10z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e4d18a2c51so387017a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978581; x=1741583381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnEHm8Q2R+qf55+zK9cHcOTX+1u/tw9AcohnyzHuWzM=;
        b=lowmE10zZjRfpjgY3yGz7s+cYg8TFDsROAvSHdr4FSL0TMnxo+7fLlN7LfOg3KTeHp
         uDaqA7GYdtJ7Dru+DB+S44hOsYpD3uDzur1TrWH55Jw+bJgOYuUAIFFz2nksHr9vqSZC
         w6obBXbSKu0yqELGxxSV3UCz6MU6ndk3/EO8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978581; x=1741583381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnEHm8Q2R+qf55+zK9cHcOTX+1u/tw9AcohnyzHuWzM=;
        b=wuyyJPbwihwc4AVtl+VaxtYv5Ow5wPo/AKFZPQZE7AVvkiE/UfFa2L+8m2FDfPdfdE
         uyVfqAqQB0DXb57cA1ojqQ/heM7sTnRwVs4s/9O0uIOrvjLWU8qwlI+C3TBMQU/XcqLg
         QuKffkzwi+UXX0O7uV8xZZn6Xs+aEpSdh/+FI1juoa4d0VUx1lf9GPxMrC94o6IgJSqx
         73OE/wDZcdXE+FZwIfsRc1sDvXMHCDLrtcjvU6MQ5adHILEWARNDTa5JoGZ9zJW0mg66
         DAVNOopFaSzMYTmJeX89iAtgKTkNKp+nCGp+Kqf/5WwVKdmbtwGZhnX5t3AXBwzvWLdc
         OTgw==
X-Gm-Message-State: AOJu0YwR9N6j7likirlW3DWqCOYQ2XRH7IH8jTUl9RcjWmD+nNTs+UxE
	uyA/DKez1xqC5Spa3T5BnXvRBY4aOc2efHUicT6BIP+sIhAU6aQANeRxKlJzvw==
X-Gm-Gg: ASbGncutAEKjci/QkTyKK9FI5+3/nrx0hSi2pc9O7ttJLUf3y0UoVUqQacOfHzID3on
	EWip4+7dlxLScQJY5RrTp3FqI8g75wrbiqk1/1toehdrNPCB2Kf7kwYSCksCnXvk5SKB43p2ynE
	QQt7KPtXLObIHw7Y5EPRxS7AuCmZm8Ls5O5QWJ6rkFG/DmxlsKMktA6kATWCuPAr4eqBIbSgTYt
	uHEqnVZ1VhINhDh0lAxmddzCHOSKpb9Yw26KnXd20l88K9St7XpBBM0DJ+P7Lem1Qnq9KXRecVO
	7OOAbyO24tqkX6l0SKEr0jd1HpvCglRvyYCE5uxWFFC+kiRwl7rhZjIjA9QErbJ+CK6sWaExcF2
	w
X-Google-Smtp-Source: AGHT+IGr7aLO58G4GmFia0KH79zY4iYQWcKqxIsMg7qlBQCpzajCy2mPKds0czrD1eMZhOSnlodKgg==
X-Received: by 2002:a05:6402:2550:b0:5e0:82a0:50b6 with SMTP id 4fb4d7f45d1cf-5e4d6b57020mr4945161a12.6.1740978580628;
        Sun, 02 Mar 2025 21:09:40 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:39 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v8 6/7] mseal sysmap: update mseal.rst
Date: Mon,  3 Mar 2025 05:09:20 +0000
Message-ID: <20250303050921.3033083-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update memory sealing documentation to include details about system
mappings.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 Documentation/userspace-api/mseal.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..76e10938302a 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,26 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  The system mappings are created by the kernel and includes vdso, vvar,
+  vvar_vclock, vectors (arm compact-mode), sigpage (arm compact-mode), uprobes.
+
+  Those system mappings are readonly only or execute only, memory sealing can
+  protect them from ever changing to writable or unmmap/remapped as different
+  attributes. This is useful to mitigate memory corruption issues where a
+  corrupted pointer is passed to a memory management system.
+
+  If supported by an architecture (CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
+  architecture.
+
+  The following architectures currently support this feature: x86-64 and arm64.
+
+  WARNING: This feature breaks programs which rely on relocating
+  or unmapping system mappings. Known broken software at the time
+  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
+  this config can't be enabled universally.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.711.g2feabab25a-goog


