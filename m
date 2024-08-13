Return-Path: <linux-kernel+bounces-283978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBED94FB64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C581F238C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0528BEF;
	Tue, 13 Aug 2024 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="FFwKJUcW"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020091.outbound.protection.outlook.com [52.101.128.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B386AAD;
	Tue, 13 Aug 2024 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513993; cv=fail; b=LQQyXLwjFccTpiekl0Pv/LjybHWYmO9HzfHoYLwjcIdydmoVC/EHgIDwrIxqYEwDItzUhCThBQgVa9wV3lTxlj/DLOZc/oQaxGYPUsw+viN1iBZ2F2a1zzfrhReS7DkqQ+HHqNT6fh6eLejvvDKoKPvweh6mjeUbtExuYrM5PC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513993; c=relaxed/simple;
	bh=bvkM/5RqoUvsXWpxhdyd1BQ6/l2T3ufXdKwHXV7BplU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OKl9d66jxNsdppCFoQY5Rd/sw6lFC/4SglmSBq78WTj+XVHtQX2hbcGqLVAIKIHEdMWs6lrjUG+yexkaYAQq3OD5XMFYfseh8SJVWyFtzBI/yQRZ0JHUL6Diomt4NSXp3Nw2I1aPDgCvaz/FzOmOereuPGKyWdXST+oVJ8ygTD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=FFwKJUcW; arc=fail smtp.client-ip=52.101.128.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaBBa0xuU5w/NvHDvIymHML3N+Fuql8PZKe36+MxHDrUVOMGhjGgWz11t1q9PnV2QwVpUc0W3CmGKHxjORlqPzDUpXwHjsAJbSSTHofkcrW4lFbAqMMVYkhVp2ccMF4VU9yo1c/USDeDTvYw/ItMgdg0/6FHro1j8TPG7FJycEILoAG7Uuvuql1GN557QHWp7oqbrZN76mseNc+P8ZCX6qWfLSQWgwgXN5JiYA5yuyf2VjBKxnIEvVjoNZahAfD448sxaalcf/TCUXetl1oeVkfWWCBUlrtSYhR3HzSN1OAE6f/5lyUihgDEDp2QLDpHbhKxFgX1vYAcXAVuSuBwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvkM/5RqoUvsXWpxhdyd1BQ6/l2T3ufXdKwHXV7BplU=;
 b=uP1zNQFQh2RMx9/o8Y3xx/13cFTm20xhkICfe1LZNA8wjKi9NbEWXS9fqLa1JPrbsJZ2UCSIZg9fw3PO8mgItPINvTh8GRTn/AWaRVohdf/shLvFdwPqSbUSGklXHE13fxhTq6iV/ZIFrEvirxMaahYDBu24qn8CwmFgHx8ucA+Cza8T1hAw/Tj9s3uXzYpYX7nZHZxJyno5YurObR40rO/HBToKoFpf7gPbhm8wCwSYLHe4jX/rUuKTr8ClgVyj5i5KiV6Q5jwM33c0MSYVU1rY+hB2cx2QlHScA5RQCd+xn7qnbq/I1oFTAPE1HRgyozYsS0scShJ1zDS6zJRx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvkM/5RqoUvsXWpxhdyd1BQ6/l2T3ufXdKwHXV7BplU=;
 b=FFwKJUcWAF4hVuXkzvR+iGwnftcRTwOAG096YSt5Jiayx4K26ieP8629C0xg2siXQcFL9hr2W9Z/z1RhU+QOcAOCKdM2OEf4/ticuDbxhravXfevh799OyCAiF/SiVxakD+LoHSrzzCjJ0JuCifssiOxm+Y6X79+JfW0VmxfkB/xTZMuhxE97PpujSQxJGqZMgTdbOqqd6XXvrY0mHGgluzyYxiYnPrKLpmnEXrN+c2XMW3+wUDDp7UgoDexwJ66pyiysHSxQXoHZHZAJd+kfGNMIia8mN7LDayQ9skdgTeF8T5eOAsJhW6jLaCt7yGoGEP2EDtfWKM1/ee0UDPZ9A==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYSPR06MB6314.apcprd06.prod.outlook.com (2603:1096:400:417::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 01:53:06 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 01:53:06 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index:
 AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+QgATIDfCAAA4pgIAAAYwQgAACfgCAAASXwIAADl8ggAAEbQCAAQrHAA==
Date: Tue, 13 Aug 2024 01:53:06 +0000
Message-ID:
 <OS8PR06MB7541D5AB85D8E44E89389BC3F2862@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
 <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB7541B0D9A43B989DC1738F68F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5081c41b-dfbd-49ad-a993-b983d4c339f0@kernel.org>
 <OS8PR06MB7541196D3058904998820CFFF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <9465f8c0-5270-46df-af4b-e9ee78db63d1@kernel.org>
 <OS8PR06MB7541CC40B6B8877B2656182CF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB75415EC7A912DBD4D21A0035F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e3733148-142c-40a1-b250-4502e8726f0c@kernel.org>
In-Reply-To: <e3733148-142c-40a1-b250-4502e8726f0c@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYSPR06MB6314:EE_
x-ms-office365-filtering-correlation-id: 4c6e6675-c057-411d-6a6b-08dcbb3aad20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0VqUllRUVhFckRiNzNiL0o0Ty9aWmdLb0dWZURZb1IrQ0tzVFl6VEtHcGdx?=
 =?utf-8?B?cW9waVRYR0RKcnBuNW8rd3JxSUwwUTROeHFPUDVKaFhaajNqZDJ0UEZiV1dw?=
 =?utf-8?B?ejdtTU5tRVpZRCs3K1AweFNwUm8weGlBNXczRC8vUFh1ekhmNmQrbG9qUFc5?=
 =?utf-8?B?eGtVN2NHeDJEVC9sU29rQ1NZTjRScGFneWJMTE9zRkJ2RUVyekZPUXg2YllC?=
 =?utf-8?B?QWFkTVY0UjF5c05wTHlMUEJqamRzVVVnWEUwcElVM0t4cDRDR2t1cnc2T1dN?=
 =?utf-8?B?U3B4NkY4cFVaT3hvVC96WDRMWUlnRWdmMGc3Y3pkUjZVRmVhYjZ3bkIzVmhX?=
 =?utf-8?B?OHh3cW1jZGJJdmsrZTh5TzZhemQyZWZQNVg4VXFFU05BakRGcTNoTVd4ZHEz?=
 =?utf-8?B?dGhncWJNUlFvUWxoUGtwS2tJLzVxR0Nzak1aN2JLUWljRnV1ZjJ5dGFzLy9B?=
 =?utf-8?B?dWg2eXhaR092OVJVSk04eG1EZFNjZnhJeXBPZVNkWGRZczVOVVVTWUc5UGVx?=
 =?utf-8?B?am16OG0xbkVOQmMzNXpNUWFoaUhTM0ZSbVdyZFRBWkxLVzg0UU5VdjEyRlBl?=
 =?utf-8?B?ZmJiZlBxa095N2VSWUlvdTlYK2FuY04wV2Rpb2xCWkg2cFlXM2o1d1VTeDMx?=
 =?utf-8?B?bjdmRXhpN3ByelhDamVqL0tZVmk4UlFLWUZQbVdCSkVNV3JEVGVodU9vWmhP?=
 =?utf-8?B?MEptczVGUTdnc2Fqd3ZWUDNoRGhPblVLL1ZWVkZjSzVoQUVMOVMzK2hndWp0?=
 =?utf-8?B?OVJRT1oxR0xKd2xpRWtxZTRZdFpuNXBjNWxhQk9uK2svclJjTXhMK0xzVVBN?=
 =?utf-8?B?aDUwRVVIcHBiUEswM01kcUdJeS8zWDN1bkljcUdCcmVsM2V2eGlwZ241a0d3?=
 =?utf-8?B?N1RzTHlzZGMvT2dQSU1WRkM4SHFDUURoYjd4UlVNRzdJb21OWWhwaVV1MWRL?=
 =?utf-8?B?NDc2Q0w4MHVNb3RCTzVtbE9uOTJmZ2FlV0dTWHg1QkZlKy9YbUhURXRQd0Nm?=
 =?utf-8?B?OXU0MnRHTisxa0dWYkFuV3l4Q3ZtbmdMaDZjZEF1a2c5SWM0Znl5VjZyU2FX?=
 =?utf-8?B?ckhVYzVRNndKZTA0eGRIekNUMENpdTNDb0RTTTVZbmhpMlVnaUk5d21UOVlv?=
 =?utf-8?B?UTVLdGR3TFRrUUR0dG1lTHRQekl0ZmxORFdVMDhvaUZoN1NQbi9iTk1scFRm?=
 =?utf-8?B?L3BiaXBPRlpOZ0RRMVZ6N0lQblRvaDdxQlgvVC80bENoZFA4dTdKcXdab3Ax?=
 =?utf-8?B?bXpjSU4zc1JSKzJPVVZUemk0c01IQTNZMlBOZ0ZjZVZHdXRGc1oycXUzWXFy?=
 =?utf-8?B?TE10NE1rVklpODU2NERXRXJzSmh1N3dZM21ndnM2Sy8vTDhWbEd3VnVMUXU3?=
 =?utf-8?B?NjdZM3ZoOUxOZmMzOUF5eGdzQ0E4ZC9MeDlMVHB0TGVvOW43MUpQTERQaktG?=
 =?utf-8?B?RXJjREluMTdpNmlVWGQ5M1NnOVdidWxEek1JWXg1blVOTERTNElxYXEreEZN?=
 =?utf-8?B?ZHlYeXZib3JPcnJnUFZVNTRyYVRhOWY4MWpxdXJEaTJXdE02MUF3RkswNTU1?=
 =?utf-8?B?aTBRL2tscTlieTZnMTFreTNlL1BuODVWNTdQTFNtTktYcTdJa0t4aDdxUE1T?=
 =?utf-8?B?RlhrTTJ6M0ZWUFhxNERWZkZUSVBJaG40VDRmKzlvK0ViMGtJd1c2YitDVnVZ?=
 =?utf-8?B?UVFZQlI4ZG5BSWw4MzR1L2pHSzY0UGV2MVp6OWJpZHpUWVNONHZtczN4Vlpp?=
 =?utf-8?B?c09HVzlqOU0vT1ZZWkwyeDJWM3ZLMjBEdmQ2OGhwS29sTXEwWjhCcHVtNjA2?=
 =?utf-8?B?ZG5XNmhzUU1WaHEzQWZ0ZUd3VlRDeFQ1R0s2OXZMSjF2bVI2Q1hKVUdXSWR1?=
 =?utf-8?Q?2FVNvmBWIRPIA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXFmUXhPN3RCaVJFYTg3MkNQQWZmVkl2V1p0alM3eFNXUEhPeVVwa3JXVlJY?=
 =?utf-8?B?Y3ZzVEdVMW12YlB5VEdoNnhlSExUTCt5eXJDaExsaVBMTXNqR1RUNm8vdzNC?=
 =?utf-8?B?QmQxRlpiUnVhbzg0ZjJDSmZSUy9vWk4wdzZFOVFqU00vQVl0bkxqbENmTkE1?=
 =?utf-8?B?WHgrYlROWDFVMEJjaXNqK1JqOXBJaEExaUxMQWhNWFZuUlo4SmxXa3NkOWNw?=
 =?utf-8?B?by9walVWb1N3WkIvNVBHYXg4VVF3Ykc4S3F2bHYrUmYrUUJxUFBlM3IzL21T?=
 =?utf-8?B?QitNVnQwWHB5RHhmVEkyZ3pLR052dlZPM2syOG53bEgxRGFKc0E0cndLY3Vh?=
 =?utf-8?B?UlZ6R3hkRUttLzBGWkZSbGRPWnJvZWk5ZHNORHhscmJ0N1JUQUIydXFpWmVE?=
 =?utf-8?B?RDRlTm92ZXdGdXB4dFViZW1CYVIxbEdTVHhzUTFqYzZkejdXQTlZZWVCNkVW?=
 =?utf-8?B?MVZYT3hUSHlxTmswbENPREQvUGZhL2hZaWdCWml5TDZYKzhIRlc1LzVvNEhW?=
 =?utf-8?B?aUtaa3hvNzh3eEw1ODVpbmxXdWsxcjZaZWlBWCtBNEJBTWk5c2tnRjV1Y0hi?=
 =?utf-8?B?KzJqZEkvWUF0K2tkT3ltc3ppbkxTcFpMTnpDR2F3UFUyY2ZRbUFrNVBpcVd5?=
 =?utf-8?B?T1Zjek45N1pMVWJFQnhOZVZNYVJaUWF0bHlPZDhPOVdUVkVET3N4LzRWUlYx?=
 =?utf-8?B?bG05cU95OWdGSGV1L3RoSXN0Qmxzdk9CdXRIK0Z0dHNFTVE1SEQzUlBPenJx?=
 =?utf-8?B?WTBGQjRmdVJ0cUxFRUQ4MU5KdVpyUG9GNkpJdFBzcEZiV0hMQUV0aEdQRDg2?=
 =?utf-8?B?dGNCaU9MSUIvTmdWVjZ3NTN1bjQ4MldUdWZqR0RSNzY2U01vM3dVeTA5cWZW?=
 =?utf-8?B?S0MyME5OcXVmUzc0L0hZL3lqeHpSWE9OTDdZY0pGNTRXUmdXRXJoV0txRjlI?=
 =?utf-8?B?WlJXaTRmbTBjTFhIbEJDVnhQTGlRWXNUNC80RDRHUjJjSG5DVTQvM1RpZVFS?=
 =?utf-8?B?N0tackxqUlBjNHB4SnlWcXIwRWxGcHFWanBoSldTY0hvOHdVa2V3V1Z0SEli?=
 =?utf-8?B?dEJ3aWlVcEJaQXVyV3J1Y3BkcnExVXV1Q1M0L3d2ZjJCOWNEUURUZXE0SHdP?=
 =?utf-8?B?M1BRSEVmWFprdzduZmpQNzBOUzEyTTFTb0VFWnUzNGtYaFkrR3oxSVV5NkFM?=
 =?utf-8?B?ZVJSUTVxMnN5YjdYcTJTaW9WNmtZTHZrWVpKSm1oWjJ0dmJuT2ZpbU9zTm9U?=
 =?utf-8?B?TTBoSDJJQ1V2Q0VyMFNxYjlONVp5T3E3VG5DVzZSaGZBdis2WGxHZm1WSGVo?=
 =?utf-8?B?ZEs0OFFydGRzS0IzaStZNkI4elFISlE3T1BGQjloVUZTSE5FaVg3WWRBbmlJ?=
 =?utf-8?B?enZOMDlIdW9TVEpHY3JIS2hVQkdDQ1l5bWlvUzZDQzJNU0FwYm54dmRGa0dO?=
 =?utf-8?B?bGZvdVhaSlJ3Wit3cTdHVWNLY3dGNUxuc2tKTVZDNDNVck4wZC9GaDkvUm9H?=
 =?utf-8?B?dHF2SzBaOXZjN3FtZzdYa0xuUjdUdllvSWl2N1Zabm5jYzVyQ240dmplVHV1?=
 =?utf-8?B?RGNjelI1Zm8yODAycHUvOXlhMnc3UDVJSUtvcnJWL251dkhGS2ZIUzZFZXJZ?=
 =?utf-8?B?ZTV5UFVpbC9aSTF0ZDFNc2FSR3R5eTdwRFgzR1Y4MXNHYkh3OGlhZWhrTkw3?=
 =?utf-8?B?dEJiblZ0MGlpZnRIUzN0WEdKa1g2WkdCN0NJdmFBL3BiaEdKblB4OGoxRnNq?=
 =?utf-8?B?dnFoSGxWRE1rcDBLdjBhZklZZTBIdHJlSEFYYlR3aStJQzhKMTBuaXF3MmtW?=
 =?utf-8?B?ZE9QQnpiMEFNMDU5WnNvbGlCVnNsYXFFcVplVnpBekhzaTdrK2tnZzB5cmpr?=
 =?utf-8?B?YzcxbXMxY2VRU3BSUTBTT1BGRlg4SEpBMEwvR0Q0RFdOaWFnSStRaUhFTjZ3?=
 =?utf-8?B?V3VjdTBZbkFpenZOVHFBRkxabnBEdjhta3Yzb1BtVkJYWTI2cmNIVTFSWHNx?=
 =?utf-8?B?NHFtdkxuZTE1Tm5acGdWZGFHWmZ2MWc4eWJIOG81amEwUjZCOWNyeW5hdEhH?=
 =?utf-8?B?OXNLWi9EV21oa0UwRGdDcG5uSUQyYWxQL0xaU3ZLTVpVeHRWUDQyMC9hdk9L?=
 =?utf-8?Q?X/N8HtT2Zc12z0Ce0p0f0bGGy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6e6675-c057-411d-6a6b-08dcbb3aad20
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 01:53:06.6521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6nCEXXAkjKBozEQEL5UHsApzTK1fAkIjlji9Q8itJDhiHtq2KE16QbehX5bMMw1potCl5M6xuqKRzgwfcXJ/AtDdZio0s7UXYyNCg5GHUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6314

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gT24gMTIvMDgvMjAyNCAxMTozOSwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+PiBTdWJqZWN0OiBSRTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBB
ZGQgQVNUMjcwMCBjbG9jaw0KPiA+PiBiaW5kaW5ncw0KPiA+Pg0KPiA+Pj4gU3ViamVjdDogUmU6
IFtQQVRDSCAzLzRdIGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIEFTVDI3MDAgY2xvY2sNCj4gPj4+
IGJpbmRpbmdzDQo+ID4+Pg0KPiA+Pj4gT24gMTIvMDgvMjAyNCAxMDoyMiwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2Nr
OiBBZGQgQVNUMjcwMCBjbG9jaw0KPiA+Pj4+PiBiaW5kaW5ncw0KPiA+Pj4+Pg0KPiA+Pj4+PiBP
biAxMi8wOC8yMDI0IDA5OjI2LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+Pj4+Pj4gU3ViamVjdDog
UkU6IFtQQVRDSCAzLzRdIGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIEFTVDI3MDAgY2xvY2sNCj4g
Pj4+Pj4+PiBiaW5kaW5ncw0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMy80XSBkdC1iaW5kaW5nczogY2xvY2s6IEFkZCBBU1QyNzAwIGNsb2NrDQo+ID4+Pj4+Pj4+
IGJpbmRpbmdzDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IE9uIDA5LzA4LzIwMjQgMDc6NDcsIFJ5
YW4gQ2hlbiB3cm90ZToNCj4gPj4+Pj4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQt
YmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcwMA0KPiA+Pj4+Pj4+Pj4+IGNsb2NrIGJpbmRpbmdz
DQo+ID4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+PiBMZSAwOC8wOC8yMDI0IMOgIDA5OjU5LCBSeWFu
IENoZW4gYSDDqWNyaXQgOg0KPiA+Pj4+Pj4+Pj4+PiBBZGQgZHQgYmluZGluZ3MgZm9yIEFTVDI3
MDAgY2xvY2sgY29udHJvbGxlcg0KPiA+Pj4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+Pj4+Pj4+
Pj4gLS0tDQo+ID4+Pj4+Pj4+Pj4+ICAgLi4uL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3Qy
NzAwLWNsay5oICAgIHwgMTc1DQo+ID4+Pj4+Pj4+Pj4gKysrKysrKysrKysrKysrKysrDQo+ID4+
Pj4+Pj4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25zKCspDQo+ID4+Pj4+Pj4+
Pj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4+Pj4+Pj4+Pj4+IGluY2x1ZGUvZHQtYmluZGlu
Z3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4gPj4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAt
Y2xrLmgNCj4gPj4+Pj4+Pj4+Pj4gYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxh
c3QyNzAwLWNsay5oDQo+ID4+Pj4+Pj4+Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+Pj4+
Pj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmFjZjcyMzUyYzNlDQo+ID4+Pj4+Pj4+Pj4+IC0t
LSAvZGV2L251bGwNCj4gPj4+Pj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9j
ay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+Pj4+Pj4+Pj4+PiBAQCAtMCwwICsxLDE3NSBAQA0K
PiA+Pj4+Pj4+Pj4+PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkg
T1IgQlNELTItQ2xhdXNlKQ0KPiA+Pj4+Pj4+Pj4+PiArKi8NCj4gPj4+Pj4+Pj4+Pj4gKy8qDQo+
ID4+Pj4+Pj4+Pj4+ICsgKiBEZXZpY2UgVHJlZSBiaW5kaW5nIGNvbnN0YW50cyBmb3IgQVNUMjcw
MCBjbG9jayBjb250cm9sbGVyLg0KPiA+Pj4+Pj4+Pj4+PiArICoNCj4gPj4+Pj4+Pj4+Pj4gKyAq
IENvcHlyaWdodCAoYykgMjAyNCBBc3BlZWQgVGVjaG5vbG9neSBJbmMuDQo+ID4+Pj4+Pj4+Pj4+
ICsgKi8NCj4gPj4+Pj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+Pj4+PiArI2lmbmRlZiBfX0RUX0JJTkRJ
TkdTX0NMT0NLX0FTVDI3MDBfSCAjZGVmaW5lDQo+ID4+Pj4+Pj4+Pj4+ICtfX0RUX0JJTkRJTkdT
X0NMT0NLX0FTVDI3MDBfSA0KPiA+Pj4+Pj4+Pj4+PiArDQo+ID4+Pj4+Pj4+Pj4+ICsvKiBTT0Mw
IGNsay1nYXRlICovDQo+ID4+Pj4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfTUNMSyAo
MCkgI2RlZmluZQ0KPiA+Pj4gU0NVMF9DTEtfR0FURV9FQ0xLICgxKQ0KPiA+Pj4+Pj4+Pj4+PiAr
I2RlZmluZSBTQ1UwX0NMS19HQVRFXzJEQ0xLICAgICAgICAoMikNCj4gPj4+Pj4+Pj4+Pj4gKyNk
ZWZpbmUgU0NVMF9DTEtfR0FURV9WQ0xLICgzKSAjZGVmaW5lDQo+ID4+IFNDVTBfQ0xLX0dBVEVf
QkNMSw0KPiA+Pj4gKDQpDQo+ID4+Pj4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkdB
MENMSyAgICAgICg1KQ0KPiA+Pj4+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JFRkNM
SyAgICAgICAoNikNCj4gPj4+Pj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9QT1JUQlVT
QjJDTEsgKDcpICNkZWZpbmUNCj4gPj4+Pj4+Pj4gU0NVMF9DTEtfR0FURV9SU1Y4DQo+ID4+Pj4+
Pj4+Pj4+ICsoOCkNCj4gPj4+Pj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9VSENJQ0xL
ICAgICAgKDkpDQo+ID4+Pj4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkdBMUNMSyAg
ICAgICgxMCkNCj4gPj4+Pj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9ERFJQSFlDTEsg
ICAgKDExKQ0KPiA+Pj4+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0UyTTBDTEsgICAg
ICAoMTIpDQo+ID4+Pj4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfSEFDQ0xLICAgICAg
ICgxMykNCj4gPj4+Pj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9QT1JUQVVTQjJDTEsg
KDE0KQ0KPiA+Pj4+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1VBUlQ0Q0xLICAgICAo
MTUpDQo+ID4+Pj4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfU0xJQ0xLICAgICAgICgx
NikNCj4gPj4+Pj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9EQUNDTEsgICAgICAgKDE3
KQ0KPiA+Pj4+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0RQICAgKDE4KQ0KPiA+Pj4+
Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0UyTTFDTEsgICAgICAoMTkpDQo+ID4+Pj4+
Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfQ1JUMENMSyAgICAgICgyMCkNCj4gPj4+Pj4+
Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9DUlQxQ0xLICAgICAgKDIxKQ0KPiA+Pj4+Pj4+
Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1ZMQ0xLICAgICAgICAoMjIpDQo+ID4+Pj4+Pj4+
Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRUNEU0FDTEsgICAgICgyMykNCj4gPj4+Pj4+Pj4+
Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9SU0FDTEsgICAgICAgKDI0KQ0KPiA+Pj4+Pj4+Pj4+
PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JWQVMwQ0xLICAgICAoMjUpDQo+ID4+Pj4+Pj4+Pj4+
ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVUZTQ0xLICAgICAgICgyNikNCj4gPj4+Pj4+Pj4+Pj4g
KyNkZWZpbmUgU0NVMF9DTEtfR0FURV9FTU1DQ0xLICAgICAgKDI3KQ0KPiA+Pj4+Pj4+Pj4+PiAr
I2RlZmluZSBTQ1UwX0NMS19HQVRFX1JWQVMxQ0xLICAgICAoMjgpDQo+ID4+Pj4+Pj4+Pj4+ICsv
KiByZXNlcnZlZCAyOSB+IDMxKi8NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gTm8sIHlvdSBjYW5u
b3QgcmVzZXJ2ZSBJRHMuIFRoZXkgYXJlIGFsd2F5cyBjb250aW5vdXMuDQo+ID4+Pj4+Pj4gSSB0
aGluayBmb3IgbWlzLXVuZGVyc3Rvb2QuDQo+ID4+Pj4+Pj4gSSB3aWxsIHJlbW92ZSB0aGUgY29t
bWVudC4NCj4gPj4+Pj4+PiBBbmQga2VlcCBpdCBpcyBjb250aW51b3VzLiBUaGFua3MuDQo+ID4+
Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfTlVNDQo+IChTQ1Uw
X0NMS19HQVRFX1JWQVMxQ0xLICsNCj4gPj4+IDEpDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IE5v
LCBub3QgYSBiaW5kaW5nLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+PiBJIHdpbGwgbW9kaWZ5IGJ5IGZv
bGxvd2luZy4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiAjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUlZBUzFD
TEsgICgyOCkNCj4gPj4+Pj4+ICNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gICAgICAgKFNDVTBf
Q0xLX0dBVEVfUlZBUzFDTEsNCj4gKw0KPiA+PiAxKQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBOb3RoaW5n
IGNoYW5nZWQuIFN0aWxsIG5vdCBhIGJpbmRpbmcuIFdoeSBkbyB5b3Ugc2VuZCB0aGUgc2FtZSBh
bmQNCj4gPj4+Pj4gZXhwZWN0IGRpZmZlcmVudCByZXN1bHQ/IERyb3AuDQo+ID4+Pj4+DQo+ID4+
Pj4+IEFkZHJlc3MgZmVlZGJhY2sgc2VudCB0byB5b3UgZnJvbSBwcmV2aW91cyB2ZXJzaW9ucyBv
ZiB0aGUgcGF0Y2hzZXQuDQo+ID4+Pj4+IFRoZXJlIHdhcyBuZXZlciBhIHJlcGx5Lg0KPiA+Pj4+
IFNvcnJ5LCBtaXMtdW5kZXJzdG9vZC4NCj4gPj4+PiBTaW5jZSB5b3UgdGhpbmsgIiNkZWZpbmUg
U0NVMF9DTEtfR0FURV9OVU0iIG5vdCBhIGJpbmRpbmcuDQo+ID4+Pj4gRG8geW91IG1lYW4gSSBz
aG91bGQgI2RlZmluZSBTQ1UwX0NMS19HQVRFX05VTSBpbiBjbGsgZHJpdmVyLCBub3QNCj4gPj4+
PiBpbg0KPiA+Pj4gYmluZGluZyBoZWFkZXIsIGFtIEkgcmlnaHQ/DQo+ID4+Pg0KPiA+Pj4gV2hh
dCBkaWQgSSB3cml0ZSBpbiB0aGUgZmlyc3QgQXNwZWVkIDI3MDAgcGF0Y2g/IFNvIHlvdSBhcmUg
bm90DQo+ID4+PiBnb2luZyB0byByZXNwb25kIHRoZXJlPyBBcmUgeW91IGdvaW5nIHRvIGltcGxl
bWVudCBlbnRpcmUgZmVlZGJhY2sNCj4gPj4+IHJlY2VpdmVkIGluIHRoZSBmaXJzdCB2ZXJzaW9u
IG9mIHRoZSBwYXRjaHNldD8NCj4gPj4NCj4gPj4gQXBvbG9naXplIGFnYWluLCBJIGRvIHRoZSBp
bnRlcm5hbCBkaXNjdXNzaW9uLCBpdCBzaG91bGQgbm90IHNlbmQNCj4gPj4gIkludHJvZHVjZSBB
U1BFRUQgQVNUMjdYWCBCTUMgU29DIiBzZXJpZXMgcGF0Y2guIGl0IHNob3VsZCBiZSBzZXBhcmF0
ZQ0KPiBzZXJpZXMgcGF0Y2guDQo+ID4+IEl0IHNob3VsZCBiZSBiaXRlIGJ5IGJpdGUsIGV4YW1w
bGUgY2xrIGRyaXZlciBwYXRjaGVzLCBwbGF0Zm9ybQ0KPiA+PiBwYXRjaGVzLCBpbnRlcnJ1cHQg
cGF0Y2hlcy4NCj4gPj4gU28gSSBhbSBub3QgZ29pbmcgdG8gcmVzcG9uc2UgdGhlcmUsIHByZWZl
ciBoZXJlLg0KPiA+Pg0KPiA+PiBTbyBJIHN0aWxsIG5vdCB1bmRlcnN0b29kIHlvdXIgcG9pbnQg
Im5vdCBhIGJpbmRpbmciIGlzIH4NCj4gPj4NCj4gPj4NCj4gPiBJIHJldmlldyB5b3VyIHBvaW50
IG9uDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWNsay9w
YXRjaC8yMDI0MDcyNjExMDM1NS4yMQ0KPiA+IDgxNTYzLTMta2V2aW5fY2hlbkBhc3BlZWR0ZWNo
LmNvbS8NCj4gPg0KPiA+IERvIHlvdSBtZWFuIEkgc2hvdWxkIG5vdCBiZSBnYXRlIG5hbWluZyBo
ZXJlLCBhbGwgc2hvdWxkIGJlIGNsay4NCj4gPiBFeGFtcGxlICsjZGVmaW5lIFNDVTBfQ0xLX0dB
VEVfUlZBUzFDTEsgLT4gKyNkZWZpbmUNCj4gU0NVMF9DTEtfUlZBUzEgYW0gSSByaWdodD8NCj4g
DQo+IERyb3AgdGhlIGRlZmluZSBmb3IgbnVtYmVyIG9mIGNsb2NrcyBmcm9tIHRoZSBoZWFkZXIs
IGJlY2F1c2UgaXQgaXMgbm90IGENCj4gYmluZGluZy4gWW91IGNhbiBwdXQgaXQgaW4gdGhlIGRy
aXZlciBvciBub3QsIEkgZG9uJ3QgY2FyZSBhbmQgZG8gbm90IHByb3ZpZGUNCj4gZ3VpZGFuY2Ug
b24gdGhpcyBiZWNhdXNlIEkgZG9uJ3Qga25vdyBpZiBpdCBtYWtlcyBzZW5zZSBhdCBhbGwuDQo+
IFdoYXQgSSBrbm93IGlzIHRoYXQgbnVtYmVyIG9mIGNsb2NrcyBpcyBub3QgcmVsYXRlZCB0byBi
aW5kaW5nLiBJdCBpcyBub3QgbmVlZGVkDQo+IGluIHRoZSBiaW5kaW5nLCBlaXRoZXIuDQoNClNv
cnJ5LCBJIGFtIGNvbmZ1c2VkLg0KaWYgeW91IHRoaW5rIHRoYXQgbnVtYmVyIG9mIGNsb2NrcyBp
cyBub3QgcmVsYXRlZCB0byBiaW5kaW5nLg0KSG93IGR0c2kgY2xhaW0gZm9yIGNsaz8NCkZvciBl
eGFtcGxlIGluIGR0c2kuDQppbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0Mjcw
MC1jbGsuaD4NCnVzYjNiaHA6IHVzYjNiaHAgew0KLi4uLg0KY2xvY2tzID0gPCZzeXNjb24wIFND
VTBfQ0xLX0dBVEVfUE9SVEFVU0I+Ow0KLi4uDQp9DQoNCkl0IG5lZWQgZm9yIGR0c2kgYmluZGlu
ZyBpbmNsdWRlIGZvciBjbG9jayBlbmFibGUuIA0KDQpJZiB0aGVyZSBpcyBubyBiaW5kaW5nIGNs
b2NrIGluY2x1ZGUgZmlsZSwgaG93IGRldmljZSBrbm93IHRoZSBjbG9jayBpbmRleD8NCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

