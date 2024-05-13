Return-Path: <linux-kernel+bounces-178003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61B8C4752
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075981F22BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093B54BD8;
	Mon, 13 May 2024 18:59:55 +0000 (UTC)
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B8446DE;
	Mon, 13 May 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626795; cv=none; b=AmOyvrPMdyS7HgXet3jq7ImtZddr0/lQwhTG7P40E9BuwKX3QOAnCpvWt1QNiX1sRTzvGQhocF91qieWcEKAPLNylxQPx/z1xg0lb5NJegby0hQuj+HjPyAENh0zsCbwqYmVDMRag+K1tUxFJCrXsrSvMF/+EYVVtFjAV7jI9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626795; c=relaxed/simple;
	bh=aePf0JOBXn78wI9ftaCWPhl/wej/6T9oe6C/HoTRS8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvCKEkfnYCYRj8tQRuXE3ncZd03xUENEL9tMM0kwnQ6yX8jTZaTHBcLfjss4LPMbTMu/KR1eW06bbdhjhKoabq4L465U+xTjGw4m3SsT7fV9D9lXoxH0ugvpHcmfZt5XyL6eq5UhxwQGfQkqwk5+Cvpmv5yorNj9E7UvOT/TCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de; spf=pass smtp.mailfrom=mariuszachmann.de; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariuszachmann.de
Received: from [2.211.228.80] (helo=marius.localnet)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mail@mariuszachmann.de>)
	id 1s6atl-0073cy-N1;
	Mon, 13 May 2024 20:59:45 +0200
From: Marius Zachmann <mail@mariuszachmann.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] hwmon: (corsair-cpro) Add firmware and bootloader information
Date: Mon, 13 May 2024 20:59:45 +0200
Message-ID: <4918546.31r3eYUQgx@marius>
In-Reply-To: <0e5d5843-e91a-4c0e-a7a7-fbda55301265@roeck-us.net>
References:
 <20240513162328.17636-3-mail@mariuszachmann.de>
 <0e5d5843-e91a-4c0e-a7a7-fbda55301265@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Con-Id: 241080
X-Con-U: 0-mail

On 13.05.24 at 20:51:25 MESZ, Guenter Roeck wrote
> On 5/13/24 09:23, Marius Zachmann wrote:
> > Add support for reporting firmware and bootloader version using debugfs.
> > Update documentation accordingly.
> > 
> > Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> > ---
> > Changes in v3:
> > - use different debugfs directory name for each device
> > 
> > Changes in v2:
> > - better patch description
> > - Documentation uses "Firmware version" and "Bootloader version"
> > - removed conditional CONFIG_DEBUG_FS
> > - get_fw_version gets called from ccp_debugfs_init
> > - get_fw_version does print a hid_notice when an error occurs
> >    instead of failing.
> > ---
> >   Documentation/hwmon/corsair-cpro.rst |  8 ++++
> >   drivers/hwmon/corsair-cpro.c         | 71 ++++++++++++++++++++++++++++
> >   2 files changed, 79 insertions(+)
> > 
> > diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> > index 751f95476b57..15077203a2f8 100644
> > --- a/Documentation/hwmon/corsair-cpro.rst
> > +++ b/Documentation/hwmon/corsair-cpro.rst
> > @@ -39,3 +39,11 @@ fan[1-6]_target		Sets fan speed target rpm.
> >   pwm[1-6]		Sets the fan speed. Values from 0-255. Can only be read if pwm
> >   			was set directly.
> >   ======================= =====================================================================
> > +
> > +Debugfs entries
> > +---------------
> > +
> > +======================= ===================
> > +firmware_version	Firmware version
> > +bootloader_version	Bootloader version
> > +======================= ===================
> > diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> > index 3e63666a61bd..f7d321d8676e 100644
> > --- a/drivers/hwmon/corsair-cpro.c
> > +++ b/drivers/hwmon/corsair-cpro.c
> > @@ -10,11 +10,13 @@
> >   
> >   #include <linux/bitops.h>
> >   #include <linux/completion.h>
> > +#include <linux/debugfs.h>
> >   #include <linux/hid.h>
> >   #include <linux/hwmon.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/mutex.h>
> > +#include <linux/seq_file.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/types.h>
> > @@ -28,6 +30,8 @@
> >   #define LABEL_LENGTH		11
> >   #define REQ_TIMEOUT		300
> >   
> > +#define CTL_GET_FW_VER		0x02	/* returns the firmware version in bytes 1-3 */
> > +#define CTL_GET_BL_VER		0x06	/* returns the bootloader version in bytes 1-2 */
> >   #define CTL_GET_TMP_CNCT	0x10	/*
> >   					 * returns in bytes 1-4 for each temp sensor:
> >   					 * 0 not connected
> > @@ -78,6 +82,7 @@
> >   struct ccp_device {
> >   	struct hid_device *hdev;
> >   	struct device *hwmon_dev;
> > +	struct dentry *debugfs;
> >   	/* For reinitializing the completion below */
> >   	spinlock_t wait_input_report_lock;
> >   	struct completion wait_input_report;
> > @@ -88,6 +93,8 @@ struct ccp_device {
> >   	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
> >   	DECLARE_BITMAP(fan_cnct, NUM_FANS);
> >   	char fan_label[6][LABEL_LENGTH];
> > +	u8 firmware_ver[3];
> > +	u8 bootloader_ver[2];
> >   };
> >   
> >   /* converts response error in buffer to errno */
> > @@ -496,6 +503,66 @@ static int get_temp_cnct(struct ccp_device *ccp)
> >   	return 0;
> >   }
> >   
> > +/* read firmware and bootloader version */
> > +static void get_fw_version(struct ccp_device *ccp)
> > +{
> > +	int ret;
> > +
> > +	ret = send_usb_cmd(ccp, CTL_GET_FW_VER, 0, 0, 0);
> > +	if (ret) {
> > +		hid_notice(ccp->hdev, "Failed to read firmware version.\n");
> 
> If this happens, the debugfs file should not be created, or at the very least
> display something like "unavailable".
> 
> > +	} else {
> > +		ccp->firmware_ver[0] = ccp->buffer[1];
> > +		ccp->firmware_ver[1] = ccp->buffer[2];
> > +		ccp->firmware_ver[2] = ccp->buffer[3];
> 
> That makes me wonder: What is in buffer[0] ?

buffer[0] is an errorcode returned by the device. It is read by ccp_get_errno,
which is called by send_usb_cmd.

> 
> > +	}
> > +
> > +	ret = send_usb_cmd(ccp, CTL_GET_BL_VER, 0, 0, 0);
> > +	if (ret) {
> > +		hid_notice(ccp->hdev, "Failed to read bootloader version.\n");
> 
> Same here.
> 
> > +	} else {
> > +		ccp->bootloader_ver[0] = ccp->buffer[1];
> > +		ccp->bootloader_ver[1] = ccp->buffer[2];
> > +	}
> > +}
> > +
> > +static int firmware_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct ccp_device *ccp = seqf->private;
> > +
> > +	seq_printf(seqf, "%d.%d.%d\n",
> > +		   ccp->firmware_ver[0],
> > +		   ccp->firmware_ver[1],
> > +		   ccp->firmware_ver[2]);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(firmware);
> > +
> > +static int bootloader_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct ccp_device *ccp = seqf->private;
> > +
> > +	seq_printf(seqf, "%d.%d\n",
> > +		   ccp->bootloader_ver[0],
> > +		   ccp->bootloader_ver[1]);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(bootloader);
> > +
> > +static void ccp_debugfs_init(struct ccp_device *ccp)
> > +{
> > +	char name[32];
> > +
> > +	get_fw_version(ccp);
> > +
> > +	scnprintf(name, sizeof(name), "corsaircpro-%s", dev_name(&ccp->hdev->dev));
> > +	ccp->debugfs = debugfs_create_dir(name, NULL);
> > +	debugfs_create_file("firmware_version", 0444, ccp->debugfs, ccp, &firmware_fops);
> > +	debugfs_create_file("bootloader_version", 0444, ccp->debugfs, ccp, &bootloader_fops);
> > +}
> > +
> >   static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >   {
> >   	struct ccp_device *ccp;
> > @@ -542,6 +609,9 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >   	ret = get_fan_cnct(ccp);
> >   	if (ret)
> >   		goto out_hw_close;
> > +
> > +	ccp_debugfs_init(ccp);
> > +
> >   	ccp->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsaircpro",
> >   							 ccp, &ccp_chip_info, NULL);
> >   	if (IS_ERR(ccp->hwmon_dev)) {
> > @@ -562,6 +632,7 @@ static void ccp_remove(struct hid_device *hdev)
> >   {
> >   	struct ccp_device *ccp = hid_get_drvdata(hdev);
> >   
> > +	debugfs_remove_recursive(ccp->debugfs);
> >   	hwmon_device_unregister(ccp->hwmon_dev);
> >   	hid_hw_close(hdev);
> >   	hid_hw_stop(hdev);
> 
> 





