Return-Path: <linux-kernel+bounces-298029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4963595C0F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7E6B21B98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12411D1753;
	Thu, 22 Aug 2024 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJMnyF6E"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D516C854
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366242; cv=none; b=oBC9pc+IAMy0TI6yFDoPkoM4WP6UJ3FufE+DhSPT9rqv1S44grZhxr3UdgSp66OExXazdeHQ458tbYwILjpyAWboGD2EwnHi4uZOQF6JkT6N1yCaNX3Om8ROBlXNEJ5APcQE1joBqpFHoux9LAPzLnbpS98maxb1d8WX4GYmrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366242; c=relaxed/simple;
	bh=bV0Hv4F5M4WK/rHCUNMOXrwO9S6mM5cJEw7CqiA6rR0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EB6DaMzBH066QIAkPxlJi4SQeK/H7keHF2L9G6HSJOhB/YwgIbapTmvWk5bT4OKZxKkGwdOM2UsBf1qQHFsWBW9buGzKh8aSMQ9dQlg+eGeMtytF99WeB8WQv3e8Z/BhNLQRhmFRMCmlEDZKajkIEjVMiUXG4Jr5kOSaHQW6mN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJMnyF6E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b0f068833bso36655017b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724366240; x=1724971040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XWZ4Xz+lCe0RvJ+xWgJ0XVc3fOWwjYgwkNv7blQ8afQ=;
        b=iJMnyF6ETBMRRO0EH02OS1Fbi46PEYaJyne8cSJzlwpqyIcevFpSRdCM4nzT8kjqHL
         EvJcv/uHm9QIrgn2qcfiM89+vLgoqX6lwWNZjlncdQL9mtsVtIkcHAkmK1VOto2r+Bm4
         +AoGCNwK/2MNBUwj2RzOp33dYTzQx5eIvDtJxHFVyJtR5A0YsBvt4fbpyP79/SBjcHdP
         3sjbObxRBt3YfDBcMrIxA43w3qhdUianBE8Ff6SP6F6q9A0VLAtpjukDVQTPTW7aI4xp
         kOkCydWieBlyVyOi5Tp87SinXDMsw1Ig9hxNsxeyjVXnGFDjJMRHh7G1q9ogNmG/2geh
         6BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366240; x=1724971040;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWZ4Xz+lCe0RvJ+xWgJ0XVc3fOWwjYgwkNv7blQ8afQ=;
        b=RxMDaAbNEAkgl1QylX8sijdWv/LO4POr0JYtix3rSxEpK+Cv974cMpA107vvlOVCP8
         VeCNiAhzI0XApq8+J9/YuanFJn5ktjF7AkREPh6gckrcoI+Jpgc+GjjwnwxoF15BcLqm
         KkI6ok/9GKs4hj0bLiMusxxWLWLNT+/WEg3IoaBHcjy57+8anUSoYKgGfahv8pBs4zAT
         UsYHFHKIgiBcALuh02m29LDe2rSRfo1zntWtaMAu2pwcvQjeKzrD+5BqHb86jfM95p/r
         wAm6YKWz+vgMAsjEaRs7jjARmaQ8jx0up3BcsdUSrPiSWOYBNRCA0+ex/UYr71MXn5Yn
         4Urw==
X-Forwarded-Encrypted: i=1; AJvYcCVE1ZJzX+TjzkiAe6ijzXuBQIBVxVItxg8OUHOtJEd5J1Rh4IwQQ9b4JD8mq4tuXoPqcRZcQaoTPnr+FwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGYh0mBadpW2+Akha4lqLguxJ24UkjbJKL8WU1ZDSGUZUIgZl
	pQfOVeaYr6qb73lSxLZt74Ny0RQdMZ5R3Y1ZKRt1nHTLarWsR5QrbtmSRgLYAHAYbNwWtA+Ojiy
	kuQ==
X-Google-Smtp-Source: AGHT+IEh0feUnYKmvoGoanKbfZ3EUdFCfO1u8P1OY5a3VSAoj+0fu18DZjI2TT/irFJwTHZPiFBAr6SCExg=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a81:f911:0:b0:6b2:7bd8:d794 with SMTP id
 00721157ae682-6c603e614a9mr253617b3.4.1724366239661; Thu, 22 Aug 2024
 15:37:19 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:37:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240822223717.253433-1-amitsd@google.com>
Subject: [PATCH v3] usb: roles: add lockdep class key to struct usb_role_switch
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
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
v1->v2
- Avoid usage of ifdefs.
v2->v3
- Removed redundancies.
- Completed peer review and added reviewer signature.
---
 drivers/usb/roles/class.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index d7aa913ceb8a..7aca1ef7f44c 100644
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
@@ -396,6 +399,9 @@ usb_role_switch_register(struct device *parent,
 
 	sw->registered = true;
 
+	lockdep_register_key(&sw->key);
+	lockdep_set_class(&sw->lock, &sw->key);
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -412,6 +418,9 @@ void usb_role_switch_unregister(struct usb_role_switch *sw)
 {
 	if (IS_ERR_OR_NULL(sw))
 		return;
+
+	lockdep_unregister_key(&sw->key);
+
 	sw->registered = false;
 	if (dev_fwnode(&sw->dev))
 		component_del(&sw->dev, &connector_ops);

base-commit: ca7df2c7bb5f83fe46aa9ce998b7352c6b28f3a1
-- 
2.46.0.184.g6999bdac58-goog


