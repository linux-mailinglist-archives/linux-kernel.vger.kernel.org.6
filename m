Return-Path: <linux-kernel+bounces-276332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB2949237
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F221C2144F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91261D47AD;
	Tue,  6 Aug 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hu5phMRg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MQb+xkR5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00A1D54F2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952347; cv=fail; b=Z9HFBsSQJPJbMDMKpAPOvegZDJ32KEm2U61WH8pL02n/7PWXcFsIBQ4Tj9laCkH9QqokYoaV1n4FtEwZ9FFQVjPkWNeBk74GVmYtiXznK1CAvq0X1u7/21KL+Fqe5Uwz7QXg5rVoMJSOG86GDVrkO/iPfISH9erz9n8wDx8Dhac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952347; c=relaxed/simple;
	bh=v2lQZkVfd60EMXoUCxDqJGk/jajAklFjRQwfJ1Hsdy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iwVcdE0ABeyVa9Ve1jKFr51GH7Fa6ip3UIRA0Pmc/UEIyAr/ha9a4gmzlhOJXV4qEaiacgU4Ayj7bDvlZj4cXSNRUswr+Nh4rMR5xmXhCu7NmhESMh6PPP8zXfGGtqME1RA4Pf8Hqk/ErhXcQMnTEqb9/la8RUJnhILcimJA6vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hu5phMRg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MQb+xkR5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765kesQ005096;
	Tue, 6 Aug 2024 13:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=oD/yYjj91ssp2sT3GmAZJ0BGT89U701uv4gFcx8rwgo=; b=
	hu5phMRg0T6tO0GrQVyr3wAsAPGq0OHONhGvNmEiDVKsOwgltDK3ovAm68QsKTTe
	lJb4Iq9OJRGi+EKXBfojXSeja0rzp1m4xF6to9JggzWTH4kHxjFLnnL1IXvSON9c
	fMNBq0D1FocuDRxQqz0NNgSI2+iCasFo6q692FvGbn5fI/M/UNBUwB2CQCu4M512
	2od0/YcaHJRK2O52GUfWJZ2TzfVXThmgzgIKYc7XUihLnDR0cWoCYODbEXC5GTBK
	Nc6uxPoSzG0KjlhLyzInNZVLubW7ZHg7WqzAmPwxy7qswcLlt7WwJZpqXuaciQbQ
	jl7y/TnGrLbYEHXZRfR2Tw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sd3unays-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 13:52:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476CO33b035131;
	Tue, 6 Aug 2024 13:52:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08vwhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 13:52:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLlwz62/coer9/67r7vyIYnSBLKOmRqhLtcNfSmi/65ZmvnjmtQfaYjAYG9YomP6irtZ7jJErsVxk52NuDqdVwBBflcRn1dMoN3mDXULJaWQBGFWDbgyvIpt7qDhuAIzgaG4EjR2UNuQJezDwaBEjyUMF+LgrLClwSsBIp00urPNUp961Quk+BV7vBP1NqQd+PJPiD2JE7XV5T/bu/KpExckRKMe9XkmOVRFr6cNHvo/y0ulBXZJYpxn50OdVbWh7Nd4HqClyATLnC7M+SwxBzqUpex94ZNHDfaESkYWZobwgsVaULRjWq3lHEEU3peOO6NN8Wn/9z3rwqklWASvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD/yYjj91ssp2sT3GmAZJ0BGT89U701uv4gFcx8rwgo=;
 b=Al0SGWSrkF/woYIa/HDK9oom1XX4gKSDGSbfCRBMwWw/LY2uNzRygXTvZtYDXwCHR/n5pKp2IAzUotYqTzTGUyycmC6pvxspYSQ0L1zjAX3PSa3KgemEBuUZ8dTMMxS3qxJ02NKdO/AK5lHNnI5QQ+r+jbK9tnvtm7MRLcumJ0r/MP0lo28earjLSoukqXL/JVIhNUKAVFDJmLv0tkzI50etubrxmvNDgQ3He+K6wghv08fjsm+I9w5hXU1DNEJz85UcEYML990qWV3tJOpjy2pTCrdv2fx7jEO+puppLYNqwohTrDMG+VwjH3KRYCCV6c463uUF/1J5uBfYsie7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD/yYjj91ssp2sT3GmAZJ0BGT89U701uv4gFcx8rwgo=;
 b=MQb+xkR5k+FHcRUXa6UyvJL8G5KukjT1r6xyxc8dsNjIA53CpfUmcFH9920dnX5yciCOI7IiXmnnDEMXAc8EJJ7Jo/x4Zz7ZFTI97Pu3+kPp9nK82SddtY4FTz/QNBGfcEUBMAofgHyk5a95FXOHXiuU372YWxSUyeQZ2ohIOfU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB7425.namprd10.prod.outlook.com (2603:10b6:8:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:52:10 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:52:10 +0000
Date: Tue, 6 Aug 2024 14:52:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 09/10] mm: refactor vma_merge() into modify-only
 vma_merge_modified()
Message-ID: <010d7599-82b7-415e-856b-a9eb4dc145f9@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <5ffdf3241d10bfe96371947a27f596bf21761af8.1722849860.git.lorenzo.stoakes@oracle.com>
 <20240806154244.5faeba67@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806154244.5faeba67@mordecai.tesarici.cz>
X-ClientProxiedBy: LO3P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ef7af1-a894-467b-691d-08dcb61ef7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk5GcW1uQmhRNTEvM0d3aHdsbW9NRkV3YU5jSFdOYXFmRzE1RmUxRS90V2Zn?=
 =?utf-8?B?anB6K3BqRjR5VmRBTjV4OGhWSlI5UllLYWcyUGdpNjl2bzI3NlBBU3VSdmdH?=
 =?utf-8?B?bEtITG1YUlJYakRzU0ZGMXlGWkJhdnVWbHlEeE5uMUJtYmwxS0swam83a2xU?=
 =?utf-8?B?NmgvNHhoeStaT25oQk55bXZMcW00bWZaSkYxWDNITU84RnA4bC9ZenJEYW1u?=
 =?utf-8?B?ZU9MUjRYUnkreFNkaUZzY2Q1VkxJSVVKU1pNWFdVSG1MUEVobGlkK0U5cmFM?=
 =?utf-8?B?OWNFY05OM0RTRG5mb0x0amwyZUp6VnQ0RERYN2N6dzRUN29tWDVjOFVrQ1dZ?=
 =?utf-8?B?TjBsOC9waXJyc21MUGVrV0hJTEo2ODNBc2x6TFBjVDNyKzBzRFBMcGFlWS9Z?=
 =?utf-8?B?M1NaNDV0dEtzczdXZllianUxSHRybktEeUVpbEcyMnZFUnFWM0RUUTNXd1ZT?=
 =?utf-8?B?STZBYUxQMW5idTNHNjhLbHlnVUxQOVVIMHh4MjZ6NUEyM3BoR0NWb2pTTG12?=
 =?utf-8?B?VDAzdFE0UDIwNTRtR2s3VzlJU3NXSDV2OUFDK1JSaHB2MVNzakhRNmlpbVpy?=
 =?utf-8?B?UDltQm1CaXNKUkVHNGxObDdLRVpua1pSZW5RRUh0aE9VMDdYZGdlOG9WZHkx?=
 =?utf-8?B?T0hQNStWTkRNMFQ5eXdsK3JBdyt5Sk9BOHMvR0F0cXBFM2preVlEWnBROWMx?=
 =?utf-8?B?WTdzTU0yQ1lwS1o5Tjl3TkVERkVWUmVLSXdIRnhFTjlYN3dtSHgybStIR0No?=
 =?utf-8?B?RWJtMmJ1K0todGdudkdTUE92YVV5ekpXRUJLem9qWG1YVmM3c01aclpKSkNq?=
 =?utf-8?B?dFhXMnVYVEFZV2puMEtRVnlzdVo2elZMTFY2NmcyeUxuV1pPYlc4Ym9VSXVS?=
 =?utf-8?B?RS8zbDZPR3RBMmxSTE1JSS8rczFZZWMvcEk3RDF4NWk2citaWldzQjRvYzNn?=
 =?utf-8?B?YmRZSlZHN1VtMXYwUGFhbGRPdmFaOHVxOUJRQWVWZVkrVXhacXlWNkI0ejhJ?=
 =?utf-8?B?T3Y4alpyQkVmU0MyRWtVQmphTHM1eHdjVlZvZ1FUN1NheHdnb3FBR09ENUl1?=
 =?utf-8?B?eml5aGdUakhJaExrbkxQUTNrV3JWS0pKUXZHRjI5UEplSW93QTJHVjBxOXEr?=
 =?utf-8?B?RHIweUs3NzFBdTF0a1Y2OUpvT2dIZWtPK1UyQTJ0L1VPdG1iNWRSL0p6TSt5?=
 =?utf-8?B?OUd2VE1OazVjUWJtdit2SllOZnZaelIxeFpESVB0RzBsSmxpcmR2aExvc3I3?=
 =?utf-8?B?MFNNUVgxeFdONTI2ajEzWG5vWTNiN08rNUJnRVRpdUpCYjl0UjVrdXpHNnFJ?=
 =?utf-8?B?L3MrL1lTTFR2d0ZXUndGamlIc2ZxdEU4MGZwUHlwVWVCdWJCQTEzU3FkRTNz?=
 =?utf-8?B?N2R6Mmsrbzg3ZUwvUjRTUGRoSnA1Qi9kaG11V1YvV2RMemZwcGdaNy9NTXBl?=
 =?utf-8?B?cU82cnBKaGZnTWg2RHZJaVB5S253REdBU2dZZ05JQk8vY1lOY3ZmbTJUVjN3?=
 =?utf-8?B?eFZkeWswbGxtbW1zRUl5eEhaOVI1eTBZTVVHTHY4YStZbXY2OGp5b1V2NXRi?=
 =?utf-8?B?VXROZFNSMHVodlFsT2hSU1p2VEx0WWVmMFZ3MHVqOFQxNitWU3UzN1dkWUtK?=
 =?utf-8?B?RGU4QjBMMVdIT0Q3N011NitzQjArNno3VEdmV3NTTFVidjdldU1lUmxnY29r?=
 =?utf-8?B?YjdHdEFIcVBKejIybGVueTVwbW9PdWVJai9DakUwUkhaeW1aVkQ5dnBXaGNO?=
 =?utf-8?B?N0d4R3ZYS3E0cGhmaDcvYjJ5aXZab0ZDQWQrSmdVNGw3azE3eVlFd0xXUjB5?=
 =?utf-8?B?MnZ4OXFiUzRIckNwVVhCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yy9LK0drRlpSK0pCSUpDQ2t5K3g2VVFxREcwa0dVWnYxU1BheVN1RGtlaDVT?=
 =?utf-8?B?dkZNaVM2cWNNQWw2R0luTW5XRWd6Q1QzSURzanJBcDF6Zkg1TjFValFBWUlI?=
 =?utf-8?B?SGFLMkNqWnVnblAyTS9TTWY1bzVJaUJINUJxekx0MG1BZHI0Si9pRURkdXN3?=
 =?utf-8?B?eCsvSVJOWVZKRlBWdWd1NHUyTTVveU5Wb3VpelB6VExIQ3JnRVZrY292VEEv?=
 =?utf-8?B?NEdiN0EvbGpDUFJld3NsOUFFMU9zUkJnd3cvdnJRL3VlYitlM0UxZWd3MDBq?=
 =?utf-8?B?WFJJM0R3QUxoWmJIbmN0OVgrZ0dGZWdRaU1pTjI4MGExeDhRNzNMemhVMTdL?=
 =?utf-8?B?Tms2UG9jUDF1N0EvMjA4YXlxMHV5em5qL29jZG5BK0w5RHZVV1RhcjVmYWM4?=
 =?utf-8?B?RElxZTUyVGJIZlFlaUNGdk14dVI2TUJoOW1zeEJMQ3ptNnJQVjRjazR2RkZv?=
 =?utf-8?B?MlljdjFVMDVyb1FFbFdUSllEd2tla3VXcGs1ckFnalVhVTNLWUh5TnhiTVNV?=
 =?utf-8?B?YStrcmhsMWVhTHRBZUF2bDM2NkpGeEQraG9KcHJ5VmVRYm5sZStpRUNGcjQr?=
 =?utf-8?B?RzdzaUJneDA5UXV0K0dMeWYyRDNpY1JnMkNjVVllazhkNGhHR2t6RDdMckFy?=
 =?utf-8?B?SEtrUEI3NnU3V21kcEVqTVE1cjByQlZrY2lWenFVS2Zha0hHMytIMXF0dGpl?=
 =?utf-8?B?eGJUajZVM2xkVm5KZFlzWkd0N0lCdUpVOUdjQlg2clcyeDZHMm4zMDZSa1dw?=
 =?utf-8?B?ZWFDN0VNNSt5eWtwQjJIUkNKOHNNY1RDY1Eyek9xKzQ0Q3JOeEh0dEUvdjUw?=
 =?utf-8?B?SjZmU0hVaGZ4bFRxLzFZSkJkbHR4UEVZbmYybFVsb1VuOXJSTG85UVV3Zyth?=
 =?utf-8?B?Ukp6M0Fidm5mR2MvVXNsVWFKUmV6UzZsYllBcllic3BQNVdDRkg2VDJBSTNs?=
 =?utf-8?B?blhjTlYvK1QydEF5Y2ZuV0VuRVRKOGYvMW1CT3NScUdzeFg4c08vbHBITFlT?=
 =?utf-8?B?bXNEaUxrRjBpTitNTysvT2Z5Y1FaRkhkTFpQUEUzaFNFRENDOFVDcVRnR1Bq?=
 =?utf-8?B?L0puQ2VONWEyOVhwTGVkS2dMc216MFRVeUFTTGlnWC9PYTdCa09ybUQ3Ni9s?=
 =?utf-8?B?SERJWVY5RXdRYlpNTVJ5M01mbWlHb1dwZ1IxRUo0VTZrSmZOLzBaRGlLL2tK?=
 =?utf-8?B?c09URjJVb243MkU1cWsyRk93YndpUHJLTHkxUDRKMktiNTdObmRMOGh3VVov?=
 =?utf-8?B?blV6UHNTdE5SWVVpT2RyRnFTaVdmSzJNdjdoYUp2MXB4SXhVUEoyZEJxZ240?=
 =?utf-8?B?elgvcUtzajdqSEx5R29jdzU0Y2VVVTg3Q1FvSXh1Wld0VXRmMC95ajl2RGtz?=
 =?utf-8?B?SEdTSXM2dVZETkF2RXlZcE9Zc1pGT0FMRStUdTZYcFlId1c1VExQNk5zWUY4?=
 =?utf-8?B?VE5sUWluZ0pvT2lYRnRsSEh2Y3AvdUl3VFdzaXZ2SEQ1M3ZXbG11dzFRYmE0?=
 =?utf-8?B?TXMvL3BiNFFkRjB5Q3N0Z2VzQ3ExN05rU1dPOWRQdzRyeUovQUxqYnR5TVpa?=
 =?utf-8?B?WVYzNXl3OW90c1ZscjFLTHM1QS8rMmdXRGNVM3VNMTdGdlJNSXEvQ2FPYm54?=
 =?utf-8?B?UmpTSDhVRHhYQW1JM2xOQkI0U2I1WllmdzliNHF0RjZ1UjJXclRnNHlLaVhK?=
 =?utf-8?B?R3ptNmVTUzhmTDFJZ1VDcnFYYTdJbEdJdnFTYmpEMGk4MlF6RzVITmswTEN4?=
 =?utf-8?B?Mi9zQUxybHRvRXBLTWNyL0VsNTZLOVJYN21LM0hseUdLU0dpQUY3VTBtMGln?=
 =?utf-8?B?VE1kL29wVmFNOW1odGFHMzhVYnhWL3VXbWpZeE83czVTendPQnBnc1h6SVZ6?=
 =?utf-8?B?YlNEdWNhbzV5Y1p1WVFqTXdnRlBnNnJxZUxtSnZYaGRuYzFhSzc4Z1B3T096?=
 =?utf-8?B?Sk5kRFRuUTJXbHkza096MUJya3dDUVFMb1dFN0hLeHcvYm1uNmNDOTk5K2xp?=
 =?utf-8?B?NXgvVzlGbzJobmNueTFuU0RBanZXc0xlMi9RdUU0M2hoMXRxdEVUZ1l0UGlB?=
 =?utf-8?B?blJ5M2RSdkVhZzI4YTZWcVNsZHRPNnlhNFMzNkRzamc0QytnOHJ6WnV5SWc3?=
 =?utf-8?B?NjZGREp5WUUyRUFqNHlnZ1Q4Uk9TWHZsRG11NlF1eUFRU0hvcFJkRGw4VW5i?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cwVHOYaNpodmAtjuXYRJkTTue1sA0AR3dU4ZOOwyoUvucDSBXfcYN1CdvGGk6DJ+U8dK6iFFY2RrPB6K+eTaRoHlL5n+wZOzV12TlRh1V871WvfRyEl7xHkjTz/WLGX46Tp5sa6utnSpsWnVe+UN0Uf9WY0VmMP14wWSW2P5PvglfDyt1jf+XCLMwJTVTHUXwMAx5V/LwNJ+3VfMHlKbIhO7jMeuVjZr6Pnkv1oOOhMMOYY2tO3pPMsFUafMaGq3xI/dmjOCT5UW8JuIRCjAQ8dce3gohIgLjHNZKj/FicSN7oLrncP/i/HFdpFB1XaWo7p1KzUHkay53CZp7c4e/bBDYQh91Q8vMh9t7Vtw4iLaxnj5qvs5zJY4rhMPnyEcIRWaIo8c9gYpbin83p3M5AM7qLScKxoD8ZBU/tcRKkZwMNgRoFRI380meXOD6ZYpF77e3j/uKPGhydDNPpdZr7PRhU4/zMaoU6e9usXnMbcIwFAFm8e5drBISooBP+HRhtCfMZoXXlUoKq24sxksBxRcc/l0VlpTeZhOQ4eFmhPiL6P7LzAkNSE0GeXQtq9qXLB1AsQWPvuXD+C2ul553plBBNTkAKTJRw02KhOwfqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ef7af1-a894-467b-691d-08dcb61ef7c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:52:10.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcdbEk8w8/U0gaQ1umjZDcls1bkTuuboH7Cp0eUfM9yNoYhIFCkZZgDqBVACy1LfAFyti4XaUKzO4SxUE4GQ0/j2ZNqNQKczWvl0DDzFykY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060096
X-Proofpoint-ORIG-GUID: -yltDa5p_kD1ohju5He_cOK_uuKvPOW7
X-Proofpoint-GUID: -yltDa5p_kD1ohju5He_cOK_uuKvPOW7

On Tue, Aug 06, 2024 at 03:42:44PM GMT, Petr Tesařík wrote:
> On Mon,  5 Aug 2024 13:13:56 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > The existing vma_merge() function is no longer required to handle what were
> > previously referred to as cases 1-3 (i.e. the merging of a new VMA), as
> > this is now handled by vma_merge_new_vma().
> >
> > Additionally, we simplify the convoluted control flow of the original,
> > maintaining identical logic only expressed more clearly and doing away with
> > a complicated set of cases, rather logically examining each possible
> > outcome - merging of both the previous and subsequent VMA, merging of the
> > previous VMA and merging of the subsequent VMA alone.
> >
> > We now utilise the previously implemented commit_merge() function to share
> > logic with vma_expand() deduplicating code and providing less surface area
> > for bugs and confusion.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/vma.c | 474 +++++++++++++++++++++++++++----------------------------
> >  mm/vma.h |   6 -
> >  2 files changed, 232 insertions(+), 248 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index b7e3c64d5d68..c55ae035f5d6 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -569,8 +569,7 @@ static int commit_merge(struct vma_merge_struct *vmg,
> >  			struct vm_area_struct *adjust,
> >  			struct vm_area_struct *remove,
> >  			struct vm_area_struct *remove2,
> > -			long adj_start,
> > -			bool expanded)
> > +			long adj_start, bool expanded)
>
> Um. Oops? ;-)

Yup minor oops there :) will fix up and put in patch 8 if/when respun!

>
> Otherwise LGTM.

Thanks!

It's worth reviewing the use of commit_merge() here which answers your questions
on patch 8 as to the use of the adj_start / expanded params.

Keep in mind this is trying to retain existing logic as much as possible to
(somewhat!) minimise delta.

>
> Petr T
>
> >  {
> >  	struct vma_prepare vp;
> >
> > @@ -607,6 +606,236 @@ static int commit_merge(struct vma_merge_struct *vmg,
> >  	return 0;
> >  }
> >
> > +/*
> > + * vma_merge_modified - Attempt to merge VMAs based on a VMA having its
> > + * attributes modified.
> > + *
> > + * @vmg: Describes the modifications being made to a VMA and associated
> > + *       metadata.
> > + *
> > + * When the attributes of a range within a VMA change, then it might be possible
> > + * for immediately adjacent VMAs to be merged into that VMA due to having
> > + * identical properties.
> > + *
> > + * This function checks for the existence of any such mergeable VMAs and updates
> > + * the maple tree describing the @vmg->vma->vm_mm address space to account for
> > + * this, as well as any VMAs shrunk/expanded/deleted as a result of this merge.
> > + *
> > + * As part of this operation, if a merge occurs, the @vmg object will have its
> > + * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
> > + * calls to this function should reset these fields.
> > + *
> > + * Returns: The merged VMA if merge succeeds, or NULL otherwise.
> > + *
> > + * ASSUMPTIONS:
> > + * - The caller must assign the VMA to be modifed to vmg->vma.
> > + * - The caller must have set vmg->prev to the previous VMA, if there is one.
> > + * - The caller does not need to set vmg->next, as we determine this.
> > + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> > + */
> > +static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> > +{
> > +	struct vm_area_struct *vma = vmg->vma;
> > +	struct vm_area_struct *prev = vmg->prev;
> > +	struct vm_area_struct *next, *res;
> > +	struct vm_area_struct *anon_dup = NULL;
> > +	struct vm_area_struct *adjust = NULL;
> > +	unsigned long start = vmg->start;
> > +	unsigned long end = vmg->end;
> > +	bool left_side = vma && start == vma->vm_start;
> > +	bool right_side = vma && end == vma->vm_end;
> > +	bool merge_will_delete_vma, merge_will_delete_next;
> > +	bool merge_left, merge_right;
> > +	bool merge_both = false;
> > +	int err = 0;
> > +	long adj_start = 0;
> > +
> > +	VM_WARN_ON(!vma); /* We are modifying a VMA, so caller must specify. */
> > +	VM_WARN_ON(vmg->next); /* We set this. */
> > +	VM_WARN_ON(prev && start <= prev->vm_start);
> > +	VM_WARN_ON(start >= end);
> > +	/*
> > +	 * If vma == prev, then we are offset into a VMA. Otherwise, if we are
> > +	 * not, we must span a portion of the VMA.
> > +	 */
> > +	VM_WARN_ON(vma && ((vma != prev && vmg->start != vma->vm_start) ||
> > +			   vmg->end > vma->vm_end));
> > +
> > +	/*
> > +	 * If a special mapping or neither at the furthermost left or right side
> > +	 * of the VMA, then we have no chance of merging and should abort.
> > +	 *
> > +	 * We later require that vma->vm_flags == vm_flags, so this tests
> > +	 * vma->vm_flags & VM_SPECIAL, too.
> > +	 */
> > +	if (vmg->flags & VM_SPECIAL || (!left_side && !right_side))
> > +		return NULL;
> > +
> > +	if (left_side && prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> > +		merge_left = true;
> > +		vma_prev(vmg->vmi);
> > +	} else {
> > +		merge_left = false;
> > +	}
> > +
> > +	if (right_side) {
> > +		next = vmg->next = vma_lookup(vma->vm_mm, end);
> > +
> > +		/*
> > +		 * We can merge right if there is a subsequent VMA, if it is
> > +		 * immediately adjacent, and if it is compatible with vma.
> > +		 */
> > +		merge_right = next && end == next->vm_start &&
> > +			can_vma_merge_before(vmg);
> > +
> > +		/*
> > +		 * We can only merge both if the anonymous VMA of the previous
> > +		 * VMA is compatible with the anonymous VMA of the subsequent
> > +		 * VMA.
> > +		 *
> > +		 * Otherwise, we default to merging only the left.
> > +		 */
> > +		if (merge_left && merge_right)
> > +			merge_right = merge_both =
> > +				is_mergeable_anon_vma(prev->anon_vma,
> > +						      next->anon_vma, NULL);
> > +	} else {
> > +		merge_right = false;
> > +		next = NULL;
> > +	}
> > +
> > +	/* If we have nothing to merge, abort. */
> > +	if (!merge_left && !merge_right)
> > +		return NULL;
> > +
> > +	/* If we span the entire VMA, a merge implies it will be deleted. */
> > +	merge_will_delete_vma = left_side && right_side;
> > +	/* If we merge both VMAs, then next is also deleted. */
> > +	merge_will_delete_next = merge_both;
> > +
> > +	/* No matter what happens, we will be adjusting vma. */
> > +	vma_start_write(vma);
> > +
> > +	if (merge_left)
> > +		vma_start_write(prev);
> > +
> > +	if (merge_right)
> > +		vma_start_write(next);
> > +
> > +	if (merge_both) {
> > +		/*
> > +		 *         |<----->|
> > +		 * |-------*********-------|
> > +		 *   prev     vma     next
> > +		 *  extend   delete  delete
> > +		 */
> > +
> > +		vmg->vma = prev;
> > +		vmg->start = prev->vm_start;
> > +		vmg->end = next->vm_end;
> > +		vmg->pgoff = prev->vm_pgoff;
> > +
> > +		/*
> > +		 * We already ensured anon_vma compatibility above, so now it's
> > +		 * simply a case of, if prev has no anon_vma object, which of
> > +		 * next or vma contains the anon_vma we must duplicate.
> > +		 */
> > +		err = dup_anon_vma(prev, next->anon_vma ? next : vma, &anon_dup);
> > +	} else if (merge_left) {
> > +		/*
> > +		 *         |<----->| OR
> > +		 *         |<--------->|
> > +		 * |-------*************
> > +		 *   prev       vma
> > +		 *  extend shrink/delete
> > +		 */
> > +
> > +		unsigned long end = vmg->end;
> > +
> > +		vmg->vma = prev;
> > +		vmg->start = prev->vm_start;
> > +		vmg->pgoff = prev->vm_pgoff;
> > +
> > +		if (merge_will_delete_vma) {
> > +			/*
> > +			 * can_vma_merge_after() assumed we would not be
> > +			 * removing vma, so it skipped the check for
> > +			 * vm_ops->close, but we are removing vma.
> > +			 */
> > +			if (vma->vm_ops && vma->vm_ops->close)
> > +				err = -EINVAL;
> > +		} else {
> > +			adjust = vma;
> > +			adj_start = end - vma->vm_start;
> > +		}
> > +
> > +		if (!err)
> > +			err = dup_anon_vma(prev, vma, &anon_dup);
> > +	} else { /* merge_right */
> > +		/*
> > +		 *     |<----->| OR
> > +		 * |<--------->|
> > +		 * *************-------|
> > +		 *      vma       next
> > +		 * shrink/delete extend
> > +		 */
> > +
> > +		pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> > +
> > +		VM_WARN_ON(!merge_right);
> > +		/* If we are offset into a VMA, then prev must be vma. */
> > +		VM_WARN_ON(vmg->start > vma->vm_start && prev && vma != prev);
> > +
> > +		if (merge_will_delete_vma) {
> > +			vmg->vma = next;
> > +			vmg->end = next->vm_end;
> > +			vmg->pgoff = next->vm_pgoff - pglen;
> > +		} else {
> > +			/*
> > +			 * We shrink vma and expand next.
> > +			 *
> > +			 * IMPORTANT: This is the ONLY case where the final
> > +			 * merged VMA is NOT vmg->vma, but rather vmg->next.
> > +			 */
> > +
> > +			vmg->start = vma->vm_start;
> > +			vmg->end = start;
> > +			vmg->pgoff = vma->vm_pgoff;
> > +
> > +			adjust = next;
> > +			adj_start = -(vma->vm_end - start);
> > +		}
> > +
> > +		err = dup_anon_vma(next, vma, &anon_dup);
> > +	}
> > +
> > +	if (err)
> > +		goto abort;
> > +
> > +	if (commit_merge(vmg, adjust,
> > +			 merge_will_delete_vma ? vma : NULL,
> > +			 merge_will_delete_next ? next : NULL,
> > +			 adj_start,
> > +			 /*
> > +			  * In nearly all cases, we expand vmg->vma. There is
> > +			  * one exception - merge_right where we partially span
> > +			  * the VMA. In this case we shrink the end of vmg->vma
> > +			  * and adjust the start of vmg->next accordingly.
> > +			  */
> > +			 !merge_right || merge_will_delete_vma))
> > +		return NULL;
> > +
> > +	res = merge_left ? prev : next;
> > +	khugepaged_enter_vma(res, vmg->flags);
> > +
> > +	return res;
> > +
> > +abort:
> > +	vma_iter_set(vmg->vmi, start);
> > +	vma_iter_load(vmg->vmi);
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * vma_merge_new_vma - Attempt to merge a new VMA into address space
> >   *
> > @@ -1022,245 +1251,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> >  }
> >
> > -/*
> > - * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
> > - * figure out whether that can be merged with its predecessor or its
> > - * successor.  Or both (it neatly fills a hole).
> > - *
> > - * In most cases - when called for mmap, brk or mremap - [addr,end) is
> > - * certain not to be mapped by the time vma_merge is called; but when
> > - * called for mprotect, it is certain to be already mapped (either at
> > - * an offset within prev, or at the start of next), and the flags of
> > - * this area are about to be changed to vm_flags - and the no-change
> > - * case has already been eliminated.
> > - *
> > - * The following mprotect cases have to be considered, where **** is
> > - * the area passed down from mprotect_fixup, never extending beyond one
> > - * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
> > - * at the same address as **** and is of the same or larger span, and
> > - * NNNN the next vma after ****:
> > - *
> > - *     ****             ****                   ****
> > - *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
> > - *    cannot merge    might become       might become
> > - *                    PPNNNNNNNNNN       PPPPPPPPPPCC
> > - *    mmap, brk or    case 4 below       case 5 below
> > - *    mremap move:
> > - *                        ****               ****
> > - *                    PPPP    NNNN       PPPPCCCCNNNN
> > - *                    might become       might become
> > - *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
> > - *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
> > - *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
> > - *
> > - * It is important for case 8 that the vma CCCC overlapping the
> > - * region **** is never going to extended over NNNN. Instead NNNN must
> > - * be extended in region **** and CCCC must be removed. This way in
> > - * all cases where vma_merge succeeds, the moment vma_merge drops the
> > - * rmap_locks, the properties of the merged vma will be already
> > - * correct for the whole merged range. Some of those properties like
> > - * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
> > - * be correct for the whole merged range immediately after the
> > - * rmap_locks are released. Otherwise if NNNN would be removed and
> > - * CCCC would be extended over the NNNN range, remove_migration_ptes
> > - * or other rmap walkers (if working on addresses beyond the "end"
> > - * parameter) may establish ptes with the wrong permissions of CCCC
> > - * instead of the right permissions of NNNN.
> > - *
> > - * In the code below:
> > - * PPPP is represented by *prev
> > - * CCCC is represented by *curr or not represented at all (NULL)
> > - * NNNN is represented by *next or not represented at all (NULL)
> > - * **** is not represented - it will be merged and the vma containing the
> > - *      area is returned, or the function will return NULL
> > - */
> > -static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> > -{
> > -	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
> > -	struct vm_area_struct *prev = vmg->prev;
> > -	struct vm_area_struct *curr, *next, *res;
> > -	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> > -	struct vm_area_struct *anon_dup = NULL;
> > -	struct vma_prepare vp;
> > -	pgoff_t vma_pgoff;
> > -	int err = 0;
> > -	bool merge_prev = false;
> > -	bool merge_next = false;
> > -	bool vma_expanded = false;
> > -	unsigned long addr = vmg->start;
> > -	unsigned long end = vmg->end;
> > -	unsigned long vma_start = addr;
> > -	unsigned long vma_end = end;
> > -	pgoff_t pglen = PHYS_PFN(end - addr);
> > -	long adj_start = 0;
> > -
> > -	/*
> > -	 * We later require that vma->vm_flags == vm_flags,
> > -	 * so this tests vma->vm_flags & VM_SPECIAL, too.
> > -	 */
> > -	if (vmg->flags & VM_SPECIAL)
> > -		return NULL;
> > -
> > -	/* Does the input range span an existing VMA? (cases 5 - 8) */
> > -	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> > -
> > -	if (!curr ||			/* cases 1 - 4 */
> > -	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> > -		next = vmg->next = vma_lookup(mm, end);
> > -	else
> > -		next = vmg->next = NULL;	/* case 5 */
> > -
> > -	if (prev) {
> > -		vma_start = prev->vm_start;
> > -		vma_pgoff = prev->vm_pgoff;
> > -
> > -		/* Can we merge the predecessor? */
> > -		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
> > -			merge_prev = true;
> > -			vma_prev(vmg->vmi);
> > -		}
> > -	}
> > -
> > -	/* Can we merge the successor? */
> > -	if (next && can_vma_merge_before(vmg)) {
> > -		merge_next = true;
> > -	}
> > -
> > -	/* Verify some invariant that must be enforced by the caller. */
> > -	VM_WARN_ON(prev && addr <= prev->vm_start);
> > -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > -	VM_WARN_ON(addr >= end);
> > -
> > -	if (!merge_prev && !merge_next)
> > -		return NULL; /* Not mergeable. */
> > -
> > -	if (merge_prev)
> > -		vma_start_write(prev);
> > -
> > -	res = vma = prev;
> > -	remove = remove2 = adjust = NULL;
> > -
> > -	/* Can we merge both the predecessor and the successor? */
> > -	if (merge_prev && merge_next &&
> > -	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> > -		vma_start_write(next);
> > -		remove = next;				/* case 1 */
> > -		vma_end = next->vm_end;
> > -		err = dup_anon_vma(prev, next, &anon_dup);
> > -		if (curr) {				/* case 6 */
> > -			vma_start_write(curr);
> > -			remove = curr;
> > -			remove2 = next;
> > -			/*
> > -			 * Note that the dup_anon_vma below cannot overwrite err
> > -			 * since the first caller would do nothing unless next
> > -			 * has an anon_vma.
> > -			 */
> > -			if (!next->anon_vma)
> > -				err = dup_anon_vma(prev, curr, &anon_dup);
> > -		}
> > -	} else if (merge_prev) {			/* case 2 */
> > -		if (curr) {
> > -			vma_start_write(curr);
> > -			if (end == curr->vm_end) {	/* case 7 */
> > -				/*
> > -				 * can_vma_merge_after() assumed we would not be
> > -				 * removing prev vma, so it skipped the check
> > -				 * for vm_ops->close, but we are removing curr
> > -				 */
> > -				if (curr->vm_ops && curr->vm_ops->close)
> > -					err = -EINVAL;
> > -				remove = curr;
> > -			} else {			/* case 5 */
> > -				adjust = curr;
> > -				adj_start = end - curr->vm_start;
> > -			}
> > -			if (!err)
> > -				err = dup_anon_vma(prev, curr, &anon_dup);
> > -		}
> > -	} else { /* merge_next */
> > -		vma_start_write(next);
> > -		res = next;
> > -		if (prev && addr < prev->vm_end) {	/* case 4 */
> > -			vma_start_write(prev);
> > -			vma_end = addr;
> > -			adjust = next;
> > -			adj_start = -(prev->vm_end - addr);
> > -			err = dup_anon_vma(next, prev, &anon_dup);
> > -		} else {
> > -			/*
> > -			 * Note that cases 3 and 8 are the ONLY ones where prev
> > -			 * is permitted to be (but is not necessarily) NULL.
> > -			 */
> > -			vma = next;			/* case 3 */
> > -			vma_start = addr;
> > -			vma_end = next->vm_end;
> > -			vma_pgoff = next->vm_pgoff - pglen;
> > -			if (curr) {			/* case 8 */
> > -				vma_pgoff = curr->vm_pgoff;
> > -				vma_start_write(curr);
> > -				remove = curr;
> > -				err = dup_anon_vma(next, curr, &anon_dup);
> > -			}
> > -		}
> > -	}
> > -
> > -	/* Error in anon_vma clone. */
> > -	if (err)
> > -		goto anon_vma_fail;
> > -
> > -	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
> > -		vma_expanded = true;
> > -
> > -	if (vma_expanded) {
> > -		vma_iter_config(vmg->vmi, vma_start, vma_end);
> > -	} else {
> > -		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> > -				adjust->vm_end);
> > -	}
> > -
> > -	if (vma_iter_prealloc(vmg->vmi, vma))
> > -		goto prealloc_fail;
> > -
> > -	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> > -	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
> > -		   vp.anon_vma != adjust->anon_vma);
> > -
> > -	vma_prepare(&vp);
> > -	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
> > -	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
> > -
> > -	if (vma_expanded)
> > -		vma_iter_store(vmg->vmi, vma);
> > -
> > -	if (adj_start) {
> > -		adjust->vm_start += adj_start;
> > -		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
> > -		if (adj_start < 0) {
> > -			WARN_ON(vma_expanded);
> > -			vma_iter_store(vmg->vmi, next);
> > -		}
> > -	}
> > -
> > -	vma_complete(&vp, vmg->vmi, mm);
> > -	khugepaged_enter_vma(res, vmg->flags);
> > -	return res;
> > -
> > -prealloc_fail:
> > -	if (anon_dup)
> > -		unlink_anon_vmas(anon_dup);
> > -
> > -anon_vma_fail:
> > -	vma_iter_set(vmg->vmi, addr);
> > -	vma_iter_load(vmg->vmi);
> > -	return NULL;
> > -}
> > -
> > -struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> > -{
> > -	return vma_merge(vmg);
> > -}
> > -
> >  /*
> >   * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
> >   * context and anonymous VMA name within the range [start, end).
> > @@ -1280,7 +1270,7 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
> >  	struct vm_area_struct *merged;
> >
> >  	/* First, try to merge. */
> > -	merged = vma_merge(vmg);
> > +	merged = vma_merge_modified(vmg);
> >  	if (merged)
> >  		return merged;
> >
> > diff --git a/mm/vma.h b/mm/vma.h
> > index bbb173053f34..bf29ff569a3d 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -110,12 +110,6 @@ struct vm_area_struct
> >
> >  struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg);
> >
> > -/*
> > - * Temporary wrapper around vma_merge() so we can have a common interface for
> > - * tests.
> > - */
> > -struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg);
> > -
> >  struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  					struct vm_area_struct *vma,
> >  					unsigned long delta);
>

