Return-Path: <linux-kernel+bounces-268568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DCC942652
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34180B22C49
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683E16A382;
	Wed, 31 Jul 2024 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UkXu8WpD"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04206EB64
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406621; cv=fail; b=FVudekxuWlOzKYn1/wLXK1nAJIisJhJ1Jc9EoKCTHMHp1zUaqDcDDFRYwrHsk30yfFaPVaHTz62ozUfLgX6fgZm4GhoVucsh0PLMrgmyVY7AEx+cv89+mZmaXwjjTQrmf2kp/pgVcCwRdwuoWXP/Bsa+o3UY0rsqNqBQDXcqeWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406621; c=relaxed/simple;
	bh=lnDm80jX706KMW6QFUJnNDiam/q0+hHTBfYP0ZkNe3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ro3Mg2b5hcZfN/w6HqWZbH2aMDvhwkj1RXz1d4EYlhTP1OloXxxnXsDApWXppkojMPMZlLXDSOQt/e1dP4NTJTeqsJzbKhJzQdhFM8Vnc1oCnLko2Mhv46X9eVQ0dqZjoFhkGjNV0FSp+lI0robRGfg5DtPxgglFjmBY7ip803c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UkXu8WpD; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga0vv83Rnu3M3pLvK/JMJj3RVJl6lXW8RFXk/tm/v2RhrbE5Z3leWXqufBHzZKtW7eREA5GhpG6r206nqIsssEFd9F7KLqHzJdT0r6KU5S3wohEp+9NucMLFfPMZdVXYclTwQ3s2YaUMv5C1UcTMYke43Vm0FRBrCXfZt0mcmQuKpewCjxnQ7BOMk5dJevMe5TSHo5x+TgJsFJCF4vP7cakWCAWORSN+8Tmaav4Jz8cQztkZs49//orEqVv3gSr2tubG2QHmQm6u49Mce9rgFcuqSr2r3kJ4LziEG/paEulzanOcr3OZ7XJaQxHd1UrmO4w/+hfKF/rPdXx5Cwn3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrnK4qxzACPO0PBdvxNSIIY34Byg6/l3SbP+x/MVcB8=;
 b=jF3SvBh0UCqW1+CJ6h7UuLKEzWuOLWp3ihdpfIRi1tSMFLlZFoa1MIoD8LE1DDF2cGQykoQ9porFjajRhkBLi6ZVz/oXF5jTIjBLyN8SdPKQ2rBxoBVjGYzcS40L5gM0DHiloDzcRZAPNbxVoUDPkFgRw7EcaRiY9o3ERCL6rTQVbH3+uXRT/fjGiZOAdlx1RuUVL/Tsp9cdrKwaG1W0u859YnXMpVf5V3xnO4LvlwfQgeToDCOuiMonF7vszS3Q+K50U/O0Q1+GAp5CDPxroookQGU6auqgKHwotKYafyRBR6HhTMofUFV3YdN2yNP0LQ2c+m5tcDQ5m4j6ZVQyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrnK4qxzACPO0PBdvxNSIIY34Byg6/l3SbP+x/MVcB8=;
 b=UkXu8WpDSHPEl8QlPuFFb+35B7139cpM073mzoqxGnr2a5IFgOvI2BIW+X8nc8ofO3DZB/OCFC9/+1Rssk+Xv73MCDffPUciJT6oGlSjUiY6ZVf/HLLhQ/5dd8xiNY7lj5O04uqGQAPTyiZ7WwJWZaoKk8naI1GnQ2wPadpOY6Y=
Received: from BYAPR08CA0044.namprd08.prod.outlook.com (2603:10b6:a03:117::21)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 06:16:56 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::7a) by BYAPR08CA0044.outlook.office365.com
 (2603:10b6:a03:117::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Wed, 31 Jul 2024 06:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 06:16:54 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 01:16:51 -0500
Message-ID: <5e3b9b29-8d17-6a04-f2a5-1748a52d1a6a@amd.com>
Date: Wed, 31 Jul 2024 11:46:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [peterz-queue:sched/prep] [sched/fair] 124c8f4374:
 WARNING:at_kernel/sched/sched.h:#update_load_avg
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, kernel test robot
	<oliver.sang@intel.com>
References: <202407291328.761441a7-oliver.sang@intel.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <202407291328.761441a7-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 6074beb0-c862-4f9d-a875-08dcb1286029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVdTYjZJeWgvSFFkY3ZyQlNpM2VLRFQzT2UzMkJ0cHdWREdDVXVZQldHdjRl?=
 =?utf-8?B?bkFKeVBURDBpM2lEQjBvck5uNlBhclYvaytYcjcyQlIzK3V6WmJvZ3YvMkRX?=
 =?utf-8?B?WUJPN081clRrakZJdzRBbjZaOWVrYzA3SjRkd3kwQVZYZlBMcWdaSWt0M1hu?=
 =?utf-8?B?WjVsNTJtcVgyOWJnTmN0Tk96OTJKWjc1MUY5NUpGdDRBS3VLZVF5V0oybkwx?=
 =?utf-8?B?bFE3SmE5N2NxUU9Dbm9JK0tNS09BZitYazBlRFdxSUZVNmFreUpsRGF5OTNH?=
 =?utf-8?B?RU1jQUpNRmVZeHY4NEl0RXI5YzlJbHlyM0xMUFRpNnNkQjh6ekxiZ3Z5Yzcy?=
 =?utf-8?B?bEpaeTNHUmJSa0pNWlVnWGNudlFCeml4bVNmLzRoQnJ3OXdPL2pFRTh3TlZi?=
 =?utf-8?B?Q212UnA1TmpZL3dpL09RTzJUWDRLamJPMVFWbVZ0czc3MXB5UWNBUTFhaGZZ?=
 =?utf-8?B?ajBVRUxkU1BVTVdHUndzdW00QUZ6NXJObG9BVTM1Zk9GMlF2aHpXYXpoc3dC?=
 =?utf-8?B?S29peDVSNWY5K1l3M1pZUURuaEVGeEIrbjVFNmZQSjV2MEo5elBUeFFjV1dI?=
 =?utf-8?B?REgyL2VqcGp0eGpSYVRXMG1PbmY0Zm9CSnhMalIrMmRhR0hESnNPRjVHWWNu?=
 =?utf-8?B?Tk56QitqYk5mY3BGNnhwNE8xejdNOWNWLzNLOVVaQmt1ZUl0emgzSzhZQy9C?=
 =?utf-8?B?bDI5eDN6eHNYM3lhVmg1ZkVCZk9uYjdObWU5cG0xRURhdmh0RFdGK3VzWWdl?=
 =?utf-8?B?Y0ZEYWlycnlnMWRxNm9aZi9WT3o3K0hUUzFCTnN3SWt3ODFkblZUeFNJOVQ2?=
 =?utf-8?B?dGpVbXk3OUgvMGRQeEh3T3dDelpRVTlMN2ZxaTR1RW5YU2loUEJ6dWhpcjhk?=
 =?utf-8?B?ME1ycUpTUURvbGlxM25keTA2eHM4dEFkc0hybkY1a2IyUDhwNzM5NHZKMWFj?=
 =?utf-8?B?N2xCTVFQbzc4RzRvQkRvQUZJOGphWk04ZHVsTjJuaW9EcXRZK2VxUkttRTZR?=
 =?utf-8?B?T0xmU2gyRmdBRHFmMW9nQUl2Q2ZTYnpkOU1QMEtOdlVPWFRMa2JKMW5xeHc5?=
 =?utf-8?B?NTNQaXpxcEZjQ2FhL2JLMk9EZkc1d3JnSFBPeHNuYTgzSGkrZ1RTeWt4cktF?=
 =?utf-8?B?K0RLUEJSSENlVjlVczVNNkF2QTZ0d3d1WnJyQXJxTU1IL1BRdy9Qa2NDUVZu?=
 =?utf-8?B?eFVVci9CbUtvaU5NWVZ1bWdnNHhMSUl4NmxRMVV5N2VoeFJEQWJZVlhwWTdu?=
 =?utf-8?B?WnozQjN2R09tR3BBWkpzK3hmWlZpekd1QmU4NHZJL3cvL1NtaHNKdjZ6aDI3?=
 =?utf-8?B?T01lb0JrQkF1WEhBMlhWNzVpM1pZRjJKYmVXa1F2S3FoREtUcWFHRUo4bHlr?=
 =?utf-8?B?RkFwb2FieURGY3hDRmRLTDFxNDNadEdEY0pSbExWQ3dMSlhEMUZWS1JuRGJJ?=
 =?utf-8?B?MlRjYkpCdzFVeDlaTzdyT1VKNUpISEZ4b00zU3N4WEdkY1hlZ2QzTDdYNUxP?=
 =?utf-8?B?Y2ZHaWtjeTNmclpWaHB3VWhkQXV2LzVMQzd3ME5EU04xNnNoNGNEOG43eHBo?=
 =?utf-8?B?ejBnV0l5ZmtPQjhoQzZ0ZnhXQUpUb1JlVzgzdXpkeURRWU9ZZFVZZmRqOWJU?=
 =?utf-8?B?Uy8xOXU4eUx5Qkw5aStGVHJlQlREWUdMbzBzMXFYekFGV0prbFlFZ2ZZSUwx?=
 =?utf-8?B?T3gvSWJ3STg1OEhrWVl2aTVWeXpRektaaStJZXBBOG5wNWVQQTdONUQvVlpk?=
 =?utf-8?B?ckJ2Z01saFRHM2N1cVNFTm1zQ2U3VVFvYWxGZ2duU01nMWVTbGNlMHFmeGp2?=
 =?utf-8?B?TFIzUDNOY3BTaWNXcjRwdFpCUkg0OUFyb2s2YTlHWVhlL0FWVEJjcWxsQlMv?=
 =?utf-8?B?QngyRXhnalRwNHVtZFpRbDFnY3JHK1F0NlM1dWw0Z3o0VEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:16:54.8356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6074beb0-c862-4f9d-a875-08dcb1286029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206

Hello Peter, Oliver,

P.S. I see that peterz-queue has been updated recently so I'm not sure
if these observations still hold but if they do ...

On 7/29/2024 11:44 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/sched/sched.h:#update_load_avg" on:
> 
> commit: 124c8f43740f3f1e3e2aeecd976bcf5ddd7bd435 ("sched/fair: Implement delayed dequeue")
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/prep
> 
> in testcase: boot
> 
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> we noticed the issue does not always happen, 60 times out of 150 runs as below.
> but the parent keeps clean.
> 
> a1133ac6dc7c6bde 124c8f43740f3f1e3e2aeecd976
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>             :150         40%          60:150   dmesg.WARNING:at_kernel/sched/sched.h:#update_load_avg
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407291328.761441a7-oliver.sang@intel.com
> 
> 
> [   13.522527][    C0] ------------[ cut here ]------------
> [   13.523046][    C0] rq->clock_update_flags < RQCF_ACT_SKIP
> [ 13.523055][ C0] WARNING: CPU: 0 PID: 158 at kernel/sched/sched.h:1550 update_load_avg (kernel/sched/sched.h:1550 kernel/sched/pelt.h:67 kernel/sched/pelt.h:174 kernel/sched/fair.c:4747)
> [   13.524265][    C0] Modules linked in: drm fuse ip_tables
> [   13.524722][    C0] CPU: 0 UID: 0 PID: 158 Comm: openipmi Not tainted 6.10.0-12745-g124c8f43740f #1
> [   13.525464][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 13.526307][ C0] RIP: 0010:update_load_avg (kernel/sched/sched.h:1550 kernel/sched/pelt.h:67 kernel/sched/pelt.h:174 kernel/sched/fair.c:4747)
> [ 13.526793][ C0] Code: 00 4c 2b bb 88 01 00 00 40 f6 c5 02 0f 84 b7 fa ff ff e9 ca fa ff ff c6 05 b9 1b e4 01 01 48 c7 c7 34 74 d6 a6 e8 a1 c7 fa ff <0f> 0b e9 78 fa ff ff 65 8b 0d 8f 83 91 5a 89 c9 48 0f a3 0d e9 7b
> All code
> ========
>     0:	00 4c 2b bb          	add    %cl,-0x45(%rbx,%rbp,1)
>     4:	88 01                	mov    %al,(%rcx)
>     6:	00 00                	add    %al,(%rax)
>     8:	40 f6 c5 02          	test   $0x2,%bpl
>     c:	0f 84 b7 fa ff ff    	je     0xfffffffffffffac9
>    12:	e9 ca fa ff ff       	jmpq   0xfffffffffffffae1
>    17:	c6 05 b9 1b e4 01 01 	movb   $0x1,0x1e41bb9(%rip)        # 0x1e41bd7
>    1e:	48 c7 c7 34 74 d6 a6 	mov    $0xffffffffa6d67434,%rdi
>    25:	e8 a1 c7 fa ff       	callq  0xfffffffffffac7cb
>    2a:*	0f 0b                	ud2    		<-- trapping instruction
>    2c:	e9 78 fa ff ff       	jmpq   0xfffffffffffffaa9
>    31:	65 8b 0d 8f 83 91 5a 	mov    %gs:0x5a91838f(%rip),%ecx        # 0x5a9183c7
>    38:	89 c9                	mov    %ecx,%ecx
>    3a:	48                   	rex.W
>    3b:	0f                   	.byte 0xf
>    3c:	a3                   	.byte 0xa3
>    3d:	0d                   	.byte 0xd
>    3e:	e9                   	.byte 0xe9
>    3f:	7b                   	.byte 0x7b
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	e9 78 fa ff ff       	jmpq   0xfffffffffffffa7f
>     7:	65 8b 0d 8f 83 91 5a 	mov    %gs:0x5a91838f(%rip),%ecx        # 0x5a91839d
>     e:	89 c9                	mov    %ecx,%ecx
>    10:	48                   	rex.W
>    11:	0f                   	.byte 0xf
>    12:	a3                   	.byte 0xa3
>    13:	0d                   	.byte 0xd
>    14:	e9                   	.byte 0xe9
>    15:	7b                   	.byte 0x7b
> [   13.528234][    C0] RSP: 0000:ffffbaef40003d90 EFLAGS: 00010046
> [   13.528723][    C0] RAX: b53834d2850b7b00 RBX: ffff9ef2efd34640 RCX: 0000000000000027
> [   13.529379][    C0] RDX: 0000000000000002 RSI: 00000000ffff7fff RDI: ffff9ef2efc20b88
> [   13.530029][    C0] RBP: 0000000000000001 R08: 0000000000007fff R09: ffffffffa7053610
> [   13.530685][    C0] R10: 0000000000017ffd R11: 0000000000000004 R12: ffff9ef2efd345c0
> [   13.531344][    C0] R13: ffff9ef2efd34640 R14: ffff9eefc0e26400 R15: 0000000000000000
> [   13.532001][    C0] FS:  0000000000000000(0000) GS:ffff9ef2efc00000(0063) knlGS:00000000f7f5f180
> [   13.532720][    C0] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   13.533242][    C0] CR2: 00000000577c51ac CR3: 0000000162e6c000 CR4: 00000000000406f0
> [   13.533891][    C0] Call Trace:
> [   13.534215][    C0]  <IRQ>
> [ 13.534504][ C0] ? __warn (kernel/panic.c:240 kernel/panic.c:735)
> [ 13.534863][ C0] ? update_load_avg (kernel/sched/sched.h:1550 kernel/sched/pelt.h:67 kernel/sched/pelt.h:174 kernel/sched/fair.c:4747)
> [ 13.535278][ C0] ? report_bug (lib/bug.c:? lib/bug.c:219)
> [ 13.535695][ C0] ? handle_bug (arch/x86/kernel/traps.c:239)
> [ 13.536079][ C0] ? exc_invalid_op (arch/x86/kernel/traps.c:260)
> [ 13.536498][ C0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
> [ 13.536920][ C0] ? update_load_avg (kernel/sched/sched.h:1550 kernel/sched/pelt.h:67 kernel/sched/pelt.h:174 kernel/sched/fair.c:4747)
> [ 13.537334][ C0] dequeue_entity (kernel/sched/sched.h:817 kernel/sched/fair.c:5429)
> [ 13.537729][ C0] dequeue_entities (kernel/sched/fair.c:6972)
> [ 13.538130][ C0] unregister_fair_sched_group (kernel/sched/fair.c:379 kernel/sched/fair.c:13159)
> [ 13.554647][ C0] ? __pfx_sched_unregister_group_rcu (kernel/sched/core.c:8759)
> [ 13.555167][ C0] sched_unregister_group_rcu (kernel/sched/core.c:8707 kernel/sched/core.c:8761)
> [ 13.555621][ C0] rcu_do_batch (arch/x86/include/asm/preempt.h:26 kernel/rcu/tree.c:2576)
> [ 13.556008][ C0] rcu_core (kernel/rcu/tree.c:2845)
> [ 13.556373][ C0] handle_softirqs (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:555)
> [ 13.556775][ C0] __irq_exit_rcu (kernel/softirq.c:617 kernel/softirq.c:639)
> [ 13.557166][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 arch/x86/kernel/apic/apic.c:1043)

Looking at the call stack, any chance it is the following case that is
tripping this warning:

	CPU0						CPU1
	====						====
wakeup_preempt(rq) {
   resched_curr(rq);  ------------------------>	sysvec_reschedule_ipi() {
   ...						  scheduler_ipi();
   if (task_on_rq_queued(rq->curr) &&		} /* sysvec_reschedule_ipi */
       test_tsk_need_resched(rq->curr))		handle_softirqs() {
      rq_clock_skip_update(rq);			  /* RCU_SOFTIRQ */
} /* wakeup_preempt(); */			  rcu_core_si() {
						    unregister_fair_sched_group() {
						      /* On the rq that got the resched IPI */
						      if (se->sched_delayed) {
						        dequeue_entities() {
							  /* Trips RQCF_ACT_SKIP check within since waker called rq_clock_skip_update() */
							} /* dequeue_entities(); */
						      } /* if() */
						    } /* unregister_fair_sched_group */
						  } /* rcu_core_si */
						} /* handle_softirqs */
--

commit a64692a3afd8 ("sched: Cleanup/optimize clock updates") seems to
have added this condition to skip clock updates after an enqueue since
wakeup target will do a schedule() soon. Since delayed dequeue may has
entity to dequeue now, looking at rq_clock_pelt() in dequeue path will
trip this since PELT believes that the clock is stale. Could something
like the below work?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd4a6bf14828..c437b408d29b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13297,10 +13297,34 @@ void unregister_fair_sched_group(struct task_group *tg)
  			if (se->sched_delayed) {
  				guard(rq_lock_irqsave)(rq);
  				if (se->sched_delayed) {
+					/*
+					 * We can reach here when processing RCU_SOFTIRQ on exit path from
+					 * a reschedule IPI. wakeup_preempt() may have set RQCF_REQ_SKIP to
+					 * skip a close clock update in schedule(), however, in presence of
+					 * a delayed entity, this trips the check in rq_clock_pelt() which
+					 * now believes the clock value is stale and needs updating. To
+					 * prevent such situation, cancel any pending skip updates, and
+					 * update the rq clock.
+					 */
+					rq_clock_cancel_skipupdate(rq);
+
+					/*
+					 * XXX: Will this trip WARN_DOUBLE_CLOCK? In which case, can
+					 * rq_clock_cancel_skipupdate() be made to return a bool if
+					 * RQCF_REQ_SKIP is set and we avoid this update?
+					 */
  					update_rq_clock(rq);
+
  					dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+
+					/* Avoid updating the clock again if a schedule() is pending */
+					if (task_on_rq_queued(rq->curr) &&
+					    test_tsk_need_resched(rq->curr))
+						rq_clock_skip_update(rq);
  				}
  				list_del_leaf_cfs_rq(cfs_rq);
+
+
  			}
  			remove_entity_load_avg(se);
  		}
--

I was not able to hit the SCHED_WARN_ON() reliably on my end when
launching a guest to confirm my hypothesis - I was able to hit it
approx. 1 in 10 run, but I've ran with the above changes 10s of
times and I've not hit the splat (yet!)

Note: Although the diff was updated for the latest
peterz-queue:sched/eevdf, all my testing was done on the previous
version on this branch based on v6.10.0 kernel.
--
Thanks and Regards,
Prateek

> [   13.557638][    C0]  </IRQ>
> [   13.557920][    C0]  <TASK>
> [ 13.560463][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702)
> [ 13.560957][ C0] RIP: 0010:irqentry_exit_to_user_mode (kernel/entry/common.c:? include/linux/entry-common.h:328 kernel/entry/common.c:231)
> [ 13.561465][ C0] Code: 90 41 57 41 56 53 48 89 fb e8 63 90 1f ff 65 4c 8b 34 25 40 37 03 00 49 8b 3e f7 c7 0e 30 02 00 74 7c 49 89 ff e8 97 8f 1f ff <4c> 89 f8 a8 08 75 38 a9 00 10 00 00 75 40 a9 00 20 00 00 75 4b a9
> All code
> ========
>     0:	90                   	nop
>     1:	41 57                	push   %r15
>     3:	41 56                	push   %r14
>     5:	53                   	push   %rbx
>     6:	48 89 fb             	mov    %rdi,%rbx
>     9:	e8 63 90 1f ff       	callq  0xffffffffff1f9071
>     e:	65 4c 8b 34 25 40 37 	mov    %gs:0x33740,%r14
>    15:	03 00
>    17:	49 8b 3e             	mov    (%r14),%rdi
>    1a:	f7 c7 0e 30 02 00    	test   $0x2300e,%edi
>    20:	74 7c                	je     0x9e
>    22:	49 89 ff             	mov    %rdi,%r15
>    25:	e8 97 8f 1f ff       	callq  0xffffffffff1f8fc1
>    2a:*	4c 89 f8             	mov    %r15,%rax		<-- trapping instruction
>    2d:	a8 08                	test   $0x8,%al
>    2f:	75 38                	jne    0x69
>    31:	a9 00 10 00 00       	test   $0x1000,%eax
>    36:	75 40                	jne    0x78
>    38:	a9 00 20 00 00       	test   $0x2000,%eax
>    3d:	75 4b                	jne    0x8a
>    3f:	a9                   	.byte 0xa9
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	4c 89 f8             	mov    %r15,%rax
>     3:	a8 08                	test   $0x8,%al
>     5:	75 38                	jne    0x3f
>     7:	a9 00 10 00 00       	test   $0x1000,%eax
>     c:	75 40                	jne    0x4e
>     e:	a9 00 20 00 00       	test   $0x2000,%eax
>    13:	75 4b                	jne    0x60
>    15:	a9                   	.byte 0xa9
> [   13.562938][    C0] RSP: 0000:ffffbaef40613f38 EFLAGS: 00000202
> [   13.563444][    C0] RAX: ffff9ef0287dd080 RBX: ffffbaef40613f58 RCX: 000000000000080b
> [   13.564125][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000008
> [   13.564796][    C0] RBP: 0000000000000000 R08: 000000000000002b R09: 000000000000002b
> [   13.565456][    C0] R10: 0000000000000296 R11: 00000000ff8772ac R12: 0000000000000000
> [   13.566115][    C0] R13: 0000000000000000 R14: ffff9ef0287dd080 R15: 0000000020000008
> [ 13.566782][ C0] ? irqentry_exit_to_user_mode (kernel/entry/common.c:? include/linux/entry-common.h:328 kernel/entry/common.c:231)
> [ 13.567254][ C0] asm_sysvec_reschedule_ipi (arch/x86/include/asm/idtentry.h:707)
> [   13.567709][    C0] RIP: 0023:0x56652630
> [ 13.568072][ C0] Code: ff ff 83 c4 10 85 c0 74 05 83 c4 08 5b c3 83 ec 0c 8d 83 8d 6b ff ff 50 e8 cd 7c ff ff 8d b4 26 00 00 00 00 8d b6 00 00 00 00 <55> 57 56 53 e8 e7 61 ff ff 81 c3 13 38 01 00 83 ec 0c 8b 44 24 20
> All code
> ========
>     0:	ff                   	(bad)
>     1:	ff 83 c4 10 85 c0    	incl   -0x3f7aef3c(%rbx)
>     7:	74 05                	je     0xe
>     9:	83 c4 08             	add    $0x8,%esp
>     c:	5b                   	pop    %rbx
>     d:	c3                   	retq
>     e:	83 ec 0c             	sub    $0xc,%esp
>    11:	8d 83 8d 6b ff ff    	lea    -0x9473(%rbx),%eax
>    17:	50                   	push   %rax
>    18:	e8 cd 7c ff ff       	callq  0xffffffffffff7cea
>    1d:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>    24:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
>    2a:*	55                   	push   %rbp		<-- trapping instruction
>    2b:	57                   	push   %rdi
>    2c:	56                   	push   %rsi
>    2d:	53                   	push   %rbx
>    2e:	e8 e7 61 ff ff       	callq  0xffffffffffff621a
>    33:	81 c3 13 38 01 00    	add    $0x13813,%ebx
>    39:	83 ec 0c             	sub    $0xc,%esp
>    3c:	8b 44 24 20          	mov    0x20(%rsp),%eax
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	55                   	push   %rbp
>     1:	57                   	push   %rdi
>     2:	56                   	push   %rsi
>     3:	53                   	push   %rbx
>     4:	e8 e7 61 ff ff       	callq  0xffffffffffff61f0
>     9:	81 c3 13 38 01 00    	add    $0x13813,%ebx
>     f:	83 ec 0c             	sub    $0xc,%esp
>    12:	8b 44 24 20          	mov    0x20(%rsp),%eax
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240729/202407291328.761441a7-oliver.sang@intel.com
> 
> 
> 

