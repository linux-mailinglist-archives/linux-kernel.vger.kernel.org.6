Return-Path: <linux-kernel+bounces-529646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D551A4293E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD853AD4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C3263F26;
	Mon, 24 Feb 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cx3ZwOe2"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7226136C;
	Mon, 24 Feb 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417113; cv=fail; b=uLpEnFJO0jOeiFR8tpAKgZBCqCT7oLwaijmesMH+l4Bgzth/+r4+qUU3zkjp4Qjo/VfQ5+3+aGVWOgniQHqb4qWlI/fdR074fkHN9FS3LMxaaDJnwjJI30DvyOH4Tah3E8gI9/NxZDxZ3Dx3PlkdXEvrWxqjSoisp2fA9hs+g2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417113; c=relaxed/simple;
	bh=P3BJa9lj1XclXmwFTykj8WJHfN/J9sYRclMkSVpxooU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AxrbP530UNHxb2T7JWP8a7BYnWchTNoDojm0F0PB7xnsnq1to4vQwMpkgE9YT3g/qCS4mWXDqGdX7dSwF+9WmqOzIJ8v0DoXNBS+6QkRLTIeAjcGs7tS/R1jmiMcmk447tZSPeOfSsNLGr+zzBJPEpdWDosg3ZuXBBiwmfeWXro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cx3ZwOe2; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+UILeNmhXpaKPsVbb5mPG5rx//uyT1GmyJQKp+lkZC3u/WBJqEn9oC49DFmyC8wUcoJmRAecfVGGYimpbm19WLm7jOfrNb0o7PID5yuooiS9fNepL3++D+6epM24urpRhvnckkUoZmW+GGi85/L0cPrbcD/zg7zVI/OfPBFTfLu/iXd0Vp9GrpmeDIgmuhyA1P1tQjTRy+j1QLVSAdnWwEmIDgVRaYsn4kCM7w3dgbVI7AMQ6YAwvrbWWh0fXpArn+1qOwjXmWcOFldiqa0DExdsAMPE7mmPHnmK1OiKSAUWXSmEFT3jI85upfO01ibOTNaXTf4UCY+ChN9LUJc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD9OM8eXvfveIqh4KTLufiaeAHslTxS/XUii1rr8cGA=;
 b=OYKmRLv0n0UF1SomkN9rLBqQT5TYTV8WfkCH8miUPDiv9mCaFlTUC115lNHkNra9J/0tkN9R8acff+WcKLogyxiTaIA5i1esqMFQX+6s1JH9fE1KplGPlUC8HGHvDeD8gNCvW1NeFizU26DjX4uKtcZaLdkBnh9uXx5DN6+yE7VwNAi/yA0RTgCCn0uNS8vvfCxFFPZmovlrAZhqyNzNel0R9wbGN/elW8IZ/AvC7abe4IzPi8veVysvbM6ODHxss9W1p9f6m6G+qQ4h1gcbzOOxH00M4UqOqhi9LbTYZJHVVWVE1JubM14/fozQqdcXbYoVh+5us7xPzgeeVl+VXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD9OM8eXvfveIqh4KTLufiaeAHslTxS/XUii1rr8cGA=;
 b=Cx3ZwOe244P2m48CxoZ5fxy8qglzKvEX7gWFjVFUWbzwT24213dsrbOItLbr0HNvbUDIo8Fdt/YZFmvjyh0t309300fj7VIQKfuDhkrkT2mTMSLjBJZr2ODQTSw+/bhzvS1DXL/b87VhkQZ/7eJpRtnokv18yidYgDFR8hBge+cejz9VNQEBhbc6cIlntpiOhWj0eYpfCgo0BenI1VoS3YwmTeHu1IM9VYedZCeK3yarg1zT0ift36Ih/C6BDJzpU1NMPnNDMUO6Af2Dcp1HV5R/htUT9DKvFaw5Reo50FEVCa1Qys+5jjXKkL2lLr8bkAHw/xx5WSsh+j7hAgcNvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10488.eurprd04.prod.outlook.com (2603:10a6:150:1d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 17:11:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 17:11:48 +0000
Date: Mon, 24 Feb 2025 12:11:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Shawn Guo <shawnguo2@yeah.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] arm64: dts: imx95: add ref clock for pcie nodes
Message-ID: <Z7yoTPAvhzqfBel6@lizhi-Precision-Tower-5810>
References: <20250128211559.1582598-1-Frank.Li@nxp.com>
 <20250128211559.1582598-5-Frank.Li@nxp.com>
 <Z7nmckvKi1xcb4Qo@dragon>
 <AS8PR04MB8676A4DA393EABCFF5DB80948CC02@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676A4DA393EABCFF5DB80948CC02@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10488:EE_
X-MS-Office365-Filtering-Correlation-Id: d74013f9-43df-4701-72f2-08dd54f6528f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGtpM3JrVEZ3R1VwTVVjYjFYc3BoNUZHdjZtclZJcmt1emw0TUxFdkFidDVB?=
 =?utf-8?B?ZmVJUHpDWWtwTHV0UWdxY25ldkI3ODdpWUtGaWI0dFJhb2RkTTl3ZHFrUEYx?=
 =?utf-8?B?Vm5icU1CRTMraENoSnduRThER0JFUVdQVlZKMzJWYTlCbG1nWlgwWGQ1aVJT?=
 =?utf-8?B?UG03c0tuOWswNWNXQW53MHNPRFRwNDIrd1cvcXJTQ284aUtuNUhMQ1FYbTNQ?=
 =?utf-8?B?dTFndzV2UDV2eWZRN0luMjFIVlYvbzFYbk9FM1lYUDBreUN1cVVnd3ZHcXkw?=
 =?utf-8?B?bVh1akp5Njhqc2JaQkxHNmpVWTJJUHpndDJtYjMxTWxVK1J3a041OGFOdzZs?=
 =?utf-8?B?am9jTzMrYXNrZkZrK0N5SkhXWVRnbm5mOGtLQ3ZFUVZBa0N2cXpWSkFUeWlZ?=
 =?utf-8?B?M05zczJxblNmK3V1WEplRi9kRXlBNjUwUmkvbStSOWNKLzhONDNvcUJ3YWtV?=
 =?utf-8?B?ZnZVc1BpSUt2M2JGaldUa1ZXbDJjTHQ0VGNvZERYVi9SZ1pXdjdLaXZpQmoy?=
 =?utf-8?B?ckdzUml2R1pMWWdxSk0vVTBYd1k0dnI0NDBWR3l6b0pheThpRUk0VXZ4M1dI?=
 =?utf-8?B?WFJGTkxlL05JOGpIaW1QSnZZMms1eWZaeHFpSmlVS1FxWmFQTk53WUNSOWNt?=
 =?utf-8?B?dmgybm9ESDRwQ051dzdHeWhHRFA2dWorN2kvNzU4azY1dllqTTArWVhWd2FY?=
 =?utf-8?B?RmJFUnlQa1QwN05WNkpxdGdHK3ZVKzN1RzBweGQ5dkNPRVlWaTkrcDA1b3U2?=
 =?utf-8?B?N2hzbzV0N2pNb00zU1VReEVLTGZGZHcyWThoenh1NkZvQWJLTmU4YzRtVFdJ?=
 =?utf-8?B?MjhRSGluQVZ1aVlmZWh6NzR3WkJzVUV5SjJ1ZWE3RDlObTN0T3gwL3V5NFJx?=
 =?utf-8?B?REtaNmlDNnFLNkNjMzlROWVpMWowUHkvRkJ5ZVlFQ1l0R2hla0huSkZTMlhY?=
 =?utf-8?B?Z0hWRmNURkU3UjNUcDIrOVhrdnRwdnBENVdFYUIzT1pOUTBYVU9ScGdFTnMy?=
 =?utf-8?B?OEE0cWQ1Wi80czBRVy9uaTIrZHZqWXczRzNiemhpRTRlMWg0WTJiNTJTWTRh?=
 =?utf-8?B?VmNCZzBONEVuYkV1aCtVb1lWTkZFVThFendhbjZDdzcrY3Y0aS9LOGVteWEy?=
 =?utf-8?B?ay96U09FbjRxOUxRYnpnQTZ2bnVRS084UklmQll6NEZWTVlVL1Ixa1VrZ0hp?=
 =?utf-8?B?VlE3dmF5OWl5L2dBQW5MT09yVGV1S0RFeHJGUE5aSGQ5d0QyclBkV2doK09E?=
 =?utf-8?B?ZjlIc2w0SE5halhIQ21DcnMvWFdwL3I2SDZKN250dG0wVXFacmw1dnNnMTEw?=
 =?utf-8?B?NnZka3V6R3YxMzczWUFuU005bnFlS1R5RmwvNmVqdFl5YzlQSkpWcW50QzNi?=
 =?utf-8?B?aGREQXQ5bEQ1djR1enByT2RETU8rdnBzK0d3SWZLVGorNWlWZTEwQkhTbEEr?=
 =?utf-8?B?eG9IZWRGV3VtTHBQWkJOL2Y3endXZVhUc1pSWnNCVXd2YUdpSlB4MU9zaEtk?=
 =?utf-8?B?N3Izc1IyUnlFamVvdERFU2xLbEhmSTc3QU9MZkFwS3JDak5qYjBPSk5IbzdJ?=
 =?utf-8?B?QWVDNXd6Y1dvMlZlb042TXFjME5GWHZYS2pCdWNtVTA2RG5xbWhaZldJMnl6?=
 =?utf-8?B?Y09lc0REZVhsT2Nwb1FZa0gwc3QvSjVsalNRbGVWT2M5bmxtTkVhOVdaWStL?=
 =?utf-8?B?NGxrRUd6R0wySm4zUnU2UHlqMTZVUEtHZGxtYi9UL2Y5RWdnVzlSdGtUWTEz?=
 =?utf-8?B?RWhNcldta0p6V3RFV3p5bG45KzEwQ2NnZitNNFNIR1I3eCtpU1F3THFiZGhR?=
 =?utf-8?B?MzhvM2JNYVRwZm5ZSUpYaDl1UTNLeUFBUU9jN3dxUEZxMjkwVGRlbWI0YlhB?=
 =?utf-8?B?d3VnS0o0TFFETEpGZUhNWU1XU2NSM1JFaWpQVHEvNGd5UWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldRNjh5WXdpbmhpcStOVHNyOTNqN1VuTVUveUlRS3EwSU1VSElNZTgzQmk5?=
 =?utf-8?B?S3J1bGdVOCs4dDhGQVUydDNKTmg3K3NzQi9OUkVRTGtwZnFJdWNKRTRXTFlV?=
 =?utf-8?B?RWtra2VvS2ZCOXJ0V1A3MUZxQ0YxZXlBUlNrVVg3MkFFWXpUYis2TWtDd2t4?=
 =?utf-8?B?cjRyY2xqMnBPclhScUsrRGxiWWRWazg0amZlQ2l4L0xOdEN4VW1HL2Rrdmxm?=
 =?utf-8?B?RHJqZ1JQMDdzYUsrZUx0NS9DYTNic3RrMUEvSVB0WXEvODBleTdjQzROTUpZ?=
 =?utf-8?B?cURtUHlnM00xMDBMTnAwNWFPM05iVG1QUFhnQmRxd0I5WE1KbXlxU3dnRmtm?=
 =?utf-8?B?ZzhzeStRV1U3UTFVcCtVVVBzWTZlRkEvTkxwdGZUUzFJYzFlV1cwSnRteGNs?=
 =?utf-8?B?T2tQMmhRRUxhN0NJU3NndmNvMFVDLzh4cHhhTy9sVS9DUy8xWTFMbVU0OHd2?=
 =?utf-8?B?aEFCWkk3enNtcDdINTRXZVpCZHJTQWF1MEVLeHhmRWVJaEJLOFA2MTI5NjlF?=
 =?utf-8?B?MmwxU0cvcXZSUDl3dlFrak9TdHV1SVVtQnR1SmZzaUZZekJ2SXp2VlQvMjUy?=
 =?utf-8?B?WFVEbCtKRzFQN3BVRUtLeHNmeS90SnJ4MUxqN1hBeTdoK3pyNlQ2RDhhMjVa?=
 =?utf-8?B?aTNCSWZJa2ZNZnFXLytpZVdTSFZPNXBGRkNyT25QTFN0dkl5Y0tMVXpibDhq?=
 =?utf-8?B?UGp1bTBudVNRcTNmODNVZ0hJSTh3cWlNMnBlbk1yQWh4a011SkJpVjJwT21w?=
 =?utf-8?B?WVNUKzJPOHRCSHczZjcySEZ4ZkM5RjZGQUVDZS9TbDNNb3Z0dVNkWDR0RWIw?=
 =?utf-8?B?NGRZU25qRzBLRGl0ak11c0U0MTVVYnVhVWF5aFBSdmdJbDdLSE80dzhydGRU?=
 =?utf-8?B?T2ZUaEFWRmtSQkkrbEJKMmxFc3lwMFpIejNzRW9uZ0ZiK0oyT3BjS2pCMmZP?=
 =?utf-8?B?dzY2aEJDU0VYc1dyUGY1NFVlYmVNWmhEUm95V0dkdWl4NDExN2k4OTJ2SkVt?=
 =?utf-8?B?cWRESkRweHJ6SHZMM1pLT0ZQMkxnY3BDRVFMZHVuNm5IeUxjbExLSnN6dVYr?=
 =?utf-8?B?Q2dCTXdmam0rVHBudC9FRDRRTWFDUmRUdnM0YmpacXVzNWlUQnAyY1BlUXVW?=
 =?utf-8?B?bzA1TmdmcDFRNzdaT1VLQkVaSDBHVHRjcFFDTjY5MlJFdVZoa3BvelU5ZDRZ?=
 =?utf-8?B?WVY5MTQ0elBtNkxEM2JaenEzT0h5NHQ4OElOOU9GMC9Zdko4K2ZSM1F5NUl3?=
 =?utf-8?B?WGlRRXhxVHY1V1ZjeWpwYmtsYVdGZEdwcEpUa3R4eWFGTmVxUHorSUFyR2No?=
 =?utf-8?B?SVhtS2FUd0RIUG9RTnR6MS9rcXQwazZseUlpS1U5MVgyUHdaWFBzL2FJbkJH?=
 =?utf-8?B?L0VjZWZjWVVQOUZqdkI4T1MveS8zV3IvK3BIQkR5YWNRcDRSN2VFbjR2STF2?=
 =?utf-8?B?Z085alRKREpSZitaWVBGaWJpZXBhVncwZlJiUW5YZjVlUFFXRlpWVEN2M3pz?=
 =?utf-8?B?Slc1MkJmMFBLN3A1b0lVZ2ZOcndPZURwWHlKT2hzd0E3d1A1NmpjM1JydDh0?=
 =?utf-8?B?bVhTTzg2ZEN5QlBkaCtKS1VXaFAvOTlzZnZUWVVXZzFHT0dZcjZiRVNBazR0?=
 =?utf-8?B?WE1xSDM5TFlKNVBYdHRSN1FrVkJEazAzWnlZWjZEU3ZoZFc5UEQxdmxqM3JY?=
 =?utf-8?B?MEpUWEU1SGhqaXQyKzdSd1dtZXY4YXViVVY1RFp1ZmhQbURvSUVGUEE2ajZ5?=
 =?utf-8?B?R0RtemtaaGl0MTJiQUdqaUI5WEI5YzlUNlpWSVZERWV5RS9GNlNDN29Ibjdj?=
 =?utf-8?B?MnpTeHl6dnkyTzA0N09MOU9ZdnYxWmhHWGRyamUzTEI2VGJBYnhvcEx4R2hS?=
 =?utf-8?B?azRXRHQ2ZmZYazR1T2Fpd2EzM0NLVEdtYWFBWk82VmNTdGtFNUllSWdSdURz?=
 =?utf-8?B?MlpKNFBvQjlDc0dKbjVrSE5scm1hL1kvY2pXZWFzWkhTZERrMUtyR0hPTk5S?=
 =?utf-8?B?WTNka2JpanRySHRodmpXM254REZXWExQNzI0K1pDTjBCQWdld0JKYVhpdlRk?=
 =?utf-8?B?N09qOWJEb0RHUiszUUgyWGs5WnlZSWYvTzZ6cFFBRllFMzdabzNKeVpLTW9z?=
 =?utf-8?Q?iYD5KZVcu3atPjpmvRkfwqfUq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74013f9-43df-4701-72f2-08dd54f6528f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:11:48.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+i+K1P8LDvs4do+yvUaZzsleIwneFf80WjHfeCSlcb85SsXOindcK/MO061IK7Gd6NRH5bDqCctN71oFfgObg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10488

On Mon, Feb 24, 2025 at 02:10:40AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Shawn Guo <shawnguo2@yeah.net>
> > Sent: 2025年2月22日 23:00
> > To: Frank Li <frank.li@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > Conor Dooley <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; open
> > list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; open list:ARM/FREESCALE IMX / MXC ARM
> > ARCHITECTURE <imx@lists.linux.dev>; moderated list:ARM/FREESCALE IMX /
> > MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list
> > <linux-kernel@vger.kernel.org>; Hongxing Zhu <hongxing.zhu@nxp.com>
> > Subject: Re: [PATCH 5/5] arm64: dts: imx95: add ref clock for pcie nodes
> >
> > On Tue, Jan 28, 2025 at 04:15:59PM -0500, Frank Li wrote:
> > > Add "ref" clock for i.MX95's pcie and fix below CHECK_DTBS warnings:
> > > arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie@4c300000:
> > clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
> > > 	from schema $id:
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree
> > .org%2Fschemas%2Fpci%2Ffsl%2Cimx6q-pcie.yaml&data=05%7C02%7Chongxin
> > g.zhu%40nxp.com%7Cf373e5ed1a6b4c7aefc908dd5351a620%7C686ea1d3bc2
> > b4c6fa92cd99c5c301635%7C0%7C0%7C638758332322731937%7CUnknown
> > %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOi
> > JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=glq
> > vwWeavp1SMo6%2F8rZ%2FbGMXgJHCeYPYIZVW3vkTFHs%3D&reserved=0
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >
> > #1 ~ #4 are applied and #5 doesn't apply.
> Hi Shawn:
> Can you help to take the last one dts patch in one patch-set below instead?
> https://patchwork.kernel.org/project/linux-pci/patch/20241126075702.4099164-11-hongxing.zhu@nxp.com/
> Thanks in advanced.
> BTW, the others had been merged in PCIe git tree.

Richard:

	Still can't apply with your patch because usb3.0 nodes impact this.
	I resend my patch because it is easy to fix conflict and apply your
125mHz input part.

	https://lore.kernel.org/imx/20250224170751.146840-1-Frank.Li@nxp.com/T/#u

Frank

>
> Best Regards
> Richard Zhu
> >
> > Shawn
>

