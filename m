Return-Path: <linux-kernel+bounces-405232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC4B9C4EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F4828A2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88020ADE0;
	Tue, 12 Nov 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="XZXcaUmK"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93620A5F1;
	Tue, 12 Nov 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393721; cv=fail; b=qELzBfAa0BUFUiNJr1kUhMMTO2Fl2Fop5e6NnWxtAIoovQP40xCz8fuUZJFiCyuKzdvoKPPvVGL64wd/8Qib0R+0GiS4BwrFmrc6280rMA/meDarnnHS4be+dTtmHyMK5Ru91G954excH7HWq5L4soyGEnol0j8zEFwBN5mYoPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393721; c=relaxed/simple;
	bh=E7v0Idho53S8ukfVuHlP4Qbh3+TrXUaplODTa/7CyYc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oMrD1s2NThZon3uvZIUJW+3zCsM6zvZ4OtHwb3FQwnC1bm3xpQuzuLu1KTn+hz11iTT6CIVD890cr771ByzKTGoiBxLolzzysaug9NYA50lamIvBkVzGJ2vJVmxs86hSZ0RM1jC/J0xCqR1YEg8VOu0INTb9ir4Z0oa/uo6sVSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=XZXcaUmK; arc=fail smtp.client-ip=40.107.21.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeDKtHg33/2L5Xe4cSB/mcXz2NoWordWhM46Jv5UK/2cnDrTMgysPMrMU8fW/Vt66WmNg7kbvYwa47Ad2gdUQtE3mtLtjL4AIFXo8ldQCeByDhegTOH0aMJQ45OR0C3rTWO23zU4ElFVmRfFCBJ7o1D1t1Zcy8BRjDWzpBXXf3r8vc189wfXCdSn/OR9k1FqGM3ZzZA03bVSbK6lzhwSkWh7uyRsFZQws6Q3+ZfBi593QS6zMgHuyUxnzBzVVhNg6uaREhmmUW7OCRlRmrPG5+l/ndhIyYK7w6vbFEKTekk164lrgBiEOwv+1C/FGC7mLfhLF0daQmdt1k2YrDQWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBP1lqm4a8r+XPGPyakaL2LkPPDwdDkPI1a+IG7CK6w=;
 b=SekHJfsBPsz9cueSaShq+yqlCJOhRxaIB1PG+/r/4Q8wN/1s4+Eq0HrbnuqZFAy0dm4vvxHduJMO4SRfONc6PKnkmOq2IalQYhz3p6hOaTXjvz+01rBj+Udf2Rg3cW6sdyf1nE71JBwX/gvQyyym920wH/srHO4LMq5AIektXFOs+ZVj8EIueoDbqIbeYkbHGVAMG4iluiMLQpdS++wlpB79KViQfdcQ1Qd425Rd8um7ZOeE8v5UI7U0t9Aq+ZqUwZd03i3MXQ2/7N0bNWpbI2cnvGVVaZd6Ssx8aObaVdYIuNRGCvaIl+sremxVPyWekeizXNjwhzhuJ5DzeQ+6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBP1lqm4a8r+XPGPyakaL2LkPPDwdDkPI1a+IG7CK6w=;
 b=XZXcaUmKotSyIxgweOHbOmrfcTfJhEJk15LetMl3VJ/V0P9e1ZsTPOOaiY2RE7lB+NC9u3KOd4Wg1V8cvX8wGSDyor7+ae5nE6U5xVNs9zrTBS5+PTtAoo0+qcjbdomFwrRq4KsDcrvXMHC6sxy8li4eF4ZAkfCjgLYbzwyZT60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU4PR04MB10959.eurprd04.prod.outlook.com (2603:10a6:10:586::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 06:41:54 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 06:41:54 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 12 Nov 2024 08:41:32 +0200
Subject: [PATCH 1/2] of: add support for value "false" to
 of_property_read_bool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-am64-overlay-bool-v1-1-b9d1faff444e@solid-run.com>
References: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
In-Reply-To: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Josua Mayer <josua@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, rabeeh@solid-run.com
X-Mailer: b4 0.14.2
X-ClientProxiedBy: PA7P264CA0446.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::29) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU4PR04MB10959:EE_
X-MS-Office365-Filtering-Correlation-Id: 423749e5-5507-4074-405c-08dd02e51900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUZ3Q0J4cy9xUEpxaGZIUVpKc1A1RUdmZHJtcms5YkVEc3pSTjdjT0tjQmhS?=
 =?utf-8?B?eEZJYmMxZ2kzR2FBSWZ3VFZ0Q0RLVHFETGl1a2ZYWEhEYVdHaDQ3N2prNEI0?=
 =?utf-8?B?K0s4TkJFZW50ZHlhNnhtRTdMWWc4UERuUXIrdWtxeEViL3V4Umh1aG5zaGpH?=
 =?utf-8?B?NDZPYTBBTmVYdWg0cVpyK1EreWp5Y2t2WjhyOG5SS1JGVXFaTEFYRXJad0o0?=
 =?utf-8?B?Vlp1U3Q1OHN1Wk5BeDhxNGZWTGExOWJZN1JUVDF4M0tPdndPQStybUREQ0I1?=
 =?utf-8?B?NytRaVp2NVdLZTBvOGNGSUprSWJqSHhzbVQwYXRxMzlSMjBMcVZQTUFuVnN0?=
 =?utf-8?B?Y1M1SFhiVnRoM0JRblNYUSt4V3Z0WEErTStoZWEyMkJjclNOTEEya1FPTzEv?=
 =?utf-8?B?WndUYzdmOUlMTy9WR2RFUWo2Uncxd2o2R0NaN0ZIblFSYUhJM3RlMHF6Z2VU?=
 =?utf-8?B?K3cxRFRUVk9qWHJMTU9FRGRyY25Zd3h5ZXUxSk41RzhGSFh4dFVwam8zUWN6?=
 =?utf-8?B?V1JQQk9xR001OHAwZkp5Z2FrdkNGbGMwU1lSSGFSUHpsNEcyZUpxYW13QnYx?=
 =?utf-8?B?enF5Z3puV1E4dHBzNml0M3lhV1RiWnhsdGd4U1lmZlQwQWdSMHhVK0hPRGVO?=
 =?utf-8?B?a0IwQUtWdDdVeHlJRFFoZ2p1cE1rMUM4T0djNExWM0YxcXNUUllOeGVDUzla?=
 =?utf-8?B?Wk1uZlhFV2kyZFMvQW03TnBWRkwvRWJuYTlIUHlicFdhNEtySDRERWNSY3pN?=
 =?utf-8?B?NER3YkNEcjZmcTNyZi8zTWpPWjNBcVVYT2NHMllRMTB0R2RQbnBEaWxkYitx?=
 =?utf-8?B?cUZpdldPbFdPdXo5QlM4Z2krOHlFdTdoUy8xb25nS00vTGtScHorVDJaZCtp?=
 =?utf-8?B?N1hNZDcycU9RU2lCZ280VUdFUDRNOElLZjJ1Q3cwbUtvcUtXTkRVeXFyM1lO?=
 =?utf-8?B?T05uOWREcU03TVhlTHpoUjR6clFXdjl3dzdRbUg1ZGd2TmF3dDN3S01tRHVN?=
 =?utf-8?B?YTJ6eVpYN3JVYXBLcE5tdm9vWFJQNVhEZ1hiKy9QSi8xdHJONk95YWtoZzF1?=
 =?utf-8?B?QlVxNjVuSWl5NVREdEwrVDdsSHdHbDFBcGw4TStUdSszRHFQNlNXMU12N082?=
 =?utf-8?B?THNBWVlQUVdoUFNVS1RTNVR0c3hEVE5ucGxHYWI0djBTOFFiQWNJV0s1WnQv?=
 =?utf-8?B?NXh4WWJySTRhQmtXWXorVmZMeWRmb2tDaUIrT044dGxJR1gzSGRDYXY0YW4v?=
 =?utf-8?B?YUVaSnVNVFhQSXVibFpGRHB3azdFTVJpelJDc3ZVNlp1dC9hNjd4TmNreHVG?=
 =?utf-8?B?ZWJlNnJyTTFpeFZ5Z3poQkdPZnNwZ093OURheGo4TlhzQzgwZGtPc0ZLK215?=
 =?utf-8?B?d1psOUVNVUlpM3dXd2NCaTNhckd1YXJzWnJIbk1aSi9HRUgyUGN0YVZYNFY2?=
 =?utf-8?B?MGFKQnh2S2hHY0NwRmY1bjhTcWFmMmpwelBNYkkvaCt1eTlldm9PRWNLL3pR?=
 =?utf-8?B?dk1VSXl1NW1zK1AvV3JTVHJJb0tValFRaUVTRXRQYXpjU3FDOGFqcytON3I2?=
 =?utf-8?B?a3J5UUxBZi8yZzJmMDlaVUtWbzVvR0JuMWUzMjVFNzNXNnM0NFdCd0hvakxK?=
 =?utf-8?B?ZUVtdE9md1pWMFVzOWMzWkZHSVRUejVoT0FPeDZ3Ylc0Z1dDMklMdW5rUEZ2?=
 =?utf-8?B?Y3JmZlZCZTh1cnN6TldPakhFZWR2VzBJcitwRmdwRTZ3MnRYMXNwZ1QxM2lG?=
 =?utf-8?B?TG51R1lzVGF5cnpZNEpOcEF5UnlUcElIbzc5VGV1eXg5RUZ6cFNONzBvZ0sz?=
 =?utf-8?Q?xuB1tOJtc1s1YHdN+ygvNs3CABfqeYFHFWbOA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azYycFRFcVZRNXFrY3ZGT0pXbWQyYXl2N1hDcXNHa1NZZzZkdVhXcFRkQjht?=
 =?utf-8?B?Q2FrNSt2dzRDZHBBS3cyWG50Smo2RzVtYUtnWS9vZ0VvVlRXb3N5d1A3djBl?=
 =?utf-8?B?eWlHRkY0WlBXQXd1TEZMWldkNEZaTGVaUkN3ZXpTaDBoVW5HRFY3N3NxUzlw?=
 =?utf-8?B?WlI5VEpBMU5raVFQL2ZGU0gzR3JmM3Fzc0VjM0NPZmhOdGJsRlJoelpndjM3?=
 =?utf-8?B?SHI2aUxhNkRyYnJvUklNSkpRTFdDd0daaUxIQ1JsVmRucklPZk1jQkp5d2wz?=
 =?utf-8?B?RFhBb0syZWRLQjZsUDE1cm5LUTVjeGhBQ2VzdTNoWXlvYUh0bkVEeWs4eTI3?=
 =?utf-8?B?V2RMT1RJQnJDcTZ0R3A4VjJOc1JXdVN1OWJDQjkzdXg3VHc1U0Y4bTg5OUlR?=
 =?utf-8?B?QVpqWUJCbUcyK1pLbHJwUXVHSit4NVVOWlgyRCtVOFhaRHMvYVZKUmZQVWd2?=
 =?utf-8?B?MFBTTlpKNHphVVVXWDVqM2YzK1hDaTREVEpnZnZ4VkdySUJzZ3JoREtVakJz?=
 =?utf-8?B?OG9tZDN3R2pSL1M3N1ZDL0lseFJ0NVdIdjVrSlNsaHFBcWlNeFRFY2VHWTNK?=
 =?utf-8?B?dHoyemtWdEJ3NFNtbC9XYXF4OW1GZGxaN2NhVUFiMlNwK1BWMFRscnBxZERP?=
 =?utf-8?B?SmIyaEJidGlLdEwxc2drTDVoeHVkYzVDaDhHVm9oRmNHY01EZEp6QTFyUC9n?=
 =?utf-8?B?VTlrT29EaUxUYzBoTWdtVFV0MG5MaTZ3UnJxZUxicmg5RFNRQys0bk5ReXVy?=
 =?utf-8?B?OHdkYzAvRDVaTFlTSXIxcXJnb3ltc1dPWXBVMjVPeVpEbXpVNFhQQ3AwSkls?=
 =?utf-8?B?U1MweG9sUm1PbnUzUnJ2RGg2bmt0MXNseWJXYmo1aUl2aEQ4am4yYm1tdE1m?=
 =?utf-8?B?TzROVWdEQVZ2MEtjd1o3TG8yYkxma1U4NXBkTjFzVnZOSU5uQ1Y1RDN3ekcr?=
 =?utf-8?B?bm5GK2ZuRy9yR1JvYXpLeDF1UEd5VmMzVDFlQmhnd0YxMUpRT2NQTHhZUFJi?=
 =?utf-8?B?QjIyNnp0aVFLVVhmRGhsS0t1aDd2UUxWV2l5QmtTd2tvdGEyTVpwUjRYS1cr?=
 =?utf-8?B?a0tOeVA3azVHM1I1a3hjRU1PT3ZIZkVMdzBFZ3hwOXllbDlJNEpyVE9zSWFI?=
 =?utf-8?B?Z2VMNlR5RGVTYWdlelQ3R203N2FnMUZyeGhNOCtnWkJzeXBOaFJnM1lKUkhU?=
 =?utf-8?B?SXBmVWFxcWdab2FmVnN0WStRZGtrZEV4WVpnWHhJVXBTRjJlNUsydjFiRkVv?=
 =?utf-8?B?TVRsOC9QVFBWU3k4aHF0NTNNN0J5RkF0ZlZaRG1rUkFMaFNDaCt6VE1XdGxs?=
 =?utf-8?B?c0ZFQWZ0L3F4QnpqVkE1WFlpS0g4L3pZUXhYVmc5bVpqK1lmeVhRL1VNT2tz?=
 =?utf-8?B?a0RZVEt6Z2tmRENHU1ROT0xINlBJbDNYUkltR0w2d0l1UkZrR0N1NmY2TTB6?=
 =?utf-8?B?alpTMHBMZCtXT1dQTTBHSnlEL3ZqUmdpR2d2M0F2bmdIRG9Qa0YzOW9xYlNT?=
 =?utf-8?B?NFZGSDk4Vnlnam5EdE81SEtxWFgydkhHeE9XdXhkTGZsb056U0VyOWg2OG9L?=
 =?utf-8?B?dEI5L2pBcWxYSkRRT2R5NUFiMmdieHh6eXJldy9lamZmUEc0VWtnN0JlYmY4?=
 =?utf-8?B?Uk94MVJTZDkySzAvOUJ4RnZtN21yV1FWWTd3NzJnMVdib3phUC9uOFI2Z3gr?=
 =?utf-8?B?eWkwOERMTndwUUIyUkFodzh1MTJNMnEySjlpMFEzdGZPYTFEL3VLZFVBb1BN?=
 =?utf-8?B?MldYckJSRmFNdUgybWhxcTl2QnJBTDJ2T3M0QUJDaUJSUDhLUUhteThob3Av?=
 =?utf-8?B?a1dlSktEUDlkWlZZVnA5ZEJ2TE51dUVxbjRIcm1rTE5raXNaYVV1YkZ2cTJh?=
 =?utf-8?B?KzJ5QVc3SGswekNVUFN2aFdEMGh0R1FhOWZrajdCTFJocWlNQkhrNW10UUph?=
 =?utf-8?B?Ym9zaDdrc3B3cC9JVXl4UFM2SmFHU0krbkMrd1lieVVNdmFZZjFXWmlIdWtm?=
 =?utf-8?B?R0FhMjhBV3NZSFJLc01xWTdLb2Z1VDBMT2w1QWhmdTlNWCtaQkpDbWQwTFhs?=
 =?utf-8?B?c0V1N1FxYXJIeEFNRlJnL2pMOFpJaHc3L3FFUUQvRmx4MkhMclU0cTZ2dHN0?=
 =?utf-8?Q?CDUSp0Xtt/exW/15hOmkxwBZu?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423749e5-5507-4074-405c-08dd02e51900
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 06:41:54.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYGuxNo9pV0+45AfaluW49HnFKjGY5Ze1SKxkSWJhP9HDZbjtABuyrQtDqf/n3VQsVEl42/6ciFn8bSktFrqKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10959

Boolean type properties are usually considered true if present and false
when they do not exist. This works well for many in-tree board dts and
existing drivers.

When users need to overrride boolean values from included dts includes,
/delete-property/ is recommend. This however does not work in overlays
(addons).

Several places use string "true" ([1], [2], [3]) and one uses string
"false" ([1]). This suggests that at some point the value of a type
string property was to be taken into account during evaluation.

Change of_property_read_bool to only return true if a property is both
present, and not equal "false".

Existing usage in drivers/of and include/linux/of.h are updated
accordingly.
Other places should be reviewed as needed wrt. changed semantics.

[1] Documentation/devicetree/bindings/sound/rt5651.txt
[2] Documentation/devicetree/bindings/sound/pcm3060.txt
[3] arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/of/property.c |  2 +-
 include/linux/of.h    | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 11b922fde7af167cc69f6dd89826219653cd1ee8..a51132b883fb3fa0b1a120bacb298abf72f67c5b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -893,7 +893,7 @@ of_fwnode_device_get_dma_attr(const struct fwnode_handle *fwnode)
 static bool of_fwnode_property_present(const struct fwnode_handle *fwnode,
 				       const char *propname)
 {
-	return of_property_read_bool(to_of_node(fwnode), propname);
+	return of_property_present(to_of_node(fwnode), propname);
 }
 
 static int of_fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
diff --git a/include/linux/of.h b/include/linux/of.h
index 85b60ac9eec50bb202aa774cab273e1d947e394d..ea65c7d1176194d6ce79432782361f2cdab84f8b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1247,14 +1247,15 @@ static inline int of_property_read_string_index(const struct device_node *np,
  * Search for a boolean property in a device node. Usage on non-boolean
  * property types is deprecated.
  *
- * Return: true if the property exists false otherwise.
+ * Return: true if the property exists and value is not "false",
+ * false otherwise.
  */
 static inline bool of_property_read_bool(const struct device_node *np,
 					 const char *propname)
 {
-	struct property *prop = of_find_property(np, propname, NULL);
+	int ret = of_property_match_string(np, propname, "false");
 
-	return prop ? true : false;
+	return ret == -ENODATA ? true : false;
 }
 
 /**
@@ -1268,7 +1269,9 @@ static inline bool of_property_read_bool(const struct device_node *np,
  */
 static inline bool of_property_present(const struct device_node *np, const char *propname)
 {
-	return of_property_read_bool(np, propname);
+	struct property *prop = of_find_property(np, propname, NULL);
+
+	return prop ? true : false;
 }
 
 /**
@@ -1679,7 +1682,7 @@ static inline int of_reconfig_get_state_change(unsigned long action,
  * of_device_is_system_power_controller - Tells if system-power-controller is found for device_node
  * @np: Pointer to the given device_node
  *
- * Return: true if present false otherwise
+ * Return: true if enabled, false otherwise
  */
 static inline bool of_device_is_system_power_controller(const struct device_node *np)
 {

-- 
2.43.0


