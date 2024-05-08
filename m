Return-Path: <linux-kernel+bounces-173583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07D68C026A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8602E2827C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213BE57F;
	Wed,  8 May 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eT51Zpln";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rtBjGi4f"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC51B1095A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187556; cv=fail; b=TMVITMHiP7Yt4Z9XH8P3eaLDV7Uuy7DGk0+FezpGaGbuI+0UifOSs1NAC/29keeKFNEG6AvD48clBn51SFdtyqYi4V2AE5cm0ctACEtQB7Cn10xxBI5DoIVVdU1tq3HEwJ24PZ9kRWybmdoUTBhJweUTaLkYx3ouVGjaKYM1IiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187556; c=relaxed/simple;
	bh=r5vCebRaIwX3M0HX0QQFhsTmNwQtU/3W8RudMGJ7Y08=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dODnrQ+7eeYTZWp78fliMW/kwD6tpDPBZHSbpIk4g8BrAIb4GwTJGlAk3qlEHoJa56HlSiMveCxryww3v9svMhgPxxoqXhw6R3iTxexmyavfjO2rhw51iYAJQY8RWzUOBSA0UZ4RLEur8BAJhP8jXY1WqmUnQzB1q4yHoqV9shQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eT51Zpln; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rtBjGi4f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CO5Y0001331;
	Wed, 8 May 2024 16:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pjGteoW4rBgvPuU5mrizoqXFEwcwFL9N8QkKYBzH+iQ=;
 b=eT51ZplnzAkm2v56R+Dc3CQ2zsHPAuId3Z45x4zjfiHb6gs0nWJqGU7elSs5h2V0IBzF
 IrY5lsOAGzxrjkuzUBgyeaH1e8L9Wmt/4rxE3S8dIODItSjgSoX4kbPch369NEFGZf5j
 uaUKzWBB0xW0awoSJAu+RcW2viLN6eLqyd35xmJ5qxCVgKfBvTTNoWnYeSeM0XLg45pV
 VkPGPjztmz6AxoJRrlMa2zxWlgYD9fPQth0pDCqFhlgkDdJ3vXDRvE3MLKQ8wyAcHkM8
 gNXYJOgkZmr+Ctj+qqZjFFY577W77/RQ1Pm6oiUX8Zj5rVsApAn3zeJ+2KqSnzpcV/rr Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfq2bve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:59:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448FWXm8024276;
	Wed, 8 May 2024 16:59:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfnk85b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzTe/8EUjRHxrabZH9tEe72Nz4nCH77OjprgZi0a2zCKvoputJMCWHsI0AcpDmu8b7iX+F5caMykDc1yB64g2TLspfFeiIuVV1dOAHo0pIOKGehXiRynVi7eA30M07/BlqroayEmxZDBP5GD9MzVeV+sOYqjiqUr492Ee2FrdOmZSZeAhtDfQ7IrStIf4aIW5JNEWdeHS9Cb2gIiLKlULaoCX2p8Ps216sq2MD/gG+ktGyOqlLhrPxLbP9Vs05uEkuYweLnLU/hmsjriyL7Tg5eZawtADS7CL3fkWfPcWqphrYKHhWLrc2rAC4vVUIeh2k8yyEf+71nxHnEmz0RuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjGteoW4rBgvPuU5mrizoqXFEwcwFL9N8QkKYBzH+iQ=;
 b=oX30LygZr8bsNAoMp/7yCAPA5FuhQPsA5xkVEBA0UahSh5Nhbo+uLQCoffN2vHU82HR5VDfbVfMdDfOLHLTVhTv7n8Rf8hiKCdPQDFCK2bZQxZdSMW3LxE+l4dyYqwFIquDzT6hqcEy489WL/ATJMRSC4U+N7fJUwHMSHwTXAykYSsyQ6V5pQ/7qzg7f5Bed7RmJ1PR87T7fhwZOpj25DDnx/3Y7fFYAlJ1frhtXuz1rltE88jy7lX2fu7WaKFl/h0fVUKIGUsiLpFIT7rMZU0UtTIRTMUw+pLfF5M5hvlB2icwG5Bm9GDjFbe/c0G2SJM6U0AFvX/F/I+TFnT9Yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjGteoW4rBgvPuU5mrizoqXFEwcwFL9N8QkKYBzH+iQ=;
 b=rtBjGi4fXx9YoG2aZXwwBfiLud0KBX2BzI69hu49/KXQM/ZA9na7oRMhaAkZnANwsnnn5czMvjNTVTkW0v206ugIpojtLUGJ6UspkMLDTX3QWfToLi99ou4NdxtT/+zafGRwz+7m6UeK5SdrValtuQuqIyZXJJ3EkRnR2dWPWZQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 16:58:49 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 16:58:49 +0000
Message-ID: <64df4f60-464a-4fae-81c3-f355c07410d0@oracle.com>
Date: Wed, 8 May 2024 09:58:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap
 failed
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-2-jane.chu@oracle.com>
 <1bc8c5ff-1452-11d3-edee-9f45a87015a9@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <1bc8c5ff-1452-11d3-edee-9f45a87015a9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH0PR10MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 30161ca8-5f22-40fd-c0f1-08dc6f802195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y1Q2R2grRFNEamRyQzNEQWlGY24vWE4wRk5rM2ttb1c1WkFGUS9LSDhSMEdh?=
 =?utf-8?B?bmg0bE5NTzE4R2J2Yll1WDFZVnlBb0d3RWZZbTFsbkFSd2oxTHpQZlJkZUt3?=
 =?utf-8?B?a1lnZUdiM01ZN1JrOVRKN3l0dlNLTlRTRTNHdXZLSEVtRlZHOUEzYU5MdE1a?=
 =?utf-8?B?cVMwdzVJbGVubUNHdkJVTWJoNllnQTlkUWVaRVhEMmpSaXVhVUtmNkZKazY3?=
 =?utf-8?B?eWNoWGFGaFlIVDJXMTRwamZqbG5yWENLWXpyUnVFOVk0NWZyYmdwRytBV0ho?=
 =?utf-8?B?SUd4YkdnY3VDSmYvRFlXb3I4OEdkTVcwNThkeklwd2JKbzBuYmlJUEIvRkNk?=
 =?utf-8?B?ck9sNnp5RktKdElmRXY2MTVzUCtKdHpLRDljQnl5bElLeEcvRGpuTlpCVzNS?=
 =?utf-8?B?QWd1SnVjRWh3TkdkZklaSHRqMk91NUhEdTRSeXBCRWFOTStNU3JNYXBINjU5?=
 =?utf-8?B?cWxhYk9vSjFsNzZNZHVzZnlkTjBqNE5aK0tXczE1UjdDb2tlT1IrL2JZS1ln?=
 =?utf-8?B?UzJ2UjliOUFvWG1wbnJKZ1Iyc0QxV1hRYW9taFgwWms2TWFiTFVralBqUlQw?=
 =?utf-8?B?ZW11MEQ3Qkhja25LR1YxcnBHenlHKzVmRitlVXRISDVaa1FxeVYrSVBYNjUx?=
 =?utf-8?B?Yko5cXg2d3pTaHVsemc4aUVmdWt5RjNLU2x4VVg4NjFGOGZZZ0xCcytjZ20r?=
 =?utf-8?B?TkNCR2Y3Snh6b2hZTjJtRHcxZ2RDVE1Ic0FGbmwwSWxFUkhFWnpOYnB2ekdV?=
 =?utf-8?B?YTVCYnV5Y1g4Q0lFMyswTWQ2SmlvVnBYQURVTXlGaDl2QlpEaVd0blFmZFN1?=
 =?utf-8?B?UWhMNjBWZHh6cUduOUFZeWp5QlRGMnIrVWJlMTFidGl2Q3pFbnB0ZGhNdFVp?=
 =?utf-8?B?QmdYcEdOLzhkL1dUNFJqZHhkVXNJUG1ZcmFSRFJmTU1sNnk0RU5Ud1lKODBx?=
 =?utf-8?B?SDFPbjBFTkdkUUdaeC9hK0JQSWNrL05IWTN6N3ZxVlFFbHc2VHlVT2ZCbjZI?=
 =?utf-8?B?ejlPV1p4emlSNmd3eFV3bWtjdk5wcmtZNXh5VENadVBhYmlKN1h2VEM2Wkhx?=
 =?utf-8?B?V0RkZjRwWk9LN25GY05aeVphTk9uc0V1TUd5OGZGN2VRRW5kS3FwMjFBenFE?=
 =?utf-8?B?dmFCbXdTcFdBb1pBNENieWZyZHpiSWZGMEtsVGtyVW9qbU1xT29CT3NVTXpF?=
 =?utf-8?B?aEhCTDd6cS9nVnNPUENQajhqSWZEZ2dtaVkrWTNTbFdEdlhGMS9lRDdSTVVs?=
 =?utf-8?B?cE12aG5UeURtTDAyYUVLRWU0cE95ZEYwOVZ0M0ZabTVaSkpzaXJpWGkvZWZw?=
 =?utf-8?B?T2Rpa1VUYW1ZaWtFOHhhcGM3MkJIRWdjMEdGV2VCOUtLc3A3WnVUN3ZlY2E2?=
 =?utf-8?B?MU1TRHdSaUNRckI4cENzOFcrYUNaR0N4RjRSVEloZkJUMHJjTExmbldqUXNv?=
 =?utf-8?B?NnIyS3hHclU3V2ZZWW5GUnFWTkdoODJpWEhKZXNzNTAvMXVnWEhoMlozMVN3?=
 =?utf-8?B?ZHlDSXBKNXg3RTl4LzV2SHQ1QTdNOTUvajNNZlFFODhvekpFVXBWbldJelE3?=
 =?utf-8?B?bFN0bU9WRmZGSkNGOWpSdmZjNCszZ1hNNnM3bS93RTdIaE1nNmxKcWJrY3ZO?=
 =?utf-8?B?b1JPMzVjc0tNdEFtdnRIem81aUFRTWFjbzU3bHdWb3dmV051NkEvWEljY3Fj?=
 =?utf-8?B?NythRlo4elhHVjAzUXl0TnpNWmRpMXRkMHRDODRZNncwaHJqMTR1UGhnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1Y1cEFGNnFYbnJaLzFSQW5TazVaSjJGaHlWMWc3UUplKzdobjh6Qm5aRm9L?=
 =?utf-8?B?WUROVEJkd1pzbW9nTEJmazVCeXJIcDFWRXJEL0NtdFdIMkxidDNNWlU5RGJJ?=
 =?utf-8?B?MFdMSTR3VlRNMTl5N2s3UHIwMWMzbGthdG1IR3lYK2lIS2VCVm9pQ20rclVF?=
 =?utf-8?B?dWZJS3lYYUFxUEJVUTk1eFIrTEpOTUx5ZXpRZHpCY0lVTDMwOGEvbGVQVzhh?=
 =?utf-8?B?OU9Ocmp3d0hrbHhGTFE3VDlPSEs3dTA5T0JGN0Joays4bTNOeUxMS3ZoeFNQ?=
 =?utf-8?B?L25WS2NBMStmYkZkRVhVOFA5YThCTnQ2SEsrczZSNkpvY1JsVEZNOGJ4bjNy?=
 =?utf-8?B?Mk5OQWdGdk56eXFNck5jYTR3ZzVZZlRtb0FlWmM0bGcrKzBaeWxjTXQxeGdH?=
 =?utf-8?B?WG5ZTGFRakkwaEVDR0E3MW5pNVdXT0cvVTdIZ1lGY2czVUtFWGtlT3NmM0U2?=
 =?utf-8?B?eDVqNHpjZi9pOEV2eDM2YjJtdHhJVy91ZVF5RXZndE04OEpPVEF0bXpRS0xM?=
 =?utf-8?B?Q2hDa1MvVG9PZ1lsN0JneDJ0QmlHNWppb1JFMktuK29UYms3dnBTRVltV3dj?=
 =?utf-8?B?cGdtZW85VE9hcmJndnBJVXdodzE0SFhZL1c0b1B1eFp5dFdTQWVKRVA1ckFo?=
 =?utf-8?B?VE04WENBMGJmUHhNZHcrZDZEcitpMUZGM0ZZaTVsLys5eUlQR3ZEZmtkRkIv?=
 =?utf-8?B?UWk4Y1NoZ0cwN21xaXMzU2lxZlk5em5mdk1UcUFHelJsQy9JYmVpdVR3Tzhu?=
 =?utf-8?B?VWZDVDFacDBxUytUR1N5UndoajBuSTBFSS9RUXZ6K1Bkc01EQzBRalpLaDYv?=
 =?utf-8?B?cC91WTNMNUFOYndWRngxSXpsZXhYVklreUFWR0lRbWRjZTRseVJmS2l3WktZ?=
 =?utf-8?B?ME9sQ0wxT1k4NDlyeXIrWnZ4cFpvc3RVQUFQb2x5Q0Exd2YvSFF1UmtkckZs?=
 =?utf-8?B?Z1ZFYktKelZReTk5SmhrTXNNOHFXRDE2bVB2cUthRnluZVFwdlNDY0hKQjBT?=
 =?utf-8?B?SWhjc2c3UnlQMDVnZW9tMGNyMXhOTENNc0VPNFZ1UU9BdVlkUDZTcVR5cjNw?=
 =?utf-8?B?Ri9yK3ovSHJpdVZQalJXbEo5UW5DNTAwU1FULzB5MC8zUnJrSVl2d0VQcjRa?=
 =?utf-8?B?dnV3U2RFcTJrSkIzYUdYVEt2bEc1cHVDbUY1MjRwSWFwOVdKR1dQSEFWckZM?=
 =?utf-8?B?WWhMMWhWY09oS3NoVkFjT3h0UGpZNU9DVFV1YmlSZlI3VS8vMXFJSWJ5Vm1Z?=
 =?utf-8?B?eFpIQmdpVENvRzBuWlBVY2JucGFnT0pnZnRiOXJVVlIycG9uNG9XQlVhN2w5?=
 =?utf-8?B?MWlpZkQ0bElrUmYxMjRUNWliZFRTNlFaajlYMyt1dE11UEhlODc1MVVxVXhD?=
 =?utf-8?B?eENaVmdwNnhubDNyM3VQbDF5VFhIWXBVTVVIZGNmaEhZa0RDNmVIajEzNENv?=
 =?utf-8?B?QTFTS2puUTJYQkF1TE91TldKWklBTzRSekRqMU0rOWdNWGgvdjRPTUhYd1pU?=
 =?utf-8?B?WXM5ZkZvTmppaC9INkMxVnI1OGNGS1FzSS96VytCUTFHODZVaVhMK2NwNlEy?=
 =?utf-8?B?TW9YMlp3QTJRR0JBOGFUbGZXVFh6WnRVT0crVGFmT1FjVm1CdWphUXpFT0F4?=
 =?utf-8?B?cjk0Ui9icC9xSndLdkJjbHJSVTBFVC9KOWdyam5RcTJjdHZOSzBwZTlvK3Mr?=
 =?utf-8?B?eFd2L2ZaSE1lYkxIZmUrYTBpLzhxZ3N3RktnZCttemhxa25NNVNmR3cxWit2?=
 =?utf-8?B?UjQzNkd5cUoyZ0QwanBYd0F3S3hBcVZrMWVMUkJkczJhZU0wMmlncFdUL1Zx?=
 =?utf-8?B?d1JWQktRYzQzRXAwOXZxeXpOakJ2dFI4N2xHZmdoK3hWKzFHdzN2WnlVY0po?=
 =?utf-8?B?VnRBSjBWc2o0WjRwU1VFaDFHcmc3WC9RUk5nS2ZUV0srRC80QURkNE4wVVJn?=
 =?utf-8?B?Y1dhWGh0M1YrZUMwS0pEbkZNU0s1Y3BWR2VDMVl1d2pkelpINjg2MFl6c0Nu?=
 =?utf-8?B?WVdWWVY2MGduR1BaZ3ZyWktwVzZDWXYwZk81UnYyaTlka2ZEbllYZXI1ZE1a?=
 =?utf-8?B?SmkzN0JFbzJvRitUSUhJL0JqYjkzU2k2Q2dFMnRaOW9WZWlVUkc4WitGUXVG?=
 =?utf-8?Q?unXYf1y5iENntcAJqtq76qbdU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WjA9RZevjHqsN6LpZwfMA2LtTABB/4FNnG8SCjwZdU1E1PNV3zKxRtgLbu8HpmQNCs4iKHTo5IL740EziiIq47FmeemVAb8B2nG12PZ73ikVVIlfGRk5j2pC9927a1wOiuXGD+Qk6v9gZ6rDCeHJLkcrF/gs40PsKNyRaRp6uqPxoH8oZZk0GKb3vycyerOpnlAvmGC8HWPPFwn1ijimrVQh8OHrf9RcuAAS7L4IXuKCqAxgfNTOtlwu5902qgWjjyea4a1iQ9a9/ZxFj0zn7ZMysHaB4+ukmOqOyht+pHQksbUzoeVuI6aX8sGw6ket7BNUHkAJqap4f1b4gvMT/M0bolthdA4ipUlHH+CaWkpUbBN0oSDEYDsp80Wcyk5Y/C9paNc6lOncnzod1nWmW6fCLPPVndhOTlrMrmOOAHd3c6kpD27Kq32ClEsfv6L0GDtV0PMSaAc/qEbCQ1S17/FVivPy98Ockt9L8pR422lFLmyZQDURyoDO2nUj3FXgJQr8EDbEYVx2t5xBK3cVZasvx2JAaltfJ0vaNgiCXaZT00AmksjjUw+2wJf+xY9otBnlJKVvOXDQLmHWB3WFBEThL5vAlDOHu+z5gDYDHjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30161ca8-5f22-40fd-c0f1-08dc6f802195
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:58:49.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpAuXF4564CxzLG4X0pdo1vrfcDrUcQa9Ji4S72UYd3Co2HIe3wEVCktm7Rm72ARbsQVSl0ak/2m8l/fumobuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080123
X-Proofpoint-GUID: HFJT40WwGSXnXjERO3mvm2b1HAl665tR
X-Proofpoint-ORIG-GUID: HFJT40WwGSXnXjERO3mvm2b1HAl665tR

On 5/8/2024 12:47 AM, Miaohe Lin wrote:

> On 2024/5/2 7:24, Jane Chu wrote:
>> For years when it comes down to kill a process due to hwpoison,
>> a SIGBUS is delivered only if unmap has been successful.
>> Otherwise, a SIGKILL is delivered. And the reason for that is
>> to prevent the involved process from accessing the hwpoisoned
>> page again.
>>
>> Since then a lot has changed, a hwpoisoned page is marked and
>> upon being re-accessed, the process will be killed immediately.
>> So let's take out the '!unmap_success' factor and try to deliver
>> SIGBUS if possible.
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   mm/memory-failure.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 9e62a00b46dd..7fcf182abb96 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -519,19 +519,14 @@ void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
>>    * Also when FAIL is set do a force kill because something went
>>    * wrong earlier.
> Since @fail is removed, above comment should be removed too.
> Thanks.
> .

Good catch, will do.

Thanks!

-jane


