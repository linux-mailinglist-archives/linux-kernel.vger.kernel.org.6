Return-Path: <linux-kernel+bounces-445538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978439F1784
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB0B168D46
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504A191F92;
	Fri, 13 Dec 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RWibQ1es";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bamtHKy3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E232175AB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122695; cv=fail; b=qimtt4tlBzG6XqyCF7Jtkzoy2eRfa9Y9ukB9AsrWQSkggAu5moiHXoV8Z6P9H8RcK4/NM8rjsvIQxj/OcOWCvBQEn+C15popmJkXeA5I8T/BtRopZedE0aSJKgkzKoeoAAFHqAhAYAKypuetyFRPeK4ztg/9JQKOsOeRK/Wmt+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122695; c=relaxed/simple;
	bh=SDb4uEi8DyJey6+aqHXXdA7zLFIUnvSMypeptwQesQM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ZtZS+o1GwO1KXeHQZWIkp4U+q7InlnXDRLiOnQ1ec3+e05N23lhqOozZH/85ou1opzbGWrAJlW2EJ80QUq4M4E2CeYh/0pdFruPrvGrbK5axFcZK3snGD0NEMk5J/Mplvx5nx/UulDym5G6p6aI4/XBVBPLgNU4YDsHWUZ110+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RWibQ1es; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bamtHKy3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKBnBm015406;
	Fri, 13 Dec 2024 20:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SDb4uEi8DyJey6+aqHXXdA7zLFIUnvSMypeptwQesQM=; b=
	RWibQ1esWKuFIaUvOCjjjmMJfRZFI1Qace+KzGfatwlpe87HzRLyV9im2M7V5rTu
	CMuonBUqQkWXCr9N1+m6QGtne1YPTTNGX2DWnai4Uv/dYScowXt1MQvgd56nrXTJ
	GjU8F3OCxRc+36kXeddFoLOUVy4xCKnSJUbL77hKmMwxYuGSv3kXVNWEuXywJK8q
	lQN413CZ/s9pMgT6tHqOjOjy3tGJnqLD9mfcme7TfcRANYr8Eh5InoJuFC6qH3OT
	OIIv43SmjT9ykwGQZaAXhH+u6gVvovLwdbbtXnE5ZgKuFQqMSkztj6vUkDrA15/D
	ltRkmp0Eg/yyD+8dqg39nw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedceak6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 20:44:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDJFY2o035611;
	Fri, 13 Dec 2024 20:44:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctd6k2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 20:44:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLwIERDMO7LIfP7Y8ECt1RstK9Br5DBlUlIPeURIcQQASNIz4xPHGb5m0fk9otTJ3i7hebBPpSKHMvJeeqGKsVky1WXE+LV8btMsAcjBY/M5jhvAzUPw/Qsqm/uppVXbpvGccMT3InMn/E87z1dXZfSGOcCT1JqpQn2CriWbkqUXZ5vQaU8sy390w0vxlkUkYMeA6MPEe6VZ6e7Hx8LH47v7eLtg4FAGmkISLC4rsxwMpK4N0Vvg5ZApgJA9qY7uubuw0rW4jSC5SfqkP1LGf/621SaNRXdLmcjo6zmmybtoJ3q7Ywsy3ho+ifckPXlk0fuMKodN3I3wb7Ol+F5NQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDb4uEi8DyJey6+aqHXXdA7zLFIUnvSMypeptwQesQM=;
 b=PAca7GijJEffJZN6qBUFrzITGddQh35qAPyCGxzHqo8sJvrIOOetBbR3zlg3nPxpAPbUkyP9NY45PqoIHz+1UbwzI4zRQrh/I7i0eVNWa9DRc1zTFZBGRpWoF6NFSgwIhSQ5F9WqvCjYcRyILyx2FgUKYXCNOO1K+Tw1X9K+wDGKPutjrXTS/Eg1SUeHoODNVjxKUOSYHB1KgLqKaqsFpPk1vON8GpORaRb1JmaDhtkLu8F9gexXM+XTh8gDM9NYNE0KtyHeqnIYrV3SO2exvIaqxLwsaYkESIix/CLIoI6ikwCYu+QdpK6cXmJIEs34Mha5qgCOrEUuq/5pX7ToPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDb4uEi8DyJey6+aqHXXdA7zLFIUnvSMypeptwQesQM=;
 b=bamtHKy3sk1bu28fN1xhoZsKDo++YsQiXLz+U1PAOgjLtr+9hyUkQuhpvoCuuapCkRwpOFhelnP3lnILXjC1T3dxi1Ei9vbzV0xXxCGuaQw1mqiJB5uipZ0BuWmLapNsuUAlo7in0jlWJVxC9n7rLFIvdw9Kqa0n3/H7b7dj+CI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 20:44:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 20:44:24 +0000
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
 <20241213040658.2282640-6-ankur.a.arora@oracle.com>
 <Z1w9ydTN90Sl8qda@localhost.localdomain>
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
Subject: Re: [PATCH v3 5/7] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-reply-to: <Z1w9ydTN90Sl8qda@localhost.localdomain>
Date: Fri, 13 Dec 2024 12:44:22 -0800
Message-ID: <874j379uu1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW2PR2101CA0028.namprd21.prod.outlook.com
 (2603:10b6:302:1::41) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cb1c23-76bd-4556-d2c6-08dd1bb6edb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlNXWCtFLzBQZlp3QUo0enllTVJUYUxWOGkwdURpdUpNdEdSaE5RQWh5RG0r?=
 =?utf-8?B?UkYwdzZweDdISHREaFdycC9CbDBEWU91ZFQwOTlUQ2dleUtGTGZvbjRDTFE2?=
 =?utf-8?B?bk1lbEZQZWhjMjNDZGxXZS9VNHQvc1dqTytsZjZYU2xnWGlJU25jSVlrNFY0?=
 =?utf-8?B?TkVCN092V0NPMzlaZWY1Ky9IMG9LUHNvcTl0amo2eXRlM3FkcHBLNStMYjFJ?=
 =?utf-8?B?cEU3QlhLY0d0UnpoS000cG5ndll3ZFNCT2M5ZUpxRSsvQ2pCWll1L1lDekll?=
 =?utf-8?B?Snpkb2lLdXdUZ0pmVUxOcGRDZ2lVeUN2eUZ1bFQ0VCtoVEozR3hyKzRDc0dk?=
 =?utf-8?B?dDRXbEEwakV1UE9GZXlpODZNZW9CbHdjQWE5a0Q3TWV2WDE4RGF5YXVPYjZZ?=
 =?utf-8?B?L2lGak41TUdtTWNmemtZNCs4bVRWdWg0eVNiZ21qSGxzWXowRDFLWTFaZUFT?=
 =?utf-8?B?bEVuU0ZkVXJyY0VUckFrUjUrRzZ2eU1vdmUza29JeVNmTlU0MDJIc1h5eUQ1?=
 =?utf-8?B?WmNTZEUxdkMzdXV1dmNybE9QRDRDT2VzQ1hobjBIalhRSS9ubTM0VGxXUndJ?=
 =?utf-8?B?UUxEZVdzQ2IvRjhjN1E0bk1QTGFZV0hlTzdxUjRZeC8zTmtoLzN6eW1SR1hZ?=
 =?utf-8?B?S09UdW4rVjJUUzdmZWY3WVYwSDVtU3AzL2tBMms1T2I2QXZqV1hnVi9QQ003?=
 =?utf-8?B?QlB2dVJmU3NoWWFLdzJha2hibGg0VVk1WFd5aGg1aS9KblBZUERDSStHVTZz?=
 =?utf-8?B?ZThzZWZXT09mcWpvQlBJaUlqT0FWQkJFYThyMDhHOXFkb2JGQnIycktrVG9F?=
 =?utf-8?B?aFVHM1pmcnpGNnlNNWxhYXZzd1liczVWdHU0L0lCQktSclcxcGVwZzFKMHVW?=
 =?utf-8?B?dzBZVzB2ZFoyZzdwVXNsVXdEWWtMaHNTSHpEWldWdmhqdW5qWVFscng2ZldO?=
 =?utf-8?B?YnNmN0VNN3k0amVQSUdpNkhoU1NjQmd2UFh0WVE3Zno0cjRoNTBVUng0MXdE?=
 =?utf-8?B?a3N6V29xMmdFZmcrdUZ5a2hwUWhhQzJiYkxEczF6RTRuZjZ1d3FpYm12dXgy?=
 =?utf-8?B?bmRoazVnUjJ5a1ZsNURvdnNZdEdTUENYd3M0eEt0cHpCT0FOSDFFdTBrU3Fl?=
 =?utf-8?B?SFV4cGVRQWY3VWpWMmozTnlCbE5qeW56THFXM29tQU5iNHpwNGxuQlpqNDZQ?=
 =?utf-8?B?RWtCTG43bUROMXNhQXlFZC8xQlRObGd1VG1sK0tZSHBvaXpudHRhckxucU02?=
 =?utf-8?B?TktmWjdZOEhtT3dsb1ExaHlkV05lNVF1ZVhzZEJqcXoyR0ZxQnBGdEVVcWNF?=
 =?utf-8?B?bFF0QjVXYWMyNWJXTmIyZ1ZGRkFRMHByUUxzUFJ3NzdNNUR1dE9qUTRJQmpw?=
 =?utf-8?B?dFhZU3pUODBEQmJuUE9QYlkxd3pwdHhVTUNqcm5Hck01bTZNQjFYelEzQ3BK?=
 =?utf-8?B?L3UvOHdnT0E4S1NFamFpUHByRE9MQzdxNXo0UHFuVW5TQUszazFQY0daVm9S?=
 =?utf-8?B?cCt1UjJUOFBLK1Y1UXZRK0VGYkJHZ3BHNHRuQXI0Z01EY2xxWGNDSWUwbWVW?=
 =?utf-8?B?UkQrdzFJQjNtVUZRQ25xSnlPRkcyYXRwajlrOVBncVN1L3U5M2htTU1iaS9q?=
 =?utf-8?B?Qm5scFBqNTd1NnB3VWFsYzJqL1A1R3RuWURNeStyVmxhR0hlREd2ZHhiL2Jo?=
 =?utf-8?B?MEpLY0N3R0dwSldVdWMySERWbXorRTVPS3pvTkd6ZHZ6UDZIUVFaM1o0dmx3?=
 =?utf-8?B?UEREaFU1ZzRkdTMva2V0ZlpkRUkvMndtek1kQi8vODZ3eHk3SG5HUmc4T2s0?=
 =?utf-8?B?WklKR2k0VjZMTFR3dzFkQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2I1cW8vYVN4VFc1NnBQUEtqZVhUUDZ3VkR2TVkzZVVzcmZTbmtKQ000QlNp?=
 =?utf-8?B?Mjg5aHRtN2xaVndGZU9IZmtwWTBROVFZY1hsd1FYb1FMWExnRnFFYnE2ZnNG?=
 =?utf-8?B?ZjJHMlZIa3l3d2tLVEx3YjZiYmF2WVQ0UDlpbWcrWmN6VUpnZWEza3dubmFp?=
 =?utf-8?B?ZGU1MXI5M2dCUlpaR2RDcnB1UmI3WmZtSCttb21KdUZEZUhtRml3YWphR2Zy?=
 =?utf-8?B?a3FWOHRmYUJrRFc0V3ZqZFVGbDRkWmt2UFVReHY4UklJK1J2VXVrM0F1QXdU?=
 =?utf-8?B?K2t3QlVOc0ZWSWhzSUxrRWF5cTNOOUUvMW5CZUlpZStSb1NSK2VyditZTTFS?=
 =?utf-8?B?RHhucHZQN1dOenVSV1RONUkxUU1EaE9ianZhRGJMaThIVko5bHVmZjZuckZE?=
 =?utf-8?B?ZkNqZUpoaGN6MGttemliSXpjWTJqd1E1cTZOZkViTlk4dnlpM3dKTzlwcWdC?=
 =?utf-8?B?U282RTFGdHpZb3FlbkloV3BHUUZvbnF1WXI5MDhaSDZyZXVjNXBHQ2gyM1F3?=
 =?utf-8?B?akRzR3NYYnBpTmV1NVdMUXZHM0wyUVFxR203OHd5WEE4dWg2QW5YbkM1dDRi?=
 =?utf-8?B?dDBtTURzM1pJbmFlcUxrMlJwbnhmTjE4R3FTQ2NWSThLUVp4ZzZRUFF5T2to?=
 =?utf-8?B?VDZUbUtGbGh6aGxyVXdvLzZRTk80bXJtNWdobWpHYVc3ZnJtZDNEdmU5RXo4?=
 =?utf-8?B?VU5ZdnhxRkpzZkhuNklFVkN2ZnJPQkhWNnlrdGJNMjREM1ZaZTV5MjdmaFdz?=
 =?utf-8?B?WDE3UGFad3JUeFZwVndtTU1PN1hUMFFBdlVESU00ZXE1ME05N3Z6cFVnYk43?=
 =?utf-8?B?aGwveFUvL0RuWmJ6eUpDQndlcUptZ21kOGtGT1FIb2I5TjBHUjVNeTRMTjN6?=
 =?utf-8?B?UnFScWRQL1JaT0RualYwcDB6SlduRkszaVRtTkxOQy96UG9mYWJHWFBWNm05?=
 =?utf-8?B?NW9xTS81ZWxHZ0VDT3RJenVpelp1SXlpdjU3V1NLN05hK3Nyc1ZMbHdHNWhU?=
 =?utf-8?B?ZmZ4U1R4RXhUTDZsNVd1WjROV0M5ekhINHUwL2ZFU0tPVGQrSG45YmIveUlm?=
 =?utf-8?B?S0JFUHJqL2lBRitaK28zbjAzdm4vYkVJR3lRY1h0TnBIOElabEk4dmtSWVNF?=
 =?utf-8?B?dHN3ZEJlTUpiT0dTb3VGNGdwbXlWTW90SmVNdU9vL25RbzFPbjhoRFdRZk1i?=
 =?utf-8?B?Qi9FdmdDNVBrL3lyVzY2eVcvdFkxMVZuU1B3bVNoNVE0QWsxc1RTQ0xVWHR5?=
 =?utf-8?B?TUpXSGJ1b2d2Q2lKRWI5YVEyRkE2NjdIbjU4TnM5aGg2cnRrUXJrQ1hpSHJJ?=
 =?utf-8?B?MHFzYnpVZkV4QWVpWU4rSkFXSHFzQkRxaUMzRytLR0pWVURUeWoyOTRCK2pJ?=
 =?utf-8?B?NDV0d2Z2YzcyR3M4YjVBdCtoQnUwUGxsblVWWGhLcDF2Rkp2bEpmRDFwd3Iy?=
 =?utf-8?B?YlhGTjZzMUFDMzkrQ2RqTzFERWxqNS9IbkQ4K1VKaE56U0pELzNJSC9Lektu?=
 =?utf-8?B?eUZOaSsyZm1tbzAzdFRFOTlob1dFVE9ya1lMNWdJY0FwR3NnY240cTUxemJZ?=
 =?utf-8?B?Um5RcGJTNzJCTGRMdFBTYi9OVHp6MUZkUlJoVlhNVFliNXcvSllENGF6enVy?=
 =?utf-8?B?ZjI4MTNSSjRaOTllay9iTzNxaGs4cStjcnpjZlNxL3c4aHVweVFqcXN2V0Uv?=
 =?utf-8?B?NjlKWFNSMkVNbTZxUVdmQ1hPV0V4Ym1iWmRXV1NWODhyWG9vemV5T3pFVTlk?=
 =?utf-8?B?THc2L0ZJb2tZVXRhTkVpNmRpbmplM3ExanU4SXkwU2lJQko0V1Yxa2srNGJB?=
 =?utf-8?B?dzQ3REdKb0U4U1JCTkR4QWREU05DVFNYWWJEWWp1cjdrR1NnQU13dmdna1ow?=
 =?utf-8?B?Q2JPMlFMdjk2TTdmdnAwNkhoWWM0WHRRdEdyQjh3RG9xd1BISWwzMUhEdUpk?=
 =?utf-8?B?OWRvM3RvK2N4VGZidUticDl1SzNWUzJGUHU3VGVhRmxCaFNiWU5FZDkyMU9F?=
 =?utf-8?B?VzY2SFVYaHMzMktWbDJkR3kwZ01GVVF1WlI4NStLSW05MEZZcnBuMXpDcVVS?=
 =?utf-8?B?dXNQQlpKa0tuQWpLazg3VEpxN2IrcWNzbU0xWktKYzhCQlB1a24wV1FaU1R5?=
 =?utf-8?B?cEJPS2x1RzBpSS80ZkU5WFAxUGxqbFhIb1pabFR0NUh6dzJ1emhVQmdMN2lP?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QMOqiGDFcqXlhx2njt0LNt+jP2Kd+c4JfxWQNiGR3FdeHx9rtaQYpE6y2FJQdhBvXolvZxj4Z9CmVWRNYEvyXvmRP8Jz0f6JxldyEuweSdPbsiplRir7I6EePheEVjJwKW9yuJreRMKwG0L4QfrRRCs+FfJ8zyBZw+h+pvkXs7uuoG8ysBCBw2npWdgiphm08ZwEe4U8wCZpGoOF2lifAa3ZGF+OA+YyOBxTqhqPYlgi9bqkT6HZ5V6zEcvalorbQQ0SdhWUluhgiVSeS0ZkckXufA8i+vj5tkDBXFzflzjbCrCvv5dpYvjHpZ82z2wwp1Af+jQ1sXamVlO5MHUwWtEgc++Aj3bbV1pyslbmSmRUxH+UkX7R770cfWTkGtlwGG8m7sfgZxavKhj26tK7LSnyaoYSrf7ULYRhvxYX1pIIV/qrNj98RNYKGnSnCZRspAOdKtoEzSrEbCnfu7YHF4ts8eNPe4t7OTIK/4pP9n5m7G8pPgnMDkJA848aNfmn8ugMX+D7bnhJG7VKWhvKzUumUejWuIgPgLn6Dz0JfL30Uw6BtydZA/MGtFd6hKr9a9jB/Tk3DNhulLWKQOha7ErkZe9o93dQtjPFppAHyDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cb1c23-76bd-4556-d2c6-08dd1bb6edb6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:44:24.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC17Gr0UelXUGGaC+2dP2CfxILUBZt3CgcyFJlAqYcr1Oodro7MgsSfPHrDood17A/s3tloO1F2ZpJFUXBaA19YdxFf/asqGPoK76dwWAJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130147
X-Proofpoint-ORIG-GUID: eieN-BVttCHSDLMQJKa86rQWukB8bJtL
X-Proofpoint-GUID: eieN-BVttCHSDLMQJKa86rQWukB8bJtL


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Thu, Dec 12, 2024 at 08:06:56PM -0800, Ankur Arora a =C3=A9crit :
>> With PREEMPT_RCU=3Dn, cond_resched() provides urgently needed quiescent
>> states for read-side critical sections via rcu_all_qs().
>> One reason why this was needed: lacking preempt-count, the tick
>> handler has no way of knowing whether it is executing in a
>> read-side critical section or not.
>>
>> With (PREEMPT_LAZY=3Dy, PREEMPT_DYNAMIC=3Dn), we get (PREEMPT_COUNT=3Dy,
>> PREEMPT_RCU=3Dn). In this configuration cond_resched() is a stub and
>> does not provide quiescent states via rcu_all_qs().
>> (PREEMPT_RCU=3Dy provides this information via rcu_read_unlock() and
>> its nesting counter.)
>>
>> So, use the availability of preempt_count() to report quiescent states
>> in rcu_flavor_sched_clock_irq().
>>
>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks for all the reviews!

--
ankur

