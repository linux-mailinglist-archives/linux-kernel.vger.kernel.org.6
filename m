Return-Path: <linux-kernel+bounces-292098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD11956B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0599528313C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5816B753;
	Mon, 19 Aug 2024 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RkXbVVjd"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A75165F18;
	Mon, 19 Aug 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071199; cv=fail; b=gjFy7Q+JpS2+m90MpCH6/1fRZJ7Uzy+yCwj3PZL7OD5kFdlnM2xVn8oixDzQKUnZT7caVsOCkphFF4dqDoiseP/81qpWEu9QBPyxh2V9rvx1Y4KG1dVHVdsjQawrJaRzr1oaL6YNfMPBCR4qMYK17NIqjlAGeOw2ASPCklkWITg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071199; c=relaxed/simple;
	bh=qmtjsvd+cdAWtRvTb7p2CZ2DgkJi85bu6sLFZr+HRGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AEmdfLZ8c6vr1phFz3j6CqkZqXzPTaBCc3Y226fBI+ZOkGxCJCLS47UV39eAVwupZjd5h3a7mqEFu3MxEVVxNWCF8bijPbGqP8fAe5bbSGqMzqR6GoirXHCy1/q+XlyN92Yl3fg2ftxGx7+1AADcSSbxH5j/ccXS8Y2SMA1dVCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RkXbVVjd; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/wJOe2utc7DW/Vhe1qTwcYmUbdgdfr6u40RlvOI/Ty6zeZ8usYTVTgF2F1QHSR53kfFR8RLwZnJ/OCbx9n7gzibT3QJDGt6L9RWiF4a0yDeesP8fZqYlQJfbmY93x8FlF3hPnRbJSRmXXUmoWh81JoO9LycyeM4Zsca+zHF69jefEBxsSK2ryjDZ5hqN9kBf/PdQJPhlN6XokR4klNO3cq1bkZeL02zYw0gkryhjQ3rBWZfo71qmhZVKJIZ5TdxtlMOOhIqIAXJrFQp9OE4i52eKDRSqwVl7wbgjiKVtw9TK9jyzvR6iQSJ/AnaliX5CW5wqFLGce/Fjxvo0pMuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmtjsvd+cdAWtRvTb7p2CZ2DgkJi85bu6sLFZr+HRGw=;
 b=gELNeoLfYfjyorHl2NuHREGFjY/Llh8oYEVwFpRsPyVrvQLNaNJ7mxr3gzIJlkK3CxnWTWLrYDc2mn6Rv1IQCd7yofdsz5iY5I8HCEeqaSMSdCW9UOtVaNYoFfhPVHTZkBEA0A6oTKjXHk6jjODBD5EGJlXKDC+uoWA7IH0y4S4ryPOHdhdqq6kBuJ1okXayxaRYylsw2GgBfMaDSWeg948wp9ninem8oeiW2UBa6xyxDkTJGrMjxLfDQagomJ/uKHbMMsLaSpvuBszWZY/aNzJ27ojsS2gZUtW6vizoNP1vQE3m1DbLFQx30btH09NLeQ0u0OCQ7+GoiBL+adMm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmtjsvd+cdAWtRvTb7p2CZ2DgkJi85bu6sLFZr+HRGw=;
 b=RkXbVVjd0NlBxGfrWKuuGZD4tIyLOBOEI5p1oCJmOOaEavRfbkm2/srf5pilNXYP3XILiaUt472OIs9OKhwR7TrpBVQFwBkiAZ6FUakVt+bCbXd4mEo0eJOBB9xySQDSUhSoD8HgDsMZ2vygQDjotxIgCeiHQNcoovlQVh6wY3Q=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:39:52 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:39:52 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Harry Austen <hpausten@protonmail.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 6/9] clk: clocking-wizard: add user clock monitor
 support
Thread-Topic: [PATCH v2 6/9] clk: clocking-wizard: add user clock monitor
 support
Thread-Index: AQHa5ZQWy4iAfPkmiE+WG+znss6Y1bIunUmw
Date: Mon, 19 Aug 2024 12:39:52 +0000
Message-ID:
 <SA1PR12MB89477EFB7053170705AB6591818C2@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20240803105702.9621-1-hpausten@protonmail.com>
 <20240803105702.9621-7-hpausten@protonmail.com>
In-Reply-To: <20240803105702.9621-7-hpausten@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=66463115-cb44-48d9-bb3c-ad1b8ad2063e;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-19T12:35:06Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|DM4PR12MB6374:EE_
x-ms-office365-filtering-correlation-id: 421adf37-ac8d-4f5f-5121-08dcc04c05d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1lOcG52bmRLVEoxYmprTjRZQzFsRTl6NFN4VEVxTXdmSU5GVTQ5WjhjaG1s?=
 =?utf-8?B?WEVodEU1azRaaiszU2lGWWNyQlgxUkdnMlFuWjlTZGRuWGdUZVh4cjRUTkRH?=
 =?utf-8?B?UE5YOXFtdGJ3b1RIWmdhNXgzODVmK1dHRnlVaCtLdXVlcVAreGs1NXZ3R3VE?=
 =?utf-8?B?enh2a2ZBZVlWUzRBUzU2RHJXT3h1R3I0d1pMTzVsaGJNN2czOVdxM1ViUnRi?=
 =?utf-8?B?YVBHd01EdGhNK1hJQ0w3V1YySk5KWjFSdE01eUU0ZlBQa28yb2xIWFFkTnZH?=
 =?utf-8?B?N2FPWmF5OXZzdGNrcFA3TUlXYTB1RjR4YlljcU9SYWpWY2FUbjVZZVhPWlJN?=
 =?utf-8?B?ZWE0eWNrVGg3dy8xc002eXFUckJvZ1I3YitlbzJEL0MyYUNxeHJ6MTJVZE1i?=
 =?utf-8?B?MEtjcDRQRDFuZzAzMXhkbGRHc0gybWF0N1ZLNlY3TFMzeDFlZXZSSmYxVzZt?=
 =?utf-8?B?NUdHNkJ2cW5NTW1iOWdoZHRqOUEwMms0VG5aVzBYTEdpaU5CWXM2bVJOS3ZY?=
 =?utf-8?B?UHJKMDJkdE52ZW04L2hZUm1PZ0QySWRNRGRaTEcyKy9Rb3pBZmRRc3dLcTNF?=
 =?utf-8?B?ZW5uSGJUaHZ2MnpJK2JOVTNjUDA1d3lQM2x3enJXdlFwYU8zMlJnMGdnUGxZ?=
 =?utf-8?B?YkVaVmlMc1lOQ0RDSmpvcEx5Z0hOVElRUHZkd09lSXJhcm1JekhoVnpIQjA4?=
 =?utf-8?B?eXQ2TFVBQWpHdmlZaDdTRE4xT2I1OGNuWk02OTNVYy93ZU44NXhrMjhVRmdw?=
 =?utf-8?B?Y3pGQ0lFbWlmLzhkcEF0SFNxenAvRmE2SUZlN1V1YzBFWFM5S2NheWlEamZJ?=
 =?utf-8?B?ZGgrbm9vU3h5Z2g5dzR0eXRxUTNxcjZ5VzNyWE5ERTVCdElZM2duaEZUVHVE?=
 =?utf-8?B?VFgvdVlOOUxLbEZBNXpXT3FieHJnZWdvVzlJd240V1hSSnA5UXRtT0Q3S3BG?=
 =?utf-8?B?Zm5BZ1NvYzc5MXZOMlZXUGlrRXRDVWI0alc4djZJdGdFb1ovc3RySEJ2ZU05?=
 =?utf-8?B?S0NpbnZUdjhGQXdhdWlGaFkrRkxDaU9WWGJGdHZ0clp4aVZtV3FIV1FFVnRV?=
 =?utf-8?B?c2M0VVB3c01jL0V3MUsxQVdjK0lEM3hjejErb0w0NEwwR25IaitHSFF4ZFg3?=
 =?utf-8?B?YkZ5WU4yVzB6SWVEMUdMbm1tOVJyNHdPcUpvMkkwYVd2cGlCTVIvaVhzSFd1?=
 =?utf-8?B?Tnd0QUVkSVJFeGFkR1E2cjF0QThJRkJkaUhxa2VIOHl2M2NvNEt2bzZxTHpM?=
 =?utf-8?B?cUwrWkpuZGVod3FJVlpsNGlxc0lUMk9laSsyUDBaVGltVm1mVVo3MVgvODJy?=
 =?utf-8?B?WHVQVVN1cDZESURDdW91VytvWnpEd1BEUFZZYndGOFYvTzZSdjhWU0lZaDN2?=
 =?utf-8?B?bXFaVkxMSEhZbUQ1cXdSSCtYdUk1YXMzdW0rZ09vN3FETmpoQlBpVndPTlJG?=
 =?utf-8?B?dkxTYk44c0FmbW93NkpsNlcwcGhkZGdPT0pCcStuWDRiOVZWbE1TT0dLOU9G?=
 =?utf-8?B?dVpkN3F2M2pkKzRUakRIbS95OUdHa0Jnc0EwYldIS0hlTW1KYVM5a3NiY1R0?=
 =?utf-8?B?K1NyNFVkUGk5anBrdW4yaFN4OWlSWFdXeHBidzBlWTdSSjZ0WVRZY1ZYODJm?=
 =?utf-8?B?Y3gvSHMwTXJ2QnlFdWhlRW1rMUhWN3NRa1hFbmJjbmlJNlQzTFBqV1A5aStW?=
 =?utf-8?B?RklibjZodGtacTVxNk9uZTkzU0RaRHJkTHR5cjkvSGdsTkpGSU92MlZhSFkv?=
 =?utf-8?B?b2RKc1JGUDEwSUZ5SGNhWmtYa2Q5YmxUdW80RnYvbjlnd0tCQ2VneGlhc3JW?=
 =?utf-8?B?WHZmSFc0STFpaHdhbmhSajhBaUR2TDdLNFVJVVhJdTQ1MjgwSmNNUE5kbjF2?=
 =?utf-8?B?MDhDb0FzRyt3NjdhYVJWTlg0M0c1Q3plMUZRcVViVDBTNFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWE4R2hPQ2hUMkIvVkR2MzJVeklRaE5CQW5NTzNSV1pjM25xTnlmR3dLYW5I?=
 =?utf-8?B?eVB0ZlFjWWdyZDdaTzRWNFZ6c0hVTkNhYVZvT1RERjdBTlV0ZVZvUWc4bTZE?=
 =?utf-8?B?Nms4MXBzd2NTUzdQcXYzZTZhS21FZ0dmL29jalR5WnZKQkJPTS9jczVsbzRH?=
 =?utf-8?B?NlFuOGs5QzdmMGczN2hwUkcvL1Z5d3h1dTZmdXRlNE0wZmpJTmp4dDBDb1JF?=
 =?utf-8?B?MFZVNHgvUTJOeEV4L0E4Q2ovSHNiRG1zRGZmcXhmaWtVMGsvdkxDZ1NKRzh5?=
 =?utf-8?B?ODlZODRJcy9pTG1SZnk0aldrRDJuTStlbExDMXczZ3hTWDhTTHlPeVovN1d2?=
 =?utf-8?B?WERUVWdLYkpUUHZISXZmV0N3dm8xbFZNSDdpUlJnVk5SUTdlWEkySzh0SWp5?=
 =?utf-8?B?OUFrWFdBU2c1Wi9OckNKSG5nTHB0bWFCWStwN1dOL0lVdWI5dzhjZzNKVUV6?=
 =?utf-8?B?VnkzMkNkcC91V1ZGbHN2OEFBREx0emtTUVJCdkFjQU9MMHp4SSt6ZDRNekc0?=
 =?utf-8?B?ampQemQvVkx4Z1RtSVBUQ1ErZWpzVWk4dHpDNFB6WDR4QUdxNkY3UEp2VE5p?=
 =?utf-8?B?L1R1LzgrTlc0V044bTB5UTJRWEN4Vk1DYTRKMldvMG5Hb2cvTWZmbFNsU1dR?=
 =?utf-8?B?ckVka1l6UHNEdEtFVGkwZ3BvaHNRQXJFTW5CMHlrTkkwODAxaFUwWTFYQnNp?=
 =?utf-8?B?MytQZDFVT21VZ0dZQ1ZBVVlnYlM1dERnUSt2djNHeGxWYTgzYzhiK2pVN1Ay?=
 =?utf-8?B?N29nK1dJdVdyUVNYSUhubWU0RHZOQUZ6eVh5ZE5LYU1jYWl6UHFLb0lZRGFU?=
 =?utf-8?B?eU9yOVlvUGpjRnZuNW8xdjBjaklLMDNKV2RTWkJjaW5KQnpkTThUS3dmR1Zw?=
 =?utf-8?B?Mks4Uk9KSjB6NitWeFdpR0p6Tm0yUzVWM1dTOVhLSXJSdUE5VCtiZDJkM2Zj?=
 =?utf-8?B?Tnp1U1NiTG5ZcFc3dUg0YmtTWGhmTTFuajF6N3JDbnptZ3hBSFVJK3h1bjBQ?=
 =?utf-8?B?V01HNDVvSDZYMjhUcjQwZ01CdEo4aGdKLytlMFFNTXBqSEF4Uy8yOU1jMjBP?=
 =?utf-8?B?eklPcEFjSnhuSXhUNUdPSzVIZnU5S3gxNkplSDB1OGQ2aVdmRVpEcmRZK05M?=
 =?utf-8?B?VmFLL0NjNURSSW5UYXZxVWhRcEtlM0dOOHBPeUlTbCs5bGR0Y3Nycnh5Z1I4?=
 =?utf-8?B?RzkwQ3pJQWRFTUdRb1NETlA2clNwbGh1OGlYc2NnVzRta1hFOGJtdkFpTEty?=
 =?utf-8?B?R09vYzV1ZnYzdlkxNVVhUndnL0ZpNmR5OUVwS2hzbmJJSHVOOGtIU2lLZmpx?=
 =?utf-8?B?WDU2ZzBOMXFMaTJGRFJaLzBnUHdiMDVmZGRBVndLcDIrT0U1NjVBSWVaU1Vr?=
 =?utf-8?B?UXRHZDV0KzkrZzBPenVtdGpzeDlIdTYxdUpvMGFMeHFnNllPbGpwc2EvZjd3?=
 =?utf-8?B?KzNKN3krVGhyaGsyNUgyMkQ5S09iVExLSitJS1dzekNnZXZIcWh4RFJhVnIv?=
 =?utf-8?B?M3EwZXNzb1pNRG92MWk5V3F5TTNHV0w2RU40OUpMbEpUZ0U2ZUwvbmROVUs5?=
 =?utf-8?B?NXNJdTFTN1dHR3lWT1E4bUgvdE9QZk03aGpoczJOSncvcVp6aEdBR056OXNY?=
 =?utf-8?B?bGFXK01EdFBuK0RXUWJ4bUlIWDcwRExhY3EvR3MxZWVueFZZcm5pd0VnU0pX?=
 =?utf-8?B?Z3RteWM2QmtOd3VRL0plZ1FqWUMwc3I4U01iTWFGa1Jkb2JhcENNODRpZ0Fp?=
 =?utf-8?B?QmVIcS81bXByUG1mKzk4QlBtZTJUTVYvWEdaNWVvelVPZTlwSjFPQSs2MnlU?=
 =?utf-8?B?TDc0Zk9wUlFXcTNtUmNqWU5MOWNWOFJKMkhsWG84MlJ3NmpPMnZJa1dIUy9T?=
 =?utf-8?B?K2hNTjc0clJYWmtTTUROSTRTdGJCRUcvc3FlcVN4K0NBRVZCS1llMXlFQURT?=
 =?utf-8?B?ZytHRVJ6KzFqcVlDYWJSTVl5a2MyYVI4djlNRDNHem5FL1BjS3g3VzRKTUF3?=
 =?utf-8?B?WldOdnluQXBVK0ROR1dIUUJXcFEraHo1Zm10czRmait2dHdRMWFzVDdPRUhp?=
 =?utf-8?B?eERaK1RLZzg0eEVrQVIxUDdDV1ZsTFdXdktETGdSMVVDcXBJc1R0dm1XUXZM?=
 =?utf-8?Q?ldGw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421adf37-ac8d-4f5f-5121-08dcc04c05d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 12:39:52.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hUWsVAaVY3q6IIeVE3WiwjlLjtjxmq1aGsalnw3/LXXZraNqirRLlljJ5/lBjE2Ho+fjLo/KXDNCgqTQwPWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYXJyeSBBdXN0ZW4gPGhw
YXVzdGVuQHByb3Rvbm1haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDMsIDIwMjQg
NDoyOCBQTQ0KPiBUbzogTWljaGFlbCBUdXJxdWV0dGUgPG10dXJxdWV0dGVAYmF5bGlicmUuY29t
PjsgU3RlcGhlbiBCb3lkDQo+IDxzYm95ZEBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyemsrZHRAa2VybmVsLm9yZz47
IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IFNpbWVrLCBNaWNoYWwNCj4gPG1p
Y2hhbC5zaW1la0BhbWQuY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4NCj4gQ2M6IERhdHRhLCBTaHViaHJhanlvdGkgPHNodWJocmFqeW90aS5k
YXR0YUBhbWQuY29tPjsgRGF2ZSBFcnRtYW4NCj4gPGRhdmlkLm0uZXJ0bWFuQGludGVsLmNvbT47
IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT47IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJu
ZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgSGFycnkg
QXVzdGVuDQo+IDxocGF1c3RlbkBwcm90b25tYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYy
IDYvOV0gY2xrOiBjbG9ja2luZy13aXphcmQ6IGFkZCB1c2VyIGNsb2NrIG1vbml0b3Igc3VwcG9y
dA0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFs
IFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywg
Y2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IFhpbGlueCBjbG9ja2luZyB3
aXphcmQgSVAgY29yZSBzdXBwb3J0cyBtb25pdG9yaW5nIG9mIHVwIHRvIGZvdXIgb3B0aW9uYWwg
dXNlcg0KPiBjbG9jayBpbnB1dHMsIHdpdGggYSBjb3JyZXNwb25kaW5nIGludGVycnVwdCBmb3Ig
bm90aWZpY2F0aW9uIGluIGNoYW5nZSBvZg0KPiBjbG9jayBzdGF0ZSAoc3RvcCwgdW5kZXJydW4s
IG92ZXJydW4gb3IgZ2xpdGNoKS4gR2l2ZSBhY2Nlc3MgdG8gdGhpcyBtb25pdG9yDQo+IGxvZ2lj
IHRocm91Z2ggdXNlIG9mIGFuIGF1eGlsaWFyeSBkZXZpY2UuDQo+DQo+IFVzZSBwcmVzZW5jZSBv
ZiB0aGUgdXNlciBtb25pdG9yIGludGVycnVwdCBkZXNjcmlwdGlvbiBpbiBkZXZpY2V0cmVlIHRv
DQo+IGluZGljYXRlIHdoZXRoZXIgb3Igbm90IHRoZSBhdXhpbGlhcnkgZGV2aWNlIHNob3VsZCBi
ZSByZWdpc3RlcmVkLiBBbHNvLCB0aGlzDQo+IGZ1bmN0aW9uYWxpdHkgaXMgb25seSBzdXBwb3J0
ZWQgZnJvbSB2Ni4wIG9ud2FyZHMsIHNvIGFkZCBpbmRpY2F0aW9uIG9mDQo+IHN1cHBvcnQgdG8g
dGhlIGRldmljZSBtYXRjaCBkYXRhLCBpbiBvcmRlciB0byBiZSB0aWVkIHRvIHRoZSB1dGlsaXNl
ZA0KPiBjb21wYXRpYmxlIHN0cmluZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSGFycnkgQXVzdGVu
IDxocGF1c3RlbkBwcm90b25tYWlsLmNvbT4NCj4gLS0tDQo+IHYxIC0+IHYyOg0KPiAtIFJlbW92
ZSBkaXJlY3QgVUlPIGRlcGVuZGVuY3kgYnkgdXRpbGlzaW5nIGF1eGlsaWFyeSBkZXZpY2UNCj4g
LSBNb3ZlIHNvbWUgbG9naWMgZnJvbSBwcm9iZSBpbnRvIGNsa193enJkX3NldHVwX21vbml0b3Ig
Zm9yIHRpZGluZXNzDQo+DQo+ICBkcml2ZXJzL2Nsay94aWxpbngvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgfCAgMSArDQo+ICBkcml2ZXJzL2Nsay94aWxpbngvY2xrLXhsbngtY2xvY2std2l6YXJk
LmMgfCA2MCArKysrKysrKysrKysrKysrKysrKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDU2IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay94aWxpbngvS2NvbmZpZyBiL2RyaXZlcnMvY2xrL3hpbGlueC9LY29uZmlnIGluZGV4DQo+IDA1
MTc1Njk1MzU1OGIuLjg3ZjUwN2JkOWI2ZjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL3hp
bGlueC9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvY2xrL3hpbGlueC9LY29uZmlnDQo+IEBAIC0y
MSw2ICsyMSw3IEBAIGNvbmZpZyBDT01NT05fQ0xLX1hMTlhfQ0xLV1pSRA0KPiAgICAgICAgIHRy
aXN0YXRlICJYaWxpbnggQ2xvY2tpbmcgV2l6YXJkIg0KPiAgICAgICAgIGRlcGVuZHMgb24gT0YN
Cj4gICAgICAgICBkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiArICAgICAgIHNlbGVjdCBBVVhJTElB
UllfQlVTDQo+ICAgICAgICAgaGVscA0KPiAgICAgICAgICAgU3VwcG9ydCBmb3IgdGhlIFhpbGlu
eCBDbG9ja2luZyBXaXphcmQgSVAgY29yZSBjbG9jayBnZW5lcmF0b3IuDQo+ICAgICAgICAgICBB
ZGRzIHN1cHBvcnQgZm9yIGNsb2NraW5nIHdpemFyZCBhbmQgY29tcGF0aWJsZS4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL3hpbGlueC9jbGsteGxueC1jbG9jay13aXphcmQuYyBiL2RyaXZl
cnMvY2xrL3hpbGlueC9jbGstDQo+IHhsbngtY2xvY2std2l6YXJkLmMNCj4gaW5kZXggMWY4MDIz
ZDI0MDI5Zi4uNTU3ZTExMDE3ZmFmOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsveGlsaW54
L2Nsay14bG54LWNsb2NrLXdpemFyZC5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL3hpbGlueC9jbGst
eGxueC1jbG9jay13aXphcmQuYw0KPiBAQCAtOCw2ICs4LDcgQEANCj4gICAqDQo+ICAgKi8NCj4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9hdXhpbGlhcnlfYnVzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
Yml0ZmllbGQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gQEAgLTEyOSw2ICsxMzAsNyBAQCBlbnVtIGNsa193enJk
X2ludF9jbGtzIHsNCj4gICAqIEBheGlfY2xrOiAgICAgICAgICAgSGFuZGxlIHRvIGlucHV0IGNs
b2NrICdzX2F4aV9hY2xrJw0KPiAgICogQGNsa3NfaW50ZXJuYWw6ICAgICBJbnRlcm5hbCBjbG9j
a3MNCj4gICAqIEBzcGVlZF9ncmFkZTogICAgICAgU3BlZWQgZ3JhZGUgb2YgdGhlIGRldmljZQ0K
PiArICogQGFkZXY6ICAgICAgICAgICAgICBVc2VyIGNsb2NrIG1vbml0b3IgYXV4aWxpYXJ5IGRl
dmljZQ0KPiAgICogQHN1c3BlbmRlZDogICAgICAgICBGbGFnIGluZGljYXRpbmcgcG93ZXIgc3Rh
dGUgb2YgdGhlIGRldmljZQ0KPiAgICovDQo+ICBzdHJ1Y3QgY2xrX3d6cmQgew0KPiBAQCAtMTM5
LDYgKzE0MSw3IEBAIHN0cnVjdCBjbGtfd3pyZCB7DQo+ICAgICAgICAgc3RydWN0IGNsa19odyAq
Y2xrc19pbnRlcm5hbFt3enJkX2Nsa19pbnRfbWF4XTsNCj4gICAgICAgICB1bnNpZ25lZCBpbnQg
c3BlZWRfZ3JhZGU7DQo+ICAgICAgICAgYm9vbCBzdXNwZW5kZWQ7DQo+ICsgICAgICAgc3RydWN0
IGF1eGlsaWFyeV9kZXZpY2UgYWRldjsNCj4gICAgICAgICBzdHJ1Y3QgY2xrX2h3X29uZWNlbGxf
ZGF0YSBjbGtfZGF0YTsgIH07DQo+DQo+IEBAIC0xNzEsOCArMTc0LDkgQEAgc3RydWN0IGNsa193
enJkX2RpdmlkZXIgew0KPiAgICAgICAgIHNwaW5sb2NrX3QgKmxvY2s7ICAvKiBkaXZpZGVyIGxv
Y2sgKi8gIH07DQo+DQo+IC1zdHJ1Y3QgdmVyc2FsX2Nsa19kYXRhIHsNCj4gK3N0cnVjdCBjbGtf
d3pyZF9kYXRhIHsNCj4gICAgICAgICBib29sIGlzX3ZlcnNhbDsNCj4gKyAgICAgICBib29sIHN1
cHBvcnRzX21vbml0b3I7DQo+ICB9Ow0KPg0KPiAgI2RlZmluZSB0b19jbGtfd3pyZChfbmIpIGNv
bnRhaW5lcl9vZihfbmIsIHN0cnVjdCBjbGtfd3pyZCwgbmIpIEBAIC0NCj4gOTU4LDE2ICs5NjIs
NTggQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBjbGtfd3pyZF9yZXN1bWUoc3RydWN0DQo+
IGRldmljZSAqZGV2KSAgc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKGNsa193enJkX2Rldl9wbV9v
cHMsDQo+IGNsa193enJkX3N1c3BlbmQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBjbGtf
d3pyZF9yZXN1bWUpOw0KPg0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCB2ZXJzYWxfY2xrX2RhdGEg
dmVyc2FsX2RhdGEgPSB7DQo+IC0gICAgICAgLmlzX3ZlcnNhbCAgICAgID0gdHJ1ZSwNCj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX3d6cmRfZGF0YSB2ZXJzaW9uXzZfMF9kYXRhID0gew0KPiAr
ICAgICAgIC5pc192ZXJzYWwgICAgICAgICAgICAgID0gZmFsc2UsDQo+ICsgICAgICAgLnN1cHBv
cnRzX21vbml0b3IgICAgICAgPSB0cnVlLA0KPiAgfTsNCg0KVGhlIGNsb2NraW5nIHdpemFyZCBt
b25pdG9yIHN1cHBvcnQgaXMgYSBkZXNpZ24gY2hvaWNlLg0KVGhpcyB3aWxsIGVuYWJsZSBpdCBm
b3IgYWxsIHRoZSBkZXNpZ25zLg0KDQo+DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNsa193enJk
X2RhdGEgdmVyc2FsX2RhdGEgPSB7DQo+ICsgICAgICAgLmlzX3ZlcnNhbCAgICAgICAgICAgICAg
PSB0cnVlLA0KPiArICAgICAgIC5zdXBwb3J0c19tb25pdG9yICAgICAgID0gdHJ1ZSwNCj4gK307
DQoNCg0KU2FtZSBoZXJlLg0KDQo+ICsNCj4gK3N0YXRpYyB2b2lkIGNsa193enJkX3VucmVnaXN0
ZXJfYWRldih2b2lkICpfYWRldikgew0KPiArICAgICAgIHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNl
ICphZGV2ID0gX2FkZXY7DQo+ICsNCj4gKyAgICAgICBhdXhpbGlhcnlfZGV2aWNlX2RlbGV0ZShh
ZGV2KTsNCj4gKyAgICAgICBhdXhpbGlhcnlfZGV2aWNlX3VuaW5pdChhZGV2KTsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIGludCBjbGtfd3pyZF9zZXR1cF9tb25pdG9yKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpIHsNCj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2
Ow0KPiArICAgICAgIGNvbnN0IHN0cnVjdCBjbGtfd3pyZF9kYXRhICpkYXRhID0gZGV2aWNlX2dl
dF9tYXRjaF9kYXRhKGRldik7DQo+ICsgICAgICAgc3RydWN0IGNsa193enJkICpjbGtfd3pyZCA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArICAgICAgIHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNl
ICphZGV2ID0gJmNsa193enJkLT5hZGV2Ow0KPiArICAgICAgIGludCByZXQ7DQo+ICsNCj4gKyAg
ICAgICBpZiAoIWRhdGEgfHwgIWRhdGEtPnN1cHBvcnRzX21vbml0b3IpDQo+ICsgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gKw0KPiArICAgICAgIGFkZXYtPm5hbWUgPSAiY2xrLW1vbiI7DQo+
ICsgICAgICAgYWRldi0+ZGV2LnBhcmVudCA9IGRldjsNCj4gKyAgICAgICBhZGV2LT5kZXYucGxh
dGZvcm1fZGF0YSA9IChfX2ZvcmNlIHZvaWQgKiljbGtfd3pyZC0+YmFzZTsNCj4gKw0KPiArICAg
ICAgIHJldCA9IGF1eGlsaWFyeV9kZXZpY2VfaW5pdChhZGV2KTsNCj4gKyAgICAgICBpZiAocmV0
KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKw0KPiArICAgICAgIHJldCA9IGF1
eGlsaWFyeV9kZXZpY2VfYWRkKGFkZXYpOw0KPiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAg
ICAgICAgICAgIGF1eGlsaWFyeV9kZXZpY2VfdW5pbml0KGFkZXYpOw0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICByZXR1cm4gZGV2bV9h
ZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgY2xrX3d6cmRfdW5yZWdpc3Rlcl9hZGV2LA0KPiArYWRl
dik7IH0NCj4gKw0KPiAgc3RhdGljIGludCBjbGtfd3pyZF9yZWdpc3Rlcl9vdXRwdXRfY2xvY2tz
KHN0cnVjdCBkZXZpY2UgKmRldiwgaW50DQo+IG5yX291dHB1dHMpICB7DQo+ICAgICAgICAgY29u
c3QgY2hhciAqY2xrb3V0X25hbWUsICpjbGtfbmFtZSwgKmNsa19tdWxfbmFtZTsNCj4gICAgICAg
ICBzdHJ1Y3QgY2xrX3d6cmQgKmNsa193enJkID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAg
ICAgICAgdTMyIHJlZ2wsIHJlZ2gsIGVkZ2UsIHJlZ2xkLCByZWdoZCwgZWRnZWQsIGRpdjsNCj4g
LSAgICAgICBjb25zdCBzdHJ1Y3QgdmVyc2FsX2Nsa19kYXRhICpkYXRhOw0KPiArICAgICAgIGNv
bnN0IHN0cnVjdCBjbGtfd3pyZF9kYXRhICpkYXRhOw0KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcg
ZmxhZ3MgPSAwOw0KPiAgICAgICAgIGJvb2wgaXNfdmVyc2FsID0gZmFsc2U7DQo+ICAgICAgICAg
dm9pZCBfX2lvbWVtICpjdHJsX3JlZzsNCj4gQEAgLTExNzAsNiArMTIxNiwxMCBAQCBzdGF0aWMg
aW50IGNsa193enJkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gICAgICAgICB9DQo+DQo+ICsgICAgICAg
cmV0ID0gY2xrX3d6cmRfc2V0dXBfbW9uaXRvcihwZGV2KTsNCj4gKyAgICAgICBpZiAocmV0KQ0K
PiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgcmV0LCAi
ZmFpbGVkIHRvIHNldHVwDQo+ICsgbW9uaXRvclxuIik7DQo+ICsNCj4gICAgICAgICByZXQgPSBj
bGtfd3pyZF9yZWdpc3Rlcl9vdXRwdXRfY2xvY2tzKCZwZGV2LT5kZXYsIG5yX291dHB1dHMpOw0K
PiAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiBAQCAt
MTIwNCw3ICsxMjU0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY2xrX3d6
cmRfaWRzW10gPSB7DQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJ4bG54LHZlcnNhbC1jbGst
d2l6YXJkIiwgLmRhdGEgPSAmdmVyc2FsX2RhdGEgfSwNCj4gICAgICAgICB7IC5jb21wYXRpYmxl
ID0gInhsbngsY2xvY2tpbmctd2l6YXJkIiAgIH0sDQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9
ICJ4bG54LGNsb2NraW5nLXdpemFyZC12NS4yIiAgIH0sDQo+IC0gICAgICAgeyAuY29tcGF0aWJs
ZSA9ICJ4bG54LGNsb2NraW5nLXdpemFyZC12Ni4wIiAgfSwNCj4gKyAgICAgICB7IC5jb21wYXRp
YmxlID0gInhsbngsY2xvY2tpbmctd2l6YXJkLXY2LjAiLCAuZGF0YSA9DQo+ICsgJnZlcnNpb25f
Nl8wX2RhdGEgfSwNCj4gICAgICAgICB7IH0sDQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJM
RShvZiwgY2xrX3d6cmRfaWRzKTsNCj4gLS0NCj4gMi40Ni4wDQo+DQoNCg==

