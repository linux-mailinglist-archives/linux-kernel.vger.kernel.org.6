Return-Path: <linux-kernel+bounces-544830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B29A4E59A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8590189972D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EA0283696;
	Tue,  4 Mar 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=arndb.de header.i=@arndb.de header.b="ACTmPjza";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/Of9qKP"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131B27C844
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103757; cv=pass; b=Z2bYMzQchzqsW1Joi4aZLYG7MYbelOuHYSFI9sM0qr4UCFoHh4kAMnharuyTJ+R+2kWtbdgu9dVf/AORalnmuJ6hog+5xKWNnAKHYuDy8NlSwUakLfJrHnu8iAXMBN6o6FP2legWNlZnSPfcofAQCN1pRW32abwHa9rTD/UBVhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103757; c=relaxed/simple;
	bh=MZTJ8jtmBdhVrMI155JXnI+5KZaVM9Qmx/m//I/59EY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q589PKz1luua/vA62gzHR0vjZW7nbET4xDAw/FVxCEQuZ0soNEphV6t5qVyyk6R1vtc36OfH/6P09yCDXWBA2GxPk0sYSLm5UIt2irZwC+H1lozNAEQW3YJVxd0A5o2H2I509OlMm610YAKKLdttZpJzIroBdt7FnWQkQI3S+Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arndb.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=permerror (0-bit key) header.d=arndb.de header.i=@arndb.de header.b=ACTmPjza; dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/Of9qKP; arc=none smtp.client-ip=202.12.124.148; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 9FEE740CF4D3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:55:53 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=permerror header.d=arndb.de header.i=@arndb.de header.a=rsa-sha1 header.s=fm3 header.b=ACTmPjza;
	dkim=permerror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha1 header.s=fm1 header.b=E/Of9qKP
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gGZ3GrkzG1hs
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:54:14 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 2A0C742728; Tue,  4 Mar 2025 18:54:12 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=permerror (0-bit key) header.d=arndb.de header.i=@arndb.de header.b=ACTmPjza;
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/Of9qKP
X-Envelope-From: <linux-kernel+bounces-541353-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ACTmPjza;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/Of9qKP
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 9E651434D3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:18:15 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 97DBD3064C0B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:18:14 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61AA7A6773
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F77B1EDA07;
	Mon,  3 Mar 2025 10:17:53 +0000 (UTC)
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A31EDA04;
	Mon,  3 Mar 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997067; cv=none; b=rq/zmdrnPbj4XyMlF/XWMtRW9ZJKn1M8Czby0WHP+1Apb92+Opp1lSBS1ADsy+oyhZTawk3n4xumDUclnA/C6xWkTywdjx257BS3qm2E3hEIL7t/NL1UoBJ3uCYBwPRgptoToao+oIEDa3aq27pvRUUdGnpHISIrrER5odbd8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997067; c=relaxed/simple;
	bh=MZTJ8jtmBdhVrMI155JXnI+5KZaVM9Qmx/m//I/59EY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gb58epXi0VnSALgiBldMzOLSxYBkupz1E5cjijJFE1mR03olsKyYxu1dJoDAOoYv/G7Hv3V/QsnWym954OD8uDlRuQx/u8PEayatjhI8vTiD6e8hq+2Bg5sG7/9/S/8E5HwDJpMSMOL86mT6+SJywflKl7kfzhDskM3twIaqCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ACTmPjza; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/Of9qKP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id AC350114018F;
	Mon,  3 Mar 2025 05:17:43 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 05:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740997063;
	 x=1741083463; bh=SxVYYWyEfN4voFI2GASZNcWhRuSURq5mf16q/E3gNcA=; b=
	ACTmPjzaTTMxIbatIYGXPxfZ2GKFfsmkcgJlnCNJgmlKcruy1qoEYQ1jX/RhEYH0
	MpmL7rblxpKixaEl2KOdCL9Tp+cN9Qm3rribIBNIhB3q8ccJzJl8W1PeqlUHtNsI
	c7+eE8sV4BXmnesPJmoZ2qss48y8QpzfIt0LqDWRUAmsZ5BenuLQH/8VoXoeCs5v
	Y1fCYb88BxAEe5w6VNbsSFjWsWM+necwQTuWnf2J4dSGAjPbDutLvU15JSWK3xCP
	e/9rd2bP2ceRcSrsKNXdOxEXdtjkjFm+JC+Ct/bdJfmUnNACiPiQ/nUC+VAaOBvu
	ZY8myTG+L2GiYqs9PwUBUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740997063; x=
	1741083463; bh=SxVYYWyEfN4voFI2GASZNcWhRuSURq5mf16q/E3gNcA=; b=E
	/Of9qKPfuRFgh05lgDVjthlVaFsZeNgRie5Qum1UO/wu8HD+fXLwjqM7NachGZzk
	SdpWzxqpemLu+bj91/Gjta0GWoqURLJtgZ3SCmqQCuGi/z4muXOk5fQ1d2BGtKyd
	S4j+do4VhAqUDkBP5qvPotVjzu39JYj0uUbJcKjHw4eVz4uvYALPWGEe5IkjI+XL
	Hj5KsomTWeGEsfHuzTvk5uKeWGeNtPwyc8SXJs9CEuvDBWNyc3nrNldJJ85YCvzI
	g/UFXHmuJYCC2GrBpUZTY0y0vcqTYwvKKDwv/8R0GLS/SXT/NMBSmKNNF+stZ6D7
	Sc4frAJiz9Bc2WXBJ7EWg==
X-ME-Sender: <xms:x4HFZ_G8V-KcZeJrH6KcxbnE47ySgY6MXJgFwfuwYmJnqrPs1IlK-A>
    <xme:x4HFZ8UUPqdfZomHfLky_ieSS7ax4FFRIXXFUfDim5FdJTTokDMRry5dQ3xXkYIma
    Bu49CDOpS8dsqDLbVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlsghulhifrghhnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    lhhukhgrshdrsghulhifrghhnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgvrh
    hnvghlqdhjrghnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x4HFZxIuFO8VShpOOZL0Xv_zZBXaDLQCpGyFUx7D9_KS4iaKOi6xYA>
    <xmx:x4HFZ9E1d0aOG5H9Rj6R7X6BQYNq_QBPx-7EupAFS1bAnnk9wXRmxg>
    <xmx:x4HFZ1V0CzKOB93_XvINub9xlqkg2uy9bO1erVggdedtg2ALNh3fcw>
    <xmx:x4HFZ4OCpw5qeC3ovA5DknGfYiF4S77wL_9yP_MPUAduvywvSmLL0A>
    <xmx:x4HFZ7zgPQQ9UEoJI1BGexAsONSDK49aWEFZNyJMlCe5GOxA0Uc95SYO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 434AF2220072; Mon,  3 Mar 2025 05:17:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Mar 2025 11:17:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lukas Bulwahn" <lbulwahn@redhat.com>, "Lee Jones" <lee@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
 "Lukas Bulwahn" <lukas.bulwahn@redhat.com>
Message-Id: <a15bb180-401d-49ad-a212-0c81d613fbc8@app.fastmail.com>
In-Reply-To: <20250303100055.372689-1-lukas.bulwahn@redhat.com>
References: <20250303100055.372689-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] mfd: remove STA2x11 mfd driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gGZ3GrkzG1hs
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708459.98603@lI0M0zOu4g5CSowx0Fk8UQ
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 3, 2025, at 11:00, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> With commit dcbb01fbb7ae ("x86/pci: Remove old STA2x11 support"), the mfd
> driver for STA2x11 is not needed and cannot be built anymore.
>
> Remove the driver and its header file.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

You probably also saw the bits in drivers/media and drivers/ata
for sta2x11. I have another list of drviers that are (probably)
be unused for some reason. I have some more arm platforms that
I want to remove, and was planning to go through all of them
once the board support is gone, but feel free to take that list
below as a starting point case you are in a mood for destruction ;-)

Most of the drivers below lack DT support and were only used in
board files that have since been removed. Note that the s3c64xx
platform is still around and may use some of them even though we
had previously planned to drop the platform by now.

       Arnd

---
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 89aec08df739..8d2d429170e7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -370,6 +370,7 @@ config RPR0521
 config SENSORS_LM3533
 	tristate "LM3533 ambient light sensor"
 	depends on MFD_LM3533
+	depends on UNUSED
 	help
 	  If you say yes here you get support for the ambient light sensor
 	  interface on National Semiconductor / TI LM3533 Lighting Power
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 721ab69e84ac..1caca5d22500 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -30,6 +30,7 @@ config KEYBOARD_ADC
 config KEYBOARD_ADP5520
 	tristate "Keypad Support for ADP5520 PMIC"
 	depends on PMIC_ADP5520
+	depends on UNUSED
 	help
 	  This option enables support for the keypad scan matrix
 	  on Analog Devices ADP5520 PMICs.
@@ -53,6 +54,7 @@ config KEYBOARD_ADP5588
 config KEYBOARD_ADP5589
 	tristate "ADP5585/ADP5589 I2C QWERTY Keypad and IO Expander"
 	depends on I2C
+	depends on UNUSED
 	help
 	  Say Y here if you want to use a ADP5585/ADP5589 attached to your
 	  system I2C bus.
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 13d135257e06..9e6693b41463 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -52,6 +52,7 @@ config INPUT_AB8500_PONKEY
 
 config INPUT_AD714X
 	tristate "Analog Devices AD714x Capacitance Touch Sensor"
+	depends on UNUSED
 	help
 	  Say Y here if you want to support an AD7142/3/7/8/7A touch sensor.
 
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 91a2b584dab1..c3319a644c25 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -46,6 +46,7 @@ config TOUCHSCREEN_ADS7846
 config TOUCHSCREEN_AD7877
 	tristate "AD7877 based touchscreens"
 	depends on SPI_MASTER
+	depends on UNUSED
 	help
 	  Say Y here if you have a touchscreen interface using the
 	  AD7877 controller, and your board-specific initialization
diff --git a/drivers/media/pci/sta2x11/Kconfig b/drivers/media/pci/sta2x11/Kconfig
index 118b922c08c3..3153544c0600 100644
--- a/drivers/media/pci/sta2x11/Kconfig
+++ b/drivers/media/pci/sta2x11/Kconfig
@@ -3,6 +3,7 @@ config STA2X11_VIP
 	tristate "STA2X11 VIP Video For Linux"
 	depends on PCI && VIDEO_DEV && I2C
 	depends on STA2X11 || COMPILE_TEST
+	depends on UNUSED
 	select GPIOLIB if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_ADV7180 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/platform/samsung/s3c-camif/Kconfig b/drivers/media/platform/samsung/s3c-camif/Kconfig
index f359f6382fff..0132b0f13dec 100644
--- a/drivers/media/platform/samsung/s3c-camif/Kconfig
+++ b/drivers/media/platform/samsung/s3c-camif/Kconfig
@@ -4,6 +4,7 @@ config VIDEO_S3C_CAMIF
 	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV && I2C && PM
 	depends on ARCH_S3C64XX || COMPILE_TEST
+	depends on UNUSED
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index 72776d08046a..43551cebf5b2 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -144,6 +144,7 @@ config RADIO_TIMBERDALE
 config RADIO_WL1273
 	tristate "Texas Instruments WL1273 I2C FM Radio"
 	depends on I2C
+	depends on UNUSED
 	select MFD_CORE
 	select MFD_WL1273_CORE
 	select FW_LOADER
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d44c69bb3dfd..75eb2b3a64a6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -117,6 +117,7 @@ config MFD_AS3722
 config PMIC_ADP5520
 	bool "Analog Devices ADP5520/01 MFD PMIC Core Support"
 	depends on I2C=y
+	depends on UNUSED
 	help
 	  Say yes here to add support for Analog Devices ADP5520 and ADP5501,
 	  Multifunction Power Management IC. This includes
@@ -129,6 +130,7 @@ config MFD_AAT2870_CORE
 	select MFD_CORE
 	depends on I2C=y
 	depends on GPIOLIB || COMPILE_TEST
+	depends on UNUSED
 	help
 	  If you say yes here you get support for the AAT2870.
 	  This driver provides common support for accessing the device,
@@ -362,6 +364,7 @@ config MFD_CS47L92
 config PMIC_DA903X
 	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
 	depends on I2C=y
+	depends on UNUSED
 	help
 	  Say yes here to add support for Dialog Semiconductor DA9030 (a.k.a
 	  ARAVA) and DA9034 (a.k.a MICCO), these are Power Management IC
@@ -1069,6 +1072,7 @@ config MFD_OCELOT
 config EZX_PCAP
 	bool "Motorola EZXPCAP Support"
 	depends on SPI_MASTER
+	depends on UNUSED
 	help
 	  This enables the PCAP ASIC present on EZX Phones. This is
 	  needed for MMC, TouchScreen, Sound, USB, etc..
@@ -1121,6 +1125,7 @@ config MFD_RETU
 
 config MFD_PCF50633
 	tristate "NXP PCF50633"
+	depends on UNUSED
 	depends on I2C
 	select REGMAP_I2C
 	help
@@ -1245,6 +1250,7 @@ config MFD_RT5120
 config MFD_RC5T583
 	bool "Ricoh RC5T583 Power Management system device"
 	depends on I2C=y
+	depends on UNUSED
 	select MFD_CORE
 	select REGMAP_I2C
 	help
@@ -1325,6 +1331,7 @@ config MFD_SEC_CORE
 config MFD_SI476X_CORE
 	tristate "Silicon Laboratories 4761/64/68 AM/FM radio."
 	depends on I2C
+	depends on UNUSED
 	select MFD_CORE
 	select REGMAP_I2C
 	help
@@ -1498,6 +1505,7 @@ endmenu
 config MFD_STA2X11
 	bool "STMicroelectronics STA2X11"
 	depends on STA2X11
+	depends on UNUSED
 	select MFD_CORE
 	select REGMAP_MMIO
 
@@ -1543,6 +1551,7 @@ config MFD_LP3943
 config MFD_LP8788
 	bool "TI LP8788 Power Management Unit Driver"
 	depends on I2C=y
+	depends on UNUSED
 	select MFD_CORE
 	select REGMAP_I2C
 	select IRQ_DOMAIN
@@ -1868,6 +1877,7 @@ config MENELAUS
 config MFD_WL1273_CORE
 	tristate "TI WL1273 FM radio"
 	depends on I2C
+	depends on UNUSED
 	select MFD_CORE
 	default n
 	help
@@ -1877,6 +1887,7 @@ config MFD_WL1273_CORE
 
 config MFD_LM3533
 	tristate "TI/National Semiconductor LM3533 Lighting Power chip"
+	depends on UNUSED
 	depends on I2C
 	select MFD_CORE
 	select REGMAP_I2C
@@ -1995,6 +2006,7 @@ config MFD_WM8400
 	bool "Wolfson Microelectronics WM8400"
 	select MFD_CORE
 	depends on I2C=y
+	depends on UNUSED
 	select REGMAP_I2C
 	help
 	  Support for the Wolfson Microelecronics WM8400 PMIC and audio
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4d71a76ac82e..6e698549e2dc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -362,6 +362,7 @@ config SENSORS_TSL2550
 config SENSORS_BH1770
 	 tristate "BH1770GLC / SFH7770 combined ALS - Proximity sensor"
 	 depends on I2C
+	depends on UNUSED
 	help
 	   Say Y here if you want to build a driver for BH1770GLC (ROHM) or
 	   SFH7770 (Osram) combined ambient light and proximity sensor chip.
@@ -372,6 +373,7 @@ config SENSORS_BH1770
 config SENSORS_APDS990X
 	 tristate "APDS990X combined als and proximity sensors"
 	 depends on I2C
+	depends on UNUSED
 	help
 	   Say Y here if you want to build a driver for Avago APDS990x
 	   combined ambient light and proximity sensor chip.
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 977b42bc1e8c..72eecd075bfd 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -107,6 +107,7 @@ config KORINA
 config LANTIQ_ETOP
 	tristate "Lantiq SoC ETOP driver"
 	depends on SOC_TYPE_XWAY
+	depends on UNUSED
 	help
 	  Support for the MII0 inside the Lantiq SoC
 
diff --git a/drivers/net/ethernet/wiznet/Kconfig b/drivers/net/ethernet/wiznet/Kconfig
index 4bac2ad2d6a1..1f7a7edfa0b9 100644
--- a/drivers/net/ethernet/wiznet/Kconfig
+++ b/drivers/net/ethernet/wiznet/Kconfig
@@ -33,6 +33,7 @@ config WIZNET_W5100
 config WIZNET_W5300
 	tristate "WIZnet W5300 Ethernet support"
 	depends on HAS_IOMEM
+	depends on UNUSED
 	help
 	  Support for WIZnet W5300 chips.
 
diff --git a/drivers/net/wireless/marvell/libertas/Kconfig b/drivers/net/wireless/marvell/libertas/Kconfig
index caf8bc231b2e..d232ecaee9d2 100644
--- a/drivers/net/wireless/marvell/libertas/Kconfig
+++ b/drivers/net/wireless/marvell/libertas/Kconfig
@@ -22,6 +22,7 @@ config LIBERTAS_SDIO
 config LIBERTAS_SPI
 	tristate "Marvell Libertas 8686 SPI 802.11b/g cards"
 	depends on LIBERTAS && SPI
+	depends on UNUSED
 	help
 	  A driver for Marvell Libertas 8686 SPI devices.
 
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 7b18358f194a..73126f1f4f97 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -299,6 +299,7 @@ config BATTERY_BQ27XXX_DT_UPDATES_NVM
 
 config BATTERY_DA9030
 	tristate "DA9030 battery driver"
+	depends on UNUSED
 	depends on PMIC_DA903X
 	help
 	  Say Y here to enable support for batteries charger integrated into
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d8177..f5cf30172a54 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -499,6 +499,7 @@ config REGULATOR_LOCHNAGAR
 
 config REGULATOR_LP3971
 	tristate "National Semiconductors LP3971 PMIC regulator driver"
+	depends on UNUSED
 	depends on I2C
 	help
 	 Say Y here to support the voltage regulators and convertors
@@ -506,6 +507,7 @@ config REGULATOR_LP3971
 
 config REGULATOR_LP3972
 	tristate "National Semiconductors LP3972 PMIC regulator driver"
+	depends on UNUSED
 	depends on I2C
 	help
 	 Say Y here to support the voltage regulators and convertors
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f496ab127ef0..da7d8d626366 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1280,6 +1280,7 @@ config SPI_LOOPBACK_TEST
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
+	depends on UNUSED
 	help
 	  SPI driver for Infineon TLE62X0 series line driver chips,
 	  such as the TLE6220, TLE6230 and TLE6240.  This provides a
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 79a8186d3361..bb4affd536ca 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -313,6 +313,7 @@ config SERIAL_TEGRA_UTC_CONSOLE
 config SERIAL_MAX3100
 	tristate "MAX3100/3110/3111/3222 support"
 	depends on SPI
+	depends on UNUSED
 	select SERIAL_CORE
 	help
 	  This selects support for an advanced UART from Maxim.
diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index aae1787320d4..f25011cc61c0 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -231,6 +231,7 @@ config USB_PXA27X
 config USB_MV_UDC
 	tristate "Marvell USB2.0 Device Controller"
 	depends on HAS_DMA
+	depends on UNUSED
 	help
 	  Marvell Socs (including PXA and MMP series) include a high speed
 	  USB2.0 OTG controller, which can be configured as high speed or
@@ -239,6 +240,7 @@ config USB_MV_UDC
 config USB_MV_U3D
 	depends on HAS_DMA
 	tristate "MARVELL PXA2128 USB 3.0 controller"
+	depends on UNUSED
 	help
 	  MARVELL PXA2128 Processor series include a super speed USB3.0 device
 	  controller, which support super speed USB peripheral.
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d011d6c753ed..5f0deb409f94 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -377,7 +377,7 @@ config USB_ISP116X_HCD
 config USB_ISP1362_HCD
 	tristate "ISP1362 HCD support"
 	depends on HAS_IOPORT
-	depends on COMPILE_TEST # nothing uses this
+	depends on UNUSED # nothing uses this
 	help
 	  Supports the Philips ISP1362 chip as a host controller
 
@@ -625,6 +625,7 @@ config FHCI_DEBUG
 config USB_SL811_HCD
 	tristate "SL811HS HCD support"
 	depends on HAS_IOMEM
+	depends on UNUSED
 	help
 	  The SL811HS is a single-port USB controller that supports either
 	  host side or peripheral side roles.  Enable this option if your
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 5f629d7cad64..efa798b2d56e 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -130,6 +130,7 @@ config USB_MV_OTG
 	tristate "Marvell USB OTG support"
 	depends on USB_EHCI_MV && USB_MV_UDC && PM && USB_OTG
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
+	depends on UNUSED
 	select USB_PHY
 	help
 	  Say Y here if you want to build Marvell USB OTG transceiver
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index aa681266c68f..3869c98185cb 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1464,6 +1464,7 @@ config FB_PXA168
 	tristate "PXA168/910 LCD framebuffer support"
 	depends on FB && HAVE_CLK && HAS_IOMEM
 	depends on CPU_PXA168 || CPU_PXA910 || COMPILE_TEST
+	depends on UNUSED
 	select FB_IOMEM_HELPERS
 	help
 	  Frame buffer driver for the built-in LCD controller in the Marvell
diff --git a/drivers/video/fbdev/mmp/fb/Kconfig b/drivers/video/fbdev/mmp/fb/Kconfig
index b13882b34e79..11442169f049 100644
--- a/drivers/video/fbdev/mmp/fb/Kconfig
+++ b/drivers/video/fbdev/mmp/fb/Kconfig
@@ -2,6 +2,7 @@
 config MMP_FB
 	tristate "fb driver for Marvell MMP Display Subsystem"
 	depends on FB
+	depends on UNUSED
 	select FB_IOMEM_HELPERS
 	default y
 	help
diff --git a/sound/spi/Kconfig b/sound/spi/Kconfig
index f407c37c37fa..e93a1abfd7bd 100644
--- a/sound/spi/Kconfig
+++ b/sound/spi/Kconfig
@@ -13,6 +13,7 @@ if SND_SPI
 config SND_AT73C213
 	tristate "Atmel AT73C213 DAC driver"
 	depends on ATMEL_SSC
+	depends on UNUSED
 	select SND_PCM
 	help
 	  Say Y here if you want to use the Atmel AT73C213 external DAC. This


