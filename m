Return-Path: <linux-kernel+bounces-355901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565599586F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43DAB242F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E4121B447;
	Tue,  8 Oct 2024 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SXCedmiw"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EC21A711
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419205; cv=none; b=kHJ1Ix20u0Fc4Al2ExXnF7eNhALiQ7itk4wi2CWZLWfT6ujaOLOYmrXArnmFcZHUybVqU0igt/cNU/QZEjMNRbq9fh6pb4trmVs1/9hFMC/e2Re6UVB7FTr5wqhMZ3cHREQ/4lo2DdsTDSSVJQqN4EB6sbvIdP8kcD7PzsYdbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419205; c=relaxed/simple;
	bh=1I46L2ZZyE7z1LPEWtTa6y4lX4+EFDjuB6l0WCN6EhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRL0FE79iyWzNcvcvIPVHGMjHuOt2UvGDDUrkbkJ2PcUZcFXNpokMG1WfF3GmmnNjeaINy9QJ8eqMO1oAWYkCqWvmoW+pOcnydvr1MFirZoAlrG4zjv+aRWPlPpuHjlOm8H/tMEAx9cw0YMXm4Ks9fOn1XGx+qKX6E2WIARGoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SXCedmiw; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGg0d92z6ClY9g;
	Tue,  8 Oct 2024 20:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419192; x=1731011193; bh=p/O8K
	kaCx16EereU29CzMz00CvS4k4wZmCMmGDGS+QM=; b=SXCedmiwRKg0oKp4JfUb/
	YEB0Kgl7Z1Z+LzF1iYDTKWafeOWqe4P/HLMJpLRcz33URp5X/DIqo5fFXkMVq0Od
	B79l5QMFfz9t8b9yq4MZczXtm4+OrB3wkKZLg6rBlUSTq10xcdPgSxjlumbs1iOC
	1pzoz8D+bxwxguH9HXV+I0GyfIBevXjb5yvaHPj3lvKkfwbmmskigIy1AmIsWjmQ
	5TGBh2eORVWrxoG2WkNx/CmipBAt0Q05lc3aOBvvIzxPbEPu1zXsZ7rURxriTERN
	qnGUMPyuGKO9VEDrKTTN1nf5JgDYQHlgN+gjyYJjrz1G/sclBVLf0BlMLGIsnVTc
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id a-M-XagxgGK0; Tue,  8 Oct 2024 20:26:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGb6Lwcz6ClY9L;
	Tue,  8 Oct 2024 20:26:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 19/22] xen/events: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:58 -0700
Message-ID: <20241008202601.3737326-20-bvanassche@acm.org>
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

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/xen/events/events_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events=
_base.c
index 81effbd53dc5..985e155ebe4b 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -411,7 +411,7 @@ static evtchn_port_t evtchn_from_irq(unsigned int irq=
)
 {
 	const struct irq_info *info =3D NULL;
=20
-	if (likely(irq < nr_irqs))
+	if (likely(irq < irq_get_nr_irqs()))
 		info =3D info_for_irq(irq);
 	if (!info)
 		return 0;

