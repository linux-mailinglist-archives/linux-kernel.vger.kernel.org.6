Return-Path: <linux-kernel+bounces-539603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF7A4A66B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A437A8599
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4DB1DE89B;
	Fri, 28 Feb 2025 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BWPn5+DA"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBAF157A55
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783819; cv=none; b=mYhaz1CdWx5UMXkOJvfTu3ocAyOikhJzrKIEx3JjRyalZDp0iE8GsOFd0DAbIxWHhr9JOR1yqgtL66SV2pJkNpRhH8hPbkkQ0SDQQ785KZRBum/z0PObNyLkMz+NT/SwVYlgQs8/WcMn8iEt/V/EJa0enPc9UxxKAyBCJznTZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783819; c=relaxed/simple;
	bh=7j3qjGvPFFSYTj58FVcu/QNHzMyIyli39yBCI3WM1kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jp6TYuJQibJamKqPrh1a2wlPqT793dXS5cDbuMBQUjGNtsYCpx6JRlN4kc/hKfXqoIVObBqeMEiEaj8FkDKz4jH05UXOMFBnC8pYO7d3egdeBerPrN5xsWBuXA8eaAk3PMJdetnMlml3xMLbDi/ufpAinZsWwhL170uRXh81CSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BWPn5+DA; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2234338f2bbso6881355ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740783817; x=1741388617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf/QBUV7NVEQKN07Cfxd8tCBRl6ymxJlYuA3WLlAYys=;
        b=BWPn5+DAPWkRpGJUpq/O7z2kT/4xWYRVva11InSZbTBvuA2+P7hCma0YlUxTlE68qH
         cyvTMBFtUIFL/Nlf7XPLt1JaeCDnCumLF+WeFcapco3g/aikJKyWNqCLMgPa3fsiAV6E
         wfj5jXG2qPAZaX9UCCeeYDv0UAzmcoMPkoyyyJCP6EWueh9cIk2gulnhe8w8FSjkapA0
         Od7IEgz0Un+WY0F0AwBnM70tOUZJyCacgx0+NLbiMWF5o76VPTmZCiBapGdMnUAR5RUO
         e4yx8vOf/RrWStsxLzGxx4YrmaqVyIZBoW0Y5DEd50cxeSs19rJazwE7m3oSjei7WFZQ
         T5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783817; x=1741388617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf/QBUV7NVEQKN07Cfxd8tCBRl6ymxJlYuA3WLlAYys=;
        b=UPio8WpubctEa9UkYSIp7vfoH5S1S7ojAW3ltlKqBvKDKWfFKyY5DQxfNf5WX0rQ4y
         S4HUkXZIqnk3jvPNRkf3+M0zt84bz0L6/tFGxCHWbXTrTkjwhp7rW77TxcbZMeT+shmD
         T2w+2J7BlnarhpoHZA9ken1whqUXlyXaRVrC5zLasRRObmuRWLa2UTg14dyElHbdqb6m
         TPYIxgHLOZ5PSSWAnkqevuR6V+xzqyRhRy1ZqxLVtbbOwhu/RMLQg085wJxldbJ5B/EL
         EUXgf7lCewLG0HFhoDHC7eCMti0ZWh7kYhhIYdPNlUodZ/rz90HoAJ8Y1YGRq17PjZul
         9enA==
X-Forwarded-Encrypted: i=1; AJvYcCUlXbCnK7Xh6+NSsPIesRKlVIJ+rTVPyzYTdY8BA05Bk2R43zbReyGDo4PmzFjRJRHCYFyMtZe8w7z42x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCHqem+VcYjNDnjjWutdEyEiQ/zCIqjxXmijOZVA8GFGyaTbp
	ziKiO6gR9eKymV4zAU1I/T0JbHAvcgGY/qT40GGAk+ufc8NOrzt0TzJbVs+lLxZ4ksxhy8kjuRC
	kfz/Z0DTZasa3pobaaDkw43QAiv4DCLL1
X-Gm-Gg: ASbGncuDezNHWKmUHCGVPFzVhgPxThDD1AeMbgm0si6mwzoiOMC+TBU+1B25c3ORraR
	AyILM1WTEn7GlFqK8CjtFf6kMgxaielS7xFeyVJZDLsuYJYuMlbCqWbzyjN4yX9LJsfjeLqd0BO
	cpVRYLJ54luU1YkbjMQckMYdbpw0WAT/aY1Xy3QXPgl6I+Y4VATg1+7o6cyuxzDsJvYy0Bh8KqO
	rZZ7OIkmQfiO0Vig3LborvxuQZjn9ueTkBwL+Z8UulaJN6fhRQma0QftTpUDfqwZ9OmbmhVMHgK
	wDxJ8t9PuuBX1LrZt5HPz6Yfv2+qCAnSgbHXhJi7PDd+xeq2
X-Google-Smtp-Source: AGHT+IHUdSS4qvxNQbUG1GSSETx1tYeYbCJTASaP2vuO663APRzoix+sZ3ezmTaHknBze/LbhOwuljxwBf8y
X-Received: by 2002:a05:6a00:2348:b0:736:355b:5df6 with SMTP id d2e1a72fcca58-736355b8b91mr227420b3a.6.1740783817284;
        Fri, 28 Feb 2025 15:03:37 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7349fdc7aacsm290722b3a.1.2025.02.28.15.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:03:37 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CB61434028F;
	Fri, 28 Feb 2025 16:03:36 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B891CE419D4; Fri, 28 Feb 2025 16:03:06 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: convert cmd_to_io_kiocb() macro to function
Date: Fri, 28 Feb 2025 16:03:04 -0700
Message-ID: <20250228230305.630885-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cmd_to_io_kiocb() macro applies a pointer cast to its input without
parenthesizing it. Currently all inputs are variable names, so this has
the intended effect. But since casts have relatively high precedence,
the macro would apply the cast to the wrong value if the input was a
pointer addition, for example.

Turn the macro into a static inline function to ensure the pointer cast
is applied to the full input value.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring_types.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 432c98ff52ee..72aac84dca93 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -605,11 +605,15 @@ static inline void io_kiocb_cmd_sz_check(size_t cmd_sz)
 }
 #define io_kiocb_to_cmd(req, cmd_type) ( \
 	io_kiocb_cmd_sz_check(sizeof(cmd_type)) , \
 	((cmd_type *)&(req)->cmd) \
 )
-#define cmd_to_io_kiocb(ptr)	((struct io_kiocb *) ptr)
+
+static inline struct io_kiocb *cmd_to_io_kiocb(void *ptr)
+{
+	return ptr;
+}
 
 struct io_kiocb {
 	union {
 		/*
 		 * NOTE! Each of the io_kiocb union members has the file pointer
-- 
2.45.2


