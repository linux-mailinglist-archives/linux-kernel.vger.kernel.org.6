Return-Path: <linux-kernel+bounces-399469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2959BFF5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA78282F28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66E1D7E42;
	Thu,  7 Nov 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="tYgxufsP"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A5198A08;
	Thu,  7 Nov 2024 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965642; cv=fail; b=uyy/dfbnIEhGITKNsclZO6bbD9XGgSUieRlhewYN8PbNbwlwwoV9soxy8yxoNgQ2JMYYU0RqP34EKN4Cnm46oMJytppL81eMTcFjNHFA2fEXWB6TeyhbnjDdcXr6+EBiirUzfN4hJtiv6+TXB0DYyuqNVFL//AqNkqTJTB6OTFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965642; c=relaxed/simple;
	bh=2B0GeZvBmC59DLQiL6lkijH9MmOmGerZpFxvcTkLnjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jo6++t6VuTbTkPlaV0xdzuInEU37T1qB1tWQYLfIHmYv52qVBabOblkAR9oUHOOPMmrABW+s/kbxTW4MZKhGjFTOk3uWDLNrp5NVr+T8p6cMekRl+As4r9vWsRpXvVJrGoAGc6/XJX7DI7nNw1WFZWqytqX18XiNHmPyEQM69Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=tYgxufsP; arc=fail smtp.client-ip=40.107.117.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoTOQGDlxvi1xtVJHUjEXJnR6G84zTY4yVig6knYez493P/+Cjgv/02dYlEGB+pmcpl9cgrMBJGKew4vNnyyp4lNbDI7VMihOH8X7eRM1w/it95vR3hVxmug+VYdCL7Lx5xcoRoFMoWO+mJl5OnGyiT310eJH0Z85HkjOUsdN4nZHdZ3hPDfpbSHwEUR07IoQUTHqOsE8o9oz0yl99iR7PM7b2BYadDytru6rbI4YeRtEHLud3PGIEtmnxlF+KbUr9sytws3PI6X5gjcwVXKnUBJvTBpblOzHnBUVpgY/OYwbmyjxKVjyeR+PXHn0MYLJlswUFna0JOmJHqSj7hjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B0GeZvBmC59DLQiL6lkijH9MmOmGerZpFxvcTkLnjQ=;
 b=P6YB8eCZpXmLwSdsGUD+xXN1r3nsi0L57Hh/j0VWeVBFODkWjlwFmLgu2bdl65rxjsRx5BErU480xeCh/Mt1ytYhxZqnySldsa/GHMWJNRKhO5iG4Tu8CKLq9uaE8osRtHlCyLpm8qMLJBe48LrcMO+4G1cRzZBySnGelx5UOhbsqLC+2TZqqUu7AiFmDBZvIJuaLAFsRgQNMbPPU+qt/YO7A0/Ad8ls3DXDyWdkHTD5vsAwaOy7I8KpVPc0bUB0KCggImIZ6OVOypFqJ25C5lHXUxpOkwVpGF7E9qSWEAGaKm2oGQvquHAyfYFggPpb2UMrZxgV0A71lIUSlluHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B0GeZvBmC59DLQiL6lkijH9MmOmGerZpFxvcTkLnjQ=;
 b=tYgxufsPWKfdrlewGvm/sHoO54E21ZPqPVryKpyYUvsRFEkl7Cx4yS9+ix3z7gyRvqPOg6mIx/XAiYli4h9o3oxPtl50N1Hlts4BGeq03jwm2SsEbLci/hyfALtcYOPH7e9D9oYt0CJ40cEEY/r0poQtI7zC4zZ0wjrr89F72CY=
Received: from SEZPR02MB5495.apcprd02.prod.outlook.com (2603:1096:101:4a::13)
 by SI2PR02MB6102.apcprd02.prod.outlook.com (2603:1096:4:19f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 07:47:15 +0000
Received: from SEZPR02MB5495.apcprd02.prod.outlook.com
 ([fe80::4fba:bc9b:33e3:6f95]) by SEZPR02MB5495.apcprd02.prod.outlook.com
 ([fe80::4fba:bc9b:33e3:6f95%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 07:47:14 +0000
From: "Haowei Cheng(Harvey)" <harvey.cheng@fibocom.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogu9i4tDogMDAwMS11c2ItbXR1My1maXgtcGFuaWMtaW4tbXR1M19n?=
 =?gb2312?Q?adget=5Fwakeup.patch?=
Thread-Topic:
 =?gb2312?B?u9i4tDogMDAwMS11c2ItbXR1My1maXgtcGFuaWMtaW4tbXR1M19nYWRnZXRf?=
 =?gb2312?Q?wakeup.patch?=
Thread-Index: AQHbLuJOhIt9NRu7m0GuzhYM0mppkLKoX0aAgAJKK4SAAKCkgIAAKjAN
Date: Thu, 7 Nov 2024 07:47:14 +0000
Message-ID:
 <SEZPR02MB5495C6CAF78EC669F65CD6398E5C2@SEZPR02MB5495.apcprd02.prod.outlook.com>
References:
 <SEZPR02MB54953820B2A9EEBD807D0ED18E512@SEZPR02MB5495.apcprd02.prod.outlook.com>
 <2024110512-popcorn-germless-01be@gregkh>
 <SEZPR02MB5495A8637098B92CDEBBFC6C8E532@SEZPR02MB5495.apcprd02.prod.outlook.com>
 <2024110735-lunacy-salvation-684c@gregkh>
In-Reply-To: <2024110735-lunacy-salvation-684c@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB5495:EE_|SI2PR02MB6102:EE_
x-ms-office365-filtering-correlation-id: c49f48d0-0419-455b-01fa-08dcff006520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?eUkyMUNTRjExN3FPeXI4NE9PVVNNZzNNNVh6Qy9hQTVvem9BNEpJdWFJVS81?=
 =?gb2312?B?OTlOZXdIemV1cXRjZjFkVVlyRXZ0WlRTVUlweVVTUTlGdXQ2di8zVzMzUHdy?=
 =?gb2312?B?b0JoL3RVL2VFWUlWVzVwN2Zxdk4yYmZFZzB4MUluODQvOTEvWUJUaDZjYS9Z?=
 =?gb2312?B?VkJGWXBLQ001UlV6dlRuK3R6bk5GUm0zZHJ6ckRraCtpYWl3bGF4bUpQZjRx?=
 =?gb2312?B?WUZKYVB3Q1YwTTdzYXYyMU9qK1lqdnJLaFV6czBHaGl6VkhTanpseGJCaER1?=
 =?gb2312?B?NC9Ld2pkRE41TFN5U0V0Mmd3ZUJtZkVRWFdWb0UwTlhsU0pLOEQ2OHFuRzRM?=
 =?gb2312?B?UkRldzNEb1pvcFdxWUx3VHN2SFdQekI2Y3NuOVIwa0piZXp5ZWdlM0R0dEJm?=
 =?gb2312?B?SW1BZlpJZkZUSUdUMUVPb0F0ZUN3ZFJtNmdtSDYxbjZRajEwM1NKelR3SGhF?=
 =?gb2312?B?ZVRWYnU4VEVtUkxhT0dnT05hUnV3aDNWN1NMUnVwUUxRbDBpZk5mamlsaEd3?=
 =?gb2312?B?eDMxUTFnWDhqemFuVGQ2NGMwRkRNRTZGZGRreUVvWmYxQTVPNGVDWjViTDNn?=
 =?gb2312?B?OTY2c2pmTW1ieGtYQ21EZDI3WVMvMERhUitURm1iZEVIM3lsamo1Yi83M3di?=
 =?gb2312?B?dWlXR0tkNVRRVFBUa1VyN0dzSnJHOG1MMHMrQ3kwNEo1UW41cVVsT0JtK2FD?=
 =?gb2312?B?Qmpuck1HUnlYQWsvUkc1YURVcit3WmpDY3o2VHVIRFUwOWtHNnBlQnFxc24y?=
 =?gb2312?B?cDd0SkFyL0psYUhDSG1vcXRPV0VXQ3hQeUVuSG1oQmFMSG5tL0lDUkdZZWs4?=
 =?gb2312?B?Q1VobkIyVzZ0MTJtWGZNUTJOVWxpa0grMHRVQUovbFdlNjFGZUprdVM1NUpa?=
 =?gb2312?B?UGVSaUN6aEJ6U2kzN281d0w0Qk1FaU5pbGVzbmwvcUNSZ2JvcElpUDdQcHFT?=
 =?gb2312?B?dXpBV0FpSjBHY2xOQSt6WlVPQmMxZzNmRjdVcW9nRkxTc2dHRmxzSi9hTXE0?=
 =?gb2312?B?OXhCOUVOaWRwNlZKTjhCTWxuWnlERFpGVzBPTW52TFlYM0RzeGJxUEVRdkhO?=
 =?gb2312?B?NFFDdEJCTUY4MVFZNDJpQXB0b01CVnoxZXdXTEltUC9SL0l0UTVqRzQ3MlJh?=
 =?gb2312?B?T2tsaVIvbDhzUlNwRVRQdFFZTGRwQzlXQWdwdkg5eEt3N1pXS3V2U2NQOU1H?=
 =?gb2312?B?c0FkLzZoSDJXSFlPK2JBdUJ6UWtOVE9GZW9EUVB0QVB5eGZpRGJWTVBwR0RW?=
 =?gb2312?B?RU5DbEJIT3JPSTRvUk5keHRJVUpreWJGUkUwQVV3M3BQcC9FNUpHS2RhaFdF?=
 =?gb2312?B?cmJvdWZhSlgxVjZOQkNWNVN5TzFJdHFtMVFyYU05Wmt4YzNKSml5SFBtc3pY?=
 =?gb2312?B?VFFUK3I1UVdxVlB5L2ZKVFpGbzUwcFBVQ1p2NERPNEM1QjlDUnRHdEV6WU8w?=
 =?gb2312?B?OU40TVAwNTI0M0tMZi9pU3pCQUcyS1VYamFrZTYwdUtDMzR2aDhHWmVMUkNT?=
 =?gb2312?B?SG1HZmdld2FvdkY0eWZPWTFrd0Z0YWZxKzlGV1VGa3FkQWdZN3paVVRyZDQy?=
 =?gb2312?B?YWZNYWo3Z1JRdU9XUk5WSldjcEphNG9QbmZiMU5aZ1NJNjY3b3RCTll0M0tQ?=
 =?gb2312?B?aFMzcC9JQ1hKQmRObmRodGFzWG5SR1BYZGQwUGowUFJZaTIvSHM2aTR1UlFM?=
 =?gb2312?B?Q2FJU2VWaGh6SmNNRWVYTnVWSVJLUnVlYmtQZXNIT1drTU1xZmIzaC9Mamwz?=
 =?gb2312?B?b1kweVdnVkFCaTc2UlducFZDMlhvcTBDZVU2Z0dkbUxTeEROaVBJR0xncUpO?=
 =?gb2312?Q?oaMvjTMzhDDZaHnAskyApPmfmkB9yOeTp6yuU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5495.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WlZpbHRCMGFMd0E4aUlEOVp5NGY0aloyRWt3ekx0NDdKMFphdm16MXd1dVpx?=
 =?gb2312?B?eWVoK3dCZjYzRERnYkh5dDB4anhvQ25CQVFScEErVVRpbDZzRUw3UzYzaENB?=
 =?gb2312?B?YXFQRFBxZW5jbzdBa2FRSGlUVkRwYjRrbzE5TmpTNDlzeEw3ejJsbXhidG5x?=
 =?gb2312?B?TTMybzBFQlUvU1N6OXFmMFNzZDlkNGJzdlljVjF5NmJLWTBLWWtGNnFJcHRC?=
 =?gb2312?B?STBtNmRaM3hIdGlKOVUwTnRma2UzQXZYYXRFOXd5YW83czA2S0ZRVENQYXhn?=
 =?gb2312?B?WTNQMEhDSm9DSk4xUHdQVkg0NzlzWVYxQWg5VUNySU4xaUhLRzVvVVI4MnJS?=
 =?gb2312?B?ZStUQ0JOYmw0QW8xZm95NHBjLzAyWmxRSVVZeE5DL2xPOVlFR1NQN3k4RXFz?=
 =?gb2312?B?a1k0dWl0cE5qaGFXM1ZGUmVxYU9TRnBzbEtzWHNSbW5yc1J0Tm1abTVWS2gz?=
 =?gb2312?B?QUU3cUJVVTg5NVI3NXludTJHRkZpZFIwUkpXaks2S1VVckp1SVV0eXJ2clM2?=
 =?gb2312?B?bDI2L3BkVTFLTDFjT0gvdjVYdW9yR29JeWEzeWlkeXlqNytsN0dvQkpzdUhp?=
 =?gb2312?B?Vm5nZFJuWVdHMFFOZmtKdkFuc2Z2d1FGVzNUbjA5WVNsZDFlTlhrbjlDQzA2?=
 =?gb2312?B?MURaQ3dBdlJkc3IxYjU1RmVadDJTYjNMT2V6R3IrVHBoaWptUFpjTm5HYWto?=
 =?gb2312?B?elBwdGNNaHdOMmI4bU1jTEs5bllPa2dpMHhXOHNaR250U1VRYVl5Q2FlbFVh?=
 =?gb2312?B?OGs4MmhPZ2UwYnFxcytxSS83RXd5TlhiQ0wvSTEyZm1EQ09NeWVneEtaWk9H?=
 =?gb2312?B?Y3BSZllCZ1ZjU0t0c21mOWQwVVN5L2dvY1pzaGhUOXU0UCtHQ29sdWRFMFg0?=
 =?gb2312?B?Q1duMEhacnp5N2NWWTM5bWEwVHl1R1pKblZOVmVqY3lEeHRBZW05ejd4Zmls?=
 =?gb2312?B?V2htaXJkbGl6bzA1RmZuNWhwL0hwSWNhcGlzbm1Qemp0QlNPdmdjUVhUbDly?=
 =?gb2312?B?eGNGTmQ4VzFZY1BzWnhlR1N1YThPMVVwL1pzSy9GSkFnOTZZWUJJQjRCSU9R?=
 =?gb2312?B?TnhrUUFzVXZxUXBEUmpNNFBjNHZ2ek5FaTFSMmljYUpoVkx1OWFWREI1TmlC?=
 =?gb2312?B?dEFCWFdUNnZPWTViZlkyQm02RjRwVDNzdlpjS2h5S2lOM1UvN1hOR2U5bWJV?=
 =?gb2312?B?VXNnaHlHMkprQ1pVTS9VMTcrRXJZdnAwTCtIWXBEOGR1bmM0RjBPY1lnNnlW?=
 =?gb2312?B?aVMvZnhGUytoczQ4QlQrTUkrVFJJeitqWUxtNWNQcXRKdXoyMllheXc2VWp1?=
 =?gb2312?B?T0Rjak1WclNFWG5ITUdJQTVLc3FZK25TSEIzemRNYko3eUM0NHFqU05rTjc1?=
 =?gb2312?B?ZlB0UkZBdlp4c3Z5VWhKK1FZTkRXMCtyR2hMaWYvWUc2eno2VUpoMTJ5Rmtr?=
 =?gb2312?B?bk5hYTdoV3V5WndxWVhvZXBRMERmQ2lHT0ZadzBTVDNhOFVwZzNlMXdKcmRv?=
 =?gb2312?B?cmdCWm55L0JaRDdLVEpPZE55aE9aTXZoK1dYa2hKZS9hVE9DamJhOUMzTkFh?=
 =?gb2312?B?M3ZDa1Q3TTdmVm9mWDVRaFdibkVVUmNFSitPTmI1R2hYN0dvZXEvSTJVZDIr?=
 =?gb2312?B?OEM0YmNBd1JxVkFPNG1hSFd1S04ybzI1Z01JamhsZUJxMG5hMkZ5M3hXNW9t?=
 =?gb2312?B?K1FOQmNEa1RYS1NFNi8yTi9Td2ZOZFI4WFR5V0V5TDNxOEk3YzFTVjZKaDNs?=
 =?gb2312?B?MzV6OUlRWUQrdENKOVJxNlhJNFNwZDNzazNJZTgyODFBZ0N0SGN4RnVvYk1U?=
 =?gb2312?B?QzEvMENXdzhONCtnSDlEZ0Nua2lTcFJ2V2Q0ckk0cnN0QTNKczZ0SlRvM2ZY?=
 =?gb2312?B?QkxIc0ZXUU4valpBZ2pteXZPdk95SlpLUTQ0bmxnNWF3K1hjTTZSRnAwUHRX?=
 =?gb2312?B?TzlremJ4MktuWTN3R05Ea2pvb0lJRlJWa0NlK3JIOWEzeHg0N3BEd0M2OGpj?=
 =?gb2312?B?VE1YQ0VlaEpWZmhrQlJYSEFFY05kYm5SUWIzaXp6VFQ0RGlqMFNETzdVb2FJ?=
 =?gb2312?B?TlZJRnhIelA1ai9PenE3YTJEMVRpc3FOejlESnNOMjJ5MWprWW5BZVdjenFo?=
 =?gb2312?Q?T0Ek1Ak3a+ReggaV8MOTQGNX/?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5495.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49f48d0-0419-455b-01fa-08dcff006520
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 07:47:14.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGL27G2ee0KBpUDOt9iy2oqN/MBdlYVSQ36xe1mZbGqUAVF3U6ewBGbgDtniV/c/OKRXGi1li2WDeHdYSWEpWTJp3zDrvRpi0CI+a3czRP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB6102

SGkgZ3JlZyBrLWgsDQogICBXZSBoYXZlIGNvbmZpZ3VyZWQgdGhlIFVTQiBSTkRJUyBwb3J0IHBy
b3RvY29sIGJ5IGRlZmF1bHQgb24gdGhlIHByb2R1Y3QgYW5kIGNvbmR1Y3RlZCBleHRlbnNpdmUg
c3RyZXNzIHRlc3RpbmcgYW5kIHZhbGlkYXRpb24uDQpUaGlzIGlzc3VlIHdhcyBkaXNjb3ZlcmVk
IGR1cmluZyBjb21wYXRpYmlsaXR5IHZlcmlmaWNhdGlvbiwgYW5kIGFmdGVyIG1ha2luZyBjbGVh
ciBtb2RpZmljYXRpb25zIHRvIHRoZSBBUEkgdXNhZ2UsDQp0aGUgaXNzdWUgaGFzIG5vdCBiZWVu
IHJlcHJvZHVjZWQgaW4gc3Vic2VxdWVudCB0ZXN0cy4NCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPg0Kt6LLzcqxvOQ6IDIwMjTE6jEx1MI3yNUgMTM6MTQNCsrVvP7I
yzogSGFvd2VpIENoZW5nKEhhcnZleSkNCrOty806IGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb207
IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6ILvYuLQ6IDAwMDEtdXNiLW10dTMtZml4LXBhbmlj
LWluLW10dTNfZ2FkZ2V0X3dha2V1cC5wYXRjaA0KDQpPbiBXZWQsIE5vdiAwNiwgMjAyNCBhdCAw
NzozOTo1OVBNICswMDAwLCBIYW93ZWkgQ2hlbmcoSGFydmV5KSB3cm90ZToNCj4gSGkgZ3JlZyBr
LWijrA0KPg0KPiBXZSBmb3VuZCBkdXJpbmcgZGV2ZWxvcG1lbnQgdGhhdCB3aGVuIHRoZXJlIGFy
ZSBkYXRhIHBhY2tldHMgdG8gYmUgc2VudCBvbiB0aGUgVVNCIFJORElTIG5ldHdvcmsgY2FyZCwN
Cg0KQWxzbywgd2FpdCwgd2h5IGluIHRoZSB3b3JsZCBhcmUgeW91IHVzaW5nIFJORElTIHdoZW4g
aXQgaXMgZG9jdW1lbnRlZA0KdG8gYmUgYW4gaW5zZWN1cmUgYW5kIGJyb2tlbiBwcm90b2NvbD8g
IERvIHlvdSByZWFsbHkgdHJ1c3QgYm90aCBzaWRlcw0Kb2YgdGhhdCBjb25uZWN0aW9uPyAgSWYg
c28sIHRoYXQncyBmaW5lLCBidXQgaWYgbm90LCBwbGVhc2UgZG8gbm90IHVzZQ0KdGhhdCBwcm90
b2NvbCBhdCBhbGwuDQoNCnRoYW5rcywNCg0KZ3JlZyBrLWgNCg==

