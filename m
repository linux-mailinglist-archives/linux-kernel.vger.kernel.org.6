Return-Path: <linux-kernel+bounces-287375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5FF95271E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17606284385
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC43D62;
	Thu, 15 Aug 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WUhHkLsQ"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136815D1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682785; cv=none; b=S+qDYPupOZKrRMQI/T1MI2aLCNZr9OHVPX+goL+HXgyet70CA1/8HhKy4p2WwK5PE0EXwludRs9ncSnMU2bsRU+eRaO+sWFl4iTVVOg8nhTbrjOBAdMX/yjejHLh3PcGXvaxlfkfc4awUbleAvt7/okUpLm9uG3gkvCFKVnjcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682785; c=relaxed/simple;
	bh=MFpYAqAur2CBTuwezZFu2fjaPugZ2gH2Pu9bI39ap9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAEmJDuWH0BhxuW/S6UHhoMRs/Gy/soDPi5hyOAjaKBoAaEaD+31UEWQWmuTq1osdiHplEMZV6QcKmcyGqYb1NQrGpfscQ7G5fuV3stN1XXijllLN+6ftVEDidCKgk53l+rBFwPoyXQRf0q00vnOSliHaaNbUJVzdpdjPUPkngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WUhHkLsQ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093890e133so30920a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723682782; x=1724287582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7eQNG3qJiwvs9MNyrho4kKV2vMWG5TUUcItl6qZj48=;
        b=WUhHkLsQ6qmf7EMmG12baVU79wFo2WK2aoqyEoUidkWLiAq5t+mse4CKSJanDNvvVy
         ylhHP1OsLZX+6wUDMNeYOrkbHGWGlIXndMiJn9DnSepcYDrkctklfo5mUIfBdeNdcBGV
         CSFIvW4NUsZKJrj8cHDf6zLb0zfYSyHbQDZgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723682782; x=1724287582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7eQNG3qJiwvs9MNyrho4kKV2vMWG5TUUcItl6qZj48=;
        b=d2IAnytrfl7dgGHwmVEekqZa1uW1YHOBpwQvsZp2gVn23xOvOr8MXMkywWFskiV8Fo
         RtGJAdljVgxEoBOeCDuxTUSFXVStfpGUui3PGZdETOC5BbynwUIStQ57buNyJPlil6GZ
         9t8iOz0CfykCcPtx5SCj54bR/JS2LfRLqBI32KsfHsZNZ5CVOdpMTwCMFks1S/CqKEzY
         E6rmpqQxz0UXAhHh5j4/wvbt16/IMdZ4I9wATiZmaf382fyrbQLAYhuavJ3RkZEpLBGh
         z0tDwpFBQXbmpR0fH1k5e65L7c+KsP3VmifS0WsYif3ubeNOrhAu3vZJ9Y/ELrZiBPMv
         AgoA==
X-Forwarded-Encrypted: i=1; AJvYcCVi8ifN5jxlwTTX2uYr8K9XjEITjurXcYzgQNTHlAqdOWvIPtVFze/DnuqztfbcVK1GXTS8GCVVifWarBcxrywC96NFYJvRcKJhP6AA
X-Gm-Message-State: AOJu0YxVVPk//gAVURAfLODznupK1G+Xbh+K1iyhwLgpQi3e3aHHzVFU
	ve0nGZxGZaXrONqusBJdaVcqGIyY4cqCTOFERCUrQM4iAKwFHGjJOqVX5cIW1Q==
X-Google-Smtp-Source: AGHT+IHSVf2Ro3Z8JmcPhwCQkLbT2k7ksoTCsp6QSWAbLA5ZEaTIF51XkrLoFFWSu23YtxtemeDyEg==
X-Received: by 2002:a05:6358:569f:b0:1ac:efb0:fb3a with SMTP id e5c5f4694b2df-1b385aeced1mr85394055d.2.1723682782595;
        Wed, 14 Aug 2024 17:46:22 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (140.248.236.35.bc.googleusercontent.com. [35.236.248.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd9072sm2165626d6.15.2024.08.14.17.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:46:22 -0700 (PDT)
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
Subject: [PATCH] virtio_pmem: Add freeze/restore callbacks
Date: Thu, 15 Aug 2024 00:46:17 +0000
Message-ID: <20240815004617.2325269-1-philipchen@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic freeze/restore PM callbacks to support hibernation (S4):
- On freeze, delete vq and quiesce the device to prepare for
  snapshotting.
- On restore, re-init vq and mark DRIVER_OK.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---
 drivers/nvdimm/virtio_pmem.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index c9b97aeabf85..2396d19ce549 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -143,6 +143,28 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 }
 
+static int virtio_pmem_freeze(struct virtio_device *vdev)
+{
+	vdev->config->del_vqs(vdev);
+	virtio_reset_device(vdev);
+
+	return 0;
+}
+
+static int virtio_pmem_restore(struct virtio_device *vdev)
+{
+	int ret;
+
+	ret = init_vq(vdev->priv);
+	if (ret) {
+		dev_err(&vdev->dev, "failed to initialize virtio pmem's vq\n");
+		return ret;
+	}
+	virtio_device_ready(vdev);
+
+	return 0;
+}
+
 static unsigned int features[] = {
 	VIRTIO_PMEM_F_SHMEM_REGION,
 };
@@ -155,6 +177,8 @@ static struct virtio_driver virtio_pmem_driver = {
 	.validate		= virtio_pmem_validate,
 	.probe			= virtio_pmem_probe,
 	.remove			= virtio_pmem_remove,
+	.freeze			= virtio_pmem_freeze,
+	.restore		= virtio_pmem_restore,
 };
 
 module_virtio_driver(virtio_pmem_driver);
-- 
2.46.0.76.ge559c4bf1a-goog


