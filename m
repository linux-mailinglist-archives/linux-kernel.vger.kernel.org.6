Return-Path: <linux-kernel+bounces-331021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60B97A757
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE301C2334D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2478F13D28F;
	Mon, 16 Sep 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpIRAiPz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4103D982
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511589; cv=none; b=kIvPJIAAR6En2sGTr6lXLr1tMbqu/1dB7vRYIBzdPnVUexdFORUbJEWcgHP4xraOB3hPqGKrgxDejnr9aVwuNV8Tqj/eeH2xoRsxq2podUdEzN87qjgAQGXPZ4YwIqiRLPdXDTaVRMTXrYwlbnwmt0qLP56EToE2jrTurVhilXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511589; c=relaxed/simple;
	bh=hm48JXEIf4Qh3L7/EGK5bJzmwt2Kku2kiNSqtmDfgs0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HgBFp+UNvfP/4DXBX3N7enee8xw/87uKYUhtVdydhC8Ou3Eop6IAN2MOT8IkQ6CjgaGnbTuxN9a6kzWA1lPvTjjdWq3oOwmrXxPBCWOyQqiTGMvSDAkwo2cT5SPJz4JRuv2cscv1Z7pI9Fla+W7IGapgAMkrIu/gi6sQvQ3cFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpIRAiPz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726511586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=X7796kQiN8JkFcyUNsQBv84LTsmrMbLlpHtIF9rU9QA=;
	b=EpIRAiPzXplnZS02gf6lW+wpdr1cl4ZHij3X67dYFAwequv/jzZP40R843xNApx2lrhxuo
	HHryrz0O2BhMfQQIsFwo1wiU+OO/nvoFvuSCiWdnQpm74U2UIg2Qzc9EWWgU4bDHhgt2F7
	mKKw4ib9+wBPe/Mf8ytxewFJWhc7vyQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-6CA6bgkiOPaS_ZCekU9Ezg-1; Mon, 16 Sep 2024 14:33:04 -0400
X-MC-Unique: 6CA6bgkiOPaS_ZCekU9Ezg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso33847265e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726511582; x=1727116382;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7796kQiN8JkFcyUNsQBv84LTsmrMbLlpHtIF9rU9QA=;
        b=nJkDtMVbXFzWmh5Yq2SAJ/mVneMlrjz0W8xT0W9OHrbEMx/FG8B3hCEwiduRVasJGH
         YyEFPWTJeQfmWHg6HvkfmP/O0YzikFyGZIRTSwBM0W5DA8eKuOEXKe0SQwaZ07Mg1vnB
         5cos4AE7qMEo3wmZKtyzJk17lxXuOLo+E4R7Km/iioymHFPebUIej+2g5OcBWA426VqC
         IW7WGfyOqNv8Tjb9TeF8S/DIkWhEjTYg8jrr9EwLOMhk/C4B6UYkNg8OHRiiGwoMJotI
         F9pj/uHdKPW2h629RBOrnVnZApa5RUUCJCWxbR+ohLN0FYme1aFFNSH0vwRxt6bIunzr
         ICFA==
X-Gm-Message-State: AOJu0YyN4cKD52pueay++vKIbYeN9iZUFVBgfoEpO0C0y5G99R2qlOoL
	92UR1MyivDeZE/jtIeA34J2lPgZTK7uhzwuGS8EzRqYxD3fTrfqi0TyL9aMw+2YJEq8vLJbj7bU
	nGOKhs24hHwf2mB1JFxh5jD+rmMXm+5kykFQLtifRKwnvlhOEBFruQzVr+KgJf6gcxRtSrXpczm
	HKE20DAxlRtnhtwGuwDubU+wWukjjpkfAPOPVdvQI=
X-Received: by 2002:a05:600c:4744:b0:42c:b802:47bc with SMTP id 5b1f17b1804b1-42d964e091amr121067915e9.34.1726511582202;
        Mon, 16 Sep 2024 11:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4xlYytPGyDiOdL8yrJF86iAslRshUMMEUuSrQQ7TqZWWyRpaqYywxdlMlP7eGHt2ui8gMDA==
X-Received: by 2002:a05:600c:4744:b0:42c:b802:47bc with SMTP id 5b1f17b1804b1-42d964e091amr121067625e9.34.1726511581620;
        Mon, 16 Sep 2024 11:33:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:9b4:46f5:ba16:343e:7485])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b15d3ebsm117113315e9.28.2024.09.16.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:33:01 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:32:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio_console: fix misc probe bugs
Message-ID: <ad982e975a6160ad110c623c016041311ca15b4f.1726511547.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This fixes the following issue discovered by code review:

after vqs have been created, a buggy device can send an interrupt.

A control vq callback will then try to schedule control_work which has
not been initialized yet. Similarly for config interrupt.  Further, in
and out vq callbacks invoke find_port_by_vq which attempts to take
ports_lock which also has not been initialized.

To fix, init all locks and work before creating vqs.

Fixes: 17634ba25544 ("virtio: console: Add a new MULTIPORT feature, support for generic ports")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index de7d720d99fa..bcb05fc44c99 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2007,25 +2007,27 @@ static int virtcons_probe(struct virtio_device *vdev)
 		multiport = true;
 	}
 
-	err = init_vqs(portdev);
-	if (err < 0) {
-		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
-		goto free_chrdev;
-	}
-
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
 	INIT_LIST_HEAD(&portdev->list);
 
-	virtio_device_ready(portdev->vdev);
-
 	INIT_WORK(&portdev->config_work, &config_work_handler);
 	INIT_WORK(&portdev->control_work, &control_work_handler);
 
 	if (multiport) {
 		spin_lock_init(&portdev->c_ivq_lock);
 		spin_lock_init(&portdev->c_ovq_lock);
+	}
 
+	err = init_vqs(portdev);
+	if (err < 0) {
+		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
+		goto free_chrdev;
+	}
+
+	virtio_device_ready(portdev->vdev);
+
+	if (multiport) {
 		err = fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
 		if (err < 0) {
 			dev_err(&vdev->dev,
-- 
MST


