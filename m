Return-Path: <linux-kernel+bounces-441257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6677B9ECBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799AC2843C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5B8225A32;
	Wed, 11 Dec 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K+cElOjl"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDD1C173F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919733; cv=fail; b=cDb8mX2Q/3Po37It7R488dCsEctPdu1RiOIfHMKW5J0c177rmiUqV+3TZDKqbi88npV1QvR+JIqk566JNcayVEZ3wqcRorFTrrIql7POgbYNHqDtBycTWKCP1COOhG5gwvLT081wtzMQDIxGTySl40a/Qg+Ak33mMTc+L3ODEHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919733; c=relaxed/simple;
	bh=2TRjiSvOLlkNIrI0EnLSrVx+PJdaAURcS3Ld4j8zN/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pe9TEYZXKe36heQIZ3OLM05VJXypGfgsEhS17qF8INlMEbF9xeugCXv+Y5YKPLa4KOoesr9YM+ZGrMgWLvVwvIjp+JhVLFq9Ax3PVcQpCGAW1+pyO8lDeiPoN07pnbBeDM8toTO8NdvTFv+zJVq5XxNEazFpJrrjFncDttbtTOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K+cElOjl; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsDH9uu0cXo+zNu0J616uNjltORdKcFVSy2f/FxDSheXvDax/liYRs/RMHwq269/SI1eE0R/qGxJff++7BeYRG+mrMeZoumWypYTS2oQnpRcp+xjccadbnYN2/hdqNBU054YjHyESwm1SNZh7qm5QhB3qJnw30XGpDvVCB3ku6Hnm0r33vrLeDxUCNIo0wO30RuHkSUZzmUTaUqwJw7ZuYRArwizIyet8A0Xmy/nENaMFekXgptir8pakdNMdfZhe02qUD5ZSQXB0536bhl7l928MeKoPP1eFmXtZzhVoPPfmwfQtWYQVeEtF0leTO0ihkUD9npvO6RlmWwvh8qbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6ZIOjVjpC2brlaqR5PIDnBakaiGO1FvAZ93/q6uvGk=;
 b=v4zVteoR4bgSNkZ6QW8FGIMKfTQhSoskvgeTT1Y8d8dv33OGyOqzAyMD0CRgbik2egqChiiv63l5gyMTcPgH5Kaa6TVGSzufbRjmQ4miEMGc/yylC0B/SSGtN2jRZwbjr6lvdRyXg5osdkBb+bW7eerWoMTS/0oP1EgbQGEDMS1u44QBAHmvnLKmmWHssI3Un3fwA2n94dCf2O9s9nqZV1A1MMLvXVmfU2Axgb0uqhJqLHyyL7QBNJaklgbDGJWha/qEFYjMpgdluxFO8KCu+OWlMMp0nHsw0YIbO9lSrd+glonF9ir2FFCEuQCfO7RRQ5877cuYGt3jwTQXmJDw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6ZIOjVjpC2brlaqR5PIDnBakaiGO1FvAZ93/q6uvGk=;
 b=K+cElOjllsU1Oy2AoSWYQCFbAY1Xb1iyNnSDafIDI0yiPoDEI2OZM68dEQjtDyT77D7dzHnhGphAxhBtanrzItJLA7Phjcl+HHHzXf9gQQNUvYbeu8KSpkFbWXx3hVjNsFMIgQYKmmkyrwiCJPK3wePi/hQkgO6HBnxki9JzlQzCVYClbfJBSvePiLvv24Y6jfaba1tFjBy39pfmZmWod4xW6Gro8tWCuH6SL0n7dLTbMLuxJ51ThU9SoJv163AoWE/hHdDvMx0XjKJgO/7ivxnXa/F4rVxsjFDlx7A2pdP9QFaw+UiOBon3Jz8WJTcwqUFmioylU64HwYX7wXk+wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 12:22:07 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 12:22:05 +0000
Date: Wed, 11 Dec 2024 13:22:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched_ext: Get rid of the scx_selcpu_topo_numa logic
Message-ID: <Z1mD6WsdT5DAwVrN@gpd3>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-3-arighi@nvidia.com>
 <f6cdf7d9-b11a-4b6b-9d30-35afb50a55f1@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6cdf7d9-b11a-4b6b-9d30-35afb50a55f1@igalia.com>
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: cf10ca08-21de-46b2-f4f5-08dd19de6caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3gAPZlbREL2gH775oJa2+Dj40KgvPw4vWmuxl7JrIcgO3URmOM7IvdQbQ7DP?=
 =?us-ascii?Q?MjXZqq8eSKly0QehhOVkwBE5Oc4qJDIVLQxtUzzurgMeVg6llruJ3dJ6OYx8?=
 =?us-ascii?Q?pg0/JVbmlhslGed3ePgZJ4VrkLYSf5gsN205vKd/LhQhu68bWIuOU4mJdd9U?=
 =?us-ascii?Q?rZmJPxJSOXI+8fWxL2LMt3blbooLHUvkk+zhIqHMWGqSmiwhZMNDHrZ4jqw3?=
 =?us-ascii?Q?8Ie/OCrADX0wq0c1SSR/TIXtQet5a5eSOlUiKzmWRT6YtjhQN2yd844ryyYU?=
 =?us-ascii?Q?Win840ttZps+2BS3t3STKF7dpeVHnNzHimUzEF3OUtnYGTWQI1GrtvakQ4oy?=
 =?us-ascii?Q?NX5rxY/ms6ohNToCNd62y4yLwWWTs/SxS4DX/WkOw5WP1ubePWDi9rQz/H1+?=
 =?us-ascii?Q?VPl+LDGZhfahBkRrRCFrxWx/00h3yp787/UKZ3F82JuZMv/bvpykwBIypBGz?=
 =?us-ascii?Q?/GOblFTGPK0UdF61pQ+KjuEsYgx38B91+yTP8YiqsAPPP7PjQ9MN0Zw2gJey?=
 =?us-ascii?Q?GDRTTF3rW7Ko6cnMN7zZPInBXcBifjgfgO2rpeJwPvpKxfbsXy+P2pw5ldzn?=
 =?us-ascii?Q?NjB8fcJZo4VUNlR0c4jmenK0PM1bCujxQHuWlUv4Bw6BSnKYX+0YXgPM1/EX?=
 =?us-ascii?Q?M8AuolBeijH2e7KPasHyb3EQg7jjZk2mcVTlrDnLoaUC+klMUR1BtPHTiaRY?=
 =?us-ascii?Q?4DW08uLMMHGQHpFcl3Tcr4opKx4xcc1usZmQ+2tkHxfkrDdmMkqwIByjIcYj?=
 =?us-ascii?Q?sfEC+mLJlZybsVdiq+oxxPtGWh15olSft1cHrrHePKZtGLNGtfIOuWm+KeQS?=
 =?us-ascii?Q?m66v3F6KFC7cOxjxlGuYsthgYyC50MVyRNJyZvftDoD/g5o5n1k0O95Kj0g5?=
 =?us-ascii?Q?g1msSGKkMo9mji/beGGP4gqHrSDQ2ZRv481aD49OK1klT/pi0NqqIHn9HXJ3?=
 =?us-ascii?Q?P3AdWug8zlqo05OkOA2v+hBHt6NtHvfrB/asktQtxOr5w8u7xpcK+v/B6yQM?=
 =?us-ascii?Q?MUSwNNA7gke8OyR0HwrKCY+jxxYXzUzMJ0lLaEcpvL5pDa5jqq8ISXy9EDj2?=
 =?us-ascii?Q?ejVaFKcuWqSmfnd3gwYkSoNrR6KSgHVujF7/3L3JPxXkVxtUxlPnqGJuPyjw?=
 =?us-ascii?Q?WLsVUmpF7qb45TllL0CiG2oLqgjsPpiSUsB2Ah0zhrgb1ZH5mn3Iar8/yCZd?=
 =?us-ascii?Q?jxm78Km2sTqCArvZWcJOAscvjNLq38V2uOTiu/NOIysmlQ0q/5niG0UKKSks?=
 =?us-ascii?Q?v1n9VX12LquxdZ8O3w81Wh9srqRSKuPY7ljvgVpJXi4jBw/+SLXGJ/CtRieu?=
 =?us-ascii?Q?iS1bZmJR8wDcqKdEG7ciEFOrRe+uhUqRHNRck41Ly/LUXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d82F3yVnuqwO/hvqR0/B74jQ/KdO1h5n5F1Y4j8kC9RjnMXOhVUKIQ/ZNQ/N?=
 =?us-ascii?Q?lt95S+Q2yy3UJ2EF1xgyMpuxh+dIBF6DsJ2sgMG0VPZt4Jq1l9JYhXEpzxMf?=
 =?us-ascii?Q?qUHNjc76K4bygukHXOH6ciOBwOpuowzK+BQBo4eT7C83YlR9AtH6LwLJSJvb?=
 =?us-ascii?Q?vHoJYXGb9ZPltZt/ISnM2DomYecK5H60+gWq/wvdihzQzndzHXhh1/DMRiA+?=
 =?us-ascii?Q?bN9jXS7x93B3Ot9INeFy+jAmqix0mxTDdeWBy4csnd6VQ0j79cKgXqD6vk/0?=
 =?us-ascii?Q?8jsumhv4oT4ipg4G2o6DoloAiWkBhs4mFU40af+khMr+06EtV8lVE7nk38Zc?=
 =?us-ascii?Q?tAv5sK/mgzVGoghK3cGXUJ0T8kO+0sTc9JeAxFi642lTFGtX8dAWgVhwmg3p?=
 =?us-ascii?Q?KOR57dMJNWFX/WV98S/MDfaWIupFs8am1s6UDbuMIFE2ip6wKwRpkqUxYC6+?=
 =?us-ascii?Q?gWd42J3ftXgjaf6sOPsfoBYFr46Sy33eMLd0Ct56B+H8HgKqAoMia6FmG6MA?=
 =?us-ascii?Q?2UgAiw7XK4lVZsiv7TsAgfvvAYBHQ36NBIDIBOgKrcWNwPKbieYLgloUD+oM?=
 =?us-ascii?Q?Qw7DZwLwcNKvoztpygI+7SecC6QTLa7t3HmCYwNh94KIRHvoUvihV+BS2IOv?=
 =?us-ascii?Q?KtMk6MrUKigv4Z3w99A4OuaMPIpKVT2tNaq7UDeE5NR/1dxOtedGmhbk/id1?=
 =?us-ascii?Q?41TyHYuWHNk2Cr6wF2U8QPFtm7IRB+uyz3LBdApHArCLvc3liMYbquEEIE4f?=
 =?us-ascii?Q?DypQKpjTKakqwpDxl29uaVW/7KKHeC9EDKkmE0AKe/P7ALID1b4bx6UsKIn7?=
 =?us-ascii?Q?DZ5yfk7NS8aMJMwZfOMQd6PaKYmznvGMY2meNManSMF57zmljuls2sBnqc0F?=
 =?us-ascii?Q?QMsStXAdTBDYHfBEw00Xpt9GALLuRY3Zl37lMaC6pv17cJAjxTA9fUjo+nn0?=
 =?us-ascii?Q?4iVA/vj36bQi142AjGnT6yw/KXUQMJjLhfoZoBzVesWztnjg0PbT72SBa1LM?=
 =?us-ascii?Q?bXgywq9yn4lfDlasADVKaVWP60jfVuvgwuw4B35ypNC5Qjaz9uIXeuZ+50Id?=
 =?us-ascii?Q?YKYchKFXlwq87CZN4X7de4nDhbooa1TBDbZPx1F77IleFNenRD+OkYgiP0cB?=
 =?us-ascii?Q?vxBQ9xf2tguYz04tPftmXI16BrKyeQTbWIggKDRVmkHeKWUxzJIfomglunoh?=
 =?us-ascii?Q?lHbtzOWE74c+xlk6doqqw7Z8eBS/GZfBDBSzY6uu2nHOXPmRLEJHuHvKAP21?=
 =?us-ascii?Q?hKPHXKyfyNKVZSgajHox4fCfNOiF0s7hkenHhjYYt6AUnWHx1q9YJXpP8OMy?=
 =?us-ascii?Q?N7OoXYkr1WEad1eefWK56l6Zfr1kIE039z3SBgioCJTozblgbvu1Yl/cVPSg?=
 =?us-ascii?Q?eE1fMmKwF7dnJswQJ+l73GLq4qh7wljSEC0oU7KaxUUaHQz2RXidkmRkkSgc?=
 =?us-ascii?Q?UzeNLdd5GNG5jSGuZNyHOKIFbpGmD5V7gENss/xCLh/4Dvdsqln427+P6TCx?=
 =?us-ascii?Q?YMuY7YFRRw3V/NSBxSlO9M1t9NWCkEjFXMEVq9gWALerSJ0bAd1zTIZhhWWh?=
 =?us-ascii?Q?DLJasCaVwf6nRrAUFPwAOSxGkqQHjYChnmSC8l7T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf10ca08-21de-46b2-f4f5-08dd19de6caf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:22:05.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6w0cl7zl/L6G8ucvEqvBkgWI8TMRKHr5H+/Kxf4Wt3MzCex8Qs0Vcjd3PnAlWknbLBsG/5y6Lw6CvJAyyii0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

On Wed, Dec 11, 2024 at 05:05:35PM +0900, Changwoo Min wrote:
> Hello Andrea,
> 
> On 24. 12. 9. 19:40, Andrea Righi wrote:
> >   /*
> > @@ -3519,9 +3476,8 @@ static void update_selcpu_topology(void)
> >    * 4. Pick a CPU within the same NUMA node, if enabled:
> >    *   - choose a CPU from the same NUMA node to reduce memory access latency.
> >    *
> > - * Step 3 and 4 are performed only if the system has, respectively, multiple
> > - * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
> > - * scx_selcpu_topo_numa).
> > + * Step 3 is performed only if the system has multiple LLC domains that are not
> > + * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
> >    *
> >    * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
> >    * we never call ops.select_cpu() for them, see select_task_rq().
> > @@ -3530,7 +3486,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >   			      u64 wake_flags, bool *found)
> 
> 
> Adding Step 5 to the comment describing how it works if there is no idle CPU
> within a NUMA node would be nice. For example,
> 
>   5. Pick any idle CPU usable by the task.

Good idea, will add that, thanks!

-Andrea

