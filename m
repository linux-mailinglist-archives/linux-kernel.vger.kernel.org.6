Return-Path: <linux-kernel+bounces-397288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DBC9BDA04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A23D1F22865
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35A216A38;
	Tue,  5 Nov 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJvvffz1"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78721620A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851073; cv=fail; b=mvrZyqlY9cXJzlJxr2HGE2v4hIJdyaUQpyUfABDKgzppoU3KWUACqXR3aUU9ognHirIl8cObqROnFyv3zCNDvjJK+Q+gz7XzMUuy8EqEnAqar9GeXuOyT0vjGET0uu0+Iq8SnqlR3SmVUSsRiAmtOZHlNJn7BCqv48PE1makkXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851073; c=relaxed/simple;
	bh=FNIgNLKZ8yN0f/sCHCRrPML1EcMqYjGZMpVwBZSjFY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNeaGSom4Hh34fPgGzW2wA5e1P6Yhd9rbOq2yWM7jVlpEVnicN6UYU4j80MzgtveD2e4WDJ8yBDDB/kfkD3lFlLEQqkj6y1G2ZwEMqZR7yJjBq9FvLRUw22IKRXLo1QvzR3ealBvz/zBOUrZAwheMNzQuKtOFDnbXD7IpuRTxOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJvvffz1; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5m3fyh+eqo1Rmh5bEtiBWBt6McqkH2kzc2cfs9Vhe0UjEet2WJHqIJ48I9s8OqDozibL1dX6eW5JfDD8kp7Glb3wG1eSG1p0wI838j9oOW2KxiEbpe4PQd30fykWw3Amz5NA0pLZ/KO2NW+9PhRDseCeRankCJ/9c+WcOH5nkIFSAteRwUt9XiOo/H/r58gLJRIYREtm4ANnQJtTEdKiSaf57PzRcpvpn4PNprp+bEnASDKODBzai87Xeesiu/4X7c8Nl4y3Ac9UwqdrtPjGjzIiIAN5G79esFpgm3Re/5xy+kfNlGWcId6Dnbu4/0IyMGSZatsDKbDn0OS9aHi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr7v41xxHMyRho9D+N0+BQsSxyyu1H7OT3PRrO1IF3Y=;
 b=FkIt9auKL93ICYa/01uLEWyiR2bLGPI4y+4Nls9f/8BxUPoSmTQLXBzZco+tbRDhJI1UJVg0rl5/9z/Rhehquzr9tmnAUZt3IFQlgdAnD1WUMmUmqRtRQ6s1g8s0UwTIlGWsuuqZgbmftuZ2MHUUh511ohU+Od2zpWTayb5aUH4kfjC8hHc1V+Nn1+UKbM2Zx6WR+B1+zIiqLUSGGVS4LFiVQEZEryR9vM+RlEcOJQDqiB0l+mrvKwfRQ4Q50Q1tgaYbs88Tbiuh2Of0/dKZ37pvvaq+K5zC/7vS4xPiFYwBU/QWt61zpc5rJDnYedlnHX1M89/BAPHzCTssMLnc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr7v41xxHMyRho9D+N0+BQsSxyyu1H7OT3PRrO1IF3Y=;
 b=iJvvffz17svIztEVRhq9+RK6TIPCLSyLmmYnOaNQ4XuSGzbH3/rU/dTFCSfgfC/+rNtxQC2CamXqQ36PH+A2MyE8MbaM/p3pWk5q1EEiZAmtrsBrqW6ZP4AvIN69M03k/jC5Piu6JhUv4SrM8GP/OKbgT/mMaKPXaWxA6UaOlb5SouhyLZwe7jCbvMRK7yvARrJHyhIRqW6GNs2mRD+q+1yEGJqYsCp91pT14KwH+wbK43AS1LIFtfq5MfQ8x32eRozLlbj+axlDURUV6TCTsSVe/uJi5lbi3gMiRY2W1RaOBQxZxBcuH1Y0Wslpl0d6DlyXr/Q/6BL7hcteorFmXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Tue, 5 Nov
 2024 23:57:47 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 23:57:47 +0000
Date: Wed, 6 Nov 2024 00:57:42 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com,
	Changwoo Min <multics69@gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Avoid live-locking
 bypass mode switching
Message-ID: <Zyqw9rI-hbxhMqv_@gpd3>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e80442-6f52-4b49-b2bc-08dcfdf5a60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ht2V7R56cpYBSQAODy88ZGgK+yGL0e9m/eQz8Rd9wheDbniDPaI28yd/YBms?=
 =?us-ascii?Q?mFNjVlwtERgf1Uh18W+aVeY+CweHc2REpTUVSzF8Orp8/frho0Jg+D7ZM0mP?=
 =?us-ascii?Q?1w2DFWUO2tGua/LM77IbkOp6c5XeDkbH2ySb140GHwbqRza4SG8x+Ib787a2?=
 =?us-ascii?Q?Par8w2PH2EglfRQrVkWawvIcNhdkYFc1FSZFfAdqKIq/dxrzLKzDU2aXeFXG?=
 =?us-ascii?Q?ikJH9r9a2Gy8z6lHhnxJ6vGJE8huKsJkcK0LRYi4EWRw8dvUDaVs2b8T6QQe?=
 =?us-ascii?Q?5dhkUB2zeWvw5u12MilbhSGsxR5W/vOMW9FYUQmOezVNn8sVOwKtQ1PZcL9y?=
 =?us-ascii?Q?TemU5F/GNGGAxY9cbRFU0E1hzOzPhQbNnioPEJx9XNE7OzjUlv3sOTWf1iJB?=
 =?us-ascii?Q?Y968odvk4Rnoc2YEH1s4ejktJ8puyd8bx+OCuQHR9QUHUhwYy6mzP6f1MyiJ?=
 =?us-ascii?Q?RsSFHPsqFImKm8RQ056Ii3jB653Vt6QobzccOjKe5UzXtGCVPL54z77qWD3I?=
 =?us-ascii?Q?h65/6PkNN232H9ihkgpGfaPWkDSP/soqsCLwS/ZCiB6AwNaZUjRSYky6lnOf?=
 =?us-ascii?Q?eqngIAIw+fvcA+sd12oRxPA/SyLEI6mxcceTZUKCGDKey/znXhBjF5s/1Ku2?=
 =?us-ascii?Q?/+8jJYpycXcsXk9JFkxKdnZRWfelgoVcYadwRK3cdjFFetDH2nLWgU6e1pBi?=
 =?us-ascii?Q?GSZmc7Ynt5OmntfwGiMRYp3M0lCxs24jjKsOCmc56/5dFACsLle0UW1UjwoP?=
 =?us-ascii?Q?uGviqyl7I9wDy2ic4Dl8OGGqaaFApn0Dgtp0l9WisumeLeXLm0jmjBnvM4BI?=
 =?us-ascii?Q?NcKR1sOjSDqGlbVeEnu8uBOI1nSHZffBb06hu/cXxYKmBTLIbA1Zp1PCKjxO?=
 =?us-ascii?Q?9VPF8MoRvmv/ouvTExNe7CIrNlkbspgl6QaSAh5pbXkACMgGGVfDlOJNEYnd?=
 =?us-ascii?Q?P4cVEt0XSp9qXeciwIgx/GMn2HXsHfR1W7PWxILpYzOb8tuPpd7qXb9X89qx?=
 =?us-ascii?Q?roH7A5OtywD8qj/5QJLBsV0GQBlMQfOWe9AnLO7+SHWcJjs0P4DIDQ4pm9Tl?=
 =?us-ascii?Q?IFaVC8uVvC1Tjq+O10ODnqRT6y0uijVpK+Mgn3Ni2yALgmFwD/eVooMt2ndd?=
 =?us-ascii?Q?ZQSQcsBbcZ+lhkr+/PgavQJZk3V82DjSWeVD2OYUVrwIVwEP4A1bxTk9Dmw+?=
 =?us-ascii?Q?cXA7/IxRtnrrfKbXdjTR+rojP/QvtfZyOz73EWuTzCkh7adQJK8lIncpT6rm?=
 =?us-ascii?Q?7zSB93f9k8lYdK/Vs7aG0fC0e6vd8cnsfqBT+jwTXd3fWRH6MUuIMs+JSsQ1?=
 =?us-ascii?Q?s7Zr5Q70agEeCreA/JLSRBOv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/7msAHD6Vd2IegR5mS6m1KkLGQFkc5x3wHLzlCpMf5TrG3haptjaZH5M37P?=
 =?us-ascii?Q?9OtLSVYHRKCjYTKiKC8Soj6qRH8ttUhNMxKuSuPKPKm5ZYqWzGYNQOGSt0Hg?=
 =?us-ascii?Q?n7pe0HiLPRk+s4uxEJtGEifyFJ4aLnChHshcTh3PmOaXxafa5AgB2oGQ/AFR?=
 =?us-ascii?Q?tcUgDT7gDpJWtiFTeQVQkVK1vaJpHgh/iDHJ7mtO+pRdE6S0xWpsjq1fk8Fu?=
 =?us-ascii?Q?eMrLAgphDG1DBo48QS12mIEVsC5hxhuT0mTSJo88E32RNinfEfwl1qQa0EYx?=
 =?us-ascii?Q?m3vUrgzQiG7DFqgzpP4zCfTG07F2qq3QKvp59wpV+u5GlpseYeuM8h1VJSjv?=
 =?us-ascii?Q?K7LXDLvc5Ewd7xfyDYoBewKaI6Jl8x7XubVoSPRHWhc2d6XuTqjdffaWg40d?=
 =?us-ascii?Q?37hHRadTuIlpMPjYUVMsmL2Us2PZtmybntRFuuFKqcPDRvdfnadcO2J3GNGv?=
 =?us-ascii?Q?chEh/u3KD8PevF4j0uUx5lm0LrYomPe1iTvDME/a0rRZeBDQPxvkfQapymCM?=
 =?us-ascii?Q?0zXqgh/eY3Zu2fZRJ3ypN1G9x/eRxPXiO5XxHyRunfZBXbnm9LyF+ccCjsZr?=
 =?us-ascii?Q?OtAYKEcFTdlaRiT6k+UpK9Lj1Zwu5J57CjI1TQ/fiUr//EnWHPGCgRO19AQ9?=
 =?us-ascii?Q?+S42A7gcLVVV8hgA2BbeXvsl0WwNQqUGFrvZfSimU/8/rMrDxQ8Z8XU9d/q/?=
 =?us-ascii?Q?mxhF9xZk5fBmH5F+Z9iDNjbx8i/CwsxBYKEGDtA2A8wCVwMAeY5olKQyw3D0?=
 =?us-ascii?Q?mHbu07QKWA68T0nLzJ3P0fDjPyX5RxTcHVdr2TTcuDbN3eP+fX47oQnluk8G?=
 =?us-ascii?Q?dwbAY/0NIug86Hc9yB3uQXPd0z2Qdo8VEnmCER5m2zx7/EkhywGEknAFvA69?=
 =?us-ascii?Q?mVmgQsNze5Z/UAZyg/btEl4Af2fcx5cXc1b9o9aJOzZtwSVsIiwPAGLIhRGE?=
 =?us-ascii?Q?rwskOyghyH+2OBhDKWmHfFjQDy9ZxJlnb99nN0uzTt25o32dltNtd6AOs8Wa?=
 =?us-ascii?Q?D7CLrRC4QwYuL3x9SLAfeaEWRfEoGf+KP7LnbyyAbo1NKkRNuFaCxGvVC9qh?=
 =?us-ascii?Q?ub3g1wqvWSWILS2TG6Go0GpmOJf0sx9OasUNsM1mpfz15dFBnbBL5yDS4V6B?=
 =?us-ascii?Q?pZ28dlWlCftl7FcUOwJGL35vrdkyqe3FslGoDfJQdloVw2gT9fDtZpjVFFmw?=
 =?us-ascii?Q?p6taTth3bIcnCMy8LSJH6uEjT2kBrSH+Hl8NBv/Tfbrzz7uD/GBhVknu0iJ2?=
 =?us-ascii?Q?EAmEMj8Vx2tF7zqPI1sBt+rUGLQz7JrSkL3HK85YNZZELIqg04WCXajTTtt9?=
 =?us-ascii?Q?XY8dXnQH9dI4bYGmAuj50pwuTdAoe72JSYDwCNTUMAwNx8q3eH/O7WdiT8ic?=
 =?us-ascii?Q?NDewIhKM0Mw4vTyWAKkr9fus+UsrH3ZOKdf3E2JzIlttiRw2Z7SWNm7wRAFP?=
 =?us-ascii?Q?G+t0Mb+DuSNELi/X1gsHu+XMG8eOWKC2hhpQI2rOcLZQ3k/9eQ2YDGQh1gpS?=
 =?us-ascii?Q?x1DQaqRTDMypZVikO393LIyzkU5IpunP1gbFkubN17auRf90Ann4b4/1JaW2?=
 =?us-ascii?Q?WtVT8nOGhekijBWnpV9/zvATciuMjCF2HaQoIImV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e80442-6f52-4b49-b2bc-08dcfdf5a60a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 23:57:47.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfNFMcrsBP0dPgTXmG8e73dnOsDGJm9d9OwVdUTKK38Cv32uPYvGj8hTahp+dB8pK1Y1L1UXgU/WDBhhE0Oq2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

Hi Tejun,

On Tue, Nov 05, 2024 at 11:48:11AM -1000, Tejun Heo wrote:
...
> +/*
> + * A poorly behaving BPF scheduler can live-lock the system by e.g. incessantly
> + * banging on the same DSQ on a large NUMA system to the point where switching
> + * to the bypass mode can take a long time. Inject artifical delays while the
> + * bypass mode is switching to guarantee timely completion.
> + */
> +static void scx_ops_breather(struct rq *rq)
> +{
> +       u64 until;
> +
> +       lockdep_assert_rq_held(rq);
> +
> +       if (likely(!atomic_read(&scx_ops_breather_depth)))
> +               return;
> +
> +       raw_spin_rq_unlock(rq);
> +
> +       until = ktime_get_ns() + NSEC_PER_MSEC;
> +
> +       do {
> +               int cnt = 1024;
> +               while (atomic_read(&scx_ops_breather_depth) && --cnt)
> +                       cpu_relax();
> +       } while (atomic_read(&scx_ops_breather_depth) &&
> +                time_before64(ktime_get_ns(), until));

Do you think there's any benefit using the idle injection framework here
instead of this cpu_relax() loop? At the end we're trying to throttle
the scx scheduler from hammering a DSQ until the scheduler is kicked
out, so we may just inject real idle cycles?

-Andrea

