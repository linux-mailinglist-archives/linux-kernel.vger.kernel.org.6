Return-Path: <linux-kernel+bounces-265378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8301593F059
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91641F2255F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B713CFA3;
	Mon, 29 Jul 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XnrG/82e"
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA204139D12
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243208; cv=fail; b=jsI2fwSs7pXTn8JdOpAUUYKIgGmocovdzryMWakGvsCNmCZ6Dkj8czp6lLFc87sVgiyM44hqDcfHeP+CkJHjkd0nIsJEUQvfVCW287WHxwWzy+mDV3XNNHOa/Uafwd+yCJkqVoDY+Ncrd4VOUP0bR5kvhF4K6HboWG3j/wU+o/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243208; c=relaxed/simple;
	bh=bagEqIV9bRqN7LSD0/+GZsFBWIl7zCZzaw7NvA97yPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ORL9N990ZvXPTw4Lt0FoWa38U0nrVnAkdyNXR548bVLJ46qP2ZwAwHqdfwCY7NjrmawXXPMv+IpCOrLLmoq1WtSJpZpiJTpk5JX9GjYy3mWU/mSV0hCgmupqm+VTrzX0yhlaZKZ0NS73Mpw0NAPnbAb/k8d8rK+a2f04kDFeeXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XnrG/82e; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1722243204; x=1753779204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bagEqIV9bRqN7LSD0/+GZsFBWIl7zCZzaw7NvA97yPA=;
  b=XnrG/82eLNW6drWtWVD8eUXm3Zm2T6iIR6dEBAw+I6GnHtRQlzEhWRvp
   mGP3i5y9zoW8Rlm0SvWsPVQ03qhvWD/cGTJGuCImPXTz4s7uVL4R4n6ri
   oYuCKvVnEWIG0TklZiQver2zxY/CUfVZJ+aaybBrSLeq8/cEmXFxQo2Dk
   a4HBg9YOuktnVcwDqmaotVpqcNo5f2fOGE48O59JOy4Av6SZp1i8/9qgj
   DlMgx8CbHl/z2AKWmWQXRc4z5gOh91c8x7pigb5FBXief4eYoWBsnslLU
   yzky3Eun8G/uy4+SoBweHaFqgOarDM6raWL8CeXnB+8xoVgm1IuHpxhaa
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="126573191"
X-IronPort-AV: E=Sophos;i="6.09,245,1716217200"; 
   d="scan'208";a="126573191"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 17:53:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7/AJbJRoOQyScGlGv4aMMK1xIZ6S4PdgSxrv+NmTbCtBg8UDiRZwDn7VuTeIcsweNIDZuKFxRvzJbR+dc8aAXyy9GVbcF/6R2ppgfp0fUpqYbUq37A+7popca37VvgVTcwLgpwhVaMNV1arikj9EqlQ541HIRm2g3slmmqQ69gMcj8Z28dPpdc4Wc4aaRv4Hp1wUD6ptm7f5HjmJ+IIjVYGXcUsknO4yVH+HHyOhpigqr3/DykAYvozMd5mmB8+2tjfzKBK3IdXIRCb5xokfpf/hG0C5DhwhAqi1f3u9rsWxGxR5w4HTpnn0WfWpzIVpdHCoy36wnOJzSZkfTRY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bagEqIV9bRqN7LSD0/+GZsFBWIl7zCZzaw7NvA97yPA=;
 b=zU+q/L0AL1zWyTPalD3FI0dUdyiwlb3tIxMS+9xIPFdhcasS3blIIwrhVkeJpO6gcbKfP7Y5exZ3SjEbm9NGZqMNeyG9zsbzokPsIycaKl92mXrXQbWmRQ6jfxSdVFlBDlbfjHhUwKjkYhBmhDQnGR8sX53XiiDnasw5VLN2Ta4izWNNkbOwHSlKDcAEFfaEoH1XGopENDzEbri/BHTbEtlyIpC+nD+WFQ4/L8oWYMwYxo201FrtG17cTpuu30X4zSJghzceRheLr5b/B90BA1YGymv3zUgjNF60hmYG6cOj+myCjS3grjJs4BD8yID0Qu7VYMAtPiqA0RFCfAzjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB10267.jpnprd01.prod.outlook.com (2603:1096:604:1e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Mon, 29 Jul
 2024 08:53:11 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 08:53:11 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Michal Hocko <mhocko@suse.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar
 Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>
Subject: Re: [PATCH RFC] mm: Avoid triggering oom-killer during memory
 hot-remove operations
Thread-Topic: [PATCH RFC] mm: Avoid triggering oom-killer during memory
 hot-remove operations
Thread-Index:
 AQHa3zgpkku48clQz0iGM14ekjFxLLIIuvWAgAQlj4CAABsMAIAAQuCAgAAFzYCAABKDAIAABqIAgAADFwCAAAqQAA==
Date: Mon, 29 Jul 2024 08:53:11 +0000
Message-ID: <280af822-577f-468b-953f-b70190551b6f@fujitsu.com>
References: <20240726084456.1309928-1-lizhijian@fujitsu.com>
 <ZqNpwz5UW44WOdHr@tiehlicka>
 <fd6e84d5-9dba-47fb-a39e-1f7f0995fdf5@fujitsu.com>
 <2ab277af-06ed-41a9-a2b4-91dd1ffce733@fujitsu.com>
 <ZqczDQ_qAjOGmBk0@tiehlicka>
 <264840d7-d770-29a0-7c36-6ede9063d06f@fujitsu.com>
 <ZqdHch4VZG9UC2yM@tiehlicka>
 <f2b49b7f-7622-4322-a34f-cd4b1756b791@fujitsu.com>
 <ZqdPmtDjwDUoKJA2@tiehlicka>
In-Reply-To: <ZqdPmtDjwDUoKJA2@tiehlicka>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB10267:EE_
x-ms-office365-filtering-correlation-id: 937e4280-a951-4f9b-ae73-08dcafabe065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2orb2Z4d3FVYzlqVDVscENvZWF2eWh0aWZzRWRYTUVFM2Vhc1VkM3p3b0cw?=
 =?utf-8?B?RjY4MWlRQlhWWkZBQ0NxRFFLUkVDSGhHVmZNUUZmcjhrb2VxcmFCSTBFREgv?=
 =?utf-8?B?aFdsbHRyMnNPaEN0dHNPRkhMWmdmdDhnODF6RFFSWDdNanFFMGFtNmFwenZM?=
 =?utf-8?B?emVnQTdyTnFUcGZ5UTNmRXc3LzdVUGZ0ZTNSa2ZIM3VIV2Y5eGFlMDVRTVgz?=
 =?utf-8?B?OU9uLzRQbjZFTS8vbGRtVWgvd08xd3NPSkxXTDJYdXdPZ28xcFZXYmRTUnRt?=
 =?utf-8?B?QnZrb0VPN2VoUUpocDkrRnk1UlpLaDNuMFpCSlZrK3pEVDdLUmhBSVloVldl?=
 =?utf-8?B?QVVqZFhNRUo4OVI3WnBaTEllT1Jsa3lrNHBtVCt0MUF2dUppV3lpMmVQNE03?=
 =?utf-8?B?cnF1dlF3RDJQZGpFQ21qdC9ScllIbUtqUmhjM0IxaTRjOG4rdHpPamVTQWg0?=
 =?utf-8?B?MHdRWWF2bXpTcFpCVDRldlE2MDdDTVFBbWVwa3hVL2QwY1RRV08xcHA1TFU0?=
 =?utf-8?B?di9Tb2g2aUQ1b3Y1ZTFjQUUzemdrSEpVZVV0djk2OXp6MXgyYzdtNmVSbDQ1?=
 =?utf-8?B?a1JoVmhzdjBpU0phTzUxV09nUWRsUk8rK3B4d2MvZXJKeGhYUWFMY3czR0xV?=
 =?utf-8?B?YWc2OEVOY2MzMnVhb2dQTVhxbytRc0lXWXZUTzVSQlFjVUpkVE5wREYyUUZy?=
 =?utf-8?B?UEdPU0hJMyt0WGtsdkpNT3VVU3RBWXlleWNBd0tHMEpPVHFWSDltbzBvWWM1?=
 =?utf-8?B?R0I1WVgvQVdQOXJ1RTRKUWpmZXFMMnl3alhQN01IcS9Nc0FhN084QllPWEkr?=
 =?utf-8?B?bXhnc2M3Qi9CYXJBVThaL3Rwb0xjNFdoYmdjR1ZmSnE1YWdQWW1qMUczUDNL?=
 =?utf-8?B?Q0FPK1M0d0NzdHZCQTRGZTJIWlR2T3pBUUxrcnNGSEJPYVVJSXlJcUIyUmN4?=
 =?utf-8?B?ZU9xOUVNR3U5ZjF0UnBQVkdrRFZsWHRsVVdnbGx1Y0Q0UUVYdzF0U2tsMjYz?=
 =?utf-8?B?d0hzQnZ4Zk5IdytFbFBpb3B5emZ5TTZURWpHL2ZTaFpyYU9YcUwzdExSbXp6?=
 =?utf-8?B?S05mcDVSSm9NUEFvU0RrWUphZzF4NmFXYW1CRTNHRVZoT0JwUWRSYzAxU0xx?=
 =?utf-8?B?b1R4M1FrNFc5UUh3YkUvaTV6QmRBZm9FSGVubHhlaFlLcUx4SzBQbXEzakll?=
 =?utf-8?B?dlJNWGhiSzJsWjBKUm9NVFVCUnUyTTNzMnNuYUtWa0dZRS9JZkd4ZGw4SVlP?=
 =?utf-8?B?ektlNTdmYXRpRTU1dVRBZlJzdmJlUm1ucXVQUWhzakhYcURHcWNZeC9mbUlP?=
 =?utf-8?B?NTFTYU9OemNkQW92ME5ENndnVDJ4cGg1ajZyQktBKytzaUdLMkVpMDJsdTNk?=
 =?utf-8?B?eFU5SG5ETjY4dzQ4elpDbUcwbklOc0pYeWtHSFFaUHNia3ZJaFdza0VML2RN?=
 =?utf-8?B?cEZSOGtjWitYK3owUE1tdWNvVHAwc29iQ1NTQkgyZW5qV3gwQ2VPUlpOUEdC?=
 =?utf-8?B?elFpZ1BpbDFVd1RyZmM4M1hhSzhEcVQ3N3QvdXZmMGtzbDgyK0MzSG4waTFJ?=
 =?utf-8?B?ZE9nTnpCdVZRbHNSZnpIeENwMjBQS2JUQWxnaXRacEFQbEJqNmg0OFdRUmdH?=
 =?utf-8?B?blNWakVoYjZqRlJHVWdGQTBvd0RsKzFrd085VEtKVGVuN2lxT05xWjRSL0Vz?=
 =?utf-8?B?NU5VdmgvRkR6bk9TbHhMaWRjaGRrTlNxWnNCcUxFdDRMR1lIa3VyWEIzUTdL?=
 =?utf-8?B?WHQvQ29FbWFYWVdwZ1V1WDgzZ2NJUVVIb0w5RXY2RTA0VEwwRFBJVEZtVDNp?=
 =?utf-8?B?M2pCdUJ3RThiVzJsZE1jTnl0d3JEbXFrcTRXb1pvVDRZVTd1ckNTU3hmNTA5?=
 =?utf-8?Q?7SfYr20jg6RKR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1BFWG9UeVg3NFZVYWYrRS9BdzgxZCs1WXhuTWNwUHQ0L0RFOWMxQzBTT0Yy?=
 =?utf-8?B?b0hpUHc3bHRTOCs4ekhiTml4ZjFMZVRDTUFvWHo2SW9FeGNQc1dyNGlmMEhl?=
 =?utf-8?B?aUZDcWx2N0ZvUE9BblkzZVFjMmg0YXk4NEdQM1BiVTY2Y2hzcGF5Ry9SblhE?=
 =?utf-8?B?WHYxN20yOHJLdmtsK1RsMmVnbEpIWTZVNTBzcVh6UE9BUWR5QjlWU2hELzhD?=
 =?utf-8?B?N0ZwdjN0VCtXRVVtclV3S1BLN3VBOXNLYXArdWNsMnBHNjJUWS9McjV0Wk1L?=
 =?utf-8?B?aXVrRHJwTlRWazNCWlp0Y0s3SnR0L1E0Uy83OXhpWjUrOXd1K1UyTTNNQW5L?=
 =?utf-8?B?TlRKc05pdklrNWFwMkVrRDRBM3JLcndSWmF3cDQ3bjRFcHREK242K2NKaGtP?=
 =?utf-8?B?c1hCYmY1NjM4Nkhrd3RhVUQvMDBTaWh4ZmhWR01jVlVrOVhjdG1GRmlReHBu?=
 =?utf-8?B?R3ZOS3dWOGZqaHNDajVqN2trVWZ1RVVISDFpU0w2eTJHTTM0ZmpPMjVFK2lE?=
 =?utf-8?B?OUVEdmdVVUhjM1ZTaE5pUE5yV0h0b2xUQVNlaEF3TkNURms2Lzl2Z2Qzd0JI?=
 =?utf-8?B?R1h5MjJHekFYN2FsVjZBaHIyTVJ4WEcyWGZBMDhZbTQraFpoN2xmdHdjSmxV?=
 =?utf-8?B?SVVYSnl5bmZXUGExU2pQSWRScVBvenM1OVVnWnRCUUdPc0FHK3VNTlBZU2FK?=
 =?utf-8?B?cWM2aGU5MHI0cGFETkdVKzNtQUFNSnhES1pJTFlKQlB4ajN1Rk5YUDN5bWlk?=
 =?utf-8?B?QmdEK1VCYzN6cysxaEd3YlNJLzBpSEx1UVJJSDdwY0RkYUZOZkFxTUpKOEF5?=
 =?utf-8?B?d1l2YTRtRE5YM085S0xNakM4VXlWeHVOUTNPekIzaC9QQWN2R3FEWlBsL2lW?=
 =?utf-8?B?U0hDVm5heG1IQWN5UlpZQm8rTE1iSDd6dVpCeUhnZDh1Y2NrL1Q1Y3NWYTU2?=
 =?utf-8?B?bUtMVGNOUWoxTHBZWTNoT1VudFlKc3Rtc1pTb2dkT2IwakhMWThrbUdJQU4z?=
 =?utf-8?B?dkhjZFVRaGxqdFdVSFNPL2hLSnhsZGJQcVEzTEl4Zjl3R2pqV25EVFN4eTlm?=
 =?utf-8?B?SHZDVUJ3UWhzMzdvZVFkQ29oWldZNWEwZGJvS3Q0K1JRbUl2VElLOVVlb01I?=
 =?utf-8?B?TGw2QWFlbmxFUFNRRFQxNjQ2MVcxNkhLbG45SmZYNkIzVXdBb0xxMnJyN2tT?=
 =?utf-8?B?MUplWFk2VktWTnpHQ1hpeWdpc3BYditSZWhRYWZGb1c2ODkxZHJPcEF6TzNX?=
 =?utf-8?B?dnRYMzFNQzZ2N0ZiaDdFM2p6SHFuYmxmOE1XTWFESExjQURpNjhCa2xEQU9M?=
 =?utf-8?B?SjcxWllzRlVubjM1Uld6WmVIMDVtQkw0TmpVUTNNZ2ZidnI2NkN3S3dnV0c0?=
 =?utf-8?B?MFdhQjkxL3IvYWtHNjBFQnBOVEYrWVB5S1QrYm5YTFpjY00xNWwva0tQeVdW?=
 =?utf-8?B?OWZnRDRxZWxsMG5qdU5lcS8yeDVSNmZrSmJ2L085L0FqMllDN25OeHU2WldB?=
 =?utf-8?B?dkU2aE1KOUFZOEszTFBMT1M0N0t3WDA3Tmc2QVZZais2RHZ4Q21qdktaMm9q?=
 =?utf-8?B?RGhBOHZrbHRQNldhYVBuQThtRFFQbktZeGhySlh1N3FxbENZK1B6dFRGSndY?=
 =?utf-8?B?UWxQS3Y0T29vNFVlQVJvUmlVVmN5a0trRVAzK3ZrM2lraFRLcU4xUDRFZ3pS?=
 =?utf-8?B?SitXZEZVUFBVdjFZSUFFVjIzZlc3ZzlzMkNIdlV4QWF2aS9RN3dvV0dJcWN6?=
 =?utf-8?B?YXJwb0owWDJwZWgwM05xM3lqL2JOUzQ5TXNURStmY0ttUXBUWEM5ejROWlpH?=
 =?utf-8?B?QTlaZjNRRWxSb3BoWk9mRGMwL0l6ZTF5UmhpR3FndWUxRUEwQ2oyRUd3N05I?=
 =?utf-8?B?TVI2c2VRczRmOUJkL081d3lxU1Rwa0M3SjJERGhlT2tRZlRNUXF4VDY2eFpU?=
 =?utf-8?B?Y1FOWmpveGN0K3hMQnlDbFpJSW1pR2FBWDNEV053Tm9NS1pHK3BpUWNwc3N0?=
 =?utf-8?B?N3k1ekRQcURDSHJRbytacHduYm5WUE9wVlJsM0hqMFgwaXRheGFLMW9TcWZO?=
 =?utf-8?B?MmpPbEs4dDUrOGZ6L0p3RHlGRU1CTW5ZdHRlRXp1WGhjL1hldW9ab21sSUI2?=
 =?utf-8?B?WWg2VytrWFp6cytDQTlsdDBhZTkzcjZuazFkWEY1TVBVTVUvWDYvTjcraXFK?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE73F9EBA8207B44B599F3DF8CAD78BF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f1b8Q9dIo5o4xlC2SvFv/xUetIXzJRAr7rGK0hArZo/XHayY2wBdwoc5hnTuQ4m+uhuWGM9OWCv2U1uxX/Ih/lLoD8aegqXv6MNHH2ikUOFIv6Gc1mxltFZg1nSV1v5+lvVRGI17tuE4bnYjrxcfmgEd3LsxQP/yBasuTOr8HqIUCyTzaN+NQM6Vsm8h0UMjdTLUQgVo2jm6YtAcal3eF/XM9G2kC5afqZJGai56c9+6x3DS5mT/NgnAsiAzVxZub9uYIIT7Jk7eTVqhAeQ4hgtAJ10n6b98lucMz0sGQyU9kkyML4lcbrXDUKQHjxzMow7QcqTLtCJm2i2kpJ5kILSc4HoAhOz9UAZcGGqeMggj8ASMnOvRgg0KOT4oDoR+yek3Lpv/D5ToF2jr1Kw2cg4A3nu3SPKR7x/o0KFqff1tanBt1FdifNPrV8pfa6heWaKrF8hWUMSTtMPhWIE/DGwTI+Y5X2d3ZGTc0/C1E1owxJv2LGV376rafcU8i3kjt+wZSoTQfxKy7IDLFYQy0AtdLyHr5bJiHNj7cEahtY4h4Aq2RX+qIW1LSZLPFgBqAXzRmm0B8TTQ9zROtixtYmjzHAHI5ZP02xQul4bAdis3cDNqyTpCNGxl9mYIVebg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937e4280-a951-4f9b-ae73-08dcafabe065
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 08:53:11.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPyUH+l84du1tSlqpllZurlfNdHrpt9Rarhdq0+95vG74mFHVLixvyVWBWL/Hm7mJMa1cEA+Un1dbTB5XEiLWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10267

DQoNCk9uIDI5LzA3LzIwMjQgMTY6MTUsIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gT24gTW9uIDI5
LTA3LTI0IDA4OjA0OjE5LCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+IE9uIDI5LzA3
LzIwMjQgMTU6NDAsIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4+PiBUaGF0IG1lYW5zIHRoYXQgcmF0
aGVyIHRoYW4ga2lsbGluZyB0aGUNCj4+PiB0ZXN0IHByb2dyYW0gd2hpY2ggY29udGludWVzIGNv
bnN1bWluZyBtZW1vcnkgLSBhbmQgbm90IG11Y2ggb2YgaXQgLSBpdA0KPj4+IGtlZXBzIGtpbGxp
bmcgb3RoZXIgdGFza3Mgd2l0aCBhIGhpZ2hlciBtZW1vcnkgY29uc3VtcHRpb24uDQo+Pg0KPj4g
VGhpcyBiZWhhdmlvciBpcyBub3QgbXkoYWRtaW5pc3RyYXRvcikgZXhwZWN0YXRpb24uDQo+IA0K
PiBXZWxsLCB0aGlzIGxhY2sgb2YgcHJvcGVyIE5VTUEgYXdhcmUgb29tIGtpbGxlciBiZWhhdmlv
ciBpcyB0aGVyZSBzaW5jZQ0KPiBkZWNhZGVzIHdpdGhvdXQgbWFueSBwZW9wbGUgY29tcGxhaW5p
bmcgYWJvdXQgdGhhdCBlbm91Z2ggdG8gcHVzaCBmb3IgYQ0KPiBiZXR0ZXIgaW1wbGVtZW50YXRp
b24uIFNvIHdoaWxlIHRoaXMgaXMgbm90IGdyZWF0IGl0IHNlZW1zIG5vdCB0aGF0IG1hbnkNCj4g
cGVvcGxlIGFyZSBzdWZmZXJpbmcgZnJvbSB0aGF0Lg0KPiANCj4gSW4gZ2VuZXJhbCBkZWFsaW5n
IHdpdGggYSBjb21wbGV0ZSBtZW1vcnkgbm9kZSBob3RyZW1vdmUgd2hpbGUgdGhlcmUgYXJlDQo+
IGFwcGxpY2F0aW9ucyB3aXRoIHN0cm9uZyBudW1hIHBvbGljaWVzIGlzIHF1aXRlIGhhcmQgdG8g
ZG8gcmlnaHQgYW5kDQo+IHRoZXJlIHdpbGwgYWx3YXlzIGJlIGEgY2VydGFpbiBsZXZlbCBvZiBz
dWZmZXJpbmcuDQoNCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBleHBsYW5hdGlvbi4N
CkxldCBtZSByZXRoaW5rIGl0IGFnYWluLi4uDQoNCg0KDQoNCj4gICANCj4+PiBUaGlzIGlzIHJl
YWxseSB1bmZvcnR1bmF0ZSBidXQgbm90IHNvbWV0aGluZyB0aGF0IHNob3VsZCBiZSBoYW5kbGVk
IGJ5DQo+Pj4gc3BlY2lhbCBjYXNpbmcgbWVtb3J5IG9mZmxpbmluZyBidXQgcmF0aGVyIGhhbmRs
aW5nIHRoZSBtZW1wb2xpY3kgT09Ncw0KPj4+IGJldHRlci4gVGhlcmUgd2VyZSBzb21lIGF0dGVt
cHRzIGluIHRoZSBwYXN0IGJ1dCBuZXZlciBtYWRlIGl0IHRvIGENCj4+PiBtZXJnYWJsZSBzdGF0
ZS4gTWF5YmUgeW91IHdhbnQgdG8gcGljayB1cCBvbiB0aGF0Lg0KPj4NCj4+DQo+PiBXZWxsLCB0
ZWxsIG1lIHRoZSBwcmV2aW91cyBwcm9wb3NhbHMobWFpbC91cmwpIHBsZWFzZSBpZiB5b3UgaGF2
ZSB0aGUgdGhlbSBpbiBoYW5kLg0KPj4gSSB3YW50IHRvIHRha2UgYSBsb29rLg0KPiANCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNzA4MDgyMTI5LjgwMTE1LTEtbGlnYW5nLmJk
bGdAYnl0ZWRhbmNlLmNvbS8NCj4gDQo+IGJ0dy4gbG9yZS5rZXJuZWwub3JnIGhhcyBhIGdyZWF0
IHNlYXJjaGluZyBlbmdpbmUuDQoNCkkgd2lsbCB0YWtlIGEgbG9vayBsYXRlci4NCg0KDQoNCj4g
DQo+Pj4+IFsxMzg1My43NTgxOTJdIHBhZ2VmYXVsdF9vdXRfb2ZfbWVtb3J5OiA0MDU1IGNhbGxi
YWNrcyBzdXBwcmVzc2VkDQo+Pj4+IFsxMzg1My43NTgyNDNdIEh1aCBWTV9GQVVMVF9PT00gbGVh
a2VkIG91dCB0byB0aGUgI1BGIGhhbmRsZXIuIFJldHJ5aW5nIFBGDQo+Pj4NCj4+PiBUaGlzIHNo
b3VsZG4ndCByZWFsbHkgaGFwcGVuIGFuZCBpdCBpbmRpY2F0ZXMgdGhhdCBzb21lIG1lbW9yeQ0K
Pj4+IGFsbG9jYXRpb24gaW4gdGhlIHBhZ2VmYXVsdCBwYXRoIGhhcyBmYWlsZWQuDQo+Pg0KPj4g
TWF5IEkga25vdyBpZiB0aGlzIHdpbGwgY2F1c2Ugc2lkZSBlZmZlY3QgdG8gb3RoZXIgcHJvY2Vz
c2VzLg0KPiANCj4gVGhpcyBlaWxsIG1lYW4gdGhhdCB0aGUgI1BGIGhhbmRsZXIgaGFzIGZhaWxl
ZCB0byBhbGxvY2F0ZSBtZW1vcnkgYW5kDQo+IHRoZSBWTV9GQVVMVF9PT00gZXJyb3IgaGFzIHVu
d291bmQgYWxsIHRoZSB3YXkgdXAgdG8gdGhlIGV4Y2VwdGlvbg0KPiBoYW5kbGVyIGFuZCB0aGF0
IHdpbGwgcmVzdGFydCB0aGUgaW5zdHJ1Y3Rpb24gdGhhdCBoYXMgY2F1c2VkIHRoZSAjUEYuDQo+
ID4gSW4gZXNzZW5jZSwgYXMgbG9uZyBhcyB0aGUgcHJvY2VzcyB0cmlnZ2VyaW5nIHRoaXMgaXMg
bm90IGtpbGxlZCBvciB0aGUNCj4gYWxsb2NhdGlvbiBkb2Vzbid0IHN1Y2VlZCBpdCB3aWxsIGJl
IGxvb3BpbmcgaW4gdGhlICNQRiBwYXRoLiBUaGlzDQo+IG5vcm1hbGx5IGRvZXNuJ3QgaGFwcGVu
IGJlY2F1c2Ugb3VyIGFsbG9jYXRvcnMgZG8gbm90IGZhaWwgZm9yIHNtYWxsDQo+IGFsbG9jYXRp
b24gcmVxdWVzdHMuDQoNClRoYW5rcyBhZ2FpbiBmb3IgeW91ciBkZXRhaWxlZCBleHBsYW5hdGlv
bi4NCg0KSSB0aGluayB0aGlzIGlzIGFjY2VwdGFibGUgZm9yIHRoZSBwcm9jZXNzIGJvdW5kIHRv
IHRoZSBiZWluZyByZW1vdmVkIG5vZGUsIGlzbid0IGl0Pw0KDQo=

