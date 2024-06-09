Return-Path: <linux-kernel+bounces-207521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF00B901859
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 23:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177482810DB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 21:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7523F524B4;
	Sun,  9 Jun 2024 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="XImHj7o6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFv/hOoE"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521C48CE0;
	Sun,  9 Jun 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717969428; cv=none; b=ZQfmafBYp+kwy7sPWs1BII89Y+D2nQ8tYQHUxEZMZgMEWYy5dLNSE1rf8vid440D1M0SwrwpSEt5/gLb+CReVj2FbXTFeEf76/osT/3vety68JrAxDrLYZdOywGOX6oJbzLL+N8k4JU/69l5rBACe9easXv8YbJ92YwRI3ZyfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717969428; c=relaxed/simple;
	bh=HJgurrWiX7eXP4/IiNcGUcXHq8B7HVmDJ3Xbz7REcyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYbhZCZfx9BEoEokDJ4C83jjUmUFEeocNZ93R1w0f/J0i8F5T9k+EyEr7V3UDUl733pkc5Qdj7Guujjt7no6/91IETw/ey1zz8Zd5C/hu8KzTw/i7ZPPms/W24AOQw8IJVLBtSonijEbzxXK4dLr/wrsqeKNqPzs9llZl1HbEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=XImHj7o6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFv/hOoE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0147913800C2;
	Sun,  9 Jun 2024 17:43:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 09 Jun 2024 17:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1717969424; x=
	1718055824; bh=fGXoDc5UQ7R92D0+Vz5I/WElToagZBOZ6lR8JyKacWE=; b=X
	ImHj7o6OhXSA1D8wybapa2gE4lY/FttnqFiGnltyOvsho9nXXG2uooFMwOsnPqBy
	MB1/JwtctjTauXMWydtA8BTVxG634bd15zNGytG4kJ0bvSMv5MqI7pPLnEfqzeKr
	e8+y5knhXbfbnhp7n9erHcGeGWkzcbZ54uhKoBGVZr3VY+1JwRDcnd8b95+5JG8d
	K7vo3+/sb/9m9xOhOXdhC837Fhszt3vDFxnQTlBPWrgCUh3LnX9jnXprGp4XPRXQ
	YolsM51/bt+FVOleAt/f6Mm7Eu2LTWlExPoUfF9v8q5UIcVTX4LhTjxkAdAINokZ
	qHmWHpw1NWf/aDLFKgypw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717969424; x=
	1718055824; bh=fGXoDc5UQ7R92D0+Vz5I/WElToagZBOZ6lR8JyKacWE=; b=O
	Fv/hOoEMJbyIFtVcjPMCbMXCMCm4SCIlQu/bMnDJQ/2j6VjtU5iPvAUdid5ltmdR
	hSK06azb6ogDhYZCnQ1VHGgjzg76NIgILM61oFJz/Yi/kwfAEYFE1aUllWBYgVaw
	IrE+kT5lFzAwh2LqMCfaFd3VbIw29hR5uAwExlZu8uPsvNajRqzQIt9JOTX7+cQV
	athT1KOKThpigCZQnQcZfN/lxF2Va1uZZk/vIZbpDLpajuUPyvQikUKrdOWgm8su
	CPTm5ZOPKBuahJNTBfwCaTsgIEIrroGIaOuT5lL+cljVBO6rjHfYXYX6InZKNals
	hlpfYJWcW2sCWEnnip7Kw==
X-ME-Sender: <xms:ECJmZvXJ2WMUi2o5Vppw2T2IjzyabY8cXmq6RLp-Zk_bP6TPMjM-1g>
    <xme:ECJmZnk3_xrOb9fhQ08yKzgRfur63HlgikXtLyIsE9Nlrc5Y31lAmtJUVo2Knc86V
    Kqkx6E8H3fs2rGzJyY>
X-ME-Received: <xmr:ECJmZrasbdMOKSTFRurHZqGhAhmrQvs0DqzunHbR6kJunYIk6TQHnTcKGdW1U-tL0vxXwN0ouJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:ECJmZqV5id-LmX3dEvCOtw14p1adApGTXy9BKe3ZulhgMFAheivLYQ>
    <xmx:ECJmZpnNMidT_gv0XCnPlwhVNrYtJGMK0Sk-SqmGBJVorJgeqVcE-w>
    <xmx:ECJmZnecSw1Du_aoOqkxose4tXoIwgclGfgI5CBaWb7TeLkytSP9sg>
    <xmx:ECJmZjEaFnqRX_VTUOJhBdjLTiZEJFS7HtBqwHmPFXnkqoBtYvmdzg>
    <xmx:ECJmZvWReU4NmGO7ltoJasA2W0GiIUMJwooYBJzhDp_RCJeETtSY5lbJ>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jun 2024 17:43:44 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: diogo.ivo@siemens.com,
	dmitry.baryshkov@linaro.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: don't retrieve PDOs if not supported
Date: Sun,  9 Jun 2024 17:43:18 -0400
Message-ID: <20240609214328.6580-1-mpearson-lenovo@squebb.ca>
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

Check if PDO_DETAILS are supported as a feature before attempting to
access PDO. If not supported return that zero PDOs are available.

Tested on Lenovo L14 G5 AMD and confirmed with Lenovo FW team that PDOs
are not supported on this platform.

Suggested-by: Diogo Ivo <diogo.ivo@siemens.com>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Note this patch replaces my previous submission 'treat get_pdos not supported
condition as info instead of error', based on feedback from review.

 drivers/usb/typec/ucsi/ucsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cb52e7b0a2c5..cadea8d328ed 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -641,9 +641,13 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
 static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
 			 int is_partner, u32 *pdos)
 {
+	struct ucsi *ucsi = con->ucsi;
 	u8 num_pdos;
 	int ret;
 
+	if (!(ucsi->cap.features & UCSI_CAP_PDO_DETAILS))
+		return 0;
+
 	/* UCSI max payload means only getting at most 4 PDOs at a time */
 	ret = ucsi_read_pdos(con, role, is_partner, pdos, 0, UCSI_MAX_PDOS);
 	if (ret < 0)
-- 
2.45.1


