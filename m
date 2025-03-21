Return-Path: <linux-kernel+bounces-572039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A5A6C5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC93481896
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34432343AE;
	Fri, 21 Mar 2025 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OV2aTeRX"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E3233D92
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595309; cv=fail; b=Kgvel2mbVZmOlczdwmrKG0EtWywJsE2bVfHNYZHWhSUPIdICvtp2gnJwqmAMuCF75wb9KDdN22KoKqL8MAXM4mGS2+HOsDZPJqu9MbxcL2ABXdrIy3Jalg45UPHptoe6WoZP1hPnC0yBlSMdjJus5ze/sUTF45cnGFspxhMczp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595309; c=relaxed/simple;
	bh=5oKV8Dvz12mss296bCh95qkWa0i00TaPxok2H0i0phI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dt89Bbmqg7MDtFsktJWYoqG8nEuO+j4wRhV1soIRQDW+lfg943z/oF2Mdl92G1PubJ01tKE7PQmpCgCVk8Zyie3veSoQ8r1UJ+gnMaxCvBbmdQ021H7ckaxmrtwtqu5WIC4j298Um/OY+5x+ZFpeA/868OSUsK2QQO2CGAgZb9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OV2aTeRX; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0ylhX7QCOTFpnyzhGQW11EQl/n5Z0MzMN4Pp1bUlwGIX+7UxdU4PbSrd8IM8jdoo87fb5Qu4Yaz47OJ7dhYsGhDRrsqK84W6KKGwEVkjbQfBZXkAANrBiJyNZaQGkkGGr9r1IV9+7nUIJbR5hqnYmLOI8RFxbGCijqIgx5PfPj1OEFlxT9EwixWdlIDGtEU8h3eCTDWxkirOI1gcGfuex8Meruw5YiocCT6gvwI2DEi+WrhoQ2NclC8+AhNbwcPm+d20NNWJjQVgL07wh+83vlUDll+Y5gWUsMDSCjC3b6qTcBdF9w+y3VLiorAGrtVTHuZCUfWcUIaN4+fpodm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13QSUySkE9m0mljipzN+85r42PA1S44/nN+eHXFZZew=;
 b=ojhIe0Fglacu4ao8hlWbMMg6vtM306ZI9vfGkls+2o+5OHwAIqJTsMrEhRdHFJfAFra/EWlB0rCVynZ21Zh7l2p8yT4Q4EnhPf35OO6UUG9N/hbRzVckG1SKh82GROOQtiVfJxLY01eM38+YkPhAUJMlNeIBjt/4K+mcftA7m/YVqpxL42i4YhOnOQ3psZSTnjllkhUGyUISkM4yj6SrQTdZJj/G5r7SreKjMVs2PZzZtzueI26OPbC5yjNeFy06zRowVU3g/TmFCqD2BrE7mYTddW1DS54gM5i45SmadHpQsHIgtGdmLV/P7I83SweclxRtHGq/BBMpvvWmMpeJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13QSUySkE9m0mljipzN+85r42PA1S44/nN+eHXFZZew=;
 b=OV2aTeRXfM51D2fKaPrOOCSHZHZwl94C344qy3R4l/CLBR5Vi9Gbry9lYnC6zTzZuzjtJBz7A5GJKP6oexaZG1ICL6voi4kPPx2g3TIOZtdHZ4hSDLXRCe2iAGaZSqVToU2+4fSn+s8udAAEgQToRSYOvj9GtHJjTgIepMYyL6JFnaVtUavVcKWfxz2hDAm1X4tGFZtvZNl9vTLTLc62n9Hm1l0pJQ9C9NnGPi3MvruF+SY4zh0iFkStsaw37oO36c+uU75LxGg61PcL1At9xyJJIoiqgBRkSAJqCF+mIuyal7NRSYIwJx2GL301vqCtCsgyNsAvAU3JXUgatMTx9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:15:04 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:15:04 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v6 sched_ext/for-6.15] sched_ext: Enhance built-in idle selection with allowed CPUs
Date: Fri, 21 Mar 2025 23:10:46 +0100
Message-ID: <20250321221454.298202-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb32aa5-f119-48df-4a7f-08dd68c5d481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5xfxCi62DQqNG7tpdo8S7RU1r/JlRTH69Fg9XjrQU34MscTheDFyd+qAFtBj?=
 =?us-ascii?Q?zfnLD64lFmjxhO7ij8u+7hWhjgY7bsblk5Vy6LP1RkTRcDIOVTveVUJofl5K?=
 =?us-ascii?Q?azlpLX/Ysxc9oBwXTlG2H2D3cLgn/YUDgeqjhwr4cyOFJt3S2K/gW45FGenb?=
 =?us-ascii?Q?m2BMyPm6x+dCB45IBNgrTPk8610vdqqmzqvf5qMVIUZsuPVw3ZEncH9Qt7yy?=
 =?us-ascii?Q?jCr/zlhIDyV8Pf74kcMpxX8lTULB4t+H+Wn6JE0bsTIMbU3MfwFIRbKOXv9D?=
 =?us-ascii?Q?kR4LqYuDom2J5oyrO7w4wwfMnJzJ+2PeTStApmc9mt7HApY+cbHIHIuKaCrO?=
 =?us-ascii?Q?dqiMJ14Wuh21+SxB+0yTBZUgQmNLK3+7ze4Sf1UEJUKZhkSTW70gdodY5ZIk?=
 =?us-ascii?Q?IZPRlPoRPg6I17pA5IAiPdcXf4IAQkwJYNtDGF6CnEf2oLFrGAkU5R88s13w?=
 =?us-ascii?Q?y/+/HHGvAy/hInqkIfCRjdddtlOYGJpSNHFNNB6r0uRdks/dwo2eGiHtL1Fn?=
 =?us-ascii?Q?Rk8c8A5e4XmWLreM1ZHPv2J5P+vaE+lE5K/5x6Lz6Jt6XBMhjwC1pjLIjfxZ?=
 =?us-ascii?Q?RuHr37ucnrvZXqj3G9Zrg8iFUZyitWJm+kiItkG3civ3TTxz1XqGQS6g23TW?=
 =?us-ascii?Q?aSwuORfmp5XrHNzJaT+v2pIXD2OVAbT3KOXEHlL3ZqalZlDv1vGyvd5dlVPM?=
 =?us-ascii?Q?ji0giSyUXjQD6Rc/ntSSw+deuJGeKH6aaMTbkalakYbTuZZJk05cEY9O3VyZ?=
 =?us-ascii?Q?5cfAyr198JUtwV+/luvwPPke/h90gLx+ihQq1TDAoTPEBtIqgJhkkLgT9vM2?=
 =?us-ascii?Q?A4zz3NLNYT6OJYYortHDXRqV1Qm6kXU7MpTH5XqgrGjZvPamNNLM8PNjisNu?=
 =?us-ascii?Q?lXZvDOoPHS9VkE1cXmTsoifJ9rqt2G8y1Yc2+S/nmZHTjjHXMnZy0oUArW1y?=
 =?us-ascii?Q?mqSVTS8klmx2T+ocwOhm72t7aT4Xc7YNgtmWCQpI9vVpKvYS+N/VCqy1rcSL?=
 =?us-ascii?Q?bVHFEUilgEmYgL9kCtghhrZAHHeCuYW6MrVHs84GbD0T/PwQ8sSdbxaC/WHi?=
 =?us-ascii?Q?YWHKzR3ULQYDfgjIry5/icdGjJ6cJMn070S7imCdjTsHh14yZGZmIUBALmZW?=
 =?us-ascii?Q?PoX9wfSSL8ZgNlTz2ElGDmhMEfskyNf4RDArlsBW4z1zhpdTVgQvjWyHQ8oh?=
 =?us-ascii?Q?6VzaG8eaDIYTxpA7oYPearHenOXZtQpAB9BmsJTuPy50Uef7GUlYm9ElvWqP?=
 =?us-ascii?Q?Tt659rumePBU/hgsXp+fEZVajxcv8yeZKJ3podJiG06sg5Ivir/cSaBSH0YK?=
 =?us-ascii?Q?Rxz1ZzTTF3QipJ4mmU+ispo1DsQPva2QuWm2NQ39JNJqezib6rIGp+zfPiQX?=
 =?us-ascii?Q?1BpqMgdrGW1Trp3wThonyx66RCz0m6naiq64SyKDl3vE8YOhzjG11OomxTae?=
 =?us-ascii?Q?o33O7SXknNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1vkGs5Jy5WvE0qG06I1D1Mc71CtTSmfYw7eqWkhliNTy8KYRjTo8dE6N4OW?=
 =?us-ascii?Q?BcKg091Gex5xlBR2ytpGYbUBTcFXBx2AfdLhxzaljmuzj3U7IIV8dGV29+ZU?=
 =?us-ascii?Q?r2JDpYBm53CquUcU/ATFqXCX+Ynaa73G6lOShcktgjUC3pfeuTDqqhTd1nJL?=
 =?us-ascii?Q?iWJq6T287klCIZbDsDkv90VhcTlIAiWAHKuZ4HmMKstg5JZ76L0bsVhz1mMs?=
 =?us-ascii?Q?jAs62UW4SEL16UZBAVDKPfwwTOUg7NZjxMILN0c7NnRlThF6MBe/KKeYIzTW?=
 =?us-ascii?Q?9M8faUg6UhEekJqF6U7Ye04Pqj7YXm1ZIhpCgw6IHci3jBo/QT79d9W+1fF3?=
 =?us-ascii?Q?HFw3ekip8S3ayDeqhYFJTMd8oLfbAVtLQD1mNrQfxmUk2THY+ZJUkFpI3cos?=
 =?us-ascii?Q?5tSfCOpX2tCnTsbotGH50GHvETlP3Fxf1nOSnniykIykkenf3U0oYiFxrusb?=
 =?us-ascii?Q?vV2LkKYGTwnZr5I5aynL5aI++GjU/Q1WKVtu3KQgHmWWoXeVDfIJziPQGjmB?=
 =?us-ascii?Q?JwBMAJ2BX6zbtHBJIjDGJLgRwZJgOPc4ZRJUJw3N/1VNrbRuDP0SYanmfo/S?=
 =?us-ascii?Q?VgjeSVXNv7GYc9BDF0cj5IpgPdMcvOtpBXjsPpRel8KSa5bhe4UQqqbcoHYS?=
 =?us-ascii?Q?0GLgLICE5d6XTKUe94Hp5rJZwaKFYy8+nSr48qYRYyTIm5926m9UYjz4gql+?=
 =?us-ascii?Q?x9Iy+aULb1lO6MEaVvwXUyFg0IT5tQm7meRGDP8tGUthRBDWGhfiR0At6/tD?=
 =?us-ascii?Q?N5oQMOQuLM58BGmbZ55dO0dLenmrGFD6JWtnlCU5GACqeQvWb0BtFWmRuE5Z?=
 =?us-ascii?Q?Dm0vuTXPOuKjaN5SBQaw8RF4zLEJS87Y1nF3xikStgmgOoibqtJOvY1xLswq?=
 =?us-ascii?Q?ilsRsteMcuTNm8e0arW9Q0xsKAk+FZMFxXWO1Pdw+WtRq0U95lpFNRrnTbYZ?=
 =?us-ascii?Q?yXSxpnvP0/YWTYyG/th5rx9ZJZDj+iyByVBAVRAT6GUZ9/SwhjzpUSiPIbjB?=
 =?us-ascii?Q?a6wSmGdqSHnUe+7igZ4FWJAabE8630bjHYaMkLyFXgiNDVoTx1J/yAdN+S74?=
 =?us-ascii?Q?39WqxefAPY+SHhN1nZ1cjf3SpAjJcfkjjbIvO+Lt3oNgRQDVdNxFg6p6B8A/?=
 =?us-ascii?Q?kHIQxkyN2CJ4KnKbOCGozZqwK22rmJYKtSLUzXuZAYCJxxiVxYCzphIReBnf?=
 =?us-ascii?Q?elgfQZpHswL1rV9hQmTvLNy/BX5RntX4OV1bt+IBbjetBIiV8es1k6wdLdyv?=
 =?us-ascii?Q?1vDIvx9wUTBKDfW0wOBbgV7YE7gxs1/oc3qn0X0KIb6iz2/pekLuuBOTVGP8?=
 =?us-ascii?Q?740vqVlRLziyXxXBuUYbLZWMKD/xoWI83ANdBzEpO2VdIif88udfvxzfy0J9?=
 =?us-ascii?Q?ylTb23H+KgZHmlcLgq4efjHL2xT8l3eH06uLUAmZKvUh9BdbNMr0nYheo211?=
 =?us-ascii?Q?wd/vXm5AG8TAAz7KefJ6jZYa/6b7r0ADkbYeJrBPaRfPl7sF29CC35lMHnTT?=
 =?us-ascii?Q?2F4B8oCUpqvb/FARUzmmpqhaoPX1PkcEnIR3hWG+mfmRX60BGv7ThZd4/0+s?=
 =?us-ascii?Q?Io7pN3K/lJVNFlrqQQ6CRx3UAsX7cmEcyJtyRjKi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb32aa5-f119-48df-4a7f-08dd68c5d481
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:15:04.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSVH7b5HjSaJSa9F8rXleyEwSFZP970F/Bsiq5H2EtvpzZusrlld2PI8VYjpoiBAJ+qsrsQ9CYoEzv7UpWTG6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Many scx schedulers implement their own hard or soft-affinity rules to
support topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., running certain tasks only in a subset of CPUs).

Currently, there is no mechanism that allows to use the built-in idle CPU
selection policy to an arbitrary subset of CPUs. As a result, schedulers
often implement their own idle CPU selection policies, which are typically
similar to one another, leading to a lot of code duplication.

To address this, extend the built-in idle CPU selection policy introducing
the concept of allowed CPUs.

With this concept, BPF schedulers can apply the built-in idle CPU selection
policy to a subset of allowed CPUs, allowing them to implement their own
hard/soft-affinity rules while still using the topology optimizations of
the built-in policy, preventing code duplication across different
schedulers.

To implement this introduce a new helper kfunc scx_bpf_select_cpu_and()
that accepts a cpumask of allowed CPUs:

s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu,
			   u64 wake_flags,
			   const struct cpumask *cpus_allowed, u64 flags);

Example usage
=============

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		   s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
	s32 cpu;

	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
	if (cpu >= 0) {
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
		return cpu;
	}

	return prev_cpu;
}

Results
=======

Load distribution on a 4 sockets / 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses the
new helper scx_bpf_select_cpu_and() and 0xff00 as allowed domain:

     $ vng --cpu 16,sockets=4,cores=4,threads=1
     ...
     $ stress-ng -c 16
     ...
     $ htop
     ...
       0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
       1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
       2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
       3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
       4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
       5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
       6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
       7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across all
the available CPUs.

ChangeLog v5 -> v6:
 - prevent redundant cpumask_subset() + cpumask_equal() checks in all
   patches
 - remove cpumask_subset() + cpumask_and() combo with local cpumasks, as
   cpumask_and() alone is generally more efficient
 - cleanup patches to prevent unnecessary function renames

ChangeLog v4 -> v5:
 - simplify code to compute the temporary task's cpumasks (and)

ChangeLog v3 -> v4:
 - keep p->nr_cpus_allowed optimizations (skip cpumask operations when the
   task can run on all CPUs)
 - allow to call scx_bpf_select_cpu_and() also from ops.enqueue() and
   modify the kselftest to cover this case as well
 - rebase to the latest sched_ext/for-6.15

ChangeLog v2 -> v3:
 - incrementally refactor scx_select_cpu_dfl() to accept idle flags and an
   arbitrary allowed cpumask
 - build scx_bpf_select_cpu_and() on top of the existing logic
 - re-arrange scx_select_cpu_dfl() prototype, aligning the first three
   arguments with select_task_rq()
 - do not use "domain" for the allowed cpumask to avoid potential ambiguity
   with sched_domain

ChangeLog v1 -> v2:
  - rename scx_bpf_select_cpu_pref() to scx_bpf_select_cpu_and() and always
    select idle CPUs strictly within the allowed domain
  - rename preferred CPUs -> allowed CPU
  - drop %SCX_PICK_IDLE_IN_PREF (not required anymore)
  - deprecate scx_bpf_select_cpu_dfl() in favor of scx_bpf_select_cpu_and()
    and provide all the required backward compatibility boilerplate

Andrea Righi (6):
      sched_ext: idle: Extend topology optimizations to all tasks
      sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
      sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
      sched_ext: idle: Introduce scx_bpf_select_cpu_and()
      selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
      sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()

 Documentation/scheduler/sched-ext.rst              |  11 +-
 kernel/sched/ext.c                                 |   6 +-
 kernel/sched/ext_idle.c                            | 196 ++++++++++++++++-----
 kernel/sched/ext_idle.h                            |   3 +-
 tools/sched_ext/include/scx/common.bpf.h           |   5 +-
 tools/sched_ext/include/scx/compat.bpf.h           |  37 ++++
 tools/sched_ext/scx_flatcg.bpf.c                   |  12 +-
 tools/sched_ext/scx_simple.bpf.c                   |   9 +-
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 121 +++++++++++++
 tools/testing/selftests/sched_ext/allowed_cpus.c   |  57 ++++++
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  12 +-
 .../selftests/sched_ext/enq_select_cpu_fails.c     |   2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c       |   6 +-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  13 +-
 .../sched_ext/select_cpu_dfl_nodispatch.c          |   2 +-
 16 files changed, 404 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c

