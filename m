Return-Path: <linux-kernel+bounces-201300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E48FBCB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F3528415D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B514B09C;
	Tue,  4 Jun 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="fji6YQ7O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqcUieXZ"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6645C1C;
	Tue,  4 Jun 2024 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530095; cv=none; b=gwUEydmZmYyrIqMfESK2kD44Yh5kNaNX0JThbtnY50ue8EchyT+7mQpszkp7+IsI7ESp6BGYwYtZNuqafoj04lPpTgIDzaikz06FpVI/KvogDp5LisgeOiJAisk9hhje56q387BLVZQBmDpazJYdNYdRE7GTcB6hlzAT/LAMuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530095; c=relaxed/simple;
	bh=cpBzf0bOW6D3PuiqMtlHVXbUX0LGNrVMf6maz1q6McM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFWskTt+jwfh60BkPetGsyofm+zhfsdIDX4r1oGJxL24/KuGz/QfT6eCfN1vrlfWgnJACdQnrxapUEUT4Ie+ja92eREQMQzbFOhX7LbQ88VshgDn85H8mFdBt4xSToAXndDcpOn5Ph7ZvJ4hVWzYJGQgTB49veDnCbuWGsbDi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=fji6YQ7O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqcUieXZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2D6BF114011F;
	Tue,  4 Jun 2024 15:41:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 15:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1717530091; x=
	1717616491; bh=gXKDVPqqf1TGYrQ6LIKhp12gZIkQFmy4CtG/jgGn/o0=; b=f
	ji6YQ7OIvrOJo/BN503HDWEicjDZ3Vk2jU1mruLa59XllPgSF4VP9P7MjAeCpa+R
	7EQEjk76hq3DpFIxGhjrCiLI9uGf2KIUEjMan3XFMYk5J53sJ25ITAdZE9MBVpbf
	AVfv/wVeA9M2Rhxsp8CyjS8ZdmRFmLCsKNvHF7G86q9AEa0wKSYzBPFysi7dMlwq
	qHV+CuTu11S894N37UVWH8zrYVfDm7ZVTuwHNQ4tohqhaBNb4CkESEG/3sf+IfiJ
	iZGfnqbC/joZlRLrp+hK/uS2aTVFcVjNDLa1IrHVtqnRCJ8xzP5+xbDLYl6DLHOP
	7cGlaOvhD+Dnci/uzDeZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717530091; x=
	1717616491; bh=gXKDVPqqf1TGYrQ6LIKhp12gZIkQFmy4CtG/jgGn/o0=; b=U
	qcUieXZrMpVrorQA669EEDh+S+w5MmqMf74TOft4pqpgQtgv3jS+bEJIbvV6dGCd
	9dijEDDcVtqq7FgVAEkPXYmbdxW7wPpfCk6LXd+Tu6CmlCX+ipIxbPYkANrOJK/0
	beLfCKWpPlpAsHB80nzWUNYhYfRxsrEsNxC0OtugyUCFtGfqPsDUqjWsYVVZu0hu
	E7WeeFIsv0Ke2LMc9XeaO4eWq771auKeSQtKxZn8kJdKgpPLN4SiUq2q74npJNhw
	cbMhJqudSwModWIgPYKiN8L/5XUKi7LYY3D3Bml7kQ6ypFAySZQRDAKpHwEjxZkx
	I5xnoaGG/cFIloWyUaddw==
X-ME-Sender: <xms:6m1fZuDtjzgUJ0xYu_4BncjSBLw1aJ-63x-BudQsE5P6kA6p_Kn0Cg>
    <xme:6m1fZoikdTcUkLkTjstl0bGrX2dZ9wWIfoOq_2c-9b5_ypsNGQ0F5SWvBpSpWLJ2V
    MtXOrWKiGBj6Wl_9Dc>
X-ME-Received: <xmr:6m1fZhmWqeOyB589LFvmp5etnqHqU0vvjbGHmND54an5tJh4DeChwxfzkOpY-pWFw-JVNf3znKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:6m1fZszK_p2PLBqh-Xp9KRsKO-tQGrr91pPJ3hxWnvlnw3Y6tl6akg>
    <xmx:6m1fZjRlA0gBBgo_9mAsNFCKyGdpd5veyGI4XWvq9kKFnOSOoRP-TA>
    <xmx:6m1fZnZrNZvGj8aIzFiS2IaOqQE6Cv-FWjT78n5bJIInTgVTwu7iUQ>
    <xmx:6m1fZsRWsOsUvTERA8pjnDBjvD78uR8rtk8P7rEJj_Wpu--Qze4W-Q>
    <xmx:621fZkICwjjyVckUMQvXN0g5uxwgNEcbd-Md378HtRlqEWRv1P-Ta_CT>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 15:41:30 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: treat get_pdos not supported condition as info instead of error
Date: Tue,  4 Jun 2024 15:40:44 -0400
Message-ID: <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems where the UCSI PDOs are not supported, the UCSI driver is
giving an error message. This can cause users to believe there is a HW
issue with their system when in fact it is working as designed.

Downgrade message to dev_info for EOPNOTSUPP condition.

Tested on Lenovo L14 G5 AMD and confirmed with Lenovo FW team that PDOs
are not supported on this platform.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/usb/typec/ucsi/ucsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cb52e7b0a2c5..090be87d5485 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -632,8 +632,12 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
 	command |= is_source(role) ? UCSI_GET_PDOS_SRC_PDOS : 0;
 	ret = ucsi_send_command(ucsi, command, pdos + offset,
 				num_pdos * sizeof(u32));
-	if (ret < 0 && ret != -ETIMEDOUT)
-		dev_err(ucsi->dev, "UCSI_GET_PDOS failed (%d)\n", ret);
+	if (ret < 0 && ret != -ETIMEDOUT) {
+		if (ret == -EOPNOTSUPP)
+			dev_info(ucsi->dev, "UCSI_GET_PDOS not supported on this hardware\n");
+		else
+			dev_err(ucsi->dev, "UCSI_GET_PDOS failed (%d)\n", ret);
+	}
 
 	return ret;
 }
-- 
2.45.1


