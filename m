Return-Path: <linux-kernel+bounces-433726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49B9E5C33
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BAC1664B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96F229B0F;
	Thu,  5 Dec 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BDCxse5b"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54D227BA5;
	Thu,  5 Dec 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417513; cv=fail; b=KEG4R8yTf+B+OH0o2gSc++qQmeKSK9pFZwIKw3tbZOZ9I/YIc3EVK78KNJoT+PeauOgQhXWMdRbl+bQRF6dMBsToWV7Lyt+PW2avbiUdgzFwGd03AnxiMoJsauhJ/xLVKySZ6NiSDlEx9tZ6sjiuKFMuj5V3w/buHtOuogHHjtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417513; c=relaxed/simple;
	bh=mGGN37OWp+aduPI+3e4Y8ziQnmTHSWKE6eHA1Bzp21U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ohgq1r4rhskoDPlq4MGahAydTriCSbvtKv/FvHi4WO15xuQA+MXbi6WV2eGDtOGxv9EKt2t8HszgWQIN++1X+KdeKiQD02XoU/CdTMI6FNXe/RXseM5/iod61DFPzmNYQvqEOMcjll3J487soW28wdqQxvShzR+FQgyrDhlSmSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BDCxse5b; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB8xNoytgnCJcEJc2OyYYKvmtPLuV/1OqP/RBtetemAhHUzlNiBYdJiJ+iqKOoQMCtiECTF2SupKfIy4zUyzJZUeLl61Z7lFXar7KTGJJ+/AQyO6jHt+K+yf20wuCYDmufgqb4iEuuU3yTBIqw8Z0TXj75cA9NU06S5g9/EpJhUQzvMhq2k1FZveMmKa5kbpT3jzeC+L+NyR5KKfPHs1IZEXzFP/lvlY+lZlbSQC6kbljmIih+D5BCB21tyjNVHuxNW++FMktexs/Qe56RvCyWuTuFQART+Q79DSV6YQWOXttDb3TtDMjBWmgV5RbSRMRXzWsDREvSg7ljCJndgGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy0HT+FTy7m40dkT7/0R42A2NWHtIKcoyDetvr0QoP4=;
 b=Ue3sEXGDlb1nP7ZtO4KfCmqU4qBwKXwSVwuOnU9hJcZ5w8bnFNa/IRxJHEeKkKSqEzPO3VX6KAgI0jWk2Gdk4uLkF2PrF++6vtrZgykBEQo3jYB6BHhNbjzy0/JTPwNYFMWefw5pTsc1kgMdD+u0lvPvkeaH/9ZOK2F1k7cLnmq13OArNI0uWmuA5WCirX/kbliKrR3IXwENS2YMVMHqPZZAKwI+MPrdI1AlqN7AyN1S5+PjU4q/uAELgpjPvLAkV/vtfPQrRydUeh7Hxoq7YqGF9tzSPFMjV4R3bmxMg/hKgCdGOP/KDO962PfJ18tMvlSjBM17Gu1F1H8YroEUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy0HT+FTy7m40dkT7/0R42A2NWHtIKcoyDetvr0QoP4=;
 b=BDCxse5bnkXizwlsaffaoKritnP4SdG2n9YGcrxadDWXGVEKs98C28djetJRZPdbOYJSXV1va58jm45bpoq13gRLUnMCjkxC3OGB5+qxvgjvXK7aZQHQEp8xbtf4GaNb7wKRqkhmQVP3xNX8p2EmLPq9DYV+fgPMtypfGr0Ts6dME1E4TPZhfaHl5cmD4v2FJeBOVBUQ2N9A5XjLeAnWSodJFuq0oI/Wze+z0QpnnRedS3Fh8xjjH2ArSD8iP1IEW9dFiMhBaXQmODakcMI9f5l9RjBqhK9LIswd/y6m4o2h9gHsqRsxn8v+z1wfu2Xq2qQvCLyh5YqDTThSgKLAPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBAPR04MB7446.eurprd04.prod.outlook.com (2603:10a6:10:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 16:51:47 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 16:51:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 05 Dec 2024 11:51:13 -0500
Subject: [PATCH 5/5] arm64: dts: imx93: add pca9452 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pca9450-v1-5-aab448b74e78@nxp.com>
References: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
In-Reply-To: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733417480; l=2719;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ByZmZVMFQefEgEbYLBGLsWjBEQTR+hvttxmsOxhU1a8=;
 b=6o3DE36F1ZRWFqj5Ixp7eqKhrNzHnu5dazVfAJSFPDbPPz2V2YRKRSsHPS5oFcHLK8IOc36vm
 eKExD5fL48HB9Vn2POYlNGs+fNREdWkF8eUasBgtYMKX8RLxafOcu6a
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBAPR04MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: d131d831-caab-495e-5e23-08dd154d1b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjhJcGdPa2w1WEpPM2RxbkZ5SVEwajFzT0lsZWJteE5LQS9DM2pFRjdoNEp4?=
 =?utf-8?B?OCs4Tmsyb3Y1eXYxbDBJdE1iQUFNTDYrbFV6OFlnem9ORGxRQjE5MGNFYXlL?=
 =?utf-8?B?elJVS1UwWEFZNlBuK09qdFJzWlZWTHk2dXp0YlowVnhQL08zcUxWNG0xVHht?=
 =?utf-8?B?K0lTQmxSYXJOZ1ZHekVxZ1N5RjVYK0NuMU95NFdhRDdsMnNtckxMdWtKUmNI?=
 =?utf-8?B?ekkvV2pFZzlSaC9NR2MxTlRvNklpWUM5UDYwV2pDeXJ5dFQyR3JWK215TTRj?=
 =?utf-8?B?QSs4V2QrRm56YjQ4a2RTRHN3TDNXN0lnbmwvQlk5U3ZLVDVZL08yeklXa2xU?=
 =?utf-8?B?UEdVejJ6bDRMQnRlbXlMbkNYdVpkeHcvSk9TUkptMnk3ZWJPUExUeDcxOXdP?=
 =?utf-8?B?V2R2QWFZVWxsTGxFeFVYREh1VkFjUWJNa28vTldZUXd4bXdCS1JIMm04VFpF?=
 =?utf-8?B?YWMzTHZ4cHhuUGRQTXpwM2xIUWhOR3ZTM2NjeFpNUTJ6UWQzK0V1K05lYncz?=
 =?utf-8?B?YmZzVURYVFI5Y01MQitYeUx5NFJNUTdaNnd5cVNzYVlyZ2hHZmxCQ1Zuak9h?=
 =?utf-8?B?WlYvS25WazBUQ1YvL0FrUGdmTkZrYjZMTmVXTzR0ZkdpS2NKY2VYeWVGSWRz?=
 =?utf-8?B?aWFGSHBESGdYTURZb1IyTUxhRDBaazA4dXBDSE1uNVljNzR2U0FOUG5Jd09q?=
 =?utf-8?B?Z3FTTTMrbi8vclpFRFhKaVJGR2ZVQWg1SUFUdnR0VURmODFkY1BSNlhEZkhs?=
 =?utf-8?B?b1NYQVR0bEpoN3Z5UkIzQ1RGbjYzUkY1ZEJucUQ1dDJqWmxZQ1drYUNXamZt?=
 =?utf-8?B?K05xbmMrUW5wT1A5V1IrR09adVpROUZkMm1BV2NoZVNrb2JqOWlRdHN4anNq?=
 =?utf-8?B?YlZTZHYxUjkzcWorQkRQbEhvU1ducDlSalNUbUNCSW1PTEdYRHV3dXJjaVV5?=
 =?utf-8?B?anpTSVh6QjdsUGZxdTZoRVZzUnZyVGxLbzFVQmhsV3Fsek9WUzhqcWIwNTJa?=
 =?utf-8?B?Si9UTVFhRlBueEE3WUhGaFFCaEx0S05DZmFhSnU2d0FkZXhtb1d4RVprdHVp?=
 =?utf-8?B?SXBMSUVWRHozKzdtR3lyRVR4RWhHclNrZ0I1eXVMaTdUemRXbFU4RmJRRTFx?=
 =?utf-8?B?MmwrSGQ3amhIZXJqeWs2K0p0KzNzaU1FYzFjam1wcjBvZHN3a25XOEpUWjFM?=
 =?utf-8?B?UzNEcG5tclZmQVR2WkhZYzNSQk4vQ1ovVWJUdDUyRTcxSkxqT1JiYVR5bGpn?=
 =?utf-8?B?bzhwaEl3L3BFdkhyc3RkempYbWt1amkza3JHU2h6NitOdTZBREVCa1h1NnFJ?=
 =?utf-8?B?QmJsVkt0OTZwV1h3NmIwcG5xYnFwLzBlRDNGbGJ1ZGhRVDVZYnp1QlBaS2lU?=
 =?utf-8?B?ZTZLL21lWENVYktiQ2xRUDl0T0hWTURLLzVQTzRXZkgzeFQ5aWYvZ01vTmY4?=
 =?utf-8?B?Y2tMWndleUR4Q0RGOGF3TFFPOW9Yd3VCL29wbXNtbGozSDd3RnBDVmxoa0VG?=
 =?utf-8?B?aXdBMCtaZWRUL042cm5wOTNaNWJOaWxxNkZ6OHB1czhrMGRrVVhUSGVCQ2dr?=
 =?utf-8?B?c3lhQW05Y2FWZ0h0TEwyMEJ6R0VMN0NWU1k2S2JmL3ZuZGpwcElHV2d6N1dn?=
 =?utf-8?B?YTF6a2Q1b2pENnNNYVVHN21kS2JhWU1qNDg1LzI4T005bUorb3ZFd0FYVS9v?=
 =?utf-8?B?TU0yTlRDcnIvSGcvTmRPb1I0SWFnbXBSZTFQMlg5M0svVXo3SGhzNXpGNFRY?=
 =?utf-8?B?Z1ZUT2E4Q2pJc2J2NENSQ0ZRREZRSTRRUFU2N05VbHBSdU13bm53V2M2TlNN?=
 =?utf-8?B?S2xZRFBjL2JCUGVJbEl2NHk0N2IxK0FQT3dScmlicmc3bjBiajlOamQvVFBE?=
 =?utf-8?B?dlFZaWlhemlhbWIwRzdRZW9SdkU3VUhyQTVOUlVYU1dsRG1vWHNCZFNQdGFT?=
 =?utf-8?Q?41rqeudnBNs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmNuRjNZT0tkUUhEMzRNWjF5VXhiSG1TWFRFRWwwN2g0WlNaNllqUjhFVVp5?=
 =?utf-8?B?Vm9jZlhTRjJ0V3FkSll5dzI2dFljWVIxbkl6VzZjNmNPNVJTamZaY1o0cGJT?=
 =?utf-8?B?OEZsYjJvbzNlbkJZM3BrNmxOc2o2S21xZmorVzA0YWdHNkV5aXZ6d3FCN24r?=
 =?utf-8?B?VlorRUUzb0x4RjNVQ05HUzk2aXJ6SHBVQmk5L09sdTlJZkg1NnI1VWd3bFlw?=
 =?utf-8?B?QUhxQm9zVUhxMDRYV3lXcm9vMTM2OUxxbmVFbnVKeENlck5YdWRJM0RUcTZ2?=
 =?utf-8?B?MnRSYlJLN0l5UGJ1MXZtY1g0K21QdUFOdHhMMFNFNC82VERBRStaYzdGbFVS?=
 =?utf-8?B?bzBlVWp3M1NZTlB5bWk3cUxkZGFkYVdmV294dGZzNHpSRnpvUTVYM0x6S25l?=
 =?utf-8?B?QmpRaWgzTTI5SE1HSVdwaWhaQTRZN2VlTStWMEtlWFhmN2VZNTJnL1QyT1FZ?=
 =?utf-8?B?ZXFkMHZXUGZESGxZRHl6NXR0NTlqRkc2ekJjaWpucXdDS3B1ekJlL3hvdEFr?=
 =?utf-8?B?ODhFdlhwSEFVazN3N2dQZ3VEcFljY1YvWFZvWUtLUEhtRlN3KzhjbHJ2OGMz?=
 =?utf-8?B?V0VkWTRrYTVqdTMxNVFwKzVBYlcrSEVsbm5mVXBmWFFMUzhyeFE4M0o1ZHN5?=
 =?utf-8?B?ZU5ycjQxNlBpWmNnZFMyWDA3MThUNE05YWJ5ZDFDeHBreFhBTWdDYWx1N3di?=
 =?utf-8?B?RUVyWmNqcDZFYkkrNVlBcEZ2am9KUEg5UFZtVVFxMmRYeWFYejdHMVNUYnRk?=
 =?utf-8?B?SjJsOUlIUDJ1dGVPb1diLzQ2Tm9pR0huRmxQR3kwcHhhQktTRkFmTWo5cDJ3?=
 =?utf-8?B?MGQxTHlBWlFRb3c4L0JZZUVXZG1TcTNOWFpSRTVET3BkZ3pzZmNET0lGV1Z3?=
 =?utf-8?B?VWtPMEZibTYyTE9wMlFUODErQ3FpTzhJZWxTU0tYVHNFWS9pTXltNGpsVWF0?=
 =?utf-8?B?RGszNHgwZ1Y4ZDRRaE96WkorbndsaElXUy9YZ2tndWtKcDZkWno1NjJRWlBY?=
 =?utf-8?B?ZU9qaXJEQnZRYjF4Y2hQN3psS2haSmZiMjZVR3lPMVFrQzNaUkg4VFh3ODVq?=
 =?utf-8?B?QUsvQloza3dOTzFEMmRaWjgrWEJWQ2s5d1V6TWJsdTBlWkJab0dMUlJWdVJO?=
 =?utf-8?B?ZEhuK0phLytaWFpZRC9vNC9ibkVhclpta2JUeHI3dWZBbjAwTGhMeDdnVnVk?=
 =?utf-8?B?NU9kdk1oNXlUNm4ydjNSMS9pbWZQdXFNZnRyUzBpU0NrTTB0dEdPenFzOU1C?=
 =?utf-8?B?SGsyUEc2Tk5SN3lHTmdLdHZwYU02QkpreC9yeitBdXpVS3owTk5oVVY1a0xU?=
 =?utf-8?B?SUtveElOV1BWbXJLWkNNV0lOYU5MZHlLQmhOcnYzaEp2WXBLNFpxc2pISjFE?=
 =?utf-8?B?Q3JnVVNKVldoMFIwUHlma2d0WWFmYmR6ZlhLeDZHcjFGWm1wdzRaU1NTUFg3?=
 =?utf-8?B?SHZQT3V2c0lmbHY2YnpPWlVGdEJUTmtVRUFNRmlwRUdkc1oxUUxuZ3Jib0Zx?=
 =?utf-8?B?bHVwK3FvbU1Pd0hYK1lFVEhnMUdJM3Nkb3M1WkpYUEQ3VFZmMlVEVVlZVjJF?=
 =?utf-8?B?TXZkbk93eUFrV2hLUWdRUmZJQ2ZNdHBCZEFtc2pycjlOSVVodkhpYld6LzND?=
 =?utf-8?B?cUk5U3VUMDRwWUowQitia1VkbjZvZ2swU3pHZ0JtRjFyaklFcXh3aWRCaEVw?=
 =?utf-8?B?bExVckM2azE2eWNHb1VNb1c3VlRSK0o3L20yaTRTcXg1ekYzVHVaTS9rSklD?=
 =?utf-8?B?TSszSGE4UUg5bkhGL2kvMnRUSnNTSEtlOFdKM3c3cG9ZUlpwRWxNUVJENExj?=
 =?utf-8?B?MVhFWHVFakU5dXE0TWRaaUNVV0ova2dhUHo1MzU3WVZsWGFLK3JlNG0wVEd0?=
 =?utf-8?B?dUptN0VmVzU1V29ZY2FFcnEwbGlqU2ZWM1djMlEyUFdIa1Y0L1RTK3FJbURE?=
 =?utf-8?B?RVd1b21yeC9IK0JuSWR5ZjIvR1lTVEczL3BpaTMweVFhOWdNTWEwNU1ZMDYz?=
 =?utf-8?B?M1FtWjJaUVl0SFFUVlVqS2c0dkpDa3JEUjF5dEhjNGREMHkrWUFHSWsxZU9y?=
 =?utf-8?B?eFR3ZXdrSVduUjgzWDcvbmQzT213bklYWGdDKzNuVllrVDhuNzEwd3JZbW1w?=
 =?utf-8?Q?JVyDtOIO+c0Ewl9ucAJPD52FH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d131d831-caab-495e-5e23-08dd154d1b71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:51:47.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwwxBZDaSDu8wQG0+EqcRjkuSJZqpGy2xZM1OJnb1pxR/5dWb9grRkIgEYqWpohOsew+rGcKcK91ebg8rhPlQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7446

From: Joy Zou <joy.zou@nxp.com>

Support pca9452 on imx93-14x14-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
index 236a44c1782ae..348abb9ceae19 100644
--- a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
@@ -219,6 +219,89 @@ pcal6524: gpio@22 {
 		interrupt-parent = <&gpio3>;
 		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	pmic@25 {
+		compatible = "nxp,pca9452";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <610000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <670000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1060000>;
+				regulator-max-microvolt = <1140000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <1980000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <840000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &lpi2c3 {

-- 
2.34.1


