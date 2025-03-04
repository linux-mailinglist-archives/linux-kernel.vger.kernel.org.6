Return-Path: <linux-kernel+bounces-544136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAC6A4DDC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE91C176B06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500A620298A;
	Tue,  4 Mar 2025 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="4zQ83xgO"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023111.outbound.protection.outlook.com [40.107.162.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71E1FDE3A;
	Tue,  4 Mar 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090925; cv=fail; b=t+0x/IxJZ6tDh9lkB/+gQLd4wkdV+YWdB+pW4fDlfDJN2KEOumwuCU8b9u1axcMcD8JXLAwkiGiWNoLm13A839eUF8H3YGRbmJl7zG+zvgGqM3BNBVaKh+OC0FbfnleDvSDGXM0F+j1CFgwdgj1d91pzI38/8AhI1tEN4onG8Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090925; c=relaxed/simple;
	bh=OLCU9WutmjoEjLioc/fc4Tb19CvmMHPez+l/HPSMkmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YyZmvb1IJsckAdxj83UQYnH0Tuzcl2yITPr+q3r7GcrQB3rmYY9KrbQyb6cIp8MtgFctlkk7A5Vlm2tiOfr29mtgpXjXkzspBAOlYonx9cRxMxjnUBmRIFuD6zd6WdXmOJKEFLdFEi2s4deTS98ZjzfGlXm15CBMgOCJb4VS7nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=4zQ83xgO; arc=fail smtp.client-ip=40.107.162.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2tTbNnlOEIjwe+tozIKi0TDolH6/C4efc1PsrS3u48P/8SVaqXgPb3BruTwZHlZhi5DLEJ2ESxN46HZvatnAkdSUfuprnRhKvOpZ7CNOD4XJH5wKtRLvpk2jU5KGZXDRnThHQoVP8LDVFC5XV/0dtYutivKYVy1sFDn5pgJWurKdznz2gQqiEEizeFgLQpNWZ9BIfofxnRzdi4lQFuQyJCPSDUfbwWIe9xgqQhhAhd94vJsIDijqh8AC46OHBBa3oe7A95NOvkXaBeVnOPhd36JTn41Nh7tuh6vn3vB98VqgO9a/q4ZAq/yAPJzMRC2oPttdEl026DFEMu/WMNhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLCU9WutmjoEjLioc/fc4Tb19CvmMHPez+l/HPSMkmg=;
 b=t+emaVQ0mx9tFP5vcJ9s33gDg/Y2qNme7IXtLvMlS5gij9ozj6phersiFgDsUPuPn80wLDkjTyQxVLzOgCT52E07EUenHtIDrwwuNgyQRHuvED1cAcxisGwk03L8v8MIJ8bFnRxUEfP4LVJ3W8qlsnblcCbstpTWhbkmXnIWWBv23hV9qL+fNDWRTGZ65dfL9+f41kDQ/AIhvd1u8bPTO0FWr08NUS6KPowhPfgQGO3VNwETaWgRN/FJzYr3C9dIb/rgyJXWk1ZqYWwxl77/Df3xyp9L78kh4UGnaNTKJ1IiywBFN0RcyQTJSGfiZLqCtxvGPT9316dtJsUzGFaIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLCU9WutmjoEjLioc/fc4Tb19CvmMHPez+l/HPSMkmg=;
 b=4zQ83xgOZ6BDBa5he0X37oG3KbzI7Cbmbcyn/MK7Se49eEPHlYjqC3eoxGaGXCsXeuua6fX99eekgKSlUOlic17xpVkWnlL9DiZb38c58Jdob3ItIN0OkIyJMUD2XqTqNj/e6k9g+pXn1n4/c/0JDSz22IXs+f59KIv69ryzb3jDEXq2krt/Cqw6k0YcfpW/Luzseg8EjsE1MLuDAiBVGWTpv08940/tXhcLeIQqRjbCpB6LYHJzjCxgn7PmVf/JeZkjCcPFJ/zaGjp8iJ3/sVLdgtN+FaPg1Atc3culQRg9lqd5gNt7I5TLHwug3+lj8E1S+USEo7VyABs6vP0+ew==
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by DU2PR04MB8918.eurprd04.prod.outlook.com (2603:10a6:10:2e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 4 Mar
 2025 12:21:57 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 12:21:57 +0000
From: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (ntc_thermistor) Add min and max temperature
 attributes
Thread-Topic: [PATCH] hwmon: (ntc_thermistor) Add min and max temperature
 attributes
Thread-Index: AQHbjN7lsSOLtLm4Y0CUYz9ZultBILNi0tcAgAABdp+AAApvAIAAAfa1
Date: Tue, 4 Mar 2025 12:21:57 +0000
Message-ID:
 <PA4PR04MB7630D681246FB1F81322017DC5C82@PA4PR04MB7630.eurprd04.prod.outlook.com>
References: <20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com>
 <f2b58aab-6664-4968-86d9-1e761a41b065@roeck-us.net>
 <PA4PR04MB7630FFDEE9AF8E1458DBA6B0C5C82@PA4PR04MB7630.eurprd04.prod.outlook.com>
 <d3e8a814-1dce-4054-87f9-3bd3f7b7c6dc@roeck-us.net>
In-Reply-To: <d3e8a814-1dce-4054-87f9-3bd3f7b7c6dc@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7630:EE_|DU2PR04MB8918:EE_
x-ms-office365-filtering-correlation-id: b868d430-8187-4deb-62e2-08dd5b172810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?uAQkt2s6bZSG7+4cTlKmbdBNplu7CIi3FU6GaxFrUpINdyocgOcRS71gDV?=
 =?iso-8859-1?Q?2k7K+rBPg9R/c4PGkJOc7/2Zx5+cvNSgkwSjKzkvVGLl61AYsPdLTZGXji?=
 =?iso-8859-1?Q?XiPm+jALAoG/VhafrcfaGytl7abblEJvWkqmRH1DnApC9XJWdLfFVAxNrR?=
 =?iso-8859-1?Q?q1+mFcFlZiLmyDt7DfV7p6x3KgVQiJ0EdFGXE4hX3i+ShF+cuFV/PJ6hS9?=
 =?iso-8859-1?Q?O4wK8Up6GuFvCHOGA6RTsAF5b6gihymtbct0k4TJpX1DSMdlkiT3cV/xFr?=
 =?iso-8859-1?Q?4K2E1suTQiVqtm9CySQXfgxydUwMnqpQzkCZXo+HUz54AgCRAi6t4926lo?=
 =?iso-8859-1?Q?hAKnwVCq1V/lDcjupAEh2kDBj6rv5Mv5DEibQnIAQ5Y7dN6LbZNNgwmtrb?=
 =?iso-8859-1?Q?xTCrOaAaddLoDE9TcuD3wk2miFR05Q8ZyT76Ucw4DRvXep9msBb7K7GR0D?=
 =?iso-8859-1?Q?SZF1umDfH3eviQ9UdScVRbF88ZrToKv9lUw7qxI8J36mMbck0o84g/clxm?=
 =?iso-8859-1?Q?Un0NmB9gGk/jhyaUWMxwasnn8WJr6gSfZ2BP/kGTqc8HRqenLt//2fEZNA?=
 =?iso-8859-1?Q?PC9rUgFSvuZ8iJYZiJTt/RAFFMKFxDwvkKuYsg0mwaZGgj66nJZaDOxydi?=
 =?iso-8859-1?Q?6JSbFfpBwjFvgIkSB88Q518HcEESc/to/2mjv/kPt4nzuZ+CO+rC3BoiJK?=
 =?iso-8859-1?Q?aqSL/iBbazZ1p0QYZ1heg7P3C5htGo5f1QbtBV+lJQITtwKYTXC4A2a6ke?=
 =?iso-8859-1?Q?+kPTQLwpbOuuf+hk4Wmn8IO7SyYUIr7mqRSJ6j5RBdAWvYNVFEAXhHJLBy?=
 =?iso-8859-1?Q?8JK3OHjtDSLVTkiQ55uZ07p+iapHiM5bgC/EnpXrq1NTEUbYJWq7Ipqo58?=
 =?iso-8859-1?Q?dsxIzZTDwYay/N1nhpYBL9beYFHoLluQovpp1rVo+WRQjiVMamYPb8r/2z?=
 =?iso-8859-1?Q?yegwYTbGdgJSI1xRoM1LaOExW77qpVozOGp19lMakDFrHXQDM36ZbOFGej?=
 =?iso-8859-1?Q?WIC6Bw5m+E12XF9pWPCIWn9V0T8VKAZtK+xqT7Mtyb5MaTgxvRUfuFhLZa?=
 =?iso-8859-1?Q?IvHxWzA+P7rK2LaeCVXv6CUtt/crCUTyzK3xshRwiFP+RC+sNmZRByDX1Y?=
 =?iso-8859-1?Q?4ib/ECMFSATTIf+SPGwTPjar/ox2y3pKMhNPYEWypmmoyOn34s+tmHtMCm?=
 =?iso-8859-1?Q?Iz211UALDkhLZQ1RFF/rBxIJ1Lv7wuK0H99qVMhpjNHgHplD90KksSTZi0?=
 =?iso-8859-1?Q?3yGIxj8oRW4q1N8j3AcQab2+Q8fPc6j8WFBHEdJ3TmFtN9DXtyjKP+uKTc?=
 =?iso-8859-1?Q?kFfi1rsG7ws+ScO6qsBaHp2QuPf+IJQkzxcGp6eZY5Awdi4pru96fTWFh1?=
 =?iso-8859-1?Q?U+XYM5AhKYa008dQ7bO88UPbhds9PRBrz8I3SQPAgT3S7L46Xzu+5gpGon?=
 =?iso-8859-1?Q?tTOoCMGpXzGo8eYbjGE4uwbay+tIcHOVJsDXY37Y5FQQV+8WF+9NkuZOPT?=
 =?iso-8859-1?Q?vHyqoQlUDpYY8rdcBv7EMa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VzS+eX15yxFVnsB4qEcGz93FMszDjsSw2+44AU3MVN7CKfZtSZXRy71n5Z?=
 =?iso-8859-1?Q?rcdIn4BMmc7k16lFlB2aD+AaNjqS3sUt0bY8NVylAXNQuA3KdtX6cxTL7M?=
 =?iso-8859-1?Q?gb6fObbp3ZakmNz5E9gHQSaJMVUCj5d0A5kaNSfCqF6021a9KQoGZBM41W?=
 =?iso-8859-1?Q?y4+xBJ5+NDq0rP86KlSx54BJken5tv9m5eEH8DcqRs9W5mSD4P9BBtU7bT?=
 =?iso-8859-1?Q?EvUs+QeIX7kne/fcwf16KJ1N07/cxd2sQsDP5i1P1snP91fOtdTz3RgVJv?=
 =?iso-8859-1?Q?3WqKmbjFCLqKZOri1vJq8d5bE+EGIvb1im/RNluZNMlnw/hMAa1yhItzi3?=
 =?iso-8859-1?Q?ethacHPPtKeTnbYsqc3acVV5ce+/IaRETvuI/VjyYcZU2qEXhFPhLqR4Bf?=
 =?iso-8859-1?Q?nFqCXlHnqsqOGSkpW8FHHHI4LGZYGaYb6RsYtOY3E9OnQzNF53bWUmt2WM?=
 =?iso-8859-1?Q?TX6KkKmDXRBLD6GY9FoNrZagQoVQb2HqSJh7CpsPKQc1eX8SnU43XkJBOq?=
 =?iso-8859-1?Q?NN+AG++0q34j+MQMUc4ojDmbLtSnsgyZKwxXwQnMv4oDNlcu73EbjLNtJL?=
 =?iso-8859-1?Q?sSCyimyarQqMXuk0Ln78Y50oxLL9MrOBFsdvoDatxqHJ+6kiHGImZ8mJ/W?=
 =?iso-8859-1?Q?qsKc+xEotojDPyzoiZ+1glWPT7/V8YLPoiKgIHxgR3eomrqcPzFin4fXk4?=
 =?iso-8859-1?Q?JKf9H1SXd/VpwcDVt+4WF6l1pjo/Gix1MlntLSQGSmccQLp+f6jwI1+kjj?=
 =?iso-8859-1?Q?qNHbxueCPkkWFig9E+qRJSdUQ26K7QjVxIGFUiBjEcyzZOAbtVaz4GbvHT?=
 =?iso-8859-1?Q?RK+hVR+aKDEVPDfK9RAM9rzoZg8F0/q9xeIkPfkL2MUzsEj28YhHDdmXJs?=
 =?iso-8859-1?Q?FuaM42yReH0RLMAo7Kw4So2laRup2G4IF3jtuPr6NPq1KEm0h5KAk6HJ7R?=
 =?iso-8859-1?Q?iFQbWlZhpsmCINdhldlpojQYfhkyDzLqBT1jugo4E/SCukrXFRx4y/Ad22?=
 =?iso-8859-1?Q?EUUE06Wcg4QftRMnEqotFjS4E2qfoYiX0WZTTjVfVcFPA9Z3MOqf/zipDu?=
 =?iso-8859-1?Q?TJVmO2PAqUBOhbqyQF/NnVtI1MTiDXYfZFBNthsAGJRJIJ+Oz5V2F+CVPa?=
 =?iso-8859-1?Q?ZCpDEzQqUM2EaHYT/KZsuj5R3uazqazAKu1ex6aRvWG1QIqNHAJpBBXREB?=
 =?iso-8859-1?Q?rObHvFML5AhZIMJuqPy/hXi3x44ek2wpGYai28I2BDGK6b4RpLMQTstYpk?=
 =?iso-8859-1?Q?UPSnJQ8plWHCevG0xMVcgy739RmedQwV4akhh2KnDVwnu4zJb0qGR04UV2?=
 =?iso-8859-1?Q?QDtHu+C58cvC7IhnjI/5kpBXj+pVt+G0We8R5QIG2Kr/FSLwxVB3VUWw8M?=
 =?iso-8859-1?Q?c3iKY9nGmcSIpG0OpLqEDCPPYYhbVm4+Wsf+Jebl9npVQ3xFBiiOIEzede?=
 =?iso-8859-1?Q?vhCAAemag0PClHFXAfNlH50rXkGps4ISZn2AjuNK4mqJb8UBLJd5xJcLTb?=
 =?iso-8859-1?Q?ZuBMw8VomY6OoGRmtvGlAdfagMPnk/kVWihYRadWbWa0mSWGICCe+LWkSG?=
 =?iso-8859-1?Q?rFD9O+ws8jlFywz5JVH2SePPohuPH/EUgW1EfNCRmGequ/8Ap3CYnGz/TR?=
 =?iso-8859-1?Q?VqLYDugj6gj9jWdAJeGsLx86zcRK4TIZ8fBpI5B2JyOeu14FRfK/GEkis5?=
 =?iso-8859-1?Q?g+H7Fumi2tbJFsEBfTN47Lu0oHPrPQ5Ujea6OXOLvC482R6Euuzatt1lba?=
 =?iso-8859-1?Q?PlDw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b868d430-8187-4deb-62e2-08dd5b172810
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 12:21:57.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyBwARLomWD1IJrBtFJlLBmnmzh4srS97WFVQj63AYfs4n2a7xGPR2SAuTRRk07d3QYl6/XhihjTwh/tITz8+i7QKOvkVqRuZcoVEPH6Jb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8918

From:=A0Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux=
@roeck-us.net>=0A=
Sent:=A0Tuesday, March 4, 2025 12:54 PM=0A=
=A0=0A=
>On 3/4/25 03:33, Maud Spierings | GOcontroll wrote:=0A=
>> From:=A0Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <li=
nux@roeck-us.net>=0A=
>> Sent:=A0Tuesday, March 4, 2025 12:12 PM=0A=
>>=A0=A0=0A=
>>> On 3/4/25 00:24, Maud Spierings via B4 Relay wrote:=0A=
>>>> From: Maud Spierings <maudspierings@gocontroll.com>=0A=
>>>>=0A=
>>>> Add the min and max temperature attributes as it is trivial for this=
=0A=
>>>> driver.=0A=
>>>>=0A=
>>>> This can help with detecting implausible readings and indicates to use=
rs=0A=
>>>> which range they can actually measure, so they will not set a trip poi=
nt=0A=
>>>> at a temperature higher than max or lower than min.=0A=
>>>>=0A=
>>> Unless I misunderstand the driver code, readings outside the table valu=
es=0A=
>>> are never reported. Also, min/max are supposed to be alarm temperatures=
.=0A=
>>> The reported values for min/max would be between -55 and +155 degrees C=
,=0A=
>>> which does not make sense and has zero value for trip point usage.=0A=
>>=0A=
>> Regarding the driver not reporting values outside the table values:=0A=
>>=0A=
>> That does seem to be true and is good in my opinion, however currently=
=0A=
>> 125 can mean 125 or something higher, with an indication of a max=0A=
>> measurable temperature it can be determined that this is a max value and=
=0A=
>> thus might have extra considerations.=0A=
>>=0A=
>> Regarding the meaning of attribues:=0A=
>>=0A=
>> It is difficult that the attributes do not have descriptions in=0A=
>> include/linux/hwmon.h=0A=
>>=0A=
>> Is there an attribute that should be used to indicate this maximum=0A=
>> measurable value to userspace? HWMON_T_HIGHEST/LOWEST?=0A=
>> HWMON_T_RATED_MIN/MAX?=0A=
>>=0A=
>=0A=
>There is no attribute providing the temperature (or any other) range=0A=
>supported by a chip. highest/lowest are highest/lowest measurements, and=
=0A=
>the rated attributes are rated min/max values for the system, not for=0A=
>the chip. This applies to all chips, not just this one. Misusing the=0A=
>ABI to report "limits supported by the chip" would be inappropriate and=0A=
>misleading.=0A=
=0A=
That is unfortunate that such an attribute does not exist=0A=
=0A=
>> Some extra ramblings:=0A=
>>=0A=
>> I want to have some indication of what the lowest and highest=0A=
>> temperatures that the sensor can measure are. Imagine I set my trip poin=
t=0A=
>> at 140 degrees, but the sensor can only measure up to 125, I would like=
=0A=
>> there to be some feedback that this trip point can never be measured.=0A=
>>=0A=
>That would be a problem which applies to every chip. Unfortunately, it is=
=0A=
>all but impossible to try to express that in sysfs attributes. Many chips=
=0A=
>have different temperature ratings based on the chip model/variant=0A=
>(commercial vs. car vs. mil), but the valid range can not be determined=0A=
>from register values.=0A=
>=0A=
>The same really applies to this driver: The tables in the driver are for=
=0A=
>specific thermistors, but the thermistor will still provide a reading if t=
he=0A=
>temperature is out of range. It will just be out of spec.=0A=
>=0A=
>On top of that, thermal limits should be based on board limits, not on chi=
p=0A=
>limits. A board which supports a temperature up to 140 degrees C but=0A=
>utilizes a temperature sensor which can only measure up to 125 degrees C=
=0A=
>would be a badly designed board. Trying to address that in a driver=0A=
>would not add any value.=0A=
>=0A=
>> Some kind of plausibility check may also be interesting. For example I=
=0A=
>> have an ntc in an lvds display, if this display is disconnected it shuts=
=0A=
>> down because the ADC reads zero, which means temp=3D=3Dtemp_max.=0A=
>>=0A=
>=0A=
>The best we could do would be to return -ENODATA for temperature values=0A=
>if resistor values are out of range.=0A=
=0A=
That sounds good to me, I'll give it a test and send a new patch if it=0A=
works out.=0A=
=0A=
>Guenter=0A=

