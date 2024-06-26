Return-Path: <linux-kernel+bounces-230284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4311917AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530231F20F99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175B9161304;
	Wed, 26 Jun 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q+c+tj4k"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83E1662F2;
	Wed, 26 Jun 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390196; cv=fail; b=Yd02zaV/iCiRKUxrEjBiw29FxMBbusZe3u5CBHuulwkJc+MeSup29A73ZMHHtCdGHDx0mibW3U1I7ZAG625A1xxj8T9EkmwzJ63wcptPhsYpMexmRb2aDdMWRBIqwRot/VJNdHVRHkBdSTtqft6sT7KL30OgZvljOk07VDgB3PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390196; c=relaxed/simple;
	bh=Kcrjm65USdQ462qiumlR2p5jZ3ekh3RTSby9D2FAOBI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D2faKAiUc77fnt5EfeKHmT9CDDOXgBHT4Tm0sLqGfR6RDo9oUXbycq9JC4bez5cxpS9DzlvjVDyw6SqTRZu2CnyemFgANY7Il7rKZhYU5NFYt23taL+6Zva94f9E+ahqY3GkYSRVQafLjfdK5e8v7TJm1TupM0nPvjYGTbSWORM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q+c+tj4k; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/HK77+vNiFwJ4npdpMtHArRprBZR6n6BMa4igsMR+MSw4sXr1HHKdW2bZoeZluwTh900fzV6fDQo+nfFLFsB3TVSpnjsA2lYOBLVnIblzO7gJu6HGp7dv7lo9S173R8F6ouURWQI78umHWCu57g2OL+eSZLsgfj7QdeAhXcr+ZQAwlG6FkfiKKQSd9E6pkYPpxqtHF2i0VYzZyqKzA3hfk/BfZpwwXZokqR0+dtViIZn/G89zxFQx99u+oTEoiiB8u2yx3c0mxCRfWFfbYrKNciF81tGTXI9e+PdKFk/DS2RTrpQ/OmtElBIzix3ayXGKNWgKde5a/JGOmyKlHxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtIACtbITX8rBk+33i9Vg+kIjEAJfifW6x8hGRN3SGs=;
 b=h/3TTB42Z1bQJapcTVhuMVCIxf88M8XLarWEzv3YcnQhCL9sGtrSWepZy3sewVt6OVG0jL1yICG9M0VCYsnYIcB4M2HtMY1zlwIWF3Z+wFN2XyP/eQ+lYZNRG5ESqyab5Ll5HwV/gx6zWEaWDUEIL6Nx3rDJQbw/PPfh3mqnArWhlSrZo97slkUIL0DcZfJ/MrGCeWz+hgvSs9T/EAXq4xPqGgFmjTSJDgu+hu7x3ILAyQlsX7V/OyO6eMSG4QvuspB4XcwuqxsRlHueMh0jgNxMj+3I0Elmaejv0ZJQPW3Pt5GTome9rcFSrMxRyoXVFamaCBc89ZppeX653AAzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtIACtbITX8rBk+33i9Vg+kIjEAJfifW6x8hGRN3SGs=;
 b=Q+c+tj4k46TlVKazNp8cjNa/zS6Mk9nswxRDG7lIsUh0I3gzijB360pzu8n7+05tNdefG/28OPtfcDzowCsImw/4wt+4FGwzc9LgKOAF+T/NsFl9MR+m/8BW0sDNz5np6EWZT6GVqaYCuYeKHipDP32LO9T+mcRxGDPTaBsRLMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 08:23:12 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:23:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 26 Jun 2024 16:32:11 +0800
Subject: [PATCH v2 2/2] firmware: arm_scmi: create scmi_devices that not
 have of_node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-scmi-driver-v2-2-8f2f85b87760@nxp.com>
References: <20240626-scmi-driver-v2-0-8f2f85b87760@nxp.com>
In-Reply-To: <20240626-scmi-driver-v2-0-8f2f85b87760@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719390738; l=2433;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=uIz5E+KxA+WSlZpU5jkPzIV4/vUMnMoR0lxYv9gMsRU=;
 b=khrM68AbMN+IwacMZCcUSmElW6CyPoHXWhw8/N08MHxBf/+fDaWm5nXhQ5xMQS+1bs9WQ68mz
 eCJ1CqUd9OeDLBgD/VOSI4QX2RuFIUT8AqlthDGlE1x62PQiS/unGF4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d08e378-51ad-4aa1-3307-08dc95b9381f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEQ1QUJvOE5YWUo4ZEY3enhKZEM4RXZTSFFNbXZXMCtYZlpGeEs0ZFV5bXNN?=
 =?utf-8?B?TEkvL3oxWlZqOTFBLzJJZmIrMEFaNXdTMXhlVUFkVCsxOW9WT1pwQmo0SWdo?=
 =?utf-8?B?a1gwa2t4OWMzNHlFdW04Wm9JL0FyclVPSVRmTVM1QnU0UEpHN00wZThLV3Mr?=
 =?utf-8?B?WlVaV3JOWll6c0lEWEY5QzJpWXhKT3NLNjA1b2VaY2syRTB0QjBYL1VaUUhU?=
 =?utf-8?B?TWtjQkhvYVl2MmxrdGZQU1pZY29IUnQ4amlMbHJsVTRIcEc0ck5ocDZ2b1Ez?=
 =?utf-8?B?eXhlWTQ5WW1JTVhEbHNITVh5R0pCSU1VNEN2NlBjSms4bWVISHVDSjk4SEFH?=
 =?utf-8?B?MFEyUzlEYk1COEhPSGdTUDRtQ2NNOXN6RjRCYW54dUNuTjQ2NkZldDVsZEdR?=
 =?utf-8?B?UzhjRE10eUFRSEJ4b2FJa2g1U3l0MzBHSWtSSWNHOEZ4eGpJNDFhcytkd2Mx?=
 =?utf-8?B?TmtXeVNPdkxLN2VSYzI0emhEOEoza3BtVXc5czJLNVhsWVZMUW01WFk2cjly?=
 =?utf-8?B?RytKaDZQOU5oZTVBR0RHbnM5NEtXY2JtZ0VrZWNWQ2wzOFZJN0xlc3k2Kzdl?=
 =?utf-8?B?VExVY0ZiV0dkaXZmZGJkVzJPc0dtOE9MY2VKbVltMFozczBJdHNQbWF3bVJI?=
 =?utf-8?B?azNqV3hQbGZYWnB3MHQ1dm1oVk4zQys4b2pNWGVSSDJTVlBPcko0aE83ekNW?=
 =?utf-8?B?MVJ2RHlqSDZtdlhXcDh2cFdmMHJQb2svM0NtZzhheHNOaGpCTWE0eVBDYUkz?=
 =?utf-8?B?M1crb0krQWc0Ykg3TzlqemdXdUI4dGdTdDY5ZUplVnNMcU1hZ0dlK1prYUJI?=
 =?utf-8?B?TEIzUEVGelFPWWk5N3lKSWNER0N1QUprN1ZTUnJieXlFVWZkUmxjcDFzMXI4?=
 =?utf-8?B?Rmw3RWwwYmQzdzRVSklqWklmWktxeTYyQ2pmMHErWFlFcWtsOElJb0N3bTF3?=
 =?utf-8?B?cTJIcndiTC9Yd2ZjRTB1cXNRQTRxQlhESE5FcCtlU20yVzRLMWpOTkVMemx0?=
 =?utf-8?B?MVpQVUROWjdxZG5PWGI3UGxFbVV2MENYWHJYRk4xSEtUKzRRUi9BVE9ZSGlL?=
 =?utf-8?B?Z0hMeEF4MmtLdXZjSnU5KytOWjNyemxsUEFPUHpFNGFyejJtbnhpdUpzU2N2?=
 =?utf-8?B?cjlNSE95YWhuUHA5WUJCOUZKZnhGZmlTcTRKMlZNNTgwWGoyU3RkVHpkaG14?=
 =?utf-8?B?RmJhZWxYeGhkN3liWnBoQjlDYjRkNFdTdzlNaGFQMnRqb1M0c0NyR2orbjBk?=
 =?utf-8?B?N3NKWWdRWUFXY3IvMWpUMzRmdHBwNXVXK01uV1RnVVh0bVJCTFZMOU5SUFlF?=
 =?utf-8?B?VDFaakplZ25senl3TUYyNEJtRng1ak9zeVYzS0JVbHZmOHRaRUQ4S1FmTnM4?=
 =?utf-8?B?bHBBNSt2KzdFdXNkbkhxRGpxSWN2cWxyTkF5dEwvcVY3QVlTT3BmYVh2R2Nv?=
 =?utf-8?B?WGtQZTl2Uy9reTdBeU8wUkZ0WGRnbDdCN0tydmo1TnFxb3JiWlhrZm1iNC9J?=
 =?utf-8?B?WHh4Z1FBY1NUQWRwS3JDeDZRNThnYlBKK2MrQjZlWXdNb1owTmQ0MUE5amNt?=
 =?utf-8?B?cElDZFlaWjdwRnp4ZitaaHNqQlp0eEc0S0tjRVA2WmVvN2tRYlhENW4wNkx4?=
 =?utf-8?B?ZFRSSmc2Wmt3a1N5clMya3dsU1g3by81dytJbTdoaGVmcndqZWhtbXVjZEtP?=
 =?utf-8?B?ejlXU2FVSjMwbGlwcG04cWI3VWNuZmdWTU5rUkFDZTl2cUh3N1dSdS9QRlhI?=
 =?utf-8?B?Y3lmOXcrU2VMNk5TR05aelF1RURIY1NJMElmWVNILzMvVklQR2NWazN0NkZy?=
 =?utf-8?B?bW42Wlg3TU5iZU1NVkhjRENGUEFKSTJZY0xUQ2Z3QmV2YjVDRWlXTUMvSUhK?=
 =?utf-8?B?cGtOdmpPMzVEQnVaK0tWTUlqWjFFc1h6Y3JYL1pNRjI5OHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzVGUFQwcEZ6a2VIZ3c0Sk16ZUJZVW50czREWDd0U2xaYWZRQk5JT2tDYkpD?=
 =?utf-8?B?bG9OeFlOc0VRZkxWNHBPR09vWHlVZVVkWHNSa0t4aStCVUFPdmNiRGVYK1Rt?=
 =?utf-8?B?MUd5QWtZZzZ0OEF1YmluMFo1d01BcE5tc2cxcU5jUmM3aFNDQVhqZUVkeC83?=
 =?utf-8?B?WHYxTFNPYjlFK1ZodWVLZG1hb3p5QjRSbzh1V1pCaUEzSWkxM3ZFbXJNdWZI?=
 =?utf-8?B?SExIUXZHcHRXMldtM3pUL1RRMHpRbzE1WTE1ZFM5RTRoQVFxT3daeVpWSWpE?=
 =?utf-8?B?NE5jenlsRzFqdTAwVWlYUTlDaEJZaGVVa0tCeDZPM0RqMzE3VnV0RnBZTENT?=
 =?utf-8?B?NW91Y0lXY1YweEYwckY1VVN6NWhTS1Q0R0ZkZktpM0VMdWRmSUdIdkpITHFx?=
 =?utf-8?B?Q2NlYllRUTFuNWdHU3k1S2ZlbE5PWGFpZ1N1cUpXWmtsY3FSVTdMNFE1cjI2?=
 =?utf-8?B?bU94WW9VYkw1R2w3d1FhS2lNTEloUkVOR0h5a3ZwYTI1Njk4QndjUGJsckNS?=
 =?utf-8?B?aTBwQU9JWnFLYmsvZnI5T28zRjhpdElERFVBQ3VTemhFdHVXcFN1VlpUc1E2?=
 =?utf-8?B?OTBmNFlwWDFTYmIwVWxHR1lacGVBdTdRaTVBZUFpc3l0c2pvT2ZrbkRlc2x2?=
 =?utf-8?B?a2F2NEtOUkd1MFVwMFJtRG5CTlU2dkErZHhBZXV0ZWk4akVUNkNydGV3TVVG?=
 =?utf-8?B?UUU2dkJ1cDBaZFowR21jbGh3dDBqSmVhSityVXhDZEJXdFNSS2pDeEl2dGJ6?=
 =?utf-8?B?ODc2SEEzM04vbFpnd0xMK0s1akFuaUFCWnU2Zk9aQzVvUEFKMm5nZDJBQ01Q?=
 =?utf-8?B?RWpXc04wSWdta0ZFeWZXc29KNm8wbnRiaDBHK3p0dmlPa3h6L0xLWmwzZXlq?=
 =?utf-8?B?SzVGUHNiSGlZalB6WnBjMXB5Tis4TnBiNnRPR053L3VQM3RsVnFQbTdMdVRx?=
 =?utf-8?B?WUI2QW93OW9jbExvKzUxM21xcElhWGEwTy9GUVQ4eWlRTU9Wd0tKdDA1YjlY?=
 =?utf-8?B?cW95MmFoRUFRSitQd2xqS29MOG5hQWZSdFBQNnhsUWs2NHNjY1NCb0lxdnhN?=
 =?utf-8?B?bjFFL3lRTzJvdjhOUmpOV3RHUWtlclI3Z3U4NWhoS0t3RmZlUlZzdDgwK0hB?=
 =?utf-8?B?WGtnNHFONjlWRTY3c2drck1IQVZwdmZxSGhReEU1NHBHSG5IUmhnVjFNaVlC?=
 =?utf-8?B?eUpHQXovWVd3S3N6dXQzVHRmVUxHV3grVG8wUlBQMFpYcUplN0FGY29yK0Ux?=
 =?utf-8?B?TUhrbGJkdjdqcit5OGwxL2E5T0ZmUjkzbXNCTzV6NFlyazdlVkt0dGg3UEtk?=
 =?utf-8?B?bU41UjdEV1pGdkU5T3hSWjdVWmF6am1HNlJJMWxWc2Z4bTFQV0RIanB0K1la?=
 =?utf-8?B?cHhENXp1elhCTitYVWpyYTdaWUhYaU5idmJHd0xrbXl4bmF4ZGJXWmNVaFpU?=
 =?utf-8?B?bFhqV3I0ZlhCdVpmZE0vM0lYOVpIZW9QS2k1SGg4UjhIcHZNNVRZLytnM2E0?=
 =?utf-8?B?ODVQVm1XbXNaSERVMG5jM0kwWGRSemxvd1lsU2pGOG02YjI2YXdrRStNRVR1?=
 =?utf-8?B?Ry9mWXV0alVIR3ZSMk1KQlpmaWhNUzdjKzYrUlRFZDA0RFQwM0NxOWNSQ2FB?=
 =?utf-8?B?Z3BIdWdkamdTYlZNKzh1TFZ5NmY0T042aTUxRkNZc2F3RXF2V2wzVkpCL3Rr?=
 =?utf-8?B?TjNZdmdqREFubm93M1ZpZWF4Y1RVTUVpbFZVUkRHWTlOMzlBL2o4a1ZDRE9Q?=
 =?utf-8?B?WXNXZUROSERwa3IwMzVSWHNkMnN1MTFXTk45ZmpZK25JZ1J5QUxzVzg5SmtF?=
 =?utf-8?B?UzdzbVBnTVRsdktOdTlhNlVLVWYzUDNPZkx5SENoTU5Vb0psKzlGdCs3ZTJX?=
 =?utf-8?B?YjRtQlhON2NqTGZPc1dPNWRZNjRia3VZamRnL2ZjT0d6Q01yWC9QTGJmOXZj?=
 =?utf-8?B?ZTd2WXpUQVNPeDAydWQ1TEZiL2U3clNrQkU1U0NhQnNWVk96SURnbmRHME5m?=
 =?utf-8?B?elpOOC9NSG12YXVtejdMbkJhMWgyeWpzSVBlQ2srZUpWQ3JNaWRhajVMbTIv?=
 =?utf-8?B?VlJOcWYyaC96YlB2ZmM1dWtydnNpelZERmJwUDhmaUVGSmVLcWc3REI2Z0to?=
 =?utf-8?Q?lG4k6ueX+9QRWVakT0RxKOoVe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d08e378-51ad-4aa1-3307-08dc95b9381f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:23:12.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoiO8tMRdWkinBb8OyTUh6aU6xJQ+aCWyMwKdNg48aVtFMENJzr0V0ND4cZu/dCvF0DWPgdMMJJStgELOiS57Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165

From: Peng Fan <peng.fan@nxp.com>

The scmi protocol device tree node is expected to have consumers or
per node properties expect `reg`. For System power management protocol,
if no per node channel information, no need to add it in device tree,
and it will also trigger dtbs_check error "scmi: 'protocol@12' does not
match any of the regexes: 'pinctrl-[0-9]+'".

To enable system power protocol, need to explictily create the scmi
device and bind with protocol driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/driver.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6b6957f4743f..44a6e64eb78e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2952,7 +2952,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 
 static int scmi_probe(struct platform_device *pdev)
 {
-	int ret;
+	int i, ret;
 	char *err_str = "probe failure\n";
 	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
@@ -2960,6 +2960,7 @@ static int scmi_probe(struct platform_device *pdev)
 	bool coex = IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX);
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
+	uint32_t protocols[] = { SCMI_PROTOCOL_SYSTEM, SCMI_PROTOCOL_POWERCAP };
 
 	desc = of_device_get_match_data(dev);
 	if (!desc)
@@ -3114,6 +3115,36 @@ static int scmi_probe(struct platform_device *pdev)
 		scmi_create_protocol_devices(child, info, prot_id, NULL);
 	}
 
+	/* Create devices that not have a device node */
+	for (i = 0; i < ARRAY_SIZE(protocols); i++) {
+		void *p;
+		u32 prot_id = protocols[i];
+
+		p = idr_find(&info->active_protocols, prot_id);
+		if (p)
+			continue;
+
+		if (!scmi_is_protocol_implemented(handle, prot_id)) {
+			dev_info(dev, "SCMI protocol 0x%x not implemented\n",
+				 protocols[i]);
+			continue;
+		}
+
+		ret = scmi_txrx_setup(info, NULL, prot_id);
+		if (ret) {
+			dev_err(dev, "SCMI protocol 0x%x txrx setup fail(%d)\n",
+				prot_id, ret);
+			continue;
+		}
+
+		ret = idr_alloc(&info->active_protocols, NULL,
+				prot_id, prot_id + 1, GFP_KERNEL);
+		if (ret != prot_id)
+			continue;
+
+		scmi_create_protocol_devices(NULL, info, prot_id, NULL);
+	}
+
 	return 0;
 
 notification_exit:

-- 
2.37.1


