Return-Path: <linux-kernel+bounces-181710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 429FA8C800D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9223BB20F28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31199944D;
	Fri, 17 May 2024 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AO2Jbct5"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364A2F5A
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913833; cv=fail; b=YZ5+h8vqsfeXGBIrXifTf5YG8e/TzmoH3criF3s4kRiA9eH/424LS/1K9ziGsCiws+7BLA6DNxmuPV0hhKGWDTt7wPAGwD90l1RrMy3x3e0Xo3yrOLDdyOB4N2pNgpqCbJk9tcUGiqFsea6rlPPgKvMq0oEzoke8diPZUqRy1iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913833; c=relaxed/simple;
	bh=FQMXjRMek4vAJ2gzLWMktG+JqvkIylepxBLaMKu7XCg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZzEMIlxdisRfEMshDHnU/KGmHC8s4I2Hw0YmwWCOhfZ1BlZcaTex14Y0x0lZi0hoZxEL2UXwz5jfyFKNI35KgWFvo0MV0prKEgzCYL78XbjWyWTukTaelmNbvpIoG0zhPsyVJPr3+ItqyWK5D8rPRCy54K4rvVFZxWfF3LH8zbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AO2Jbct5; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy5Eu/Oi5FO6T6YFaf+BcX9lshvM5xm1O1jG0LkNX82LwNfPQyJCjMD8FQbgy8bLLHvacclZlLuS+nk9TtKcBQMwIWEPrn//M+lGcIM0w4/BZDiszk7EzffI78C6zrBtDvb3pVzeZN4JkO4Ve13PQ/MHPxUexqZzzC4babkhdhE4+dPFQfTUO5kaExnyJWrqDNNXfMvX4BAaXNCT3o/f3PGk0csEjyoTzmysJmC3xcyMfvODVIjKFKSmADnlHBpVi8/FS+0AOFJd8gnarBrVdLTgapwBPCRmhk+BVT9tM3qQxbTEuPiNl56GzJiLqOm4e/LucCg5hB8cmPE1Qph9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0Nc5BoBwga1Ie2yrUbwM7djomdYDZ1Uhn2V1xyRXQA=;
 b=awc4PFSK59hT/6mlD0R2J6KRGQgbdCwI9VKiGQBM67R38V+RqMafS5sDqmx21DeoJdJzMSb7UuRJE43F3gjETGWhDRETtOnlwen+nvNiXSf/pwAKRL6Q2TUUCvtNSmcQVH2c18lsR5IEzAzqGYtzMcMCYEyr3b6hlVQtaZv+xcuEQ4xQU+NsyQhfCoVQOXTrHvOUmeF8mwBPsZUTr3Rzr6U+3LGCEpL/paaaZxt6O0tJVbBxR3yFrWpA9nkWHvNLZthB56rhZgLFHJ7l6w8PD1K+9CcxqddMG4rsEftdAyPxFgHXhEvG5aJKUGwME3dqWUgRSjq+j5icNE+9NO3m/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0Nc5BoBwga1Ie2yrUbwM7djomdYDZ1Uhn2V1xyRXQA=;
 b=AO2Jbct5i7wlgCCcn72mYfzc6BNoQeSHSnrO2hUkN+qQPZRWdAYqi2ignNOzLvYYXaiNxeHYlDdOnW0P6KtkULXZmvQRKVc4hIObMcDUg6s+5JLeGxaczv/gvZzZbjz/JTiPm7c4yCp00OnZ1wnVTdnIPH2z0SJZZo5qITbCuTEbqN/ev1SIZbLsiS2WD2mE1h/SGC2FHAoknf5IAH5sqSmncOITcqFOGHkowp2eGAWL7j4CM6IlCo7ho5wDpfJOYDsjGxMhl75LvvX1exkI13Ac9YPS8eg+j39DdkMHp7Vk5LZIyX8xJx0jqjLf7iVim473DGuk7h5OHjdhPR4EYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 02:43:48 +0000
Received: from PH7PR12MB7186.namprd12.prod.outlook.com
 ([fe80::515c:f534:ac0f:4775]) by PH7PR12MB7186.namprd12.prod.outlook.com
 ([fe80::515c:f534:ac0f:4775%4]) with mapi id 15.20.7587.025; Fri, 17 May 2024
 02:43:46 +0000
From: Jordan Niethe <jniethe@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,
	ajay.kaher@broadcom.com,
	alexey.amakhalov@broadcom.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	jniethe@nvidia.com
Subject: [PATCH] x86/paravirt: Ensure calls to pv_op functions are RIP relative
Date: Fri, 17 May 2024 12:42:24 +1000
Message-Id: <20240517024224.995517-1-jniethe@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To PH7PR12MB7186.namprd12.prod.outlook.com
 (2603:10b6:510:202::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7186:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a3a0a9-75e0-48ee-aa14-08dc761b2c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0I9gHtB9HEDVwQP3uiCYOoTvJ1MxfRh9NsNny0L9bygfQiMC4cOCmpFbUpk4?=
 =?us-ascii?Q?3aMI24YkaZJ0QgS2DyIaW/iYh3ih4L5LB6k51URqolZg0BtARGUMWFpGRvz+?=
 =?us-ascii?Q?2lQOggr5C7J7CkWRvDbj14zB7qBRBLetrCykElbmOI5fBlII8HmLMA2Ch03e?=
 =?us-ascii?Q?e9hB+/ddLQDk8cdu3A1+iXaJ4AQIyPhw42oU9hKJhMRQBevUCz/NB+odq+Ty?=
 =?us-ascii?Q?T1DjyIxQhbOdZ0+YSTbVsTzjKu21RJ1MdQRW4/mnejb9AvIOL8a9IQ+FAzwL?=
 =?us-ascii?Q?bsSs3fp4vuixOaHt32ZjWhekfAIY5wj6ukT9+AQI5oilEEnolGAZkoj+0Lip?=
 =?us-ascii?Q?1VegRg/sOoZMOjV2BEnQys7Q3e0v4ZO8RgIJkxEkuAKtxnRLdl11HhztvNQq?=
 =?us-ascii?Q?pLuqRb1Io2dFYf5CJam1n/BcTUIlQuVsn/qeOKp8LF9Dc4Wsv6EeMuh+fX9w?=
 =?us-ascii?Q?H7HsGXdq0UjILduQsLUPH45Lhwm3o8gPJldAkQKHnkH2JZQ7fPQA9genE1RR?=
 =?us-ascii?Q?jen065Kz9UkROAgH74j441daTXX/fnWgpYZqn846kB36HqmGMqP7vpOCNnam?=
 =?us-ascii?Q?2EK0a8Vx8b+F8Ry3s+hu9+sRcUZNUnuxgBbj7UP/wL7iuRZjjId1gtuyoSGD?=
 =?us-ascii?Q?VDiodAdI9KBZjKLVYPP8D6vOK8p48G1RkPbacLij8P6n6wGRAGva5BkSA3tL?=
 =?us-ascii?Q?HbyO7VjAPVXPgXUaUoL9/IZmUF2QhuLt3Tp1WinMWCMOwxCbA3PIigvJC4H2?=
 =?us-ascii?Q?IQdtgLI3SSyaEE8FlQoq9jnHULiPaQGNZ0Hqm75hEX2tCPXcI1F7mn2QkXQ+?=
 =?us-ascii?Q?bXAFXMTueUgs0n6Nn5g1y5/nYANhZuIgPXmjlbwHbX2J6NonBNGLc2oNah7z?=
 =?us-ascii?Q?Avo/75it2h7gAKCP5ijkiHKcMJvj24I/dDG3GmK0KAJF54bv4LfYJqx7m2Yd?=
 =?us-ascii?Q?tht7h4cZHx2Gh3KpAyro9YSWk9xh5Ueg2VsXN/smdQL0VbIzcFlxFX9x2KEN?=
 =?us-ascii?Q?5xC3NES9h6qKj4p+D8q153863ggWHWMsFRn7higq/7XXQo6aZ+OAvNUZfYWY?=
 =?us-ascii?Q?xaHrmLy0wtqIQDIcSiUE1gEGwVMVtFnIoEhaIYkteZCOzMU74cCis7CytvK5?=
 =?us-ascii?Q?Sx2WF7eMmiOi0DdD6iOuZ3ET6ZyK7xh/CsiUg8g9DjfBLG0fvn7CCWMDMGGx?=
 =?us-ascii?Q?tPTFSpIKmCQQ+1J0gNxnmTSq+9GOpOGCrHSpe7EdYZfyU+UReN+5NgPt1bnu?=
 =?us-ascii?Q?2hOhF44nHqjsXygPj+Eq3sbUk8/JvsfJANxEsMf/3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQp5IDpGVhJv7TF4X14TZEBnjhYXNjVe0t56zSnSyR1bscmPQZWjxpW9/G9r?=
 =?us-ascii?Q?GxyOF6xLM9lTdz/aovkSs2b2hbH7uVSn1qNVgTrN+Ksv6PqBCtfZxGXh8fSY?=
 =?us-ascii?Q?ThV4PAJ5kn00L9oWK1QTMUhWMF3XWbzVGhDUPmD47qcAz1cvIP41JEdv3W8k?=
 =?us-ascii?Q?gqssAUvJ9OUbKpavldEDFEGELlT9+mTbpRaB8nupbul7XbHCXwxKKszx2RNX?=
 =?us-ascii?Q?vhNHzdttxcH1aRl6NP7+Z5lQj91Ce6PSR7xn3qYQZiGKQTW+hOctob3EGwT6?=
 =?us-ascii?Q?c46p4s8s5sb8sIvdD+We8mV2VOgRmnqVERukFcgXIStrh2o3hF2vdI/cM+ms?=
 =?us-ascii?Q?UwgKeIWPOM8TWwsCQ9GnAWSyV2RaMKgfGyW+iGQ0c1n1ZKQAYoNbQOO8qDC2?=
 =?us-ascii?Q?38EeTZqgZV1tTS55GQh9vlY2+26qorNU0sIpbHN4W7ZBcFkCatDNlelsSVbd?=
 =?us-ascii?Q?elW/IfUG7Iu0Jj+8eV/LpsJqe5vj6zcpOSDsKi1y/geWLhjvj2QIVulYCYyJ?=
 =?us-ascii?Q?VefOkw64WtawuDPcmK1hNdNqkR5+ZygYv6VYwAdG8F2OdE0DTjHcC7kKlle3?=
 =?us-ascii?Q?2jMoyjMJxABmOxPud/Wujk+ULyrahvyuXEbK76mtUCLl/Z4/eWtwr6rUv65I?=
 =?us-ascii?Q?u5bD7MqhYahKtWCBPvJaxZ4rA3iAWIe5xG14sxbZEdlRGSzyh/ckaKLSbYUc?=
 =?us-ascii?Q?IjtzvSURqfLD7LI5zIhP7d6SBR9XIJdQXMF5UjYFlUvAGP/LQpnZeEnl2MUc?=
 =?us-ascii?Q?e81/LkbyHSgBhvO0QJfHBaA5R8a70Vhi6Xo5jyT9Y6OZ61MjaAd1r/GXT00G?=
 =?us-ascii?Q?f70QTJqM4W/XZfdF+w71+iLNgeyK/lLlOLuUiSRM1mcCvhBL+rxx9TQ0IBvO?=
 =?us-ascii?Q?/q/9Hv+I0E9r+F6/uFJ5l08p7NyT7yv2Bs3z9eDaeto1E4WieBEx3cU7oWzo?=
 =?us-ascii?Q?KM4BXx7BNpmqiQN+rNyndbST6jWmW81VB2BN696W3QhgYVw8Y3J9MImjUdoz?=
 =?us-ascii?Q?HnUQbCfi83CCZhvUjJl7AjMm14nDQUg7ll0qQ2x/m7lf/JIyYhfLfraFM0y7?=
 =?us-ascii?Q?DjQkb3Z9/gOFEpvPpxeL80w++rVsgbsveTtnVEBvzA9HwfxCtV7Ot1Tv+TTu?=
 =?us-ascii?Q?f3wYBbRvjsyTBUmZ/jODqAuqltH1vX6EGY4gc4cEiZ3HTsN4CarYhq+tau4K?=
 =?us-ascii?Q?0FNGssTQE3EoX1/JxEOlclj8LY26aQrqeclJVHyrN96Z0DL24N9xGicLunbh?=
 =?us-ascii?Q?eFrSu9V8P/lh41WVaPncBlzihvt8g8qiSZc73/qB9nSdOGQ/NZyIrDamcfkN?=
 =?us-ascii?Q?B2TJ42Vef9RC5eJ96LBFio4dL0O5Dw3RFHKC+oGG8P3aMDnyD9H0lTSo47oH?=
 =?us-ascii?Q?DBpagRoexo1eaifoqhlD8TUraExvGB9vo3WBV+kb+96Zd+o3XkO7MSg215yu?=
 =?us-ascii?Q?G+pLzL0IQd9m0BOeyn0wZa5W5UsqFYRorE/+QhwTIKEufVPfCJ18T+olhvrf?=
 =?us-ascii?Q?lepDhQ3K6vaPINj++q4b2AGprECtnZUKoNFFtYFGGpAUfNQujw0TR1EL2mj3?=
 =?us-ascii?Q?JxXMqDOPXe7mm4BJjs2dsnMwruBOe0hQrxJa6ocY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a3a0a9-75e0-48ee-aa14-08dc761b2c28
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 02:43:45.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H8ZCctvM0cyayA1pSkkyFXSkhwx9QwEX1XE4v5GwKeqhYksZrMqCsdsZlHeHciWxIuipR9z3/xwRPpFCx8WaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250

The pv_op functions are patched from indirect to direct calls at runtime
using the alternative.c infrastructure.

alt_replace_call() patches an indirect branch in the form

	call *disp(%rip)

to a direct branch.

For the paravirtual functions, this indirect branch is generated by
inline assembly that uses the PARAVIRT_CALL macro:

	"call *%[paravirt_opptr];"

However, it is not actually enforced that RIP relative addressing must
be used.

The toolchain may instead produce an indirect branch in the form:

	mov    address, %reg
	call   *offset(%reg)

This has been observed at lower levels of compiler optimisation but
there is nothing preventing it from occurring generally.

This triggers a BUG in alt_replace_call():

	[  114.919130] SMP alternatives: ALT_FLAG_DIRECT_CALL set for unrecognized indirect call
	[  114.919137] ------------[ cut here ]------------
	[  114.919138] kernel BUG at arch/x86/kernel/alternative.c:429!
	[  114.919144] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
	[  114.919148] CPU: 13 PID: 14617 Comm: insmod Tainted: G           OE      6.8.0-rc7 #16
	[  114.919151] Hardware name: Supermicro SYS-1019GP-TT-06-NC24B/X11SPG-TF, BIOS 3.3 02/21/2020
	[  114.919153] RIP: 0010:apply_alternatives+0x447/0x450
	[  114.919160] Code: 18 90 02 e9 7b fe ff ff 4c 89 f8 e9 65 ff ff ff 48 c7 c7 10 4f 90 8e e8 17 52 16 00 0f 0b 48 c7 c7 68 4f 90 8e e8 09 52 16 00 <0f> 0b e8 a2 0b fa 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90
	[  114.919163] RSP: 0018:ffffa9714d8fb9f8 EFLAGS: 00010246
	[  114.919166] RAX: 0000000000000049 RBX: ffffffffc2674690 RCX: 0000000000000000
	[  114.919168] RDX: 0000000000000000 RSI: ffff97ed101618c0 RDI: ffff97ed101618c0
	[  114.919170] RBP: 0000000000000006 R08: 0000000000000000 R09: ffffa9714d8fb8a8
	[  114.919171] R10: 0000000000000003 R11: ffffffff8ed46848 R12: ffffa9714d8fba0a
	[  114.919173] R13: ffffffffc267916e R14: ffffffffc21be935 R15: ffffffffc1fc750a
	[  114.919174] FS:  00007f9417d21000(0000) GS:ffff97ed10140000(0000) knlGS:0000000000000000
	[  114.919177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[  114.919179] CR2: 000056030cd5e520 CR3: 000000106587a006 CR4: 00000000007706f0
	[  114.919181] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	[  114.919182] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	[  114.919183] PKRU: 55555554
	[  114.919185] Call Trace:
	[  114.919187]  <TASK>
	[  114.919189]  ? die+0x36/0x90
	[  114.919196]  ? do_trap+0xda/0x100
	[  114.919200]  ? apply_alternatives+0x447/0x450
	[  114.919203]  ? do_error_trap+0x6a/0x90
	[  114.919206]  ? apply_alternatives+0x447/0x450
	[  114.919208]  ? exc_invalid_op+0x50/0x70
	[  114.919214]  ? apply_alternatives+0x447/0x450
	[  114.919216]  ? asm_exc_invalid_op+0x1a/0x20
	[  114.919224]  ? apply_alternatives+0x447/0x450
	[  114.919226]  ? apply_alternatives+0x447/0x450
	[  114.919228]  ? insn_get_opcode+0x36/0x1d0
	[  114.919232]  ? insn_get_modrm+0x71/0x110
	[  114.919235]  ? text_poke_early+0x6a/0xa0
	[  114.919238]  ? apply_returns+0xcd/0x330
	[  114.919240]  ? pcpu_block_update_hint_alloc+0xd5/0x300
	[  114.919247]  module_finalize+0x23e/0x3b0
	[  114.919253]  ? add_kallsyms+0x295/0x310
	[  114.919259]  load_module+0x1af9/0x2180
	[  114.919264]  ? ima_post_read_file+0xd0/0xe0
	[  114.919270]  ? init_module_from_file+0x86/0xc0
	[  114.919273]  init_module_from_file+0x86/0xc0
	[  114.919278]  idempotent_init_module+0x109/0x2a0
	[  114.919282]  __x64_sys_finit_module+0x5e/0xb0
	[  114.919285]  do_syscall_64+0x86/0x170
	[  114.919288]  ? do_syscall_64+0x96/0x170
	[  114.919290]  ? do_user_addr_fault+0x304/0x670
	[  114.919296]  ? exc_page_fault+0x7f/0x180
	[  114.919300]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
	[  114.919304] RIP: 0033:0x7f941751e88d
	[  114.919307] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
	[  114.919309] RSP: 002b:00007ffc77449ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
	[  114.919312] RAX: ffffffffffffffda RBX: 000056030eb0d7c0 RCX: 00007f941751e88d
	[  114.919314] RDX: 0000000000000000 RSI: 000056030cd69cd2 RDI: 0000000000000003
	[  114.919315] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
	[  114.919317] R10: 0000000000000003 R11: 0000000000000246 R12: 000056030cd69cd2
	[  114.919318] R13: 000056030eb0d750 R14: 000056030cd68888 R15: 000056030eb0d8d0
	[  114.919321]  </TASK>
	[  114.919322] Modules linked in: nvidia(OE) rfkill tls intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel binfmt_misc kvm vfat fat irqbypass ipmi_ssif rapl intel_cstate spi_nor mei_me joydev intel_uncore mei mtd acpi_ipmi ioatdma ipmi_si intel_pch_thermal ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad nfsd squashfs loop auth_rpcgss nfs_acl lockd grace dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua sunrpc parport_pc ppdev lp fuse parport ip_tables raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 raid0 crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ixgbe ghash_clmulni_intel sha512_ssse3 sha256_ssse3 ast sha1_ssse3 spi_intel_pci i2c_i801 dca i2c_algo_bit spi_intel lpc_ich i2c_smbus mdio wmi
	[  114.919378] ---[ end trace 0000000000000000 ]---

Before commit 60bc276b129e ("x86/paravirt: Switch mixed
paravirt/alternative calls to alternatives"), the paravirt patching did
not look at the indirect call to generate the direct call target. The
target was determined by the type in the .parainstructions section
entry. This meant the form of indirect call used did not matter.

Force PARAVIRT_CALL to generate a RIP relative call on x84_64 instead of
leaving the choice to the toolchain.

The inline assembly invocation is based on rip_rel_ptr() in asm.h.

Fixes: 60bc276b129e ("x86/paravirt: Switch mixed paravirt/alternative calls to alternatives")
Signed-off-by: Jordan Niethe <jniethe@nvidia.com>
---
 arch/x86/include/asm/paravirt_types.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8d4fbe1be489..a960ed301c6a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -242,15 +242,28 @@ struct paravirt_patch_template {
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
 
-#define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
 
 int paravirt_disable_iospace(void);
 
 /* This generates an indirect call based on the operation type number. */
+#ifdef CONFIG_X86_64
+
+#define paravirt_ptr(op)       [paravirt_opptr] "i" (&pv_ops.op)
+
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr](%%rip);"
+
+#else /* CONFIG_X86_32 */
+
+#define paravirt_ptr(op)       [paravirt_opptr] "m" (pv_ops.op)
+
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
 	"call *%[paravirt_opptr];"
 
+#endif /* CONFIG_X86_64 */
+
 /*
  * These macros are intended to wrap calls through one of the paravirt
  * ops structs, so that they can be later identified and patched at
-- 
2.34.1


