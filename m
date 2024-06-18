Return-Path: <linux-kernel+bounces-218468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BBC90C04E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3387A28308A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFC84C84;
	Tue, 18 Jun 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="uQE5KhaC"
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68B17E9;
	Tue, 18 Jun 2024 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669905; cv=fail; b=MqY3VxmjFYUPVHYwnOgez+83mkdYnBlDygaH7KSsJPy1zixzWqW1pdxDQl3de86aOwznD0CCw7isaLxj9s/YFvqrvdN3wtJdV7spBlvaLUDIqGIsXQy8Xly1KJiFqdZmndEYcRTT2lC5pSHtd4EaXHcIUTUToG4orwcbB0TLy34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669905; c=relaxed/simple;
	bh=ygFpbdVCY3VPhwjX/R1SfK895SkPa4QLgSw/Aj9+lw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YNfwDqCVA+SmfOGr7G0kvDAtUQej+sdf1mi4K54ucYqzQy4oXET+SDpg77WQO5NMxpMJ1wgxy0/p2O+nq15gbr65BQDzjUPQKroP3A+KO7VRNuPJdMzrs+yUIY0j6Zc5OP2Xq3VlOeV/c+4IWTzTNO3ZcG8AfKfYDXmABPD1F9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=uQE5KhaC; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1718669902; x=1750205902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ygFpbdVCY3VPhwjX/R1SfK895SkPa4QLgSw/Aj9+lw0=;
  b=uQE5KhaCRj4vYMgLm7W723+t6P+76EcICBI8MtWL2yRV15S0wnl6w2O3
   kcFuupb6DOHvifXKySsR1PqpsaSef3HUoAQdn9BFoYQy62NyT/MH4tfL1
   7DClxHvllg3yqCJzTEyyy94mPBrZMOnsaIokYb4aDE09sNR0D36QU8eKZ
   amRwDjP9ntU2BzJ8INvo18pQ7C2lZxBC4JmJLdU4V0onammdPzH86j792
   6EiydCjcEs8lPlaEbSp/ZuKrN9J81rGNReBtsjlSHkFWAU3yxTLnDgkyq
   /MntcJFAxN7NiKTl2iZZMoj7TWZiqO4WD0y1laxWYDwDXOen4k9NNQndI
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="122407806"
X-IronPort-AV: E=Sophos;i="6.08,246,1712588400"; 
   d="scan'208";a="122407806"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:17:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gld9LHNUL5SA6hYFC/qp4cCEagwu1lOn8WZrk1moHR8hlsTMhVLj8Dv0m8qT2RFjFUyHXlS/1KcPxpCE3kGrmS3qjysGffcKPlQqo8UB5JSzxXWul5pst9e6/mYBRtPyOOAGwnszCjcNAbYvx2jKVE5xvGLAla9ZU9ITSt8wcNRcxRqf6mzfWE6mCJh5leyU6TS3FvPxPQUerQYZgADYAObEWOxoIyNBFO0PXAPRMUn59/l/GE/wmDQa7npZETwKC968RxbdyhWrGzhA66qLrf+67rqJQbGisxZtOrjeIqymmTPA/1YmKhWEGhFuD33DzetNAtzOu4klZ2PAvM96fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygFpbdVCY3VPhwjX/R1SfK895SkPa4QLgSw/Aj9+lw0=;
 b=l0/DUlM2ewhRxlSXn11eh5QYjqf4dWFgDc6fyScYhEdbbl47byrqBXX7S2YJ+lNCDMlebz8EiVopAd6TnhoE6kZvLFn9CzamogZfxd6rSZ42rJNRDI0kyKfHOfLx12PS+xsmyAxx8TUYSC7n7/ViVjpzvxzRQayvtvvj/3T6WVQcB+KHaN5GNUCagG4O1r9slinboBs2nf0f6oXAW/Ff1ddK86IUEr23J34oWyI+jbVZlZDUzSmil4wDr8vLGgR+bcsoemCM8GNdjTWGlcF6xxhaUlH1YPRJ85FfMQsI6Vie6ruKd+3K/ijNzNkm0uqCDfSiKAlV6ZCuDexoN/JDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB6774.jpnprd01.prod.outlook.com (2603:1096:604:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 00:17:06 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:17:06 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: exception-tables.rst: Fix the wrong steps
 referenced
Thread-Topic: [PATCH] Documentation: exception-tables.rst: Fix the wrong steps
 referenced
Thread-Index: AQHavfZEvk8iBJrZk0WK8fRycfgz/rHMk5OAgAAaMQA=
Date: Tue, 18 Jun 2024 00:17:06 +0000
Message-ID: <8f4defbb-eee8-4c66-baa4-7c5da792f673@fujitsu.com>
References: <20240614010028.48262-1-lizhijian@fujitsu.com>
 <874j9rgph4.fsf@trenco.lwn.net>
In-Reply-To: <874j9rgph4.fsf@trenco.lwn.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB6774:EE_
x-ms-office365-filtering-correlation-id: 0d099ae0-feed-4d83-fe25-08dc8f2bfc72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|1800799021|366013|38070700015|1580799024;
x-microsoft-antispam-message-info:
 =?utf-8?B?UE9YdWJvcGhtMi9Vc1JZMHFwNkFndnhEUVo5U1JEOHpncm5COGVRbGRScTVG?=
 =?utf-8?B?YzhsUnNIQlJVM2IwYkkzbTBPd3pZbFZHR1JEQlVCM2hTeTdxWFFWZkVnODJs?=
 =?utf-8?B?R0dwMGo4M3VTWTdjajBZT29mbW5CS1Rlek5Ud2Q1dnZCMC9xY05mTUhzWllv?=
 =?utf-8?B?V1UxYVlDY2FqWTVOa2p0RDlWUHFBZTdrdkNza0xGV0tLOGRzR0k2Nm42aUpM?=
 =?utf-8?B?Unl6bW9KOHhKN1VsSlhLQXhRK21ncTVLQUU4NU13SEczL1ZzWENWbk5wa0NL?=
 =?utf-8?B?a2piWjRLaDhDdGRSVU14Z2l0YlNHRjBrbEhleTg2dFF4aktWSjFUVEJRY3d4?=
 =?utf-8?B?eGROdVlwZE9UYzQvajZUVSs2YnloN1REMHNHdUhPRFVNd1ZyWHZvZkpmNlRV?=
 =?utf-8?B?RTdYZlNQRFIyRG8wSUJJdVZPZnJBeStPbVoxUjJwN3NSN3QvbGZDUGxXRXh5?=
 =?utf-8?B?YTh5cW5YWTdiV1o5T2JYYUtldmpsUUdBb0dmeGZJa1ZjZWhwdVc3QTdEQjNL?=
 =?utf-8?B?VTl4N2tVTndiUThaQTlnWWlEZHE0UEppZHJGbW1kUExYbUg5WlRsd0FybDc4?=
 =?utf-8?B?bThvMmx5V2VxUC9mb2hVbXphMmw5b0x5Ry90RzUyc05nNFNpQnFkK2psSVBW?=
 =?utf-8?B?RU11UjhQK3Faam1rbEN5ajJWNWdxRzBJaDlTV0tLMjUzUkpwandVZDNXK1M0?=
 =?utf-8?B?b3dtcEJPKzdpZEZacld1S2k4YmhHY1VLM2dBWWoyQUJpRDBWWDdYd0trS0dt?=
 =?utf-8?B?cUFYcG5JTnhYaFczZ3VFUUZnN2ZmUzZSN1hCRnhqUWN1akYwR3VZOXU3djBZ?=
 =?utf-8?B?SEpPaHNPcG4wZ3diOHRKM0FEMWZEWlpJRzd1M1Ezb3JNNDNzQ3VRWHJEdzVE?=
 =?utf-8?B?TzFsRGNJR0dKVWJrejZGQ2xrOEtreUhWd3IxT1p4MlloWC9JQVN3dXRhSUty?=
 =?utf-8?B?NTVKRmt4Q1dHb3FuTFhtd2w3QVZpeWlyQXo1YnVRR3B4Wjh3SkRHSElCL0JN?=
 =?utf-8?B?aGJLczdNajZ4MFBLSTNsTkVRN3EvQnZTQzd3VHVIbGdnQktOSnlGMk5jNFZM?=
 =?utf-8?B?cW5maTJBZVFvRXpNTDZQVmk1dTRDMk50M1FLY1hTWGlsamZkQ2IvNHozWWhQ?=
 =?utf-8?B?eUhzYnhJTFFTY2FWVUdZckhBc3poMUtPNHdDRFNSaG1jYUduOStmd0NGc09x?=
 =?utf-8?B?ZEtUQ3Jsa0JmZjVmT2ZpZzUvY1VyMWdXTzRYckp4OWg3WDArSXAwOGwrYnJh?=
 =?utf-8?B?RGtsako5dGNrZVVYM2pCVHN1THp2dE5DRk05SUNVZ0oxZ3NDVnJ5WVVZZWoy?=
 =?utf-8?B?R2k1dnA2cVZOSDNEa0IzV0FGSnpXcnVXZXZwcmVVN1UxRTJoTkpKSzZrOTVV?=
 =?utf-8?B?R09UaEUySnYvTzJVcnBoU3EyN2FHbEVJd283YlY1YS9HeTludWZJdkxCaUlE?=
 =?utf-8?B?dWVlZzQ2ekpJMzhxUmxSbVZUTmZmalFkd3poYnFwdlM2dDQ2aUZYWmp6U2I5?=
 =?utf-8?B?RkFnMjNzamJOdjNiQW96aGNaR3dUa29jVS9JS0UvV2hROXNvREU1MTB3a0NU?=
 =?utf-8?B?S05lNWczaGdoTGZ5dmh3ZXN5QTdQMnl3SktwN3gzcnJQa0p4WjduWTBtQ0pj?=
 =?utf-8?B?MHhzZ3ZGbzJzRlpHMVh4eDYwM1lWUEhNWlh6YzQ3RzRCN2R1SHpYU1M5WXht?=
 =?utf-8?B?UlJNenI4eWN2Ui82SUxobUQ0VzFFSmtyaXY5Yk01eHJQUWxpcGxrZnFocmps?=
 =?utf-8?B?Sy9Ec29abXlaQ09sR3lhMjVhOTZBVjBBUkpqY0FQMW96TmtXTGJRdG1td0R2?=
 =?utf-8?B?YS9wZi9Sbmp5a2tnRGIzNjBGdXZad3oxZFVvK3BEb1hFOGVvVU1tSFQxb3NK?=
 =?utf-8?B?V2NsVmczcy9nMno0SHJ2bFlBRTVzektrU1FsbVZKeTZ5OFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015)(1580799024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEJnMDdHNWRjTU5QbzNnZ0tkak9OU3JZRnIxaXQ5RnQxOXZLWVVzNUJTN01I?=
 =?utf-8?B?aWhCSkQxYmlnZDEzdmFsbloyRGtBZExYbnVMMitnbkdjWUR6OUhXUjBvdTBi?=
 =?utf-8?B?VkZVSXFNc2VwRFJ3Z3BMTStNdTFqbFc5ZWM4OFlzeGhvQ1FpNGMwV1RIaisr?=
 =?utf-8?B?VTNWMWRKVkQ1TGFpV1Byc1RuZzhqa2JuNmQ4QkJLeWtlbFFVeUFMeWtVa0Zh?=
 =?utf-8?B?QnpxL3R6KzlvUTg2Ump4c0NKQkhVanpoTzR0RzJXamtwZGFVeEhKTlFpZW9s?=
 =?utf-8?B?YlZWS2NHdmxwRFdGR3R0UVUwZUd0VWNJK0NJWXFldkNkeXlxZnN2SXh0bDVE?=
 =?utf-8?B?ZlZUcnpPYm1QeFFEQ3gxZ09CajVvb0RRRUJHQnp0MWtwYjVWL1I5cGh5Z2Nu?=
 =?utf-8?B?T1hYbkRWTTVCRXlXSkpUS01HYmVpWTc3YVEyNzNOTFg4K1VzSVU0TmtiK1NW?=
 =?utf-8?B?NFRtT255VDcyY3R1SysyT3Z2YlRSdm40KzBKd3ByRWMwQ3pMTHBsWTRVT1pW?=
 =?utf-8?B?L2NmdDhyM1l0T0hqUnpmVXJrQ3V5K1BRY2IrSXJZdUpzang2ZWNML0ZQbWlS?=
 =?utf-8?B?K3NaeTBLTE9qR1UvYS9MQVdhSGxEMTVWWWNqR2FlcTFTOCtydVMrVkRlSnNZ?=
 =?utf-8?B?bVVMWHM0SWU1Y0NJRE9jNWRHVFVCM25SL3BMbWFNMVlteUdTNTR2Mk1BU0Jn?=
 =?utf-8?B?cC9BTFNYbXZvYzgwQzV5THZCTDNhb0VzdVZqWjJmV2hWdzZKUUV4UWFvZDFj?=
 =?utf-8?B?T1JjOFhGMHZVYnlnU0JGSXJ0SlNmdDFCOHBiZnB3Vld5MTNqNWJUWno4aDgz?=
 =?utf-8?B?ZUZWYURtdlIyZmlFS013c0FWSzc1YTBQUGRhckxZdzJjcGxhdVFDTkM5UUEw?=
 =?utf-8?B?QVN0YmhpVUJwZ1JlTHd3VVlHSElVNzZ1VWZncmZQL3pNUndzK2t6cjFFckZt?=
 =?utf-8?B?R1JoNTJVVlJraGNGNUhrZUxEQ2hkcUpYVDRMZTA4TDBwMjBWMDJ3a243RHNo?=
 =?utf-8?B?TFBFS21JQmxmcHBhYUFzd1JuUE5DWVB2c2RtOW1PQ2o2QURGVGFoem5obHQv?=
 =?utf-8?B?RjJtbnhPQXkzMldhRjJYOEpvbERrSlpveExnKytCdGFWZ1lTL1FVNVRyK0l1?=
 =?utf-8?B?cFA0aUk3TWp2VVIwYTZIT0NaZVU5STY1cDk0OHM3REhOM0lhQVZyZXM2a2ZH?=
 =?utf-8?B?V3p5N3B6bmJzMXc2R053ZjQ4YnRNdlkwYmRER0Y3UE5pQmtSV1hQTi8vV3pq?=
 =?utf-8?B?b3NGQWZuSW9CMVlYbk5NMzlraGhDcEx4R3FJcTlCSmc3ZEkxMlpDdWI0ZlZU?=
 =?utf-8?B?czhJYlUzZE9jYlM3bCtSZVFKcGlEZXVtZVZnenpoeW05QjhhWVowVGJUbUVM?=
 =?utf-8?B?b0x5RHR3clRyRzFSK2s0TVlHQ2tLZ05nSzJRbTNQU3U5Z2ZCdHkrcjdpNVhE?=
 =?utf-8?B?UU5XZ1lvcHBxQUhxV21VemJ0WitDTGU4bGtibmkxSXNYdFI4U0dLQUI4QmFh?=
 =?utf-8?B?VzJjZU5Gc2pkUDRVOCs0UWd4NVJTVm1GNXFkd1dLY0xsbmpWQ0NHZU1KeHRG?=
 =?utf-8?B?NGgwYVpEdVRVMXZlcGFXMGVVVi94VFg5NE82Qzk4WDIranNmd281QUl6RWph?=
 =?utf-8?B?T0pzaWZsZHgvVWZsVENmcFFPMUJKQ2ZyQnVqZnV3Z2E0ZWVTZ29qaDhkV1BV?=
 =?utf-8?B?U3ZUZnZXcFI3ZlJCMkRkZmczNUFKMUdtemJlNE1scE1uZUZVMXlNVXB5MjFW?=
 =?utf-8?B?RHVIa3BaTjFrTU1ZWlpHSi9WaDk3UG0vT1dNS1I1enh6YmZqL2laNW5xQ3Ju?=
 =?utf-8?B?aWwvcHFqaWpPTEdhZFNOYnQrZVpReUdOVkxINkFMWElzcXZESS9JOE93aHdX?=
 =?utf-8?B?S0JNRGtYWjgrbno5S3pVVFVack0vS3NtenhmaWZDOGpVYk11WGVxaTNkTjEx?=
 =?utf-8?B?bmlLdktFZU1JU202SUk5UU5yQmtJQngxNXBVU0hpemJkdG1SSDJ2NFVzY0xo?=
 =?utf-8?B?OWNyRGhYZ3lPdTk3VVY0OXA2cHRtZzhHSnNrSEErajZNbUp3dlRYUEpWZ3Zj?=
 =?utf-8?B?ODIyVEtCYTNveStMOXZGdmJFUWd6cVJ1Z0xvK282MlpCT3ZhSFRTeGVrR3g4?=
 =?utf-8?B?d09TbEdMVWZzSHJzYitIUmhwYU9KUjRzMUJxN29kYThBc09mdDZLSmtiR0V1?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DB14FAB8776634C83B3902A7246C621@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VhacjcVbJLk2K+QjNrkEcWPOwiLNdNzxmlvsunZjKJ/YY0B+s4iNqxRcH8Bw9f326mOFnscZ1B1+t+N9kgnqrj+B/I0BXG70ACDT/yA7oEoS84nwV0pWsKp4e0PILkcKUgzoRmJZU6lR8YurGo1F2BixMQ/NxH4ITrhArBzhNQICmmQ6xScYNTFDHWCtninL5yO6fBkdsIhFBq7Ty3uIsrUbME0L5RLkr+65shrqzIH3EXdpXYAz3QEPibIllQsNSS/vIKZZJlYvd3evNbKVaKFjEtYmrJkcnEOM0PhYgDLbJIpmcOdnsvSP4zFu3rD6KURLNsMu3w5aoSDOPwQpOGN5e+17L67HDtoj8Eu4IGBkcrSr2OuZUijsS4aA8Id0sysoKmzV2ZB3CBJUVDFIC0RIllZwhF8CZNitP1vOqB5hXsLCxIn8Z6nRcyQtIhRA2KLXeI6ASZvMicDLWkF4AnNTSlJJPcmJd9Hc55G959H9SQPmmbxs9I9dytio5sBgIavzeiXu+cfjwXvR5xzhlB1bI/v2WY3G+vnF4Zdb7PNcV5i7I/ED4MuGXRMw8kcNPuaQ92gieH+CEOkayk4U+xqtbJfpKHYGJXGRmJoZa/hCkf2Ihaw89FxYUjCILlCB
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d099ae0-feed-4d83-fe25-08dc8f2bfc72
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 00:17:06.1028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VD5PVy4/0sQ21Loopto/UnY7yIE5zfb09MsJ8zg8xqlGKgOZsMwbR7lcwieEAlPg+4U0PKKiwkJH6V/6bY+tqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6774

DQoNCk9uIDE4LzA2LzIwMjQgMDY6NDMsIEpvbmF0aGFuIENvcmJldCB3cm90ZToNCj4gTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPiB3cml0ZXM6DQo+IA0KPj4gV2hlbiBpdCB3YXMg
aW4gdGV4dCBmb3JtYXQsIGl0IGNvcnJlY3RseSBoYXJkY29kZWQgc3RlcHMgOGEgdG8gOGMuDQo+
PiBIb3dldmVyLCBhZnRlciBpdCB3YXMgY29udmVydGVkIHRvIFJTVCwgdGhlIHNlcXVlbmNlIG51
bWJlcnMgd2VyZQ0KPj4gYXV0by1nZW5lcmF0ZWQgZHVyaW5nIHJlbmRlcmluZyBhbmQgYmVjYW1l
IGluY29ycmVjdCBhZnRlciBzb21lDQo+PiBzdGVwcyB3ZXJlIGluc2VydGVkLg0KPj4NCj4+IENo
YW5nZSBpdCB0byByZWZlciB0byBzdGVwcyBhIHRvIGMgaW4gYSByZWxhdGl2ZSB3YXkuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4g
LS0tDQo+PiAgIERvY3VtZW50YXRpb24vYXJjaC94ODYvZXhjZXB0aW9uLXRhYmxlcy5yc3QgfCAy
ICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FyY2gveDg2L2V4Y2VwdGlvbi10YWJs
ZXMucnN0IGIvRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni9leGNlcHRpb24tdGFibGVzLnJzdA0KPj4g
aW5kZXggZWZkZTFmZWY0ZmJkLi41NjJkMWJjNmQ0NDggMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2FyY2gveDg2L2V4Y2VwdGlvbi10YWJsZXMucnN0DQo+PiArKysgYi9Eb2N1bWVudGF0
aW9uL2FyY2gveDg2L2V4Y2VwdGlvbi10YWJsZXMucnN0DQo+PiBAQCAtMjk3LDcgKzI5Nyw3IEBA
IHZtYSBvY2N1cnM/DQo+PiAgICAgIGMpIGV4ZWN1dGlvbiBjb250aW51ZXMgYXQgbG9jYWwgbGFi
ZWwgMiAoYWRkcmVzcyBvZiB0aGUNCj4+ICAgICAgICAgaW5zdHJ1Y3Rpb24gaW1tZWRpYXRlbHkg
YWZ0ZXIgdGhlIGZhdWx0aW5nIHVzZXIgYWNjZXNzKS4NCj4+ICAgDQo+PiAtVGhlIHN0ZXBzIDhh
IHRvIDhjIGluIGEgY2VydGFpbiB3YXkgZW11bGF0ZSB0aGUgZmF1bHRpbmcgaW5zdHJ1Y3Rpb24u
DQo+PiArVGhlIHN0ZXBzIGEgdG8gYyBhYm92ZSBpbiBhIGNlcnRhaW4gd2F5IGVtdWxhdGUgdGhl
IGZhdWx0aW5nIGluc3RydWN0aW9uLg0KPj4gICANCj4gDQo+IFRob3NlIHN0ZXBzIHJlbmRlciBh
cyAxLCAyLCBhbmQgMyAuLi4gd2hlcmUgZGlkICJhIHRvIGMiIGNvbWUgZnJvbT8NCg0KDQo+Pj4g
ICAgICBjKSBleGVjdXRpb24gY29udGludWVzIGF0IGxvY2FsIGxhYmVsIDIgKGFkZHJlc3Mgb2Yg
dGhlDQo+Pj4gICAgICAgICBpbnN0cnVjdGlvbiBpbW1lZGlhdGVseSBhZnRlciB0aGUgZmF1bHRp
bmcgdXNlciBhY2Nlc3MpLg0KDQpJSVVDLCB0aGlzIGlzIHRoZSBfX2NfXywgYW5kIF9fYV9fIGlz
IGRvY3VtZW50ZWQgYWJvdmUgX19jX18uDQoNCg0KQ2hlY2sgdGhlIG9yaWdpbmFsIGNvbW1pdCwg
aXQgZGlkIGhhcmRjb2RlIF9fOGFfXyBhbmQgX184Y19fLA0KZm9yIGV4YW1wbGUsDQoNCmNvbW1p
dCBjMzY4YjQ5MjFiYzZlMzA5YWJhMmZiZWUwZWZjYmJjOTY1MDA4ZDlmDQpBdXRob3I6IEFtZXJp
Z28gV2FuZyA8YW13YW5nQHJlZGhhdC5jb20+DQpEYXRlOiAgIEZyaSBKdWwgMTAgMTU6MDI6NDQg
MjAwOSAtMDcwMA0KDQogICAgIERvYzogbW92ZSBEb2N1bWVudGF0aW9uL2V4Y2VwdGlvbi50eHQg
aW50byB4ODYgc3ViZGlyDQoNCjwuLi5zbmlwLi4uPg0KDQorMS4pIGFjY2VzcyB0byBpbnZhbGlk
IGFkZHJlc3M6DQorID4gYzAxN2U3YTUgPGRvX2Nvbl93cml0ZStlMT4gbW92YiAgICglZWJ4KSwl
ZGwNCisyLikgTU1VIGdlbmVyYXRlcyBleGNlcHRpb24NCiszLikgQ1BVIGNhbGxzIGRvX3BhZ2Vf
ZmF1bHQNCis0LikgZG8gcGFnZSBmYXVsdCBjYWxscyBzZWFyY2hfZXhjZXB0aW9uX3RhYmxlIChy
ZWdzLT5laXAgPT0gYzAxN2U3YTUpOw0KKzUuKSBzZWFyY2hfZXhjZXB0aW9uX3RhYmxlIGxvb2tz
IHVwIHRoZSBhZGRyZXNzIGMwMTdlN2E1IGluIHRoZQ0KKyAgICBleGNlcHRpb24gdGFibGUgKGku
ZS4gdGhlIGNvbnRlbnRzIG9mIHRoZSBFTEYgc2VjdGlvbiBfX2V4X3RhYmxlKQ0KKyAgICBhbmQg
cmV0dXJucyB0aGUgYWRkcmVzcyBvZiB0aGUgYXNzb2NpYXRlZCBmYXVsdCBoYW5kbGUgY29kZSBj
MDE5OWZmNS4NCis2LikgZG9fcGFnZV9mYXVsdCBtb2RpZmllcyBpdHMgb3duIHJldHVybiBhZGRy
ZXNzIHRvIHBvaW50IHRvIHRoZSBmYXVsdA0KKyAgICBoYW5kbGUgY29kZSBhbmQgcmV0dXJucy4N
Cis3LikgZXhlY3V0aW9uIGNvbnRpbnVlcyBpbiB0aGUgZmF1bHQgaGFuZGxpbmcgY29kZS4NCis4
LikgOGEpIEVBWCBiZWNvbWVzIC1FRkFVTFQgKD09IC0xNCkNCisgICAgOGIpIERMICBiZWNvbWVz
IHplcm8gKHRoZSB2YWx1ZSB3ZSAicmVhZCIgZnJvbSB1c2VyIHNwYWNlKQ0KKyAgICA4YykgZXhl
Y3V0aW9uIGNvbnRpbnVlcyBhdCBsb2NhbCBsYWJlbCAyIChhZGRyZXNzIG9mIHRoZQ0KKyAgICAg
ICAgaW5zdHJ1Y3Rpb24gaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIGZhdWx0aW5nIHVzZXIgYWNjZXNz
KS4NCisNCitUaGUgc3RlcHMgOGEgdG8gOGMgaW4gYSBjZXJ0YWluIHdheSBlbXVsYXRlIHRoZSBm
YXVsdGluZyBpbnN0cnVjdGlvbi4NCisNCitUaGF0J3MgaXQsIG1vc3RseS4gSWYgeW91IGxvb2sg
YXQgb3VyIGV4YW1wbGUsIHlvdSBtaWdodCBhc2sgd2h5DQoNCg0KPiANCj4gVGhhbmtzLA0KPiAN
Cj4gam9u

