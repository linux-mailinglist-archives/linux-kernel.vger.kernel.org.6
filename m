Return-Path: <linux-kernel+bounces-302290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE3B95FC29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65791284357
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C9119B5AA;
	Mon, 26 Aug 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hv8qGdrl"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C3811E2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709214; cv=none; b=o3bdLoaAWGtb8A9OdIo4h3jPzdAIBh0igegh8AH43G/+Uh3MUmOr4qFAWIEN9S0FZAFQMzRzg2YE7zxqn8HQfOzln6Zd0licNDEsJWBe6YqxsN+RfO1jHlH8yaXxizs9vDWiHf2j5rwfJ4hyGcRH6NmTVHVTJ7hjLU+Jo3vBj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709214; c=relaxed/simple;
	bh=jTM0jAyh1dyw5X5cHLVRJ87Jic4NLyo+Ct0r7BxdakU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRmYcx5YU7DH0rzO3FYvwcoazDRchrJNaQYx/7JN88IXu750ZK4hvaNkFFpp64+DQJhEzOfAX7hqBYFV3PZv0dTzFOhVj/TZaWPEH2QVGn9Y3TWccAH3Xagi5La/HJWF2ZrkDnrFtHH7f0IZdWJyv6VtHJVR/l/N6PFArWpnsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hv8qGdrl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fee8813c3so28558821cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724709212; x=1725314012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SiSQOaTpyXJiMAgdm5YfXRHccf2gWIyjfptOmFMd/7I=;
        b=hv8qGdrlJsqmSPbg1cbkcSp0MOxZdLbMfHz4o91VCK+Miuke6Nhkvqq9RquhmAkoto
         2UftEkdkVoQANN4CC+n6HffdnUketXkNTpJHmeUN3dznByTYAkZKxHU6KNwc1+Q/rp0V
         +3tZUWOdJLyqC8N7uiTv8gu1CXw6NtfQaK8XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724709212; x=1725314012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiSQOaTpyXJiMAgdm5YfXRHccf2gWIyjfptOmFMd/7I=;
        b=U8FAuLYhuz3yo0vBPed3AgHlyyXr3s5Lzr2g/BWCSCo0aWAtFky0R3M5lfFqka+Y3w
         kv9Amw8ysfMmppxpeuGWgghKMJAQYAQN4JBjjocTvkrhku5V5SHbFzAR97BCX9ohu1Vv
         nKpGWQMdALrOKtQTL4EjHbsXya600WjRViWw5JM92T8sftBkTxv3Px+sEA6EHoRDwCN/
         MBpKVhhyYWAUg4LEODWMkPWUnXfjiv8UluHNEXNNX9CSA3wviT+rc/HDNVG8+vsI8hJg
         YXT7BNqA6od+OGNqnjvkBiE2ZECdTQpcVnW9sw98aCt4ZQdqVT7yrSBZvsDlXw/9XtG5
         6qkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJqp7oNlOfDd2ODeNA8uwdUcYkyM46OcMcfBdHJ8nHVDy77uum5dnLLkdFnM2hC0MquJUoeyCitAz3zJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4HDAhzovKTRV4SauzJRhPOQEVV7lhOSubifZsY6SVCONPa72
	vvYSUmsQJ3wYBOTCrBqVSp5lW53jbNnhCc0iGyRJTfxPZwz3TzWL4hgFUJSTcA==
X-Google-Smtp-Source: AGHT+IE+JAjPYPtVbxFqucyrZTzrAHx+x1/DGRvVRVS9F+m6AXkc7hPFywhHH29+pRV5Z2ToT6UMQg==
X-Received: by 2002:a05:622a:4811:b0:44f:d986:fe4c with SMTP id d75a77b69052e-455096453c7mr115032211cf.20.1724709211831;
        Mon, 26 Aug 2024 14:53:31 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (74.206.145.34.bc.googleusercontent.com. [34.145.206.74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f75b5sm47507521cf.58.2024.08.26.14.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:53:31 -0700 (PDT)
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
Subject: [PATCH v3] virtio_pmem: Check device status before requesting flush
Date: Mon, 26 Aug 2024 21:53:13 +0000
Message-ID: <20240826215313.2673566-1-philipchen@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
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
v3:
- Fix a typo in the comment (s/acticated/activated/)

v2:
- Remove change id from the patch description
- Add more details to the patch description

 drivers/nvdimm/nd_virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 35c8fbbba10e..f55d60922b87 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	unsigned long flags;
 	int err, err1;
 
+	/*
+	 * Don't bother to submit the request to the device if the device is
+	 * not activated.
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
2.46.0.295.g3b9ea8a38a-goog


