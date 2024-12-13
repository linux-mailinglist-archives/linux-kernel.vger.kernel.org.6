Return-Path: <linux-kernel+bounces-444482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E0B9F078E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAA428721C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068B21AF0C4;
	Fri, 13 Dec 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L2s69nkx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mJTcu/qP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7571B0F1E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081524; cv=fail; b=A2y2Prfv3F0UxAGy9GMEWW983wojkK2KkXRiLtPQMUo1fesnyqFyE9WrBb/n4vU3E54bbKc67EP06Pq0DyFG5l98cGMQG8+ts0r0sZdoV0nkHxbGn6ltK3gvaAEOHhoTO3PyqSCEwQHCPDo96fuMIqyR8bfyS+l2VS8Spjf6Lec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081524; c=relaxed/simple;
	bh=I5m9xE1BFP5ROtyneGBZRYzmUdIe5zHRFDi78Wat3N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jb+4dgW8C02WJEgqr0jezQ9isOcbrgSKFne70Zo1LevKJsDtFhOfEPSI+ksjn7HhjbPJ1PzX7R5sm4FyflYUiKATvxKDDJNSvzTXgKedWQIZ9DZDlHlrW/FsF4thbKQzIl1fDTIb3AKh9HR1NAA3oeE8vbwJM6Q23cmZxu332zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L2s69nkx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mJTcu/qP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1fndX025606;
	Fri, 13 Dec 2024 09:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hNp6Vu1SQeVje3Xri9ymIBYoslsyh/UCnRrXBx84rfA=; b=
	L2s69nkxK94gNNpIazjubTXMH/chvUH0rtmopPfZ86G/FF05X7X9QQS/t+GrYb6F
	f174sTofT9n7+ldQ/DEJRJ45E1o7dp8aOM+aM5o1ZWyZ+KzOGO0H1Y+sb72DCp4K
	yACCbYI+PLZdS4njLCWfiGGFFkbSN1lW7uwKkx+WfucKrq8rQGkYSAHTFR5REE5r
	U+rA0oNtH90Q9Q+QuMz/rQHw6QKKA3IWSBha1G0vAoRcwXoTo5fgGaOaQKI82Dpf
	WZseBZUgZgeUs8gS+VPk8rvWb4hIctr+d+/a1myeDJj1hdgqp4s13keelYHvDt8O
	DLWLYo16fw73XXuhGDEPgA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9aw3h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:18:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9ATle019461;
	Fri, 13 Dec 2024 09:18:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcgcgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXC+HDZWgJBGlHka/eygS6DHIt3RDWQusdsIQ6oyfsV+Pf9DJOodK+eD/6tCgx+ILJ92gdW+rsbZmkP4eR4et1MeC6Wb64MemUrT3B15WZCjsaSOWBCrILHAahA8aUDfPilA2pjA3EVOhnbcb9ZJMT6bScWEQeeVKJa+P0NvulpNshp5Rvr1AaOe1ssBo4uXFpbLvHoqvzxxImclAJ8vghi2iCWAPWZX3rvhOr2FVxecrpNQrsT/mZFtlIn23TpEmAvm7BjwlZUyJ4/wf7L/x+WmThxY93NquZCWCOF1JjnA8zluTSYLOqnEBdlBU4iOPGLB8i03VqzrUFu60XvZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNp6Vu1SQeVje3Xri9ymIBYoslsyh/UCnRrXBx84rfA=;
 b=qi8XU5jgQwX8UxgAvtXRV0Yr7uKiZVfqsAHCEDAVntIPnU40s+f+/fq89YO/BM5ep1DNYGLR1HXIdI7VnWkAbi8LLpmDyaJLBGr8wAqC8oQeZF6AGhnvyHMciLQgjrBIpdDv9HGd7kLZqiSL2mzdH0PR2Q4ZAEIM2Yl6KJjw9n3R/TZM2SaCfytV8/6xexgKl4xqTnkDcAdCJQzxH+2WGZ4EGBlXJKWeYFML5En0GjHArf2UhSVak2fWIEqM8/NQUjtGahfeomTvLC59CppuJD3ZJRkQAfeXO+8A/kwI+EmM9eNaD0Ab9PvQd9L2SkA9RdEYm9wbVz2tZE62FFrDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNp6Vu1SQeVje3Xri9ymIBYoslsyh/UCnRrXBx84rfA=;
 b=mJTcu/qPnd6+xza/CpP3Nzzn1PsvCWivryOSENfIearEaOgrLw1z9ehoCuraBHTunQyiGmRiwX7gFSpXxXqxzR7UITKIVXb5qmj+g0HJbyZH6EJzwe9B3xrxo2EqrED6YThrBAqZsbLxMswmmm6Syzf0UG5dlQyXNd5FfVOKaSk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB7097.namprd10.prod.outlook.com (2603:10b6:510:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 09:18:01 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 09:18:01 +0000
Date: Fri, 13 Dec 2024 09:17:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
Message-ID: <cb5eea98-2515-4b06-8f65-515842e1081b@lucifer.local>
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
 <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
 <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local>
 <CAOUHufYCF0i_aJZPceMXfcTZUcZsCY9fBuMr=25q1bROWx5nsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYCF0i_aJZPceMXfcTZUcZsCY9fBuMr=25q1bROWx5nsg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0400.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b68eec-5639-45ac-94d2-08dd1b570a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkozTXU5QVYxRjJ5Zm84ZDFQVGxXSmd3SWk0RkRqcFV4VEsvbW9VZjZqZHNQ?=
 =?utf-8?B?elVqMzdndnRKSU5xMENOWndhRTlrb1F2VXRKeVlQNXFBSDdQUkkrWGVINncr?=
 =?utf-8?B?ejVxcXYxTDN6ZHBic0tPZ0ErMllBSjZVcjZSYU0vZmJIdHc0Ulk0SW1nMVp3?=
 =?utf-8?B?SVY5NXFZRFk5bjBiYkxTWDdOcTM3Q243T0xOVkFJNXY5NlVVbDN2djFvU3Vx?=
 =?utf-8?B?aWRsdFZOV000bjRtS0VhUkgxSSsxbjc3NXVMWFAxaGliVHJJTUhpcEpYQnB3?=
 =?utf-8?B?dnZPNlA2b2JZK1pEQVFvNnNzTGMrSUxETGE4RnZjQklybnkrdHdXa1U5NDVJ?=
 =?utf-8?B?Tm02RUpKZXlMdVBoYVpia0toaGN5YjFWeitQa1c4MnU2ZnB3Q05DNnpkbGdz?=
 =?utf-8?B?RitmRkJCdEFRdlNpVjJsZ3JKR1pueDc3ckpFT0JGSXM2cWM0LzRKNUM5NnZ4?=
 =?utf-8?B?ekowK2NzVDU1eE91ek5kcmM0aEFja054a1FaSlBWZjhTOEpmczY3VEV2ZUYv?=
 =?utf-8?B?Z0N3UDZxWWpuZ1JSS1ZoWmpxZHc3MllPOU55MVcwaGYwN2pwcDBUakJFdEN6?=
 =?utf-8?B?NCtEclpEKzUwQWNzdUl1dWVidmZLWXV1b2I4S1dBdy9BVHgxa3RXRDRLbVNX?=
 =?utf-8?B?eDNUQkpvNk9aZXYzOFd6WkFCNmZxS0FaRm1Yb1E2b3piRzJSRFA2Y1BVM1hy?=
 =?utf-8?B?bWxnL25WbnArQnB5cEtIL1FWSk9Td2RNU2ZxZGlxajZqcS9DSC9jYTdxaFZh?=
 =?utf-8?B?NHYvVTVTN1VuK283TXloWmxoK1RTRHBOaWhPNmM3b2NqNFVwVXhxOEZVekJZ?=
 =?utf-8?B?bG9GaktMM2JYRVIvUklvZlM2ZkE2YUNnaG5MSWdqd1hFblhpaGVuclZJTCs0?=
 =?utf-8?B?S2prcnozTUQ3aFFhM3FoVTM2dUxjT1RvamtpaGZKaDFrUUZQU0dOQ3ErRTZ1?=
 =?utf-8?B?ZXdwRHJTNWxFSG0vVHZTNjJ4Y1Z1dW1XTXBsU2R4V0VRSXg3bS8xM1BhN3ho?=
 =?utf-8?B?SFc3bFhYeVczUXlXdUdKV0pJa2xXeFBwU1R5R1QrQjZneDVwbmFZZEJ6ZFh3?=
 =?utf-8?B?SWJWZHBpaU44VFBZQjc4MEpHRUlvZi9RWHFQYnRUd2diZFBZS3QwQzdiYXd5?=
 =?utf-8?B?dGZ0YUxQOUJwaU01TzQrWlJJTERyRGZKQk9MOEJlUHp5QVBWVHluT2l2VFRv?=
 =?utf-8?B?Q2lhWE1hV0xXRTE2SlVUVFdlZjhqRDloeTVkMFdrMWxCRkxRSTduMzRwb2hY?=
 =?utf-8?B?TEY3bEVvR0tZUFRtUnZJOWxISXdwUkt0czFnalRuVzJTNzNJWmg2ZDZtU3V3?=
 =?utf-8?B?Y3I0N0hzSHYybEVUUHZFVTk3SnRKN2V2eERqUTNJZUsrMk5BZndDRU1KSVdW?=
 =?utf-8?B?MENJaXYwcnNkRXowdDVmWk43eGY5QitzUlVJNDg4NE9mL3pCYlZBdXJaTkl5?=
 =?utf-8?B?Nm5nYytQQ3YxWFJvNStMYVhKb25xdVk2aHVueWlPLzdVSUd3Z082QTZIZ2xY?=
 =?utf-8?B?TlUrM0Fac3g3QVl2YitDOUpMdkFUK2o3eXcyRkdPNTZueXdPSXRCV0gxQjNh?=
 =?utf-8?B?V0d5eEdPZ0YrVzB3bE15SjJqN3J5NEZNOTYwQjhxTjdsUHdtSTNKMVVITXEx?=
 =?utf-8?B?UXhYYWFtekJocW1RN1BLL2xIeEFCaGNKMHQzMUpSMWVLTXZjT0VhaXpjUVFV?=
 =?utf-8?B?VEFJUTdSOERsbkNtZlNqZVZjSHU0MHo2RFhPMjhGZlJ3MEc4cC9qZFVUZ0VO?=
 =?utf-8?Q?nFYR3ojUK47IGWTuYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHNzbE1VTEdsR1FhQmVYZVcwMGFCWE5heUZKamhRc1dIQnJaMy9kU293MW1q?=
 =?utf-8?B?Y2tlTGxzMy8yVm16cXBXMXU5YTRUcXUyU09sRmhRS0pCbit5c1gxb2ppekpJ?=
 =?utf-8?B?L2VDWFlYVjNRUm5Cb0pvVVFZUVdNNit3RWtxdTU2aTJTdGFDdWhaSEVxREFQ?=
 =?utf-8?B?MEZLanNTTjI1UmJIN0pPNitPeW5XbjF4cGVpWWIvSC92Z2RFbDdPR1FIYzBV?=
 =?utf-8?B?T2k2NksxRklOME1IZGF6Q1V5WmtyUFZiUXNjaW03eWw3VUJvSm1aOGRxQ3NO?=
 =?utf-8?B?dWdnYlZvQnZleE5IQ2RlYlMzZ0pqMHJNMWREMCtERmU3OTJTSVhzSDY4dTh5?=
 =?utf-8?B?OGp4TU9DNDJ2MEZDYkZseGkzVzYzU0VIUXk5Ym5ZVFNvNlhDMWRuWUJsTXBZ?=
 =?utf-8?B?VzBXZ3VDMmpOYWpIcXBRc2lTZGVFeXY2amdzQ3RTc1lKSXBVSHN6K1ZTa3N4?=
 =?utf-8?B?cTZ0QkxBenRCRWtJSHlGSnplMU11YmlNTFl0Z3liVlpyaERhbDFCRXVBY2dT?=
 =?utf-8?B?eWg5ZHJlV202NVJsMkM5TCt1K0I0RkN6TnNNYUZQZWpiSkVOVzdXTWpwUngz?=
 =?utf-8?B?V1BiQVNKNkprS21aQlBqTGswN2NSVFNucFNWVUNiZ2dOdXZjRXZOdFVQQVA4?=
 =?utf-8?B?aVlMMFF6MldOWFE5NGlnQkRNcDZ0TnFCVk1qWXBwenJydUFMc1k4VEh1ckxJ?=
 =?utf-8?B?WFduOHVjKzM5ZWxEOW0wTGJVcnRaWmtEbExXTExGL28xWDR5Mmx0dUtsdURD?=
 =?utf-8?B?Nm9oUHZ4UXlYZkpmczZxNGl3Tlc3cWV2N2R2YSttYlhHeFVqZWF6VVphZEY5?=
 =?utf-8?B?MHFIWUJtd2tGSElucE5yeklLQmk2SlEwNUFOTi9DWWNyZ1p6alBicEJEdkdz?=
 =?utf-8?B?N2MzM0tVWVNNbGFnL090MmFjYWlheDdZR1RicGNadFhPY2ZsbnRaeVMwM1Ju?=
 =?utf-8?B?aDF1b0lYeWtCMUY1UXBQMUQwNVJ0WlFCL2UyRytGZnhpVnlSd2UyVHJ2UStq?=
 =?utf-8?B?OUJEOGpsT3UrYWFJNDgrUzVMc0JHZ0syRFpkbi9ZNzZ0UGZwYzlMUDhZWC94?=
 =?utf-8?B?eCtES0dCVTF2QitxZjg1UlBZdDVob1pxSWJROVFPMVBNaFhrSHkvWnpNNFNv?=
 =?utf-8?B?R2hxZUtsMkhtZG5DK2xLTDVJazl1MTQrZ0lpNzJBVW8zMmZSdzVuYktCNlVt?=
 =?utf-8?B?NXNnNGZXVm1uVXZwZTRoZ09GUkJYWWplRVFjR2RTRFBlaFBZajYrVjd0c1E0?=
 =?utf-8?B?MEhYL0xtUzNGZzRwUUZIS2labkZGUlVLQjVmSTFsUDczbElRYnQ2c2JSRkhK?=
 =?utf-8?B?NVNEbnFUT3JpOXpZTjBaL0w1Y3pWNFZ1dk02VXdrbXJPd0pFdWtWU2VKWmFr?=
 =?utf-8?B?L0hRY3U4TlRmYmRSZ0cxcTdjdnBMQzMzMTRDb1liN1VVSHV4Q0ttMkoyN1BS?=
 =?utf-8?B?Y0xVZG8zZy91SnpNV2pNcFgrVEt1S2U5NW9lb1VpbTJxSHVHcWZBUWU2RkVZ?=
 =?utf-8?B?enRmZ09uSXpnSGdMb2ZmdlZUYldUUlppakg0dkZLT3Y1aCtUQmc2ZnQwMmIy?=
 =?utf-8?B?d25ZbXk4UmsxMXFlVHc5VGJsQzEwQmNxRGhVb1BCZ0J1bWtPbDA3VXd1OTZX?=
 =?utf-8?B?NkQvR1E4cTBOZkNkcElXakt1eENUVEVQVlJxODkyalVaTnVxWENLRm5hb1ll?=
 =?utf-8?B?V25ncERLNkpjZWJaQXpNZks1NWw1VS8vcWxyVWM2UnR4eVB1YlBZbDVxU0VX?=
 =?utf-8?B?eFdQc0w0TS9CTk5sUFgxR0hhSzRBZEZzWkJRVmhHUlJ6d3JGay9jbS9kV0Er?=
 =?utf-8?B?S0J5akdURS9Wb1RIMTJkbU9NenArZUxXZXYzbWRvZS9QcG15NlFoSWU0OEVY?=
 =?utf-8?B?OWZyTWhjQmphRzV4OXUrcHA3N2FMSDJzSUl6RkdlUUo5YkwyeFRGMnpKcWhJ?=
 =?utf-8?B?Snkza21IWXVrVnAwVWlBWEg5SjRiK0RoWjFDWnRlS0hiRmozNEVVRlJHUno3?=
 =?utf-8?B?QjJxQkZRazlJclZZVGtIc2pVczB4RUJYbjV6aTlJbFJtdVNYUCt3THFnZlJY?=
 =?utf-8?B?RytYSndQcGdmS1YrNERDc2lWQXNsUFY4c0EwZ09zcUJUQTFLaXdNNHpjYW1k?=
 =?utf-8?B?WHRTN2JubFhVMnVEVGN3aEs1cnhyTWMvWXdsRU9DRjV0cnkyb1dLVzhvT1g1?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eqNjh90quew3iWcNbz9BzTZMWYsruGt2uBK7EHrFme6UUYAoBIY7CzwQU9ccKa3hs2uIhqaGuwVkOq93y2mgLZN7tPdS7lZLRby/hoAE8QwvY5ZtFoHI8VxGdRz1tdjj84E+JJnOUXk2gUdlvVGRduhp+CM37b09rJvTDJXmmgNzG4qvSz8wFVSUSRar7SKx0f7DQKht6LVqVV65/h5W38N8hlQAx52DCr5LsqkR0s2dh3tXb1OoJ41B0Ie0z1KO6H9iaXMCAwf5COqbQ+AIvTvGgDvBSgqVb9NBn85k9vuFCNxusqqFVx7H04yYnYAZFaRdHgeB/NT+4O3BdKT8QXJr/iAmjrwE3ZI+m1UU3vBFoLsqejtlJ4Zowp9G+Evqpciv5fhfB9/vIkUnPnkO3ZhBxXwdeRvN0ZE7vei6B7Funn2HgbI8Tq5CERAz65xFr/T4eRDorqIruRh7B0K7sGR/QkiuHyCiX5XoYbqdErib6sHSLVTRBtJ1ytf8rTzY1002chvh/89Pf5roL2snzod6PMlr8JZWBGF/DXcdmLLbooVU+Cc4Er1yXs2skMLQraowhd/lEvJkAlBHaqseZixo5HWFkGRn0XmQRV/FnnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b68eec-5639-45ac-94d2-08dd1b570a91
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:18:01.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFZP27xL5Sf11EDDrJRTUNxDci8WqO1gTH7yWUTgUaoNbHzutH0JYDu2si77f4K86UlrvdN48HQwvzuG+AEH6AzqivtG9A0x7Z3xd+N6iNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_03,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130063
X-Proofpoint-GUID: aPEZBiyHjdz_VWhQ_HSkIg_V1oqpSMxh
X-Proofpoint-ORIG-GUID: aPEZBiyHjdz_VWhQ_HSkIg_V1oqpSMxh

On Thu, Dec 12, 2024 at 10:50:19PM -0700, Yu Zhao wrote:
> On Wed, Dec 11, 2024 at 11:57 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Dec 11, 2024 at 10:36:42AM -0800, Jeff Xu wrote:
> > > On Wed, Dec 11, 2024 at 2:53 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > Update the MEMORY MAPPING section to contain VMA logic as it makes no
> > > > sense to have these two sections separate.
> > > >
> > > > Additionally, add files which permit changes to the attributes and/or
> > > > ranges spanned by memory mappings, in essence anything which might alter
> > > > the output of /proc/$pid/[s]maps.
> > > >
> > > > This is necessarily fuzzy, as there is not quite as good separation of
> > > > concerns as we would ideally like in the kernel. However each of these
> > > > files interacts with the VMA and memory mapping logic in such a way as to
> > > > be inseparatable from it, and it is important that they are maintained in
> > > > conjunction with it.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  MAINTAINERS | 23 ++++++++---------------
> > > >  1 file changed, 8 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 68d825a4c69c..fb91389addd7 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -15071,7 +15071,15 @@ L:     linux-mm@kvack.org
> > > >  S:     Maintained
> > > >  W:     http://www.linux-mm.org
> > > >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > +F:     mm/mlock.c
> > > >  F:     mm/mmap.c
> > > > +F:     mm/mprotect.c
> > > > +F:     mm/mremap.c
> > > > +F:     mm/mseal.c
> > > > +F:     mm/vma.c
> > > > +F:     mm/vma.h
> > > > +F:     mm/vma_internal.h
> > > > +F:     tools/testing/vma/
> > > >
> > > Will  madvise be here too ?
> >
> > No. We had a long discussion about this on another version of this patch :)
> > it's blurry lines but it, in the end, is too much related to things other
> > than VMA logic.
> >
> > We probably need better separation of stuff, but that's another thing...
> >
> > > I'd like to be added as a reviewer on mm/mseal.c.  Is there any way to
> > > indicate this from this file ?
> >
> > This is something we can consider in the future, sure.
>
> What'd be the downsides of having an additional reviewer? Especially
> the one who wrote the code...
>
> > However at this time you have had really significant issues in engaging
> > with the community on a regular basis
>
> I'm not aware that this can disqualify anyone from being a reviewer of
> a specific file.
>
> > so I think the community is unlikely
> > to be open to this until you have improved in this area.
>
> I do not know Jeff personally, but I think the community should make
> anyone who wants to contribute feel welcome.

This is very unfair.

I have personally spent several hours doing my best to try to provide
advice and review strictly to help Jeff get series into the kernel, perhaps
more than anybody else.

My intent throughout has strictly been to HELP Jeff, to both ensure that
mseal is as good as it can be, and that he can be a productive and
successful member of the community.

This is, and has always been, my only intent and desire here - so things
are actually quite entirely the opposite of what you seem to think they
are.

My point here is solely that this is just an area that he needs to work on
and I'm not enitrely sure it'd be helpful until he has done so, this is
all.

>
> > You will, of course, remain cc'd on any mseal changes regardless, so
> > functionally nothing will differ.
> >
> > And equally, this change doesn't alter my or Liam's role, we will apply the
> > same review regardless.
> >
> > The purpose of this change is, as the message says, to ensure the integrity
> > and maintainership of logic relating to memory mapping, and mseal is really
> > entirely a VMA operation so has to be included as a result.
> >
> > So it is administrative in nature, ultimately.
>
> Sorry -- I couldn't make out what you are trying to say here. So I'd
> like to ask bluntly: is there any previous disagreement between you
> and Jeff to make you reject his request? If so, I think we'd need a
> 3rd party (probably Andrew) to review his request. If not, I'd urge
> you to use his help.

The point is actually a kind one - that I and others will ensure that Jeff
is _always_ involved in any technical discussion pertaining to mseal.c
regardless of the structure of this file.

However as Vlastimil points out - we can't separate out mseal.c here, not
reasonably. And it is so clearly strictly an mmap/vma bit of logic that it
really ought to be included here to ensure that we who maintain the overall
vma work can ensure everything works together - it doesn't make sense to.

Thanks, Lorenzo

