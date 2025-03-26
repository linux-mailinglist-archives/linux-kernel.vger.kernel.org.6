Return-Path: <linux-kernel+bounces-577348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996C4A71BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D004616A91A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5391F4E56;
	Wed, 26 Mar 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hO0h/sEq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZkXiTTe1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624A1F4289
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006474; cv=fail; b=S86moOk99snTN8ekrOGemMvKET/SiEDL2YIdx+KGosLDWgkjfhYXocU+TEw16JlKXGjxc8URci6uRLHgh5C6XpssSO+pqPWUwG2DPZZwikW1Y4fOWI/GuiKiTr7C9gCAZ5i4bu0zgaIqxoGeebN6HnBLqq2X2RJmpV+aqFrpsGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006474; c=relaxed/simple;
	bh=de4/nNMYqrMjj1TlzmUVBaQEuW5Oc2dBl9tIsYw9Mxc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ep/Z6dI7U08NAGYJ0yg+BFWyHvAJ+iTXU4fnd3oV0A+yK7xvZc1zZd5Bf8ErrjCvJvYe/uAnfdGkUSoTIUxaM4VGuO+YPICc4lFshth18mvG04nsMvvAn5cykwkKBoUN66TCNtiaHxylPUUuJeQ1qDGnGQ7NGp11AHl7aIYEZZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hO0h/sEq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZkXiTTe1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QGMsGG030811;
	Wed, 26 Mar 2025 16:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VvKadLPi7Isyt4dQEV8LURHJDyHPVNCn2LGpPcOriBk=; b=
	hO0h/sEqPOTGSn70saPnkIgonLARV0gcBy8UeDJvhxnZYkc5aGJAm6Z0bA3rQKse
	QBLgHm61laS/g2vDYzzyYfytWe1Hp2fby3SJjp0N3XWm5TG1DlwF+68wqavHrBda
	jhU+sDZeOrxQLzI/jh/uMC6ty0o1mgeTNulcgU2B0LslyOPe62UZlZpEHhTIjWv8
	MvdNa36mBwsJf431vCt++iKyqm/1yFRWPoy/s8PmxtYSHc5cDbUPg8NroFmxgXLf
	e0mzUFLh4M3a0gOF7OpN0+HuZBkWGyGjvI52AwlWyt+3utQcRhnFwwszNs/jMYqX
	keF9kN6XtTwUN7Fb8CgJgg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrshy75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 16:27:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52QFm0BG036409;
	Wed, 26 Mar 2025 16:27:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj5e4469-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 16:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzOb0hF0xWP9T0A5AeTucC4EHmtkBCHmibPWClVnwkuvKZaK2/YBFdcC1+nKU0Nn7Js4qSnuS6lwjnPQZRT10ESZ8wgt9bGslNP3LOU4L/Dz9DcPgxB5qnnKutJ8DJc3arPWIFdoBgh8te5w6h2yIKWadeLVlUZvjliNRRx54TmWRV/kA3nN/SZ69IcNr4wacNzViP5IzB2IFJglqVDYCewnzNh0Qt2oV7q1D16iOQzHoBjM8nuFHoFPKdzSjGDGsvnk9zJsuQs8T77Jxy4sJ3cZpLAALuvrU9TahzMh4KsUl8GuKGJ/7aOf3SGOfP9WMms1btYyAnOGHhiNinR+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvKadLPi7Isyt4dQEV8LURHJDyHPVNCn2LGpPcOriBk=;
 b=V14Nd5HVMiWjckNKqvuNz+NR5axD9rLe3IPHbt0kLCHBwq+XslHW4/mHWwpCdWvcuUJQk8JxRSbAxBLG4jVeIqxpMOPG8NVBQctn9IciqAyri97ukmlsHuX3RIVZBSmZpQULYMtYvMCRWJq6OxQvRcxzAGeJZmzu0pHkr7SqIX0wLaSf9TCce9SABtTyJNIKsiT+VQ2IgckPBy4YjFOLXrSxvLzHJwtfwwUVlruBi98uAXFqT0IJQ4ige0op2lwcfIJH5NuYw1ZSpmGFxD5v7yMSZGFqzPdHHfwQ2u8KfbGhMrypWeVO05t+MYbKIeXafZ5ln/FqNgNZmyI5tl3PVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvKadLPi7Isyt4dQEV8LURHJDyHPVNCn2LGpPcOriBk=;
 b=ZkXiTTe1Y3emG3ZZ2HnxaRpwxS/ZCyu2sAVZazMZd+NKXx0pW//ULacMoVw7E69nmsnc3eZEafcyPgPTtX8W0BcQK/E6DOZYU2PiBNAfUeA+rngIjuDn3FcDCqa8gtBBd1vqyXrNESG57FQIaGm9tOclu+V1SVe7si8zLwfNHoY=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 16:27:25 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 16:27:25 +0000
Message-ID: <90ba3938-89b4-4435-b705-ea7a654293bb@oracle.com>
Date: Wed, 26 Mar 2025 11:27:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] jfs updates for v6.15
From: Dave Kleikamp <dave.kleikamp@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net
References: <94b4d641-ca23-4b1a-aacb-0870e1ac7b25@oracle.com>
Content-Language: en-US
In-Reply-To: <94b4d641-ca23-4b1a-aacb-0870e1ac7b25@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610::17)
 To MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH3PR10MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 280a60f6-2a87-43f2-ed32-08dd6c8317be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVRBTlZHaXFRaUxTVVV3c2tNc1QwampBOVcxOFQ3am9FbTdpcU1XenFuNVVC?=
 =?utf-8?B?Mldiamc2T0hJUXJ3cmszUEg5Qk1nQTgwV0VsdW8rQ1A3eDdVMFl1dXN0dUsw?=
 =?utf-8?B?OXk2QUhWMFVLQzZibE9rTjhBa0orME0zd3U1QVNCeTQzMFFwbFdjYk9jakFR?=
 =?utf-8?B?TjFZMHhKS1F4Y3hKbmw5c1J0WW9qV0J5NUN2VmtSYzF0RU10TU45eG1EcnVp?=
 =?utf-8?B?WTlNV0h2OEtpRXRZQWh5ejNva1Z2WEJ3Z1Fqd3FSZFVSUVpzVnplK25BTkRw?=
 =?utf-8?B?REZKWHVBaSt4RDRZWUMxRm9uK2YvQnNlQkwxM1V3NmFQQ3k1cjQreGR6cUZq?=
 =?utf-8?B?bThPbGhJTFFHc1U5WlN6SGlVbDhDOG5mYjdaek00RUNOR3VKOG5TUXNWakwz?=
 =?utf-8?B?N05tVjRJYUp5SlpKdnhRN2QrRFlkczIzWTFMclF2U3BrNnRtRFZiVDJTUHVx?=
 =?utf-8?B?MkJNcUd3MWJTZDZGODFmZm1rdS9LOFFNdDRGOE8xMzNKdG9uYTF4eUtWYzhu?=
 =?utf-8?B?RGhvUit3OEJYdmNmMFpIYzF5MEJwdkxYbG9jdG9MVFFZZVQ1ZkgxMCt0cWRP?=
 =?utf-8?B?RHY4YjdHajlLUmpMbzl3K0xzd3lQRE1CNUJoTFprVVNPcldybDZ4TitqdnQ2?=
 =?utf-8?B?NXNJY0NiQW0xcVJuMnZqVld3YzJDOTVhUGQ5UnRGa0wxVWtsMU1PalNXNzB6?=
 =?utf-8?B?clpTQ1hoMkpHSjgwNS9UbUVhRytRNGR4dGhkeUszTldob2Y2TDlyN2RsNkNm?=
 =?utf-8?B?Ym1JckdCcXJGWi9SdnRUZ21DS3NpelgweUVkWlRGVkRKMHpaY05YZ21KOEVI?=
 =?utf-8?B?eWZiTWNZSUVoemxjaEJYQlFzL0h6VmhTUjA1Ynp3L21rYnQrMFIvRHFPVGZT?=
 =?utf-8?B?RUVRYUJEVDNEMk5BRWR5UnlyT2RINTRoSHhmRDdQM09KR2hJTGFqNG52bGY0?=
 =?utf-8?B?UkttTHlIMzhvWnErcWhUYlYzdWt5U3g1M044Ky9MV0Q0ZkdQd2U2V3F6SEpn?=
 =?utf-8?B?QllnMm1DUHBhK0NZUWdjcjNLWXRKU2FhY1d4MDBYWWs4RUlaVTBqNFFYM0M0?=
 =?utf-8?B?YjdVL2YvM0JvalNVa1hFWXJtWWV4S09WK04rbnFQVStYY1BzUjJQeHQ0VUJa?=
 =?utf-8?B?aWZOVjVRVXF3UGwzL2cwUFZwQjdqS0VHeXJzcGlPTXlkTTU2UE1NMU1wYmx4?=
 =?utf-8?B?cTJpTlBRUlRKWGhGdmdDQWlVTnR0VVlFY1VWOHY1Qmh6aFRBa3FBSytHcHpV?=
 =?utf-8?B?eTkvQmVBTGxjSGROZmhCUE92dEF5MFp5TVBkMVFabzhCbmFkTUNNdjZQTHNQ?=
 =?utf-8?B?bk1mMEs4Vk5WSVIrU2U3U0p6V3BCUXdHUWJKOHB4Umx6OVNCNFVKUTh5NXg5?=
 =?utf-8?B?WUZHNzFhZlRIb0t2TWk3M3RqUVZKQVdGR0s5RDk5R0hxaXZkNnA1eUU3d3hq?=
 =?utf-8?B?UExSRUlrbWVxN2hyVElnSko3bzAwb25EeUFSKzZicStMQm5YUnhuYTZ5NElr?=
 =?utf-8?B?K0NGVEM5cGtZQWlUSTJnMlRrL3dWSjlxRkJFYTFLeCsvQjU0SXh3a3ZoQnZw?=
 =?utf-8?B?NW9uQy94UGRXRjBMZFRBb1MwWHlIUGdxckJQL08ySVpTT3R2bU50cjlLMld0?=
 =?utf-8?B?V2lDT25DdVdTc1Y0SFBCcFBvdm84Q2daSVhPRTNYZ0R4THBtNXE3dGhHNjNZ?=
 =?utf-8?B?TmJLNTUvdVg0ZXhBd3NaUHhIclhVOWpqaDRRdXFQMmpIWE9PNHVtc1hqMGs2?=
 =?utf-8?B?WTlUMCtrdmhYRlRkc2dBTXRvVXBaaXlieXlySE9aZjhndTVyZ0EvUzFJQzlP?=
 =?utf-8?B?RXIzNjJwbWRxcTlUK0pjOGx6SjkwQjJmNVh4elZKaHJkS1dJdUc4OWx1SDNZ?=
 =?utf-8?B?WWtTYWRHeEFha3ZGK2dOZWNyRWFlcUY5Lys5WTJDd052aDhVWVFuLzVxZGVM?=
 =?utf-8?Q?ldeImt+GE2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXNqQWIwTC9CN091ZUh1WFpqVmJReUMyZVU0bm9McnZtQWtFSzF1N3dGZkhN?=
 =?utf-8?B?N21nRTZScU1Qbk1hcEpVRWFtcnBubi9PczIrQU1QdHZyTjZGRmtNL2FKamFT?=
 =?utf-8?B?c3Vnd3paUHVHOStyckwzR081OTVoZlVXbzBBU0ZTMXpDWWM3bC96aVFpZmNq?=
 =?utf-8?B?eUVHOFBrdGU2Nms1WEo5VzJ1ODNOd2MyQjBQN1IzQUk0SjFoWVduLzM0cHVY?=
 =?utf-8?B?Qkxla25ZV2MyaHVOaURIVjRWWFluWk13eTVKeHNwbUcwS2lzTi9VRll3M1kz?=
 =?utf-8?B?S0dzN3VsYXVmeGhHa1NTaXJjTzZDeHRZNlBXMC9lOVR6ZXRlbnFzOUk1enlj?=
 =?utf-8?B?bHE0UUdmZkl5Y1JMZkEvUzBwenV3RWpqOHpGWWk2dFR2TmdDbFhpVW1ONUE1?=
 =?utf-8?B?aTZQRnJjdEY3YWw5cW1TejR1Vy95WTgxSG4ycEdoQmJiNndmbzl6eHJnQmw0?=
 =?utf-8?B?NFVDUjFUMjFrZXV0Y3lJalNLSmdORTNmeHRNRjVIWGJiVDNsS05YaW5lNmVo?=
 =?utf-8?B?TmFoVit4aURvcVNjYUJjclZ2eC9mc1hRaUVTMTMxaWlKZzJmZlgrOERXUmJJ?=
 =?utf-8?B?azdtNFpySWx1S1E1ZCtvRUxwa3hEWWNMSmtOZ2lnazJ1VHdRaUVpMDZNemJM?=
 =?utf-8?B?MDZuMisyaEJUTTlFSkhCcGpETTVGVWFUME85bDkwNjRGc3MwT1pHQ0gwYTh6?=
 =?utf-8?B?bkFhUVpIWUNGUVpXcGY2dXNnb04rWW1GRlBjdlJWTDArOGE3bGRHUVMyMVls?=
 =?utf-8?B?WDNzN3lvZ00yYWxJRFZEMDV2KzBvcnk4R1VMY0VJdTdBMTllRnlTblZPemVV?=
 =?utf-8?B?RFhBQ2hPV3FYbWFPTENXMFE2L0VqaXNweFJFdXlsejNaM1dQSUFjVjFoVmtH?=
 =?utf-8?B?NmhqRjY3QmRPSW9sTHNQd1V1Vk1XdGIzUzN0ME9EY3ZWMlRVQlBrK2RRN1Bi?=
 =?utf-8?B?c25ISUVOQ3VIVzFZeWdJbUw4aFU2b3JsaU1yV2ppYVdqUnBIdE01ZVc0ek9l?=
 =?utf-8?B?NFpSMGg2NkdaVE5TbFMvRjhnNlE0cGVFTDdTNWgycTBQQktoRGZqMnlNL250?=
 =?utf-8?B?clRVdFU5dFFXQ2dCYWdVWFpFSlNVQkkrNElQeEpNckExREorcTl1MTVoTEQ1?=
 =?utf-8?B?TVVQT3dYbitrcmRCanh5dDkxelcvUWZwVmw0OFh1Ym9pYjRMUU5Rd1NGeUVu?=
 =?utf-8?B?QXFNdlRDdFJIdmIwSmlmNlVGZS9RVVRYTkxrT1ZzZHBsc0tQOVNqSm1zVTdV?=
 =?utf-8?B?L0xlWVRUY2g0Y0tjNlpyTEhuQWRXWlBvbktRNkV3bnhBYk15OVhzWEY3elpL?=
 =?utf-8?B?Wk1FYnFsSVJ6NHp2U0E3VmlvMWdhbmk1dW0vUHZ2d2RMbEwvNmFRNXFHYVJZ?=
 =?utf-8?B?RE9CTDR4dHBGZDk0a2tpelBkYVZLYlkvSUxaTEdKVEt2Q2Z5MXRFVGttNm9W?=
 =?utf-8?B?d2xJSXRHcXlyNEw0K0lVUzdja1p2c0dyYzZqMnBxeUhMbFh2Qk9IK1pIYndR?=
 =?utf-8?B?MHNvRTllN0pPRVo0WG9FeElIdG0vSEFXcVE3Q25VM3RJTnpDKzdZZlRTb29W?=
 =?utf-8?B?MHFzaWlwM0hjYmlVRWVTSk9jbkRvK1BydXFWbExOaXdDUEU3SWpxbzJ3bVlT?=
 =?utf-8?B?NE5PaDVQbW9FcTJ4TnB6L2RNR3g1bml6NE9TbHVwYk5OUEs5YkNPa2c5T0NV?=
 =?utf-8?B?VEU1K1hGSG1rTGNWKzYvd21ZUkcxZm5BV2tyWHpVaWxIQ1ZOZCs4K0o0Qnpl?=
 =?utf-8?B?LzlnV3RnNS9yS3lHSG5ES3JTQXBFSTVYM28rTGRIbFFKb2RlZ0c0c2tNaFBS?=
 =?utf-8?B?L2VKN1oxOW9SWUlMNlFKRW40TVFUa2NiL21EbE1CS1RkS0NVbmlZY2RTek85?=
 =?utf-8?B?ckZsN2JHeVUxZlVXaHFEVTI2RUdSQ21YVFhLZW1kTkd5anhKZlN6T29LNDVC?=
 =?utf-8?B?WG1uNmhKTmkwYUpuOHlwOUZKdU5aYm9rYkZhbE9GbzBDMEtad2ttZXo3TDFi?=
 =?utf-8?B?eFVoL0NlQktFS0tEZEdXTFd5ZzkvdUNRelRLa2ozYm52ZFZpNXNHNmlhY1Bk?=
 =?utf-8?B?QzJXUS9BbS9KcjlLVnkya0hKZVluRVYvSjZJY1d3SlVoaVgwMFBQS3JMWkhU?=
 =?utf-8?B?UVlERkRFTFlYMzl2V3U0eWJtNFVBcWdLdzIrSElWSFRqQXhYeDhJdjFXU250?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wWfabj/MlqRGW138qi/7WVhhCt2QeJn07xJURsZXSZcU2FmOF0RV5QLidVAcsKIEI2vRQtlu3BZ5jOmtMxSmG/qqzRsO0cVoLg0DEU+s0isPbDUuxuOq+C7KKj7nQnp26R3Hvhg+oykTzDY945wZV929pEjAzLFil9uyAZ+oX4779yyspCbdpMSjLLFVL6j+1jNp4BtPGr2GDwW1r/QruRdUpfuqyvJHJRlp62rLZS4kMYCMrbbfUZ/oeEqau1TTaHnYbsfKHbmjnBr3+W2Ezp4nVLH78vV8Ne5Itix98c26q1GArDScrC5q0LiaPmdQLgKo40Ke6V5YY+7g52jAKcCPBMZoXI1OWnBbLHhfg3e7IA8bQjO577VQRt5g+1GrQspNq7Cve8ga2HzTPw+XQtnVSGib/2Qi2jVcxbq5x8BDpMsZWLatZiwYLfe8nEG3d+BZW8FOCceb6urIFhyf1lnPL4ZIfdlTA/rD5NTz5CWY+AvfuTk0IaFnWQr56cL7LZnvb0eeTeJYfp0lpHzZqVjMKTbVEiGm7gMzKEYzoQF/SVHjdLmNiTJfdVqOkbEx9+osMskaLYvzIz4zcsDkc+fHT5XRImMtgHGu9EIME7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a60f6-2a87-43f2-ed32-08dd6c8317be
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 16:27:25.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1AYNszTCp6rFh15IIDfn7U3y2DVuu/WUatjMRzIg1ChLU2GM0h8oig75cEs13x2TRHZeV0Mxt0AyG5GKQY8+UOgW131315g8IrHjopSGwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260100
X-Proofpoint-GUID: wucVnnSjhRMo8te9IkiyNsPpkoi73Jd5
X-Proofpoint-ORIG-GUID: wucVnnSjhRMo8te9IkiyNsPpkoi73Jd5

On 3/26/25 11:25AM, Dave Kleikamp wrote:
> The following changes since commit 
> ab68d7eb7b1a64f3f4710da46cc5f93c6c154942:
> 
>    Merge tag 'loongarch-fixes-6.14-1' of git://git.kernel.org/pub/scm/ 
> linux/kernel/git/chenhuacai/linux-loongson (2025-02-13 08:43:46 -0800)
> 
> are available in the Git repository at:
> 
>    git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.14

Of course I notice right after I hit send that this should be for v6.15. 
The tag is still named jfs-6.14 though.

> 
> for you to fetch changes up to a8dfb2168906944ea61acfc87846b816eeab882d:
> 
>    jfs: add index corruption check to DT_GETPAGE() (2025-03-11 11:53:40 
> -0500)
> 
> ----------------------------------------------------------------
> Various bug fixes and cleanups for JFS
> 
> ----------------------------------------------------------------
> Dan Carpenter (1):
>        jfs: Delete a couple tabs in jfs_reconfigure()
> 
> Dave Kleikamp (1):
>        fs/jfs: consolidate sanity checking in dbMount
> 
> Dmitry Antipov (1):
>        jfs: reject on-disk inodes of an unsupported type
> 
> Edward Adam Davis (2):
>        jfs: Prevent copying of nlink with value 0 from disk inode
>        jfs: add sanity check for agwidth in dbMount
> 
> Matthew Wilcox (Oracle) (1):
>        jfs: Remove reference to bh->b_page
> 
> Qasim Ijaz (1):
>        jfs: fix slab-out-of-bounds read in ea_get()
> 
> Rand Deeb (2):
>        fs/jfs: cast inactags to s64 to prevent potential overflow
>        fs/jfs: Prevent integer overflow in AG size calculation
> 
> Roman Smirnov (1):
>        jfs: add index corruption check to DT_GETPAGE()
> 
> Vasiliy Kovalev (2):
>        jfs: add check read-only before txBeginAnon() call
>        jfs: add check read-only before truncation in jfs_truncate_nolock()
> 
> Zhongqiu Han (1):
>        jfs: Fix uninit-value access of imap allocated in the diMount() 
> function
> 
>   fs/jfs/inode.c      |  2 +-
>   fs/jfs/jfs_dmap.c   | 39 ++++++++++++---------------------------
>   fs/jfs/jfs_dtree.c  |  3 ++-
>   fs/jfs/jfs_extent.c | 10 ++++++++++
>   fs/jfs/jfs_imap.c   | 17 +++++++++++++----
>   fs/jfs/super.c      |  6 +++---
>   fs/jfs/xattr.c      | 15 ++++++++++-----
>   7 files changed, 51 insertions(+), 41 deletions(-)


