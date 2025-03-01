Return-Path: <linux-kernel+bounces-539842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB7A4A9A2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645021754E5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222881C07F3;
	Sat,  1 Mar 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OL5vyS3Y"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72CA1D514A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740816681; cv=none; b=KvMayIm5DyEN4SrOy/HWAZKW9489vto2vwpTSqfJHjCrLe7TSmPAaSJNryDMXzSEz+PbfgP/dM4X2K2V9RqKhQyBqTqpqWwM/boq7cXjEBVSipJdhibpsPE53GWUwVNLNxvaBMWm+9UYrBrK9rViV5XjHBiGE0CAdQQa3gF+ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740816681; c=relaxed/simple;
	bh=W3esQ3uB2eK7u8wdWDrtbmEiIIXQW1K0iZZVUbIYJ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5CY3ebHWxKOTc59yfrrkUC7cynmme5WcnHSGAqUkILBwz8cHHyQY7P3C4sp6gMu96m8ngQGoyi9uFxW9Z6/0YXblO4uIKYcDXgoYFjx03RKjVcQ8XqNgNNnHsdTNExD71wlWnBe3afq7Rlp9fUT3tXRV4jTfyliARIOS/srFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OL5vyS3Y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so3844115a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 00:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740816678; x=1741421478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9AznYEhhOxvf1OTat2or4y7QL3kvaIdXLnyiooUz1o=;
        b=OL5vyS3YzeHes3eO37urGrnGjxDrMISuhYLEDzgNF7ICl9j89K47qCWTGs8HJNn5an
         ZuoaJ+4mnjWzYwoHy4hH5khXFawyh7tiBBOG9uB1kbDUvkdhkkFRBqLWYOxXwPetvDMJ
         HTZcIMeu6D0tqtx9Xi/5rZuje4jDNLgdNKcAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740816678; x=1741421478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9AznYEhhOxvf1OTat2or4y7QL3kvaIdXLnyiooUz1o=;
        b=wvFJbfTeEQTeHdmTISkGEaSwgQdpQ/07k1D780sX1KyscJL0G8cf4UOhkTLz8gYY1b
         s/WYOmpRG0vZpL90w+LVPHJPqCGRR85aZHWxjX8clyyxDQhMqj2DuE/KkkiinPWOH1FJ
         nOruuZmom7HjWtbzTiXRXLuA57h8Q8USvrHwnPdg7OrHn8ufVtn0g6NA/5mxqtdfxTJE
         05SjUgSAvqozMJv7Wzzb0UMU/saGmUwFpLZEy+RSAAZn88OV5t6iKJZF0bW5hlYcPpqS
         tLHwa7+cwv2afAq0zEh3orqWiqilCvYETzF5Cy+AIF6tRRr7rLfLbger0f5Cx4g2SN3s
         V5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUsaZIEP2Vg+eXVwqwCVarLqBdiOTlFzaNnog0vRBgzIcsYBO/SkE6BEKvut0ih/cDS5L/j7UINWWf9qJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRIU6djCR7Xi2yDTtvo9rS9uRYK5dkR911zltYpWoi5Jmn5jV
	kH6X/VJug1KCXTzH/5xOUhFpZPqvSpUztn4ekRhh5U4+uCcXa9EbzrA4QLk97A==
X-Gm-Gg: ASbGncsmTfZzKAaratjkAX1BQI12ar1t55QNmlZ17tybWp33HAaTDwuQTo/021qne8q
	8yxJ5dqoFowaylVJ+hgZM80Pc6IfWz2pviA21MuV6edl/6/oDK4W+fY5g5184b/Hj/M102lJ/NZ
	pE5xrNMqGfa6V6hjZcAxKY/EF4c7SSvv/H94PKIfnh18IDgfrZk4K4HXuYwI768EJvy1ZImPY8F
	FW0KPhp1xVxGX5Zxluh8R5mt1NZ6MtJx2Ma8hwKjpjt9RDcrVXsqy53kM1uYtU5Sgbmgwu5ny/b
	Nkzs2RyC+U8M7F7dHaESnIZO32iEopAMO6+0iK/nUBB5ohx+PT5uby6I7S7MAPrTmuARBH3L0iu
	OdAmZOA71kvv5TCgXIjTg2HKGg3Hl+deQvR4=
X-Google-Smtp-Source: AGHT+IF2bddT16xrWqHaoLOeMqINJ2RLswpfmiriAxWx8apEVmlQ5vYHvVN5jHk5ZP6gPal6kwpftg==
X-Received: by 2002:a05:6402:5214:b0:5e0:348a:e33b with SMTP id 4fb4d7f45d1cf-5e4d6af10d0mr6525153a12.12.1740816677909;
        Sat, 01 Mar 2025 00:11:17 -0800 (PST)
Received: from akuchynski.c.googlers.com.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa5dsm3693641a12.14.2025.03.01.00.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 00:11:16 -0800 (PST)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH 1/1] usb: typec: ucsi: Fix NULL pointer access
Date: Sat,  1 Mar 2025 08:10:56 +0000
Message-ID: <20250301081057.1952519-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250301081057.1952519-1-akuchynski@chromium.org>
References: <20250301081057.1952519-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resources should be released only after all threads that utilize them
have been destroyed.
This commit ensures that resources are not released prematurely by waiting
for the associated workqueue to complete before deallocating them.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index fcf499cc9458..43b4f8207bb3 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1825,11 +1825,11 @@ static int ucsi_init(struct ucsi *ucsi)
 
 err_unregister:
 	for (con = connector; con->port; con++) {
+		if (con->wq)
+			destroy_workqueue(con->wq);
 		ucsi_unregister_partner(con);
 		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(con);
-		if (con->wq)
-			destroy_workqueue(con->wq);
 
 		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
 		con->port_sink_caps = NULL;
@@ -2013,10 +2013,6 @@ void ucsi_unregister(struct ucsi *ucsi)
 
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		cancel_work_sync(&ucsi->connector[i].work);
-		ucsi_unregister_partner(&ucsi->connector[i]);
-		ucsi_unregister_altmodes(&ucsi->connector[i],
-					 UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(&ucsi->connector[i]);
 
 		if (ucsi->connector[i].wq) {
 			struct ucsi_work *uwork;
@@ -2032,6 +2028,11 @@ void ucsi_unregister(struct ucsi *ucsi)
 			destroy_workqueue(ucsi->connector[i].wq);
 		}
 
+		ucsi_unregister_partner(&ucsi->connector[i]);
+		ucsi_unregister_altmodes(&ucsi->connector[i],
+					 UCSI_RECIPIENT_CON);
+		ucsi_unregister_port_psy(&ucsi->connector[i]);
+
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
 		ucsi->connector[i].port_sink_caps = NULL;
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
-- 
2.48.1.711.g2feabab25a-goog


