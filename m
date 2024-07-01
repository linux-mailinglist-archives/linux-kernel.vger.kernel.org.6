Return-Path: <linux-kernel+bounces-236868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1A91E7FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26308282FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098416F82F;
	Mon,  1 Jul 2024 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rMSvNY5p"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82916EB6D;
	Mon,  1 Jul 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859920; cv=fail; b=dfBVhKXYs3LZgtSg8jHtKNigPhsQr7+9N8FztSzoR8wjZQoPHa3WvGpVHxCc7ywUpqyKJrCDrpdfaeBfcx/Z97ya1SR3HBp6M6ZnC31US8ipFDgEXj86F/SH3HzeKGosHASZS9G1PgMgZE9AtRTL5morKv+Tm5w+rkdKeH85P0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859920; c=relaxed/simple;
	bh=ZJ6jxKPg4OdHI8GJ5mANK2TuJX5oAG5WHEBWi1DRRJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mkebQGfU2KfOzhIjeItIpvSuSlKVbmK+AudDrQocjo7Fc88CGj9d1qBd+71rpaHARLdA+Giw8auKXSXrJJvU+6wI5BrMymXrLHs9vmf2ENXe7XS/ZUPOB0xCO/UsGfm/rxko1bJj2GDHZDZho0/YdYy0SExPyUs/SCr+8xRTgyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rMSvNY5p; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNRqxgXIFmsoOoHUAp8ODl6BfWub9Jd3fiuIfti1S+uRpNMESm1K7ZiefQbj4YDxiUZfFSIVjFOeZOc/SDAnQw6NSRW4dWdDDEXJT3of44KjERiByt8crRjCkeTbAEz2VZGU1e0odEFlfxwOdf053Fy4UMFF16CSrbAuK6+5jg7dIiRc+Zp+Yq1fzpEK5K9Fa+oV6LYspSWWtHjWc9xT9Lc+SMKY2nge4wBlSI/hUpIZM4sXxA4gPSegHSKfmO5xEf+3EqRB7Yo1GdIFe+NbZ1D36BgeIA93eQuukU7NKN5FmTnwMMMmvWYVqC+4V7ZEg68pcadLHIF5iY8+zVFQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMbdFeSElON8leQlnmavt4zbf+os+dMhPQmVkzETxLU=;
 b=LHYJJfXhZoMrpk41j/3XIEKuhPnRc+5ddYPrrMgdt41Gwf2ngEu/zSyZK9nTmpaTGpRvtFSvqyDGz8yr2cYmipHgTNzFKav8pmQkWts8Tcdc56QJ3H2m5NCmtK9GmJmpkbNDgpnhqtPLOU5aHB3kWMl5i6Zx7aNyL1Q7ZmWQx3wa58ZFtOaDGoisGlfq4ChXzfyo0ppWOM/jSnYN6J39FAqgGXdnFTgWtgjrCoa18O3M0CvVAxaNFVqK4ivY8k/xsPWjLdaYutSH7XPInIuCDWSytpVginLtcpMB6S8ZnekGfrJDVVj1Kx1YEThbDIDaNjLFx03CddxKG7ETdRMMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMbdFeSElON8leQlnmavt4zbf+os+dMhPQmVkzETxLU=;
 b=rMSvNY5p/7BmBfzexTD4A6zaO7MEnp46znRZSUh0OK8kw2P37vElFb5KeViDiY4JsC6nxkwF+DDQNCzP7/pGuNboQKydbgrj/5m03o0bK5KVgyU1E7H5B/HG4d0zn7PFNozP86yXFBNTfEmbSfCb1cNqWftMvP9BDbENfQx5aho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Mon, 1 Jul
 2024 18:51:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:51:55 +0000
Date: Mon, 1 Jul 2024 14:51:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 02/13] arm64: dts: layerscape: add platform special
 compatible string for gpio
Message-ID: <ZoL6xVdj/rEgK0H/@lizhi-Precision-Tower-5810>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
 <20240626202533.2182846-3-Frank.Li@nxp.com>
 <CAL_Jsq+YpLk4E-Sk7otOtbZo8FKYb-9GuPC1ie3aRauP=7_1HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+YpLk4E-Sk7otOtbZo8FKYb-9GuPC1ie3aRauP=7_1HA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 33be159a-e7af-4348-d9a4-08dc99fee114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzdZRis3aldSYVNnVm9HOUFFU1V6RTA4alkrakxpVTlnNURsN0k5cThOVzIx?=
 =?utf-8?B?dTF3c1JSd2J6b0MxVGo1Y1d5ME1kR0J4U1R6UHQvMitZRVVTKzJHYmdkTnRt?=
 =?utf-8?B?bVlBMVhHMkxNNE5PTVJOeGJCVk9KMVNaWkNQOWhhL3VIRk5sUHR3cjFZeURT?=
 =?utf-8?B?OHk0WTZKMWJFS0RHQnMvOWtOcmlLZTh0NUczWlczWjM2NzlSRUx6VkFWbUpz?=
 =?utf-8?B?aGJxTys3OEh1K011cTlRQmRmODJBWEF5T01RczVia1BpQUNBb3I3d0JUSWZv?=
 =?utf-8?B?M1NqWWFxbTZWYUx3SUNxSjNYblBTNW1iTUV4VkxpV3M1aXBDc2JINTlrV1E5?=
 =?utf-8?B?YXJNM0wzd0FPTWFWSFkwMVl6ejF1TlJreHRDMG5xRUU3YkdWNFdpcDZLQzVO?=
 =?utf-8?B?YW9lblQzR28vY2tTV21lZDQzTWp6NlpuT1FaYXNoWnkvaWZ6Vm5yd25ud3Uv?=
 =?utf-8?B?ZHcxeTFwMTMyK3BJNDh4RGJ4U0lQREEyeUlNNnVoMDZoS3d4TzltS1dwOXpD?=
 =?utf-8?B?dml3Zm1odlV2SlhuakRyS3Z0QmNPNkxNWXZra2tnV2R1alQxakJKWDEyMlIz?=
 =?utf-8?B?TW55NFNDQjlyWG5BY2w2QTNUR0swZkNPOFdLelBlUEFJSSs4L2pnS3pFTkNV?=
 =?utf-8?B?WGVFTHpYQXNxNHQ5Mjh4a1J0WkRvYU16dnMyWHNlbm5GTThmL2xWLzd1dmFF?=
 =?utf-8?B?c1NEWmRyeWRJR211WlY5UUx6M2VvTHFLRXk1cGhsWEhleEhJNkFoVHdFeEdE?=
 =?utf-8?B?dytUQWRUbDdjYmwxOVU2Y2VqSGdsRUJRZmt1QmV2UGliVXRsd0NlTXd2RmtY?=
 =?utf-8?B?dHVQVGhNZFdrRS9MMVVpT0ZhZjNDWUt5dnNIZDU4bFVPRVJIQ3g0M2U0QURM?=
 =?utf-8?B?Ty9HY0lWSWg0WlYxcnRPOVVhS0NjSExUN2NyQmxPR3BhWDNtUEg5Y3Z3enMy?=
 =?utf-8?B?aUlOQ21VUHRpcm1xNW5OM2U2cGR4aU9nbDIrU3B4a0ZSUk1yUmVrQXJPWWMx?=
 =?utf-8?B?Uy9CYlBMVmdZSG44WFljM0ZPQTd4c1gyWnlkRjdjS1JGMXhXbWxrVTYreEhY?=
 =?utf-8?B?aEF0di9Kb3hxclI2WVU2TE1nTnZkSFVKc3N6ckZzamEvOXE1cWVDWFhTN0pV?=
 =?utf-8?B?eDAzRlp4ME9wVmxxSXhiN0VKcU9Ta3JDVTJGYTFNSStBNzUvblJYYmpCdVl3?=
 =?utf-8?B?bC9qdVFhWm9Uc0lpckVtZ3Ztc0NyL0pXbDFENDRpKzlnZXp4ejhYMlluSUUy?=
 =?utf-8?B?Ym9BNmpvNlB1aGtybC9jRWdYTWU5YmpLQ2Uzb2JOdDlUS1BSbktpelk3UDNN?=
 =?utf-8?B?d0N0ZTFCZUh6bS9FKzRpWGlXN0piNlI4clQyK0lneUNpUTR2U3FuN3VWcGxk?=
 =?utf-8?B?djJodlZtMFJ4WUhqL2s0dk85UHU5MllvaDVxMWtPMkZFWU5aaUcxdi9RU3U5?=
 =?utf-8?B?YktlRkJCQ0pjOFp4WGxid0dHdGMrM1NDbGhuWm1UOW9Kcm5FVk1YNGJTL1RR?=
 =?utf-8?B?TWVkSWtiZkZDSWJOb011VGw2OUtSaS9KckdzVnNMOU5vbFZ4bnJ1MHRrMTVK?=
 =?utf-8?B?WDNBODZMYXE5MnIwNzJrN0RpRkhXN2tWcTNEa1c3eElzYVNuK3JQaEZYUEdQ?=
 =?utf-8?B?S1gwbGtsRG9CWnZKSXAxcEM3VWhDYkRhMmNqVE9FR3N6emY5L2w2U1Vld0ZM?=
 =?utf-8?B?b2ZBMGwzYXNpSnc2aTMwTGVnem5WTzdoZVhPdlRKbXpyYmsrdVJxbjJFMTJn?=
 =?utf-8?B?U0FJUC9CK2RhejdtTGVUUTkrUkVIempROS8vS25laHhPU1lDOFZWdGlFM2JN?=
 =?utf-8?B?dVY5WnRzUzFPdks3dHNtbGJqeW81UGFBdGlraEsveWhqenBpSFdqaWg1cDkv?=
 =?utf-8?B?OGxIOEFxU1oveFFudUs2YXo5MmVEd0pITnY3R3dDQU1kUFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny95bFBUeUtxQW5mWkd3NjJzeXc0bTFydXdiRHNEVTczKzl6amNUZ3pPSkR5?=
 =?utf-8?B?L0ZLWmIwVlBLUXk3WUN4aXo5NHZwNFJQRkpsUnNzWExwSVJFL0tkN0x3aGJl?=
 =?utf-8?B?WmJ4Z2RpdnJIOEdzVDZZajhxMkRRRXZrRzdJSzMybFBCK3hqL2JXd09qUWYw?=
 =?utf-8?B?dG1vaFcxbXdHR1ZMSUFZZ0Q1ZjJjMlNSNERvbDdmVTZxVTRnN1Q0ZlFNTlkz?=
 =?utf-8?B?ZkZYVG42SnpramF6S0l6cUYrdXZOOXNoYkUrb1pSV3l1MSswaWdLRmFGL3NF?=
 =?utf-8?B?ZWYwazFOaWpRVWtQZloxNFdWRTI2MTNpOGVQV3E4SCtUUjhBbjZxNlBiNmtX?=
 =?utf-8?B?YW5BLy9sUjF0UVlWMHEvaUtmbVMxY1B4cGpjcmVhQVAzY2xPYUZCOVVxTDc5?=
 =?utf-8?B?cWlWeG9UZlVPQmVRZFI4SE9xajZPcnhxYjN3MHFzU24zdXF0V1gxR0U3NGw2?=
 =?utf-8?B?eHhpQmFpQmJsd0ZjdTJJVmI1VDhiVUJsQ3VEekI0S3Rla0o4Q1VvNGUrMGkz?=
 =?utf-8?B?Tm9JSC9lSGI1dTUwQW01MjdGYXRnWGdaZmZtUDFLb1ZkT1MrWCtDb0wzd01V?=
 =?utf-8?B?K2hBNDdiNmpYQVlsMytFa0pVTXJybmhpeVFQQVlma1JWQ1FwR3l2SXFvZFZ6?=
 =?utf-8?B?aHBvdXRzYWlwNXJ3SEJ5WFVwMmdLQlYvRU9rZGtqenAyQmRMMTBYS0VuYXJP?=
 =?utf-8?B?b0w2WmVyUW9nUjFEalpjR3R6eElhQk9CaGdqSzhaNTlTOTBIOEFKVS9qZXg2?=
 =?utf-8?B?akl4L0Nmbkl1NG1UcjkxTzdxdUNVbEhDekxoOEdRcG5WYzJhTlBOV1NxZUhQ?=
 =?utf-8?B?Si9rMkxnUTZIeWwrR01VcVUzbW50dzZlYjdWSFFOUWR6LzVTMVZrZjFpVUgv?=
 =?utf-8?B?SCtscW9hTlBiMnAyWWsyQXBtelIzV0RUVks1STlpM3V0V0pVWXh4M2xjV0ln?=
 =?utf-8?B?bTdGTjdXL3ZoVHNtVC9MWmJTUHBjOHJ0aFoxWmJOMG1JU2pYcFZLSUZoL0hq?=
 =?utf-8?B?VDI5RlF1OWNBRHFBd2dWQnp5aWdwYVRBNytIemZtd09pTDd5NElZSy9pbW5K?=
 =?utf-8?B?UXFsRkhOMnZRRDZPeUtvUmV6Wm1yZ0hQa2ZyeXNnWUdKbjdkTzVKTncvNGVk?=
 =?utf-8?B?QmNINTRudkNDZVpydGZMSzJtdzdsSGJGTjhSeWpxV1YrRFF2ZFdJR28reXJs?=
 =?utf-8?B?RDFIMU5VZVlFcU81ZGhnV1JPejZKUHRoVVllTy85ZW5HbjRocFcrOS9KaUho?=
 =?utf-8?B?SUx1azNybTVkWFBPUUVNNmZIdDdocjFtRHpERDhvS0JIay9UWmZSMGJLMTdi?=
 =?utf-8?B?TTJyUVhHdWJjS1JFQ20wNEpKT1pRQ245dXg4bDhrcmtTYUd4VGdxckRDNlRr?=
 =?utf-8?B?TUJjWk5NbGRjV1V3VzJ0cXJJOEVOaTZKOEcxQ25iYm5mM1VsUXhXSTdSNFB6?=
 =?utf-8?B?QWhjeGlNc3piZE5SRGRMbVM4NVJhL3dHcm0zbk1NQ280R2N3K2Z0eVNuWkNx?=
 =?utf-8?B?Vm02bVhmdCs3VStOSXJWejFaWk85ZXZMVVU2U3Ntd1VNY0x3MHJyVEw3emRQ?=
 =?utf-8?B?QW4zYTZmZm4raHRObjhiNEx4L0JGcDJHa0Q4N1JHdnd6RHNBM2FJSndkSEJY?=
 =?utf-8?B?SlRSenZNcTVtOVgzcWdRREJRTEdkbW9NeGZjcXBtZ0hJT2tkQWNKK0pRdll1?=
 =?utf-8?B?SkFyWDVuakJXSlNQaG1kaG9RejNsZjRmSjlXdDJpSGZkRlRra2lkZFFJM2lG?=
 =?utf-8?B?dFErSEtRcVZiMVIrNGQzVEIwREJiVTRwZ1JhT0xhbnByNkp4Qit4eVlTRjdN?=
 =?utf-8?B?R1BPa21ubUxDUFJCNjdoVTdKOHpRTG5zbXN3aEtCdWZESWEvTU9CRU9aclFJ?=
 =?utf-8?B?eW95RE8vUGNvazdjTmZDTEVEZFVUcTBJTEllU3MxQVVqb0gwMGM4K0JpOU4v?=
 =?utf-8?B?Vzg0SytiNzZ2QnN5YnBWeWtOMUdNaEcyVFJGNHFHUDhRZjJjMUx3YkxvMU5P?=
 =?utf-8?B?QU9qSWpLaDdJMGwzRE45dm1CeXZzclF3eWZRZjhkcnpaUGJIdVVFRDlYR3JT?=
 =?utf-8?B?b3EybGNXRmlYUXViMis3V0ZEd3F0NDhnK1YxOU9MZU90cng2WXA5ZzNwYnY2?=
 =?utf-8?Q?gTXk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33be159a-e7af-4348-d9a4-08dc99fee114
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 18:51:55.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xdcc84DHMOZG5w0R3wLixK7eWugH3OA4c6a3rqxb85vMThXH1e2Nq3YhfACSURjAFn0J4THfstZdo0hXrH23nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

On Mon, Jul 01, 2024 at 10:43:32AM -0600, Rob Herring wrote:
> On Wed, Jun 26, 2024 at 2:26 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > Add platform special compatible string for all gpio controller to fix
> > below warning.
> >
> >  gpio@2300000: compatible: 'oneOf' conditional failed, one must be fixed:
> >         ['fsl,qoriq-gpio'] is too short
> >         'fsl,qoriq-gpio' is not one of ['fsl,mpc5121-gpio', 'fsl,mpc5125-gpio', 'fsl,mpc8349-gpio', 'fsl,mpc8572-gpio', 'fsl,mpc8610-gpio', 'fsl,pq3-gpio']
> >         'fsl,qoriq-gpio' is not one of ['fsl,ls1021a-gpio', 'fsl,ls1028a-gpio', 'fsl,ls1043a-gpio', 'fsl,ls1088a-gpio', 'fsl,ls2080a-gpio']
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 4 ++--
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 8 ++++----
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++----
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > index 2e1cddc11bf47..1b6ab9550cce9 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > @@ -407,7 +407,7 @@ duart1: serial@21c0600 {
> >                 };
> >
> >                 gpio0: gpio@2300000 {
> > -                       compatible = "fsl,qoriq-gpio";
> > +                       compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
> >                         reg = <0x0 0x2300000 0x0 0x10000>;
> >                         interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> >                         gpio-controller;
> > @@ -417,7 +417,7 @@ gpio0: gpio@2300000 {
> >                 };
> >
> >                 gpio1: gpio@2310000 {
> > -                       compatible = "fsl,qoriq-gpio";
> > +                       compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
> >                         reg = <0x0 0x2310000 0x0 0x10000>;
> >                         interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> >                         gpio-controller;
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > index f8c9489507e7a..524b44f424272 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > @@ -589,7 +589,7 @@ duart3: serial@21d0600 {
> >                 };
> >
> >                 gpio0: gpio@2300000 {
> > -                       compatible = "fsl,qoriq-gpio";
> > +                       compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
> 
> ls1046a isn't documented.

Sorry, there are local dt-binding update patch, which I forget sent out.
So I have not found this problem when I sent out dts change.

Frank 

> 
> Rob

