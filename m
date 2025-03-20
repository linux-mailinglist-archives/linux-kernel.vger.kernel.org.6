Return-Path: <linux-kernel+bounces-569255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6083FA6A094
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72631896F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70B20ADFE;
	Thu, 20 Mar 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGWHgC6T"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE232080FD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456413; cv=fail; b=F3XRRHGHgTAG6fVwD0cejAGUSwWLQtrU5f6HEVDLJczs3Zsfd4dq7I0WhP9af7/XXQrVv7fspYhHZLvIcBun+/DTnuCzlKuOHRbINAP0dgOX0MGrPaoMqrjZFXX1c/ySk8Zak1Py8rCa2n5leeqSwaryjA+4+UuAj1NwkYVdIy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456413; c=relaxed/simple;
	bh=oL8zJvICipkWzywPC0I4qiDnvaUh2fpG2qX/5sfcwRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BX5xgJR4PYMCqJyOGZIjUPPymjeEwbZkUn3aDB6VGlUqTVBMry3gMS7aVrGFwh8hgQngXcJmOkgA3ABnm2tF0yg53SWVdHNpSoY5X6GFKECmldyuNjq2bXUFYrzzJeUGKCyKzSaidPolgvgdvxcVs5GUjVvYSSkzm5xdW/gjXL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGWHgC6T; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uyqw97PVotitaMw+AEQCeEe9JxPw5rLghCoXWP5xq9kqlHFbvJzZFx3WfdWvtCyUyY7/qT+XkAShDyKZzMupHF2Dr/ZxTB4bWFi2HvSYxd0Dn4w4zJyp5kZvkR8Gyhjl1y7Ill6B2t+nqYOesfvLuzEGHSq+u7YmKTEPLzs0YeXtmY91jgxOepOegIVORhduk6N3cB7W8LKQrvlJxLOxqGAgMJyE+rEsAJk8LwgtQw15AEeO+ZGR4hv0SbY9LvL2VP8720rS1RH1fsDRHuu7vQf95Yh4yf9/JE7tf+uCsA2tnX2AYGmbhiuwhwHMBi+YHtstfnh0CicVOneVpGJM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWukKYLx6dxV9P9+y9+WKEyqygay+dBRvMUc0FVjWo8=;
 b=NDafANeT7j30rRJLPR4xHElMJpRZR4flHN5ewIxHSdGPWEpj3JEZ9YnrQ0ft43V/PnklAYWwWAyh60X/raezMnttZwLfylWcZMbSDkFmlQXeUhKDNcudUGvk4K7JNEpIvapaKKf+yEg8LqfSw1CWINBQT+fa/N0SClZfDCsErDKYqnqvjz4opvwi78F11RE5/La7Mod3nzxF0ur0CusRHv/ew6tyZFf46MBqpG9SyAil4PrABc9b1acGTFcYRyUjJXVnf6w7izr/jtoHCzQ7Pqek9/bEfYnkfTc5rj46kONUAfhKNFfJsaxRqpTkqdhcbunbrbUlKZ0CH2s8qsPhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWukKYLx6dxV9P9+y9+WKEyqygay+dBRvMUc0FVjWo8=;
 b=UGWHgC6TsBaYOkrFMUumzMKsA3iBK7Bj2mQK+xlbRQfJy2h7RgVdd8NoRaWbAHRgPIOs9tpzmqQfJ8K50Bhm1mJHCHtxxN9y3bHl5KXcIJRZhFqHiOLTuZ7VuA9KY9WYiOZ1lRq40IsBsogrGLIXkVINJdt28kKVAyhb8jdVcs/u28uqXf5ka14HnXWt9PjJs1ELpAxIUTFhWObe7FIIzVJ/L8gKy5nKxX15DrxBrFow+aLnBKNhburJKuvk6VyllKlxOMfSfeTz+HJzi/S4qicTN30dbIAo1eJHPU3yw7pBD4rewD3wX7iNAJL+PjLWQpVZzpth4l3giI3wefGaeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:40:09 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:40:09 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sched_ext: idle: Introduce scx_bpf_select_cpu_and()
Date: Thu, 20 Mar 2025 08:36:44 +0100
Message-ID: <20250320073927.216147-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320073927.216147-1-arighi@nvidia.com>
References: <20250320073927.216147-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 903d12d6-b157-469a-8fde-08dd678270c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NgURrfxEa1nXDmul05bvQx5Q602b2WS5mLLfZi/7sG2ght7RaH55b6zFZJhz?=
 =?us-ascii?Q?yt2dPiT3CRC8idte7troPhyBylzOIyZ3wN5ofBv5kTIauG7C9RgomnDTFJ46?=
 =?us-ascii?Q?+M3aV09JUbxhBISrBI9iJaC9oQvbMYitv9m00u1Av3mvNaewFT/pcqAWfDo5?=
 =?us-ascii?Q?lR1AOg+jKTpHy6zVCqHpw8dIG3PWmUegtbywkiZLIWNenXoZVosN/uq9MHT5?=
 =?us-ascii?Q?IXbdfc16kkmZHvpBmnJA1i30pf264O/6JtmsaE6XcL6D+B/DAeIyoxHY9Z4w?=
 =?us-ascii?Q?VUeb4+poA5wJeB5Bw34u15/upSM1G9lkM3AjUWQPt6yVAGUTgJpCO/PEez6f?=
 =?us-ascii?Q?DGAv40eraMf15Pbho3XGrGJbDHY/ODrfEbBPy6hqSDAzWqM39lyk5BTQ2n+7?=
 =?us-ascii?Q?v/NYCNmw3j5tjjV/CRycyCaP/VaD6M2JVlGyLW9UXfcwKiUzjOJ6gCZOwUYp?=
 =?us-ascii?Q?pSjN+ofrMsBMC/Kk3CR4Dv4YguC6CigyaY9DNtnGCGGPJuBUNKnpCxxQ4Fd/?=
 =?us-ascii?Q?V2mni+YPfweGZIKXm5HarOqamzKdNZfGtCFq2JCApEXyJnx4DOL9uZoF5CfJ?=
 =?us-ascii?Q?OHp+b80D4ZhQbz0caU4WEd+wWjgcu+0AXlyJVRv8gky2q41/dd/AfmeWk0AT?=
 =?us-ascii?Q?cCQowh6AOy8cYOuGRcDh28JrulQh6OSVamLRP4LA6zAm/mDw4/gDRkl8lRot?=
 =?us-ascii?Q?tggu6G57dnKfqZRGMuRshjYP8+tqtJxpvxt8QzHvsQQMc+HtZwMo8lUNasJU?=
 =?us-ascii?Q?nziCSu5x49V01wFZ1yXRAhrr2g+3CVUjKKpQum74DzAX1caD7V85QMIvEFii?=
 =?us-ascii?Q?NjfZu/GLPH2yOJ7qx4ybU2ZlDDHQIE6xjgd0uhPuEduiYNieGyw7Q1E33F8P?=
 =?us-ascii?Q?73svv4nf4I8193lqUiLq4bC9VodWVZUpnOE/AOIF0LvRpW/WfnEMpABiuU5x?=
 =?us-ascii?Q?4Wl/uFCBEbxvjKf7meS21mfquHv8Sx7w9xVUbpIgAgyJFvyzbPv0xkunCXgz?=
 =?us-ascii?Q?MRJ/X3joQF+ytK2qgXa5Cwv99mstom4IQ/IHons1E7iK8SnCgGb+tcGW3C2G?=
 =?us-ascii?Q?NThXso0GUrS6xtx2xGDKdNVnvgiWD4FI2HSYcoo+/FSA+U2V5DGigFeTi3a+?=
 =?us-ascii?Q?J9qHlEkt2DnX1Yh6do0QvmBq51OvuuNiAuqVzF0/7eCBu5A1/RT3PK1Kdw0j?=
 =?us-ascii?Q?XiEM4jbpMK3Hdh4tSkjbJsk+0daLLyiciptXKlCW1LnVYAtoXUXDU2zp0iiq?=
 =?us-ascii?Q?+4YHmilJh04MQ9pj8v0owJ0Vw55LWZ3VhlG2EcfwHzTsbXp58BXm6w5XGeuq?=
 =?us-ascii?Q?SjE4JCYRugT+Z8mymKxvqfBITDma7Ys+CMkQodx4k6I6FnQln7nqsNwG1MbB?=
 =?us-ascii?Q?W8e/fsXPTGmUPP5TVLES3OTxOLaB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLqD4geiAIxniJ7fLlYhIgI5pN3salArKXhxIkXYS/rJY18SF/W3MmYMgmXE?=
 =?us-ascii?Q?/ptdkas/5cQwNwZ4AMWXGzKI56fC5CUKi9Q4vwd/6LE2PV0bN1Q+blXApNZY?=
 =?us-ascii?Q?dnnh3ueNJ7AlsF1SC9C0tDjlxK9tUw4vcN6yWBpazv+od6U5w7f2QijXFS7o?=
 =?us-ascii?Q?gx1HAsLvohaotF0FiawfnLJHMKxOJ/xeunutP71gNGv7rKllYJRH3TfAchQU?=
 =?us-ascii?Q?MuPlo9tnzc7UvErx9n8IyoWsU52lXl4skobeYvgp23W56z2lqayPO7slqSTu?=
 =?us-ascii?Q?A24THQMMZAvL3dTIVkxz8SL8DmHYhQLFuhIwInm24QrQUblRyjg8vgwlHyOC?=
 =?us-ascii?Q?XevEUif90a3cKrF1GhOkNUoXoeGUY/T98Y7irmP1ywffsxmyaxutd7jhs8En?=
 =?us-ascii?Q?KhdserL/VsBpPP380lhxqOoN3PC83Mce+OL3myWHUsrprwPbH/ur9X0Z4w+e?=
 =?us-ascii?Q?KchPVBJ81swq9DbHyjTFccawupmYIqMDEUeqWsubMpIFxcQKFUpwSLJrLkaq?=
 =?us-ascii?Q?7oQBOvVWgbauNSHO7s2IPIEiUUvuWt7o46ENtEDf2OoWKqWqlsyrnNwJxhVM?=
 =?us-ascii?Q?qXAwQIX6R9uNHWo/r1CZhrFv+h/SOf+g5wHSLJXXV8VII38B8lAqo+YWhOf1?=
 =?us-ascii?Q?R/6GGQ4Xq90qrdon8iwcXsoDYnQuKEeMiaUURcKFeEBVOmmnx/zQyPtLfTxs?=
 =?us-ascii?Q?T22tkAPDKlolCwN3rFeRiapEgl6CJZslts+J3Xr6HX7DUKeGbLWQLyMxMm+b?=
 =?us-ascii?Q?aRH/NqAUyyapO7InQdh9P50KXyocEuk3v3YHZfu4FY+5kSvf5BFPLQ2lwCry?=
 =?us-ascii?Q?vgQTCvfTyRaHBi6dX0bZNigLwzPxNXrpeJy6ThHAH9RuL0XzOmob7Qyhs5mJ?=
 =?us-ascii?Q?x4ARntVc8EL7peW0qarO+CQX8VYlkvS8QLylBc8TkBN12cSAMWX43HHpATav?=
 =?us-ascii?Q?aT8Db1TtorP1JNRD07BafHOgIsmRmD8wl4gTLoKse9QjJue+/CXYqsWOJz6e?=
 =?us-ascii?Q?EYZ5z/jGlTJWvUGpMmhlokfmDGhJOK2nZHj6X4Q5wfGd469XivYLoZL5CoED?=
 =?us-ascii?Q?kpsom4VtBkXNUl9x4e3df19+6nr0e83a0WAjLJ9hOxgfdUnI4N7/9MqM3NBm?=
 =?us-ascii?Q?YF8BZKFqt09X1b2wgluhLXskhja9Tff/rEbJLftb9Vdk+ilDR82lhIboeW02?=
 =?us-ascii?Q?Kj/jZP/PzrafWWS7RiaEahDkhJTjE79Z/Q2tjmnCXVIvd/4uUNQFbXCvNUmA?=
 =?us-ascii?Q?IDio5mLIvCvXZsDLLoZWN2EXTIy7jBLQ65xIBjiYU5xW8Aqd+q0npOBQS35N?=
 =?us-ascii?Q?Gce0dFkvL/o55HoNktqghJDlg1uN0tuUj0CNdnHnCMFnwQqxgj8cT7lcaG34?=
 =?us-ascii?Q?RJd6NQHKV0ZmcPGOR4EPVaL4KecQYdvtACesycKWht+HJUvqA+CHQXTcfvQ2?=
 =?us-ascii?Q?Pa0/Pq0ChKFfFYOC6qhnI6xsxhpN5ee0Ty77FxZe8h+w4FUosuEgqNYK6gnV?=
 =?us-ascii?Q?Kh0gCEKSYP7LUSOdSt0cdOBaPwiokxNUO8feAyC2uhs/NRaxGVypugSbTK1C?=
 =?us-ascii?Q?GED0CMmubnGML1rMPQyBPSzTS4Z5X8pze3EjNa0u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903d12d6-b157-469a-8fde-08dd678270c8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:40:09.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRG7nuX2Nnzd8ADLai+OcQGogyn430Zv7M0ATRGnwfPEl74uzJOLfpA1+qLogMzSCNtcyS2qUz0kxuG6CRQOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

Provide a new kfunc, scx_bpf_select_cpu_and(), that can be used to apply
the built-in idle CPU selection policy to a subset of allowed CPU.

This new helper is basically an extension of scx_bpf_select_cpu_dfl().
However, when an idle CPU can't be found, it returns a negative value
instead of @prev_cpu, aligning its behavior more closely with
scx_bpf_pick_idle_cpu().

It also accepts %SCX_PICK_IDLE_* flags, which can be used to enforce
strict selection to @prev_cpu's node (%SCX_PICK_IDLE_IN_NODE), or to
request only a full-idle SMT core (%SCX_PICK_IDLE_CORE), while applying
the built-in selection logic.

With this helper, BPF schedulers can apply the built-in idle CPU
selection policy restricted to any arbitrary subset of CPUs.

Example usage
=============

Possible usage in ops.select_cpu():

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

Load distribution on a 4 sockets, 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses
scx_bpf_select_cpu_and() with 0xff00 as the allowed subset of CPUs:

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

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across
all the available CPUs.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       |  1 +
 kernel/sched/ext_idle.c                  | 43 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 3 files changed, 46 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f42352e8d889e..343f066c1185d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -465,6 +465,7 @@ struct sched_ext_ops {
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
 	 * - scx_bpf_select_cpu_dfl()
+	 * - scx_bpf_select_cpu_and()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index faed4f89f95e9..220e11cd0ab67 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -914,6 +914,48 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
+ *			    prioritizing those in @cpus_allowed
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @cpus_allowed: cpumask of allowed CPUs
+ * @flags: %SCX_PICK_IDLE* flags
+ *
+ * Can only be called from ops.select_cpu() or ops.enqueue() if the
+ * built-in CPU selection is enabled: ops.update_idle() is missing or
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ *
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the selected idle CPU, which will be automatically awakened upon
+ * returning from ops.select_cpu() and can be used for direct dispatch, or
+ * a negative value if no idle CPU is available.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+				       const struct cpumask *cpus_allowed, u64 flags)
+{
+	s32 cpu;
+
+	if (!ops_cpu_valid(prev_cpu, NULL))
+		return -EINVAL;
+
+	if (!check_builtin_idle_enabled())
+		return -EBUSY;
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE))
+		return -EPERM;
+
+#ifdef CONFIG_SMP
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, cpus_allowed, flags);
+#else
+	cpu = -EBUSY;
+#endif
+
+	return cpu;
+}
+
 /**
  * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
  * idle-tracking per-CPU cpumask of a target NUMA node.
@@ -1222,6 +1264,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 
 BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index dc4333d23189f..6f1da61cf7f17 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -48,6 +48,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
-- 
2.48.1


