Return-Path: <linux-kernel+bounces-344602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DA98ABD3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9EA1C225E5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83819ABDC;
	Mon, 30 Sep 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="VlIqTFXc"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B99199FD7
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720203; cv=none; b=q9sSHfbgHdWGmKo4duaJ5SWKCwkUgm4s2DCFj5BPkMjZJPpR7tAAYhylszdzKtqzLA/7NU0WcOG6aOHWTsbCy8ozgRGp73vEX7k+/ETPNo9isxO2ZOna0w78KoTWuixXpAi7QE1IuGtJjLeNejZHQTCXwsQ0XidjeERBG3hucPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720203; c=relaxed/simple;
	bh=wMkbPdQERDjq/9DrfYoNkRWi79b/YzuNtyjQwTcPYPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COjFptHBZvt1UYMK2HqIeVvXLJ5qlIb0UPzgERH6V74X1UpRw8u2oiJiJROwqCkvbwTHaURd4NRAgxIhk802KSk7iEyHhmT4kGomZzDIzCEqluMJGFhEA9cq+KKRgnSddSZdQ0zXmRbjoKHlnJowg0kODG54kg7G+wNMxS5Ag9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=VlIqTFXc; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmK6SSMzlgMVv;
	Mon, 30 Sep 2024 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720191; x=1730312192; bh=nJnVm
	0N1UucQhw1NIaTwi873TC+brb/Qt9H6/kSM0Yw=; b=VlIqTFXcxp2HH3mntdvOX
	ChjC7bt/orV1GhKGCireddfFcibGpybu/ZXlFpF6Evm67SM/fKdkxhWnltNwOng9
	R+B6ltfRsJrjoLPAqiWke8f3qRn1GtdubuDjny3vP7ztv2eKkKwVCB39LBI3Km/v
	kgAWQK0EJL9SODxKMbKMn42Lt468HvhLgKf5RIA57HzMDDb+GvjvSOY6/lb0+mEs
	+Oen5n3PbblSWYw7UCzFw6RtYxDc2id2SeXD1w5Xd1QWZHGNWJEV8UO8Rp0Zwu7F
	xeqguJsThv6ETHnslh+p3raUdbcnYLZiiO1FjJUq6vjVyhI2Ya+t19qf6oacbP5C
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7EKzhqxwEy-s; Mon, 30 Sep 2024 18:16:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmG6lZwzlgMVp;
	Mon, 30 Sep 2024 18:16:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 07/21] hpet: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:46 -0700
Message-ID: <20240930181600.1684198-8-bvanassche@acm.org>
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

Cc: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index e904e476e49a..e618ae66587d 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -195,7 +195,7 @@ static void hpet_timer_set_irq(struct hpet_dev *devp)
 		v &=3D ~0xffff;
=20
 	for_each_set_bit(irq, &v, HPET_MAX_IRQ) {
-		if (irq >=3D nr_irqs) {
+		if (irq >=3D number_of_interrupts()) {
 			irq =3D HPET_MAX_IRQ;
 			break;
 		}

