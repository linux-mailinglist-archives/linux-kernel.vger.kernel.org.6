Return-Path: <linux-kernel+bounces-171933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B98BEADE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9461F22410
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A5116C86F;
	Tue,  7 May 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AU2zUm82";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DyyfYTpG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444B16C68B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104470; cv=fail; b=a+zANIVesRUePHjPHZ4uKlcBn9DmXjPcjn249OsTYYarMRLc+MasVXcJEL3ZTfoghXbHoyVAhiLozFJxZm/HGucYZEBEO7fqC7VN6yo4+crcm9krIRJ/u5U7YVnFeyAvdqSxTa9PgBJAkf5t+arGT815llzC0JDafoiFHMYSS4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104470; c=relaxed/simple;
	bh=R0yIL4ffTlPlfxTZWpHnmSnVO4Kb9k+KfwXCeYZ0DRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SksSiQ9GCW15diwuhrPV8ZMeUBjZTsACSI1mqX+tS4LUABMyO7iCrBBAjEXYygV+XAr/XkgKgavCJZa28/NBGVfzOj8JsFHrkt9Umf2xOYaBm1OhWQ7qHq5hv1GcK2gqr6p1WX9GzHJpHauLVkOzKUbyn1or4bp5uznYb1LejDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AU2zUm82; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DyyfYTpG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447GX6VY004002;
	Tue, 7 May 2024 17:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PgSM+MmOr0Uw5cYTkvkis/dIy9nDUTnznQeZ4YvxW9A=;
 b=AU2zUm82hX5IF72YjlcwFEUeH0kpHFKbkiXt2OLT8/SaEDu/0fsY+/oX/mqY9Ll1W/Cu
 fIxu6cPyPG5IhZaQem6aGtMpISnxhZy6QshNvBCuZtPRWdaqtpbRhOWy6QLE+2a4Wj6W
 C2C2GzE1S6SKfTSeTSiXP+YE/L9x22iY6El9rMy/kptvNnqTLxYzsNm93kznz3Vy3KIZ
 zSZj4jG4kjE/+XIdzWhwbJhjv+jULu7+D556vkT8tXeficta/fdl0sGf50b+Y7C7yMrX
 BDe28gqHGjZasFP3BgCyLr5SW8bTMmD/PUj8lkQn20ImR8tCijlK8vzHU2MmEc03PRnZ XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbwnfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 17:54:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447HDDQx039370;
	Tue, 7 May 2024 17:54:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7ccww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 17:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ3JFQrQRBs++JM1xsoBh5UcNSnxfWyD1JyTpOmut/hJe92SIew8CkyFla+I5VT+uhuwy17JvNyiOp2zRYJffMQvv/r5673UhnXYc8MsdIraH1wJpI9ToMbyis1mGPtDG5XMTIhpaBKrD2Em8gze1q/vO8WUZj5x399gCAoBIEGUfTlrR7C3EMHdoYPy2WJk1+lvoDvJ88YNtQTMrCFbeLSYUe0ZvklFCAEAEQrzqlvrg1OSeWA0jGF4eXrlVTtGFAmhqeX8QuDl3Mlc5s04kRuEDbbfpEg9snjMFNr0eDF2DQM7IJ5ULw3dH07VK3mT0sRCUEYdfzcvQC11xj2V4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgSM+MmOr0Uw5cYTkvkis/dIy9nDUTnznQeZ4YvxW9A=;
 b=mja4kJEduORy9cS5An0wPaY/Hsz5RHGQInIUDiG+WRGJetlc3WLIp3vML5J5TtkbGmgxEwLttfaheXS5BZp6L1rIDT8+vUAhlMy2phY818bbgbBXArAxe/QhZuxuWF/bnRIKlSHvNu/bxg9HLHuT/OFB/bxug7XSWtVhLMH4T1iG+pfnGu0bFL9jMS2T3fm0rKWAgcpk3Kw7Gl56jcegFPGNsDRVljgPmFG9rchiWGq/fzFWxTzg5iAiJLSjnxp+rsR5uEeFNwDF+rGtj/5WPJy3AWQ/YImyUXfBmeBEjcoUEICu0EQFqU6KYgUV9DhcQMO2/CUDqx43NdU5PC5aMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgSM+MmOr0Uw5cYTkvkis/dIy9nDUTnznQeZ4YvxW9A=;
 b=DyyfYTpGre/IoIvAIeXiQL7PiuOBL25b1IBYuUuAZfdJs/92xz5sPaG+indECSIOAxpLtP8YOEdA+vCE1D6yXGC2xZSAr1CZIhQI07kVXEPoemAIH+Ln46bZ1+2kFdBdpAsUhgpykqC5yV06S8ZnuC88t2/XNjjyHNrfwlGGa+U=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4701.namprd10.prod.outlook.com (2603:10b6:a03:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 17:54:14 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:54:14 +0000
Message-ID: <2f965887-19b5-47bf-98ca-d40b3ec05e75@oracle.com>
Date: Tue, 7 May 2024 10:54:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap
 failed
To: Oscar Salvador <osalvador@suse.de>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-2-jane.chu@oracle.com>
 <ZjnuJgUVVnwYrr5p@localhost.localdomain>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <ZjnuJgUVVnwYrr5p@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SJ0PR10MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 829fcf30-c085-46f0-b8c9-08dc6ebeb4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YXY5c3JpSDVNdFBCU0Rnakg5WnhYNmRoMGF0YmI2UkhlOXZQSzg1UjdTK1hO?=
 =?utf-8?B?NDhkTXBOenh5NEdRU256Q0JFTC9zV0dhUFhNU3VmRHl4QS9xbEFNWEc2Zit4?=
 =?utf-8?B?NTBmYk13cXNlYXFQelBlNGxTV0VkK1NrVjZ6VDE4a09yQ2dQV2FwUG5nSG8r?=
 =?utf-8?B?NkR0LzF3VmVxZUtvZ1pFUkhGWlJTQWJnUjNud2JxWEpVZS8wZXNVWnIvb0Nm?=
 =?utf-8?B?bEk5ZVpFNWFYRTNQN3BVSXJxVWpxdnBOVEtaY0h0dlQzcHEyd1U5TXNMM3BW?=
 =?utf-8?B?WDE2ejIyeEdVN2tmY1A4L2t0TXJrNkZkTjVURHRtNk9TYmlCL2MvTUdMREFN?=
 =?utf-8?B?aHprSnlWdnhFR2ZFYmZRWDV3RDhUTUVhZ0t2K2JZQWgxWEI2ZUsxMDdjcEFp?=
 =?utf-8?B?QU8zeUhRa2tIYzVSank5Y05mZ3pndUhsMjJxTG9YZ1VhYnQ2KzlPZHdudkNo?=
 =?utf-8?B?UkRVUjduM3hrWXl2MnNjWEVCdWNPUjdOLytTMVJuYkkwa2FEWWE4c2RDVFBR?=
 =?utf-8?B?dW9ycXJFNEVYbXM4bUJlSktnWUNCZThQS3lDaFZrbHIwVFpGaEdSVU1VRE9C?=
 =?utf-8?B?Ky9ZcjlnR1h6alBHMmo2OVEzaDd4aC9SOEQyZVQ4UEEyQzRiL0NQYUJYb05H?=
 =?utf-8?B?a1MzUFZpWWgrbDVkcnN5b0JpUFpOQmhjM2ZRMnNCRTh4eExDenVRdDN3TUkw?=
 =?utf-8?B?WlY5Y0wwc2NLYWl1VU1zVW1OMi9mMURyNGQxUXFFaXVHUWZScmdIQ2FZYnV3?=
 =?utf-8?B?b0VPWHYzSGR2cTBMY0U5VnhmaitZendWdmZGaGtyZXhyc2E2L2t1UUFRWSt2?=
 =?utf-8?B?RFVMN3JyRTJ2UExJOHR3YmlGaDQ2L1Y5TDBsb2VYSzNKdFppbzY3TFhqc1d0?=
 =?utf-8?B?V3ZRVHFGQXU1V3N3OU1CZGNxQUhKT3NnWEhlMWJiT3A5SldXaDhSZDVQQVVq?=
 =?utf-8?B?VGlGMTkwSDRiNXF0T3pqYjg0ZEo4ZzRxVi9ta2JpdXVFTDVueUYxaktFb3Za?=
 =?utf-8?B?NldYbXA0VXh2QnZwbWM2T2t3UmZBQTJ2TGt4ZHp5THFCRlRrYW5kdXdiOTBj?=
 =?utf-8?B?NFB4MVF0ZW50UTRrZWFHbUFNMmhrYTFzN05vQVpPYm1mNXQ5NEpnTjQ1YU1L?=
 =?utf-8?B?VlhQNlA0aEo1UUp0Q2VZVGozcnZQc2RXTlRCUGkva08yYVJVMVErL0xjVUVC?=
 =?utf-8?B?VytBK2xITGc2d2tDNGpvOVZ6T2tLeHBvbWlnTVpnOTNIVmJMNjdBWW1OZ1dH?=
 =?utf-8?B?R1pmN1h2cnV2Y3o4U1Q2YWRZZGdQaFBVOEp1NVZEMEhwMUhoUXhsSnl1YUlH?=
 =?utf-8?B?OWVaUCtnK1ZjampwdFBYU01FVmhBZWZ0YnBMZ2h0S01tZS8xYVBpU0ZpaTV0?=
 =?utf-8?B?NWw5cUltakVCaGQ2UkJ6dVNiTUtQcEo4MlR5MVNFZWxzUUhQRSs0VXdybDha?=
 =?utf-8?B?UVhHeS9hdzRzbGZsUGQrL1lmVnRITms3RWRKU0xJa1J2TFpoU2s3UjQ0R2ho?=
 =?utf-8?B?VG9Pc1F6YWVHSjhlS1pUY1QxME9uNHd5QWdxcWFwQ0xjUm1zL0dpQkFSUGxB?=
 =?utf-8?B?Vkw3SkR1SFBtL3R0K3ArSk5zYXVuZ2tFWjNObElxRHJRaktVVWoycXdrRURR?=
 =?utf-8?B?ZVp3dlczZjNHMG1kbWRvWjN0L05zMDkrQ2RsMXhUV2hGeG56b2xoNkFDa2tp?=
 =?utf-8?B?aHdzMmpTUnY5c2pLNXBneGNEaXBBeHdGbldrNkwrYlVHb0xJTGJnYzNnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OW54ZjJRNTJBVm55Y2ZXY2dHME9aWVBCaDVoYzkreEgvaysvK2t4VDUwYnlO?=
 =?utf-8?B?b1pabUZNdzdaVzc0SDRQc1RLSjNCUlZ5b1lxVTcwcXk4TWlOVFZGa2NJRlNs?=
 =?utf-8?B?SFJPejVUMVdzV0p6RENPUnlobU9ZWUxId21xUWZWbTJoVVduNDEvSENuTUJs?=
 =?utf-8?B?OHlGR1pFWkRuR3hPT0J2cEVJWDAveTlwWjYvZkFWWGhIbWIyaWxIV2NBeE5m?=
 =?utf-8?B?OVBpMTcrZWdWOXpZamY5RDczdEMvc2FUcTBQY0lwVll3ZHdUdy80amJua3Bw?=
 =?utf-8?B?SzY1YUoyVkU4MXpEQ2FETEJHbG5pN0lwdXdPanlKS1hZWGwyeWpMb2dpNXNk?=
 =?utf-8?B?eGJjcjgyd0c5dVcxd2lWckZMa0RCMzlXekExckNvaFJZd2dEZ3VOa3o0YlR0?=
 =?utf-8?B?TjI4VmdjdWx0YXFaTFlBbC9HNUZ0bTdiS3lEOUxQVk54VHdHTlJTMWM4Z1FL?=
 =?utf-8?B?TjRpMlk2KzVtM2toTlhUTE5LYUtWNnY5aGVmMUlOaEZmVGwvUGFMMWZMTzIv?=
 =?utf-8?B?UUszbEhKdS9WOExMUjE1ZDU1TWtkK2c0WHVibDBOR0M4cGVzNjY3VkFSZEY5?=
 =?utf-8?B?eG5IaFJhVWlEUWNrSHpWdEd2Q1UzK21CdHNCRWlLekhRM1F6UGp6OXZBci9Z?=
 =?utf-8?B?aDI5b29MT2d1ZFh5V0xJMXdZdUV6TXg4NmxKSjFIaHRJNTdBT2ZCeCtRSXBT?=
 =?utf-8?B?MzFCZUFxU3lZdGVLSHhHV1IvSWszWU5BSGlQZWU1UUNnb2hlWkpZMjAvbXFn?=
 =?utf-8?B?TmpCejVXU3ZFWjVmL0hRclRpS1pweDJjT3hLSklFUFRWSHltbHRjOS85STNZ?=
 =?utf-8?B?Z09yczBVUk1MbGJqakp1VW0xZE9VWG00NzUwcGRhY0oxaWREVGlNRWZjYlhY?=
 =?utf-8?B?b2hldG5aeFV3RFdhYjVlait5a2NjcGJaNmxackJjWUdEa3loalFpdmdSbEs4?=
 =?utf-8?B?RXc4YUhlT1JtZlpYZFQ1dk03S3pWTCtJRWNMT2N4Tmp3QXI1UUpRWEtWaWZX?=
 =?utf-8?B?ZXFCdWtaTHlqWC9OZEp3V21nUTJjTFh1bHlFZWhzNEJiWFR5c2FtaHFPbDdz?=
 =?utf-8?B?d1h0UFRFei9WRzFMV0owd0FGWEV0R2ZGcENLYllORTUyQlBXTkRYL2Q2aEJj?=
 =?utf-8?B?YmtPdDJLTCtCazRqYWM2SkZtYk1Ib05URXZOc2I5ZndUMFVLbHdxbGdSdXVv?=
 =?utf-8?B?QVFOdXo0aVdhSENyZEUvS1FRemRzdmRZUktwOForRXRlR0lJZEFEdE51K1k5?=
 =?utf-8?B?dGI2Z015VWZOZEE3ODhVNnF3ZXNzemxaVzF6dlFRQXJMa3MxNm5RZ2NoN1lR?=
 =?utf-8?B?WTgvWXpGbVNDWWdqSi9hYW5pYy9zaWFBTnVqSHVialg3QmN2a21xMy9wZ205?=
 =?utf-8?B?V3lpU3NkcGtCV05vTVZ1eURCRHMrbHE1WUtXY3ZJellxYTdoTWRzQkdnVG00?=
 =?utf-8?B?UUhqdmF2LzBTTmFRbkFscmI4dDdmR2x5SjB2anB4M25hNUVhKzFyNFlEVUhr?=
 =?utf-8?B?TXVMSkM1enhOdTVzZ3A2STNzbXJaczg0WERHbVp2L1RuYklhdFBCenlNUVlI?=
 =?utf-8?B?TVdWbEZmQXVnQWxDYnRUOUFaNC9nWkhkT2hJaUVwbUdzVFVQOHl4czJtcU9x?=
 =?utf-8?B?bVNIYkNTdDVOUjJYRkFHV2RnelRGUDBEZmQ1Z3htV2RGSUw1YUM4OXQ5UEFn?=
 =?utf-8?B?Mmo5WHBSSGlSbnIyQ3ZKSjdDK1BzWTcvRGJWZm80MkM0U3o3emNWK21CSEEz?=
 =?utf-8?B?cnZQTE5ucjZrOTVBN2RYbXZwcDZvU3VCQlZTT1B6aGpmMHJmTlo4R0tkdnZV?=
 =?utf-8?B?M1JRSExWU283RkcvWEVRY2JyQ0RLTW85dFJqRmpYSVhzbXUwVGRkUnlsaFhn?=
 =?utf-8?B?bjJBMElZM2NwdmRjWTJEbXhNYlZQNUgwVGZMY2Y0cGRxQnQxQzNoU1ZBN05u?=
 =?utf-8?B?UGs3enZiT2tUdE1aOWVOVWVyakpPc3ZtaUNSRkljSDQ2cVByOXpNOE1vSlMx?=
 =?utf-8?B?ZjR2Skk2dHE3eHJVdHI3QnZ1eU5qNlR5dnRZcVN2ZGdmSmlSZjB1VFlacWVq?=
 =?utf-8?B?YWhtVXhnbUlkTnBEYjRXVEFFeEdjZXJqcU1YM05TRkxyZDl5Yk5iYkY5MC93?=
 =?utf-8?Q?yhSjKGNd+q9axmkQPBJkAD10c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+MdNOnfB2xcWFC/wHxTlBUNcqR7x2usl8BbIRqhDial5rLrHpg1y+9BEaekb/lO7/id5MI69+rfG4EcPAzwRRtBpiU8vOF+IN5SMZTOtAKg9P1MLR97i8bXacyL9kwug4/SkMqT3MThk6ct/QvXVhDeLGBfrN+8FGPIrtM39S89iBdmxej4MVAfv6+xk6hefvzg4jvmPTG91iJHj8cpIQVOPQ33brHNkssjw8I9dEJ+F3bWY6K19yZu8AG4IOwcCTEIRKV20PzsN54QYGioAQ91vaWm8JBp1Sc+/AmY0XFbf5kVWlf36zJLer2cRPcFX6kkIqrqYFEmfz/rC05QhzdKrp7XcaeBOBLOd8pupL8J/7ZnyKkcvBlaIFrRCUnKdflfF57MyA0xEWvetuWpEfiSyeX7azZGoWoK3VTN/qCUFkpDjT+ZtVE7JnrsmrkvQxHEsTGMbjjCPdqSzoObuCTMlarP7rIu9W4gBFtVF1RZs288JQ3MR8EkxXneGQt+qxdY87tmsEtUQtREoZKrdUNg9C0ZlrZ8DDZxPXJzfi3ZZ7zHgFaAF/kpr8k3a2RHuEwu77xgZ7oiJzvaIQhFqkmkJM1pBNEImqUE7HKtKAJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829fcf30-c085-46f0-b8c9-08dc6ebeb4fd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 17:54:14.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i0wrQyOZRLu33wJzVDkQSqUO1tVBpuisl5li6Gs6yoq4YGLSKrJ3DyzdDdhWpg3ForazY8ftDsqWYP9OyWMtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=939
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070124
X-Proofpoint-GUID: i1P9G7gCWiSpPzO8haAjxRJ43a8WUqF0
X-Proofpoint-ORIG-GUID: i1P9G7gCWiSpPzO8haAjxRJ43a8WUqF0

On 5/7/2024 2:02 AM, Oscar Salvador wrote:

> On Wed, May 01, 2024 at 05:24:56PM -0600, Jane Chu wrote:
>> For years when it comes down to kill a process due to hwpoison,
>> a SIGBUS is delivered only if unmap has been successful.
>> Otherwise, a SIGKILL is delivered. And the reason for that is
>> to prevent the involved process from accessing the hwpoisoned
>> page again.
>>
>> Since then a lot has changed, a hwpoisoned page is marked and
>> upon being re-accessed, the process will be killed immediately.
>> So let's take out the '!unmap_success' factor and try to deliver
>> SIGBUS if possible.
> I am missing some details here.
> An unmapped hwpoison page will trigger a fault and will return
> VM_FAULT_HWPOISON all the way down and then deliver SIGBUS,
> but if the page was not unmapped, how will this be catch upon
> re-accessing? Will the system deliver a MCE event?
>
I actually managed to hit the re-access case with an older version of 
Linux -

MCE occurred, but unmap failed,  no SIGBUS and test process re-access

the same address over and over (hence MCE after MCE), as the CPU

was unable to make forward progress.   In reality, this issue is fixed with

kill_accessing_processes().  The comment for this patch refers to 
comment made

about '!unmap_access' long time ago.

thanks,

-jane



