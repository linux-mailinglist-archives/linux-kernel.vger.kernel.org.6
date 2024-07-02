Return-Path: <linux-kernel+bounces-238552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E00924BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB41F23578
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7CC17A584;
	Tue,  2 Jul 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX0VDV+s"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222E41DA32F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961512; cv=none; b=hZWppnagH8Oi4PEz4LV2XOOTZdJQ3LFmMrnanTieu9SolNjn6oVvjDmjEWb62eRFKg439sadpACfb2dbw4hEXsi6WNRT3THVpBp463xeM3lpIhOAGk/Uk+9zzII9FRtYZhmiAXEcEgO40YWceudUjgQjvUW6rQjq6+VFogh4F3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961512; c=relaxed/simple;
	bh=GAZLNxCDl/VzE2feZ2Or9rZGG2bf2m8cFjRgNzJefBk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uJmZRcgGHdB2jQ4PMqsQ61TWSy9A1jxA6uKkhfcxF894bT/caoNzWKDo4PPZuDmT3YVvL4SPTlRRGqe8kSmMYWaUq5ZF6opApfwSRgymh6hnLwjp9zclsWvZouep0W/FHMaUhryfEXoJXKZk4pW353u/uqa6RECIYiatVLK2b5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SX0VDV+s; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6507e2f0615so2898011a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 16:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719961510; x=1720566310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sbCbDH8DWJ9lXy6bGpx3jz+av+y6CU73Pt4IvzsaJU=;
        b=SX0VDV+sNJeF5W+cIkf8wGxHeNXBAhrbgrB9UuoRUqPEflUT1UNhEDWGzJu2c69jhb
         jIUES9JvotAesQkTGdT5zfDmWliaceMw/ci+CbeTov5abjzOtQP57R9vK/iurvNeU6gw
         meAjm8UbxIZ1NmrsneR9FdPgSTxEgbxbfzR9sZZOK3cwehDZiaeUY8g8/+Q16hsZvTBH
         ekwqhRJ+B9KG4nUiMdFXLAYsaB/nHxbJQ6+oxiXdW6Lzaf829kuLPB5Gdq5ewPYzHydS
         ml7GDSs7ojk1NlPy9GkvuFeK+f4Kby372WSuSHTrttqeDv19uMfrt7aic74ymg0me241
         5Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719961510; x=1720566310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sbCbDH8DWJ9lXy6bGpx3jz+av+y6CU73Pt4IvzsaJU=;
        b=OLnRWYCA8pGcr86gygM2AatthK5hwIjLd7tfS19taHuvBm2yIiYPLDKRAY41412F3z
         WKb8SZFqgX2HxLwgw/yxuyqhI+RFouBO6IG7AaVFcKKc9dm09D37wq6NeKbrfwbey+jK
         8iIBYP5sNwXj7+bdLVKKkentPdMIfz7LIjmOYzHG4TNB+arDltFuDoPsc9q3Ebg+U16H
         uLYIyh6MljWoJ+VGnK/igoiK0yaC4IGl99zwm2CRuy/ZStZRErSywcoTQ0cIJTB5nzld
         cbDVL7jd5LV/44sw5nEJuYJ8X/R8jykn3ceq/e83diIXy17XqiQu+xH3Iu9sQxzuKvAB
         pPDg==
X-Forwarded-Encrypted: i=1; AJvYcCUnhjhxc7SURuszBPNTZk7rfETKes4Iofn3e9UVg6YoW5y74b4A1lQfxf/0TSDNUFLhAM7ItiBpGbsRshOnc9Oqtpgs2KeDLgOaQMMQ
X-Gm-Message-State: AOJu0YzxiAxwoXvxqv41wIARJjuvAXtCCE7OO+sAx39yN5kdy2othEWC
	fmhpeoNwK0tgJP93p3hyK1OCT7H0OUcI/YfMxkjdnBxM3RmLlZSyAO5p/JXppEY3Os9tycTUbCz
	JvND1as+PzFujocBjgnf1yA==
X-Google-Smtp-Source: AGHT+IHM1kQ3vOaWP/zy1B+T0BIwVrVldgIGWVYTZIiQiW6Vm1X7Dn2vlVibHWtc5rsRwr/S7PgQhHQcrVHieyzjHw==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a63:371d:0:b0:6e5:fc24:5fe8 with SMTP
 id 41be03b00d2f7-73ce1b5754dmr22650a12.0.1719961510026; Tue, 02 Jul 2024
 16:05:10 -0700 (PDT)
Date: Tue,  2 Jul 2024 16:04:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702230453.1441209-2-yutingtseng@google.com>
Subject: [PATCH v1] binder: frozen notification binder_features flag
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com
Cc: gregkh@linuxfoundation.org, arve@android.com, maco@android.com, 
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com, 
	aliceryhl@google.com, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a flag to binder_features to indicate that the freeze notification
feature is available.
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


