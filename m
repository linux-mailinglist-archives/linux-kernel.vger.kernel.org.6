Return-Path: <linux-kernel+bounces-343095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B19896BF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF971284B09
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B651C4A;
	Sun, 29 Sep 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JTkHnp8s"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6C2263A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727634086; cv=none; b=bj4u/OQgPExsw0iLp905l4l88MFSND0SSB9fQQf1aKgy5FyhT4oFCwW0LX0wB2g5KrY57oa3WOExLN39JRNgx0Yom+uQmt34yx0QAGYhjtfseZpmdD0d9eu7ejB+pGo2xfQn8oNhM565rMPYtKOUwqPLunDJYGM8FBIgCj8+t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727634086; c=relaxed/simple;
	bh=IiI7k5eKIv3t3egjU4Ltp6qafG9X3D4ad7adQ1hTsrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hmjm2XHTEed/ENiuIo5oQPkGFLz/RACSkNEH/AN6s4VFLM19TFZHCLZz5EejW0ucf0sCnLXbu6lJcQR2eaLB1zARm/oc2qBieuL1EKGujcx27AWeHH2gUcocswedg7o7QNfvDi84Yt8jMLX7reTqDWNZ0k4hnqcUJUhRIoRSLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JTkHnp8s; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E6CF33F2D4
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727634080;
	bh=NcSFbsIXgiNSIJxntSXwkK9zAY/t+TLdWZ5xLvbV6u8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=JTkHnp8s6k+gJbbZgFS4BB1kLdAjjM7ktdb/5StUZ3B7Fepl9qIC/ssnTA5BFFEst
	 QHn/NCi5ePPNTn3LJenRjuyn7j1YykP0buURCX03+ehUIdA2E9KMDXoQRcgf/Dgr6i
	 pl53t4ao+RO4FOiCLBzPfp+/q4BPII3a97MwBYrCmtvetum7WMnr320xKQC1H7v9Sc
	 VdNdA63dh9mPfMA/GkWU85BhpiKGxqK6jKI3wAEFdXh+kWg3yBvmFmaGKJ8oJJksB2
	 AktGuBlSmXEHnvJDSr3o80XnK1B7oWC6I8Rk+DpJRx3mHKrZl3eLOFmY1RlFerFlMI
	 tIlZagQO0gBeg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8d13a9cc2cso332947066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 11:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727634080; x=1728238880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcSFbsIXgiNSIJxntSXwkK9zAY/t+TLdWZ5xLvbV6u8=;
        b=X8tk0bBpIwpYr2bvUTQEdfPk8HQfEjnqYuLEW4PHfHJ1ebYSxXB1XhF4x8qbWaRFbT
         W7Xpnp4HBEsNjp5NOSZdYzy9KPsOWUqNeQ2WMaq9Sqq1Ns373zj9SNUp3BP/Kzoo4KoP
         pY9L5E9vodG2XWQLJQ7cos/ylHc+DXVv+N/UJ6b0BNaDCH765jQ00kTlSCzEBwl10d+F
         TNptbp81jZz1/XE4yPU6txWM8NMeh5cg6005kzGznurT1n9b5Xaf8vuE+7BeX5RGKrsp
         StNcba/dU9Vt3yrdiYApeKNJ/2a23+bU887qyYgvyngRML/morhGsMIlAJpwFQMYFDp3
         rZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRMZhwpdTprFqEDHXptuJTs6hfkLI7cUoB5ML3/pMKDc05OmRSn/VVZkZpaMIzBBLYwQTTF8GvsXkx2HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrx62uGojZPZ3o4tFBDXNLT/Z9o8/01yWK77e0olj0Jlg0q8rg
	Uk6/Y6m4Oxukio41gDRXNwJCIkwU454e27OFHS5fZ5Xo1AXw8QcVI2rWqS0wrw7NgaCXrtvieAY
	bg+9pIcNz+b3Tp89QiUCG6v/gob515nE8c9q02W8JtxfelA62jgGAIpBgNah5Av50zlkBFSF4OE
	5kHw==
X-Received: by 2002:a17:906:6a02:b0:a8d:2c00:949a with SMTP id a640c23a62f3a-a93c48f2108mr1109687766b.9.1727634080069;
        Sun, 29 Sep 2024 11:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/dwfX8CpFC/wMaqb9ON9AqBmf3Q6FpW0kLVPD+7epq6zvyosEb7pk9U9oZmP8xLkgLxMtPw==
X-Received: by 2002:a17:906:6a02:b0:a8d:2c00:949a with SMTP id a640c23a62f3a-a93c48f2108mr1109685266b.9.1727634079417;
        Sun, 29 Sep 2024 11:21:19 -0700 (PDT)
Received: from amikhalitsyn.lan (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248af1bsm3420056a12.75.2024.09.29.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 11:21:18 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: stefanha@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost/vsock: specify module version
Date: Sun, 29 Sep 2024 20:21:03 +0200
Message-Id: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vsock module.

It is useful because it allows userspace to check if vhost_vsock is there when it is
configured as a built-in.

This is what we have *without* this change and when vhost_vsock is configured
as a module and loaded:

$ ls -la /sys/module/vhost_vsock
total 0
drwxr-xr-x   5 root root    0 Sep 29 19:00 .
drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
-r--r--r--   1 root root 4096 Sep 29 20:05 taint
--w-------   1 root root 4096 Sep 29 19:00 uevent

When vhost_vsock is configured as a built-in there is *no* /sys/module/vhost_vsock directory at all.
And this looks like an inconsistency.

With this change, when vhost_vsock is configured as a built-in we get:
$ ls -la /sys/module/vhost_vsock/
total 0
drwxr-xr-x   2 root root    0 Sep 26 15:59 .
drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
--w-------   1 root root 4096 Sep 26 15:59 uevent
-r--r--r--   1 root root 4096 Sep 26 15:59 version

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 drivers/vhost/vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..287ea8e480b5 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
 
 module_init(vhost_vsock_init);
 module_exit(vhost_vsock_exit);
+MODULE_VERSION("0.0.1");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Asias He");
 MODULE_DESCRIPTION("vhost transport for vsock ");
-- 
2.34.1


