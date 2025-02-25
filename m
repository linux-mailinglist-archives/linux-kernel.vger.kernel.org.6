Return-Path: <linux-kernel+bounces-530915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB87A43A21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D08917F92B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD3266B6A;
	Tue, 25 Feb 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kw5zbeGF"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABC267B62
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476559; cv=none; b=XAx4hsNxD8TUawPSA5kwnPouCtFgtx43r9frpglJalLKdOKXgLGfxNTuNBidiTm4lp+lSBUmQJ09tjjPILiJOyoabyIJWgMYHQPhJiEUPPgIOxI0QlEyhtHIDOiglXNPOi6WJXP4MzGDBXMv4zOaJyNHGoqwyGuZ6HXHe4lJSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476559; c=relaxed/simple;
	bh=vMOdpFf13leEHXzQqFAXuKlmIV8zaMhepi2X91ndeJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvt0iI3IAacqleK56RkvFKubGlFCjQQ0KwARO0/r5hoAcawTkHzt7pMGSDOgkWbZKmifRv2pGdvpbFh0aD344DzpIFIXJBttIgHGYP6QDyrSrgjDRxE9v9qwBhTWBlZA3uuEjrc87IJdtg2r6d6dcu9ByJByEuoFm9tfuCW8RHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kw5zbeGF; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740476555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o1BPkLTn6NvjCT7x9OM1G503BAs6KZAocao82IvriLs=;
	b=Kw5zbeGFRxky6YJy4oO3akkD+YCXCr3/ip3D1oT+j/RhOAc9x34iGsqQa1KEfty96PDdKy
	lVg0vKRXlgTnw57Pq8mgL621pWJllxN1Xx/pPN84TNtYWuicYevY6Vtyzp2euhA0rr1o5L
	pPvvthR3ZVFdI+kQKIPI1STcI1NG+t4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] pcmcia: Use str_off_on() and str_yes_no() helpers
Date: Tue, 25 Feb 2025 10:42:22 +0100
Message-ID: <20250211140350.713397-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_off_on() and str_yes_no()
helper functions.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/pcmcia/socket_sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/socket_sysfs.c b/drivers/pcmcia/socket_sysfs.c
index c7a906664c36..4eadd0485066 100644
--- a/drivers/pcmcia/socket_sysfs.c
+++ b/drivers/pcmcia/socket_sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
@@ -98,7 +99,7 @@ static ssize_t pccard_show_card_pm_state(struct device *dev,
 					 char *buf)
 {
 	struct pcmcia_socket *s = to_socket(dev);
-	return sysfs_emit(buf, "%s\n", s->state & SOCKET_SUSPEND ? "off" : "on");
+	return sysfs_emit(buf, "%s\n", str_off_on(s->state & SOCKET_SUSPEND));
 }
 
 static ssize_t pccard_store_card_pm_state(struct device *dev,
@@ -177,7 +178,7 @@ static ssize_t pccard_show_resource(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct pcmcia_socket *s = to_socket(dev);
-	return sysfs_emit(buf, "%s\n", s->resource_setup_done ? "yes" : "no");
+	return sysfs_emit(buf, "%s\n", str_yes_no(s->resource_setup_done));
 }
 
 static ssize_t pccard_store_resource(struct device *dev,
-- 
2.48.1


