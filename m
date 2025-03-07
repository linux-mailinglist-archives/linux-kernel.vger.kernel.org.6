Return-Path: <linux-kernel+bounces-550534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42156A560E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637DE176297
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10248195962;
	Fri,  7 Mar 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yulqrtdy"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0819006F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329150; cv=fail; b=E1kX7t1N48b9GmTTp67rxTYgnZvcB9iNHuLsXcBH7nZeIfbAMw/Aiz6gDC0kWeVIxv8n79MZkA1BwX3phkMEBdczECr+OZzD8x3qY1jOkqQS2l65uT00HLb0G1HxS8xuaEOhCMAaeVwdnNDuAelnQTWfiNNb5lVJjtqllBpS3OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329150; c=relaxed/simple;
	bh=CEcJJ7OyTHUIJpHCuB2sHOPmWA+RQBRlMRCRjSNDexA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EuOtlK9Z5g3OnWDfQLSKO2J4uyfrsNOEgtR2/p0U9xz+uuA3xqc79qXOi2z8c7yzro4luxvVNsxpJwEjRkZHrwLSrREP25symWhv7N+AuWMrWkIGTau9Lq0lpHhR+U7hE1FWplt7s/Phi7RdclEaFdEi4IF8GrlTmSDwAjVoCwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yulqrtdy; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YK8UZYjfmEOiUla2KYMeZO7X2vJGHPMDq79lLOBuvOIWAUXiaFL6TNP+pL4oGPJwDFaazVgBFTbdIo3z9cTA8LAP2aM1UJJ1rRDXQ4ONyHp5GNej6ikgUQLP0MQpeq41NVpacl0WOVc1gz1Dh22XkHeABCA2xV5vKeYgSCrft6li66DKE08MVz9eaMDQQiR9Kk81SZnZCa1/u4YhrggnuvUfBbcmzt/splfBHQ3E2ATSk8DdqQrMzpMq/7HZhauWHS7Lyy4PvjIqAONFDYdc7RUpbOYJSAQYJoK4nxrp5PaiO4sIUnhuHzt2oMK6/1n6OGRbQzkmfQwvgP4jyt7P/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry20+r04sphzoiaaJTb3EB2Hrifw18CbXXy2cx7GHzI=;
 b=MA1T2r/BTGpGckV04jJZOoKq1gUXC+2uhFPMH5qUx+/CUVf+eoZPifrX4eGIgV5Hul7UX2eKDzk+xFJfU7etsfil3iRoFZNNE1Hsi7Asz4Q3iQh+LamSNOCOtx5X2H7AtRUYboaOTSBmT8dzHSExE2andgOzFFFCdiIUGvRPDYdSA//9ZsIzic2RhP7a3vK236Cp40joO1Xitdf6y5BGct6oFjiPweWCLFGKT0t9TG0x8ACVI1qFiwBqsqQ8NcWMPUctpNt9vki43xulwl6zjoSpEOkVdoARaV86pdoy6xO1J751NXbxMLTzyD5MrH6Rxe33yOoLYICFdyP7b44iPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry20+r04sphzoiaaJTb3EB2Hrifw18CbXXy2cx7GHzI=;
 b=Yulqrtdy9MKwh6XeZauVzniVKcPa++Em9WC5Q6EHLuJjNIOqruFes/nadwV+BvRS2V5zdQLq9jbcP05PTAy8oNPThv88DUDyBEQrwVTIWAL8QuqhsjwHooVo6HbnpmI/qahu8Tns/IRVDQpTX5Yq1yW7o03vdS/Yebmroldkymo889EAzEaVzf31rcqQS8dqH6erZOFE41DxpUS6Dg29HtVIM3r1/K+JFDgrvoawvix+XgxnpKssv4nznshmWNTFtq91/ts0wgu6JV0b0nj6M7v6DEMHEPIIrRyNZl0OcoFhiAKjzDfUQr38DIH7rKjrPJjH08PzzQ+lU2erPf/oJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS5PR04MB9972.eurprd04.prod.outlook.com (2603:10a6:20b:682::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 06:32:25 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 06:32:25 +0000
Message-ID: <f8df2b5e-b005-4ada-8108-159b2b94a72e@nxp.com>
Date: Fri, 7 Mar 2025 14:33:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/bridge: fsl-ldb: make warning message more
 informative
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250306-drm-two-ldb-improvements-v1-0-f139d768b92c@bootlin.com>
 <20250306-drm-two-ldb-improvements-v1-2-f139d768b92c@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20250306-drm-two-ldb-improvements-v1-2-f139d768b92c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS5PR04MB9972:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c37c6f8-68c4-4d8d-62e0-08dd5d41d2dd
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WHdIM0d3YmJSNXg3VTQ1RVk3R21YQ1VBTzZXWHIxUnB3NTMwZnF1UFpaRFVH?=
 =?utf-8?B?WCtRbzlDckMwbzIxSEg5MVFqV2RFbFdTR2FheU5UdXhvVGM3cmJMRVl4US9I?=
 =?utf-8?B?TUlQQ2c0VDlacUlhOTFKLzRyeHJvZUFzd1JIa2JSRzhLamhTQnA4dVBrbXUz?=
 =?utf-8?B?NVo4OW0yV21hclI4ekRib0dIVlpyMTUvMUZpeGxOOG1GV0oyeXpHK2prNThr?=
 =?utf-8?B?N1VrelRxT0hDVE81Q1BvUmZWQ3cvenlESXlpRmVpQU5taFIvdjE0U3Y4Y0Q3?=
 =?utf-8?B?NzQvenUyVWxjRFczMURZaWdmbmIzemZRdmhRcVU2bFplRG8vTWNYZHVuRnB1?=
 =?utf-8?B?dUF2TGdwLzBMakFDeUt3MEZHMk9xaUZZVk9IbnpsZjhLdVkxd1d4aDU1SlVh?=
 =?utf-8?B?ejJtVjRjeGE4VDNvWVdDQVRFVHYrcERLUnU2OGhmMnZlRmxLRG5OVFhyNE53?=
 =?utf-8?B?RnRWQlJFUnVJSUlid3VSeFZsSzNuT2dTcitOYkZpcU1DcGpOSlcrUkllVHhu?=
 =?utf-8?B?YmZTaDNHUnBXbSt3aVNDZWdnZW92MU90WndqVjhCdjF0SmdqMTEyeWpBY2Rx?=
 =?utf-8?B?S29wUjJNNjBqRlZUcWYwakdWN2sxenUyZi9mMjErb2RtTkt3OEFnTTNuSmwz?=
 =?utf-8?B?V2RIQnhZZzFXNmxuSVJJNUVza0ljN3p3OEFRckFmY2NpcXR4ejBHRkpIQUxq?=
 =?utf-8?B?b3JkN2RkOXZ5dWxsZWtYcGIzWXpWZDZZQXU5VkZra0hGdHRzR0VGOGREMTJm?=
 =?utf-8?B?WEEwK3M4WTdHMHI3eE5MZys4M1d4ZUZ2ZjdrYWRXaHNoZDN1Ukk0NkNVNGtn?=
 =?utf-8?B?LzlLRFVQTkc1RldYT0kxR2wrKzZ5VW9rcHN2bUYvd0EycE5DKzJSeGROa3Rp?=
 =?utf-8?B?Ui82TkJjZDB6UWFsRnBmR2JsVlJKa0s0ZXJIUGJESmtEblk1Wlgydm1VdnA5?=
 =?utf-8?B?Z3BQVUMzOUtEbGhvY0FDWkxiL1RyeEt4amZienFBVXNWVHVKVnlkSnlhUTZ5?=
 =?utf-8?B?SzVDSEs4VE5vOHJWYmp6OTVyRTBpNVN5aEVEaExlZ0EwdTU2UndBeENtbVpZ?=
 =?utf-8?B?S0lWMDBvZ3dxVi9OZGJuaFc4V1JKdmQrYUwrTUdHNTdSOUNKOWMxUmpDRWtt?=
 =?utf-8?B?L3Njb2xKbjJlV0wzZExGTTNkNG9vUnZ2T3hGdWJuR3dMSnVvckN0ZStjRGU5?=
 =?utf-8?B?OCtyY2Nzekt0MGdlWDBMditwVjRLVDdPOWxWbnJpdDFTc2VoSUxiUy96QzRj?=
 =?utf-8?B?YU1tWkZqQ2V6aG9WaDhvYVE5ZzRmQ1FsSzhWcitybkl1WHk1NFJSdk1YSUVo?=
 =?utf-8?B?OEVia3dPdHpnd3hsbTkyWmoyU0dxaFFSdWlIWWdiUUFjQmZ5MW8yN2JWU2FG?=
 =?utf-8?B?QndQM0J6aUVWdU5KbGl4US9EWlQzcWtlaTJ5UVBmdHlJRmU5WmRHdkg2NGN1?=
 =?utf-8?B?eE05R20xVUVpSmhzSnhoUmh4YlNlc0N5MjAyNmZjL0NRVFlWZG1WejEyU21p?=
 =?utf-8?B?b0pQRHowRm1hMXgrUjJTUHl0VW5ITUJkUXByazRRcnY0YktXdWpDb09aaGFj?=
 =?utf-8?B?ckk4bWY3Rlgvak9seHRvZ2EwWnhrTlhYWU9LamU5anJkZk5Gck1FODl3SmhJ?=
 =?utf-8?B?TnJWRWt2b2kwb05lYTVVdTlpcnNzTFVLeDhzeXZjRGQwWGtiSk41Vmpwbld5?=
 =?utf-8?B?c3duejRCSzJsSkVXZ21TV3ZhTzdvTGIvajhzdFgvdEpzbFNlNElBNDZLYXN3?=
 =?utf-8?B?V3ZiRVB1V1FGOWJ1Y3g3aUhDN1VJd0g3cWg5bzZkQ1djVzY2RFlwYzJETHpo?=
 =?utf-8?B?SzlKb2phTkYvM0JUQ3duUms4NTdxRTVnT1VJZ0c5bW9HOWgwM1owYXZDSzda?=
 =?utf-8?B?M3N4NGRsUjJGTWMxNGEzcTI5REVxazdCWGxMMUVWeml3MEE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UW1PWVVoN21HOVB5TzZFdEZ4RVhucHZqcGNNUVpwM0hxNkhSVDc3U2RBUDlw?=
 =?utf-8?B?UkxiYjQrZDJrbFNtQ1JzVXRGZEZ1bmFmdUE4RUZPZnJEZ1NOKy9VdkludE56?=
 =?utf-8?B?SE5sV21SZTk5MU51RmJtNVRGWnNJMmovNDF3WFdGc24zYWxGY3ltNHpabGdI?=
 =?utf-8?B?c1FPalM4bjhjWlNMa25jeUx1U1F2NUVRc1lMNGlKL2ZGdEI0UWZGUkdneUIr?=
 =?utf-8?B?Zm5YZTJIQkhkRlJLUUpVbGNKaU5EcUljbGtxVWVnT0N0MlVIa2lYWC85eVlR?=
 =?utf-8?B?cU10aHdkbVM0dGkvSEVIYjQ0aGxZOUJLTU1CRnVNUFpWSGZoZEt6S04yeE5U?=
 =?utf-8?B?NDIrZGUzWVUvbnhnb1VsU1lGWmVacjhPdVRPQi8xaFlNS2hyY1BYMlJBeERM?=
 =?utf-8?B?d21vYkhrSU9rNkxwQWNRem1pSnZrTkx1VGtMVEVISzhOZml1Vk0zblROUkRu?=
 =?utf-8?B?cCtxbTFIU3VLMjdkd0JzZkdUczZBOEJCTDBQZWFFWjlxK1N4L1h3UUl6K1gx?=
 =?utf-8?B?c0Y1WjBXR3VHQW12cTJLYUp1ZzZ1RzNoK09lajVuTmtmWTNEdURXaGZnV0dm?=
 =?utf-8?B?bW9BN0RDRU41ZDFRaTBTb3h0MkZreXRmNFZZZTdvU1BPVWx6U3lNVkdVOWgr?=
 =?utf-8?B?RHlNRHY0cHlGNGZuakFjV2hrL0d1aTRCNGxXcEMrQndpa3ZzZW9PQktZc2NM?=
 =?utf-8?B?UGx1WGNncGRxeFBjK0V1TFFTVW9ZVmRKNkxmaFBJVnB5QUNrcm5KNGVoeXg3?=
 =?utf-8?B?ZjFRbG9nL1BJWmxBWnUwQkhvaXZHb1pYbEpjSjg5SmhMbmxJdjQzckZTVmor?=
 =?utf-8?B?MjY5VVY2aG5LYnFYMmRNWmdkYU5uM0FYT0ZuemY0VFBRRERaeDhBSkd2N09a?=
 =?utf-8?B?czBmNXNnVVcxVUpMZzlVY0RuNWpxUW5VRFZ3TDJ6UlNWeHd4eW5VemFScThr?=
 =?utf-8?B?emQ5RXBhYWtlK1B4Ung2djZGakdoU21lY3hZNTNUaGkxd3IwMDhobkNURitN?=
 =?utf-8?B?YU1weWloVE1jWDJVS3ZJQXpRSlJXU0Z2dTh0SG9aRzlmaHNWbjdwMENBNFNN?=
 =?utf-8?B?aXpDNFZzL0pTTkhHVTdpODZiUEFNemlqNWk1ZTJpdHhxMWFQSVRha1NTU1FZ?=
 =?utf-8?B?WUo3bUZJeTBGUWZueEtZNkMrNXBRamNDai9BVUtEQWV4NFpMZm5aR1JLdEpr?=
 =?utf-8?B?NWZUck5XdUVwZHZxRzM4VlVkdC9VQlBLcEkxWm1UMCtOclUvZHBCNGRnNXVk?=
 =?utf-8?B?eHZrMnJqSlFFcjUvbTk2Z2xxQytSOCtFb1ZjTnUySDkxR084TWpPYnVSMjlN?=
 =?utf-8?B?OEM0OHJaMEdvYWhYV2dUa21YckdsU0VRZUlJTjdmdG0vQk50cHhFZlkzYkxk?=
 =?utf-8?B?VXU0Z0l3QnM5MjZBcmRPMXZIRUI0UXpWd3E2cHBLNldJZlFHcDM1enlVZEZF?=
 =?utf-8?B?RGVmNWVXeVpKcmtpRjVmSFl5MWF2WVU5c0QrcnJ3VFVSQU9rMGxzTWFjdm1r?=
 =?utf-8?B?ODM2Z1JoSUdXYWhxRjUzb00vbU5UcVY5MU5sSDY2bUpDU1M1VWhUdkN0ZGd6?=
 =?utf-8?B?dGxHMEtxTWJsYm5PN0VHQlhCQmZPSjRQbjhvVFBqUmhXbDBWMmdxWk1GZmZS?=
 =?utf-8?B?Z3NUUFB4RU9odkE5VXlyR1RxS21IeStKVFA0Tkw1cmRuVE9XR2NzQXFsaE1T?=
 =?utf-8?B?OTJ2RS9mRkVCTUtYSVZhZWRaSEVEbURTNk4vMTBHSzNoK2RQbEpTaEVZZkxJ?=
 =?utf-8?B?dFFLOWwwdTVSZUErUzczZU9aN1psSWhhZlF1Y01wQ0NTdGkzTGErVHJFdDlV?=
 =?utf-8?B?QmJsU0pJQzM3OVYvTDJacTFLWFNHY1J1dnFrT21SNE1CUHNIaGkwak1aRWI4?=
 =?utf-8?B?cVVsenB2Z29WWU9zUVhTSnQ1ZldUY3pCRWdxSngxYXdXaUlmZ0w2UFZDaS9r?=
 =?utf-8?B?RjZCejZvUlVYSTQ5dUhXQ1QwRFlXMFJWVjJvY1gxeDd0ZGtTZVhXWEROTnFM?=
 =?utf-8?B?QmFNaXAxcTVmdjY5cGlKYnVtUk1SMTA4TUhndWRyVnp3Sk9Ienk2d200WmNB?=
 =?utf-8?B?bGlhM0N2clZNZXlpMXcwaVRNc0lVNC90VGVCdHkreGh5aWphSFBXc042Y3Y0?=
 =?utf-8?Q?uV5c4LelxNI+UTtQvkGGnjZVS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c37c6f8-68c4-4d8d-62e0-08dd5d41d2dd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:32:25.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K24V+tQiXFILriBj3mhnfgpHPaSIdSoQ9xhAl8e2yvFtxHZGF0oTPIxdAhyX2Z7bpv0JyIwwias9gkDG2Y228w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9972

On 03/07/2025, Luca Ceresoli wrote:
> This warning notifies a clock was set to an inaccurate value. Modify the
> string to also show the clock name.
> 
> While doing that also rewrap the entire function call.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/fsl-ldb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index 0fc8a14fd80062248a43b8b93272101a7ca6158a..c7c899a9644bb827845fb3fe96a9695d79a91474 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -181,9 +181,9 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
>  
>  	configured_link_freq = clk_get_rate(fsl_ldb->clk);
>  	if (configured_link_freq != requested_link_freq)
> -		dev_warn(fsl_ldb->dev, "Configured LDB clock (%lu Hz) does not match requested LVDS clock: %lu Hz\n",
> -			 configured_link_freq,
> -			 requested_link_freq);
> +		dev_warn(fsl_ldb->dev,
> +			 "Configured %pC clock (%lu Hz) does not match requested LVDS clock: %lu Hz\n",
> +			 fsl_ldb->clk, configured_link_freq, requested_link_freq);

Though this slightly changes the warning message userspace sees, I guess it is
acceptable.

Does it make sense to s/%pC/%pCn/ so that the clock name is printed in lower
case instead of upper case, since it seems that all i.MX specific clock names
are in lower case?

>  
>  	clk_prepare_enable(fsl_ldb->clk);
>  
> 

-- 
Regards,
Liu Ying

