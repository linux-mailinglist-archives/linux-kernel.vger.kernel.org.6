Return-Path: <linux-kernel+bounces-366534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE8099F6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBE61C23048
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F731FF020;
	Tue, 15 Oct 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="L9w6FP2c"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD21FE101
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019443; cv=none; b=sAA4wQeFB0g7Mbmv+zJwSz0Z9G/COehPB98OMXL0777A7WMtq1nF51PuF0WV3lf9xijMXwTLXlyPWiu0sDqurxnZW7Tz4jrF5pJv3y8i1Zhcan1MO8OrCsb/4pprV/aVVN8GFqxtjP2Gav2/skVjm3QHfS7z10rayWxrN2/u9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019443; c=relaxed/simple;
	bh=vy7V4NIrdMOyXq6KgHzCKDSyegF8v/naaLxh0AwU07c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6OiL5z0t36apqwZFoZAItqe2aGnmpMDmkq1HeD0JJOrAHA+jhkkQQEvP8DoYbLhmvay/zoswAR3T+pMfEbXVAHUgXTr4qccNm1K//y9c5dQLuoW2GH82x6NjjZ21lX3PoKYCGbY/Ijw/6xwPBJDqtavGTXEXaaNIOz8ZuRDumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=L9w6FP2c; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFp2kgtzlgMW8;
	Tue, 15 Oct 2024 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019436; x=1731611437; bh=vy7V4
	NIrdMOyXq6KgHzCKDSyegF8v/naaLxh0AwU07c=; b=L9w6FP2cLH2zMTGEMCp1X
	caI8PwV+IabJYW84fXYV6hR8q5wMSNekOSSXd0RhDfGXl7CAoqGy9Oy0l3LHT8rN
	6p3xSCyuQdeOT9lygCnM6YMsHxcAYEVuOlvDYk1do7tAmxBARLXWCIJ2U6wE6lyd
	L1J7nEY8A0fW0T7R6FMlTgSPPIwviGhQhereAefU84/s2khIoVgRBZigQyozF2Hk
	5k3toF19pz7SsgPVbn4Z/vZLharf0x7xTTV3rhhF1uEBOmIx5F87lCGYpRGg0B8J
	kDN6oBnJdklllji0bgr+lacCL3Sf0gn3+TqKlPquHjZMsvoYWZRVIyXZ7WtspkBG
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xV7KS3PWQd8N; Tue, 15 Oct 2024 19:10:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFl08d3zlgMW0;
	Tue, 15 Oct 2024 19:10:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Juergen E. Fischer" <fischer@norbit.de>
Subject: [PATCH v3 11/22] scsi: aha152x: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:42 -0700
Message-ID: <20241015190953.1266194-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241015190953.1266194-1-bvanassche@acm.org>
References: <20241015190953.1266194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

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

