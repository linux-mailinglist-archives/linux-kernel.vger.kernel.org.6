Return-Path: <linux-kernel+bounces-522626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A603DA3CC97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1908C17202F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48DF25B669;
	Wed, 19 Feb 2025 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gZPIItfs";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QeTQXaxs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JvzjGdk9"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9325A340;
	Wed, 19 Feb 2025 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005033; cv=fail; b=AlYzKSPdzD06B2FJqO6TXVw8jdD2t5n0goF2b7PSxa2SRCbwtUd8MXuP7lzW10JWrSfwftzbQ0+XWXOlHy7lyC6+LuEwRDwQ4JECNqfNWDyxv13XJOyNqjIDP1lxNxbrRulVxdXPaWS5SB/nej1wRBqy29ZssyddyyBA4+tj08M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005033; c=relaxed/simple;
	bh=lGG/bKj5Y4SXw44ipwHbxcVXLu8snsb9BjnwMgzl6k8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eDa0jhKE2KLnF3a0dHFYFwtDixJR7Dyp0yZqXCMWLToocL2N0Apm2FvuYHZm0Ay9T/gAh0gW19zEY180/jZW9MgiTRAKbgzJiQDQk2guyikbhTsJm+T7nlVINdAIumfCPIs9uCNdnT77wDViZLUVAeq6XISCNrfTjFihoRigmTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gZPIItfs; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QeTQXaxs; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=JvzjGdk9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JM8fV6009685;
	Wed, 19 Feb 2025 14:43:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=lGG/bKj5Y4SXw44ipwHbxcVXLu8snsb9BjnwMgzl6k8=; b=
	gZPIItfs77UoK5svHw+0+p9a7ep8X5YRBEUx6VAi5KQyQwx+WGWolmaBeZfscqla
	3Y5VgxTb4X6ubTTFfkYUxzgAxFyYXVdmPmzRj1lEpDcazpS95D9Um3RTfq1nHVDH
	1J0yDtUacTa9Rp6Q3NcVQ4yybzYNw8yeGs72WOHGeqTRHiIVdaNRC3+CGxs7y+33
	T2ExBDnh93mRhFA2bkQMDEaAD8BLxiZtrzzR9qq2a9G7izqjMEypHetgnm2FbJMv
	TPlLI/BxqlCJne0frwO51Q4gGhoYwRKtaTwRDXd9frfdYV2el+/A/Z+Ta4vSEXNK
	ej9yDi3qnquliCNo23/KgQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44w00uqrqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1740005013; bh=lGG/bKj5Y4SXw44ipwHbxcVXLu8snsb9BjnwMgzl6k8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=QeTQXaxsZu9MToeI0mgtAfjkCgGRxkp8sibXSRCP0/TarIOH6y7qsdxdmOMX0n7FI
	 5KQncP1dv3LwRNxOFBKl2a7WVtyvvtXgB8lht3y8gj9rz0THgPWFhatjwRQCgxkLle
	 Lv59hCQ2SjrLK0QdV8OEb5bpIEDHwHJ9akg8hvJPOhN9QkQI26oYuBsqmRxVVcVZxY
	 j7f+/g2hG9yxXOwTsoQH3pTTHfI4dpyMJZzDpsh/4Hy9+UdMSb61DhnJVspfNwwmAR
	 3v+js0m58xXQHrgQmjc+pKkmCHOLrRVxi/BWxlWEvb613PaqLIWKaf0G07l+5bXwbA
	 itG6+tH/H+XWw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EA8CC40351;
	Wed, 19 Feb 2025 22:43:32 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 34670A0063;
	Wed, 19 Feb 2025 22:43:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=JvzjGdk9;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 13A1A4048B;
	Wed, 19 Feb 2025 22:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCHJc61GnWUNctTNkucl1v1gX9WEFo1y61YsdlgomWevhDzdir2kJmdTogQXfEQayrVlcQAOREvo7LGZhp90qNxKLOiQVGyh52OSOAkRagykUI9SjTw4yrosukZ0ecbGhAv4VzIV1TS3jCyiVtTxWecQzk81kcjMo/lkLWEkgEZdb6fdT+vGPuckAIU+fw5jjbiaIgrHqqBqYErEPxMPnNGwe59ck4sFF+J9ZeUjjNP38AFJHlDXm4sdS3Kmgzq6ixEMjC/f+P2heBqQAKvv5ByqztVGFyywXphSAFxcDQWL+LVpu2UlMVb6tkwn22VZcn/bnVZzd6fYnnF9akpj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGG/bKj5Y4SXw44ipwHbxcVXLu8snsb9BjnwMgzl6k8=;
 b=T54Eiv7rSJf3APTBOJT7x8zgPLhUkKQREFFmbr1C7dgft8cDGlMmNtJRqWkMFmbIaT0cSe5guVmN0W5SpRhyxjWDdm4qGzDsMCCNpWqQVFz/0jIyEKiDHJq0DF031g7G8UWR3MEQSQuwnvD/eOLKgKbX1rlgL1lxpq8LxgSTtahbYU5xobsEVY7aO4jlJ4AU7RGgKPjzwiqxYZhK73Oz7claRhV/+WiCyOyo84q2u+YuISHbld1yvcLDzZlob/xoKr9LCvIH72aKHKvvLeU73i+dtFIMt/xsVhyazEHSIXrGfgDFEoKOcdWhk1Q3u8g6vf5HvQPzNU581+XMQf1rLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGG/bKj5Y4SXw44ipwHbxcVXLu8snsb9BjnwMgzl6k8=;
 b=JvzjGdk9e4zxjm6QZ7apm0SokrfbRpqTwwEkDLKAbivItCBQZzCBGDYfZkIAw7e1JinAqiFqULLMzlUME5DrAn9slc33QbVonGYIhIA2ttjupjEUrkJbBpEuFKds1oPQdqjra7dkkG/7F/b1c4Z2HZ/KxWMfDuRO/xMayFmGCDA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 22:43:25 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 22:43:25 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] usb: dwc3: Don't use %pK through printk
Thread-Topic: [PATCH 2/2] usb: dwc3: Don't use %pK through printk
Thread-Index: AQHbgT7Mh5F/BmYdsEiBIZzP7mGum7NPPNeA
Date: Wed, 19 Feb 2025 22:43:25 +0000
Message-ID: <20250219224317.o4usb7flepnvbide@synopsys.com>
References: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
 <20250217-restricted-pointers-usb-v1-2-78da55158832@linutronix.de>
In-Reply-To:
 <20250217-restricted-pointers-usb-v1-2-78da55158832@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB8906:EE_
x-ms-office365-filtering-correlation-id: ff4e5b52-dbe6-4d3e-a9b0-08dd5136d263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVVGRFgzYmNUdVZ0bzRaVlZZekpjOUdFNnlxaFkxNHd4NWxSZnRYakVGMk9m?=
 =?utf-8?B?WStIa0tPQzhOYi9adW1ueUZLaEtjdHM1Z0wvOGZnV2FnaEE4cStNREVBSHQ5?=
 =?utf-8?B?dDVCbDRuVmhnc0ZldjZRVXNNWFp0dkZhSmw2MEhEUisxMnRTNDBkY0tCTk1P?=
 =?utf-8?B?S0NoeGhVbDBZSC9wbjRUbElWNUhQL09nRDU0VFlZSG9VKzREMWh1Y05EZjlB?=
 =?utf-8?B?NDFzc3hJTUxBdFh3aGhTMGRQaStCcFdnOVNhNm5IMGNOSVE4SVJTSjVvZVd2?=
 =?utf-8?B?Z3R3YVN0dFBYREtxclNrN1p0WmNuWXFKQmFTU1RZaDVIekpSMmp0bG5UUEo0?=
 =?utf-8?B?QTY3QSsvVm0ycXBrUGUzUFdNd0lPYTFjVDRtZHQwbE04UUt0NE84SGFuc0RN?=
 =?utf-8?B?UXNLd2RTbnhQRC8wdUg3cmxXT0d2bkJVbXp2Yzc1cFBTd1EwZC9iU3JSNm9N?=
 =?utf-8?B?d05DR2hBSFY2Mm01dkpNWVQ4MTFvV0Z0VTJHUFBiYlVTQURNeDNCSjVta1dl?=
 =?utf-8?B?RW9hbkZlWjdBVUJrdlorb1RzTENhRE1MbHU5QmFQT1Z5REtFYkhLNHVnaHN3?=
 =?utf-8?B?YXhaa0NGMGV5TUxDcmxvTkR1VzhCWFlXcWVPdFloRUw1NU1id0ZURXRrdDRs?=
 =?utf-8?B?N2VRMWdUU2lwUmJyc0RsTXY2Sk9ibm9wMHBUTUZRamxDVkxVTEY4d0RVejVP?=
 =?utf-8?B?U3M5TW5zNzFOeGhEMFRPZzYxNHdlSU9COG96ZDJxRTZ4RVQ0aEFNdERsd2hP?=
 =?utf-8?B?TVN0eXRuaVo1ZlgvWGNReXJzZ0NmNWp5T3lpTFNMY2pIakNNQ1dic0RSVitz?=
 =?utf-8?B?ZldDTDd5OVBvRWVjK2loUkRxT0hMTUtWLzRVTUV0aUdrMUd6RnJtcUhWdFk5?=
 =?utf-8?B?Z3UrYUlnRXhmdGFVdjFreXpDWGh3SldyeFowMVJ0QTAwK1g3T2wvYktIL1I0?=
 =?utf-8?B?OVUwaVNXbnQ2VmhuU3o0OXV2dnpPRHRsWjhJSmdzN1RyenM0aFFaenIvdThh?=
 =?utf-8?B?c1d2a2lMVHZDd01YTWFuRTJZUmlVUGxmS0xQOXppREhzT3ZHdEJWaTQ4SVNj?=
 =?utf-8?B?UStGVXpaRDUxVlRNZkdFcFVTVTVESU1taE1mZkdCUFRnbmt4ZXlZb3U0ZmpZ?=
 =?utf-8?B?bWkvMER0STltSExzb0JFRis3TStWRnYxR1RuK2NXaksxRkpteGlRQUZnbHZo?=
 =?utf-8?B?dFIrNElsZDFDTlBmYmhIQUFoMm15WGs2VUpKaEFITEJibVFEb0J3and0MzVP?=
 =?utf-8?B?RFl1Tk9SVDdQMElGMTVBS0VtWXhEOEd2VFdyTXRVWmlpOFRyZDJTalJUamhx?=
 =?utf-8?B?b3hQaW4vRC8rUy9HWGh0OWtSL3Z0cllQNCs5S0NDVWxoZS9hdy9Qc1Nseng5?=
 =?utf-8?B?Qys1S1pEWUsycHZWYkFwTS9DdVZmOUxpam1hRXBnVFRvQTZZb3lKTkMrUGpU?=
 =?utf-8?B?UklzcEtxQjJBME13TWIySjhjQVUxazEzRG5tRzhDcXA2eWpNWDE0UGZCOGE2?=
 =?utf-8?B?MzhScnNpVitjTGRDUjZGblpXU3g3Sy9ibHVkSnV1bDZ5YnVBMVNBUi9RdU0r?=
 =?utf-8?B?MEFGaGJYb3RTcXdLcFJ5V3JEdGNTbmxXL05yOEZXRHJlSzBtcFFsMXlBSzc3?=
 =?utf-8?B?WUlTbWdkeVFTQ2FkYWZMM3Z2SEp0eWtRNjZXbHYvZ0NDS20vWVJQdE9HRGpZ?=
 =?utf-8?B?Y0VRZG9wUG5ubHYzcHVIQThicm9XMVNQaFIxQk1tQnNza04wNElUYkduenYr?=
 =?utf-8?B?dHc2d2FVektsMG1RR05rVlJ5dFozcHNJL1owc1ZzbDBpc0NRWk14TTJUM20v?=
 =?utf-8?B?bUIwUUtadUp0S0I2M3U2Z1BDZFJqKzF2UkRZWnRoMWJCMHpSNlRQejVWeWwx?=
 =?utf-8?B?b05wc3dEV2loa2FnRHdQSnNUZkdlSXhTaEtrYm1jM3B0QmFCb1k4UWd0VWFv?=
 =?utf-8?Q?kYw7U74KioHCxQhqWHwTLG4Uq/Vdjvyf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2ZkZGpUeEJpQ1BndzExMG9kOEl0TVV5ZVpvaVV0N09ITi9QOTVrbnF1T3Ux?=
 =?utf-8?B?YzduOHlaRlpXQ2lpN0V4aE80eU5nc0NWV3NWU2ZRMjNBOHpOOXp2WFRGekZR?=
 =?utf-8?B?MldSL1d6Syt6WWtaQ0dqWTVrRzNjaEdnUW9NbzlLNEQ4cnN4ZUxsUm5neFRX?=
 =?utf-8?B?SWhQRlY3ak45SWxKd1c1a2NudUYrb3d1ZDhtbTY1R1ZqYjdkZFlZUENJR25S?=
 =?utf-8?B?aUc2aEpGOHhGdzkzQndsNjl1end6TW5HOUtTRlBHTmxHTHJ1RFVuUGIrYWlO?=
 =?utf-8?B?cWNwZGRjWHdpK2pjN3dzVUpiRVRDOWlSTlBxWitEUlZlM2R2VWM4R095eWZC?=
 =?utf-8?B?WE4yVUZ5UXVCVXRqMjgyTkFFMkVWcitEazNqajhZUG1RTDhBcHNnd2RYYUdi?=
 =?utf-8?B?NHhVOTZrQkNGbTlNVHFXbTFoRkd4TEFSRm80WUVxcnhhM3hYUXAwTENTVXN5?=
 =?utf-8?B?cjk4WStqQjRDR0Z0VWJ4TTRCNUp0WjFwOWhocGFHVzZDRHM3R0VLbnp3WHB2?=
 =?utf-8?B?T2NUaDFNbmFkQ3N5TWNOS1VXOTM5cVc5cWVFQUoyWUlaZnFKK21qNlZRYUcv?=
 =?utf-8?B?RENKbzR0TW9zdjFtZG9uVkJqZENuc3BKTjdoVXFoSklBcnk3L0EyZHhOaUU1?=
 =?utf-8?B?OFBWMVJSNWxYMk1EUkdQcEdjSmtiQjZ6aTU5VFlLQmFyalhWM3lZVUJLUFlH?=
 =?utf-8?B?R1NLTHd2UHhLcW5Bb1E0emRBaGpGbExNbDdzODRDbzFSZVhIQno5cXkzRWRO?=
 =?utf-8?B?TXBVdnN3akw2czU3TVFtdDlXRmpVNkVpN2RlZkxtUjZXT21tQU1HSGtEL1RE?=
 =?utf-8?B?L3pKclVPQ0d6aTRCOWMrR1FRU3Jta0dFWlVqYWtBbkVPNVpYbitjNkNacFB1?=
 =?utf-8?B?ejlHNUZwVVBLZkFtQ2lPZzhPc21sa1ZTSGt2dEVQUTVGS3QveVQ0a2dITDRD?=
 =?utf-8?B?NGRzdFpQVXlaalhtNlMzT2k3dHkyZXJOTXBHYU80RUZudm1zWlZjamRmQ3do?=
 =?utf-8?B?MkxWdWJXMU52YnJjeWo5ckpya1p6ZWxRZWpPaVZMZXhXa1FtdjZWK0R6dWVZ?=
 =?utf-8?B?bThKQzk2RXdnb3lsWVNqcmFmUlpYeldiQm1EQVowSXh3WlNIMURpMW9hZWtz?=
 =?utf-8?B?Q05WNkZwbjJmWEVKT0plWE9MaVlsRTBVWmYrbW5lVjhUbkpZcG5xWjJPV2Fo?=
 =?utf-8?B?T0dXVEozOG1iWHBIYllCU2xLYytjaWh6Q2JaVlVHS1VCY01TbzVxbEVkNUFu?=
 =?utf-8?B?RnEyWTJTUVkzTHZ3TmR6R1FiTEp2M2NGcFdDaENTaVNJRmEyL01NSlVPQVAw?=
 =?utf-8?B?NkdoREIrTk1yOEZ5S0RENGUwcE5PVFM1ckFJMmpVcXBCNWZXUkZWTGI3ZFB4?=
 =?utf-8?B?TU5tRkx1MU1WV0RRSHlZeWlsd0JvbS9KL0xTU0dpdmlzS2NCeWZOdnBtUEVq?=
 =?utf-8?B?d2Z1bVphZTBpUG1RaFdzbEpQWDVXSE52dGdtaFRZOFpLdThhaWEwYStjS1Uv?=
 =?utf-8?B?SHpjSVBGYTdiNXFNVWFZcU96Q1NGekY5eVY2Wnh0NUZPU3I5SkdXNmJseDZk?=
 =?utf-8?B?UXJ1MkdxUE1oaENwK1dpOU5QYVpRYUJuUk1PVHd0TXJ3WXRmMjFxRHFBVnJP?=
 =?utf-8?B?eDlocWZGejcrTVhsNzJWRkZ1SUJ0cnhFS09GcUFsVENqaHFvSHhkb1Zobm1G?=
 =?utf-8?B?RUZkNm04a2p0K0lRaUYxaEw1MnRoUDVIVFJNSHo4VVVKZEpQR1BGVm4wdkpZ?=
 =?utf-8?B?S3ZlWDE1UTZWdDIxeUxualVqMGZvSytRYWkrL2lQU3N5eElpNTJxelNHTUlQ?=
 =?utf-8?B?eFovUTRSdXhWQVhUVCtTT3pHc2JqV2Fab0tnSkxZVzVodmk2Sm1reTdOK0tM?=
 =?utf-8?B?VkdNbEpZSFd4TU9DNWV0QlBPemlFS0lSZUxUaGl1bTdPK1U5Ni9jdTRCcys3?=
 =?utf-8?B?ZnE3UTVoajl1QVMyOEdIcHdONFgxdUR3MktxdUFpY0wyd3EwM2MwMit1Ni9J?=
 =?utf-8?B?bmppVmhQdkM2SythUmVRU1JJZjZWdUZSbzdKZ3l3K293NGNXM0J6bXdnbFhx?=
 =?utf-8?B?VGtXbTFrNkkxMG1RV1JpSm1VQVB5TEZMdEVHNTJ3bUNLL3hKRFFDUFRDSW5U?=
 =?utf-8?Q?7lKQUUiKAJTMs5YBVfNw6rwl4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <391519F82CAC204783F50CFECA6CF5FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2YQp9zCK5gR5zVz/KLSI7HEEvkicRmE7yEqsDi30ITxGrBHh+QKv6FgrNhUHvOuPkjKZAzUpHOKkW10oINHLx/HY5DO87Vko4UEk9CT8/Ty+RekIyE5iWhgHRrGu1J71wBwpfSw0d4aqPU9H3a4Ccn5vyzQuecBUVGSNaFIDdlzdSLugHMgK9OlpMKZIX2n+Glzcm0/HwgQBk1u1L8Z7JpYnTpCbMHChfZLP9tjEeNMLBSBwufX2sL8dCYKA6IkPTT6T7py8wdCD2Y80hPZ7mgiG6dBuH8bPGEyudnoZevJ+N1W/1Fd+XhHJVd1+7GcXG0445QQn4Rooi9UpmYen1I84M3liVwcSRL88w8NiYa8ogmYVU72OFaZ5uxIG3vLOBfuFYXsoeu+qQDZFN7BTKN3VIVCmGeT1dHFmQLuLCqf5gVt9Cmy9YN600UZPIAZCHm7aXGzizgYwtlySwj32RydAIEYjoko6RLShJohG6NxvWLyy4TCWk4aqqNnchMKNbv6r+8XkpA7vQRMYL3uqRY/sy7oRAad0qt/4b3egeHwPqGhiGQpIQJDW3O4/tQRdrOwi9COhMcr3z6rnd77r6sjnSuWm/N1bIhDftV9BJVcKaEPCaGHihYiw3hSYB2p8ugBvtVx9xhoqMY4MiwJzXQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4e5b52-dbe6-4d3e-a9b0-08dd5136d263
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 22:43:25.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TiRltaOd8G8cDhQB3VG7YbMcbm/J9B62gGU3JWXtT/rimA3ZHSUV4tRir//8US0yk7Reou3vaDImGDF7FCVD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
X-Proofpoint-ORIG-GUID: mEWkIVwqs2HiORVEQf8nz5bEF6mi9VvJ
X-Authority-Analysis: v=2.4 cv=TIq/S0la c=1 sm=1 tr=0 ts=67b65e95 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=javlGa28A10A:10
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=D69x2IRuepVTDY0TylQA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: mEWkIVwqs2HiORVEQf8nz5bEF6mi9VvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_10,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=973 clxscore=1011 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190166

T24gTW9uLCBGZWIgMTcsIDIwMjUsIFRob21hcyBXZWnDn3NjaHVoIHdyb3RlOg0KPiBSZXN0cmlj
dGVkIHBvaW50ZXJzICgiJXBLIikgYXJlIG5vdCBtZWFudCB0byBiZSB1c2VkIHRocm91Z2ggcHJp
bnRrKCkuDQo+IEl0IGNhbiB1bmludGVudGlvbmFsbHkgZXhwb3NlIHNlY3VyaXR5IHNlbnNpdGl2
ZSwgcmF3IHBvaW50ZXIgdmFsdWVzLg0KPiANCj4gVXNlIHJlZ3VsYXIgcG9pbnRlciBmb3JtYXR0
aW5nIGluc3RlYWQuDQo+IA0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1MDExMzE3MTczMS1kYzEwZTNjMS1kYTY0LTRh
ZjAtYjc2Ny03YzcwNzA0NjgwMjNAbGludXRyb25peC5kZS9fXzshIUE0RjJSOUdfcGchYUw2MzQw
SkVqb2lTeTdncllCRTlDN2tpdE4zbFI3QnNINHpXU2tZNlFLUENyQ19TREJQSUw4clphb0lYeEFC
QWRJUnNFQzJZUElfQXRDVTl0TXJEMWJ5T1hlWjkzWXB5d2ZBRkx3JCANCj4gU2lnbmVkLW9mZi1i
eTogVGhvbWFzIFdlacOfc2NodWggPHRob21hcy53ZWlzc3NjaHVoQGxpbnV0cm9uaXguZGU+DQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXN0LmMgfCAyICstDQo+ICBkcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jICB8IDYgKysrLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtc3QuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1zdC5jDQo+IGluZGV4IGVmN2M0
MzAwODk0NmUxNWI3MmQ4OGFiYTQ5NDFkYzUyYmYwNzg4ZDcuLjVkNTEzZGVjYWFjZDIyZGUxNTgy
NWRjMDYxYzI3NDdjZjA5ZmVmMDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1zdC5jDQo+IEBAIC0yMjUsNyAr
MjI1LDcgQEAgc3RhdGljIGludCBzdF9kd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICANCj4gIAlkd2MzX2RhdGEtPnN5c2NmZ19yZWdfb2ZmID0gcmVzLT5zdGFydDsN
Cj4gIA0KPiAtCWRldl92ZGJnKGRldiwgImdsdWUtbG9naWMgYWRkciAweCVwSywgc3lzY2ZnLXJl
ZyBvZmZzZXQgMHgleFxuIiwNCj4gKwlkZXZfdmRiZyhkZXYsICJnbHVlLWxvZ2ljIGFkZHIgMHgl
cCwgc3lzY2ZnLXJlZyBvZmZzZXQgMHgleFxuIiwNCj4gIAkJIGR3YzNfZGF0YS0+Z2x1ZV9iYXNl
LCBkd2MzX2RhdGEtPnN5c2NmZ19yZWdfb2ZmKTsNCj4gIA0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqY2hpbGQgX19mcmVlKGRldmljZV9ub2RlKSA9IG9mX2dldF9jb21wYXRpYmxlX2NoaWxkKG5v
ZGUsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBkZGQ2YjJjZTU3MTA3Y2I2MmM1Y2VjMDJlYWUzZmUz
NTI0MTY0NDY5Li43ZWExZGNkMDdmMDI5OTljOTEzZjE1MjBlYzA1YmJjZjFhNDNkOGQ1IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTE5NzEsMTIgKzE5NzEsMTIgQEAgc3RhdGljIGludCBfX2R3
YzNfZ2FkZ2V0X2VwX3F1ZXVlKHN0cnVjdCBkd2MzX2VwICpkZXAsIHN0cnVjdCBkd2MzX3JlcXVl
c3QgKnJlcSkNCj4gIAkJcmV0dXJuIC1FU0hVVERPV047DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKFdB
Uk4ocmVxLT5kZXAgIT0gZGVwLCAicmVxdWVzdCAlcEsgYmVsb25ncyB0byAnJXMnXG4iLA0KPiAr
CWlmIChXQVJOKHJlcS0+ZGVwICE9IGRlcCwgInJlcXVlc3QgJXAgYmVsb25ncyB0byAnJXMnXG4i
LA0KPiAgCQkJCSZyZXEtPnJlcXVlc3QsIHJlcS0+ZGVwLT5uYW1lKSkNCj4gIAkJcmV0dXJuIC1F
SU5WQUw7DQo+ICANCj4gIAlpZiAoV0FSTihyZXEtPnN0YXR1cyA8IERXQzNfUkVRVUVTVF9TVEFU
VVNfQ09NUExFVEVELA0KPiAtCQkJCSIlczogcmVxdWVzdCAlcEsgYWxyZWFkeSBpbiBmbGlnaHRc
biIsDQo+ICsJCQkJIiVzOiByZXF1ZXN0ICVwIGFscmVhZHkgaW4gZmxpZ2h0XG4iLA0KPiAgCQkJ
CWRlcC0+bmFtZSwgJnJlcS0+cmVxdWVzdCkpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+
IEBAIC0yMTY1LDcgKzIxNjUsNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2VwX2RlcXVldWUo
c3RydWN0IHVzYl9lcCAqZXAsDQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gLQlkZXZfZXJyKGR3Yy0+
ZGV2LCAicmVxdWVzdCAlcEsgd2FzIG5vdCBxdWV1ZWQgdG8gJXNcbiIsDQo+ICsJZGV2X2Vycihk
d2MtPmRldiwgInJlcXVlc3QgJXAgd2FzIG5vdCBxdWV1ZWQgdG8gJXNcbiIsDQo+ICAJCXJlcXVl
c3QsIGVwLT5uYW1lKTsNCj4gIAlyZXQgPSAtRUlOVkFMOw0KPiAgb3V0Og0KPiANCj4gLS0gDQo+
IDIuNDguMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9w
c3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

