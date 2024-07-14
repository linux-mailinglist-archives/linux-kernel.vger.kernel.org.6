Return-Path: <linux-kernel+bounces-251684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F1D93082F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 02:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF431C21374
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 00:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08871862;
	Sun, 14 Jul 2024 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZtlkCZnv"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2129.outbound.protection.outlook.com [40.107.237.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8998ED9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720917176; cv=fail; b=LR04LTUt5zOr+lbWQgyEReHy1D0WLM9sjf39pEn0+/I7/jyGIr+NkgkoSFUl+meVArA78+ddMzzTgKmvH/QNoHscj8MF7MeT34JFRufd79YytwZpi4aE+yAhIIQs2Q6YX/zFXXV1Jy5R90CA88TLa4HwW48YYgesFXSg6EvsCR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720917176; c=relaxed/simple;
	bh=7JonfUr/zD3hQW2E5Yj7SuPGp0DFzRUgpKE28Xdh/f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GPHk5Y0aHbQuUOzpe2jpTxsqNHikH920gozV9xq56YnfYAWgaYtNj3hxA19A5OliX0TCEhEq5mk1phcqz87SKM2V/p5reba4voM4lXw2PuPWJHNTgQqVazOV7vLdTdCNMOTaX7JrZlS2OH2TKaPxiCliP0AsfUb3zU2UXOVxnDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZtlkCZnv; arc=fail smtp.client-ip=40.107.237.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGQTBxqXiUd55Fc1PBjz2NrAoTtGWtceKjHgEz+CKAFNZjITVl7yHcXrTOkqHTYTJLUL7pdXFkOPImWDyzU0rVkTd1uoEhV0JQbX10b7F235mmtPru/XkKenzsu4N5UhWpNBso7N7BBBiseIKbktJZXgVuMuQ486cSl7SwP2Y6U9bpH4kqUoewgZXSdljZerm2ew/p3Ub3+R3aI33RPLpYBjrebZArIN/V8GJbk8FoaiaQ9Vq9Khq4KHqwsNr4Uu46I2CWtLx9RGvXMOIv0hzuyEwg8T28sCnDQPJmwWrjFfXD4gEjoP6du+OYJug33s6e+fyn8SHsthg2CWmaOoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWkROxPYZ3cynbwHOyo8agEeFOHFa5KJSvKYYYdFrwk=;
 b=lS7EAT8Tm9n0BVB+jRQC2iAtoTJQiPXvsTdNlu7LIo0MyzscLynW7LWqHDeGPtqBTYTldHWC12eUdUyxrfOlfZlwzt21mSZA4FjOGuvBA5u8+afsc6ZsTVKqkUdbdOUqq7iwyM09h8FCoopFWHcexZn2rc22AlDGgLnv3UVR1VjCE4PobwvfgOAgRqMoC+n5KxrAsmruJsGWh0un8rc1d4QE98lEnbUMrXq9C2zWx2gvI8K8+eLCfFdHLU8HtzSS/30+In8wOjliJIbLQL0KoDHUfVjW/LtJI7EumQRhHXcYelZ9KczEUuKmWjkmr6VnvJg+owL8ATr2IuEx+uMAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWkROxPYZ3cynbwHOyo8agEeFOHFa5KJSvKYYYdFrwk=;
 b=ZtlkCZnvkEu/8cAKxOnWxjucI3Jl/krR84nxg6GCS8UbGc6uutYnHVM41P4a9bIvwEidTE6MYrcP4C8HBsf+Gw1WV5F+fG/NRZe4mZrTNRFf2MCAf+nd5MBlC42Wu7yELw3dNhygY6LZqGV2rY3yOSWghjPR9oWvCob+RQWdzG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 BY3PR01MB6596.prod.exchangelabs.com (2603:10b6:a03:361::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.23; Sun, 14 Jul 2024 00:32:47 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::a178:99c3:308c:d6d]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::a178:99c3:308c:d6d%5]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 00:32:47 +0000
Date: Sat, 13 Jul 2024 17:32:43 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	vincent.guittot@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	lihuisong@huawei.com, viresh.kumar@linaro.org, rafael@kernel.org
Subject: Re: [PATCH v6 0/4] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Message-ID: <fxtdubkbj6oucps5mc5ep3elk2ap5peufrzli5nbqnrkpluugm@ojv6ccksc5ld>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240603082154.3830591-1-beata.michalska@arm.com>
X-ClientProxiedBy: CH0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:610:74::33) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|BY3PR01MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: a2491353-ea6d-483c-4eda-08dca39c7bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ypxVPjDfiA/l6l/0nINjCSljJqy17n5g0vUejpUQKCAhLdwmMVB1GKrPrMI?=
 =?us-ascii?Q?CQpDqzeVFXIwVoBgE8XhDx9DKWPGVqf5vMB1lNIoYoGyVJRASJfDGc1CQ3U6?=
 =?us-ascii?Q?Y4Ll8VgWtSuh3FdRWphtfjN904OcUeR1HgiqZL12C9C++baq9qVlLngBmCj5?=
 =?us-ascii?Q?nj/BfdRZ42/bPowkJ6oqTiTVoHpIhTp79tGXLPA9D/bA/Ge8YQRAQ9HObkEu?=
 =?us-ascii?Q?UuUZUogbvh90bu3yp2sgrHTNTqa//ZpUrIaHpPuHN+HEC5P0lg/WzMY63Www?=
 =?us-ascii?Q?gLJIY9to0EieTEn6tPxx8aPqHYtJ0EZfm85tJpdWwJbx2Px/RUgaHKLFXcXE?=
 =?us-ascii?Q?jp8bxL+r+gubtUMAE5CVsx56W9ZiHl9OhES0fjYZGaHP4Rhw8KEcirpbKKHM?=
 =?us-ascii?Q?LQTDMMv6uMeIVJMarVOffqfZDjEOQSDeVPY5CVIVrI/VH9hDET2DzZLAG2Nk?=
 =?us-ascii?Q?1hWvqLh4IbVCdX1oWbDoA4SEjI4Mw9BXufMyNw+pNeGvJ8gKLfLQ/M4LAEpO?=
 =?us-ascii?Q?IUMM8ubHaQoAThG4GQX83Hr05Ko/wJIRsOht9FxSBTfQithhRmx4TDg1xhTG?=
 =?us-ascii?Q?OKLBzsr1iXyAd2830TtfA+TLIreWFJPPtuZKFFU6NPs0LyAQO6BmtltOh42J?=
 =?us-ascii?Q?m5emuYkCrXQVoamyF7uZbkoZCxZ0FIXRdgq+mLhDsueiuWlHywqFnFmkun9f?=
 =?us-ascii?Q?ERbzswSeOplNd890TBDngnqLPxd99n6odNzRRcRNpb0XaTprEOjUXumLfM8Y?=
 =?us-ascii?Q?uT9T0IkpVMwzQQDCdD6ZgigVTTPovIKwHAiqvPMAcO62oV4YrxmTWxODHb+N?=
 =?us-ascii?Q?r3VJxIN3lOjYBXhlOmcoeKrzR0VgUAFxh4CA0i5d0Jgllrja4JvhMJA0tr61?=
 =?us-ascii?Q?laCD4ijth7/2hvlwLT/KRwNSly9y0jHIIY1N7QFS1LE2p/sxKbDGy0gbfkpy?=
 =?us-ascii?Q?7P7xO0WujkMADxhvnXQnhuNmeGqWyMS/zlhHmJx3DcW/LBRpRl02IftbifOG?=
 =?us-ascii?Q?Jjwx2vjwzi1oQrM1Y5PZfAwd+22gVheW2IQWBHZr83XBpiqJnWmcCdlcgwNK?=
 =?us-ascii?Q?wUfz5ugV++QW8h8z2//joA/Ushcti8zF9JQ8zhcZuAZQO1WGDrzhwWO9ibqD?=
 =?us-ascii?Q?bmBmd+5DbsjA/3rlZOi/zUyIjYYlQ4nCrsSxMix0plzAt1tBJmr9KBakcM+T?=
 =?us-ascii?Q?6gh/Ag81an8CwG/TIsm6Ui9ALsnhzwkduvZsySxl+ivSoW3WNaRPeeIP3Lat?=
 =?us-ascii?Q?UJ1+YVQjpx9Zgl6rYESgCBRV96oy7IV9nBK3Jr7HqGT8zOAa0qoVWdqexAQQ?=
 =?us-ascii?Q?uyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YKE98czUcJdiVHz2VdXvnptwpCoMdbIy/XSk74ou5pPG3yqBBEv4InZSF6y4?=
 =?us-ascii?Q?kguOWgTMG5Og4DXXCazQzz3I/5VyYSqsXFfzujX3X+btaYZwf+7VtvR02zrG?=
 =?us-ascii?Q?jq15GIJmcOncqzt/excCPp/bwn6rgBfzzOARI77d3UsjT0Re4d5a+Tb3M7om?=
 =?us-ascii?Q?pyIsNAo4hpUk9g8f9PPR0TiK+ujs817yvZK2vKT4KmvQXl7JL0/ZpfpWCpD9?=
 =?us-ascii?Q?Bv13oY6Vy4gyVOj8y2WsM05bCZURkWZ8tk+ZdWh6FGqTqzTbd0tQeiWdi94y?=
 =?us-ascii?Q?3NRSa4NkpvB/RXxZB7Ndmv0xVp9uvMfmB8p+zVlwSHs8djz9aEn+B45mto9d?=
 =?us-ascii?Q?5u+qT30csXKnguBLJe9ZWZEI/W3gqu0oLuTQ/qlR5f5KRtTBWlGBiAtJYShU?=
 =?us-ascii?Q?cKSx6t3l569H+rq1ndFPX2J1ngcM7XDkY497+EIn+BI2rMze2346qC3GF1QR?=
 =?us-ascii?Q?acmUtv/xA6s4V/8cxbBAlByMF/NfAn+aFc5NUp/oxsdEEJGClj53HW2gQ1pk?=
 =?us-ascii?Q?SFvwgwL3wbuBZvNQDuLZj+4Ao4KJ+YZDj8EcEZ1iyle+o+QLMYomtBtCa9Do?=
 =?us-ascii?Q?1EVBRJy6NNj63XtU6MP3YbKxLuKJhMd78zCV4v6XdBC2sMeCBkzJj6ajCLe9?=
 =?us-ascii?Q?PQk6adw1PYNFyRdGq4ynO7AVgmH27VjomIz0eaCBJG5buZpBtKo4Owz5amEO?=
 =?us-ascii?Q?R1mOM5OgTD4U/o2EdSYBrFyczQJx0HLW6PJV4F/GwanzCYvn8WIXe7/Ut042?=
 =?us-ascii?Q?j698kzGZcQV1CPjp2FaJl5OfyCFj35kkdIbkAI288DOy3xnCnJwM6sj6RDHC?=
 =?us-ascii?Q?sx5PBFcE+C5on/m3cZrYJXttJbV8QDjfb+oh4Li+zRXOlq6Z0cdDUjV7nsCS?=
 =?us-ascii?Q?6Cvv8VqwCL/SUM5Z1bfn7dmGl1CpipvVay5wSrnL9zkYQpVBJroceOCx1kvV?=
 =?us-ascii?Q?vnpFpcG0Uhu5h3jPlZNj28qGwGU2XPXAwUp1XpboCpyxCkAB6HeVxTVLgFjg?=
 =?us-ascii?Q?dRIAvvHSNYvik262W+f+cXRDkNnZtDGx/+jcmtEBALJZ2iFqintJqW4k+W9w?=
 =?us-ascii?Q?IIbOWAIRr9h3Yd8RquaQVn9zUU13vSUaoPJ63NXEZumqgtG78Ksap2KZda1e?=
 =?us-ascii?Q?mYlTtHIspmGBLW5diJzI999L+iQ1zDJjPTn2Aa1snSjT9WUuFCISSSldDsqk?=
 =?us-ascii?Q?ToW3dQbWxqHblepmu6SKxI1x5ZQ3frtjjgMvY43B274rl7ZfQxezdSWjx/LZ?=
 =?us-ascii?Q?fIxVWok9f7VlsG1umMeVel6oO2SC5HXhqRwHehJMXv8q56TYa9IGVLEqmUKL?=
 =?us-ascii?Q?cOTUblsN7AtmWsBC1nJVOTxyPO1lvrJ4XjI8qMbzYY14u/UESpFEcOv6IFCH?=
 =?us-ascii?Q?qnfN4af9TyiZ2nq10rc9/uM3k1QS8z6YXhJL6RVh8OXHPJEJKeyEgf81w+m8?=
 =?us-ascii?Q?k/81KxdELl9DJV5buR0BJC2MdVZWLwRVJb9nT+bcPnL9GI11xpei0CnkXcUc?=
 =?us-ascii?Q?m5ol+jODs4DsfaidQBELdxzT2/ue91SfStxl8r8rB6UgcHyejUDlE7+xHz+d?=
 =?us-ascii?Q?oI64PGviUz/KxoqImWp0GxhlGq47f6cwGKUSAG2lb8ygCkauJBsf0nFEyDep?=
 =?us-ascii?Q?4BcloVj1tIz3By0Fdwd0a3AYzFCpwzEBxaFtgMPsUgVM?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2491353-ea6d-483c-4eda-08dca39c7bd5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 00:32:47.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GThxzfm4YrLBUdd/m6PuRzIJgPOYeVwtbAMZt5aomdhthpc6kCcS3is8e2YBwGOAuFwap++57ZOIGQC/cYmuSsbN6qqD0Oyng8YFN7NLVgrto4RHPxDGMHwhV+o+pxvS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6596

On Mon, Jun 03, 2024 at 09:21:50AM +0100, Beata Michalska wrote:
>Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
>existing implementation for FIE and AMUv1 support: the frequency scale
>factor, updated on each sched tick, serves as a base for retrieving
>the frequency for a given CPU, representing an average frequency
>reported between the ticks - thus its accuracy is limited.
>
>The changes have been rather lightly (due to some limitations) tested on
>an FVP model. Note that some small discrepancies have been observed while

I've tested these changes (v6) on AmpereOne system and the results look correct.
The frequency reported by scaling_cur_freq is as expected for housekeeping cpus,
idle as well as isolated cpus.

Thanks,
Vanshi

>testing (on the model) and this is currently being investigated, though it
>should not have any significant impact on the overall results.
>
>Relevant discussions:
>[1] https://lore.kernel.org/all/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/
>[2] https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/
>[3] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
>[4] https://lore.kernel.org/lkml/ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com/T/#m4e74cb5a0aaa353c60fedc6cfb95ab7a6e381e3c
>
>v6:
> - delay allocating cpumask for AMU FIE support instead of invalidating the mask
>   upon failure to register cpufreq policy notifications
> - drop the change to cpufreq core (for cpuinfo_cur_freq) as this one will be
>   sent as a separate change
>
>v5:
> - Fix invalid access to cpumask
> - Reworked finding reference cpu when getting the freq
>
>v4:
>- dropping seqcount
>- fixing identifying active cpu within given policy
>- skipping full dynticks cpus when retrieving the freq
>- bringing back plugging in arch_freq_get_on_cpu into cpuinfo_cur_freq
>
>v3:
>- dropping changes to cpufreq_verify_current_freq
>- pulling in changes from Ionela initializing capacity_freq_ref to 0
>  (thanks for that!)  and applying suggestions made by her during last review:
>	- switching to arch_scale_freq_capacity and arch_scale_freq_ref when
>	  reversing freq scale factor computation
>	- swapping shift with multiplication
>- adding time limit for considering last scale update as valid
>- updating frequency scale factor upon entering idle
>
>v2:
>- Splitting the patches
>- Adding comment for full dyntick mode
>- Plugging arch_freq_get_on_cpu into cpufreq_verify_current_freq instead
>  of in show_cpuinfo_cur_freq to allow the framework to stay more in sync
>  with potential freq changes
>
>
>
>Beata Michalska (3):
>  arm64: amu: Delay allocating cpumask for AMU FIE support
>  arm64: Provide an AMU-based version of arch_freq_get_on_cpu
>  arm64: Update AMU-based frequency scale factor on entering idle
>
>Ionela Voinescu (1):
>  arch_topology: init capacity_freq_ref to 0
>
> arch/arm64/kernel/topology.c | 145 +++++++++++++++++++++++++++++------
> drivers/base/arch_topology.c |   8 +-
> 2 files changed, 127 insertions(+), 26 deletions(-)
>
>-- 
>2.25.1
>

