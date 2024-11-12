Return-Path: <linux-kernel+bounces-405333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97CA9C4FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98680285A10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F020CCD0;
	Tue, 12 Nov 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Hde7lGI7"
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791071A707D;
	Tue, 12 Nov 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397847; cv=fail; b=qBnJg9EZN5n6ERkMBd9off91HdWI9dH1FkPchpiyHQpUMVnSSrRvY8PCT0c7NSQ5VOe1Sncm5m7/h1w5hBKEshjP0Dd6JzMp2KAF2vGHkLLfYJVuni+BH12AdfTlFNhw9dW48BlVbWTvCRL7J52Hx5Wziak2R/HRxxTb5xltasw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397847; c=relaxed/simple;
	bh=wSytrPdtNnLBQ4Cf6cJe/JZjSGOVVTYXgeWqkdFIbmY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lTksbXFg5kgBO4ZY4g0Jew2aom+4YO6otHraskvIaFIOBiIZkal2FjxMmBqdbsVasL3YbRzvMTkCRPq+IKtVhH9qjI65W8ln43HEn4pe7bABq4c7lw3LjytBq6L2bHaeV+BWuRb1dJA0vCVoM18ZXuKQD5gkL6BlU6CdXCU2l2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Hde7lGI7; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1731397844; x=1762933844;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wSytrPdtNnLBQ4Cf6cJe/JZjSGOVVTYXgeWqkdFIbmY=;
  b=Hde7lGI7b5iu3sr/TqHelAJcs7s0dU9puDtT7LRp5Erhec39D5U3lPPl
   sXs3A7X5+Hp+gAK8YJlLOXrA7hucIwhOo5nw7JmMbTC3GMUL7VvlfqbKH
   TnwmoBsEzm9FfX/tHZeQs48Zt5D1z+Hypb43EKQNfeouN5IKshT+qF1ps
   RM5GqICCqnz+BM4G0TNdxA5rbGGn4Vv2ZYBLU2pHd1IQzoIryMoT1oic1
   +L78ohVILqXBLmr59BdTI4BAHmgJU+xNolG2vaPRW+R8zgCG+Y3us3mz2
   30vXE1xjCYYgZgBYBjlwtmR7EB87FWyjZbqZenbvoSQFj2GLPArukBI1g
   g==;
X-CSE-ConnectionGUID: Lj9s9MyOROm0RrFLASCEIw==
X-CSE-MsgGUID: s25c3mOGRQqeR1gfMc9e7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="136654985"
X-IronPort-AV: E=Sophos;i="6.12,147,1728918000"; 
   d="scan'208";a="136654985"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 16:49:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2gFQFDEdgj7JiXFb5mIq6V9Byyw5bd+k3m/BHb6RlnSxzE0nY7y7L/gcczlUBQCp0Jfu1uY2bloiGbHHxkNt583aBrQKF+Q5jY4RLilUFD1KcCgj4M14kFlUlYMVOCm6gzvOtwqDQFeczeOypdrF9WFnSpGsPPkfGuEJ4JsGyAG31tpnDQXalnp2CaLpKyhScASaODD/Ublt1Pu8meeDZsiDF5WWbDbFooDRiwt20M4DfDux3AKGy3fAnF7AQVNFIhc38Thmmnx32j0DaDm28WGgLlh/MuBQnHGvJT4TB8YvTyOcKncQjWGcMkImHMgFGrr/sRRkMePM8n2WowW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSytrPdtNnLBQ4Cf6cJe/JZjSGOVVTYXgeWqkdFIbmY=;
 b=L+5Xjwx1Qe0+607VtT3zYSvKPGEXF28AvNK3XlUCTIav1/B3kwp7e5MSE+oroJmfYbEV0XuXNqGTQJbz+8WvAKoTKLdFIkI0Bex7lNAy7bO3f493qMCKnerp/VVSQ0n3v4vyGPwQm51+VL/P6hF1toPsXVToj8WyBVqqT24UL6wBAAihICJA/wTk68JrTdjVqZ+dhOjd2kPErhrG+53tUTUd5rWcbv2gHxJbtCkD9PwCrmUEW/x3KfTmHhunqeRdzrBIMd07n8lWaXsRu6HH0Qc7Dn8Eha8gbR8nfJmZIkr1NW5kUBnOsIfiZU1kaWzwf4xi/fYD3nTF7pGKqIYATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com (2603:1096:604:12c::9)
 by TYVPR01MB11203.jpnprd01.prod.outlook.com (2603:1096:400:367::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 07:49:24 +0000
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe]) by OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 07:49:24 +0000
From: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
To: 'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>, Will Deacon
	<will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet
	<corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Bjorn Andersson
	<quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio
	<konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
	<nfraprado@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Thread-Topic: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Thread-Index: AQHbMaC0J9oIMH8IZkqiWC48wavuCbKtOFWAgAABjICABg9SkA==
Date: Tue, 12 Nov 2024 07:49:23 +0000
Message-ID:
 <OS3PR01MB69039D08CF87FC69CDE6DD8FD4592@OS3PR01MB6903.jpnprd01.prod.outlook.com>
References: <20241108054006.2550856-1-fj5100bi@fujitsu.com>
 <20241108054006.2550856-2-fj5100bi@fujitsu.com>
 <f66a649a-60dc-44ba-b8b0-b049c9e357fb@linaro.org>
 <c50d36ca-2268-4149-8bf0-c44fc1786d9c@linaro.org>
In-Reply-To: <c50d36ca-2268-4149-8bf0-c44fc1786d9c@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YzJlYTU4NTUtNzU2Ni00M2MxLWIzN2ItNzM1ZWE5Njc1?=
 =?utf-8?B?MjlhO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTExLTEyVDA3OjQyOjAxWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6903:EE_|TYVPR01MB11203:EE_
x-ms-office365-filtering-correlation-id: 5a44a87c-f6ab-4b1e-ea97-08dd02ee869a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2NOVDQvczFLWmRBeGNZYW9sZVVKbHgrUUhQOWtkbFE1SERieUhtWnhZYk9B?=
 =?utf-8?B?alFRV3VvZWFYN1hTbkcxbzJYN2cwY3hrZnRWNExHQVNxV2RqZjU4Skd1ZTJZ?=
 =?utf-8?B?a2N6dXZSUFJBRitJWEd1VU51bEh6Y1FnZzhjRzZZQmRISUppQ3lVa2tmd0hM?=
 =?utf-8?B?a1BlSEgvdWtMVGhsMzcrUjk4SkpmUE02RUxVREpzNlNpdEw0K3luUFl6VHZm?=
 =?utf-8?B?RmZxRDNSazdBNDVBUkw1VU54VndlRHlRUjFheHVmcm1ad0JiQ1RsNEZhNlBu?=
 =?utf-8?B?dkM4YU8xUDA2OGpBdTZsRkpZY3V5QWdoaHpjN2MrMkM0TkwzYTlYbmFndFkz?=
 =?utf-8?B?YkM5NFZKNXVtU0pPVkEwM2l5VTNkRUpaTnI4bnlLVHREbG9DYk5zeTJVN01j?=
 =?utf-8?B?cmRKMFA3MitjZWJrTTdZb2dUWVE0VFFaU2JuUmhjQzU4VC9nYm5zSGtDOEFw?=
 =?utf-8?B?OWgwL1RaN3Q0Q2JJaHlBejMrbStuZWNJRy9jK2J1ZnU4SzZ1QTRJREE2MlNa?=
 =?utf-8?B?dkVEWW42UTRSTkF3YWFuakNxTG45NWdYbWd0TElzOEJlRzZwak5uNnhhSnI2?=
 =?utf-8?B?QmZoYldMUWROWm12TFRGUFZwTTI3Yk51SjZwWHZqL3RpUTNxVUN0MjQ4S0tx?=
 =?utf-8?B?WHdLbjV2UVhQaFBJTDQ4Y1pVU0tDUlBtMTZ5ZXFNbFhkVXIwUFJqbWZhb091?=
 =?utf-8?B?cTArRFlnUk5ZQXROTGZONDRCbFZWaUVPc3BSTzd6RGkrbjdqc2VQSEoxYXdj?=
 =?utf-8?B?Q0gySFZQaWhXemZiTVZmN0ZWTlh0aGRKUitkcjVGb1RDOGFST2wzZzhteldl?=
 =?utf-8?B?YjFXaUVYa1lmaCtEQTBCakJxR0xubUVtTHZGSDR4d0wrVEI1MDFFdWR3OWRH?=
 =?utf-8?B?RDhGN0tUVHZCa0lKSzJpVmF2YkFuK3FYR0JYSTh1dUVieGE4elNKUWRpZUw3?=
 =?utf-8?B?UDNVcE9vMDFhWDZVcWdvRXRSVXhNWEFiZS9yYzN2Ym5xc2orclpRbC9IcDdu?=
 =?utf-8?B?UTdlOVFRYTE3NnNoQ0RzNEZ4SUcxZDJHYVk0c3Q0aDFqdW0xL0swTCtURWho?=
 =?utf-8?B?alRUaVoxcWpIOUJoK3JPU2F0TTRFT1I5K3RrbnlKNHJOVmQ5d0xiZTNubm5y?=
 =?utf-8?B?RXJ1V2JwUzAvdTkwM3ZyZSs3RzBoSWppT1VQU1NSb2JlTjdESUFTcHFsMUdE?=
 =?utf-8?B?WUdpYTB1U1ZvTGl5ajFQdnF4MmUwUHVaRk5hQmd3NUx2MDlma0JDSHkvejBX?=
 =?utf-8?B?Z2luRmVQWlpWZm1sdnhqaWNrZE5nOWxyK2EvYVBMMGNubHVrVmhzUlpnMU5J?=
 =?utf-8?B?b3R6RU9ORUcxUlcwR2F6ejBzcDlUcnB0OWNwV1BtV2FKd1A3eXE3NWdPTDJx?=
 =?utf-8?B?Y2ZiY0lsVGtsQU44VWhEMGZBbGhXdnJBcE44TDN6REQzY3ZEdzFDaWo4ZkdD?=
 =?utf-8?B?eDlvRndJWk1JOWJnZjJsbGNyV05KOFVEUVNsdDUwem9Ua0NNRW5FZG9oU1Jm?=
 =?utf-8?B?NGpTQUs0UXhTZThpY0daVWY3NG9BcnlINzNxZ2FOYTgrSWx4THJIczUrMGlt?=
 =?utf-8?B?TXJEQ3VUNUgvbUZDTjBpRnJFekpHRmF6ZUpQNVVaS3J0OWRlck5oVHJpcFhE?=
 =?utf-8?B?RWVCdTZIZ2QvdHF2QUZ4bnArbUZqVnd2Q2ZGcGN2TG9Dc1UyRGgzc2Y4Ymo0?=
 =?utf-8?B?WDRIRGp5ZWZZM2JiSFpVMTBHenJWRHc3V0FuSWpnd3lkcGExMFlrcGFtYXhy?=
 =?utf-8?B?Y1BBM2Z0RzhpRVFXajg2UHJseDJGdEszZFB3VXFuRERXL3p6dmRyMzFrVFda?=
 =?utf-8?B?bzVqNVUxVG1aSk1uS1RqaTFNY0FiOGpxYUhqdzEzWEVQT3FKcGRZQ09LbzJ3?=
 =?utf-8?B?RGsyOHJBZFAwdVlNcGtmL0hGUTZnSmtlZjg3MnU4QUI0UEFUYmcxSDFsTWpB?=
 =?utf-8?Q?jVeHKYRXBD0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6903.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm5PSnAwWG5rcjN6ZktyUmhhQlNqelFOVXdnK3VrM1dzUGlPTm9qakU3Rmhn?=
 =?utf-8?B?S2xWUm1YMWxBVS9BcEdjNTIrdWU0SERSNVZJNld3OVY3MVBiU1Q1L1E4QU1s?=
 =?utf-8?B?VTN2NW13NHRrUlBadmh3V3g3UU9OTC81cEo2RHQ1cWxJQTdibjl3K1FxRFFi?=
 =?utf-8?B?ZWhMSWhqaUFPQjdNVVhWMW0rOEpiZlAzZlo4SFhPWGsrdU0zSkphVWx3L01u?=
 =?utf-8?B?eVZoK0p6c1oyc3VXcGNlUVJsRGRwL29nWW5vTTV6TjB1dDkwV2R0OXpEMWNj?=
 =?utf-8?B?cXNrdkZEQVZRYWNHdGp0MnA4dnZwdVo3K2wrYkdXQlNteUZrb282TUZ6dEl6?=
 =?utf-8?B?K1dGNU5ERGNleHQrdXhZdnNrNFd5S3FQbVdudjZzQUpYaXJVNEFvclhVeHRk?=
 =?utf-8?B?cVlyS2dtWHhxbUprVHVaT3NlQWRlSi9uQi9tRW9PL0hmZk9LNDVWN0xKc29l?=
 =?utf-8?B?RlQ2Z1Q5RUhFdDhKZEV4NUY2QW5RWVVvSlBKLzJPRzUyS2dONE5SSy83UE82?=
 =?utf-8?B?SlEraS90Nmh4NlVhTnZsR0ZjSHVSb0FHM1NhOHpCMWVBZStraTYxaWlEbEZ4?=
 =?utf-8?B?MGZ0S2o2WVFBWmgyYlk5Z2toejlTcnkyVXJTTDBIVFAyNS9TZHhBQlhyZEVY?=
 =?utf-8?B?NldTMEdJamJybHJ4TFVQb0VxSE9DWXlJdVFrd0Y0Q2hvQUs0ek0wWHF6WGVC?=
 =?utf-8?B?a3Q5bjkvRzBjZGYyMFpzRE5SMFFkUzE0ZFd2cGkzNHJXdlZoL0kwUjdFSXBD?=
 =?utf-8?B?UXZHUExzNzFTV0xNeStwcERSa1pJOHJGQmVVTEdNZXJlTmtIZVcyMWZ3eEd2?=
 =?utf-8?B?UzJKZitNSkM1UEk3bW9vRjlMV3RvQlRwMjN5cmx4UlU0RGZKZHl6bTVxcVFX?=
 =?utf-8?B?c3pZdzJueHJham0rYi9IcWRhQ3Z4ZW9USTRXNFM3dkRvMGpkS0N2QmF2QWo1?=
 =?utf-8?B?VlNUdkVyT0QrQ3VERVBoWGhUY045TjUzZU1ENHVQK0Y2cUVuMGZmalhyQzI5?=
 =?utf-8?B?aE9YNlNqVU41N2V2Z0RRRWN5R05QaExPZnY3NVhtc1hIQ0p5bXFOZ3FJMVJW?=
 =?utf-8?B?MThUdjhBUEp2ZGpQbTY2djQzSW5Ha1dpZXpiTlhsSnZHa2VsUnMyMlE2U1V5?=
 =?utf-8?B?QStEOFo2SkFFMjNHbnRtMm1mU1Bab1Vvek9PR2paTEhBUXVZNmFFZzBUMTdj?=
 =?utf-8?B?OEhGcGJuQktVckorek5iNGx0NjRUaFBScTU0aDd4TkhPM3hoV2tSb21uY3lK?=
 =?utf-8?B?OW9HZnZOSkdYODkxRkNOTkJBVXBXekhYRWZFbkk2cFljd2hIbXdmUXRFS0I1?=
 =?utf-8?B?QmlYdzNwbjk4NkxmTGoxRmk3TEM5WEU5TEZSeDE0ZDZsZXhEZkVMS09pR3Bp?=
 =?utf-8?B?STkyb1k4enhsSmtHUlhIOGpLMGFaVmFVdGRRMEJqbzhRZm9vRjB6OWhLL3pk?=
 =?utf-8?B?TGZqNFlBSCtsTGF5emQ1Rmd0ZFlveTBsenpLSGhOd000aDh2eENEbHhaMGJr?=
 =?utf-8?B?ZXNWSlVzeVh0TXBXdmF0YjN3ZjJvLytCamNmTFVJUUpzQmZTSFdaM2pkR2Ju?=
 =?utf-8?B?cm9CRTNhZzF0RFpPOG9TcGlXajh6RFEzTjlwcjVDMzFJNGp5NFpSQjQ1ejVN?=
 =?utf-8?B?WCtYYjJWN0paWWhndEpHa2YvTC90aEJ6RnZJVFJabXF6MFpnaDZHSXNSNFpK?=
 =?utf-8?B?UTVCWWhpTDRjZGJJOU5TQlRsVnBHOFBZUUtUZURISXNsTXphTGk0cWZGdSts?=
 =?utf-8?B?SC84ZzNqZXpMQXYxWis3dkp5S01mNnJQV1Q4VkpOWW1tWmtmNHJlZEw2MHFk?=
 =?utf-8?B?cjFkLzRCV3psdVhrNU95UmVGanhXaEZ1MEhiTlNlelB3WUhSQzlmV0hZSEp1?=
 =?utf-8?B?enR3bEpaSGpxSDRCUFkwb3JCNXE5VUZRbm9Pa0E5N2hKd3h6R2hOMzBrREZm?=
 =?utf-8?B?VnFoMm94aVhXYjMzVHo5YldGMHlueS8reDdtd0c4L0tQUnFWU0FialhJb0JN?=
 =?utf-8?B?MjB6Qi9GT0ROOVJlME9GOVd6dnFybTFKZWc5c2lFRUxCcUU4bGpnazRNdUt3?=
 =?utf-8?B?azEvVnFTNndVQ3QxVy9zUFMzREhmbVprQW9VZG1kdm8xeGFuMit2b3pWRzdU?=
 =?utf-8?Q?2cCLSzQ1YBbAf2Pm5XjT1IcgM?=
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
	CtbnarG2WLgPpFr9P/zcP/LdcFG9SK3vgBK5bDVCM98cppiwOJl0/+tTH2usGhvA5FMXthPqigvs+DUtv95fMeY3DYZ0gALqLqNdaIQ52vwb6q88rAkiXgr6W5RBPHsul3CrUODc88RvuehSq/vTvTb4mLvWXdGrnMFftm9Xp48o3aBjR9c/pj0Ysi3oh74Zcyvm7KV0pAl9DPQ+NnHhINFxvSdpSJEw6HQ9vqOaNUKLECGV4LamH1KOaDOgq/3QrsmKQ5pNgAwpSOFOvnF3JwKNZpBOSDjTvZSppaxuXlPIlSh3qKmer+TX3ibFOUG5wTv9xuf71oWXHzapoAvQoGfQ0eOLrOhEHxx2m5ockHe/urEQPzfgwEe2E2qF0IgCY+c47ZbrlVdtWXn1QAxnfCly43df+WjOletdSGZoSyTaQ5Mat5dY95ewBr8mZBTDoMFcyNROn1vm1yo8JKiPU8wCEgxNqDCJpYX+I0stVXBLafu8eDbpeBjGLeTuaUPHV9/shIV3TlDGtBdXsYo2Et27eO+toNw4OQfLSIaLUDhxhDyzoad4eBLj6jiZPxOvhrt3nJ/PTBOLF9fKUyn7ysoYd1HdAbsV1V7eQhT68FX/V3Mj4N0K1oyJ4HlS1I6x
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6903.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a44a87c-f6ab-4b1e-ea97-08dd02ee869a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 07:49:23.9774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3URGzWR5xvsqx6M6JrCCwPh997cl1lL1VYeFLQxmGJivBnWdFA0rNQPM2RI9mQicbT+ZgZ7SjFPsW/DEYN7HJpg4ZSH4uorD70EeMrIervo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11203

SGksIEtyenlzenRvZiBLb3psb3dza2kNClRoYW5rcyBmb3IgeW91IHJldmlldy9jb21tZW50cy4N
Cg0KPiANCj4gT24gMDgvMTEvMjAyNCAwNjo0MCwgWW9zaGloaXJvIEZ1cnVkZXJhIHdyb3RlOg0K
PiA+IFRoaXMgYWRkcyBhIG5ldyBkeW5hbWljIFBNVSB0byB0aGUgUGVyZiBFdmVudHMgZnJhbWV3
b3JrIHRvIHByb2dyYW0NCj4gPiBhbmQgY29udHJvbCB0aGUgVW5jb3JlIE1BQyBQTVVzIGluIEZ1
aml0c3UgY2hpcHMuDQo+ID4NCj4gPiBUaGlzIGRyaXZlciB3YXMgY3JlYXRlZCB3aXRoIHJlZmVy
ZW5jZSB0byBkcml2ZXJzL3BlcmYvcWNvbV9sM19wbXUuYy4NCj4gPg0KPiA+IFRoaXMgZHJpdmVy
IGV4cG9ydHMgZm9ybWF0dGluZyBhbmQgZXZlbnQgaW5mb3JtYXRpb24gdG8gc3lzZnMgc28gaXQN
Cj4gPiBjYW4gYmUgdXNlZCBieSB0aGUgcGVyZiB1c2VyIHNwYWNlIHRvb2xzIHdpdGggdGhlIHN5
bnRheGVzOg0KPiA+DQo+ID4gcGVyZiBzdGF0IC1lIG1hY19pb2QwX21hYzBfY2gwL2VhLW1hYy8g
bHMgcGVyZiBzdGF0IC1lDQo+ID4gbWFjX2lvZDBfbWFjMF9jaDAvZXZlbnQ9MHg4MC8gbHMNCj4g
Pg0KPiA+IEZVSklUU1UtTU9OQUtBIFNwZWNpZmljYXRpb24gVVJMOg0KPiA+IGh0dHBzOi8vZ2l0
aHViLmNvbS9mdWppdHN1L0ZVSklUU1UtTU9OQUtBDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
b3NoaWhpcm8gRnVydWRlcmEgPGZqNTEwMGJpQGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vYWRtaW4tZ3VpZGUvcGVyZi9mdWppdHN1X21hY19wbXUucnN0ICAgICAgfCAgMjAgKw0KPiA+
ICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDEgKw0K
PiANCj4gDQo+IGRlZmNvbmZpZyBnb2VzIHZpYSB5b3VyIFNvQyBtYWludGFpbmVyLiBTcGxpdCB0
aGUgcGF0Y2ggYW5kIENjIHRoZSBTb0MgZm9sa3MuDQoNClVuZGVyc3Rvb2QuSSdsbCBkbyB0aGF0
IGFuZCByZXN1Ym1pdCB0aGUgcGF0Y2guDQoNCj4gDQo+IFdoaWNoIEFSQ0ggaXMgaXQsIEJUVz8N
Cg0KVGhpcyBpcyBzdXBwb3J0ZWQgYnkgYW4gQVJNNjQtYmFzZWQgcHJvY2Vzc29yIGNhbGxlZCBG
VUpJVFNVLU1PTkFLQSwNCndoaWNoIGlzIGN1cnJlbnRseSBiZWluZyBkZXZlbG9wZWQgYnkgRlVK
SVRTVS4NCg0KPiANCj4gDQo+ID4gIGRyaXZlcnMvcGVyZi9LY29uZmlnICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgOSArDQo+ID4gIGRyaXZlcnMvcGVyZi9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvcGVyZi9mdWppdHN1X21hY19wbXUu
YyAgICAgICAgICAgICAgICB8IDYzMw0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVk
ZS9saW51eC9jcHVob3RwbHVnLmggICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgNiBm
aWxlcyBjaGFuZ2VkLCA2NjUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wZXJmL2Z1aml0c3VfbWFjX3BtdS5yc3QNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGVyZi9mdWppdHN1X21hY19wbXUuYw0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcGVyZi9mdWppdHN1X21h
Y19wbXUucnN0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BlcmYvZnVqaXRzdV9t
YWNfcG11LnJzdA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAw
MDAwLi5kZGIzZGNmZjNjNjENCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9wZXJmL2Z1aml0c3VfbWFjX3BtdS5yc3QNCj4gPiBAQCAtMCwwICsx
LDIwIEBADQo+ID4NCj4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+ID09PT09PT09PT09PT09PT09PT0NCj4gPiArPT09PT09IEZ1aml0c3UgVW5j
b3JlIE1BQyBQZXJmb3JtYW5jZSBNb25pdG9yaW5nIFVuaXQgKFBNVSkNCj4gPg0KPiArPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPT09PT09PT09
PT09PT09PT09PQ0KPiA+ICs9PT09PT0NCj4gPiArDQo+ID4gK1RoaXMgZHJpdmVyIHN1cHBvcnRz
IHRoZSBVbmNvcmUgTUFDIFBNVXMgZm91bmQgaW4gRnVqaXRzdSBjaGlwcy4NCj4gPiArRWFjaCBN
QUMgUE1VIG9uIHRoZXNlIGNoaXBzIGlzIGV4cG9zZWQgYXMgYSB1bmNvcmUgcGVyZiBQTVUgd2l0
aA0KPiA+ICtkZXZpY2UgbmFtZSBtYWNfaW9kPGlvZD5fbWFjPG1hYz5fY2g8Y2g+Lg0KPiA+ICsN
Cj4gPiArVGhlIGRyaXZlciBwcm92aWRlcyBhIGRlc2NyaXB0aW9uIG9mIGl0cyBhdmFpbGFibGUg
ZXZlbnRzIGFuZA0KPiA+ICtjb25maWd1cmF0aW9uIG9wdGlvbnMgaW4gc3lzZnMsIHNlZQ0KPiAv
c3lzL2J1cy9ldmVudF9zb3VyY2VzL2RldmljZXMvbWFjX2lvZDxpb2Q+X21hYzxtYWM+X2NoPGNo
Pi8uDQo+ID4gK0dpdmVuIHRoYXQgdGhlc2UgYXJlIHVuY29yZSBQTVVzIHRoZSBkcml2ZXIgYWxz
byBleHBvc2VzIGEgImNwdW1hc2siDQo+ID4gK3N5c2ZzIGF0dHJpYnV0ZSB3aGljaCBjb250YWlu
cyBhIG1hc2sgY29uc2lzdGluZyBvZiBvbmUgQ1BVIHdoaWNoDQo+ID4gK3dpbGwgYmUgdXNlZCB0
byBoYW5kbGUgYWxsIHRoZSBQTVUgZXZlbnRzLg0KPiA+ICsNCj4gPiArRXhhbXBsZXMgZm9yIHVz
ZSB3aXRoIHBlcmY6Og0KPiA+ICsNCj4gPiArICBwZXJmIHN0YXQgLWUgbWFjX2lvZDBfbWFjMF9j
aDAvZWEtbWFjLyBscw0KPiA+ICsNCj4gPiArR2l2ZW4gdGhhdCB0aGVzZSBhcmUgdW5jb3JlIFBN
VXMgdGhlIGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0DQo+ID4gK3NhbXBsaW5nLCB0aGVyZWZvcmUg
InBlcmYgcmVjb3JkIiB3aWxsIG5vdCB3b3JrLiBQZXItdGFzayBwZXJmIHNlc3Npb25zIGFyZSBu
b3QNCj4gc3VwcG9ydGVkLg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVm
Y29uZmlnDQo+ID4gYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGluZGV4IDVmZGJmZWE3
YTViMi4uMmVmNDEyOTM3MjI4IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvY29uZmlncy9k
ZWZjb25maWcNCj4gPiArKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gQEAg
LTE1NzUsNiArMTU3NSw3IEBAIENPTkZJR19BUk1fQ01OPW0NCj4gQ09ORklHX0FSTV9TTU1VX1Yz
X1BNVT1tDQo+ID4gQ09ORklHX0FSTV9EU1VfUE1VPW0gIENPTkZJR19GU0xfSU1YOF9ERFJfUE1V
PW0NCj4gPiArQ09ORklHX0ZVSklUU1VfTUFDX1BNVT15DQo+ID4gIENPTkZJR19RQ09NX0wyX1BN
VT15DQo+ID4gIENPTkZJR19RQ09NX0wzX1BNVT15DQo+ID4gIENPTkZJR19BUk1fU1BFX1BNVT1t
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVyZi9LY29uZmlnIGIvZHJpdmVycy9wZXJmL0tj
b25maWcgaW5kZXgNCj4gPiBiYWI4YmE2NDE2MmYuLjQ3MDVjNjA1ZTI4NiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3BlcmYvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvcGVyZi9LY29uZmln
DQo+ID4gQEAgLTE3OCw2ICsxNzgsMTUgQEAgY29uZmlnIEZTTF9JTVg5X0REUl9QTVUNCj4gPiAg
CSBjYW4gZ2l2ZSBpbmZvcm1hdGlvbiBhYm91dCBtZW1vcnkgdGhyb3VnaHB1dCBhbmQgb3RoZXIg
cmVsYXRlZA0KPiA+ICAJIGV2ZW50cy4NCj4gPg0KPiA+ICtjb25maWcgRlVKSVRTVV9NQUNfUE1V
DQo+ID4gKwlib29sICJGdWppdHN1IFVuY29yZSBNQUMgUE1VIg0KPiA+ICsJZGVwZW5kcyBvbiAo
QVJNNjQgJiYgQUNQSSkgfHwgKENPTVBJTEVfVEVTVCAmJiA2NEJJVCkNCj4gDQo+IE1pc3Npbmcg
ZGVwZW5kcyBvbiBzcGVjaWZpYyBBUkNILg0KDQpUaGlzIGlzIGJlY2F1c2UgdGhpcyBkcml2ZXIg
c3VwcG9ydHMgdGhlIEZVSklUU1UtTU9OQUtBLA0Kd2hpY2ggaXMgYW4gQVJNNjQgYW5kIEFDUEkt
YmFzZWQgcHJvY2Vzc29yLg0KDQo+IA0KPiBTb3JyeSwgdGhpcyBsb29rcyBsaWtlIHdvcmsgZm9y
IHNvbWUgb3V0IG9mIHRyZWUgYXJjaCBzdXBwb3J0LiBJIGRvbid0IHRoaW5rIHdlIGhhdmUNCj4g
YW55IGludGVyZXN0IGluIHRha2luZyBpdC4uLiB1bmxlc3MgaXQgaXMgcGFydCBvZiBiaWdnZXIg
cGF0Y2hzZXQvd29yaz8gSWYgc28sIHRoZW4NCj4gcHJvdmlkZSAqbG9yZSogbGluayB0byByZWxl
dmFudCBwYXRjaHNldC4NCg0KSXQgaXMgZGV0ZXJtaW5lZCBieSB0aGUgQUNQSSBJRCBhbmQgZG9l
cyBub3QgZGVwZW5kIG9uIG90aGVyIHBhdGNoZXMuDQooVGhpcyBBQ1BJIElEIGlzIHVzZWQgYnkg
RlVKSVRTVS1NT05BS0EuKQ0KVGhlIFVSTHMgb2Ygb3RoZXIgcGF0Y2hlcyByZWxhdGVkIHRvIEZV
SklUU1UtTU9OQUtBIGFyZSBhcyBmb2xsb3dzOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjQxMDE4MDE1NjQwLjI5MjQ3OTQtMS1majUxMDBiaUBmdWppdHN1LmNvbS8NCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTAyNDA3MTU1My4zMDczODY0LTEtZmo1MTAwYmlAZnVq
aXRzdS5jb20vDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDExMTEwNjQ4NDMuMzAw
MzA5My0xLWZqNTEwMGJpQGZ1aml0c3UuY29tLw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCj4gDQo+IE9uIDA4LzExLzIwMjQgMTI6MDMsIEtyenlzenRvZiBLb3psb3dza2kgd3Jv
dGU6DQo+ID4gT24gMDgvMTEvMjAyNCAwNjo0MCwgWW9zaGloaXJvIEZ1cnVkZXJhIHdyb3RlOg0K
PiA+PiBUaGlzIGFkZHMgYSBuZXcgZHluYW1pYyBQTVUgdG8gdGhlIFBlcmYgRXZlbnRzIGZyYW1l
d29yayB0byBwcm9ncmFtDQo+ID4+IGFuZCBjb250cm9sIHRoZSBVbmNvcmUgTUFDIFBNVXMgaW4g
RnVqaXRzdSBjaGlwcy4NCj4gPj4NCj4gPj4gVGhpcyBkcml2ZXIgd2FzIGNyZWF0ZWQgd2l0aCBy
ZWZlcmVuY2UgdG8gZHJpdmVycy9wZXJmL3Fjb21fbDNfcG11LmMuDQo+IA0KPiBUaGlzIGNvbmZ1
c2VkIG1lLi4uDQoNClRoaXMgZHJpdmVyIHdhcyBjcmVhdGVkIGJhc2VkIG9uIGRyaXZlcnMvcGVy
Zi9xY29tX2wzX3BtdS5jLg0KVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSBwcm9jZXNzaW5nIGRvbmUg
dG8gUXVhbGNvbW0ncyBMMyBjYWNoZSBQTVUgcmVnaXN0ZXJzIGluDQpxY29tX2wzX3BtdS5jIGlz
IHNpbWlsYXIgdG8gdGhlIHByb2Nlc3NpbmcgZG9uZSB0byB0aGUgVW5jb3JlIE1BQy9QQ0kgUE1V
IHJlZ2lzdGVycy4NClNwZWNpZmljYWxseSwgdGhlIGJhc2ljIHByb2Nlc3NpbmcgaXMgdGhlIHNh
bWUgYXMgZHJpdmVycy9wZXJmL3Fjb21fbDNfcG11LmMsDQpidXQgdGhlIHZhcmlhYmxlIG5hbWVz
LCBmdW5jdGlvbiBuYW1lcywgQUNQSSBkZXZpY2UgSUQsIGFuZCBzb21lIHByb2Nlc3NpbmcgaGF2
ZQ0KYmVlbiBtb2RpZmllZCB0byBtYXRjaCBGVUpJVFNVLU1PTkFLQSdzIFVuY29yZSBNQUMgUE1V
Lg0KDQo+IA0KPiA+PiAgQ09ORklHX0FSTV9TUEVfUE1VPW0NCj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGVyZi9LY29uZmlnIGIvZHJpdmVycy9wZXJmL0tjb25maWcgaW5kZXgNCj4gPj4gYmFi
OGJhNjQxNjJmLi40NzA1YzYwNWUyODYgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvcGVyZi9L
Y29uZmlnDQo+ID4+ICsrKyBiL2RyaXZlcnMvcGVyZi9LY29uZmlnDQo+ID4+IEBAIC0xNzgsNiAr
MTc4LDE1IEBAIGNvbmZpZyBGU0xfSU1YOV9ERFJfUE1VDQo+ID4+ICAJIGNhbiBnaXZlIGluZm9y
bWF0aW9uIGFib3V0IG1lbW9yeSB0aHJvdWdocHV0IGFuZCBvdGhlciByZWxhdGVkDQo+ID4+ICAJ
IGV2ZW50cy4NCj4gPj4NCj4gPj4gK2NvbmZpZyBGVUpJVFNVX01BQ19QTVUNCj4gPj4gKwlib29s
ICJGdWppdHN1IFVuY29yZSBNQUMgUE1VIg0KPiA+PiArCWRlcGVuZHMgb24gKEFSTTY0ICYmIEFD
UEkpIHx8IChDT01QSUxFX1RFU1QgJiYgNjRCSVQpDQo+ID4NCj4gPiBNaXNzaW5nIGRlcGVuZHMg
b24gc3BlY2lmaWMgQVJDSC4NCj4gPg0KPiA+IFNvcnJ5LCB0aGlzIGxvb2tzIGxpa2Ugd29yayBm
b3Igc29tZSBvdXQgb2YgdHJlZSBhcmNoIHN1cHBvcnQuIEkgZG9uJ3QNCj4gPiB0aGluayB3ZSBo
YXZlIGFueSBpbnRlcmVzdCBpbiB0YWtpbmcgaXQuLi4gdW5sZXNzIGl0IGlzIHBhcnQgb2YgYmln
Z2VyDQo+ID4gcGF0Y2hzZXQvd29yaz8gSWYgc28sIHRoZW4gcHJvdmlkZSAqbG9yZSogbGluayB0
byByZWxldmFudCBwYXRjaHNldC4NCj4gPg0KPiANCj4gLUVOT1RFTk9VR0hDT0ZGRUUsIEkgc2Vl
IG5vdyBBQ1BJIGRlcGVuZGVuY3kgc28gdGhlcmUgd2lsbCBiZSBubyBTb0MNCj4gZm9sa3MgZm9y
IHRoaXMsIHJpZ2h0PyAgVGhlbiBhbnl3YXkgc3BsaXQgd29yayBwZXIgc3Vic3lzdGVtIGFuZCBz
ZW5kDQo+IGRlZmNvbmZpZyB0byBTb2MgbWFpbnRhaW5lcnMuDQoNClllcywgd2Ugb25seSB1c2Ug
QUNQSSBJRC4gDQpJJ2xsIGRvIHRoYXQgYW5kIHJlc3VibWl0IHRoZSBwYXRjaC4NCg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpCZXN0IFJlZ2FyZHMsDQpZb3NoaWhpcm8gRnVydWRl
cmENCg==

