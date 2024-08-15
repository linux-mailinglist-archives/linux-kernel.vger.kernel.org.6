Return-Path: <linux-kernel+bounces-287397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0643952752
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186B21F225ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCAB18D650;
	Thu, 15 Aug 2024 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WOA+bQzP"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC73BA53
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683431; cv=none; b=kOtbhKbxdFeVLhy2hEXZrPSu5WKeH+RR6BRAvJnlXOpjWZEFqd40CQOpwjyiDY6NWrLAz1Fw0m7/zWJXFAa0vLCeRsTqRRpepqXneKVmE7+mzpX2wkFTPymYmeEbrv+L4IqN8fFH2hbrnKkne0jAsx7rjCATnYTILD6XObsgt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683431; c=relaxed/simple;
	bh=368TiaxNIcxCK60CWSg8TX4WbROxX/ctY6baf9Uo4PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAhxNM70SYdME1Svsgu/WXxZTgppibHo50++YGCM9jc5H1HlymmI33a7LWTQkujHkrUNd7EWIZz+YDtwg+CAzFEuzNKQQlout+P2eztpaQfLq6hbx47ese1cvWPBotR4bBpioSomF5b6iWOVZEKvae63GtRNfeGRlU1BScfiz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WOA+bQzP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1dfa92d8dso4528285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723683429; x=1724288229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mC/qr8MXY+EwHkMGwD4N6qk5mBndc0DNrIK0ECikEHI=;
        b=WOA+bQzPZ5SnJwHjCh2vDrzvWXRoTuPFlQ2rG+iNdCWQ0PYJo4Uzd0kV/x/iyfzOkt
         Z2bH+jiOd7lmh2L7ybFWoTA+fwWt+c3yKU3tBjmsycGw6WDMxYgBlWI7JeOkfRdGozJ2
         Wb6lEzzxOjlpWUg4w7AlfK/f4d8HkaF3Yz+vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723683429; x=1724288229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC/qr8MXY+EwHkMGwD4N6qk5mBndc0DNrIK0ECikEHI=;
        b=lKoo233EVHsmMAptrpqeouqF5zqaVtK+k1gOZW5d0/6UUptHhQ8X1Kxa7MUJQKZIyC
         vvP79cdJlvY/B0bkEShQN4IKJLMbdjzAKHrMN2pqnMRzKizXEti4Ty4X6rDcq7dkpeL/
         dxFakJNJilTsXGYkK1VBkewfrC8niVpLG+42p8tEU8MsLQzt4LCWlqlIWY74A4Ti4vOd
         urYkdse+eom4SdIceN5IopyNaXiOx8CAi0B45yK8+md6m7sTVU0TPM7+TmdJobHn0Xm6
         lu5XaSGJNafIFlMFbVsjYfE5K7n6Qawsfgq2daWZudJEKXRGACKEvLOfcehWOkmKCWhm
         0q0A==
X-Forwarded-Encrypted: i=1; AJvYcCVsB0Q/f0C1VDYSmvsAyaRCTT9CpNCobwnxYZBe+qYGHzuU+d72G6ryMr7fHEY4BtjigHSp+f1UBsl3M34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yykd67Uw+ZZnaWa2fXdH474qLPtCH4A57v9Z3pmn0hDM8mIM
	gUcWyMvRB9bW/MM7FStmYDfTTJjkUQMEH0vEByLPQEHwk1ejH93ckKRw+qo9yA==
X-Google-Smtp-Source: AGHT+IFzFS1cAkp04Ak5eb02FF38FZuq4vN9/hrIFBugIoOlifoqQbAf2j9hy/A1dl3myUgxjXWyxw==
X-Received: by 2002:a05:622a:18a2:b0:44f:89e3:e8d2 with SMTP id d75a77b69052e-4535bb75416mr28547711cf.12.1723683428894;
        Wed, 14 Aug 2024 17:57:08 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (140.248.236.35.bc.googleusercontent.com. [35.236.248.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a07249dsm1977581cf.89.2024.08.14.17.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:57:08 -0700 (PDT)
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
Subject: [PATCH] virtio_pmem: Check device status before requesting flush
Date: Thu, 15 Aug 2024 00:57:04 +0000
Message-ID: <20240815005704.2331005-1-philipchen@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a pmem device is in a bad status, the driver side could wait for
host ack forever in virtio_pmem_flush(), causing the system to hang.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---
 drivers/nvdimm/nd_virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 35c8fbbba10e..3b4d07aa8447 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	unsigned long flags;
 	int err, err1;
 
+	/*
+	 * Don't bother to send the request to the device if the device is not
+	 * acticated.
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
2.46.0.76.ge559c4bf1a-goog


