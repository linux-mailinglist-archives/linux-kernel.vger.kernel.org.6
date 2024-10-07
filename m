Return-Path: <linux-kernel+bounces-352997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6FC99270F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC861F23854
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14AF18BC24;
	Mon,  7 Oct 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfGrxmxu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6A18BB83
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290032; cv=none; b=n8SjgAx6fKX7A9SQ5A6U7vnbrZASJwpZZ8C7A8ezWDLZAJ3BQwrRsWw/lUhxBPFEnhD8gJOdBsh3wUW4qUw1nQssxCviOl3fE9p0GCUauYfaRB9s/XAmIlABmIs2gQ8fKsYYldZnQHtr1n8Ih936ageT4zGhsEbqe7jMGW8WTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290032; c=relaxed/simple;
	bh=1bNqtOd4P3rGBCTkswQjFbo8yOERRIeBEeFDQkr7xiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=It8jzW5L9yrVCeznMj92lI+YCh2zWep0HtG1z9k4vP62lpLsi1NYaf2M8cVZVQcxuDvORR3tOmMNeZfIFM+91ZnGG3KfmZNKQl3GMYuHzgMXV9Zo4CLKjwrXdZuPyJCv3vlONqvTPH6IxFJYIT6XtydU6p/XJqg5l66F5xjZKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfGrxmxu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so55408255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290029; x=1728894829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o+xD54rM+kPh81dLT8oIMtcHrdo64L3uxtIe9qc+nTM=;
        b=RfGrxmxu/DDu38cXJjeSOO3sm0ehaUB+kJVSlmKhwGTB9JdsHw2q8gZJlmqgbUeX6U
         9vB846dWVQOBg3DE45dArjue5mx8m4frDcQewEdq/tYBn0V/qWLk+BqTzFj0ljiuz3yH
         aA8TjgwJhNClzLgACbOhvf+XaTbqiFQrclIb+muO1ujD7ELk0lKX9LZXaJpua+k7FvR7
         IdnYdVAzdX3P/ELVgU5PuG9UdlbrWhe1p6kXghrdhMp955D6PqJhtvTyTTcOE6AujKxT
         W79D+vilS9m6wm8zBzn81x8LEv8ucdTnYqL5iuW7jvWLho4HjkvwDCQXD/kqgMfkroq1
         YknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290029; x=1728894829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+xD54rM+kPh81dLT8oIMtcHrdo64L3uxtIe9qc+nTM=;
        b=iMfqmJ081jbf1r87y79p6ZJSnlpNop5Nul5Bg9KHkAQPq8+4tmoWL1s2jDSAQeuYh+
         2dFS2oi5NJW18M4gHV4zkRQnfr/RNvLIny3MwCOodPEi1zCsvg7V5oJI+h2AGihPs0MP
         MXbPQDnh9ZHiUJwO253swu0pR9rRYd8ij0HgfMhS/LhYABWo5npzhvNn54zZHvAkqxI4
         e1Mg1uyAlAGV86VkF4+8XQ7K7V+a0NTcy9co6ilpMiAgwMZaKqD+uQZDh8cMC1jHJTvp
         9bkW7+L0fBnW7rGr1YWzufH0oRquKbexPIP3h10fC9t+1ks68Jfl9rJJFv4XdcpMUL2L
         c4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMM+9RBuL45NVvinohZQdXuvmSxhALbGVRYdMf4YJReCZFLOTn4aqtLrisO41vKwv0PuUkf6bwogCF38E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMCTOeioI53Tgcrr8VmhkZX/t8gAGmgc2RDudcU9k+kah+z6f6
	M0gboqPEnEHIEGoAdR40WDKU5QtltpXyxdjmzLlyWyuE7RacxBra
X-Google-Smtp-Source: AGHT+IFfT2Pk+wZUyr4+w0J8iZ0WLy21BhP1EjzY0+8RqUItMDej63U+RU4AUkHhoGNI1Q8P87ESEQ==
X-Received: by 2002:a05:600c:4f81:b0:42f:6878:a683 with SMTP id 5b1f17b1804b1-42f85ae94e9mr121651355e9.22.1728290028831;
        Mon, 07 Oct 2024 01:33:48 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89bfb494sm68702575e9.21.2024.10.07.01.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:33:48 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
Date: Mon,  7 Oct 2024 10:33:31 +0200
Message-ID: <20241007083345.47215-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/ioport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index e2fab3ceb09f..6290dd120f5e 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -144,7 +144,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 * Update the sequence number to force a TSS update on return to
 	 * user mode.
 	 */
-	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
+	iobm->sequence = atomic64_inc_return(&io_bitmap_sequence);
 
 	return 0;
 }
-- 
2.46.2


