Return-Path: <linux-kernel+bounces-535903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738DDA478C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9A41886284
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738D22689C;
	Thu, 27 Feb 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hsZrVwIo"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7B226D06
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647508; cv=fail; b=psu2amde3RXYFc+B78ok3lBWtY2K8RqYGEiY+3MsPjaIEw7t6z5qe62NYHq3WNVy6cVo1xf+33PKkcnEs4eTV82RAz6w7ren+t6OBQBfIDH5mNflpx3EfHQllQaQOSCzEpSwZsUy/Y3uxCn6IPiUyXFM05nE+GgMvKBpuvZDFYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647508; c=relaxed/simple;
	bh=HpuK3GAZmLHyjXP96W2vunbwIFOK0EdUn0PMMqtIU+o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=klCpwi+mw1HGQmIjB0V1i5fggWVcWAX1UYiOuA73wsRYLsOUi28JsjKBDTywRvSwghTa8X9UPSSWAlVA3O9+tZi3dXoMU7u3I2sOTgTowsP7ApAfLjXSy7+7XdJQ9ApDQDKBtng7zH9742aEFNIOGHukv92/ljXbDKK/YDBQzo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hsZrVwIo; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/qFcD/25jpx1i6zeT5cK9Rdk0qR0xDY7rCUyxxnu12cRZHj8vTKUxeok2Oo2qHN9WSalrRbwC86YkO0Ec1OJZQfPq3g+eEPJtb72N0mCA4PSvaGl0bpJInz4L0+32YE+ZpePaZ94TAE6bDtdfnyI4iUzPQFuH7i2bWx3o8iR2xutDmm3gAGXrPw5p28R73526dkLLwJ7dJ+1xTM8LB+n5mn3T+1yrmx5Kc4Z1JEh6Jp3dkwpP5AUq4UHxAzZFKvMCzXONuOjs+LCzByu2tCenRIdKOM11r+PXnl+2Irq6TZYjEmZfT0Nr7AGKQcBEpWV4681wKRwFjElFxgBmOcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33XYuNpKQKiPJkwIHqPXV1JnMfg4mPvuX1KiwA8OKyU=;
 b=yLusOmS6ucGMp7dTfQfPM2Ioa9GVxrvyZ3Y3uzVGkdLJKQr9iafls+LkdnUKVge/RhmN2T6fs0zr9Ml8ieKx0tITUs3eBSeHZZP2jyu69F+IGvC+tff6QIp81hX8OQ1pVcz/+kaTIPq6cvpI2906w8bngiEfP250R9U8OO/KKkQ2D6L7Vejq7pFjbmbIrw7pvpLqUdv6UHnKrJEvChwSvqeteUeiGHMoL/E+6lIv89ku2syO0WLL/Eo4On9A2te/8X0Ev6K6B0tCVJ/SjSx38zRHzb3WEmPex9oGUuiDEPRAWh3eBvLpCNO0rHTqzEjiZMSp5Rw+EDWWWMHwGtNA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33XYuNpKQKiPJkwIHqPXV1JnMfg4mPvuX1KiwA8OKyU=;
 b=hsZrVwIoa5BUeQobFoS+Jd3ee1pYNZcYAYbwCF7XtsPBBdWwd9fzdKQUas0Vjvcu4dtcgMgAo0ujddULftAqmb0qLLu5GkP5tFnDT12U/yApyX44ghO7YMrbWMYKV4KUeMzrpiyxO3eXxZSitxNp58DAoatYmwcdp1buGvfcSBcTZuEfCUpjaf24Csk+kUMEAjRoNG/mkIA3px4I/B9fAPQE9sJb+R70BP4u5roTlIiUbaRF1QjcpFe0HcEy9YMjGT0g8Aayaf/KAdCzAizqZB71fSfATtN9NvF2h2No+kpZsvu34UAIIQpVi7KULpbad7ZBW939y52sKQfH+Fl/cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 09:11:44 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 09:11:44 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15] tools/sched_ext: Provide a compatible helper for scx_bpf_events()
Date: Thu, 27 Feb 2025 10:11:38 +0100
Message-ID: <20250227091138.253809-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0435.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: a334f24b-6980-406c-ae6d-08dd570ec14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/fHk5tTzttG30uBXwxz46GRZ89BIBn8Ro28yOE+dRmma3WhFoEm4/9ukqPsT?=
 =?us-ascii?Q?ye3RZP9qYElsW3EmZ9fm7xKq8GJUI3nJYmPntnu+lhdpHDAo9EVlv53PoZXC?=
 =?us-ascii?Q?wsfdYUwjycNehLEPBVdEFGVsqIQJAF1BxWz42469U+Xy8RFSAIykRFRbFX3J?=
 =?us-ascii?Q?ftK2jDUJpNHCj/Us6LhTU/etQ33yBuA9KpkPPiqz5q8LqXC3zG2gHwDmHxYb?=
 =?us-ascii?Q?t7E0Bhr9/Kfx1GmCyrWmrOI8NUyjYcys0AP0rZl2xrDDHzGiSRqa1dq0ixD6?=
 =?us-ascii?Q?RpvB1fSJPvKuPYYKxPz5qz2LuJscDmG2Nw/8tyiyEbtC+jIIjIynta7on4ji?=
 =?us-ascii?Q?nRx4/vW4EWTVUZ9CGYQ2wLJ1T4UUgMju8cc0njfWebqV8K/oI8EwyKGNT//i?=
 =?us-ascii?Q?+WkCqvSwFJbEvbPqcr6QTUUKmn3MA8vO9TCpkZV5L2/SVMU8k/EwU/V0+ATd?=
 =?us-ascii?Q?tiwi1Yehnq4w6DROZj6+A+H6z36bvOh3AykijZSALpk5BwgTgfVbfhIDh5cT?=
 =?us-ascii?Q?Pquc+4R7wyv8uKCOUf+q6jzh98WX5hCQCeRQcPw3PUdXSs3iiUkYdNiRs7JP?=
 =?us-ascii?Q?zYnLYd+7Yu+NUHppMGhmc+en3C9z6JnKoV+BqIXsdMCo/F5npu73J5OVTPtt?=
 =?us-ascii?Q?nECC+tg9Gt8HyrtihL+8J4crqtoe9dXdRbImS/oxiUUWY2BQenVd/kKERf3C?=
 =?us-ascii?Q?x2Hk0su61g/XTUJkty2dAHvYcPcBM2TotdshU7iveq/LZFR89hy+hq5RFHO9?=
 =?us-ascii?Q?1CJ31Npy1Q6nHxb8eX85GWSyjI1yOjwMYkxIYZcfzKZmBNaqMI7N5pelkvCo?=
 =?us-ascii?Q?2pnSuIS1184UGgVwCGOJ/Mtpplz+iJN8UI75/YfTFVBcQ0JZF3jLhrpmBhS1?=
 =?us-ascii?Q?Slx8JiYcEvEDBTW6oacU3dNOh4qaALqMZcopdTZpJuETOedM93Gs/Use5U1Q?=
 =?us-ascii?Q?oJUqjRuFQDQdMI5DiSSE/estLazGS2wVE3dCJLd90yqNz318K06wSFLTwkBl?=
 =?us-ascii?Q?1V1tHa28Cq/hrm/LdEgY9uydktdfW0yfk9n+oGp9QxlUXkFcUiy+WtIKG0Ds?=
 =?us-ascii?Q?aIzSToEaJQnLLje+orNxF067eBm4GaIUyisNFoUyiW8tWuh1gnHZV4YYmMj1?=
 =?us-ascii?Q?R+1LLY3onQR8xvVwRCqugU0JO/jwodRZhDeZKf/QoN5yfqiV+AzPaSpBskOF?=
 =?us-ascii?Q?2k/zVjK9HVnRnIYVNqhIR0F0J8NMM0R+WqyQQLUutDhZFeiVT5sW6nbTxEPA?=
 =?us-ascii?Q?oI7XiV9R9LcWbajUNEKlucr3gDyCiFavNzWsCdjkUkb7gfLIjVgKsYFrC6yx?=
 =?us-ascii?Q?LyQMvEBx3uMLledMVVkV+kHc5toBrKY7mNW5UtwtApjlW1KM0yMxxR71sdwv?=
 =?us-ascii?Q?KC9OOlhFjq560H1vjulLpi52fZMz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kIebvi09ejyeH0WM5R33JqEMKVVEahbhPoTfxv+VFozZ9CqT8/212OeWieiz?=
 =?us-ascii?Q?8y4E4vWLAs4uHmaUVRMPcuzDd0ZgntEOx3Gu743t4eFgCOceNMk9at+/iU4g?=
 =?us-ascii?Q?D37oSD9ci4eqQhgp9G48yIEbeMcem1PuzZJpZKTXrjWgTKizVSRwHnDPt8ZY?=
 =?us-ascii?Q?6BGCMgLqWEfy/EyZIkPt8nGByogJKWeXeZ7QoYsYGgrgH/LQp1KoT/ds4am3?=
 =?us-ascii?Q?G9M5PTaX5i+cGz/yF09Y9HRykIO9PGW2xxERg6VT9AXGfdxf6cMgyJhq1ilO?=
 =?us-ascii?Q?s5wf0yuxGnHQRq8Otuzix4IDGPjexfSQzi90qgGkScuUD6aT5nZ0Jq9EmH5m?=
 =?us-ascii?Q?Y8FAYxFIpTiNCkqA+ge5xWolWL199puG5xvCXd3HPbn9k+862AMDhNYWu69B?=
 =?us-ascii?Q?SZ4+oxqq5gnJpyNr9N7go6XPmvyydgD2jAX0Gvsf9O7/YZu1VxJhkjV+E/PZ?=
 =?us-ascii?Q?gKceLKPVvQE2xGfzWO49/jkqoQx1tNDVuWBScVz2mZfNQujFv3sPd5aC9Zxk?=
 =?us-ascii?Q?zuWp/zB1IrPORub1m1UFjLlNGpEA1qfQ6zlO7k7i23rzCYDp0OHkA+AjLCGl?=
 =?us-ascii?Q?jlCIQzj1msA06HZMdHArNpkCUxxKe1HtuuRdk8DcBo7dE7LQfKp8TSt2cPU6?=
 =?us-ascii?Q?K1wC3MV0FVyJTIjvnuwOGVTWlUlKKUpFuJiunlEHfxeMHqyQVv0sr2GD0i39?=
 =?us-ascii?Q?RzMF7Y1eTXH8du/3lvxL/NmQyXpv/5eb0c7C8tt2rqZkwJO1gnIltf8SZnvu?=
 =?us-ascii?Q?pzrUICFmLH/NCYCmTnJMWsfDONuoVNcDGpg+TfvfmR/ThpkZoaN1IZ5XC3ct?=
 =?us-ascii?Q?ZxCj1Z64ivfHEslPodAtR5HmQjgDGxd1Qol2fS6VPKgXQGToZ32tt2cc7YB4?=
 =?us-ascii?Q?HgTjSpiGwObzj8SV+zpz1Drn+BAqByQuBoYPeADStSoSQCvdYq1PIMzl3mI7?=
 =?us-ascii?Q?yLeStO9pgZDHRVQDojSQrexC+OA6wMQowyDAkTvmSOViLZgZWzccQNIFSy9g?=
 =?us-ascii?Q?NcC48JvBxMPzbfuVALOPea8DfM8W84zYZXAn+PEnPDBmhZSjR775pGW71FRJ?=
 =?us-ascii?Q?te8T2bnGXL8y/+6UJBWCz29NLsrrGrlqu/UHCuVhkoynxZJ9kmZp3SSatVfO?=
 =?us-ascii?Q?K3q2oJAQMUNaSaySpyOZKVQ9GHd2+iDi10mP3Toc+XMFJ4a3mkpQE9Ow4AJK?=
 =?us-ascii?Q?/N/7749wGzqH0IlPzwar+z1sW+uEms76u5MWR6q4jcEAk1BNjmBo4gmfFccT?=
 =?us-ascii?Q?/+QuUkLyeHfirfufvjKG/RWeEBmhAfK1Q/RTlfbVK/wQfUTcsJeEUyQOx3vC?=
 =?us-ascii?Q?JofDIlps5YHqje2YuB2eEwv4K6gVnXGtPt7Y0eqy3VXjpe5CPVxJujZmb0Rb?=
 =?us-ascii?Q?UOiOg5rusmHqx6BD88U74B2h39Wv/SWN+7jfMWXtiCZTWAEvK6MfUGr6vndC?=
 =?us-ascii?Q?01jQySzPfGsKu0DZnszTRxlXtYS5lsYlrEDdYc1V4I1BLLOOFzK2Bi4UOwqU?=
 =?us-ascii?Q?EsnXrw/KqSaZImhyGXT3AP/GFs0JIdvJAzKYQ6VDgcJIYmH+fISfEVuTzuo3?=
 =?us-ascii?Q?ufp3X89bqpwcXihG9Mlv5XkkJGrawPOQYSlE+kle?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a334f24b-6980-406c-ae6d-08dd570ec14c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 09:11:44.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruCVaWHTOA07QLIH6Nr9WB8U6iAfkV6FJ9joO9FWo+sfdvfGmiu2l+6vaUtPz8HGMfYn7rUx1NfpzM5N9valwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

Introduce __COMPAT_scx_bpf_events() to use scx_bpf_events() in a
compatible way also with kernels that don't provide this kfunc.

This also fixes the following error with scx_qmap when running on a
kernel that does not provide scx_bpf_events():

 ; scx_bpf_events(&events, sizeof(events)); @ scx_qmap.bpf.c:777
 318: (b7) r2 = 72                     ; R2_w=72 async_cb
 319: <invalid kfunc call>
 kfunc 'scx_bpf_events' is referenced but wasn't resolved

Fixes: 9865f31d852a4 ("sched_ext: Add scx_bpf_events() and scx_read_event() for BPF schedulers")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/include/scx/compat.bpf.h | 8 ++++++++
 tools/sched_ext/scx_qmap.bpf.c           | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 266f94fe479b7..9252e1a00556f 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -183,7 +183,15 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 bpf_ktime_get_ns())
 
 /*
+ * v6.15: Introduce event counters.
  *
+ * Preserve the following macro until v6.17.
+ */
+#define __COMPAT_scx_bpf_events(events, size)					\
+	(bpf_ksym_exists(scx_bpf_events) ?					\
+	 scx_bpf_events(events, size) : ({}))
+
+/*
  * v6.15: Introduce NUMA-aware kfuncs to operate with per-node idle
  * cpumasks.
  *
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a6c6be308315a..45fd643d2ca0d 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -774,7 +774,7 @@ static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 	if (print_shared_dsq)
 		dump_shared_dsq();
 
-	scx_bpf_events(&events, sizeof(events));
+	__COMPAT_scx_bpf_events(&events, sizeof(events));
 
 	bpf_printk("%35s: %llu", "SCX_EV_SELECT_CPU_FALLBACK",
 		   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));
-- 
2.48.1


