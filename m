Return-Path: <linux-kernel+bounces-204558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5098FF074
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439B21C26225
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D330199380;
	Thu,  6 Jun 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f4irWy5T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vH/VbSwM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CC199255
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686737; cv=fail; b=IfLZ3bKKEE7UBKz7cOCa75UVcA6z5VLOORAw5qXYRn1cFcZAa536dY6YvlflmwiroX2hTcwvUDIx9FxowD8sP/4muhwezkc1k9fb0wkD5vF+f1rc+biUNVysyPQ598fJmAHjmEJ23RXzKgKiG3N2olDG632rO/TWqOAvqj1ZwZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686737; c=relaxed/simple;
	bh=7/spBkYLu7MSNgYjIXQYy1ZpJi3v+ZDE5GGA1/Sv2N8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Vigcmx3MrMnbf1dgRGB2bH4JvX0PthezL0r6+cedsflXWhwMEmUPe6gYbnexu3vL/x+agSiGBp4vcBBizOMsqZx3p6N00jGCMgKYTXKsMURm7SCPK7ZFIMArO3OQH7ZTLGUJvLsiEKg/uPeqdumgXC4FiAaHesnv1fawTCdpYKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f4irWy5T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vH/VbSwM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568ioed020246;
	Thu, 6 Jun 2024 15:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-type :
 date : from : in-reply-to : message-id : mime-version : references :
 subject : to; s=corp-2023-11-20;
 bh=mOaFOlpBYV4bZqituuCMxQzZS3qZtfifw6g3ISpHBp4=;
 b=f4irWy5T6zjPnCr1fLu9v8yy3N42Hy0r6sB3gdwHctJJqxmOq24cr0w9Ewl+at6J7Xbl
 hoBPikz6rHXWFNPX1NsP53IUPDU1QhRRW5umhYiL3BtogoY8VMlf29+o9rrIrigIssPJ
 bIbgiQVpoCNQi74A8YzUa3vyBo42QTYN/2No5yrgEmwcW3edknLeGQVTPxOMXqLSq9jZ
 RNM2kcNBfcB2zqf5u6U7k7VFHJOtkL9pQLPfmHNcPAVribxWSXB0b0MFUn/+lR0wnFdD
 V1bHI+MTorp6CJsK1RJ/k7RBLxOKyuds1LWofhsfVIRWdKilxQWb74AuHL5VyL79WvLe ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsybrnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 15:11:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456F265n024059;
	Thu, 6 Jun 2024 15:11:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr0ykjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 15:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNoti6I3Sp3pGOT4uZvUBlPjg109Zxsfya+5tzAgVptWHsGb5g2X8GxLgXsHELqI9eEIzwZFx6pMsGk+V+/Qwbc/9WoWCTWPV1DoO5Kyj154ZTjLG1MAPZrWWk5HXW21Hto9AI9iVpkws6tiOpXv/eDhaEXY/8+JU7woUiwTF9k2EdtgRqZDSZKnYY3axofHqabb6QMnewOjpnCbnqz6WZCBkkMddU+N1uNMNC9SO6Xr83ibHYJ4lU7sZRXWlBMDho0RnChO9tssn+rmNZTGHEPdIBgVjRX/oVXt0armA/Z97C3g0a7yJYUOha1zl92U31MoOndeViqFglnQCWIwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOaFOlpBYV4bZqituuCMxQzZS3qZtfifw6g3ISpHBp4=;
 b=FgZWRRwoS3BQXTH20zy3ErW9lAEPynxcmvbkeqMORFhufHK5TvDwzZEOp7rCjCyNMLuRmpc/iAwdBen5kEsTjV2KpPTz2GEZ0pEOMtZ9Pql/z3Nv+djEVA1q5jZz/xNwusnaCFX17jqJyLBHfD1I3682DXyd8BJnwTMWkHi4j0V5kEdjGSBdeIrM6kfTHISyXI+NM3hoeIWxL6/rbe22xylJL0tWOubEGyjWYfw3TymHwVoGOobqAZl5bbamlzZKrO9N5SnJobCseCWnr2gWvsQPiJoKLVpwl+PcwLOJFsViAQlJCrBhA3203oA05EHnFXFt38OEDtS+jc/PJLdkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOaFOlpBYV4bZqituuCMxQzZS3qZtfifw6g3ISpHBp4=;
 b=vH/VbSwMtIZIYxvkaoexQverErQFXSh5OJ1L4WBOr+Wv2gYyyWS0X+bMvfbGxhRvMIlUmhfVoKmV2kkfyreh3zSJJoOOkH4Pp28eSNYPaMme+fLS1QnhljV3n8bk98oxOSJTTwK+qyGigPIHJgnr/g4xmrn71hgUnHgH7wrwT+o=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8149.namprd10.prod.outlook.com (2603:10b6:8:1ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 15:11:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 15:11:43 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-14-ankur.a.arora@oracle.com>
 <20240528162725.GH26599@noisy.programming.kicks-ass.net>
 <87ttif641i.fsf@oracle.com>
 <20240606115101.GC8774@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, paulmck@kernel.org,
        rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
        joel@joelfernandes.org, raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ingo Molnar
 <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 13/35] sched: allow runtime config for PREEMPT_AUTO
In-reply-to: <20240606115101.GC8774@noisy.programming.kicks-ass.net>
Date: Thu, 06 Jun 2024 08:11:41 -0700
Message-ID: <87ikymw1g2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 0639f9b4-4331-4320-ed64-08dc863af978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4aFwwcrUDHYJEVVZCSfqskR28XoLlprprebkJptAaM6tEL8Dh3nriiNmWDyL?=
 =?us-ascii?Q?vBJY93ijDVnrgLnrwSD46q/t8Nf5Kt5H4G4DolynMCRhuscRCL1GYM4KlabQ?=
 =?us-ascii?Q?GZaVnGAgGagM1LCcZXh0mr46prg1sr5/M9UR4Zi/tDU4lyg/sWXpWQSpDsaS?=
 =?us-ascii?Q?wSe6GAyBYUTHEDVy/4dBoQPhfGSDIVbylYlgsdXYZ37uWt+BnoMaA4TRhV+Z?=
 =?us-ascii?Q?N+DoJwmVg6DDe+ePYgfM2+GYPid3jfRGrmM6HaAkfr/D0r0GllMlJJqTcn9M?=
 =?us-ascii?Q?LbnSx8klGhpUxBIEBui5ibw/oNFgxuTImKwrPKqrU4w/vZ12KosCz6Xq7sNW?=
 =?us-ascii?Q?SiD4BTAoea//9SrL7hSajZ8XjgJcQ9j+Xbz3/FSluGkTUPd1ZcJE4rRjZrOj?=
 =?us-ascii?Q?iSohAHjffEsbJ7mFDrnc4rcMPMtQ8lHfBzDAGMKt7mvIGm02EGixXTgEY3W+?=
 =?us-ascii?Q?nasO3ozmqejSlbbdONnNHkyRFboEbLSDCe490gktcGdngEh5Heiu1PPAT+O5?=
 =?us-ascii?Q?xggjkBVnx0BG+6YC/pqXXtJegwyu4FvRXs/NOOOUMChRBTudxX/ZM/pGhkHo?=
 =?us-ascii?Q?+HKLQULs1aW4WI7cIBkhVC03iAQpqJY133hVoG6bpXI6suBT+f47yxSI7yvG?=
 =?us-ascii?Q?4J198zjW20Tw0S7fFinPJawQ0whfMWcSGldM9/kVkbEg2QbDaDPIoKFDu5jf?=
 =?us-ascii?Q?qmBNpqo+OZGDsV8iD1nvSR9X1Pf3dddzKl+oGRovhlxC3Sg4QKhx54yEOGmw?=
 =?us-ascii?Q?PtrvNxA230h/5G1HtR2fTq7twRobWm6r1wJ68vAzDh3wcp62GXY+HWIT66DJ?=
 =?us-ascii?Q?w98BibUXqbENU9Qm5DLrrLH3uC69W3UrVueAPPGdCzM3B0jekYPCyF91BCEJ?=
 =?us-ascii?Q?9ZFNY8kl83k97nZCuejWG8jalMexqhVCOHMQoFuUDuFAUOVNJo4uY5VRCyDo?=
 =?us-ascii?Q?crloU3mU/iSv1xVPtDhR+YXQLAUheHFd5l4hVxC2q+Np/he8JX+l8OIkpwZR?=
 =?us-ascii?Q?9rjcx0VDiz7wmtojTMdK2asVskmXvyntkDW2bmXsxeb2J58l5daGeAn3QdTW?=
 =?us-ascii?Q?/u5pC+Nz+f4G+rhbuWRoB4goeHShRVuPnmGKvpXCN4tIHXDaryCSIQogZyQJ?=
 =?us-ascii?Q?dOtmyVteBFRlqx3rVG3szY483PIf3Ih+yl6+OOrqKszt9B7iEigEHaTOJ86+?=
 =?us-ascii?Q?X6nfGRBbKgJdacHfEOvAyhlhdL9ZNf/n2C7hsGeG6g6rrdvHS7FT0Pio3xDR?=
 =?us-ascii?Q?8z/fyzFWER3AdLfgND7+x8WT44RS9l3UAhFHTykYS+a0q+gIkWQ7smM5+/yB?=
 =?us-ascii?Q?5V576MFsq3s1leb8ECPt+s9r?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZBZKFCgoziSStoB2w8LqMyvs1zf56ERkHZmcd4ivkOx2BtyDMjeENHHu56eX?=
 =?us-ascii?Q?5ygdDg1RQk790trwZJOSJU1Z5HlAodtd/8GlhVRJdOpSVUsSq+0WV7/saieV?=
 =?us-ascii?Q?HQO9ghu/UHGHwMRq6KqA0ZHV0zYX0sBJ45Mvn4QXCJ443dNwGfr3Ttc5m+Yz?=
 =?us-ascii?Q?4t1BLlZF+/nglU8uBFMjKuIYL1iW7dSf8ZYWb2bsuw2EgfdJGpS4rOLQSDiO?=
 =?us-ascii?Q?zuaTlUQC8wLc4uLnocysoOjUU//r5bXWtHl/xHAcioTseQpwzWtGytEga8Ts?=
 =?us-ascii?Q?aE9Fcsm29EuQGgnBd4UTWegMibXfbQaPloAjp0UZjxpP3dD8DXJm7SUsFehc?=
 =?us-ascii?Q?1PcByXoNdwwYChCkFSk0FPdJYto2GOR76nsJx4iN+BodosIF6JClUlUOKDnC?=
 =?us-ascii?Q?FP4L2PUkK+dmRFgkGAbHuIuhaf28uc61Xonz8Itr+ehOFPjKnG3Uw0QXfGCC?=
 =?us-ascii?Q?pxcHw1ANTl1E/f1Y7Z9hPiQiLaMLhztQfzNAfEYqTWzlWpK9YHblgCf81FjK?=
 =?us-ascii?Q?a/ZEUKirNHirPZisPTwPqqXiZdLtrIiPInFUsl7L2Jk6V1KFiZonDRHfLwqX?=
 =?us-ascii?Q?EEk/NHM0u+iPo8UDf2MSUIcecl1zfYF+BtHHSDB+EpcYllhs7aaZRLQyXEId?=
 =?us-ascii?Q?ExljtUJktbbYCOBWneVnO2U3Nzup0n1pMSeQHS0UEBiw8Og/pm0Dfy8Kdndb?=
 =?us-ascii?Q?Sp7HfIkT4IE618DWmx48Ej9k0qzLWfje3PvmJqx+hWFSgZj5WcIHDJ6NQaPH?=
 =?us-ascii?Q?7YohKKc19HyrHmsdIyyJv8yE2joA+vMuMgBL6Ex8KzNu/RQ3iFfnPl5nsPHO?=
 =?us-ascii?Q?XjNef5NXv4Kndn+8vn/cdcYWZ0iHoZ1jrJ8lmkljGH3CWIIGtrUUic8cdrYH?=
 =?us-ascii?Q?Ft1vTh9lj0uuUpoQPs1Fm+enakuMdGQ8lcJmJeB/MrWiVHzaKSQYj+4WreRW?=
 =?us-ascii?Q?X8DU9+dKKEJGlB/G8kR4qMNBJ3aEPZIRhzeYN2DGnJ7ff3v4zvGMGrw+4K1w?=
 =?us-ascii?Q?6AXR37ycA9sMOYw6JxIL0UR0SGTgA+datKbXW7vxBBMXXCDcpnDWklRk/eg+?=
 =?us-ascii?Q?ohpsd6Tj5bh1kfAdAZ78L+Nab5/HjfNPjEUBPx2OHA+EyKJ6+hlkLanAV2J4?=
 =?us-ascii?Q?+D5I7zyjDi5ttmEfioOk+gyKjYd+WQeYdcXoda3ioYoiaEVBuEg8uLQwDlzs?=
 =?us-ascii?Q?HzQtNQIdtxvuOGWiOg9R3p8tdom4RVO0AuPJ0ACUQGx/b6eJ0JXDNbg67xkn?=
 =?us-ascii?Q?qwcTau3S8jouONzs6QzhWl2dsMJ9AZ5ZAfQAUsaUj1sBoWH5sIpmz5Fm2JbL?=
 =?us-ascii?Q?LNcS3x6PCHicEDjcUytgFUyqcxKR3ziIbY+mEGGW7Q4sU0m6Kf7ufmqqeQHf?=
 =?us-ascii?Q?EYEiWwF1Rn7sEdlBbWqvlMVSxyd9MopD1DToqcyAhkrKbgK2guNJhr3CHtbv?=
 =?us-ascii?Q?6AnaESCsnj2WGt7b/c6kw8uW3RJ7zkgDYs1QAaIlXm4rUT7MGWGsmvo+Wjcy?=
 =?us-ascii?Q?s4Xa92G2S+UPKzEXP3iuIVwCrVhTxnlS/YpckHR8JJlQmc3bgUzCjir2Wsf8?=
 =?us-ascii?Q?4Nk41sPSDQywuPQRVf0gXoaNS9PPrY2Eoilpt3VLVNY/sKq2ypSeCY+Pj2/C?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2bAhGRJ4P42Z3IZQvhWUYCD+Q1OioCA011vsVG7FHv2yi6xMoKQ2ksr6mbKeo63BVVyMj/H+n+ImL3kRJ4TzQDZUXxXO95rEsZdZmjKWXmyP2XWXDhHk6r13GokEOX2ujZRiclUK6T4HjKs6IoWNZxl686mXS/ReuSu1jagLn5BlXdbEjRjAbXkikTYJ/h04F7k6GNTeMBfJKh0XTwviils96kHU7EFOFq3HLSgnF+lv+sTrFugzyccxA6Ay/0J2CHK7FWeLBbi5tE6Ybl75LOG+QltGm4o/rh4BYD380DJsHcZqhHTwHmE1ncSu+PnFJNHKbDhonZsfw9BdXeyGjhKGAK7WCX3D1xTSBO0vTgK3UE8VB+HijAHtz8c6d1RK26K0Bl6CEUR6R+UdJI9PI5tMQ+MCk2Tv47uF99vmNG6jl7W93ZAHswSP8t7Td5jWRzSm2SicZvm5r/9aaU0HxqiDIgg5uHJ2juvOhdWVLaWznqTGH+zt0TTn61ivDvaKBgduWEKCn0mCCc2So7ZDri/HYKtc75jxZzZnOIQjGEJ9+QdYVjP84Q3lPVodl0s/TBRaGSM5ouwwuK2RGhpvUZ7aqWTU0g0ONkSQNstYWWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0639f9b4-4331-4320-ed64-08dc863af978
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:11:43.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F10tU/AIL5g900eWE3a1DEuRUyvp5Lld6g8GjHIPuVmEeYRKRu3rbLIHmQgmQIrV4h9AtifhDJnM6gCbfiDip5T3TrBUtSWfXmXaCZw0xIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060110
X-Proofpoint-GUID: a7PW7oTnJ2MKT_KqUX9UguZu3DG0UTdM
X-Proofpoint-ORIG-GUID: a7PW7oTnJ2MKT_KqUX9UguZu3DG0UTdM


Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, May 30, 2024 at 02:29:45AM -0700, Ankur Arora wrote:
>>
>> Peter Zijlstra <peterz@infradead.org> writes:
>>
>> > On Mon, May 27, 2024 at 05:34:59PM -0700, Ankur Arora wrote:
>> >> Reuse sched_dynamic_update() and related logic to enable choosing
>> >> the preemption model at boot or runtime for PREEMPT_AUTO.
>> >>
>> >> The interface is identical to PREEMPT_DYNAMIC.
>> >
>> > Colour me confused, why?!? What are you doing and why aren't just just
>> > adding AUTO to the existing DYNAMIC thing?
>>
>> You mean have a single __sched_dynamic_update()? AUTO doesn't use any
>> of the static_call/static_key stuff so I'm not sure how that would work.
>
> *sigh*... see the below, seems to work.

Sorry, didn't mean for you to have to do all that work to prove the
point.

I phrased it badly. I do understand how lazy can be folded in as
you do here:

> +	case preempt_dynamic_lazy:
> +		if (!klp_override)
> +			preempt_dynamic_disable(cond_resched);
> +		preempt_dynamic_disable(might_resched);
> +		preempt_dynamic_enable(preempt_schedule);
> +		preempt_dynamic_enable(preempt_schedule_notrace);
> +		preempt_dynamic_enable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_enable(preempt_lazy);
> +		if (mode != preempt_dynamic_mode)
> +			pr_info("Dynamic Preempt: lazy\n");
> +		break;
>  	}

But, if the long term goal (at least as I understand it) is to get rid
of cond_resched() -- to allow optimizations that needing to call cond_resched()
makes impossible -- does it make sense to pull all of these together?

Say, eventually preempt_dynamic_lazy and preempt_dynamic_full are the
only two models left. Then we will have (modulo figuring out how to
switch over klp from cond_resched() to a different unwinding technique):

static void __sched_dynamic_update(int mode)
{
        preempt_dynamic_enable(preempt_schedule);
        preempt_dynamic_enable(preempt_schedule_notrace);
        preempt_dynamic_enable(irqentry_exit_cond_resched);

        switch (mode) {
        case preempt_dynamic_full:
                preempt_dynamic_key_disable(preempt_lazy);
                if (mode != preempt_dynamic_mode)
                        pr_info("%s: full\n", PREEMPT_MODE);
                break;

	case preempt_dynamic_lazy:
		preempt_dynamic_key_enable(preempt_lazy);
		if (mode != preempt_dynamic_mode)
			pr_info("Dynamic Preempt: lazy\n");
		break;
        }

        preempt_dynamic_mode = mode;
}

Which is pretty similar to what the PREEMPT_AUTO code was doing.

Thanks
Ankur

> ---
>  arch/x86/Kconfig                   |   1 +
>  arch/x86/include/asm/thread_info.h |   6 +-
>  include/linux/entry-common.h       |   3 +-
>  include/linux/entry-kvm.h          |   5 +-
>  include/linux/sched.h              |  10 +++-
>  include/linux/thread_info.h        |  21 +++++--
>  kernel/Kconfig.preempt             |  11 ++++
>  kernel/entry/common.c              |   2 +-
>  kernel/entry/kvm.c                 |   4 +-
>  kernel/sched/core.c                | 110 ++++++++++++++++++++++++++++++++-----
>  kernel/sched/debug.c               |   2 +-
>  kernel/sched/fair.c                |   4 +-
>  kernel/sched/sched.h               |   1 +
>  13 files changed, 148 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e8837116704ce..61f86b69524d7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -91,6 +91,7 @@ config X86
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PMEM_API		if X86_64
> +	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PTE_DEVMAP		if X86_64
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_HW_PTE_YOUNG
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 12da7dfd5ef13..75bb390f7baf5 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -87,8 +87,9 @@ struct thread_info {
>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>  #define TIF_SIGPENDING		2	/* signal pending */
>  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
> -#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
> -#define TIF_SSBD		5	/* Speculative store bypass disable */
> +#define TIF_NEED_RESCHED_LAZY	4	/* rescheduling necessary */
> +#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
> +#define TIF_SSBD		6	/* Speculative store bypass disable */
>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
>  #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
> @@ -110,6 +111,7 @@ struct thread_info {
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_SSBD		(1 << TIF_SSBD)
>  #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index b0fb775a600d9..e66c8a7c113f4 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -64,7 +64,8 @@
>
>  #define EXIT_TO_USER_MODE_WORK						\
>  	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
> -	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
> +	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
> +	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
>  	 ARCH_EXIT_TO_USER_MODE_WORK)
>
>  /**
> diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
> index 6813171afccb2..16149f6625e48 100644
> --- a/include/linux/entry-kvm.h
> +++ b/include/linux/entry-kvm.h
> @@ -17,8 +17,9 @@
>  #endif
>
>  #define XFER_TO_GUEST_MODE_WORK						\
> -	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
> -	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
> +	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | _TIF_SIGPENDING | \
> +	 _TIF_NOTIFY_SIGNAL | _TIF_NOTIFY_RESUME |			\
> +	 ARCH_XFER_TO_GUEST_MODE_WORK)
>
>  struct kvm_vcpu;
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7635045b2395c..5900d84e08b3c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1968,7 +1968,8 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)
>
>  static inline void clear_tsk_need_resched(struct task_struct *tsk)
>  {
> -	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
> +	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
> +			   (atomic_long_t *)&task_thread_info(tsk)->flags);
>  }
>
>  static inline int test_tsk_need_resched(struct task_struct *tsk)
> @@ -2074,6 +2075,7 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
>  extern bool preempt_model_none(void);
>  extern bool preempt_model_voluntary(void);
>  extern bool preempt_model_full(void);
> +extern bool preempt_model_lazy(void);
>
>  #else
>
> @@ -2089,6 +2091,10 @@ static inline bool preempt_model_full(void)
>  {
>  	return IS_ENABLED(CONFIG_PREEMPT);
>  }
> +static inline bool preempt_model_lazy(void)
> +{
> +	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
> +}
>
>  #endif
>
> @@ -2107,7 +2113,7 @@ static inline bool preempt_model_rt(void)
>   */
>  static inline bool preempt_model_preemptible(void)
>  {
> -	return preempt_model_full() || preempt_model_rt();
> +	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
>  }
>
>  static __always_inline bool need_resched(void)
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 9ea0b28068f49..cf2446c9c30d4 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -59,6 +59,14 @@ enum syscall_work_bit {
>
>  #include <asm/thread_info.h>
>
> +#ifndef TIF_NEED_RESCHED_LAZY
> +#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
> +#error Inconsistent PREEMPT_LAZY
> +#endif
> +#define TIF_NEED_RESCHED_LAZY TIF_NEED_RESCHED
> +#define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
> +#endif
> +
>  #ifdef __KERNEL__
>
>  #ifndef arch_set_restart_data
> @@ -179,22 +187,27 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
>
>  #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
>
> -static __always_inline bool tif_need_resched(void)
> +static __always_inline bool tif_test_bit(int bit)
>  {
> -	return arch_test_bit(TIF_NEED_RESCHED,
> +	return arch_test_bit(bit,
>  			     (unsigned long *)(&current_thread_info()->flags));
>  }
>
>  #else
>
> -static __always_inline bool tif_need_resched(void)
> +static __always_inline bool tif_test_bit(int bit)
>  {
> -	return test_bit(TIF_NEED_RESCHED,
> +	return test_bit(bit,
>  			(unsigned long *)(&current_thread_info()->flags));
>  }
>
>  #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>
> +static __always_inline bool tif_need_resched(void)
> +{
> +	return tif_test_bit(TIF_NEED_RESCHED);
> +}
> +
>  #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
>  static inline int arch_within_stack_frames(const void * const stack,
>  					   const void * const stackend,
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index c2f1fd95a8214..1a2e3849e3e5f 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -11,6 +11,9 @@ config PREEMPT_BUILD
>  	select PREEMPTION
>  	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>
> +config ARCH_HAS_PREEMPT_LAZY
> +	bool
> +
>  choice
>  	prompt "Preemption Model"
>  	default PREEMPT_NONE
> @@ -67,6 +70,14 @@ config PREEMPT
>  	  embedded system with latency requirements in the milliseconds
>  	  range.
>
> +config PREEMPT_LAZY
> +	bool "Scheduler controlled preemption model"
> +	depends on !ARCH_NO_PREEMPT
> +	depends on ARCH_HAS_PREEMPT_LAZY
> +	select PREEMPT_BUILD
> +	help
> +	  Hamsters in your brain...
> +
>  config PREEMPT_RT
>  	bool "Fully Preemptible Kernel (Real-Time)"
>  	depends on EXPERT && ARCH_SUPPORTS_RT
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 90843cc385880..bcb23c866425e 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -98,7 +98,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>
>  		local_irq_enable_exit_to_user(ti_work);
>
> -		if (ti_work & _TIF_NEED_RESCHED)
> +		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>  			schedule();
>
>  		if (ti_work & _TIF_UPROBE)
> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
> index 2e0f75bcb7fd1..8485f63863afc 100644
> --- a/kernel/entry/kvm.c
> +++ b/kernel/entry/kvm.c
> @@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>  			return -EINTR;
>  		}
>
> -		if (ti_work & _TIF_NEED_RESCHED)
> +		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>  			schedule();
>
>  		if (ti_work & _TIF_NOTIFY_RESUME)
> @@ -24,7 +24,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>  			return ret;
>
>  		ti_work = read_thread_flags();
> -	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
> +	} while (ti_work & XFER_TO_GUEST_MODE_WORK);
>  	return 0;
>  }
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 965e6464e68e9..c32de809283cf 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -904,10 +904,9 @@ static inline void hrtick_rq_init(struct rq *rq)
>   * this avoids any races wrt polling state changes and thereby avoids
>   * spurious IPIs.
>   */
> -static inline bool set_nr_and_not_polling(struct task_struct *p)
> +static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
>  {
> -	struct thread_info *ti = task_thread_info(p);
> -	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
> +	return !(fetch_or(&ti->flags, 1 << tif) & _TIF_POLLING_NRFLAG);
>  }
>
>  /*
> @@ -932,9 +931,9 @@ static bool set_nr_if_polling(struct task_struct *p)
>  }
>
>  #else
> -static inline bool set_nr_and_not_polling(struct task_struct *p)
> +static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
>  {
> -	set_tsk_need_resched(p);
> +	atomic_long_or(1 << tif, (atomic_long_t *)&ti->flags);
>  	return true;
>  }
>
> @@ -1039,28 +1038,66 @@ void wake_up_q(struct wake_q_head *head)
>   * might also involve a cross-CPU call to trigger the scheduler on
>   * the target CPU.
>   */
> -void resched_curr(struct rq *rq)
> +static void __resched_curr(struct rq *rq, int tif)
>  {
>  	struct task_struct *curr = rq->curr;
> +	struct thread_info *cti = task_thread_info(curr);
>  	int cpu;
>
>  	lockdep_assert_rq_held(rq);
>
> -	if (test_tsk_need_resched(curr))
> +	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
> +		tif = TIF_NEED_RESCHED;
> +
> +	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
>  		return;
>
>  	cpu = cpu_of(rq);
>
>  	if (cpu == smp_processor_id()) {
> -		set_tsk_need_resched(curr);
> -		set_preempt_need_resched();
> +		set_ti_thread_flag(cti, tif);
> +		if (tif == TIF_NEED_RESCHED)
> +			set_preempt_need_resched();
>  		return;
>  	}
>
> -	if (set_nr_and_not_polling(curr))
> -		smp_send_reschedule(cpu);
> -	else
> +	if (set_nr_and_not_polling(cti, tif)) {
> +		if (tif == TIF_NEED_RESCHED)
> +			smp_send_reschedule(cpu);
> +	} else {
>  		trace_sched_wake_idle_without_ipi(cpu);
> +	}
> +}
> +
> +void resched_curr(struct rq *rq)
> +{
> +	__resched_curr(rq, TIF_NEED_RESCHED);
> +}
> +
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
> +static __always_inline bool dynamic_preempt_lazy(void)
> +{
> +	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
> +}
> +#else
> +static __always_inline bool dynamic_preempt_lazy(void)
> +{
> +	return IS_ENABLED(PREEMPT_LAZY);
> +}
> +#endif
> +
> +static __always_inline int tif_need_resched_lazy(void)
> +{
> +	if (dynamic_preempt_lazy())
> +		return TIF_NEED_RESCHED_LAZY;
> +
> +	return TIF_NEED_RESCHED;
> +}
> +
> +void resched_curr_lazy(struct rq *rq)
> +{
> +	__resched_curr(rq, tif_need_resched_lazy());
>  }
>
>  void resched_cpu(int cpu)
> @@ -1155,7 +1192,7 @@ static void wake_up_idle_cpu(int cpu)
>  	 * and testing of the above solutions didn't appear to report
>  	 * much benefits.
>  	 */
> -	if (set_nr_and_not_polling(rq->idle))
> +	if (set_nr_and_not_polling(task_thread_info(rq->idle), TIF_NEED_RESCHED))
>  		smp_send_reschedule(cpu);
>  	else
>  		trace_sched_wake_idle_without_ipi(cpu);
> @@ -5537,6 +5574,10 @@ void sched_tick(void)
>  	update_rq_clock(rq);
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>  	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> +
> +	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +		resched_curr(rq);
> +
>  	curr->sched_class->task_tick(rq, curr, 0);
>  	if (sched_feat(LATENCY_WARN))
>  		resched_latency = cpu_resched_latency(rq);
> @@ -7245,6 +7286,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>   *   preempt_schedule           <- NOP
>   *   preempt_schedule_notrace   <- NOP
>   *   irqentry_exit_cond_resched <- NOP
> + *   dynamic_preempt_lazy	<- false
>   *
>   * VOLUNTARY:
>   *   cond_resched               <- __cond_resched
> @@ -7252,6 +7294,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>   *   preempt_schedule           <- NOP
>   *   preempt_schedule_notrace   <- NOP
>   *   irqentry_exit_cond_resched <- NOP
> + *   dynamic_preempt_lazy	<- false
>   *
>   * FULL:
>   *   cond_resched               <- RET0
> @@ -7259,6 +7302,15 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>   *   preempt_schedule           <- preempt_schedule
>   *   preempt_schedule_notrace   <- preempt_schedule_notrace
>   *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> + *   dynamic_preempt_lazy	<- false
> + *
> + * LAZY:
> + *   cond_resched               <- RET0
> + *   might_resched              <- RET0
> + *   preempt_schedule           <- preempt_schedule
> + *   preempt_schedule_notrace   <- preempt_schedule_notrace
> + *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> + *   dynamic_preempt_lazy	<- true
>   */
>
>  enum {
> @@ -7266,6 +7318,7 @@ enum {
>  	preempt_dynamic_none,
>  	preempt_dynamic_voluntary,
>  	preempt_dynamic_full,
> +	preempt_dynamic_lazy,
>  };
>
>  int preempt_dynamic_mode = preempt_dynamic_undefined;
> @@ -7281,15 +7334,23 @@ int sched_dynamic_mode(const char *str)
>  	if (!strcmp(str, "full"))
>  		return preempt_dynamic_full;
>
> +#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
> +	if (!strcmp(str, "lazy"))
> +		return preempt_dynamic_lazy;
> +#endif
> +
>  	return -EINVAL;
>  }
>
> +#define preempt_dynamic_key_enable(f)	static_key_enable(&sk_dynamic_##f.key)
> +#define preempt_dynamic_key_disable(f)	static_key_disable(&sk_dynamic_##f.key)
> +
>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
>  #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
>  #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> -#define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
> -#define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
> +#define preempt_dynamic_enable(f)	preempt_dynamic_key_enable(f)
> +#define preempt_dynamic_disable(f)	preempt_dynamic_key_disable(f)
>  #else
>  #error "Unsupported PREEMPT_DYNAMIC mechanism"
>  #endif
> @@ -7309,6 +7370,7 @@ static void __sched_dynamic_update(int mode)
>  	preempt_dynamic_enable(preempt_schedule);
>  	preempt_dynamic_enable(preempt_schedule_notrace);
>  	preempt_dynamic_enable(irqentry_exit_cond_resched);
> +	preempt_dynamic_key_disable(preempt_lazy);
>
>  	switch (mode) {
>  	case preempt_dynamic_none:
> @@ -7318,6 +7380,7 @@ static void __sched_dynamic_update(int mode)
>  		preempt_dynamic_disable(preempt_schedule);
>  		preempt_dynamic_disable(preempt_schedule_notrace);
>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_disable(preempt_lazy);
>  		if (mode != preempt_dynamic_mode)
>  			pr_info("Dynamic Preempt: none\n");
>  		break;
> @@ -7329,6 +7392,7 @@ static void __sched_dynamic_update(int mode)
>  		preempt_dynamic_disable(preempt_schedule);
>  		preempt_dynamic_disable(preempt_schedule_notrace);
>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_disable(preempt_lazy);
>  		if (mode != preempt_dynamic_mode)
>  			pr_info("Dynamic Preempt: voluntary\n");
>  		break;
> @@ -7340,9 +7404,22 @@ static void __sched_dynamic_update(int mode)
>  		preempt_dynamic_enable(preempt_schedule);
>  		preempt_dynamic_enable(preempt_schedule_notrace);
>  		preempt_dynamic_enable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_disable(preempt_lazy);
>  		if (mode != preempt_dynamic_mode)
>  			pr_info("Dynamic Preempt: full\n");
>  		break;
> +
> +	case preempt_dynamic_lazy:
> +		if (!klp_override)
> +			preempt_dynamic_disable(cond_resched);
> +		preempt_dynamic_disable(might_resched);
> +		preempt_dynamic_enable(preempt_schedule);
> +		preempt_dynamic_enable(preempt_schedule_notrace);
> +		preempt_dynamic_enable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_enable(preempt_lazy);
> +		if (mode != preempt_dynamic_mode)
> +			pr_info("Dynamic Preempt: lazy\n");
> +		break;
>  	}
>
>  	preempt_dynamic_mode = mode;
> @@ -7405,6 +7482,8 @@ static void __init preempt_dynamic_init(void)
>  			sched_dynamic_update(preempt_dynamic_none);
>  		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
>  			sched_dynamic_update(preempt_dynamic_voluntary);
> +		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
> +			sched_dynamic_update(preempt_dynamic_lazy);
>  		} else {
>  			/* Default static call setting, nothing to do */
>  			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
> @@ -7425,6 +7504,7 @@ static void __init preempt_dynamic_init(void)
>  PREEMPT_MODEL_ACCESSOR(none);
>  PREEMPT_MODEL_ACCESSOR(voluntary);
>  PREEMPT_MODEL_ACCESSOR(full);
> +PREEMPT_MODEL_ACCESSOR(lazy);
>
>  #else /* !CONFIG_PREEMPT_DYNAMIC: */
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 1bc24410ae501..87309cf247c68 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -245,7 +245,7 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
>  static int sched_dynamic_show(struct seq_file *m, void *v)
>  {
>  	static const char * preempt_modes[] = {
> -		"none", "voluntary", "full"
> +		"none", "voluntary", "full", "lazy",
>  	};
>  	int i;
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5b5d50dbc79dc..71b4112cadde0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1007,7 +1007,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	 * The task has consumed its request, reschedule.
>  	 */
>  	if (cfs_rq->nr_running > 1) {
> -		resched_curr(rq_of(cfs_rq));
> +		resched_curr_lazy(rq_of(cfs_rq));
>  		clear_buddies(cfs_rq, se);
>  	}
>  }
> @@ -8615,7 +8615,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	return;
>
>  preempt:
> -	resched_curr(rq);
> +	resched_curr_lazy(rq);
>  }
>
>  static struct task_struct *pick_task_fair(struct rq *rq)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 041d8e00a1568..48a4617a5b28b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2494,6 +2494,7 @@ extern void init_sched_fair_class(void);
>  extern void reweight_task(struct task_struct *p, int prio);
>
>  extern void resched_curr(struct rq *rq);
> +extern void resched_curr_lazy(struct rq *rq);
>  extern void resched_cpu(int cpu);
>
>  extern struct rt_bandwidth def_rt_bandwidth;


--
ankur

