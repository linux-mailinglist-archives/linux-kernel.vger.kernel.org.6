Return-Path: <linux-kernel+bounces-243924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0D929C7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B6D2810DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EFF1864C;
	Mon,  8 Jul 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kr5H30Bo"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF91111A8;
	Mon,  8 Jul 2024 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421480; cv=fail; b=ejtAbR5C/i/qnwOYfCpAxeOotfMxq7YpkFrUH50vqPHiDS0Wg7k6S0wk1BQLm4Z4btP6eCOD1uJaF4DMqBoYTF5UQ7k83V5UdBkEst5fR1G/hq4xVMjtcfffH4A1hp1Qyy+RdeBhDJ2HIme3CbQ+amAj1fJ6GVbuYV3UoujmX8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421480; c=relaxed/simple;
	bh=+NEHTXV6BcUftgn/+z47VRCQQEQFTVorl5WO8fvaF+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bucLdOrsb1S5BlWnVaIsoCuwQGLBq1U6O6kLfD+XuvEpD8Dz1Jp0wgDd3LG/i+qaYh0FNZMlP5BH5VMRRw6KMPxGdNJCh6kPd5mxb9PMGUgPZhTwRdibzBb13qxipftAPhhAnUI/AKAjEDWwxmvevt8K+nMq7sxy8QHGvN0BcS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kr5H30Bo; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWf0ShokhOF127Ecy7rbu/M1orVwBUa5/8Jbwt+lXkxd+ti+e0sVjSTCnRmadbMB73rvyffb1of/GSjmKzofC4LSPNeInFXUPoIqkvQu76k3QvZQUgLFZ4+atQd37RYveOwQnng7cxe8X9i5vo5eoApht9VItn2h8M5EPb5T6NJS/wkV0n7ftgtB9KKXxa6g8eYPjAXLWF6/7rYpxxJUu364M6VmyihM4iYOsyQ1vbEvrvd13Ul9w/kndW6HGPhPJWRpPJqHsm4HXqLyuX+a37T/Ng4hchzpZvzO0ZyVPEmBcC+uP0GMY2jHCEF4+wmycoS3Ib7GrxqovwV57bu6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oidvAYGAJcR6bQ8ZpvnET9iSlpJe4fn0RPvFmQW9UEA=;
 b=Sl4NtvgzeQHHuN0chjQPDJwccChSZcq/hKOB+ee6tAD4MAY/jAcpWqmFUcRL3FJM7gAAWgZX1LbyXNhTXZ+0CO4YJV5MEQr6y4Dq3DRF8v5pQqftZLCedNEIRaSae719Q7J+Frp749ZQwsY87ZDteBzid2QVZQWYmbNyKALAWQcHxlF6cbhkjP33yK7efc7b7KUI2pR+wI5AIKx3NC2EjuYgHTSDr8P2dlqHwwFGupWBXeWAs0BG45ajvNgIYdkKEsQ7FJSFGAXxtJdc5M/mqZNn2pn9Eg484YMqQca8Fxy4kbzBcv9WxM/m5Tg8P4PdqWY+pntvGC2eWxVxx0TEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oidvAYGAJcR6bQ8ZpvnET9iSlpJe4fn0RPvFmQW9UEA=;
 b=kr5H30Boj2lG2OiVLJfTpguuWNjDEE2PQdcv2CK9XOjVq8JWQhAtOoqmwMnWQN6CgbnR+8xvj3Z6Zgi5GxBPSC3H8MoQdqM/0Xxuv+EhhhTUAMVE+WLLXFMGKi15FKWRoZGSK1VNnlX/4dGkK8Dn2DYOpEAuMB7siavl0HEWL8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GV1PR04MB10274.eurprd04.prod.outlook.com (2603:10a6:150:1ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 06:51:15 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:51:15 +0000
Message-ID: <31301581-a710-4e25-a079-e017686c52ec@nxp.com>
Date: Mon, 8 Jul 2024 14:51:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] dt-bindings: interrupt-controller: Add i.MX8qxp
 Display Controller interrupt controller
To: Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, tglx@linutronix.de
References: <20240705090932.1880496-1-victor.liu@nxp.com>
 <20240705090932.1880496-5-victor.liu@nxp.com>
 <b0cbd659-21b8-4049-8882-f49275d4a247@kernel.org>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <b0cbd659-21b8-4049-8882-f49275d4a247@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GV1PR04MB10274:EE_
X-MS-Office365-Filtering-Correlation-Id: aec34b0e-3e9a-477b-f581-08dc9f1a5cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTBwV0orcFdFVmtUU204MldOSWFXSkIzZFh5YWd5TVovazV6VTIwbUxwQWF5?=
 =?utf-8?B?K0Y4a0lJWWJkeXppYlI1ZmRiZitXZjR1WGRBMG1qSXFCVmJrQjZIWnZSeFNp?=
 =?utf-8?B?dzVWalZIQWtLVXVKc0d4ZjBtM2JhVDhmZUtUYzZGUXNqOHB6WGYzN25XQjhQ?=
 =?utf-8?B?Y3psRXJORHFob1p1Q0JlanIzUTdmZGtmTVBoT0xWS0tWNmdacndEdjgxYnVl?=
 =?utf-8?B?RkIzSXNsUGpYZVJqWUpxaEhPR2EvMTE2VFlBUCttaVh4WUxlTGlnYzM3dlda?=
 =?utf-8?B?aU5SeCtPQ3RhNkdtcFpUckNmUHhSTzdmZm1KU3hIOWd4bWl5QXZnZDFHa0dX?=
 =?utf-8?B?aXhvU0dCcng1T1Y0c3ZBNkJGc0xuUnJSZThpb0lSODBJeDVRbUppdGk5cy9k?=
 =?utf-8?B?RjVIMTBieHU3R3lneHUraDVuQ283MFBNTUhqWDlDM2xVNzNDamNkd1R0MXBX?=
 =?utf-8?B?a1Q2M1hFY2NzbTlObUJsbUhZNEtnV3ZXbHVuM1FKVTVuOU81OFc3a2FBKzc1?=
 =?utf-8?B?S1lxSXZIT2FZK296MGlFNmlMVkQ2T3NiUEhYRkVGUnRVWnlqNStPSkpYUDIy?=
 =?utf-8?B?UWk5MmR5ZVFJdUNaZUs4KzRHV1JuVkpIaXhBeEVQbGRJeTl2ZDJXaEZwZE9F?=
 =?utf-8?B?bVFHWElJck9GMzNLdk54eUJxYm5jR3RtN2JGQmpvSkNJVEk3QlA0ajRBM1pQ?=
 =?utf-8?B?UDBuWjg0T1dISk1tQmlCcnRyRWJsTXFyY1RaZE1BTStXUVhqRGNlL1NlV3Az?=
 =?utf-8?B?SXl5RjZjeG5yeG1ndmpvZjFzWWhlVWVnKzkxem1GQzB4WU9QYzMyeDk5MmN6?=
 =?utf-8?B?Z2pkbWoxNUI1YTJSeDBDb1hVWWVqQWJhVE03TFBRYzJuTzNxMTBSSEp0dmpQ?=
 =?utf-8?B?QmdDRGxnRkRoS2sraHJNV1lvM3RITjhBRnZOQ0xxT1NwZVU2U3lINHZzR1Bn?=
 =?utf-8?B?M1Z1Q2tHbFNhdkpWQ01sUWhteHFKcmIxeHlmWVc2R1VMUHVuOVFnWnlLSGtV?=
 =?utf-8?B?ZDVqdDc5WEtwM1M3aWRhSndmREpaYzVXMjlSdVJ0S3c2Q25PSHVLSDFvZ0Nx?=
 =?utf-8?B?V3BpZ2laWUJiNVVnOUlrYU43VklSV1VEMVlQcFlVU244YXhFMFRzSWF6Ui8z?=
 =?utf-8?B?L29iRGNGVC8yOElCTENjL1AvYWFqdCt5UDN6SkRMaTQ2TFgyMGhvTXdHUjFk?=
 =?utf-8?B?V2pxWnFzeUdQMi9NVDY3eXRkdFZnazJwZW9MZlozcFJGWlF4VVdxbWFvZ2Z2?=
 =?utf-8?B?c1pVczF5NEFhS2JaWGxKaUtocktXRTQ5WnFBcHNoNEZjeWVuRUpJK29YNHA1?=
 =?utf-8?B?UzcvY3pUMmZIbGlkWU83NmRta092d0xnOVhzL3VrS1BZVzQ0U1JJVHcxV1E0?=
 =?utf-8?B?c1locFVTYkozSFQ4Z2R2WFJjQmYvcVpiUGFTakRQckJHamJ2bS81eUR0QVVj?=
 =?utf-8?B?K1FMQXEvRDlwbVRraWswdjBnMU5MV1d1dFVsbUE4amZrUDEzSk5LSVdGZW1u?=
 =?utf-8?B?aThRTFNaWFRIcFVFajN5RkN2dldrN0dKN25haW9XMjhaeisyTVllblVCa1k5?=
 =?utf-8?B?WXZhUzF4MmZLUWhhU3pRYTliNmdFQXF6bzhZaGV6bVZsQi9MOVZJV0FZanFC?=
 =?utf-8?B?QjlIS2taUS9sMkcrcWZ0b3IrUndhcW55WWZzNzl2VURwNHJRK2o3N3VacGxL?=
 =?utf-8?B?QStJcEJYMmVTdG5UeWh3NXpOZGFRTEJpanFraXdhTm5VcUdpcWcrMnZSV2Zs?=
 =?utf-8?Q?lhkx3xq15BWxlUVUNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWNQZUdmbi9oMWFtYnJ3cHVhc21Bbld5RTlDdndUWHMyb0xNM0tYOGVwUTU3?=
 =?utf-8?B?eDFPalBVa2s3ZTFJNDJMR0ViVVBqdHhXVTN0T0ZHRSt3aDR3cjNoUm1oUExo?=
 =?utf-8?B?cU93Tk1mMHBqbXZVcjFXTVNXYXVvSW9ib1RUOVFGUFdhLzU4T3NjNXpRam80?=
 =?utf-8?B?VWJOL1BDV1dTaEI3N3Z4cXFQcHl6Ulp1am85eHE0OXdURnYxZDZlU2p4QmZM?=
 =?utf-8?B?alJDUW1sRGJXNW1zbm1hb1JOdnpEN2R0TmZnRERFL29HVkNvcjRvVWlmQlFy?=
 =?utf-8?B?VUl6TnJDdnpqU0xmci9OeFRLOTZxUVFFUkJxcDdZa3Y2QkpoaVJLRDl1TkZK?=
 =?utf-8?B?d3BZVGZXK0pmMlI5cGRxaGNpdUFqRm1id1RzTTVKVWJGVGtya1pJTkNJelI5?=
 =?utf-8?B?bzF3UFI0eXdBVHgrakliaERPWmRNNXhkOXJwR1lFOCttb05acUlGWDZtNjF6?=
 =?utf-8?B?cExwUmdtajduRzRXVm5LSTVsSFRvSjJTOEsvRTlmK09RMzJqdWJGRGpZUlps?=
 =?utf-8?B?WFdEL3k3c2RhMHAwTTE0NWJoeDBDeURnZXduOGJGUExuQ1dtTDcySDNESVlW?=
 =?utf-8?B?dHNOUFQxZmhnVWZaQlJnYldpQit3OWIyR1I5bTBRTkNpd2pvZVVWUytCSjU5?=
 =?utf-8?B?ZlNSMGxlVVlockRTMGFxOVptSGJqZlRlZU53Yit0VW92endobTlRVzNxcGJY?=
 =?utf-8?B?ZVV0OGRmTkhVRzA4RUxCRHlZWi9oTitEZitMakp0QWpHZE1ZY1JQaXo3dEhq?=
 =?utf-8?B?UFRDQ2liVVI0YjRKSmVEWmZVQzdaNU9CMHBSY0JzcW9jMmwvTk04NGpvdnJV?=
 =?utf-8?B?RzJpUWFkdnFid0V5RDVlUXNTaVlCb2htYUhhRHdweHpyQm9UVTFJeE9NaFVh?=
 =?utf-8?B?amlsMkdPNnNHTXRiaGt2ZU12SVV0eUFCa1BkZko2dnN4RzBRR1o0NVlmbHdG?=
 =?utf-8?B?b3pkTjc1a3JGS0NRemFTcWFsQVBlTTFzRi9LNlVFWi9MZnhpMlFTcVRuUHZB?=
 =?utf-8?B?Z2Z5Rzc5YVY1NnJTWDdQUTRQZFlLK2JJdkZLUVBwSkVPR01SMTVoZkRhUm54?=
 =?utf-8?B?OHBteGoxT1F5TEYxODJYVjZrNEJ6cGlsT0s3Z0c4M2lZaG1UNnJ6QkxCY2tz?=
 =?utf-8?B?UTlkNld1WnRQRW42djFYUHdaMy9QQnlNMXI0ak5oejV3UzhFY3JMOHZKbGt2?=
 =?utf-8?B?ZWVQVlczTG9NSFdiNGFNSVRYbUh6THowUVVIVGxLL1phb2tyc0N5V25HTWh0?=
 =?utf-8?B?dzlDMEVjV3N2N0swL0dUU2lBZWFQV2VSTkVvaU5YWDNmc1FtSlI0bzJOT213?=
 =?utf-8?B?OU8yVk82a29DS1V4VnpBNUR2SzlFWmxaMndEOCtpUkoxbGVrR1ljQTF2Ni8z?=
 =?utf-8?B?QndMZnA3OHFnRnNla2ZmZ3IwVlRtcWdObmFTWmNLWTUrSm1pN1lHTkZ1Vm95?=
 =?utf-8?B?NFlZSGUzQmczc3RXNjlaVlVZak0vU2RiNENNa0NCTTNRZXI2eDdkUDVaZzlv?=
 =?utf-8?B?NXdjN2M0OEMyNGF2L1FWZlZwUExVUXNkdkhqYytEMDduTHdLOHY0SnRGbHdH?=
 =?utf-8?B?UWlXWExXK2hVQ3JIWVUrWFppSG4vOHFIQUJpSDFZaFZERTlMR2FDS2h4S2Jq?=
 =?utf-8?B?ckRySHZReDJJeWNpalNrMGEvTTNYeVBLNGZwdCtMZ3Z6VDZiODM2cGVFK2hm?=
 =?utf-8?B?UXBrVUtjMDVKeXRvSHdEcDFhZmRNK0Y2b0Z5M2Eya0tGcHk5UTMrYU0yTjVx?=
 =?utf-8?B?dHRmeDNBbWFWRjRjMzNWR0c2RUtlNWNjblpabVJnR2FqSlBIenVOR2VWaWlN?=
 =?utf-8?B?NDl0dlpFUkRPd0cyZnZLN1BlWnFjUHh0VnhzVk93TjRIYzRyKzNkTGJUVFBE?=
 =?utf-8?B?YVRRNHZIdDRiZWFpYlgyeDJRVlRTa3dmbDZEYk1pWnBaWStQaElXMFlxUWRj?=
 =?utf-8?B?OCtyUVBVUGNwYlZpR01RUW1DSGRhdmRXc21rZUJOTklzSXA5c2Ftemd1N1d3?=
 =?utf-8?B?WkJ3WklhWTkxY1dKM2RaU2t4bVVEdmZ4eFZjODZ2Z2g5WWlZVERuVmE1Sjk4?=
 =?utf-8?B?dzJ3WDFiOWJxNWkyUlZzWDQvdDVoaUNlQW5BUFA5UjFwa1hWWk9nZjYyZG4w?=
 =?utf-8?Q?N3FqsVz6liVdQIRp/XWu/xpr5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec34b0e-3e9a-477b-f581-08dc9f1a5cbd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 06:51:15.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JDI81H3Lci4MDGjHSpIa0llrSquEqy93U1AaJdK3lh8fowd4+9O1uje8GNLf2gn6YNw/iRVrUpd+rGfqhB0wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10274

On 07/07/2024, Krzysztof Kozlowski wrote:
> On 05/07/2024 11:09, Liu Ying wrote:
>> i.MX8qxp Display Controller has a built-in interrupt controller to support
>> Enable/Status/Preset/Clear interrupt bit.
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>>  .../fsl,imx8qxp-dc-intc.yaml                  | 321 ++++++++++++++++++
>>  1 file changed, 321 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml
>> new file mode 100644
>> index 000000000000..3d0d11def505
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml
>> @@ -0,0 +1,321 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/fsl,imx8qxp-dc-intc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Freescale i.MX8qxp Display Controller interrupt controller
>> +
>> +description: |
>> +  The Display Controller has a built-in interrupt controller with the following
>> +  features for all relevant HW events:
>> +
>> +  * Enable bit (mask)
>> +  * Status bit (set by an HW event)
>> +  * Preset bit (can be used by SW to set status)
>> +  * Clear bit (used by SW to reset the status)
> 
> 1. Why this is split from the main node?

Maxime suggested to do so:

"
But at least the CRTC and the interrupt controller should be split away,
or explained and detailed far better than "well it's just convenient".
"

https://lore.kernel.org/lkml/2k3cc3yfwqlpquxrdmzmaafz55b3lnqomzxjsvtetfriliqj3k@tv6uh7dzc2ea/

> 
> 2. Who can use this interrupt controller? Children of your display unit?

Yes, only devices in the main display controller use it.

> Then it is not really a separate device, is it?

Er, per Maxime, it is a separate device.

> 
>> +properties:
>> +  compatible:
>> +    const: fsl,imx8qxp-dc-intc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: |
> 
> Do not need '|' unless you need to preserve formatting.

Will do.

> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Liu Ying


