Return-Path: <linux-kernel+bounces-366831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998CE99FB18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4991C234CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ADA1B0F3D;
	Tue, 15 Oct 2024 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="coE9PC3q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e2Lilu/7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79F1B0F0E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030461; cv=fail; b=Yo4I3x/m3PyYrQJiQwFl9mFu0Nrvn8gWXSEY/6fWb0EVNd31YnO5BT5PdnmdBx2xuxG1OZxDBEHXe0FCkRCF/Q6og1cOk/CnIt0q8ycMf5ohg8YbEVM54byIxrEkNrHSKISeoOAqOTRae3OPBquvjpYQr4HI1Bx6wLOCf/B8zxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030461; c=relaxed/simple;
	bh=R9rsK5so3/yjiAh+k8pkKllFD3IBKebI7olEQTovTMk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=qU06WWAqBOVEfF7adLs16S//3X7eB8tLTdTgNm7OhX7HtwzZMrVx5k0VGPFFJsO/+NeV6EHOtRDxu3RQLBORyBAMgjkZNWtYpc+cYmGpuyPBfqchYslJz2W8NUCYdQF70NvGoR/srRN25E6uL/Srf2n3JsD2YX7moBG2gavCHpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=coE9PC3q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e2Lilu/7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHu0nd029909;
	Tue, 15 Oct 2024 22:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+Vx+nQbvqfKvjX0pk8
	40IBK4J6Q00mzKz/9NKmyBWMM=; b=coE9PC3qDkwgxPjQ3tINccRJlexr2g4dIO
	jaJxomRBrjGR9nIHYHfIQsVPeEy0NZ9WGuqXhkPEGpsEzgOgri7bUigrEo4bgpoN
	SsFZY6KfsbmViRtKmGtIEBYLlGFqAKp6dKJaoUaT8Ljh8krwzA4vyecK8DHA7sKw
	IPjvrjg6HDRf8y3BLRXN/v5fxj1OTwI47Fk71Fvoou/7QXenCkxDKaOh1Lxgw5RJ
	qjh5lFxzL2lOr6QnesLBHcveGB3sPsHoTrLrQGiSYzEgzZWEQgg/hfXqSr10onoh
	Pt2JHpbc8ZELzixXUUXBDkZfkfLme0kg2jfUA3qa7y7ZEddxbzhQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2jeg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 22:13:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKHLLN019946;
	Tue, 15 Oct 2024 22:13:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj82yk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 22:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYe6aQ6RWy07gBdwli+LGy6ICViuvY3nEH/flw/seDB+95Znmbo33hpEyRldobu90MXqRi9Rx1wvUQC2PNzcv1STlq704I6aUpv3zFc4P0nis+UEkwEQOA8qHu1Jx59n2K+FC7d+k183gG4shvp3vFGWrHW0hKxRU51XqUZ75lnzWpdQUmBwBzO9Eo3WqOFJJpqZdP5tr00PrbmkVuSPfmnM9CksjtXyP5VfSJOE80rCKVRqHp/qZgiClGtnRcJhL8nA5e7pbDNnPStqNE6fDSa8gU8vG4WQLvyltPZScXZXwcrf0bGygYn0CftugYjk0biugcXspIF+pYoOoyEopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vx+nQbvqfKvjX0pk840IBK4J6Q00mzKz/9NKmyBWMM=;
 b=KxHoh8k06IYaHYOXOewF4NA8RqKEyC5R5Yce/BllIC6XqhpvhnK35/DZLgMNjam0Ciq3BFkLPFxDA/y+wk16nOAJaFXlUSOgKO7fy/uirHV4577pwhOihmnRHagNgR5m6GDNadDi3Wx/MysnAWMNjCCh9xVRF3eRhA92hIWnlP77Q9kFXzDPWcFkz3uqubR5JhIMuFCsPmQ110rWLm9TQyMeKl1RXWj29Ht6erk0yZJCCrE2GW5jYPLJmgyxRH5rlQyCJP8NDaLDSNA4/UzkBVcFx5Iiv5pBOQPnDqZas521cn3JUccCrWfogyyu32Q+gNj47D1mvj/+vhd3SbcjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vx+nQbvqfKvjX0pk840IBK4J6Q00mzKz/9NKmyBWMM=;
 b=e2Lilu/7a/nP8zSFUruNDsnZ/8qT6ieaq8nBpLlI0rIg1zRW/QH7wkHJwpa5JfMKDFRrKjIOy37dd7xy8UJVLanxOZ5PuOXjtZnvLGUxKKbOTKjpcVuSsVFt8xumr6P9syzBaIC/pLAiZudEH10yRXyrgoMLeXK3t0dOA3KwjBM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN2PR10MB4205.namprd10.prod.outlook.com (2603:10b6:208:1d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 22:13:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 22:13:48 +0000
References: <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra
 <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
In-reply-to: <20241015112224.KdvzKo80@linutronix.de>
Date: Tue, 15 Oct 2024 15:13:46 -0700
Message-ID: <87ed4hrp45.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN2PR10MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9e6845-82b5-4e84-5777-08dced66a46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/qKwlFMzMZhgkLLKWUW6HeVxpKAhiD9xJg1hIAHnFCIptf2lsNCaqHaBqcH?=
 =?us-ascii?Q?HRVqgO9KMLFrNJ0oCqJjmWKjDyaRSJhylksfXLtqAatnxznqd7HLlHse+UD5?=
 =?us-ascii?Q?i1xLsrDBM96kGnsM9q/v7p2F23fmaAeNndBjlQMhKz8yD96pyKuL0LaJ798r?=
 =?us-ascii?Q?Og0P02w3pvLVTAh/YPEAc74oze+emQlbNvmqdBgmDegZ/8dXYrbfB0VTsnKu?=
 =?us-ascii?Q?4o989D7gro2js0IB0cviViC8HOhIh/OB2rpesyquQhKfIBWY3TPcbxQgj5GZ?=
 =?us-ascii?Q?/R6fOvmLS8JZ35O55FOPYIy1UJSUFZ22Lg2k4K+vRmoY8WwtIDpZ9L6diEXt?=
 =?us-ascii?Q?8UGy2MaEOB2t2CMKc57/2sY1A/9edMmu923W1D2p0Ep+/gU0mHbuw7xTk79e?=
 =?us-ascii?Q?W2tYzKHhqAxwfg32HOAWlaOwS3RXmentl+1m1y/MOMTyQZIyXOxL1ND8p6/i?=
 =?us-ascii?Q?mDEjxDf+7PQFcF107LAbpgsG79UkXHOUTYcAH3DcpoaGaNORE2+nuyyB002C?=
 =?us-ascii?Q?0LgOrwinyv5Ucu7u91VDBgMkDxB6B+drgelEVOkEQIJrQAVz4GFdmTVDkm87?=
 =?us-ascii?Q?fwZ2v3m4AsSX1r0qa8spSy9ubAmTAz2PrJvfPbMCx1kyJ0oGSi4dyuiKMcif?=
 =?us-ascii?Q?SC2Ah44+PDJkXs4vicOFXHSBQIy5Quu3bU9scXySTorU0sCzygK9J6LkXoTU?=
 =?us-ascii?Q?q168+T2TpF/nDGdhBcRZ4S1iHl8OpvNxDxZS5t35aaCh7iinvSa+b8ypEgUg?=
 =?us-ascii?Q?CUkDPBecvuHcUKArs3d3SQtspDky8lzMz/fGHH9MNVlfjY8PI4p35hHUVQ8b?=
 =?us-ascii?Q?PiJB01mQ1TzDIQPNSHB+aDZuzWZk9CVolDRt4U/9E9A0Mr3LZorq4jOmSxE/?=
 =?us-ascii?Q?6/r/5ZzUOvdqjUIqZameY1BFZul1J+rgQv0M5OX5lSHHNPc/kDGtNqgLrtdA?=
 =?us-ascii?Q?wassorrebaRO2gh3Mi0BUqv1ta+50C2BNSfRnTWbaCn9EwRcFjpyrffFg9il?=
 =?us-ascii?Q?PeJAnCc/5jV7BZaLyr36cKgKzxIod3Cz2mZSvMB4ndoMlSLeXoaZTbzwhfUH?=
 =?us-ascii?Q?NUA+DKkmQi6KCRaXxM8CIaxLdHfDN1q2dbnfFTsfROiSskNJ0e4NxphC2RyK?=
 =?us-ascii?Q?nG0IGMpVj+N9W+5tDnpwjIn9IKGnH2k5U18e4kXUsn+yGvC3ML5Ra0WhvUw3?=
 =?us-ascii?Q?JTJZE4u3SqUWmagUJS+R1GBrqGs2HQ8s3b4/HRfwzjxSgphhRBl+0i/YQhvm?=
 =?us-ascii?Q?bCae7m1vLHvSVU2JztUmgjg3POQD9eWBeZYB2sZGNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7IsJPf814fJYE/ejnlCt/O1JkLr/t8BsXu9OK11J+ucZD2cIA28qN3DrgyfX?=
 =?us-ascii?Q?gws6xoRXZDs77VZ2xYw5wKK7Q0rSzau+5SuhhYKiICj+lTgG0h5hd4pAdAuE?=
 =?us-ascii?Q?YsfUXQPnPFIaCTiInh7ICY1FdLHqBm2StecHVXhLKWt3TsUI/NG6ISzdrjSk?=
 =?us-ascii?Q?xEHd26T9la8QAHiiBGsKV5YiWBJL6gSxIJDdODcwJVbB1jpSL1X+tGfJjdGn?=
 =?us-ascii?Q?CmnG36Axyui3PwjU2wpIescKgfrxXBu8Uj6Y/Ah4aTmi3OchXSbXrvEspFcR?=
 =?us-ascii?Q?3NGvC88jUHqF7JcgnPxQPCefBET2kVIxU+gewjuoDHiHsekUXO9k3AEqTFln?=
 =?us-ascii?Q?s+T323cpS+R4rLglpbRlH1f2K5pc9cIMR/p2BdhMMjuRQtYVO1KZnKbVWtYg?=
 =?us-ascii?Q?2nDJ80zQ2SbMlE1j2INW811783w1Ha90YHnsAEf7W2i6+Mbst7gM4454RnSC?=
 =?us-ascii?Q?BPCM4prM5UB0dw/KTTsHWh2X0Us/G5L5RRQrQCT8fM+bxdMqCjL0LjksUdtq?=
 =?us-ascii?Q?XhhMpy9xLyldJ+n9x/j5bSL4z1b3OQ4fqrOlO5UA3y0PYxV+DKmKw6mQcKcB?=
 =?us-ascii?Q?PFK+9D6YfjMCE0WESJ/yLpURZ7TmC1UU/RHr8NQ7Y7jJlEKKmRzxV6qzJx8W?=
 =?us-ascii?Q?1hXHVtM9NDe7ePlW0+VSOB4RPX2qcJrB3lfx/DEWv+CL0MeD0GU7c996+DXC?=
 =?us-ascii?Q?+sonmMqIfjWPJ5BKo5uAXobAFMBwKl0AT3XakMbil3/GBsRVa1dAtUdzF5q4?=
 =?us-ascii?Q?0ojoicsuoU4zs96W/fYgehQIW590ptK/wV1tRkQCFxHNNmNbY3AaDogjPkQz?=
 =?us-ascii?Q?G88MKgcZ/7JUDJ8zAJYV7Dy9yxQcZuoHWbcS8JrI6AhArSFSmxoMZoHrNZFH?=
 =?us-ascii?Q?5CdLXa+R0qmLFsDDb5Cp0IMCZvpRjApPw3E6Sy8HfNjyckdoa+RwlDgX74BN?=
 =?us-ascii?Q?cxe6sajR3A2TsppUJMZGSmJX9RzpJpo91pwqYzwxp7Pmm0R/YwyJbxA9g6Gu?=
 =?us-ascii?Q?+TNEc6TLu6FKgGn8YlD4vkVb7c2JGNOaFgxVABLxaHmSPFXtciz4LFLONyDh?=
 =?us-ascii?Q?9igMC6j3xRU77s0BHo1STRbISGmpmZBBlos1Ot3wpGPMk5g3Xv+upc2PnyPG?=
 =?us-ascii?Q?bcmIBKnCYpJEdniVV+bugzxFRdA5AHPnliI17QWmLCexkNJyUkR8afcL9Fed?=
 =?us-ascii?Q?hkdbcwolJXi8WQd6I9ioiTkiCXptsVHQIqr+/hKLjd3EpRMHUEQP58YQH7d6?=
 =?us-ascii?Q?ZPzjluXhEArCaTnqMhQRnDWTjEcRXj14HcBwFL97UkJavJNBceTLtfpRroNx?=
 =?us-ascii?Q?e0TYQHOypP0obsZYkkJEEWGQIssNPhw7+eqYr8ksnlqrJ9JCkdxBaMCppUox?=
 =?us-ascii?Q?9mLhr5FS+OohyrdHF+cmTvuBQUfSo7kNJ1STKoU1pjF8bX80Ewf3l0m2iZ68?=
 =?us-ascii?Q?PGsoGdSmIIgoY4rKvsJU5VnPmhuJqH64EiqhHENH9CcE3RyGdjyrtPoRtu6o?=
 =?us-ascii?Q?p+2Sdw05W5pwrxEgxdAlH19Y8XMKijxG9ljmpVuw8CG59n1pfNE8nv3OOvAP?=
 =?us-ascii?Q?np+pHHAE5p/1Ff8gJ9y+Igx7Q7r3NuZxi4z4Gl8Kidtob4mOXd1ZfzFS/iAd?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gFqdUd5CRmRaQKVEVKRrtJzIOg60JOHheU0PC3jHzTt6hCb2gOCkscpmO/CJI8Hrr7x36LUsSER6O3ETKHNKAmYkttAeInuHtZpxUfoiV3A7qJSG+NbKBb22QwRneEaOV2T0s129iWfkZjEoR2W8qdECAqCiDyZrixwRe9yjuDbg8sandFtI+xG1owza26pSASJZ7xXMIzbU/ITVXdbC+Os0uZFrquzEALshbYrgyTd1snQTk4JDtcrKLlJfcVnHa8YkBLEEQYQWMLLEoIEJFTOTzE15163d8+iiV6WO3RrrQaCnHziEgE20p+6LQnBl9IPLUOyPZeGAz3yk5ib2QMySNVE0Eq6+d4HFo5p3//hCtXwXBFJ40ZO7m9e8MJC8ERO9WWQUuQj7S5/0ap75lIjqRAbuPjQnMC2VlW5Qg8Tj+RrOuKnHfuDzInMVyFf3+hLbRlntK3BefhTeg5wPeatby5uMaSJJiXbl8pt7o65/UHGS1aqvERsLH1P9i3dqbw7ouPXRp57qZhtC2+qN0zWJnlGSrJyI4D9PyzwnrSKx5j0sEklGqP9zMwtnL9La3hdAg2lpDorsGIqOTREGCN7E24Cz5ReF6CP5Wg86PBE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9e6845-82b5-4e84-5777-08dced66a46e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 22:13:48.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9o+LKrv8WlSaH0xDEEoOWRS0RGNIQpAWcOr/y41/tZ2408H+uOOD0ZslYlR5WHyNokKP2dwR5VC+IRtR0q78fVWQkTw7v12vlBHWRrHbR8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_17,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150147
X-Proofpoint-GUID: ccsVuE-0mWpOd8ywYWTTVOV3fhCN_W3Q
X-Proofpoint-ORIG-GUID: ccsVuE-0mWpOd8ywYWTTVOV3fhCN_W3Q


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-11 08:59:14 [-0700], Paul E. McKenney wrote:
>> On Fri, Oct 11, 2024 at 04:43:41PM +0200, Sebastian Andrzej Siewior wrote:
>>
>> > Okay, this eliminates PREEMPT_DYNAMIC then.
>> > With PeterZ current series, PREEMPT_LAZY (without everything else
>> > enabled) behaves as PREEMPT without the "forced" wake up for the fair
>> > class. It is preemptible after all, with preempt_disable() actually
>> > doing something. This might speak for preemptible RCU.
>> > And assuming in this condition you that "low memory overhead RCU" which
>> > is not PREEMPT_RCU. This might require a config option.
>>
>> The PREEMPT_DYNAMIC case seems to work well as-is for the intended users,
>> so I don't see a need to change it.  In particular, we already learned
>> that we need to set PREEMPT_DYNAMIC=n.  Yes, had I caught this in time, I
>> would have argued against changing the default, but this was successfully
>> slid past me.
>>
>> As for PREEMPT_LAZY, you seem to be suggesting a more intrusive change
>> than just keeping non-preemptible RCU when the Kconfig options are
>> consistent with this being expected.  If this is the case, what are the
>> benefits of this more-intrusive change?
>
> As far as I understand you are only concerned about PREEMPT_LAZY and
> everything else (PREEMPT_LAZY + PREEMPT_DYNAMIC or PREEMPT_DYNAMIC
> without PREEMPT_LAZY) is fine.
> In the PREEMPT_LAZY + !PREEMPT_DYNAMIC the suggested change
>
> | config PREEMPT_RCU
> | 	bool
> | 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> | 	select TREE_RCU
> | 	help
>
> would disable PREEMPT_RCU while the default model is PREEMPT. You argue

With PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n, isn't the default model
PREEMPT_LAZY, which has PREEMPTION=y, but PREEMPT=n?

> that only people on small embedded would do such a thing and they would
> like to safe additional memory.
>
> I don't think this is always the case because the "preemptible" users
> would also get this and this is an unexpected change for them.

Can you clarify this? The intent with lazy is to be preemptible but
preempt less often. In that it is meant to be quite different from
CONFIG_PREEMPT.

Ankur

>> > > > If you would like to add some relief to memory constrained systems,
>> > > > wouldn't BASE_SMALL be something you could hook to? With EXPERT_RCU to
>> > > > allow to override it?
>> > >
>> > > Does BASE_SMALL affect anything but log buffer sizes?  Either way, we
>> > > would still need to avoid the larger memory footprint of preemptible
>> > > RCU that shows up due to RCU readers being preempted.
>> >
>> > It only reduces data structures where possible. So lower performance is
>> > probably due to things like futex hashmap (and others) are smaller.
>>
>> Which is still counterproductive for use cases other than small deep
>> embedded systems.
>
> Okay, so that option is gone.
>
>> > > Besides, we are not looking to give up performance vs BASE_SMALL's
>> > > "may reduce performance" help text.
>> > >
>> > > Yes, yes, it would simplify things to just get rid of non-preemptible RCU,
>> > > but that is simply not in the cards at the moment.
>> >
>> > Not sure what the time frame is here. If we go for LAZY and remove NONE
>> > and VOLUNTARY then making PREEMPT_RCU would make sense to lower the
>> > memory footprint (and not attaching to BASE_SMALL).
>> >
>> > Is this what you intend or did misunderstand something here?
>>
>> My requirement is that LAZY not remove/disable/whatever non-preemptible
>> RCU.  Those currently using non-preemptible RCU should continue to be able
>> to be able to use it, with or without LAZY.  So why is this requirement
>> a problem for you?  Or am I missing your point?
>
> Those who were using non-preemptible RCU, whish to use LAZY_PREEPMT +
> !PREEMPT_DYNAMIC should be able to disable PREEMPT_RCU only in this case.
> Would the following work?
>
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 8cf8a9a4d868c..2183c775e7808 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -121,6 +121,7 @@ config PREEMPT_COUNT
>  config PREEMPTION
>         bool
>         select PREEMPT_COUNT
> +       select PREEMPT_RCU if PREEMPT_DYNAMIC
>
>  config PREEMPT_DYNAMIC
>  	bool "Preemption behaviour defined on boot"
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 3e079de0f5b43..9e4bdbbca4ff9 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -17,7 +17,7 @@ config TREE_RCU
>  	  smaller systems.
>
>  config PREEMPT_RCU
> -	bool
> +	bool "Preemptible RCU"
>  	default y if PREEMPTION
>  	select TREE_RCU
>  	help
> @@ -91,7 +91,7 @@ config NEED_TASKS_RCU
>
>  config TASKS_RCU
>  	bool
> -	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
> +	default NEED_TASKS_RCU && PREEMPTION
>  	select IRQ_WORK
>
>  config FORCE_TASKS_RUDE_RCU
>
> I added TASKS_RCU to the hunk since I am not sure if you wish to follow
> PREEMPTION (which is set by LAZY) or PREEMPT_RCU.
>
>> 							Thanx, Paul
>
> Sebastian


--
ankur

