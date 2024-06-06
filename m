Return-Path: <linux-kernel+bounces-205163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E458FF83F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D77C1C238FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2911813E03C;
	Thu,  6 Jun 2024 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="PWUeAAVu"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2098.outbound.protection.outlook.com [40.107.100.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54A49646
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717096; cv=fail; b=fVXcqlrgRuE99WRvTHLo0kDw5VHvsMLNnEk83Fkn+/KAnJTB46F2O36pHnIPIAFILjv6wynxO8kFIPxnFNJXRNLHcLXOPchQiVkZKn4JhejtgFQAliTdFsIwd/OxqKunXclMyEfV95aGrjxiq69HToJrdtHHPJgf3KzevEDYvD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717096; c=relaxed/simple;
	bh=6Ndwaw6KD8DyIyo3icVCF2PPJ17YKWdSoxeiMB2RVjU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KQR+vuYIMMXD+E59qRN+/bmmGSNKaGwzD1do6RAyxysiVXFpQJ13pCOHSYfWSkhk4iHnCDbqNu51bLlKR97+xa69xP9IVLBVMR1nxWKwGtcFkLJaIbVf0dFGME2NPnPaEH498R9Q3qfoYljcrow8O0/KjJ8nQw5iZ8lcLRX1j+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=PWUeAAVu; arc=fail smtp.client-ip=40.107.100.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwdcgL0Q/lserNCapg/OzWXEHXpSr1ULwjF7aaCaXbfCRbZ28tc1GY0HOUl+Man6ArOWAPdu9naVkmLDfOKAiQz5rPxu72EtFynv3GJwnBgagZJ9M9xKchMHOYVuHd3r5u/69N3SfqwnM2zKeCG0eU61UxjKEwvmJiv58yvv1ubObwcfA/fNQEBYsvYxuKCgEdSS66yWV9HoVDrvW3y9+M/Og1pmQJkWegBYUBpn8qzZqHFR6+BuK4Q/pG5F1RACGn4n7ddp3MQUZ7lL7HJ/IZNKSLfPjKOnjFi9jVdsFT9P+UQXYhol0LOmgL2uWVZspL3hbpAwb4ad1EriLRx0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZA3ApG1I7aIwYN47QXucy0hzOUXacrzH2pQroVKs7g=;
 b=VE8rv0ctChPaceAyatXigAK9ORgRW0zaTHkXTZFfo5kybv2UUf/cXLYsPU607GFX1V/ECZWOMkC13Lbc5IeNGvFSyFdAWbTJqzD1iBSqMKjqPZN0W1GNGJHtwqDbtnuG0PZkw0aMLQqfmAFgqn6fHOC0hjKT6+ENy6+XiG5eOTMM8y1MEAJFRwiudEeWDUZhOFsXx8+vNLPfvjqvCMf0Min9ZRolYAGOPWqNg8urKWoRlx+WfCDwCiaQ/oV9IcaO9BVpRxHvcMYUPFAqp9Skky+WJRGN6J6N3c1S7CWFMgJch9Oj99TUokvyNf5d1bnJwKO4ZI/U2pDy7TCwkVRv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZA3ApG1I7aIwYN47QXucy0hzOUXacrzH2pQroVKs7g=;
 b=PWUeAAVuwvgnnRCkiqQr/x9CSBmLaIwiWcUNcTSLKpGmjCT3HOrxl9rMopRpwa8M0YJQ8jxrr5oKKzNunl+seLr6OeDcUxIlR38+JRh+xtEiXHfsS3b1fiwnE50jZ07RRHcZu/D+8zdGouRIUX8K8Sjd8HqogOFSiGL0pBegy8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by SN4PR22MB2853.namprd22.prod.outlook.com (2603:10b6:806:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 23:38:10 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%3]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 23:38:10 +0000
Message-ID: <91d65552-a5ad-4daa-be0d-7a3544ec9fec@phytec.com>
Date: Thu, 6 Jun 2024 16:38:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable TI LP873X PMIC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com,
 geert+renesas@glider.be, konrad.dybcio@linaro.org, shawnguo@kernel.org,
 neil.armstrong@linaro.org, arnd@arndb.de, m.szyprowski@samsung.com,
 nfraprado@collabora.com, u-kumar1@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 upstream@lists.phytec.de, w.egorov@phytec.de
References: <20240604233836.3628063-1-nmorrisson@phytec.com>
 <1bc38042-7034-4937-a2e6-2dcfd8c2d609@linaro.org>
Content-Language: en-US
From: Nathan Morrisson <nmorrisson@phytec.com>
In-Reply-To: <1bc38042-7034-4937-a2e6-2dcfd8c2d609@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:303:b7::11) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|SN4PR22MB2853:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1987f9-c553-4999-b604-08dc8681b98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3pYcVdWelQzWldjV2E2M0VoV3R4WEp1MTYxUkdDV2tHV3hpVnBhNW40MlhJ?=
 =?utf-8?B?VythWVJxVkZRektvWWhLWXBBa2FzNVdGSi95TlBVaDBwYWUvaHdvbG9EZDd4?=
 =?utf-8?B?bkpiWk5SNzVaK3RFL01QNXdSM3NjR0NEZWJaVGVsU1FURmlTc0JOUGkzbXc2?=
 =?utf-8?B?VzZndlRlcmFhTWlNMWp1UnA5bGxndjJFak9EZVkwUkcyUGZMeElFTEU5NWJM?=
 =?utf-8?B?NzNkRGNPQ3l6RVV2VHRUTkprSUFpR1NjbXZoUnV4YXJiVFU2SGZkVUVQY0s4?=
 =?utf-8?B?Y1BUSGNtMDYvajZONmFKeTdLY0dnRFdRbnA3L0l1VlV3cVZlb1B0TDU0ZEhQ?=
 =?utf-8?B?c1R3TjFjMHNXT1RObm82dUlZM3RBWTNmNEl6c21jSklZRlRWWmk1d3U0T3Yy?=
 =?utf-8?B?YTBTK3A0M0NycDFuTmQ1ZG9LQ1NTeGVYQUJhVEtrbWVoU3ltNUVCblpPSDM5?=
 =?utf-8?B?bmw1bGhDakxVL3ZjaDZkSitYcGVVVkd1NFZJRGtsS1dBTFA4R1NWYjhHdjVT?=
 =?utf-8?B?YWNZR2JSMGdlemdzcnY5UHRBeG5xeGNNVkpnQm00T1Q1VC9YR0pWT2xNd0I0?=
 =?utf-8?B?QzhJTVlxU28vQTJmSVVIMUc1d1hVM2NVc3FFYXlKeFRya1BNald3TWhzTE9Q?=
 =?utf-8?B?ek91YmRYY25TRDNHNkFYaUxLZTFPdHdpZmUrUEJPQitBcTFtQUZxWWxnWVFP?=
 =?utf-8?B?ellPS2doS05HSGczamNKMHdxc05HRGlCTzJrOWxkYkI5and0aGk4ZHRQSGdz?=
 =?utf-8?B?ZXFseWVhSVFERlhGcnRzVVJ0SStMK2U1TmFqbjl0ZEF3ZGRMTUtRSS9CRHg5?=
 =?utf-8?B?QnlEbGJmZ3VwVlNNVjlUbXNheGhWRHBNYS91TjZTMDJ0eUVEcU14WTNEdytp?=
 =?utf-8?B?aWJpa3dtVzFiblBNTHpNNVdWTldyMzRLRkNVd01nek91Sk5HUFg2dnpobnNR?=
 =?utf-8?B?bGpISGxUOVd3dWJlMFBDc0hERUNhMHZWZHU1Q0VUWHY1cXFEMnhCTkF1eW5N?=
 =?utf-8?B?TG5MZTRiSlMwZVZ6UmdPbjk1d2hRRFErUkZtSTdqL2pxZkt5Y0M5MUR3MGY4?=
 =?utf-8?B?OGxRNXpuNEtwUmZ0U3hzOTRrVGN5ZDRPQjRuekVNMDg5SEVTajc0SlNhMHZo?=
 =?utf-8?B?M2JMS2V0amdBRis5eGh2SjFnNDhkU213STI2RU5KUlA1UjRSZHY1NlZBdDEv?=
 =?utf-8?B?Q21QSGxFRHJZTFRQbEtTcUlrOU8xQnNBVzZzbG1jdjk1Yno5OTVDL25wSDVX?=
 =?utf-8?B?RzZXcUtVQ0RiSnRQNkwwTmI4d3M0K25qWEhLaU12TkNYZzFYMGZYanVIbGpW?=
 =?utf-8?B?VnJCaDRiTUtuSVc2TDBVd1V4V1Q2QlIyZ0lZR2JpR3VjK1pndW9qeXdFK3Vl?=
 =?utf-8?B?M1lmbXZPQVdlWE5LYW40SmN5cmtmMzQ3bGc3MXpmNkJveXFLZ1pyMFhLcURD?=
 =?utf-8?B?cE5GeUdBQW1uWmUzWFBZWXJJZ1JxUEpLRW9CVFZpaC9DcWlWY2tsTklEYWoy?=
 =?utf-8?B?QmVlbnlMT3pKdUNaUzJ1MUNROGFPZDhjL0htWGUvalRPR1RLOXdsbk0rdjFo?=
 =?utf-8?B?QzhHUDBCRm5CMk5SY1g2S0ZQb0p6Z1BYYmVjRkNsQ0l1WVlZQi9UVGU2dDMw?=
 =?utf-8?B?b3RhWWVQQVFBam5yTFNINGlLbDFHVm56Q2hJNWU4dE83WE40TmU1aloxYnU4?=
 =?utf-8?B?OFFGL2tPcXJDdGlDdDhreUNIeXF4amh6NDUyQnY3bS82Rzd1bGhpditOMlZn?=
 =?utf-8?B?MlBUZ1dTT21oS0ZnK2JTcmE0RncveURtR05LWXNYL2FUbG04dVdtZFVNRC8r?=
 =?utf-8?Q?1hoB4plqZBkn4rO8JnvaJ2n/eLCF0TmWBrd8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXlLd01DU2tBZEFwWTdrckY1aHZhZDVKRlh6SGZUMGY1ZHdNMVkzMlBPQVhY?=
 =?utf-8?B?cUdDOE13ZUd2dklsbGtCUUd5NTlBcCtsMHUvT08xbmRvWm5xWGFHeEJVQnlU?=
 =?utf-8?B?WmFDSUx3Wjg1WmM5YUI5Mllybm1DdWtvdXRIbkhLTWdvOFArK09lT29rTUo4?=
 =?utf-8?B?TlZBOUZ3K3lpVi8zaEwxRG9KMFNjN3NiL0NxM0NqSXg1aEJsWUVnTnprc0Zr?=
 =?utf-8?B?V2FpdFFNcEgzS1NMSnRRNHN0clB5NHlkeGdZSndqTFhuMEg0MjNZUkpMMFJn?=
 =?utf-8?B?WUpOMTFjOS9tUWxJTkRnREpKcjBXVGhVbkZQckhWYVQ2NlFFaUhwQ2w0KzVU?=
 =?utf-8?B?MVdkZWxMNUZRV3RtalZJcUhzWWlwbE41b3VBbVVrNnBNcFc0bFVYZ0FwcUFn?=
 =?utf-8?B?VjZuZ1ZKTUNIVlprVTRGTVdmRldJYVNsOHE2Wnc4dzhudStUSWhHa1B5Q24y?=
 =?utf-8?B?bWoybUtMY1FOL21pY29Id29yZ2lxcG5EMG9Fdi9uL2N4MDBJRy9sSUZQWm1m?=
 =?utf-8?B?eVp3OUg2SXhkVEwyeEZUcHZiTWJmSjBMUksyVkw5Z0g5Y21tMmlPek9BTWRl?=
 =?utf-8?B?TmpXc1BIMXR1dkZCd3JRUHZiVU5sWjd4YUk5OFRFWUNpMk8vWmt2S202S09t?=
 =?utf-8?B?ZWRJUytkdmI4OFlpN2s0cm1wMlJoUEwwdUtkZDFaSU1velFlTUl3LzQ0cjNF?=
 =?utf-8?B?UEdURjZsVUFFYktiZnc5YmFHNzNkMEY1VldHSk5RNXNxSkF6a01yWWgrK3hS?=
 =?utf-8?B?Q0FJb3JqUjFnajk0dEJQMllFQmNWK1NaVEFYQ0xsMlEyWXB6blo1M1EvRjFu?=
 =?utf-8?B?YktoclJ0Ulk0eFA5WDBwRzBvbnZ6TGRqcXRDWjd4SzRsZDRYaUdjVElXN2c3?=
 =?utf-8?B?SG1GMGhWSGIzdS81ZW8xZE5UQmJoZVhuRzk1U0M1dXpjcHRmWVFXZmZLTU5D?=
 =?utf-8?B?a2RrdDJlQTQ1cVM5NUxaZG1mMFFBOWdaaG4zZllXTW9Ea09JWHBSekkraGlQ?=
 =?utf-8?B?UmM2TWJtT3o5QnB3SXJlR0h1RmVHVmNIV1ptWjFJTTR5bGVrWmx0U25aTnk5?=
 =?utf-8?B?eXk2dUMwLy9BeHlZNFpwTitOcTRBbmswRkppU1RPaitwbEhjL0VrMVVkOXM3?=
 =?utf-8?B?TFZ0Y0l2d1kybnlaRmNzS3ozeXl1VW00RkoxeURQdFdickZoZnJpYmVNY0tl?=
 =?utf-8?B?UFQ1eU1GaUhXbGw0OWNabDZuYTJPZXBLdi9QTk1zWFVUS2E3UXpYUW5jUVBI?=
 =?utf-8?B?bEVwNUdTSlVwZmtJMWFVdmFPZnZ0ampoTTVhSTJrM3JBNHV0bDBhdXJTMGxD?=
 =?utf-8?B?N2xEZ0c4bGJjRDBWUWxYczhRbUsvVU5UQmR3ZlR0blg5RGdSQ1plaldYdnpT?=
 =?utf-8?B?S3llZ2xIR1Z2b2pwNlFLLzZKVjJabVNuaDhHZTkremw4WVM1Q3J1L1kyK0xV?=
 =?utf-8?B?alpIOU92NWV0YzlvUUU3d216RlhGK3FUL0MxY2MwbStGVXNmYnM0R2NucGph?=
 =?utf-8?B?cCtHeFZHcnJnbHRZbExEWGpQVGxUdXYvNXdLSFdVbnl4OE1Ja1pOYm5zTGxv?=
 =?utf-8?B?dVphL3ZBMVVtK2hTdk1FckdnZnBTZlF5bnA2V0EwdVAzRWlSS3l2RzBLNTFN?=
 =?utf-8?B?c3MyTDhpT01TUTBxN2NpblVxdUpkZmNmcWRMWGJWUFkzYWJITFEwazFSc2pM?=
 =?utf-8?B?aWp2ZWNmVXRSYW90Z01EcVZlK1NUelNyWGpmMEVGY0pKNy9CbHgzTHlwa1pu?=
 =?utf-8?B?cTdMM2Noa1FlYldWTXB1bTVZME5oaWRyUDZjNjgyc0s1a0FibUpvOUVheUkr?=
 =?utf-8?B?bEV1QUk5b0tqOEoyWnJnMGVuMUM5N0ZLZDU4bU8zWW94bHRtY09WRS9Qd01G?=
 =?utf-8?B?NGg1bFU4OTlBZmliZ2p6VXd3QnFhWUtXdmtiVk8xZU5pSEcvcnNIK2NITHow?=
 =?utf-8?B?TitDUFlRcWVKaVpjbnJsdUoxS1JJRTk1cTl4QUIxdE5xcFNEb05xMUxUanEw?=
 =?utf-8?B?anRwWjJZT0x4UFgxY21JamtQaFpPMGF0UHhiUnAzNWhJNXdzT3JrbTB6cFZZ?=
 =?utf-8?B?aTNDdm9hemUzUVc4WTNBYnZ2SHRiVzVTVTg0M0JZbk1YVnFPUVFUS28yRGd4?=
 =?utf-8?Q?kkl0JychiQ1pknIsriVa5QNmb?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1987f9-c553-4999-b604-08dc8681b98f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 23:38:10.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6ZR++PewYpDRQ/lM9WL91XF/G6YfhaPVPYQbW3bXLjnfxoyrRFeGjYHVT4sWE/8DbrSF5N3soU14OlOLAZFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR22MB2853


On 6/5/24 12:15 AM, Krzysztof Kozlowski wrote:
> On 05/06/2024 01:38, Nathan Morrisson wrote:
>> Enable the TI LP873X PMIC configs.
> Why? No user of this, sorry. Please explain in commit msg why this
> should be done, e.g. which upstream user needs it.

This will be used by the phytec am642-phyboard-electra, but the patch 
[1] has not been accepted yet. I will fix the other issues in a v2 as well.


[1] 
https://lore.kernel.org/lkml/aac6a41f-a384-43c5-8eb0-722cda74b4ea@phytec.de/


Regards,

Nathan

>
>> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
>> ---
>>   arch/arm64/configs/defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 57a9abe78ee4..24ea62a8fdbf 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -745,6 +745,7 @@ CONFIG_MFD_SEC_CORE=y
>>   CONFIG_MFD_SL28CPLD=y
>>   CONFIG_RZ_MTU3=y
>>   CONFIG_MFD_TI_AM335X_TSCADC=m
>> +CONFIG_MFD_TI_LP873X=y
> Why this cannot be m?
>
>>   CONFIG_MFD_TPS65219=y
>>   CONFIG_MFD_TPS6594_I2C=m
>>   CONFIG_MFD_ROHM_BD718XX=y
>> @@ -760,6 +761,7 @@ CONFIG_REGULATOR_FAN53555=y
>>   CONFIG_REGULATOR_GPIO=y
>>   CONFIG_REGULATOR_HI6421V530=y
>>   CONFIG_REGULATOR_HI655X=y
>> +CONFIG_REGULATOR_LP873X=y
> Why this cannot be m?
>
>>   CONFIG_REGULATOR_MAX77620=y
>>   CONFIG_REGULATOR_MAX8973=y
>>   CONFIG_REGULATOR_MAX20411=m
> Best regards,
> Krzysztof
>

