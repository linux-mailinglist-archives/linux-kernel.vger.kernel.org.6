Return-Path: <linux-kernel+bounces-285571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9776950FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38EEBB2181B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710F1AB52D;
	Tue, 13 Aug 2024 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IhvF5fYu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8A1AAE2C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588942; cv=none; b=Ozr5x4x+Tq14zI0xzHGZcQuT6bmC/rnq/Y1kBt5bR4agzhr+inbBnbrSjbQ6y/A864E9Ti7OD8yE0LKGWEuwTjmPEXq2jQ9C6RTu9K+5R/mvfHFDRIe+62tDbT1pO+ztFhfLRfUGQHwIgJzjaevMK+d3AlLeO7rivy8D4K2N2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588942; c=relaxed/simple;
	bh=/38aI+YAN2Wq+jg1IZPZHLPCfbDsyq9J8zvtu8VEKZc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NpBrXaB8K/f+LoO9T0TK8HL4pOTqQbk+GhPBM+vl7oEUeAVVCXJkXMhoQ/bEoeSbNy6ivwDfXoPJiuh3NxSVZpVhoFxDGR6/qHXpA9YbCMt5OL8VRWYtcUa1ywC49WsxdheFcgQ1Blnia9ApDO5cl7B6yj5go3Hr7zu7JErAPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IhvF5fYu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664916e5b40so5139297b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723588940; x=1724193740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nNyQdek71tWkWFoFbYjEqvCxbsnsam31z3z18l0u0tw=;
        b=IhvF5fYuHrK2tDaGUA3dUOBJAAh2mvu0SAoI1MYqjLkYlDOWytZ2hTsvYNk8Z7WaM2
         dL5WE5v5QNrJkpJyyDywBLgSzcUwTxdf4bbKR+iRh+zOp3O7EDPTEBlp6QMwsJZ3p5xJ
         x9f4BEBiw4HW8+RevqJ0Bs3trDqfOWaAo4nsU5R5PA28L/hhm0UL+71t/jPtHHxgVdpZ
         Quhc+KvYRhN+iWPizLCDMWZHy0Xp50NeWmCxqQNWyl9i5Jre4sOIGLlm3b9gnhYnJi9e
         4w61iYVCF8C69mLA9BK/Vk7ngFapAc+W6GR7+RklmkMa80ILlC1GlJ94XZs15+BXFOk+
         tKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723588940; x=1724193740;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNyQdek71tWkWFoFbYjEqvCxbsnsam31z3z18l0u0tw=;
        b=Rl82vRIhiypIzeKhv/H7+8/dsLKJG8VoHf6CEP1npaFtZB1PqVs/lZdVv3JIOoeZw7
         H7APXRP+bArvFLZeDsm8h1kjRWPKSF+laIS5z1XBlq7ScKVhnr8U0SwuvPl75kkDbbBo
         FWJXn20gVcmLEhq2rOrkcrNDSwli6xryS+ZofsHC8Bn4UKWFhdF5jmWR8QWD9eEcq73O
         dZ8Z5+Low/MwOyELYp/avwhXuAIwvl3XU5X1pyE8CnRmg13DNMiduksUGW8qhj1iFtjX
         vAA2xJ1uxOXJ8ek5UT8OU/2lDQbgjRVrzu0c5AmD4R9G19ykfSh78+rKBDjKbwvIfAe5
         kiIA==
X-Forwarded-Encrypted: i=1; AJvYcCWMOLeHNTXSHcSEwFrJSiFPrt7rKXFSwAggghjvr7u9TYsLpJiA4guB/uXwbo5qY8LssBOJmWKpY4bfAJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxytKjsxaN3nyhC5vBP+zk+Z6SVnNvvXShWHJvY7hvqDB0vQlNF
	gAXBLliE5SxJgtHzVM95Uv6moy7iowhrIKSk1m1NcuVRvStlI+Rk2uos8kuRBCYao680KHTn5Tm
	Vgg==
X-Google-Smtp-Source: AGHT+IFogisWsaivYv9CNJQlglDwle03mtYwK4ZCba6a77yHOJqB85TEgvNiv/CtmfMxOg5eUSyAfr02VmQ=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a81:77c1:0:b0:648:2f1d:1329 with SMTP id
 00721157ae682-6ac707e5fc2mr626617b3.1.1723588939990; Tue, 13 Aug 2024
 15:42:19 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:42:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813224216.132619-1-amitsd@google.com>
Subject: [PATCH v1] usb: roles: add lockdep class key to struct usb_role_switch
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
 drivers/usb/roles/class.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index d7aa913ceb8a..807a8f18ec20 100644
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
@@ -33,6 +34,10 @@ struct usb_role_switch {
 	usb_role_switch_set_t set;
 	usb_role_switch_get_t get;
 	bool allow_userspace_control;
+
+#ifdef CONFIG_LOCKDEP
+	struct lock_class_key key;
+#endif
 };
 
 #define to_role_switch(d)	container_of(d, struct usb_role_switch, dev)
@@ -396,6 +401,11 @@ usb_role_switch_register(struct device *parent,
 
 	sw->registered = true;
 
+#ifdef CONFIG_LOCKDEP
+	lockdep_register_key(&sw->key);
+	lockdep_set_class(&sw->lock, &sw->key);
+#endif
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -412,6 +422,11 @@ void usb_role_switch_unregister(struct usb_role_switch *sw)
 {
 	if (IS_ERR_OR_NULL(sw))
 		return;
+
+#ifdef CONFIG_LOCKDEP
+	lockdep_unregister_key(&sw->key);
+#endif
+
 	sw->registered = false;
 	if (dev_fwnode(&sw->dev))
 		component_del(&sw->dev, &connector_ops);

base-commit: 38343be0bf9a7d7ef0d160da5f2db887a0e29b62
-- 
2.46.0.76.ge559c4bf1a-goog


