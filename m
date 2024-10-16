Return-Path: <linux-kernel+bounces-368774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2739A14CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD041C2238B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830C1C4A3B;
	Wed, 16 Oct 2024 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRK0nqLr"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5E1865E2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114303; cv=none; b=ma2xY/Kc7/ZI/gpmD9xWtqi5MoSIdRivs97Taj9GTts0xsudkeYpMU3UNVeXfb2dQfcVot/EP4pTKouQmnd0oMLB0VnC4jiBMt+58iBJsKvvr2oAGcd6JJJ5jNzlYmZo/8B9EVGVAQ0cH2aD+xWJoRRVhrbUSFsvAQvo28vAdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114303; c=relaxed/simple;
	bh=nRlqtEMsqxy6aKjMYhdBNmJILg6PrdAr1LA+9kaixuQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LcGmmJcqmBvO4SwlPzc4p90f+Mz5bYaH8rMl+fMObd6x7BGwFp4bu6SkXLrxDE+bejuT1ZqVjCfcHJ26Zb6w2o85Xu09D6NxDFLeI27SHvVHYcnN4p9lJptAho1q3Wz4Ggnpza/yZoKSoyauGKQx2uMGLgkdk1sM1KDeIQZysNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRK0nqLr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2070e327014so2211225ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729114302; x=1729719102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BXptLlLi8/LBU0AsGt6M3UhadzKkAlLyCjh46uIpkZM=;
        b=bRK0nqLrKYailv3AWK5wIBGaMJQYR9WNxMhKZzjql8BeU69va9KjJTMtGHNqS9e3I9
         OVlk/bZZxjdqoyoTuKzBeht785q6Lqj95GBJG0KA3wDOBdb4b53vhv/+ojIfGTxhRJD3
         ufb5IYg1FPweOatk7P05ktUd/LqpdVZuy9+Pj5FNv/jCVXBlCFzOKd7yxrggNKfuz2Ux
         1d1Ngrqy89JzXKrDr5ybAA46JmxELuQAGILp9fhmT44r5+9bHRpkvIPbS8dZvTTMRBEq
         YObhQfPgNM6boROc+S5sYw9IP9Lad+vZ7Q0IXWGm5lHhgtpN0wCWkhB7fpnvi8+qBmeC
         PeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114302; x=1729719102;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXptLlLi8/LBU0AsGt6M3UhadzKkAlLyCjh46uIpkZM=;
        b=kksLQIQcLETW7EghtQ1nu1GW/6hvvGkHbW9/MedM4YD4bCg1lOmf70FaBV5DOfVSVn
         y0W0Rm9kqppnkdV7SCWlLgyM0yN2gNMOqcAc3FOGwUW6JjQaQE+Wv58I4RLKhQeg+elY
         qdo8MjcLEb8c8PITexKFZQvYW4jQgmXt9yUc1rzmbjNONi4QVCvXrDZbK77SpLrOBZsZ
         1zTKyz0duuVt5UbwXXfzzIc5myGZCyKn7qaeQKJB5yDW8pjrKQx+TqOWNxypNujP7nK3
         BjARYXqeJstgA6udiE5dUEGW4rjP85MkwfLItLX7IgPZdr4aKzUOLbhyIv2GzSNfgfRo
         0rxg==
X-Forwarded-Encrypted: i=1; AJvYcCVIkl9B47KoYEljv4oScTF3l/Vn3fh+NHBlMi1DS0vsHxRy3EDVy/zQRJuJLHtJ9iNGz5MVlfwe3ZicpIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzodMYaVqrL4BMvluK9n1hCEYvzUG9O7gejhmXRa2y76hmnA5Ck
	dp/5oxuTqlUXGFCiBVDiyT/gAquNT796/YMssMLPJr6UPGEYYwQJ80pHw5D0nMWSWq0Cm2Ny4SJ
	9XF3W3jeEt3TGzBH0r41g1VR4N6TEDg==
X-Google-Smtp-Source: AGHT+IFBdMmX234DaXsAlmM7MfzNBEwsw8QhZPXDdS8L95+FFk1iKjLmNXEnaw8p45IZR6ap1EgsSyZrMkzymru+d3nU
X-Received: from abhishekbapat.c.googlers.com ([fda3:e722:ac3:cc00:d3:6212:ac13:b90b])
 (user=abhishekbapat job=sendgmr) by 2002:a17:902:ced2:b0:20c:9678:e179 with
 SMTP id d9443c01a7336-20d27ef7ca4mr170645ad.6.1729114301551; Wed, 16 Oct 2024
 14:31:41 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:31:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241016213108.549000-1-abhishekbapat@google.com>
Subject: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
From: Abhishek Bapat <abhishekbapat@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Abhishek <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Abhishek <abhishekbapat@google.com>

The initialization of the max_hw_sectors_kb value is performed by the
NVMe driver through the invocation of the NVMe Identify Controller
command, followed by the subsequent retrieval of the MDTS (Max Data
Transfer Size) field. Commit 3710e2b056cb ("nvme-pci: clamp
max_hw_sectors based on DMA optimized limitation") introduced a
limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
(MDTS = 5). This restricion was implemented to mitigate lockups
encountered in high-core count AMD servers.

Currently, user space applications have two options for obtaining the
max_hw_sectors_kb value to determine the payload size of the NVMe
command they wish to issue. They can either execute the Identify
Controller command or query the kernel. In instances where the
underlying NVMe device supports MDTS > 5 (128KiB), the user space
application can potentially create an NVMe command with a payload size
greater than 128KiB, if it fetches the MDTS value through the Identify
Controller command. However, this would result in an Invalid Argument
(-EINVAL) kernel error, preventing the application from issuing the
required command through any of the kernel supported I/O API. Presently,
the kernel exposes max_hw_sectors_kb value through a queue sysfs file.
However, this file is only present for an NVMe device if a namespace has
been created on the same NVMe device, necessitating the existence of a
namespace to query the value of max_hw_sectors_kb. This dependency is
semantically incorrect as MDTS is a controller-associated field (section
5.1.13, NVMe specification 2.1) and should be accessible regardless of
the presence of a namespace on the NVMe device.

Expose the value of max_hw_sectors_kb through NVMe sysfs to remove the
dependency of having a namespace on the device before accessing its
value.

Signed-off-by: Abhishek <abhishekbapat@google.com>
---
 drivers/nvme/host/sysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b68a9e5f1ea3..1af2b2cf1a6c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -546,6 +546,17 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t max_hw_sectors_kb_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	u32 max_hw_sectors_kb = ctrl->max_hw_sectors >> 1;
+
+	return sysfs_emit(buf, "%u\n", max_hw_sectors_kb);
+}
+static DEVICE_ATTR_RO(max_hw_sectors_kb);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -687,6 +698,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_max_hw_sectors_kb.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.47.0.rc1.288.g06298d1525-goog


