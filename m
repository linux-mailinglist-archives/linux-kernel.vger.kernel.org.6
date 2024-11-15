Return-Path: <linux-kernel+bounces-410212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ECA9CD652
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C097B2451A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E0F61FEB;
	Fri, 15 Nov 2024 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P0KfGiZT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BKhCK2TG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C11714AC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731646719; cv=fail; b=gubeZidZubLuVexL1/Gmxcb5fVBICt49qwX4hTP+xpCBqTLbriaRaoQdl6OsDKDBW4o6js8JcdlvuMv65DDczN3MZDjcB33LdOAgkoG5Cj4jdn9gBMv2EBHqq1uht0spNPCwbkc7uwBMrSf2hrakOaDaiAYcVouR21E5G8SvhU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731646719; c=relaxed/simple;
	bh=+eueeOoD8ujDCBdc58VkkuZQaWzv4KmUyI2z/oXWd6A=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=MoGJJO7aS2donHkTY0prBOS9+13vWOS4RpHTGYN0/mGl5LBsyFzNY3vgRcsFSe1aVpxnasRBTQkvEfTENaPZ5pGeiyJlKA+PM6o2DqeE38sVe7/RIzqPMEWbA9K8otY0KLX+5JK6Qxhj4dQI67li6zyJOFtpx/mJHR89dM5D4WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P0KfGiZT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BKhCK2TG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF4BZAg025774;
	Fri, 15 Nov 2024 04:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=X5b/DwiQ+1Gine6kh4
	NbdlJzGxpBaEdlZJME3vZXSYs=; b=P0KfGiZTB4poCYiBTmwyIaXlhSpebe/btD
	7ZtOedQHHa8N4Z8DT20WvONG8M0HHNrGwxXGRja3xVigAjQKjniRoNfPw/9S+CTV
	V9f04WiMMuOXGGkjaMD5zyNuaeDltZ4Fq/7T1U3RDv/kjX1GCy+6uCAILjE2SCW2
	+gyojrUJZwc6JssZcAUDIyE6RzNeJbPbPXA+eHMRqo/ttLRoNjIKPgQgfg/q1VqL
	OAKUlY4+5X/k5EyagggLAIJrQJLWqsX2E7LPfxrndr6orYsduc9xYuYB7Hvd/YLN
	ti69Iy3ggWHzu9jHODRxth30bTjwCDZY2SstRTimlZprbB/5rqmQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5jjg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:58:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF38EJZ025882;
	Fri, 15 Nov 2024 04:58:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6brw04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:58:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngoy6xIc9kLEhQ3GE+FIsZZt9TefBBzbnGuP9H4qNTgwXGhtbdRazXXpbxFHn95dnEo8GrNkj72a/gbqZXF/9qcC7RhHD81cTuDkpCKaDFj9+2h0+GRh7ew9QRVjV6YsSgTpz1Pe6dfcgRHp9fvA/BOo1ikHc1/tv4sEqXAzXWf3OGpFFrXMnWJ8NorElpTro5claMj7jeYxvwa/y5gK1fjAYXkeuvSz8ZXcn77Jsp96Qe7/NsAxzs7Fmm9Bpng96G4tbq3dldh0kwYrN+vSZLPsel38GVei6zASsyWQdQdbJHb2VJHoQBTjCWSy//yY9LLD/0+u+A8qQbKoqkbGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5b/DwiQ+1Gine6kh4NbdlJzGxpBaEdlZJME3vZXSYs=;
 b=tIht0UnBqRQVb80sGsB2/Dm7pz359+lX7PYQf2oCguT9PXqDKlhnDdz08p9vO8HWt2i7SB6dGHJwN/TDekNF6iyp6SKo11S3aTqgd4WT+Vg63aE+v9oCj24bmvcTdUPtts2qho4wDNVXF7nLuUu51adYclJvl1l348/J+P2ZK/cK9ny9eiTVygHFYr0Xey/f+5N0PzJb2PE+VVkJmHT3OZK1SOZ1GbP27/7/JDZGB8CyvQaJKBnuuZVVSby7YMh9GmuDvUAoYUNs06JuOxsJGfUhaTVmXe2WGjkaMj/ScVFt+tuiP9tvyKz4lETUX9acVmJcQkLexz9+1OfN+37RNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5b/DwiQ+1Gine6kh4NbdlJzGxpBaEdlZJME3vZXSYs=;
 b=BKhCK2TGcjC2O/DIjVlMcbdgiJTLlfEPwyuCErfZrauW7pQkc8zvJGgGHsmBgtGpH/ftYg5mKvVHUtLGidPhBj4+uZ5bhx+SECQbwAUQ1kaRl7bHVUirf2oR454EwT9J5ia5BmCgO+DMd6JvcSJuNHg71ND6+btElwJ6InxMwyM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 04:58:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 04:58:14 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-5-ankur.a.arora@oracle.com>
 <20241114085027.cH9ZY0OD@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 4/6] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-reply-to: <20241114085027.cH9ZY0OD@linutronix.de>
Date: Thu, 14 Nov 2024 20:58:11 -0800
Message-ID: <87wmh5nlek.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:208:329::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c141e3b-b630-461f-a402-08dd05321c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6+ATFr8ysK2KIjN5BWG7AmKDhL1hpL+X9LVk96vKZABx71aWlzVDHzYYzQB?=
 =?us-ascii?Q?B3GvMeYFPDj3GZfiaPoZwNROHJvq4SIx7Z66V0PoJOOvQaat6nBiBtMUnxV4?=
 =?us-ascii?Q?jx8SwqnGJJIz96Kn73XdTmGnGmIuST6oJhW3JNJn4PFBiAofhqB1bUe+Y6cN?=
 =?us-ascii?Q?V5a1keqTFYOY5Me9PUt1ZG9AgY9FnIFR5bUIUe4ycgVj7KoYYyaNrq7XV8dF?=
 =?us-ascii?Q?kBSImgZrhfzhvR1ZQ6FX7eO3CQEz/J1Jv2TI9cboJ43oNDN1m2pdNwRaFQ2G?=
 =?us-ascii?Q?I9CrzKLfMT0mQ69dpZCwSeYiZINSgByx2wUqZcEB0+x4mTKDXDYZg8UmCay2?=
 =?us-ascii?Q?hbJc+J/9pOWwAvVr2pIuVCFf4Gq2MwcDHgr+7qI5pCowgJ+PwkKoUDOiW0Sg?=
 =?us-ascii?Q?HPaFrd6/Swg4tqG0bMu6rs5Og5bYO/3Zzce64TSQaikdMYWxwuMgXkekV9o+?=
 =?us-ascii?Q?emtI/aeC68zRve2cu84JAr3wmUjneS56vTPpOx3RU7tnAjMEYzjHkwpco016?=
 =?us-ascii?Q?teXgYOsrkUWmM+uV/KRF0hxRpvNAIojzpu4pd9ZcbWEMcQpZbxGimY5YgnJH?=
 =?us-ascii?Q?XyeBkCSuDH+l1T8NsLwZgheHrVHRfjMSm9SK2L09gHH3pS1VGktoPpie7cON?=
 =?us-ascii?Q?qxGjZHBrdDoqIfSYDyPtmf2xYumpVmpAq8If0w3c23ZsehF15l9KgemhAgX8?=
 =?us-ascii?Q?TgbXyO3wStbI22HrmWIeYVKyKA74RxKn/7tNEK0U2QkLS3prvL/OV4TzOSxJ?=
 =?us-ascii?Q?bSmyINyq+xvwecJjQEST1ab/0cRDPM/WlRP7VfoXlsLioGdJ112mXSnEQTCL?=
 =?us-ascii?Q?FHzw1Hfkj5gbKc6TVQk0fodLWAlcuwwBZBYzkTs7aDsgOoHH4jwE4mXOvgCE?=
 =?us-ascii?Q?vYxW63jyPmezsWcx9NtAZxPSE8rS+E7kemqR/I+p7/syc/rlDZvZ9qj+gYRb?=
 =?us-ascii?Q?02ir1UBo2zn7Y4mpldtd7xI6F8Xm6XwbaGFf3DI11c0VcBsW6OBg4UUrrSSw?=
 =?us-ascii?Q?k4pHaw3LwVyXuKQIc8Vbn853mrlzHA1PlFKMNamCQiKgVsB49iaboo1vmwXl?=
 =?us-ascii?Q?Q3MJBkZniC8AfuWMLfzsIYm84rstO9OeUeAeaBfJ7kf7Eh9E9+NP9Cu8w1I0?=
 =?us-ascii?Q?umgdpzbLy2/xCas0pxVxwA0SIroEhvhouj7+nR0CofI5EVD5/cKCg/GzneW8?=
 =?us-ascii?Q?G7171UoSk9GjgL6mwvfq+ggn1Y/lsR6jmr791uFmlCYjCu68/NM3guqYoiQ3?=
 =?us-ascii?Q?5hf/hGnWxBNTy6zLZiZBrxnAJrj0xZtQoQThkEcO6KXV8KjC8OUUTC3vBqb+?=
 =?us-ascii?Q?7wVBp0uRlVTfhJN1VEYOPoKe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aaQLhamFomUM5Q/oZON3TcHduONUL+UmmMJEzGzaYzN8ZSnMUKe0hb3YS75Y?=
 =?us-ascii?Q?QCCvcmruRR/Rl4fgcHGbt0WhacjwMj21FTsfQ6m3+Zb/Ho9whPWl7q+PC1SS?=
 =?us-ascii?Q?4FlQ3FAjt9N1UziQq23unMlkvjfK9NwOGYhMyO++JjT6P+QM7DrXGycRgdMV?=
 =?us-ascii?Q?6ebzfLk9oNtb8T62wHyeeb5I+SdKlONttu7jTKXaqFFJuae0PraM0Z1iijfP?=
 =?us-ascii?Q?BryUfjwRPexQsNIFbu4kzQ0i/0Eq535XsNdz7LdQN3JAXV5C7i74OC9lNJzp?=
 =?us-ascii?Q?t/+b+ERJJDQ4LKLQxJfe5IkOZEtj8uCjHXAhu7YmfuV0XmEZ1nACfbHfd1cu?=
 =?us-ascii?Q?9f33lWMkP5VdwRnnc0HCq9bgqV4qEnv7kNf97a6WIFYNTHSC21jzwnmaxPuU?=
 =?us-ascii?Q?DqspDflPJ390DCDX5kfdHSemfZCYY4SI9PEdu6GiyYNdEyRX19o/0ALRMeoP?=
 =?us-ascii?Q?3gEieIGz5QlrrkVtubtbxKhwMJWYoESjczNZQUAYJ1BZA0dEa2x5TuubhjWt?=
 =?us-ascii?Q?b+urmMk6Qk6IchA94nYFNBWc2qvsJNXpELbkjXj0VGpsGcYxU1GPrEuYo1Hk?=
 =?us-ascii?Q?T3vd1sDNwDJA6CdH9Zgryac3x7tO8agNB6kXc6fNw0uT5ZZliqv2I1IQNx93?=
 =?us-ascii?Q?KS/HpEBCXGJmEZJjSlbJ6fDoU7izLZ66hE50dNpgQ6kl3DnoXb5nMPxZZCVS?=
 =?us-ascii?Q?4y6Y/JlkZiAyRwa5sbggb6y8SL+dmjTr1vOjDofw12ZbqxLnGrflG6De/YML?=
 =?us-ascii?Q?8gpXWE0vkwfzmziTGb2SPEWI8F9puuZ53aWouuJ1MxwwvYV82mwNqXhYvDJM?=
 =?us-ascii?Q?h87B/c6CY8CkVYoi6lZGL7p1L4Ynyup9Rrcy65mCJab43sJR2l3qc9LtYQdT?=
 =?us-ascii?Q?85k4wt/LlSLAk9P/IhPRa9w4Gl9fUf3iFf6GVKKfbRDMUCYTZjuDt+bQ0juv?=
 =?us-ascii?Q?uEYyEwdBORfoWYXwyfBnIZ+NgUeEZxzxPuvxBS2Zo5t/3orxf04B1lYLkGuI?=
 =?us-ascii?Q?cS1VsFH7k7vQvp7Wa4crL456W9f/wvDnmmVlJQv2uZ8trdWNlL6FpSzaJ7sI?=
 =?us-ascii?Q?XLj2u2AA/Bl2LPMM6sGf91MnQ2HszxAc+HOLyN3BQ4d1I2TyFo2iaGRCnPsf?=
 =?us-ascii?Q?kD7ubmtZARhgxdlIKzaTkUd5e3inLAOgCsS3FKlL8iNrEhydTjIfnsxR35vp?=
 =?us-ascii?Q?PZ02D0TSXNGegrQOAQn/385kVQdkzhi/aWLQLcumkWFKUf1rhI3m2kDPL53n?=
 =?us-ascii?Q?KGmkrMDLcNJCCg2MzXhMcTPGOKzFrgDE9EiVZtqGm1pRVHmYahrh/KLhyPKY?=
 =?us-ascii?Q?n3CjVGJ0XM7rM9yqeGOBlDVRyVQjj1XenNRxgYCcNq99rvrjIZyvTSglib+7?=
 =?us-ascii?Q?ZPMJakZOiG3b/RBkoT57MB9kzCd+YOH27SHyN7nLHdq8CY9rJAH4fdM3+drc?=
 =?us-ascii?Q?QLuC/iyQusz6Imea3xSfsmiHhEWacPQt7lI3XLLDW2Jws+Th2pCQ5Rib0ZqE?=
 =?us-ascii?Q?mmn1Pkdyulf1tNFjwIrCy4Qd/TYDF6gphLNuCCspmhes4USZCOsxXa1srZf3?=
 =?us-ascii?Q?2uAG1WNW69lJDHhnB1hUevrivo0Hnmok7q93JFlK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	enqAESIElHfK+C50GenK8a12jvTn1EURG47tqy1eEL7Y5d1TFHzqIWvBeqTmDlm8O3kMaQniPYcizRZGJqoJJ0cH2spIB1t2CE2R94f6g8WIcJoF3Aeeh9CS+CymJtBYVCmdi92Rcpr0aNpSVJ0bPtDBDQpdtK/E+bo1++7JInNf6+dj9gHx/o+oIIqmi3thvfIqfDJfYyRUWPLrNZQYjaFeotsH69iXrsgR1Yz2vnVsUP0MZRXysx/N5wbZJcc1o8JYTiJKE4TAJHqryVHWBmWa8572iCQ01ZK2Visom+VxjWySkWb6kIv4ZKNBMkI1Bptaw9XMRl99fR1Y94U3nOfa/FRjozxnd7s8MHI+ccKBshSdt5kSTmgVJbVPGApydtnim1/qldkUv1IZr4lAvijsk8Sl5/ZFu+NJ13MNwhxLc5lJizMlUQSdgHWmQIwFgpP/uDL2MUBjj7wVYZjGOSV74CGOAkm8ll+eqiV/T9TofowUv37PtBPCpk3HCxByTcN5rcRngVpW3urdmIVy6MPlBWxeraeVxNJtucdLBkf8P/7WpgzG5hZ2YZRA3AsNCQCwxXvxbY4pZTzlFPHdLzruxqt9qJTsJ8UuF7JjdiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c141e3b-b630-461f-a402-08dd05321c93
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 04:58:14.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4M1zpnCANGhd6LbmhGIi+tLbaOuU6sZWAoK4xczoxHkBTi0wsscGLAYTAlWPLb10vgMeTj9T0V0c5NjHKY+Owz7cS+TXFd5z17ka0DwPBP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150040
X-Proofpoint-ORIG-GUID: n8PnOKPA8P9VVAPz3NqrgRLsIoQR0RzO
X-Proofpoint-GUID: n8PnOKPA8P9VVAPz3NqrgRLsIoQR0RzO


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-11-06 12:17:56 [-0800], Ankur Arora wrote:
>> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
>> states for read-side critical sections via rcu_all_qs().
>> One reason why this was needed, was lacking preempt-count, the tick
>> handler has no way of knowing whether it is executing in a read-side
>> critical section or not.
>>
>> With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
>> PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
>> quiescent states via rcu_all_qs().
>
> With PREEMPT_LAZY=y && PREEMPT_DYNAMIC=n we get PREEMPT_COUNT=y and
> PREEMPT_RCU=n. In this configuration cond_resched() is an empty stub and
> does not provide quiescent states via rcu_all_qs(). PREEMPT_RCU=y
> provides this information via rcu_read_unlock() and its nesting counter.
>
>> So, use the availability of preempt_count() to report quiescent states
>> in rcu_flavor_sched_clock_irq().
>
> Okay. You might also want to update the cond_resched() comment,
> 	s@In preemptible kernels, ->rcu_read_lock_nesting@
> 	  In PREEMPT_RCU kernels, ->rcu_read_lock_nesting@

Good point. Will add.

> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!

Ankur

>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Sebastian


--
ankur

