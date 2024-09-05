Return-Path: <linux-kernel+bounces-317853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE596E487
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CAB284690
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845911A727E;
	Thu,  5 Sep 2024 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aIoxNqID";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W7KGRMpO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XAGuemle"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660D18A6B0;
	Thu,  5 Sep 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569974; cv=fail; b=CxH9mTYlKs1VuLW4tbKfjRdVjmokX5qgBATBu+CdW3raIxA5GdltNQgu60yVJ8PB0tfDqHasvJTm7Gg19RRA1Kuqeks+3BvA4b+XYksSy8JaPSBmikWHN+7bioBcEQvvynixuR5zYbHS1BFMLo5oV7zVVZ5xoxZRdEf9i+OK6kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569974; c=relaxed/simple;
	bh=MfOOkO7GVVw2isViYp7n47/zdgEqxIBUVf310cYxElc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cDpbyXFY3Z6LgZzhsB6nfVZbpkOnEYh6IgqVOznAAzWbqVKntMF1yaMyF5XsYruTHCBqfy/TlDBi5Uu6hVfQY5SwcOPX/GgHwdLHvKaTy4AUiYV0zyX1od0C3nIivuIN06hVb8gg/pAHXaiZTOT9V0HpRSDKlqHrbsW1pjQTQQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aIoxNqID; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W7KGRMpO; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XAGuemle reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485KqDUo030040;
	Thu, 5 Sep 2024 13:59:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=MfOOkO7GVVw2isViYp7n47/zdgEqxIBUVf310cYxElc=; b=
	aIoxNqIDbVGssyj7Sez7wyXZJxPf+iRVddd56tWOkM0x4wTvULGXb61YjB8Ay4ZZ
	Na5XuC2jSXDbqhhouWasKUIR8pJ/VwKs/G0s26WtrHAvKebZiOC8yxBdXevgwls4
	Q+GgOoQ91iD0jmnWckns7SdStidgzXlcfqS2DhKdyCGZ73o0WyvzfdzG83HUhNNp
	Gr5z76nQcjVwP1kNplSou4lo10sEjoHZnsK8LStg6Xhs5wRNWztY6HCdyVrsPE/6
	cDfzwJefXFHQFLK4wcJyhX6ZkBPE23UmnN7bKTHnuLiPOxT34+cmFmR2BU5bRMmZ
	Xl6cax633CAlqvYTydPsFw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 41fhxt8np8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725569944; bh=MfOOkO7GVVw2isViYp7n47/zdgEqxIBUVf310cYxElc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=W7KGRMpOLZFpemLqqVQVmXkbzE8zMBVt4RqziJ3pEcAEOZhd+MO0BBx3yjNy3BQpI
	 DuqPDAG0t6omYqkVOECEdNrByPQQbU4lhWPxgNYiY4tsvwXzB/XSJyTo2QplFCaIv/
	 0xcHWTFA7TA+MB7F89E550bQsTHMbjaHliUpclMzD+upREhwFo59K27eY46ev+kZeR
	 vAzjkjQqgkQLciRhlsDZtK+urixVPFrmqAsGoAMUhb1IGeDthb8AW23JkVFJkap6Sl
	 yr1RZqE4R1azMOrd9auvJX8tXDdr+kRcPGju4v+tc9TIDXROlKgO4jLEwPsIITE8JG
	 hADHopf9tXt+Q==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 689A940147;
	Thu,  5 Sep 2024 20:59:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id EC78BA007B;
	Thu,  5 Sep 2024 20:59:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XAGuemle;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A1C6640218;
	Thu,  5 Sep 2024 20:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQrhI54wjON9VuIePm2LWjhaUM+cQhNikXvZrmqPMMd0SVAET0ZZi/foPxFCItxE3l/clXHUSEWsCJSFYfFwVcv5I0+rUCTYTgs6OnJaPmakusnJbq4WDF80HN2roXJSgdcUri7/sNszAxpRKhEdTFluvG+zRf4zrEcDsL5T86JbD3SUvLYmskvZYFxeyBos2A7aiLt070TrD7cBZwXgJu3czjLw8AbxUd+mhpP/a4GyTkStuRlL9uxfpGFBXD4n0zO4qBU02b50UiWprqZot3JdcQqe78+KiVWp2mTXiDQAT0bEMfK6WbCymYqmmzBdG/20IdOWKVbjHLv3aAWkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfOOkO7GVVw2isViYp7n47/zdgEqxIBUVf310cYxElc=;
 b=W9H1d2BblxTeNCwAXOQb6YQrRlRbMT83zAr/cVrVj+f41QNisCA6yFetwakzoM9hIASmnjqPE+urJ6NSQM8BpZaP9la2fWvegi9z0a7YADqvl0RcZAzNipsDiKD58DY8UY3Rh7TTvp7s4uwj6lSNzk6zPwaqcbyENLUyHepw8z8Olb/wQo4Hv8h1WCzScHnOzfdiDcE7QCMubsITj1xjD9Uwh3uL0KMv4A4zjBPI4S24n7SJ6h/SjzHUGKOw2YR0Kb4Do18wEWc1CsuKGmdlJLHIA6D3IyHERzJbgRCoqk2gRB8tNXXIH1VaxQlSrawmTwcoAD4VNx9b6UK0vDZLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfOOkO7GVVw2isViYp7n47/zdgEqxIBUVf310cYxElc=;
 b=XAGuemlehuFxST2lq2LAmU4MXZei47e7PAdPzUuabG5OK11c/PFb1NsJZvQJ03pZ89QSlac+3CBdFyUfA6EodgsWk0j3nlhU30+YLOFvQPkLmkciZKbARqwQkNKEqS19R2cX2fAEA6H+XyPPix5YUzeyvTkH/Ak9pwaNIp9kxcg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 20:58:56 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:58:55 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH v4 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Thread-Topic: [PATCH v4 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Thread-Index: AQHa/88kD/UusB/CpUOCl7n0brpVLLJJrTIA
Date: Thu, 5 Sep 2024 20:58:55 +0000
Message-ID: <20240905205850.jsq25jlws2k75sq4@synopsys.com>
References: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
 <20240905-dwc-mp-v4-2-aedaeacf0556@nxp.com>
In-Reply-To: <20240905-dwc-mp-v4-2-aedaeacf0556@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB8594:EE_
x-ms-office365-filtering-correlation-id: 46a01be7-01ff-440b-f1c6-08dccded8e3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2pXV3Z5T3F5c1htQnlYd2lSbkk0TnB6YUN1QWR2VTl6WGVGWHZqZUVOM28z?=
 =?utf-8?B?enl2TkpnQXpWaXBwMk9mV2EwdWlwc05UTzB0a0tST0h3U0dQT1R0UWJYWVAw?=
 =?utf-8?B?MHd0amh4VUF5NmIxTitwcFVNSGx6S2RNc1FVOGlyM28xVlJHeEtXdTduMStW?=
 =?utf-8?B?d0pMVm5lN1BrN29NOVUvWllkVlRJN2NXU1JlZ1dnSU4rdGlnYUhNMm1tLzUz?=
 =?utf-8?B?SWJlOStVbDVDZjdwd0VIWVd1enB6cnFRUjViRmF0KytSUis3S2J0dnUyNFFh?=
 =?utf-8?B?SHVMb3BVdVhBbHVYMk1wMDFRY2srV3BpOVhnckNiNU84cFJqVlFvVTM0U1Ba?=
 =?utf-8?B?Y05GOE9sSldiY3cvWjdZZU9OMFhIN0VLNXBVanJXU2ppcHoxcTJaaTEyZjRU?=
 =?utf-8?B?RU5xN2M1UE53TW8zMlcyeWdRYUlWVVhVUnBVUmhWVXRXQUNLY2k4RWhxelkr?=
 =?utf-8?B?YXZyb0tOYlFySVBxU2t3aDAyYnR3Q0JBN3NLZitTV0VoRzQxQ3NOOFRwT05K?=
 =?utf-8?B?QUdjMlRPcFozNWdJb1dlZ0F4YVJlMmdGNlYzanJoZjR4WjlsUkI4aWI3eHR6?=
 =?utf-8?B?dkpRN0lncGRyTVpGNmJlMGROZDFETkhncGFtN3RKNC94RVZZT0RIbm02L01D?=
 =?utf-8?B?L1NmaUtCR3AvQjBGV3prM0hteTdPTnpuWVkxcXFKVW5PK2VqeDkweC82QVRC?=
 =?utf-8?B?WE1ieUpRcms3MTNWTVhBbkxITDdGZU9KdVBsQXBwMzdxK2dEUWVraEtXajVl?=
 =?utf-8?B?Q1FTc1piNU54bjhyc05uUmh6SThmR3lVUCtxK3NZbm1DOWp2U1hTUWFpa0pL?=
 =?utf-8?B?QWNzQkU3TFdXNm8vRFlEb0NRVlMwYWpKZlh1aElGOWpMSjhlMkpKemJKcVUr?=
 =?utf-8?B?b2Y3Y1pnWjE3UUdiem1xUGRZYkNXNi82dFlqeE9HZndFdWQ1ZUdiZytwcXNT?=
 =?utf-8?B?L3lucm9WSXgrVmxvN0FIOWZvS3VvLzdZNWZZT0dhclFaQkRaL0FZM3FEVzA1?=
 =?utf-8?B?d2tUNHNvcDVTMWZGZjNHOTZoQmZLUlcrTytZQlZSMUVlbGFoS3pyTDludkhm?=
 =?utf-8?B?RkYzeEZJUVdEb3pPbCttYVkzNnRESDJkOGtSa29zU0t0S3BST3JNUExQQkZk?=
 =?utf-8?B?OWVENlg5Wi9HSFNnMkxEZEpkSkVQU293QTdJQllBY0c3bUZGOS9uOVZ3SjFJ?=
 =?utf-8?B?ZUZZcldQbGxhbEZFWGkxNkNsRkJmSllqODR5YU95Vkp3L00rQkhWR1B2dlNZ?=
 =?utf-8?B?TUMwMWZEWlAwUjFhUXRoM2kzSjlXcHBEZ3dlV0dkSGRObm9tQW50R0R6WXVt?=
 =?utf-8?B?YS85MERBbjhBazZ2alE5eFRxV0crN3FQRDdLVHNFSDZkR1RZZ1M5ZUtYd01u?=
 =?utf-8?B?Q1oyZ1NzazQxNE5mamM0QmRyRkFJem9lSUhPTzdUdVk5VTBxVUtOeHNYWTFj?=
 =?utf-8?B?cFlOcGpyTjFTYnN3eFVPUzFjUnFKcDFHYVVMVW1kTHM2clRsZC9HaFg0eTMx?=
 =?utf-8?B?QWlmVERxb1lSalQ3VU80U1hMQkFPUE5rT0Fkc2NmT09jSmRKZ1ZPQ3Jpbk5Z?=
 =?utf-8?B?SnBLcHVaSlVBWHZNc0RCNklLaHBwSmhUU05OcCt2L2tXRjN6anRGN2lOQThI?=
 =?utf-8?B?c1VxRFRBdWQxU2xSU0UvWWlJNUZzaGI2Nis5cG9iSUlOSEZNZHpTSzVNV0hU?=
 =?utf-8?B?Y29BNjdhV2VqWlM3U3RKbEd0SGRmK0UyREJ6QytmNktjbS9pK3FLc0poTExM?=
 =?utf-8?B?L1RLTXM0Q1BIenJJZktJbmFRS1ZrQTg2OElEZHNYdHo2bnluRU5MbC94eU5y?=
 =?utf-8?B?TGpRRWJtRzRxOXI4YzF5TzBudkc2NW5ndnlQYjRDN0kvcHZLMFpJdTRHVXJE?=
 =?utf-8?B?N2haVUVkalhJMUY2Tld3SzNjakpyVUV1Z1l0RVM3b3dMT3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aE5jeHJXQVF4R2NRYjRFYUFyN3dYTWpXcThtamVNZGxoNmZIU1Q5TTVBU0E0?=
 =?utf-8?B?Y0dCRG00ZFRCQjEyZWN5S25EZ2FRRVY1eTllT1dkdU0wM2VCYXhLTVZLeUEx?=
 =?utf-8?B?L2FiYjlScHV0WnlNY3QzTnAvVGE1UXBQUHVNSlFXMndRMUxid1F1RytsanVr?=
 =?utf-8?B?b3I3YkNyVkpNWGU2eGtDWWZoL3JPYmlkNVpoQmZYamNBRCtZL01kdmROUTc3?=
 =?utf-8?B?NTRCWDNEcjBYTWxXY3R6bXBRVUk2ZldZV2pWSC9zaGN0RHlDNjFaTXZQOVU1?=
 =?utf-8?B?aEc3VS9UK2VjL3QvT0xsTTZGVmF4VFlqOUc3NnZJcUlUREQvalJIUW9zVjJJ?=
 =?utf-8?B?UUJYVkx0NkxTTnd5YWV6VnJ6emE4L0V4RTI4Z3h2d2hPYXBXcTJvN2loVnkz?=
 =?utf-8?B?dnRRYzZ2VDIydG9tQnJUSUc4c0xrZk5GTElPenZsMmFQVTBxaW1lY0grRlBr?=
 =?utf-8?B?UjNsUUFySWxhOURLakZ1bm92aGFYZ3JPRjZ3MlpNaVdLU0R6N2ZJaVlrK1VO?=
 =?utf-8?B?allwQnJpekdhSEh1NWRHaGUwT01QYUNqbjlOamgwNFZUQVBvODB3a1o2KzFU?=
 =?utf-8?B?TjV4NlJ6Wm1VMkIvVm1BNUY2RUFFSjR4SWVUcUdQRXNPWXhMVE5zbEI5dkxI?=
 =?utf-8?B?Qk94WlZnRUZzMW9xUlQzWmxpdllHWjU3SDQxNVZGZGFSdHFiWEUxS0xEcHk2?=
 =?utf-8?B?cHp6WTdiWnpnUCthMXB1WHVyVzExZHBwYy9SNkwzbURnSU12Q2V3WW5JQ0d1?=
 =?utf-8?B?a09uVi9YR28yd2tEUEc1SGJ3TmE0THBDWGEySDNaYk9yaFZObVFqUGptL3dq?=
 =?utf-8?B?b3RLNXcxZ2RZZDZ3YU9qMGk0Tjgwdm9UVlRhb0pwaTVvUWNrOCs0THNVbUxm?=
 =?utf-8?B?MUdUeEllVXljUmtEWFpYYlYvTlIyNzhnZzJ4V29mVlUyYkxiZTczUzQ0K0Js?=
 =?utf-8?B?aHZxRDlZbStLU3NrVDhRV2g4L2Zrak9KVWhjaldpMEsxeG9xTThNWW45L1hh?=
 =?utf-8?B?S3F0eUhWeGYzWW42Sk1HYzdhOGFzcndPYkd3ZkxoM3Y2YXZZR0pFSG91TE53?=
 =?utf-8?B?SCtzMGxKc010LzdXbFdWc2hvcjU0bWpOSzRwSHpONVNzcjA4VStCc09WVXZm?=
 =?utf-8?B?WFZ5ME0xbnJ5VkJlYURFN2ZGeFFGbkMra25uMVNRa0ZBcmg3QUpUOVpjMExs?=
 =?utf-8?B?VGl3RVBzakxkZk83OVkydG5GbWpmS2Z5WkVRQmttTEwvM015V0VqOXdrYytP?=
 =?utf-8?B?VU95OU9reTU4M1ErSlpQUXhEbjV4Tm41VmVjQTFldWtNZ0Raa2lBdE1hSzVC?=
 =?utf-8?B?UlpSN3Z4a05xWTZVYkpKV1AzY2g0Y3Y1c1Z2MU9kT0YwN2E0RTVsMWM3aDZz?=
 =?utf-8?B?eXJTQ1Y1bGM5bjlvSCtnaWZ3Sk4yS041ZjJtQlRJM3gxU0M2TTFhQTVuVHZE?=
 =?utf-8?B?Z0NzdUhyb1RBNEptVkNyRUEwVWFQU3YySWFuMWtMM2xZL1BTbVpzRjVBbWRJ?=
 =?utf-8?B?YmN2WkNZTk1jSkcyN0xwUzlpZEFjYXFhcndxSjh6cFVvZGJGL2ZNdDZMR0c4?=
 =?utf-8?B?QnY1aHJDL1MyZGtZZ2p6U3dsSkpTMWhuS0pwVDcyQkIzVUQ0bEZ6M29CdXB4?=
 =?utf-8?B?QVpiRGEraVZOU1NRMmYwbTJHNldndnVrdnhLVFFsSjFmamxreWIwOGM2NWJ3?=
 =?utf-8?B?VTdTazJvZFlCVk5idGhaSWM5dmh0YnpNL0VjWm1OT1BRQVcyMDF5VkpxVmRP?=
 =?utf-8?B?ZG9FYmlWYW5kQmREZkV2UEpmTkRCSTZHUnNrK2hEUGlpS1M3OStMYy9DbEY0?=
 =?utf-8?B?UnAxdy8wWWtmYW8yd0FIVTVtL2M4T0QzYVp3ZnFqb1M2UFdZOElJRnpNNXpG?=
 =?utf-8?B?L0JITVR6RTJUQjRlSzdPWWdzQ1BFNmRrSTJqeFE2L2NTOTRuNXowdWRvOFdu?=
 =?utf-8?B?eGI3Ni80STM1SGVNSjdBZnJEY2JqR3VHaWtoT0VPMG9FUm91R1F3ZG5ib25n?=
 =?utf-8?B?TUJSQUFRcGVMSWRLUi9UQWdTMDdaU09nckhQTW1GUVVVZmQwa2h6RFp2RWMv?=
 =?utf-8?B?RWxPVmNiTmdXdVVHbkJTUFVTNktkQ2hDNDJUdWpCZlIzaE1Yenc1NlBMNkg0?=
 =?utf-8?Q?XXgwgjBvxPMvesh519wHEdHDB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5789563DB547AD4F89B6E7F1648EA077@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HBmN9q2NGc0ppZAlS3rh69fcgbWQwla9QtqTCXoTPX4OdWYRwOH8GQ1k5fxonL6rQNeFPrM15/1sZX7eEp25C8pBke+jc9RRFuX0UecCgwXziUYWNsVwUuH7afPEwrswnGJjiYIokVlu6bgDZYXMrOnpYE4wdTFEKrMDjiu9vob2HsNRNUrwtE9FAqCEwl8E+JAS3R5831e0jVilGdoeZcnKE/H30Z4HVJSKqz/urooQWzgXFCuL3xZEmtqq19TZADgl6jrlGHXKc0qdy02gvducdmEXd0DthWnK68692CT79aMpc5pl1G6POzMhl8F6yICLhzZM5DBhD3sryyVyofAv6r5mHEpmGLq2WEXisx/h5kpW/DVjfevw2XTIoSlx/UMMns9OokUxDE4B3o1GS8DIzCc7gO4UhBG4nVB6YxgD3285toQkZaHlco9wOPo9OAKMv6ZOBz5AQhYEMtHPJby7xeWUfZh5z2iI58fyye6APFa7Oa/1QBRzBOSyRNay5bHQzPkKAptdB9+0C9apiEjNx0OXWRf7Trf74rO8/u/uZ6x9wa4exyl7cY8oqREtXgniFLar1ZDWdkyQeW4lahfOI4MAyePmUlBgOmSEGTyRXP+pzNBP8o90gpJfuYLGRX9TzcKE5dfcZxSj2oLfuQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a01be7-01ff-440b-f1c6-08dccded8e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 20:58:55.6990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH1n7/sY50s9Xq1Dx2/VHnco1TR5KXs1cLnF+ndrsEnFgulzgosCvOhy+ox5bP0CZZLemiMZO/a34b2ECvK2SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594
X-Authority-Analysis: v=2.4 cv=H/mJwPYi c=1 sm=1 tr=0 ts=66da1b99 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=jIQo8A4GAAAA:8 a=8AirrxEcAAAA:8 a=PweFDGKkJR9sYum1GUsA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: hR-sXhCEyv5wIkwQbjl7xRDNjk11o8Lk
X-Proofpoint-GUID: hR-sXhCEyv5wIkwQbjl7xRDNjk11o8Lk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_16,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409050156

T24gVGh1LCBTZXAgMDUsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBBZGQgMiBzb2Z0d2FyZSBt
YW5hZ2UgcXVpcmsgcHJvcGVydGllcyAoeGhjaS1taXNzaW5nLWNhcy1xdWlyayBhbmQNCj4geGhj
aS1za2lwLXBoeS1pbml0LXF1aXJrKSBmb3IgeGhjaSBob3N0Lg0KPiANCj4gZHdjMyBkcml2ZXIg
aGF2ZSBQSFkgbWFuYWdlbWVudCB0byBjb3ZlciBib3RoIGRldmljZSBhbmQgaG9zdCBtb2RlLCBz
byBhZGQNCj4geGhjaS1za2lwLXBoeS1pbml0LXF1aXJrIHRvIHNraXAgUEhZIG1hbmFnZW1lbnQg
ZnJvbSBIQ0QgY29yZS4NCj4gDQo+IENvbGQgQXR0YWNoIFN0YXR1cyAoQ0FTKSBiaXQgY2FuJ3Qg
YmUgc2V0IGF0IGkuTVg4TVAgYWZ0ZXIgcmVzdW1lIGZyb20NCj4gc3VzcGVuZCBzdGF0ZS4gU28g
c2V0IHhoY2ktbWlzc2luZy1jYXMtcXVpcmsuDQo+IA0KPiBBY2tlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8
RnJhbmsuTGlAbnhwLmNvbT4NCj4gLS0tDQoNCllvdSdyZSBtaXNzaW5nIGNoYW5nZXMgZnJvbSB2
MyB0byB2NA0KDQo+IENoYW5nZSBmcm9tIHYyIHRvIHYzDQo+IC0gcmV3b3JrIGNvbW1pdCBtZXNz
YWdlIHRvIGRlc2NyaXB0IHdoeSBuZWVkIHNldCBxdWlyay4NCj4gDQo+IENoYW5nZSBmcm9tIHYx
IHRvIHYyDQo+IC0gdXNlIHswfQ0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1pbXg4
bXAuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LWlteDhtcC5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWlteDhtcC5jDQo+IGluZGV4IDhiODg2
NDliNTY5ZmUuLmY2MmY2Zjk2MGU1MDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1pbXg4bXAuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1wLmMNCj4g
QEAgLTE0NSw2ICsxNDUsMTcgQEAgc3RhdGljIGlycXJldHVybl90IGR3YzNfaW14OG1wX2ludGVy
cnVwdChpbnQgaXJxLCB2b2lkICpfZHdjM19pbXgpDQo+ICAJcmV0dXJuIElSUV9IQU5ETEVEOw0K
PiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50IGR3YzNfaW14OG1wX3NldF9zb2Z0d2FyZV9ub2RlKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgcHJvcGVydHlfZW50cnkgcHJvcHNb
M10gPSB7IDAgfTsNCj4gKwlpbnQgcHJvcF9pZHggPSAwOw0KPiArDQo+ICsJcHJvcHNbcHJvcF9p
ZHgrK10gPSBQUk9QRVJUWV9FTlRSWV9CT09MKCJ4aGNpLW1pc3NpbmctY2FzLXF1aXJrIik7DQo+
ICsJcHJvcHNbcHJvcF9pZHgrK10gPSBQUk9QRVJUWV9FTlRSWV9CT09MKCJ4aGNpLXNraXAtcGh5
LWluaXQtcXVpcmsiKTsNCj4gKw0KPiArCXJldHVybiBkZXZpY2VfY3JlYXRlX21hbmFnZWRfc29m
dHdhcmVfbm9kZShkZXYsIHByb3BzLCBOVUxMKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBk
d2MzX2lteDhtcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAg
CXN0cnVjdCBkZXZpY2UJCSpkZXYgPSAmcGRldi0+ZGV2Ow0KPiBAQCAtMjA3LDYgKzIxOCwyMCBA
QCBzdGF0aWMgaW50IGR3YzNfaW14OG1wX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAJaWYgKGVyciA8IDApDQo+ICAJCWdvdG8gZGlzYWJsZV9ycG07DQo+ICANCj4gKwlk
d2MzX25wID0gb2ZfZ2V0X2NvbXBhdGlibGVfY2hpbGQobm9kZSwgInNucHMsZHdjMyIpOw0KPiAr
CWlmICghZHdjM19ucCkgew0KPiArCQllcnIgPSAtRU5PREVWOw0KPiArCQlkZXZfZXJyKGRldiwg
ImZhaWxlZCB0byBmaW5kIGR3YzMgY29yZSBjaGlsZFxuIik7DQo+ICsJCWdvdG8gZGlzYWJsZV9y
cG07DQo+ICsJfQ0KDQpUaGlzIGxvb2tzIHZlcnkgZGlmZmVyZW50IHRoYW4gdGhlIHByZXZpb3Vz
IHZlcnNpb24uIERpZCB5b3UgcmV2aWV3IHRoZQ0KY2hhbmdlIGJlZm9yZSByZWJhc2U/IFdlIHNo
b3VsZCBhbHJlYWR5IGRvIG9mX2dldF9jb21wYXRpYmxlX2NoaWxkKCkgYQ0KZmV3IGxpbmVzIGFi
b3ZlLg0KDQo+ICsNCj4gKwllcnIgPSBkd2MzX2lteDhtcF9zZXRfc29mdHdhcmVfbm9kZShkZXYp
Ow0KPiArCWlmIChlcnIpIHsNCj4gKwkJZXJyID0gLUVOT0RFVjsNCj4gKwkJZGV2X2VycihkZXYs
ICJmYWlsZWQgdG8gY3JlYXRlIHNvZnR3YXJlIG5vZGVcbiIpOw0KPiArCQlnb3RvIGRpc2FibGVf
cnBtOw0KPiArCX0NCj4gKw0KPiAgCWVyciA9IG9mX3BsYXRmb3JtX3BvcHVsYXRlKG5vZGUsIE5V
TEwsIE5VTEwsIGRldik7DQo+ICAJaWYgKGVycikgew0KPiAgCQlkZXZfZXJyKCZwZGV2LT5kZXYs
ICJmYWlsZWQgdG8gY3JlYXRlIGR3YzMgY29yZVxuIik7DQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+
IA0KDQpQbGVhc2UgcmVtb3ZlIHRoZSBBY2tlZC1ieSBmb3Igbm93Lg0KDQpUaGFua3MsDQpUaGlu
aA==

