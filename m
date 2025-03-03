Return-Path: <linux-kernel+bounces-542686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29CEA4CC70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CCD18968ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81C4239585;
	Mon,  3 Mar 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RRFK5+IW"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F79E237707
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032155; cv=none; b=qwX7GBwVzEA4O2CQHL/+lIKGrWhIslYeD9dleaAS1KaZmlSIoANw8Sb6JwyUrqFOk4znFuGxszdD87WLzCzn8GLS8p40xrYfU3mhJHtprZInNHr6OwmsL7lTGuwzKJ1fZJmqdtUlyM7yZjqdoM/U6+IzfPKngzKIFKfhpFCqSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032155; c=relaxed/simple;
	bh=VFQeuhQrmXgZOY+JfXBPbjeF37rWPb4GdeTObDb2Rf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1T66bnBnlzsg1LBe3WbchdWPOfiYRrNFYXMeubtadm2zmdQtdPPa6Ks81I5+B58QQE4mTNQsTb4rFlCTR0pOREOnA8Xy+gygFwJZ90atUCNwDx6q6gMejE1Vl/3D2VpaWMYN98TwRnm2K2ga9rUqPoc2PPMOLrj/apG92bQIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RRFK5+IW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2238d965199so35667605ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741032152; x=1741636952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqs6enPVx21oxb5GivnZU1DWbwEExp/3gOjrVfmP78c=;
        b=RRFK5+IWJQs3c2TMeNytKYerVfuXWNDsh/vWTzYJFLyt5xnIaTtm9JinCt1oMOMKpY
         LdvKYI+FXd2jgoq9fGh0x06Jgre6UYIS2yUiep0+mMa1+V3bkeq9CNo4qEghokE2hK2D
         N7r4Ctpe2UhwMS/kNzfVlJcqsKs1X8aOa13uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032152; x=1741636952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bqs6enPVx21oxb5GivnZU1DWbwEExp/3gOjrVfmP78c=;
        b=bTZn19/WGbc4TEnmWkrNcFbqOv1AbkLw4y2Oz+exYM2QnuyOB6+sHsfREkHM2eZya2
         SUKU5UhB9tdLVVXKN+GBVF4vantfhHHzGhU/zx7TfmHKFXyKXH62Cm36G9zrzVaNMvo8
         XZueT0G23K6f6eaukD4gpfGff22bKpx7M3638bICxJBGli4EgXdhJn7gUIzz5zze6z/h
         dMB1llTfx/Fx1z4WhlbXtIyCXgiT5rymbfW+u9s8d9CStTrClBpiZgCaYYToY2+6Zyb1
         CO21AQjRSB6vCwTwltC2iqoR0k5cD5drBSKm7SxijU0Rop8MfdEBxHQON5Lcfm85x4cK
         28cw==
X-Forwarded-Encrypted: i=1; AJvYcCWIvXSjFXLXIyWZ7A/tgEcCJ/PFJ7cXmQRQsP4AjyVVBiebDgYhUcYk54zhxdyqb0L4Mbgqkzh6Rz91w0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnznMLbr73H9lR5K3oVOxHT+mzi/PwOhYP9y9hcjH7R8kaa0Sk
	wHBbXGifcCFIE4386isCaahQfQl2M1spxRAjnicsELeu6t5xuwFr7Gxj0pzaFg==
X-Gm-Gg: ASbGnct0nrUE6ag8eyeT3i4MF6V4T/ck33PQWGxl0F0m36r78ofDEKIAQfCzNjG35a0
	W+1+eUGwRTVJm2iqdGMxc5qMY4jYbbQ1M3J+39I3LX0QnSbL1lVspItF2tRoDEv84DV69kigLpD
	6r3WVRavh5LZJ0IuUbWpw13/BjSO+F2jznzbzikGEFeKRMbDmRigutGvC6777PMNMMEMmDKKSNn
	c4VbZCz6u5xPzrqm7h4kb6biGwlU20Lx49fCOXSVrg8SfOPNWdfJm6oESOlp1JctsRNwuaJdbCY
	A21l+5GqIAr8LVRRignDKfBJbZmunaPcfm6Ytym/1UT5hnVVLAgjupoBvlcohGEjaKyR4bT9PgI
	Wa3DBwXhEqwyIohM47enSnEyvDiwwlEI=
X-Google-Smtp-Source: AGHT+IHEpC0wzYC9qpTOKYzyBCFKX1RplbM8mEpi5mu7LaJ5QXKsMTUayHNtXumG2Q6HyHXT6kFqmQ==
X-Received: by 2002:a17:903:198e:b0:21f:988d:5758 with SMTP id d9443c01a7336-2236924e748mr224147945ad.35.1741032152431;
        Mon, 03 Mar 2025 12:02:32 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc4b4sm81233875ad.171.2025.03.03.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:02:31 -0800 (PST)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v16 3/3] binder: generic netlink binder_features flag
Date: Mon,  3 Mar 2025 12:02:12 -0800
Message-ID: <20250303200212.3294679-4-dualli@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303200212.3294679-1-dualli@chromium.org>
References: <20250303200212.3294679-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

Add a flag to binder_features to indicate that the generic netlink
feature is available.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 94c6446604fc..b3d21ccd81f2 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -59,6 +59,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool generic_netlink;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -76,6 +77,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.generic_netlink = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -619,6 +621,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "generic_netlink",
+				      &binder_features_fops,
+				      &binder_features.generic_netlink);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..96e64ebf910f 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		"oneway_spam_detection",
 		"extended_error",
 		"freeze_notification",
+		"generic_netlink",
 	};
 
 	change_mountns(_metadata);
-- 
2.48.1.711.g2feabab25a-goog


