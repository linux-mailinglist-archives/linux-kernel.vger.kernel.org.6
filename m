Return-Path: <linux-kernel+bounces-438377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049439EA05A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC81F2819CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDD155743;
	Mon,  9 Dec 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ajYDfcx6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t3wy0QD4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C34199EB2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776640; cv=fail; b=iOO+VXHj5a0TejxIxSqbz6XYF8nbRAskq/ODlbbvdJEMUVaQ6P/qZL06stbuFVYgyfO0Ij+RkW4Hb3sPYxmUJiUlaLo4I+caPq20k1iBvnW4RLQkKV8qjgfmswtG7bl2NaKXPlGc4B+/jnycNIZktBDF6svnBhtfYIb8rq/+Xng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776640; c=relaxed/simple;
	bh=gXkioY+JbczprsZM2XCOjkPI/PlZ6AeWmpPFpTD0cMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nTtSPXsqLDjCbqKosAhWDVRYq2xKAwqpZ2h7TDBbdhXOh6B36r2fR4OKHJeU9Q7fGyWFrf7HkgBIHORTMFQpO+KmY8CsmWJAQ1Jehpf2THAPnGiVc+aZiK8F9PodDuWqhBMrb2fiSslhvKY3Q0vfBbnOA8diWWMBKdGzI9tkLeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ajYDfcx6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t3wy0QD4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KMpWx020378;
	Mon, 9 Dec 2024 20:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gXkioY+JbczprsZM2XCOjkPI/PlZ6AeWmpPFpTD0cMY=; b=
	ajYDfcx6dzGpUUmbkArTA+IbGrrLawg51BwPY5RkvFBrk9gJoJABCnjxVrg8reYB
	OCHc4xg3UkKYRsgUb8EcoIk6HuU5W0nM1YL4iyF5Vqn1qemLeRwJqZAbCeBcb0rQ
	yygOuVPjlG3YEKmEXYnPeinpn93Ka1AF+kl0n/8VmaYIW5VsSF6LnOnVVZiRDNLI
	cLjckz/AjtjQeW4O/tiqbQbCDAQrd57onHz0yBr8g8viNjHQvSfoHGjNKAnysTp8
	BaixoRVD5YVmIwko4+9pVoRbBovW2mon6dsJDG4bYqJ4akRl5hHhY3sUfqkV2t4I
	t5yUNuOeIWh8DH8LjKsO2A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr6298q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 20:36:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Ij8IT037990;
	Mon, 9 Dec 2024 20:36:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctdycwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 20:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlIEft/sIcuWqZkz9aLWWB5XWuKG8wzRwoTlb7cHInFVjAtTBCPwdLwKboeZcoE4zDxJH2+hJmzX0HCtnKaHsHntczoTIJUghq0lW6b8dupWlhnJPf6EdQr3vs/l3p1zB0lz4ykmn6JoA1Sci4V8aD9EdVrmhaIZiPf3Tra32CAXcG8/jaTk9s1kF4QfbxszgCQ/reCpllvyDDrlVR3/61MR1pv/w0+2fSbG7XeNVE8iJNFhFW5M1Izdd4UW8o0E7T6hoCUqfGbglmKzA+iAXf8I2pln6bJq1kAUcCb1YbtvzJkX6sSd/Kqwp8SNGAlurCUkOlFLcOqlQ8cZP0VqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXkioY+JbczprsZM2XCOjkPI/PlZ6AeWmpPFpTD0cMY=;
 b=mR2f5Waj+kdEMlnaKf3vO+HSjcY1qnTHD/74Jjowo9a0sF1MBEneHGO+EZefGvxryvzD+H3QWKsKknBu9t8WTc+RfP3fo6vbRYCjwlc0Gz/ztrAmn/DS2JSeN/2ArV/5gxCKqD1BNjbeAWsirL5sWOcA5G1Cbtd04obk11mfiXgXIIVeZyAYjRLWT3NNJLW4HTDa0xXH2fZL2ErBdv7MhAjkdP6ZDKlCF1w6txgZu3XXts1vEo8VenOlCs+V84lbuq+l2gmNWVWgbIQ6Y0iw9pnbOWwHN1TzaiOIvo/MZ+mt8gmtNf4DUBznSdKIYKePva7s7Cd/mkAJ2j5+7KxIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXkioY+JbczprsZM2XCOjkPI/PlZ6AeWmpPFpTD0cMY=;
 b=t3wy0QD4mATK0UucOJroDDbldNwhTjYwu7nmCLwPhbh0tg1a5JkmC1QnHZac+onQx//IZRyv4UvYMkhMAab1ex26hk0rHzF/8pVHD1G8kgR4qfppIIOftuDHPOV62bnXUFIpGRShuQ5mCcoVM3ebGkeRrLSW9s2oOhDqjsbEyts=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by SN7PR10MB6596.namprd10.prod.outlook.com (2603:10b6:806:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.25; Mon, 9 Dec
 2024 20:36:54 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 20:36:54 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Topic: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Index:
 AQHbNV85xP8mG8bGMUONwn7IqXYau7K1jv+AgAANEACAAAlsgIAA77AAgACalICAJ1meAA==
Date: Mon, 9 Dec 2024 20:36:54 +0000
Message-ID: <ADA482EF-F2FF-473A-9585-CD5925FA8BC1@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
 <20241114102834.GM6497@noisy.programming.kicks-ass.net>
 <CF032474-7725-48C1-BA31-A8728C6C06E7@oracle.com>
In-Reply-To: <CF032474-7725-48C1-BA31-A8728C6C06E7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|SN7PR10MB6596:EE_
x-ms-office365-filtering-correlation-id: fd7bfd14-9d7a-4de6-bea7-08dd189137e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVhiUmQxUkZZeFI1Zks5bXFBL3hBdHoramhnaWVhTlpwaEU2WWZMR05kY0tE?=
 =?utf-8?B?RUVlWnM0UEcwd01HYjd1RWdvN2JYME54aks3YlM4MGRoWVlPTVJ0Q0EwV29W?=
 =?utf-8?B?dVVJTHU1bG9COEF6bnJ5ZkRkc0lOS2RxRnh1K05MNU5wRGdaR3pvYTNOSER1?=
 =?utf-8?B?bGpwTGk3ZVBTUU1kZTVadUdnNnlTWlQ0SUpCRHBKZlhpVUs4TlFCL0J0V1dZ?=
 =?utf-8?B?TUU2Mk9JSmx4UnJRclBNdEV3blc3UEpKNGRkSkFGaGEzTXNjeER2K3daa3pI?=
 =?utf-8?B?NVJBby9BQm95WDR0Y1pWcDBVZ2taZzBqSjNIMWowWFJkY1pyOFU0RVFQOE1t?=
 =?utf-8?B?VGRDN2U4eGFJekJ4VmYvSVhTR2ttM0Q4dzZpOGFsWm85K04rVStQZFo2dXVv?=
 =?utf-8?B?L2tVNVNlVVpSRUVYMFZCSlBJc0lBZHVtdkZVeFFGNG9TZ0M0SWpqa1lqd1lG?=
 =?utf-8?B?d1JQanFNZ3BiMy9keGFWa2xVTGsvSmJBZ0phTHlsdDVYYmtvSEwxUWN5bGpl?=
 =?utf-8?B?VDBxY3BTN05iMHhEUlI2WE5YSlB2eERWWnlHQkhzTElGeWpQMWdCRTFsU0xR?=
 =?utf-8?B?TmF2VGV4T1loQUFha1cvam1kMEEvR1JtOUlwZ3lFVWU3ZGdDaHBNb3FRM2Vt?=
 =?utf-8?B?QnBDS3pnZFh0M25oQ2NhMDJ0SHhMR3VCYTdaWThkUmNia3VCZDdCWkhnalAy?=
 =?utf-8?B?cUZ0N25sYm5YZVJLZHpzYk5tVEJRb1BJUmNHbzB1ZHB6SnZTRVhmL2JPTXRE?=
 =?utf-8?B?dXlNWnUyOWlYNXBEOXBPaFdESHl2cHJWMTh2OGtKeHo2YUV4QUlhc09UZGR3?=
 =?utf-8?B?RHVLN2FQMGJ3cFNRQ1l3RkFXSjVKTlpWWFZ1TXFhSWExallHV0JtMVk3OVJK?=
 =?utf-8?B?MDJJc1NpMnpYWGFhQmh4Y2trT0M3UGxkTkJvN1hWQmFtb2RBNGpnem05djht?=
 =?utf-8?B?S09QUll0bXEwRlVhd1ZtOGFjck1hdHNRL2pUS3lWbnpEdXh0VU9ScXBNMGR3?=
 =?utf-8?B?Nk5ULzNvcXpaUFJFRG5yY2c3Wnc1dmRqUnlQWWtlRDB4OFJXa3A4aWl6SEs0?=
 =?utf-8?B?N0krc1hzVHhxR1RiRFFuSlZLeWl5Uk1wSHJCVEE2TWNHT09RNkhranVuakFB?=
 =?utf-8?B?YXpENU4xY0RhUCtrV0F2bnR4Ujg2K2Z3U3Y0YzV1dUFKZWsreFFURHJNTFI2?=
 =?utf-8?B?UmcyK3Z3ZjJFa0xRYnBjZXpTVGlBMjNWQW5odnZpVkhGTkFrMzFFWm5EQ3Jw?=
 =?utf-8?B?Zmk5c1grQVlETHNlNkQrR25lQUVjdDFhV3FROTBDWmpsRFZicUZQOVIvUjlC?=
 =?utf-8?B?SHZsOXNLaGlmeHBDWVpJOXNxK0ZqUkNIZUJsTlpHWEw2Q1VQUWVXQStPSUZP?=
 =?utf-8?B?ck9GcmN0RzRVRGtyeTFNNHFOaXZUekFkbWhLWWtlSzhVQ0Z6bVNmYi9EaGsz?=
 =?utf-8?B?WTZYSERnME92MjlLKytSaXIwL3BmMlJRSlN4YldZaFNaM3F3OEtOZUFzclM1?=
 =?utf-8?B?YzRtTlZYRnlCYVM0aDFLVzcwWTVzcTZvemhoNVBUeExwSGx0K1ZZUU5HVndJ?=
 =?utf-8?B?OGRraFdDbnhhN3BBNWp1cGlacForN2p5OWR6Y3Zxc0drbUtnL1RjOWpVd2pI?=
 =?utf-8?B?VTdtMjUwVSs3dTVTUVhTbWJsQ1djczJpTHFoQld6cklWM1lDZFJnSlkwSXFZ?=
 =?utf-8?B?RFhGOTdmZTVGRzAzdnVXSVE0bEVxVmpNa0dhNGo2ZUFOaEdKeDg1Z2JVb1Ri?=
 =?utf-8?B?V2pqOGZrVDNGRzJUeHpzQzR0bWdlc0hqUlBOL1ViV1pzamt3TzFURVBUQkR6?=
 =?utf-8?B?d0hDR3RJZnpoTmhpUkNjcTlUQmZHNEc3VFpRZmVRMXhLaFViQUowUm1CS2NP?=
 =?utf-8?B?dTl5eHI3MnZueld1RkRib0hkNnJLbWhQMSs0Y1ZpbGQ1Z1EwdjVIL2FzMTJ0?=
 =?utf-8?Q?LX5a400BcSI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDdlaWhIU1FyV3RPaXZ2cnl1R0RoUkQ5NW1XeTdvcSs1Z3RneHdPS2Q1eHp1?=
 =?utf-8?B?Mk5VdW8xTGZKclF0dFIyY3V2aUF0Y3NrZmF6dXFlWmJOQU9hWWttbk9USnkw?=
 =?utf-8?B?Q01zeklZZmszWnp5TzFYS25IUnQxSFcraGRka2Y2RFJsQmxzcUNsc2hlV2lQ?=
 =?utf-8?B?MVhwTXVTc2tBejZwOHdIV25FRk1kY3VxNEVNZXQzcmpiTkx5UVYvWnB5eVlk?=
 =?utf-8?B?U2k1SHNJUHVaNTRnQ1ZXSkJkS20ybWdqVE9BNTV5SFBoWlFyWlh1eFh1Ykdp?=
 =?utf-8?B?T2hydC9idURRZHNhRjgyK3lEY0NkOE5DWDMxY1VZUXc0RWs5UGtVdVIzNHdw?=
 =?utf-8?B?Wm94T0UyVndwdnVFMFhwNjZqM0xJd3pCZzRaRnFiUGFTb3pLNDN3VXdua0Rh?=
 =?utf-8?B?ODM1RDdITnNSWGxYNXNwdjdVWTZ6bnM2eTB1OTNQZFR0cmpjL0Q3MDZURkxU?=
 =?utf-8?B?eXFDUTNPbE9Nc0loaTgycFJUYlZUd3lXSDFQamxVclNDSDZieGNMcjVsS1o3?=
 =?utf-8?B?MHlYbUxBMmhMKzEwQlhBNFhyUFlQVWtvdFVsMHdaaEFnZDdELzh6dU9XVEVD?=
 =?utf-8?B?aHZvRldMSGRRV3E5TU5ydDdNMWZ5Q1k2dzRIakpoUHZsbitFeHMwSGR0cjVZ?=
 =?utf-8?B?K2RQRU80OGJpY1RKd3lDL3RpQkNOck9CdWV6NWpsaEc5V3NCMmpSdkd0QjVh?=
 =?utf-8?B?NzNPdVFYVWRYWitmM0RzRWtWblErUUhUVmR5dCs2em8xZDNxQ3pnQUtqOHp3?=
 =?utf-8?B?SU1sMVJtcUM1aDhlRlpjQXgzais4MkJhaVFSSVJQYy9XN0ZNdWp6bkF0cFUz?=
 =?utf-8?B?SjN2SkRETFIxK3d6ZlFSVmE1c1dkL3NhWHNlUlVlSDF4NEVLckJRUTBxTTdN?=
 =?utf-8?B?VjI3cCtwaGY5UE94Sm9hMzNDWGhqU3AzOW4vcDB5b2k0TjNuVUIxZ0lrTGw2?=
 =?utf-8?B?UU0xR0cySk1RVE9PRk5FY1BHc05McmVZM0FkQUd1K0oxek1WdWpMNlBCOE1T?=
 =?utf-8?B?OU1IZ2VkcnNWWHRWSlRsUU16SnJHQUdPRmcvaWtEOEJqSzZYUjdZcytXU2lJ?=
 =?utf-8?B?S0lpWmprRFRqNGJJbzJHOWRIODBsRHNxK2xncys2Rk9hV0hUV0hVQmcvN1Zh?=
 =?utf-8?B?VWJjWUhTaTVkalpTRTBFK3MxU2VseXNxYm9tTmZVV0NuMHlKSlhpNkNpTlc2?=
 =?utf-8?B?aDdNYzJZVTI5VklKTlB5K0tVTkd4MC9mOW1uZ0xqb0c5NE5CUVBUcFFNOXVi?=
 =?utf-8?B?Q1pzYkVNdm4rd1hpSW5ha01JVUppOEkrZEVLYXpQa0E0QnpjejZHek5mbFFW?=
 =?utf-8?B?Wkc2ZGx1dXk3Y2hncGRLay82TVRRbGtxMjFITFpoOVVrcU5XS1pnODhxaUZq?=
 =?utf-8?B?d25rQ3pTS2I1WjlmdUp5L2NOSk1rK29zYTA5U2lKNkN6eGhsUUxkUEQ3TzFD?=
 =?utf-8?B?ZTJRTm1CMllSNFpOLzluUVVUZzlXWXVvK1YweVRSU0hpcTZXejB4MkNRM20x?=
 =?utf-8?B?N3RuNURaL3dWaWFJK3NCTEJVZTZHdmNWaGFsWHVrYnpaaXlaeDVFMTMrcENt?=
 =?utf-8?B?ajBsSjBkZlpmV24zdTUzdG9BaHEvUlVCNnpPMkl1Q2hGR3AyZDlnWTVaTlkr?=
 =?utf-8?B?REsyQ2tsK0IveGhZcTdFN2FXdmthdU5JZjJYOGxsaFBxamZ6ZlRBeWxzWWMz?=
 =?utf-8?B?RmFmeTBNMm9QTmpzR29Od3RFcGIxdzhFTGVULzk4MlFWNkxDZkNIeS8yTGhR?=
 =?utf-8?B?Q2NUN0p6Y1NwMnB2ZFlhbkFYeUI0Z3h3Rm9BL3d2Tko5WXZ0MmVmWEVmbUcw?=
 =?utf-8?B?WW1OaHF3T0Jlc1VvVDh5cElEOEhMNUd5ZzdscVF5M01remZnYTlzZm5UNGx6?=
 =?utf-8?B?OHppdDhTN1NlQlIvK1VidUxCUDEyZGxvcXhHejlsVjhyOEhwTVZLeHpOZDN3?=
 =?utf-8?B?eVdzU1FPUklVeHorQVNGTnFUVFV6WEFhZVEzY21LNnNUQ055M0c2bGpwM1R0?=
 =?utf-8?B?VG5KYXI4NjU1MGgyOW5XUkx5QlZMVXVvOUxxNDFUaTZ5TzZCL1hJOHZkc3ZD?=
 =?utf-8?B?Q1R1dWJobnY5ZHlNZzNreE1uTUtpL0NKUzBCYUMxRGp1UFg2WmtBQzJnQVc1?=
 =?utf-8?B?Vjd2YlUyMTNlTUNLRjBhRzJYd2RqQm52a25JSXUzRGNrNnRXc2dGSHl3VWUz?=
 =?utf-8?Q?CpqPYZbiJq1fvuCbtxxMsyZJlbFyVB8CiINrFbQ12Saq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <404AB65447A20B40B9603754C39AE0BD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NqWRO6e/7uyzDKHnU0/kNd/VDbNAVzBbHoNKpP0z79EmqGiAhlwl/kEUET5GR2OCOjlEo4/g0bMTJrqTeTZumosfhXfCHVtD5YhqHYmJr1EEg7ZaSlWoSzs6WwDVkPcDZSawJUN3B4Q+IgT1pakeB5vyJuvZ2C3rtDlX93TiwhYKIIpMkIc/hv49fnUmP528R5nqhv9W+Zr/G9hsnhnOwK9IVRK104LPkoO/sAaH+t53iVmYBtP0GsyxXhMP2qKbYT04i2tqdMLdaTBXH8oZ7wathrCOuYbQs8eyUzrdmSeyxt/vZvejO5a9gPbj/KFksPiBfg98q3oiix6NHOKv44iTpanrIIiJMbGqS0MnM9lrtILmL7/fpN8AFvOvJLWZfkfEdUqkSMXRVcSBDZgMTENjmDXjDUFbgzFPm5m5MLKpFFKvksoQebeXF2aZQyCb+fXCGjdgIFCOTUq9K+n4wiSC5dsr+zd915jL8NukUvn1sdjp5UhLonkdDYSXSnlqGBcF5DQ6nVxbOYrk0y5YlS78uvvfE+JGChmatIN6GVn5tYw6LT9uhup2g446sBAynuufng+kEEhNKeCLDJgBWJijDYGhNXzRrd40dwP4u6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7bfd14-9d7a-4de6-bea7-08dd189137e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 20:36:54.2969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9G/i7/ihmvBLqItq8Hc3lAoMR7yigedLfRGt3V7mlyBzPXbbOazUqB3vSZ5iQ5k8z7Z4J0sOynecf83zPHqDblHmhZK1s0lNyBdwgkNsqYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_17,2024-12-09_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090159
X-Proofpoint-GUID: 6WKCMxD2rw5FjU4YgjLJDRmiNorUU-w8
X-Proofpoint-ORIG-GUID: 6WKCMxD2rw5FjU4YgjLJDRmiNorUU-w8

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCAxMTo0MeKAr0FNLCBQcmFrYXNoIFNhbmdhcHBhIDxw
cmFrYXNoLnNhbmdhcHBhQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gTm92
IDE0LCAyMDI0LCBhdCAyOjI44oCvQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFk
Lm9yZz4gd3JvdGU6DQo+PiANCj4+IE9uIFdlZCwgTm92IDEzLCAyMDI0IGF0IDA4OjEwOjUyUE0g
KzAwMDAsIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4+IE9uIE5vdiAx
MywgMjAyNCwgYXQgMTE6MzbigK9BTSwgTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiAyMDI0LTExLTEzIDEzOjUw
LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+Pj4+IE9uIFdlZCwgTm92IDEzLCAyMDI0IGF0IDEy
OjAxOjIyQU0gKzAwMDAsIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+Pj4+Pj4gVGhpcyBwYXRj
aCBzZXQgaW1wbGVtZW50cyB0aGUgYWJvdmUgbWVudGlvbmVkIDUwdXMgZXh0ZW5zaW9uIHRpbWUg
YXMgcG9zdGVkDQo+Pj4+Pj4gYnkgUGV0ZXIuIEJ1dCBpbnN0ZWFkIG9mIHVzaW5nIHJlc3RhcnRh
YmxlIHNlcXVlbmNlcyBhcyBBUEkgdG8gc2V0IHRoZSBmbGFnDQo+Pj4+Pj4gdG8gcmVxdWVzdCB0
aGUgZXh0ZW5zaW9uLCB0aGlzIHBhdGNoIHByb3Bvc2VzIGEgbmV3IEFQSSB3aXRoIHVzZSBvZiBh
IHBlcg0KPj4+Pj4+IHRocmVhZCBzaGFyZWQgc3RydWN0dXJlIGltcGxlbWVudGF0aW9uIGRlc2Ny
aWJlZCBiZWxvdy4gVGhpcyBzaGFyZWQgc3RydWN0dXJlDQo+Pj4+Pj4gaXMgYWNjZXNzaWJsZSBp
biBib3RoIHVzZXJzIHBhY2UgYW5kIGtlcm5lbC4gVGhlIHVzZXIgdGhyZWFkIHdpbGwgc2V0IHRo
ZQ0KPj4+Pj4+IGZsYWcgaW4gdGhpcyBzaGFyZWQgc3RydWN0dXJlIHRvIHJlcXVlc3QgZXhlY3V0
aW9uIHRpbWUgZXh0ZW5zaW9uLg0KPj4+Pj4gQnV0IHdoeSAtLSB3ZSBhbHJlYWR5IGhhdmUgcnNl
cSwgZ2xpYmMgdXNlcyBpdCBieSBkZWZhdWx0LiBXaHkgYWRkIHlldA0KPj4+Pj4gYW5vdGhlciB0
aGluZz8NCj4+Pj4gDQo+Pj4+IEluZGVlZCwgd2hhdCBJJ20gbm90IHNlZWluZyBpbiB0aGlzIFJG
QyBwYXRjaCBzZXJpZXMgY292ZXIgbGV0dGVyIGlzIGFuDQo+Pj4+IGV4cGxhbmF0aW9uIHRoYXQg
anVzdGlmaWVzIGFkZGluZyB5ZXQgYW5vdGhlciBwZXItdGhyZWFkIG1lbW9yeSBhcmVhDQo+Pj4+
IHNoYXJlZCBiZXR3ZWVuIGtlcm5lbCBhbmQgdXNlcnNwYWNlIHdoZW4gd2UgaGF2ZSBleHRlbnNp
YmxlIHJzZXENCj4+Pj4gYWxyZWFkeS4NCj4+PiANCj4+PiBJdCBtYWlubHkgcHJvdmlkZXMgcGlu
bmVkIG1lbW9yeSwgY2FuIGJlIHVzZWZ1bCBmb3IgIGZ1dHVyZSB1c2UgY2FzZXMNCj4+PiB3aGVy
ZSB1cGRhdGluZyB1c2VyIG1lbW9yeSBpbiBrZXJuZWwgY29udGV4dCBjYW4gYmUgZmFzdCBvciBu
ZWVkcyB0bw0KPj4+IGF2b2lkIHBhZ2VmYXVsdHMuDQo+PiANCj4+ICdtaWdodCBiZSB1c2VmdWwn
IGl0IG5vdCBnb29kIGVub3VnaCBhIGp1c3RpZmljYXRpb24uIEFsc28sIEkgZG9uJ3QNCj4+IHRo
aW5rIHlvdSBhY3R1YWxseSBuZWVkIHRoaXMuDQo+IA0KPiBXaWxsIGdldCBiYWNrIHdpdGggZGF0
YWJhc2UgYmVuY2htYXJrIHJlc3VsdHMgdXNpbmcgcnNlcSBBUEkgZm9yIHNjaGVkdWxlciB0aW1l
IGV4dGVuc2lvbi4NCg0KU29ycnkgYWJvdXQgdGhlIGRlbGF5IGluIHJlc3BvbnNlLg0KDQpIZXJl
IGFyZSB0aGUgZGF0YWJhc2Ugc3dpbmdiZW5jaCBudW1iZXJzICAgLSBpbmNsdWRlcyByZXN1bHRz
IHdpdGggdXNlIG9mIHJzZXEgQVBJLg0KDQpUZXN0IHJlc3VsdHM6DQo9PT09PT09PT0NClRlc3Qg
c3lzdGVtIDIgc29ja2V0IEFNRCBHZW5vYQ0KDQogCVN3aW5nYmVuY2ggLSBzdGFuZGFyZCBkYXRh
YmFzZSBiZW5jaG1hcmsgDQoJCUNhY2hlZChkYXRhYmFzZSBmaWxlcyBvbiB0bXBmcykgcnVuLCB3
aXRoIDEwMDAgY2xpZW50cy4NCg0KCQlCYXNlbGluZShXaXRob3V0IFNjaGVkIHRpbWUgZXh0ZW5z
aW9uKTogIDk5SyBTUUwgZXhlYy9zZWMNCg0KCQlXaXRoIFNjaGVkIHRpbWUgZXh0ZW5zaW9uOiAN
CgkJCQlTaGFyZWQgc3RydWN0dXJlIEFQSSB1c2U6IAkJMTUzSyBTUUwgZXhlYy9zZWMgIChQcmV2
aW91c2x5IHJlcG9ydGVkKQ0KCQkJNTUlIGltcHJvdmVtZW50IGluIHRocm91Z2hwdXQuDQoNCgkJ
CQlSZXN0YXJ0YWJsZSBzZXF1ZW5jZXMgQVBJIHVzZToJMTQ3SyBTUUwgZXhlYy9zZWMNCiAJCQk0
OCUgaW1wcm92ZW1lbnQgaW4gdGhyb3VnaHB1dA0KDQpXaGlsZSBib3RoIHNob3cgZ29vZCBwZXJm
b3JtYW5jZSBiZW5lZml0IHdpdGggc2NoZWR1bGVyIHRpbWUgZXh0ZW5zaW9uLA0KdGhlcmUgaXMg
YSA3JSBkaWZmZXJlbmNlIGluIHRocm91Z2hwdXQgYmV0d2VlbiBTaGFyZWQgc3RydWN0dXJlICYg
UmVzdGFydGFibGUgc2VxdWVuY2VzIEFQSS4gDQpVc2Ugb2Ygc2hhcmVkIHN0cnVjdHVyZSBpcyBm
YXN0ZXIuDQoNCg0KDQo+IA0KPj4gDQo+PiBTZWU6DQo+PiANCj4+IGh0dHBzOi8vbGttbC5rZXJu
ZWwub3JnL3IvMjAyMjAxMTMyMzM5NDAuMzYwODQ0MC00LXBvc2tAZ29vZ2xlLmNvbQ0KPj4gDQo+
PiBmb3IgYSBtb3JlIGVsYWJvcmF0ZSBzY2hlbWUuDQo+PiANCj4+Pj4gUGV0ZXIsIHdhcyB0aGVy
ZSBhbnl0aGluZyBmdW5kYW1lbnRhbGx5IHdyb25nIHdpdGggeW91ciBhcHByb2FjaCBiYXNlZA0K
Pj4+PiBvbiByc2VxID8gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMTAzMDEzMjk0
OS5HQTM4MTIzQG5vaXN5LnByb2dyYW1taW5nLmtpY2tzLWFzcy5uZXQNCj4+Pj4gDQo+Pj4+IFRo
ZSBtYWluIHRoaW5nIEkgd29uZGVyIGlzIHdoZXRoZXIgbG9hZGluZyB0aGUgcnNlcSBkZWxheSBy
ZXNjaGVkIGZsYWcNCj4+Pj4gb24gcmV0dXJuIHRvIHVzZXJzcGFjZSBpcyB0b28gbGF0ZSBpbiB5
b3VyIHBhdGNoLiBBbHNvLCBJJ20gbm90IHN1cmUgaXQgaXMNCj4+Pj4gcmVhbGlzdGljIHRvIHJl
cXVpcmUgdGhhdCBubyBzeXN0ZW0gY2FsbHMgc2hvdWxkIGJlIGRvbmUgd2l0aGluIHRpbWUgZXh0
ZW5zaW9uDQo+Pj4+IHNsaWNlLiBJZiB3ZSBoYXZlIHRoaXMgc2NlbmFyaW86DQo+Pj4gDQo+Pj4g
SSBhbSBhbHNvIG5vdCBzdXJlIGlmIHdlIG5lZWQgdG8gcHJldmVudCBzeXN0ZW0gY2FsbHMgaW4g
dGhpcyBzY2VuYXJpby4gDQo+Pj4gV2FzIHRoYXQgcmVzdHJpY3Rpb24gbWFpbmx5IGJlY2F1c2Ug
b2YgcmVzdGFydGFibGUgc2VxdWVuY2UgQVBJIGltcGxlbWVudHMgaXQ/DQo+PiANCj4+IE5vLCB0
aGUgd2hvbGUgcHJlbWlzZSBvZiBkZWxheWluZyByZXNjaGVkIHdhcyBiZWNhdXNlIHBlb3BsZSB0
aGluayB0aGF0DQo+PiBzeXNjYWxscyBhcmUgdG9vIHNsb3cuIElmIHlvdSBkbyBub3QgdGhpbmsg
dGhpcywgdGhlbiB5b3Ugc2hvdWxkbid0IGJlDQo+PiB1c2luZyB0aGlzLg0KPiANCj4gQWdyZWUu
DQo+IA0KPiBUaGFua3MsDQo+IC1QcmFrYXNoDQoNCg0K

