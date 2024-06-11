Return-Path: <linux-kernel+bounces-210034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0CF903E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3B5B22E17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1B17D8B2;
	Tue, 11 Jun 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+IADLgh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BJGXSEEL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C117B437
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114760; cv=fail; b=OZIiVs89+JTCfYE26i3ZAq/hfJYQ2tCqvkw52r9OemiQYgIWb/dLB11dPJMi1rLrM3P4Bk9tWwhCoBstgN7zCf2u1ImRB1qmIyGG56khbc3d6UpWdj+FT0N6np3BkJFPFrT353DftNX0MuXzE39LRhaXCH3zpM9I7g7iVqQC2dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114760; c=relaxed/simple;
	bh=oJRtimWa0I11345USzrmSJ8RRXeu3keVYu7Cz0KoB2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C+TpZmLyntdsn208g3+nRsQtBoRrDFvsF24ESVr/PUP1zp0eTcLS9bdVe0OQf3ILHalJsnAFaS7cHxkRRc3OLJsJLTq5Jnv80BeuAD88wVc5o//rxdFrgV/HX6G9TsVtBxCHRL5JGuzpFndNpcWuZFhvapbSr2rVXjzx1kF7MHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A+IADLgh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BJGXSEEL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fOHS028066;
	Tue, 11 Jun 2024 14:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=oJRtimWa0I11345USzrmSJ8RRXeu3keVYu7Cz0KoB
	2I=; b=A+IADLgh3uTfbILvFnqyUWTTYGE2CVS9CAY1DCMXAExS+hKUOmkpo5yrR
	VyJCL6mU/lW2ebLZHjiH8Ax0JjjzdXjHYg7wGqENq9fk/seb540zfhml4DMoirNc
	XtqXDDHjY4OPee7CHL6gUbFqg0hncYVfOIV7NMoyhfl/C8+2x9Uk35KEPSBU/DL6
	4PR2S9d5PEi+VfGQUbQqqZycOLQS/+69MthKLlJyQFYFxYJZivpv8q2UbqGaEU/g
	m0v28t8qJ8AMsloRzXH66ywuTheZAj5Lue+PRLCwmaKvSz8wW9aWOj1e0X/xJoDd
	7bKpjuuoaX47zgvb2Mjf4fJ7HsdaA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mcxr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 14:05:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BDWio6020108;
	Tue, 11 Jun 2024 14:05:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8x8jt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 14:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaSsu2iIk13hmhgYohVppScbkp+YCSosY/kD+s74vP9U88p20UnBU5w22G08dihak2tm1YcvHEOMsHcgtI9BTxzd89fd2VrCXOgVezA+EYm4Aq6W9l/ModHoH8DoP9bG7QbdXRAqaV8v2Woeswoj01xB0F88UBm5NJJD1Vv4ze3+QFzU3fjwifSYTkrzrUnlwdlN8pUMsiKMDMQZcMl1w0lPoH0RE/DBBgsVs0Ijk/1nqALSkLC4LyJ5u33UO7FIruoA/YKf0CE1AtULIjMLPO8hxvD8uJpzYERy1mmwi1gxB/1UFTtpAnei8ZWJbIzKd+V40QX5W3Bc8sHjgm83ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJRtimWa0I11345USzrmSJ8RRXeu3keVYu7Cz0KoB2I=;
 b=c3bmV0/UXa0qISfzG1rmmU5Vc1e3WZ+Hr0aG8pTMCaz5Nk4CKdVAUN/Ef1AekRv0RK9/wOLN/mrA+LxajAIA6tC5QlG5Wc34JzCwHQ46oBt0HwQnFUhwA0Bt0gJw0IQQs4SN9kez0W8spsIViENdkmd93fHl6fSMs08gdElOJwMZqIljVV8manho9krnQ5F7Hh3zHTEGe1FugPGQdJaUdnZ9qAjlFIrqlwGFvXJS34mGMg5X279GBVGE2Tq5f9xqK9g06r+uZh5aVRC+Tab8X1Sk/rD0sSYm3qKvT/1AvUIYCNvaJGgM2oMWgTHQlrwLEYPnibIa2kuPxemNXoTm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJRtimWa0I11345USzrmSJ8RRXeu3keVYu7Cz0KoB2I=;
 b=BJGXSEELdb4Ix4txHurS7gMD4KxdlZEIaVNurqBSwbgCFgH+eeMwolugjYvNB3ySZ5cgOgpKWz0u6owbM0stSkoqMk0DmHfF4Oj/ZN6Xgq7jAb4Fwl6a/417+41PgSAaLzzbPRJSHHrrr2XRJp+FzfteuqrW91NIvVL/G7dqnZA=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Tue, 11 Jun
 2024 14:05:32 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:05:32 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: "jeffxu@chromium.org" <jeffxu@chromium.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Keith Lucas
	<keith.lucas@oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew
 Brownsword <andrew.brownsword@oracle.com>,
        Matthias Neugschwandtner
	<matthias.neugschwandtner@oracle.com>,
        "jeffxu@google.com"
	<jeffxu@google.com>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "sroettger@google.com"
	<sroettger@google.com>,
        "jorgelo@chromium.org" <jorgelo@chromium.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: Re [PATCH v5 2/5] x86/pkeys: Add helper functions to update PKRU
 on sigframe
Thread-Topic: Re [PATCH v5 2/5] x86/pkeys: Add helper functions to update PKRU
 on sigframe
Thread-Index: AQHauGKQF0B3HhgkNUGVwycOSCk5jrHBjJkAgAETbgA=
Date: Tue, 11 Jun 2024 14:05:32 +0000
Message-ID: <2DB720B0-0921-4912-8C5F-F0EDDF77845D@oracle.com>
References: <20240606224035.3238985-3-aruna.ramakrishna@oracle.com>
 <20240610213934.3378947-1-jeffxu@chromium.org>
In-Reply-To: <20240610213934.3378947-1-jeffxu@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|CH0PR10MB7411:EE_
x-ms-office365-filtering-correlation-id: 8457f383-9f08-4a15-592c-08dc8a1f8ed8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?a2twT1Z2Y1NUUVp4Rm5ubkttWnFTbU9RVlQ0ZEJCYjZhaXpuK1hiQXdRdnpX?=
 =?utf-8?B?bmpuYmlnT1ExYSsvSDFJbFFqOU9xa1BQN0ppMy9oV0ZNUm10UkxXTTNaazdD?=
 =?utf-8?B?WUhPQkFzOG9xOWJuRnMrVDc5aHpXOTMwa01NazlGVktqaFp6VTZwNExqYXpV?=
 =?utf-8?B?NVZHVnZ3NlhFamwxdXBwUW9tRFpzdGhBU3Znb0I2cHcxSVR1VEl2RkJaKzF4?=
 =?utf-8?B?Z0dieHVQZTQ2MmJxSnJuOHBCemNsbEo2WE56c0NjanI2SFVYc01pZ1VkQUdk?=
 =?utf-8?B?VExvMU1mWGR2dHNKemZRV1hndXpsS0ZYNkNyWkNQOVN0ZHg1aFE0WUY0UkRn?=
 =?utf-8?B?WE5MeFU3b0JYais4TUhDdnpTbXVrNHR0aFBvRTZzU3BOWitnVWs1bC9FNVMy?=
 =?utf-8?B?eWR3SjF5amJlaHRkY3N4VE5IcmVyNk1menpUeHdkV1Ura3dLZ3NNcWVWZmo4?=
 =?utf-8?B?dzdtVTdOd2ZZSGtpengxQVBLWitDSEtPUWFyS3JqOTJLaXB5UzVtSzkxVFly?=
 =?utf-8?B?a2l0Vjg4VDlpU1ZGWjFVcGROQkxKZ2FkaGQ2SmRqUVd6ZDF3WThndVBCZGtx?=
 =?utf-8?B?YnI2cHZ5WUNXUzhyWlpvU2x2MFZHOHMvc3lQL3dmRnhOVjVtSnRES0JzR1Zi?=
 =?utf-8?B?VDNCdWloTkFEWE51T1RWaVc3TXNYbHN5NjBxQkRTQ1ZHNU9PUWRDR3pDQ2Mz?=
 =?utf-8?B?OWVKWmUwdklMenhBV3ZvVWNzS0hCUnBsUm1ScXk2L20xbDlmRWZVRXorT3pV?=
 =?utf-8?B?TXg2eUtYNTk1dEFYMnJCa2NSQUxPdHFybTJtTDJPZlNmL2NtUXZ3aVlxandG?=
 =?utf-8?B?UXJqQ1EwN2dFUVRwTEkyOURRQW0vK2ZuTGJyL2N0UGRLSGVvaXdkZEt0RTNK?=
 =?utf-8?B?RVhyK0h2aTFIQS9NYXlCUXFrV0JWSGhJZHB1UzN4U0RQRU9aWWJmQndaOXdY?=
 =?utf-8?B?eG9ubTlTcWVRVzJUcHhzNHlLaHI0dlFHekxxWkJaZHJpMWFUN2Y2MHJLaitr?=
 =?utf-8?B?QStEYUZiTEVqYVZhOEhDbEJiRzA0a3hKblFKZmJCMkNVdWQvMkVKYkdjSWVl?=
 =?utf-8?B?Qk9vZk03VzVDVmJZWjBjMkx4TjV1c3F2TERNNFZxVVNrSjBsZnFGSERTbjlN?=
 =?utf-8?B?dlloSWMwemk4RlVHVTF1c1d0YmxwOUR3S1BIYksxUjhnNGtXVnZPTWQ1MnV4?=
 =?utf-8?B?SWFZbVdOd2lMa2U4bG9GeUg2bE5pUnFWSnhGUTRVeVNPeWQ5QVFjakloZGlY?=
 =?utf-8?B?enNSeUdUM2F6VUcraXlJS3FoVEwrci9haVA4Y0FsTDRkUHloY2IxSGE3NVRN?=
 =?utf-8?B?TDhQeE40cEVHR05LeHNIUnNOYzRjcS9YSVZleHVucDJuRGpSWGJhNmNzMnA3?=
 =?utf-8?B?c3JCcW5XdUpKUS8yUHhWWCtVN0o4WVErZWZnc0ZSKzBOZ3F2L29makQxb0dQ?=
 =?utf-8?B?RnFTWDJjTnhxVTdzTGFxeWdkZHFqOUlIK1JiQzhzdzJaSVBWL1gyYlhkUkUr?=
 =?utf-8?B?RktNNllueVU5NjgyRmgySlp1VXQ4ZHJjT09qa1U0R25qOWlKYk80cjJ1c1Rx?=
 =?utf-8?B?QWtEQlkzTXdNZGFDd3RpYlZoVmZ6a1NscjJvU2NMUmFqeFNqSjByQU1ydWhM?=
 =?utf-8?B?VTlkd2lqc2tjMGxzSFM5N2lDdXU3TktjY0dUWXMwaGpuMUtBTWRZVUdBbHgw?=
 =?utf-8?B?TUpJN1NpOVdQa3l4Q09yTG93UHNxc254SGNFRkwxOEJ4WVE1U05IOXRrRmYw?=
 =?utf-8?B?SEFDeTVWTSsvc25BdlhtSWhGamVJT0plWjEvVHNpZVZPWUhJa3RyR2FGTmxH?=
 =?utf-8?Q?qnFo0WpicA0Cqm4H+eYqZuewZt1k0sAD9mAuA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NW9vYkpOenArWjJrZXN4NXBYS3YxWFo2YnBWNXo2SmFUVHM1alVMeDFxVmZB?=
 =?utf-8?B?NWdNOGlYbEJLaGZ4TlpmSDAwRDVyY0l2amxpT0tEM0IybEtJcmlEeWtLSlpL?=
 =?utf-8?B?UnptWU14bnlBbTFRUXNsT253MjFKVjU2RGI1ZU82UHpyV21JakVzNk8rRmRx?=
 =?utf-8?B?SGJtVHdRRklQSHV0MGdXOVhyMnhUU3pFRmd4RlQ1dVZsOFJjLzhlRUUyWWZT?=
 =?utf-8?B?bGNjQ2JiQVZ2ZWZJRFM3QVdIc1ZvUVlsdGNOVjJEN2VLVmU1WDZXTXdYTUFX?=
 =?utf-8?B?aWtIRkdSOTJVd2RDV241Q25QUzVsOGVocWVjcUZjeXVlWExaQWZGdktTMURn?=
 =?utf-8?B?WE9ZMkFMeGJlVXdqMFJGZTlwVWU2a25KR0FpYVRTNk1kemF3ckJ4elNoWTR5?=
 =?utf-8?B?RGpoUWJTWURnbzVidVljR2FEK2V3aXV0TUdLaERqWnlOMC95QTFHaUo3RDhN?=
 =?utf-8?B?L0o0ZWV5L3U0MStMeVZlbzBXdXZyNWpZZGlRcUZmaWJtQ1NuTWNZaHJwM2FE?=
 =?utf-8?B?aERGRys2dzBHQ1ZhOXIzbUxxbC9QY05WVytrc2Y1Qm9IWlU3akxZTHBjN0dw?=
 =?utf-8?B?YWRIWlZLRVBGT2hIbGhkK21QNWJvbVJLSDRoT0JlVWhQUVgyQ1NNTzhPcVdZ?=
 =?utf-8?B?RVRkTG5sTytGUUR6UGRhZllVNm9mWXgvMzJrVXFENUVyZnNGRm5veGF6V2Ri?=
 =?utf-8?B?Sll6Ynpad3UzQTBYVHRYcDRtYW5acGQrTTlWdWcwK2VHbkEzcStWYlllU0p1?=
 =?utf-8?B?YllMaXlxNy9EUnB5ODhJRE8xSXdhZVlIdkpEVjZFUHlrWGZ5Tm4zdUNhL25Y?=
 =?utf-8?B?blVkQVN5OHF5YncrM2hBWDFZc0wxN0hmeFFmUndrcFpBK3BjVURoL0s5R25h?=
 =?utf-8?B?MXFCbzY1LzdCY1Y1SndxdFBNSEdqVkcrcWZKeHZkeW9MaGhVVTZlYS9yb1RY?=
 =?utf-8?B?YjlleUJnZm5ueUxOY3RZa3FlNnNoVGE1L0lTa1hHSitCeUQyRnFJZ2YyUG9X?=
 =?utf-8?B?OC8zN2dQaHFrOUhkb0N0ak5IR1BQNXZxWE01V3loZVUyUjcveHZyc0VmZTlC?=
 =?utf-8?B?c2czZm5NNDd0ekxZVCtQSGV4c3FORDdKb3llK3gzamF6RzVjWWpQaStxZ3JV?=
 =?utf-8?B?eEl5RWh0WllQcUYycDNkdVF4RTdHbEo0NDBmTmxLYURyZ2lMcXVNWW9HWlVx?=
 =?utf-8?B?anFUSmNONDZqaURjVkJMOENFMEV2dytSYjBuVUR2cEdkdkRuQmljZzBEWHR4?=
 =?utf-8?B?bCtlVVFmdVhpR2ZtQS9oaHQyYXN5MTA4ZytBUXRES0Z0YUFzaFd5bkJhMFpC?=
 =?utf-8?B?RnRGSXNpQWgzOExSYWpXSWQvTk1LRlhxNGc2aWpmWVBmTlc5cTNsbDZETVpn?=
 =?utf-8?B?aEpwQzVtOFdhVHpPcUFQb20xRTZBS2FIcWVCR0hVZnphVGVweWUwVkI1OGJ0?=
 =?utf-8?B?WWYxMitaZkdwTktUUnpDcktEK29HcVhRVGdSazZEY0VjejVqTHJyL1NyaU96?=
 =?utf-8?B?NmxoenpleUNsUmdWZTlDM3I5U016T25KTHg0WVcvaXJQd1ZvMVhTRU5IUTZP?=
 =?utf-8?B?MlYyS2IwRjIxaWlBNE56S0orY3hrdzdGN2JIdlFxdis1MnlVaHR0VERmM29J?=
 =?utf-8?B?RThCL2ZBeVNWWmJzVTdFVGw4SlpjTkV1Sm5pZXErRTFlYS9Gd1QrZDI5MVUr?=
 =?utf-8?B?RjEzK1IxeVFtVW9ZWVJjZE9aeU9ra3V5WXVrK2tPbkk4SzBOWjFpTEdWVkFw?=
 =?utf-8?B?YkdWcVBJTXZIcDVrdHRSZ2kyTmVZNllMMWk3NzI4ckFxSS9ibFAvdEpJVDhZ?=
 =?utf-8?B?WFpweTFGa2RCYS9FTHhVWTZYcGZhV3JPcElLb1BIYzJvZ2NybGdwN25nZUty?=
 =?utf-8?B?M21EVG8rVUw5QmdQWGtLYXNkTllmanBTTjZMZnFaQmlmNUlTL2swSnhvWk54?=
 =?utf-8?B?TExuRU8vY1NkaXhha3crZ3B4U3pjYytlcFVLbFJIUDlMZGp6SFpsTU9vU0ww?=
 =?utf-8?B?OEs3QzBvZ0RoelRsdVFaYm5PcGZhT25vK3g0anNndEV3d0R0eFcyL3BmRlBo?=
 =?utf-8?B?alNpQXlXMmRtY2taUlRkeEtXbyszYTl0OWtyRE4zYldGcmNNRTJSMERyY0R5?=
 =?utf-8?B?d21sWGhlL3RRblUxSE5IZ1pzTnA2RFVvL05WRUFkOTJKdXR6Mmovdi92cGh1?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF5A14B95440FD4398AF742B39E49DBF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SZpFhtsjDiHZFi3By/SiUxEK4yEWaUOCRPLcrOt3yemWLKJAFsY+djAX6PjBkHBryMsLZk9KvRwehsMuV8esSKMDJHgx4Rd/AfyXcS0nYpKLB8ua+ba2ex+6ZCCMiELQnFtehYMKeJDh6D/JUurJC6qCxhdkl7hK7NPMB8o/ZxrVw+0Qhr7bg9POJJdg074S+T1cuZlwV/moob8VIRNYI3QL+JiUa6h8/M2JJU74rziOZqm+OrWUkFAdS8r9WfVeSKRLVW7EDYGc2W6i5aiSXmyRv7q5Ev8nedzZ6qCzzq4J/celp2s+uTR/5Orohw2YUav7dYDdTp1kooSczm7dpTGbqTpfSlnNfMw3DREgjtTRBtMJWASKJE6DvdukvZq+GHP6Xm7q9nt7uu0xWz8f7MBpKYRd9LePMMxJNJNgZIvst+EDRpOUNpBw3WIu5GYAtcJHMOxdPap+Exh46YGQYvqu/sfZHG5HUtH5GNyX4y3qQr2ta8iyg9d7+Q7ZUD6I4CzILCv9i9Y0daAHcErKIZD3hNEoFxHROaetMFOqq54PLnu4becpBpHL8f3UxMZZDH7hzdtFth5i1CP5MhxLgV0EGbLdnFYjXx2HL2kHUiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8457f383-9f08-4a15-592c-08dc8a1f8ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 14:05:32.4725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmnRE6gPjtqKvBTwjr6eHFpbRsXdo9BNEiyZfiBU1aUALGnngXLjg172KdP8Z9tyziANdMEBiQYL+RRdyRNhpqZQObE5DUXqNBOuJ0X8too=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110102
X-Proofpoint-ORIG-GUID: hq11ZUnST99rmSa2TpjtUtn2BBKtnxXq
X-Proofpoint-GUID: hq11ZUnST99rmSa2TpjtUtn2BBKtnxXq

DQoNCj4gT24gSnVuIDEwLCAyMDI0LCBhdCAyOjM54oCvUE0sIGplZmZ4dUBjaHJvbWl1bS5vcmcg
d3JvdGU6DQo+IA0KPiBUaGUgb3JpZ19wa3J1ICYgaW5pdF9wa3J1X3ZhbHVlIGlzIHF1aXRlIGRp
ZmZpY3VsdCB0byB1bmRlcnN0YW5kLg0KPiANCj4gY2FzZSAxPiBpbml0X3BrcnU6IDAwIChhbGxv
dyBhbGwpDQo+IG9yaWdfcGtydSBhbGwgY2FzZXMgID0+IGFsbG93IGFsbA0KPiANCj4gY2FzZSAy
PiBpbml0X3BrcnU6IDAxIChkaXNhYmxlIGFsbCkNCj4gT3JpZ19wa3J1Og0KPiBhbGxvdyBhbGwg
MDAgPT4gMDAgYWxsb3cgYWxsLg0KPiBkaXNhYmxlIGFsbCAwMSA9PiAwMSBkaXNhYmxlIGFsbC4N
Cj4gZGlzYWJsZSB3cml0ZSAxMCA9PiAwMCBhbGxvdyBhbGwgPC0tLSAqKiogb2RkICoqKg0KPiBk
aXNhYmxlIGFsbCAxMSA9PiAwMSBkaXNhYmxlIGFsbA0KPiANCj4gY2FzZSAzPiBpbml0IHBrcnU6
IDEwIChkaXNhYmxlIHdyaXRlKQ0KPiBhbGxvdyBhbGwgMDAgPT4gMDAgYWxsb3cgYWxsLg0KPiBk
aXNhYmxlIGFsbCAwMSA9PiAwMCAoYWxsb3cgYWxsKSA8LS0tLSoqKiBvZGQgKioqDQo+IGRpc2Fi
bGUgd3JpdGUgMTAgPT4gMTAgYWxsb3cgYWxsDQo+IGRpc2FibGUgYWxsIDExID0+IDEwIGRpc2Fi
bGUgd3JpdGUgPC0tLSAqKiogb2RkICoqKg0KPiANCj4gY2FzZSA0PiBpbml0IHBrcnU6IDExIChk
aXNhYmxlIGFsbCkNCj4gb3JpZ19wa3J1IGFsbCBjYXNlcyA9PiB1bmNoYW5nZWQuIA0KPiANCj4g
c2V0IFBLUlUoMCkgc2VlbXMgdG8gYmUgYmV0dGVyLCBlYXN5IHRvIHVuZGVyc3RhbmQuDQo+IA0K
DQpJ4oCZbSBub3Qgc3VyZSBJIGZvbGxvdy4NCg0KVGhlIGRlZmF1bHQgaW5pdF9wa3J1IGlzIDB4
NTU1NTU1NTQgKGVuYWJsZSBvbmx5IHBrZXkgMCkuIExldOKAmXMgYXNzdW1lIHRoZSBhcHBsaWNh
dGlvbg0Kc2V0cyB1cCBQS1JVID0gMHg1NTU1NTU0NSAoaS5lLiBlbmFibGUgb25seSBwa2V5IDIp
LiBXZSB3YW50IHRvIHNldCB1cCB0aGUgUEtSVQ0KdG8gZW5hYmxlIGJvdGggcGtleSAwIGFuZCBw
a2V5IDIsIGJlZm9yZSB0aGUgWFNBVkUsIHNvIHRoYXQgYm90aCB0aGUgY3VycmVudCBzdGFjayBh
cw0Kd2VsbCBhcyB0aGUgYWx0ZXJuYXRlIHNpZ25hbCBzdGFjayBhcmUgd3JpdGFibGUuDQoNClNv
IHdpdGgNCndyaXRlX3BrcnUob3JpZ19wa3J1ICYgcGtydV9nZXRfaW5pdF92YWx1ZSgpKTsNCg0K
SXQgY2hhbmdlcyBQS1JVIHRvIDB4NTU1NTU1NDQgLSBlbmFibGluZyBib3RoIHBrZXkgMCBhbmQg
cGtleSAyLg0KDQpBZnRlciB0aGUgWFNBVkUsIGl0IGNhbGxzIHVwZGF0ZV9wa3J1X2luX3NpZ2Zy
YW1lKCksIHdoaWNoIG92ZXJ3cml0ZXMgdGhpcyAobmV3KQ0KUEtSVSBzYXZlZCBvbiB0aGUgc2ln
ZnJhbWUgd2l0aCBvcmlnX3BrcnUsIHdoaWNoIGlzIDB4NTU1NTU1NDUgaW4gdGhpcyBleGFtcGxl
Lg0KDQpTZXR0aW5nIFBLUlUgdG8gMCB3b3VsZCBiZSBzaW1wbGVyLCBpdCB3b3VsZCBlbmFibGUg
YWxsIHBrZXlzIC0gMCB0aHJvdWdoIDE1IC0gd2hpY2gsIA0KYXMgVGhvbWFzIHBvaW50ZWQgb3V0
LCBzZWVtcyB1bm5lY2Vzc2FyeS4gVGhlIGFwcGxpY2F0aW9uIG5lZWRzIHRoZSBwa2V5IGl0DQpl
bmFibGVkIGZvciBhY2Nlc3MgdG8gaXRzIG93biBzdGFjaywgYW5kIHdlIG5lZWQgdG8gZW5hYmxl
IHBrZXkgMCB1bmRlciB0aGUgaG9vZA0KdG8gZW5hYmxlIGFjY2VzcyB0byB0aGUgYWx0ZXJuYXRl
IHNpZ25hbCBzdGFjay4NCg0KVGhhbmtzLA0KQXJ1bmENCg0K

