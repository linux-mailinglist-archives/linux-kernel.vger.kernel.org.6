Return-Path: <linux-kernel+bounces-419024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95749D68A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74295281B83
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFA17C7CE;
	Sat, 23 Nov 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b="AqOFLufL";
	dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b="ZI52wGjn"
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B04879B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732358527; cv=none; b=NWiMZGZ9J0eb8jTTJOHp7cOoG4xLeLXNXjktLeCLyb3hsue56xugxof9V6BkM/6jCuevC4o/cbpdHM+DdGjcX/OxnAUQoP5mXq9wQT1wXp82JGratFjeeLTynVG6zaUimOgT4jeyWvmlET6Zv3osLlzJ1zalr+DabPhO/FZhv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732358527; c=relaxed/simple;
	bh=xiyJf2nCVkmqMydhgf3KlmAnw+fLljWTPHp61utelpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQGw7pksTvPNBtGsf01mmsxlKetTo0udU6prI7dBT5wx+UqdiyN1MDBgUNktShoQ029w4tB6PUVQmnnbLps/InSIa8FF5i/GIhXVnoH97+1ulAnPYb8PNPLy6UYtFaNZ1zG6GJRRNTbhEqU6pZquIqOo4OwDJ5XSWUeeqW+Iwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embedd.com; spf=pass smtp.mailfrom=embedd.com; dkim=pass (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b=AqOFLufL; dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b=ZI52wGjn; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embedd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embedd.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
	s=dkim1; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Sx11ulPCWfQCUW2lEI+vJ62MgRBMlPw0B1PBVw3yF+M=; b=AqOFLufLt2SqGIwbF9Xv9Vff6Q
	5FN1qgDwAQ5ITpjcxBjwIUDxs3tMvDrea/lGrZiNSr/SrZMNlsAc3Y3NFw0H1p56FkqPFCYdophkE
	nPUwZX0tSI7CA5rIr4XQALEp3gTyCJIQcRDKlczVYAIrlQujgcCnCbLDRjt8SLQjB9w82CyfXdkIn
	jdy8nPuvqMGv5dhvRLg2VuquX8cNsSqpwZy/1wWT8nHU/jfMO8A9Uq9fMH/8Bj+Z6DeH45v3YnJag
	nrw40F+Wm4fuxCQ+xDuINalW3jx4j25+Ie4tdmCy1AhdtailvTlh44ivCFk8g9QUl1ux8WUvShFkr
	WWxPKF8Q==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:46550 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <dd@embedd.com>)
	id 1tEnXe-000000004ZQ-1Lib;
	Sat, 23 Nov 2024 11:39:06 +0100
X-SASI-Hits: BODY_SIZE_4000_4999 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_7000_LESS 0.000000, CTE_QUOTED_PRINTABLE 0.000000,
	CT_TEXT_PLAIN_UTF8_CAPS 0.000000, DKIM_ALIGNS 0.000000,
	DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
	IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000, MSG_THREAD 0.000000,
	MULTIPLE_REAL_RCPTS 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
	OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
	SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000, USER_AGENT 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CT 0.000000, __CTE 0.000000,
	__CTYPE_CHARSET_QUOTED 0.000000, __CT_TEXT_PLAIN 0.000000,
	__DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000,
	__DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000,
	__FRAUD_MONEY 0.000000, __FRAUD_MONEY_BIG_COIN 0.000000,
	__FRAUD_MONEY_BIG_COIN_DIG 0.000000, __FRAUD_MONEY_CURRENCY 0.000000,
	__FRAUD_MONEY_CURRENCY_DOLLAR 0.000000, __FRAUD_MONEY_VALUE 0.000000,
	__FROM_DOMAIN_NOT_IN_BODY 0.000000, __FROM_NAME_NOT_IN_ADDR 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
	__HEADER_ORDER_FROM 0.000000, __INT_PROD_GPS 0.000000, __IN_REP_TO 0.000000,
	__MAIL_CHAIN 0.000000, __MIME_BOUND_CHARSET 0.000000,
	__MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
	__MIME_VERSION 0.000000, __MULTIPLE_URI_TEXT 0.000000,
	__NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
	__OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
	__RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
	__SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_NEGATE 0.000000,
	__SUBJ_REPLY 0.000000, __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_IN_BODY 0.000000, __URI_NOT_IMG 0.000000, __URI_NO_MAILTO 0.000000,
	__URI_NO_PATH 0.000000, __URI_NS 0.000000, __URI_WITHOUT_PATH 0.000000,
	__USER_AGENT 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 7%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2024.11.23.94215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=Sx11ulPCWfQCUW2lEI+vJ62MgRBMlPw0B1PBVw3yF+M=;
	b=ZI52wGjnRSWo+Y6YAH3mgyQGES4Sr3nSkrlaWGVgUqfqUn715k8jl1PE8hK/jhdDHifijaD7MUQwvdjhoh9wIcBrhS21f2Xp1mzSJKUgyUM8ahNv+XnGWJHnD5j6z1Ls+OkjRUkRKwh/Ai5XL6TwhDNpoBa4yW/u5UCHE46LB5w=;
Message-ID: <d9f641491ec83c5f96ee547001dd8bd7ed5ae5a6.camel@embedd.com>
Subject: Re: [PATCH] gnss/usb: Add U-blox 8/M8 device id
From: Daniel Danzberger <dd@embedd.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Date: Sat, 23 Nov 2024 11:38:42 +0100
In-Reply-To: <ZyDO9lTmJmnQ1nJO@hovoldconsulting.com>
References: <20241026075857.3651161-1-dd@embedd.com>
	 <ZyDO9lTmJmnQ1nJO@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dd@embedd.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: dd@embedd.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1tEnXG-0006Xu-J1
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <dd@embedd.com>)
	id 1tEnXG-0006Xu-J1; Sat, 23 Nov 2024 11:38:42 +0100

Hi Johan,

this is the lsusb -v output:
--
root@test1:~# lsusb -v -s  001:002=20

Bus 001 Device 002: ID 1546:01a8 u-blox AG - www.u-blox.com u-blox GNSS rec=
eiver
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            2 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0=20
  bMaxPacketSize0        64
  idVendor           0x1546 u-blox AG - www.u-blox.com
  idProduct          0x01a8 u-blox GNSS receiver
  bcdDevice            3.01
  iManufacturer           1 u-blox AG - www.u-blox.com
  iProduct                2 u-blox GNSS receiver
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x003e
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 [unknown]
      bInterfaceSubClass      2 [unknown]
      bInterfaceProtocol      1=20
      iInterface              0=20
      CDC Header:
        bcdCDC               1.10
      CDC ACM:
        bmCapabilities       0x02
          line coding and serial state
      CDC Call Management:
        bmCapabilities       0x03
          call management
          use DataInterface
        bDataInterface          1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval             255
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10 [unknown]
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol    255=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0001
  Self Powered

--

This is a cat on the device, so you can see it's in fact usb gnss capable:
--
root@test1:~# cat /dev/gnss0=20
$GNTXT,01,01,02,u-blox AG - www.u-blox.com*4E
$GNTXT,01,01,02,HW UBX-M8030 00080000*60
$GNTXT,01,01,02,ROM CORE 3.01 (107888)*2B
$GNTXT,01,01,02,FWVER=3DSPG 3.01*46
$GNTXT,01,01,02,PROTVER=3D18.00*11
$GNTXT,01,01,02,GPS;GLO;GAL;BDS*77
$GNTXT,01,01,02,SBAS;IMES;QZSS*49
$GNTXT,01,01,02,GNSS OTP=3DGPS;GLO*37
$GNTXT,01,01,02,LLC=3DFFFFFFFF-FFFFFFE3-FFFFFFFF-FFFFFFFF-FFFFFFE9*27
$GNTXT,01,01,02,ANTSUPERV=3DAC SD PDoS SR*3E
$GNTXT,01,01,02,ANTSTATUS=3DOK*25
$GNTXT,01,01,02,PF=3D3DF*49
$GNRMC,,V,,,,,,,,,,N*4D
$GNVTG,,,,,,,,,N*2E
$GNGGA,,,,,,0,00,99.99,,,,,,*56
$GNGSA,A,1,,,,,,,,,,,,,99.99,99.99,99.99*2E
--

On Tue, 2024-10-29 at 13:03 +0100, Johan Hovold wrote:
> On Sat, Oct 26, 2024 at 09:58:57AM +0200, Daniel Danzberger wrote:
> > Adds support for U-Blox 8 GNSS devices
>=20
> Please post the output of lsusb -v (or usb-devices) for this device.
>=20
> IIRC this is a USB CDC device, which is already managed by the cdc-acm
> driver.
>=20
> Johan
>=20

--=20
Regards

Daniel Danzberger
embeDD GmbH, Alter Postplatz 2, CH-6370 Stans

