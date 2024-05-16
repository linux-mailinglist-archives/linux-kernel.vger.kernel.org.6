Return-Path: <linux-kernel+bounces-181601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2408C7E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66A1B21AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2AB158217;
	Thu, 16 May 2024 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AEvK96L+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q4U5jesh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBA156F2A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715896789; cv=fail; b=bxL0YOi2mpwHn55q+Xlc/+CrWCeezldMCJsxdx2fSel3d11f1OMhP3DxZwd+IhP0L/+Se6j+DVN3M9gEZEwEnLSVcFxORaE/BEGd7J2/OhhucGiGzGNspKOrsjGmcwpvS7xoxMwMBE0NbjSi11JYUkEx9qPm1WUlW3Wj6ospY4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715896789; c=relaxed/simple;
	bh=z6OGtNZfdmw6wvzeUzcBSTFTcDJjjQLlqvwjJesUj2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iNpHi8TXqfGrLseN/2pAd1XXGvsCj329tqB16y3QL7b+mPZ1OrgBgGOaMNRtqigekc8I3ICVmnXAGqAeFb1lts+HURwwltTVZW6AU+KYQCwKleQMjZ2KME8arIVwGV4awyVOsVWoY6pzT3nEGYvf5I3o2Pzn5tzPkIb6m1Rw4O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AEvK96L+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q4U5jesh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GKsoP9031221;
	Thu, 16 May 2024 21:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sco2Wpsp9CYSL/1rLsNixZjtCT5FFqCWqOv+6NpE+es=;
 b=AEvK96L+2nloy0E+/2Ah381x3Ra9h/FHyrjrfPnBQqvJfVhBnlZwghP+Ky06AjXfyA/N
 1Z/D7hAX3Zxta5wTs5bQsve+/e7k4AsS95oJUl26iS8R2tlgSzU/zrC6hCAeXYdHxolI
 c0z/ijpvW9gupG17sLXfMCkNCKD43VZ1cKPAjh+h0ZEHAcPsWUHC2F7M5FoWV1CcPl62
 uKppANRAO5Xnd+HMXSajyXe0iIAuLmWoQuLg5CnJBcIGy6mjiu9ZJRTT10a68zyGjZ6V
 F8i/dz9ZIKPx4lNoYKLYdw9x3BgQog8DfSpVZjoJgBHrBFsKn0if12z22mXEYnlW2HiP qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y4c8r68p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 21:59:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GK9b6v018175;
	Thu, 16 May 2024 21:59:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4h2kk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 21:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUSW9rNXWxVinq9WvI8BPG7p9E8W3Sduq3N3tVUSRJA653H+gHNpLbgROVBxGRlV60QVYYsz6usYR8QksGLkNvB7goW4TE0Cqig16yaGn5vLOyZE5st93T6f6ZhHDHYH1pJs6ZaWR15/EW6yRS2623JVQ90bIY/5vc8ZQKg/lXlC79gUbSfxlKVmrk792dCXA8QWv8D4345siNFDgllU/1KrXmfOYnMGO6/7t8z5n7WrYa6jRW/uuozHBGAvMVVXrbNVdyyGuLV4URg0cwI1orv6sOgY6S5mbDOLiE2eGZDi3FNCwPr0Q2MMGdCDp6EPprrFs5hUT8F4bOvXba/eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sco2Wpsp9CYSL/1rLsNixZjtCT5FFqCWqOv+6NpE+es=;
 b=gCpm6Ed0a9uAN0dOxu8VesyiTtJQ/fUr5UiKsxpwUDrKvvbLGffBcyfGROD/O3A31nCrhTcktccWJXeoxgzK1hz62072yXs3C8ytcL7eF2itfjrlMH8+OnoMRGK1UcGPIOwLZ9a6kP1fensbEzKhvGjgI8quEvTjB7sLTMm8Su8RfgXFuBtH2LpDITqKZ958O/hNnG7DVociiHrM3Qj/M8hJSnjTlv+GnTt5vHFOS4X/0nPmWS0fuYa+W4hqly2Fk+i7yYjdegEGz9tfj5LtP0FpRmGziP/quph0CRA/Y9fUEdMK0IfB7UrSBgoYLiu5A5LDil2DOnPbMhOh98fDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sco2Wpsp9CYSL/1rLsNixZjtCT5FFqCWqOv+6NpE+es=;
 b=Q4U5jeshT3mLsGuH7SepUWpWHq0sQLQoaNe6GZZrBU0pZh3dEfzquVUjBcvsXBwo1ZJt3yRJzmrkwXEWBKb6Yv0j049t2WHT2qc/9fZr1d3U2mXKhCfmQ0XdWazQiakNaU+j2/DYR4OWEXeySrlS3J9rRZzrZ5M/jOqKCtdH+gU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 21:59:28 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 21:59:28 +0000
Message-ID: <c52a87c6-048b-497a-aa1e-bb3efbf2147c@oracle.com>
Date: Thu, 16 May 2024 14:59:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: Drop node_alloc_noretry from
 alloc_fresh_hugetlb_folio
To: Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
References: <20240516081035.5651-1-osalvador@suse.de>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20240516081035.5651-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 933334b8-7a88-4850-d6d9-08dc75f37517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aXh3TUdQbnlKSkk0RXRhdG1WY29jUEk4aFhQVmttS1lwZFgyK2FWNm8xZWFv?=
 =?utf-8?B?NExpL0pHY3cySkl5cy8wTWtVb1RqQW1icTArdjErUFd1U0c0a3drUXorYVJJ?=
 =?utf-8?B?cWRDNjdpLysxbERqNndWNDVzUXlIVWtlcHorbVNoRE52UDNZbGFvazZUUXR4?=
 =?utf-8?B?a1pISjVEWlFxc0s1N2R6K0VFcFo3Mm9NUDlVNXhtelFVZGxPTHBSbGRsK0x0?=
 =?utf-8?B?Z0RJSE54UlVLUHlFcGVjTE1GaGxqWUF1Y3NCek5IMkhxa3F2cGQyY1pPV1dm?=
 =?utf-8?B?czAweEkxZmN1VVg2OE9Sc3BsWHlRQ1I4dzExVW5IOExvc2NwTmNFcnE2eFNN?=
 =?utf-8?B?emdmM0xmdTNyUTV4Y2tFSFVDSVI2VjJkSUdDSWE3NnJuOW1DMHNWZ2lETGhk?=
 =?utf-8?B?MDdwYk9yRFFoQ3UvakxlQjRQajVtTnphSDI1TEwwWitST3NPNjBTSHJQY1pr?=
 =?utf-8?B?WXhNcXAxaHpsN2JsaGxUSHlZcWNWZnVPYVhKTmxyNjhxT2NvT2JIYXNUQjBZ?=
 =?utf-8?B?YmdwRlFBTWUrUS9XWm5qVnBzSlhtNHc1bHlCQk80ODNtM0M3U0xDWGZIbEQw?=
 =?utf-8?B?NW9RdEc2eEo2R3EzNDdRellYNnpxdVNmL21GME5uTms0QUtEa0ZuRUw1OEFV?=
 =?utf-8?B?cWV2VTd2TWdEclNlNVNpajBCa01kNEhzT25Zdm1ya25rWGhzZkxleCtpZjNG?=
 =?utf-8?B?TUcyVzdObW94Q1c5dHFZUlc5OEVaYjFwT0RrQ0RUbnlSNlJ2bkM0aHV3M0x5?=
 =?utf-8?B?SXVIM1ZNMEtrYWQrNHVJTGk0amt5TkRrT3RKMEsrWUxySzU5dytpS1Q0ZDJr?=
 =?utf-8?B?Tk9waVBWQ2J0VGRUa0pVU294K3RNdVM1c2JVVHFhQ2dPRmhHckdyQU81bXdk?=
 =?utf-8?B?RjBuYnNqaHhjZCtDaW1aSklxVDJJZkIvSE9ETHZ3Y0dqZXhCUlYwTVV4bWcx?=
 =?utf-8?B?MlRzZWRKR1ZVMVRmbnpUWmltV3FxNlo3VGU3cXEycWgwbnpNQ3UzNXdZUCtF?=
 =?utf-8?B?YVdVWTdTdnY1d1ZkTDJXRVdsQ0hGU2VpbUlWcE5OdFdnZG5uaDY2T0hVb0ZN?=
 =?utf-8?B?R0tIcFdOT1pQNUZFdHlQQzdMMVBuS1hBQnhBeUpvamxxRHZ1L2N3RUxvd1Bp?=
 =?utf-8?B?QWJyZnJFQ1V5bmF6MGhyRXU4WERIbi9SekplK1VUeG1UUHFxMUhZTVlkMG9R?=
 =?utf-8?B?eUdqVFFNbVZoYUhYcnBHc29QME1LSEtnTEVmbStkU2VneEozM2QyRXpxQTNw?=
 =?utf-8?B?ODBYYTlVdCs0UXgvQ042dWQ5Qmhncm1mbHgzcjlHK2hZaks1clM1TEk5bEp5?=
 =?utf-8?B?Vnp0R2x6SUl6czB5ZHVGUFpJY2dVT2NWZ1NqS24wRzdBUGdPYVFVUlZHdGt1?=
 =?utf-8?B?U0huRFVYM0s0ZlhWU2JwRFIrS0swd3g1Q0ZiS2w2OGljdFNNVUJyU1ZhRkFM?=
 =?utf-8?B?dzRuWUlFOVJpcjNJdGhwNHd6KzYwL2locnIydDlneDJHbFRQUGdtWHE2VEZq?=
 =?utf-8?B?dThFNW1vUVNpU25COSt5cFB0TWVwNEtlU3JnbTZXOEhwdVFVcy9XR0NZTTdh?=
 =?utf-8?B?enh3VEcyeDdRaUVaVEhWUXdUQmZWaHo5bVdVZzc5WDlXeU42ZW1haGxoUWgz?=
 =?utf-8?B?Z0R3SmxQVUhISk8ybGxZN2xKYmVxbzlOQU1ra21YWWJLVFlmNzBPM3lFSENv?=
 =?utf-8?B?VDFRRVZTM0pRcW9rRnJKQTlvbXhCWTMwNXlXclM2MGNMRDNPVTFyZHlBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3ZjaEY1RTdWM0NkU1hjL2dCMG5YN3NGc3k2MjR3cko5RFNhK3dKa2xocUpZ?=
 =?utf-8?B?Vkl4SGl6MmlsbFJnNmZ4T05laTc5TU96VkJvek10QnhIREg2YlZsNHdwSThu?=
 =?utf-8?B?Zld0YVVVZk1aR3FGWU1IVEJtQTBIRzFGemJaVUoxRVpWL0p0VGdJSVpudkN4?=
 =?utf-8?B?WStZSVQxMThTenVZai9PWXNPSzlTanRPNEpPNFprQWJyd1NDSjRMQklLNm9M?=
 =?utf-8?B?STRuZXlTaVM3TC9lakdQWXYyV0phV1UwRFZrc2RDbzEyV3djSXE5eUgxbzly?=
 =?utf-8?B?NmRzTEhPeFEybVBUK3c2SWZSZUxyekpXWjJjenRMcndrM1QvR0VjeFVmWWpD?=
 =?utf-8?B?S2FuOUoySTJCZ0xYeG1mTWd1T2w0MFI3YUZaa0RJZXdueU5KVmpPMi96SFRt?=
 =?utf-8?B?UWVkMERINFF2MnlZOWVPYTBWRkNnbjJJYUs0aFgwTEY3cTFQUlBUKzdxdC9S?=
 =?utf-8?B?UG9yR2hObnExb0MxYWV4Tm5xWllZWFczS3BrQlIySkhjc01kbWhROVRZRVIv?=
 =?utf-8?B?NitNSXJSZFMvNnZ1b2tBU0JDWVRsZmtwOW1IdUJ4Q0pMUWR4Z3BUa1R1bFYr?=
 =?utf-8?B?MDJPT2JnODUrN24vWlBwdStIL3hNSlovSEh6STBnT29TN1N3YWdGbGhHT1Jx?=
 =?utf-8?B?QmZmMFVGUGtQZ2lBcUx4NHVYQ2xBUVFGc0NURDNYdU51clgyRE9PNWN6ZlF0?=
 =?utf-8?B?bE4xbFk3b0NxaElFTVpwSUtPWlFBamZqYlUyZ0RWVXNsT1EzeEtJbTJSWWVK?=
 =?utf-8?B?VTZOMEp1NUVPZm9NcUFiK3p0ZHc3TFBILzN4T3J1OE9Dc2JtMks2U3JXTHIz?=
 =?utf-8?B?N2MyVXU2b0V6c3gzV1hzM2R0RFd0UHBoVFRSUVNVQ2ExMmNraG0rV0VMbHU5?=
 =?utf-8?B?U1RGVkV2NGlyOC80czNUaDRucmxTSnpzQ2x5bCs2bDdjVzExR2lNRTlOeHdS?=
 =?utf-8?B?K05KTUFjc2NFN1BZV20vYWlyRFk1STNySkQzQm1QRGZYRTg4QmxDaFFrS3NW?=
 =?utf-8?B?UTloUEIxS0tKd2Y4a25mOGd5T1RpMktLU3ZpN1I0Q3l1ZFdPY3RJcnEyUW1t?=
 =?utf-8?B?QksrSjRFTU9qNDlxSmk4NCtFQ3ptWXZUMVdRdWt5Vk50RTdYMTZ6OUp2cWZl?=
 =?utf-8?B?cEpHSzdvNmozNmg2Sm9kRjdsT2t3Z0svVmtWazRLbmVwN2ZCa2FyeDNrTmJL?=
 =?utf-8?B?QXA2RFk3cTZvZnpOWjQ0SWVEd3JQVTM3K3FickpEVXhSRGxxRHcydDRNcENJ?=
 =?utf-8?B?WFhUUCtYcGJIYzR1L1orREloQ25JVGIvTmlZbDJ6b2ZIZEphcUg3Y3BleWVh?=
 =?utf-8?B?SUJ2L29MSUs0QTllSDI5d2tDMGs5Smd1aExHQW5yQjFYbzlzTHFEWHphcEQ4?=
 =?utf-8?B?TTIyTzhGR1BOb04vUXUwWkdEcHZFOTI1MDNQVE8vdTNpWElBVno3cWNxM1dP?=
 =?utf-8?B?ZEp6UXNGTXNQT0xxaWQrNjZHNE8xVU8zVlF5YnB6d2REVC93K1hHczVwZTZ0?=
 =?utf-8?B?b3ViR0pNdnRtbzIySHNNTTFoNExqRlN4d2NqcDhVcWRBaHFoQlZwc2x2dHNW?=
 =?utf-8?B?dWJWcVdhaXFzMUE5TGtZSW1VZFdwYTFDbzFPRGVxRHptQ3dPUy9XZHAzWHVY?=
 =?utf-8?B?LzhTQUUzWjArOFZVdnlIOU1qVFJHWWZxYkxTd1FvUXBGejVnMHl1Yjl2dUo3?=
 =?utf-8?B?L21hVEM2L2xHRWVLV2hkL0Rsb0dzKzQ3dXVqVWNWTVZnaTlwVk1nblJxNGdn?=
 =?utf-8?B?ckhkaUlsVmszRXZld1dWWmp6YUNsUFVyOWs4Z05TTDBNWG1LV25ZVUJWZGx6?=
 =?utf-8?B?eWtvZGpFTDlUa3ZGYXlVeERuRDRQMktvdk10Tmp5d1I2cWlOWXlvODBJcHJq?=
 =?utf-8?B?QkVDYjNGaHFYYk4zclNtb1YxVlpGTDY2WE0yQTdCVDNTcmh4L2MzMjBhcXJF?=
 =?utf-8?B?RWl3KzhXVGo1bGRrT3V6N2ZKVHlTSUZSVDFsYzZzUVM2VmE0bW52ZXZ3WTFY?=
 =?utf-8?B?Y21IUDlKSko4ZEgybkJQUWxsUjlyQ0xsTGp4cThieGo1YnlDZEl0U09DL0NU?=
 =?utf-8?B?MlpldFZPL0NzdEVENEJ0MDY5MVl2U0prMVhadExnSjVBN3RkaEsvUnhmUVdD?=
 =?utf-8?B?OGdyQVZEekhKZ3d1UnMyRnNVc1RabHJYTkhCNmZyVkpuTHdvL0FzTnd4VHph?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i/MQveUek5Q3LRpkfk32Pigq/nGH/AFoZhaPAP0eDwdPFuYKnJquNCFIpdPOZVSmBH53VR7iuXKrTwBU/izam27XuoXc3NKnxEd+FwPx/DIwMIhJy2xN0QRHmYDl7hFrIW9SstKltTN4xl/yN4IHo6dyRpLjTzHGEXiD6XEJWjzcRpa9KJDw7NcF94OApefdORVBjfvgyb/fw78FBE3vGJ+5+CNyd2oSs0DEHq0sMka3XiTAjqJcPhviCJsx39KqZeK2nK4fGezkCVr0AIOY2tpc+PuOa7c0JMFiumRHk+vTZ4Ygicm0znYJVCbvS43CNreBju8H1Vp2Ywb36uaDJCCP+tI7O4nTFhe7OHZYlrXSHqRyz8HtyIbj9m/iQ5g4Zvtc5lpkYQyty+UXTvwS2aIBb0ipA3nnGlUe41xR3+8MybBTPDPWpDQstE43s82oz0k1Jgjec4PFcGFnEsf9xVOyT4hrW+WavHwcDayUgVY6X39sR3s8jM6zHMrls2yRv8Lw7fJ2uwRYL3Xn+9S3UTaTxUWieJu6ekh1It0XCSHZmxsHL7tjXo1EFsU1kNwz6FHmri5GPzoq35mxiGtFsYfNc78fMmRABDZJhBfZR70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933334b8-7a88-4850-d6d9-08dc75f37517
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 21:59:28.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNIJWWRQVkl1FhvJBFNEb0supz7kleCudNGAXY7hkb3W8s8KsXOogjenXphUdJsmaZMGOnUZsHeYgfRJAFQQM7IGZU/U85mJ9Qam362EXoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160162
X-Proofpoint-ORIG-GUID: twspQ7SmGi4NjzdFjMtyr8RhHYjBJeij
X-Proofpoint-GUID: twspQ7SmGi4NjzdFjMtyr8RhHYjBJeij

On 5/16/24 1:10 AM, Oscar Salvador wrote:
> Since commit d67e32f26713 ("hugetlb: restructure pool allocations"),
> the parameter node_alloc_noretry from alloc_fresh_hugetlb_folio()
> is not used, so drop it.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/hugetlb.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6be78e7d4f6e..fedce00ff839 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2289,13 +2289,11 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
>    * pages is zero.
>    */
>   static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
> -		gfp_t gfp_mask, int nid, nodemask_t *nmask,
> -		nodemask_t *node_alloc_noretry)
> +		gfp_t gfp_mask, int nid, nodemask_t *nmask)
>   {
>   	struct folio *folio;
>   
> -	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
> -						node_alloc_noretry);
> +	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
>   	if (!folio)
>   		return NULL;
>   
> @@ -2513,7 +2511,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>   		goto out_unlock;
>   	spin_unlock_irq(&hugetlb_lock);
>   
> -	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
> +	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
>   	if (!folio)
>   		return NULL;
>   
> @@ -2549,7 +2547,7 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
>   	if (hstate_is_gigantic(h))
>   		return NULL;
>   
> -	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
> +	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
>   	if (!folio)
>   		return NULL;
>   
> @@ -3474,7 +3472,7 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>   			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>   
>   			folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
> -					&node_states[N_MEMORY], NULL);
> +					&node_states[N_MEMORY]);
>   			if (!folio)
>   				break;
>   			free_huge_folio(folio); /* free it into the hugepage allocator */

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

