Return-Path: <linux-kernel+bounces-261102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B8993B2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDBAB24115
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B015AD90;
	Wed, 24 Jul 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bbzEEfik";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bbzEEfik"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83815884F;
	Wed, 24 Jul 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832022; cv=fail; b=I2LqZ5iaaPP+emJmvXYqyQkpd9mPeIjipxVArxf0wvwY5k0yQCdjJMNizYTEWLLRU5Ap42exDL9aXR8D00qJ/owzYndsLM1bttAiNfebJPzoesF3ZYVoKpNfuS16NJI+2cWRIdkc9XT1j/BR8FfrW2KRs2e/6dgC+lQsOeUs6sA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832022; c=relaxed/simple;
	bh=tyoetkT53L4TVwwm639U1i8F1oKNQ2qZDklm5R04NBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RSA/NXLlFrxM2JxalZVvGXQt9fgDWBWDbij0+i5Mn8SUfuCUUg//Lnz9080yu3Xq5+z6idXiMH0QyDTjE6I+is38GIKbFmXwvgc1ddZ/xU6c9QWjT/LSlNhlbNITZ57R7eqSkby5ZVOXyMQjbYkTSHxORNMIx018CDHHUdp09hM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bbzEEfik; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bbzEEfik; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Fr11p9ELVDF/Zuqe5uJquZMV06/9WjSekRGhlX6gW/eBOhcYR1D8Y/Yr86kpEZlGQcwk5w5ELbanfIqgswDEhArZgyBBOopcIhGGhZse4AWDnO03nwK2QZY5niE06vjOFIL+WBG+wE04eTyiyJjfyxhq1qIOmBo8IWJwmzqwKnEHQCAAq0sAV8+QlbYRT/RCOZa4sBhW1fkDK0OaM/XSpxjoFboOdgZOjJsJJSlVkKzWbnlMzzjiN22QtvqxVuEUybxd0pq7ihyfvesGbdVcQyfgt0YkhSuXq2+kAf4keHQ8uL1XXBOakWSuwBIykkD1Q7AcPPZPp6HI/NRbYKA2Fw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHKM8bzZXNQSEM1EnYV7Q4PsQQnzQawk4EO1dUZ8kAw=;
 b=aSb7F8AXx1u5y0Mi+B4+wfQ4/uKpJ5vQ0dTjfWZVevdx4KJB+xRVCQTfrch5dOo0O2EWQ7fsB7t6R6R8R96YH+maxneff04FCMzF8SpBguqCoI0pCikVTMdfw88S3y+Ncwr7lWVEEfTrVGcZaB0vux6neOw+sNIm/DlgqumvGeTzAZ4ERuyojezLryjmyL3wwK5WfMxTQaJA/cvAFhaIWbbwD6mC40KPPlJEvgAo076ICzaJcro/YyIZwg7Hf2pguSOh/JHfNpP0DUsBAXc8aAMR4An+kSH7XL+Kg9BKyiSolmX6S6Br4guzbJc04XRUdR8y6Mt+xJHb1kRL4f2pOw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHKM8bzZXNQSEM1EnYV7Q4PsQQnzQawk4EO1dUZ8kAw=;
 b=bbzEEfikw3eRprU1Gll7k4yxWigzwBRRCNDzeGa+AWvRWu3oElPRYcXEC9IIWSZ5+oVy0Jq66SbvW4eayeYVtK6RkvMnbDTFQV5oXAv+YFAkuODNaFF+PAx4x1jcaOgKw+CxkkGwdhC8iM3E/ihudA5LzUyi39R7vJmWU9ekWXc=
Received: from AM5PR0301CA0033.eurprd03.prod.outlook.com
 (2603:10a6:206:14::46) by AS8PR08MB9195.eurprd08.prod.outlook.com
 (2603:10a6:20b:57f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.31; Wed, 24 Jul
 2024 14:40:14 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:206:14:cafe::7d) by AM5PR0301CA0033.outlook.office365.com
 (2603:10a6:206:14::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Wed, 24 Jul 2024 14:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7784.11
 via Frontend Transport; Wed, 24 Jul 2024 14:40:14 +0000
Received: ("Tessian outbound cd0b9b5d6f11:v365"); Wed, 24 Jul 2024 14:40:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 93c88abbdf3af401
X-CR-MTA-TID: 64aa7808
Received: from Lff1124e4776a.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id EC749A5B-1F0A-4B18-A1DC-036B0D7F850B.1;
	Wed, 24 Jul 2024 14:40:07 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lff1124e4776a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 24 Jul 2024 14:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2bSrVrX0i+K/VKxVGKT0sI0Qg6jGE+n9sbRm+soDnyN2UmfmWQLod+nfFUjf6xZpKZ9cxjEZIQdmLXJiWiBItnjJEjDhb97XMGs57u+aq1rDfguZ8/0xFBcyJXCb9And+Cc/zgZELHOL6H3wyW4ms2Pyw1nWUqSf7OFI9iwucrzyyZYycgsumN2E7BIVsNMvb9e0EIxatHHRI2Gj0xDek/uNECndPRcWdcGCpEtbM318kDVXY7K2Xwz0smbvUuIraDkb6FtOFqjN7EZlVsTUKjaRL10eHIPWducPFqBZPKP5SY+fy9VsfdeqWlK2comT1HrOhIWyN7PvodoDFpwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHKM8bzZXNQSEM1EnYV7Q4PsQQnzQawk4EO1dUZ8kAw=;
 b=ojW1SsOG2Qb6tyQRw6RnnggIBS2j16QqbH8kBcbx6I1yH9cAUBEQwnVlBzWDAyD5LItydBm7sdbsMeIe6oNmoSaAlWfpCGhIIJ/LPDlWldgsBhg0t8FPVh5fxOuwHTJNb5B+3QmlDcUbWaieFLQNkw6fKEDdTfVz/stEQv87vUdEde4VUCwaqil3/zsa2cGmCa8A66x43zNB8FBXb3YmpEbINRBEs8N3Y21SPFw3zHB+RNwQpSUUsHqeIYPhN+IS9v+fxaGvF8KgR28DJ5tk9x7IugXuCpvZo9Tq1ZRnoOFrnMENiGqPHqB+rjujwZs0Uj3VSSRdYzAgFmx4Yb7ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHKM8bzZXNQSEM1EnYV7Q4PsQQnzQawk4EO1dUZ8kAw=;
 b=bbzEEfikw3eRprU1Gll7k4yxWigzwBRRCNDzeGa+AWvRWu3oElPRYcXEC9IIWSZ5+oVy0Jq66SbvW4eayeYVtK6RkvMnbDTFQV5oXAv+YFAkuODNaFF+PAx4x1jcaOgKw+CxkkGwdhC8iM3E/ihudA5LzUyi39R7vJmWU9ekWXc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com (2603:10a6:10:401::11)
 by DB9PR08MB7608.eurprd08.prod.outlook.com (2603:10a6:10:30b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 14:40:03 +0000
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a]) by DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a%4]) with mapi id 15.20.7762.032; Wed, 24 Jul 2024
 14:40:02 +0000
Message-ID: <9b823928-2910-4253-821c-6082fc9f48ae@arm.com>
Date: Wed, 24 Jul 2024 15:39:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] firmware: arm_scmi: Track basic SCMI statistics
Content-Language: en-GB
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, sudeep.holla@arm.com
References: <20240715133751.2877197-1-luke.parkin@arm.com>
 <20240715133751.2877197-4-luke.parkin@arm.com> <ZqEN6w49zFSDMUIe@pluto>
From: Luke Parkin <luke.parkin@arm.com>
In-Reply-To: <ZqEN6w49zFSDMUIe@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To DU0PR08MB8639.eurprd08.prod.outlook.com
 (2603:10a6:10:401::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU0PR08MB8639:EE_|DB9PR08MB7608:EE_|AMS0EPF0000019A:EE_|AS8PR08MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: eed2e2f2-004e-4d6a-7b0e-08dcabee8761
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QVZOZzZHRDRQTmlNbnQ3VVJlVThyZmZnVXJ3RWpaK0FtUjlndmVYUFBrc0pq?=
 =?utf-8?B?Z3dSWDFJS0V2Z1BxQW1BekYrR2hjNFFTRFN1bEdUbEEzQm15NmlpT3lOV1Fo?=
 =?utf-8?B?Zm5yNi9zMjZ5WTBkZDYwMXpyVVJkUGR5QlVkZXpva0svZzdmd1ZhVkQ5VlVw?=
 =?utf-8?B?V0ZkYkM5bnora0Fsc0ZOYW4yckNnMFlVbHFRdHY5UXNyZXRkMG5FM01KMWYr?=
 =?utf-8?B?QTdnb09TblE4VXNYRW8xUlRCL2tRWEI2MzZ0clpQVFZhczdwSVdkaTQ5UXY1?=
 =?utf-8?B?V3BET1hCUjV1ZDY2TVltay9BRjZpZDBoNmw1UHlUbzJ3YVllb1E5WEtXUEow?=
 =?utf-8?B?cFRtdTVBdnJXcFI4Q25EeU5MMnlxTi9iOHZMbm1WS2R1ZFRmZkxTYWpPZC9q?=
 =?utf-8?B?d3JzY0hsMXZ5YzJXaCsxcndSOG9jWEZjQk8raFNZQTdpdGd0a0JSeWc5c3J5?=
 =?utf-8?B?Y3NkYWd3N3p0amwzalZpaUFIbTZ5WXNjb2VIa0ZycVFhSmhGbUxFTld6REFi?=
 =?utf-8?B?cmxESDZGUEoxeXJaWFBRbmxQTEI0Mm1DK0E0SmFzbE0xV1hncWREbkVHU3A4?=
 =?utf-8?B?OGg2dm9EYVBzRHYrMnRmVktHQk1lQVFQbis1YklGeDk1NHg5WlhJR1VzbjZT?=
 =?utf-8?B?Zi94NU5Kc0pDTmJjSmFock5pdElJU0dOZEVzcXU3WTdnanZieSsrS2kwWWhJ?=
 =?utf-8?B?UFpuYjJnd0VxV1hEK3JVOU9TaVNKL2EzbmJoRnBOR1o5N000WHpRWlhlNzBF?=
 =?utf-8?B?VU5FemZOYkFoQ0lMVGdhODhqWlNYNVVXWDdrdk4yMDZMeXoyVlY2NlA2b21z?=
 =?utf-8?B?SHpGdXNZSzhuNUxkRXN5OUVpL1lYTUZkWDh1OE5yWmtYa2djV2RQOUJmcGZ3?=
 =?utf-8?B?YkZmS04wY1NWQ0s2VWlpRkRCUUwxZi9BaCtuRVBGMWdaUUthRGVEZWxNYVdL?=
 =?utf-8?B?SmhmVE1VRWJtVG1PZzk4d0RsazFtaFRPbFNRSmU2QXdPb082ZDg4MDNXNjls?=
 =?utf-8?B?bGtQS0JhdWxyT3ZSMFZ6eUxIRnJpL0M3b3VSRnRLUUlXOVJvZmhxUHJkSjBD?=
 =?utf-8?B?aG5acWxKUlJQOG9kNHVzK1pkb2F3UVRhRE1CUHVheFNiVDdQUFdURUtiK0dR?=
 =?utf-8?B?d25WUjJxWmc3UGE5WEt1dFl3c0xFcW0reFZTVkZ2dDdQOXU0WldsQnZER25m?=
 =?utf-8?B?ZnRGdTh0YXZtbXVJMGlmNjFERXYrYXBZUkVzdWNyckloeDEyQjIwYnF2Y3dZ?=
 =?utf-8?B?YVFCV0oreVBLbjY5czhTR1dYZTNHNEs1bE91NUZRZS9JbGFMdk5iQTVPdWJM?=
 =?utf-8?B?TExkbWVsdW1JMnJBRzB5T2pFOFdFVEdPb2M0NmhyMHZ0RFRqZlRKV0RGSFJP?=
 =?utf-8?B?Q2hCcHZOMURGSUt0QStocjk4NXRtaWhFVmNLOUlFWEhpN0V5WldSWkhKSjcz?=
 =?utf-8?B?anpwM2V4eWg5VS9DNWgveHpHVHozU2JnZS9NWnkvKzJoUTZrSUt0YnpuVWtT?=
 =?utf-8?B?ejdaYjhPNUFBbmtleklMRW1XKzVWN1FnaTFscGxQcWRUSGFMZDZ0Vi9ROGNz?=
 =?utf-8?B?VGpVV2RaNkNmai9OVzlGNUZWUXBIRHpHdG1ORmtvTkhjRVYvUitBbmQ0VGp3?=
 =?utf-8?B?VkdaRkZ0WTFFcmFxRTE3eDJhc1VEdHNqUHIrVHhCTnU5RTZYdzczSkIzTzN1?=
 =?utf-8?B?WGdNajFUUEVaOS8vTStKdFAyVVg4c2Vmb1dFMkZ2QVZEd0hlSHZhMHozcVZr?=
 =?utf-8?B?UFJueExISjRqcW9GeHFKVGg5WjZTSHovS0dwTjN2cWlDemZzaTEyS3ZYYlNS?=
 =?utf-8?B?d0J3SWhPaUdvMWdCQ1VBdz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8639.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7608
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:401::11];domain=DU0PR08MB8639.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0e429a80-49ae-43b9-0f0b-08dcabee8082
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|34020700016|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFo0NXp3NHVmOWRlMytSbVpsWW1Gb1Z3WXJpSUtUQkM5dHE5MjBpTHZhNTZm?=
 =?utf-8?B?Y1JXdmNhQWxtVDYzVnQzV2Z1VVdoUGxRN1RqWlVPWHdzRTVZQmt6R3kyVjdI?=
 =?utf-8?B?RHJXbGdyNTRJb1BQNGY5YjRKMUYyREkrT1hDcU5JV1l0b0Jhd05hKzZrN2RG?=
 =?utf-8?B?bDZsczhDUURmSVNUc3ZRYjdSWFFkc0RZWGNzYVBBY3hNYytBOEpEbVV2N3FY?=
 =?utf-8?B?NkFPYi96Yk52RDFOMDl1Z3NzZ1VmZWhxOWNVZjZOaXRrTHJ2SnpibnlwS0o5?=
 =?utf-8?B?Z2VUbHVJdUhIMDJTd1RzODZuSmFFd3VoOElkOFlYam5vOVp0bmpvUy9RZmdy?=
 =?utf-8?B?NWN0Qm1qYmhTbGdUNlBvNG5JWThFMzlGeVF0WDBrNlREV3NWb1hRbzk4KzJo?=
 =?utf-8?B?Nktzeks5bm02NWpHejlKWmVlRTd2R1BlYnBoTVFDWTFpdHJiNmpEQUpwSWFq?=
 =?utf-8?B?aHJhVnk1dmxrVytzaVNGV2lObXVSRlorQXV2elpIVkdSRXVlT05iTFc3dDdD?=
 =?utf-8?B?TTV5THh3THRCakR1TmNJbmc3S2Y5Wk96TS9MVzhHb1dlYVg4dzhrakgraXBv?=
 =?utf-8?B?VnFaTFRIVnU5RVg0bWJzaDQ3T0FwY00yamhnemMrQWRXL3I4N3p5Vnp4NFZJ?=
 =?utf-8?B?cUtKWk1US3lPYlJXTjNicVFHSi9CY3dtQ0NEUDVBaVYxZlhRaFNzcGZQNnMv?=
 =?utf-8?B?N3V0dVdnQWhJM0xFWVY3S3hHZHdwOWd1UDl1eXpUL1BrNk92UHl1VzB5Szcr?=
 =?utf-8?B?S0NWQ2dQV05qQzFWZjlONGxtck9qZ3poQjlEZVFBdHVzSS9IeUtoUlk0dEM3?=
 =?utf-8?B?VGNBQnJkN3AxcmMwZGI1ODMwMzgyRFVRRFEzMHVDaEVnYTVFcm1WSldNOEM0?=
 =?utf-8?B?Vk5tL3hKVkR1cHR5YTBvcTBGRnpuUVp0Q3pzOFMrMnFvOXU5TE1aOHFzWnQw?=
 =?utf-8?B?b2pMMnhHK2JtemFoUXRJTFIwa2VEUEtqSmV1YjhCM3cyL0xvaUc3MEdWQXNT?=
 =?utf-8?B?cmRSZjF4K0FzTTJXWFpYTkxONUdNdmFTZWhOWlpISFVUa0MzSDE0T3cxTEda?=
 =?utf-8?B?amlHQ2JkSXNLWTVpWWRXY3A0TE14UjFzTzRUek9WVnEzR01PajBXVzlqTytx?=
 =?utf-8?B?UWpUbTZ0NmVjVDVMWUNSZFlIZmpxRlRQYWJtY1pvcHBRZXFlQ2NlNkhRNHNM?=
 =?utf-8?B?NjJNQVF0aUFtaUV2cEZZZTZYTnNDLzFuWmxGNk9EdUZwN1dLbkhGcGJkeWxo?=
 =?utf-8?B?MFNsdEdSaGQ2RzM4dXJXQTd0dEtKUm9LWjFhOW5vR2lqaFFYeWtUdFRCZ1la?=
 =?utf-8?B?czRvU2orMDAvWWs1SFlOVDJCSTRjOW9Pb0NheG1VR0xCRzNTc0djR3NXRmFH?=
 =?utf-8?B?TndzZEkvUHJIQW9oekhscnZNaU5maXJucGRNNTBnOVlEbk1sSmQvZjFIS1pl?=
 =?utf-8?B?ZGtkMFlrdi9iRjhOM3psWFRwVmlyd3U2NGpKbzYybld3YktqRnlCNFBIZGFU?=
 =?utf-8?B?ZjZ0eVVlQ2lKYW1NR1NjZTBRbDhPRmF1aFNWTWFLTlpsLzVadTJGbXZaL3hQ?=
 =?utf-8?B?SmdWT2ZIcDZSRzdyR3FMZ3NuNVRoZVZCdUtYNmZrMTMrUStxRjJ6aEVyOUIy?=
 =?utf-8?B?NXpHWVNBTmRBMmxDTkNTbWc1QlFTM2JsSjJQYnFrWE85L0tlYUhacjFVekI2?=
 =?utf-8?B?b1p4QXkxQzlFQ3NHU2I3T083Vnd0UStiLytKMHZoSWswaVNXNnlWOVZFWk9t?=
 =?utf-8?B?SEhXOTJFVVB6bVltM2hZR2Y3RU1sSW9TTmNYUEd1ejVzSDM3VlVBM3hYWEdp?=
 =?utf-8?B?STlTV1RrbFJnZk14M2pMNjB5Z0t6UDcvYWtucnVEai9CazgxT2hIQ21DSXZZ?=
 =?utf-8?B?bzJGa2FaRzRieWhSM25EamNVR2dYd2ptT3Nia3J5VTF5WWZnR2x6dEhYMVdZ?=
 =?utf-8?Q?A8b38yC71X+Lch6USFJI4nAhdAkpBQpn?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(34020700016)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:40:14.0865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed2e2f2-004e-4d6a-7b0e-08dcabee8761
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9195

>> @@ -994,6 +1008,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
>>  		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>>  
>>  		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
>> +		scmi_log_stats(info->dbg_stats, ERR_MSG_UNEXPECTED);
> 
> I'd be tempted to say why dont you wrap these scmi_log_stats() inside the
> scmi_bad_message_trace() ... BUT in order to avoid an additional
> conditional inside the scmi_bad_message_trace() you will need to somehow
> remap the MSG_UNEXPECTED to ERR_MSG_UNEXPECTED inside scmi_bad_message_trace (lets say
> with a local onstack array indexed by -err)...AND that would mean committing to keep
> such mapping in-sync with the the above enum, so as to avoid that adding
> a new definition into scmi_bad_msg BUT not to debug_stat_counters will
> end up in a buffer overflow....so at the end probably better/safer to keep it
> this way...

Yeah, I had the same thoughts and came to the same conclusion. As far as I could
determine there weren't enough scmi_bad_message_trace()'s to warrant the extra
complexity (both code and processing) of centralising it.

Thanks,
Luke

