Return-Path: <linux-kernel+bounces-254570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF4C9334D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D61C2262F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D26AAD;
	Wed, 17 Jul 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3Iz29rY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94D3C00
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177485; cv=none; b=BSYG4wv/n9G4I43spm6P/mcsp/6PtWDNDQoKoP5uWi5VsDuh3XURoLfYQeFZH67bRH6RaExr7JAFOpyYcT6L9CgF7Zlnyn9JGfIdcf9GI4U7bi28wxrrX2gn2QxuPlxMRgWaS1iUDHEOWOn+emKeiRDa3vs7J+dZ5MYkj1gnw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177485; c=relaxed/simple;
	bh=rtFrRQ4rFy9iHSqIJgEhQebrOvlDgtJBnPfjcOkYxIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPDLjS+wXWTbmumQ6hhYNXVYfk4yHtaLhycu/WbkPnsyPdjhawfYer2eVTYYGMqFrdDvAOn+IFOkvk85bfhqH048jDrvaSGiQczPRQFG+Ei5kqpyL7aDWAcW6dqR+rd7jHMk7jeIuNR5CGYHYEt2M1x0COi7F3Q4u6hzEGiWm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3Iz29rY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e036150efc6so10734820276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721177483; x=1721782283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZfO2IpnB7bc3YW/PTDqptNxNpOawD6JRjU0h2mR8Jg=;
        b=b3Iz29rYEG1T3ucw5yrRRO3ZZ9BlbBwUaCzS50QP2Ff2OTwc/ljrJShW+bvIPyF5+v
         Xjz8koT9uQ6VBJzA5zLw/YNQ9GYGT5yStvWrBlu2SQb6xFJPntPTVi8eaOTPgUac5/AC
         N7p20o3EycGCoYYuGTchdzFBMuzdIV4dldsg+Ib9GFdJuY6VmqiwXN0ABTFmIJ6efpjm
         PU6ijdOz326eaPNCRbvp2ZVxD58KhQ+1y22N2vod89gr0jrtLuopx/pBM+gzD2Xg/ulF
         P44wXEz7KYY1NB3KUzkBn9G+HNKDH2Wm0uhH43qWDu/R4Bqyb6A0BydwzyBCpOjD8Bxv
         BGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721177483; x=1721782283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZfO2IpnB7bc3YW/PTDqptNxNpOawD6JRjU0h2mR8Jg=;
        b=U+8Q5t9RRWboDOJt65CmNdA6ZLUmLZJwKNWBgLC1UI8HW9OIC9lEhRlLQcXBW+DljV
         8ZWVFwu+uxhZ0JHaERVKe+NaR9/EE5kKfMxpJ7DQPWf2AUcdSvc1/cOZQsistt0HxZnN
         UOAdupopkLc3YTVDRBoBjU9Ba40TOh2NHkSUuS++wI4XQPBj4bjA63w4XBxWwRrhYXtu
         HeCwTalQv7Mr136dRkIFyV7yJq9/NSOGiStb3QOfGxgfe4Y0CqNr62uCWhUPeWzTrFuG
         7asIEQy0gZK6F+Fdn9hiQdIi3QaIfYEj8p4ff5ypl5sE/tB+Zr0ZSGk8L4o3TNY4WWKc
         Q17g==
X-Forwarded-Encrypted: i=1; AJvYcCVb/vdLoAm/0gSf6DHstIw0wMvDeamR+LRaH6To7mEwBi9LRZ9mJtNg8hCJe1D5bwZcwJt43xNTWJsmBuKx7ZuIzWcUXWEG+TruFSnd
X-Gm-Message-State: AOJu0YzwRIPvL5Wz2vC0lr55AQNCItbj3jiGsdhnRz11pDa+hakadcbA
	MNbNE5niwgNWQgcInSNhnsIshg/Ic0wFRYtf1WXcI5ypZ4g4Inb+kKO0/d68rWZ1pQm8q1YWElx
	qEw==
X-Google-Smtp-Source: AGHT+IHn69xVfaZrAZa13CCuMoUt0BnnEiwyRbQOQS68ztFEUUQVny+N76Q4ts71rDSaIim5mgpGHu6Hias=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:140a:b0:e03:5312:c053 with SMTP id
 3f1490d57ef6-e05ed6fdc1bmr322276.7.1721177483369; Tue, 16 Jul 2024 17:51:23
 -0700 (PDT)
Date: Wed, 17 Jul 2024 00:49:46 +0000
In-Reply-To: <20240717004949.3638557-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717004949.3638557-1-jthies@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240717004949.3638557-2-jthies@google.com>
Subject: [PATCH v1 1/4] usb: typec: ucsi: Add status to UCSI power supply driver
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add status to UCSI power supply driver properties based on the port's
connection and power direction states.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/psy.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index e623d80e177c..d0b52cee41d2 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
 };
 
 static int ucsi_psy_get_scope(struct ucsi_connector *con,
@@ -51,6 +52,20 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
 	return 0;
 }
 
+static int ucsi_psy_get_status(struct ucsi_connector *con,
+			       union power_supply_propval *val)
+{
+	val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
+		if ((con->status.flags & UCSI_CONSTAT_PWR_DIR) == TYPEC_SINK)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+	}
+
+	return 0;
+}
+
 static int ucsi_psy_get_online(struct ucsi_connector *con,
 			       union power_supply_propval *val)
 {
@@ -249,6 +264,8 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
 		return ucsi_psy_get_current_now(con, val);
 	case POWER_SUPPLY_PROP_SCOPE:
 		return ucsi_psy_get_scope(con, val);
+	case POWER_SUPPLY_PROP_STATUS:
+		return ucsi_psy_get_status(con, val);
 	default:
 		return -EINVAL;
 	}
-- 
2.45.2.1089.g2a221341d9-goog


