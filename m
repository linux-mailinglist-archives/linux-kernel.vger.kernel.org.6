Return-Path: <linux-kernel+bounces-529727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30EAA42A49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0473ADBF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3163264A88;
	Mon, 24 Feb 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fW9OtSLQ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49615E90
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419156; cv=fail; b=qPdR2HecmCMc0tvIdL7E1mfCc0kAMhl4HEEf9ZE001ubtnNiwtD/DcrDnd5fPHV2F3E0NU2y+S+y4+UU9ekNHkdeA49z1MIo533EedRlj9wx9rR0+JKI9QmvbIK4WV4Hcep2Q38g7ukLZuoFrsRquED+EqDEBqOz4H0X5WnXF8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419156; c=relaxed/simple;
	bh=uFbaxgH46uAr1wH2gGdqjKXun5eGtv4QVIod6hzQFeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nOVC8lq6dcydfBc8ZwoU8MVq4cF4jWes2U+Haxng0GUql3JhJo76hfEmU6wmADG+LWwzq8gKmDOVKjSzgLSJ2DNLMysm4tBGR1g5F2pTLLDPz2cVfwEO9VAY8uTzxj4cLJdAk5x49NhgfME70vKbFjUnzLiaI3ft/oL8kgRoAMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fW9OtSLQ; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkU+Y0HJPP/bKXTYkHDNW0EU+7CJ7LQgacE9PE4yYGCN1lzB3VsqSl5zhdDjOdnI4pOfQaRP+Ic/iLwSrMivZaPYb9fml1UGzTDVWxSx65zVlTU8eSGhlwdj2wZhaP1VQ9g9kPe+QbTKZ3Dw5or3LKrjoqjA/hz6DRBBJCShG/wSymB5x/nNWKKEBeTB/z+SZxAUKItSkhOO8iM3G01v11lpXSewGFh0DvLUuzvgSWPfXLpYQmXIaIRU3/BY9R8DOwHKK4QywxBAk7b/jBVJpafVlPBvd+yTNPVRTs+c+SxQQArYu9e9k+2egGW8SPNeX4c4RWIOzcHG+DhY7JC7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IqRxlsvxAczFwcs/U1DJMI8b7vRdGn+DYx5i5cF0dk=;
 b=i7RAL/v1Y0UmrGr+TKcXlTYRcB3pyoO5fn2jF6unc0cfnj/0PFVlEK5np2B0pKG4rd+fdz7vmfjJZkvwAXltqZI01lASWnuaT2tcJvgajG7q+0NXt1Ab5IWfmjq0x9YAlInT/d81TQ9SY7nzKskV9L3gb4o+8x7Vq/aLbNPl0HHQORjJLtNvBLS4QL6K9SkMCvyW41KV1zwl1La592UcsjgjxOni8bn44De6Rzu98CGIGEiipHuEaVzywN0uSnkN3KUqhCM98c3Oh0S5Dx++BeWHvw3r94F4nXLD3+GvI0ILL3XEEKTWfcGgKPQpvFlhd2nn7Pz8vP8Cd41WfNm84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IqRxlsvxAczFwcs/U1DJMI8b7vRdGn+DYx5i5cF0dk=;
 b=fW9OtSLQLhzajc5mmI/dBcF5lc9+hVgnzgUt2bRh0K48aHAx4C0sF37dYEcUDw6GosDnlPKXqtNyOCJD9OWTFrDvPCUzwm1VQlB5uhm3U/kFSPT5kjFqpBfaJdCV6QEG8iqQ5sUyTEVMssVz+baSRcyhrXV/uImm74sUc5MTun1W3tRSglZJdPXl6J+AZvkrwWItVVSBhnp5f2p/Axtxj4Vo7JWEyLIrNtj1oPzQWJkeG0IE/IT2dvAY+AmioTaxV1TIW3oKSJfBqDvINjXNl20gNxosIRIgTTCvyf89EIHYb7vzOHo69y6tnPJI9H3IxVkx6A/LiIKCNehQN1/LlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 17:45:47 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 17:45:47 +0000
Date: Mon, 24 Feb 2025 18:45:44 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: idle: Introduce
 scx_bpf_nr_node_ids()
Message-ID: <Z7ywSJmPEr1ojN2e@gpd3>
References: <20250224164921.214455-1-arighi@nvidia.com>
 <Z7yuuIL7-GMv2rsI@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yuuIL7-GMv2rsI@slm.duckdns.org>
X-ClientProxiedBy: LO4P123CA0326.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: cf46d126-7264-48d9-f923-08dd54fb1231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYkG9RNoiddNc2usY5YzTGCBxeuBg3FYXK2TBGvoVyfmWdg2obllx77Al6T4?=
 =?us-ascii?Q?XGrdDYsfxSGEfrAGnIYqYIeT5UoXevUygP8abSi50npdszwk8coNKuDcql7m?=
 =?us-ascii?Q?cNAG/tlgQx1TmStOfZuzY2J2mx3Y60Z18ksW02BKPc2xpnVu3dxjfOUOqAwB?=
 =?us-ascii?Q?89/1SZszAtU1qAYdRAE6sUJhb+tydTYntRj1TP/V5XDo/S9/69+ZzEmWg4to?=
 =?us-ascii?Q?ZOusnKn27wtSA6UDa2gElaWFrbwRNKLsVbwfc2tRqxydX0xWp4BYgn+RqAmE?=
 =?us-ascii?Q?WgTWn2S+LMhcfFjaW9WR5ww4V3MN8pbtMC4Oumop+quUDlCDPwIISR7BllTL?=
 =?us-ascii?Q?EzRRa7CCiR9/inGSjwxRIfsxwO8V6W37tHV6l81qUo/8GFPsfMGaB9QDa7SM?=
 =?us-ascii?Q?XhA9OL5SJV1DVMC39szAyHmsjEhWqBicMbEhFBROKq215u8v/QAn5GiyLqkE?=
 =?us-ascii?Q?s8Jduihy/dWesuzjFy6y39Dl2s38elAtwhl1EVPgluyzgRknpDyBmMUVZGMi?=
 =?us-ascii?Q?Dw9S+wpaWLUw8388xvr0fsLlVQ6BphrO1LOX3BPwKV/iMUf2y4YqrH8p68+k?=
 =?us-ascii?Q?56U1LEyBNP1E3+l2D4tVN17Y2ZKIYUZRPskOeLlgEIY9fRPFN2v2zRfcEiGX?=
 =?us-ascii?Q?cFp4RFlcK/3sCAU6/mTwCnZEyDYD/A/nqPLHIJsoOzgyD3lfgKH/KQx/qlYQ?=
 =?us-ascii?Q?fihLD+gKMmvFjkyv55/9mBlj3DgqpLcgWzmgieiC4ltppKKYR7NAtOHxLfsM?=
 =?us-ascii?Q?hE0OayoM0qJvQexRsAl0FlnLXVvEG1DoHiSh/1QuFkUtY6Z/EKHY0/IyuOAX?=
 =?us-ascii?Q?IykEMhtPI2mtivTeC8+zlBY/SXKnzBp9REbSHjCKxS6xSyzqSIY5kkkrVZgM?=
 =?us-ascii?Q?ZGu4VX/1FAxZ5U+UH46AkHsIUGUOeuZVLvSXLC84GS418RyWblQZs11LiXWw?=
 =?us-ascii?Q?fnYmu8l7Ml8Ahspp4k2HlQ5lPri9DZ9/hj7tCHNSS9bofchfwUqAIhD9uxnS?=
 =?us-ascii?Q?oMscGY6Sz8DO1oVs0keDF2CFmRs3nMqvqyQBg0zgjLZBkaYUoUZzdvhYGK5F?=
 =?us-ascii?Q?pwo7MYCjeNqsZ6+NS7+Wd0BErQvJT4gYC9qCG6XjNoAutN3CxE+DVPMGUWHb?=
 =?us-ascii?Q?3aIn8ixvE0EiXRWvssu0+8NipkqMNH23QbSir9rSFlcQ5zaXRwPdBP1prXpt?=
 =?us-ascii?Q?LlLfOLFB2ypxKPnfIo0Puxc0/C6wIU0+NVmyS9ox5JEXG0b6xM34JJDHkZDH?=
 =?us-ascii?Q?xmM4yfAeOFFry3++NDAs43p7k1JXCIktY3ImmyuZKPoiN/hXlOjHHSVh24G6?=
 =?us-ascii?Q?sdQbrgIBnmGO7b2vmjlfNtNFlTfcyg3jmd5YW0g4Gl4WWvKWUIW7PJFqbUpr?=
 =?us-ascii?Q?85vcTvBk798GxrmyVluHYxW7qgF4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lVLNsWDBbeFpP9vzvm/fOVv3OTEpCUlB01dxVwC/F88wXF+SprOL52JQjbLi?=
 =?us-ascii?Q?dp89jf/Ty1q4f47mmKmis5eonDnvr+olwEDKOb0Xt2XbMDiBw8Fg9d/AHvha?=
 =?us-ascii?Q?6326zinZ39aztCzM1JvdfjjQV0izP0u7o0tAOREb5RBbCknZ/fsdeM/03wg1?=
 =?us-ascii?Q?uPLBpyjwoGAWtNthOQYhMmsVvT7s+IHXpqJD6+2XnTV1pSZBcFqZrlxu4zFY?=
 =?us-ascii?Q?WMjqc0srsPy3HYFTlC9Wp8Y1SuQ6ogImujE4QVXvHxpa7+1M5HWg6PSmeM54?=
 =?us-ascii?Q?oJRWtPX1eoToPiXJSu7jdZqdr8ZFCDhEp2nBMj3PZoJfPFWJYF0642B9B9i2?=
 =?us-ascii?Q?350W6mpGjmeG2vzsqYCdHSI8ZrEpNR7kBSFJAatNISGM8EPaLiAGIU1NVyDq?=
 =?us-ascii?Q?tgHc3coo8hq2Ii2AJtCCA5xcmd2B6EAh0u0QY9+klC0gtarnm6Y2RJybB8LR?=
 =?us-ascii?Q?zJ1DSROYD7ss9gAtGrMd3IbCSe+hQi06hpz76C6qezrv7BFlcCrVQZON91Wa?=
 =?us-ascii?Q?qo2zJSa0eV0kKGF64arRw7weY0n3JNTf2nywSrKOdsWsMm8XuIP2woAxh62H?=
 =?us-ascii?Q?tv2qfOF05h798XJMH3bawliZhX5vlPohCCIt2hl1pKgk3dS2EggLCC9S5iq0?=
 =?us-ascii?Q?WwDJrM7wVGtiSrNjCYUIWJ9sj+OL/hTHH8Wugi0OGvpAp+ZtEHI1ivP4VDrW?=
 =?us-ascii?Q?loHCpC4037vc4HBrOpmPKlFd/oWn55pKcidgoblz2V02ape93RgHtYf+MoE0?=
 =?us-ascii?Q?VDettV4ShaGf65swYOfw0oEM+45uP7sIcIvjv9enVooM9vc6OTyAtLtU/WHr?=
 =?us-ascii?Q?duwwaYs/1/mlI+dJEnd62aupvqcr5dReaj71XyQkcpSd8Xo/4uG9v5mrwKUg?=
 =?us-ascii?Q?/sJIHqHEKqj8tdNPZ3C3ZLWJuEfnmReaOaGY4zv7R7isjchG0FtQrRzVMLEK?=
 =?us-ascii?Q?AHRmL6tNvsBilWyEGbom0BPhC2l73w9n0El6n6bRKvkWSg/EozwwJqhqrlgW?=
 =?us-ascii?Q?2NLglU2SnORs6V2ZHMWu9lTZJGz+zt5kMmDCfAlU0Slgys6zBGhAzUOLqvhz?=
 =?us-ascii?Q?XX8p4ZXJMGLpYL6cjiofDkP5pJuhsPQzELWL/7tn/Yok0ImiOcFJTd2nrfvU?=
 =?us-ascii?Q?6YMMRDTJEPj+S0yoK6qWFnu3EG+ti0l8Fv0TLmH/bqM3qpRnOK6r7RKOkAd9?=
 =?us-ascii?Q?99aI3+Uf7Dy9KjRCfMTdCwr/Qd97O89zox2ReSloqKI0+48cszikdwLloVu6?=
 =?us-ascii?Q?otc9pnoTWc6a1GSYx4XobcA546htd6Ts+KIAspAk8x/eE3zetUp2nIz8LDu0?=
 =?us-ascii?Q?ws4O7KQzWIx7xWGuN5Tsu5P0ng2hDA5ofnxjwCLMXN43Rugq00tVHUq5o7H9?=
 =?us-ascii?Q?+zaYuiyG3ICSkazPxYX3qynOIWCJlwMAkmhh7PQZfu8kk4czdHx875IF6xm0?=
 =?us-ascii?Q?PKhapU8cQtSidGdXszF8f1Nqk5Qi2bEsCihBOFa/sZP9nuwklmCS6+z4GySE?=
 =?us-ascii?Q?eOn08c47VDlCH+FSf5CCBGJTuqv8EN/rx2i8O0YC4AdOYxsXXJMh3nn+iDrH?=
 =?us-ascii?Q?LOoXaN51gedgWSAYrfiL1ZFwhtCI0fxBvWedA0wp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf46d126-7264-48d9-f923-08dd54fb1231
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:45:47.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yntnTgjgW++Z/RLmmgU2acXkynRoGPTsDpTcDLadlDUfCE8YFl8ygmDGw3LzP6coYfqEwvbWI95AkleDTprhcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103

On Mon, Feb 24, 2025 at 07:39:04AM -1000, Tejun Heo wrote:
> On Mon, Feb 24, 2025 at 05:49:21PM +0100, Andrea Righi wrote:
> > Similarly to scx_bpf_cpu_ids(), introduce a new kfunc scx_bpf_nr_node_ids()
> > to expose the maximum number of NUMA nodes in the system.
> > 
> > BFP schedulers can use this information together with the new node-aware
> > kfuncs, for example to create per-node DSQs, validate node IDs, etc.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> Applied to sched_ext/for-6.15 w/ s/scx_bpf_cpu_ids()/scx_bpf_nr_cpu_ids()/
> and s/BFP/BPF/.

I even re-read that multiple times and still managed to mess it up...
Thanks for catching it! :)

-Andrea

> 
> Thanks.
> 
> -- 
> tejun

