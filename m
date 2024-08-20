Return-Path: <linux-kernel+bounces-294394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E029C958D28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44284B23961
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EC41C37A3;
	Tue, 20 Aug 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kff/CVt0"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079D1C378A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174583; cv=none; b=Ze6VYIrZn+acNEskGIPhigmJ4GDo4Vg2zSycfcvO6mojVqVfWjN2WzFw9avNnhqXTZccntukn3frhtmycy1S1MqwzLoDGnJwvHCzBznc62XhobduavHytCSM3OEj0WAKRYK3wHg+7/ml8edkX4nR6INw2S2+kMgIX3SORzWhYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174583; c=relaxed/simple;
	bh=WoePu1j9VOd2T7GWO2R+V03LjT4GKPVJ+35Dd/6RTPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGR6LeEEwkxRlQ2yRofZsqM3SZ1hkJOv7wkDvBUqaShDIPHrOd7Py9JzQhjLZoS3W5EeYPTAV1IKX8hiRlPrwv+GxO0jcfs2W8N3vWLJQRMa8l+r/ltGoo4lpdSSgnu3DHJh/Qn8Fsu5x3uS3qCc6Yfh1qGqfnDvOGCyPa79MWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kff/CVt0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1d6f47112so406258385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724174581; x=1724779381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nG3sk+SGqgopURDWRpSLqodBy9lchgvdy2diDegZ/Gw=;
        b=Kff/CVt0KTooh+u6P4CjIVPWQv2+BFdT901XMi5DIa5LjMAOrnyFGVQcGdv+jJCorW
         BM2JZpKg2+kuaw+6p7wNKHJvOp/3UFdtHhwh4sHbAWeP0AE1feWF7v/hSibvGJBUQ6fy
         kVbe6EnpDs93BaHrRvFLcXtYNZiZXB7jcKvaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174581; x=1724779381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG3sk+SGqgopURDWRpSLqodBy9lchgvdy2diDegZ/Gw=;
        b=DDdQyLncbxT1ulXa63MFa4Ee/BHEWx96VQARvikwidjxFr9j74qyEGZtKzg5DeVHen
         QYEI8n2LQ/w9QaLgMvZCz7qDRN/LKGsdSUEzvG+2w8ry0vUjHNigrY2ZYQ279sxg86Ei
         Yp1r1+JhkU0X4huJjhdVpzEvVxC/Cu5PZdAhBHLuOD6AMh7m0tx4CM2jkgGWBTO8MGG2
         WBKaes7RU8VZrbvTCwPplqyg9Hj997U/HSlhjQ3WevE/2ayFbNsHmpLNT9Wu4c2bzd1N
         aWPAPsqgleXjE6kk3QA+lLY7U3fVE0ApS/tYIlNQkz3iaIQy+lqvWNd+KtgQwnQboB7m
         Giwg==
X-Forwarded-Encrypted: i=1; AJvYcCVbiql9m8SEYs6VUSdtgmi0OWNZ2rfNG9OpRt56X1NGchTsvdelZmeuMMEvJXglD4GH/ccy+Ctfrz4SDe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkX89xAPmuSCLUZmO47t/NfFQBilm8hkElh4ivyXJf6c8ehQqm
	BEyngJGGfU1f7SUwwjeQemwTAHpHi882IIslAjL8/H6uphHpmz8bLCdNTgBdvQ==
X-Google-Smtp-Source: AGHT+IGLC0VAnx3ACOqPL6vui1/41GTnaKvRUKl8IQ/H2tHfiWeItGJfBZfdI5j/ZjUY1Sk7SMbEsg==
X-Received: by 2002:a05:620a:370e:b0:79d:7ae3:4560 with SMTP id af79cd13be357-7a5069af85bmr1549222885a.55.1724174580540;
        Tue, 20 Aug 2024 10:23:00 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (140.248.236.35.bc.googleusercontent.com. [35.236.248.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e42e9sm545390885a.88.2024.08.20.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:23:00 -0700 (PDT)
From: Philip Chen <philipchen@chromium.org>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Cc: virtualization@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Philip Chen <philipchen@chromium.org>
Subject: [PATCH v2] virtio_pmem: Check device status before requesting flush
Date: Tue, 20 Aug 2024 17:22:56 +0000
Message-ID: <20240820172256.903251-1-philipchen@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a pmem device is in a bad status, the driver side could wait for
host ack forever in virtio_pmem_flush(), causing the system to hang.

So add a status check in the beginning of virtio_pmem_flush() to return
early if the device is not activated.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

v2:
- Remove change id from the patch description
- Add more details to the patch description

 drivers/nvdimm/nd_virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 35c8fbbba10e..97addba06539 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	unsigned long flags;
 	int err, err1;
 
+	/*
+	 * Don't bother to submit the request to the device if the device is
+	 * not acticated.
+	 */
+	if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
+		dev_info(&vdev->dev, "virtio pmem device needs a reset\n");
+		return -EIO;
+	}
+
 	might_sleep();
 	req_data = kmalloc(sizeof(*req_data), GFP_KERNEL);
 	if (!req_data)
-- 
2.46.0.184.g6999bdac58-goog


