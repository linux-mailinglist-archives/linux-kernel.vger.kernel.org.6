Return-Path: <linux-kernel+bounces-372360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D29A47AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDEBB24D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E912071FD;
	Fri, 18 Oct 2024 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oLoeURDL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h9fvjPq0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655071EE00E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282052; cv=fail; b=Up5Qhb2u+xQoEDAr+nsES9340RN/8s3ZgRyApaoEzMvVaP/WeOFaQX9nPmeBIND5IjZVDUBR4upN+vC0MxP+5cfpGEm8IR5kVfoMyKqtMb7yCtmdPRCtCvhm2L3rZx43aLcPMZg2Mq4mdOSra1DNzjLbrslwkYGMML+qvtx1lno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282052; c=relaxed/simple;
	bh=RA8Vna51cWb+C0IXZnVIPPvI0eXX7RBr6UrpYR75fE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ENHGhC8PJpzZ+srJqH/v9NXLhcbamOBZ+MTtFzaIXE90o8oBXdDT3XGRnrutnlvOKh5Gj8ikJQh4QueLO4JeTZmRthPZ7ODxh7yeqy8D3ymvgf24Nkg2rkh+zC0qH7NoZHGwlzpAUwrpWh8Obhg499a2S/f9lXs0o6DUuB4XxOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oLoeURDL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h9fvjPq0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IK2CA0022739;
	Fri, 18 Oct 2024 20:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eyzxNjLrw1xK/C5X4vogMUn1gtamQeRfK+4mSHb/pv0=; b=
	oLoeURDLahVcubhdXY8gSoUsgljv5nagd4WgDr3Orf8zteEF8xcwCXpXoHqlA7sR
	BwUo8sKDEdndxS7ut64Skp3UETuFsjWti/3OVs+q2WyE1CmZjynnjoZiQc8Llise
	WpvCpRJYoNVfTYrMgE58b7O4NbCVKS6lbFrwr7/F0uvWBpQYEr1dJjLvTsj35Jr5
	q9H7z8ckzWmN4e5pqZveuIPfLqYitEnAdtRbzwxPels/KDdb5sEr+AYCYG3w4q8n
	2De5CCrCMXe/fi3VwDZfVE2JXdY9lnInNK+I3eGpXetYDLLXSV2UIknjgqXvKl4k
	oRZRcB6Stu4Yijx41TFGng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5ct4q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 20:07:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IJrxDA027269;
	Fri, 18 Oct 2024 20:07:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjn64r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 20:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vREAJV7qhwytpqh5sF4p9301tdy4O6oaKpTHjL7BRTYmolW3kjizUYRW6e0SpZmzYfS771M7On81EQct+64wfhAMmBIdV5WTKd2dG0jujBwkom0YPDqLXA5+jejyweMaEU/cY//7YBVr7x28r1pqstZF7muGF11zHadijo53+ws/blgKykj4lOl1IUarFugSmDtuxLhTBVh4DHspPWRHgoruUWtmRQ4Rc7Tas1dKtOv1fi3OUSY2C9TO6FSBCevp7QkYvHs5y2NuFnppbc7yc+dSxAPcRCEKiSCy0HacjtZ4Rp37nQd7jtSGdgns+CPeKXF/6tdwbNn/8sHtYyDBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyzxNjLrw1xK/C5X4vogMUn1gtamQeRfK+4mSHb/pv0=;
 b=U1JYZZ1nh/h+j50D7RHVgu+9e4R7N+NIwWdVxHaiXq4A1LH+qXTwY1Qn49Xf2YXRmZgWMVQ4Gckyk0s7KTtr4zTNDQO1dsgachtvMWjlpzq6z6e1TEf7K/toIrqUSsIr1SFZNPMZPXCBp0TYDhfXz268Tmi06SWYOocmwLJmOBRkjA0hQzwcQrkcBaChVHvqDojGK/vRs3KRtTUfz7rQDAcZ8e+9iZTQDx+ENUV4iE+Fy8045D2h6a6S4XnP3lpBSoddEywfhVpxX9lkVEUmpYXKBo0Fzsr41TnfQGGzx2GCJyai91bf3OgYbJCPGd+O0ndfy3kY82Sd/axNKcXddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyzxNjLrw1xK/C5X4vogMUn1gtamQeRfK+4mSHb/pv0=;
 b=h9fvjPq0bKnTICauAWZ0XsHeHU8yn+uUwoR2gCvdXx1eSnNnw3qfmtp9bpHAdgArdA9PfutWdH+ao0PE0bzdd5ucbSSsikcAwMaI+fa6lsc0giAwonuLnhY/TBG9yOHwtORPz/1yLC9kFi6dXkAW7TxS5/B5G5Sdd+1atEd7HUA=
Received: from DM6PR10MB3977.namprd10.prod.outlook.com (2603:10b6:5:1d0::20)
 by IA0PR10MB7546.namprd10.prod.outlook.com (2603:10b6:208:483::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 20:07:01 +0000
Received: from DM6PR10MB3977.namprd10.prod.outlook.com
 ([fe80::5748:741f:2230:d6a9]) by DM6PR10MB3977.namprd10.prod.outlook.com
 ([fe80::5748:741f:2230:d6a9%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 20:07:00 +0000
Message-ID: <eb0c7c21-5a45-4a36-a96a-1abaaf3bbd61@oracle.com>
Date: Fri, 18 Oct 2024 16:06:54 -0400
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
 <aa4b6c90-6e8c-4943-ba83-6688cdf776a1@oracle.com>
 <3f096ba0-b6f0-4db7-9d65-ba0550eb98b1@redhat.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <3f096ba0-b6f0-4db7-9d65-ba0550eb98b1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::36) To DM6PR10MB3977.namprd10.prod.outlook.com
 (2603:10b6:5:1d0::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3977:EE_|IA0PR10MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fad0498-514a-4183-e731-08dcefb06d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnVPZFd5WHRVMXRhWmVLaFVwVFZsZU5pSDg5UGZXbVFJWEZRWU9XUVFlWHlu?=
 =?utf-8?B?NjUwVmJESVNVQ1RJL0dhR0o5ekNmeUwrOEVYcUVlWFVMb3JUNHdDUFpUSFNt?=
 =?utf-8?B?ZHAwNVdrR0UrbGdHbFZFNWl3dC9YNHFoczg3R1pNRldQbkt4WC9PNFVFbVFX?=
 =?utf-8?B?b0ltSEZTRHpXUGZKcnFPUG8wZjdNM2Y5Uzd3OEVHVVpLelJYNnFhRlREVit4?=
 =?utf-8?B?NWJ0aGZMb1hwR2ZxQnpKWDNvWkhlZEk4SnJHMklJV3M0cytycllFQTdESXd4?=
 =?utf-8?B?UmNRRXZXOVdLTUxUaGs0WUl5Y1FKNitlRWFpSC9sUDFtUUZ0Z2paRHFXTjhW?=
 =?utf-8?B?RXFxeHZkbW1kajgrdmpwRWhEeHZkRTVPdkg4U0Q2NXN0ZVBmaUJrYUZud0NQ?=
 =?utf-8?B?cEJ1MFRYYlV6Z2ZWTExLbmFZV1NSZXhIajRqbGp1cjIrdkEwZ3hlUlVkY1Vi?=
 =?utf-8?B?L3YzcGFXY0IxMFBnWFB0MjUyV1IyRTd3T2d6dTMvVC82U0dzd0hBb0dpUEVH?=
 =?utf-8?B?Z3dkaytSc1pXMWg2MVVlTlZBdFFYaDZENS9QN05hVHBESkx0YUZnLzJOU0xC?=
 =?utf-8?B?VkxMQmhyRS8waWFnRGV1cWxiQ3dFVm54OVZhWE5teWFnYmpsc3IvaGh5aWls?=
 =?utf-8?B?Slo5UDZBaTlqN2xmWUUvWFB4bFpwcmx4djFTVXBDKzcyRXdSbkxWK01Damg4?=
 =?utf-8?B?dkF1N3VnMzFDSWY2SEIyRWc5V0x1eENsNXRRSGNzdjFpSkZGd0g2ZmkvWkto?=
 =?utf-8?B?aTRPbmdpdUlIM0hWQ29uOW9NWHkyVWgxanlYYnV6cUZOenR4c0dOejdncEkx?=
 =?utf-8?B?eGpvSDBhclR4TzduQmgwQ0pMVjk1TjBRWjdMcXc5c1lxMlFQL0t6STFpZzJv?=
 =?utf-8?B?YkZKZnpVL3h0ZmJkNDVjN3pUTXVWNTI0TWg5SThrQnBFU0tZY0dwVktvY3Vs?=
 =?utf-8?B?emhNK2dGdmJPeDdqUW1uaDRXSFZFNmoxTlp4dXBZRFo4UnpPWE9NVjQwMDE4?=
 =?utf-8?B?SkVqanRxUk5mODBnQmovWWViZjBMQmh6Y3RMVVVvYldYYzRuRXpvQ1V4UXoy?=
 =?utf-8?B?bG5YKzRmV3k4K2ZDaC9YZlFKU0MxTi9CMEI0MnBKSEJiNTZ1SlRwT252cGt3?=
 =?utf-8?B?WHNRM2g3ak0zUG5Uc2o2aXo2b09DZGZQS1g4dDBjN2lnM2NrbDlpRnB4MmZK?=
 =?utf-8?B?c2s0NU53RU9OY0I5TXUzZGcrQS9pU0Fmb2Q0Tk1lOVFWSVRmQjVYaCtSUU8w?=
 =?utf-8?B?TGhZUkVvdVZTME53NjgybFdOMHRmMFBvcUxRRGF0THBlYWswTjQ4Zm1lYTNo?=
 =?utf-8?B?L2FITlBiMmRuM2E0R295VWJ1eEpXN0xIU2l0VDAwNlBZdFVCaWE2NmlSaWZZ?=
 =?utf-8?B?akxQdHprcjR4b3lsQTRuUUJIa0IzbHRHSmF2TDJrRzFxWk13d3NvZzRZT01S?=
 =?utf-8?B?OHpTYTdwcFd0K08zM0krVXlOTUF1aG1rYWN1ZDhmdFBURmg5RXk0b2hrVWNB?=
 =?utf-8?B?WlduUFRxSFU1TUw3L1FpVUl3eUlMZzNCSlpxZ2ZsZk1JSkdDWktwUUdJVHR1?=
 =?utf-8?B?OWxuYW1ld09zTlNZM09COHV6dmIwMFY5OFFBSjN4YUhESjVUMWEwbW5lV1ly?=
 =?utf-8?B?eUJ3RjNPUUdoY1VpWUpBb2gwZzBSRHFtTk5nSzRYd3l5enQwbFZQVVk3ZExr?=
 =?utf-8?B?YjEwZ1QrOG1kMGtRd0ZBNXdkMUd0b2QzdG04c0V1aHEwNHA5dnN1Qml6ZWdn?=
 =?utf-8?B?ZjNxbWVqNnVkZzZSemRaQnJIRnhKTE1QaFRLVmFEZm44UGFsVW0zajJqNzJy?=
 =?utf-8?Q?wR9fneSxORgy+wChNYmQvvAttvFRoPIeGd+XI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3977.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUlkeE9lSHlieTVhS0xVM09kMHhHNnptZThJYTUvRGFkdnR6eFRDcU0wOUZ0?=
 =?utf-8?B?MDZRWWNIM3lKMHFnVEZHRE5peWpZYjZVNUNpMTlSY3gzT1BxelNGUjRMb2Zr?=
 =?utf-8?B?aTczMC9QaGRZMEUycGQ4MmhxVmhUUzZwdGJsZ1NSd2Zzd3ErUGp3WVg0bktn?=
 =?utf-8?B?Y3dwYzFJQkt5d3VsVjRUd3JTRGZ6VHFBOVZaM040SWVleXU5UnArNVhzUnNq?=
 =?utf-8?B?TTJ0TkJWajNjVmtPdG9MRUs4S1lZMHZHeGlwZGtOdkJKdUhjbVU0SExzN2Rk?=
 =?utf-8?B?WHhDT3N4MXZwbHJGTktUMnIwYWIwYzNnMVRqcERBUW5HVkt3Tmo2UWU1ZGpC?=
 =?utf-8?B?U0NkZmhhQXg2bW1YNHVJSGVXOTVBSFVpckYwS2RRNVBIQkVxdlFsWXY5cWVv?=
 =?utf-8?B?TTUyUlp0eStwbjF1SERHcmVONlp3bkhCV0xSeHpLNFBkR3A1TExWOEx4dDNW?=
 =?utf-8?B?SHJUU3JzM0hwYklxTWM5clM4cFkzLytzKzdBOE1pZ0ljQ01lMVNpVUVxZjFx?=
 =?utf-8?B?TGpCQjNRQmNrZkRQZWdxWW5KcTM0dWFPWGVJTWVGQllSaC9aT0VqRFY2ei9k?=
 =?utf-8?B?bXcyeUpwc29KNjBjcER0WlZFcUF1dFZQdHYzVll5Z0dOakhnNU9GemVSK2Y0?=
 =?utf-8?B?NUxaMnZUK1VpZExieEdQYUk2RlQwdkkxSjFEdk8xa0dXZ2tCVS84L0c1MUhm?=
 =?utf-8?B?a3VZSSt3UFovVVBONGZsc3hlc0FMNHc4VkdlMzJ1TkhNSEZXWjkzNUcwdkUx?=
 =?utf-8?B?RGg3ekFGbzRRL3VVN0VsZnFxSldUNXFlT1N3TSt6OEdoNDVLTVZVT08rVitp?=
 =?utf-8?B?azFHejRuZFJORGZwUDZJbytIQ1pFMlZ0ZFp0RHNYNFoxZWlUWW8xRncxT0xV?=
 =?utf-8?B?akMxOVlUdTdQZHNIVlFDTU1wZlBsMWhVclpQalhSOUk0dDJ5YUNGVDdSNlor?=
 =?utf-8?B?K1hVVndOOVBONUpuZDRCODRsa0tpb05SMlBVVzNrZS9PR1MzNG1pT3lXV2lv?=
 =?utf-8?B?aGpXNEE0VUd3Rm0rdWY2b2FhdVFOQTh6Q3ZNYzlwbEdnb0dSbEZ1WCtPVXpY?=
 =?utf-8?B?V1ZNeitJa1NKM3pDUmZ4VUgzMC9zV1ZNcXk2S3lIbDZ2NXJYL3BweUZOSjlv?=
 =?utf-8?B?c1AxT2tROGFSYVFNak9xWEU3Zmt0VW0zL3VocGlYeGg2cDhHdWYwRGxCTjBq?=
 =?utf-8?B?OVpyNWVWTXJFRTZRU2krNENtbnJrYkZjV1ZxZEZYWWhBY01zRXFVZFB2c1lW?=
 =?utf-8?B?WHY4TGF4ODBoM0RaWHR0cmNVcEpkY3VRUXFCTEJpVDBLdFkwM29qRGltdkdk?=
 =?utf-8?B?dDlNSENHTWVMams4R3dTemFvYVJtbzgxVS96UnR6Y2RZZ3o3TExVN0JMWmQ3?=
 =?utf-8?B?TlhqSjNmYnhsNUZhaTdxQS90VEdmTWwwODBKWU0ybUJwc0QxbmhjWkJTUzR6?=
 =?utf-8?B?Zy9xbi9md0JGdG5maXc2dzFOQVVaQ1NOY3RnRU1QaDJFODhlaWVGanZkNWox?=
 =?utf-8?B?MS9CK3ZGWHRYZklyaVF5MTVKck9LQWUybzNGUmNsNm9mUDQ5bWlySEEzMnVy?=
 =?utf-8?B?cHZyWm5kMktoTU5td0JyRTNUNEorNGdpa0lDYkJEZnpzcjBmOTFlOTJVVnl2?=
 =?utf-8?B?Zk9Db21RN3RMdytEMGJZNFBhRkIxTXNMeFhhbFVodmkzREl2U05jM2xLZ1hJ?=
 =?utf-8?B?Wm41cVNxYWxSUm45ZHZBQm0xeWUyNWJtRDNJTlhBNE5ubFVCZUlsMVc3aC9C?=
 =?utf-8?B?bGIvZE5DRVFFT0dBUlJuRGVhTnhJWU94VTI1R2JUb0xLRjJsWGpQL2JUYjM5?=
 =?utf-8?B?cUxLMEE4WDQvVXkzOGFpbk9PWXNnZmRWQUZabzhLdTdYU01PSXZwSS9ZMlRn?=
 =?utf-8?B?RTZNU29WZXRmRjBIRkpoa0E3RXc0TmhrdnVKQWRlekJLK2dOUTlWTmZ4S0tY?=
 =?utf-8?B?L0NFTmNXRTIrOGJhUUtUc3BYa0daSVhWUUlRK3JuR1ZyeEFxMmwraHA0R0Fm?=
 =?utf-8?B?d2JkdFN5c1VjbWp5YnpxcEIvSWxRWGp6TWJLQWpnZjB1QmJTK1U1Sk10U2o3?=
 =?utf-8?B?SFBzTytlZkJHQy9uMS9sSjduZWh6Rms3dkRYczBRY2dNZ2RMQjJiRG1PZUJV?=
 =?utf-8?B?K3pWdVlXRUVQY29VYUFoMlcvNzNONDJEbWFVK3dNVXNjZC9UMjYyemFIWEZS?=
 =?utf-8?Q?x8NNM1JU4COseN8uI9/dJJ8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1a88BkLAxqZHMEXtl3ZHdNqbH14yo6VOwe8YiXVsTVnjguIw0Vy2p1LVIszS1tgTpoIs+Cya7NUtU3IzrCb857JVm45IFOPSQAxuz8M2ZHCZH9e1ZQ19nDnyC2TMQ8s6KYWj793pU4SXe/MllauMLz2ZvLdI1JFBlD27bTP/gxpPaFsYDwwC/H3KChQ4IEznrsngzbT0qn8wmXrIW4sLsS2o8oBvBdleS5MXuVqGFFUQr0MovOiht/efvywQmUL8iqr/cFRN8Q1Dl3bV813CYNQBCdep4zlDuO+blK+KdlPzYPTE7a16BRQYneD4TLys9ERCQ3qyZu9O0lkNAGK3fzlRIGo81AaZpYx9HZgNESNsef1FgacVB09WJBwMT6Ead/YkmNA88QlTpw2sbwy1pKgehn177p4v/zT9EqFjGB1yY8QJg4JljcJ0f1qi2LNp2aoKYDdh3CTVBjq0AfKGi+nV5G6DAiYbubOSvOrijCanHFAjnRonEk8WEZXuZxpYVP/ZvvQI/m0gW1a6bPcyDMKmvuhjT53zlLuFeTp+30NDuRlCuGxhSML/zr5ItqNB6g84asl5tQ6MRlh5j2DvbHMhBWu87d6PdX2ktndmznM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fad0498-514a-4183-e731-08dcefb06d47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3977.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 20:07:00.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxxilfjSlRD0zbg2NSp79XYimnVS5CcsUOS6D0bj7u31u+uUzgxCW6zMlIlwFzpjcWdzDPxqEoXJ1GeYugDXy5UfPRW9Uc5bjwR+IHSb9KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_15,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180128
X-Proofpoint-ORIG-GUID: f-r1a7HCt6VaCwLd_z08ozROnplT4Tqn
X-Proofpoint-GUID: f-r1a7HCt6VaCwLd_z08ozROnplT4Tqn




On 10/18/24 15:27, David Hildenbrand wrote:
>
>>>> Hi Ryan,
>>>>
>>>> First off, this is excellent work!  Your cover page was very detailed
>>>> and made the patch set easier to understand.
>>>>
>>>> Some questions/comments:
>>>>
>>>> Once a kernel is booted with a certain page size, could there be 
>>>> issues
>>>> if it is booted later with a different page size?  How about if 
>>>> this is
>>>> done frequently?
>>>
>>> I think that is the reason why you are only given the option in RHEL
>>> to select the kernel (4K vs. 64K) to use at install time.
>>>
>>> Software can easily use a different data format for persistance based
>>> on the base page size. I would suspect DBs might be the usual suspects.
>>>
>>> One example is swap space I think, where the base page size used when
>>> formatting the device is used, and it cannot be used with a different
>>> page size unless reformatting it.
>>>
>>> So ... one has to be a bit careful ...
>>>
>> Yes, that is what I was thinking.  Once a userspace process does an I/O
>> and if it is based on PAGE_SIZE things can go south.  I think this is
>> not an issue with THP, so maybe it's possible with boot-time page 
>> selection?
>
> THP is a different beast and has different semantics: the base page 
> size doesn't change: the result of getpagesize() is unmodified 
> ("transparent").
>
> One would have to emulate for a given user space process a different 
> page size ... and Ryan can likely tell some stories about that.
>
> Not that I consider it reasonable to have dynamic page sizes in the 
> kernel and then try emulating a different one for all user space.

This is probably  a case of ensuring proper documentation from the 
distro or application vendor.

Or maybe some type of "Safety gate" could be implemented outside of the 
kernel. Some check for the prior use of different page sizes, in the 
cases where it could cause problems.

