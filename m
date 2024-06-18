Return-Path: <linux-kernel+bounces-218498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F74790C0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9194A281B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408875672;
	Tue, 18 Jun 2024 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="P6kR9Hzc"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2103.outbound.protection.outlook.com [40.107.244.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5A7483
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671886; cv=fail; b=Hbk5MZaXUP4EhMO8Cmpmzfz5g7jtH30W4nfZPdS4cPYfSIiaW47NWVgDgcX+N3dcJlur+tPewHK9PgWWWAql0eRc2C57RzicAqick+Pe1ZP2DZ0lFv/I5iwS4U7I3vGkTm5SVtlBF/rWcx0I8lLUy7Kf6Y3MJ5Jh/Z8y1DFzyM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671886; c=relaxed/simple;
	bh=Q26OoYSv4Dzl5E9Aqxk2jkGmYkilLSzNVQWOsrPcwis=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fu+YIeLrh8+I3QaZpa/oxbhdqM8KUp3ez/KXbYppAmwpuhFRZZCQ1kxNj0T5m+XaQTZrJgrzYhf9jRT+iZJHLiWd3nvvmHmNtWau+Jlxmi71f/QZ5Xh2Pb4VRDRI7+NP+CLPdurItmK3HIGq9ukIZr/xC7Pay0pk4uesrMEINps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=P6kR9Hzc; arc=fail smtp.client-ip=40.107.244.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSromftFS1get3uyCS7GUzFdRJD12BtHCT4tG8143deWn9mg6hMRBYRRDDmW03kD03XiDqkGj/S5sVUeC3S5+CqUshgLOWAAIRPMjHcCfvlgPuyqiDDWKD8Ao0upInHBpu0ApGFV5VJb/xb1Sq60V3QMiPXGOdmNPTB5SyrEvHxDVqtCx8AfBrTPlZ2ixEpEnT6HK5kwvCwdpxAeqi1Mw7NmvSNBktAsjCqcs6hgGM7laWZvu6dPDj61fR0cQCrYGGhcp+61B8nG7FI8TCFXB4I7LjWqqfNUJpGJ296+iBa9Gjk37nijqA4L+0mFPwWK4y0KFU1Yic23ivMs6Y7tHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKWoEWRYMshx6zMGLdjrj4hRzjiylxM5Y3lmeXaCOT8=;
 b=FPq1ZscBFnxXmRBCr8pGrLdtmuX+tHYJWIvlZoX86qFNP92eZ9R3t/jMr7dFwPBwFnCnfOG05slWvxYDFPSIMkVqf1jR/1AqathcBi/JxDkHyivvmIerKLzRXXJH7E5aqdM57r7r7Qyi5A0yDNu29eQbi7HgWwczq79nNGm4//LigpxQR/pTDitQ8Ka/2NANgOy2BuAeUED1RSUqoBBjQf/wbU+2rimJB++LYVDk7EP9dAplV4kZT6Nsguv6kB4tcDvkKejIW9JnCfx84BaiR7zgdKaHpisKVsm6r2VhrItFxAue9fEFbdr+E0fG3n46n6/NqT7gYcjPfk08Jh4Axg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKWoEWRYMshx6zMGLdjrj4hRzjiylxM5Y3lmeXaCOT8=;
 b=P6kR9HzcSihWmxZRrwB6zi9kktoKAJWqz7tBjKsk7nRUwP98oMsEGqVlEJANDSOUUP96LwjLe3Mu3RBoxgEmBaAL3xKKfBMcnl45Kx8q7TvDFl3sFNKegiwVyh87DK6zQAPjUAQqDRXxV0zuAKofk1zrk4+i2ZHqC7WFAh4lrSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 00:51:21 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:51:21 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v4 0/2] Mesh PMU: Add tertiary match group support
Date: Mon, 17 Jun 2024 17:50:54 -0700
Message-Id: <20240618005056.3092866-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:610:4e::35) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CYYPR01MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6fbf8d-0df8-40f1-54f3-08dc8f30c518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KBKlCEcVMWSRKL77b2lCeZikMDURXxu0lnf+iuVGh+Mn8cB0mPRBp4bJt1gm?=
 =?us-ascii?Q?l3ABNPgXVzJPh3esW0Hgp1EJ59wKdp7Bfhm0ixsTip9M26HE5Au6ggmpd4ky?=
 =?us-ascii?Q?GuU/clfGf8brjGiV6nMhqHOk7RmKlCxWk0uiXzLx/V+ujCRUdfrMXfqBsJ+8?=
 =?us-ascii?Q?eknpEfgBeEMDYL2yfpm7e8FT3+PeL93srPgKg5XfXSLCIr5Hnx9grlbinCM+?=
 =?us-ascii?Q?rz1sFmwKc00RYuqhsz20qb2C1+i7EYQZ6lpG1D1BTRa0fQgSF1ORx9+bwLiS?=
 =?us-ascii?Q?901OQV/hk/REcf9ODxWbh3nHAZvlqpuHcF6Pu8IJMEULwiEUqTWkwas59U8i?=
 =?us-ascii?Q?GLEnOmdq9I4uG53Gk5mw1CdhEFUa0L/ipwR0/mjMcrlqZn5vlbCHZvgsfe1a?=
 =?us-ascii?Q?zvzZxG/vd2FNC7h5khMqcWJqkxQ2sv7XCZe5vZZUnLFy4GBCDDCJPO5t6QJ4?=
 =?us-ascii?Q?RbYg4iB7/n25872ClvVmByRhPA7ReIgjbvffGUcFCtcKmIIHXNHekDEBJebg?=
 =?us-ascii?Q?WzNFqv9qo9FUwTEtygnFb21B02ERJMQRYfSE+7164Owtr9hhUEaIvoiIVhS9?=
 =?us-ascii?Q?UD2mrDIcxJYKXbkJC4xvmn4vWJs2iVkZdsiBqCnh8RYK2VYHyJka1HFNXjrm?=
 =?us-ascii?Q?UyGLwNE5JYYgPUqkhVMdYM864/JwucjSEGnYRpubiYSpXJoFJBkOCeQQBbzS?=
 =?us-ascii?Q?0spkrPq1AIr/LnegVWBLsEj1QkYrrFN2oMi/zKukN3JviybnFDKxKAwToLND?=
 =?us-ascii?Q?pxv41PqaNgyiJAgOg9xfdUWNCwYrnM1v8FxT/6QO3elJc88YtekxFV4dHfdf?=
 =?us-ascii?Q?hztKnUBr7JxmDAHU88jHxtcdb26DmYaHYqMO6niA/WsoMeCjM/9zun4a9rzA?=
 =?us-ascii?Q?EJJGFdJ31+sHUkI7cewHR/y8UbxjdK7uhK1U5D+dO02+l8PPsZD9743BFlAh?=
 =?us-ascii?Q?qKdt4mxGe11urHnmcRk7utnvLhzXDVKXHSg/vrqzJm3uvupswLV0I7ncWJ5N?=
 =?us-ascii?Q?vxtR1djhVUBnev9/7c6wX+UavHj00lgP/8UCXIInzysV9Ppu9miWdnpSAbVP?=
 =?us-ascii?Q?yxS06MHoIayL7s/2EI56gCkeguOcqPIeUDLpBwPhGa4IoVnziDA/M2wKf7kF?=
 =?us-ascii?Q?li7wAFXNQODpnLeiWeR3scAJm75JFFb3UDxmek+t5m3zG434AAp84/v21ArC?=
 =?us-ascii?Q?0a2qVs2odaiz83yYwGlhwgocBSjo/JcpXVmbNyP01SQuGxOxtsz35lv+0Nml?=
 =?us-ascii?Q?NcpuYodGDn+XqA+d3LIqKx2fGh0twEOOTQbr8pMJU++WFE1+UE/eGXs9KJzq?=
 =?us-ascii?Q?BlejvoFNoGC2zR4TFcgCwgW2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(52116011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gUKSW0JeI8EdotgL4J23wprNImNxCXLydPJcxt069Z0RSGmE6b1xTCggKeAh?=
 =?us-ascii?Q?5bfZHgM3dp8uhE0VdjFFYJ5hVQ5L5khnXFEBzDgLsAYkSRP0X9jKRm3nGhgE?=
 =?us-ascii?Q?X2LoIaHeXx5qkVYYZFyC535DrvDvDxyZfmajbQbYccGH7RgEipsiS8Dri27U?=
 =?us-ascii?Q?9DIQn3shKIqWpwfm/3D/BGa9WZCzqh/lV8YucG0VJoIHKINksF0joI9Eu3jM?=
 =?us-ascii?Q?xwe0htN36OeTOLBq1zoDxWVAil6ntrvSLwEBA6FyGSD2fSJWhialy+qg0OZz?=
 =?us-ascii?Q?w22okOywhF5MuPg3+6B2TrlBO++bey1xVIjCtmvL3SOQhpTJqiXqrBXenSKD?=
 =?us-ascii?Q?zzxa8N8p0eNwLjSPjSm7QG/hTVaj1J2HzlahI46NZljgUi4eSwK8yj20rIeL?=
 =?us-ascii?Q?b8BgAHyiu77RbXpzDcVlkeLDLig2iAqoT3iV8zj5hAbPE8C+7KajkjAwmeW+?=
 =?us-ascii?Q?hYyEZ1WU9jRiYElbSkD0reaxlJ0DPWr5l+ujjHOPJRqodZQAXtBREYpKUVH+?=
 =?us-ascii?Q?da10CHlPj14gTrADygNu2HYfft2rhuiyUGTG15KXU3uVzgF0cABM0JEqqagc?=
 =?us-ascii?Q?phqDfAoudksIjvZ1Uyuhk357FWekxoRA9uc+49A5UFw9h1EJptVLDssDdfXa?=
 =?us-ascii?Q?JYFK9VCNZofB5Wl2W6RZ7e9dqfph2rvGIHcmdowRMW9BHxiubzFrJyBom34L?=
 =?us-ascii?Q?cnYMuDRb8oorWBu7sl0HJT7KOapQbw2zuXYEJMvkQji99Tir0QdYJ/VcKWzV?=
 =?us-ascii?Q?72EnBoWDMOaXyBJX5yWJtJmbyC0GqUZHZBGKxiLVWdR+dl1PkSL4cRVEdyzv?=
 =?us-ascii?Q?kBfGQA3FJCODR1N4/I2JMrCeYE1W111WTxcNqJj863RQMhZYpC93ZImy9EL5?=
 =?us-ascii?Q?Nos4hBGWjKesAZr9eCKq1ZdHH41zzcRnjTWK+15JfBiJLCcktX2VGjTggE0l?=
 =?us-ascii?Q?swsljQF2zSVQQPiMYaD176SxnruQ3e749mJ/oIrztw2MbeaCoqFbLRdX3gNh?=
 =?us-ascii?Q?dBuePTVyORqAzQYe8hf0M80RTkMhLa7s4r5wtLM4CT6BlmHoDGHU+V6nA/v6?=
 =?us-ascii?Q?tioPpJ3dGaxrMXfk1E/hYXUvnwZpbavc7hY+4SGEO4Ka9RFYO96XdvuZUfjW?=
 =?us-ascii?Q?URruzOk+rBdhnUfQlvE4IThHwhw+m+EoP6c/1qt5rpixRCFv4nP9zusuxuVp?=
 =?us-ascii?Q?WxmpNDMLEXMDj+oKJhcJFDsLev37F+/chwIT0WGvtJrhYNZT+QmvKstfYsOP?=
 =?us-ascii?Q?G4+SYqlwtaJ4ZSWn0trOg40OibJ3+YLzLHV2YlDMN2GV6BIrKo/7aEwNIkmC?=
 =?us-ascii?Q?OtXT0NxUwJvtktohGUi3AxEGRR3hzqGKBOaqR5ILgzpa1rxnmTdaoWWtRUvL?=
 =?us-ascii?Q?MXmkWqjmJiomH3YtzbOSvROxHaWsFkmoFV9tUsi5ENdKVyn2XZoJ/uFA9fCF?=
 =?us-ascii?Q?kqsb4S4YJoEfCFYrDM2u09Cj/V8xQPgJcx7yD/dwk31srqovFauSlo/4fdOg?=
 =?us-ascii?Q?FTg8ZYcYnsrbGTvRPGzj9eWntWmofkvKKqmSAGmYz5usICDCTJS8UApcbPm2?=
 =?us-ascii?Q?JdUBLrtzCL0NYtG1Wq9LiKFKSunlXHouNWv91LzfExnRPOvrDcr7nGRv4nkm?=
 =?us-ascii?Q?GCafMkN95KBWi5Q/Ov2VD0I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6fbf8d-0df8-40f1-54f3-08dc8f30c518
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:51:21.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVvYOCWJB/akk1XseHb3wPoevwCQB6zHkjiX2La9pn5hH5ON64HKJgqsjyLf6BE/89KaDhPsP4TNq+3oiP3gpNTCqAVHQCvPDMe96OOkggwRFZ7q6VYhxDMW+hBCcd+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410


v4:	* No changes, only rebased on top of v6.10-rc4

v3:
	* Replaced wp_cfg in arm_cmn_hw_event with wp_idx that keeps
	  track, whether the event uses 0 or 1 index for the given direction
	* Cleaned and simplified allocation/claiming of wp config
	* arm_cmn_val_add_event() can't and won't fail anymore
	* Separated wp_combine from wp[] in event validation phase
	* use memset()/sizeof() when clearing an event
	* Still kept wp config allocator in separate functions - at least
	  for now
	* https://lore.kernel.org/all/20240329013215.169345-1-ilkka@os.amperecomputing.com/

v2:
        * Wp config registers are allocated on node basis, instead
	  of using the same one globally
	* Use bitmap in the event structure to keep track on the
	  wp config registers assigned to the specific event.
	* The bitmap tracks only either UP (wp conf 0&1) or DOWN
	  (wp conf 2&3) registers.
	* Dropped the second patch
	  ("The patch set v2 is now in the internal mailing list")
	  as perf/sysfs doesn't really support items with the same
	  name even if visibility would handle them.
	* Addressed a bunch of other comments by the author
	* https://lore.kernel.org/all/20240307230929.6233-2-ilkka@os.amperecomputing.com/

v1:
	* https://lore.kernel.org/all/20240126221215.1537377-1-ilkka@os.amperecomputing.com/

Ilkka Koskinen (2):
  perf/arm-cmn: Decouple wp_config registers from filter group number
  perf/arm-cmn: Enable support for tertiary match group

 drivers/perf/arm-cmn.c | 116 +++++++++++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 23 deletions(-)

-- 
2.40.1


