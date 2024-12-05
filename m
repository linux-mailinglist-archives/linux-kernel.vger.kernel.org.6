Return-Path: <linux-kernel+bounces-432574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC89E4D26
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E76285933
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427401AAE09;
	Thu,  5 Dec 2024 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FnSeSH6o"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5016199FA4;
	Thu,  5 Dec 2024 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733374627; cv=fail; b=LGXPFgcBPw2xfjo8iuNWsUPhrok/pa+81hTEjH/R1dmWDEA4wx+L7H2z8xmxQ3oYgA0V8RTDeVFYEhuUr40MjZ+/yRxsFwugDI6G5KbsJhsII8n7TAukgJexgdcruNjweeRBJeF5XyLiADU/wk0D+GAxII+t9mZhSfEvkExxSNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733374627; c=relaxed/simple;
	bh=un9iXQ5xghbtZREQMJotfWmXPPOY7jR+nhscSRxZpvg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uIp/ZlDRKlZQuOOM9aZT2ZyykeXoZrQ2V8rOetbjJvnxlpnClb5REMD4WzyuzE8+ZToKzi+Rz/lMO/rhkpJFeQWcI1jaVAGT4i5ReuAiRdneegTb7utw83rXbKaCMknwox4xL95j9kAKeZqmzy3IITXRWobAyFQezKIB7b5r81k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FnSeSH6o; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcLJjmU1xwBcCbZyAeNy6aIqPwy1UOk+Q6RLmOtChPD5797al2X64HhN5MGYJtfJ0Do0SOlO+OjIesY6LYntfkPTw97Il8aYhfuToiYAIYkQ9UwZ4tJNRq5EIzcKoT3h3XilqF3EOg0PuJLN4Q/2Ycrxn/WbkeukimdYNL+hjyS85fbHiI8PKRG25p0leYE0BSVJExfsAyjTIMvc/NyGP142pepFZ8beKCBJRLI/ehI/O2Z5lUrvQBZJlzg8kxsurZP0Tt0epWq0avUvFobKNgaP0b5jGwxqdDNL+WJKnRRlvFLFf+t9qEMwEIMunMh8dbISpfpuCL6wM93ki9cl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7veCpghGih4EyT0+UxUfwK10HmZpxhIQyYrVveOB7c=;
 b=sl74ktbwqC0XMhxv6P7m9Q0vfhJ8BhZPdty7EsPhsn10f8mhCzQiMjMNYEU3MedZceNTByHqmt4pjB1ULptCuwDLW2JBqVExP53jVZmLXb+p5MhYMWxQJ7tEtSiiSURSo7B9XCNITrSd8hitpWYSiHRE+Q03lyTcT/VGsNPEj9gPOKc5PdPp29+WP7eJO/407ASGk7TIXhoWLk+5V1FnByJjECTxgRuJ1lcCazX3+NI0GbkXSXY984UWnNkXGpskR5lxBqe8VcoZ38tOB8LA/BCA/QfrZ4zwDeJYMyMhC6gRPYVXXqAEQLjR1r22QI64x7l0ZmTkFbKdOdkCizet+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7veCpghGih4EyT0+UxUfwK10HmZpxhIQyYrVveOB7c=;
 b=FnSeSH6oQHAs5vlYmN4AKZZhfpjjsEcnpEIVzYoLfdrbFPqITXMb0oZUTqZfJpuh0ULefZxNwei9paExy7gM0SOshOLJpnyJHGzEK9VgeaE1zzv2MJyOX5cII7TIFP8+FK0tAYKbnWeCWlqViml1ud3OfyomDC3wkZKH3QPSBfkxx9QpA5r1eYQaNjZVtQ0vPI/H8vBusk5QVxnvioIRg4ypx3iSPmb/+kdkZDg/0jHj3FsYqVLCF/T58b2Ku8IPQwgakkPivv6nLX2b2JY16/hS/Z04I8uyL2uDE7SnHKLqwSmj0ROrBHQHXGmnM05mY3Y1sS1V22SwKlneO08D8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by DB8PR04MB6794.eurprd04.prod.outlook.com (2603:10a6:10:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 04:56:55 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 04:56:55 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 05 Dec 2024 05:56:34 +0100
Subject: [PATCH v4 3/4] firmware: imx: Add SC APIs required for secvio
 module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-secvio-v4-3-5c37cdc39573@nxp.com>
References: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
In-Reply-To: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
 pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, 
 V.Sethi@nxp.com, meenakshi.aggarwal@nxp.com, 
 Vabhav Sharma <vabhav.sharma@nxp.com>, 
 Franck LENORMAND <franck.lenormand@nxp.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Horia Geanta <horia.geanta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9358:EE_|DB8PR04MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 329330a6-883e-4f45-8de1-08dd14e93d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TE4vRjFTWTlGaFY2cEgyS3I1dHNMNndwaGVsWkpBSUgvb0RFRlpUL012Y0gr?=
 =?utf-8?B?MFBmY1MwWEl5UmRHd0JzU3hxOXdIWkZPNWtQdDYzZ0FOWnM2ajVGYVNvcmdx?=
 =?utf-8?B?eEJxK1BDVmJVdUJrNTQveW0yYXc1QkRjTXU0dlNESW8yckk1YjJhSUU2ZVh2?=
 =?utf-8?B?cDBlcmVwQ2ljWUhOTUNYQ0gyQlhjQUJ6VFFNbHBTcmttWHB4N0hoSVQ5M3hv?=
 =?utf-8?B?V1VSWVJoaHBVaWpqN25rR2g1NElQZ295NzEwQytaV1I1K3ZvZ1lhSzNWcnpG?=
 =?utf-8?B?OVBkMEhrVm51UHBvK2JFaDRrYk9lM3dpQmg2c05lc0JhQU4xYmIreHozTHMv?=
 =?utf-8?B?UkJkYmQ0NUxoYVlSR3h3RkNGYU9NL2cvMjVyR01CR1M0VjAxUlM0aUszTy9i?=
 =?utf-8?B?dEtNNEtVQnRQQkFjckVjMWx4TTVGczkrSVBLWSswZU85dy83dlhMbEVSYkRp?=
 =?utf-8?B?KzE3UzZROE1IS01WQ04xUmVzZjZqYW5FL2kzVmt6WW8vM0srS3EvTXBJRWRN?=
 =?utf-8?B?S3ptdWZEWkh0K1J3aWFESHdKNjF5TVN1MTFISnNFM05Wcys5YTBybHFNcGNr?=
 =?utf-8?B?SlFERVU4Q25iaFN4d25jOXpMaXBQQm81bU5Mblo3d0lHcmgyMG1CaCtaOG1x?=
 =?utf-8?B?UjJ0MER5NlhmcmthRkh4WVBDQkkrd0ZEN0tWTlJCZXVpMjlINmZGeUlrSjFh?=
 =?utf-8?B?WHJnOS9TRlMrMTBiYTZnMjdNZ2ZhN1Frd2lqalE4eitBMUN6cm1VUEVrYUp0?=
 =?utf-8?B?YjIzb3ExekpFU1hONGV4cXZROEtWMTFiaWt2UWVmdkhDcDJRbyt4NzBJeWlK?=
 =?utf-8?B?L1RHWTdIZmZaUUVoM2thVXlvRVVybEhDN1BsYVVkb0k0R3FxalN5djAzbWoz?=
 =?utf-8?B?QWFieEJ0NGMzeHZPRngxbm12RGd5RzVGNFFWYVNlZjRFY2puaXBwU3EzY0o0?=
 =?utf-8?B?SlFaejFEOWZGTy9yOTBnS0VNdTNwa3NOOXRxUmgwUUhKakIweHRGd0JJVFdS?=
 =?utf-8?B?WEdtY2VUWnBuYWdGbWhicWVRQXgyWFkrS1BOZTk5aHI4ZExSbDlPaXhmWFRB?=
 =?utf-8?B?em92aWdSaWp2eFR6aGFHSWhvWjJHbkpPMzZzTkNBUS84ZHM3Y21Lb0h1bkdQ?=
 =?utf-8?B?RW9VbjgydGltZTBEWjg5ZzdyNytscmxab3J4SXMvQWphRmJJTmptNFovNkhx?=
 =?utf-8?B?dkV2TERpc3BOWEI1M1lLSnlhWXBMZmVFcHd4OWhKdnRZU2VLUERQSHl6R0J6?=
 =?utf-8?B?RE5oTTRkU0JLT1NDNHpUT1ZjdjZpeU9kbzdpaXVWZDRiaVNUamdVcCtrR1E3?=
 =?utf-8?B?ZWFpdmtXaS9NVDUrUy9JeU92L3Y3RVV0c3NoN01xL3ZkSHRPODQya00yWTBm?=
 =?utf-8?B?U3ArVlBqTkZKQ2JSK0F1cnlIY0s5R1lKcFFyTHMzK2JLeWFicnJ6MVJkaFJt?=
 =?utf-8?B?bkZIeXRsOVF1UW1oY2NsZURHVU5IVEoxNWlydzM4amFuQmNRTHppT0pYTnhE?=
 =?utf-8?B?U0tWQUZxVlYvN0RYMGppSXltWURKbHFXcGNyWHBrRU1lMVNZd2ViK2JQZmdF?=
 =?utf-8?B?TDdKOHZNZzdNVkRza3RrYkdGK1ZqdExITmVkR0FrQldVTXp5ZmViQ3V2eGJt?=
 =?utf-8?B?RnJYVGxEeFpFeW40RmxRVWtnNWpBc3ZFVjdpTmpjRTdCY2NLZW9kSUJaemps?=
 =?utf-8?B?ZzhZOGExU25NajdSUVFIc3hWNFRxR281M0V1WG1mUGVBWi9WNEVPa0RGejVl?=
 =?utf-8?B?WUM5cmRjbUpkMEFxRVhZOG9leDFSY0FjaFAwWDI5UHZFdGZmUk1YeG1QRzls?=
 =?utf-8?B?TGNXZjJzeGRwQXdUVDArakZJQzB5UExJR3U0QXBQOUNCbnlEdENEbWNzTk1p?=
 =?utf-8?B?YW5ib0dEa0hlV2dQRy9tZEE3Zm5Ma1JVTzhhM1NXRlRZM0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEIxZ3IwSXNmQ1UzMWo1VXIrZjJhTGR4ZUI4dTZIVlNsTG40dWEyajJaVU12?=
 =?utf-8?B?b3g2SWVNNlV1cnlMdUJjd0oybmV2RDVaZjNnT00yenJQNlpwWVVoV0YyWVB4?=
 =?utf-8?B?ZEMvbWI5Tk5WVXBiOFVKd2JJRUVKZ1k2TDdqSExQZFpXNWRHUkU2M092dWIr?=
 =?utf-8?B?NTd6OTM0MWFqVElnb3liaTFNaklBbWVwUDRZM0ROWnVnb0J4VTBZZEhKR1B0?=
 =?utf-8?B?blBSYzd0VUZoRGw0ZUM5KzZ6QnpXZGVlUWhtbUp6clRNV25oUEgwbllyREQx?=
 =?utf-8?B?MTEyQ1M5MWlXVXFGNHBnemx0MndZZCtDOGh0YmhYbWZSazNJWmxNaW9qbW9p?=
 =?utf-8?B?TlY5OGpOb2N0WkkvbDBmS0paNTBlUkwveDk1QlBiUTQyK0MxUlNTdFlyMVFu?=
 =?utf-8?B?YWxUaFA4NnFCSXU3UW1zM2kxaVc0dlJrcU9QUERPWFJYaGdDUk1iWWxZMWd4?=
 =?utf-8?B?UGlmOE1Rc1B2Z0ZqWnJTUFpWOWo3YWxMS0ZpdEpmbFpBekM3WGxpdXZyZVps?=
 =?utf-8?B?NFV0Q3c2Umg3Nmwyd3krbGFuRXNNM2p5cGt4K25lRVBtdHBVWEY3N0UybERv?=
 =?utf-8?B?T0pNME5MQThXS0lZajZka3lSc1huSSszRm15dHhtK1dhVWIzUEJLRDRmM1Z1?=
 =?utf-8?B?YmlIT1UxUDhvMCtobEZPeFN2SEJ0SFZ3NjNaWldoWWtLQUdxSDRNaXlhY2d2?=
 =?utf-8?B?bzQzNjhZaWtUb0JvTi9kWlZFcitYZ3J6dHhJTlFSREV0ekdqZ2NkMmcwRTlU?=
 =?utf-8?B?TG1xenhmdXNGOE91akxMN2dUd2lWVDFkaDFaL3FDbTdDR3ZIVExpNVE0dDFi?=
 =?utf-8?B?RmdNZVcydE8wVU5BcXU1R0xOUVY1Ty9GQWs1b21oNm40eE83dkdUSUNJellM?=
 =?utf-8?B?OW11RXB2ZWJhakkyRGxFdzVTV0E5RDM2Zlp3K3NhcWNLSklrV1hKY1hMRWRx?=
 =?utf-8?B?WkVMdHZaOVhWV3dyWExDTHdYb2ljeUV5aThSNmR1Ti85ZWs1UUQ4YTlrcWhI?=
 =?utf-8?B?WnpvTm1WUzV6LzlDV2t5WmZPM0ZGWFFHTWt3RGZsUDBFMDNRZ0pXM3JaeStu?=
 =?utf-8?B?MHl2eExNYk9zeU93ajFOWGVBb000alRaQmlYdGVyUHRPMktvN1VSMWVCdDdm?=
 =?utf-8?B?MUhXU3pPdkVSZEIxM2FCS1JJa1FJT3A2K0p4cE0wQTU1TlhuZE4yeDIrbTBR?=
 =?utf-8?B?L2pYejlBc1J4TnFnZ1lwSUlrSklOd3JUSFZvcWJLdHo1WXJ1cVVzU0FJTU4r?=
 =?utf-8?B?bm5oVkNYMERDaUIvYkxLWitHdEFBUFBDYVJjQUhVUFVtaVlNWmsrQ1I1SGx0?=
 =?utf-8?B?TlNFRzd0Ujg3RUE4cDBIRGRDOVRvYmFKSVRaUURhbFpWb0NIS2E5ZzY3VXAr?=
 =?utf-8?B?TnJlSG16dnNmdHB5b0REcTY1U3JMK21FQTlsUUUrNVBUY1lyTDRvUzU3Qk4z?=
 =?utf-8?B?aU5zQ3pPaEt1QjFod1VXQ2lNSk1uQzZEVEZKOXNKcHFybzM4dU02clRCR3Fi?=
 =?utf-8?B?anJNVmJJRnoyK0UrcllhOEZ2L3RFc05WSExHTXVxdTBGczJrbnByRmt4R1p6?=
 =?utf-8?B?UHJIL3NTSHY0MysvRzhVb0V0ZWJDSFpqVGo5Y2JYTXQ0SHVpalI0ZThWcUJq?=
 =?utf-8?B?ZVc1M3ZUTUhBd2ozNmdMZ2NvMy80SHNBOTNCQ2xtalhjZkV0alFqMUo0NjRr?=
 =?utf-8?B?OGR5ZEd4a1lyMDAwVm5GNkcvNHhzSS93bmt3ZC8wbGpoVVM4Y1dZVGpqeFZl?=
 =?utf-8?B?TzlkSWt4TWFxWldRaDVaUk9na1JZb1BHc3gwMmw3N29zYkhscVJleHlMYlFh?=
 =?utf-8?B?OGJDMURDSHNWN3ZHTzNQUTd5dXA1eTdLRlNEZHZGWDhLTGpZMjE0bEdVbld4?=
 =?utf-8?B?TCtHRm1GMW5ucTU4aFZzSktWNTFsMGVmODhpOTh2OGwwdGR6Nmp5dHlURTVY?=
 =?utf-8?B?RDJSbGZJZm9UN2pvem1Ocm9CWHdsR2NNS1FUV1Qxb0FlL3NwOXVkVHE4NTB1?=
 =?utf-8?B?S2ZWMm1ybW16ckJJNmx5VVlnT016R05BVlVxRGdwVFoxckFsd2U3ZlgxMW9x?=
 =?utf-8?B?NXNlQmduUHJ4RjJKRFB4Y0NvZVNVMks1VUR0RmVRVVBDVE1SejBtNHhWaGt4?=
 =?utf-8?Q?ENaN+rnwsyFzZ6CyhC0MqiEE4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329330a6-883e-4f45-8de1-08dd14e93d13
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:56:54.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDeeJqyV7EpqXpmKYaN8sAHpulUIE/VmHTVv/LNo5RwXeTwvyaRV13T1VavyXk/GTMKI6Dsabrhptebb0Afvcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6794

The Security Violation module requires below System Controller
Security controller API to interact with SNVS block via SCFW
    - imx_sc_seco_build_info
    - imx_sc_seco_secvio_enable
    - imx_sc_seco_secvio_config
    - imx_sc_seco_secvio_dgo_config

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta<horia.geanta@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/firmware/imx/Makefile         |   2 +-
 drivers/firmware/imx/imx-scu.c        |   4 +-
 drivers/firmware/imx/seco.c           | 216 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/ipc.h      |   1 +
 include/linux/firmware/imx/sci.h      |   4 +
 include/linux/firmware/imx/svc/seco.h |  69 +++++++++++
 6 files changed, 294 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be8..7aaecf570c56 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o seco.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 1dd4362ef9a3..c96dc73689a8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -242,9 +242,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 		 * APIs are defined as void function in SCU firmware, so they
 		 * should be treated as return success always.
 		 */
-		if ((saved_svc == IMX_SC_RPC_SVC_MISC) &&
+		if (((saved_svc == IMX_SC_RPC_SVC_MISC) &&
 			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
 			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
+			 || (saved_svc == IMX_SC_RPC_SVC_SECO &&
+			 saved_func == IMX_SC_SECO_FUNC_BUILD_INFO))
 			ret = 0;
 	}
 
diff --git a/drivers/firmware/imx/seco.c b/drivers/firmware/imx/seco.c
new file mode 100644
index 000000000000..2d6bf301ac87
--- /dev/null
+++ b/drivers/firmware/imx/seco.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020, 2024 NXP
+ *
+ * File containing client-side RPC functions for the SECO service. These
+ * function are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/sci.h>
+
+struct imx_sc_msg_seco_get_build_id {
+	struct imx_sc_rpc_msg hdr;
+	u32 version;
+	u32 commit;
+} __packed __aligned(4);
+
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	struct imx_sc_msg_seco_get_build_id msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_BUILD_INFO;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	if (version)
+		*version = msg.version;
+	if (commit)
+		*commit = msg.commit;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_build_info);
+
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	struct imx_sc_rpc_msg msg;
+	struct imx_sc_rpc_msg *hdr = &msg;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_ENABLE;
+	hdr->size = 1;
+
+	return imx_scu_call_rpc(ipc, &msg, true);
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_enable);
+
+struct imx_sc_msg_req_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+	u8 id;
+	u8 access;
+	u8 size;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+} __packed __aligned(4);
+
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	struct imx_sc_msg_req_seco_config msg;
+	struct imx_sc_msg_resp_seco_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_CONFIG;
+	hdr->size = 7;
+
+	/* Check the pointers on data are valid and set it if doing a write */
+	switch (size) {
+	case 5:
+		if (data4) {
+			if (access)
+				msg.data4 = *data4;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 4:
+		if (data3) {
+			if (access)
+				msg.data3 = *data3;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 3:
+		if (data2) {
+			if (access)
+				msg.data2 = *data2;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 2:
+		if (data1) {
+			if (access)
+				msg.data1 = *data1;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 1:
+		if (data0) {
+			if (access)
+				msg.data0 = *data0;
+		} else {
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	msg.id = id;
+	msg.access = access;
+	msg.size = size;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_config *)&msg;
+
+	/* Pointers already checked so we just copy the data if reading */
+	if (!access)
+		switch (size) {
+		case 5:
+			*data4 = resp->data4;
+		fallthrough;
+		case 4:
+			*data3 = resp->data3;
+		fallthrough;
+		case 3:
+			*data2 = resp->data2;
+		fallthrough;
+		case 2:
+			*data1 = resp->data1;
+		fallthrough;
+		case 1:
+			*data0 = resp->data0;
+		}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_config);
+
+struct imx_sc_msg_req_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+	u8 id;
+	u8 access;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+} __packed __aligned(4);
+
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	struct imx_sc_msg_req_seco_dgo_config msg;
+	struct imx_sc_msg_resp_seco_dgo_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG;
+	hdr->size = 3;
+
+	if (access) {
+		if (data)
+			msg.data = *data;
+		else
+			return -EINVAL;
+	}
+
+	msg.access = access;
+	msg.id = id;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_dgo_config *)&msg;
+
+	if (!access && data)
+		*data = resp->data;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_dgo_config);
diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 0b4643571625..df38ab8e7e2e 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -25,6 +25,7 @@ enum imx_sc_rpc_svc {
 	IMX_SC_RPC_SVC_PAD = 6,
 	IMX_SC_RPC_SVC_MISC = 7,
 	IMX_SC_RPC_SVC_IRQ = 8,
+	IMX_SC_RPC_SVC_SECO = 9,
 };
 
 struct imx_sc_rpc_msg {
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index df17196df5ff..947e49d8bebc 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,6 +15,10 @@
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
 #include <linux/firmware/imx/svc/rm.h>
+#include <linux/firmware/imx/svc/seco.h>
+
+#define IMX_SC_IRQ_SECVIO            BIT(6)    /* Security violation */
+#define IMX_SC_IRQ_GROUP_WAKE           3   /* Wakeup interrupts */
 
 #if IS_ENABLED(CONFIG_IMX_SCU)
 int imx_scu_enable_general_irq_channel(struct device *dev);
diff --git a/include/linux/firmware/imx/svc/seco.h b/include/linux/firmware/imx/svc/seco.h
new file mode 100644
index 000000000000..508444c02d39
--- /dev/null
+++ b/include/linux/firmware/imx/svc/seco.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020, 2024 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Security Controller (SECO) function.
+ *
+ * SECO_SVC (SVC) Security Controller Service
+ *
+ * Module for the Security Controller (SECO) service.
+ */
+
+#ifndef _SC_SECO_API_H
+#define _SC_SECO_API_H
+
+#include <linux/errno.h>
+#include <linux/firmware/imx/sci.h>
+
+/*
+ * This type is used to indicate RPCs/RM/SECO function calls.
+ */
+enum imx_sc_seco_func {
+	IMX_SC_SECO_FUNC_UNKNOWN = 0,
+	IMX_SC_SECO_FUNC_BUILD_INFO = 16,
+	IMX_SC_SECO_FUNC_SECVIO_ENABLE = 25,
+	IMX_SC_SECO_FUNC_SECVIO_CONFIG = 26,
+	IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG = 27,
+};
+
+#if IS_ENABLED(CONFIG_IMX_SCU)
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit);
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc);
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size);
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data);
+#else /* IS_ENABLED(CONFIG_IMX_SCU) */
+static inline
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* IS_ENABLED(CONFIG_IMX_SCU) */
+
+#endif /* _SC_SECO_API_H */

-- 
2.25.1


