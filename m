Return-Path: <linux-kernel+bounces-346746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A089F98C841
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4709A1F25C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B44B1CF2B8;
	Tue,  1 Oct 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="npXPjI8S"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535231CF2A0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821850; cv=none; b=VbX74NvLVWOLEWWUPnmcuKvji0M+pmCBcJ231PcdbyI/XU4rnp/Jg6coFoSyXSmFqsv64scKj5JhaTTMqnu02MqjtxOF8Cwu7o2u+nH++wTQLfDtScx6B6YFDMGJcjnUqpxbw/Y+cabWWzgDQ7Ex8WB23C/QDL21jlIwfoB6Pk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821850; c=relaxed/simple;
	bh=JGTFl5VoZdw/HMSx+xMjDWjUeDuNOPJLXAn6T5BdJYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swLOsKtOgZHQvWu3j57xyzKsug2SKuCiAZ8JQdbW63IccUqRJVjutF9TODuTGmRSn1sHq74kvjN4f6C4jPylo1WDUghCtWA+ZY5iGMwKrW85kdx7Ikjc3YvjD6DWsANvdKycwRE+fLK9IuyQ1r7FJxtp+egfDcrGe6gC6HK1ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=npXPjI8S; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e045525719so3798850b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727821847; x=1728426647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQt8/ibZGmr7UQAMTn5RryHz2eZfh/xc9yurTJPgOaA=;
        b=npXPjI8SwU0So5l8m4ZN22qFUG5G5lrl0EmQJvjDGAMv1HD4W1YIGL+lxt7dk8ORkr
         +x5ztrLQI6JfDh/TTWOXO3gyT7ZHhRSFeoMG2dkmkDgv72S/JCG9NjYfPsP0cQEYjYcJ
         rjn4WFgKBtvDIHMN2h2LwDukfBnUbSTI9RwODUaA/6qu8vl6pfbSzW9WybkCdit2LAAs
         vcGfpZsqxryP/Kx8tkWrUipLgj8sQk7SYTYbqDTadMjcHjsoSwBGoDZd2x5daE18Zazl
         55EG1RBU01GJqCAFBXuV5KmkEXNyS7cwC79go7xvJoWl3Q/JIESh0DIk/f/cJx38BB/d
         8Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821847; x=1728426647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQt8/ibZGmr7UQAMTn5RryHz2eZfh/xc9yurTJPgOaA=;
        b=PTyDSXP/bRvwz79OhKaDg0MWjnV3TI65+++gYdmzD7SAi6wykxaGDtTgAo0zTmA5iA
         1uoUV36+3vnnIXwXwQ1WARRk+o5GayeIxRLoA9fAjHSnN+swpVrX/c+V1gFR+0YvX3YT
         OPKvsnkgzAY5kFBSN0pq0aljUokWKWziDGsHr8WUaUD5eiR1PGXqVhR2/BXvJZ6R790q
         r5nAqRJxfR/W8Fsp8jp3CXzj2cGxIQvb8rAo+il3RayRx8NgRl8FEuiCdNncQKp1vlUw
         fUaNoV84FxC0JZnC2a4eFHlYooj+gtgxwBN6lE3PSfzYKI9LEJ2UzQjFYiUYz/ToOn9y
         akYg==
X-Forwarded-Encrypted: i=1; AJvYcCWgjtl7qQK6mLfcFb22VyEEXXIsDQ4RZtU4r6VLZBuEwYD6/ruz+vgbklPc9+1Eon7rVkJ+d8foJT23xDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMwHND608NQX42vqWR3FisAdj+/RzHv84JhUkLK6J6QeIVnYF
	q25Z3xL3Rx/eagsQh4TOE6d74/6XBR8kZTjVVuftyA3Kv6bV5tk34UwPjU0Jc68XsiGSoKV6Dpp
	7
X-Google-Smtp-Source: AGHT+IGhvVHHB1hJmRFs6zxZiSrw/UPrPWpHoFtdU1cOKU7mjPFozjX8w0AobKNYjmXrmqNGa3i2Pg==
X-Received: by 2002:a05:6808:1493:b0:3e3:b10e:c2c7 with SMTP id 5614622812f47-3e3b41879eemr1066223b6e.35.1727821847469;
        Tue, 01 Oct 2024 15:30:47 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e770eaa056sm3002097eaf.31.2024.10.01.15.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:30:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Oct 2024 17:30:18 -0500
Subject: [PATCH 1/3] cleanup: add conditional guard helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
In-Reply-To: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
To: Peter Zijlstra <peterz@infradead.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-cxl@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add a new if_not_cond_guard() macro to cleanup.h for handling
conditional guards such as mutext_trylock().

This is more ergonomic than scoped_cond_guard() for most use cases.
Instead of hiding the error handling statement in the macro args, it
works like a normal if statement and allow the error path to be indented
while the normal code flow path is not indented. And it avoid unwanted
side-effect from hidden for loop in scoped_cond_guard().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/cleanup.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 038b2d523bf8..682bb3fadfc9 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -273,6 +273,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * if_not_cond_guard(name, args...) { <error handling> }:
+ *	convenience macro for conditional guards that calls the statement that
+ *	follows only if the lock was not acquired (typically an error return).
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -304,6 +308,13 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
+#define __if_not_cond_guard(_name, _id, args...)	\
+	CLASS(_name, _id)(args);			\
+	if (!__guard_ptr(_name)(&_id))
+
+#define if_not_cond_guard(_name, args...) \
+	__if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)

-- 
2.43.0


