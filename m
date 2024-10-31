Return-Path: <linux-kernel+bounces-391460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB719B8771
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3251C2145E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31B1552E4;
	Fri,  1 Nov 2024 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yu24/i3q"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F01C82F1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419218; cv=none; b=PIFzMUbbhz8JM7T2yH5qMawv5kp/r7nmQ1g5R3e9EAMfHL0q7TWnF/OqXOhmPzANMn+PeAhpD11VtAzEbyG7otx69lnuy3f3y6pH2eiU8duUJdh4WnMaaiipLVYOgekOxdX1uM+iWKlWXQ27SXZU9jAo+gL024jjW1aZhDEFMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419218; c=relaxed/simple;
	bh=GcFamxwRDGPO3itT2MjcU3zPO7i7GG6u7AIRa1Q7oFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdeCDI6xLCSyCuUUC3JNmWKK9D4oXPmRrAACY6fh+91qICCrmIHl3Hdn1z0/VL5BgKQIxhpJkkkjLll4kBBhKM8QqFdYFIjRHthavMPCQTh6gP5LqIibSZu8VA/DQARF9NIF0qWZQojamKBm8KoM1gSBGCBwY8Kjb/63GpMuxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yu24/i3q; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3705b2883so32794957b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730419212; x=1731024012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQqXD8GGG81ZKLR68lhIbs8UaEvihWRfJOeJXcvzgOs=;
        b=Yu24/i3q5aG87jJNVFOLjAvr9E/GVFHnfn6/TF7u/pE76/AgiMniNJUL2i5ISehmsB
         Y0kHnmu/Z7eRdKr2/TkiHmwv9hoO/MWlaoKCZN1dj2EEe0Y81JXwl1aRyOiU1jfeUQjN
         k7+Ep9Gt3ru1e2C1BeAeMKRa1u93JwaKB2btQgNxTdFAvhDyrB9xv0kdjzEZzY1IM8tj
         Sd0Fs/q08Efin4rt6VZ6QftLp1xlRxnThdUaOVyH6b3y5RdyRL22h47HW8YzhNtwPBQz
         5IUS87z314a/4/LxJrgKQpXm6EJpQPPWs5t9w77I+spAKAzY7qxlg6ZMq5J8zIKowgsy
         /MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419212; x=1731024012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQqXD8GGG81ZKLR68lhIbs8UaEvihWRfJOeJXcvzgOs=;
        b=G3ktvhFnmjDM2qlgvo7VtXi/A4ybZfI1VjQXkhky+nnlcvYAdiCekEZpxrkijwywCX
         KHWXMgkxTYyg426hglT3q6JNteRLwBApxZebV2FTEak0CrFXM2wWkTogELeRdjZfBRz+
         0sVYksoF+8cl7KF1MT6ywktMR640UhUHFpTZck8WVI9ErafFG+7FIyFGXqc6ri051coR
         Kdv4qxHFH1TcaFoODThRSz5OHakGnQ2UcH12Z4WI+zBIJbHyttBwjztvopmMzZZQ+C2H
         y80EiDROOqzPcBnRb0dE0nGmRihH9CJbfOSgP6O69xjxZpfFNKAvVxMrzwnlzZuTm/Ba
         ylxg==
X-Forwarded-Encrypted: i=1; AJvYcCVo9cyj8zZ3BQnJ0r5gxIm9KaTGX1BF3M/ckbhsKw3vFL5f/r5XQDAmDhQIfOU104BenrTRUZnce79aHsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyhZ9klwyjWzUWP8g6x9uU13undcLxfyYWnbF6cq5PqJiAXFId
	0ScQs7zavEtpEkbQLI4h34Sz6njN8cGyqdr84fKz89LG9YMNE4IH7K/UO7Z0n66snp6oqynV1i9
	ZXQ==
X-Google-Smtp-Source: AGHT+IF3kA3CN/HGj+QhxHeBH2gUZC8UXb3P2uSWUlJKoBcrreHMjjN4zZ3Ex75VcC0umN5SfVTmaiZ0oxw=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:2e8f:b0:6ea:fa4:a365 with SMTP id
 00721157ae682-6ea64c11f97mr45177b3.8.1730419212131; Thu, 31 Oct 2024 17:00:12
 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:59:54 -0700
In-Reply-To: <20241031235957.1261244-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031235957.1261244-1-amitsd@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241031235957.1261244-4-amitsd@google.com>
Subject: [PATCH v1 3/3] usb: typec: tcpm: Add support for sink-bc12-completion-time-ms
 DT property
From: Amit Sunil Dhamne <amitsd@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: dmitry.baryshkov@linaro.org, kyletso@google.com, rdbabiera@google.com, 
	badhri@google.com, linux@roeck-us.net, xu.yang_2@nxp.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for parsing DT time property "sink-bc12-completion-time-ms".
This timer is used to relax the PD state machine during Sink attach to
allow completion of Battery Charging (BC1.2) charger type detection in
TCPC before PD negotiations. BC1.2 detection is a hardware mechanism to
detect charger port type that is run by some conrollers (such as
"maxim,max33359") in parallel to Type-C connection state machines.
This is to ensure that BC1.2 completes before PD is enabled as running
BC1.2 in parallel with PD negotiation results in delays violating timer
constraints in PD spec.

This is an optional timer and will not add any delay unless explicitly
set.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b3d5d1d48937..8b325b93b5a9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -319,6 +319,7 @@ struct pd_timings {
 	u32 sink_wait_cap_time;
 	u32 ps_src_off_time;
 	u32 cc_debounce_time;
+	u32 snk_bc12_cmpletion_time;
 };
 
 struct tcpm_port {
@@ -4978,7 +4979,16 @@ static void run_state_machine(struct tcpm_port *port)
 		if (ret < 0)
 			tcpm_set_state(port, SNK_UNATTACHED, 0);
 		else
-			tcpm_set_state(port, SNK_STARTUP, 0);
+			/*
+			 * For Type C port controllers that use Battery Charging
+			 * Detection (based on BCv1.2 spec) to detect USB
+			 * charger type, add a delay of "snk_bc12_cmpletion_time"
+			 * before transitioning to SNK_STARTUP to allow BC1.2
+			 * detection to complete before PD is eventually enabled
+			 * in later states.
+			 */
+			tcpm_set_state(port, SNK_STARTUP,
+				       port->timings.snk_bc12_cmpletion_time);
 		break;
 	case SNK_STARTUP:
 		opmode =  tcpm_get_pwr_opmode(port->polarity ?
@@ -7090,6 +7100,10 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
 		port->timings.cc_debounce_time = val;
 	else
 		port->timings.cc_debounce_time = PD_T_CC_DEBOUNCE;
+
+	ret = fwnode_property_read_u32(fwnode, "sink-bc12-completion-time-ms", &val);
+	if (!ret)
+		port->timings.snk_bc12_cmpletion_time = val;
 }
 
 static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
-- 
2.47.0.199.ga7371fff76-goog


