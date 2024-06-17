Return-Path: <linux-kernel+bounces-217109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722AC90AAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B371C208F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ECF1940A2;
	Mon, 17 Jun 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AU+uxLrJ"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE84187548;
	Mon, 17 Jun 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718619120; cv=fail; b=scZUE8t8tq5iAgo9E86h10xTsBShn0n9CWCvJQpjTWCMEK0ZXSyqCy8H1ifqLP1wG2s4SkV3knegLsguVJGNG9zjIDEKysrb0GStDVb9/8FPfgdNbC5rF1vpT39ZAR03nd8eD91yaCmkuiX58mpWfEWxT9Nrjb4k2d7mJvG79J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718619120; c=relaxed/simple;
	bh=meW5shbWBXjQu80mUSLdqCKhQ2RY0ZwgePH3++6CCCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGtWwghTeMEecHjfQXuTpUsp1/31iOSCtOrkDzDCaK05T21fWyWNByo81Ew2SlPYRa7nEhnf2JixsNa1CnGN2s9Ubub+Vavn1X9ZrEyppTYxuhSilSZuoiDUUVk45JG6qX8VvWWx9UI3z10fV0vMR04P7njGsCPsM5bZqWI2FMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AU+uxLrJ; arc=fail smtp.client-ip=40.107.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYnuHdU9Cu4qJgglzElK2PWkJUM6l+PY9kCCvU+r8Mjh8OUhXir6WgF00Gqup0T2H/HPX2cEsdnw9OXVVjvAlQqGjOhVKv3XWI2PPzLj4uYjci7fFus2QWGZrbDHJPeOleiaK56onckJSaf4oHFUU0XjllF5emG+ncyMvaKzZ/JtZU4qJss+Y8m6q79kmWLj7yminhUqRr3cOHq+UCO4QH1M6hNCmygUuKP1fUL8mDe6yOUJLq6n/dmCbEaSWehFAfeJWaJOMFsvH6J0ZDQPJnnCuL6rFJnO/zhisaDfYmrwrirKfhhTVHdK324NQPQ16sG1W6U/A0xhkViy/TAlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meW5shbWBXjQu80mUSLdqCKhQ2RY0ZwgePH3++6CCCg=;
 b=jItIRdYQ4mjBCo8wWjF2haW6SI+yvXiehicNK6lUlvNIPgr5d75EQx3VywrB1BheTqIeewFVTLKcpMY+SpE6f8EyPV/cusrAucmC1Sxl6qQSCnvOIN3aiWxXeO/spyoOxFnAmzlZscye7rleRFkAydFXeGuNQkwFtNgQZ/g3l+Y3PJLODwQia0+uAZIrI/NhjMqQtXJHrB6PrHX3SJmzoAqMI6Okpns5CSS3EwvZBwTnxCBjF8/T04DNTeTWneQ8DLYqXcpBLQYOmpPWa39QR0SLuk5gYSaNd7JTO+27HWD3E8OpD8xDW6nesIduamjjnhT2lOzfaSGqL60qF0CsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meW5shbWBXjQu80mUSLdqCKhQ2RY0ZwgePH3++6CCCg=;
 b=AU+uxLrJOxZwrDEgVXPxPEaWt8kUSpuYWvyyrdzPJXKVBrZhou6CMjSQksQHNsi5AprCIkSLUi9pqrhU4qN5PQESDzh+X/i/Iw7O6skAn0lAAZAdCVjj2jnQvFW/bk3Fm1fATMtfohbHoRivM0tBQdC+QrzjAHx91THaQhdZZh0=
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by GVXPR04MB10520.eurprd04.prod.outlook.com (2603:10a6:150:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:11:53 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 10:11:53 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Vabhav Sharma
	<vabhav.sharma@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Franck Lenormand
	<franck.lenormand@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Frank Li <frank.li@nxp.com>, Daniel Baluta
	<daniel.baluta@nxp.com>
Subject: RE: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
Thread-Topic: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
Thread-Index: AQHavW5l3co4p5AGlkCtInU47ZH/FrHKBDwAgAGy3wA=
Date: Mon, 17 Jun 2024 10:11:53 +0000
Message-ID:
 <DU0PR04MB92994DFA6AA23B7521B20B2680CD2@DU0PR04MB9299.eurprd04.prod.outlook.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
 <750f5388-20f9-45a3-a1e6-ceac4b91329f@kernel.org>
 <AS1PR04MB9358A2457AF05553457DE9B0F3FB2@AS1PR04MB9358.eurprd04.prod.outlook.com>
 <1486a1b6-4119-4121-b6df-3da21d06add7@kernel.org>
 <DU0PR04MB929983AB361DB081B44E7AFE80C02@DU0PR04MB9299.eurprd04.prod.outlook.com>
 <a752a912-a328-49c8-b887-fa95512785cb@kernel.org>
 <DU0PR04MB9299FB3B70920CF85CA2FB6B80C12@DU0PR04MB9299.eurprd04.prod.outlook.com>
 <f6515498-ffc4-45b0-a19c-82204e4c83c0@kernel.org>
In-Reply-To: <f6515498-ffc4-45b0-a19c-82204e4c83c0@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|GVXPR04MB10520:EE_
x-ms-office365-filtering-correlation-id: fe562811-5b24-4621-d6ac-08dc8eb5e963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|921017|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?cC8rZm1neGdOekhvK3VFeHR0TXNoMjFqZ2ZnTXFpVUZHK0hOR3ArNEFnaUxX?=
 =?utf-8?B?dkhJcTFJeWtpemFYQm9ZeGwzYkdnRHNLaDU3YkJTaGtNVlVXUnU2b0lmcjJj?=
 =?utf-8?B?RDg2b3JpSlVNK1VsMXZueEhtRFRNUlZJSlJYNmpnQ2R6Y25pc2kxNHBIaURz?=
 =?utf-8?B?dHNRd20wSGRzeVN1QS82MitQcisxdGVwZnoyZytxenVrUm1LQ2MvaFdmejhY?=
 =?utf-8?B?MEF6MWxFaG8yRVNzS1BFZjZZYUhtUmdMWDM2RnNNelFLS2N5anQrZFJzTk51?=
 =?utf-8?B?VjAzdTFhTHZaZWVsMzhqS0p6ckN6ZmEvT3Y5amFtWXFpSG9HdFpXaGJZZm9t?=
 =?utf-8?B?TksrcUt6dmdqYjRzd1VmbFRaNzZ5WTNhREYwSm53T2xzQUpnOW9lS3ltSi9O?=
 =?utf-8?B?K2hxc3dBZE9JQTdQYlJyMUVWNFJxU25GTGIvVmxNWCt2dTRNNzNVaGtNa2xq?=
 =?utf-8?B?eGU1Qm1ZaWYwdStZSTMwK2x4TjhkTVBNc0tCeXYzZThneEJJOXUxREc0d0hL?=
 =?utf-8?B?dnJoZ2V2UWkzT0pBSUhJNU5OcFVVcUZvNVhhRTRzTTNSYTNONEgrWks4OTBr?=
 =?utf-8?B?clFNdEw5VVNXRDh1cUdQOGRxS2o0dWpSTUkzblFBRGQ0ZWtnb0JXejAxSnpx?=
 =?utf-8?B?M3pyRktxVkdNV3ZLVkR1S2RXZE1zeUVwajFaMG5aemhMazhkbkpsaklRSG1F?=
 =?utf-8?B?VDNmQ1JYWlErSGFaNGVBd0x1Zi83QWpZK1R3cE9menpRYUtVWjQxTmtud1c5?=
 =?utf-8?B?VmI5a1MwOFNRM0JFejVXWjZNbjB4OWJNaGpEeGNPakxWMjNnMENyOWNQY3JS?=
 =?utf-8?B?akpEMmlrcUdXRFRtWDVWb0tUZFI1RDR2Q1JERWlPVnJNRHFPbEZadVYzOUh5?=
 =?utf-8?B?RDd5WVpPSmVLeGxWdEMxeHA0R0lvZEdkS09ENm8zZkJoblJTRWZvRlNNN2hV?=
 =?utf-8?B?VmdBWE90MDZ4OHBBdDdJUVoycm5YWjNtMDk1UktPWXd0Z202TWFUY3E2V0Q2?=
 =?utf-8?B?UnJhK0RYamlJRGczY1BpTmR6bDJSamRxOUhvR0dTU0d5WDBOTDFWV3U0UXlX?=
 =?utf-8?B?RUY1L0pCc2JwOStwbGV4UnZPZTFWRjhVZWE1bFE4Qk1yeTZtMEFtVGFMbmF6?=
 =?utf-8?B?YU5BK0JieDFQeFQxTGtXVE9FSUdGOGFkeUU0WldpZm0vUkxzTUlLS213dE9y?=
 =?utf-8?B?bGl0OXVIb2Mwd2FveHIweHJ4YU9hSzVpdU50NXAydVVKM1NnZjZhL1BVbjg0?=
 =?utf-8?B?bGNOOFF6RzhlOGpJSnQ2QUJhdXBmblRQc1p0MkxVZDkvamNWdzhlT2xITzUx?=
 =?utf-8?B?OGdaUFpIb3hDbEZmRzZKS2Z5NGhub01INHVLYkplOVpuK0RzRmdLdGxFbVZH?=
 =?utf-8?B?T3o2aW1tYk9xVjhpOTdYZzlWMTVra3JhUVd1TThYb3RzUmxGaWpBWFhUUnNw?=
 =?utf-8?B?SXIyeExTbEsxQlhGZmprdExVZjNFcVFYejZrdTNCeEpHTlBKSE1acTB2akVY?=
 =?utf-8?B?OHJlK1U5TVU4cDFsU3FzcmFjNEQzdWp3eCtiY09UazZ5ejZwd3R4UVZla3Mw?=
 =?utf-8?B?WW96Z1JsZnBybUdGYU53V2pWT3QycTVzbTlPbHZPSERuSTZrQzRqQVh0bHd6?=
 =?utf-8?B?bzg1WXJBT3V2UTZBQTZRVVYreGZBZ2tEYTNHRFE0N2xzRndtTVNQYmdudGNt?=
 =?utf-8?B?T291eEo5SjhETUJYeEpPMTlLZGgwTXl4THhGbU5Mbjk4TTB3SFRTNEphOWJo?=
 =?utf-8?B?K0JWbEFFVFhsY2E2cmZFUGEvamxaeC82aUNISllRRzBnTlpMNGY4RFhQTnIr?=
 =?utf-8?B?QjNscXVKK2hoZ0lpdUprUEJYa3lnbFdSV1dvYWsyRUJOYlIyR3N6bDR4OTBB?=
 =?utf-8?Q?nNN/sTZuLXvyr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEtYUnlkWkljZ25EbCsrV3FzeWpxYW5ZME53QkQyYWI2VGExSVAzUnlEOHZC?=
 =?utf-8?B?YVdQenhrWmdQSTlnc2F3c3Q2R1Buenc3cjl1dklxY3lDdzZ5OW51dHQ0OS9z?=
 =?utf-8?B?UHlpRmZxbmtmOTRXTnQ3MXFYcXdCZ3V4Z3dubHM1UUdxVnF3QURjbHNSSmhu?=
 =?utf-8?B?KzY2UXZqNzJpWUw0UHRGRlV6UzRVZUFyVUhsMHVwVXY5ZDdtUnFrMnRxUE1w?=
 =?utf-8?B?b1EzcXBsRHUwWm92RTlvWWpxZitWOUZaQy9nZGZHMUtlQ0NjUE8wT3B2UmxS?=
 =?utf-8?B?SzNsSUF2RWJ4TCtyWXNCV1VMUysrbUhxVXlUMHZJUjRrNFlKR1crbmV4M0I4?=
 =?utf-8?B?VGcyN1VSNzZoVUxtOWExdXhKY0tUazJCdEZUVWRlTkpMMk5rTjBVTVhkL3lJ?=
 =?utf-8?B?blVyRlUwWGRLd3Vlc2JDRkpLUGU5OWxrdFJoeFQweTdiRUJnS2Vsc0t0YVFa?=
 =?utf-8?B?NUxlMnVKY1dSN0pQdXBjWEY2aEpIb3NlVTdEOWpZbmFoaFdLZjNvbGFWaXdx?=
 =?utf-8?B?MWFzNUxZM2pVMTNlSEF4dDBBTXFUSHJxUHQvN1NOU1d4TlFqakZJQU5UL2I5?=
 =?utf-8?B?RDR2NzV0NnU3OWxIclEvUzk0N3h0UjdnOXQveTZjNUI1MzRwNGZYUVhOWUJl?=
 =?utf-8?B?d295a2J6YWJ2dzBBb2JNQ1h5bSt2S3oxcXhXRkZvMGMyandmZ0I1THlhWkVj?=
 =?utf-8?B?VVdGUDZuY082STdwREZzVDBHV3VoemNWMVRjZ0puWC9mWS95V1lXZ1dObDlX?=
 =?utf-8?B?aVN1U1o0SlMrYklXcWZIWWNOSHZ5NWNsc0RCZTludTRneWkrSWNWUjRIMmZq?=
 =?utf-8?B?MEYyaldNTDNZYm5WS3JtSzZqeEJkaDNaTTV4K3lmdEthVkljbzBJMWIxaCtV?=
 =?utf-8?B?MkRTUUdJZDFkT0hleGNVWW9jWVVVSHNKOTVNVFZER01vc0tMSHk3TEpzMTJm?=
 =?utf-8?B?YVJvNjdXRTFJVTZ4dkJaQThEb2kzY1pPUEFNMDNIZHdWV0JXaTVZS2h1Zmhh?=
 =?utf-8?B?ZUo0V2YzRFk4eG9XdldDbEI3UmlEaFcwTHFNdGtDeXJrNGJubGFOb2lFejFM?=
 =?utf-8?B?RTMyU3IxUHNiM2pyMWVaWXdLeHlhUXl4VFhmTy9qQlRRNG0vVngwRFh3RnZw?=
 =?utf-8?B?VWU4L3V4cTZMelJ0Z1F6SlFIVVdIbWYvZmF5MDBZWVgwM0dVYVpYRWxXSDFN?=
 =?utf-8?B?WHVCNWtOa1VwU3o1anpEZnZWQmZqRC8xSm5qVGxvdHhUVW4zaXhTcFdwOWs1?=
 =?utf-8?B?MWg5ODQzVTVOakhlTEZFRWRNbEZJTTdiV25HRisxZWd1L1dyUjEzNkxTNnhs?=
 =?utf-8?B?UUR1ZEkrbk4veVREbHVpU3Uza0pLTnJiMXdVWEk2OHZ5Z0VSelFsdXBDaUp3?=
 =?utf-8?B?Y0twODZreHdKU1pudjlSemJrUy9HZkt1NkpQYmZWS1JHMWtha25sckpQWFJp?=
 =?utf-8?B?VjBEQy80M3FjemY0bm1ZZkdNQy92OEJ4LzhJQWdrT0dZNFRmeUpVK1RCVUdD?=
 =?utf-8?B?RGh0SUxJQTJST2ZyUmh1OHFPZkpLZXdHUXdjRGJEUCtCOCs4ZEM1Qkw1c3Yv?=
 =?utf-8?B?R1NySkMxYU1kV2cvb3VWZTVpRi9JeXFBUXZobkttVE5GaWhaZEt0SDVRQkxF?=
 =?utf-8?B?Z0lxRU1YR2orNHI3a1BUcS9ENGlqSWNKVE1nU0FBTStWMEtzTDZnQ091dnVw?=
 =?utf-8?B?MlREZTJVR2R3S1Fnc2lvdlZWdEhTWlpZcXlBNnBwa1d1eE5icFAwM1hQdVVq?=
 =?utf-8?B?WWxjUlJwaHdBMkVNaXBQaWNJN3RUVVduNXFOWEg1cm0vSnZ1UXQ2MkFOQmF0?=
 =?utf-8?B?SWJTQlQvSFRrT0ZZK3JjZkdLUUNOZ0NDdjBGbG40RXFqaUF5aDFidkl1RnND?=
 =?utf-8?B?SWtNRTBLQm9KcElqQzJCUG9hVWp4c1ZJTWo4RGIrdlhwSXNtMTlhRTQ4Z1k2?=
 =?utf-8?B?aDJmb0pZeW12SDMvb0ZTdDhnSXY3TW96a2NnbDhGOUV1TE9tbjhnUGVvVURN?=
 =?utf-8?B?ZjJlM3E2NUFhSG9KeU1NNVRxczVLMGU0WDFxZ21nVjVRYzRYVjF6ZDcrRkll?=
 =?utf-8?B?d0hIUU5rSGdJL1QvV2VsUjRnejA4akp5ckpHYU5KM1Bac040dktMWWtISU5x?=
 =?utf-8?Q?afGZjzPPqhE/P0eDHRjlAWnC7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe562811-5b24-4621-d6ac-08dc8eb5e963
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 10:11:53.5155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFpDG2jn0x3oMWc4afYhTfqa9L7iF9SeaovFOSAe2V+BEOZHa30biLiLOYG/SJ+jh2uqEV48sLJo2DycT5tQ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10520

SGkgS3J6eXN0b2YsDQoNCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwu
b3JnPg0KPiBTZW50OiAyMDI05bm0NuaciDE25pelIDE1OjM0DQo+IE9uIDEzLzA2LzIwMjQgMTA6
NDgsIEFpc2hlbmcgRG9uZyB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YsDQo+ID4NCj4gPj4gRnJv
bTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+PiBTZW50OiAyMDI0
5bm0NuaciDEz5pelIDE0OjE0DQo+ID4+DQo+ID4+IE9uIDEyLzA2LzIwMjQgMDk6MjAsIEFpc2hl
bmcgRG9uZyB3cm90ZToNCj4gPj4+IEhpIEtyenlzenRvZg0KPiA+Pj4NCj4gPj4+PiBGcm9tOiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4+Pj4gU2VudDogMjAyNOW5
tDbmnIg35pelIDE1OjA4DQo+ID4+Pj4NCj4gPj4+PiBPbiAwNy8wNi8yMDI0IDA2OjU4LCBWYWJo
YXYgU2hhcm1hIHdyb3RlOg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE1pc3NpbmcgU29DIGNvbXBhdGli
bGVzLg0KPiA+Pj4+PiBPaywgSSB3aWxsIHVzZSBmc2wsaW14OGR4bC1zYy1zZWN2aW8NCj4gPj4+
Pj4+DQo+ID4+Pj4+PiBTbyBubywgdGhhdCdzIGp1c3QgYWJ1c2Ugb2YgRFQgdG8gaW5zdGFudGlh
dGUgZHJpdmVyLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE5BSy4gRHJvcCB0aGUgYmluZGluZy4NCj4g
Pj4+Pj4gSSB3aWxsIGRldGFpbCB0aGUgZHQgYmluZGluZyB0byBkZXNjcmliZSB0aGUgcmVhbCBo
YXJkd2FyZQ0KPiA+Pj4+DQo+ID4+Pj4gU3RpbGwgbG9va3MgbGlrZSB3YXkganVzdCB0byBpbnN0
YW50aWF0ZSBkcml2ZXIuIFdoeSBpdCBjYW5ub3QgYmUNCj4gPj4+PiBwYXJ0IG9mIGV4aXN0aW5n
IGZpcm13YXJlIFNDVSBub2RlPw0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gVGVjaG5pY2FsbHkgeWVz
LiBCdXQgU0NVIGNhc2UgaXMgYSBsaXR0bGUgYml0IGNvbXBsaWNhdGVkIGFzDQo+ID4+PiB0aGVy
ZSdyZSBtYW55IGZ1bmN0aW9ucyBhbmQgYWxsIG9mIHRoZW0gYXJlIGFscmVhZHkgYWRkZWQgYXMg
c3ViDQo+ID4+PiBub2RlcyBpbiBTQ1Ugbm9kZSBmb3IgY29uc2lzdGVuY3kgYW5kIGhhbmRsaW5n
IHBsYXRmb3JtIGRpZmZlcmVuY2UuDQo+ID4+Pg0KPiA+Pj4gSSBndWVzcyBzb21lIG9mIHRoZW0s
IGUuZy4gcnRjLCBjb3VsZCBiZSBwYXJ0IG9mIFNDVSBub2RlIChyZXVzZSkNCj4gPj4+IHdoaWxl
IHNvbWUgY291bGRuJ3QuIGUuZy4gcGluY3RybCBEbyB5b3Ugd2FudCB1cyB0byBvbmx5IG1ha2Ug
c2VjdmlvDQo+ID4+PiByZXVzZSBleGlzdGluZyBTQ1Ugbm9kZT8NCj4gPj4NCj4gPj4gWWVzDQo+
ID4+DQo+ID4NCj4gPiBEaWdnaW5nIGEgYml0IG1vcmUgb24gdGhlIGltcGxlbWVudGF0aW9uLiBJ
dCBzZWVtcyB0aGVyZSB3aWxsIGJlIGENCj4gPiAncGFyZW50IGRlcGVuZHMgb24gY2hpbGQnIGlz
c3VlIHdoZW4gcmV1c2luZyB0aGUgcGFyZW50IFNDVSBub2RlIGZvciBzZWN2aW8uDQo+ID4gQ29u
c2lkZXJpbmcgdGhlIGRlZmVyIHByb2JlIHN1cHBvcnQgYW5kIG9jb3RvcCBjb3VsZCBiZSBtb2R1
bGVzLCBJJ20NCj4gPiBzdGlsbCB0aGlua2luZyBJZiBhbnkgc29sdXRpb24uIERvIHlvdSBoYXZl
IGEgZ29vZCBzdWdnZXN0aW9uPw0KPiANCj4gSSBkb24ndCBzZWUgYW55IHByb2JsZW0gdGhlcmUu
IFlvdSB3aWxsIGhhdmUgZXZlbiB3b3JzZSBpZiBtYWtpbmcgaXQgY2hpbGRyZW4NCj4gYW5kIHVz
aW5nIHBvcHVsYXRlIC0gdW5wcmVkaWN0YWJsZSBvcmRlci4NCg0KU29ycnkgSSBkaWRuJ3QgZmlu
ZCBhIGdvb2Qgc29sdXRpb24gd2l0aG91dCBtYWtpbmcgT0NPVFAgbm9kZSB0byBiZSBwYXJ0eSBv
ZiBTQ1UNCm5vZGUgdG9vIHdoaWNoIHdlIGNhbid0IGR1ZSB0byBleHRyYSByZXF1aXJlZCBwcm9w
ZXJ0aWVzIG9mIG52bWVtIHByb3BlcnRpZXMuIA0KRS5nLiAjYWRkci9zaXplLWNlbGxzLg0KDQpJ
IHRoaW5rIHRoZSBrZXkgcHJvYmxlbSBpcyBPQ09UUCBpcyBhbHJlYWR5IGEgY2hpbGQgbm9kZSBh
bmQgdGhlcmUncyBhIG1pc21hdGNoIGlzc3VlDQpJZiBvbmx5IG1ha2luZyBzZWN2aW8sIHdoaWNo
IGRlcGVuZHMgb24gT0NPVFAsIHJlLXVzZSB0aGVpciBwYXJlbnQgU0NVIG5vZGUuDQpNYXliZSB5
b3UgaGF2ZSBhIGdvb2QgaWRlYS4gV291bGQgeW91IG1pbmQgc2hhcmUgYSBiaXQgbW9yZT8NCg0K
QlRXLCBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIG9yZGVyIHByb2JsZW0gaWYgbWFraW5nIHNlY3Zp
byBhIGNoaWxkcmVuIGFzIGFsbA0KY2hpbGQgbm9kZXMgYXJlIEluZGl2aWR1YWwgZnVuY3Rpb24g
ZGV2aWNlcyBhbmQgc3VwcG9ydHMgZGVmZXIgcHJvYmUgd2VsbC4NCg0KUmVnYXJkcw0KQWlzaGVu
Zw0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0K

