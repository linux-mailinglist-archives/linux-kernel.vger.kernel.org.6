Return-Path: <linux-kernel+bounces-570356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296CBA6AF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB96D8A68E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAEA228C9D;
	Thu, 20 Mar 2025 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iQ7qZZZ1"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010006.outbound.protection.outlook.com [52.103.11.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691CC1DDA39
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503304; cv=fail; b=a3BSYFDo7AEQBAFYuW6Fp/HZT5wFUU+RAwwnyWSzYq8qKPHKerl+64pg+pUmu5p2Onv18wdn3MTzOmZ31bRli7dm/bq+6wQVHHWk9OJdPCechCAfWawcjeA5s8k7y7iTKCV1IplS8iaGb3/X52cM8r+u0/DxXxjb5flh1kyEYAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503304; c=relaxed/simple;
	bh=GupO6qgr3DAZTHbqnvEQ2DcYXYt5z66rHvmx4mFwxwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMj0Du8MHqNYN9KJczq7glTxVx+EWhPi89/dcIU1N2Dz917dccULebnJadSWST2XB196fp3QbqzkTDq+Z3VKuFJOWnKaZh+h1I1uEoaVlamjC1S6bzgewACXqgMAbshszGZFcKfNxT1JZbW2CwFUJgYIN5DKVjPATb69I0XLoWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iQ7qZZZ1; arc=fail smtp.client-ip=52.103.11.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+oQa94qUL6EejIaRhZxub1zkbMqROrSMSLjepKIUP9TEMop7uJsw2XmPD9dkkuIFlheHymaPCGTfhO3XotZoOQ6GiWI92jlhs9CKD/uR88FihPfZa9TbS9BqsMsHFOuyOqKmNdSLlMiezx2jnpIZv+or3obPZgHAiNpavztQYhRbZQCdguEtv3rnZUvhIE9yrlhrkhiXg1I18XfEEuGUrZskV9S6BHw7SrisO3NHDP5OR/tN3mIWMNd8rIEdMOChZOIH7cSATkxo8bSv/HQqWNxKLDEwqhdXvBqQm1tMsmxboT6xwsQVVmMlQGVP4PFVlFhHXql2VSAQUVvfe58Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GupO6qgr3DAZTHbqnvEQ2DcYXYt5z66rHvmx4mFwxwc=;
 b=WIbwordfnHbdro1vMMbiHEJc1IzRZFb42s6HeSax3E5q4D0VzXGLNVlsf6J22/fO+G9Nqcs4LUkJd/CSTPpff0LSvN/UYMlbqI/vco1TORu6QVCwor6H7t/WllFiUmftBQUT/TlRdjrLqKNjIz4VjqepC9Jxy3RF1jm88cQoSCGVcDYEcBxUkqX9SZy9lCPFjmf8hNJR+U9S7KS/a68vajdRp+alfdn59OC3VXIMrErRDdN2A7V9M2+kxDQrHBsLXCat19j4EvuSzCoJbeQ02WsM8lXsNLmsUqf/mF3cguk9PlyJzNWpZhOmei7ls1laWWUF4lg7FxfnNpT4jMfckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GupO6qgr3DAZTHbqnvEQ2DcYXYt5z66rHvmx4mFwxwc=;
 b=iQ7qZZZ1TcPSJDOZOWasnA1VOgG18hSFM7nTNlAzAazySzmcx8TG+z9zsGct+Fn4aATaNjtbropn7b1LRxpE40uNuf6ipEBb4TwrL/5vtHRHjArqTOXYd1qVW6nTLzGbrZPXzwKHSQBB95sqol0D0Q46gQareb0wR2649sIX4sdDhHXW8JN/EnO0gNIzxKyRpkTpo2ATJVGYJXmKEenWCTAH1/Cu4vchjBnGAgAJ9e0sozP70S3ZHIzvgBMbiom0dOfOybk2gr7CU7pz61LXPuKdcn0mWSt/UUT14Z+YoEaudrVKo6QoLl4gHm3YLcHSVftCfGD40zM5jB/f4DKoxQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6988.namprd02.prod.outlook.com (2603:10b6:5:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 20:41:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 20:41:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ard Biesheuvel <ardb@kernel.org>, "terrelln@fb.com" <terrelln@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>
CC: "brgerst@gmail.com" <brgerst@gmail.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Compile problems w/gcc 9.4.0 in linux-next
Thread-Topic: Compile problems w/gcc 9.4.0 in linux-next
Thread-Index: AduZw3CVEeBLGArOR7mAlPxdXuU1qQACZlCAAALC4gA=
Date: Thu, 20 Mar 2025 20:41:39 +0000
Message-ID:
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
In-Reply-To:
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6988:EE_
x-ms-office365-filtering-correlation-id: 198ac539-73da-444a-ff04-08dd67ef9d97
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnpFX5gNBgVui9nZ6J+Gucr//2GDSsLTPhBaiIA3m4DQJYjart1+qt4n8N2wU/wyInzmwI1RAxt8IIvMa6bjePqgzk8ZTSAyFKHaYxRspH8ipHjBchhra+Djzqv+LaBUCsH9Ix1g1GSOHqEqmEOaIB4qRMHLH4jgq6AIEMJNGDkNNmyRCxhjCPSpKlKX2dOk4vx6/LhfU8hunAqwwqxEERzYM2fSDy7TVgmbcSrqoG9TDsgl7Ph8mygUFez1+ZLhMZbcNx2SIS318Q2GabmgosVA/Q8SVzkgFV/aMZPc0L/08eaOawRyrDwutk+041P6DYfoVviWzYzMne30JJOvho5UkMhQJ8b84mkBOGbfZr+UWUGDK7YhemAxii1wX6nJ+FpgQlqHfxzm5fmO/jca6NmHDhP7jp7oKW81HewuYJHooZgBR17qV6ym6phDOp1wEnOGvl9iCP9iTa3O7t+LKdAVUxhAVvkxjFF74XVsmNex1auoB/tOBrqYqhx7r1V6m0yHSTsJVeNHoGrw+xol/VDnI9kDCC3q6Vr4q5fx8t/fwE+Cz8KT2rqLCm1bKzJE05taDyzvgvGMzfakeB+5NoOFZ+EQ/PgVzAoPPLoJW7jZv8uTTHVEJMaoDJEjuCgEUS0Pqcnk8mGIImUWXfmDdTCy6YJSvhMj82+fphxIOA88M5cnMwJAZHU36iGr2n3d3TzaLHax5zj4LnuBiTfxa2fhzS5MOif1HCu3oxr1tHJ6wE6RZRGEC7UtVtVEdmI5Hng=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|19110799003|15080799006|3412199025|440099028|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?UldLeFJYMHFqWFVRcXJUaXk4djQ4Mi9nN2FZS2IwcDFrWGNTK3pHK0NXTGNY?=
 =?utf-8?B?a24zbHdSSXQvV05VL3Rxei9QWFB5ZGk2T2RhQ3lRZ2FNUWVYdVI4NUxEM0Mv?=
 =?utf-8?B?ZkNKNE1HaUtsRWZlMG8ySDJPNFFCUTYwRUFrVE9CTVRnc01keE4xSTA3VVVK?=
 =?utf-8?B?WEFvRVk5N29ZaUU1Mko0Y0FxbEFEK0FnL2d3dEI2R2FCRWlDdkVlV0ozbnZR?=
 =?utf-8?B?cCt1U3Vra0xqWlFuREt5WFE5TjVGUjJrMkdqZUo2a0x3SFAwWWR3ZVo2WEhG?=
 =?utf-8?B?OTl3emVlZTU0aysrNVpqcUZPRWcrWTdITERONnZpQVA2OG96RVJNTkx1VTZy?=
 =?utf-8?B?bDBwdWg4UC9tcGRITEEvUUZ2aWltanFiV1liNUR2cjdia3hRUUJXcEs4b1du?=
 =?utf-8?B?N01jcEJPbTZBZ0pKdlNGa1crMmZOc05POUdQRE0yQTVlSUhUMHBubmhEdlN2?=
 =?utf-8?B?RENUMCtXekNnYWZBOHhkdWJWZm1aVHkvN3FHdHUyT2NueGgyWjcydit6SHJw?=
 =?utf-8?B?dm8vdHd3dG1USEFFQ1A5dnlyR3I3Tm1ZSy85ZEZCOUM1REd4bWNKSk1MeTNK?=
 =?utf-8?B?V0hxYzZIUmc1bndhYUNvb3ZFeGUrTW1IUjRJRjJPd0Q0VVF5NVpjY0k3bHZ1?=
 =?utf-8?B?S29VeC9VSkVTSmZibEFqeCtSYXRFU3c2dkJJUGtvN3o4czJlR2dVSUdJSUxM?=
 =?utf-8?B?MEtpeC9NdWlBRzQrZ2pnSmMyZzByTm95Z1Z6d0dnUFdiMFJWY0d3c1E3R21B?=
 =?utf-8?B?RFgrb2x1Y3FTVnorRlk0ekhDcFNHaGpaMko4YUxUUUIrUzUyS1NwTzdqemUw?=
 =?utf-8?B?b004aEU4bUR3YVd3dGdNWDZyVllYSE5CNkMrUDVOZlJkWkhhTVo1MzF6Tldk?=
 =?utf-8?B?REFtL0VnTXI3N0N0VlR4cTVvMGdqTUV3bEo4NytLL3pIVC8zUGtrdDVrc0Zv?=
 =?utf-8?B?MGdnWFU1b3ZBa3R6Q0R6bkRweDBLU0pXSTZrRVk1WUdVdGhna1FSTWl2TDJZ?=
 =?utf-8?B?SlBmOVZGS2VXQ3VpdXM5RHI3NGJsL0xWSERDdXV4V1E3V1FtVDlZa0J3eWt0?=
 =?utf-8?B?QS9sNk9YbXprT3BuZVNLbXBDbjl3TnhOQXRJcHkxeTZOZ0E2ei84TzVmTlg2?=
 =?utf-8?B?eXBiMm9mS1Yyd3VPeEYxR3NPQ2EzaDZCTUR6NW13RHAwWVpOWVh6OVJSMzRa?=
 =?utf-8?B?R1J1SG5INnFyanVXbkliblBNNHljT1l0U2Zxd3RHc0cwN0lZYkxyODFiZUJ2?=
 =?utf-8?B?Qmo4bTlRbDlNb2lNdGJMblhheGhPUWdWdUF4alNHbmhXZXJNeTNvVW9XRDBO?=
 =?utf-8?B?dGpscDA5ODJ2OVVVZVJsc0ZqVm5vZWlQeXg3ZnRlMWw3OE10ZGl3OTV1Tlcw?=
 =?utf-8?B?c1pBajVUVW43QW0wU3k0MjhqbUVxOFVEdU5UUG01WjVxU0ZEc2hWTDlmd3B6?=
 =?utf-8?B?OHJQRFByV254dU1kK0tNdVpkcEt0bVoxVDh1N2JMNWNUSEFhZXlDaTZKb09q?=
 =?utf-8?Q?80k8zKEh9ffRC6MKC/TXDKGcDeR?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0VnTVpiZHpXY21vdW5MYXNSSXJjSm02aEprWThLRGpaU21NcXYzaWkvcFpM?=
 =?utf-8?B?R2EwMWJKUnU5T1FjWHhjSVB5NFBMTGlsVTFBWTByMTFNN002TllsR2xUcVll?=
 =?utf-8?B?dmFaZGY5RGtic01qT0h6bWFwOGd4aDFnWjR2QW01a0NtQnhQZW5SV28yVmw4?=
 =?utf-8?B?R0dPd3haYlB3N000ZHNrck4zYytKWjIzRjVtMjhYTExOZWlwQzd5ZzBBR3ZI?=
 =?utf-8?B?NTlDaHR2eEU1WHdnL2FGR2dxdWRvOFNGaUJjSUk1ck0vZzZOZTJ2TGhPQVNI?=
 =?utf-8?B?MnhXancrOCt5K3IxeFVnRmZ4SGlCNjJqU09uaVh4Y0kxNGt2TzN2V3VBV3Ez?=
 =?utf-8?B?SWdQcGlSUXk5enRCUFh5UmVKcVo3WmVzUS83WWVlck50cUd0dnBhTmIwQ1Zi?=
 =?utf-8?B?UERBNjMrbUZuT3k5UWhkUFd6MFVzT2xBT3Ivd3BkQWp0MzRQNW15ZVdVWTRm?=
 =?utf-8?B?bDhIQ2xGd1owczJPeW1aSVJhNi9TaEQ5b28vSUZWc1pTRFYwbTArN2NLdFU1?=
 =?utf-8?B?Um92VlllaTQ5aXVXaWdWTENzMkx4cC83Y0xQZ3Iwand1KzJHOTNieUxITnov?=
 =?utf-8?B?b25RUnNIMnVpbXY1ek5rMUpUWDRWMGJtZnk4UlhDbFZTRlhWbGZrSzlhbU82?=
 =?utf-8?B?S1ZDOEhNbUpLS0xlNlF0YjRuUzBBU1dxMERvRC9ickVQVjZRNDFqQUhJYkYx?=
 =?utf-8?B?eElYQnBnL1lxazNDbndyVFJ6Z3JMV09nZHZSMnVyS3g0TXFsVmRRYWJKYllh?=
 =?utf-8?B?VnR2MWlNL0tTYzNrdkZEcWp5dENBOVdLbjc5TGxpVVJtdmRabkpDc0VWdTk2?=
 =?utf-8?B?L1lkZFlpVGFNWmFQZlcxeUpaWXFnclFjcUJMbEViQ0xFZ1VIWERYNnBXU2xG?=
 =?utf-8?B?Wm9BajN2QU9rL3h1VUtYdEszdkRQTkxoRU5ORW9PakM5WXhyd1BiQ1pmM0hO?=
 =?utf-8?B?Z1JCYjh2S3AxWlNRMTU0ZjcxaW02WHV2aHNSZktnZWZ4dnFBQVl3TEVkMEJR?=
 =?utf-8?B?Y3VwTjFsS1pxaW9HcklNM0JxcW9hdzRpUVdYWnlVbXNndjVETVBLa1ZPYUFQ?=
 =?utf-8?B?S01ieXRyTzVRUHM2WHZCczQzVHc2ckl3REpicVVNbHZXdHFyMnQ1aUllaFZZ?=
 =?utf-8?B?L1htWElyYXZwMktLZ1daaGVySkc3N3I3N0tSYTY5OEF4QkdKZHJKdFZ0eTlw?=
 =?utf-8?B?aitUaElrVHhGMDdrQzRZRkUrY1E0SHFUTUhrd0l5bkdUYm5qU21JRGwxVkdL?=
 =?utf-8?B?Vi9kSlVQSmF3ZG1aZllQNkVWcnlTMWNxTUdtNWJpcjMySVRTczJhR09pWHds?=
 =?utf-8?B?cW5WbzBaK09SM0VPdWFXNGNNdlFYWDRRUEdMcXZFUW1GZWk5WVVISlM4MEI2?=
 =?utf-8?B?cXJPQVg5OXYrQTdzbWlGclNkR1NwbXIwWEp3Tk5vMWtaQnh2MFBJK0FVempY?=
 =?utf-8?B?eHFlK3JnR0JyeTVZTE9NS1dvUkkzWFNybmJYNytkQWFxVG40a3BkbUM1Nysr?=
 =?utf-8?B?em94ZzEwRElHZHh1VmtMSVNoZ0tQdlhiVFF5c0NYdWJZcldkSTBaUG82c29H?=
 =?utf-8?B?RDlqYmtsTUtGVDBqYXF3NThsOVZnUmJNdEFxQXZ4Rzhya1RyODhZK0tHeFMv?=
 =?utf-8?Q?WE8GBy4O2LP8qe7f/3vKhqgS/oIFUQMcNJBZedN/ij34=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 198ac539-73da-444a-ff04-08dd67ef9d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 20:41:39.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6988

RnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDIwLCAyMDI1IDEyOjIwIFBNDQo+IA0KPiBIaSBNaWNoYWVsLA0KPiANCj4gT24gVGh1LCAy
MCBNYXIgMjAyNSBhdCAxOToyOSwgTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29t
PiB3cm90ZToNCj4gPg0KPiA+IEJyaWFuL0luZ28vQXJkIC0NCj4gPg0KPiA+IEknbSBzZWVpbmcg
YSBjb21waWxlIHByb2JsZW0gaW4gbGludXgtbmV4dC0yMDI1MDMxOSB3aXRoIGdjYyA5LjQuMC4g
SSd2ZSBiaXNlY3RlZA0KPiA+IHRvIGEgZ3JvdXAgb2YgNiBjb21taXRzIHRoYXQgeW91IGF1dGhv
cmVkOg0KPiA+DQo+ID4gYTlhNzZiMzhhYWY1IHg4Ni9ib290OiBEaXNhYmxlIHN0YWNrIHByb3Rl
Y3RvciBmb3IgZWFybHkgYm9vdCBjb2RlDQo+ID4gZjU4YjYzODU3YWUzIHg4Ni9wdmg6IFVzZSBm
aXhlZF9wZXJjcHVfZGF0YSBmb3IgZWFybHkgYm9vdCBHU0JBU0UNCj4gPiBjYjc5MjdmZGEwMDIg
eDg2L3JlbG9jczogSGFuZGxlIFJfWDg2XzY0X1JFWF9HT1RQQ1JFTFggcmVsb2NhdGlvbnMNCj4g
PiA3OGM0Mzc0ZWY4YjggeDg2L21vZHVsZTogRGVhbCB3aXRoIEdPVCBiYXNlZCBzdGFjayBjb29r
aWUgbG9hZCBvbiBDbGFuZyA8IDE3DQo+ID4gODBkNDdkZWZkZGMwIHg4Ni9zdGFja3Byb3RlY3Rv
ci82NDogQ29udmVydCB0byBub3JtYWwgcGVyLUNQVSB2YXJpYWJsZQ0KPiA+IDlkN2RlMmFhOGI0
MSB4ODYvcGVyY3B1LzY0OiBVc2UgcmVsYXRpdmUgcGVyY3B1IG9mZnNldHMNCj4gPg0KPiA+IEFz
IG9mIGE5YTc2YjM4YWFmNSwgZXZlcnl0aGluZyBjb21waWxlcyBjb3JyZWN0bHkuDQo+ID4NCj4g
PiBGb3IgZjU4YjYzODU3YWUzIHRocnUgODBkNDdkZWZkZGMwLCB0aGlzIGVycm9yIG9jY3VyczoN
Cj4gPg0KPiA+ICAgICBhcmNoL3g4Ni9wbGF0Zm9ybS9wdmgvaGVhZC5TOiBBc3NlbWJsZXIgbWVz
c2FnZXM6DQo+ID4gICAgIGFyY2gveDg2L3BsYXRmb3JtL3B2aC9oZWFkLlM6MTgzOiBFcnJvcjog
b3BlcmFuZCBzaXplIG1pc21hdGNoIGZvciBgbW92cScNCj4gPg0KPiANCj4gVGhpcyBpcyBzaW1w
bHkgYSBidWcgaW4gcGF0Y2ggZjU4YjYzODU3YWUzLCB3aGljaCB1c2VzIG1vdnEgb24NCj4gRURY
L0VBWC4gVGhpcyBicmVha3MgYmlzZWN0aW9uIChhcyB5b3UndmUgbm90aWNlZCksIGFubm95aW5n
bHksIGFuZA0KPiBJJ2xsIGxlYXZlIGl0IHRvIHRoZSB0aXAgbWFpbnRhaW5lcnMgdG8gZGVjaWRl
IHdoZXRoZXIgdGhpcyB3YXJyYW50cyBhDQo+IHJlYmFzZSAoZ2l2ZW4gdGhhdCB0aGUgZml4IGlz
IGFscmVhZHkgcXVldWVkIHVwIGFzIHdlbGwpDQo+IA0KPiA+IEFzIG9mIDlkN2RlMmFhOGI0MSBh
bmQgbGF0ZXIsIHRoZSBoZWFkLlMgZXJyb3IgZ29lcyBhd2F5LCBhbmQgdGhpcw0KPiA+IGVycm9y
IG9jY3VyczoNCj4gPg0KPiA+ICAgICBsaWIvenN0ZC9jb21wcmVzcy9odWZfY29tcHJlc3MuYzox
MDMzOjE6IGludGVybmFsIGNvbXBpbGVyIGVycm9yOiBTZWdtZW50YXRpb24gZmF1bHQNCj4gPiAg
ICAgIDEwMzMgfCB7DQo+ID4gICAgICAgICAgIHwgXg0KPiA+ICAgICBQbGVhc2Ugc3VibWl0IGEg
ZnVsbCBidWcgcmVwb3J0LA0KPiA+ICAgICB3aXRoIHByZXByb2Nlc3NlZCBzb3VyY2UgaWYgYXBw
cm9wcmlhdGUuDQo+ID4gICAgIFNlZSA8ZmlsZTovLy91c3Ivc2hhcmUvZG9jL2djYy05L1JFQURN
RS5CdWdzPiBmb3IgaW5zdHJ1Y3Rpb25zLg0KPiA+DQo+ID4gSW50ZXJlc3RpbmdseSwgaWYgRFlO
QU1JQ19CTUkyIGluIGxpYi96c3RkL2NvbW1vbi9wb3J0YWJpbGl0eV9tYWNyb3MuaA0KPiA+IGlz
IGNoYW5nZWQgb24gbGluZSA2MSB0byBhbHdheXMgYmUgZGVmaW5lZCBhcyAwLCB0aGUgY29tcGls
ZSBwcm9ibGVtIGluDQo+ID4gaHVmX2NvbXByZXNzLmMgZ29lcyBhd2F5Lg0KPiA+DQo+IA0KPiBX
aXRob3V0IGhhdmluZyBsb29rZWQgYXQgdGhlIGNyYXNoaW5nIGNvZGUsIEkgc3VzcGVjdCB0aGF0
IHRoZSBvbmx5DQo+IG1lYW5pbmdmdWwgY291cnNlIG9mIGFjdGlvbiBoZXJlIGlzIHRvIHR3ZWFr
IHRoZSBjb25kaXRpb25hbCBsb2dpYw0KPiB0aGF0IGRlZmluZXMgRFlOQU1JQ19CTUkyIHRvIG9u
bHkgZW5hYmxlIGl0IGZvciBHQ0MgPj0gMTAuMSAoYXNzdW1pbmcNCj4gdGhvc2UgYXJlIHVuYWZm
ZWN0ZWQpIEluIGFueSBjYXNlLCBHQ0MgOS40IGlzIG5vdCBnb2luZyB0byBnZXQgZml4ZWQNCj4g
aW4gdGhlIGZpZWxkLCBzbyBldmVuIGlmIHRoaXMgZ2V0cyBmaXhlZCBvbiB0aGUgR0NDIHNpZGUs
IHdlIHdpbGwgaGF2ZQ0KPiB0byBkZWFsIHdpdGggaXQgaGVyZS4NCg0KTmljayBhbmQgRGF2aWQg
LS0NCg0KV2hhdCBhcmUgeW91ciB0aG91Z2h0cyBhcyBtYWludGFpbmVycyBvZiBsaWIvenN0ZD8N
Cg0KTWljaGFlbA0KDQo+IA0KPiA+IEknbSB1c2luZyBnY2MgOS40LjAgaW4gYW4gVWJ1bnR1IDIw
LjA0IGluc3RhbGwgYXMgaXQncyB0aGUgc3RhbmRhcmQgY29tcGlsZXINCj4gPiBmb3IgdGhhdCB2
ZXJzaW9uIG9mIFVidW50dS4gSSdtIGd1ZXNzaW5nIHRoYXQgZ2V0dGluZyBhIGZpeCBmb3IgdGhh
dA0KPiA+IHJlbGF0aXZlbHkgb2xkIHZlcnNpb24gb2YgZ2NjIGlzbid0IGxpa2VseS4gSSBoYXZl
IG5vdCB0ZXN0ZWQgd2l0aCBvdGhlcg0KPiA+IGdjYyB2ZXJzaW9ucy4NCg==

