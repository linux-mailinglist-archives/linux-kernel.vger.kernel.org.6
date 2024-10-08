Return-Path: <linux-kernel+bounces-355892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB5995866
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C551C21625
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E43218D87;
	Tue,  8 Oct 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3nL5np8H"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B182185B8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419197; cv=none; b=RlHJPFnIMjv9LI85r/4sMkUi9R4gQVSyA9X6CZE0fyqMaA0bvqGy/2ia57wydhwYSLoS3h0SWbweAR3zuV+j8iRDOQK8cVBOk9fKlTdrsdtRDAdAe1nobg3NQP/hkFZZhekzFTR0gox+rpu73yHEdR49KwsIjdKNsJLuMWh1JeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419197; c=relaxed/simple;
	bh=wbyhHh/fNrwvxkXQyCwz4oT17PgEMPM3u9oMoptGZ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh4yvke2VhLZwo01L9gKyoixYJ+7tf5EwZH+1WZc69dowxX4x0bOWKY4W32LBCaFHh9NGdVLnWZ7vOUrBbkGSF5/0IBi/lxs2dHXBUjKtuygr/jDJjgF/uobhjicwB0tssIOEZo/TA5p/Y6tJLGpVTQKvoEfikhJuqaMfkaOZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3nL5np8H; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGZ1QLdz6ClY9n;
	Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419187; x=1731011188; bh=wbyhH
	h/fNrwvxkXQyCwz4oT17PgEMPM3u9oMoptGZ2k=; b=3nL5np8H6eOrY3thn4QW9
	Ps5yYV+XpNx5mXgLi6x4IEQLDOioxoK5ttT3hSPeh5ZggfOe9ODFFQx71AfqvG3V
	SGtAgyXRH60pJnaEbvn++/mRnehlVzcm5bw8iNT0EFgtEE8M1aCi0++5rHCKTtFp
	IFt8zCsBaD7T6AiBbgjAaDq+f3tKeB22S41Rl3hal4+hvYaglhikmgIOdqUrQDJB
	q6CuHWnp1NsPlzcfNZtYDg99gKdxMXi6Q/2/shS9w6Wm9DxCaa8iCp5xW8s5Xxal
	9S3vGz4DKGUBPZvLmQnYrPW0Tep6bJEE0iS9sRulGTTgDZaoP0YKKR7DZlLYMozD
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9v2TV9QYxm02; Tue,  8 Oct 2024 20:26:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGW1X3Fz6ClY9Q;
	Tue,  8 Oct 2024 20:26:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Juergen E. Fischer" <fischer@norbit.de>
Subject: [PATCH v2 11/22] scsi: aha152x: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:50 -0700
Message-ID: <20241008202601.3737326-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008202601.3737326-1-bvanassche@acm.org>
References: <20241008202601.3737326-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: Juergen E. Fischer <fischer@norbit.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/aha152x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index a0fb330b8df5..4276f868cd91 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -295,7 +295,7 @@ CMD_INC_RESID(struct scsi_cmnd *cmd, int inc)
 #else
 #define IRQ_MIN 9
 #if defined(__PPC)
-#define IRQ_MAX (nr_irqs-1)
+#define IRQ_MAX (irq_get_nr_irqs()-1)
 #else
 #define IRQ_MAX 12
 #endif

