Return-Path: <linux-kernel+bounces-199764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D668FA591
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC848288621
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2D13C9A1;
	Mon,  3 Jun 2024 22:32:19 +0000 (UTC)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D2137927
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453938; cv=fail; b=UsT3bYNzyfRUxIQrQh7i+NEu8sqrR8YIvxDR8UE1fB7KDQMsWqc0qcf0n8gO1lX9pQNZitPczr/We0sfgQbykCOSmZOGtysA03uls53nHPCqjv+OUzPZGhl0036vRfIlum6PokHm0WLS1sjP/FszBFhHk4st4rYAFWwy3rmevhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453938; c=relaxed/simple;
	bh=B0C1UwFfaxHukKQUueqaufDko9ZZyUKia/Av+3yaadE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myh64IqCnRaZLTvywxEBHGEcqY0NjCmUc5stpOwVDVH9He2d2BJdD2x1e+gnGFrC45+K7R1AtQAn6nYWxP55QT5R2vJOHMJyV5hiCiADfBMf5QdK5KtkYgVk8EOl/yaPkv/qDryJ8YTRl/P7A6ecKJ5SZBGRLA6D6vBuMvKmFF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453E2HEf026966;
	Mon, 3 Jun 2024 22:32:04 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dhpe.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpps0720;_bh?=
 =?UTF-8?Q?=3DB0C1UwFfaxHukKQUueqaufDko9ZZyUKia/Av+3yaadE=3D;_b=3DhYLTCqud?=
 =?UTF-8?Q?dDI86RQKO7uXfqOL8jHrdsA+n7Ki5xGw5OuEwyXzlfrVtFALAYXMbPUJTXvF_tO?=
 =?UTF-8?Q?GUuBMNkDT5PbWBE59UUTQXD0eYnDIDz/TuEPQ5ZOo9uburjHjFk/tsjezxsATEb?=
 =?UTF-8?Q?Zk7_YE0pEM3xG9nfm3Rg6AirxSMd3sJpvhZ9wsRhZ1oKteaxS2g2F5TPDhiy3AO?=
 =?UTF-8?Q?g6qfcvCy4_NXVyAfKEShLrHdlA0QiQqpTVYWBIQwtEtUB/fPyJsDqw/ifVpRp+Z?=
 =?UTF-8?Q?5rkC9OEQ62oqTKa_MPENG79z0CW+++QRZjbop8VH+7TqKcQdRS+vNlS11OMYzg8?=
 =?UTF-8?Q?dp3gk0UmzjRkCD5jmAq0K_gA=3D=3D_?=
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3yh9kwxs2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 22:32:03 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 1A08E8059E5;
	Mon,  3 Jun 2024 22:32:02 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Jun 2024 10:32:02 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 3 Jun 2024 10:32:02 -1200
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Jun 2024 10:32:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXgcTWV680MB4WlUBWkPgHXtYKZ+F0NbrEpQNBG6sNzIhRnYp5KWC9lRnk2cVuJUggfkRzU8ygDHAI35K0KW07A5yDltmFewIb2lKCQxsik33wciupA+KwipEM9SbK73e1xzi0Had/5oGsUfgRJ1l58w808ZmE0+jIQGoAzYSJSIdvbh8UQSQscXKQpZMuXisXL7ajglcVElgqiV+2vL+z3eU3Botv2gUiYNUs+/AhCzY72W+nSSinMpYh/cdHcRh2SPZzvWK3mrCLJKxQbwMtPVG9Tw8mrljEi7MCoIlFKBpmNZNe5KHGZXV2JYeNr+lZRZ8KmX1SlK8jwWM5TQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0C1UwFfaxHukKQUueqaufDko9ZZyUKia/Av+3yaadE=;
 b=Gtx5e2ySOS8z+8Bq0uGMJu17wSVvMw5HDPCGjkg1S9nTHvd49PaxwkSyfsqLKJyxO8gHahr5O6212QZwLJNZCJW+fAYUsEMN8WAP+ScctII0sFUlArU/oPKwz8jw7atZWBUsp4Ykj1ThxmB5vmVzgLv48/zqCsXD2NXXw9yQu13udryUqxmRcb09TjnUETa3Ps3HntI6+XLj9AVwkszl3eDWE7Hyju6MVPRWpI+jPNzJL0sekV+169FfNdNn4IVd2UdI9CEeoa+7lutvROZP2qJOFyg2aLf4RtkNVQsPVl2LLZQv0M5AZIJqhSZooEBoba8BmAauIJCOl6QKiLxy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB1652.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:433::13)
 by PH0PR84MB1978.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:161::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 22:32:00 +0000
Received: from SJ0PR84MB1652.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::211f:8af2:c674:966b]) by SJ0PR84MB1652.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::211f:8af2:c674:966b%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 22:32:00 +0000
From: "Klein, Curtis" <curtis.klein@hpe.com>
To: Rodolfo Giometti <giometti@enneenne.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pps: clients: gpio: Continue after failing to get
 optional ECHO pin
Thread-Topic: [PATCH] pps: clients: gpio: Continue after failing to get
 optional ECHO pin
Thread-Index: AQHas6wbDdDMVmcuU0W8pIHrdktkDbG1mFKAgAD55OA=
Date: Mon, 3 Jun 2024 22:32:00 +0000
Message-ID: <SJ0PR84MB16523160FD193563BE3FF26789FF2@SJ0PR84MB1652.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240531224411.3515712-1-curtis.klein@hpe.com>
 <177dd111-fb1a-4650-9c81-ab5903859c77@enneenne.com>
In-Reply-To: <177dd111-fb1a-4650-9c81-ab5903859c77@enneenne.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB1652:EE_|PH0PR84MB1978:EE_
x-ms-office365-filtering-correlation-id: 9b16444c-0e37-45b0-a2ca-08dc841cfc68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YXljT1RMQnV5dWZPMXNFMTJ4Wko4OHVxVUpCRS95aEE4UklydWRTTlVkZU1Q?=
 =?utf-8?B?aEUvemkxV1RoOGdsandUaVhJaFlKY3FoTTljSWhKa1hIQW0xUFAwVTBYZWpN?=
 =?utf-8?B?ekJnQjNTQ1VTUnBmOFpiK0lMWVNhUFFORzgwYzY0VVd6WnFjVDNXZWQ2aDAr?=
 =?utf-8?B?YkhhNk8vUkxtSm1EaDRXVTZWWmZHck1zOXVHQ0l3RDhKYmxHYXJIalBackJS?=
 =?utf-8?B?b3k0OTRMd1dZYUVXaUJwZE9STkNrcGpqTjFDNDRjbUVRbm10Z0h2cENGRUll?=
 =?utf-8?B?MEVMSjl5WlhIejFaQWpFeWtlSVM5YkpjcktybVlRWjRpancvOUV6NDRqQ0h0?=
 =?utf-8?B?cThlUStZa0haZ0lwYjhiSHpGWkFzelBrcTRoZUJiOG92aEJMemVYdWlONkFS?=
 =?utf-8?B?SzZCMTBrQVU1VFZsUWtYQkRYM0RWanJzbjdZNDRZNTB4bnYrdW05d3J6bjla?=
 =?utf-8?B?UXJYRTBQZUJPanphRi9KN0ZrQnpFaHIzSmFrUDRieW81dzk5MGNESXFvOWtN?=
 =?utf-8?B?OFZHNWlxR1V6dXRLZzdycTNNOEZIc3pibllnaDhIb1ZOVnlOR20yWklDeHFV?=
 =?utf-8?B?WVRaTTcvS1NGOTN4NUd6bUtZR0FieHBtL2NNdVFnVE1tKzR0SlcyVlBqbEgy?=
 =?utf-8?B?Tjk3NTAwRXZmMlZQMGtGajJucnh2Y3pVTFlXMGJCeU9OM2daRFdmOGdJMk5V?=
 =?utf-8?B?Uk02Skt6Y3MwaTZMK2FOSWl2dm5LTytuc1VoTHI5aEV1VnB4bm14U3YyY2dR?=
 =?utf-8?B?VWZMV21aZmM5VEdZZUtyV1ZUekw0YXdiYnVDV0gvZHZGMGRoOVp0RHVLejRI?=
 =?utf-8?B?QUZhM0gxM2U1SExpTDNpSlhLcTcreGpEOG5UcGQyMkNiNUd6UTBLTXcxcCsy?=
 =?utf-8?B?M3pWcnpGVGdZN0JxTXMyNThVOHJSLzc2dWRybWpsYStNVzV2RDFhek5Qd29J?=
 =?utf-8?B?emZoZ054STh5ekdJclVxQmxMK3c3cDU3QW5hZldHMWw0dENyakw4ZXFFdVow?=
 =?utf-8?B?N1ZPUk8rM2hxc2lJZXdRQjJJZFRaajMwbFhBQ25UczA5MWJHTG1zMUNYbDJa?=
 =?utf-8?B?QmN5a1V1MzNySXVvelErTHZBTTNvRnZTcmxxbjdCZzJOUjczUElTanYvSTAz?=
 =?utf-8?B?WksvblV2WSsxeDIxM2l5SUFXV01RMGZ6bUUyOEFqN2Jmay9pdVRvNmpaTXpa?=
 =?utf-8?B?UjM4RHVkSi80NEFpY3VZV2l6YldsL0hmNVJYMG51bzVKTUdDa0IvLzVPeDQ2?=
 =?utf-8?B?SmVlbmRVQjlVZUxibnBpQytsSzJkWStMY2pNbkFidE5jZFRtR3hjbldFTk9n?=
 =?utf-8?B?QU0vZmZyVFprYUNPS3RNT1pzR0N1T0lrWUpyMDVMQzVHZ2szb05OeStrYkZx?=
 =?utf-8?B?Z3d0S1FmTVd3MU5KckVvWkZscnd5MS9ONVRRRS9SMFUxNWQwUmw0SlJ0aUVB?=
 =?utf-8?B?eVJsQUM0alozcGt0SWc4OWxuZC9IT0FiVWNTdmprSnpFeFhMcWd4Z3k3Yzlt?=
 =?utf-8?B?M2JuR2VndjluWkd1SDFiQmUrUjRxY0lFeUFHMVdzdDVkZXFsd1J6YjFXNjNJ?=
 =?utf-8?B?bDRwL29SLzZyNzBuejYrNXp6QTR3L1RBdjVtWDRjUEV0RE8rR2NQcWZWWEw0?=
 =?utf-8?B?cGIwN2tkRVdLU0VNOXFvOHNUWUZXcW1vTCtBRkR1dmcyU3B4cTBwNVlKZW9G?=
 =?utf-8?B?WHBTc1p5WnZNRUVxOVR3b2JUSUFqVDVZbW9jbU5OTmFURmdrRjc5b09GUGxB?=
 =?utf-8?B?QTRpSnRrOGFveTlhekZ2YVVkSGRoelhLMHpjSGMyYnhQenFiV1ZTVUxwUHh4?=
 =?utf-8?B?bGlrbi96UlB5b0VKZXB2dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB1652.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnVUemNYbXdVMVRPdkhyOXljSjV2L2cwTzJnU2NOR0gzSVpkYVNmK3B1ZHZa?=
 =?utf-8?B?QzRscW9yeG5pckY0TDl1TC9XZDhObDJLS0xYVEYxSVZ3VUF2VW9PL1hPdUJu?=
 =?utf-8?B?SjVHNDlVcGNIeUdUQ0QwSm9BckpEMW9lVHBHaUk1WTBGdzZmTHpGc1RuSGd6?=
 =?utf-8?B?MHo1ajRLVlptZ0pyUXRIeGdxZ3JyY1dBUWoyMTBab2ZCWnZGQ0labm80Y0xz?=
 =?utf-8?B?OWluZHcxNkxMUWhBL092WkI4KzJLdUZJSUJBUVBYQWVEN0pFQnRhblRTbmow?=
 =?utf-8?B?dFlXeEJQejJYc3R1b0VWaVRtUENJcXhxWnRoZEZXQnRGR0hOUy8rMGdxcmRu?=
 =?utf-8?B?ZmxjNUlLS0haVjJXRG13VzlBREprWTFtSDgrSm5ZcWNkQ1dqa1poY0p2aUpF?=
 =?utf-8?B?cU9NMUJBR0d5dklTSlFRaEpha2gyVjFPcHkvUnlJQm8vS1FQeEpJT0NsL3dI?=
 =?utf-8?B?VjVTYTZJOC9zSndONCtmYXFIYzg4RndGejRYbUliV3JXMFA5eDJKdVZGMkUv?=
 =?utf-8?B?R1Y1NXVLK09TMGZRbmZ6UldpTGkvTUtDS3FSRURXdXZ2R0ZHNjROWVlvaDlx?=
 =?utf-8?B?TkFiL1Zwdm9ZK2dCZFQwMWlOL2VFZGk0c2xHa2dTazl1cFFuaU1kdGRFMDN3?=
 =?utf-8?B?QmdyWThhNFd4cyt5R3AvUTBtQjlvWDZkRGFyWituVlFzNmUweXdnb3dlbkcx?=
 =?utf-8?B?ZGtSQUtHTGs0b3gxM0RYMlk0TEZNNmpkbmsyRjFvWUMxb1BZd3JKdmNHb2lK?=
 =?utf-8?B?aC9qSTVTS0RQZHZranNtdnpGc3dOQjZhT0hLdHBZNDlOaklXeXpEK2daVjJp?=
 =?utf-8?B?eUFwTkloTnJZZEFQc2YxdFQ5My9wN1NpbzlUNzVTZEVHeEU3UU5VelhuaUpv?=
 =?utf-8?B?NzJrVGFmMTg4eGhVek96bFZzRmFkazBGT1N1UUJrRzdOZXBCcUZaR0xvS1ps?=
 =?utf-8?B?V3BYQTZUbjd5T2FXa2lYOHF0VTNaajc2d2w2Ny9YRktGVlR5MGFUYWRpMDNY?=
 =?utf-8?B?RWNkVG53SktsMlJvYlhvMGw4NmZuK0Y1cysyeEc1ckJmNFBBcVZma2RIeTZG?=
 =?utf-8?B?UlBlSGxrVEJRNFJaZythMkdRM1ZNQXRDQnZnWEtrai9lMC9rN01WSzhQbGRk?=
 =?utf-8?B?TmpzOE1NakFMbTRNb2xaT1MrYkNjbGtxemxwTUE4WjgvT21UNHgrUG9RKytI?=
 =?utf-8?B?b05kTmNPa1ZITXhHMkhWVXBpeUtNMTk0OFVWWG1aekFta1FnNktzUTZtQklQ?=
 =?utf-8?B?bjY2QTNwdTkveGU4Wjdya2RJV2x5R291b3dBaWd6VVV0OEdRWXMwekJnTDdF?=
 =?utf-8?B?enZxU0x5cHd3WXJhbFYyUlJCVDBPcGI1YWZ4MjBlTXh5SzNlVW5kancxR0xh?=
 =?utf-8?B?Q3JFOCt4ZnRBdEJSeG51dmt4TTI4bTZFbnVpZ0Z6alZvYzQyaW1sdG0vZ0Y3?=
 =?utf-8?B?UkFZbWdOUkw2c29kc1gzaTRGY3MyazBlWHJEL1IvN3ZTaG82V0ZSWUtVUWND?=
 =?utf-8?B?UUltNlMrNjJYWmdPc3RmS0I4ODRTbjQ0V3BFT3RoeFFxR0l4aU1BYXVFQmNF?=
 =?utf-8?B?dEVIazZPZk1DMVZ0QWdiaCtwdkFYQVNvd0FzZWUyd2xqUzRUcmIzZ1U5SWM1?=
 =?utf-8?B?Zmdpa1MyRUpJTVg2M2d6NVZISlN5Ui93djRBWjZmVnlKQzh1VE1xeDFVQVhB?=
 =?utf-8?B?NERSUUtNdzg4bmNGMGhaRjQ1WXRVcnd3YmplMUo0dWMzS3Z1VFlVZkZ4dXpR?=
 =?utf-8?B?Smh2dGM5a3FTMVdUY2ZBNWd0bzdIOVdCODkvTGM4cU44Z1BNUjVsb21Yend2?=
 =?utf-8?B?Z01DaWJVWmMwTTdkTDZGZWhDOXgycjMyVFFhN1U4TUVMS0t6Q0RPcFFvbmtD?=
 =?utf-8?B?a3BLNisrUktrVTdNOFlKalNBcTh2QkJVbmZOYnlWN1ZoWGJXTzhSNzNHK1Jo?=
 =?utf-8?B?bkdCdGh5ZmZmME5sQk8wbE9lRk9tQllCZDNud0tVVVRBd1ZNWmxXTUFuNUY2?=
 =?utf-8?B?NWlOMk5hU0JWY1BTNlZNdGM0UlIyN2N4bERpK0dJL3NSUVd5Rmd5VW1wajJa?=
 =?utf-8?B?SndZZmZ2dXFHU2N4Qjk5SVNrZEsxVnhKQlB4eTI0RTBhQk9xR3J1Q0Q3LzBI?=
 =?utf-8?Q?RydpFmBimzDvsNT0u+iGrt6tC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB1652.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b16444c-0e37-45b0-a2ca-08dc841cfc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 22:32:00.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQsEOJ6GZLounhmSdIwCBY6DHvn2p0+TKtXP4rzOaaGCHr3Yg2P7i5s8Z1OrwWCH+hf8DyCxpv/roFW46nxwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1978
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: sEYGaEtN-Rxvgj9aHpSDzOXCw1j3o8-F
X-Proofpoint-GUID: sEYGaEtN-Rxvgj9aHpSDzOXCw1j3o8-F
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406030183

T24gU3VuZGF5LCBKdW5lIDIsIDIwMjQgMTE6MzMgUE0sIFJvZG9sZm8gR2lvbWV0dGkgd3JvdGU6
IA0KPiBPbiAwMS8wNi8yNCAwMDo0NCwgQ3VydGlzIEtsZWluIHdyb3RlOg0KPiA+IFdhcm4gYnV0
IGRvIG5vdCBmYWlsIHdoZW4gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwgcmV0dXJucyBhbiBlcnJv
ciB3aGVuDQo+ID4gdHJ5aW5nIHRvIGdldCB0aGUgRUNITyBwaW4uIFdoZW4gY3JlYXRpbmcgYSBw
cHMtZ3BpbyBkZXZpY2UgdXNpbmcNCj4gPiBwbGF0Zm9ybSBkYXRhIGFuZCBHUElPIGxvb2t1cCB0
YWJsZXMsIHRoZSBjYWxsIHRvIGdwaW9kX2dldF9vcHRpb25hbA0KPiA+IHdpbGwgbWF0Y2ggb24g
dGhlIHVubGFiZWxlZCBwaW4gbWVhbnQgYXMgdGhlIGlucHV0IHdoZW4gc2VhcmNoaW5nIGZvcg0K
PiA+IHRoZSAiZWNobyIgcGluLiBTaW5jZSBpdCBpcyBhbHJlYWR5IGluIHVzZSBhcyB0aGUgUFBT
IGlucHV0LCBpdCB3aWxsDQo+IA0KPiBJJ20gbm90IHN1cmUgdG8gd2VsbCB1bmRlcnN0YW5kIHdo
YXQgeW91IG1lYW4gaGVyZTogd2h5IHRoZSAiZWNobyIgcGluDQo+IHNob3VsZCBiZQ0KPiBhbHJl
YWR5IGluIHVzZSBhcyB0aGUgUFBTIGlucHV0Pw0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFp
biBiZXR0ZXIgdGhpcyBzaXR1YXRpb24gd2l0aCBhIHJlYWwgZXhhbXBsZT8NCj4gDQoNClN1cmUs
IHNvcnJ5IGl0J3Mga2luZCBvZiBoYXJkIHRvIGV4cGxhaW4gd2l0aCB3b3Jkcy4gSGVyZSdzIHRo
ZSBncGlvDQpsb29rdXAgdGFibGUgSSdtIHVzaW5nOiANCg0KICBzdGF0aWMgc3RydWN0IGdwaW9k
X2xvb2t1cF90YWJsZSBwcHNfZ3Bpb190YWJsZSA9IHsNCiAgICAgIC5kZXZfaWQgPSAicHBzLWdw
aW8uMCIsDQogICAgICAudGFibGUgID0gew0KICAgICAgICAgIEdQSU9fTE9PS1VQX0lEWCgiZ3Bp
by4wIiwgMjMsIE5VTEwsIDAsIEdQSU9fQUNUSVZFX0hJR0gpLA0KICAgICAgICAgIHt9IC8qIFRl
cm1pbmF0aW5nIGVudHJ5ICovDQogICAgICB9fTsNCg0KV2UgaGF2ZSBhIHNpbmdsZSB1bm5hbWVk
IGVudHJ5IHRoYXQgaXMgbWVhbnQgdG8gYmUgdXNlZCBhcyB0aGUgaW5wdXQNCnBpbi4gTm8gImVj
aG8iIHBpbiBpcyBkZWZpbmVkLiBXZSByZWdpc3RlciB0aGlzIHVzaW5nIA0KImdwaW9kX2FkZF9s
b29rdXBfdGFibGUoJnBwc19ncGlvX3RhYmxlKSIuDQoNClNvIHRoZSBmaXJzdCB0aW1lIHRoZSBw
cHMtZ3BpbyBkcml2ZXIgZ2V0cyB0aGUgaW5wdXQgcGluIHdpdGggDQoiZGV2bV9ncGlvZF9nZXQo
ZGV2LCBOVUxMLCBHUElPRF9JTik7Iiwgd2Ugd2lsbCBnZXQgdGhlIG9uZSBhbmQgb25seSANCmdw
aW8gZW50cnkgaW4gdGhlIGxvb2t1cCB0YWJsZS4gVGhlbiB3aGVuIHdlIHRyeSB0byBnZXQgdGhl
ICJlY2hvIiBwaW4NCndpdGggImRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgImVjaG8iLCAg
R1BJT0RfT1VUX0xPVyk7IiB3ZSB3aWxsDQphbHNvIG1hdGNoIHRoZSBzYW1lIGVudHJ5IGluIHRo
ZSBsb29rdXAgdGFibGUuIFRoaXMgaXMgYmVjYXVzZSB0aGUNCm1hdGNoaW5nIGxvZ2ljIGluIGdw
aW9fZmluZCAoaW4gImRyaXZlcnMvZ3Bpby9ncGlvbGliLmMiKSB3aWxsIGFsbG93IGFuDQp1bm5h
bWVkIHBpbiBpbiBhIGxvb2t1cCB0YWJsZSB0byBtYXRjaCBhbnkgcmVxdWVzdCBmcm9tIGEgZ3Bp
b19nZXQNCmZ1bmN0aW9uLiBXaGVuIHRoaXMgaGFwcGVucywgImRldm1fZ3Bpb2RfZ2V0X29wdGlv
bmFsIiByZXR1cm5zIC1FQlVTWQ0KYmVjYXVzZSB0aGUgcGluIGlzIGluIHVzZSAoYXMgdGhlIHBw
cy1ncGlvIGlucHV0KSBhbmQgdGhlIHBwcy1ncGlvDQpkcml2ZXIgZmFpbHMgdG8gbG9hZC4NCg0K
SWRlYWxseSwgSSB0aGluayB5b3UnZCB1c2UgYSBzd25vZGUgdG8gZGVmaW5lIHRoZSBncGlvcyAo
aWYgQUNQSSBjaGFuZ2VzDQphcmUgbm90IHBvc3NpYmxlKS4gQnV0IHRoaXMgY2hhbmdlIHdvdWxk
IHVuYmxvY2sgdGhvc2UgdGhhdCBuZWVkIHRvIHVzZQ0KZ3BpbyBsb29rdXAgdGFibGVzLiBDb250
aW51aW5nIGFmdGVyIGFuIGVycm9yIG9uIGEgb3B0aW9uYWwgb3BlcmF0aW9uDQpzZWVtcyBva2F5
IHRvIG1lLCBidXQgSSB1bmRlcnN0YW5kIGlmIHRoYXQgZ29lcyBhZ2FpbnN0IHRoZSBub3JtYWwN
CmNvbnZlbnRpb24uDQoNCj4gPiBmYWlsIHdpdGggLUVCVVNZLiBBcyB0aGUgRUNITyBwaW4gaXMg
b3B0aW9uYWwsIHdlIGp1c3Qgd2FybiBvbiB0aGUgZXJyb3INCj4gPiBhbmQgY29udGludWUgdGhl
IGluaXRpYWxpemF0aW9uLiBUaGlzIGFsbG93cyB1cyB0byBzdXBwb3J0IGRldmljZXMNCj4gPiBj
cmVhdGVkIHVzaW5nIEdQSU8gbG9va3VwIHRhYmxlcyBpbnN0ZWFkIG9mIEFDUEksIERULCBzd25v
ZGUsIGV0Yy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEN1cnRpcyBLbGVpbiA8Y3VydGlzLmts
ZWluQGhwZS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3Bwcy9jbGllbnRzL3Bwcy1ncGlv
LmMgfCA5ICsrKysrKy0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bwcy9jbGllbnRz
L3Bwcy1ncGlvLmMgYi9kcml2ZXJzL3Bwcy9jbGllbnRzL3Bwcy1ncGlvLmMNCj4gPiBpbmRleCAy
ZjRiMTFiNGRmY2QuLmI3ZGI0YTNlZTk3ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bwcy9j
bGllbnRzL3Bwcy1ncGlvLmMNCj4gPiArKysgYi9kcml2ZXJzL3Bwcy9jbGllbnRzL3Bwcy1ncGlv
LmMNCj4gPiBAQCAtMTE0LDkgKzExNCwxMiBAQCBzdGF0aWMgaW50IHBwc19ncGlvX3NldHVwKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgIAkJZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYs
ICJhc3NlcnQtZmFsbGluZy1lZGdlIik7DQo+ID4NCj4gPiAgIAlkYXRhLT5lY2hvX3BpbiA9IGRl
dm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgImVjaG8iLA0KPiBHUElPRF9PVVRfTE9XKTsNCj4g
PiAtCWlmIChJU19FUlIoZGF0YS0+ZWNob19waW4pKQ0KPiA+IC0JCXJldHVybiBkZXZfZXJyX3By
b2JlKGRldiwgUFRSX0VSUihkYXRhLT5lY2hvX3BpbiksDQo+ID4gLQkJCQkgICAgICJmYWlsZWQg
dG8gcmVxdWVzdCBFQ0hPIEdQSU9cbiIpOw0KPiA+ICsJaWYgKElTX0VSUihkYXRhLT5lY2hvX3Bp
bikpIHsNCj4gPiArCQlkZXZfd2FybihkZXYsICJmYWlsZWQgdG8gcmVxdWVzdCBFQ0hPIEdQSU86
ICVsZFxuIiwNCj4gPiArCQkJIFBUUl9FUlIoZGF0YS0+ZWNob19waW4pKTsNCj4gPiArCQlkYXRh
LT5lY2hvX3BpbiA9IE5VTEw7DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4NCj4gPiAg
IAlpZiAoIWRhdGEtPmVjaG9fcGluKQ0KPiA+ICAgCQlyZXR1cm4gMDsNCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IFJvZG9sZm8NCj4gDQo+IC0tDQo+IEdOVS9MaW51eCBTb2x1dGlvbnMgICAgICAgICAg
ICAgICAgICBlLW1haWw6IGdpb21ldHRpQGVubmVlbm5lLmNvbQ0KPiBMaW51eCBEZXZpY2UgRHJp
dmVyICAgICAgICAgICAgICAgICAgICAgICAgICBnaW9tZXR0aUBsaW51eC5pdA0KPiBFbWJlZGRl
ZCBTeXN0ZW1zICAgICAgICAgICAgICAgICAgICAgcGhvbmU6ICArMzkgMzQ5IDI0MzIxMjcNCj4g
VU5JWCBwcm9ncmFtbWluZw0KDQotQ3VydGlzDQo=

