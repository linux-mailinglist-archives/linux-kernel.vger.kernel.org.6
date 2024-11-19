Return-Path: <linux-kernel+bounces-414292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D49D25F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0756284018
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69CE1CACC8;
	Tue, 19 Nov 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iwRAmxrI"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011000.outbound.protection.outlook.com [52.101.129.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D113B780;
	Tue, 19 Nov 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019587; cv=fail; b=RAX/8O3TKOXeqa8ycNPpYGAOaFqMMnOut+B/hgPIQZmnRv6kBEEyEiIRQuByBemaFtPM7oznxWoHymSGPX72Td2wTHvHK87RYEAaiDqTWSP9yG6LwejhxKCJHiffqFO42PmWzgJ4wYnTpAXbXu6B+N5Z2oGXrWdcsH0x+T+DTbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019587; c=relaxed/simple;
	bh=vnH8O4flsTilzXcUQetLgmHfCcRfGvZWAb8scYy5HW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ciLQBGTvf8KgRSX+vof80dkl/gp2fUez5MpPeInioQwbXqNCDeBDpJZtZKeycLrJmWFmVLBXPDvZG9K5gnwmxOOPCE7k3G0UEkbxCo+EVa3ThUsQ0yBkEj/5QGntyx3iYObgBV4wmWx3HC+D4hyXVdCIyGB0J5ENeH25puGt/EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iwRAmxrI; arc=fail smtp.client-ip=52.101.129.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4LqVmzcv7O6h9Yo7BU2aGgW8X8tVyNsLVSc5Q2Qi9o8TZ6rKhZl0PETopBBEcwbF80auRtkZFIXQzywr3SvLlSyuidGRwJJ2jVAWwvrKpkjwKfYpIQshVLzDMvw+hCHJeIqZx2oZO7VqJOJTj5miAt/7iNdgR+LFQxpbGF1A59CTBzS43sjeqMcacVIRtsVms39jom3rNxV7z4ps7e1C82y8VmiKjlYXcY0PCU+/BYagE2gr/8cFxP0TOFQTYv+J4mqwjljdNWvQGCSrSQZk4oa1eg86687nRKQ/iDsq0kjtb3Mob+UGqwbnBNozW84mtzrAayHCPb+dkwkF+K9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnH8O4flsTilzXcUQetLgmHfCcRfGvZWAb8scYy5HW0=;
 b=SqeZjH5uh4NlbFpTt+k5XkioYgIHhdccHGw1NoasiDE8JgW2YfDebkEZrISQalxMsKwq0ie/JEyScSEFC5Qjdxo7V6D/1Rt+ZnZVI771KBLsfvFLF41Y2EsPQJKZqw5pKArnfYYGdOWr2UPLIEUgf3BTXeizH3Q4QlRewUZtjM6lGbaT8CrahmxPHSxprdRJR/UZ6GHegUb6WsWqhCIXtH1VxQdvflUPKQNjIhVer0VBl3F8YSHbymap9o+i7LxfRDvRNwtg8+eVhcQQVj+3Yi8CWW6s/dmhzv+o4PoW4kkWx+fR0B0J4fQedGtQT8NKShLSBSwAQrNf/nVv72eMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnH8O4flsTilzXcUQetLgmHfCcRfGvZWAb8scYy5HW0=;
 b=iwRAmxrI7bNAzNFDaMBUBXSuzsND/M+IAGmFVpErwSp2sXDLvkT5OZXTrPpKzQo2jn8OPwhJbfkbGRb3yTbshl6bg0ultZIe2x6AcFTM9phNr4W4jaGjMNWAWIm3Iu3JUMdgTbVoWhbOTrzx9SyLwGYKIrgdD3j+220zGSeQ6onC+Z9zsbxm2HpyQkgoaocRBxTUql4jzPRQmwbY+wkPGoGs68rtWWxhowAm3NxF+XbJ08XJwmDakB3cdS6u6+LV1i1XIovdk1/KCNsFHHQpDvzpJubkw04Sx8Hq2CkxDm/X+FjtWwD2xRRIwvmVdIqqSi36VB4ngRNw8/wUWLu6MQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEYPR06MB6753.apcprd06.prod.outlook.com (2603:1096:101:174::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Tue, 19 Nov
 2024 12:33:02 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8182.011; Tue, 19 Nov 2024
 12:33:01 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "mwalle@kernel.org" <mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogRml4IHRo?=
 =?utf-8?B?ZSBpc3N1ZSB0aGF0IGdzX3N0YXJ0X2lvIGNyYXNoZWQgZHVlIHRvIGFjY2Vz?=
 =?utf-8?Q?sing_null_pointer?=
Thread-Topic: [PATCH] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Index: Ads5Z1bjTgbcKYBiSvSmNoAzjrMY+ABElzwAAADlTkA=
Date: Tue, 19 Nov 2024 12:33:01 +0000
Message-ID:
 <TYUPR06MB62173B558D42E47CD7BCDF7AD2202@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB621737D16F68B5ABD6CF5772D2272@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <f15c5c40-d836-4995-ba7c-ef7470d1772f@quicinc.com>
In-Reply-To: <f15c5c40-d836-4995-ba7c-ef7470d1772f@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEYPR06MB6753:EE_
x-ms-office365-filtering-correlation-id: a352bd67-4b86-4c35-b22a-08dd08964ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RThDMi9ka0JCMmlPSFh3VWRFU0VLdlpVc2Mxak1WZGRlSHY2d3dZMXFYWFJt?=
 =?utf-8?B?U040ZnZjaHdDN2h5Z0NlcWhVTTAzci9PVGlGQm11SmhwRWlJMkkyUUp1U2FD?=
 =?utf-8?B?QnVMbkRTOE81V2ozU01ZMVpYaW9VS3gwaWwwNklZdS80SGtjdERkNHVNQklB?=
 =?utf-8?B?cWFHRmVWbTBwN29jUEdNaG1Ca2ZZei81cHlRYlJxSERmK3FyY3BzcnVxMkpB?=
 =?utf-8?B?N0ZFSXdvSHdEYy9HWnk2S1NQeW55TnR2RzVZWGFBdzk5SWdGV0R2bXpaYTFB?=
 =?utf-8?B?TCtROXV4T0RTQzc3aWNnakNnY0FXWEpycUQ5bmdZb2ZuT3ppdFA1VlFrVVpT?=
 =?utf-8?B?S04xM0Q5S0F0cS80dTdkellzaVZrbTRSOC83RzhFblZTVzZOMEVSUHA4ak1T?=
 =?utf-8?B?NktsaHBCSGlOUkdjOE4vckpHaHMrV1RLbmNmZXV6RXlZa01Vd0NPK3dFWTQ1?=
 =?utf-8?B?amdKcUJ6THFtVXJOOURuQWF1RC9jVWdHY1JKVmNzNFZvWU1xUGZWU3FORHZs?=
 =?utf-8?B?ZTA0MmhBVXdseTdHQWVOa1d3OWhnMEVBQjErbkFhMnlWWVdUK2ZUWDBUcTVZ?=
 =?utf-8?B?cTVnK1dIbnVwUWVpcllkbzFtVGFvVGV0YzdJU1JoWURGWGUxODBYd0ljU3E2?=
 =?utf-8?B?cjNrblBxSHUwTnF5VmtXeFFWdWgwSEM5R2NsREFSY24vQ0ZPaWkwZmNZaW9I?=
 =?utf-8?B?L0I2all2OUJMdHpqZWRZSW5odFIrREYyQytjRm5mOEVib3hHeGZhME85cC8x?=
 =?utf-8?B?TkZIOWJpYkhUWHBzZUlGMFg3eU12VXNwSVhmQm9uYnovSGNTcFhCN0xrb0Nr?=
 =?utf-8?B?eXpHaGprMEJVajRLVmlQZmxSWjRJTEdMOU9aUW0vTWtnN1JBeE1KMVI1THgx?=
 =?utf-8?B?aWhVcTNYekt4cFpNd3YzeEVFMHQvVXAxUU5aTGJ0aHI4RVBjMGtDRnRucmZQ?=
 =?utf-8?B?SXhGZThvd0VKTGJpd1V3aGswVGM0b3p6MDlVbVVEUVpDL1c1S1N4czVWa2ky?=
 =?utf-8?B?ck8wMlFVZTE4enBvaDRXdkdZY09SU3ErbkpkMWtIclNxVnFHajVXeXRUNkJ3?=
 =?utf-8?B?SzllNkxXU3JndEN3MU9WNzJlS1FaRURnbXBDTXBIY3loVThVRWsrb0d1Z1FV?=
 =?utf-8?B?TjBuV3VzQWx4ejBVM3BEZG9PTEV2UVc3NWp0OVQ2QVRDeis2OGZmRU1WUkpx?=
 =?utf-8?B?UW9sUUlHTC84aVVXMkZYUXV5SVUvVndIZStiUllpcW5Ka2NqaXN1SnVOUERy?=
 =?utf-8?B?Tmhwb29BRHEvOTFIYi9oQ0NZN3J4VlZIN01SbzVSNS9UV0tWOWpqZ0NNMFpO?=
 =?utf-8?B?cnBvcWhyQXlkY3htRXFzRlVBcVo4K3JCcXM5N3JNS0NhVzVFekMwa3AwdVJx?=
 =?utf-8?B?eitHbFRyYUhGV2VQWEl1SHNacERXLzhaUjNqSjA1R2ZBM3JHQnA2SHVyR0kv?=
 =?utf-8?B?RmxMQzJiWHRzRGxBd0owRGg4R2ZRSjE5cnlIYkpqYnFKRUNTMnJsN2xsR3Jt?=
 =?utf-8?B?cmduZXN1ZnEzWW96dE9jOERKN1hvd0kxc045a2pxa0w3alJwN1FvWGdoRmdp?=
 =?utf-8?B?RzZWZU1XNnZVTTJvVGw2OWF1aUd5VDFyOFh4d01GNW12Ym1aUCtKSFFCR0xE?=
 =?utf-8?B?bDRNU1ZVdWUrNmRSU3hwQ2RLRVJyUUV4dm1HS3ZacVZiS3RIOTU1d0IyL2lG?=
 =?utf-8?B?TVB5eEVFSGtVWE5YeUlTN2JzNDdHT0tnMFBPY1QrK2ZyZkk5Vm9tNHN1RWlY?=
 =?utf-8?B?SDdnbXEvZE1oQXpoeTFoVjEzdXlCWkdtVTBoM1lyTDRXSmhhOXBlTlZOaVdZ?=
 =?utf-8?Q?LVwoov5KpsjT4vR/d/UccPyFo9Q9Z4KjZNiqk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUNUbGJrNmRyRVF6YTI3aEtKcHdtZnM2TWRjTHN0OTZxWVdCUE9mSFpaV2lO?=
 =?utf-8?B?TXMyVlBjaTJqMkJ6MTh4MVprcFZ4YVNGekd6c2hmVyt1b2hVN1g3SFYzWER5?=
 =?utf-8?B?MTNITVZoVUNySWdFMjVRVll4aW5INE9YMU52TndYeUxqb2FTOFhZQnFJUU1C?=
 =?utf-8?B?SjU4NGE0cVV5K0xJZ1FoK2pZM0FpZUxBVm9qY3BWcVUzdU5nYmkxVDdOaFdx?=
 =?utf-8?B?Sy9WaFV5NUNENzUrL01ySWtpdFI3QU8xYTFRZXRBM0ZmVERhOVJxTldrSTVB?=
 =?utf-8?B?ZkJRRlcrcW95WU1lK2JjV25pUU10SnpyLzZ2eit3aW16MWVxVnJyUHJRY3JO?=
 =?utf-8?B?L1Y1S0kvUU96NFgvTlBtMmUwVVo3MlVZZ0t0c1dabzR2S1JxVG9JZzVUcTRt?=
 =?utf-8?B?RHNzSlVtU1BLVDFsN25ZTXFsYjBnR1UzOFlpaXZPY2hTMVhFOHVkbU81M3Ju?=
 =?utf-8?B?OXc1azdyR1hKWU5TUG4vUXBFRGxlbFcxb2JodVQwOUk5cXQwZmQ3UGpUbEZR?=
 =?utf-8?B?V1EvWVpXRkVtK1d6V0psb2hRLzdlNWdXV2FQZHc2OTZIYituSFlKY002RUNa?=
 =?utf-8?B?TGRXQWk0YndmNzRVR1c2T2c5MU5NMGNvc3ZZeVBxVWRPMUxZTU43blVCN3Q4?=
 =?utf-8?B?YURhYys3RWtkK1Q0NUVoWWl5bGxNcTRwK3gwQlRXTkxoSi9MRWJkcUlqNXhF?=
 =?utf-8?B?NUJYU3NUOFdDK3ZENnhiR1BHdE9LREJlRitHb2ZpdlUxd1pGekFtQTRtVnJF?=
 =?utf-8?B?TXIzeUhWRTRodGVNZFVxOXlPdEtCNzdCUUlSMmtmc3pRUWlBQnc0YnVWM2wz?=
 =?utf-8?B?N1hWN0JYRG85eWdXOWRYb1dub2FGUEl3ZEpFUTkvVXZ4WEhFR1JhRWVvSlR5?=
 =?utf-8?B?TWUvREVtait4OHBOS0Jac2NhWVJXOVNZYU40ZEx6eGlZbUpaSCtCdTl0SjRR?=
 =?utf-8?B?dkJYeVpvZWZ3b29VcXJkQzdPcFQxUHJrT3p1OWRtQlBGOXNTWWxsSXZvRWxp?=
 =?utf-8?B?d3pGYVZyTkphbENORjJ6NVlzWHhBbm41Mkw2ZDVkY2JBdE80MlRteVlkc1pu?=
 =?utf-8?B?amRsN0RvakszRFpxaTNRempoMDZxcjhjV0UxOGRLQmRKa3Z0bysvd2Y3VWxY?=
 =?utf-8?B?RXF0UlhYalIvVk81MlR1TU1LTUlpTUlGclpHZjZrNDUzbEdQdUZaS281Ny91?=
 =?utf-8?B?cjMzUGJzZUgzemRjRG5EeWplWlNQeUgwc2VzWlZGWE1aMVk2UXFuc0pUZk1p?=
 =?utf-8?B?blZscThVQzZHL01pd01YdkJpRXh1N096cjVsaitnLzVraTBVT01hTjlielVK?=
 =?utf-8?B?TEhCUFp3TEcxeENjMUV2OE1xZ1JZY2hUR2YrS0VJeHhFZzJUbmtza2UzcTdy?=
 =?utf-8?B?ZlN1b3hxeUJNV2pNak41SFVxS2tsZ1FaSDdUZ2NWVmJyYkpEbUlNb1dxOEYv?=
 =?utf-8?B?cThtSEVmbmRIOEdudnl3My91Mk8wSERGMGlzN09VcElKS01SOGFLTlpaS1pQ?=
 =?utf-8?B?em5WOTJNWGJNNGVOT212YlFBblZzaCt4aE40cnZYZjRhaHdJT05tUWZMS05l?=
 =?utf-8?B?VDhmbmZVcHZtckhoZk5GN1RnemtVb3JVZWU5Ym1zOXd5VmU0SldML1lQa25O?=
 =?utf-8?B?aC90bVliTkJ1aml3Wm51T1ROOWRxcXRpdEl3anhUekE2ajdVZVlQRkwycG1T?=
 =?utf-8?B?QXVlRnRCdXdqSXJadkttUllrL0N1b1hOMmNWYm5Ccndkb0FMdmtrR1BRSTc1?=
 =?utf-8?B?NmM3aURZOUZSUHVZSXRtaVR0ZWdXNDZXSXdBSGJNakZ2aFRQd3c5dVMxdmNq?=
 =?utf-8?B?WGZ2WUZ0TnJNTHg4MTdjQnF2UFVzWEZLc1NTeEUrRWJ5cHI4Uy9qSy9nZWxn?=
 =?utf-8?B?anVOSWphMGRrZkdKLzBraWloSWJJRy9lNnRsMFQ1T2pjUUIwSkRDYUtQRVND?=
 =?utf-8?B?MCtKOGRuVEVJaUNCOVRBdUFnUlhTVGEraGJNQW1GNWVsYVRVSGNvMCtCZmxp?=
 =?utf-8?B?ZFRrQlhBT0d2TEZCVC9qZXREVzh0VEFPeUlJKzNrZ0I4eEVnY2VuTE1mcWEx?=
 =?utf-8?B?bGY1RnA2TlhVaE00Y1VydXF5eU1RUUZqYkUzZFNNTWhIb2lXQUkyQ0hkSDFl?=
 =?utf-8?Q?E1Ms=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a352bd67-4b86-4c35-b22a-08dd08964ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 12:33:01.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ll7IeL8w9sZmPnBMh+EFbeZ2vfODjiVgzTIxJmFEo3Wl5bLuQfBEaNaxc+9HS8JlamKfc3vXxd4SgPF83tumpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6753

SGVsbG8gUHJhc2hhbnRoOg0KDQo+ID4gQ29uc2lkZXJpbmcgdGhhdCBpbiBzb21lIGV4dHJlbWUg
Y2FzZXMsIHdoZW4gdV9zZXJpYWwgZHJpdmVyIGlzDQo+ID4gYWNjZXNzZWQgYnkgbXVsdGlwbGUg
dGhyZWFkcywgVGhyZWFkIEEgaXMgZXhlY3V0aW5nIHRoZSBvcGVuIG9wZXJhdGlvbg0KPiA+IGFu
ZCBjYWxsaW5nIHRoZSBnc19vcGVuLCBUaHJlYWQgQiBpcyBleGVjdXRpbmcgdGhlIGRpc2Nvbm5l
Y3QNCj4gPiBvcGVyYXRpb24gYW5kIGNhbGxpbmcgdGhlIGdzZXJpYWxfZGlzY29ubmVjdCBmdW5j
dGlvbixUaGUNCj4gPiBwb3J0LT5wb3J0X3VzYiBwb2ludGVyIHdpbGwgYmUgc2V0IHRvIE5VTEwu
DQo+ID4NCj4gWy4uLl0NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L3Vfc2VyaWFsLmMgfCAyNSArKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPiA+IGIvZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCj4gPiBpbmRleCAwYThjMDViMjc0
NmIuLjlhYjJkYmVkNjBhOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vdV9zZXJpYWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X3NlcmlhbC5jDQo+ID4gQEAgLTEyNCw2ICsxMjQsNyBAQCBzdHJ1Y3QgZ3NfcG9ydCB7DQo+ID4g
IAlzdHJ1Y3Qga2ZpZm8JCXBvcnRfd3JpdGVfYnVmOw0KPiA+ICAJd2FpdF9xdWV1ZV9oZWFkX3QJ
ZHJhaW5fd2FpdDsJLyogd2FpdCB3aGlsZSB3cml0ZXMgZHJhaW4gKi8NCj4gPiAgCWJvb2wgICAg
ICAgICAgICAgICAgICAgIHdyaXRlX2J1c3k7DQo+ID4gKwlib29sICAgICAgICAgICAgICAgICAg
ICByZWFkX2J1c3k7DQo+ID4gIAl3YWl0X3F1ZXVlX2hlYWRfdAljbG9zZV93YWl0Ow0KPiA+ICAJ
Ym9vbAkJCXN1c3BlbmRlZDsJLyogcG9ydCBzdXNwZW5kZWQgKi8NCj4gPiAgCWJvb2wJCQlzdGFy
dF9kZWxheWVkOwkvKiBkZWxheSBzdGFydCB3aGVuDQo+IHN1c3BlbmRlZCAqLw0KPiA+IEBAIC0z
MzEsOSArMzMyLDExIEBAIF9fYWNxdWlyZXMoJnBvcnQtPnBvcnRfbG9jaykNCj4gPiAgCQkvKiBk
cm9wIGxvY2sgd2hpbGUgd2UgY2FsbCBvdXQ7IHRoZSBjb250cm9sbGVyIGRyaXZlcg0KPiA+ICAJ
CSAqIG1heSBuZWVkIHRvIGNhbGwgdXMgYmFjayAoZS5nLiBmb3IgZGlzY29ubmVjdCkNCj4gPiAg
CQkgKi8NCj4gPiArCQlwb3J0LT5yZWFkX2J1c3kgPSB0cnVlOw0KPiA+ICAJCXNwaW5fdW5sb2Nr
KCZwb3J0LT5wb3J0X2xvY2spOw0KPiA+ICAJCXN0YXR1cyA9IHVzYl9lcF9xdWV1ZShvdXQsIHJl
cSwgR0ZQX0FUT01JQyk7DQo+ID4gIAkJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KPiA+
ICsJCXBvcnQtPnJlYWRfYnVzeSA9IGZhbHNlOw0KPiA+DQo+ID4gIAkJaWYgKHN0YXR1cykgew0K
PiA+ICAJCQlwcl9kZWJ1ZygiJXM6ICVzICVzIGVyciAlZFxuIiwNCj4gPiBAQCAtMTQxMiwxOSAr
MTQxNSwyMSBAQCB2b2lkIGdzZXJpYWxfZGlzY29ubmVjdChzdHJ1Y3QgZ3NlcmlhbCAqZ3NlcikN
Cj4gPiAgCS8qIHRlbGwgdGhlIFRUWSBnbHVlIG5vdCB0byBkbyBJL08gaGVyZSBhbnkgbW9yZSAq
Lw0KPiA+ICAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KPiA+DQo+ID4gLQlnc19jb25z
b2xlX2Rpc2Nvbm5lY3QocG9ydCk7DQo+ID4gKwlpZiAoIXBvcnQtPnJlYWRfYnVzeSkgew0KPiBz
dGFydF90eC9yeCByZWx5IG9uIHBvcnQtPnBvcnRfdXNiIGZvciBxdWV1aW5nIHRoZSByZXF1ZXN0
cywgYW5kIGlmIGl0cyBub3QNCj4gbnVsbCBkdXJpbmcgZGlzY29ubmVjdCwgdHgvcnggd291bGQg
a2VlcCBvbiBxdWV1aW5nIHJlcXVlc3RzIHRvIFVEQyBldmVuDQo+IGFmdGVyIGRpc2Nvbm5lY3Qg
KHdoaWNoIGlzIG5vdCBpZGVhbCkuIEhlcmUgaW4geW91ciBjYXNlLCBhZnRlciByZWFkX2J1c3kg
aXMgc2V0LA0KPiBzdGFydF9yeCB3b3VsZCBxdWV1ZSBzb21ldGhpbmcgb3V0c2lkZSBvZiBzcGlu
bG9jaywgbWVhbndoaWxlIGRpc2Nvbm5lY3QNCj4gaGFwcGVucyBidXQgcG9ydF91c2IgaXMgc3Rp
bGwgdmFsaWQgKGJlY2F1c2UgcmVhZF9idXN5IGlzIHNldCkgYW5kIHN0YXJ0X3J4DQo+IHdvdWxk
IGJyZWFrIGVhcmx5LiBCdXQgc3RhcnRfdHggY291bGQgY29udGludWUgcXVldWluZyBpbnRvIGRp
c2Nvbm5lY3RlZA0KPiBVREMgKGlmICdzdGFydGVkJyBpcyBub24temVybywgd2hpY2ggY291bGQg
aGFwcGVuIGR1ZSB0byB0aW1pbmcpLiBDYW4ndCB5b3UgdHJ5DQo+IHNvbWV0aGluZyBsaWtlIHRo
aXMsDQo+IA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0K
PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPiBAQCAtNTc5
LDkgKzU3OSwxMiBAQCBzdGF0aWMgaW50IGdzX3N0YXJ0X2lvKHN0cnVjdCBnc19wb3J0ICpwb3J0
KQ0KPiAgICAgICAgICAgICAgICAgICogd2UgZGlkbid0IGluIGdzX3N0YXJ0X3R4KCkgKi8NCj4g
ICAgICAgICAgICAgICAgIHR0eV93YWtldXAocG9ydC0+cG9ydC50dHkpOw0KPiAgICAgICAgIH0g
ZWxzZSB7DQo+IC0gICAgICAgICAgICAgICBnc19mcmVlX3JlcXVlc3RzKGVwLCBoZWFkLCAmcG9y
dC0+cmVhZF9hbGxvY2F0ZWQpOw0KPiAtICAgICAgICAgICAgICAgZ3NfZnJlZV9yZXF1ZXN0cyhw
b3J0LT5wb3J0X3VzYi0+aW4sICZwb3J0LT53cml0ZV9wb29sLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAmcG9ydC0+d3JpdGVfYWxsb2NhdGVkKTsNCj4gKyAgICAgICAgICAgICAgIC8qIEZy
ZWUgcmVxcyBvbmx5IGlmIHdlIGFyZSBzdGlsbCBjb25uZWN0ZWQgKi8NCj4gKyAgICAgICAgICAg
ICAgIGlmIChwb3J0LT5wb3J0X3VzYikgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBnc19m
cmVlX3JlcXVlc3RzKGVwLCBoZWFkLCAmcG9ydC0+cmVhZF9hbGxvY2F0ZWQpOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBnc19mcmVlX3JlcXVlc3RzKHBvcnQtPnBvcnRfdXNiLT5pbiwNCj4g
JnBvcnQtPndyaXRlX3Bvb2wsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBv
cnQtPndyaXRlX2FsbG9jYXRlZCk7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAg
ICAgICBzdGF0dXMgPSAtRUlPOw0KPiAgICAgICAgIH0NCj4gDQo+IFRoaXMgd2lsbCBza2lwIGZy
ZWVpbmcgcmVxcyAoYW5kIHlvdXIgY3Jhc2gpIGlmIHBvcnRfdXNiIGlzIG51bGwgYW5kIGZyZWVp
bmcNCj4gd291bGQgYmUgdGFrZW4gY2FyZSBieSBkaXNjb25uZWN0IGNhbGxiYWNrLg0KPiANCj4g
DQpGaXJzdCBvZiBhbGwsIHRoZSBwYXRjaCB5b3UgZ2F2ZSBjYW4gc29sdmUgdGhlIHByb2JsZW0g
d2UgYXJlIGN1cnJlbnRseSBmYWNpbmcuDQoNCldoZW4gd2UgZmlyc3QgZW5jb3VudGVyZWQgdGhp
cyBwcm9ibGVtLCB3ZSBhbHNvIHRob3VnaHQgYWJvdXQgYWRkaW5nIGEgbnVsbCBjaGVjayBvcGVy
YXRpb24gdG8gZGVhbCB3aXRoIGl0LA0KYnV0IHdlIHNhdyB0aGF0IHRoZSBlbnRyeSBvZiB0aGlz
IGZ1bmN0aW9uIChnc19zdGFydF9pbykgaGFkIGEgbnVsbCBjaGVjayBvcGVyYXRpb24gZm9yIHBv
cnQtPnBvcnRfdXNiLCBzbyBJIGdhdmUgdXANCnRoZSBpZGVhIG9mIOKAi+KAi251bGwgY2hlY2sg
ZHVyaW5nIGZyZWVfcmVxIChtYXliZSBJIG1hZGUgYSBzaW1wbGUgcHJvYmxlbSBjb21wbGljYXRl
ZCksDQphbmQgdGhvdWdodCBhYm91dCBvcHRpbWl6aW5nIGl0IGZyb20gdGhlIHNvZnR3YXJlIGxv
Z2ljLCBzbyB0aGF0IHRoZSBwb3J0LT5wb3J0X3VzYiBwb2ludGVyIGlzIGFsd2F5cyB2YWxpZCBi
ZWZvcmUgZ3Nfc3RhcnRfaW8gaXMgZXhlY3V0ZWQuDQoNClRoYW5rcw0KDQoNCg==

