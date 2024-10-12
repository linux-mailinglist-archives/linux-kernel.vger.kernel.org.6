Return-Path: <linux-kernel+bounces-362107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B199B125
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAEBB2017A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72D136E21;
	Sat, 12 Oct 2024 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="QmyzZWt0"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823C10940;
	Sat, 12 Oct 2024 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728712227; cv=fail; b=kEuYY+wkndx4w4sc8LpoUo4uAh8tJl7xMLOkKf8BbRoYikYKLeRRrK46lt/rRpHQah0GevQZwOwCYTskm8YXPwW8Vwv3i/jnarUrxuTXuyM/oeZgPzlBjdD2w9GQFRhJMymlBGQvBtT0EElUHSTTqD0Z4SfKRNlDUQSsc98Qhxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728712227; c=relaxed/simple;
	bh=Rjam6Kkki/dDcmwhxVGYyGmQYrQ52a/t91IaT/KsElc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ITnlVcPwZyDUHSf4AAUBmlewjz2X5S4T8ImOSKYdF7IYl7mualZUJS1yZ4LTmdbNvJDXLaMLGd3D9zkgpXBlxsh1WQXWu6cv6AuUHL8Tth0EcI1Snn3pyYqUo2U8718LuTs26WLHqSyT1nbss2/BARH1XCeZs8/2USM+sJ14v1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=QmyzZWt0; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZmXq1bjt38AmuRfIGQ2PCI+IL6Z6xVvD6pbdpNQU0tIZfuaPnOJQeWbKdldGTEq+Guu0kFRCXKKHnVpyIsKp8uxdip7pEHv3iw5k+A5ICxGaX7f8lVRsX91PABA2Gj/MdnvqVvE5/Tz+unT4BinAlzgAYzw4DJ8Ru+K9ksgSG/09EcAszUksOZYgjZ5VjIB6lnbMRb5NXnSxunIQiGn8ugMfWDL5jsurH3/L4kSbMNHv86mUhiu+grla93OeOxNPlWd5T1WYN6o+33i58Qa6Ck1sR+pXZ3HGJ7/OKLIeetsYt9gowJlzjQqNySoQzLJ05KIKhBtQ1R5Nq7HvOFakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mUrH//sizOJiFhVfkQ9KEGadTZv6qfmo1vpBIruwqE=;
 b=qdurJPIChzfb4F568aC4JKUHP3ZxdV4/Fw0bxvlvnQEqpKWwHtQT6Z2HfVsf6pcOwCNKN4D57qJcLoAul3fyRQkG9Vr/O7Rn8ociEwoG2jTkdU+ah4MZcRqIgtXwzTsLTKo4apU7vS897A03EMNndZuT458Vwhu/E8vsISN9C27rabs9kQKtWwCidmyuxIdziPvezXzFWjILbQNeZydS68dj7VGyl1jelVvMPr9xnQX96E6aO4fXXpugpoqn5MXh/sSsSyBc9vApk7ULCI8a5nIvORa8wBP8ax/88AzGD555S4dOeEG6bKZ1yXu4zUH0/27/CwDezvZwaj7dUxebmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mUrH//sizOJiFhVfkQ9KEGadTZv6qfmo1vpBIruwqE=;
 b=QmyzZWt0W8qWemPpwBUbmFGdQoNfnd46YXOy5ZBa3taxYOZ3n6qh5SXYTbHxJ1eCL/CSchF9hdn35IhHUJ3So+2w0J9G3Wmlau9SRVt7H1uPZlHDr7B37HhiVEUgYzWCBjOUJIoR78Q0Ff+dz9SZiiptQaCDYmaOmzQa/lwvr7VwYhcxeDAaoas0P2JrCZn0p4qwqcURAYMjk+Ci4IJ8/8nL/5nUlvibXQnn/XtfExkwa70PqgJn4B5FX/qKHIkkBNDXCMVzZD4dh9cxDbVq6pbo3WNTIpHqUxPABcEz2QLw9BlWailb1Nj396zjpo9KDFQ+Q9hdfR0PtBh86l8iFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7915.apcprd03.prod.outlook.com (2603:1096:101:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 05:50:18 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 05:50:18 +0000
Message-ID: <5b1b4c2f-39ec-4631-acdf-15f0548101cb@amlogic.com>
Date: Sat, 12 Oct 2024 13:50:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] clk: meson: add A5 clock peripherals controller
 driver
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
 <20240914-a5-clk-v1-5-5ee2c4f1b08c@amlogic.com>
 <1jjzf1xf55.fsf@starbuckisacylon.baylibre.com>
 <4ce0c864-fd82-42f3-8122-7ff921b5cc8b@amlogic.com>
 <1jldz9tpja.fsf@starbuckisacylon.baylibre.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jldz9tpja.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f1fbb3-6633-4ed4-d0df-08dcea81c0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmsvRW1EY2VMWXdraWVBZlVOVVRKbkFGRDNKVXlZamdLMUh2NElMdm04ZDlu?=
 =?utf-8?B?OVA4QXNFQzJOVGdBQnFFRjF3dm9FVEhvWTdXdTRFbmZMbVRia2thWHdnUjIv?=
 =?utf-8?B?Zm4wclk2QXJJSkh5NGp2MXBHcFVWUjMwNVhoNVYrVjMydXJBWGI5SzJTSit4?=
 =?utf-8?B?TllPNkhVN1djVVoybTNwUjJ0dWc5Sjl5cTUyNHBvRG5BQTFxRWRyR2RPR2ZO?=
 =?utf-8?B?NjU2WS9xdGttUnlDbEpxYWJLSkhoRVR4RStQZE9BL2tUYWJyZHdXOXJrMmE1?=
 =?utf-8?B?TFNySERHRjdzQm01VjU4R0JCTTFSemdDUUJaem9aYWUwOG11UDhCaTgrdmZ3?=
 =?utf-8?B?UDZxRGt6VVFNVm42aTRrMllKY3VYQllWWkRWd1N0TDNxRnRINy9qWjVCOGZT?=
 =?utf-8?B?bC9sc2xVSVYvbmxJaVhBZVEyL1N4Ukw3b01wM29ONEt1REpRdU81Y2pCcWNB?=
 =?utf-8?B?T1VRTWdaMkdLK0k1RVNMMXFmL09zd0ZxaW1ndHpBR3ZBcktQenF6YUZvMnYz?=
 =?utf-8?B?bmk3dGVUMndPQUdmWXVoM2xxOEVMV1ZYVC93OURmUGgzeWs0RUhDVFFvVkpX?=
 =?utf-8?B?SlVncjdUby9RSmo3VGpqMkltcTB1Q2pRb3pINlluM2czTXRaOFF0OHR5dUVm?=
 =?utf-8?B?RGhEZEhkWFUyang4cTFjelhENDhVZCtHOG1wWFlPOUlXSy9nQjBTV3MzUE9K?=
 =?utf-8?B?eFpFOUpISVhZMERCc2tEclRTeGQ4bysyQmMySTJlaWxwYkZ2YUJXRU9XUzBx?=
 =?utf-8?B?YzZvTS9MTG11RFd5eTNObnd1ZVhhZlRrSXVCcmlkMU91UzRuZ254SlNlM1Aw?=
 =?utf-8?B?VEI5NXFwQjJ5R2J6KzQ2RGtvNkF2QzZJL2J0a283alRYM2RheEQrWkVUMW1o?=
 =?utf-8?B?MnBsSlJRY2VIVHJTdmd1VnhuNmpqZm9pcEVrM2FmczBqbnFsR1VEZ1RFb2Ry?=
 =?utf-8?B?Z3pEM1dyMHZNakxidDFXWG5uelQwSC9sZnJ5NkRRWE8vUmlzbThDRkNxelVR?=
 =?utf-8?B?Q0VqcGx4NFdkOXhZc0Q0VW5BL0tXbDFFYnVicEx3cTIrQlBNZ2NOOXNZY3VP?=
 =?utf-8?B?WkQ3SUNKdXdjaUlhd09QOGQxNFl1amMvMUgxc0hVSEszVHZSb3J0MWJJNWtS?=
 =?utf-8?B?WjNnOHJobmc2U2E5WDIyNm4xWDE5YXFZWTVTeDdHZGkyNjE3YVo1U1RxbCtv?=
 =?utf-8?B?WFBsZVFQb2pmNUxucHpHSk84YVNNVGppcmdmUTZIa3F2VC92VEo4WkVpRDJX?=
 =?utf-8?B?OER1bnFhSDVZczRxcUlFOHVLRTM3ZEo0Z3BwVmY2bW1qR21ZZ2dtM1JrRS9x?=
 =?utf-8?B?R0RZd3poWjkzNlQ1akFlRURoVUxmemVHZGxWYkYvTnJJQXorVlIxK3VqZ2Ix?=
 =?utf-8?B?VmJlSTk3dkswM1lhWTEvaEFLWExoaGtwZDViOFJKQmxNMCthcHdBaW42d1Aw?=
 =?utf-8?B?bXZGc2paZTBBS2Q0U3hJYXQ4Rmt6RXZhRW50SGJYSGNNYlhQSFVHVXpqb0dR?=
 =?utf-8?B?eUxLZTNnU3I0b2ZGR1gxV212VHhBcWY4TmZhYVNETjFFU1dJS1dmMUg4eU8x?=
 =?utf-8?B?ZXc5VnNxRk80eFgyN3BxSm9JQkI1QjRBZEJzSmp3YmJPTHlBZkRVbEIwcGZF?=
 =?utf-8?B?U0dwUlczZTF6YVllYlhWS29JWnU4empKUUtpUFAvMUhtbTJrcVRlOFJNdUNU?=
 =?utf-8?B?dTk1elp5NjhTWTNMTWdjNWwxNTBybG5uR1ZXNWowUm5ZdHpHSzNlbjNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFNKUjJoVWcrcm01Tnp6aDFQbkVPSjJHN1BRZDJvQjNDMkg2bEtNbHVJQUN2?=
 =?utf-8?B?b1Fyb0hzMmtraStoV1phemNTYUxycVRQbEordmt3Z1FrUkZLb0tMRFNUMDRh?=
 =?utf-8?B?ZlNIekdpVGpmb3JZZk84b00vbjFrOGpMblY2TFIwZkEwT25aYW5VN09zYXVB?=
 =?utf-8?B?R2tGMmxPV3p1Z0lMMzZZdU1OTVFGRitIT1VPRE9QZlZrKzVnc2R5Qnhsd1BS?=
 =?utf-8?B?dmpKcWlmM0JnUU9UL0ZjekVpNXlpOWxuYkFOTXB2ZGcxMW15QTBKeXp4Slp1?=
 =?utf-8?B?ekx4YnZJdjVxVjQyV0FzNS9lRCtIQWVGM1lGaVNKU3lYTUlUV1lrcGlyamU5?=
 =?utf-8?B?bXU5UEkzUzRNL0V5Z3lsYWI5Z0ZqdlZvMzROdzhwRTNmR3ZHOGV4WEV3Q0Fa?=
 =?utf-8?B?Q0MwU3ZYVnUrWmovZjE2WkwrMXErSTU0WnhzR1RTUHdJS1NsZFczWjF2OExS?=
 =?utf-8?B?WE95di9ldzRTdlZ2VS80MkFuY2plbGtCeWtGYjZoZ3FOamxYeGE0WHZTSzZx?=
 =?utf-8?B?NFpGSFBhOWlESVg5S3EwcmpiazRvZlEvTmFyeWxENE1vcHdWbkxQZXBDRjVz?=
 =?utf-8?B?NCtkbmo3SlFXTzNiYjdocTNnY1RJSVh5STlTVytMTlY4TGRiL2U0eVlNMHIv?=
 =?utf-8?B?cXZGM0hhYURRaTY2K3dTV2FESlpKYll0LzRyeWQvLzRYMHNMWFFoU3hxSVhn?=
 =?utf-8?B?R0lRbmZvUitLVDFLUGhEOW5RakZwVVJ0UnJzNzRweTYvdG04SzJIVmxMamNN?=
 =?utf-8?B?T1RLc3A3REZnTkV6d2ZabHM5OXExMVRsdWE5a2JKRHFEL0RQZ0doZ2RXVTlF?=
 =?utf-8?B?V2VNS1cyNVlBcCtxWHVyT1FIMm9rS0tDSnRCdTA4OVFIU2hON1VrK3VQbm5r?=
 =?utf-8?B?bkd2OU5Gd0hzd0t3L1VEQysvb2MyTjNsZVhzU3RLOGV6dWZKZ3lFU3ZTVW13?=
 =?utf-8?B?NUlGSEViNSt0Zkp1QW9pejNFS3gweDZUdGtCU2NzMkh5YTlnUWFkaU5kcTE3?=
 =?utf-8?B?eTNnY0JmVThSN2FUOTZmeXRKaGhndDQyWEYzdWhHcC8xZWNqcGRtT1RZdHVn?=
 =?utf-8?B?WW5ISnlxLzVxYi91RExscEhGU1ZyVEc0VlVyS2JQS3lIem45QzBRb1V3M2Vo?=
 =?utf-8?B?SnQ2SmNjeWJoTEJwT1gzWXNwU3VhTVJEdG1QMjR1MEhqbzVlWlBobnQ3dVdW?=
 =?utf-8?B?c2UwL29MNnN3UUl0V2ZKUS93S0VWaGVycVIybkM4SUN6ZTlIbkttZUxYL0hV?=
 =?utf-8?B?b1o3Z2Q4NVBaQUFvY2J2UWRTTTUwU0FUMHFha0xQcXM0MXhVVzlQQUwrWDdr?=
 =?utf-8?B?TmNISmJyN3hSVzhqa1l2WTA2UzlCNTlKVVpqK1FsWWg1T2lQRUsxMy81RVpE?=
 =?utf-8?B?TDFwR2RPdXFjWjN3MGQyRFVlWkF6clVnc2ZIbENCelFUd0FPMFJ2WFVUK05v?=
 =?utf-8?B?OXV6S0Nab1ZTYlVTVERCRHZCM2xzMmE5T0tQU1VnK3pockJERjdZNFhVMVVi?=
 =?utf-8?B?L0NycXFObTB6dmxsNklESWVzTVh3UGY5c3lUL2N5R0lNWlBxcW5MZHZFOHl0?=
 =?utf-8?B?NTZBeUEzL2xMcFR1UlZmK1hJWnVkem5xbnl5V1hISWE3MVRxUmR4UjZIdkNR?=
 =?utf-8?B?V3VYMlB6Qi9FNUIrR0xtQ0c0UjVMcUVKS2creHNRVkQvUkJCUWx6bW9Pd203?=
 =?utf-8?B?YXJpQ0svbUVQaExEUWRDZ05Yb0RlNmRYdk5lbUJmekxJS1c0dEVRQnVuYnpY?=
 =?utf-8?B?eGRWVzBNaWZkUWFxT2dCeEhNbTlGVjBIN1JpYWt3YXE0anFUYnptdG5rMmp4?=
 =?utf-8?B?VVpHWTZoY1B0T3dNR3ZTY1dKVytSQzB1bk9rczhrcjFOM3YzQ01KcHFHeldT?=
 =?utf-8?B?bEhTc0xxWE1iZUduYTA0OS80TDgzQVRDKytSTUY1cWNuM21CYVF1L2tjMVpi?=
 =?utf-8?B?b01vUG1vR2prV3RwVy9JYUtKdG1IRlErbFFtV0lzWDRBN1RJS2JEMUphRTBo?=
 =?utf-8?B?TGF1RlBmVXo1SkNEV3dOR3dFU0FFd3dHVEVNVjgyVXBQeTBsZnhOU3lLODhW?=
 =?utf-8?B?MEVkTnA0dGIxMktJMm9UV1hiVndURWM5dmZiWTJaQ1NUYkVsY0pZOCs1c3pt?=
 =?utf-8?B?bnN6bThURmVTVXpuL2NZMkxETitWTlhzY2xydnlqMlhuamxQamdGMXRGL2E2?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f1fbb3-6633-4ed4-d0df-08dcea81c0c1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 05:50:18.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYsTnG0cvBWk49DiZtA/b7+8NdOhUPxffUct4j4XEJz+JPTYHpJxItx5UU0SuqvTsvTcBdcf1dZ53uvnDQoRLLWULsmyDPrE7vACWRV/Y+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7915

Hi Jerome,
     Thanks for your reply.

On 2024/9/30 18:16, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Sun 29 Sep 2024 at 16:44, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
> [...]
> 
>>>> +static A4_SYS_GATE(sys_eth_mac,              CLKCTRL_SYS_CLK_EN0_REG0, 26, 0);
>>>> +
>>>> +/*
>>>> + * FIXME: sys_gic provides the clock for GIC(Generic Interrupt Controller).
>>>> + * After clock is disabled, The GIC cannot work properly. At present, the driver
>>>> + * used by our GIC is the public driver in kernel, and there is no management
>>>> + * clock in the driver.
>>>> + */
>>>> +static A4_SYS_GATE(sys_gic,          CLKCTRL_SYS_CLK_EN0_REG0, 27, CLK_IS_CRITICAL);
>>> The GIC has a driver. If it needs clock, maybe it should request it and
>>> enable it, maybe as optional.
>>>
>>
>> This has been explained in C3. GIC is a public driver that does not
>> reference clock, so you suggest setting it as CRITICAL and adding the
>> "FIXME" annotation.
> 
> Yes indeed ... and at some point, it is expected something will be done
> a actually fix the situation ... not just pile-up FIXME comments.
> 
> Adding a clock to a driver that should have one seems doable.
> 
>>
>>>> +static A4_SYS_GATE(sys_rama,         CLKCTRL_SYS_CLK_EN0_REG0, 28, 0);
>>>> +
>>>> +/*
>>>> + * NOTE: sys_big_nic provides the clock to the control bus of the NIC(Network
>>>> + * Interface Controller) between multiple devices(CPU, DDR, RAM, ROM, GIC,
>>>> + * SPIFC, CAPU, JTAG, EMMC, SDIO, sec_top, USB, Audio, ETH, SPICC) in the
>>>> + * system. After clock is disabled, The NIC cannot work.
>>>> + */
>>> This comment looks like a clock that should be passed as ressource to a
>>> bus or power-domain to be properly manage. This is a pattern that keeps
>>> on repeating. I will not block you on it this time around but I strong
>>> suggest you fix up the situation on the related platform. Next time
>>> around, the reason won't be a valid one.
>>>
>>
>> There are too many modules associated with this clock... The most important
>> is the inclusion of some system-level modules that are not managed by the
>> driver in the kernel and cannot close their clocks, perhaps it is not
>> appropriate to describe it here.
>>
>> In the next version I moved it to scmi-clk for management?
> 
> No. The number of module associated with a clock should not be a
> concern and SCMI should not be a 'Hide all the things I don't want to do
> in linux things'.
> 
> You've got a bus that needs a clocks. There are possibilities associate
> a clock with bus in DT, either directly or through power-domains. Please
> do it correctly.
> 

I also wanted to process these key clocks in scmi-clk for the following 
reasons:

1 These clocks seriously affect system security and stability, and are 
managed in the security environment (BL31). Under bl31 we will add 
additional judgment logic to these clocks: If the kernel is in the 
runtime stage, critical sys_clk/axi_clk such as GIC/NIC/CPU_DMC are not 
allowed to disable (these clocks can be closed during deep sleep, 
because the aocpu is always alive to receive and process interrupts 
normally), this can also prevent attacks.

2 Register permissions corresponding to sys_clk/axi_clk can be 
configured in the TEE environment. After configuration, the clock cannot 
be disabled by writing registers in the REE environment.

3 This driver is used to manage clocks related to general peripherals. 
Clocks that affect system security are handled in the security 
environment through scmi-clk.

>>
>>>> +static A4_SYS_GATE(sys_big_nic,              CLKCTRL_SYS_CLK_EN0_REG0, 29, CLK_IS_CRITICAL);
>>>> +static A4_SYS_GATE(sys_ramb,         CLKCTRL_SYS_CLK_EN0_REG0, 30, 0);
>>>> +static A4_SYS_GATE(sys_audio_top,    CLKCTRL_SYS_CLK_EN0_REG1, 0, 0);
>>>> +static A4_SYS_GATE(sys_audio_vad,    CLKCTRL_SYS_CLK_EN0_REG1, 1, 0);
>>>> +static A4_SYS_GATE(sys_usb,          CLKCTRL_SYS_CLK_EN0_REG1, 2, 0);
>>>> +static A4_SYS_GATE(sys_sd_emmc_a,    CLKCTRL_SYS_CLK_EN0_REG1, 3, 0);
>>>> +static A4_SYS_GATE(sys_sd_emmc_c,    CLKCTRL_SYS_CLK_EN0_REG1, 4, 0);
>>>> +static A4_SYS_GATE(sys_pwm_ab,               CLKCTRL_SYS_CLK_EN0_REG1, 5, 0);
>>>> +static A4_SYS_GATE(sys_pwm_cd,               CLKCTRL_SYS_CLK_EN0_REG1, 6, 0);
>>>> +static A4_SYS_GATE(sys_pwm_ef,               CLKCTRL_SYS_CLK_EN0_REG1, 7, 0);
>>>> +static A4_SYS_GATE(sys_pwm_gh,               CLKCTRL_SYS_CLK_EN0_REG1, 8, 0);
>>>> +static A4_SYS_GATE(sys_spicc_1,              CLKCTRL_SYS_CLK_EN0_REG1, 9, 0);
>>>> +static A4_SYS_GATE(sys_spicc_0,              CLKCTRL_SYS_CLK_EN0_REG1, 10, 0);
>>>> +static A4_SYS_GATE(sys_uart_a,               CLKCTRL_SYS_CLK_EN0_REG1, 11, 0);
>>>> +static A4_SYS_GATE(sys_uart_b,               CLKCTRL_SYS_CLK_EN0_REG1, 12, 0);
>>>> +static A4_SYS_GATE(sys_uart_c,               CLKCTRL_SYS_CLK_EN0_REG1, 13, 0);
>>>> +static A4_SYS_GATE(sys_uart_d,               CLKCTRL_SYS_CLK_EN0_REG1, 14, 0);
>>>> +static A4_SYS_GATE(sys_uart_e,               CLKCTRL_SYS_CLK_EN0_REG1, 15, 0);
>>>> +static A4_SYS_GATE(sys_i2c_m_a,              CLKCTRL_SYS_CLK_EN0_REG1, 16, 0);
>>>> +static A4_SYS_GATE(sys_i2c_m_b,              CLKCTRL_SYS_CLK_EN0_REG1, 17, 0);
>>>> +static A4_SYS_GATE(sys_i2c_m_c,              CLKCTRL_SYS_CLK_EN0_REG1, 18, 0);
>>>> +static A4_SYS_GATE(sys_i2c_m_d,              CLKCTRL_SYS_CLK_EN0_REG1, 19, 0);
>>>> +static A4_SYS_GATE(sys_rtc,          CLKCTRL_SYS_CLK_EN0_REG1, 21, 0);
>>>> +
>>>> +#define A4_AXI_GATE(_name, _reg, _bit, _flags)                               \
>>>> +     A4_CLK_GATE(_name, _reg, _bit, axiclk,                          \
>>>> +                 &clk_regmap_gate_ops, _flags)
>>>> +
>>>> +static A4_AXI_GATE(axi_audio_vad,    CLKCTRL_AXI_CLK_EN0, 0, 0);
>>>> +static A4_AXI_GATE(axi_audio_top,    CLKCTRL_AXI_CLK_EN0, 1, 0);
>>>> +
>>>> +/*
>>>> + * NOTE: axi_sys_nic provides the clock to the AXI bus of the system NIC. After
>>>> + * clock is disabled, The NIC cannot work.
>>>> + */
>>>> +static A4_AXI_GATE(axi_sys_nic,              CLKCTRL_AXI_CLK_EN0, 2, CLK_IS_CRITICAL);
>>>> +static A4_AXI_GATE(axi_ramb,         CLKCTRL_AXI_CLK_EN0, 5, 0);
>>>> +static A4_AXI_GATE(axi_rama,         CLKCTRL_AXI_CLK_EN0, 6, 0);
>>>> +
>>>> +/*
>>>> + * NOTE: axi_cpu_dmc provides the clock to the AXI bus where the CPU accesses
>>>> + * the DDR. After clock is disabled, The CPU will not have access to the DDR.
>>>> + */
>>>> +static A4_AXI_GATE(axi_cpu_dmc,              CLKCTRL_AXI_CLK_EN0, 7, CLK_IS_CRITICAL);
>>>> +static A4_AXI_GATE(axi_nna,          CLKCTRL_AXI_CLK_EN0, 12, 0);
>>>> +
>>>> +/*
>>>> + * NOTE: axi_dev1_dmc provides the clock for the peripherals(EMMC, SDIO,
>>>> + * sec_top, USB, Audio) to access the AXI bus of the DDR.
>>>> + */
>>> Same.
>>>
>>
>> These normal peripheral drivers manage the clock without a problem.
>>
>>>> +static A4_AXI_GATE(axi_dev1_dmc,     CLKCTRL_AXI_CLK_EN0, 13, 0);
>>>> +
>>>> +/*
>>>> + * NOTE: axi_dev0_dmc provides the clock for the peripherals(ETH and SPICC)
>>>> + * to access the AXI bus of the DDR.
>>>> + */
>>>> +static A4_AXI_GATE(axi_dev0_dmc,     CLKCTRL_AXI_CLK_EN0, 14, 0);
>>>> +static A4_AXI_GATE(axi_dsp_dmc,              CLKCTRL_AXI_CLK_EN0, 15, 0);
>>>> +
>>>> +static struct clk_regmap clk_12_24m_in = {
>>>> +     .data = &(struct clk_regmap_gate_data) {
>>>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>>>> +             .bit_idx = 11,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "clk_12_24m_in",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_data = &(const struct clk_parent_data) {
>>>> +                     .fw_name = "xtal_24m",
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap clk_12_24m = {
>>>> +     .data = &(struct clk_regmap_div_data) {
>>>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>>>> +             .shift = 10,
>>>> +             .width = 1,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "clk_12_24m",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &clk_12_24m_in.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +/* FIXME: set value 0 will div by 2 like value 1 */
>>> Again, it is fine when it happens once, like the c3.
>>> When the pattern starts repeating, it is time to do something about it.
>>>
>>
>> The corresponding suggestions have been made to the hardware designer, but
>> now the designed chip cannot be repaired.
> 
> Not asking to fix the HW (although that would be nice if you could)
> The HW is what it is. The SW needs fixing. That you can do.
> 
>>
>>>> +static struct clk_regmap fclk_25m_div = {
>>>> +     .data = &(struct clk_regmap_div_data) {
>>>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>>>> +             .shift = 0,
>>>> +             .width = 8,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_25m_div",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_data = &(const struct clk_parent_data) {
>>>> +                     .fw_name = "fix",
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap fclk_25m = {
>>>> +     .data = &(struct clk_regmap_gate_data) {
>>>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>>>> +             .bit_idx = 12,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_25m",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fclk_25m_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +/*
>>>> + * Channel 3(ddr_dpll_pt_clk) is manged by the DDR module; channel 12(cts_msr_clk)
>>>> + * is manged by clock measures module. Their hardware are out of clock tree.
>>> Yet, they exist and should be part of the bindings since they are
>>> obviously input to this clock.
>>>
>>
>> Will add it to bindings, as optional input clock source.
>>
>>>> + * Channel 4 5 8 9 10 11 13 14 15 16 18 are not connected.
>>>> + *
>>>> + * gp1 is designed for DSU (DynamIQ Shared Unit) alone. It cannot be changed
>>>> + * arbitrarily. gp1 is read-only in the kernel and is only open for debug purposes.
>>>> + */
>>>> +static u32 gen_parent_table[] = { 0, 1, 2, 6, 7, 17, 19, 20, 21, 22, 23, 24, 25,
>>>> +                               26, 27, 28};
>>>> +
>>>> +static const struct clk_parent_data gen_parent_data[] = {
>>>> +     { .fw_name = "oscin" },
>>>> +     { .hw = &rtc_clk.hw },
>>>> +     { .fw_name = "sysplldiv16" },
>>>> +     { .fw_name = "gp1" },
>>>> +     { .fw_name = "hifi" },
>>>> +     { .fw_name = "cpudiv16" },
>>>> +     { .fw_name = "fdiv2" },
>>>> +     { .fw_name = "fdiv2p5" },
>>>> +     { .fw_name = "fdiv3" },
>>>> +     { .fw_name = "fdiv4" },
>>>> +     { .fw_name = "fdiv5" },
>>>> +     { .fw_name = "fdiv7" },
>>>> +     { .fw_name = "mpll0" },
>>>> +     { .fw_name = "mpll1" },
>>>> +     { .fw_name = "mpll2" },
>>>> +     { .fw_name = "mpll3" }
>>>> +};
> 
> [...]
> 
>>>> +
>>>> +static struct clk_regmap pwm_h_sel =
>>>> +     AML_PWM_CLK_MUX(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 25);
>>>> +static struct clk_regmap pwm_h_div =
>>>> +     AML_PWM_CLK_DIV(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 16);
>>>> +static struct clk_regmap pwm_h =
>>>> +     AML_PWM_CLK_GATE(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 24);
>>>> +
>>>> +/* Channel 7 is gp1. */
>>> and ? if GP1 is RO, why can't you add it here ?
>>>
>>
>> gp1_pll is a special clock for DSU, it is integrated into dsu_clk, we
>> don't want other modules to reference it.
>>
>> My understanding is that gp1_pll should not be provided to the peripheral
>> clock tree, perhaps this is a redundant design.
> 
> Then /* Channel 7 is gp1 which is reserved for DSU */
> 
> Note that if GP1 is actually RO and DSU does not change the rate at
> runtime through other means, then listing GP1 here should not be a
> problem, spi would just be user of an available PLL.
> 

cpufreq(DVFS) driver will still dynamically adjust the frequency of gp1 
after running, but I configured gp1 as RO under bl31, and it is risky to 
open it to other peripheral modules.

For example, when the frequency of spicc is set, the frequency of gp1 is 
just enough to meet the requirements of spicc. At this time, spicc will 
switch to gp1. Later, when the cpufreq driver dynamically sets the 
frequency of gp1, it will be a disaster for spicc.... This may also 
happen in the future with peripherals that support hifi_pll (audio 
adaptation sampling rate and synchronization with video may dynamically 
adjust the hifipll frequency).

>>
>>>> +static const struct clk_parent_data spicc_parent_data[] = {
>>>> +     { .fw_name = "oscin" },
>>>> +     { .fw_name = "sysclk" },
>>>> +     { .fw_name = "fdiv4" },
>>>> +     { .fw_name = "fdiv3" },
>>>> +     { .fw_name = "fdiv2" },
>>>> +     { .fw_name = "fdiv5" },
>>>> +     { .fw_name = "fdiv7" }
>>>> +};
>>>> +
>>>> +static struct clk_regmap spicc_0_sel = {
>>>> +     .data = &(struct clk_regmap_mux_data) {
>>>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>>>> +             .mask = 0x7,
>>>> +             .shift = 7,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "spicc_0_sel",
>>>> +             .ops = &clk_regmap_mux_ops,
>>>> +             .parent_data = spicc_parent_data,
>>>> +             .num_parents = ARRAY_SIZE(spicc_parent_data),
>>>> +     },
>>>> +};
> 
> [...]
> 
>>>> +
>>>> +static struct clk_regmap dspa_1 = {
>>>> +     .data = &(struct clk_regmap_gate_data) {
>>>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>>>> +             .bit_idx = 29,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "dspa_1",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &dspa_1_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>>> A word about SET_RATE_GATE ?
>>>
>>
>> Look at the response to one of the questions below.
> 
> Still a word ? your comment below does justify this flag clearly.
> 

CLK_SET_RATE_GATE is to enable glitch free mux to perform ping-pong 
switching.

>>
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap dspa = {
>>>> +     .data = &(struct clk_regmap_mux_data){
>>>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>>>> +             .mask = 0x1,
>>>> +             .shift = 15,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "dspa",
>>>> +             .ops = &clk_regmap_mux_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &dspa_0.hw,
>>>> +                     &dspa_1.hw
>>>> +             },
>>>> +             .num_parents = 2,
>>>> +             /*
>>>> +              * NOTE: This level of mux is "no glitch mux", and mux_0
>>>> +              * (here dspa_0) is not only the clock source for mux, but also
>>>> +              * provides a working clock for "no glitch mux". "no glitch mux"
>>>> +              * can be switched only when mux_0 has a clock input. Therefore,
>>>> +              * add flag CLK_OPS_PARENT_ENABLE to ensure that mux_0 has clock
>>>> +              * when "no glitch mux" works.
>>>> +              */
>>>> +             .flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>>> Humm CLK_OPS_PARENT_ENABLE is not how we have handling glitch free mux
>>> so far. What changed ?
>>>
>>
>> This is a hidden problem we have discovered in recent years, the previous
>> chip use is ping-pong switching "no-glitch-mux/glitch free" have this
>> problem. If mux_0 does not have a clock "no-glitch-mux", it will not be
>> able to switch channels, and I will organize and submit patch to fix it
>> later.
> 
> The NOTE comment and what the code does are not aligned.
> * Your comment says that input #0 must be enabled for the mux to work
> * The flag ensure that parent is enabled before switching to it. There
>    is nothing specific about input #0
> 

This has been explained in another patch. Configuring 
CLK_OPS_PARENT_ENABLE can ensure that both channel 0 and channel 1 are 
enabled during mux switching. In fact, we only need to ensure that 
channel 0 is enabled.

>>
>>>> +     },
>>>> +};
>>>> +
>>>> +/* Channel 6 is gp1. */
>>>> +static u32 nna_parent_table[] = { 0, 1, 2, 3, 4, 5, 7};
>>>> +
>>>> +static const struct clk_parent_data nna_parent_data[] = {
>>>> +     { .fw_name = "oscin" },
>>>> +     { .fw_name = "fdiv2p5" },
>>>> +     { .fw_name = "fdiv4" },
>>>> +     { .fw_name = "fdiv3" },
>>>> +     { .fw_name = "fdiv5" },
>>>> +     { .fw_name = "fdiv2" },
>>>> +     { .fw_name = "hifi" }
>>>> +};
> 

