Return-Path: <linux-kernel+bounces-254428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD6933313
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA31C22123
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A15674D;
	Tue, 16 Jul 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="R/P3sups"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023087.outbound.protection.outlook.com [52.101.67.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60085208BA;
	Tue, 16 Jul 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163169; cv=fail; b=av/Hxow/ULsAtOKsGayYC6bPl72zGPnladKdfXY6VuCiEhHhtdyxDFpGKH9SlgW/1DQxe4i59rJrZk+weGMvp8fwqM6kcnYe6tV5n/RlkQcBMqKAbNP6j5wyAMu/W1ZML/FJX4tUunPzMxGAJvI8tyHfPHeSHCP46on6LwvMpEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163169; c=relaxed/simple;
	bh=VRXmsS5yGNmyZMHT/c7K20HHr3/BRyDhXruHL7zFUzM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=u7GhJgPHt3IUUfkDSnfev8EdsVJ+bcXuX1K6vQjfusP6eXqtYGr3ir0dXF9L10e/vCeTNvOtJLp53FjRnhv6FJkSmyNqKMTggfz8/rBk0r6h1xeSKFIiEZ2De7JwsRwLjS0AXevQaAhrmfx9Asvhn4jQWDhqtV47VEr/ZCBU1V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=R/P3sups; arc=fail smtp.client-ip=52.101.67.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAawBIotFEfftEWqRim4ogy2WQoqge9Gt+O6V1QxV5oQhGEVAaF4S4GEaVH7nnBTNMZR8Eqhrk0x0VOJr3vLZ8A9KddVGFU2vKDc86QlRuN4RRNp7QQrxAG6Xj+7vPUEfq0rS1O4Rq35ZNi+qpim9yGybBWGVxyeil/YLFDvoE6ue21MJNIbRpgZPqaA9YXRSXaeUF8T6w1Sq3WrHGZMuGRiqOgUYTCrwNGHsKGJvtBCtshZEHW9WWwz3YnAufOAR56AwXbU5oxmgmzo3G5LBH6yu1uj2RnwUuYYZqNvMoELawarnzWLaWGVlvi7zyqNokB3FmrglwD4iNZjSSfW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGg0eVqkNMHs/mp5O4euxl40i22630pU7gQgBdShYBc=;
 b=CdFeKoGBwARPkbMPlDD+juRiX/dBDcAyEyh3s1diMwoyr/J5Qxu78B3n14zVP5RzEwe7btxKZZo55E7sPe674i6rhNwfpyW3MuJuR5mbVNw4xayly4bGf3VTK0kFRWC3juFPEzsETShSuxViB+M2wpWwEP8x6ftDX2XeV0lz3qm4iLKSEGG6sAiWTKkd9f7UWyBOfteH90DIdWTHzyZ2gi2Hz3drnoL8zer89lSFcfUS3up88H+Ha81AU/GVn+1AwO+BiEHxFGgFlEoMjo93uLwRGhMYiShn5ukuq/Som8xd71u8HGt5HAi+LozlgVXRYT+GaiNFBMnM2Iz8CFB7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGg0eVqkNMHs/mp5O4euxl40i22630pU7gQgBdShYBc=;
 b=R/P3supsfkVfRDs3SNMeBX9TjgZQpHeLa+blY7DdzulOvr5Yf+kPoZ/4CfoTATBSN1dgQOv0empr2r/FWa684P3OUVt2DEfYTBhYiMTmdgzVYhZ9fjkhvVh1eWDAQVgvGmuye231Im+aoUxa7CYhPc2SAnQoihQDF3aVnvRYPvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 20:52:44 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:52:44 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 16 Jul 2024 22:52:37 +0200
Subject: [PATCH RFC v2 1/4] dt-bindings: phy: cp110-utmi-phy: add
 compatible string for armada-38x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-a38x-utmi-phy-v2-1-dae3a9c6ca3e@solid-run.com>
References: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
In-Reply-To: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaa2084-f805-4bac-b3bb-08dca5d93dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dCtuNmR5ZlYxK1dxZmNHK2ZpZWJrSTFPMjJrODE1LzlGenZxT0IxT011MkNx?=
 =?utf-8?B?VHhvbE1NcmRnRHlkQVdYWnhXWS9VN2VFa3I2bSsyVTlWNTVIcUxTZEVWL1hP?=
 =?utf-8?B?UUJ1dDk1RzRGZHdiUTVYaGdtOEtoK2NhaE1zZzdsQWpvZlhOK0hQSUx0Q3Q2?=
 =?utf-8?B?bzd4ZEo0QTlnckx6Z2xMV0EzUHdvRHNOZUtXSHpZbW1TTitORFVYa2t1dGUr?=
 =?utf-8?B?MVZjZ0VkQlpXa0VIcnlFaklhN25mcmVHalVITEk5SmpZWlhDOU5MVVlIZ1dD?=
 =?utf-8?B?aUVwenpWOFVlVWo5dVhTTkQzeDByMDY3VFhkSlcvMjQ4WDFGbkV1WXUrb29V?=
 =?utf-8?B?Tk1ZN2duenVKQU1lVW5UT3M4OTg4YzkzejNJQklZazdld2lDUFQ0Yy9GVXJM?=
 =?utf-8?B?NE80Y1h4RXRHY1VHd1VHTHhJcmYzMjJZMHJjN3hlVGp6UWdmSnNQRlBDNVFQ?=
 =?utf-8?B?L0RiTFdibk5IWmExUTdFK0tpUjg1alcwT3FWei9MSVh1SUhqQnZFWS9xU3VX?=
 =?utf-8?B?RUhSeXZxTlBucFdERjAvYzFQUXdjN0R6Um43TUF4U2VYazBiUFVjek0zeXU5?=
 =?utf-8?B?UjRyR0x1aGt2S29iVHVqanV0YlpYSzJabWtoZzVEVnZ6SHkzdUtYYVFqREgx?=
 =?utf-8?B?clduaTlCZzJRRWU3VzZURWZHSzFqMFlOSWRnYVpKVHh0d041RzByMDYzNTk3?=
 =?utf-8?B?Unc5dkllVnB1YzNObU5wZHRrMFI3Q3BYNXN0Q1hvMEoyMkVub1BibGNYMDE1?=
 =?utf-8?B?d1FnVG0weEg1U1RCZFh2MEhWR2pOTlN1VFpyNGhUVk9kZkxBTDZQd1R1R0Nx?=
 =?utf-8?B?c3g2eUV2dzBUSEJISGxwY053amIzTkIvckFuaWlMenU3WEtYc1dJTDd0TEZo?=
 =?utf-8?B?UzE4eVNUbVh3NGkyNFZpdTNwSHVJSDg0RHE3MndPSVdxdHRGa2NJMjdnZ3V4?=
 =?utf-8?B?Z2NQTmZmUDloUUVRcko5dExMT0sxeEhLU0FTMU5pdFVjaE5ObDlVSm04eEVB?=
 =?utf-8?B?UTZsQlZjWmdpd1JGRDNFVkNnKzcxbnhJVUtmVStlNHErUCtXZXRMd0hkN2Nx?=
 =?utf-8?B?YzRrNG5QOUNSNUkwWDJGKzBKbmFpS1BMQUs5b05XYjByNWpuam1WK3hmZEFi?=
 =?utf-8?B?T1BjVnhTWHU1bzNZVnYwSEFxZGtnamJRd25TSEpJMUhnNWlXeWQ4VzZUN0I3?=
 =?utf-8?B?S2NoWnkwcU5PY3UzdVlOYXA0VHNKejQxSjJYS21wYTZTRG1aMFNCcGk0VVM3?=
 =?utf-8?B?cTJIckQrWW9LekNjejE1RGY1bmswalNTbEU1NGlHMUlEOHJWUzBRZmVZVkY1?=
 =?utf-8?B?OFdodzErRXZiYkw1MVY2M1dadWhpNzBKK1NHcW1Va3ltc3VjbGJsaDRZMkVn?=
 =?utf-8?B?UXNIeTRwaVJLUUt0eFpqZ3BzeTkza3JOZ25zVHZSU3BFd1hjMkRBMlBNbjg2?=
 =?utf-8?B?Ui83Y0Z4Q2xseitadXdNRnRpV3Y4c2FoWWpzR1Z3QmExSytZQVNYeVdVeWxW?=
 =?utf-8?B?V2lxb1BDaVFweW0rR0VVY3FJYm9kcEkwYUcvMTZDSVhoUTYzL0FoY3pycit6?=
 =?utf-8?B?NnNLMVpvUGZBcXZ0Q0JaOW5wdUFwa0cyWGRwWTQ1ajJyVUlzMEtWQ1dhcEQx?=
 =?utf-8?B?SDdVdjZ4ejBPVWNRQmtEcUF4SzFjTTFOTWZhK2g5YkVMUXgxVE9ENDNiNGV2?=
 =?utf-8?B?M2FDdlhXdjNQRGFqeUVCUHBqS0hXOWltd3hZM1pKV3hna0dyN01la2tQSy9n?=
 =?utf-8?B?alR2UDFxVUFBVXh1NGZZdzhlbHdmdVdPK3A3UXYyYzl6WVFXMEtGMWFJT3BD?=
 =?utf-8?B?aGRXZjg4bjFPNWt0TEJRLzQrSGVDaXQ2L0FOeUMvMnZiNkljd3dkUHpqZEdm?=
 =?utf-8?B?Q2tGdVp0UXoyTWtYdFU5Y0VmVHZ5TFdLM25qVXU4bFJhNEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW9FUndnZ3hGQXZtZi9vU3RlNzcraHhLUXVLYjRndVROYk5oWjVieGEvOWdB?=
 =?utf-8?B?ZUplTCs4UFlIMFlzdzBFVlhlMXQza0gyVG9hc1VjUnVFRVRoSVQ1YTlmMzFB?=
 =?utf-8?B?dmxZc0Jaa083clVkVG1ieFB6RVpPZFhnbi9XV0QrYjkwY2E2V0xQTW9IMnMr?=
 =?utf-8?B?Q0NwSHl5RGFTZEJMT1I4cHRKRkxIaW5FTEVMWGZUeWM1OU9jR0pROFVVdnly?=
 =?utf-8?B?cDlhVE1YT3RKS1A2cm51cmZRb2FuMTB2Y0w2U3dHbFNGbWpnSkhDNUpqUWRq?=
 =?utf-8?B?RVpIOEJCL0N3OTF5aW1DS3IvSFcxMUxiQStRS0dVODlqRWZOTUtjWFRWMU9l?=
 =?utf-8?B?aDBvQXE5ODdhU2Fhc29PT21YVDl2Y0JOTXdNcGZaaHNmd3ZGc0IvbG9CWDJS?=
 =?utf-8?B?U2N2dm9DaGpQK0xEbHJWVU5scC8rbmRWdFFNRGM0L0Nmd240WmhGdTNjRGFs?=
 =?utf-8?B?SnFRbVlkWEFKZTY0R3RxTWJNZmpEMzJVUHFyNFBLRURnT3YyUTdhYzg1OTkv?=
 =?utf-8?B?QkFHSWkzSno5dmRUOXl1V1cwaEU5bWxubEE5K3FuSFo2M0R2cnZ3V3B2TFpa?=
 =?utf-8?B?WCs2dE8zYlc0NEtEcENJc01EZ2ppbm51T0xLcmlEWkxsZ3FmdE5IdkRIUGJs?=
 =?utf-8?B?QXlheUwwQVlmV010Q2RPcUI4N1QwNkc5OFhqNUFLYk1oWW00blRTYWFCVEV4?=
 =?utf-8?B?aDBLSTFpTUpOVWdYbnBVNzhqcjNFQjRXMGlTeXdMN2Q0dFpJOGQyTEpZNVZT?=
 =?utf-8?B?YUE2RDRrMjA2S05TVWFLWEhXanNLeTl2aUpDeEZDbXJseEJoMWh3ZTJYZEtS?=
 =?utf-8?B?NE9ya0lUR2x6ZU5xbXl1YTBJelpoaDA4K0lCWXJvSGR1Y2tUSTFLanlITnor?=
 =?utf-8?B?ZHVJeHJQd3ZyemtxaE54QllyZFZWMUlFZ0t6UzRDaXdzOHNuN0sxSW5xcDNS?=
 =?utf-8?B?SzV5UWNhQVUvTzVMc09WZ1JyVENPRmVmTlRGUTJCa0psbUVWVEJoY2lRa09D?=
 =?utf-8?B?UjJ4NWdqNW4yMW5mV05nWjZkdTJaQzlmNXM3QnpzM0tEK0NCc29DS0dmekhW?=
 =?utf-8?B?VWNLSlpwa1ZuYit5Tm8vTVJBeGtSMGdsYTBsRkMxK3FwS1JqU1lyeVBNSENG?=
 =?utf-8?B?M3dtZUFDdmdmeDBBVVBJTVhuK0VLNWR3dHRvbytybUsxa0dCTnliTGxhOEJs?=
 =?utf-8?B?R01nYjdZYmxPTnRSVUMwTCtGRWNQN2VvaDdNWG9oYXBrMEtINGg3bnBUR0d6?=
 =?utf-8?B?cjRzWHNvazVpdTFOTGRBTUIyejdDUSt1aHM4NmZUaENOTmdrdWF2d0YvN1h5?=
 =?utf-8?B?QkZqbmxkTDJDclU4NEpScEpLK2pHbGZZcm45SzQwUEFjVmYvbEJOU0h4YVJW?=
 =?utf-8?B?ZU9nRy9zR3hwUG5oNXBCWGZMRE1Jb2U1clFyTCszM1VVWXVvc3JWTjhuSEVI?=
 =?utf-8?B?UGtUNFBOcGFRRlRUV2ZUdHFrZE5xbFRhM1NmUVIxdHBacEJaclM5c3kvYU51?=
 =?utf-8?B?M05QZnBEbE1SZUFqaGxXOGp6YXVEdVNHS3RsSU9OZ3pGLyt0OVZRTStyK0x5?=
 =?utf-8?B?REl2SlVYRmJxa01GR0w5ak9CMFFwK3VpVHNGV3BQTGpNcG5INzZzeDJQeUg1?=
 =?utf-8?B?SzRoTFRFaDBZd1MvYkswR0V1ZkduMUdSaVh1TVNYNjd4MFBFUGVFeVlKNmRn?=
 =?utf-8?B?cG1nZ0hSdmxJcmY4MlhGL0ozdGVKV1o1UDJITWFndDJuM3c3ZGoyemRsc3Bz?=
 =?utf-8?B?ek9wUWxnUjE4UkFSWVNCMTRoSXRzbUNGR3IydGJnQzJtZzFnSktlRElZUldO?=
 =?utf-8?B?WGZERkdsUWJia2hWMTRhMnQ3ckU5UEtuaE50aTlYWS9xZEliMTZTZXBtcWo4?=
 =?utf-8?B?YjlKL0tOclFvTFV5MFluL0VYMmpud0ZLNjN3WTlGYU5ZQmsweHRYVlY2Y3BH?=
 =?utf-8?B?MHYxSmRJK2w3WGdGNTNDd0VJWjgyNlpMaHpIdzdOTnM0NFFRSlljZDdXRmFY?=
 =?utf-8?B?ZWtPb29yc3pCajB5WTVJZXAxQ0xtUFZ0RUlRUk1ZNnJKU3dURG1OOURQNUR1?=
 =?utf-8?B?c2tDalhLMjdUVjNmVldZb3AzVDJtWTBUTWMvR1AxSEdlV2YyWHZVYlpVb3F5?=
 =?utf-8?Q?qgaSziwG3IO1AkSCLcwGLsBo5?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaa2084-f805-4bac-b3bb-08dca5d93dc2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:52:44.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krnyEfCuHFf4bLedAJqJZkiRtvzwYliLQRvZlgQ32dzlAZ6CB4qTQlUV4a8Ic5tppHW2MBH8vghC0dsECXmZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907

Armada 38x USB-2.0 PHYs are similar to Armada 8K (CP110) and can be
supported by the same driver with small differences.

Add new compatible string for armada-38x variant of utmi phy.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../bindings/phy/marvell,armada-cp110-utmi-phy.yaml       | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
index 9ce7b4c6d208..b90bda10b779 100644
--- a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
@@ -25,10 +25,21 @@ description:
 
 properties:
   compatible:
-    const: marvell,cp110-utmi-phy
+    enum:
+      - marvell,a38x-utmi-phy
+      - marvell,cp110-utmi-phy
 
   reg:
-    maxItems: 1
+    items:
+      - description: UTMI registers
+      - description: USB config register
+      - description: UTMI config registers
+
+  reg-names:
+    items:
+      - const: utmi
+      - const: usb-cfg
+      - const: utmi-cfg
 
   "#address-cells":
     const: 1

-- 
2.35.3


