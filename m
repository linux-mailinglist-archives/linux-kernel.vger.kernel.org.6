Return-Path: <linux-kernel+bounces-444259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8BE9F0367
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAA71884343
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E5189B86;
	Fri, 13 Dec 2024 04:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UJ6IvRcN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JxPGKNsw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3A188714
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062862; cv=fail; b=hRuubtD1tDBnxGBADsmJYtnqVtZaI53NXRD0TYVEaJQy/gTdmN3kg1zIVwtY/CQ29kv8gvAdCVCsaDHO68zaipjuwQQOeKcgkhusJ8MJXbxVkbYDL++pAp7kCGPaApVRwaZZvNAAtFsYQc9hmvKM2a/+I2KhCB7a3tmxR8Tuvbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062862; c=relaxed/simple;
	bh=9UKnFlXDWAxTFs3T5JE3cDHDYVNbdroR9G4dbtQBUZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVz6WLxSKXauOSa3lEn7Dl/Amhz6jhKR/dBp0AKskA83gholJ0myak+bQMgSJMWChNxKJUQxjw+ms02/qSLi+ZwBWG3OtRIeTG2gKVydw5b8Pp4FG+xTDOUI6P4HGokEBdciiE5MW8ksWMF4lU+HKzMB2Gx570Lwfnn8m7e1Ma0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UJ6IvRcN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JxPGKNsw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1fpfK025936;
	Fri, 13 Dec 2024 04:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mTNaQdalAFsgcTDaW+HwCA2w+sUiv09+iCu+IfRXPcc=; b=
	UJ6IvRcNA4K6FSLsODVgNCCYW23hvdfhCPTaeeQtHZmpOg+kRxsK5EBm1qIytVwP
	RlW+FYY4S4ZYIeUfd9mP8TVF8eTHBl7lovLAdY0CyItsAjkT5On8vFsRcVQFvmZs
	Pr8jsfE3hMe84z/vkeBzoKS90tQ6NdlM3l5WpFcLYwWjU5QRIcrCllc2AIpHr8zA
	O5Pm7447XJMwT/ZSITScJaB/xIrDZkRtUqCrRZuQVLbaSLMsWa2SeORv8hTBbKY0
	oIeA7rRndbVG68L8QLoNWR98LHJxhgiZ8TY5MUkex2k5o4KPjZcSq56k7S4imTLb
	IkNP26iS3/FS56MYvbSbjQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89ces8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD2D1CC035682;
	Fri, 13 Dec 2024 04:07:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctc9hm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trQcowXAtlPi1RuNDkms51nEdLeqs97zg7PquYHLNqYloDNGjqS1EUQLauoqmkngsOGwC3/+5GlBeOBXpc+4lFifZTUXIqwJyvWDrHNPbK3VWwtf7gwBVqhFYiTuxQ/8vn3Q31IHDpOnLhQ2FwRYF0HIFyKaVFrv0+EuIlSynhRKCShTOFBhoCGVmXnFHhqNBgQmtCnIe0gThu/Bxkjrbdr1WWGW+cZOxgWVbfvE7wraPmT+mdtgF69SI9RumPJyBX5Y6L62tTeqa66BwjBrYQfLoBvLqSi9cxSPoLM7uxnUoqlBSfX1SkVzo5duv5XA2zG74bAS7ajVK9GPpTlrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTNaQdalAFsgcTDaW+HwCA2w+sUiv09+iCu+IfRXPcc=;
 b=rj6yUxxpLxwp1xh2OJ8K1aJDk9A8SvnZ+WC0bIyZynerUGc1PLM4l1G/b1BpA9L4cJY4V/Ppq5+6oc16cmyq/3UolyshmFqx1R0cdenriZc9gfwai0qKFK61HyrPxkOXEVhcws0rlDOQhZ9e8xTY5Ef++aWQMQS4H3TQ5Lck+syryLAhERsm8jv/jr+D27qe6WcXmE6tNA3pT6Vmu0zHFRpDTNxLIzTCEOyAytn3bIAVIaMe0l065BHDqsUeEuYaUst86jmMlDUvjoI5BJti80oLu7tnYmPE70vuWl5PqVQBfPmn9gL8qu+AmKzNR3JGJfLYQwvkcCA8OqpE/nDL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTNaQdalAFsgcTDaW+HwCA2w+sUiv09+iCu+IfRXPcc=;
 b=JxPGKNswvoAaoGRrg1yXZovEGMYYWm3pVgb4momXURsQoIraEQn3ITfPcLg4i33Datpojy3frtIRUY7e4N8UEWwlx0Qyg58K170vKCJEd19EwAhD8Gg/BGoXSyYAN4MlHYV3Rx22jFVoUz8Z0SQFZmaxDIHIEYGRJIotngYSraI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:07:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 04:07:18 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v3 5/7] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Thu, 12 Dec 2024 20:06:56 -0800
Message-Id: <20241213040658.2282640-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8f82c1-eb04-45a8-7fda-08dd1b2ba299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Y3H3iG+oxV0ytCpJu3LhbQFakf1tepRV2/s/9toS34ECNo9wDcmt6aQbPQm?=
 =?us-ascii?Q?r+SO937TLsk/wEb6BI7E6E2RldUwFNlC3GXMk9E86EO6JdFol1pMkzO754Pd?=
 =?us-ascii?Q?pWL0RLgXxeWlLVp5wbcf/a3pe7tn9zbFWOFFAu9hbXbF3lp9xnyApvCFPG/I?=
 =?us-ascii?Q?QsUi3QP4Fm8hX6MMHLXozQqSmBeqNnGHtRIOKLmiOqWJ+dHcKYPs/UTlG1mN?=
 =?us-ascii?Q?YLEBNXnvIUdyhhPk13r+TgtMh5pn4WaymDcDaO9klWeOjJiOQdbiB3K0vC+f?=
 =?us-ascii?Q?jpfIpCQqCeSnmKrIpjcg5EGfBLzUpZTtYgXwLI/u8+HNJ6gWwRDh8E/A2vRR?=
 =?us-ascii?Q?3CLyobFIUzF55/h4NC4fC5N3d/wC2FbeM5nPw///gLjNblxFISGS7QFLsq+E?=
 =?us-ascii?Q?H8Ew3FrJNvBZ0syBtcggNCOAEOR+KoabMUdiVAwrfi2UE0t7+Nhx0knDjDXQ?=
 =?us-ascii?Q?HqsknxKcZZs5M+RJ7ISl46zf7975lxuB+mCp2kTU26IMvZrFh88NjeH+9CAe?=
 =?us-ascii?Q?UcYlNbOJ1ctfCsQEtCb3VgYgET5VaztcLv7WFoR60w7hPZ6urTzhPEMNdLNN?=
 =?us-ascii?Q?NmPK7IoaE53jyk74KTqhaxl2UsSQteCYhyoiaWMrFGbqhAySeaUpkBGkjYuf?=
 =?us-ascii?Q?5EU9nrLP+FXxKEtS1HpSN1lkq7kNoNtEj0GRztcuDPkSpdmdMuJtuCW3zwxR?=
 =?us-ascii?Q?EX1/x/HUDsiX0dhxFgPZXDL8gQMZnmnfwG8rPb0oKqQU+hNLUx4LMTCzooRL?=
 =?us-ascii?Q?ta7V2LmzaX1766nz2QCbGvUR7n/AUmoWWSlp5uSMpNgi9mteyrR+jQ37gKdJ?=
 =?us-ascii?Q?H8wAYA5WtAa4zJoUSAIneJ3gSO4/59GqOQX68on4nuoFnY3Macv2j/jmZetm?=
 =?us-ascii?Q?mIlBhN2cfVjP5ffKg99MDYtwQJHnDgQR7LWF2nzSW4nN7Ay5UzmPqRvc6RWw?=
 =?us-ascii?Q?tfSpd3tL1eytKQvdGJReX2BPOe3mOq8bCpx+STUaJU+ZOvAjGxVZcULNtMX5?=
 =?us-ascii?Q?jfkPh1VMQpZkzK6MdSnOrh/n0IrYms4QGyCAOAI3NBxUPp/SCMSghnMm+4uP?=
 =?us-ascii?Q?+kCIzEFqgQeXh/BMvvAzt8yWyLEDnPNTU9vGBfhU2FRl/+56ZGiNajmqTHek?=
 =?us-ascii?Q?bC8p+RNgoUzPj702wLrPy7kb10Nf7uFU935RDbeXKXBhAfuRzlU5oEqzXyrM?=
 =?us-ascii?Q?97vfqC8v4J/TDXTMLGcs4v5MxoB1wpTNQjEiokiY396G8+4zdFEBusuJ74U6?=
 =?us-ascii?Q?7MWxyEYDyV4acZsekEWjarFtm9OWPzg0Uf8Op+YVqV9w4g33+g6AmuIeN6/i?=
 =?us-ascii?Q?aPC90pNQqLIs0TdLpAUn+hkehsdTg+tE1H1oz22H2UqpCM6T7qQE0Yoi1mQi?=
 =?us-ascii?Q?n/Phio7lUhzofX2mh9AWKEU/m8t3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p8wOyvZYBVS0wlZfmoavARJAAOoUPpOdv35bcaXsXnubGzrS3KY2GKPsB213?=
 =?us-ascii?Q?mYcjwwVm02eFatdpdO8zpYa4UU4s003tjlHihXyLzdCPQXjYy2GabVHLLBeU?=
 =?us-ascii?Q?djDvhqwYMjY7EhlSJ/4pIVsoFOHE+MItnUqMvmL8Pft/qilwLWFB7uo+eoPT?=
 =?us-ascii?Q?gRiCGANRm9YK29x4Pxa+HB2r0G5kSFBtFg2N/rn/Rwy+Bm8k+PG0bGN7pmQ9?=
 =?us-ascii?Q?cYE01QvjDVcbx9OYNOCQCr22tgzxtJRF8ZaiVG1IQowTQ2Hpsvlzv0JEEGFN?=
 =?us-ascii?Q?9tJOn/+otuLdbPpVmQWXUbT1RVSog/I3x5OMmHeNgFFEDn3Wvls3UlKS9JQI?=
 =?us-ascii?Q?gSusD1I/CpSgGUqTIVgKNBLWM5o3UifbG4UkwMfTPnRzMBdM70CBGAg65M+f?=
 =?us-ascii?Q?P/IKUn+CRJi6BO1ks89VRyqmxo0VCN9wzO2BzHcWon3LuZM27OmgETXGeCUY?=
 =?us-ascii?Q?V9yYXwIBLp9AS+eTLpH1mgcKkHhWKfUF2rp2/G6qEmwbMQ5kNV2koWESplhE?=
 =?us-ascii?Q?k1m7sk4w24qxubFK6qsC3M4w9vM8ZhxkHrdlBIIqwkFXH/qIqWfgw2e68bA/?=
 =?us-ascii?Q?AyaSbEeCqMgGHU5RZ5Qf3FBtqrDqEyUUyyPSqGR0bCvyy/CI3r1zzBFbbtDE?=
 =?us-ascii?Q?ia0nyw12YWG/Ri1NtGZACu+61+Vd55QEmeU3sYYqxgYGg1A83mzETKVYvoMV?=
 =?us-ascii?Q?WJRl81y/sbh4FtFVZeBOwDNvfo0RwlABbUkWgCaCkgekVi9dahqrvjPPahmX?=
 =?us-ascii?Q?O9ElDczb0HtqIuGuAz2JIufMDXoiT9VCTDvCYLzw+NiylH9s79Cdf6w1KYR5?=
 =?us-ascii?Q?EUY2JGwfBObGiAujQsW7+Sf4IrkheT68evX4OgMajtd+wbt0+LlepbPE7zBU?=
 =?us-ascii?Q?lsxPx2yLgTfXiAbJVsCsufF4jSAKnhcMPR4/UgB4UBDmbuoebUr+wLedSgIR?=
 =?us-ascii?Q?s7nBtaCdtAcfGGFEcz4Xe01Lh0YqCzKX3o+cR5a+xAoQS6KKZgVVtRlRauSg?=
 =?us-ascii?Q?lCos6c3YpkapimuBKeu0RGkVD4aH7CbmDIFLh+E32DrEJxVrXSJp4wxA3cg5?=
 =?us-ascii?Q?YMykmnDpBxWGbPyt48mSfPP4m48hcOTzDt85N7OYjPcJCUfwOo4zwfmzZa2o?=
 =?us-ascii?Q?Bo5By2mH+YuR1Bt1Jx5R/IMFcW8jGfT5E2t5LfFdNIwnHYqq33o+5lFDLBQX?=
 =?us-ascii?Q?0uqeiy8AO1nuXQQezEb4ytEUAuO3tQFDXw8kNiGPPBb2k1yrPKuWb+Z1pu9H?=
 =?us-ascii?Q?moQb2ZZYASALwMnwntTPZtlqgScLPBtb8Mg7AIR4af/yv73Aeuq28L8lXEfW?=
 =?us-ascii?Q?5DFsnuTvN6zsju0FBACnTX6inkAVEFJ5a1a9jUnuFGlVF3hRfVkgIjaQAVXA?=
 =?us-ascii?Q?4qNpKv353I4Ikhlk9moUFD6mRAsI2AF8ISOxdb2YmVQK9MgKMBqubl4Qb9p+?=
 =?us-ascii?Q?bYMR/ucV256/nUVH8kU/fHJdCx3ieVUdOVgr1M9Nweov4e8lPAi3HfeKrP2v?=
 =?us-ascii?Q?+TJHXMYduYcGJlqWQXZ2ExpxhM8+0fwEWW90Zmb9GqO5YkdwvTJnfaGOI0d7?=
 =?us-ascii?Q?yuU/Z1blYtBPcA7/eNJbTOQfHcaOE1yHg1RX5qeRvEdRNHmIkQsjgbulEHO+?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p3pI0zhlisXcBv4bE674F7clhg9mUopcGDG19n04GdKT34gloz6PAIXcDZZxfhKG6JUiRwylxQJAaGzATlSksLb7/6UKpnngwQi9FI/s5Yp6rMDLVjcRjN1tnZF6pLkuSsGTT2T6EM/0LdrVbfJAKNmR5a0bm0KbM8C3bbsDn18R6miScMEeIdXWIFYE0ig9qASj2gOmQJThNNChfe3nzFSJNuQo67mcVDN0jtYqASYnd0jl5hoL1HJLVPTx3TjiLaV7K7cyW2gH5b8D87m+EzlYklkda6q8sm3Fpz+8lek9qEGKLz7Q6uwtPvN/6YuaOmL2SAp8Dtm1bo0uihWifKklhGLEOobYbqpA28IysaQIhIvpEoRBzGYIj3YMUbUHNX94lVR6CO2JP/7opcCPXSzM1psqklefyU416bLzmMaIqH0uRGH4ehTmP3f0f4XhcLwQ6YM+KSQdufBwcqlB6Y3y987CkPkga2Rw5ywYo4VOcJzmgYep5/XR1czBqy4rUjvXsbBAYItXcE/o7I5kz9oW7FOyjVJLO3v2ZNULII0U/Y/1Iis+yTrD+MBhtB1NM9LaPYcDDDhsuy8bPklXT3qWBgeMDdSZvldDEYeLRtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8f82c1-eb04-45a8-7fda-08dd1b2ba299
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:07:18.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X30qRVG9GZFqdjndkcz3WVFjgm1eIKQAbJxGQifyw0ZFG2LKjxHtjQpFEK9lx8zU/SBAf8D0QLqXMEcu3QR2BU9KnenpoGzzmKXuB0cNDS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130029
X-Proofpoint-GUID: gpiJ9HPwaY07nGlOAMlua-hbzeF-oNND
X-Proofpoint-ORIG-GUID: gpiJ9HPwaY07nGlOAMlua-hbzeF-oNND

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was needed: lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a
read-side critical section or not.

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), we get (PREEMPT_COUNT=y,
PREEMPT_RCU=n). In this configuration cond_resched() is a stub and
does not provide quiescent states via rcu_all_qs().
(PREEMPT_RCU=y provides this information via rcu_read_unlock() and
its nesting counter.)

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 95a7c6c71a91..c7f7820b5e18 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -983,13 +983,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      (preempt_count() == HARDIRQ_OFFSET))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding the task preempt count
+		 * (with PREEMPT_COUNT=y). In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.43.5


