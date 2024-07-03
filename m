Return-Path: <linux-kernel+bounces-239980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A37926784
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3E11F233D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92F1862B1;
	Wed,  3 Jul 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDjsQj/p"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BD1862B6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029552; cv=none; b=HKdPznQlXbpEQ1svppoJSIsGd4R7lrLX/uE5Ex4tSE82AHytmhAuJhMbnOY/6pvBEUWCQfIH9xXbHz3HlCAZ1kFazlRw+XBAirAFqiMNBk4lESvaXJ98ZAmUbHZI2kHynU8mmFlK/xnlvTGAyF6zzxpZB5bWZD+nD59ay/2bkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029552; c=relaxed/simple;
	bh=k8MRUbhHkjOhILYB9mNRHhZKXLPJOg91tgWozGH8p2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iU27e9ieo9zYEvK/3rrBRHy6WRT2bKsLERkZdF/AcU5ar1tt2kDMR98VjDz1zQuKAiC8AIPjciJGpMGuBcbqDO63+hC/cJG0TSR5FIyFt3pRz8x+Y1M6Cgp0pG2KnS3h9DQqxxIoV45+d9ItDldvn1mtRkD/UMrD1bg3sqi/1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDjsQj/p; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70af0dff5c5so498203b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720029549; x=1720634349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AHTcN0faUMJUQ+dWhhUWTakw8XF64osRGcEYZrolzvg=;
        b=pDjsQj/paezW0GvrcXT+9tv5pGCrRphgek26RkKVUKu3ZW6FXmbo3gxRltl1lwUq5n
         o6dnupfFF/HWzY7oqiZGuItGtE1KUI1bE+MlS2QDHbntHKO2Sutnuv5BMCuk1yqmUnSA
         K0DNzfTsvx3ESp+4t9dR8cvFmqDm4JXEaj1SWsg2v9OuUz6+P5Z+QCazjlMWgzGyLLuR
         SeJhMbwE04uMwwQBOJiBV0mKwfS/1CT66jHsnlPOPx9cLqk30Epzxxchs4wNFUDi4V2K
         6XjU1LK82k7kCHDxl4WexWpU0HOvlw9W18j6SkYlG9vg1FxM3soveZER6KycYtKE1Y3S
         jRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029549; x=1720634349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHTcN0faUMJUQ+dWhhUWTakw8XF64osRGcEYZrolzvg=;
        b=GRxlPxtWKfac6kFhqi9FEj5s3epHEF2p30bPNLbA7tbBPo7QmfoOeYR1RYaaschGBU
         IAje5OKT8/bSULt+4FyL2oQYgDn4pSoPiPvaCAF3p02kthwwL51UhKYYdJYzSnQehsHn
         OZ5u/6FkVLrnpA11aQ3z8S+5mznAH+yatTbOnrSG4M1I956hGazBvrpogpGkBszGJISR
         Zj9MFIzp72It6UrtZX5KDEH4Cs3b6fIeSfjUZ/oGJkVOrfadaSvdhBhOG281+knIuLxK
         /FEAN/NRVL4bZBoCqWltrkHRNgiT5FReIcT3sCjK+lAa2aawdamvjVhq0VmjSuds5OEj
         Q1lg==
X-Forwarded-Encrypted: i=1; AJvYcCXbFk43rJ16KFTc0cnZ1oDgQYFg9E8Wztadzs/nstkeNCfY2RzPK68Qoq+8cP+NAYsEU++65cDKMD8KIneA7oEHEmm8eqw8p+PakfDQ
X-Gm-Message-State: AOJu0YzPP/C9tQXzOgAxp6HPiCxWHobVaKYxRUvBpzZU+mwHmOLJtVw/
	2VFX5ax2S1LqTjveYqXI9+1wWkxgHEbw0HB3fSINJtpEF0uAF5AKF9CiiAtKKuHk3IXYacvG32N
	BaJJ0AhDUWFhYWVAjcwLOHA==
X-Google-Smtp-Source: AGHT+IGqZmv+oabNfIyY7QWOxNI78RRfONrhA60hWQ/B6RYAgC+XSxWmus+o7V2NbSDMiKdF9hyi3nBkP/5YqnHE+Q==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a00:1913:b0:706:6b52:4392 with
 SMTP id d2e1a72fcca58-70aaaf0c089mr616345b3a.3.1720029548542; Wed, 03 Jul
 2024 10:59:08 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:58:46 -0700
In-Reply-To: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703175843.3639568-6-yutingtseng@google.com>
Subject: [PATCH v6 2/2] binder: frozen notification binder_features flag
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a flag to binder_features to indicate that the freeze notification
feature is available.

Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 3001d754ac36..ad1fa7abc323 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -58,6 +58,7 @@ enum binderfs_stats_mode {
 struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
+	bool freeze_notification;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -74,6 +75,7 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
 static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
+	.freeze_notification = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -608,6 +610,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "freeze_notification",
+				      &binder_features_fops,
+				      &binder_features.freeze_notification);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 5f362c0fd890..319567f0fae1 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	static const char * const binder_features[] = {
 		"oneway_spam_detection",
 		"extended_error",
+		"freeze_notification",
 	};
 
 	change_mountns(_metadata);
-- 
2.45.2.803.g4e1b14247a-goog


