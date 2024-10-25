Return-Path: <linux-kernel+bounces-381720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B349B0351
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B961C20D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA57080C;
	Fri, 25 Oct 2024 13:03:51 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2D206500
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861431; cv=none; b=fZ0oZtNUkQgviYaYFhaTUb+812XPWh+RCCHcneqMZfZGKMMOnKBo3pbGbx6+qaM4GKhjhEn6QOGI9jAPKG8KdzaM60LeNkjyw5WUoY/QCd01NKkR9FC+LZ74TOA8maKgHLvSUPsSDvfQoBBKBZPdpYYrkf/aah3mI0HMwpsYESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861431; c=relaxed/simple;
	bh=sCUAcuzkk1BDvJiVdvBh/8oEOlPZMobXjEXHHtt7ndQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l3fmjANDoJZXWJXra606oQuB6oNHkXQmlSK9yxWv9cfNm/qnRj6racfB+DHMgg2hPYyQNo7pSRJhRjOShuxJ8W1BM57rPzGQPQFBPQtEIn53+UCE8ptw6JjoZwlK4/Y3lXvV4UIx8pskbQZx2AnWQ4X5Q5ILmjro2uXXoulwR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315eac969aso14010665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729861427; x=1730466227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTYj1JwC1afquZHY+Mdiq2m4AHx9z9hl/py0kliUDB0=;
        b=Vy+0kDo0feMF6h4nlDv3bCDYj67RSbSQrS92532xL0sz4Somz9IPZ6z5H4qFOa5kKG
         4/VRbUtSpkHA/SR+kSK7gC7m9UBvqHcIbjTwIGZ/lgQNO+bhPtSuDs3j60Be95k6cOcv
         qZsKrjXwCqkeeJF5l2EjyfVaCLIZA6QeC5bYG/i35yzPgEtqVZxqMtH+lNXH/Iydw13p
         evo7IvC75lgFLOqVyIfACPuJM3ff2GHbl29gj3rCW1yMrvTojwaraBwGbT87kiuxSCBw
         v276VWWQyPMT2yr9F4PvfmI8PBaSR1jqeombNcDBTctua19vPyYF2j2A6Nxj9wc9hNQU
         QnYg==
X-Forwarded-Encrypted: i=1; AJvYcCU2HtBn5odpXtoVsehiJo/kewWOfc6ytrRx4Pi587k/u12w0eWpwL/KdJOjKqPVgp+kmahy1NKZnpqdkgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypwwZQcmnGlUI+qlMQ8vp7nul0m0N3gLrHqCnKMOMhwouXr1+T
	/qOnxS5EzVHw9PxFP+ZnDW3g6TpHOuklnHizpVdlokL2L3oR4evf
X-Google-Smtp-Source: AGHT+IGlR61nI+RSg/2oekO2zDvSYzHaDZqZkK2n7asF8ZEQXbPJVZmIUwnCdelLjeiug1NCR0p7cw==
X-Received: by 2002:a05:600c:13d3:b0:431:5475:3cd1 with SMTP id 5b1f17b1804b1-4318bc96684mr40212435e9.17.1729861427053;
        Fri, 25 Oct 2024 06:03:47 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319360d32bsm17021795e9.46.2024.10.25.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:03:46 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	=?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags.sh: Fix warnings "null expansion of name pattern"
Date: Fri, 25 Oct 2024 16:03:16 +0300
Message-ID: <20241025130322.3077455-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Warnings such as
ctags: Warning: include/linux/wait_bit.h:59: null expansion of name pattern "\1"
are triggered when parsing DECLARE_BITMAP() inside comments,
resulting in an empty token.

To avoid this, ensure only non-empty tokens.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 68b2b49f5688..db7972b6109e 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -189,7 +189,7 @@ regex_c=(
 	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
 	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
 	'/\<DECLARE_\(RWSEM\|COMPLETION\)([[:space:]]*\([[:alnum:]_]\+\)/\2/v/'
-	'/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]*\)/\1/v/'
+	'/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]\+\)/\1/v/'
 	'/\(^\|\s\)\(\|L\|H\)LIST_HEAD([[:space:]]*\([[:alnum:]_]*\)/\3/v/'
 	'/\(^\|\s\)RADIX_TREE([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
 	'/\<DEFINE_PER_CPU([^,]*,[[:space:]]*\([[:alnum:]_]*\)/\1/v/'
-- 
2.47.0


