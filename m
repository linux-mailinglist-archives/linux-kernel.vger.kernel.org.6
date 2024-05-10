Return-Path: <linux-kernel+bounces-176117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC48C2A14
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE611F2277F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082524CB4E;
	Fri, 10 May 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVGADxvI"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C8487B6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366626; cv=none; b=NnLjfdRDCQJomywxntx/ng6W9Lol/nxZQ1DXaC3DEm5KLEFtQZEzazxhqYOFxEXbD5nmV9UmtTXlOmyEdtKfgAxif4ViQEVQ/ZCkDHQyfCe6I/uZ1BkyfWIyc/SraC/s22XxDwnvPzVV9xUrhikhS9aoxLxyLBNyFGfrXUZ5YG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366626; c=relaxed/simple;
	bh=5Dxt8M/uMnrYaCujm6SYe3p0Nct6vbEeAdJLQT8qgX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p76alnaEfpA/HR6kmywmUSYhL7f/Bnl313ckOvb2rqkRfHRWkV+E58b/V3/JP0/NZ98h1u4jcsWyOYrdQcFdR0Pk1R4UOGNI3VOnjUOSHVmgvFlJsK5w1stut+YxTuuM/9NtR3y2vUh1ctfcAmQbh3iK/KNaSOV/75yP6oYz3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVGADxvI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-620a2321b0fso30877917b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715366624; x=1715971424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibv/f3Jsw2CQCASuGotHQItld+LQXS/bJ8cmbunskpI=;
        b=BVGADxvIsseFytloloa6J8ZK/n6MXRxCP3qoLi7FVIbuxg5FCrSc4u+Z32RmEqeujL
         C/cx4acpAE93nY41Nb3SqOAKTfyjZFQ/DsTxYaoGGhkYPLIvf917udWjPZM/6F69YlF3
         f5HArZZXzjJoNwEAdZhNWTpqbb1UNQlQunPJ74Y7pzsN0F92hi7PVvYTtbNnJQq+Oh7O
         MtLmEvHgWH9LrjeVVK9m1j+jseFa5kKmuapNBS8yNM6JqAjkmuTj4xEOkKKuE/NoW6Dy
         T2e0WEwODDquHxxrtnzYzEMrkdVjomt3RKVd1ZRR1F59no1z1BHbmXeOzHoNa/a0OYNU
         emQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715366624; x=1715971424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibv/f3Jsw2CQCASuGotHQItld+LQXS/bJ8cmbunskpI=;
        b=Ael/deWePa9LZ3ioyHQI8QaBkkpV+Ocmrf0WHn9fDyIg1dWzSynBvJpeZatH2wMUy8
         QFqdoUJpWZ22lP383FvcJeBRbCVO8nOnulCBRjdqOUImSMlDzeVNiRj8rfK9X07obeN2
         zDBNplPeo6kIxbJ2rP7rVVChW6EYaLE3ZnHfWjSbqdXyQjhZUhUE83Tsnb5jpQl/ar1u
         OTaL6PeDP4P0ZGk0+pQjHeWiAll0ZhKOEci+EwpZbqUsAi2UdBz6DVN4ICO1KhX36tsf
         OQ92UFitq13taXUlp26Spm55UnWEY/FMGcmKbqnCzB4cpkkKux5gFw/iLiBvWkxPilct
         lQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2uB4lWkug5tN3V5Qh76937J4EFezRsJDjsTCA+OjiweXn3mj/RD9qXwJJIvQX+UlkbM+JRcpNWGq123lds3VCdJeUpqDKvQkyXonY
X-Gm-Message-State: AOJu0YyYLqPtoe3q5PPfKqnfMfbcNX72GYhUD8OaFRS8MCPPy3x+hVzS
	DiJrM40ORhN3KK0II+2CbX9g3CK26TWVDP5eHoY96LThyk36lSlqhUTQqcAWRcT3wLKmQAHRO4u
	5Vg==
X-Google-Smtp-Source: AGHT+IGDfBKNUEYIqbIlS5Fkvoe+iha8Qx5p07lHU3gwnZ3n5tfA9OQISwkzlfUYlssG+VExqcdQVtPLK4A=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:6c0e:b0:61b:ec22:8666 with SMTP id
 00721157ae682-622afd96b2fmr7843577b3.0.1715366623917; Fri, 10 May 2024
 11:43:43 -0700 (PDT)
Date: Fri, 10 May 2024 18:43:23 +0000
In-Reply-To: <20240510184324.2944101-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510184324.2944101-1-jthies@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510184324.2944101-4-jthies@google.com>
Subject: [PATCH v4 3/4] usb: typec: ucsi: Delay alternate mode discovery
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Delay the ucsi_check_altmodes task to be inline with surrounding partner
tasks. This allows partner, cable and identity discovery to complete
before alternate mode registration. With that order, alternate mode
discovery can be used to indicate the ucsi driver has completed
discovery.

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

 drivers/usb/typec/ucsi/ucsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cb52e7b0a2c5c..bb6e57064513d 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -963,7 +963,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 		con->rdo = con->status.request_data_obj;
 		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
 		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
-		ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
+		ucsi_partner_task(con, ucsi_check_altmodes, 30, HZ);
 		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
@@ -1247,7 +1247,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	}
 
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
-		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
+		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
 
 out_unlock:
 	mutex_unlock(&con->lock);
-- 
2.45.0.118.g7fe29c98d7-goog


