Return-Path: <linux-kernel+bounces-536045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB6A47AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9735188E4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1B622839A;
	Thu, 27 Feb 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rsu8Tac6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EEA1DC997
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653718; cv=fail; b=ozLs4VB9dZCxAaJ5cwmOY1eKIREcucnjHSwodYjLYX+a1Yt/VB79SVBNMxTKEB9Q4RqR6CfnML8FSrwkyv30Bqg7iaQr5ibBf+cQjVlHgZW1WQHynRUU+KBuJ3VrV6kG+UwlMxHgDw1DIwPX+fKC0YhJnW8QPacUHn6BWv2MMa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653718; c=relaxed/simple;
	bh=EbyAz4zqqGrCdu9nAX0gL10a/vv4cZC8LsOYXnMIoRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HhNj7L06N24ax59+m+TN1eCmCbrKkBhGuYvUNomffYNRws6UcFkJ3yzKL1y9/fqebX1XN2OFmBb0j3UvKe5MCYmvdfOezC3MDcBXsl4Hcv3ktUSprg5khIyTm8o0alR74ZAhYjgSIy/xxsQj7LQdkDy8nkEBQhnJdaI+lI91Q4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rsu8Tac6; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiEnoTI5aMGzJNu69QMBcEFybw9Qrk/VqObjDhVEs4Zq/EUYdiOdE0t6wTIBJEUAKBoBdtzHzKLsm8itDKb7+QjVPCBR2sc/0L2kOVPuqq4H9uKR3FzOhR8yuta/MD8i1cgNh7UQP6ukNxjrNmrFghu7iwUKZd43PBRSp+5Zji15F2wfgpriI1nahRcxwef+ORg1t9dhRh7IlpG9WKuOKiAnJHwZI8aPqD/NlUi+QiVn1tnGrxnBEmHnNm20mWrTU11fkQSHGjDW+HPr0tBhqu8BvGIv3pOWL9XXiLI/x7kD4SDefXE0BxP4i2Nzki3+xM/xo8I3diWKoSF/vkKnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1xbnxb5gGw3uhYPJivFzZnrh2NhZ9kgv62dgcpqVyg=;
 b=QtN0AGBLZ2zLGxJtRKyAihTDY1GzQC/d4aYHfcGsi5xv/e0FCBhdsfAM4QAiqyw5kWH1LqiLxEs6j3n+bQFnl8mnrUQWSlkS+Hq96Ti4oDuDuyPmLQz1M+G4tzWLfKWqJBSkjmn/3PR5Pa1OAAGW05WVV254etbe2TFTnNNED/N49+kXBV1RArrSoe+AKRRwJwo3NL/y7CWr5ovmHoPlBW9GmNuTqSvYTWu4q3/ZpTISel+6tAcCi91V9d89AB+BjKMnQZzXOXcyfmt4+E+bAGDhicMBNp/7f9l7tuqxxNMf+SAk48zc8m+YKln8jO7Fw10xny/AbWBiGCLwo1/mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1xbnxb5gGw3uhYPJivFzZnrh2NhZ9kgv62dgcpqVyg=;
 b=rsu8Tac6g53Mad3wLnTJdQUYGLQJydVO2jkSiqYBHHhk1Rfbb1w+e8jv0aiefkzbvl0Juh3jv5FeP+siYFdPcqmx6g905BbZGx2hDVu2rF2y7qXtWAHOCIj/+WoChnaLrTeK6fRqNY2M7nwu60SPMkXixiJvg67w6P8FNQofpVkUyxFI1jOXuEFzzRey2gKSSWiH8R6+c4JfMMeokwFkREB/DhkVA09ml9WKFCSacAWaUPIDogywsw7eTAimAx6sOEPMa0iYBt97BN4rqJXkGoWMuKClaIiFwBDkuiyd1LGgQT5MgffB4QwWmOw1CagiKvXfAXMHJo3o6ddJ2amMwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS5PPF4A654669B.namprd12.prod.outlook.com (2603:10b6:f:fc00::64b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 10:55:13 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 10:55:13 +0000
Date: Thu, 27 Feb 2025 11:55:04 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Add trace point to track sched_ext core events
Message-ID: <Z8BEiHv3u8BsX3yG@gpd3>
References: <20250226143327.231685-1-changwoo@igalia.com>
 <Z8AWZBtrGN8h76AK@gpd3>
 <6a23642f-b3bf-4501-8464-f66bb9f1f57f@igalia.com>
 <Z8Af9PRa7LrxHpfp@gpd3>
 <ea71a8d7-ba0f-4d43-9304-6544060a1bb6@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea71a8d7-ba0f-4d43-9304-6544060a1bb6@igalia.com>
X-ClientProxiedBy: CWLP265CA0332.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::32) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS5PPF4A654669B:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa98054-5635-449a-c590-08dd571d3626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?viJwWaKZCfKXaFCcLZqvqI9Oca8vn7RZhEeUdoUY6WBzgSGYSNkkpnwR7KEu?=
 =?us-ascii?Q?wYYNZiWp6CgEgeRc9wYYoXDk9xz86mB1TIVZLF3tqtuM5wZED+1KmtLrBtVI?=
 =?us-ascii?Q?LZsvTUinmcZdTvt+XnsNQ7PEnBKtpx7RM4oxu53aD3vuv1p7m/bCXv90Ut9C?=
 =?us-ascii?Q?p5tDkc3ZBhb3OHf0x1t9V9D2a+hRI7ptGSsGAzBLQUFQMW+YCg/j1iXBxUV8?=
 =?us-ascii?Q?+cCjX3/DHe0O+EnBYcoIcLd7UdmEXA02OrF4Gg4TU5QJncC6Zo3sY4FhKsCp?=
 =?us-ascii?Q?hD78vFpKvvy+EgafpJ4EGgx66xAxkgrtZGsHHoadN7WJ1HGL5KDBSc+Vicx6?=
 =?us-ascii?Q?tBNGt0YfUa7a8ssrb09YoPf0Q+j8e4HfwyF5C4ddW+fkY8Y7IM6aL2JqfbWh?=
 =?us-ascii?Q?HSpCnLs07YuXesIUvsESQjieisEVrSuhd6g8979VjF2HBme19Y3gWjGJy38C?=
 =?us-ascii?Q?9fBQg7nAF0lsBBPhatV5j1dQ7ON8eULsTRWV7cJyNNp7FkhiiK8z6aiiaSr1?=
 =?us-ascii?Q?35qATd4eQVi5NmAE8p4S+qLEgRtUmIzW2J7t5zgzQqzxrDjPZmw5+Dv4Dzqf?=
 =?us-ascii?Q?Yk/7/RaMM0vzZuNRiivW31CgFl0lyPpuABP+GeB0SkU+GH4j3gER1AMmV/L2?=
 =?us-ascii?Q?VJVTUqznQhQiyb99JM5ugUyUcozZmbd7Ta2zFwsGDbBrI1nb1t7x3+nmdG6S?=
 =?us-ascii?Q?hYEsMsJ4LwXfV2VrShJTn8Ol2ZBGi1cTOi7qZKDKLY5/WUiu6/0D+AVYxV9i?=
 =?us-ascii?Q?b0eBYOTFykRGB59/yLDjOeuB1qYpVALCovzihQJ7fAWlJ4RgYtLwLPolzpKh?=
 =?us-ascii?Q?hFnw/huCLAoSs8YiUM5XrOJJsQkoGzVB/PVg3tFNZq5+MKaGhW92XJYqlgK9?=
 =?us-ascii?Q?oOIIUbuN8uf6GggxeSBCWrbfP45vaCEhaIVicq88n3PGq9dVh3ui3y8cxmr3?=
 =?us-ascii?Q?P7dxUAP8WXG19QLcf9iSV7KusfC2CtSEgAvDmcdAofGsPD69xbwiNw5zYyII?=
 =?us-ascii?Q?7+rbHvumVAl24b30taj2oggVPimEO/Q6IpldOVU3DC2M+tzn63imGGa/MwGM?=
 =?us-ascii?Q?jkngSrEEa74MG4C4A6TtZ8B3iDLcSiRSguyayMoCrT2knUFnNGaO1lkwzjag?=
 =?us-ascii?Q?UlvEgepN0u7QncKRFt3CombA/j51Ghozk9X34awWXXx6iwGzsf+ceB4/mqu/?=
 =?us-ascii?Q?MieJHYnGMrY4R4eN74tHEtfM1ElmrbHGUU6ttKU4IzQ9Jpeef6v7QnfLq2mw?=
 =?us-ascii?Q?wiamqPfHZoYVAOMSFhFmPr9zpyQtBL8pQ15HX1Ibv9K1K05FNJYXxdAvBna+?=
 =?us-ascii?Q?zyL2lf6udZRA6oqS9V+RZ2yZfWzMkN0Hn77vGMJmaRhOft/HyTjYXvvl2Jib?=
 =?us-ascii?Q?Wkc3d86tEGOZ1GGzDpgHxvsXSbyH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?McnJ24+RzFQFV8qu0SUGUXO0/y5YZ6uOMnV7+z5OlCnz0yd5MW3XlKFPfmw2?=
 =?us-ascii?Q?ajUIRzYlI2EqF5F0zH8QlHF/JmHGt6RsWJLhxTRQrpBI5S2ABkJjW2e2Y+Lr?=
 =?us-ascii?Q?ugRz/T+lOsywZGBHgT82B/3eMdsYoaMdvGrMQ2qbyfd72Zjty4BI5rMeiiML?=
 =?us-ascii?Q?CknQct5fIfyKffo1HESrc7zZrB/Zsi/ElEDvTENaSdui/+C0xS+CakOuMjed?=
 =?us-ascii?Q?Ph6nV80QD0nnUX0uo1jYW1ta0ejPI23i0DNz7soZfaYfQsMxjy7YTbQQG6hD?=
 =?us-ascii?Q?z8zvNMkBnTacAdFvkRsMYgljZclgpU4VsrXEmOb7kSXYY5k6hxkamPVlSHKZ?=
 =?us-ascii?Q?mrfvwhsaUlxmC2erqiroGmnHF0CSomolBoR8y3F25mvqb+JAmOhTJ8esPsDK?=
 =?us-ascii?Q?vrn+GUpvYHue7pvMlFrTyVM8g71LJGZCThVAICPbtrOnL2VCoxJAq0i9gItA?=
 =?us-ascii?Q?99ntJI6+/r18YgiesMjY+Ybv3Ek2LNM4qA14aIkIOT3Meb2rxXQwqRHD+WW8?=
 =?us-ascii?Q?8wIGtxjF2jcP+7XeKAwgUesFAi9v0+P1GYYgZ79xRHlw+LCKs+1nTO1zy5sR?=
 =?us-ascii?Q?dFwmwORcuLjCoF+9Zlfo9rOU7wyE018wniqtG++JruNMcB2LxuPgG8YtXvo2?=
 =?us-ascii?Q?VoUGzXBJaFYY3X+mg/9nP+WOZ7pPR8pxbvLukPIeDvER3aal/3I+R+OkDrC2?=
 =?us-ascii?Q?DBBV8volK4LMVgLqVYnUYEwjV8i7d7en2y+T6dxaBnLM1OqgryxvjoHLywJu?=
 =?us-ascii?Q?QDNTFwXANXpPb7Sc0CfdnKimemkUZEyG3lt59A3NNlEzwPtaW0EuSXSVWfK9?=
 =?us-ascii?Q?gJPjG2IBAyZVp99UtBnFaDXxyn0JcaCLHjuC/sG2fnXCiH2mWqVp56FITSzP?=
 =?us-ascii?Q?aXdL4AK7pwmrpHsYDcV8TyxA/RAf/Ntf9oK/053wROuo/nBokF0H1w9oY3P9?=
 =?us-ascii?Q?0+axduvZDUUmXfvWB0OIZBkSzvQtSRlVeEkn779SPa6rf68hMsfFNO/tQDuO?=
 =?us-ascii?Q?iXTXWVl5axW+PcEHV2hmUc+2fJx4Lh8vIDm2OcOfC5a2F8eWKZhobeM3e69O?=
 =?us-ascii?Q?KL7DJ4O8MUZTGo9UIHdb7+gk9WBWZMKKwsKHAUc8mL957LwgYJsYYB+tD4hl?=
 =?us-ascii?Q?N+ytA3njasfoa6LX04wXsyEoLrxU9gR99GhrVexEsodcgbkdOYoheuMTfh5y?=
 =?us-ascii?Q?mj2E5z/ZrffOWIikGue6Iz2h8dNWWWAfuBn+TfNUkrCNvWrRh4netpB+1DVM?=
 =?us-ascii?Q?K1k7Hb0ChsWk2dz4ATqoSvynTASk8zpJQ6Y7rHZJM8fcNRacF1ZE1vO7l/70?=
 =?us-ascii?Q?TM+2K5gnVgqszk8Ao3v7KKkukbrysKgDt70Hg0IONFRJGzeimkTn835Qf3QE?=
 =?us-ascii?Q?Ti6Zgm3nnBvum6/KQrA0LIsKiVmc9b3BUpTQHYfSZbO4Mo/qqJGS2pEtDENB?=
 =?us-ascii?Q?2uMeYj04urzxPIoGfVMpxthW/TzMkKAjP+1p67sKf65Rj1I9UBgRPNq1ALqt?=
 =?us-ascii?Q?SYyp97dWRPoNBqnjr0LNpj6gSaMBoAj5hVhhJZ8p+2/E/ZPS4fej4ld6bfRF?=
 =?us-ascii?Q?cCDqhm3bXBqQ4N1iESH/ZDNYmhZB8XjeK29l1bRl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa98054-5635-449a-c590-08dd571d3626
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:55:13.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhDctgpe1OJo1aMFt1YrXey9dhXcaltr3JZZZL24JwUH4phkE4AI0nQLVCIuBtREsmMjb6RRRMJkrJmS5Bt4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4A654669B

On Thu, Feb 27, 2025 at 07:23:23PM +0900, Changwoo Min wrote:
> On 25. 2. 27. 17:19, Andrea Righi wrote:
> > On Thu, Feb 27, 2025 at 05:05:54PM +0900, Changwoo Min wrote:
> > Otherwise there's the risk to break potential users of this tracepoint that
...
> > Maybe we can call it @id or @event_id or similar and guarantee its
> > portability? What do you think?
> 
> Now I think dropping @offset would be better in the long run
> because we can maintain scx_event_stats clean and do not create
> a source of confusion. Regarding the ease of using @name, adding
> an code example in the commit message will suffice, something
> like this:
> 
> struct tp_add_event {
> 	struct trace_entry ent;
> 	u32 __data_loc_name;
> 	u64 delta;
> };
> 
> SEC("tracepoint/sched_ext/sched_ext_add_event")
> int tp_add_event(struct tp_add_event *ctx)
> {
> 	char event_name[128];
> 	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
>         bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);
> 
> 	bpf_printk("name %s   delta %llu", event_name, ctx->delta);
> 	return 0;
> }

We can definitely add a BPF code example, but keep in mind that tracepoints
can be used also outside of BPF, like:

 $ sudo perf trace -e sched_ext:sched_ext_add_event

In this case I think just having the name is totally fine.

> 
> The downside of not having a numerical ID (@offset or @event_id)
> is the cost of string comparison to distinguish an event type. If
> we assume the probing the event is rare, it will be okay.
> 
> @Tejun, @Andrea -- What do you think? Should we provide
> a portability-guaranteed @event_id after dropping @offset? Or
> would it be more than sufficient to have a string-type event name?

I think a tracepoint should be used mostly for tracing purposes, not in
critical hot paths. So, under this assumption, the overhead of the string
comparison is probably acceptable and it allows us to not worry too much
about breaking compatibility.

Also, perf trace allows to use filters based on strings, so in our case we
can do something like this for example:

 $ sudo perf trace -e sched_ext:sched_ext_add_event --filter 'name == "SCX_EV_ENQ_SLICE_DFL"'

While at it, what do you think about renaming this tracepoint
sched_ext_event or maybe sched_ext_core_event?

Thanks,
-Andrea

