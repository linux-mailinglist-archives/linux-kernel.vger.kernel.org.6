Return-Path: <linux-kernel+bounces-299481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D300795D55C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E58AB21B73
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753961917F2;
	Fri, 23 Aug 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFDcULMB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E8190482
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438350; cv=none; b=d/9eKmoG9WH2yDifllWKXPl0lexLxAAgSEt+rUf4A+huhTF1CodbHpPTHiGoNJzkDK/ZaIDZN7MSsSuz9Nd+5Z2SRbmOTXxCz9oce18p+kJJZbH+UIwE6/8eK17HtNpqm7lfu01gKYHWpXIR2hJvM0SMwKu5koq9cIj12pVn6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438350; c=relaxed/simple;
	bh=sVzJV9USq9eKNEzwIFZInybbtCZlW+uBUC8SgalnmSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PTByrzcClKoFOlolqJ8aiyQUznSvNSgVnrtfZ6zDenxKU7bxfJVpLotCpfgANW5ZeNGxDLLXZ32qClNYk/fJew5Lgkv9vkMTQeAeuuL/m6kJR5zNqu+5xvgNS9+EmXLCrFGr890oBwvO1yCtfrUutW2s1aEqTJY6VrqUSOIwznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UFDcULMB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428e12f6e56so7205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724438347; x=1725043147; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeAj6QQyTkhL3Etqku7A99WvtAjPRPUGrAhllHSbre4=;
        b=UFDcULMBdWmkgpzIaWUX9oHCgArlxy+Ie2rOcYlRglyAFIYVTY8FlFF2MMaobcynh7
         /WQzzkeWH740Bq8KPQwI49JAoLUmmhPllqpRj/DKD6x/MQX5fjbokreA4KbaablTcyfy
         TYfUnmyzWYNTbeg2vAIqRKFAXrvuu733+HrYoEO4ImOG8BJ0pHxnTL1WqdNcZpS7cSiU
         DviD5ffohfW1vuRde2N+CT0+5vB+GvP6p8/iHPgnCpnot1sjolredFBcjgD2yYcFOykw
         hOj96VxEqzPh/3DT7lglfHxG4xEYjMPbVBt6sBx/fmJUtqZwBqMcVvRkaKaePbSBJbR9
         ornA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724438347; x=1725043147;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeAj6QQyTkhL3Etqku7A99WvtAjPRPUGrAhllHSbre4=;
        b=Xflzg+f16olG3j3tqevcM4N+3DPQLs8/HEHFYFLVVc+Ni1p67qlxKUoBiAnXZ2ZR1C
         F3/b3Ni9y6mIwTBFo91pakjUvY+vLep61Sac+vVApiT3qX7UafyA0tOwVBPzksC+y8bl
         X/57En8CRU46YuMTbDlasoafwGJZ7BTutFcA4u/wczytFsXB3qHjw1jTNOR6slcaTbNC
         7/tOkYASptPBSxFBYfY6eorIxLQkGyGpRwBoVyq88Zf0Q9h8DCdnaXyyKGsP7/sfTZvY
         7ZwriZ93/FjZac3AhtvnxgEDunCe+cSOArNlFnIk2TDQcHSEdZ9xD680pN90tCzExb6I
         pRYg==
X-Gm-Message-State: AOJu0YyB2gj5WFM37t3d/dAGHdrsIhQ08i6yFcL071JbVSbwpXICeVmH
	n7wtoUh+X2/QqbZtGTFlrH5AlHPlQFz7EcMkUnT7xutT+5ebdl9vyl0C8nT2fw==
X-Google-Smtp-Source: AGHT+IFZ722Lx1blVGG2/ICsCK8F+H69EIM8QFz+t/DEVAFFrk0vyOqtGOJZELjrZhSmw8atbdME0Q==
X-Received: by 2002:a05:600c:4e41:b0:424:898b:522b with SMTP id 5b1f17b1804b1-42b8bcbadb1mr89345e9.1.1724438346614;
        Fri, 23 Aug 2024 11:39:06 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:eabf:157d:f06b:d918])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c459sm4707083f8f.27.2024.08.23.11.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:39:04 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 23 Aug 2024 20:38:55 +0200
Subject: [PATCH v2] firmware_loader: Block path traversal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-firmware-traversal-v2-1-880082882709@google.com>
X-B4-Tracking: v=1; b=H4sIAD7XyGYC/32NQQ6CMBBFr0JmbU3bYAVX3sOwqDAtkwAlU1I1p
 He3cgCX7yX//R0iMmGEW7UDY6JIYSmgTxX0o108ChoKg5a6lo2WwhHPL8soNrYJOdpJmME1F6m
 e0mENZbgyOnof0UdXeKS4Bf4cH0n97N9cUkKJxrStc9a2+mruPgQ/4bkPM3Q55y+CNAaFtQAAA
 A==
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724438340; l=4972;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=sVzJV9USq9eKNEzwIFZInybbtCZlW+uBUC8SgalnmSM=;
 b=w+PQC/YhGSbyDuQGT2kE+BkkIJLnPf7kD9AeBeE6Xxke8ibFZiogpmGPhEoE4cP0lg9tWwuMw
 e4HXbY+zATIAiw+TTOoVuDLHbSVbRxZvxNl3X0b/9e2bZSkwyaTJlJF
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Most firmware names are hardcoded strings, or are constructed from fairly
constrained format strings where the dynamic parts are just some hex
numbers or such.

However, there are a couple codepaths in the kernel where firmware file
names contain string components that are passed through from a device or
semi-privileged userspace; the ones I could find (not counting interfaces
that require root privileges) are:

 - lpfc_sli4_request_firmware_update() seems to construct the firmware
   filename from "ModelName", a string that was previously parsed out of
   some descriptor ("Vital Product Data") in lpfc_fill_vpd()
 - nfp_net_fw_find() seems to construct a firmware filename from a model
   name coming from nfp_hwinfo_lookup(pf->hwinfo, "nffw.partno"), which I
   think parses some descriptor that was read from the device.
   (But this case likely isn't exploitable because the format string looks
   like "netronome/nic_%s", and there shouldn't be any *folders* starting
   with "netronome/nic_". The previous case was different because there,
   the "%s" is *at the start* of the format string.)
 - module_flash_fw_schedule() is reachable from the
   ETHTOOL_MSG_MODULE_FW_FLASH_ACT netlink command, which is marked as
   GENL_UNS_ADMIN_PERM (meaning CAP_NET_ADMIN inside a user namespace is
   enough to pass the privilege check), and takes a userspace-provided
   firmware name.
   (But I think to reach this case, you need to have CAP_NET_ADMIN over a
   network namespace that a special kind of ethernet device is mapped into,
   so I think this is not a viable attack path in practice.)

Fix it by rejecting any firmware names containing ".." path components.

For what it's worth, I went looking and haven't found any USB device
drivers that use the firmware loader dangerously.

Cc: stable@vger.kernel.org
Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v2:
- describe fix in commit message (dakr)
- write check more clearly and with comment in separate helper (dakr)
- document new restriction in comment above request_firmware() (dakr)
- warn when new restriction is triggered
- Link to v1: https://lore.kernel.org/r/20240820-firmware-traversal-v1-1-8699ffaa9276@google.com
---
 drivers/base/firmware_loader/main.c | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index a03ee4b11134..dd47ce9a761f 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -849,6 +849,37 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name,
 {}
 #endif
 
+/*
+ * Reject firmware file names with ".." path components.
+ * There are drivers that construct firmware file names from device-supplied
+ * strings, and we don't want some device to be able to tell us "I would like to
+ * be sent my firmware from ../../../etc/shadow, please".
+ *
+ * Search for ".." surrounded by either '/' or start/end of string.
+ *
+ * This intentionally only looks at the firmware name, not at the firmware base
+ * directory or at symlink contents.
+ */
+static bool name_contains_dotdot(const char *name)
+{
+	size_t name_len = strlen(name);
+	size_t i;
+
+	if (name_len < 2)
+		return false;
+	for (i = 0; i < name_len - 1; i++) {
+		/* do we see a ".." sequence? */
+		if (name[i] != '.' || name[i+1] != '.')
+			continue;
+
+		/* is it a path component? */
+		if ((i == 0 || name[i-1] == '/') &&
+		    (i == name_len - 2 || name[i+2] == '/'))
+			return true;
+	}
+	return false;
+}
+
 /* called from request_firmware() and request_firmware_work_func() */
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
@@ -869,6 +900,14 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		goto out;
 	}
 
+	if (name_contains_dotdot(name)) {
+		dev_warn(device,
+			 "Firmware load for '%s' refused, path contains '..' component",
+			 name);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
 					offset, opt_flags);
 	if (ret <= 0) /* error or already assigned */
@@ -946,6 +985,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
  *      @name will be used as $FIRMWARE in the uevent environment and
  *      should be distinctive enough not to be confused with any other
  *      firmware image for this or any other device.
+ *	It must not contain any ".." path components - "foo/bar..bin" is
+ *	allowed, but "foo/../bar.bin" is not.
  *
  *	Caller must hold the reference count of @device.
  *

---
base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
change-id: 20240820-firmware-traversal-6df8501b0fe4
-- 
Jann Horn <jannh@google.com>


