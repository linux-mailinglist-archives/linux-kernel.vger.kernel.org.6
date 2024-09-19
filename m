Return-Path: <linux-kernel+bounces-333390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DC97C7D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960F11F29C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE821991A0;
	Thu, 19 Sep 2024 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b="I73y9aul"
Received: from egyptian.ash.relay.mailchannels.net (egyptian.ash.relay.mailchannels.net [23.83.222.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FEB33D8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741055; cv=pass; b=Wc/5i7Cy7JQYsj/3Fw276SfrBh/gIGgdaN/4DZ/r+39FXDp5L3XEoX1PzvG6tPDEdsZ509iW3NwPy45BnhkpDhicoXFy8kEVZUz1/vUXEsz4P2QtZYOBtVbwECQMuGny35Zg2qVo1YpgSp7AkW1tHZUXfAb+c6i4In7WWdMR7YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741055; c=relaxed/simple;
	bh=qTCGjhY8cyKNGduJuWzW59X9K0yVJZzCwGbCOsUx0Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oLk64/1zvoqKuRMpPR4lA7GT2x9eli0i5y8aJGS2I7vl8W9bn404ENjnr9q34LqdYk0R7KruIiAUDZZbflRsmaaeaQGRM/eatGpi3RXXzvxCTQw8qQ2hMAxQiNV6a0uOlx7+mXLnOd8dNLZytYeV9uq+gXurqWXyHwdGNFD4DSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net; spf=pass smtp.mailfrom=kaehlcke.net; dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b=I73y9aul; arc=pass smtp.client-ip=23.83.222.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 785108A332;
	Thu, 19 Sep 2024 10:17:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a280.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 29DC384B46;
	Thu, 19 Sep 2024 10:17:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1726741045; a=rsa-sha256;
	cv=none;
	b=Dx+GPa2uHoLHYrd86/6botA7GUyQ0l0h6arQR50dQ8xbmywOTlcTFX6KDLBoh7vQ8B7LBw
	GevlK065x4GuQQmsC4D2XWOqxrHGXignqqt5eWotmIvFdNd98ujL9AbJEQjaPBHbcTT1nD
	AyfQCYaJAXr2eheRGe0X1bo3FvKyKfPvVHfKhd6bmT8cTPQjYODCqz2STi932AdFcVqp8F
	iDO32t7radp0TzSheNn/z1CBilpKy5gv1RVG9QMCLj8qAcXVt2Qiods8nngdq0xmFz5z/C
	YQZhuHGzkwcQ5h+ebYWhcZZRqCskIXBArvevfWbwOnL9++dMC47ToQjW94U04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1726741045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=nhWi+8fAenCzu4uMyI/I00T9J2tOLVVKO7adjVTL6xs=;
	b=M8L9eef69H0YRTvczeGgi6F9hERPcYsLxAWSPV5w9NMo7/L+EaVTTrOvCAUHY5oS1EvLLp
	30IEXoT1UHXl7I5yWKOSNIbkBiXm4ScurhzQz7iUDgPT90DCDliVeUCv6UFwnvMbuQM7i0
	2LgRVCS/zV7PO9OIq/vkcm5AlzkX1nJWmhTjjqrgFRnwmWNBJ4DIGXO5Cro5jfHDNNudh1
	biRoHSKf4FQag4fpVFFpiaRWC7juOdHYKVBwpGv0MKbPFW5pmoh5DyR++u4ulVx9WEJyNj
	WjmnBnbS8TGrVQlxwjAedNwtm5y1bRDMj6zdBh9GuUYXf3bWZFzsoMU1i+FXZA==
ARC-Authentication-Results: i=1;
	rspamd-b5ccff48b-pt89w;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=matthias@kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matthias@kaehlcke.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Shelf: 40d91a34264ac0af_1726741045379_2279288865
X-MC-Loop-Signature: 1726741045379:3440743876
X-MC-Ingress-Time: 1726741045379
Received: from pdx1-sub0-mail-a280.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.108.164 (trex/7.0.2);
	Thu, 19 Sep 2024 10:17:25 +0000
Received: from curie.home (unknown [86.127.233.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: matthias@kaehlcke.net)
	by pdx1-sub0-mail-a280.dreamhost.com (Postfix) with ESMTPSA id 4X8WfX4LzSzCv;
	Thu, 19 Sep 2024 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaehlcke.net;
	s=dreamhost; t=1726741045;
	bh=nhWi+8fAenCzu4uMyI/I00T9J2tOLVVKO7adjVTL6xs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=I73y9aulWH1eHkiWhVuV5gQn4OHNPv96sT2UPsoIzWn/hWqfayRC1t8u3+GHfXcPG
	 Dq+o0PE/moon+yvAy0o1nP5xu40FTEbBNfsaKaXjKUK2Q+dozgW5igCzJ+TNuwr9+C
	 GXYZPGsqjch9wQ6UHe0gkio0EoWYHRGPDUs/j+7gD/4v3NyAcE2hH/X9RKAweXY7Vq
	 GonKq8CHfiKoytsy8Yf25AiiylWcu1tAOenRTxjz/pp+5+VQRQ0/mV5jAqcrWnrfK1
	 H9VkeV3O9Fnzls+sDxdgCrqmYq+COnA2r5sQlzd2j35ezVNEi9zebrvloLXkWiD7Ab
	 XjxPo4lmMm+qA==
Received: by curie.home (Postfix, from userid 1000)
	id 422E5106F6E; Thu, 19 Sep 2024 12:17:21 +0200 (CEST)
Date: Thu, 19 Sep 2024 10:17:21 +0000
From: Matthias Kaehlcke <matthias@kaehlcke.net>
To: linux-kernel@vger.kernel.org
Cc: Matthias Kaehlcke <mka@chromium.org>, 
	Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: [PATCH RESEND] MAINTAINERS: Update onboard USB dev maintainer email
Message-ID: <txyp2574geamo6l3nuk2rn5lbepmsw24zp6bqhxwc5b6egywm4@7n57hgzmnqwc>
Mail-Followup-To: Matthias Kaehlcke <matthias@kaehlcke.net>, 
	linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Update the email address of the onboard USB dev driver
maintainer.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..cd0e5d03fd21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16994,8 +16994,8 @@ S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov9734.c
 
-ONBOARD USB HUB DRIVER
-M:	Matthias Kaehlcke <mka@chromium.org>
+ONBOARD USB DEV DRIVER
+M:	Matthias Kaehlcke <matthias@kaehlcke.net>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
-- 
2.46.0.rc1.232.g9752f9e123-goog


