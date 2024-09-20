Return-Path: <linux-kernel+bounces-334351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480AB97D613
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8FF1C224C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7314375C;
	Fri, 20 Sep 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BlvFmIMc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F441422AB
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838436; cv=fail; b=gvWBcnSDr8tuHXnf6KkH5Xp0KRWITOdmSIq/F3zUxWl2Ug5x7U9HOp9jbNXB1EK9rrRKjhHqg6Cn2LK57EIhYjpnNFz+xZJ9nLoRuf2FJlTwj5DKFm6uuLudQJmmWvKW1L0qi1hCZkmYe6WfVSh2s41pUVyHAdpERyM6fnVm+9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838436; c=relaxed/simple;
	bh=hxf7R8P5+dJNRB7cX5W8ba/GaUVzp71WnYrpPzDdb5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pFtdlFl9Z76wJ7VDCWEBcsOuN20PkhCtax4cIJ/vSQ4zKLxR9PWZpdT9Yu5MtFLZHEQA8STukgzEgpJU71XA9xBsR518N0y5JU56GYWh+WFkz52TqH6eAtPPEeX+INrBDhc/XPP5+2610cveThnz9BYiT/vf8JCYTGjtpb5c2MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BlvFmIMc; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+9hqgc6RBNakHnwsNvs7IVp2jybBtWq4QOrHeOHEK4TlNVNHldrvKZ3TbwF5yAAF3O0oePCgRgOljfyqnypt/jwx+3kJRir2a7bdyWFbZjn1ywx4clDRZ+HKXnuMFYTx8ILA2Ndc3F1TpUA350qo53RJxKhTVBTps5Ci4G26Rmw0ScEd6Fyeq4jAoud6SG9E0TxT/vzm4n/6dMqmQKTeVExIiN2r5KH8ydK6yugiIhpHhbw7Cb1W70uTYM+RkPD1wtdcOpd1IqGj9Uhg36WkkNGgzXKaarwQZA0ebwzOVc1RQFLmNfb6fqlYeC1q9pzI+A4HiZA8edO8i/IIyh16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RXI9tMA/2doYlMw31+brpVL40KHMYWh6wpuEonwFIM=;
 b=vUjxAj3jHEdtiXo6nVOcR/9eX/oRnSpgu89qCsjFR49B6abW7uqgS7WtesMhq31r85rJcyp5GQZS9vYOEHdKwPMJZUqkYOjsejhipM2lK3olBgOYGA/nVGp1QXAaPH6iVTZ7wxdm80g5hANfabNVQ7/AIaidUPLkKBaT7AVabaGZpRzbiFmFWg4xVjMTIWP16X4gjpbb6Vx2Q9pP9N1If3OszP1TNdLdE1RA8bnGdS4kOX2aA5HFu1oYOypHsyiIA9L5EK+2ti/heR1iWEelFTaOUjHCbdzOxES7X44eRb6w620U6F5lEqCT8WZcZynRjZC7NFff7pt6XPwagUTa2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RXI9tMA/2doYlMw31+brpVL40KHMYWh6wpuEonwFIM=;
 b=BlvFmIMcFTAap8d4sXPM0uFT+ySOVM7IoZZr1QwyiDpQhJXgVth4LwfW5u0IqXziexPzuSU3Bk0CB/OBOQkp6RAt6RweXu6L+5JhmjWB8RLZvtz5zcthih56lyHbelNSsQs8bf1WXjogC609Osn33uMEL+YrNw+hcy7WSNPYtno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:20:28 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 13:20:27 +0000
Date: Fri, 20 Sep 2024 09:20:22 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Richard Gong <richard.gong@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	Shyam-sundar.S-k@amd.com, muralidhara.mk@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h
Message-ID: <20240920132022.GA286939@yaz-khff2.amd.com>
References: <20240913162903.649519-1-richard.gong@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913162903.649519-1-richard.gong@amd.com>
X-ClientProxiedBy: BN9PR03CA0478.namprd03.prod.outlook.com
 (2603:10b6:408:139::33) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0cea97-0781-4c15-5ac6-08dcd976fdda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7mIZQmGOYaO5WuV9aWAnkHLbMoRZel2sAz/TkxMNJBbLeE/r1+wjiMcfNrI?=
 =?us-ascii?Q?4efNbuhMIcpQz2FqqGptzlylj6PoAUTsJgsYVQYpUw3MGytUL0PrLJ9yoMcm?=
 =?us-ascii?Q?b7Uv5xcWVzqMWx5Nn14pi8J85UUf6hb5PrJNpPZbUWdsYvzZbqQZj5P2kRMI?=
 =?us-ascii?Q?TbqczefGbYYpJ3nldq2myCwugvEZCt90u8iFd3fCmy1uvAImLAgxL6+og+bx?=
 =?us-ascii?Q?Rew9xWy49A4IG+GdjnhTGJBnYXxkXleMoU+o3k1Hw+DW7vC/sB2Ld+/UYkPd?=
 =?us-ascii?Q?KeWV2JdkAAbw51hfJhGZYnfNl69DAGiWRstpGh4FQ2CMT1boU4FBiHgeRp7B?=
 =?us-ascii?Q?dVFUnjksqiU9GmEkzCRegzcFHs0myqZgpj6nLMGe/E/la7DGxg+7RZAYTreS?=
 =?us-ascii?Q?CVf6BLzdwW1YuuEDbR+8+if8aywH6mhzFYN+uWfiOg2nJ85fU2JJ4lnwGnci?=
 =?us-ascii?Q?zZKxd3Tjmru5Rl0a01qEp7wmsHDGAhp6teCriAUBfFG+w8ueUYapGdYAC3JD?=
 =?us-ascii?Q?IeRByL/oMWPX06J4sbgxLy5a6oqO8sNsCdTz+i947y2RExwAKTOnr9E6rRCT?=
 =?us-ascii?Q?hbI8BvTSWa7bmONbeewNX0b2zAmpTbVc+QDoJCe38zWEPZFrR5B6eAN3SXDw?=
 =?us-ascii?Q?NlVlQdIYLh8N+T0/C7eZBKTMphMV9cVsXenZuDfP3b7t029afynauWfUD9FG?=
 =?us-ascii?Q?/qfAQwLWEphu02Pz/Xd/QLrMoZJxm8EEmFlHWrsqESfoT8FDsarzlt2Srx+C?=
 =?us-ascii?Q?5DV+IGUNKpo8BbM2N4sBbYM7hL3vsakkiWIJn/p0aWEVpEScyxyBc2Eun5g7?=
 =?us-ascii?Q?JUMeKdUImX8c5g5DuOXqtp13fcmeS7KFq/SFuGCzjS/aThyKqWM+7Efb7LbK?=
 =?us-ascii?Q?/+q+6FehxDPnpQvNHWEocmTKXJi5zVzV7dmKU7aTXrfYC8+tfqH/yW+pisXo?=
 =?us-ascii?Q?koPm/Ht9CRtYAK2nZZGVhThvUP1AVd/PwPrMGGkAx4LFZ3pzYYO+5oMtqxgC?=
 =?us-ascii?Q?kNMxMhaAm1MIX4wYRKk7SaESCTF1tPkprqUkLUhmmLf7l7k5YjFGZWSqdqzY?=
 =?us-ascii?Q?zQKHdTN8eJwc4etU0F2dThYlYJcgOR5PauRY6+rTqL0pP6VdMh38NkFVj9C1?=
 =?us-ascii?Q?QWRQtm/N5yw9ytL6g8a1vYrWeLJyBL5+wQEdy0hZvN13fDvtGi0FQzLXiWyU?=
 =?us-ascii?Q?W1yn0GCKjVVOUd1oTv687x1hVnu19QNuP6RNs3LPbyhKwzwExlXXgwK82m/A?=
 =?us-ascii?Q?yrMZxk3HLCHibdUvhLA8KdoT+Ls7ayVEm7rdG9VDJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cz3nO7sbBa28K7uXdt15x7B5+wvmGO6svZZHYqeFkQWHl7swI2b6+PBFNfGx?=
 =?us-ascii?Q?firzpvLk6u6b2H01ILyCkugRle5NBpbLaYyUGSHqhJi36xWa/Cd3dMtI1nwc?=
 =?us-ascii?Q?ILlAtCjfiWwSqHaxVdSMxht1h7sQw6DgpjoZGOP8kSgoUm/2CMUuX11A0osa?=
 =?us-ascii?Q?rEb09FofGOI3B9RwQgv8hgkkR78hhE15C0JBMLUFIacAwlmlGl4ZbIzFqLU1?=
 =?us-ascii?Q?mymQ7H1c+rpjqB9E9X2HEMCTkJFAMVxTOa4z9s4ieF8b+3rxXSun6uCMBNow?=
 =?us-ascii?Q?T3LqsfEJz3kyPrNTp6eY8lCnps70e2+EyUlB0yvF/Z7SFnLavcfH+r6TlWH2?=
 =?us-ascii?Q?J1aGFF79hHi0R/C9FGg1XN4rgVCFEv4K2jUAoJkmYQuc1npViXdY+O7p8QY+?=
 =?us-ascii?Q?wfWOSS2qaIrUIauyYngDp49Pzneu+CdwWIpU1iy+uXsRYWdkFy0eNPns/i6g?=
 =?us-ascii?Q?t0gsWIfMXenkgiSdKM9UqpcfMll2QU0CVN39bF0nZyl0q1pJk9ZY7jQPzBBs?=
 =?us-ascii?Q?UrNpJWRmasw+WvQ/eHv4/D6P/DOe2vQBIkbs+vCitdKqLHK5iso0daiT2TU3?=
 =?us-ascii?Q?w4lvIbDrMRheAg6fN8cGSE+84CWPvrdrPac5/evIIAcjWlNGrBTbelwUInrF?=
 =?us-ascii?Q?vOKhzYgGwiKZo5fU6hbpE1aGaL7yLf6DztpJFv2ue9nioYcORKFWRjqBdp59?=
 =?us-ascii?Q?umzSNx7A9tVTtD3BJ90fjJCUz4AwlNtDk83EeiFPgez49KNlUuFDUE5qDbc0?=
 =?us-ascii?Q?3wWxP24EauVPH7GAzWUPWDGAAp2wgjCAznY48diaUZ8e2hzXDFXsEE2ZArZG?=
 =?us-ascii?Q?jwC62Aeb5GkNlhyZcKT9Cs1jy//fKkAf6DSTvVC+qxaJtcdh4PLmvXYEPAD/?=
 =?us-ascii?Q?sujbb0CKXa7JwIjghkJYXGvZcin8rJWaM+dgQUkPmIedUs+w676fd0Jmh687?=
 =?us-ascii?Q?q699wW++eQUeOK03ANNjSsrcpwtisF1qZL4Kt5btBOA1NXLjq78/+7dcWS+7?=
 =?us-ascii?Q?t10B6VfdfPHAG5GpQy+JjHgBaugnPRLv0tgMGs68XDJoJdjYcmYz/d+0CZKe?=
 =?us-ascii?Q?pYeElJWH8go69CoN07lj5nOO1DqFxM2cMOX4CUBcHZ5FFQeilXixqO26MuJM?=
 =?us-ascii?Q?2AS1iYzWg9pF4BWesoqqhM1QgYrvYokgPaOOPbGdr1PPl06UEby+/y3kSfx8?=
 =?us-ascii?Q?6pAnrh1vEU3IDhGnhFWGZj7jlzD8Oc8f5Rqb+E8tM45riI6+OR6+N3p5UvHD?=
 =?us-ascii?Q?P0ST3DEOgg8GQKgFasvoVgpJyKZVdZDqNuDhGD7WTIJZM2e2ihWw2YwHHcsl?=
 =?us-ascii?Q?jhEawIgoV0oztSWI/qNwIqaZy/9UDJVjewEIKSLivhOap2rCmE+k1S/yBq5K?=
 =?us-ascii?Q?wFIgtEZKe0M56ulu9trY+zc5wAIMFWQu9WUwv65g9qvhr1ZrGl7ZVj46RiwA?=
 =?us-ascii?Q?AQjVz2CmOKc0OMXKPPEEwCHarjXenE1/TlIpfzb0S+zWq+moBXhktQT/e2u3?=
 =?us-ascii?Q?uNvVr7GH7tQBtxhGR/DEVrd9thnGQ6bDm3nCP/vSd4GGDUNxUUCGe5fABGui?=
 =?us-ascii?Q?lFMTypcz+qq18NgnMdMC6GPwxLDNRTx7vpvTdLYh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0cea97-0781-4c15-5ac6-08dcd976fdda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:20:26.9217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUNgDjZUeS1RZZg0IcbSsVJL7u9lG6ivcEgXTe3wJmMUbal0JPkchsX6ONElyu06l24O2k+YfmWfEbHKhROGhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

On Fri, Sep 13, 2024 at 11:29:03AM -0500, Richard Gong wrote:
> Add new PCI ID for Device 18h and Function 4.
> 
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

