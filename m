Return-Path: <linux-kernel+bounces-169330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3688BC723
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2351C211BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44487481A7;
	Mon,  6 May 2024 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="cmNaQdYn"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53CF45944
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974537; cv=fail; b=T7rI6Aw7f7egmCowpMH1zH2+iqEvpA8dxi/IG6Dugkdjj+KsBYVPs9OIJs1TtrrvDvm5DLvQWnBIExB4IE1TayDVD0nxA5Y2RrX08jw9tq6Ueb3C4cdbgBGrHCl1yoy1J3eWNA1HMbLiAKdn9vpmPzz9J6bowKzyEo8GjjvoitU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974537; c=relaxed/simple;
	bh=yGIu441crHucRHSZmbZWjFQ8YhT5XFTAOi8MEM5iWTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jNamiaLnZjyOS/qHWsvm37lc1rILdoA40UNAsearOgs4s5rYw5768SZjF2HMkw7MWWlN2rrQMwrHXxIcwzDU6D9rfcXZEY0Q9MaSs9T8xOr2vYcIMHGGmeV9eTKNXLMqd1HQmR9RWT0msW+dClinC+dBwVJ0pPzTHxvt0PuZqDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=cmNaQdYn; arc=fail smtp.client-ip=40.107.255.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg2vRN7/m2op1zjIiRXH+3A3aSzUZowfbbEJHFlN1EkhN3KWEbif5PlL0RD7T1xueAA6sE261kHhC3ZFawHI2dG+JXj+/KgeRg5LTObDfAKiOpoVXj8h4xcJZSSC5JNQ6g2Be+TQZcL3hgcEiAgd6YmVTnuDQQD/DUMBG8TWBWVBNs6GA3aCQRzSSXVRjlJ36Hqt2rzdzoSpY8V9h2inmtaMKuB+pxitTjPV/m2EBI9Dnvq6W96eAfrTlbvTyi+jvN8L0A/TmmuTeUzGvE7BzRsOwJogxKjcbqAYgrIaBIjMP+7zrMDxiwMExiEII6QNRW7TpT9auxhQbfnw/whN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGIu441crHucRHSZmbZWjFQ8YhT5XFTAOi8MEM5iWTM=;
 b=hh07NXREx30s2uAy8iPeEo0flmIqi/FSWBcQ5Zabk66zzAXrREGNFLOcwkYk5uhAMMUxTl7Ru1dYU1yQ3kF6hWyLdFEbfPYm1bhtgNfJy7gUxelXOiA/HGswGpXIjI0LbVhKTpes/fe/bG3fp47hT0hzPYFesoAuvdJPfGkY9Al8ZVuwXbRMoD1KhisUWXX+XOBP86CtSYx1n0zrTjyjsUqgzUxjlIi1Cz8Y9jQjHj94FzZtw/C8lBjpNmstewzj72Y/XJQFtW/xZlxco5hX6QfQBptvYQNoERDFS3MiFv+xFs9UYcEBcTV0tMAx/N2LRvjGpMXTDiQ3pLzSw/SE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGIu441crHucRHSZmbZWjFQ8YhT5XFTAOi8MEM5iWTM=;
 b=cmNaQdYnPzrmPG9XDH41HvHDws4dILmAvVQI1Pa95xybRp3/5JIqkznXYTPD9h7hvvEvzDMKzosUEdC47OmY5UdD2uQYaa8bLVEjiQFdd0bq6YzJWlh/G3N1xlOmcz38m60DLwIdwkbqJYcTAg1XzIPml+btfhNfz3p/GcoeVAhPcPN1YKJ1uQV1ntz4OA6jAHyUKxT+jxh8fBxTqWSR4kzQ6Mq7OYVBoTwCTJtl8CTiYCOnKGb0HX0dvLQzWKHy7AfFXhYwmFuFDYhIEgQ5lRfGvilLfcXmR5FoypM/e1n16jHCW2P/pexwSamIH2GJULT6ifUIMNll/gDz8CkJvw==
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com (2603:1096:400:465::12)
 by SEZPR06MB6718.apcprd06.prod.outlook.com (2603:1096:101:181::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 05:48:50 +0000
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::6f8f:f3d3:493:bb86]) by TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::6f8f:f3d3:493:bb86%4]) with mapi id 15.20.7544.029; Mon, 6 May 2024
 05:48:49 +0000
From: Dylan Hung <dylan_hung@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "joel@jms.id.au" <joel@jms.id.au>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"zenghuchen@google.com" <zenghuchen@google.com>, "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
Thread-Topic: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
Thread-Index: AQHaSprFD5IIKTS6AEypynuES/HNLbGCio2AgAFFYZCABoIIgIAABIeQ
Date: Mon, 6 May 2024 05:48:49 +0000
Message-ID:
 <TYZPR06MB65678EE7611DDB825E5404C19C1C2@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
	 <563ad5613e9c5f0671e1f49f2d9ba71d8735799b.camel@codeconstruct.com.au>
	 <TYZPR06MB65675E5D43EE265DD702E5689C182@TYZPR06MB6567.apcprd06.prod.outlook.com>
 <645d4f645b1296d54573c4fe734768adab160035.camel@codeconstruct.com.au>
In-Reply-To:
 <645d4f645b1296d54573c4fe734768adab160035.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6567:EE_|SEZPR06MB6718:EE_
x-ms-office365-filtering-correlation-id: fd2c3e88-a751-4c1f-03f4-08dc6d9033f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2hIMERxZU9jd0RnSlBHZHFDRlQ3ZmZPem1kNm1HeUVqZjMzOGpGUTlFRUlV?=
 =?utf-8?B?VG1rSnRVQkJFT3VJZnBXWmlSMVU5a2N4d25lTW4vaHpkbnNQWlJHOWlSak5z?=
 =?utf-8?B?NjF6dUJ3M252OHhGWFdJSHNQRU0wVzg3SFhVZENsbGRsUVhOYVV3VkFJcjls?=
 =?utf-8?B?VHpaSUcrM3ZkTDlCWXJXSUovVXg0MjlreitYNXlTWVpMZmRkT3pneVAzSWtK?=
 =?utf-8?B?NmMwOXFCM1ZBYXBKc0NkZVFEQjZYZXVYNU5NVkZiY1Y1Z3ZnRjFSOVVWd2Nh?=
 =?utf-8?B?S2QzaU5wT3lnVlluYnVYaGJiL3A4MmE4TkFIWWdiOHV0T083MDhuMUg2ZVpt?=
 =?utf-8?B?emkyUXlHdE4zZi91STdFWWZheHFnRDI5ZitTQWMyT09NVkw0NGVoR25mNVFL?=
 =?utf-8?B?dDdETjVqZlRiM25SSjBvbHMrZXEzRHVyeUlHSDJ0VHN6Snl1dDBpbUdNSHF6?=
 =?utf-8?B?ZTE1YlFPUHozMWVTUG5kT3VIODZhcWtRQVNYSDhId1oybmlOdnNrQXpPdlR2?=
 =?utf-8?B?czBaQ2s1SStnOHVIMXYxeUw1WTBFZUxPVXZQVitEQ0dLdGVpSEJseGkwWVRz?=
 =?utf-8?B?NXE2d25xcjRndXBVOWl4NGFaTnoxYXl4UFJVSjJIUTNScEVlQ29meVVOcWNq?=
 =?utf-8?B?QlFqeDhnbDIwbkFmS3NkSVB3WXpVQ3RNdit5b216RDU2S1BFR1JGbXZSVnYz?=
 =?utf-8?B?R0VoTEhjcm9rbEx1UjE0emRORGdrTGxSdk5RRFZabCs3SUN2T1VDRkdBSEw1?=
 =?utf-8?B?c2ZHTUZOZmJlalBEcEtPZkdSS3VaalFmSk5tNy9uRXVLdVdvWUtGaGJDNUo0?=
 =?utf-8?B?ekpBKzZmTHIwYzV2eEJndDF0c1lhYUhYaFppVDJUaDlwMXhUNk4zajRucXRX?=
 =?utf-8?B?ZnUxUnZray9tMndJeWhRTDB1dS9ORUJyMFRFdEQ5WUNrZnlNNTJ3ZDZwRUZD?=
 =?utf-8?B?QVQ2YjNTNll4NnlHeFBiMGtFVGIySTI0dTRaTUtDWGdmWDgwRmF5UTgxOGlS?=
 =?utf-8?B?ck5kYjJqK3REZFdRQUVISHJwNDdYdmtWUGJueXNyR2VwVTEzNnlyV1FJTFg0?=
 =?utf-8?B?S0o3MmpXWE9IN2w5NGwreURKbi9tUXlBZVc1QWZaUHpYRE93M3Y3RFJZL3VX?=
 =?utf-8?B?eHhXWVJWb0lhSGhXSDEvclBhK01TUUdKckI5VitJWFBScmZRaW02YjV6ZWdy?=
 =?utf-8?B?WmJzamRYUnVSS0syNC9aQ3FRN3AwZkErcE5JUE1SOHJhYWVtaW4yYkR0Z083?=
 =?utf-8?B?b2ZaVHQvaGljL0FtdUJSZTRNV25oU3NPWDJ6NlpWNlpuSG5BMGdqeXJTNmFE?=
 =?utf-8?B?bXZQbjJ3TmlmSUprNEEvZkRIUHJhRDJ6MDVoNzVIQ2cyNDFEMEhwcmxDaTJi?=
 =?utf-8?B?Wnh0WXZkZHF4RTJqNWZzc2doSWljQUZIZEU5c2tTRTFkbW5yaHc1L3ZNVUZs?=
 =?utf-8?B?R0hvTkJBMkZDSDdhTHdRNFgxaHd5c0lwSllXLzRuU3dCK0NKdnNrM09xZ3p5?=
 =?utf-8?B?cExEK3cxQjZNMHhRdDRrdVVoNFYwazN1L0lVNjRoQUNYWjZWTDRNSjBDOVlz?=
 =?utf-8?B?LzNXZjhDaHdYa2t1eUdMVy9xZVc0OG5Yd01rWVpFcWs4WTJHSG1NNDd6NlZQ?=
 =?utf-8?B?eml4UTBiQkNCeHNzMVYvbldCb3gyN0VCSW9ES1VVaDdEL2s4N3crVUZlbzBT?=
 =?utf-8?B?R1k2YVp2YW55SjdPbVgxbXNRQmtXM2dCVzU0OU8wcVJYTjQvQmQzNlUxbEV2?=
 =?utf-8?Q?XF85dKmJNRWjFkeASg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6567.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3BjaWpRNDA0S29ESGNPeTlOT2VUT1BYSzd0YnVyNkFxZk5SYWJXOHdHQ1Z2?=
 =?utf-8?B?NWhLS21IYTVVdXF5UHVwR3NRTUJKK3RWQnVBUUhvdHJOZmRuaGQ3WjR0UVpP?=
 =?utf-8?B?Q3lCNkZYUXh5MHFFRU5PZmJWR3hZYStqK0lieENiN01SdzZFSFBjK0JDcHI3?=
 =?utf-8?B?NGlvNDdYVTlqMVk3d3FXeklVb2wxdGlxaW53WnZ0SERnMEdyNjRlUTFBRHVL?=
 =?utf-8?B?b3k0WVBEREtKMDVoUkhRWU9rczZabHNkdTlvQXk0SWNnRVFGMjhwL29VeDBB?=
 =?utf-8?B?ZzN2aHB5R0dXWjB4NHRLKzlpMjVvNjdtdnVYTGtZa1A4eFRFT0ZocW5nWEEy?=
 =?utf-8?B?VGtQNjgvVGFIVW90MnBiTU9xVUdmbC91MitXN0xhc0hlakhsOERtL1N6MWZa?=
 =?utf-8?B?YWtNSkV6aXpaWmYvblErZGJIWlNBZmNBUjhNMkgxNzdzYzRnTkRwS1ZudDNo?=
 =?utf-8?B?aWNVOFJlNDN3b0MrUW5acnlWQVIwK0FsTldMMVU1QUliV0RTMisvWFpEWUNN?=
 =?utf-8?B?Y0g5M3V6L1FqeHM5N2JXRmVHbStrMVo4enAvMjcyTUJkQzZwbVNSalNsbGJX?=
 =?utf-8?B?dllOUjlCME5tOWJFbHI5c0hVNTFUSkl4UytsVHYyN2NHMzljdFhxbWxYcU1j?=
 =?utf-8?B?aThKZ2ZMdlduenJnNnY0ckhmS2l1Y21hK3FSQU1JTHhZNjZscGZNTEZqSW5h?=
 =?utf-8?B?N0VFUXIzQ1NQSFJEb1FJY0RQVXVQV1dhQUtheVBkRk44bjVOMXZkUWVjS3oz?=
 =?utf-8?B?SG11bkJReDc1UUc5U2gra0VrN0JxOXFhTkZFR3VBRnhwTi9hK1FjOXdTRDV5?=
 =?utf-8?B?elVRVmlCeEYvRXZNU05nU0ViVy9BSlFiM3NHM0Z0ZWtTZlhkaW04dmhlODZN?=
 =?utf-8?B?ZFVwdnhMci9ES1VvWlZaWXRtUzVwdS8xcnkyMDVMZkhyZ2J1NDBmQ1l3dm5B?=
 =?utf-8?B?cjhjM0lWVEJPNGVUdVFIOXp4R3hURU1EMS9BZER0NmtYdGNZem5uZm5EUG01?=
 =?utf-8?B?NjVqSTlVenNYR3oyeHVOdGNBVkhpRHpCd1N0L0tGNmJzZG4wNXZCQUMxamg4?=
 =?utf-8?B?bkFWbnlsK0VueUpsOUlqK2IzU0doSnI0UlNhWTg1RFBLV2dsRkN3clFEWGhu?=
 =?utf-8?B?bE1valhOR0tZZ21aQjRyKzRodGYzbzFUNkkxL3NUakFxZmo1RVVGdlBJdER1?=
 =?utf-8?B?UXNHYlhIVzhKNTlWUkRWOFRUbm51YmRneVhzVUd5WlBQVnR2eVd0Uk4yaE1V?=
 =?utf-8?B?MUJUeXR2ekkxZTZ2bkpsNXJLY2ErTGpzWUFYUEVQTTFZNEFBMHdIaDVBK2Zh?=
 =?utf-8?B?OXF4akZRcDA5VERsNXVoY2FJYjRZeVB6YXBseFlYMTZnREViS1VFTUxDQndE?=
 =?utf-8?B?SFFESGNiclI5YUEwOE9RaEs3aU1id2Q1eDArc2dIR3NpdUNCZGp5UFBXUGhp?=
 =?utf-8?B?dFA5bFZqYi8wSXJkSkZFVk5ZRm9VRFBpVjF2c2NoaGJGRGpiSWdneGtXMEkr?=
 =?utf-8?B?ZWlkNjdhakVpNnF0M3V3djZTVlN4SHc1N2V6MWpISnVaNGR1NXFzcVBwcVpy?=
 =?utf-8?B?VlZPNzBTOVBHeEhuNFo3RmpKWjlzdUhXV09HTVVzaENVVkFjaE9SdnE2bXNr?=
 =?utf-8?B?RUJscUFhUHZrcVovaG1KdkVxV0x4ZFkrbFczV1N1d0VqZW8vL01QbEhEdEwy?=
 =?utf-8?B?Sk9YMlhpOG1YWXNOZ05USGRWQTVQMjNBYVRPaGlWTkpydW5VWUllSllkcTh3?=
 =?utf-8?B?djMyWUkreTBjMGxwUktpNnZ0WFE0YkZTamxkdkxSdUZ5YjUwMGswWitvbk9h?=
 =?utf-8?B?U1FiOG5obkZqbXZNMDVJM2xJdEFrTzJKUU5TeEZXaFFkdXVWOWVzQW5Ibk1K?=
 =?utf-8?B?RlVDQzAwblV6QXVMS2N5NDJsVSs5UXgvSU4xRXA3Z3hKanJGOS8zajdpNllU?=
 =?utf-8?B?VWQ1K1ptQnZUTmpFSkgzbjlyVlZFNUkwT29acTQrSmg5aDVjOXpobE9iVEZz?=
 =?utf-8?B?Q3FrVzZncnBWZGpIRDlIcUlHZWdCV0dWMEFVN2dPakh5S29kZlJOUU5pWnhD?=
 =?utf-8?B?M3RKWG14YmxEZGtHOEZIT1VXSWV0cFBCZ2k0UW5yYWwvck55MTlWSktudlox?=
 =?utf-8?Q?YNSmndpA0Uqp2XiCyVtE/3fAi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2c3e88-a751-4c1f-03f4-08dc6d9033f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 05:48:49.4044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GohdejZrcG7gSfG8oUSTf1dDvTaqDm/JMOovWe3r6H3jAGukt1jgn+/Rq7i/ik+lAY8TukKF0u/g7csqZdxs4QZpAOuQwFWFJBOBmQ5+7s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6718

SGkgSmVyZW15LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplcmVt
eSBLZXJyIDxqa0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogTW9uZGF5LCBNYXkgNiwg
MjAyNCAxOjEwIFBNDQo+IFRvOiBEeWxhbiBIdW5nIDxkeWxhbl9odW5nQGFzcGVlZHRlY2guY29t
PjsNCj4gYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb207IGpvZWxAam1zLmlkLmF1OyB1Lmts
ZWluZS0NCj4ga29lbmlnQHBlbmd1dHJvbml4LmRlOyBndXN0YXZvYXJzQGtlcm5lbC5vcmc7DQo+
IGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsgemVuZ2h1Y2hlbkBnb29nbGUuY29tOw0K
PiBtYXR0QGNvZGVjb25zdHJ1Y3QuY29tLmF1OyBsaW51eC1pM2NAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEJNQy1TVyA8Qk1DLVNX
QGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpM2M6IGR3OiBEaXNhYmxl
IElCSSBJUlEgZGVwZW5kcyBvbiBob3Qtam9pbiBhbmQgU0lSDQo+IGVuYWJsaW5nDQo+IA0KPiBI
aSBEeWxhbiwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlc3BvbnNlISBJIGhhdmUgYSBjb3VwbGUg
b2YgZm9sbG93LXVwIHRoaW5ncyB0aG91Z2g6DQo+IA0KPiA+ID4gTXkgaW50ZXJwcmV0YXRpb24g
b2YgdGhpcyBjaGFuZ2UgaXMgdGhhdCB3ZSBrZWVwIHRoZSAiZ2xvYmFsIiBJQkkNCj4gPiA+IGly
cSBlbmFibGVkIGlmIGhvdC1qb2luLW5hY2sgaXMgc2V0IChpZSwgYWx3YXlzLCBiZWNhdXNlIHdl
IGRvbid0DQo+ID4gPiBzdXBwb3J0IGhvdCBqb2luLCBhbmQgY29uZmlndXJlIHRoZSBoYXJkd2Fy
ZSB0byBuYWNrIGFsbCBob3Qgam9pbg0KPiByZXF1ZXN0cykuDQo+ID4gPg0KPiA+IEkgd291bGQg
bGlrZSB0byBjbGFyaWZ5IHRoZSBjb250cm9sIGxvZ2ljLCBpbmNvcnBvcmF0aW5nIHRoZSBwcmlu
Y2lwbGUNCj4gPiBvZiBkaXNhYmxpbmcgdGhlIFNJUiBpbnRlcnJ1cHQgc2lnbmFsOg0KPiA+DQo+
ID4gQ2FzZSAxOg0KPiA+IFdoZW4gYERFVl9DVFJMX0hPVF9KT0lOX05BQ0tgIGlzIHNldCwgaW5k
aWNhdGluZyBgaGpfcmVqZWN0ZWRgIGlzDQo+ID4gdHJ1ZSwgaXQgc2lnbmlmaWVzIHRoZSBjb250
cm9sbGVyJ3Mgbm9uLXJlY2VwdGl2ZW5lc3MgdG8gdGhlIGhvdC1qb2luDQo+ID4gZXZlbnQuIENv
bnNlcXVlbnRseSwgd2UgY2FuIHNhZmVseSBkaXNhYmxlIHRoZSBTSVIgaW50ZXJydXB0IHNpZ25h
bCBpZg0KPiA+IG5vbmUgb2YgdGhlIHRhcmdldCBkZXZpY2VzIHJlcXVlc3QgU0lSIChyZWcgPT0g
MHhmZmZmZmZmZikuDQo+ID4NCj4gPiBDYXNlIDI6DQo+ID4gV2hlbiBgREVWX0NUUkxfSE9UX0pP
SU5fTkFDS2AgaXMgdW5zZXQsIGluZGljYXRpbmcgYGhqX3JlamVjdGVkYCBpcw0KPiA+IGZhbHNl
LCB0aGlzIGluZGljYXRlcyB0aGUgY29udHJvbGxlcidzIHJlYWRpbmVzcyB0byBlbmdhZ2Ugd2l0
aCB0aGUNCj4gPiBob3Qtam9pbiBldmVudC4gVGhlcmVmb3JlLCBpdCdzIGltcGVyYXRpdmUgdG8g
a2VlcCB0aGUgU0lSIGludGVycnVwdA0KPiA+IHNpZ25hbCBlbmFibGVkLCBldmVuIGlmIG5vdCBh
bGwgdGFyZ2V0IGRldmljZXMgcmVxdWVzdCBTSVIuIEluIHRoaXMNCj4gPiBjYXNlLCBgZ2xvYmFs
YCBpcyBmYWxzZSBhbmQgYGVuYWJsZWAgaXMgZmFsc2UuDQo+IA0KPiBZZXAsIEkgc2VlIHdoYXQg
eW91J3JlIGRvaW5nIHRoZXJlLCBidXQgaXQgbG9va3MgbGlrZSB0aGUgY29ycmVjdCBzdGF0ZSB3
b3VsZA0KPiBuZXZlciBiZSBzZXQgaWYgd2UncmUgbm90IGVuYWJsaW5nL2Rpc2FibGluZyB0aGUg
SUJJcyBzZXBhcmF0ZWx5OyB3aXRoIHRoaXMgY29kZSwNCj4gd2Ugd291bGQgb25seSBldmVyIGVu
YWJsZSB0aGUgU0lSIGZvciB0aGUgSEogaWYgd2UNCj4gKmFsc28qIGhhcHBlbiB0byBlbmFibGUg
SUJJcy4NCg0KV2hlbiB3ZSB3YW50IHRvIGVuYWJsZSB0aGUgU0lSLCB0aGUgY3VycmVudCBjb2Rl
IGRvZXNuJ3QgY2hlY2sgd2hldGhlciB0aGUNCmhvdC1qb2luIGlzIGVuYWJsZSBvciBub3QuIFRo
ZSBtb2RpZmljYXRpb24gSSBtYWRlIHBlcnRhaW5zIHRvIGRpc2FibGluZyB0aGUgU0lSIGludGVy
cnVwdC4NCkl0IGRvZXNuJ3QgYWx0ZXIgdGhlIGxvZ2ljIGZvciBlbmFibGluZyB0aGUgU0lSLg0K
DQpgYGANCglyZWcgPSByZWFkbChtYXN0ZXItPnJlZ3MgKyBJQklfU0lSX1JFUV9SRUpFQ1QpOw0K
CWlmIChlbmFibGUpIHsNCgkJZ2xvYmFsID0gcmVnID09IDB4ZmZmZmZmZmY7DQoJCXJlZyAmPSB+
QklUKGlkeCk7DQoJfQ0KYGBgDQoNCj4gDQo+IFRoZSBpbml0aWFsIHN0YXRlIHdvdWxkIGJlIHRv
IGhhdmUgYWxsIFNJUnMgbWFza2VkLg0KPiANCg0KWWVzLCBpbmRlZWQuIFRoZSAiZ2xvYmFsIiB2
YXJpYWJsZSBpcyBhbHNvIHRydWUgYmVjYXVzZSAicmVnID09IDB4ZmZmZmZmZmYiIGlzIHRydWUu
DQpUaGVyZWZvcmUsIHRoZSBJTlRSX0lCSV9USExEX1NUQVQgYml0IHdpbGwgYmUgc2V0IGluIHRo
ZSBmb2xsb3dpbmcgY29kZS4NCg0KPiA+IEJpbGx5IHJlY2VudGx5IHN1Ym1pdHRlZCBhIGNoYW5n
ZSB0byBpbXBsZW1lbnQgdGhlIGhvdC1qb2luDQo+IGVuYWJsaW5nL2Rpc2FibGluZy4gVGhlcmVm
b3JlLCBpdCBpcyB0aW1lbHkgdG8gY29uc2lkZXIgdGhlIGhvdC1qb2luDQo+IGZ1bmN0aW9uYWxp
dHkuDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWkzYy9w
YXRjaC8yMDI0MDQyOTA3MzYyNC4yNQ0KPiA+IDY4MzAtMS1iaWxseV90c2FpQGFzcGVlZHRlY2gu
Y29tLw0KPiANCj4gWWVwLCBJIHNhdyB0aGF0LCBleGNlbGxlbnQhIEl0J3MgbmV4dCBvbiBteSBs
aXN0IHRvIHRha2UgYSBsb29rIGF0Lg0KPiANCj4gSXQncyBqdXN0IGEgbGl0dGxlIHVudXN1YWwg
dGhhdCB3ZSdyZSBlbmFibGluZyB0aGUgSEogaW50ZXJydXB0IGJlZm9yZSBhY3R1YWxseQ0KPiBo
YXZpbmcgdGhlIEhKIHN1cHBvcnQgdGhvdWdoLg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gDQo+IEpl
cmVteQ0K

