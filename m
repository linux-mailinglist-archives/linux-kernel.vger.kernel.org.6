Return-Path: <linux-kernel+bounces-173660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90A8C0388
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892F01F21104
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1D212C80B;
	Wed,  8 May 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eOPDW9Hn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aeXDY35d"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A212BF28
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190337; cv=fail; b=dM5ebTd9X3EbU38yfua6JVrt190idK/VXChmp0qftz3SmHIXte37kGBgfCugfKFEKZ8A67iU0v5IElZYl/TsJD8Aqw/wi3/WQA8InNMBKYubm4R5xb+8QVW7rsMkSUhInuvybKGwxpmyzBDRCUxI3ZKsC3BLNQNtWi4CFkzcXFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190337; c=relaxed/simple;
	bh=CvVg15k0WvXuSLkzigZBg2ZyaIhlrzd5r7BMaoznJfA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=twJxTzLSXWs3Qzd0/0gagua7t7JiiyRVgfhWwWhA46qJZ/zwT/e6sgcbrS5ZJY/mozORBsO5tvPd9S2JJSOpFoOOVTDyiK7X9KRd0+ISXuLZkLMDdmSC6ZfyGWKSgsrxMPEZKhxSzrPCc0HNj8MyfWNVbJKtMnyrlEMw49o2s9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eOPDW9Hn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aeXDY35d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CO2KQ001321;
	Wed, 8 May 2024 17:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=28AnUhqqnAf9NrMZu6u35zjFwHgFpuCOGroToAaq1k4=;
 b=eOPDW9HnvGF0toB+YVl+zTZm5i68KyCKm2BkJHboy4GoYnDor+K2T6zcdwGvW0O2WT0+
 9+VqjvZ1aSXz39/DJieS8AzETcQmLO/u5m0avrpSgGacEJqoPZF8QAtTKHjncBqDoGIl
 G1HKX8Iyt/AIIjoLuegn43R0e15yxU3n8CCcktiH0mduW0wKPI4NfbH7Shf3kxJK8y4x
 Y/rRa8nxoOFxhtf+bDorv0WKyM2W3CIw96E8zAjLlBGITlaaPX95m8ng10b1jSwJ3G3A
 7ziV66T6KOpNFOwlEZDZf23BD/pVusZUlJ6mDjqW3h1DAnUD26FRmZ5xRtD34Ksx0Uy5 SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfq2ex0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 17:45:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448HQBPQ031112;
	Wed, 8 May 2024 17:45:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfj4j0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 17:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVD+tzICDuOBfQYCpTr5STBHLC/GU+kz8NfnFC+NGSno5frUbi1JxEBm5Uzl3VpjruualQrDJ0BIOLRdhO7lgTVGyddM7H9TELVFlVyO8jJes+rVz5fA0E0ROGafHgZOVuMoHs/joXxU+Cn0Ntl3R+99dPnx83hgw/WZYKRX6waipyVKWdJB+fR6YZV0Ox6NC1Z2p/c9lc8zdPvSbkkDFCX26I4SwveNg2GDfm/x4v9VnKJ70kYxVa65eIA6KKmz63DJ1hpCILd36LPo1XyezeXOOFF9/tmCdwwZ7OaG3GUCK6xJXxw8WaeH+6DOFAsDYCpTsnn0Gnm6RAhZoY3/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28AnUhqqnAf9NrMZu6u35zjFwHgFpuCOGroToAaq1k4=;
 b=m21/J7RbfXNZ0hbWiAm/JKaeqTeqWeve8poueeb1nlclz0ZCdn9g8XqZvLi48CaymSRtaO0dQ8m81QVqoLAPm2l0XHJJcPomSPKe0b3HKOyn0Z50O4p1bx37KFd6kVkJBcNBCRvPwIu+DqdDs6BrHjJCCLnCR48Shi81K7AR1JmrZ3+uXesOTJMdCEAnXRPV3gGHXFErE5fvaFYRTWmbx3gx2nNHlxNMDh9vB313+Jz9QInbAx/6OQFdm2KZfM3DTP5UWzlrkffgdRxnsIlMGlQR406U0fvLtLosQgloFwLh5hlT18oF66sMJsGw21V4Y29W/53Yq5uyUJd/DrSJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28AnUhqqnAf9NrMZu6u35zjFwHgFpuCOGroToAaq1k4=;
 b=aeXDY35dMtul5vIJQ3PB2KO4e4rK3CQwc7OJwG0XlELpWjecg1wSL+PFa4XY75hJLgxHbhFaoZfQhl1Nh60vepvgWpqSE4bXznXjganvdi5XkKHSwPjUefqR3qvUeX1RUeEdJUKpkcDuefLEFcI+OOSzKuGA+IDFEOUWjmggW+0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:45:20 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 17:45:18 +0000
Message-ID: <1b4c50b6-2371-4e1b-aef3-d70c32888054@oracle.com>
Date: Wed, 8 May 2024 10:45:15 -0700
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
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <b6c1b513-4470-4721-120c-1b1c813b2680@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH8PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a21792b-cabc-4ace-cc37-08dc6f86a05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SXZocHJtOWJURjhRZXkvVFBzNWhPT2FXaVFBelY1VnlWRlZYK2drYW9TTW9N?=
 =?utf-8?B?elM0YVJPWnN4UWJ4NFlwNHJzN1JqeUJ1cDh1UENDK1pFVE5ENko4R1BOVnNm?=
 =?utf-8?B?cHhnQWFRYWxFOHhFQ0FFOGFkMFU3NHJ1N0J0ZVlXUXBkcGRYMEZFdnpSQ0Zk?=
 =?utf-8?B?MFFOTGZFSGYzVjFKdGZ5SVAra2xnU05OYjByYk1ZcFFiMGRhVmU1a3hGUmc5?=
 =?utf-8?B?OThkZi9TTVZ1V01YcUI2SkxkKzgxUGpoL0FDWWJTalc4MjlqRDgvZnZFQU5y?=
 =?utf-8?B?bmovWHh2VW1ydVdxVEs4VjlhSnpvb1hEd3h4c2NGMTlwZzl3bVFBRGFIcGJ3?=
 =?utf-8?B?TWg5Ky9xWVFQTGp5cW40ODU4YmZFbUFSL0E4S25lSDk4bVNXcTB1cTRoZmc1?=
 =?utf-8?B?L0hLYTgwUGJIWFBtWlQyajRuMENTNVRuMWUydmF4d2twTWdaS01ZZ1NzNXds?=
 =?utf-8?B?dVZyZ1k5aFNhN3lMbUZxTzFjbERmWEZ0RCtJeUFWeVNZL3RPRnMySXBPU25s?=
 =?utf-8?B?SUVFckJabDVBdG5yM0Y4NFdseGVMUHV6eXluTlJYcVhsZFdEVHNGbDFUVzdj?=
 =?utf-8?B?dHZHMCt3ZXRKNFh0eW9adzlpV1ZoR0YrNjU0OGkrRFJjalVoWUE1eDRocm5X?=
 =?utf-8?B?bHFQNUZpaTlGRTNBaEsvclkrdXRkNTQzZ0VleCtkcXg2NWRHSXRVRUcxVXln?=
 =?utf-8?B?TDN4WlhuWjdtYWlOQ3F3V1NSSWRKd1NQa3BVTmlwKzEvL3YvYWt4YitCODVy?=
 =?utf-8?B?eGFaVzFhYWNBTDZuSjVtQWJmVS9yUnhPbzdINDhFdHlRK2t6N2NqQmVkRnNK?=
 =?utf-8?B?dW1iZmpXWTM1ZFZmTGNWcGJQWXZCVlhYYiswTkVxaFRuamFmTGhnRVF2QVdW?=
 =?utf-8?B?emVJN2pUOFVvMER5SDVPOHVrQXROZStSMU11RGJldUlLN05VOVNpK1NPS3Jt?=
 =?utf-8?B?QUI2K1pxYUpWSlcyejFZbzZJQlBuenN3K1dqRy9UWG1hK2x6U2M3UnFxNTJE?=
 =?utf-8?B?MVpDZUY1YktPdUpOVFM1WERqbkJOZmZwUEJyVVh4VGl4dnQ0TjBkU1RjcHlZ?=
 =?utf-8?B?NmhBeUNhUXVhcDVnOS9heU43T290ck40SExaMEVaWUNFMmR4aUlTWnhWK1RF?=
 =?utf-8?B?RVgvSXV4aW9qZEoyZjAybi9Rc2JkNE1jTjBPT0tuRGhJN2VZV3BvRTY4cmJE?=
 =?utf-8?B?am94N0hxRTVFQ3BJL2tYN0l3RUdhUWdQbXhGekFUbml4ckZLOEZoZWpzc1I5?=
 =?utf-8?B?ZmZvWU96bGtFYmpsMExPaGIxdmNnTC9qSWc0L2FvbW03YW16N3lCeCtjMnRI?=
 =?utf-8?B?bWZGSlhhU3lSV3pTL1BDbGFLRHJpaUF3akJGOFExWTJ0ZEJyNmJWbXA4SFdK?=
 =?utf-8?B?VjhTeG51Z1d2T0E4bitJWUlOaGVwM1VjaHZ6cks0U1FLSzlTUk5ZbmZ2NUFZ?=
 =?utf-8?B?dWdBY0ZVRy9FbDZvWXVDYVpFN3NTR2FTWURVQnpQQmhPdFJsbitOeTZrblcz?=
 =?utf-8?B?SXRYVHB3QVJ5dzgwQ1RkYnJmbERSWWltWUgrcEhXTkFKaStmSFN4Qm1Kbk5X?=
 =?utf-8?B?RFYyajgzVE1zQmN4SXdIMldhVlgyRU4rR0ExMEw4U2wwZittVDM1SzkwcFV5?=
 =?utf-8?B?RW0za3hTYnZZZ2ZBYXA0dWw1ZXB2NDlqWXFkSTdScGRzdlpsRmR0enl5Qzhu?=
 =?utf-8?B?andBK0E4Q1JwWnBXdzVrTUQvWllzSEQrVzZYdHZBNmhKOERrVGttNWtRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXorY3ZZYlRvZ29QcVpVa2djQ1lpV3VjSjZ3SmZUdU9BUlhQTUFGOHc0V080?=
 =?utf-8?B?R0JKODM5S3Y4YWx0dGhFQWIvLzRqczJGdzNJTVAvYmljR3EyVjUvYy9lVStD?=
 =?utf-8?B?ZmxPdy9URStwMzR0bEdDZzlEVlA4b2IrZTI4cEFlVlE0N3dGbTdtamlrRWVx?=
 =?utf-8?B?TElwZHRHRmdsbEE1Vk9Sb1lvekpwQkUzOTNGMGgyOGFDTHZsbTVDT3JnTHZ6?=
 =?utf-8?B?aEZNbENPWVZMNUUwTDcwd2QzUE9XVEdPWTB2ZXpKbHRGWDVRNGF4cGFNZzN1?=
 =?utf-8?B?VitreE1SK05WaVFXWE94dFBDWU5mS3BhVDcxNDNYYmtOVGRxOG95VmlzOTVB?=
 =?utf-8?B?bTA2Z3kzTFp0VGZjMXlqNXptMU5tNUVlNFpWWEFhQ0JBNklOaFFwUW5NRThI?=
 =?utf-8?B?RHBBQjV0cGNyaDhSTGwwQUlDVmdnaUNPaEloZHJaV3YvNXBUZll1N1hTcnNW?=
 =?utf-8?B?ZTA1d3JTL0Fpd2ZCUkpzSVY1TW52QUl2bVB0LzUzbUU5dWZwN2VpNnRDelZy?=
 =?utf-8?B?S0NxeS9reVBjZ0RrRUp0SGtvUWNYT3RuOHcrUVRZWHpuOVVCa2F2L0Vsb1dT?=
 =?utf-8?B?WmJ0T1pBdVdUaUhrc0J6c01RTmRoL3Z1bEhiTHd6eklTbndMQWxtN1lObWUz?=
 =?utf-8?B?ZHVkNnNIMjhXS2EyRnZZOUNrQzFsRklJWi9OdDhwak5LKzg3ZCtkSTYrNlJz?=
 =?utf-8?B?U1g1Vkh0eThYd1hnTDZpa0lvUzZhRFJpY0wydUlnUjdtdUpkeW4rNVdlenZS?=
 =?utf-8?B?eWhySlN5alJXYThQRzBSOWJMdTMrTW9DenpQV2o0K1R5aXhRUEoxUkJSQWN6?=
 =?utf-8?B?ZVpWbHhaUERxckxyNkYvejdLb053RWhxTUMxL0tqaTB3c1hQZWtObVRqT1RG?=
 =?utf-8?B?bGRaL1E4WlBwTGN3ZktlR3YvUlJ1a3gwK0d3cDZzNWplamlnTy9Ka21kRjN3?=
 =?utf-8?B?c05EMDBhTUxpWmEyRXFhakNlTmZ3Zkl6Q0UrdWVxV1JUYjBlaUQrZFh2UTZK?=
 =?utf-8?B?RURqOEtjcEluVjJZVlZVVkptYXV3RVMrcjVTL0NqUEhQelI1YWFqV3d5S1c5?=
 =?utf-8?B?OW5HU29qeFZ3WHhLSjFjaWdVaE1FUGRJWkVjR0t5aW51MGlhQjBocjB3enlw?=
 =?utf-8?B?b3o2K3Rna0c1bkJLMkU5dkttT3JXV2tiT2xiYngrMlFNZExOMGpJbEYxRWkz?=
 =?utf-8?B?WGdTaHJpRSt1RjZObHF5U2RrUEhheDBjRE9VTkN4bXc5UGk0aGlqMnd5TnJW?=
 =?utf-8?B?Nm9XTUxRcDM1RUl1eUpUSDhRT0tvbks1MEpwajBPditON3JST1ViTGRjNWwy?=
 =?utf-8?B?d3RVb2xHaXhRV3RUdmFZSWo5SEhrRGhNNGw0R2lGOEFrc3BwNUlhWlZtWmlM?=
 =?utf-8?B?R0EzYjB2bU85MWhUd0I0TG80UTd6aEsxR051MERpYWdZcTlSRXRsd1g3YVBk?=
 =?utf-8?B?eDY5d3hQRGtyNlZONXpZTWNwTDJ1bE5nTkZmbmhzY0o3R0pHd2MrQXIwUWRk?=
 =?utf-8?B?U1V0UFBQcWwrZkhLcGo0dEt0QW9rTTVrSmRBV0MvNmNmeHVqMjl2TXdVU2tv?=
 =?utf-8?B?UWpEcml3K3FqYlhqZkgxQ0gyZTdFY1h2eUtGM2ExQ0FJNmJOZWNwb0p0ZGF1?=
 =?utf-8?B?bXZpY3ArRFpQNldidk83ZjFaY01qTzBDQkRDV3kxeUtWWHBpTER0QmhobHdK?=
 =?utf-8?B?U0dpNC9PK1BFRS9NeEVEc1JHdldTUDZBWG9abCtWYmk3bFFmMkVCK3lwaWQ0?=
 =?utf-8?B?WWpNL1JTMS9GdWNMUDBBWlVIVThlK1d1cDFVMHN2bGFrdVNVVXUzQmZDZE80?=
 =?utf-8?B?RnlRYzRSOER5TzJ5YjZaVklGMjV3VXNQQmtrQUlReW11RFVQaklod0sxNzFD?=
 =?utf-8?B?S2J6djRJczVqcDVpeE0wTFFUZmNnWWpMT2NoUjNtbWF6N2x1MXI1RmVoZ2hB?=
 =?utf-8?B?N0wvMW9mUitmVmY5T0pLV1lMOXlVSjF1Rm9Ya2YvVytHZkx3MFZyTEdxQ1dD?=
 =?utf-8?B?UExjN2g4OTl4bVpKTGFFYzhnTG5tbEp6QWtzVXB3bDFkYXZVamtMUEFONlVh?=
 =?utf-8?B?UVcybGxYUWVFZitLQm90eEw0V3d6VjR4K0w3S1ZPN3NGdGdtTUhFeGlBVFBr?=
 =?utf-8?Q?jSkKHm90/1AmLRPEY7bRDTi8o?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wqQMT8SqdBrf0osfCwDYR15eduAxn4x6zIgQjW49PAxW2NO9WVjVItCrM/3PAy9dIJaKAEIMoJRI2VQMdtGVP5vsoadWoXgl5j7ibS8svUFtEV0co3RZfE3Qd36KA1I3H2xebgP27n9voIngltKrAVuPET+TKLZyrH0MZVZowYSb7Q23xiCkclSR2P6gUdhcMXID/1K/lwa6luOx/vgHffCEoj0uI8PVkDIOQe6c6sciIaC/Iu0IXaRmo0oOrLxsWslX7EiAn4CR6nAaIUqR3YNAU0xcM93Le2nvJrHR+Xx071cFTsVc+avYtqXTee0OVVQEz8qaBbVQ3RDL+Mj9Km16g69FjW4iA8Br2LboaDi3aCaIKR43dP6GtZzAxSd+snxt3cEn6vdkURelfq36wH7v+JdQgLl4R+Qzjvm+MhN2NGsUH96IChM8+SYeYTtlsXSCRPo76roDcN5I8aMtGtVTw+Gu2f064ustlwoJuc2ijWSCPSUGrZOW7Dj/hR6DDIe0GJEOytWamzc+D4feMoiGyA1UgRSasu6IFD7a2PbOECbGNEFVCkC0pwuEHW0iNeXT8S4Mo2TvbwRiUDjADU7TjpOJ40OcmF5+xTiFox4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a21792b-cabc-4ace-cc37-08dc6f86a05e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:45:18.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+OXUjeaXD9uqdNeh2eEio2VWvEdNUF3akqLzxgeMCGkuPa6V+Qly7/dOyNI9FKrJAnkwssz3nN8geWBTzZEow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080129
X-Proofpoint-GUID: l7w8dImPO2RWVUOnuwBVWuSccGw08xiv
X-Proofpoint-ORIG-GUID: l7w8dImPO2RWVUOnuwBVWuSccGw08xiv

On 5/8/2024 1:08 AM, Miaohe Lin wrote:

> On 2024/5/7 4:26, Jane Chu wrote:
>> On 5/5/2024 12:00 AM, Miaohe Lin wrote:
>>
>>> On 2024/5/2 7:24, Jane Chu wrote:
>>>> When handle hwpoison in a GUP longterm pin'ed thp page,
>>>> try_to_split_thp_page() will fail. And at this point, there is little else
>>>> the kernel could do except sending a SIGBUS to the user process, thus
>>>> give it a chance to recover.
>>>>
>>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>>> Thanks for your patch. Some comments below.
>>>
>>>> ---
>>>>    mm/memory-failure.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index 7fcf182abb96..67f4d24a98e7 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -2168,6 +2168,37 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>>>        return rc;
>>>>    }
>>>>    +/*
>>>> + * The calling condition is as such: thp split failed, page might have
>>>> + * been GUP longterm pinned, not much can be done for recovery.
>>>> + * But a SIGBUS should be delivered with vaddr provided so that the user
>>>> + * application has a chance to recover. Also, application processes'
>>>> + * election for MCE early killed will be honored.
>>>> + */
>>>> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>>> +            struct page *hpage)
>>>> +{
>>>> +    struct folio *folio = page_folio(hpage);
>>>> +    LIST_HEAD(tokill);
>>>> +    int res = -EHWPOISON;
>>>> +
>>>> +    /* deal with user pages only */
>>>> +    if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
>>>> +        res = -EBUSY;
>>>> +    if (!(PageLRU(hpage) || PageHuge(p)))
>>>> +        res = -EBUSY;
>>> Above checks seems unneeded. We already know it's thp?
>> Agreed.
>>
>> I  lifted these checks from hwpoison_user_mapping() with a hope to make kill_procs_now() more generic,
>>
>> such as, potentially replacing kill_accessing_processes() for re-accessing hwpoisoned page.
>>
>> But I backed out at last, due to concerns that my tests might not have covered sufficient number of scenarios.
>>
>>>> +
>>>> +    if (res == -EHWPOISON) {
>>>> +        collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>>>> +        kill_procs(&tokill, true, pfn, flags);
>>>> +    }
>>>> +
>>>> +    if (flags & MF_COUNT_INCREASED)
>>>> +        put_page(p);
>>> This if block is broken. put_page() has been done when try_to_split_thp_page() fails?
>> put_page() has not been done if try_to_split_thp_page() fails, and I think it should.
> In try_to_split_thp_page(), if split_huge_page fails, i.e. ret != 0, put_page() is called. See below:
>
> static int try_to_split_thp_page(struct page *page)
> {
> 	int ret;
>
> 	lock_page(page);
> 	ret = split_huge_page(page);
> 	unlock_page(page);
>
> 	if (unlikely(ret))
> 		put_page(page);
> 	^^^^^^^^^^^^^^^^^^^^^^^
> 	return ret;
> }
>
> Or am I miss something?

I think you caught a bug in my code, thanks!

How about moving put_page() outside try_to_split_thp_page() ?

>
>> I will revise the code so that put_page() is called regardless MF_ACTION_REQUIRED is set or not.
>>
>>>> +
>>> action_result is missing?
>> Indeed,  action_result() isn't always called, referring to the re-accessing hwpoison scenarios.
>>
>> In this case, I think the reason  is that, we just killed the process and there is nothing
>>
>> else to do or to report.
>>
>>>> +    return res;
>>>> +}
>>>> +
>>>>    /**
>>>>     * memory_failure - Handle memory failure of a page.
>>>>     * @pfn: Page Number of the corrupted page
>>>> @@ -2297,6 +2328,11 @@ int memory_failure(unsigned long pfn, int flags)
>>>>             */
>>>>            SetPageHasHWPoisoned(hpage);
>>>>            if (try_to_split_thp_page(p) < 0) {
>>> Should hwpoison_filter() be called in this case?
>> Yes, it should. I will add the hwpoison_filter check.
>>>> +            if (flags & MF_ACTION_REQUIRED) {
> Only in MF_ACTION_REQUIRED case, SIGBUS is sent to processes when thp split failed. Any reson under it?

I took a clue from kill_accessing_process() which is invoked only if 
MF_ACTION_REQUIRED is set.

The usual code path for delivery signal is

if page-is-dirty or MF_MUST_KILL-is-set or umap-failed, then

- send SIGKILL if vaddr is -EFAULT

- send SIGBUS with BUS_MCEERR_AR if MF_ACTION_REQUIRED is set

- send SIGBUS with BUS_MCEERR_AO if MF_ACTION_REQUIRED is not set and 
process elected for MCE-early-kill

So, if kill_procs_now() is invoked only if MF_ACTION_REQUIRED (as it is 
in the patch), one can argue that

the MCE-early-kill request is not honored which deviates from the 
existing behavior.

Perhaps I should remove the

+ if (flags & MF_ACTION_REQUIRED) {

check.

thanks!

-jane



>
> Thanks.
> .

