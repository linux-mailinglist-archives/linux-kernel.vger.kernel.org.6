Return-Path: <linux-kernel+bounces-389789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842049B714E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FE61C2123A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D52C1E885;
	Thu, 31 Oct 2024 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOBC8sin"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4423A9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335664; cv=fail; b=kwQJajb/X+qbVnuW3jjMhOViti0smafCtD94dk1dp3TfU66ClF2EfLGbMMCKHvxqotx/2Kk7y1L8GmKwwMYGi/1v4wwegqzJ4UreNsgbABB/KGExT6LwbwKHs7/1gK3gQ9V8Oiu74Dlrdlc7Yh9CzHXAqFOiexVO6/cMZ89wOuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335664; c=relaxed/simple;
	bh=AcaK7/YqoyUA63o8GBO0M0eJMT6TPtWtI+wYUdEsGu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MAs8E6/92gHHpX/vNSiNpLuvhh4OJY49VwPgjCx8nIVMfBQ4v1NJotYRQSXO6Sca5NcyI+EOavGiiCB3hAh1NnxDE9k0T2CkRVYwgg+XHYzqkXavYIs7qwk9xFm9apDappShRhZtfUyHfnQuKlpxgEBv3acCfMkJyOpK8eL3S20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOBC8sin; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+zUspTiN4C0gGQdM5RgqMdtlo5aLuWcRANVO8w9M4HUx1EQz0dC5EOo+utSC4ADyXfZBrtj2jaznFuxc8R6VneN/4eq/rlDP9/QPWP9LeXWo8k9r4KTrQIeA/SRgB4V9HMOQsHxMfeONrMUvFwlgwoWuvuHInI4y2a3S3h30NPDcLo6cMkeBuU6PPE5mHCYEuXkZ34mSHfe6pR1S32de20i9J4SZrWRPLYgVzjubjQNivHhEyiZkfVD1eohVXKatMh78Lo3bDPRsuhWlD3rp1kELtCf/qfxQ39pD4CmfWR363NxsEsU35ldZlHQwX+JIu1G4Abi0uBvxUcL7XDYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLsdBHKLJyA0UY0GD+HlYk+NT8WqN1QbYmPjQZJhV/k=;
 b=gyaMkE0am5Bh4UERD/qmIx4wnnWN5C4a7zvCkFSFMJeEwkEzmQMIGVDm6ST4JGEwT+cnWbfaQWl6mrdEG/rv5ilBQ9qdU19nBW6eIGgWXvWrS72cFtM1GItp+BQT3JOWyzXUscL+b08CnrcM9wFTQwPGb5BSUCPBnrSEPojf1plsKJj7TmFRhOB7P1ED/Svg9bZ/2DX/8Kl5iQyrUkjgrMq1inFxPQFyxKsdZLJ5sxJPdmyz3gq3PJJ375+NZXaDcN9p1iuaRALNqvg97i6Pr9ksgsqdwp6ZamwnEBBYNefwsgv+mlgnWzm75K/p0gaPqNPxMox1AJ/FkmAQ4Wi1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLsdBHKLJyA0UY0GD+HlYk+NT8WqN1QbYmPjQZJhV/k=;
 b=bOBC8sinaBsbc0dHlxz7bHnSHdcXE0EyJEWESiQAqh1ro6kqxbD1dQwXcNM/YrVMXLJM4QkWfBgbddRyAJcXc6Rmes0xEdu8JObsqCdY5MxRtlic9cIVi2T/Te3rZWcr6jnIvxLKGS6gmmrdTlhY9U1NNoGbQBknzu8PPWvqZeKW8nu5mJ5G3WWR/04or47Tm51Nxqh9ww+VsU5TqmpDUkX5uy8VnoMjMzVaGKnVYrrOJ+vlN/bzPFtm77mzueFw+I5w0zcaVtcqhbreT0tuzxNSlwvYkKQCqGLU+2Hk4GI52UQqFOti444qKVbegamlDTeQeQPytMXR1jKj9f71/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 00:47:37 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 00:47:37 +0000
Message-ID: <a2b3f866-b7e8-43a9-a3e5-74d46032541c@nvidia.com>
Date: Wed, 30 Oct 2024 17:47:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Alistair Popple
 <apopple@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
 <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
 <8d9dc103-47c5-4719-971a-31efb091432a@redhat.com>
 <cdfadcd5-d9fe-4f90-8794-a563744ce207@nvidia.com>
 <20241031000218.GA6900@nvidia.com>
 <21ee9aff-a9d5-495c-9e5e-38e9d25b11cd@nvidia.com>
 <20241031002552.GB10193@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241031002552.GB10193@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 794af345-8b2c-43a7-6638-08dcf9459dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEhPUG5CaTlDb3VRampQdXlGN2JTWWpsVFlvRkpZbm55K3ZxRDRIZDE3U25C?=
 =?utf-8?B?Ym5QV3dwcEZ5M3J4NU1EeXYrNUhsODRNR3M4V2sxNmtHSjNWVTkwbEJGTnNx?=
 =?utf-8?B?VDRtaVhjNWdSZlprVlA3enc5ODc3emlRc0Q4Q3ZIRjVHVkFRcUU4aWJiWDRL?=
 =?utf-8?B?dnhRSFBjbWVrdlQ5YnRrUCtRV1FVT2F4Vkg3Wk9NYitXb1lJTkxXUi8rK2pS?=
 =?utf-8?B?NjhNTjNHaGVFdm1sNWVHczJJUHkvN3B4d01YZkVCejM4ejJKaDVMcWN1UVJH?=
 =?utf-8?B?V0tIQkJ5OUViVzdycHdOSWhiWGNtWDhpNnFtbWNlTVNoektEd01GR2tLbnkw?=
 =?utf-8?B?OGJyckVXK0JwYmxaOEVLSUNES1JuWWhJdzVqeFE2ZEJvTnVlTXlUZUJOVDRz?=
 =?utf-8?B?VUliNzRaVWkxSy92d21qdkVsNUN1WEF0TXA4USs5b1d6VHE5end0c3EwTjNr?=
 =?utf-8?B?ZW5UaDJsdHNSQXFPNzlaU29DWVZyUjhGRzNHZDhDK2lEK21YUjhWOWw5bGtU?=
 =?utf-8?B?TGszL1hYYndHTFlOcE9IUVRVYlh4SFFNbXk4dE16OFpya1hmUVVYSU5KZVF4?=
 =?utf-8?B?eWh5cXFicDJPZFZEa2c1citZRDB5bUE1ejZzeUVJdTJTZUR1N2VsWThoM2k1?=
 =?utf-8?B?d3gzSDhxTHdIbDdXbzAva3YwYlpFcjRmOFFmUnl6WGFLbjQrZkQzZzFtQWlI?=
 =?utf-8?B?RlFZMFhXQnZHd05GcFVYRVRkL2o3N0RCeHROdjUxQzhUVUp2aE1vL2JJZkZB?=
 =?utf-8?B?eGJHVk1VaitwRkRNT0E0Sjd0citCTmFQOFVFRmJtSyt5QU9nSWgyeG1OR2pQ?=
 =?utf-8?B?UklPcmNvNmwwZ0FLNFdPNXJoUWdUOUNaT1RwNk9yd2I3YjFEWnV5S0pmZSty?=
 =?utf-8?B?cjlSa0VBczQzL2hhWTlsMjVlcWNXendndk01N0dHQ3Uwa3FTRWp3OTJLMWcz?=
 =?utf-8?B?OGxrbUlFczVVR1hWbjlHODZ2RFVsUDU3NGdzcGplNE9ocWR1V25OQlBTNlhS?=
 =?utf-8?B?TW14SkdqTU9zbzJFZXhKNVRDZlFkeXlDVWZhVlBwTnIzc0IyVTl4UklabzhN?=
 =?utf-8?B?QVkxU1drVnZTbmdsK0VHWFZKbzFjNGNac3MyM0xHeVhFVkNnZUZmQ0ZVaUpN?=
 =?utf-8?B?UTRpK3hWY3I5R2RqNTMwVmZnRHFjektncUFyWlhhU2JLallydStmdW5mVTFS?=
 =?utf-8?B?NVlqSnY3dTJLS2VMMFBqaFIyTGQ5dVptQWRZcE9uNUFvL3FZMkUwL0F5TGd6?=
 =?utf-8?B?SlFTNU5Tdk9IUEtVbWtCQUMxODBuSnYzVFJwR0JPTFkrZFZGdnR3RFR5WHBL?=
 =?utf-8?B?bzNsZ09OempWZk52TldXb0pwamJCTjIzM2RpZUZpaitndFcrby9ld2phTDNB?=
 =?utf-8?B?TitjeFJOKzBpTnJIWEczYm1xb2ZiSXdxRmpkaUlZOEpKM2dkcXY5bWxnSCtM?=
 =?utf-8?B?R1pVbnVDZWlDc1Z0VFBZU3BSR2RUanc0YXdlYTZxY3U3Tmx4UmN1WGxSQVN4?=
 =?utf-8?B?Mm05eFN6bnNqZFY3RUVHWHMrV01UWnplVGRiczdjR1ZUZ09haDVjOVlOeHRh?=
 =?utf-8?B?WTZ4eVU3aDhRY3ViY3VjQlRpbE5VWklUbkg5MUdiNlpOcHRJTTRsZGwxUzA5?=
 =?utf-8?B?enZ4M3pvaDhsbTczUDZoR01WbHNnSWJWQ1l4ZHRBMEZiRGxpT1p6emp0bU9n?=
 =?utf-8?B?QjVpMDdTWk5HQk9HQ0o0RlZ4SXJYZWUwTHAyMkhZcFpobkFWNWkvK2UySFJH?=
 =?utf-8?Q?XSBtWMZxfp8T63zE4/uSkibnTBVevUv7auvjjpk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFZJYXpabUEzZk9hcmlNWWthcU5XT0RnSCtndFZvSW93YThuaU8ybE5VbE5m?=
 =?utf-8?B?LzJGOEhIbDFuaDJLRGlHN252Nnd2VFZSaEU1R0ZSMkhBRWNiVmxjWW1aQ0Ew?=
 =?utf-8?B?OVZIZUlyQWpDV0Urbnh6L1k3Vjh5dC9weU04Ry9rbVRHN1pUNjBPcm9MMDQy?=
 =?utf-8?B?U1FPZGc2TjR6RFExSmJMdVhDK1drZDhYYTNBOVVIVHVER3RSWVJob25CK09X?=
 =?utf-8?B?bFNMTWNrVEZUc3BDM1E5czNJdFlIdi82UEpXS3BmWXNQVGNSdm4vTVZxT0NH?=
 =?utf-8?B?QUxwTXZNNTVUZU5YektzY2hUazZTMFFQS1g2ZEpkcUptdHBHTHpzYW4zMEpZ?=
 =?utf-8?B?TlNVdk5FUTdEUDdVVmdjMzBKczhQdmlEQmVxNVpyc3RZUUFwbnMrb0FRSDdm?=
 =?utf-8?B?UEM4Z2dIOVhHVm1Wcm93Qm4zOFpWM2F3MXZKUG13TzdoSysrcWtMUG05OXJs?=
 =?utf-8?B?SkpTYkFRcUwwYjBvdmFEMFdGb01zdFliTVNzanErVkk5SDRCM0F0OW5iTis5?=
 =?utf-8?B?WFBTaUdaY3JHVjBuODV3THIzMkNTK0dEbnpFMVRaQUkxQk42TmxBTlBQSVFu?=
 =?utf-8?B?a0VSQnpuVkhHek4ybmZBSE1raWFnY0hpaC9wSi96VVh5cS9Xem9naW85Yll2?=
 =?utf-8?B?ZjhERkVnVnM2dmJPaFdpbTB0bEpzTjdRUnNveHlXS1RHbkpMOWliVCtQZVdK?=
 =?utf-8?B?RGFjaGRXVFQrNUhQU0taMlhHZzljT3Ftbm9KS3RPaGwyb2V3Mit6VUxqUlZx?=
 =?utf-8?B?WGl4djlmOWQ4ZmMwWVJaOFNxTXBwUlBjZzdRVU5GRjZmL1g4MjZrci9ia1Bu?=
 =?utf-8?B?bEZWNVJFVWREb2RHZUFoVGNhcVdmcytwRnRuVUNNc2tMdTlxc2J6M3B1dTg1?=
 =?utf-8?B?Y2M5RzZwdDNmV3FnMExIZWtMa0FVbFFrYUt6REl5cW9TMC9MR29JUngyWEJa?=
 =?utf-8?B?ZmpjaW9uTEY0bzMxVHltZC9PQytKZVRVMjJzRldvVXAraEc4emNsY3JKdkJF?=
 =?utf-8?B?VTVsblpPSHJvckxzVFFHWGFtd1VzRXVlcUVGdWZCRkJCNkxjMmZYYlRDTmp2?=
 =?utf-8?B?MnkwbnVPNHhTbjB5TGJnMVkyT0R0d21XVUwvQ1gyT0JFczlZRCtBZVpuV1k2?=
 =?utf-8?B?eHkwSDFnalppZVhIcjJiMWQ0blNkM0ZjZHlrYW5MOFpTNUZPZ0p4c0k0THZn?=
 =?utf-8?B?RjJ1clNMaGJtakJENy9kMFh3VWJMNGt6TmxHYWdwaGhQSHByTlF1U2lhOWYr?=
 =?utf-8?B?UXVqQVdpbENXUUhzSXpwckFGNnd1NFhHZ3FUV2xTUm5hQjFWZ05tNE5kbE5o?=
 =?utf-8?B?VFRXZk0yRy9ad3AxTzh3TndST2NDUlpWVUZCWlN0OGN3aUc5N3p5dkNtM0N2?=
 =?utf-8?B?Q2dtNnpMK1V3TDhnQ2Z4WGtmMlhiZUZ6SGw4L2JDbmNjQzk0VHJVNTBXYXNU?=
 =?utf-8?B?Q2JkSEQ3OFQ1dmZsamhhcEdIR0xQQjFVWmJxSkNycXlVK2E5aUJUb0orRGVj?=
 =?utf-8?B?bElUNk9mOWJ1TFdrUDdQcko4c3Nzc1BoeWM2aVJBM0duUDdhQ09ieW1FbVgw?=
 =?utf-8?B?SEduRk1oUEhhK3RDQ3ozaStNYVV1bEtiaVo1cUhhZ2U2UkdmT1laQkgyMCts?=
 =?utf-8?B?U1NQeHBPMzhUOXdyQk5VWU9jRmtnclNUVUQ2TEJmckRLYTVXSHE5WjNxL2pY?=
 =?utf-8?B?akZRNXJNWG8zTTlRTURCUnVYVlZ3M1c2UDk2V2txMUxjdERVZkYxUHdDMXBE?=
 =?utf-8?B?SVhNRmwyU0tMUnMyRHh5M202Sk4xS3hhYVExb1lBYWxBS1ZtOHQ5UTRNckRr?=
 =?utf-8?B?WFg2ZkhFa3B2L3hIS2xORVBPY2pqVUxzSHlqMC82amVzeW9LSnpjR3dXWDZT?=
 =?utf-8?B?djFHNFAydStOT2dBbnIrUmZyenJMZ255Q2xuYUZqQ216aVJYcG5BNm9MeXdB?=
 =?utf-8?B?M1QzY2Vua1Z5d1FyQjhjWlRzRmZtSWdqcllwZGhkRFNMRDVSbG9kckxRTnl4?=
 =?utf-8?B?L002ZTJCMVBmQ09kSFl6S3ZWWERBSFNHQWI3R2JPMDdzQUJMUFc1cXg5bDRp?=
 =?utf-8?B?bE01VTBQZVd4STZFN0tqaWlqMi9kd1VXL0d6WDVnMWpuTXhkb3VZOHRybHlQ?=
 =?utf-8?B?aStpQ0pzZ00rYVNYMm80SXhTOEl6VDN1ck01WkFSaWovZmFtcmJvSVU4dXUv?=
 =?utf-8?Q?MW1PcJWrCoXd23YtrKrYCjU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794af345-8b2c-43a7-6638-08dcf9459dc8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 00:47:37.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5LVK0MyBX5+9Zm5fa+snAfp+61J35DRauWu8gP4L6TAdMBAdq1TuqWrmrkBqZ+P6H5PiMLEWCjw66Pin7FX8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238

On 10/30/24 5:25 PM, Jason Gunthorpe wrote:
> On Wed, Oct 30, 2024 at 05:17:25PM -0700, John Hubbard wrote:
>> On 10/30/24 5:02 PM, Jason Gunthorpe wrote:
>>> On Wed, Oct 30, 2024 at 11:34:49AM -0700, John Hubbard wrote:
>>>
>>>>   From a very high level design perspective, it's not yet clear to me
>>>> that there is either a "preferred" or "not recommended" aspect to
>>>> pinning in batches vs. all at once here, as long as one stays
>>>> below the type (int, long, unsigned...) limits of the API. Batching
>>>> seems like what you do if the internal implementation is crippled
>>>> and unable to meet its API requirements. So the fact that many
>>>> callers do batching is sort of "tail wags dog".
>>>
>>> No.. all things need to do batching because nothing should be storing
>>> a linear struct page array that is so enormous. That is going to
>>> create vmemap pressure that is not desirable.
>>
>> Are we talking about the same allocation size here? It's not 2GB. It
>> is enough folio pointers to cover 2GB of memory, so 4MB.
> 
> Is 2GB a hard limit? I was expecting this was a range that had upper
> bounds of 100GB's like for rdma.. Then it is 400MB, and yeah, that is
> not great.
>

No, 2GB (original allocation, thus 4MB real allocation) is just the point at
which the page alloc code typically switches over from kmalloc to vmalloc
(internal to kvmalloc)--for a freshly booted machine, that is.

For some reason, I've had "a few GB" in mind as kind of a "likely as much as
people will request" limit, rather than 100's of GB, just from what I've 
seen.
However, I don't have much additional data about how user space (which 
does the
allocation requests, in the end) behaves, either. Maybe it is actually quite
rare to do such large allocation requests. Or maybe not.

But yes, if this went 10x+ higher, it would definitely be "too much".


>> That high level guidance makes sense, but here we are attempting only
>> a 4MB physically contiguous allocation, and if larger than that, then
>> it goes to vmalloc() which is merely virtually contiguous.
> 
> AFAIK any contiguous allocation beyond 4K basically doesn't work
> reliably in a server environment due to fragmentation.
> 
> So you are always using the vmemap..
> 
>> I'm writing this because your adjectives make me suspect that you
>> are referring to a 2GB allocation. But this is orders of magnitude
>> smaller.
> 
> Even 4MB I would wonder about getting it split to PAGE_SIZE chunks
> instead of vmemmap, but I don't know what it is being used for.
> 

For a 64-bit system, I think we have quite a healthy chunk of vmalloc() 
space
(ignoring, with some effort, the multiple KASLR bugs that have been recently
messing that up), right? I mean, your points about keeping kernel
allocations small or at least reasonable are resonating with me, but it's
also true that the numbers are much bigger with 64 bit systems.


thanks,
-- 
John Hubbard


