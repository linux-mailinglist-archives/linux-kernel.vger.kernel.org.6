Return-Path: <linux-kernel+bounces-574821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD18A6EA81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010863B187A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC3A20E6F7;
	Tue, 25 Mar 2025 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XgkGZO+U"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B2234966
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887742; cv=fail; b=GxOnRmQJQ6VJZyRNYkrFayWL7U+q4OXV+1chasC6GAByb4l9EZpXS1LGldyEO4Jd3wknfyW+E6G6bAFxOyVBtokxDYuCFST6CSIkiAxmFZEoKN5dWHbdXgYyp5dOHvLFeOvJXcUZ9mjdRJ1QFnM1odruZpnSFOBFEU51IX8MQSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887742; c=relaxed/simple;
	bh=8FF3rsS+noQolo9VAxXPMFJdUTkxk27UmcKGEmNftZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JidINuW2N9enERv18gPRZ2KmmtId3dHszFpcggm9QdcQQu/6SESFb0Bhd10tDinCNsVEbHmmlPQkc5SY7ozTx7xbrQxDpqMWkmQonUFOjBcf2V5vRew4DW41b5/Oxr3ccaOmt2RVjugz/q934z1QoFsPDpPZuVyeTppr7Fp9CgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XgkGZO+U; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZGd1sZ5efTFF7vm2klhAoR2AhHiIAMftnyPBrD997daavemSmF/BZIc/9uT1iXypqWWXongml/6pWXvgVnIt+asORJn/WGEdcRnPN1WO7V9qCQpQGInoz8U0gwav0z7te69ZDO1VrLZGmWWjQyxlmklK+NJr0PCQFsP4ZzBz1GqiGMd5jENaNYAUhOhP51vuvjXGc+5w1SALDcMaMcSyEakg24jC86wxJGZG186uyIXL+e8XYVTv57DbRJCt9M+S02z3Mb2MY0dvuQBViJWRxhJKrnyUvhUx1pYPBiV7qXYYD9SmrmaRK3UPqLSdkgUzwhXcsEL0lwiEiGMnGYjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mSb0ISaPKpbDU+mBqeaCgWfQKo2Lc6O5Pp2t6uVhEs=;
 b=XMWTomYNEq4mmaMlVpOsNT/SIxPIAOh0PSDSB9hFw5q3nLS7VB5WPDlUvB0ey26fOJCR02xO2mP2XfNBMtlLQ1lKAj96S2bw2iiyhZMe+OCwMb+FoHjhNzK4WfZjPmJxmLPT+dt4m3BSsei/J4Ri2sc8D/JVJSGNIiEPqvz4q/NdMzCLVB0dtVWp1fPx27XpKN+ntGDZ9nSBqbJ5RnSIMZnxl/PPpxajEaThn2sYiaFO/miYLN8TxyDVq9ZhcNy17j2Cqnf7G4zdhQTZa9LGyRM6Nt/AXbaNdgAyjSmPG//BuRbGoGnalWoizVeLWQWhoKzjj6djG/XpKwFuRw7dfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mSb0ISaPKpbDU+mBqeaCgWfQKo2Lc6O5Pp2t6uVhEs=;
 b=XgkGZO+UoSEPN0gCoqpN+AE3oB5b8s41jzmvFdiAFO4G0nKSFLSJ/NigKo0n1kjFZRazwAoZmmuY+oT3BGst5IINtyp/tecgvumDSzbKzJIY1KXeRYapi0AsAlrGrElOda7ceDshKvblzdBy2naGvFUM90s7EFqqaKiJi0VCLhSCTalLeWTnvG7q1P2Z3DBTyu43eqzHpcOV4onMMPFB1+P9R2ss+QEY3n3sAFZ2jg4i5GTEYeQmyQOSuwe9XVvFz3c5ZSvzwrcYFXjCIgOvkGV8WVVyzHw8sRNJOWGc/5ybaa4yb0MNHeHfEdTabyIT4uVG2OFVUP4A4GKrFvyhCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DU4PR04MB10402.eurprd04.prod.outlook.com (2603:10a6:10:55b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:28:53 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 07:28:52 +0000
Message-ID: <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
Date: Tue, 25 Mar 2025 09:28:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20250324100008.346009-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::11) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DU4PR04MB10402:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e1238c-c750-4684-3eed-08dd6b6eb179
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlRJMzRIV1lZMGQ4QXg0Z1ljc3o5L2JmeCtSZ21KckFFajFIL1kxWnc5N3Fq?=
 =?utf-8?B?VTJkK3R4WUJkQ0lWOG5OekRvVG5CalR0UEFaWXVzTHl6WXY3bXNYSjVZSFUz?=
 =?utf-8?B?Qk8xYXltd0NFRXdSWnlGMDNHWThUZjFEa0dHT201LzhjYkYxTFo4QUkxQVFJ?=
 =?utf-8?B?RkVqbTNFbGgwa0V5MmpGVlFlbTQ3YWMwSkl5c294VkZ6OVl5SFVjMTNjKzhL?=
 =?utf-8?B?aFBrSUhFbXB2c2J5YlpRTCtwZXNRL3FhQ1Q1STQ3WDZHU0J0dFRoS0FrcDl1?=
 =?utf-8?B?L01TcFc5R2VBSEFBbjVtV2U3aTVGaDdaRU1oRE5TTjE2bXcydjFKUHVuelVK?=
 =?utf-8?B?U3MrdzhNQ29mWlhwOEs4aUVpeHh6ei9HaW4zTTd2d0JsWXUwUGl0d0VFRldZ?=
 =?utf-8?B?VFRQejlCQUVQNXIwbWVWSk4zNVlxOHowSVpQb1FSSzRoSU96K0xMK0lpb2pp?=
 =?utf-8?B?R3dlTVl0bExTMVcrQUF3eVQwQjh0WGF3UXdWT0ZOMDh0bVJBbk4vck1xVmRN?=
 =?utf-8?B?b0J1MlQ4bVc3YSt2dzRHUjdPOGJNeU1nbjEzVWVmaTlHajcvd0dPMndGZnVw?=
 =?utf-8?B?S0RGUVN0cHBTOVFiVU9RQzdDYngyNjd3anVFNkd1c0pjWTRjcHViS0tqUHNE?=
 =?utf-8?B?djdlN3ZNZHRBZmx6SkpKaDQyMEx5Um9wU3NHRFBKajNQWGdtUG5ldWNkTXE2?=
 =?utf-8?B?Tkw5SDVyNDUvVU95SC83MU1EQU4yRk1qRHVUV0tuU1VlWFpBdUdJOHM5KzRI?=
 =?utf-8?B?Y3BHMVE1djVyNWZ2TU1kRXRyelBvNUtyWnAydGVFRFM3Y01KbFNPSXZ2Mi85?=
 =?utf-8?B?c3NaQmJhdUNnQ3VKL2FXODJrM3FXRFdBRTJtaCtMb3ZydE9scEIvZzd5M3Yw?=
 =?utf-8?B?RWJtS29YR0xIbkgwSUhPWDZ5T1pIOEF2QkFvYjIrVHVicC93RlR2TWZFZHlR?=
 =?utf-8?B?WllNV3BkVmNlb0FDRG05Z2YrMVRlZGN1NFN2SXR6VWZJV2hiVkdWcy9mZmYx?=
 =?utf-8?B?QUllcGVHK25ucGJqbjc5Tk12MWZTY3VXd1lKWjNjUnZVekFucEpGaVJlQW45?=
 =?utf-8?B?anRWQ1I2V0d1SWg3UVNLQzJzSVV3dGJpd2NtRHQxNHh2a1p2N2xHMU1hckdT?=
 =?utf-8?B?MzFEcE9oRVVCOHorUnFjem0xSm9zdVNzeE5odXRDVHBkOFdCN3RSVE1xekFk?=
 =?utf-8?B?YkwrdU9BRFBweS93V3pzS3NtejJQejRrQUs0a3B5cTlINTllZTNKbVFwYmRy?=
 =?utf-8?B?VldpMVRmbldQdkVseGkrUnM2WjRGazJyK3h5eW5pRVZXQTRCQUwwd2VXTEg2?=
 =?utf-8?B?RFdCTmtNQ1UvTm1Wckk5am4yYTc2RE15UHhySDUzdkJ5SzdpczNnd2s2am0y?=
 =?utf-8?B?QVJXOTBxNFcwMmZjb09ZWHJQL0UwaFdRNC9IRDRxb2ZmQlZwMS9laUZ1Z3Jp?=
 =?utf-8?B?Q3ZDZUVzSStIaUdCVEtPTEJYejkzTi9aV0pObHNrT0p1Z251S2E2enEwMExn?=
 =?utf-8?B?b1ZJWmljYTVzZEVPdmtncnlWdzJ5WTNpekMrVmFsWWdtNE85ampTZlI2ZWlW?=
 =?utf-8?B?UklWTHFCRm1NV3FHUzl4bGRYbm9MQU82QWRJNGg5N0dWWXh5UTV0VjJjZlQ1?=
 =?utf-8?B?ME1tdS9HTUZ0bXR6ZUwyS2xVVnVsTHBxaURIKzg5dUMyY1ZZWXFhamdTUWVq?=
 =?utf-8?B?ek45MUF5d1ZlT0kzVXVZTzNqQXpDWDFmZk5OUDh0bkdpVVlXZmpidm9RRThE?=
 =?utf-8?B?SldQTmoxeVoyZ3BGOVhkWUFMMVhObHc4a3FTZ25zcFNxa1ZHOU9RTFlVeUhv?=
 =?utf-8?B?WFYyN3JzQzJXOHlQZFI3MmNlVGdndnFXTWhSNmtWVDZ2REwvdC9WK3dEbXF1?=
 =?utf-8?Q?E+COhZZfcfQpU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azRtVGsrNG1WcTZ6TnNXa3daQkpDRE9JM0ZLeDJBZWJlR0tDN3M3SlV0ZXgr?=
 =?utf-8?B?VnNvUmUybW4vODg0M1VLbFU2L3M5aE9VdGtVNFhzeDl5Mmg4QmxPVWJLcHpF?=
 =?utf-8?B?TkFuN29YTkhkQ2h2TWxBOXhYdkRtaU9LTTdCNHd1STNqVU5uSlhraDA0Q1Jq?=
 =?utf-8?B?anh6ZWs3RzFQZ2g0TjltRVpJNVIveVZ1enZYTjN3Mk1XNk5wNVZDaEVDMlBF?=
 =?utf-8?B?L3Z0L2NKbmlqRWZqcEx3dUFtdlhTMXpBUnl3cUk5Z3EwNUNPTGI3aEFWQmxS?=
 =?utf-8?B?RjNuaEdMalpNOVB3byt2TDlTQ1l1S2FaaWd0R21uaTV3TlVDM3A3aVVUcW9V?=
 =?utf-8?B?eUx0V3o4TEljK2JSTTZwN2RTcTZPNkoydkN3M1ZKMUVYN0VPN3padFNMRGJQ?=
 =?utf-8?B?NWhuZjdDWW11QTAya25JQll4NU13elk2TDhPLzBBNzA5eVZkN3RZK3F5Kzhs?=
 =?utf-8?B?T2JPSnRmcHVUc2M5K0JEMjBIR2x1eVpEdmZQVHBpam8rTnppZXFnUm50RzdY?=
 =?utf-8?B?Nlk1VnE5RGhuZmw1M2lWMGVxenNSTlRoRGJEMVM3cmV1L1hZN1c2ZUtmWHVr?=
 =?utf-8?B?WURkYWRVdVRZTGFhUXkrWC9aNHNIOEM2NDdia1VIUkZTOEo0bE8vVnZIaHRj?=
 =?utf-8?B?RldPcFhLc2dVb09WMXVjRHV2SmlzQzZPVi9teWh5VGVJNTQxMDBXTTlZaHVP?=
 =?utf-8?B?d3A2KzV0Q0xjOC8xQTF4cHBxbmJsTjd6ZHJlaGRTaHh6aGpHM2V6S3lYdWQ5?=
 =?utf-8?B?aWJ2bVh4WnA3TjBFTTRqaEdIQklEa3dtWTRCVkV4OW1Dd2RYUHV6ZVVyQzJM?=
 =?utf-8?B?eWduSmNXR0pGT0FERFNCUm1seGdiRFluc0JTZUJDZlV0N2ZjeDJ4c0c4MUtS?=
 =?utf-8?B?dE9mcjhtNFBYRzhyUU94NDlxSk90OVgzVXFWc1U1T1NtbUtyVmU5V1Qvekl4?=
 =?utf-8?B?TUpsVGlhNTQyR3VYb2JReHBocWVuM2FSUjN6eTJNYlVocFViRFFESjlBQU1L?=
 =?utf-8?B?bDBJdkd1UTRUdWM1bTZCSHR0S0VvRFJoeTNrakhFTWVkVEVUT0xBdWF6d1Jx?=
 =?utf-8?B?MXE0bjBiSWlIMTJWRXIySktOOHgxcGdYOVF5NUp5ZFhwSjZSckgyR3Y4M1BG?=
 =?utf-8?B?OExsYlZrQXVXYVpham82MkJOQVUwa3IydEtrdzBrbGNWYkFQQStudThaZ2xY?=
 =?utf-8?B?eGt0UXhwRGF2SFYrUENwUS9KZXlMRE1mSEgxOHV4QWVkVWg5MFFKWmh1WVlh?=
 =?utf-8?B?YWcvNUl3VGw5NFZzRXRJdGtQb3lzNXRUbGZYa3VaSzczZmpXYmphSzdNdEpR?=
 =?utf-8?B?RnlYNW1aOUxORm5PVVlsQjNCQ2FJeXlMTzVGVzc2NWtUQ0NoUmY4SG1mLzhG?=
 =?utf-8?B?dkNVM01sL0hvYUw3M0lkY3VoV2pjMnlQd21ZdXlsU3JTVWVVeDhtMk9BWGpp?=
 =?utf-8?B?NTdLaktHOExCcWhLZGtQL1YrZ2JNc3lLNjYrdTZiM0xoakNGZmowOEdYZi84?=
 =?utf-8?B?NkUvMGZPUGx0NW95ZzBLdlNQY3drbVFLenNSNkRob0xBSC9HaThBK0EwcHJV?=
 =?utf-8?B?L0gzcG5LWEsxZ3pNUGpLcUZrU0Q1RzdFaTFNMFN1c2RLb0dTVWNrMVE2TUdX?=
 =?utf-8?B?TkpRem9CcXFhL0RKcFV3c1piMlU5RVpEd2N4ZTB3elB4MWlGUlpFTGl1WDBJ?=
 =?utf-8?B?RjBYaVZ2QTczdkVBU1NpclhhcWdOSGdnaFA3bHFrZHFFOVQ2L3dzbXgwYVFB?=
 =?utf-8?B?aHZkTDgyTlhFc3JPODBCaDRPYnVkRUNLMFoyK3JVRkVMbjlxMzVWbitoSEQ4?=
 =?utf-8?B?UTR3RmtWaS9tb0poZkhDalc0TkFyVzhaOVQzMU9mV1hHd3g5eTAxVzVzQTd5?=
 =?utf-8?B?cXllVm4vTGxEVHNwUjFJajRSZy95a3lpUDd0M1EyMXpKTGprVzZtbFlOUWxp?=
 =?utf-8?B?K1krSTRDQjdmV0g1NGh3Vkk0U1VTaXE3ZHRQYy9DazN2SVhUdk9xM1QzaFhS?=
 =?utf-8?B?OUpiME9qWWNhSTFEdXUvdlI4d2VsRkltekVma2lqa0Q1c0RwYlJyRmxkZ0gx?=
 =?utf-8?B?WURsQXBaTnRIQ1B4cXpFZHVueEVwL1BzOVZwcEJTaFhobGJUcWFObm9BNkRj?=
 =?utf-8?B?dHR1TU9xUGRNeGNuYUhhc1J3aXZ0ZlVhWSszdHlsRExGcHF3YWF0RVFDQVBy?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e1238c-c750-4684-3eed-08dd6b6eb179
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:28:52.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwYtqeGt2jq2nJRW9rJU2cFfve8MgcS3Bj+NraPHV6J9H/HQpjSN8JOJ0Npwlw4Asxj9gdGrS0q3sRAutoJTyhAeYhZKXL+3TkIwS7sVXbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10402

On 3/24/2025 12:00 PM, Daniel Lezcano wrote:
> STM supports commonly required system and application software timing
> functions. STM includes a 32-bit count-up timer and four 32-bit
> compare channels with a separate interrupt source for each
> channel. The timer is driven by the STM module clock divided by an
> 8-bit prescale value (1 to 256).
> 
> STM has the following features:
>     • One 32-bit count-up timer with an 8-bit prescaler
>     • Four 32-bit compare channels
>     • An independent interrupt source for each channel
>     • Ability to stop the timer in Debug mode
> 
> The s32g platform is declined into two versions, the s32g2 and the
> s32g3. The former has a STM block with 8 timers and the latter has 12
> timers.
> 
> There is a special STM instance called STM_TS which is dedicated to
> the timestamp. The 7th STM instance STM_07 is directly tied to the
> STM_TS which means it is not usable as a clockevent.
> 
> This driver provides the core code to support both platform but only
> the s32g2 is configured. Adding the s32g3 STM support is
> straighforward.
> 
> The first probed STM is used as a clocksource, the second will be the
> broadcast timer and the rest are used as a clockevent with the
> affinity set to a CPU. The rating is higher than the ARM architected
> timers, so if they are enabled in the kernel configuration, they will
> take over and used in place of the architected timers. The plaform
> data is used to specify if a clocksource, a broadcast clockevent or a
> per-cpu clockevent is desired thus allowing more flexibility in the
> future to configure the STMs on the system.
> 
> Cc: Thomas Fossati <thomas.fossati@linaro.org>
> Co-developed-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/Kconfig         |   9 +
>  drivers/clocksource/Makefile        |   2 +
>  drivers/clocksource/timer-nxp-stm.c | 524 ++++++++++++++++++++++++++++
>  3 files changed, 535 insertions(+)
>  create mode 100644 drivers/clocksource/timer-nxp-stm.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 487c85259967..e86e327392af 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -763,4 +763,13 @@ config RALINK_TIMER
>  	  Enables support for system tick counter present on
>  	  Ralink SoCs RT3352 and MT7620.
>  
> +config NXP_STM_TIMER
> +	bool "NXP System Timer Module driver"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	select CLKSRC_MMIO
> +	help
> +	  Support for NXP System Timer Module. It will create, in this
> +	  order, a clocksource, a broadcast clockevent and a per cpu
> +	  clockevent.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 43ef16a4efa6..c3a92e6b9f94 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -92,3 +92,5 @@ obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
>  obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+= timer-loongson1-pwm.o
>  obj-$(CONFIG_EP93XX_TIMER)		+= timer-ep93xx.o
>  obj-$(CONFIG_RALINK_TIMER)		+= timer-ralink.o
> +obj-$(CONFIG_NXP_STM_TIMER)		+= timer-nxp-stm.o
> +
> diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
> new file mode 100644
> index 000000000000..b67e438487ae
> --- /dev/null
> +++ b/drivers/clocksource/timer-nxp-stm.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + * Copyright 2018,2021-2025 NXP
> + *
> + * NXP System Timer Module:
> + *
> + *  STM supports commonly required system and application software
> + *  timing functions. STM includes a 32-bit count-up timer and four
> + *  32-bit compare channels with a separate interrupt source for each
> + *  channel. The timer is driven by the STM module clock divided by an
> + *  8-bit prescale value (1 to 256). It has ability to stop the timer
> + *  in Debug mode
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>

Not needed.

> +#include <linux/of_irq.h>
> +#include <linux/of_device.h>

Not needed.

> +#include <linux/platform_device.h>
> +#include <linux/sched_clock.h>
> +
> +/*
> + * Each stm has 4 channels which take 0x10 Bytes register space
> + */
> +#define STM_CHANNEL(n)	(0x10 * ((n) + 1))
> +
> +#define STM_CCR			0x00
> +#define STM_CCR_CEN		BIT(0)
> +
> +#define STM_CIR			0x04
> +#define STM_CIR_CIF		BIT(0)
> +
> +#define STM_CMP			0x08
> +
> +#define STM_CR			0x00
> +#define STM_CR_TEN		BIT(0)
> +#define STM_CR_FRZ		BIT(1)
> +#define STM_CR_CPS_OFFSET	8u
> +#define STM_CR_CPS_MASK		GENMASK(15, STM_CR_CPS_OFFSET)
> +#define STM_CR_CPS(x)		(((x) << STM_CR_CPS_OFFSET) & STM_CR_CPS_MASK)

STM_CR_CPS(x) seems to be unused.

> +
> +#define STM_CNT			0x04
> +
> +#define STM_ENABLE_MASK	(STM_CR_FRZ | STM_CR_TEN)
> +
> +struct stm_clocksource {
> +	struct clocksource cs;
> +	int counter;
> +};
> +
> +struct stm_clockevent {
> +	struct clock_event_device ced;
> +	unsigned long delta;
> +};
> +
> +struct stm_timer {
> +	void __iomem *base;
> +	unsigned long rate;
> +	union {
> +		struct stm_clocksource scs;
> +		struct stm_clockevent sce;
> +	};
> +};
> +
> +static DEFINE_PER_CPU(struct stm_timer *, stm_timers);
> +
> +static struct stm_timer *stm_sched_clock;
> +
> +/**
> + * struct stm_instances - a set of counter for the STM initialized
> + *
> + * @clocksource: an integer giving the number of initialized clocksource
> + * @clockevent_per_cpu: an integer giving the number of initialized clockevent per cpu
> + * @clockevent_broadcast: an integer giving the number of initialized broadcast clockevent
> + * @features: a set of flag telling what kind of timer to initialize
> + */
> +struct stm_instances {
> +	int clocksource;
> +	int clockevent_per_cpu;
> +	int clockevent_broadcast;
> +	int features;

'unsigned int' instead of 'int' since none of these fields are expected
to contain negative values?

> +};
> +
> +#define STM_CLKSRC		BIT(0)
> +#define STM_CLKEVT_PER_CPU	BIT(1)
> +#define STM_CLKEVT_BROADCAST	BIT(2)
> +
> +static struct stm_clocksource *cs_to_scs(struct clocksource *cs)
> +{
> +	return container_of(cs, struct stm_clocksource, cs);
> +}
> +
> +static struct stm_clockevent *ced_to_sced(struct clock_event_device *ced)
> +{
> +	return container_of(ced, struct stm_clockevent, ced);
> +}
> +
> +static struct stm_timer *cs_to_stm(struct clocksource *cs)
> +{
> +	struct stm_clocksource *scs = cs_to_scs(cs);
> +
> +	return container_of(scs, struct stm_timer, scs);
> +}
> +
> +static struct stm_timer *ced_to_stm(struct clock_event_device *ced)
> +{
> +        struct stm_clockevent *sce = ced_to_sced(ced);
> +
> +        return container_of(sce, struct stm_timer, sce);
> +}
> +
> +static u64 notrace nxp_stm_read_sched_clock(void)
> +{
> +	return readl(stm_sched_clock->base + STM_CNT);
> +}
> +
> +static u32 nxp_stm_clocksource_getcnt(struct stm_timer *stm_timer)
> +{
> +	return readl(stm_timer->base + STM_CNT);
> +}
> +
> +static void nxp_stm_clocksource_setcnt(struct stm_timer *stm_timer, u32 cnt)
> +{
> +	writel(cnt, stm_timer->base + STM_CNT);
> +}
> +
> +static u64 nxp_stm_clocksource_read(struct clocksource *cs)
> +{
> +	struct stm_timer *stm_timer = cs_to_stm(cs);
> +
> +	return (u64)nxp_stm_clocksource_getcnt(stm_timer);
> +}
> +
> +static int nxp_stm_clocksource_enable(struct clocksource *cs)
> +{
> +	struct stm_timer *stm_timer = cs_to_stm(cs);
> +	u32 reg;
> +
> +	reg = readl(stm_timer->base + STM_CR);
> +	reg &= ~STM_CR_CPS_MASK;
> +	reg |= STM_ENABLE_MASK;
> +
> +	writel(reg, stm_timer->base + STM_CR);
> +
> +	return 0;
> +}
> +
> +static void nxp_stm_clocksource_disable(struct clocksource *cs)
> +{
> +	struct stm_timer *stm_timer = cs_to_stm(cs);
> +	u32 reg;
> +
> +	reg = readl(stm_timer->base + STM_CR);
> +	reg &= ~(STM_CR_CPS_MASK | STM_ENABLE_MASK);
> +
> +	writel(reg, stm_timer->base + STM_CR);
> +}
> +
> +static void nxp_stm_clocksource_suspend(struct clocksource *cs)
> +{
> +	struct stm_timer *stm_timer = cs_to_stm(cs);
> +
> +	nxp_stm_clocksource_disable(cs);
> +	stm_timer->scs.counter = nxp_stm_clocksource_getcnt(stm_timer);
> +}
> +
> +static void nxp_stm_clocksource_resume(struct clocksource *cs)
> +{
> +	struct stm_timer *stm_timer = cs_to_stm(cs);
> +
> +	nxp_stm_clocksource_setcnt(stm_timer, stm_timer->scs.counter);
> +	nxp_stm_clocksource_enable(cs);
> +}
> +
> +static int __init nxp_stm_clocksource_init(struct device *dev, const char *name,
> +					   void __iomem *base, struct clk *clk)
> +{
> +	struct stm_timer *stm_timer;
> +	int ret;
> +
> +	stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
> +	if (!stm_timer)
> +		return -ENOMEM;
> +
> +	stm_timer->base = base;
> +	stm_timer->rate = clk_get_rate(clk);
> +
> +	stm_timer->scs.cs.name = name;
> +	stm_timer->scs.cs.rating = 460;
> +	stm_timer->scs.cs.read = nxp_stm_clocksource_read;
> +	stm_timer->scs.cs.enable = nxp_stm_clocksource_enable;
> +	stm_timer->scs.cs.disable = nxp_stm_clocksource_disable;
> +	stm_timer->scs.cs.suspend = nxp_stm_clocksource_suspend;
> +	stm_timer->scs.cs.resume = nxp_stm_clocksource_resume;
> +	stm_timer->scs.cs.mask = CLOCKSOURCE_MASK(32);
> +	stm_timer->scs.cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
> +
> +	ret = clocksource_register_hz(&stm_timer->scs.cs, stm_timer->rate);
> +	if (ret)
> +		return ret;

clocksource_unregister during remove callback for cleanup?

> +
> +	stm_sched_clock = stm_timer;
> +
> +	sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
> +
> +	dev_set_drvdata(dev, stm_timer);

Is this used?

> +
> +	dev_dbg(dev, "Registered clocksource %s\n", name);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_clockevent_read_counter(struct stm_timer *stm_timer)
> +{
> +	return readl(stm_timer->base + STM_CNT);
> +}
> +
> +static void nxp_stm_clockevent_disable(struct stm_timer *stm_timer)
> +{
> +	/*
> +	 * The counter is shared between channels and will continue to
> +	 * be incremented. If STM_CMP value is too small, the next event can
> +	 * be lost if we don't disable the entire module.
> +	 * Disabling the entire module, makes STM not suitable as clocksource.
> +	 */
> +	writel(0, stm_timer->base + STM_CR);
> +	writel(0, stm_timer->base + STM_CHANNEL(0) + STM_CCR);> +}
> +
> +static void nxp_stm_clockevent_enable(struct stm_timer *stm_timer)
> +{
> +	u32 reg = readl(stm_timer->base + STM_CR);
> +
> +	reg &= ~STM_CR_CPS_MASK;
> +	reg |= STM_ENABLE_MASK;
> +
> +	writel(reg, stm_timer->base + STM_CR);
> +	writel(STM_CCR_CEN, stm_timer->base + STM_CHANNEL(0) + STM_CCR);
> +}
> +
> +static void nxp_stm_clockevent_irq_clr(struct stm_timer *stm_timer)
> +{
> +	/* Clear the interrupt */
> +	writel(STM_CIR_CIF, stm_timer->base + STM_CHANNEL(0) + STM_CIR);
> +}
> +
> +static void nxp_stm_clockevent_irq_ack(struct stm_timer *stm_timer)
> +{
> +	u32 val;
> +
> +	nxp_stm_clockevent_irq_clr(stm_timer);
> +
> +	/*
> +	 * Update STM_CMP value using the counter value
> +	 */
> +	val = nxp_stm_clockevent_read_counter(stm_timer) + stm_timer->sce.delta;
> +
> +	writel(val, stm_timer->base + STM_CHANNEL(0) + STM_CMP);
> +}
> +
> +static irqreturn_t nxp_stm_clockevent_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *ced = dev_id;
> +	struct stm_timer *stm_timer = ced_to_stm(ced);
> +
> +	nxp_stm_clockevent_irq_ack(stm_timer);
> +
> +	/*
> +	 * stm hardware doesn't support oneshot, it will generate an
> +	 * interrupt and start the counter again so software need to
> +	 * disable the timer to stop the counter loop in ONESHOT mode.
> +	 */
> +	if (likely(clockevent_state_oneshot(ced)))
> +		nxp_stm_clockevent_disable(stm_timer);
> +
> +	ced->event_handler(ced);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int nxp_stm_clockevent_shutdown(struct clock_event_device *ced)
> +{
> +	struct stm_timer *stm_timer = ced_to_stm(ced);
> +
> +	nxp_stm_clockevent_disable(stm_timer);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_event_device *ced)
> +{
> +	struct stm_timer *stm_timer = ced_to_stm(ced);
> +	u32 val;
> +
> +	nxp_stm_clockevent_disable(stm_timer);

While examining the code base, I came across the
drivers/clocksource/timer-imx-gpt.c file, specifically the
mx1_2_set_next_event function, which includes a protection against
missing events. Using a similar approach would allow us to keep the STM
module enabled while only altering the channel's register state. This
risk can also be mitigated by adjusting min_delta_ns based on tick
frequency.

> +
> +	stm_timer->sce.delta = delta;
> +
> +	val = nxp_stm_clockevent_read_counter(stm_timer) + delta;
> +
> +	writel(val, stm_timer->base + STM_CHANNEL(0) + STM_CMP);
> +
> +	nxp_stm_clockevent_enable(stm_timer);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_clockevent_set_periodic(struct clock_event_device *ced)
> +{
> +	struct stm_timer *stm_timer = ced_to_stm(ced);
> +
> +        return nxp_stm_clockevent_set_next_event(stm_timer->rate, ced);
> +}
> +
> +static int __init nxp_stm_clockevent_broadcast_init(struct device *dev, const char *name, void __iomem *base,
> +						    int irq, struct clk *clk)
> +{
> +	struct stm_timer *stm_timer;
> +	int ret;
> +
> +	stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
> +	if (!stm_timer)
> +		return -ENOMEM;
> +
> +	stm_timer->base = base;
> +	stm_timer->rate = clk_get_rate(clk);
> +
> +	stm_timer->sce.ced.name = name;
> +	stm_timer->sce.ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +	stm_timer->sce.ced.set_state_shutdown = nxp_stm_clockevent_shutdown;
> +	stm_timer->sce.ced.set_state_periodic = nxp_stm_clockevent_set_periodic;
> +	stm_timer->sce.ced.set_next_event = nxp_stm_clockevent_set_next_event;
> +	stm_timer->sce.ced.cpumask = cpu_possible_mask;
> +	stm_timer->sce.ced.rating = 460;
> +	stm_timer->sce.ced.irq = irq;
> +
> +	nxp_stm_clockevent_irq_clr(stm_timer);
> +
> +	ret = request_irq(irq, nxp_stm_clockevent_interrupt,
> +			  IRQF_TIMER | IRQF_NOBALANCING, name, &stm_timer->sce.ced);
> +	if (ret) {
> +		dev_err(dev, "Unable to allocate interrupt line: %d\n", ret);
> +		return ret;
> +	}
> +
> +	clockevents_config_and_register(&stm_timer->sce.ced, stm_timer->rate, 1, 0xffffffff);
> +
> +	dev_dbg(dev, "Registered broadcast clockevent %s irq=%d\n", name, irq);
> +
> +	return 0;
> +}
> +
> +static int __init nxp_stm_clockevent_per_cpu_init(struct device *dev, const char *name, void __iomem *base,
> +						  int irq, struct clk *clk, int cpu)
> +{

This function duplicates a significant portion of the previous one. To
avoid code duplication, it would be beneficial to extract the common
part into a dedicated function.

> +	struct stm_timer *stm_timer;
> +	int ret;
> +
> +	stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
> +	if (!stm_timer)
> +		return -ENOMEM;
> +
> +	stm_timer->base = base;
> +	stm_timer->rate = clk_get_rate(clk);
> +
> +	stm_timer->sce.ced.name = name;
> +	stm_timer->sce.ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +	stm_timer->sce.ced.set_state_shutdown = nxp_stm_clockevent_shutdown;
> +	stm_timer->sce.ced.set_state_periodic = nxp_stm_clockevent_set_periodic;
> +	stm_timer->sce.ced.set_next_event = nxp_stm_clockevent_set_next_event;
> +	stm_timer->sce.ced.cpumask = cpumask_of(cpu);
> +	stm_timer->sce.ced.rating = 460;
> +	stm_timer->sce.ced.irq = irq;
> +
> +	nxp_stm_clockevent_irq_clr(stm_timer);
> +
> +	ret = request_irq(irq, nxp_stm_clockevent_interrupt,
> +			  IRQF_TIMER | IRQF_NOBALANCING, name, &stm_timer->sce.ced);

devm_request_irq instead ?

> +	if (ret) {
> +		dev_err(dev, "Unable to allocate interrupt line: %d\n", ret);
> +		return ret;
> +	}
> +
> +	per_cpu(stm_timers, cpu) = stm_timer;
> +
> +	dev_dbg(dev, "Initialized per cpu clockevent name=%s, irq=%d, cpu=%d\n", name, irq, cpu);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
> +{
> +	struct stm_timer *stm_timer = per_cpu(stm_timers, cpu);
> +	int ret;
> +
> +	if (WARN_ON(!stm_timer))
> +		return -EFAULT;
> +
> +	ret = irq_force_affinity(stm_timer->sce.ced.irq, cpumask_of(cpu));
> +	if (ret)
> +		return ret;
> +
> +	clockevents_config_and_register(&stm_timer->sce.ced, stm_timer->rate, 1, 0xffffffff);
> +
> +	return 0;
> +}
> +
> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct stm_instances *stm_instances;
> +	const char *name = of_node_full_name(np);
> +	void __iomem *base;
> +	int irq, ret;
> +	struct clk *clk;
> +
> +	stm_instances = (typeof(stm_instances))of_device_get_match_data(dev);
> +	if (!stm_instances) {
> +		dev_err(dev, "No STM instances associated with a cpu");
> +		return -EINVAL;
> +	}
> +
> +	base = devm_of_iomap(dev, np, 0, NULL);
> +	if (IS_ERR(base)) {
> +		dev_err(dev, "Failed to iomap %pOFn\n", np);
> +		return PTR_ERR(base);
> +	}
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq <= 0) {
> +		dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
> +		return -EINVAL;
> +	}

From commit description:

> The first probed STM is used as a clocksource, the second will be the
> broadcast timer and the rest are used as a clockevent with the
> affinity set to a CPU.

Why is the interrupt mandatory when the node is probed as a clocksource?

> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "Clock not found\n");

Missing irq_dispose_mapping ?

> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable STM timer clock: %d\n", ret);
> +		return ret;
> +	}

devm_clk_get_enabled instead of devm_clk_get + clk_prepare_enable ?

> +
> +	if (!stm_instances->clocksource && (stm_instances->features & STM_CLKSRC)) {
> +
> +		/*
> +		 * First probed STM will be a clocksource
> +		 */
> +		ret = nxp_stm_clocksource_init(dev, name, base, clk);
> +		if (ret)
> +			return ret;
> +		stm_instances->clocksource++;
> +
> +	} else if (!stm_instances->clockevent_broadcast &&
> +		   (stm_instances->features & STM_CLKEVT_BROADCAST)) {
> +
> +		/*
> +		 * Second probed STM will be a broadcast clockevent
> +		 */
> +		ret = nxp_stm_clockevent_broadcast_init(dev, name, base, irq, clk);
> +		if (ret)
> +			return ret;
> +		stm_instances->clockevent_broadcast++;
> +
> +	} else if (stm_instances->clockevent_per_cpu < num_possible_cpus() &&
> +		   (stm_instances->features & STM_CLKEVT_PER_CPU)) {
> +
> +		/*
> +		 * Next probed STM will be a per CPU clockevent, until
> +		 * we probe as much as we have CPUs available on the
> +		 * system, we do a partial initialization
> +		 */
> +		ret = nxp_stm_clockevent_per_cpu_init(dev, name, base, irq, clk,
> +						      stm_instances->clockevent_per_cpu);
> +		if (ret)
> +			return ret;
> +
> +		stm_instances->clockevent_per_cpu++;
> +
> +		/*
> +		 * The number of probed STM for per CPU clockevent is
> +		 * equal to the number of available CPUs on the
> +		 * system. We install the cpu hotplug to finish the
> +		 * initialization by registering the clockevents
> +		 */
> +		if (stm_instances->clockevent_per_cpu == num_possible_cpus()) {
> +			ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "STM timer:starting",
> +						nxp_stm_clockevent_starting_cpu, NULL);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct stm_instances s32g_stm_instances = { .features = STM_CLKSRC | STM_CLKEVT_PER_CPU };
> +
> +static const struct of_device_id nxp_stm_of_match[] = {
> +	{ .compatible = "nxp,s32g2-stm", &s32g_stm_instances },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
> +
> +static struct platform_driver nxp_stm_probe = {
> +	.probe	= nxp_stm_timer_probe,
> +	.driver	= {
> +		.name = "nxp-stm",
> +		.of_match_table = of_match_ptr(nxp_stm_of_match),
> +	},
> +};
> +module_platform_driver(nxp_stm_probe);
> +
> +MODULE_DESCRIPTION("NXP System Timer Module driver");
> +MODULE_LICENSE("GPL");

-- 
Regards,
Ghennadi


