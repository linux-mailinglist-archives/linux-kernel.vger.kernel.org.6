Return-Path: <linux-kernel+bounces-549665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B419A5553B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761A73AB66E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26AA25D54C;
	Thu,  6 Mar 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="DiRYLLY6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF526BD84
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286532; cv=none; b=c35l/IlBmG9liWhFlDU3le1IhEpJfFHHc911Foxp4R6a83siv54hWnz9d9GL0lOEcl8VGupmUhw9FYYkPqQizUl5BKfHU+AP7rwwfG/+7Y/7BKNDpwE6mDdexSb/B5iYBbuLDaXaETkYdJlc8oMlm6QRQRqPYNZVt753pvSWqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286532; c=relaxed/simple;
	bh=E/tsTP8wyUDOe27tTvVuV4X1CxKf+JytdF/Q8cM+his=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2am0eQJaUvreSpKRmERtF9KOIN9zAYDR0VgqikIo7NOpUUpKuLrXS9J2s2aPGmZqtxHVEQxBsGr5C/RQ1NLbQmVJq+/EWMazv6UDMc9fwcWCrY0RLorTCFqb8R5LK6cppBpzAiT1B5xILmsNqM88sHwcyRthOai3G03CSDufGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=DiRYLLY6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39127512371so746787f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741286529; x=1741891329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYrHaUeLiXzVSvfmenLky5qyVqTXSKfWKor3msr/muM=;
        b=DiRYLLY6ViD2HlUhrO6yGma2NdOuTqLfAYGUpvMy3ioq7NxS6Kh0ncyd/gsMM9BqFI
         N9pCbt2Zq+vmueZ5UYT7L4//DaAumPsqt+lueWDCh0O8uE4UCoLKG6Qr6tby7FRdWGB6
         7gNT/NgG1R/X8Ez2aQyhtpdQXTkB2o9+ecLYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741286529; x=1741891329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYrHaUeLiXzVSvfmenLky5qyVqTXSKfWKor3msr/muM=;
        b=BOBjbC/YFGAIkv7136oZXB8AacS3jF6oSapykhTlDX0KERGFI98oWHt7dVrofZzUkr
         zv0P6+nO2iwsglSRUlYbn5ZOUIeAZEsLXisOrSPTsqql39G0KL0Q5hP8+Jcs7CnseXQo
         mXNKLkqd76E++kNeyFv+KZ3z3rDz7JLha7rGqZjFFKbeIEXchJ7nPhXrtU82TWliiHCP
         UV53gOaQ8CpPHLR3Yo3ColPjcsHWxlkhGqNDLmtASz+gHViGo64W+yBObS3ROKi7gxEj
         Yai4XXX80V3K1g2pSozf1sAMR1L2XPwGDkJKrGb/ew70OHDgBnuPlyEv3JEslP8MkKiR
         YFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx0/Uy/LzRJNGCtEdLb3KKQfzHBFBMLKgT0xMoeHzAn9Fx3pC/A6hgX1nSZYkd0YOvhWa0Qj1pYGFDCzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6oVoX1c3oIxVpU6Gn0XTTDzXgVGBfbLnjBmpidrfg6nZLXvB
	KTtZEZpSfWbemY49BNfiHgo/mWNdSZSkoUxizgzWCjVf/Hpbk9HL0CUOK5+03w4=
X-Gm-Gg: ASbGncvXfPTdeLAm3saffhspE6okW12zgBAx0vgtWycybjY1sEWc+8n+dFMGkPac8mv
	xs8MhjIYnZNotfvELsbP3wGvC/RRBOd8CwcUBiJXf4/8nkiWjKFVovTe5BZM8YWyy2vwkrODmVJ
	X1lFFh8f8HWQ2s883UeXdvBmMBlWpUAfZ6Lw4oGV8v0rZ68x2lMomSt5RUBzxPTXVXKl09kChhF
	I6yUjqdy8YnbikjvBLjxD90bDXCeVuDHxWoYRkOAX85QBWLg96lqGnsaOfn42EAHeEEdF2ucSrA
	NTd7JUYOLeMn/1F2eT6TMwx4ILFtpELHYyXDDFpU+bXJWtdQazIG/7wQnRQ3rVrCKemCSuDfVfu
	zpX0RXw==
X-Google-Smtp-Source: AGHT+IH+nH/xiy9Dq7KnlApmkYpAWCNttkUhs0wRhbdZSpqTpXff4HvBYqnnTlTKFC75NnySVWf0kQ==
X-Received: by 2002:a5d:64a2:0:b0:38f:43c8:f765 with SMTP id ffacd0b85a97d-39132d8e592mr192416f8f.26.1741286528812;
        Thu, 06 Mar 2025 10:42:08 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c55e6sm57052725e9.23.2025.03.06.10.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:42:08 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] tools/nolibc: always use openat(2) instead of open(2)
Date: Thu,  6 Mar 2025 18:41:19 +0000
Message-ID: <20250306184147.208723-2-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306184147.208723-1-louis@kragniz.eu>
References: <20250306184147.208723-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All architectures support openat, so we don't need to make its use
conditional.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/include/nolibc/sys.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 3cd938f9abda..a8dca5ac6542 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -798,13 +798,7 @@ int openat(int dirfd, const char *path, int flags, ...)
 static __attribute__((unused))
 int sys_open(const char *path, int flags, mode_t mode)
 {
-#ifdef __NR_openat
 	return my_syscall4(__NR_openat, AT_FDCWD, path, flags, mode);
-#elif defined(__NR_open)
-	return my_syscall3(__NR_open, path, flags, mode);
-#else
-	return __nolibc_enosys(__func__, path, flags, mode);
-#endif
 }
 
 static __attribute__((unused))
-- 
2.45.2


