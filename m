Return-Path: <linux-kernel+bounces-388111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D911F9B5AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C71F248A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE4194C61;
	Wed, 30 Oct 2024 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QKIbbFB+"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1C193081
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263166; cv=fail; b=Dqrg0LLVsLzzY2dIkBwOTAowgziQH/h7T0ia6P/qAG/gI/IaszR4AlG3IF/jk9JrUwQsaWMm8T8OBYpYaAItS0KIWaaeF8IUgiEynFigt83IofOhPF7azAiA1JrkqNjaLGRppLJgMl5ipIUiCoExYL2nIvDRIzDgvhNZXJEsgRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263166; c=relaxed/simple;
	bh=19kc2Xa2lZRbLdRF2gWHeFluP8jyIpOY4fM5RRb32Hs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LYIzN/mqrk43kn8GKY3TG6ugsuPuaEEfbvRaxpjqL+VDEFDE8Dq8zjkk8xAgc387AEn27iCzLGd6P82h1Ct/S0vNvvbO+Vtwi6l6QicNGW8E/Xm4DNTJSwJO7k+H/XH4pPGqrJXRPY0VpGAqGXdEwoU83yNa4vg/rA9F3cRzyTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QKIbbFB+; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPXjyIQLsBtIDv7akU84j0O0vop7il5yNEbpCeFrL4hliu2Jl1Xu+2MW90UANHji0CwdZi7qleYYEDomIlWTd9Qb+r8M/h1rO3U7TTEHMCTf4Wo9A7y3LHREeKu0Rt2jOKR4NhCqDi2ZlN/l8ZdQRik8s6AkfptaA1Jz2Fk4n3Wa2uN6kfqivZGCPYymh818Vuq11QfoM5sleflcKBUGSWdN70tvHCRpVIxggEVoOheqkmawx28+f0MMTZcFQ5StDNSapZaiTUcMBKv5CZDhAyAheiozRmcB1vOL89UJRCzN5HxjdbpKQXtLjQyzIiSkxDDY5u4nvUZOjqDOTWL3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rPPc9PMscvq6qarri1VRlB5snEZhla6DZZoQ8PBrk8=;
 b=dviuwsLUPkzB0GwiroTr5iFSmH3j7As/YepwclwbjdHJC4rVajbV3JHLsAcjvthNk2WgSMcJh1GaCAJoveYNknECy8QyBNOt9DBPQfEOUqe7bxtqZ930l+lmCGkgXWTCPIxsWvdjaWZLhZZsiAt9hxj2eWVdZPZGdmlPKqLdnF9PtaVRlwRvssKAM45K+P5wl99jqXR6CiBYTDu6fBsc4lCSaADsLtHoBUu8xYmxmAJMHAgxE96RC/urMeQq4aVZ2RYtcac4efjAv6n9b4LoLgbeAAlMGpuFX83/6KxY9eV4zbF5KMdZfWUwaVz5hsCEE9EP3LCvXcN0+MFHQRspcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rPPc9PMscvq6qarri1VRlB5snEZhla6DZZoQ8PBrk8=;
 b=QKIbbFB+/Vt882dGS3dYk57j6IRp2i79E82R22OqGo5AR4b4R7sHkkpSlxUQ/k6Tw0fuXsyvqB/fcx6dNYhLe1AJ/FtcATg6M7iPzEvb8YBYenv/ZgVBJAa+jEOFoEO2PIz+Ad4ee6EKdTPMRXCvlJRr5kMcXsE5ohtuuVSxGuF8H8mnNaNcU9Ffpscv1SPkliCFm/2ek/C290JXhHP6G8oUH5UjSOhozUpyURFh5/kZLz/fFhhwXL6Wj1QeGpuLUOaJKmUNYEW/61VhxX3pWgfTOhD+Swm0Y8XNmPpKhxQvkWIA7tar7UmdV+p8jW5bszrn0Ih9LbX3/VLN9/GtNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) by
 CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 04:39:17 +0000
Received: from DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579]) by DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579%7]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 04:39:17 +0000
Message-ID: <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
Date: Tue, 29 Oct 2024 21:39:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 David Hildenbrand <david@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZyG3GAvTHpRL9tnU@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To DM8PR12MB5462.namprd12.prod.outlook.com
 (2603:10b6:8:24::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: bd26dcd6-83a6-4b5d-6e1f-08dcf89cd02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ri82Mm0zZDRCSHFXRXF2TGxmTEpLUkt0UFQ3MWFTa2tUWGZmZ2YySi92REJQ?=
 =?utf-8?B?aXFrNytzZTFrUm91OGEwWHlIbi9GcnJReFJVSEcwUmxhY0F2OC9YbUZKSXQx?=
 =?utf-8?B?b3ZVUzJzbDJINVdvME5MVHF3WEtoWWRLZlAxNTJCVEViazVuT0FPV0YvMmkw?=
 =?utf-8?B?MC82Wm9mdGZ0VzBPeFZ4citkaHZNRFdtOFBDanZUTjg1TmhoMTdTSE1CTld3?=
 =?utf-8?B?WnhxTUR6QU9kN2J1T1B1TTMwcmVrUTAvekFZbGo3U2Z2MGhYajUrSHN3bzYv?=
 =?utf-8?B?eGIxZ0lEcW5qQkhPekgwZW1RWFlKbllMWE5EakRFTVVyaUNCcGRkZVpESTJj?=
 =?utf-8?B?WG9pSStCcndMMDIzTnVmMk9BdWhTOVdnR24xZk9FQXJ2Ulp5TmJFSGV1QnA5?=
 =?utf-8?B?MGk1dE00OWI0Mjk1L2ZCMmgwTWZSZFN3U1FBWTdJLzZadmhxemM2d1pzL1ho?=
 =?utf-8?B?Tnl1OWlQdU9NTndOSmxjREtWSkx1bmI0aDgxU3NackdGUlpuNDNKeGFEYzFE?=
 =?utf-8?B?bUJ1eVlZdDdkSFF3Z3NFRXBCR1Q5cU9RcWlFTHdOVkxBQzI4dDY1cDZFb1hR?=
 =?utf-8?B?Vmx6cGNHZXRQbGxCckFlUXZGZzdzODZDWkViN3NWa2E3MTlhMzI0SEpDN0FG?=
 =?utf-8?B?bGxwSkE0WHB1dStsNnVwZmtGc296VWZJdVNObHZlUlcrM2Z6Y1FXVjNqbkFy?=
 =?utf-8?B?MGtycGRJd3VCSEk0ZGNlVCtScmZZcUFHT3NrQmZheGFGVTBCaTJCblZEYTJs?=
 =?utf-8?B?b3VubCszUy9QTlJ2UHFCVlF0ZnArR1NVa1VnWTFRSTVVWmkvODBhRDRtQ1Zs?=
 =?utf-8?B?eVQ4TWQ2N0JnMnBzeE14V1pGSklMb2x1TlFtMUdMUDk1QkswWThPSjlqUWNq?=
 =?utf-8?B?YUsyRTJkbERpT3YwV3hLelRybWlNYVFUcUd5Ly9EKy9kWUhyVGtVRys5ZS84?=
 =?utf-8?B?UFE4bW5EOUJRQWdHNWRYWnZyNGZxWkE1VDJWa1lXRnpIN0p6bjZDamppSlBY?=
 =?utf-8?B?V2tzQ1REQ3VYaFQ2SWdoTHpERGdyQUdIaVZDSERJZkVueXdmQXRmZ3BYS2lw?=
 =?utf-8?B?NnZuSWMrdTk5b01CV2ZUSVg0S2lvTGdDNk55dmtnL1N0eHZlNEoxSXkzTk5n?=
 =?utf-8?B?Z2ZjNTRWOE9qNWhDaWU5c01Bb1p5cnUzY0Z6NlNQeXBqYzJrU25sMVczQ2ti?=
 =?utf-8?B?cGs3enR4RUtkTmVZSXVCbXF2TWpqa0hHNFRrZHBENHJmd3k5OC9Dc3d1Rnhm?=
 =?utf-8?B?U3VobEMwdzdyd2NMbmQyb3hkd2J4Rkc0OU1RcFY0a3cyTE1kbEhDNnNZZE1a?=
 =?utf-8?B?T0FJb1ZlTEtScVEwSHdnWVd3ZVFpWFhQTmJNRXUyWXplOTlVMENrTTdzQnor?=
 =?utf-8?B?QUhYbEVlSlJOYmxnYUxxRks4U2YveWdVV2dmK2I5YW1VbjM5YUFJdjhYekh0?=
 =?utf-8?B?STFwWDRwZWVESnY2Z2hVcFpsK0NyR3lkaVNjdWlveVJiMVdRTzlxTnhkZ0o3?=
 =?utf-8?B?UkZoOVRNTzE4QWI5WThHYW81ZGhVRnU4S3YzSFRsYW9hbXdxM01DRCtsT2Ix?=
 =?utf-8?B?U2pXZlJXa2oxSnFFRFRCaWVldGJtY09BMCtndWlWcDkzSWlvUFZYOHVsL014?=
 =?utf-8?B?bGRTem1VZnQ2TkdxeVF6SEVwcjJNWmIvc2dScWtyeWV0QUsvWHJORWtPdU9S?=
 =?utf-8?B?RjlHeUZBZWE4VklCRlUvUytkSFVINGxpMjduYjM0Z1cxaG9nOWRUOFFJYkZ3?=
 =?utf-8?Q?P+nEaa9zP8NPTnW5cZwpKaVuB4j2iX2frYzvuND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWZ4dUFOMU5TMlUrL2UveTVIS1ZmdC84WVBqeDMxYlZLQ0lFVS84eDhEekZt?=
 =?utf-8?B?WThzMk02NVRwZ3RrU1I4YiszNk90cWpWNEU1eDdMcTZoUGtRc1VpcnhkWkVa?=
 =?utf-8?B?VDFlUVVTL3lXZmZSZHpGdGM0K09GVkgrZy9kRzR0WXBkWWR1UWNTV3JrOGpj?=
 =?utf-8?B?UlhuWjdpb0I5Qi9KMC9CTDJ3UEkrSFVYcnJDQ01EL0dIblcxMHFaRi84L1g1?=
 =?utf-8?B?V2pjWVVPUDhCSWFHRnFqcGVYVVNmbnhVaVZOektDYkFReXRaakhCb29tQmlW?=
 =?utf-8?B?TFVVbkVuMG12d1lLaVQwMFIzdG9BTjZkUU9ScTZzK3hHZmxyM3c5eTBLWW1l?=
 =?utf-8?B?Ymh1ckpCdHhIUEhtV0EwemRBSHlxY2hwNm9vdllORDhNRXBvUDc2ZHlUdWpz?=
 =?utf-8?B?eHRwanRHdE1nYk1ka3VXV3hWdFFEdE1Xb3piWVVjODRLWVdlNEFNNGVUZFZF?=
 =?utf-8?B?RlorRERIWGZTb3pGTjMwQzV4TFpRMEhDM013dWxLSDJrcGVQK3BYRXdidlFo?=
 =?utf-8?B?ZkFCNDBhZXdkSDZNOWZESFlRdDgzSjJpY3phR1pzWnIybTNYZHJ6M2tLdDFD?=
 =?utf-8?B?eEc4c2tJRC9URThsSU1KbWZpNHpFUG1XWXdGamF3anpyd3N1ZjZtN05Hc24r?=
 =?utf-8?B?WGtXVFcvNmJpc2pJOSt1WTJ4OVhaMzlpbmtTYmNCaXhrUm5PTUtnZ3psK2xK?=
 =?utf-8?B?ekMzNlNkb1U4ait2RkVtVC80d1hRa3FNZW1DcXhUL2xKZStlMDVkajNkaEpa?=
 =?utf-8?B?QWttREtULzgzQStXTHk0RUNGbk9rYUU1K1ZWVTVMd3FNOXNnZ3lnN3N2alBv?=
 =?utf-8?B?NG9TNnpFU3ZabHlMaGNkQzJGV3lmczJUOEl6RjdJWjU3emJubjBYczdtd0l4?=
 =?utf-8?B?REw4VTZpVlhYdnFsYzB4S3lXMitKejdIZ0Y5TEhzQUxadGZLZ0k4ckZLWjhK?=
 =?utf-8?B?QU02ZnhtZjQwQ0N4SXZ2dGE0UlduTzh0dk1MY3hJeHJJdXJlNnRFUS9wUG1C?=
 =?utf-8?B?aXptQjhwSG1JODdYbTZodklRcW9xMi9EMFVqRDJEQXpKRmlrTnZ4ZXdUelF1?=
 =?utf-8?B?RDE5UlBhd0lKODluSGszTEllTUVmb3JvU2FtNG43K3ZoYWtBdFhaa0U0WDI3?=
 =?utf-8?B?UkpaelgyTG1sMHREMTQzLzFGVHdOS3JyaHNyVFRxYkY4ZTRZRzJJT1NCWnFp?=
 =?utf-8?B?TTVpeFFoMFFGMVNqbEFmQmt1OWt0MW53SzNEMmx4a3VXd0ZNcFZtWFBTVDhq?=
 =?utf-8?B?dTVXN0NVOFJ5R2VSSW9nRUNuNi9DSDVBbWc2VkUzNkoxeGx5WEtXMGl2REtR?=
 =?utf-8?B?NlYyNmNicjE4aGdBTFFZSnVhZzV3Z2xNR05KbnVIZ2RwMm9EeE9qRWFNam5Z?=
 =?utf-8?B?N0lISmNSalllb04wNmJUZS9KTXIramxtOGQ3RU53NXhvbmRFVHgrbllLZ1NV?=
 =?utf-8?B?bFY2OGE0UmtDS083MXRYQWczRm9NdmhJK1lQU3Y0cTN0WldZSFZYRGtzczNW?=
 =?utf-8?B?a0hSZUMwM3NpQmVGcnVQS3BBU0RnUzh1VkhoUVdxMHRNSFdXdTQvaXEwYVRu?=
 =?utf-8?B?VVh1VkdCVHlvUno5dVZLNVdaZFlDOFRkSWtKVUgwWklycWZWa2ZEdDlBaTFp?=
 =?utf-8?B?UDI5L0tmVjU0VHVKTkgrc1B1RzRtYnArcDFIS0ZYdXVLRFNNdk9vNE96TWRP?=
 =?utf-8?B?R0x5czZtVTl3RFFOUjFGQ21oM01hajByVk9nWmhwQW5VbUsrV3I2Rk92Yzc1?=
 =?utf-8?B?V0ZEWG53WjZNV09acHJ0OVUxOExjRWRYSW9PVWFsSk56czVoY2hmMldaVTdy?=
 =?utf-8?B?UWZpVUp3VFRHbnlXVGtUSURkMzBlS2FCQ0pybnVOUjR0cXFQZEhtbVFtMktO?=
 =?utf-8?B?TVBiWFAvQXFYdjIxNlFmUHY5eVFLYno1NGplT0VWckFOYWtlWG51YTFSWWtp?=
 =?utf-8?B?QVprcWpzdUR0Ylp2aEdnVmlMOUhVejZxY1VmU0J2ZWRoR0R5QitsVC90SGNu?=
 =?utf-8?B?WU9RMWRiaVo0WU5uYUxBamFzOHExZCt5cm1XWjd1R2RUU05oVCtCaWVOZ1ZK?=
 =?utf-8?B?WlcwZDRMbFhmWEJnNTRwMnVRWG5KZ09VdzJldFpQNStnNHM0Zi9SMElMdDcx?=
 =?utf-8?B?RXdSWTl3U3RDWUFla1ZHbmltYVd1T09tWW5xa3NwVUx0SlR2MjhoWk9wbWow?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd26dcd6-83a6-4b5d-6e1f-08dcf89cd02b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 04:39:17.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6Gd5q1gSOKgn2/5Fwhs3ATRgtYmqRDlgmVd0x4phxCfq1f3DjhroOTDyXSHvrDwfOTDoG0lHI8ErcGTaAmSiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691

On 10/29/24 9:33 PM, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 09:30:41PM -0700, John Hubbard wrote:
>> I do, yes. And what happens is that when you use GPUs, drivers like
>> to pin system memory, and then point the GPU page tables to that
>> memory. For older GPUs that don't support replayable page faults,
>> that's required.
>>
>> So this behavior has been around forever.
>>
>> The customer was qualifying their software and noticed that before
>> Linux 6.10, they could allocate >2GB, and with 6.11, they could
>> not.
>>
>> Whether it is "wise" for user space to allocate that much at once
>> is a reasonable question, but at least one place is (or was!) doing
>> it.
> 
> Still missing a callchain, which make me suspect that it is your weird
> out of tree driver, in which case this simply does not matter.
> 

I expect I could piece together something with Nouveau, given enough
time and help from Ben Skeggs and Danillo and all...

Yes, this originated with the out of tree driver. But it never occurred
to me that upstream be uninterested in an obvious fix to an obvious
regression.


thanks,
-- 
John Hubbard


