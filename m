Return-Path: <linux-kernel+bounces-512130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D0A33482
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DEB18869B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7CE126F0A;
	Thu, 13 Feb 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QU3I/gUO";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wt9u4XVN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Su/9YlAY"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D84A29;
	Thu, 13 Feb 2025 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409476; cv=fail; b=BCERHAbNQWkKcown2+hKhI2NhuNHpplonMbeAFPP5BvC419HIZVvNf9p2bY7IShicLPAFfM1h4cOxD4LDc4ywdRDvxNewfMdiMi3mgpAa6Kz3jztQVM4EobMOq1OWwebpo/6dJdfA75MIOmTro6Kxb1zYlPX2LAtAFo6yq9BkOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409476; c=relaxed/simple;
	bh=2be7IIc+ZjagYBGyKqs2a2qXDrOSuZ7X8zOz43Zm0GY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UdjxCP8aJlIt33iHrDnaUpbGCcigRxpMJMtWL62yFhdDItJOPLPyIkVyKgHT025i+tZuWIHCY5PReEgA2KBEeR1XzvNhAYiO0Smjo7ONi8pWnhKlsYt3+OyzF/OHffkP5gMKCLO03I07r4vebXkIAaDDsPyJDBrjXRegowF75Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QU3I/gUO; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Wt9u4XVN; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Su/9YlAY reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CLIhSw011322;
	Wed, 12 Feb 2025 17:17:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=2be7IIc+ZjagYBGyKqs2a2qXDrOSuZ7X8zOz43Zm0GY=; b=
	QU3I/gUOXoWe2JjRvCead9SmOA4UKx3+jkJuJKqJ9vh+vDJv2ZQj2+u98kVsKtfZ
	480kaCpgtcwzZgTFYg/FxzhQRj5bJ0DGgUuBS4OqDWgj3lTsGQW012UbZRnHk/nl
	Z+DicvuY+zDnx8NXGMA+kYotp5mGCCDP+CpEn1NrHWMKM+SkA8g5P6MjHWrsAgXS
	eo1rg+vxiJfQZ/i+RL5x12WFR4QeB8Tox9sXxKYBtVPOmFaBUuzjIIdz62QN3Tot
	Jtyanx7R/6ZQbXEZGMFi4cLm+EJ+lFL67NRCK/GubuD/cp+PsxipTJn21cLduhOY
	AKphaE8feJkQXab1WIvZOw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44ruhebt2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 17:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739409466; bh=2be7IIc+ZjagYBGyKqs2a2qXDrOSuZ7X8zOz43Zm0GY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Wt9u4XVN99jxD689Tt1l+JRTCdr6VYSjMDTXg6f6sGFqb/sD8bkcQWq+QXFkDztuP
	 a9Gd6QMkS1yWYTuHXIXMrzGBmMuUos1jP5q54XgXoVIOLoGTstj+mHkwThzHdDubxj
	 T4kuMTAiYIiqhi3LVahegfUZkkWXOaM2xy77RY+criLZqf0fRRIFeAkFKmVENBhLaf
	 rBV+v7HDC7oZLHwMef6qap93IT1y3+EElEy7cf76BCkTECfkEf/GrnS/tkL/wFADR5
	 HfJX+QRrEeNu8NstUzFmHt7GFdC5dG+xrDoZ+PnnCZ/bqlMbDVlF0nxqgmpdz/5Wpr
	 XIRf9uyhH7Zdw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0E73740237;
	Thu, 13 Feb 2025 01:17:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AAC7BA0080;
	Thu, 13 Feb 2025 01:17:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Su/9YlAY;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DB5FA40515;
	Thu, 13 Feb 2025 01:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyFJ0efhgwJS/QNalGCGzJe+gAgG7BYOYuGVnfoHQ8BzsD8ihgzkurEyDj4PXyOKrE1GKuqON8SQLFkh9WckURwmh8pYhsiBJ1Va6oQlENEUtiaysn71orR9wbiQfRTem/baGZ7/j/GV3hYUecEjxZsSukyzbtM8fEV869RgQlFOqm9pgB4umwghh4VMbrGZmyoIXv/JVoSErP5BmMoPujy+Hs0cogAODNoBTgsknPZIH7C1j/yMa50NcZrUt/fsQXRCWTmGkfOpncZegenyia9QGxSyvlDD+ohwB7AhraBEZwuKi18zTMFyQxGSYHe5VArRWnEBgLEN0ARJwO9KFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2be7IIc+ZjagYBGyKqs2a2qXDrOSuZ7X8zOz43Zm0GY=;
 b=vhiEiRKH+eKxjvo5y+BYlSqptyKhE1oR35PNWFTz4EStbcPH6XBClMOWphRFmTwgE4St3UpYdUhkgbIxybIj7v0YCSDmcoc6F02/xomLhZsJ9L+lmUx7NcgUqHfdRHHEHCU6XTmYqAjWc5CFSouMWciG8YBTG1F/9mYZYpeZG4D1qXiqxwmRKUX283HrLnDpeqJR74o2KK6tc2qzpwm3cSpTzK8KZAlOg2k9WjbBOvNb8kHlZ8nHG5lZvfW1j9GHPTYkrmMiXigfBolZlrfJig5Ol1pa6Jiw4XkNq1chTGFQruWF3P7dOME0Q8j2HCnt9510WnXMQRAXd/oP9gZSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2be7IIc+ZjagYBGyKqs2a2qXDrOSuZ7X8zOz43Zm0GY=;
 b=Su/9YlAYRSVKiV8DYb3ISDgWaXPPoG86O9pCo2ZYjrPqEM8oWNng2UuK8p74PDlLwXabS42flb/4y34lTNCerdhmz7pFFkRr6gsZ4s/TU1ap6plKDeCYpL2BbU/rbkIKegON+F2wfjfsOJwnSV+A/Ftx8gR+NMFfRicdUK+VN3A=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 01:17:41 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 01:17:41 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Topic: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Index: AQHbdnAAit2sY24YUU+11LLZH+RUWrNC6NyAgACeGQCAAIyBgIAAacsA
Date: Thu, 13 Feb 2025 01:17:41 +0000
Message-ID: <20250213011736.orc23wbgvjoybrbq@synopsys.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
 <20250212011013.xumqgguhluxdslpz@synopsys.com>
 <Z6x5lB4hGpz-9IzS@smile.fi.intel.com> <Z6zvcF1oe4TklTlK@smile.fi.intel.com>
In-Reply-To: <Z6zvcF1oe4TklTlK@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8402:EE_
x-ms-office365-filtering-correlation-id: e14a50ae-2bda-4823-7ae3-08dd4bcc364e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVdlOEM5UE5yeUEyS2FMZWF3dkpmSE1ycEJSOG9OejVNNzcra3R6VXB3ZzZY?=
 =?utf-8?B?dnNYWlVLMHY4aWJtWEEwQjhEMXpmem9SNHVMd3Z0MWZjclltUlI4ZGVvb2JC?=
 =?utf-8?B?akg2dm13amo5amFHd0p3aXlaU3BBK0Evc3ExR0VCSGErMDN3dmhjWFZBVVky?=
 =?utf-8?B?dzFTcUhOaVNORHhqYklRYUFVUk5XVCtVOE9GUG5LUDZFNWpJV1ZrMGtvdFBM?=
 =?utf-8?B?czRGeHg0aitGTm4zT1RObS9WOEwyc004RVRLb2NRZUwvR2RoR0pCYlRaaXJK?=
 =?utf-8?B?V05nbW9keTJGZXdGV2VYMEI3R255RGZYeTlRc0xyNFpTdU96U1I1dWh6ZlQ0?=
 =?utf-8?B?RXdHNTRMdmVET2tuQ1plV0xSOE9ubU9lbDlSVG50T1NkdmR0Mzlia3NyYXVT?=
 =?utf-8?B?RHZFV2FITFZXV2U2KytvZUJENU9VQktlUDIrNDlYLzFvQ0FaQ0Y3SDgxaHpz?=
 =?utf-8?B?elFKeTBQaWI2aUpuNWMyT1NXaU9iRE5vaWtraTFFakI2amVtSzJKTGR1cXF1?=
 =?utf-8?B?b3ZTSm5kcWZwT05SOXkrNXJSd0FkaUJkanBCaTlNN2R4cCtnS3h0YkhLS3JI?=
 =?utf-8?B?TWJhWmZnWHlPR0xTNS9kWmgyMkZ3dnFWUXJYcG9QR01KaHRqQXRDQVJtOTI3?=
 =?utf-8?B?bk5YZWlpdHhjVEFMZjlRZllVTU9xSDUvejRPV1o5eXFrQXIyMzBvd2hYVDIw?=
 =?utf-8?B?Ym1yVDZ5MHhjYnhkUytFZ2c5dVRXM291UTZsNUkwVmVCQWxIc0hkcE9EOWMx?=
 =?utf-8?B?cHg1U3k3UmFaTXp5L3AyTk0va3IyOVN3VEhzak1tamVYZDJycDluSTc2TlY5?=
 =?utf-8?B?eTFjYUNZQ0lqaFBINkt2cXE2RXRTT25aQ2pwQ0sxLytCc1BDOVZyRFFFUGdj?=
 =?utf-8?B?N0NhNUgwZkhiYkp5NjZFOENSMFFtR1BvVjFPeFMwYU54ZDB4VWdVbHhEVUZI?=
 =?utf-8?B?MHBDN293eGVUSFp1Z2pUUG83Ym9YbHlCR0x4RTVCK2VXRzJUSWNieUc3MUlm?=
 =?utf-8?B?Y2t2MEI3amtxR1paQWVqVThMR0hDTEpsbkJzR2llYVFSTEV4UktabndqbkpI?=
 =?utf-8?B?bklRTmFldkF1NUN6MEg1ZFlldUZKZUlxd0VNNmJYQjhUNFpqdzBiZHNGOU5M?=
 =?utf-8?B?UEd1TGVyaXNHOUNGdEdMVk9tR2hXWFV3UVpIY0pPbkwzK2lYY203ZHFmWTFx?=
 =?utf-8?B?L01ZcktaSUNkSFY4N3ZlS3RVNVUzUDg1Tjh5WVRXRjlTK09seGU1WlpwbHg0?=
 =?utf-8?B?UjBLQ3BianB4V2JEbks4SXp4VWYzREtuOFNpZGFsM3l5Q1QwdW9oNnd2Vk5q?=
 =?utf-8?B?RFl6SGQ4cml6WUdCQ2FEeEZIVjk0N20wS2ptVHFqVTdVTU80dElFbzlzN0Ns?=
 =?utf-8?B?ZWU2WkxBRW9UVlo1UDZXOWVIMzdVa1lIUHBOZlBQYkYzckc3S3p6VnV5VVB5?=
 =?utf-8?B?Ym1adHR4OGt3c3VKYTdMMFIyajg3ZWpoVXppa2E1OGtLUnlhWWg0UGZ6aS91?=
 =?utf-8?B?SUdmSTFNZkdEZ25Ua3l2SmFQdHJraE9kZFc2SE44VlcrMjJKZDZKMHJ0U0sz?=
 =?utf-8?B?b21pdjFZcEp0NTEyMS9ub0U2WE5UVTJFcHdwSzhnSU1CN3ZSL2VHajFHMnh0?=
 =?utf-8?B?aWZZTkt6am05NUtQQ1FpQW1uQnZpeklIQ3R0WCsra1dsdEN1ZHJxMjduUVNv?=
 =?utf-8?B?VDBYQStZNTd1d3ZSalRaaWlUeVJSMmpKVFRNdUYzTytVQitXaXBXY3ZpS1Vw?=
 =?utf-8?B?RFR5OFo5SkZ4NHphOUFjTzVkQ3lvclJqUjhkSWljQ0hQS2ZROENMYTNOWGRt?=
 =?utf-8?B?TTh4dStxQWRGU0pOWUVVTWk2TytWRTJ2YzZFakJ0K2ljYTFKOXRrWGtmSDlj?=
 =?utf-8?B?TWwydWpVa09VSVZQVVRTSThSMThmUEVqK3ZKenZkcFlLVEtLdGo2aFo4SEVE?=
 =?utf-8?Q?v7YXL56qNOFACxD0jekXbo+mNltwFs/2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnYrSWFDeHRsSVR3ZWpsc1VXT082R3lrYkExMGNYQXQ5QU9XbzRiNXh4b2c5?=
 =?utf-8?B?SXRBUnlHV1B1QTdZZVRGbWdPRHJ1ZWdRcWNlQXhoaFhnSEF6TXYzZzNLUTBw?=
 =?utf-8?B?eEl0K3FYbmt2eVhyN2VsT21XaC9QRWsxdHRnOTBNV2JHZk5abHYzWGVrdkRI?=
 =?utf-8?B?VkE4OVFWMDcyVEpndHhoa3lYTy9MbFNVL092N0xYUjhBZjZwZVNCREc3Y1oy?=
 =?utf-8?B?d3NaUHVoOWdKZnp1U0l4YWw2Wnh4MzZGUDJLWUZ1dFZQWDRjSjdCMlBkdjZJ?=
 =?utf-8?B?OGNKb3lUMmlzWEFGWHhkY1VsV1JDcDF3anZ1UTFOVHcwUVJBbmpzelVJWExJ?=
 =?utf-8?B?aktkOGl2MWdMb0sxQVV5UEdwTWVwemxOOW5UNG9PM3RSTEF0U1ZPb09lbVdQ?=
 =?utf-8?B?WElRRHUxRW5VekdOZWYvSjdHN1VDN1RUTUErdXhTS09uYyt2UWU3MDlXNWly?=
 =?utf-8?B?aS9mZ2VBaXpUL1ZsdHgzU3NteEJqY0JCR0wreUw0QzNaTGJ5SDZuUWtJYWxY?=
 =?utf-8?B?WDg1Z3htTWlxYVVZKzZtVVZ1MlJXdmRyTnNWbldDblNTOU5VWVBWeWE0UUta?=
 =?utf-8?B?N0RaZHFXKzFDeVIzVE1jSnRocTNBZ2s2eTQ0SmRDOW82Y1ZTTTc4MWYrZU92?=
 =?utf-8?B?SVp2SDdtOTNvdFhYNkRlMlhZdHBIS0R3bHUwYTZzQk9nSzFVdGZldnpySGFE?=
 =?utf-8?B?Qkh3TDJsZUVDcmpaWGw2ME1zekR3Tm5vZG1RRXRsbnhwN0dPaXR3ZHlmbUdW?=
 =?utf-8?B?WkttQnA4Tm1razVhTStPMkdIaGZicHhRVzNvU050bTlpeTJHVno2L1VER3ZT?=
 =?utf-8?B?T0xDVXNHU1h2L1QrM1hJV0UrOHJaTWZFckNvZll5eHMwbUg5UWozeS9QaU1v?=
 =?utf-8?B?b3cyMkluVkhvcmhCVjA3TUY3Q3NTKzBMNk9sdnFVNTlPRHNGeEZjSUxxR3ZY?=
 =?utf-8?B?RGlMVnZnVHc4TnpJZ0R3MzhXR3lzUUJNNnNhcUtrSFYwZXJ0RlJhaUFPSkVl?=
 =?utf-8?B?Y3RFd0RhYVJhV3RXUDU4dDhBYnUyNXZTclNNU2JqN3ptMGhvSTR3cWNMQzNB?=
 =?utf-8?B?b0tuRy9rejd6anB5Qk5HYVBFYm1RTi92cllXUm1kWFZBVU56YTA5L2xtVkd4?=
 =?utf-8?B?UFNoeHpUODVITzNaa1hMMEc1ZjlUWkgxQnFwb2lWanQ4QTg5M3N5Mk1pRU03?=
 =?utf-8?B?RUNQMFB0dVdxMTVDVWhNMUJlckdpQ0J5Sjl5YXdDajF6UzJ3QXp4Zzc3akhY?=
 =?utf-8?B?RFd5L05qaG1tRDdIbG5adTNnWm9EOEJTVnRGWGJXQTdLQXBva2FUTFlCL3Qw?=
 =?utf-8?B?bW5mK2g2UU9TMWlzQTkrcEp5RVdNVFY2ajJxVFNMRE1xWTlHQVFYY1l2c3Nj?=
 =?utf-8?B?R0tRQTdnQnd1NTcwb2pkMi9OVWxGNFlTbEw5aDJsNkdiUXhTSXpJQm9Penha?=
 =?utf-8?B?THZtOHF3SGJKVklFVU9WMkVIaXo2aENzUERxR2xzS3F3VTZhMUk5dUpxNUN1?=
 =?utf-8?B?akpxZ3RRYWpCM0lQZ0ZwZkhpQVhyakxJVnVVdDNQN0RROC9XMWRYZkR5MWRi?=
 =?utf-8?B?MEhEYjFEMzlPcU9BWTErWWx2MVJsZkF0ZTRPWWZ3VHBvdGl0L0loc3BITHdl?=
 =?utf-8?B?RVQ3d2Mrd1J4Q1JiWW9uUEMxKzM5UTROM3RFRloreEVRSXBCS1ZCcGxmc3Zy?=
 =?utf-8?B?bEh6RDlTVkx0RTUrc0ZDMTZzRzlZemtyVjBNWHBaSlZFc2k1TWxYUW95ZEpU?=
 =?utf-8?B?aHYvWVpPbEZNYzFnMjhTdUJrQkVLNFRnaS84SjduN0djVmVPOVhLbjMxOUU3?=
 =?utf-8?B?ejJ5TXlMUEg1WlRBcTd3M2p3NVN2cTRGL3Rzb0F4TkpuZGM1WFVLWTVqeU5x?=
 =?utf-8?B?ZWQ5Z0NEVnl0RVpuUUc1cWMvVXNsc0NoeEZHVFBKY0dVdGNQdXdoaTB2a3ly?=
 =?utf-8?B?ckRWMmptSVZ2emw1b2Jsd2x4eVhGWHVIdjhMMlBCbCtoMy9FeHpOTVNBZk4r?=
 =?utf-8?B?dFFyWG10dERUZHNzUlJvYWo3MnhEdnR5ZDRIRVdBRndKblZaeDVKMVRKQTBq?=
 =?utf-8?B?RU5YejVJLzdUaWE2L0hmSFdPb2RvVUhQTUxKZWJIZVg0YkpFR1R2YnQwbmo4?=
 =?utf-8?Q?F/eEauBab3kTX860BTwWuDxM8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A69A0C1CFA9B1944AAE26BAE58059E01@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bl5wIpobtckUOGOGTCmOehzgVEa95gXgFj3ya+I6lCajYwfNG4eMVOFn7lE0EOtjoYIR3sb+zm85M14vjbkQH5lOdAvYf+4UUSez4xsZS0QBaucqm5tlUKWyYRVzTDl66MEZoMyCJGpU5YJ6SszoZX/emCCwE2ncgxd5iiPJp3rBj+Xj5OERvAeEydTqOtqWeb+ZxW84DMefCVtcBqRyNdQ5RnSBpbs7JUXHIVxcVx7E032YZFbF+nnO70rNAPeGFbq5FZ3fJk6FDyHTF+F1EqSOvFUPAN6CmHZ5XfV7QMMI/pXWwkn8lQayFK4lwWYeTCtCGozzEhwz6s1jf3SOP9spOBYxec2HDhqsEoVb0yCv4rp1S/6NTa6vGwWNzlkXq+lxCrsS9pbpY0LZr7eV2xDvYUSMfeeH1SoE+B+/yN7ureNOHKmzgR0G1tTfNVs/MbEYXslYbp8rChYU1lvQVa+T+UbiXPu5yXOF9rChyaMrmLFj35ldqoktLU5qayhLZzEUQwHRYMvfxK6AHmr10kTuVaJhdMFu9lHyYQi/mz9paYYqbwMWISZJxNCWgks6yXzhgc2BUKZ6SjFF+yADb269tl+pj4yKyBAsvk4cDu7Er2glRAE3ysuWuE2F5A9JJYTewfv5C0keNdvaxbLSfg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14a50ae-2bda-4823-7ae3-08dd4bcc364e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 01:17:41.2901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aMJYkKL9wQtP4C1msPbKDxRlS1kR2umU0jr9aM5QiA0+Omlrx6voKRCCw6W+lUKD8w8oh3SyhoIuwe1tMDEzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
X-Proofpoint-GUID: aaW2VMQWA1I3w-UjUT7EZ5Ao8rMWPIKk
X-Proofpoint-ORIG-GUID: aaW2VMQWA1I3w-UjUT7EZ5Ao8rMWPIKk
X-Authority-Analysis: v=2.4 cv=TP6/S0la c=1 sm=1 tr=0 ts=67ad483b cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=DAjRf7xOnFnuoqTCNCYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=623 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130007

T24gV2VkLCBGZWIgMTIsIDIwMjUsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gV2VkLCBG
ZWIgMTIsIDIwMjUgYXQgMTI6MzY6MDRQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0K
PiA+IE9uIFdlZCwgRmViIDEyLCAyMDI1IGF0IDAxOjEwOjE3QU0gKzAwMDAsIFRoaW5oIE5ndXll
biB3cm90ZToNCj4gPiA+IE9uIE1vbiwgRmViIDAzLCAyMDI1LCBBbmR5IFNoZXZjaGVua28gd3Jv
dGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+IHN0YXRpYyBib29sIGR3YzNfZ2FkZ2V0X2VuZHBv
aW50X3RyYnNfY29tcGxldGUoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4gPiANCj4gPiA+ID4gIAkJ
Zm9yIChpID0gMDsgaSA8IERXQzNfRU5EUE9JTlRTX05VTTsgaSsrKSB7DQo+ID4gPiA+ICAJCQlk
ZXAgPSBkd2MtPmVwc1tpXTsNCj4gPiA+ID4gKwkJCWlmICghZGVwKQ0KPiA+ID4gPiArCQkJCWNv
bnRpbnVlOw0KPiA+ID4gDQo+ID4gPiBJdCBzaG91bGQgYmUgZmluZSB0byBpZ25vcmUgdGhpcyBj
aGVjayBoZXJlLiBTb21ldGhpbmcgbXVzdCBiZSByZWFsbHkNCj4gPiA+IHdyb25nIGlmIHRoZXJl
J3MgYW4gaW50ZXJydXB0IHBvaW50aW5nIHRvIGFuIGVuZHBvaW50IHRoYXQgd2Ugc2hvdWxkbid0
DQo+ID4gPiBiZSB0b3VjaGluZy4gSWYgd2UgZG8gYWRkIGEgY2hlY2ssIHdlIHNob3VsZCBwcmlu
dCBhIHdhcm4gb3Igc29tZXRoaW5nDQo+ID4gPiBoZXJlLiBCdXQgdGhhdCBzaG91bGQgYmUgYSBw
YXRjaCBzZXBhcmF0ZSBmcm9tIHRoaXMuDQo+ID4gDQo+ID4gVGhlb3JldGljYWxseSBldmVyeXRo
aW5nIGlzIHBvc3NpYmxlIGFzIGl0IG1heSBiZSBIVyBpbnRlZ3JhdGlvbiBidWcsDQo+ID4gZm9y
IGV4YW1wbGUuIEJ1dCBhcmUgeW91IGFza2luZyBhYm91dCBzZXBhcmF0ZSBwYXRjaCBldmVuIGZy
b20gdGhlIHJlc3QNCj4gPiBvZiB0aGUgY2hlY2tzPyBQbGVhc2UsIGVsYWJvcmF0ZSB3aGF0IGRv
IHlvdSB3YW50IHRvIHNlZS4NCj4gDQo+IFJlLXJlYWRpbmcgdGhlIGNvZGUgYWdhaW4sIEkgZG9u
J3QgdW5kZXJzdGFuZC4gSWYgd2UgZ2V0IHRvIHRoaXMgbG9vcA0KPiBldmVyICh0aGVvcmV0aWNh
bGx5IGl0IG1pZ2h0IGJlIGFuIG9sZCBJUCB3aXRoIHRoZSByZXNlcnZlZCBlbmRwb2ludHMpLA0K
PiB3ZSBjcmFzaCB0aGUga2VybmVsIG9uIHRoZSBmaXJzdCBnYXAgaW4gdGhlIGFycmF5LiBBbmQg
c2luY2UgdGhlIGZ1bmN0aW9uDQo+IGlzIGNhbGxlZCBvbiBhbiBlbmRwb2ludCwgaXQgZG9lc24n
dCBtZWFuIHRoYXQgYWxsIGVuZHBvaW50cyBhcmUgYWxsb2NhdGVkLA0KPiBzbyBJIGRvIG5vdCBz
ZWUgdGhlIGp1c3RpZmljYXRpb24gdG8gaXNzdWUgYSB3YXJuaW5nIGhlcmUuDQo+IE9yIGRvIHlv
dSBpbXBseSB0aGF0IERXQzNfVkVSX0lTX1BSSU9SKERXQzMsIDE4M0EpIG1heSBub3QgaGF2ZSBh
biBIVw0KPiBpbnRlZ3JhdGlvbiBzaW1pbGFyIHRvIHdoYXQgd2UgaGF2ZSBvbiBJbnRlbCBNZXJy
aWZpZWxkPw0KPiANCj4gRm9yIG5vdyBJJ20gZ29pbmcgdG8gbGVhdmUgdGhpcyBjaGVjayBhcyBp
cy4NCg0KT29wcywgeW91IGFyZSBjb3JyZWN0LiBJIHJlYWQgdGhpcyBhcyB0aGUgc2FtZSBsb2dp
YyBhcyBiZWxvdy4NCg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiBzdGF0aWMgdm9pZCBkd2MzX2Vu
ZHBvaW50X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjLA0KPiA+IA0KPiA+ID4gPiAgCWRlcCA9
IGR3Yy0+ZXBzW2VwbnVtXTsNCj4gPiA+ID4gKwlpZiAoIWRlcCkNCj4gPiA+ID4gKwkJcmV0dXJu
Ow0KPiA+ID4gDQo+ID4gPiBTYW1lIGhlcmUuDQo+IA0KPiBIZXJlIEkgYWdyZWUgYW5kIEkgd2ls
bCBhZGQgYSB3YXJuaW5nIG1lc3NhZ2UuIEluZGVlZCwgaWYgd2UgZ2V0IGFuZCBpbnRlcnJ1cHQN
Cj4gZm9yIHVuZGVmaW5lZCBlbmRwb2ludCwgc29tZXRoaW5nIGlzIG5vdCBjb3JyZWN0Lg0KPiAN
Cg0KQlIsDQpUaGluaA==

