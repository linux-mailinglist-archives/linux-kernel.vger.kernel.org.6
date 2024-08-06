Return-Path: <linux-kernel+bounces-276307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8DF9491F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C271F2129F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6768620011F;
	Tue,  6 Aug 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eIhBIIRO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fjaWs58D"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402951D6DC4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951905; cv=fail; b=p0+1gPjTW9f34TFhpi7AtUgqBimP+HhulP91PHySKVrGbi1wazl8keQ9DywEO/Vh7qNb+3MNDUr2HNAA4lUBPOixC6arDolzboVIyruq1KefFkUTfbJ/Y98gq4OLxPMvPE0cTPuao6cJLZho7CyzNmlP7cBbsxo3ddqCVVDdlGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951905; c=relaxed/simple;
	bh=sNzJOXWj4/adVNxs1Cv3Qyd5Kz+ij8EaFG1nHNajmaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CowC0QFVccROenqyB3XgMO5kXFcwj6UagXs9LNteMen4DnjhD64ie00xk4knSyXwZqYZkgy8SUK5vXTdAlEZU5z3PDGg6jsVNU0BLVeS14MQFkiDvMx1iVywSSmS8pLEwgVQfAZ2m6P40rZH7rwHkIBsIHP34RbEGpz+xvb8RJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eIhBIIRO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fjaWs58D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765kmT2001388;
	Tue, 6 Aug 2024 13:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=gpfiZq6aC4WFvE2RsvDSWWJfFQUaGEy6FZxeBBO7pf4=; b=
	eIhBIIROwnQnWbJjVYk0iYCqEtThvermYO3X3iH38LBbY4TokZRxZ0J41A+va+PS
	rvVIJj/bd0P1ql3f0LJcRZ2pZ8CU3UcDGJiW/RESDUVAkx2Pk069UcEkPvOlwb3L
	sULkjjIKwl77qN+CsNnyuSQVuGN9EHQ63Z6dAWJiDouELQhXHfyza361A1zJoqxk
	XWtKLSlJ4coBuINOxID9qLsTeSZ8LngnDuTNJ15w0CttgsDRklaCV0L1/KdXhh9p
	neeBzR6aE18NqUZf6MLKqeYqjQItRoDfuij+zriTxut+F7iWFdaYv/8qwt1W1bmS
	QlszTObOK8c0kuvNDqsu1A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfanctb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 13:44:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476DMc2Y019764;
	Tue, 6 Aug 2024 13:44:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08nv24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 13:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cacmlsHQ70o21e25WrzSR+574qF/XmNxHGAPw6Tqs8oFI2vc2UxeRZKGu2bwV/3T2Wo+9cdMH1e+MMCikwYsi34t3NiDx326xqYMmdNw/JVn4ksEpS1zMd4q49o1W/hMIkJkqDvcQy3BNGf1N5cckNrCBkVLSuFj8vS4Eb/Kcy2Wd8ySDI4CK+fW1R2QxSHYNh2IlWaclpOqmEkGFAbue33n9Cv7jG2L71V+xIt7CEnzGCHqcdfT0FOL026JYvn5dMY7En6V4K8YCa/gjvxFXZm/Yv55zrCEvxWnhR773tdpt3whlbgAFHsa9Akg0VUgoTYPCpq+WVCRv4IZM6qf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpfiZq6aC4WFvE2RsvDSWWJfFQUaGEy6FZxeBBO7pf4=;
 b=XeUM1rRq6ZoWqF3LHDa9CzD7JFw01143tyYTT5kQckQx3I11Lal8nEn197N3r4n37lMDB8bZUIGaACMEicbpSNqIFFCmyUVIlI3zUjC9yn7Z5Copl4ySyF6FtvwSv7/HgWBQ83ZSH8E98kcRrl8p3MpjEzzvv77HtPaP99NwNUas0q4p7ngVCX/qiRnkPaRayYq+5qAF2JM+xLVSkobnhym4MyiaTgVun0c2wacX4sAb7hP/3MGGmqvUjj+gD1AU5oPkKUQajt2FtnChKMVKIkjNkfee7n7fnX8gBUEMqnN/UyrWjesjArSKbYQfrOmcunWM+KDm4lpzzUwZ+1RAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpfiZq6aC4WFvE2RsvDSWWJfFQUaGEy6FZxeBBO7pf4=;
 b=fjaWs58DcLZfkTlQN1SCzlBshvq7noJ2Lm17zopXtZqrwFGu3wsQ9+31tuUdY98YxT+wtamwjB79gaA3Yad24EegK7+bsv/QMQS4YXGsAJUXBtsw4tttSZB56Dq30qjGymHyph8sTl/BsZTK1U0YpsBughHv+s0pAP1p7OYuVFs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH4PR10MB8145.namprd10.prod.outlook.com (2603:10b6:610:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 13:44:49 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:44:49 +0000
Date: Tue, 6 Aug 2024 14:44:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <938b7626-4f0e-46d9-a6c0-e06a68e2ab1f@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
 <20240806150422.2aa2354e@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806150422.2aa2354e@mordecai.tesarici.cz>
X-ClientProxiedBy: LO4P123CA0219.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH4PR10MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: ff102c95-6c86-478c-2a9b-08dcb61df0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FLMDgxczVldmZCWEFRcDhlRkhZbFhmbUNVQys2N2d6aFJXZngvWmZQbEtS?=
 =?utf-8?B?cXR4K3ZEeWEzM2kyK21VNDRmSkFjQnZzWmJTdzA4ZjI5eStEUWQvekJuTFpF?=
 =?utf-8?B?MzZmcGNzQmoyREdKTGdOMlk0NUlBZ0dTU1VrRDVvTTZyV05NQ0QrbDgrZ28x?=
 =?utf-8?B?QXcyQUZkZEg3YXVNWnNzbzlLeDB1M1dNQk5uVmhLOU93OHpzU1RRV1BJUWty?=
 =?utf-8?B?SzZsSE1jYXJGamoyZExkQmduajNpbnJuL2FacWloRlljbHl0dktVUEJHbXJS?=
 =?utf-8?B?ZHMxTlZLZXAwQlF2c0VxWTdxVUowQ2NJVGVya2FCYVQ1dUN2bVdiSE1WL0dw?=
 =?utf-8?B?NkFoNXBCNm1yZlBkU09ua3B3WWUxeU9KUEZSNVAwU1RkWFZ4eGV1SUhEejJL?=
 =?utf-8?B?QjdIYUVSRDN3VU9id1dIS1Fvei84T0tEYkttWDdrdTFlTi9HeHgzLzdZUkc2?=
 =?utf-8?B?OGJmN2NjOXNlR3ZGU0liUkxTUmpqdE9MOEh1NXFCRngzdlJWUXhSODRIbk9Y?=
 =?utf-8?B?YWoxeStTSVdxZmdtQSs1bXJ1YTRkN1N1VndBck5LZDlOOUxJcHdEcVNTUUZh?=
 =?utf-8?B?WDMzYy9tVWdYazgyQ3NudWsyQkdIVDlGd0oyZVA1SVFYQWRRcnVSSGZzQUVL?=
 =?utf-8?B?WFY4ZG1WY3UzbndKbjFLODN4TGQ2QW5MektiNlFUaHhDU2VCdlRXZ2M4SjBL?=
 =?utf-8?B?Y256U3RVZFQzUHB3Q2dSY0huM3E0M1BDWnNrSkNnYTdoL2h2ZGpKMjdYOGM0?=
 =?utf-8?B?eDZtSFNVeHVEVUZEWEFxMHlRRENGMXJCT2haV1k5bDJoMGhraFdrdVVlZGxr?=
 =?utf-8?B?UjBBSTV3RU9UeG1kdkhhQ0Qrb2xDdEhTNUFUWFBoQ3ZWQVd0cGc5b01JbEo5?=
 =?utf-8?B?SmttN0MwSStsTUN3K1hYOWZIakZzOE84T281Ym1xbGI3amtpV05yMWJlb2Z4?=
 =?utf-8?B?ejRLemp5UFBtNWRYd3FGczdrdzBNM2xKbEJmVmcybzduRVBlNXZYWUh0cGVI?=
 =?utf-8?B?eGx0elk5T25Ccys2RUhLTlYzR0RKTUtIWHZiU29EbWc2ekRWZ0xCUnlONFRh?=
 =?utf-8?B?THNJWlRpUjg5SnlkcUlHOWFTS0J5M09kRHFSVDF5MGl0Y0FwQXpOYVREVUhX?=
 =?utf-8?B?ZVU1d1EzZ1pkZmFycm9PVXBEVUNXREtpM1NPKzFoN0crZjhoeXJOLy9TbHdr?=
 =?utf-8?B?cWdxUWVTSlZjUmtvNCtmZ01oWjBkTEJsZktuamp1SGs1NGtBU095d0QrbFh2?=
 =?utf-8?B?TFFEQnFsVWJtKy8rMXpMV3BWS3d0Wkd1aTdiRlFJcGV6V2l1UzVkTWJLbEEv?=
 =?utf-8?B?Z1dHMzRLZHZMaVlOZ1FmZGs5Q1lOWHIzVEE5bC9kdGVFWENlTFY0aVo3TDlV?=
 =?utf-8?B?RTRPTFR5NlhOYnF0U1RQdlp6b0YxbWd3UytGUmtmZDU5OHh6MWNkYVBnRG52?=
 =?utf-8?B?aFB0WHZoNkRWNUk1SXF0cHZPaFFOVWR6eGd0Zit3THdDeVhOWTc3YWtVaUh6?=
 =?utf-8?B?Q21KUlM3azFQci9jR0lLTy9ZeWVUU3VzZU1qb1FFeGI2ZC8zaTlxNWJhSmdT?=
 =?utf-8?B?OUlaZkdGN2tZZE45R3JZNmhEeldxdnBlenA3dmNqZmx0cEFXbnlycjhzd2VO?=
 =?utf-8?B?aStuNEVqTFRNdjZOYW1HMVVnWlFoZlJSSHdIUUZLZ2E1MlRHM2Y0elMxMGVN?=
 =?utf-8?B?Q0Y0dFhrY0V0dGh3TTBrZEJUc1VXV3lpcEJ5U2x5WWl2UmN0dWNMM1hnRVZI?=
 =?utf-8?B?UkJQQ3BOaVY1Q2ErK2Ewa0NKOGN3Q21obGI3ZGRsZTNwWVRhNVl3bnJVb0sv?=
 =?utf-8?B?MXk2enYyc1AwYzZJMFYyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjZCZ3JCNVZUOHlvZ2tORG02bEZjb1lQYzFiaFQrRGxYdVdkTkZoTGY0MEht?=
 =?utf-8?B?enFwai9yQjVUWDZuT0ZYVWVUTjJrcytBb00vd004cFVXa2xsSnhDekJaRTNh?=
 =?utf-8?B?M0cxK3hEQ1NTdEZhb01oQ09JY3hhTkFBc0RQYmd3VmlTTmYwM1lzaHl0TC9P?=
 =?utf-8?B?ZFFhc3pMUkpWcTlxSXZteGZNZUhTWXdUZ2tJak1BVWExNUVHM1RWNlZjVEN3?=
 =?utf-8?B?aEovdm5NU3IrQTJFcE52aXFZZjkwQnU4aWNkSUFOVTVUL091Zm80UGM0TXdE?=
 =?utf-8?B?ZjJ1UE91REdQUkVLOGpxYUxVMm8zcEJ5bnhVeklmN2hZRnI1UDVpemN5dmV3?=
 =?utf-8?B?d3BiWGtwclJJdXIzRlp5S002cnhKbStyb0hDZzdKbGhrWHprRlB3T095eHRo?=
 =?utf-8?B?VmJIV0V5NlowME53N0NNMWJNRDhJZ0kzTzFiWjZNZUJvOTdaWW0zNUZzMWRW?=
 =?utf-8?B?TDdsSnU0OU9EMEkwY1FGblRIY0lkYmt4RHZxT21ZQk9NNUJOb08waHFVOFNE?=
 =?utf-8?B?MVo4ZTJQQ0plY1VNQ0x6Ti9ZMlc0SzFiaEZmdDFoeHY4OGxEVjE3YUgyaEdF?=
 =?utf-8?B?NFI4WFM4UzhhZXh3TElVK0xNSi8yWG11U2E1aFNvTTVqWUpTWmtRR2E1Tkpa?=
 =?utf-8?B?N0tUNEVES05TYVJxUGZueWhMODR4dzBDWEMvNHdSZ3lXckIxRzJrYlpxTDJ6?=
 =?utf-8?B?dHVyVEJuakVqRXpmL0VEMEpWbWZXODc0Zk5vV3RBcFhjeGFZWTBER2pqT0tp?=
 =?utf-8?B?M1ljUmpHc0dVU2ZGRXdZNWUvaEpXaHkxVlYxeG1iOUhIUFh6ZkhkZVY4TDRY?=
 =?utf-8?B?bFJtd3dtOUZ4ZDFrYkgvSkU5aUh2TGZPSnUyU29JTmtlb282eWd3ZjNFMG1U?=
 =?utf-8?B?VndKbC9Ub1N5TDZ0VFZpeldrM054ejhEdi8rNHNGRE41MlNmYmFhWVYycVJY?=
 =?utf-8?B?VmRJd1RnUXo1a2hwR2dJUUVySXBXQlJQVGQvNnVRQ0labnhlb2FwYXpKZTdR?=
 =?utf-8?B?OFp6MkZNZnZYRGtCcldZaWduYzBmTG4xTlowTi9MbmRQLys4RzJleEJ2Z0R5?=
 =?utf-8?B?Y0FkbnVlcW9qaGxEZFVHOWphWU9IOWpGdm4rcmlPWlZ2TFdVOElFY21PVUdU?=
 =?utf-8?B?MlVZS0QwTHdsWnRhZzc5bmlIcFhibDg4NlJsRTdndWdjZ0Y0MG1abC9QU3g1?=
 =?utf-8?B?TFlqRHdEOGZneUhKN05rdmVXUmxhcWFnK2dxa3hVYzJWb0dvNWlLc1BoL3lv?=
 =?utf-8?B?aUk3U0JhRTZXVHZVUVdESHN4TVFhaDVFcU1yVEM2eWJ1cC84UDJ3VmtoQmxO?=
 =?utf-8?B?K09kZVgyMUFvMFVQU1BMQmoybTM4YXZTWUtocmowMWViUE56VW8zdXladGpr?=
 =?utf-8?B?Y0w1bmxLNWxQR2tRKzFxR2JzbGtNTy9yMkJlVWNJUnpZQjNycjIvK3RlNnJG?=
 =?utf-8?B?SlVZUjIyV1RnQlFGK2VCNWpPTnBYWXVlTGRuak9TQXUrdUltWFZBd0o0WXRp?=
 =?utf-8?B?ejlwUlpDTXR5NFA5R3R2aGkrMDlhY29wYnRyWVhIMkdRWVFKODF4V0MwWXZ6?=
 =?utf-8?B?aEFtS1VIZ2xaMENRRlU5TmZhZ0ZoR0ZLWWhyaXAxNHpVYTJ2Sk5sRHhyVFZu?=
 =?utf-8?B?V29wcTJYK0dvNWU0Qk85MlQ4cG5DMjgrNzVXd1V1TjZrY2kyclJrWENLZ1Js?=
 =?utf-8?B?Tm1uWU5HWjhzSWk4RWFtSGdPMEIzZnJVa0ZFbDBaemtJL0Jldk9IazVXT1Jz?=
 =?utf-8?B?K3R3OExvMXJ1Nk9QOTBpVXlTT2xSMDBMTVJrRXJXcDhhUmRvRFFEbVRZUEE5?=
 =?utf-8?B?NUdOZVJBSnpvUDBxNytuM215eEcwWHZua1JORTZISGpFR2J3NDZhYVBkZG1j?=
 =?utf-8?B?L1VFZUVOOFVBY2tQN2JUQVNTTmJ0Vm02SGVnTUhqcEM5ekxUdHJDR3EwWWFm?=
 =?utf-8?B?YXM3Q2pSVFZhbXQ5VFliakhudi8vUlFmclVlWXlhZ0ExbXA3T0xBTU5MOUdC?=
 =?utf-8?B?SFNaRFgwcVhpTWhSS1RGNXJpL0c5MmFoNVY3TG5hclM4bEFGSCtYMU9PL1VM?=
 =?utf-8?B?cFhzRU1Ca05uNTJzQ0paeGxKZ095YTJEM2xtWHY3VnBFL2ZGZGVoNnBvWlJo?=
 =?utf-8?B?SDdGbVFYQTM4STZKbGoySFlvbU8xYnZxOTJTTEt4eVBadmlyckY3VlNSWmE3?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QjJHcGgDTyQFMRMOzt84lLoB0TQRJmtCLYHHAPHMDMQg5oqx4YAVAXds2ibr+3boaXhUf39kfNVfL57//p9t7WJopFdu9YQ1qL6bBPfUo/BgvnZGvCoWe2f/UScnOYUGhRWOVX2uVyRF2sEqtxjOE8n3JApDeLx2EeICi9vRoF7ev5cd8BLxqeSoBveYFExblE+6/qSDVfeu+mK5deMo+kOkmZKHM2CYIWVOHk/kdw3eLFsDjyKR1/cLQtWOt8yYub7Th5qlHS/jdUAM/4I9w3iC/Sqn9Yfke0hPdaxwGSSLXVWziJZOcQ0pQFXb3GV3uDpsff+o+H6x+tCMuIkqDu5Llu2Y5m4CmVKOH6SQSQoFb/brekPzFNXGUS3bsSdtLsMevOqnIum7z7roWug8mgzFvh92X6UMtLAaJYlydwv1/Tjxmaz3UWw22gO0b8s8Lp0X9WzRzIyphMUcIC11sDr3ojcuUDI4jAEZ2nOvOfyZiXSlb/bHaA26Cm8z/gFlboZ5qc0iRx0KPxLyvBlZwdqYgtD9DP3BsnzYyOMJx1Xsb+wqEVb5SsG3rQvBhK6GDyxIN226AQZlmzwDIdg3p8fAEh7ZoXWn7Yuk8qvA3T0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff102c95-6c86-478c-2a9b-08dcb61df0b1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:44:49.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksx1SYPeCsBr95DXAYm2UoXDVApIEdTsSnPsOMzv69NOKjMDCJCD3Kjes1TgufIv751nXFHGPyRZgYYeOaqMLDZwKtJD4z9MkHwEw3xsBmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408060095
X-Proofpoint-GUID: rn6cr27SvxedAQzUokaN7nt2wJiRiW22
X-Proofpoint-ORIG-GUID: rn6cr27SvxedAQzUokaN7nt2wJiRiW22

On Tue, Aug 06, 2024 at 03:04:22PM GMT, Petr Tesařík wrote:
> On Mon,  5 Aug 2024 13:13:54 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> > to use vma_expand() rather than invoke a full vma_merge() operation.
> >
> > Abstract this logic and eliminate all of the open-coding, and also use the
> > same logic for all cases where we add new VMAs to, rather than ultimately
> > use vma_merge(), rather use vma_expand().
> >
> > We implement this by replacing vma_merge_new_vma() with this newly
> > abstracted logic.
> >
> > Doing so removes duplication and simplifies VMA merging in all such cases,
> > laying the ground for us to eliminate the merging of new VMAs in
> > vma_merge() altogether.
> >
> > This makes it far easier to understand what is happening in these cases
> > avoiding confusion, bugs and allowing for future optimisation.
> >
> > As a result of this change we are also able to make vma_prepare(),
> > init_vma_prep(), vma_complete(), can_vma_merge_before() and
> > can_vma_merge_after() static and internal to vma.c.
>
> This patch truly rocks. Let me just say: Wow!

Thanks!

>
> Petr T
>
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c                        |  79 ++---
> >  mm/vma.c                         | 482 +++++++++++++++++++------------
> >  mm/vma.h                         |  51 +---
> >  tools/testing/vma/vma_internal.h |   6 +
> >  4 files changed, 324 insertions(+), 294 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index f6593a81f73d..c03f50f46396 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1363,8 +1363,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma = NULL;
> > -	struct vm_area_struct *next, *prev, *merge;
> > -	pgoff_t pglen = len >> PAGE_SHIFT;
> > +	struct vm_area_struct *merge;
> >  	unsigned long charged = 0;
> >  	unsigned long end = addr + len;
> >  	bool writable_file_mapping = false;
> > @@ -1411,44 +1410,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > -	next = vmg.next = vma_next(&vmi);
> > -	prev = vmg.prev = vma_prev(&vmi);
> > -	if (vm_flags & VM_SPECIAL) {
> > -		if (prev)
> > -			vma_iter_next_range(&vmi);
> > -		goto cannot_expand;
> > -	}
> > -
> > -	/* Attempt to expand an old mapping */
> > -	/* Check next */
> > -	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> > -		/* We can adjust this as can_vma_merge_after() doesn't touch */
> > -		vmg.end = next->vm_end;
> > -		vma = vmg.vma = next;
> > -		vmg.pgoff = next->vm_pgoff - pglen;
> > -
> > -		/* We may merge our NULL anon_vma with non-NULL in next. */
> > -		vmg.anon_vma = vma->anon_vma;
> > -	}
> > -
> > -	/* Check prev */
> > -	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> > -		vmg.start = prev->vm_start;
> > -		vma = vmg.vma = prev;
> > -		vmg.pgoff = prev->vm_pgoff;
> > -	} else if (prev) {
> > -		vma_iter_next_range(&vmi);
> > -	}
> > -
> > -	/* Actually expand, if possible */
> > -	if (vma && !vma_expand(&vmg)) {
> > -		khugepaged_enter_vma(vma, vm_flags);
> > +	vma = vma_merge_new_vma(&vmg);
> > +	if (vma)
> >  		goto expanded;
> > -	}
> > -
> > -	if (vma == prev)
> > -		vma_iter_set(&vmi, addr);
> > -cannot_expand:
> >
> >  	/*
> >  	 * Determine the object being mapped and call the appropriate
> > @@ -1493,10 +1457,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		 * If vm_flags changed after call_mmap(), we should try merge
> >  		 * vma again as we may succeed this time.
> >  		 */
> > -		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> > -			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
> > -							  vma->vm_start, vma->vm_end,
> > -							  vma->vm_pgoff);
> > +		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > +			merge = vma_merge_new_vma(&vmg);
> > +
> >  			if (merge) {
> >  				/*
> >  				 * ->mmap() can change vma->vm_file and fput
> > @@ -1596,7 +1559,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  		vma_iter_set(&vmi, vma->vm_end);
> >  		/* Undo any partial mapping done by a device driver. */
> > -		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
> > +		unmap_region(mm, &vmi.mas, vma, vmg.prev, vmg.next, vma->vm_start,
> >  			     vma->vm_end, vma->vm_end, true);
> >  	}
> >  	if (writable_file_mapping)
> > @@ -1773,7 +1736,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		unsigned long addr, unsigned long len, unsigned long flags)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > -	struct vma_prepare vp;
> >
> >  	/*
> >  	 * Check against address space limits by the changed size
> > @@ -1795,29 +1757,22 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	 */
> >  	if (vma && vma->vm_end == addr) {
> >  		struct vma_merge_struct vmg = {
> > +			.vmi = vmi,
> >  			.prev = vma,
> > +			.next = NULL,
> > +			.start = addr,
> > +			.end = addr + len,
> >  			.flags = flags,
> >  			.pgoff = addr >> PAGE_SHIFT,
> > +			.file = vma->vm_file,
> > +			.anon_vma = vma->anon_vma,
> > +			.policy = vma_policy(vma),
> > +			.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +			.anon_name = anon_vma_name(vma),
> >  		};
> >
> > -		if (can_vma_merge_after(&vmg)) {
> > -			vma_iter_config(vmi, vma->vm_start, addr + len);
> > -			if (vma_iter_prealloc(vmi, vma))
> > -				goto unacct_fail;
> > -
> > -			vma_start_write(vma);
> > -
> > -			init_vma_prep(&vp, vma);
> > -			vma_prepare(&vp);
> > -			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > -			vma->vm_end = addr + len;
> > -			vm_flags_set(vma, VM_SOFTDIRTY);
> > -			vma_iter_store(vmi, vma);
> > -
> > -			vma_complete(&vp, vmi, mm);
> > -			khugepaged_enter_vma(vma, flags);
> > +		if (vma_merge_new_vma(&vmg))
> >  			goto out;
> > -		}
> >  	}
> >
> >  	if (vma)
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 55615392e8d2..a404cf718f9e 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -97,8 +97,7 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
> >   *
> >   * We assume the vma may be removed as part of the merge.
> >   */
> > -bool
> > -can_vma_merge_before(struct vma_merge_struct *vmg)
> > +static bool can_vma_merge_before(struct vma_merge_struct *vmg)
> >  {
> >  	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> >
> > @@ -120,7 +119,7 @@ can_vma_merge_before(struct vma_merge_struct *vmg)
> >   *
> >   * We assume that vma is not removed as part of the merge.
> >   */
> > -bool can_vma_merge_after(struct vma_merge_struct *vmg)
> > +static bool can_vma_merge_after(struct vma_merge_struct *vmg)
> >  {
> >  	if (is_mergeable_vma(vmg, false) &&
> >  	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> > @@ -130,6 +129,164 @@ bool can_vma_merge_after(struct vma_merge_struct *vmg)
> >  	return false;
> >  }
> >
> > +static void __vma_link_file(struct vm_area_struct *vma,
> > +			    struct address_space *mapping)
> > +{
> > +	if (vma_is_shared_maywrite(vma))
> > +		mapping_allow_writable(mapping);
> > +
> > +	flush_dcache_mmap_lock(mapping);
> > +	vma_interval_tree_insert(vma, &mapping->i_mmap);
> > +	flush_dcache_mmap_unlock(mapping);
> > +}
> > +
> > +/*
> > + * Requires inode->i_mapping->i_mmap_rwsem
> > + */
> > +static void __remove_shared_vm_struct(struct vm_area_struct *vma,
> > +				      struct address_space *mapping)
> > +{
> > +	if (vma_is_shared_maywrite(vma))
> > +		mapping_unmap_writable(mapping);
> > +
> > +	flush_dcache_mmap_lock(mapping);
> > +	vma_interval_tree_remove(vma, &mapping->i_mmap);
> > +	flush_dcache_mmap_unlock(mapping);
> > +}
> > +
> > +/*
> > + * vma_prepare() - Helper function for handling locking VMAs prior to altering
> > + * @vp: The initialized vma_prepare struct
> > + */
> > +static void vma_prepare(struct vma_prepare *vp)
> > +{
> > +	if (vp->file) {
> > +		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
> > +
> > +		if (vp->adj_next)
> > +			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
> > +				      vp->adj_next->vm_end);
> > +
> > +		i_mmap_lock_write(vp->mapping);
> > +		if (vp->insert && vp->insert->vm_file) {
> > +			/*
> > +			 * Put into interval tree now, so instantiated pages
> > +			 * are visible to arm/parisc __flush_dcache_page
> > +			 * throughout; but we cannot insert into address
> > +			 * space until vma start or end is updated.
> > +			 */
> > +			__vma_link_file(vp->insert,
> > +					vp->insert->vm_file->f_mapping);
> > +		}
> > +	}
> > +
> > +	if (vp->anon_vma) {
> > +		anon_vma_lock_write(vp->anon_vma);
> > +		anon_vma_interval_tree_pre_update_vma(vp->vma);
> > +		if (vp->adj_next)
> > +			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
> > +	}
> > +
> > +	if (vp->file) {
> > +		flush_dcache_mmap_lock(vp->mapping);
> > +		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
> > +		if (vp->adj_next)
> > +			vma_interval_tree_remove(vp->adj_next,
> > +						 &vp->mapping->i_mmap);
> > +	}
> > +
> > +}
> > +
> > +/*
> > + * vma_complete- Helper function for handling the unlocking after altering VMAs,
> > + * or for inserting a VMA.
> > + *
> > + * @vp: The vma_prepare struct
> > + * @vmi: The vma iterator
> > + * @mm: The mm_struct
> > + */
> > +static void vma_complete(struct vma_prepare *vp,
> > +			 struct vma_iterator *vmi, struct mm_struct *mm)
> > +{
> > +	if (vp->file) {
> > +		if (vp->adj_next)
> > +			vma_interval_tree_insert(vp->adj_next,
> > +						 &vp->mapping->i_mmap);
> > +		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
> > +		flush_dcache_mmap_unlock(vp->mapping);
> > +	}
> > +
> > +	if (vp->remove && vp->file) {
> > +		__remove_shared_vm_struct(vp->remove, vp->mapping);
> > +		if (vp->remove2)
> > +			__remove_shared_vm_struct(vp->remove2, vp->mapping);
> > +	} else if (vp->insert) {
> > +		/*
> > +		 * split_vma has split insert from vma, and needs
> > +		 * us to insert it before dropping the locks
> > +		 * (it may either follow vma or precede it).
> > +		 */
> > +		vma_iter_store(vmi, vp->insert);
> > +		mm->map_count++;
> > +	}
> > +
> > +	if (vp->anon_vma) {
> > +		anon_vma_interval_tree_post_update_vma(vp->vma);
> > +		if (vp->adj_next)
> > +			anon_vma_interval_tree_post_update_vma(vp->adj_next);
> > +		anon_vma_unlock_write(vp->anon_vma);
> > +	}
> > +
> > +	if (vp->file) {
> > +		i_mmap_unlock_write(vp->mapping);
> > +		uprobe_mmap(vp->vma);
> > +
> > +		if (vp->adj_next)
> > +			uprobe_mmap(vp->adj_next);
> > +	}
> > +
> > +	if (vp->remove) {
> > +again:
> > +		vma_mark_detached(vp->remove, true);
> > +		if (vp->file) {
> > +			uprobe_munmap(vp->remove, vp->remove->vm_start,
> > +				      vp->remove->vm_end);
> > +			fput(vp->file);
> > +		}
> > +		if (vp->remove->anon_vma)
> > +			anon_vma_merge(vp->vma, vp->remove);
> > +		mm->map_count--;
> > +		mpol_put(vma_policy(vp->remove));
> > +		if (!vp->remove2)
> > +			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> > +		vm_area_free(vp->remove);
> > +
> > +		/*
> > +		 * In mprotect's case 6 (see comments on vma_merge),
> > +		 * we are removing both mid and next vmas
> > +		 */
> > +		if (vp->remove2) {
> > +			vp->remove = vp->remove2;
> > +			vp->remove2 = NULL;
> > +			goto again;
> > +		}
> > +	}
> > +	if (vp->insert && vp->file)
> > +		uprobe_mmap(vp->insert);
> > +	validate_mm(mm);
> > +}
> > +
> > +/*
> > + * init_vma_prep() - Initializer wrapper for vma_prepare struct
> > + * @vp: The vma_prepare struct
> > + * @vma: The vma that will be altered once locked
> > + */
> > +static void init_vma_prep(struct vma_prepare *vp,
> > +			  struct vm_area_struct *vma)
> > +{
> > +	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> > +}
> > +
> >  /*
> >   * Close a vm structure and free it.
> >   */
> > @@ -292,31 +449,6 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
> >  	vm_unacct_memory(nr_accounted);
> >  }
> >
> > -/*
> > - * init_vma_prep() - Initializer wrapper for vma_prepare struct
> > - * @vp: The vma_prepare struct
> > - * @vma: The vma that will be altered once locked
> > - */
> > -void init_vma_prep(struct vma_prepare *vp,
> > -		   struct vm_area_struct *vma)
> > -{
> > -	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> > -}
> > -
> > -/*
> > - * Requires inode->i_mapping->i_mmap_rwsem
> > - */
> > -static void __remove_shared_vm_struct(struct vm_area_struct *vma,
> > -				      struct address_space *mapping)
> > -{
> > -	if (vma_is_shared_maywrite(vma))
> > -		mapping_unmap_writable(mapping);
> > -
> > -	flush_dcache_mmap_lock(mapping);
> > -	vma_interval_tree_remove(vma, &mapping->i_mmap);
> > -	flush_dcache_mmap_unlock(mapping);
> > -}
> > -
> >  /*
> >   * vma has some anon_vma assigned, and is already inserted on that
> >   * anon_vma's interval trees.
> > @@ -349,60 +481,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
> >  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
> >  }
> >
> > -static void __vma_link_file(struct vm_area_struct *vma,
> > -			    struct address_space *mapping)
> > -{
> > -	if (vma_is_shared_maywrite(vma))
> > -		mapping_allow_writable(mapping);
> > -
> > -	flush_dcache_mmap_lock(mapping);
> > -	vma_interval_tree_insert(vma, &mapping->i_mmap);
> > -	flush_dcache_mmap_unlock(mapping);
> > -}
> > -
> > -/*
> > - * vma_prepare() - Helper function for handling locking VMAs prior to altering
> > - * @vp: The initialized vma_prepare struct
> > - */
> > -void vma_prepare(struct vma_prepare *vp)
> > -{
> > -	if (vp->file) {
> > -		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
> > -
> > -		if (vp->adj_next)
> > -			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
> > -				      vp->adj_next->vm_end);
> > -
> > -		i_mmap_lock_write(vp->mapping);
> > -		if (vp->insert && vp->insert->vm_file) {
> > -			/*
> > -			 * Put into interval tree now, so instantiated pages
> > -			 * are visible to arm/parisc __flush_dcache_page
> > -			 * throughout; but we cannot insert into address
> > -			 * space until vma start or end is updated.
> > -			 */
> > -			__vma_link_file(vp->insert,
> > -					vp->insert->vm_file->f_mapping);
> > -		}
> > -	}
> > -
> > -	if (vp->anon_vma) {
> > -		anon_vma_lock_write(vp->anon_vma);
> > -		anon_vma_interval_tree_pre_update_vma(vp->vma);
> > -		if (vp->adj_next)
> > -			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
> > -	}
> > -
> > -	if (vp->file) {
> > -		flush_dcache_mmap_lock(vp->mapping);
> > -		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
> > -		if (vp->adj_next)
> > -			vma_interval_tree_remove(vp->adj_next,
> > -						 &vp->mapping->i_mmap);
> > -	}
> > -
> > -}
> > -
> >  /*
> >   * dup_anon_vma() - Helper function to duplicate anon_vma
> >   * @dst: The destination VMA
> > @@ -486,6 +564,120 @@ void validate_mm(struct mm_struct *mm)
> >  }
> >  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
> >
> > +/*
> > + * vma_merge_new_vma - Attempt to merge a new VMA into address space
> > + *
> > + * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
> > + *       (exclusive), which we try to merge with any adjacent VMAs if possible.
> > + *
> > + * We are about to add a VMA to the address space starting at @vmg->start and
> > + * ending at @vmg->end. There are three different possible scenarios:
> > + *
> > + * 1. There is a VMA with identical properties immediately adjacent to the
> > + *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
> > + *    EXPAND that VMA:
> > + *
> > + * Proposed:       |-----|  or  |-----|
> > + * Existing:  |----|                  |----|
> > + *
> > + * 2. There are VMAs with identical properties immediately adjacent to the
> > + *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
> > + *    EXPAND the former and REMOVE the latter:
> > + *
> > + * Proposed:       |-----|
> > + * Existing:  |----|     |----|
> > + *
> > + * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
> > + *    VMAs do not have identical attributes - NO MERGE POSSIBLE.
> > + *
> > + * In instances where we can merge, this function returns the expanded VMA which
> > + * will have its range adjusted accordingly and the underlying maple tree also
> > + * adjusted.
> > + *
> > + * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
> > + *          to the VMA we expanded.
> > + *
> > + * This function also adjusts @vmg to provide @vmg->prev and @vmg->next if
> > + * neither already specified, and adjusts [@vmg->start, @vmg->end) to span the
> > + * expanded range.
> > + *
> > + * ASSUMPTIONS:
> > + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> > + * - The caller must have determined that [@vmg->start, @vmg->end) is empty.
> > + */
> > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > +{
> > +	bool is_special = vmg->flags & VM_SPECIAL;
> > +	struct vm_area_struct *prev = vmg->prev;
> > +	struct vm_area_struct *next = vmg->next;
> > +	unsigned long start = vmg->start;
> > +	unsigned long end = vmg->end;
> > +	pgoff_t pgoff = vmg->pgoff;
> > +	pgoff_t pglen = PHYS_PFN(end - start);
> > +
> > +	VM_WARN_ON(vmg->vma);
> > +
> > +	if (!prev && !next) {
> > +		/*
> > +		 * Since the caller must have determined that the requested
> > +		 * range is empty, vmg->vmi will be left pointing at the VMA
> > +		 * immediately prior.
> > +		 */
> > +		next = vmg->next = vma_next(vmg->vmi);
> > +		prev = vmg->prev = vma_prev(vmg->vmi);
> > +
> > +		/* Avoid maple tree re-walk. */
> > +		if (is_special && prev)
> > +			vma_iter_next_range(vmg->vmi);
> > +	}
> > +
> > +	/* If special mapping or no adjacent VMAs, nothing to merge. */
> > +	if (is_special || (!prev && !next))
> > +		return NULL;
> > +
> > +	/* If we can merge with the following VMA, adjust vmg accordingly. */
> > +	if (next && next->vm_start == end && can_vma_merge_before(vmg)) {
> > +		/*
> > +		 * We can adjust this here as can_vma_merge_after() doesn't
> > +		 * touch vmg->end.
> > +		 */
> > +		vmg->end = next->vm_end;
> > +		vmg->vma = next;
> > +		vmg->pgoff = next->vm_pgoff - pglen;
> > +
> > +		vmg->anon_vma = next->anon_vma;
> > +	}
> > +
> > +	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> > +	if (prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> > +		vmg->start = prev->vm_start;
> > +		vmg->vma = prev;
> > +		vmg->pgoff = prev->vm_pgoff;
> > +	} else if (prev) {
> > +		vma_iter_next_range(vmg->vmi);
> > +	}
> > +
> > +	/*
> > +	 * Now try to expand adjacent VMA(s). This takes care of removing the
> > +	 * following VMA if we have VMAs on both sides.
> > +	 */
> > +	if (vmg->vma && !vma_expand(vmg)) {
> > +		khugepaged_enter_vma(vmg->vma, vmg->flags);
> > +		return vmg->vma;
> > +	}
> > +
> > +	/* If expansion failed, reset state. Allows us to retry merge later. */
> > +	vmg->vma = NULL;
> > +	vmg->anon_vma = NULL;
> > +	vmg->start = start;
> > +	vmg->end = end;
> > +	vmg->pgoff = pgoff;
> > +	if (vmg->vma == prev)
> > +		vma_iter_set(vmg->vmi, start);
> > +
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * vma_expand - Expand an existing VMA
> >   *
> > @@ -496,7 +688,11 @@ void validate_mm(struct mm_struct *mm)
> >   * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
> >   * vmg->next needs to be handled by the caller.
> >   *
> > - * Returns: 0 on success
> > + * Returns: 0 on success.
> > + *
> > + * ASSUMPTIONS:
> > + * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
> > + * - The caller must have set @vmg->prev and @vmg->next.
> >   */
> >  int vma_expand(struct vma_merge_struct *vmg)
> >  {
> > @@ -576,85 +772,6 @@ int vma_shrink(struct vma_merge_struct *vmg)
> >  	return 0;
> >  }
> >
> > -/*
> > - * vma_complete- Helper function for handling the unlocking after altering VMAs,
> > - * or for inserting a VMA.
> > - *
> > - * @vp: The vma_prepare struct
> > - * @vmi: The vma iterator
> > - * @mm: The mm_struct
> > - */
> > -void vma_complete(struct vma_prepare *vp,
> > -		  struct vma_iterator *vmi, struct mm_struct *mm)
> > -{
> > -	if (vp->file) {
> > -		if (vp->adj_next)
> > -			vma_interval_tree_insert(vp->adj_next,
> > -						 &vp->mapping->i_mmap);
> > -		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
> > -		flush_dcache_mmap_unlock(vp->mapping);
> > -	}
> > -
> > -	if (vp->remove && vp->file) {
> > -		__remove_shared_vm_struct(vp->remove, vp->mapping);
> > -		if (vp->remove2)
> > -			__remove_shared_vm_struct(vp->remove2, vp->mapping);
> > -	} else if (vp->insert) {
> > -		/*
> > -		 * split_vma has split insert from vma, and needs
> > -		 * us to insert it before dropping the locks
> > -		 * (it may either follow vma or precede it).
> > -		 */
> > -		vma_iter_store(vmi, vp->insert);
> > -		mm->map_count++;
> > -	}
> > -
> > -	if (vp->anon_vma) {
> > -		anon_vma_interval_tree_post_update_vma(vp->vma);
> > -		if (vp->adj_next)
> > -			anon_vma_interval_tree_post_update_vma(vp->adj_next);
> > -		anon_vma_unlock_write(vp->anon_vma);
> > -	}
> > -
> > -	if (vp->file) {
> > -		i_mmap_unlock_write(vp->mapping);
> > -		uprobe_mmap(vp->vma);
> > -
> > -		if (vp->adj_next)
> > -			uprobe_mmap(vp->adj_next);
> > -	}
> > -
> > -	if (vp->remove) {
> > -again:
> > -		vma_mark_detached(vp->remove, true);
> > -		if (vp->file) {
> > -			uprobe_munmap(vp->remove, vp->remove->vm_start,
> > -				      vp->remove->vm_end);
> > -			fput(vp->file);
> > -		}
> > -		if (vp->remove->anon_vma)
> > -			anon_vma_merge(vp->vma, vp->remove);
> > -		mm->map_count--;
> > -		mpol_put(vma_policy(vp->remove));
> > -		if (!vp->remove2)
> > -			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> > -		vm_area_free(vp->remove);
> > -
> > -		/*
> > -		 * In mprotect's case 6 (see comments on vma_merge),
> > -		 * we are removing both mid and next vmas
> > -		 */
> > -		if (vp->remove2) {
> > -			vp->remove = vp->remove2;
> > -			vp->remove2 = NULL;
> > -			goto again;
> > -		}
> > -	}
> > -	if (vp->insert && vp->file)
> > -		uprobe_mmap(vp->insert);
> > -	validate_mm(mm);
> > -}
> > -
> >  /*
> >   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> >   * @vmi: The vma iterator
> > @@ -1261,20 +1378,6 @@ struct vm_area_struct
> >  	return vma_modify(&vmg);
> >  }
> >
> > -/*
> > - * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> > - * must ensure that [start, end) does not overlap any existing VMA.
> > - */
> > -struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > -{
> > -	if (!vmg->prev) {
> > -		vmg->prev = vma_prev(vmg->vmi);
> > -		vma_iter_set(vmg->vmi, vmg->start);
> > -	}
> > -
> > -	return vma_merge(vmg);
> > -}
> > -
> >  /*
> >   * Expand vma by delta bytes, potentially merging with an immediately adjacent
> >   * VMA with identical properties.
> > @@ -1297,8 +1400,7 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  		.anon_name = anon_vma_name(vma),
> >  	};
> >
> > -	/* vma is specified as prev, so case 1 or 2 will apply. */
> > -	return vma_merge(&vmg);
> > +	return vma_merge_new_vma(&vmg);
> >  }
> >
> >  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> > @@ -1399,24 +1501,40 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >  	struct vm_area_struct *vma = *vmap;
> >  	unsigned long vma_start = vma->vm_start;
> >  	struct mm_struct *mm = vma->vm_mm;
> > -	struct vm_area_struct *new_vma, *prev;
> > +	struct vm_area_struct *new_vma;
> >  	bool faulted_in_anon_vma = true;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = &vmi,
> > +		.start = addr,
> > +		.end = addr + len,
> > +		.flags = vma->vm_flags,
> > +		.pgoff = pgoff,
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> >
> >  	/*
> >  	 * If anonymous vma has not yet been faulted, update new pgoff
> >  	 * to match new location, to increase its chance of merging.
> >  	 */
> >  	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
> > -		pgoff = addr >> PAGE_SHIFT;
> > +		pgoff = vmg.pgoff = addr >> PAGE_SHIFT;
> >  		faulted_in_anon_vma = false;
> >  	}
> >
> > -	new_vma = find_vma_prev(mm, addr, &prev);
> > +	new_vma = find_vma_prev(mm, addr, &vmg.prev);
> >  	if (new_vma && new_vma->vm_start < addr + len)
> >  		return NULL;	/* should never get here */
> >
> > -	new_vma = vma_merge_new_vma_wrapper(&vmi, prev, vma, addr, addr + len, pgoff);
> > +	vmg.next = vma_next(&vmi);
> > +	vma_prev(&vmi);
> > +
> > +	new_vma = vma_merge_new_vma(&vmg);
> > +
> >  	if (new_vma) {
> >  		/*
> >  		 * Source vma may have been merged into new_vma
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 50459f9e4c7f..bbb173053f34 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -55,17 +55,6 @@ void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
> >  /* Required for expand_downwards(). */
> >  void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
> >
> > -/* Required for do_brk_flags(). */
> > -void vma_prepare(struct vma_prepare *vp);
> > -
> > -/* Required for do_brk_flags(). */
> > -void init_vma_prep(struct vma_prepare *vp,
> > -		   struct vm_area_struct *vma);
> > -
> > -/* Required for do_brk_flags(). */
> > -void vma_complete(struct vma_prepare *vp,
> > -		  struct vma_iterator *vmi, struct mm_struct *mm);
> > -
> >  int vma_expand(struct vma_merge_struct *vmg);
> >  int vma_shrink(struct vma_merge_struct *vmg);
> >
> > @@ -85,20 +74,6 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> >  		struct vm_area_struct *next, unsigned long start,
> >  		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
> >
> > -/*
> > - * Can we merge the VMA described by vmg into the following VMA vmg->next?
> > - *
> > - * Required by mmap_region().
> > - */
> > -bool can_vma_merge_before(struct vma_merge_struct *vmg);
> > -
> > -/*
> > - * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> > - *
> > - * Required by mmap_region() and do_brk_flags().
> > - */
> > -bool can_vma_merge_after(struct vma_merge_struct *vmg);
> > -
> >  /* We are about to modify the VMA's flags. */
> >  struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> >  					struct vm_area_struct *prev,
> > @@ -133,31 +108,7 @@ struct vm_area_struct
> >  		       unsigned long new_flags,
> >  		       struct vm_userfaultfd_ctx new_ctx);
> >
> > -struct vm_area_struct
> > -*vma_merge_new_vma(struct vma_merge_struct *vmg);
> > -
> > -/* Temporary convenience wrapper. */
> > -static inline struct vm_area_struct
> > -*vma_merge_new_vma_wrapper(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > -			   struct vm_area_struct *vma, unsigned long start,
> > -			   unsigned long end, pgoff_t pgoff)
> > -{
> > -	struct vma_merge_struct vmg = {
> > -		.vmi = vmi,
> > -		.prev = prev,
> > -		.start = start,
> > -		.end = end,
> > -		.flags = vma->vm_flags,
> > -		.file = vma->vm_file,
> > -		.anon_vma = vma->anon_vma,
> > -		.pgoff = pgoff,
> > -		.policy = vma_policy(vma),
> > -		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > -		.anon_name = anon_vma_name(vma),
> > -	};
> > -
> > -	return vma_merge_new_vma(&vmg);
> > -}
> > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg);
> >
> >  /*
> >   * Temporary wrapper around vma_merge() so we can have a common interface for
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index 40797a819d3d..a39a734282d0 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -709,6 +709,12 @@ static inline void vma_iter_free(struct vma_iterator *vmi)
> >  	mas_destroy(&vmi->mas);
> >  }
> >
> > +static inline
> > +struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
> > +{
> > +	return mas_next_range(&vmi->mas, ULONG_MAX);
> > +}
> > +
> >  static inline void vm_acct_memory(long pages)
> >  {
> >  }
>

