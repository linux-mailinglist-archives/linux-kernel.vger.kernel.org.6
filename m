Return-Path: <linux-kernel+bounces-524918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B68FA3E8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE9F7A878B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA026771C;
	Thu, 20 Feb 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLKq6lv0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1C26463B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094967; cv=none; b=qkyrLwKoR7B1LrzD+NzqA5PNuj9wVFOCWhloexw31/Yd2PWVyres4yz/+kATVFT/tWcpTkzG6JcZBJLmsacnZVyVMww/QHDjvgHNgLr5SpmVln5jb9HXrzyK756hRAfV9ZD3Rp0CkUpQvz9PtJKq9wo6F+dsRFkMOTYyFRJz7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094967; c=relaxed/simple;
	bh=cUeKf4PCCVtFVO53wxl3QweJJfWATQQ7W81yy0YfVQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S8bI+IDEpz/nsX//2Km9/J7KFxmqdjVAbiEIRSvJ0/neRxk30hBVBuocokNg8RwCmuMBGPJrI+6R2jMkQ2A1IhtXnT2jcHY1HXGj6hyeWp9BICIDvHr+YJ4aPkReLLRxfWghPZP/V/qlfjtmTSpk8s5BA5p7JCff7vH30RijLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLKq6lv0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740094964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=64ZpdAsvcI+F+rxDlYFyucFy3wRloEAxpqLq+Ucj4cI=;
	b=gLKq6lv0rjdqfS4tn1BQaLevv5gavFAPmI0+Zx1vHZLwzCq3eCG7YvFnb+SBvjZAmkUsbA
	B7usJgLZcaBYqGdPtD6Cm4CJHgAtTpz6U7IMIfm+ncLAwdmGmjqq6CobY62q8yxxoE9W9D
	aPDe6aXvisLTLf7bKGVhpqOU9L2rxFo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-WkgjWr35PWSIlwtfPwR61Q-1; Thu, 20 Feb 2025 18:42:43 -0500
X-MC-Unique: WkgjWr35PWSIlwtfPwR61Q-1
X-Mimecast-MFC-AGG-ID: WkgjWr35PWSIlwtfPwR61Q_1740094962
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abbe5ac36a9so255809566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094961; x=1740699761;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64ZpdAsvcI+F+rxDlYFyucFy3wRloEAxpqLq+Ucj4cI=;
        b=swlTwNL+RbtlqalbpnKXrHOy29HX1M9qTIf60twnerAFvQf7wW69gOojzIlyfePqEm
         YVO4099tlkw/qHEIRTl3af2iT5v1i4NuM5OdyBEtNvttb9Wgu1nDg01rgOt0AKvyRutl
         GqVzTbnet3UZOwn9wqWMptOxPYnxvjQhRQH1lgDpzaynzmcJWDsoB8vcLAzv6myJy7M4
         QkDMEb5FAqwL+mEKMHcDajdB9Nd/g1G8gJER+vZtek0bsdrUwYzxCeeN+zGcHFniCLoR
         SwOghgtgOLpp+jZKbYRdiyeOMdku5HaYtoPZbI6H+KY9dnMh+oCCf2K28LHYgo6MVrLb
         RmWw==
X-Gm-Message-State: AOJu0Yz9a9y50XfHiTVmN7/qaczA7ctVp6wNWidFAydRgKHuawO8Z2Hx
	qbDvk6Z+9QvlxpBmdK22uTmad7lUVo5Z+sFzdPFnBlsuMPjAkek7JXmhkghQUudzNyt3i7glY+g
	ZnCCVvc1FKejuOeFlfRCQ3pUgnqeIUanD55Dlc6cBnPZ785XByYwpnPQxysE5T4OWZHdgjd6mes
	78qlvHMylR02eMDOmaso6ZA2xfniLoCbsHABAKjwM=
X-Gm-Gg: ASbGncuyxDamAg0EA8nqvHzxm8hUSEREOI0c3I6sGOiD2zFBJjhTf70Hsv+fcNwBo84
	ZmCwMFs08L6oVc5Num6x1ndzyNjjVM+QX4RW+ExwAneLcSWEw6TlN1dY8wrv4sGWCSbVdtxk0ND
	Iqon0zgQ7eWOw8+7hza/DmgmLDwMStKSZzyoKfTDnR32vAqiR/anzjRx0KoZLbuZyc639AsNOUa
	J7+f4AO27ReJDWZMiK+7Ks6NKknyICI5YunclkU+GDaejIfS0eKcGP+NjcFa3x5FnpvvA==
X-Received: by 2002:a17:907:7eaa:b0:ab7:c00c:680f with SMTP id a640c23a62f3a-abc0de4f6f8mr58469966b.53.1740094961022;
        Thu, 20 Feb 2025 15:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhhgQ2tD8HKuJBp4jMU5+KqRB/WeK8wqr6fsH8j2hzo2w7lM401/yo0RsV3QgWvZIqWnWv5g==
X-Received: by 2002:a17:907:7eaa:b0:ab7:c00c:680f with SMTP id a640c23a62f3a-abc0de4f6f8mr58468066b.53.1740094960585;
        Thu, 20 Feb 2025 15:42:40 -0800 (PST)
Received: from redhat.com ([2.55.163.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb945da4a1sm934223766b.132.2025.02.20.15.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:42:38 -0800 (PST)
Date: Thu, 20 Feb 2025 18:42:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Auger <eauger@redhat.com>,
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio: break and reset virtio devices on device_shutdown()
Message-ID: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
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

Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
accesses during the hang.

	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
	...

It was traced down to virtio-console. Kexec works fine if virtio-console
is not in use.

The issue is that virtio-console continues to write to the MMIO even after
underlying virtio-pci device is reset.

Additionally, Eric noticed that IOMMUs are reset before devices, if
devices are not reset on shutdown they continue to poke at guest memory
and get errors from the IOMMU. Some devices get wedged then.

The problem can be solved by breaking all virtio devices on virtio
bus shutdown, then resetting them.

Reported-by: Eric Auger <eauger@redhat.com>
Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index c1cc1157b380..e5b29520d3b2 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
+static void virtio_dev_shutdown(struct device *_d)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	/*
+	 * Stop accesses to or from the device.
+	 * We only need to do it if there's a driver - no accesses otherwise.
+	 */
+	if (!drv)
+		return;
+
+	/*
+	 * Some devices get wedged if you kick them after they are
+	 * reset. Mark all vqs as broken to make sure we don't.
+	 */
+	virtio_break_device(dev);
+	/*
+	 * The below virtio_synchronize_cbs() guarantees that any interrupt
+	 * for this line arriving after virtio_synchronize_vqs() has completed
+	 * is guaranteed to see vq->broken as true.
+	 */
+	virtio_synchronize_cbs(dev);
+	/*
+	 * As IOMMUs are reset on shutdown, this will block device access to memory.
+	 * Some devices get wedged if this happens, so reset to make sure it does not.
+	 */
+	dev->config->reset(dev);
+}
+
 static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -384,6 +414,7 @@ static const struct bus_type virtio_bus = {
 	.uevent = virtio_uevent,
 	.probe = virtio_dev_probe,
 	.remove = virtio_dev_remove,
+	.shutdown = virtio_dev_shutdown,
 };
 
 int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
-- 
MST


