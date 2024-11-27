Return-Path: <linux-kernel+bounces-422970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454419DA0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1B9284DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CD2224EA;
	Wed, 27 Nov 2024 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lbOhRdtw"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61683C8FE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674795; cv=fail; b=ejNzilwGKlZWBHmi9TTZwAASlAdWGESOdAxf97/d84GQTld1ah8WCpT5QY7a0qVwRXZL64C2Sltf4P/Ts9LHAbyL9HAtC1JY5vh3VbDrFP/AIfscZD8hL0tRwNgYlfHtDf+SY6+uMl0fqSYeL7SqmW2bpDLB5B1r98g4q2hSZsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674795; c=relaxed/simple;
	bh=RQ2Thd2LQhxy5HmfNEPwouF91lmHMpsZ61o9Wb/EJCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uo1yCNHVe8JNhzBizMnb9l5EqrekYMNI0XS1x3kvITu5Z3yOeclJPdrFUrXioF7XcNKyBpNMWD+d6lE3Aas8wE6T1rxIx+epcP7DOvmpuu3tsxCB5/XesPbEQgjcUgpHAAMYJj/oo1f+uLxN2P5JwOhkbf/1UX0XdNRYTRORbPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lbOhRdtw; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1732674793; x=1764210793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RQ2Thd2LQhxy5HmfNEPwouF91lmHMpsZ61o9Wb/EJCE=;
  b=lbOhRdtwWDPD521fcwglI0SSm9yHYSc6rKOhjsjR3O7Fp7kAOe9/bBWf
   DgA1yPETduM4LAnaOs03HBy16EjXbmGW7iBHUvrR2rNi7bropMsyBhF6k
   kOkBgwDkQW8NY+bEM7p+46eE0vbnM2/4ov46lXu3XxmWVw/VS5qmdJeiI
   iBQ0zwUh5WSRwxM/QSauYqnF+f1qdNMCvBlhFI/aztYAMuJnSeOBtFI0/
   IF1aSxy7Inj9v9pwZyub3g4AsVw5CblNQMCbcVvbG6sUQ9sBkByovfO24
   Re6bQwJP+33rfvrF6g8OV8CiF7rek9Hs30NXEEW/0SUv6pAepA3iRF+1O
   g==;
X-CSE-ConnectionGUID: pizCp9OdRvGex/k6ZtrWMw==
X-CSE-MsgGUID: ZnsYS9DdSwWhU2JhtJix4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="137854190"
X-IronPort-AV: E=Sophos;i="6.12,188,1728918000"; 
   d="scan'208";a="137854190"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 11:31:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0LAVeBLmu5vLK27gScCd4XLAF6oUFjCxLSWexzeIG7IPn8kZ0FGNmlSGD7nFHwLOEfK7yFH8F6hqqy+2FoUfX3endGZuaXfI+GHo+1LVJ1leDDm1cfDT8Brd2Lww/S0ZdHV0TyinUErSbz1/XNnUd3aRPW0FTCuFbcx9kWInvM2DkpuEYFl7btpGidhpg93mno8PZrKW238voo1WwvOSHazLaNONpt624sUL4faS1fBiaQQueh0QSUGmWL2XeK258C0HqmYt77m+Vnqz1VqN6kPOa9EY/At3+H4WKdUCsK0yDjR2vgtCX7Y0zV8XCYMLhPZuhGdmnstZf1pGDzn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ2Thd2LQhxy5HmfNEPwouF91lmHMpsZ61o9Wb/EJCE=;
 b=Lq50pa/MpKa3hm4WGrzKMxYOYW0yU0kFmeVL+pddQvRrUz7mU0Z9Zg4NWtMAX/XwaJRv0Gl5wctq5m5xe1s7pSecBN1QDiMcx5UBiKWSTi8k6n9R2oaFhcLB0ckXKlMEscjOnio4SHi8Pj9x5KO/Dv8twvxC+bWsI77EvLNEH1sfmkNmfLLfmSjxfbzK7pDSSqF7MntkAYRQU5F/5vrMXBgtrV6BQYlRuPFKQXWU50uiZDb7BZaIpWQE7dNK+vqYS3uz1CCnKGj56ZW6BGe0LfqlzjkvEGrsU3+RaLCf8ewUpDjTQszquw7L6Ty1lg+USe9NviP3NCiubhjlQyefzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB10627.jpnprd01.prod.outlook.com
 (2603:1096:400:31c::12) by TYCPR01MB6623.jpnprd01.prod.outlook.com
 (2603:1096:400:af::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 02:31:56 +0000
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::1393:48f4:70e4:b324]) by TY1PR01MB10627.jpnprd01.prod.outlook.com
 ([fe80::1393:48f4:70e4:b324%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 02:31:56 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: 'Miaohe Lin' <linmiaohe@huawei.com>
CC: "'jiaqiyan@google.com'" <jiaqiyan@google.com>, "'linux-mm@kvack.org'"
	<linux-mm@kvack.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, 'Andrew Morton' <akpm@linux-foundation.org>,
	'Naoya Horiguchi' <nao.horiguchi@gmail.com>
Subject: RE: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
Thread-Topic: [RFC PATCH] mm: memory-failure: add soft-offline stat in
 mf_stats
Thread-Index: AQHbO9GsfRpNBfPhx0SQ9Pd6RQr5BbLI6bKAgAGBvVA=
Date: Wed, 27 Nov 2024 02:32:35 +0000
Deferred-Delivery: Wed, 27 Nov 2024 02:30:26 +0000
Message-ID:
 <TYCPR01MB961779970E6BFA06BD4BF46EE5282@TYCPR01MB9617.jpnprd01.prod.outlook.com>
References: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
 <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com>
In-Reply-To: <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9OTA0MGJlNTItZmJlMS00NWE3LWFjNWUtMjdiM2YyZDQ4?=
 =?utf-8?B?NWE2O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTExLTI3VDAyOjEwOjM5WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB10627:EE_|TYCPR01MB6623:EE_
x-ms-office365-filtering-correlation-id: 85e97956-8803-47cb-e211-08dd0e8ba941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3FRNFVFZkEvL3NTWWVNVE9FMTVpQjNVV3g3VjEzM05IN2FTQ1pNMlA1Ylhp?=
 =?utf-8?B?RGVHKy9KZUNaQjVXUE9hWEhvbDdPMzFTY2N1bk13TVczVURhZEhXTm0vTGNz?=
 =?utf-8?B?UEdSTWRRcU1aTUhrcnpPd0RlcmNoUlo2S0FIdTUvUjNCSXFRMjdwMk1BTmZi?=
 =?utf-8?B?KzVuSDFWUUkzNDZOVkl3S2d2SVA0SXJ5ZTFzMkdla3ZBTGVTZ3A2S3R6dVRX?=
 =?utf-8?B?SmN3b0Y5SDYrVnROT0ZFQTRUMStGKzV5ekZSMURHUXNoUW5BT1ZGQWtsN3FK?=
 =?utf-8?B?ek5lS0s4VHZnaVFMRjNJWUwxOGgxWnlyRW9lZFc4RUxSQk03UnNMSGMzckRS?=
 =?utf-8?B?YmVzS3VHTjJySStkUjhzUHFBNDMxVHVLbml0MmFSL1Q2b3d6SFhuQ0ExdzNu?=
 =?utf-8?B?NXRicWdSNHJnYkVKaWFDTGI4MEhsN2dHelBWcDdKc2VhZFlBb2RVUUZtNUdt?=
 =?utf-8?B?NVZkNWNVN1QzbFFFcmpZUVZhQnVYV0tudVZ5SHNMb3BRZzNSTHdDZFg0aTZE?=
 =?utf-8?B?NW5uU0VDcTR2VDJrMTllYjB2QkwxMUhDMUFuWDVKV3lSKzBvWXdxTFBCVVdx?=
 =?utf-8?B?UVlEeWppT3JHMC9wc3hWRHVkUURpeHVWbE9PV1huMTVoQzBKSU1RT2ZkNExG?=
 =?utf-8?B?MXlYRDZyYUVlQ3ZIcmw4Z2FlZ0pzL0dKL0dkRlROQTgyU2RKbGFUS01NdDk4?=
 =?utf-8?B?TXNGNnlCR0JTZ3c3VTB0eXVwOEFtblZvT3pUYWdvbThWYS9tV1dJT2lFSWIy?=
 =?utf-8?B?citJMlAwRUVRN0NkU1RtZThraFNnYTlnSjgxU2ZXWHFqUjVyWjI3YVkyRVhW?=
 =?utf-8?B?aXcydk9ybmJiMGYrUE11YU9iWDE5bjU5NmtWcUk1QTQ2MGtLUmtCZDF2UkQ1?=
 =?utf-8?B?Y1B1RWxPcHRjMkVTc3p1SkJFakVrMHNQdzF5WmpQU2dMa2NsZncwZFRXMk9C?=
 =?utf-8?B?cXFmUTg4UWF5QTlnaVh0bE40UnVqeHVpZWJkZVd0bkZzQ0Y4cVZxV1FmOVlI?=
 =?utf-8?B?bm45RlJYbDZ0dTgwYm1RaEhDZkc4aWl1S3hmUTFhazhyU2p1LzRkcVBIbnhi?=
 =?utf-8?B?TEJyVm50QzIxd3V0c1FNQXhrODdXdWpzY3FjMXFkdWpYZlhHNThrZld4VDRt?=
 =?utf-8?B?UmM0czBRdGkwRk9wcnh4NVRhZVdjOU1lemlseXZkOEI0S1VDMGJlTitzZ2VW?=
 =?utf-8?B?U0VZalVBbnJjVFV6QTFzRmVDeXFSWERQaE1tYWNoY0IvQTgrNnFVMUFCMzZZ?=
 =?utf-8?B?NzRueDhLZldRSzBNMDA3OW0wZGpQWVVnSW42Q0pHRkhLTHlqYVhFbUNUNW9F?=
 =?utf-8?B?MkJOT0FXQVptTGdXNEQ1dElubWFTWnBmUnBhWnNsTVpycmFTQnRxTGQ1U3l4?=
 =?utf-8?B?bjRqbjZrZnFheEppUEw3YjR4NjR3amhWV1pmRGtHRXR4VVc4enU5eUZVZVBw?=
 =?utf-8?B?Rlh1NzIyaXhuMngrYnFUZTA5QmJDcHVON284SHM3SFUwNEFwMXoxYmloN2JE?=
 =?utf-8?B?ZWNKcTlXMTN2ZUg3dWc2NExBZG44SEJnajIxVnpkRGJHbHVST25WT0o0dmZG?=
 =?utf-8?B?OThtM2tQZ1ptWXpIZGphTlNyQzNxMCtxV2pMUnAxZHNqVzNsaitLWVc5R2NJ?=
 =?utf-8?B?azRoZmNNeHAvbjRlUXBOZ0k1Tk5pelAvdjdqZUZscnpvQVFoWllEeDRWc1ly?=
 =?utf-8?B?RlR0cmRaQi9WNEhERDYrQ0pUYkpzMitteTExQndWcHo2ak53aWVhYUEwamFS?=
 =?utf-8?B?UlJrMk9jT1VacFhqeHg2VkswUUVUMlR3THRncEhmUVdmeGI5UzNNWHpkMktH?=
 =?utf-8?B?WXYrKzYyaTJrMngwSEw0cFhYNEVyNDNIUTlhSG9seCthMUs1QkJNbXFrQVBV?=
 =?utf-8?B?T05mZ2FxN2NUQzgvWnhDM29ZR1lVUnFMMmxZUmV1MWZJZzcvTjB2dE51bkF1?=
 =?utf-8?Q?kB4CfNAjqG4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB10627.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3VYYWpsY3hxUUNBMzY1WTVhVGNJYWtocFVyTS81cTRXWTI2Y1Y3WkFZOFVK?=
 =?utf-8?B?NnRiZE4rT2lUZlRWQkNoNHZ0elhmUENqK1RhN0VNRWVmTFVLaHpXQzE2VWtr?=
 =?utf-8?B?SlhCNXVkUkQ4Wmp5cytqTmdoZVFyZE84WWhDdkptWlpwOW11MXpDd0VxU0ZL?=
 =?utf-8?B?UjRMdm5EYmpDQThkbnoxdkQ3cWVTV0kyeThqTUI4Q2JlaXFqWk9pN1hrZEMw?=
 =?utf-8?B?Z0luYjFBbFpNT0poZVc0dTAvUWR1UkFETkdTOVhTamlsbEQvcUpzSkNSTFVm?=
 =?utf-8?B?cWl4TVM5dS9sd2ViYmpzb1p5ajhuUWxucWVFbGJycEFNZkUyUWVYM0ZlWlh6?=
 =?utf-8?B?YTBsTDczdklKRjlqckZNcWo3QzA0UTV5SFhWMWhYSnIxek9jVFR4RXB0Vmx4?=
 =?utf-8?B?RU83aE1MTC9tUkpwS09QUUowd0lWM1FubWxzTGZ6c2NDd2xwekRTNkkzdGFF?=
 =?utf-8?B?bmRkNk40WW9sZWhwMTZWUlQxWDZUVW5vMHRaRzQzWGRJZUR3cXR5Q1IvUlB3?=
 =?utf-8?B?Rk5uOEpJemxwd0MyMzFrOC9XQ1NsK1FRbUUzSFYySFJFWk56OXRLczZGcTg0?=
 =?utf-8?B?QXpoMkJTckczbXp6Tlg4VXgzbncyWjJjazE4Mzh3SytFaTFKVk1Gdm9icHQ5?=
 =?utf-8?B?cnBXbW1PbmlOZi8yV24rZlFnUVJNVzNwTWM3NDVTQmJUSk9BNTFYTFd6TlhS?=
 =?utf-8?B?K2pvSTdTaTFOa2ZoTHd4aGErSmpOUkRXc3lRUExxSk1wdzFnVGtnWnN3Q3BD?=
 =?utf-8?B?U3BhK0ZsbWZrd05uQ2l4dUhMV3ZKMmthYkJTa1RHNWpTc0N5OCtDVElrcXZS?=
 =?utf-8?B?bVRVZ1RXcXgreHp5VGVPR0ovZjFyK1VRekVobHkzVXc4eVA1ZVkxVCs0T1hF?=
 =?utf-8?B?elVaekFvWlZzNzdlcVZJcjB2UEhob2VGR21wQmUyOEdiMDdVcVgwWUVubVhL?=
 =?utf-8?B?cWNTSlFsbzJuTjMxdjZ2T0FFTlFCa2I4UTR6NUZpMU5tMTVRNnoyMnU0R0tm?=
 =?utf-8?B?WmdwdHF1MUNXeWpBTVVseHg5NXg4Ky9YRDQ5OFU1L2sxL2d6VUpvaHM3ZFFE?=
 =?utf-8?B?dGVUeUQ4RjUzR3JwK2ZJWDA0dm5pQ083V0xJUklaWmtHdlo1VGNOVDVWSXJI?=
 =?utf-8?B?RjhFZkY1N1F0ZUd3bDZDWERwaW1XSTZCcG5hT2pPdWlXZUl1dFN3TnducitD?=
 =?utf-8?B?ZHRvbTJhK2Y2K3RBcmwvcFpkdy9mZUdtY0hoNFFNSnZaY2RyS2dWbU91TWR1?=
 =?utf-8?B?a0RCQ3RLSGt0QjVCMFU3TE1uaFNFN1k0MDI4WXNlQ2RQeXNUVnFNS2Y3bmE4?=
 =?utf-8?B?ZGw2SWhlb2FLOEc2czdXRUdmZmE0djJRTEdZUGs1U0lYUzdoazdwYVArank4?=
 =?utf-8?B?TGFhdFkzQ1MyU05iZHpKVVdLNEszYWM0Zy94b0Y2Q21wMHpKbUJsdUtHL01w?=
 =?utf-8?B?MlZ3akpEekhIZjJ4Y1RYREFpOVd2MGdTbzdjanVQdXpPeHBKQXp3U0Q1OWJl?=
 =?utf-8?B?d3EwQ3VZQkJpZS91eXZGL1ErOTFiL0Vudkc5SUlwRXFyck54V0xobWs0aGMy?=
 =?utf-8?B?aE0rbHRvMTFTbmY4QnFLeVkvbHZQRWpkamdoRi9rSkRNOHpsaWQvS0lMbDg4?=
 =?utf-8?B?UmJpeFhVbGphQXI3OER4RjZLYW1aQWJGWnZrdmllR2REL2Z3QlZsR0FVcEo2?=
 =?utf-8?B?WTVJSHo4SFNYeWMzMVM1eTFtSmlvM0svYVV1Sy9oSE1xeTIrYW5ocVpabzBI?=
 =?utf-8?B?TTlwYTJiZ0VVOG52aDZHcVlzSmlMWFJyWmY2ek9tTk5XZXluMEp6eDZOQkZa?=
 =?utf-8?B?cVYxaXVWaE53cWZvWDdDQlV5b2src3ZJR1RLd2pPdVVzWjJkbHZLNm5udmFI?=
 =?utf-8?B?dS8xRS9TV09zVDcvS2E2bjJQbjlNd1k4YVdUc2VjWmRIVnFnM2pOMnM2Uzlo?=
 =?utf-8?B?a0pkS201M2VkNitHSlAvdmFpcXVzY2Jma1IvQ09nOGFnRVl1TFhNQ2lrMjlH?=
 =?utf-8?B?WlpmRWFRNEdJQXB3VndvdFpoS3RxRXlXeUF3SU9taWFXcU5POFEzS3FWaTlX?=
 =?utf-8?B?V2phUmhibGpXM3U3aHdrd205cExJNGhrWE1pSkJYMk9SUU1pajUyb2xpSDZk?=
 =?utf-8?B?V3dJL2M5dHNmUUJhcGlGamcvb3pKRWErd2V1ZGVaaXVnK0gyWnZtakV1Qlhz?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LWMBmjpfOTMkHsamphwzNoEMxi5ayYKyN5tj2FPIKJbAovp1mZSnsNGzoQF35wa8851ahXdtAWTTFyh7Zlz/BInA/0SvzCaBjsHE7pD4KzY5hrMkqT9ON+iYoqaQGgIaUrLse88kmnZrOZixmq2aqH1+CUKcLw5JH6Yz5xo+1qIRtZJHPpE2UZdTnK2OKDzqFzvbveza4cDgC0lV0dlCExL+iKaQ4jAHl0niL4s2PcaHfsFIzBhIbh39KvFl+z5dOOUxMw1scIWpMKeeRAEhXKu88ZI4zE64qkQLptSSBjvx5l/CNED4B6RoEik0wIENYIXHCUz8S6H6dUbLxN9ixhmWAPtlSylUuc7zdd3kSrMCXX4WupdWdhqQCwYvrGvwg50zZzgubAh7zB0jsjhWm1lA3dCgLzs7XDNCOP9I/UiL2Qf0LcNwzYd+sdsm3VSxJOtwMfIxNxd4Nm+qHJRDD9JBXzsBpCaRCDHCfI6MSdZgTjsLuczYswjbWCOGyyjQo11HwfVPysG5uKGgvSh/NwkUhECukKGw66K4xFEaRwjwhIepBRIY49ueu04Tfxo6rfsmY2ZDHEVQ10o8xeJbiAG4DalemIkqsHi2tLbQU5MKEhBghvWtiVRGxfUhtQRM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB10627.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e97956-8803-47cb-e211-08dd0e8ba941
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 02:30:55.6596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcr9l75kwIhc0PkmFdp37ju7NNMxGamg6GeXbVPciDM3PrkJschuIGCEPkX9rjBh4QkkbI/EfgOhRipWKNDIZ0OkTYPuJ2WdON7cVw1tzj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6623

PiBPbiAyMDI0LzExLzIxIDEyOjU1LCBUb21vaGlybyBNaXNvbm8gd3JvdGU6DQo+ID4gY29tbWl0
IDQ0YjhmOGJmMjQzOCAoIm1tOiBtZW1vcnktZmFpbHVyZTogYWRkIG1lbW9yeSBmYWlsdXJlIHN0
YXRzDQo+IA0KPiBTb3JyeSBmb3IgbGF0ZSwgSSd2ZSBiZWVuIHN3YW1wZWQgcmVjZW50bHkuDQoN
CkhpLA0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IA0KPiA+IHRvIHN5c2ZzIikgaW50
cm9kdWNlcyBwZXIgTlVNQSBtZW1vcnkgZXJyb3Igc3RhdHMgd2hpY2ggc2hvdw0KPiA+IGJyZWFr
ZG93biBvZiBIYXJkd2FyZUNvcnJ1cHRlZCBvZiAvcHJvYy9tZW1pbmZvIGluDQo+ID4gL3N5cy9k
ZXZpY2VzL3N5c3RlbS9ub2RlL25vZGVYL21lbW9yeV9mYWlsdXJlLg0KPiANCj4gVGhhbmtzIGZv
ciB5b3VyIHBhdGNoLg0KPiANCj4gPg0KPiA+IEhvd2V2ZXIsIEhhcmR3YXJlQ29ycnVwdGVkIGFs
c28gY291bnRzIHNvZnQtb2ZmbGluZSBwYWdlcy4gU28sIGFkZA0KPiA+IHNvZnQtb2ZmbGluZSBz
dGF0cyBpbiBtZl9zdGF0cyB0b28gdG8gcmVwcmVzZW50IG1vcmUgYWNjdXJhdGUgc3RhdHVzLg0K
PiANCj4gQWRkaW5nIHNvZnQtb2ZmbGluZSBzdGF0cyBtYWtlcyBzZW5zZSB0byBtZS4NCg0KVGhh
bmtzIGZvciBjb25maXJtaW5nLg0KDQo+IA0KPiA+DQo+ID4gVGhpcyB1cGRhdGVzIHRvdGFsIGNv
dW50IGFzOg0KPiA+ICAgdG90YWwgPSByZWNvdmVyZWQgKyBpZ25vcmVkICsgZmFpbGVkICsgZGVs
YXllZCArIHNvZnRfb2ZmbGluZT4NCj4gPiBUZXN0IGV4YW1wbGU6DQo+ID4gMSkgIyBncmVwIEhh
cmR3YXJlQ29ycnVwdGVkIC9wcm9jL21lbWluZm8NCj4gPiAgICAgIEhhcmR3YXJlQ29ycnVwdGVk
OiAgICAgMCBrQg0KPiA+IDIpIHNvZnQtb2ZmbGluZSAxIHBhZ2UgYnkgbWFkdmlzZShNQURWX1NP
RlRfT0ZGTElORSkNCj4gPiAzKSAjIGdyZXAgSGFyZHdhcmVDb3JydXB0ZWQgL3Byb2MvbWVtaW5m
bw0KPiA+ICAgICAgSGFyZHdhcmVDb3JydXB0ZWQ6ICAgICA0IGtCDQo+ID4gICAgIyBncmVwIC1y
ICIiIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMC9tZW1vcnlfZmFpbHVyZQ0KPiA+ICAg
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMC9tZW1vcnlfZmFpbHVyZS90b3RhbDoxDQo+
ID4gICAgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbW9yeV9mYWlsdXJlL3NvZnRf
b2ZmbGluZToxDQo+ID4gICAgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbW9yeV9m
YWlsdXJlL3JlY292ZXJlZDowDQo+ID4gICAgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUw
L21lbW9yeV9mYWlsdXJlL2lnbm9yZWQ6MA0KPiA+ICAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9k
ZS9ub2RlMC9tZW1vcnlfZmFpbHVyZS9mYWlsZWQ6MA0KPiA+ICAgIC9zeXMvZGV2aWNlcy9zeXN0
ZW0vbm9kZS9ub2RlMC9tZW1vcnlfZmFpbHVyZS9kZWxheWVkOjANCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRvbW9oaXJvIE1pc29ubyA8bWlzb25vLnRvbW9oaXJvQGZ1aml0c3UuY29tPg0KPiA+
IC0tLQ0KPiA+IEhlbGxvDQo+ID4NCj4gPiBUaGlzIGlzIFJGQyBiZWNhdXNlIEknbSBub3Qgc3Vy
ZSBhZGRpbmcgU09GVF9PRkZMSU5FIGluIGVudW0NCj4gPiBtZl9yZXN1bHQgaXMgYSByaWdodCBh
cHByb2FjaC4gQWxzbywgbWF5YmUgaXMgaXQgYmV0dGVyIHRvIG1vdmUNCj4gPiB1cGRhdGVfcGVy
X25vZGVfbWZfc3RhdHMoKSBpbnRvIG51bV9wb2lzb25lZF9wYWdlc19pbmMoKT8NCj4gPg0KPiA+
IEkgb21pdHRlZCBzb21lIGNsZWFudXBzIGFuZCBzeXNmcyBkb2MgdXBkYXRlIGluIHRoaXMgdmVy
c2lvbiB0bw0KPiA+IGhpZ2hsaWdodCBjaGFuZ2VzLiBJJ2QgYXBwcmVjaWF0ZSBhbnkgc3VnZ2Vz
dGlvbnMuDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFRvbW9oaXJvIE1pc29ubw0KPiA+DQo+ID4g
IGluY2x1ZGUvbGludXgvbW0uaCAgICAgfCAyICsrDQo+ID4gIGluY2x1ZGUvbGludXgvbW16b25l
LmggfCA0ICsrKy0NCj4gPiAgbW0vbWVtb3J5LWZhaWx1cmUuYyAgICB8IDkgKysrKysrKysrDQo+
ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0u
aA0KPiA+IGluZGV4IDVkNmNkNTIzYzdjMC4uN2Y5M2Y2ODgzNzYwIDEwMDY0NA0KPiA+IC0tLSBh
L2luY2x1ZGUvbGludXgvbW0uaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW0uaA0KPiA+IEBA
IC0zOTkxLDYgKzM5OTEsOCBAQCBlbnVtIG1mX3Jlc3VsdCB7DQo+ID4gIAlNRl9GQUlMRUQsCS8q
IEVycm9yOiBoYW5kbGluZyBmYWlsZWQgKi8NCj4gPiAgCU1GX0RFTEFZRUQsCS8qIFdpbGwgYmUg
aGFuZGxlZCBsYXRlciAqLw0KPiA+ICAJTUZfUkVDT1ZFUkVELAkvKiBTdWNjZXNzZnVsbHkgcmVj
b3ZlcmVkICovDQo+ID4gKw0KPiA+ICsJTUZfUkVTX1NPRlRfT0ZGTElORSwgLyogU29mdC1vZmZs
aW5lICovDQo+IA0KPiBJdCBtaWdodCBub3QgYmUgYSBnb29kIGlkZWEgdG8gYWRkIE1GX1JFU19T
T0ZUX09GRkxJTkUgaGVyZS4gJ21mX3Jlc3VsdCcgaXMgdXNlZCB0byByZWNvcmQNCj4gdGhlIHJl
c3VsdCBvZiBtZW1vcnkgZmFpbHVyZSBoYW5kbGVyLiBTbyBpdCBtaWdodCBiZSBpbmFwcHJvcHJp
YXRlIHRvIGFkZCBNRl9SRVNfU09GVF9PRkZMSU5FIGhlcmUuDQoNClVuZGVyc3Rvb2QuIEFzIEkg
ZG9uJ3Qgc2VlIG90aGVyIHN1aXRhYmxlIHBsYWNlIHRvIHB1dCBFTlVNIHZhbHVlLCBob3cgYWJv
dXQgY2hhbmdpbmcgbGlrZSBiZWxvdz8NCk9yLCBkbyB5b3UgcHJlZmVyIGFkZGluZyBhbm90aGVy
IEVOVU0gdHlwZSBpbnN0ZWFkIG9mIHRoaXM/DQoNCmBgYA0Kc3RhdGljIHZvaWQgdXBkYXRlX3Bl
cl9ub2RlX21mX3N0YXRzKHVuc2lnbmVkIGxvbmcgcGZuLA0KLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVudW0gbWZfcmVzdWx0IHJlc3VsdCkNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBlbnVtIG1mX3Jlc3VsdCByZXN1bHQsIGJvb2wgaXNfc29mdF9v
ZmZsaW5lKQ0KIHsNCiAgICAgICAgaW50IG5pZCA9IE1BWF9OVU1OT0RFUzsNCiAgICAgICAgc3Ry
dWN0IG1lbW9yeV9mYWlsdXJlX3N0YXRzICptZl9zdGF0cyA9IE5VTEw7DQpAQCAtMTI5OSw2ICsx
Mjk5LDEyIEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9wZXJfbm9kZV9tZl9zdGF0cyh1bnNpZ25lZCBs
b25nIHBmbiwNCiAgICAgICAgfQ0KDQogICAgICAgIG1mX3N0YXRzID0gJk5PREVfREFUQShuaWQp
LT5tZl9zdGF0czsNCisgICAgICAgaWYgKGlzX3NvZnRfb2ZmbGluZSkgew0KKyAgICAgICAgICAg
ICAgICsrbWYtPnN0YXRzLT5zb2Z0X29mZmxpbmVkOw0KKyAgICAgICAgICAgICAgICsrbWZfc3Rh
dHMtPnRvdGFsOw0KKyAgICAgICAgICAgICAgIHJldHVybjsNCisgICAgICAgfQ0KKw0KICAgICAg
ICBzd2l0Y2ggKHJlc3VsdCkgew0KICAgICAgICBjYXNlIE1GX0lHTk9SRUQ6DQogICAgICAgICAg
ICAgICAgKyttZl9zdGF0cy0+aWdub3JlZDsNCmBgYA0KDQpSZWdhcmRzLA0KVG9tb2hpcm8gTWlz
b25vDQoNCj4gDQo+IA0KPiBUaGFua3MuDQo+IC4NCg0K

