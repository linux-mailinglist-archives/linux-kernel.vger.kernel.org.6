Return-Path: <linux-kernel+bounces-302820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE0E9603CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D4828269D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D014518755F;
	Tue, 27 Aug 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="a/NA375e"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020097.outbound.protection.outlook.com [52.101.69.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942DB1F943;
	Tue, 27 Aug 2024 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745652; cv=fail; b=DaQKRW80qMmxdKV7FR+iuvKcfoCxOx/c1Yt8u1PSOG96Brr2w2gigQVisIChNKmtmZxeSewyxuhqP/yRZ7/dufj3ztpZ23Tur/aA7cHDcO7A/XsaVXLcJJB9aapJ4FSSSP9EiaZCKxA+NTy42/wbdiTi2qtOawRxK8q0nH6S/sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745652; c=relaxed/simple;
	bh=U4mMnvpU2KduBzJAg2OMFjL6qcPUKDF+9OAsuB7dbhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f/PmuA/rPPx0sgVTa2udsbr5UwlyOxbUJ30xP+wzs+zalGioht983nPfUMEUF0Ojfwh36sxJBLPrlFBELyO5Gwa1IUec1R67Jx6RrSqHFlyAC/MnTHHxGdX5X+Bj/fg1R7eSzU7OxTIeIkpEGCTlscmcGztc5Cec+zASg/FeloU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=a/NA375e; arc=fail smtp.client-ip=52.101.69.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixt0uDUaWwez4ZATZytoEatc9ukLcRvOL/ezjgm6kEtW3TNLZRfMpJRqJsZ9TmC4UtTFRa3XHv2c3hdgnnOBCYKRD33k6ux87PdnQ+rcTEWlcSR8MqLaVSeGyKU1Rg/bjxQS+Ogatx5VHrBYGC9xbEtKc1Ncc0pbpiFIMKHc/OwlKYU0d7CV2M7FjOnuIgEEybEWZP4GCi7lIj/kVVDqxuQXhGYO6nsQyR9ss/15WqzQtT8PMIQw4Y0GXlT/d3q7MnasLNktQbzf86U2+z2u8ZB9K1ZVGWShNBzI6fjbTCRJAzWOEbdPDwNPBsCpLiIQ/X/Blas/AN8XXm9+DI7KLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4mMnvpU2KduBzJAg2OMFjL6qcPUKDF+9OAsuB7dbhI=;
 b=t+szkw6AtCpxX8JB78g8PVYfJOdJXdUoVOu0JDGwS4PKsI6BHStUIjYV9T7GEKF4+nl3gTNQxcj5LRIryW0WOjpwat5mjzZSAM6CAIWjy/DOFhq0L+34jZ7C6rWEy81cN5LE31wwwfJBrQAb4nAYaHSEbH/sYVeBwDZQhrnIej7g7eKlubzDH8iIVQOdA+ommy/hih6KrU0Llbl7zwr2DUKgjoyrzkUX3bx3A8QVZK5Oz/gAEFdOSHI1MOBYka31pUnghmX6nCXches+sMzXBSRqNHqxlgzwRX/QYGQWp9WdlQMb1+TGke7fRgxSMbv993T1I1t6I8HxsyTROD4dpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4mMnvpU2KduBzJAg2OMFjL6qcPUKDF+9OAsuB7dbhI=;
 b=a/NA375enZF2uVN4UgAEohPPPCeILhjQfZL19Co6/mLBKLgQkPorRA1KcPkdKEUNwtjxGV6KfFnBBWD5M32ajqvT0irI0/PJhS6lJXJ3+F/3oneHQ8nwbMEUHoc/IssYsidPFoTCsunwl0DPDHFlXk+7I1Yfc4sx/RVZc4Qtav0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAWPR04MB9720.eurprd04.prod.outlook.com (2603:10a6:102:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 08:00:47 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:00:47 +0000
From: Josua Mayer <josua@solid-run.com>
To: Logan Bristol <logan.bristol@utexas.edu>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Matt McKee <mmckee@phytec.com>, Wadim Egorov <w.egorov@phytec.de>,
	"linux@ew.tq-group.com" <linux@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
Thread-Topic: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
Thread-Index: AQHa6mRMvn4eMRt68kiqym0pT5BO+bI37FCAgAI4KwCAALUuAA==
Date: Tue, 27 Aug 2024 08:00:47 +0000
Message-ID: <15b5d678-9dff-49e1-9871-9b3a98148f38@solid-run.com>
References: <20240809135753.1186-1-logan.bristol@utexas.edu>
 <23ac5cfb-dc5d-422b-925b-ab3f7cfae622@solid-run.com>
 <c6cca5d2-45f6-4a2c-86f5-cdcb0db9e936@utexas.edu>
In-Reply-To: <c6cca5d2-45f6-4a2c-86f5-cdcb0db9e936@utexas.edu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAWPR04MB9720:EE_
x-ms-office365-filtering-correlation-id: 639e6ea6-89ea-4737-7563-08dcc66e5bfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjhvS3QzTlVPMkhzR3owMmw2OGZUNlpyQTlqNDZoWlFrajNpbnBydVVmODVZ?=
 =?utf-8?B?V25ndEROQzdTRmdaM1NUZkkzMm9YWFBXOUhvaXpYTlJNdDhzUE5JT1Z2WXpr?=
 =?utf-8?B?cGRleFVDRHN4KytQVXNOaGJ0aGRiMFEvQm90RGxDVHlib1JuZmZ5Vk9odUtk?=
 =?utf-8?B?RzRnbWpZZXFNYjY4SmpzRVlpZnV6WTJ0THc5NXVPaXdNeWJxTHNYNjVsbnNU?=
 =?utf-8?B?Zy8wMnFaTjJCbTBlZlR0MythZmNzUmY3dllCOFIxMndQQ0RrOHl4cUpZQUJx?=
 =?utf-8?B?L2Z0WWZTSHpqVWRRazJrNXZzZmpJYzJqei81bUplRDBJYWxKemdJWFNmZlNM?=
 =?utf-8?B?MEVZZW9lMkQwRzJuQVIxZkQ5U1RLSjR5TnA4bDVYMFZ3bXBnTUVtWDlKQlZk?=
 =?utf-8?B?SmxyK3hQZmRnYUx4Z2h4SFlqMGpIYlJHU1hjS1dqWStuZldhYnY5WCtMdXJQ?=
 =?utf-8?B?WHBISGJ3dTk4ZTh2ZGIvT0w1UDhZN3hPQlp4cFVralpiV3FJT2ZrVGpJcTZy?=
 =?utf-8?B?WU0vVUhiZWR5ai80OXR2S0dlYXlaOFhsanV1OUVnWkErYktnNDdYbkpOekZo?=
 =?utf-8?B?MnhqeUZROTloVjJJN3BCeVFVcEpVV1ZrdFA1cWl5cXN2ZGZqdDRHTnpGZEVR?=
 =?utf-8?B?azVhSEljUVpuRDcvbWJCMUYvUnhDbFRicGowVWxTeUc4U3gwMTl3OGRBb003?=
 =?utf-8?B?RHFLTFlSblhnMi9keXFzODRieEJFcEU5T0Rxd2hZeFNoMkJCcExZcnNkRHFU?=
 =?utf-8?B?cVhoUjF4M1FqMFowVERITjYzT0ttQk0waWFhTXRQSnNoMmNKcVBuRjNVcnhD?=
 =?utf-8?B?V2loZ3FSNVVVWHk0YjN4TnNYSDY4QjlsV2VsQzlYendVY2J5WTdqZDB1WHQz?=
 =?utf-8?B?Qnp0ejdXSlRBaWZIZ1dzd3piWlpOeWQ0YzJxbjRnR1hHTGlucUpCc3Z5K0po?=
 =?utf-8?B?cjdoeVkvcEJvbXhGZmhrd3ZJVFNiUWdXdkV5MWVIMm15MU94VmVkaVVqZUJs?=
 =?utf-8?B?RWhzQnFYQndIcGxOa0dxUG5YaXBIVG05ejBzcitrM1lVOHFwbml2Nm9Eblpi?=
 =?utf-8?B?NTdBaFM0LzVWc2cyTlA2c0lXZ2RLZ3FBZDh3TCtGbXNWbjFjSUVHL2tLODhP?=
 =?utf-8?B?eUpMeUg0L0xTRGZxOVdvelNFODFDbGNmR3RVUHRnK2dQZlhJbnlRaHIyckNi?=
 =?utf-8?B?QW05VFU1enI4cWI1UXdCNE54eHhJTXIrVnVYS3BQeFBPaVcrOTlGKzJEdmZG?=
 =?utf-8?B?cGhoSGk4RDdIQitoVWF1QkFOWXQrcnd2azF4YUtxSERKL3JmcjV2bEQ4djZZ?=
 =?utf-8?B?MmxJanJwMFUwVUtTaEUxUjZxUE1oSTY0VlNnRTJRbk1NNWdkUzZ1SFlQU0Jl?=
 =?utf-8?B?WWk2R2kwWFdOamVCd1BhejMzQ0sxejl6MEF3bTE1UHh5THhuVWZkQVZrV2hU?=
 =?utf-8?B?TUMwdTBqUm9Nc0xUc1ZMOVdCeVcrbDlFYXRkOHNkZW9lanhVNlZvd1NncnJm?=
 =?utf-8?B?OXFGM2p1YmpoOWc2S2tpT2JxRXNEdUFxREJOS3crOUxSVzFHMGx1emNvcFVH?=
 =?utf-8?B?NEd3MnpSYTNBWG1JRTNoTHk3TFlKUE1kZFhYSko5YU5VWFN6WHdQNkVHcnRY?=
 =?utf-8?B?aHVGeE85b0h6Qjl5MFFnelFqSVJkc2syRnVGTEMwWU4xdG1iOFRYZGhZbHV1?=
 =?utf-8?B?QmlZS3N5TlhCRXBlWGtqMmhsYkZuN1MrcE12RnUzMDBwNm1zdXZucFBmM2Jt?=
 =?utf-8?B?U2JyN2hjdUFUUkxNR0xVNVhCVW1xQUtoVTF6Q0diejFPL0JWejNnNDRrWjFX?=
 =?utf-8?B?TDRvWkN6VVFkaXJrTlFmNERCVnZWWlZuRzlYMHZGODBKSDVTcGEzTThDN3N3?=
 =?utf-8?B?blVFUlBIZXdZR09PWUQ0U1BqZElTUzR6K3BRcHBJYkVXTGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzV2VkR2ZFN3d3NHSkxSTjA0R2wvUER5T0lHY0dJVkZCeTFoOFBpcGRzekQ2?=
 =?utf-8?B?VVRCTmcrbEkwU3VYYVR6UUs5WllSQmZzNXhQaDVLMmljWEw2MXprOEhBUlF4?=
 =?utf-8?B?RXVZb21EYjlpUXoyVkdsa3RNa2c0UC8wQVowaWhTeUk1UWlEUzlPdU4yMTJL?=
 =?utf-8?B?aUxIUWJialdYMXBFc0NWZ242ZlpWeGg0ODFwd1l2SldxQ2czc0dGaW9rR251?=
 =?utf-8?B?TmhTWmlzdEJBYkZoUG1DNlNMUTVkY3dheTBQbzVSU0NMUkZxL0JsZ1pTOWtp?=
 =?utf-8?B?VmZhMStSY3B3VjF1dGJSYUxvMjNoY3dxZnpkdmkzd0VGLzQwMUdoTGdlNnAv?=
 =?utf-8?B?dnQyVHpLUzc0amhLTVh2L3IzQy9LSTNrY2ZoclAySEhoSjNJTDBjOWhNN0NJ?=
 =?utf-8?B?clE1VUxSbC84cE9CbEF2TDloRE9mMGxEYzJOMlhMamtKeFg4ZDJHQXRHRGRG?=
 =?utf-8?B?MVJkUkszU3paaXZnN2hiUkN0MTNXQVpmTUhTdnJiR3FERzJSK0xtc2d3SVZp?=
 =?utf-8?B?TmJZdThhN2p0ZEFCa1hqVE93K3YwVUwwcW1TUzBVWnVIYWc3eS9aVDZKYkJY?=
 =?utf-8?B?QWVFaVVNR3VXaERtaitvVU9CZ0NKY1ZBb3lORDdtL3BFd2t5VVlydUh4Vlp2?=
 =?utf-8?B?cXozY3VVOWJROG5xbjJOdUdiejNCb2FyMENRRTJqeVViTU9Dd1lsMUdBd2FH?=
 =?utf-8?B?RUcrdndWSkwrYW4vYThkaEQvSnJHREVXaGJneHFCWUNMamxwQ0VuRWZKUTBm?=
 =?utf-8?B?YWtFaGhvN2NGU24xN3hsbGJpMEx2cHROcTg5aUlNMWxYQ0Nwc09meFZzekhO?=
 =?utf-8?B?MGwwMEtYbDJ0bVl0dVFkeHJsYUtPVUExclVEMC9MSEJKd2szcFVrS1YrVGVi?=
 =?utf-8?B?WWlVT3JQSUdxZFRBNEI3akVwb3AvVEtIb3d2NS9OdlM4WUNNQlVUWllacG9X?=
 =?utf-8?B?a1BrVXBpRHRHWFN3QWl4c016YUJ1aFgwRmVoS0w1Mit2dCt3d1BjVjA4VWpi?=
 =?utf-8?B?TWhEZXpnY0VxL1BhK1FYbGtOVGNPbUZIMHo5T2llYVlYMnZDc1o3bUpWMExw?=
 =?utf-8?B?VG5LZFB2dW9CMmhNeUlaYUFka2tIOXNjWUhKRE1xbkdXN0ZCckJ1NTE1bHBa?=
 =?utf-8?B?ZThsVlkwcC9wZkdlVmxBenc5aHFraGIrZnNxVk9PenNTblhkQnovWFMxa3hN?=
 =?utf-8?B?MXMzTEZ0QWltWGJGRlJqSGhUQkpiWEcwa0ZKa2FuZ2xpaHM4aEZhOFlvQk02?=
 =?utf-8?B?d2g0cUw2eFVFVjZ2K2VtVGJCNXkyV0I5UW53blpXVitwdnIrZmx5VzA0aTBl?=
 =?utf-8?B?YWZMb0M4Z1ZqNFF5NXhIOThVVFdUTjlCaXNRZ2VuTzE5K0o1LzFqL1VPSy9B?=
 =?utf-8?B?VHpNZjE0U3lVZ05rV3BkMzhPeERuU0dhOU9HbmY4c25ZbHJqSmgrTmFwTklP?=
 =?utf-8?B?cEpjbGwya0o2RHJpN0VGZmVRSHlQNHNJWHJOUjZmajhBVnFqSm9uSDdyWDhx?=
 =?utf-8?B?cERFbVB4aWFVRUhsYmtMVzk1RXA3WTZ3WVlLUFRBM3NQSWZocDQ2ZXI4Vkht?=
 =?utf-8?B?RGRieWN0dXlCVCs3ckRWV1RjOTRZUW1mNG4zMGkvb1N0emVWdXdnaFVzNFQx?=
 =?utf-8?B?SSs0UUdsbllRVDE5aVA2dkpsa05JUWRaYXFEbmQ3S2VaaFQrdHZYOWk0WG1W?=
 =?utf-8?B?QmpjTGtndllWYkE0dXJRSXdWVHh0ZzFmNU9ITVl2a0NtY0J5djRRWFJkVm1L?=
 =?utf-8?B?bFQvNlphWnQ3T0RIT0ZIMlo3YjFudGVEaFBnWEpKOSszUHhSUzNlT0ZDVFlG?=
 =?utf-8?B?aWh6SE9RVDFPQmZxZVNxNzZUelBmUmc1azluNEMvMU4zMllYR3FZUzhOWm1B?=
 =?utf-8?B?ZFo4dkpHYzJPdlZDWXFZTUlnVmhXNmJpZ1kwV0dXWHhNWkZ3eEdCU3FhMlZx?=
 =?utf-8?B?TjV3Tm54VVQ1NU00ODBJVUkxUFNyOGVSbUphRHN3b092cUR3YURxT1VIbVRk?=
 =?utf-8?B?Z1V0ZFh6amFxR2JYQWtsdE5FckxhcTBJWmJoeHhaZ2liazJwbW5rR1dSRmpV?=
 =?utf-8?B?VGRQcjdpY2pqV3NXcHZxTzFwOXlnUDAxZ0ZsQmNSdVljNFQyOWozQ1RMSE1G?=
 =?utf-8?Q?PGiBl8ONsRNRz0PGK1O6M934Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <036A4B201D57E148AB591203D4C0422E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639e6ea6-89ea-4737-7563-08dcc66e5bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 08:00:47.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oYs6fm61ZXj1Ms65nteoNk7NF30FkcgMbcUB2GxRwtRtNcI7EnsKzqQtJRHFzWm2VutivEVE5qF6MKQX09Y2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9720

QW0gMjcuMDguMjQgdW0gMDA6MTIgc2NocmllYiBMb2dhbiBCcmlzdG9sOg0KPiBIaSBKb3N1YSwN
Cj4NCj4gT24gOC8yNS8yMDI0IDY6MTggQU0sIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gSGkgTG9n
YW4sDQo+Pg0KPj4gVGFuayB5b3UgZm9yIGluY29ycG9yYXRpbmcgdGhlIHJlcXVlc3RlZCBjaGFu
Z2VzLA0KPj4gdW5mb3J0dW5hdGVseSBJIGZvdW5kIGFub3RoZXIgbWlzdGFrZSAuLi4gc2VlIGJl
bG93Lg0KPj4NCj4+IEFtIDA5LjA4LjI0IHVtIDE2OjU3IHNjaHJpZWIgTG9nYW4gQnJpc3RvbDoN
Cj4+PiBFeHRlcm5hbCBpbnRlcmZhY2VzIHNob3VsZCBiZSBkaXNhYmxlZCBhdCB0aGUgU29DIERU
U0kgbGV2ZWwsIHNpbmNlDQo+Pj4gdGhlIG5vZGUgaXMgaW5jb21wbGV0ZS4gRGlzYWJsZSBFdGhl
cm5ldCBzd2l0Y2ggYW5kIHBvcnRzIGluIFNvQyBEVFNJDQo+Pj4gYW5kIGVuYWJsZSB0aGVtIGlu
IHRoZSBib2FyZCBEVFMuIElmIHRoZSBib2FyZCBEVFMgaW5jbHVkZXMgYSBTb00gRFRTSQ0KPj4+
IHRoYXQgY29tcGxldGVzIHRoZSBub2RlIGRlc2NyaXB0aW9uLCBlbmFibGUgdGhlIEV0aGVybmV0
IHN3aXRjaCBhbmQgDQo+Pj4gcG9ydHMNCj4+PiBpbiBTb00gRFRTSS4NCj4+Pg0KPj4+IFJlZmxl
Y3QgdGhpcyBjaGFuZ2UgaW4gU29NIERUU0lzIGJ5IHJlbW92aW5nIGV0aGVybmV0IHBvcnQgZGlz
YWJsZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEJyaXN0b2wgPGxvZ2FuLmJyaXN0
b2xAdXRleGFzLmVkdT4NCj4+PiAtLS0NCj4+PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPj4+IC0gRW5h
YmxlZCBjcHN3M2cgYW5kIGNwc3dfcG9ydDEgaW4gU29NIERUU0kgaW5zdGVhZCBvZiBib2FyZCBE
VFMNCj4+PiBpZiBib2FyZCBEVFMgaW5jbHVkZWQgU29NIERUU0kNCj4+PiAtLS0NCj4+PiDCoMKg
IGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NC1tYWluLmR0c2nCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMyArKysNCj4+PiDCoMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMt
YW02NC1waHljb3JlLXNvbS5kdHNpwqDCoMKgwqDCoMKgwqAgfCA2ICsrLS0tLQ0KPj4+IMKgwqAg
YXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1ldm0uZHRzwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMyArKysNCj4+PiDCoMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMt
YW02NDItc2suZHRzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzICsrKw0KPj4+
IMKgwqAgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRzacKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCA2ICsrLS0tLQ0KPj4+IMKgwqAgYXJjaC9hcm02NC9ib290L2R0cy90
aS9rMy1hbTY0Mi10cW1hNjR4eGwtbWJheDR4eGwuZHRzIHwgNiArKy0tLS0NCj4+PiDCoMKgIDYg
ZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0LW1haW4uZHRzaSAN
Cj4+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NC1tYWluLmR0c2kNCj4+PiBpbmRl
eCBmODM3MGRkMDMzNTAuLjY5YzVhZjU4YjcyNyAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL3RpL2szLWFtNjQtbWFpbi5kdHNpDQo+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy90aS9rMy1hbTY0LW1haW4uZHRzaQ0KPj4+IEBAIC02NzcsNiArNjc3LDcgQEAgY3BzdzNn
OiBldGhlcm5ldEA4MDAwMDAwIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhc3NpZ25lZC1j
bG9jay1wYXJlbnRzID0gPCZrM19jbGtzIDEzIDk+Ow0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNsb2NrLW5hbWVzID0gImZjayI7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG93ZXItZG9t
YWlucyA9IDwmazNfcGRzIDEzIFRJX1NDSV9QRF9FWENMVVNJVkU+Ow0KPj4+ICvCoMKgwqDCoMKg
wqDCoCBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZG1hcyA9IDwmbWFpbl9wa3RkbWEgMHhDNTAwIDE1PiwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDwmbWFpbl9wa3RkbWEgMHhDNTAxIDE1PiwNCj4+PiBAQCAtNzAxLDYg
KzcwMiw3IEBAIGNwc3dfcG9ydDE6IHBvcnRAMSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHBoeXMgPSA8JnBoeV9nbWlpX3NlbCAxPjsNCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFjLWFkZHJlc3MgPSBbMDAgMDAgMDAgMDAgMDAg
MDBdOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aSxzeXNjb24t
ZWZ1c2UgPSA8Jm1haW5fY29uZiAweDIwMD47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfTsNCj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3Bzd19wb3J0
MjogcG9ydEAyIHsNCj4+PiBAQCAtNzA5LDYgKzcxMSw3IEBAIGNwc3dfcG9ydDI6IHBvcnRAMiB7
DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxhYmVsID0gInBvcnQy
IjsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGh5cyA9IDwmcGh5
X2dtaWlfc2VsIDI+Ow0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
YWMtYWRkcmVzcyA9IFswMCAwMCAwMCAwMCAwMCAwMF07DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KPj4gLi4uDQo+Pj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItc3Itc29tLmR0c2kg
DQo+Pj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQyLXNyLXNvbS5kdHNpDQo+Pj4g
aW5kZXggYzE5ZDBiOGJiZjBmLi5hNWNlYzlhMDc1MTAgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRzaQ0KPj4+ICsrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvdGkvazMtYW02NDItc3Itc29tLmR0c2kNCj4+PiBAQCAtMTc3LDYgKzE3Nyw3
IEBAIHZkZF9tbWMwOiByZWd1bGF0b3ItdmRkLW1tYzAgew0KPj4+IMKgwqAgJmNwc3czZyB7DQo+
Pj4gwqDCoMKgwqDCoMKgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4gwqDCoMKgwqDC
oMKgIHBpbmN0cmwtMCA9IDwmcmdtaWkxX2RlZmF1bHRfcGlucz47DQo+Pj4gK8KgwqDCoCBzdGF0
dXMgPSAib2theSI7DQo+PiBjb3JyZWN0DQo+Pj4gwqDCoCB9Ow0KPj4+IMKgwqAgwqDCoCAmY3Bz
dzNnX21kaW8gew0KPj4+IEBAIC0yMTAsMTAgKzIxMSw3IEBAIGV0aGVybmV0X3BoeTA6IGV0aGVy
bmV0LXBoeUAwIHsNCj4+PiDCoMKgICZjcHN3X3BvcnQxIHsNCj4+PiDCoMKgwqDCoMKgwqAgcGh5
LW1vZGUgPSAicmdtaWktaWQiOw0KPj4+IMKgwqDCoMKgwqDCoCBwaHktaGFuZGxlID0gPCZldGhl
cm5ldF9waHkwPjsNCj4+IFdlIHVzZSB0aGlzIHBvcnQgb24gdGhlIFNvTSwgcGxlYXNlIHNldCBz
dGF0dXMgb2theS4NCj4+PiAtfTsNCj4+PiAtDQo+Pj4gLSZjcHN3X3BvcnQyIHsNCj4+PiAtwqDC
oMKgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+Pj4gK8KgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+
PiBXZSBhcmUgbm90IHVzaW5nIHRoaXMgcG9ydCBvbiB0aGUgU29NLCBkcm9wIG5vZGUgdG8ga2Vl
cCBzdGF0dXMgDQo+PiBkaXNhYmxlZC4NCj4NCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRo
ZSBjcHN3X3BvcnQxIG5vZGUgc2hvdWxkIGJlIGVuYWJsZWQgYW5kIHRoZSANCj4gY3Bzd19wb3J0
MiBub2RlIHNob3VsZCBub3QgZXhpc3QgaW4gdGhpcyBEVFNJLiBJZiBteSB1bmRlcnN0YW5kaW5n
IGlzIA0KPiBjb3JyZWN0LCBpc24ndCB0aGF0IHNob3duIGluIHRoaXMgZGlmZj8NCg0KWW91IGFy
ZSByaWdodCwgc29ycnkgYWJvdXQgdGhhdCAuLi4gbXkgZXllcyBtaXNzZWQgdGhlIG1pbnVzZXMg
OigNCg0KQWNrZWQtQnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KDQo=

