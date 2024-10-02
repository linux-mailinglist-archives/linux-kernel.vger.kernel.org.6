Return-Path: <linux-kernel+bounces-348050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584898E1F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2CF1F2318A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70D1D1E65;
	Wed,  2 Oct 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FJHbpitt"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020115.outbound.protection.outlook.com [52.101.56.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF61D1752
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891734; cv=fail; b=pM292iMld2vRb6Pv0qRATCJgNgS71iVoD4KC5kQ7CHqvkuvCPb5pne/TAMwFkpjIVcbbE7YPSKvgZhPZhecP5Y3NhZEvUBFRqAsmA9FvgMf9l4lpeJ/kHz1PECJH7EN5G4L6Ch7ud/Gi2mV/7X9bSQuIivltnLxH8c4QbbwoAug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891734; c=relaxed/simple;
	bh=2TMwVzSC6mU+9ZUW075nP03KeC9epC/SP+Bi9P9h3p8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H3Z8Og2s8Q+oENhQbc1xmcZ9loXJ1IhafydqlEqwxvuolxb4pw5Ett3alKpQshs607esOTO6Sblc9UZhcR9ujh813xlAUd+NASW7+P5CLh43rgSUD0wXn6fffwrdHXEql9swH2Ki8h0vFHqF2zpn8+93Yz0PuQF1YlLbR4Ox4i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FJHbpitt; arc=fail smtp.client-ip=52.101.56.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3b8UuT3mRyf0Md1iElgvnq6CAHqq9owyg1OPCgA57L1ClaW8HtHg6SEKDktR2XRFKl/TP7tRegSgH9H615s2jIh0VhODkaTOm/lnHZltvr9fqtj1DrcvgKyLK4IqAtgZLBSDm3S0vio7jROn2l9MxWLtMdI3JH8WINW02oSCF0HAr3fXGmEfuaKtoqrGM81459WCV8sEZWzlGTYpPNW0aeqKLhmxmHMg1DY0VXoURAb0Yq5yj76qWazgQYN9tVE5FqRIik9bKzvmmRa8dAM0dXYjuj0cH4W+CpH0Umf8wlmlDKcKnVpr5cOp0Gts+NYZNBY18NoI3oGzP+CyN9TyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmCY7kPSGm2hVzipsoyDNU5SYzNPZW73nz2dLQZxanY=;
 b=KpnuZgfvfYawnnxYiSXVcJItjH+LiAK0NpJ6+VL937caBswfwqOCwl76GlvVU/Zc4GQ2Rd7D6oBp97WN3pR8OkO5Pc0eobOpK58BSFMaUr6mh0KNoJ0c3GZOpM7Qy/YU2p0+nv4Mu+l9CcGcU/v8/zSBwQrR+hzhtdSHuw+jGmZwBtY4EA0KBpGnT53NS4IIgXKvOsvGie0iIA+OVwZYhc/sODQMKzdBF4TAmDR1BwdzI6rau0yAPpC0/hfNWOgX6YShlxn0uVJXZFSBPv8HUeWIqtvxI5UwPolLlhv20n/pYCdKRMjb2fkD4ENSoHbkKa+VdHO67XzUvYNZc6hczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmCY7kPSGm2hVzipsoyDNU5SYzNPZW73nz2dLQZxanY=;
 b=FJHbpittzie731NExOmuAssgKr2gBWBTaGS0BnUK+xqThhErwVAsVeWokjWr6d6whbblaL2foCb0JKc62UhdDdmtc3m3fJRBxsvCsQvjSUCjz+VJD2bP0L6k1kReCDQVmqSv1/XDVXqcx4nGmBjLqojfavZZMNpNUrsPnkZSSaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV3PR01MB8535.prod.exchangelabs.com (2603:10b6:408:194::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Wed, 2 Oct 2024 17:55:28 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Wed, 2 Oct 2024
 17:55:28 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: jgg@ziepe.ca,
	nicolinc@nvidia.com,
	james.morse@arm.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation for 32-bit sid size
Date: Wed,  2 Oct 2024 10:55:14 -0700
Message-ID: <20241002175514.1165299-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:610:32::9) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV3PR01MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 7651e31c-f92b-40c7-32ee-08dce30b66b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U68pvkoV6xve/ZZwpEJ6/AnHyR4Q6s4NVQbfOdBHhvANhznE0729EzXWEQEO?=
 =?us-ascii?Q?9pcT1s8lepm1wFQNPSunEDXF/lfNlqQsbb1b3qrPAtRh1oy6vTyFyYpqyFEE?=
 =?us-ascii?Q?s3g2ZmOVTqVBX9rhO5Cn0xdCgZ1UtjASFVXUJoDaF8sFvvKuFM7mnqpyIm/C?=
 =?us-ascii?Q?wPISfR+vpmG212/zv0Luk8zzffc5x27r61RH5CwSrb1lsIGfA41Zcjqn92VN?=
 =?us-ascii?Q?yPhHn0Zz3hMeQeM16IErJE6UruKZS9IwKnLTv34LCWF1ef4BLrUdZN86d4G/?=
 =?us-ascii?Q?4r037Bk7oacdyFoVxW92W6MUBTlymWnKhh26EwcRxP32JoVNjAWRtdOiC6y7?=
 =?us-ascii?Q?LZs4zZ0kMYPk3B2h4UHGOExxJMrvA/mRn8byhO2+8ekbiprDuL3ZYgCt5US8?=
 =?us-ascii?Q?im2nfuJcdXVxbs00O88XHPOP8tzhqRFR7N5E+9sWNkvJFmqHu+wmmST9kPr7?=
 =?us-ascii?Q?W8NuwwfEFXzO4L+75h230BbAQIIbP6Pxog1J1XS0k3nSkGUDKa2Hzw2kx9z7?=
 =?us-ascii?Q?TUhwj/CjNm0eQfyk7hwgOgXLBWdwa76x7iWWGzUH20ubKrMnRt680ozMAq+U?=
 =?us-ascii?Q?wFhEDK0XWAsO2mWuq1Cp6BLKj0nCY4b+Fx7cwrBiEoRgRSeGBRdH3/IADNH1?=
 =?us-ascii?Q?YQ2Xux8ebhwLhhHlFQV/nlqmi6w8NDmbuu8ZNxc41jlgCF7jc51lqvA6VtyX?=
 =?us-ascii?Q?uCf4hm+EJjQ4IJfea8JgYqQLobMt1AYQW8KHoJGPTVyLB9MS6jYvyof3rFwr?=
 =?us-ascii?Q?L6lWikM+MHOEEYufVqWcpC3QQhtvsAuAmJ7bAF974N4oz4IAAj86DlIE7bQ7?=
 =?us-ascii?Q?ooVhpUR0xpjQoJd2jPRLqv/I2wDPOpbB97CysUDRvA0S99G3S9vmTuG7w4nJ?=
 =?us-ascii?Q?TnJEaWTzDLXLLApUZmQCwj6Blo+XYaIVZkXi5Ac8tPPAtSsx3JkpMNSnETxJ?=
 =?us-ascii?Q?SGq9BUkiN0N9nyXVJAu2tbE0vMfKWr8XErdfVkuJBqKWJIi2bRktx5eIEVhI?=
 =?us-ascii?Q?oKV76fmBl6rs4Cym2OSVS9thOayltOxGIAD4lNMyDc9VVR3pEd+t49u+LvbA?=
 =?us-ascii?Q?YODuX2M2+cBQkpro/OeHn9clVikWCMGh8zckITporkCoKX8MVYZSLVWrGS+5?=
 =?us-ascii?Q?8DBRV1UmGirp2S8NTMrqOpoYDJIroektWsLVIPyq/wzJI8rzdn2ME/eyA0Z/?=
 =?us-ascii?Q?Vj0XtHxzLDldRHko2ztPRSMn197ldRh+96YV3/dtii4jOodiEbRDO445yIDC?=
 =?us-ascii?Q?0LxZOWuC9e/m7uYh1wtpfgMKyozSW6RSwf+AKaDfqi0iJzdhVDaHvizM57Ab?=
 =?us-ascii?Q?vZOpOhDmU/7ztQEQ8wfC2cqNtrnikal2DcVAQHtjpMa0jA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l91BEXOFEAuD0YaibS1varGu9no3lYzTsMgyaO1gPEePRmuR62oZjkedTbDz?=
 =?us-ascii?Q?06Sr7lTLlkuG4kkdRMGKPy1myztBC2MrHpyXPH4lynW4TsqogWyknM3YlnAc?=
 =?us-ascii?Q?qJwG7+FacWW6N04/eZcv77juNdTuAjEUdtexycccifxNC6oRMqvqzvioeqyb?=
 =?us-ascii?Q?eYElvVAlOQ/tA2oxN6Gkp7c7bu0FiSDY/AO4F8jia/fzgJkcd0WYLBSzhbw3?=
 =?us-ascii?Q?3wxDb3qyKTbNJjWqp54CILx0vO2IkL815ERcIotLrgS9v+sOLigwZLImgDKp?=
 =?us-ascii?Q?hNhTwgbCeYjC+WHZlq9WZdMv5Cfs0RJF+KsP/7Qx2O2Pdl+/7DkJO7PyIM15?=
 =?us-ascii?Q?SAaOzKVaj9R8JZIMAprpoVVGECLNA8iYqTtWQr+4t2gFGAIV8Uy+5bOFw+sT?=
 =?us-ascii?Q?tMUYo/MAzIey5f3+eEdmigjK54liCmLPMvo7ZgCMGqwW3RMN8beCr0nYFXGo?=
 =?us-ascii?Q?PixO5O721HeNetsCPhymw2MCO1MVnT99Mv30FieLdWTIAifKdlbrGVTE9pMz?=
 =?us-ascii?Q?W7xLaolcAu5uZkyVlEJjCesY5+K1FrXz+S1LMCwOdPPTwD5S5gTTEzOLVJkN?=
 =?us-ascii?Q?abS30/CN5dSWUi6784fWxSkklxxGvg82Th73+q3ssaRGF2M+iCPro37w1h2U?=
 =?us-ascii?Q?zarLDiE6kZmdoQ+vV001dFp1m5zdERWDY7hYEYogSDJzjzb0ifBjMiKPdqes?=
 =?us-ascii?Q?KGfWXp+yg54UBbRGd6Xvgit5739Km/zewRSWXfYa47JRHy8z6xpZqbVVtV8Z?=
 =?us-ascii?Q?0EXSQ7kILSMVSrU4k6Epmk0kJm+0TVJ4jcmDfYGfP/3XUvnkRAVhmyAk9DtT?=
 =?us-ascii?Q?tNXrDdoETe7UNfJSQvyZkl2kvxNBXq9YvJKoubjsJ3o7kdUjJV7K1qnuSjtg?=
 =?us-ascii?Q?9ZA/tTvtQmCjFaKZBpNEZYrB0EkPojzj2d/lpVjjrMfLwx7E1GBoi9vf3NON?=
 =?us-ascii?Q?C83FtRaZH6YrMoo4TX4RgS96CjXU+EOtEvK5gpWEoze7a3LQ9GcZCPPbg7fC?=
 =?us-ascii?Q?Ze4ymNwf1f8cBrblsglF64dx3hIajDAbM6oL6cNa8XizFa5PwXaUldSQwUgk?=
 =?us-ascii?Q?SIM0FP6nGi1TPCPBLsG2pnM3DDEWCmm/jhVWE9zU1AFvp0HkJyP33yJgKNA4?=
 =?us-ascii?Q?ncUFcBEBaZezrJ8bAEZ8Du7uJ656UNEJ6e0kGeVaYWAbvHAS3MFColzDZTzN?=
 =?us-ascii?Q?vhKxQXX2PMZJV7pVWpJtZXVgKXlC2EsuMvrY9gpb1WAAir8DseYln9UpFP5b?=
 =?us-ascii?Q?7GpMOb30fhPZGb3EFtFhR7z4k+Uh5Il42Jc96G9khFwv/cpuNCCtmqo18AR7?=
 =?us-ascii?Q?uTV4R1Dgwe29H02l2liQ8QCkPi6sLNCbtb8UGVYKXSYzOKYdoMa64wjjil1Q?=
 =?us-ascii?Q?KZLw/urpuQTkqDdiB5F692QKSiUKlc9hVYyeYXMxWSixu/rllhHGqs1oHat8?=
 =?us-ascii?Q?8OOh+WoOb5J6yS0vMjaCUWYxPNwt2Z4JOyJqbxH9aKJpAlcNHgB0unKTFS4V?=
 =?us-ascii?Q?nXLA7jFwtLnFTxuNQuUBU98JwXB51moeeSvp5W8eWZJtqDjGPpWC5si1ERD7?=
 =?us-ascii?Q?wPbpekCcBw55DkmzCYolmltH/pdPB7VVdRW7s4d+Ekx6heQ9UcMVM4w009sk?=
 =?us-ascii?Q?cZL1MzFzCoysQvvR7NrBytg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7651e31c-f92b-40c7-32ee-08dce30b66b3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:55:28.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY/ajXb1LbobV111qd8VjdHK0y77uIhNRou8iOFHyB3CIPULf+YC0iWnKV6dScpN8TDW8mmJUzGvQdyOwnMJDD7mA4MWa9efq64QQHTgxoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8535

The commit ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
calculated the last index of L1 stream table by 1 << smmu->sid_bits. 1
is 32 bit value.
However some platforms, for example, AmpereOne, have 32-bit stream id size.
This resulted in ouf-of-bound shift.  The disassembly of shift is:

    ldr     w2, [x19, 828]  //, smmu_7(D)->sid_bits
    mov     w20, 1
    lsl     w20, w20, w2

According to ARM spec, if the registers are 32 bit, the instruction actually
does:
    dest = src << (shift % 32)

So it actually shifted by zero bit.

This caused v6.12-rc1 failed to boot on AmpereOne and other platform [1].

UBSAN also reported:

UBSAN: shift-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3628:29
shift exponent 32 is too large for 32-bit type 'int'
CPU: 70 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1 #4
Hardware name: ZOLLNER SUNMOONLAKE/SunMoon Lake, BIOS 00.00. 2024-08-28 18:42:45 08/28/2024
Call trace:
 dump_backtrace+0xdc/0x140
 show_stack+0x20/0x40
 dump_stack_lvl+0x60/0x80
 dump_stack+0x18/0x28
 ubsan_epilogue+0x10/0x48
 __ubsan_handle_shift_out_of_bounds+0xd8/0x1a0
 arm_smmu_init_structures+0x374/0x3c8
 arm_smmu_device_probe+0x208/0x600
 platform_probe+0x70/0xe8
 really_probe+0xc8/0x3a0
 __driver_probe_device+0x84/0x160
 driver_probe_device+0x44/0x130
 __driver_attach+0xcc/0x208
 bus_for_each_dev+0x84/0x100
 driver_attach+0x2c/0x40
 bus_add_driver+0x158/0x290
 driver_register+0x70/0x138
 __platform_driver_register+0x2c/0x40
 arm_smmu_driver_init+0x28/0x40
 do_one_initcall+0x60/0x318
 do_initcalls+0x198/0x1e0
 kernel_init_freeable+0x18c/0x1e8
 kernel_init+0x28/0x160
 ret_from_fork+0x10/0x20

Using 64 bit immediate when doing shift can solve the problem.  The
disassembly after the fix looks like:
    ldr     w20, [x19, 828] //, smmu_7(D)->sid_bits
    mov     x0, 1
    lsl     x0, x0, x20

There are a couple of problematic places, extracted the shift into a helper.

[1] https://lore.kernel.org/lkml/d4b53bbb-333a-45b9-9eb0-23ddd0820a14@arm.com/
Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
Tested-by: James Morse <james.morse@arm.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

v2: * Extracted the shift into a helper per Jason Gunthorpe.
    * Covered more places per Nicolin Chen and Jason Gunthorpe.
    * Used 1ULL instead of 1UL to guarantee 64 bit per Robin Murphy.
    * Made the subject more general since this is not AmpereOne specific
      problem per the report from James Morse.
    * Collected t-b tag from James Morse.
    * Added Fixes tag in commit log.

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..4eafd9f04808 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3624,8 +3624,9 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 {
 	u32 l1size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	unsigned int max_sid = arm_smmu_strtab_max_sid(smmu);
 	unsigned int last_sid_idx =
-		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
+		arm_smmu_strtab_l1_idx(max_sid - 1);
 
 	/* Calculate the L1 size, capped to the SIDSIZE. */
 	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
@@ -3657,8 +3658,9 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 {
 	u32 size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	unsigned int max_sid = arm_smmu_strtab_max_sid(smmu);
 
-	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
+	size = max_sid * sizeof(struct arm_smmu_ste);
 	cfg->linear.table = dmam_alloc_coherent(smmu->dev, size,
 						&cfg->linear.ste_dma,
 						GFP_KERNEL);
@@ -3668,7 +3670,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 			size);
 		return -ENOMEM;
 	}
-	cfg->linear.num_ents = 1 << smmu->sid_bits;
+	cfg->linear.num_ents = max_sid;
 
 	arm_smmu_init_initial_stes(cfg->linear.table, cfg->linear.num_ents);
 	return 0;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1e9952ca989f..f7e8465c629a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
 	ioasid_t ssid;
 };
 
+static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)
+{
+	return (1ULL << smmu->sid_bits);
+}
+
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
-- 
2.41.0


