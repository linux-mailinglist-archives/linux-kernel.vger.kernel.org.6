Return-Path: <linux-kernel+bounces-551542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5191A56DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AFD173FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65EB23FC4C;
	Fri,  7 Mar 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac7OwQEZ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE423F292
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365250; cv=none; b=e8bosPugcSJ5n5oFshOVyqHXuidzploeCaRpsR4+hRxMWaf3wXbI4w/HesFJ2k1VviyQMMHecYYIzsq2eDftkTOpq9jhP1314o0UAZcpf+DGM8K62kzAB3OY4d+XqmyMwA1f7tJ3lSFN7IFUMh97kmcsb8D2Gnk0x+P6IP5Gk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365250; c=relaxed/simple;
	bh=MLVeS3S2M/4dawND6bcTBsnDTo8J1PX6I06dfPfpdg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG6uHZYAR5Q2rlfA34MZE6yivQlpwrk+rfxqZBN51wYjwdNU0EzPpjc7QH25icie/E+j8U8C69b/PBDoDxrtPRADWya1z5GgOpe1tOw8L58BwjanTrZPj9y01xqEBwBUktjJier8qzUkTame68Oh0FEgfxzM6C6FnxzOhbdiD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac7OwQEZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so24196475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365247; x=1741970047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adxvT7ii/BhGf5+g/wbSaeJv9L6Vrv0AMOExKXchHM4=;
        b=ac7OwQEZJt+6H7/us/HeBeAbOqkh1Cyhbc9sYyNtNUmzeCCFOenJOtduN/Mhax0qSe
         R5A4X1+VGI7CGeyJozq36I0tUcuVqlvF43jpZD55KbEYxiPYsnHoDdDIBuBfcms8vutF
         ZG+Ajw6pyRpK2Hc/FZx5KpboBdZDKSBoGVfjO5+1w3jEGFcyAhZelqkjyD8pkpRwGCJO
         7/90vS4Nb3+PnNBlTxFnXcCCZVNMRtH78h0ufOTSIAZmfzQqMfVNcenc2a33Pj8QnEZT
         SBUniN4ImPFhEILZAEis8r8Pl1A5tWpUJNpoKoas9xy7HxKYdqRLez5EObl9dCM6MqF1
         QBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365247; x=1741970047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adxvT7ii/BhGf5+g/wbSaeJv9L6Vrv0AMOExKXchHM4=;
        b=hde2wRobSqA2RMJKrCUBmsH9JXngVo9EFkvqGXj5JBUMOWdOHYQq4cng5hzzsqhShX
         6mgM+AwJj+v95d1F1XmHYFvf2C04CsX8FiwwKsGr4wQxEDvcWM3NThE6Ma8tJTkvoyTU
         vWq1nt+007SPU0XX4bAaHriZNvLcEIA+o6ENCs3NKzLpjQv+uO6ICzX3zJRFOBAmn2iu
         Aut5YRPmuUVMFF9Oi9lOOtP3zETeqfpzBqaP3QjPW24i15g27JKgJI7/n9O9YX6cVO3G
         wKG/20ZEK6kVG8FBtLDMhhuBGHYqcgZGqShzkCOLADfH1E0Zd+e8RWniLEzeyQrbTmaZ
         hCgw==
X-Forwarded-Encrypted: i=1; AJvYcCUpfnNDjMjOe7NRQPxXBH+PvxuVTUATSMNtfRIZZsO8FzcUnt4eOwIBr0CfJa4D4jX4BuWIKtOOVGs4dgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyonvRiDiHEKsJCM78QDOVb2UqPWEGcvz7LvhmjypqJBbOTcaL/
	7I40wOaqaj+aA5bFWynrCD1lqKtNlp1jicGKAbWpZwQwQVIw4XsI
X-Gm-Gg: ASbGncuC+9xkwL0a1pWjMP3lrNE+sJ6YaYCdaejlBJmKXAkye6ZWg1VE6mD2dvx2K36
	NwUYWlVnhGlkCTEzB6OPQoLOcL37bTI/4qyN6WCcpJ/ytrbP+s19/GnJ2Torgu072SlQYSCMNZ7
	9DOYPZ9ka6sRa8y7Dx9tmp4X1fPG8QtKwDDe1wDu+ldxe/Te2/9eeOrh+7OB0KGhnr4MKAHQWBH
	yWJxBbNEkTTPIykV6E+zlTrIaxxOSzkD6PNAbWjOJeuCKJh8fKChdbQfOz74h9h+QJlcrXgE0ew
	Cr/rIM9lNL0J5SyOeQgaRakzSSx0ldOKMl+wT/fLndRRjVs=
X-Google-Smtp-Source: AGHT+IG5OJlDQkUEWLTKW9FjBSL7uf+mEOU/9qxTIBuGznGo8NW21a6bnmcM0Z6BWJ1f1cOvwRXYgA==
X-Received: by 2002:a05:600c:4e91:b0:43b:d116:6483 with SMTP id 5b1f17b1804b1-43c6021f13cmr34597475e9.27.1741365246562;
        Fri, 07 Mar 2025 08:34:06 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:05 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 06/16] drm/vkms: Allow to configure CRTC writeback support via configfs
Date: Fri,  7 Mar 2025 17:33:43 +0100
Message-ID: <20250307163353.5896-7-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307163353.5896-1-jose.exposito89@gmail.com>
References: <20250307163353.5896-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a CRTC is created, add a `writeback` file to allow to enable or
disable writeback connector support

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  4 +++
 drivers/gpu/drm/vkms/vkms_configfs.c | 42 ++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index e0699603ef53..abe7a0f5a4ab 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -94,6 +94,10 @@ Continue by creating one or more CRTCs::
 
   sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
 
+CRTCs have 1 configurable attribute:
+
+- writeback: Enable or disable writeback connector support by writing 1 or 0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 62a82366791d..e9f445043268 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -74,6 +74,47 @@ struct vkms_configfs_crtc {
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
+static ssize_t crtc_writeback_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_crtc *crtc;
+	bool writeback;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+
+	scoped_guard(mutex, &crtc->dev->lock)
+		writeback = vkms_config_crtc_get_writeback(crtc->config);
+
+	return sprintf(page, "%d\n", writeback);
+}
+
+static ssize_t crtc_writeback_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs_crtc *crtc;
+	bool writeback;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+
+	if (kstrtobool(page, &writeback))
+		return -EINVAL;
+
+	scoped_guard(mutex, &crtc->dev->lock) {
+		if (crtc->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_crtc_set_writeback(crtc->config, writeback);
+	}
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(crtc_, writeback);
+
+static struct configfs_attribute *crtc_item_attrs[] = {
+	&crtc_attr_writeback,
+	NULL,
+};
+
 static void crtc_release(struct config_item *item)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -93,6 +134,7 @@ static struct configfs_item_operations crtc_item_operations = {
 };
 
 static const struct config_item_type crtc_item_type = {
+	.ct_attrs	= crtc_item_attrs,
 	.ct_item_ops	= &crtc_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
-- 
2.48.1


