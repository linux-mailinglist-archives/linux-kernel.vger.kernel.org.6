Return-Path: <linux-kernel+bounces-546661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768DEA4FD6D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5007AA30A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96423E35F;
	Wed,  5 Mar 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R3QzpMd/"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99D1FBC94
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173478; cv=none; b=V03W0oSPKhgl9NnTmgkc3mjDzBnpe/BDUvYS75QnXKYthWnVG5omH/9FVTdoc5oC+bPEe4dtJYTXi3Fps9YLB+w+3e79+hw9sFMCJXCUpydM4WXe0cesNcMOsMBnS1Q2INen+02p6ytYNQg8KaHhyLB7Ug2GFzHziKxvV46urps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173478; c=relaxed/simple;
	bh=yclqQDzQ3fuTbQrldeL31okzvYD3Yv7nodsLYHb0az8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwjBuAmQc/ZD31ovs4yJ6bGAvGtJ3VYwT03nWEEVg67vz5KLKhGwRQSr7gcs5GnBnWJoLLLm67TswJolfR8zQv8cd+lx58UPNHzO3/ImYz4Lj00SNC56TDXWQg8tdqn2ztI7TGy548LAsuWy5ZaigGk+vdq1cHZ/9O8r2SgBZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R3QzpMd/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso272322a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741173474; x=1741778274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5Za3WdMVvxWz3492jYv2JlXl0TBbBgskHE33VDHckU=;
        b=R3QzpMd/5dJUQ3p3m+46sCd0tmZ4H8OlYTmIa+43QaZUXJSSrVDAqhxEARnGWBLaph
         0XvflDIvrWIHiHBpeZjh2KNVFvtCIScuy1f8mb9YcLRdeZZ7PSMcDmtpQIgWgmloRwK1
         KdDYIIJU0aqMCQQAYHR3zdYhYhs4bwLdMVlvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173474; x=1741778274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5Za3WdMVvxWz3492jYv2JlXl0TBbBgskHE33VDHckU=;
        b=vFRp06BJaUsm6oA8wyY+dzzLx33YRndvg/zeqXhOVE7ecMzteEOajBNawb9soE5KCM
         87KRt18MyZKWbmGj77clsnJR5pdNOKY34OwJicBECAwjuco2QLyt8Oz9cy0tY2QYxms2
         D9dxBjtiS+zEjFUQJMrYzzKsZZGz0HaoEKmZ7cU/VJoO/B2kvgEA8/MqBXd4Go5nL3UX
         emil6fVyKLE32zflIJ06NDgdBmyWEwHeDcvOvLCCqPasyBimzbDCUDpMXPQWJtrKzwdm
         wQpRrBCVFwrR+QqE7edOfVEWoOTLKucbd5lVOV1eWTmB+ixmP3rCAT12RB6nQUZJ8M/M
         /p2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyk1YfTI+zeDOxb3KMdxcZ947o9GOCtcm4ynwjNv3WuJRQlCU3EH6+AGl3Agao2GagQ4ye+qgpX5dxEg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvKMiBSh0mOuCJmYphxyej4wgxEpmg7Y5nAsLb8kpHKrvdfSl
	Hf18kvRRuqJ+Jl4NPxtNSD8KK7fdaqCUPSEgZBK2Mb+RH4pmKwHJ8PWmWyxh+gdCVmRyIqjsHBy
	Qdw==
X-Gm-Gg: ASbGncvxDAgi9Ys9eSPO0+xaSJDgmpOVdak4TVL/80gttngrlyaYWpg0FC3KpgVAfJ6
	MgB2EXCujq3QmcZfYXXnS46bl+S/DpXxY1F9Tdw/V48cUVEZ9a9RwdI7E1+9weeu5LxN2HrDiHP
	1s6yWAiLzOhzyf1hQwHSx5JC9uX9Yd2C8pML64bc6l3hCUzk9uFhwXxwCl2BKRa/dISebe9OH4J
	iDw5rrp4mmzrgipARH+ULGB+iOGoUziprZlITLECRHWpTfNhI2xWHXT9R1CT9bX5/OoLUCqGeCi
	kZH4dsBw7FZ05RvrBYCSKK4kkrPEFn7u3YAWkAmf+hcn2zJEKWgIY/7flPlZPdlsCLdptz3sIlc
	W+PcQsTbPqHILq5mCqE9S+bYAYD6B1oRyvX4=
X-Google-Smtp-Source: AGHT+IEqyW5X4ASwkw6LFXhgxDPUVU1GXyMLlS7feXUfmf2zFsVab6nnqWKmqGmgg4CjQS89d0mm5g==
X-Received: by 2002:a17:907:3da7:b0:ac0:4364:4091 with SMTP id a640c23a62f3a-ac20d844166mr259084666b.9.1741173474306;
        Wed, 05 Mar 2025 03:17:54 -0800 (PST)
Received: from akuchynski.c.googlers.com.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac21e902cddsm35907966b.113.2025.03.05.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:17:52 -0800 (PST)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] usb: typec: ucsi: Fix NULL pointer access
Date: Wed,  5 Mar 2025 11:17:39 +0000
Message-ID: <20250305111739.1489003-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250305111739.1489003-1-akuchynski@chromium.org>
References: <20250305111739.1489003-1-akuchynski@chromium.org>
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

Cc: stable@vger.kernel.org
Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
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
2.49.0.rc0.332.g42c0ae87b1-goog


