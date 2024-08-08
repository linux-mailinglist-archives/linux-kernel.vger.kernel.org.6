Return-Path: <linux-kernel+bounces-278947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD42B94B6EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5611F22B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47526187878;
	Thu,  8 Aug 2024 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="N+4N1keE"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022116.outbound.protection.outlook.com [52.101.66.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511615228;
	Thu,  8 Aug 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099814; cv=fail; b=Nts9e3gf6JA3geQIQ3AtyiVbCVDb5Lbh6ODaTfcc54olAsJ7/R7CwqYJis697n2akbOuTD2ngDAQHE0XhY/+vFwlx24YtxUEhOjfNLB5WU01iCoIWljY//tVGrCLm2Nrn79lGxDBEW73cNYBtLXf/c/Rrp7ClrMeW6ksyDM08Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099814; c=relaxed/simple;
	bh=2L+VDZ5NU3OuM0VB5MG0XNbKNk/nqblLhSR0rv6FDVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAk8+7KvoVvAtsM8EX+jgnkxqQzLi2O1sjbbltKUTOYJaY7ESnavxsCKNOngje45j3lbndEIxIypt1Vf3r4F6nEnffktsXlKmPpUQVAbGNZGrCXZaSCxVPJgpC+OAOxaqsn3Hoa1swCApsTAIZ2X9BMHaX9bAGJoW+kKjtjmH9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=N+4N1keE; arc=fail smtp.client-ip=52.101.66.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROIzmgjDEpSqyxqU3OvR3b58Mcl81YJZeB1R7hHEGZaQ/OOzshGBotqU/FrnXer482WNjZxE0mDjIizmQR+N8cYte6zpLWRsUluQMPe97JQzp/AMSrWrVYf2ZXKzRBXSlv3msvNcc9L+8ABWkYTp9JhDe2HHnUEmxCamrowkqhGq4imN99lo47dfFfFZM/Jpcd3CKdprHHYi4ApIf17yWN4yW4ziJv/UB7M+nHSBjABuAcKTxq7lxI6YmftrjGVN5jolHnrWrivV2Kf+Hr2a1gf3h6GOqdbWoqLL83Va9mAwDIfPUUrDmbPqicdW4YCyBI2MT3SwWtGijrYeqGuQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L+VDZ5NU3OuM0VB5MG0XNbKNk/nqblLhSR0rv6FDVQ=;
 b=i4MfZz13qvOH/4THIZWV2YUMaPrSrHmarEaHYbPO4zp+UvB03qSxfJdzQjfs0/Q//PlGFV9rTFAuWgHopZuI3buHezYfFQiU/sJzy/1/g/0737wYrFYf/10zSAVw1D/fysqAfHyiyaBBSyUelDyMZU8edXK0cFTDtrCvM0rtOzWbiWeauAkG+oODlx7i8ZYCI+zQrktkmKlXELMwhqAni/2oraaxZf+9wiQn7M0d7LvHkMJMRM+3pVxSIdaIAcSfsIeg+kausGemp1WPr8yViahmpmrFCg2zpUW2v1gE122gnUa9+Qhz+dbsIRogEptAL1mfTndeOIYD77FYw85YRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L+VDZ5NU3OuM0VB5MG0XNbKNk/nqblLhSR0rv6FDVQ=;
 b=N+4N1keEegkBfHSsA4XWOftWOK2gxdeXqmeGwKeBA5E8+bHvCYs3dUTcwPpzsRtRTiqtlKI744t+vTAJSDmqGW8sUVEsvYANtFWvnF7fDlAbPY3N443XRxC2Ww1sVVXd8YOKWzDWELGsKFSpIa9zW/cpv+Pq1ICV1lPeG9cBhP4=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 06:50:08 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 06:50:08 +0000
From: Josua Mayer <josua@solid-run.com>
To: Logan Bristol <logan.bristol@utexas.edu>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Matt McKee <mmckee@phytec.com>, Wadim Egorov <w.egorov@phytec.de>,
	"linux@ew.tq-group.com" <linux@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64* Disable ethernet by default at
 SoC level
Thread-Topic: [PATCH] arm64: dts: ti: k3-am64* Disable ethernet by default at
 SoC level
Thread-Index: AQHa6Q6Xslxv/i17FUeDMsR7xIZ7BLIc7EuA
Date: Thu, 8 Aug 2024 06:50:08 +0000
Message-ID: <16f9ab4a-62ce-4406-94d4-1441e459469b@solid-run.com>
References: <20240807211342.1660-1-logan.bristol@utexas.edu>
In-Reply-To: <20240807211342.1660-1-logan.bristol@utexas.edu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB7703:EE_
x-ms-office365-filtering-correlation-id: 64714654-1070-4d69-7c0d-08dcb77657af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzRZcHdVMk90QTZULzhzK3NBS0JCdklpVXRxcHFsd21xMDFEeS9uSlU4RkVF?=
 =?utf-8?B?YzZBWlN2M0ZrcFdjS3B2eTlBZFRxYytuQ0gvME1zQ0NXcDR0dE9WOG5mRERK?=
 =?utf-8?B?QTJtOWJXZ0k0V28zMzFiWDYyNDA3VW50Y3JUam1pZEVTbHltS0pMVnZ4aXpk?=
 =?utf-8?B?RThKbmVKaFNiYmd5MkhDYk15bGlJTU5yZktBU3JQQTVBTDQ0MEJvdG1xYXRx?=
 =?utf-8?B?TDRhK29MQlcxc3Y0cUdBbDg0NnpydlZ2Mk5sdDROYkcyTnVwcGV1OXMrYm56?=
 =?utf-8?B?YTB3cC9JT01DNytlRHJmbXZqZ1dqdkFWMi8rR0ljY3FYek1IOUJDNzNUN0NR?=
 =?utf-8?B?RFdFMFJ6dlZiQXhpaFExWE02SndQSklHNUxUUkRhWXRZMTk1VkllejZqVUF1?=
 =?utf-8?B?aENSeUY3cFpQZGtnRFZlNXNHNmkweWs5MjE0S1BkMDUzYUJVd252MXlZanNE?=
 =?utf-8?B?QnR4Qit4ZU9rc0grL0xWQlhDWEJVRzNTNFdRSGJVV2VMTGttYk1oS0FieFdF?=
 =?utf-8?B?YmZHWURwRlVDdTNkVmR0ZzFSTkxXY3gxUHZ2ZldQR2FaeVNTV1BlMnFieCtu?=
 =?utf-8?B?ZkhKWkRzdFFJQmtFSXZPVDB4ZjgxbHRUZTlqbTA3d1JOc1pCMkQxOWNkZWN2?=
 =?utf-8?B?eDlEOW16d29KeU1oNnhRdnVFYVZwT0MrOWpVQjV5R1JrLzB3YzhPdUtEU1U1?=
 =?utf-8?B?Q1I2ZG5OQ0ZOcXN5L3JEdms5c2hsVWJVQUVINTNtU3k3RzNzSDRnem16cG1G?=
 =?utf-8?B?amU4VzJGbGlNQlZpeCsvOENqR1NzemwzY0dFQm52VDNPbTJXbUFJTkxOUzE4?=
 =?utf-8?B?ZTZ2cnhxQW1uZ0EwK0duaWpRZUNuSjFpRXpralhodEM4ZmNLZkNIUTM3cEdJ?=
 =?utf-8?B?K1JTK2JZcjg5cE5jcDJPckd3cy9rR2lFK21NVEZFOWs0eFZyMS9kUGc0VGpw?=
 =?utf-8?B?NDJocm5pcUM3b1pLMHhjMFdOT2trNTM0ZTF5b3lYSmpoZmIvZlB1U0IzRjJv?=
 =?utf-8?B?akR3ZEF3aWd3NHlmVDIyTzZCaWwra3Z5Y3JUSHhJUnJEeXFlKyswSzB3OTlE?=
 =?utf-8?B?Snk4Y1kySjh6aTVicGtXeSsvV2s4T2lzMlNMbW9HbnhJcm5lanZSSTJJbU9K?=
 =?utf-8?B?T0g5SWIxeWwyejB1alFWcnNpZmRBSU5YWVNHODdkU2wvQ0RzdW5TWlRvSjVT?=
 =?utf-8?B?Z3Rwbm9BTkIvd25KSEN6NDZKWitXZlpGeXNPWkRiYm9QR3lCT0p6UFozM2Jt?=
 =?utf-8?B?Z0FOUHlxUlUvQWdKSW9nazVjc2FrYUwrUFdWWHZPNjNDbTFFZE1uMUlTY3BT?=
 =?utf-8?B?ZjhyWW11cTRiSEI4Wm9nQlVzUk9ZVmwvQU1ZSFhlL2w3azNkNFpQUTF2b2JZ?=
 =?utf-8?B?bEZxSFhuM0VsK1pWMFZGOExPbEFBVVVHazNibnpBOStaVHFNa29OTEZ1Z2Fm?=
 =?utf-8?B?a0lZMTl6bHE3UTFjbm9EN3hBU3BybGhxbE9LRHJsWml5aU8wWENSaitLZTFH?=
 =?utf-8?B?QSticTdpZTdCOTFGc2NJWDF6b01EaEdLQVFWTTlrQis5R2p6dlRtbFNtbDBq?=
 =?utf-8?B?VUJub1dCSUFNenhWQk0rVEc0UmFjOU0rOHVTMitteXZMZXQ3UU5objBpRXVt?=
 =?utf-8?B?NVFqTXdEZ2Frc1NvZUt3WlJiVlByWDRKemRGaWlxMFV1aUFFL0tsTktwL05X?=
 =?utf-8?B?VDJaU29LdHF5dG1SbER3SVZzOWQ1bGVIUmsybkdneVp0WWQrRzZBcmo1Y0dz?=
 =?utf-8?B?VW52a0QwbktkZHgzeHZIWldjNGpVeGVPQ1dlbVZSYVdEdTVYWVB6ZzBuRGli?=
 =?utf-8?B?UzJNSllpcGxzdXg1RjJBeHd4Uzg3WVJFQlRrSEZ6VFA1S1ZtaTJic1M5QUhV?=
 =?utf-8?B?MnAyMnlLd1BuUUJwYnJseFg2NHVTRDMwaUdXMy9Fcm5TYXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWZtVDAxejRzMThPTHdhOS9JT2RsNWdyeXcwdDV2ZHlEalBZeDJsTnNDdDJr?=
 =?utf-8?B?RmZyM1NJaVkzblFpL3oxQmJvcWJaNUhzOEdYTzVrRW4xMFRjOUxiR0h0eWQ0?=
 =?utf-8?B?cUptTFc3alVsN3R6amkzOGFqK2F3VXVFY0xEbWVhTzI2eTNxZkNhZEZUVXg3?=
 =?utf-8?B?aTFHbVg2NlYwcXZPQ0hZbHcvcmRlYytsLzhpeUtPOWlxRjhWOGdhQys3OUpX?=
 =?utf-8?B?OTU5RUhyY05kenViaDc2NTdQZVVKRnUyZ0dPbUNYaWVLSTl6SXJIMFNRU0Jj?=
 =?utf-8?B?NHRQZTgvTWRMdW83aWVxdjJtVnJFdklxRDVBTE8xY0JXR1dEbm5IQXFGSG0z?=
 =?utf-8?B?MCt2WnVHTGFnczdNQkhvUzRYMzZDTG5Sekp0UkZISCtObmU1YmF1dkNRVDhH?=
 =?utf-8?B?UnpmRXY1UzFqSVhsQ1lYVUMzbEFBazh1Y1Zodnc4TVF3ak05OGZVcldGTmx6?=
 =?utf-8?B?MlZjbE5XRTREWkIwUFdLRit0d0VpSEFQYk1GMnVhaXdkZGtRb3NhSGx0ekIv?=
 =?utf-8?B?Z0wxbzg4ZjNlZllzalc4cXhzOWtmTE5QMUVRNGtFRCtmczlqR2pGRk1ucEZH?=
 =?utf-8?B?S3FiMFZCM1IzNVJ1VDBleWlnakZxK1dPVVB4YlJaWEJpaFp3SlA2TjMvemlP?=
 =?utf-8?B?NFF0S0gxVmI5b0tKTnZPMlNxa25vakFyS05NdFFXTXg4VVR4Z21LVjUzODlt?=
 =?utf-8?B?SitwRnRya0VhbEw2Z3p4M0tva2ZqeExtMU5FR1VLeWVRMzdUL0tqMUlwK0Ns?=
 =?utf-8?B?VXJZenVGMDMwM0t0UFJKQjRFTVJubnZQSm5Eak5yb2dNRFBUUUJUd1lpYk5l?=
 =?utf-8?B?STlIWXd1MzFYU25PZjB0UDlJWTQxYjhwa3p3VERmMzZEQXNtRDc1UDU3MXU3?=
 =?utf-8?B?MHhSUXpEQmREcmdCM0E1MnlTTXVXT05Ebi9pUmRHd3NDTGdNQk84SkVseURN?=
 =?utf-8?B?dDZ0QkVWY3BLeFVWU0ZYTmd6ZlIvaWQwTHRRU2t1aXF5S0hqWmNHeGtCOE1J?=
 =?utf-8?B?S0wwWE5tVW0xY3dsL3hmTFVwSXRpdVg0b0VOM2lReUk1MzFZZjUxSmg3MWM1?=
 =?utf-8?B?b0IyRlR0QXZUTzl2Y3dPU2VEbzV6Ym9ESHJQenZ1RURZNHBiZXoyNlBOWU83?=
 =?utf-8?B?akVlMkFvbGVYZEw5OW1NdnYxMlpnaWVkQzNMQXpjSm0vbDQvUW9WWFAyeHAw?=
 =?utf-8?B?eGh2by9qbEFHNUFCOUFvc1REcGg2VDVrcXVMcTFhL0Jwd2RuTHRyQVVhZmFi?=
 =?utf-8?B?UHF5aXpPdzNHNnhjNHBlcTVjTm11cDVMSEtQcW9yR2tGaVZydnE5eXVrU2Jl?=
 =?utf-8?B?V3lkL2pUMnNqRXBzQjVnOFV0Ky8rbnUvcy8vRll4RkwvbEZhYnFTT3FZODBZ?=
 =?utf-8?B?ODkrcG5XanhkNWxZS0Nrc2NSMW9Td1hhVURJTFZIeGFUVkgwSnoxV0tDMVhN?=
 =?utf-8?B?bkFUazBGeWllSU5BZ05wTURXZFByelpKbitqZU1ndXMwWWRxVEx4UE9CUmNW?=
 =?utf-8?B?K2cxeHFOMDhzWDM5YngyOVpTZ1pFdGlXQ3ZURTNmV0xONkN2SWpMN3NQQWVw?=
 =?utf-8?B?dFVpZUQrZEZYejJkM2hwZTVoVEdINDczVEpCSTlwSVdyZ1ZCajRIMUpEZnpx?=
 =?utf-8?B?NG5uSFpnVDJvYnJTZkZsTHZDcHV3cDRBbjMwcXpqTVdyZnVDY3oyUnBFcnMx?=
 =?utf-8?B?bWJ6cHRsRytMcEE1OXd4UVRWWVFDTGFiNHJJSjFDQXNvZHRlUkxUWDlaNGJw?=
 =?utf-8?B?ajArSVpDQ1RvTTgwV2NNbGM4SkRnVjhMS2NhaGh4U2NBNkR0Rkp2TWc2SU5s?=
 =?utf-8?B?RFdIYTVuVGVZVmRKdTVMYnZVMGFNcDBOTmJBMnBkTFdOR2FWclNISU5FNUdT?=
 =?utf-8?B?ZC9VTzN0cDNNd0FiWTQzTTFNcjVReDE4YkdWVHl1OGFIWXptWFR2Ri9BbjZv?=
 =?utf-8?B?dkJEUzQrMll2QWlwVWIvK2xMNE5KeUdTbURxOU9ZWEJzREhKN294ZEtwY0s3?=
 =?utf-8?B?QXh4TXhqaVd6YVlsVVFtLzQyNnVaRkpMUDJWWGhPMDkwL3B5SzdpTHdraVdw?=
 =?utf-8?B?SFFrN3dubnZWQ3B3VWttSlprb3Y2YXlwVjdCeFdQempnRm5lSnBVaHJyWjdx?=
 =?utf-8?Q?0Q4w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F4FA294E724B84DAD68236EC7A0D5DE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64714654-1070-4d69-7c0d-08dcb77657af
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 06:50:08.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBuo4PxhUcIfThlwi+fNU2gJGa8WsEGPDgfAcVpZccno+yF9nPBRK7BnyuG5K+FyQVg3ZMTLvNU43OnpGdKNaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703

QW0gMDguMDguMjQgdW0gMDA6MTMgc2NocmllYiBMb2dhbiBCcmlzdG9sOg0KPiBFeHRlcm5hbCBp
bnRlcmZhY2VzIHNob3VsZCBiZSBkaXNhYmxlZCBhdCB0aGUgU29DIERUU0kgbGV2ZWwsIHNpbmNl
DQo+IHRoZSBub2RlIGlzIGluY29tcGxldGUuIFRoZSBub2RlIHNob3VsZCB0aGVuIGJlIGVuYWJs
ZWQgaW4gdGhlIGJvYXJkIERUUy4NCj4gRGlzYWJsZSBldGhlcm5ldCBzd2l0Y2ggYW5kIHBvcnRz
IGluIFNvQyBEVFNJIGFuZCBlbmFibGUgdGhlbSBpbiB0aGUgYm9hcmQNCj4gRFRTLg0KPg0KPiBS
ZWZsZWN0IHRoaXMgY2hhbmdlIGluIFNvTSBEVFNJcyBieSByZW1vdmluZyBldGhlcm5ldCBwb3J0
IGRpc2FibGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEJyaXN0b2wgPGxvZ2FuLmJyaXN0
b2xAdXRleGFzLmVkdT4NCj4gLS0tDQo+ICAgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0
LW1haW4uZHRzaSAgICAgICAgICAgICAgICAgfCAzICsrKw0KPiAgIGFyY2gvYXJtNjQvYm9vdC9k
dHMvdGkvazMtYW02NC1waHljb3JlLXNvbS5kdHNpICAgICAgICAgIHwgNCAtLS0tDQo+ICAgYXJj
aC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1ldm0uZHRzICAgICAgICAgICAgICAgICAgfCAz
ICsrKw0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItaHVtbWluZ2JvYXJkLXQu
ZHRzICAgICAgIHwgOCArKysrKysrKw0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02
NDItcGh5Ym9hcmQtZWxlY3RyYS1yZGsuZHRzIHwgOCArKysrKysrKw0KPiAgIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvdGkvazMtYW02NDItc2suZHRzICAgICAgICAgICAgICAgICAgIHwgMyArKysNCj4g
ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQyLXNyLXNvbS5kdHNpICAgICAgICAgICAg
ICB8IDQgLS0tLQ0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItdHFtYTY0eHhs
LW1iYXg0eHhsLmR0cyAgIHwgNiArKy0tLS0NCj4gICA4IGZpbGVzIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KY3V0DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL3RpL2szLWFtNjQyLWh1bW1pbmdib2FyZC10LmR0cyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvdGkvazMtYW02NDItaHVtbWluZ2JvYXJkLXQuZHRzDQo+IGluZGV4IDViNWU5ZWVlYzVh
Yy4uOTBmZmM0MjZjYWUxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2sz
LWFtNjQyLWh1bW1pbmdib2FyZC10LmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Rp
L2szLWFtNjQyLWh1bW1pbmdib2FyZC10LmR0cw0KPiBAQCAtODksNiArODksMTQgQEAgc2VyZGVz
X211eDogbXV4LWNvbnRyb2xsZXIgew0KPiAgIAl9Ow0KPiAgIH07DQo+ICAgDQo+ICsmY3BzdzNn
IHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmY3Bzd19wb3J0MSB7DQo+
ICsJc3RhdHVzID0ib2theSI7DQo+ICt9Ow0KPiArDQpTb2xpZFJ1biBBTTY0MiBTb00gaGFzIGV0
aGVybmV0IHBoeXMgb24gdGhlIFNvTSBpdHNlbGYsDQpjYXJyaWVyIG9ubHkgcHJvdmlkZXMgcGh5
c2ljYWwgY29ubmVjdG9yLg0KDQpUaGVyZWZvcmUgdGhlIHBvcnRzIHN0YXR1cyBzaG91bGQgYmUg
c2V0IGluIHNvbSBkdHNpLA0Kd2hlcmUgd2UgYWxzbyBzZXQgcGluY3RybCBhbmQgcGh5LWhhbmRs
ZS4NCg0KPiAgICZtYWluX2dwaW8wIHsNCj4gICAJbTItcmVzZXQtaG9nIHsNCj4gICAJCWdwaW8t
aG9nOw0KY3V0DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQy
LXNyLXNvbS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRz
aQ0KPiBpbmRleCBjMTlkMGI4YmJmMGYuLjk5NWUyNzAzMDMwYiAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRzaQ0KPiArKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQyLXNyLXNvbS5kdHNpDQo+IEBAIC0yMTIsMTAgKzIxMiw2
IEBAICZjcHN3X3BvcnQxIHsNCj4gICAJcGh5LWhhbmRsZSA9IDwmZXRoZXJuZXRfcGh5MD47DQo+
ICAgfTsNCj4gICANClBsZWFzZSBlbmFibGUgY3BzdzNnIGFuZCBjcHN3X3BvcnQxIHN0YXR1cyBo
ZXJlLg0KPiAtJmNwc3dfcG9ydDIgew0KPiAtCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IC19Ow0K
PiAtDQo+ICAgJmljc3NnMV9tZGlvIHsNCj4gICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
Cj4gICAJcGluY3RybC0wID0gPCZwcnUxX21kaW8wX2RlZmF1bHRfcGlucz47DQoNCg==

