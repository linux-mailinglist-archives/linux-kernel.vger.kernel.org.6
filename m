Return-Path: <linux-kernel+bounces-444255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01419F0363
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2CE284B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC917D378;
	Fri, 13 Dec 2024 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dvnbw+h1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cSScn+4g"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC316D4E6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062855; cv=fail; b=Z0Fs61C0VR62V6G5DA1ADhyIeqjXXMOEDW/Us0wo/YATrselV5DyCnLcHkC30H5vwfoweS2EJO+N6hRAjr9Uuzi5M2L6/CN3Qcv40Woc/f1v99lj0ov5maf9U2FUci0+0poeiHzOrMt7foycg6fha3/QB4fCYxDJ3xwK11ywPeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062855; c=relaxed/simple;
	bh=0ROZhsqVjfwY9K6VaTVb5ejlAecHJzLWTFDMQ8C31RY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ee7zjhQMlZjdNlUaiod19F708+Tgrr7nknzJvm7Q/MyX1nRsXbyskemYLvC+5JdRF0xACJ30hWu1Jp62bf6HA9svCzwW5wsfMepKWf3CfXh2FPWDVh2nHiU4/ey9KwBxbLHPGsormUH/KfZmAPYMeYY9ERv1OGwIBs7fVRQx74E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dvnbw+h1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cSScn+4g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1fnTg025601;
	Fri, 13 Dec 2024 04:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=jlg1ezypiYYf57kY
	S9E10HP0KOIYzuRgExmM0pBplUQ=; b=dvnbw+h15BpgONIFSRawpd4DnGLtmqee
	3FJ86pvbZwOKHSqpkhIda0NRM2HXiVbEX829gVmVhlb0ndBOqHA5ftk8uoI/oIZ6
	ihXHu1+PlplR/Ak758twyK28zRm7d20uJKD+js5bEwXpJkZwWqqyXdk7gyPJbwO5
	K7Zod5I5yM55smMFCDVEKpvFTRkd4i+zgxDKfV0RH/+8DwILjQHBmYOP9Gn2IRiN
	DPAOtjIzxSm1YsbIvhQANWCnbTSjbv78gqB+b+gYw1k7T4BOhCY8nQd3O4sok1sb
	VGMw/Ds7iF4SQJLvi3M2LrH8pJdJVPvmYqjfDGZmQ8SNULdkn4Np1Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9avpdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD2u4d1008623;
	Fri, 13 Dec 2024 04:07:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctc10gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSq87JKhuKs+cdAKd04KhV14UEgHAjBSSCVoKpSmtcDsNxoRQvOvNqXpLaHCWWFWIihtWtWIWtd7k+NA2d/3QGOIZSH2tSnz7wgF04TX81wYcSDa17HX2GxRKWRBJnWiTzuC429mK4YKAh9XVGdeGvihubG3HS6o4ltTwj94jxmGAbcGoGmgzkIrT7g6JBbR+/urV1JCdSCRafh4hznqnp0zf4ZSw3OKoTtzHa3Rl5OapQR5bZyH5EqGwpB/oRpYtsyQQz+W85e6ek2HZwPFGchgmZXw0JtP7V1GXsJa85FDsLKR8qFVholxH+w4mkQz9jSu2FEvfrK2J2UUR9gfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlg1ezypiYYf57kYS9E10HP0KOIYzuRgExmM0pBplUQ=;
 b=DYQ/cQK8berey3c7GJxaJP/ZFuq7gDVzn6cXVcJTUMGrRn915NP8cYHBIaZgrGxz8Uztqp6kUkp+Al3UuD+D1f3X0oLnMpKWH/0saivKxa5yqpZ/VeMN8bFOv3yLDewvGCIES4eftstv7NaMoDZxtbAs5n2T41WmsZegY/Le7CT6itvVZeepC6kjz/Ofk0A8liKqg/UKa4sYg3dn3x56vqXYQMQAsd5g653XKCgm76pXbE0JuJvt1MvI1mniY1r80sqQJXh3ow8jKNb64tymT39FeFyjgE0ODlGWMrRDECtZJOhNfq55xjKR+2g8E3SDnJG6Fy0MGAtE4nWOoIaRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlg1ezypiYYf57kYS9E10HP0KOIYzuRgExmM0pBplUQ=;
 b=cSScn+4gGbGCXPcYAfoIHvzFloH1l62CWH2QIHSyY6gklLsmLT/1W/1UbAuQQwc9MpgKAwwbDLHyt+U+JYsGRbv1nyGz95tQDL5BAFYCLmsjII0OEX4X0TtKOFfUW3yLPKxJJUardbOq9u4ZID9qpJuGaLY2Zs3sXa4JKzbb+VA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:07:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 04:07:01 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v3 0/7] RCU changes for PREEMPT_LAZY
Date: Thu, 12 Dec 2024 20:06:51 -0800
Message-Id: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd065ee-d1e1-4691-4d61-08dd1b2b9899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8mgvzM5k1RikWY3/viAIqEvUPuEnP9k3Eb7X23l3g0q9QkEe7Y+JjSn9F3t?=
 =?us-ascii?Q?a+i5nrm1LNECInCtdSTBFmKV/gKap6Vk+vSvWhpWE7/rdo5Fb5kjG60FfjSd?=
 =?us-ascii?Q?SZBxXn3ZrkV9Pe9sSvfjOEPEfD2ZrJK0/m11dkvqXbXB/Q1PKCJxZT1WOad4?=
 =?us-ascii?Q?40eNfaL2tD27xM9vnvVPRVWkhyqWKQJKzaLnigM46vS8CQqL4DZYVyXIhiBk?=
 =?us-ascii?Q?f1p5nO4/TYj5JHc0KW+buFA2b1UBgHy4WqJbFOrixF+tZSDc06lFwKeJZiJe?=
 =?us-ascii?Q?lWddI6iqu1KoZ/7MdnuzhEA/Du/BTc8htEgByYZoYCb27gEvQptAqp8QZ3f6?=
 =?us-ascii?Q?/K6Eu4EV/HuMmt8VMAWtRYjItykONwLDfOwTMClGL/RnVKQy5RziZYbWXqF0?=
 =?us-ascii?Q?lSVWCkSWXMz7bB5pr00bHx7Ka/GhHr+Opil6Lh1UPhF2mMo7bT7VzCR1rfZR?=
 =?us-ascii?Q?OzbYzpErFqkUo2YUF7VHsuomVeL07qWkMuqJ5ik1L4YIy04fQ1Lfm2ZwuDzV?=
 =?us-ascii?Q?PMW5E/JU/4wbuneSTtPPolrwPkCYlZElcSbzkAtRHq54n7jYdEB6zKDRCJzB?=
 =?us-ascii?Q?5J5VfFJ0Tc+zFamndAsMPibZOLruo5Eyfo/UKusn4Zy+b0ojgYVtuJB7b86M?=
 =?us-ascii?Q?ckkKHUsj9zQcxqgqTSkblxRCt/u/YkTEv+gq4IlZN2zh90axSto8w4WLL06p?=
 =?us-ascii?Q?NhVY+y43ENslyCAo6/qhaY68QmT3GjYrpvkZltVzxQEpJ+smNSRx4T67ew62?=
 =?us-ascii?Q?I+d24dJfgAuvzNqUGoZIMPcYDsl7YneMcazM4pqUc9IwGMTiyR+7H5jTdyPi?=
 =?us-ascii?Q?+DDmzub8F669JL19e5gJ6K/uxvxm5jTyD6g2ONLOlofYPqnlud2SzviNoasT?=
 =?us-ascii?Q?8W3lIwS2QBcJXN7upIr3egdSqqs5Swz1NS4b0Iq4t7oxT7IG9lmW8uv/3EG+?=
 =?us-ascii?Q?dzy9WU3NpyLu2j7GgWsPnT5JVzjgSkwgiNxIgZ62vH8TgnJWEPRa5HHO18so?=
 =?us-ascii?Q?wPVALvioDgv7xHBFsirfmcrLqR3jKvAiq3Xodr+PAembtaPBtw3JurNne+xp?=
 =?us-ascii?Q?thfWUmIaKmmkk1YouGyz+s7ZipaUBJupd+pRw6hkqnKZRPNfKQv9dNzuGwaN?=
 =?us-ascii?Q?E8XzsD07cOi0iZLEiaVewTgF/nTox4EJp7Mfj1y5CMZphgNL3nbLvCU/IdRM?=
 =?us-ascii?Q?VZvuHV7kbJUxi57mo0aymiCEQE+Ls4Je4cMxv7SrV+zpVjk0P6SSUBu+ES+X?=
 =?us-ascii?Q?/hG31SsK9odyznRaMKpcsgtXjcTPnYaGhIh8WDdMUqrmEGGyd/6rTMXmtiL8?=
 =?us-ascii?Q?/ZN6YSLXShrOH3B8HTQ4TuanQtonB/t4YuAvalkCfpEQMqPwjY3eAEqW4prS?=
 =?us-ascii?Q?DfTJ/azztzVhrmZGDZgOx8AxPi/b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yVZf5Y0j4ijehiSwRznNJo24Wo8icz6RkEoamMxz9YNyj7F+cV6e3il4ewdz?=
 =?us-ascii?Q?HAiB4u8J7LnacIFfmit/klWjhiMnWwmJi3WD+DCIhxUwqlmRVHqteYZWhwG+?=
 =?us-ascii?Q?7+6rdnYm/BlgtJNqKhPhbnVP1pp5LVVh1uF8IuSd9n1XB+zPccYWB/vvqh9E?=
 =?us-ascii?Q?26ryL7EUN6dgRbtYREe3y24/aPgj7Jl/oTh1Z0eg58lyzr5y9MhNSLX45OON?=
 =?us-ascii?Q?HdzGdz1Rqf11v5ed0qZhUMPOn5NH3hW99E9PT2ymO+/+9jeTWHpo7Ge3gsK7?=
 =?us-ascii?Q?FgcRkpr2/P1diNzesupvF553lM9BjJ2KqoxFQFoIGVcBANxJ0U2mQ8xemRzX?=
 =?us-ascii?Q?QaHGPG4XINohjMbuqg09qx3ub64lXwjIUxmUa8tu05MNByh0siHXFGw0p0bg?=
 =?us-ascii?Q?fk/weQHgSiz5SePl63JsoS1s0QAPcOykH4CyY+B/RZuookl7Az1wxDCxEKNX?=
 =?us-ascii?Q?HBojP2GdDdppKMJ6lksDDvMxE8ebRJwiB8Fm8oS0Ree2PgqlhI65GcwSz+Gq?=
 =?us-ascii?Q?G6zZLqdM9PoQ89L0ii/r/YUE6x9NE5jRWR3Y7dmdjEzUQzCt8y+kgPEZz313?=
 =?us-ascii?Q?rLa3a9JRbW1AlVSET0Oro+8r+vJQsN3u05B1YWfz1Lch/8owfvg78u2a6odK?=
 =?us-ascii?Q?VZdo86F1k+qNvwKHyC7evqALAIU+M4zPhuof49uyQ1vb4FdhbsX+mS18uqT5?=
 =?us-ascii?Q?ooRVVM02VHyj5KpZ+zqHBKUDwWPFDmt3pKXbWXGwqJck80CLUZ0naQf0+TS9?=
 =?us-ascii?Q?98nvNn9PMh3doZv18UeqaeasdBc1cDuuEnBK5qvIGToenvoFq8GbVKD/2x4x?=
 =?us-ascii?Q?1UWaoGmufkp8H0RfqqVE7SjJ5QKAHW5NdyARAV+5tx+EdYu0eUzm1xrFrj3v?=
 =?us-ascii?Q?lI5buqEZ2OTPJtENO+6cKj4SIGDy6/PF2cUhd4PE8d8svBAd4ax+4qAJRnWa?=
 =?us-ascii?Q?BmL1dhS3baQxKuuUZ3GVJtVjwWYe6WOecidDwSnAAXBTD/W/4eI7PT1H5ZRh?=
 =?us-ascii?Q?5wsI8Y/Ol1CT23Z8e7ItKC8b8q6qKEp6BlAQU6nnEoQgF46JquGcjVanZXfe?=
 =?us-ascii?Q?JdKTXJD1alAwDVI/26T//4iZvYll8yM3OgJtG6tQmWMpervSVXez/C/hCH6V?=
 =?us-ascii?Q?LM3ks0i6t+rDXzgWBjertYUGqMTNxJN58/JoYP1BGFqI1W5OoF91FfzpzoCu?=
 =?us-ascii?Q?7uzY+OTwApbPjHYHvnCotYdXgqvobOctUjhSMn4FZTgAm2Xgx1/O5ryqL93B?=
 =?us-ascii?Q?gqQZGtOucZoB904hGLmr1GrS7wvWvF4o/hXD7BH+yBNoLO8jJMZQGuiiIdch?=
 =?us-ascii?Q?bC29rrvyLZ4jRLqdnW3xJwDjtOqprjb/y/6YfYdeL/UH3Kkc8KwwjkLJxpg5?=
 =?us-ascii?Q?cL2jT/QMRFTYCcJZgXe9H4GI1H3xojZ+dXqybN/SyNqPrdV3vz90w9ZPAsLq?=
 =?us-ascii?Q?gCPLoH5IC6qKFVsAHejM4xPQY6n8np28rrY4OWp2DmDujRPpQRP0OM0EzzkK?=
 =?us-ascii?Q?x+KlMeUBnTzFTncMGntjCjB6T4+1t8y9lZj+enO/Nwx4xU+3nVeK7G3g2YvU?=
 =?us-ascii?Q?RPXeSWWh00V/83V3ebnrHvPdgq7/PJWjklMt79cnP910lgrlfq9Jrs6HSRz9?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h+mvPghIXJwSQpH0uQg0Dkf3GQoJZbCxGNlBcNv7L4l3YpFWf6/X4yIuaNwHt5xjbGQcKaHecV72HtcV8SzpSRa60mrpwG+oJJ9pHqer+y8CWzM5QE6ya63tOmEjFfAHqXtKREAYuFEchjAV4HZ4NJo2rPpzzTfSSrsMQ9oGGJvW7f/z6ICaw//BPeZCzzNbAvGk57WJDL+D/y/CtjcIKM4Dsx8vbwr5+E/rEAaskvXrk3cJ4Cbsq5dQCMzMjz79LyUYAlxtrw31YyHk0aNQmVios+E/5OZu0CfQaLsmShcTU3pPl2il+Rnse1pHePDn4vubtMiTBV531G83FEnuCNlwTIhY1Xrce92sDcxqzJO0V1VOTKzrMczCzZfNIwfNfMg68VMxuClRjmh16okLIca/1q7Li0+/6RcyFvrYUkvRqeh18+NLTXTa0xCCvvYvobMublGTArQZTL6F8vH1wvWWeNMRbyFCPdaLnxhZpotdMyXNd/GcdHpFwuU5/oVhNwrtLflQTikONrguv17PXdVvo+SoicA7nxhS9MpJxtdkzmwoVrIoravs+4KdaORuAVxjEcAjJdDuxUcgklSQ8EaTNprKGaFQSd0h6xc7W0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd065ee-d1e1-4691-4d61-08dd1b2b9899
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:07:01.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBMeO0Cfaf0kImhv7wKCs+7+AhearvJCNdXUNxsruFcIA86RBvo4TEq57CN266WHRqeLs8Jrbs4yPfB0dmZeTYIjOmPh1ea4h1CLI3mN090=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=298 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130029
X-Proofpoint-GUID: HwVQflZFc8DnAVrRcSUcrql30RgLklK2
X-Proofpoint-ORIG-GUID: HwVQflZFc8DnAVrRcSUcrql30RgLklK2

This series adds RCU bits for lazy preemption.

The problem addressed is that pre-PREEMPT_LAZY, PREEMPTION=y implied
PREEMPT_RCU=y. With PREEMPT_LAZY, that's no longer true. 

That's because PREEMPT_RCU makes some trade-offs to optimize for
latency as opposed to throughput, and configurations with limited
preemption might prefer the stronger forward-progress guarantees of
PREEMPT_RCU=n.

Accordingly, with standalone PREEMPT_LAZY (much like PREEMPT_NONE,
PREEMPT_VOLUNTARY) we want to use PREEMPT_RCU=n. And, when used in
conjunction with PREEMPT_DYNAMIC, we continue to use PREEMPT_RCU=y.

Patches 1-3  are cleanup patches:
  "rcu: fix header guard for rcu_all_qs()"
  "rcu: rename PREEMPT_AUTO to PREEMPT_LAZY"
  "sched: update __cond_resched comment about RCU quiescent states"

Patch 4,
  "rcu: handle unstable rdp in rcu_read_unlock_strict()"

handles a latent RCU bug rcu_report_qs_rdp() could be called with
an unstable rdp.

Patches 5 and 6,
  "rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y"
  "osnoise: provide quiescent states"

handle quiescent states for the (PREEMPT_LAZY=y, PREEMPT_RCU=n)
configuration.

And, finally patch 7, "rcu: limit PREEMPT_RCU configurations",
explicitly limits PREEMPT_RCU=y to the PREEMPT_DYNAMIC or the latency
oriented models.

Changelog:

v3:
 - moved patch-3 to be the last one in the series (suggested by Sebastian)
 - added "rcu: handle unstable rdp in rcu_read_unlock_strict()"
   (suggested by Frederic Weisbecker).
 - switched to a more robust check in rcu_flavor_sched_clock_irq()
   (suggested by Frederic Weisbecker).
 - simplified check in osnoise (suggested by Frederic Weisbecker).
 - dropped an unrelated scheduler patch.

v2:
  - fixup incorrect usage of tif_need_resched_lazy() (comment from
    from Sebastian Andrzej Siewior)
  - massaged the commit messages a bit
  - drops the powerpc support for PREEMPT_LAZY as that was orthogonal
    to this series (Shrikanth will send that out separately.)

Please review.

Ankur Arora (7):
  rcu: fix header guard for rcu_all_qs()
  rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
  sched: update __cond_resched comment about RCU quiescent states
  rcu: handle unstable rdp in rcu_read_unlock_strict()
  rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
  osnoise: provide quiescent states
  rcu: limit PREEMPT_RCU configurations

 include/linux/rcupdate.h     |  2 +-
 include/linux/rcutree.h      |  2 +-
 include/linux/srcutiny.h     |  2 +-
 kernel/rcu/Kconfig           |  4 ++--
 kernel/rcu/srcutiny.c        | 14 +++++++-------
 kernel/rcu/tree_plugin.h     | 22 +++++++++++++++++-----
 kernel/sched/core.c          |  4 +++-
 kernel/trace/trace_osnoise.c | 32 +++++++++++++++-----------------
 8 files changed, 47 insertions(+), 35 deletions(-)

-- 
2.43.5


