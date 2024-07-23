Return-Path: <linux-kernel+bounces-259864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D4939E69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80DC1C21FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15114D701;
	Tue, 23 Jul 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CmrnN2V3"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3544C9E;
	Tue, 23 Jul 2024 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728814; cv=fail; b=ufYMmSQdQ+FgXJM23X6TadNceV7xQC3dDpGcmlwgwu+fo8udyn1ks/fMfL0p+SoC9PDQl/Mm06OrhQJtVqeI8nLbWrkcSpIJnZirfNDYABh5JK7cPSfsfqPLSyQmeghOeVa6J8RNec/MR1XSKGajcV4zGRVvw5JT7a9DhvMIdYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728814; c=relaxed/simple;
	bh=CRVxNn0G6xBbzvofj/HSfFdcpMT6hpKdu7JrLK+KaC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BKnbv1UV5HWrfk2Cfgi6rKc6xYnud2ndjjBzFfbdjmbjRRhPggphxOsHdrNH6qP0tBvPhrS1mjZPQtGW4hoG+d925eIayHhJLOvnD292oBXfANLhhazut1jwl2IozvUZVXMJmyvAU3X9fUhNTZwNrj9LYsE4aNql7497/Qyi2so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CmrnN2V3; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWctAdQhXWL7klca7GelreakaLZDDykAr8kBbx5aoNXsKRtRHoSgTNeBAI3R6ZodACcN6EvP2xHDmWtqD0yj3PIG5J74yFY9zQ8JfHZrnQZgpj/Uh0lpsm/X9QkyS1qHllZ8XYqf5EhEo7lQKWZ6sqzl7E4uGXHVshHNT7mOyEqYLWDjwBPk3CnRxoF3f/4tRP33l8XliwPDIUNXbH0C7JMLVskhMeKMbuef+6PYaZhrhMNfyp3F447OGJtl+iDT1ZUGKKxCH/yTk5yiOduOnW6p6ECIXY+IvN/ZquMZlOFpNGfne2mL8rpHDyeby4JsjSfSKCLRxim2fq0bi9k0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTPqEbKMm0RwVnyPE6nzIJFcoUzyIs4aRNg4fjbkHUs=;
 b=fC6AuEBJs2gQwrDhc5TiSxwQOLxQVpFqbok0J2G7l4QVT8DspAWpegkpzHUUdH88Hh4hD67d7fe3XhXW0gTqEvj59iwjLNFzNjqV6GqW29sd4JHwEchXXkpjTGFybcDVZ/oDupR5GCC5mnkFAsk5bOT3cF6UoI/ZIyvALGx02e7AxZX6u0oJf7GJ1jwfsq0befBC7s3uAjEja+EmK0poJQ6XOcim+SPaMPD8vq5W1d4f69mbylVP0HRYgUHfN1nLHCvk08K/bp3QL+oNzhcLygKEbSlJ9jmU5tJne/9baSn/oEY4vIigde5IAcAVddXd5bIBzt/vfa8H6kN/88MZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTPqEbKMm0RwVnyPE6nzIJFcoUzyIs4aRNg4fjbkHUs=;
 b=CmrnN2V3ZvOamVTY6QvjOuPlQjN0XCm5WEOnQik57/SqyJ3IyrpeG1WC52wmRu0DnIFNiXIkWKdz2CKwirZqWBOHqqzcB1LrZwp8WQ/eBSR3VwZ8OEfQyItCuuVs8eEsyqfPcnDjUkws8V7iNGOzyXUfl9wOewFyJwUKLdpP2fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GVXPR04MB10022.eurprd04.prod.outlook.com (2603:10a6:150:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 10:00:09 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 10:00:09 +0000
Message-ID: <f734cdbf-d59f-4dec-80c3-4cc32898affb@nxp.com>
Date: Tue, 23 Jul 2024 18:00:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [DO NOT MERGE PATCH v2 11/16] dt-bindings: phy:
 mixel,mipi-dsi-phy: Allow assigned-clock* properties
To: Rob Herring <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 tglx@linutronix.de, vkoul@kernel.org, kishon@kernel.org,
 aisheng.dong@nxp.com, agx@sigxcpu.org, francesco@dolcini.it, frank.li@nxp.com
References: <20240712093243.2108456-1-victor.liu@nxp.com>
 <20240712093243.2108456-12-victor.liu@nxp.com>
 <20240722230934.GA233475-robh@kernel.org>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20240722230934.GA233475-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GVXPR04MB10022:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a35c590-a46e-458e-8efd-08dcaafe3c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjN1eFp2L2JJZHVrNWx6TlVGWTBaSng4emFzK3NmYy9mcldHUXF4NjY0TXFw?=
 =?utf-8?B?VkRERFJZdlVaSWc1bGxVaUs4a1ZSeVRYNk0rdXJwNTNLU2loMDBOK3o2N1lh?=
 =?utf-8?B?cTNUMm5nQmladTIvSHgycVNRbUh0d0xKSnpaWXpqNFhKM0d0L1B0NFpSMXE4?=
 =?utf-8?B?Y1I5LzJzN1R4S2lxeno4QlpTQUtqR3ZnU0VKaUZDK0dHdkpaRy81OHRqaktw?=
 =?utf-8?B?ZXl4SVkwNUJYV2Rpa1dYdjlSK2NjZ3lNUXZXditxZnRlQlhEOEdFbXYzbnoy?=
 =?utf-8?B?Z2x0MUZuWFdqQUM2OWFhcGNueXN4MTBTREdkNDZCb2hRV1NUYkhLYnNVMFE5?=
 =?utf-8?B?R0tsL1lQYTN4R1ZPNWFZcUZabTBPcEhtT3duclZlbTVzRElIMVNPZ29Hd0ZE?=
 =?utf-8?B?QWswRkFuKy95MnNzSXFreVdpMEZrb0l4NEYyRHV6cjdJK2dxTmVBaDdJSTg5?=
 =?utf-8?B?RGRiSG90Wit1L1FyRFRUYUh5K1ZFZlFPMmdlbnJYQWQzZnI4MkhtTjNvVHU5?=
 =?utf-8?B?bkYrNE80eXNuY3lnQld0ZmVObTlBdnBabVRHZ0NRYXhXUlF2dFlkcnNIV04x?=
 =?utf-8?B?YzNIQkVPVUJXS3pDZTBsanRyZnpGZXBVRVhJWkIvZU9KN2FCWDJ6b0lGZENu?=
 =?utf-8?B?UHdCWmVwU05IUXpndHludytCVjdHTE1wdTBBQ1Q0MlhrNGpoTTNZUnVlQmZp?=
 =?utf-8?B?aVgyUVl4WnA5SlJ4MzRnOExDb1U1VWg4MUtLKytPNDlGQ3lheWs0M283QTZj?=
 =?utf-8?B?SzlNZUl3K1E3RXQzbUZEZTBJZ3FuS1I4Qitlc1drc1ZiUTRGREFnblZuSkdr?=
 =?utf-8?B?Mmp5QUxjdjRVTXVKcEJ0ellvVHpqaDQ0SnNMQThOejNIMXhReWJrTkMvUnBs?=
 =?utf-8?B?WGtVYStZcnlBM3JtYlhjUEtZbE0vZXRwTTlMWTdaTmZUOXBBdXBDR1V5QnAz?=
 =?utf-8?B?aHRsejlUWWFsVnp1RW9lY3loQ0U5RUVFNUg1ODcrVEJxanRJbGRtY1RGZmFB?=
 =?utf-8?B?UWg5ZDJHdWk1dkFoZnI0NVFOQ3d1cndmYmprQVFIcmNYVEJZWEF6VTRZYWd5?=
 =?utf-8?B?bEowRWF0cFlCVW5aQjFOSjBpS2VRVGR5TXRKL2FjZkRuWWgzWnhzODkybjBJ?=
 =?utf-8?B?YUdMdmdXYnAyeksrenZDdEl3MmN6V0VkNHhpRjRQWEZUTUJKSHJpNzBxcEIw?=
 =?utf-8?B?dFpMT09UaEYvaXQrYW4xc1FLcW5jQ1ppWkZXRWloRUQrZVZJMnk4bitPZ0F6?=
 =?utf-8?B?QUVBQUFRczR3OU12WGswUkRvaU84MDhocXl5OXd3dVlJakEzZVJyR0FDUHBV?=
 =?utf-8?B?VWNBSHhyWkhUbUtpc1dkcjlaR2d0OEx4Ly93UW9EREZxNEdEK1l3ZFpRY2hN?=
 =?utf-8?B?VFphbVhvVHJsOWdjMEtURXFaV2FQbm45UHFSMEQ5T0hQNURLREhyZ25pSE5E?=
 =?utf-8?B?YnhQU3h3SDhBbnFUemlJQTE3UHRtdm9Sdi9TL09CYzBUdU9YZ080THNITWM0?=
 =?utf-8?B?Wmp2ZjEzS1NoSmdzclFXclJQRkJDNkc3RFVpWm1BRWE0anVmMFIvTHA1NmNV?=
 =?utf-8?B?UFN2SDNrSnlCNzJySWtFZnkvRjFDbGNrSzNqYVpzSXVaOXpZL2F2VkxyYnhO?=
 =?utf-8?B?cmVIT2VqZlFDZ0tNbEdiZHFVRjRLTHU2bzRBcGRJZnEweW1qSGRwUFFwY3Ev?=
 =?utf-8?B?b3JoYVUwZXVwWFhUYWFoM2NMVm5sd25rRlJzYk41Q1l1R2F2ekswNmpoTXdO?=
 =?utf-8?B?ZUR2aXFuWkJWOTk1cHM0aUlpcUdlajhhbERUb05LcG95WWdIYzkwNXhTOU93?=
 =?utf-8?B?dmxVWGsycXduMkxBblB3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXhlOHVvZnYvR0NlVzA0ZUU5TDlra2xLaTJjSlNBeXlXVUtIUktydXh3VTJR?=
 =?utf-8?B?OXlFOExiOGZJQmRSU3pYbXhHOHRvcExzN3ZJRFNxanlaUG5MYlBQcGVJYjc5?=
 =?utf-8?B?Y2dMM2pxZlFaVDZBMDFjRGwySzMzbUJwdmZyWmh4eXFrRGtydXpzTjV5bU1J?=
 =?utf-8?B?czY1Yit6cEkvRnp1VFgySTJhY0p1emo4ZmVoVjNzZWJnVGdJYk9oUkdybnh2?=
 =?utf-8?B?SEpLbFY5bE9nQ3FPajdBTEF2MTlBcjgvOGhzSFlIWUw4dHRvZGYvY25WZFBa?=
 =?utf-8?B?QnRud28ya05yby9MOHUyK0dkenlXOW8rWnQ0YlhWUUxHc1JDc1ZBWTExRCtv?=
 =?utf-8?B?OXlQSFNpdFQ5MmNhMU1VTEtDTmxnbG1lVkdNdlVIV0Nmb2J4d0xwcnJTRVEw?=
 =?utf-8?B?QjRIZWV6dEdJR2JZYjVSTWRxb283M1kvaWhMMzA5cVNYV3dleFZFcmdlZE5Q?=
 =?utf-8?B?c3MyVmdmZXh1MTlucmVxSFh1SERhWTJtV2RoR1dqeTNyNTA0T1ZyaGNqMk1s?=
 =?utf-8?B?TnZVU3kxOGlxeEY4cllkU3ZieWwrb0dMdU8xR2N1VzFyS3dJOGF1bmdaUU9v?=
 =?utf-8?B?UEU4NSt1SmR0bWFLYmVRWU5HMUFMS2F6K1VpcW9pUnp5MFBOZjg2U3ZvelFr?=
 =?utf-8?B?SE02YkdUR1JvT1lCRHg1VFgwdlgwcUtaa0M2RFBVWW9iS3FEdk1TTThjU0s4?=
 =?utf-8?B?UWNJNHA3bXlQSkxnRHRBSE5KSVBhdXFiSGlBcXQvSGY2V0dVMjhnNWNyejRF?=
 =?utf-8?B?MCs0bzRFV3pJR25jc2lUVVNXeXFEZ1QwR2JiMDZ3REZabGxNNE9mMDFhcGlO?=
 =?utf-8?B?WXNWQkdGZk9qSW8vVTk4V29HQWNnZ3JwdDBGSm9GT3ZZL0lxOEZlUjZDcXRR?=
 =?utf-8?B?L1Q5Vkp5cDR5WDA0eU5GcjV2VUxlN0FzVXliVzJCM3NneXk3WDZKZ2ZiMDhz?=
 =?utf-8?B?ZUs1S211T3hHb2ZyN0o2czNJSUlIZlZicExsZjRaOVpGSkRXdXhPRVl1SzNI?=
 =?utf-8?B?RUtDWkxkNUtjRXpBN2RsMFBGbTU5Zng5K1diVU80Sm9KVU1JcVdCQmtZbnc1?=
 =?utf-8?B?amt3R1J0VzdkS1ZIUGY4M1Joa2NFNE4xeVlRSDRmeUxkU3ZkdGtMbTVVNS9L?=
 =?utf-8?B?U2p6bVhNUEthUEFJUDVaY1FUd25MT3ZiVmlHb3drZC94QjkwMlNTaFdQaldG?=
 =?utf-8?B?Q0plNENoNnh6WVQveEc2a2cvSkJ2cjlUZldFMjhQQlluZnlVMmdkU2Q3WTI5?=
 =?utf-8?B?MWU2VEJQZ3Yxd2dKbnRMakVtNWc0UG1zZHRaU0NiQm1ZSkpvN3FYSE03WmdS?=
 =?utf-8?B?bkhYNGMyR3RvV3hKOUpxVW80ZzVpaHloNlNOdUhvWlZ5VjNWQ1Rqc2hWZmp1?=
 =?utf-8?B?Q212VWtqeUZYU3VSODR4ZkZ6eVVzWWYzSU5XbnVJQ2pqVkc5c0hxR2NFR1d1?=
 =?utf-8?B?OHQyL3lkNkFSc1R1cGxmZTFlb2JNMmV6MTJlNW1CUE51Z1FPdkhoajdCMnVi?=
 =?utf-8?B?NkFtdWowOWhrRHpoa0FEeGJabjRkSi9xSlRweGVENWRYWS9kb1V1UzVWUlNJ?=
 =?utf-8?B?QThlWWtTcFdST081QXZpK3VMS2VwcjVMbHBFVGZWYm9wWUFTWmVHVmVEWGZU?=
 =?utf-8?B?dEhQUUo2RkluV0R6OU9uSTBuUjk0UkwvMFdyazd3ZXdXVUpUQlRxVHhMMWpO?=
 =?utf-8?B?ZWRINlN3bFJYdEJJQ0c3MkQ4WU1kclVlTjRuR091Wmt0ZElvdldLVWxnSVpQ?=
 =?utf-8?B?S1Ftb2l2UUVyOU1MTWFjeWE5RGVTZFRCQk1tVGlVaHkrQWExWExQVkJsdUF6?=
 =?utf-8?B?MGpBd2ZocTk0YU9BQ21WRkdGZ2tPRk1QUmptTjBydlNJRm5EZ0xneXdHZElH?=
 =?utf-8?B?SnlTY3BlRE1OOXRGSEN1VGNRa05CYlY1QkR0WkN3ZEZPOWlZWGRSTkNPN2Rh?=
 =?utf-8?B?L2lkc0pheG9WYlgvQ3VUY3Y4MWpSaENvSmRjTGRrUml1VytWdTFYT0tZTDJm?=
 =?utf-8?B?Qm9uVXNjT1hFU3QzZ0hnNmhLR3d5Z1l5Qm5XZDFPV2FmV2hVbXJqK2N6Vzd2?=
 =?utf-8?B?ZTZWWmNmL093RFp6M0FmMXJuclp2dktHOVFOZUFpdC9yZkNyb0tUeVJ6UHFD?=
 =?utf-8?Q?di9H49AERTULFNADdAZPCFniB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a35c590-a46e-458e-8efd-08dcaafe3c9a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 10:00:09.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vxW1zkNZF2FvQggm6pe5v5ZF27/GAuVhN/dn7y8HKLR1o8IkttAiLDPm6dxtCfa8EHZjQvYaQc421GwwISQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10022

On 07/23/2024, Rob Herring wrote:
> On Fri, Jul 12, 2024 at 05:32:38PM +0800, Liu Ying wrote:
>> assigned-clock* properties can be used by default now, so allow them.
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>> v2:
>> * New patch as needed by MIPI/LVDS subsystems device tree.
> 
> Seems like this could go on its own, but if you don't want it merged 
> then I don't need to review it.

This patch is needed for testing a LVDS panel along with the display
controller as wanted by Francesco.

I plan to drop the "DO NOT MERGE" prefix and send it formally after
the display controller part lands.

Thanks.

>>
>>  .../devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml          | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
>> index 3c28ec50f097..286a4fcc977d 100644
>> --- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
>> @@ -72,11 +72,6 @@ allOf:
>>            contains:
>>              const: fsl,imx8qxp-mipi-dphy
>>      then:
>> -      properties:
>> -        assigned-clocks: false
>> -        assigned-clock-parents: false
>> -        assigned-clock-rates: false
>> -
>>        required:
>>          - fsl,syscon
>>  
>> -- 
>> 2.34.1
>>

-- 
Regards,
Liu Ying


