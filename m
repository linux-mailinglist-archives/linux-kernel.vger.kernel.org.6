Return-Path: <linux-kernel+bounces-543434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C868A4D585
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006CA3A9E99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8661F8F04;
	Tue,  4 Mar 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="BISmWnWb"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAB1F4720
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075164; cv=none; b=iFGsvna9/NUb62oqC33Re+PcYOmPVO04MTcBisA6GA/HiJSr5KPRWSz05QsXhystnBbk9x/6Q0bvYNQ50IQlqbqbNQfqwccVYnzsamSExAe2o7D9sxTfFDXULKBRBpzlpq1VYix/AnKTItyQG6jgQEtmOM5U27Lrz9f4n20LVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075164; c=relaxed/simple;
	bh=E/tsTP8wyUDOe27tTvVuV4X1CxKf+JytdF/Q8cM+his=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuEeEKfUMfr3UJNBGweo58L2NtRLieSleCtPmyilhbw+CMgZ9bSV6pxDUU9MyfsX8/VkcQXm0SGLEBBJYatWnNq6U1L696N7xwNxaJ8m/Kvz3Daqvh/Om+XXk79lHHKWWaAgmZZ8hkZXv6YLqs9+xnm/VP8v9VKi73PZRG8AEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=BISmWnWb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390e702d481so2327931f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741075160; x=1741679960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYrHaUeLiXzVSvfmenLky5qyVqTXSKfWKor3msr/muM=;
        b=BISmWnWbaXn8bjw5HpdG4YK7TIr9vOtDphcMzea/h6FnRFmhrPBJnzy4Orb9RB2dRc
         gCdjjJ7Lt+QKyjAxKy+X5q/0KKSsJnxTO2ohcREXhcU27jAeX8rNTynIr3Pwg7GHvjMI
         H6twwtnkbJSYmpzaJOpgoyaeT2KEowgAPewE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075160; x=1741679960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYrHaUeLiXzVSvfmenLky5qyVqTXSKfWKor3msr/muM=;
        b=uoJk2WV4A0eHC7rZJ0BWu3GyJfjd8jpf5xnXAE/qxGKbBvGbkzj2oDMRzUUYJEgr8X
         yMiv6vVF4e+H5o5QVZomFVTWj+lXLAzvKzQ6BtvZv68N855t9Cn5QCiUNYMbQm+RNKqR
         mJNanz2ZAthqpMAuL9a8t6i7QkDnk9lCgzJIOkN4Wz3VG753yIQulRnWZ+DdM5PeTPyO
         qKDr9BVebafPEOMZGHybpyfVVyiE81Wul/tI4VVfmQrF+f6+Y4JEmdFT39LyH9SmRkSd
         3M5qDQnM4HsH+9Rv2mmOGkl+woOk2wXec+q/C6A1ZeRDzOXbaA9wfwnDPzXvde5OQW5R
         S5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW3zn4+VYqdXuTvE4+vXvGsEKNi57iEtXwkYlmf6kfqgDzJXtUg0BKut6/CTDUavXjVaxxmq9qqMo3n6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyavEpf9mizai3ycsxwL1C1HUY9eC9pYqiqrKLD/Kf2niWGjegb
	n1xaXbIZ8AatRwhhcTfHVpmjJJ0BuSBc70xe9ZBbjkL1xmk8GP7G7HzQfQM+0mFHKzwwF7iLOjE
	+FszGog==
X-Gm-Gg: ASbGncvTxHFnUX3O031JITZbdtGtwoYQIdKSECjNcLg+Iwl3Y4oyBZ2PUbIj30+l7XW
	TLNtfNOibTw89QTnh5ZvDwkMSbo9BWHvyWvaRKDiY3q4uHwIAkdUBqvvFf+qMlhWWrZ8OQTWdGH
	tqrfRTYhfCuGd4eGvBezPgVDz4XHNps9OrtHcu1LOvR4YsgkZ/20GitfICC2gfnb37qiPjvqsZO
	C3PduAxlQ2Bpd7Ubn508u91TN+0iT+nN4P8zlPr5LQfGT7EPThBumVPzwtoadb4Jfmr5ekS4LNn
	xdsBm4rAuwSfv+I1wy1N5CQsuzhMXkx7b/i/hPxtAgRhnGjTYCRftte6NxOGvh5U1K6g8G6yJNf
	W4rAK8Q==
X-Google-Smtp-Source: AGHT+IGqjX+Pa+YisUiFuirJU3uxnZiOY5Wo3qiQRVVAyLRsKo0I6FSe33xFdkegzoFjmj/C7dvfXA==
X-Received: by 2002:a05:6000:188c:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-390ec7c6a8emr12288174f8f.5.1741075159802;
        Mon, 03 Mar 2025 23:59:19 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm16618101f8f.5.2025.03.03.23.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:59:19 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] tools/nolibc: always use openat(2) instead of open(2)
Date: Tue,  4 Mar 2025 07:58:16 +0000
Message-ID: <20250304075846.66563-2-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304075846.66563-1-louis@kragniz.eu>
References: <20250304075846.66563-1-louis@kragniz.eu>
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


