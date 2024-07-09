Return-Path: <linux-kernel+bounces-245293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C692B0C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F159D2812D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D113665D;
	Tue,  9 Jul 2024 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1jWRyne"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A59144D00
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508534; cv=none; b=l3HSjGMSaNSO+3xm8Awc+QDrims/p6dF1tdeUGyBEuK9E/0HgS2xHPRya27IfmboZI6psFh2guBRocMvs02JkDlPsESpJDciTfzQJgK7aEdEpX2lYdiN6een1A9g8BkwPvs91oRjd0E/uvv3otig9kxxdSXVT4aUaXTi+0dO56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508534; c=relaxed/simple;
	bh=5xUmkKG5yUqtRQH+3cQPuwgEI+tcDwblj3IXj5ZwSsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiWt2JP/a0Y0PK8uSPVopywjbAp1xjejtVbtZZwOQTG/A5Agwti/SXaxCl4BlwVsK2uYLH4MRWIRpdldjP8nbGhfOrT8JThsKIJisXQYUzjKz8uhB/GMshsIs15UcY8AsmTyeekq4fcnv17sxRqpbMEMOqhdcvtMUIHjoJFjups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1jWRyne; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70b2793d2ffso2619736b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720508532; x=1721113332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAQ4RhEaSV+8bv37ytSMZxXztdW5gICJdrjwG4uRu7Q=;
        b=I1jWRyne5iig0tfzzXFKe8xMQ5Z2CVanD7BLtwB4Q53/+wCIUem5yBAUnvQ40IKrQw
         eHtD3qkSp0AxkoheAytGkyqU7iQM67UYWcJR1GE8W8uR8b5ZWEarF+n8+31fvohAXbDC
         R9Cs3ZzA57p8cbmkv9AJnRptGsHxd+DJ3WEuxtF8yxsdxgW2sqEHLaoYkWYvMTpEzHhg
         DoqBnSjO38Yze6hGLk02D8B9gKmceyCBhlSUtwISbhNONoafluPtCI2Szav/gEuiGYW2
         CnUCYGWjr2KRpK/cjZ09Itec5zMwr8uagnDn52h8eWaQxZorUUO+9SlNcguCLnlz4kMc
         9WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508532; x=1721113332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAQ4RhEaSV+8bv37ytSMZxXztdW5gICJdrjwG4uRu7Q=;
        b=YgPn1o6WOErBwThalDlEdUozqndZ69Md/WF47250FS3oZywn8EMwkeEQbmnaE062Xd
         WstV3jAMz0WGIvK9go2hPoAdlygkg0M/4/cBIz7BRrf/j5bnjARJDx+/1PtTQG6iZ4Hz
         LmPA/Jlu82MzptlLfWRcTXjqFA0bxJ/HphSlyT3CCbdZ+ZGuKzck9e+DJh/sfaIR8Bnh
         E7dh7Zg0PY8fZMKsIcduliC1OiUx8lx894ji5rUf1Jat0bFQIdbWr8rKNO1CRpd8W5g9
         34sgSbkU/zKM85P7+/WotbLh916zbYHbTq36dX40HO9IVrNrQUMoGQ+w+Q4DV8aZQick
         WQyg==
X-Forwarded-Encrypted: i=1; AJvYcCXJOGmEN0BQPT4u5LD49tyXk324CEJO09y1XpCbDKCLzl009TVHIDSm6B8k/d6OFvrXDNd0xi/9keuY/EZkvy6O6GlLx1eblenSbcHm
X-Gm-Message-State: AOJu0YxgO+0PMFSLLiH8ddmYALPCVoovkpDIHdNNwEUI/Lhzm37pfQcz
	TjyXHpL6249Z+KrdWGZ13SLh/5mAjZZyAur1Cj0hmpRSw3Nyq1XNv1Fo1qQAF7SNwoavirjhu2L
	kbByu1BSh1bi/8n/sAz25fw==
X-Google-Smtp-Source: AGHT+IFZ6HGLxBbQ21Ag5zpQKdf7/L/04/aI8mayaAqZpVM2pnQitaTK7U0E9NuFS7pQVWcWQ16Wr6FTb7YRoe5rFw==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a00:2d84:b0:704:26cc:fe68 with
 SMTP id d2e1a72fcca58-70b43650a22mr109757b3a.3.1720508532370; Tue, 09 Jul
 2024 00:02:12 -0700 (PDT)
Date: Tue,  9 Jul 2024 00:00:49 -0700
In-Reply-To: <20240709070047.4055369-2-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709070047.4055369-2-yutingtseng@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709070047.4055369-6-yutingtseng@google.com>
Subject: [PATCH v9 2/2] binder: frozen notification binder_features flag
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
V8 -> V9: Add patchset summary and changelogs.
V7 -> V8: Resending patchset to the correct list of recipients.
V6 -> V7: Resending patchset without --in-reply-to.
V5 -> V6: Separated the binder_features change into its own patch in the
          same patchset.
V4 -> V5: Merged the binder_features change into the same patch.
V3 -> V4: N/A
V2 -> V3: N/A
V1 -> V2: N/A

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


