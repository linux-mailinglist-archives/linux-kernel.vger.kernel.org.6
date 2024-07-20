Return-Path: <linux-kernel+bounces-257976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579159381A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B7928228F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2412F386;
	Sat, 20 Jul 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="j0jOJf5Z"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023077.outbound.protection.outlook.com [52.101.67.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7605143C4E;
	Sat, 20 Jul 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485180; cv=fail; b=kNqg1ptOU59QaZkUGxwGY9yMeVcnfWvF7QPpJdFjiqqkHB3YwIz5LtZB4C/v5IKborS7ZoXuspQ5rmOx8uJQVogG6daNwlk2LbLavC6tAgTTls7BPellbH/KtlR5JwVStqI5iZqxPGqAkC9NPSr9HXXp8yT/Ff8zXltHoPwET5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485180; c=relaxed/simple;
	bh=W0iTYrXYW+p8XlYPb0cdFWWEElxzVQ940ojtVg8+Duw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TawozJetUZFzWUzva42mlL1Y/3mrotgEqVNgDGbxcb2Tp/HhhlVzZPr/2vEv4INnkFLZEqwzscNE0HQsr5+ucbHUJjuVSVcIBuumxEw34ielfgZ1ArDGvmLp6cHW/T/ZlY4UoCuN93olnbtAOk6GPvjv0o+ibBVGNbUdK+E6FaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=j0jOJf5Z; arc=fail smtp.client-ip=52.101.67.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cf9dOXktbWtAPctpGq7KfvO8Yy/knJUztkXYvnybb9TvONDQHk64tOIW+SEXwiBo+165Ovrj0t803z7sceTRAWneuW/BFGvPuGFz9pAGFRpMksQac2XX8k3c4/8ng4X4aSsvq8rW8oIHxw0VGH8SRNr/7F4Uw8I/QjquwAh7RS1ZbmNXFAgFX8dp6dTZ+xST3b2Ew+azH0zDsLTu28Zv8lee/mGnf8uBFR1xg1cQhE2zyf8rTMsW2a6pGwlw3c+L+YgUUQyNtyADPzB3uTX7itoyvmw3xor5rion2WnvP+XQNiIUWd+/1+dCwtFpz5YIE0E0SWlUxB0UR/RUat2CPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2zO0ijjJMnyS94BfobQfRw03W82OCbwq/nhnks92/c=;
 b=F0KygOBes+1LfeBzHI19gPDnXw+unCclWpHnhCTES3S2W8rx3q5zj1Xn6NbZ/vwsItjXcIxLdYCF5A0sxuSbu+9ycHRSP9ZHQj6eHEtwVdl/3qazb1HJnnXTeJ5YDHZKgDwk/IXUEckak5DAd3CpQyIL4fKMgCh+e1uw6mEBgzOtolR8HfqN3Pj7oK+fa3sBzrtgHjbRV/GMshjaYLQiZ9oA2FtZ4axGDds7+aNJuYYiePm4qkW80YyovivOzLnIgdvxKIXXqrTWppOFsiBLmnMQ6RG1/14vOBGW8cUwVIQ2vda5EsGcOAEEq6hPiuKOYP+NoOI6XeAxv6kBTPUCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2zO0ijjJMnyS94BfobQfRw03W82OCbwq/nhnks92/c=;
 b=j0jOJf5ZNoMhJ/JWpBmWRzb2FlH1OLHv60iSKVSCSkTWMRclPntfD6GSIofUj3BfjI+P0UhZh9NkFTMloByd2Iy58rKkUxaJCxQ5tWa570tXk/HJWAwLJUcQw8uKo+4RQlgmuEsCoknhOyfbKzhH+zWZ5t1HE7SgPHE6xdASOGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10299.eurprd04.prod.outlook.com (2603:10a6:800:238::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 14:19:29 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Sat, 20 Jul 2024
 14:19:29 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 20 Jul 2024 16:19:22 +0200
Subject: [PATCH RFC v3 5/6] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-a38x-utmi-phy-v3-5-4c16f9abdbdc@solid-run.com>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
In-Reply-To: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Konstantin Porotchkin <kostap@marvell.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI0PR04MB10299:EE_
X-MS-Office365-Filtering-Correlation-Id: 7805e983-d325-455b-8d09-08dca8c6f7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mmkxa1NnTC9DOUdKSlI2MXhaZGxxUjJCR004cmpWYTZrZnQzQ0toL0lxWWE2?=
 =?utf-8?B?aXh2d1E0RzJNdnpVeTBvcTZpTDV5QmtyaS9EWmhNcFlpMVBYRjhacVJkZFhN?=
 =?utf-8?B?SDlzdFN2bUl0NDh1VmtTVE92Qi9mQ1dpVW12d2wyaTdXMERqS1o2b3pQQnF0?=
 =?utf-8?B?bFBmK2tWVEJmV1NZV2cxMjVsZE1hMDRlcENMWUxaZHpyZkF3L1NnQW1FTU5I?=
 =?utf-8?B?V3NObU1DZHRsQ0JuM0xmdmFNbklrSEVzejhBVHRRNVpnRURGZWtaS3RPSGhC?=
 =?utf-8?B?WHZwU0dHRG5wRXJ1WTgrVFp1d2pCRHJxaUFFaXZ6c0JSVS9CeXkycnk5aFhC?=
 =?utf-8?B?SWFyekpxenZlenBWRGVnczRrN3YrYjBlaU9RazA5UG5GYTBNWEpHaFArMGt0?=
 =?utf-8?B?RUorL0RIQ3cxZkwvQ0gyQmhKOWNKQmNpbjlrTjBjejBaZENPVW5JdVVBdVM1?=
 =?utf-8?B?eGFLaTBJNzJtUVByaUE0elltU2VoNDRkaS9nSnUydHg1Q1d6Y3BkM21GalEr?=
 =?utf-8?B?bzFtUVRqNytTd05Pd1NKV05WckNGN3BtaHkrMlA1Y2pIQXFydHBxcVViaFZE?=
 =?utf-8?B?RjF3aUQ4UjhsQWI2U3YyaWRZR2pwM1BVaE9DRFBNYXB1bnRRRE9yamhJS1ha?=
 =?utf-8?B?NGNoSU1ieVF2SldMMDR3VU9lM2ZhbWlYNzA4eU5uSTNaK2Q1WnFWWEtYRXZ2?=
 =?utf-8?B?VGZkL0RtUnZ6Rm1XcTdaeGYxNGhyMXFjNVY0Q1J4RnR0RE1wQzdpS3ZLTWN2?=
 =?utf-8?B?Umt3Y3ZPaWVhcWp1YVZMbzJOUGxUZkxTTmJYeTVTTWI0UFdCQ0t1eS9PUmM3?=
 =?utf-8?B?dVJ0RmFPazA5aGNLSldHOFdENUR4SHB0RnpDMWNGWHZacE5wNkZRN2R6WjFK?=
 =?utf-8?B?WnhkbHpkRzZDdlFVKzZ2STI2cHRZTHdFY3dpT29rVWl4dXlGemtSMXJUbTdE?=
 =?utf-8?B?UTRGbGtvQWtpeTdsUmo0c1dvOGErSWNhVjFkclFYZUx6QmtOaUhsZ29WNGEx?=
 =?utf-8?B?V2JFKytSZjZrVGRDbTlQRHFnZHJmZEtPQ2JJbDc3VzNLY2E0aG5yUnNqYlNK?=
 =?utf-8?B?a2RocFdBaE56TjlDcjVDUUZFbExSd0VHMDFKb09NVmZxQktKUmN2SG5keUNX?=
 =?utf-8?B?aUV0M21BTDRoT050Ukc0UlpDN21DNHZGVmhlZCtQT21JOEhBcnJvd1dmMFlD?=
 =?utf-8?B?c2ZjQlhWQ0tvOGhYYWR3QWJsOTdQSFR6ZVFIMkdhNVRYOFJOb2FyekRnMEJ1?=
 =?utf-8?B?Zlc3MWdJVkQ3WHcyS1dUalZJejlvNUV2S3ZFZ09yZXJkS1ZubWszT0Npd09W?=
 =?utf-8?B?SWlsSlpmZ2xhdmEycndqWEhwTmpSWThqOE4vdjdLQ2RjZWdudktvOFlEMkJ4?=
 =?utf-8?B?aVNHdjUxbzFBMWRCanpGSDRqWTRIRVlHdjBEWkVRTFhjY0p1T0QvNW5kYnZv?=
 =?utf-8?B?dFZXU3R0MFhROXZPaGlLVTM3WXp1ZnNBS1NkK1h4T2xML3dmUFhtaC9ldGdx?=
 =?utf-8?B?ODBscS93SzNEU3lWYjZZbmhMOFBsbDErYkdzdGlSejZ3aGhlTXR0NkN2bkdx?=
 =?utf-8?B?NStpWmdPWGhudVI2OUlncDd3dVpvYUVrKytzV1pKZ0Z0MDhMRVcyTW9lQWs0?=
 =?utf-8?B?RHJXcVgzWEpTM3BUY0JHeFBidXN2d0YvYmxHR09EM2pUZ0ZUMUxHOXNpd0Zx?=
 =?utf-8?B?L0U1MGdtMEthNnRPQy9uUCtDUU1HZFJldDlIMVpOMC80bDM5aWVtRjMwek5M?=
 =?utf-8?B?QjZ4TlBkU2g3TlFmMUdmR3ZSRDdubUlKaEZDV29LQllOR3MwVktiSnVlbFVr?=
 =?utf-8?B?b2lVS2pEM2VkVy9uVHFodTBTbWNYbHo0NCt0Q3RleGxRMU96VXhleVA3UGxW?=
 =?utf-8?B?dFpZV05aZjNlNWRFUUhDTDhSa3doeC9PcitvOTA0L1B2ek9DY0ZvZHhLa1Js?=
 =?utf-8?Q?o44WfjzJbBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXo4czVVTjd5STN0anJ2SHlvQS9rMjN1V2k3MUdlNjJ3TkliSjlLSFVyMURM?=
 =?utf-8?B?aUJQTW1Ea0lYUzhTUkZzeHMxSXY3ODRQUEY0anUvNSs5Vk5HSTVMeUJjL0dX?=
 =?utf-8?B?ODZtc2hrMkNtNU05MXZYTUpGUmo5RWk2M1lmUW11bzRMR3lqYlBmQmpYU3F0?=
 =?utf-8?B?Q3drbXhYODNtenQrcFdyY1paK09QMy9xTkwvdDBKbjVlb29tS3BHSCtSSCtn?=
 =?utf-8?B?MG0vTU94VXRRV09LbGxhS3VYenRoOWJnbU1lT1RJWjZET3RUUXRXN2orVVRx?=
 =?utf-8?B?R2c4Q0J0RXRRWUFEZlhMSk40d2YvQlJYWEp6T09Jc3ZDRU1PUC9WWngrSHE1?=
 =?utf-8?B?aURrR2VWbWZvZER3bHpIUjRIU1MzL2VVMVoraXU5VWJVekVBR1hTNzY4MG9H?=
 =?utf-8?B?dEEvN3RSMVBtV3J6WEY2NjBhbFJ0cEZTM3VVVG0vRkpYZkNFbm5QbU5Qc0pU?=
 =?utf-8?B?bXkxNlVPa0pRUFJ4N05aeXJDVjRGblVQSmZPL0JzV095QnhDODg4b2NEdG9l?=
 =?utf-8?B?YW1qdXAwdUdobmRqWlltU0hqNE9lRXFaUEduSHRtQlVQOGVKd0VMK1pITnRW?=
 =?utf-8?B?ejlFQmd2dXlBd0ZhMkxwZWM2RVYwVTd4amQ1OUE1aVpVWnZ2a2VIVDNSTisx?=
 =?utf-8?B?S3JFeTlPdUFEdHpWZkRQNnhQWm5ubXBuL2N2UFZqYUJXNmxWRFcvUlNMVlpi?=
 =?utf-8?B?OUQ2SlFNeVc1SlBhTGdmRWR6TDh2bDdpZkN0L1BWbEE4NExTQjhJYW43bFlh?=
 =?utf-8?B?aU9Md2dsSHNUWTQ5RWlid3I3L1lnRGpoVGhJUmZyNGFQMWRINUdVOFg3dWll?=
 =?utf-8?B?Y2FMRzM4bGxTSnBFTXAzaHM1dUJsZ3M3NTBMUE1weVlJQSsrN294cEZ5eUly?=
 =?utf-8?B?WDBnSkM3NUlYTStQK1J2SlhieGhOOTU4TVVDNkVjc0pST2tIY3FhQUxSRDVa?=
 =?utf-8?B?cDdzMmdiaXhnTkdFaXF6RExPVVFoNEcvUnNEaEtuc1VFT1ZYR3FCYkMxdHMz?=
 =?utf-8?B?cWZhSERLSU1HWTFTL1lIVHhXc1VwNWJ3RUVIOGl3T0V0ZkV2QXV6QjRiQmFK?=
 =?utf-8?B?REFyajlFQTc1K05XRXR2Z0NaUGI1U0NMR3J2bjdPQUFDQ21hTU4wcmpQSXB0?=
 =?utf-8?B?ckwzRURNKzVrMEc0OGg0emVaNllCeXVlL0VYbjg2ZjNrblhqV1ZZaGNCcnNu?=
 =?utf-8?B?eEVnUHpiYUZSYkFpNDlQZ0Q5UzJNQ05CVVVpNkluOW9SbnladEN2Z01aRnhH?=
 =?utf-8?B?dmVFRllzc0o3eCs3ci9mR0t5T0pOTWVVdTZnSk96cys0a3ZsWmg3Z3p3SmU3?=
 =?utf-8?B?aDZPbkovYzZhSk4zb3NON2RIT2hqd2Uyd3l0UHRpc1dYNngvekxqd0VSL1lR?=
 =?utf-8?B?NjdnOXExcGsrOTBkY3dCUndJTXNtRWpiQytMYVhVaEIrUy8rVFFTOFQ1WXpY?=
 =?utf-8?B?bElROFV5SUNnTU9EU2pLOUVPYkZmOThoaDNRTkRhT0JWUFpyME9rV3djb3JR?=
 =?utf-8?B?cDhqUFZkc3lubTdFcDVDdnpyWVF1V0ZWL1lBV1NBMHZ4V3JnTEd6TmZDRmk1?=
 =?utf-8?B?Y05jemJZS3d1SnVSKy9xU0NJUEJGekdIS1pManUyNGpXcDlrcVZZZkR0bFJO?=
 =?utf-8?B?S1ZVSjk5NmtwOHBFYWlkS0xFSUg2WjJGNGlsT0Y3d3pTQjljSDByVTZ1Q0tD?=
 =?utf-8?B?anQwQ0xCTDFvZUFoNDVXTXZicE9hekRXSVBZdnBKOXF1b0xod0ZoUzMvKzhQ?=
 =?utf-8?B?dnRpWGQ0RHl1SGg1VDN2ZkZSNHkzUmFpclZJaUpPSTFLM01pWmdoeHZVb1Np?=
 =?utf-8?B?S0YxalJxMGE0ODBydm5tM2FybENuajZiNElqcnk4QUZaRmFzb3MxOGVLM1FO?=
 =?utf-8?B?QXQyWnFTdTkraWVRTWNMT0I3bi9xUFlqRiszOEtNdHhuM0wxQTFnMXA2aTNU?=
 =?utf-8?B?ZVp4SUpnT0RJVHFBdzFuNmxOVXN4WEhRUU1URTY2KzV1eVZCbUJqc2NsU0RM?=
 =?utf-8?B?SHN5ZjdOS2VRS3c2c1RwenZQSFdzREk5RTM1OVd0TWdOUVFmVDQ5NWZEVWVY?=
 =?utf-8?B?cUUvVi8ydVF3Q0NKSEVtaDZ1eWFOMUJNdUVqWllYWXZRdGtKN21Hclo2dmNW?=
 =?utf-8?Q?1xONiKfch7jpycwG9eU8DQJnX?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7805e983-d325-455b-8d09-08dca8c6f7ef
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 14:19:29.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnnP186jIje1z2Tg0uF4e1iIR0cswD8C0yXUADAEBYgpr3MVvz5ABocDJxZaZwt6dKo7jTSP8c0BuPiLv7G5AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10299

Armada 380 has similar USB-2.0 PHYs as CP-110. The differences are:
- register base addresses
- gap between port registers
- number of ports: 388 has three, cp110 two
- device-mode mux bit refers to different ports
- syscon register's base address (offsets identical)
- armada-8k uses syscon for various drivers, a38x not

Differentiation uses of_match_data with distinct compatible strings.

Add support for Armada 380 PHYs by partially restructuting the driver:
- Port register pointers are moved to the per-port private data.
- Add armada-38x-specific compatible string and store enum value in
  of_match_data for differentiation.
- Add support for optional regs usb-cfg and utmi-cfg, to be used instead
  of syscon.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 209 +++++++++++++++++++++++------
 1 file changed, 166 insertions(+), 43 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
index 4922a5f3327d..4341923e85bc 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -19,7 +19,7 @@
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 
-#define UTMI_PHY_PORTS				2
+#define UTMI_PHY_PORTS				3
 
 /* CP110 UTMI register macro definetions */
 #define SYSCON_USB_CFG_REG			0x420
@@ -76,32 +76,44 @@
 #define PLL_LOCK_DELAY_US			10000
 #define PLL_LOCK_TIMEOUT_US			1000000
 
-#define PORT_REGS(p)				((p)->priv->regs + (p)->id * 0x1000)
+enum mvebu_cp110_utmi_type {
+	/* 0 is reserved to avoid clashing with NULL */
+	A380_UTMI = 1,
+	CP110_UTMI = 2,
+};
+
+struct mvebu_cp110_utmi_port;
 
 /**
  * struct mvebu_cp110_utmi - PHY driver data
  *
- * @regs: PHY registers
+ * @regs_usb: USB configuration register
  * @syscon: Regmap with system controller registers
  * @dev: device driver handle
  * @ops: phy ops
+ * @ports: phy object for each port
  */
 struct mvebu_cp110_utmi {
-	void __iomem *regs;
+	void __iomem *regs_usb;
 	struct regmap *syscon;
 	struct device *dev;
 	const struct phy_ops *ops;
+	struct mvebu_cp110_utmi_port *ports[UTMI_PHY_PORTS];
 };
 
 /**
  * struct mvebu_cp110_utmi_port - PHY port data
  *
+ * @regs: PHY registers
+ * @regs_cfg: PHY config register
  * @priv: PHY driver data
  * @id: PHY port ID
  * @dr_mode: PHY connection: USB_DR_MODE_HOST or USB_DR_MODE_PERIPHERAL
  */
 struct mvebu_cp110_utmi_port {
 	struct mvebu_cp110_utmi *priv;
+	void __iomem *regs;
+	void __iomem *regs_cfg;
 	u32 id;
 	enum usb_dr_mode dr_mode;
 };
@@ -118,47 +130,47 @@ static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
 	 * The crystal used for all platform boards is now 25MHz.
 	 * See the functional specification for details.
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_PLL_CTRL_REG);
+	reg = readl(port->regs + UTMI_PLL_CTRL_REG);
 	reg &= ~(PLL_REFDIV_MASK | PLL_FBDIV_MASK | PLL_SEL_LPFR_MASK);
 	reg |= (PLL_REFDIV_VAL << PLL_REFDIV_OFFSET) |
 	       (PLL_FBDIV_VAL << PLL_FBDIV_OFFSET);
-	writel(reg, PORT_REGS(port) + UTMI_PLL_CTRL_REG);
+	writel(reg, port->regs + UTMI_PLL_CTRL_REG);
 
 	/* Impedance Calibration Threshold Setting */
-	reg = readl(PORT_REGS(port) + UTMI_CAL_CTRL_REG);
+	reg = readl(port->regs + UTMI_CAL_CTRL_REG);
 	reg &= ~IMPCAL_VTH_MASK;
 	reg |= IMPCAL_VTH_VAL << IMPCAL_VTH_OFFSET;
-	writel(reg, PORT_REGS(port) + UTMI_CAL_CTRL_REG);
+	writel(reg, port->regs + UTMI_CAL_CTRL_REG);
 
 	/* Set LS TX driver strength coarse control */
-	reg = readl(PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
+	reg = readl(port->regs + UTMI_TX_CH_CTRL_REG);
 	reg &= ~TX_AMP_MASK;
 	reg |= TX_AMP_VAL << TX_AMP_OFFSET;
-	writel(reg, PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
+	writel(reg, port->regs + UTMI_TX_CH_CTRL_REG);
 
 	/* Disable SQ and enable analog squelch detect */
-	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
+	reg = readl(port->regs + UTMI_RX_CH_CTRL0_REG);
 	reg &= ~SQ_DET_EN;
 	reg |= SQ_ANA_DTC_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
+	writel(reg, port->regs + UTMI_RX_CH_CTRL0_REG);
 
 	/*
 	 * Set External squelch calibration number and
 	 * enable the External squelch calibration
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
+	reg = readl(port->regs + UTMI_RX_CH_CTRL1_REG);
 	reg &= ~SQ_AMP_CAL_MASK;
 	reg |= (SQ_AMP_CAL_VAL << SQ_AMP_CAL_OFFSET) | SQ_AMP_CAL_EN;
-	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
+	writel(reg, port->regs + UTMI_RX_CH_CTRL1_REG);
 
 	/*
 	 * Set Control VDAT Reference Voltage - 0.325V and
 	 * Control VSRC Reference Voltage - 0.6V
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+	reg = readl(port->regs + UTMI_CHGDTC_CTRL_REG);
 	reg &= ~(VDAT_MASK | VSRC_MASK);
 	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
-	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+	writel(reg, port->regs + UTMI_CHGDTC_CTRL_REG);
 }
 
 static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
@@ -166,22 +178,38 @@ static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
 	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
 	struct mvebu_cp110_utmi *utmi = port->priv;
 	int i;
+	int reg;
 
 	/* Power down UTMI PHY port */
-	regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
-			  UTMI_PHY_CFG_PU_MASK);
+	if (!IS_ERR(port->regs_cfg)) {
+		reg = readl(port->regs_cfg);
+		reg &= ~(UTMI_PHY_CFG_PU_MASK);
+		writel(reg, port->regs_cfg);
+	} else
+		regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
+				  UTMI_PHY_CFG_PU_MASK);
 
 	for (i = 0; i < UTMI_PHY_PORTS; i++) {
-		int test = regmap_test_bits(utmi->syscon,
-					    SYSCON_UTMI_CFG_REG(i),
-					    UTMI_PHY_CFG_PU_MASK);
+		if (!utmi->ports[i])
+			continue;
+
+		if (!IS_ERR(utmi->ports[i]->regs_cfg))
+			reg = readl(utmi->ports[i]->regs_cfg);
+		else
+			regmap_read(utmi->syscon, SYSCON_UTMI_CFG_REG(i), &reg);
+		int test = reg & UTMI_PHY_CFG_PU_MASK;
 		/* skip PLL shutdown if there are active UTMI PHY ports */
 		if (test != 0)
 			return 0;
 	}
 
 	/* PLL Power down if all UTMI PHYs are down */
-	regmap_clear_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
+	if (!IS_ERR(utmi->regs_usb)) {
+		reg = readl(utmi->regs_usb);
+		reg &= ~(USB_CFG_PLL_MASK);
+		writel(reg, utmi->regs_usb);
+	} else
+		regmap_clear_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
 
 	return 0;
 }
@@ -191,8 +219,15 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
 	struct mvebu_cp110_utmi *utmi = port->priv;
 	struct device *dev = &phy->dev;
+	const void *match;
+	enum mvebu_cp110_utmi_type type;
 	int ret;
 	u32 reg;
+	u32 sel;
+
+	match = device_get_match_data(utmi->dev);
+	if (match)
+		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
 
 	/* It is necessary to power off UTMI before configuration */
 	ret = mvebu_cp110_utmi_phy_power_off(phy);
@@ -208,16 +243,45 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	 * to UTMI0 or to UTMI1 PHY port, but not to both.
 	 */
 	if (port->dr_mode == USB_DR_MODE_PERIPHERAL) {
-		regmap_update_bits(utmi->syscon, SYSCON_USB_CFG_REG,
-				   USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK,
-				   USB_CFG_DEVICE_EN_MASK |
-				   (port->id << USB_CFG_DEVICE_MUX_OFFSET));
+		switch (type) {
+		case A380_UTMI:
+			/*
+			 * A380 muxes between ports 0/2:
+			 * - 0: Device mode on Port 2
+			 * - 1: Device mode on Port 0
+			 */
+			if (port->id == 1)
+				return -EINVAL;
+			sel = !!(port->id == 0);
+			break;
+		case CP110_UTMI:
+			/*
+			 * CP110 muxes between ports 0/1:
+			 * - 0: Device mode on Port 0
+			 * - 1: Device mode on Port 1
+			 */
+			sel = port->id;
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (!IS_ERR(utmi->regs_usb)) {
+			reg = readl(utmi->regs_usb);
+			reg &= ~(USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK);
+			reg |= USB_CFG_DEVICE_EN_MASK;
+			reg |= (sel << USB_CFG_DEVICE_MUX_OFFSET);
+			writel(reg, utmi->regs_usb);
+		} else
+			regmap_update_bits(utmi->syscon, SYSCON_USB_CFG_REG,
+					   USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK,
+					   USB_CFG_DEVICE_EN_MASK |
+					   (sel << USB_CFG_DEVICE_MUX_OFFSET));
 	}
 
 	/* Set Test suspendm mode and enable Test UTMI select */
-	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	reg = readl(port->regs + UTMI_CTRL_STATUS0_REG);
 	reg |= SUSPENDM | TEST_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	writel(reg, port->regs + UTMI_CTRL_STATUS0_REG);
 
 	/* Wait for UTMI power down */
 	mdelay(1);
@@ -226,16 +290,21 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	mvebu_cp110_utmi_port_setup(port);
 
 	/* Power UP UTMI PHY */
-	regmap_set_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
-			UTMI_PHY_CFG_PU_MASK);
+	if (!IS_ERR(port->regs_cfg)) {
+		reg = readl(port->regs_cfg);
+		reg |= UTMI_PHY_CFG_PU_MASK;
+		writel(reg, port->regs_cfg);
+	} else
+		regmap_set_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
+				UTMI_PHY_CFG_PU_MASK);
 
 	/* Disable Test UTMI select */
-	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	reg = readl(port->regs + UTMI_CTRL_STATUS0_REG);
 	reg &= ~TEST_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	writel(reg, port->regs + UTMI_CTRL_STATUS0_REG);
 
 	/* Wait for impedance calibration */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_CAL_CTRL_REG, reg,
 				 reg & IMPCAL_DONE,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -244,7 +313,7 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	}
 
 	/* Wait for PLL calibration */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_CAL_CTRL_REG, reg,
 				 reg & PLLCAL_DONE,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -253,7 +322,7 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	}
 
 	/* Wait for PLL ready */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_PLL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_PLL_CTRL_REG, reg,
 				 reg & PLL_RDY,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -262,7 +331,12 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	}
 
 	/* PLL Power up */
-	regmap_set_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
+	if (!IS_ERR(utmi->regs_usb)) {
+		reg = readl(utmi->regs_usb);
+		reg |= USB_CFG_PLL_MASK;
+		writel(reg, utmi->regs_usb);
+	} else
+		regmap_set_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
 
 	return 0;
 }
@@ -274,7 +348,8 @@ static const struct phy_ops mvebu_cp110_utmi_phy_ops = {
 };
 
 static const struct of_device_id mvebu_cp110_utmi_of_match[] = {
-	{ .compatible = "marvell,cp110-utmi-phy" },
+	{ .compatible = "marvell,a38x-utmi-phy", .data = (void *)A380_UTMI },
+	{ .compatible = "marvell,cp110-utmi-phy", .data = (void *)CP110_UTMI },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mvebu_cp110_utmi_of_match);
@@ -285,6 +360,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 	struct mvebu_cp110_utmi *utmi;
 	struct phy_provider *provider;
 	struct device_node *child;
+	void __iomem *regs_utmi;
+	void __iomem *regs_utmi_cfg;
+	const void *match;
+	enum mvebu_cp110_utmi_type type;
 	u32 usb_devices = 0;
 
 	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
@@ -293,18 +372,44 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 
 	utmi->dev = dev;
 
+	match = device_get_match_data(dev);
+	if (match)
+		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
+
+	/* Get UTMI memory region */
+	regs_utmi = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs_utmi)) {
+		dev_err(dev, "Failed to map utmi regs\n");
+		return PTR_ERR(regs_utmi);
+	}
+
+	/* Get usb config region */
+	utmi->regs_usb = devm_platform_ioremap_resource_byname(pdev, "usb-cfg");
+	if (IS_ERR(utmi->regs_usb) && PTR_ERR(utmi->regs_usb) != -EINVAL) {
+		dev_err(dev, "Failed to map usb config regs\n");
+		return PTR_ERR(utmi->regs_usb);
+	}
+
+	/* Get utmi config region */
+	regs_utmi_cfg = devm_platform_ioremap_resource_byname(pdev, "utmi-cfg");
+	if (IS_ERR(regs_utmi_cfg) && PTR_ERR(regs_utmi_cfg) != -EINVAL) {
+		dev_err(dev, "Failed to map usb config regs\n");
+		return PTR_ERR(regs_utmi_cfg);
+	}
+
 	/* Get system controller region */
 	utmi->syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
 						       "marvell,system-controller");
-	if (IS_ERR(utmi->syscon)) {
-		dev_err(dev, "Missing UTMI system controller\n");
+	if (IS_ERR(utmi->syscon) && PTR_ERR(utmi->syscon) != -ENODEV) {
+		dev_err(dev, "Failed to get system controller\n");
 		return PTR_ERR(utmi->syscon);
 	}
 
-	/* Get UTMI memory region */
-	utmi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(utmi->regs))
-		return PTR_ERR(utmi->regs);
+	if (IS_ERR(utmi->syscon) &&
+	    (IS_ERR(utmi->regs_usb) || IS_ERR(regs_utmi_cfg))) {
+		dev_err(dev, "Missing utmi system controller or config regs");
+		return -EINVAL;
+	}
 
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct mvebu_cp110_utmi_port *port;
@@ -326,6 +431,24 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
+		utmi->ports[port_id] = port;
+
+		/* Get port memory region */
+		switch (type) {
+		case A380_UTMI:
+			port->regs = regs_utmi + port_id * 0x1000;
+			break;
+		case CP110_UTMI:
+			port->regs = regs_utmi + port_id * 0x2000;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/* assign utmi cfg reg */
+		if (!IS_ERR(regs_utmi_cfg))
+			port->regs_cfg = regs_utmi_cfg + port_id * 4;
+
 		port->dr_mode = of_usb_get_dr_mode_by_phy(child, -1);
 		if ((port->dr_mode != USB_DR_MODE_HOST) &&
 		    (port->dr_mode != USB_DR_MODE_PERIPHERAL)) {

-- 
2.43.0


