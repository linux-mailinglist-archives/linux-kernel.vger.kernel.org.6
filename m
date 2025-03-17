Return-Path: <linux-kernel+bounces-563269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271BA63C05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500A4188EF47
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC7156C63;
	Mon, 17 Mar 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="b/CZEDGM"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F41459F7;
	Mon, 17 Mar 2025 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742179802; cv=fail; b=PzvbeO6lpBX0W+lAfiONs3s1hHgBENVHl9UEA3MA49wCHd45/AFQifC3JzFM+DU2epLb8SK3d0R80Bowf5xnSN7fuaoY6ZqyoaY04fUL4KZ/NH5xpX7TTzowXOaWbmmwg0VHNa96B8dF+6PYtKfUibt2UCgI9dBTmSfRmgFIKvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742179802; c=relaxed/simple;
	bh=uJiEEuZgDcgW9HmlAAmYjQ0mIUhZCmgMppvvlQ8Af8o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+yCJmCZ03PZj5eb95sD2nBdfMseXqHhvqGI2sAMMRwqU1qIKBHildpVWXAlWOHykk/RhL4VgI06OJEIPb7ph7c1LhCDbdGSKr81928JBJDmoG5/CkdM0bpPf67oRmxhR4F4h4LEi+GOqgsaHYeA6bfCITtH2qFOKtDsXbOesZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=b/CZEDGM; arc=fail smtp.client-ip=40.107.117.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsTK1Xx8no6VhlD34Hf6Z5PxRi8m9sPRnOlc8n2/1Ujh8NnWRpkfmRKXY0s1UvRNCL6uO6YqTe2/anSj31Nykv0WzorJ/GvMkoftsB5sPuIRIKyCTR66tVzhZOy8E/ZK/8Tqv97DnKaqaIMwiYNqbVRFZU4MGN3JViex9O1jsnFfsuoj6aKBZp+u+FgD/gy8QmOkmYMFCSB2Jf9QNfG5QMxTzmVjqOB5jC8Vd2wns3ndB35KfKy82kB/JLwz4G3wRewnxcREnloAOPxK5Queih0E+Xygx7TQ2i4wrayRJ0lc9D9efSGxj1/lU6vwZBQbztCG4YpxZXTXaZ0yhlP+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxaAL/Dl+9xfqvuWF3I37n1zu7aBd5EpS/v2p9xrqxg=;
 b=GSzVJ2wZxSjrui4L/uo0kJopAWSsk4E3sWYYz2mtzbHK7dqnlv95/F6zUdy1odxrFEyIuFBzuctTQjfCwSgLSsKsLruJuNX0VUhvnO1af3teDWIbCZ6qD5J5CC6SWaKINUep0oQbDDhXazyNN6H2NZTZ+zAsSuAgoej0sed8x4tdWFQq/f8bcHmwhdFJVOhJRGK9zCZEAvlHa8DwGHaMqt4wWeVQtV7mOQgxGIoXKQ91YWSuW524EE4AncpQuK3l5a8vWHf4JtBTfycRO55TdxAixyJLjdAP3F+z4445yZ/pm9LU4gPdUBty13HwD8BnJ8TFne1ME+y6uqtxmLUmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxaAL/Dl+9xfqvuWF3I37n1zu7aBd5EpS/v2p9xrqxg=;
 b=b/CZEDGMhPCsYNn9zGyz2zLuX2jGSuCyq5EoHdARDSAkGzGFZPaRDqZ4lKwIZAAYmVfKCIuK88b23T3ZwrOwJUiB5yS3px128JV+rA0FJutWtM4+UjqXdVYsJVkCIS9+p4bPEawLW2VOiKSNa1YP8hWXHnnf3lirjMOEX5Lncj1R4bf6s08OTIFMnqgG409jDu4Apk32oYAFGLhYAxOsd+e70VeM3Qv9mLaE5lxLWLMsJc6S3S6iWLgq2n2xxrGkxo6rYxKMBAyBwQOr354u4nZPzkRUPiqFxQ14p5HPHPcvC3ikNSj8LcW4vIT6uUr5jmL5Q9J0mFYL/ndXdC5b7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by TY0PR03MB6984.apcprd03.prod.outlook.com (2603:1096:400:274::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 02:49:57 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:49:55 +0000
Message-ID: <3dceafbf-49d4-4084-bfae-74384e187941@amlogic.com>
Date: Mon, 17 Mar 2025 10:49:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: amlogic: Add A4 Reset Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Zelong
 Dong" <zelong.dong@amlogic.com>
References: <20250313-a4-a5-reset-v4-0-8076f684d6cf@amlogic.com>
 <20250313-a4-a5-reset-v4-2-8076f684d6cf@amlogic.com>
 <20250314-tested-husky-of-force-1ccdca@krzk-bin>
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Content-Language: en-US
In-Reply-To: <20250314-tested-husky-of-force-1ccdca@krzk-bin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|TY0PR03MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: ee23cc04-889a-4c2d-b3d0-08dd64fe661b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmhhNVowRnFEZjM1bFhLeTVPVFJZMnRlQ0sxTUhEeXdQWENiNmJDR2hpQ09j?=
 =?utf-8?B?aGd1Z1pvNUcwam5CWlpDZ0piWU94c253Ri9UTlJsVm9lTmhjblgvUThrSERD?=
 =?utf-8?B?dXh3c3lHOVZwZEFQQzdvQXc3aEZCZTlOOFlXZXRhVUxDeldKYzlJMDZ6OWNn?=
 =?utf-8?B?Wjh3SjF2RjNoSjVPVGlLUDVkNlA5S3RNRk83SXlOWlo5SE5YWVNRekxsSGJE?=
 =?utf-8?B?bnVRNU9aVXErU3hPSll1UVRaamg2ZGh4RnY1OXpEQXFNOGJKQmNqTTVMeWF1?=
 =?utf-8?B?WVZST2Jsc2hyK2VzcWRKSENhQlhCWlNPMkxnU2VRajM0S2FJMndtd3hlRSs0?=
 =?utf-8?B?SEw4T3Njd2pWRVYrWjNLYWg4aWtPTFg4bHhMd0huOUJ4djk1aklZN0tqUU9F?=
 =?utf-8?B?QkVpZE4wUy9Eb29iNGFDbjhMYUVrS0w1VHI4MlBIU0lNZ1lOeTRDVTI3eHZa?=
 =?utf-8?B?dlZsOUVPUXpFb1BVbXE0eFBhZ29uNVhycVdSbzN4anduM3dkSHc5L2tscHNj?=
 =?utf-8?B?QUdYNHFhSUNoWjcvem9Ib2ZzbGZ5V2tweDdqU3d5ZERwTlExaStIQ1liUzVk?=
 =?utf-8?B?VHJLZEt0UU9GUXFFbDcycTQ3dlE3M3VVYXBoTTdsd2hqRFZxWXpCUTlGQXlD?=
 =?utf-8?B?eGFWS1Z5MkgwM2pLMy9iV0FRQ3RJSFdmWEZSclVzeVQwbitPcVZvQmJUelBk?=
 =?utf-8?B?L29CcmpJWmJJdWpURktpWm85T3pVZXVTeXNhSFFVT0RoZzdoUDlMbFFaNFdI?=
 =?utf-8?B?Mm5CVy9qUnpBZy82MnpUZHhDbnhNZ1BYU2hDRG45SGhrUjZQR1BsTDQwWkxo?=
 =?utf-8?B?SHovZ2E0bG81S01VM1RzRGpJVWZUbEtsSkxCOUtjK1M1cUVhNENxOHBicUVs?=
 =?utf-8?B?OG9WSXRrdG56R0FvNVREMWsrWjgzenhUeGw3TjE4NGxCVEJ0SFlTdVNNOStG?=
 =?utf-8?B?Mk5taEt4cGgxTmdKSlprZlJPODMvanN6YzNSbHkveWdxMDVlaHRiWlMrNWh3?=
 =?utf-8?B?Y3ZjTUdvOThYVkpvd0RReVY5dmFBOEhSbm1WMWE1d0JGT0VUeXVScC9KdVhC?=
 =?utf-8?B?NGp6YTlOV3J2SWV3TWRVdzR2MS9ESjBpT0FDMDNHeXRsU2VGa3FUbDVJcW5S?=
 =?utf-8?B?NWlSaU12Q1JKVEs0ZE5zYW0wOWkyQTRFdWJMRFE1UXdURGkxdW40OEZZZEZR?=
 =?utf-8?B?NExBeHNGdy9aVGl1WEVsaXgrOWZUQklnZ0NORFk0WkdBNlo1NmcxOUhuaXc2?=
 =?utf-8?B?akJHd0Jnd3dVSnBySnV4YWFqK05VNkZ6aEhsdGxTQjlJOWFOQUw5Zk1LY2Zh?=
 =?utf-8?B?SUVSRGJlY29LWmQxdGNNclpHa2dvR0R2M3Mwa2EzVFhLblQzVDBOTWhoWVd3?=
 =?utf-8?B?bURHSldMUzhWUm93R21zYmdWNmxRNmM0amNxb1dsSWpWems0UDVBU2xIK2N0?=
 =?utf-8?B?NWo1Nm5VWnhMY2tOMjhGdmNnbk5VYlJOenV1cWh5T2hvdDdvbG9jWFg1NnZo?=
 =?utf-8?B?NWxOd1ZSYlNBZk4rU0hpZHJ0Z0FtWXRVOE1DeFFVRjRZL3Q0Szh5N0xCNGdY?=
 =?utf-8?B?dlAycERxYlBQNy9saTRkV0lPM0VvYkFkVXF0U29Cb04wemtmT0FVQXZCMlUz?=
 =?utf-8?B?Q3pYSWtpbFh4YytKbEdKY2FaTlhybEQ4RTQwYzAyNktNVEV3YW0vQ0NXSXMv?=
 =?utf-8?B?WWxCYWdVa1hPTVBJU1JMYlhYVE5McTcrRmRBZ3pjRGJDMnlYa2x0c0lBSGkv?=
 =?utf-8?B?VnZFTGx4Y2t0Rnd3R1RPUVUrWTlZdHlhbCthNFFYM21xMmF1N3Y1VVBKM3B3?=
 =?utf-8?B?ci8wLytETThDNXpuT25sRlhuN1lCVG1QU2g0NEhUZC9XRUZQWjlFWEZKbmJK?=
 =?utf-8?Q?6MypZp4P1qvZl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmFKY0VqWk1mT1JiMmxaUXB0Z1hmc3ZMekhqOG5mblRxNkt2YVFOVmNXd0tw?=
 =?utf-8?B?dGVjZmFyWHIySDZtYTZlWWtMMFR6c2dqZGZqblZZWUlDS09hVDc3cEg2Mi9G?=
 =?utf-8?B?SWVjU2EzK1IyZkMyR1U4azl6ZTVIQkJYU1FwZ1JqajVYcnoyZnBwV2daaGlP?=
 =?utf-8?B?NjNZa0tOSXBpK1FyN0Qzekt4THFRQU5yOHVObGNhR1lwQXdjd1FVVWJTY3Zt?=
 =?utf-8?B?UUl1dFNMSkNINTV0RVJ1KzJmdXphM3ZmYWEyUUNWZlpSamlTY2RCN0YrVHF2?=
 =?utf-8?B?TmhMeFdESHpRSUx2a0pkalpGaGl0cGNMMzNBTC9ZSXZVQlZZNU5FWm9TeFE0?=
 =?utf-8?B?cXpZM0s5T21vTGU4VDVJMk1LWTkrNFZseVgxbElwMWcrMnk4UXgvODJLRCtH?=
 =?utf-8?B?YzA2bHhiYU5xKzJqcCtNWjIzSjB1aWtxUmNJMFc5ZnNwQUs2cW9nUkFySTd0?=
 =?utf-8?B?cTRZTzBRSmUyYmJ3OHZzZFErV1RuMHJSeUN4c09NbWs1aGd3VTJoRFcyVEpD?=
 =?utf-8?B?djhPR09aYVlNWGk1WjJhREZQVFBzejF5cmsyTGRSZTFCRE56OFB0NDhiK2Zs?=
 =?utf-8?B?MTgxK1RiUjc4NVJLcit6SjlaVGp4OG9rMGRFbHhzc21KTzNrb2dvZHZLKzZU?=
 =?utf-8?B?R3F6S05yd1d2ZzlQNnBJbk9qcTRjT2lQL0I2YkovWGR5SDhvQW0rVzBWWjVU?=
 =?utf-8?B?ZjdMVXZkb3plWGNERVVpT0djc1lKSnlKbTdvRXlwZ2h1UTlKRUsvc0Z5WWVs?=
 =?utf-8?B?cUFlTUlYTXpGNDB6T0hMVUROMnFENXBzNEF2YWxXSTRpdEtPdDNlSlJIc2Ex?=
 =?utf-8?B?dmVzZk5mc2tzejVocXNYVENCQXpJK0wyNnNYRnJjZVJRZ21reVFtZFM2RGVR?=
 =?utf-8?B?eU9GdjFmYWJ0RnJyaXgzcEVFMUJiakxJMDVLMTBNU2lkMlF4TGdEMU5Va0Zz?=
 =?utf-8?B?RDNLZk85dERiS0FmWGFCZWZLTHh3Zk94cUFLU01JY0w0VnIvWXJHSzRSVmJ4?=
 =?utf-8?B?L2lzTjRhUnRMK0psdHpDRUh2Z2JaenZsZEhtamNBVDJHNTFRQlYrQTVjUlJO?=
 =?utf-8?B?by9SeE5EQkMzQTA2eXRodnNHVFVmRFNXUWl3WlZETm45N1hYMCtldERYb2F6?=
 =?utf-8?B?LzI4emVlbjVqbWh3bXZoUFBlTEJCWDl1aFc4UkdLUmhoNk82KzB6VC9HRHF2?=
 =?utf-8?B?MW8vN1NXOTYrR2VDUGRqK09uYXFURlR6Tm9SeXJGckNQZ1F6MWtycm9TNkFw?=
 =?utf-8?B?OVltM2RBcS8vM0xTMUhOZkZJN29Zam5ITHQwQnNGSk1VRkFVUXBRVUJYM3J5?=
 =?utf-8?B?N3dGL1paTGhTaGt1dGtSekRkMEdldzdaQ0lwNUFNZlE5N1FnMFNVM2VDUzFE?=
 =?utf-8?B?OHFiTS8yQmI2RXBPN3I4TFQ1SU1wVDV5UC9hQjJtc3d4dGlublg2L1VvL0s5?=
 =?utf-8?B?OUZFa3VVWlRRa0k2T3NWUkxMVlFqdTBwOFh0VHFrMnplWmpMRFZIVEtDcXBB?=
 =?utf-8?B?WFBqemZEZ2xURDRrUVh1ckNBOUZzTGJJY2tLTUtMb3R1VStFQS9vN2V0Smls?=
 =?utf-8?B?TXpDbDVLaHBHTUdydXd6MGU5VzhVVFJXSHhuWUhkN1dZS1JnSm5BVmF3YnZ1?=
 =?utf-8?B?L2VtT1hFMU5TanlOb3NEVUJDeklmeFdueEdaUEp6TkZWekVyNGlEUVpWRFBn?=
 =?utf-8?B?YlVSU3FNejdzZnJYUU0xVjFQTjd6dXJKZHAzbHZxOXdKdmhzQVM2NHdyT2lR?=
 =?utf-8?B?c1hLc25CV2hsQVYxTkd6STNjQkZBUzhtNzBmYjUrc3lncmErU091VWxjUWxy?=
 =?utf-8?B?bDNselN6dUl4cXJhTTFaejBhYzZMMUlBY2ZlY2xJNE9Od0JzNCs5akF5TXBi?=
 =?utf-8?B?bEdOTlZBbHAzMDZKMDgwb29kWEZCZCtLbXRUVDFMeFZQMnVjL2VSQ0pEZ1Ey?=
 =?utf-8?B?ZHp1SmNqYlg4S0c5b1hDbnc5SWpTYTJTWjJOcDZoTnJIY2diZ0ZrTEtnNG5h?=
 =?utf-8?B?MGlCRHRCOHJEVWs1Z0xkVmtlemlLZW5sUHBkdHpEUkdtcmF1aHhTU3pwcktK?=
 =?utf-8?B?SUVwWnhKd0I2L05oQ1JlM1FtWnVZM3p0NUlzTXZ0YWVJeGZrRGZCN3VEZlUx?=
 =?utf-8?B?RFN2eFY5R0J0VEQzSThodFFYUjQ5emowZWdKTmlkSlZ5engzS2U0L3RyeVRh?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee23cc04-889a-4c2d-b3d0-08dd64fe661b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 02:49:55.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJEPTGhLrLRmfLV3WOrMnAZU1lX5cFdT91AoMiPvakvetK/QoAhTCp2KXyHOrRaYHrHVGOaIDJuAZArd3sCL1h84xpgMroRaRCAC0U/VnVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6984

On 2025/3/14 16:01, Krzysztof Kozlowski wrote:
> 
> On Thu, Mar 13, 2025 at 05:05:35PM +0800, Kelvin Zhang wrote:
>>   &apb {
>> +     reset: reset-controller@2000 {
>> +             compatible = "amlogic,a4-reset",
>> +                          "amlogic,meson-s4-reset";
>> +             reg = <0x0 0x2000 0x0 0x98>;
>> +             #reset-cells = <1>;
>> +     };
>> +
> 
> Why do you have on the bus devices with bus addressing and without it?
> What sort of bus is it?

Are you referring to the 'apb'?
If so, the 'apb' bus is defined in 
arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi.

apb: bus@fe000000 {
         compatible = "simple-bus";
         reg = <0x0 0xfe000000 0x0 0x480000>;
         #address-cells = <2>;
         #size-cells = <2>;
         ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;

> 
>>        periphs_pinctrl: pinctrl {
>>                compatible = "amlogic,pinctrl-a4";
>>                #address-cells = <2>;
> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,

Kelvin Zhang


