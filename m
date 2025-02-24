Return-Path: <linux-kernel+bounces-530056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1CA42E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C1189D7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8526280C;
	Mon, 24 Feb 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eXHhWFno";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H2edesJP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083E25E47D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429984; cv=fail; b=oGaHpxgg6m2D2AnLluntKx5eVecsmyK8WoxGpN8gk6i/H9GwrR3hEg0nuR5eKM/brJw6qqGomQ3Ms4IUFocl9hMVHWlDYXJXHfuD86BQ6/BAOWZi1MwyBVxHOGi5BjycCv8h8GTpxA+V5Uwv2FhusD2WzqblnRLcy8xiiR98nhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429984; c=relaxed/simple;
	bh=nxz8xE2KGTg4evCB1UCNdLxbZLOy8WyEkzJuhrqemoM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GrjxcFCkZvSlh6dB7PlY0hGTBmpBNerRQe7ehg74ddUba0kUHBmV/opVtV+aRSLif4vRxwOIvvclZeJPNWjIzwTJDZNpdRZKwYXY9oATtc93B+7DF7LrDtBPzAaNXiHF3iX6suC1NvKlWOxX0fD23ByKsN8cdWVOnsrh8WOUTo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eXHhWFno; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H2edesJP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKffVc002939;
	Mon, 24 Feb 2025 20:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R+6kJWFKyBGmnXsTwzHdGQTwxodoPyn5ojzSd8CyN8I=; b=
	eXHhWFno1QSUjsnFFz5lpkshEeW6v3+vpwHyu2mBsqwHVA0707X794d2JmV6pQo/
	vaPGHnhzXVsmK6SLHKxr1xADKdTxIg1nVpWSg6sEec1sdB4QaGmecdWoYSm3lx0w
	/V9YWFTPKgE+zzR8pUz1VH27PSXzvGaGmZFzHS6Fq80+HeQU77pREyv/c2dRUSpm
	ttumQgcSuzpBCVMHQkSYrMvkPzlz2HmubXFcKodIZEFNmfpZJ3G1X0bv0504uElK
	6SaARDXrBkhJeGtKFh0yrIRnTzCnM/Dl+WlEu7ibvtPQvZTv77/WarC91L/QKYYj
	WfxJnITT3XIsEsyrIeQ4HA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t3hy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 20:46:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKLQFJ012590;
	Mon, 24 Feb 2025 20:45:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y519gabt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 20:45:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5lCNTqPXRVgYgiKmB378KQpieUTqD5i8bFT+2qYu7Vw5dcMnxuwhhr94uGrWTPSNjEJpp/lJfqW7rIselKWuETUtvx7oqwq5L2/7jqbV6Xm1BYS14L3/9peiyZ1BMFOTxxYWlh1L/b1AZ0sORKSpgCS2NsRCgxHGMuOZ8mjJS+YBmtkF1ZVPVUJM86qa1cw+zliDKh8BR+udymTvJYkqLHKLg9UNk83Mh0XfUFOQZojSRJdVXsHWDdOANywuGHSHzkjImbJt/REqcMCMC+oJiE6jXQElr5ejSJEENiTPwjnqcBkri24FsYgRegFJXAkJyFgc3DUvqIBU0mn7tZ/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+6kJWFKyBGmnXsTwzHdGQTwxodoPyn5ojzSd8CyN8I=;
 b=xoTDK0tlWWBZG1PQOF2Nrha3RxDBI5ump2ypAlpq7XuwUYYcKZpCWtbqNpvmoiL0uKD9Rv8zV9MrfYv91FhXL8OrUTx+c+7lUgSUKC1SPxU5FJBhygoo1qzhsI983spNszCv1xJeFYITrvqWfSaBRyCzCRPB5CNA3y1hYyXDHxRCqHx5btA1TM5HnuMWVpoQlQZV0E9vR41IuW5VHte9aAzyS3LYLTpXbss+uInYiYOAlBY3CORRE0dPql+FCdGMIi5BwflhmmSQhLufAZeR1PxUmueszGnaD5Eih4NnpsuyJmmWeLt+Fd2REffZbC+fJFhCAyxE2Wg5R8TcHg4F6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+6kJWFKyBGmnXsTwzHdGQTwxodoPyn5ojzSd8CyN8I=;
 b=H2edesJPWtRwmnW6E9agKHdtGlaMLRQMONzdTxBzZKnA4/sC7Kh0f5o8vGH9KrVF3OPhNBgK3k4rdN+7dBc/fF8NjhFcrH+oXmHWsLCDD1yKte806cW3raXJ4KTZW/u4gYWejwNcrWpfykzuFr+Q2T4ozrCMnh1lmxVRUzK6lKk=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 20:45:53 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:45:53 +0000
Message-ID: <2e8c5dc2-ac07-4042-a218-1dcc68a96290@oracle.com>
Date: Mon, 24 Feb 2025 12:45:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: make page_mapped_in_vma() hugetlb walk aware
From: jane.chu@oracle.com
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linmiaohe@huawei.com,
        kirill.shutemov@linux.intel.com, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com
References: <20250121041849.3393237-1-jane.chu@oracle.com>
 <Z48p2oK1AfRLYmDQ@casper.infradead.org>
 <b1245ac1-4dab-443d-97e8-cee583235547@oracle.com>
Content-Language: en-US
In-Reply-To: <b1245ac1-4dab-443d-97e8-cee583235547@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:408:f8::9) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|SJ0PR10MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0ec443-a9e6-4205-0878-08dd55143afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk42WUZuTDNFNzR5bXhTelVSWVliQlpjRVBYL0JIQXNDbERBazJSWDZaYW9K?=
 =?utf-8?B?R0U4R1IxWjhGRVZuY0x0eTB5dDRZdjEwalJEWUJHU1dLUVRuUFFVN2psa3ph?=
 =?utf-8?B?SE1ERExuZnFiblVjQURmOUtGUTN2ZVJKOWIwMmpSSVMxVzloK2h3UlBQVi8r?=
 =?utf-8?B?bFFQL2VVdER1T1ZIbEk4TGtmVFhHYmdXSjBRQmdmVnlnUnlrS1c3UkxXbkhE?=
 =?utf-8?B?ZnFjTmN1SnM1NGhHU1l3RXdMQzNMeU02eGNHT1dEWFdBd2lRRmtUcUhVRHhF?=
 =?utf-8?B?RkY1N2gxa3B5N0M3TnduVzltMVpCaEo5a3N2M294dXBObGJYYmk5QjEreHda?=
 =?utf-8?B?Y3Q5amJBZHE3KzhZeEVDcmg3UmJDWWE0clZUVmFteDdRMU1nb3Q2NWF4NXdt?=
 =?utf-8?B?Z0txWnNPWUVHWFdkMnpvZVZnRE9vdjI3c1dFM2FJNmdYemtqK3dvNkluMUM1?=
 =?utf-8?B?ODZoZ2dZcWhPVlZLM2N5VHhmd0xPajBZL29yUCtRMFJKZ3N2cWZObUVJM2h3?=
 =?utf-8?B?U0d5NHljRnJBMXNab3hKSWVqcVAzc29lTWNPc1RHU2NjT0tYS01KbWlsMkZF?=
 =?utf-8?B?am9GVlYzK29KY25oUVNRaFFOdXZtalpGSFMvbGtKOWVzc0ZBK3E2bG5EUkpw?=
 =?utf-8?B?eldDNGQxZ3ljaUlHLzIvNXFKdEJZM1I3SHlRbmhKNHIyenRvTis1NXNQUFJN?=
 =?utf-8?B?YXFSY2tCVWRpY1YzdXlISDBDT3pQZGQzQ29VbDhrdnE1SWdOMTIwd0VidDU5?=
 =?utf-8?B?b3lhYnhCa2VrcGtyZzVPSDcxS1ROMXl2L2ZhTVd2b1kyVWdQVUhKSDZwOXJ2?=
 =?utf-8?B?bnJ3a1d3N0lTU3Vta1VYaTF5ZFJvYTFpUTVBTVcvZjVUVCtQcGFlbWpRWEQ0?=
 =?utf-8?B?SHJFaDR5ekNHRTZMSTVoRWg0UUYwcWhKQTRqcExLSWpBMWFUSllwOHpLQlNL?=
 =?utf-8?B?WFA4Ukk3NmthcVFWR1JZM2hlSlk5cUUwZ056c1RVbUllVnNxZCtqelhqTTQz?=
 =?utf-8?B?V0piN1ZTN3RZclNiSXFxSldQdkRVNElFYmZRcmlGS0tOM21aK3BqaVd1dkFX?=
 =?utf-8?B?NGJvbGxoc25aeEpVQ3MyaFBJVnVkVE1CNzFFL1B6ZjhNeW1RWjZVVysrOTRz?=
 =?utf-8?B?TndQR1JmRzdnZjkrOGNFUW1tQ2N6ZjRMdkdwUFdGbUJLUnpWbFdnR0t4bGxz?=
 =?utf-8?B?SkwySmt4dUtMT3hybGxLQTZrMUtWaVUwV1BZd0R5ck5lZ1JlVEFtM05NSnFD?=
 =?utf-8?B?WVpIV0VwMjBFbUxPTzYxUjZYRGozUmVUdnhxcFIyY2NaUGVhU1B2dDA1b2p1?=
 =?utf-8?B?SktKai9tNWtPdU1vQUhvYzRIa0Ixb0tvL08vdlFyNXQvbDFEK1dJcVZNQUxD?=
 =?utf-8?B?bDQ0aUprREVCQWZPbDd5b2Mxc2Z3YUNyeUxnZGJVY0JzWEtDZVNLZThYRGFm?=
 =?utf-8?B?M29wTlR6Zm9weWxGN1dsalBFUXg3dVVOU3Y5K2I5YlRhalZmK29ETTFqd01U?=
 =?utf-8?B?RVo1VHNJZjVRbTVLWER0UXRmbndtYkxqNnAvSzF1WkMwKzNXK1RKUmZORmdC?=
 =?utf-8?B?c0lvTFNNM3pZUXlsOThFdjZ5UFd0SW5lYnpsd0xyb0ZVUkgrMUVwekl4dHZh?=
 =?utf-8?B?RWNhdzQvS2FXaVVEN1JJUVVYNkJxSVZaUXBET29oWmgvUjRjbkVxSTF0TGJk?=
 =?utf-8?B?Rks4K0gyd0M1NnhGTGl0NkFabDlEbHhQNTFVdG5aRjAzQ1gydzlPZ24zOTBS?=
 =?utf-8?B?WFhtalRWWis3dm0yTEN1dm9TK0llNlovRldybUtRc2ViRjJrSjZwejZxSHpi?=
 =?utf-8?B?eXdHQW1ab1p1dmowT2FwdHMwNlVnbTJnR3E0cTU3UkhiTE9pekJIcFlBUzhK?=
 =?utf-8?Q?wHLnkP3DhmAya?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlhEYlB3VE1Hak1ZaTBVM1RlQTdWdWtxM0xDdDhVMDJIRkRoSytQMHBQazNl?=
 =?utf-8?B?Q1Bsd3RmRTVXeWNOR0VWbjJKVkRKSWhJTTdJMzJTZVE0S1g0eTVIOXM1cXZr?=
 =?utf-8?B?anEzUDUzaVR0K0psSDhLS2szL1ZvbHJRN3o2bzE0NVdNY2JUNzNaWGdpSit1?=
 =?utf-8?B?NjFRMTdYczRsZktsWnErcHJxem5uOW9CWE1yM0JXT0hOa2MycnM2a2JNWkIw?=
 =?utf-8?B?c09aemNDY2UxaTkxOHJIdThjWHJMbE9RNFpicTQ4U0xGNHFtNUpoQ2ZHazJX?=
 =?utf-8?B?Z05IcTJXQ2lFUkNZMk8rWFh5ZytOWWF2VVJzM3JndEhNSXhiTFR5SndONW1O?=
 =?utf-8?B?bGtoWXRHeHRLSVlTblZXWGR0RjVvZGNnaTMrcXlIU1RjSEZjZ3l4KzJ3ZzVy?=
 =?utf-8?B?d0hUZjFDeE5nVS80a0V4amlubjU2R0xEaHQ0UUQ3SEtXQ2xQUDBaOEVjRjBx?=
 =?utf-8?B?aUVSeFZhOFU4TjZ1UDgzK01uNVljZkhTTVVDMUswNVhlaHY2b01aSmFZV1N3?=
 =?utf-8?B?dG4zOEF0R2t3Rk5HcVNySUVZYndCeVhaWUw4Z1RRdnhEN01CNTJpemJwM1Nr?=
 =?utf-8?B?Tm9LMjJudi93ZU5wSWVPbnd4ZUsvMWdPR01nVGRWd21PN1VISCtmSzF2YmRi?=
 =?utf-8?B?a0wxWjduSUtDZGp3eFR1bGhsMU54U2ZlY3A1L2pSVHU1NDdPTjJQb1paNG9p?=
 =?utf-8?B?Vm5oWW9EaUNqSmlVbStIWVMwbEFxVkROVWYyU1NTM01meklQbVc0MXVBT2Qv?=
 =?utf-8?B?YXJ6UklGMHhnR0NQNkZSVjR3bE0vN1NVRzBCK1IwRFpPTWJaWmZqZ3FSQ1Mw?=
 =?utf-8?B?bDFzQWhFeEJ4UEYyK3dpNXpLTXFvTEFtNml2aG5MS2p1LzZGdTdpZ2JuckxU?=
 =?utf-8?B?bUhOMDFzMnZtdFp5TU5jMUlZSUtaUVMyRnlmVGVXNmxEc2VDSWs4MzE5R3Jz?=
 =?utf-8?B?RWVQWTJHZG0xM0F3MlhaZGs5QWRJTlBnR2JhZDFBZ2xMcW8wTDJ3Q1ZxZERU?=
 =?utf-8?B?MGF4WDZmVHhKUE56Wnl3aURtL0dSdlptWDlVQldBZkx1RkQraUl5OG9WVnFs?=
 =?utf-8?B?bzZNTXJHZ0hNeC9qOFcxRnkxbURXNFNUT1pJWmJqWVBWNXNWQW9EMFV5L3Ro?=
 =?utf-8?B?bUlxMXRyTlRZMVNVOXJIV0hzTUMrVU9qeVB5NmI1aWowdDQrK1J1TXNTU2k4?=
 =?utf-8?B?NGNjbjNVanU4N202WGtDUkVqMUdLZWlZWjhFcDZ0WmlJSXVYUzBqaG55N0tC?=
 =?utf-8?B?YWZ4NHAyVHJOR3ZIV0dJaDl0eVVRTmJTc3RTeWh4UWRnV0Q2MW5kLytFem16?=
 =?utf-8?B?NDBCVCtpMFNsdzFUMmhZS3NaZERieGRJTVBRUy81MUJYbzJ0bnYrbWhNK082?=
 =?utf-8?B?dGgxdmFFd3IyOWM0U2Q2TUxiemwzUkFkZTRFTFVTSWMvSFRqOGZISnBLOVZm?=
 =?utf-8?B?QisvWWVBRTJQdllMM0NzeHQxODBKd0tqNmlvbkNwdkhpNGpidW1iemlLdVZz?=
 =?utf-8?B?Z1UzUGw2WEVnejJpNU8rZ1J3anRvT0k4dUR1SUdMNy8yN2pmWUpDMVhCL1hS?=
 =?utf-8?B?ejB5UnM5UzBicTU2aW5MRHRmWExkSEVicG5JdHpvT25rSXhXeThBbEdybTBH?=
 =?utf-8?B?OTlSOUFjRnhxRDYrQVM5Uk5KR1U5dmhCV2tET3pFZlltdFN0b1F4d0puNGRQ?=
 =?utf-8?B?a3N2M0syUmRia1JYdVBibGtJTG02VXZaUjErOFUzajk5LzV6eStGN0NMRTc3?=
 =?utf-8?B?ckRFVGlCSzlGcUZRRkRDUmNTRUtXeVU5aWErMUJHU2J2ZFNmeTU0dzVWR1Iv?=
 =?utf-8?B?WTZPd00rTFlQU011SG1MTjhuNXJYQk4yTis1em1aRkhWaThKWThQSlo2OGZm?=
 =?utf-8?B?SmVSNjBDb0FzQS85blJSdzFkSlQ3c1JnK3kyNEZmcWJTNXlBN0o1b3VIZUVB?=
 =?utf-8?B?R3dCbFAza1JGRTliU1BuTkZyaSs4amdJRmZsb2NIN0V0V2xTLy95bDhTWGoy?=
 =?utf-8?B?SGxSczU2b3JMZExlRTVITXJsMlNpMnRTK25wdStqR2MrSk05QVp1TDR5c2Zw?=
 =?utf-8?B?YmxXeFd5am12dlFEY1RxTjRsWWR1aDJEbkFiMVFCRHNKZWVSZkI4Z2ZrSkFY?=
 =?utf-8?Q?4iQ/BWXsAQ9prF43TY2g/vzHd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X8XZDawDxbQ8JS5dCoyDdM0WoFjrB6ZiNnLY2ERzpPSKTha06LE+AauffTYEgoM1NVZL92GKIg68MtfaX0c05jFgK4w7qw335qcyI0fnrWX+hIKJEo+Mvau2BvPcrzuYgSkhtSOT9nUGlwK4RDHQrKJCoYVRdvqVRQc9+nx+OEyhqDv8qM3GPQ/TsOtrcdQg1mp5QO8jt3TS2HBpzJhglQBJFDD0z8G/oOCEyfctXHQNujZvIf4oe24/22D3cxdRt+mh7p2sgcoSegfBvmj9CAnTE2yRcH9KdEZcj3gosiZtlXNrsIzVw8N7WEqsVlPiEHx8Cj2R4/ZFVN2sn+WEHBxElrtTNsLqJ6PjX3ZaPp1UdrdaFA0VQzH7tMfaZyt9iSAxC+extcLAv43RoqlaKXWfrTC8ctn+7yIaF4tdSe8wk4erdcrYRZkGJ6sL3PGmQC0joxIxe4SzsFQsIgur5XMTE/1/CJ5nVtwpB+PAIx2yK0+q+/TbPn9Qn9YcIPp5CZtrww129BBzCO7TqYBjjcPC79FeJ6S0tw/2N4fyanAw5tQjXVA7dqeEZCLx97BKDS+pS3T4DzwcNQ1hBBoy1MtQYlc3CTcsRIh2RYRHnhA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0ec443-a9e6-4205-0878-08dd55143afc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:45:53.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: De+mcdGwUZNQeeoROamB+jSKAXfXk5nbzXW951TL5cquVm6p0vdoPrO3bJHIW/r8DNctcz+kVpm1flcYWbrd3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240132
X-Proofpoint-GUID: bwzjWlnpVeWGHlaC7g_EBq7YTaZjU5AK
X-Proofpoint-ORIG-GUID: bwzjWlnpVeWGHlaC7g_EBq7YTaZjU5AK

An update below. Also, add Peter.

On 1/20/2025 9:20 PM, jane.chu@oracle.com wrote:
> Thanks for the quick comment!
>
> On 1/20/2025 9:00 PM, Matthew Wilcox wrote:
>> On Mon, Jan 20, 2025 at 09:18:49PM -0700, Jane Chu wrote:
>>> When a process consumes a UE in a page, the memory failure handler
>>> attempts to collect information for a potential SIGBUS.
>>> If the page is an anonymous page, page_mapped_in_vma(page, vma) is
>>> invoked in order to
>>>    1. retrieve the vaddr from the process' address space,
>>>    2. verify that the vaddr is indeed mapped to the poisoned page,
>>> where 'page' is the precise small page with UE.
>>>
>>> It's been observed that when injecting poison to a non-head subpage
>>> of an anonymous hugetlb page, no SIGBUS show up; while injecting to
>>> the head page produces a SIGBUS. The casue is that, though 
>>> hugetlb_walk()
>>> returns a valid pmd entry (on x86), but check_pte() detects mismatch
>>> between the head page per the pmd and the input subpage. Thus the vaddr
>>> is considered not mapped to the subpage and the process is not 
>>> collected
>>> for SIGBUS purpose.  This is the calling stack
>>>        collect_procs_anon
>>>          page_mapped_in_vma
>>>            page_vma_mapped_walk
>>>              hugetlb_walk
>>>                huge_pte_lock
>>>                  check_pte
>>>
>>> It seems that the most obvious place to fix the issue is by making
>>> page_mapped_in_vma() hugetlb walk aware. The precise subpage in the
>>> input is useful in providing PAGE_SIZE granularity vaddr.
>> I don't like this solution because it adds yet another special case for
>> hugetlb.  If we don't split a PMD-mapped THP, we'd have the same
>> problem, right?
>>
>> check_pte() would succeed if we set pvmw->pfn to folio_pfn() and
>> pvmw->nr_pages to folio_nr_pages(), right?  I just don't know what else
>> might be affected by that.
>>
>> I like one of these two options:
>>
>> @@ -206,6 +206,7 @@ bool page_vma_mapped_walk(struct 
>> page_vma_mapped_walk *pvmw)
>>                  pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
>>                  if (!pvmw->pte)
>>                          return false;
>> +               pvmw->pte += pvmw->address & (size - PAGE_SIZE);
>>
>>                  pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
>>                  if (!check_pte(pvmw))
>>
>> (that needs a bit of tidying up; you can't just do that, but I think
>> you get the basic idea -- correct the pte to point to the precise page
>> instead of the hugetlb pfn)
> That'll work, let me think about how to tidy it up.  More below.

It appears that check_pte() is supposed to be able to check range 
overlap for leaf pte among other things.

But the currently implementation doesn't do that.  Fixing this takes 
care of the subject issue.

More below.

>>
>>
>> The option I really prefer is much more work but matches our preferred
>> direction of getting rid of hugetlb specific code.  Something like this:
>>
>> @@ -192,27 +192,6 @@ bool page_vma_mapped_walk(struct 
>> page_vma_mapped_walk *pvmw)
>>          if (pvmw->pmd && !pvmw->pte)
>>                  return not_found(pvmw);
>>
>> -       if (unlikely(is_vm_hugetlb_page(vma))) {
>> -               struct hstate *hstate = hstate_vma(vma);
>> -               unsigned long size = huge_page_size(hstate);
>> -               /* The only possible mapping was handled on last 
>> iteration */
>> [...]
>> -               pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
>> -               if (!check_pte(pvmw))
>> -                       return not_found(pvmw);
>> -               return true;
>> -       }
>> -
>>          end = vma_address_end(pvmw);
>>          if (pvmw->pte)
>>                  goto next_pte;
>> @@ -229,7 +208,19 @@ bool page_vma_mapped_walk(struct 
>> page_vma_mapped_walk *pvmw                        continue;
>>                  }
>>                  pud = pud_offset(p4d, pvmw->address);
>> -               if (!pud_present(*pud)) {
>> +               pude = *pud;
>> +               if (pud_trans_huge(pude) ||
>> +                   (pud_present(pude) && pud_devmap(pude))) {
>> +                       pvmw->ptl = pud_lock(mm, pvmw->pud);
>> +                       ...
>> +                       if (likely(pud_trans_huge(pude) || 
>> pud_devmap(pude))) {
>> +                               if (pvmw->flags & PVMW_MIGRATION)
>> +                                       return not_found(pvmw);
>> +                               if (!check_pud(pud_pfn(pude), pvmw))
>> +                                       return not_found(pvmw);
>> +                               return true;
>> +                       }
>> +               } else if (!pud_present(pude)) {
>>                          step_forward(pvmw, PUD_SIZE);
>>                          continue;
>>                  }
>>
>> ie get rid of all the hugetlb-specific code, and add support for the
>> PUD level to the common code.  You'd also need to write check_pud().
> Good idea!  I'd like to give this more generic approach a try as well.

I ran a simple experiment on page_vma_mapped_walk() checking on a PMD 
level hugetlb page but with the hugetlb{} logic commented out.

The experiment includes both test/move_pages and the memory poison 
tests, and the latter hit a NULL pointer deref. in try_to_unmap_one()  
that I am looking into.

Besides, there are broader things to consider, such as pxd_trans_huge() 
are defined under CONFIG_TRANSPARENT_HUGEPAGE that doesn't apply to 
hugetlb.  Mabybe try pxd_leaf()? but they're not the same thing, does 
the  difference matter?

Hugetlb doesn't use pxd_lock(), it has its own locking though after 
peeling off the wrappers appear to be  the similar thing, but not quite 
the same thing.

There are also the hugetlb unique PMD sharing and implied locking 
requirement.

Maybe there are more as I dig further, it's becoming more like a project 
on its own which I will update on a separate thread in future.

Thanks,

-jane

>>
>> I'll understand if you don't want to do all the extra work.  And
>> thanks for tracking down this bug.
>
> Thanks a lot!
>
> -jane
>
>

