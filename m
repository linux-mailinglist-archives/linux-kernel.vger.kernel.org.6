Return-Path: <linux-kernel+bounces-398914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 368499BF7E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95C3B22E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F50120C47A;
	Wed,  6 Nov 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eamvuqS0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hkvXHPJO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ACE20C335
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924346; cv=fail; b=P/SJkBliayY4xDuE2jbNMHJ8Dz98F+0lp+7ETFYzsDT+hM2udSj/9plAsOesrAz0OKftpUWW/HSHFwVkpP6Ysuu54zkQ3vPVfmu9+awptCAQSRzqeYpCX4FKoUYkwAyvhYkkPZSensKQU+AuYwVpTCJyy5mjTRo67QLuWPifqeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924346; c=relaxed/simple;
	bh=XkDLi5ol59gRERPDVk3D5C+wdBJEZPFArCBZTwoj2Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q/K8jV9l7MpzXBQN+m4081ypf1buyNAYcDGnCqwXDeGj5MljGVuIsLV1zGXt+wHyhfWkYCoWCjarpLstz605CvVzmbS4/kA/UO+HDbybcrBLSVgSEzRZj9/rnaZv5irmMCfAr5TpYPkJCXJl8P/jwa1XAh9OgbLZTdIwXIwpXB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eamvuqS0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hkvXHPJO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXXJv005483;
	Wed, 6 Nov 2024 20:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DePIVHClCjpAOXGADN2fMS/sfjzxG63DBLHmmkjwoGA=; b=
	eamvuqS0KMJvebkY8wgHdQYP0QDJDTXmnbX6Hb7dw9EGGT5icafwrFAifksYbjHj
	2B4PnqFdRrXmRX2mzKzygzzf6H/afi0z0FYLcEXoHCwSAZFb7AQU72D9nJeCwIf4
	EcnX3sYO6GdRVHYqbFuDMbFacB4bF81JmZOnH99Ml+7Rxj96HTIsB3Feokcftc6E
	pdcF2O5lo9BmIi2CjEwdadXydoju3Q3QIJToHqWlaXBaIr56glM/uvO11HrL20uq
	HrPompfRFZ4uX0NrUelg+i8FzyvMPryAd1khVLmK7NhwDsIctUleTntW76rW8XaW
	uOGER2ggEiHzWOqy8Orv2g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagc91cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JYkii009712;
	Wed, 6 Nov 2024 20:18:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahfc0pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4bsP90G8aucIAaOx7ho/+fVc84G7iB9gZMFc3Bp3lZg453M8TJwx6E2DQxAo0H55MaOHAwjpiLw+23q/pGN4/xEtWDxqXx6eC3mZVKwOSkJ0y0M0pzeJfoloCzWrRW2u9XAWB5YJ9dwuoj9AoF0dYnaciGQ97GWQUtYgcG2xaDaEAxxplgXPEXt7BCAkE+VFvbvr3GkpMMxof6DqT/yqVX7jdNuWl1FJvyEPTVgMzwSiSid+vVCnsrWkX/hvGocbsA9QkywbXvy9o7+ULfYSUO45m9Ixs1GfnUC/tIIkU3Ep9HHcm1OIkskyggSpVuDYOlU+TfmwlMZUwIKXkotyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DePIVHClCjpAOXGADN2fMS/sfjzxG63DBLHmmkjwoGA=;
 b=u4xo7z5evrkrYvmyUXypal+lPlv/uq44abcUlCRoTwwyTjiOHktDPI9YuVj6JUx3wbDIbuCR/QkTsvQLvKpZTsxSWkgrhi2WqFqKxdsOT4wS0FDHwjLtFQ9XlAvWAJ5zhOlfhStisLeFeZxL5/X1VkbWB96em1vBMUxO06hrPVCxkq1ll1s99cXoaTT4ZoqxCIjJxUPdiUC2uZKOC43ae1rx/TSPc7b+WKuBs5O004CecRkuPq7CEZ8Ez5VFgPr19+V82W/y5jY9ifNvWacoWfPscninfmbq8LoB5edtB/ARj73EKXN1jkrZLMwzMYrzF3UNsgoVOUFbGgzRH8ijSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DePIVHClCjpAOXGADN2fMS/sfjzxG63DBLHmmkjwoGA=;
 b=hkvXHPJOxXak5xZkpQz48wketohFPZooIvMBQssYosT343Wg0nLb2nRj5KEFOHEDN0+/S97rs8quCbI0FM+F9ItXZQ1c0c3PclNjYI6NDtwCquAuDOMllTkO2FAqAAzmS5uYEDyrG72yXmPo9OK9gmIYDI/i0U+OOR5myxhgj7E=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 20:18:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:18:04 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v2 1/6] rcu: fix header guard for rcu_all_qs()
Date: Wed,  6 Nov 2024 12:17:53 -0800
Message-Id: <20241106201758.428310-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241106201758.428310-1-ankur.a.arora@oracle.com>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d892a7b-d2c3-44a5-1e0e-08dcfea01ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6ObcAwoBhL34ZhWiuV/kUd/O7MoVa+N4lJgzvwwQlsNdjHxSgXgQiRHnzCg?=
 =?us-ascii?Q?IH/gnSkX/AxO1dX0cT74q0OwopSH0LEtESmJgaIBDToOx8LXxFTIVNl11185?=
 =?us-ascii?Q?mFZnKXrx60EEAPZjw9zTmXL0PGMt6fY31yEsd0Cz+llFi9CCKiN0H7ua66pc?=
 =?us-ascii?Q?MpaRYqZtzMeupASllXORZswgduDFNWZBLUci5t1R4XaZr9Ijf0xwzL1p6v3f?=
 =?us-ascii?Q?Tqz4M/NbqbHOSRQ2+SV4vlkro0zLoU0wcNhZWBY9m8vE2tmhtz9zB+O9ndvr?=
 =?us-ascii?Q?NooPeFXAQgJS1f5JySVsEr+mRjkR5KjYHYaLlxG0YIY0sYEN+DsRGi5KIj0u?=
 =?us-ascii?Q?Gw+p06sIUjA+qt2jIXO7UoUG2g+RkDtyqwNHyISbawVf/WOdsj5BunRK3SHJ?=
 =?us-ascii?Q?NnVtzc0xwGatJ0bMOz633jZYsyIgRRtIgj+oRfX7tiQzO0469ImCroUMTgdf?=
 =?us-ascii?Q?4h1hUIWhbwPnyVmDaOAIgPy4AAplgT0oEte3MHxOte9Td8Kw8jnlOQnPp2RW?=
 =?us-ascii?Q?C2yq+NbWoi3DZ3HMFWXwKUh3MiKD+dkbLSCGSPHY9cslbgHEVCJh0nN69OaA?=
 =?us-ascii?Q?pAor/gd8R/sSKoiEUXJmQOPTCEpqTLYAkEkR22754EzPRz7ernlyE7LiYcwy?=
 =?us-ascii?Q?cSTm3DHdpcNt/m1MbND4IpXFKMZlAZlKs2UQIR+vryfdm2gplBIlaKBOtvfd?=
 =?us-ascii?Q?F+25Ojvv6qNFZKBVaBoRUvTs0ocnHYZIKW5c/x+NGudzWTQxhFh8ocsrSYC8?=
 =?us-ascii?Q?MXxA5vp7/3Zzb5NpJ8w9OJ0P268RtwXeHST9nivpQaePwPpsHQpLdG283qsb?=
 =?us-ascii?Q?iDL2zP8IK7K/PHyAr9BiH3Kz5ZZV0V/AB8TngCdGj5eq1fGQNwistOfCQyhr?=
 =?us-ascii?Q?ycN4xH/grDWEJlXflZUSZjeC+SEg+G4obyCooIrjRHGILR3QrdtlBJhiObNi?=
 =?us-ascii?Q?6OG3ni2+hIELmJ8hNk16vTDwXAfcy6ht38gbdoPD/5kaZTz+oGA9BwZb06bu?=
 =?us-ascii?Q?f9hhwtf7lQpl/HhfXFVguGHaf3WA/psQ9KcA+ohIlRM6OZppYN10c3Kpmyah?=
 =?us-ascii?Q?4rq0GB/DCI9WPfZ+MK/w1lzyTBhVQCo5wUw9HsRqyy1P8gEMKOZrth0LlGJg?=
 =?us-ascii?Q?EEDYIfB8uSC8wcLLo1Uf+78Hir6JjyjW7XjP/jGmkiS0ggfPgNWxKkXpPnue?=
 =?us-ascii?Q?1rjrHtMmK3T/p3K3pxOKV0fNUCw6zcrKUxzhvwcaCtqED5FR9d+x14f1NaYI?=
 =?us-ascii?Q?LMEKy+qY9UiRJ8D21/8j/ViN+YT5As1pZdpsV/4jqqL7MJsY0696E132ZQH7?=
 =?us-ascii?Q?6uJESj2JP2vOsSsmYX06lLDK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DdH2ulY0Dgh6yHC4ZT84sDMgK7Wpea4uwC1p/yepZwv7DlunxZGqWHd/wwLU?=
 =?us-ascii?Q?DfQsq58f05dI1FOw9mwoBSdG0vieN1Y/xEPVwG1hL/RiWEdf0bIZwanS2YbR?=
 =?us-ascii?Q?HDUkC0tgjiWV52oNKhmzd9Qn6b38UZAC2uHjimPRNuKN9dNOz7tPaPCdIY1R?=
 =?us-ascii?Q?MKunIeJa7zTO0rx8rCGhywYHvMu/LG3sXFmhmoZ/8EvEIyLcOIASDnIK0Fyq?=
 =?us-ascii?Q?0R73qX+P9np92Jx1fe9fjIneke0Ki67r+M15DnDTQNyQ/O3FRWH/mMLXSdY/?=
 =?us-ascii?Q?Ex4ciJCr+C869H6ru9thUMmXQIS4ZTqujDJrwLenrFV7UEDd894adaSNUy8u?=
 =?us-ascii?Q?pQ9fzR5PPSDd5Uoy0Vvc2yI+i17Tm+G5nbN5CqDwwAX6M0j8POEjP6EFDZsj?=
 =?us-ascii?Q?70u9UjE4cuKKviHQU+APn46MAs1jIorB2QcjAXgMY3o/JNv/2g13GPPWUMzi?=
 =?us-ascii?Q?wCm90ei7MguJcJj3yYdfldGy+UnAPhyBBf49IMoB2yqHYRD1VJIqMTD2BjjT?=
 =?us-ascii?Q?LmQ/O4cN9xkPddL5kXb9RWX8ar9wpx8L3o9dJ7SVRkg44bqWKD2QKvfa7JTf?=
 =?us-ascii?Q?cs6F2dadW//3qtcoBeopzrcBLorSW8FP3yYorW7Sdoiag18oikOHPZUsJbQt?=
 =?us-ascii?Q?tD9mI3O+eycHtdoALL+8Q692jPcWU5GTvGwfSTdqhPwlwX6OrpsxHJFf9QKn?=
 =?us-ascii?Q?41hyS3WRwybYFNAEefJ+Hf1hbFDFP0J59DuyoBTnQx+tLDhiL0URSpTbeFE6?=
 =?us-ascii?Q?LEDNhsWXjV6qjWbGbLzEOQt5CMSD5IE00mDvHVIjxislFqYkolzjTPYnDPcK?=
 =?us-ascii?Q?2R3KmSDO+it3vi6FpyN0rwcGvoBVdnQUlF+q1U/ZWQ4bxtYYErFvwbRmMMHK?=
 =?us-ascii?Q?94pezHype9ZhNRwQj0EAQU8uozh3qsEG4uGwhviioq4U4L5ZzE3fCffy5gUX?=
 =?us-ascii?Q?Q3j/J7fd0ntEKOBO4omefyzaCX5CbDEx8CrNsCIFZcuXx/o1NteFPx+5nOWU?=
 =?us-ascii?Q?du8ozW0MgP8PsD+QI93jDkUojNJMbwj9RQtnzekyDzvJkk5PPvEwqKGISy5I?=
 =?us-ascii?Q?e5eVt0JwpNkPmqQLiS3EvoSz0nGlCGoDyOl4mMqOVvS9t9w99IorhFIEKwjk?=
 =?us-ascii?Q?PiMYNk8JUK9X6uL0G56q195ucOJp4/Jb9cMGkURruVs/O0AVNcN2LK87Khu6?=
 =?us-ascii?Q?TJa3wLwgjNhE1WamD07eEZx/O6lvGb0uqNkF4zym1CKRRUjOg0vIM/r0YuMY?=
 =?us-ascii?Q?Ek/S5ZFREmZE5p1J3K3xVXbWoqZp1H/Bq4rnAleuFukMXkWWgfDNKgxi8pOj?=
 =?us-ascii?Q?EQjWtBz5jaF41eNog1QYs7m2COeAFIIXS1crWdpTp3EK5dWXlubTYnHht/Fb?=
 =?us-ascii?Q?Off6ZJ6NlgqzOe6zKhNkbnGq60qb1/F9kGCyGa1bJXLv2ldbr3+C+7uIeuvU?=
 =?us-ascii?Q?+KXW6Cw3O80TJSJGHSJOW5zd25yVCxdsgOjanmQVzLuPLAofxn+hMu49wAb3?=
 =?us-ascii?Q?6wFl3pi4aVqsyb32GDQkWdA43icblt6NKspiKLxOkmrQL+8xOgTwz/Hzf6H/?=
 =?us-ascii?Q?zdZGyt4OVYgKaIzfeK6x04UI9ZtfKnkpG7EVCwsMB+NOzFhuqeOuQEZimujg?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	361q49g2hvZEYTHWsAlvcbsZU2yIG/ia2/f7EWWO8/4socuciYMMSMnBt0KWKW6BEBPmuHYjqTekOgZsznkJxowLXsZy6RbsY+JcXnIle23ZFzkF+SbphfUjvpH0iShR+qW6m6LC02r96Nrq7KTnbGrl/7pXOdN3r/Oini9+M8PSW7dq4nyGaSijZLxxwieetqRt43HN9RB+g6aogtsvAbJ2Umu7FZ3KnB/RjDcJrMrq9S4lmddlF6jh9AhIeZhwCWuppTA8sPEMSea01n2c13Qg8ZGVyiNjykIfvOiGQVxCOWlpazMaE8lrFPGmnpeAwV8R8VPdXSfaSIgHxbpmwarwWyqUEv2dZo+EdicfDA0M0e0an2TyhDZWv1j4I8HWTu/2/Q8wv/aw+qclkt0RthHbTI5i0OvBCsjmWFj82ZzGt5lFfGlV5VV8UG0bq9+hNCCDOsoug/fa2CFsfDncCjFCPDK+qL3dJ6/M+9EDf4/qYQfupUln6ge36c0MeIL+xFmc77JtRpuwz1+VMB+OqvPRP11eA43Tvfw8y8N1vqJBJ65++m6Mdgzi0HxBUlsT6Re0VBfqXwSYtZ4DPQrLCLqq4Hw2Pg3kFRXcECHCz2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d892a7b-d2c3-44a5-1e0e-08dcfea01ec3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:18:04.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owrrWBDEdhDACxg2AzEVvdLNLSJ4cnCvHwn3Ax8n4RZbzhkptVYV+GCaTjHqKg1/T6kCNgBRKDoAbEbage5syfth5UA7UpfD/iBAyzgFY9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411060155
X-Proofpoint-ORIG-GUID: 2mgRcgAlhywpqozRN0ydBvmb3_lj6aJW
X-Proofpoint-GUID: 2mgRcgAlhywpqozRN0ydBvmb3_lj6aJW

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 90a684f94776..ae8b5cb475a3 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -104,7 +104,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.43.5


