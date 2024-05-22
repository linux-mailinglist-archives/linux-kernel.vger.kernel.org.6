Return-Path: <linux-kernel+bounces-186544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281DC8CC56C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33D52829FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556B1420D4;
	Wed, 22 May 2024 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gL0wMAgA";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Mhlpl/Ra";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sNd/CgBf"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF601C6BD;
	Wed, 22 May 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398260; cv=fail; b=u+SLmdx1XVCyClfecaMuHYRUnQsPiod1eV6TJ5aUytHtR4fGEaMbXBKzI9kFg+Ct4Ysn1XLTIZlq1Ix9ffVT1Nk6mlwIQxep1Yq3L1l1g8tGWQlU9WF89jbzr77vtVjqIyQrhcvJfBJ2TDDa/zAuDah8VLZZlswFKRgGHpuPhnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398260; c=relaxed/simple;
	bh=qvBiWeX1Sfe9J7a+JCsh0eBReom6AbmeDvE5p9OG6FE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iMKzBXHl/sg6uj2foItU+H01WLvcS76Fp7X1DZWTQlfufudxibTzdhh/iW936leWLMIdEVz114rLuH1dPJr6kufYN7SPwJJMxZdur8Qtvc0lmjaR1WjKWliWnEGEvmEXnW2dPUw5UwYbgRiJ9q68ATdGXjzzmpLwNaNx1n3BrV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gL0wMAgA; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Mhlpl/Ra; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sNd/CgBf reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MGg02a021755;
	Wed, 22 May 2024 10:17:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=qvBiWeX1Sfe9J7a+JCsh0eBReom6AbmeDvE5p9OG6FE=; b=
	gL0wMAgAM/uY3DyG9UNFyMJVrmmzeNGF2Th/CKJk2u4gHD3ibmMh/Zkr91+8XWpn
	yXFtutoovoGfMLCVc4S38ZJehx+vQD2jJOjwoPsPudWsCe2W4lrSdtpyeZqT8InD
	U5NDjwA1SNrUb5HeI34qz2zKxvZYqPw4fUaL82kLY5aPy4mk1x+OOGUkeWYMuwNR
	iwJ3kGolT5yZo2pt0qLPBXFG0P1diXzjnor38L8PAnmpynoJoUVxaTBVOcILOUqG
	YziR0CVZfqPpozxGtB2f/lFIQ/JshNCgKwuOSSmC4gE65WTY2lwloqisWulGsNz8
	/y+GTSfS6hDV/d8HLCd8Uw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3y6u8sjqn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1716398229; bh=qvBiWeX1Sfe9J7a+JCsh0eBReom6AbmeDvE5p9OG6FE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Mhlpl/RabyHHEK4qiFKosQgfa14qAP/WitzqvVd0T4b7RNyiHDnOGWKg3erSfBK8X
	 A4tQBdyuhbFOd5QH5dpkdUcAxoljZd+bQfnfQajkZodu0TRWnky9RT2m5fPygrIng2
	 YHGKwY+PCwJRZneL3kWXMd1fnA+RenHz4Rqev8v29j5CVEQ3cotN7NZLMU5/rlScXO
	 CbyNCOvejQ42dcTh+iVlbV9dzIgJF8T1tQxR4uoubsaaMraL8bveWojy9GG6aAE6c2
	 +vPCJm/naQc/Q5CfB6WT5qIhZPGpwqXMNhtMZQhTgL9Ij/AfhUufFD5b4xGoCKX3rO
	 r70+0MKKLYdlw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 47ECC40453;
	Wed, 22 May 2024 17:17:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 86CE6A006D;
	Wed, 22 May 2024 17:17:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=sNd/CgBf;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0DBEE40353;
	Wed, 22 May 2024 17:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juyLSjDw4q1Sowo1aM/gb5IyWtVi/5jyZFQ7H9zYpdT2riZCw2J97xUq4loIAejKsKKDJTRd2RapMGNiWMbLcsjqdoZDkDsNHyLaqCobGTU/emRCgIB2DTi4LWtcYqr9uttKHUzC29n3vmQ3yW8CDw2JRZArbwWOYaQGRzNFEdLM5hEqT5Bz5NL0B2ZSxBywoMjjhSUM+OE5zzKMbfALgtu+X1tM996RtV1X81DseALN6qhPdrA1yxq+zjgCPHGsURfZ6ovxArVJCMe/sViD18GsX51jCbCu7XXCZ0EXg+AYhSRcwenxFr4lLUHIY5qvxO1exLHdN3Q47kLv2Dzq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvBiWeX1Sfe9J7a+JCsh0eBReom6AbmeDvE5p9OG6FE=;
 b=WgFLIESxeOGrr34GHz0+pNW2qazv/EYlQMFgOqSKvZlY4DDdcI49oK3fenCfHFVIBRYgYXZgCYBvQUWBkR7i7flFqbSvBJhe2pwJyG+Wdr8lJlRdHZRA5lZhKdeAxPZhkRrdBfly4o6EFYNaHZZFKhNBGHc8KUDLmWvzDJLNcG940FReKX4KC24u7lm8kMTPimeTw3uetSe1ksI6mbYHf7ovY3MW/2guOuutogN8gaXBmcpWTGOCv2lRXdSSKby/OTtk9gBGtelm/65XiMy5QVzBaZENoWH09qo9fdEKBWS1gMFapudhMmBXUTAiw5bkVVmpSeNBTLh7vd3Y5bfZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvBiWeX1Sfe9J7a+JCsh0eBReom6AbmeDvE5p9OG6FE=;
 b=sNd/CgBfIY56tKgA3637q4ydZBBSgQdqn98OEl13fWiuxTzHoHJt7YvK0p+fQ/xaDu00gcw330zJLmaEvHnc3NNrUtAQ+hervbg5kPSxJSld9w1TXWyiNDVU5TGYtCkdrJROJI2snZLC0LPoDy1rdgkvRbFBhuGEr2C6vnhKKzY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Wed, 22 May
 2024 17:17:02 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 17:17:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Michael Grzeschik <mgr@pengutronix.de>,
        Avichal Rakesh <arakesh@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jayant Chowdhary <jchowdhary@google.com>,
        "etalvala@google.com" <etalvala@google.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Thread-Topic: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Thread-Index: 
 AQHaisR7p/ka60fKF0m666TF1RlbgLFzcN6AgAGh4ICAAOvGgIAAlmuAgAAznACAHZQygIAGhRmAgAfA2gCAABofAIAA3HGAgAAo1QA=
Date: Wed, 22 May 2024 17:17:02 +0000
Message-ID: <20240522171640.iuol4672rnklc35g@synopsys.com>
References: <ZiWga5Kqno1ICv97@pengutronix.de>
 <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
 <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
In-Reply-To: <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB7848:EE_
x-ms-office365-filtering-correlation-id: e5569f8b-cc78-485e-5fa3-08dc7a82ff07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VjlFMGU2ZWhrcm0xVUpnMFVJSVdTbHZOeU1WTUZ5Ykpab25SWTJFeUM5RmZi?=
 =?utf-8?B?ajRUbVR1U25Nc0ptNlRJRFc4N1lWbVcxc3dhVzVyeWg1eWIrOGN2OG1RcW1U?=
 =?utf-8?B?U1lkQVZrd3llR1hQWTlabmN0a0hJL0piZWJ4NG0zNlJjdFhqcGJiRm1mYngx?=
 =?utf-8?B?RUthcUtSZTEvR1pLVWhJalN1cjlzc0IzVTh4T2xUcGlwVXg5VkFFRytXQlFF?=
 =?utf-8?B?RlRiUnFSbUJJTU15b2Z4YXIvM3dFZTMvMjFUYVVQeXA0cXl5VTNzWVRDRmRq?=
 =?utf-8?B?N2VKMFp6QTA4YVVNSGFVaUVBcGpEaGljbUx3Y3VYYTVOSFJMTXlBR2hoYmVH?=
 =?utf-8?B?VG1FK1dhcVQ2TitReUpyeVhOVW1JbGY4WGFaVVBpNmZucHdod1ZEUXFXQ2ov?=
 =?utf-8?B?VTlWTkZ5NitpOXRaWEEwcndKbHFMcCt3bzJoOXBwNTFlSUNqa1JGY2JzbTBC?=
 =?utf-8?B?NzUzSXpTQXlPQnk5dnN6RkJrb1RVRXArYVEvMmthKzlLRkxTSG1SRCtQK0gw?=
 =?utf-8?B?WHpLY0x4dnpZQWJ5Skp6ZC9iNEVLQUxyQ2s2OFlJMHB6YzVGSUdPc2Q2S0hI?=
 =?utf-8?B?bWswcFoxRWJXVUQ3N08zYkRnZEdpZFRDdWFwSFVVZEd6emtJSUJiU1VkYlNF?=
 =?utf-8?B?cElOOTJ0WThOM1MyUWRlRXQyZVNobXo1OHk4ckIyMTczLzdHVEt0R2RtYmFo?=
 =?utf-8?B?OEtuT2J6bUNEK1IvMjBUQ3ZjTGVVYUNyVnZJY1kvVlB3Yi9RRFMrUmIyT3ZJ?=
 =?utf-8?B?QlNrZzd0LytLUW9DejNmdVo2d1pIRW9jNks4bDlqcDU5UXNWb29RaEVtdTda?=
 =?utf-8?B?eWdwK1FsL1luWDRhRFpKakx3ZTRBTUdYdkNrOVhmcnpLcWF1bDZXQmNEeFpm?=
 =?utf-8?B?enZNQnlwelBXT0VvSjVDcmt0eUZ4Z3pDY0JvSEticEdtVEhGS1d5dXpWd3Rv?=
 =?utf-8?B?eHBjQ1VjeHAzNWplWDNnalNJSFFQTEw1dnFHRi9wcVd3b0M4RFdTbm03VU1V?=
 =?utf-8?B?dUZ2eU91ZVIrM2w5Ulg1ZkNSNldaOFR6WTNxaDQ2Q2c0RmJaV0l0dVpWWlNn?=
 =?utf-8?B?cXRvaWR3SzFHUUNEOURNQVpHOW1sOWxucWhmcm53aElPSTF0UzEya2RRRlR5?=
 =?utf-8?B?dE1mdWxwWHNZeUVEeHcvaDV0cVN1c0lnc2NWbFdUcUlhSC9IU0NqVTQ0L2Fh?=
 =?utf-8?B?M0ozWUJNUllFK3VUREM1RkVwZ2x5Z2Noa3VBMHhQQWJGWU5zT2xuclB5SXMv?=
 =?utf-8?B?L01IeGtHREgrcDhLOGJvdE9RaWpxVVZHOTc0STNYS3gyeFJZQXZlTjlOUHZt?=
 =?utf-8?B?OTZRRGRXOFVEbmpWV3FOdzdsNlJoaFZHZVFXRFRMSWQ1TnBzbWkzelBNaHZP?=
 =?utf-8?B?cEpUSWtMQ2M3N0htTUEzWkNTRXBWOUxjd29SVis2M3c1WkZSNnIxRzhUeWFN?=
 =?utf-8?B?MXVBdXkwZjYzdnprMUlLb1hUUHNEcTYvd1JjS3BqTDk4V01rUUZHNGNvWmdK?=
 =?utf-8?B?akk3Mjd6NE9sZ2F6WkhCTVhkUmdWREdqb3EyTHRWTjBZT09sRllzSXcrQjd5?=
 =?utf-8?B?emF1RGZQOXlRdjdIVFZ4N2NkTGYyTldJSUtGbWpnK1hWbUo1KzRJVi84dTFB?=
 =?utf-8?B?UFd4MjlDemRvUzErUmR1b1lFcmhrVXpjNkJlKzlGN0Z1TWwwM0hnTmNPeVdx?=
 =?utf-8?B?UjJ0R3RMaGtRejIzWGMrNnRhMWlKTjBPY0Z4Ylhob2JyTDFxNjNaaEx3VWRz?=
 =?utf-8?B?NWcxZEkxSndHcmZySjBqMy9hTUFWZjVscExkb2Z3WDhnb1ROeFJjYTlFY1FT?=
 =?utf-8?B?OU5QL3UwQTFyVEdHUDNzdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZGIvTFNBSkVySDBMRXZPcXBYWUdHWVZDaFo4NlRUUlFtL25wOFVyNVFnUmYw?=
 =?utf-8?B?TWxqUVpoVEFpeVpxbFNPd0tpUkVvU05Bc3l4TThvYnVhdjhzbGNCbm12UE9K?=
 =?utf-8?B?ZFEwYTZOTHZhY1NoVGo3WW5wejd2VjRGWFM2S2llSVZVdllCbmZkU3RsckJ0?=
 =?utf-8?B?eEJ5SmhFZ3VHVjVPbzlMb0lTS1YvRTlGc0hTeWlSR3pJWUNZd2hFQzdsTklP?=
 =?utf-8?B?U2dzSTNyOTkxZnpGK0lzZUFWMWFMTCt5cW5mcmJDenBMTEdoWkM5eG45ZGxu?=
 =?utf-8?B?ZnlnQTloWWRqMHM2bVA1N3ludCtLVUliM2pqUXlNRXNsLy81ZXlZTFh1SGxK?=
 =?utf-8?B?eWJBYmNvdjRvYXdKR3VlT3lpN1g4eUhHOVQxTHlWb2o0WGVWNzF4WEoyL0Fk?=
 =?utf-8?B?bEpzWEQvL0VaeXBweWF0MVczc0IrcVJhdGNUWGZYQzE1WkIzbXFzaGtQQUxT?=
 =?utf-8?B?eXo3ajVhWUNWNVNZL0oyNU9Kcm5HTXFzOGVRMm92TklhSm5SWkZrcjN0OUE2?=
 =?utf-8?B?UTZXMGFGTEpjRjhhTXJmZ2xqKzlPZHRzQXJBN0RteEtERnBRWE40NFpKSVVH?=
 =?utf-8?B?dTl6VURwVFNqNi9iZ0I3VW5pVFRLRkVOOHJwMTc4WEoxY0h6amZHb1RaeU1S?=
 =?utf-8?B?dmhkdDBvcERUNHBhTzZxOWo5SzdwcXl2bEt3Z3JybFhVaXpzRnVKQ2puekVW?=
 =?utf-8?B?dU9CVHZvZFpaRzg4em9SUHRrQ2VnbVN1U2xZc2RUS2w2VUhjZ3IvSVJ5dGZI?=
 =?utf-8?B?WElZUnMxQ2xZVlF4Vks4Y1N6TjEvWHlMUVRzQ1BQL0VsMEluODlzNFpWVUlU?=
 =?utf-8?B?d2VLVEdPT2JiOVV3eGdUaitTdHkxSVhQdVNwenNVd2Zyek8rUGJSZE0wai9u?=
 =?utf-8?B?WlpNSEsxMUlwVnNXTFdGRCtMQ1Q5NE90MXJHOWN3enl1b2Y2Ry8zNzVqKzVs?=
 =?utf-8?B?dldQQ3Q5d3Vpd0Zhb2l0MEt3bEVpNlpqV0NQWnhla2tqakJmbmx1NFhzaEVa?=
 =?utf-8?B?a2h3MlFCblZ2OWtWelFsNHR0M2RRam1hdVBRNytVK25teU9mczdpNHBUNEpl?=
 =?utf-8?B?UHQ2OWhNL1kyTUI1dUtxclZKMWtSUmZqaVlFUGVmN2loYU0wNDc2ZEVFRlVN?=
 =?utf-8?B?OHRGZkpKTXk0MVRETU14Yk1nNWpXNWVwU0I3eXNVZjFibDdzbWJPbVA5d0Za?=
 =?utf-8?B?T2V3MTdueFYvYlhkZ29yZHpkOEkxYjU3dVNXNmdBa0pkaFVhbTdlaHhOZGZo?=
 =?utf-8?B?S2RJT21oNWUxOHhRU1dBcDk0cFg4bzhmdXhpM2tYNmJKc0ZkK1ZMeE5zbjBq?=
 =?utf-8?B?blV1N1lxS29TZEl2WjRoRk5WR29xY0haSG11L2hZRVdPQnU4TVBlL0xtR1NB?=
 =?utf-8?B?alBId3pCUjI2OEhrdUU4dFpGWlI4NzE3OGJ3aFJVdjdLZ0F1ajllbFF1ZU5a?=
 =?utf-8?B?MHBjSjRCTTVsT0I5QjV3bG44UGt4Nis5VWlmYlo1SGIrWmZwOTA2U1JxSGx1?=
 =?utf-8?B?SHF3MnZzRHFKSU1tZERKK25wQ0tJa0ZVb2Z3SmMxME1vbUxSNlAyUmtnbTBR?=
 =?utf-8?B?Ynk3SVdwUFFmUURlSmxMaWRXMnFhQTNBUTBHYUlFUjFEYmQvSTdmM09XeU52?=
 =?utf-8?B?MXRjY25adTdLMWZpRytUOEVvR3FPLy9TWnh1RGpIMkpxbnJOOHRGT2JtTGUy?=
 =?utf-8?B?anR4elpROVMvMW4rM3BZb3VxbUNoTGFrMHdSR0JCSDRnOHVHQ25tNmNoM2M5?=
 =?utf-8?B?Y1RYazgra1BWWCtiQlFOWldoYnVPRzlkZ25OcEhxeThNUENSVTk3Q1VBZlF4?=
 =?utf-8?B?T0N4cThWSDNZMEdDWUh6alFoTzA3dXFwQWpZZ2hvZXYvZWVqc1FpckxtSWp0?=
 =?utf-8?B?UXp3WUdOWkNMTm9pODg1TVR5RDQ1WnBQVStoeTlySUNBSE5IYXBxdXpwVWl0?=
 =?utf-8?B?QkU2ajB5L0luV2w0K2hrYU4zdWNrQVVqVHpHNjk2ZkNmdjNaM1Q2N2xIZFFJ?=
 =?utf-8?B?TUFnQmZ1VFA1dmtxd2FFdi94MDExeW9hb1JUMVIwZDVBVkg0dGNPZXpaeTdw?=
 =?utf-8?B?c01TODlTaTR5ZGlvMG51aVNwRXFFM0dqOEQ5Q3ZYK2liN0Y4Zys0Y3VLcWNZ?=
 =?utf-8?B?KzJDNE1uOGNJVFJNdURoN0tpcHJJTy9zOVFDNVJnMmRLcTlrNTBMSWNVL0tx?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB7FC69A4AA047469B866B62F44EEBF1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o6pXyFL2hdlm9tYoa0GwC7agEskWa9jFFrfHjFjiDY456M11JwF9U3fffFA2Nz8d3U4W3WQAJjhzHFPb2uGqGCYFiA22QEEDMO8kl8qj1PHx+Hp5ZH65WGhaekWoygJVo+UEnzQQLYwkfl1T7jkWp0MtGIpMTcapd05BXAZ+ppygO9VXIeNJxukabdbVvbNWXzN88cvxfghfmJlK0ssKvjS0Oixa88uEuXkk80P507EeO0zFPMa9aoJU0jRRq/lHW965uxCnPtz5hAs/Q0coCR0nFefts/PbQ9XW9ZC0xN6Alc5ly3+QTu2dIvTMd0chNZuRF/eWOV4To2NzbzYRzXZCeCuo9A55Ei+bETQ6snme8Z1qwWo03MvtXZr5T4rDVhgmj2xa2Ia/pFTYKf4Sy3C4m8gK/iEpTDylzk/PpXV45Tuhz10lf2xa2R4ZZ77vLZZiCdiMSlTsepYEk7Ez+ZaxVyOqCeeZB44z07s+CaftH/16YonfwuhCscvtHStnUn7IAm9KmZE8bNy9a01flyA7wT+g4N9ynu0OpLnQpvGHCAswQd21OiS3PG+dY8rgL/4gdymNdG23ESZUjtsuqg8zMd4+Iazg2wNe6dcdFs80IFUvfNkryMBP7kvrnzVoYnv5EVBCL6sg5dFjSYVw7w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5569f8b-cc78-485e-5fa3-08dc7a82ff07
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 17:17:02.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMerzh3wjdY3JYUba9uXjVrrbP74VgCIQrMWelswGQFVIdu07dQySwGO3MK+U/aFXXdqCrtlLSP5guYJ1yH5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848
X-Proofpoint-ORIG-GUID: 4xcAzSADXvE7j52XLQfSggW3kFZyQyYy
X-Proofpoint-GUID: 4xcAzSADXvE7j52XLQfSggW3kFZyQyYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_09,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxlogscore=636
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405220117

T24gV2VkLCBNYXkgMjIsIDIwMjQsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDIy
LCAyMDI0IGF0IDAxOjQxOjQyQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBX
ZWQsIE1heSAyMiwgMjAyNCwgTWljaGFlbCBHcnplc2NoaWsgd3JvdGU6DQo+ID4gPiBPbiBGcmks
IE1heSAxNywgMjAyNCBhdCAwMTo0NDowNUFNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gPiA+IEZvciBpc29jIGVuZHBvaW50IElOLCB5ZXMuIElmIHRoZSBob3N0IHJlcXVlc3RzIGZv
ciBpc29jIGRhdGEgSU4gd2hpbGUNCj4gPiA+ID4gbm8gVFJCIGlzIHByZXBhcmVkLCB0aGVuIHRo
ZSBjb250cm9sbGVyIHdpbGwgYXV0b21hdGljYWxseSBzZW5kIDAtbGVuZ3RoDQo+ID4gPiA+IHBh
Y2tldCByZXNwb25kLg0KPiA+ID4gDQo+ID4gPiBQZXJmZWN0ISBUaGlzIHdpbGwgaGVscCBhIGxv
dCBhbmQgd2lsbCBtYWtlIGFjdGl2ZSBxdWV1ZWluZyBvZiBvd24NCj4gPiA+IHplcm8tbGVuZ3Ro
IHJlcXVlc3RzIHJ1biB1bm5lY2Vzc2FyeS4NCj4gPiANCj4gPiBZZXMsIGlmIHdlIHJlbHkgb24g
dGhlIGN1cnJlbnQgc3RhcnQvc3RvcCBpc29jIHRyYW5zZmVyIHNjaGVtZSBmb3IgVVZDLA0KPiA+
IHRoZW4gdGhpcyB3aWxsIHdvcmsuDQo+IA0KPiBZb3Ugc2hvdWxkbid0IHJlbHkgb24gdGhpcyBi
ZWhhdmlvci4gIE90aGVyIGRldmljZSBjb250cm9sbGVycyBtaWdodCBub3QgDQo+IGJlaGF2ZSB0
aGlzIHdheTsgdGhleSBtaWdodCBzZW5kIG5vIHBhY2tldCBhdCBhbGwgdG8gdGhlIGhvc3QgKGNh
dXNpbmcgYSANCj4gVVNCIHByb3RvY29sIGVycm9yKSBpbnN0ZWFkIG9mIHNlbmRpbmcgYSB6ZXJv
LWxlbmd0aCBwYWNrZXQuDQoNCkkgYWdyZWUuIFRoZSBkd2MzIGRyaXZlciBoYXMgdGhpcyB3b3Jr
YXJvdW5kIHRvIHNvbWV3aGF0IHdvcmsgd2l0aCB0aGUNClVWQy4gVGhpcyBiZWhhdmlvciBpcyBu
b3Qgc29tZXRoaW5nIHRoZSBjb250cm9sbGVyIGV4cGVjdGVkLCBhbmQgdGhpcw0Kd29ya2Fyb3Vu
ZCBzaG91bGQgbm90IGJlIGEgY29tbW9uIGJlaGF2aW9yIGZvciBkaWZmZXJlbnQgZnVuY3Rpb24N
CmRyaXZlci9wcm90b2NvbC4gU2luY2UgdGhpcyBiZWhhdmlvciB3YXMgYWRkZWQgYSBsb25nIHRp
bWUgYWdvLCBpdCB3aWxsDQpyZW1haW4gdGhlIGRlZmF1bHQgYmVoYXZpb3IgaW4gZHdjMyB0byBh
dm9pZCByZWdyZXNzaW9uIHdpdGggVVZDIChhdA0KbGVhc3QgdW50aWwgdGhlIFVWQyBpcyBjaGFu
Z2VkKS4gSG93ZXZlciwgaXQgd291bGQgYmUgbmljZSBmb3IgVVZDIHRvDQpub3QgcmVseSBvbiB0
aGlzLg0KDQpTaWRlIG5vdGUsIHdoZW4gdGhlIGR3YzMgZHJpdmVyIHJlc2NoZWR1bGVzL3N0YXJ0
cyBpc29jIHRyYW5zZmVyIGFnYWluLA0KdGhlIGZpcnN0IHRyYW5zZmVyIHdpbGwgYmUgc2NoZWR1
bGVkIGdvIG91dCBhdCBzb21lIGZ1dHVyZSBpbnRlcnZhbCBhbmQNCm5vdCB0aGUgbmV4dCBpbW1l
ZGlhdGUgbWljcm9mcmFtZS4gRm9yIFVWQywgaXQgcHJvYmFibHkgd29uJ3QgYmUgYQ0KcHJvYmxl
bSBzaW5jZSBpdCBkb2Vzbid0IHNlZW0gdG8gbmVlZCBkYXRhIGdvaW5nIG91dCBldmVyeSBpbnRl
cnZhbC4NCg0KQlIsDQpUaGluaA0KDQo+IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgaXQgbWF5IG5v
dCBtYWtlIGFueSBkaWZmZXJlbmNlLiAgVGhlIGhvc3QncyBVVkMgDQo+IGRyaXZlciBtb3N0IGxp
a2VseSB3b24ndCBjYXJlIGFib3V0IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gbm8gcGFja2V0IGFu
ZCANCj4gYSAwLWxlbmd0aCBwYWNrZXQuICA6LSkNCj4gDQo+IEFsYW4gU3Rlcm4=

