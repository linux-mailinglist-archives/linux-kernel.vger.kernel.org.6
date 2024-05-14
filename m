Return-Path: <linux-kernel+bounces-179212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1A8C5D67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793F81F22025
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5CB181CF0;
	Tue, 14 May 2024 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQSNSf6E"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFF181BB3
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724102; cv=none; b=HZyLFdhehl8wZKKHoS81r+dMm44Xq95vOhjyLhaBQas33nODF+Fg6ID/zL094SeURfI2/stLE7nKnbCDYoGcIvHy6AMxnvhJJUiI76FNYV3vA263KdT0pJBH7fNi0vhFW/7iaF/t7L7QYGNSVTwxxGctPfxIUwA5BVJAc+3kuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724102; c=relaxed/simple;
	bh=S1tIWGM3NKAB6bQddDwAPW4gGwnmbTJEnABhbu0cG9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JzFJA1RFfC16GgcHS2ZyO+UUILDDnfh1cDkNj4ZyLJg9VHqldBUQWDLjZOPwof4qQjKMHeLqqoeMCuoPJ71D8Nr2AwCkdOvXtQHSAwzc4A1uS7m6aZ6DWxXQCFHWU5TwI7g/gozv+ZEBn0LQYRZVFddGAAmlo7lNgv+OI20seog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQSNSf6E; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c1f7169so87516877b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715724099; x=1716328899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fyYQsAdLlgEZ2rV2qIpyKWvlc+8qV4Q0/4ynMYRrvhE=;
        b=OQSNSf6EZsAB2MBPN+rntvz3u1/3Me76bPtKnPMC8np7XFV4Z5adN0LjEP35NoR+ag
         3hhYhHrtx/u0pHnpsesMsw04Ex1c8cdI/zdAiLva4pcfLrcBtvPU3T3DMM8gCjIlqyLE
         FhqUyyX+t+4f/q3BD6t6IRMRyFB0uPuQAaCcFI9bxMtghWRyCwIBCGB40eC9q2hVtHtI
         jzYqaJD9n8rdBx0Ys7HX4wVvqi9SntuBJDDvZzmBmgLZKdsTrLCmGihqUoONYq0RwGDB
         MO27gbAH6JLIYOidikk21X6QJzMGi2ixr3A4bFDd5CR2YVO9AlavLL1JLP6F0kS3uDlu
         kn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715724099; x=1716328899;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyYQsAdLlgEZ2rV2qIpyKWvlc+8qV4Q0/4ynMYRrvhE=;
        b=gLy5kJWvoWPIKXrflG3aKIRjAv9sC5y7MqrXy0HdDZHnIutA1loeal8AwR4RFIrdD5
         sv0S71f8TuoN/m2F621GLWUc9ERQgxHDK6q27j8G/xPIID3XSq7FQcNbgoC8+iEU0Kea
         fAWQcygPLyGnMZyNNMH8rKJ4sRAXHi4SSFbbPkEmchnhqZGWvXizf7BaEjEOnTr46i/6
         EkWWN1eQS7xwuQedXTAF4Fh2oAFeMnaquPi8gfCYkw2OZ1wTmWkHHEUPsuZhg03I8qtC
         tD5insXuBD4R+BENlloPTIpwHkSe9Hc5dKuvj9A068/Rps3tBLfOx8CAWfGaA18qTx50
         hNAg==
X-Forwarded-Encrypted: i=1; AJvYcCW1E9pbUjgA9TRmlGZnWM6D/AzGK9L4EKNPNpQ1whDZpP9qjwrfw0+kb/DhA+oHtZKdr0jzUl6O819Evv7CW8hl1mblhbzB192V7Ffo
X-Gm-Message-State: AOJu0YyJL4Sq9zhTZjH+ctZ6xZByW5mOB3kOl+gd83Ta16IJvf1GyAFy
	LRX5tkfw+TOu+xg6iToh8aO6lBaPE1f4yAUngDtkVNn+CeCCHgSs8Xduf1FPtZrKeTWOfB14Aja
	JGA==
X-Google-Smtp-Source: AGHT+IFQuPmXbAuMV4yHfCbocvMCwkaDmQTqNl+j+oT+iNlZrjwgKW3FanuU4+YpCrGMlG3QFv2xd8A+IXg=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a5b:a51:0:b0:de5:4b39:ffd0 with SMTP id
 3f1490d57ef6-debcfa7dc5emr3713479276.0.1715724099609; Tue, 14 May 2024
 15:01:39 -0700 (PDT)
Date: Tue, 14 May 2024 15:01:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514220134.2143181-1-amitsd@google.com>
Subject: [PATCH v1] usb: typec: tcpm: fix use-after-free case in tcpm_register_source_caps
From: Amit Sunil Dhamne <amitsd@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, megi@xff.cz
Cc: badhri@google.com, rdbabiera@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There could be a potential use-after-free case in
tcpm_register_source_caps(). This could happen when:
 * new (say invalid) source caps are advertised
 * the existing source caps are unregistered
 * tcpm_register_source_caps() returns with an error as
   usb_power_delivery_register_capabilities() fails

This causes port->partner_source_caps to hold on to the now freed source
caps.

Reset port->partner_source_caps value to NULL after unregistering
existing source caps.

Fixes: 230ecdf71a64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8a1af08f71b6..be4127ef84e9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3014,8 +3014,10 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
 	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
 	caps.role = TYPEC_SOURCE;
 
-	if (cap)
+	if (cap) {
 		usb_power_delivery_unregister_capabilities(cap);
+		port->partner_source_caps = NULL;
+	}
 
 	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
 	if (IS_ERR(cap))

base-commit: 51474ab44abf907023a8a875e799b07de461e466
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


