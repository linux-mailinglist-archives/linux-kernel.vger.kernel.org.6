Return-Path: <linux-kernel+bounces-176118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B372D8C2A16
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E821C21689
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43584D5B0;
	Fri, 10 May 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhgFULAD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA24D135
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366629; cv=none; b=EfUCGejJCFXN1WGDX17UwKcsMncLCVCqJpp9XxOLeKyxA3+hFrOtlsmmOhOJUtRY4JiHC8ynocN9avg56D5FlDuzC5kQbqW7a6LRHTPhr1sLvysNYoxtX+o3kmgsiQfAkkPrhg/tu1HQvx66ug2qa5zE/M/fHLRQitoPnwe95tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366629; c=relaxed/simple;
	bh=R0kPcz2z7KHQtcT+DCQun4RPsuErPgcBNGZMQbxuRmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nW0SSYohORbv2KtSq/nfvp5rWV3x6dpRGdhnHCWI6CAx4/y4SxNsztgisFpuEvMXTgsGXD0aZnYj6p4oqwmwUO802xV0qv5oA/Wl8CAbvE/skcgG+/m3U1VNuQ87zRdMkW+0d8Xn4cR0/x1IW9ywxdEfgQDyB17c2rpK+clLRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XhgFULAD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62035d9ecc4so40628157b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715366627; x=1715971427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5TEblfXliubmthqHAqJA2jNdtqm1t1yD50gCYv7pJus=;
        b=XhgFULADE46oqk5FpKzQer23oOo97i7TBoKoeteoHxUBHNuHCPWnXvKdZNQrVjzI9g
         /cU/NV3jJ6FhUVepkLpNnw/MUqZ9jRrP9zsJjFxDHwexN1R1ghP1FwZliTXMDWNk3E7b
         1QJmp3pPrp/41fg2wC3N3mMoj1ed9iTvxWNG6z8WerFrmT+UrdiEzD1faLvpCQx3GwPm
         yp1c4ZATrUnxu3OjSAS3px7eDx0ICMC5tevh6MkcjbwmchHB94CcHbRxznmJqmLbu5Uk
         LxuksmOr67lIagAgYJ44qsqCQ9rzJ7wFR9A2wlj/JkVJlcQ5Ljgnqw/5P/khHRCGmdAz
         1M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715366627; x=1715971427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TEblfXliubmthqHAqJA2jNdtqm1t1yD50gCYv7pJus=;
        b=siNpX9GTVuu80WlG8xoMYylO8tphvQhjkT+JnFsekOeQI1/C+jcLROyGO3kUWi+GYL
         iZ8EQLmGtXr3X1ZGybBn+47iaxcEpVhosOvy4nvtYJsVIRFK/ZuIZYZQ0WklzeZeF9Yq
         3a0mR6SFjkVJ6pEy2hjDr056tpoUkv4RkETVspBhdXZ4kriwEiGEaQNKJMqPSookqNZc
         IYnL++SrijUy6v5C1RPezf+5myFHrJ2KkN0FK49g3z5lRixWyAZ4ZlbMENyPYvp5gfxT
         wnauJw6Osjtj70QiZpZ+dt9/iTxp2WKMwQ5Dji+pZmC759Q8v6ZlIYOWgNiIewyzGI//
         ejfw==
X-Forwarded-Encrypted: i=1; AJvYcCUQBakLxV71klYvJiOzMVS7sWsjwL7blrW4Nkgc0iXRMJ2fSp83yFskC2y81apiUXGQpiA3bbjb5EmobOPNyO+gdEzP20uHdTMHo2DZ
X-Gm-Message-State: AOJu0YyW53XT6+SXto/Hlsb06slgFPY/q56jcZbR3wlS/iJcgQOSQIpA
	vplseyQGCQYSlGChweKvCx7TApecUBdlxXSokOGAc8rMckKiBpikp7mmt/PILWz73bolF8Eg2p2
	gpQ==
X-Google-Smtp-Source: AGHT+IGaWgy+lzvqz9wTSsHNfbW5bue9orgmN1BHek+1YZUAMaba3g5YRlXLvCXcathhN4gsL6Nmrz7YeF4=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:3801:b0:61b:ec81:3f3b with SMTP id
 00721157ae682-622b0038dfbmr8623737b3.5.1715366626864; Fri, 10 May 2024
 11:43:46 -0700 (PDT)
Date: Fri, 10 May 2024 18:43:24 +0000
In-Reply-To: <20240510184324.2944101-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510184324.2944101-1-jthies@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510184324.2944101-5-jthies@google.com>
Subject: [PATCH v4 4/4] usb: typec: ucsi: Always set number of alternate modes
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Providing the number of known alternate modes allows user space to
determine when device registration has completed. Always register a
number of known alternate modes for the partner and cable plug, even
when the number of supported alternate modes is 0.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in V4:
- None.

Changes in V3:
- None.

Changes in V2:
- None.

 drivers/usb/typec/ucsi/ucsi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bb6e57064513d..52a14bfe4107e 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -812,10 +812,11 @@ static int ucsi_check_altmodes(struct ucsi_connector *con)
 	/* Ignoring the errors in this case. */
 	if (con->partner_altmode[0]) {
 		num_partner_am = ucsi_get_num_altmode(con->partner_altmode);
-		if (num_partner_am > 0)
-			typec_partner_set_num_altmodes(con->partner, num_partner_am);
+		typec_partner_set_num_altmodes(con->partner, num_partner_am);
 		ucsi_altmode_update_active(con);
 		return 0;
+	} else {
+		typec_partner_set_num_altmodes(con->partner, 0);
 	}
 
 	return ret;
@@ -1138,7 +1139,7 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 static int ucsi_check_cable(struct ucsi_connector *con)
 {
 	u64 command;
-	int ret;
+	int ret, num_plug_am;
 
 	if (con->cable)
 		return 0;
@@ -1172,6 +1173,13 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 			return ret;
 	}
 
+	if (con->plug_altmode[0]) {
+		num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
+		typec_plug_set_num_altmodes(con->plug, num_plug_am);
+	} else {
+		typec_plug_set_num_altmodes(con->plug, 0);
+	}
+
 	return 0;
 }
 
-- 
2.45.0.118.g7fe29c98d7-goog


