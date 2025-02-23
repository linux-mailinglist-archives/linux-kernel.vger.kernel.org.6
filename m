Return-Path: <linux-kernel+bounces-527989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB77A4120D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91CB3AE0B7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11ED20468D;
	Sun, 23 Feb 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC37JLva"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272D1DDE9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740350033; cv=none; b=IIgZgI3zNj9MUhYIcw56cD+xfiZ70S3yJo/K51oAK2H3nrLxpnEEk6hSr/z+9qtnEG7P2CIwXC6HeJUggYQAT8z67aWxkMeq1lXWDQokwMUNzF9ZnjJoQaFiXZykM0E94vFRPLgvkNO3T99cB/uCJsqTLIWOkFXPw1A/ixcalC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740350033; c=relaxed/simple;
	bh=R8RVlunLeOvvHknZHzv/9f5i+3icyNbhNxmv8p7I9VI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gI2xjVq0+zII/0uCyAIbPzopR8O8LNpMDFdApO+e9ENAt8wJQjvLHgica61ovXbt8frNmxit4mfkrnWddql5YuzYB92QdLCHyfKVQGhUqDFw4qj2wf56pjvg+KaPuc+i3Q5mV7gq9tUu1qee18xfzPGo7hPAMUeKgdcAk0/YP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC37JLva; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so6230301a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740350029; x=1740954829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCACBmaXu2VyfK/GZ5QTe6qDTsf+ujBpWqazgly/3j4=;
        b=cC37JLvasCueeHgHZ9OcFRw141iH/ou5ItH2i5U+OVddo5gDDMKQvy9vo2oYEDHLFg
         cwbBiQlTHXSgqCxag16vAoqJPvY4uKqwqvWiehl4//9ZDyIEe4NEQKuA60LSSJmwUrEQ
         bjEan0jdgScqq88IO+VmWT7FegpV/DWgByI6AzGpHJDbl590o+oB7888LQxh3xLiHjJu
         Ey8BrHo9bNiZy3dzmIffahLznGenC1WkFq5VRv6Bs0hlNzN6yv+V1fsCCTJS9id7fsn1
         O9IdpZCE1lLkYZnPOIqmJltoHJpKghd4sERxP4mUYTSYuvPenl6LR1JsuJOWz7FNqAv5
         TrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740350029; x=1740954829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCACBmaXu2VyfK/GZ5QTe6qDTsf+ujBpWqazgly/3j4=;
        b=nBeAqEDMdWzTd0BIXMyXs/gpoavmnIP/IWJQMAuZuSUsetbfb6sfniIkvd1iRsfNlz
         zG9jK4hPdXLCEkTI4RuigAapY4i9cKiO670rgyfv34g2XIX70RIXKq0V+glLMPWOdgeF
         xHA6I7M4aLomnl8JEFnK2ELre3NSbONdx3SL2fiZnVNmnpBLsX7Iz/UeyS+83WR+K+7T
         JoX9CavpjOOR50jw6SjHd6ammG6F7ixmeqrl9O3RpypcSH3gab/glGBWbbRJ/wW6Yg8U
         NeiqJMy07JYv2QLpZJLdt8BX4W2vVJmxNkMKnV4BNgakO7MDu3zatkGu5quC21dW4DEX
         Cdnw==
X-Gm-Message-State: AOJu0YxhOpSZEcmGMNmaadLtEK84/oGHueXWedPXYolXDxh+pOL6yu3F
	Bu1NKk+wjetCitde/AQ8SqOR8YEYZuIB2vzMgaVaiqgTuFnGeRDiPwkPe0ZtmzE=
X-Gm-Gg: ASbGncuo9uEw+aYbCz0prZ8tq6REl7Sx5GBXsS65wOiekf1OrTiDSmS/rLJaSNwXDX7
	xfb7Diit/K0DuBTyjao0Q4T8ijg83v+ykPITl377KUD/PV+m9ur3z0zERcKwfJo9CjTsQhwLx7F
	bEXS7jh3wr/rO22v+sp10gaQTt6xMrP38qg/D/LidLGml+FFw3rI8TRN/9xI1kKc+SMNfAKKFVi
	8tZ+LRRjaGBExVZZYphxSVxCMC+S1u2dy3C/vnClbIR6IupVcABewqr+CxbQaX01pTwH+Kw9ACL
	1VuIUoFmCDdUbmxmMxGVLNHb3VC1FFcn2bY8AqT9XIZkTtXwXPCAw3Nj/S6PTZd2vCCenYSohA=
	=
X-Google-Smtp-Source: AGHT+IEN7WZmzHn+1x2mpxhPl2CJt3SHusUbG3svqnAoKdmSBbdZgFg/D40tDRBRpgxaTGZGjRjpGg==
X-Received: by 2002:a05:6402:518f:b0:5e0:815d:4df7 with SMTP id 4fb4d7f45d1cf-5e0b72508c6mr11602980a12.30.1740350028959;
        Sun, 23 Feb 2025 14:33:48 -0800 (PST)
Received: from localhost.localdomain ([2a00:a041:e635:5000:2555:b80a:9297:4930])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d367dsm17741693a12.44.2025.02.23.14.33.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Feb 2025 14:33:48 -0800 (PST)
From: Yonatan Goldschmidt <yon.goldschmidt@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yonatan Goldschmidt <yon.goldschmidt@gmail.com>
Subject: [PATCH] binfmt: Remove loader from linux_binprm struct
Date: Mon, 24 Feb 2025 00:32:34 +0200
Message-Id: <20250223223234.13764-1-yon.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 987f20a9dcce ("a.out: Remove the a.out implementation") removed
the last in-tree user of the loader field, and as far as I can tell, it
was the only one historically.

Signed-off-by: Yonatan Goldschmidt <yon.goldschmidt@gmail.com>
---
 fs/exec.c               | 2 --
 include/linux/binfmts.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..f45859ad13ac 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -755,8 +755,6 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	mm->arg_start = bprm->p;
 #endif
 
-	if (bprm->loader)
-		bprm->loader -= stack_shift;
 	bprm->exec -= stack_shift;
 
 	if (mmap_write_lock_killable(mm))
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 60d674af3080..1625c8529e70 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -64,7 +64,7 @@ struct linux_binprm {
 	const char *fdpath;	/* generated filename for execveat */
 	unsigned interp_flags;
 	int execfd;		/* File descriptor of the executable */
-	unsigned long loader, exec;
+	unsigned long exec;
 
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
 

base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.39.5 (Apple Git-154)


