Return-Path: <linux-kernel+bounces-398874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD69BF773
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB22AB25184
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7618820EA56;
	Wed,  6 Nov 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gzmiZk4e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="prFidhcQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3720EA4C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922032; cv=fail; b=klf1FuH4LFD8BYcnTT7947g7Y2Nr5ApT5up1Z9HRurTX5rLdCB3f7EWWK3BMtLkBBi1g9mYvY9TGJxOscduCG+oenwbmc/tyyR2wAjt8u39FLnPRYmG/jB1ceLKppxopS5WuEEPAslnuTWA1W1Jc0gmjU+H3hfU2jo21hGEWfxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922032; c=relaxed/simple;
	bh=dcRnurHeD4RyGX+ao34Rg9IoQD41T+r8b57I0cgHu6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D3UpjiDM1DfJE7fkqA2OzE/Wg6wOFcGEu/7QiIp7+g+wquWHsbE4eB5Uia7QZvvXwKQOnvFjkllAgQHhFXVfhTd495d37snkmFeUiNVzMHlojrs9Wixtv5ROtBOrGiJqlxugbktMfXdDuIeAmA4Bb5DwXg+3KMHFad0Ityw+/O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gzmiZk4e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=prFidhcQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXbKL017396;
	Wed, 6 Nov 2024 19:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dcRnurHeD4RyGX+ao34Rg9IoQD41T+r8b57I0cgHu6I=; b=
	gzmiZk4edvSK9ySfrf00LowOTTbTsBCT3hIx4YSxaY/oiQXGbkBmFO1K445QL3ej
	VBnRbqZaKbeQ1O+so7cbbcaoBfY7BhOX3p5caXBahRUqxIWZu/v2dV57DACPbXto
	8HFOlfxBjZCEeBXUE7/lTgBf8V30gJ+aEuXgixQcVilWnOCrAnytrC9gKFATWhjT
	jC/gq7YPBlCFwg3SM+4BUACP7E+PFc3/ttV3qh952FR6+pUjipZ+AQ9S2HcVPtMq
	L8RxbK2rnuc+iClNsJ6J7hRKNOFFup86bKDwgJYF3dOvqka4ZtXP85oTkeyrO99Z
	dutx0ME5j0WenNbGn7+aSQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap00yud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 19:40:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6IYp9U036289;
	Wed, 6 Nov 2024 19:40:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahfaj49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 19:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChjkQse1XRyDkCdVEJizl6eg/zLV5U3cgalcauaTP31G0axwYWm5Jn/wf7G+1rrcE2rGJ0u4oX+BJUfvmNDw+vXcmpygePaoS0YA7SXuzkhZgKA+zWjp7nwH1SEgvt8BWZF3sRpaJcPtkJfa6GCj5cBR97VMBHZ+15FuqgvgQAlho4R/57O827qLMkyNp14p63XqaWdbXKlaQaw8Mzd4nt8TO9TO3/s9m8vgDcWQCXaT/CZZL6O1AbFkzayCJc4X44F2zaPRTJ2xeSEKPJ5uLJGqREPS8OhYaEO2Ut4SuLUtSuD4GkokBeDkwtIP0R4SYTMRtmT3rJl9x9nNMaxRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcRnurHeD4RyGX+ao34Rg9IoQD41T+r8b57I0cgHu6I=;
 b=efp9lQ2pSRQFg/ndxrV6i6jtv3ybeTIibsey8wyWwsXV+/uM4nsjcjeppiYWh2mxyV1HP9qbBdmGQ07v1n4N07XhF4/mQrnSTVZ6F7v53AJlaJ7e3pAV8CThIrltS+jE5pdiYs33JPPR4tHQo55255PckjYExGHbJA1Qt3SISui2pfY2YczUn8GHJ3XcUxZ6XOgK3or11LlwSw+HZPq4Ug0Eg4tRpjj+USwsHVQcxf2ubEzaoGMcOE1m04mWb339oWVFWFPYY06aoXkRUY6rSio9VCB4kKJBUOHcMliupyzgxtvf5dWnkCNDH1xA+qS9ym3ckFrEppsBI35teWrgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcRnurHeD4RyGX+ao34Rg9IoQD41T+r8b57I0cgHu6I=;
 b=prFidhcQp9EtCmn5S3RNHwXuEwU+8wb7QRhXVx6tNQG0e69p+pafhRWj/SaYaBcGvm0joZtHsLAzMB94h4e10G5twGIBgWxeJHIbsc0jslteogtnB4RU8L0DsYNjyc1tBkpsMfg2Nq7Rm43PwWz2gXFdcUZULPoAATCeXLv20ck=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by CH3PR10MB7908.namprd10.prod.outlook.com (2603:10b6:610:1d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 19:40:17 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 19:40:17 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rudi Horn
	<rudi.horn@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Jeff Xu
	<jeffxu@chromium.org>
Subject: Re: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Topic: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Index: AQHbMHpuH5Uv1vq1UUi4UXxKBpQkarKqosSAgAADoIA=
Date: Wed, 6 Nov 2024 19:40:17 +0000
Message-ID: <9BA465A2-905D-4D0E-87A6-AB89C28A7B4F@oracle.com>
References: <4225E088-6D34-421A-91AA-E3C4A6517EB7@oracle.com>
 <4d484280-3bed-453f-b2f6-0619df4e9914@intel.com>
In-Reply-To: <4d484280-3bed-453f-b2f6-0619df4e9914@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|CH3PR10MB7908:EE_
x-ms-office365-filtering-correlation-id: c11de8b8-7427-4c4b-9ead-08dcfe9ad74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVpobUlkb2dyTDdWVWwycmlyVmtUZVlMb214cnE5aUw4R3cza2tjcTFySU84?=
 =?utf-8?B?aXZyMHp1N0Z1MFpMakJzcW83YnRORk5DK2tDUUxvYmZTY2RNMGxGZEpGNU9Z?=
 =?utf-8?B?dVUxb0EzWDhqYnpKa0x5RWNXYm51NEI2aVdSMkdNWnRicTR5Uk5rOHd1RjBD?=
 =?utf-8?B?Unh0MXFrMGVaa1M1MjArSmp0NzhQMmRXd1FPRmVCUU1HRmdiN0RRSkpNdkNU?=
 =?utf-8?B?S0Y0ZmdoZHlZeCtRQ0NVSU1mMTV1Yit1Rnl3VmVBd0FaeExBMFp6cVBDakkw?=
 =?utf-8?B?cC9qNjg0MVFtNXNDMnhtM0J5WFY4NUZNR2FmdUJyU1djN0h4U1BIV3RCdHJ1?=
 =?utf-8?B?eHZKc1FiQ3dJNVFyWHNxdUFVZVhROW5WWDh2ZTFZY2toSWlZdXlzNnN1NEt1?=
 =?utf-8?B?QTcwcm9UQ2g2bWJnVDlmZDUybDYzY3gyU1hMa0U5cDlST3BybEFObVR2YWZO?=
 =?utf-8?B?WXJSdHh1TGh4ZmowQkcyc2tWc0I0VVJ5Y21qMFpSQ0tqajVJaCtSMEd1SFVk?=
 =?utf-8?B?T2h4WUkxQlZ3dHFpTFRKMkxzREl3blJKdUgvb2tLWHlQeVNvNUdpTGtNaWFD?=
 =?utf-8?B?L0MrQmJqUWFzSG9sQ09XRzRLTDB3UHdua2kwWXltZlRPalBTM3hGbmd6VmYr?=
 =?utf-8?B?N0swSm9jUEhjWm41bzhSRHRIbFh3YmN2MzREWmw0dVJMRzk1WER1cXE2ejAx?=
 =?utf-8?B?bnE5RGk3aHk0Y1BENksxWDZma1VjVnRNK2IxdjRPT09TYjI0Y3NIbTFTTGUr?=
 =?utf-8?B?ak1uMzBUbk9MQVRBeHpkV0s4QlMzaXdub1B5Sjk1VEp3TytJbzg5SUJRYnZY?=
 =?utf-8?B?NE1uL29IRk5ZNmVyNDZFVFZlR2ZDSEs1Sys1ZGNDem1mbUVZcnZtT3A0NHJT?=
 =?utf-8?B?KzNSNjFhT3BYWGFKUm5YYk11TlJBWWtjU0crRC9CcllNcXFISlc2dEVUbDRU?=
 =?utf-8?B?aHZ6WDhxVC9OQXBCSVVQWE5pbnpiQXlmaURBUUtYT0xnNlU0OE1KWWJCUk16?=
 =?utf-8?B?NXdqMHo2SDhZejFrNmUyd0VRc244U2hsYmV0MnpNc3FUOXpOQlY5RFVsanZw?=
 =?utf-8?B?RlFlcFVqMysrMXZqOVRGYjAzZHRIMG5vTFgzSVN4a2NJWWZGcjhCV1Q4UlB6?=
 =?utf-8?B?VXBQM0c3cWpTMDRuOTNqV0ljb3VMbXNMTHo3Mk5Sb2d2Rm54Z1o1c3RRNkZw?=
 =?utf-8?B?dGxwbEZST0NsaUx3WnREME0xVTZDc3NuUWZOV0hXMzBvSU1iV3VCbmx1ekha?=
 =?utf-8?B?bFJSdWM1QnRYWTYzbVIrM2wrQ2t5VWtvRjVzVmEwVHl3RFkvYlc3bVZhTGFa?=
 =?utf-8?B?R1FiWHdrbHFLb29HREVXeTJ1a2pCNy9HN0lwQ2pWYW1pWXVjV0J2aTBGNTAw?=
 =?utf-8?B?MWtmZUtqeitOT0JwelFpMk5XS1lHYngyS1JncFFoNEJoaHZ6c2VFbHZPRWlW?=
 =?utf-8?B?Y0F0RGYxdVZ1Z0VJck94bE42cVFBaTI5TjdNOE1GQWRoUDI2cTg5N3RzczA0?=
 =?utf-8?B?WGNzNVRlRk1NSE1sa2xGVVdIMVJ4d0dxVUNkTVFJZjRSWDRzSDVGd0pkUmZE?=
 =?utf-8?B?SkR6aWJTWkVNYy9zaWxnbFk4bi9Za3ljOGZjMXJDUFJrQXM2bjRuQXV4bGh0?=
 =?utf-8?B?a1ZlY1ViUjE5UlpBMDR4TjNaZ3h3VE9oZGsxcFBvUlhXQmhzd09aNER6b2dC?=
 =?utf-8?B?VVR0MDBoSHdISEJaM2N0dm1sYTM1VFoxRGZxWnAxSTU4TysyZlVpaXNHOFR4?=
 =?utf-8?B?MStKRXIyNWN6YmtIbStKSkZXNTNDWkFyRnFxWWFONVdhZWZDOSs4ZDJ6TnFQ?=
 =?utf-8?Q?vdb2q+LH51vA1CWcApLiNzvYJuoUHeUkNbLRU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2hyZENvSE41dkJiZWdVRWlKTUFQN0VSWXN6WnNUQ2ZvTW5ES29xUEtUSDFa?=
 =?utf-8?B?MjVCWVBBSlFnd0ZSOTVhVmhOcExnaUh3TFJsTC9ZOUdra0FTc3pCQ0x2bFAv?=
 =?utf-8?B?MXM5QVFKSGREdHpCTXNaZi9kUVhZQlpGTGRPRytHaVBjZTkvd1BtQUhrTFpr?=
 =?utf-8?B?NFNzSzlvTmxzNmppUDgzQWpYTGNBS0ZKWTJXc01xaG1ZWk0vVFN0R1ZheVJJ?=
 =?utf-8?B?RWQ3WWtPUTlxK1hvS2xLMW4wa1FPOHFzMDRCN0ZkSGZDZXhoanBibVhhTytQ?=
 =?utf-8?B?ZDZudnFScWtBaGVYYUozMkUrK1dWYm1sR3RxN3pnRFoyWW9GMmw4cVY5VjBK?=
 =?utf-8?B?dGxCeFNESzZIeDcxckZqQ3gweTBrWVFyUitFZC96ampxNVJYc0RjYmJYVjhz?=
 =?utf-8?B?dTBKTTY2ZlZ2bXJ0ZFZLVkJvU1FaWlNWNDNjWXdGMDAyS09rTEZwMHNvYm1w?=
 =?utf-8?B?SHZONnBTa3pWRHc0bmxieGRxL3AwbHAwYkY5MW50MEoxL3poUE1icGgvUHlr?=
 =?utf-8?B?WVIxOFJkRThsaHpoRTdVU3ZEQXZyYlFiOG00SFBpazZPMEdnYnhlTW1xTk1C?=
 =?utf-8?B?Y3hLcmZCNUd1bnduZzdyWTFuSnpnRkJ2d3pMbW9zNSttOXBmOFhLdTRHWU9v?=
 =?utf-8?B?blJMNUFGNi8yVkZzaUFIWFdNLzhKRHdBK2NWYnU2RmM1RktZR2lvaThDQWxS?=
 =?utf-8?B?dDBORlZ0OHcxa0ZhTUxZS2pkU01Md0hCV2N1L05MMUZYZHE5VjIyU0VzVDFt?=
 =?utf-8?B?bCtEUG13K3VnRWRiWWhwb1h3V245Y3BaOVdMMWRmUStMSlFNK2hKVy9JYzk3?=
 =?utf-8?B?N01wcEZ3SzNaWmI2bWVvZG1MNllqMVpKelVKVHd5WHI4N1lUTEd2TmZOdDNx?=
 =?utf-8?B?bkNCZ0lvK1JPb0R0U2JpNjBKT2YxQmFsUjcyRWZVc3R2VG5xV1kzNUJqdXhs?=
 =?utf-8?B?Rk1PUUNoMjRCUjdNRytQZGR3NTdnTkpNMW5LVFVlMzVZQTlMSWpkM3NlUXBZ?=
 =?utf-8?B?M1dGclYrOHA2MlNUeVBSZTZ0Z1Jsc1J0MXlMUTltRmZkb3ZnTGkrTXo5L0ZF?=
 =?utf-8?B?Q2VtT1lsV1F1TnlUaXFkb1gyZVJjME5BL1owdnUzMkdSakx4TW5jRTFRdnpj?=
 =?utf-8?B?R3V1ZXRpNFpCb0poNk0zaU1nSG5LYlJ6OUFoaml2emtkNkVBdmxaVmd4VEZo?=
 =?utf-8?B?MDZiWDl1ZzlIL2cwWjhUbTNPTytscmgrOVcrbWJJMTNrMVUxeHRvc2xVak92?=
 =?utf-8?B?bDJyUUpRM0dmY3RsczRiUlp0Yk9wMjB5OStYQk1qK0tsNVZBald3UFFsQXgr?=
 =?utf-8?B?ZXhlY2xFY3FhUkFWUkRmN0RaZzdSQVB3UzhMTWxNWVFCbDV4U3hTK3BkRDRP?=
 =?utf-8?B?dFp2ellZZDIyUWVoSnUwSUNxL0w1aVN1QWczS1VzTWd5bzkydjAxRzg1QXdM?=
 =?utf-8?B?KzBhbE5aMW5zWGRrTlJLV1g0U0MxREd0STlscjFxbWJqT2NXSVlVelppMzVK?=
 =?utf-8?B?MFFWaG1QV2ZGV2pKRzlqMmpRUHIxNEtGa00vL0NCamxZenVoZGNWMWJpdk1O?=
 =?utf-8?B?QkxmWCtsSGJoM0VJVWIrVWY3MmUvb2tTSnRDZVlpTldJdkQvSEpuUWMycmJn?=
 =?utf-8?B?aGFTVVdIY1ZUN1ZwYnJ0TGJPVTYrbm9vVzlaVU9YaXpzNTJVd1pDQ0p1eXVn?=
 =?utf-8?B?Z2tDNFYzeU1KQTBIQjA1eUJZTU1ISjdhQ1dzQjdDT3NaL2pMOHFPNzh0TTJN?=
 =?utf-8?B?cmhlblVEQ3BNZUhIbXJmR1BHL2VNc0hnODB5R1RXakZrZjBkdDZjbXY5d0V5?=
 =?utf-8?B?R1FLSStoVldTYi94Tm9kTGVlVTdTWlZ1S1RtS3gzRWxaS2ZwcFdxbFdUaTZS?=
 =?utf-8?B?NXZ2OWQzU3dqNHBNeUtOVktRRjVWL3pUUy9ZYTJmaUZYZEU5V1NuVVliMy8r?=
 =?utf-8?B?UE4zZ2JhdjNoam5UOHZUL2FuUTR5M3ZOZTd1WUxEeExwK2psN3I2cjFHaEty?=
 =?utf-8?B?eVNNaE1qMFNQdjV5bk5lOXJaRFRsTk43Vm5iclNFdFRnK0Zvc25IckJpY2Ny?=
 =?utf-8?B?MnNHdEVuSDBOaEZwenFmeGtTTEJIYTJEek5hTEJORnk4MWxraEVoNXJQZkxh?=
 =?utf-8?B?OS8vKzEybWtZMXM1dVU4T0RvZTdWeUMvbkdVNHlqZDVVM2loQmtQamtDUTFY?=
 =?utf-8?Q?B7xz76AepEttEDmtw33EHSZKdm9kb12kUPDz9SConIlJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E94E26719097140AEA35198B3748EF7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3rKh+oiZ0RKMprHrBLcg5X5OIV42V3RJVZr9a9n6PmFEXKikgJrT9SO29n1mPi3j+PWuRA3WFcNppxv4yrj2LNxR7BDRCJs7F0dEgoCShaQYdO9WVhfMhGSqPPoqLGkSIUw/T4LntcPlSJ69Z2dLMUUaf8j9nkWzAV+yLVuKzMRVVleikKWONiTTnMSVhVve3Dv5eImEYBCkMPngAs+CLT/C6AqbEjeF1ZfurAQKbrobHJpEiJUhZf2gYcUnzs3p+8Z1vfY9kqjBtZRTHKluQlYqKFgdrufP6biFuqg2DdtyFCL2vzaMbRuu/WLVvdgLEEjs9Cgw/twqO+RuTcXC4cSJqAPDfSbyCLfLSJYcepnK2KbT2hCV5ZxGe5lT9zikMOFdNsWrWlWqon+MzrlCyhSB5Jfa9nz2smo4fV8RBmh808rPX6BoBnHJpPVenQ009QHEbaiiLiYqWPIrJ9BMY7ZSfwhUwL3z/dCp7sqahyTUJgNhDlp3pwMKOSD7ScMlbIsKvh0ZevnUo4EE3yaLSkPGgX6ML4Tbo/nENZ2op+4X0Y0LdQ/iNbX18vOxm0X3DyQaA0vy1ySO4XiDEsGhT5R8LdMIzRIBC3gK7v5KLoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11de8b8-7427-4c4b-9ead-08dcfe9ad74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 19:40:17.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bY11VzpFdu121c73VRq0zoaxbRkd6gkP3rBNrWF1ngZetu0qz+P7fBx8aar02nWRL59jF08OW4yrnZ1qvnJND9muMAMePJv8fc3Q4p8d0gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411060150
X-Proofpoint-ORIG-GUID: fRPboeJ-_mXfDp506jP6wsEcJbN2yzsz
X-Proofpoint-GUID: fRPboeJ-_mXfDp506jP6wsEcJbN2yzsz

DQo+IE9uIE5vdiA2LCAyMDI0LCBhdCAxMToyN+KAr0FNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDExLzYvMjQgMTA6MzMsIEFydW5hIFJhbWFr
cmlzaG5hIHdyb3RlOg0KPj4gc3RhdGljIGlubGluZSBpbnQgdXBkYXRlX3BrcnVfaW5fc2lnZnJh
bWUoc3RydWN0IHhyZWdzX3N0YXRlIF9fdXNlciAqYnVmLCB1MzIgcGtydSkNCj4+IHsNCj4+ICsg
ICAgICAgaW50IGVyciA9IDA7DQo+PiArDQo+PiAgICAgICAgaWYgKHVubGlrZWx5KCFjcHVfZmVh
dHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX09TUEtFKSkpDQo+PiAgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4+IC0gICAgICAgcmV0dXJuIF9fcHV0X3VzZXIocGtydSwgKHVuc2lnbmVkIGludCBf
X3VzZXIgKilnZXRfeHNhdmVfYWRkcl91c2VyKGJ1ZiwgWEZFQVRVUkVfUEtSVSkpOw0KPiANCj4g
TGV0IG1lIHRyeSB0byBzdW1tYXJpemUgdGhhdCB3aG9sZSBlbWFpbDoNCj4gDQo+IFRoZSBleGlz
dGluZyBjb2RlIHVwZGF0ZXMgdGhlIFBLUlUgdmFsdWUgaW4gdGhlIFhTQVZFIGJ1ZmZlci4gIEJ1
dCBpdA0KPiBkb2VzIG5vdCB1cGRhdGUgLT54ZmVhdHVyZXNbUEtSVV0uICBJZiAtPnhmZWF0dXJl
c1tQS1JVXT09MCwgdGhlbiBYUlNUT1INCj4gd2lsbCBpZ25vcmUgdGhlIGRhdGEgdGhhdCBfX3B1
dF91c2VyKCkgcHV0IGluIHBsYWNlLg0KPiANCj4gSG93IGRvZXMgLT54ZmVhdHVyZXNbUEtSVV0g
ZW5kIHVwIHNldCB0byAwPyAgT24gQU1ELCBhIFdSUEtSVSgwKSBzZXRzDQo+IFBLUlU9MCAqYW5k
KiBYSU5VU0VbUEtSVV09MC4gIEludGVsIGRvZXNuJ3QgZG8gdGhhdC4gIEVpdGhlciBiZWhhdmlv
ciBpcw0KPiBhcmNoaXRlY3R1cmFsbHkgcGVybWl0dGVkLg0KPiANCj4gRGlkIEkgbWlzcyBhbnl0
aGluZz8NCg0KTm9wZSwgdGhpcyBpcyBjb3JyZWN0Lg0KDQo+IA0KPiBCdXQgdGhlIHN1Z2dlc3Rl
ZCBmaXggaXMganVzdCBiZXlvbmQgaGlkZW91cy4gIENhbid0IHdlIGp1c3QgdXNlIHRoZQ0KPiBt
YXNrIHRoYXQgeHNhdmVfdG9fdXNlcl9zaWdmcmFtZSgpIGdlbmVyYXRlZCBpbnN0ZWFkIG9mIHJl
YWRpbmcgaXQgYmFjaw0KPiBvdXQgb2YgdXNlcnNwYWNlIHRocmVlIHNlY29uZHMgYWZ0ZXIgaXQg
aXMgd3JpdHRlbj8NCj4gDQo+IHN0YXRpYyBpbmxpbmUgaW50IHVwZGF0ZV9wa3J1X2luX3NpZ2Zy
YW1lKC4uLiwgdTMyIG1hc2spDQo+IHsNCj4gdTMyIHhpbnVzZTsNCj4gaW50IGVycjsNCj4gDQo+
ICAgICAgICBpZiAodW5saWtlbHkoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfT1NQ
S0UpKSkNCj4gICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiAvKiBFbnN1cmUgWFJTVE9S
IHBpY2tzIHVwIHRoZSBuZXcgUEtSVSB2YWx1ZSBmcm9tIHRoZSBidWZmZXI6ICovDQo+IHhpbnVz
ZSA9IChtYXNrICYgeGZlYXR1cmVzX2luX3VzZSgpKSB8IFhGRUFUVVJFX01BU0tfUEtSVTsNCj4g
DQo+IGVyciA9ICBfX3B1dF91c2VyKHhpbnVzZSwgJmJ1Zi0+aGVhZGVyLnhmZWF0dXJlcyk7DQo+
IGlmIChlcnIpDQo+IHJldHVybiBlcnI7DQo+IA0KPiAgICAgICAgcmV0dXJuIC4uLiBleGlzdGlu
ZyBjb2RlIGhlcmU7DQo+IH0NCg0KQWgsIEkgbWlzc2VkIHhmZWF0dXJlc19pbl91c2UoKS4gVGhp
cyBpcyBhIGJldHRlciBpbXBsZW1lbnRhdGlvbi4NCg0KPiANCj4gVGhpcyBwcm9iYWJseSBtZWFu
cyBtb3ZpbmcgdXBkYXRlX3BrcnVfaW5fc2lnZnJhbWUoKSB0byB0aGUgZW5kIG9mDQo+IHhzYXZl
X3RvX3VzZXJfc2lnZnJhbWUoKSBpbnN0ZWFkIG9mIGNhbGxpbmcgaXQgYWZ0ZXIsIHRob3VnaC4N
Cj4gDQoNCkkgZG8gbm90IHVuZGVyc3RhbmQgd2h5IGl0IGhhcyB0byBiZSBtb3ZlZC4gV291bGQg
eW91IG1pbmQgZXhwbGFpbmluZz8NCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLCBJ4oCZ
bGwgcmVkbyB0aGUgcGF0Y2ggYW5kIHRlc3QgYWdhaW4uDQoNClRoYW5rcywNCkFydW5hDQoNCj4g
QnV0IGVpdGhlciB3YXksIHRoaXMgaXMgYWxsIGhvcnJpZmljLiAgSXQncyB5ZXQgYW5vdGhlciBy
ZWFzb24gdGhhdCB0aGUNCj4gWFNBVkUgYXJjaGl0ZWN0dXJlIGNvbXBsZXhpdHkgaHVydHMgbW9y
ZSB0aGFuIGl0IGhlbHBzLiAgV2Ugd2FudCBQS1JVDQo+IHdyaXR0ZW4gb3V0IGhlcmUsIGRhbW1p
dC4gIFdlIHNob3VsZG4ndCBoYXZlIHRvIGFzayB0aGUgaGFyZHdhcmUgdG8NCj4gd3JpdGUgaXQg
b3V0LCBhbmQgX3RoZW5fIGdvIGJhY2sgYW5kIGRvIGl0IG91cnNlbHZlcy4NCg0KDQoNCg0K

