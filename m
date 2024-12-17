Return-Path: <linux-kernel+bounces-449832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF99F56B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97487A1F29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70C1F8EE9;
	Tue, 17 Dec 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC3h0hCA"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE62166F3A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462675; cv=none; b=Q5qKY7oT8ySEFfuG1ZzqJwchTEDTB6Q7qYAS+dKi6z2BYmTUSMiy2W3N4wYXLCcMmabYCvZ/5Qy8RHWqw3PiYLO/OQRfifidAIIR/6wZu5bb5jilfzp3O1/Xq7GvNAC5mAJ4lNl6e433CWGkHlQOnHAj/B9LnZiZ4tZJTsxApyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462675; c=relaxed/simple;
	bh=dmPld3HZKVL1Pq9inX33H1cmTEOiVLNEXU72GV98lw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZsZS+j+4eGKIdJXTHrZ9mdLk89sbz4EvcbIjshlyUmNLieYmPFjq2r/6URUbeAzVUwULhLYqTmRtY8f3VpVji1hU+WWeLbM3XvC4BV8FXWPtQK3AvV4f3nGRe4fCqwtkxRk4B0h0jf76KJKUtU0JdhA0t0DnXmUtMcprpz5UZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC3h0hCA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21683192bf9so54147245ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734462673; x=1735067473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnUuI4C20zQjWjV2mM6jucFAU9rONuEWnBg8YV3Gsa8=;
        b=kC3h0hCAvqNvYnUoaHSTBnhj8VJhzBW5E22DYLfq9D+N4DhXhTMxhiUbFPr8HwNG3C
         AKsuOH4Ffd2Amy4M4FqkUyL0WIJdByDCIPhd43rllZ1I+v4EuXBG9j7ZWupJT33MX3WM
         Hrwwq+ekKS5SbaKPaSMWGv1S6+g+FhAxbM8U6hxeBEMlITEjTAfn0BU+MnsZWQtNAF65
         wV2p54gKFl89FKxA/oJB8XUy1y0HqgsHju+apVktnGyTYkymJHgWjVrE12V+ZwUHrR6B
         9Q2cXiCdyuau7fRRqm1MAXIrHi1yWQYfZu81SJ0Gvn34cCRutnXraX3DRFaU5goEhjwr
         oCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734462673; x=1735067473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnUuI4C20zQjWjV2mM6jucFAU9rONuEWnBg8YV3Gsa8=;
        b=RHWVQVAid/3F6k1YcEyb2B5UG9OUWV0EjHzQ/0o9G7O6yeQ3nH9UvHWX4ewBUjTNuQ
         qPQ18SYtQhp9x04JGT+kEYHmf08Uv2aQ1b2k/nbz5Io7Iw9Kagse8Q/JdnBOy2nMWjoH
         KwCvVam2n8VvHZVUGbX2Qv9EepmhDkXbXNOeFhWc9OX2ZU+wRgflBgfFdi9p65MfEJN/
         t27MJ2xTLS6MiR+x0U+vRYTMFXNROxKo0+4zfBNSaYm0SyecjESEIdUiGLTi0p+nnfZf
         zz0u8dAERPBEy/fCFkTdqfJ48aWLQ0Ej4GvYTXYXI182WIRVPkl7xka7PAazl5rATY1V
         0Dig==
X-Forwarded-Encrypted: i=1; AJvYcCVsW4Fa2Fg8PprMwARroGnWDqD3YRBJ/N5UdFgFcO1ci4CtW73DVB5mW/t9xmqwsH8U6iBBCfA2swkM0N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaha8ityzt/BgXJdFOKYAvQTUGI9V6BiR0IEjMikp/pdsgF2hU
	uOPFzKOWFzxIjGjm14lboQV6ZjaGce6iFkuIFgdkoYYUMCweyk7dKHbCsldsRy8=
X-Gm-Gg: ASbGncsb5RZqXUZ5FmNJDmQPl/bg+6j73DVp80NZKa0gC5AO+u8/nv+eI07q/Nc9PrW
	QNShUk1N35FvkQIl70jeoHkTHCP9db/kjg93P+e1VOw6PtIzmEKaOFwZ3NAfPGFpIhyYiT7Zfvg
	1WehV06md3uQ5VjGmtu2ykTH2DfSb5j64XTl+iC0CJx7fpAlwxAzG6KXj3ef+C/qSQvvZqNqTVv
	NvUQA09YfXbgyn2DsSwJ/fhvRPwD+v7KiRrk/Z3uQBgryelDUbG1XsP0i7xtOLy6BNtpklV
X-Google-Smtp-Source: AGHT+IGRyxuY8qwEMLLY7KjW13/BG9HiBeISNuJoszNtFUO0+PtvFGdKhWOSuf0+V6i+YushQCkWEw==
X-Received: by 2002:a17:903:983:b0:215:af12:b61a with SMTP id d9443c01a7336-218d52d512emr9617425ad.50.1734462673275;
        Tue, 17 Dec 2024 11:11:13 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:ecbe:ab7f:849b:1fad])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e657d1sm63170725ad.239.2024.12.17.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 11:11:12 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+7741f872f3c53385a2e2@syzkaller.appspotmail.com
Cc: dhowells@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marc.dionne@auristor.com,
	syzkaller-bugs@googlegroups.com,
	Leo Stone <leocstone@gmail.com>
Subject: [PATCH] afs: check for NULL terminator
Date: Tue, 17 Dec 2024 11:10:52 -0800
Message-ID: <20241217191051.77935-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6761b929.050a0220.29fcd0.006f.GAE@google.com>
References: <6761b929.050a0220.29fcd0.006f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing check for reaching the end of the string while attempting
to split a command.

Reported-by: syzbot+7741f872f3c53385a2e2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7741f872f3c53385a2e2
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 fs/afs/addr_prefs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/addr_prefs.c b/fs/afs/addr_prefs.c
index a189ff8a5034..4f8553aa5931 100644
--- a/fs/afs/addr_prefs.c
+++ b/fs/afs/addr_prefs.c
@@ -48,7 +48,7 @@ static int afs_split_string(char **pbuf, char *strv[], unsigned int maxstrv)
 		strv[count++] = p;
 
 		/* Skip over word */
-		while (!isspace(*p))
+		while (!isspace(*p) && *p)
 			p++;
 		if (!*p)
 			break;
-- 
2.43.0


