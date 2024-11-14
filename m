Return-Path: <linux-kernel+bounces-408642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A840B9C816B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2110B2488C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3D1E8859;
	Thu, 14 Nov 2024 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YmM7VPmt"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022117.outbound.protection.outlook.com [40.93.195.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233221E883F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554361; cv=fail; b=twjOxvvDQpuVsBAy544rnGqXW8/i/09voCEt36ofRposRlcW7zoecPzpeYS/kdMJ0//Kdwy0cb7DhjYmzEbK6ZUDkqK+IMkKnmUz8XLRbmJKFe49Sg5fvs/qZdj9FjYopiNaG6E3TcJN08TchtpIaCttNYSPZcAEXfa4IO1Mir8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554361; c=relaxed/simple;
	bh=ajaXMTF6sfSDJxImpKVPSnOCp2Bd8uK7ml26XE9404k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J2qfs7HHo9Ztfl15gKAHLnE88fDssOT/A6cM3I+N1S+k95ua7YPr17DD2jXD1LILLWXZ8TqJRdWCCxP7VdhpZa6pWPqYszcJ362CfUR8Yw1QmyGL7WW9OllkWZRZuBtRiT5jK+quscvECsICSPZMHVtArKGdPgnPNQ1cXhhH73A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YmM7VPmt; arc=fail smtp.client-ip=40.93.195.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xocD6REg+Xi23pYWiGxl8qXN7SjoBKRD77V9H0o3k2LOg/gMUjbANV0mzc9SBsJkKhGRbWwzrog2Jq0EY7PCfBrgT0FrM8bE+OHFzptqHt/bWAXkMqB0qWPe9u5kCKP5vmHO8m9/gSZRMqdoq6ntKKRF8cmQsrPMM5Kr2knfekOTkEntGhNIuWqVpa21Kmc0sUfpR3WXnY939fUnugxkfm0GYrMoLpLn7Ha5GL2N9255vMQWfPb0h5/OolMcjpOo6aiFo3CHrdFhx9U2xRbzeP0oKKql6RgIm4J4YzDenX43PyDM4Htmx7cbw93F0G4s7LR1kfCnROLJZhI7zSs9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8ofHZM4LnpBHCc2JRZSOooilZ4MsUAsGxJK7VAHWWc=;
 b=JblsVCGX2RsszMPgUAzqOXmucOKU+fMUWvsvB0pE1OP7DaXI+AHvn7WYjax9QL0jLurnZ7jYpkk3u0zxySEjBBDdvlOAoX+LdtQLL8M8xtZtVTnNPxW2msKtZMBhlC5TFyBT4gUfnrV/pPOzzW6vjQN1t8rs7Zp+hyrZuCLV4ARC7p3kKi7JRejbbgKwKE4SOcv3CcDinegej9CjGm7hurYHE2I9u7hQ7aGe3WxybACSAhp9TdDNPGWRf1W4te8hcpI7Cf9YLQEM2cW2vbYAfk+1pBcRNhUwAq6YNYgWsbB2rYvIVP9P3AGaP5d2FLT+rNHc12mWmkhuDTvdlySV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8ofHZM4LnpBHCc2JRZSOooilZ4MsUAsGxJK7VAHWWc=;
 b=YmM7VPmtlOm9aV7nJqlGwq+45agRJ/PEGoflE/kgskFWnUNOwbYWECTyvvgs50fel6wiko7/J2NsmiG/zhGn2zRak7gbmcjOULSHKBfvNG+BzogUDFU/98J9ZHmZ9V3caGDLmnj4vV0FeoyAb7opng+k9Y9F7cjpILS2V+I9LhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8501.prod.exchangelabs.com (2603:10b6:806:39e::18) by
 PH7PR01MB7584.prod.exchangelabs.com (2603:10b6:510:1d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 03:19:15 +0000
Received: from SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d]) by SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 03:19:15 +0000
From: Paul Benoit <paul@os.amperecomputing.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Benoit <paul@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: smccc: Support optional Arm SMC SOC_ID name
Date: Wed, 13 Nov 2024 19:04:52 -0800
Message-ID: <20241114030452.10149-1-paul@os.amperecomputing.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::40) To SA3PR01MB8501.prod.exchangelabs.com
 (2603:10b6:806:39e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8501:EE_|PH7PR01MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db10019-5a6d-46d4-b964-08dd045b1e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ItYWJiv4H0WhQPIMYuiXUwFkbGODowmqDg6o0oE+Iee8MzSEoZ1GB1/U85B6?=
 =?us-ascii?Q?o7o5qSooJXqJ9Yo85VG3PFSO1xuhtmDu+sSzDRW4/O0fq8SmjW7mn2ECLFPr?=
 =?us-ascii?Q?NqAQQbnaewPjWFVKSxoy/Nn59LGWLwpiP1snQ59Gn70VXbFuyzsAzr1qRHL9?=
 =?us-ascii?Q?tfx6L9hpTO3u2Gf3lx4QC5fYX/wNjdL/ufqnPNDhGsVv0mTPNrWPGErhy2mH?=
 =?us-ascii?Q?SqGNs4zB9VduVFJ7jUOOVhKpH8hex76jV1nRmasjGsvjzLI37FqT6x4udeGf?=
 =?us-ascii?Q?0JnEzrRXX1mx6hubE5GyHtgjW4dQ736ruytBLjJbfdUnHrfuSkVF3/L9/YIP?=
 =?us-ascii?Q?Pso9W4FTyPdTxvNziTdsJWt9xgusbmwKYu8sUpiDtt6ygvxq3Ti0c3/hhy3B?=
 =?us-ascii?Q?otPPFmPkOe53SHH83Fu2JaShXByAOOwo3xnmFnihLNmkD2yGjl8Q/8XtGxPE?=
 =?us-ascii?Q?hhkL+dcJALBbn3v3cKVscJ4BQg5bs22kKIN2nGtLzfQF/GuWfgs/u9MalVBh?=
 =?us-ascii?Q?8ClzFOH1uFmPgdp4ul6mQlxHvS/rQKhveYCF2HSuDDe1MQHbAj/KIVjnPCdM?=
 =?us-ascii?Q?ssh9YziJe+AT13NDw77aPgC/T49sBK3n8fP4dzrDZ/H8EFrCjFrlJhWg2LaJ?=
 =?us-ascii?Q?E9VZwogB3wg/ZVVSMRmeqaDurw+Vf3HCbZMKWIe34rcMwrnqZTgdbrqh9xih?=
 =?us-ascii?Q?Lwp9796wJQQXDIop2BeepdaL3MXarG+gv/BaYnfHAJqk+snl9/A7lWBm5B9X?=
 =?us-ascii?Q?BHWiAkn094I0N6DmKJQup9hIiDljwNX287g3Ov59xeIUR44FJ5li1bL0RWHz?=
 =?us-ascii?Q?inpIQwezwqbQwYl9HW1ITsXMq6Uh4ZwKUW/NiS65cibC/PaXPYynEfm1MOIO?=
 =?us-ascii?Q?txhOG+ffjYmHNdillRwzrTv9+41kqK1HyIfl1O7mQf9uWHrhuVo/G4/BO+f6?=
 =?us-ascii?Q?1DM1PI1EfWkmhEGuml6f83YeDeDhFbD6yOYOnOqulqc6hKlx+1RUd/+/2pzO?=
 =?us-ascii?Q?kF6paLeRVwhBbbf6THplhNL4rP+Zl75I2SXZ3tP0XNeWUffEgIBIKg8reYId?=
 =?us-ascii?Q?ZtTrfFc37lL/CO3o6rjAbeDxJ8JA8+I/eXU0OJWa4Fb+3vCXTLOPqSvds8sP?=
 =?us-ascii?Q?+gFADg5jSvYvAGiwf1fQqOESZGnlRN1Yb/qY/EscWKTsR5HtbNnX+G9WgTHl?=
 =?us-ascii?Q?F2zHEK4ecu9myDJbgqAiocqVaYF8YDohOXCRtdOXZ3JS5jNkll5il8h2Yoaf?=
 =?us-ascii?Q?ai7mZRM4DFbr26PBoi+MZR22Z7NlVac2Aue/Mll3io7rx43jrEjFv0epS60y?=
 =?us-ascii?Q?jNB+79zoacleC48hhMRy3etxxJtl/HzlLYPVC31ZXMqiLZmS9qr7cAW+o0G+?=
 =?us-ascii?Q?uZ9rt9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8501.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UJlFqLcm1oV6ERGfI3yUEf35vMJSWlTA5cOVa3JQFeSWy6O8fY/UoHZ/PcuW?=
 =?us-ascii?Q?pQftoNpQWA5y8SARl0CArzt4gggtMnfOAVj+Ni5zZzCfaVNDa34Opx8d0iF8?=
 =?us-ascii?Q?bqq/RMVa+JTsOpsv8iEH2YYUC7ZYP8CqnX9R+UWhL2Eg5Xiv1nNIFpOH6WGv?=
 =?us-ascii?Q?KlQ5R0qKjoMpVYk1981yS7JizgOYwMyqKsNWiOZ7F1NxzZJQeMvo9b/zNbfc?=
 =?us-ascii?Q?oK46olfeQvZK0Utm+Jbqfez9wNN3NGm6VsRmJs9PTkLgNKT7aPl0yF9Hi/+Q?=
 =?us-ascii?Q?zw/j6hZMQK+a0r8NpRHsnKHnFwSl+JAhRXmQxFyV10r50+gjT3MezGxsKmhy?=
 =?us-ascii?Q?QR5lk+rJt5d9iztynKDkrWNPFhlE4nZ7JulZguvc93wL+Mot5QtZs0NJhH9c?=
 =?us-ascii?Q?K8QjitDRFmKVOAK4xwEKFHZikQt81q9GRBJOYzsdZhFw5YFW1600cn9f0MzG?=
 =?us-ascii?Q?Tv37+mQSkB5bNRVqGyT5BjLWqCwZVRCcb9HXKeVzRVHGG+ztYYfId/llG/f4?=
 =?us-ascii?Q?GPvU+eLY5OT398iArvzaHVNM5/rju818GGjIOXvuVmmOZfCKijAwfC8bHhbO?=
 =?us-ascii?Q?JVD1URZ2GLh67HSe6ENCnb0Sikh63rbrORzaauUQtALlEDwfX+WTHFmcrF1b?=
 =?us-ascii?Q?Jj19Y4la4nX/ZjTr6jlVHLKbQGLwJnT20G8PhN/rYJqY5yOFwmeHSQZNlJbA?=
 =?us-ascii?Q?AVuT7hOQdTKlk83Wyl6mq+300b2uiWM40rNoblsSNg3bOHzkjpoyxYsKNtBw?=
 =?us-ascii?Q?Pxx6ymnQHpcwOsXfu5WvYifNv4gbGOlo+j921R765eYgJ98ANM7BT20QPlez?=
 =?us-ascii?Q?CLRxmoDfBhwrFPcngPqHX63UqJEULmOXvmTEHfX650Y3frQpPu1Pa4+spvYf?=
 =?us-ascii?Q?4UdHaque3P4AEN0WPUYLZlGWKfKTXFYQGqx7nDayxQdTBLNBnpU9Jc/vEYwQ?=
 =?us-ascii?Q?qiQmsTmm0FBxrv7SOEZRK51rfAv5NpcOTCHq9OsDM1/8tjAvO4HiCrfrcHv4?=
 =?us-ascii?Q?fDbTCYECRYtugdpAh6/CxydAeWCvlDmSzV7tCjeXmK96DhD51ReaHRsbMhc8?=
 =?us-ascii?Q?dumtdHE90cCwQjMobi1V9tQACJyjBp3CyH80PtKZyf044YhkMFuLzTdAPbHU?=
 =?us-ascii?Q?ZH+EZBw8TAG3SqYa8cOXd3kH40b+JMZtS+1YXCJgBLYwzOkLJvei3rxZ8VE8?=
 =?us-ascii?Q?pM646b9W/zRz422gl1rvMuhhNwhnlXTOflU9324QCopEEWGBfAfYPvosxevn?=
 =?us-ascii?Q?I9y6YKFRPUPnSfo55PuLPW887dPDmykaSUPSa4VQNk2MbJ4aAUcyPB6x2Kjk?=
 =?us-ascii?Q?dSEG2xL99sejFoKhvb+JRC29DH1Or0kRZ1RbPQFzWJdJrltPSOSkchGOZg+K?=
 =?us-ascii?Q?oizGxxXLsP7stGHupUkZrdSWhk+JAg/qE3jLneIfMLvw3qQQcyPXP0Wm4X4e?=
 =?us-ascii?Q?sQyjSz1BSzqUte02ztwfVS6V4cFGzj7RhPu5WzL3HKdVHy+PLmAUqj7BQwdy?=
 =?us-ascii?Q?WOTfdRdZNXQVD4WdcLvvE/YBF7JQmhoEFEl0RLhEPw80pEQByBr3I4KpGO9P?=
 =?us-ascii?Q?caPIh0G2mxRRFMUIj7AKkvuNJwDpfWLxIOEJ9ltresA3bQ6fxyWQS0ZWbO8X?=
 =?us-ascii?Q?LfVyvLON01eQVkgn0b84zh8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db10019-5a6d-46d4-b964-08dd045b1e19
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8501.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:19:15.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlHolizQaLIzaG3TwplzBM91VJ0WyfpV7mqmN0T2wb2xIsxkMdJu37owHjI5XCflWMyu52VoW8drKDoltG4qeuThMiFvTlfhsqPKZbFElFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7584

Issue Number 1.6 of the Arm SMC Calling Convention introduces an
optional SOC_ID name string.  If available, point the 'machine' field of
the SoC Device Attributes at this string so that it will appear under
/sys/bus/soc/devices/soc0/machine.  On Arm SMC compliant SoCs, this will
allow things like 'lscpu' to eventually get a SoC provider model name
from there rather than each tool/utility needing to get a possibly
inconsistent, obsolete, or incorrect model/machine name from its own
hardcoded model/machine name table.

Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/firmware/smccc/smccc.c  | 70 +++++++++++++++++++++++++++++++++
 drivers/firmware/smccc/soc_id.c |  1 +
 include/linux/arm-smccc.h       | 10 +++++
 3 files changed, 81 insertions(+)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index a74600d9f2d7..1c7084b0b8d7 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -18,10 +18,12 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 bool __ro_after_init smccc_trng_available = false;
 s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
 s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
+char __ro_after_init smccc_soc_id_name[136] = "";
 
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 {
 	struct arm_smccc_res res;
+	struct arm_smccc_1_2_regs regs_1_2;
 
 	smccc_version = version;
 	smccc_conduit = conduit;
@@ -37,6 +39,66 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 			smccc_soc_id_version = (s32)res.a0;
 			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
 			smccc_soc_id_revision = (s32)res.a0;
+
+			/* Issue Number 1.6 of the Arm SMC Calling Convention
+			 * specification introduces an optional "name" string
+			 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
+			 * available.
+			 */
+			regs_1_2.a0 = ARM_SMCCC_ARCH_SOC_ID;
+			regs_1_2.a1 = 2;	/* SOC_ID name */
+			arm_smccc_1_2_smc(
+				(const struct arm_smccc_1_2_regs *)&regs_1_2,
+				(struct arm_smccc_1_2_regs *)&regs_1_2);
+
+			if ((u32)regs_1_2.a0 == 0) {
+				unsigned long *destination =
+					(unsigned long *)smccc_soc_id_name;
+
+				/*
+				 * Copy regs_1_2.a1..regs_1_2.a17 to the
+				 * smccc_soc_id_name string with consideration
+				 * to the endianness of the values in a1..a17.
+				 * As per Issue 1.6 of the Arm SMC Calling
+				 * Convention, the string will be NUL terminated
+				 * and padded, from the end of the string to
+				 * the end of the 136 byte buffer, with NULs.
+				 */
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a1);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a2);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a3);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a4);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a5);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a6);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a7);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a8);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a9);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a10);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a11);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a12);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a13);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a14);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a15);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a16);
+				*destination++ =
+				    cpu_to_le64p((const __u64 *)&regs_1_2.a17);
+			}
 		}
 	}
 }
@@ -67,6 +129,14 @@ s32 arm_smccc_get_soc_id_revision(void)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
 
+char *arm_smccc_get_soc_id_name(void)
+{
+	if (strnlen(smccc_soc_id_name, sizeof(smccc_soc_id_name)))
+		return smccc_soc_id_name;
+
+	return NULL;
+}
+
 static int __init smccc_devices_init(void)
 {
 	struct platform_device *pdev;
diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index 1990263fbba0..6f698c703868 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -72,6 +72,7 @@ static int __init smccc_soc_init(void)
 	soc_dev_attr->soc_id = soc_id_str;
 	soc_dev_attr->revision = soc_id_rev_str;
 	soc_dev_attr->family = soc_id_jep106_id_str;
+	soc_dev_attr->machine = arm_smccc_get_soc_id_name();
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 67f6fdf2e7cd..5935cf636135 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -333,6 +333,16 @@ s32 arm_smccc_get_soc_id_version(void);
  */
 s32 arm_smccc_get_soc_id_revision(void);
 
+/**
+ * arm_smccc_get_soc_id_name()
+ *
+ * Returns the SOC ID name.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID name is not present, returns NULL.
+ */
+char *arm_smccc_get_soc_id_name(void);
+
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
-- 
2.46.2


