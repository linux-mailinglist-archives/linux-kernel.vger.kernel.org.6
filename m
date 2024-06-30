Return-Path: <linux-kernel+bounces-235398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3FD91D49A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA2B1C20B43
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F78415FA71;
	Sun, 30 Jun 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="saepFWW8"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABA1527BB
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786775; cv=none; b=rO54jVffEfwGpURETp6qUVCJPnyBnLnK9zoV/DsL+AeGnyO8M/uYaKWZXVLsicGW/MnYvcjb2fmWVhm8JiTp6irdguq0BLQ/W+FZxvWqQrxYSiN7xgVCB5BStUB81HfxmM6k2wDzKIa14k0KdVi/0P366Gbmr/5/V6/08lDM7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786775; c=relaxed/simple;
	bh=GQtamdc865dWGQq43UxMEnK6DMqDUf4s9VSg+IZzUd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEx+CmVRhQ/dYNFVthxIug1ZWbRFA+cFXl3L/wkTBkW6GagQe/QoK1mQIjp7/+NCTCBwM1Ursf/hDJwjuwwkdoEW29BUA7VAoQVq3r0sYFpY1A8IHUYXUS2FTNEB7swUC0YZwpcpD0BWSCBFbQM6FSWj1UiLvjFptr7tW+vpnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=saepFWW8; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3pY2Hclzll9fM;
	Sun, 30 Jun 2024 22:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786770; x=1722378771; bh=mq3SJ
	L+opWIPTpSEvvg4HW9BnuQCBIk2w44ZKHA9fVo=; b=saepFWW84znIFUQZrY7Im
	4m+l2u8f4Hvec0TbA/kUwk+T2h0t97FTwI9D6bRtM4ya764qt+ruVUl1P+73GIzn
	wuCrVgyEcJ5KcQCySpHqNzuNivDJzjsOFAdKtQA7tRw8fRbVFvqRmhLab7UgcAoz
	f1skEPnCkmVpBBzFYQ9DsWsrpAxqrWxyRze+CyPAVE44hfsRoTYgOPzStmkJrgsX
	3IXnA5yXJkghRJkDmnLJ0w8lsS5w55YwyBNIj8CxXNnKueG/2PGRblX8WwUT/q9W
	lzYWDehE0/dCkrAEPLAx9DddETzln97XwjZnemO7eP27w0oyWg/XL4TGMOTlRAKT
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id A_XAnG5OdfXD; Sun, 30 Jun 2024 22:32:50 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3pQ4Kdhzll9fH;
	Sun, 30 Jun 2024 22:32:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH 49/53] usb: typec: ucsi: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:27:07 -0700
Message-ID: <20240630222904.627462-50-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240630222904.627462-1-bvanassche@acm.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a format string to create*_workqueue2() instead of formatting the
workqueue name before create*_workqueue() is called.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.=
c
index 2cc7aedd490f..2209f45c2b9a 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1504,15 +1504,10 @@ static int ucsi_register_port(struct ucsi *ucsi, =
struct ucsi_connector *con)
 	enum typec_accessory *accessory =3D cap->accessory;
 	enum usb_role u_role =3D USB_ROLE_NONE;
 	u64 command;
-	char *name;
 	int ret;
=20
-	name =3D kasprintf(GFP_KERNEL, "%s-con%d", dev_name(ucsi->dev), con->nu=
m);
-	if (!name)
-		return -ENOMEM;
-
-	con->wq =3D create_singlethread_workqueue(name);
-	kfree(name);
+	con->wq =3D create_singlethread_workqueue2("%s-con%d",
+						 dev_name(ucsi->dev), con->num);
 	if (!con->wq)
 		return -ENOMEM;
=20

