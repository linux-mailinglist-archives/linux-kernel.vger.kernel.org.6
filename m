Return-Path: <linux-kernel+bounces-444021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49839EFF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A580328626F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A51DE89B;
	Thu, 12 Dec 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mc5sO8/3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CB1DE3AF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043285; cv=none; b=L7tEhrMtOpHQSDNfmP6WdzUvSt3eRxcYMI7+FncpKo6x2vYS7nAiyEvljhYb5WT6EGt2knDHCnOd0ywMwBwBifz2nCtaR0cnKAEFQ8vWmlaFitedGrmoXenSjuEVmkhuhxve9jhNHTUoP4JRndkubUDUQpU/eT+4ShPUWbu+q3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043285; c=relaxed/simple;
	bh=QnID2Nngias2laFlMVHINRNQrpY+Vv1z4BU4mytckzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=matSNKjDyaJxSAXVZva04J4XYasPi4sF80vD63hIBGWJYZwQmSg6opp96SuKxzQz/1YYFTFeRmsBmSaaqDTTSdOH5+6jqUe8b+eAJ06f8pOlFh9RZWDSU284o1/AVBYm/CiMneb9yIuqaaRJ4kXJF7Eoakq0/sSXYbA1VQMQbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mc5sO8/3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216395e151bso7702395ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734043283; x=1734648083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTbCEHQ6hia/KRivi/ryuMVv6+i9eA+M0miy6FoyLNI=;
        b=mc5sO8/3S6Wp08VWV37d0JDfLVG2ESqb4yYByKOyUXCchu6TnKx3FYCHDJNYxn8JMo
         ztUeVaUcnL+gcS/QxnW0mJYhzRJA9OcWJmmZTi9AqV2pSGjLa3fIm5H/4wzJyvKSF+9m
         hyin09IheCPJ4YhK+dcD5AOor90w/DVh1WKcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043283; x=1734648083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTbCEHQ6hia/KRivi/ryuMVv6+i9eA+M0miy6FoyLNI=;
        b=LtnTmkuVGh1sGUZEpQ8bjCLAM16U1t09R7zPe/tlUpJTGYzdVhUOVmKu9pSFe29owT
         Jw/HWQIUNm9QHoL2K8EK+lF50RL9O6qEvjiIhTGjXsVmcJRO7PSh5sr9X9c/l6JAuasp
         YegU+qoPEDciQ/GmAfQewUavGjZC5asyFK1y+VRAbbDJvKZU08yxXaR0ciudQ28D7slF
         0xiAyJdxdUC2SbSWoaUDv1UOJd6cCsF4y5Qw6hqPNI3NytsYvP8g6EmCUzqmEuCcAiDh
         sDBz5odIdowPH1S+l7vr+/HTyq5MKYAlq7p/uMOdG7wJICIWswqNWUK6t+k9qeWzE/KY
         5dVw==
X-Forwarded-Encrypted: i=1; AJvYcCVXqp2YA0R/2EgXVesh9k2Ed+TZa4JZSC6nAzq5c0C3Cs1qPgBDEpRcF342JACJjyYwxTGNufcErAcTwIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SADt62gu3fRq8rSG25tjys1yAfdrSwKueSmWdYqa9yLBsebu
	4lg4bnhs+Lk365by2GioETqcxvFLEDgvjQKWXLPVJU8MvemUCKN47psUg4eeOg==
X-Gm-Gg: ASbGnctu2ovRBxeo9ccKmUZy4rfv5QqaAUG7ctulwwm9Z+DmJEHnZaky1X2y7WyxEDD
	rPXq9IlFbs8kFANmW2LYcs7LjlFI2vCws/sJK4cUGVDI9+wKYTSgUm2NEy2e+fQrbaDhAL9Qwux
	edkhn3vRclzEDuE/nvhzScsf7ugDgEL+9LiYalceRr5EY19RUQuaO4M4zKioi25sMNcMO8w0pSY
	X5gyTxv2e/4+4mz/JAsFfUzWTFCCdpIuemFJphrSYomqb1rdVAs7+v0UALT4kfXLKTHQOrSlYiP
	GzHEYqzulI5ywjA6c+GCI5IfXF7DCwxJ8mK34k6kjiHbMA==
X-Google-Smtp-Source: AGHT+IE7mpoXxnTF8cVAExncDjTsgRkgtqF/AwV3t/7KpNuP4yvLpiYHGewaXEWkm9gaAI1GF97u+Q==
X-Received: by 2002:a17:902:f546:b0:216:4fad:35d0 with SMTP id d9443c01a7336-2178c7d5224mr66505915ad.9.1734043283528;
        Thu, 12 Dec 2024 14:41:23 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (200.23.125.34.bc.googleusercontent.com. [34.125.23.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216281f45a2sm98579785ad.250.2024.12.12.14.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:41:23 -0800 (PST)
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
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH net-next v10 1/2] binderfs: add new binder devices to binder_devices
Date: Thu, 12 Dec 2024 14:41:13 -0800
Message-ID: <20241212224114.888373-2-dualli@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241212224114.888373-1-dualli@chromium.org>
References: <20241212224114.888373-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

When binderfs is not enabled, the binder driver parses the kernel
config to create all binder devices. All of the new binder devices
are stored in the list binder_devices.

When binderfs is enabled, the binder driver creates new binder devices
dynamically when userspace applications call BINDER_CTL_ADD ioctl. But
the devices created in this way are not stored in the same list.

This patch fixes that.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c          | 5 +++++
 drivers/android/binder_internal.h | 8 ++++++++
 drivers/android/binderfs.c        | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ef353ca13c35..0a16acd29653 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6928,6 +6928,11 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
 	{} /* terminator */
 };
 
+void binder_add_device(struct binder_device *device)
+{
+	hlist_add_head(&device->hlist, &binder_devices);
+}
+
 static int __init init_binder_device(const char *name)
 {
 	int ret;
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index f8d6be682f23..1f21ad3963b1 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -582,4 +582,12 @@ struct binder_object {
 	};
 };
 
+/**
+ * Add a binder device to binder_devices
+ * @device: the new binder device to add to the global list
+ *
+ * Not reentrant as the list is not protected by any locks
+ */
+void binder_add_device(struct binder_device *device);
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index ad1fa7abc323..bc6bae76ccaf 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -207,6 +207,8 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	fsnotify_create(root->d_inode, dentry);
 	inode_unlock(d_inode(root));
 
+	binder_add_device(device);
+
 	return 0;
 
 err:
-- 
2.47.1.613.gc27f4b7a9f-goog


