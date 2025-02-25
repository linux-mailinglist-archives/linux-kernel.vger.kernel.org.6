Return-Path: <linux-kernel+bounces-532346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE4A44BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D93B168571
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE243D984;
	Tue, 25 Feb 2025 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SLJ4ZIY4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NSo4+VhZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D8D2F50
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513489; cv=fail; b=H9OLwkDEknmMe+sjwQDKrmSk9rqY+YhDMN9vnvm+W2UafinaK6mFIEmJyHcAZy74DhVR67gwBkxGuJUlr86XBdvgho/e37O7us4M/THZgxfjFQ17QFMibLWcYnnhcugTT9yStBNoL+W2y8kxgTXQrE9nCVEGAgg63gSsINn0Ct0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513489; c=relaxed/simple;
	bh=yT33Py6k0H6TZSDBqliaoU1NLiHDC1cZQxs/ZLGgOLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1FBSx0qylvcutLnTDABQFm4sRCaJi5Tsx7jlFxuxQ1BOlVishqWNbsXFoB2lmY3CCVyO8Nu3tjafbY8JwNNxNAAB513HEWTnmRdlY/N1MPZNhn5FWI3I3ZIJNf6+J786amDxpe4qsy97SZRy1h1p7JNc4Tq6CC9rNLt78OPARE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SLJ4ZIY4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NSo4+VhZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIXdNg005165;
	Tue, 25 Feb 2025 19:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PLKrdGD+ezKK0vopD/AhRohB1yYkLY/islSoQFcPmVg=; b=
	SLJ4ZIY4vJBwgHfVIH4ob5cTr9tTG9uiPiELky9UR2I8MY7YS4nSzIXdTRgPp2IM
	zDFInAJiCuDmymPxYdL5PIkDdN7RCtxjeKElDK+p8h57cBYqOcld4DxEgkfrBx4K
	QKksc7RdMoAw7VOAo5RnkQXFaH+ZQc2DzA7nFIayyaZJ4WEU7IM9ocBF93jCwViE
	MspgkBZ6gCnfvwqC5oQGNlPHjaYGNfobr8jKBqzhx79SIikQui9MgUDeaJxTYKg5
	tBxVzA1ChsC5BWwZLi+MESkQ4+2hOvE/QYp2SW2jOLiyZliK0MC0Lz6J2nRxDHFM
	UXz5F6bCcDKS1sGQHY6JUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2e7yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 19:56:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIYEPB027322;
	Tue, 25 Feb 2025 19:56:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y519rnxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 19:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxNBbn7e2kqPkJhpXyZfHijE1tD5HZI+wi6F04py0ovZScpJYb1FBzr0Z/pgAnnKtfVYqSllk0O8vrvnwgc5AAk1TQeJzvUmbzUr5dihxx1lcP+Y+y2462IYjph9XSISRLAJMCozqvKVeTAj2I4xC62jrEnPSMeOnO/e9ee0Kog4WVm7i6KaKhafUF4XVcTvLV8C/DQ58K4XNoEQ9KWT8igXcHHzEOj26SWhnbQN120/UYcT7K/d9DKF2i49oaG0AGh+T4GsXEc+ACJwgY8lno0IhGtNF8+24y+mOS0KJI76JLYt+n/H7HYUmGXdxgK2rwTi5VPpAprGpkR9kLtw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLKrdGD+ezKK0vopD/AhRohB1yYkLY/islSoQFcPmVg=;
 b=FowXyxP4SxGZAWGuPeB5MN6oPqCCEYz+e2U0Xyow7VN/5sygVSDrAfxGjKjEINGm63k8o2aK0bMNtIXf+foxIjoc+cYGR5MdwdYCN15uT7LAVnLE2giI0WSzElsnoxI9Zx5490nn5ac8alpCxnrsGItF8P7aNWGZK/CVH2F5dNWK1N+oj8mfMtbySLAjjvIEDvb/6MZXCx3zo+ZAvpSGmwAoUSBFXJLcQ+iiagtUGiZyyijmhpH8+0aCZfSHt6UO6kkklFgnOLpqETZmygmdCYMc8ISKkjLrJJ+dYOhzSUK9GwxmNqg0h57lr4gIfSVtp9zEY0/46ciNlBgzt3v50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLKrdGD+ezKK0vopD/AhRohB1yYkLY/islSoQFcPmVg=;
 b=NSo4+VhZyLiyOao47rTlqX9tfuLcLSUZSaRgAqn+Rpa0gBn0JlyI/nGjDwGCxJBaa6GrMxUPk011UvkuxLIS6ojVMDOz3I+5Zrs7Et+iyKL+EoyzTFkpx7JzDTdfSOiIkGjI3w2z/7FVMSvQvEbJ4d4SYr7A+LsYoanaTPLgEDA=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by LV8PR10MB7797.namprd10.prod.outlook.com (2603:10b6:408:1e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 19:56:45 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 19:56:45 +0000
Message-ID: <6277f5a3-1d12-4d6e-9fad-9e720876a4ce@oracle.com>
Date: Tue, 25 Feb 2025 11:56:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: make page_mapped_in_vma() hugetlb walk aware
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: willy@infradead.org, peterx@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20250224211445.2663312-1-jane.chu@oracle.com>
 <3f3acf9f-f71d-77a3-ca61-5cc5c6c7f02b@huawei.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <3f3acf9f-f71d-77a3-ca61-5cc5c6c7f02b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|LV8PR10MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3e26df-11e5-4901-8398-08dd55d68857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG9WQmdDbVpGSytqU1JSWE5JWGpkTitMcCt6QmRZTnVBZDIyNmo0d0FDQTJ2?=
 =?utf-8?B?UXF3ZFZteTlNbG5VeWcybCtzck9TY1Rielo1ZEsyS1BXQmlHL2dKMXMzdHZS?=
 =?utf-8?B?bmdVaFZWRytpSmt4cS9uR2M3WVJsWHJPOTlNT2pmSkorcGdVVkY5RTNndHVC?=
 =?utf-8?B?cCtXVisvYTZWcEtQVnQ3RFd2ZjhocXhMNERYU3JwaVpjaDdoSTJMVnFueFkw?=
 =?utf-8?B?UDdQVWlyRGxmbTg3WkxnbTAxR3kvWGhJdGprY1VhQTBzSXZRb1RzQ3pwOUF4?=
 =?utf-8?B?Q3g1Y3YvSUp2ZFVrdlh3TUFlZXlQTGNDUXR2NDVXTUE0Q3BYRm5vK2daZVZj?=
 =?utf-8?B?a2w0TmxubllLQ256ZjN5TXZSSjg2NHlpRjlDZnJsWUtrTy9IT200MjhIYUkz?=
 =?utf-8?B?aTZTTmVXOW9waVRUWXRSdzg3ZGhYaWptQXFMTGtJb0paYkg4c1l0R1RINlpI?=
 =?utf-8?B?Q3IzQkxSc2VsRXhLL3Rma01MYnpTNGxDWkNPOEE3dTVqZUlHOVlESUNwSGgr?=
 =?utf-8?B?WjZzaGV3L0s1eG44VzBlcXdoekdnL3UzM3hjTnJYaG16TjlCU3k1MXdmRlc3?=
 =?utf-8?B?UktkcnBxSWFTQ2puRy9zemp6bzBHR0FvK3VCam9ibFR5M2VvaVptRHFBb2dn?=
 =?utf-8?B?NlJENmpoSllxd0V5RG11dlZ4c292aU1oT21oSWhpZng5TFBRbTgzZlZEMEky?=
 =?utf-8?B?NnE0V1YrQWdvdEl6RGVyZ3dCdWhNRTROWlFQbDMwYjVRU3p1bmUzNldVb2NB?=
 =?utf-8?B?OVpFaXJkTjJPa2x1T1JoMXBPRi90TWQ1Nk9haUs4TnJjaGRoQmpERXBoekh5?=
 =?utf-8?B?UkljaWxOOFN6T0dPbll4VjdYQkJPeGVEa3JUd0RVTThDM25GSDBTdEx2VGV4?=
 =?utf-8?B?L1NmQWcvaklMSFdWNkkrU0VtNVZxc0RPUkRIK0tWMExxZG1JZ0xmemJTVjgz?=
 =?utf-8?B?S0MweVRnd2JHWThNMGp2RkMzYkVud0xuTDc3cDYzS3hmZXBvOHFZK2s1eldo?=
 =?utf-8?B?Y0JJb1FnK0tIQWtveDc4RmtkZERUY29MamlLR2JkdUxBM1RxM0pOWXVaRkpo?=
 =?utf-8?B?SzA5b0FBQ2pKOXdHdVNWNlBpNFlTdkQreGZ6dmU1RjMxM1JGUnBGT2RQcUNr?=
 =?utf-8?B?VkFVL05HTVVCNnR5SkkwNlBFMFpMMnNocEd1VUphRW14ZHE2WGVzc3RqRENa?=
 =?utf-8?B?Qm1uMVNnVkZRWS8yRHdsa2VPMS80bWNrQm0zQzZEa0JwZXF6QTZhWlB3QjVC?=
 =?utf-8?B?aTJKbFlxakRseEhMd0o5SG5QdVVwOGxPS3dabVZ6OFpnSzFDSWUyUktHWHRl?=
 =?utf-8?B?WWNFcUJqa28zS0daK1c4c3dERkFoalpOWnFYdWpJeE1ZaE5sOW9XYkdIcHkw?=
 =?utf-8?B?MzlSL3g3NDl1QTRWbEoyTTNJMm9RTjlpc0FjU0ZzRnhXcXBjN0xIQmwrb05R?=
 =?utf-8?B?a1g0d09xeXpnSE16NDFUd3haTUhBcVIyM2NlOUxKUDNGS3ptc3V2MXV3SFFO?=
 =?utf-8?B?TkV6ejQySHE2S2F5R3FvVGZncFdpVG9wRGhHOGUrdmJVdkE0a1dOQ1diY0Fp?=
 =?utf-8?B?ZkM4Mk1RWWxYUTl0TU9RckJPMXdTNGZmQ1N4VHVCaGhwblFGTjVnZFcwVHlY?=
 =?utf-8?B?VU9HQWdpUk0zSTRLZ2d1SUhnRjA1R3RMYWpWQm5uUVhaK2lLTUIxSlJpRWVz?=
 =?utf-8?B?MDFkNG9EQzNGMU5BUFhoVlc2Y2F0U3d5bDFqYU9Db2JqcEcveWIycmI5L08v?=
 =?utf-8?B?Ly9hQVE2Z3lLanN4eHA0T2FvK2QzdkZZTktBVHIxa0I5RE9jMGtlMkoveThP?=
 =?utf-8?B?allyTTQ5azZma29IZlV0M0IvZXFyeERKWDBYRUZObndmQXdDMDhFeFM4OGJp?=
 =?utf-8?Q?MW7Ddv4f3MdrG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU1SbW5XQ0ppVVVtSUU4M2hrd0dCdXN1YTlpeWtHQlBmU29HaUJIL1lveU16?=
 =?utf-8?B?K0pRMDZWeWpPaW1PVWZvTGI5bzVRVHpPeWhjN0hzNGNjT3FZc3dFeGwxQ3Jh?=
 =?utf-8?B?VXpTRUh5RlFXdm9wcFByVXhaNk14c0Z4QWxncXJIeWxSdk84NkJiOHF6OVAv?=
 =?utf-8?B?Q2NGZk1PYjJOYkM2SEVNYUZLakRiN3h2NGJTQzB2Yysrc3QrenhibHY3VWxi?=
 =?utf-8?B?WGprbm1wV002RXFXTmd0VkJzWDVDaHVqVTc4RVJVQW56ZGQyVC9xaHR0VWdP?=
 =?utf-8?B?aGNiUEoybTJGSXBvSVdEYWVJS3M0YXNlQVhwb1Q5SDMvcWdWUkE0ZEJJKys1?=
 =?utf-8?B?WmtwenhWSUZVa0hqVXJYYm9Ca1pUZUF3S2VxaWN4akI3ZjZGcEl5VUtVT3Y2?=
 =?utf-8?B?WkVpT1JacEFrczJqL2pyazE0SGRLd0lCTGFVT0pjTTFLOTFDazJ1dFNVekZh?=
 =?utf-8?B?clJ4SHNqZlRTVUNQOVdNTHVUeXcwc3NINWdVSFJNaHpjU1VYb0tWR054bmx4?=
 =?utf-8?B?VjlGZERFVk55WUJ1SGlpWElrRTlVdkdBaTFoSldRemJlS1NkMnVRSEtOd25U?=
 =?utf-8?B?N0lRTXhwK1B0OFJaY3dQVFZ5ektJeFJHald5Tk9aQ0QySDlsVjMxSVQyK0U5?=
 =?utf-8?B?WjRDK3NiY0NBSlpCbXFqV1RIUFROL3ZkaGxGUVdBVXBPRTEwMmpyTXNLRDFO?=
 =?utf-8?B?SUg1NEV1OFIvemtUZ3BOTEdSekNTaGJvNGNGbFlIdlJ1NHpvTi9DT3pxTlRK?=
 =?utf-8?B?VVJackJ5amd6SHlTbjdKemxFMUVJM1dQT1FqQlpRUzBSeU5GSzA5RTRDV0t1?=
 =?utf-8?B?T3NTY2RpWXp4cUU4Y3c1SG11YTFyd0ZRdjgvWEhoQ2xBZnhHbE1aemMxRzBP?=
 =?utf-8?B?U05CZWE5UDZMbmRRNHArQ3VmS3NTOC9yUUxCWVdrR1UwUWxFN0VUSTdoZERu?=
 =?utf-8?B?UnZ0TUw0aERGaE5jV2VQRlBBeXVDOEZ2ZHcweTNOZThyZnRRM25SZmdvRXlM?=
 =?utf-8?B?b0tYL0xjYyt5dk5NMERicnBqTGtqRWFHSjVGR2g1ZEVvYUZ4QWNEYXZBd3RP?=
 =?utf-8?B?UndyM1psS055cXg4WjhoNlRKaDM1QTRtaEt4MEhLSTBIbDVHdFFYaks2K0JP?=
 =?utf-8?B?TmMxK3ZlemRVbncvVGx5ZjAxaUlzelhWSnRwYW5SSUFXaWNFYS9wWXh1UVBj?=
 =?utf-8?B?bEhTNE5seFBqWmNhS2dJWXRQaU1YOWFyZXgxMjl1aE1qMUFZeUlmMHVEamZI?=
 =?utf-8?B?cXpKVC9SWjZoUVB1aDNzNWtPWHd5L3BXUVRlMWI0U0JxZm9uem1NVVRUb0p6?=
 =?utf-8?B?ckZERkszeDM3aHZiRkZ4dVJ0dGNjdzN0WVBPQ0p3STZhN3BQWHowbHg2L0Nr?=
 =?utf-8?B?cytFdU8rWWY0S1U0bnlrcS9pVnhrOEpUSVQzcWh2blBsY0FUcy9BTno3YmdC?=
 =?utf-8?B?aTNQa0c3MDFkZzhyRE52ckRhYXZYcDJucng3bVBsT0hzVjI4Q3lIZ0ZYUFhN?=
 =?utf-8?B?RWtHWVVETHpOWjN0d2s5SnBFMk9pVUpOV0lmSFJsQ1Z2V25XOHlpZkRPYklh?=
 =?utf-8?B?NW1vam9LRUE0b2V3Rml6Y0REVVdPbGk3OEtObE0ramxhVmwyZzBUblRXQmNO?=
 =?utf-8?B?S3E0T2NNd3FZY3JGRm5lVTAvRHExK3JLSm5acUtwOTgzdnhlQVZWOGpnZlpX?=
 =?utf-8?B?MnJiQUdGWlNldkNlQ2NoL2l1TDVWVXg4UWVvMHhqVDBxNzl6WjZZMHJXTEJP?=
 =?utf-8?B?aEpkckJ5T09qSWEwM1M3Mk8rTW9wcDVicDd4bDRDTXZPcWN2dDZyVmxscjlj?=
 =?utf-8?B?Unh2MjljdmJmcHFvSkhUelM3eEtaV2V6eEY5cDNaZUdSa29IZ29ReklFNExV?=
 =?utf-8?B?NWM5TzJsMVZzUmtrVHZNOStvSFF5VlZYTWFDeWlKNmp3aVBDbGVPOXhRV1Uy?=
 =?utf-8?B?MEdqL09MK09vR09rR2dOR1NQMGo0ZUNFQlF5T2UzVC8rRTJ1bEM2VjVycy8w?=
 =?utf-8?B?YkJxUjNDK0ZYNDNNWWJXNWhjem01d2dHQUdhWnJ5REw5WjNvaEFYMG81c3Vs?=
 =?utf-8?B?dEdBNXl4a0Vac0VaWG0ybjIvd1luSXZTc29DSDdhejRaZUIvbHB5NE4xMnpX?=
 =?utf-8?Q?8uujxOe9NyCelQNyj+LPJ3slH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nr7RFlPV0/+HlNSvBf56AaWtlrmZsIBObmiIBt4aZbAj+BjPJ6cy6m6HkOsg3ixF0VM85mqAbCw+RLp6iYsQxaGtQsyqJZEW0EfpBTLG9WsWQ8wnZEfImhXXutdBSh3qMyNwXtj1lg2Ezo3eShKLiUGhJy+UTknwk81jVr6qePIcwD/YcBTYKkdvn3rEI62MOyTFKtlqbb5Fo5MAcv2YyXqj7q4VnUj64QeSOSusBXe5j13PM4m34oUDkKWJVdQoDNmnD/maJHv62TZUeIO4gVMDQAcPwqkijzs2oqD9Dy3yOE27SAvQQj0UAczAQc1Z2MhLtGTBQEMQg0nSv/A8AR3lWHu4btA50fhmOLOzKq+3Lii4MN3zFQh6Au+wcp/G5Z1tZrNKMYx6MhUdxAa0LCUxcg32VRrpYptux2JxBiEPZ5OeNbTEnMNKZCcqO9ZjooI56KiJTbq66bKdHjz9z4UdOtsk1dxLyPHa2hdQH8VSGqwF+Yoh1U0rW0Xl/h1zcJJ7UMGtSeh4wjIHCyPnK+pc7eM22XbwzobKqNnvqICewHEkSRW3HfvrmJ37P7kTUDqM50L8BGL4iEwzi4Lol4T8w9l2IwmXmlxtzmkAwjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3e26df-11e5-4901-8398-08dd55d68857
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 19:56:45.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDHrTCx1A+GBzbhOIL88232ATQLh01kaZ4t8BMueX50keTiS0YCe8aseV2Yn5HokJM+RWYR2fG9JAeQGDCA1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250120
X-Proofpoint-ORIG-GUID: aYAhhs4ZOP9WFj4K4NEIbMAaB6h3siUn
X-Proofpoint-GUID: aYAhhs4ZOP9WFj4K4NEIbMAaB6h3siUn

On 2/24/2025 10:49 PM, Miaohe Lin wrote:

> On 2025/2/25 5:14, Jane Chu wrote:
>> When a process consumes a UE in a page, the memory failure handler
>> attempts to collect information for a potential SIGBUS.
>> If the page is an anonymous page, page_mapped_in_vma(page, vma) is
>> invoked in order to
>>    1. retrieve the vaddr from the process' address space,
>>    2. verify that the vaddr is indeed mapped to the poisoned page,
>> where 'page' is the precise small page with UE.
>>
>> It's been observed that when injecting poison to a non-head subpage
>> of an anonymous hugetlb page, no SIGBUS show up; while injecting to
>> the head page produces a SIGBUS. The casue is that, though hugetlb_walk()
>> returns a valid pmd entry (on x86), but check_pte() detects mismatch
>> between the head page per the pmd and the input subpage. Thus the vaddr
>> is considered not mapped to the subpage and the process is not collected
>> for SIGBUS purpose.  This is the calling stack
>>        collect_procs_anon
>>          page_mapped_in_vma
>>            page_vma_mapped_walk
>>              hugetlb_walk
>>                huge_pte_lock
>>                  check_pte
>>
>> check_pte() header says that it
>> "check if [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages) is mapped at the @pvmw->pte"
>> but practically works only if pvmw->pfn is the head page pfn at pvmw->pte.
>> Hindsight acknowledging that some pvmw->pte could point to a hugepage of
>> some sort such that it makes sense to make check_pte() work for hugepage.
> Thanks for your patch. This patch looks good to me.
>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Is a Fixes tag needed?

I don't have a clear call and here is the reason.

Since the introduction of check_pte() by ace71a19cec5e ("mm: introduce 
page_vma_mapped_walk()"), it has carried the assumption that pvmw->page 
(later changed to pvmw->pfn) points to the head of a huge page or a 
small page and had been used in such way,  so that it doesn't really 
check whether a given subpage range falls within a huge leaf pte range.  
When 376907f3a0b34 ("mm/memory-failure: pass the folio and the page to 
collect_procs()") came along, it sort of exposed the latent issue which 
hadn't been an issue before.

Thanks!

-jane

>
> Thanks.
> .

