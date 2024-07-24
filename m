Return-Path: <linux-kernel+bounces-261478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93493B7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFBC1C24086
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3911A16EBE2;
	Wed, 24 Jul 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhNOSj4d"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8A16DC0B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851943; cv=none; b=Hjtu+LxjLyngoawRpI9yLRZcBn7uqZTfJvYGB3dBXIcx/6qiu/FCcyjWaLbUCiq/yH9oZ0/eAwTbgoM+kPoCyPw4dKOZXxhoWgz+Ha9huFVNQkRCjC0OyKV//Yt59vqHTBHPcgzxx0WZj6nOGRyxc4aOoTsx0JCx7AMFAcm9lpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851943; c=relaxed/simple;
	bh=h58HLHCNa0YzrY3VJan8w1y3GHAehkiK7wZWPvDTkMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oNzab7zK+26OQc8XqV8bwKl3ZZcmnoNGBdHO2ClItSbct5xXPlQLmn1c2wuckERpEqZcBejGRtYAapANgwuCgS/NqHzwoPNWWnUZm3+eAwQnM/Oeynx/5ic9QNKLIZlMCNRcQRN1ynUhiYSaj0/JwXQ3ryO/mmOd6AmPbvcvI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhNOSj4d; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-76522d1dca5so217922a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721851941; x=1722456741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLze0kadUGbSBXCo4aky2nkQ49F0HsvXX1UCI/WKp1o=;
        b=xhNOSj4dCcUemx9vY6CORPziQOytusxE3o8zPAUWwMUJRpsLuKijbO7SErJCK2mf3J
         GidKKkAdOlaNDdgzNV/1SvFtZk9rRzGjajxiwJ2FfQgjsHd5ptLe5Zx0YpKmoKL5Tp8G
         flPdnGeKAXLFqzdmxHJ1TEypvTpN2PMYm5eOBcQ1tCXvhSxTjp9hcrgZCP8YeXJRTSgL
         wOyYltN4YOKiBKhh85QVAh8tbxVUZW+vcjGK7DM1fnQD1HI1af5dmU54YpCPz/vaiF5q
         ewIrD+u8FQGN6EGDZswwD1K7LpCy99MSresZ7U6IcUzxVRjfxqWy54xxdYWjnpEzmfya
         jszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721851941; x=1722456741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLze0kadUGbSBXCo4aky2nkQ49F0HsvXX1UCI/WKp1o=;
        b=ltlrX6my1KNjHAIW+ZmFEnvIJe58/2z3LuRT6zy6yenP8JrT0/XJRNvb3Swopcgb1a
         CRJVXCkE0HdSiNDyP5hfJhVSleK0cCDPgcT4kFKpW6t7cB161SVzW0GST3jeqCgluTtX
         0lto+3/6XZqHL8JAk9DSS9oUqC85XPVc858huQtcKOv0WonsnClEVULyh4CCvbOivZbD
         Wg3vRvw7EKjhLaOHIY4KPx5jylcXXFJJ4RtfJ5dLy/ahiHmx2/6x/huBcU/Jdxphmm4m
         mWhFdiAq5YgCOqtct08EmJj2RvcI4CezrETpUy9KzGvXkNy+Og5ZsJ7Ewk4L9y0ig2PF
         v8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWMwdw7awbN1evLf3kXmxx8UKpz99IqoVCbYLDa7ajk/rTtZSrMw7aHnGe0Glj0I5xTio9gcu6wVYrhXj71T3nK9vvzqVsW4Lj3W1Xb
X-Gm-Message-State: AOJu0Yw1jJ5R7gbn8KYEufuoyemTOAnjCbIU/8qsna6iefkQ21+X4S7w
	mxD5Ah6gVWyMWJREgKtstRkC/u1Fk+Ysd4vKmMLpWUTT47g3/nW/qaeYvECzqwUyu3mFwI/HKa5
	BYA==
X-Google-Smtp-Source: AGHT+IGQUzfvNQ0VfRVxY9FJGcd61WeAx5N6cNXLQohbC81lMBoH10RygYZERrbbZNtHojNKZX6YHzJxc9o=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a17:902:f693:b0:1fe:1a92:5b2 with SMTP id
 d9443c01a7336-1fed3051a17mr16985ad.1.1721851941169; Wed, 24 Jul 2024 13:12:21
 -0700 (PDT)
Date: Wed, 24 Jul 2024 20:11:14 +0000
In-Reply-To: <20240724201116.2094059-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724201116.2094059-1-jthies@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724201116.2094059-3-jthies@google.com>
Subject: [PATCH v2 2/4] usb: typec: ucsi: Add USB PD DRP to USB type
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add POWER_SUPPLY_USB_TYPE_PD_DRP as a USB type in the UCSI power supply
driver. The DRP type is set when the partner sets the DRP bit in one of
the source PDOs.

Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in V2:
- Using DRP bit of source PDOs to determine USB type. Updated commit
message.

 drivers/usb/typec/ucsi/psy.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index d0b52cee41d2..d708f9eb1654 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -204,8 +204,17 @@ static int ucsi_psy_get_usb_type(struct ucsi_connector *con,
 
 	val->intval = POWER_SUPPLY_USB_TYPE_C;
 	if (flags & UCSI_CONSTAT_CONNECTED &&
-	    UCSI_CONSTAT_PWR_OPMODE(flags) == UCSI_CONSTAT_PWR_OPMODE_PD)
+	    UCSI_CONSTAT_PWR_OPMODE(flags) == UCSI_CONSTAT_PWR_OPMODE_PD) {
+		for (int i = 0; i < con->num_pdos; i++) {
+			if (pdo_type(con->src_pdos[i]) == PDO_TYPE_FIXED &&
+			    con->src_pdos[i] & PDO_FIXED_DUAL_ROLE) {
+				val->intval = POWER_SUPPLY_USB_TYPE_PD_DRP;
+				return 0;
+			}
+		}
+
 		val->intval = POWER_SUPPLY_USB_TYPE_PD;
+	}
 
 	return 0;
 }
@@ -275,6 +284,7 @@ static enum power_supply_usb_type ucsi_psy_usb_types[] = {
 	POWER_SUPPLY_USB_TYPE_C,
 	POWER_SUPPLY_USB_TYPE_PD,
 	POWER_SUPPLY_USB_TYPE_PD_PPS,
+	POWER_SUPPLY_USB_TYPE_PD_DRP,
 };
 
 int ucsi_register_port_psy(struct ucsi_connector *con)
-- 
2.45.2.1089.g2a221341d9-goog


