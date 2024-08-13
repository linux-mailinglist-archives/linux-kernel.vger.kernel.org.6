Return-Path: <linux-kernel+bounces-284093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2535C94FCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B74A1F25215
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1045219F3;
	Tue, 13 Aug 2024 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ElaaX+GH"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8C3D994;
	Tue, 13 Aug 2024 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523735; cv=fail; b=hCD/gns/wmuQu5/3/5gydmmxlDiZ6DdcBq+EBJwtJboQy1vZvp8FtDYsm+4XhaAUfirWHYgvBF3z4EPplDqW5xS+K/nfNsTC2dC2UopxXRkFXamPbpxJjArgVNoVQUebojtdQae6XhZzoelbreCPXlXtqcJGC1wcVw5SUnWuuig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523735; c=relaxed/simple;
	bh=iuG+BE/FalHLXOzAwdQAnDE4NmlgmDnu7B1ib1489Ic=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Prp0soObBLV/eLwXwVdqLl7/u505iyo2rOTvWjAwHt8N1JuMOhzfCuP85dOtEPpkHhvY/r/gdor61D3EDhAOozT4B1DhJSaAAbBvMdigbvsIlLpvRxi9y7RxaSD/CnU/OGbFQBcyVUHyUj+Dptofk1iQinD9KMw+LruMlxOeMJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ElaaX+GH; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlbEua0DMlju4xlI5GIPne7qmnfxbfafDA+ApNsvyoV5t4xwP+d8/tUOuidYeCY68Z27x8WZQ6MFrZtU3Ka7qOc9RMPgbEDvkDtmIfMGhWS3lQoUXee5X/JG8egsEWGRDLYaU+wb5HIzxOIPFH/68p+2kZXE74N9zjHRGOwAqQPExMJQMT8YgS/YLq2eM1ebbtgWCk88WKPWU4/QnARUAr2Y+w5RNi82fW3/kttWw8fQSxVX3cbQf4DLAvBBU9NSr3VJCW/JE/K/hyFUD0blJbMvc/FR8eAPqACIs1xN6ShuLOYuyXJnFsq4EjoiUg8+dneaT3JWGohR2qLNswOhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEHyWqbaNN+WxGtnMf5346T8SQEuqx1jZxctrXBVs7w=;
 b=NOWDz3O1UvnPG7WJNrM/nMozKCIPKWfroKd7V5UZbK3vFFMazEX9BIeHik7HxbuDd1vfzeLefxzTRsTfOuItU9+yqnQA8B0QIJyHmNrOFPYQdG4PyZVrUAKzgb0hcz79Bsr3Lc9Ow2cGrvXn4IXbqWoyctV6r9TxFCi8iNPSMeLBU5QsEOM8eHdrf2J+fJ6O/QPYPBNlWiZHys3IaJZ0J1H9uTFl5gmYxWklx7RoULkzhbo+oX97IUZGD9waQwDSViAQOYk8qKdeWPxsy80wtDXfHNgCiY6HCrycoIv55O57i41u/LAEf9qnli6yZgFpTUdrsIsjNpKtgtdcM2sJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEHyWqbaNN+WxGtnMf5346T8SQEuqx1jZxctrXBVs7w=;
 b=ElaaX+GHEhzQSKFomOYML0n3KSjA+qKq4LENIg5cOe3gzziFanuY5ZC//tvhhIISbpKbI5w4ifwMSsno12+/ADG8lscH3Sl4NZK0fW70RutMiT9XrR72/FbqG+N0HNs5R8iIzdCgtcILRppK0iNzl1V+b+KtE9i3cNCLpO2at/0+O2WASilJ4iMvCT+MzpvLbMJC5dok+RszOqr/o5WPNj8UJKnZXWDZ+qD4EYsSDtc3q24XTdgEKfNMpH6/4rkehtwK63l0+KKJCAdL1Xqv/kwTXnfj74B7vxKPd1pT8t9EwS9SRhfea/cpxu+jp1jU8yKxbyB8mnvkWtxY75yOFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:01 -0400
Subject: [PATCH 06/17] arm64: dts: layerscape: remove undocument big-endian
 in watchdog
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-6-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1506;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iuG+BE/FalHLXOzAwdQAnDE4NmlgmDnu7B1ib1489Ic=;
 b=qexTZ5nv5XxeuulnUmliEz2pIv1NoMGRyEgEo6yV+z1HHUw4AVK3zVyITsvQHMEdNOnj1THxE
 N7WlDxl7MTsBugcUuTWhUnue+jIEb95jogKrV3L5zuspwFJUy8ksZYp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b6ac03-0ab0-4ea1-d256-08dcbb515d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkxGN0srN2tyKzBKZDFldDFLUW9KeTNvMHFMOGlCSVkwUklta0NzQlFVZVhv?=
 =?utf-8?B?bXNpZ1l6Q2crclFVSlJndkwwb0Y3MjNXdS9Md0tQTWtXbW8zOUZPRWNiMnlj?=
 =?utf-8?B?NGdoQWxhMEFXbXptS3NRMXJjbWQ1NEtkeHE4RGNHdTF0SXlaRkYyM0wrWnJ6?=
 =?utf-8?B?cmo0dkhaZnpXTjBTRU1BbWFXMEUxSTdHbEF2NWhuRHZmUTBPV3FKN29yeHNp?=
 =?utf-8?B?eGNZRkNYblM0REhzZmlYczV6SjJ4L3pHdWIxbkV5OWw3b3Yrd3E4ZElMYVQ3?=
 =?utf-8?B?TFZlMWkyY3NtMk43cWFVWTE5RGZYVGprcE9Ecko5eVE5UzlOR2lUNnA0dWVO?=
 =?utf-8?B?MytWRGp1eEpZRXpDT2VmYUVMWFgzKzB6cnE1aGd0V216Z2RxcDY2R1BhREY2?=
 =?utf-8?B?eVBRK2ZiRHZQL09NU1p4THZsTE5UeTJIN0w3eUlWcHlEZ3FTb05BdGpuejV1?=
 =?utf-8?B?Y3MxcFVkLytCSlg2MCtEV1NVN1VDc1RYc2grVkJhS3dRWUNmNThkRkhuTzFn?=
 =?utf-8?B?NUlYSUoyZXVCclRiSnVxNHBRZ3RnYVBCZTQ3Z0dNbUxPSEdiNWdLQktiRUNM?=
 =?utf-8?B?SkRhenVzTFN5bHVsclBZUDYxSmNOSXYwWENCQlJjdTFIK20yQVZDYmhqZDhW?=
 =?utf-8?B?NFkrTWpPTjIreXNmT1JINng1aEJEdWxXejA2TGlpWUhyMFdySXpqVlNNdVhy?=
 =?utf-8?B?cmJLa25xUWpLRXdnQi9TaTBXTVRIeTVKZTFUS3lpaWEzbnN1TzVEM3VDUU5P?=
 =?utf-8?B?SzFRUXIxODJiVCtvczZJMlRYZ21RTUs5MTJtSnllaUtJYzV0STE0c2Q1ayt0?=
 =?utf-8?B?ZmsxbFZYTUh5SnNtc0p1cWVmTjNQRndwR0FVa3ZZaVpFVGhUMG9hQ0hqSmJK?=
 =?utf-8?B?bTF5Q0N5K2s4c3A5KytycmhTWGEzT2YwcC9OMEJIWVZ1VytxMHB2R2xKdWlP?=
 =?utf-8?B?VTB2YTZhUlRnbGNnNmVCZncxKzFXMUhWbWJHS0NtOU16RU5PRTB3eUJ5bDVV?=
 =?utf-8?B?L3YydHNEeXNZeWtBSUE1dGViMzY1UmZKZ09RakR0RG8xQmhOMUpYR0FKU01m?=
 =?utf-8?B?UWltQlNaMDJsMEFpd08rUDVzV2g0aXE0OXhmWkJaSkZ6ZjNhWU9OTnd6Q2ly?=
 =?utf-8?B?YVJsK0l5c09PVmsvVmdoRWVmcExKTCtTQzk5WWlXSGNUWStJK2JCa05wVDg5?=
 =?utf-8?B?L05RMGQwOXh6NFJJMi9DQTJDVDJoY2VtdEhqOTczOEFVcGdwZ2R3blh4ello?=
 =?utf-8?B?Q2c5eUJJRjdadEZmNVJSQUdOVVZzOHQ3UkRMOUt4VmhaR3BGajJPSDFEbi80?=
 =?utf-8?B?L0RlaStrZ21vSmZKcjFIUWVHQnhYdjVZTXozd1VPcEN2UlAweUNETkRidGRT?=
 =?utf-8?B?ZWhRYXNVRys3NzRKeG5VYU8zVWZNTUFRYU0xaGxIREpqZXhLZ2Q2amgwdnJw?=
 =?utf-8?B?eEwxcTI2WGp0ZC91N2ZrdERxKzR2bTZzcmozcnZxWlhqYm51MXI0SGhka3Zz?=
 =?utf-8?B?WTA0dXBtU2FxTEFxeUlRdHV4eVliUnJjYWNBQVRWMGlnVFpPZWJRVU44RDdY?=
 =?utf-8?B?UGlSL05jaVRUY0JtTklwZmttb2pGNGtsaGVaS2FPTXpPanQxRTN4K285dVFz?=
 =?utf-8?B?V2gyVHlWZzFHY0J3QUVXU2E2Q0JLcXg5U2l6b2JaWVlzTDlJR1FzMjF3OFMy?=
 =?utf-8?B?THV0b1Y3MHVLcVlZQ250NzVoeVZ0TURlU3Q5SXE3dTE4dmxsbGZDVGRnZGR0?=
 =?utf-8?B?bmVUTmNkTDhPV0N6MCtsZVBrRFAvZnFmZ0hYa25XeGVWbUFiSks2VEJoYUtM?=
 =?utf-8?B?Q2xhQXRRVWNyd1B3cnAzSUh1SllYMzNtaFd2NG84RUR4N1F4d0phcWwxU2da?=
 =?utf-8?B?UU1Fb2ZuL1lxUjdnNDRzUlpQNFkrVXBIaEZGZnB1dk9Xa3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnpZQjhDeWd4eWxieTF3VW0rY3VaeCtwUEZzZWFVUUo0Z3BaK1UraXUyRHVt?=
 =?utf-8?B?WFhLTnZ3RHJNb0NwaXd4QnlkMGk3bjhmVVFodzZwdUxWbWt6WDZScEhaZFVr?=
 =?utf-8?B?YUl0UnVvckhrUkFOVS9zTXoyZkZCRGF0NEQ1cjBVTUZuRS9WM3RaMTFELzJi?=
 =?utf-8?B?TGY3MTFGTXZFaC9yV0pkOWRhWUdXc1ZoV3p5VGtZYVVGQ2tsZm5jTGxOcVlx?=
 =?utf-8?B?UzJPMlk0bVNwK2VPRnpBZ0RESlgyZ3Q4bjYrdlZCZFgyQllJNDZTZ0RPRmx0?=
 =?utf-8?B?TTFWSWFsYWYwTkorRGphckV5NDcyMENIRjFNMlFVVCt2MjRVSk95MHZKQkNS?=
 =?utf-8?B?eFpXZldpbGhWSmV5dXgzektoRkZWcDlsdFo0Qk0wRmlCVEJybEswejkwV3pk?=
 =?utf-8?B?cVlscEg3dDlNeWlFSGl1enNDMmdPRmo3cllwYlh4Q1ZoUXo1dEZtd2hkVWM3?=
 =?utf-8?B?VW5HRU1Xb0ZvUlBxNjJsWkgxdDhpMERwTlBzYUNORUhRRW82aUppK0toWlFX?=
 =?utf-8?B?cjE0WjZudFZRV05mMjV2ZTBJOWxyMG9BTHhuVjh1OURJd2FoUXgvN1N3aDIx?=
 =?utf-8?B?ZCt4WXV0ZDVlK2QvT0M4TzVxQzhxTnBFQ0lwUkZ0enYyeTM2RW5WOHpXeUow?=
 =?utf-8?B?bzl4THZUWFpERzRrOTRuSERQRHlac1p4SG5OejMvM1gveFdLdEsvU3d4Ritt?=
 =?utf-8?B?a1J1V2hKM2tjUDc5LytjcStTbGZjTWpIQVFBVytHUlBBWG4xTE9FR0RNTGR4?=
 =?utf-8?B?N0JEZWVOZjltVkQ4ZCtIM2ZWSDhOVlNjZXh3S2NybmxJSThmSjRPM0E3bGtk?=
 =?utf-8?B?dmlma3RRdjJNSjFwTmd1eWtiZkk2WElTU2cyZmdDbThRU2ptZ2cvYnNRcVdP?=
 =?utf-8?B?amhjMzJIWkxkNlMrbUpMUDdqbHhKZVBKOXorR1lrSm1KOEYrZXU4bTJlSTY2?=
 =?utf-8?B?bytsTldKTXVlMlA2OWxRU1Z6WS9NT1JuWlZEN3Y3Nzd0c3UrMjJNRGtCcTNr?=
 =?utf-8?B?M0RIcjlWWE4rNU5nWHNUWHN4aTJEdmVmem5OOFRwejJsYUhYbWgyeTI2L0pw?=
 =?utf-8?B?UkJ6V0JvWWpTRkhjMW91ZzBhSmRHZmpVUVR0MWRqZU1xdU5GYUhYNVVhVnMx?=
 =?utf-8?B?eGpQa2FVZm5IczdOeTY5MmF3bDB6K1FOMDk5M2VqWlJ6aWF4RC9OZXZYNjlI?=
 =?utf-8?B?dEgzZk1KQ1BqalExZDVTZmU0UTlCRTFPSWpUdG0zdzZ2ZDVGS0o4SGVXa3VU?=
 =?utf-8?B?WUkxdGFxeTQxaU9xRWZibnhDbjlhUE1vYXJ4eVFDNlV0YVJKQVFta05SaThV?=
 =?utf-8?B?aUV2SHlVM2dKWk9wb1FnbDVwTHRIYjYxOTBlTGRqRGowWFlYQmh6aTNXMXRs?=
 =?utf-8?B?a0J0Smk2d2t1SWxLYncxWndjV0FBaXRGSXNKYU9LeFQveDdPaXovdDhKVGUx?=
 =?utf-8?B?TmNRWGZuVUVUK2pKaHp3RGUwWXQwZFJtaDZwYTBQc2RNUEovNWFtbDhIQ1pn?=
 =?utf-8?B?aGw2Mjg2ampRTXc0NXJYZ0hDRWFjUU4vME1YdnNkL3U3N1dxTmlnTUcrR1Iy?=
 =?utf-8?B?ZWx2b0c2SzZ2RW83WnNWU0phblYwWmcxUHMvZmdUZi83c1dST2ZkZ1dWNzdx?=
 =?utf-8?B?eGRQTkYzSDFoWm56NGJoUGE2bStjbGUzN0g5SFVtYm80ZVVZeGpFUkt3UlVh?=
 =?utf-8?B?Tkk4ekJZV0dTeXMrMEJ1YVA0TkV6N29KRVdTdkE0eEFJOXhaNDBjVUJzUmJv?=
 =?utf-8?B?N21OSXFST3Nab0VMbllmTUtHUVVOczQwRmlOQktSbEJlMG5pMWQxUTVkdGdi?=
 =?utf-8?B?NzF2REZ6Tkw2V1Q1N1hicDVFaDJLd29HaTh3UmJqdW1hbHNzWk53QVJESDNk?=
 =?utf-8?B?MlBxdjBxbjJuQ3RSWWhCeDVldGlHek01cjkwRytld3JsLzNaUGdxUkp6WWdl?=
 =?utf-8?B?M3Z6YXdtQXl5MXp3YTdaZDZoY2RPZkhMTW9pK2ZwVTJ6SWkrL2xPQjg1Vm9T?=
 =?utf-8?B?MkF0UnJyWjV0Qjdsb3RUL2lOeEJzTUFtNkp4QmhZYjFmZERZaytuc2E4b0I3?=
 =?utf-8?B?SUszeDc3YnFQNmpmUjdJbE1vYzVFeHlzdER1RzRxR21zRW5vMWNLSnMrRm41?=
 =?utf-8?Q?kD36L/8bZVlpSfIzvzB1uMbCp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b6ac03-0ab0-4ea1-d256-08dcbb515d5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:31.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wibzpUkZLrW09yDFkA1nkHPXaKKJnq37AJ+xQCdEl2oHaPyOB7M3RiDafdxa++stdEiCz8e6LJrrYhgWL+I99Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Remove undocument property big-endian in watchdog.
drivers/watchdog/imx2_wdt.c also never parser it.

Fix below wanring:
arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: watchdog@2ad0000:
	Unevaluated properties are not allowed ('big-endian' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index a3c57da63a01b..b84512bc4c881 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -430,7 +430,6 @@ wdog0: watchdog@2ad0000 {
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(1)>;
-			big-endian;
 		};
 
 		sai1: sai@2b50000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index c0e3e8fa1e794..5837f1b15dccb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -776,7 +776,6 @@ wdog0: watchdog@2ad0000 {
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
-			big-endian;
 		};
 
 		edma0: dma-controller@2c00000 {

-- 
2.34.1


