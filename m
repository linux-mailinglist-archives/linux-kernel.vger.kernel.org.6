Return-Path: <linux-kernel+bounces-372304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825C9A46EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B418B1F20F09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9DB204F68;
	Fri, 18 Oct 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fgfGMy8Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hio+QPNr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F216204096
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279220; cv=fail; b=GH8s89iTcL4N+afN0CZNb0VH+Oo/6dPv4jvG8WSp+FXuEZDN+xgpUTe7vTnkfKp4+SQr3WJHa2c7f8eYsEziAYt6B+0zs5bM/ph67dUmOB/oO7fF/1VHioTS4eTQ9aXX6mDaQSixAqKx3Z4ORNWq2e6iZTG4fAZx3LPSnKz0wOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279220; c=relaxed/simple;
	bh=UtvLsNRenbgfqsYwlJWcapTQkU1YQEUmtwZPljxdCvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f/0DwLcJHzMRGvROlaPvtle5rw3ixT5jwVj0XGxEQJWWIsWKaghY/oxp4s24sTCP3zexzypWMqpmEBdpHO35pZxOdRKLgMsbECn9yHgpFRZVhVkOeic3mYcHTTQcmBzcVXVE1AajLqYSUNdIn07eOHHX6/TISe+ZyvTWv6cZ0ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fgfGMy8Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hio+QPNr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IIfjU5004541;
	Fri, 18 Oct 2024 19:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=D/GT8KLY+M5gUTSkSIj4n0tWnOGdlYCenq32m3M8jx0=; b=
	fgfGMy8Zm5OHL4+Li6BUcUrdrBJxKk7vtsOe2KMka9gBR6MGPelCdUDp+piGWq8m
	IJhnBXHWlAHK55vFD27NFU/HahDmLNLHvkJ5lSL7sEUcCN0C8B2dS/FZG44237PB
	igfZCQLaA2VLbUhR4b73oGOShMDjoUwbHzRormUKT4kO+SWm/qngwYFE8kvc21v9
	DN137YWBoS9octWhNCji5wGhAbV/nrQHsiYZh0kZlUKvnKsCZ4MiLeSzP8Q0BaTr
	6v6eOQlpr0xEnLaef+aqHy3j2KAlLMT38xfbh8ORj/0GIbCnu4qxr17Lv/rPhy2g
	P6P/wijCsCSdM02syFJZ4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcs6cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 19:19:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IIh8B5026224;
	Fri, 18 Oct 2024 19:19:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbyvnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 19:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5WX+xahAIouC5+kUNpXDBV6P37N3jCeOVqZThUjIUgwGBaACl33JyR4TbnDB0yaE+x+cVlr71mm3ue/UJmfCE2UWLWA5rn5EsbApWKfJYOHofrMRQthKHuX4T19qJnxV1Bp2mrzwBAG+Q8Pm1E/Ch17btfCea/sf2DkuTVGZJl5jO7IQL2mLHipu7ux3QjcsOU/zbsi02WuY4HbJMuT2CduXG8uiZjlcTaBRI8TaiUb6KkvLVXnTNeQQZCf5gqomOQBWq8M0R9/KvA1IPGEBC8E3Evthrm9DrM5Ra4SazJZqB5zZpbkrX5r+/0ppDh8e9LlSg+2KxfXXn7JK7Owyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/GT8KLY+M5gUTSkSIj4n0tWnOGdlYCenq32m3M8jx0=;
 b=MfiKTfHbvG2VMwU9pAvugesmvippEpzfkfAwK3vC+L78q1v6Qp3Je3YV0Ue/xMtB/KbOwaTSS+bFTJVJ8K3mT8QEayskUtXelS5EsZ9HQ/si+m/ZE6qkuYa6vVJ46NjbUBDWANLB88RmJK9ZjjdYncuABfcu7h3iVBXGanChppaB9rSfq87uyeM39EDr+7uyC6/fK0XzWoFCe3JemYlsK73Xv2SKRFfFRPEqOsurof8rXTe3s+/ofd3tH5ITRAdFBkm0oN8cCOJM02UcU04ff8BDfs1eFpWGZZuzDLZuZGb+WoVRr56ZctHT4FaGaxZNiiQkVDkoLRnVoIhhHwY4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/GT8KLY+M5gUTSkSIj4n0tWnOGdlYCenq32m3M8jx0=;
 b=Hio+QPNrEFy8qPhXAUVHK/z4XAfddKtKTDIvZ33U4mvdbeApmkcLtGze3wBfnQkjjGn9LLeAboP/m4FsmzEphpncX1kjvacfLmFHPuQfOukUdp9/xLkJFg2vhiO0rsejkEo5mp3MGY3uq9fV9lQD/Q56XUUMR9dw4Nf/gPwgykk=
Received: from DM6PR10MB3977.namprd10.prod.outlook.com (2603:10b6:5:1d0::20)
 by IA1PR10MB6760.namprd10.prod.outlook.com (2603:10b6:208:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 19:19:48 +0000
Received: from DM6PR10MB3977.namprd10.prod.outlook.com
 ([fe80::5748:741f:2230:d6a9]) by DM6PR10MB3977.namprd10.prod.outlook.com
 ([fe80::5748:741f:2230:d6a9%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 19:19:48 +0000
Message-ID: <aa4b6c90-6e8c-4943-ba83-6688cdf776a1@oracle.com>
Date: Fri, 18 Oct 2024 15:19:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [RFC PATCH v1 00/57] Boot-time page size
 selection for arm64
To: David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Marsden <greg.marsden@oracle.com>,
        Ivan Ivanov <ivan.ivanov@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <f5baa653-fec1-4f6e-91b0-ed8368d3c725@oracle.com>
 <915e2f0c-f603-4617-8429-da4dacc862c4@redhat.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <915e2f0c-f603-4617-8429-da4dacc862c4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::26) To DM6PR10MB3977.namprd10.prod.outlook.com
 (2603:10b6:5:1d0::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3977:EE_|IA1PR10MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: a093adb3-a030-4d08-799c-08dcefa9d4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm50NlFOQldESWE2eFRoYmFzbVcvdDB3Mis2T3J4anlYdkVtL1E1Szh4NTRK?=
 =?utf-8?B?KzVXZGF1RUYrQkk1RDVYSXNHd3RCbW9LaUlMa1d4U3JCVklldTBPOXB4dlZn?=
 =?utf-8?B?YW52cE9INXhiMUdoK1BFMGNxK3h1MWp2RGJ1RXpxVHhsaFB0Rkk5RjN1SVB2?=
 =?utf-8?B?WFI0ZmFDdkYvV3I5aHhOVU5NVzkvUWhkaGtrRDJER3pzaVlITlRDdzRWRUNj?=
 =?utf-8?B?ejJ4YWRXM3hwZGxVYUxOdTh5YjRYdlloS1kwQ2lMa0UwRmFGUGxjT25VTjF6?=
 =?utf-8?B?dkYvZXhYY0VhWGhBNGpUR3JFdkc3WldVZmRFbmNyVTJkVTF0dzQ5ekRrOXIx?=
 =?utf-8?B?dVBwV3pBMG5TdS85RlJ1Zyt4ZnhybFN4MEd3TlRJOW8wZ1MyMDlLaVY5YzVi?=
 =?utf-8?B?UlFTODg5eUQvdHhmS1Ria1ZVY1RIbTEvK3Zaelp4WnJHL3FSc2MvbkVqNjNC?=
 =?utf-8?B?L1JTQVFTekpJL2N5VzJMK0RDZEdSS1ZlSVRTVzRHQ0Njb0pXbmc5cXBjRmlG?=
 =?utf-8?B?TFVrUHUvejJHQU0yRWovYVB0MWpxVkRrYWE5ZWlLS1E4azd4Q1RlTk5iTHlP?=
 =?utf-8?B?YnN3cXJUNkc1a1ZBSHQ0R2pCeFpXenVnL3FsYS9NakhpVVVZb25tbVdsQk9m?=
 =?utf-8?B?VWF2RlBQVFpNRmcvWkdFeUdrekRTVFZYM0h3azJtWVhRQWhjeTdMNXZNRWU3?=
 =?utf-8?B?dlY1ZXhVSytoNlBOaTlvZmxJdmplZHlLOHhsMDFsek1PV1BXOWNyb05FTGRu?=
 =?utf-8?B?bnVUNTNPSEd3SmdnRFB3WGFsd3JHZy9RS05xcmcxT3JQOTBPdkNpUlZScFQv?=
 =?utf-8?B?OUpWZlY4cGhOZFNuZWdqN0ZSNVRLV2JIMnRKTGpEbUI1bzRuQUE2b244alcz?=
 =?utf-8?B?YzRqRldFN2JJTXJQSXM3MjRNbTBkWnoyUGU3T3hrdkhqdnowMXpzSWkzOE9N?=
 =?utf-8?B?blRSbHJ3RkdDMmZFTzhwVUNVYmw1QVBYSk9zZUtqNWNaakdUb00wMk1Lc3kx?=
 =?utf-8?B?dnNrWGFpWkoyaWxTSm9FQ01LTEhXQzA2Rm9uc25HbVpSZ0JRN3lGcWdXRUdh?=
 =?utf-8?B?WGN1TXVERXBHczdYdDFpdlJjd1hMVkE5OHJFSitJZVU3QlByaVZLd04yc1BF?=
 =?utf-8?B?Z1FZTjBTU2pMa0tMeW9HcGQrZUxNcjNaUGMvZjBkYUptaHpNQzJCMWx3WjZ4?=
 =?utf-8?B?eXZHclROUGx2bXNuQlVITkw1T3M4VXdnbVpUbTJqV2ZaZXNwdTNRdE5WQzJQ?=
 =?utf-8?B?a0RRM0RSVmx5MVozVVRrWTNDV1ZYUG11SkdSZEJoSTFyajAwc2kwdlo5bWgz?=
 =?utf-8?B?ZFlwNHVsb2ZZVzhnNktyRkRMUVpvb2hxSCszMHFmcG5UandQb0duQmlabk5R?=
 =?utf-8?B?YWc3WEtYdnRhQnh0eW5xTlhab21YSVVNSGZJeU43b0RXRlNQa3BkVFc1Tnkz?=
 =?utf-8?B?S1lRZzFUWmRKKzl4UDZldjlDZWE5TjRFNXNVRTR5SDNLTGVRSkkvdGpiSThV?=
 =?utf-8?B?ZEF3cHE3NHBLWEUwQWhXSVBvTkYzeUkvRkZQTzN3MVZtTXNvc0lwdkhyTTF5?=
 =?utf-8?B?aktjendsYW0yYjFlcUFTSGN4bkF4L0trc1p6MlVoQ3pudHovbkFBMzRiaUZK?=
 =?utf-8?B?YWxqSFpWMmVTeXlUeGY3LzhQcExHQXF0VzRsL0xBalp5dW9RSEZYZHdJS3dl?=
 =?utf-8?B?dllXWEg4ZkJkS3IrYUlnQ1QrQjV3VHZpZmxnL3FZRUF0YlZRTmduN1I5cE9U?=
 =?utf-8?B?Vm9DZHJneXJqdTdsaW0ya3ZTV2Q2ZWd4WHF2NGVXVWV1SGYwdFg2UUhheDYx?=
 =?utf-8?Q?qLx84FVhHEozgvazjscvRoTqufRMfvQuEewIA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3977.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L29mRklqQnArSmErS3dQRnhSenltMEtVWnhkNmJrK2UxSVBiNkFlRStUZDJv?=
 =?utf-8?B?ZHFJZXJQWFFNdjg1R01PZW4wTXBqQjVLUHBMa2lCc2Q2VVNDNG5rUkZMRTln?=
 =?utf-8?B?a1pjYXhLd3JBZ2pkRDc5S210dHd5RkNsQWhYcThPSGNxUnBuLytQTXgvNGZM?=
 =?utf-8?B?bG9wMUk5ZjZ0WUtKQ1U3WExtZGk1SjNZRG83S2s1STdXMFFZeCtmandQMFV4?=
 =?utf-8?B?Q1lEVTR3aWZKMHhJSmNORkU0K2FhQUJTckZtVjlOQTB2L3NEVlZwdlp5UXJZ?=
 =?utf-8?B?aUw2cnU4MkovbW5SaWNjTUZwMzZnajRTcGk1SDQ3bnRjRC9BbysrTWlKL0Rz?=
 =?utf-8?B?VDZjR0J1SXM5T1lRRW5uclN5ODFpRXV1SitwWTUxeXIrTFVsT1lMdlZ2RVFU?=
 =?utf-8?B?OHlSbFBwaDV5c2JVWWdkcXk1R1lrV2NVYUVTOU1kWDdZTjNLQkVUeUJjZU55?=
 =?utf-8?B?R0VFUXNPYkdzWkFwbEM2VEl1aUtIU3hLYUR0eTh4VW1MbER0YUM0ckUrakxZ?=
 =?utf-8?B?dk52c21jeVF4MTBWNkRqSkRBS29NdThTOXRKMElraXcxU29qbWNrUFFKN3hQ?=
 =?utf-8?B?Q0pmN2lZU1BoL3dkNkI5WkRoajREVHFTT0JCa0l3U0dta1FFUEVXZm43Z001?=
 =?utf-8?B?YTNiY2puZUpzUUJHYjhNOC9Hang3VmpPRy9kS3F4aVk2QXJTUm82QlZoMzg4?=
 =?utf-8?B?cXVHLzcyZC9LbUZkeTZSejdUazdIZ0tsMklIbnVWV3Y2MUp6Uk90UTR3eFNF?=
 =?utf-8?B?aHgzNXkzUkJUbjRxOUJ3ak5hQVZtTDEvYUxoM0FCcmtDYi8vS3NXek5DOG5L?=
 =?utf-8?B?QWNCUjIrZnZtWXd0b3ZZS2s2dis4WG1XNitCdFdkYXpDeGQ4dkhqRWtUQ0Vs?=
 =?utf-8?B?VXZxWTJoOVQ0eGZEVE9KMzU2RXBxSUc4c1JNMGxHcHRGMzE1V25oOXhyMjBT?=
 =?utf-8?B?OGdqb1FPQ2tJcUVodHdULzdrQ01CZjRRM1JSYlovQ3BPaFR5VkVodmZNai9o?=
 =?utf-8?B?NnE3V052OXBWQVFld1hVR284c0UvUDh1emhHb2RHSnAxOWdwMFpxYzBEY0NW?=
 =?utf-8?B?cWQwNnNrNVUvZXhUSmNjdGZXanBRbVdYUkxMU1NsWWJWQ0hqbks4SFBQVTI0?=
 =?utf-8?B?Z3N5TXV4Mk1zUEUzZ2xYZ2R1ckNiQkdzayt6TjgwOW9xeHA1RXplZXRCQkV3?=
 =?utf-8?B?VHg3QlNhZ2VLV0JMckptdWZxSHl6K3BEOCtLMWc2dzExZkVYbm5FMHFRUmho?=
 =?utf-8?B?V1F3WDhNYlpBbzVaTFBQZXV0QTFVNWpLL2dMZzd6ZmpCeE52RTdlbkEveDMx?=
 =?utf-8?B?NWZrUGNNZjYyRWpzM21vamhuZC9xTHdEUE0yTUZxQnFlMFBtdS8yMVpuSSs4?=
 =?utf-8?B?NTRHRGtZWnRLZHc0WEtiWXVLZ2JrNDdXRThvTXlCMkFJM2tjTXBZVWI4aERZ?=
 =?utf-8?B?RG5LZFM4bHVQTWFWbk1kQ3lCbmpKUlZ0bFB5Szd6STVkN2lvMjhXYVlIeEw1?=
 =?utf-8?B?K29qaXlrTGVwd3prdHZTUTdVTkk3WjUrYjlWd0Z0SzIrMEVEV1VCTXFYL2Za?=
 =?utf-8?B?T2VIUk9hODdYY01JbjllajNYcm41TGkwajYyQm1nUVJXTWR6M1FiUWg0NDho?=
 =?utf-8?B?eHBkV05SRkcwKzRnQVJJbTlhM2NRdVhFYzZNUklNOUpYS2JYdG9lK2FXbTNL?=
 =?utf-8?B?WU83Z2tHdk4vQ1VSam5MVE82RXByVnprdy8zSmlBTkZrRmVDZmlXRU83ZjJT?=
 =?utf-8?B?K3lSNGR1WXBOMjN5ZldGRTN2NG5MNVdTbHBMR2tId3BRZ0VQbWQvZGhJNk5V?=
 =?utf-8?B?MGRQMDl3UmJ6ZG1hQU84NWMyWWhYYXVxdXdrdWRRZnRadjZFOU1TaVNVcXhR?=
 =?utf-8?B?WURZTk5xenVLZHpmeXd1NXFETG00VDRHUGVUblF2QzM5UkNUNDNRWk82RmpW?=
 =?utf-8?B?bGFaa3U0UG5vMEZrUzk4alZ6THpYN3V0TWNWZ1hLVytueElwbVNVVy8yd0M1?=
 =?utf-8?B?ZHM5YXVSZldSSDIvOGhYYUd4bk1EcnY3OU5FK2p0SmZ6NHFyQkhDdmswKzhZ?=
 =?utf-8?B?TXNFMWJGcWQ1SnVJeHR5RmxzdGJaYm40c3JpeXZTR2xnMVJKL2pJYTQrK0ZN?=
 =?utf-8?B?dm9ZRnV1VUpkUXloQ2FUWSs2YmJBYlRyc0RQN2NZQTF1aGpMS3BVc2c4bkda?=
 =?utf-8?Q?AKsiM20FxjLgCB7UzvE6Pj0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6QtY8i3aHCGUG8xNBd8IdIN7TE4BBQUqcMKbJMU/hY9R35r/4Ni74Md48Vip1h5zqZYnf+ce7Uf9pFUih8hgNwc3Y+A/fHW/FQ6NsfahqSdRuIEwNOzI3yBFUWy4l9h6lYIR6IzwjuzsDs5CiGXy/W2M5XJocs7xFDuvR3pBuMMRs7R40PYOTdxk9kmg2zrWb7coQ1oIIEkdwJwsi1P02H141NqZ8oXn1iU4KfaMIi1tsbrVmt1ywUSzXyzeX8VWd6MCvlUyUqN4Sxuvmx3w4JnYQa7+txWhQBc//v6cBHMvD0f+3TxnFBN/pxWR/FQQEpkqzrliW6jLoJ1ElAcw6J1XZcGO2A/QYAoSQyM2vIiXWjnqiFSuhhlO9sLRvSroME2Ry4hDscqWJOy3A3uIIwmWftpIY8HH7SEbSMj6qF8ot7xEEjHTxeHKHDEN6XbBB2k+y0PSH4DSInKCxPKikfZ/eJvPwlgRrvdYBbedA5Di9j9iBNTuns7sTzUYNocjQlSj/nnn9ng9qGe3b9tGnbbkaH/ajveugfcnr4uCsHtVmbxnaX9ggpAQQsB8QYsQLVL85iZVl7rvedylUnyYjOyLcF5OQLyMHeCU1yFwlpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a093adb3-a030-4d08-799c-08dcefa9d4cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3977.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:19:48.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/KOz9LuGx81aLuN42LGBl1xIAqj+5j/eJls08sPa3uSK7hjCRXhBilOuadABLq94KjgmPOdEZIaPnrw551YmdBG68VZ1JCxO9McjggOGYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180123
X-Proofpoint-GUID: i1i05zA84Ph9UaDFcb4oluBkEsFJWNrl
X-Proofpoint-ORIG-GUID: i1i05zA84Ph9UaDFcb4oluBkEsFJWNrl




On 10/18/24 14:27, David Hildenbrand wrote:
> On 18.10.24 20:15, Joseph Salisbury wrote:
>>
>>
>>
>> On 10/14/24 06:55, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> Patch bomb incoming... This covers many subsystems, so I've included 
>>> a core set
>>> of people on the full series and additionally included maintainers 
>>> on relevant
>>> patches. I haven't included those maintainers on this cover letter 
>>> since the
>>> numbers were far too big for it to work. But I've included a link to 
>>> this cover
>>> letter on each patch, so they can hopefully find their way here. For 
>>> follow up
>>> submissions I'll break it up by subsystem, but for now thought it 
>>> was important
>>> to show the full picture.
>>>
>>> This RFC series implements support for boot-time page size selection 
>>> within the
>>> arm64 kernel. arm64 supports 3 base page sizes (4K, 16K, 64K), but 
>>> to date, page
>>> size has been selected at compile-time, meaning the size is baked 
>>> into a given
>>> kernel image. As use of larger-than-4K page sizes become more 
>>> prevalent this
>>> starts to present a problem for distributions. Boot-time page size 
>>> selection
>>> enables the creation of a single kernel image, which can be told 
>>> which page size
>>> to use on the kernel command line.
>>>
>>> Why is having an image-per-page size problematic?
>>> =================================================
>>>
>>> Many traditional distros are now supporting both 4K and 64K. And 
>>> this means
>>> managing 2 kernel packages, along with drivers for each. For some, 
>>> it means
>>> multiple installer flavours and multiple ISOs. All of this adds up to a
>>> less-than-ideal level of complexity. Additionally, Android now 
>>> supports 4K and
>>> 16K kernels. I'm told having to explicitly manage their KABI for 
>>> each kernel is
>>> painful, and the extra flash space required for both kernel images 
>>> and the
>>> duplicated modules has been problematic. Boot-time page size 
>>> selection solves
>>> all of this.
>>>
>>> Additionally, in starting to think about the longer term deployment 
>>> story for
>>> D128 page tables, which Arm architecture now supports, a lot of the 
>>> same
>>> problems need to be solved, so this work sets us up nicely for that.
>>>
>>> So what's the down side?
>>> ========================
>>>
>>> Well nothing's free; Various static allocations in the kernel image 
>>> must be
>>> sized for the worst case (largest supported page size), so image 
>>> size is in line
>>> with size of 64K compile-time image. So if you're interested in 4K 
>>> or 16K, there
>>> is a slight increase to the image size. But I expect that problem 
>>> goes away if
>>> you're compressing the image - its just some extra zeros. At 
>>> boot-time, I expect
>>> we could free the unused static storage once we know the page size - 
>>> although
>>> that would be a follow up enhancement.
>>>
>>> And then there is performance. Since PAGE_SIZE and friends are no 
>>> longer
>>> compile-time constants, we must look up their values and do 
>>> arithmetic at
>>> runtime instead of compile-time. My early perf testing suggests this is
>>> inperceptible for real-world workloads, and only has small impact on
>>> microbenchmarks - more on this below.
>>>
>>> Approach
>>> ========
>>>
>>> The basic idea is to rid the source of any assumptions that 
>>> PAGE_SIZE and
>>> friends are compile-time constant, but in a way that allows the 
>>> compiler to
>>> perform the same optimizations as was previously being done if they 
>>> do turn out
>>> to be compile-time constant. Where constants are required, we use 
>>> limits;
>>> PAGE_SIZE_MIN and PAGE_SIZE_MAX. See commit log in patch 1 for full 
>>> description
>>> of all the classes of problems to solve.
>>>
>>> By default PAGE_SIZE_MIN=PAGE_SIZE_MAX=PAGE_SIZE. But an arch may 
>>> opt-in to
>>> boot-time page size selection by defining PAGE_SIZE_MIN & 
>>> PAGE_SIZE_MAX. arm64
>>> does this if the user selects the CONFIG_ARM64_BOOT_TIME_PAGE_SIZE 
>>> Kconfig,
>>> which is an alternative to selecting a compile-time page size.
>>>
>>> When boot-time page size is active, the arch pgtable geometry macro 
>>> definitions
>>> resolve to something that can be configured at boot. The arm64 
>>> implementation in
>>> this series mainly uses global, __ro_after_init variables. I've 
>>> tried using
>>> alternatives patching, but that performs worse than loading from 
>>> memory; I think
>>> due to code size bloat.
>>>
>>> Status
>>> ======
>>>
>>> When CONFIG_ARM64_BOOT_TIME_PAGE_SIZE is selected, I've only 
>>> implemented enough
>>> to compile the kernel image itself with defconfig (and a few other 
>>> bits and
>>> pieces). This is enough to build a kernel that can boot under QEMU 
>>> or FVP. I'll
>>> happily do the rest of the work to enable all the extra drivers, but 
>>> wanted to
>>> get feedback on the shape of this effort first. If anyone wants to 
>>> do any
>>> testing, and has a must-have config, let me know and I'll prioritize 
>>> enabling it
>>> first.
>>>
>>> The series is arranged as follows:
>>>
>>>     - patch 1:       Add macros required for converting non-arch 
>>> code to support
>>>                boot-time page size selection
>>>     - patches 2-36:  Remove PAGE_SIZE compile-time constant 
>>> assumption from all
>>>                non-arch code
>>>     - patches 37-38: Some arm64 tidy ups
>>>     - patch 39:       Add macros required for converting arm64 code 
>>> to support
>>>                boot-time page size selection
>>>     - patches 40-56: arm64 changes to support boot-time page size 
>>> selection
>>>     - patch 57:       Add arm64 Kconfig option to enable boot-time 
>>> page size
>>>                selection
>>>
>>> Ideally, I'd like to get the basics merged (something like this 
>>> series), then
>>> incrementally improve it over a handful of kernel releases until we can
>>> demonstrate that we have feature parity with the compile-time build 
>>> and no
>>> performance blockers. Once at that point, ideally the compile-time 
>>> build options
>>> would be removed and the code could be cleaned up further.
>>>
>>> One of the bigger peices that I'd propose to add as a follow up, is 
>>> to make
>>> va-size boot-time selectable too. That will greatly simplify LPA2 
>>> fallback
>>> handling.
>>>
>>> Assuming people are ammenable to the rough shape, how would I go 
>>> about getting
>>> the non-arch changes merged? Since they cover many subsystems, will 
>>> each piece
>>> need to go independently to each relevant maintainer or could it all 
>>> be merged
>>> together through the arm64 tree?
>>>
>>> Image Size
>>> ==========
>>>
>>> The below shows the size of a defconfig (+ xfs, squashfs, ftrace, 
>>> kprobes)
>>> kernel image on disk for base (before any changes applied), compile 
>>> (with
>>> changes, configured for compile-time page size) and boot (with changes,
>>> configured for boot-time page size).
>>>
>>> You can see the that compile-16k and 64k configs are actually 
>>> slightly smaller
>>> than the baselines; that's due to optimizing some buffer sizes which 
>>> didn't need
>>> to depend on page size during the series. The boot-time image is ~1% 
>>> bigger than
>>> the 64k compile-time image. I believe there is scope to improve this 
>>> to make it
>>> equal to compile-64k if required:
>>>
>>> | config      | size/KB | diff/KB |  diff/% |
>>> |-------------|---------|---------|---------|
>>> | base-4k     |   54895 |       0 |    0.0% |
>>> | base-16k    |   55161 |     266 |    0.5% |
>>> | base-64k    |   56775 |    1880 |    3.4% |
>>> | compile-4k  |   54895 |       0 |    0.0% |
>>> | compile-16k |   55097 |     202 |    0.4% |
>>> | compile-64k |   56391 |    1496 |    2.7% |
>>> | boot-4K     |   57045 |    2150 |    3.9% |
>>>
>>> And below shows the size of the image in memory at run-time, 
>>> separated for text
>>> and data costs. The boot image has ~1% text cost; most likely due to 
>>> the fact
>>> that PAGE_SIZE and friends are not compile-time constants so need 
>>> instructions
>>> to load the values and do arithmetic. I believe we could eventually 
>>> get the data
>>> cost to match the cost for the compile image for the chosen page 
>>> size by freeing
>>> the ends of the static buffers not needed for the selected page size:
>>>
>>> |             |    text |    text |    text |    data | data |    
>>> data |
>>> | config      | size/KB | diff/KB |  diff/% | size/KB | diff/KB |  
>>> diff/% |
>>> |-------------|---------|---------|---------|---------|---------|---------| 
>>>
>>> | base-4k     |   20561 |       0 |    0.0% |   14314 | 0 |    0.0% |
>>> | base-16k    |   20439 |    -122 |   -0.6% |   14625 | 311 |    2.2% |
>>> | base-64k    |   20435 |    -126 |   -0.6% |   15673 | 1359 |    
>>> 9.5% |
>>> | compile-4k  |   20565 |       4 |    0.0% |   14315 | 1 |    0.0% |
>>> | compile-16k |   20443 |    -118 |   -0.6% |   14517 | 204 |    1.4% |
>>> | compile-64k |   20439 |    -122 |   -0.6% |   15134 | 820 |    5.7% |
>>> | boot-4K     |   20811 |     250 |    1.2% |   15287 | 973 |    6.8% |
>>>
>>> Functional Testing
>>> ==================
>>>
>>> I've build-tested defconfig for all arches supported by tuxmake 
>>> (which is most)
>>> without issue.
>>>
>>> I've boot-tested arm64 with CONFIG_ARM64_BOOT_TIME_PAGE_SIZE for all 
>>> page sizes
>>> and a few va-sizes, and additionally have run all the mm-selftests, 
>>> with no
>>> regressions observed vs the equivalent compile-time page size build 
>>> (although
>>> the mm-selftests have a few existing failures when run against 16K 
>>> and 64K
>>> kernels - those should really be investigated and fixed independently).
>>>
>>> Test coverage is lacking for many of the drivers that I've touched, 
>>> but in many
>>> cases, I'm hoping the changes are simple enough that review might 
>>> suffice?
>>>
>>> Performance Testing
>>> ===================
>>>
>>> I've run some limited performance benchmarks:
>>>
>>> First, a real-world benchmark that causes a lot of page table 
>>> manipulation (and
>>> therefore we would expect to see regression here if we are going to 
>>> see it
>>> anywhere); kernel compilation. It barely registers a change. Values 
>>> are times,
>>> so smaller is better. All relative to base-4k:
>>>
>>> |             |    kern |    kern |    user |    user | real |    
>>> real |
>>> | config      |    mean |   stdev |    mean |   stdev | mean |   
>>> stdev |
>>> |-------------|---------|---------|---------|---------|---------|---------| 
>>>
>>> | base-4k     |    0.0% |    1.1% |    0.0% |    0.3% | 0.0% |    
>>> 0.3% |
>>> | compile-4k  |   -0.2% |    1.1% |   -0.2% |    0.3% | -0.1% |    
>>> 0.3% |
>>> | boot-4k     |    0.1% |    1.0% |   -0.3% |    0.2% | -0.2% |    
>>> 0.2% |
>>>
>>> The Speedometer JavaScript benchmark also shows no change. Values 
>>> are runs per
>>> min, so bigger is better. All relative to base-4k:
>>>
>>> | config      |    mean |   stdev |
>>> |-------------|---------|---------|
>>> | base-4k     |    0.0% |    0.8% |
>>> | compile-4k  |    0.4% |    0.8% |
>>> | boot-4k     |    0.0% |    0.9% |
>>>
>>> Finally, I've run some microbenchmarks known to stress page table 
>>> manipulations
>>> (originally from David Hildenbrand). The fork test maps/allocs 1G of 
>>> anon
>>> memory, then measures the cost of fork(). The munmap test 
>>> maps/allocs 1G of anon
>>> memory then measures the cost of munmap()ing it. The fork test is 
>>> known to be
>>> extremely sensitive to any changes that cause instructions to be 
>>> aligned
>>> differently in cachelines. When using this test for other changes, 
>>> I've seen
>>> double digit regressions for the slightest thing, so 12% regression 
>>> on this test
>>> is actually fairly good. This likely represents the extreme worst 
>>> case for
>>> regressions that will be observed across other microbenchmarks 
>>> (famous last
>>> words). Values are times, so smaller is better. All relative to 
>>> base-4k:
>>>
>>> |             |    fork |    fork |  munmap |  munmap |
>>> | config      |    mean |   stdev |   stdev |   stdev |
>>> |-------------|---------|---------|---------|---------|
>>> | base-4k     |    0.0% |    1.3% |    0.0% |    0.3% |
>>> | compile-4k  |    0.1% |    1.3% |   -0.9% |    0.1% |
>>> | boot-4k     |   12.8% |    1.2% |    3.8% |    1.0% |
>>>
>>> NOTE: The series applies on top of v6.11.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>> Ryan Roberts (57):
>>>     mm: Add macros ahead of supporting boot-time page size selection
>>>     vmlinux: Align to PAGE_SIZE_MAX
>>>     mm/memcontrol: Fix seq_buf size to save memory when PAGE_SIZE is 
>>> large
>>>     mm/page_alloc: Make page_frag_cache boot-time page size compatible
>>>     mm: Avoid split pmd ptl if pmd level is run-time folded
>>>     mm: Remove PAGE_SIZE compile-time constant assumption
>>>     fs: Introduce MAX_BUF_PER_PAGE_SIZE_MAX for array sizing
>>>     fs: Remove PAGE_SIZE compile-time constant assumption
>>>     fs/nfs: Remove PAGE_SIZE compile-time constant assumption
>>>     fs/ext4: Remove PAGE_SIZE compile-time constant assumption
>>>     fork: Permit boot-time THREAD_SIZE determination
>>>     cgroup: Remove PAGE_SIZE compile-time constant assumption
>>>     bpf: Remove PAGE_SIZE compile-time constant assumption
>>>     pm/hibernate: Remove PAGE_SIZE compile-time constant assumption
>>>     stackdepot: Remove PAGE_SIZE compile-time constant assumption
>>>     perf: Remove PAGE_SIZE compile-time constant assumption
>>>     kvm: Remove PAGE_SIZE compile-time constant assumption
>>>     trace: Remove PAGE_SIZE compile-time constant assumption
>>>     crash: Remove PAGE_SIZE compile-time constant assumption
>>>     crypto: Remove PAGE_SIZE compile-time constant assumption
>>>     sunrpc: Remove PAGE_SIZE compile-time constant assumption
>>>     sound: Remove PAGE_SIZE compile-time constant assumption
>>>     net: Remove PAGE_SIZE compile-time constant assumption
>>>     net: fec: Remove PAGE_SIZE compile-time constant assumption
>>>     net: marvell: Remove PAGE_SIZE compile-time constant assumption
>>>     net: hns3: Remove PAGE_SIZE compile-time constant assumption
>>>     net: e1000: Remove PAGE_SIZE compile-time constant assumption
>>>     net: igbvf: Remove PAGE_SIZE compile-time constant assumption
>>>     net: igb: Remove PAGE_SIZE compile-time constant assumption
>>>     drivers/base: Remove PAGE_SIZE compile-time constant assumption
>>>     edac: Remove PAGE_SIZE compile-time constant assumption
>>>     optee: Remove PAGE_SIZE compile-time constant assumption
>>>     random: Remove PAGE_SIZE compile-time constant assumption
>>>     sata_sil24: Remove PAGE_SIZE compile-time constant assumption
>>>     virtio: Remove PAGE_SIZE compile-time constant assumption
>>>     xen: Remove PAGE_SIZE compile-time constant assumption
>>>     arm64: Fix macros to work in C code in addition to the linker 
>>> script
>>>     arm64: Track early pgtable allocation limit
>>>     arm64: Introduce macros required for boot-time page selection
>>>     arm64: Refactor early pgtable size calculation macros
>>>     arm64: Pass desired page size on command line
>>>     arm64: Divorce early init from PAGE_SIZE
>>>     arm64: Clean up simple cases of CONFIG_ARM64_*K_PAGES
>>>     arm64: Align sections to PAGE_SIZE_MAX
>>>     arm64: Rework trampoline rodata mapping
>>>     arm64: Generalize fixmap for boot-time page size
>>>     arm64: Statically allocate and align for worst-case page size
>>>     arm64: Convert switch to if for non-const comparison values
>>>     arm64: Convert BUILD_BUG_ON to VM_BUG_ON
>>>     arm64: Remove PAGE_SZ asm-offset
>>>     arm64: Introduce cpu features for page sizes
>>>     arm64: Remove PAGE_SIZE from assembly code
>>>     arm64: Runtime-fold pmd level
>>>     arm64: Support runtime folding in idmap_kpti_install_ng_mappings
>>>     arm64: TRAMP_VALIAS is no longer compile-time constant
>>>     arm64: Determine THREAD_SIZE at boot-time
>>>     arm64: Enable boot-time page size selection
>>>
>>>    arch/alpha/include/asm/page.h                 |   1 +
>>>    arch/arc/include/asm/page.h                   |   1 +
>>>    arch/arm/include/asm/page.h                   |   1 +
>>>    arch/arm64/Kconfig                            |  26 ++-
>>>    arch/arm64/include/asm/assembler.h            |  78 ++++++-
>>>    arch/arm64/include/asm/cpufeature.h           |  44 +++-
>>>    arch/arm64/include/asm/efi.h                  |   2 +-
>>>    arch/arm64/include/asm/fixmap.h               |  28 ++-
>>>    arch/arm64/include/asm/kernel-pgtable.h       | 150 +++++++++----
>>>    arch/arm64/include/asm/kvm_arm.h              |  21 +-
>>>    arch/arm64/include/asm/kvm_hyp.h              |  11 +
>>>    arch/arm64/include/asm/kvm_pgtable.h          |   6 +-
>>>    arch/arm64/include/asm/memory.h               |  62 ++++--
>>>    arch/arm64/include/asm/page-def.h             |   3 +-
>>>    arch/arm64/include/asm/pgalloc.h              |  16 +-
>>>    arch/arm64/include/asm/pgtable-geometry.h     |  46 ++++
>>>    arch/arm64/include/asm/pgtable-hwdef.h        |  28 ++-
>>>    arch/arm64/include/asm/pgtable-prot.h         |   2 +-
>>>    arch/arm64/include/asm/pgtable.h              | 133 +++++++++---
>>>    arch/arm64/include/asm/processor.h            |  10 +-
>>>    arch/arm64/include/asm/sections.h             |   1 +
>>>    arch/arm64/include/asm/smp.h                  |   1 +
>>>    arch/arm64/include/asm/sparsemem.h            |  15 +-
>>>    arch/arm64/include/asm/sysreg.h               |  54 +++--
>>>    arch/arm64/include/asm/tlb.h                  |   3 +
>>>    arch/arm64/kernel/asm-offsets.c               |   4 +-
>>>    arch/arm64/kernel/cpufeature.c                |  93 ++++++--
>>>    arch/arm64/kernel/efi.c                       |   2 +-
>>>    arch/arm64/kernel/entry.S                     |  60 +++++-
>>>    arch/arm64/kernel/head.S                      |  46 +++-
>>>    arch/arm64/kernel/hibernate-asm.S             |   6 +-
>>>    arch/arm64/kernel/image-vars.h                |  14 ++
>>>    arch/arm64/kernel/image.h                     |   4 +
>>>    arch/arm64/kernel/pi/idreg-override.c         |  68 +++++-
>>>    arch/arm64/kernel/pi/map_kernel.c             | 165 ++++++++++----
>>>    arch/arm64/kernel/pi/map_range.c              | 201 
>>> ++++++++++++++++--
>>>    arch/arm64/kernel/pi/pi.h                     |  63 +++++-
>>>    arch/arm64/kernel/relocate_kernel.S           |  10 +-
>>>    arch/arm64/kernel/vdso-wrap.S                 |   4 +-
>>>    arch/arm64/kernel/vdso.c                      |   7 +-
>>>    arch/arm64/kernel/vdso/vdso.lds.S             |   4 +-
>>>    arch/arm64/kernel/vdso32-wrap.S               |   4 +-
>>>    arch/arm64/kernel/vdso32/vdso.lds.S           |   4 +-
>>>    arch/arm64/kernel/vmlinux.lds.S               |  48 +++--
>>>    arch/arm64/kvm/arm.c                          |  10 +
>>>    arch/arm64/kvm/hyp/nvhe/Makefile              |   1 +
>>>    arch/arm64/kvm/hyp/nvhe/host.S                |  10 +-
>>>    arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   4 +-
>>>    arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c    |  16 ++
>>>    arch/arm64/kvm/mmu.c                          |  39 ++--
>>>    arch/arm64/lib/clear_page.S                   |   7 +-
>>>    arch/arm64/lib/copy_page.S                    |  33 ++-
>>>    arch/arm64/lib/mte.S                          |  27 ++-
>>>    arch/arm64/mm/Makefile                        |   1 +
>>>    arch/arm64/mm/fixmap.c                        |  38 ++--
>>>    arch/arm64/mm/hugetlbpage.c                   |  40 +---
>>>    arch/arm64/mm/init.c                          |  26 +--
>>>    arch/arm64/mm/kasan_init.c                    |   8 +-
>>>    arch/arm64/mm/mmu.c                           |  53 +++--
>>>    arch/arm64/mm/pgd.c                           |  12 +-
>>>    arch/arm64/mm/pgtable-geometry.c              |  24 +++
>>>    arch/arm64/mm/proc.S                          | 128 ++++++++---
>>>    arch/arm64/mm/ptdump.c                        |   3 +-
>>>    arch/arm64/tools/cpucaps                      |   3 +
>>>    arch/csky/include/asm/page.h                  |   3 +
>>>    arch/hexagon/include/asm/page.h               |   2 +
>>>    arch/loongarch/include/asm/page.h             |   2 +
>>>    arch/m68k/include/asm/page.h                  |   1 +
>>>    arch/microblaze/include/asm/page.h            |   1 +
>>>    arch/mips/include/asm/page.h                  |   1 +
>>>    arch/nios2/include/asm/page.h                 |   2 +
>>>    arch/openrisc/include/asm/page.h              |   1 +
>>>    arch/parisc/include/asm/page.h                |   1 +
>>>    arch/powerpc/include/asm/page.h               |   2 +
>>>    arch/riscv/include/asm/page.h                 |   1 +
>>>    arch/s390/include/asm/page.h                  |   1 +
>>>    arch/sh/include/asm/page.h                    |   1 +
>>>    arch/sparc/include/asm/page.h                 |   3 +
>>>    arch/um/include/asm/page.h                    |   2 +
>>>    arch/x86/include/asm/page_types.h             |   2 +
>>>    arch/xtensa/include/asm/page.h                |   1 +
>>>    crypto/lskcipher.c                            |   4 +-
>>>    drivers/ata/sata_sil24.c                      |  46 ++--
>>>    drivers/base/node.c                           |   6 +-
>>>    drivers/base/topology.c                       |  32 +--
>>>    drivers/block/virtio_blk.c                    |   2 +-
>>>    drivers/char/random.c                         |   4 +-
>>>    drivers/edac/edac_mc.h                        |  13 +-
>>>    drivers/firmware/efi/libstub/arm64.c          |   3 +-
>>>    drivers/irqchip/irq-gic-v3-its.c              |   2 +-
>>>    drivers/mtd/mtdswap.c                         |   4 +-
>>>    drivers/net/ethernet/freescale/fec.h          |   3 +-
>>>    drivers/net/ethernet/freescale/fec_main.c     |   5 +-
>>>    .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   4 +-
>>>    drivers/net/ethernet/intel/e1000/e1000_main.c |   6 +-
>>>    drivers/net/ethernet/intel/igb/igb.h          |  25 +--
>>>    drivers/net/ethernet/intel/igb/igb_main.c     | 149 +++++++------
>>>    drivers/net/ethernet/intel/igbvf/netdev.c     |   6 +-
>>>    drivers/net/ethernet/marvell/mvneta.c         |   9 +-
>>>    drivers/net/ethernet/marvell/sky2.h           |   2 +-
>>>    drivers/tee/optee/call.c                      |   7 +-
>>>    drivers/tee/optee/smc_abi.c                   |   2 +-
>>>    drivers/virtio/virtio_balloon.c               |  10 +-
>>>    drivers/xen/balloon.c                         |  11 +-
>>>    drivers/xen/biomerge.c                        |  12 +-
>>>    drivers/xen/privcmd.c                         |   2 +-
>>>    drivers/xen/xenbus/xenbus_client.c            |   5 +-
>>>    drivers/xen/xlate_mmu.c                       |   6 +-
>>>    fs/binfmt_elf.c                               |  11 +-
>>>    fs/buffer.c                                   |   2 +-
>>>    fs/coredump.c                                 |   8 +-
>>>    fs/ext4/ext4.h                                |  36 ++--
>>>    fs/ext4/move_extent.c                         |   2 +-
>>>    fs/ext4/readpage.c                            |   2 +-
>>>    fs/fat/dir.c                                  |   4 +-
>>>    fs/fat/fatent.c                               |   4 +-
>>>    fs/nfs/nfs42proc.c                            |   2 +-
>>>    fs/nfs/nfs42xattr.c                           |   2 +-
>>>    fs/nfs/nfs4proc.c                             |   2 +-
>>>    include/asm-generic/pgtable-geometry.h        |  71 +++++++
>>>    include/asm-generic/vmlinux.lds.h             |  38 ++--
>>>    include/linux/buffer_head.h                   |   1 +
>>>    include/linux/cpumask.h                       |   5 +
>>>    include/linux/linkage.h                       |   4 +-
>>>    include/linux/mm.h                            |  17 +-
>>>    include/linux/mm_types.h                      |  15 +-
>>>    include/linux/mm_types_task.h                 |   2 +-
>>>    include/linux/mmzone.h                        |   3 +-
>>>    include/linux/netlink.h                       |   6 +-
>>>    include/linux/percpu-defs.h                   |   4 +-
>>>    include/linux/perf_event.h                    |   2 +-
>>>    include/linux/sched.h                         |   4 +-
>>>    include/linux/slab.h                          |   7 +-
>>>    include/linux/stackdepot.h                    |   6 +-
>>>    include/linux/sunrpc/svc.h                    |   8 +-
>>>    include/linux/sunrpc/svc_rdma.h               |   4 +-
>>>    include/linux/sunrpc/svcsock.h                |   2 +-
>>>    include/linux/swap.h                          |  17 +-
>>>    include/linux/swapops.h                       |   6 +-
>>>    include/linux/thread_info.h                   |  10 +-
>>>    include/xen/page.h                            |   2 +
>>>    init/main.c                                   |   7 +-
>>>    kernel/bpf/core.c                             |   9 +-
>>>    kernel/bpf/ringbuf.c                          |  54 ++---
>>>    kernel/cgroup/cgroup.c                        |   8 +-
>>>    kernel/crash_core.c                           |   2 +-
>>>    kernel/events/core.c                          |   2 +-
>>>    kernel/fork.c                                 |  71 +++----
>>>    kernel/power/power.h                          |   2 +-
>>>    kernel/power/snapshot.c                       |   2 +-
>>>    kernel/power/swap.c                           | 129 +++++++++--
>>>    kernel/trace/fgraph.c                         |   2 +-
>>>    kernel/trace/trace.c                          |   2 +-
>>>    lib/stackdepot.c                              |   6 +-
>>>    mm/kasan/report.c                             |   3 +-
>>>    mm/memcontrol.c                               |  11 +-
>>>    mm/memory.c                                   |   4 +-
>>>    mm/mmap.c                                     |   2 +-
>>>    mm/page-writeback.c                           |   2 +-
>>>    mm/page_alloc.c                               |  31 +--
>>>    mm/slub.c                                     |   2 +-
>>>    mm/sparse.c                                   |   2 +-
>>>    mm/swapfile.c                                 |   2 +-
>>>    mm/vmalloc.c                                  |   7 +-
>>>    net/9p/trans_virtio.c                         |   4 +-
>>>    net/core/hotdata.c                            |   4 +-
>>>    net/core/skbuff.c                             |   4 +-
>>>    net/core/sysctl_net_core.c                    |   2 +-
>>>    net/sunrpc/cache.c                            |   3 +-
>>>    net/unix/af_unix.c                            |   2 +-
>>>    sound/soc/soc-utils.c                         |   4 +-
>>>    virt/kvm/kvm_main.c                           |   2 +-
>>>    172 files changed, 2185 insertions(+), 951 deletions(-)
>>>    create mode 100644 arch/arm64/include/asm/pgtable-geometry.h
>>>    create mode 100644 arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>>>    create mode 100644 arch/arm64/mm/pgtable-geometry.c
>>>    create mode 100644 include/asm-generic/pgtable-geometry.h
>>>
>>> -- 
>>> 2.43.0
>>>
>>>
>>
>> Hi Ryan,
>>
>> First off, this is excellent work!  Your cover page was very detailed
>> and made the patch set easier to understand.
>>
>> Some questions/comments:
>>
>> Once a kernel is booted with a certain page size, could there be issues
>> if it is booted later with a different page size?  How about if this is
>> done frequently?
>
> I think that is the reason why you are only given the option in RHEL 
> to select the kernel (4K vs. 64K) to use at install time.
>
> Software can easily use a different data format for persistance based 
> on the base page size. I would suspect DBs might be the usual suspects.
>
> One example is swap space I think, where the base page size used when 
> formatting the device is used, and it cannot be used with a different 
> page size unless reformatting it.
>
> So ... one has to be a bit careful ...
>
Yes, that is what I was thinking.  Once a userspace process does an I/O 
and if it is based on PAGE_SIZE things can go south.  I think this is 
not an issue with THP, so maybe it's possible with boot-time page selection?

