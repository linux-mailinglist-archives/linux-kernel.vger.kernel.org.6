Return-Path: <linux-kernel+bounces-409865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018CD9C92A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3281F23475
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446851A265B;
	Thu, 14 Nov 2024 19:55:32 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7919CCF9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614131; cv=none; b=Jw1mTdRWA6l4JyYytv4mFQlRg99QyT29isCQUXSX8xKATNEik529bC3VV6+IdPIhKPKluAoU7ZgJS7lqWuieJKIPOLaz9XyXQV/HXKxQc0Ufi5beC7ShSdKpzKdj9pwK4gLQGqU/GOYdoyYr50LkS1Attr2mHE51faJYB0HBtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614131; c=relaxed/simple;
	bh=te/nYkT7ynCICzyDhP7SSLDM6Gnt115Q3PJoUC3Ss78=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Lp5CsNJA9JaBA714iCKmVNfcqtkL2jmBHkTObUSQhd1NbmfAhPI8ZhNwKF+R/szsX+IQhGB83fVJP4NkGIynUgOxeumdvJr4bddW6zMqJ5JW37Mi7ghPnIO0GPfUFizX5wQnDe+11ReoXNAJvEcDcA4iCzVqeowtvpxgdroDzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43193678216so9435185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614128; x=1732218928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oChurHVSkauDMO18eKSyKG4OEzF5P4DWu/eGbZgcy2U=;
        b=i/P4b5bBH5Z33QJ0QMYnjrBnIfQluIw+HXafgqtD14jTOnU+O/Dj3h7dYlzgX3o4ht
         YKF9RNdGQqTEOLNgo0oFXITJ+IzAA6ItwqnX9k5MFY7PpX2q4h+mFdElTsNnkGgiiCkn
         MGkxXA8qJVK7ZbVvD9MBwsnNfFZEkf7JAo1gMVuLMSVi/fJ7S3Sla52Hq6zaMz29NbG6
         RA/lpyVVRXAa/+q5b94+Xoe3bNqGQZV498/xOt14lvEh6qDNeVOQlGeyWC0fiGRuWHsE
         D0QkLXP1BQkX5I4WdlpXSTgCTGPTGVOhnWEk6QjOV7pWHyeikwYIpXW4AolZ19qkQnaj
         3ZMw==
X-Forwarded-Encrypted: i=1; AJvYcCVjYlrCp90xl87d6utREl6zhPFkiDTA+KWCKAchOxVgI84O9s8uZ5SnJoCtjKtPFz7dWQy56T+EMLnx2Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQH9i/YHrqxv2sHuGaMvMuRH5i2/7cHipGHb+I6DKg//J824V
	jQP+CrlWMs9m7Wa5Ti28xu5CAeiylxn8jK1ViVPEYlJutzkc5ri5
X-Google-Smtp-Source: AGHT+IFX9iJrtNDNc9J2VnCoV7MLiIvfMrGcjMNe0Hizo/taktUuM1VRV47SjZD3b3ODNvD6hrJqUQ==
X-Received: by 2002:a05:600c:1f0b:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-432df72a4f1mr408875e9.13.1731614128417;
        Thu, 14 Nov 2024 11:55:28 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7878esm31296305e9.14.2024.11.14.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:55:27 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags.sh: Tag timer definitions
Date: Thu, 14 Nov 2024 21:55:15 +0200
Message-ID: <20241114195521.3073881-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tag id, defined with DEFINE_TIMER(id, ...)
and ignore usages of DEFINE_TIMER itself.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 scripts/tags.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index b21236377998..7102f14fc775 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -188,6 +188,7 @@ regex_c=(
 	'/^PCI_OP_WRITE([[:space:]]*\(\w*\).*[1-4])/pci_bus_write_config_\1/'
 	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
 	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\<DEFINE_TIMER(\([^,)]*\),/\1/'
 	'/\<DECLARE_\(RWSEM\|COMPLETION\)([[:space:]]*\([[:alnum:]_]\+\)/\2/v/'
 	'/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]\+\)/\1/v/'
 	'/\(^\|\s\)\(\|L\|H\)LIST_HEAD([[:space:]]*\([[:alnum:]_]*\)/\3/v/'
@@ -260,7 +261,7 @@ exuberant()
 	# identifiers to ignore by ctags
 	local ign=(
 		ACPI_EXPORT_SYMBOL
-		DEFINE_{TRACE,MUTEX}
+		DEFINE_{TRACE,MUTEX,TIMER}
 		EXPORT_SYMBOL EXPORT_SYMBOL_GPL
 		EXPORT_TRACEPOINT_SYMBOL EXPORT_TRACEPOINT_SYMBOL_GPL
 		____cacheline_aligned ____cacheline_aligned_in_smp
-- 
2.47.0


