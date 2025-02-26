Return-Path: <linux-kernel+bounces-534745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BDBA46AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9BB3AC24C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571A23716E;
	Wed, 26 Feb 2025 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CbuPO2lH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NwtBcFsl"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F521E096
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596930; cv=fail; b=s129IFGnIEGo6ST3JBpLDcc7HKc1zne1AuexnHql1zVahE2+Hsp7g79bN0dU/3mWcoev8UF3TydI4SerjSAHPPK7xySF4fJGpc5rqO4wtNStrPOexlJX2teTk59YKsjLG8/hUwn93e2GfxC2rQBH9beqCznMuooMNmD3jQaZpQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596930; c=relaxed/simple;
	bh=mdIiWG7cSD1WskNCbQnctLRWGtoe3AR2/j4n9zag6OE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i3oG21VTPEcw8DA3lS2z7/P9Mp/XD636HzMtpUaJKVHP3rhMc5fNjEIdSlH0+pxIjXw0NqCRTNGfvPuEZdaZhcYjS/kg4AbxGOdmf8jGSZLFcnYm2UImVJKCwiiKLpFzkGCufykuYz3+is6bmXUfuQMnRtw70mWZl94loh0AP9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CbuPO2lH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NwtBcFsl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QHtgJS019292;
	Wed, 26 Feb 2025 19:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nlTgKuDa5xv1oLGWn7UJZkkY/fpn+nOHs35T8YxF9r0=; b=
	CbuPO2lHsvmrHhL9WQCFrlSKh+BF8Dqty+hoigxosE9C1VhAELHgND74F7nQCUva
	aHmdZ47QhR0dLkMK8tfeXw2xCBmGQSjJeRBfd5HHPMp8ilYhjlEfcpPjf4fRqOvg
	IbmhOZAKClfiBkVOsjEFJaV2/wcUVmYwui5oPeycR3On5EWJSTW6Ommd2IFxuaFm
	20xF0NUxY6tt+wsxs0MhSbX/wpb0Kv0tuIVSov1b79WxMkxqbVjnI9x/hO4AVD+B
	VYpxRO5I16+QKytXG/kJ2jGjkO23+FB4IpwHYkladidYe9slcAtmgSYsyOoJ6yWf
	R7fm8nRJjQe2mwZQxOmyGw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfsurh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 19:08:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJ0Ygg010256;
	Wed, 26 Feb 2025 19:08:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51au5cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 19:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xa5d+p6AKDyekFPakHYnn9prP/okXXDgbJPSy47dx535ql6NWEs5r+qlTcZ+/VpExkiarid+BFEDj8rDEJIGwIFyFo82Dd7HiV6B2oqQfhd6K2YryHCacHGznSFsA5V9KKNr+xDPHYiZqz0odmYwjTGPnCEoxYGlNf/dV+kj6ejBBD6Z+B0QyNv9Mv3ys/FI/UWHbT4jcCm5xTMybzGzdUJDMzkwzOTB4Ui+le2fVSvLKRND1M4my1w3CK0E7VYsLeIvepo8DQRgWCdT+sGDOVC9WTW3lHX49Opj3VO8mkVkP4e274du2ar3HxbY4VMOpETAu27+gQ/UPlRVX2SKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlTgKuDa5xv1oLGWn7UJZkkY/fpn+nOHs35T8YxF9r0=;
 b=DmN0fKEd+3R9invryEU548efS03EOh0/fRblJYtGBW+Hl+3KpIX9jo4Ai869J2NHRq4FDL3QZr2PbOljbd/WtW6BwbvqtYHCv6+vrrJdknsNfjIb3w4Jpg4NVxuBfxMzTGK6xCb6kVKeEN0oGBbGV9t8VWzj3dk7iQx8LEP1tBg7Xfz3JS+3J9d2w9OGbbJsGpcLufkq0YsM65yU2J/Eh6aSIM9c0Rcqjx1wEo6HcoF5sgWKfHx192q0GHZ+2BAy6LBKG2aCKa8nAjdIxPadcIr30HbT+KysF3zwugPQDtEnUFSN/4SM5L+U9KG1MuZ2oPE21CuBnQytz8VPyl3LSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlTgKuDa5xv1oLGWn7UJZkkY/fpn+nOHs35T8YxF9r0=;
 b=NwtBcFsl5rGG7KNWeOUiGVqHEPginKqZ1NLge9FEVyYDbzmxo3U+R6xa2tcYeEix/HCg4NC1W33fk9LKBt6qSvpVhNge2xJfPcVs1JWXPr044FuHZzn7cHk8mAji7nhaqefzJlxQ+8PAjV2kZLk3KwUAMxXMRWUWZA+wgwpIdZ0=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by SA1PR10MB6295.namprd10.prod.outlook.com (2603:10b6:806:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 19:08:18 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:08:18 +0000
Message-ID: <be189a58-9cd2-4c1c-af9f-ffe219c1b58e@oracle.com>
Date: Wed, 26 Feb 2025 11:08:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: make page_mapped_in_vma() hugetlb walk aware
To: David Hildenbrand <david@redhat.com>, willy@infradead.org,
        peterx@redhat.com, akpm@linux-foundation.org, linmiaohe@huawei.com,
        kirill.shutemov@linux.intel.com, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20250224211445.2663312-1-jane.chu@oracle.com>
 <0e825585-3421-4fa9-8912-41b936f29fae@redhat.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <0e825585-3421-4fa9-8912-41b936f29fae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:408:f4::13) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|SA1PR10MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 663895e2-9327-4bb8-6b65-08dd5698ede8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDBYcXpWUjdjZTBMNkJoL3B4dTZWTFd5RTNrVHdRT0FMYlZMc2hiZkw1YWRj?=
 =?utf-8?B?Mkh5c1dTSEQ4ZFk1aEVhczJ0WVgrb09FelhTTm1VVGp4VGhuT2liUk5PcFEx?=
 =?utf-8?B?OXBQQ0x0UytwZ2ZhM2kyNFB6Y05wck9rUVZKTkhqSnBhd1N4R1RzdUwwVXpE?=
 =?utf-8?B?b1QvcEdYYnZZTHdzR0lrb0w5aEVWR0tNaUVjOVFSL2xRY2lJUzkvMXZuY0Y4?=
 =?utf-8?B?NDhUd2hSanRZV0lFWVVJUkYrUmEyc0V3MCtrTVBOYmFETElTNFpUVXA5QnB6?=
 =?utf-8?B?ODJvSDVHRHhXVmVtOW41ajNPSzBDWElOaVdoMXlGUHFnK1hzUEJBTlVLekdl?=
 =?utf-8?B?bGw2OXkwRWZIK2lhaGVQaUdjNnp6SmFKMWsvK0lzT1dPMHNwUldJQUlXN0Ev?=
 =?utf-8?B?OWVEbEZqYWVnOG43Z2FDRzdoMTFSeFlEYjZYM3ptcVBldXlDZHRjajMwdTVP?=
 =?utf-8?B?bVBzM0M1WmlNRDJOWll2RGhaUnJRRWJETjV5cDZIZTBUNEh1Wk8rejRZRExI?=
 =?utf-8?B?b1NZUG1nd0ZoOVR5S3dvWU5OeHBBODBINlQvYTBIUGRjL2R1NDR6aHhYVmJK?=
 =?utf-8?B?ejlscWRndS96bGtYa0pjRGlxOGxwNFBTMFUwY1pLRFRtbUhTTm5GWllwb1NQ?=
 =?utf-8?B?U1Rvb0hKV2VZR3c5dDBtR0l2OVZ3MmZualY1T1U1TDFaeWtiRFplcVF4K2p4?=
 =?utf-8?B?bWg5N3JCYmdUTXloNktuQmthOXQzU0p6UUo0R01uYTBxM3RRODAvaWYwYkFS?=
 =?utf-8?B?alJISTJoSjQyUWwzZ0lHbVJMbG0wS3FwSEM2bjdheXRQOHdqL2dCRkRKQ1po?=
 =?utf-8?B?anRQKzgvY2Rld0gwMUxCWXU0OTg1ZFdHUnJrQXFNbU1SQ2V4azk0K0lkc1Br?=
 =?utf-8?B?QUJwOGVXL1RZcUZ5N1FuZHdzT0EydTRYQ1Z3TjlKSlNiaXlNTDJ0WXNmbnBI?=
 =?utf-8?B?bkxKeTF6Rm4wK3FubVVKUGZnU2t0Y1NJRlFDbkFMaGN3TitnUFdkc2NCZ1VX?=
 =?utf-8?B?WmJwaWowbHRYWUtVNFZOWUFnK0V0eEVBYTc4QkswZC82QTRBbGVsUEpwTlI2?=
 =?utf-8?B?V253NDlJNXgwRUlZOXVJMVdJU3NTRmZWUUJTT0l5QVF4TGdpKzY5dzRmckpZ?=
 =?utf-8?B?TkxycHhSSmlCWXdnbElNWFRZdEhsVGpQOHdQQy9mTjhnL2NLL1JpUTlmemV1?=
 =?utf-8?B?T1lXeXU0cGk4WHBBcVYzMnFyS3JpOFdYYjFRV2k3OTRRV0VqS2lGUGJvcExx?=
 =?utf-8?B?WnVzc1lhakthU2txdU1RVzJIVnF5VFBRSEp5TjZid2ZNVUo0YlloZnFvL2pR?=
 =?utf-8?B?djRkeE10RjlMTjRlVDRYL3h5R3U3WnMzZEdnR3hjb3ZzcFE4SjJkUFhRMlZC?=
 =?utf-8?B?cWo4NzAwbENXTkM2QkN3Z05tREwrQnU0eWZjQ2twT29Oa3A5Nmp6MWp6RHpT?=
 =?utf-8?B?NXVFYjg5OXcweU5NYXZTY2VVWkg5c0ppTGNjSVdac3krc2ZXUnAxcGdXR1A0?=
 =?utf-8?B?cXgrdWhWTnI2ZnhkUDRPQy84eE5KTUJZMUwwMWNEOWRTOEwycXpxMVE4aDVG?=
 =?utf-8?B?N04xMXlMdWt2djVHOE53T2NqRSsveXdaZUNKVjFOSElWQmV0VHRORFIyWG5D?=
 =?utf-8?B?My8vZFUwZW9hRTNoR3NQZU56amtXSnUzeWRuRkx3UVc2ZXIzNU5JeTV2STFQ?=
 =?utf-8?B?TzB4Q0gyMVNud2hEMTh3bk5DUStUNXBzbnZQSnV0VWhwRnc5V1VaZlFGazI0?=
 =?utf-8?B?ZUs4OThnY1FPMGFOYktUUEVsL1ZaZ295L0xWakZhSlNFd0N5QzB3dlhmb0cv?=
 =?utf-8?B?RGNreXdIMkw4SmtVNEVQSlB3aXlDY0RpNUwrVlVvM2k4aFVPQVYwdzAvU3pI?=
 =?utf-8?Q?FQBWmovH8JGHv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHY1WWo4VWkyaFhESzBsUUE5cmJWSVVCZVkzOVBJcVRiVzgyS0Vtd1FSOCs1?=
 =?utf-8?B?WktMTmVXUzN1Z2RpakhoMnVVMC9KRjVDV1ZCbUtFMElrNEwycjFDTFhPaGcv?=
 =?utf-8?B?NUVTcHo0bmNCR3UyRUtiQ3d5Tmx2QTBPU2RNYzd4eDlVSEg2Zkd2UjlOT0dJ?=
 =?utf-8?B?bFJnVUx1L1FQTktrNC9odG9hT3YrbE9YWVY2N2FIeExlYWwwQUZFeXMxM3dy?=
 =?utf-8?B?NEhuVUsyenFTOWw1OUVWM2NaWEZja3ptQzBlVnpiTnlSSTFJclNnRGNHeUs2?=
 =?utf-8?B?UnZHZlA3QUsrS1NPaWNiU2FjdUx4ZlptMEI2ckpHTnJpWnZTSTZjWFpUaDY0?=
 =?utf-8?B?ajQxUlBaU2Z0L2tWa003Q21EOFFjQXAwSEJZQ0VZbUJHUXFwbG0zY01IMkR3?=
 =?utf-8?B?bnBlSDJ4N3pzdCtDcVhCRlhucHJQKzRnK2cxVTFZMnhtSmpqRXM3ZS9Gb0xs?=
 =?utf-8?B?c0JRUXlvZWs1a3VJamhxUTdySDg3ZUJsRlVGVWpCRVRSbktENGhha3FUd1o5?=
 =?utf-8?B?TG1xMHB2OEh3YVpPOVVmOGRhSHRRL0xLa3B5WmpwWU42Yk9Pcm1YQkl5djd3?=
 =?utf-8?B?b0pneEkrd08yQVAyQU9JSU80MGd3SURmeS9NVjZOamt1Y2VaUTZLMUI0YVBs?=
 =?utf-8?B?ZnhIOFliajFMVUVmM1JNVHV0V01NZEJUcVNBd3JGcHl0ei85Mkw0TXFPWWxR?=
 =?utf-8?B?ellxSWRhdXhTTExmbmQrQzM5UG10c0VQNG5nU3gzSFM1M2c0VkMvd3RlN3l2?=
 =?utf-8?B?UWlpaVFsdGJPLzZueE9tbWpvZmNtT1p1aTN0SUlCUGFEamd2dzVOdGhHVGhW?=
 =?utf-8?B?b0UreHRoQXVHMkpsejdFQy82TG00RStXNml6THNmN2tEdW9qTkhrdmJscnhK?=
 =?utf-8?B?WXJqMVowanFueVlrbmk1ZEw1bGwwcW4yd3lFelF1VHlSSW42Vjh3TkpCVHlO?=
 =?utf-8?B?YmlOT0IzQ2NJNHN0STkwQmV0MlRiK0VOd0pKaHRQWWpyMmkvYVpJMk9XZWgz?=
 =?utf-8?B?K1BjaEgwTlp0Q0Y1V0NSR0dqMnBiQUZiVEhoaEplTmtVN2JSNnJhRHgvY3pG?=
 =?utf-8?B?NWNuTjlKc3FvOFYzUlNOM2lQdkxoSERxSUI2K2pFdnpiRVVPcnorNXdUckhR?=
 =?utf-8?B?TDJjeUYycElTUHhJS1lqZmNORDd4Ui9YZXhva0VJV3Q1Ly9BR2VpbHBETm5Y?=
 =?utf-8?B?S2QvNU80TFFHTnMveGg0T21tUFRzb3lhTlQxa21kZjYrbFZ2bFpWS2ZBdGhp?=
 =?utf-8?B?eWk4UTF1N0NyTjJDdnlMOWpvMHZiYTFXNmpFOVBRV3VCVnRVbnBaQm4rdEFP?=
 =?utf-8?B?OU9ocm4rMW9hNGg3cGN4RnBhMkVrTHRCb2xiTHk3eTBNc21wZnhzeU9NVjlC?=
 =?utf-8?B?Y1dqaHhxUktpck11NDJNcjNnU2srOHk4bSt1K2NDNU92K3M5dDJ2Ri9SWW85?=
 =?utf-8?B?VXlscTBDZG8wZkR4eGx6QkM2TC81VTZ0d2VTZ1B5NEFraWtsN0hRUDhQN3V1?=
 =?utf-8?B?cllETnlXT0tHa05VOVMxOVNldGtIdGJwVHB2SlZmeU5WYk92SXp1SjFzYUpk?=
 =?utf-8?B?QVNlcjBSaG1sT29nelR5d25PL0JVUkpWU1dNSDZpUVVtZlYwVTlROVo0WXI2?=
 =?utf-8?B?d09QZkdQRkhwQWVweGEyVzZYNnBVS1R6cTlYcFZKNlc2QjdQNXlERTNRTm9N?=
 =?utf-8?B?VEN1SXNYKzhjQVQ0dHZGaHlmQnNHQURPbW93VzdUVDloRC9IUXdkbWdpZE1U?=
 =?utf-8?B?eXRRdUtlVW1LbG1pZzNPTFg4YThKRnBjMm1ZZ3JqU08wT0NPQlo1QTNwV202?=
 =?utf-8?B?MkxDeUJTY2tER0QrdHJQd09qZDltamJxNFRtYWUrT1VzcTVKYTRXNW05QTM0?=
 =?utf-8?B?RUp1T0pjR05GR095OTJEc0gvRlo2andJa1lHRGsxaExEcmV3WDliT08xMjRW?=
 =?utf-8?B?a204cVVvcG43akY0RXRBUHZ2RWNBb2tsWlJuNTRxb3pPTzRhZjk2N01LcDRs?=
 =?utf-8?B?THhsclpRaFNKV05hSDY5MXdVclR1M0Z3U0I2MmhDM280T2F4T1RLclFYUHp6?=
 =?utf-8?B?SEkxcHRLZGQ4M1hwUVRValZGQ3ByeDVJSmt4dERuRmh3dDQrOCtuR1VJOFly?=
 =?utf-8?Q?Jk1ZHLt2yNTeTCJbYPZlq7WJV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v+gNyyfROBsX742sSNW3LZm3vlN1Nvq73+uUDNbvA9R0Un94wwhvucl2KuG/ZzJzA/PAt/wQwDHds4pehqmbanKc+E+R9ndvXy/4dF6b80z1wR1l4subPbeiNqRLgVhGC88/ThYscFY8jT2R6ywBcWmlpGi0htY+5Eabh7NzNXTlWH6tAK4CUc49foqPsKzCM48z5CCgYBNVX+qEuqUw4+RQTZ7T4KzOiFd2F0fnbs9HSd9KTXFKJQbZ9MREGm8gpbpENj3ulJs/JiIvp5mmV0uu4As6pP3XhHkOOQPuQsMSfGyUjgn5zh8DkpuL8+RwB9toKJaMXmiIcgEWfWfyChfpoyJm3bI94zRllO/K3VVyWZ8mkusQ8a/UG9g2xC/wY3Iuvqvs14WqDv0DdtqMt6rdVF00hOYMQrcvA3toCTbgtdY1FH5TDcuHp5mUltMY0gERAzYa+QV81+zKlw2F4OJ2iMOv5ZFC2QyBriCKDiBR9u11BpPQnuWYM6n1AYdn8sNSJewxwwu8FVuzy0artF0omw1FH0GZ5dSc1G3q0E3ExCHRFJPH2g31gRekiAI4vmxqnQezN8hsJnLmHP3BAL2h2TTdNaDzvzlfNz8NCPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663895e2-9327-4bb8-6b65-08dd5698ede8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:08:18.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KefiK/clWsj8BKGYYGFwBx2ohKQtLYQrfHWps9wAQE5hG+e0dNlbTqU2rDgc8DomnnHlsfdIt8W4x7YV/rYDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260150
X-Proofpoint-ORIG-GUID: _Fq7rRHxrK1wLIGMVsZQ5BtWCzmVpkaO
X-Proofpoint-GUID: _Fq7rRHxrK1wLIGMVsZQ5BtWCzmVpkaO


On 2/26/2025 7:49 AM, David Hildenbrand wrote:
> On 24.02.25 22:14, Jane Chu wrote:
>> When a process consumes a UE in a page, the memory failure handler
>> attempts to collect information for a potential SIGBUS.
>> If the page is an anonymous page, page_mapped_in_vma(page, vma) is
>> invoked in order to
>>    1. retrieve the vaddr from the process' address space,
>>    2. verify that the vaddr is indeed mapped to the poisoned page,
>> where 'page' is the precise small page with UE.
>>
>> It's been observed that when injecting poison to a non-head subpage
>> of an anonymous hugetlb page, no SIGBUS show up; while injecting to
>> the head page produces a SIGBUS. The casue is that, though 
>> hugetlb_walk()
>> returns a valid pmd entry (on x86), but check_pte() detects mismatch
>> between the head page per the pmd and the input subpage. Thus the vaddr
>> is considered not mapped to the subpage and the process is not collected
>> for SIGBUS purpose.  This is the calling stack
>>        collect_procs_anon
>>          page_mapped_in_vma
>>            page_vma_mapped_walk
>>              hugetlb_walk
>>                huge_pte_lock
>>                  check_pte
>>
>
> Why can't we require callers to never pass in subpages of hugetlb 
> pages, and sanity check that this is the case?

Because for memory-failure handling, we want to pin point to the exact 
small page even if the small page is part of a huge page, so that if 
userspace could manage to recover, they don't have to recover the clean 
subpages.  Please refer to 376907f3a0b34 ("mm/memory-failure: pass the 
folio and the page to collect_procs()") for the change.

thanks,

-jane

>
>

