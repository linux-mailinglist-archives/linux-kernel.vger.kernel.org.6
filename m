Return-Path: <linux-kernel+bounces-383013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48B9B162C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE3282A62
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98E17C22E;
	Sat, 26 Oct 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b="JDFKoOkf";
	dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b="DofKhjsg"
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA21384B3
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929726; cv=none; b=Z6pqFj+5eXTTajun9oVwweaWRLP7Zu/ZomFzqsy5Ekp8CDnjGynYR4FjuNKvUrZuKzIFnD5OQauS2bj/a/lYcpCF/+M5FxkBQYv0fHyrgWFaI1OWTNwe0A9VE86OfmvmNlDn2XJO2a5qaAe9b88wpsCYELyi4MBOFLuc0EtKYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929726; c=relaxed/simple;
	bh=mU9HPii3MeI8FdAIbZqlCoAZM1IA+d3IDE5o3C7ZgKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKNaPNN8LZMGvg2zzwGZZg9ApKGpIpStv+xZY0nERaYQjuzhMmLChfdSc8we9hSFoEDZ9HDsxUlVvOPddsIeNHofIiLVhQgldGTqsR5MrcJWI7mqk2yLldP9n0urYxH3qBeh9kgPWoLjTygGkpW/KHMmvfFgVQLVavo4w6F2b7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embedd.com; spf=pass smtp.mailfrom=embedd.com; dkim=pass (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b=JDFKoOkf; dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b=DofKhjsg; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embedd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embedd.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
	s=dkim1; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WpI7H1Gvt9lgGH2ycMO9T2GTxR9m0Eby2eQfvWe+3oI=; b=JDFKoOkfQ+R52eY0DiLqT6650h
	oG+YZXkaP1WiZp+bkmxbt0Qj+H9CE+/WiVN3Xs6hS+iPbx7VIIBkdr3I4mXv8xwhP8EJ95RqJelWF
	E+6iuBcYhSqWAxvB46AojLcM+ZXU6o2yvkBlbLTMI5y6etfSRuYooUDFR4adx/ILNFWK/DeV1b/i/
	7fnZyNvFNxnIqzDAeQbgiUDN5f/FjwU1/mwl5yY3sKN7Uz+P0iJHd1dH6qFd5zNb/BiAzJZNsq/h1
	tuoM4JuMFt+lYjrfTihj5eZRVx1VbkswJzTQIpy4/r/1X8fVlezr0XeIyqyvzwFRufvGzj1BOd/J6
	DavMR2Rg==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:50302 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <dd@embedd.com>)
	id 1t4bhr-0000000069f-1p8x;
	Sat, 26 Oct 2024 09:59:32 +0200
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
	BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_500_599 0.000000, BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000,
	DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
	HTML_00_10 0.050000, LEGITIMATE_SIGNS 0.000000, MULTIPLE_RCPTS 0.100000,
	MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_URI_FOUND 0.000000,
	NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
	OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000,
	__CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CTE 0.000000, __DKIM_ALIGNS_1 0.000000,
	__DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FROM_DOMAIN_IN_ANY_CC1 0.000000,
	__FROM_DOMAIN_IN_RCPT 0.000000, __FROM_NAME_NOT_IN_ADDR 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_X_MAILER 0.000000, __MIME_TEXT_ONLY 0.000000,
	__MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_PASS 0.000000,
	__SANE_MSGID 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
	__URI_NO_WWW 0.000000, __URI_NS 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2024.10.26.71815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From; bh=WpI7H1Gvt9lgGH2ycMO9T2GTxR9m0Eby2eQfvWe+3oI=;
	b=DofKhjsgx1zwJZvom4+dn0dqRN5ChsXwq4xl0FrnfIz76Kp12+NQS1a24vUzqL7INMCH8M3QAKClprMB91N4tZAFbCerdgo/sFdPuYItQdw3RWpS9GQNhIWyDxtXvd2VdN5U2NMfFcDL6P5t1IsmbdxCQpmE2swbEA3/WC/elVg=;
From: Daniel Danzberger <dd@embedd.com>
To: johan@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Danzberger <dd@embedd.com>
Subject: [PATCH] gnss/usb: Add U-blox 8/M8 device id
Date: Sat, 26 Oct 2024 09:58:57 +0200
Message-ID: <20241026075857.3651161-1-dd@embedd.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dd@embedd.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: dd@embedd.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1t4bhY-0004tY-4i
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <dd@embedd.com>)
	id 1t4bhY-0004tY-4i; Sat, 26 Oct 2024 09:59:12 +0200

Adds support for U-Blox 8 GNSS devices

Signed-off-by: Daniel Danzberger <dd@embedd.com>
---
 drivers/gnss/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gnss/usb.c b/drivers/gnss/usb.c
index 028ce56b20ea..927f89a5b3f0 100644
--- a/drivers/gnss/usb.c
+++ b/drivers/gnss/usb.c
@@ -18,6 +18,7 @@
 
 static const struct usb_device_id gnss_usb_id_table[] = {
 	{ USB_DEVICE(0x1199, 0xb000) },		/* Sierra Wireless XM1210 */
+	{ USB_DEVICE(0x1546, 0x01a8) },         /* U-blox 8/M8 GNSS Receiver */
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, gnss_usb_id_table);
-- 
2.39.2


