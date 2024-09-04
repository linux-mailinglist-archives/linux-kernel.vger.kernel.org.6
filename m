Return-Path: <linux-kernel+bounces-315050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849996BD32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0BF1F22783
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D21DC726;
	Wed,  4 Sep 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="XThbLlcQ"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2122.outbound.protection.outlook.com [40.107.103.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE91DA2E4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454358; cv=fail; b=Lh+WwhqCY+iZk9plSzP6qlnxHb1r6FnGbLgPsLGTyisH4ocK/7202RP+nk6iCrm5iPZIDHBFBLC5J2vsOH8A6+E21Vswqbi9YTGFoQlr0AcMcVatbrO7IOERXlvN/WVZdsI8G3mLK68aObtjZGzaQbAEenRtpzz9GzFtyLdRQGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454358; c=relaxed/simple;
	bh=vwswVPzU4H0aHVZixZya5b36D2L6ydmcyQwIwvOtqzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i2Y/Gyhf+8X1KOoVYsgNKgrUQ4YwBRJIZWR+OtLrAbY6u7TVFBzxoB+hfPK/ZFFmADYOgYM9n5alfH9Dypo3afuDoiB6uLBLsiHtdS39bKEuPn3BgzJZE09L/ssGrHQdH1+XrweEf51TUsb2oRQRaYfnVMQzTgpnQVLCwnlQpso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=XThbLlcQ; arc=fail smtp.client-ip=40.107.103.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1256SdafwKy5ojajJvDLyMMSC4E5NOGMUVc2HZO3wAV9UDebw/DdMdXsz97j0aPMErHFGkWVs0xpHo2l33qYJr74hFWZqDtvckqFne43f2W+jE49o6TduDruWE/7rs7nAcZNiD+bFk9tUf3b8oyvAevv3QzBLC1YsAgTff/OfXUXaO/3UVP/JmL7DQrrDiS3Q9sv1U/RfmxChkwys5C7I5vFmGepMQ++De9vS4ulgi7Zp9kEP17ORLRk5ldGtYkzvsXFzvPribHyy9h0u6p3kCwdYnc15n40c5peZvXTzyTXjKR5dKHwzJkuxuunN+QL/j3bRgHyW5KurLQbHkLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUfSKMHnY421uxuWm1S5Rhr7yMzTWC1WAkImkDn4Oco=;
 b=HmRIX5So++KqFTZSlKSuO+h/JhYM37BP33rrsWs/DHB62U8ftgZGHd3UIKNr+otdrXmPeLB6yYD1fl2cKNgWYuEDfZTNJHiZ9S3Kt34nGvskKGGMsjILlhSpLuFCcUMesdE+Wf8lhEzLmtELoCCa4VX/06Dh83B73oM4VWSTwvdJxt3LNssrmBplp5brwrcIAR3x3sHwYs8eMtD5szcgWknv76bY5jQm80GIoPGVemMDIfoDLHPBpLTZsr3SIqQb/hi5LrD6PbtcZ5EQmQnO+9RTnh0QSX+LIW579Z+Ouxoa3Wh7MucT0w1AWvpdSUFeDWXZqCdarKCvwIIhvu00Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUfSKMHnY421uxuWm1S5Rhr7yMzTWC1WAkImkDn4Oco=;
 b=XThbLlcQNRsFDpiP4KrsZuq67UfsxryQHfiIyOYPnA9kZ1EDVcHz09WZxXsodTQRlBLKmxnphafQ3IjLNUD4EUjEI9YhGdb9/a6Csz463tl7o+m4yB5OMiH1+gjkvYdf1d//enUwGFTjDvzxj+OCxS0k6TVIQpqOu1lb7XhtAEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by VI1PR02MB6397.eurprd02.prod.outlook.com (2603:10a6:800:17e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 12:52:22 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 12:52:22 +0000
Message-ID: <6267cf2b-1c05-ec72-9ac8-e715561d5bac@axentia.se>
Date: Wed, 4 Sep 2024 14:52:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] mux: add mux_chip_resume() function
Content-Language: sv-SE
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
 <20240613-mux-mmio-resume-support-v1-1-4525bf56024a@bootlin.com>
 <94069d56-0981-2d69-65c2-901a05758806@axentia.se>
 <f5067055-1470-4386-8839-b4ec2527872e@bootlin.com>
 <4cf89e3d-7164-67b5-0a3c-9e8e4df274eb@axentia.se>
 <c8a82583-5570-4286-9f1b-00a2717bae4b@bootlin.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <c8a82583-5570-4286-9f1b-00a2717bae4b@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::19) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|VI1PR02MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 58468747-2f76-4caa-0780-08dccce06b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW8xZ0dNU0s2c3hxNHNuWlU5V3dqaldjejJHRHAvRm4wYm1RTWlMazJ1UjRm?=
 =?utf-8?B?UUhxNEtTTVBoR01Od25VRENzanQ3MzVhekVHLy9OQTVQVzhJYUg0UUhSN0Jp?=
 =?utf-8?B?bE5kRGVTN0piODBjQjk5cHBXUXo2WTg1SUh1UDBtZGI4ZzhXejFxa0lMRWNx?=
 =?utf-8?B?VG9zTlIvaG9aakpIZjVxTUNBRmFhN0tld09uc1lYZWlEdDZpRDU0bWFETzN4?=
 =?utf-8?B?a2h6WitzbEtOYlg3NS9ZZ3R1RnJzVXlUbkJJUjI5elNtRVZQMGFFVTNTTmNG?=
 =?utf-8?B?cDRtK1M2bXRXbVZlV3FRaU9WWllzRFhJUWhFYk5XcHBQbnNOU085QlVVVUtS?=
 =?utf-8?B?a2lOWFRjeisxNnV0K2IvOUJnRG91SjhsQ2x1a2F1ZmI0YVRJcmdRNE1VSU41?=
 =?utf-8?B?RTRyTG0rZDNmT2hFSlNUUmtLYU5YMUF4ZWUyaWtDM0dCNHZwUWY0andXOGZL?=
 =?utf-8?B?dWFtbjgxNWV4U1A4R3hYNW1xbkVlMzcweXJFWnpBNU40eG1YODFwZGw2QkZP?=
 =?utf-8?B?OXBHOWdQbmZhTi90TWxqcVdSaFFkM3J5MndqVm5ZclA0N1ZBclRCQVg4OTll?=
 =?utf-8?B?Q1FQSHg3TW1qUE9aaWlhN3F3dmswRE4xWER1dEUwVU55OVBqMVJkNW81OFpo?=
 =?utf-8?B?Tk5lSVF1SnhGcFVFbTBXUXRKcXVCSXRJdEFzMm5Fd0E2WTFGSUlHNGtwdE5D?=
 =?utf-8?B?NzdYTmd6VzY4NUJmK3loZEMrcnNpaFJ6S0piZEY0QzZpcmNlU3JBUVprb2Ro?=
 =?utf-8?B?WHNlRVRwcjNSb3k0VG9xWkYzOGdGMHRzMmMreE5QMWhtSzd2Y1JZSEdaVUpS?=
 =?utf-8?B?bzRIbkZhM25xRDU0NHRtQThqSXA2TVRRUnJ4QW1ONDZTQXA0cVQwUmtoRk1R?=
 =?utf-8?B?YUZhRTBneUIraStMbGNUaG4xSFg1aDJBc1h4TVZpTUhhMlpLcFY4a1R4Y21n?=
 =?utf-8?B?b1ZOS1RDcHhKQzBadVlYQnFKb25SUWdPV3hvMG5IaHZHNi9KSDlyNzR2UVE0?=
 =?utf-8?B?Z2pvWklrZGFTNC9uV2ZlbnVUaTJZdjE4UDJUa1gxK0doS3dSaXdFZGMrUDY2?=
 =?utf-8?B?Y2t6WVBiOWZDY29ONjZ3Z0RVYTZQdFZHRHNMajB0alBZNkdtM3lDU0lRNUFO?=
 =?utf-8?B?ZTV5aWdFMzdHTlVPbDhyT2dQS3VuL1YzeDM1SXRud2lHaEpmTk84Qm1DNW5Q?=
 =?utf-8?B?OHExc1NqZnozeDFlUFV2eE1zSzBEdlNtZnVGS0RyYXhrMy9mZUt5UlVDTHQz?=
 =?utf-8?B?aFNHSktQaTdLZ0lKK2xkc0N5RnZLb25uaDA3NC9QMlp2VnVsdFdzcENiMFBu?=
 =?utf-8?B?Nm1HaTZ4cG5aN00zMXFhdFc4TEpSazNnUnUyeWVkbFNBUTc1VFJRS2p0VFNT?=
 =?utf-8?B?WDZENEtiMks5a2ZScERKQ2VzSy9UR1JRQmtZa1ZCRWVKb0xNdms2NHEwemIx?=
 =?utf-8?B?TGRHT2R6b0hSVkloVEE1clQ2RlJ1Sm5xT01yNlMzd0VldWhjaEtDZ3NLeDNz?=
 =?utf-8?B?UEFGRWU4a0Z4bU5QK2MwTXBaWFJYSnBPVURQeURIUC92WXBDTXV2SWQ5VGhj?=
 =?utf-8?B?R2RqUWplNDU0VllVWjl2eW5ic3cyN1NrcVZybUpwWGZNS0hpM1k1T0wyTVdy?=
 =?utf-8?B?dnh4UzRXZjQ5VTdBTGtROFpjZ3lGeDdzczZVdTRtTHNMUTFQMm5kRTZpZXZm?=
 =?utf-8?B?TytZTVpwLzEyVUI2WkNxcWp4UGo2UExXakRNcm9UdDFJZENGZGR4cUZpZjNP?=
 =?utf-8?Q?vbOfpu5+VyxTuc3lrg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3I0M0ZZWUVtOVZ2bW9ZVHhpUFl6RDI2NW5RK01CVHRUMkZjUHc0cE1oeWI5?=
 =?utf-8?B?WUx4MjJBTWFVNTYxcmYwSnNHT2YzUHVPUG45UEdHalc4NzVvQXVseUxaNSt5?=
 =?utf-8?B?VG5iV0Y3VVQxZThGWW1ScXlrbW9nYVlnTVpscXhscm5ZZzdZd3BPUDF6UkxP?=
 =?utf-8?B?UEREVVgxZHVTN0psSVhETXJQbkV6WVpwai96WHp4Wjl2OVR2TnMzYU5kTURW?=
 =?utf-8?B?cmwzOHZ6T2tpVFBDSjBKeUlQdnNkSExjaFcvRzkvVFZZV2tqVitub0hpUzdC?=
 =?utf-8?B?eHBuTlJLSXY4RGk1cjFaMzBXQ013V1I4YThCYll3cXBvWkNENEpuVzAxMjNo?=
 =?utf-8?B?dU9GK3o1Wm51am1tc1d2MUFZcjQ0RHpkUmlsb1F5bm5TOU1nN0RuV1FTSmtI?=
 =?utf-8?B?UUVPTmlud0tMdGZTYmFnRVBJM2JNSjdIOFZjWUVMa3padUJvQnF2bEhoN3li?=
 =?utf-8?B?N3JveXBtVzdDeHB5RC9XVDlGSU1sY1FGb1RKcjQ3UTI4c1BtYjFHYkgza0x5?=
 =?utf-8?B?SDBiLzBSNHFxVEhqaXRwb3RVQkFOSWsxRk9heU95M0pGa043YkxTNGNnTG5w?=
 =?utf-8?B?UkZzTkovZWlZRnNJckdReVdBMGZDOGFzT1dodys1STV0N2YxcmsrNUg2RTZ1?=
 =?utf-8?B?QS94TGt3alVBRFRSamtleGVUaUlxSVc5bFNUY0NkeUphYW9aYkdDM0xINHdl?=
 =?utf-8?B?NTdIOWJxYjJNM1ZCYlFaTVZWWERoTW91d0hRQk5jWElReGcyN3FmSzArNHc1?=
 =?utf-8?B?djVZR1ZKQVdKVUNkUjFlTEFVN1lTeENHYjNuL2tGMEpPYkUxSGdKbCtlZXhV?=
 =?utf-8?B?UVJoSXJBOWhYbEVpY2xVSmhmdmNtYVlSeENPU0UvQlZmb2JTOThqeFo4Zjh2?=
 =?utf-8?B?VnQxd0hGMFZzS1BaVGVtSVBLcDBoVWl6dU15elZwcTEyektQK0M3bkJnQ3c0?=
 =?utf-8?B?b3dvUUUwaWFxOWt3aEIxekJrSUMvS2w0RWpReWxFcCtocWlVbHlVcHZXb0Zu?=
 =?utf-8?B?SDlvSEx6Q2dsdkVBT1BBeUMweE1BSWtqbG1kd1NKbEtYVFZmOE9EdTNhYngv?=
 =?utf-8?B?ZVdhUERIa08vd3dOb3ZYSStibjh4dEVMSWZ1elB4dmIwcFNwdmxrUWZ3MzB3?=
 =?utf-8?B?clo3RjBnbjhoMVhWMnQwNVFzL2pTbTFzNzhXMGR5Yi9ObTIvTVFTZ21NdlVH?=
 =?utf-8?B?MURmQTlBQ2FuYnc2Unp6dUNDSUdwTHRCeW9kTDhoN0k1MTQreDRMaXRFSlJQ?=
 =?utf-8?B?cWVuNXFXWTVpVlBiUXlaanprbWlUdXRlc2RNczBlQk1FSVFORGtDVGtrWDNa?=
 =?utf-8?B?YjhNV3pYdE1HdXdtTllKcUFwOWlrOWtyeUhRRmNpc3lrRUNVNXdaYnJOL0E2?=
 =?utf-8?B?UUxGS1NoOEV2alJwMVI3a3hxVm9xYXBObk5lZXkvN2IxYi9LdFBKQWpoZUIr?=
 =?utf-8?B?NS9ld1RNZ3JUUDBjMS9jWTE0M1JVbWNTV3JveTc4N2wrMm1rdjlNaFhKeHZk?=
 =?utf-8?B?SEVLSzZZVUFKeUJHenZlRUxMNEVWczRkTXhWUmV3djFXN2JuTnNjOVo5b1Va?=
 =?utf-8?B?OWNYeklqQlBJOG1TV3UwN29wVVJPVVFwMW42cjRLVEZFYlNXek9HektDUzli?=
 =?utf-8?B?blAxOHZsM21zZ1NxSTdQcXNocEZabzhJSUpHcEJEbnBNM2Z3M3lYY04wTjZO?=
 =?utf-8?B?ZmFkVGtwbk83YUVGWEpOeTZMcVk2WFZESXpvd3N2SXV3Y1VmcmhJR2NzOTdm?=
 =?utf-8?B?M3RNVEJHN2RyaDdIUFhrT0RDRFg3SVU1ZUZzTHc0VXc3ZHZublNwR2FPNEsz?=
 =?utf-8?B?dWRRUi96dGtiRlE2bFpvbEJiczRSK2ZzTjhHOE1YS2ZHVS8yeVBjaVhOS1I2?=
 =?utf-8?B?SkZhTWlkVDRaS0ZWaGQ3ZmpOMGxxTFZsT2EvNkdTUVRMUWdJek9reEhjZmZn?=
 =?utf-8?B?M01iR0tsSzVvV0VXamtLaHpDQWV3Z2thcFJnNnZDamhVSWNmNHUyOUFFOUwv?=
 =?utf-8?B?NldZWWdOY2ptMFM1THVrcnR4YVpHQzQzT2x4bE1PSCtJNjByd21hbGE2VEJo?=
 =?utf-8?B?a1dwZ0syRFJBZi9UK1NWeG4rQWl3Skg4bWJtMXplSHRoajV4NVZyNHRuTGpN?=
 =?utf-8?Q?qYbb9rB8U1BPxjsLC9Y5Rf4Ri?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 58468747-2f76-4caa-0780-08dccce06b48
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 12:52:22.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmSdKxSvND8DQDiSWr6MrI9TfWq67DckXm0dP50eOq/rKjmqBCGz+dtzPI5lAr/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6397

Hi!

2024-09-04 at 13:29, Thomas Richard wrote:
> On 9/4/24 11:32, Peter Rosin wrote:
>> Hi!
>>
>> 2024-09-04 at 11:18, Thomas Richard wrote:
>>> On 9/3/24 15:22, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> Sorry for being unresponsive. And for first writing this in the older v4
>>>> thread instead of here.
>>>>
>>>> 2024-06-13 at 15:07, Thomas Richard wrote:
>>>>> The mux_chip_resume() function restores a mux_chip using the cached state
>>>>> of each mux.
>>>>>
>>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>>> ---
>>>>>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>>>>>  include/linux/mux/driver.h |  1 +
>>>>>  2 files changed, 30 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>>>> index 78c0022697ec..0858cacae845 100644
>>>>> --- a/drivers/mux/core.c
>>>>> +++ b/drivers/mux/core.c
>>>>> @@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(mux_chip_free);
>>>>>  
>>>>> +/**
>>>>> + * mux_chip_resume() - restores the mux-chip state
>>>>> + * @mux_chip: The mux-chip to resume.
>>>>> + *
>>>>> + * Restores the mux-chip state.
>>>>> + *
>>>>> + * Return: Zero on success or a negative errno on error.
>>>>> + */
>>>>> +int mux_chip_resume(struct mux_chip *mux_chip)
>>>>> +{
>>>>> +	int ret, i;
>>>>> +
>>>>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>>>>> +		struct mux_control *mux = &mux_chip->mux[i];
>>>>> +
>>>>> +		if (mux->cached_state == MUX_CACHE_UNKNOWN)
>>>>> +			continue;
>>>>> +
>>>>> +		ret = mux_control_set(mux, mux->cached_state);
>>>>
>>>> mux_control_set() is an internal helper. It is called from
>>>> __mux_control_select() and mux_control_deselect() (and on init...)
>>>>
>>>> In all those cases, there is no race to reach the mux_control_set()
>>>> function, by means of the mux->lock semaphore (or the mux not being
>>>> "published" yet).
>>>>
>>>> I fail to see how resume is safe when mux->lock is ignored?
>>>
>>> I think I should use mux_control_select() to use the lock.
>>> If I ignore the lock, I could have a cache coherence issue.
>>>
>>> I'll send a new version which use mux_control_select().
>>> But if I use mux_control_select(), I have to clean the cache before to
>>> call it, if not nothing happen [1].
>>>
>>> [1]
>>> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L319
>>
>> No, calling mux_control_select() in resume context is not an
>> option IIUC. That would dead-lock if there is a long-time client
>> who has locked the mux in some desired state.
> 
> Yes, I didn't thought about it.
> 
>>
>> I see no trivial solution to integrate suspend/resume, and do
>> not have enough time to think about what a working solutions
>> would look like. Sorry.
>>
> 
> We maybe have a solution.
> Please let me know if it's relevant or not for you:
> 
> - Add a get operation in struct mux_control_ops.
> 
> - Implement mux_chip_suspend() which reads the state of each mux using
> the get operation, and store it in a hardware_state variable (stored in
> the mux_control struct).
> 
> - The mux_chip_resume uses the hardware_state value to restore all muxes
> using mux_control_set().
> So if a mux is locked with a long delay, there is no dead-lock.
> 
> - If the get operation is not defined, mux_chip_suspend() and
> mux_chip_resume() do nothing (maybe a warning or info message could be
> useful).

What if a mux control is used to mux e.g. an SPI bus, and on that bus
sits some device that needs to be accessed during suspend/resume. What
part of the system ensures that the mux is supended late and resumed
early? Other things probably also want to be suspended late and resumed
early. But everything can be latest/earliest, there has to be some kind
of order, and I'm not sure that ordering is guaranteed to "fit".

Cheers,
Peter

