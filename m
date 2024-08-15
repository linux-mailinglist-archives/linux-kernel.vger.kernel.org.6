Return-Path: <linux-kernel+bounces-287509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E769528A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDF2282B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4E23D3B8;
	Thu, 15 Aug 2024 04:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gLwhjJH"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6E4315D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696874; cv=none; b=gvd/fFxp60/OA4qpl7dhGTAYczIqstjI8lHT/ZI9m/laHxKSHBx8pZZ7n9QWIYRp8RqpeFQi1nuVejtJf4hZgzvIPyvWrZfbGs91UBBHNS8ka/KZNctyf0F0H1Y01KED9YSVMH4ANzaJdfv+64yD6hyFmA3n+JqdnVJVd1twnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696874; c=relaxed/simple;
	bh=CIyh2Hi4CZUi9XTL9S4TBE6w6lxvminAGJoN/U8QYgI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CRAfiJMHd/YFm83yQpgB8BLUKAJHBNFV8jIhOqOI6XqnsYdLLnNQEpuCbot7xUcR/MQSBXz9osN0QKXxS7bPnmXmx7ehGjdEEZZ4tJkjlrUtGJ+4G+PsMaU1kKM57ZVY0B8zWbc8oHSoZWf+Uq86Va97nFBihjvsOTLi0av5zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gLwhjJH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6af4700a594so11104997b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723696872; x=1724301672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KqFPfPw/+eAhFMgbEV1oKb6Go5sw4YpM3slnpPMtK5c=;
        b=1gLwhjJHMKhlsChoSYLtVNj5QNeMu32KYFPqGbBLzs6nWiL+4xSg7C0TSRx5ZGsUxs
         FBcZznvw29G58zfFW0j6k3fJYKWLOurTgcGGi8PNCi+kBmKjrchdGWTZICYPI9ZCLSbn
         p11hn51rbstMjYOfEjZ0ouQ0Qy9r6dM5U8XRzODJGEOFos08JLlBbAnxGIc/kXJ9733J
         H1UVIv/y2e0hGbTkODb9dIdJlCH5GQoBmKCI0c335Zb3LWO8ymcslmg25M2Y7gPBpQ+3
         UGXsb66UwwAZ0S5hcGpCTcWvcYbs42oUjNM8ApTR/qzS4D+/v8nRD9Cw8kjyYQjVVa/h
         qpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723696872; x=1724301672;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqFPfPw/+eAhFMgbEV1oKb6Go5sw4YpM3slnpPMtK5c=;
        b=R0yxMgtgPwL6xPlsIT7j+lvRj5kw9wy9IdanZcZymFrAbw1eeeeIEez1WiUESQo+l+
         DSAQbhPobZC9YSGV8VqpE2tQy3RlP7tR3mPku3QUeMjR9bYGrb6X+8KPTwXzRt8BK8ie
         YqCxB3wO+IPCLqO/HWrH3VEq/oUkjfXv6zpzLr+K7AKFvNXTGTUq/t7PTN4Fq1E0w0/e
         +IIlnvYL1QpPLT/TXaun+9sYj/bqXxdM7ZtSk7sRL6+4bwPfYpqfPeY3+pcu3H6Glfqr
         WbljBJNmTMkO0J06c8f6+NAOOg2JH61dNjqpdj5cBXedzOXxShrWwiPNAz8IHmstTfsd
         xp6g==
X-Forwarded-Encrypted: i=1; AJvYcCUMeoUXCBRgA0B8Su1o16OWL6xBE7RQqOe/Elrbw/38TfEzYwj8ztGBdStZetst7d+xSR69FePAS5KjeOG/3JxQPGaZByzLb6i1yYoM
X-Gm-Message-State: AOJu0Yzj2nYiFrmMsp9bYIPvVwC/XrIGyqXj7EeVRXKQHV+lfFwGmtkc
	Afw0XBi4xXjULDENOnu6TvoydyRylHJedywZ5DySfWf7OFBEp+OZ9kQzTl9YCjtgDkjpoEh5bIK
	u8w==
X-Google-Smtp-Source: AGHT+IEBjmls5YuvvIW0qo9ijmjd+AEQopTobtlkuNiO0WrfeebhHjyKa3UEUw6v44NiYUO2jTU/yTe9z5o=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a81:8d4a:0:b0:690:8ad7:55f9 with SMTP id
 00721157ae682-6ac952c03damr2159617b3.2.1723696871793; Wed, 14 Aug 2024
 21:41:11 -0700 (PDT)
Date: Wed, 14 Aug 2024 21:40:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240815044058.1493751-1-amitsd@google.com>
Subject: [PATCH v2] usb: roles: add lockdep class key to struct usb_role_switch
From: Amit Sunil Dhamne <amitsd@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kyletso@google.com, rdbabiera@google.com, 
	Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

There can be multiple role switch devices running on a platform. Given
that lockdep is not capable of differentiating between locks of
different instances, false positive warnings for circular locking are
reported. To prevent this, register unique lockdep key for each of the
individual instances.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
v1->v2
- Avoid usage of ifdefs.
---
 drivers/usb/roles/class.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index d7aa913ceb8a..9dbe9f6bea83 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -11,6 +11,7 @@
 #include <linux/usb/role.h>
 #include <linux/property.h>
 #include <linux/device.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -33,6 +34,8 @@ struct usb_role_switch {
 	usb_role_switch_set_t set;
 	usb_role_switch_get_t get;
 	bool allow_userspace_control;
+
+	struct lock_class_key key;
 };
 
 #define to_role_switch(d)	container_of(d, struct usb_role_switch, dev)
@@ -396,6 +399,11 @@ usb_role_switch_register(struct device *parent,
 
 	sw->registered = true;
 
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		lockdep_register_key(&sw->key);
+		lockdep_set_class(&sw->lock, &sw->key);
+	}
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -412,6 +420,10 @@ void usb_role_switch_unregister(struct usb_role_switch *sw)
 {
 	if (IS_ERR_OR_NULL(sw))
 		return;
+
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		lockdep_unregister_key(&sw->key);
+
 	sw->registered = false;
 	if (dev_fwnode(&sw->dev))
 		component_del(&sw->dev, &connector_ops);
-- 
2.46.0.76.ge559c4bf1a-goog


