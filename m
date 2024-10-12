Return-Path: <linux-kernel+bounces-362654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA299B7BC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA911F21D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE111146599;
	Sat, 12 Oct 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="NZJBPV7m";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HtOgpLiW"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C9176AA5
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728776395; cv=none; b=idAj6QggCMZoSwZ/BryimY8fc/idfvwm9HYzBb/NAtnI47CgI9j4Lr9zTnu3AAV3ypYf/3BIYbWRudTUXLGwioPonpYabV5o6OWtUvdGIuuezkHc501tJDIqXNXAdiPmi+VcTsd1xs9mPLYR0FuxjMReMArzyPcdhrD3/ZmGJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728776395; c=relaxed/simple;
	bh=H3Lnaupza36I+QrDmwZmdZ7PyjVQkmDtBgaPmv+H5XE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZU5z2juJJLnGrhQo1raSw0J9p/dWAOI7aEInmdh+62qzPJmiQjNrNPkiOi+qiWZL+FRgMSo5rHQ28JNocEndmDVF38rEFJAAEvsdodSCnu1iSVuxuvVel7yeApshQLY7KxYCiQGjvL0jBh1b/V7tlWc7HKXSe9UzrMMh1qS0H1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=NZJBPV7m; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HtOgpLiW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
DKIM-Signature: a=rsa-sha256; b=NZJBPV7mg5dWPLyPo/SHMdk0+1Md7AIAD3+r29gMzQweWzMKobuj8bS+xWdMJCx6FeShwqYg47ohQe4/wvyjoYwubduM17IB22g7nsofz+Yn2Es0Lf+ChwKq57aY0w5Xv+7jiOjrRWYaTM45AP7y6+Fk2d2Wrtr+HbmHuuZLZzUMcsnkEMCMcfZEHIB958S+dEaZnKPoMN+DM5PMbS7dMwfsZB9TvVlp+NNlkJXsVQXoL+/dGlj2AqR8Hpy3/DlRxw5bzDKsE1FTESofWPvV42v5delgeZ7LscrdA1YSZ7R+TUwgOaYVxX6+4XG5V9NFAE7VJXKGzhmTTD3wid2qPQ==; s=purelymail3; d=lkcamp.dev; v=1; bh=H3Lnaupza36I+QrDmwZmdZ7PyjVQkmDtBgaPmv+H5XE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=HtOgpLiWlg84lG1QxedJu4uDAtqqMkov8TU6AQb4m13ojkZpKThNInARI1QOdkc84ilkwym02kt7oTD3/IDr18izLZqeSsc/p4P9hqkURvywnpZlW+lm7eXLOO0nMN5foT1JLPsOirM5QyHjz5axjv22xFmCO+vI3vIztOI2wDBNlqEGA25FOZJuZS4YgK1fSeqWnVCXHfUWv5tl8FVxsVh2VHj4EvP5FpIRPNyLPWaNW7Yk9GHZr7769q75wtHaIwh1Rb8chtd6S+ViEeS9W3506Wv4UvGtK1Ldzj5e1inA1HYs/23UIT4h1fcWilshDHKAYIZaMtjNgTLsLWpiFQ==; s=purelymail3; d=purelymail.com; v=1; bh=H3Lnaupza36I+QrDmwZmdZ7PyjVQkmDtBgaPmv+H5XE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 48567:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 413486811;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 12 Oct 2024 23:39:37 +0000 (UTC)
From: Danilo Pereira <dpereira@lkcamp.dev>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: vchiq_arm: removes multiple blank lines
Date: Sat, 12 Oct 2024 19:37:40 -0400
Message-ID: <20241012233931.30720-1-dpereira@lkcamp.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Removes multiple blank lines to adhere to kernel coding
style. No functional changes intended in this patch.

Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c =
b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 27ceaac8f6cc..29e78700463f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -106,7 +106,6 @@ struct vchiq_arm_state {
 =09int first_connect;
 };
=20
-
 static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int=
 handle, void *data,
 =09=09=09     unsigned int size, enum vchiq_bulk_dir dir);
@@ -309,9 +308,6 @@ static struct vchiq_arm_state *vchiq_platform_get_arm_s=
tate(struct vchiq_state *
 =09return (struct vchiq_arm_state *)state->platform_state;
 }
=20
-
-
-
 void vchiq_dump_platform_state(struct seq_file *f)
 {
 =09seq_puts(f, "  Platform: 2835 (VC master)\n");
--=20
2.43.0


