Return-Path: <linux-kernel+bounces-397175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911FF9BD7A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A5F284007
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5247420E00E;
	Tue,  5 Nov 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="khjlT0Tg"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92838383
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842290; cv=fail; b=FdIyNKL0o45SfhJTpgOhX7RuEMno64IFIln0c4yTaF22mON9ZP090HXfmBIhBURh+/htXnxGCkQ0BkWpp2R2E95qQ0kO0IfMPCaMlGwTIXFiU+dRAXbMCZ+APhoVoFPfMJ1mHhSIZq1k2pLXDLKDofAbVEtnp8Tvb3Youow2NEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842290; c=relaxed/simple;
	bh=/TScozK0KBWibdGIxlhvOUJD0SpQA0+slh5YEPj55lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fkVkwYEFTY5UVHQPwIPStteI8cbiD2t1e/OMUVU8F3lwktB/yIWphBTaDu983Tx3jNreeDQXoRYWAo0wdHB6+73OjcnMF7OA/FJwEb4BeU6yo8z44On6BWFj/pu1gySU7hkKEVzSA67SbGgOjl38GVQeN9rTpk11AI5A0/IfA9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=khjlT0Tg; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz1KOo8eiJ5ANJE3kLOZDmDaWAPxdsYCb9hOJgwvwiYytuk/iNHqOs0NBhWHyqwzy2M/jzdi4So49R4O1eF2N+T9qjNW/MWN1AvFKWfFbtQpAbzLPSA1fgJpYnKXClosELonJil9R+6VY0+QlDuqKCY4+tFCrfePNsvoewckBeNVAGRgNRXsrEihM1qodUoOL/lXPQ33jS7XIIcWHvkOEI0PMnUcuf6TSeSKX1asqo9LCjTsi9XRpXCNVt/FSe9q4bWqhcwwRB6E29Td2DSgmkGh0erOvMLbFyZv+kuOWF3nF7Y35O4pjJnxca9D7LPCCZ53dSSD15AjXNZKzAuXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gwKBVBFCO/O72P3EeJWnpvO604iYRvv7yglT8X9PYI=;
 b=gXxfoj/yD8Qddr1jBGPETf2ffDZIbebbJubna4X7dfsoHQzLE5ZFBto1F98g7Y6KO2uqiH5bTuF+M2AhGqo/czmHiGc2AiQi3RyQ/JQpBI4MeUI1PU4iGl5l3+frQ7sfZCepSNFabnkGe1QKjJcb6x4w+x1AWCXSy0LN3zJIsbYS17jY3H+m6pF7D6LYmPcgd3MCbVF78EhXsAjNsxVZsrC0hNCknCIFtSR5JDmPYZkP4goSzMpy0DypbFvURTz7CesV5Ya/eXq0Csy0dyb80AIskoiNdAUo7pf6pRpzZG9+Jtx3t/u/C0BRc5Av9H91i1h02Ck7YkTA0KeHTyvcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gwKBVBFCO/O72P3EeJWnpvO604iYRvv7yglT8X9PYI=;
 b=khjlT0Tg4pJ0xFyn26dixpWm7T5RZ74u0nreIPWGrkcOgenNp8cWc1Da2NFu4rQruuQdVurmeDIxa0yq7luRWEp7LeN2SiWyPNtgwTMW2GiPFXhnVud4os67SZCZK4LhW2Oq6N3Q0u62/OkYPKoEICUdNeYXBw8xJvZptdP2BmRDTbYH0Q2xGhJQhg+XCxuI6zU+hODuQUrPW2eZOvGDbO50+pvGceE7bBAp5IapKTfTo/z9/XNJu86/IcwHtx/WbT3ou+4kBbQTR42kUBJcPCePnJr3UOPIVTYveTGxfxvAMozJDW4BsRbwJfpFivJM5qQnWJI/yNZ1oBARc6W3ig==
Received: from PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::16)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 21:31:22 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::55) by PH7P223CA0021.outlook.office365.com
 (2603:10b6:510:338::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 21:31:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 13:31:03 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 13:31:02 -0800
Message-ID: <131cf9c8-ebc0-4cbb-b722-22fa8527bf3c@nvidia.com>
Date: Tue, 5 Nov 2024 13:31:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] [PATCH] mm/gup: avoid an unnecessary allocation
 call for FOLL_LONGTERM cases
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann
	<kraxel@redhat.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>, Peter Xu
	<peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins
	<hughd@google.com>, Junxiao Chang <junxiao.chang@intel.com>, Mike Kravetz
	<mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>,
	<linux-stable@vger.kernel.org>
References: <20241105032944.141488-1-jhubbard@nvidia.com>
 <20241105032944.141488-2-jhubbard@nvidia.com>
 <80500348-e86a-4b8b-94a5-1953aa4ebe12@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <80500348-e86a-4b8b-94a5-1953aa4ebe12@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e91365-d6e3-48d6-00a1-08dcfde13169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGFPQ3lmUGE5RHNCZHU3ZUprTVNOZW9ubTQ3MWdna3JveGdITGRGRmdjY2hU?=
 =?utf-8?B?M3JjUUlEZDZJUXZ1RlJ1akNwYlN6U3dKa1lHVHJZbURSSkN3UzRNd09oWUw0?=
 =?utf-8?B?OFpJNFE1eDdTTTJlZjdrTGk3MUlscnVyVDZkcnc4Zys2a1JIdEtycTE0Mjlk?=
 =?utf-8?B?MlBhT0Vnakd2bXdNYU9MaW9rRG0rZEhRSTF3ZTkvdGtzNGd5ejlaL2dxcEFx?=
 =?utf-8?B?eWloYWxZc0NQWjBFVW1qSGVmMk5TYk04V2M2K2ZvN01nNzEwalRzdXpOOG11?=
 =?utf-8?B?bDd5RTZhZ1dOMU1XUlAyZnU5a2RZMDgxN3ZJUVRWVHFwL0ZISGtVY2RaaGs5?=
 =?utf-8?B?R212SVRKaEtHakw3cWtxcGpPMUtUZkUvNFJVKzdHK3kvV2NJRjlaREtOb2Vh?=
 =?utf-8?B?ZW1PYWNHYnN2aXhkRisvU2Nza1d1cjJrYVlGc2NGNWE5OWhTZDU3ZENDMllB?=
 =?utf-8?B?bmJwVExTQncyTU95ZGs2OGFMVS9xUEV1S0lQQVNnalpGdW1XSkdiOHJibmU0?=
 =?utf-8?B?K0pnSkdQZ0hyemlVQXdscUZzR1ZzQUVZVkRUUFdUNWpXNVlham1DNmp0TlM4?=
 =?utf-8?B?Ym5kY1NxYmRuWTVDMW1SeHNIekZoVEhPQ0l6QytRSXlLOFB5VmxvWkR4ekFj?=
 =?utf-8?B?Wmo1WWFJeXhpRmVWLzllVTdOelJoNXNhdjZ1UXVuMUt2TWgyU1J4Tk5WSm0x?=
 =?utf-8?B?QXgyOGFZSUpDdytQZUsvWjZDeGU0cDFzdXJLMEExTkNoa0hyRXFKQ21rS1Rn?=
 =?utf-8?B?SVIyMlRRbzhJSzFLYkRnL1p4akpKaG0wR0t3WkJtU3Z2bW5VeTRBMWFIbTk4?=
 =?utf-8?B?RXVmUTZCZjhhcUFwcU1FakxnZUhsRU0rZE81REk2dWUwYUhrbUVCS3VKaU9z?=
 =?utf-8?B?d3BCVWxGejlaMlV4bktGOWN3WSsxQjJuYUNrUFVRSjlNMHRyemNoODlINGNs?=
 =?utf-8?B?amdnSWRpSmtFZGxieG9zMGJUVUVRYitReVlZN2pNZXJaNHpLL3ZuQzNybHhw?=
 =?utf-8?B?alNVS3V2OUxKUlNjVTdIdDNob1RkSnZzcjArVmt3N3FOUTJMaE9IUnRWZG14?=
 =?utf-8?B?L3lrdTZlSEhVR0ZkVzMrQ2V5Z24vb1U5RGliQlRLdHFMSVRIWGlIaUx6Z2Rj?=
 =?utf-8?B?WHM5QXdEVGJDN2xLb0hTeFBQeVR0VzRYaGNDSDMwaHk0clptRmFqSW1BaFRn?=
 =?utf-8?B?OUFuYlE3Zlk0aWRVMjQ3WThxdUJtSUhMZW1RRnpsb3RnVDRwWXRZK2ZPdG1s?=
 =?utf-8?B?UUpzM2VoOGgyWEpiTHVkS0JWSm1JMmlXck1hYWw3c3VxQ21LbWR1YzVpRGNy?=
 =?utf-8?B?ZFY5SnFlQUorZklxb3hHeXJ0cysyLzY0VEVlcW5wc3QyTWRYYytlWDk1WGVM?=
 =?utf-8?B?elNON1AyZEEyc0ZiQlZaVDJtRHVmbHAyTzBBZ2ZMUGNuMVNFek12aENobktv?=
 =?utf-8?B?WVV3Mit4d0tNelR4S2tqNW5WVHI5SVVWZmJSdlQ0MHVCeENhV0s1cEZuUVl5?=
 =?utf-8?B?RktWenlWdmJxNkZ2Qlhkci9zSndzcDUzWURmdHdqayt6UUFsOHFDT1dRcWdZ?=
 =?utf-8?B?c2I0TnpNTEErakdiT0xMV2xtYk8ybEMraDd0MWI3SytSTzA0QkkvTWVoZEd6?=
 =?utf-8?B?SndxNzBPS0Z0ZVRQOHRCK2tBQ3FnY21HNDlkQ2loTUhIeVZQK1J1UEt1WFox?=
 =?utf-8?B?VzB3M1F1bitRcHM0LzVkQjJOZHhDTXNzdGdybGlvZHpjZ3diNEV4dkVEYkd3?=
 =?utf-8?B?LzZZdVc2YkZMVGMrbm9mbG1oUmF6c2NrMi9CVTJ1czg5VWFucHhXQUhSMEEx?=
 =?utf-8?B?My9tZlQxalo1MWE1cmo1dS9wcGZiem51bTJiZEw3OU4vS3QxVWZpVWtpRFMy?=
 =?utf-8?B?MlVoc2pSU3FlbjBQeklFNm1UdXpNT3h4UHkyRWdiN2RTQnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:31:21.6483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e91365-d6e3-48d6-00a1-08dcfde13169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133

On 11/5/24 12:47 AM, David Hildenbrand wrote:
> On 05.11.24 04:29, John Hubbard wrote:
...
>>       return ret;
>>   }
>> +static long
>> +check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
>> +{
>> +    LIST_HEAD(movable_folio_list);
>> +    unsigned long collected;
>> +
>> +    collected =
>> +        collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
> 
> Nit: We're allowed to use more than 80 characters :)

Yes, I'm aware. Most of gup.c stays nicely within 80 cols, so it's nice
to keep that if not too awkward....

> 
> (I would prefer the old way it was split across more lines if we really want to split; this way here is less common)
> 

OK, if I need to respin I'll apply this, to restore the old way. If
not, maybe Andrew can fix it up please?

diff --git a/mm/gup.c b/mm/gup.c
index 0f5121ad0b9f..0a22f7def83c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2435,8 +2435,8 @@ check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
         LIST_HEAD(movable_folio_list);
         unsigned long collected;
  
-       collected =
-               collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
+       collected = collect_longterm_unpinnable_folios(&movable_folio_list,
+                                                      pofs);
         if (!collected)
                 return 0;


> 
> Thanks!
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Appreciate the ack, and of course the idea and implementation as well! :)

thanks,
-- 
John Hubbard


