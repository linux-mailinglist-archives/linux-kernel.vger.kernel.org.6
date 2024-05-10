Return-Path: <linux-kernel+bounces-176016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C5E8C28C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3531C2173D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59A176FA7;
	Fri, 10 May 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RnXTlB29";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IfT9wu2s"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A512C526
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358537; cv=fail; b=gVNc2hq/45EoLuS/JWahJcHoZy6CThihxbf2PzlIU2zjZDnTvTrkedpUewiRM510p57KhUEDp/rX2ubE782y9CTqbliY3OoK1jpT14uQUdeZjWxECj81A9acergk8HUnqaHZyTpnE2u8/HbTIqONUzOC39Usyhe/QSyPFkJM49c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358537; c=relaxed/simple;
	bh=qj5O3LiI2DsWwMa8RD/PjEuHerUgD/ZVDW0ag/jtiz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NM1PL4DTWFWjo2Gc+d6OOLTitpb9bmx/dGOBVnSzpxwVPj+VDEmlwax6jc13rffqPOKUemUKOtePlo+Gd5wsmN8SEDdSgtO3ybqGZbjad/O3YXV44ShLb5WltKbAGh8yrtYgde70fDegPAbOop9/WzIjfyjui1BatN0Sjs7jNP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RnXTlB29; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IfT9wu2s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AGOsJd011941;
	Fri, 10 May 2024 16:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qj5O3LiI2DsWwMa8RD/PjEuHerUgD/ZVDW0ag/jtiz0=;
 b=RnXTlB29jTe+QQB6nEwRkX9OofhI/UfDUfjyMJmoSNWd1FqItUtGeyWmjeMFK3BzbxZp
 LWjWtUhKNwnplvDvxIk/IPuL4NnNMnbjVnhNKVWUmsh+WL+GI0zhxvxNdSeVlHIlwTId
 XGvbRaAgjpa2VcUEWniHdWfV1/D2AC/Q+8AH+A/MHYdlpNzvZax4ashwgIm67AZgZS8t
 /Don8RnDcKLv2AcQKc3124oYqDSVSx4c9Al5q2Odq0VGQ/Wrds9aqJ40nT5WMkt1IOLY
 FrsHrrc0zHWrMnUWwdXU7NnBXMOMjas/jJQQ281Qe7uARS7Qr7+7DVgrEkc+vrab8tSO QA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1pj3g20u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 16:28:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AG93bk017850;
	Fri, 10 May 2024 16:28:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfq2w7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 16:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arjDufocpZ0WBga7NzGsyj5Eo3SL8JaieMyToZjS4pD1rkt464q1UuFLL1O85qZFUmeALzXKmP4hgxZtzaH/xvXh84PWso9IW9fqjM7us4kyCfcsR7zzcpXbN/p+NKOs5nzGgWpmGoS66mpzyOD2nDqggR7TyDOZN1JkNX805yDGomEeNxWT6ujD6ZkzL3cwSb6RrX5CN7C04SWt1WDS5LOyVKUdKHb6DNwf5GmdJTH0S8pr7F6fzQUGSq6TAWZaeRTxNF6PkrYWTSp+j2SgFk4JPBPByGdz9gzVZAA7yTpXXIrpZW0u+ew4Sn3QJkc4m3NlHC6Z2IKAFz6ia/P08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj5O3LiI2DsWwMa8RD/PjEuHerUgD/ZVDW0ag/jtiz0=;
 b=apZQ3WvibQpO3TzK0DKIfHw7Wy2wnjFrTUCDd4C4o25DoPsQY3UrOKGC/oh7/QfLCcVMdeDDgr6ofDgDT+WtPgM29V8jKasUrIaLBEjBMFAftBFdervL7bkD6xqhVATN/GsX/M4vG+iBbTVF1hnMkk5WmvYJxcKFcqS+y5SVl6vySa40yMpuQ8jFsCDKIZqpR7uEPqNjX4knq/mps7foz02rt1AwLtX4zL/b628ot4NW0bx6zQkLWb/W8rmgS0yMPNTQpD0bK0pGHlqPgEHuR2BuoQTf5zZVrAvvvPMv/ZEOKmsD0eTV8RID+QKha4G43429hkfuk4acs3JNHtrSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj5O3LiI2DsWwMa8RD/PjEuHerUgD/ZVDW0ag/jtiz0=;
 b=IfT9wu2sHIry50d16iOp7/5Vv4eN6KE8fM4Il6tSwi5jb9RJVd/vT6c7BqBw6Bt0oAOm+doXolz4o5CsjH/ucnvQ7Z1o5dfX6GKsD86oyZjU7b+jBCS+u4nIwcCzbcLwUcAC/rKJDLRl/hDsoS9jg7E3LxlKwIVggQuBBjHXa/Y=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by PH8PR10MB6600.namprd10.prod.outlook.com (2603:10b6:510:223::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 16:28:31 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::e826:67e0:4e6b:51e9]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::e826:67e0:4e6b:51e9%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 16:28:31 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: David Hildenbrand <david@redhat.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "muchun.song@linux.dev"
	<muchun.song@linux.dev>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [RFC PATCH 0/1] Address hugetlbfs mmap behavior
Thread-Topic: [RFC PATCH 0/1] Address hugetlbfs mmap behavior
Thread-Index: AQHanPaLSH3Q8HWEDE6RoHi6GjNJRrGLsmaAgAHl8wCAAAgAAIADE90A
Date: Fri, 10 May 2024 16:28:31 +0000
Message-ID: <AE7FE90E-4799-4691-876D-84B03F97F1CE@oracle.com>
References: <1714699270-7360-1-git-send-email-prakash.sangappa@oracle.com>
 <901d53f0-1cbf-436e-8ccb-875680dbc1d5@redhat.com>
 <0C0831EB-AA56-49C9-9D92-460C0FFF9BB5@oracle.com>
 <c1b69c38-59c8-4d27-9ff5-bcca553da7c2@redhat.com>
In-Reply-To: <c1b69c38-59c8-4d27-9ff5-bcca553da7c2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|PH8PR10MB6600:EE_
x-ms-office365-filtering-correlation-id: 89694d3e-0873-45d8-6988-08dc710e3b0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bWMwRGM1dzBpd21BZ0FNNEU0bzhVcXdXQmI0RW1CWjVTeFFUZGJOU2d5NDZa?=
 =?utf-8?B?ZjRsNWd6a3ZYalUwMk11ZVlIZlhQSmpnRCtsVlNSM3djNWVzRTRrOVo3azEz?=
 =?utf-8?B?cUV5OENBay9jUWs3UXczaC9zNDZ3MEhnd2M4MXJkZm5MNzdUYW1zS0lDekFB?=
 =?utf-8?B?K2NhVzJHckc1Y1VacEp0eUdiRXMwNk8zcHpMcnNqVy80YVdWbjh0MkJ5NmlH?=
 =?utf-8?B?UjczZW0vWTc1MFBQbGFWcWdVRWV0UjJMRE9hZzJLdDA4RnRjOHFFbmcwNjZj?=
 =?utf-8?B?NGg5VitOTmNBSmxlTW5kcVpCdmNxNTZJeWdIb3M0QjZ6UXVtUjNkOVhMdXl4?=
 =?utf-8?B?TWlaRS9YS28vYUdnNW9SNC9oTk9oaVRMbE9TaG5ISTYwYnRxanA4RjJsLzdW?=
 =?utf-8?B?OUJkblM3akY0akNvcU9sY2lkUDgveUV4ek1YSjlvSSs5ZFhOWmtkNTBHNHdz?=
 =?utf-8?B?RVFBWjQrbHlFVEgrUjB6d0RrVld1R000WnpuRGdDSXBUSTArYmVpcXRCWUhl?=
 =?utf-8?B?T0YrbFNqc3VxaWphRitiNm1MSWpqejhjV2tNSG9kWTBMWkVDU1FKMG9ydHdQ?=
 =?utf-8?B?WDNuNkdKWVA4OE9HcHhzZ0k3SWlOd2FyRzNYTjdobXcxMkF3M1RIYVVVU01B?=
 =?utf-8?B?cTFqemJFeFVrdCtXQjcwZkpVR1l4Nm1oNEd1MURMamdXcnhCanlMdlBNUFVy?=
 =?utf-8?B?R2s3OWVuQ2tycXU2ZEt5TCtYeGlNYWRyckZwbHIvdzF1Um4yNitUaFREM2Z1?=
 =?utf-8?B?SEt5YUtQQk9aZko2WFpKbEJZbG5GaWxNQUJzdGwvSWo1Rmo1NFoxendFendC?=
 =?utf-8?B?L1lCdVJxWUVWM2lIdFBjRktFeGVUek5qdC82MVdWYjg5MFppMHNYWllGd0U0?=
 =?utf-8?B?VDByQWNsblZtTmhMemF0NGJtTXlHME80NVR3blVwR3JBOFp0Q080b1VXZ2U0?=
 =?utf-8?B?L0I2RmxlNkhPTUJCN3Z0cmVPL2NFVWdjU0RVOUwrdzZYbndNemswYWVCVXkr?=
 =?utf-8?B?SG1KUkNlZlJjallYdS8zTDhSL2s3cE16NkhZbmZkWmdzbzR2V0I1NTllVSs1?=
 =?utf-8?B?REIveEdtVGt0WnJnbjRFd1JTam5JNXpGQVhrSW5aY1ExQzViOTJVNWI1TDAw?=
 =?utf-8?B?SS91VWw1Wjl6TDJ6eFVHcklwYURtTmwxdUVoODkralRPZGdieWNJRkQzUFlU?=
 =?utf-8?B?anRNZUtjOG9RRjg3T1IwWHMxYi9BR2s5ZjFZdlhiNDRRNFRWeWtMTGdiUlN3?=
 =?utf-8?B?ZG9vaDdQTEE3STBtQy9xQVkycjdKU2lQVnRmSW5MY05SOHFFMWxybEF4VDk4?=
 =?utf-8?B?LzNKRk5MdmkvNWpiLzZweFZzRkVJUVIvYnBmUER1WWs5cmlDa004RVQrOHRw?=
 =?utf-8?B?TG5yR2JGRmlPRTFsaFU1WEJwMS9UV0kybk5OSkNQL1RHQVlYU2JnWnVNelZT?=
 =?utf-8?B?ZnAwT1MvcjlUVzNWaGR6OFM1YTV0ZmlvY0pUYlVpWWpWVXR0Nk04RjJVd3hX?=
 =?utf-8?B?akgxVUovWTNuaGtHeE42TUhDdWNiQ2diTlM3NTZicGZmUjhmRGFzUkVBaE5Q?=
 =?utf-8?B?VEdzRklnbnpGZEtTU0tlcDVTOEx0VzV6UXAyaGVLWnZYUVpQalJINm9QVFcw?=
 =?utf-8?B?Zk1VY2tBUVpST0V1ZzhHVTVvei9VYUFQd29lMDRLTElNK3FXNGVwZUE3Y1l3?=
 =?utf-8?B?aGJiOFVyd2VBc3Z0QUxlaDJLUVdzN3VWYll5bUc0dFlweWM3NHFrRWN0azk0?=
 =?utf-8?B?VFAxbVA4VjJCRkpCTTBmTHlvMGtTTE8zMS9SeFlCY1JCdHRFRzNOOUhQZDhJ?=
 =?utf-8?B?UURCd0VxRHQ5cmQ2a1BaQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UHFCbk5hTjRnT0pXNytUQlk5WXdFMjFjdkViWHdnK0hDR1lNbDR1VmxrV2to?=
 =?utf-8?B?L2UvVVYvcVhDQlZ4SWdrK0h0a1JIQ3pieFc5QlZrWCtiSHNXSWh5NUVjM2NY?=
 =?utf-8?B?OTBucWdLc2ZkWlZMd1UvQ3AwaGFOa3Y4VzN1ZWFUQ1N2Q0htN3ZhS1BpbUlC?=
 =?utf-8?B?V28yTFNtRGZmbzhjNDNqdzUyM2c3WTVXalpJWEp6TW9UZ1NoT1N1eTBQKy9X?=
 =?utf-8?B?L1RGZS9yT0Q2dDJwQm93VlplWThrZFQ2eDhEd3BWZUdqVW5vWFpCc2w4d2w0?=
 =?utf-8?B?ZW9kNkdvNFlaUzBzZGMzdVdVTUVJbW5IRkU5b0RpemFxaUFqbWlZTW1OU1dG?=
 =?utf-8?B?YmVGMXJtZlpDR2FZdTBjV2s2RDY0OVh6ZU02NjgwYS8yMnBtSWs2WGpLOXAz?=
 =?utf-8?B?T3FpQ0JnRXFnaVNSVnJyZWV1d0FSMEJOVzVIbVJCV2pZYWpiS1FQMmdhaVVo?=
 =?utf-8?B?VVJXTUNtRit0V0N2V2lBbjE0VUNYcFdsYWExY1ZLZ3A4elhCcUY3VjZXQ1RD?=
 =?utf-8?B?QjJ6M3F4emdmNXd4NUhSajgvNXdHamoyZ01CeHdQa3dJc0RoalAwbm9haktx?=
 =?utf-8?B?RDNxSTZZTVZvNDl4UU13c2RkWWMzQmlvemFKd3B3d3Q2ZHgvSHlkNmtiZWxH?=
 =?utf-8?B?RkFORzRZU1NnQWdiK2crRUNTVDYzQnA2SkpET0FEMEdZdlN1SGhNcFdoYWo0?=
 =?utf-8?B?bFhZRzNjMHhtTHJlbm9OMklLdWxFU05BN3VXYitEWTVjMUs4ZnZHQmRTQlRm?=
 =?utf-8?B?enBZdE43RTkwcklRa1NNcE5BYWIvMEorUkV3ek84M1F0cXhvdEx4UXFOeTZn?=
 =?utf-8?B?MGNuM01DejN3Qk5pVWJqendKV2JGL09KRS9LU21qUm1iUlJCYWtoZldGRlRO?=
 =?utf-8?B?K29sVUZBaEhSOFRCQjFGM3FDbzU0T1pFaUNmTm51bUxiRUU5blVtNkdTWkln?=
 =?utf-8?B?MEZNcGdFbGFubk1UamhjNXRHVmFXM1FDbnJCdlA0MkIrODdXNldTVVJLVGp5?=
 =?utf-8?B?VlVVbGVvc3dBbzEwUURoNHZsRlBkaW12VlBGWUx6NG94Y1QwZ2pVam1UZDJU?=
 =?utf-8?B?RjZXUkxUV1VyNFMyRDhtTEV0bmZqSjg5dUFBNHlEVjhYSlVaT09oUGpyejQ5?=
 =?utf-8?B?Z3NzcUlQM2VCYVZCZkZDZjJoNXhtN0FCTXlhYW9EeXBtTkloa2JMZW9mU0VU?=
 =?utf-8?B?UWQwUkhYM2czMDJHemdxMzZZS3V0WW5LMi90eHRqZHVoWFlIcHdBUjRyOGN3?=
 =?utf-8?B?WC9DbHdCSHJFWHg3VS9yelJIeFJDRG1Ha21ab0MrWkNlVktEazUyQ1VEUHM2?=
 =?utf-8?B?ZVQvVkU5SEhwK2NDckFUQS9JdnBYWUh2VjIxQnBiZHUvQlcrNHJzeC8wMGZ3?=
 =?utf-8?B?ZGMyUEVRcDZoVDRtckpCcnhrUXhCemRZZW5ubmQ1RDlkQklrL3RGMzNVTWo4?=
 =?utf-8?B?aEJ2MjRRbVJuNkxVWnEwUEswRGpRcjJmWlQrTnd1RE1hR3dTSXE0aVN3dEwy?=
 =?utf-8?B?WDQxY0RvR3FpTUZraFQxWTNCRTZ4QjM0RjNMdGN5aDBXSEVIQ3g3RzBlVlIx?=
 =?utf-8?B?UU9IbE0wSWV1akRRVzJRSVdVMnNKN29kSmNOeFI2ZkhCNkVPa2FuYWVzZE5C?=
 =?utf-8?B?YTdWb3JwdHkzcjJHMk8wZU9Sb0NqQkZGVlJvb0xLWGh5NW5lY2wzYjA4amk1?=
 =?utf-8?B?UzZubUgwajhxaWhSOUtIekdSUGtwSEZGZWtSZlptb1VyV3dhSHo3dWx1ci92?=
 =?utf-8?B?R01EUEtCS1JMMm9acFpEZWhoaDFOQ3B6WlU3S3ZBY2h4UVhGZm1NcWcwNjkr?=
 =?utf-8?B?N2RHSFFpS0g3YzAxbXRyZTlVcnM0U0JCRndOTVMyWFYvbGY1ZTNvdzZtR2ZW?=
 =?utf-8?B?UXREbzN0aWt1ZDBrcVVBZzAvN2NkUDh3Qi84eDB4eGJiUkxhcWlvRVcrTjNo?=
 =?utf-8?B?VHVvTUV3aW9YWVlRTmE2NmNMaThhTm9DV3RhN0xMV0dLRUpvSzJYUVUzM3Ru?=
 =?utf-8?B?ZWFOWEFNUEM4a2RET2twWWEreXdESDROR29xbWEwVE0yYkNMS09VS254SUtr?=
 =?utf-8?B?amkxdHFpOFpUNTd6dzRjWDVIRG04d09CTFNTRUZiRldpdUUrZmsrMW1SS1Jq?=
 =?utf-8?B?OVRxYXhnR1pFRElSc29jYUR0cm91RWl1SkpnNVB0N3krR2tjOEVTa05vNURq?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D05EEFB60990B841AF13607E2B1F5182@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vzCc7pkRCu5Fnb6JS8iMzZCtYEKhl5bZOCoKXd4EPp16Ki9o4RbLofDvFDZU/kA3YVG078IJFbS2wNpphqmmkkvayO+3YS8xVkwSVKmv35UkB13yMNidp07GDYhonalEPiUekO2yVjYbMank00z8ha0mYrnx/qVigde+I+tl9b7+IYTe2UsQnvgPNIJBcX7e3luRkOeyvHfpX1DE/eBANZvizw2tS3llqIWdfJPkBBgG1ShA5Di0mu5/pOdbvNCf7LZQbmHS5iI7wbdC3XI4XGU9O4a7PN4203UyQDCmzbuvZmRc7UUuUM9MMzxm70gUhqS82tmEBbKIoAnGdgHmYdBkd2C93wJaeOWUxfSshxCnhCzecSXdCVwrq8isNhY4ghzuFNS675Yw8ujDdqKQkPVxwMbcRn0/EnId1xIrshCaBxljDS6t8cYtd1ihrsYsuAaycW0McsqMrLUKXoLQyBemmTyTSYMOJx/ZbYb92tSGPNW3+hjfGOXbqopVcxSTE0bd5Js9aIsQz/a8xxjSGWj/NhzELa2uvZ4RUaFgSDSPN3M/ioVHnjYfgKaKSdxUVcaDHbQd5+fXqhDcBxRd2Pw1mRijcx9q3Zz9m8kLWMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89694d3e-0873-45d8-6988-08dc710e3b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 16:28:31.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2JEvR8jDS019M4MTZywbuLqjO6w2oKlLGi/pxK6IrmNfeAoMLm39n5GkgoHc3G0uCPqtIehb8QZT8Vbeyy/+uo67EL3CICTiQxhYQXbNaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100119
X-Proofpoint-GUID: MHUYks1pTEmjsx0TwB7zEqj0cF87PSrR
X-Proofpoint-ORIG-GUID: MHUYks1pTEmjsx0TwB7zEqj0cF87PSrR

DQoNCj4gT24gTWF5IDgsIDIwMjQsIGF0IDEwOjI44oCvQU0sIERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDA4LjA1LjI0IDE5OjAwLCBQcmFrYXNo
IFNhbmdhcHBhIHdyb3RlOg0KPj4+IE9uIE1heSA3LCAyMDI0LCBhdCA1OjAw4oCvQU0sIERhdmlk
IEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiAwMy4w
NS4yNCAwMzoyMSwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+Pj4gVGhpcyBwYXRjaCBwcm9w
b3NlcyB0byBmaXggaHVnZXRsYmZzIG1tYXAgYmVoYXZpb3Igc28gdGhhdCB0aGUNCj4+Pj4gZmls
ZSBzaXplIGRvZXMgbm90IGdldCB1cGRhdGVkIGluIHRoZSBtbWFwIGNhbGwuDQo+Pj4+IFRoZSBj
dXJyZW50IGJlaGF2aW9yIGlzIHRoYXQgaHVnZXRsYmZzIGZpbGUgc2l6ZSB3aWxsIGdldCBleHRl
bmRlZCBieSBhDQo+Pj4+IFBST1RfV1JJVEUgbW1hcCgyKSBjYWxsIGlmIG1tYXAgc2l6ZSBpcyBn
cmVhdGVyIHRoZW4gZmlsZSBzaXplLiBUaGlzIGlzDQo+Pj4+IG5vdCBub3JtYWwgZmlsZXN5c3Rl
bSBiZWhhdmlvci4NCj4+Pj4gVGhlcmUgc2VlbSB0byBoYXZlIGJlZW4gdmVyeSBsaXR0bGUgZGlz
Y3Vzc2lvbiBhYm91dCB0aGlzLiBUaGVyZSB3YXMgYQ0KPj4+PiBwYXRjaCBkaXNjdXNzaW9uWzFd
IGEgd2hpbGUgYmFjaywgaW1wbHlpbmcgaHVnZXRsYmZzIGZpbGUgc2l6ZSBuZWVkcw0KPj4+PiBl
eHRlbmRpbmcgYmVjYXVzZSBvZiB0aGUgaHVnZXRsYiBwYWdlIHJlc2VydmF0aW9ucy4gTG9va3Mg
bGlrZSB0aGlzIHdhcw0KPj4+PiBub3QgbWVyZ2VkLg0KPj4+PiBJdCBhcHBlYXJzIHRoZXJlIGlz
IG5vIGNvcnJlbGF0aW9uIGJldHdlZW4gZmlsZSBzaXplIGFuZCBodWdldGxiIHBhZ2UNCj4+Pj4g
cmVzZXJ2YXRpb25zLiBUYWtlIHRoZSBjYXNlIG9mIFBST1RfUkVBRCBtbWFwLCB3aGVyZSB0aGUg
ZmlsZSBzaXplIGlzDQo+Pj4+IG5vdCBleHRlbmRlZCBldmVuIHRob3VnaCBodWdldGxiIHBhZ2Vz
IGFyZSByZXNlcnZlZC4NCj4+Pj4gT24gdGhlIG90aGVyIGhhbmQgZnRydW5jYXRlKDIpIHRvIGlu
Y3JlYXNlIGEgZmlsZSBzaXplIGRvZXMgbm90IHJlc2VydmUNCj4+Pj4gaHVnZXRsYiBwYWdlcy4g
QWxzbywgbW1hcCB3aXRoIE1BUF9OT1JFU0VSVkUgZmxhZyBleHRlbmRzIHRoZSBmaWxlIHNpemUN
Cj4+Pj4gZXZlbiB0aG91Z2ggaHVnZXRsYiBwYWdlcyBhcmUgbm90IHJlc2VydmVkLg0KPj4+PiBI
dWdldGxiIHBhZ2VzIGdldCByZXNlcnZlZChpZiBNQVBfTk9SRVNFUlZFIGlzIG5vdCBzcGVjaWZp
ZWQpIHdoZW4gdGhlDQo+Pj4+IGh1Z2VsdGJmcyBmaWxlIGlzIG1tYXBwZWQsIGFuZCBpdCBvbmx5
IGNvdmVycyB0aGUgZmlsZSdzIG9mZnNldCxsZW5ndGgNCj4+Pj4gcmFuZ2Ugc3BlY2lmaWVkIGlu
IHRoZSBtbWFwIGNhbGwuDQo+Pj4+IElzc3VlOg0KPj4+PiBTb21lIGFwcGxpY2F0aW9ucyB3b3Vs
ZCBwcmVmZXIgdG8gbWFuYWdlIGh1Z2V0bGIgcGFnZSBhbGxvY2F0aW9ucyBleHBsaWNpdHkNCj4+
Pj4gd2l0aCB1c2Ugb2YgZmFsbG9jYXRlKDIpLiBUaGUgaHVnZXRsYmZzIGZpbGUgd291bGQgYmUg
UFJPVF9XUklURSBtYXBwZWQgd2l0aA0KPj4+PiBNQVBfTk9SRVNFUlZFIGZsYWcsIHdoaWNoIGlz
IGFjY2Vzc2VkIG9ubHkgYWZ0ZXIgYWxsb2NhdGluZyBuZWNlc3NhcnkgcGFnZXMNCj4+Pj4gdXNp
bmcgZmFsbG9jYXRlKDIpIGFuZCByZWxlYXNlIHRoZSBwYWdlcyBieSB0cnVuY2F0aW5nIHRoZSBm
aWxlIHNpemUuIEFueSBzdHJheQ0KPj4+PiBhY2Nlc3MgYmV5b25kIGZpbGUgc2l6ZSBpcyBleHBl
Y3RlZCB0byBnZW5lcmF0ZSBhIHNpZ25hbC4gVGhpcyBkb2VzIG5vdA0KPj4+PiB3b3JrIHByb3Bl
cmx5IGR1ZSB0byBjdXJyZW50IGJlaGF2aW9yIHdoaWNoIGV4dGVuZHMgZmlsZSBzaXplIGluIG1t
YXAgY2FsbC4NCj4+PiANCj4+PiBXb3VsZCBhIHNpbXBsZSB3b3JrYXJvdW5kIGJlIHRvIG1tYXAo
UFJPVF9SRUFEKSBhbmQgdGhlbiBtcHJvdGVjdChQUk9UX1JFQUR8UFJPVF9XUklURSk/DQo+PiBB
bm90aGVyIHdvcmthcm91bmQgY291bGQgYmUgdG8gZnRydW5jYXRlKDIpIHRoZSBmaWxlIGFmdGVy
ICBtbWFwKFBST1RfUkVBRHxQUk9UX1dSSVRFKSwgaWYgTUFQX05PUkVTRVJWRSBpcyB1c2VkLiBC
dXQgdGhlc2Ugd2lsbCByZXF1aXJlIGFwcGxpY2F0aW9uIGNoYW5nZXMgYXMgYSBzcGVjaWFsIGNh
c2UgZm9yIGh1Z2V0bGJmcyB0aGF0IGNhbiBiZSBjb25zaWRlcmVkLg0KPiANCj4gSSdkIGFzc3Vt
ZSB0aGF0IG1vc3QgYXBwbGljYXRpb25zIHRoYXQgbW1hcCgpIGh1Z2V0bGIgZmlsZXMgbmVlZCB0
bw0KPiBzcGVjaWFsLWNhc2UgaHVnZXRsYiBiZWNhdXNlIG9mIHRoZSBkaWZmZXJlbnQgbG9naWNh
bCBwYWdlIHNpemUNCj4gZ3JhbnVsYXJpdHkgYWxyZWFkeS4gQnV0IHllcywgaXQncyBhbGwgdW5m
b3J0dW5hdGUuDQoNCldpbGwgcnVuIHRoaXMgYnkgb3V0IGFwcGxpY2F0aW9uL0RhdGFiYXNlIHRl
YW0gcmVnYXJkaW5nIGltcGxlbWVudGluZyB3b3JrYXJvdW5kcy4gDQoNCj4gDQo+PiBIb3dldmVy
LCBzaG91bGQgdGhpcyBtbWFwIGJlaGF2aW9yICBiZSBhZGRyZXNzZWQ/IFdoeSBtbWFwKFBST1Rf
V1JJVEUpIGhhcyB0byBleHRlbmQgdGhlIGZpbGUgc2l6ZSBuZWVkcyBjbGFyaWZpY2F0aW9uLg0K
PiANCj4gVGhlIGlzc3VlIGlzLCBhcyB5b3Ugd3JpdGUsIHRoYXQgaXQncyBleGlzdGluZyBiZWhh
dmlvciBhbmQgY2hhbmdpbmcgaXQNCj4gY291bGQgY2F1c2UgaGFybSB0byBvdGhlciBhcHBzIHRo
YXQgcmVseSBvbiB0aGF0LiBCdXQgSSBkbyB3b25kZXIgaWYgcmVhbGx5DQo+IGFueWJvZHkgcmVs
aWVzIG9uIHRoYXQgLi4uDQo+IA0KPiBMZXQncyBleHBsb3JlIHRoZSBoaXN0b3J5Og0KPiANCj4g
VGhlIGN1cnJlbnQgVk1fV1JJVEUgY2hlY2sgd2FzIGFkZGVkIGluOg0KPiANCj4gY29tbWl0IGI2
MTc0ZGY1ZWVjOWNkZmQ1OThjMDNkNmQwODA3ZTM0NGUxMDkyMTMNCj4gQXV0aG9yOiBaaGFuZywg
WWFubWluIDx5YW5taW4uemhhbmdAaW50ZWwuY29tPg0KPiBEYXRlOiAgIE1vbiBKdWwgMTAgMDQ6
NDQ6NDkgMjAwNiAtMDcwMA0KPiANCj4gICAgW1BBVENIXSBtbWFwIHplcm8tbGVuZ3RoIGh1Z2V0
bGIgZmlsZSB3aXRoIFBST1RfTk9ORSB0byBwcm90ZWN0IGEgaHVnZXRsYiB2aXJ0dWFsIGFyZWEN
Cj4gICAgICAgIFNvbWV0aW1lcywgYXBwbGljYXRpb25zIG5lZWQgYmVsb3cgY2FsbCB0byBiZSBz
dWNjZXNzZnVsIGFsdGhvdWdoDQo+ICAgICIvbW50L2h1Z2VwYWdlcy9maWxlMSIgZG9lc24ndCBl
eGlzdC4NCj4gICAgICAgIGZkID0gb3BlbigiL21udC9odWdlcGFnZXMvZmlsZTEiLCBPX0NSRUFU
fE9fUkRXUiwgMDc1NSk7DQo+ICAgICphZGRyID0gbW1hcChOVUxMLCAweDEwMjQqMTAyNCoyNTYs
IFBST1RfTk9ORSwgMCwgZmQsIDApOw0KPiAgICAgICAgQXMgZm9yIHJlZ3VsYXIgcGFnZXMgKG9y
IGZpbGVzKSwgYWJvdmUgY2FsbCBkb2VzIHdvcmssIGJ1dCBhcyBmb3IgaHVnZQ0KPiAgICBwYWdl
cywgYWJvdmUgY2FsbCB3b3VsZCBmYWlsIGJlY2F1c2UgaHVnZXRsYmZzX2ZpbGVfbW1hcCB3b3Vs
ZCBmYWlsIGlmDQo+ICAgICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkgJiYgbGVuID4gaW5v
ZGUtPmlfc2l6ZSkuDQo+ICAgICAgICBUaGlzIGNhcGFiaWxpdHkgb24gaHVnZSBwYWdlIGlzIHVz
ZWZ1bCBvbiBpYTY0IHdoZW4gdGhlIHByb2Nlc3Mgd2FudHMgdG8NCj4gICAgcHJvdGVjdCBvbmUg
YXJlYSBvbiByZWdpb24gNCwgc28gb3RoZXIgdGhyZWFkcyBjb3VsZG4ndCByZWFkL3dyaXRlIHRo
aXMNCj4gICAgYXJlYS4gIEEgZmFtb3VzIEpWTSAoSmF2YSBWaXJ0dWFsIE1hY2hpbmUpIGltcGxl
bWVudGF0aW9uIG9uIElBNjQgbmVlZHMgdGhlDQo+ICAgIGNhcGFiaWxpdHkuDQo+IA0KPiBCdXQg
aXQgd2FzIG9ubHkgbW92ZWQuDQo+IA0KPiBCZWZvcmUgdGhhdCBwYXRjaDoNCj4gKiBtbWFwKFBS
T1RfV1JJVEUpIHdvdWxkIGhhdmUgZmFpbGVkIGlmIHRoZSBmaWxlIHNpemUgd291bGQgYmUgZXhj
ZWVkZWQNCj4gKiBtbWFwKFBST1RfUkVBRC9QUk9UX05PTkUpIHdvdWxkIGhhdmUgZXh0ZW5kZWQg
dGhlIGZpbGUNCj4gDQo+IEFmdGVyIHRoYXQgcGF0Y2gNCj4gKiBtbWFwKFBST1RfV1JJVEUpIHdp
bGwgZXh0ZW5kIHRoZSBmaWxlDQo+ICogbW1hcChQUk9UX1JFQUQvUFJPVF9OT05FKSBkbyBub3Qg
ZXh0ZW5kIHRoZSBmaWxlDQo+IA0KPiBUaGUgY29kZSBiZWZvcmUgdGhhdCBwcmVkYXRlcyBnaXQg
dGltZXMuDQo+IA0KPiBIYXZpbmcgYSBtb3VudCBvcHRpb24gdG8gY2hhbmdlIHRoYXQgcmVhbGx5
IGlzIHN1Ym9wdGltYWwgSU1ITyAuLi4gd2Ugc2hvdWxkbid0IGFkZCBtb3VudCBvcHRpb25zIHRv
IHdvcmsNCj4gYXJvdW5kIGFsbCBodWdldGxiZnMgcXVpcmtzLg0KPiANCj4gSSBzdWdnZXN0IGVp
dGhlcg0KPiANCj4gKGEpIERvY3VtZW50IGl0LCBhbG9uZyB3aXRoIHRoZSB3b3JrYXJvdW5kDQoN
CkF0IGxlYXN0IG5lZWRzIGRvY3VtZW50YXRpb24uIA0KDQo+IChiKSBDaGFuZ2UgaXQgYW4gY3Jv
c3MgZmluZ2Vycy4NCj4gDQo+IA0KPiBJbiBRRU1VIHNvdXJjZSBjb2RlIGlzIGEgdmVyeSBpbnRl
cmVzdGluZyBjb21tZW50Og0KPiANCj4gICAgICogZnRydW5jYXRlIGlzIG5vdCBzdXBwb3J0ZWQg
YnkgaHVnZXRsYmZzIGluIG9sZGVyDQo+ICAgICAqIGhvc3RzLCBzbyBkb24ndCBib3RoZXIgYmFp
bGluZyBvdXQgb24gZXJyb3JzLg0KPiAgICAgKiBJZiBhbnl0aGluZyBnb2VzIHdyb25nIHdpdGgg
aXQgdW5kZXIgb3RoZXIgZmlsZXN5c3RlbXMsDQo+ICAgICAqIG1tYXAgd2lsbCBmYWlsLg0KPiAN
Cj4gU28sIHdhcyBtbWFwKCkgbWF5YmUgdGhlIHdheSB0byBlYXNpbHkgZ3JvdyBhIGh1Z2V0bGJm
cyBmaWxlIGJlZm9yZSBmdHJ1bmNhdGUoKSBzdXBwb3J0DQo+IHdhcyBhZGRlZD8NCj4gDQo+IFFF
TVUgd2lsbCBvbmx5IGNhbGwgZnRydW5jYXRlKCkgaWYgdGhlIGZpbGUgc2l6ZSBpcyBlbXB0eSwg
dGhvdWdoLiBTbyBpZiB5b3UnZCBoYXZlIGENCj4gc21hbGxlciBmaWxlIFFFTVUgd291bGQgbm90
IHRyeSBncm93aW5nIGl0LCBhbmQgbW1hcCgpIHdvdWxkIHN1Y2NlZWQgYW5kIGdyb3cgaXQuIFRo
YXQncw0KPiBhIHJhcmUgY2FzZSB0byBoYXBwZW4sIHRob3VnaCwgYW5kIGxpa2VseSBhbHNvIHVu
ZGVzaXJlZCBoZXJlOiB3ZSB3YW50IGl0IHRvIGJlaGF2ZSBqdXN0DQo+IGxpa2Ugb3JkaW5hcnkg
ZmlsZXMhDQoNCklkZWFsbHkgeWVzLiANCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLiANCi1Q
cmFrYXNoLg0KDQo+IA0KPiAtLSANCj4gQ2hlZXJzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0K
DQoNCg==

