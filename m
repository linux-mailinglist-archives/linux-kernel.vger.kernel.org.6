Return-Path: <linux-kernel+bounces-212948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95F9068B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42451C239C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4D14037D;
	Thu, 13 Jun 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2GrKfy1S"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE913E40E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270924; cv=none; b=uaiGFno+myA5MjoFhV5E2H+dVW9aVHUJZf5c2P9O39oF/x4PqDhBa8ju9NNmrb8mAsz+Tv+VViZZR0Xg6C6kQLsBIMwjHleBC7y6KYJ4If2bXUajkSLv9rTiWr4oSYLDDqMG71oB8gF7qRYlwUYqn7nGdnIcP5WRedykUNNfWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270924; c=relaxed/simple;
	bh=5pgijTNOHSq33kNFeZWgVCJ/+J4jPXvn/88PeX7JNp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkuVqQu9qtJQy01s7/ac6MWho/W2waMMKyUTZB3kErenGHHPuxFlK+NwpD2yZht8nQx3exDutyeVhZO28WLbMeUEunY4g5MFMcYtKMHzzqEKj7IRq3uMVSVU5XLkivi0kYY3ybbumbncvx9Og1Uri+SlYy5IJ12C6PChyvVyPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2GrKfy1S; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebed33cbafso8335771fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718270921; x=1718875721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc2jSE+iPH8VTD+ljhWwIl7lvYVzx0ufmLaVO0qarUQ=;
        b=2GrKfy1Sz+intGFuG4F24LI9SkM4Cbwlz2euNcknSZ/UyUv2a7b2znLTSPZnuv88D6
         YLyHeS+cTHL/6NrHAu5pF9D0mxBhQfNuDF5VWinli7hus6owEyahk6QfY2ymW03428Cq
         MmZ6G43hy4+nsJKg0DPjTC2QJUvB85/RTgUCMfiiLDFjtFCc7PayYSpAeRC/qoU9CcEF
         ZbjluU2KhGBBqgaXbxwS/j3A427NfpDzIVbNI6xZHiYQJVbhwbbu8kOBaI9bAEA886Th
         g1Z3AcltZo4xCelVpEIl0+Pp0xZOwZISNZBM7RGRxviEYhV5AsVtWFMoZVSvwhptUy8w
         iLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270921; x=1718875721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc2jSE+iPH8VTD+ljhWwIl7lvYVzx0ufmLaVO0qarUQ=;
        b=wmrH+tIhKfPsOxVP/WLbLqZgp4y5ALzL3NtnEwLcIO01iJC9XJabtzV3TJzmBQ8pAT
         LX4Xl3X+/gIjy732gYNNy18RtGvF7/6KWZQgItQcHswi6yx9su5lb+L1Mhw3F8qfPo7l
         KubT9hOlb/htxQ2HgOjNDa8r2EP2r6zxeOqdSVrNo+nuOk0AkMj9ETdL9oWdJ0P97/nV
         16ejHZFHTSBNRN5uSCp6o0UUVwPbts3P4n/WaMbcyTrexlf6sCKYyuuyrj++ZuFUk2ZX
         8K7De9tLmVIzKnjKXdnE8CY6yeSy/6SVG3peycZjtp+MA2X2Tcmq2RigHq7q5+yqhpzO
         0bHg==
X-Forwarded-Encrypted: i=1; AJvYcCV7lQ7PjYxJCT/E82dYSYjurEUWwiiDXEM227BoXq+/fneE+Bg93mq+KkXBtgo50I1AFaDpga46Ric613pYJood/B7PMDqwejUPSjH9
X-Gm-Message-State: AOJu0YwoY5otv0FkrdzTRDCHeV160qoYPVapehXLOYnWtdbzYZojmoPt
	LvHzi1RmubLlrPEMEptleuZK7NLBrIz1iV1gBDIl1bB1cvHFTorGcfF9tW6W8Ek=
X-Google-Smtp-Source: AGHT+IFkLo+cbc6Zg/KlLxxSJQydQmIB8foYzgTBu2MYiW9llbTP9u+6JKlPeX49yob/xdyL4IQdkw==
X-Received: by 2002:a05:6512:3994:b0:52b:bee3:dcc6 with SMTP id 2adb3069b0e04-52c9a3fcc4emr2896885e87.51.1718270921194;
        Thu, 13 Jun 2024 02:28:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:875c:e292:3280:ccac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73e8sm54990205e9.43.2024.06.13.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:28:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v8 1/2] drivers: export to_ext_attr()
Date: Thu, 13 Jun 2024 11:28:29 +0200
Message-ID: <20240613092830.15761-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613092830.15761-1-brgl@bgdev.pl>
References: <20240613092830.15761-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make to_ext_attr() available to code that wants to reuse struct
dev_ext_attribute. While at it: make it into a static inline function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/core.c    | 2 --
 include/linux/device.h | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 131d96c6090b..d51e7f05d15a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2459,8 +2459,6 @@ static const struct sysfs_ops dev_sysfs_ops = {
 	.store	= dev_attr_store,
 };
 
-#define to_ext_attr(x) container_of(x, struct dev_ext_attribute, attr)
-
 ssize_t device_store_ulong(struct device *dev,
 			   struct device_attribute *attr,
 			   const char *buf, size_t size)
diff --git a/include/linux/device.h b/include/linux/device.h
index fc3bd7116ab9..f7957ec918a3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -120,6 +120,12 @@ struct dev_ext_attribute {
 	void *var;
 };
 
+static inline struct dev_ext_attribute *
+to_ext_attr(struct device_attribute *attr)
+{
+	return container_of(attr, struct dev_ext_attribute, attr);
+}
+
 ssize_t device_show_ulong(struct device *dev, struct device_attribute *attr,
 			  char *buf);
 ssize_t device_store_ulong(struct device *dev, struct device_attribute *attr,
-- 
2.43.0


