Return-Path: <linux-kernel+bounces-390942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C179B8051
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CE6284701
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8511BE87E;
	Thu, 31 Oct 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="lTJyE8la"
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E4CA6B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392706; cv=none; b=a8uQM0x5HZwhVpIj+H1qSNJxR7kAvAKYMNQecse0SSYRl1vRd58SYLYkr8ASnkYgUXbkkqgJFCIhNE9s08dDOPC7uFoXGzwKvnBQ0+Y07+OvotqxDgh23RmUw0/anaUvkAT3TUuIaSbKMlW0eKE97NHX3BHE6JsuFAUXd+zq7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392706; c=relaxed/simple;
	bh=9t+1HWKCNf6VucSYaxtleHwN/dP++t7UZJkLK4IDOcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cajlc4VK1kgf0ypF0ubuCuz5BSKR/1tgBWDVnNv/jvsFYE0CiIigZjFhHiZk70gRfP7JhC0KzcS+7qf9cM2W3Jb4aF5OoeVF3p/vGXsXxAUjj6bk/twijW1ciFTGJ07DezNbf73jOvbW/ooYPBAXbrVYnY0n49kymn2UFocGRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=lTJyE8la; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 6Y8atb5dFqJRS6Y8dtNuHG; Thu, 31 Oct 2024 17:35:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1730392511; bh=9t+1HWKCNf6VucSYaxtleHwN/dP++t7UZJkLK4IDOcU=;
	h=From:To:Subject:Date:MIME-Version;
	b=lTJyE8laLgOkTAVKX4jEViJHvjp2hNQEw2jSn8qBi0kQcwZsTgukcuLbHWswfOh9M
	 7gIgNYvq9lOykzpFu/x+SqG/xlufjAs8GJYqUEIigtlW7/7ALtkLppY/FJ5wWnMm5I
	 eZ6M8LCD0BkB4UP/6WRTfMQzleSVzWens2ejxUrfc7MHg/Nfwt7dmGZEoRXObbo3rF
	 IkJLO1nXbpiEiB70QobdoAWj04VS3t3mGfJ/HhBKXD5c8Tpbc/XyKFa4Jp3Kon9bqk
	 xWqDbu+Qd0FEaT+h60IhP10nJ7bW7+WuwhH4t43VVKWG3WjBLUeikiMJ9PpjaBKVa/
	 /Rs3qAareSzLQ==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V2 1/4] drivers pps: add PPS generators support
Date: Thu, 31 Oct 2024 17:35:05 +0100
Message-Id: <20241031163508.259522-2-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031163508.259522-1-giometti@enneenne.com>
References: <20241031163508.259522-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfN/FxSRnUHB8WmG0CP+7byCawZGM+hNWPsQQe7XCZ8BG6h94SNtY3v8NkMD6m77ludedH4mu/SejsdPh1Qkgnq1AJw6JrKoxc0lrTKjYyVfqMlpUFe0J
 3oq2GuqyBUkU5oLMhfTNAVCtc+Al5t3aUP5HUvjw9PAM2CSeisVSFzou9hLuABhKbZ3IVj+MBZ1k+25gQ5Oh6FqegXlFpBt/io0nx7oqvSlInTAuwFFogD3c
 vOI2LlKHEGNKYY2PG7IPt+wlaLpb4GoJp83zTTESoeIKjJ6FKCTPmUAVYFT8jMM1QK11AsOIBoLRrQKJgtqeZpB1heIOQVCdAP4fNhX48724+P3M14egsyH7
 O8iaJawf1h1CdTekqeFFEuaFzByUk5mkAH+C0U8KORUYtC/EnRkQnWATOZ1tcl40kAhOFlrj51GcjMqMNLiwWy/fkb/1qlTBVsTdesdZwATk3gvCFzO0wGme
 aXTRc3gosfDLpFZJHBM1ab9r6oC3sGqdWXnWHY+8QMOVS2fu+8QyBWbG3GYUfLuy06I7vBAE9orsTeyWb3sLvDBilrDlRN6B6gSgzCxms4J5nn99BwZSDH1a
 tVDqQp3i+W8DxdQv528GVGo8vDv49fo4UCJPrewkCygXz4Cm/zRPnKPnOOzLV5yfzihISGsyYe6XbXxMwomXLfns1uff/oqeGcslinXbBnV4/Ny1JXUMSssx
 Rljyh3qJkap2w+RiktjKn8PKh/nbf/tO

Sometimes one needs to be able not only to catch PPS signals but to
produce them also. For example, running a distributed simulation,
which requires computers' clock to be synchronized very tightly.

This patch adds PPS generators class in order to have a well-defined
interface for these devices.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/pps/Makefile                          |   3 +-
 drivers/pps/generators/Kconfig                |  13 +-
 drivers/pps/generators/Makefile               |   3 +
 drivers/pps/generators/pps_gen.c              | 344 ++++++++++++++++++
 drivers/pps/generators/sysfs.c                |  75 ++++
 include/linux/pps_gen_kernel.h                |  78 ++++
 include/uapi/linux/pps_gen.h                  |  37 ++
 9 files changed, 553 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pps/generators/pps_gen.c
 create mode 100644 drivers/pps/generators/sysfs.c
 create mode 100644 include/linux/pps_gen_kernel.h
 create mode 100644 include/uapi/linux/pps_gen.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e4be1378ba26..e4f7f798f091 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -283,6 +283,7 @@ Code  Seq#    Include File                                           Comments
 'p'   80-9F  linux/ppdev.h                                           user-space parport
                                                                      <mailto:tim@cyberelk.net>
 'p'   A1-A5  linux/pps.h                                             LinuxPPS
+'p'   B1-B3  linux/pps-gen.h                                         LinuxPPS
                                                                      <mailto:giometti@linux.it>
 'q'   00-1F  linux/serio.h
 'q'   80-FF  linux/telephony.h                                       Internet PhoneJACK, Internet LineJACK
diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..63871eb816eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18536,6 +18536,7 @@ F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
 F:	drivers/pps/
 F:	include/linux/pps*.h
+F:	include/uapi/linux/pps-gen.h
 F:	include/uapi/linux/pps.h
 
 PPTP DRIVER
diff --git a/drivers/pps/Makefile b/drivers/pps/Makefile
index ceaf65cc1f1d..0aea394d4e4d 100644
--- a/drivers/pps/Makefile
+++ b/drivers/pps/Makefile
@@ -6,6 +6,7 @@
 pps_core-y			:= pps.o kapi.o sysfs.o
 pps_core-$(CONFIG_NTP_PPS)	+= kc.o
 obj-$(CONFIG_PPS)		:= pps_core.o
-obj-y				+= clients/ generators/
+obj-y				+= clients/
+obj-$(CONFIG_PPS_GENERATOR)	+= generators/
 
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
index d615e640fcad..5edbfdb8bd92 100644
--- a/drivers/pps/generators/Kconfig
+++ b/drivers/pps/generators/Kconfig
@@ -3,7 +3,16 @@
 # PPS generators configuration
 #
 
-comment "PPS generators support"
+menuconfig PPS_GENERATOR
+	tristate "PPS generators support"
+	help
+	  PPS generators are special hardware which are able to produce PPS
+	  (Pulse Per Second) signals.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pps_gen_core.ko.
+
+if PPS_GENERATOR
 
 config PPS_GENERATOR_PARPORT
 	tristate "Parallel port PPS signal generator"
@@ -12,3 +21,5 @@ config PPS_GENERATOR_PARPORT
 	  If you say yes here you get support for a PPS signal generator which
 	  utilizes STROBE pin of a parallel port to send PPS signals. It uses
 	  parport abstraction layer and hrtimers to precisely control the signal.
+
+endif # PPS_GENERATOR
diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index 2589fd0f2481..034a78edfa26 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -3,6 +3,9 @@
 # Makefile for PPS generators.
 #
 
+pps_gen_core-y			:= pps_gen.o sysfs.o
+obj-$(CONFIG_PPS_GENERATOR)	:= pps_gen_core.o
+
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
 
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
new file mode 100644
index 000000000000..ca592f1736f4
--- /dev/null
+++ b/drivers/pps/generators/pps_gen.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PPS generators core file
+ *
+ * Copyright (C) 2024 Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/uaccess.h>
+#include <linux/idr.h>
+#include <linux/cdev.h>
+#include <linux/poll.h>
+#include <linux/fs.h>
+#include <linux/pps_gen_kernel.h>
+#include <linux/slab.h>
+
+/*
+ * Local variables
+ */
+
+static dev_t pps_gen_devt;
+static struct class *pps_gen_class;
+
+static DEFINE_IDA(pps_gen_ida);
+
+/*
+ * Char device methods
+ */
+
+static __poll_t pps_gen_cdev_poll(struct file *file, poll_table *wait)
+{
+	struct pps_gen_device *pps_gen = file->private_data;
+
+	poll_wait(file, &pps_gen->queue, wait);
+	return EPOLLIN | EPOLLRDNORM;
+}
+
+static int pps_gen_cdev_fasync(int fd, struct file *file, int on)
+{
+	struct pps_gen_device *pps_gen = file->private_data;
+
+	return fasync_helper(fd, file, on, &pps_gen->async_queue);
+}
+
+static long pps_gen_cdev_ioctl(struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	struct pps_gen_device *pps_gen = file->private_data;
+	void __user *uarg = (void __user *) arg;
+	unsigned int __user *uiuarg = (unsigned int __user *) arg;
+	unsigned int status;
+	int ret;
+
+	switch (cmd) {
+	case PPS_GEN_SETENABLE:
+		dev_dbg(pps_gen->dev, "PPS_GEN_SETENABLE\n");
+
+		ret = get_user(status, uiuarg);
+		if (ret)
+			return -EFAULT;
+
+		ret = pps_gen->info.enable(pps_gen, status);
+		if (ret)
+			return ret;
+		pps_gen->enabled = status;
+
+		break;
+
+	case PPS_GEN_USESYSTEMCLOCK:
+		dev_dbg(pps_gen->dev, "PPS_GEN_USESYSTEMCLOCK\n");
+
+		ret = put_user(pps_gen->info.use_system_clock, uiuarg);
+		if (ret)
+			return -EFAULT;
+
+		break;
+
+	case PPS_GEN_FETCHEVENT: {
+		struct pps_gen_event info;
+		unsigned int ev = pps_gen->last_ev;
+
+		dev_dbg(pps_gen->dev, "PPS_GEN_FETCHEVENT\n");
+
+		ret = wait_event_interruptible(pps_gen->queue,
+				ev != pps_gen->last_ev);
+		if (ret == -ERESTARTSYS) {
+			dev_dbg(pps_gen->dev, "pending signal caught\n");
+			return -EINTR;
+		}
+
+		spin_lock_irq(&pps_gen->lock);
+		info.sequence = pps_gen->sequence;
+		info.event = pps_gen->event;
+		spin_unlock_irq(&pps_gen->lock);
+
+		ret = copy_to_user(uarg, &info, sizeof(struct pps_gen_event));
+		if (ret)
+			return -EFAULT;
+
+		break;
+	}
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static int pps_gen_cdev_open(struct inode *inode, struct file *file)
+{
+	struct pps_gen_device *pps_gen = container_of(inode->i_cdev,
+				struct pps_gen_device, cdev);
+
+	get_device(pps_gen->dev);
+	file->private_data = pps_gen;
+	return 0;
+}
+
+static int pps_gen_cdev_release(struct inode *inode, struct file *file)
+{
+	struct pps_gen_device *pps_gen = file->private_data;
+
+	put_device(pps_gen->dev);
+	return 0;
+}
+
+/*
+ * Char device stuff
+ */
+
+static const struct file_operations pps_gen_cdev_fops = {
+	.owner		= THIS_MODULE,
+	.poll	   = pps_gen_cdev_poll,
+	.fasync	 = pps_gen_cdev_fasync,
+	.unlocked_ioctl	= pps_gen_cdev_ioctl,
+	.open		= pps_gen_cdev_open,
+	.release	= pps_gen_cdev_release,
+};
+
+static void pps_gen_device_destruct(struct device *dev)
+{
+	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+
+	cdev_del(&pps_gen->cdev);
+
+	pr_debug("deallocating pps-gen%d\n", pps_gen->id);
+	ida_free(&pps_gen_ida, pps_gen->id);
+
+	kfree(dev);
+	kfree(pps_gen);
+}
+
+static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
+{
+	int err;
+	dev_t devt;
+
+	err = ida_alloc_max(&pps_gen_ida, PPS_GEN_MAX_SOURCES - 1, GFP_KERNEL);
+	if (err < 0) {
+		if (err == -ENOSPC) {
+			pr_err("too many PPS sources in the system\n");
+			err = -EBUSY;
+		}
+		return err;
+	}
+	pps_gen->id = err;
+
+	devt = MKDEV(MAJOR(pps_gen_devt), pps_gen->id);
+
+	cdev_init(&pps_gen->cdev, &pps_gen_cdev_fops);
+	pps_gen->cdev.owner = pps_gen->info.owner;
+
+	err = cdev_add(&pps_gen->cdev, devt, 1);
+	if (err) {
+		pr_err("failed to add char device %d:%d\n",
+				MAJOR(pps_gen_devt), pps_gen->id);
+		goto free_ida;
+	}
+	pps_gen->dev = device_create(pps_gen_class, pps_gen->info.parent, devt,
+					pps_gen, "pps-gen%d", pps_gen->id);
+	if (IS_ERR(pps_gen->dev)) {
+		err = PTR_ERR(pps_gen->dev);
+		goto del_cdev;
+	}
+	pps_gen->dev->release = pps_gen_device_destruct;
+	dev_set_drvdata(pps_gen->dev, pps_gen);
+
+	pr_debug("generator got cdev (%d:%d)\n",
+			MAJOR(pps_gen_devt), pps_gen->id);
+
+	return 0;
+
+del_cdev:
+	cdev_del(&pps_gen->cdev);
+free_ida:
+	ida_free(&pps_gen_ida, pps_gen->id);
+	return err;
+}
+
+static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
+{
+	pr_debug("unregistering pps-gen%d\n", pps_gen->id);
+	device_destroy(pps_gen_class, pps_gen->dev->devt);
+}
+
+/*
+ * Exported functions
+ */
+
+/**
+ * pps_gen_register_source() - add a PPS generator in the system
+ * @info: the PPS generator info struct
+ *
+ * This function is used to register a new PPS generator in the system.
+ * When it returns successfully the new generator is up and running, and
+ * it can be managed by the userspace.
+ *
+ * Return: the PPS generator device in case of success, and ERR_PTR(errno)
+ *	 otherwise.
+ */
+struct pps_gen_device *pps_gen_register_source(struct pps_gen_source_info *info)
+{
+	struct pps_gen_device *pps_gen;
+	int err;
+
+	pps_gen = kzalloc(sizeof(struct pps_gen_device), GFP_KERNEL);
+	if (pps_gen == NULL) {
+		err = -ENOMEM;
+		goto pps_gen_register_source_exit;
+	}
+	pps_gen->info = *info;
+	pps_gen->enabled = false;
+
+	init_waitqueue_head(&pps_gen->queue);
+	spin_lock_init(&pps_gen->lock);
+
+	/* Create the char device */
+	err = pps_gen_register_cdev(pps_gen);
+	if (err < 0) {
+		pr_err(" unable to create char device\n");
+		goto kfree_pps_gen;
+	}
+
+	return pps_gen;
+
+kfree_pps_gen:
+	kfree(pps_gen);
+
+pps_gen_register_source_exit:
+	pr_err("unable to register generator\n");
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL(pps_gen_register_source);
+
+/**
+ * pps_gen_unregister_source() - remove a PPS generator from the system
+ * @pps_gen: the PPS generator device to be removed
+ *
+ * This function is used to deregister a PPS generator from the system. When
+ * called, it disables the generator so no pulses are generated anymore.
+ */
+void pps_gen_unregister_source(struct pps_gen_device *pps_gen)
+{
+	pps_gen_unregister_cdev(pps_gen);
+}
+EXPORT_SYMBOL(pps_gen_unregister_source);
+
+/* pps_gen_event - register a PPS generator event into the system
+ * @pps: the PPS generator device
+ * @event: the event type
+ * @data: userdef pointer
+ *
+ * This function is used by each PPS generator in order to register a new
+ * PPS event into the system (it's usually called inside an IRQ handler).
+ */
+void pps_gen_event(struct pps_gen_device *pps_gen,
+			unsigned int event, void *data)
+{
+	unsigned long flags;
+
+	dev_dbg(pps_gen->dev, "PPS generator event %u\n", event);
+
+	spin_lock_irqsave(&pps_gen->lock, flags);
+
+	pps_gen->event = event;
+	pps_gen->sequence++;
+
+	pps_gen->last_ev++;
+	wake_up_interruptible_all(&pps_gen->queue);
+	kill_fasync(&pps_gen->async_queue, SIGIO, POLL_IN);
+
+	spin_unlock_irqrestore(&pps_gen->lock, flags);
+}
+EXPORT_SYMBOL(pps_gen_event);
+
+/*
+ * Module stuff
+ */
+
+static void __exit pps_gen_exit(void)
+{
+	class_destroy(pps_gen_class);
+	unregister_chrdev_region(pps_gen_devt, PPS_GEN_MAX_SOURCES);
+}
+
+static int __init pps_gen_init(void)
+{
+	int err;
+
+	pps_gen_class = class_create("pps-gen");
+	if (IS_ERR(pps_gen_class)) {
+		pr_err("failed to allocate class\n");
+		return PTR_ERR(pps_gen_class);
+	}
+	pps_gen_class->dev_groups = pps_gen_groups;
+
+	err = alloc_chrdev_region(&pps_gen_devt, 0,
+					PPS_GEN_MAX_SOURCES, "pps-gen");
+	if (err < 0) {
+		pr_err("failed to allocate char device region\n");
+		goto remove_class;
+	}
+
+	return 0;
+
+remove_class:
+	class_destroy(pps_gen_class);
+	return err;
+}
+
+subsys_initcall(pps_gen_init);
+module_exit(pps_gen_exit);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
+MODULE_DESCRIPTION("LinuxPPS generators support");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pps/generators/sysfs.c b/drivers/pps/generators/sysfs.c
new file mode 100644
index 000000000000..faf8b1c6d202
--- /dev/null
+++ b/drivers/pps/generators/sysfs.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PPS generators sysfs support
+ *
+ * Copyright (C) 2024 Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/pps_gen_kernel.h>
+
+/*
+ * Attribute functions
+ */
+
+static ssize_t system_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", pps_gen->info.use_system_clock);
+}
+static DEVICE_ATTR_RO(system);
+
+static ssize_t time_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+	struct timespec64 time;
+	int ret;
+
+	ret = pps_gen->info.get_time(pps_gen, &time);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu %09lu\n", time.tv_sec, time.tv_nsec);
+}
+static DEVICE_ATTR_RO(time);
+
+static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+	bool status;
+	int ret;
+
+	ret = kstrtobool(buf, &status);
+	if (ret)
+		return ret;
+
+	ret = pps_gen->info.enable(pps_gen, status);
+	if (ret)
+		return ret;
+	pps_gen->enabled = status;
+
+	return count;
+}
+static DEVICE_ATTR_WO(enable);
+
+static struct attribute *pps_gen_attrs[] = {
+	&dev_attr_enable.attr,
+	&dev_attr_time.attr,
+	&dev_attr_system.attr,
+	NULL,
+};
+
+static const struct attribute_group pps_gen_group = {
+	.attrs = pps_gen_attrs,
+};
+
+const struct attribute_group *pps_gen_groups[] = {
+	&pps_gen_group,
+	NULL,
+};
diff --git a/include/linux/pps_gen_kernel.h b/include/linux/pps_gen_kernel.h
new file mode 100644
index 000000000000..022ea0ac4440
--- /dev/null
+++ b/include/linux/pps_gen_kernel.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * PPS generator API kernel header
+ *
+ * Copyright (C) 2024 Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#ifndef LINUX_PPS_GEN_KERNEL_H
+#define LINUX_PPS_GEN_KERNEL_H
+
+#include <linux/pps_gen.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+
+/*
+ * Global defines
+ */
+
+#define PPS_GEN_MAX_SOURCES	16		/* should be enough... */
+
+struct pps_gen_device;
+
+/**
+ * struct pps_gen_source_info - the specific PPS generator info
+ * @use_system_clock: true, if the system clock is used to generate pulses
+ * @get_time: query the time stored into the generator clock
+ * @enable: enable/disable the PPS pulses generation
+ *
+ * This is the main generator struct where all needed information must be
+ * placed before calling the pps_gen_register_source().
+ */
+struct pps_gen_source_info {
+	bool use_system_clock;
+
+	int (*get_time)(struct pps_gen_device *pps_gen,
+					struct timespec64 *time);
+	int (*enable)(struct pps_gen_device *pps_gen, bool enable);
+
+/* private: internal use only */
+	struct module *owner;
+	struct device *parent;			/* for device_create */
+};
+
+/* The main struct */
+struct pps_gen_device {
+	struct pps_gen_source_info info;	/* PSS generator info */
+	bool enabled;				/* PSS generator status */
+
+	unsigned int event;
+	unsigned int sequence;
+
+	unsigned int last_ev;			/* last PPS event id */
+	wait_queue_head_t queue;		/* PPS event queue */
+
+	unsigned int id;			/* PPS generator unique ID */
+	struct cdev cdev;
+	struct device *dev;
+	struct fasync_struct *async_queue;	/* fasync method */
+	spinlock_t lock;
+};
+
+/*
+ * Global variables
+ */
+
+extern const struct attribute_group *pps_gen_groups[];
+
+/*
+ * Exported functions
+ */
+
+extern struct pps_gen_device *pps_gen_register_source(
+				struct pps_gen_source_info *info);
+extern void pps_gen_unregister_source(struct pps_gen_device *pps_gen);
+extern void pps_gen_event(struct pps_gen_device *pps_gen,
+				unsigned int event, void *data);
+
+#endif /* LINUX_PPS_GEN_KERNEL_H */
diff --git a/include/uapi/linux/pps_gen.h b/include/uapi/linux/pps_gen.h
new file mode 100644
index 000000000000..60a5d0fcfa68
--- /dev/null
+++ b/include/uapi/linux/pps_gen.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * PPS generator API header
+ *
+ * Copyright (C) 2024 Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#ifndef _PPS_GEN_H_
+#define _PPS_GEN_H_
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/**
+ * struct pps_gen_event - the PPS generator events
+ * @event: the event type
+ * @sequence: the event sequence number
+ *
+ * Userspace can get the last PPS generator event by using the
+ * ioctl(pps_gen, PPS_GEN_FETCHEVENT, ...) syscall.
+ * The sequence field can be used to save the last event ID, while in the
+ * event field is stored the last event type. Currently known event is:
+ *
+ *     PPS_GEN_EVENT_MISSEDPULSE	: last pulse was not generated
+ */
+struct pps_gen_event {
+	unsigned int event;
+	unsigned int sequence;
+};
+
+#define PPS_GEN_EVENT_MISSEDPULSE	1
+
+#define PPS_GEN_SETENABLE		_IOW('p', 0xb1, unsigned int *)
+#define PPS_GEN_USESYSTEMCLOCK		_IOR('p', 0xb2, unsigned int *)
+#define PPS_GEN_FETCHEVENT		_IOR('p', 0xb3, struct pps_gen_event *)
+
+#endif /* _PPS_GEN_H_ */
-- 
2.34.1


