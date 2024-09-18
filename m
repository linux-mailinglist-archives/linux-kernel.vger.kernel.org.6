Return-Path: <linux-kernel+bounces-332228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A897B700
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F681C2269C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AFA3DBB6;
	Wed, 18 Sep 2024 03:00:24 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403DDF6C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726628423; cv=fail; b=BIvJgd2gOEMxoeWdg3SHp86dt1gLI0kiqeSpQn8mYo+efVbnH5nhu1TJTiFlPDZ/aICcqSVikRpMgS5Nzr4QnVuzWtpO7va8xeWLMKUoHlN/5rWNO2mjdmC9d6JRlDFWQZted1E3O9e4YGYaLXHmmruqlzYEhZtr4vYNYMz+9KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726628423; c=relaxed/simple;
	bh=HVDVsL7PjO7DobXfha5qsZNw9ZH8oGZ9O8YxozJ0Nzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ec4Awcz+yP7Kg/WfgugLGRBC//SLSd+msx/tB2cvxuTtV2lo/8V9yYwcMiiSf1XEDEFpJK64XHx8sHxJ6fE+qeBd+YvaeBJtdWd43J4FsPkCYD8RZnH478pdkGdPAUWh0oFHLiwo4w8B7LGsghyGtTP9kOA1S5X4ld5KG55Y2r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I2UxJ0005960;
	Wed, 18 Sep 2024 02:59:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41myq1uq20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 02:59:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCvkR2vcYbh7+Jno1q1B0vR8ErAeanXSv9tx4t7wKoRex0oSxKCcp+IduRrG9xQf96mVoIfUTiDBqzZwzNB4uq0h0aNxKPG7A2DcluIW2qXD3D+Mh6qadskntUkvGG0URz9puEgDNgceap977IYBlkxot4A8H/8VXnf8YIDd9q0lB9rIK2y55zcyWlzbLhET5GYmDuLPrEY750SlSVUTtWyWpug+SeWh36RL3w20Va/DkEJta/DTBI8+EFiYd/DWuVqYXXCHjhmM7VTzlt0EeEAqhbPk5RYD9+Vb4nPJQRlUmKwEp8+hMKeTVL3Q8lj/EIOiYf6e2jDwdnoBFUD12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwBEzm/06z0vqePm2LWMiIt1o9XkCosKJWmzrngsM7E=;
 b=F12zI2uaai55iM9yEf29Txqulzf9K2dn3TcYzvj0KFp+dgkr90kAyTS9cZW0Tl9QoLywExGOsnn8HGCGyyRrMzYXvbkseCLnsmIIPFgoUr39hzQpOLH2KDtMyhFmx3TGCd5AuMXJI2bcwdn9veDJfEV+IVBTP8x0fZmr2M2wEtdplahCVhtzqxlaPh56Ie1f3Z5AYiF8xWR1GVCu2PZp+eJqJ8QGQ62ZVxwE7pm8fNp98zH9FZuZPeQv2hkd+CcleMS7VCVbSPTQhTFEj1v9w/B5AS3u/mQ16qAuxFBu28jYmT8+/MEKtxbhkxcW7nCohszwvytfbMYN6YwGBtJ6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 02:59:44 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%5]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 02:59:43 +0000
From: guocai.he.cn@windriver.com
To: tglx@linutronix.de
Cc: bp@alien8.de, guocai.he.cn@windriver.com, henning.schild@siemens.com,
        jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mingo@redhat.com, peterz@infradead.org,
        x86@kernel.org, xenomai@xenomai.org
Subject: [PATCH] patch for poweroff
Date: Wed, 18 Sep 2024 10:59:26 +0800
Message-Id: <20240918025926.233858-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8734mg92pt.ffs@tglx>
References: <8734mg92pt.ffs@tglx>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b1fb4a-6aac-4a11-8e7d-08dcd78df26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eQF/3t3DKlfPi0OqX3rACbil7SnWbmOiknoLynllBhcEyLeyhxZvFOn+VGuR?=
 =?us-ascii?Q?Wk9q26/ECWoErhNA/Cz3VgxUPfHF734oEBzqD3aaV5SWDpm5GQbq3SXC+6Sr?=
 =?us-ascii?Q?LHYuSrhKMGM/S5QJ89vRqGM8rusFy70YZT617LRQxF2RZdcJzY9q1IvCqpcw?=
 =?us-ascii?Q?HbpmafHqBd5oZRubRZCHT/yZlhwcBKQGpr06/y/fr3/q5VrK4eBo25Hjabka?=
 =?us-ascii?Q?61qlfjuog2aWSIurQRUXIUSdg5yfH9YT4Le0bgj3y+QC951GTn3RgQRdGuIJ?=
 =?us-ascii?Q?yK+2F4tVPAsJPTm0XE5gfAZRKfUsMNtRAqdLI7NpY41TEaxmk+A9d4G5tzeD?=
 =?us-ascii?Q?Ke1JufC+OJzy4E+6gUXQsozCwFebsbSjwL/5PznFCNChgO7w4S+QUL9oy+PG?=
 =?us-ascii?Q?rCdS1fHwjI3CYJYKeqPuVTQG3oUntVtf0uG0L62tEFAlG+XSSqrIOZIIC4Vg?=
 =?us-ascii?Q?CVx3mLz+QBHwyE9LJQLBY4VqsyIzEuZ6q9v9rRomcQmIxfiDpG6r1UOSOe+K?=
 =?us-ascii?Q?6ZMOcEb/HdMobtN+RMZNVpdrOd8NWKgZ8KjTVwDJ7WcgZchBqaiwHj94Sb34?=
 =?us-ascii?Q?JDqtOXBCNqxo+EtFlx4icEc87FE1jDD8cj5qZmmXN1pFW7ZKgduQjcJGvSi4?=
 =?us-ascii?Q?gejzCy/c7hyT4f43n4SRmmvrpHbDKxuU5um8hHltHMzeMzQC9h429NxBrguI?=
 =?us-ascii?Q?9CDr7JtbqTo05hcd0NlT9242Vos5j/hzt9FlOFJZWaCXugeT2eKhNltgs50F?=
 =?us-ascii?Q?A/egETA9cNrzDaTEOA6eX2jfCbyS97IRpKHpQ6wBNvhI6jTetCh0SM6rvXF4?=
 =?us-ascii?Q?hrHHsRhlEXaQ+TrpqAr7zvBgIog2fsDxyt9OJrFF1cbU9sSNHamJqzyJwhsx?=
 =?us-ascii?Q?Rp86yPgVG0datMKRGlzgUNmkVSByDoWTdpcS28/CtvSR/RlVdIUP4sBn8t1o?=
 =?us-ascii?Q?rOZF+FlbbIqEzW2+CoIKrQTUOUmHGwY+Ytbr2RIo7wOOOOJSRgtfmsf+jNCU?=
 =?us-ascii?Q?rB2jrumxrnC/zarHdtyO34pF2E9lHdX0ZY8QmBuYOy6SUZ4XCa+fLCbOxYDO?=
 =?us-ascii?Q?gayAbsNhYYPk78dSuHpzklnEDgilGxC60ijx/kJGADQiR0PVyxtDvxFcLbl/?=
 =?us-ascii?Q?UapIDgD57ut45uUgEkiavQWphO5mPxbWKwK3MBFgOlUqeifLkCuKnS1pQE5U?=
 =?us-ascii?Q?o11AkeApGNKp2HwF3D5JM4OsEgd4kO9l3R4jiMVcy3ypTfOqfmC6M+k+Gl7m?=
 =?us-ascii?Q?MXfoO05A6JSnpC8Uo2LMgW85j2FucreBUUQ0jEugUPCNMdKOu1StMsF83ncg?=
 =?us-ascii?Q?hn1nPgugo2OFB5rhYkIZTgm1qCfkAphdjQi7msF2IXFCMx/Zs6H9XSspG+RE?=
 =?us-ascii?Q?T1ZHNSgw7jX1KBOYaJgSVzw5IGjzD+smSdCdlZNefvnWmy648Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dIW6j7nfd0yCQyOyG9yr5JIlNuAP07xSaby0gCYhc/Ycsyq0v2QFmznw/5BK?=
 =?us-ascii?Q?CzVn5KNdoKXU6kM6Sbts/7KciWFZKVHomVOdrfHfjYsJc4cf6S+46nRXW2Fp?=
 =?us-ascii?Q?pPPY7JH3L5D2giXms2PWEqIOknwlNBuXseYAkObZg8iLsnIB1156waMkpZpk?=
 =?us-ascii?Q?nBSB9W/AzMlAw8a+rYNegDluHL4sGM8hC2XsFu+CaGRgoHvpHsYzQIwDWIk4?=
 =?us-ascii?Q?OuOCXnq7HfUB3c9dB5fVJOZTgFNdL2raKEx4TqbQFTrmbSVQYB5M88WPLBhL?=
 =?us-ascii?Q?one/t+BVOw7NBZAO2hJO+B6qMqSF7N2sPpIr6Dum4Fxm4cghY9jzLcT9Sgdg?=
 =?us-ascii?Q?GQxKYmv3vjedfMYvMaQWaP+q5khwB6creCjqhxfDU6is/fnsDb4yzqJLndCX?=
 =?us-ascii?Q?TtyPr7KZbTGcNC/PLF8EE+I+e1YJkar+zcebxZBvYKD4kj79NuRzHdxevJPX?=
 =?us-ascii?Q?x/zCwshCSuWVZRHmrfx4hYJ7PXhbsu/bzI6DlXefDGn55hjYhUiw3jmvCaVs?=
 =?us-ascii?Q?/07avrA2NhEpZFBVBLJnze7hXIF7CR9HUo2ufuBpiA5Uvv5CyGrw1RD0ln6g?=
 =?us-ascii?Q?NqhjHnT/rFQypDVeV8U2RttYoWHScLgVibglfReuWf/8Cp2xjUyyZ6mRlFBi?=
 =?us-ascii?Q?Oz48yUhhY79oUWB0YHl+iEG9mHuA6O/4QO2iE6/1G+U/shN/8ijF2QLQtIwZ?=
 =?us-ascii?Q?+475IByWoaOo2XE0jjL9vMXhhqSRwSinhl3yLnHNhGKeMeB4fs/E0ryUjKTn?=
 =?us-ascii?Q?MeFgBLQFhPFcDZwn+vAHTEGvYucsjeT8gIZxBboEjuaeJm+unFm2NL1YhlGz?=
 =?us-ascii?Q?eBYys3X0/7ByjBbUesg2hst6ktMFfIZcWpQK951P5JHzafgZAYFZHk7JFNSX?=
 =?us-ascii?Q?zEGSUXaHb7ppqlbLt8ZYDLrHksmjX4sOLUvjdbmLf4s0qpe/T8FIgfJ6pfbo?=
 =?us-ascii?Q?hkdmr1oRs2C//qIgRDHd/BFq6L7GyPJh+CKxykW4/iUbZguVcHCRC+MYtP56?=
 =?us-ascii?Q?box/jaiwB4jH6jX4v4KjK8QLnfVa5E/eli/4JjLrHq2hOKAD1VcJvaRtpI+b?=
 =?us-ascii?Q?AhaUbfyVxvukX4r6R1np1ZUSMGpxGxCWo/HqgmWBXH/j33Tb6ooYcFTx/QPs?=
 =?us-ascii?Q?zd1RnfE2yPxUQL5yc5W0SiDFAzX7nZ617irtK5SAuI4m2b3c58WB4BHlcGia?=
 =?us-ascii?Q?PFXuoKQ9sRFRz7vT4O6J8RWQhrGL6oZjc2qQqmIr86GJjXEKWQKI3wETpDYU?=
 =?us-ascii?Q?gUQ6bbMljVFbw46fGa847UIJXLB5/JgJDiFsRcWUwH3bIlyt8EXwuwTieipx?=
 =?us-ascii?Q?iHJrqhyYzL03jDuLsP1Fjiq4JxMYnsQNgDI2Y30gYwrshxoizSF3fbfx2E1c?=
 =?us-ascii?Q?uiolJg/W5NjR2hjNNtJsTpqbT5W0Gt7GOMxNkOl+BtNyLY827RlyWVUkRI2E?=
 =?us-ascii?Q?fk9/mH96lk7M2zu5f8XvjDPzwTRaXGiral/eUjAO9Zkzk5rFHFBgFZMsRtOR?=
 =?us-ascii?Q?XwlWeP4prthEOkI7ukJCh8zEurqwCAC/sveiywYww1htrvvYQhdzFLkMLCDX?=
 =?us-ascii?Q?f7yEoJt2/hbnSBEWWtwsd6sRpAXz8dECtsfxmjtwxoY961/i5d1v4aH0IDIK?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b1fb4a-6aac-4a11-8e7d-08dcd78df26c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 02:59:43.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml/OS9WH+Edfb88iklvb6TBt+xQF+QtTUIxLWo90XHEi4dIGca2XBqZkHEM06q7YhuJTT9MGJT3kcd7EyRgY1yb/EV7bttSUxUth8coQQHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-Authority-Analysis: v=2.4 cv=MYM+uI/f c=1 sm=1 tr=0 ts=66ea4224 cx=c_pps a=F+2k2gSOfOtDHduSTNWrfg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8 a=rwjpvru4nLiipjcMe6EA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: CUDRXqHF8A-cZauyst6LO5dyQJTvFVJp
X-Proofpoint-ORIG-GUID: CUDRXqHF8A-cZauyst6LO5dyQJTvFVJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=473 adultscore=0
 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2408220000 definitions=main-2409180016

From: Guocai He <guocai.he.cn@windriver.com>

My branch is v5.2/standard/preempt-rt/intel-x86 and I make a patch according
to your adviced patch.
But it does not work.
Do you have more advice?
Thanks very much.

The following is my patch on v5.2:
---
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/process.c        | 14 +++++++++++++-
 arch/x86/kernel/reboot.c         |  2 +-
 arch/x86/kernel/smp.c            |  9 ++++++---
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5f4e79d14613..4c1cf610807a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -975,7 +975,7 @@ bool xen_set_default_idle(void);
 #define xen_set_default_idle 0
 #endif
 
-void stop_this_cpu(void *dummy);
+void stop_this_cpu(bool sync);
 void df_debug(struct pt_regs *regs, long error_code);
 void microcode_check(void);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 2243af6530f8..35d5cf73716e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -590,9 +590,21 @@ bool xen_set_default_idle(void)
 }
 #endif
 
-void stop_this_cpu(void *dummy)
+atomic_t cpus_stop_in_ipi;
+void stop_this_cpu(bool sync)
 {
 	local_irq_disable();
+
+    /*
+     * Account this cpu and loop until the other cpus reached this
+     * point. If they don't react, the control cpu will raise an NMI.
+     */
+    if(sync) {
+             atomic_dec(&cpus_stop_in_ipi);
+             while (atomic_read(&cpus_stop_in_ipi))
+                   cpu_relax();
+    }
+
 	/*
 	 * Remove this CPU:
 	 */
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 3f677832fc12..389643727e37 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -742,7 +742,7 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
-	stop_this_cpu(NULL);
+	stop_this_cpu(false);
 }
 
 static void native_machine_power_off(void)
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index f2a749586252..9dee65b96115 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -112,6 +112,7 @@
  *	about nothing of note with C stepping upwards.
  */
 
+extern atomic_t cpus_stop_in_ipi;
 static atomic_t stopping_cpu = ATOMIC_INIT(-1);
 static bool smp_no_nmi_ipi = false;
 
@@ -162,7 +163,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 		return NMI_HANDLED;
 
 	cpu_emergency_vmxoff();
-	stop_this_cpu(NULL);
+	stop_this_cpu(false);
 
 	return NMI_HANDLED;
 }
@@ -175,7 +176,7 @@ asmlinkage __visible void smp_reboot_interrupt(void)
 {
 	ipi_entering_ack_irq();
 	cpu_emergency_vmxoff();
-	stop_this_cpu(NULL);
+	stop_this_cpu(true);
 	irq_exit();
 }
 
@@ -192,7 +193,8 @@ static void native_stop_other_cpus(int wait)
 
 	if (reboot_force)
 		return;
-
+    
+    atomic_set(&cpus_stop_in_ipi, num_online_cpus() - 1);
 	/*
 	 * Use an own vector here because smp_call_function
 	 * does lots of things not suitable in a panic situation.
@@ -256,6 +258,7 @@ static void native_stop_other_cpus(int wait)
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+    atomic_set(&cpus_stop_in_ipi, 0);
 	local_irq_restore(flags);
 }
 
-- 
2.25.1


