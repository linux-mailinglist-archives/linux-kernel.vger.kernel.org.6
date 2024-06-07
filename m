Return-Path: <linux-kernel+bounces-205448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1588FFC21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EF6283972
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95489150999;
	Fri,  7 Jun 2024 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ehm9bb30"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2055.outbound.protection.outlook.com [40.107.113.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF11CA85;
	Fri,  7 Jun 2024 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741196; cv=fail; b=U16JXPnNQ6XmwkpcyxDlKOcKTBWWKAGkVHthHU/kH+iTims1rDlua3Yl0lPd/9ZO51aAE51NqpTVNqCgVj5ONjxLG3perXjyHy27iyY6N29D/uIFMIlm2VbyBS3XLhFtsseFxTuEzLeThOVm38w0GOOFbdXGEagd5Zva8MyQ2qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741196; c=relaxed/simple;
	bh=H06xU9hf+GNGUAjvSU6oNYt7xJ+DNfynT0FhCjqkeUY=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mSZqA0oyOfAv5VNhs4AY5UCbA9Us6dh6g/VFDfNJS7tyAbdR2T0mMNYimeskKAgTslTwaBJtOB3DbTrUIVLbVtuXfyb0MXEIts9tpYYivdsCzNF1KGuCvhrktUsTTYOw4zYlvqerWfzV4qrm34yb2Mc61XWR6JW30pu4QvpLUjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ehm9bb30; arc=fail smtp.client-ip=40.107.113.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P22Dl8xhGXslyAeZ+/VLDllDhh8JOoR7ESW4lyRNby+o+7m9RLPYvlqKE/HYVoRfWjfjK/r7GRn6ycuq7m6kudzPQ6LP+/Cq4CoMtqoLaT7eS0K/hdoiTj+DYQhmrQOpiB6QK/gC+7DQhrMiww33rod4FL8/irNNR/iUXCmNfPXLfg9GxxoUVR5fOooYAyEz+ctPQX5jXNqfJxaV57L4EdoohxwDvtFnkEQ1YWoQKUHogDMiMkjIGwq94ZledJerWuZOJhKGjobfutr1CMZ8bvVgNPe/8EYtTttmbWbZ//8JLM3L82PWgYNFyxTVdNWDLiUBK232y34tk9+nKXYSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cjgYQIkCVnQzMHKVCiti5jXtlj5WOwqEQdv8dY7LS8=;
 b=ickZ+ZAG8R7vIzzbp4bdrUrN2BDMobYBv3YbVRPm0/vJXvJPXgKJmd6j7jzewzxxfhmma8lhxFNuMoIVcdbh/soXM1T3OPf25ou69RrjeHrUFOjH48WR2Tj64+KZ0Fr5HQ5HtufwK5qiLSuVG00L09Xu3cnfDHUUqcCyh0zuDIHNosc5vWbkRHqfGvnZok6z5KcHTrm2pQeGHDhq9rSYrMNd5hGfctrMI8L06D+IuSGR4Ic86eOunvhdT1iIuLtDQL4DkauuxpWcHh0syeMnlqc7LscIFnpuHYWf7TY9rEJa8r1jjufz8wvJ1h7CSTdFMYaXh+8gUdwns+0g8xTr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cjgYQIkCVnQzMHKVCiti5jXtlj5WOwqEQdv8dY7LS8=;
 b=ehm9bb30BPClxS/FV/MTpyKEjZZoyYaXCeN/LhUFJb0IgrzRzAUtEpiFLJnPjlD8Xi94jYWkrVVL9heTMJ4tVrLsxFPN5XyC8BCtsAj8bN6fbErwCABMkvUaJ9U8ajitOaxfiq2opsS6uOY++xr12qVhzUCu5xzD8U3EFkeDVhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6299.jpnprd01.prod.outlook.com
 (2603:1096:400:86::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 06:19:50 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 06:19:50 +0000
Message-ID: <87frtps29l.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: ak4554: Convert to dtschema
In-Reply-To: <20240607055725.38057-1-animeshagarwal28@gmail.com>
References: <20240607055725.38057-1-animeshagarwal28@gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 7 Jun 2024 06:19:50 +0000
X-ClientProxiedBy: TYCP286CA0235.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::13) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: b79cf25d-52ab-4c83-d262-08dc86b9d678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TBQ9q3mAL6FzKxqD4F9/TarkXdBSVUIIxm/HWeGoZMCpgsRLU95ysE3oxG1r?=
 =?us-ascii?Q?qZzDJUsN6QouxTUMDStWUtzy1FQpV99LgY5an+HuizudhE53eQ/BiNn0iMZz?=
 =?us-ascii?Q?HRzvmVGl3GnGl8wo0aiTPzL0w7KEWJmQvl8tZGcFxZM4CHPq33wtS1q41Bje?=
 =?us-ascii?Q?+gaVLYxhP96mMvlrYJy3Vlcy/PxKw3VMqHtAXKBNM7Af+kLCnJc7tTeVJqio?=
 =?us-ascii?Q?o8kxkUzyWkbPpHiymYcAdKfdfsymLtp2boKs8gcBiEp3YIF6QHkml6L+I00L?=
 =?us-ascii?Q?ftz4QW82/q78G3Aeof+lPXOo2+RtQOwQ4gg3Ac+ZWwuoS0jUVB6mkKknNmBW?=
 =?us-ascii?Q?RBJiSWXdXdoc0HbjXANFvTMD6MNSj0D2BHtNnw/cAWAbO1FCexE9c6icqkqm?=
 =?us-ascii?Q?8nI1HsBpdHTPcDJTobCk6IgNGfufil0+zkm/ReMsDkYUgMgZFfSOzz+u6yNx?=
 =?us-ascii?Q?xmsBs+lF2becwjMmhXiUlzz1EwPwcP0IJ5RRza/2qjY4d17/HvrF98WIPaPq?=
 =?us-ascii?Q?gFwW6lsEOoSCkscLdSLIl8RFS40z1FbndJgCKLXZVki34tw/PRTmOVbxFCVq?=
 =?us-ascii?Q?IF7lT1FFd57ZuYi+9JQSHsNsLpFm7MHMAbLS5pVpPeFwM610KWZvORmP0N8Y?=
 =?us-ascii?Q?Kwj3Msexi+YQLZ7iy/bTECX7ISemQj0fpwnaKEvwoMcf6lZSLqVxfsbRWXrY?=
 =?us-ascii?Q?Fk9VXAcghSto48XodrHLcwURMVoeUpSdcmowL1ioz26KpHZz8yMVMIog/bZ4?=
 =?us-ascii?Q?ihtlZOEZcdpUIPcgEacIzIO1J8zrvw61K3Eply3vE1T6BdaTfg1mK+fRuVQ3?=
 =?us-ascii?Q?+5rS3av/Fpr8ZQ7e6FFH9ntgS0H6qL/eju8Zrw2x2eR+n3FHKyRt4/UUgihA?=
 =?us-ascii?Q?FveIOwLMzxElmXklmEYYPNTdwUe9wJp1CURLlHe6J5YLXo75s3DZYQUXaVD7?=
 =?us-ascii?Q?B1GgM+WmYYjepJm7mv2KiRps6NbvaFKlyoivqxgrowP2tfou7H8xso4+r5pH?=
 =?us-ascii?Q?f6Sd546g7dBXMG7x91O13VRduf2yxHyVr7OFt9iUmW/rBDTBsE2z4f5odcf6?=
 =?us-ascii?Q?k5J2RYdupuV+HL1V4xCny2tfEMJecfW1BlxjEq34z7QlgH8KU0ULrAj7BUjJ?=
 =?us-ascii?Q?SEPmR7C+QQlKqWAmpzVnkzLM1srkTToCLNeU1k4djN/klMb6pEzanZ30m15W?=
 =?us-ascii?Q?C8Ie5Rn0KnFC4SHfhgb+NJqUx9grwK9OJ5TnTriKTyGnT0Ov2jdBNUqipGw9?=
 =?us-ascii?Q?zO1dxs9ekcNOJXdvcu03s94Zjkn5I8vYay1iOVxj3faEuPgyBycegvdD0eSy?=
 =?us-ascii?Q?1mvCuIf/FzzH5zU7v6YbtFquJHYpiz/fh3sZw+8xaEPkzXqKRWQSCB0WHIwR?=
 =?us-ascii?Q?c5X5ivA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XAdpFfQNS2UYMtit2PttVuwHHMS+m/3F5l/6sehG4/2iJOmJ1olnNxTJwy/l?=
 =?us-ascii?Q?d/Kua3IAWcfUMG7buFq1+nqvA+rxXHX94Pb88sYHrmH9yaPvKbQiMHTCz6oV?=
 =?us-ascii?Q?NtoEE6sqpJkEY/hntW7Z9tDDInrDdNQ+Uzp5BImzilpExNdZn+TT2swQwiiA?=
 =?us-ascii?Q?bwHkOLXXSw/AWUC0vwyHA1nXw5kpyeyNj4XqIbPa7tFcC9azKw3sQ4AFkMqF?=
 =?us-ascii?Q?2xw5jWLogWGIuJCgUEwmkzmt7EWuNtxUj+kV43H7wTB/DKEdxyzX4CRxrK1f?=
 =?us-ascii?Q?Aed1yMGgxI1zFoHNOOz5BI5Psi0mAfnbsjR2U4UqbZUjfDX8BB2pyRCOmzba?=
 =?us-ascii?Q?+SeGUEXAaIlfJOYyvFFeYSu/6VRqu6lMnjiTnxzkCyLKR53NexE3fm43d2C7?=
 =?us-ascii?Q?bYpU180qE5a+2VMmsxqiq96T60AVJzt3lxor0vgqg2r23IOoXnCLkMHhsz42?=
 =?us-ascii?Q?3vsN7+Iy1O76J1dgcQ8QsQxtjZvZMdWOG8/Tpi8WL9gLH4bjYMy05hee7snP?=
 =?us-ascii?Q?UlGRkYOfVFck34RrQenEICh+kM/KWW5krzBC/Tra48jlXua+HZ03D7WkmSlz?=
 =?us-ascii?Q?xg0qw0lo9GLWxTgfa248JH0lYq5h8jbbA+5UXwmJe+v5xM+9Z+bfmCXg74EX?=
 =?us-ascii?Q?RM+8GY5Xw1lhjOKknyZ2GA+n0Z6j5JLzzRqJe2BCAAn/n1L1gT2TLcfKNA6o?=
 =?us-ascii?Q?J8WKz+38VGPFIw6omuQy4dfXj72up+pHh/FJ9r1q073i04gqOPmqC6RYpfxN?=
 =?us-ascii?Q?l+hZHXrTtM/Vt/B9rrRDotIRTNgjlOwWWhS2ll2dkc6eMP5nmJZ0wHoSW/dj?=
 =?us-ascii?Q?m0TBUIIrwISp/VEtw2/4Ze2vbYVA0oim1WlJtGS+uYEeLHWGB5kte2/AuNNq?=
 =?us-ascii?Q?wE22/16ryXCE4U28vYq/y50k7Ofd0VXYUOg4qKg9vV85gb6aKT9OiEW2W/z2?=
 =?us-ascii?Q?IE+FepglKeVy6Tm8A/CaXSlcAMujjoh/2lCd2fNcrpRmDkKa8Ja9+6a3XaIS?=
 =?us-ascii?Q?ewqyZPmE8hpqzFR3b1eYKgx5pknQ6vI442XynhOdYRHbSbPIpkIDeil4O2KT?=
 =?us-ascii?Q?SupwOBIOQb1z2aCBoQCCqLqiuO0Yg1ZrIBdG0JT23q1BbJJaJhPy64pW5P6U?=
 =?us-ascii?Q?Fo+tf9X6egzV9V2ocOshmb+vEaSPWbYNl4s95Xg5PPqMzqIA1k31GHCp8GSC?=
 =?us-ascii?Q?o9iPaXfWyc0hKIAnblyxZON0IJv/9tiLNEhkttvD+H+fDYWUjjeL7IhNhsAZ?=
 =?us-ascii?Q?ePx2fN7C3HY3nDchixce/paiqn9Udvc4TT96L/RzAAQ9iJ7rHsYKFO2pTOl7?=
 =?us-ascii?Q?axEUM+/mk0ZIFCqGWT6mEK2qnUbMEVOVFdMxKFvDwtvobhUNjCTXvemwuVsI?=
 =?us-ascii?Q?Sub2M9ceegN4vUBTmOEmDSS5PIQvwlZDiQR0SEFpRX2X7XuZ08J792WNowRq?=
 =?us-ascii?Q?rDV4d7yKsai+d3S4/ibzof44+OPQlsTVenltUsYnZf7WRbniXKcU1eOOzqqD?=
 =?us-ascii?Q?+OTiDWQx2JHH1k2fWBU+SDDbgXWqxjYLYfK53M/nRlTAq/HiDV3cdqaNZR/L?=
 =?us-ascii?Q?dwYGB3iy6Eci4JuC7UFJcHqwPWKX7c15syFYTKUV4F5jagiHlUD1KZxviUih?=
 =?us-ascii?Q?Za9QYMuD45CnlcfxWll+PMg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79cf25d-52ab-4c83-d262-08dc86b9d678
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 06:19:50.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBKAmIMCAUM6NY7lu0L62bNEZ21eaiz1gfh/N28C2IqxJmCxCH6rZW5XXIg1sRBxmexoQnT0EzWlQyGvl4fMysKKHmu3ZG9qyyeWy3wCvmywusohuz51GZRc2CQUJTB3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6299


Hi Animesh

> Convert the AK4554 sound codec bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Thank you for the patch.
But no one is using AK4554, we can remove it instead ?


Thank you for your help !!
Best regards
---
Kuninori Morimoto

