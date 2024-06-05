Return-Path: <linux-kernel+bounces-203189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCA8FD7A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952901C21B19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE9215F31D;
	Wed,  5 Jun 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="b7fz9v51"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2105.outbound.protection.outlook.com [40.107.220.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64CC153BC7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619865; cv=fail; b=q89HLyNg3resix+rC+Brs3w9o2252dfVNUKECxwsVptJzVsHX7Cvxyx7MKi4nWEg6A8AiVOVKFcYZXzubZ68Vr5YLAsZL0Klxx1rBcx8jX6ODWra0Nj665lgz0C6rnZpQ3f5Q3QfsJiUqgh3TAgK5fbLXMBv5ZpmXFNJHnFtLoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619865; c=relaxed/simple;
	bh=sXlrWyzuF5NypRiJ9utIQoU9FV98MfFVBNrAndk93X8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WjZdqlekQwaJ8d3J4MPbIgFsWkuxqq4L+HpQBr9fJp/wFC5SgtLt6EEwL/JSbbDh2Y/Sc4gWRcyySxiZc8gqoBJrAVRV3vlTXRfPuUJx/H17bMrwZqoFPTm+znPMz51q9VnU9pGYUJxTL+jeu5jhTXylLL8EZPi0CikxUFYejMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=b7fz9v51; arc=fail smtp.client-ip=40.107.220.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2NODL+w8xruVPGxXdDWktj3mHhWs6f7eOY4PQ+3e2d46ou+K2iHHxI/UZOK1pCzQG7Lj7h/hsOtmv/PN0GuINPthb4Fzt9AY1+dFQbSuj7/4DGccjfsOeK9soGW7ODMx4BKp+51rXrd6c4nJ/Z+zMqT4319GSHA+BdpWGTFR0gv2zvENkplUMFc1udv4CvRwHoX6evKWz3ZJG0j6ODE178lFZ59xEe76cgzrr4+17fwqsTcl5/ZVZBqE3lqZTzePJRhLG9MJ3gkOh0Bep/9SDr6xo11vuV614eczLEqL42ygXitg82KFbWYSrEMbXxcB1cFt0SRAO+u3axVlJ5Vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75U8XTWVYIRCZjzSdvJ92iQPOnD0bnaaffjYKvar4DA=;
 b=ecX3w6Fhe7hcAh70crbhU1X+sjBkG2/yZRLkkpx6unVh5AodMDNJAwrbhIExsORCCH6kFzTNSnrKDZsEBagegcnSxbd/4AhtgSWOiNRNoNVf14RsYrbE1YVTtMcPaEjmmOAiYapBAqeBGt9xYnI6Jf0mMY8Sfz5Lm2JvIAkNGUo9rM+huBZJ9h3j/iPdkali4ysANZnDv13QgNPE6WlUsv8EJTS7GuhpTgQhKcU5KjzyQDduaf5qf02Ku2ByHM8HY9vt6I3p7+CUpgI0PeahOrQLC4Fsi+N/HWJFNAbfOv7aZR2sR6+HyD+Nr012tYq/e5vd/atgb/DqFFQg4+WbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75U8XTWVYIRCZjzSdvJ92iQPOnD0bnaaffjYKvar4DA=;
 b=b7fz9v5106cqGOwkTjYZBrjORkjJF+Su8md7AyuN/Qij6P8TwG9BgCAL/0zlXWbnGzxklS+8c+Rvu0Zgqdu+8wt6aFXPo37pinwaiHOIPFgjK4SnTj4OmnK7rP3qqZjNIy3JDVdrzrWZQW6Dcs2WlzHEdRpOh+tHnQK1bgJis8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SA1PR01MB8236.prod.exchangelabs.com (2603:10b6:806:38c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.33; Wed, 5 Jun 2024 20:37:40 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:37:40 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v4 PATCH] arm64: mm: force write fault for atomic RMW instructions
Date: Wed,  5 Jun 2024 13:37:23 -0700
Message-ID: <20240605203723.643329-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::32) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SA1PR01MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 85005473-d2a6-4b70-0abc-08dc859f580e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y+Xhey7dAG4SPGl0rNu1r9ibi1/XBfkuT+5HkEXNQ2tyc69jZhrv2cBVyJ8/?=
 =?us-ascii?Q?JF5+5B3jWlEhUknU+c7OKletOoPLiiW9QYd2THkZ5JVFkVok9PGOnWKwQG4f?=
 =?us-ascii?Q?8e6zvTmE8eF5BlpwRoCA4mtz6w7chcIu1Ih7koZy5767MPzAmiAaSGG5CsSz?=
 =?us-ascii?Q?07Domuh8yCLrIghx5aeK+zXW1M+7ZmFxj+SyZXam4Y14RJMIAWlVhlNGgtB/?=
 =?us-ascii?Q?ne6vGrPllYgRwxrZvBWiaHe22dXqgzkS6Jzbx1rp4Jq85ZP70lFnorRxsU79?=
 =?us-ascii?Q?zC9QBYPsBPwKft2nDLL6ct30gBp4C7DabPUPMzXVlnfnA1xAIi72pKMwRVAZ?=
 =?us-ascii?Q?R38oTWjoOhaTu+kVTZ1VTQUpytDlk/fKN5I974FkwwyYkZrTf6YzeMbLcNpU?=
 =?us-ascii?Q?j85f1WiBU9n09pInV749QkJ+whio0GCzGSS51R8euiH4YnMgNNhPan2yNAwb?=
 =?us-ascii?Q?Is5kCmxOzr+9qdCrL0z1+vHmQE1koXExsObddAJEvzEg9JirEXLQC0jY0CtE?=
 =?us-ascii?Q?JS44MBhAvtrVWnDeHFT3GXM5DyiVoyXhfwI26BXCdoNt9nOSZRv32wtWVe1f?=
 =?us-ascii?Q?ZNLPAslimow8HWOaOJb44/WTk3Zl6etZImaWN7nOkORlr0B1aPZgMwFiekAX?=
 =?us-ascii?Q?PyBMQFjfNdsvtSaSONC5GFU/9K/VJ/H8gOW2nmQPJG018EulDsLvb/mr9D8W?=
 =?us-ascii?Q?70LyvLJbQ/77tAUdvIVc5QcxZCsmOoD3o9vVmqWckv14bfUm01CaNXswYpbE?=
 =?us-ascii?Q?+64YD0BRmnfwVdhbTbvE6XdI9NxoIdo8vA2VyKgKYHEwc/lKkefCnLECLIie?=
 =?us-ascii?Q?gF2IpAYF7oXCw9yvKF/IhOEzUJwmK6qHfQhcvcK0fNR3tS4pC9cJJe75JjRD?=
 =?us-ascii?Q?G1Ta14hbzqAaYaz994FDSB/A8O0LuITr/9ZoQp25wosYahObsUCbjArMXIwW?=
 =?us-ascii?Q?P+JG4gGPppIA7sSbx94O6QljEOzIcuUhtg/Z6udOgJbb7mK+eGZkYXTiCJqj?=
 =?us-ascii?Q?fRgFNggQYNLdA9s64T7/PjjduFREGkiQaHefvaDoXFUM4AH38I2TqxYZ68fm?=
 =?us-ascii?Q?p+KypplGsol5fO9NzoN8REeZ8dDs2OfBd0X6l8MKGRgmsODv+CAMrY1A0hrf?=
 =?us-ascii?Q?bG5ZzZm1cSB3FeZlK4GW6v9/jMhISmRQUhV9PvF7uh3Z1IbOhmVpha4J6gbS?=
 =?us-ascii?Q?fuHH7XswjPJKxarg8z7jlRKH6lJi3jV7Lh/2Xn/bdiosUpdYWAuKJGIOJDTn?=
 =?us-ascii?Q?iT0n48rEJ3Ni4qhTbXlczEDXZ3Ad0AfoVmeCd9pmlvUGTOQ04uhHxmEqLcNo?=
 =?us-ascii?Q?IiVxKoOZ+1AMpul1VLL8Ush7odkRHadAoWL0ob7C8FAvJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wZ+azrNKEXLiHgT07IVstbjGBrZYHmj79Z+G2fxJ9AK0FyWcVJxiXqo5p4CJ?=
 =?us-ascii?Q?7dzORouz5zUJEAICHTSklSec3J/q/2GHoK8E+RxeHFh7V82SgKMeBwXz1G9W?=
 =?us-ascii?Q?DUEINcH4n9dX1WswggntgrufogYgno+CBTOuSzU4oPgSPXRDzEQ5JI5Bae/u?=
 =?us-ascii?Q?LM55IL8hLWvrrKipBEWgTKTcbmaVsQGlC56jRa5XPHbl9CIJZlvEjM5M3Rhx?=
 =?us-ascii?Q?EuULpjL6wHdOCleTM30EMtXUbJKB4xts2/iYg6A7zLpX51S8dWgmyASoCUrF?=
 =?us-ascii?Q?sL21CGcbTBE6rYTPxFUyN0xK7rV2PRDwAV66YTEMcLi++RihepB/+vGLxKSS?=
 =?us-ascii?Q?LZKmBb5G5QCo9Kh+78dIHOMGB6VFZiEg473lZxCLhtU+u5XlwNxCTnBoEPmM?=
 =?us-ascii?Q?a1EKa+o1BNvufeAdEf5Z7J7EvN8G0UKBSHtet1YAAxbOyROP5aOMSwrlPHuC?=
 =?us-ascii?Q?AuKk7+HjHus9OuX8EndAFYuaM2RLOb5scnQXvvfX//jaXfWJo2og1ItERptB?=
 =?us-ascii?Q?BlJ3alpi+6k3HbmtYkCufVfOG3SoPO+cVqLZXAvFNcdglvqqP/QdQsq8E9Ot?=
 =?us-ascii?Q?MKXS739Pxr3RM00O/04aHMlDLpB3JGn0VJwQJBs5JplnCKM4i9CaZ/hIXHyH?=
 =?us-ascii?Q?eEcmqLyn1yr0XxQn+aHVS90urtUSqNNSbfyaiGr7erceGoUtUCziTZLYFi8+?=
 =?us-ascii?Q?eg9V7haxXbe4d+N4dBB1A1QFNRIelWVyw8QfOfeRm+AWHA8MNv3hhwLANnWt?=
 =?us-ascii?Q?ZMXcOeomAKWRUXariRnIi0LxUcqX7YpqUDC0vhaO1UFBg3zrwQqxcGbJOX2G?=
 =?us-ascii?Q?zbsGSUMEVQLVnKQVCqQgLWTDiDG5AgPyhLnsrwBcQkZ0S3hdSN0DUSEZVCwi?=
 =?us-ascii?Q?t+E/1OirWUDxS9GHHti8taF7RkJJpU2OJ+7W24XxU95ZEhLi4sM5aBAASuG9?=
 =?us-ascii?Q?REQRPAuL0WfnmkaN77hF/inEdIG6hwQSPTGHENcxoUWWQrLf3cBPCDWiFWru?=
 =?us-ascii?Q?SoElK6M+WtnpiBv6fiMUH0t1X3gWGek5L0nZJWJSBE7j/vAzZKZqpF4WnJj+?=
 =?us-ascii?Q?iiCMOyLW4IQxdvv6nbzDOTFjnUUD5S3BIok96+0p4epPVQW84pT5BVCglqCz?=
 =?us-ascii?Q?yJ3h6Kpwzv1YrrwAJ38vTH5Hto4kLQjkpAv9mGgV31vutPjaRe78r9oIr1ke?=
 =?us-ascii?Q?THxJWTytxJHgt7B+JDHyg+WImBUwHg71+Y4cXWSAwWMXsCTxPwXq84BvaDuK?=
 =?us-ascii?Q?lsOjSu/nQkK+/DWWqD3ShXnINvJzHJA+GV++wfX/zrL0wGKaPEbkMHtHFYUs?=
 =?us-ascii?Q?aLTSFnkeEp6VmkGUhBfdOuEaqQEotr3sA4VnvgzdZnozNeKVzXp3+RWL0rvg?=
 =?us-ascii?Q?AS3hW8uXw2CukUzF7AlTTlRyEns23AJ9OpiNYYAFB6MHubapNXcLFBzKWiPo?=
 =?us-ascii?Q?NrISoRPwdENHtA5JA7K8DGkJCYWVeUPHDaBphBqpkLjFOA/YqkY1XD+l3kl/?=
 =?us-ascii?Q?eYxUCot6nwIUpWHtpWOoznRbKRuAal9TI/ZB3StV3BQzP/FkmZgismm9n541?=
 =?us-ascii?Q?u/H/g9wvQAJOZl+peNzUwZaECBJQKMQmt36Gqopf89+oa51LhbiNnbk6Yxvh?=
 =?us-ascii?Q?ido5IMITSEaP+dRPEV6MqXY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85005473-d2a6-4b70-0abc-08dc859f580e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:37:40.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMVNZAtlT6aQik/EKm1c3tHYg31m7uaMMEETJSoQps7dBQB8fWDkL9Mcu1Ti2sCVpizXdRrAMevEJFU+u5xBG+5Hb/4ghkWrrtqjvRH6C2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8236

The atomic RMW instructions, for example, ldadd, actually does load +
add + store in one instruction, it will trigger two page faults per the
ARM64 architecture spec, the first fault is a read fault, the second
fault is a write fault.

Some applications use atomic RMW instructions to populate memory, for
example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
at launch time) between v18 and v22 in order to permit use of memory
concurrently with pretouch.

But the double page fault has some problems:

1. Noticeable TLB overhead.  The kernel actually installs zero page with
   readonly PTE for the read fault.  The write fault will trigger a
   write-protection fault (CoW).  The CoW will allocate a new page and
   make the PTE point to the new page, this needs TLB invalidations.  The
   tlb invalidation and the mandatory memory barriers may incur
   significant overhead, particularly on the machines with many cores.

2. Break up huge pages.  If THP is on the read fault will install huge
   zero pages.  The later CoW will break up the huge page and allocate
   base pages instead of huge page.  The applications have to rely on
   khugepaged (kernel thread) to collapse huge pages asynchronously.
   This also incurs noticeable performance penalty.

3. 512x page faults with huge page.  Due to #2, the applications have to
   have page faults for every 4K area for the write, this makes the speed
   up by using huge page actually gone.

So it sounds pointless to have two page faults since we know the memory
will be definitely written very soon.  Forcing write fault for atomic RMW
instruction makes some sense and it can solve the aforementioned problems:

Firstly, it just allocates zero'ed page, no tlb invalidation and memory
barriers anymore.
Secondly, it can populate writable huge pages in the first place and
don't break them up.  Just one page fault is needed for 2M area instrad
of 512 faults and also save cpu time by not using khugepaged.

A simple micro benchmark which populates 1G memory shows the number of
page faults is reduced by half and the time spent by system is reduced
by 60% on a VM running on Ampere Altra platform.

And the benchmark for anonymous read fault on 1G memory, file read fault
on 1G file (cold page cache and warm page cache) don't show noticeable
regression.

Exclude unallocated instructions and LD64B/LDAPR instructions.

Some other architectures also have code inspection in page fault path,
for example, SPARC and x86.

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/insn.h | 20 +++++++++++++++++++
 arch/arm64/mm/fault.c         | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

v4: 1. Fixed the comments from Catalin.
    2. Rebased to v6.10-rc2.
    3. Collected the review tag from Christopher Lameter.
v3: Exclude unallocated insns and LD64B/LDAPR per Catalin. And thanks
    for D Scott help figure out the minimum conditions.
v2: 1. Made commit log more precise per Anshuman and Catalin
    2. Made pagefault_disable/enable window narrower per Anshuman
    3. Covered CAS and CASP variants per Catalin
    4. Put instruction fetching and decoding into a helper function and
       take into account endianess per Catalin
    5. Don't fetch and decode insn for 32 bit mode (compat) per Catalin
    6. More performance tests and exec-only test per Anshuman and Catalin

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 8c0a36f72d6f..efcc8b2050db 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -325,6 +325,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
  * "-" means "don't care"
  */
 __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
+__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
 
 __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
 __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
@@ -345,6 +346,7 @@ __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
 __AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
 __AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
 __AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
+__AARCH64_INSN_FUNCS(casp,	0xBFA07C00, 0x08207C00)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
 __AARCH64_INSN_FUNCS(signed_ldr_reg, 0X3FE0FC00, 0x38A0E800)
 __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
@@ -549,6 +551,24 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
 	       aarch64_insn_is_prfm_lit(insn);
 }
 
+static __always_inline bool aarch64_insn_is_class_cas(u32 insn)
+{
+	return aarch64_insn_is_cas(insn) ||
+	       aarch64_insn_is_casp(insn);
+}
+
+/*
+ * Exclude unallocated atomic instructions and LD64B/LDAPR.
+ * The masks and values were generated by using Python sympy module.
+ */
+static __always_inline bool aarch64_atomic_insn_has_wr_perm(u32 insn)
+{
+	return ((insn & 0x3f207c00) == 0x38200000) ||
+	       ((insn & 0x3f208c00) == 0x38200000) ||
+	       ((insn & 0x7fe06c00) == 0x78202000) ||
+	       ((insn & 0xbf204c00) == 0x38200000);
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 451ba7cbd5ad..3dbeb6069fbe 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -500,6 +500,34 @@ static bool is_write_abort(unsigned long esr)
 	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
 }
 
+static bool is_el0_atomic_instr(struct pt_regs *regs)
+{
+	u32 insn;
+	__le32 insn_le;
+	unsigned long pc = instruction_pointer(regs);
+
+	if (compat_user_mode(regs))
+		return false;
+
+	pagefault_disable();
+	if (get_user(insn_le, (__le32 __user *)pc)) {
+		pagefault_enable();
+		return false;
+	}
+	pagefault_enable();
+
+	insn = le32_to_cpu(insn_le);
+
+	if (aarch64_insn_is_class_atomic(insn) &&
+	    aarch64_atomic_insn_has_wr_perm(insn))
+		return true;
+
+	if (aarch64_insn_is_class_cas(insn))
+		return true;
+
+	return false;
+}
+
 static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 				   struct pt_regs *regs)
 {
@@ -511,6 +539,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	unsigned long addr = untagged_addr(far);
 	struct vm_area_struct *vma;
 	int si_code;
+	bool may_force_write = false;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -547,6 +576,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		/* If EPAN is absent then exec implies read */
 		if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
 			vm_flags |= VM_EXEC;
+		may_force_write = true;
 	}
 
 	if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs)) {
@@ -568,6 +598,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!vma)
 		goto lock_mmap;
 
+	if (may_force_write && (vma->vm_flags & VM_WRITE) &&
+	    is_el0_atomic_instr(regs)) {
+		vm_flags = VM_WRITE;
+		mm_flags |= FAULT_FLAG_WRITE;
+	}
+
 	if (!(vma->vm_flags & vm_flags)) {
 		vma_end_read(vma);
 		fault = 0;
-- 
2.41.0


