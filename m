Return-Path: <linux-kernel+bounces-522863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB5A3CF59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E8718973D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3131D54C2;
	Thu, 20 Feb 2025 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C3Zyuu1E"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B91CDA0B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018499; cv=fail; b=My8VYzNgsX7fF1owABMhc6HJ3Om3F67XEBT4KQ1tD3BPskqUF4MDVhdOKqGKAi2iDqICEtIlDcGKWMUpQYUciHPuYupV6uwRw5RJ+OhQB57jstD5Z+my4zKjz6+B8jv2STF9LD8Y8FSuUSu+5wYjeJM1LhnIOFvO3RVg036biFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018499; c=relaxed/simple;
	bh=6tGSQZVXHJAYboi+Hg3Mr9ACuH7XZ5ZkuM6YDTV6zuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOzbWNxh4bdo6VGYZxcCua7BFKPAIiY2J7AitoVUHPzW706hwPSV9zZoYq1GOrdeMBDKUVaOm7A9ygx+nJhKihuprj9Y5kDaJ+QVoMsXWBYYdXsnZKq5YQujYTEiVRUnQbO51+jbtppaU4bLIq/HgqKdIdp9vwqtb525xeYy0iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C3Zyuu1E; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rrn7LltVJTEkJeDB4Fgm0eEvPTD7L/sefd7FQ9J2R2K4RegFf3NhTBEnjoZCyOarY6hTqVgvfsdgjC9ycWJF3h326rdATrgKphcslbt07dk7D0aKFhseKvysr/8a253eFMGkjGQTWVVfc9I3SEQ9bA/TLkhQpkWyo8cTbmpaDpgqhC94pbWX/ZXqjONySFbVRNy34btLpFK7YAdn47l8onQPgcF4w5Yw6ybuTOk4n8k7uyegmnlV2eNtpDLt+sq5SDOXnwVTEDWuWd6MCkLm4Ob3+FYvuOt90r8e+HtI3N7Cj79sCXhO0Qy+p0328X/vgYL87KZ18xRK9ogiIZyD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J+ACsJxusHPqsT2+IFsZTggg4psydIQWoZ0Dl19M+M=;
 b=hbgnoY9l6uMGsuEqMC8FxM1/JRbGAXPWz5Ru4Ca7JhEV20YmBOFUfzJMO1pLuvmm9ibiBfmNMvduRB3eys0mpWogIwx1gJLrtNuXRDVsH8YS+tzuB13wsu/atKVKRZZ8e1vudbm8/OrM+Z+Jggxi85D78S2Ou3qgROY/U3qbRr+gsx5SbT2cvL5HX7bj+EKCMySa1NevqPWZRMyCAWkk/JfbbAAbFtMNhBq3JvKDddMfIuGMYcD7R3p7nngVTbo+93+zeGLVjMDlhcYtF6t8TtMReHyLf6wwbdFl3DhhITDdi2n9gIyrd6fUYAI5jf/418i1EHwktjPzggK01ITeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J+ACsJxusHPqsT2+IFsZTggg4psydIQWoZ0Dl19M+M=;
 b=C3Zyuu1EI/+og0r0h/hs+DfyekGhw7TbCP/QaE5CXEsNXA6Xa+m2UxPv+cZ7yqJtjS3MATC8yT7KF2jl+lgMrbu8d/oSXv8MCzzlOJFaZXI94PNyPjc7eBOVPsUdsfc1Kewh0tMhK9EHXipIM8J4KcOxIVaNSRG0127yHHgHbwE=
Received: from BL1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:256::12)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 02:28:12 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::d4) by BL1PR13CA0007.outlook.office365.com
 (2603:10b6:208:256::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 02:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 02:28:11 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 20:27:49 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <kirill.shutemov@linux.intel.com>
CC: <akpm@linux-foundation.org>, <bhe@redhat.com>, <dave.hansen@intel.com>,
	<ebiederm@xmission.com>, <kexec@lists.infradead.org>, <kirill@shutemov.name>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <security@kernel.org>, <x86@kernel.org>,
	<yan.y.zhao@intel.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination addresses
Date: Thu, 20 Feb 2025 02:27:29 +0000
Message-ID: <20250220022729.5722-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
References: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c96fdc9-ac9b-46a0-a1b5-08dd5156386e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1vXyG/RTSRQmF/YXKUemX+39+c044KxrTOfpfLjYJnhsypYbru8zz9y9JjSR?=
 =?us-ascii?Q?R1OzAoSbfxRD9+YjkpuYld21mpTHOpofco64L2cqXkmRengsLY7oIh/hEyOS?=
 =?us-ascii?Q?Evgc9EQPZVCN8qM6zH4W9JCpkestfc3N/FKYFh7qSO5mjv2f8yPryhqB4RzN?=
 =?us-ascii?Q?RU1/bOoBt5CeKQKrXSyYYTCHj2qJY10GfPS7UEywbzqrpe8zudN4Oq29217U?=
 =?us-ascii?Q?p/Fr433T9cZ8T4VDaCnfFiawxeSuJbzE0d20YbQ/24BC5fXnSsa1WlvF2180?=
 =?us-ascii?Q?G/Tr/t2MP4mN7fwGt/2VuWOlR65vzqpWmP+5I/HYZ4AMSTmwKS4axA8HYjLP?=
 =?us-ascii?Q?iR21UscAZuhW17j0EcCcOUhiDR6B9qGtQ7T09H4z++eCmll1ECBZXQUCyXbU?=
 =?us-ascii?Q?2v518sw6GaktPbcGB0PrNgOjFcRK1kwUbWkfm/pFYoI7RyGXcenP5WhptX66?=
 =?us-ascii?Q?xMwI/BbYmzbdEQRxQLf0mxCBiM7EoH5IWtIJ+SI6fQE96140m2h8RE2+hxgp?=
 =?us-ascii?Q?KRMrAfFlcGfLgM1it7vNo0fyZdNT4rXmTggwvWokJ/Mz/EsHLNPOm1z+kTBa?=
 =?us-ascii?Q?MCD6RzMY+l1ctkuaxp1uVy5KSpyW0a0uu2eE4hx+xe2Cgg45zM9tvKNv/o2u?=
 =?us-ascii?Q?cyxwqxsck1s3lVI9ayVdVmq0Bs5kW74R1ju1uQoKPGN8Kmjee0SM6lny9NPc?=
 =?us-ascii?Q?VO1FwXKIRSemyd7QKhiTLF+iFwxsdta5reqP55XYOt7pOQMjLuOPfgG7iAUy?=
 =?us-ascii?Q?1TqmJRwf4LYS2koIxWgaDcZVRzbdF3Ca3ZcDikBlhwysaEIotwRPgjrkT+av?=
 =?us-ascii?Q?h/darqIi29UK2k3ef7ANmJOktzKwRaumYHJTRHMmDdkC9krPzKiBjE+CmmXk?=
 =?us-ascii?Q?QUZBjXGejTJYbea2Vs/O59xXw6F28opNrprg6U38eULIA0vUC9s4KQo+G/y6?=
 =?us-ascii?Q?kOcfEHJWZmAZjyNto1+oz7EOg1EbvYz3xajpZSPZ9BWC95jsPsFoEm0Gps6Q?=
 =?us-ascii?Q?golObDVYUQX+1AGOEsM5g6Cpkav3FU60A4JGpWnZcTQs7Hayjc/+bIZ/IvRq?=
 =?us-ascii?Q?1evTRjtKzIfPWv+OjyoxmOcmSOViRVIE+cpYo1jiY3xjsGdv9TwcdK27+kK0?=
 =?us-ascii?Q?TcaVQa3d5JE6WIcTRHj9HTNWZ3BOBsyMxNJbaHeb+zFvM5cANtLC6t1sYZJo?=
 =?us-ascii?Q?Ifp8ECflTXvbHYVDrMBY9Z1HFagwJJrkTw5YRvdbRb0NAEEdC8QiICM+lsVw?=
 =?us-ascii?Q?ZD0Px4EoMiD5tU3EO5SYD8MovneGVAzYITzdos941Wg1BIC+uc+W/wWY1K7q?=
 =?us-ascii?Q?uWX5jKh1B3vBFzFPx/dlikPJwD5bKTPbcCusYZzV2Shlpk3WlMczkj/YSMYH?=
 =?us-ascii?Q?LCyzPjrsrqllftH3AXsSSG5EqRa9LdgItglap3sgs0aS/mRCbV9CNyfgtNqD?=
 =?us-ascii?Q?3Gplmx8a0RIDooNHxiWU6UlQsa9pAW84?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 02:28:11.1977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c96fdc9-ac9b-46a0-a1b5-08dd5156386e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619

> On Thu, Feb 13, 2025 at 07:55:15AM -0800, Dave Hansen wrote:
>> On 1/13/25 06:59, Eric W. Biederman wrote:
>> ...
>> > I have a new objection.  I believe ``unaccepted memory'' and especially
>> > lazily initialized ``unaccepted memory'' is an information leak that
>> > could defeat the purpose of encrypted memory.  For that reason I have
>> > Cc'd the security list.  I don't know who to CC to get expertise on this
>> > issue, and the security list folks should.
>> > 
>> > Unless I am misunderstanding things the big idea with encrypted
>> > memory is that the hypervisor won't be able to figure out what you
>> > are doing, because it can't read your memory.
>> 
>> At a super high level, you are right. Accepting memory tells the
>> hypervisor that the guest is _allocating_ memory. It even tells the host
>> what the guest physical address of the memory is. But that's far below
>> the standard we've usually exercised in the kernel for rejecting on
>> security concerns.
>> 
>> Did anyone on the security list raise any issues here? I've asked them
>> about a few things in the past and usually I've thought that no news is
>> good news.
>> 
>> > My concern is that by making the ``acceptance'' of memory lazy, that
>> > there is a fairly strong indication of the function of different parts
>> > of memory.  I expect that signal is strong enough to defeat whatever
>> > elements of memory address randomization that we implement in the
>> > kernel.
>> 
>> In the end, the information that the hypervisor gets is that the guest
>> allocated _some_ page within a 4MB physical region and the time. It gets
>> that signal once per boot for each region. It will mostly see a pattern
>> of acceptance going top-down from high to low physical addresses.
>> 
>> The hypervisor never learns anything about KASLR. The fact that the
>> physical allocation patterns are predictable (with or without memory
>> acceptance) is one of the reasons KASLR is in place.
>> 
>> I don't think memory acceptance has any real impact on "memory address
>> randomization". This is especially true because it's a once-per-boot
>> signal, not a continuous thing that can be leveraged. 4MB is also
>> awfully coarse.
>> 
>> > So not only does it appear to me that implementation of ``accepting''
>> > memory has a stupidly slow implementation, somewhat enshrined by a bad
>> > page at a time ACPI standard, but it appears to me that lazily
>> > ``accepting'' that memory probably defeats the purpose of having
>> > encrypted memory.
>> 
>> Memory acceptance is pitifully slow. But it's slow because it
>> fundamentally requires getting guest memory into a known state before
>> guest use. You either have slow memory acceptance as a thing or you have
>> slow guest boot.
>> 
>> Are there any other CoCo systems that don't have to zero memory like TDX
>> does? On the x86 side, we have SGX the various flavors of SEV. They all,
>> as far as I know, require some kind of slow "conversion" process when
>> pages change security domains.
>>
>> > I think the actual solution is to remove all code except for the
>> > "accept_memory=eager" code paths.  AKA delete the "accept_memory=lazy"
>> > code.  At that point there are no more changes that need to be made to
>> > kexec.
>> 
>> That was my first instinct too: lazy acceptance is too complicated to
>> live and must die.
>> 
>> It sounds like you're advocating for the "slow guest boot" option.
>> Kirill, can you remind us how fast a guest boots to the shell for
>> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
>> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.

>I only have 128GB machine readily available and posted some number on
>other thread[1]:

>  On single vCPU it takes about a minute to accept 90GiB of memory.

>  It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
>  it doesn't scale past that in my setup.

>I've mentioned it before in other thread:

>[1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm

We essentially rely on lazy acceptance support for reducing SNP guest boot time.

Here are some performance numbers for SNP guests which i have here after discussing with
Michael Roth (who is also CCed here): 

Just did quick boot of a 128GB SNP guest with accept_memory=lazy guest kernel parameter
and that took 22s to boot, and with accept_memory=eager it takes 3 minutes and 47s, so it 
is a remarkable difference.

Thanks,
Ashish

>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov

