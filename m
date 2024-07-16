Return-Path: <linux-kernel+bounces-253785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3939326F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DDF1C20B52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AC419AD45;
	Tue, 16 Jul 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="IdGm69ps"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020092.outbound.protection.outlook.com [52.101.69.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600219AA70;
	Tue, 16 Jul 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134545; cv=fail; b=W+Qu02iBZsPuiP2BaOLjdBIKrSWARSKG1G6PhSDbhwokhpJ4AzsAhiXMdQZD0jo8K3maBYWcEddkTC2fkfrjIPEwLFd5Y3yIzmxAznOMhsmX+qkmEGfjX4twsFCzlpJ5GjXU2/ZYtXCqooXCRJWBQ/FUBp9soPR7frJC0McB7Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134545; c=relaxed/simple;
	bh=4FkwyUKAsJirvhriXxdrzWw/tUGA5Mdrl7/5H2nWVoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ThnqVLyffvtGoXbB808AuQYmRl2IYUcFQujjD5EZbCgy1lZz7kuq722xUxHeTyBpkfVUlPpLam+tLsSk87HYEMyTBoeuhZyDA/SleNKOFIktnk+jKd7E/WpnyBJPUlkJKJQrgcEdKRG7iD78MdPAumZgTqV2tl4kZ4EUaUzlDMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=IdGm69ps; arc=fail smtp.client-ip=52.101.69.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh/OFIuFtXIoEQKXhNbPuVukGcFjWzoFt/Fu5KCXG2QbW1ESs9nwx7cOXhzhWZ1j9eTUSd0i866ywbiYtpR3FC+txEDMoC+18niEyjEfGx2DDzGhtxInPmxkuZ0o0MJpXNIFQplMyS4jYoXB9WOLOmRf72jYJkPFuloxG68TKH2FJ/Xoc4kJVHLc7JvXszRzABnzmertlJsqltycQeYU41sfPijSV9/vsA0s+GwhrOKnxinkmF/apfGKA3ARhLkrm5D5ZcjB0xHcNT6HRNaMLJFKZmu9WWkXh6/+KjPVmCk0Twb+7o6sdYz+tn63wjeYFYCGgniKqDQ9RL2347sPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FkwyUKAsJirvhriXxdrzWw/tUGA5Mdrl7/5H2nWVoQ=;
 b=gLTRmpH7Uit2BL4XeLphZI2ZtczmTd+ayrrJCPt93lGcgb4f+b4IGM/STpJ4ZPi4l07W874Aj5ImP1Nubz7rCAm5pUyK9cT5O6Eo8HBjh1WI8TvuL0NIfoKWf2FbL9wii85TzHpXPWbsRa/6KyVTzZYZfysNgQUJnG7APE4ZjZXQEZGVebnEoQKxaKmBEh/T6A5/+Kg2v5CWmqXa7tADIguqVKKOvOjH3YznpJl1erR3zjC2YIP8xySUktfuPxJc8jVk/OinqpVgaRt1wXpMeplhr8dlNquMZXjkG1IxGAEvJ6ytGpnYxljmrDRes74dmZLwNLJesJvU+aAPMlQNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FkwyUKAsJirvhriXxdrzWw/tUGA5Mdrl7/5H2nWVoQ=;
 b=IdGm69ps6PwZgWHeViN/LQFDZb7TEzlH2pU75w4oqTLz9Qtf7tSGhxr7A+fRD1ht8Xs85LhyqIna7PCtVxeRVR0yvTm+5A0qUMxv28xHfE9J6y+b5YPh1T/4BKCQ1Tl1fWOIQr4McjhRs2X4rkQlGBg/yAyS62pa6vn6zt4S8zY=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DUZPR04MB9897.eurprd04.prod.outlook.com (2603:10a6:10:4ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 12:55:39 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 12:55:38 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] arm: dts: marvell: armada-38x: add description
 for usb phys
Thread-Topic: [PATCH RFC 2/2] arm: dts: marvell: armada-38x: add description
 for usb phys
Thread-Index: AQHa1t8UBLBa+iFCB0+N+odSS9eyG7H5USqA
Date: Tue, 16 Jul 2024 12:55:37 +0000
Message-ID: <bbb5c223-d75b-4adb-9930-a67126c16605@solid-run.com>
References: <20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com>
 <20240715-a38x-utmi-phy-v1-2-d57250f53cf2@solid-run.com>
In-Reply-To: <20240715-a38x-utmi-phy-v1-2-d57250f53cf2@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DUZPR04MB9897:EE_
x-ms-office365-filtering-correlation-id: f8cfcd10-06a5-4c3b-2bd8-08dca5969739
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWJ3U3lRc0EzUjc3ZVpPR3FiMFhDTVNsdjFSWEdrZWpBQUhFWEtDbTI5RWNY?=
 =?utf-8?B?N25nUmxxYjVDcXRJMnhoVE5rVG51UHJ6QWoveVc1QjBrTFlwK0d3N2NUdXhP?=
 =?utf-8?B?dzJjN0FUNXUyS29uK2h2Y0l0TnB5ZE1McTJ5cXpaaEZsV2h1WmNJWFFmcXFM?=
 =?utf-8?B?M0ZtVXM4MlE0bUtldDliMDUxMTZ0N3VXdjc3cmEzcElFMytLNFJWRkMyMTZI?=
 =?utf-8?B?aFVWSDA3U0FWM1F4U3cxdzJoR2F1ckxPazFXQ2N3Y0xJWUx5TDJWQ0lacWRG?=
 =?utf-8?B?TkQxR1lJK2kzSlBFL1VxQnVVbjBqLzdjQlY3UlR0N2N1MEN1RU01bEdTTUlw?=
 =?utf-8?B?SnZyZlp6UElSMzlPRGtKZGYwZ3J0aWFnREVMRmxJWkttZlEwQWpicEJBbldO?=
 =?utf-8?B?cmNYL0lRdzhSbGMvanhqd2lIWHdwcmV6WmhuSXA5YmJuVkthdVErNkRLQ0t0?=
 =?utf-8?B?MWVVSzkxK2c2dWhVUGN1dFlVMG5tR2FDSVE1bFFDeVNpM3V2UFdKc3JvLy9R?=
 =?utf-8?B?NDBwRmFiSVUwMWlldmg0a2pFS0RITkVQVFpaeFhhVHBFQjY2U0FoZFhWNC9T?=
 =?utf-8?B?bTdGQ3QrS0lFSGdJUng2SUxqZjNxc3Y3OVpodHBpTVRtRFM2KzcrdllaTE9L?=
 =?utf-8?B?QTdubDIvMlJScTFaaE1OZElhajdUZXpsanZoTVp4SXRUOVNkZGY2aVl2M1NY?=
 =?utf-8?B?bmlQY2ZnTEUrTGtTUlk5RnZvUEh1WDl2aGk4ekpra1lKOURCWGk5WTUyR0ll?=
 =?utf-8?B?RWlVd05oRXNGWFpjUGNwdUtoZG9lUy9ZQ0JId0VTQzc1Wlp6c3VKVVNTVEVx?=
 =?utf-8?B?S3ZsaktFNG10TjRpOFBMVnp6ZDlLVzVvMDM1YTVyZVlhV0pCMk16cWVmQzI1?=
 =?utf-8?B?WVA4U2FnaCt0Y3k3TVBhVE1kL3kvZ3pXZHJHdnNMN3NtNlhaS0dvYllGMXEy?=
 =?utf-8?B?Ullab1VLTCtTRmFVUTlYclRIb01HemVHYnF4anJLUGtLendON2h2ZURrNlhL?=
 =?utf-8?B?alJJeWZzdmp4Qk1KZTUwQ3RpOVdWNHIvUi9Bd0Q5Qk9VaklzRXBwdFBqQWo2?=
 =?utf-8?B?MWxLRU9NOUluYVlBd3ZyUGNTQjllbjNqMkZyWm5JdzJRQkZ1TUxDUjYwQ1ZG?=
 =?utf-8?B?NGRzMHJSREFGMXdWQlppK3J1YUVqMnJ0Q21FVi8vOU55RDNqMUJoRFErc0lG?=
 =?utf-8?B?Wmpyd2VIK1BLNHlSTGNJZGxOaVNGUjczbXVUT214YUcvT1hXbTRRYUtVUHZ1?=
 =?utf-8?B?dExEYng2T1lpRWd0Y3VTbWtreEd3YzhqeTZFTFQyandoYXc3Y1llcHdoWW84?=
 =?utf-8?B?dkNoMHV3a2FzbmczSnZqQmdPd0FKVGpwcnhjZE5oaFE2Tzh6TDZXUWJSWmNu?=
 =?utf-8?B?bmlrbnYwekxJa2JMdS9yUWxCckxIR0c4WGRPOFZ2NlhJK2ZTeUFaQ2R3RDNN?=
 =?utf-8?B?KzJjREFIZmQ1ODBPWmZlaENLVXZ2dUdsakVHNFRpaWRTc1hnc1BsOEcvRERF?=
 =?utf-8?B?R0ZqWkdsZHlLTDBMM0x5a0JmT3gwNzFzS1dHSGZ5V2FBZ0FzbzRqYUI3em1F?=
 =?utf-8?B?RlY1Z3hINmdDSHFBV1NaNFJobytCZXJvYWZyb3RicHRscFV4aUFNSzJITnFs?=
 =?utf-8?B?R2xpSU1pQ2htZVVCQjk4WXQvUlg2cnJiYXRZRWtHcy9QeFlZbDl1SXdwaHlM?=
 =?utf-8?B?RzlGdzJRY21xWTA5SHRHS0I3ZXp3czFQUCtZcm14RENHclAwVUE5eU9jZVpI?=
 =?utf-8?B?a0QyRmZFTjVKRURGamZoTXY2L0poTDlJSGNSa0xRbVlyVnhZaTVESGg3RVBX?=
 =?utf-8?B?MUxLelN1eVN1Y0MwR0Z4d2FGM1NOZ1VpQXl2TjNkMi9aL0NhVEw2MGNpNlVF?=
 =?utf-8?B?TzBxOE9xWUFGQVE3K0o4NE9jQXJwb09rNzNvR3JodlJuL2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cE9HZkI4VklUOXVOd0QzYXo2L1VSZ0NkUGJicEwzZEEvMEVNVGlXVkhjUFpS?=
 =?utf-8?B?VDA2OVp5UkQzN0Y4TmZLQWZIS3dvS2ozSHBVc2NyRzlOZkRSZXN0NmdrM2hG?=
 =?utf-8?B?dzlFd3ZvZVlYMGdKSmVCMG5VVHNrdUtOd1ZSZ1FiY1RaWVBtK3VnUm8xQWYx?=
 =?utf-8?B?Nk51OWlCRW4wUEpyY01Qd3IxMld3ejNiR0twWS9jRWpYZFRvKzczV3lTNUpW?=
 =?utf-8?B?NmJEN1hXU3JzUTkwd0MyMFc1V0JNdHh4SmtkZnRZaTRvS1dkNEZSUzcxVHFz?=
 =?utf-8?B?cjErYXIxSThUak1jWTcyaFFXRnlSWEpJK3ozSkduZm4yK0RCU3loelR2NDR2?=
 =?utf-8?B?UmtCbzlwTHFzWk81akNtMkRONXI3dE1manJWS0hmU0NwRXhFMDA5eDdJTGVj?=
 =?utf-8?B?bUFUNjVBZk92UUh3dU5semMyNUJibEp0VTczcGE5b29ha2ljZ2VHbmlmZnB1?=
 =?utf-8?B?d1lpNnNtUjFKRE9aUEpFQjhMbDNzcTdyREZEb3pIejRmUW1hb2ZjTExFV3dB?=
 =?utf-8?B?NnN5azE5dHQyTFk3c0tsSTlIS0tYNG1uSTFqR3d0bm5jMWRpVnF4cHA1R2VT?=
 =?utf-8?B?M0ZqekpYR2VJVndWU0ZKYS9oczFDMkpDNUE0b2Z0ZHVZTDczNXFFcUJ6YzdG?=
 =?utf-8?B?Y25lbXVBWkorN2RUbFJQYXFnT1ZEMHNiby9Jc2dhZDNKL3laam5hRXZxNWpT?=
 =?utf-8?B?STFpV3RXVGhMVWlnS1A0ZmluSVlMZ2pPQURWaE5GaXJYUVlzdi9pYWlFdys4?=
 =?utf-8?B?VktRYXpOUWJqbU9NcVBkSUQvcGdEU3RnWEt0bzNPaXkxZkxaSGpkZEl4T3JD?=
 =?utf-8?B?QlJSVlRoZnFUQWFWSlphNHkrVXZuTTVGRTQvSlhyUStGWGxXZkswQmVlblJx?=
 =?utf-8?B?K2FpVURpN3FqdmYveVdFWThDQ01nVGtQSTIxNVFWb1ZYSlV1ZkxkZVVObTNI?=
 =?utf-8?B?NmpFWGUyNG1JM1ErV1luY2xqWGpLelhPUG1naHp4c2JXVk1WaEhINXV3NFFj?=
 =?utf-8?B?aFk3bk1NR0lXc1ROWkVBL2lKU0kveWNvNk81MnQyZmROZ0tCRVB0aGtzODIy?=
 =?utf-8?B?MHRpY0xlNFRuTGNjNmQwVmN2QVhuS3dhSm1wdUU1aHB3Y2tidUF6d0NaQTdU?=
 =?utf-8?B?bDlQYmNlUWRnNERxNFBpNkgvaDdkWG1EL3JLbzg2Rm9TNThRckFOR3Y4TzlJ?=
 =?utf-8?B?VlRmNmVyeTR2VlJNWUs4V2ZBRG5Cb1ZwYlhZMml0dnEvMVdOZDZ4Z2d0U0RT?=
 =?utf-8?B?blJERjlDMUU5S2o1RDFpSEk0VzQvTklPRVZXSTdQYnBZVUdHd2ZaYlRDbTZs?=
 =?utf-8?B?bFhVVXlQR09Wa2gwTURDUkxRY3FnZ1lMM1hwVjlDQkk1WUc3WVZHUVhSNURH?=
 =?utf-8?B?MXI0K0FpdEhBaU1ENzZYeDhYUXJhVS9VM2R3WDh4d0hXbFNNUmRPeFkrb0Uy?=
 =?utf-8?B?eTh1d293MTkvNklCeGxUdkpKU3pJeG9UME1BaEFYZmpKQmQ3czVLb0hSZ3hl?=
 =?utf-8?B?OUtzUjBjZ0VWYW03MlBnRVJ1Z2tHcGs3b3RnOHg1OXVOU1lUQ2hOSUNBM05M?=
 =?utf-8?B?ODJjc0xaT0V4dndDRHByN3F1elhMNXBRVmZRK0F1UFplRkVJK3Fkb0hGME9P?=
 =?utf-8?B?aFhsM3RSTFNBUkxHVjdxZFlYRU5lTGpQRm5ILzEraVhZd256V1dKUUJnWnBH?=
 =?utf-8?B?WDdBSEt3emlYSTJCR2s5WnljMW5VNXc5UVloVU9ub0FydnE4Szd3MjNtelQx?=
 =?utf-8?B?dU51TE1mOS8xZ2cwMEFQL1U5dnNHVHBzNFY2VExGaXoybW1VTUVvcWhKOEI0?=
 =?utf-8?B?NkdIeW5VVnpNczFXQSsweThQUFNKLzYwd1hzdkdWV2czS0U4OUNyMmJpZlcz?=
 =?utf-8?B?NjczS0RVN1hZUmJzekYrVFNDK0laeS82SmlyVkNxYXJpazNhTG5yM3B2bi9l?=
 =?utf-8?B?ZjBtaUFwSWQzcTArQ1JZU2l3ZFVrdjY4MmZweU1BM3FuWjI4NW9OUElHbDhW?=
 =?utf-8?B?ZGI0RlJ1cUZYaDl1OWZoNUJoc2VUa1VwOVI2ZnE4VmJvbXhEVVpKZCt3OXhE?=
 =?utf-8?B?YTNTSDYzeXcxNDNFUC9pTkFHWm8xNTZsZ3RDRVpWUEpsRmFrUEZUYzAraDkz?=
 =?utf-8?Q?VI4EfZTBtJkCkh9CK5Lzj6YI9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AEDE4EA978A2F4EA0BFB719F8256715@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cfcd10-06a5-4c3b-2bd8-08dca5969739
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 12:55:38.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2+V+i2Wz9Z7NWt+MkFN9hDiDIm1trw9KsL/AI/DR/ZbUauo36Mp1eQgu7gGcZHmV20iwVN80wABne/eaYZ0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9897

QW0gMTUuMDcuMjQgdW0gMTk6NDcgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gMy4gdXRtaSBwaHkg
ZHJpdmVyIGFjY2VzcyBqdXN0IHRocmVlIHJlZ2lzdGVycyB1c2luZyBzeXNjb246IGFsbC1wb3J0
cw0KPiAgICBwb3dlci11cCAocHJvYmFibHkgZW5hYmxlcyBjbG9ja3MpLCBkZXZpY2UtbW9kZSBt
dXgsIHBlci1wb3J0IHBvd2VyLXVwLg0KPg0KPiAgICBBc3NpZ24gdGhlc2UgcmVnaXN0ZXJzIGlu
ZGl2aWR1YWxseSB0byB0aGUgcGh5IGRldmljZS1ub2RlLCBhbmQNCj4gICAgaW1wbGVtZW50IGFj
Y2VzcyBpbiBkcml2ZXIgd2hlbiBzeXNjb24gaXMgbm90IGF2YWlsYWJsZS4NCj4NCj4gICAgSWYg
dGhpcyBpcyBwcmVmZXJyZWQsIHdoaWNoIGR0IHByb3BlcnR5IHNob3VsZCBzW2VjaWZ5IHRoZWly
IGFkZHJlc3M/DQo+ICAgIHJlZywgcmFuZ2VzLCAuLi4/DQoNCkkgdGhpbmsgSSBoYXZlIG15IGFu
c3dlciwgd2l0aCByZWctbmFtZXMgaXQgc2VlbXMgbWFuYWdlYWJsZSAtDQpwbGVhc2Ugc2VlIHRo
ZSBleGFtcGxlIGJlbG93Og0KDQrCoMKgIMKgwqDCoMKgIMKgwqDCoCB1dG1pOiB1dG1pQGMwMDAw
IHsNCsKgwqAgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBjb21wYXRpYmxlID0gIm1hcnZlbGwsYXJt
YWRhLTM4MC11dG1pLXBoeSI7DQrCoMKgIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgcmVnID0gPDB4
YzAwMDAgMHg2MDAwPiwgPDB4MTg0MjAgND4sIDwweDE4NDQwIDEyPjsNCsKgwqAgwqDCoMKgwqAg
wqDCoMKgIMKgwqDCoCByZWctbmFtZXMgPSAidXRtaSIsICJ1c2ItY2ZnIiwgInV0bWktY2ZnIjsN
CsKgwqAgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCsKgwqAg
wqDCoMKgwqAgwqDCoMKgIMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsNCsKgwqAgwqDCoMKgwqAg
wqDCoMKgIMKgwqDCoCBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KDQrCoMKgIMKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgdXRtaTA6IHVzYi1waHlAMCB7DQrCoMKgIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIHJlZyA9IDwwPjsNCsKgwqAgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgI3Bo
eS1jZWxscyA9IDwwPjsNCsKgwqAgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCB9Ow0KDQrCoMKgIMKg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgdXRtaTE6IHVzYi1waHlAMSB7DQrCoMKgIMKgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIHJlZyA9IDwxPjsNCsKgwqAgwqDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgI3BoeS1jZWxscyA9IDwwPjsNCsKgwqAgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCB9
Ow0KDQrCoMKgIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgdXRtaTI6IHVzYi1waHlAMiB7DQrCoMKg
IMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIHJlZyA9IDwyPjsNCsKgwqAgwqDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgI3BoeS1jZWxscyA9IDwwPjsNCsKgwqAgwqDCoMKgwqAgwqDC
oMKgIMKgwqDCoCB9Ow0KwqDCoCDCoMKgwqDCoCDCoMKgwqAgfTsNCg0KSWYgcmVnaXN0ZXJzIG5h
bWVkICJ1c2ItY2ZnIiBhbmQgInV0bWktY2ZnIiBhcmUgZ2l2ZW4sIHRoZSBkcml2ZXIgY2FuIGJl
IGV4dGVuZGVkDQp0byBvcHRpb25hbGx5IHVzZSB0aG9zZS4NCg0KSSBoYXZlIHRlc3RlZCBvbiBh
cm1hZGEtMzg4LWNsZWFyZm9nLXBybywNCmFuZCB3aWxsIHNlbmQgYSB2MiBhZnRlciB0aWR5aW5n
IHVwIG15IGNoYW5nZXM6DQoNCi8qIFVTQi0yLjAgSG9zdCwgQ09OMyAtIG5lYXJlc3QgcG93ZXIg
Ki8NCiZ1c2IwIHsNCsKgwqAgwqBwaHlzID0gPCZ1dG1pMD47DQrCoMKgIMKgcGh5LW5hbWVzID0g
InV0bWkiOw0KwqDCoCDCoHN0YXR1cyA9ICJva2F5IjsNCn07DQoNCi8qIFVTQi0yLjAgSG9zdCwg
Q09OMiAtIG5lYXJlc3QgQ1BVICovDQomdXNiM18wIHsNCsKgwqAgwqBwaHlzID0gPCZ1dG1pMT47
DQrCoMKgIMKgcGh5LW5hbWVzID0gInV0bWkiOw0KwqDCoCDCoHN0YXR1cyA9ICJva2F5IjsNCn07
DQoNCi8qIFNSRFMgIzMgLSBVU0ItMi4wLzMuMCBIb3N0LCBUeXBlLUEgY29ubmVjdG9yICovDQom
dXNiM18xIHsNCsKgwqAgwqBwaHlzID0gPCZ1dG1pMj47DQrCoMKgIMKgcGh5LW5hbWVzID0gInV0
bWkiOw0KwqDCoCDCoHN0YXR1cyA9ICJva2F5IjsNCn07DQoNCiZ1dG1pIHsNCsKgwqAgwqBzdGF0
dXMgPSAib2theSI7DQp9Ow0KDQo=

