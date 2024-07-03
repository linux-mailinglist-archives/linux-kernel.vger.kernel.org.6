Return-Path: <linux-kernel+bounces-239013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662D89254E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31F9288CB7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56C137C25;
	Wed,  3 Jul 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="gQZE7qn1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D02C879;
	Wed,  3 Jul 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992687; cv=fail; b=sG0SKESsP/JbW4bivKKyEoiiYZ+8WKvJ5fH6O5TIgJSx4Xt2d8ZP1Juc9gspJMrmj4RbLDeZhH3b+Q+L/dhNE+9zggwmDKcdfQl2L7ZLTPlwgHoNPFr9ZBA4R30/wvcJikiZD86KhU7DmKTKHB1fsuu2GDNNRyCbLztgLkM3EIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992687; c=relaxed/simple;
	bh=Tb8hA/nUmQE6+vFaLXy6JmVC9M2v9Om3BJUdBAJThvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZuORDoet+F4EOGjzEmemVE+qVVFXD5RBsp6kflGmHcnrXsoezS638LLP20isvagSU7DpaI51WGk9DIixOYlwktZyGhkxuJcPzdE/wuZZtShCseFj+b/ldmbbssSIAzEO05y1o7xaJ3mgRX6E1beMme8L4yLrj2Clcabr0xGJCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=gQZE7qn1; arc=fail smtp.client-ip=40.107.22.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy1zWYh0mSH2FS7j3Z8ANaJhfn/HNMY2q/lUGbBWR4DLkK+dlqGEz8g9g1f5mDCnGHGVSLvpGvv32b1Qxi6sOHtBg3uLk+NBqRwvBQLz0t3AdtUvxUWAknrFXm1q4SZecqID6t1O49qaR9laiQukPGOZtNvtcLu2eTOBVmDCI0PWHzNu4mJWKLqp+99/f7geLub4UO+m+D+G4sxpGhmQTy25QXGwgHaZjQQTjodLtMsLkIguuLLlQLmqK66Qs1TkyZeMkXhXE6jXtzGfzXWoPA96j/Nqr2x1J3kUWjughwsogtfDYcwwpuHk9tRLfwxziMiahzFD6OvQ/YhkpJvEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NaDQlynlppexV0zioNYycL0fFvyZCGtQQ46hYraGC4=;
 b=MuJhiVTChFi2rrUvY7etgH3/+EWz6un4kxVpUZaewsE/gHs/91ZNJyZAjTlIZHCJP847KU0lVpeUjI3PzF762Bw07yY/CiAQUwSB9t0QHa0Wc77rsF/8VNanG8/QmCWomy5kjGRAcmH0/W8p4ddidoHQn3/TzOhzEwYxFZE3TW6PtTvmXqtmlwHGkopZiJvl6jj+HXyh12z4EyY3T+FR1jj4SdW/MWtOrWP7YcQ1DTwJ7LmfFeudcsvxC2SdC0Z7u80iFh3pYV7tbRyUljaVQ3Kb+fYD/8rqYGInGekwYR3JVohKV0ENaUT+o1toPQS4hqsUtCz/mrjtK5iYsyAFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NaDQlynlppexV0zioNYycL0fFvyZCGtQQ46hYraGC4=;
 b=gQZE7qn14b9u3ypjIaESGHPaHDmUqWKcb2cHEuT++1WNrz1RlYcnrOeZPiYEwgZFKPSaf51MSFfm9bcofOHae2Anuw23FDwvANa63g4WvM1LaxwZmqqwzrf3YXGxJRu71cDSgic9pbMXV8ZYOoD4rRqaZ57jA0gbuixH/imGAj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS4PR10MB5919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 07:44:43 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 07:44:42 +0000
Message-ID: <e8f8dd22-4f4e-414d-bb81-27f96c4c2139@kontron.de>
Date: Wed, 3 Jul 2024 09:44:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] dt-bindings: regulator: pca9450: Make interrupt
 optional
To: Krzysztof Kozlowski <krzk@kernel.org>, Frieder Schrempf
 <frieder@fris.de>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>
Cc: Joy Zou <joy.zou@nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240702103155.321855-1-frieder@fris.de>
 <20240702103155.321855-5-frieder@fris.de>
 <897f588f-019e-4519-9106-bc18ef22f5cb@kernel.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <897f588f-019e-4519-9106-bc18ef22f5cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS4PR10MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e886998-a2e4-4057-7336-08dc9b340079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0lHY05Fd3pIWGFBdDJManhSOENyeENIUjVPbWtkbDBtcldCSEJNTUVhbm9x?=
 =?utf-8?B?b1RmZXZGWnloYWpiR2lmWC8vbjFrWTNST1o4UVl6MWRZT1lQcXJ3TWVQbFp0?=
 =?utf-8?B?U0JpMWJYK3VEV0VMV1pwU3Q5Y2NXTTZQcXpiUEF3elpHNVRtZDA2dlRrazZ6?=
 =?utf-8?B?NFA0dys3TXc4SWNTc2lEdGNVY0xLQ1ZqMHdIRUFWSXdHRktURlZMV3VHQmlh?=
 =?utf-8?B?MWpnUlZGWUhxVWVHTng4T3d5TFZsOE5meW1ROWZ5YXVGaElIc29YNWV1RkFL?=
 =?utf-8?B?WHhKZ3NwV0twSWw2MTZ3TlZMOHBMeU9oa2pwQm5iRjdTc2liY3FnaVdFeFJx?=
 =?utf-8?B?akJVUVk4b01Vc3c4MjlCaWRSbUU5SmM4TkUrSHlpTkpFZysrOGxxSGVDVGFl?=
 =?utf-8?B?OTJDQUhacjlmemYrRW1KMUVXS1djdVcxRE9SWXZrU3BDdVYvd29EaHFDZ1Q1?=
 =?utf-8?B?SDZGNUdTTHNrWit1ZS8rNklWMm41NlVxd3NRWXlyM0RxTjZVT2xUR3Jkcmgy?=
 =?utf-8?B?ZHQzc1oySmZjWGRzY2x5ZitTTWc1b0xuQVg0dmtBRUswWkxrUTFwREhST3pv?=
 =?utf-8?B?Z244TEt2a3J4RDVJeUVuOWxlaGRYMjVPejcyQkdUYW9UQVY3d3BreWFldVhN?=
 =?utf-8?B?VC9xay9QcXgxMlM0andRY01nM1dhejMrYTBFcDlFNzhNSFRHWEdQNHhMTFhH?=
 =?utf-8?B?RzAxUVgyOS95empnM0tQdGhCVU55ZTROek9Va3JaZ3ZZbSsrdWRtc0hJUkll?=
 =?utf-8?B?bWFJUnFGZ1JVRW42ZTQyVzg2WUd0b1RYSndZdE9HMVZMTC9aN2U3eDQxdTdt?=
 =?utf-8?B?c1laQkZHQVBUZldvT0JySHhva0I0RHUrd1JzOUV6SURacGFDSUJna1RsY0pC?=
 =?utf-8?B?dFpiK3R6blhFWW9hVWtNcFlDaVE3VS9qeXBSQTNKZGhSSHRYQXhMUnNKeWY4?=
 =?utf-8?B?VktYb3BNQWlxQWRLRGVtanM5cG1PRkZIeDdXMmpZU1NsUDUxaFFsa1B2UkJF?=
 =?utf-8?B?YjQzZE1tVmhiRjkzNTZzWm96d1JadnZYSHAvTmNwMGtQOEtXM2luV1V5V2lZ?=
 =?utf-8?B?SWx2TzBGMlNRQzJxSzVqb2dJbFkzelI3QU9aaS93eFhldVpzRExIQlQ1aVJC?=
 =?utf-8?B?SmpMaUd2RmplZEMveVRhVHlmUkJFcndTemVOUFJnanBmZjJXcGk1RlpEeXd5?=
 =?utf-8?B?MGZFV2tpZU9NZCt0NnhSRTYwdkFSTVhLMEdUVXRvYUl2azJsQjZwMUlzRXJo?=
 =?utf-8?B?K3dUOTAzWnJuWGtqc0NiL1BHb1ppQThnQnc5cGZWMUpGQUoyV3R0bnduQU5U?=
 =?utf-8?B?cS92RDhEMlpUTU5TMGExcXE1YjRjMWFHZWhCcHQwVkpUMHo2OEMvMVJLdk9O?=
 =?utf-8?B?b2VKclJ6RTJ4M0ExQXZ4R2RHdXhRTWZjay9aT05GY1RINHJnTFhVZmNGVEdt?=
 =?utf-8?B?V25kRG5zRk04Y2hweDl1UzB3VFN0U0IvdG5xQ2xKS2I3enprRWd6QzZtMGpU?=
 =?utf-8?B?UGhULzFVQU9FL3ZucFBiYzVuYXlUdTg0VXhBQjFsbmhLYVpWNHh6KzFTTTFk?=
 =?utf-8?B?RGZ5dUJlVWpaYUg1a2k3RVhTaVh3eFZKUGtjcU90ckZJcG1nQmtDK3JEYzNl?=
 =?utf-8?B?VUtLTDV5Z1hIbFhjSXFENXA4bmZPVXFuZm1lSFFTVUJIVXZIZ3V6T2lCejVy?=
 =?utf-8?B?UXc1YmpCVU9ZNXkyR012RzRGSm5FUmFLVjQyU0VuV2ZQZjZzWk1odHUveUw1?=
 =?utf-8?B?Z2lDR1YrdGVZRTdkM1B1RlJUYlRReDhtTDJCVmt4VjY3QkRGRk1wdkxERUwy?=
 =?utf-8?B?V2t4RnRzVnMvZENHOVYyTzBMZVRRcGZBcUxnVytrT0ZMSUlUKzZSZmdSbmhL?=
 =?utf-8?Q?UC/dSgfEvx6yb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW1kcW1oVVMvRWFpMHg2RDNFWDVqeEg5dGgzR3NydWhHVzE5UklEZmd3MFZI?=
 =?utf-8?B?ckpyS0hsYW5udVY4U04xVGhQY3NuMS91RnN0N3dNVS91SWZjRVdYTUVxTExx?=
 =?utf-8?B?enhnWHA2a3pmL05Pam5wd2FNdUROYis1Y3E5S0xCbUZ1Q3NRUGs3aWNXc0ow?=
 =?utf-8?B?MzJrSU9oUGVjY0czS0VyUEU5UGN1Q056ZG1LaW8zdkxKNTdFcW1CUDkyNFR4?=
 =?utf-8?B?Z0hpZ2t3LzlyUWdvbnBkNVNyUHBla3ljclhhMXZyalhWVW16cnlRVld5WHdU?=
 =?utf-8?B?SWhnWSt2R3A1dTZHeldkUTNMbWxHcGR6UjRvUi9OWWgydDlvRmpXZ2pDMWZO?=
 =?utf-8?B?WHZPeFNpc1p1enBpdWViNHFCZXoyTnhXeW5TWmxTR05MOHBvcnhwcEUvc1lq?=
 =?utf-8?B?WTlqa2NJbEVMaFJPWGtGTDh4M0F4ZGRVMFpzeE14SURUejVSb3h6NldGWmdX?=
 =?utf-8?B?NkVQUHhoNXVlSHNCS1hJaGkyQVpSTXlpZ2tHdDRXcnIwZFlkZ0dtUjRWMzY2?=
 =?utf-8?B?TDl6eWwwR3JIYlJIMlAvTExOb2g4UXVCVGJWU0ZDNS8vS08zMFB1ZGQ0NU4x?=
 =?utf-8?B?andRY2xjNUYycmwrZHpUck5wd240bnZrYW1BK3NIUk9VdEQxTXUwNTVXUkFi?=
 =?utf-8?B?SElhdCt2TTFqVGUzSEhGeGV6NFl2YVdRNGx1STN0Z1hTR3VsZjA5L2xiVjlw?=
 =?utf-8?B?ZVQ0bk56RWFMWjFpeXYzdHVOd2ZiMFN0SU9nNjBNVXZwVGhkN215bTF4YjNR?=
 =?utf-8?B?RjlUTVRBV3RCc2t3UXhkOWExdWFocVk3NW9lMkQ5U01qT2pod05BaU9CK2FG?=
 =?utf-8?B?NWRWQUtDZExNbEQrRmpIRFdUMzlEQ1BXcHlUOWtweitDVFJsODR6VDlBbHlv?=
 =?utf-8?B?MGdGMzNhdmR1QnMrTS96RGI2cUNBUFlLLzg2d2loQWZjM1JSR0Y4b3hvblhM?=
 =?utf-8?B?NklJS2ZGcHRvZ3JibDc3YVhwektOWG9xZnpkMFA2OG5PeUlsek4wMWR6Rk5S?=
 =?utf-8?B?c29WM09SYTNvL2xaNWhQU09COVBDb3ArZHhPSytMR0VZVnphVkEydEpqZXJr?=
 =?utf-8?B?WS9pSTkwMllCTWdkSWVyeDNTekpybUN4WjZqWEcySm51Zjh1S0QyMVZkd25h?=
 =?utf-8?B?c2F4am9hZHdMdkVDNEtiNWRCOXhYS2EreVRlZVY1V3dOVEg2TUdrVm4zK3RP?=
 =?utf-8?B?UnF1bzU4ell0OTllZGMzajNlcm90UGEyV21OL0hZTVU1em0vakE4ZW91Sno0?=
 =?utf-8?B?T0w5Mkx1ZDIrV2JOaVllNGkrMTVzU0JXL2JDb0p2MzRhZHZSSVhRVDB6WHN3?=
 =?utf-8?B?Zlhyckw3WEpOVDYvN2tocHNiTzlJdTJmNG0xTk4xcnpzZS9vM01kaXZJaWt0?=
 =?utf-8?B?emxTbyt3YUsrWFRZTDNjV2Yzcjk3Z2N0MzIxbjdQYk9SeEF3WER3MEFVQ2oz?=
 =?utf-8?B?L0JNWTh5TEZLTXU5enBrUHRzeUR6UzVOaFIrVmFoNXRTbzUraUdmSVF6RzF1?=
 =?utf-8?B?UnI2Ly8vTXFYMFdCVWRoRlNOd21GVVgrQkZ0QXRCZzNHV1VUekRrK3RUblNn?=
 =?utf-8?B?NTdIbk9oVG1iT2hHSlR3OEVMOW8wdG5OODB4SlFYWjhsbDhCdXgybEtFeWNx?=
 =?utf-8?B?N2hPemFkZHhMMFpzZkM2OUM4WDJqd1pvRTB4S1ZTNnBKQnRvZm1WeGI2YjhT?=
 =?utf-8?B?MGtocC9sYy9Tb2NJdmwwVzlOSVFzYjFSaWdyekV3aHU1TEhPT0dpRjk1anNZ?=
 =?utf-8?B?cjdlL2dtVUlXVUxIWUlyY2dHZEROcTVQNldzUjR4SUZnY3Zhc3g3OE9qMDJh?=
 =?utf-8?B?VjRQbWNBTVQzVXg4bEtHeEhtL2NON2thcGZMMUY5WG5DeDlRMW9OcFFNZjJE?=
 =?utf-8?B?WjF3MXdneGdsZUVKOWtFckxSaExHRDdKQzlOUkI0MS96RDlYK29PQlpDalNI?=
 =?utf-8?B?VTVlZlJXb3UwSkVkK2pMVWMwWVNKRFJsZG5RRXJuUW5JZ1JabHUwMUszVml4?=
 =?utf-8?B?dFRkbjRVTTVqZGFaUTAxbzRlL1p6TFd5MzJ4eTVkSEVaeTg3RHNqYlU0MVAx?=
 =?utf-8?B?UC9RbmRCdVMvdG55emsvMTZFaHFzbldCd2hZYjg2cnB3bG9GcEpLY1VnekVB?=
 =?utf-8?B?NHBEY3Vya0RaZWxHVkowemtQaU56eit2ZHVDWWtQam5JMVNNSklENHdZdm5E?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e886998-a2e4-4057-7336-08dc9b340079
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 07:44:42.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ek0Q1Ju1UyZdSa+41duXJSKQon255ke2VkPWJ4RM3pHcVHlDLbPkTW4cqwcksUvhhUdCGXLsLLXjRPkAYYRc/zcKyWBWfv1/IQ2W23+gqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5919

On 02.07.24 4:24 PM, Krzysztof Kozlowski wrote:
> On 02/07/2024 12:31, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The interrupt line is currently only used for printing warnings and
>> the PMIC works just fine without it.
>>
>> Allow boards to not use the interrupt line and therefore make it
>> optional.
>>
> 
> Do you want to say that interrupt is optional in the hardware and not
> connected in your board? Sorry, but that's quite long statement without
> actually stating the main point why this should be optional in the binding.

Yes, ok. I will change the commit message to be more precise.

