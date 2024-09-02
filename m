Return-Path: <linux-kernel+bounces-310641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B99967F88
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AD61C21E33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FF4155398;
	Mon,  2 Sep 2024 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mXCqpSJs"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C477F11;
	Mon,  2 Sep 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258865; cv=fail; b=PvIOeUyOZtnhowuykea7aSYxkeDBccJXh5/ZwQUD/+X8i6qfVKfrNy2YYp73FaQ15LM7y4Kvbnot8kWJu3aCh2Taf5dxD+t0C6+0qzdUJ86qgzHwFQMLolz3uPeitL/kstxPP+tuZ6hyfz/5YxKtiyMELa36uuV9CUOF7Qz0iCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258865; c=relaxed/simple;
	bh=7VDKuH9BhH64QGZcAbC3CSsT/QCjsJTI3rz8qOmeolE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nXQh9AEwJKWKOy0NxWawvvl8Cd6caav2u5+RvPWW3skn4b5NdL1yCJamU2FJiwy+tQAnCRXvB8qadufMUzM+GK069OccvfzMoFiebhCBlbG2T7Md4rTicqlsNJfrR8nknpYaizVqQvD8gqd/bRFIEW1B5n9KqOhU3g9tm/KAHf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mXCqpSJs; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYWihoOOfCZ1FNAJSQLlhuDfS/cWm0qwlDpAHZ+0PVzUnq1GKlSjCxMYvstz1PB1kEmmRmMpsl7GIbp7MCmZ8ifrWcBdGvbFzxOY9UDLsCf+epgz6Oz3fsDDqylW6ma0pgzeonwYMkD/xD0/na17VgrUyhUhtEdpZyV8qLY4oWrL4jCATlBtSm9/NndqOn7n0GAMDgL5uNx82YcDdJO63PwBeRye4voy0OiF02TDvn8pd6TCVnRhyVplkdJh/2b0nZRyOYRcpEaY6b+DPEYRn2pZWqDQp+1CUBsus8h7K4nl28b33TQlQCZh4l4RGCKtSwWcloRORx51oTHAbQmOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VDKuH9BhH64QGZcAbC3CSsT/QCjsJTI3rz8qOmeolE=;
 b=ZDvM5YQkywWHtZWrValHojhUsRU1tu+B8R/u8tVRpxYQ1oG5ugZKA6HAX6p4vCMHW1l7ymTK98WysDcO0P68PSHi/w7dqmTSP//jMD31m80Po8Jc5V3+FR/WmAOVUY4sfdNgM/LTaMMMRVco/OZA5VPf1MPRIeulPHVI8XTLSNMmetRyWUm01M5V0qPZANzytlV5L+uk4mZK/B0jsx6wwMpyjgT1FJbrOg2P9HiZsqPLR3OIhyz5z9b2GYCVOwfKmEdZkQUiTtdFOCGqBZKc/KACWWS+SuFXHz060DARfDJLnRE8Nr9/9sogd2vIJbumEP4y05SHte6F2wGJSJojeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VDKuH9BhH64QGZcAbC3CSsT/QCjsJTI3rz8qOmeolE=;
 b=mXCqpSJsjk/GcQ950pMbEYlb8NHX+gDm+Hg+Bgz2eN3gMNlhBjT+ic2VuIDRg89T7xAsFv5gs7I/WAV8HyIqKATxpxWvWPlSzxs+liLf/YEaTeIhZXo8RQHMG8ufZo/XZ5RJ8bcxJC/AZrgEUo/oOvH6AJP9HfmOOrRfqKzgoVo3bAKnzngJCgwZMzmAqZnRCFjplvlA45WoxwCEqqkl/GUaHcTZZbSRhOCrlazJsVZ+GjGsh1Yoi1YKO2B78hibqtmtNuYfrVDqUk1p7kC7TEoPmb72hyCDNJL3ywi+jozVfGenBHrA0FAccKsHP03ku2z4K4PyoJwIPytgf5wTwQ==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 06:34:19 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:34:19 +0000
From: <Varshini.Rajendran@microchip.com>
To: <krzk@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 25/27] ARM: dts: at91: sam9x7: add device tree for SoC
Thread-Topic: [PATCH v6 25/27] ARM: dts: at91: sam9x7: add device tree for SoC
Thread-Index:
 AQHa4YZMeTWeKexZ3kW/54rPazvlL7IQhMgAgCqFTACAADGvgIABSMUAgAA5NgCAB4OAAA==
Date: Mon, 2 Sep 2024 06:34:19 +0000
Message-ID: <1b29f54f-80a3-4afa-aa78-09939b2d5620@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070934.1991467-1-varshini.rajendran@microchip.com>
 <7031d811-2bb2-4325-996c-a6de766925db@kernel.org>
 <bf77fe95-0982-4605-a493-25c889e81639@microchip.com>
 <5fbc815f-d52e-437d-bdc3-c61f365e9d1c@kernel.org>
 <a36c4d23-e2fe-4bf5-a262-5eb9828e6e7a@microchip.com>
 <fe4c8c72-1f7b-4274-a910-4ad803487951@kernel.org>
In-Reply-To: <fe4c8c72-1f7b-4274-a910-4ad803487951@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|BL1PR11MB5303:EE_
x-ms-office365-filtering-correlation-id: e6d169ae-4f7a-4189-ddcd-08dccb194642
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmluTVVkQjUyWDVCUzZ2b05JejEveE5PUmttbENoZkY2S2lOWFA3b05taUtH?=
 =?utf-8?B?ZnpDdDc2VW9takpWWG5nU0IraWd4WkFJc01KcTBIMGk2WHJiMGVnMEZKU2xp?=
 =?utf-8?B?bEZUTk51bWY1VlJ3dnY2NFA0RnlYMzVpQ05oTFVKM0l5UzRLVDljSEQ1dzU5?=
 =?utf-8?B?anBGK0FYL3JWVXN5bjYybG9UYmRBay9CYTBEcjhKSWYzTmk5SHFoeElEM1Jm?=
 =?utf-8?B?SkNHUlNTUXdHaXE2QXk5ckZZOGFEN2J2dXp3V1djNUpzeGZhMkVNNFppQWx3?=
 =?utf-8?B?eVorVjFnVWNlK256RlBzTnM0ZWtBalE5OVJoWjZoTTlpZWtDUDdTNTU4Y1Q5?=
 =?utf-8?B?T09rQTRpNmFEUitnNGt1WDB0M0xxOHNGU1k5bFV4cWNLUVZId05EZENTdmFY?=
 =?utf-8?B?NmZVSjBRNXJiVWFaVjRHYmp6bUxOWk00bHNxdTFIY3RFUmhxaStDaHB5UlNo?=
 =?utf-8?B?aVFOYXdiMmJVWE5wNW9WdkRtcEs5aE1qU2R5cmp4SnBlNlIrNEl0cnU0dWcr?=
 =?utf-8?B?YVBWRVVzZC9EM2ZMdHdobW5ZRHlzY09GcDZyM0orUm8yZ2R6MlR6R1VRaTZw?=
 =?utf-8?B?SUpabThLSWlsWWE2NGM0WVhBQVR1UlhLemlVTFNkdmJUdGhzSmI2OFNVaWds?=
 =?utf-8?B?dnVXUkg0R2g4QkJzek5HcUtBTm5aUW1vLzl1QXU3Qm9pbXluMFBwNjF4OXV6?=
 =?utf-8?B?a2thdVpnZExpQTBrVXZoNkxHOUdZdjByRm9UNWUrYktBbnhFUTQxTkhOZ3Fl?=
 =?utf-8?B?S0ZGWjJvV2xxbXdtdkpQTUM0enExdnBlWFJqOGZ6bm9TeVR0YXd6NVBPVHZv?=
 =?utf-8?B?OW1ZZTd1ZW95K0VTUGt3d28vODBqMnF0WXhVcDk3M1BsdDZEM2Q4WWpxaTc2?=
 =?utf-8?B?OW52cEdQTDJ5M3RQTTZPTFpVanY0aHI3aHNaMXNjS0VHRjh2YUlHNTRIaGFj?=
 =?utf-8?B?azMzNWpWNUtjVTZYaUFJK1R1WUoybzVHdXNrdmo3ckN5c2hPVHNNSGJYUS9X?=
 =?utf-8?B?aHNYaVd5L3ZCN3VXb2NNQVlCNzdyYSs1MzVBUWFPbklleHlFRTdqcFNQcy9k?=
 =?utf-8?B?M0RaRTFZdnVXSlJJbE1nbEZ1bjdQS0xOS2NLR1djRTh1TUR3RVFHQW1KWVpv?=
 =?utf-8?B?S0dNSHYxZ3I3YWRRVjhzQWh0Q1Y5bG5mc1BqT1E3eVpvbGcreEZmaWNBbE92?=
 =?utf-8?B?emtnRWRqMzJyckVOTVJRMFFlV3MvbmxudmVkc21YeCs3K3VmVEIvMWxBZUhG?=
 =?utf-8?B?WTB6QW1oVURVRkhpdGF5eFJ4OVFlSkhGZ0M1dG9ud0xNZzhDNzZkOHFXb1BB?=
 =?utf-8?B?ZDlMeEJDUytZQmk5RmN0SmR4Rk9ZbW9oY0Jwbm15M2FKenVQWFdYRUdmT0dG?=
 =?utf-8?B?Ry9CRmFOV0hDbUowcmhTQStuNk80b05scDJpSm5icTRMT3ZJUHhiL2NKZW1q?=
 =?utf-8?B?eVR2Z3daL0pWcGdqbjl5RGg3UXlYRGd1RWRZYlRhZFdhalk1L2hEcDhhTnI5?=
 =?utf-8?B?QmM1dkc2S09CRlRMRUJQOXpWNlpEYXF3SVRZQW5ka1ZXUFU1dGMwTlg5VjZO?=
 =?utf-8?B?NGVDTjl0MTVrMUtVK0o0M1dGc25DRys1T3BuUDlvbFJ6M3dFVVUxRmhiQnc1?=
 =?utf-8?B?VFhzSWJKSTYraTcycjJia091VXNWUU1nUkpZdzhoRllNNndpKzJRWmlMTmhK?=
 =?utf-8?B?UEMvaFVGbVU3Q29BK2c3Y3pnQ3JKQmZmOCt6NURoQVcrNE1LYlN2VjNPdUdH?=
 =?utf-8?B?LzVBd2o2TnQ2bEJuUTZ0S3lXdGtsVCtDSk5IWVVVVFdnUWVTQ3EwM3R4VDds?=
 =?utf-8?B?WUE3dmtCREM4bHdYUm9MSFUrZ1FESEUwYkpYL2I0TytLQnR4cXpaTHlwQnIy?=
 =?utf-8?B?TDcwdXp5TGJxLzRHT2VDZit0V3l2M0pxV050M29vWTZDd0VucVEwTG1WNFlE?=
 =?utf-8?Q?h51rQdTLUV0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkVqMzJsUUhGQWFSaDk5M3g2SjdwUnpubkFOdmVsSHVvUENLc0Y0SllZYyt4?=
 =?utf-8?B?a3Vhcng1WXptL1krNWpGZkZybXhObzBBSk1mZHg0WWFlL3pNb3c5c01NN2l3?=
 =?utf-8?B?Q1ppb0RHbkltd1V4dk42d2lNazJDMmtnd1QwQ0ZRQUlxb2ZhN3VIbDRha0VX?=
 =?utf-8?B?YnNzdGUwby9wLzRFK1RJR1hwMWZiMm50SUo2QzlobllpY0ZHTnVtVFNrTDlI?=
 =?utf-8?B?OW8rUEoxMHBoWGU3SmdxTUNTWGtGL0pqUmpiaGZZdHpJR0c0OW5aSFhTVTJj?=
 =?utf-8?B?aEl4UkRNU1hBMXczYXp1QTNCNGg0Y3VBanV3anJsRVRyVUJGc3JaYVkrNjlY?=
 =?utf-8?B?MGJ6bjZDREtpS093T2VhS0wvckdBdkUrZStjNzF3ek5UMmhZdWZhZjlTdmNp?=
 =?utf-8?B?NlN5MFNTL1hiMVhMeElkZlVKeVRIeEdZM3o1QTJESG9UUHgyaTJpd1l5OTlY?=
 =?utf-8?B?VEVTSktqUkg0Yy9tZTVXS2xwaWpxQ2E2dFV5eWZXSUlrY2hBaDdIQzZ2eUo5?=
 =?utf-8?B?SG5vdFhPbGhPOXUzRmhuWWlmUXdtYWhYKzhCRnU0YU1HK0hxN0Q0VGkxdndt?=
 =?utf-8?B?dFhIK0tURlRwR0hCZitUM01mVG9NemUvOFFxQmtuZUpZMEJ2R1FJQVMrR2Fa?=
 =?utf-8?B?S1FCcUh0MUxIZ01IMUtrNXozY29oclFEZXY5K3RXT3RWNEVMVU83Qm1zSThS?=
 =?utf-8?B?d2E1VERkV3A1OFZ3Q2k2clJPV2NwY0JCZkhKOEpJYnhnN2VLYytSZi9OY2tE?=
 =?utf-8?B?NEhtMkxoNTJEOThlK2ozajl2ZkVUclZoa1hOZUU1SXJ3cFMzVnhFc2NuMWpB?=
 =?utf-8?B?NmlFRnZqYWVzbU9PSmgzQmJJbW1IL2U2OERRMC9KTmNWcnJncXJMSTRCVXFE?=
 =?utf-8?B?ZlhVQ0ZndWJUZ1E2THRFK0JzVmxGNmVzN3ZaTkdQOXY4Z1RSaFZrQmZ1SGV4?=
 =?utf-8?B?U0hSNndVSFVqVzRXdno4U0x1cUtmS2xzUmJia2diLzNkWjhQMGl3OFl3TVFH?=
 =?utf-8?B?ZU9qakJUMmtEV0NQNXNHT2VodjZCRk1rdW1jVStPWjY0V0dza2xTNmhOQnBS?=
 =?utf-8?B?a0xkcGJyR2t0eHNodUcyWjQ3bGs3NERnamNTbGw2VHFEeEVudU9kYS92alNs?=
 =?utf-8?B?ank2Kyt4ZHNNOTJBOSs3dDdKV0NvUDNJbzhmMnhaU1NRZ21qVnZkazd4bVk0?=
 =?utf-8?B?VEZEdDRoUTBMOXp2dzR3QWJJQ0x3UHlZa3JNV3FhL093QmxKbDVYNHIwSE9a?=
 =?utf-8?B?ZDFvQlB1U2xoUVViUHROeHFRSTZlbTl3RHdCblN0VkQrVGU2VGRwRVR2QXBV?=
 =?utf-8?B?U3lvRENMajRXY2t4UC9vNE5XUlJTNVBndmlMaS8wZ0JuK2t2L0N3WWU0azhO?=
 =?utf-8?B?NG1HSDhxUEdkVjdadXN2eHlPRTVhR3FRU1Fmd0l6SFhyaXMxTGFqQjgycFRy?=
 =?utf-8?B?L1VFNVo4RmRlUkRvNEcrRXdvc29xazVTQzNsWlN5VFFwd2ZhczQ5S0RVbTk2?=
 =?utf-8?B?cW9YYkI4bFg1dDhURHRUK3NuWVh3QllFL2Qwc1Vib3RBWm5DTWx0MGhoTFRZ?=
 =?utf-8?B?Ky81Z0x6TTdIRU1meEYrVXhhUy9WTUdVWWx5bUhrZCtGdVpyT1lHTnlGV2hi?=
 =?utf-8?B?ZEJQUVUzNDV5MUdkT3RqYU9PSGM5MlQ3dWZ3RllacW80eTFMd0JZaTd1VS9D?=
 =?utf-8?B?MVh4a2J4QWdPREM5NkNPazJWM1ozRlYrcDA5MHcxMDBFUnk4dTg5cU5FVjcy?=
 =?utf-8?B?RVYzaFhPYkRzVktqbXdiNkNFY21FK3ExZ3ZPNGpGZXJLS09LMFVGSmRxS2Zk?=
 =?utf-8?B?YXgzV2Uza0NMek1sSU5vWHRQaGRzS3UvYVAveVMxbGhjQ1J4VTl1MUhWTXdO?=
 =?utf-8?B?VFB4aHlIdWZJQTFrT0ZZMnM3Mm9jMEFIL1JEdHNoMlI3bXd4TWtFRjNnYkNw?=
 =?utf-8?B?VlZnc3I5ZysvTUZZV25uMlpJclorOSt5cFdQOVUvN0htMFBhdFZkdFdKZXhD?=
 =?utf-8?B?RkRLdkZhWTZta3NCV3NEZUhTRitvYzg0RXQ4NDZVWVp5T0JpVnNJVTJTOENn?=
 =?utf-8?B?NTBBem1PMWhUTWxWTDVoTDBSRzlMTHlkYjNwVnZBK1pDUmlHQUEwSlMyN3Rv?=
 =?utf-8?B?dW5VSyszMUp2SWVnQm8xM1JHRXU4VmtFc3M4czlvQThJTnl1UE42eWRZbDR4?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C70C0161E758641B0DB20E4A2AACE0A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d169ae-4f7a-4189-ddcd-08dccb194642
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 06:34:19.3161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfO2UzL6+ew5Kn3ULK8q3GC/GgPl2xAotTecZEOnVf7gSp82myQlvgyo7M72l7dqzdaZ76As28TcpHmTpyZ4bmHobvGw52nEdNwq/RS/Tihk3b2nlFnDo8t6lOyUoZ4W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303

SGkgS3J6eXN6dG9mLA0KDQpPbiAyOC8wOC8yNCA1OjE5IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDI4
LzA4LzIwMjQgMTA6MjUsIFZhcnNoaW5pLlJhamVuZHJhbkBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
Pj4gT24gMjcvMDgvMjQgNjoxOCBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDI3LzA4LzIwMjQg
MTE6NTAsIFZhcnNoaW5pLlJhamVuZHJhbkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+PiBIaSBL
cnp5c3p0b2YsDQo+Pj4+DQo+Pj4+IEFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5IGluIHJlc3BvbnNl
Lg0KPj4+Pg0KPj4+PiBPbiAzMS8wNy8yNCAyOjAwIHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+Pg0KPj4+
Pj4gT24gMjkvMDcvMjAyNCAwOTowOSwgVmFyc2hpbmkgUmFqZW5kcmFuIHdyb3RlOg0KPj4+Pj4+
IEFkZCBkZXZpY2UgdHJlZSBmaWxlIGZvciBTQU05WDcgU29DIGZhbWlseS4NCj4+Pj4+Pg0KPj4+
Pj4+IENvLWRldmVsb3BlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2No
aXAuY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVy
cmVAbWljcm9jaGlwLmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWYXJzaGluaSBSYWplbmRy
YW4gPHZhcnNoaW5pLnJhamVuZHJhbkBtaWNyb2NoaXAuY29tPg0KPj4+Pj4NCj4+Pj4+IC4uLg0K
Pj4+Pj4NCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICAgICAgICAgICBjYW4xOiBjYW5AZjgwMDQwMDAg
ew0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImJvc2NoLG1fY2Fu
IjsNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZjgwMDQwMDAgMHgxMDA+
LCA8MHgzMDAwMDAgMHhiYzAwPjsNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgcmVnLW5h
bWVzID0gIm1fY2FuIiwgIm1lc3NhZ2VfcmFtIjsNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgaW50ZXJydXB0cyA9IDwzMCBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+LA0KPj4+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDY5IElSUV9UWVBFX0xFVkVMX0hJR0ggMD47
DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1uYW1lcyA9ICJpbnQwIiwg
ImludDEiOw0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JnBtYyBQTUNf
VFlQRV9QRVJJUEhFUkFMIDMwPiwgPCZwbWMgUE1DX1RZUEVfR0NLIDMwPjsNCj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiaGNsayIsICJjY2xrIjsNCj4+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgYXNzaWduZWQtY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfQ09S
RSBQTUNfVVRNST4sIDwmcG1jIFBNQ19UWVBFX0dDSyAzMD47DQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIGFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDQ4MDAwMDAwMD4sIDw0MDAwMDAwMD47
DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8
JnBtYyBQTUNfVFlQRV9DT1JFIFBNQ19VVE1JPiwgPCZwbWMgUE1DX1RZUEVfQ09SRSBQTUNfVVRN
ST47DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGJvc2NoLG1yYW0tY2ZnID0gPDB4Nzgw
MCAwIDAgNjQgMCAwIDMyIDMyPjsNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgc3RhdHVz
ID0gImRpc2FibGVkIjsNCj4+Pj4+PiArICAgICAgICAgICAgIH07DQo+Pj4+Pj4gKw0KPj4+Pj4+
ICsgICAgICAgICAgICAgdGNiOiB0aW1lckBmODAwODAwMCB7DQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4Ny10Y2IiLCJhdG1lbCxzYW1h
NWQyLXRjYiIsICJzaW1wbGUtbWZkIiwgInN5c2NvbiI7DQo+Pj4+Pg0KPj4+Pj4gV2h5IHRoaXMg
aXMgc2ltcGxlLW1mZCB3aXRob3V0IGNoaWxkcmVuPw0KPj4+Pg0KPj4+PiBUaGUgdGNiIG5vZGUg
d2lsbCBoYXZlIGVhY2ggVEMgKFRpbWVyIENvdW50ZXIpIEJsb2NrIGFzIGEgY2hpbGQgd2hlbiBp
dA0KPj4+PiBpcyBjb25maWd1cmVkIHRvIGJlIHVzZWQgYXMgZWl0aGVyIG9uZSBvZiB0aGUgZm9s
bG93aW5nIG1vZGVzIFRpbWVyIG9yDQo+Pj4+IENvdW50ZXIgLyBDYXB0dXJlIC8gUFdNLg0KPj4+
DQo+Pj4gQW5kIHdoZXJlIGFyZSB0aGVzZSBjaGlsZHJlbj8gV2hhdCBkb2VzIGl0IG1lYW4gIndp
bGwgaGF2ZSIsIGluIGNvbnRleHQNCj4+PiB3aGVuPyBEVFMgaXMgc3RhdGljLCBpZiB5b3UgZG8g
bm90IGhhdmUgaGVyZSBjaGlsZHJlbiB0aGVuIHRoaXMgaXMgbm90IGENCj4+PiBzaW1wbGUtbWZk
Lg0KPj4+DQo+PiBJIHVuZGVyc3RhbmQgeW91ciBjb25jZXJuLiBCdXQgdGhlIHRoaW5nIGlzIHRo
YXQsIGVhY2ggdGMgYmxvY2sgaXMNCj4+IGNvbmZpZ3VyZWQgYXMgYSBjaGlsZCBhbmQgaXQgY2Fu
IGJlIGNvbmZpZ3VyZWQgaW4gMyBkaWZmZXJlbnQgbW9kZXMgd2l0aA0KPj4gZGlmZmVyZW50IGNv
bXBhdGlibGVzLiBJbiB0aGUgY3VycmVudCBkdHMgKGkuZS4sIHNhbTl4NzVfY3VyaW9zaXR5DQo+
PiBib2FyZCkgd2UgZG9uJ3QgaGF2ZSBhIHVzZSBjYXNlIGZvciB0aGUgdGNiLCBoZW5jZSB0aGVy
ZSBhcmUgbm8gY2hpbGQNCj4+IG5vZGVzIGRlZmluZWQuIEJ1dCB0aGVyZSBhcmUgaW5zdGFuY2Vz
IHdoZXJlIGl0IGNhbiBiZSBkZWZpbmVkIGluIHRoZQ0KPj4gZHRzLCBzYXkgZm9yIGEgY3VzdG9t
IGJvYXJkIHVzaW5nIHNhbTl4NyBTb0MuIEluIHRoYXQgY2FzZSB0aGUNCj4gDQo+IFdoZXJlIGFy
ZSB0aGVzZSBpbnN0YW5jZXM/IENhbiB5b3UgcG9pbnQgbWUgdG8gRFRTPw0KPiANCj4+IHNpbXBs
ZS1tZmQgdXNhZ2UgaXMganVzdGlmaWVkLCBpZiBJIGFtIG5vdCB3cm9uZy4gSWYgdGhpcyBqdXN0
aWZpY2F0aW9uDQo+PiBkb2Vzbid0IHN1ZmZpY2UsIHRoZW4gZGVjbGFyaW5nIGNoaWxkIG5vZGVz
IHdpdGggb25lIG1vZGUgYXMgZGVmYXVsdA0KPiANCj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3Rs
eTogc29tZSBvdXQgb2YgdHJlZSwgbm9uLXVwc3RyZWFtIHByb2plY3Qgd2FudHMNCj4gdGhpcy4g
U29ycnksIGJ1dCBvdXQgb2YgdHJlZSBkb2VzIG5vdCBtYXR0ZXIuIFNvIGl0IGlzIG5vdCBhIGNv
cnJlY3QNCj4ganVzdGlmaWNhdGlvbi4NCj4gDQpOb3QganVzdCBvdXQgb2YgdHJlZSBwcm9qZWN0
cywgRXZlbiB1cHN0cmVhbWVkIERUUyBmaWxlcyBoYXZlIGNoaWxkIA0Kbm9kZXMgZm9yIHRoaXMg
bm9kZSBpbiBbMV0gYW5kIFsyXS4gSSBndWVzcyB0aGUgYmVzdCB3YXkgdG8gc29ydCB0aGlzIGlz
IA0KdG8gYWRkIHNpbWlsYXIgY2hpbGQgbm9kZXMgaW4gdGhpcyBkdHMgYXMgd2VsbC4gSSB3aWxs
IGFkZCB0aGVtIGluIHRoZSANCm5leHQgdmVyc2lvbiBpZiB0aGF0IGlzIGFjY2VwdGFibGUuIFBs
ZWFzZSBsZXQgbWUga25vdy4NCg0KWzFdIA0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC9hcm0vYm9vdC9k
dHMvbWljcm9jaGlwL2F0OTEtc2FtYTdnNWVrLmR0cyM6fjp0ZXh0PW9rYXklMjIlM0IlMEElN0Ql
M0ItLCUyNnRjYjAlMjAlN0IsLXRpbWVyMCUzQSUyMHRpbWVyDQoNClsyXSANCmh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90
cmVlL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxLXNhbTl4NjBlay5kdHMjOn46dGV4
dD0lM0IlMEElMDklN0QlM0IlMEElN0QlM0ItLCUyNnRjYjAlMjAlN0IsLXRpbWVyMCUzQSUyMHRp
bWVyDQoNCj4gV2l0aCBzdWNoIGFyZ3VtZW50IHlvdSBjb3VsZCBjbGFpbSB0aGF0IGV2ZXJ5dGhp
bmcgbmVlZHMgc2ltcGxlLW1mZA0KPiBiZWNhdXNlIHNvbWUgYnJva2VuIG91dC1vZi10cmVlIGNv
ZGUgYWRkcyB0aGVyZSBjaGlsZHJlbi4NCj4gDQo+PiB3aGljaCBjYW4gYmUgb3ZlcnJpZGRlbiBp
biB0aGUgZHRzIGFuZCBrZXB0IGRpc2FibGVkIGluIHRoZSBkdHNpIHNob3VsZA0KPj4gYmUgdGhl
IG90aGVyIHBsYXVzaWJsZSB3YXkuIFBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHN1Z2dlc3Rpb25z
Lg0KPiANCj4gTm8gY2x1ZSwgcGxlYXNlIHBvc3QgY29tcGxldGUgYmluZGluZyBhbmQgY29tcGxl
dGUgRFRTIHNvIHdlIGNhbiByZXZpZXcNCj4gdGhlc2UuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KPiANCg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpWYXJzaGluaSBSYWpl
bmRyYW4uDQoNCg==

