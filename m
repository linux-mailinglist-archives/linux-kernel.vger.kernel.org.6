Return-Path: <linux-kernel+bounces-237563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B977E923AEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A50E1F21909
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A815887C;
	Tue,  2 Jul 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lm8pbkXK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lm8pbkXK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52913157465;
	Tue,  2 Jul 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914268; cv=fail; b=AmLTuPZHXGWf2/K31BZphRfnY6VA1HBccuNNDRtqgJgiWiATv3lOOpl1L2FUlKCsY7q/hN5XeQEoNAOLRC8099YDsFMaia4HHoo5pPmKUwtsGlqp4K/QwIR1ZXqkD0WxIwdcAid87k4FteOFkT6cGHkDXbBXCWaNfwatGbeX7xI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914268; c=relaxed/simple;
	bh=GeVQUHcLqwJrmEM7cJ72WEphuRQzTxlWfRFZVaXQysU=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E+IbWuEtKAZICXCrgcXOxEiHGyyd+GXpjvklAJQdPrhyfQZcIRqU8IqAF3low/tiLMz3BNg/KtHEaS2XVxzGKGoJggKsDr7Goos2yrZv3lVA5cNWDP/b5muhz1T8M1EoCnkZjRMmVFJaw4ALEyG46aOQHbIExhtB2lTU2zSK2tU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lm8pbkXK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lm8pbkXK; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=H4/SmRcGcCr5afP57GFWtoSyMD1WRyoChu+WTvqkZUNmykOaik4AM9BOJ+hXrMvFNffnPxlfJhEoJe0ZPLOuBId/3Pr2Q2vs5HO0WpFj71qYqrm2qOZ24VuaejoET9ocpOBi9YNpxmwq77iC2w/58hdlYPQKFTCuoF8o2AlM9L7TnQg1l8zFj/tXrBGsvbLViNXtyq7A4pUnzzznGLDLtVOfnqHfw0PAAdIN6n/DLDgQ48OY5Jsz4BQ70bq3wPpIg790qZW1Q39Z+Omv2GSfupoz6Yccm952ggeTL1Ei9ex4M8UG55m3P00bhAOe0EK/whqLl6TIwhEd5TqbR9pdRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdgmsWR8bdYTnxML7NI2U130EzlizH9/0nnlgSWDc8E=;
 b=euArFRTQeacxPS0oYpm8mGLjuXHULXCK4khUEvrqsYCPqGPxlZsr5Ba1vOZzBE2mnRHxA6fED20Wo/Raou0qJ0e6BkQn6cREU+kTzMbV6k3KeJO1HARuBMvB/5KYEgKOJCvvX/RfgBMKcE0X7S1MxIh7ZmlVAetfLGtcgMqEzl4qsVP4GAFtZlQD66b0sDrS+8clyU5YhEYdJb4cEyNFqzkK5RpEo2LAVftS5HpCK+CIi73JolgKo1BnnjvSrTVRRqUF/1nFuKSlB2uJt/fRncrI4uExxCJ3Ee2oBYBKJnClmnFPMlDfYvz8Qtn3z9ZIQ9l7uDITqg/mqD4+ub9jtg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdgmsWR8bdYTnxML7NI2U130EzlizH9/0nnlgSWDc8E=;
 b=lm8pbkXKav+nov4Tr7WXo4ZCXU8UouX3MA215j+b7wE9XsFfCkElIkIbrmCovzYNoxFVL9G6JNcKspvWEj9/pVu2kJFNhAHKnEmibg7cyPaMthFPyV7gE/qG1wVxjpcNVYn8IYnmIV1gcB3W/2EqTzcQMzRpD+KUWNo+xftmw+c=
Received: from AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40) by
 DBBPR08MB10411.eurprd08.prod.outlook.com (2603:10a6:10:536::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 09:57:38 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:208:0:cafe::b1) by AM0PR03CA0063.outlook.office365.com
 (2603:10a6:208::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.27 via Frontend
 Transport; Tue, 2 Jul 2024 09:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7741.18
 via Frontend Transport; Tue, 2 Jul 2024 09:57:38 +0000
Received: ("Tessian outbound 95c69b3c0b42:v357"); Tue, 02 Jul 2024 09:57:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e8d81d1f96179e97
X-CR-MTA-TID: 64aa7808
Received: from 732729daafd6.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id DC594C4C-BD89-4373-A7BE-7F502CBBDB85.1;
	Tue, 02 Jul 2024 09:57:28 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 732729daafd6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 02 Jul 2024 09:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THh/Br9nCrbprm8IZCOLG53VwaYu2tNczFutJ1vqrXWJVYm67T0DaWy5TI9RQ1ieZqaXRBBzw3PlytF+Hpvj8E6IuSovGE32l+ZkIY9/SDqSB520qol8ra00du8pG/y4t8y+Vf61UMm8cW0xTXUyjdZ7zTevvjjuqwwUSknNs8OiWRJIlEhdoxsFejUfy9cNGQ3xqczLewNEBMxXOnFkW8ZUlgu2vzdVQ+t0NBTIKARmIWtuTvE1QStjVVBmxH6Ied6a1CpMkwRvA/ULFuXFkSB/UK+Um73BYz7jwg7lt60gpYI8a4isi1ojFpQiabyApSPcmqJMZP1tZ27YY17Jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdgmsWR8bdYTnxML7NI2U130EzlizH9/0nnlgSWDc8E=;
 b=LIoY/Mk130m7WffMqaOdOrzePVDdDjqc2SwMBFXxYgWQYa6pDqCAPtkwDBY9Yh3sJeTXi7eZhYVV4qqdOeE3Muq4XoIHU480T0L+0F6rGuwNcjhcueJ9sMuMUE4eV/Fst5hIdDcyK5EuRgZC2D4eTfBsKJl4vHi/26y6RvAxjaEDsx1BB5WEzykpNhtPI1Koq15ExCDpUXDUzErdNiohMKcNuYZQLVO3Tbmj68NTDZnu0baywtMySEdYMYq7R3ZuTpFL3gC4p2t57ve/cxy90nTTEdYGnMFymLnjc4gYLufmgQvkpPVIqJRl4Cob3ELD0w2VhFCUVWklw7458nXzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdgmsWR8bdYTnxML7NI2U130EzlizH9/0nnlgSWDc8E=;
 b=lm8pbkXKav+nov4Tr7WXo4ZCXU8UouX3MA215j+b7wE9XsFfCkElIkIbrmCovzYNoxFVL9G6JNcKspvWEj9/pVu2kJFNhAHKnEmibg7cyPaMthFPyV7gE/qG1wVxjpcNVYn8IYnmIV1gcB3W/2EqTzcQMzRpD+KUWNo+xftmw+c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com (2603:10a6:10:401::11)
 by DU0PR08MB9581.eurprd08.prod.outlook.com (2603:10a6:10:44b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 09:57:25 +0000
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a]) by DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a%5]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 09:57:25 +0000
Message-ID: <490bb053-f2dd-4c6a-a976-c8d21d66eb4c@arm.com>
Date: Tue, 2 Jul 2024 10:57:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Track basic SCMI statistics
Content-Language: en-GB
To: Cristian Marussi <cristian.marussi@arm.com>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
 <20240701142851.1448515-3-luke.parkin@arm.com> <ZoLWH9-JPFQB4YSu@pluto>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
From: Luke Parkin <luke.parkin@arm.com>
In-Reply-To: <ZoLWH9-JPFQB4YSu@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::20) To DU0PR08MB8639.eurprd08.prod.outlook.com
 (2603:10a6:10:401::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU0PR08MB8639:EE_|DU0PR08MB9581:EE_|AM4PEPF00027A63:EE_|DBBPR08MB10411:EE_
X-MS-Office365-Filtering-Correlation-Id: d30905ed-cc43-4aaf-d7fa-08dc9a7d6827
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TWlrSVlPc3Z3b2t6WmJRRnJFWnI4YjU4dmhIaVV2L2lQQ0t5Rk1QV1l3Y2Uv?=
 =?utf-8?B?OGdQbmx3bHUwT29ZRmI0ME5FWHZEL1RGL0hiV0plcGc3ZURNbDl5MDMwUmlF?=
 =?utf-8?B?aWV5d0hFV0ZVaHpMb3ZwQjFmcjFLaHA1a0h2SjlZdEJYWUo4eFBOcUtQaEpz?=
 =?utf-8?B?OGtZN3pJK1o2M1RvM0d0ajdEVHpZd1RPeS9pNDdNaG44b2JZWTBiSDZpbFBM?=
 =?utf-8?B?bGRIVTNQUUJGc1FOemwwMkdITUVyWnNMS3QzZ3hJanlndm5CR09qYWc4S0VO?=
 =?utf-8?B?TlB1WVNlT1F6QkYrUi9saW1ISWszMHBNNG52VUtFeS9rV2kxWWdvWG10cGl1?=
 =?utf-8?B?YkxCTE1yQlFYQlg0TVZDQ1oxUTZ3clhUcXZIQlFCYlUzRzcwdzJXMm05NUhM?=
 =?utf-8?B?d3R0RmJ3UVpWcGlqV2h6OUVBMmRxUUFodUl3M1hUQngzS0hUSHBPYld0cEpj?=
 =?utf-8?B?eWxJWnV2WDUvdW1WWkRabFZSMmZnengxbGloZlhrZ1JzVi9MWHlKZGNTcVc0?=
 =?utf-8?B?NkNLVjBDTllDa2liTWNWS282QlNEZ2JWWXdvdnRpZEdTdzRVUnVtanlpekhJ?=
 =?utf-8?B?MXVSSmY0dk92bVpXb1U5RXc5NC9oWk5jczArK3EzcGlXdGtySXdwd3ZIVFRE?=
 =?utf-8?B?dng4L0MvdHAvUlU0SjFYaFJ2bDVjZHUvdC95dk9PdVJOcDhhaC8zSUxQNWxL?=
 =?utf-8?B?ZjBoU3NRd0llYVYraXVpMDluZ08xSVdBb3JxaFBvS1htaUliVVdrZ3RzbS9q?=
 =?utf-8?B?QmlKTTZJcmE5a0tvd1lGbDk5UkxtSXdtYjNlbmIyZGEwZ3lham9pN1piVHln?=
 =?utf-8?B?K3ltQXhxS09wRVpXRG5jTE11MnVucUtzenM3Mzd5WitWVmZ2NVh2WVJHVTNP?=
 =?utf-8?B?ZFhqckhaenArS0ZrNTNzb2xOTERuSndZL1BDcEVCakpiK0VCWHIxeWpSS3hC?=
 =?utf-8?B?VGxEZDE3cmZBNTU5bVNqM2piTUdwcUJlaTNrcUxhS2xoSENlUXVNQWpiVHpi?=
 =?utf-8?B?SE9qMzZTTG1aeWViSkdobmxrbWp4QjlVNVRTT1k2ZVdNVFZlcGo0UmVld1pr?=
 =?utf-8?B?by8rMUlWUm1BUVVuYklNVWRlZS9idWo1d0lYSC92dTJFOTlCN01wcTFtRXo2?=
 =?utf-8?B?R1U2N0laaCszZkZWcm8rcldQV2lmVXNpb1dwejdZTzF1SWM0S1FrU0xLNFc3?=
 =?utf-8?B?Zmk2ZmIyK2JvOXcwQ2VvNzVoRVRuQ0F6bzFjbmVNWDFkSlMrRnV2bkFFZE03?=
 =?utf-8?B?VmhObXpNY0hCWkRlQVJUS1IxMG9hU0tHam05U1dNazgxd2lzU3BHRktVMS9a?=
 =?utf-8?B?YzBOdkFPSDM5MXdLNFp2dTMrNTRoaW5zalp6WTRod3M4K0JBdWE2cXFuT1BU?=
 =?utf-8?B?TmZ5TS90YUM1NHRrNXNQWnRGc0dudUkveURtZGNWRHpCaW1DRW9rWmhnU1JQ?=
 =?utf-8?B?bTNFOGlQSGRFWkpiQ0R6SkQ2MUxNL2k2YzlhSHJUMWM5ZmdZU0k4T3NXdGhC?=
 =?utf-8?B?ditCT25UdkljSHRTNS9laHVjZ2wrOVF1cjArbDN1NHRKQ2REVXpCQ1N0K01E?=
 =?utf-8?B?SFdDeVFYSThmdEF1TmdYQXhsRmk5aFhFcGc4cjFCd1pERmRHdHFqZ1grNnhz?=
 =?utf-8?B?NGFzeFI5Z1JhZm16V1hiTDdFUkdRUXVyaHpoV3RWWnFDT3hHdW8wUnlKbjQ4?=
 =?utf-8?B?Si9tbG1IVUJLa1ZyYU9adExObzVPb3VRcTc4ZlZNNDBUdjUzR1Fhd3FJb1B2?=
 =?utf-8?B?Mm9wUFg0SEFEbGx0c0dxdXVVelVBbnBIQUp5eXpyMzI2TVJiOXBJQ3dvRzZu?=
 =?utf-8?B?TitxQ2Z0dEFuNDhiWnpEUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8639.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9581
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1036b290-ac4b-49d9-4754-08dc9a7d605b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0NvM2xUU1U4MXRKT0VJaXhXQ014MnRmcHNkQStXK3RFZHFSTmJ0NzdEQ2xz?=
 =?utf-8?B?a0g3MlVJSGpKUHNDTDV6b0pSQzhTL056WVVQZGVaQTU3VzdOUUw3QTMwUTNK?=
 =?utf-8?B?MzY5ZEVSM0NjdktCYWlmS29KQ0tEMVhmY251enlic3VhcmJ5UzBocFVsL3dF?=
 =?utf-8?B?R0RqKytpU20vQ2tBdTR6a01uR1FIcmZjcm1RNk5mR3BNZGt5VWdlSTlxa2pP?=
 =?utf-8?B?M0ZjUWwxZlM3TVNiU1JsR1JCQ081Zm1YU1J5c1JnQlkyUldTNXBOYng3UXdH?=
 =?utf-8?B?dnVGRGN5ai9JSDhWWjdscFEzY0gzUktuZlJKMXBYY2h2TGMvYzlsMnJVc1BK?=
 =?utf-8?B?Zk16d2pjUkFNK3RMUDNMVnF6TkhiRnR0cVphTW1uRGxyUTFVeDhCZFpkM1Zh?=
 =?utf-8?B?RDBMMHJ4aWx3UVQvaytzaDlTODBTUkpoMFFkYVM4cFNjRjlhS1ZEd2ZKOE9E?=
 =?utf-8?B?enc3WTVOeG13ZXdhUCs4QXUxbXFjMmM1ZUNvOUVtakZUZkRFTDFXMlFiTGQy?=
 =?utf-8?B?U2FZc01BaHo5c05STnQra01vbDZGckxJNmc0TmFuZWVCNG9SNTRQazhwSFVr?=
 =?utf-8?B?eTVxam1ua1BxNHJhQ29MTjl5VnFhdWJzT29RQlM1dUliY0cvQ29oekZpUTAr?=
 =?utf-8?B?d09JSVJ0cmxvUENQUE9DVWNoQ1pPMTZYK09RTWJXV0Nwb2VCYlIralNLU1pW?=
 =?utf-8?B?RE4zMXc5NzJMUE1WSmk2Snlia1drc0FTamI3a1Q5U1VSSzVJR3JVNUNBRG5B?=
 =?utf-8?B?VElaMk40Z0Z0Mi9rMkQ5M3BESkhWL29Fdk9NSWhEQ0xmSTBTbzA2YVZKeDQz?=
 =?utf-8?B?QVpsVmErVnd3R1ZWdWN0bkQyZWZSVnJ0NXlETDhVRzZYWTVlQmFRcDZCUklD?=
 =?utf-8?B?WkVIMG93alFDZ0ZqSTlxREVKY1dzUDdsWTBZK2xNZlBFSnhvTUlURDJZTDE0?=
 =?utf-8?B?NFlGaHhJK3VFeDVWODFDMzYrWkZFb0hrN1JqaUp6QWdNUWVHcGUzbThtY2Nw?=
 =?utf-8?B?Z09qQk85WEhneExNRDlpaVI2WGNlaElmTDgwS0F4dVpycU16ZThnOEJxY0VI?=
 =?utf-8?B?eXlCTFRrdDFEbDRmcVpWeWNxbEdvL1V5UXh6WGxNZWU3WGZ5QnJSS3o5VjJP?=
 =?utf-8?B?cGR0bXA2NmtkNmZuWThIZWZKM1ZhRVBGTDFkM3JGRk95MGZJbTNEQVJycStJ?=
 =?utf-8?B?TUZBak4rRmJDWDhBbzdFN1FkMGRDSmluMUFFbi9aUFV6ZXFmcUJheVdUU2d1?=
 =?utf-8?B?UklFNitCSC9WREdBb3hoeURlM3dxWVNQeW5vUzZIRlBmUTJITlBrMFdIK0xa?=
 =?utf-8?B?NmR5ZzViWFJSK2ZnSFBNaHZwSzc2VlRPVTd3cXhXWVM5MXpqSUFPa08zcjJD?=
 =?utf-8?B?Z2JaRWpXY04wSmhSdTQ5dHFVR2hHRkIxZDlPRlUreUdiVUVqUVBudlhYOTJD?=
 =?utf-8?B?Z2xjUEFac0JEVmJtYnBmcjIreVFjT1lZMnJFVzFyUzFmNHlraUlaTDZ4SWhI?=
 =?utf-8?B?WFlnd1hCVG55Z3hUekJtZWpiR2tXNGptNXZMWFRGcFRucHR5VlNQbU0zeHZT?=
 =?utf-8?B?NldRTXBXZ2dtekZkWWc2NEhVM0hTQWVuQlpQT0VMeHpoZlF2TlZkdUtEeTdh?=
 =?utf-8?B?QnNwanJmcmRucENsZnNQQWJ5dkNXendGd2hrZFRpMkl0dzNaWUlmQzFaSU0z?=
 =?utf-8?B?Z3lkV0ROemFCUzRLMEFndWNhQm1lYXJpUzNua0FSN1JmcXIwSzhGcVB1R2RF?=
 =?utf-8?B?VU1SVUJiNkhESkJTaTZlbk9vc01IOGVHT0kxdTBqZ1JOS1ltbHpoVzdESGtV?=
 =?utf-8?B?T0xOTlVhL3VZcUVWK0JyUnhvQW8xNkx6SlAvdDE2ZmlRYldhMTVDeHlubnhV?=
 =?utf-8?B?RmhXMTBjbEFnUHRFVnQ5cG5YZVUybVVGS2JhUEx2YVg3d0N1VGVjOFVxejR6?=
 =?utf-8?Q?8E/W4wWz8imnELX7bP1cE4JdOtT5N59K?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:57:38.7548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30905ed-cc43-4aaf-d7fa-08dc9a7d6827
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10411

> Ok, so IMO, this is the main core thing to rework in this series: the
> "counting" operation/block should be defined as a macro so that it can
> be fully compiled out when STATS=n, because these are counters
> incremented on the hot path for each message, not just once in a while,
> so the above if(IS_ENABELD()) now will be there and evaluated even when
> STATS=n.
>
> Something like:
>
> 	#ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
> 	#define SCMI_LOG_STATS(counter)			\
> 		<your magic here> 			\
> 	#else
> 	#define SCMI_LOG_STATS(counter)
> 	#endif
>
> .... I have not thought it through eh...so it could be radically
> different...the point is ... the counting machinery should just
> disappear at compile time when STATS=n

Hey Cristian, Unless I've missed something, It looks like IS_ENABLED() does do
what you ask for.
In Documentation/process/coding-style.rst:1168 it reccomends using IS_ENABLED
for conditional compilation over #if and #ifdef, saying that the compiler will
constant-fold the conditional away.

Thanks,
Luke

