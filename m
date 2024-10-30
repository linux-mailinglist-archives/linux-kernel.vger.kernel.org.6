Return-Path: <linux-kernel+bounces-389318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807269B6B50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48E11C22ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156F19AD8C;
	Wed, 30 Oct 2024 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o8oxltlU"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0F194138
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310592; cv=fail; b=p7r2SHFxqwvFCceIrqfEaXomNVd0CNn61a/3yy7/bh1XmyZT8dRJX3LuQhjlBwwOB9aDIvepRMpgsUk9xPQj2UX4DjmiJNc+3EOsxpDxhtVB6VlMHFYZau0i7mbhfbgPLGvn9jPXGNUlsxG3mcveh6Vr9OWa0HIB8UZTOrRVtts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310592; c=relaxed/simple;
	bh=S2kVW1RZnhs1XGPv+H1UPaXOKiwABi0rOExepJAXNYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DkqoOXvJplOb9CblDg17/SEuSZXjthshZ05t8cShVr9IugxdT31paz5gVUF67eI0VP9IlwY1TosnCE+5vnH4ja1a8feVywxVwHd4L/UtXnw5CdSj9WibWmWcczj46XrGek0R2kEu6lAx2078bedC4Do0aQiO7EmjbiBYCz36mrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o8oxltlU; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHtqHEEhSAT4ZkjTFhPqx/cpw8k/V8D5e8pT/25vp9MO2S+UbawoBnJp+bHTF8/5TK9wp0zCUk8gQFqNDpFOeT0HmONuIqG3g3JMyZJDd6l8xT+dSVSl+e9N57aJZcqohrMTCvFQLR2ouitWfKMcN6TprQiO2aRBIYf6a7VRtnEH3dvNgAypxe6DPuH+CcxeCsZyi0alcu1Fh4RVWpinubExtcDnFf6QQNgR8GdFb2sLQDyopKmCUs5fLcd73uRptvE3E/c5Y9QbuWpO0zH+6R3YQwSCyFxTRtuXTuuEytFwKVuKKLz8+2yFchUy8Bo7PP+Edu4UIz8FT7aWKdqc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjW/si28/i39oMlJ5hMib6/bfqPMamXKem3ZtVeU2JU=;
 b=aEmAp3iyOOFW9+ETnCyMSy88SEuHOq6TGdDQ3dMN0pBq77gWKtHNqQ2xleKdSumw5X0MtTEni3MvpiewJ5lnMMT0Zcx7ZDqgbcz5mikOdQlugiaXPBkASnzp9lEp3Hl/SnHQN/OCpUrfuI24p0WWam3eBONZrZ4zbDnZBWmUsdve+vbtCSN5v44GBSr/TG5YUYNLjJyBWGbcQiIYkmLJBVz5tnjbsW5Iy40GnRIYp5jUHOgirbTZdgdUH+nr8U5bBFNEOqPu/wjFguYc8nFC0p994PLbmX0dyrJrqZE3U8WT0tVrkQOBM+Z1OheYQkQPlfu0b2Cw2Dj22c+u3qMZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjW/si28/i39oMlJ5hMib6/bfqPMamXKem3ZtVeU2JU=;
 b=o8oxltlU48cPzs+CkxCQ/cGo1xO2dwf6txLjRmN0fAOMzLeJKmJCrg9i3Y1bMk9HaLG3iV0uUvr86l4JvtUCCF7J4bekRnxrE5qBVVfIRY6hd0ELu9cqaFPoV/vNDNi2+1srvcjjJwkS0wwY0w5f/eollKZ93jskAdM8q8wYwOYpv7anpSdDSxV6y5DZrAvQjcpXQfcJZaKUZDUWHrOdwvxks41Dm3oKnpHW7BIKkfjfBEaUsqFeJFYU4Sis75DU/D85vtj+KTwJs417C5Z3TYp/YAVhsT4j1j5931Z+BK5kTQNcI38GR+8+lGA8GCjQ5B6upk59zpefFXTVTYO8Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 17:49:46 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 17:49:45 +0000
Message-ID: <6b6b8477-921a-40b4-b689-36080981a134@nvidia.com>
Date: Wed, 30 Oct 2024 10:49:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Hellwig <hch@infradead.org>
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
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <87124c1d-5b95-4499-aa4b-22f2ecd376bc@suse.cz>
 <ac06dcfe-c370-4a37-9d1a-2b2c2ef076aa@nvidia.com>
 <87aedec7-3890-4a35-9f72-b4edb8e1c390@suse.cz>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87aedec7-3890-4a35-9f72-b4edb8e1c390@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::20) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: e091a842-2e82-4972-8a75-08dcf90b3dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3FkS3MrN01ERDFuSnV1aXhPaUhtSXArWlpDOTNlU0R1U1I5VEd4Z3dJVnlW?=
 =?utf-8?B?eWlkRUF6Z3dkeStremoyVzhZM29IUG53aHp5U0o3Q2NweXJuZEhBeXYrWUZH?=
 =?utf-8?B?cXVwWU10WC83Tkh1S2ZIbUcvd01nbUZiang1cnVYOEhaVkZBV0p5MUpUQXBJ?=
 =?utf-8?B?TUFyRDhHN2srK20xNG1HanZ6Y1NHczhqdjMyTzh6S2c4Ry81K1gzcUpWT2th?=
 =?utf-8?B?WDNJd0lES2tRY1VhZXdoRkZuak52RjFaTWR1amZEYklWb003N0pTK1VuZThF?=
 =?utf-8?B?MnNIWHFCVmFoT1U5cHhTMjJQbHc2ajJodm1BR1IyenNzZ0M2YjRzcmZvYUtk?=
 =?utf-8?B?dXMweC9qZDNFRkNQdldMdk1GZnJzY2dUMkd4Y3pZV0JnbzVMOHNUcjZFbGpU?=
 =?utf-8?B?eFhKZjBlbGxDblpWQmpJSXhlSHdyKytoWnJ1UjZ3OEhpM0ZMWm1td1p3NmRO?=
 =?utf-8?B?V2pDQlBGaUZrSTk5Tzl1Z1FHcjlRUCtwRForZ2tTYjBoKytqQ0hJMk9tYWZE?=
 =?utf-8?B?eVJHaU5leHpVTGY5SFZINHRZSFducXJtUWduWTE1SFRtZ2NqYlNzanZiblgv?=
 =?utf-8?B?TjNkbVVNbzVycTJHRTM1UlpWcElqa2Q5TnJ3RUh1YmlYRUtha3RBRGFRU096?=
 =?utf-8?B?WFNWbkJJSkVZdmdpaXl4QU9xMUxFQVNzR1VJMjNEQ3YwMk5KMHgrVWFkN2c5?=
 =?utf-8?B?eDFGUTVjdGJKbXJUdUZIVysyZFNlTnJGcnFkYjRTa3VRbkdsZTl6L3RLOUo3?=
 =?utf-8?B?Q0RNUFlhQ2Rmb2VxMnAyeHV1SDgxU2l6Wkx0c1IxZ1BUOExBT1dzczJYbjA0?=
 =?utf-8?B?M3pJbE94Zlk4RFcrQTZoWWFYV2U0VDZwY2tZWFIwQ3llckZWMUE2YTQzRXVL?=
 =?utf-8?B?VVAyRjFiTWRENnRtK2hPTWVqa1Q1SEorWUhOZHN0REZ3dHQ3ZVp5K0ZXcUdE?=
 =?utf-8?B?MkFheG5YY1dRc1VwSWdvOTBnZm1WYnlZalVsM013N1FoV1VSSUlNaVFoUkY2?=
 =?utf-8?B?OE9ybldOeHBNV05MdStFUm1yb04ycWswZHhTZWpSb3BGWEVIcXJHVzRxTXRZ?=
 =?utf-8?B?TWxpYWNnVFZVSVZSK0xqTWZHZjJlV0dJWHVtSTVXWXROa2YzSVJlWEJkazIw?=
 =?utf-8?B?ak95ZFdrdEg2QWkzNDkvaloycFRiQkZ4YjV1SHdLWnc1elZQdGNqNlhDV1RW?=
 =?utf-8?B?YWw1SGQ0K25rNnl6ZHExb2xSTTFvSWtoKzlrYldYU2RPL2lKUzRNbUFCWmdJ?=
 =?utf-8?B?cG1zcUNRd1NaOTVocVpGQUpHYUhkcU5WZmdyVmFZaFBFYWVURDdmV09zQWZX?=
 =?utf-8?B?K0dnWmI1VUdmcWt0L3JRbW5TNDZOUjY3dmtTVVZ5WkJzdkVwa0tVeWpKVVpY?=
 =?utf-8?B?U1o4QXd5eDdqVUJJV3BEUWFMcXlYOVgvU2c2QjcyakpGdC9FUy9uVWJPaDNm?=
 =?utf-8?B?WGcvTmluT2RjYkFsTTUxTjFPUWdlNisrV0VncHcvTkd3Z1BGWFlTSXJwOW1B?=
 =?utf-8?B?cm8rUkRKNCtrVkx6R0NhNDYvOS93TkxaelNraHoxTHUzN0ZWUWN3Umx6WTZv?=
 =?utf-8?B?R2FGMUtYelVRbDdyQVRBRTQ5SWlSa0ZaWmFvU1ZzbzZSS0lYeTJhZnlkaFE0?=
 =?utf-8?B?b2pmNGZzZHVoZW9idlRXeXplYlpGYklhTjJ3NVluQ2IzSVdYM0QrQlVpNjBi?=
 =?utf-8?B?Tzh0R1BrWURmT2VITDF5VzVjeFpTRTZWaXRNajAwUGtGYkVVVHBxelhGM3Zy?=
 =?utf-8?Q?5uGPTAVBZKizBD5fGYCWntqgY3017fxMT3Z3UIG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjlURncrMVdwNTI3UGZYWnRyTHZLL0hMZjlpM0NROStqTE1QR0xLSSsrUk1M?=
 =?utf-8?B?U0lBYmNidGlMVzZTWHhUbVhSSDFlNFI3d00zUjdrSFJKKzRVVVB1UTROTWVQ?=
 =?utf-8?B?WlFzaXRBRDdJdXpaUDE3TnJZdUdXOHlQNHBnOC96VW1nUjJacEFRRStqQW8z?=
 =?utf-8?B?REtiUTRBUlNzK21CZGczTDVIOE9pN0RrOXhnTE5uYlhLcnBNNGVZUFNLOXRU?=
 =?utf-8?B?R2VtU01Cc2NwTEhUNlN1RTd0dHV3cE1FeGN5MDRZdVloK1VoeFRpUG9uQnRR?=
 =?utf-8?B?eHJwMk5hN1VXR0VLcnlYREZKdnlGUjJ0dUx6N1g4c0xtRHBNMXAvRC9sK2Nu?=
 =?utf-8?B?cklNL1NsWGxYK1NueWRHTXBBYnBteFM1UU1pZmpHM3pqRkZhSmdQSFFhbWlU?=
 =?utf-8?B?aThwckNqRHhYcXQvTHM4aTBoU2RzZXdPVWVSR3hNOW9uU0tXTHgzRWhLK0No?=
 =?utf-8?B?QW02K2tWeHFJWHBCcjZsNVR5bjVBMldHajF1VnU3eFpDU01NS2R1WGVxWFVt?=
 =?utf-8?B?LzB3RWQ4Rm1HdFdVcWV0SGR5bjRhYTFnUHphR3R4ZFByaTRzUWlIcVlCbEZO?=
 =?utf-8?B?bjY3RmE3aUw1SW1mbGQ1L3FoTHJTSW43R25EVmZjaXNGZ2VnNjV6VmcybWdD?=
 =?utf-8?B?TmdlYXlnQ0lvWlNFSVBKZWtFcTRFTlA1YThKQ3ArRWkycTJpZUJicUtSeDRz?=
 =?utf-8?B?UWMwNFJJN2xVQ0t2VXNuWDZkM09xRVdHQW93ZWg3UDdLdXdGbEEyWlJuTk9K?=
 =?utf-8?B?cmVLZTdCQk9GVW5pZmE3VDg3V09KeFdqSlA0THN6SDJ6aXNadVVxL1hOSktj?=
 =?utf-8?B?R3RGRXEraFQ5TENYbStJYWRGQTlwbnEwd2hkQ1g3Q2tUdGRqQkFuM0o1Q3Iz?=
 =?utf-8?B?VlRoZXk3c2gyaVl2YWpHVXovVEVOdkdCU1pIRVRadzlVa0lqRk1MZFNuUGZi?=
 =?utf-8?B?WCtRVHEvcXVuMGR6cG5qRU9vV1FHaHNjZnI4RWhkdytSMGJHTUF6QzNKVWZX?=
 =?utf-8?B?aFRoVmlGVGc0ODQyVUpkdmcvQ3JZMEJ5OHI1V0VGTTBNcTFUOWQxSnVGL2FX?=
 =?utf-8?B?dnpLZXNLVldMWnhXYk94amE4UnhqMlVmWW5MUENrZHdiNXpRK3pnanhBbHR1?=
 =?utf-8?B?N1BEWEdNeU9VbUVkeWgvak50Vm02R3daUGJ0cm9PejRTcXNWYkk3d1dTT3lX?=
 =?utf-8?B?N1lFQjljdkNEQ0lOWHlHcU9ORGkxajhGcDBYQkVRZ1RWeUUwTDZHeSthU1lK?=
 =?utf-8?B?WUNYc0ZJRkF3Z0cyN0wvQUNqNjgwUnE0c25lQlQxWGZaWUdHUUdid2Jhdk54?=
 =?utf-8?B?UUNFdUQ1YnpJZjJXWDUyK3lKZGlZUGJ0M2R5WC9ROStTOENqZTA4bk1CYk1v?=
 =?utf-8?B?TjNka0tlWTZoYkZNZHdIZ0Qvc1BBeVJwVzNxdnNUendJWC9Ibll2UU9hZmw4?=
 =?utf-8?B?b0JrSWh6UjhpV1libU5BR2hyQS9tMy9JZ2RaTWtFbjYvSlJLRXJoYS9Yb1pQ?=
 =?utf-8?B?OXJ5MlFlSDErelc4ZmpyWFZtcVY1N1NzVFZmcmhDOTVTU0RHSnp6TkRtd3lT?=
 =?utf-8?B?WXNrVzlZMFBNWVFxY0xadDluYnV6anlpNXptRmFJbVp5UjRNUTNHVWhUTFJz?=
 =?utf-8?B?V1ExYStDaStxYXJ3aTR0VUNrU2trQThYZTI4T2lrVUZIMWZ6Mm9tdlh6Slp4?=
 =?utf-8?B?VFRtSFJTSlA1S2lLQjV1T0FKcEVTcGR6MXR4Qm1Kb082cFRSelFDY0RtUGJS?=
 =?utf-8?B?MzZVZWVUZ3BqNDFram1LbGZWeTRjNU1nZlh5eVFRKzZFM09rQUI5bkFWVm5B?=
 =?utf-8?B?ZVpLa1lvaXBRYmsxdFRwa3FZVTkxK09JSm1xT1RqUlNHdHVOa0p2eWFobXNU?=
 =?utf-8?B?Vnd6d2NYZTBIZEpRVlhLbkRKOEFiR3U5YURVcDNIY1ZGYktuNW5XRjJVS0Vq?=
 =?utf-8?B?dHc3NmhScDYvMVlKcWRCY2ZFUmZtNE9abXkyYmxlenlqSmZTenVVd1NMYkpH?=
 =?utf-8?B?ZHdBeUVxZWJaMTlzcTZRMDduZzJOZUFNYTBmNW1EMjg4WXB2anFJUWhuVVFK?=
 =?utf-8?B?NHltWHlObkE0dVFPUFNNSWdHU1VTbGFGeEQxSGZmMVpFTXkvWDVaemJON2Zp?=
 =?utf-8?B?T0gzZVpvelRsNUJUb1hwZmZCem5WNGxaNmRKVnBDMVlWMkxGVkRJdkF0ZEdO?=
 =?utf-8?Q?/iOYlmU4Mb5qzg2ulc9oP84=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e091a842-2e82-4972-8a75-08dcf90b3dce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 17:49:45.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBJSOecB4lMtgXb06vstTQI7xb0tuKpp0CxybrOdwwOSVFtQT8WsjoDjsAZOws1ie+vg8sG7uCHaCc9/qvB5OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

On 10/30/24 10:42 AM, Vlastimil Babka wrote:
> On 10/30/24 18:29, John Hubbard wrote:
>> On 10/30/24 4:03 AM, Vlastimil Babka wrote:
>>> On 10/30/24 05:39, John Hubbard wrote:
>>>> On 10/29/24 9:33 PM, Christoph Hellwig wrote:
>>>>> On Tue, Oct 29, 2024 at 09:30:41PM -0700, John Hubbard wrote:
>> ...
>>> It might be a regression even if you don't try to pin over 2GB. high-order
>>> (>costly order) allocations can fail and/or cause disruptive
>>> reclaim/compaction cycles even below MAX_PAGE_ORDER and it's better to use
>>> kvmalloc if physical contiguity is not needed, it will attempt the physical
>>> kmalloc() allocation with __GFP_NORETRY (little disruption) and fallback to
>>> vmalloc() quickly.
>>>
>>> Of course if there's a way to avoid the allocation completely, even beter.
>>
>> Why not both? I'm going to ask our driver team to batch the pinning calls,
>> as recommended nearby, just to be sure that we are following best
>> practices.
>>
>> But it also seems good to use kvmalloc() here, and avoid any other
>> regressions. That's also a best practice.
> 
> By "avoid the allocation completely" I meant David's proof of concept
> elsewhere in this thread, that seems to replace that kmalloc_array() with no
> allocation :)
> 

aha, OK let me look into that then.

thanks,
-- 
John Hubbard


