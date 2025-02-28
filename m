Return-Path: <linux-kernel+bounces-538658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D079A49B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA89B3AA609
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E7E26FDB1;
	Fri, 28 Feb 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="q9E5fsJa"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011038.outbound.protection.outlook.com [52.103.68.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7B26FD84;
	Fri, 28 Feb 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751798; cv=fail; b=A57HJsR6SW2LxeuLV6lp9D5B+T9tFMQdtVafVeWxYcCbGLuthqab1aWznqZzDLj1qixYp4dgfsPcGdp7/cy0PlZlN6GTdPQDqSGUMu7ioyIJCBq25dGCbo1w3rJ0Yu3rmQiPHaUlTW149EWWcdOff9GOJbjBx/CT9iHs6OnKzWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751798; c=relaxed/simple;
	bh=JoRlsIAbe1MCJGJ+TciORF2ZjS6P1jVhQjZ58CFRfNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jeu7TpCNdojcSqrLzQryytZqdnHtdCL+oRuA8HTWgYKaoaCQM2UocOvVsu6LiG57dIUqkS+EhCXmrib2HU060yA3kwJ/hewueJq/tCtp0NhFhv91sN1sh7Mh+AOKjqL9huH9i1/Nzfk8UU9ttFGBCDlPhxkEFm59HiYSds9Fxso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=q9E5fsJa; arc=fail smtp.client-ip=52.103.68.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTEfApB91mijxxvrZnRdYzpSandvcr2ViaCa5BZ5Wt6GH9rC03TOTwDI8NRCDzb4ck3TF7lHBc3WOtBS9qMO9D8KWhlIgnjmZuByfWlHOnYgIN5jo+73cRQLcOdm+gbE39k+5yDvCmMN6y9TZ2Ok7dN3mPGvOuXwn8TljGLDK4JRQpz2iwWwgD4C8BQTYuhFXzWePp/4FFPtNWCE/LfVzdXbtHRJvBuqd2aeQz8mKm7qLMj4wB9DnEdAiV+jEl1eBWBTry/OjVCrOcVnl28jSrBBEYMhQ5MGXs+NnozJX5yfE5aSrBfoqd2cebNIH8nZdW/Iu/yy7R0T+1T1Po+kOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoRlsIAbe1MCJGJ+TciORF2ZjS6P1jVhQjZ58CFRfNE=;
 b=M1hCQVSEFjWciDeCDAvqey+96Ur+C7G3f3ztsh8OUFMicdXpmg3gZrnMrqxI1Tpsfzdva7qTeGoxsZPhqswOkaITGuCeFBnBNYTUwlfXJH/HqGD8J2PwX+YDeXF/aPY9Ycf7rblUms6fMf8dZOKD+ysq+oIphA636hsw8j77I1aWOM9hQnyb4wVxpuSvI4O0v34rIpoof7gUO/OEgJV2cnU3L5n+Y6aGPXDc6u9ky1A3qVxt8hW+C9avkDB59XmcgUO+9boRBSUrgqlQZNkujrwgIVbCF0PfAqrUvl+CwhH/bwucgeob8ld4iHUr0em6RhiESpT02GAOF1PYZ69/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoRlsIAbe1MCJGJ+TciORF2ZjS6P1jVhQjZ58CFRfNE=;
 b=q9E5fsJaEhtD53EgWtFV98i7rk1BubnW/WAOPiSwejyJuZkx3bh76rBq/5+vwTwjcA59cJYh0HDdbSS21VnYfA1DH2iU3S+BISGmXuArq5pMsngTnkdLk/nHAt5zzJe0a8w96K/eT3+LX2AxGbAH/j6Jpw/hmi6aef0CKLPbLua2He2Mwsi4y3NKISzfmtnNxTv56rat9c+RiiOAziN3hcMBFYTK6XU5ZcAQhGXbjNS6IvzT7fZUpnthvWkgVVQxvVltYNBnqxIr7t6bUswKxPSBMFFnSFU7Yv8JoPoWt/U0Iq91IMb/15r1ulzgmqtehURdYO9RRz9C70ms80I2Lw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9109.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:115::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 14:09:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 14:09:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "pmladek@suse.com" <pmladek@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "apw@canonical.com"
	<apw@canonical.com>, "joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, "sven@svenpeter.dev" <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: Re: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Topic: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Index: AQHbiOEjzUrALYS3lkmTQCvm8eL6dLNcwxe8
Date: Fri, 28 Feb 2025 14:09:48 +0000
Message-ID:
 <PN3PR01MB95972518DA57C43F01769B83B8CC2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
In-Reply-To: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB9109:EE_
x-ms-office365-filtering-correlation-id: d0ac6170-b87a-4f13-2260-08dd58018fd4
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|8062599003|7092599003|6072599003|15080799006|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDlORE9yTXI4bzBjS08zQjZaTGdvVG1OcnorTFozUGRSTDNoYjQ1YWtEaXNn?=
 =?utf-8?B?aUU4KzFrZ2dJK29uc1FpNmhQMFllYy9QL05HazgvUUVML2UrTW9JMWk3M05C?=
 =?utf-8?B?VUdhN1IyNGxKTERFTmNiQzVGS1hCNDdzaWQ0N0NEZ0JrQzBCZFpHeDJUUkl6?=
 =?utf-8?B?Wm1XN2NMNHNGOXhaT3VJMW92b1JnOEE0SkRKalpZN1diVHVmejR5WElVMjY2?=
 =?utf-8?B?am1ET2ZoTjlpMWlCR0VkZnJyNFhzSXRpaGlqRTdEZEhScWt3SDBpKzNCTE9V?=
 =?utf-8?B?Z2t3RzcwR3FhSTdGTFRIeGl5bFFIME1BdU54VnJFUFNYVGl2SXh0WEF5bUZh?=
 =?utf-8?B?cXJNdzV3eGNSYVd1bVNxSFRBeU1yNjN2TjIvM0M2ODFBblhvYWJ6K09KRERm?=
 =?utf-8?B?R3A3WGtKMGJocDRXTG9CdGJPcGZ0UHAwOWdlU1ZhamNObmpZd2VrRVlUV2NE?=
 =?utf-8?B?RmR1bXQySUlYaTdvUjBWQy8rZm5sT0t2T2czTFUvNFVnNXc0MjhiK0cwc1dS?=
 =?utf-8?B?WW1tcFd2S2FGMEFIby9yNGYva0xrS0NZTFkyOUVyL3VkWitlUXBFZDFVOWFu?=
 =?utf-8?B?L2c0S1dQRGI1dDR2aVdKSnZWaE9XUUtpYWxOME1ReW56WWg4TFJLaVl4QytE?=
 =?utf-8?B?OUdWV0tINWY2ajJ2QUtwRlJ5Q290c09DbE4xQmJnanhGYUpkZjNURG96a2tF?=
 =?utf-8?B?UjdtWGVRVlFraTVCNnVJbjgra0VYYUpTR0VUS3JxWnMxQmxrT2JnZnZ4bFhF?=
 =?utf-8?B?eTFGaVZ6YnUyVVJod1llTzBNLzBlbVNKUHlsT1IxUjlzRURuRTJ2WmVDdzVT?=
 =?utf-8?B?RlczT2lnQVZYQUtMcW9LaVZuQVFMUFc4Z0ZXaEdkUFE4ODNTczY0VEE1YkVD?=
 =?utf-8?B?d2ZibVoyaVJsZmY1REdYOW5zNUNOL0lFaWw1QUUrRVpRVXFxTDJUZENheFNM?=
 =?utf-8?B?ZDM5ZFNSbXgrYi95MFlGcXAwYWl1VkRmaVU2ZWV6N0ZuT2N3NUlLT1VUd2s5?=
 =?utf-8?B?YkJCbTY3VnNETzlhY1NqdHV3WEdRTUFrMmJoOHJKZGJ4V3hkZUFjcGoyS2s3?=
 =?utf-8?B?UG5DRGplanB5b3J0cXZIZXFvR2dvVmJOaU1nRzJiMHZ0dTlKamF1YmN3czBO?=
 =?utf-8?B?aWgrVDdBVEcwdlZhRFpYd2wydmlnRGI0Vi95WS9WY1ppYVJZeXEyY0E4OEJN?=
 =?utf-8?B?eUUvRDBFN2RlRGN4V2ZXaGlPdmhPbjA0cS9BQ1NoQnZVcW1XZEx2ZnA5TVE4?=
 =?utf-8?B?WGRWdU5iYjNrb1hmbHZQWWl6UWpmMVZ5TlJVQnoxZmN4bEZtTUsycVNjZDIz?=
 =?utf-8?B?NmhkWUtNaWYyN2wxdDdKdWg3elF5OEpScSt1R1M4QmhNREk1ckdTcUNBOXVW?=
 =?utf-8?B?Y2V5djl2K1VTeWd4TDJvaFkwM2JkV2RISHNNUkM3ejZXNDJiZnh5eWptNWt4?=
 =?utf-8?B?UDFZSDZwOUQ2cCsrVmphd1hFRElwbHpSbEV5ekg0emlvd0V4VFl4TWtoUXFp?=
 =?utf-8?B?NEFSa1JzRFVzY2pRclM1Z1VpeEFSa2loWFBtSjZVQzFkZ2pCRFc1aC9IT1Rj?=
 =?utf-8?B?QVJwZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aE1sS2FEdjV6OUsvQVppdWhCRlpRVE1TV0wzcVhtd1BtMUl1OTNuVVA3Z254?=
 =?utf-8?B?YXVIaWlhYllMMERWUkNoNmp5bVlUTnZUcUZVWXU2QVJibVpPWGE2dkMrR1Nq?=
 =?utf-8?B?QUZDektsYkpTQ29qejBKY3M2NmRWQXVFUlluU2M5QTdhVGhTMDNyMHlFbDYz?=
 =?utf-8?B?SkhVV0p1U001cHQxU2hHVTd4NXBla3NhWXViUFhHZjF3K2dPK25NeTcvSUQ5?=
 =?utf-8?B?VmxBR0FSMmVpcWEvZ3AySGlQaDVpTTdBbmZoSW5SbGg0UisxZWhCMmY0ZzB4?=
 =?utf-8?B?UE90QUhDOEJiWFgrSVRnRFM1UVZFZnJkM0VrMUt3YllYU2tYNnd2RDFXc3hH?=
 =?utf-8?B?SUZVOTUwZko2RlBlRU8yaldjejFER0w2cnNLVUZJaU8xcWJFMTNJWDU1T1I4?=
 =?utf-8?B?MGRKZ2NQUUIyTEU3cEZkWWtqa2xMU1FYRG9BVDN3Ky92eHpCTEc0dktlTEdC?=
 =?utf-8?B?a0VybHVpQjJLb0ZQa3lDNlVoSWRGcVVIdk5DZDlNekFVWlhTbzFseGRINWpi?=
 =?utf-8?B?OTZ1TUQrWXF5N3g0QjhTRTRaK2Fiak0zRHczdWdrdDRweVZzcU9XZXhwWXZy?=
 =?utf-8?B?QkdRTkxSUzhZM1Q4aXVESlcwQVhqOW1rczdkVlp0V0krcWtKbW5EZUdmOXYw?=
 =?utf-8?B?dlhITmlXUnlYWE1yakNHNUNvT0JkZjNpZW80aWJMcTNLTTYwOU5ET3AycFVJ?=
 =?utf-8?B?NUs5OEFrdEtyR2R6cDhPQkdmUDFjRDlGSHRZOHhrNXk0NlU2VUtRbEREaDJD?=
 =?utf-8?B?T3F5VHk5eis3bFRYa0VvOWJZdmdqckVsTmpJS0ViMkVTMGU4R2xWMWVnenFC?=
 =?utf-8?B?T3Qrdnh3dlFaWkw3MStEWTBZUi9HWVREOVpGenZIbFRyN0YvallDM3hyTnU1?=
 =?utf-8?B?VDd6NkJsUFJQVmIwTlkxQkVweTgrMkJHbXZLM2lyMWRqV3FZRHp0eDdnUGl1?=
 =?utf-8?B?d3BPcTBPSXYxTG5yVTFENG1kcUhaaWF6Y29nbWNvUmdjcW1YcnRPSG9mbWtF?=
 =?utf-8?B?bUdjdWJUYUQzNCtUdmkxb3NKVlRMU0c3L2wvc0tneUt3TGdOMU5VVGhGLzJ6?=
 =?utf-8?B?U0xob3plTjNveFBKc3ByL3ZNNkJrNzIxZjhrV1RYaWZ6ZGdKZ0gwNW5sWlh5?=
 =?utf-8?B?U2xKOHhPZmlabWlpM3Vabm5zWk9sOGVvcEVrQk5STEVDU3RpWE03VW13bXR0?=
 =?utf-8?B?NVQ3bGxBT3IwSXBPS21EUUlBTk1kTlZiUXFYK2RXdyt1YlpBSlk5RE52R3Jj?=
 =?utf-8?B?VHdRMWp0dHdlakVMREd6TkQvTlRmcGNNTmo2ZU51dXA0L0RrSmVlQStPT1ZH?=
 =?utf-8?B?SGVQOE9NUUU1WWpZM1dVNk1LY09ickY1UlpSdFlsb1F0a1dQTTlDVDNnWkNV?=
 =?utf-8?B?TFN0RXdqR202YVV4SVpIYi9iZUUvb0VtNmQ3aURiNkl4VFdPT0RIOEpSM1po?=
 =?utf-8?B?NElRTW5icnVGT2orbzlTTGNia0VwVzgrWUhGWHNtc0M5YlJJaTlvMmlhY2RK?=
 =?utf-8?B?Si9GNXZQZW1Ia3lOcTZmWWZSNXlGUUc3L0tHSDY2blZObkNHRVdwdDVraExI?=
 =?utf-8?B?STVRSGJqU1FFcHFOb291cjkycVgxY0I3cTBuNGVaN09pN0p0YVh5aDdPOEJZ?=
 =?utf-8?Q?DZR9AJDow66HYhMM67JRaLkjmx66boypyc0TpdJmuheI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ac6170-b87a-4f13-2260-08dd58018fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 14:09:48.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9109

DQoNCj4gT24gMjcgRmViIDIwMjUsIGF0IDEyOjAw4oCvUE0sIEFkaXR5YSBHYXJnIDxnYXJnYWRp
dHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPiANCj4g77u/RnJvbTogSGVjdG9yIE1hcnRpbiA8bWFy
Y2FuQG1hcmNhbi5zdD4NCj4gDQo+ICVwNGNjIGlzIGRlc2lnbmVkIGZvciBEUk0vVjRMMiBGT1VS
Q0NzIHdpdGggdGhlaXIgc3BlY2lmaWMgcXVpcmtzLCBidXQNCj4gaXQncyB1c2VmdWwgdG8gYmUg
YWJsZSB0byBwcmludCBnZW5lcmljIDQtY2hhcmFjdGVyIGNvZGVzIGZvcm1hdHRlZCBhcw0KPiBh
biBpbnRlZ2VyLiBFeHRlbmQgaXQgdG8gYWRkIGZvcm1hdCBzcGVjaWZpZXJzIGZvciBwcmludGlu
ZyBnZW5lcmljDQo+IDMyLWJpdCBGT1VSQ0NzIHdpdGggdmFyaW91cyBlbmRpYW4gc2VtYW50aWNz
Og0KPiANCj4gJXA0Y2ggICBIb3N0LWVuZGlhbg0KPiAlcDRjbCAgICBMaXR0bGUtZW5kaWFuDQo+
ICVwNGNiICAgIEJpZy1lbmRpYW4NCj4gJXA0Y3IgICAgUmV2ZXJzZS1lbmRpYW4NCj4gDQo+IFRo
ZSBlbmRpYW5uZXNzIGRldGVybWluZXMgaG93IGJ5dGVzIGFyZSBpbnRlcnByZXRlZCBhcyBhIHUz
MiwgYW5kIHRoZQ0KPiBGT1VSQ0MgaXMgdGhlbiBhbHdheXMgcHJpbnRlZCBNU0J5dGUtZmlyc3Qg
KHRoaXMgaXMgdGhlIG9wcG9zaXRlIG9mDQo+IFY0TC9EUk0gRk9VUkNDcykuIFRoaXMgY292ZXJz
IG1vc3QgcHJhY3RpY2FsIGNhc2VzLCBlLmcuICVwNGNyIHdvdWxkDQo+IGFsbG93IHByaW50aW5n
IExTQnl0ZS1maXJzdCBGT1VSQ0NzIHN0b3JlZCBpbiBob3N0IGVuZGlhbiBvcmRlcg0KPiAob3Ro
ZXIgdGhhbiB0aGUgaGV4IGZvcm0gYmVpbmcgaW4gY2hhcmFjdGVyIG9yZGVyLCBub3QgdGhlIGlu
dGVnZXINCj4gdmFsdWUpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVjdG9yIE1hcnRpbiA8bWFy
Y2FuQG1hcmNhbi5zdD4NCj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEw
OEBsaXZlLmNvbT4NCj4gLS0tDQo+IHYyIC0+DQo+IC0gQWRkIHRoaXMgcGF0Y2ggdG8gYXBwbGV0
YmRybSBwYXRjaHNldA0KPiANCj4gdjMgLT4NCj4gLSBNYWtlIGFycmF5IHN0YXRpYw0KPiANCj4g
djQgLT4NCj4gLSBGaXggY29kZSBlcnJvcg0KPiAtIEZpeCBzcGFyc2Ugd2FybmluZ3MNCj4gLSBN
YWtlIHRoaXMgcGF0Y2ggc2VwYXJhdGUgZnJvbSBkcm0NCj4gDQo+IERvY3VtZW50YXRpb24vY29y
ZS1hcGkvcHJpbnRrLWZvcm1hdHMucnN0IHwgMzIgKysrKysrKysrKysrKysrKysrKw0KPiBsaWIv
dGVzdF9wcmludGYuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDM5ICsrKysrKysrKysrKysr
KysrKystLS0tDQo+IGxpYi92c3ByaW50Zi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
MzggKysrKysrKysrKysrKysrKysrLS0tLQ0KPiBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgICAgICAg
ICAgICAgICAgICAgICB8ICAyICstDQo+IDQgZmlsZXMgY2hhbmdlZCwgOTcgaW5zZXJ0aW9ucygr
KSwgMTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9jb3Jl
LWFwaS9wcmludGstZm9ybWF0cy5yc3QgYi9Eb2N1bWVudGF0aW9uL2NvcmUtYXBpL3ByaW50ay1m
b3JtYXRzLnJzdA0KPiBpbmRleCBlY2NjYzA0NzMuLjk5ODI4NjFmYSAxMDA2NDQNCj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5yc3QNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5yc3QNCj4gQEAgLTY0OCw2ICs2NDgsMzgg
QEAgRXhhbXBsZXM6Og0KPiAgICAlcDRjYyAgICBZMTAgIGxpdHRsZS1lbmRpYW4gKDB4MjAzMDMx
NTkpDQo+ICAgICVwNGNjICAgIE5WMTIgYmlnLWVuZGlhbiAoMHhiMjMxNTY0ZSkNCj4gDQo+ICtH
ZW5lcmljIEZvdXJDQyBjb2RlDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gKzo6DQo+
ICsgICAgJXA0Y1tocmJsXSAgICBnUDAwICgweDY3NTAzMDMwKQ0KPiArDQo+ICtQcmludCBhIGdl
bmVyaWMgRm91ckNDIGNvZGUsIGFzIGJvdGggQVNDSUkgY2hhcmFjdGVycyBhbmQgaXRzIG51bWVy
aWNhbA0KPiArdmFsdWUgYXMgaGV4YWRlY2ltYWwuDQo+ICsNCj4gK1RoZSBhZGRpdGlvbmFsIGBg
aGBgLCBgYHJgYCwgYGBiYGAsIGFuZCBgYGxgYCBzcGVjaWZpZXJzIGFyZSB1c2VkIHRvIHNwZWNp
ZnkNCj4gK2hvc3QsIHJldmVyc2VkLCBiaWcgb3IgbGl0dGxlIGVuZGlhbiBvcmRlciBkYXRhIHJl
c3BlY3RpdmVseS4gSG9zdCBlbmRpYW4NCj4gK29yZGVyIG1lYW5zIHRoZSBkYXRhIGlzIGludGVy
cHJldGVkIGFzIGEgMzItYml0IGludGVnZXIgYW5kIHRoZSBtb3N0DQo+ICtzaWduaWZpY2FudCBi
eXRlIGlzIHByaW50ZWQgZmlyc3Q7IHRoYXQgaXMsIHRoZSBjaGFyYWN0ZXIgY29kZSBhcyBwcmlu
dGVkDQo+ICttYXRjaGVzIHRoZSBieXRlIG9yZGVyIHN0b3JlZCBpbiBtZW1vcnkgb24gYmlnLWVu
ZGlhbiBzeXN0ZW1zLCBhbmQgaXMgcmV2ZXJzZWQNCj4gK29uIGxpdHRsZS1lbmRpYW4gc3lzdGVt
cy4NCj4gKw0KPiArUGFzc2VkIGJ5IHJlZmVyZW5jZS4NCj4gKw0KPiArRXhhbXBsZXMgZm9yIGEg
bGl0dGxlLWVuZGlhbiBtYWNoaW5lLCBnaXZlbiAmKHUzMikweDY3NTAzMDMwOjoNCj4gKw0KPiAr
ICAgICVwNGNoICAgIGdQMDAgKDB4Njc1MDMwMzApDQo+ICsgICAgJXA0Y3IgICAgMDBQZyAoMHgz
MDMwNTA2NykNCj4gKyAgICAlcDRjYiAgICAwMFBnICgweDMwMzA1MDY3KQ0KPiArICAgICVwNGNs
ICAgIGdQMDAgKDB4Njc1MDMwMzApDQo+ICsNCj4gK0V4YW1wbGVzIGZvciBhIGJpZy1lbmRpYW4g
bWFjaGluZSwgZ2l2ZW4gJih1MzIpMHg2NzUwMzAzMDo6DQo+ICsNCj4gKyAgICAlcDRjaCAgICBn
UDAwICgweDY3NTAzMDMwKQ0KPiArICAgICVwNGNyICAgIDAwUGcgKDB4MzAzMDUwNjcpDQo+ICsg
ICAgJXA0Y2IgICAgZ1AwMCAoMHg2NzUwMzAzMCkNCj4gKyAgICAlcDRjbCAgICAwMFBnICgweDMw
MzA1MDY3KQ0KPiArDQo+IFJ1c3QNCj4gLS0tLQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi90ZXN0
X3ByaW50Zi5jIGIvbGliL3Rlc3RfcHJpbnRmLmMNCj4gaW5kZXggNTlkYmU0ZjlhLi4wNTY5Mjlj
MDYgMTAwNjQ0DQo+IC0tLSBhL2xpYi90ZXN0X3ByaW50Zi5jDQo+ICsrKyBiL2xpYi90ZXN0X3By
aW50Zi5jDQo+IEBAIC03NzYsMjEgKzc3Niw0NiBAQCBzdGF0aWMgdm9pZCBfX2luaXQgZndub2Rl
X3BvaW50ZXIodm9pZCkNCj4gICAgc29mdHdhcmVfbm9kZV91bnJlZ2lzdGVyX25vZGVfZ3JvdXAo
Z3JvdXApOw0KPiB9DQo+IA0KPiArc3RydWN0IGZvdXJjY19zdHJ1Y3Qgew0KPiArICAgIHUzMiBj
b2RlOw0KPiArICAgIGNvbnN0IGNoYXIgKnN0cjsNCj4gK307DQo+ICsNCj4gK3N0YXRpYyB2b2lk
IF9faW5pdCBmb3VyY2NfcG9pbnRlcl90ZXN0KGNvbnN0IHN0cnVjdCBmb3VyY2Nfc3RydWN0ICpm
Yywgc2l6ZV90IG4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmZtdCkN
Cj4gK3sNCj4gKyAgICBzaXplX3QgaTsNCj4gKw0KPiArICAgIGZvciAoaSA9IDA7IGkgPCBuOyBp
KyspDQo+ICsgICAgICAgIHRlc3QoZmNbaV0uc3RyLCBmbXQsICZmY1tpXS5jb2RlKTsNCj4gK30N
Cj4gKw0KPiBzdGF0aWMgdm9pZCBfX2luaXQgZm91cmNjX3BvaW50ZXIodm9pZCkNCj4gew0KPiAt
ICAgIHN0cnVjdCB7DQo+IC0gICAgICAgIHUzMiBjb2RlOw0KPiAtICAgICAgICBjaGFyICpzdHI7
DQo+IC0gICAgfSBjb25zdCB0cnlbXSA9IHsNCj4gKyAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGZv
dXJjY19zdHJ1Y3QgdHJ5X2NjW10gPSB7DQo+ICAgICAgICB7IDB4MzIzMTU2NGUsICJOVjEyIGxp
dHRsZS1lbmRpYW4gKDB4MzIzMTU2NGUpIiwgfSwNCj4gICAgICAgIHsgMHhiMjMxNTY0ZSwgIk5W
MTIgYmlnLWVuZGlhbiAoMHhiMjMxNTY0ZSkiLCB9LA0KPiAgICAgICAgeyAweDEwMTExMjEzLCAi
Li4uLiBsaXR0bGUtZW5kaWFuICgweDEwMTExMjEzKSIsIH0sDQo+ICAgICAgICB7IDB4MjAzMDMx
NTksICJZMTAgIGxpdHRsZS1lbmRpYW4gKDB4MjAzMDMxNTkpIiwgfSwNCj4gICAgfTsNCj4gLSAg
ICB1bnNpZ25lZCBpbnQgaTsNCj4gKyAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGZvdXJjY19zdHJ1
Y3QgdHJ5X2NoID0gew0KPiArICAgICAgICAweDQxNDI0MzQ0LCAiQUJDRCAoMHg0MTQyNDM0NCki
LA0KPiArICAgIH07DQo+ICsgICAgc3RhdGljIGNvbnN0IHN0cnVjdCBmb3VyY2Nfc3RydWN0IHRy
eV9jciA9IHsNCj4gKyAgICAgICAgMHg0MTQyNDM0NCwgIkRDQkEgKDB4NDQ0MzQyNDEpIiwNCj4g
KyAgICB9Ow0KPiArICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZm91cmNjX3N0cnVjdCB0cnlfY2wg
PSB7DQo+ICsgICAgICAgIGxlMzJfdG9fY3B1KDB4NDE0MjQzNDQpLCAiQUJDRCAoMHg0MTQyNDM0
NCkiLA0KPiArICAgIH07DQo+ICsgICAgc3RhdGljIGNvbnN0IHN0cnVjdCBmb3VyY2Nfc3RydWN0
IHRyeV9jYiA9IHsNCj4gKyAgICAgICAgYmUzMl90b19jcHUoMHg0MTQyNDM0NCksICJBQkNEICgw
eDQxNDI0MzQ0KSIsDQo+ICsgICAgfTsNCj4gDQo+IC0gICAgZm9yIChpID0gMDsgaSA8IEFSUkFZ
X1NJWkUodHJ5KTsgaSsrKQ0KPiAtICAgICAgICB0ZXN0KHRyeVtpXS5zdHIsICIlcDRjYyIsICZ0
cnlbaV0uY29kZSk7DQo+ICsgICAgZm91cmNjX3BvaW50ZXJfdGVzdCh0cnlfY2MsIEFSUkFZX1NJ
WkUodHJ5X2NjKSwgIiVwNGNjIik7DQo+ICsgICAgZm91cmNjX3BvaW50ZXJfdGVzdCgmdHJ5X2No
LCAxLCAiJXA0Y2giKTsNCj4gKyAgICBmb3VyY2NfcG9pbnRlcl90ZXN0KCZ0cnlfY3IsIDEsICIl
cDRjciIpOw0KPiArICAgIGZvdXJjY19wb2ludGVyX3Rlc3QoJnRyeV9jbCwgMSwgIiVwNGNsIik7
DQo+ICsgICAgZm91cmNjX3BvaW50ZXJfdGVzdCgmdHJ5X2NiLCAxLCAiJXA0Y2IiKTsNCj4gfQ0K
PiANCj4gc3RhdGljIHZvaWQgX19pbml0DQo+IGRpZmYgLS1naXQgYS9saWIvdnNwcmludGYuYyBi
L2xpYi92c3ByaW50Zi5jDQo+IGluZGV4IDU2ZmU5NjMxOS4uMmFjOTBhYmEyIDEwMDY0NA0KPiAt
LS0gYS9saWIvdnNwcmludGYuYw0KPiArKysgYi9saWIvdnNwcmludGYuYw0KPiBAQCAtMTc4MSwy
NyArMTc4MSw1MyBAQCBjaGFyICpmb3VyY2Nfc3RyaW5nKGNoYXIgKmJ1ZiwgY2hhciAqZW5kLCBj
b25zdCB1MzIgKmZvdXJjYywNCj4gICAgY2hhciBvdXRwdXRbc2l6ZW9mKCIwMTIzIGxpdHRsZS1l
bmRpYW4gKDB4MDEyMzQ1NjcpIildOw0KPiAgICBjaGFyICpwID0gb3V0cHV0Ow0KPiAgICB1bnNp
Z25lZCBpbnQgaTsNCj4gKyAgICBib29sIHBpeGVsX2ZtdCA9IGZhbHNlOw0KPiAgICB1MzIgb3Jp
ZywgdmFsOw0KPiANCj4gLSAgICBpZiAoZm10WzFdICE9ICdjJyB8fCBmbXRbMl0gIT0gJ2MnKQ0K
PiArICAgIGlmIChmbXRbMV0gIT0gJ2MnKQ0KPiAgICAgICAgcmV0dXJuIGVycm9yX3N0cmluZyhi
dWYsIGVuZCwgIiglcDQ/KSIsIHNwZWMpOw0KPiANCj4gICAgaWYgKGNoZWNrX3BvaW50ZXIoJmJ1
ZiwgZW5kLCBmb3VyY2MsIHNwZWMpKQ0KPiAgICAgICAgcmV0dXJuIGJ1ZjsNCj4gDQo+ICAgIG9y
aWcgPSBnZXRfdW5hbGlnbmVkKGZvdXJjYyk7DQo+IC0gICAgdmFsID0gb3JpZyAmIH5CSVQoMzEp
Ow0KPiArICAgIHN3aXRjaCAoZm10WzJdKSB7DQo+ICsgICAgY2FzZSAnaCc6DQo+ICsgICAgICAg
IHZhbCA9IG9yaWc7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArICAgIGNhc2UgJ3InOg0KPiArICAg
ICAgICBvcmlnID0gc3dhYjMyKG9yaWcpOw0KPiArICAgICAgICB2YWwgPSBvcmlnOw0KPiArICAg
ICAgICBicmVhazsNCj4gKyAgICBjYXNlICdsJzoNCj4gKyAgICAgICAgb3JpZyA9IChfX2ZvcmNl
IHUzMiljcHVfdG9fbGUzMihvcmlnKTsNCj4gKyAgICAgICAgdmFsID0gb3JpZzsNCj4gKyAgICAg
ICAgYnJlYWs7DQo+ICsgICAgY2FzZSAnYic6DQo+ICsgICAgICAgIG9yaWcgPSAoX19mb3JjZSB1
MzIpY3B1X3RvX2JlMzIob3JpZyk7DQo+ICsgICAgICAgIHZhbCA9IG9yaWc7DQo+ICsgICAgICAg
IGJyZWFrOw0KPiArICAgIGNhc2UgJ2MnOg0KPiArICAgICAgICAvKiBQaXhlbCBmb3JtYXRzIGFy
ZSBwcmludGVkIExTQi1maXJzdCAqLw0KPiArICAgICAgICB2YWwgPSBzd2FiMzIob3JpZyAmIH5C
SVQoMzEpKTsNCj4gKyAgICAgICAgcGl4ZWxfZm10ID0gdHJ1ZTsNCj4gKyAgICAgICAgYnJlYWs7
DQo+ICsgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgcmV0dXJuIGVycm9yX3N0cmluZyhidWYsIGVu
ZCwgIiglcDQ/KSIsIHNwZWMpOw0KPiArICAgIH0NCj4gDQo+ICAgIGZvciAoaSA9IDA7IGkgPCBz
aXplb2YodTMyKTsgaSsrKSB7DQo+IC0gICAgICAgIHVuc2lnbmVkIGNoYXIgYyA9IHZhbCA+PiAo
aSAqIDgpOw0KPiArICAgICAgICB1bnNpZ25lZCBjaGFyIGMgPSB2YWwgPj4gKCgzIC0gaSkgKiA4
KTsNCj4gDQo+ICAgICAgICAvKiBQcmludCBub24tY29udHJvbCBBU0NJSSBjaGFyYWN0ZXJzIGFz
LWlzLCBkb3Qgb3RoZXJ3aXNlICovDQo+ICAgICAgICAqcCsrID0gaXNhc2NpaShjKSAmJiBpc3By
aW50KGMpID8gYyA6ICcuJzsNCj4gICAgfQ0KPiANCj4gLSAgICAqcCsrID0gJyAnOw0KPiAtICAg
IHN0cmNweShwLCBvcmlnICYgQklUKDMxKSA/ICJiaWctZW5kaWFuIiA6ICJsaXR0bGUtZW5kaWFu
Iik7DQo+IC0gICAgcCArPSBzdHJsZW4ocCk7DQo+ICsgICAgaWYgKHBpeGVsX2ZtdCkgew0KPiAr
ICAgICAgICAqcCsrID0gJyAnOw0KPiArICAgICAgICBzdHJjcHkocCwgb3JpZyAmIEJJVCgzMSkg
PyAiYmlnLWVuZGlhbiIgOiAibGl0dGxlLWVuZGlhbiIpOw0KDQpEbyB3ZSBuZWVkIHN0cnNjcHkg
aGVyZT8NCg==

