Return-Path: <linux-kernel+bounces-425226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5159DBF13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6ADFB21A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA6155300;
	Fri, 29 Nov 2024 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FMqn3yzh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JUK7g336"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71C22EE4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732855186; cv=fail; b=QtlcdkKwzft5eudqqCjFV2Bf+MA1UlynHFUEcS16gVQLbcEUi4UtX8V1Kiq3PscE4Vyw/WoeN3FE2fSdEL+V18IhcEAkVTEEwYjvZJlR8sWLvRZL6TKhZFwhbzC847e/DH2A7pfrQ1a7Wd9UWxh1xykkWGcikogCiwiHCikb9ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732855186; c=relaxed/simple;
	bh=TEa0005QVYT0yAGlEtOyDmm+cWzz+EBpsCHj/ed17S8=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=rLvRRCjdxeEPNUQG5zXO//hfVhP0QjTjqbUUz5GNq80QzgwqdGEy0SraYuukfcJ3jNJKCWF2JbFE71oYeJpKV61E4TBKLlsZi8w3Oe49smgtt82fLJHw33NCPZOZPNhZlEdO2m5NXooZytQmh/OHMitgtPpBUDxbpkb2IEXEdjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FMqn3yzh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JUK7g336; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1fZMw017024;
	Fri, 29 Nov 2024 04:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+iyKYQFY3fZU4V/4FQQw+X2DB/+FQ8QnmOVPOiCFT/c=; b=
	FMqn3yzhqieYv8zG7HUa+lLZgE7b8kSsmE/KvcdjK4YXaPk6wvKAcWCZ+kr4N6Kt
	XMhkVxrrQGRTJIzovx98lredFWjyCBCaUfeQxlFFzyRl/ySfHFgbTBjUSsSgbn+Z
	b6p0+uSB2u9OWmLtRX9TwPe6II49w4fPaesCw64Jk+s/t7MF5oNqGeYO5D375xUP
	yQ4HW5AycU1ZXjR4SsfkClKbygr4jY1S/7KKh6ohcHtuUvpFST2nu8bu8Z5zfbWL
	y7qx1rSDWwUskCZUxLFDYJ2S1U44CqBwVzoG0W7KNepBlZk3JD6NNEfEpBd/r2pc
	a/eubBz4KRNXzoJMKsvSqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xx2n85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 04:39:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT31Pfk014235;
	Fri, 29 Nov 2024 04:39:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4367007w54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 04:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1So5oydJW7PzN0N8ULG4IpA45Odm6aGt7hPXih1066Nel1e8q5k0XM5W6TAlBPjYfKAMMue5fCkI9QXx1AA0wp0SEARR4x+oWVyigdHDSWn5Pgfa4CRbbiWJUVz/OiklzCyR7f6XKq2P6MSFSrq9JKs0/sfudBSEwobTIBmnzNZ2a3bZrz1IatLPSfdOiwyK5+KDqScs6eQiEv6LFBM0ZDkI811v6WNMSsjdHR1sJwdDl+tTlxz4kEVHa916tlLOFSNFTpCrSiZrOCtg69Cdttkc/LB2eGYOGb0fqyamJaS2NjUkz81SfiQPBoadDV03aUyoCQ5jV7/ZqpqR0rqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iyKYQFY3fZU4V/4FQQw+X2DB/+FQ8QnmOVPOiCFT/c=;
 b=LIQ98ykt7TKYaBgII/DPksN2yzs7acrM6JjQct7vlUxRT2fqOBQvDbN1jeHu0beL3C5lwhu3YW5tvZQ6V6TldV6u9lVcjIJEFwmCGZD+ybRDBMgw/LyoWA3pkBmkRwU7qJySyF4mjfZUyZ6nfnsrBGhjy7N2L2E+Q37O79Zxz+dzFPSMMg6wnWBe67HEJLHbrhYA+i8mrtmmdQ+FzWk/hrNdwD5C9Qv6fPihQUb6q/b9sEWivYB2rby6YzmPoTEFJ4QGrf6MqoiBpacOtnA66QaE4wlKwuMKN12NT6w3r5zQrDmB/st4hgn51aJmYbGVlJYIUcvnUMsaQ2JMxDDviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iyKYQFY3fZU4V/4FQQw+X2DB/+FQ8QnmOVPOiCFT/c=;
 b=JUK7g3363b+xxD5exf5+zz6Sa9UmzYeXLAKexj/9+55md0x/lr//d9ErFN/kvhVRh4MjeKtuspqLo6iftRETCePAmATcNII1TCLvpwva0LBNVaRT9SOsrK5248bau8h9ltQctRptYzx1aUHor9r24iX3SSqVIDGFYnMuaYiPa1s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB6350.namprd10.prod.outlook.com (2603:10b6:a03:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Fri, 29 Nov
 2024 04:39:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 04:39:04 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain> <87serfgffs.fsf@oracle.com>
 <Z0Xf37hJiyA7O0Ye@localhost.localdomain> <87zfllfddj.fsf@oracle.com>
 <87jzcpfbc6.fsf@oracle.com> <Z0hjNED_t_lqNFbG@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, efault@gmx.de, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
In-reply-to: <Z0hjNED_t_lqNFbG@localhost.localdomain>
Message-ID: <874j3qfyca.fsf@oracle.com>
Date: Thu, 28 Nov 2024 20:39:01 -0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: ae72e8b9-36af-4759-30d8-08dd102fc0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1AwUlNYZFpZRDlXWkRySDRPd3U1ZTNkUms2dWt0QUFyc0ZKN3lIWkE1enRL?=
 =?utf-8?B?TjZVcWhwakdlNTRKQ1pUd3ZCVXllQk5yWFdxYVdNcWhuN3JRenJNbEtBSXB5?=
 =?utf-8?B?TUtGejJWemo3bno5R1dRMHpyTGdDR2lWL2pOaktTK1g3OGhQTDJWQnhxeFp2?=
 =?utf-8?B?QmhNWHROKzNjRkdVVEFvOG93U21YWFZCaWlMRnBtQUZReHJxY000NXBkam9H?=
 =?utf-8?B?eE1IdDFGeWZGUGNKajRxQ1JSUk05TUhOOXBzQVRlTmxHMW9uazJoZjl4a3ll?=
 =?utf-8?B?N08zZWYwSkkzVUpMcVorUDhla2F1MTJMN2VsblUzcUJYelRmMldTNDJzWHZM?=
 =?utf-8?B?NklFUm9DYTJMR2lzVmJ3enRDSU5MaXpLYWNOVFZVNVZtQit5b0duallKVjNV?=
 =?utf-8?B?WWxySzBOZS9FNWVodWZkRkdOZjVHVWU2ZTRVQ0FsZDZxWHhhNUlibGcyeFE1?=
 =?utf-8?B?ZE9wMmVaSnI3NnBJRThjcnRNaXMxY29SK2VRUjRTWVdvb1JtNXJFNkk4OXpZ?=
 =?utf-8?B?dkJoMjRZZVFHQlFxK2o3cG96UnZaSVc1L01aWTRNSkY1eFVnRHhUR242UDFj?=
 =?utf-8?B?ZCtvVWlUN0dkN2VmWFc3ME12Wk9OdzRYY2djWHlqL09vUVNYSlZWTzJpdTNB?=
 =?utf-8?B?SzJSdkhldWdqT3hldld4b29UWWFiOXhQUFhhQ1BnVE1KVlNjdVMwYWkzZm9v?=
 =?utf-8?B?dWNhYUlkWmJHTzhlMFZSVUdBWmtQeGtzSDYzNGZSZVVHZGliMzlTNGdEZzdJ?=
 =?utf-8?B?VlZYNDBMMi9wYmE3QS8rbUpCVmZHaU5NMER0YWZVOWJkdkdXaGxaeTB5WTJm?=
 =?utf-8?B?QWl1TWFWbzgzUkxXRnEzWHc5NUQrVW8wRDNYdVNlaDBTcXFWWTRqNXdlN2U1?=
 =?utf-8?B?TktrcWVBL2dDeGd0QzlZN2ttZGxEOUNkTWlyYmkxaERvTER3UTNDK3hrT3I3?=
 =?utf-8?B?NFg3WHQybXl0cDBBVFlxa0sxWU0wMUhhWEQyZXJ2R0VwMFYxRnNnZ2FWOHY4?=
 =?utf-8?B?VlBGYUlhZEFiMDVydDdSalRhcG84a3dDNm1yMjhka3J3d1JOOTFIMnhnRGM0?=
 =?utf-8?B?dVNCbGJDZG1MTTRPUS83NlFrUmp5Z2hjajQzZGUwdTE3R0JtUDI1Y0h1TzRU?=
 =?utf-8?B?TG5rNVhnVHZuNFZzZTVJMXlueitYeFFLUHV5THB2ZXhweW05dU54c0MzT24r?=
 =?utf-8?B?T0FidmNUK1I1QkF0dXcxeDRodERPZ21kRzB3VisxZHc3NU56RGRiQjNnazF2?=
 =?utf-8?B?bVRCdXlYUm1Ram1vMkUvdmV6TVp1TjZHOWo4V0VFWjlMZkdWRUdkcU1yMko0?=
 =?utf-8?B?YkhXVWRNeWRGeDJIQ1cyUGpQaDd5YzJ2SlJSenA4ZzY1QThweml0ZUNWb2Fo?=
 =?utf-8?B?UU41cDgxZWxEMjVGcjN2OGVUUGpZM3pwZTJrZTZNTlA2MjZVdHh6aldpcmtv?=
 =?utf-8?B?Z0lKWHdZYlJwb3JLQ1AyQVZRZFd3WXJmQlZJeDArYWYxM1A5T0dBM1ZmVmdC?=
 =?utf-8?B?by9LRXQ4clloL3Azd2FUYkNKKzFoaENrWlZWL2k3UEMycSt4ZEVIY2VQZ0ts?=
 =?utf-8?B?RWRQbkwwS0wrUlZGK2RuYm9DeUh2MGN1NDNhSnh4d3JSclRDTGJhTFBTam5V?=
 =?utf-8?B?OU5Ua1lJbEJvNFRnRlF1RW5Ma25kVGd0TFBKWjZwTy9yNXhCUG0rR3JMWEx1?=
 =?utf-8?B?VmpwSUlmbmErZ0JWZlQrdnhObmlWYU5TRTBZTFlDZVBYTGVDSjRZcHZIMmgy?=
 =?utf-8?B?ZFNmZ2tjTkpqbGlJRkFZRkxjUnBZdXYvOHVHR3dvT2pNbUlLV2FxT1UrUnNT?=
 =?utf-8?B?RnoxKzVmdUd2NkZvdEtKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDB2K0x0RkhiSzNnZUwzdExIMGpua0VDd0F4K01HNkdrb1lNMDZid3NxMURF?=
 =?utf-8?B?YUo1aXBXemt5WG5XODdaN3loSG9XNTdueTNhcm8xK3cwdWQya1BoMGFvUDQ5?=
 =?utf-8?B?aWRHSkpQdHgrSk5rNnJ3YlVRb0xSODBBTVNlTElIQWFTUWszN1dGT1pqL3FO?=
 =?utf-8?B?czhuWk4wZlZ3ZjU5TUM2SDd0aUEyWVY0RWtKUFkrTk5lQVVKcGRjenlyS29I?=
 =?utf-8?B?d3F5SEVuRDUrUjhDOG9jWUVxMHB3azhNM2l4YkwvMmdKTjZTT0JXZ1NuTy80?=
 =?utf-8?B?RVlaU0Y2bjZpK3VoRGdrRnR6UzRMSkRVU2ErSWNpNzVZRFJpQTZpVHptMVpT?=
 =?utf-8?B?ZnBncDRMVnhlMkxiU0o0cWRpd0xoSXVkR1QrcmtPQkFQdXlqWWpBZlcxcFhX?=
 =?utf-8?B?dzE4ZUFQeFNCUXBORXJacGY3T3l5ZmkyajR3TTJzd3QrcUoveUd4bElKekFS?=
 =?utf-8?B?eFArR1I1Z0xpNjJYdmV4bHJPd0dubytwWFpiemVuYnBNVlVpL2JWM28yazBK?=
 =?utf-8?B?Vy8zSTRHaW92SE5CVHY1T013anhZSldnM0RSRS84eGU5RXo3eG9VY1FLbGVh?=
 =?utf-8?B?MXdRYVBDR1FTekd3MHZTN0o3OUFJY1JuTzA1L2t3VElPQ0p0eitrSzE5QmhY?=
 =?utf-8?B?bFRKNFUyeHlHd1hqUmxrSnpBaHBZMnNtSGNkazdQZ1cwUHlSVTVxZTlLSzVY?=
 =?utf-8?B?OWNTKzlEVDlsMGZqVk9hNXN3WHdEV212QXltSE5oN0tiazEvUjR2UXpFSDVq?=
 =?utf-8?B?NHV1elpNMEFabm9aTXF6Y0pjZmVnRUQzNW85dmpxSHc4dTVlUTc3VVFYdU44?=
 =?utf-8?B?QnluU2VYSlRJMm1sN0VPNTE4RTYwNjVzdVJsM2JiNEhYMWw5c2hneU5PUFVJ?=
 =?utf-8?B?UHg4N2FidTdZWHF0KzRhU255bXBrNzFaeVFTZG1EQmVpS01pazJoeDlEVkJ5?=
 =?utf-8?B?TXBYdHZVUk5WTzNuYWJBWmZXbTYzNHBYbDZYUlhxdWcrMEpEaDdHaG1Hc0JF?=
 =?utf-8?B?aVZoWllGR0QyOExYVmJLN3krb2owclM4N3ByemFSRGlPbkJ4ZG0wc0ZtVHla?=
 =?utf-8?B?dDl0NytYRnlKOXJicEZ2Z01yakRtY1RrdkI0TUlhMFFmUVpKc1pQRXJPNHJn?=
 =?utf-8?B?REJvemd0UG9jYWFxdU1DS0tDdzh1Y1lUaGQvWWx1NVhLVFZNVnp2ajBpSmlB?=
 =?utf-8?B?WWI0anF2UiszdVZDeS8wVk1Ha0FRZlBFWmRITlFneDVYZHV3ajlhZ0VLTzV0?=
 =?utf-8?B?cUxUR1pVVE5NZ0hIN0FFdkQ1b3c1NTFuWGdjR3dLQlkyU0MyQTQvSjFLcTdE?=
 =?utf-8?B?WitZTlJtbkp5cHNFbENCNmZTS0k0TUQyQTBiclFDb1oxb1FURlBjZWtkZTJP?=
 =?utf-8?B?OWpSR0RLcmszWDVZQ3JtTDQ5c21adUExT0JOY2x1YVJrcnRIamc2cFdxY0Np?=
 =?utf-8?B?cThIUnZEUGhPV0RqTDVNQ25yNUFNakNicDR1THVweHVaeUZZeDd4Z2wzcGJV?=
 =?utf-8?B?V3lrL2tpb2cvdG1tVWNHejhrT21ZaFM5dVpRa0RkZ29sbnZMbElxTjdBaGcv?=
 =?utf-8?B?Q05DV1h4OHJEaSt1a3JXUGR2d0hpT1RGYXc5YytiNG9mdGRWeStIOUNyOFVa?=
 =?utf-8?B?L2pCcnJjVFI2ZVNaNVBTd3pBVEtINjQwbU03REdyaUoxQmpiNG4rUE0vb0Q1?=
 =?utf-8?B?aDcrNXpyWFR2UzBoTEFEbENUYWlXbkMzUEU3L0IrOUVjSUFRRG9QTENjc1Ez?=
 =?utf-8?B?ZmM3NnljK04vMXZ3UStzL0ZSNE5qNmJXc1JWRFAxcTdXTnByWFNHVnpBQWtH?=
 =?utf-8?B?d2hQd1Q1SThPK3p3Q1YxeDdQYTRBUHRhbGJHTFpwaDRmam1tUGQzL2lMYW04?=
 =?utf-8?B?Wi8rUkZUK0lkZTBHc3pPa2NsNWRqS2ZPZ2V0N3JsOU1vbThOUndNSE5uL0NZ?=
 =?utf-8?B?MnZ6SFpiYkhxOGdqc1VLTDdNMU82UTdpWTF3VS9GS2RCWG4rQlhxeDVYL3FB?=
 =?utf-8?B?Sm8wanZ0QTVIRlptSlQrSDFoYjFocm13K3UrWUt5NjVEazFIQm5zR3FZUUVG?=
 =?utf-8?B?Vys2MUlwdjZLbzgzWnpUZ3QreDVkaHdLUE9HK2dyeW44VjVzOExKVmZPbStm?=
 =?utf-8?Q?GoPNFT0kBpG4mi57fZDS09zyc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/8xj9oa4QW/1HIQkWlZzk0OXVHaLYF0jzcRss3KC/1ywAx5FPnpu9xATyFSN9ClzTGtn79pcvGER5z4L+EgrysJsavWhLgzyzY1bumpmV61UUzpebCiFuoC+3picQ1BE2qUlU8w748k6lIJMcpr8LIcCzgLOgSwltpDq0g+Rxslkuzf/c4N0GZ/nj/rNjgphtDHQIk7DyTklD4PqHCpGVuyM/3ohJK3YkD5C3Q7zGvSxewcXry2Xhz1VVtzADlOfbrnTMyxkhd7xyrB3fOcBVK8IWsI3LEvL7vElj1WaxXEwXqG7DRgyP4wx24yZNubXNpJ1evO5mbl78Cjp4Ok+4sPxnuvTG1yey1i2GRxsJT7Q+LTB3aoGA3NRkjKkJv+CfSR4uJw99/aHNl+O8Ki6fFPGpALW6RZ0UBDXwXi+LCz3jQC3BDPLjY1UGnAgzzJNyaiTLkDzHS0496wHtrt6MHNflQmNJm3yylyqe3jaYNH9EQpZYtSmvCD6oWYGCIQv6qZ3NPI9Yq2PiCKUsbs3ur2rOfG+bZuJcLrXg7KQpzvxmEu9mmhyBU7Sq1FZbasnJKd/E39JEksoDmV291NEt5wCdZWB37vC+AYZOXdFW90=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae72e8b9-36af-4759-30d8-08dd102fc0e4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 04:39:04.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0isSSjvIzCf1uAilaG6pMJtIVSh/IISTiNoKfLXgZIjEOSmZzFW2eTzjkEo59yTdoAag94g/clE/ndO3PkX4+BAwTRvDunk/65R6Qg40U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_02,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290035
X-Proofpoint-GUID: XuFeNBSgac0qHUSv097W31KAZWTewBsK
X-Proofpoint-ORIG-GUID: XuFeNBSgac0qHUSv097W31KAZWTewBsK


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Tue, Nov 26, 2024 at 10:19:05PM -0800, Ankur Arora a =C3=A9crit :
>>
>> Ankur Arora <ankur.a.arora@oracle.com> writes:
>>
>> > Frederic Weisbecker <frederic@kernel.org> writes:
>> >
>> >> Le Mon, Nov 25, 2024 at 01:40:39PM -0800, Ankur Arora a =C3=A9crit :
>> >>>
>> >>> Frederic Weisbecker <frederic@kernel.org> writes:
>> >>>
>> >>> > Le Wed, Nov 06, 2024 at 12:17:55PM -0800, Ankur Arora a =C3=A9crit=
 :
>> >>> >> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNA=
MIC
>> >>> >> which allows for dynamic switching of preemption models.
>> >>> >>
>> >>> >> The choice of PREEMPT_RCU or not, however, is fixed at compile ti=
me.
>> >>> >>
>> >>> >> Given that PREEMPT_RCU makes some trade-offs to optimize for late=
ncy
>> >>> >> as opposed to throughput, configurations with limited preemption
>> >>> >> might prefer the stronger forward-progress guarantees of PREEMPT_=
RCU=3Dn.
>> >>> >>
>> >>> >> Accordingly, explicitly limit PREEMPT_RCU=3Dy to the latency orie=
nted
>> >>> >> preemption models: PREEMPT, PREEMPT_RT, and the runtime configura=
ble
>> >>> >> model PREEMPT_DYNAMIC.
>> >>> >>
>> >>> >> This means the throughput oriented models, PREEMPT_NONE,
>> >>> >> PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=3Dn.
>> >>> >>
>> >>> >> Cc: Paul E. McKenney <paulmck@kernel.org>
>> >>> >> Cc: Peter Zijlstra <peterz@infradead.org>
>> >>> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> >>> >> ---
>> >>> >>  kernel/rcu/Kconfig | 2 +-
>> >>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>> >>
>> >>> >> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>> >>> >> index 5a7ff5e1cdcb..9d52f87fac27 100644
>> >>> >> --- a/kernel/rcu/Kconfig
>> >>> >> +++ b/kernel/rcu/Kconfig
>> >>> >> @@ -18,7 +18,7 @@ config TREE_RCU
>> >>> >>
>> >>> >>  config PREEMPT_RCU
>> >>> >>  	bool
>> >>> >> -	default y if PREEMPTION
>> >>> >> +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>> >>> >>  	select TREE_RCU
>> >>> >>  	help
>> >>> >>  	  This option selects the RCU implementation that is
>> >>> >
>> >>> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>> >>> >
>> >>> > But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
>> >>> > some issues now that the code can be preemptible. Well I think
>> >>> > it has always been preemptible but PREEMPTION && !PREEMPT_RCU
>> >>> > has seldom been exerciced (or was it even possible?).
>> >>> >
>> >>> > For example rcu_read_unlock_strict() can be called with preemption
>> >>> > enabled so we need the following otherwise the rdp is unstable, th=
e
>> >>> > norm value becomes racy (though automagically fixed in rcu_report_=
qs_rdp())
>> >>> > and rcu_report_qs_rdp() might warn.
>> >>> >
>> >>> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> >>> > index 58d84c59f3dd..368f00267d4e 100644
>> >>> > --- a/include/linux/rcupdate.h
>> >>> > +++ b/include/linux/rcupdate.h
>> >>> > @@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
>> >>> >
>> >>> >  static inline void __rcu_read_unlock(void)
>> >>> >  {
>> >>> > -	preempt_enable();
>> >>> >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>> >>> >  		rcu_read_unlock_strict();
>> >>> > +	preempt_enable();
>> >>> >  }
>> >>> >
>> >>> >  static inline int rcu_preempt_depth(void)
>> >>>
>> >>> Based on the discussion on the thread, how about keeping this and
>> >>> changing the preempt_count check in rcu_read_unlock_strict() instead=
?
>> >>>
>> >>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> >>> index 1c7cbd145d5e..8fc67639d3a7 100644
>> >>> --- a/kernel/rcu/tree_plugin.h
>> >>> +++ b/kernel/rcu/tree_plugin.h
>> >>> @@ -831,8 +831,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int nchec=
k)
>> >>>  void rcu_read_unlock_strict(void)
>> >>>  {
>> >>>         struct rcu_data *rdp;
>> >>> +       int pc =3D ((preempt_count() & PREEMPT_MASK) >> PREEMPT_SHIF=
T);
>> >>
>> >> This should be in_atomic_preempt_off(), otherwise softirqs and IRQs a=
re
>> >> spuriously accounted as quiescent states.
>> >
>> > Not sure I got that. Won't ((preempt_count() & PREEMPT_MASK) >> PREEMP=
T_SHIFT)
>> > give us task only preempt count?
>>
>> Oh wait. I see your point now. My check is too narrow.
>>
>> Great. This'll work:
>>
>> -       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
>> +       if (irqs_disabled() || in_atomic_preempt_off()|| !rcu_state.gp_k=
thread)
>>
>> Thanks
>
> Do you plan to integrate this in a further version of your set? Or should=
 I send
> a patch?

Sure. I can add it to v3. Okay, if I add your suggested-by?

--
ankur

