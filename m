Return-Path: <linux-kernel+bounces-429511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC19E1D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2494F164AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AE41EC016;
	Tue,  3 Dec 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KCrCye9J"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC81E5721
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231335; cv=fail; b=I6LcnSZR+gmKAIE39832bdtS+Jzd6CPmA9rN0fi1stAdilm6L2ATSW1w+EVd6mzPQQbzm9RWvuVyFUuu/KSeVrtMSucx0OevQ+4Y0ufJRz82IEGIBnKL5ga8FgviWfxNZduWhgQWjy/XquQTELueHrgtpCeP4jTI4ikuqGoq3IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231335; c=relaxed/simple;
	bh=Q1JvpNrBgjALFNpsTgAoLhh/PBagFeYwETJ+y2Je9gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T0CdWtf8SWryd1sc1kMWjW+iGK/D8CL2pF83bKMo5XRhwkPmoiwCjEAm786pd5hLdh7dhtz8SVMOFn3XOitHvucypeK4cNw7kJD6gmUASoLY0d7G3A7IuEmVK/f0MSpIojjNwUWBGsY0HXlLCTT+xzEVdMuntXBQtNXJ74jACW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KCrCye9J; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUmGXagObat/F/TwAriS1BzMGjakvQ0Kg7z7+ftGSyNYKy5lOcj8ZCR/rbzfDVqVfX30PANpH54TVy3GM+BcTaALxCHqpHdOXMmLVWljkDxPCVmyRpfBwu3aEeL+34SP2JfOvhyAi3d3RIkZTGz/vnJpacXKK0fF+3OqFOBACiD2NNFyNQJmudso7Gat/baj6Cy+pUeA/gKOZhHaUo2TkkgZMNQwmgC2OBj14S8BiFUTUa2B0OpkxoJYixi4+hLzxZxfMYw7ELX6znXJWRSA5mlQluFHgXXjdfUDfx7IxTvUvrN4OUy4ZSzFxYqumvtGJxVtRisrHExAF3/Y3kKl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWkTyvVwC1AT9Luch7Pw5kPu9LO32+/+H0o20CqdIS8=;
 b=u6pVxFzuNdinxaSsAspcUTYVUTL4PpSdd8gUZm4YKDkEz5lI+28YEm0D/Zk+AHlwkbj8L6yjN7CNZjSA+A6UMQsUDmgyF9furWuKfkzuKrUvEVaJxIObdGKSXg45cMjIK2Q9rsuR7y2p5Dt1ScO7jGd1TUxdRcO1XYpxp/8mBV1fbiRPAWWzzXP5EAII4Cv9kwheID0eYWtS77vNGlEiiFP+eJOfmRQF/C1GVjJlUx0HLZvU2/Ra4rZO7wiFYEd8TDwY95hf4Nu7R+WyTY4rQ+2bfQ16OxCl9UxRMGYE2sHx2h06n51LcVLf7GMB3Eq8npnvWCvhNDiZeVqLlNU+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWkTyvVwC1AT9Luch7Pw5kPu9LO32+/+H0o20CqdIS8=;
 b=KCrCye9J0UWefAAqbTGHwfSNGVxbUkN58cjcJ1ZMd4sbMw3h3ZO9uhu+oiYjuig8bxjjuEG2F5Y6T9eVRA8EkgVIbIfr0PYlVLBf2k223cEqOt8N0SdKimIEVk/snF40wj4m8Tw2G9uNbQCr8AE56cR18T/IugI5R77/epOi/8H7U6Ib4OiV3+p+QjOj1DuBjt2uH+2MiVbpw6qRsBtHMzmWNWqAm++HK/4UJeguufk7lx4hRRlhAs+ZeWUdVfj/u1F+wI1KcyMz5OJkPEwIbf9L6YSR7JU1g0sJe7gDXmaT2tebiluLxd8C4SI5n1LiPQuY59YKlAKtDtHaChGQvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 13:08:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 13:08:49 +0000
Date: Tue, 3 Dec 2024 09:08:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: Help with atomic fallback
Message-ID: <20241203130848.GK1253388@nvidia.com>
References: <20241203003856.GJ1253388@nvidia.com>
 <Z0747n5bSep4_1VX@J2N7QTR9R3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0747n5bSep4_1VX@J2N7QTR9R3>
X-ClientProxiedBy: BN0PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:408:e4::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 0696a9fc-b5e6-4f46-1f6e-08dd139ba0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5WamgY8PE6THRjfE4pisMe3jXOMJhTy1bOzRvLIup/wEFhz+bMjrVfzFrHOJ?=
 =?us-ascii?Q?Rv4dV2CLo+7Qmvhb73I7Zi2VWp4VO5bPwh4t/JCL/MO0fQq5mldraJdMAEK2?=
 =?us-ascii?Q?z7hsXOCxlyRyyNSEqjI3LYBKF6PJMvON8RqAy8ZAWNwTpdKKJ9PvDA6j73N1?=
 =?us-ascii?Q?eSIpRxsZWLzcfBekGyGMkejEskhFfKV+Q4yLL4ADa4Ml8znFLix6lTB3vksA?=
 =?us-ascii?Q?R7BY//JgNPwig+qY+BOr6eHxk8eo48p0ZW346vne8EtFIBG+0RGGor+Psco5?=
 =?us-ascii?Q?olbU++P2Ov97aOsMzOeDavG5jFgVbpLbIoCDrt/dhukhlqGzWeYEbO0OGAnV?=
 =?us-ascii?Q?TWTe9fepREYrUt6NtsvJ+0rKTWz6QDsgqlv6myZ89mWngVuF+LIg/gMGXTks?=
 =?us-ascii?Q?yNrJoNplwAKOJlq4XdxOktCMd6HcaIK/LX/OFAhI/vDVOEWETCYCE4i/CqZq?=
 =?us-ascii?Q?OKuuQME5pQI2Jb8OetpKxS1mWiZJk410a1I+EKBIL7Cj39owqasZpAZlaokw?=
 =?us-ascii?Q?bofCCz+zR6yR4arYP1wv9dxQKs2FCwHfRYwImoKJJbjFwtTKviz++Yrh1Jd/?=
 =?us-ascii?Q?vliOzXGsDX8nEIdt+0UXvw3aVyHk3L9usFK5fB6fizzFGD6Hog7Kiupi5w7e?=
 =?us-ascii?Q?g0DZcIkZkl3XyEN/sc8klSX4l+q235Ux7CIdew8Rxjv29lUmXP0ZNtiID8aJ?=
 =?us-ascii?Q?VTLOI7o1kiirnNKC/eb73PAlhYx8ek4Pt4ZbstLsFYcJOTHyCXC9EW1A/sdi?=
 =?us-ascii?Q?Y6RAYFxhebLJbPZrDjOJqbj3L0m1Q6lvo7OCIy3Tts4YO0E8OXRMv8K60P1G?=
 =?us-ascii?Q?VmbIH0epvoaauOZHdrCdezb+7+eNk7R0OPQDmwJlhKn+a2RRSlxUFTx9l+0e?=
 =?us-ascii?Q?7z/jmmftBvc+cPMvpEXhNZJ58a0T3d4EcnIMqy6q7ea2+Xlbj71fU3DiM6CG?=
 =?us-ascii?Q?IkqQxTf0R/jq6wgrz0LGD6J4dupjnlwpgiRsCxnuCIbOTP+suL/K+gxKXUta?=
 =?us-ascii?Q?RtHzKvZseT7tz2ZoFUfhPXkRsdG7baw847yGyA/5Hjf8+7GO9xlJ9lRennIh?=
 =?us-ascii?Q?YaJykZk7Y3aFwpOZCQXCn3dTZP3wogY7eG/qNk1BgWgNYuTGOwDZ99HkKypK?=
 =?us-ascii?Q?WOyqPoK6xaxvbuFZQA6bJuuoaeRvYFT5RYoG2cUoQNY3t3uqujU2amsyvCM7?=
 =?us-ascii?Q?aG5emaYgX51ZMAT4c/mdMyAjpgfau2Qd89IQLlQUbRO331TDmSIS1FUo96zd?=
 =?us-ascii?Q?WSAF5k7hoKth/Uv0V707TAwTmW8tqAILNTSouuks2blnzLiY/56Na/ogNj23?=
 =?us-ascii?Q?1As66JjHHvydoGv/tInD6i9VL2u/FhOhiH+kvydW8uFJoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dks5WaxgrOj6gv2RQl1EfLNScnA3xF8AlAARxUuR4KAgF+ZaQ1taeW3yBlNn?=
 =?us-ascii?Q?CsMP2JfTG+8wc8uZI6B5HLprIsdikqeetvhn6s96/5CTXhugoevuMkXVfg7y?=
 =?us-ascii?Q?yqCPCwLLk7Lm3Y0BU5iPcdqrVnMUL6kq3SjzDXCKvuihvSi7HymwwKcksg/6?=
 =?us-ascii?Q?FhA2DapHxqae/cXSgHCT9tOJG+iuPE3gXoU7QBWWxOSFfOEdlNQzehtnSQaq?=
 =?us-ascii?Q?5Erfx7tabWCfsfKGZ1/zWbDlJsXatznhRaIWVpcNFdPAavOLrqhTYTFXghr8?=
 =?us-ascii?Q?t0WiuJLCBtM77wq2dRjsBiz4+dq9osM8ApGFXf8K5/it9RE27T3VQ42DhDxP?=
 =?us-ascii?Q?JI1uqy2uk5ypWF8tnFj792WYAUUTXos25GujMxy7U16hfPMO4qwdNCtFLFk/?=
 =?us-ascii?Q?JnHFvf/rwx19mz6rSVHJgR2bGlXlQVh8JR4YMJMEmK+DmGUKO4Cl8Vy5p3b7?=
 =?us-ascii?Q?0MHuNJ5A27jpaelPrru3xLMC1toXTQxV62yhVa9edASDvLM56fujlZRn/jJ+?=
 =?us-ascii?Q?ril80725zYU3NSJSU/tfsRBrC9ZVUxgZTVJ0/fTtX3+akbp7m2K5c/KLbx5E?=
 =?us-ascii?Q?nXjUSwNU4cxmr3ZQxFKuZHO/KGluIfOVfL8eufAId9ZmA7u4a3CDx2dzo4hn?=
 =?us-ascii?Q?A8lZ3pCirKAI8qvm8XdVTFbNHvoAAYYlQDveQfijAtKxZFb5BgOdZHtgFBY8?=
 =?us-ascii?Q?nnT/sa95jOG3wVz8j+9HJli4nluLfo0PdtHwPHo0tOAPdEb6qdt1Jri0/c+V?=
 =?us-ascii?Q?aYH2eNYxCELY0mlJYNSsIN2oKjBehPOPtbe009aMSdeTXCFxaWI2GJW6rpDs?=
 =?us-ascii?Q?MbE9m4cfd7boV/bprfB65u+i3pusTTO5QbWmICE6cNnMkVk+KDj9Dpi/fPSx?=
 =?us-ascii?Q?jVJ8kBRbznhy3y2Al/Hct8lgHHTq0DXm89yrGGN0Q5zI9J8hVnllaICjLGM4?=
 =?us-ascii?Q?FSdg0rmzTgcL7fkYPVS+9Gn7OgzZ7zU5jD1Mm7YwzGzQfGCcwF/lXElwK9kC?=
 =?us-ascii?Q?SdL7RPAuyk2atsz48pJcMlSuprgo5/7RbXwWnnVtC8Gk0fOKEITjcqJqvJc8?=
 =?us-ascii?Q?JUTd7Yyy7Ad9UxUdpdwnMVSCvK/lR/Kjhmk67MDSMnu0lfY9GzWdI77iN4Nh?=
 =?us-ascii?Q?s322MR5xgr/qohgivqnpru18OIGCbCoQIAnJ8blsWJ30z4UiIldLY4fYcNxY?=
 =?us-ascii?Q?GMN8Z1b56IL7ZYH4wfem8Mihdjtm24u7Kx6Bd2seD8fjuT3zefVZLWD2/9Tg?=
 =?us-ascii?Q?HQf8ECbmMtylFsJIbTs+6GcO8QdGH7PxYK5NN25P2J2ahVmZra810VeZHl8e?=
 =?us-ascii?Q?FULfYbHN8GsOKfbcUyFEclnvW5I2WUbaUlFJViYMcxspN4+adOg57279hc2S?=
 =?us-ascii?Q?dKmvzqkGjDczXDpr4/2Gq77EFa+OixewRjVvNhXAFWqX7YsiVpkoDe8SwJcf?=
 =?us-ascii?Q?UYoAxymsPqB+hKBxDmTFvb2aA4nXjIROc6XHjNXbrl5tDts8yb1GKWZrJw89?=
 =?us-ascii?Q?d87b3BkMKh3t+bM2byLeHj5an5QVVnigaP3HmDOQMNHInjVm2v3LgRXlFg6r?=
 =?us-ascii?Q?+V2qqScRLQFjkpKGYsc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0696a9fc-b5e6-4f46-1f6e-08dd139ba0c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 13:08:49.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIXDAY1KOipZZzZptEvJmeUX4DQLJY4+dUS1+bhU2iE1qzEj5VMrc/CPPzMjFOqH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

On Tue, Dec 03, 2024 at 12:26:22PM +0000, Mark Rutland wrote:

> I'm assuming that's the report at:
> 
>   https://lore.kernel.org/oe-kbuild-all/202411301219.jHkzXdJD-lkp@intel.com/
> 
> ... for which the config is:
> 
>   https://download.01.org/0day-ci/archive/20241130/202411301219.jHkzXdJD-lkp@intel.com/config

Yeah, that is representative

> > Which is immediately because of a typo in atomic-arch-fallback.h code gen:
> > 
> > #if defined(arch_cmpxchg64_release)
> > #define raw_cmpxchg64_release arch_cmpxchg64_release
> > #elif defined(arch_cmpxchg64_relaxed)
> > #define raw_cmpxchg64_release(...) \
> > 	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
> > #elif defined(arch_cmpxchg64)
> > #define raw_cmpxchg64_release arch_cmpxchg64
> > #else
> > extern void raw_cmpxchg64_release_not_implemented(void);
> >      ^^^^^^^^^^^^^^^^^^^^^
> 
> This means that arc isn't providing a suitable defintion to build
> raw_cmpxchg64_release() from, or for some reason the header includes up
> to this point haven't included the relevant definition.
> 
> From the ifdeffery, there's no definition of:
> 
>   arch_cmpxchg64_release
>   arch_cmpxchg64_relaxed
>   arch_cmpxchg64
> 
> ... and hence no way to build raw_cmpxchg64_release().
> 
> The intent here is to have a build failure at point of use, since some
> architectures do not or cannot provide these, but we should clean this
> up to be clearer. The mismatch is intentional and this isn't a typo, but
> I agree it's not great.

It is not consistent..

For instance on ARC io-pgtable-arm.c compiles OK it calls:

	old = cmpxchg64_relaxed(ptep, curr, new);

Which expands to:

 old = ({ typeof(ptep) __ai_ptr = (ptep); instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); raw_cmpxchg64_relaxed_not_implemented(); });

And no compiler error. Presumably it doesn't link, but my compiler
ICE's before it gets that far.

> In this case I think this is an oversight in the arc code, and arc *can*
> provide a definition of arch_cmpxchg64(), as per the hack below (which
> implicilty provides arch_atomic64_cmpxchg*()):
> 
> | diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
> | index 9b5791b854713..ce3fdcb48b0f9 100644
> | --- a/arch/arc/include/asm/atomic64-arcv2.h
> | +++ b/arch/arc/include/asm/atomic64-arcv2.h
> | @@ -137,12 +137,10 @@ ATOMIC64_OPS(xor, xor, xor)
> |  #undef ATOMIC64_OP_RETURN
> |  #undef ATOMIC64_OP
> |  
> | -static inline s64
> | -arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
> | +static inline u64
> | +__arch_cmpxchg64_relaxed(volatile void *ptr, u64 old, u64 new)
> |  {
> | -       s64 prev;
> | -
> | -       smp_mb();
> | +       u64 prev;
> |  
> |         __asm__ __volatile__(
> |         "1:     llockd  %0, [%1]        \n"
> | @@ -152,14 +150,12 @@ arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
> |         "       bnz     1b              \n"
> |         "2:                             \n"
> |         : "=&r"(prev)
> | -       : "r"(ptr), "ir"(expected), "r"(new)
> | -       : "cc");        /* memory clobber comes from smp_mb() */
> | -
> | -       smp_mb();
> | +       : "r"(ptr), "ir"(old), "r"(new)
> | +       : "memory", "cc");
> |  
> |         return prev;
> |  }
> | -#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
> | +#define arch_cmpxchg64_relaxed __arch_cmpxchg64_relaxed
> |  
> |  static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
> |  {

Okay, that is what I was expecting to find, so I can ping the arc
folks on this direction and maybe get this resolved.. I'll send the
above to them as a patch to start a discussion

> However, there are other cases where cmpxchg64 doesn't exist or cannot
> be used, and the existing (x86-specific) system_has_cmpxchg64() isn't
> ideal. I suspect we need both a Kconfig symbol and a runtime check to
> handle this properly.

> I think if we fix up arc along the lines of the above (with xchg too,
> and handled in the cmpxchg header), then we can rely on the Kconfig
> check that the existing io-pgtable code has:
> 
>   depends on !GENERIC_ATOMIC64    # for cmpxchg64()

Yes, I have been relying on this as it seems the closest thing we have
today.

> ... and we'll (separately) need to figure out what to do for the runtime
> system_has_cmpxchg64() check.

It is gross, but at least today we can do as slab does and #ifdef
system_has_cmpxchg64

Thanks,
Jason

