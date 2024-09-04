Return-Path: <linux-kernel+bounces-315185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F289696BEF9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC46528A518
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71B1CF7C4;
	Wed,  4 Sep 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="gVf1C2+Z"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2108.outbound.protection.outlook.com [40.107.22.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB041DA10D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457477; cv=fail; b=XQVog3qeSmlCjpI7V5rC8EP/jPL3oirJ7/n/bBcP7mXmmb+eU7uJs6oTCFuLARNvw1bXwavtWESKgOe6KOSPQflB/mKeX0cCM7/laJht64d0J1aW4J0H7eEUDIrlzKtAgR+Ya3jPuOCi8BSa7ox2qrnd+KwbpfeDvx+kKXTknbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457477; c=relaxed/simple;
	bh=6pGK0Hiy0HnXDsNHqR421LGmliDUbwgt8ztQQ79PGN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S2joh1uwD5yeOtz2aESKLG9l5qLO3OC3M9tK2WFYZOmTBzN5knoCMsi2ZyVw135+XM+8LjLBqDCTZphH+5saqTFhzdsBgY/a6K9aTqmzt/KZMNQqJvdyLoBhbDPzN6nn1tE32CKTKvKRH60Kb/0EfMJfKfiOqjgbU4lXVsHL4ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=gVf1C2+Z; arc=fail smtp.client-ip=40.107.22.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha4NekDtFk33TgMQCbsFxehz2oa1aJCaodiYrmXrP08gdCkvV+6PusMJEGaHIwLB+Nq6Kkd+b63e3KUvyR/kQKUCqpWq/acX2sZF3WrZJzkweF/MkN5Dst9RXo1s096MA3mUtFTVOr17k1bzac7EGa15323QL6P9qtRQ0HP4l+uWxb7QyTvEXHlnc36dIwOvnR3ikisdKRpOoVd2AdAsrl5uxZPM1zp5PxFcw+teY+HOPIjX6Y4ynM6q0Bgs5LXZr0y0A9+WZm3u5Q4+3D9UCukAD/ysxuKMeZgUODcAZirprc8v1DuqooZZj4iKU+FXeuRPDJg5AK5+5SzoU6ZT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2bQluJae/KHVyTDmbHeQ+9Nj1bPpvQp233s1qogkQ4=;
 b=D1ndq2KApukc8XhP4o1xY8wQnw7OU/m9kvoKpKRTCx6DNxZJfKy7Akscrv9uGZ3W21z10886kbNE+B5i6uQbjJuTvaAwopO+8aayxqoFbdQaAzL1i4OSYWHmGqaOYtK7AP2zF1LQEk4QVulOhsiJDIALyV2Hm5AIxJTbjRO2sNxC78DnTzggidWnVGIyIzo4OZlZ81D2t0rYmAqHgBXCHiOuriUyQRgXNoeUiO3w7lBrKTOiC9ApOS/bhuOANs+h5lVafjUszLkOfdZzg85rbASi5/uBCL0MdqcdDyMcl08jcsyAsjyF8tvH+NiYUE3WgiLyWBRGlr8oDlUfjvlolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2bQluJae/KHVyTDmbHeQ+9Nj1bPpvQp233s1qogkQ4=;
 b=gVf1C2+Z34kZCbQirmD2CCTpd1usTIuqYEBfmaUod7QAkm8UXVvZu6gWJMNM7WFnVLrgXZCNNs/m2EKVa7acw6ZOqQBZSO+r10SP6A5yIxn1A1ZOVeHgd0vq7kJ3sVCUsB11LSXQhedNu6B70zV+UIDcQ2vC+REYPGBb+HbmJ2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB3134.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:44:29 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:44:29 +0000
Message-ID: <727803d7-2b0a-449b-97bc-b18fe2378a38@kontron.de>
Date: Wed, 4 Sep 2024 15:44:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 5/5] phy: freescale: fsl-samsung-hdmi: Remove
 unnecessary LUT entries
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904023310.163371-1-aford173@gmail.com>
 <20240904023310.163371-6-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240904023310.163371-6-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI1PR10MB3134:EE_
X-MS-Office365-Filtering-Correlation-Id: 39324ef7-c1c2-481d-cdc8-08dccce7b312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3lLLzZrZFVvS3VIYnE0Y1dmMXR4c00zTXl1QVJSbTVuNm9vM3I3UjR5cUQ1?=
 =?utf-8?B?MzA3L0oxeEp0SGdmSnVqaC8xRCtPZVBnTFdNK00xNjl4ajRaUkkwRTYwVlVa?=
 =?utf-8?B?dXUvWVhBR2JNeDdUM3lKSnorREJSVSsySHlBek9Ub3RtVkJkYXJUd0dYVmpX?=
 =?utf-8?B?aGoyWitNUDYrL1ZVUnU2dU9ZdFdkT2t6aTZjamU1NytJdmpDVHFGZ2VwOXhF?=
 =?utf-8?B?eXJZS0dBWnlIcGpVL0RHK1dEd1dLNEV1TXBpN1JjK3VMTEdJb0hmM3RRaU1v?=
 =?utf-8?B?N09tWEFpajB1ZGxWeUk0VE1hWThYWjZrUWQ1KzdpZDd2OGQ0NERqYUhUQVFW?=
 =?utf-8?B?SG56UW5FZXFlWXBpSGdFdCtaNGRzNUdjVklLb1dPcnZNSnM5a3FMZWRvQ1Vy?=
 =?utf-8?B?VVRRdUdpMTFmNmE0YmRyM1B3VzFjNFlVWkhlNGlqZXdsQXpkdGtsSzhDNjFy?=
 =?utf-8?B?MWxvM1l6Q0huM0J6bVlRNnBqcnV2SGM1ZWNkQUF2SndSQXNNdmFUbXRGeFN6?=
 =?utf-8?B?VmozYXJLS2VwaTE3TzltY1crVERJTjlqalFOeVlhVU4zNEtjOGMzMnFKRHpa?=
 =?utf-8?B?MHRGT3IvOW4rWnNFK2dLSWdIcTVuMDFzTldPcEh0SFVZMnNQb3BoNThWazl3?=
 =?utf-8?B?bU15dlpVazdSdGdkdmtTVzcrajhYNElta1RVeE1NYytsNWJkQUFDdFB6YTBE?=
 =?utf-8?B?cUluWjlUT0szczgxTkdZalhNY0xTTlBYdnM3VWFXb3NSUzRrQlFwSWNsbjJY?=
 =?utf-8?B?OUtIU1hzRThFc0pSOW0wRWtzRHVZUlVpQWpaMEErdlRmUHpiNWVpUmxKSWNI?=
 =?utf-8?B?NThHLzZtc3dmM1pjRHZkUXcwQkZrdUN4d1NLSVBBTWV0d1NudGZiNUNxYkM4?=
 =?utf-8?B?emtPc01jcUZFN1dXajBEQ3NHT21NdWJzYWxyQ2UxWVRaU216bFFrME8yd0RO?=
 =?utf-8?B?RnNLU0E4dFpIU2ltU3RheXExTEsvTEd3RjQyVU9aOWRSZWlNcTFpOWluYkcv?=
 =?utf-8?B?Nm9WRnljNXZ3TEZad212RlFDZkZrb2orUW10S1lZR1VmZkxFWlVYSm1VTDRj?=
 =?utf-8?B?d1Z0TWZHQ0pzOCtDTGswa0daNlJ5QlRRK3dZWWVXeW5zdkJRQUZsR21tMUtU?=
 =?utf-8?B?UU5QdlFrODVRdUpwajhWNTZhcEx0SytkY0hncXo5ODVPUWNWSDZ2VWMrdmF3?=
 =?utf-8?B?eU4yKzVaQTI5TVlVNlVlejFWOWdPVWFmNm9PelQ5aG5DYVZXcXNOU013T1h4?=
 =?utf-8?B?azlTcjRsQWNxcEdGbU51MEV0bjJucDZUbHU1ZVRpa0ZJV09mM1J3dVRMRHFh?=
 =?utf-8?B?NHJMcEcwZnhuNCtmY3pVMXJVMDJFOC9QS1JLVXZvSnY2dFdDY2lIdUcwYWQx?=
 =?utf-8?B?bjQ2VjNjQ0dZSWtCMHFEWEFhQzkyTk9vUC95eFJ1QXg3TTkxY3pxU0Z3b2x3?=
 =?utf-8?B?SDMzR2ExZ0RVYS91ZFlQRnc3bkppc29KWlUyZS9iQ25vV2xIQjhOeUc1cGVu?=
 =?utf-8?B?d214YWtSeEJoQ1F0SDNmRjRWcUs2MXFEdlpWUGZ2bDU4S0lYbkxoWDdHUTZI?=
 =?utf-8?B?VXI1YjliUlo5UUNpRzI3QVVaVGkzaEpSbi9DSGliSVMwclRrbkpDUW5qRXJQ?=
 =?utf-8?B?c0IvaUsxK0VzMWdQSm1sbDBHdG5ITW54YjFiNWdXTVVDMThScEs5NDY2L1Yz?=
 =?utf-8?B?ald5aG1ySjZqODdWc1d1WVJzSDZkYkZnOHpNNDU5RnA2dXNodFV0NkU1ZENL?=
 =?utf-8?B?RkZmQndpSjVka2FuWGo2VDhVRHBVM0RFUHFjK2JPR3VxT3ZwSnY2UWVQcDRC?=
 =?utf-8?B?d010NmZySFFORWZ6eG4xQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXZJbnEwYk9iVHpaOHc1SnhuSVJnYjBYcWdpSlBmVmIzTUVTSWl4RFBXTkhE?=
 =?utf-8?B?amRqVzRTeDBNaXhvNFlQNitnWFNuZUhVMFR4cjRLRjJIcHpEdkJRTzB0Z0tV?=
 =?utf-8?B?c2hCcGNDTFJLOUJnM1c1NmdwcGUybnJSZzIreXNSNUpHMDg0aGhQWlBMVkxT?=
 =?utf-8?B?dWFycjFEZTZMSzE0WTVpR2JSSmhkY2dNNDZZemxZY2ZPU1lkOG8zM3MxSmxy?=
 =?utf-8?B?K3ZER01yVHE1OTVlVFV2RWMyQUVsUmJYN0g2NVRCb1VyTW1ydjBCQkc2b3FV?=
 =?utf-8?B?ZE9WSUZFOW1oa0tsekFmdUJMbnB4QkZSSlpMaFJWUGNhWlJTQUN5Vnk5R2sr?=
 =?utf-8?B?SWNEeXZvbkVGVi9LREFUQXpGM0g4ZmcyU0FiSmtSNG1ndVNVaWpNSTBkdW1V?=
 =?utf-8?B?WmFocmdnOU9wdjlKTjBrNnZxdDZIZUEzNFpRMFEzWnBPamhnZEh4ZmdON01u?=
 =?utf-8?B?WWtKQWF2T3ZvNDhOTlpyZXhyNnFWSHcwNnFRWWdpVCt3TmtzYzRPT2tLd2VB?=
 =?utf-8?B?NXNxWnoxTzUrTGo1d3dtdXF2REJKcGV0ajVTa0NMSjE2SnhoTGV3YjVIV1Rv?=
 =?utf-8?B?SlkvSEdjVXpidElRSDhjWTBoNUhUREpYMnlERzFCeFV5VnZUdVJwVzlyYUln?=
 =?utf-8?B?dDFNMFRQQ2pvcVFQdEpsbFdWd01oaVZ3dStWczd4c1lkVFNLVnhheHROOW5O?=
 =?utf-8?B?RUlEOE5kdXgwVEQrUEVmSzFkS211aDgyWjYzYzhFTjBVMkFPSFBmU1FFQ1Fi?=
 =?utf-8?B?cFFZWjRIOEJKeWI4QWpmRDNhc1FPRWsreURaU28wNnBlUTk2aE93VlNFSzZZ?=
 =?utf-8?B?enV0SnV2UnJLNkpINUlsNVQ2TktZMExCUUFlUk1lVnI2Z3VhczNZeit0UExy?=
 =?utf-8?B?ZVdQQTR5SzE4K2dLLzNmTE5OMHlrU2MrNzZMV0tJekc4Ukp2cFNiQWdXTXhM?=
 =?utf-8?B?dEowWjAvcjkwTmxIa2NLb1orelJkbUliVXdNMGNuUzlFUWdBMHN2MmduakV5?=
 =?utf-8?B?QlNmN0RKMkdMVGdpazdmT2dVdDF5TlAzWXBPM0s0dGErcEt0aEpkeEdLY3F2?=
 =?utf-8?B?bjJqbWhhM2g1TmEvNGI3Nms3VjBUbmdkOGRZTDVqNEJidk9PeXF5enBXenBF?=
 =?utf-8?B?MWNjalRiYmltVWVsaGMwQ0RnS2ZxcFViaVFGb3NjSklsRTVjRGE0cjd1MFJq?=
 =?utf-8?B?NlV0M1NWSkI0N3ByeDhZQ0J6dWIya3ZBYUJMWENodERqN2RhVXUzSEFqc3lo?=
 =?utf-8?B?UTRhQmxxdXNEU2JSQ0t1bk9RSHlxOFVuT1hlZzZCc0thZGxpa1laMDlseXFj?=
 =?utf-8?B?Vnp2UFVFZDloZ3FSc3NYL3VLb1FFd25Wc2pEaVlNREFWaUd6TjhvQUs4dWZt?=
 =?utf-8?B?MmFkcGxKaXBsK2lGUGlMNG5zVUM0OWZUa0VGaHk4aUlINWE3NTFUaWMyNFV3?=
 =?utf-8?B?Tno1UTFRQ3pCRjN2V0VTZmxhSGR0MFVWRWxDQ3dnOGFEOFFFRjV0ZnlDQkxD?=
 =?utf-8?B?S3pOTEEwaTRQcXB3SmNMS1BTdUR2MlZLd1VZZjRJbVoyTzZWTlJHLytCMFRU?=
 =?utf-8?B?cVA1c0NJUk5kQ0tsVVJQY0pCSndScnVCYTZhcml6SU5CNE1ZaUZwZ2FvdTZu?=
 =?utf-8?B?c0MrdC8vY2Q5bHpPelFTVDRIMkN0Wkl5bkx6aFpFemdYajc2T0loZG4rYVNz?=
 =?utf-8?B?YmVxbm5XbEc2Q0YySHZGRUc4QWswVmtuSmhkMUNPTDZTbEl4ZFZsK2VsZXRo?=
 =?utf-8?B?VnRDNituQjJjUndxT01POExBTVlWVjlXdmtTZnM3Zy82bmI1bHpSZTI5djgv?=
 =?utf-8?B?TTJiNzlxcmkrVVhZdFUwVXlIWG1yU1ozbVBDSTlDVUp5QklGZFBGWmYzM2xC?=
 =?utf-8?B?ZDVXQ2ZJUExDMzJCVmxyVW1KcTJndWptY3BwODZIQ2duL3Q5d2lIRWVraThP?=
 =?utf-8?B?YjRBWHFrTU0xelM4L1pUeXdUbWxML3gzNS9uNEczTG9GNUprVHU5MEdKZTdT?=
 =?utf-8?B?T2hZZjNmWmRpakZ4QjJyMVpIL0hxMWFncFNlS3RGazlFRXpUK3R0S2dLWGJE?=
 =?utf-8?B?NHBra3UzVHJvRktGNWkwenFnd1N5Mm5VTXlHbmsxL01qWCtENmVUVUZkMThi?=
 =?utf-8?B?aklHclpJTklEUmsvR3VKTGNVd1QyRzRrazhnS3dLYXM5RzRaUmNMZ1BaSmtP?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39324ef7-c1c2-481d-cdc8-08dccce7b312
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:44:29.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RskRnSZ7D2SSD7e9I5fvGLX1rXEHM/RmrZqaiYlZfcjt6Fu5VVBbKVlQTO6WYQqbyiQch+kuYyDWuX8BjCm3VxbTduTc5lkazsk/CY/Wiyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3134

On 04.09.24 4:32 AM, Adam Ford wrote:
> The lookup table contains entries which use the integer divider
> instead of just the fractional divider.  Since the set and round

                                          ^ unneeded whitespace

> functions check both the integer divider values and the LUT values,
> it's no longer necessary to keep the integer divder values in the,

                                               ^ divider        ^ table?
> as they are able to by dynamically calcuated.

          ^ can be calculated dynamically.

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

With commit message fixed:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

