Return-Path: <linux-kernel+bounces-242062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A9928326
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC96B2848A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA01494A2;
	Fri,  5 Jul 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9ie3WvA"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C18148851
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165767; cv=none; b=ENTOkDeOLIwa8MgHNLlyUgRcZNyYbrs7+Kt/D3uqUEeDgjJYo01NZ2KzTzfW66JgBvoQ4Q2y6vG4DNl/R1l/o+pNEQVUfSpCJ4bDIOkQFhGFikA3uCllocORuGvE1Xc8bCHZreB+zUVhUdRMd+HbSzl/hIft8Bd68l3wNZOpmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165767; c=relaxed/simple;
	bh=4SVfiTT14IOGOJAh8Mvi9GxV+p3w36AIjeJIp5TDoyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3OXkVLUnWIYoTf8FvKnn9+Ero58pV159yA2LmZrMcVZ61KEx2L4JCeFP37twEWKAZeOLGvaetW82hd7J0NV1ZJJfYzoYj4hyjSr35CdwXrUhmAhD5YxQBcemGXeBILVvPPLSW+4P0Kl3mlKXi1Kl/bQu05BfHDnug4q0yK6ibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9ie3WvA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36799fb93baso917303f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165764; x=1720770564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aEiM8GfYg6AtJ01v2ahAsrUKMYrAlMvvkF2JxRpick=;
        b=U9ie3WvA8D9i+ZtX+SP/C1O75enysY2f8hnLS5hf5ecA4EuUVY3O1qNAPRYFVKYS3b
         HiPcbN5ty3vWhAaP2Dnvk5GU/kBbqdr0em1Xm17LZTKFMHQ2N/jUM5FBuWBUQcTWyDm5
         yH5+2/zWUiItSGDxlXfxYDtQGfISlzQYj6Bkq6qcttYBo/DotpTaixoqRmML/QMQl0U0
         2jn8YMMzLJyxdzkJTLyEx4sT4KDvf3basrD+llwDkqDx0rz5wpVEZKH+5kcbdFAqLLGq
         l+QLJks6oB7izEhAKXRPd8jIAoUz3+hJN6rtXBAWHkZW1zbhXJpFnmIcLAKhFBHs4+Lg
         r1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165764; x=1720770564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aEiM8GfYg6AtJ01v2ahAsrUKMYrAlMvvkF2JxRpick=;
        b=I98rCOZf3VHtX69SZtyz9pUy+XnEdXIQ3WvDMhf5M5xIfs7yJ2xg8oapTrXVEyWqHG
         fgwYvn9CVGB/rMctw7OSuP7dVkyiw2t1EmB5nZfPyuCHQdmNhtBXFGpWHyYIBBWbe5PZ
         zP/bTUfS8SnniObDv3uEwpbb2goAhCYpApYGbIKe9LeyyAHGxviCwLS67WpdU+xQaOCM
         FOQ7eEjSMOOhTAwOWhKZA3g2t8/k08u5G9s2hZlPYQnixHYny8xNp+YN7GlrWR4ltb/S
         uQywiT0neMruI+Lryc6ZQFGoPopBY2EK5L/jdgke6/zIPsuEuSLLUTWN/I8btQ6I1bct
         1N6A==
X-Gm-Message-State: AOJu0YxYTa2EgfoJjervM2BG4HtZZLNioiklxLxxMJZPR1323bE1b5zl
	tXQNCITNIGoH2Az9dJ0G6bvYO5yQ6PhpJ/aWdbT1YIDlXv/UqFCmArpWRtsKd0vXu6nsuBeqApB
	jivQ=
X-Google-Smtp-Source: AGHT+IGopdLfGMm9uiNVdeVOpm8IKahWTLm2cGh7cyoXTR2UBAcZSt4pwuFufMVM+W4nm2jr8hJCRQ==
X-Received: by 2002:a5d:4146:0:b0:367:958e:9821 with SMTP id ffacd0b85a97d-3679dd53cb3mr2598197f8f.29.1720165763842;
        Fri, 05 Jul 2024 00:49:23 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:22 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 15/15] nvmem: core: Implement force_ro sysfs attribute
Date: Fri,  5 Jul 2024 08:48:52 +0100
Message-Id: <20240705074852.423202-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

Implement "force_ro" sysfs attribute to allow users to set read-write
devices as read-only and back to read-write from userspace. The choice
of the name is based on MMC core 'force_ro' attribute.

This solves a situation where an AT24 I2C EEPROM with GPIO based nWP
signal may have to be occasionally updated. Such I2C EEPROM device is
usually set as read-only during most of the regular system operation,
but in case it has to be updated in a controlled manner, it could be
unlocked using this new "force_ro" sysfs attribute and then re-locked
again.

The "read-only" DT property and config->read_only configuration is
respected and is used to set default state of the device, read-only
or read-write, for devices which do implement .reg_write function.
For devices which do not implement .reg_write function, the device
is unconditionally read-only and the "force_ro" attribute is not
visible.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/ABI/stable/sysfs-bus-nvmem | 17 ++++++++++
 drivers/nvmem/core.c                     | 43 ++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem b/Documentation/ABI/stable/sysfs-bus-nvmem
index 3f0a95250aa8..aa89adf18bc5 100644
--- a/Documentation/ABI/stable/sysfs-bus-nvmem
+++ b/Documentation/ABI/stable/sysfs-bus-nvmem
@@ -1,3 +1,20 @@
+What:		/sys/bus/nvmem/devices/.../force_ro
+Date:		June 2024
+KernelVersion:	6.11
+Contact:	Marek Vasut <marex@denx.de>
+Description:
+		This read/write attribute allows users to set read-write
+		devices as read-only and back to read-write from userspace.
+		This can be used to unlock and relock write-protection of
+		devices which are generally locked, except during sporadic
+		programming operation.
+		Read returns '0' or '1' for read-write or read-only modes
+		respectively.
+		Write parses one of 'YyTt1NnFf0', or [oO][NnFf] for "on"
+		and "off", i.e. what kstrbool() supports.
+		Note: This file is only present if CONFIG_NVMEM_SYSFS
+		is enabled.
+
 What:		/sys/bus/nvmem/devices/.../nvmem
 Date:		July 2015
 KernelVersion:	4.2
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 89f632f91768..12df7d037d37 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -184,7 +184,30 @@ static ssize_t type_show(struct device *dev,
 
 static DEVICE_ATTR_RO(type);
 
+static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	return sysfs_emit(buf, "%d\n", nvmem->read_only);
+}
+
+static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+	int ret = kstrtobool(buf, &nvmem->read_only);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(force_ro);
+
 static struct attribute *nvmem_attrs[] = {
+	&dev_attr_force_ro.attr,
 	&dev_attr_type.attr,
 	NULL,
 };
@@ -285,6 +308,25 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 	return nvmem_bin_attr_get_umode(nvmem);
 }
 
+static umode_t nvmem_attr_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	/*
+	 * If the device has no .reg_write operation, do not allow
+	 * configuration as read-write.
+	 * If the device is set as read-only by configuration, it
+	 * can be forced into read-write mode using the 'force_ro'
+	 * attribute.
+	 */
+	if (attr == &dev_attr_force_ro.attr && !nvmem->reg_write)
+		return 0;	/* Attribute not visible */
+
+	return attr->mode;
+}
+
 static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
 					    const char *id, int index);
 
@@ -341,6 +383,7 @@ static const struct attribute_group nvmem_bin_group = {
 	.bin_attrs	= nvmem_bin_attributes,
 	.attrs		= nvmem_attrs,
 	.is_bin_visible = nvmem_bin_attr_is_visible,
+	.is_visible	= nvmem_attr_is_visible,
 };
 
 static const struct attribute_group *nvmem_dev_groups[] = {
-- 
2.25.1


