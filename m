Return-Path: <linux-kernel+bounces-175243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9474F8C1CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A95B22675
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E4148FE6;
	Fri, 10 May 2024 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VpUMhITc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z0QACt64"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A214885E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311152; cv=fail; b=dWUQfh+XZbOT0lzaYE9kNwSVH6/G6QOKZ+XTfQkAZxykZCf7kYDhvivVF6K4YAWD6K9e6TVfpBrbA7JDtPUf08/ncz4rKB+nsz7rtltjcLpZyOyvQh09irO7z0W0oNWjMnfV3omBew867Huop21jjPnJl/ZAuUoAGKEBac1mI5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311152; c=relaxed/simple;
	bh=czkib8yvgMNMFtrpzqrkcZE2tEoxiljKpRS+bOlKIi4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=etQMvRrzL57Fs+lQNAl9GT0ExWrP1C21zNdHiUMypgVJFeimaW0H+GoR7pnFDEUmtDgWmO8En6IxRLTy8mvwLtk/t+VyB/E6kLXexzfnciZbK2UzLZzYGhps5MKhhSBk/u/QtMeEWjmyBZDOtDYRuE8R80rWtu9EVgvBa/+BhlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VpUMhITc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z0QACt64; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A2jDJZ003970;
	Fri, 10 May 2024 03:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=P6aBMnBAe1oNWqVr4G9vZooRtfIav+9TGgK36rTX4Wg=;
 b=VpUMhITcHHfq/iAgJte3abHgR3+Y2gL3SIl0nhO2olDxjeJfpQ/NlscglZKOtUhvZqOg
 +oWm80TE7h2GGq+ELXQ0x9qtUTGjbtJkZKcDqYCYnQmrtmKh3NBTi0zqOZhK7k+c180k
 U43k42lba8nEXH3WLN+WRmVKyWorO2HNB8WR2ht/8+emdqPRXi/NNXX9CGis+F85/cKi
 IxcT072Rb+AKautYyxcZXs4sl3lFMvqq9x0CAQ64Mfi3ResO3Af5bH/2viEwucT3QD2c
 umQ+94NnOLeXqpQBEbSTELVZ02WUOG5qXM9OlTLfCoeO37j7yDlGtL5EUdMSoBNMqu8h PQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y17x7r7n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 03:18:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0GkXs031009;
	Fri, 10 May 2024 03:18:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfm26u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 03:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q709iH0EvauKEVnwlcqcPw2Da0ILMKrWbozOR4GuEwcr5Bw+DA/4u1BYoxrS0fDsGsC6Of0+0axtA2I4zNKUFd1lt5OH29/q4IgK/67LpcyfXjpR+ij+2QKA/MyJki9iWjS11zivD516FYGVhDNr/T3y18iwZLisEw9kIQaucEZLkPEYGd+xxFyugKYWrU2ZnifmJg9Ntnorw3TNPl5Y4IcVOs1Ty2305/5hyH8q6GXQlsgUM9fSxF+0jABVfzCWF9cIk81iGPLuBiiaXWHTF9iVrgmlnJY1oHpMjOSFnRy+jFS42/+YhCiDyERmw9LVCHbdUgvo4D8DidguADLKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6aBMnBAe1oNWqVr4G9vZooRtfIav+9TGgK36rTX4Wg=;
 b=bUe8v6CyEOk1IOFRQ/eyDiy5T3aLBQuDmOqVms8CODy5inv7ykkop7Kl5MhP4aOATQanY7BZIlfIovgGXT7eUBy5kkFYviPqF2Jf+eTNbILlbx5tNawUYJpY5M0Y/gXC+C3yoYd5gA8scQRMdLfFFKag3kEvSECp2XQbJCxxWWUbpJ5fu5SHkGlKStldh4zRRqn6Z4jhdMsFbVxKp7AH29ZBEgPbk2VxD7ZDK755rBpgnaEIdeahkp/yIn0dWRN1a+saCdogMAU4WD801VIVin6TtQ5zw72zP6/zxRT3Emp4iHkpF45euLFlF2V/phi7JvpT3n3O5T+98IAplMuRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6aBMnBAe1oNWqVr4G9vZooRtfIav+9TGgK36rTX4Wg=;
 b=z0QACt64FLMpotCAaRhx+YgeJjlRN5sNk9Bn1ufLcL7pVXKAL+iuPf4fHyOjLICcToqXqMXleC4Jue7BuzFa79B1P43WrtOuEgDjNe9hchlcboq0AGy50lJenMiLdYrEmspRoB9ObjY0ELaV5u/6iHXepZaIKFriKoxIc564kYc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 03:18:49 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 03:18:49 +0000
Message-ID: <d6b7c197-2b3c-442d-9b0f-ff7db3bd1ed9@oracle.com>
Date: Thu, 9 May 2024 20:18:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-4-jane.chu@oracle.com>
 <038cffc0-e027-b518-460f-40099819c588@huawei.com>
 <c172fa3d-d4a4-4605-8f39-df0536718bd5@oracle.com>
 <b6c1b513-4470-4721-120c-1b1c813b2680@huawei.com>
 <1b4c50b6-2371-4e1b-aef3-d70c32888054@oracle.com>
 <30d4d249-e3b1-79d5-3501-0ccb9c529110@huawei.com>
 <7a292357-8515-4ea6-b4d1-6ca6fa407e72@oracle.com>
 <32b88a87-8edc-12eb-1fd7-2a028b8f9fb3@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <32b88a87-8edc-12eb-1fd7-2a028b8f9fb3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::23) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SA2PR10MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 529b0b24-3244-471f-6dec-08dc709fe913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZlBTZXdkU2dmMHExTUowYS8xU1VVaDFmWkhVbk9ZOEI2YUpqNHh1MVVod1JY?=
 =?utf-8?B?eEtwZC9ZWXVsanVmaGRSektmcmU3YVN3T0hyL282cUxybEVQMlp4ZnBtZlpx?=
 =?utf-8?B?MmY4MGZQWXcwcExmazlYRkFNODdBM2JGaDRpRSs3Mmxpb05vNk5CNURCUDlE?=
 =?utf-8?B?RUM3ZU1WcUtSM016MmcrOW5HQlJvVFcxOTh3UXE2T1B4NGpKOEZTc0cyRG9P?=
 =?utf-8?B?VXFnSmVhZ3JjcWVUT09iOW1qblVRc1RvaEdHSkZaMXYzZ2JVdDYvTVBMRysv?=
 =?utf-8?B?anNOemJvVnVXTE5kT040c0NzQUdsMW9GbFJXTnJIMDZINWdLV3NoOE1rOWVa?=
 =?utf-8?B?aUVlS0Jub0lpQ0RXN0F3VXN5S0QxK3pRdU8vUnlDQXM5N09nM0Q0ZjFBQ2o5?=
 =?utf-8?B?OUliS3hRRkppNWpjRTVablVEUldBUmhLLzFLbXRuMXNjTElGK2xZSTNJTDc1?=
 =?utf-8?B?TS9GYStCUzN3NitkOTRwQlVOWHVJL1dsVzMyb2VMOWdYR3hsMWFhMTMydkpT?=
 =?utf-8?B?WUhCRzVFT1drTEdHWWVRUk55aDY5QnRKY3h5N0NncWF2ellrOFpzUU1POW5j?=
 =?utf-8?B?YjdGMFFUcjFsYm1yQjBpWjNpcnZzV3pGa2djY2ZYZTFsTUZRT2pFR01WWTJK?=
 =?utf-8?B?Um9vWUZNNmhsZEZQY0M1TDQ0UncrZnllNlUzejE5eEdCdHhkRHlZTnVVWDIy?=
 =?utf-8?B?cHJjczdoOVVkYzR3RGQ4M2VuOStlSFRWVFVWOVBIeE11bExBOWw4cUZsa3JB?=
 =?utf-8?B?N1VpMFdoY0tnVTl4V2tJVyt0azRwRGNjNitJRDRweHhiZGQ5K0RXOFJOMVZC?=
 =?utf-8?B?ZFhzZm1rTXNEOXRvcEhZaTA1OEVTK0JiOEkvaER1QXB5RzJVRUtJdDJJRlZo?=
 =?utf-8?B?VllZdXZXbEtRdzB1MFFYeUFtcUxtbDFCbDFzVW1YcHlwM3BjZURQaWtzbkRo?=
 =?utf-8?B?eUYzR2lja1JVaTBOdXA2bUR2cWZTZ2FmSGJQT1paM3lxZ1FDUGw5MGIzREs5?=
 =?utf-8?B?Unl4blhNOVpObXozMlJUNEltSytyQXJ3a2FpL1NFbnlrTjQ2KzAvd1dLRGhX?=
 =?utf-8?B?NmRpQ2NjeFNkcXJ2WnRZcjk1WElhU05vN0dkTktpc3F0Zmx1NTdjb3MyU3Ux?=
 =?utf-8?B?WFhGdjhIdnp0dG5QNms1SE91NnhyVXhuSmRqczQ2T0Uwb242MmF0b2VQUGJZ?=
 =?utf-8?B?ck9NZkdVRXNhZUdBWmxVY2ppT1BJME5zeUhVeGxhTHhUcmdRNmh3eW9SS0Y5?=
 =?utf-8?B?K3RwcDNIZ3Uxcm9CY0cyVlRWbHVkdmh6cG1zWVJIRGxuUmxLZkorTUI2bXQ1?=
 =?utf-8?B?NlVjT3ZIb0lHUE4zNG1tNUxCOGxSeUU5ZVozRUJRcTNxUGVOc3FJU1BYK3cv?=
 =?utf-8?B?aDhhZnJ4MHp3dnFMSVVUMisvL1dMY09OUjBVN3hOd1JFMCtuWHlRY0w3NS9K?=
 =?utf-8?B?c0ZycjZHV0w1dnIyeE1ITjUyZ2piL0xIdVFScVNzMDR3SDQ3em84VmFWVzJM?=
 =?utf-8?B?WFBJMWxWZ0FMUUhINkJVbVhMVUVKUjEraS9hWlhpQy84MmEwTE9uZGtHSFBy?=
 =?utf-8?B?MmMvVWdVRk1tdjM2WUR2Y3k4ZWJYZ2tvY0lXV0pLbDNrcnRhSjNrbGlDazNE?=
 =?utf-8?B?Ti9sUTk2aHJXUjY4aFYwcUo1NnlsLzVadnZMUFhXcDJiVmdwd2huZENsWGxp?=
 =?utf-8?B?SUhZbmZ4T1hqOE1LTVVPcGN5aTMwbXhhTWZjMmpMZzFmOEw2OWU5ejdBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WFIvZGh4UEVqSG1MaEoyeDY5azc3amVZSTRBSzdTTitxVVp0dnNqWGxjNDdv?=
 =?utf-8?B?R2JGYnNqRXlHaXBPdDRnSGxJL2F4QlcwRGF3eGUwVnkxY0QwZ1Y5UWV3Q1J3?=
 =?utf-8?B?cFR3a0pWUXdjWkEySjNsK2pFUlRJNXJCcFZyV2h0ZHZieUJMR2JjVWxmM1hB?=
 =?utf-8?B?RFY4emlCV1JuUVBrVWhEL2JxT3NnMlJUc0NjbTFEWm0vRFVqRjhxYWdrWXEx?=
 =?utf-8?B?OEtXRjlxVjRVS0hMQ1hCNnF1OVlsZXd3Uk9oVms2S2lCbUZmYTJBUThETnM2?=
 =?utf-8?B?b1JOY2Y3b3phUzNXVTVnenVwZjRRMExPaDBiem11dGdENXJLak1GMjF6aEw0?=
 =?utf-8?B?U1FsNW5tLzF3Y0c0Q1RGQ3RWOXhQNDZIcHZic3ZwOEdMMjlKK3NJNHZ4SGhB?=
 =?utf-8?B?NzYrV0gvQUhsRjU4N1NSaSs2Um1tellEWDAxKzNZZDJORlcwSWNYL2wyY3J1?=
 =?utf-8?B?YmcyajdJNDM4Y2UzTTBzWUtadnA3UUhzNFVoSUZXcDhhTldpMmk5Y0NWMlFv?=
 =?utf-8?B?MXR0ZnFyclFQT2dzTjNrdk5zemtubUE5QnZINEtoUUpTdSs1cFhSc1k3cFk0?=
 =?utf-8?B?MjRRMEpvMm5DQkgvMnVpQUExN2lkcSs0bGQ0dTg4THdTc1BTRVZCdTRIc3p3?=
 =?utf-8?B?d0lHaER1L1pMZVhNei9nNHBVdjlTeHdRcVhxMVhkZzNIUVdldFRWZFhHVFIz?=
 =?utf-8?B?M1plaUFoeEFnN21QUmUySnB3OXh3RDA2a0xNaURsaXZVdlR4aXRBY3kxNHpl?=
 =?utf-8?B?UmtwWEpVMEtOMHM3Q0NFaUxpYkRpTmZDekhnaEpaemk5OGNha0lrdDBaZ0xk?=
 =?utf-8?B?WFZtYnAxK1lqV1dVQ3Qvc2xxWE1PdzRwWDBPRWtnZ20wNGpoblM2b2hOZWtU?=
 =?utf-8?B?djVTVE4vRGhIbCtSMnFYVlRzUVVIOHQ3M0tOWnl5S0dXdmN2VTVSTFBNaGtJ?=
 =?utf-8?B?MkFkQ254OGZ6ZzduRnkzOVhobzljZWJ5cjFiNXAzUHNTV2xrNm1LeFFQdnEz?=
 =?utf-8?B?aEZ6ZjVyNnlhTjdmemFnK0dxdGxvczM3ZGduRWpIT1ZOVGVZNW5LTWJJdlNr?=
 =?utf-8?B?ZmVDTFF6VG9UNlJ2dFlCTGNBNjJvaWRrdmhmQkVsZmhiNnhDOHhPN3JXV1ZQ?=
 =?utf-8?B?QUU3Z1lFcXkwTzRjYkJ2akw2T2dkRHVUbWhod3VYVGZubEJZdXdlRTJZRlU3?=
 =?utf-8?B?QnBmYUlsQzV4c0JabGJGNjZWak1jait0N0NHK3J4Zmh2TGpkaW5TMkNTMHpy?=
 =?utf-8?B?MUphSnNQS2pnOWFMRG9HZ2RCNmY3YTF4eTVsbFJhZWJ1RkkyZ1hPaE1MaVhn?=
 =?utf-8?B?TnZPVDRqYkhCZURDN2phSTE5eE16ZVViWUpsOUd6TC9GcXl5VVJOL04rYUxh?=
 =?utf-8?B?cFdwTHlpS1JENlZsbWE3bjVDTnZJSXVpdGVFb1ZJRUtLU1ZsZ2VUaHlDZVMz?=
 =?utf-8?B?TFV1VE5oL2FLeTd5bUNOajU0MG5PWjh1a2FLRU5RYkY4cnRyNmlPS3FJYWhu?=
 =?utf-8?B?Slk1ZXVHNWFCaGhkNkZLNEJyejZtV2E1RmtBM3RMSGhYc2V4a3VISU9URkUx?=
 =?utf-8?B?NWxkSzhOTTJtRDZsd3FZdk9LWXZnaDR5cHEzd2ZacFVycjB5OUZXQVJtVnZP?=
 =?utf-8?B?SzBLWkFwVTBQNGtHakVBQ2NkQU1mM3pmb29zYnBEdk1kSXkxejZhcE9FN0cw?=
 =?utf-8?B?M1oyQzd2WmF2ZUhQK013bktHTC9BUGExYWx6ZTE5M2t2eE16K2c1djRXa0k3?=
 =?utf-8?B?TWNRQUl4T0RRYjA1T0hpeU9KdGdLK3plTEtRU3hCYTRaKzNPaE9IT01XdFc1?=
 =?utf-8?B?LzgvK3R2VUplYXc3SEJMdzlOUEZYOCt5b1ZCU3dlc2tMUDdTZzZwcXhQS3FF?=
 =?utf-8?B?Z3cyWWJNTHRIUktONzFVNmZDZFhnTXR5Z04wb2ViMGZWNmhlRlhnb1NzbHAz?=
 =?utf-8?B?a3lRNHNQU1hubDZsbDJjcGlDV280ckNVS094Z1Fsell1OGthMWxOekVPT0lF?=
 =?utf-8?B?djVyOUJZYmhUVkVzNThlSmZmZ1c0bm04Vnp0MFFMZ25KVGF3aXhleWptc0tD?=
 =?utf-8?B?a0pKK05ud05VNzAyd01lMkhyVUVBODBlSEltQUhzVDh4RnUrQnY4amVIMTNB?=
 =?utf-8?Q?zo1DIFIUJaDFI4aBYB01Mq8ok?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DTqim6yTwSMxQ6iEtvMgplN7lWgMNi82dLmQBJNTyrSUCy58t6LJQRThhHIGEdkGyfMtmmL6HrMrm2+YX/q0jy/A33USQ2p++tB5sP3pjbPCm3DZ36E+4JyG0T26ekGgxVqNHm9gnoPPIk0YxwWhW2yJhyizX4ZwsY8rFrtcbKQkT23kSuv78OtKWXIvvOccZ8qLAxOXKUkrUR1wscsjbr18YZeUgiR804jDjvg0h+3pBdY7j3iKp5rzvL7L5fyIHLffz7rxzk9L7yFoK7sslXAzxwKs0apBPob2NQAh7DF+Gg9VTXnd6TmEXeyclJZx3DXgJ6k5csSjPgDKziIdtmgqG7ykHWoZ4bPB8onnqxbIsQ7U8WxyNN7o8jZbkTBHTzkSkMJax5QOlW1eBRCUmMK8UfBbZvuIJzo2k/Cas1EqAZXn+PiXriM2EYIE8vyKvb689g6f/Mf0aIiRNQ5Lni6nBK1aZSLJyxIXA+3sYAbnmVKGquZZVCCfkaAKOhHiA161p57uzGzFyu32/thvfAWxaTTxos5pGdv4v8JvkHYlGHGaoUfI01LAt+pUBbk+nRYK1dsJGmZnvxvzBK0bqoKVZ8WiOg7y/N7wMEo/UCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529b0b24-3244-471f-6dec-08dc709fe913
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 03:18:49.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98ShWviJUpYk4x01ODPfs2dHluJz20tDQkg+GPnQTfCmT4dfcGRYzjoUj/n/uWaBxhVJQ+oKYE02FM+z4X/oQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_02,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405100022
X-Proofpoint-GUID: XJKjcYzrYNEoKIP4zJj34iYRtJr9jEss
X-Proofpoint-ORIG-GUID: XJKjcYzrYNEoKIP4zJj34iYRtJr9jEss


On 5/9/2024 7:59 PM, Miaohe Lin wrote:
> On 2024/5/9 23:34, Jane Chu wrote:
>> On 5/9/2024 1:30 AM, Miaohe Lin wrote:
>>> On 2024/5/9 1:45, Jane Chu wrote:
>>>> On 5/8/2024 1:08 AM, Miaohe Lin wrote:
>>>>
>>>>> On 2024/5/7 4:26, Jane Chu wrote:
>>>>>> On 5/5/2024 12:00 AM, Miaohe Lin wrote:
>>>>>>
>>>>>>> On 2024/5/2 7:24, Jane Chu wrote:
>>>>>>>> When handle hwpoison in a GUP longterm pin'ed thp page,
>>>>>>>> try_to_split_thp_page() will fail. And at this point, there is little else
>>>>>>>> the kernel could do except sending a SIGBUS to the user process, thus
>>>>>>>> give it a chance to recover.
>>>>>>>>
>>>>>>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>>>>>>> Thanks for your patch. Some comments below.
>>>>>>>
>>>>>>>> ---
>>>>>>>>      mm/memory-failure.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 36 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>>>>> index 7fcf182abb96..67f4d24a98e7 100644
>>>>>>>> --- a/mm/memory-failure.c
>>>>>>>> +++ b/mm/memory-failure.c
>>>>>>>> @@ -2168,6 +2168,37 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>>>>>>>          return rc;
>>>>>>>>      }
>>>>>>>>      +/*
>>>>>>>> + * The calling condition is as such: thp split failed, page might have
>>>>>>>> + * been GUP longterm pinned, not much can be done for recovery.
>>>>>>>> + * But a SIGBUS should be delivered with vaddr provided so that the user
>>>>>>>> + * application has a chance to recover. Also, application processes'
>>>>>>>> + * election for MCE early killed will be honored.
>>>>>>>> + */
>>>>>>>> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>>>>>>> +            struct page *hpage)
>>>>>>>> +{
>>>>>>>> +    struct folio *folio = page_folio(hpage);
>>>>>>>> +    LIST_HEAD(tokill);
>>>>>>>> +    int res = -EHWPOISON;
>>>>>>>> +
>>>>>>>> +    /* deal with user pages only */
>>>>>>>> +    if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
>>>>>>>> +        res = -EBUSY;
>>>>>>>> +    if (!(PageLRU(hpage) || PageHuge(p)))
>>>>>>>> +        res = -EBUSY;
>>>>>>> Above checks seems unneeded. We already know it's thp?
>>>>>> Agreed.
>>>>>>
>>>>>> I  lifted these checks from hwpoison_user_mapping() with a hope to make kill_procs_now() more generic,
>>>>>>
>>>>>> such as, potentially replacing kill_accessing_processes() for re-accessing hwpoisoned page.
>>>>>>
>>>>>> But I backed out at last, due to concerns that my tests might not have covered sufficient number of scenarios.
>>>>>>
>>>>>>>> +
>>>>>>>> +    if (res == -EHWPOISON) {
>>>>>>>> +        collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>>>>>>>> +        kill_procs(&tokill, true, pfn, flags);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (flags & MF_COUNT_INCREASED)
>>>>>>>> +        put_page(p);
>>>>>>> This if block is broken. put_page() has been done when try_to_split_thp_page() fails?
>>>>>> put_page() has not been done if try_to_split_thp_page() fails, and I think it should.
>>>>> In try_to_split_thp_page(), if split_huge_page fails, i.e. ret != 0, put_page() is called. See below:
>>>>>
>>>>> static int try_to_split_thp_page(struct page *page)
>>>>> {
>>>>>       int ret;
>>>>>
>>>>>       lock_page(page);
>>>>>       ret = split_huge_page(page);
>>>>>       unlock_page(page);
>>>>>
>>>>>       if (unlikely(ret))
>>>>>           put_page(page);
>>>>>       ^^^^^^^^^^^^^^^^^^^^^^^
>>>>>       return ret;
>>>>> }
>>>>>
>>>>> Or am I miss something?
>>>> I think you caught a bug in my code, thanks!
>>>>
>>>> How about moving put_page() outside try_to_split_thp_page() ?
>>> If you want to send SIGBUS in the event of thp split fail, it might be required to do so.
>>> I think kill_procs_now() needs extra thp refcnt to do its work.
>> Agreed.  I added an boolean to try_to_split_thp_page(),the boolean indicates whether to put_page().
> IMHO, it might be too complicated to add an extra boolean to indicate whether to put_page(). It might be
> more straightforward to always put_page outside try_to_split_thp_page?

Looks okay to me, let's see.  Will send out v2 in a while.

thanks,

-jane

> Thanks.
> .
>

