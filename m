Return-Path: <linux-kernel+bounces-542466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31248A4C9C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574B67ACC93
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E1123E355;
	Mon,  3 Mar 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H71Yv7fq"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073811F152F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022744; cv=fail; b=ltFBFgJG11FhQsaBZfFtRa5aUsRXmYgR0mxJiMfOs9g6o5StcskUgBLpjcelTTtst+/WMrLsSAebxwRshwHhYutf+SaTvNUTW7EXoW9FFroIqdq+RAA2NRVLmat4cWvxl6rst/Oy5H9/aXIqVcsD/XLqYDOrSmh8asy5rdmtVV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022744; c=relaxed/simple;
	bh=k9lPXHT/6YzIIaOC5pY4IJzx1DoCFkyBwz6Qm7kNZkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f9BJFN5K1oj/IuBCZ/VuY931Ds7V2x6/N6I0/glvC1lUHF02GdQLBewEF8845M88nGBz75f/CU7iN5leMfk/DEJ5DQTdDkPTgwejTfTX5DR4NKF6tOVeXtWfMrvoNDpSVq4dNjsMELv9AsomA5rkRZbY6kRYS7MQaUJeQPCOxio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H71Yv7fq; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut/Uaa3TlKXaWv5EWgwcMe4eGyFP6ezn6iriCzuXaV9DcoJHN6jSUoxNzfqIWUWvjlNIJBQDcAy/YVo2e27EPQZhi6FQVPO5V282iQgVCWOTcj0Wh2eW7MGujuDT6RRiExOeMGArANIjVCqg3TaYCi5QqcPQp9z45FVKyD8qeidTqQ5Z4sZkgpZAiZKVBz15ZzVokVxwlWGbRbjSCIhzW1ANm35nUypRQTJC5AfMO3n581Ptbd/0oiYC7v0QpCLQmtAZ1USWVM+inVar9EPGvRhKuEWZW+L7CvGPu6dXQgTX/1KEkF+tNVZpgskU2+vKcBHMthctmpkFmLwqz39nXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cpxEO8DT/vcDSbn/vw6nsew+7H1oUSXj9x45/TvAPg=;
 b=HoAy22TuWRjpKd2t85G3BOQjICBpu0H5RwG1ByXnhQ3tcyMFO6/89lA9Ld4WeN0z0X2/G9jc9PUZGKqzxl6WSIYelUmhL4uNtsdv+rXyiLT36oLzSoR9Z84qaDX5CewtIhIKLI6BQimNSAZfVDfvS8eiwngdauUj4O2c3szKMaEpui2LhIaMVja8v/qcybv3sF0KCuBUjjGdHXRoDrYUGIlJNHPFC7iDcDV3qMQPMJoUznfTFYPl1Ud+LzibwQbCO3dtZZzpveYcRR4s+Se2NON9bGFK1/Bsglu5Opc1CdKqPZ+Bdaba/jlXcQw1fZcsZNPjCQBzpkqp795Hohrpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cpxEO8DT/vcDSbn/vw6nsew+7H1oUSXj9x45/TvAPg=;
 b=H71Yv7fqhQa69GQhljCL14QXFznMuMAcSl/G3O1YxVdejVXOZLyMr7g2y3D2RpGIfIEURprQnh6Paq6aUwhztlMQY+FIUoM+PMiwoLRniFoaZJhRI2ooFRURyjF++bQrypj18XSZZnjidNN5U21b26WXRVCsxPwlvNFGCb+H0QUCFcIrvvuBzFPg1pYEw4MhotVBWp4J/mioess0ddg7SrXyY9Ygsx4RvpSR+TzoGDw3wkvObPEK9Havxi+iaevJPbpM8AZ8YT6xxkWTxDkscCx5esscDyYif+DxwcGdtiHV85qNNY+/pnMT3CCTd38I9BakXv7Bp3MZ3Jybatz0sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 17:25:40 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:25:39 +0000
Date: Mon, 3 Mar 2025 18:25:35 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
Message-ID: <Z8XmDx7DegtpzoYj@gpd3>
References: <20250302220903.54001-1-arighi@nvidia.com>
 <Z8XUozpR547RFxkx@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XUozpR547RFxkx@slm.duckdns.org>
X-ClientProxiedBy: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c40716-aeec-442e-ec95-08dd5a786b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jSpSc4i5Lqj4ZQGf8fYLgeDyDVM/4dyi7cnkD/bdl0Kp8L1tfWRXfYAf4ZTN?=
 =?us-ascii?Q?jXSEAr07uOpy+O8eQa3b0LfX2hJJ3BWL7YMK6GopZae96p93CLl2vfUjroOf?=
 =?us-ascii?Q?+OWX2APxIr/GglN/AySGf05JU8Hnv5gyvZqCxVf4aPiInMo6LGF2TuO9sp20?=
 =?us-ascii?Q?aKfnlEBlYu466w7vMNrsvP9keDnMEIFM/IlWd2qJdfncT+fNUGRsAJ+yM/6L?=
 =?us-ascii?Q?Mw5LCTcSKBUC3BfqpVtc/75oSrZl6J8d/Epk7Ha1GVmCzYRK0qJ/u8sIJXB/?=
 =?us-ascii?Q?iqxCUjerN1kj8eTz2raIVQ7Xtu2LuPu6HH7aOiyy4iMDijVW8HRC4cpMChgu?=
 =?us-ascii?Q?YB1RG6tat22N0hfcZa0c6fuEjgxivFE+0yWqKwBJu5ELmO45l4DAiwHNycc8?=
 =?us-ascii?Q?3ZIdvnMWYnjrjIcSApALfpc6HImPCbb7dhDb2ckOWaQO0KY8urDZVS61TdxS?=
 =?us-ascii?Q?FcWd72xwJVh1wfgQwLQFCHMFiA1PshLnwCllPIN5//wOUZRSI6fwS1Z6FzM4?=
 =?us-ascii?Q?ohvIafUfhOSrpEGZxsumUdBxUDaHLmLWm43RceDf2+XQ4vHemf6WE5QdK0ej?=
 =?us-ascii?Q?eyTGL0lS1X5azrMjKdSkHNztYHvPeqXd8wvqupCrZs0Hm0Hz1DtChbndHSlm?=
 =?us-ascii?Q?zrc+cmWYDHVAQC/gZ7ahsoZGaz6o7dngGwZGIJ6ICGWd01q9OQenVerVvJ0w?=
 =?us-ascii?Q?cn2fBsTMo15ZSQ5XI/tsrYddi1tRL4l7Hmzc70FbcWYs3lQs9ThfZDin8Jvk?=
 =?us-ascii?Q?Uf3Ftei4PxVkE499wi7w2OhbCd+soe/ri4phEX0jyMTWE88nVs8nmH0+UVuo?=
 =?us-ascii?Q?lgB2RJveDA2BulCcTHdKXArHRai1opjU7z0kjbRnhq2RoqnymwrpQUtGSiG6?=
 =?us-ascii?Q?STDRsXR43Cre1ZzJVFEcdUxVSE4xMivFKfmumr9FkniZn1xF76E3TrJdTZF3?=
 =?us-ascii?Q?eqOQKgbNVlWU7kHlsMTucrl1h85bZYilL4DNBvX81NwGlzVbRVlQSCLpQdGa?=
 =?us-ascii?Q?Q7PteUnii9VN/6gkyNdUYpGS+PBBVic6ksrfaBOyhsriKhK9kWl5mznOhygq?=
 =?us-ascii?Q?MDInGNYCle3GzjBzTB/Q/Kh6CF2m5eGWQ9HlNZpq2xFzsRzA3vp4IrL4yKoQ?=
 =?us-ascii?Q?yWnzrfsWUlmmnwOwlh+uTxmIPYS5kp1gLmdnVypI78rUMZOqKXpnXUTUbQSt?=
 =?us-ascii?Q?R/ZKU2nTFd5yG2+ZwjEs4wGdPK77wAU01SINiTqQfZRgdu69bIz7gloNASNa?=
 =?us-ascii?Q?SnPuA7vAsgbw3bxgzfJNE9XVnUFGO/wBynOS9sXQzJDhKEc0yDZESfJgJq40?=
 =?us-ascii?Q?TZE8yCG2nNRXa1VRimdE8MhmM15F6hbp45qcKKqPLCmLhWuAnUiRs+gPP6+O?=
 =?us-ascii?Q?PT2sY8MgMVc3DAiBVtGxQNQN4up2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjJYMvQyL8qZDNk9Uam+QaPPij3bUR/eDODj2Xr3u1EXEAlLK0mMzVOQmJyO?=
 =?us-ascii?Q?/0MqOSdRsq5Ucs044TAVZb+liNnEV3nACnmb9AYFfiZQAqWQyQ+SjVSGMH21?=
 =?us-ascii?Q?VDnGyWRj/iRUQbiWdjdX/5CzFNdkplxHEK/9mZ8hqEXQ+rcfmFFMWNqmbqyZ?=
 =?us-ascii?Q?BAeLrLGKllbugbuxTb3WIx3VFQi6QvXGG0I605xjx1f4aFk59j8g2JfWmnRX?=
 =?us-ascii?Q?px5WezIyYYCth+lzd6ZYfbccKB29de5DqTzbcuQHBCZ27j4Y34QIWytX/Yun?=
 =?us-ascii?Q?Q1+FtglmwNW+XCuxh8JkrZEXbxEmJcFGQBDVza9XmI6ZKJdPfiX5S+M8n6R1?=
 =?us-ascii?Q?0LJdMKVFfFp3PEEm00A/giMO7Shriuxm3oVNe1dbxwoMvv5/T20hIUet6rDf?=
 =?us-ascii?Q?BLD94Tx4ivnbLBIRrp8mDpgKM1n5KJ/qO9UxvRhN968q54+gNejiuTC459Ez?=
 =?us-ascii?Q?tBOUXmaoGxYRFVtSuME8l9tuZla4V8XKVhrkvRoGh7CojFi7SmWm7s8tX/do?=
 =?us-ascii?Q?l0orZ3ets5gRTYx8K5KaC8kBuIh4kMPCdXKNsU6vr2aeYEOXI0sIK4eMnkfE?=
 =?us-ascii?Q?ZsB3PxKwTFb/Q9WJ16vhDjvl1Se28+EsfdJ2+5Xw2ciucnKtO8qBMClNnwqw?=
 =?us-ascii?Q?kp6XiYrXc7vvncRm4CDpQVRmtCGspLHfCTRfVkpk9AXOi1rXjEfSGYdro2W1?=
 =?us-ascii?Q?VBJ8KMVeUHsdSnGv3wafjAJcEXQGjVQIf6fEtObj64iaFmxzDO4Q/QJPzz4T?=
 =?us-ascii?Q?jEvsBF3jW7BvZ3wsUClUM01XsAojqDc/PEwTo55nkFmd94EQp1y4LnxwQ9Aa?=
 =?us-ascii?Q?TTl/KScB2vEOGttBX+Q50LiEBIyFyp9QXaDYgjr1SEl24Od4fCkWEgIUOqek?=
 =?us-ascii?Q?W7TKVE7u1VbDlGTO76YaZUjwIptjccOTjsPTNAL47PFXFhckvpUPqtOgkRUe?=
 =?us-ascii?Q?OETnKDYfv0dft3HsageN+PTF5VCfnbrEtBEBls3YYEk83fMrmWK5O5JuNgd5?=
 =?us-ascii?Q?lDzUqOU8nKlaNjqVp4DGCExPafOBu8kZYtaZSgzOhN7th04cDsSefarZTBcv?=
 =?us-ascii?Q?VBvzbS9CtXKvCSeqSy59US7gAJt3zYQlqyJbDtn4QcgSlCNF3ZLH37G4JHa4?=
 =?us-ascii?Q?7s6DSHH0bqDw7TW2ck/eHn/jlRwwKA81iG31yFgu21sxK8U+bOLyH0CJs67s?=
 =?us-ascii?Q?f+oieAvrZbMBxtJsQckeuncdJsaK3rdGDPEYxpGf+l2151m3XozAb838zuWS?=
 =?us-ascii?Q?o1hMjIk9EvgWS3pSn3SE3S2ALVVrrNm4xokUe2g2EssySYTl/LgN56FjKINx?=
 =?us-ascii?Q?feL75RqJLgCJVfDEXtBqYlwRBA0GQDh8zzsxwSDfKRf7cbm6WxuR4mNmpB3Q?=
 =?us-ascii?Q?o7jRcbbW8UMK0Z7vS3yEcLi2YyKzaVy94QKhTAQ0f0AH0khOOKVPQmcPbukn?=
 =?us-ascii?Q?YrS5VOY6biyigTwl8zCPb0bKJUhCZaPys2esiYRcm0Iv5uDXISdhXmtOrfbP?=
 =?us-ascii?Q?cxvpNhOghAW9SwdliHR1exODoAAcemGDQKVBVy3oi7RnKFNDM13Gbj+cjKox?=
 =?us-ascii?Q?LQzSevuvUbqhwZmhiWu1enFfoOWVAVdbaJJVzF6T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c40716-aeec-442e-ec95-08dd5a786b31
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:25:39.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6wtr2peWm95Nr//a9FTksENVObZWqaXyC+gbHoAp5x2e74oMosEJOjlLrWwTCiPv7U3E2MasQrD7cg7BfCXRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

On Mon, Mar 03, 2025 at 06:11:15AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Mar 02, 2025 at 11:09:03PM +0100, Andrea Righi wrote:
> > If a BPF scheduler provides an invalid CPU (outside the nr_cpu_ids
> > range) as prev_cpu to scx_bpf_select_cpu_dfl() it can cause a kernel
> > crash.
> > 
> > To prevent this, validate prev_cpu in scx_bpf_select_cpu_dfl() and
> > trigger an scx error if an invalid CPU is specified.
> > 
> > Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")
> > Cc: stable@vger.kernel.org # v6.12+
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 0f1da199cfc7c..88b2ea58ff942 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -6422,6 +6422,11 @@ static bool check_builtin_idle_enabled(void)
> >  __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  				       u64 wake_flags, bool *is_idle)
> >  {
> > +	if (!ops_cpu_valid(prev_cpu, NULL)) {
> > +		prev_cpu = cpumask_any(p->cpus_ptr);
> > +		goto prev_cpu;
> 
> I'd just return the invalid prev_cpu. The scheduler is getting aborted
> anyway.
> 
> Thanks.

Yeah, makes sense. I'll send a new patch soon.

Thanks,
-Andrea

