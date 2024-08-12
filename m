Return-Path: <linux-kernel+bounces-282820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4694E8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E94FB22E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0792316BE36;
	Mon, 12 Aug 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="pfkMONGY"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668274C14;
	Mon, 12 Aug 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452857; cv=fail; b=JsJF9TSAluP+xv+Uf/9Pjn8/p6VTo3ak4sh/eOHNO2+jT/fgsF+HDWpwQJk/MWMiCvpP/1Ntelz1ZcS2DxxNyON1ZOsaGMHzdjkoiFGF7Xz4qoVwJogcJkM/YVGvv6iuJPMjA5Xm8gU0gzKskF95mjZ+KQ6wh5n30ZOuU+7d4FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452857; c=relaxed/simple;
	bh=6k4DtSbmvBVWzTesE+JHUCl8Ihp6oUSf/DM603c/RFk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUX2agk0f4dU3ZyatB2yL4v46uIva1NqVDIwr25aEvTbUQ6Rn86CeVD6m40EtzGxbjqgBIPDuyHLUf1W+DkKrsHwgcV1KQiYDqlEPiPFQ5HqR/c6nxgFEMPYBq+utiiZ7dCo3AeuOLS+44B2NJxIvIo+5s1LqBkQX+y/tb+y+qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=pfkMONGY; arc=fail smtp.client-ip=40.107.117.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqqhfPIMbJomekUW8azjnQlvMHQKr4CEG4wnAtOT7AtEpqCRSUAJ1MHD9hmv9FQujm+ikecUP64szAYzWf4JExOYx5vXFrPoc/5tiSZOqiEb7XX7f/aFPKWrnDPlLq/fvrdRfYVhwAJYs8p4Oyocqq3S8S0E0lZTib8QvlveZcRP1gsLRALhFT59lY1la6mCzGx8dpBf8sUzRH+Kmz17G/JWKa/e6lO+/57+bNgVjXD/vZ7P6yDZGkiu89ZkJzjgrvw0krYPzK29YQDo3z/iSozxFbfqdtWlJuWUKlsBOn7qmB9CgySRGsg+TXn6L2/Y9h5T2u02Fuk6akU7ePuyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6k4DtSbmvBVWzTesE+JHUCl8Ihp6oUSf/DM603c/RFk=;
 b=B1XUuaeJ7L4oi3RIMNKonLKZc6qYOormKhQ+5E/qoozIGhKAL/DDE389SSEIMyY1uV+orcCtrWq+a1mJXuOu6xldnU+PxI/vS4N/mwaQAbDJpfQAcOrILbwKL3s2Rw9S6+nBviOrg1SYuGrCHAo8fH3dq4eFl/xiiMRJNOIh7EMghPKXwWlFclLgi2uuqiA97is3YXF1PYMYoNvw+1thcDqsUKRsRmBR3FQ2RJgW6pzG0fNwAiiLZBgQA+kVMwCuPNZBgWBc3V+MFU0uerX8O0dTaLMvoPWjB/joVA4g6BommK4yftfJmtApzZvcUX+a2zd55rANFhEns96IykcKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k4DtSbmvBVWzTesE+JHUCl8Ihp6oUSf/DM603c/RFk=;
 b=pfkMONGY6NvpaIfEfrLBUhJFXr+BYJNv7jyrFPigZ9zWC6UuPTSF5Vk0EXtXCYZ0NFIZG/UKYucKkVrIjnw4J7of4y9Tc6jBxXzuxxU522b51ds75wsDFr8doFwaY6HkblOS0JY/H3uKivE9d0gknJqxr1s3ucIGmAPGAK1vBV2Jkdk0IHM3gjwRNh/aorUSs2zhMQNIphuDApqA0qkTGZdJjHlobnV0e36Az+0gs8cWXaHA3fNNjK7/ueiGmbqFqmiJlNMLrSNGl9Nxn20NdcXtgfLGcU3PG/Ry0yBzSM2j0CLCgoiKGLngyHA1F404juV/kkdREcAC3/RCJWTjSA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB5176.apcprd06.prod.outlook.com (2603:1096:101:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 08:54:08 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:54:07 +0000
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
 AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+QgATIDfCAAA4pgIAAAYwQgAACfgCAAASXwA==
Date: Mon, 12 Aug 2024 08:54:07 +0000
Message-ID:
 <OS8PR06MB7541CC40B6B8877B2656182CF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
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
In-Reply-To: <9465f8c0-5270-46df-af4b-e9ee78db63d1@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB5176:EE_
x-ms-office365-filtering-correlation-id: 9c67c09e-d27b-4da6-1a94-08dcbaac5366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1ZZZ3JQd2EyaEpaU21FOEpmdDRqbG5oRUVtTVZPeERKd1lUWFhzc2VZckhK?=
 =?utf-8?B?cXk0VXByaGx5TGtLdXpOd2NaNHNUbUxmVVpDR2RiVk5aYXpMTkRKc0p4MjJO?=
 =?utf-8?B?ZW9aWHlva3pnQWxlS2I0WmcvU1U3WmM4a0FHcnVIMlNBL2lrTnVRU2ZDOFN6?=
 =?utf-8?B?MmpPQzBaZXJ0M0d2dzU0aE53VENwTXdzbEIvUEljQ0lsaGZESEl5ekNqUTAz?=
 =?utf-8?B?ZnlTbFE2NlRGNW5pdUpROERyYVRiMERWMGpYWktyWmdiWXlqaW5HbXpIN3Jn?=
 =?utf-8?B?UmRYdTZSRTNOdFF4VHM1Ni9heUE5VkZGSTNYcytKOUtwcWlGV1JVQjY2U3Z1?=
 =?utf-8?B?bXBreUYxTjRtTWxWOUxPUnE0dlJnNmpoRnV4U2IrNXNlNFRHQWlmR1hoNThx?=
 =?utf-8?B?dXVPb2E4YWtNUVJqNHQ2a0U2bVZBemd6Q1AxUjhRYnNUL29QMWFTcFpPTTJ1?=
 =?utf-8?B?WjFKR0JHTERacWwwTVZkSFZUQ3RjbVRPUmFPY2p5VlJzZHl1SnJ0OHl2TGVq?=
 =?utf-8?B?Mlh2MGRnc3daYVVMdklBTlFyL1FUd2RaTDd0VW5vUEJsSmsrWlh3cUNHWCtT?=
 =?utf-8?B?bmNkSkFBa3BxOFJYTlBmOGZZQnJ5a3kzRDFheXE5NlVNdkNMODVmbXhFVjNY?=
 =?utf-8?B?NG5LbHhpK2MxSFJsd3k4bnFQdTZ5bnNFMHNRYXJUcDJCb2xkeVFxUmlVUEM5?=
 =?utf-8?B?RGQ2T2NEd0pMeHdCV2U0NkZOZkVWVlRSYldrUDVLektubUp6RitVdnhnUi92?=
 =?utf-8?B?SGhHUi9ESEJWYUZBVnRpKzZnVWtnUzJxRUhrWEFsR21KbGF4QkQrc1FFUjlS?=
 =?utf-8?B?SHc4eCtadkJoZDh2bFUxcUhGUnlEcWg4ZlBIUGVmRHZ3NUp4L2pZN0IxUjJJ?=
 =?utf-8?B?bUM4MjY2emRoYkZ2K1FhakUrNUJETnJyK0M3dmlCQ09JWW0raGNTaHVrT3dI?=
 =?utf-8?B?MEVBamUyaGw1RXppeS93L0FOVXByeTdnWGZaQURJeEUrbUVHVmpxRVNCZy96?=
 =?utf-8?B?K3NnQU9xM3U1Uk1EN3NwbUtzdnRTbmlIYkZxb2JIc0F4WnlueUJrTExuRWND?=
 =?utf-8?B?QjQ1NkJhLzN5ck5oTERSOVV0QlcrWlJDcEdDUEdLL0pZKzlUTC9FMkpwRVRl?=
 =?utf-8?B?Y3Y2MWV6MHVmRmJmdHJTV0tocWNkQWp4dFBVR2MwajNSd09wQXNmUllXZWZW?=
 =?utf-8?B?MlJlWFVtYk5tWWZvL0tqVm10M0FGSUJwa2RWTGNIcVVCdi9UU29ZU2ZCWk9K?=
 =?utf-8?B?RGdOSXRrK05sMkovQXJvOG9YRXNlWEJ1akdQMmpRdTM0UjUwbVpjVlVPaGg2?=
 =?utf-8?B?SEgyUlhvRjlSVDM1UVJML2QzeFNTMW5RSldHUnJ5NTZTS2ZENDNoWlIvb0Q1?=
 =?utf-8?B?M1QrSU9zdHpNOGdWc2YxbDVvVHBBcmNaczA1dis5VW5wTUxGSkF5UnhYcmMx?=
 =?utf-8?B?bXI0c1RBV3pUeHdMUzdmOUNuTFFWNG90OWNldTRMcEY4dHJPZ2N4WGp3REUy?=
 =?utf-8?B?RFdEWUZPb3NNWldrRjduMUZLNXNkT0RWYUdkci9qc1RSdk1TR25YaWZXdXpp?=
 =?utf-8?B?N2tMRmdEU3J5Q2RsMmROaVEyWVVUU3dMK3l2SDRFQkJiT0ZHcTZSeXRFQTU0?=
 =?utf-8?B?Y2J1WFdTcDNtYlN4NGxtaEtjbjljMTlDMEZPcHdpTGZaTzRZR1hrbTlNOXU2?=
 =?utf-8?B?MzJseE1KdVlaR0NHUXVZOTAyZU9vZ1dIbERTenM3d2kwNXRySGlSdEZlcXBV?=
 =?utf-8?B?NnJvcTBmbnRaQ2t2SFJQeUsvWUhJQTFadnJvZER3cWpIN3l1T1V5RU9Sbmo1?=
 =?utf-8?B?YjRUMGRTNDJZUXpNOElxeFNlakV2c29PNmhPeWZ6OHgyeVlDbSs0R2ZOUU0z?=
 =?utf-8?B?QVVzaVo0THBsTE5JRVJHUk94RDFJRjR0Vmd2dkNMTEo5bk1sZVJvb0d4dTB4?=
 =?utf-8?Q?mznEBu5kTKU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzFMQ0dGcVl3Rm1zd3o1K3NlQzUwTzFjSXRlc1JKSmhqckhzSDZ5SmhjYVJ2?=
 =?utf-8?B?Sm5UdTljQXRHZDY0ODFMTHVGcTZiMGE0RWFYV0YxSFR2cjMwOWIrUjRkL3NB?=
 =?utf-8?B?Y2lNWmppYlVJSWRWQldwWWJZc2tSczBzSFJBUjJjbGwvZWRxdkFiVFJmYmNt?=
 =?utf-8?B?S1d6bXhSL3ZuczJDeGFYMWZ1TEFHZHhJSVM1RFk2K0p2Q1ZZZTh1d1UvRXFM?=
 =?utf-8?B?bFQvS1laTm1TOEVlaUlJVjIyaWtRTlFUWEVYU2kvL2x5Q2h6d1Ewdkcvd1JQ?=
 =?utf-8?B?bC9VbTdIRE0xWmhTZjhhWi95N0JoOS80TVpPTFI4eDNoMkhKSWhoNms1cWlt?=
 =?utf-8?B?MDgrNHZkU1J2UlFLV1BtbWRTUzFMejRPME1NcytRaXpUbndTS3FaZ2FvVExt?=
 =?utf-8?B?TUVGSlBFTk1mTENHZEVMRnFnR0NNbDJhZnU1Tk9nL1lXN1N5NmwrZTd5OElL?=
 =?utf-8?B?K3FKaEJkVE05d0hDWjFIaURHalhpZi9jUVc1cGh4RDROT0VJVndGRmpsNCts?=
 =?utf-8?B?NHNObnpJV3RjRDFNclZmREs4Q2pLK3JBcFVtSFVuNmd6SDRxdkdSYll5WUpy?=
 =?utf-8?B?ekZMcGRTcVUrbFJTYU1ldWxhbUhWbW5nbS9zb1VGWVVDZ2d3VGI4RE95ZCtw?=
 =?utf-8?B?UGtkN213S3pzQTR2NkdBN3BZNk5ta3RGT013WmZrMmRNdE5zSnFSYWZsMWJR?=
 =?utf-8?B?WWRReHBkQWpXaGx4QnBhOHZ2QXZTZFUrekJobWJ3SWRORTArTDBERVNqNGVz?=
 =?utf-8?B?TzNLMWlwTUphaFF6VE8xTGtMcU8zbjExL2pkRU81dEVvbjhQbzVKN2I5R0Qv?=
 =?utf-8?B?Z2FMZlY3aVZFTWpPU2l6b2lxdW1HTVVkdUJYUDlCcmEvSzJYWHdvQjl1d0Vt?=
 =?utf-8?B?My9Cd1hReWRyUEhmWG1XU01MV3VHdUxnL0E2S0JDQnBVSWt6YWtzSWdHa2M0?=
 =?utf-8?B?dnBPZnVuTjhUeEZzSEhPM1ZoYTdhSG1BZExYVThGeVkrUGYyME5LRkpERlVX?=
 =?utf-8?B?bUhQeXVpREhJMmkxTUZDYjhkdkszWjBkYW91T2UyY3d4emVlOURCK0NDRnFn?=
 =?utf-8?B?TGM5bXRRSFUwczh4T2RubkcrUHRPNCtCSUltOFp1THFhajhYUHFTSjVaWmJn?=
 =?utf-8?B?NjVSUFZPM0IzU25DL21DWmJKd1ZjWENocXZNZWkzUUMySjkvVE4vUERVODBT?=
 =?utf-8?B?aVpmUjY0M2srNEpWNHlMRCs0QUxuMUNhK3BteThKd0ZXdy9sbFhpVEtDL2hW?=
 =?utf-8?B?eVRoblNKUmdKSk5mSTAvSCtjV2RVaWFPczVCVmlsT1IzL0wrSXRhOGs0ZkMr?=
 =?utf-8?B?amg5bzc1S3NFNFlmOGMrUlVpczJXdWxmVmY1S2JUK3BDSVV4Zk5hOGt4YVha?=
 =?utf-8?B?dGJiZkEzeGZ2a0tUaU5kaDFzbmt6ZThibFh2ZXdZaXlsK0UrYURINFZxT1Ux?=
 =?utf-8?B?SHJ0ZWdEeUJINkdKTnc4bHJSRzU4QUJ3YzVjSk1INUttTGFpanYwUDBEUC91?=
 =?utf-8?B?clZpSXNtbHpYcldWNU0vNDlIMWRidTIzUG1sb0M1MUZGZHIxVHdURHFnbkV3?=
 =?utf-8?B?VEZTV3FadDhzT1dRcDc2UEJYYWwzL2NraWxIN3ZvOVB0UW5wVzcyb3ZLZHBD?=
 =?utf-8?B?cDVPUG1ncGhZeGZERGhGVG5DM3pCQUl6YVZoNlQ4dVU1UVE1UENZcW15cVdl?=
 =?utf-8?B?QVNBQWwxRlZtYWUzbGNVNlJJeTVSeUcwK0JJK1VVY1RGYzBxVVBnYnRZM2hM?=
 =?utf-8?B?bk5iZ0ZqU3d2L2lDbmtpLzVpdzdna0gvSkVWU3YrUVdxbFRaSVRMRmVkM3g2?=
 =?utf-8?B?Y2oweklJT0grajZGeHZWRVJwODYxQjRLR3VZTkhFUDhrMUJ5REJnY2pzeVpB?=
 =?utf-8?B?M1pGaFNreUx4VDFPNTJRaWwvU2dadnNuU3VqWGlRMkc0TmRKdm5BT1hKK01i?=
 =?utf-8?B?V3RERDRNMHd4Z2lrZmI0bGNtV3NFM0JCTFh4K3FSeVFySzJtZzVIYVBMa2FE?=
 =?utf-8?B?MWRsOTZsQjFaNlN5cVV3MGZoS1k1L2N2cDdVblIxM1FTOUtjVGpkYkpySS9J?=
 =?utf-8?B?SHBzV3dUbEhWa3p3YnFPaWszUWV5MUpzeGdKcVM3Sy9tZEU2N1ZNWGNIQU1z?=
 =?utf-8?Q?etIFYX2zPRg0EQrZ1f5yxUu+Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c67c09e-d27b-4da6-1a94-08dcbaac5366
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 08:54:07.5791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wI5raz2ltRZYQVAfyRaBO52jIETsmZ+U0BpY0WsYg45PT+RFtcdjCqNlBkH/AuULKoY7/ME0BvmreGpfqcsT4TYbaCkGGIVNhDDIqn88uKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5176

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gT24gMTIvMDgvMjAyNCAxMDoyMiwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBB
ZGQgQVNUMjcwMCBjbG9jaw0KPiA+PiBiaW5kaW5ncw0KPiA+Pg0KPiA+PiBPbiAxMi8wOC8yMDI0
IDA5OjI2LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+Pj4gU3ViamVjdDogUkU6IFtQQVRDSCAzLzRd
IGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIEFTVDI3MDAgY2xvY2sNCj4gPj4+PiBiaW5kaW5ncw0K
PiA+Pj4+DQo+ID4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy80XSBkdC1iaW5kaW5nczogY2xv
Y2s6IEFkZCBBU1QyNzAwIGNsb2NrDQo+ID4+Pj4+IGJpbmRpbmdzDQo+ID4+Pj4+DQo+ID4+Pj4+
IE9uIDA5LzA4LzIwMjQgMDc6NDcsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPj4+Pj4+PiBTdWJqZWN0
OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcwMCBjbG9jaw0K
PiA+Pj4+Pj4+IGJpbmRpbmdzDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBMZSAwOC8wOC8yMDI0IMOg
IDA5OjU5LCBSeWFuIENoZW4gYSDDqWNyaXQgOg0KPiA+Pj4+Pj4+PiBBZGQgZHQgYmluZGluZ3Mg
Zm9yIEFTVDI3MDAgY2xvY2sgY29udHJvbGxlcg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+Pj4+
Pj4gLS0tDQo+ID4+Pj4+Pj4+ICAgLi4uL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAw
LWNsay5oICAgIHwgMTc1DQo+ID4+Pj4+Pj4gKysrKysrKysrKysrKysrKysrDQo+ID4+Pj4+Pj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25zKCspDQo+ID4+Pj4+Pj4+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+ID4+Pj4+Pj4+IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVk
LGFzdDI3MDAtY2xrLmgNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4gPj4+Pj4+Pj4gYi9p
bmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4+Pj4+Pj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+Pj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmFj
ZjcyMzUyYzNlDQo+ID4+Pj4+Pj4+IC0tLSAvZGV2L251bGwNCj4gPj4+Pj4+Pj4gKysrIGIvaW5j
bHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+Pj4+Pj4+PiBA
QCAtMCwwICsxLDE3NSBAQA0KPiA+Pj4+Pj4+PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAqLw0KPiA+Pj4+Pj4+PiArLyoNCj4gPj4+
Pj4+Pj4gKyAqIERldmljZSBUcmVlIGJpbmRpbmcgY29uc3RhbnRzIGZvciBBU1QyNzAwIGNsb2Nr
IGNvbnRyb2xsZXIuDQo+ID4+Pj4+Pj4+ICsgKg0KPiA+Pj4+Pj4+PiArICogQ29weXJpZ2h0IChj
KSAyMDI0IEFzcGVlZCBUZWNobm9sb2d5IEluYy4NCj4gPj4+Pj4+Pj4gKyAqLw0KPiA+Pj4+Pj4+
PiArDQo+ID4+Pj4+Pj4+ICsjaWZuZGVmIF9fRFRfQklORElOR1NfQ0xPQ0tfQVNUMjcwMF9IICNk
ZWZpbmUNCj4gPj4+Pj4+Pj4gK19fRFRfQklORElOR1NfQ0xPQ0tfQVNUMjcwMF9IDQo+ID4+Pj4+
Pj4+ICsNCj4gPj4+Pj4+Pj4gKy8qIFNPQzAgY2xrLWdhdGUgKi8NCj4gPj4+Pj4+Pj4gKyNkZWZp
bmUgU0NVMF9DTEtfR0FURV9NQ0xLICgwKSAjZGVmaW5lDQo+IFNDVTBfQ0xLX0dBVEVfRUNMSyAo
MSkNCj4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV8yRENMSyAgICAgICAgKDIpDQo+
ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkNMSyAoMykgI2RlZmluZSBTQ1UwX0NM
S19HQVRFX0JDTEsNCj4gKDQpDQo+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkdB
MENMSyAgICAgICg1KQ0KPiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JFRkNMSyAg
ICAgICAoNikNCj4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9QT1JUQlVTQjJDTEsg
KDcpICNkZWZpbmUNCj4gPj4+Pj4gU0NVMF9DTEtfR0FURV9SU1Y4DQo+ID4+Pj4+Pj4+ICsoOCkN
Cj4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9VSENJQ0xLICAgICAgKDkpDQo+ID4+
Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkdBMUNMSyAgICAgICgxMCkNCj4gPj4+Pj4+
Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9ERFJQSFlDTEsgICAgKDExKQ0KPiA+Pj4+Pj4+PiAr
I2RlZmluZSBTQ1UwX0NMS19HQVRFX0UyTTBDTEsgICAgICAoMTIpDQo+ID4+Pj4+Pj4+ICsjZGVm
aW5lIFNDVTBfQ0xLX0dBVEVfSEFDQ0xLICAgICAgICgxMykNCj4gPj4+Pj4+Pj4gKyNkZWZpbmUg
U0NVMF9DTEtfR0FURV9QT1JUQVVTQjJDTEsgKDE0KQ0KPiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1Uw
X0NMS19HQVRFX1VBUlQ0Q0xLICAgICAoMTUpDQo+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xL
X0dBVEVfU0xJQ0xLICAgICAgICgxNikNCj4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FU
RV9EQUNDTEsgICAgICAgKDE3KQ0KPiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0RQ
ICAgKDE4KQ0KPiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0UyTTFDTEsgICAgICAo
MTkpDQo+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfQ1JUMENMSyAgICAgICgyMCkN
Cj4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9DUlQxQ0xLICAgICAgKDIxKQ0KPiA+
Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1ZMQ0xLICAgICAgICAoMjIpDQo+ID4+Pj4+
Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRUNEU0FDTEsgICAgICgyMykNCj4gPj4+Pj4+Pj4g
KyNkZWZpbmUgU0NVMF9DTEtfR0FURV9SU0FDTEsgICAgICAgKDI0KQ0KPiA+Pj4+Pj4+PiArI2Rl
ZmluZSBTQ1UwX0NMS19HQVRFX1JWQVMwQ0xLICAgICAoMjUpDQo+ID4+Pj4+Pj4+ICsjZGVmaW5l
IFNDVTBfQ0xLX0dBVEVfVUZTQ0xLICAgICAgICgyNikNCj4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NV
MF9DTEtfR0FURV9FTU1DQ0xLICAgICAgKDI3KQ0KPiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NM
S19HQVRFX1JWQVMxQ0xLICAgICAoMjgpDQo+ID4+Pj4+Pj4+ICsvKiByZXNlcnZlZCAyOSB+IDMx
Ki8NCj4gPj4+Pj4NCj4gPj4+Pj4gTm8sIHlvdSBjYW5ub3QgcmVzZXJ2ZSBJRHMuIFRoZXkgYXJl
IGFsd2F5cyBjb250aW5vdXMuDQo+ID4+Pj4gSSB0aGluayBmb3IgbWlzLXVuZGVyc3Rvb2QuDQo+
ID4+Pj4gSSB3aWxsIHJlbW92ZSB0aGUgY29tbWVudC4NCj4gPj4+PiBBbmQga2VlcCBpdCBpcyBj
b250aW51b3VzLiBUaGFua3MuDQo+ID4+Pj4+DQo+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xL
X0dBVEVfTlVNICAoU0NVMF9DTEtfR0FURV9SVkFTMUNMSyArDQo+IDEpDQo+ID4+Pj4+DQo+ID4+
Pj4+IE5vLCBub3QgYSBiaW5kaW5nLg0KPiA+Pj4+DQo+ID4+PiBJIHdpbGwgbW9kaWZ5IGJ5IGZv
bGxvd2luZy4NCj4gPj4+DQo+ID4+PiAjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUlZBUzFDTEsgICgy
OCkNCj4gPj4+ICNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gICAgICAgKFNDVTBfQ0xLX0dBVEVf
UlZBUzFDTEsgKyAxKQ0KPiA+Pg0KPiA+PiBOb3RoaW5nIGNoYW5nZWQuIFN0aWxsIG5vdCBhIGJp
bmRpbmcuIFdoeSBkbyB5b3Ugc2VuZCB0aGUgc2FtZSBhbmQNCj4gPj4gZXhwZWN0IGRpZmZlcmVu
dCByZXN1bHQ/IERyb3AuDQo+ID4+DQo+ID4+IEFkZHJlc3MgZmVlZGJhY2sgc2VudCB0byB5b3Ug
ZnJvbSBwcmV2aW91cyB2ZXJzaW9ucyBvZiB0aGUgcGF0Y2hzZXQuDQo+ID4+IFRoZXJlIHdhcyBu
ZXZlciBhIHJlcGx5Lg0KPiA+IFNvcnJ5LCBtaXMtdW5kZXJzdG9vZC4NCj4gPiBTaW5jZSB5b3Ug
dGhpbmsgIiNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0iIG5vdCBhIGJpbmRpbmcuDQo+ID4gRG8g
eW91IG1lYW4gSSBzaG91bGQgI2RlZmluZSBTQ1UwX0NMS19HQVRFX05VTSBpbiBjbGsgZHJpdmVy
LCBub3QgaW4NCj4gYmluZGluZyBoZWFkZXIsIGFtIEkgcmlnaHQ/DQo+IA0KPiBXaGF0IGRpZCBJ
IHdyaXRlIGluIHRoZSBmaXJzdCBBc3BlZWQgMjcwMCBwYXRjaD8gU28geW91IGFyZSBub3QgZ29p
bmcgdG8NCj4gcmVzcG9uZCB0aGVyZT8gQXJlIHlvdSBnb2luZyB0byBpbXBsZW1lbnQgZW50aXJl
IGZlZWRiYWNrIHJlY2VpdmVkIGluIHRoZQ0KPiBmaXJzdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaHNl
dD8NCg0KQXBvbG9naXplIGFnYWluLCBJIGRvIHRoZSBpbnRlcm5hbCBkaXNjdXNzaW9uLCBpdCBz
aG91bGQgbm90IHNlbmQgIkludHJvZHVjZSBBU1BFRUQgQVNUMjdYWCBCTUMgU29DIiBzZXJpZXMg
cGF0Y2guIGl0IHNob3VsZCBiZSBzZXBhcmF0ZSBzZXJpZXMgcGF0Y2guDQpJdCBzaG91bGQgYmUg
Yml0ZSBieSBiaXRlLCBleGFtcGxlIGNsayBkcml2ZXIgcGF0Y2hlcywgcGxhdGZvcm0gcGF0Y2hl
cywgaW50ZXJydXB0IHBhdGNoZXMuDQpTbyBJIGFtIG5vdCBnb2luZyB0byByZXNwb25zZSB0aGVy
ZSwgcHJlZmVyIGhlcmUuDQoNClNvIEkgc3RpbGwgbm90IHVuZGVyc3Rvb2QgeW91ciBwb2ludCAi
bm90IGEgYmluZGluZyIgaXMgfg0KDQoNCg0KPiANCj4gRHJvcCBmcm9tIHRoZSBoZWFkZXIuIEkg
YW0gbm90IHNheWluZyB5b3UgbmVlZCB0byBkZWZpbmUgaXQgaW4gdGhlIGRyaXZlciwNCj4gYmVj
YXVzZSBtYXliZSBpdCBpcyBwb2ludGxlc3MgYW55d2F5Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0K

