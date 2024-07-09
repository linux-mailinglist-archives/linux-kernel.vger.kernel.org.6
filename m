Return-Path: <linux-kernel+bounces-245187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDE92AF6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02EA1F21EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7212FB37;
	Tue,  9 Jul 2024 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZF9/QzDs"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429812F375
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502708; cv=none; b=l2vWLBF7IMKUdNOGxegUzwz3ZkrPslKUu1ersIKHyi8VbuC8BzIpIC8OQsO4/afw3cOl7sNoOPgBNYVZ9uS1ERuP4351oaT1kHK5XYLUC0LpVue42MxOJXXydD+nthf+Ktd6HoeuAVtLXkWJ6GZU64gmGJ7ou3UFYgup7scSoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502708; c=relaxed/simple;
	bh=k8MRUbhHkjOhILYB9mNRHhZKXLPJOg91tgWozGH8p2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gTUC+eRZIGupMw2GxFW1jmRnI8/IGU2YlQ6qmYaC45NOHBlEX7SjxU36xfb8A2NQiDiFzvaK5zf9R8dY4dzNNyVoyKI24FJZxQ9sh34EaAnHC5Eg1/AO29hbezjQrLwT7N3JcCHI8nEUDRlmciJ5dOtVhnuYVWxYfw9gWC+Q8bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZF9/QzDs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fb7de2b22eso13816025ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 22:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720502707; x=1721107507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AHTcN0faUMJUQ+dWhhUWTakw8XF64osRGcEYZrolzvg=;
        b=ZF9/QzDsGRTvBgsvbFWW3ekyuGRQCHShUTH4i2aOzKMqGco2k8Ooq4lNDPLWl5EOS9
         Hc4xYygaElEKe+Xn0Wa4U8bjrSuc9+PbEV+R34undvmBF/mIuZMSMAoZybD3f3Akb+84
         GNMfK8dSSYJTN0rR9b4IWHhtZCiKQJHnJf6v7oDqhSaV8wG0NqI6dMlMWY4K3FQ/kwR4
         34yebpiKFVXxlzk+yIozUpchOWAWJznVtflOdyybkcTCyG7hsdzieOro0KVb0sAQKPu1
         FLjQ+ibf531zAu7o3cHrIfx9AjizHKwVTCdeG76yBrf1EhVyyzoCyzm5Pn6jshMr8T4t
         NJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720502707; x=1721107507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHTcN0faUMJUQ+dWhhUWTakw8XF64osRGcEYZrolzvg=;
        b=f6B5vUR0JiT/XkQb9L3pT4X7IEMlo4HF7Uf2XQPAS8hlaRyET/YN380aPy4/DDJaAI
         NibNc89iA49WhKr7lePfFHdzgbOYd1xGdUzXLnTkE1ZWjmUFArhTDN39xqGbh3792mdm
         TLVWbJMkdCUHy7qr8KaRrAK49YnQB/pYtf2ATWzuO/hWmp6JzFd83ht1uIhIZyerJuyL
         yaQyytcU32CHo2dj/mjdRBbX4ksfw6uYyUFFvA4fCuxrw+FVc0A8WFCZ+WKXtAlp0yuh
         Z1dhxsL9wXsgm7BelyprgyDulWSt0mxAdstGRU8sSYWvFt5ZZt0UaKZO5cgbbOLEHoDO
         aGAw==
X-Forwarded-Encrypted: i=1; AJvYcCXfTMU+rShlMxQIPi+JMagP7DaxBym0b47YraTtPSSZYF7mn/uWjElxYSfnLx/iOfxzQ9rfoxkIHsGPWZSiSyUHZcjZrZ25IqMYnKJN
X-Gm-Message-State: AOJu0YyzPVRfxT0T9ztGx1eRwxSx1nRUefPcAxCbVXVj/Zkbc4zojqVK
	DZKtw9o/7nqRVjESxZNi3tkWmnjtTqFxCEoe4jmg7z/eLRNBJ5XuqaI6FVdvsdDkNFcshCbsPrw
	m5a+6RIpKDd17QoRFx4zd1Q==
X-Google-Smtp-Source: AGHT+IFqkigwNChn9ZO8dagAV/GIuoI2PUbi3WxOc4du1EalVFiLpGj82NqNA7X5LLKRQkgdamAIk+tn/NG2RxzfPw==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a17:903:120b:b0:1fb:f03:893b with SMTP
 id d9443c01a7336-1fbb6ecebc2mr1499475ad.11.1720502706764; Mon, 08 Jul 2024
 22:25:06 -0700 (PDT)
Date: Mon,  8 Jul 2024 22:24:08 -0700
In-Reply-To: <20240709052408.4032665-1-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709052408.4032665-1-yutingtseng@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709052408.4032665-3-yutingtseng@google.com>
Subject: [PATCH v8 2/2] binder: frozen notification binder_features flag
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


