Return-Path: <linux-kernel+bounces-400485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC429C0E37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E588A28283A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22494217330;
	Thu,  7 Nov 2024 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIwMqeaL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fJpzqm8t"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B8366;
	Thu,  7 Nov 2024 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006167; cv=fail; b=dTZYZ51QEZ1kDF7lKRm6xIVCAvdNFUOEZdXpHcM+YMA5JtlwnOMQOELu9W+JxhazJXa68qN8rAnXgeTYbPOxekWxZ1BpbRsPsLT8PpjcQJpt6z6LSf9fM5sccrMRcxy6sw8fLeauhwfQXPELIWPA+PCPeB5bE9cOqiRVcWq2v0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006167; c=relaxed/simple;
	bh=bxbO71Ki8wbZ7zZPjq+E4yL1qKFYBuOC00v13gfhDr0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cvhiAT2oSqvxqDELuh3oVPXxfIsCoDtO7HQUhljwvr8ifV0F/iU4KP00M2u6y7//2bMxSmOQbxOO4JvfknOBEB5HERKeUgwQP8FStyu+BMqiXW6fYXdyMBPQFIRl31FLBC/nDlCQVt9GVkKVQUF8Kcr0SmO6gxLSpMrLF5IS4Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HIwMqeaL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fJpzqm8t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBcWd002581;
	Thu, 7 Nov 2024 19:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=jjFcKK9DaHs68Rfo
	xVo4HS619GyPcbhiJra1Yaq9/xU=; b=HIwMqeaLtXZRv7+6VBm42ECTxLxVTd+6
	Za5NX96HyoOA20kulRmKjmONdRG1vAE4jhKAgM1T5HBdU1QM3mIFpjfDyRovhYHp
	GKyA+gywWhfrtm8lZ24TzAKsicbTLIaQC2NozjG5Ud1KkdnEdi3ezYTLhBo4Pqla
	Qsx0VGxvymp6k9foO4STjlMVok+0vYk4WuQ81nlo9EVcbgaP7R9Y6S4WACQE7nbl
	mUqgRR/pMVjGw0GGb0eTdPQjyYRPPgm4zjS/CvTbxGe5Ts00HWcqElCTousq7wmZ
	uXtu9ZDio8Wyr/jDBqH2tYgFJO53uKGjUJHIEAPz9UHitdkcDwNKyw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmtbatk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:02:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7IsvQ2008466;
	Thu, 7 Nov 2024 19:01:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahaee6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0svouPuRqjLtUJRHvvWxovXLnxngeK1dRrZLemDfGBWR5ZLpVYgVh1ur4lQf/PavVXmaInHavS3muwHoQ3LxOAl/vwnpb9h+oAEFseeSdUwC9MtE5WAY+Jv3qJLBa+eLRnWJ/iuOl7ZI0/o5WBxx2xulTlkIBwwfLu2lhNw3+h/Oj549Xv4J3Se+ugZSzKbkHbwe/qVV4qadp6MPrhy0RiPbJ44FPdXVGM4lAxNU75F0+VrF1J/aN0eNsHI2h4BD/ZVzu3lnuKs+uZB7PX6TYrkLUXz+8RFfUIGbrTdUTM2dXlG+lXOIY+5LlCnF/RXX/Ez2onezY+pj7LChXbOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjFcKK9DaHs68RfoxVo4HS619GyPcbhiJra1Yaq9/xU=;
 b=EUwBdkoZqBap4nz3DoeSKMlofl8xxk4vDtpd/T/Ak6ZRMD6OcPGRf7B+aNczll4vKNvtwznUD1ySEzSfQbHX6VkTYu7aPAWAieS6udsEPknzyzIPUZf0ezJaHz7HR16mILUNseTGNodcN9kC60IQr3K0UgOtj+R3H0KSsEMard8JDaeZ0//klKyl5X5Jdxh5Q7w19gF1bIktlQ03eW9TYwBaayFMknlt7diq2bDF1raa/w6Al/+BtwW8Oxph3m9pAr85pRzyCH6aVd6B/Oz7hd3Isf6L+gW2pkp7psoj8QA6jN+3RDHxMtCcZCfQkg5hDcb6saYMyD1VtEtljACRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjFcKK9DaHs68RfoxVo4HS619GyPcbhiJra1Yaq9/xU=;
 b=fJpzqm8tNZDZT06T0QOLXddqOt4B/dbf+r+bSQf/8v/1O3qRTwQj2ahdiMV4vOp6iQTbc9u8+Hd+ghRnQ9cNvRzCoW2MTANCSdKui2dW40GxSiPviiTNsIS+WKTCMpESycdRDkWJSZFipaezjWqh7n0oNlGLW4RsRflFqSXgl+k=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA3PR10MB7042.namprd10.prod.outlook.com (2603:10b6:806:317::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:01:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 19:01:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH] docs/mm: add VMA locks documentation
Date: Thu,  7 Nov 2024 19:01:37 +0000
Message-ID: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA3PR10MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d1d994-a586-4111-6732-08dcff5e9f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmpOeU9HQkdPYm1zaHh2T214cFZqMkFtRUltZ0t1R3NVbVRDVmI2SHdGRnJM?=
 =?utf-8?B?MDZCTnVMOGdKcExYQW5BMGZqTjk0dVB2ZUMwWm0rdTRuK1JXSWNIenExellv?=
 =?utf-8?B?VGFsblZkcHI4QksrcW9lQkI3UnYzYUhmamxpdlF3Q3lTaDVyQytNT3A4bnIy?=
 =?utf-8?B?OXZpKzk2T1RvUm9ycXVMUGUrbEFUVUVFSTB6dXVaM0xKYWxUWHFKY1RWWmpD?=
 =?utf-8?B?VzRFcWMwcHV4TUhaRFpkMzF3OHE1TkZwOHg4UWdhajRGYjZWYVFLZFVoZ0Y0?=
 =?utf-8?B?TWE5bkh2UlU1ZElqaXAxWkc1cUh6bGNTcHBZdmhJc1c4dlZTMnY0SWpwL2Nz?=
 =?utf-8?B?b3orRlU1ek0xUWNNb05LbGR0TytYV3ZyZFZyejZWQmNUSEhnejlFQVZzZTNx?=
 =?utf-8?B?WXVRVXVEcWgzUkluTUcwekZtQjM4Snp1bkJQTXBFVVpHNnhJajVKbmdILytW?=
 =?utf-8?B?UGxrcmJKZHZNR2J3cWJyeThrQ3plV2l2aFRzOUFVUmRMY3g5bjRCYmxKNjQ1?=
 =?utf-8?B?WkgwMjJodThieFRnKzV1dmlING9WSWdseFc0WlpqNDhWRW8rTmJhMXZCemV5?=
 =?utf-8?B?UWd5NkZPVFRhR2NRR0ZURldOM3kybUgzVUhRL2Y2YmI1OVEyQXYvT29nSUtv?=
 =?utf-8?B?YzFXNURsRWsxc3hUdms1eHd1QnRjMWxCcWx2dVFsd3BXdDVVSTZPYkw4bVZH?=
 =?utf-8?B?OXh6WHNVOXo5cWdWLzVMWmVQT0ZyNzR6b0JYZEVSL0hQalgva1JreENrRGM5?=
 =?utf-8?B?N1pVdzdPUCtpdmc4WjNUTkQ1ZDRNL09MVERnYUdTZHI2Rk9CMW9rRVAxY3dl?=
 =?utf-8?B?Qmw2TXJFOE5ZaU5EMXU1aWk4Z25WUmlIMGhVYVZMRW9TTVlaVWNZMEs5eEhq?=
 =?utf-8?B?TkozUWdza2VWSklQOFNqS2NaZlhsNGIwSmRqODR3cVZHWVNDRUZ3bTgySFBz?=
 =?utf-8?B?QU0zTCs0MnJLMmpXMEdDZSszUE9YZUVJSkMrSkJMc3lYNjdNR09mYlNpOEU2?=
 =?utf-8?B?ZXhrN2ZlSWk3WFp5aEV6c3c3alZoRGhZVHNrdVYvc2R2YTRGeVo5blY0VmtI?=
 =?utf-8?B?bHBtT3ZvOWJEbVR0cys2aE9SeFIyQU5abWJEd0RzV3JkZExkdnlYUW9UQUgw?=
 =?utf-8?B?eUd1TnVqZXpqRjJUV3EzRnlFZTYwMEtyMUk3aVFQRDZ5Ukl1TDRTR0JLNitQ?=
 =?utf-8?B?SEpqYXBSOWI5SzFqK3R3RnZXUHZreFBHZW9KYjVhWVgxMzRZczBFRTJteFNK?=
 =?utf-8?B?cTlucHhIRDFYcjlicUR0TmZnc2NyRzg0amFoZTJsa3lLN0dJRWhGK0FkY0hj?=
 =?utf-8?B?amI4NHFDMkpzTlJDQ0o5WnNjK3poaW9ZYXcxYzFnRERQeDRJZUN3WDI5d1hm?=
 =?utf-8?B?M0k1MnBYWVV3dnlFRnR3ZnRLdlUvR2VGUVI1SVF6dnN1OVU4NHZZbURsRVo2?=
 =?utf-8?B?TkxNTjdjZ0JKdVJIdUI0eU16ZjFpMmNXMkppclZteG9mTXRqcmU2UnptMDhy?=
 =?utf-8?B?YlJETWNNMmwxMGRIZkNVRm5jZUJiMkZIVkQyS2xiU1FxQ1hqZnBldlRNVE0x?=
 =?utf-8?B?MGZHVEJvNXJwMnB3TFNGNHNDdkNXbzNQdlV5Mi9PVTlLQmhOcTEwUUdCZmV5?=
 =?utf-8?B?RW40WUtoZmkrVzBVbVRHelc0U1pnUnR5aHFHZnlTaGM0Zm1iekdQUVhvWEpm?=
 =?utf-8?B?L296ZW5YZHZBZ2hmcmhRdE9vditBM1N3VFN6L0lmc2tnMHF1Mzk4NThRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2dIdGRCWk1GMTJnMUUvTk9wTmN2emlYU1g1VUErVHhRNUR0bkQ2VVVZT0Mr?=
 =?utf-8?B?L25ZRW0rWDluSVJYRFk4VTFVMnFrN2F3OSttTXI1djNvQllmQnYzdDBEcjli?=
 =?utf-8?B?T0ZqcEdBSXlkRXhnZHdJQUh0Nk83NjdIa2lGVGdDSTU3aUNIQkdDV2ZZdjZr?=
 =?utf-8?B?VkwzMmtOdmwvRW1LVTZUenNGQXo5TW9KYyszZ0RmVmVUOXA2SlFGYWw4V1dx?=
 =?utf-8?B?cDNhZ1ZQQ0d4SEVGa0dZUmVjSVJ3L1RsSzg1Y2lrZGx3OWc1QWZvbjlvMUxJ?=
 =?utf-8?B?MGRzYUNFUHNJQ1BhOEVLWUtWckxNNnhpaVVISStSWlBhRDM4aDdKWDVMY3Vs?=
 =?utf-8?B?RzNRUWZGeWM1RUZUTXVVelFsS2JGS2NMcmMzNWFDeUdZUUxFbFZxRmorS0ph?=
 =?utf-8?B?MDNZY1dCWmVIR0x5U2ZuWU1NaUs2eXBBZFlwWWhLL09GekMvY0pUMG9aSXRM?=
 =?utf-8?B?VjR1NmI3UEMyQXBINDNlejJrRjJWOGZDUVZqdk1RREQ2blBaZUpwcXJyY24x?=
 =?utf-8?B?WFozTnVWMG8ydy9GaDl4aERpdWZ2ak9vb1hOcW1Mdk9SNmFwY1FYaHR3elht?=
 =?utf-8?B?Q2ZCbGFpMXEvbFFTWkxHSEs4YzZiUFM5TVdxT1R4am1yTmRPRHFLbTZlaUUw?=
 =?utf-8?B?L3czNHhyc1orZGlhMUNHeDJTTUx4eFJSc0NJSHJxY2ZKODNmZk5KcWQ1YW5N?=
 =?utf-8?B?SnI3Y29mOFhDellKOFhIWnlYaHlLV05peTVubHFrSGNJUjFHRkYvSmpjMDF4?=
 =?utf-8?B?Zk8xbTltUUd1a2RLT29zbzZPNjN5WnRzM0FXNTh0WjkvZjFQdkJ2MTFJQmtj?=
 =?utf-8?B?bU4yY2grNGlvUnphbm1aU0NHTVc4bnJFeTdLVTZZZzlHT0xqWUtZK21jaS92?=
 =?utf-8?B?aVpiRjZBV1RZaUxGQnZQNFdIdUM2S1JmWkE3N1RaVGNWcDBvcVR3eGZ1VGRN?=
 =?utf-8?B?NzM0RnBGakEyamlkZ0lZZGRHKzlOL3JUK0hCcHVWT2x5MktNRU9EdUYwYkRo?=
 =?utf-8?B?U0hRMWJPaXpPZ052RVM3ZDlLNms5Q1hiRzV5YkFqcFIrSHVhdzlmMHRNS2VE?=
 =?utf-8?B?bEwxOEVVUEF6Q2tPVUtlNlVMM0s1TzVlc3Azd2JwWjJFb3YyT0lNS1A0bUVq?=
 =?utf-8?B?Q1NlRTRrSlhob0xlaEZzck5XbGVkTU93Q1FZeWo2YUQvNkQ1bGw5WWJhcXpE?=
 =?utf-8?B?QnJIdFIrclB3dUROMEczeFRQL3JOV2JqMDlZU3NaVmVGdmRPS0lTaTdBclRZ?=
 =?utf-8?B?V1dzcTZNRFVpU21XR3lCR3ZucE11NlZmVEhGL1lGVzNrWHpWZnpIZ3ZEbXFq?=
 =?utf-8?B?eCtqZWY5MzV0NkJrUGdXcXZMcVMzeXpXaElZa01rSHRueTVnNnFDUndyQlNE?=
 =?utf-8?B?emhCVTcyZXh1ckVpckttMy9QT1QrN2NLamJCcHNtc3ExTTdIQUlRMGQxMjRC?=
 =?utf-8?B?S2hwVnVsT3FySG1BdTNSK1hkdFRzSXJHY1ZheEtOd3NRQi9EUHY1Sy9SazZM?=
 =?utf-8?B?a1kwRGh0SThqZGlEalBPektJQVlCTFFaR1VWL2RHeWRaUFRsckZIK0k2SkZB?=
 =?utf-8?B?TFJ4dlZISzdlRkFENUZwZHlia2dtRXdjNmNBVnBSMTdZRWZqMCt6QTRzcThG?=
 =?utf-8?B?VXlhZGJLT0JqQnd1VG5qOWt5R05iV1UyV0MrK0hlbE9Ba3N0dXFZUmRORDc5?=
 =?utf-8?B?OXkyQmlxRURqaXdYQnV6ZGhpZ2tLYU9MekNlcENaSlRPSjVzeGRPbUpkT3F0?=
 =?utf-8?B?NjFoYXZ4aTZValhHL3JETDFEUVhDbmtKNEJENkFJWU5xbTNDTDZYWm52TUFx?=
 =?utf-8?B?QnBQZ0xMTzZkMG4xbUtZM2xRRFF6azRoWkRoYzZIekxZNEh3dG10L1ZWUEFw?=
 =?utf-8?B?RHRQU1cxNjR5R2VFKzQrbUVjSnNNY1pEcnNTZWxqSHJuU2Fhbi9HS2JMQXFH?=
 =?utf-8?B?ZkF4SXczTzlIWWF2a3ZpQzBYczJsbHRKaVNXV0pzYTJhMDJXcXFhT3NDQThD?=
 =?utf-8?B?YVJMQWtteU9LenhOUGVDcDZzK2VzWEtzQ0Z6Y1YzU01naG9jUys2MDJTaHFa?=
 =?utf-8?B?M1FiN09ZTE5HeEdGWWFla2M1TXdQb0ZLK0ppNndnN1JCSTgrcjJGaUxRUVF3?=
 =?utf-8?B?cDFkOGhYK3BjcTBYRGFqREdRbEZFUWVKQXlBM1VTUzJ3UGloa2tzaVF1Y0V6?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OyZALgcSjXFXQtBdUYLRL9zKLW82nUUpERY+VJAuB9+2jmeb/kMfb61ing9+x3+ShEvBHqPGNZHBaa9SStKI1sqDBjplRfj10VzA7uvTx6xrFe14dA+U0c0wSIsKHWLJesac1ygy+IqVcLtAjeB+L2eFn5e2rA6DZK7KZPKJhEujjJjQfJAduJFLTDtEMpQ9rTjXfkp1byiiPqGP8K+VjA6TQik8iPRxD1EUAvGmWOjba/y66HW9JP7Vo5icI/6dW2j9A5Sm1YrSVfq4mKzTGFXcLbN4k5WVMU+xJHR3+R3Pk0AYqyCgVlcgkg9h6CKxfsCKoD1EJZxKRWmtUMeJHH0MsWVLsMvbcUAjC1CfzlhNvTk6c9GXwhnQq0wHDZOIKm4G+UqfMugUOTsHiYzte/Q6dJh+NvkoParWv0lBu5ETRXIgs41NIgu80ELKRhaGeQixkuB98qk9pH2V3+HoMT2DLldQfmxJydk3vbMDNCMSp1FNv8exMrbUvpS4Ucj4tMUvalORFTXaz6EQ2pK8WYlEoybp8fa2uDaKZUjlw5AacJ3K+Xk17Jzh7ACfpcew/Tfo+oBUmwuXjMG6iPrNSdSZ9rUiP9noEgoNviqW2Co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d1d994-a586-4111-6732-08dcff5e9f09
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:01:44.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YklcYc0TclWktl5zQrR8BCI27LeHu0MelDCbJjxJJileYHNOQJxK/Omo1pUBaQdgX8SE6s2N9OWYg7Q65f67CRYWufOJT2wDnVsseMFiIWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070149
X-Proofpoint-GUID: w8PJGjXGuIUQdkS65H8P807Dr_GNLgV5
X-Proofpoint-ORIG-GUID: w8PJGjXGuIUQdkS65H8P807Dr_GNLgV5

Andrew - As mm-specific docs were brought under the mm tree in a recent
change to MAINTAINERS I believe this ought to go through your tree?


Locking around VMAs is complicated and confusing. While we have a number of
disparate comments scattered around the place, we seem to be reaching a
level of complexity that justifies a serious effort at clearly documenting
how locks are expected to be used when it comes to interacting with
mm_struct and vm_area_struct objects.

This is especially pertinent as regards the efforts to find sensible
abstractions for these fundamental objects in kernel rust code whose
compiler strictly requires some means of expressing these rules (and
through this expression, self-document these requirements as well as
enforce them).

The document limits scope to mmap and VMA locks and those that are
immediately adjacent and relevant to them - so additionally covers page
table locking as this is so very closely tied to VMA operations (and relies
upon us handling these correctly).

The document tries to cover some of the nastier and more confusing edge
cases and concerns especially around lock ordering and page table teardown.

The document is split between generally useful information for users of mm
interfaces, and separately a section intended for mm kernel developers
providing a discussion around internal implementation details.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---

REVIEWERS NOTES:
* Apologies if I missed any feedback, I believe I have taken everything
  into account but do let me know if I missed anything.
* As before, for convenience, I've uploaded a render of this document to my
  website at https://ljs.io/output/mm/process_addrs
* You can speed up doc builds by running `make SPHINXDIRS=mm htmldocs`.

v1:
* Removed RFC tag as I think we are iterating towards something workable
  and there is interest.
* Cleaned up and sharpened the language, structure and layout. Separated
  into top-level details and implementation sections as per Alice.
* Replaced links with rather more readable formatting.
* Improved valid mmap/VMA lock state table.
* Put VMA locks section into the process addresses document as per SJ and
  Mike.
* Made clear as to read/write operations against VMA object rather than
  userland memory, as per Mike's suggestion, also that it does not refer to
  page tables as per Jann.
* Moved note into main section as per Mike's suggestion.
* Fixed grammar mistake as per Mike.
* Converted list-table to table as per Mike.
* Corrected various typos as per Jann, Suren.
* Updated reference to page fault arches as per Jann.
* Corrected mistaken write lock criteria for vm_lock_seq as per Jann.
* Updated vm_pgoff description to reference CONFIG_ARCH_HAS_PTE_SPECIAL as
  per Jann.
* Updated write lock to mmap read for vma->numab_state as per Jann.
* Clarified that the write lock is on the mmap and VMA lock at VMA
  granularity earlier in description as per Suren.
* Added explicit note at top of VMA lock section to explicitly highlight
  VMA lock semantics as per Suren.
* Updated required locking for vma lock fields to N/A to avoid confusion as
  per Suren.
* Corrected description of mmap_downgrade() as per Suren.
* Added a note on gate VMAs as per Jann.
* Explained that taking mmap read lock under VMA lock is a bad idea due to
  deadlock as per Jann.
* Discussed atomicity in page table operations as per Jann.
* Adapted the well thought out page table locking rules as provided by Jann.
* Added a comment about pte mapping maintaining an RCU read lock.
* Added clarification on moving page tables as informed by Jann's comments
  (though it turns out mremap() doesn't necessarily hold all locks if it
  can resolve races other ways :)
* Added Jann's diagram showing lock exclusivity characteristics.

RFC:
https://lore.kernel.org/all/20241101185033.131880-1-lorenzo.stoakes@oracle.com/

 Documentation/mm/process_addrs.rst | 678 +++++++++++++++++++++++++++++
 1 file changed, 678 insertions(+)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index e8618fbc62c9..a01a7bcf39ff 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -3,3 +3,681 @@
 =================
 Process Addresses
 =================
+
+.. toctree::
+   :maxdepth: 3
+
+
+Userland memory ranges are tracked by the kernel via Virtual Memory Areas or
+'VMA's of type :c:struct:`!struct vm_area_struct`.
+
+Each VMA describes a virtually contiguous memory range with identical
+attributes, each of which described by a :c:struct:`!struct vm_area_struct`
+object. Userland access outside of VMAs is invalid except in the case where an
+adjacent stack VMA could be extended to contain the accessed address.
+
+All VMAs are contained within one and only one virtual address space, described
+by a :c:struct:`!struct mm_struct` object which is referenced by all tasks (that is,
+threads) which share the virtual address space. We refer to this as the
+:c:struct:`!mm`.
+
+Each mm object contains a maple tree data structure which describes all VMAs
+within the virtual address space.
+
+.. note:: An exception to this is the 'gate' VMA which is provided for
+	  architectures which use :c:struct:`!vsyscall` and is a global static
+	  object which does not belong to any specific mm.
+
+-------
+Locking
+-------
+
+The kernel is designed to be highly scalable against concurrent read operations
+on VMA **metadata** so a complicated set of locks are required to ensure memory
+corruption does not occur.
+
+.. note:: Locking VMAs for their metadata does not have any impact on the memory
+	  they describe or the page tables that map them.
+
+Terminology
+-----------
+
+* **mmap locks** - Each MM has a read/write semaphore `mmap_lock` which locks at
+  a process address space granularity which can be acquired via
+  :c:func:`!mmap_read_lock`, :c:func:`!mmap_write_lock` and variants.
+* **VMA locks** - The VMA lock is at VMA granularity (of course) which behaves
+  as a read/write semaphore in practice. A VMA read lock is obtained via
+  :c:func:`!lock_vma_under_rcu` (and unlocked via :c:func:`!vma_end_read`) and a
+  write lock via :c:func:`!vma_start_write` (all VMA write locks are unlocked
+  automatically when the mmap write lock is released). To take a VMA write lock
+  you **must** have already acquired an :c:func:`!mmap_write_lock`.
+* **rmap locks** - When trying to access VMAs through the reverse mapping via a
+  :c:struct:`!struct address_space *` or :c:struct:`!struct anon_vma *` object
+  (each obtainable from a folio), VMAs must be stabilised via
+  :c:func:`!anon_vma_[try]lock_read` or :c:func:`!anon_vma_[try]lock_write` for
+  anonymous memory and :c:func:`!i_mmap_[try]lock_read` or
+  :c:func:`!i_mmap_[try]lock_write` for file-backed memory. We refer to these
+  locks as the reverse mapping locks, or 'rmap locks' for brevity.
+
+We discuss page table locks separately in the dedicated section below.
+
+The first thing **any** of these locks achieve is to **stabilise** the VMA
+within the MM tree. That is, guaranteeing that the VMA object will not be
+deleted from under you nor modified (except for some specific exceptions
+describe below).
+
+Stabilising a VMA also keeps the address space described by it around.
+
+Using address space locks
+-------------------------
+
+If you want to **read** VMA metadata fields or just keep the VMA stable, you
+must do one of the following:
+
+* Obtain an mmap read lock at the MM granularity via :c:func:`!mmap_read_lock` (or a
+  suitable variant), unlocking it with a matching :c:func:`!mmap_read_unlock` when
+  you're done with the VMA, *or*
+* Try to obtain a VMA read lock via :c:func:`!lock_vma_under_rcu`. This tries to
+  acquire the lock atomically so might fail, in which case fall-back logic is
+  required to instead obtain an mmap read lock if this returns :c:macro:`!NULL`,
+  *or*
+* Acquire an rmap lock before traversing the locked interval tree (whether
+  anonymous or file-backed) to obtain the required VMA.
+
+If you want to **write** VMA metadata fields, then things vary depending on the
+field (we explore each VMA field in detail below). For the majority you must:
+
+* Obtain an mmap write lock at the MM granularity via :c:func:`!mmap_write_lock` (or a
+  suitable variant), unlocking it with a matching :c:func:`!mmap_write_unlock` when
+  you're done with the VMA, *and*
+* Obtain a VMA write lock via :c:func:`!vma_start_write` for each VMA you wish to
+  modify, which will be released automatically when :c:func:`!mmap_write_unlock` is
+  called.
+* If you want to be able to write to **any** field, you must also hide the VMA
+  from the reverse mapping by obtaining an **rmap write lock**.
+
+VMA locks are special in that you must obtain an mmap **write** lock **first**
+in order to obtain a VMA **write** lock. A VMA **read** lock however can be
+obtained under an RCU lock alone.
+
+.. note:: The primary users of VMA read locks are page fault handlers, which
+	  means that without a VMA write lock, page faults will run concurrent with
+	  whatever you are doing.
+
+Examining all valid lock states:
+
+.. table::
+
+   ========= ======== ========= ======= ===== =========== ==========
+   mmap lock VMA lock rmap lock Stable? Read? Write most? Write all?
+   ========= ======== ========= ======= ===== =========== ==========
+   \-        \-       \-        N       N     N           N
+   \-        R        \-        Y       Y     N           N
+   \-        \-       R/W       Y       Y     N           N
+   R/W       \-/R     \-/R/W    Y       Y     N           N
+   W         W        \-/R      Y       Y     Y           N
+   W         W        W         Y       Y     Y           Y
+   ========= ======== ========= ======= ===== =========== ==========
+
+.. warning:: While it's possible to obtain a VMA lock while holding an mmap read lock,
+	     attempting to do the reverse is invalid as it can result in deadlock - if
+	     another task already holds an mmap write lock and attempts to acquire a VMA
+	     write lock that will deadlock on the VMA read lock.
+
+All of these locks behave as read/write semaphores in practice, so you can
+obtain either a read or a write lock for both.
+
+.. note:: Generally speaking, a read/write semaphore is a class of lock which
+	  permits concurrent readers. However a write lock can only be obtained
+	  once all readers have left the critical region (and pending readers
+	  made to wait).
+
+	  This renders read locks on a read/write semaphore concurrent with other
+	  readers and write locks exclusive against all others holding the semaphore.
+
+VMA fields
+^^^^^^^^^^
+
+We can subdivide :c:struct:`!struct vm_area_struct` fields by their purpose, which makes it
+easier to explore their locking characteristics:
+
+.. note:: We exclude VMA lock-specific fields here to avoid confusion, as these
+	  are in effect an internal implementation detail.
+
+.. table:: Virtual layout fields
+
+   ===================== ======================================== ===========
+   Field                 Description                              Write lock
+   ===================== ======================================== ===========
+   :c:member:`!vm_start` Inclusive start virtual address of range mmap write,
+                         VMA describes.                           VMA write,
+                                                                  rmap write.
+   :c:member:`!vm_end`   Exclusive end virtual address of range   mmap write,
+                         VMA describes.                           VMA write,
+                                                                  rmap write.
+   :c:member:`!vm_pgoff` Describes the page offset into the file, rmap write.
+                         the original page offset within the      mmap write,
+                         virtual address space (prior to any      rmap write.
+                         :c:func:`!mremap`), or PFN if a PFN map
+                         and the architecture does not support
+                         :c:macro:`!CONFIG_ARCH_HAS_PTE_SPECIAL`.
+   ===================== ======================================== ===========
+
+These fields describes the size, start and end of the VMA, and as such cannot be
+modified without first being hidden from the reverse mapping since these fields
+are used to locate VMAs within the reverse mapping interval trees.
+
+.. table:: Core fields
+
+   ============================ ======================================== =========================
+   Field                        Description                              Write lock
+   ============================ ======================================== =========================
+   :c:member:`!vm_mm`           Containing mm_struct.                    None - written once on
+                                                                         initial map.
+   :c:member:`!vm_page_prot`    Architecture-specific page table         mmap write, VMA write.
+                                protection bits determined from VMA
+                                flags
+   :c:member:`!vm_flags`        Read-only access to VMA flags describing N/A
+                                attributes of the VMA, in union with
+                                private writable
+				:c:member:`!__vm_flags`.
+   :c:member:`!__vm_flags`      Private, writable access to VMA flags    mmap write, VMA write.
+                                field, updated by
+                                :c:func:`!vm_flags_*` functions.
+   :c:member:`!vm_file`         If the VMA is file-backed, points to a   None - written once on
+                                struct file object describing the        initial map.
+                                underlying file, if anonymous then
+				:c:macro:`!NULL`.
+   :c:member:`!vm_ops`          If the VMA is file-backed, then either   None - Written once on
+                                the driver or file-system provides a     initial map by
+                                :c:struct:`!struct vm_operations_struct` :c:func:`!f_ops->mmap()`.
+				object describing callbacks to be
+                                invoked on VMA lifetime events.
+   :c:member:`!vm_private_data` A :c:member:`!void *` field for          Handled by driver.
+                                driver-specific metadata.
+   ============================ ======================================== =========================
+
+These are the core fields which describe the MM the VMA belongs to and its attributes.
+
+.. table:: Config-specific fields
+
+   ================================= ===================== ======================================== ===============
+   Field                             Configuration option  Description                              Write lock
+   ================================= ===================== ======================================== ===============
+   :c:member:`!anon_name`            CONFIG_ANON_VMA_NAME  A field for storing a                    mmap write,
+                                                           :c:struct:`!struct anon_vma_name`        VMA write.
+                                                           object providing a name for anonymous
+                                                           mappings, or :c:macro:`!NULL` if none
+							   is set or the VMA is file-backed.
+   :c:member:`!swap_readahead_info`  CONFIG_SWAP           Metadata used by the swap mechanism      mmap read.
+                                                           to perform readahead.
+   :c:member:`!vm_policy`            CONFIG_NUMA           :c:type:`!mempolicy` object which        mmap write,
+                                                           describes the NUMA behaviour of the      VMA write.
+							   VMA.
+   :c:member:`!numab_state`          CONFIG_NUMA_BALANCING :c:type:`!vma_numab_state` object which  mmap read.
+                                                           describes the current state of
+                                                           NUMA balancing in relation to this VMA.
+                                                           Updated under mmap read lock by
+							   :c:func:`!task_numa_work`.
+   :c:member:`!vm_userfaultfd_ctx`   CONFIG_USERFAULTFD    Userfaultfd context wrapper object of    mmap write,
+                                                           type :c:type:`!vm_userfaultfd_ctx`,      VMA write.
+                                                           either of zero size if userfaultfd is
+                                                           disabled, or containing a pointer
+                                                           to an underlying
+							   :c:type:`!userfaultfd_ctx` object which
+                                                           describes userfaultfd metadata.
+   ================================= ===================== ======================================== ===============
+
+These fields are present or not depending on whether the relevant kernel
+configuration option is set.
+
+.. table:: Reverse mapping fields
+
+   =================================== ========================================= ================
+   Field                               Description                               Write lock
+   =================================== ========================================= ================
+   :c:member:`!shared.rb`              A red/black tree node used, if the        mmap write,
+                                       mapping is file-backed, to place the VMA  VMA write,
+                                       in the                                    i_mmap write.
+                                       :c:member:`!struct address_space->i_mmap`
+				       red/black interval tree.
+   :c:member:`!shared.rb_subtree_last` Metadata used for management of the
+                                       interval tree if the VMA is file-backed.  mmap write,
+                                                                                 VMA write,
+                                                                                 i_mmap write.
+   :c:member:`!anon_vma_chain`         List of links to forked/CoW’d anon_vma    mmap read,
+                                       objects.                                  anon_vma write.
+   :c:member:`!anon_vma`               :c:type:`!anon_vma` object used by        mmap_read,
+                                       anonymous folios mapped exclusively to    page_table_lock.
+				       this VMA.
+   =================================== ========================================= ================
+
+These fields are used to both place the VMA within the reverse mapping, and for
+anonymous mappings, to be able to access both related :c:struct:`!struct anon_vma` objects
+and the :c:struct:`!struct anon_vma` which folios mapped exclusively to this VMA should
+reside.
+
+Page tables
+-----------
+
+We won't speak exhaustively on the subject but broadly speaking, page tables map
+virtual addresses to physical ones through a series of page tables, each of
+which contain entries with physical addresses for the next page table level
+(along with flags), and at the leaf level the physical addresses of the
+underlying physical data pages (with offsets into these pages provided by the
+virtual address itself).
+
+In Linux these are divided into five levels - PGD, P4D, PUD, PMD and PTE. Huge
+pages might eliminate one or two of these levels, but when this is the case we
+typically refer to the leaf level as the PTE level regardless.
+
+.. note:: In instances where the architecture supports fewer page tables than
+   five the kernel cleverly 'folds' page table levels, that is skips them within
+   the logic, regardless we can act as if there were always five.
+
+There are three key operations typically performed on page tables:
+
+1. **Installing** page table mappings - whether creating a new mapping or
+   modifying an existing one.
+2. **Zapping/unmapping** page tables - This is what the kernel calls clearing page
+   table mappings at the leaf level only, whilst leaving all page tables in
+   place. This is a very common operation in the kernel performed on file
+   truncation, the :c:macro:`!MADV_DONTNEED` operation via :c:func:`!madvise`,
+   and others. This is performed by a number of functions including
+   :c:func:`!unmap_mapping_range`, :c:func:`!unmap_mapping_pages` and reverse
+   mapping logic.
+3. **Freeing** page tables - When finally the kernel removes page tables from a
+   userland process (typically via :c:func:`!free_pgtables`) extreme care must
+   be taken to ensure this is done safely, as this logic finally frees all page
+   tables in the specified range, taking no care whatsoever with existing
+   mappings (it assumes the caller has both zapped the range and prevented any
+   further faults within it).
+
+For most kernel developers, cases 1 and 3 are transparent memory management
+implementation details that are handled behind the scenes for you (we explore
+these details below in the implementation section).
+
+When **zapping** ranges, this can be done holding any one of the locks described
+in the terminology section above - that is the mmap lock, the VMA lock or either
+of the reverse mapping locks.
+
+That is - as long as you keep the relevant VMA **stable**, you are good to go
+ahead and zap memory in that VMA's range.
+
+.. warning:: When **freeing** page tables, it must not be possible for VMAs
+	     containing the ranges those page tables map to be accessible via
+	     the reverse mapping.
+
+	     The :c:func:`!free_pgtables` function removes the relevant VMAs
+	     from the reverse mappings, but no other VMAs can be permitted to be
+	     accessible and span the specified range.
+
+Lock ordering
+-------------
+
+As we have multiple locks across the kernel which may or may not be taken at the
+same time as explicit mm or VMA locks, we have to be wary of lock inversion, and
+the **order** in which locks are acquired and released becomes very important.
+
+.. note:: Lock inversion occurs when two threads need to acquire multiple locks,
+   but in doing so inadvertently cause a mutual deadlock.
+
+   For example, consider thread 1 which holds lock A and tries to acquire lock B,
+   while thread 2 holds lock B and tries to acquire lock A.
+
+   Both threads are now deadlocked on each other. However, had they attempted to
+   acquire locks in the same order, one would have waited for the other to
+   complete its work and no deadlock would have occurred.
+
+The opening comment in `mm/rmap.c` describes in detail the required ordering of
+locks within memory management code:
+
+.. code-block::
+
+  inode->i_rwsem	(while writing or truncating, not reading or faulting)
+    mm->mmap_lock
+      mapping->invalidate_lock (in filemap_fault)
+        folio_lock
+          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
+            vma_start_write
+              mapping->i_mmap_rwsem
+                anon_vma->rwsem
+                  mm->page_table_lock or pte_lock
+                    swap_lock (in swap_duplicate, swap_info_get)
+                      mmlist_lock (in mmput, drain_mmlist and others)
+                      mapping->private_lock (in block_dirty_folio)
+                          i_pages lock (widely used)
+                            lruvec->lru_lock (in folio_lruvec_lock_irq)
+                      inode->i_lock (in set_page_dirty's __mark_inode_dirty)
+                      bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
+                        sb_lock (within inode_lock in fs/fs-writeback.c)
+                        i_pages lock (widely used, in set_page_dirty,
+                                  in arch-dependent flush_dcache_mmap_lock,
+                                  within bdi.wb->list_lock in __sync_single_inode)
+
+Please check the current state of this comment which may have changed since the
+time of writing of this document.
+
+------------------------------
+Locking Implementation Details
+------------------------------
+
+Page table locking details
+--------------------------
+
+In addition to the locks described in the terminology section above, we have
+additional locks dedicated to page tables:
+
+* **Higher level page table locks** - Higher level page tables, that is PGD, P4D
+  and PUD each make use of the process address space granularity
+  :c:member:`!mm->page_table_lock` lock when modified.
+
+* **Fine-grained page table locks** - PMDs and PTEs each have fine-grained locks
+  either kept within the folios describing the page tables or allocated
+  separated and pointed at by the folios if :c:macro:`!ALLOC_SPLIT_PTLOCKS` is
+  set. The PMD spin lock is obtained via :c:func:`!pmd_lock`, however PTEs are
+  mapped into higher memory (if a 32-bit system) and carefully locked via
+  :c:func:`!pte_offset_map_lock`.
+
+These locks represent the minimum required to interact with each page table
+level, but there are further requirements.
+
+Locking rules
+^^^^^^^^^^^^^
+
+We establish basic locking rules when interacting with page tables:
+
+* When changing a page table entry the page table lock for that page table
+  **must** be held.
+* Reads from and writes to page table entries must be appropriately atomic. See
+  the section on atomicity below.
+* Populating previously empty entries requires that the mmap or VMA locks are
+  held, doing so with only rmap locks would risk a race with unmapping logic
+  invoking :c:func:`!unmap_vmas`, so is forbidden.
+* As mentioned above, zapping can be performed while simply keeping the VMA
+  stable, that is holding any one of the mmap, VMA or rmap locks.
+* Special care is required for PTEs, as on 32-bit architectures these must be
+  mapped into high memory and additionally, careful consideration must be
+  applied to racing with THP, migration or other concurrent kernel operations
+  that might steal the entire PTE table from under us. All this is handled by
+  :c:func:`!pte_offset_map_lock`.
+
+There are additional rules applicable when moving page tables, which we discuss
+in the section on this topic below.
+
+.. note:: Interestingly, :c:func:`!pte_offset_map_lock` also maintains an RCU
+          read lock over the mapping (and therefore combined mapping and
+          locking) operation.
+
+Atomicity
+^^^^^^^^^
+
+Page table entries must always be retrieved once and only once before being
+interacted with, as we are operating concurrently with other operations and the
+hardware.
+
+Regardless of page table locks, the MMU hardware will update accessed and dirty
+bits (and in some architectures, perhaps more), and kernel functionality like
+GUP-fast locklessly traverses page tables, so we cannot safely assume that page
+table locks give us exclusive access.
+
+If we hold page table locks and are reading page table entries, then we need
+only ensure that the compiler does not rearrange our loads. This is achieved via
+:c:func:`!pXXp_get` functions - :c:func:`!pgdp_get`, :c:func:`!p4dp_get`,
+:c:func:`!pudp_get`, :c:func:`!pmdp_get`, and :c:func:`!ptep_get`.
+
+Each of these uses :c:func:`!READ_ONCE` to guarantee that the compiler reads
+the page table entry only once.
+
+However, if we wish to manipulate an existing page table entry and care about
+the previously stored data, we must go further and use an hardware atomic
+operation as, for example, in :c:func:`!ptep_get_and_clear`.
+
+Equally, operations that do not rely on the page table locks, such as GUP-fast
+(for instance see :c:func:`!gup_fast` and its various page table level handlers
+like :c:func:`!gup_fast_pte_range`), must very carefully interact with page
+table entries, using functions such as :c:func:`!ptep_get_lockless` and
+equivalent for higher page table levels.
+
+Writes to page table entries must also be appropriately atomic, as established
+by :c:func:`!set_pXX` functions - :c:func:`!set_pgd`, :c:func:`!set_p4d`,
+:c:func:`!set_pud`, :c:func:`!set_pmd`, and :c:func:`!set_pte`.
+
+
+Page table installation
+^^^^^^^^^^^^^^^^^^^^^^^
+
+When allocating a P4D, PUD or PMD and setting the relevant entry in the above
+PGD, P4D or PUD, the :c:member:`!mm->page_table_lock` must be held. This is
+acquired in :c:func:`!__p4d_alloc`, :c:func:`!__pud_alloc` and
+:c:func:`!__pmd_alloc` respectively.
+
+.. note:: :c:func:`!__pmd_alloc` actually invokes :c:func:`!pud_lock` and
+   :c:func:`!pud_lockptr` in turn, however at the time of writing it ultimately
+   references the :c:member:`!mm->page_table_lock`.
+
+Allocating a PTE will either use the :c:member:`!mm->page_table_lock` or, if
+:c:macro:`!USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD
+physical page metadata in the form of a :c:struct:`!struct ptdesc`, acquired by
+:c:func:`!pmd_ptdesc` called from :c:func:`!pmd_lock` and ultimately
+:c:func:`!__pte_alloc`.
+
+Finally, modifying the contents of the PTE has special treatment, as this is a
+lock that we must acquire whenever we want stable and exclusive access to
+entries pointing to data pages within a PTE, especially when we wish to modify
+them.
+
+This is performed via :c:func:`!pte_offset_map_lock` which carefully checks to
+ensure that the PTE hasn't changed from under us, ultimately invoking
+:c:func:`!pte_lockptr` to obtain a spin lock at PTE granularity contained within
+the :c:struct:`!struct ptdesc` associated with the physical PTE page. The lock
+must be released via :c:func:`!pte_unmap_unlock`.
+
+.. note:: There are some variants on this, such as
+   :c:func:`!pte_offset_map_rw_nolock` when we know we hold the PTE stable but
+   for brevity we do not explore this.  See the comment for
+   :c:func:`!__pte_offset_map_lock` for more details.
+
+When modifying data in ranges we typically only wish to allocate higher page
+tables as necessary, using these locks to avoid races or overwriting anything,
+and set/clear data at the PTE level as required (for instance when page faulting
+or zapping).
+
+Page table freeing
+^^^^^^^^^^^^^^^^^^
+
+Tearing down page tables themselves is something that requires significant
+care. There must be no way that page tables designated for removal can be
+traversed or referenced by concurrent tasks.
+
+It is insufficient to simply hold an mmap write lock and VMA lock (which will
+prevent racing faults, and rmap operations), as a file-backed mapping can be
+truncated under the :c:struct:`!struct address_space` i_mmap_lock alone.
+
+As a result, no VMA which can be accessed via the reverse mapping (either
+anon_vma or the :c:member:`!struct address_space->i_mmap` interval tree) can
+have its page tables torn down.
+
+The operation is typically performed via :c:func:`!free_pgtables`, which assumes
+either the mmap write lock has been taken (as specified by its
+:c:member:`!mm_wr_locked` parameter), or that the VMA is already unreachable.
+
+It carefully removes the VMA from all reverse mappings, however it's important
+that no new ones overlap these or any route remain to permit access to addresses
+within the range whose page tables are being torn down.
+
+As a result of these careful conditions, note that page table entries are
+cleared without page table locks, as it is assumed that all of these precautions
+have already been taken (in the :c:func:`!pgd_clear`, :c:func:`!p4d_clear`,
+:c:func:`!pud_clear`, and :c:func:`!pmd_clear` functions - note that at this
+stage it is assumed that PTE entries have been zapped).
+
+.. note:: It is possible for leaf page tables to be torn down, independent of
+          the page tables above it, as is done by
+          :c:func:`!retract_page_tables`, which is performed under the i_mmap
+          read lock, PMD, and PTE page table locks, without this level of care.
+
+Page table moving
+^^^^^^^^^^^^^^^^^
+
+Some functions manipulate page table levels above PMD (that is PUD, P4D and PGD
+page tables). Most notable of these is :c:func:`!mremap`, which is capable of
+moving higher level page tables.
+
+In these instances, it is either required that **all** locks are taken, that is
+the mmap lock, the VMA lock and the relevant rmap lock, or that the mmap lock
+and VMA locks are taken and some other measure is taken to avoid rmap races (see
+the comment in :c:func:`!move_ptes` in the :c:func:`!mremap` implementation for
+details of how this is handled in this instance).
+
+You can observe that in the :c:func:`!mremap` implementation in the functions
+:c:func:`!take_rmap_locks` and :c:func:`!drop_rmap_locks` which perform the rmap
+side of lock acquisition, invoked ultimately by :c:func:`!move_page_tables`.
+
+VMA lock internals
+------------------
+
+This kind of locking is entirely optimistic - if the lock is contended or a
+competing write has started, then we do not obtain a read lock.
+
+The :c:func:`!lock_vma_under_rcu` function first calls :c:func:`!rcu_read_lock`
+to ensure that the VMA is acquired in an RCU critical section, then attempts to
+VMA lock it via :c:func:`!vma_start_read`, before releasing the RCU lock via
+:c:func:`!rcu_read_unlock`.
+
+VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semaphore for
+their duration and the caller of :c:func:`!lock_vma_under_rcu` must release it
+via :c:func:`!vma_end_read`.
+
+VMA **write** locks are acquired via :c:func:`!vma_start_write` in instances where a
+VMA is about to be modified, unlike :c:func:`!vma_start_read` the lock is always
+acquired. An mmap write lock **must** be held for the duration of the VMA write
+lock, releasing or downgrading the mmap write lock also releases the VMA write
+lock so there is no :c:func:`!vma_end_write` function.
+
+Note that a semaphore write lock is not held across a VMA lock. Rather, a
+sequence number is used for serialisation, and the write semaphore is only
+acquired at the point of write lock to update this.
+
+This ensures the semantics we require - VMA write locks provide exclusive write
+access to the VMA.
+
+The VMA lock mechanism is designed to be a lightweight means of avoiding the use
+of the heavily contended mmap lock. It is implemented using a combination of a
+read/write semaphore and sequence numbers belonging to the containing
+:c:struct:`!struct mm_struct` and the VMA.
+
+Read locks are acquired via :c:func:`!vma_start_read`, which is an optimistic
+operation, i.e. it tries to acquire a read lock but returns false if it is
+unable to do so. At the end of the read operation, :c:func:`!vma_end_read` is
+called to release the VMA read lock. This can be done under RCU alone.
+
+Writing requires the mmap to be write-locked and the VMA lock to be acquired via
+:c:func:`!vma_start_write`, however the write lock is released by the termination or
+downgrade of the mmap write lock so no :c:func:`!vma_end_write` is required.
+
+All this is achieved by the use of per-mm and per-VMA sequence counts, which are
+used in order to reduce complexity, especially for operations which write-lock
+multiple VMAs at once.
+
+If the mm sequence count, :c:member:`!mm->mm_lock_seq` is equal to the VMA
+sequence count :c:member:`!vma->vm_lock_seq` then the VMA is write-locked. If
+they differ, then they are not.
+
+Each time an mmap write lock is acquired in :c:func:`!mmap_write_lock`,
+:c:func:`!mmap_write_lock_nested`, :c:func:`!mmap_write_lock_killable`, the
+:c:member:`!mm->mm_lock_seq` sequence number is incremented via
+:c:func:`!mm_lock_seqcount_begin`.
+
+Each time the mmap write lock is released in :c:func:`!mmap_write_unlock` or
+:c:func:`!mmap_write_downgrade`, :c:func:`!vma_end_write_all` is invoked which
+also increments :c:member:`!mm->mm_lock_seq` via
+:c:func:`!mm_lock_seqcount_end`.
+
+This way, we ensure regardless of the VMA's sequence number count, that a write
+lock is not incorrectly indicated (since we increment the sequence counter on
+acquiring the mmap write lock, which is required in order to obtain a VMA write
+lock), and that when we release an mmap write lock, we efficiently release
+**all** VMA write locks contained within the mmap at the same time.
+
+The exclusivity of the mmap write lock ensures this is what we want, as there
+would never be a reason to persist per-VMA write locks across multiple mmap
+write lock acquisitions.
+
+Each time a VMA read lock is acquired, we acquire a read lock on the
+:c:member:`!vma->vm_lock` read/write semaphore and hold it, while checking that
+the sequence count of the VMA does not match that of the mm.
+
+If it does, the read lock fails. If it does not, we hold the lock, excluding
+writers, but permitting other readers, who will also obtain this lock under RCU.
+
+Importantly, maple tree operations performed in :c:func:`!lock_vma_under_rcu`
+are also RCU safe, so the whole read lock operation is guaranteed to function
+correctly.
+
+On the write side, we acquire a write lock on the :c:member:`!vma->vm_lock`
+read/write semaphore, before setting the VMA's sequence number under this lock,
+also simultaneously holding the mmap write lock.
+
+This way, if any read locks are in effect, :c:func:`!vma_start_write` will sleep
+until these are finished and mutual exclusion is achieved.
+
+After setting the VMA's sequence number, the lock is released, avoiding
+complexity with a long-term held write lock.
+
+This clever combination of a read/write semaphore and sequence count allows for
+fast RCU-based per-VMA lock acquisition (especially on page fault, though
+utilised elsewhere) with minimal complexity around lock ordering.
+
+mmap write lock downgrading
+---------------------------
+
+When an mmap write lock is held, one has exclusive access to resources within
+the mmap (with the usual caveats about requiring VMA write locks to avoid races
+with tasks holding VMA read locks).
+
+It is then possible to **downgrade** from a write lock to a read lock via
+:c:func:`!mmap_write_downgrade` which, similar to :c:func:`!mmap_write_unlock`,
+implicitly terminates all VMA write locks via :c:func:`!vma_end_write_all`, but
+importantly does not relinquish the mmap lock while downgrading, therefore
+keeping the locked virtual address space stable.
+
+An interesting consequence of this is that downgraded locks will be exclusive
+against any other task possessing a downgraded lock (since they'd have to
+acquire a write lock first to do so, and the lock now being a read lock prevents
+this).
+
+For clarity, mapping read (R)/downgraded write (D)/write (W) locks against one
+another showing which locks exclude the others:
+
+.. list-table:: Lock exclusivity
+   :widths: 5 5 5 5
+   :header-rows: 1
+   :stub-columns: 1
+
+   * -
+     - R
+     - D
+     - W
+   * - R
+     - N
+     - N
+     - Y
+   * - D
+     - N
+     - Y
+     - Y
+   * - W
+     - Y
+     - Y
+     - Y
+
+Here a Y indicates the locks in the matching row/column exclude one another, and
+N indicates that they do not.
+
+Stack expansion
+---------------
+
+Stack expansion throws up additional complexities in that we cannot permit there
+to be racing page faults, as a result we invoke :c:func:`!vma_start_write` to
+prevent this in :c:func:`!expand_downwards` or :c:func:`!expand_upwards`.
--
2.47.0

