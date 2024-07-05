Return-Path: <linux-kernel+bounces-242428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D86A9287F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AD81C21776
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B5D149C50;
	Fri,  5 Jul 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cX73Iud5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989A1474C9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178910; cv=none; b=uk3DImjn+EbU0/gFf2zoF68MAu4osRprFEGTnb4OlFv3Z3g8WdO1FmdJnho6wztNsfPl3itkIyqhiVKEdU3pMOZmNlS3LjEkNavi0LeeKkBDTK7HEyTyvQ+9BVzKQMVPmgPPoHsq1O52MdIOxjg4kGvV5Bl6c/fapslFTTboxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178910; c=relaxed/simple;
	bh=lak4dxsT08I8rYU4tKXnZja2wg0MZqfxAJYkErSmlII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lufSGXVYsCRHY1jdb4sbAl7ap3Mat+648uPHNW3kswMqsMqJUMEjPBJEbEtP+J6Nu8mf6Csgfw+lYal4w76jApwmv/ji8nZFL2bW7wOIw2+33/jE932pvm97jqy5K2Xv9YWTHKDOqIK+xbmvdWVUx84CG1j7G3Mac5F0dcxWB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cX73Iud5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720178907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUSIGduRuPTLuIye5guuFOEZVZ3eQUaOUfXk4TJeX/s=;
	b=cX73Iud51AOgEHAlWW81AMWWhHrWPPgMXibvT4NTyBfagZbYflFEddQlCrs3kOzk8kOQTq
	Dn8UOcKJ86UgMCSMI9KxDnHcEw3ag7rrAzuP4Upxpd2RvILsHvaEwAJ4VJmjxAl5joEWnP
	e54CSuPrkBXrrnvL9QAhomEiQ/rTB6E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-xIOwxTa0MoGbzu7YeNlM5w-1; Fri, 05 Jul 2024 07:28:26 -0400
X-MC-Unique: xIOwxTa0MoGbzu7YeNlM5w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42567dbbd20so11919145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720178905; x=1720783705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUSIGduRuPTLuIye5guuFOEZVZ3eQUaOUfXk4TJeX/s=;
        b=OVMBoaXE5+BTbh/hwSv8KaiZsiPMaW8efa7UlHoem4XOBwvEk9/M5EB/TdrVCtV/tV
         nl9moHIQCXg+urhuCXV1TkLGQ3/Q5+jRbK4Q5vmvDXWxeuVjkvz3277BLfU97dHSIKtf
         MeXOa8ChP7LXMK0bofualFAoXztSrpaFJ+++Z0S1FnonjqmpEPEyqxbqagmuzuMQfxlJ
         ntbuksZO0rGCDKR02yUkw9PKALaS2Hqlc0dGedNrgn0IXUIV4RCqaDWQmheJyTsBcMqx
         sCMGPf7DMBG+BigwnnpWlBJ8ZSOiPHPVakIGNcFrANvR0p2g+jZaCqQFkmFzk8BIgNCw
         YKXw==
X-Forwarded-Encrypted: i=1; AJvYcCUzVPbU76Gqg731PA4nOJ4kxsNyTTe7xqT2P6adkDrKks6UL2O6lMqsSa52zg/i8mE/LBGOmQoLNs5hvjOxfhCIgWFUwW19e05oaMsz
X-Gm-Message-State: AOJu0Yyh+2UoqEJKz1qvJ+JTO4ZXWn6jtpjuIJF8zmG2+30LJXqqOJOV
	WIVZXVh6eejrgG1lz1HEoKX4u9Z0VoF2ar+yuyDD01iVgI2I3awS4dv7Zj2bZu9TDH3fC+3vr1O
	VmlfzJFTr4Siic7ttrGma4hNp7A/CVAgpcX8KzBVZBZEW3hRTMsPZdZtwGyL9Vg==
X-Received: by 2002:a05:600c:230d:b0:425:6424:357a with SMTP id 5b1f17b1804b1-4264a45f760mr26729945e9.35.1720178905462;
        Fri, 05 Jul 2024 04:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXn1FfE3jKyhkXLC5OprjObAGEx5l00fijgonR1jxhZlWMGrSQ/t0Y3OWTzi9026CPeOS7QA==
X-Received: by 2002:a05:600c:230d:b0:425:6424:357a with SMTP id 5b1f17b1804b1-4264a45f760mr26729835e9.35.1720178904690;
        Fri, 05 Jul 2024 04:28:24 -0700 (PDT)
Received: from step1.redhat.com ([193.207.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a29eab73sm2774662f8f.41.2024.07.05.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:28:23 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Date: Fri,  5 Jul 2024 13:28:21 +0200
Message-ID: <20240705112821.144819-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vDPA block simulator always allocated a 128 MiB ram-disk, but some
filesystems (e.g. XFS) may require larger minimum sizes (see
https://issues.redhat.com/browse/RHEL-45951).

So to allow us to test these filesystems, let's add a module parameter
to control the size of the simulated virtio-blk devices.
The value is mapped directly to the `capacity` field of the virtio-blk
configuration space, so it must be expressed in sector numbers of 512
bytes.

The default value (0x40000) is the same as the previous value, so the
behavior without setting `capacity` remains unchanged.

Before this patch or with this patch without setting `capacity`:
  $ modprobe vdpa-sim-blk
  $ vdpa dev add mgmtdev vdpasim_blk name blk0
  virtio_blk virtio6: 1/0/0 default/read/poll queues
  virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)

After this patch:
  $ modprobe vdpa-sim-blk capacity=614400
  $ vdpa dev add mgmtdev vdpasim_blk name blk0
  virtio_blk virtio6: 1/0/0 default/read/poll queues
  virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index b137f3679343..18f390149836 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -33,7 +33,6 @@
 				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
 				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
 
-#define VDPASIM_BLK_CAPACITY	0x40000
 #define VDPASIM_BLK_SIZE_MAX	0x1000
 #define VDPASIM_BLK_SEG_MAX	32
 #define VDPASIM_BLK_DWZ_MAX_SECTORS UINT_MAX
@@ -43,6 +42,10 @@
 #define VDPASIM_BLK_AS_NUM	1
 #define VDPASIM_BLK_GROUP_NUM	1
 
+static unsigned long capacity = 0x40000;
+module_param(capacity, ulong, 0444);
+MODULE_PARM_DESC(capacity, "virtio-blk device capacity (in 512-byte sectors)");
+
 struct vdpasim_blk {
 	struct vdpasim vdpasim;
 	void *buffer;
@@ -79,10 +82,10 @@ static void vdpasim_blk_buffer_unlock(struct vdpasim_blk *blk)
 static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
 				    u64 num_sectors, u64 max_sectors)
 {
-	if (start_sector > VDPASIM_BLK_CAPACITY) {
+	if (start_sector > capacity) {
 		dev_dbg(&vdpasim->vdpa.dev,
-			"starting sector exceeds the capacity - start: 0x%llx capacity: 0x%x\n",
-			start_sector, VDPASIM_BLK_CAPACITY);
+			"starting sector exceeds the capacity - start: 0x%llx capacity: 0x%lx\n",
+			start_sector, capacity);
 	}
 
 	if (num_sectors > max_sectors) {
@@ -92,10 +95,10 @@ static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
 		return false;
 	}
 
-	if (num_sectors > VDPASIM_BLK_CAPACITY - start_sector) {
+	if (num_sectors > capacity - start_sector) {
 		dev_dbg(&vdpasim->vdpa.dev,
-			"request exceeds the capacity - start: 0x%llx num: 0x%llx capacity: 0x%x\n",
-			start_sector, num_sectors, VDPASIM_BLK_CAPACITY);
+			"request exceeds the capacity - start: 0x%llx num: 0x%llx capacity: 0x%lx\n",
+			start_sector, num_sectors, capacity);
 		return false;
 	}
 
@@ -369,7 +372,7 @@ static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
 
 	memset(config, 0, sizeof(struct virtio_blk_config));
 
-	blk_config->capacity = cpu_to_vdpasim64(vdpasim, VDPASIM_BLK_CAPACITY);
+	blk_config->capacity = cpu_to_vdpasim64(vdpasim, capacity);
 	blk_config->size_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SIZE_MAX);
 	blk_config->seg_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SEG_MAX);
 	blk_config->num_queues = cpu_to_vdpasim16(vdpasim, VDPASIM_BLK_VQ_NUM);
@@ -437,8 +440,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (blk->shared_backend) {
 		blk->buffer = shared_buffer;
 	} else {
-		blk->buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
-				       GFP_KERNEL);
+		blk->buffer = kvzalloc(capacity << SECTOR_SHIFT, GFP_KERNEL);
 		if (!blk->buffer) {
 			ret = -ENOMEM;
 			goto put_dev;
@@ -495,8 +497,7 @@ static int __init vdpasim_blk_init(void)
 		goto parent_err;
 
 	if (shared_backend) {
-		shared_buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
-					 GFP_KERNEL);
+		shared_buffer = kvzalloc(capacity << SECTOR_SHIFT, GFP_KERNEL);
 		if (!shared_buffer) {
 			ret = -ENOMEM;
 			goto mgmt_dev_err;
-- 
2.45.2


