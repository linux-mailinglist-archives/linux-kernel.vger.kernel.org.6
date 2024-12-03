Return-Path: <linux-kernel+bounces-430226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411BF9E2E1A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013CB161863
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E34209681;
	Tue,  3 Dec 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JauFMhix"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022122.outbound.protection.outlook.com [40.93.195.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847B189F56
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261360; cv=fail; b=OF2vCClqVdc/xxjznmVsrGqJdEGZ1ymRDLQObhAJFeyebIZIhkJzpFaCCWUUBbbS8oag+9OCAkHI35SzehwL1OsSfqgmDxpx6rKuCX5OdaAgnDLs3rUBKYdXAM0V4NSi73aYkrmZR5tISUARaeeicMtsXa+UOQ5MUpDYObX4FwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261360; c=relaxed/simple;
	bh=slxMccmX0XbcCbsFKFEAKz3ojyN9m/t8dtULqv5GezY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMLUWTBnODW0SHt2EanOS78NW3mr95TdTva5VrN5I+XjIzOgyDItqlPcO6S46kNJZyEDQDocEJcJw/ftIzyzBICWrTj4nNTf7Xh+MmftzJDEc/qoor1AQ0iMYUqX3t8NJ9wPVOaAOwtmgA6PW+NcTU3f0xVsh8LD4a4ZvGBvsuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JauFMhix; arc=fail smtp.client-ip=40.93.195.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjrqOiMtoPNUh+Usp6QLAF/9xfjkwhmpYHIgvN1oiUZJx1lrhSucrfJyOX2JokhY8w0NGlgdFuXyvqw6e+h1woOOosN198ngD6ei9vs4BhFfuJvz/BFY8d4vtssBCgozf9E++oFIohLlzs7u8St7t/cAM2kHlb5LAvtceJTSx7hedYinL65zgSM4ZATJULXdyhumorvT9RArHIH45JnjVI/lzDRUDO5MepSc4I5ZJftIZIo/AZ0itoUYaPZt5jIFudbZqcjE1Mxvc5c//lXwZPPo/3IEQPRkMTGwfSl1/cyVuhjGvuay/J/McbUgeRDLlaZMlkxrrVOlq4ApK+lKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elSJ593gqMjVgyLNCi0WM0rPz2e+spNIom0FVBFG0ps=;
 b=br/Weg307sJFhPHo4OD+0NAFthNGY0ZdBAGmor2FIKvPr9RexloqD2HrLmWgmXmY8glbPGVz1Kbha9j80ExcRIcd1pCmTA2uEzRZHu3tu1M7+CVY6+VJgvwVKrROvzMTGKYj8d066kqQVCVGtjM7xLg3o9q5Ma1DZEZAxxcQjI91r5b3ZZIWEK2t5/28Y5uD7aJBO6syD/dB5f2DCH2TcrlOTg+wPq5wNzKVL5s0mSq8QDzkjmyXENaYd/wqLC4K6BfKmnc+qycEKeMel1Y6W6+RKjvVptPBUDeMM/HFj3sMB9iY3dKJP0JkLreZQS2hPzA72ASQSaRYGNhT2ofT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elSJ593gqMjVgyLNCi0WM0rPz2e+spNIom0FVBFG0ps=;
 b=JauFMhixfYozjXVcv3CbdcSLOigcJ1+rngvy7yVX2hmJO3X6+ZkLEoAunlupM5XtSF7o58Aq+5QZUp+1+rGNhg83vaBIYnOzQspCfAUXbglevvA0XZHZ+dNb1EOzEZ5zTTCdqK4U26lB8gBhCecT57IvwX6c/BdFxy0tiM7Z5p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8501.prod.exchangelabs.com (2603:10b6:806:39e::18) by
 PH7PR01MB7799.prod.exchangelabs.com (2603:10b6:510:1da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.8; Tue, 3 Dec 2024 21:29:13 +0000
Received: from SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d]) by SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d%4]) with mapi id 15.20.8230.008; Tue, 3 Dec 2024
 21:29:12 +0000
From: Paul Benoit <paul@os.amperecomputing.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Benoit <paul@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] firmware: smccc: Support optional Arm SMC SOC_ID name
Date: Tue,  3 Dec 2024 13:28:54 -0800
Message-ID: <20241203212854.5565-1-paul@os.amperecomputing.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241114030452.10149-1-paul@os.amperecomputing.com>
References: <20241114030452.10149-1-paul@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::21) To SA3PR01MB8501.prod.exchangelabs.com
 (2603:10b6:806:39e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8501:EE_|PH7PR01MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: de1cd64e-fb04-4763-c29d-08dd13e187f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1w9xLMQY650yNwWTtAwj5sX76M54xje7p/JRbpmth/L0+sJJ99g1szdjAIBF?=
 =?us-ascii?Q?3rW7XxdvPzHXZGBHIzFL1iMmU2lolviUnrtsXI4FA9wK83GXwEmFhVrhDLDs?=
 =?us-ascii?Q?O/TLvubDUdh+3kUwGZ45tXu/CLIwFnAfNV2sfAENsUmUaQCackBo0Z74b8rD?=
 =?us-ascii?Q?3ugpSSXsE2grn6isYGH4pSrABBesrO2Gy5d2IAG927GZJ6OTiUWbEaP5hl4x?=
 =?us-ascii?Q?oXnFZjg60LulSxBUnDYoGH7r4gqOgtVpAKEGylpsN5qO3pFxySlIpmBfywd1?=
 =?us-ascii?Q?sj59wtWIBADMpTy4rr+EPv41qoGooDYCYWbzqJFOtMC//m4EzvtbrRe8lMrZ?=
 =?us-ascii?Q?uZzubvfDUjJjIw5isbpG03X3eSXMVFCSM6uwEGzhJulLosSaYN4qlkoj/SWB?=
 =?us-ascii?Q?/k2cRoyxlwzNMhJH14mVclOh65jg7zGL3rdwCi/5NPBrs6eCsxAVss03azAn?=
 =?us-ascii?Q?ZJ0OqjjihjJjukv88RVjb6v0BcQsygpJ+YcCIi6xnq4kNoz3NWzl61PJxjyR?=
 =?us-ascii?Q?NvymGdkUR5KR05f3TxGnGf+el2RYDcPTQ98WLYKW270uRixp/tpIpVKeYw+B?=
 =?us-ascii?Q?UP2IwK1mqxstBaFICJ+m1LPCSqdePedHI2B7qz9CEkE22CUeK8GvkpLghfI+?=
 =?us-ascii?Q?P2VfCQysxhJc3kBzX8jdbvNdjGx38d0oBsp8Laz1nTY3+yBNqLmdzBfHzr6G?=
 =?us-ascii?Q?YbULNmMk/op3kvkhAV8XWnYN+ot4ak+uGFD0AvcfH45IWOK3iRP49iY+Sh91?=
 =?us-ascii?Q?bpZ7ANB6IMT0WVo09cnZpqLYb4uEx3AlRUsMqQvJDUCSQxB2jTqwEsjtlRpQ?=
 =?us-ascii?Q?pDfw9C/1C5JL+vmcV09Jv2FbmHyi7WTBg4UiP4sMTED3NDwAhl2bWRDVa19r?=
 =?us-ascii?Q?IWpWua6zTWkJMdNYV0LMyspbkWjvN6rv4kJiHhIj4oprKfd0I+NkraEQRrm0?=
 =?us-ascii?Q?8FHbj78aRVZFuC/iupRmXNkGsWylm/+jjdO/2WEdEhRBZlqxxdKRDmc7q3kk?=
 =?us-ascii?Q?NAFukMC33P7KNfubOTES1kCBjCBlmXVHZwIDji94RNNbe3eqyfGCOuq47qwI?=
 =?us-ascii?Q?dFhu3wmcW4eMuYOcbaVvpNSRBfiZdClG4aTAnjwPlRqPk7RlxTGG1ROjXwfD?=
 =?us-ascii?Q?7YWCssWm3JkMtW/Y1dygbGbEH40vfXv1he9M/GArwzX5fRXZONgVtn8hzf3o?=
 =?us-ascii?Q?05rmCE/4AjyCZxHnqf1VdDHfsJWlew0I5gEF0R+FE0YouVM36W8qDVPlthOp?=
 =?us-ascii?Q?1OXMapQijAxQYml4XrpFYi8p0mOt0vlJCdQipZxBFWlZRYD1QNYrdWmmn4rh?=
 =?us-ascii?Q?kpXDMJuk780wDqxh/+hnCxeBcZC6HQYYHIgs0SWV8fnBWkfDa864HKGGQEzV?=
 =?us-ascii?Q?E8ApJNPhnvLm4ZLrKScL7DgtRXR8X2hNzKvxqisMVQpWWsFqlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8501.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spkFx73VbaNIU8bCPqKF7JhGaA5G4vAqSx8xHVBsYmkmgO+Tg2c3YxGQ5eoU?=
 =?us-ascii?Q?3Im5E5BQ+vF16n3jbap9xeU6o8ujFHGVzFpJzH65B0K9yFSV/hf7CR9KhmNe?=
 =?us-ascii?Q?lG8W/vOcTAqtS0CUGaYC/b66F5wtCtqntBbODX1R1sKpG8UOmZHPBIx32Px/?=
 =?us-ascii?Q?V0lIuNSMqQXKD+nfsy2C8C9G2q7AEA9xumnmUtsL4lyGWYKtKizcoEpttpDm?=
 =?us-ascii?Q?2bHkp45rNi9MYMW8+6pn9CIs0O9a3tM80NJoSKbdntL3NxcskzgZsTXZbCx/?=
 =?us-ascii?Q?aRa1x67QHSTxKAkldPRNAlMpPeCdAbo9snVCKL/+FLS9pyhWFn9ILqhmlw6N?=
 =?us-ascii?Q?z4EhXzN3kKGbhlhtusIdvwHO+TYGUIWxVbtpB8ZKjxFnmCw9Xmpmh7CRubP5?=
 =?us-ascii?Q?s2YASq2eH0F7J8bDbaq9xaWTwsnI3/7S9qH8C4sIfLrPht4a5V19SlKQ8iQq?=
 =?us-ascii?Q?jD2tA7JE/uKRfhX8J17H81GLNeXYvkTAnHdEQczlaslvEIH72a47GzvgUzI+?=
 =?us-ascii?Q?a7cUXdltJxaGVCtse/lYO5OFlH95xtLYkRzKNzAGuhMO5elm0WOATYR/tgAx?=
 =?us-ascii?Q?w2uB7uyvZIksYSSuXhR3cnNZoqyeZjmih/hUIge46bN7/ME2RhbWbdepMxZs?=
 =?us-ascii?Q?jxY/ukZPAhSkxunnlq4dY36fRpAKMZTwPVJbRR4gKl8MR89RoOcoaIl2uvrY?=
 =?us-ascii?Q?YY98oP2ZIwqg/vU4OKt+jne5pqJzf2Pgp77T4mPu5dmbNjMB/L8uFvzaSvu4?=
 =?us-ascii?Q?EwVzhgsFXQJxyMkKWuCyZtsEGwnDyv19JEgVCric+fB/VKzORMBFxQEQ2w+F?=
 =?us-ascii?Q?TX/OuBG0OgGT39OK8J6EyuRnry/KBY61Fl1XUMyQMZslT75YcpjFJtOo4qPP?=
 =?us-ascii?Q?DH3+ELMvFgnD9MfD7sZN1+vBqK1Jph0QmqBXEdFuKhKJ1C58eAgWImkzinlP?=
 =?us-ascii?Q?D+EgfuYZi7H4n7S74Y8IXaQe8MbRW1WKvJBT5eF1nI0SUtbe+lQm58nfQ5ON?=
 =?us-ascii?Q?Gqa4qeJhId9wrKDP9xDik+LmAaXE6DdKowS5pyirXR6rKxJrOJ0D/hPJpwkn?=
 =?us-ascii?Q?GZx867tJcJdnrM3OXdCq65YyiGje5LF3Cc2TkTcLV1ujTO9dNSArgl9DNRwi?=
 =?us-ascii?Q?jTlL4M173X4JWK/Xq3oH0xSx45rn195xVPr/ohsBdPhcaahmpmoSWV+E+Al0?=
 =?us-ascii?Q?1lmyRUDMIpXgUnyzTWO8ueg/vfOx+6Jo09EbJSGd9P3YJteNpJQkIv6HH8Ur?=
 =?us-ascii?Q?TpI+uAjjzsyQ9OH+VnlEM7tqR5ut84KFQLeDZ8RrYolIaGZ7j3/3OkwoPgDL?=
 =?us-ascii?Q?Ba+cB4XbbkRO7MFC57dYni8c7abNBY66hl89hktAB0xEtyAdMRxJaZ/88GGC?=
 =?us-ascii?Q?xXa6QLXS5R8OcrmXQ9w5Yj1LQyDZxfJJi4mCLX9rXRYhaHjQ8sapF8oymKY6?=
 =?us-ascii?Q?vApO13a0/N9UkgJT4Xs926+YTV5g4mWTYJ3bpmMYHrUjm0aDmFVm3OUWCsuq?=
 =?us-ascii?Q?Yk8fpLEaPu/WwoLimW9uNVeMDAOIvPhKm7S7eJvbTlU/FVdZXh7/beqZJRDz?=
 =?us-ascii?Q?fyjzaHwyWkLFIccrQpccrHHyg/hhn/vyalBvVw2d+xL+j/Ozct4+Ndy9HZ7o?=
 =?us-ascii?Q?oDY8wcf5o8KsQ2gst8YtTus=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1cd64e-fb04-4763-c29d-08dd13e187f4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8501.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:29:12.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXlpkFwwnIliwfChm0Si5HeqvD6k1dZG7cilzzPnD0L1xPPSk+wxPK2qFszuIg41mrUO+w3Cw+WMTlA3nznKJUXxF2ePvuKvNcdtfClupEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7799

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

v1->v2: Address code review identified issues.

 drivers/firmware/smccc/soc_id.c | 75 +++++++++++++++++++++++++++++++++
 include/linux/arm-smccc.h       | 37 ++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index 1990263fbba0..b72d100bdf31 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -32,6 +32,10 @@
 static struct soc_device *soc_dev;
 static struct soc_device_attribute *soc_dev_attr;
 
+static char __init *smccc_soc_name_init(void);
+
+static char __ro_after_init smccc_soc_id_name[136] = "";
+
 static int __init smccc_soc_init(void)
 {
 	int soc_id_rev, soc_id_version;
@@ -72,6 +76,7 @@ static int __init smccc_soc_init(void)
 	soc_dev_attr->soc_id = soc_id_str;
 	soc_dev_attr->revision = soc_id_rev_str;
 	soc_dev_attr->family = soc_id_jep106_id_str;
+	soc_dev_attr->machine = smccc_soc_name_init();
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
@@ -93,3 +98,73 @@ static void __exit smccc_soc_exit(void)
 	kfree(soc_dev_attr);
 }
 module_exit(smccc_soc_exit);
+
+
+static inline void str_fragment_from_reg(char *dst, unsigned long reg)
+{
+	dst[0] = (reg >> 0)  & 0xff;
+	dst[1] = (reg >> 8)  & 0xff;
+	dst[2] = (reg >> 16) & 0xff;
+	dst[3] = (reg >> 24) & 0xff;
+	dst[4] = (reg >> 32) & 0xff;
+	dst[5] = (reg >> 40) & 0xff;
+	dst[6] = (reg >> 48) & 0xff;
+	dst[7] = (reg >> 56) & 0xff;
+}
+
+static char __init *smccc_soc_name_init(void)
+{
+#ifdef CONFIG_ARM64
+	struct arm_smccc_1_2_regs args;
+	struct arm_smccc_1_2_regs res;
+	size_t len;
+
+	/*
+	 * Issue Number 1.6 of the Arm SMC Calling Convention
+	 * specification introduces an optional "name" string
+	 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
+	 * available.
+	 */
+	args.a0 = ARM_SMCCC_ARCH_SOC_ID;
+	args.a1 = 2;    /* SOC_ID name */
+	arm_smccc_1_2_invoke(&args, &res);
+	if ((u32)res.a0 == 0) {
+		const unsigned int regsize = sizeof(res.a1);
+
+		/*
+		 * Copy res.a1..res.a17 to the smccc_soc_id_name string
+		 * 8 bytes at a time.  As per Issue 1.6 of the Arm SMC
+		 * Calling Convention, the string will be NUL terminated
+		 * and padded, from the end of the string to the end of the
+		 * 136 byte buffer, with NULs.
+		 */
+		str_fragment_from_reg(smccc_soc_id_name + 0*regsize, res.a1);
+		str_fragment_from_reg(smccc_soc_id_name + 1*regsize, res.a2);
+		str_fragment_from_reg(smccc_soc_id_name + 2*regsize, res.a3);
+		str_fragment_from_reg(smccc_soc_id_name + 3*regsize, res.a4);
+		str_fragment_from_reg(smccc_soc_id_name + 4*regsize, res.a5);
+		str_fragment_from_reg(smccc_soc_id_name + 5*regsize, res.a6);
+		str_fragment_from_reg(smccc_soc_id_name + 6*regsize, res.a7);
+		str_fragment_from_reg(smccc_soc_id_name + 7*regsize, res.a8);
+		str_fragment_from_reg(smccc_soc_id_name + 8*regsize, res.a9);
+		str_fragment_from_reg(smccc_soc_id_name + 9*regsize, res.a10);
+		str_fragment_from_reg(smccc_soc_id_name + 10*regsize, res.a11);
+		str_fragment_from_reg(smccc_soc_id_name + 11*regsize, res.a12);
+		str_fragment_from_reg(smccc_soc_id_name + 12*regsize, res.a13);
+		str_fragment_from_reg(smccc_soc_id_name + 13*regsize, res.a14);
+		str_fragment_from_reg(smccc_soc_id_name + 14*regsize, res.a15);
+		str_fragment_from_reg(smccc_soc_id_name + 15*regsize, res.a16);
+		str_fragment_from_reg(smccc_soc_id_name + 16*regsize, res.a17);
+
+		len = strnlen(smccc_soc_id_name, sizeof(smccc_soc_id_name));
+		if (len) {
+			if (len == sizeof(smccc_soc_id_name))
+				pr_warn(FW_BUG "Ignoring improperly formatted Name\n");
+			else
+				return smccc_soc_id_name;
+		}
+	}
+#endif
+
+	return NULL;
+}
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 67f6fdf2e7cd..9d444e5862fe 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -607,6 +607,12 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
 	} while (0)
 
+#define __fail_smccc_1_2(___res)					\
+	do {								\
+		if (___res)						\
+			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
+	} while (0)
+
 /*
  * arm_smccc_1_1_invoke() - make an SMCCC v1.1 compliant call
  *
@@ -639,5 +645,36 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 		method;							\
 	})
 
+/*
+ * arm_smccc_1_2_invoke() - make an SMCCC v1.2 compliant call
+ *
+ * @args: SMC args are in the a0..a17 fields of the arm_smcc_1_2_regs structure
+ * @res: result values from registers 0 to 17
+ *
+ * This macro will make either an HVC call or an SMC call depending on the
+ * current SMCCC conduit. If no valid conduit is available then -1
+ * (SMCCC_RET_NOT_SUPPORTED) is returned in @res.a0 (if supplied).
+ *
+ * The return value also provides the conduit that was used.
+ */
+#define arm_smccc_1_2_invoke(args, res) ({				\
+		struct arm_smccc_1_2_regs *__args = args;		\
+		struct arm_smccc_1_2_regs *__res = res;			\
+		int method = arm_smccc_1_1_get_conduit();		\
+		switch (method) {					\
+		case SMCCC_CONDUIT_HVC:					\
+			arm_smccc_1_2_hvc(__args, __res);		\
+			break;						\
+		case SMCCC_CONDUIT_SMC:					\
+			arm_smccc_1_2_smc(__args, __res);		\
+			break;						\
+		default:						\
+			__fail_smccc_1_2(__res);			\
+			method = SMCCC_CONDUIT_NONE;			\
+			break;						\
+		}							\
+		method;							\
+	})
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
-- 
2.46.2


