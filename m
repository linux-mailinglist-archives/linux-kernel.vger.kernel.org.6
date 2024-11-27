Return-Path: <linux-kernel+bounces-423119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF49DA319
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB0C284239
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AF14A0B3;
	Wed, 27 Nov 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="timsgAA9"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A171114
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692574; cv=fail; b=LGi0ZtGT/yJbxN88w2XG0GSt9Qmbk8e8XlTWN7HHZ1CveUc5SI/W6IxnQe/KjK0ZjfCRXVo5bALYqGtgTJrsumJtE+UylppTO7Sc+TlPi9MJ4/BebOisuQWTxnr6HR39cRu7RNw0ih/p8s9bLB6KV6E80bRV2kbVmwwdQKkIKKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692574; c=relaxed/simple;
	bh=tktLAs1aBrwdG8BxH+MoFv1ni5V/QOpFQWadLxzOt1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sAqZLtngjndRWwZS0dUyn49iLEe0AFo+AiGatIf8mmPIOHisWUFLYICDFBHiYj077LNNRU8bzfjQVcBdPyZHS6OAxbQPsAItgLNM9l39e9q8umcOeuVRNNYpwcan7SuBRo1C39d/Lvd/lnHLf8nR0ey7jkOFXB9hq053dDFMmQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=timsgAA9; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neZ61XxQhcNnsB/aB+34qaWhRSRqkZz+X21B1a22v2ZuLwPkgEkugK35L1+Pc/GaQnw8uE7bFhF9oQk3AJoVVNuvoO/E+0aY/cMNvrsRSC3eRYA6PeJ7wAPAbYP3vkIGmb1Ro+MissxdyLKJYuY33NrrUq2eu/0l7N+0mFtdVeTTADnPv4Llr5hKCVSc5RKPN1vkecSRuQAEAUOZBMt/vXHQxiTB6CpX00CW+mh/EqWV+UiU6eHdgXMRVEvrW+Q6So2bqIlY9fFKS6uPqGN2iB00aFp9B50YqttYOIK1kaXQqkCsvppvNNFX1tjzq1yPgMrloHC+uU/ICzmaQufrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEGOsO7E0BU3d50aXMIs57Fo6DNP+w1C1YbO9SFMkw4=;
 b=NtwhXbQIy+05GU2mL42ilU32Emu6l7p+QB4QySpllXJtSioptKIJexyZabq+Jre5QFpOkOTiGoglUXZNNW3HcMPIaa3wVXTiLWtXOMaB8BUENScAbhAUHmd27ucY7TViI/yg+CSeX669x9zd5W2oIko+1YZaJnzpY+OQrwkuD0n+d0dNz4YWPCxu0/e/tynj7YnJBTCDol93nWJfhSGCSnAEKv6dLYRjCoIRkjOMqg7oGc84CJXf/hMPCI9DmXqI3spIECfpNPrRnZcrrVnesmIc9uTDJvPbyyer9Lcy/00nHYVy6n2JD+2mDHekAwT7oil8tQUw8j2jJd+AwaNDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEGOsO7E0BU3d50aXMIs57Fo6DNP+w1C1YbO9SFMkw4=;
 b=timsgAA91fE3jbA87cOn2VPcIuiqvcu4i/0LaV4uHJvug1C20k4pPMeTagnZUWYR2FoKgssK8TBNu1JnJitbMY3HlZWEG0JvdoIUSjEpgW9t/jVDnAx59/zM5Cx92wBdNXj+l0+l7w2kjO1NWTVRVuCuAHhiARuWbeSmC5BRNdBUo14SQwW6KVF9K7ilUJzoNPbd4ULl4t5mmcjaeuMxbb11tOYff5somlQ8d+W0WiJkj76SZjsGQdE1fqAjMAfupRfeHw3NBrQBj32fFRUu3B1HitMEwtOSErA/rBVoMju5iIOLEWZRXpiF5gtQKzFDZ2bgancPJxdfGF7ConZAhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 07:29:28 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 07:29:28 +0000
Date: Wed, 27 Nov 2024 08:29:19 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nodemask: Introduce
 for_each_node_mask_from/for_each_node_state_from()
Message-ID: <Z0bKT9nbSlw9WeM_@gpd3>
References: <20241126101259.52077-1-arighi@nvidia.com>
 <20241126101259.52077-2-arighi@nvidia.com>
 <Z0Z0omMh5f07xv8H@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Z0omMh5f07xv8H@yury-ThinkPad>
X-ClientProxiedBy: ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::25) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: d30e9182-0828-40aa-1fee-08dd0eb53a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZX/IKX7q75zKY2NuheYekmaYQmDjNbsY8BBEKpoi7DTi+RWxWuGm7SVBJqWs?=
 =?us-ascii?Q?3M3NWPyeR+MWBz1xfwXZYrJ6xnNHVNiLF+DnW+KthwnbYG/pz1YmCoB1maxh?=
 =?us-ascii?Q?eo0LrKveTjCIXtMbNpz2DnXn8vD7pOm45o7TneXXa27exzjGY5OUAMQ/xVei?=
 =?us-ascii?Q?v7sCCciwOzxzknAdcRVyHXxvh9EZSJxlQo8kn55kVhiTaCWP0P8v1LV1+s0s?=
 =?us-ascii?Q?3+ox9EY4/uaAslFm9rAzPqHxqSIZmEdkw1ch3PiI4/J2Aqv5+wj8iE0kwP79?=
 =?us-ascii?Q?qPVquKy5y+ApAfxBlOuvKvbZqjz1JgZRVdhZh5PVKohjkkAelhjZRJ2b1MoX?=
 =?us-ascii?Q?ifZBtQKZS/6VB+7TK35JxtnaiOcpeqW+OT+WekY2rSUvN/Fts+TjoPfHAmqX?=
 =?us-ascii?Q?rL2dt6XcKlL3J7yFzLgJZYQOWF0lmURIkqO9l1jBAkmAFVzwyLjWYrIOjUJK?=
 =?us-ascii?Q?YL7e0HwAIkv/j/qH6xWKzbCpcyJFQq5TfLqQFcboNEepDcwyo33ZkFCyth5U?=
 =?us-ascii?Q?dlVwAkmXA7hkc48MsDn+JNgfuzg8pwjFw8p3F50fwbtfqbQpNsNYyMwRLYkr?=
 =?us-ascii?Q?QrEm1LSSGC3FNNc8hlvsYLKCFJhCJaZFuMfC88lTmq2iXZSZAY6XHNPmwfQR?=
 =?us-ascii?Q?4qYEeaQbsF26zvJKUeTN57c0wDQNMRjtUxecEVDIogR2TW4tH4g00o6NVs10?=
 =?us-ascii?Q?LkTORZEjC65cxj00PxKnDN3StfbtyH9tR3Mv6g63KpT/wbzPlAfThz/5rp6D?=
 =?us-ascii?Q?t7KV9SvsyczdexBsJtfGl+w7XsWIG/33OLb18ix/obgo8YrLNl2pAYIb57nY?=
 =?us-ascii?Q?uQPbHzE7YfrYcISDpzZNPwRxWsNliPM4ohJuza2jWVAAoEhzllKOTe6sudCb?=
 =?us-ascii?Q?ZQlvpRthOIOnhZ/0kXJMsVXIq1R7q8Jnt0fs54LsM5BqhACg1gBUvctq2pzG?=
 =?us-ascii?Q?og8xf+vdaH6KBEtA9JSw5x66mSCMDqM2FShjAAnhWBYaH+MQrj3wOxsapPyb?=
 =?us-ascii?Q?F9NJ2VqFtKN3BUWFCLLD0urFu4oysoxpFxP8yVysdndhFJS17zTkB6f0tPkq?=
 =?us-ascii?Q?Ch7sojrIVq/YhEmjLN+2N8SSLRFV3uy5nvF3rVlj+SE29A4Q0w2gukr2GBqF?=
 =?us-ascii?Q?extYblpOb2z9zC2/O/VE6FZjDm46KTjhhXsCUj06IH9596m8JGS1F5FOZxDQ?=
 =?us-ascii?Q?wb9hIsiXd7A6ibv/n+gRmhAOYiQbUxKVnPgI5tSvyqP1m1ZNcYRueoblXNdw?=
 =?us-ascii?Q?aGaGjN0ivqNoBEsm6E8g1y5IpnsYPpU2k9KY7Cfq30jBHwGqeH5WEdtYqyBQ?=
 =?us-ascii?Q?Zt3ka5V7eapGnNft6m9HFzHyQUyXhlttKmr90oXklp36SQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vOhKMXMmNTb3lFPGh3dcH3aazy8KW9bHuCxIvvPxXY/OiGCjHe+Fpzja+S1H?=
 =?us-ascii?Q?4WqWP2zy9tUEXMDFsZB8Iz/asFus6y165prqhlC021WGZKrhshMQQHYuAAFE?=
 =?us-ascii?Q?b74TsQ/wqAZboRQr/+kFWiiWsWsbTR8muQqMI2pY/14vo5Zg1tlTkIq6UI8S?=
 =?us-ascii?Q?c5Z1IJmNRd87tmn/7BEt86K8MWvg61mbv03ld8w76hW2xmHJ9ZX5YGdGzp7T?=
 =?us-ascii?Q?/W0rb9VfPX8tvzVqzRSLMo2zXwENlJmd8zkZ8D5qq8ZevZC3b73t7zamCpY0?=
 =?us-ascii?Q?/edxIpa0MdZ8u1XL6QoLsZrs+hzu2GCIW1A0p88/lvpbNW+1PbpS0Q/jCtWh?=
 =?us-ascii?Q?yKJ2JPyAm6/UZ9o8DHvZmlLlge7D0OaVS/gX2yhj8fv+93Vq2y0aFJIn+SBZ?=
 =?us-ascii?Q?fiH+AeRUtya+D4eGok8P0IOzuk6jlkYQLXTnJxs/zhHVlS9HxgV12uRbnwy9?=
 =?us-ascii?Q?5dXpRXYlSFuKfGnzsCKHdYkUoCBOQL3ExeD/A2P8SgyiuOnizhmY/CddqUXM?=
 =?us-ascii?Q?SFXO6k/P/NYbHLgYWe5NwXKUbu/r4y0mI8hWZLT0Z+dYIydcFBbX3scddkmy?=
 =?us-ascii?Q?0YFh00w5JrDRMlJ5mnt4BqKH8BkoTwI2SDaYL1qV8tzXoSwrakoJCgUcIEaL?=
 =?us-ascii?Q?lg+KDsgf5n7uuhdYJgWgu9PlOF5VViDXjHTC+SPrC+RgG8TyE/I5+YM1+uYt?=
 =?us-ascii?Q?Rxtyz5+vQjVlWZqYDtGNNS40nDiyyn+k7x7gRekPekl1zGrcifcNZ0luGvia?=
 =?us-ascii?Q?lQVw5xljIJ2TfT6HUWGgSPGHpoKBPZowkYIFRuY0MFSBEKNduLP3xWpEsCe6?=
 =?us-ascii?Q?fVmE3ef2x98fq1lqqUw1i4+19gcAvTqS5LJrngnpLoaQzdJhfHI5vKnDQMX3?=
 =?us-ascii?Q?M9qNNj+kNtqIgQ10WxqXkUk4Tz0Wd+E8BUewLDwnYuZLq1vOykvXs12Et7tG?=
 =?us-ascii?Q?TTgzyZcaqKWBODC7NyHZ1VzldbKFk3PTo53q5n3rliDQ5ahW0sdmD0bkQKqE?=
 =?us-ascii?Q?WfTMyuN1X6D6Nyv4DYeiK2C2/rkND9OC6qoBBM38m3jRfZZx+EbQpoWka7L+?=
 =?us-ascii?Q?v49ya5Fi4cd3mQfckKqh1XUxTMGdqufG/1u+jz1/LDuLN3HjdlFYBohWo4Gu?=
 =?us-ascii?Q?q88VeNYx4MMSoMPbC4H6yudRextgRCN8csJ4friMHVD7zwo36r+WtO/JkJk2?=
 =?us-ascii?Q?OWxy9AHTeYFhiUk0q1rIenx5mR77wqfkUPaWR25JHLS/MmTCTE6gFPp7fqyc?=
 =?us-ascii?Q?dLMzjayi54oW2k8rAscrBU52bHODCCbFy2+HoHIm97X88DQVPIY8gggA4GJv?=
 =?us-ascii?Q?Ine9QR5Rcoy/L/RkUsyP6Z1p6ssBnm8vdg9oGlRM87rZKAzG9yYTdMaQloKX?=
 =?us-ascii?Q?4YOyiqPkRuEMkjVDe3oRI0/2qHwcz5Pp9480FoPYrpP9cAMpKiyhO0Qne8jd?=
 =?us-ascii?Q?nOqbpUnNaj0Bn8TrFhy996IjPesTpIMXxmV7MYYJFo29V0eyCnsWJJY95oh3?=
 =?us-ascii?Q?L74EZmIxJXi3cdfcJ2peEm6tbDiTTQKavAKAhTqan9XN0w0jFB5ZNpJKAD0e?=
 =?us-ascii?Q?yPgrac9bkmDsXm1gW9xJGU7CW6R7GOmjlhJKbPWX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30e9182-0828-40aa-1fee-08dd0eb53a34
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 07:29:28.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oxmt2J6g66gRcZtj0fDC1r65kX4P/xABjwuQCDdKYBWHGQqZEj5R0dWEP1qxhUGWMf1+O0jTAExHewRq3SI9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947

On Tue, Nov 26, 2024 at 05:23:46PM -0800, Yury Norov wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Nov 26, 2024 at 10:56:39AM +0100, Andrea Righi wrote:
> > Introduce NUMA node iterators to support circular iteration, starting
> > from a specified node.
> 
> We have a special suffix for circular iterators - "wrap".

Ok.

> 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  include/linux/nodemask.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> > index b61438313a73..35f1fcdd6a84 100644
> > --- a/include/linux/nodemask.h
> > +++ b/include/linux/nodemask.h
> > @@ -392,6 +392,21 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
> >       for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
> >  #endif /* MAX_NUMNODES */
> >
> > +#if MAX_NUMNODES > 1
> > +#define for_each_node_mask_from(node, mask, start, cnt)                      \
> 
> You can just use for_each_set_bit_wrap() here, and avoid this ugly
> 'cnt' in the interface.
> 
>  #define for_each_node_mask_wrap(node, nodemask, start)                 \
>         for_each_set_bit_wrap((node), (nodemask)->bits, (start))
> 
> (not tested though)

Ah this looks much better, I'll test this one.

Thanks,
-Andrea

> 
> Thanks,
> Yury
> 
> > +     for ((node) = (start), (cnt) = 0;                               \
> > +          (cnt) == 0 || (node) != (start);                           \
> > +          (cnt)++, (node) =                                          \
> > +                     next_node((node), (mask)) >= MAX_NUMNODES ?     \
> > +                             first_node(mask) :                      \
> > +                             next_node((node), (mask)))
> > +#else /* MAX_NUMNODES == 1 */
> > +#define for_each_node_mask_from(node, mask, start, cnt)                      \
> > +     for ((node) = 0;                                                \
> > +          (node) < 1 && !nodes_empty(mask);                          \
> > +          (node)++, (void)(start), (void)(cnt))
> > +#endif /* MAX_NUMNODES */
> > +
> >  /*
> >   * Bitmasks that are kept for all the nodes.
> >   */
> > @@ -441,6 +456,9 @@ static inline int num_node_state(enum node_states state)
> >  #define for_each_node_state(__node, __state) \
> >       for_each_node_mask((__node), node_states[__state])
> >
> > +#define for_each_node_state_from(__node, __state, __start, __cnt) \
> > +     for_each_node_mask_from((__node), node_states[__state], __start, __cnt)
> > +
> >  #define first_online_node    first_node(node_states[N_ONLINE])
> >  #define first_memory_node    first_node(node_states[N_MEMORY])
> >  static inline unsigned int next_online_node(int nid)
> > --
> > 2.47.0

