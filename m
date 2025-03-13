Return-Path: <linux-kernel+bounces-558718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC54A5E9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F823B7D55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617013AA27;
	Thu, 13 Mar 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rz8lXB29"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3912B17C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832732; cv=fail; b=jhuig0AEpSP3PX1cWDl+kFtviutTs1UoJPN9tFHonzYz61riMNtcqe81jxPuiePsda/SBYmeWRLFkZw5RJmBptoC75phDdR+988DO0D9Rqz2pBWTxg2KBOpIW0lfXWyBsCY5uB2Ny4VVX3S005JfPVAPX+H3wN2JMdDzNZYDhKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832732; c=relaxed/simple;
	bh=CUjlZN7T5Ry2hiQ64Jn/ex7joh3pCFkDG5Bkjh1kmLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nhI1asszMWVbc8fQKhGqN4sEV+mJiNjMIJtaVIze3mbUTfR5rhIvCdcPQGiQS9Rn6F9ivHca268QP0fFY9MyORE+r9lX+889J4XhucpErX/bJER+yrI0j8vr7y3WEQNkfYLuG6VtapvTxwMMNCzuNa0P9eTuIc87mVU1fzJJ5bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rz8lXB29; arc=fail smtp.client-ip=40.107.255.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlayNjKgeJ2jblx7OwE53kyWqnRlXatPFIFP5trqSGkM2n1sM7oQEo3A2jsXIYnSszYqmuKQg7a3bJdkoEq6fZC+nqMF6AvRg8UkHAGaPcgd2l2OlF3NEtFUVaxEuLNJAU6d+m8Kt5nzooEdsYWqEUcTqZLwnCz5iQJQHY2xstIzK+5quLz/wmPOAwmJSmmtZQAVLU+MEhmK7txwNGQFJsr3m5AUc31SUw2VfbCnBT6Iy+FPqU6cO2yKbjuSp6EBSYHxPlGg3kiZTFVog3AHzG/gsXxmF50ojcFsDFeScyo7x3MJIQDuQBtzh8PvH3k98yChP1giOvFxWdpIDLD4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUjlZN7T5Ry2hiQ64Jn/ex7joh3pCFkDG5Bkjh1kmLM=;
 b=Fql/rAheKOyY9VgRneH0N5sOFLSf0iV9mjgy/WVi47MrXMn1Trs6Ipd0lVEDc3pyzzl765EjrnDcVerWFYHL2L9uAtZ19W2oNz/nRXOuTsTFRntuRkHxRDo7KIk1ga8BiVe1PppwziBu2vkZJVJ2m5/DtvPOvAIhNrBohJgklrrGIubknZX2iPJf9OnHXza1gISuHgHFJz/ajIoq3G7aihnadUfqqnOV5Zdf1mCWGp7WZidvV8DO7bVuHydBE934lRlbnjj6LM4oK1wm816d3Fg4nqMHbKLGlmzlExUR87jlMWLh2ONxc6i0BXKkwZPzsln+YiIEpRJG4tJC9zr0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUjlZN7T5Ry2hiQ64Jn/ex7joh3pCFkDG5Bkjh1kmLM=;
 b=Rz8lXB29qXlq8EsKEMZihLDjKl+vJXdsi6VLVDJssJnPBpXd4jryG6Bmdv/lZxOSqac6VLV0RStuCuMLJD/VcupLes7x0OpLH2qiZSWT5NqbNuwCYeHGF3D8iSssA9coXylMdudxDRSkxbqCh5KNecT8ocUYs7rkMvzXilYrWhOJo6VWivRD6qoGuNe1Umw90NioirLdnIXwV1qvl9rwtwRFZeQGg6yzzvoUAoRGVljPRxXTu9pyhJpfjP6gBxbIkeJ+Gx6A6ySB2IaTkYo6ENBrQiP2HuKv8AgovKw6o1Tbo9tmj8iz6rmrYYugSubWWPji+wL0PwhgWYU8+aP2QA==
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYUPR06MB5911.apcprd06.prod.outlook.com (2603:1096:400:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 02:25:26 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 02:25:26 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Chao Yu <chao@kernel.org>, Chunhai Guo <guochunhai@vivo.com>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] f2fs: fix missing discard for active segments
Thread-Topic: [PATCH v2] f2fs: fix missing discard for active segments
Thread-Index: AQHbYo97IM4VJ+ShM0Cx72FTZCbyqbMfp5AAgFERrQA=
Date: Thu, 13 Mar 2025 02:25:26 +0000
Message-ID: <95b8334a-45e6-496a-8b0b-ab7a7fe180b5@vivo.com>
References: <20250109122755.177926-1-guochunhai@vivo.com>
 <4270b213-e4f9-46b2-958a-df3dbaaed969@kernel.org>
In-Reply-To: <4270b213-e4f9-46b2-958a-df3dbaaed969@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|TYUPR06MB5911:EE_
x-ms-office365-filtering-correlation-id: 02feb010-d477-4d4e-69f9-08dd61d650fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlFtb3NGeENsbWMyTEpDSGZGZkpDOTVveGF5czBpV01LWVBqMVIwZkxibWFO?=
 =?utf-8?B?MTJvSVptbkV2K1NLOEV3NGxINmFnUlZYN1M3ZTZpbXRKZlgyalhvNlFuMVpq?=
 =?utf-8?B?SXFXTktWN0VjTmZ3elFoUnJDOGRmTUJYbU8yaHh3YStLUkVZSnV0Z0ZnakJ4?=
 =?utf-8?B?UisvMVhiMVhuUjJkM1RkL1ZWSk5hUHpMbCtpWkIrSGJ4TWFqZGVONjZ4LzRC?=
 =?utf-8?B?dEVHWWhZVm5LSjAyVENpMUtIYnZJV1VVSmlGeG9XM0poSjhxOEQ0bzlyeVhM?=
 =?utf-8?B?KzFoc1lWdTBrMVdNcDVZQXNKcmFvOWwrZlk2SXVESjJ1Y2ltYURsUGhFWkhq?=
 =?utf-8?B?L0N4cmd1d3NoMHhIWnlXUk9pSDY3OFEzbjF3UUhld1VjaC9CeG11bDR2V2o2?=
 =?utf-8?B?TWM2NnprWEpRaDdESnZJTGlhczI3MVdOamVrcUlWMFUrSnRyTVkwOSttVVdI?=
 =?utf-8?B?T09Nc0R4MVMwMW9HSTEyRHpIQkw0Sk42YkswbndBOHJoNXhQZzRSc2pRRjdY?=
 =?utf-8?B?bFY1akQ5UjFKejROckc0WmVDb1VtV3Nxc1VrSXNicWk2Z2pvNWF1Yy9VYUtT?=
 =?utf-8?B?SGVNTEdqWEJOY1Ayc1RCMmlmM2E5YnN2b3RxUWx1L1JJMVByLzNuYVpJdzln?=
 =?utf-8?B?cU5yMDBIMy9CZEc2WS8zdXhuOGdPcjJxQUZ5KzRWeCtmdWlmNDlNN29TYzFQ?=
 =?utf-8?B?K0xsaFhjaUpURVYyczdjaEgwZWpGUUJZM0xkaHpFWVlVSGJ3QkdWTUR0RzV6?=
 =?utf-8?B?UnFmNkZVY0YzSWQ4MlFiNE4vZUZxd0hEdjZhZm1KOWpYWVBScWs1dGY3Q1Y4?=
 =?utf-8?B?TXhOTFI2cXJwS041bkZ4bStvK0pwWmdITk5Hd3B2QmFWM085S0hEWlVWK0RG?=
 =?utf-8?B?UStRNW1wSVFuMllkckFnd3lBYTVHanFHbTlpdThiRXN3bjJKSXN0MFBtblJY?=
 =?utf-8?B?L2dBSmdhNzlSdGs2UWZFcUZNZ3gvQmxDOXIweXcyOTJtWlEreitlbk5wYllF?=
 =?utf-8?B?TkF2dFY0cGhHM0pWSEgvbHBadnljUE5rRXBHOC9vQmlXWUFUWTQvdERUT0Jh?=
 =?utf-8?B?U1VtcEc5RjhHYWdSelp2RW1TYjFCUERtemZaUUs0R2NzMWJRbE1UeGk2WjZT?=
 =?utf-8?B?cFJWdkRIUU0vUkxrRXVLSGhTWXlnT0krUGlXUjY5MFBuZ0NzemdnSG9QREpD?=
 =?utf-8?B?a0srWG5vaDVmZjZ1K0crTjFQQjJTeW95OGJpckh0bTB0R3cwVDZkdlViR3RV?=
 =?utf-8?B?aGEvZ21URW1KZ0dFaGQvMkdXOXJXZUtDZHNnN3pXNDhDWkxua0VCYkFmL1A5?=
 =?utf-8?B?ejVrZTY3SjY5OCtXLzhaa3h5TWtoZkFnVm9JTktydDNWeCtYY3dvS2pDdFda?=
 =?utf-8?B?b1N4WGNyc1RDK1ZDV0xMZFNUN1BrQWczZFliZnVvWjRlWjFtY2RPcUIvZ2VK?=
 =?utf-8?B?eFVWeW5vVlFxL1lrNlZOU3MrYXdnUVcyeENOalpuTUZxYkhtc0FBdHlkVk9N?=
 =?utf-8?B?VXp6eUdHMUJDclQ0OEZDbWZmWklKN2VwZHJtaUZLQTdWa3p0dk1OaFBtVUZl?=
 =?utf-8?B?SDZlVXBLZTRxeDZrWk1rUDZ0MjZQbG16OEZkM1VkeDBvME9IV1lRUjgzTFM1?=
 =?utf-8?B?N0N3dktlc1ZvdHh1V1VhQmFUc2ljMzJ2a1Y0ZkRSRGU0Mm92VisvVW10ZmMv?=
 =?utf-8?B?RVIxT1piODdMRmNwV2RIRE92d3hoVGNSc053RU55SjJuQzJMeCsvSFVnQy9q?=
 =?utf-8?B?ZmJZVy8xdDRGbmRNWSswdGN5UmV0WkZBUkdIaWFOblZZM2ZjTmZHZmYzd3R3?=
 =?utf-8?B?YnNtNTJ5ckowVmc4am9uRHM2ZjRScnVJZUpHcUZ0VGdwZHNQNTdTdlQyemlZ?=
 =?utf-8?B?WEZlMjNyQjB4UmZ3dXlEYm5qMDlJMlhiSW82L1lyU2t5SW00bC9ydDlwUGNu?=
 =?utf-8?Q?fTWc4SjsqVPI9Voh5EOLqcp71tjyAh9n?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWhBeWpicFQ3VVFTSVRMN2JtbDBBRjF3VDhYSVdDNE1XYzNiRUFwT0UxYmt5?=
 =?utf-8?B?VDVCM0Q2L1N6bFg4K1RsV0djcTZISzNxbDdPQkhLZi9Xa000alFTVThhbHFX?=
 =?utf-8?B?bkVIMVAwMVVacGdrK3QwcWlib01TRWxXQ2ExRVgwM01PUDJ1NUZyaUsvdW0v?=
 =?utf-8?B?NExzVkwyWll1UXl6UmJ0Vm9aR3dEaE1nL1VkanhUVmRTWm9lWE04TmkyNmx6?=
 =?utf-8?B?QUphWm0zSjZKY1RUUFJ4bGZpdk1tUnQ5SEFoUE9KL0Y5MnNoY1ptOHgyeDE3?=
 =?utf-8?B?SGkyVDBDSkJxN1lTSEtFOUJhY3I3MnpUT1NkUzF6KzllK1hQckJyMktsNGZ5?=
 =?utf-8?B?WkY0d2ZxMlBOMEVPSlRxa08ySmY3N2xtNndNbENacWFoTlR3SUJkRFJjMnNy?=
 =?utf-8?B?MFVNVGRLc3orL3BaNkpBc3plSFp4QlBydDZlckhheDA1RE5VZjdZdVBkRUZP?=
 =?utf-8?B?Vm5CY2hlYVFmajJtamRWaWR1VkIvK1dUMWgrcUtEQUlod0JWc0JkL0I4dGJw?=
 =?utf-8?B?dmpqWDlIR00rek9BaHdpRUFySkNBTllqTjFSS3gyOTlkT3UzWlhKc0RSUHlO?=
 =?utf-8?B?bFlsMlNPU3hDVEJVM21PbGhEYTd3S0piUk9MMkh6cUw1Wno2anUzZ2crM1F0?=
 =?utf-8?B?MWtKcDJwbklOdUpneWdSQSswTis2Z0dBNGFWVGp6UDZlNHdIWXNmNEpZeFVu?=
 =?utf-8?B?Nlhpamxuc1dObU1hbjNkVEl1cHdITXBpNGR1MjZ2MmRpWHZOZG1DL3VuRXJ6?=
 =?utf-8?B?OXhaYmZxaFJFNlBHbXhLM1llUkQ5a1RoZmtXZ2VFNk9BRVJOOVIwT2JrblQy?=
 =?utf-8?B?bGUwTzJ2MUFYb0M1RlgxRk1PYnRaU3NiMGQ1cGZIM3kvb0RoYy9mM2RmS1Nt?=
 =?utf-8?B?U2pJSTlaNzhiMFhEUU9IeXdtV3V2eUhkeUpLNERPZ2xsY2xkeFJ6RmRFaXd1?=
 =?utf-8?B?eGVvcUh2YThYOENvcS9PUXBBMDRhSnFVTncxVk1vT2lUc2JGaUJTN2RJcnR5?=
 =?utf-8?B?VjRRMUJqTzlwb3hZZSt3NWZlNlFWSG40M3hZYWpnQ2dOWWU4VXRGUDBFY05t?=
 =?utf-8?B?SmFUWjRwT21ZWGxiOHloMVJHYk00RG5FYXNJOHJDSVV0bWhGRzJlM2RlbVpa?=
 =?utf-8?B?RTV3VUZVeHpnazFiaEtoSXpmS0IxdU90WENic3Fnbk1hTnhxYlBRNENoTnI2?=
 =?utf-8?B?dDh1dU43Wjk0Yk1Ud1RTU0RyNjhTNFRiNVB3QzlDRXhPTSt3UnhsV3FQT1Nk?=
 =?utf-8?B?UjFUTmlDSWE5dCtWMk1WdHhpaVU5SjFxM3hFeWVCLzFacm1FL0Z2NEpqM2g5?=
 =?utf-8?B?Mjk5QnNRMS8zdFZLMURFYVdqN055OTNQVXJnRGxyVzJwTlRjaDBWQURsYjR6?=
 =?utf-8?B?cjIwWkFIUURqd09jUVZIaFVsZjQ1N3dHMWdCN0gxUWJIUS8rbFlyNmJ3RTZE?=
 =?utf-8?B?MnFIbkZwSkpJUDhFUzg1WlIwWWRFbWZyZTFBQkhEaGZaeVpDRjhWcHZaQXg3?=
 =?utf-8?B?UXJnN0NZN2dZZ2xuTk40NkZKKzZaU21waU1NaFBuNmRzdnJyYWswa2xNZXNl?=
 =?utf-8?B?ZnhiOFVZNHVMQ0JtMmJieENMcjZvck1xaHZhREtpNHBUWjRNZUJpRm5Hci9K?=
 =?utf-8?B?Zy9sR1Z1TjVuNTgxT1dqOVh5QjhjMjYwRXNKWnRGVVcwaTQzRUFncm1JaHZm?=
 =?utf-8?B?UWl1dldvSzZRRnFxeGVpZHJMd2NkQ3FRd052b3pLUWRwZ0tBempYdGR6VGUw?=
 =?utf-8?B?NlR1bG5IaXFVQitOL3ZMSHRHS3hUeVpIYWQrZkhaOHV1WkNXZTJYbDIrNlNS?=
 =?utf-8?B?UHg5R3VRSTN2dzhkTWE1N21kUDFiZ3VleU44OVQ5N2UvZG04STloRVF1L25h?=
 =?utf-8?B?VitBd0JVSjJoVXhOMnZkR0ViRmVnMU5VaU1mVVVrV1dVU2lZVjZJajVOQjFs?=
 =?utf-8?B?dzdvQTZ5KzVyUnh4UmtYa0hidHFtQ1lCdmd4SUwxY2Q3UzBKaUlkTXVFWW5P?=
 =?utf-8?B?c0hza2YzdGNZajRLMVBDaGJKTXdSMTJEUi96UndTaTdEaG4yUWRSQWlRcHNu?=
 =?utf-8?B?T0RsUjZnTnVrVnUwbmVjM1l6Kzc1emptbThrN0xITzlLZSt6bm1PMk9qamt0?=
 =?utf-8?Q?sKq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D9818A3ADE98F4E91A6C27EBF24890E@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02feb010-d477-4d4e-69f9-08dd61d650fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 02:25:26.5947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZiuI/Uub3qWoK3VJ6AWLe4VDWo9VBOrEoBnBWdRWMrhBGX3uWRaNr8YlkAhZ9uS6VRbm+y/y57Y/pfLEpQ/+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5911

5ZyoIDEvMjAvMjAyNSA4OjI1IFBNLCBDaGFvIFl1IOWGmemBkzoNCj4gT24gMS85LzI1IDIwOjI3
LCBDaHVuaGFpIEd1byB3cm90ZToNCj4+IER1cmluZyBhIGNoZWNrcG9pbnQsIHRoZSBjdXJyZW50
IGFjdGl2ZSBzZWdtZW50IFggbWF5IG5vdCBiZSBoYW5kbGVkDQo+PiBwcm9wZXJseS4gVGhpcyBv
Y2N1cnMgd2hlbiBzZWdtZW50IFggaGFzIDAgdmFsaWQgYmxvY2tzIGFuZCBhIG5vbi16ZXJvDQo+
IEhvdyBkb2VzIHRoaXMgaGFwcGVuPyBBbGxvY2F0b3Igc2VsZWN0cyBhIGRpcnR5IHNlZ21lbnQg
dy8gU1NSPyBhbmQgdGhlDQo+IGxlZnQgdmFsaWQgZGF0YSBibG9ja3Mgd2VyZSBkZWxldGVkIGxh
dGVyIGJlZm9yZSBmb2xsb3dpbmcgY2hlY2twb2ludD8NCj4NCj4gSWYgc28sIHBlbmRpbmcgZGlz
Y2FyZCBjb3VudCBpbiB0aGF0IHNlZ21lbnQgc2hvdWxkIGJlIGluIHJhbmdlIG9mICgwLCA1MTIp
Pw0KDQoNClRoaXMgaXNzdWUgaXMgZm91bmQgd2l0aCBMRlMgcmF0aGVyIHRoYW4gU1NSLiBIZXJl
J3Mgd2hhdCBoYXBwZW5zOiBzb21lDQpkYXRhIGJsb2NrcyBhcmUgYWxsb2NhdGVkIGZvciBhIGZp
bGUgaW4gdGhlIGN1cnJlbnQgYWN0aXZlIHNlZ21lbnQsIGFuZA0KdGhlbiB0aGUgZmlsZSBpcyBk
ZWxldGVkLCByZXN1bHRpbmcgaW4gYWxsIHZhbGlkIGRhdGEgYmxvY2tzIGluIHRoZQ0KY3VycmVu
dCBhY3RpdmUgc2VnbWVudCBiZWluZyBkZWxldGVkIGJlZm9yZSB0aGUgZm9sbG93aW5nIGNoZWNr
cG9pbnQuDQpUaGlzIGlzc3VlIGlzIGVhc3kgdG8gcmVwcm9kdWNlIHdpdGggdGhlIGZvbGxvd2lu
ZyBvcGVyYXRpb25zOg0KDQoNCiMgbWtmcy5mMmZzIC1mIC9kZXYvbnZtZTJuMQ0KIyBtb3VudCAt
dCBmMmZzIC9kZXYvbnZtZTJuMSAvdnRtcC9tbnQvZjJmcw0KIyBkZCBpZj0vZGV2L252bWUwbjEg
b2Y9L3Z0bXAvbW50L2YyZnMvMS5iaW4gYnM9NGsgY291bnQ9MjU2DQojIHN5bmMNCiMgcm0gL3Z0
bXAvbW50L2YyZnMvMS5iaW4NCiMgdW1vdW50IC92dG1wL21udC9mMmZzDQojIGR1bXAuZjJmcyAv
ZGV2L252bWUybjEgfCBncmVwICJjaGVja3BvaW50IHN0YXRlIg0KSW5mbzogY2hlY2twb2ludCBz
dGF0ZSA9IDQ1IDogIGNyYyBjb21wYWN0ZWRfc3VtbWFyeSB1bm1vdW50IC0tLS0NCid0cmltbWVk
JyBmbGFnIGlzIG1pc3NpbmcNCg0KVGhlIHBlbmRpbmcgZGlzY2FyZCBjb3VudCBpbiB0aGF0IHNl
Z21lbnQgaW5kZWVkIGZhbGxzIHdpdGhpbiB0aGUgcmFuZ2UNCm9mICgwLCA1MTIpLg0KDQpUaGFu
a3MsDQo+IFRoYW5rcywNCj4NCj4+IG51bWJlciBvZiBkaXNjYXJkIGJsb2NrcywgZm9yIHRoZSBm
b2xsb3dpbmcgcmVhc29uczoNCj4+DQo+PiBsb2NhdGVfZGlydHlfc2VnbWVudCgpIGRvZXMgbm90
IG1hcmsgYW55IGFjdGl2ZSBzZWdtZW50IGFzIGEgcHJlZnJlZQ0KPj4gc2VnbWVudC4gQXMgYSBy
ZXN1bHQsIHNlZ21lbnQgWCBpcyBub3QgaW5jbHVkZWQgaW4gZGlydHlfc2VnbWFwW1BSRV0sIGFu
ZA0KPj4gZjJmc19jbGVhcl9wcmVmcmVlX3NlZ21lbnRzKCkgc2tpcHMgaXQgd2hlbiBoYW5kbGlu
ZyBwcmVmcmVlIHNlZ21lbnRzLg0KPj4NCj4+IGFkZF9kaXNjYXJkX2FkZHJzKCkgc2tpcHMgYW55
IHNlZ21lbnQgd2l0aCAwIHZhbGlkIGJsb2Nrcywgc28gc2VnbWVudCBYIGlzDQo+PiBhbHNvIHNr
aXBwZWQuDQo+Pg0KPj4gQ29uc2VxdWVudGx5LCBubyBgc3RydWN0IGRpc2NhcmRfY21kYCBpcyBh
Y3R1YWxseSBjcmVhdGVkIGZvciBzZWdtZW50IFguDQo+PiBIb3dldmVyLCB0aGUgY2twdF92YWxp
ZF9tYXAgYW5kIGN1cl92YWxpZF9tYXAgb2Ygc2VnbWVudCBYIGFyZSBzeW5jZWQgYnkNCj4+IHNl
Z19pbmZvX3RvX3Jhd19zaXQoKSBkdXJpbmcgdGhlIGN1cnJlbnQgY2hlY2twb2ludCBwcm9jZXNz
LiBBcyBhIHJlc3VsdCwNCj4+IGl0IGNhbm5vdCBmaW5kIHRoZSBtaXNzaW5nIGRpc2NhcmQgYml0
cyBldmVuIGluIHN1YnNlcXVlbnQgY2hlY2twb2ludHMuDQo+PiBDb25zZXF1ZW50bHksIHRoZSB2
YWx1ZSBvZiBzYmktPmRpc2NhcmRfYmxrcyByZW1haW5zIG5vbi16ZXJvLiBUaHVzLCB3aGVuDQo+
PiBmMmZzIGlzIHVtb3VudGVkLCBDUF9UUklNTUVEX0ZMQUcgd2lsbCBub3QgYmUgc2V0IGR1ZSB0
byB0aGUgbm9uLXplcm8NCj4+IHNiaS0+ZGlzY2FyZF9ibGtzLg0KPj4NCj4+IFJlbGV2YW50IGNv
ZGUgcHJvY2VzczoNCj4+DQo+PiBmMmZzX3dyaXRlX2NoZWNrcG9pbnQoKQ0KPj4gICAgICAgZjJm
c19mbHVzaF9zaXRfZW50cmllcygpDQo+PiAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZShzZXMsIHRtcCwgaGVhZCwgc2V0X2xpc3QpIHsNCj4+ICAgICAgICAgICAgICAgIGZvcl9l
YWNoX3NldF9iaXRfZnJvbShzZWdubywgYml0bWFwLCBlbmQpIHsNCj4+ICAgICAgICAgICAgICAg
ICAgICAuLi4NCj4+ICAgICAgICAgICAgICAgICAgICBhZGRfZGlzY2FyZF9hZGRycyhzYmksIGNw
YywgZmFsc2UpOyAvLyBza2lwIHNlZ21lbnQgWCBkdWUgdG8gaXRzIDAgdmFsaWQgYmxvY2tzDQo+
PiAgICAgICAgICAgICAgICAgICAgLi4uDQo+PiAgICAgICAgICAgICAgICAgICAgc2VnX2luZm9f
dG9fcmF3X3NpdCgpOyAvLyBzeW5jIGNrcHRfdmFsaWRfbWFwIHdpdGggY3VyX3ZhbGlkX21hcCBm
b3Igc2VnbWVudCBYDQo+PiAgICAgICAgICAgICAgICAgICAgLi4uDQo+PiAgICAgICAgICAgICAg
ICB9DQo+PiAgICAgICAgICAgIH0NCj4+ICAgICAgIGYyZnNfY2xlYXJfcHJlZnJlZV9zZWdtZW50
cygpOyAvLyBzZWdtZW50IFggaXMgbm90IGluY2x1ZGVkIGluIGRpcnR5X3NlZ21hcFtQUkVdIGFu
ZCBpcyBza2lwcGVkDQo+Pg0KPj4gU2luY2UgYWRkX2Rpc2NhcmRfYWRkcnMoKSBjYW4gaGFuZGxl
IGFjdGl2ZSBzZWdtZW50cyB3aXRoIG5vbi16ZXJvIHZhbGlkDQo+PiBibG9ja3MsIGl0IGlzIHJl
YXNvbmFibGUgdG8gZml4IHRoaXMgaXNzdWUgYnkgYWxsb3dpbmcgaXQgdG8gYWxzbyBoYW5kbGUN
Cj4+IGFjdGl2ZSBzZWdtZW50cyB3aXRoIDAgdmFsaWQgYmxvY2tzLg0KPj4NCj4+IEZpeGVzOiBi
Mjk1NTU1MDVkODEgKCJmMmZzOiBhZGQga2V5IGZ1bmN0aW9ucyBmb3Igc21hbGwgZGlzY2FyZHMi
KQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2h1bmhhaSBHdW8gPGd1b2NodW5oYWlAdml2by5jb20+DQo+
PiAtLS0NCj4+IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mMmZzLWRldmVsLzIw
MjQxMjAzMDY1MTA4LjI3NjM0MzYtMS1ndW9jaHVuaGFpQHZpdm8uY29tLw0KPj4gdjEtPnYyOg0K
Pj4gICAgLSBNb2RpZnkgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIG1ha2UgaXQgZWFzaWVyIHRvIHVu
ZGVyc3RhbmQuDQo+PiAgICAtIEFkZCBmaXhlcyB0byB0aGUgY29tbWl0Lg0KPj4gLS0tDQo+PiAg
ICBmcy9mMmZzL3NlZ21lbnQuYyB8IDQgKysrLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL3Nl
Z21lbnQuYyBiL2ZzL2YyZnMvc2VnbWVudC5jDQo+PiBpbmRleCA4NmU1NDdmMDA4ZjkuLjEzZWU3
M2EzYzQ4MSAxMDA2NDQNCj4+IC0tLSBhL2ZzL2YyZnMvc2VnbWVudC5jDQo+PiArKysgYi9mcy9m
MmZzL3NlZ21lbnQuYw0KPj4gQEAgLTIwOTAsNyArMjA5MCw5IEBAIHN0YXRpYyBib29sIGFkZF9k
aXNjYXJkX2FkZHJzKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgc3RydWN0IGNwX2NvbnRyb2wg
KmNwYywNCj4+ICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pg0KPj4gICAgICBpZiAoIWZv
cmNlKSB7DQo+PiAtICAgICAgICAgICAgaWYgKCFmMmZzX3JlYWx0aW1lX2Rpc2NhcmRfZW5hYmxl
KHNiaSkgfHwgIXNlLT52YWxpZF9ibG9ja3MgfHwNCj4+ICsgICAgICAgICAgICBpZiAoIWYyZnNf
cmVhbHRpbWVfZGlzY2FyZF9lbmFibGUoc2JpKSB8fA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
KCFzZS0+dmFsaWRfYmxvY2tzICYmDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICFJ
U19DVVJTRUcoc2JpLCBjcGMtPnRyaW1fc3RhcnQpKSB8fA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgU01fSShzYmkpLT5kY2NfaW5mby0+bnJfZGlzY2FyZHMgPj0NCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgU01fSShzYmkpLT5kY2NfaW5mby0+bWF4X2Rpc2NhcmRzKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KDQoNCg==

