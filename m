Return-Path: <linux-kernel+bounces-408447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7EC9C7EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B0C1F22097
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA3918C91E;
	Wed, 13 Nov 2024 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5Fu0YF/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pzM6LN/6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0818A6A0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541941; cv=fail; b=kx1J6rz/p7UeLE9xjNeCYgL39YrpNulVVhiYKQOZIcNkN1Wr71bWUshlxB8Rcl76iJ3QDOcwf/b2V5y++R4JDD8NeO4Vs6LKOds+AcOS6fDOgKHjp6DtLOHB7V1+BkrcQfUnZ08bFJi7d1vTZFj/0UEtQvfPxjNiKKPXiQ8Ys0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541941; c=relaxed/simple;
	bh=qcnNHvU1ptmUv46mB3JH3ohg3z54dhkmH6DH/7LB9vA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Cjl2T0qyNQDRWahaAYTV9UZ5hz5a/Oi6OUJQztYEmSD3c0sm2DF8i9MDCZeLet140vf0c652paOWpgybDBol3Qt2eGcP4AFYksXld/1iqnLHLI9uSoJf0PbdRjxaJQ764jpSFEfi9UEOhXLsgt+kI8apKrB5ODJoC9q21IwgnlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S5Fu0YF/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pzM6LN/6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNBZbt008994;
	Wed, 13 Nov 2024 23:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8W0nohFrt45K4eQeXnc6ZCjN3CMLdDLvpTAXN9Gwk6g=; b=
	S5Fu0YF/pEjR7evvGB6dUuSLRvihws5Ib/6aVsEh7O8wS6HWEjhN6OLdtRX68kOp
	J42diRJXbZKED+IZLi8DGHhHUlDj/KvzORbj4lJ30+Qz2blziD3cT38iIE5eN2bz
	dN3+AoJavR+oa3KRlHb5+T2/5LA3VTKShEGHBIYMVqMG+ABF6s0lfwF6RuKHLImZ
	MgNOWb9wSOL4tF2JdcVQ4znpSK2vHN5am2YvYjiDJAd8L8yxmtZW7O/6hJsUHGDF
	iDJGByz5Ngz2C8VPm6EhoD6c0ds1vVyEvkOA3nXNgmAHNN3RbIUrCKstC9QvRfqP
	GU52c+LOWuLjLqb6xf5ozA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbg682-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 23:51:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADLqb9u001222;
	Wed, 13 Nov 2024 23:51:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6acc3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 23:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0XSLtrvs1lZPeQug0n/DcKeQNZIUl4LXZogU3Hs7npSbzdhvS9lQSUJQOnSnmBW4XGZg8JcFlFl+6OqhERI8Nm5SPcgjT5nE138qeG5nxlbf6jrMuJnkJvVgAXjWN7X5wWs64ZdB83KTTzy4x31Tr2UZoII/jk/53auPa2TVXj3V9s2aCJS1QydbrheieuORsh8q9+rJ1gwx/KU5137YBZrZfs2HP97DATY8bIXC4IZhZugOpAD+Cgj4/g6+q6Ilj3xGSJ+x5Nso0qK06FZAgdemNvX+TdbKY46vnckHIg2rOVmqfwukXQTwP9mTjNMgoXE3rzXrM0Vr2MpuoBJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W0nohFrt45K4eQeXnc6ZCjN3CMLdDLvpTAXN9Gwk6g=;
 b=bvmchKdRQxRecga9w+b0IcMml0z2hIECTv/Hz5g2bCleaVPNAFYsazFdUTr1UPjRJlVmi4q2xrrYCalMYi6OYX7HtTJiwmcLZgSOUWPnTLJeufnK2EquX8yApxp64GeFN3CzEW29+PodZqBwl/43JKTn5z2IRrX7mHvmPAmxbA8s20AZbbSxp51LF7UU1HyqPeMpKM9ss4WA8/53zq5l6gKg45AOyBsISYd1CAu6gMXpSaTNeTgCAcTJR2kwxYJQkYYschBJ/7ld5NUhGUI7PY2puO/oEeEI9rdlJDim2PP+qQB9oROKchRkWtACeRmziHFhUkvQr9nRF/KQ8d2Hlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W0nohFrt45K4eQeXnc6ZCjN3CMLdDLvpTAXN9Gwk6g=;
 b=pzM6LN/6cDeQ+4SWNrWy/vVL4Ux6OBrOMFSNZiJHjHgClDhtFElS2HFTPe40hRFHR3oDQqtc4Ee/uA/HH7Xwc7DsL+qkPe2KKVi+8fzaZPL1xjMY/JNxbMFs3ZWEqWsDUCjiudgtzfjPKJ3ahbLfMFw4NOu5hoELtgNTbilDUQ8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH4PR10MB8073.namprd10.prod.outlook.com (2603:10b6:610:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 23:51:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 23:51:48 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-3-ankur.a.arora@oracle.com>
 <ZzS-xESs1KPk1D8n@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 2/6] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
In-reply-to: <ZzS-xESs1KPk1D8n@localhost.localdomain>
Date: Wed, 13 Nov 2024 15:51:47 -0800
Message-ID: <87h68asne4.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW2PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:302:1::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH4PR10MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca028de-4c71-48bc-6ad5-08dd043e2339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm16QlRYalFlczVpa0ZHRFAyV3BZdUFUUzVDMWM0OVJ5SXZpMG1zU2ZyVnpC?=
 =?utf-8?B?d2VEazVHVHRBNkdUZHlZU3ZJUE5yUmpQU3ZDY1BXWi8xODdUcEs3TTBaR3lq?=
 =?utf-8?B?aFNISGo3RXd6eVJsMHJXZytkK2wzYTNzM1NFTW0xdEttQmpWRFVyeW1mUTYv?=
 =?utf-8?B?SGFyb2QrQ0U2ckgrckluYVZRZytFMDJCYXZkWkRrRU1ORFhBU3VPVmJlUjJB?=
 =?utf-8?B?QWJ4TlhWYkVnZVdSaGJpdExKSksvMTk0eWFBZ1g5LzRtbkxKWnlvRkRkaEtL?=
 =?utf-8?B?MUlUTEt4NjFaaUpwTG5NQXFOMGpaN2VncjlHRVpVOHUwNXZSa05pZEZmM3Fm?=
 =?utf-8?B?akdkSlVuTnloRHJYN1BHU1dIZFIzaFd6L3N0L1dQVU9Dd09VQ2NyUmFGTEdj?=
 =?utf-8?B?eENWWThGNm50YU1KdkpvSlZRWUc2eS9XbFduYkVObG8zWmQ1SE5BYWEraXRs?=
 =?utf-8?B?a0h2NG9DSVZZOC9ZVHdtakZJbkpDN05OOFM2RExPUjA4T2MzNUZxbS9xZ0Uv?=
 =?utf-8?B?N0RyWEdGS0M4aFJkelZkYVNwa3hlbEQ3UHhLUTc1OHlMQmZQc3g5eUZ5WVpn?=
 =?utf-8?B?SUdZSmVxWjBaNjNXejlZaVRLM1p4N3JEM3Q0RjkzU1IrTk5QREJXb0JNWWFa?=
 =?utf-8?B?Q1NvMWtpRm9VRVdoSGpHVFBvQ3dwQ3VOMm9QOE9kTS9UU05mb0hPQ3dwSEhl?=
 =?utf-8?B?N21PaDhHeVcwVWhoNVNWWDVrb1FFZW1VNGJnWXRlc2tudFRCbHYvUjZId0dQ?=
 =?utf-8?B?T2VoaHhhUjNSd1dydjk1dHRlY2p6bWhWWkxJSkRSOXIvTzNxNnRLNVIrbnc4?=
 =?utf-8?B?MllCUDFIM2J3ZEJCL3k3WFcrVEJFODNieFY4d2drc1o1ZktNbnQvUUU1MlFV?=
 =?utf-8?B?N2w1dmJybkJhOXRvSSttYk9mYS80MzVwL0twWkNHZEcrMzBoQW9tYy9lb1FL?=
 =?utf-8?B?K0lvWlVMVUJHSjhwTXRWaTVmT1pjV056aGVtZnNuVGEzLzRjTWEvbmN1VHl4?=
 =?utf-8?B?T0hkRVRMNjUrWDM2TU9GalBnZUZBQWhHRXk1M0o4NUFnZVZIUXJNWTl3a3cv?=
 =?utf-8?B?TnBTYkt6Q3Z0RTFWcFlhZ1EzZjQva1Uxd055ZUNtUitRb3J0a09oVzI0czZY?=
 =?utf-8?B?WFpZMmcwTmw1ekFNS29VNmNYNm1WZlhqMG8rOHRsOEZ3LzNKcGUyZWJMV3FM?=
 =?utf-8?B?Zmk0aXM1UTJ6YnZ1VnRuaXNtc1QrcWFZUHRQRDdna2xMNmNNYitPZXZua25u?=
 =?utf-8?B?WHhPTkg0dVE4a1lYV2dWK29LTVUrZDF6MUVJWVh4NDFpaHgzNEx4QWk5VXA3?=
 =?utf-8?B?QUFNODArUDdGQWZ6UFBNMGxuZDVHTVJCUVBhcU1HTjFZeWtDL2cwZ09LNk5I?=
 =?utf-8?B?aFNlWkMvYWw1cTdjYkpkY3VlbnROZmt0VFQzUXQzS2tQZTVjeG1jcTNCcWdL?=
 =?utf-8?B?eHYrVUVGTjBwYlhiQUwxWjBhMFV6ZksvK0JLd3dyMWE4SlZKZGVhTmFLMjds?=
 =?utf-8?B?Z2o2YjNIK2pvZHNwcHR4QW5lUXROY1dhYjJaMUIrL2pwdUYyK01BWW11VnFZ?=
 =?utf-8?B?REllTGk0bUQvYVBNeE5SVzFOVnlPek5sY052SVo5a2ZiWDhkSUgydzNyeGgr?=
 =?utf-8?B?UHh2aWRrVWprK3p3MmxmbEdHVjB5Z29NQ0VVbmFhdnBPeGtIRkREVElYdU1M?=
 =?utf-8?B?MTFqU0d1WGhHeHU3dldoVmhuNmRETURUSHFEZE82QUUrQ2U1OUthL2xHaHdm?=
 =?utf-8?Q?p7lrccdfGrZp4UdjmHzpQW78SkSzQppW2S2wnDj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFEzNVV5UWNlUHVIZlNPZnVNMUd3SXR5Z1l1ODA2bDBnNkdOZjhHY0o3Yzl4?=
 =?utf-8?B?V2NwSXNKamdROTBzSmdrdERCa2ZOZ1VwaHhFTk5XUTYyalpOcFBucVhuWDFY?=
 =?utf-8?B?cHJBTVBJaWJCUDhvQ2w2ZmpFNnllZ2laejBYT3VaZWptQVVhUEk5Qm42d2Ny?=
 =?utf-8?B?K1FkL0lOU3RIclhYSHJBeitCMHF0ampDZ0xJeWVQM201bzFiNmt3WUVsMmI5?=
 =?utf-8?B?ME8wQjhwVFgvZU53N3kvVGpJTEMrTUZNM1h2aEo1dytBdkc4MDQyYjMvM1M3?=
 =?utf-8?B?Y0Rlalo4UFltUks1d2RsVEYxRlZTdkU3S0hoWGJrMGhtQ0RKc21vdXZxVDR3?=
 =?utf-8?B?SFUxc0I0dDJGRTBVaDIyc0IzMjNhMWFLM3FzS09GcFJuVnhTUTI3T3ZXSmZO?=
 =?utf-8?B?ektKVlhQNXA3bUJ2UEcvcmdyWExjeUxWVU8zWkhPTWR0Y1gwMkp5ZzVVWDBQ?=
 =?utf-8?B?eG1sNXFRd1NNUzgveGhUOFhhV1JLWlpXU0hhM3VHc1czWFVnWXI2RDc1Z1By?=
 =?utf-8?B?blFSUGJNc0tKVVlHeVptK056WHAvY201SXhURUF6cXc5RkNaejQxUVFZZDM3?=
 =?utf-8?B?UmNVZTVUajBLcWtvMkZPeHRjRFpVTWxkbThZcUY1U1JmamdXOVZ5RHlyQTZY?=
 =?utf-8?B?aW94TlE0UVA4OWV0ZXpUZHUyQ3FqazdKbHVRYW94NG0vVUJia3FBRTBjSUVL?=
 =?utf-8?B?VVh1NGNhcnVZdkpDMzRjK3ZPMEF3djdyMkpXWEtENnZ4OElSOTZMcGt0ckth?=
 =?utf-8?B?dWxrUnZjby9HcHgzMy9xOFdNOUlhWS9ET0wzQU9QMWR5czVWQ1FnWHVITko3?=
 =?utf-8?B?UFNNLzZGa1lISlpTOTI1Q1BPODZ2RTd1SVFSSEs0L3BtelAwTU5lWndLRUpB?=
 =?utf-8?B?TFdTTUxFWXQyM0pUVWJVVTFhU3F6M0J1ZGROeCtKL2JNNnh1QkRtaURPVzQz?=
 =?utf-8?B?QmZYd215ZUtITmJiWGQzRmI5dFRtRWJiQXpGb2ZYWWZjRUVxeE5WTTVNdlZ0?=
 =?utf-8?B?aXI0aHhTQ2hyVXQ4dXVwVm9KRHVTNXU2S1lNcHk4aG5oelR1OVdwbDJ1ZlUy?=
 =?utf-8?B?eEs1enIzd2llWC96OU9aUXF3eTdrSVh0RURqWlZMTGxMc01YWjNvbVZVRU41?=
 =?utf-8?B?amZFZWhNbVExSEwxQlJnS2E3SlltRks4UCsvVjhUWjc5Z21TK0NHR0ZXaHo5?=
 =?utf-8?B?ZWFlWWRNbWpQQk45Ly9qMFZtSUFNMk1GZEJGMWxnRXFqSjRtRHlwMHIvbTBs?=
 =?utf-8?B?M3h4b1BZd21WRWgranRSZjlEVm1veE1Yblo5ZjNlaHNkdjBheENvQjcvRlpN?=
 =?utf-8?B?L25xT3AwMjdrKytxWTgyZkFiajBVUFlIdmhkNkxKeVJRaVR4L2F2Q2llckEx?=
 =?utf-8?B?bHlPSC9DQlltQW1xKzYwMTlMMm5kTnVabktMOXg2aS9KR08yRGZaamprQUZy?=
 =?utf-8?B?ekpYNXVycy9HTGxEYm5XdngxT1hHQ3pWcU0yY1pOSEIyN2llanJSVVJXa0hp?=
 =?utf-8?B?dDdhcUV1TXZ0V3R2aTNKVjBSOEVYa2hzRUdFd2ZvaGdDQVl3c1BKd2dMU0dp?=
 =?utf-8?B?RmRUWVhXMUF5Z2FPR053VWZmclhGUXkwQlhSS1JvbjV5alRObmRoR3U2bEQ5?=
 =?utf-8?B?MGRBKzRxWEk4bWcvMm9zQkJUWU1pNHBvejRkaUhGN0ZWZTgybFR4SGp0Z3Vv?=
 =?utf-8?B?aW5zendaQzZDY2xsRkUxNW1sL0lVRkM3LzVvZnNmQ0o1M3FrblowUlpSWis0?=
 =?utf-8?B?ZEVsZlVYdWlDSUthNWN0MGwrUzZlQ0dFSEs3VE5BemZhTFdPTEcwaGpmVjJR?=
 =?utf-8?B?amJnTGFVekFtZTcvVU1UV0o0aGxNbzFwTGFGcUVWL3pHcExKeng2QVQxcklK?=
 =?utf-8?B?Z1JTY21zanBGL0F5blZucitweEFrai9wbzlDZzUvMHBDdzBmcEsyOEh0UmVL?=
 =?utf-8?B?WWZmYVZLYWU5YXJGY2xOK2RDQksrNjN1RUpDVGJRZ0VoSmpPUS93WVdhRkZG?=
 =?utf-8?B?T3RPbkRrS3VSK0ZxWDFLYS9zSklVQmNGdHNNUUJWU2I2bmloTkpiSm4vbGpy?=
 =?utf-8?B?OHVPTDFOdk5MUWlRUnYzQjZHMjdPL2hvanQ5RlFncmU2NUlHVFRVa3dlUWRq?=
 =?utf-8?B?OEpZQnJ6Tk9qOEI5Ukl5SmJNOHQrK2tmbStXSjMzcW5uV1IxQ3hWWjlaU2xr?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hKNhepoLbIdDRcrbvYAXpqH/jz8YTXIOvTOWJIipqtn8DhtDlGvE9zJC8dnZGmWs3egmBx5LZoujg5TbjFKEM2egTpj0iIZZOJY9p2/3KQFG2n4C1nWjgSvpSdQ+DNafO8bHzn7p8hTfOZA/KxkwSyQ6MygFjQ9bu3254LcsTVi1XsC6rhJePUQOc7rz0CEDOIcLPbg80A8ONMGKa6nwgJEBhyRAqS3FJlEQopmq+ce5YhJU5KZ59phFnCTDBKAD7ylYcth/pQ1Yiq8sZ/KkPQVosS9iQ5BjttmluoVI/RxU+Yvjv3EA5pmVCA0TJMCX42OTwgxWVUbeOXQqER1hkEa1Z+2MVr7yZx1YDvrGbvl0/yPmweK0LMszprWnmurU24IY0DapInrQNXpVMffKFXoEuVN9aPEcAndOPt4bA7tFTZDwNBe1OI5tPL9bRiJ/TDsGiZKrRaAbDANNAXGoX0fAOsAubRiUDnDkbRsK+FvdWWIw7xIaIRU0F3bBNSaKj3Mh5pKxH9CpvmScdtloeC/dPLQU3M2uP+gxGGsg2L36XmVv6TSIIn2+HaTNi007KPBbUG0v9zbXVJQ32Jdnc5O5yHL7DZFRwU/ePumkkqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca028de-4c71-48bc-6ad5-08dd043e2339
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 23:51:48.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQ6Jm6Ug1QXuW5cMJrHX9yriVxo81AW5o+rRdpTyNqAoKIqhmMKEC0owf7eT0f/a2OaY6QGH6AZ4+PyuaYiCpH4S2yCQSEsMeoKaks+3nNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_16,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=894 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130191
X-Proofpoint-GUID: 5zuhdixJlapL1oGh4A1DppzhyiydfghE
X-Proofpoint-ORIG-GUID: 5zuhdixJlapL1oGh4A1DppzhyiydfghE


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Nov 06, 2024 at 12:17:54PM -0800, Ankur Arora a =C3=A9crit :
>> Replace mentions of PREEMPT_AUTO with PREEMPT_LAZY.
>>
>> Also, since PREMPT_LAZY implies PREEMPTION, we can just reduce the
>> TASKS_RCU selection criteria from:
>>
>>   NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
>> to:
>>   NEED_TASKS_RCU && PREEMPTION
>>
>> CC: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

--
ankur

