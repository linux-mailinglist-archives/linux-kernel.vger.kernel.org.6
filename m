Return-Path: <linux-kernel+bounces-195967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2DE8D554C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A271C232EB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1A152169;
	Thu, 30 May 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NgsYfn8S"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747824211
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717107485; cv=fail; b=O61iMtRM8JfxFc2Pm8Dp2zSV991BPz/BKldgkP/BZdv5+NeDLlS7eEqNJbuDP9ZQjmKXURdGDoz54DO5z0WWdihj2ZUmFDBvH+Y8QP6KftWWRRQSrnp5VrS8VpjC921PAB5svu2pwuawUYH6BJwl9uC65WBQgcKufPUeRF8XzFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717107485; c=relaxed/simple;
	bh=esMXuTUWxfUFQMh+3rMwN6o9l9KZnf65LeSnJqu3voE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P0Zu4xDEwpDgD8YpZSjxGO2xrBDTUH71LS++2ZbZKAdSA4myBzLQr9ficiw+PSGQ9mwUQwKd08JkBgo+eVsejWcFNHe2g6T8ju5AIVy/FCYBI5T24plrSuynY4G+BIWlnUlFOD2qMnlSed7zPyvNkdkKN8disiDyKK/qit7p3wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NgsYfn8S; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/DAGthzZUGv5WO3tFVBGwGc7ruYjf1y4ktLSUl+x5XHZzMPO1nE2izYBmuRFZfhpgvUGpGiA8OBCeVafszQ7aa2QIRykJR3n8YKBtwELGtRe0EIF81C5SMqKqZ19X5wmVuSTcbcUjkmi0ybo5uunMehc0dWlLSrGvfKkLHVVVmKvHG3UIxCaHFA6OuBKFSaMsO31DuuUQWi7KxRFuT7KDViMavUCOfO1we9EbKuvzkntIxOh7BZLRQETmXIzSlu1ILYBgJzgp77T4FaRLHPXrdoAngBo3KDR9mGPqp286IcgrZMmj7otlOEDYQOkCIncYdBbHUvABgxW/lohxGfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ79br0jqp4g0LPY7Svt4XcKfCXvoQSLild4QaZEuj0=;
 b=eR+ZhYBn3J7Y+PCfBCGMjXaD2FHFGC3GVxmlimDDkmwYOCxVxIpEPhcdN5kTetPcRqBxVfb+hAtyRl1Z6uzsLSAsjnIN2K3S2wcYUgAFx3lcjkwOoNteCeez2Z/cOPu+ps55WqJNxu6dt0GWaLG9gtf/7J6sovWueCIibmVjemGDOFCTKkbHeZoFdt9uiZ9JClsx2FhFD1ncCuPaeqYGdZuDPhOLkEFxRwkRMk+uZ9GYLVPeVxJ+Q27YRKoIoHMJqFHjrbPoIiWU7/3+iUaSmqxBUY4dZyI2mailccLTkTqqH4U78Jc3VywMOdaod7dQbgMy1yEr3kwmWf0wdLdSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ79br0jqp4g0LPY7Svt4XcKfCXvoQSLild4QaZEuj0=;
 b=NgsYfn8SvC0LILGNqfouUtZ1I4+bZdr3hTOfM7QcGDQgsnG6qTy/jxbpCAsWaDPQrBBeXTxUW27MCWI+7IEIFywGHUPPlk7hqNlQMYAwkDfP39CmbkZ1aN0XYyVm0GTJG++Sz6bek7TNOHycu3vXxPMzVSxcJ7S7aghGm9vclA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 22:17:59 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d%5]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 22:17:59 +0000
Message-ID: <74b2fb73-3047-462f-9053-9d0eece68cbc@amd.com>
Date: Thu, 30 May 2024 17:17:56 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] mailbox: zynqmp-ipi: drop irq_to_desc() call
To: Arnd Bergmann <arnd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Saeed Nowshadi <saeed.nowshadi@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ben Levinsky <ben.levinsky@amd.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240528120246.3313723-1-arnd@kernel.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20240528120246.3313723-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:806:122::14) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 908e2e0b-d115-40f9-63b0-08dc80f65ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGlPL1ZpaWI1d0pIZ2RLRWVRbmlUZXB2ZDhNblhoQ0F0TjgwMlFzSDlPVzdz?=
 =?utf-8?B?OHVtbEw3YjViWVBPSWpYVC9VMlBiS3N1cnV1UjBkNWpETXRQVVZjdXBOT2NO?=
 =?utf-8?B?SFhwSU93OVhWU0tEc1luOUxTbHMxd28vdDVlNVJxVG4wa3dFMWM3SGNibG13?=
 =?utf-8?B?N1ExT1FPU3ZET285aC9ZcmdYOGR4anpMYWdnOVRXb3RiV1RKZWZybGVHL0Ns?=
 =?utf-8?B?ek9mRW5wbWl4NC9YYzF0dk5uSCtlVDNiNVdnTXJka0s3QXlNZ1k0OW15Snpw?=
 =?utf-8?B?dFVGKzlzeEZJdWU2TVYvbTk4dTJtZ0ZNL1VyOHQxb1lVYXE4N3hJYzRHbi9y?=
 =?utf-8?B?YU9pcnQ2azdwZkt6MHNnaDJuWlRzbjNJMUVCY0tUVGQ5QSs2bVZTMSsrWWJU?=
 =?utf-8?B?bnQ2Q0ZiOHlqYzd5YlhNa1ZreWJQYkZyZkVSdzdkUmZSckVIYnhjcGJZaWxE?=
 =?utf-8?B?KzJabFJ6dVk0Vks0V1IzNU5VNDZCdTJZQnprbUJlQXlkcm42TkIyYmJYRkZO?=
 =?utf-8?B?b0dCOWNtK2xXa2QwenJ5WHNmWFNhVWprNHBMbko4QTV2SjdHWEttOGVZK0dY?=
 =?utf-8?B?V29PZDZmL0xIWE56cmhNSHdtdVlvS2l0cUdYM0lnUmx4VDFsUFBlN2FXM3FC?=
 =?utf-8?B?b3g1UmZOcW41dGZRQzlWWVZvQ0RuNndCU3NWY2VVSFdzNlhXTzlZejBBaE5S?=
 =?utf-8?B?Z1FjTDdRMysvbEluTXAyY2VkL1oxOUVrKzRXdTY2MGY5MlF3TVYzVktkbWQ0?=
 =?utf-8?B?ZWNoM3ZNVHEvQnhZa1gwNGJhVGdUaHQ4UE1McFdaajVKbU5WaTJ4WmlhR3hY?=
 =?utf-8?B?cVpRTUM2dUlBREdFTDFWYXBkbEJUWmdBaUVXWkhEcFJvTTFpRDhOSDdacTI4?=
 =?utf-8?B?MTlScmkvY3ZKNFVXTmZORFRlTE1tRGRBUDRrOUVNYTBMTy8vWGRKeENWVnhl?=
 =?utf-8?B?cWtnR0toTG82RHh6ajdPTHN0cUxNQXRPWFhmYjZIazdrVHBvRlhOaWJCdEZt?=
 =?utf-8?B?elJ6TlZxM1orNnlydys2Nzd0NUxOV0dyY2IrR3JmaVhkVGIyS1EvTk1aa2J1?=
 =?utf-8?B?RE9qRFcrYUJScmJXYjlRaTEvWHg3YmFWZHpQalYyeTVwRTFsT3hZTTlleWZM?=
 =?utf-8?B?N2VML3ZxVlV3KzZySjFiRUVEYUtlbzZmaHlCakk5UWdHRHNNVVV3Rm5wcXM3?=
 =?utf-8?B?UmFUcDZpU1dsMXV4SUVmYXFGWUdETzlucTNvRjhFeG9HNG9FcWJiSXhKT2JD?=
 =?utf-8?B?eVNjZ3IyU0tvRGp6VE1DQlVUNHkzajFrYkJzYnQrY0FpMDdhODZvdEdmQ0xq?=
 =?utf-8?B?aGN0K3dHcVk3M2hXQ1pxOFhrRHZKOGN0Njk5YmY2RTBrMXJldUJ2UHpxWFB1?=
 =?utf-8?B?V3YwWjdIaGNNL3RGMUovbHNuMVQrZmd5MWRrclVzWDFRQmhZTjhNSVY2U0sr?=
 =?utf-8?B?dEVDYzR0K0d1elJHdmZwK1N6UFFFYkZ4bVlZQkVKdGpTUTA4MDJYRjQzQVJM?=
 =?utf-8?B?MkpZL0d5VUV5Y3dKaE43TDFVN0w3TEFhYUU0WFhlaWQvcm9XQlNVcTJuK2xs?=
 =?utf-8?B?N1VnM2lRZW04SGJBMlBidVgwT1hGYkJWWjRSNG9BVVA5SEVIUlBWTzB0V3NR?=
 =?utf-8?B?bzMrRHhVK1hVWStqWnJCRldWSUJyMnNGeTdXOU9Gb3BnMSs4SzQwd3ZjeDlr?=
 =?utf-8?B?dHZZZHY2dklOTzFPK0h5TkROWk1KVHRMaTdiVjNONlVPNzNwQmhhVHZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0g2OTNsSUFWYVJyd0piRjBWczdTVkVsNmpwRGZma1dDbTRJdDk4cFplUlBB?=
 =?utf-8?B?WHZoc3hDeWRhNnN1alJZUDJRUmdHZGthWDBlRmVoaXZ4YjA5NndiWkpNUS9l?=
 =?utf-8?B?STBFVm5WTzN5T2lmTFl4WXI1WGhrWjhkeDh4UHdvZ3pSbHJOL1ZnYktraWhZ?=
 =?utf-8?B?Y0FYLytLZGFZNktTYUJXYUhkQ2JLazBURnlIYTBGRXpEWGlMNnpuYnhPeUd2?=
 =?utf-8?B?VTFlZVdaVkFhZkhLZ1krbi9RYmc0ektWbmsxTk5WYjNZd3J2Qm8wdjFoZ1cr?=
 =?utf-8?B?eXZkY3RMelo1NGJFdmRQOUN4SW5WeGhyN2hLRG13NHdzem50SlJIb21TUHdC?=
 =?utf-8?B?T01JYll1eW13OXdkL2V1Z1ZXdkM1M2tNWE4wVkhncWFRUmkyUy9PMUtNNUdr?=
 =?utf-8?B?dGQxMUN5Q0c0QjZMMVk4amFPQUh5QzFGYXB2cTZBTkJPaXIyQnpTOFlGM3NK?=
 =?utf-8?B?TmcrWW1GSjlZbHVJaWhXSVg1Z2ZCWENvWW10b1FFQ01ESUpveVI5L2N0WkxW?=
 =?utf-8?B?MGJkNHo1dVdZMFR3REhQUUxwQzZjMkxYTERvdjJFbWZHTVY4V3QwT2JFcnhG?=
 =?utf-8?B?cEdwTjhLRVZkWTdhWkJEZ2JVam1aV0cwZlhnaWJVRGlHWUtuUlRMd0M2MUZO?=
 =?utf-8?B?Y2IzdjJ1VTFEZzA1d1FSVjRVZmkwRU82ODRXd1BjS20vMjJzanlxeXNUN3BJ?=
 =?utf-8?B?d0JjWlh4MUpTYWZnSFQ3SFV3MWJGQ2JVWnFsUnBuSkRkTDJYYUo1R1p1QnhW?=
 =?utf-8?B?WnVuNHlrT20waXhzTDBDVzFQdTYvbWhlbEZYOWxuOFlidEovK2h2Yk9hbDU2?=
 =?utf-8?B?akhnWWZEZXphVkZJcS8yejh0YXNXVzRPaDFpL081QmUraDFsT25WYnA3cGc5?=
 =?utf-8?B?L2FlOEZKV0xzV3J4TjFzK3RLc1k4OS9JbjYwUWhpeHd5TmFCbEpnVTZudzhN?=
 =?utf-8?B?OFpOMVN5NWYwNnhPV3h0dnJNQzRmTUF1N1ZaWmhHQjdrR1R3WUJQeWI1aFR0?=
 =?utf-8?B?YnZackdDb21KMVk1NnpIOG90dnlLOUtuT3VKYUNSK1RacnA3T1ovZ0tXNVhM?=
 =?utf-8?B?NW1JQlFuc2NEdnovK0N1RDcwSjRBTERXYllWVXBFaGlEZmc1VTV6TGxKVmxV?=
 =?utf-8?B?Rk4wSXhNWkRVejMyYkVsUmg2eW5QQmhBL0hTU1gzaVpkZEt0VGFycHV4WXRB?=
 =?utf-8?B?Q3laV2tkb2g2N3VQZ0NRYmhsamYxOEx1K3R6M2svZnNYRzlUNVczUUYweUJF?=
 =?utf-8?B?QUxUUFFFZXVJTWUxOG5jVE85VVlRdU9VNndyYXFXZ0lZcHh2VlJSOTR6M3ow?=
 =?utf-8?B?MDJqK2VGZ0RmRHBwRlpkWmhTTis5R0lpMWVFc2dRRXQwa0VmZXBGSUU0c3Yv?=
 =?utf-8?B?MFgwckFocjZyVTY1V0UvRkRGUStDMGtLZHFtaTBLd0w0MGQvd2plaXpvMnRv?=
 =?utf-8?B?b1BmTWxtQVdUeXFSVEJ6eHJ1bkJBclNrVTdScUh6L3BCdWFXRlRKYiswSFRv?=
 =?utf-8?B?MkdjcWVsc1R2cWJNM1F1Z3poN2NDOHA5K2FMYUNDN0ZER29sbjA3cUl1TjBw?=
 =?utf-8?B?cUxzWHhLVURsV2ttNzhOSDkwc1JKRWdwb0d5QUZtbDN2OTlTa3FSak9Cdkc1?=
 =?utf-8?B?MDF6K1M5Ui9PM09zVFVKTWFsVjkwbkNudEdjWi9haWhZT2tMeWdlZHdnTzZS?=
 =?utf-8?B?QnpKLzFGb29aRHRraUdReHhqR09nSVdhQnExQ2NiMDdaenBHZm9NN1FnY3Vn?=
 =?utf-8?B?QytCNk5XNnRxenJBWnRrYlpkRExsMVM3YWpIamprZTEzcFlaeHZXdHlqZGM3?=
 =?utf-8?B?U0pkVzJUNW5hTnpsUlFyTWZyREg4TllzUHNmZHNvZytadDVleWtPUk5zemFH?=
 =?utf-8?B?cUxHTG5ZcU10Sm9kTVpvenZZZ1RmN2k3aHhrS1o3TEw5MUdPdFBRVFAvSzht?=
 =?utf-8?B?VXlmU0FFMldnSXBxNm9BWG0xMWtWS3dDVlhnZGFWditwdEJJOXFNNFc2dTdM?=
 =?utf-8?B?WnovT0pxemladkFuZlByWllXZFhIaHNmRWRNM0lCRUZFSEdESXU4Z3FOYUUy?=
 =?utf-8?B?c2docWRqbUhPdDBVT3Y3cTJZNS9qbFBKMjJRM0tSaDkzSUorb1lySjVLZWkx?=
 =?utf-8?Q?Wet6ZGaog0ynoKGFaVTPUgbAv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908e2e0b-d115-40f9-63b0-08dc80f65ce8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 22:17:58.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcSAG38Qjn1avvmA+c2Duqi5N9HeXf65nwdUmVya7xMW7SHFjpIYw0sM9NrOiLej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282

Tested-by: Tanmay Shah <tanmay.shah@amd.com>


On 5/28/24 7:02 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> irq_to_desc() is not exported to loadable modules, so this driver now
> fails to link in some configurations:
> 
> ERROR: modpost: "irq_to_desc" [drivers/mailbox/zynqmp-ipi-mailbox.ko] undefined!
> 
> I can't see a purpose for this call, since the return value is unused
> and probably left over from some code refactoring.
> 
> Address the link failure by just removing the line.
> 
> Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mailbox/zynqmp-ipi-mailbox.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 7c90bac3de21..4acf5612487c 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -850,7 +850,6 @@ static int xlnx_mbox_init_sgi(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	irq_to_desc(pdata->virq_sgi);
>  	irq_set_status_flags(pdata->virq_sgi, IRQ_PER_CPU);
>  
>  	/* Setup function for the CPU hot-plug cases */


