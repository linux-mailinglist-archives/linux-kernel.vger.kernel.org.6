Return-Path: <linux-kernel+bounces-190374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5197A8CFD69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092501F210F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582C13A895;
	Mon, 27 May 2024 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LivJDHPu"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633413A3E5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803245; cv=none; b=aLHCwFtowMRkL24JkG1PckMxpxQKVTlqoOK9PEuxXiWW7iCd00lno7bLpo3d3ZG+Db28LzgEZOhkUDoO5eWtlRD9E4D+LM6oeQHIj1uYysOkys+lLsU2tv/Va70ijQJoMth9vzmfe9gAZvwi0AKK0JpASaclYwQT9iNeMCQmcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803245; c=relaxed/simple;
	bh=mogT9CSK+Vk/ExDHgD2Bj+5ISdL3rSJDhZAR+YNxGEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IuOD22XGFINLn9R2mPZ/i9fB9doI/+ggg0nwDAxgMEBf/UoeswaqUIsFc/Q0gew/nrp7bL8LSLTimFgEwP1z84JDUstzSqCDlv6amE5rTLSfMDpBav0tPgpftJrzBh01phO92zPPCl6MHyTSMXD2mQlmy+6DQ6+avHw5Na6tCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LivJDHPu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-681ad26f277so2220693a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716803243; x=1717408043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50caWXAQ+sC+cT9R3qngK0AJe0BNtDYXixsKN4qP8Dc=;
        b=LivJDHPuPJoBcfee9TkkAmqa0wF+xzjlwdh57bg4Vurb/s9P9QUGC2mAqbSOLTN7Vg
         8V2XNygVo95gKTMzm8QH5n4GK+EwG8N6D/jxkKmsmNyNfdhqzcdUDAmWajmYWqi3/8kX
         Iw4i7fSuL4hURjdW9Cz0/h1J8I7KPvicNwOhM5SCVjQw/fLfvaJf0k32T2O20muZyPTS
         t42xlsC8RFL6Zr+8Zaa26gLrr0Wq2KZkgMoN6HNpxSiNJ/e+ZFCBuSOzPTil8lNsmle7
         6C1Obs106cGoGBqiT4EOvomQFFNx2V9qwm5hlOqrSDUHJnpPHvCqJ6WN91CYlTdQo7oh
         kZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803243; x=1717408043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50caWXAQ+sC+cT9R3qngK0AJe0BNtDYXixsKN4qP8Dc=;
        b=eCMTyEMhZtQcQp156xXjZ3NBENoMqtMkHMaZnFngojP0xkn7aXT4q0C26WkH5gEqsq
         XgYMBCfBujKDFqRTRYKzNE1LvE719TcwwIEi9MhLCSDozVGwfdA9xRAlHm2I0dfvUjXa
         NCiV3CG0NsGNrq1f/TbB+IhHWuN4KgEykv2k/JvRL+uqx2BTstRz9yKy1bKjdZ22AROq
         7D60D0hpomUdIfR2KW2TCV2gRZE+nogTOgdKF4IBQImknamPB/qTywmyeF0ZySdJ6zoi
         fVKK/Ps2xlRXNNgkCT/Wvk9ITeuNHDVLkSawORMfyCimq0fvK2xw5qelCrza9zGpZDKf
         CbPg==
X-Forwarded-Encrypted: i=1; AJvYcCVzkQpSOazKad/z8yB27gRe17zWZvs6Lr2jn9QBQTgigI8lq5L/vqI5KNj4Fo4r6CD1yVKGF4KgpgpeZTU957IX02GK8sWa5+XKW51b
X-Gm-Message-State: AOJu0YxK4qKfpKdIFJKqk9qSotfYD/CeS8LTINVUexxQxqUgn0VsojQx
	TO0iWrhYnsRGT9qc/qsjXaVLyr4wiOnpUpGB4imevVte37rVwG8Y
X-Google-Smtp-Source: AGHT+IEDc4LAFSKqNq5l9LzfWWsnC59oJ3ZllKmfg3ST/QQZBYyxM+DacHLuQWZE3lQ4rKv/W1CerQ==
X-Received: by 2002:a05:6a20:72a8:b0:1b1:c745:5c66 with SMTP id adf61e73a8af0-1b212e64d95mr11249287637.54.1716803242578;
        Mon, 27 May 2024 02:47:22 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7d1b39sm56788195ad.116.2024.05.27.02.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:47:22 -0700 (PDT)
From: yskelg@gmail.com
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: skhan@linuxfoundation.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH v2] tools/virtio: creating pipe assertion in vringh_test
Date: Mon, 27 May 2024 18:46:05 +0900
Message-Id: <20240527094603.23481-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

The parallel_test() function in vringh_test needs to verify
the creation of the guest/host pipe.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/virtio/vringh_test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..43d3a6aa1dcf 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -139,7 +139,7 @@ static int parallel_test(u64 features,
 			 bool fast_vringh)
 {
 	void *host_map, *guest_map;
-	int fd, mapsize, to_guest[2], to_host[2];
+	int pipe_ret, fd, mapsize, to_guest[2], to_host[2];
 	unsigned long xfers = 0, notifies = 0, receives = 0;
 	unsigned int first_cpu, last_cpu;
 	cpu_set_t cpu_set;
@@ -161,8 +161,11 @@ static int parallel_test(u64 features,
 	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
-	pipe(to_guest);
-	pipe(to_host);
+	pipe_ret = pipe(to_guest);
+	assert(!pipe_ret);
+
+	pipe_ret = pipe(to_host);
+	assert(!pipe_ret);
 
 	CPU_ZERO(&cpu_set);
 	find_cpus(&first_cpu, &last_cpu);
-- 
2.34.1


