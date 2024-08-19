Return-Path: <linux-kernel+bounces-291372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362F956153
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3095F1C214F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28213C8EE;
	Mon, 19 Aug 2024 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="OhPDdphL"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3D13B7B3;
	Mon, 19 Aug 2024 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036754; cv=fail; b=bQu9bYnbKUv447cHnYIUjQTtMJDghSTEzasDFSJpC7Y4aDbA6abJHyT9JSxPHZlW4HW58uGDphd5JYqwhGUY6I9b41rEnQy/l7xyiO4pnJpsLkfPUXd7XEGMgeiPoC/3/ApYKzWfQFcyS/DgQmvbSYX0wSIXZkJHZtrotBqeMco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036754; c=relaxed/simple;
	bh=UvDb+MAUuHrjkYXQQxcZZG20FJ+czVEj+rKjyBubn3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNW6D+jXmUUzU6/cY3x+P30I0JWPHimxyXuvGPQMBMa0UzmCbu9Mpcgk0auow9VL4CFyBJeIyYCJZWFo2m/ywXel3I7YK9Dl0fdPVkNKXrzmrtMu8jkj7WSVVTfrCE9y5IGPJy22Mbr4AUsrg/+UqNCDZsRGMsPnr5pvgwWnLzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=OhPDdphL; arc=fail smtp.client-ip=40.107.215.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXPKTZ009v2+pYJ6aAO4ryqJt/A/Dwa3K46J1Wkfs3varY+3zM/nWuAcKfk5EZsKLKKTwG9zfpFpHENQBajM4ONzEZAqaxdL6dziaTPaNzfTtDEfY2/72xWfr1oPrGudmJ63apAdFj3qiwHeI2TH8436nKHTn3PyFljAaUwLsAeGiJ/j0hnorjQ0KvQgNE5bD9PqfiVj80APO3sBry73F1XYHfVKtwoZKmmB1ZfzXAKbm7502C6HfVybKMS6k52e2bhTqYYj5RSf2gmMyDaQT2Tm2GA8C6t7PlvN8XcJtkQF/uUtXxacQwJmWsAgaAXx4AD8I3mF/Q7U4hX79llanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvDb+MAUuHrjkYXQQxcZZG20FJ+czVEj+rKjyBubn3g=;
 b=A1V4EVc5FzD03u0daPGin9Tc3B8yjp8bdu/PvXDFfT4zpDzh8ROs9Zkp7/Tt/PaJN5Ip1MOh+LtIxj0zNbi8+7Tvh2MSv0EtOpWrzA1BB5/yos/umtzzD4IMXKf4B8ral+koqg1e6G1rsZvc3Y/M3jUsBTGgx/l4dFmkJlawCOSpQGVrXwrTV5TUlYDtArK9FgaVAIkRLNbAWTyrk8HyKWuEAlLSbD2prMwqiYGHnnJ8lDShK6Wc6qzXFhgRllnJKrs2jAUtDBcKzqFQZVbAUfy9/dt2AqxHtAhzZheKQ4gw/4Ct7LoJPb+rFT8RcGisdrLookLwLmdYW0HNRAcKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvDb+MAUuHrjkYXQQxcZZG20FJ+czVEj+rKjyBubn3g=;
 b=OhPDdphLbO3Ja1E6Ncy90Mu3+TIjG2JEsE3wfr4MdSAD3Do1/z5XFpfgLb7AOgCQDsy71hdAZ8BDSO4GV8x5AqhZu/Lx8M6NCsjFWkhrP7WGMk+E9Z0lMsjh0rJ5XH5MilYlPc9g/rI8RCrJwvcJE4cKP9WmRigoHRcXAWu2/qcJtcx2t5XyGh0mqRJ2adw9pdBvQbvXdO0ASJEN17CBi8phk8c3KSqVNhm1DCB5UYAr40VCsvVbRGzpA6Qc+uIXGiImOhYhXM+a7qWvo8k+nvNiQdaMJKObC356YqsRHVEVYQOcYPKQ0ZZuamGVZUNYM/RSN8oBAKEYuSNpZ2uJmQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB7027.apcprd06.prod.outlook.com (2603:1096:101:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 03:05:45 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 03:05:45 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, Stephen Boyd <sboyd@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Lee Jones <lee@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index:
 AQHa6Wjwpmm6AqTUmky9VcIbkjW1JLIdJMiAgAFHtRCAAAQ8gIAAARxAgAclgACAAL3qcIABK1kAgAAVdECABl63wA==
Date: Mon, 19 Aug 2024 03:05:45 +0000
Message-ID:
 <OS8PR06MB7541C54CA074410C50BA419AF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
	 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
	 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
	 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
	 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <20240813191454.GA1570645-robh@kernel.org>
	 <OS8PR06MB7541BB03AEE90B090AB990B3F2872@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <7e1dc98e0f69a095a8f7725b742df3c8d8436a67.camel@codeconstruct.com.au>
 <OS8PR06MB754121818B9431941C18E09DF2802@OS8PR06MB7541.apcprd06.prod.outlook.com>
In-Reply-To:
 <OS8PR06MB754121818B9431941C18E09DF2802@OS8PR06MB7541.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB7027:EE_
x-ms-office365-filtering-correlation-id: f33e505a-a2a1-4c11-2727-08dcbffbd180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0NqSmRJUEFwTFRwUm1qYWhpNlByU213bE1CMzN6K1FKTFZzSjZHMVhySnli?=
 =?utf-8?B?bUJzNDkyYmhpcHplZDFWOHNZQUVVY25HcWxXaFhrOHJWaEE2OXNSL0U1eU5Q?=
 =?utf-8?B?Um56N3RIM3VDTHYwUHNURlc5NFppeGNFWUllQXIrTnRtSEdNRUxmYWluaVBU?=
 =?utf-8?B?dXlsVERldXlaUVRBZG5lTUxBZmNXRTlNaGExR1E3VnJlWDVVem41cUtZYmZa?=
 =?utf-8?B?bTl5RDVUczdQWjNteFdDVVFRVEROY1U4WmpFaXpNM1IwTVlUT1pWbENFYURJ?=
 =?utf-8?B?SllmYlo3a1Y1R3BRK2NOZWNGQlJ2VnVRTFFmL1p0cUtlU2l6TCtWUnNMY3RI?=
 =?utf-8?B?MWNEam9ZVVV5Wno1TGlxVHo4aWhDbjNLSU5CNkdhbjhycEQveU1TNkJQZWNG?=
 =?utf-8?B?aEYxcnJnaTV6YzZVU0RCNDZ5VVlvZlZuQ2xIeGZsalJudWY0cFlXUHdnMU13?=
 =?utf-8?B?NmxqUHBzRkJlRzRqS2dncnF2T1hvbHQvOEF0V3p4YVBLYmVjNXRFYzFmb0Yw?=
 =?utf-8?B?b0VIZS9BOWZGKzVIUmpkMFE4Rk5IMWUxaytWT1FMWTZnelovUk5SQzRPRmJj?=
 =?utf-8?B?dXo2T1pVNWJMbng1MGNlNWdEU2pFSDZDYm9xNWkrM0ZuNnR5RVZRYzlXTjFC?=
 =?utf-8?B?cGFPVFQ5U2JqMjNWS3MrbHRaMVdyTTZVSVI0a01lTGhPelZiaEY0WVg3dkxZ?=
 =?utf-8?B?Mmw2clNuZ1c2Qk52dDVHR0I3SUx0RnFyUXVJajFBR3dTUkdnVDZUZnZpS2F4?=
 =?utf-8?B?dU1HTXM0UWNVclIySmdLeVhLNlFVRDg4MzExQ01Yamdnei9ZaTlkcllrYnR5?=
 =?utf-8?B?YS9US1ZLMXJzQkNER3E0alNmYllpSFlvM0JweHRMVXA4Y2VIN0NBZ3h3NjF2?=
 =?utf-8?B?WUwwbnlZTlhxdzQ5RmowTzlTbnpOS2JwWTF4endUdkpFL1JGbTVRSTZOYklX?=
 =?utf-8?B?MHhrZWVtVG9FdWpwVFRFMUtveEk0UDVJNFlFT2JYY3pWcUkvVm5lLzU4WGlq?=
 =?utf-8?B?MFIvamZmU1JHa0RKZ0NoWkpZZWdlaFVLTXdFSHR3anVXZkhlQ0l2ZVh4dEhl?=
 =?utf-8?B?TEkrK3NqWExyLytRYVQzb0ZWUzY5QW9ISU5ReHFXQkhySzZ2STFUUlpBSjlu?=
 =?utf-8?B?TXJuRFl2dDA0R3hWMHpUM0Zrc3crZXFTSy93VmV1em5BTWUwRUVabGVKNTBK?=
 =?utf-8?B?Uzl2MEtMZEpNMEs4K29jRDBkV2pheHNpWWgrbDd6Vm5UWWIvWUhwNm4yNjA0?=
 =?utf-8?B?ZzVxL2s2M3I0ajZEZlR3dHNlMnBMRmttYi83NlFWYm4xU3IxSjErdy9DT0tQ?=
 =?utf-8?B?QzNGUHZyNXgveGZhSHE5TldvMzlQOS9MYTZhRzNNdU9wMjMzRVBSU0YzTDB5?=
 =?utf-8?B?WjhOUWxiRk5nSElPVGdKRXZDYnBJOFBMTDFTYm9ZMVBpSFJ2bHNZSGIzdDdo?=
 =?utf-8?B?VGtJcHBraVFWV3RsL2VQSHREWDc2T3ZWTThwN0ZVT3pxRER6RmFRcXJsTGFy?=
 =?utf-8?B?cnAxb2xaKzFwSlR5N05xSDNKQ1ZpdzdMTGk4bS9TeTlqaHdKcXpSdWdJNk9G?=
 =?utf-8?B?NzFpRXA3RFZuSWk4dnNZN2tCNVYyYll4ZG5PSXVHcU5QQng5c1QzellCUTND?=
 =?utf-8?B?enhTK1Y1ZGF1OE02M3pXQ3Nvb2poRHJjMUdCdlFWekN3b0hDaVBRY0VMeVgx?=
 =?utf-8?B?M0QxQ0E4NEU1UHNBdmdyblEvaHNCakFFYm5ONlZEVUFNbTlzRUoxNEsvWjlw?=
 =?utf-8?B?aHhHQi92THIwbGtKdXZTU2lvdlZYTTVHNWZ5cWVVbXZtY0tVS3llRU4xYlBY?=
 =?utf-8?B?b1FxU0lWUzRuYXllSC9PaEp4cm0vc1cycmorcmdJSkdnWk1QUW5xaTFUQzNR?=
 =?utf-8?B?YlJwcjhWYnpZVjZpRTdxVHoyNmlqdHhBZG1EN2Q4N3JmRWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3B6a244SUhDTGVNOVBaL1JKNzJFUE9IWlRZMzRVdWd3dEI1VlVQbXBsYytm?=
 =?utf-8?B?YnNCR1F2SlBuMERCUVZuMDZUcTFJak4rdFdlWVc4TkZyZ3pzWDM0Q2J3b3VE?=
 =?utf-8?B?VkUwU25NWWdmQ2dkTjNrRHorcDlHV2RHaDkxSVFBZGQ3UWRNQ0tacnN5d1Qr?=
 =?utf-8?B?OHlwZEpwUFFYMkN4ZzRGQ0UyRFhsWnNPdVViTHFxVmRtV0p5VDNaQnh3cUtW?=
 =?utf-8?B?RXJXVEF5MkNoaDR5VGpKL3NQVW9QNWlVSGdqUU1DVjZYNENZdlRtVGtVUy9v?=
 =?utf-8?B?VUV5N2s0U3MwdElYb2Jrd1hjODg4TGM5WHJBbVlmWjEvVEdIeDl4dDhVZE1J?=
 =?utf-8?B?QzFveUdtbjRZZFNHU2l6R3hObVZrNWhsZ1lxY3lycUxqL01iZnluSlhuc01T?=
 =?utf-8?B?Skt1cU4vdHdleG1vdCsyMHYwanJTOTlnNGYvNEZ3ZGxYNVVrRkp5c3NJb3Ez?=
 =?utf-8?B?alpWMDNLR21yNUQ2T2x2R1RSckhTeklKb2JTSmo0bFpVeEwrQ1pGUWlOT1d6?=
 =?utf-8?B?bTJ3QzlPdVVFdElCVmQxK1dxZG5nZ0VDRHRsTXZpeVRUenpzMGk5T09TWElN?=
 =?utf-8?B?aEU1dUtzOTZsM1hDd1psZjNqdkdKd2VWWEozK0lnZmh5aUtTVVU0TEg1US9G?=
 =?utf-8?B?bnpGeXhnd1pPQ0pnTDZBYWtnT3Z0Zzd4L2xENU1jQ044WE5YQ0JaMWE4cnBk?=
 =?utf-8?B?SkkzeElNNkJoUTZyNVA3TDJqZm5Zd2FYTkxnTDhBYWdJZWNwZHJFeG9ueVNP?=
 =?utf-8?B?VDVGbWxSWUxhbVFEdWEyM2JOUVVoZkh3SDRKTk85aVVlVzZZa0NEeHBtUTE3?=
 =?utf-8?B?OUVKejZ1eGF2Z0d2ekplZUM1RFdvVFVaYjBIdmpaa2Y1bFVZa3QvZlgxTFFJ?=
 =?utf-8?B?QkFHU3Excm1pRnR2NlBjRzZSdU5XQmhmbU1FSGxVallFeEJmMFcrTmtkMi9I?=
 =?utf-8?B?VEFwelRZOFl5eW1xd0NCQ2tiYTFFMGxqRjYrK3ZXcHFvcWpkQUp3K2ErV1Rq?=
 =?utf-8?B?Vmg2aW1ZS0YvTEZVSFFYekkrVDBJY0JFUmgveUxTZkY5SSt4Yy9OL3hRMlBN?=
 =?utf-8?B?YXN3S0VSMnNuUjJQaHFKQUZBUXdEbkd6TFhqZnNjOVRlYUNRRzFidVpLR0FD?=
 =?utf-8?B?QmExUjdPYlBKelNRaUhSKzFCWE44aE92VEFUajB4T0IrS1Bzak83VVpqeXBt?=
 =?utf-8?B?aHYwT3IzSWpWOENJYTR1dVVNbVh2enhNU1VUMjRKR0R4ajM0QTA5d2Q2TDM2?=
 =?utf-8?B?c1FWVm5TZHBFLzl0WmtMSW04V3BMRWtmNzJFeXUzNlpDa09kUVk5cFNKVUty?=
 =?utf-8?B?M0s5ZlNqa3lndWFtckljNjVySWdDRERPOWRML2pJZmcxN0ExZ3FzRGRFaUdK?=
 =?utf-8?B?cFlGc2pJL0JEOGFEclY2cnpYMllFcGQ5NW95cEE1TkU4Rkt5TjhSN0E2OEdO?=
 =?utf-8?B?NHV4aGs5VkdrNGVPNkF6eUZYTEdMb1FKUXY0TUR3TGlTUktWd2kvTHV4cUdZ?=
 =?utf-8?B?Sk5hWGFSaDZVSVZCM1kzdytWNFp0ampYdVAzKzA5c1gzZFBsNUhmSmVOdVR1?=
 =?utf-8?B?c0J0QWswNUNVM1dEeGRRWTUrOVpIMEE4QThwMUhrdTVZeENMZmRPd0FvWjZi?=
 =?utf-8?B?aXAxVGg5a0ZrektYek84VnB3cmxXQjNadXpLYlIvbFN4dzdGNHpYbUJTT3ZO?=
 =?utf-8?B?WUtZcnRyWXQ1bC81elIxMWwvT0xiOFdTUGxvRDRodDRpcjdtWWRrWFBLRzVL?=
 =?utf-8?B?NFZoUDdob1ZuN1NaK21WUmZSaEwvK3dzSTVITGVsZGJ3Nm4zZmNYVTVhcjNS?=
 =?utf-8?B?RzNEQzUweFkvR0FpMmFSa2ZlSDRGeW43VmcxdUVUZGNJNmRHMnhaK1FuOTkx?=
 =?utf-8?B?cGNvc1NtTFEzMHV1bkZRTmpJRCsyZ3FTQ09KcmR1NHdrdHFpUTJNeXlrUHJV?=
 =?utf-8?B?Uk5aYmdzdFczbmNlTzBSak8xZXY0MTNiWFdQSHZTL0IyY0NhdjMzSlg1YmNq?=
 =?utf-8?B?K0RiR2lVb1p1aE5wWjNqZlNwNFBLa0JudXY3bW56dTZmZnY3dml4QU02NXg2?=
 =?utf-8?B?RHY0Ujh6eFQ4WUk5ZGxJMm1FMW5McTBHNGlLZHpLLzNrRFBwNE1yMDRTR0Nq?=
 =?utf-8?Q?C9uMNjYeyC2c7z4VUQXPZn8+u?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33e505a-a2a1-4c11-2727-08dcbffbd180
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 03:05:45.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03yCCVsLAioriQesSEvqk27j5kdIP+4QiZristg6/MfjjJ/MeR0oPdiXDSZwV8TGLp/xDYj8noT02eG9eB+ErWwjvm65UItMYDGuPN4Y/xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7027

PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5kaW5nczogbWZkOiBhc3BlZWQ6IHN1
cHBvcnQgZm9yIEFTVDI3MDANCj4gPg0KPiA+IE9uIFdlZCwgMjAyNC0wOC0xNCBhdCAwNjozNSAr
MDAwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0g
ZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBwb3J0IGZvcg0KPiA+ID4gPiBBU1QyNzAwDQo+
ID4gPiA+DQo+ID4gPiA+IE9uIEZyaSwgQXVnIDA5LCAyMDI0IGF0IDA2OjEwOjIyQU0gKzAwMDAs
IFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBk
dC1iaW5kaW5nczogbWZkOiBhc3BlZWQ6IHN1cHBvcnQgZm9yDQo+ID4gPiA+ID4gPiBBU1QyNzAw
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gMDkvMDgvMjAyNCAwNzo1NSwgUnlhbiBDaGVu
IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5k
aW5nczogbWZkOiBhc3BlZWQ6IHN1cHBvcnQNCj4gPiA+ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4g
PiA+ID4gPiBBU1QyNzAwDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBPbiAwOC8w
OC8yMDI0IDA5OjU5LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBBZGQgY29t
cGF0aWJsZSBzdXBwb3J0IGZvciBBU1QyNzAwIGNsaywgcmVzZXQsIHBpbmN0cmwsDQo+ID4gPiA+
ID4gPiA+ID4gPiBzaWxpY29uLWlkIGFuZCBleGFtcGxlIGZvciBBU1QyNzAwIHNjdS4NCj4gPiA+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4g
PHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4g
PiA+ID4gPiA+ID4gwqAuLi4vYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyeDAwLXNjdS55YW1sICAg
ICAgfCAzMQ0KPiA+ID4gPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysrLS0NCj4gPiA+ID4gPiA+
ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4g
PiA+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVl
ZCxhc3QyeDAwLQ0KPiA+ID4gPiA+ID4gPiA+ID4gc2N1LnlhbWwNCj4gPiA+ID4gPiA+ID4gPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC0N
Cj4gPiA+ID4gPiA+ID4gPiA+IHNjdS55YW1sDQo+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCA4NmVl
NjljMGY0NWIuLmMwOTY1ZjA4YWU4YyAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+
ID4gPiA+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2Fz
cGVlZCxhc3QyeDAwLQ0KPiA+ID4gPiA+ID4gPiA+ID4gc2N1LnlhbWwNCj4gPiA+ID4gPiA+ID4g
PiA+ICsrKw0KPiA+ID4gPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL2FzcGVlZCxhc3QyeDAwLQ0KPiA+ID4gPiA+ID4gPiA+ID4gc2N1LnkNCj4gPiA+
ID4gPiA+ID4gPiA+ICsrKyBhbWwNCj4gPiA+ID4gPiA+ID4gPiA+IEBAIC0yMSw2ICsyMSw4IEBA
IHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLSBh
c3BlZWQsYXN0MjQwMC1zY3UNCj4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAtIGFzcGVlZCxhc3QyNTAwLXNjdQ0KPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC0gYXNwZWVkLGFzdDI2MDAtc2N1DQo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAg
IC0gYXNwZWVkLGFzdDI3MDAtc2N1MA0KPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAtIGFz
cGVlZCxhc3QyNzAwLXNjdTENCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFdoYXQg
YXJlIHRoZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZXNlIHR3bz8NCj4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gVGhlIG5leHQgW1BBVENIIDQvNF0gaXMgc2N1IGRyaXZlciB0aGF0IGluY2x1
ZGUgYXN0MjcwMC1zY3UwDQo+ID4gPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+ID4gPiBhc3QyNzAw
LXNjdTEgQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKGFzdDI3MDBfc29jMCwNCj4gPiA+ID4gPiA+ID4g
ImFzcGVlZCxhc3QyNzAwLXNjdTAiLCBhc3QyNzAwX3NvYzBfY2xrX2luaXQpOw0KPiA+ID4gPiA+
ID4gPiBDTEtfT0ZfREVDTEFSRV9EUklWRVIoYXN0MjcwMF9zb2MxLCAiYXNwZWVkLGFzdDI3MDAt
c2N1MSIsDQo+ID4gPiA+ID4gPiA+IGFzdDI3MDBfc29jMV9jbGtfaW5pdCk7DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gV2hhdCBhcmUgaGFyZHdhcmUgZGlmZmVyZW5jZXM/IEVudGlyZWx5IGRp
ZmZlcmVudCBkZXZpY2VzPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQVNUMjcwMCBoYXZlIHR3byBz
b2MgZGllIGNvbm5lY3RlZCBlYWNoIG90aGVyLg0KPiA+ID4gPiA+IEVhY2ggc29jIGRpZSBoYXZl
IGl0IG93biBzY3UsIHNvIHRoZSBuYW1pbmcgaXMgYXN0MjcwMC1zY3UwIGZvcg0KPiA+ID4gPiA+
IHNvYzAsDQo+ID4gPiA+IGFub3RoZXIgaXMgYXN0MjcwMC1zY3UxIGZvciBzb2MxLg0KPiA+ID4g
Pg0KPiA+ID4gPiBEaWRuJ3QgSSBzZWUgaW4gYW5vdGhlciBwYXRjaCBvbmUgZGllIGlzIGNwdSBh
bmQgb25lIGlzIGlvPyBVc2UNCj4gPiA+ID4gdGhvc2UgaW4gdGhlIGNvbXBhdGlibGUgcmF0aGVy
IHRoYW4gMCBhbmQgMSBpZiBzby4NCj4gPiA+ID4NCj4gPiA+IFNvcnJ5LCBJIHdhbnQgdG8gYWxp
Z24gd2l0aCBvdXIgZGF0YXNoZWV0IGRlc2NyaXB0aW9uLg0KPiA+ID4gSXQgd2lsbCBidXQgc2N1
MCBhbmQgc2N1MSByZWdpc3RlciBzZXR0aW5nLg0KPiA+DQo+ID4gQ2FuIHdlIGRvY3VtZW50IHRo
YXQgcmVsYXRpb25zaGlwIGluIHRoZSBiaW5kaW5nPyBSb2IncyBzdWdnZXN0aW9uDQo+ID4gc2Vl
bXMgbW9yZSBkZXNjcmlwdGl2ZS4NCj4gSGVsbG8sDQo+IAlEbyB5b3Ugd2FudCBtZSBkb2N1bWVu
dCBpdCBpbiB5YW1sIGZpbGUgb3IganVzdCBpbiBjb21taXQgbWVzc2FnZT8NCg0KSGVsbG8gUm9i
LCBBbmRyZXcsDQoJSSB3aWxsIGFkZCBpbiB5YW1sIGZpbGUgaW4gZGVzY3JpcHRpb24uIExpa2Ug
Zm9sbG93aW5nLg0KDQpkZXNjcmlwdGlvbjoNCiAgVGhlIEFzcGVlZCBTeXN0ZW0gQ29udHJvbCBV
bml0IG1hbmFnZXMgdGhlIGdsb2JhbCBiZWhhdmlvdXIgb2YgdGhlIFNvQywNCiAgY29uZmlndXJp
bmcgZWxlbWVudHMgc3VjaCBhcyBjbG9ja3MsIHBpbm11eCwgYW5kIHJlc2V0Lg0KKyAgSW4gQVNU
MjcwMCwgaXQgaGFzIHR3byBzb2MgY29tYmluYXRpb24uIEVhY2ggc29jIGluY2x1ZGUgaXRzIG93
biBzY3UgcmVnaXN0ZXIgY29udHJvbC4NCisgIGFzdDI3MDAtc2N1MCBmb3Igc29jMCwgYXN0Mjcw
MC1zY3UxIGZvciBzb2MxLg0KDQpJcyB0aGF0IHdpbGwgYmUgYmV0dGVyIHdheSA/DQo=

