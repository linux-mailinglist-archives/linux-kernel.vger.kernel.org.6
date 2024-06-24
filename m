Return-Path: <linux-kernel+bounces-226993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF89146E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CF42819D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B1134410;
	Mon, 24 Jun 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsQclI5p"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050C4A2D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223268; cv=none; b=lbD4L+XcaCLeDWGZ6DEVm4Qtf97I+WLPcom4qap45oLBT8zyiv/EpbGMmPz6cX6mySPCTKeAx6jRAtjazG/c5TB7aZMDcJdM0RXfaNQbUMRVAjjqEylZ3U21m2HwalT3jeIvMeGtln0qmWDKu/Ka+X8mf3yQShVxGi3VTIQYcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223268; c=relaxed/simple;
	bh=PebdPvGqrmzS5oe05OjC+jip+HwRntEzpx7DBbsHDXk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nx0HY/QT7YG9szfsSfYNMzoKIDQHK9USUiR7ljW5ct1iRf4Qnmfd/KEQDVfPSKB28kZ3ylzpg25ikgji8jEEz+PWDei8YNoGFZleMmZh5BZo8bw80dIxLdGtTA3c2bLeXMXCMYJv74z975iZ8SndvU3F4QjNVXQbYFh97QIfSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsQclI5p; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfe71fc2ab1so9184391276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719223266; x=1719828066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5FVNLoC/hnhitK4NzfaIQHLLqsNbJYgmmmWn9laeoQ=;
        b=FsQclI5p4UxeKVoFAAHNaMFa14MEoA/5YCfkDvZmjytKlECgm3PjMWavTd6MPKuJ3D
         HKIwHtPWPCDVDoifps060kb18NA5IMC1jTWLyuAv2kPa3OtQIGTh+abqEict+49sMjEL
         8pxR4XytOKXA0Z+R4OcBclClDpD2k9mRvqLTvVIq/TpBkiLcL6xd8CPJj8KsEWOtQESv
         dE5ebaeyNt2LNET031YLIYoQY/mVqt1Y2szTqKTpD4g0v9Ty0Vk6lv4MTD89N4JHJ6VT
         m1KPKclA8INZz2XgAi0krwTPNj0YGMc3aOJXv3RIc3KakANzTXh5xC4ZJ0Rl+OwqBEjK
         pfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223266; x=1719828066;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5FVNLoC/hnhitK4NzfaIQHLLqsNbJYgmmmWn9laeoQ=;
        b=m+wz0+r4ZM5kAB3dfuezgcP2NvwpnbhvguZ/TlQD1FNxbYTiYO+Gm58qtMO8l5CUI0
         ytVWOx0hf/k9LwQVxCZx7egVZOZT13W4s+ME98E3SjyBALe/IrxLeotEILeBPwpkId7Q
         1EMUocEHlbsgYxaT3n3BenNO0yB21NXkoTE4Ha5wwV7fxYotp4BGBhcmT9U37Bt9KvCg
         yXBhVepLUB3FMm7f+WFYLfjc6hACQjBMl1+ELup3n9udl8xomaxtP4cDVOzCdbZSE7Cm
         gnPM9P6udng6cvfBvaz17PCnlNQcRe4SgEY4mR2/C0nwrPlCw8WVSARHUOjZ/V+FG+JL
         JRUg==
X-Gm-Message-State: AOJu0YzsxMR/MtHFV4kWp+4Il9i8JAbRwoFG2g/HWHqQ+PLTHlbx99Yl
	pTaDCZhLZeiWRu3bcOgmTMCn1AQ/P/oUjH+Z8MMBgCleUx5mP071WRrm9FQl01tO+QHSSU7dsY6
	uIwfUHbEslImXspbBP5k2DS7uB1NeS6NDtNsFTNgbwQ6PhACDFOc0BS30B/WYu7L8y2gP1B2vfb
	a+Mo+k7GSXHKyxpYcShDLJ4T/uRj+xJldZypPEumqcSAqFucGZnzU=
X-Google-Smtp-Source: AGHT+IGdojrjF14BcH862opCStBHNZbSkGLvFef7ShpC0RrqjnABknC2wQg3xouaGeScVp+P7cx9KBJlp7C4zQ==
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:209:3651:3b83:51d0:c2f0])
 (user=gprocida job=sendgmr) by 2002:a25:d306:0:b0:dfb:20e:2901 with SMTP id
 3f1490d57ef6-e0303f1eb15mr21503276.6.1719223266063; Mon, 24 Jun 2024 03:01:06
 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624100044.2949604-1-gprocida@google.com>
Subject: [PATCH] lib/build_OID_registry: do not embed full $0
From: Giuliano Procida <gprocida@google.com>
To: linux-kernel@vger.kernel.org, dhowells@redhat.com
Cc: kernel-team@android.com, elsk@google.com, 
	Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

Using $0 makes the output of this file sensitive to the Linux build
directory path. This is problematic for reproducible builds as it can
affect vmlinux's .debug_lines' section and vmlinux's build ID.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 lib/build_OID_registry | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/build_OID_registry b/lib/build_OID_registry
index d7fc32ea8ac2..06f242202036 100755
--- a/lib/build_OID_registry
+++ b/lib/build_OID_registry
@@ -35,7 +35,7 @@ close IN_FILE || die;
 #
 open C_FILE, ">$ARGV[1]" or die;
 print C_FILE "/*\n";
-print C_FILE " * Automatically generated by ", $0, ".  Do not edit\n";
+print C_FILE " * Automatically generated by build_OID_registry.  Do not edit\n";
 print C_FILE " */\n";
 
 #
-- 
2.45.2.741.gdbec12cfda-goog


