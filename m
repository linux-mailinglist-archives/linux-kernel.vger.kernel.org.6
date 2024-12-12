Return-Path: <linux-kernel+bounces-442756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027D9EE130
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9B1631F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7880220C474;
	Thu, 12 Dec 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FiH5bv7w"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021084.outbound.protection.outlook.com [52.101.62.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AF20C01D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991906; cv=fail; b=af7ZgF1QiKQpw3eO7iX/DQET0UWs/iusevJa9khQmRBO+ESpI5+SL8ggUHxlh/LR2b5R+zWiASz1nJTFqvJ+SqQoLxIqIqid9a7C1QsmchQU7X0GilFPOZSpnaEbMyrSHN3BlQpP9ntFTHZiMW+GEyNbk9A6waPlk3SIz5TZqq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991906; c=relaxed/simple;
	bh=KUsnGL8orSuIFJkifExisbLdSGnXCaI1GqGjmXNXel8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=M7GhzADjsO0lY0VQz0zZBY+nb2geRWobj1A9Rsw6+mLgG6rer+Zv4fHWqLZpFNy6cnJln0H+HhP5ezNRxnN5GCoD0v6G+McSiJe4xzYGgbLD+Bk9YKS+/RY2OevARJLQ7VHOXw46oNiVraEYHZhta5mMItAxfqjPLVJHx8/VmMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FiH5bv7w; arc=fail smtp.client-ip=52.101.62.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvhL+zUU96hQH+gby3ZInU6lulE0Ia/Nrm7qqtR7bSvud5+UO6fW9JGXLj4/M7mSIf/z8PE4FyL/UuV8g64xLS1HZqwsZ8jdyISFa1NIPwAALWN6fACcqm1paW8atPGeiegM8LZSH3fixE8RG8jziDVESu3Q62Lstm1HrV/8jLKm24+4RU4kJcEhNQ+B5ZpgQxwHnLAd2DaPC6KaYawxfFZz3qFC1l76f/T0bh3efE9W7fvnCK5vxnI7ZjzWA7AY3dS/Ej3j3KNPGplD0Izhxt4NtDoZmXo1qSmLtajEVPmK8ny5iqz5bnsmDD0STdlvQn47+0V5Fso//s052ezumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfNzbj7glqq7ZRv9NRQv1rv5uwrvUlxFzUXYJZDz7nI=;
 b=GaohLJdWBKISaBtlIAYZzOIKJAdfwL1Ruh7RYaX4t0/tGBiUsbZkfE3ICTTPScYffJU1dCgcXRPdChecg7+bn6rjb1Ay/EEIq+dQQvk0NAvkShSxbG9eb6lASU7NlrOtk9X+JScv66tEtOHAf6zcox6D9SZz+TwegMJF6IV542bBbPVK/4VZ80QRoAnj18+YRfZv1Yh0pS9htiNXcvqARMJZ6CmIrhQsWENrS5utVs9sKXy/fDzbrxP2F3YLZ3YxXnparTo/oszrCZzeXxDYLP/OM2mGsikvskFvUiBEEity3dOnhZLWsc4fFq9VekPV7K0S7h+6odJ4A94HrDR9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfNzbj7glqq7ZRv9NRQv1rv5uwrvUlxFzUXYJZDz7nI=;
 b=FiH5bv7wrAWiozu/LiObKEPBVOAMQ4eR4CMtFXaMic8bgelNi7FOw8IguamFRX4R6oy0W6Iwej3iI0+lO4YrKDJa/qH+xrCxX5iuFRRn39AS+CIBrss1OzfuiugnLz/sDrCJ73I7HXRMc5uLupW9Dx5eu1ZB2RJRerRSS882nko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ2PR01MB8459.prod.exchangelabs.com (2603:10b6:a03:557::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Thu, 12 Dec 2024 08:25:00 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 08:24:59 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	corbet@lwn.net,
	ardb@kernel.org
Cc: patches@amperecomputing.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	inux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v4 0/2] arm64: refactor the rodata=xxx
Date: Thu, 12 Dec 2024 16:24:24 +0800
Message-Id: <20241212082426.4110-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::20) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ2PR01MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa82df8-c501-40ab-2e32-08dd1a8677c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6suES3QBAFNkQ91r6lmSHslJ+HhDV5asn6sAud+B+D5Q/Phfxh6Y9QFcht7w?=
 =?us-ascii?Q?QmmDsU5nyvYucTFIkdJHjtzlQFVwcLtmb9oC4lASvz9T5X3WeGIRatciHA0u?=
 =?us-ascii?Q?mhQUUgj67+KdY4/1FOrEkijzNCHfPuDHeIGsIPm/73EEHa+Bpec5nsIiU/Q2?=
 =?us-ascii?Q?1Uh4sT9hy81TJUzgRY96uTcz3YK3bNWKXNqLa5acRpwifIlEtuhmt50Hp6uu?=
 =?us-ascii?Q?I6dVF54tqYyjhY+ZUJmv9jjjpwPfYZLjTsD1k5Aa1WTyxfU6OJ6y5oaIUQq2?=
 =?us-ascii?Q?zjPP6vOcBiunhT4+x0WEbTa9a7g/LGBFnnNarDoZritgqqOAdwajfScNoGpm?=
 =?us-ascii?Q?ChnbMF51+LUIaw8T9xFTaMPNt+QKlmO0F9L15UuZijQ+9+1zu4oRXxAuCyt4?=
 =?us-ascii?Q?6mbDdeuv8sT+4obZTk+TR7mBpolrdKCRgH9Ozh1sLY68C7DIvybZ3kOZxTzs?=
 =?us-ascii?Q?dQoc5xZSWewSwzAHDzHvZyQ5b0y7ZzNrlhxnlxZsd+EHpPCgkhd6c1sjxAFs?=
 =?us-ascii?Q?LiDHISa0IiOQMGtFMTdTc2B/Zf5a4/uCjLeA7ybm75/OSAWppOxHsj+oTOnM?=
 =?us-ascii?Q?Q5vtUHTJHhjdAN5n7+DE2anithBukkUG+fJVrSvJB8B7aYo/pJ2YHn3snFLg?=
 =?us-ascii?Q?29YUMfMuEpmqmhG9Wp38YXclIBLg8+JIR0qmitHxVTG9evM9uo/F3gfIJEQ1?=
 =?us-ascii?Q?VoMNsL5y196RJka0qPYqncOo3DwtdBK/XPCXAGPYAOWVXfYz0MYqiQKTIbMH?=
 =?us-ascii?Q?EPvrSt/34gxiP5P5bJiNlahbRyM1APMtMtN90Qyf9SPRDft7icPD1Hitqdrv?=
 =?us-ascii?Q?AVwOJ0VGGpVeKinReqFHRPjmnda1sA634XVPUgv4Id4IFUhuKWDA7wXxHUAI?=
 =?us-ascii?Q?OSbxFlifIyAC6ZE+Sw563pcK00/aytd+MRnFffte/18UBEZzNXqN86rEfbDl?=
 =?us-ascii?Q?lyKiBX6ocvtqd6CCYlAYj0g2uRb71YtTgkRqwmrYSqJ3N7XPGju4hkuUqZKA?=
 =?us-ascii?Q?ruZ4jHIqFJmK2VKKq24qfMT5FeKph4wnvKRlX4miLPBKOEp2e+jK870xKbae?=
 =?us-ascii?Q?alshBHcm9VfbMCalckcUZ0glODvr+FnPEIYY8ZSjJdLJT30qvvDADNovNuMP?=
 =?us-ascii?Q?IrApdB4ss/P1MWxJzRLxU91hxsu0zmL0JiMBtfkATK/PgCdd0KzoBFq3e0uD?=
 =?us-ascii?Q?5CI11wEnUgYwkRXCRLspDfm6Y6WYUkWVmDYbVvyWEUpXM/BwWjBGAVA+7yJk?=
 =?us-ascii?Q?Nc6cZ+XFpydcIFS5lSNLtq7jzMIEkBbHNc1UQQSUCzoCTPXp35xLJrQuqsbP?=
 =?us-ascii?Q?nhCbdUQcq77RI5q372JkG62/XbKaGX1sAqhuITEYIX+8hBLglcRURaKOqC+L?=
 =?us-ascii?Q?2JEpyIZFX1+BmQXI2SNAutc+cMN0gn92gw/YxWJJzc3W6rbk0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lUonzU7orPttbnCnivb6Y3N+OmMYlEEH+hcd/OOgmKQNt1ZCTXqhOt/DYer?=
 =?us-ascii?Q?oaPht9mL/XXqzkTogxAZiPmZAGMv8KG0lmRA3s8uDXPVdHQIpl0vhSnCO38n?=
 =?us-ascii?Q?3tqoxZoKawJiwm7OvybVaC1JNfCb4KMYoLKF0njl0Q3tOD1HqjhJdlBQ30b6?=
 =?us-ascii?Q?xTagV6DCcD66k9kh9sK5QllalHapKjWUFgii+DiM7nVNRaKqj1X77D3g29Ea?=
 =?us-ascii?Q?wkEr7/sPEvpa3H/zXok0O/zBh6ogZq60gqajze10XEZQQB3LhvF/3OhGIPW+?=
 =?us-ascii?Q?/TPX3z0yn6+OOhHlvw2vp2uW1bj+oQbPVMI/z0OXlewrM7YbWptY6ITh1Oo1?=
 =?us-ascii?Q?T/R/1xUiXIFhmT6Fa14aLvLQhgBQWiL8Aj/bW8Ytor4vwB1oH+UYxok95G2h?=
 =?us-ascii?Q?VPgRg6GhMI/d152JWGONB/HXeVnizr+bUFCRXLOs31QsS6q6YD8yfloDfvEP?=
 =?us-ascii?Q?rTwv0+ZCtpgRHqNFN8L6rN5VIb3fg5OU3kslqfaOmhhFiRo0n9FYhJ2vqCB2?=
 =?us-ascii?Q?PUWdUGUcESYqNgr8iB4r4ptc8aq3kicOhAAvy1+iU9jwY82MluB0SHnuhF0s?=
 =?us-ascii?Q?0RQFGp3VF0UBkh67hYH6yoJba8gXcUJKfSQv/wian0Ee/tYXzzYRH4nObiGE?=
 =?us-ascii?Q?g2gFDGiStm24yj7ZffFrh3txt4RXfoomPQmTJBQBHwOa3uYxH42ktD021K+s?=
 =?us-ascii?Q?3Ka2coqEFubyPceRgi/W80JU6B/ONgUwpfxOXoGB1f9pMtLka5OEyHvtpSnD?=
 =?us-ascii?Q?zIqaxuOuUzk9q8s2TCY4EKFBvMQoR+9jnR/OS8oH/GKwzXnJS8gWndb36Gl+?=
 =?us-ascii?Q?XfMg4Nzcr+hA8EOxCfMMo6rl6WUf5bXS0nNXTPouhKeDUxphhCdfV6hOidj2?=
 =?us-ascii?Q?rM1+yHUihgOF5u2NrceIJ3wmjh00YnnRpQW6eA5vSN4rwSGfUB7c97w5lJ3M?=
 =?us-ascii?Q?zQLdXxks48NWNwJHv9U2bHb2MgJCzlaIUkjpvarB1iLh/veRJA2Gu6OnhaKR?=
 =?us-ascii?Q?3Ti2XGnUgMf/x0DI6OLtI16DF3/B5ufSFW54XIC0TWR9RYoR6+bpsdce6ecF?=
 =?us-ascii?Q?KFuNlv1uXbMTsYlIPmwZfLYqyuZOKL9keF9UXLK+5BT3bnrxgISIRCG6pWey?=
 =?us-ascii?Q?FOCCD5fEGBHoIAimBKSLXKnwecSSEcAGG26BxsUV7lML36cPT2DhIyz8PSbO?=
 =?us-ascii?Q?sDr2p11/x8XZ7lakKeX/eLCKtDTtzDGjKWA9sLFFfFnnd/LKGpNsWVYfK6Dp?=
 =?us-ascii?Q?iQf0t6zU7pHk/AaNEkQ1t5BTVLJW3iguhB1ilzOSCBzEmQHa0dmmK+DHeU1u?=
 =?us-ascii?Q?M0Jqxj5ydoBBUpSkUIE8H0U0NAdchkb8bq9ND/gQ1eNPUTuQYLydRFZME1xl?=
 =?us-ascii?Q?9kURfCdMYBcyIWqyjgQ35sNGFWRuVz+mvpfe0oDMEhbLXpUhMxZc+BkHnBge?=
 =?us-ascii?Q?qcgW6XeBIAVqU3NMSU6WHEllQcwxzv4406xTyToGRhT8cck87gd74bssQDFb?=
 =?us-ascii?Q?5gh46pbsn8xbhGVtbsZ45FL+e9V6+hS/JB/tmv7HW162FLc6ZzzWHT6nG07F?=
 =?us-ascii?Q?fwGyHf/UN11R9QzRiaEUZXm/MPlgs1IXc/28d12/QlGtuQqy0xIc6i7IIJxs?=
 =?us-ascii?Q?CZOW1qLYysqaK7v/2/hBD1s=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa82df8-c501-40ab-2e32-08dd1a8677c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 08:24:59.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6umH3BTnh9maNY5y0yP+eSanpP4dp/5NIO6RXWjIajw0CRV5W7HIyJeOhMVd4QsH4VqdEwfLcuaTYB11up2/sme3KQKgUNNdexfe3n0+xxEKG48Enocy9la+uEDAxgAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8459

From Documentation/admin-guide/kernel-parameters.txt, we know that:
 rodata=	[KNL,EARLY]
	on	Mark read-only kernel memory as read-only (default).
	off	Leave read-only kernel memory writable for debugging.
	full	Mark read-only kernel memory and aliases as read-only
		[arm64]

So the "rodata=on" is the default.

But the current code does not follow the document, it makes "rodata=full"
as the default.

This patch set follows Anshuman Khandual's suggetions. 
It makes the "rodata=on" as the default, and removes the CONFIG_RODATA_FULL_DEFAULT_ENABLED.

v4:
  Follows Anshuman Khandual/Ard Biesheuvel's suggetions:
  - Change commit message format.
  - Change the titile name.
  - others

v3:
  Follows Anshuman Khandual's suggetions:
  - Merge patch 1 and patch 3 into one patch.
  - Remove patch 4 
  - update comments and document.
   https://lists.infradead.org/pipermail/linux-arm-kernel/2024-December/984344.html

v2:
  Follows Will's suggetions.
  Add a new file fine-tuning-tips.rst for the expert users.
   https://lists.infradead.org/pipermail/linux-arm-kernel/2024-November/981190.html

v1:
   https://lists.infradead.org/pipermail/linux-arm-kernel/2024-October/971415.html


Huang Shijie (2):
  arm64: refactor the rodata=xxx
  arm64/Kconfig: Remove CONFIG_RODATA_FULL_DEFAULT_ENABLED

 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/arm64/Kconfig                            | 14 ----------
 arch/arm64/include/asm/setup.h                | 26 +++++++++++++++++--
 arch/arm64/mm/pageattr.c                      |  2 +-
 4 files changed, 26 insertions(+), 18 deletions(-)

-- 
2.40.1


