Return-Path: <linux-kernel+bounces-370408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F79A2BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6599D1F213BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA61E2823;
	Thu, 17 Oct 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L0uYyARW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA31DE8B4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189013; cv=fail; b=VSeb6r6ZfpAF7vqdSeQfGNiGCOCLR2kG0ZLnncCtBIuodDPnt0rJ6goa3vfCFX47QC2lylNQl3H3+ilwcjQXzTUPELsoqyGBkAO3KcccrGzj2/6+aPyj3iVXwd2eGzEdrLkAKay2miAcZfZxoLboYYUr5vJ9+ivZMxxumR2ff70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189013; c=relaxed/simple;
	bh=0kfTCq9YhIY3JpWvUlZxnIZgzEQhCXxwkCXVJshzIbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q83VF6wcAbL+hEOZP+mLkmIH0WY+372SEGv3oGyVDcfnV+lhjkhfO6fo/Sfv+vYJSdTUOqYg7TT7+cOek7Be13I95aZs8RRy6pL6A9m15qSyOofXzkE1CcHKghXVVFUrGhVL0MhA2LkdBo2yulMIgeKcBBXwOTvP2Vk+qkObgjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L0uYyARW; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehWrDv+EAHxMfFs53FsBRtWJvEtwpguc8LNmJhkTOagiF7N8TJy0ycSsxRw30qTfhYAQbjQub0zYAawLD+a50FCc3Ikprkf8+BnPC3La8xd0+oeirKahORfuWJyUY+NHOmByg8TyhcA8qOzpLkWj6aZ+uY4xvO9Dgr69rqRJCKvKepobLrkOmLtUocK76fVnIkOvo5vD5HMtFBZtSujA1KbR8hXXL5cWCOKzwO9qFPxI3o0Mh6fjvc3txFBsMyZLWctQeroZ8NvTg8ci4Ysbywal7wOZ8GEZ1EUcOTvVSLi6n7nYb/Sk5G7lSSdPOuL29+bs1cb3eUxHdgG2NNGiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UDL4Bw926rB5Dj4N1GdlBbp6sAr+II87CAyVaOGE6s=;
 b=SyDmtm64CHuUJROfSG/EB/X+yqiF2/Tq7QsxXB476CntZRLn4FelWHUpuuRSYe5ny5gRjn171D1d0DyTP4BuOHHAGngygHfDPW9e5Hu9INavkL85/tYkTgFVbjvF67QJr87/y7wfnfnVuQYo6oRENyyUPeUwTVMuDRGgbblMhY2Q6gwl15UcPTL9fnfyZbWLMiZOTfrLWN/263A7VaVgzVylMWP4ziRB5qcBqUqKbG2yEj3AP+TFUKO/AR3NZXiYBBOmBVhPG/UteqPvUgGKVWkpkGAlEjqK1zLxSk4QzENY9V/6oSpMF3UQ/PJUjSrgmTNdhkACmk3ahUVHRM3EcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UDL4Bw926rB5Dj4N1GdlBbp6sAr+II87CAyVaOGE6s=;
 b=L0uYyARWZx138naPzvmPs4Fo8nSawtniAVN8mBJI6d0AAuLl0eFAEOGjuqe+w6kxpjMMpDUHs2r2BEGka/JuFJiv10tie8NLXGgsgVcv1XoDFY7WlGVre/wHHZwNS+ni0q8MFe5hItY6/B1CltCZ7IRYC45DX9vGra27nIr2qJM=
Received: from BN8PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:94::29)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 18:16:44 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::c5) by BN8PR03CA0016.outlook.office365.com
 (2603:10b6:408:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 18:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 18:16:42 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 13:16:42 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Michael Roth <michael.roth@amd.com>, "Ashish
 Kalra" <ashish.kalra@amd.com>
Subject: Re: [PATCH v2 1/7] x86/sev: Prepare for using the RMPREAD instruction to access the RMP
Date: Thu, 17 Oct 2024 13:16:36 -0500
Message-ID: <20241017181636.2878844-1-thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240904104728.GBZtg6wIgihDlsIgIS@fat_crate.local>
References: <20240904104728.GBZtg6wIgihDlsIgIS@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e664753-71a0-4638-c60a-08dceed7da79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tr9zbbuzWsUCR+40cIzzPgEQcSbJLi2MLEON6Za/sL8knwxtuoYr29VAtD1F?=
 =?us-ascii?Q?txsZhQXiyUJnU3p+kGgYFV9IAAshGQyxM2e5NtPWAXFon469Cso9s7akMqY9?=
 =?us-ascii?Q?XF40W+jFMRAT7M3bweq8PBXMqcQAAuAy8MhJAlj/7gHwx99tgB4MoOvJI0g7?=
 =?us-ascii?Q?KEKXYZt+75B4rlin7KeGPJeVhms3LobU0Qzm8/3wD9x766vJuxC9xJLchjTl?=
 =?us-ascii?Q?MbzzPt++sDCdcsI9MiQI4V8jyd82PrvY0ARUPTOuxtfpGRXS0vJ8Wp8ZQXhL?=
 =?us-ascii?Q?U2CP13fRb2bnF8fS2M04/koNgO0wSVoV1pAlTy0EQ5KjPTaNZXjz1D9UU1Ep?=
 =?us-ascii?Q?yVvj5RWPY2IwYgvk7htxONqCen6ZR0ZOJjDBfxP4NlhJkV3fyGDMXcuDFZBd?=
 =?us-ascii?Q?Pe2x2rUOb+N5OsLOGL9VQsYpnS5EFjNIM/2s7spwPBW8evOeQNgJY1nJMfkt?=
 =?us-ascii?Q?bCdP9mYVP4rFrnGQSD8RMGylAwhXlwubjVguiyn+GJg+viJkeFeCRW3eShhY?=
 =?us-ascii?Q?XI98HqW5bwLG67/VECk915bRQ9olmpZupk0USrUn9sYlnr80ys5oogEOH5h7?=
 =?us-ascii?Q?lQX2TTp6PJxRe6na7lNcDvCtDHHHC4FBMABbANx4f2twkhd1vdb2bAjnfiXS?=
 =?us-ascii?Q?51R7SkB00ebTY4vafkLOMKp9oslAvhxyqOuDdVH+4yUsoxn4GzM/vlxf3VOY?=
 =?us-ascii?Q?SdMdhhzEk0L8JGPC0TRXyDGKCAyi9iHIiFg9mT6oUjloY7FCzAsA7kbAP1ev?=
 =?us-ascii?Q?6nS4iDbdP5l49S4c3fj1jtvd9IvxhGxPXMt66JnKzk6GeEJj29ALn8f0//ml?=
 =?us-ascii?Q?Is2dERK3Vb1a97pG+v9j4QoCmiEBCkpu/KAxOhdkUKrjymfuX/b4/+UlTUZ4?=
 =?us-ascii?Q?rZN5u6VuzynEl3to0VWhacttAVbgpdw6jw66VgtqhQHLCXs8+YRFu2bgxu2f?=
 =?us-ascii?Q?8NvA8PttMnmG58xyfO0InsAwROKnvNROht0DdADoTlJge8msUQLnIjG49BJe?=
 =?us-ascii?Q?iC4NFJ81drkQuAWg0AS3dmZtkUu+XUxZMfrWXJDWg2YIX2/LW0PTJdBPM/td?=
 =?us-ascii?Q?cH5fnz7I4sd+SicpExvPukjVx79/tBCNglWGvpbkEDywNiyFmmY8wdm12b/n?=
 =?us-ascii?Q?CTC1X2TmJMBKHfR3jO5JUVaL9jqejmD6FaF5Wm1pXbYAVB6uhAymVVaFtwY6?=
 =?us-ascii?Q?qRiOInEf1hEz/xq736z+GSYzeCHHn/JQWWem5hOiuvzvXa9ZKuojA/FJT1S7?=
 =?us-ascii?Q?hlNwCCe3xnqfOmwx6Xs5LdfL1DeKO9XaiGavEouhBizlv5y5b9O9m8Pslza5?=
 =?us-ascii?Q?JzNAYGKu9fSL9ZlbjKhAkZFZRqbQW9lAe3OuDuLXra6cPalDaBgx7PLc1yfZ?=
 =?us-ascii?Q?i9d7t2ro7ZcfBbdWTm/QphnOhaKs0Ym4dzjYk+coAED+xBicXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:16:42.9779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e664753-71a0-4638-c60a-08dceed7da79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350

> On Wed, 4 Sep 2024 12:47:28 +0200, Borislav Petkov wrote:

Sorry, this email seemed to get lost in our email quarantine. Trying to
reply using copy/paste and git send-email...

> > On Tue, Jul 30, 2024 at 02:40:01PM -0500, Tom Lendacky wrote:
> > The RMPREAD instruction returns an architecture defined format of an
> > RMP entry. This is the preferred method for examining RMP entries.
> > 
> > In preparation for using the RMPREAD instruction, convert the existing
> > code that directly accesses the RMP to map the raw RMP information into
> > the architecture defined format.
> > 
> > RMPREAD output returns a status bit for the 2MB region status. If the
> > input page address is 2MB aligned and any other pages within the 2MB
> > region are assigned, then 2MB region status will be set to 1. Otherwise,
> > the 2MB region status will be set to 0. For systems that do not support
> > RMPREAD, calculating this value would require looping over all of the RMP
> > table entries within that range until one is found with the assigned bit
> > set. Since this bit is not defined in the current format, and so not used
> > today, do not incur the overhead associated with calculating it.
> > 
> > Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> > ---
> >  arch/x86/virt/svm/sev.c | 141 ++++++++++++++++++++++++++++------------
> >  1 file changed, 98 insertions(+), 43 deletions(-)
> > 
> > diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> > index 0ce17766c0e5..103a2dd6e81d 100644
> > --- a/arch/x86/virt/svm/sev.c
> > +++ b/arch/x86/virt/svm/sev.c
> > @@ -30,11 +30,27 @@
> >  #include <asm/cmdline.h>
> >  #include <asm/iommu.h>
> >  
> > +/*
> > + * The RMP entry format as returned by the RMPREAD instruction.
> 
> I'm guessing this is the architectural variant...

Yes, this is the format returned by RMPREAD.

> 
> > + */
> > +struct rmpentry {
> > +	u64 gpa;
> > +	u8  assigned		:1,
> > +	    rsvd1		:7;
> > +	u8  pagesize		:1,
> > +	    hpage_region_status	:1,
> > +	    rsvd2		:6;
> > +	u8  immutable		:1,
> > +	    rsvd3		:7;
> > +	u8  rsvd4;
> > +	u32 asid;
> > +} __packed;
> > +
> >  /*
> >   * The RMP entry format is not architectural. The format is defined in PPR
> >   * Family 19h Model 01h, Rev B1 processor.
> 
> ... considering this thing?
> 
> >   */
> > -struct rmpentry {
> > +struct rmpentry_raw {
> 
> "raw"? Hm.
> 
> So what is the goal here?
> 
> Use rmpentry_raw for the kernel's representation and convert the format that
> gets returned by RMPREAD into rmpentry_raw?

No, just the opposite. Take the current systems that don't have RMPREAD support
and transform the "raw" RMP entry data obtained directly from the RMP table
into the architectural variant. This way, only the architectural variant is
used going forward.

> 
> Because if so, the _raw thing is what comes from RMPREAD.
> 
> Because as it is now, it is begging to confuse people.
> 
> Because if you call the *new* entry differently, it won't cause any of the
> churn you have to do below...

I can look at naming the new struct "rmpread" and see how that looks if you
prefer.

Thanks,
Tom

> 
> Hmmm?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 

