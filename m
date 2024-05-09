Return-Path: <linux-kernel+bounces-174640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321AB8C120B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4B11F21EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730316F26C;
	Thu,  9 May 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e4Dc4pKN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fo4qvMWc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67B383BD
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268897; cv=fail; b=RXDYDP4a9TXKdAv/aPQUijimPgmwxlG7z5omswBvi/LgAK3eEd6vo82Z+BYSMDj5e7a1mfPAp1Vatz5aUvbIMTDgGldJKdo5crxnVetTnTWkmGayQNmUC4P20cdZrYhFes5+WoHhzKymfVASDMF66nr5Y2qsE2U5BbBtSBOTl4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268897; c=relaxed/simple;
	bh=J4m8N0oOX6aKA8d6CbonYFIjlXIyPVQlx1py2BvjHq4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OB5UkqIXm2KsOcdcN9x+tHCJMZrWmsMOyLV/Ws1bfWsKysXO/tiBzCDmvTofBPkGfcMN4YYRm9mL07egqKNMkLYxn0sb59r3dvaQmXLeweFSNEKAozJsdMZGFWdPpx91b4oUFiRf+sjRqJ6i70R+r/ebE6UERb3H0XOczr1mAmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e4Dc4pKN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fo4qvMWc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449E0Zqi027137;
	Thu, 9 May 2024 15:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=n5WV9hPJeaNzEJTZ4V0HEWfi2RV4H6gKnG3FHkL0Vfc=;
 b=e4Dc4pKNYyXkADawzQVFlSuI84q1UsUx0u3ePk16PKfHt8aj3wEWfngwkeoC1ktmOxEU
 dGRsgYx66qlsFHSJEp9fl0gyI6Za+sRbDrBV1ytxOhh0rsATjr1gYoX7mqnAZ/idZ2UC
 duU0B2X/kikj/H9Nuv8kJaoTIh3wJ4m6uiKy9n6tUyaYbbLWv64k8N6E/ez2g8Ycxbe4
 wGnvR1ZKDxXd0k6GKHXqSProM3vQy1e1x9hwLcsfrpWv4W3BVdnm5kzU91NXCYnmh1oJ
 lOj9EaDFpnTzJ4Pq9mVxKraIoXt6fDDkhgEyKDRakzhc99e9RxuvGj/P50mJqtn19o10 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0sef95mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 15:34:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449EbxPu030914;
	Thu, 9 May 2024 15:34:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfnna5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 15:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCdG4N1SgjHhP9pIY5e65F77Ctl4ymCWKHobeVp2g/0H/64dI2aVeMYYfnvsrseqwjnmPeOh3dD33FGfsN6AhAG0girecW3aJ+PaQr9dzJ/AwkX9yh4JsJd6Vt60WfW9ZE6OYcx8ImiesT9swG6ai4ROep+DdQGfi33f+FiT4FaEUSlUGq6WxvZd0bh+trFBM/5G9Ok/3D5Ii2zNTGJK+mcWElEGNBbwxG9rWtNhOQJNr8pcmgTf8gAxnw8oaXnrUKGlCedj0Zb5MNhAjqd7PrlRZXS7PdPyHkZWfKaMBWcLVFEjzNjqJVqmeg5RvQ5inz4DVQXpiUIAEipJodEcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5WV9hPJeaNzEJTZ4V0HEWfi2RV4H6gKnG3FHkL0Vfc=;
 b=FISe8GNlF1SctOrNyKgnxNb1HTx44prcZkLSf+yHP9d6eV4nMRDpN0ZzvnoQxqY4ctGZt2g0n4Q7aebqezIy7sYXX5IpomLEzeMm1E9xAGNMsuZ8HGA4JvnX8QKDd2D5DnTmk2JFPWybYHFD9OUbYPteSFGq6onsAuzt42zMdtskVv/CoA79brklepI9Niabb1u+Ds1wBTHzFyRdp0DcdUKRiHfRRpHWrk3h1tV2WxkqVegPsn9HV3w7zUyynRFtAvySpj0N76GVXhQQaVLAuxJOememM+D8KexmBZOoPuK2GOf85Avz0Nkcwg89IlMW6QtO7eolGB9cF4V2iPYF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5WV9hPJeaNzEJTZ4V0HEWfi2RV4H6gKnG3FHkL0Vfc=;
 b=Fo4qvMWc+adEuUf2tHM+/iLfFXGO+ixRm3tXc5TjAuUnw/u8vjn6ZCuvOFYfrugiDVHsWaMYqq3ZOt0pFrTpJfCnMbcxNJGFfcIQNsKSkyq7mFm/8/6MtUYS0mpl8yyXp3Lt9zfctb/hCtq1eO5l+ZAO3zQbldlg8tbyZtp1oNg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 15:34:41 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 15:34:41 +0000
Message-ID: <7a292357-8515-4ea6-b4d1-6ca6fa407e72@oracle.com>
Date: Thu, 9 May 2024 08:34:37 -0700
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
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <30d4d249-e3b1-79d5-3501-0ccb9c529110@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: f305c64f-0dde-4466-8ec7-08dc703d8b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UW96VXphZGNqSnJzbTA2T25PajZ2S2lkRDR5aTdNbDFrd2RVV1ExNFIzempJ?=
 =?utf-8?B?MmdHbXpoZlkwNm5LR1JIT2hxd0JDb0VDTFlDeWhGeFNUZlR2eVI4ZTFFS3or?=
 =?utf-8?B?WFVZSGVHQzQxMVZmYVE4Q1craEtpR1BzdjdzVHpRY2lDZ2tZa05xK2h1NzU5?=
 =?utf-8?B?V3pwQjhZQnl4ems3ekhqc2xRcXZRTEN5MXNxdWIzZVZaRnVuK3lPK1JFS21P?=
 =?utf-8?B?aUkzc0FqSFBnanU2MUZ0cnNueml0WHpUU0tmazZjSjBXTmxWcEc5cEZQU2JH?=
 =?utf-8?B?QjFYT2hOazN3enpsZUlBNVI1QlNFVTN4YkQzMm1nd2VuS3FtUWNXV0U4cGNl?=
 =?utf-8?B?T3craitRc1ZHUzBTOEVqeGx3aitLa05VYVNwYndlNnVxOU5QYzZFT21PbFpS?=
 =?utf-8?B?am5FWE5BczkxRGVDVTVOTmFTaXh5VUJ6aWI0VWZxUDEwS2F3dFRocmduSC8w?=
 =?utf-8?B?VzFSbVJ3RnJwNmVlMTBKcXI5cjY3VjBUcFVNZ21ZRVZGQkdWWklaWFJjajVJ?=
 =?utf-8?B?aVh4UEp0REZjQmRtUzdiT2RwSlRqYmNtVXFtTzA4MDFUdWs3d004Rlo0ZEpX?=
 =?utf-8?B?OFJSczBnNDZRQ0ZCaFVlS2t0NmRHRGF0Ukd3RVM1a054c3NxQ1l3WnBDNHZp?=
 =?utf-8?B?d2lEYnBhTzB0MkxrUVdWeXpZa0VNbThUT0FPNFJQbnk2b3VmbGcvRUdYL041?=
 =?utf-8?B?NHovNjZHU1dqUjZBdXR6aE5PZ3BCSTM5YlBIYmwvbzVKa0YrUjJ2ajh1RjFY?=
 =?utf-8?B?T3FQcW5YUXVLZG5tdGl1VVhiR1U3Z3VaUDRvZmtSNXNINlZGMk9CTWZBallq?=
 =?utf-8?B?N01iSnFudE03MTh6SDZYTmtNZ1FROWZZZWxvSHd5TzA2T3h0YzF4SVNNTlJ2?=
 =?utf-8?B?NnFGV29iQmttZzMza2NhZkE3RVluYllTdkpuT3BOYmN4ZmlJUllWaG1PUE4w?=
 =?utf-8?B?MUkyd1RQS1ZYTjRNeER3aWZFZmFuTVFmZC9mQmtCVzlVRENhcGQwYm4xaGl2?=
 =?utf-8?B?QzFXQ1VFWDNtRWJPVkNiY0NoQ0lZOFVheWhod0tFSGt3Z1ZQR0R3WnRKak1w?=
 =?utf-8?B?SE5mTkJiU2lRdG9Vb3ArYkVWYXhWL1dHYTArZXNBMk5oOWZNZXZvRkMveUZw?=
 =?utf-8?B?WkpLcXEvOTl6VUVYMFlYeFlObzFDbEJ3M2grU2lWajNDRmFoYXFYTlVoWVRF?=
 =?utf-8?B?bWhjdTNZS2NQLzF3ODFqWFEvandkbFMraGRKMXVSTHJxL3VBSGc5dWdDUXdW?=
 =?utf-8?B?MHQxV3ZKV1Bkd3JnY1p4Qi9ocmF2VU9saHk5dTFnRDZpdUFDVUlKTlB1Mkg0?=
 =?utf-8?B?RWFlaEN6Wk9kR043cnBtMmRjS2JzM29IMXF2MW0vOU9hcGllMlFmM3dhNktB?=
 =?utf-8?B?cXdTVVpRVEJIRk83dFhNMy9Pa0M2N3ZuakNyMUQrYnVHWk5zVE9ETEYrQVN2?=
 =?utf-8?B?NnNnbEk4ZDVzaXVkejVLR3hxSGhjTlhheEVsZ2tkN1AvRThQNVowRnY5SXVS?=
 =?utf-8?B?TjF4a2NGeE90UjYwWGRVNDBsc3pYMjVMMXRheFJhRW16OVMzVC85amdOU1J6?=
 =?utf-8?B?RzJjb25RbWQ0Q3h0QUE1OStRRGNZeHpPVWpPcHJObWw5K2VhWE5raTA1aFNO?=
 =?utf-8?B?OTY4WGN2dzJsL042MGltcy9hSkRuNU44cWUybUJXN3ptUHlIc1g0K3JPRS9s?=
 =?utf-8?B?SnQ4V0xVUmZNdWVKdndsMWJIZHFUL2RxUUMvWDcwTTlrZ0ZydjlvYnBRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlMzNTNYdEtaRURjK2VJeHg3NERldHlKUjJFbjM0YkdnTWJTQjVIVUZhL3p4?=
 =?utf-8?B?cXVsSHZCWVlwN2hPY0c1QjlnWU94STVyZTRKUjNkK2xPNURIVHY4NnlIQWNj?=
 =?utf-8?B?RnVDc0U5Zjl2aHJ6U2IrcFlPV0d6MEdSZ1ZWeWNySFplaDB0a0MwVG9Jb3BP?=
 =?utf-8?B?aEpVbU5wVTJOZzZsQ212b01mNXIrSndOanl5MmtHMGtpaXg1UGpmaGFqWkt4?=
 =?utf-8?B?T210ME9xTC9wVldjc3QzY3YwbWJIUWVLSWs0QzVmYVdSQlpXVGs2a1V0WFR4?=
 =?utf-8?B?UHZWSXBXOEgrUUgxS0Z6cms0WktORU44V29KVWdITU9YdnNUcTQwWXhzUnRC?=
 =?utf-8?B?aWdiS1pHM1FYWGFGRm9lOFhzWklhUW8xclM1S1ZxT2VJTHl0bnZ1dkwzMEJZ?=
 =?utf-8?B?YmFFRk93LzdBelZwME40RTE2WVRvVFEyS3Nsa2FVSzYzSnlyejdmcEV6VWtV?=
 =?utf-8?B?aFY2S1BwVFFDc09LZTFwcFByK2dFY3NHUDNxVE5BQjBjdVBiekRpNFZ2eDIr?=
 =?utf-8?B?VXE4MlVNUUd1OHA2bGR2dEhoOHl0TGpjd3dYelBRTTdYdHZpR2VTWHRaN0t4?=
 =?utf-8?B?akJGbytYN0Y4Tjd6QjBNZ1hjbndyMHkzYW5sTXllbm9MV3Nha21UTERXbWpP?=
 =?utf-8?B?YWRqR2xmL2FuTldNRDVxU05sTHovY2hCMk4vbjNZNXF6MkhJdUV2aDZoZE5I?=
 =?utf-8?B?dTRiVVUxamM5OUxGSHJOUmFJU2c5VVZUT0ZUMDVlZjJ2TGRmd093bUhqTzNT?=
 =?utf-8?B?OElaY3pOSnhQcFJFMXRLNGp5T3Zmajg5RFpnd25pNE80VGVzdGM0bjVZcTgw?=
 =?utf-8?B?KzZXNGJDYm1KclNlRjhiQi9SWHJJNmkyblJQZEkvOUVZWGx4K2Q3d1gyaEYz?=
 =?utf-8?B?ZFRFZGxVVjQ3cU5Bd2h1Z1VwbCs5VHZDaGdRZ0w3Um1FMGhxc3FGZzdFRm9m?=
 =?utf-8?B?S2VIS1ExRjJCNnNyUzRTMmw1S3RJUEdFTGxzV0Q5QVRMRWtXczZVM1NrRCtQ?=
 =?utf-8?B?UkNZLzRNalJpZ0xRenB3ak5OTkxFckJhVDhNYnd4cjhRaU5pSWVYczlxMWVt?=
 =?utf-8?B?aHJKWWliRjZyL0xMc3lERHA0TTRXenNGeU9ZR1ZaM2V2SEVuUkpETWVKYUIw?=
 =?utf-8?B?dEdSR3EyMzYxUEx3WFo2WEd2Z0F6YXR5Y1NKMFdpN0VuYWEwOXVPSkhPVWxj?=
 =?utf-8?B?RFloU3BTU1dOYStTR0ErMys4WVRsMWdobjJzZlZyeTdDUDF2WXhGeFZMTVlu?=
 =?utf-8?B?VVlRM3gyaVZYWk9lRHZvRzB3NGNWMXNSb1c0M2llVVNuQ3ZOU2FmN3VTQmcw?=
 =?utf-8?B?Z1BUYnE4YTBtaWFZVXpOeVU5VnpmNnR2a2pvRVpiZEwxa3ZXUjg0QklNUzVH?=
 =?utf-8?B?NnhwTDNGWXZjOVpWSERzUS83WlNCdzVKbHBGM09tTkxmZEtCM1dxSk5hRS9o?=
 =?utf-8?B?V3l2SE1mdzFIcTNGZEVweENDelROWkx5NW5CU1hpUnhsbmZzTEpvcnFMOG5E?=
 =?utf-8?B?S0dNd3p1V3JORmRoeE9Lak5OaHFEQVR5ZVBUYmVvVVA2SWdGWWl0VmI1MUVD?=
 =?utf-8?B?SlJucUltK05FdHZDc09RSGxoZUtyMlM5aXpxalcxOVlmTUx5WEc2TitIOE5E?=
 =?utf-8?B?dVNuSlQ1NlBVQk12bFBXYVMxbmxJZUVsMlU5aVFUaExRalg5WXREd3R4ek9D?=
 =?utf-8?B?VVBsYWlJTHoyUVNpNjNaTkZodTB6NVUzS0xZa0w2cFNKSHV1TlhvWXRaNk04?=
 =?utf-8?B?L3B0S3E2MVZEZE1hL1dyeElyaERteXNXS3NXMWE5dVQyRUkreXdXdlNSUkhr?=
 =?utf-8?B?LzZCaEZMNmhyaXpWLzZvNVhiSFhXY1J1WXhYMFNlR09yZXlFUDFrQm03RFpG?=
 =?utf-8?B?SnAxRnpFbkZTU2h6SGFiVUZTUHUxaHdIdStIUllzNU9vVlViR2UzSXh2elha?=
 =?utf-8?B?cVlpcEdYN2NoWFRraTVyamRTNTVmTjJ3SnYrQ1NiS2I5eklURzI4QUdRQlM3?=
 =?utf-8?B?NG9scDdHL0d0czk5b0NET05zZmp6cXk4N0tkY2RsUnJzM0RPcFgyWEd1SGt5?=
 =?utf-8?B?N1dIYzNUN1FQK2xBUjNscXEwTEhJNi9CS0oxUnpXRlRtSjhURW5Oc2NvUFRR?=
 =?utf-8?Q?EpNRPA5/1r8pyhHZb9VwlGzb0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	g8ReaJ6ORdZX+G30KrNOb6abjn7qVB8kvi0CtrNZ6dCQqib4M3aEe3OHErdxoQ0L1Ne/B79WNSNLJVYkDasjQdWDjJ757Fd8KPmqyUCTI8Q2bqaFjKWQ/2Ef0Bgd6jhLmyx3Z9mb3JhSezyw4Q1wVMXfBa7n6hj/1hIFzp2sAAZT6Sgmn8PqMTUcjxZfZ0Nx2MIwFGLNcKRpfg9zRWcOS7E3XysupxOohpguA4R4z8oAnc3FamL9uqXJtksQRavTvZM/fFayanM6gDt5X4OU7sHOxkUW6bbQ6ay9bFEAIyHjg1/AmYUcKN57T+OT87wD/a0G6xgue2CRG/hctm8XKejYP2uEiH+rGVlR+pjAkcmH0kZy1goiUruZpCg2HDC2m5fV/J1ccf+24owyi3feekmvJmR4MCrSLeGK+8IvwPDi44UpDd/lbwVOuBazTc9RQpeTbkFiwE2WaJuf23gmdBC7x7DDdZgur3ZWUQlp0DjueFih0MyUKqNmeV1R8xATzUlzjEfWyGTMUiZtbz9sqWsSCVlXGODfD8qxYvrYpUQlJBM+4hAkWXbQAiEe5V33bjusoCXmmLFqye7NTCMg5z31R5s8WgiLRDIyHGH3CgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f305c64f-0dde-4466-8ec7-08dc703d8b3d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 15:34:41.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBZxI6V0WlYU500H1v18eZ9d9G5KGDA9DxWOstJypNwy08RNLO4p4Dpzne3+ZwsW0FG+leKqoh5SBiWmkmfGww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405090105
X-Proofpoint-GUID: VFKSetBkdCOoeYNlzgXULXQfSUbeiv3z
X-Proofpoint-ORIG-GUID: VFKSetBkdCOoeYNlzgXULXQfSUbeiv3z


On 5/9/2024 1:30 AM, Miaohe Lin wrote:
> On 2024/5/9 1:45, Jane Chu wrote:
>> On 5/8/2024 1:08 AM, Miaohe Lin wrote:
>>
>>> On 2024/5/7 4:26, Jane Chu wrote:
>>>> On 5/5/2024 12:00 AM, Miaohe Lin wrote:
>>>>
>>>>> On 2024/5/2 7:24, Jane Chu wrote:
>>>>>> When handle hwpoison in a GUP longterm pin'ed thp page,
>>>>>> try_to_split_thp_page() will fail. And at this point, there is little else
>>>>>> the kernel could do except sending a SIGBUS to the user process, thus
>>>>>> give it a chance to recover.
>>>>>>
>>>>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>>>>> Thanks for your patch. Some comments below.
>>>>>
>>>>>> ---
>>>>>>     mm/memory-failure.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 36 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>>> index 7fcf182abb96..67f4d24a98e7 100644
>>>>>> --- a/mm/memory-failure.c
>>>>>> +++ b/mm/memory-failure.c
>>>>>> @@ -2168,6 +2168,37 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>>>>>         return rc;
>>>>>>     }
>>>>>>     +/*
>>>>>> + * The calling condition is as such: thp split failed, page might have
>>>>>> + * been GUP longterm pinned, not much can be done for recovery.
>>>>>> + * But a SIGBUS should be delivered with vaddr provided so that the user
>>>>>> + * application has a chance to recover. Also, application processes'
>>>>>> + * election for MCE early killed will be honored.
>>>>>> + */
>>>>>> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>>>>> +            struct page *hpage)
>>>>>> +{
>>>>>> +    struct folio *folio = page_folio(hpage);
>>>>>> +    LIST_HEAD(tokill);
>>>>>> +    int res = -EHWPOISON;
>>>>>> +
>>>>>> +    /* deal with user pages only */
>>>>>> +    if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
>>>>>> +        res = -EBUSY;
>>>>>> +    if (!(PageLRU(hpage) || PageHuge(p)))
>>>>>> +        res = -EBUSY;
>>>>> Above checks seems unneeded. We already know it's thp?
>>>> Agreed.
>>>>
>>>> I  lifted these checks from hwpoison_user_mapping() with a hope to make kill_procs_now() more generic,
>>>>
>>>> such as, potentially replacing kill_accessing_processes() for re-accessing hwpoisoned page.
>>>>
>>>> But I backed out at last, due to concerns that my tests might not have covered sufficient number of scenarios.
>>>>
>>>>>> +
>>>>>> +    if (res == -EHWPOISON) {
>>>>>> +        collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>>>>>> +        kill_procs(&tokill, true, pfn, flags);
>>>>>> +    }
>>>>>> +
>>>>>> +    if (flags & MF_COUNT_INCREASED)
>>>>>> +        put_page(p);
>>>>> This if block is broken. put_page() has been done when try_to_split_thp_page() fails?
>>>> put_page() has not been done if try_to_split_thp_page() fails, and I think it should.
>>> In try_to_split_thp_page(), if split_huge_page fails, i.e. ret != 0, put_page() is called. See below:
>>>
>>> static int try_to_split_thp_page(struct page *page)
>>> {
>>>      int ret;
>>>
>>>      lock_page(page);
>>>      ret = split_huge_page(page);
>>>      unlock_page(page);
>>>
>>>      if (unlikely(ret))
>>>          put_page(page);
>>>      ^^^^^^^^^^^^^^^^^^^^^^^
>>>      return ret;
>>> }
>>>
>>> Or am I miss something?
>> I think you caught a bug in my code, thanks!
>>
>> How about moving put_page() outside try_to_split_thp_page() ?
> If you want to send SIGBUS in the event of thp split fail, it might be required to do so.
> I think kill_procs_now() needs extra thp refcnt to do its work.

Agreed.  I added an boolean to try_to_split_thp_page(),the boolean 
indicates whether to put_page().

In case of kill_procs_now(), put_page() is called afterwards.

>
>>>> I will revise the code so that put_page() is called regardless MF_ACTION_REQUIRED is set or not.
>>>>
>>>>>> +
>>>>> action_result is missing?
>>>> Indeed,  action_result() isn't always called, referring to the re-accessing hwpoison scenarios.
>>>>
>>>> In this case, I think the reason  is that, we just killed the process and there is nothing
>>>>
>>>> else to do or to report.
>>>>
>>>>>> +    return res;
>>>>>> +}
>>>>>> +
>>>>>>     /**
>>>>>>      * memory_failure - Handle memory failure of a page.
>>>>>>      * @pfn: Page Number of the corrupted page
>>>>>> @@ -2297,6 +2328,11 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>>              */
>>>>>>             SetPageHasHWPoisoned(hpage);
>>>>>>             if (try_to_split_thp_page(p) < 0) {
>>>>> Should hwpoison_filter() be called in this case?
>>>> Yes, it should. I will add the hwpoison_filter check.
>>>>>> +            if (flags & MF_ACTION_REQUIRED) {
>>> Only in MF_ACTION_REQUIRED case, SIGBUS is sent to processes when thp split failed. Any reson under it?
>> I took a clue from kill_accessing_process() which is invoked only if MF_ACTION_REQUIRED is set.
>>
>> The usual code path for delivery signal is
>>
>> if page-is-dirty or MF_MUST_KILL-is-set or umap-failed, then
>>
>> - send SIGKILL if vaddr is -EFAULT
>>
>> - send SIGBUS with BUS_MCEERR_AR if MF_ACTION_REQUIRED is set
>>
>> - send SIGBUS with BUS_MCEERR_AO if MF_ACTION_REQUIRED is not set and process elected for MCE-early-kill
>>
>> So, if kill_procs_now() is invoked only if MF_ACTION_REQUIRED (as it is in the patch), one can argue that
>>
>> the MCE-early-kill request is not honored which deviates from the existing behavior.
>>
>> Perhaps I should remove the
>>
>> + if (flags & MF_ACTION_REQUIRED) {
> I tend to agree MCE-early-kill request should be honored when try to kill process.
> Thanks.
> .

Thanks,

-jane

>

