Return-Path: <linux-kernel+bounces-521238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60CA3B940
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E727A6DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510CF1DE8A0;
	Wed, 19 Feb 2025 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aFjB9evW"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E61B415A;
	Wed, 19 Feb 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957208; cv=none; b=Qt+lCDbbqypR93TmLNJK0++Myq53gFZdD/kaS60CGky9+uWeSpUEgnyTtg1SGPJrbPvoAE8/SZa+fHJeK5HPNmpTJAsIYGH5mYlusQT3C+8xgiAWhIdVOXICZfscE9tLNAWXxrQiSVPewCjjt1wOHuMY4wAXWj8TTSHLY1TjrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957208; c=relaxed/simple;
	bh=4UGM1FekRgOfsruEiTlnKjc9jZUaZSyzM5lT1beBgJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eoz2++q8LaO3Kk9PN9ZdRLu9UqYhy3W681dbI1CDryVAoAXTrqhKRE/O4iMMusIY2+XawniRSK1BkWUkr+zQ7+k82fv6sexUC9WXH3Fsd4xe4VTOa1bZAiLc89+XcyO0vKYcfOJ+ly0qUjP9GC2xXTp5C9O2mYozy4XfD40Gazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aFjB9evW; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Dg3dh
	jMTMTxLS6YB64TD8j0OjFqGRh6x7mAaExjXwYs=; b=aFjB9evWC16kNEhBY7lGX
	CG2k7F+J3IJQIMRl8ECp262OdxNJu0koKVSYp6AspGjm7xXkYTHfja50ZT8/pn0D
	AuFAnHwD00I8wdAMd4pHQEGeniB5NZ82wSoOsb+rDSDQQ5xj4U3/47417NDQOhNC
	og21rkyryCAx0f3QJDMW+E=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3k+Klo7VnI2XxIA--.27790S2;
	Wed, 19 Feb 2025 17:25:58 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] usbip: Fix the error limitation on max_hw_sectors for usbip device
Date: Wed, 19 Feb 2025 17:25:55 +0800
Message-Id: <20250219092555.112631-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3k+Klo7VnI2XxIA--.27790S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3KF47JrWUZr45XF13XF48Crg_yoWkGr1xpa
	4rXFyrtrW8GF43Xw45AF4UJa4Yvwsxt3yrGryxGw1DCFsFy343Wr97CrZYkw47GrWUZ342
	yF4DXF98GFW8WaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joiifUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbi7hX4q2e1ohMiPwAAsW

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

This patch fixes an issue that usb device through usbip protocol,
the max_hw_sectors will be limited to 512,and then
read/write rate of high speed USB devices will be limited.

After the commit d74ffae8b8dd ("usb-storage: Add a limitation
for blk_queue_max_hw_sectors()") is applied,
This issue happened on the swiotlb enabled environment.
This commit will checks the maximum size of a mapping for the device,
and adjusts the max_hw_sectors.On vhci-hcd driver,
the dma mask setting follows the platform device default setting(32-bit).
So dma_addressing_limited() will be true,then the maximum mapping size
use the swiotlb max mapping size(512).The max_hw_sectors reset to 512.

To fix this issue,have to get the dma mask bit that
the real USB controllers support,and set this value on vhci-hcd driver,
usbip device will get the correct max_hw_sectors.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 drivers/usb/usbip/stub_dev.c               | 42 ++++++++++++++++++++++
 drivers/usb/usbip/vhci_sysfs.c             | 11 +++---
 tools/usb/usbip/libsrc/usbip_common.h      |  1 +
 tools/usb/usbip/libsrc/usbip_host_common.c | 34 ++++++++++++++++++
 tools/usb/usbip/libsrc/vhci_driver.c       | 10 +++---
 tools/usb/usbip/libsrc/vhci_driver.h       |  4 +--
 tools/usb/usbip/src/usbip_attach.c         |  2 +-
 tools/usb/usbip/src/usbip_network.c        |  1 +
 8 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index ce625b1ce9a5..095de5a8a307 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -7,6 +7,7 @@
 #include <linux/file.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
+#include <linux/dma-mapping.h>
 
 #include "usbip_common.h"
 #include "stub.h"
@@ -34,6 +35,46 @@ static ssize_t usbip_status_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(usbip_status);
 
+/*
+ * The real USB controllers may support larger than 32-bit address memory pointers actually.
+ * But vhci-hcd driver use the default platform device dma mask set(32-bit),
+ * and usbip device's max_sectors will be limited by dma max mapping size.
+ * usbip_dma_bits shows the real dma mask bit of the real usb controller
+ * which usbip device is bound to.
+ */
+static unsigned int mask_convert_to_bits(u64 dma_mask)
+{
+	unsigned int bits = 0;
+
+	while (dma_mask & 0x1) {
+		dma_mask >>= 1;
+		bits++;
+	}
+	return bits;
+}
+
+static ssize_t usbip_dma_bits_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct stub_device *sdev = dev_get_drvdata(dev);
+	struct device *sys_dev = sdev->udev->bus->sysdev;
+	u64 dma_mask = 0;
+	unsigned int dma_bits = 0;
+
+	if (!sdev || !sys_dev) {
+		dev_err(dev, "sdev or sys_dev is null\n");
+		return -ENODEV;
+	}
+
+	spin_lock_irq(&sdev->ud.lock);
+	dma_mask = dma_get_mask(sys_dev);
+	dma_bits = mask_convert_to_bits(dma_mask);
+	spin_unlock_irq(&sdev->ud.lock);
+
+	return sysfs_emit(buf, "%d\n", dma_bits);
+}
+static DEVICE_ATTR_RO(usbip_dma_bits);
+
 /*
  * usbip_sockfd gets a socket descriptor of an established TCP connection that
  * is used to transfer usbip requests by kernel threads. -1 is a magic number
@@ -144,6 +185,7 @@ static DEVICE_ATTR_WO(usbip_sockfd);
 
 static struct attribute *usbip_attrs[] = {
 	&dev_attr_usbip_status.attr,
+	&dev_attr_usbip_dma_bits.attr,
 	&dev_attr_usbip_sockfd.attr,
 	&dev_attr_usbip_debug.attr,
 	NULL,
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index d5865460e82d..972beac653f6 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -12,6 +12,7 @@
 
 /* Hardening for Spectre-v1 */
 #include <linux/nospec.h>
+#include <linux/dma-mapping.h>
 
 #include "usbip_common.h"
 #include "vhci.h"
@@ -311,7 +312,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 {
 	struct socket *socket;
 	int sockfd = 0;
-	__u32 port = 0, pdev_nr = 0, rhport = 0, devid = 0, speed = 0;
+	__u32 port = 0, pdev_nr = 0, rhport = 0, devid = 0, speed = 0, dma_bits = 0;
 	struct usb_hcd *hcd;
 	struct vhci_hcd *vhci_hcd;
 	struct vhci_device *vdev;
@@ -327,15 +328,15 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	 * @devid: unique device identifier in a remote host
 	 * @speed: usb device speed in a remote host
 	 */
-	if (sscanf(buf, "%u %u %u %u", &port, &sockfd, &devid, &speed) != 4)
+	if (sscanf(buf, "%u %u %u %u %u", &port, &sockfd, &devid, &speed, &dma_bits) != 5)
 		return -EINVAL;
 	pdev_nr = port_to_pdev_nr(port);
 	rhport = port_to_rhport(port);
 
 	usbip_dbg_vhci_sysfs("port(%u) pdev(%d) rhport(%u)\n",
 			     port, pdev_nr, rhport);
-	usbip_dbg_vhci_sysfs("sockfd(%u) devid(%u) speed(%u)\n",
-			     sockfd, devid, speed);
+	usbip_dbg_vhci_sysfs("sockfd(%u) devid(%u) speed(%u) dma_bits(%u)\n",
+			     sockfd, devid, speed, dma_bits);
 
 	/* check received parameters */
 	if (!valid_args(&pdev_nr, &rhport, speed))
@@ -346,6 +347,8 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 		dev_err(dev, "port %d is not ready\n", port);
 		return -EAGAIN;
 	}
+	/* Set the real USB controller's dma mask to vhci-hcd driver. */
+	dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
 
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
 	vhci = vhci_hcd->vhci;
diff --git a/tools/usb/usbip/libsrc/usbip_common.h b/tools/usb/usbip/libsrc/usbip_common.h
index 73a367a7fa10..c87d74917c2a 100644
--- a/tools/usb/usbip/libsrc/usbip_common.h
+++ b/tools/usb/usbip/libsrc/usbip_common.h
@@ -115,6 +115,7 @@ struct usbip_usb_device {
 	uint32_t busnum;
 	uint32_t devnum;
 	uint32_t speed;
+	uint32_t dma_bits;
 
 	uint16_t idVendor;
 	uint16_t idProduct;
diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
index ca78aa368476..7f5cc44236c9 100644
--- a/tools/usb/usbip/libsrc/usbip_host_common.c
+++ b/tools/usb/usbip/libsrc/usbip_host_common.c
@@ -61,6 +61,38 @@ static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
 	return value;
 }
 
+static int32_t read_attr_usbip_dma_bits(struct usbip_usb_device *udev)
+{
+	char dma_bits_attr_path[SYSFS_PATH_MAX];
+	int size;
+	int fd;
+	int length;
+	char dma_bits[3] = { 0 };
+
+	size = snprintf(dma_bits_attr_path, sizeof(dma_bits_attr_path),
+			"%s/usbip_dma_bits", udev->path);
+	if (size < 0 || (unsigned int)size >= sizeof(dma_bits_attr_path)) {
+		err("usbip_dma_bits path length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(dma_bits_attr_path));
+		return -1;
+	}
+
+	fd = open(dma_bits_attr_path, O_RDONLY);
+	if (fd < 0) {
+		err("error opening attribute %s", dma_bits_attr_path);
+		return -1;
+	}
+	length = read(fd, dma_bits, 2);
+	if (length < 0) {
+		err("error reading attribute %s", dma_bits_attr_path);
+		close(fd);
+		return -1;
+	}
+	udev->dma_bits = atoi(dma_bits);
+	close(fd);
+	return 0;
+}
+
 static
 struct usbip_exported_device *usbip_exported_device_new(
 		struct usbip_host_driver *hdriver, const char *sdevpath)
@@ -82,6 +114,8 @@ struct usbip_exported_device *usbip_exported_device_new(
 	if (hdriver->ops.read_device(edev->sudev, &edev->udev) < 0)
 		goto err;
 
+	read_attr_usbip_dma_bits(&edev->udev);
+
 	edev->status = read_attr_usbip_status(&edev->udev);
 	if (edev->status < 0)
 		goto err;
diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index 8159fd98680b..e5fc4a048a5f 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -355,15 +355,15 @@ int usbip_vhci_get_free_port(uint32_t speed)
 }
 
 int usbip_vhci_attach_device2(uint8_t port, int sockfd, uint32_t devid,
-		uint32_t speed) {
+		uint32_t speed, uint32_t dma_bits) {
 	char buff[200]; /* what size should be ? */
 	char attach_attr_path[SYSFS_PATH_MAX];
 	char attr_attach[] = "attach";
 	const char *path;
 	int ret;
 
-	snprintf(buff, sizeof(buff), "%u %d %u %u",
-			port, sockfd, devid, speed);
+	snprintf(buff, sizeof(buff), "%u %d %u %u %u",
+			port, sockfd, devid, speed, dma_bits);
 	dbg("writing: %s", buff);
 
 	path = udev_device_get_syspath(vhci_driver->hc_device);
@@ -389,11 +389,11 @@ static unsigned long get_devid(uint8_t busnum, uint8_t devnum)
 
 /* will be removed */
 int usbip_vhci_attach_device(uint8_t port, int sockfd, uint8_t busnum,
-		uint8_t devnum, uint32_t speed)
+		uint8_t devnum, uint32_t speed, uint32_t dma_bits)
 {
 	int devid = get_devid(busnum, devnum);
 
-	return usbip_vhci_attach_device2(port, sockfd, devid, speed);
+	return usbip_vhci_attach_device2(port, sockfd, devid, speed, dma_bits);
 }
 
 int usbip_vhci_detach_device(uint8_t port)
diff --git a/tools/usb/usbip/libsrc/vhci_driver.h b/tools/usb/usbip/libsrc/vhci_driver.h
index 6c9aca216705..bf40aa23b6f3 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.h
+++ b/tools/usb/usbip/libsrc/vhci_driver.h
@@ -54,11 +54,11 @@ int  usbip_vhci_refresh_device_list(void);
 
 int usbip_vhci_get_free_port(uint32_t speed);
 int usbip_vhci_attach_device2(uint8_t port, int sockfd, uint32_t devid,
-		uint32_t speed);
+		uint32_t speed, uint32_t dma_bits);
 
 /* will be removed */
 int usbip_vhci_attach_device(uint8_t port, int sockfd, uint8_t busnum,
-		uint8_t devnum, uint32_t speed);
+		uint8_t devnum, uint32_t speed, uint32_t dma_bits);
 
 int usbip_vhci_detach_device(uint8_t port);
 
diff --git a/tools/usb/usbip/src/usbip_attach.c b/tools/usb/usbip/src/usbip_attach.c
index 531a415538f9..453987782eec 100644
--- a/tools/usb/usbip/src/usbip_attach.c
+++ b/tools/usb/usbip/src/usbip_attach.c
@@ -100,7 +100,7 @@ static int import_device(int sockfd, struct usbip_usb_device *udev)
 		dbg("got free port %d", port);
 
 		rc = usbip_vhci_attach_device(port, sockfd, udev->busnum,
-					      udev->devnum, udev->speed);
+					      udev->devnum, udev->speed, udev->dma_bits);
 		if (rc < 0 && errno != EBUSY) {
 			err("import device");
 			goto err_driver_close;
diff --git a/tools/usb/usbip/src/usbip_network.c b/tools/usb/usbip/src/usbip_network.c
index ed4dc8c14269..2c97db9ea567 100644
--- a/tools/usb/usbip/src/usbip_network.c
+++ b/tools/usb/usbip/src/usbip_network.c
@@ -79,6 +79,7 @@ void usbip_net_pack_usb_device(int pack, struct usbip_usb_device *udev)
 	udev->busnum = usbip_net_pack_uint32_t(pack, udev->busnum);
 	udev->devnum = usbip_net_pack_uint32_t(pack, udev->devnum);
 	udev->speed = usbip_net_pack_uint32_t(pack, udev->speed);
+	udev->dma_bits = usbip_net_pack_uint32_t(pack, udev->dma_bits);
 
 	udev->idVendor = usbip_net_pack_uint16_t(pack, udev->idVendor);
 	udev->idProduct = usbip_net_pack_uint16_t(pack, udev->idProduct);
-- 
2.34.1


