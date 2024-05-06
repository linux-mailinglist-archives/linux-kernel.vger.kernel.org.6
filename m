Return-Path: <linux-kernel+bounces-170195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A45D8BD335
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3721C21748
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B5156F46;
	Mon,  6 May 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jBq4yIVw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tHdyi3GW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4F8F5A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014422; cv=fail; b=ne13iZgIa3VVcOpboStTVgwx26snkmBMRM90QpTg9OJ/L+1ISS3F5z8+wWUHuWDf7OHUQ/z7h3l7no88/y90p0EW3/7bB2/t2C+g5Cb2Opo+xK1M50UCcp2NBPHskMhO4dd6k8CVdeZQCnuyKOTz50cP9f1EHIz36SHgINpROps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014422; c=relaxed/simple;
	bh=RmsuGDFYUtvg9s5BhdfvCS0Nuj065upsRU+LZSIczGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MHmSNfzLSCMtmDDWprdztJlYIqHW4oPDNJV7H7nMlPYBwqR2/4dIzi9PDj3vTNHgMGhM7XeHu62zTNhwAzZV8MH4YMIwAm+OomfOzpDKD7IefFji+UyOsnyYvYgSlP8BgbzUuMinaJ41KhgKxT5FxeNzJ8LVoBptpGuelmZZZ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jBq4yIVw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tHdyi3GW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446An46X027863;
	Mon, 6 May 2024 16:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=d6VV7UwA70bj2E/V0Vsjnq+n8BCv1xNfqC0eCrdoe1Q=;
 b=jBq4yIVwXPt++ZxYoDWZVCSOpFTxgU1CMQC/xCG7JmcbHG+t74uaAWejRZn39wFjduaN
 iiExGSpWui5KCtztwQaT7rFZhlIlI5MtG5MeN0y/pJEz/H88qzAuUnSvMqONqgqaR6fz
 euVmNX3FQFBrq7GJxVzAl9lG+sVi5PdJL+7s83ANwyJTqieVZ6zt1L2SD1kOf2ePr7LF
 yVEdDjl6h2aOqQ8XLJBwocVil8clOSE7tqC7huVnUGVY0d8EMmWvTtVW4Kp2xEA1mg7I
 +U/mUAQ35/IONl9Uz3qBzORNDiw/knnQ26bKE07bMLVaDG2PJ2bOyirFjzwbg94zbXtg DA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwd2du21c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 16:51:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446FRg1l014396;
	Mon, 6 May 2024 16:51:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf688ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 16:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkasOWuYZQzlLShi0j24yzE7HwIqjBz3ATt0GAfIcWqfBzCtHaVlpCzsqARUQ6dOjExeAFGLdZKu9GTc15lrzJ99jFUEdeyXhX8g+mv6mBGDW2hXrZTBzthainrt78bvJ+ugit6b5Pgd93rfCcULWLF/WUQbkaKtCPsl8SVUy/utxUqjNrbN3fiwi7uyCZQAkZOllhl9e5K25i3IHWzBUQCWvoVjqZRahKwJcHKZb0oxc3SeyzfPAKbybFm4Vwzf18diybkI33LRagxsANNJfiVxTmDNi/vkc315Wc5K3WMizktKeGuh8yqASJqsBTPc7kgcnv1jTjdagDLsH9Dj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6VV7UwA70bj2E/V0Vsjnq+n8BCv1xNfqC0eCrdoe1Q=;
 b=UgbrOyNbKY8+7a1r4m7nKnwXn6TvVM6Kuvp2EE9S5lgMdGPsKE0BXLT9Yab6xzG1VSim10K2gDgHIxLFlFGbGTpjfTkOGOLXGCahyrMjLy5YKPxI4xsetdnbcLnGaD48ul7/tFgI29XeyMwCnf02VgAGEUuaqKfNHcrPhAVQvcS+X6TsI5N3+2ISAuhtfCXhBQonBfVGeIdpNVM/Bka05qOFRkOhKzE4bfSeF7faJ+u8FfBXUOCiunFei+1wl/jVtOFYM9BhDyK2BzuSpI/OeTxpGusWraxqftFfptkKxtS0DeYFGG6stcuNHFkSCfOESdQbXFcYT7hiHuSZM015jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6VV7UwA70bj2E/V0Vsjnq+n8BCv1xNfqC0eCrdoe1Q=;
 b=tHdyi3GWVMmj1hkV0HShM7Uibx1a7Gw7pYlTN6dCcA6TbVy+7wY7n73ZmXYuyuCayxEP5YN6O+YsPX4Q6kKpeECI3bJXBW3pPbWJD4XYdR0wO7rHrVyYobvUCD9L/+ZTb2MkrUR1LOoKfCCldDV1jsFaUDPQK/hi4VDNiIU7FUo=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by LV3PR10MB7984.namprd10.prod.outlook.com (2603:10b6:408:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 16:51:28 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::d182:280b:de69:6b78]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::d182:280b:de69:6b78%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 16:51:28 +0000
Message-ID: <ce916e16-7512-4c6a-a0e3-415bdc906afb@oracle.com>
Date: Mon, 6 May 2024 10:51:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: introduce arch_do_swap_page_nr() which allows
 restore metadata for nr pages
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
        hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
        kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
        surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
        xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com,
        yuzhao@google.com, ziy@nvidia.com,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-5-21cnbao@gmail.com>
Content-Language: en-US
From: Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <20240503005023.174597-5-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|LV3PR10MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: fd421bf5-c935-4262-2509-08dc6decc5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dkRaWG5sS0I1ZExxQW5wMUQ2ekVlcVplY1FnYmZzME9GcVBPWFpVZUJsZGZW?=
 =?utf-8?B?ZExVNVp1aTI0WS9WbEpFSHI2ZnFvVkVvSUVlMUJHYXNlNWo5NHBkdlZGbkJC?=
 =?utf-8?B?dWtNUVQrQ3B4K2p5cE9UbXlmYjBrdDdWM09YcXhBVVcweE9heVJBbGN1cWdW?=
 =?utf-8?B?and6VGR0ajBVaWV3Q2FUdVllbFRidlljUzdvSmgvWlJmNjd6WE5xU2xoUnN3?=
 =?utf-8?B?bk1GMllqdDFva3RnNDZ4SXBTL1pCL2cxVGZDSEUvaTluZ1ZRd1A3NUdEVE1N?=
 =?utf-8?B?bmVTcGJoTDJZZkF3eFlCd2JRSVVGTUhqdHorRjBTWTl3ckFkWVI4VDNMR21R?=
 =?utf-8?B?Rm5sWEtrSmRRbHd2aDJpZCtrV1ZXWVJWeHVhVlArbUZwdjM2dytSRWVYU2lB?=
 =?utf-8?B?dG1tUWpYTHl2b2hpSlN2NnZOb0Q3U3lkVWo1NFl4Tkoyd1ZvL3pZMWVmVkNq?=
 =?utf-8?B?cWVLeFpaYW00NWQ2MktWZ2llQkYzWS9LNFN4TnQ1QjFVaWZKeVRlOHJvKzk5?=
 =?utf-8?B?emY1T3NucXJSY3NLRnJLOW01QUlmZFRaNC9LR2ZuT2dWazdiRUtyY2dSRjJ4?=
 =?utf-8?B?dnltVExVRHFiRHZxRTNMRGVGUlYxTEhKMlB2OXVpMkd5QnY0ejdzWW5uVlI1?=
 =?utf-8?B?WWt4ZVdCajd1cDdGRkIzbmowN0xqYVhETWVLV0l6ZFdhNEVEUTREaEZDZjhI?=
 =?utf-8?B?OGRYcXNLc2hsOHo2b0lCRGdkK1Y0TTZMZGVVUU1IRXR3dHVHbmhIWTdiR1JB?=
 =?utf-8?B?NUtSUmlYWXlObVNrV3ZwQTFnM3BjWS9RUkN3QndNcGExdHhEcUM2M1orVmp2?=
 =?utf-8?B?dlB1VWlyUldyN2RaSUhZT294dlJWUHlpRzgxbW9HaENWamNUV3BxRUZ6S25S?=
 =?utf-8?B?QXF1OVRlN3pzaWFEWG1jODAvVk1PZzVjWnpaYVhHU1dBYUhwTExwWC9nWFVM?=
 =?utf-8?B?cEtSRjYxclBsamFCZVMyNnRMYXkwVlZ1ZmljVitJdC8wL0dCcnJVRlJ5UU1Z?=
 =?utf-8?B?UUZrOWdzQlowTkRTZHQyY2J1NW00VVVNZEF2M2ZyUHJkUWtpN2U4Rm9OVEI3?=
 =?utf-8?B?eERZYVNaa2R0UDBSNmhQTWgwTTNWR1ZHdGlzbyt1eXFvV1JocGk0ejNmbnRj?=
 =?utf-8?B?KzVRb1RRNG8yb2dEU2ltY2pmaEg3aE1UbGRFWU92ZHd6cnJYaVV1REFVMUJX?=
 =?utf-8?B?dG92bnMrUi95bUNQMTNRWE5GT09PcjhLbExsMHRiZzh5UWJVY2JiVC9Xbm0r?=
 =?utf-8?B?QWd1VUs5dTBPY2pYQXNJUjBGWFN0UmdnV3NRalVPK2ZCK2EvUUZteWFPTm5j?=
 =?utf-8?B?TnVYWGoyUDRKTnV0MWI3OVlVclkvL2pGeDBEQkZ5aEM5WkFvUmhSUTdBeVV6?=
 =?utf-8?B?ZW9mUURJZG9EVWo4NHhpYzhaVDFJaXhGWjBMUnZZZTJubS9zVmhIYURqMlM4?=
 =?utf-8?B?dE1KZmE1RGxaMzRmaFFRRmM5dCsyR0k1MncwQkdBNXI3b2tHNHBLMi9YTnJN?=
 =?utf-8?B?S3d4ZVhlT2c4Zi9mTVNzaDF6OHpPN0ZrTDVFYlRLUXdvVWZzYjZVTTBGZ2pW?=
 =?utf-8?B?dmVldVg5NVNyZWNlTTFvcForUnRHYTZIemhHaGNHN1hTaUNEdHJaTENmVTYx?=
 =?utf-8?B?ZkRFT3pnM25KVEpDa2hZeXZUR3M5akdBRElZa3BYazR1MStLVCt5WkxjUnBv?=
 =?utf-8?B?SUJqcVEwcVpIdnpHL24wZkpJMERzVExzVWZzWTREWjlXK3NMaUJycmV3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OStMQjh6SDZ6dTNaMGlCNDVkcXFCS0w5d0locWpJdisva2FzaUMwTGM3aWtS?=
 =?utf-8?B?aHY2dTQ2WVFCSktEay9Rb1NmWTA1Qit0amtvU0t0d2hYVmR6bm1hTUw1MVVy?=
 =?utf-8?B?MlZtWGZVUEozNXFLbU5jQU1vaDR0S3hMRUFMbjFhckhOMy9KaElsTWFRaUdj?=
 =?utf-8?B?NTZUS2VkcG1KeDVKcE9MMjNsR2hpSnhKK2t4VFEzbW5xTE1XdTRITXRNZTJn?=
 =?utf-8?B?M0MwSlVEaUVoUHcwaWlnWVkxbkpEL2FVb1dJSEFBS0tGaFdCek0xckpCdU0w?=
 =?utf-8?B?M0d6SjBObThadHA4c0tSaGp4SEp6Rko1a3NydEZRRmM5V0tzQjNDekh0L29D?=
 =?utf-8?B?eDRJbzdnNHNhWDF1TU5EWS81SEplYVNkY045N2hmQXdSdXArOW9GWk9uN29U?=
 =?utf-8?B?QUlQcGRoUHpsOWxTQ3gvcjVTUmtCYUZLNTN6bE5uVGtTMFk2UE5hRzZZRm0w?=
 =?utf-8?B?V2lUMkJjSzFHUGUxa0NhZmIrTHJTbGVxOFUzdU5xQkVLZ1d5SjdtellXdkho?=
 =?utf-8?B?RzhHSGZ6bjF1V0JkR2dETy8wV2o0RnpXYldPSnRQUlRsa3pDQnUvcy9hUUUr?=
 =?utf-8?B?SnNZSlRRMkd4WHJVMTdnOVZsTVh1RjEzL0UrWGxxRVNBWWlCYWJMUm9tTGpY?=
 =?utf-8?B?WHdXQVpScktPcUNpUkFqK2U3WDBGMHVLZ0t4SElyMXBOZnhMZU16SVlpampp?=
 =?utf-8?B?T3JuQ0NQQkphUlpEODk1RlRUQnR6ZEhyVU1vcmtsWTVISVlRZjEvWVZkdklq?=
 =?utf-8?B?TlVXeENNckk5MHZQejRiRDF0WXZaUjVOdERMUGo5b01KSlhkVForOWd4VzAv?=
 =?utf-8?B?KzNsbGxtaWNlanZBSEptQWRmQWFoTjZWcEJDclN4SW1zNkIrNlJ0bjV2K2tu?=
 =?utf-8?B?ZGxhcVF0dktGd29wbU1oSm1xUm5ua1oyczNsa3piQmRjNXp3bE9FK1VpWGVq?=
 =?utf-8?B?TmlRYWtaQXVNS2VKNmY4SUoyVlp3cW44ZDh3dDNtcWx2bGZhcFIweHVDeHlV?=
 =?utf-8?B?dmZpSHZFMThnRUJ0QWlRdHlkYmFYVWMzVzI4S2dCYmcrRGlMVjd3UGY4M0Q2?=
 =?utf-8?B?OTdJa2ptTlVUY1RpV3hkWS9Nb3gvUlltNkRIaVhBMEhDWjZtK25IVjVNVXdI?=
 =?utf-8?B?MWdsa0ZUUGFERkVBZk1tektmWG5ranMrUkdtOWVoYzZ3WktzWi9QeVlkamtX?=
 =?utf-8?B?dnc0bjgrOU5FVGc0dVQ1TXRrTW83MklPVHQ1MmRqbWZDejlIbDUwTXBpQWQv?=
 =?utf-8?B?cURkc1VzSW9KOXNmZHJCYTZGSHhxS2J3amxFVU5BQmlFRVF6bE11Snh3Q09i?=
 =?utf-8?B?M1BSdzg3eVVjUjB2S2pISnNma1JOYWJPbjIveGExa2Y2NWxxM3VmVlVrSWV0?=
 =?utf-8?B?Q0w5REorR29LaE95SmdmZXluU0luZUhQcm5CVnc5Ry92QWE3OGxIUWlGN2NF?=
 =?utf-8?B?R3lHNytpcko2WDl3aDAyNEwvQmZZMms5Smd4TGRIUVF1cGdONXlqSzlkTHJW?=
 =?utf-8?B?SE1PRXNPL3lkamVxRUFwbWpCcTd0UTNnYjVyZ0hxZTlteUNNWjZMeFVFaEJQ?=
 =?utf-8?B?cDJ0eFBjdTR4MFpiSFRmUE1mRmljQW1CRU11Q3RjbWRRUkFGeDdwcGQzOE91?=
 =?utf-8?B?T0p6ektmSEwzSTRMQ2JkakxKNWFteWVOeHZVaS9YWEgrYlFwNGFJS1h6c0hF?=
 =?utf-8?B?ZDFCZFNueEFJMFIwcnJVUjRKaEU5RzVteG5PbXdQeENZWElQM1cwQ1hIbGVj?=
 =?utf-8?B?U0czbjF1elpiUVNkVUgzakVQZmN2WkUwUkRvc1VNWG95cEErQy9IMllkSDRj?=
 =?utf-8?B?emJnOUtRN21nQ00wRVRGMndMaFpjT2J6d3l5OTF6Z0FyeWVScXkvb2REYjBL?=
 =?utf-8?B?WTNuc0RiUUJFOURQS1lHMGJXUXRzMUZQenFiSC9qcDRnWGl0cXYvTnpFNHRo?=
 =?utf-8?B?WnZ3c1pMUWFXNTdvL3ZvZldvYTZUQ1hpYWQ1RjYrNzhDVmxhdm52WlpEUzc1?=
 =?utf-8?B?MzdLT284MzdxV1pYOWRpUkVOSjlOdG1SSGhrNzNyelhySi9YRHdlKzUraXB0?=
 =?utf-8?B?Z29YOVRjZVMxWUJFUzIvYzJqZjN3ZWxGVWdHWDk2NENGQzFxcXRHQlVwS0Uv?=
 =?utf-8?Q?pW8lmgh6aJ2lLWdqgY/9uHP1/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zzs3r6bnLJ3DASFE5AJDW0zsiv5kngcNv+++5OwI5lJpqHphiPzGMceQnXatbrmeE6lbytcx+cuSUHWVFNOsDT5zTvvgpt8G78/zk9vqc9bIEjZ1C5u9YONTLLQB0/V52FZ0vuu1lkgtblMt1hF8tJtWWf3gSveSB4fY/boxnPrQdpmgRiedz73fZGFJbBX9e5n03yy5joMuwxlZs+w+SFOszL2xk81zIbqhCwJGE9lZW/HIR4p7zxeQsBTkljoXtLvJ46gmvvNmndhLFFnCxnaFBRFcMbvtV98VuxqRzaClyXtP1iTbJlmY3S5ti8BCFVkGY3FkfUv4tKSxAiHsFpG3MIMx/2gXbNc1RwmXOKMaMCdV7/VpguZc7jvgNbKq12kTK/JWVIDzeqqmFyrtQhkiuJN7/a/0YkPBEyPUatcNn156k4oFyjNPRs4uI7JRIj7hj3HZ2e79BYgiFJq40PRscULAxCtHXmHSuLlvxG1fUamlOMWhEWcMH92hM27Wq9uv+MsFy3eHyGGitPHQuIeTIq62fJd8XZja5c9g0OCPTkOfn4v10G6xK25tTrc4MUw/Uy5dC4yt1Xzo1ZEgxbmpKmkL6UeTMxxwOFCwel4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd421bf5-c935-4262-2509-08dc6decc5fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 16:51:28.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2WhD/q3iBXGDZav1Y6iCwj1urvDwMxittTlkjEWoh9YGbdNbIkvNYqH6SI8w8ATdMx/6HHvfzyROLeGZJ9neQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060118
X-Proofpoint-GUID: cGRbPJwA7Aq8lAMZsnftFmv_6ztjL2Y-
X-Proofpoint-ORIG-GUID: cGRbPJwA7Aq8lAMZsnftFmv_6ztjL2Y-

On 5/2/24 18:50, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Should do_swap_page() have the capability to directly map a large folio,
> metadata restoration becomes necessary for a specified number of pages
> denoted as nr. It's important to highlight that metadata restoration is
> solely required by the SPARC platform, which, however, does not enable
> THP_SWAP. Consequently, in the present kernel configuration, there
> exists no practical scenario where users necessitate the restoration of
> nr metadata. Platforms implementing THP_SWAP might invoke this function
> with nr values exceeding 1, subsequent to do_swap_page() successfully
> mapping an entire large folio. Nonetheless, their arch_do_swap_page_nr()
> functions remain empty.
> 
> Cc: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Looks good to me.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>


> ---
>   include/linux/pgtable.h | 26 ++++++++++++++++++++------
>   mm/memory.c             |  3 ++-
>   2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 18019f037bae..463e84c3de26 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1084,6 +1084,15 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>   })
>   
>   #ifndef __HAVE_ARCH_DO_SWAP_PAGE
> +static inline void arch_do_swap_page_nr(struct mm_struct *mm,
> +				     struct vm_area_struct *vma,
> +				     unsigned long addr,
> +				     pte_t pte, pte_t oldpte,
> +				     int nr)
> +{
> +
> +}
> +#else
>   /*
>    * Some architectures support metadata associated with a page. When a
>    * page is being swapped out, this metadata must be saved so it can be
> @@ -1092,12 +1101,17 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>    * page as metadata for the page. arch_do_swap_page() can restore this
>    * metadata when a page is swapped back in.
>    */
> -static inline void arch_do_swap_page(struct mm_struct *mm,
> -				     struct vm_area_struct *vma,
> -				     unsigned long addr,
> -				     pte_t pte, pte_t oldpte)
> -{
> -
> +static inline void arch_do_swap_page_nr(struct mm_struct *mm,
> +					struct vm_area_struct *vma,
> +					unsigned long addr,
> +					pte_t pte, pte_t oldpte,
> +					int nr)
> +{
> +	for (int i = 0; i < nr; i++) {
> +		arch_do_swap_page(vma->vm_mm, vma, addr + i * PAGE_SIZE,
> +				pte_advance_pfn(pte, i),
> +				pte_advance_pfn(oldpte, i));
> +	}
>   }
>   #endif
>   
> diff --git a/mm/memory.c b/mm/memory.c
> index f033eb3528ba..74cdefd58f5f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4266,7 +4266,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	VM_BUG_ON(!folio_test_anon(folio) ||
>   			(pte_write(pte) && !PageAnonExclusive(page)));
>   	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> +	arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
> +			pte, vmf->orig_pte, 1);
>   
>   	folio_unlock(folio);
>   	if (folio != swapcache && swapcache) {


