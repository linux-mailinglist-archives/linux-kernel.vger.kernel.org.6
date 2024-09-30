Return-Path: <linux-kernel+bounces-344605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0138998ABD8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10B21F23AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6378C60;
	Mon, 30 Sep 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2RWEK/ss"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0919AD87
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720206; cv=none; b=ZlH9oloOpBqXqYbpVO2pkqQ3XrYYX+k+wPzdwKbhC5MWWpMjBY3JyxTwxYs94MzEz30zmRtb82cnJIEoGxENOSTPFju+TSI91gqZXgwuSWayOfhzz89zdJalviW6LFIqSIlRgdMq7W4c2DzPuAI6IjP6XFdAIQhluf29579KTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720206; c=relaxed/simple;
	bh=QTc3MD/ym+hbbckp2F+4jL317BCb24PmYXDCOA7O8vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMVUd30CCQtaMI+bqs3Tgz4ppSVeNPu986oLQXXnSyjvpQy3TfxrF+2txx7SifZbxZ6ttVhcmyqEFzj6k58u+1NofW4wcRcdEQEAmDBiaB9ZNn6lzJi1//ZkrGDCO3oKXrJYEEGTKF/eCumk96kj4OJ7wCXnQqsPiahNu1qcwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2RWEK/ss; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmM44vkzlgMVy;
	Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720193; x=1730312194; bh=QTc3M
	D/ym+hbbckp2F+4jL317BCb24PmYXDCOA7O8vk=; b=2RWEK/ssFhXruppZ7vdvW
	p9ZmZXA16d6qIEoOfZ8WMSdilsFdPvITkKrxXF08fEV09Crw33hWGWXdwFZVjfbQ
	9GYZjdwzSh8ynlaW7h6mlxMCrfj8zewZFM6ebruC1s9WQCRz15UDQMCz0Ee9B9WL
	TAWTJHM3jp8AdgbmiBo/v1Vl9vF+Z07cu3Nv9i0ygFJPZOo2MVKDADyVJLsYh88R
	8noW9lhTBeLzTgjIkmEfIutnMlZZLaVY9QW8OP7pERqqW17lXnJy1AP4xDcqG49U
	GZpiTu2RNI5CeOA+0BnqESag1bXLTlVg2DN1SuUphEVzMS9B9CjOMn0ZMFdpNtYc
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TS-PCJvtT0LI; Mon, 30 Sep 2024 18:16:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmJ6cPMzlgMVj;
	Mon, 30 Sep 2024 18:16:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Juergen E. Fischer" <fischer@norbit.de>
Subject: [PATCH 10/21] scsi: aha152x: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:49 -0700
Message-ID: <20240930181600.1684198-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240930181600.1684198-1-bvanassche@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the number_of_interrupts() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: Juergen E. Fischer <fischer@norbit.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/aha152x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index a0fb330b8df5..cc1456e049c4 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -295,7 +295,7 @@ CMD_INC_RESID(struct scsi_cmnd *cmd, int inc)
 #else
 #define IRQ_MIN 9
 #if defined(__PPC)
-#define IRQ_MAX (nr_irqs-1)
+#define IRQ_MAX (number_of_interrupts()-1)
 #else
 #define IRQ_MAX 12
 #endif

