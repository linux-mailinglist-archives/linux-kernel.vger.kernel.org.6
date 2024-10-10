Return-Path: <linux-kernel+bounces-359669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3F998ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660F82864C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2E19D082;
	Thu, 10 Oct 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cuTHKXrU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UjRSiUVY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE8198831
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582658; cv=fail; b=d2b5+KRg6SNQW1wjRLJNbFNr9qXSSH3tNGYkwmqGb9N/fq2mXfjubpNomSaj222DKusfNYVtVS4QqHc3bnL4VwPCttIhvdi06KC86MQ4xCYFRKqFYryu1PwECWS/38Dg8AiMt48ahzL6DnKj9M74D8GMH5EzEpn0w66PE2bHyWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582658; c=relaxed/simple;
	bh=IaRkx5Qj9Y5rKGzNFccZWNjcWMDTJ3PgmNoWxhcoZLU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=pDFhBsWw/9Y1ivpuXmDMxnK4kps6PcbkUXG1Jvi5M04N8k6jaJryXgs9Ng9ydiU5rhVOHoJdLJX4P1WVxqcYUm98sQvGQdPr6jcqh/1k9Ya2Z1kSZ+sOaLNJaGPQHgUdZGsz31qLkOFfVR5GnKCdvc+6Rtw5So3wLJwFkgYMfmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cuTHKXrU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UjRSiUVY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHfcfC013395;
	Thu, 10 Oct 2024 17:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IaRkx5Qj9Y5rKGzNFc
	cZWNjcWMDTJ3PgmNoWxhcoZLU=; b=cuTHKXrUGWoNwlP1Z4JiIgDbC5leCV0gv6
	4mFi0IAvSxr7atAIr/HCnFweh7OKwwi7AHKuyPUi4gM8vDnkVp/04Cb4Kz2i09Q7
	rWVOWRs0msqXATA9oH/cyXQY/NyMyHtuEtFUyJox7YG/F+qEnmR2MEMzQeNxf1LG
	sIMRc6G20XBeSMtxxkgrjEAOg+/nNXWi8UthPbCMIb6aDPA+lnyFNc3SyjrcztlH
	4LLvfHofkOixsl1S1V4ujADSeNoPx4Wa8fwV4l11MR5NMx2z1l/Z292o4ZHUpyAa
	nYC2GNIOK/J/OmXDhRm40+OsvcwyonhLVuHq8331q8zWtbKoq8kw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dubxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:50:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHIJdK034287;
	Thu, 10 Oct 2024 17:50:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwacfm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:50:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+ydVkYdCJxC2ybKCka9vRXlpU9JdYvByx5kcldVo+0ccQYDc6gxTYTDjbLvnPs+vpvBbQtIZP6++iVgaKAAueYP0L/vLQtnbXiVGUaAyc5lbUtTZ4aUF1E5tZ7oQx9TD5KVaZpj62FjbAqm9xK6amDfC4ZDQDrNR/lqWmDuw9VNsjkUgAeRwouGnm5l2xfS7rqGMvRkyce07E+qZyn8kfePB2vjfhxcICVA3qBrX+GXSgsHt62KOwVRyYO607h2CAGo6oQ2QU5wQ79GAwwkkS9213D23G89MecVMKuTlya9iz5SWHjyhcuhmq/ygM9+LyIlU7ypf9JQIUtRjZdE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaRkx5Qj9Y5rKGzNFccZWNjcWMDTJ3PgmNoWxhcoZLU=;
 b=p5HzJqyk1osgwMSfDH0HKSokdOPdDB/ko9UifuwRU2nqQpQFDn6JTgjJPm915glWoDeZMy23nVZrFZQYCcUvxEUDgBd6DPXy9dKJUNpg/zS+jjFSyurRUkw6jhn0Nw28j0Fq0wntSkrcQTFJW+0xKFhHfoAwC9aaBicWO29XO45Ic7Hn8QnQIReo1oxHxfK5QhaNyZU9fr+o1YvaZpKG5ONPyfgN1bGpYI1+TlZYKjlMAILCUFiSsbYJVPhuq4wHlgKpq3E1ZFnaza/4Wn1GRMazSHZFwQOuLOUQy0lYZvpbryAJSzdlAhyo0/zAa5TA+wNHPlhz5Kfn2JUD7xkUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaRkx5Qj9Y5rKGzNFccZWNjcWMDTJ3PgmNoWxhcoZLU=;
 b=UjRSiUVYIFoH9wy3Q7IhOjHfH+YQXeSMS/K3snPsgQ6QkDeNzR+G+oswHE9g5qedqiO97vY/17jNZYDTNUvSfILWzxpkYKaAU4arieBG2s48/dGoRJbBK9WOqa5uFWV37pWj6AUvEtGzSUPqxLKQgxXEomCdKxbMyKBpumjSluM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 17:50:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 17:50:31 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-7-ankur.a.arora@oracle.com>
 <20241010065338.sw4zZlbm@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de
Subject: Re: [PATCH 6/7] osnoise: handle quiescent states for PREEMPT_RCU=n,
 PREEMPTION=y
In-reply-to: <20241010065338.sw4zZlbm@linutronix.de>
Date: Thu, 10 Oct 2024 10:50:29 -0700
Message-ID: <87plo797a2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:302:1::40) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 136bef3c-229e-4b46-aa37-08dce9540884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ehq/Hs1GOwrZTzeTXPnpARjAQw95pC7Srgz45mRjDHz27XHIBT1TQE6Nu7YZ?=
 =?us-ascii?Q?dBzNYnc+x8He0EFr38SxzZG/sY+0YYmjiVVwW3HoRGYRQzsT2jkArckipkqj?=
 =?us-ascii?Q?GgvY9PS4guTDmMJstuoQOSKjAa/i13uORhzxP+PlkctkWIUtFI/dMS/BcfOf?=
 =?us-ascii?Q?tKs9LedIOQYRGv5I7RHRqN8Hy9Xo8tSnsOUeRCWTFe5yh8Dp3fJHnysri1oq?=
 =?us-ascii?Q?qM8JROxFtRpgJHUzZMbNzTWj9Tpvv2LlN3VGlQJC8DG7rUgJU7dah7dRwWFs?=
 =?us-ascii?Q?Nvu2O3/rp3gAQ8lswX/nORBTHqJpTK+XT4wZ7wR8zJ1lczjnXpnXVB7kUHVB?=
 =?us-ascii?Q?nEZmXIPsBpzJuYxXaKWNqknGoZNJlFM0dJtB7YUYcNslRnCBLIH2+GmUtNef?=
 =?us-ascii?Q?rauYFr362wn+skij0LgmSIHbVHSjYIHXDFQd0ZT3pfy8yQHs+PURaB6fuGBI?=
 =?us-ascii?Q?pru0f7Jk1asVtTRTDGmu3VHzYloJHCyKG2LSPFqF0aY+MbX2pOUlEw1Zrhlx?=
 =?us-ascii?Q?vvSLl5K1lGpmjvBNsFHEJq5lOebZz43EjY4TasaEC3q0/HXKRbRZmY3Xx/yo?=
 =?us-ascii?Q?GF/LZSGQwoZMT8UZMHtKdvf4UpyehuH6/i9267DVGgldyPPPY6NLB/rXtxTK?=
 =?us-ascii?Q?ckfkjo7TCgxc8/b5zC6s+tMBFV3jHwXnsUUVVyNr0UipbjfP2Y3Sb9ZicFTD?=
 =?us-ascii?Q?ty0rXhEd+iJQkFPO8enSBRY7ubnir4M76zmF6+MePELUw6AReHm+ar1/amdl?=
 =?us-ascii?Q?GS37oHO6Ym4RLptP1IGAjPVGG6K5t05ec/7FJ2IwWJdihEJrkx2Xr8wEoJJW?=
 =?us-ascii?Q?3WL6QmVW+kA1GyjYRWMiQvafxAZVHtFh72iT0mvom56nfvb3MxhB59LDebNn?=
 =?us-ascii?Q?z5+tBAk7jVePTJ4BTmVZtJXOE+ZSW5TLq9ja5IaAZrd5Dr0mySMQmLi0uqFZ?=
 =?us-ascii?Q?FbKP6eV4Lg09zcJkf9QzT7jJkDm9iC+AzmVkZtq9phrNoD5LLt8ekRn3WUe8?=
 =?us-ascii?Q?tgQN5IlGb8K2Re9Xy5Lgsh1ar4mk5U9yL+DAbLT9rLzNRSfYo83DWv/rY0K/?=
 =?us-ascii?Q?ifxM/RaO3LmtnzH7ZObU5CWf2grJ4E0Wk3UnOxubRzkMKOvBkfjjFS9FQfeo?=
 =?us-ascii?Q?Wu4DW1CYKHp4cyj7XI1z/X6lKxaABsSjo4Q+TPegsnY32zprUTl5LjNfpGAH?=
 =?us-ascii?Q?nM2pEotZuQHAIOnoRoiUulTcI4X2fEc43n/qlrqLQzeHT6IADdTvNLkShOtG?=
 =?us-ascii?Q?2MYgWR/UQoKixxxfQYx5B/cr83mJdYqbudjYejAl+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYUeTUtFGAd1u8Y6N3fsFts1AulnjJOZdg/WWy8uO5krPXEwA5d5t17o43WY?=
 =?us-ascii?Q?RDMGI0p3UzSHoo2X4qbuvwFZO+6nQT5A08BBgHMpZNIuDIv/IUdNP+QIJu8Y?=
 =?us-ascii?Q?NQIlpcRg8f6NS3S/ZspRjmnz0aHOeIugfsp6VWl+74F3QLhx9/1Oemb+0GyM?=
 =?us-ascii?Q?9emSHc/ZEpbluIq2UUhA/0oCrsuSU8EjDouVhHD8iiKG4DPRGrNO0ERCe7Hw?=
 =?us-ascii?Q?xMGCMBUsKBhrdPdajl2dcMlEDGznICwStncIt8EajWhW1h0D91/lNN0qjQeb?=
 =?us-ascii?Q?KVNO2/KQ5li/oaGUVO5e9syBDSy/XB83+lZHdwOdvwXjS30kDX7BGYmLuThD?=
 =?us-ascii?Q?TvZHolwa+xP7ObMHS0iwF6rBgklD3H9Iw2TvJ5A172j96FNTWhjIhhsCN2L7?=
 =?us-ascii?Q?mtT+t8Y8aJl+avroYQAEptcC5gh18qL2aqilmtvUT1gY+9OULcababJE7FYZ?=
 =?us-ascii?Q?Nlh96sG5CYK2uOOPWzqfnEm2scADxMbRAbQ7wowDMGb6mFQthZzMZwmkRrF3?=
 =?us-ascii?Q?1b3sFfnX1/7/CACE3R17u6gDxTJ6Zc1B1ZsVS5L80q+ScgeWvAF0nECjRWaG?=
 =?us-ascii?Q?TjxESXWPmOHOsfB+EhxDmtQ1CRRsisQnXCxFgS3vSXxL+xUVgj13Ac9HU25d?=
 =?us-ascii?Q?WVQeGRQl67xO4bhrw7JuHIZXEFxWF1D1SaHwZZUbP0+AJrkLjDuZmIxbnJzV?=
 =?us-ascii?Q?E+TfPqqnJCAoItEwHl+DwJz8tte0hCDGMIvd2iF8JkQY+2dCwU35peb2zs5Q?=
 =?us-ascii?Q?zH75hzIQbkwaQY2qtANTLieC3+0BhPhYEsJXKGkYXPDQoVB3+7i0D11taPFU?=
 =?us-ascii?Q?2VrK0DzkrNXNePAYmhgMXbH8QUk4Nw5E7dfH3O1rU1MXNXl0Wj1jmfN6JI4X?=
 =?us-ascii?Q?VqAFix52XKb8UQCAlpvxbmKKuNf+bN36OjnTPSNvxQYWBHdEJ1g2UvTnIFgq?=
 =?us-ascii?Q?LgnzKWG/6wMR/qrGHESjpqAA/gW7IRKll3uOnI5Z5IqoPoY/14JRleoxgbny?=
 =?us-ascii?Q?6VNA7edRmtaEduoc8zbNZ4b9p/UGx9cw/1cbR08UAO6/RLRmjazXa+WBtC3Y?=
 =?us-ascii?Q?zxb4pcwJfQXqvt4VGbsd5yzFJY0ersrQjoqMyNLYdMJW04lR3f5IlwKAZ0g8?=
 =?us-ascii?Q?kPFQ+ywZQhgMxnxpLlzIkHoBhvb6xmMdYq+gXaBrONaCFA6/bNk0UvsOwn3S?=
 =?us-ascii?Q?T7v+8k9OZCHdfMJgjxZ9WixRFBbxnLiSIOOP2OLKu/WtssLrpMYCYdVSi+zP?=
 =?us-ascii?Q?Gi70FPu2ITYdCbcUt1N+vKhPe6ZF3jdmRa9M1xoIqgIhOhp+wgQhWmu7Vlnh?=
 =?us-ascii?Q?k0RUu4G1LENq9XIBoGDlFdfFXVMWM5ViXsMqWADD8QFlLhaLrUm9Ru/jo7yv?=
 =?us-ascii?Q?R8BivSta4bT7khsIQ3Q4Nw4I5Ge6iU9C1/++SDVZUdisVQ490WZuzGDu0l1i?=
 =?us-ascii?Q?FcxNiQxDgXBVqYUI1zGMJBQDUiPg4zCbelLp5Q1LN2a6kZ2l01/UnIC4Fbgo?=
 =?us-ascii?Q?8Zsnu+coC1/ArjakZYzz5k6SEZbOoXoSzwFMsfEcrj7vWBy2xBbtdUARl9vq?=
 =?us-ascii?Q?OCEbbTCbIzgsA0r90FjWhXIdNWuJDJFaqpUikFrp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S9jMeyP2QTpognXkJmbXOYw3nbWXmxq3AH+vrw1uadliUzD3BJ3Na3Kz0jBjvuNMw1FWjUCHbDDyhcYG1Ox2xuatgvZw8TnfvrQoA7aXudQlkB+UNqvfM3KarnMMpkZ7ro4wPYxoVxBllvz2IPKL8cjkrDUfzDSxu7pQ0k/GKCgFKBvvqgKN/Ysyrjfv2N53yyGmrqLAfVtp3K5bmWa5eXdLdIIoUdTuGicnD5FnwDNDo7Bkaomrn4WFQZGiNxOU5NhHfguvDCeWrjufTaZUvOffePFDDU/szVNae8gAszQFrA2J0bWzVuEld5XwXpTMj08TszI0Cg0cDkXTBb4Ui6Jl6XAWw7r+D3TtLcaqV/5aMZj8TBdpFEdl1isix4NUObXv8TCpeZQOSKBGD3vE8f/LjhxYlXn/4EyPr/YPlg9reo1phfiJYFBWZVzP2qzTlF0S+M+OhAg+vjLTsVyugkjH4LpnJaVf/C2+IYvCTIxHt/R5IWqLbx0V2v1QcEze/1lSqsaCOxKxr4QkIaj6R/DD9SuYN6C1JJZvjTEBtBFs5i8Ov98/CF3UN0y2RiXtiH3Po+xvR2bH18UgZMki9Zp2TF7tpOhJkbofc19bxDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136bef3c-229e-4b46-aa37-08dce9540884
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:50:31.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrVz3zFc9MvoN9I+HTfpkiYZKxSTYFaS7ztftu/skrLxTdT/wS1UV0i6I2XKDDI2CdCH3dvFqpXomwTXCENnQOKMcgg0XqCA2JxWbM0OW30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_12,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=687 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100117
X-Proofpoint-ORIG-GUID: Lq0HrOWSiLcUggTqFj0kxY_CAASssVg8
X-Proofpoint-GUID: Lq0HrOWSiLcUggTqFj0kxY_CAASssVg8


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-09 09:54:10 [-0700], Ankur Arora wrote:
>> To reduce RCU noise for nohz_full configurations, osnoise depends
>> on cond_resched() providing quiescent states for PREEMPT_RCU=n
>> configurations. And, for PREEMPT_RCU=y configurations does this
>> by directly calling rcu_momentary_eqs().
>>
>> With PREEMPT_LAZY=y, however, we can have configurations with
>> (PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
>> can help.
>
> PREEMPTION=y, PREEMPT_RCU=n should not be possible.

That's a statement. Is there an argument here?

--
ankur

