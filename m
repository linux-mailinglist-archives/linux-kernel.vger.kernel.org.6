Return-Path: <linux-kernel+bounces-173980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95B8C089E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD471F233C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C43376FC;
	Thu,  9 May 2024 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lmunT7RV"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5283B185;
	Thu,  9 May 2024 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215551; cv=fail; b=eYyQou6CmQ1zKkNDBqUiD5VO+4IGo0eHtj9gDWK8WkyqB9dOied9obE+BgTom4aaT17iJ83IWFl0qA/9GdZ/7iBG5K44mUX1YFFEb+lTv9mpJEaJ8k38+8LtBE1QGE0ItySG8LzmkWle3c5pYrkNmaOcQI2pmxX6PCeDqQ70F8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215551; c=relaxed/simple;
	bh=TbAVnlhIacHNb+5te5cwwkee1XS7vLG8ShCdgPJW6LE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nCKl1OLHRht29ZIpaxSKvfoasZMpxyb+ryMQsfdPq8I/b7JlBpNajKxmOJvFoaQs9aVbxWU2V2XAkwTxc2uAO2gpLsU5lDWZM+6OC+ElLonAd3bphucpvDHAQBoV3whyYeVux3tyKc9PO1Iwy+7RYkaKLUbZbYRghK4TcLxj6PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lmunT7RV; arc=fail smtp.client-ip=40.107.7.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcM2L0nMvptl7U0ikkhnCgsIO8MPxt4NEZ/2tqfwlQvFpSwcUManGtLvcSF6+It7H8XnOE8yuwvYtvInEqmNtmTgfIbU9rJqxFdA+EEI1NccLgguWPPv9MiFVVIb4ZyPiPd01GHdiJs0gmzn2xNIfO7pX+27Rd6mtXhFO1Z4Pu/4JZ+53/vhKncuNWRXX9+yxWaNXekYuiAIZV+A8lx9URiyd7bADMt5jEavuIeKFcPq3dQAi1Hac29pCeb9yOcQayG5I12XX9qctZFpv+hDlgu7oTtawrw7ac1erEnLAoqHhGt2EAn61KnVufRVa4ibz3YTwRJjEhEqiTk/23vmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84OCHnyjBZQ/qydfQvDQ7XzMxmE+HugHhLxeeVBJ+8s=;
 b=KMMTNHp0vHiBqI9JRvtRX8Bpby+2E/Ha4Y0+kjNx2WEMk6gZA35H//9h2HXmqqAbXOwOmZb8oEcJE15MJgVutyHG/vbcztRaWB4i701YHLR+7bQHur2ZUI9EYOUS3N7bfOtqmuvZbkTWe5vz537q+VttWmkMnZUpkL3V8DuqQJ0+DxSuqAONRr2WS+miIUdnL9qIKccgk1/zP4sx3zg6S/sekgjnJ7n0kmN+HgnIFvdXBaoJFF43rUe2l8DiTW1HVHFjtYrFKcGEdMVljCBVR+/FaKOBswQlTZTO6JNOBkgCYKXlyxlQAaWB1enW8F6nlLASwVab+pYpc5AxWbTVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84OCHnyjBZQ/qydfQvDQ7XzMxmE+HugHhLxeeVBJ+8s=;
 b=lmunT7RVmZ0ycuwsxbCAUtZAZuUIfp4+sugGpgRskyP5rpRT3cwAHAgP4MRCt4c1FHhUicAG4hTlnSRc1vZiGde+jFC0QicHKbpxFbPv+/RRnJFEKngjvOxWnHFXJQzHmHDw7ZHoRI4B9sgmVjLGxOQrzZ0VrEAfRj0OeoO+NQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 00:45:40 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:45:40 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 09 May 2024 02:45:35 +0200
Subject: [PATCH 4/4] arm64: dts: imx8q: Add node for Security Violation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-secvio-v1-4-90fbe2baeda2@nxp.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
In-Reply-To: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Franck LENORMAND <franck.lenormand@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Varun Sethi <V.Sethi@nxp.com>, Silvano Di Ninno <silvano.dininno@nxp.com>, 
 Pankaj Gupta <pankaj.gupta@nxp.com>, frank.li@nxp.com, 
 daniel.baluta@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AS4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::9) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9358:EE_|AM9PR04MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 131c888a-dbbd-40cf-89fb-08dc6fc1597b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|52116005|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmRMSlBwNVdrY2tLbjR5K0dUMFNPZVNCdmxsaW52bG1ISUw1blJOaGV4Z2pK?=
 =?utf-8?B?MlBhNXNHME5yTG1FaytJdW5qM2JlUDVGUHA1emRpMytWSFpYRmpqaUxGVEpX?=
 =?utf-8?B?S1kxQVRTMitiOHE0eVNIcnBENjM3aU9OMWpnTjRxSGl0Ky9STFN2VWF5dXVr?=
 =?utf-8?B?RXdNdW4rTnV2Z2VjU1VrajF4NVRkUTlEZmI5ZVFETi9leWFneFdQZjVTN1Zh?=
 =?utf-8?B?TDF6OFFEUWlyd1plQ2dTTVNFNmd1OCtHZkozcnJ4V1pJZllIVjcrOTVwOG56?=
 =?utf-8?B?Zm14VENHUXdmU29Iajk1dWFwbUV5TTYzQ1l1NUlKa053cFVWZDdqNU9pdVZ6?=
 =?utf-8?B?VFlKT1VxWkNxWGcrT1BvNUsxU2M0ZVJNWGdjL2JFdGRrODlUL0d6OU9ibmhF?=
 =?utf-8?B?bTkwdW5sTEJHejcrWnBTOTdUVllaREx1Yml4eXVLTHF5a0Nkem5zK0hZVnVr?=
 =?utf-8?B?S2tHRWpJd1JQZy90UnlYTitVckl1ZkFqSnYySkYrVXdIZThSckN2ZzBmMVBT?=
 =?utf-8?B?TG5PdXRLU2hRSmU1Q2ZNRmZMOG54TDY1ZldiNGU0djNLQmJIRHFET1UxNGxI?=
 =?utf-8?B?Z1QxTkQ1SHpsYWljUjhPNEJhQitvMjVPcnF4WEJpc2Fwb090ZGl0OXZ3djF3?=
 =?utf-8?B?ZEREZnZ3VzJBV0ExWkREMFRkVE5kRmxVRWtsUjVoOFZSNkVpNmlXYlV2bURu?=
 =?utf-8?B?Vmh6TkpTL2txVk9sVzY3Y2hvelFpckZlaFlucGp5VFNXRldIM0NpR1pmZHRp?=
 =?utf-8?B?VWhFRTZ1cGJUTysyOWcyQ0I1TFpxVXIvR2ZiRER0N2hUQ3A1NENGQ0lGNDg3?=
 =?utf-8?B?bE5GbitmaGtaRG5hSGVxcEFhUVVtQ2IxN3o3Y3ZoRkVPY1NMVXM2WG9ieFll?=
 =?utf-8?B?M3NPQTNyM29kMHBMNkJ3WkhNMjhyZnJWWXBidW5QSEVCeVFYMVBrTGVsZUE0?=
 =?utf-8?B?OWZNUHljLy9jVGxrbXBvSGJVTy9OVTMzOXUzZ0Vycm1EUkR6bXNqT3RYSGhX?=
 =?utf-8?B?RmRtb0tEaUp1d0lyc2dDZXhvdUpkUUJJNzN5ZzhodEZzQkJ0V2swc3RUMFl2?=
 =?utf-8?B?QXpDRTNpNWZzdTVFZHl6cXk1NmVMeWR2Sk01ZlVkWVVNNjNVcm9IMHBhLytw?=
 =?utf-8?B?WDRYaUZDK1FnOWtlaFJkbDJDTUx6NTRnelY4T1VLS2dhTTFSZ3RXMVF0b0gx?=
 =?utf-8?B?MTJQVG9la3k5eEJtN3N1R3BuTlgyeXFCNFIwbFhTRE9TcURObjh3R1l1TDA4?=
 =?utf-8?B?elFxRCttclBCaVZmU1VZeW5iR1Jybk8vTjYvYkg0cXpwT0U4b2hmN295dkVi?=
 =?utf-8?B?Tjc4VnY5MGU4K2g2dnY4ZzFhaWw3aTJscCtBa2xVQUVZQklCQ2dMMnhFUzMw?=
 =?utf-8?B?T0lXMnhrbm04MmNCY1MwNk1WbXovVHlwSEZucXJ0cE9scVBjMWYwdmlIRDJN?=
 =?utf-8?B?MGdJTnVXc0IzVitvTkcvYWVwdXRxVUJaemhXTFhVWXBaZFA0OHFpM3prVHQ2?=
 =?utf-8?B?blplOEVSdDBzSUlMcjIxbnBpa3orcTdTVXlIZEVzd2tzKyswT1NoemtLaTBX?=
 =?utf-8?B?QzhqanE2alZkMTJJMHo2WERRRXE2TzZLVXFYU2RaMHBpSUpoZDEwWTQ4Wm9X?=
 =?utf-8?B?bnF1cTd4UC8vU0d5NlhIQSthd3dWUVVDTVE1UlBDRURSZHJKb09CdXFYZWVU?=
 =?utf-8?B?RXlLaDZFVEtCSElCUDM0TjNkdG5IZEVIYy9LU0pWTktvYzJtNHhhWFRPMjF4?=
 =?utf-8?B?OXdmTU13cmExcWtZY3JwK0ZXeVBPN2J5UGZtbHRBaThjMlFxRkcwem8yRUE0?=
 =?utf-8?B?eXdHQWd2UmVXNXNmTGFHQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0FHUTJqU3BCeWtDN2t6T2JGc0RPSTl0Z2Y1Q1l5Sm9FcEF2ZnhraDhWMnY5?=
 =?utf-8?B?VC94dmZ2R1NmdTBQelNLRG1BbG1TaHBsdllxWVNGM215UmxDSnJTN2IyczRI?=
 =?utf-8?B?TmI5ZUw3aVAxaEZ3UzYrcDlkdU8vMVB6TlpwZnpjcXQyNVk5VEpJbHF0cFBZ?=
 =?utf-8?B?S1NjUmNJZ0NIWmFrSDhmamdPTFZLMitHQVgxcUZnYnRVbDZlQThsM0lWVWhQ?=
 =?utf-8?B?bS8zd2c5d3JpbzV3dVJhZmg0RENRRmtvWXpKL3dtSm9nTmhIWUY3am1pSi9w?=
 =?utf-8?B?RDBhTUdJWDhHb0F4d3pZNVlYYWIrZTVMa2JaMjFGNUh5aTNXSkN1MXdmUDlj?=
 =?utf-8?B?YjZSZWpJcGxLUk5KbWx4dkRFSWlocVRlTk1LalhqMGoyaFJya2s1ejR3Z3dq?=
 =?utf-8?B?SlRBdVkvUHI3TDhuTVlqL2dpSG9uZUczM1ZqbU1ZQ3FlMFZFS1UvcW8vaGo5?=
 =?utf-8?B?dk1UMjVtUHlQdkZyTjhyK3lVVEIyVU1ObnJ6SkpXN3FoZ2d1dFZ6RnVVaUs1?=
 =?utf-8?B?N3lYRCtaOW5KT2xBcUVFMUhENVVub2o1dC83cjk1cGdUTFZydmRRdnMySGFK?=
 =?utf-8?B?T29waTBjdVBMTWNqVzRUeVgrMlV6Ky96Z3NzSk9WaHNvc1k0dEJHK1oxem55?=
 =?utf-8?B?dXRkNGtlTXJlMW9GSHFPdmc2Q3YvWUQ4MmJKb25CN3dPMUwzUnI0eUFSZkt1?=
 =?utf-8?B?SGZHdUF0R0RnNWhFbm9DZVAwVFRRbUxqVTdyeVExS2FBQVY4U1RRMzRkaEli?=
 =?utf-8?B?YjVVZU9WZzB4dVFSN0xmK3J1RnFjLzJtRVpnckJQN1pSNnpPV0cwNFJMU0kv?=
 =?utf-8?B?ejAzUjcxS2Q5V0tzakg0dnFycThISVdXWUlQaW1IbjFreUhGd0tIbFZjdmdH?=
 =?utf-8?B?M1lmTFg0ZXFISnlRSXZnYitYUkluU0MzS05ZU2Fwamt0ajdoRXhqSlZCQ01z?=
 =?utf-8?B?WVBQS3NIeUJxdGRnbzA2Y0FkMDhrLzJ5VjFnU3J4cXFVVkV1dkluczRxWUZx?=
 =?utf-8?B?Yk1hcnBvOWdnZXgrajR2aTJFZktONzNuSzVZSVNBckxBQXNCN0R1YlVFRnAw?=
 =?utf-8?B?VmdPNnNPaENNRFp5MkpFcGdPRy84dUVtME9Tam55ME5kcm9kaEVNS1owTU5D?=
 =?utf-8?B?Znp6K3lVYWVUcHBFSVpvc01SVjVjaTgwVlJiVUNheWlZbUZvVkJ6ZmF1SGYv?=
 =?utf-8?B?cVRabVBzVkpOYXgyZEVUTDF1ZVVRTFRFSnByYksvZWNVTkxuMWwwMGRwSUUr?=
 =?utf-8?B?NTF5Y1lLUlg2bEptdnBXa3AvdWJQY2VVR0kzYUlIdU5PSGRPWXh1OWtiVGQv?=
 =?utf-8?B?ejBCWkZZTjVsTmtCd093TE1lOVNhRkhtUlh3emttUzNqTVZyaHlWa2Rud2Yy?=
 =?utf-8?B?cndkWE1vMXU4a293Vm4xZkxMUGpUWDgxOHBDM2IzTlg0UlJyWk8vRnEzbjEz?=
 =?utf-8?B?aXMyYjcvS2dNNVI4Rm1ER0h1ZFlScmVRS1NORi9qVlNMVWxVTTBIV3h0Y1Jl?=
 =?utf-8?B?Y1RzWFZRY0xUdisvTHAzS3liLzVML0hFSUtPaStKb3dmbTA0TnFvMmhpb1ho?=
 =?utf-8?B?TFFzU2F6UldWTWx6d2E1RGlVZlVEVkVlUDNCUU5pNU1uZFhkYVd6T2RtYXg4?=
 =?utf-8?B?YXRsbEF0eUxTVjFjRW5HTnJEdHdjcUgrNWtTcXp6WmE5T1d3bDI5RjI2R0Vo?=
 =?utf-8?B?TXdEeE9aSzUxYnRzaFdkQkVYa3hUU0FQMzBWak1mMG4rdk5yUDJodXJJWGpH?=
 =?utf-8?B?WWdaVFEzS1NZM1NRcFFucER3TDc4ZjFtbnl4a3dqaHZ3UVp4L3NBanJ2bGVD?=
 =?utf-8?B?UUpUeDJCcVh2a1RobXh5YThySWY3a3Joa3dzN0tYNkVTOUNtYiswMWdwWXRi?=
 =?utf-8?B?Nm5PODF0L3VOSS9VbUg0THVldlNMN05xRGl2NWt1UHdzNTJubkpjQkNOWk9G?=
 =?utf-8?B?Q0MyQTlsSXNZOHFNZUxpMWRVY2dDMEUwbUxpaWdnY2N2WS9DakNxa01BTEh0?=
 =?utf-8?B?VjVLa3Z6bFVGQnhCVDcwQ2Q2c3lpbEkzV2liN3EwcnN3RVE0bUtmK083a0xr?=
 =?utf-8?B?MUpRUzZONFVXbW9xTHRNR0FKVmRVbTl5a2pzWGJOalF5Yjl2cDFpTXJrTDE5?=
 =?utf-8?Q?H3242CXxwHXhk89Gi70kDYzdr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131c888a-dbbd-40cf-89fb-08dc6fc1597b
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:45:40.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZ3wj4WsMttqGyh/slNFiNt7K5gX6Rrgm83hG5ml+1VF8obc/jyCKmOW+fCdbY/ZL/JstKIzjlLw1FQ6UkQICw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273

Add secvio node definition for imx8qxp.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 0313f295de2e..09d3e11eef3f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -241,6 +241,11 @@ rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
+		secvio: secvio {
+			compatible = "fsl,imx-sc-secvio";
+			nvmem = <&ocotp>;
+		};
+
 		watchdog {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;

-- 
2.25.1


