Return-Path: <linux-kernel+bounces-363954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0974499C8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C683729172D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD5119D09E;
	Mon, 14 Oct 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fVCPOWWL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oxR5GVB9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C919ABC5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905458; cv=fail; b=OzufzT0+UW8Rjd3LEtTcqJAJ1u2cf456EL+DTXdKFYJSRVtAMIpclnST62+kD4IaFXFowDRcFYg81spjJm1QMAyxtR9Mv+OIPJwypMTCC3VkhBOanjrPv7ZgO3s3bPUfwesBLv04rq+VzS0gOEbm3UzlTvfWHH3O4OVet6+lg6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905458; c=relaxed/simple;
	bh=j3Kg7pVYUgfV7PVtkmUO4Hz+g+js4a87GvrOqrtB4pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oU8lI0aJMR22pQcTlJlIjkbnrjFc2oVnbm7uAnVcNBWIgh4IpORI7a4//FXPZgSYE53wKZaufS/zo35oWVmUNnDfaJNoG8IppZyg+w36YiHiq1PPFZLH/snmUmdxjQLn5H3e8/5J9aWIq1W7VDs/vPUFbKr5fXD+qirXX96DHWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fVCPOWWL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oxR5GVB9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9u2Vu014510;
	Mon, 14 Oct 2024 11:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=scR/glwjqXmm1Ui7o+WL4w10pa6Lu0JfVTUSGQthudM=; b=
	fVCPOWWL+zOK5UVlsUJEr2IxQuUla6a7N8SQiBCjuX5ECfjHDIoLOcPiVbLgNejK
	SWQypKrk5lK9vM2knl82c6zEL2Y3ViKZW0cbnMm6kAwMjqXtxYNtLu0Canw2mD3H
	5VTx696SeNDQ3w6SrvLfLBqPyjczC5LdgXbVf7NmZykaaCEvANVCMRcixl1dqsZH
	mzAMf3TXxlUfy/RS9vjNNcz8xUBFgNvlw5uBfR/MRPNz/ugrntyBAMaiZzHcQPhm
	jEhoFk7eFYlLUJfDWSDfhUajgqSNiN/oiHOShXCe1s3XPdDKTpGQzML/pqo7ipr4
	Lr2rOIF5LFKrAYnNGPAyHA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt67vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:30:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EB5sXJ026603;
	Mon, 14 Oct 2024 11:30:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcfm4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPbit209l+CYqDiA782Anq6ulmgoigC28en0Tn7NyAs2qHhJsPc9EkTlU3S9qXK7otAT315fENXe+ZtFEaWP98ZU7rHAkvrNFnkJT8EYnbYzN0oJ8j/WRBQsp8PPbAOzpWK8UWdIvZ3YqA5WeqVdwx3lr+cYqIteCYP1GyGPGkmY3aR8TR46O9dPInBPt84g4t5W3aXSP8DbLBuqKoE64iiiqssppudhsHV6EhPrf116l8pJfbhhxCMC3gLO8yor4O1y+3ECQw2ehCOFKI6MYM5qzXHItANzKdvS7LkXZrT7SD/ri2cbzgdIGe2WfAmWSzzPgd0521zexvxfcy49zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scR/glwjqXmm1Ui7o+WL4w10pa6Lu0JfVTUSGQthudM=;
 b=e4FhXsELe9NGMwjzzwH+ggor55CnQOtqVn9SFu5UVpi9mf6tqUD/rOiZX0Bg4i/D/E7Ev+GQXQ2TU7WO7pI9Yxe4EABfC4xfAUzq+fjGHWI/HbgSKy4XYHHZltpoDZE+7jB4CbQcK2hq9OfZ7MhEcYgrIzXw3DvDK2QzhEQUS5QSkT2TuiMRvrqp186Pqf7uS3XeBaRjeNkLhADVPf7/ALU20aRWGTWxlcmDQcoKsz3tAYqQvMIKI/xPw0i0sW4HOxK3NJE5/vPoIg2TC3VxO5xVeu7Cwp81DVcPZ6DK27DwHLFbTEAHobvL6Er+68MKy9QyK/7FbsemwizihhnzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scR/glwjqXmm1Ui7o+WL4w10pa6Lu0JfVTUSGQthudM=;
 b=oxR5GVB9kRmahXlyuoNJWb+t3n5PNnnXfdbsKKxook3ggch2czOa0Ot5Mi6fbvRYOFHkp0Y20888vxxKy7/9ce1MpHQVdJVXTp+cCywwwsCwsNmrHb1R8wVdP0MvotAmZHc/aHzFr4EdD1bJaNRkAQQ4NZBfefzjsmAOiOb7Qp8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH2PR10MB4359.namprd10.prod.outlook.com (2603:10b6:610:af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 11:30:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 11:30:38 +0000
Date: Mon, 14 Oct 2024 12:30:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, vbabka@suse.cz,
        sidhartha.kumar@oracle.com, zhangpeng.00@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: fix -Wunused-result in linux.c
Message-ID: <19434478-b8e5-4158-9d8d-36e8db1563bc@lucifer.local>
References: <20241011225155.27607-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011225155.27607-1-skhan@linuxfoundation.org>
X-ClientProxiedBy: LO4P123CA0167.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH2PR10MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6fc847-4700-4aa3-174e-08dcec43a0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEtKZlI3YWIybEpnbVpwRkxvdkZWdWN2R25VQ1VJVTNVc0tSSWFUcWFNQ3ov?=
 =?utf-8?B?cFZHd2tnSGRoTEFZclFPNlRqSnU0YThQUXJZU3N5TVB0WEdvU0VIWnJwek82?=
 =?utf-8?B?R3ZBREE1djgyRzRXSkFPSW1NRHM4VzJoWndsZURVMFRLeGxSZndBMjNRdWRG?=
 =?utf-8?B?OW5VRVVSVEJJSHR6MWt5RGQyMVlSZHBDMXBnbUIrK2FHWGxxZ0FJZk5VVHR5?=
 =?utf-8?B?U2EzbHZxdjRDYmpPV2tFRUJaMjd6dWQ1d25DYytiUThiancyNzkrQ25OVEtr?=
 =?utf-8?B?azcyRUh5SklEb3VPM1NsWmFOWHpaWktjcTVpb1hJK3c5b3Q4S3I3YUpSbnEx?=
 =?utf-8?B?WUdsZHFRUENBRkNXbnpZRFJzS05KajhXMERmbDBRZ01NODliMGYzTDdCMTVS?=
 =?utf-8?B?LzdvRkJCeDR1SWs4cWlzaVJzNk5JYzhIZ3FTeTBudzArUytQTll2TDVoVXZY?=
 =?utf-8?B?UHNLSDNETmJKY1RzczFOZmN0SDJvS2w3OEF6ekVqdzlHR25ZeGJxWC94d05B?=
 =?utf-8?B?Y1FaMkxwam0yK2tic0YrY0o4ZnA0VitrYmFZZ1V5dVhwK1ErejhrNGZzeVhj?=
 =?utf-8?B?Tm9SbjZhUks1emExNXA1eUxSYUh4b0VXMEcvMzdTVHBYRmFWVjJMMjEraHVR?=
 =?utf-8?B?TjdNU1ZXV0VNTWk0RkN0WnNxTGM2c2V1R2tiQldHbmNLWjJTb1pHTzdyVU8r?=
 =?utf-8?B?QjQ0UnFzbFVJbndrdmxFcldUTmRTNXBFREVpdG5EcStTb21WT0FxRmFFczRr?=
 =?utf-8?B?eDVZLzRlU2JjbXI2cHJvREtlZXloWHNGQjNLdUNER002QjF2dnZ5R2EwUU4r?=
 =?utf-8?B?TmZ0NXdDYmUvM25MdFI2Tm5sWFpFbHZqSVdVZDgrQ0JBS25DWUkyVU96Z0tQ?=
 =?utf-8?B?dTk4eExTSGZhV0NHZHFvTFpKYllQYlFaeDdDVXUrcjJpWUFJZnpLbll6UzRI?=
 =?utf-8?B?aGd4QXZ6Z2FSejgzSERkYXlxRll5WUc4azBsbysvbERvL3d4WFNlT2tuejB5?=
 =?utf-8?B?K21KMmtaTGlRdTlHT3kxRkNMbFN2SkFvbG5Gb1p6b2MzcnYwMS90Z2t3bVNM?=
 =?utf-8?B?WHFZL2Z5Ykg3TG4rTXNwU1pJZ1FDRFNTUDhodHpRZ2U4RHJ4RGx4eWt3NkVK?=
 =?utf-8?B?V3BWeWNlT2N0SmFoVUxFM01QWHpKaHlKUExydWVuL1k2UE5jUEdrTGxjNnM4?=
 =?utf-8?B?QmxTNFpmUGJNUkdmS3F1dTI5WUtQMkwrRk5xVFJXdDR2aC9CWE9RcDNSakxG?=
 =?utf-8?B?OEhkTHh1dzBMR0Yvem0wck1Ta0dNWW5ITTFmWUFPZ2RRc3c2ZVpZNmJRRkF4?=
 =?utf-8?B?UnRxSmxKQ2VCQXA1YTh6bDcwTjJ2a2NQTjdPRkdvYnMvMmEvaXZneEMxL3Bi?=
 =?utf-8?B?dHBGZG0ybUh1T2NNUDEwbGhmekFPQVJ6ZXNrVXFVYU1GOUl5cHBna3dJTjJZ?=
 =?utf-8?B?RTRpa0lJTy9PZ1ZsK1FEUUVhQzE4OE9qeXRMWjNra0ovcEI3NUZQZGJidk9F?=
 =?utf-8?B?NXZkSHdWdGNCU3hMNnZoMEprN2VQcy81SmNia1pGbWFMQTZrWlBFTHVxT0JW?=
 =?utf-8?B?SUMrZEhMLzNROTJlQUtFTmhETjVtWnliOWQrOWREWHdTVmVZV3V1T1NJOWI4?=
 =?utf-8?B?bEg0ZWYzdVFFM2o3L3dVRm9xS2tidXl4R2VVYWRjYm9kWWVFTHJZbHdKT3gr?=
 =?utf-8?B?VW1Tc3NuTm9scmNVcFV0OFRTZ1RVQkEvMS9oMXZoSjI1RDllOWNYRkNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGVPMllSamN4dkxqZ2ZWdE10V2ZHTFhwMjNYWE52bnN1Y0JBUVg2S1Rrb0xJ?=
 =?utf-8?B?azRMSW1KUmZjRDVXcDEyc1kraURPeENlT3ZBTWJSbTZPb1JUbFRVZml4OUEw?=
 =?utf-8?B?L0U5NlVNdk9EVDRvVlhGcmhXdTZna28zaFgyb3FiZjBhTkdIOVloK3dFaWFG?=
 =?utf-8?B?RGNwSGhncGdIM2VFTGZMY2xyR2RWNTVnbjgxYWZGM2R6dStwdUcyQ0JkbmNL?=
 =?utf-8?B?cCtlWm55ZksxZEN6UnU3NU9kYUV6QXBlcVk5OGFVK2x5eTZuQzlDc1JuWHRV?=
 =?utf-8?B?ckErR1BkL1ZDMmpqRzZCcXJEbk1mTzMrT0lnVWZqL012TzNoZlJ3MFdycng2?=
 =?utf-8?B?WFhwUmtuRWI0QzljWDJjQVV4VGZNK1B2SmlUSjlQVkRUWTNUYmJtMUdWbDJI?=
 =?utf-8?B?YTNYeHFkZWJiR3hQQmprYTJEbnhFZDg1RHBBRW5qWE93Z1o3WENrLy9iNVJH?=
 =?utf-8?B?eG1ZbmM4WGVONSswa0s4TXlid0Yyc29odGpkdTZaOG8zbzYrK1JPOTVoaDVo?=
 =?utf-8?B?OGFaMTZ3a3R3WXNRSytyTXVhdjUwTGtnK0REOERMbmljNGczWjYrTWk1UEsy?=
 =?utf-8?B?a3ZxM3ViTXZ3RzdZUlJlQXlaeG9QbEZ5R3JSTk84MHZxeWx6NzdaMFBRUVZv?=
 =?utf-8?B?ZzNiWm5aQ3AyTlpOMUlIeUtiVjBlTkRTQk10ME5hb2Y0T2lZVy9vdlF0WlZI?=
 =?utf-8?B?WlZtSnRGMEx3a0tQYlV5aDhPRjNuOTcrN281MFZJV2l5YWdjUmZlUkd2dmN0?=
 =?utf-8?B?TDZTSFhHOHBvYmlzZmZqWEg2TTk1ZCs3OU1QU3dPZ0N2Ukdvd2c2Z0tpOTJw?=
 =?utf-8?B?K0R4ZWxmdmVoNDAvWlR3eS8xL1ZlSERzV1J5NGVITElqZzdSeFR5a2pxYzNz?=
 =?utf-8?B?NWlJSnl5aTQ3UmJPUkpaSDFyM1l4ekRKZVVTQUU1ZkV0OWdlYTB6OGdVaUhk?=
 =?utf-8?B?Z29nRzR6eGtDQ29xb2t2eXdXbHBaRGZYNE81bmRBUGhoU3FlNG44NTBSTVdI?=
 =?utf-8?B?YmZpWGRwS09qM1FYNXA0QW5EcEN0bVJnTHRGYk5EUGlYSGhBaXhmcFI1ZXo5?=
 =?utf-8?B?Ryt6b0k3dHV0ODhBNm16MHJWck9SNnRmcHhvak9rSkZsWUFrOXc1WU12M0Zq?=
 =?utf-8?B?bnA2YkY0WEdXYWRkUWpyZ3czMWt3UUErc25CcTRoY2lVK1NIYVJWeExnbjA5?=
 =?utf-8?B?anJjazF5ZGRuRnJONk5uTytiVng4dVozSzJrV1hXOFAwOGJhcFkvREZSRER6?=
 =?utf-8?B?TzE1TnJheWZmbTluUkpJT3lBd2xzakkySGliWTNDbGdneE9yK25Wais3Qkwz?=
 =?utf-8?B?THc0cHJubnNwZEhxWnh2VUE0VUlKb1k3eDBPNWNId1hTNVZlYkpFYndEa0kz?=
 =?utf-8?B?dUwwTVZXQmJWa2lKdDFBbTh3bzFVNGUzem1nQ25uWkx1WVBmWHpodnc4N1Fw?=
 =?utf-8?B?R3MyZ0g5RWtSQ0dEN1R2aEswbVJLTUszZSs3Ty9MMGJCcitZYVlUWWRaZDF4?=
 =?utf-8?B?Z1M0dmdqYmRTVW1SVzJscXlSRTl0eDV4aDhlTDNkdnUxQ1JYWnBlZi9UR2hE?=
 =?utf-8?B?eUNVVnRGMjQzMDVsM01lcy96cjlFeG9QWmoxQkNpMjlGN09JYlJWWVV5ejZZ?=
 =?utf-8?B?Y2psV3FibEZReVFHb0RYeEcwYnlkU2ZTQ3VXNlhFdHJ0SmVybEo0L2VCNlFw?=
 =?utf-8?B?ZXJJK0huMUdCSWMxYmNYL09nRXBrcEhtNFBiUUkwQktsVHg5Q203V0d5ckZG?=
 =?utf-8?B?T3d6Y05LK1JFdFNsUGYvY0M2M2ZpbFBxSkxxT0hmUFNqSUErR3J2MVJJTnhS?=
 =?utf-8?B?c0lXblg4TjZwdkhveWM0endwNENHdTRHKzkxL2F5RUhadTh1bXpHeXduTDEw?=
 =?utf-8?B?YTJWNXU1MFhIbUVCTEFLQ1luK0ordnREaXVSWE4ybUovakR6d1lRQmNRcU5G?=
 =?utf-8?B?U0NuVTY2azZRN2ZrM25MUVF2TldvN3hQNWhZN2RMOFdDbTYrZzZjYXQ2ampl?=
 =?utf-8?B?ZDJkZExOaXFaclh5Um0yNUNUMzRxUHcxN0cya0hVRHFESHhIOXRlNFNrOGls?=
 =?utf-8?B?V21wV2V6eVB4TU1kVkFyR2NTbXROUng4NjNsWS9zaFNvYnJmQ1dPekR3alFX?=
 =?utf-8?B?NWVTVmM4S2pZM2dHdzhXRGxQRmJ4bkFTNEkvbFVtVDJQSGEzYlJ0YnQ4b25O?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tN7xNlV0enrL6wrcGX3R9hlr8VTgZurM7vG2Acv4arHzzmGyZ9h8gmOQI6QAne5fyHWuw3ImE4sByXW9X6cZU3rrnpZY1+T55g8RfvPl1GomsS0ElTIjyS1thJLIMEqF0EpWU6I0ulVFIA/kXumYf3gGDvN/lDGMtIw4k9eoT91xLWFgK3j3NivYiYNe2xeRk046pjyv1UDhYzixBEksRhW0wQ54R+mN83gJHvyFZvPSMVljPl1jUW2uGSxuE+MVFYN7NKI0J98yEdHP7UJ+4ByXDNbNIscOVS9HXqgBtjRKnKBjk4QaiZ713FIJvFWk8lAhaU0CbdBgpOf4PA3EHjgjbEUMk28XxYMkYYPLYUrUAiiXJuTWmnVA12LqcIP0VbIvlP084ygtx92Ufxfm+Qt64iEvpi2WLsvzU+T8E/R1+1n9xzxIj39sxFmEV4sGKVlBSFHnGG26Hs08JmyC0UJ0+f/HkIoFiw9Ntu+WGPnVYXWoe4UHH5G8xqegDTVrnVwNOLNkfXEvwK0QxnoWP4JrpK08O//d37W/qZ3VQTNJbT/chOe0r4kGGopaTpWjd1Z1f3HNi9Gnp0z3WXV5wMim6Fo7oSAXdNXb2++R9jk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6fc847-4700-4aa3-174e-08dcec43a0d5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 11:30:38.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zx2D+qAX72EphywaxFSjhCx4Y25oZg7IXkzBRkCN5wCuBBiv1QPpIffp97HG5AK7RQ1yz3Yd1DR0LbxvkQS2Stla8o6STN+9GReu+Qlw/8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140078
X-Proofpoint-ORIG-GUID: VH3AN13QvMD0xvDOLkE_UN7fb_5Nts4W
X-Proofpoint-GUID: VH3AN13QvMD0xvDOLkE_UN7fb_5Nts4W

On Fri, Oct 11, 2024 at 04:51:55PM -0600, Shuah Khan wrote:
> Fix the following -Wunused-result warnings on posix_memalign()
> return values and add error handling.
>
> ./shared/linux.c:100:25: warning: ignoring return value of ‘posix_memalign’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   100 |          posix_memalign(&p, cachep->align, cachep->size);
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../shared/linux.c: In function ‘kmem_cache_alloc_bulk’:
> ../shared/linux.c:198:33: warning: ignoring return value of ‘posix_memalign’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   198 |          posix_memalign(&p[i], cachep->align,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   199 |                                cachep->size);
>       |                                ~~~~~~~~~~~~~
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Looks good to me!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/shared/linux.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 17263696b5d8..66dbb362385f 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -96,10 +96,13 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>  		p = node;
>  	} else {
>  		pthread_mutex_unlock(&cachep->lock);
> -		if (cachep->align)
> -			posix_memalign(&p, cachep->align, cachep->size);
> -		else
> +		if (cachep->align) {
> +			if (posix_memalign(&p, cachep->align, cachep->size) < 0)
> +				return NULL;
> +		} else {
>  			p = malloc(cachep->size);
> +		}
> +
>  		if (cachep->ctor)
>  			cachep->ctor(p);
>  		else if (gfp & __GFP_ZERO)
> @@ -195,8 +198,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
>  			}
>
>  			if (cachep->align) {
> -				posix_memalign(&p[i], cachep->align,
> -					       cachep->size);
> +				if (posix_memalign(&p[i], cachep->align,
> +					       cachep->size) < 0)
> +					break;
>  			} else {
>  				p[i] = malloc(cachep->size);
>  				if (!p[i])
> --
> 2.40.1
>

