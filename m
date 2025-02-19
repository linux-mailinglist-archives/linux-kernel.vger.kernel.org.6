Return-Path: <linux-kernel+bounces-520733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF627A3AE61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91F01691BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA735155312;
	Wed, 19 Feb 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="T/LJtm1u"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2125.outbound.protection.outlook.com [40.107.244.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97FE186294
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926804; cv=fail; b=Q5IHv5p6xwAmbSgIVe33kzZsU83UcFSqZhZ1lzK+XQJaqmovGnWeO1yovwJ1qx6/0/2rWG9pSJmBF1F3SWIF9fJOXRmouAdegGLs/dN052IiS/d3lQQ7+cTLb4s4mWAV5P/JC3nCTRddwlPI+SMMdZAwbQnP985+BErkHsaZ6bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926804; c=relaxed/simple;
	bh=j0a0iKOaNLFDGaXK1REr50ClqMJ1/S9JvERc4PDBOmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5yotpzq8FhiUgSZChGudkz3+ifiNBV+KdPg3zRnco0J98cW6jSwmekOpiUbOpoCFvDRFd4jhFgX+4pP61ipysOpyHuFNzi5+W/5dFRY/wagV/XzjfeEHW1BrHSzu+U80HPnxK8enbkBGSbcciGDRxFEn8xC2AUWqsd36G+HpYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=T/LJtm1u; arc=fail smtp.client-ip=40.107.244.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3LozX8H986yJwSMR/NBzioFGgbaF9SkOY+FXf8Xubb8Nzzt/t2i22uggKCD0wU+leF1svBQIxmuPQMZWvi0Jyoy7psEliR0EXMB6hj3Ab3MOMoiugdnw/X5e4D9W/nmzhpbm0TkWY8zymWyCqMek0Ud/JyuQFCdkFz9AFCWzwsRmO2VuPgfn4jVYN7d3xcld5F6T6MLit87obHcc9krGBI8fRzNuh56PggRZBVgcHHEsQt1CBXXCj2V8rp09KfrTAy3Wv+U3MWGuVdeuFirwBlPwzW2lkeZPVPoB8mAQ/IwLQt2RGWydq/CqXibP/rcx3CkExsLqTygtFkTsz7j+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ty6oC2k6wKQl3LqSwtT2xtA7tpqUjjzDioIZ+CBLDM=;
 b=AwSE8Ddv47Nd31MZnTlZcrkVCA9f37tIaBE9C7BcmnffZn5EsncO8jx0GVcFU4ORLIniBt3Lz83VRj1Y7BoSYbfzA9/U50p8u3qDw81pb3foScpj//mczwWaUNPVkM3YAdnvqUIDSA353jEjyNFYR1SK9BSlknlbfEvcEuidLi5+Idxf3yVCchTMUZprOTfHaxLZf5PEo3qRGwt17Qzb+3DyX4oL54xz/qCK2uJAKB7jYEckskGDI7X0kmuvYI0FNWGLkoZ2eE1JQppIQsr+ewvgDCyf7q8gg3RplNsKm625djx+ZsMlSaqYqyRfGs4sMG3QhnYFtTLqwvzOSjsRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ty6oC2k6wKQl3LqSwtT2xtA7tpqUjjzDioIZ+CBLDM=;
 b=T/LJtm1uW+D8d0PeORuFF3d6m5JfBuo8+iraa7lZbwcyujEelg2fRxmhZcDKEmHleKDlKbNOnA4B8bEgBNNl7Ro13mOBIHNeTX6rrJ6CuJu0EO7YZWq7RSq9Ev5J428xwWE9BWSpWe5jjzKqyjql5TdrBve3uWj5iDskgSHx3Yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8501.prod.exchangelabs.com (2603:10b6:806:39e::18) by
 LV8PR01MB8552.prod.exchangelabs.com (2603:10b6:408:185::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.12; Wed, 19 Feb 2025 00:59:59 +0000
Received: from SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d]) by SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d%3]) with mapi id 15.20.8466.009; Wed, 19 Feb 2025
 00:59:59 +0000
From: Paul Benoit <paul@os.amperecomputing.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Benoit <paul@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4] firmware: smccc: Support optional Arm SMC SOC_ID name
Date: Tue, 18 Feb 2025 16:59:32 -0800
Message-ID: <20250219005932.3466-1-paul@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20241114030452.10149-1-paul@os.amperecomputing.com>
References: <20241114030452.10149-1-paul@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:b::21) To SA3PR01MB8501.prod.exchangelabs.com
 (2603:10b6:806:39e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8501:EE_|LV8PR01MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c40f9e4-79f1-4655-a0cd-08dd5080bbb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FRJp60nn/hp/nYuAgVu95CMd562I2aQgADqJjwCOQrdecANmr9xfR1QjN+9z?=
 =?us-ascii?Q?U0RGgDSmh7WienvS2B1k456rHBl2BQ8pKcQwtAjmpS1M1vlC7C2h+ZdXJjgA?=
 =?us-ascii?Q?kK8SB5Rrlkzecjy72ltV+k27bljivNBtdvJWsgrlbX1I2iIT/Ke+PTWIyLVZ?=
 =?us-ascii?Q?A7u6j4vsW9f3vtPigArr3QCd/YB+8FLN5rKo8dJnCbQeWOwUkPiyjVMeW7X/?=
 =?us-ascii?Q?95qrPFwm5v5darC7emPDFnzX2JIRKVzQtiYoDT+qhJLicP3a5EmU0vQi8lWS?=
 =?us-ascii?Q?krcWbMlxwHJufwu4l1iyct56WrK9Drfy9ybi5zgIifm/vBolqzgBFusMBUH2?=
 =?us-ascii?Q?F/N71IBWIOOPbgWrTQQt0OQCtoPi1vD/WcQUy2CGxprHebuJFacbF+JN7KCa?=
 =?us-ascii?Q?IGM1YaSIXtcOxs9Ctm0hqLkKHAAaPpm9DEpAF51RtI984pCGp8K2qnuDZnPV?=
 =?us-ascii?Q?W2eNYiQIVhe8Ngg5kzAwXzsxpk23vY2y1WPygs+9h7ybFt1MjyV/gKVHG3OY?=
 =?us-ascii?Q?Y7bEafxIC52sE/0hCQZ1M2MTP5NGQa1vxCifAQzw96AXE8cp3Q/zWyRsLKJq?=
 =?us-ascii?Q?QHepbz6zjhCoCp0nvFbUJaWWi7klrRcbKmDLnnO0k4d77tjsthi+W6wI7jHp?=
 =?us-ascii?Q?WdySlHNBk4li8/58R9qk0xXrcMAaHcFm+RGdyHjD4qOx0cjc2p6vGIsOgpvD?=
 =?us-ascii?Q?qxiG0FGOUQI9Q36MsF4ZdrT8puHMspVs6XHDPDc2KWeGEtulSah5PhauQVKD?=
 =?us-ascii?Q?coTUN86k6aOYWOQyOd6y3zHqSu2lcjagolC+JpxmSftFUzLQqyJlSgDOdVgu?=
 =?us-ascii?Q?GCmOi/PctUm9bnZJdmDRFZTZDJXrtqiXgOGk8piZ/2S0SN/U6L9Ehn/faiw5?=
 =?us-ascii?Q?UQyCaQlZBo47JJAzswlQsv2J4UkZMaoKXPAgK6ff4zoisohaiO81UR/z3Pdk?=
 =?us-ascii?Q?zearZQh77CHDeZm6k3NOibqOXPWBYogXu50hfhVRmDBMuLltevlEKsXkE2eH?=
 =?us-ascii?Q?U+3YB2uNiySTgIsH3asVdzni7Py1KpG92HNLqyUWqty1BoPg6pLJVT1g1zaU?=
 =?us-ascii?Q?fEKy9w7jBqRrQ9mR0uzM3x41fOMlbLK+4KmHvO+V6ccjA0n/EggNfHsBCjVT?=
 =?us-ascii?Q?g0z9UkhL26AlQ7Qyhun8JnB7rx52beqi/sdhBLTMLhYaIi+hLPxGoYS+mRfM?=
 =?us-ascii?Q?21RxQ/jvG7fxAvJVJZ+3V4wnN6HtB3Y2r3TwAzQQ0PCfNEo9YNblezy01rgx?=
 =?us-ascii?Q?Fj+b85afwOMXakkxAwLHFBMHs9FL9X9UcDNbxv7lfLY5Tkj9XUvDmBpAD7jF?=
 =?us-ascii?Q?L7Nzg+fOjTPgknLSlnBw5u4ojQLqZKklXZU/2FfGQsGlJGy+MQQDwbn9SKZd?=
 =?us-ascii?Q?qplC0efdTvM7vKQxVIl9nB/6crxmtgpxV8Xg4elKF1E18yrhy+wZOSTI9d0/?=
 =?us-ascii?Q?U5dAAYGvwz/ZhdC5wX1n6zEgWskG38/v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8501.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TRFnowarhyvmMubRBMFuGC+MCdB8st1BtCjIGizKn7A/A+XmuMTpPtier0S?=
 =?us-ascii?Q?7vwXFMnIpQydsqyybQyaQUJWQJMTNPyIctNa2FWeP+TVgWK2GENgpoAJJ2q0?=
 =?us-ascii?Q?QB/isEupx+WFVD87bdSSypWuJwlIOIN2h0y7fOUbICW3Wl8r6J3cOpt9L91Z?=
 =?us-ascii?Q?Ak5oElN0qaFhamo/tCZ9x3g20miX4IJQPsiC0/iHxBB6K5lamQZlh0dHtKXk?=
 =?us-ascii?Q?2VUEl34531o6zb0413hHg8re1mxS+BctjyRXlnjM3BhC9xWb82SMOTQ2C6Bp?=
 =?us-ascii?Q?L7S+pJ/vJfvJh/rQrk3x1XDdUQi482R4sA2CwYEa4WvevoKgG1jSUT+CADUM?=
 =?us-ascii?Q?x2Y1TATBvltEpQQBrhrzOMDepe4EW7H+Tdzmw157hAu2lBgd44PligPsYXka?=
 =?us-ascii?Q?vYHHtrEw1orcfnbmL9ZhCMiRgjns0pI60BC0KSbOum4exrqvZhF09SfKUlAV?=
 =?us-ascii?Q?JEhHPCjBAy5oDjPhufjUB8TRTJxkCUW6pZadBEG4SvLAQEZxWM3TBi8RSQru?=
 =?us-ascii?Q?rZXBI6X97AorxssQ4JAK+WeIHrFxreMxlNKC+3zSrpLh8ts7v0DFwuYsg/nf?=
 =?us-ascii?Q?FwyhLXVbHnj4zwK639E4enpn1zEkICglFPLcfoMbGfeo0rJoVu7HV5Hr3kjE?=
 =?us-ascii?Q?fiR9eHyOQxsWulakV/nmOunSrxUV2n1SbWeuA5jJMzim5JJTXGVKg5iMzK92?=
 =?us-ascii?Q?iBvOWExKZeUek3JVfG+/WtlT/5ggn4HbfSTopUaAulzyjPAQPRwfnWPsIMt5?=
 =?us-ascii?Q?o69k8bXbWMF8V1VZ1730ceiJ2A400MHLkV0DYIcFlDXr8BLwxFRwsv7G6Q04?=
 =?us-ascii?Q?CsZ6+lAyq7yoTTCnBLgHz8gaSyZZgTetUqtBZSr8yDjC7H19QaCgkdZvEzR9?=
 =?us-ascii?Q?U7gbtZqjDspru2AAPoz1xcOTC0JYwOcbs+PS80/kbX2QJaQ0Iz+YbaVycK4H?=
 =?us-ascii?Q?gR6dPv833BhT77b587wBPcQDrLHK+jbNHYnJNmTBf55iGUwih5wUrDxdQREJ?=
 =?us-ascii?Q?OTECVOkzHrIT0VtAY4eUtql+Kq4Jm3ykq2Cuw7YixwfUbs4XlG5uRFVYgLmO?=
 =?us-ascii?Q?pdyo0iIKNHJigNv6rQ2mjkprp3Bwm7n0L/+hntcxAQXA7FITOonX8dzUbtbA?=
 =?us-ascii?Q?tU6jb1dRgm/LcRV4WWx63t9dejb2qrHs0RVzsOI+CFIhMH6/deQAVYO+mBwb?=
 =?us-ascii?Q?29dTjxQwQ4aRfn3eirfMJZZTlxu+ajam9zjgV0xliKIIvHJAgyRbISM3f6bk?=
 =?us-ascii?Q?Z/CMC494RHMA9l+9NbeOyQlrW6qMZSDanjbWoneaGbR35U/TVaR726YXnz1G?=
 =?us-ascii?Q?gUki4bin+/VbSniuO/tJLFHyLfC6L+GPxKsj8G3MUYX6yc+/MDHjOxhDDx6T?=
 =?us-ascii?Q?cTPWUZRgbcZRocRzxDbaytjwHoynn8py3QPdSig2RgcYqE0/ljJlQbSUc4ND?=
 =?us-ascii?Q?pEBiu/GIq2bw6HW2Q7ee6Qnh/YNw5VvjicEt4r1AHTOXuJBLCSR0lTkFkqqj?=
 =?us-ascii?Q?bKGCmqibXNDbOT47kj+U5zN5K1zJKS3J6bNeTXD028CSdnLxgfhn3VPLkYts?=
 =?us-ascii?Q?6uY72AQNU0VwjpA8SKgeunUZvwRcVLtHVNiyLFyUrulXf8XaUnCbE/ljQrtc?=
 =?us-ascii?Q?H1yATjIMTM15VMpYX4yyvQ8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c40f9e4-79f1-4655-a0cd-08dd5080bbb5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8501.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 00:59:59.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StOEd4pGt8LFbXs59zv1sbz3pjmo8M+UQJF9+085QWl8HJGpldShsCfrIMJqch93wlrYs/L7Fm+5Z7NAQXiKcK7HBIQKTpJwr4948SIlmW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8552

Issue Number 1.6 of the Arm SMC Calling Convention introduces an optional
SOC_ID name string.  If implemented, point the 'machine' field of the SoC
Device Attributes at this string so that it will appear under
/sys/bus/soc/devices/soc0/machine.

On Arm SMC compliant SoCs, this will allow things like 'lscpu' to
eventually get a SoC provider model name from there rather than each
tool/utility needing to get a possibly inconsistent, obsolete, or incorrect
model/machine name from its own hardcoded model/machine name table.

Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---

v3->v4: Address code review identified issues of v3.
v2->v3: Add conditionalization to exclude SOC_ID Name from 32-bit builds.
v1->v2: Address code review identified issues.

 drivers/firmware/smccc/soc_id.c | 81 +++++++++++++++++++++++++++++++++
 include/linux/arm-smccc.h       | 40 ++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index 1990263fbba0..7b0688d78dab 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -32,6 +32,86 @@
 static struct soc_device *soc_dev;
 static struct soc_device_attribute *soc_dev_attr;
 
+#ifdef CONFIG_ARM64
+
+static char __ro_after_init smccc_soc_id_name[136] = "";
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
+
+	return NULL;
+}
+
+#else
+
+static char __init *smccc_soc_name_init(void)
+{
+	return NULL;
+}
+
+#endif
+
 static int __init smccc_soc_init(void)
 {
 	int soc_id_rev, soc_id_version;
@@ -72,6 +152,7 @@ static int __init smccc_soc_init(void)
 	soc_dev_attr->soc_id = soc_id_str;
 	soc_dev_attr->revision = soc_id_rev_str;
 	soc_dev_attr->family = soc_id_jep106_id_str;
+	soc_dev_attr->machine = smccc_soc_name_init();
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 67f6fdf2e7cd..eb7eab04755a 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -639,5 +639,45 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 		method;							\
 	})
 
+#ifdef CONFIG_ARM64
+
+#define __fail_smccc_1_2(___res)					\
+	do {								\
+		if (___res)						\
+			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
+	} while (0)
+
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
+#endif /*CONFIG_ARM64*/
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
-- 
2.48.1


