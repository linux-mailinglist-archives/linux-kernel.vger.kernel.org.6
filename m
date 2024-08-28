Return-Path: <linux-kernel+bounces-304646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45222962324
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FF5B22EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C9160865;
	Wed, 28 Aug 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FqnrtYjv"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020089.outbound.protection.outlook.com [52.101.56.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2615F3E6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836371; cv=fail; b=KwEtk1TsY6nr6qEdV9+oCYoBAhiVlp5U1s3B7B+/X0DMfG1dzqm9UAoNGqins+cyDPcfV1uWr/V3fR4LwFMsaRMzBNrbEcaQLUMm/HFzJLhfTGFEwrcp7EgqjDC4uZS4Betw16rDWMUZsak0py+HNZnTK6mYq/uHjxOqH/PhvLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836371; c=relaxed/simple;
	bh=+eaRXs59vAbNxRm9w8QCxsMolM4wPWG2u0JXluVXOoc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ui93NwIqS+xcdHp0tOSYlBJRV32nJECQmZWQgDbqeYPT1DdYAlXOeYuwgXj/ctiaM9Vc9lUQjZ6iBINxgqDOmKtzhIWXxPyuLzzIj/7fKDYzAD2gUXUdskQ82Wtx10TdVfVZ8bdgYyduVDlzQA04JiJ/XxNW7nSt4Sle9uYJ/LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FqnrtYjv; arc=fail smtp.client-ip=52.101.56.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtW9ih2cDH+wAybslSU2n8nWpT2fdn+D235g0QXaNwlTjgDyHS4+IXEcNXoBn1joio8nev8YzNuLMaBGo3X92kO43zrT0V2lPo393UXXu/O+GricNEwr9oT6El8hXqNHR5wyT+wkb+iuAHjiUHR1Iz4D3EV6RRBvEEv41ZtJmjJPBAEpTy1iUbTkkRuucXYP96BIOx2oq14/lXpDt72uG1l+Itqu/72njveQYNQA+dJ9vSgaQMXW4aCHq5hPuyoYpkC97Mo+vMslJVu4as6Q23zAD84nM+yrqhW4+nBGntqIsWpESBFY559r73t8uHh9gpbEHV2e6ixsFKCgmXAPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vLLPXDpCmxlvD8sAc9e5Sp3a4fghmnLfQ1VhRSG5SA=;
 b=Alq/e5RhKKEaZf9mOFhLrkSXMKpYio/d7rCP6avAzyNnt4Othpno8+NUMOMdF2Gu/mqx6KCYzEWIlDKRIVi9i6GgepkyMFxRpsqfxHw9nbJaQ0LOgF51ooTF+VF59diM6Wq37hZcz+B1iGBoE8KLf3dVtiKKr9yeq82pMHo2XD/Syt1RWn60jjij7fNoCrOyWSb/0J9uZTxLahic/Yxpyzwt+jCQhb5g2Z2qug9yRxarRyF05j+MdSn4/K4pS4PPl2enIIGy8uGO+hDTGQ6Dk2XLyg6o+ncQo+qlVNNRRVq3VIFYx8OuqCB/rdfQ2HEz8oxnecl3sdBggUsbLYKKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vLLPXDpCmxlvD8sAc9e5Sp3a4fghmnLfQ1VhRSG5SA=;
 b=FqnrtYjvq3KN+GKlW7LIGekGnJx+4h8kwxaExMNhTeh3XwGgZZ0jrDyaPppmKVyt2nqcVuuxMbOK4KsfNrBcJS7JVVoaDgHPqgKWj2mKRQgRV4EF2164BeGhfOGGwsgp4k1o0ymTwx1TGl0CRa/l2TXpQ2/uH/KlU52Fy8CWNZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CH3PR01MB8444.prod.exchangelabs.com (2603:10b6:610:1a6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Wed, 28 Aug 2024 09:12:43 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 09:12:43 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com
Cc: patches@amperecomputing.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	vineeth@bitbyteword.org,
	bristot@kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2] sched/deadline: fix the hang in dl_task_of
Date: Wed, 28 Aug 2024 17:11:41 +0800
Message-Id: <20240828091141.12043-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CH3PR01MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: e515a008-0650-481e-6b71-08dcc74192a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLIIySwsFmc8OdxqXrxWIXjlXYZy6mLLG7U1guCr0YYXEX9RojAkpN/RxYkU?=
 =?us-ascii?Q?7DHkEDkCjTh+/2JIgt8bWqezBjWZ0rDZpLJbIVfBuq3ZuJVkKEsExYb8DHrA?=
 =?us-ascii?Q?FpZ9qzPL8e9li35N6kJuLkLMt+Jo/UXcQvaJvxLSnOwS5OJGp+zMtowssZ01?=
 =?us-ascii?Q?+qmitF/1HoGwuIT+WlGxAFTUJ+Cjl5prjTV59e7iZQkohMtRxZKxU+3IIsz6?=
 =?us-ascii?Q?EgImcvF52d/gWHKmPB2zyJ1S8BPzJzQ5/OHAv+OJZKuFyy4BWtmdJgysC+XH?=
 =?us-ascii?Q?octoof78giJsbZ632la5xanFygYuJXzGZxvALr9D1+UC1ZfofOiOW9h6IKng?=
 =?us-ascii?Q?Bf0pu4ssLzSqthe919Hb09H8cWaNcH6z+Brwikn4k3U/H9UJtyihIOWZ1ZuO?=
 =?us-ascii?Q?T+JIi3LHsPujJ1a4MQmDzGR4X6OiA7CHhJ0hOTk8WbgY6RrH0oxMqYkLBclI?=
 =?us-ascii?Q?6lMBzJZUr/xv+tKUKVBRG4RB4lzI+LmikgTwyzzYgVRvXhBMeR0iOXy3IsTJ?=
 =?us-ascii?Q?O2NfeDD0iRLOT+gdFRz1h5QSq2+ElrANbVE8Aj/tEokPPRCOc7M0lcAoAlEM?=
 =?us-ascii?Q?QJ9U89yEUyZXW/Rl8FRax4GPjfAy61gB283YLrlybsz1lYRtO6N7spbxonEv?=
 =?us-ascii?Q?lYaK0eR5b2Zp2ARm8BdgO3n4UbFsCK8n4RTl3MS47YfWXuY134VOpfvrW1PN?=
 =?us-ascii?Q?DcPlVrv2TgtwmFrMrlWzzDcHPbthiaqcRfr3ZnG5hwBakNCYvul/ZZ8vTw8X?=
 =?us-ascii?Q?FFLeMQi3vcdDlw9oLpSXtW0Aw0MpMM2AvceAxr8Mlpg3qB5MlXbs8qx71vr2?=
 =?us-ascii?Q?u4dyuCvZNB7AyaTqma67orqtU6J58Lwmz/oK9oNhlH4DCuJPpe6eC7XtL9Qs?=
 =?us-ascii?Q?DvdTM460TzdYhM9E40HRWGngETRQQFV77kme0N9c17SK6Vuh9zWfRDnQRAc3?=
 =?us-ascii?Q?cN8TiUyWcaJWMLAagtdQKHoyppdgxjW6x5AUmOnCzKrRFZYnxlazByj38MJQ?=
 =?us-ascii?Q?J9i7xj4iYQ7lW9gc7iqch4tLMPXCco153rUd7OZICsIerMi9zjZrxasHmca5?=
 =?us-ascii?Q?RWOiQRw0muv+vxcPZcVmlercJA6ojFY5Zr7rDMJgTciQKPmPFpF4+SfTEa4z?=
 =?us-ascii?Q?6E/BZcBYUmm0VqglmYU4spO01oH3zp1QWTL8rJDGtq72EB25D2Fg9KTaSMH6?=
 =?us-ascii?Q?XfjtRMsrasjcfd1ODX507z0dwd8hpF4N/akxXLzMA7DYxJMuqU8/kR/tI4bP?=
 =?us-ascii?Q?1jHuQEWxbI56dFbiEB4lKirT3n0/o2+3hpkBVbZVcjO09nS16hNgLVAFoV1M?=
 =?us-ascii?Q?SCTsZhKNhHKarus4wVFfup6FfOhsBGR+Hf3cepdhv+X/JwrrahWsog3zGJ8A?=
 =?us-ascii?Q?Aeg0eqg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3wD0MIDXYSYfoEKoxDtWXokttdRLj3jtEh3M0FAXTFUkBZb9Y3l055aXLki?=
 =?us-ascii?Q?yAkP8+XFcvOZUUUZWe1HDE/3/k0sCyZAZe/BkP3qXMdfx4CJIF3md3U8YzQm?=
 =?us-ascii?Q?TNxJhJXhbvJ7Lf+emEL9NJVqV6Pro2D8u/AHFBk88gSj8ym3nU8C8kJF1j4I?=
 =?us-ascii?Q?IbtgdwSq8fNhSijBm2wKF5LSB6ZiVCTIfHaUTanOKsAPIIu1TnkQGRbJVBF6?=
 =?us-ascii?Q?dU+re1TQ5Vqg6A89M3NAricXPFvjEndJzAEk/n7eP1AzRkAdpmSiGGbMhgUT?=
 =?us-ascii?Q?j1xGbZad+y26g7UbpnR9RIoqsf+zQ1Rg2JWc+UGl0rv2c8f0RJbf5VXITPN9?=
 =?us-ascii?Q?wHOprp5b+yMddF5HX0UDMCRyBnCiTF2xR7T5xs1Fu9e8gG/erFwTCX0oPgmU?=
 =?us-ascii?Q?BrF2ORvuytLosXFRMzJgtCeubHuMrYt/p63acs7u35Ia0Bc7UT4jpYbv9CDp?=
 =?us-ascii?Q?tsRdKmkiDLvNdxJsuGNdBaGa5CNGRadK+Fc4ufgw1X0WCTvBrq/HQF4GSZjr?=
 =?us-ascii?Q?MtX0XB83cpPpV2+wDLG8KAH3gmV48KJqO9GX2hg6VC4SQZK0LlR3Z3zq+cYM?=
 =?us-ascii?Q?THcBGTfXjjwebOsqr34tSzKtauhbk8R3ykyZz5QNpsmR/dChJkQMMwdBlamj?=
 =?us-ascii?Q?JQYHkM7Z8kGukmZ0NPjJE7iBKg3iYtQhsOu2OAkOdEYwqm/Y9xDrbygYD+ov?=
 =?us-ascii?Q?cu9w+BHgLsneCmks0GhqRDvFpRUKbmTCHoxTJBjjFjG0CCHMXI96CE4jAMiw?=
 =?us-ascii?Q?JoxeWooLvqcfpa0wDFUPPvS6ichjmzdcWZ3mIssd5GJKv+vlUY/oxETU76Iv?=
 =?us-ascii?Q?sq0OchRnEo6GzpW9ZWO4IRhuuo9dUMmZbn2d6MD3sN5M0jUgWu8KPwCs/jCz?=
 =?us-ascii?Q?RlNhLN5B9RJUem1v3AUYOXQRdIY2jgIQv/iQErh3O79ahMu9v8z8yD1/tm7X?=
 =?us-ascii?Q?uz8gQ0hapSlxhcYsbTFtsERaz4S7//xE0KtdzELwuXxlh8zC91qb3cQqWa48?=
 =?us-ascii?Q?bK/Orw4sjeu3ZRtJIAKhGsZrMHE5H/EtVGvfGOIqhqCW+7KvbAod0qe99yhG?=
 =?us-ascii?Q?z1+q+WyOUknGzsdTfMowlzniJc/lI7UARvr/Q0VtlTZOAFxNW5lEkXlgr4/5?=
 =?us-ascii?Q?7c+xqQDNSJk7/rgabWXHwuGp2PJzoj6qJWei/zPPCTTt/RcJ9wH0luUNDiqY?=
 =?us-ascii?Q?6VK0MAom9Egay5vCXxtgWW24AsHBG5QgzR8ZYBna2yVrtshGdrpgSbg0tFVk?=
 =?us-ascii?Q?lNOSvSUnNu7uZGlrsy5TO5UanYxvyBndBueNhpHAMVmq1HszHMGKwCTX2/IT?=
 =?us-ascii?Q?hYSYLR+Jn1xwa+AS6RTEiIvHb7TwsipFUR3zwNV/WusD2wRcvhNM2JkefDZb?=
 =?us-ascii?Q?H0rAwlvh2T0d23pniFiu7oSYTueAMXgp1YLg0H2k75NPaHZ18siLKgrYvdg1?=
 =?us-ascii?Q?U3fGtH1Qs7IbIbJ+9PlV8iBqijkS9ZFJ0ITgOYB0wAquvuB2cyzsWUw2LoWw?=
 =?us-ascii?Q?JFddVu2nINhvtvG6Z5dxr0XPaxe06SYnDRtlkIBzIoC0wYLZQnH+B3TmuLFQ?=
 =?us-ascii?Q?u6kRkZkqoVNaU/e2nI0Jnr+47ggLwWz5sWezIVmTH8K+9xo3mc1ynBJi4LWc?=
 =?us-ascii?Q?UcPpA+aQXLmm1LUj7p8L99c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e515a008-0650-481e-6b71-08dcc74192a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 09:12:43.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEblhLuEJuANdR/KpjVA0ENA82t5yyyDF6K3AtkojgCcYXyrloaDWdTWgnBBNJeuUfzZ4fysBreBgM7Eg+5U+G1OIPDcdJDel3S/mCe3P9BojZYKqtvjOMaDXzmWOHTP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8444

When we enable the schedstats, we will meet an OS hang like this:
  --------------------------------------------------------
	[  134.104253] kernel BUG at kernel/sched/deadline.c:63!
	[  134.132013] ------------[ cut here ]------------
	[  134.133441]  x27: 0000000000000001
	[  134.138048] kernel BUG at kernel/sched/deadline.c:63!
	[  134.146478] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000001
	[  134.153607] x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000001
	[  134.160734] x20: ffff007dbf1b6d00 x19: ffff007dbf1b7610 x18: 0000000000000014
	[  134.162027] ------------[ cut here ]------------
	[  134.167861] x17: 000000009deab6cd x16: 00000000527c9a1c x15: 00000000000000dc
	[  134.172473] kernel BUG at kernel/sched/deadline.c:63!
	[  134.179595] x14: 0000000001200011 x13: 0000000040001000 x12: 0000ffffb6df05bc
	[  134.191760] x11: ffff007dbf1b6d00 x10: ffff0001062dd2e8 x9 : ffff8000801215ac
	[  134.192036] ------------[ cut here ]------------
	[  134.198888] x8 : 0000000000000000 x7 : 0000000000000021 x6 : ffff0001764ed280
	[  134.203498] kernel BUG at kernel/sched/deadline.c:63!
	[  134.210622] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff807d3dd24000
	[  134.222787] x2 : 000000028b77a140 x1 : 0000003400000000 x0 : ffff007dbf1b6c80
	[  134.229915] Call trace:
	[  134.232353]  dl_task_of.part.0+0x0/0x10
	[  134.236182]  dl_server_start+0x54/0x158
	[  134.240013]  enqueue_task_fair+0x138/0x420
	[  134.244100]  enqueue_task+0x44/0xb0
	[  134.247584]  wake_up_new_task+0x1c0/0x3a0
	[  134.251584]  kernel_clone+0xe8/0x3e8
	[  134.252022] ------------[ cut here ]------------
	[  134.255156]  __do_sys_clone+0x70/0xa8
	[  134.259764] kernel BUG at kernel/sched/deadline.c:63!
	[  134.263412]  __arm64_sys_clone+0x28/0x40
	[  134.272360]  invoke_syscall+0x50/0x120
	[  134.276101]  el0_svc_common+0x44/0xf8
	[  134.279753]  do_el0_svc+0x28/0x40
	[  134.283058]  el0_svc+0x40/0x150
	[  134.286195]  el0t_64_sync_handler+0x100/0x130
	[  134.290546]  el0t_64_sync+0x1a4/0x1a8
	[  134.294200] Code: 35ffffa2 17ffffe3 d4210000 17ffffb4 (d4210000)
	[  134.300283] ---[ end trace 0000000000000000 ]---
	[  134.304890] Kernel panic - not syncing: Oops - BUG: Fatal exception
	[  134.311147] SMP: stopping secondary CPUs
	[  135.365096] SMP: failed to stop secondary CPUs 8-9,16,30,43,86,88,121,149
	[  135.371884] Kernel Offset: disabled
	[  135.375361] CPU features: 0x00,00100003,80153d29,d75ffea7
	[  135.380749] Memory Limit: none
	[  135.383793] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
  --------------------------------------------------------

In dl_server_start(), we set the dl_se->dl_server with 1. When schedstats
is enabled, in the following:
   dl_server_start() --> enqueue_dl_entity() --> update_stats_enqueue_dl()
	__schedstats_from_dl_se() -->dl_task_of()

we will meet the BUG_ON.

Since the fair task has already had its own schedstats, there is no need
to track anything for the associated dl_server.

So add check in enqueue_dl_entity(), skip the update_stats_enqueue_dl()
for a dl_server dl_se.

Tested this patch with memcached in Altra.

Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1 --> v2:
   Skip the update_stats_enqueue_dl() for a dl_server dl_se
   in enqueue_dl_entity().

   Btw, the update_stats_{wait_start,wait_end}_dl has already had
   the dl_server() check.

   The v1 link: https://lore.kernel.org/lkml/20240826021115.9284-1-shijie@os.amperecomputing.com/T/
---
 kernel/sched/deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0f2df67f710b..cb9bd3a480dd 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2002,7 +2002,8 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	WARN_ON_ONCE(on_dl_rq(dl_se));
 
-	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
+	if (!dl_server(dl_se))
+		update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
 
 	/*
 	 * Check if a constrained deadline task was activated
-- 
2.40.1


