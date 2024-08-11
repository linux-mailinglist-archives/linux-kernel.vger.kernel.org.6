Return-Path: <linux-kernel+bounces-282243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500F94E145
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F481C20CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220747F64;
	Sun, 11 Aug 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+cw2Oay"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA319441F;
	Sun, 11 Aug 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723380417; cv=none; b=hW7mgtbWpqDmW+2LSaB3eErOABn8QrTG+257HOqgjzNGuBMw1g+ha6M0va2OzVRA2ubCFRR34JBcB41gw/XZ4MIXk1CvBg9wgyImifhn9pacLKKlIuR9hZsHNoUQBPaqkAcwas7NDNm4PvvSmsOuANkOQzQ7uSCc62ceJKt272o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723380417; c=relaxed/simple;
	bh=UOTW0S88uks4HP7UMdz48xRDXQIW94fYPNKBpBibqO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnhYPtZybwCBLIiNK3lENgy8TeBLbI6NGWMNazZ3mRnUTaMrSzEPTnWLlyZhSjKCotNv3D2uwQ4FxNPeVuJ490ArYrB98X8WJx8l+uAX4Te4dG8zt3Tpx3bHil9ZxKkrP1zZUCveKhoVWG6+8CHphxr3cch1trL38E+hRPTuqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+cw2Oay; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-368440b073bso2012278f8f.0;
        Sun, 11 Aug 2024 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723380414; x=1723985214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4o2TWP+Vhvp3od6SuhOiNbj//yyX7aMfSacjM3aiopk=;
        b=k+cw2OayiJacm6HrolHLLO1crtccC/JnvAuyd80RYpj9FYGOrML2YUMuP7CUH2lnLF
         dDGkpzv7yfmZswAxygddXR8GJ1uhHgz2TAGqsV57k857vS2MztqbcmnPD9RsQf1UiWp6
         um787sjhx+0h9HYjj7UEoSQ3D1YiSTNELVAkfLI27m4oyP7xXsEz+6zDiczWNPKJnXV6
         gdhpTrsDiUqO7WBFp6VxyPenFeflgqN1gZ5NbjFhMtrb1qd269Y4ftnRhwk0xC4bBSbH
         RFZ+iI1o9PXqU98JhciIE0hDXdkpKfM1dtFIiM1RCQnTnPyfwhRxLOwavTd+MRS1fbOH
         ogog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723380414; x=1723985214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o2TWP+Vhvp3od6SuhOiNbj//yyX7aMfSacjM3aiopk=;
        b=ueOWwvUJvF6h4u2xzIZv5kwERI2D6DLhbC5dxvffDgOZM5ij4Gn2Sm1PxYkknry4mF
         /ArtTz3hreQ2HHLrdQdInMJpWaFdIV5jH36pD9i+hhmaUizvvHWsJQ9qu2Kt8LEkqnXp
         9eyhXpphY6EpBhNxNejuS4bFNguqIIfchjs48guSXz2W76h/+Lti4lNBnDperMswcaJW
         7aycsB5bY4Y+Gwp1FoIj5S9dLiGrJot+rrCP44vLnDuDG2D8cU1IcxBUPMGrRv2XXI8n
         KxZieIX9ivVjKj4M/dYeZQWyBpoPZr7pY1bfkR5GF09aHNA8ic354OhCiGDOoPRVjG8+
         W3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZUiOkrgHTCs83Dv38OMD9M3eZNAhc1sWbzJa/dQolLOFD/DxC44jEc4EVe5KjRqrXoZ63l2cmkQ1R3IvuJ0cGeLooKi30RRZcftqf8WEE8dhxVuyrHPlwjvVrLExL+HIyDRTfVsgfrZAZkxw5mDAV3Q==
X-Gm-Message-State: AOJu0YyqNN9B8oQGfT06U5yI4Cc2cT761X1e9pywRisQADq14gv6YUVm
	VZtoROz8nJiOyLdFjN9RWge2pudBJukddM4dpJh7ItqQyo7lOzONkzQvZw==
X-Google-Smtp-Source: AGHT+IFbiubdkYVo25iGBEa2LO/vfULgoIQ5BI7E2vfc3y99ro3sx/UK7xuDahjUGDns1xQmvwxZfg==
X-Received: by 2002:adf:e98a:0:b0:368:3ee9:e119 with SMTP id ffacd0b85a97d-36d282060acmr8116035f8f.29.1723380413840;
        Sun, 11 Aug 2024 05:46:53 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d4c9sm153452945e9.8.2024.08.11.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 05:46:53 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: Fix warning when controller is destroyed in probe
Date: Sun, 11 Aug 2024 14:46:44 +0200
Message-ID: <20240811124645.246016-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a small window in ssam_serial_hub_probe() where the controller
is initialized but has not been started yet. Specifically, between
ssam_controller_init() and ssam_controller_start(). Any failure in this
window, for example caused by a failure of serdev_device_open(),
currently results in an incorrect warning being emitted.

In particular, any failure in this window results in the controller
being destroyed via ssam_controller_destroy(). This function checks the
state of the controller and, in an attempt to validate that the
controller has been cleanly shut down before we try and deallocate any
resources, emits a warning if that state is not SSAM_CONTROLLER_STOPPED.

However, since we have only just initialized the controller and have not
yet started it, its state is SSAM_CONTROLLER_INITIALIZED. Note that this
is the only point at which the controller has this state, as it will
change after we start the controller with ssam_controller_start() and
never revert back. Further, at this point no communication has taken
place and the sender and receiver threads have not been started yet (and
we may not even have an open serdev device either).

Therefore, it is perfectly safe to call ssam_controller_destroy() with a
state of SSAM_CONTROLLER_INITIALIZED. This, however, means that the
warning currently being emitted is incorrect. Fix it by extending the
check.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 7fc602e01487..7e89f547999b 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -1354,7 +1354,8 @@ void ssam_controller_destroy(struct ssam_controller *ctrl)
 	if (ctrl->state == SSAM_CONTROLLER_UNINITIALIZED)
 		return;
 
-	WARN_ON(ctrl->state != SSAM_CONTROLLER_STOPPED);
+	WARN_ON(ctrl->state != SSAM_CONTROLLER_STOPPED &&
+		ctrl->state != SSAM_CONTROLLER_INITIALIZED);
 
 	/*
 	 * Note: New events could still have been received after the previous
-- 
2.46.0


