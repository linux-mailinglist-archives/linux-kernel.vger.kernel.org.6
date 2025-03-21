Return-Path: <linux-kernel+bounces-571046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D91A6B873
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB624461ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCD21F153E;
	Fri, 21 Mar 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PUO87+JS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bimhq4+C"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0F41C72
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551499; cv=fail; b=olVHE/yjETdxEZnlpDykJL1trLpsLyr4/kw13zUgc3IBgpXSck+HMyPhThetXhQQXvm73wwvCLiF+TCoLuHOGzkHuiMF1oSuA3ShA5mQQcXJppQs1QYHpZ/RCHC2/BSjSyzhPwXi9BZ3zc0SEnw7s34Ye8xhZPxuim1/9VkxCCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551499; c=relaxed/simple;
	bh=Iw1/W36ACOQ9WRZAGoiDxXATWt689Cd9btPHgJ3T3Qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DY5uuWdFinYxocl7w1rhTxM4BQ1C3/XoeWlbYS1rmCrFDhFYTGuvWEcB93mJvfZQ1b+/gxflIxkcySrwEJJ90pbdKMnDlytRTK4XOY9lhYVvixpsuwJ2k1gAVTwmgszPzZ2/yCyX7WdcdgdEEclND9dUug9C72cqt3aArpEDbTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PUO87+JS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bimhq4+C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4ubkq029543;
	Fri, 21 Mar 2025 10:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lARHe/mdVJaD2/V/UYyKIScvqsJRY9IjQdzPoLRotNg=; b=
	PUO87+JSJHOC72K81vY78ZANw/6DO5oaLmcGpIevpSFalUT4WEETXNdVnHmOReLW
	7X3/nDXnBhBaUfPR1kAiNeeUF+nt+QbcX+ls6ny+nwbVj8LuBf/3thB8WqMbdFXo
	3/RVRhl4N30YaPMn5KOpetXVm48hBh2kHFG3hTa6I5MoUVG5ANRkBGqKrb+AjMJj
	POhqHX6tG4DHtAltAHOKu4msaoTIlA+wA4ipG70aNHtwCwVw//F5/tRALKwwOB0L
	SCNNua5k2dEdBtqmMOb6P5U0MqUgSLIgwCXksqvEfIhxf+zy97vrEp/LFt7fWMOb
	kVICnAsXNscfSJi6i4VOig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s8b3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 10:04:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52L9hENr018667;
	Fri, 21 Mar 2025 10:04:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdq8y9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 10:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stPmwkhhj/Pt/vhBVUARTugKEx/EmfZgJusvykRzUNBY8aJIeOBQGWvjLpYxtvWNm5JLaZWmt1Kk4PuKTaFHTrTULu+LsqjuxWvE3D3vT5ysBO3+f2bOExgSRin1hQXheScxrtSiDwIYdvDbrrGWzuqde6hRGeA2Xa+Kk5b9i/AmKpGIdMHRoz+5Cfjt61lkWYxs1UpLIyNyMyu6Vx5HifabnCDLQS3TX3/vqp6diqtnXTfSwEa15kg6Fv9QJ9tPbZGGB5sKcW0yPBdEKxJJQpu75bHCMijUnu3jy37NpXv/ksp3SnBP5xuZq6MSjqSz299K3dzghH86Mep2gMBDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lARHe/mdVJaD2/V/UYyKIScvqsJRY9IjQdzPoLRotNg=;
 b=l2ptdx3qRBYD2xuxuVHLEmVUdIFtzKEKuCuLb1JamH3XDUcerke1PcXnIE/N/LzbAeqn9I5Bx9rkfnWd9MTeySVCKz0K/UeCW8ZEaM7zWm71DHPk97NtdkymGQV1nF4MSARvJLR69hzW7jdNEb/BwZDYZrvSiwyV2w+if2oypcoAhm385taE/Y8TovSG4BdsvK4EzMr/pOGwD0aRo8DpCCRUfCfa3ft4l16iS+m5c1W+vH0Xk68U5Ky1WmT4NFLIqLUx1FJtpRR7M6B8BTJi7TJe7ievWd7UI0lB8RzItjmH2CTlhOHrctbelfkEJ3+K5LaHqLOJzouDBhWHgIxpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lARHe/mdVJaD2/V/UYyKIScvqsJRY9IjQdzPoLRotNg=;
 b=Bimhq4+CdO43FWs6KCsyoQao43EoOr6Q7E1Nd+poP2L4tbj1Zxd4l8Vl0gAVMnqalqDGaFZBLYsde1rvmHFbtLhJNyBh2BHsunhACb98br+YLenC0uKKev9/RGrxMJM6jV7ObldUU5/a5vRtpyb1thjKeOomWbT+fU90AOUdRzI=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by DS7PR10MB4912.namprd10.prod.outlook.com (2603:10b6:5:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 10:04:34 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 10:04:34 +0000
Message-ID: <9af4bb66-83c4-4257-bfc3-dbcb2185a7e6@oracle.com>
Date: Fri, 21 Mar 2025 03:04:31 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [RFC PATCH 0/8] sched/fair: Propagate load balancing stats up the
 sched domain hierarchy
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        David Vernet <void@manifault.com>,
        "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250313093746.6760-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0163.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::24) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|DS7PR10MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf9f59d-6f51-467d-1150-08dd685fc7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHNsTERZc3laakZOR3FsZHNQZDlXR0xiYXJ1azM5cklGWitweHIvVmpEbzJh?=
 =?utf-8?B?cTR6ZEFaNEFJbDZTdzBWd0d0N2dLOURJaWdjUnpzNVJxNVNTeitHU0N2cXUw?=
 =?utf-8?B?TWVTVVBwT0NaL1hPdVhDNm9aR3JJRThaMmJBeXo2Q3c5Q1hFWUlrUG1wQkli?=
 =?utf-8?B?ZE4wQS93dWltMzZGN1VHQnBEekJ2ZDVXTTNyQ0lOU1JGK0prWlpIaUtxU282?=
 =?utf-8?B?dXdwbE1IK3gvYkI3enVreGRRT2dORG85eHBZTkVkdk0vWlZEdFRWb21Pd3hx?=
 =?utf-8?B?YVdRS1VOaGJMNjdvbExRVlV4VW1lMHlvQzJUdi85a3BMVllUZHE5R1ZBTW1X?=
 =?utf-8?B?MWZHUjU3WmRkUURiWVdwMk9VZVFtczZ3UUUwcFc0dXlGWGIxeUdWV0RFY2RI?=
 =?utf-8?B?enM1RzhUc2xUVnYrWlZNTS9BMVVROFVUZnNIU2R5NDVoVFRaSlJsZTI1MVBp?=
 =?utf-8?B?cEU1MXlKeW9kZXhlbmNFRWI3UUZ0UGRkNFJKRG5DMy83bjhqQ0JCaHhLc2J0?=
 =?utf-8?B?MlpSU0h4Sk5VUEY5ekpsTTRoRzc5Q0JtbEQvNVZkbGRVZlJLTHRvN3hydnMv?=
 =?utf-8?B?L1JEN2dTaWNHdmIreW1NQ29oNU5IekZuc3RGUHQ5eldMVm83Sjhxa1BlSVhj?=
 =?utf-8?B?Zm5BbngyeE44aXV1RVRrUk5jcXRudTdtQ2NwcThQemNRRHpvNnZVVnhNRDR4?=
 =?utf-8?B?Y0duUFMwY0JlbVlFZ01GRThRTDhBQ21ETDBRcjZtOEJndWVwcVQ5UnMwUld2?=
 =?utf-8?B?WVZwbXhacGpySkNGb2hUaldVbzQvRmVhSG05dWxQaEt2TCtkRXdpdDhSMGVm?=
 =?utf-8?B?WGd0YUNJOHo0ZjEvNHNkM0xZenM5WHRmb1YzZmlrZWoxcUZJUlkwbE82cnUx?=
 =?utf-8?B?YU83TWdRaTUvclFXd2tPQ0dKalNmWEZha1k3QkRDbVUzcDc1TXpZUkJ3emtZ?=
 =?utf-8?B?dFo2cWcvRlEzcmlXWDIrMW9wYkVoTmgzOUxKaFhDeVdNMnJwd1poWjMzclQ1?=
 =?utf-8?B?eUgrZVhZaG5rYWxRQzNIWnFIazBlRUdrOVpoRjRKdEdYdE4xYVRITlRlVTF1?=
 =?utf-8?B?Uy9tUjZoSXFCU2YyOS9GYWhYbmdyOWVvbndYY1pjc2tTdy9qL1l3aytvcnVJ?=
 =?utf-8?B?bUNkd2YySHNTMXZwRk5VUlBpWlI3QU4rbk9DeG9mYk1FNUl3THQ4V0tZZENU?=
 =?utf-8?B?NllnWVhwdHpmaDVFeWNTeHllaWZxbVhBYVF6Q052U2FucU41cVNBR1M0eG9p?=
 =?utf-8?B?dlFzcFFRWG1xTFVlc1ptYVl2SXVkNnhyckJQRU94cFpRVCtydXFucUN1cHdE?=
 =?utf-8?B?SkRnN0U5WXJrZ1dKQ1lleHg1Rkh0V0thWVlMejBqK04xODBtcURpSTloYWQ3?=
 =?utf-8?B?TUcwNjQzclNMUTVhbUlMYjBxQ2NmaUFubmlnMXJzTjZ3R2IzWm5ncDBDYlV3?=
 =?utf-8?B?SlRqS0MrMmhXdnRRdkxoSG9aaG1nY2NGNENac2gweWFjd08zU2hKMkFsUjJB?=
 =?utf-8?B?SXVpUnlnUWxDUS8zMER3cE5ZTHRLNDJSMnRLRGpuR25iLzhyamwvdWpIT0pZ?=
 =?utf-8?B?R0VPQlBFNzBnYis1dVBwOFFYQmUzYTBFTWw4ZDM1MEhJejVhYlpEcEFOek0z?=
 =?utf-8?B?QWJFVFdRRkFDNGY0UHg3SWNTVlM0L3RpdExMTGlrM1VwQk5BK1p0UHVBcGo2?=
 =?utf-8?B?d01zRElkdldsYVhackEyWjEvemxVK1hoalppMkM3WmpWaElaZEozQWxRekNU?=
 =?utf-8?B?MzM1VnUvSzBIdk1EbndpSDlnbXJJMW9PSlg5RnE3aWkwVzErcmVwQmNYNWwv?=
 =?utf-8?B?MndLU0NMbmhkNlZUK1V0WVY4cG0ydDhXblFaOHUxZWZvR1p2ZGE1OGQ5dFFv?=
 =?utf-8?Q?zBjr5GfSLdKhC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGhLcGgwSm1MSk1SM08yb2ZxWXRHSTAwaS9ZcGxia3ZxV3pDWlhlRXJxS01q?=
 =?utf-8?B?dGJlVTlEa05LcDA5QnlrZVVzaW9jQTVtbXY3SzFlRXR0N0RBQnlSU3FRamta?=
 =?utf-8?B?STBWK0pFdkZyWTNyb1Vjc2VEZm5QOHpLLzQ1cGg4STJUamV3b2JwS2ljOEdT?=
 =?utf-8?B?SlN1aDdJRG0vRUJMb285NGlHWXJLNHY0R01TUGFPR251MTB5OGpkRyswWUEw?=
 =?utf-8?B?RUplL3UrWjBCbkwwY00xT2F3dGxvWEdsd2tSODVkc2Rwc2cvakozNUlJS3Nt?=
 =?utf-8?B?SkI3MU5QK0RMOHFiMU8vNWVjbDNQQno0NG9iSVVaQjc0WEN1eUFZQnFPVlJR?=
 =?utf-8?B?WFdIQTlKUHNpdHA0UVhhWTVDeVB1NGNld2pybDdPVkpRNmFEL1dZa2hBOExj?=
 =?utf-8?B?K1ZaeDZvV3FndkxjN0xqMStRQjI0bXAyUnFvTXNEUGM2eFBWbmZYbTB6ZXV2?=
 =?utf-8?B?amFFZk9XME9TNW5qMXhIY0MzNGo3YURhY0RxdVFiSDh2cUt4WGRidHVhMC93?=
 =?utf-8?B?bk8xR05Id3NueTV6YWFTNm9SanJpT29kRDNpbVF6WXBwak82dWMrakRRcUFP?=
 =?utf-8?B?Z2crL1hsRkswQ0RnWHVwd0lBbWRQbFhRZnl5VzFSMjdGK0hpL2VZdncxUHl3?=
 =?utf-8?B?dGVwbjRuWnVib0ZmcE9Jb2U0Y0hBMTVwTXd6R0hRU0NXS1dleFkzZjdud1dM?=
 =?utf-8?B?bVBvK1dES0QvamRlb09rUmdrQlZaa3c0TkgxNVBRYW1IZTMycnFQMU5tRlQz?=
 =?utf-8?B?NC8vODJyNmpSeG9JUGVMUEovZkxtRU9CZ2dQU08vMmFxQ1FPVE93Yk4xZkJE?=
 =?utf-8?B?dVZURWJ0UVlJa28ydDI5dm9EaHIya2pTNk43RXQ5a0w1TzNkS2RtOGVKZDN3?=
 =?utf-8?B?TC85UVFHVklGS2FsZml1U2llbURhWUJsQ2QxbjNHeTZwb0lhcHUxWk9Ec0U2?=
 =?utf-8?B?dlAyR1JFYXRMVnA5aWZublRLK3BLekM3UmMyNU1YRVRZY2xZWTB1NS80YlNa?=
 =?utf-8?B?Q3pKQlMwN0dHSU8xR2pHOUEybWtFMnB6NHhDaHJMNE5OTXF3R0dReHVpOVR2?=
 =?utf-8?B?L1crZjJQSGNMQm5jcHo4aktjOWxOOU11VmFZaTZtMjBMMWRDWkoxR0ZsMERI?=
 =?utf-8?B?SVdoMHdvOUpWSnpNQUQ3ZjJicEJKR0VxTkdWZE1ZNExaOFpUSm5EdWZKRStH?=
 =?utf-8?B?OE1RTU5xbnBTK3dOeUs0OHlpRy8xdExLMXhiOC9lUzhSV2JUSWdTaGgySE5p?=
 =?utf-8?B?aEczOEFBZmduVndBODVnTWVxQ2VzRGFBa2M0YWlpL1BtaEV6WnFTdHNvMSt0?=
 =?utf-8?B?dFByajRaREppdWhoVkw3V1hEdm9GSU9SS2lWNVA3Q1V0WnhwUlhNQW8rUTZj?=
 =?utf-8?B?MHltTXgvTnplcm40SmFkczRidXlUaUQ0aWZtK3gzMTVaS29tOTdlbUZpVDB0?=
 =?utf-8?B?ZjVBL2xHbnl1YVk5VEQ4WCsyWm5QeDNJY2pWNFNJeTFWQjlxZzNpb1RnUzdG?=
 =?utf-8?B?dEc5QnRyS3p5c2V2NThiZVJ0UWVxWTBKUitMMzYvejZKUFkzQnlpOGJacEs2?=
 =?utf-8?B?R3ZGdjRQcUdaN1RmSy9vUnVydkhzNHhRMTBOdUJFV1NsYzcxaDg0bHdBQXdG?=
 =?utf-8?B?SHZFNlRPQXRpNG5aYXNBVG8yTlRKaTZQVkN2dmRTTE1FcU5qYTl0d2V6Z2RG?=
 =?utf-8?B?a0dPSlo1eTUwcFh3V0VMRU1RN25kdW1nQ1ZFZmptRXVwSkxZWWs1alVaVmxO?=
 =?utf-8?B?UlQvbmNYbktTSW9YQ3JueTRTQlNudm52czE5ZWxaZUh2c0x4Y1VqTUxvOURV?=
 =?utf-8?B?ZitNczFHUE9xT3lpejdGKzk1c0hjVllFNW1qbjRqcTlWOS9OMDlESFJwYnlY?=
 =?utf-8?B?dGVEckhvdUwyMEwzYkpmNTdqZUNoSWxZcDZMbjBOSGVwME04MUhObzZSZUtt?=
 =?utf-8?B?UkhJU2NrMzlhZ2lSb2tGWWZFbkJ5YS96ODZJM3pCRGxwZ2JBS0NzQk1QMjU5?=
 =?utf-8?B?TitZRU5VSW1BMVVHazUwOHZvNFpPanJ6Z0RJcU41YW9QVzdTOWs5TVZsc0ti?=
 =?utf-8?B?S0cwem5udG11YlV5NGVxN2FjbStHa1R3ZlBXM05aODJEVytVY2RMZlBpT3RQ?=
 =?utf-8?Q?tImLix1sz9XwRpY6Sw5TZgPXP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I6Hh5zdQYKPpfVVJACthtc4Ly0mJDQrqgP23p6WpOes44tkyccTHHrJeN5Zsk29f+JqkHATVln38u9gXhrK/JPRTDbqpWQR9qs+RcbM/tyGsGM8HF4Po5AAxKLjNmOeTSJyvoBjTrXBlBYTpBAf8/B6OB0W06y30dqcmNhtlAOFMQ8I7HMqgSJfH4eVD8oZqfKPcyUbWJgyc/W+nhPkwlxk9cNBCTAr9XgcDhhVPonAI2n+e9EA4iKishfpaDPYxkrw8eP8QEfQ1/kfofj/yviev7L2YWfJh/FIicc4s3ohzZY5wv/6IszhvsJyBhFlSQj7AtalPVNf3VYWZ4ZPDPTy5eKDywBEILeW+kcTgkkCQE3uTbzoMiZnl1g0rsQ/ULJ4PEhg24JibgLcVYst+97ujDi+OtXBUStbWhxuUBMU1CunkAAVR6T3yuo+c/EPy6B9s1Xo1tzHS5rLUXt6uPlnSPiY0uu10Gj7R5DOJU0D/5HRUTqvjjXyhfsdyhZZdD7EPB/x8VIOeJrjc8Tk49/0tfcoHq4+NQ3FWE6Npcx1twsDzIinZVxducZSdO0RpNLzwIKgLmAImwbtxBKsof4KkAAdZQ/bWDtTJ0r1m6F8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf9f59d-6f51-467d-1150-08dd685fc7bb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:04:34.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I58Tek/DLMqI/AuxDu51THI4cvSHrKcYgfJ6udZCem28+jvMs3hr2bblBpvVM8grKQNGx0PmwdqXHJeDAuHTrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210074
X-Proofpoint-GUID: Cb7m_Jr8jC85g-0dQmXRiUK_l7lJBjka
X-Proofpoint-ORIG-GUID: Cb7m_Jr8jC85g-0dQmXRiUK_l7lJBjka



On 3/13/25 02:37, K Prateek Nayak wrote:

> Benchmark results
> =================
> 

Hi Prateek,

Definitely like the idea, esp. if we can pull this off on newidle lb
which tends to be more problematic on systems with a large number
of cores. But the data below on periodic lb isn't I guess as good as
I expect. So I am wondering if the cost of update_[sd|sg]_lb_stats() 
actually went down as the result of the caching?

Thanks,
Libo
>   ==================================================================
>   Test          : hackbench
>   Units         : Normalized time in seconds
>   Interpretation: Lower is better
>   Statistic     : AMean
>   ==================================================================
>   Case:           tip[pct imp](CV)      stats_prop[pct imp](CV)
>    1-groups     1.00 [ -0.00](10.12)     1.09 [ -9.11](11.93)
>    2-groups     1.00 [ -0.00]( 6.92)     1.00 [ -0.22]( 4.57)
>    4-groups     1.00 [ -0.00]( 3.14)     0.99 [  0.83]( 1.77)
>    8-groups     1.00 [ -0.00]( 1.35)     1.00 [ -0.31]( 2.24)
>   16-groups     1.00 [ -0.00]( 1.32)     0.99 [  0.84]( 0.67)
> 
> 
>   ==================================================================
>   Test          : tbench
>   Units         : Normalized throughput
>   Interpretation: Higher is better
>   Statistic     : AMean
>   ==================================================================
>   Clients:    tip[pct imp](CV)      stats_prop[pct imp](CV)
>       1     1.00 [  0.00]( 0.43)     0.99 [ -0.87]( 1.34)
>       2     1.00 [  0.00]( 0.58)     1.02 [  2.14]( 0.29)
>       4     1.00 [  0.00]( 0.54)     1.01 [  1.24]( 0.82)
>       8     1.00 [  0.00]( 0.49)     1.01 [  0.62]( 0.97)
>      16     1.00 [  0.00]( 1.06)     1.01 [  0.94]( 0.70)
>      32     1.00 [  0.00]( 1.27)     0.99 [ -1.24]( 1.38)
>      64     1.00 [  0.00]( 1.54)     1.00 [ -0.43]( 0.36)
>     128     1.00 [  0.00]( 0.38)     1.00 [ -0.01]( 1.22)
>     256     1.00 [  0.00]( 1.85)     1.02 [  1.58]( 0.90)
>     512     1.00 [  0.00]( 0.31)     1.01 [  0.76]( 1.19)
>    1024     1.00 [  0.00]( 0.19)     1.00 [  0.44]( 0.35)
> 
> 
>   ==================================================================
>   Test          : stream-10
>   Units         : Normalized Bandwidth, MB/s
>   Interpretation: Higher is better
>   Statistic     : HMean
>   ==================================================================
>   Test:       tip[pct imp](CV)      stats_prop[pct imp](CV)
>    Copy     1.00 [  0.00](11.31)     1.02 [  1.69]( 6.44)
>   Scale     1.00 [  0.00]( 6.62)     1.01 [  0.80]( 5.37)
>     Add     1.00 [  0.00]( 7.06)     1.02 [  1.54]( 6.72)
>   Triad     1.00 [  0.00]( 8.91)     1.01 [  1.36]( 6.73)
> 
> 
>   ==================================================================
>   Test          : stream-100
>   Units         : Normalized Bandwidth, MB/s
>   Interpretation: Higher is better
>   Statistic     : HMean
>   ==================================================================
>   Test:       tip[pct imp](CV)      stats_prop[pct imp](CV)
>    Copy     1.00 [  0.00]( 2.01)     0.98 [ -1.55]( 2.15)
>   Scale     1.00 [  0.00]( 1.49)     1.00 [  0.23]( 0.58)
>     Add     1.00 [  0.00]( 2.67)     1.01 [  0.65]( 1.95)
>   Triad     1.00 [  0.00]( 2.19)     1.01 [  0.61]( 1.37)
> 
> 
>   ==================================================================
>   Test          : netperf
>   Units         : Normalized Througput
>   Interpretation: Higher is better
>   Statistic     : AMean
>   ==================================================================
>      Clients:       tip[pct imp](CV)      stats_prop[pct imp](CV)
>     1-clients     1.00 [  0.00]( 1.43)     1.00 [  0.17]( 0.32)
>     2-clients     1.00 [  0.00]( 1.02)     1.01 [  1.00]( 0.44)
>     4-clients     1.00 [  0.00]( 0.83)     1.01 [  0.62]( 0.36)
>     8-clients     1.00 [  0.00]( 0.73)     1.00 [ -0.11]( 0.65)
>    16-clients     1.00 [  0.00]( 0.97)     1.00 [  0.49]( 0.77)
>    32-clients     1.00 [  0.00]( 0.88)     1.00 [  0.30]( 0.94)
>    64-clients     1.00 [  0.00]( 1.49)     1.00 [  0.36]( 1.57)
>   128-clients     1.00 [  0.00]( 1.05)     1.00 [  0.14]( 1.46)
>   256-clients     1.00 [  0.00]( 3.85)     1.00 [ -0.04]( 4.85)
>   512-clients     1.00 [  0.00](59.63)     1.00 [ -0.02](62.28)
> 
> 
>   ==================================================================
>   Test          : schbench
>   Units         : Normalized 99th percentile latency in us
>   Interpretation: Lower is better
>   Statistic     : Median
>   ==================================================================
>   #workers:     tip[pct imp](CV)      stats_prop[pct imp](CV)
>     1         1.00 [ -0.00]( 6.67)     0.76 [ 24.44](35.80)
>     2         1.00 [ -0.00](10.18)     0.87 [ 13.04](10.38)
>     4         1.00 [ -0.00]( 4.49)     1.04 [ -4.26]( 3.14)
>     8         1.00 [ -0.00]( 6.68)     0.98 [  1.89]( 8.07)
>    16         1.00 [ -0.00]( 1.87)     1.03 [ -3.28]( 5.21)
>    32         1.00 [ -0.00]( 4.01)     0.98 [  2.20]( 1.31)
>    64         1.00 [ -0.00]( 3.21)     1.00 [ -0.00]( 3.23)
>   128         1.00 [ -0.00](44.13)     1.06 [ -6.43](113.66)
>   256         1.00 [ -0.00](14.46)     1.04 [ -3.52]( 8.43)
>   512         1.00 [ -0.00]( 1.95)     1.02 [ -1.80]( 1.14)
> 
> 
>   ==================================================================
>   Test          : new-schbench-requests-per-second
>   Units         : Normalized Requests per second
>   Interpretation: Higher is better
>   Statistic     : Median
>   ==================================================================
>   #workers:      tip[pct imp](CV)      stats_prop[pct imp](CV)
>     1          1.00 [  0.00]( 0.46)     1.00 [  0.00]( 0.55)
>     2          1.00 [  0.00]( 0.15)     0.99 [ -0.88]( 0.26)
>     4          1.00 [  0.00]( 0.15)     0.99 [ -0.59]( 0.15)
>     8          1.00 [  0.00]( 0.15)     0.99 [ -0.88]( 0.26)
>    16          1.00 [  0.00]( 0.00)     1.00 [ -0.29]( 0.15)
>    32          1.00 [  0.00]( 3.40)     1.07 [  6.59]( 0.16)
>    64          1.00 [  0.00]( 7.09)     1.00 [ -0.38]( 0.96)
>   128          1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.20)
>   256          1.00 [  0.00]( 1.12)     1.00 [ -0.30]( 1.50)
>   512          1.00 [  0.00]( 0.22)     1.05 [  4.86]( 0.71)
> 
> 
>   ==================================================================
>   Test          : new-schbench-wakeup-latency
>   Units         : Normalized 99th percentile latency in us
>   Interpretation: Lower is better
>   Statistic     : Median
>   ==================================================================
>   #workers:     tip[pct imp](CV)      stats_prop[pct imp](CV)
>     1         1.00 [ -0.00](19.72)     0.85 [ 15.38](16.75)
>     2         1.00 [ -0.00](15.96)     1.00 [ -0.00]( 0.00)
>     4         1.00 [ -0.00]( 3.87)     1.00 [ -0.00]( 4.08)
>     8         1.00 [ -0.00]( 8.15)     1.00 [ -0.00](11.71)
>    16         1.00 [ -0.00]( 3.87)     0.92 [  7.69]( 4.19)
>    32         1.00 [ -0.00](12.99)     0.73 [ 26.67]( 0.00)
>    64         1.00 [ -0.00]( 6.20)     1.12 [-12.50]( 9.94)
>   128         1.00 [ -0.00]( 0.96)     0.98 [  1.55]( 0.95)
>   256         1.00 [ -0.00]( 2.76)     0.99 [  1.45]( 1.38)
>   512         1.00 [ -0.00]( 0.20)     1.20 [-20.42]( 0.00)
> 
> 
>   ==================================================================
>   Test          : new-schbench-request-latency
>   Units         : Normalized 99th percentile latency in us
>   Interpretation: Lower is better
>   Statistic     : Median
>   ==================================================================
>   #workers:     tip[pct imp](CV)      stats_prop[pct imp](CV)
>     1         1.00 [ -0.00]( 1.07)     1.02 [ -2.08]( 0.13)
>     2         1.00 [ -0.00]( 0.14)     1.04 [ -3.97]( 0.13)
>     4         1.00 [ -0.00]( 1.39)     1.03 [ -3.15]( 0.13)
>     8         1.00 [ -0.00]( 0.36)     1.03 [ -3.16]( 0.00)
>    16         1.00 [ -0.00]( 1.18)     1.02 [ -1.59]( 0.75)
>    32         1.00 [ -0.00]( 8.42)     0.81 [ 19.08]( 0.25)
>    64         1.00 [ -0.00]( 4.85)     1.01 [ -1.10]( 2.58)
>   128         1.00 [ -0.00]( 0.28)     1.00 [ -0.21]( 0.38)
>   256         1.00 [ -0.00](10.52)     0.95 [  4.74]( 6.94)
>   512         1.00 [ -0.00]( 0.69)     1.09 [ -8.99]( 0.27)
> 
> 
>   ==================================================================
>   Test          : Various longer running benchmarks
>   Units         : %diff in throughput reported
>   Interpretation: Higher is better
>   Statistic     : Median
>   ==================================================================
>   Benchmarks:                 %diff
> 
>   ycsb-cassandra             -0.54%
>   ycsb-mongodb                0.09%
> 
>   deathstarbench-1x          -0.30%
>   deathstarbench-2x           2.38%
>   deathstarbench-3x           0.58%
>   deathstarbench-6x           0.62%
> 
>   hammerdb+mysql 16VU         0.76%
>   hammerdb+mysql 64VU         0.74%
> ---
> 



