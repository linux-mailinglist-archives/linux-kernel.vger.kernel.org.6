Return-Path: <linux-kernel+bounces-555641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DDDA5BAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20AF3AFE47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84322424D;
	Tue, 11 Mar 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="eMfQnBd+"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D751E7C2B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681140; cv=fail; b=noCrxOXfnCLJyEuiGGXR84DuvkwohXg2wRAKYGie/VHW+RIYItn9ljAx58F370bbeg9NyN8brO/JDoLnzYJtelIxfUztw+aX2lI80PFs2/t2622QXS9+3i8YDF8GHzDPQt4QPyEStDQflnWBiq19TFGT1oF32haseprl4oyiip4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681140; c=relaxed/simple;
	bh=HCrCZzDcPIPaeoPc+8dNPPn47O1/om9HID28cUx6c3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjVf7YSMo+2gAFg2K5FKWfm95qj8Ccln2q/JBSqOhw4UB+zcKh3nwtuqAtKOxozOiPn3qxwlK7tYsooMdGEARgD+YzoZXkrv0afibjkOC7Dsqah/rZAhUQcsgA7vM3bXhOzhb0i6aV/Hexg+baeF9IPkbuAnI+fzqIM9jyhB+VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=eMfQnBd+; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHpMwRM1iXDITUYjPbEIvf+efrr82Gyru8xE4zfN5Mwr4l1RrR9MiRRvAPchIst/rieOyBIpT1f1h1g1nbTOlR763HMRiXazn8/+8Iu24kdYvAoYwQYr8tr7Zc6xb9XDUle+2AcCCyqQeUBto1VgOVG62FR9jbDnX+ssOgLXT+mFTfiOHmfIZec9VLD9YwY5BJToYj5gcqqeyL9xJ4RVoZOtRBw9yRI7TuQ3+KKiBxpmTMwyWARWuYky1/PQoBtXj78G0e2V+Uev7TsDnFYvqhi6hfuJ/68lRvtubvlkVDgyJ9wwPB0MM10UFF3KDf2O+Y8zBs5ubMnzA7wyDX5P2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ogmp36lK6MVv6LSWl8DbUYxI5w9/zNtPZNkGEXd3NI=;
 b=GBd+h1NIamo/Y0c7ImskU0YXWlqnnGBNPgc2KF6Vj/LOmwBigb2vtPjrbs197vFQjCrxK6xr79gsiRayDXSkWrrUj0HnFDCs6mXPUIEeUMoxTWIlEN3hIu65ypcp3W1giTZ+wRivvn+dr2ASDZTmvlgoyzlvCmOBEPBfCz7buJr0plLZkIdSym/ffGGz8QprhFsjKM7/i1M/5wROq6A+nrgDN33vUsuBwClLavGVq7C/mKkf5zcbHgI9d2Ra2csgR20XX8k6CND3xoBdfAP5Y59zaihT0SmuwHPQeEu6xaFlOgMN8X4Ay/HmZO/lNltE1TIHu+kLU9dRSu5vFOFijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=intel.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ogmp36lK6MVv6LSWl8DbUYxI5w9/zNtPZNkGEXd3NI=;
 b=eMfQnBd+JI0o8OMF96H8dI1w4A7nIjZ86ziQ+pGmbyxOAZ/zAwu2WigAk4opFY+QKaxb4wXGIACQ+Q8BVFrbURR9MMa0+a4gD6fGBQQ0KHvonO81FYibJhhslZuz0iOBx8HCG7QPv3aOBqnTIdWPDWvkZAi8kStTy8Uggg/9o9M=
Received: from CWLP123CA0041.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:58::29)
 by DB3PR0302MB9206.eurprd03.prod.outlook.com (2603:10a6:10:43c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:18:50 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:401:58:cafe::df) by CWLP123CA0041.outlook.office365.com
 (2603:10a6:401:58::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 08:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 08:18:49 +0000
Received: from n9w6sw14.localnet (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 11 Mar
 2025 09:18:48 +0100
From: Christian Eggers <ceggers@arri.de>
To: kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>
CC: Russell King <linux@armlinux.org.uk>, Yuntao Liu <liuyuntao12@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann
	<arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: substitute OVERLAY description in linker script
Date: Tue, 11 Mar 2025 09:18:48 +0100
Message-ID: <2110116.YKUYFuaPT4@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20250310203729.GA26968@ax162>
References: <20250224125414.2184-1-ceggers@arri.de> <202503050230.820w99b6-lkp@intel.com>
 <20250310203729.GA26968@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|DB3PR0302MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 76999614-5ef2-4676-3236-08dd607559ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ejFHC08VeUpmMW3A8LxQg5u79sUtkkHsGkt2Of68Q0xmeL9U1+JtD5EAldXz?=
 =?us-ascii?Q?LKoaSY5doxZqBGnbEa3eeBo4BUpZsaToApN9oihGX2mmFpe8u9pAzyDwMHRD?=
 =?us-ascii?Q?0OY3tAmVIrPgobZLbo2DN4UR6ks6itC1rzcqvSQNwW0DxyewLBv/FRth7nIg?=
 =?us-ascii?Q?1A6yzOrUoWamR3QyBCji2y6ioVvJZ8Fpef6X0eMSpKFdMWbB9f/Hj+m//WDH?=
 =?us-ascii?Q?wjqz4IBS3b9kwwegr/3ADi5CyWbBUiA57BsqeGvkPFFms0Pgof8LEBEWc8wI?=
 =?us-ascii?Q?RTR9fj4vl0AuswyqYabjNk38yoDz4ybEVeF7yUj0Juco4EBNhHU15l0YBf/v?=
 =?us-ascii?Q?8t2sw+XenU7lkXKYT/0ysidUHcLN2xfoVawPcb0eC1Y9PtORXNsl2MRvSyJF?=
 =?us-ascii?Q?8jm2Nb3IXjg57dfe0epGOPMJncDrBlPpLoFUAnyMtMBBex2RgQ5nsOUuGqyn?=
 =?us-ascii?Q?+4sA7gR6EygeS3tgaB0YnJXn8ruV1tZo43vRJyqFRebXlsusHCEosDMeA29K?=
 =?us-ascii?Q?30sUT7BSFZYOE9yD8YH6wG46nnEfjYl10oE7g2wn5jjo6/ew1783tFfl+luk?=
 =?us-ascii?Q?stfNotn7XXRSzI0YwzrOSExnfapI7XOqUP/QDA2W5xolYsge/WsjgH6B2XRd?=
 =?us-ascii?Q?0ItXELFgBe+5WrZ0yzWnWAgBpaOx7/7mH+HlSbPQDn9O+Eh0CUVdZdVsY8ip?=
 =?us-ascii?Q?YTKKu1Xe9AkuaTFJ+0ZSKcQXqeS/iaYYZ7RvBL4LOt75I2+6vGHi9+V/aogQ?=
 =?us-ascii?Q?a9+KByt+Uq1gbmZqv0GlLFcSTeur+yj2O4SHRQFSV9XsIQYaKIswDPs0Kvbj?=
 =?us-ascii?Q?hPGmMnVfvcLbt/NW19R0w5fB3izu+YfmQHYEkKyET2fBBsdwUdh7XKgW1va5?=
 =?us-ascii?Q?7yFEiqQgyyTwSz2Ja78/FTT33l3Z9sN7GyWYavPhtlEy2VSSGmANP1J1UlQ2?=
 =?us-ascii?Q?MOJFHIllHGv0iHZHz243tNONcQ7knTCmTre71xRKyqz8XeMjv5C8FIdxqlu7?=
 =?us-ascii?Q?1lviR4Cn4+xmqe3uOajyVq2bup7RSrSGjLeWFTJi+1RK4wd/cq0/GSgOWOES?=
 =?us-ascii?Q?Igtm9GDkVIKLv858MagC5W3Q4R10jXscFG80u6dvuS3dVFET6CVUcSwuIo8M?=
 =?us-ascii?Q?Zs0LABjLHO+ZV2zVbyEYgUSBf1J6lEG5Y3fgW0Uqu9fKBWKtQeCona5cPaEa?=
 =?us-ascii?Q?z9xg1kOACOdbeMfT9LfYVQ5F0kpRddJszhQdGoL9PGeXPIBX4sMhVeQ4YqzD?=
 =?us-ascii?Q?JcqF1z+hVAtUZ77mL7rsA4dYRcMXoA6sTpPb2newInqFGDdcPeET7RE4GlKr?=
 =?us-ascii?Q?gWb+2YNcgQd+LSYdYHgmuK3MYNVvZTKGk3C+m5n59kXutYsYyuz/mRyZ6anQ?=
 =?us-ascii?Q?LiEThWinKHGT345kDbDpvGztTrOpFyOEOZJnvCH9Y2rZvFzuT6K3LnTa2eo0?=
 =?us-ascii?Q?BlcnQ+ao1Qc=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:18:49.3502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76999614-5ef2-4676-3236-08dd607559ff
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9206

[Resending, as first message got HTML'ed by my mailer...]

Hi Nathan,


thanks for pushing this into the right direction.  Actually I didn't recognize that
lld complains about overlapping virtual address ranges, maybe the .config provided
by the first LKP report (which I used for testing) didn't enable the necessary options.


On Monday, 10 March 2025, 21:37:29 CET, Nathan Chancellor wrote:
> On Wed, Mar 05, 2025 at 02:49:38AM +0800, kernel test robot wrote:
> > Hi Christian,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on soc/for-next]
> > [also build test ERROR on linus/master v6.14-rc5 next-20250304]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Eggers/ARM-avoid-that-vectors-are-removed-during-linker-garbage-collection/20250224-210146
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> > patch link:    https://lore.kernel.org/r/20250224125414.2184-1-ceggers%40arri.de
> > patch subject: [PATCH v2 1/2] ARM: substitute OVERLAY description in linker script
> > config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20250305/202503050230.820w99b6-lkp@intel.com/config)
> > compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503050230.820w99b6-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503050230.820w99b6-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> ld.lld: error: section .vectors.bhb.bpiall virtual address range overlaps with .vectors.bhb.loop8
> >    >>> .vectors.bhb.bpiall range is [0xFFFF0000, 0xFFFF001F]
> >    >>> .vectors.bhb.loop8 range is [0xFFFF0000, 0xFFFF001F]
> > --
> > >> ld.lld: error: section .vectors.bhb.loop8 virtual address range overlaps with .vectors
> >    >>> .vectors.bhb.loop8 range is [0xFFFF0000, 0xFFFF001F]
> >    >>> .vectors range is [0xFFFF0000, 0xFFFF001F]
> 
> Looking at ld.lld's code, this error is intentionally ignored for
> OVERLAY:
> 
> https://github.com/llvm/llvm-project/blob/9f170e6abed4a7b393bb8abbf07ac8d6930aa3b0/lld/ELF/Writer.cpp#L2751-L2761
> 
> I have submitted a patch that allows KEEP within OVERLAY to match GNU
> ld:
> 
> https://github.com/llvm/llvm-project/pull/130661
> 
> Once/if that is accepted, we should go back to your v1 with something
> like the following diff on top to keep things working for all linkers. I
> hope that it won't take long for the ld.lld change to get reviewed and
> landed but if this needs to be fixed urgently, this whole diff minus
> '|| LLD_VERSION >= 210000' on the init/Kconfig change should work (with
> a comment change). I can always send a follow up change to add it back.


I build from an internal tree, so I am not in hurry.  As the Kconfig changes
probably should take your Signed-Off-By, I am also fine if you do the necessary
changes on my v1 and resubmit it together with your patch when it is time.


> 
> Cheers,
> Nathan
> 


regards,
Christian


> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 835b5f100e92..f3f6b7a33b79 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -121,7 +121,7 @@ config ARM
>      select HAVE_KERNEL_XZ
>      select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>      select HAVE_KRETPROBES if HAVE_KPROBES
> -    select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD)
> +    select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_CAN_USE_KEEP_IN_OVERLAY)
>      select HAVE_MOD_ARCH_SPECIFIC
>      select HAVE_NMI
>      select HAVE_OPTPROBES if !THUMB2_KERNEL
> diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
> index f2ff79f740ab..14811b4f48ec 100644
> --- a/arch/arm/include/asm/vmlinux.lds.h
> +++ b/arch/arm/include/asm/vmlinux.lds.h
> @@ -34,6 +34,12 @@
>  #define NOCROSSREFS
>  #endif
>  
> +#ifdef CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY
> +#define OVERLAY_KEEP(x)        KEEP(x)
> +#else
> +#define OVERLAY_KEEP(x)        x
> +#endif
> +
>  /* Set start/end symbol names to the LMA for the section */
>  #define ARM_LMA(sym, section)                        \
>      sym##_start = LOADADDR(section);                \
> @@ -125,13 +131,13 @@
>      __vectors_lma = .;                        \
>      OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {        \
>          .vectors {                        \
> -            KEEP(*(.vectors))                \
> +            OVERLAY_KEEP(*(.vectors))            \
>          }                            \
>          .vectors.bhb.loop8 {                    \
> -            KEEP(*(.vectors.bhb.loop8))            \
> +            OVERLAY_KEEP(*(.vectors.bhb.loop8))        \
>          }                            \
>          .vectors.bhb.bpiall {                    \
> -            KEEP(*(.vectors.bhb.bpiall))            \
> +            OVERLAY_KEEP(*(.vectors.bhb.bpiall))        \
>          }                            \
>      }                                \
>      ARM_LMA(__vectors, .vectors);                    \
> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..fc994f5cd5db 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -129,6 +129,11 @@ config CC_HAS_COUNTED_BY
>      # https://github.com/llvm/llvm-project/pull/112636
>      depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
>  
> +config LD_CAN_USE_KEEP_IN_OVERLAY
> +    # ld.lld prior to 21.0.0 did not support KEEP within an overlay description
> +    # https://github.com/llvm/llvm-project/pull/130661
> +    def_bool LD_IS_BFD || LLD_VERSION >= 210000
> +
>  config RUSTC_HAS_COERCE_POINTEE
>      def_bool RUSTC_VERSION >= 108400
>  
> 






