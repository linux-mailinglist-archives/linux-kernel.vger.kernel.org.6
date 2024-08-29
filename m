Return-Path: <linux-kernel+bounces-307820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B8F96533D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B702EB22BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9760718CBE1;
	Thu, 29 Aug 2024 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="rxjsY1X+"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50D1BAEE2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972685; cv=none; b=Dl90w+53mBaW6eFWnyoz9hj/vx56b7mpJJRmrb5DeQAuFLar0cku69fP3SZGQeaXYpnSwX78qO2LSEA6smTeth6drSoZS21opPfrAW+chH2CZEZiXfELtDjaeT3CFADw+MKYMueiPPmt7xxEG1WrLP6/S3Dosq0CapR2G/PEY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972685; c=relaxed/simple;
	bh=2Rjx78nyUgX75X0GQGLqziP8KKXen2/SCwhbO9BiCE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuUs9bGGnrFVBGisq3NnrR6rDEDhcpJNOC3KsCegcvfjb6/MBVY+9DVQxZTKsbqkzPTdf4dDkbhdytgXplnRvrlYjUfmstNTHW4OU6cPvfqGrdQk9x181R5l0uvuCtMQ4J0y+OZu0dLB1kMRudhO4AsAacBp08eZhMRV9fbkjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=rxjsY1X+; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724972680; x=1725577480; i=spasswolf@web.de;
	bh=HyWzHg+sfe9Oo23hZtoGqTcGf6ltwKxb3Z16ronqjEM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:cc:content-transfer-encoding:content-type:
	 date:from:message-id:mime-version:reply-to:subject:to;
	b=rxjsY1X+9a1L/bERUROA8mZ38qs80DisJvPDxCZBsOfhL6ZUtY4n0NZBrKF8dv1x
	 uUcKgig/9634unH19JNjdAHFXfdDaDkIFPRaP5jae3Jpv9ygOTZuSwqH8EaIiX2CO
	 XA/lBuhe93zq5u8w5v51SEKI8xjEF7wcBauS+SFEjIFQJqGZ/L6MOFpE8mKlDJf5J
	 zsuK0yJk3NikbvvhQRn3D/DU5Z/1mhiklEvrqdm04eOlgbf/pPKQhe8hFDa5NCI+S
	 /WS5kBDJ0ffXVOyiMBejFiniMMtOSVGsUBXpGHr26qP/ofnmODZZp7wccEV9Xonte
	 DU/2idhSM94Y9tnoKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MYclj-1sXJUp1hml-00Uxgp; Fri, 30 Aug 2024 01:04:40 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org
Subject: Re: commit c2fe0480cd77 leads to hang on boot
Date: Fri, 30 Aug 2024 01:04:37 +0200
Message-ID: <20240829230438.3226-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240829224124.2978-1-spasswolf@web.de
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:axW3DG9u6C9TIL17DpA7PMcF0F3UQHDa01yRhhsc6YnNc9YeJAT
 jwaTDjMnFxu6kThjGkB9xd3GJ5s0F/UUBnxJvBx+3edhXqxexEiDqQ2nQfo8L5BUYPN39XT
 FMYXQHs0/qHqiMKrFt4guzfdZqK6gpNdg5TQHZ1ji1r47HBjw/f8sEDoCb41lIzISUMS5zW
 cT42rJvtDAc7A2aG0eqMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HVy2g/1cvag=;rAnMoYSC045+l/3NicjqIhMfjzk
 2nqOnY1fQm2fn9oiqDjdEiePHvDv09tWNTYFBgrlVI7d86N2wlaXr0tE450u1UYrmaqP4bZ8V
 +g9g6LlFXRDfuLlrv3o4O/fl5LavXlIC+/MO2RVh+PjA4liMRkjNK5OBJvbOyWR+8JNdGgG+w
 M8IEw90ed0D0JdObvUQ/yJS+DcBrZFcHd+nzQoIE3koNQX/X33DjDvAhABS/afdoaQBfqZIjC
 czdtVdYriZwQnXo4Wj+XyHE2RBpfUP3gG75qPN5twmmwcHdu4o2Ma7XqPg8BXVfNJUgakDdl+
 bvYBNQWScKsAxgOsLKg8GTQRp9Y3rEcceW2GaRW3rsd6vWweg9NOuaJmW7mIXBtKTQclV4bMG
 MjsBYO+ylgSK1ql1NoZGK+5hIKX77tMft0Zdz+6qLFS143ZT6IRvVEjU5z8JvtpmcTQvAPYpR
 LJML9pBrD8SBoyyln/S9B9hGQEjX6h5dGDECOt+4/IaVBhF1i7xQxf1mg1uON6I1F6aYZA9UB
 aoVjBbrXgp/V+ZMP/G6hlcQLlvFH32a8JNXpnGLZ083Y8b05EabKR/+TzWlTfCsfMDUBomJ81
 942Oc0LAbKNz1elKysgI1AvG5MWpMCBIpz3RXPNVRUPxZKE8aowTvJ07U9fyQIY39JVhWSAZQ
 UQAKHqm4RYbmm/s5lxxGSXtGaa8enawaL+ZxjNlTsV71FUqcrz0EQfhgk4jYNhUjMnpAIcCKM
 H4K6OQl726xmLppUwL4NlUxfq0km1Z5haa7QXyKei+qN3CK0MeywiUsp0GRDyLgXK1u0QRPzP
 cNJtwMgbbC2kg31usaLryIJg==

To look into the issue I applied the following patch to next-20240829:

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 20517448487e..ba2b0d4b1bd3 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -573,6 +573,8 @@ static int efifb_probe(struct platform_device *dev)
 		pr_err("efifb: cannot acquire aperture\n");
 		goto err_fb_dealloc_cmap;
 	}
+	printk(KERN_INFO "%s: not calling devm_register_framebuffer\n", __func__);
+	goto err_fb_dealloc_cmap;
 	err = devm_register_framebuffer(&dev->dev, info);
 	if (err < 0) {
 		pr_err("efifb: cannot register framebuffer\n");

Now booting works again so the problem seems to be in devm_register_framebuffer().

Bert Karwatzki



