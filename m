Return-Path: <linux-kernel+bounces-405579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1869C5324
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71438B31201
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA802123FC;
	Tue, 12 Nov 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="N+3f/Sbs"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2135.outbound.protection.outlook.com [40.107.215.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9C20EA2D;
	Tue, 12 Nov 2024 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406647; cv=fail; b=jR8FNCPN4aXfzQQJF79XyPq74eqXiLZcDCNxbVg0AO4LzPvnUGaBmrk6XGoXDOmq/SUXVXPAO45+1SruPS6oZOEwBQRdikFc4U+2RpHzqI+eYkHZFuD7RmYhcu7j1DRCzrqHcZiRCcq9op3sVv+oi+8G+bw1Qs75e6T2CQDrAQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406647; c=relaxed/simple;
	bh=CnaBf+fZEg6YZKDNJ88dfjH03Qaflsg+oeV/9pQmGnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SKQgJVqI7BbdrQD5nlsu/sWQ3kM4ddyz6MB7j73NJxqjYsMuopv7mCs52CoU7MNcJYViu2+QGdcaxIkPhD7K41EeMaqCKgHU3a0wDZzWvzIy0hrUteKu5OsDb1zE6R7mE8+nZJlfl7wRdv+tNydU5jRPYlOYi2xsEhSJjgsuJlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=N+3f/Sbs; arc=fail smtp.client-ip=40.107.215.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW/dkvmSxxQquVFt9qX9cIgKibujcSsAvTMD+qc61Lc9dEkF8LPU+SSKwchdwJeAd80+u91qwxsfpLJ2nUInWHuhrAIh7IZaqe+W5b7mC3PY56oOU9F1ceghfuhJGIhIqoY39/sKRp8z7A5Rr8saxPerPiM4x7V39aZA8uXl6uU5UR0hmmklDh4RWgMTwtva8AC831KunDHFwkk9hMh876P7o0CAS0iwNhen5nttdwQ1V2kzOZZRCU7jBRm2Wtsanb9UN5qaZ4Ly5Fo3JaACnj7TgJr7JSYe3FvxJuqOKI0utKqSztzS+uoc9hF8S0JxlqJil9KIcpQMw6tMy03lEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlpYBojbHJHPbG3DwycboMAbXpRXbaZ47cWYZml1k0g=;
 b=EQdloAGfwmOtrAYEmWdQdZEOxlT3tUpFzRvcM79SP2yrD5VE05hEqvNnUQy2jXW7fEJhGdcst8SKXL8m2nP3i8hWvWll2A844/tow/hHECw6si6YS4a6T7lUU3wEXnHLynm4lR/nCfzlRL38aACX02oahDDOOk58cQr+cnxeAAsCex0Lj1eJUFi65YlX0sqw2u3gwXr5Rfsff/IWyzTFhyiuwjwu+1nvkMsqL83oidI9r89+Dy8ws5rJ0XSYY85b8IskqfCvgVCtvmQOFsxd3I/Lv4ds3/PWg0CTrbIe49v+aTtPtvdLgkA7PIZwfEs0ma+Wfb5E778eCKfmiDCVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlpYBojbHJHPbG3DwycboMAbXpRXbaZ47cWYZml1k0g=;
 b=N+3f/SbsJNvdJuCAnFaPU8z5gzxdkA/fKxNJzCDSl1UmOLQANTrn6QIuyCH7i4wzF4a7fUa4wX4sYEP2CjjKEt49BMzNJedooTq2YkofwYKenPPrDvuLcai1C/A+YfXAKsM23yhKtiHQssYhEy221u6/GRFyWOQeQ6CuFQUSvFKqoce6cHAiE+rd5emOSJ/p8eie3bJj7PsEso557gM/6U8BSnoCBjEtUfDdxVPpC9cOtd537W4/0MEtnCee5rk3feNDszqrIL6a/UBhFUJxPCsfSclvSePZsKc3KPrdjPt0+YC4JNR7xPATnP+jNhdaT8eVaWBO9tbnRROMvur9SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SI2PR03MB5786.apcprd03.prod.outlook.com (2603:1096:4:150::10)
 by TYZPR03MB8587.apcprd03.prod.outlook.com (2603:1096:405:b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 10:17:20 +0000
Received: from SI2PR03MB5786.apcprd03.prod.outlook.com
 ([fe80::3f37:cacc:420b:9b86]) by SI2PR03MB5786.apcprd03.prod.outlook.com
 ([fe80::3f37:cacc:420b:9b86%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 10:17:20 +0000
Message-ID: <e13bc132-fc90-4378-852b-1ff45a6872b9@amlogic.com>
Date: Tue, 12 Nov 2024 18:16:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: meson: Fix children of ro_clk may be tampered with
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jian Hu <jian.hu@amlogic.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Yu Tu <yu.tu@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241111-fix_childclk_of_roclk_has_been_tampered_with-v1-1-f8c1b6ffdcb0@amlogic.com>
 <1jr07g25da.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jr07g25da.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To SI2PR03MB5786.apcprd03.prod.outlook.com
 (2603:1096:4:150::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5786:EE_|TYZPR03MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 15370f9e-63ef-41b4-5150-08dd03033133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG1Fa0NZTXFQVVdEd2Z1cFpkRlVZL0JPbnNEdFJ5ZHZBN3JyYy9ERFZEejdq?=
 =?utf-8?B?ajhJMXZ4cjVITlpxRm9XLy9ZMXVDR0NSZlVPbnBBRE05N1VEUmFuU1l1YXpD?=
 =?utf-8?B?YUZLZ2FoQWNZVmg5Ulk3R2ZoajdVN2VycUFGUHRVNVlwWWdoeDZZd29iQ2tT?=
 =?utf-8?B?L2JCMEs5VWE0UDBxZ3pWdmRjcFlVbW1DWHF6NGVuZE1uT0x6ZHYyTEhxckV6?=
 =?utf-8?B?Z0daNU5QcFhWRWNleUdiM2dLRStVTEdybFYxbDNDeklldWI2eTc0RzdXNHdH?=
 =?utf-8?B?cE12UTJidlFTWGdBTFRZS2FhY3J0dHdnQjMwRGorVmc2N1ZPbkJqb24rZm5O?=
 =?utf-8?B?am1kNWttUWc3amhqZ0k4WE5ySG9SK0JpZ2ZZaFRqOHdYUzhsYXgyckswcGE0?=
 =?utf-8?B?QVZ6c0JVZVloR1J1LzVEZmc0ZUM3RXQzTVhSUUd0alphV0QxY0JtNUhZdTFK?=
 =?utf-8?B?aFR5dVprWEJpbzlKQnorWFhZQWtVendYZ3R3WTNpQmtVZXJZeUZEY1BZMll1?=
 =?utf-8?B?ekZGeFdvVWNzeUt0Z0NHYXhwUFYzQ01VTVJIRTB5bzRzMU9KT3NwbG1ZbWJ0?=
 =?utf-8?B?YlV0NW55SUxXSXlXd1p0bHQ5dU55bW9tY3VsYy9WODVTK1NMSHUzdEdVYTlx?=
 =?utf-8?B?dFcwQzBDTWFyOE15LzRzWnhRb3NVbWdvU3dOT1hFam41amNnWXZMYk9KNjQz?=
 =?utf-8?B?c2NhVjMzbnJhWlVnVzJFSHZ4dW1IeFhnV1NpUTBrTjF4WW94UUhSWHlKcUNM?=
 =?utf-8?B?TEg4UXNaRE1aZHlTL0NpNkw0T29YLzFnK3lkMTE0Z3VFclBXVVBTUFhjSlBl?=
 =?utf-8?B?bEVsaG02enhhZnFoMzNsbzludmFUUmE4LzNRVENCQzArTnNDMFRqZk5kMjl0?=
 =?utf-8?B?Q3BkMk93Z0lzWjRzeXd6bGhmbk02Z0tSa3YzYkxIRENDUXpWMXkxS2RFb1JR?=
 =?utf-8?B?bzRzMHVDMXBSWmluTXdCMDlNdS9rOGlTM3ZweCtWTHdhbUs3enk2b2Y4UVV5?=
 =?utf-8?B?SGRucUhJMVhvNVYxYnJUSXhqRW1LWTdmSnZoZHV6NmFyd3RqdFllQ2ZBNjBJ?=
 =?utf-8?B?WXozazM4bEthUUp4aTBLOFlxdTNwTmp0VjAzRG9WSVlRT04yeUtWOHZHZ3dh?=
 =?utf-8?B?QjRLQjQ0UDcvMnZ4Q2Z2a1ZTd3IvRTBEdFcvdWlmWm5yeHFmYmN0SnNHWkww?=
 =?utf-8?B?UnhndE9oTzZ1VDRQWEhKR3R6S0g2UU1OVzNmZFN1eG14Mm4xdmNnVC9nejJF?=
 =?utf-8?B?R3RxV2VGVm82TWk5TWY2T1RydnRKOUZyYm8waERqRkJTWWNkZE44UGNwYTBS?=
 =?utf-8?B?Zzh3VVFCRmdTN2hvcndRU1dPRElMeG1jdklvUEUvZkkweEtpRk9STXpxYlU2?=
 =?utf-8?B?SWZpUTJvVFlCSWFJK3FMWVdNdkZuZmtCVTB3V3NzY2s4ZVJKNWN0TFZZQzd3?=
 =?utf-8?B?ZnNDd3dvRkkzYy96TkhIZHVneW1rOGpjdlNwL0JJR0c4Z3B3QUtjL01EamEw?=
 =?utf-8?B?dHdwL3hRQjNsbjdqMy9ZdjFSR1psWXN4dWdEdnB1Vklsa1ArcDRudkZyRWli?=
 =?utf-8?B?dG1Ed0EzVGNjeDRQVFZ6alNwdkpsMkFlcTNndUZnUVlacnYzNStRa1dQRElU?=
 =?utf-8?B?ZkxxZGtqV0lTNDZ3L1pZSVdRMnpXaUs5UUxJby9TNUwwZXZ2MDVwQkFaMXl5?=
 =?utf-8?B?emtBMzVQRVZyd0ZhMTF1M2tUZGF4ektzV2xJVE94SE5SZmNDUTdIT2hiRzZ1?=
 =?utf-8?Q?HJGm5kQDtgjQXBUoSOZYC/rfJ0qmdcp63zRYxBB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enVmTUR4S1hmYUtwditRQWt2K3J5OXlCeGhxVmV4bkNXZWU5L1dhQUwyakRB?=
 =?utf-8?B?Qjg0RjljWXZDNk9TS2JWbWRuTlY0Tmd1K3BwcFVqaWtuT2t2THd4N05BWmdl?=
 =?utf-8?B?TTRrK3ZsYytMY2RCQTJacVBFUzRWeFB1Rlc5WHl1Zm9aMHVpOXo3YjJoNitV?=
 =?utf-8?B?MmZSbllpNjA4NW5yZEgrOTkyWVV1V2V0MnFPdExCRVkrNHhGQmx5TzlleTVM?=
 =?utf-8?B?VDk0OUFWMDBObTBIcWNVQ3NvZzBndVdsSE5CVStUYnRSeWpSSFl5OHEwVzhh?=
 =?utf-8?B?a2oraXFiV1djMHgxdEM3NWJ4OWxiTnN4eEl1OUJyU0MrdE9nZmE0blBHUDE2?=
 =?utf-8?B?cytaaGp4aklJVFhuNHFYQTQzOEtTVlNlSXBBaHpYanI0SEtNaS9ndTJYLzVR?=
 =?utf-8?B?eVJFZjZtT0FCZVBlNWZoRTF6SHhzNWJESzVSWkNTOWlvZ1dSZmJHckVZeklJ?=
 =?utf-8?B?TzNQd3RzSEY2YUQ0OFlkVmJxY0hhUTlma2ZXSzFEU0tTaXVwcW12TVRGN0Zv?=
 =?utf-8?B?NW1iZStLL3JTV280MGh1V2czRmc1SFh4dld6VTB0OUhlbWNnT082MjdZR1Bv?=
 =?utf-8?B?ZWlNbWc5NE5EU2lrUXJYTFdvWFFXWFRCdXdtMjBwQU5LRmNXUWI1RERxaG5u?=
 =?utf-8?B?Z2tOeTk0VFdqOThKcWk5eEwvYWR3dEE0M0JBM2JDZW9XdlhKeUNrMWJtM0Jm?=
 =?utf-8?B?WlJKRjdKOFZlYUtHb3dWU1FmVk15SnI0TmhUNEo2SWVTeWdPaGRqMFRBQTNh?=
 =?utf-8?B?TGlFNjVhSGVhUko2YXROUEl3WFpLQmJZVnZiMFNXVTQ2QzNBVnpSa1l5MzJw?=
 =?utf-8?B?VWdQalgvVFcydE5WZHc0ODl6eXE0eTJqL2czNER3R0tnSHQ5a1plWXpCUmNX?=
 =?utf-8?B?akc0T2xiZjZ2dkphczVLVG0rZldnQUxNdGI1T2Rwcmp5N1h4aTdZQlBveUlT?=
 =?utf-8?B?RVMvbGNjT3lXV3RtRjE2R09WdGVzT2txZks5MWpzdUN1ZUM3KzdHYUZIZXBK?=
 =?utf-8?B?dE9ycTQ1blBLR013anFXSkNBWTdsbGd6WE9kblkxdXBQNWpRV2pSOHhnaFlC?=
 =?utf-8?B?aVc2cEZGSGRvQU93TnBPeEZJbWpHWE1kanpLMmpSK1Z6OUluSWF5VmNQS01S?=
 =?utf-8?B?UHU1bDVGSlg2a3F6dHpNaUYrcWRFT1FBbE1jZERyMnVLMHBwbUMxSXZhcTZy?=
 =?utf-8?B?QVkwUjVuRWdJY2J5UjNmeDhoMWdJaTlLb0QrOVNFdVFaQTJENG9WY2ZCM0gz?=
 =?utf-8?B?ejN5VjA3bEpEVFh0RWtIMkRuS1BQRkZhbHRwRExqRUtWQzNSNjN1TVo1U3hR?=
 =?utf-8?B?d05KTmRueHRFNC9xTjZhWGJNbVVwVGcvWkdBMml5dmxZdi9jUFpuelJCNVlB?=
 =?utf-8?B?S2lMd3IvWm1aQmtKSFUxVjBFU1lHT3ViWERya0tKT0pFVzQzQ2R6NVExKzVF?=
 =?utf-8?B?bDhHdXlmV1c0MXZCSnNORldNc1lidTFlcFdta2E1MnJzTVMvWXF2N2xQNVVC?=
 =?utf-8?B?R1FpWHkwMHRTR3AzRjBseUNFbysxdW9hS0pINlczblVJYlNzNjhJOWpQSWI3?=
 =?utf-8?B?Y3NSZ2JFWTFmYS95R2FYOXBpelQxWlNxUlNEL2p3c2tRZDN3eHQzMmEwU3p5?=
 =?utf-8?B?K3BWbXFUR0NZUTFVQW5LU0lVMW1GZ1hBMzFDTUVVaFMxTGkxdzZXajJqdWR1?=
 =?utf-8?B?dDJNVFppekthTFJlSnF3VEU5K2ZweWIrT05rdTVDT1RseURZM1hSK0w5WERl?=
 =?utf-8?B?ZFJ1bkprWTF5cTVtSHJlY2hlT3FTbjdOZjJpZE80OWdXaGF1dDN6U3B5QnBt?=
 =?utf-8?B?Ti9ZSlRFQlYzKzUra1V2bFNSSTA2SS9ZOXJGQldKZ0JWak9Nb3NjaWNRQmtZ?=
 =?utf-8?B?bWh2VGQ5VHc0eGxXMHJRb28yT1REaThYQTBDT0kvV0svZUluZHpjblNXYVZn?=
 =?utf-8?B?VHVHT2U0MTlBQzNQRmRVVlNOeDVnOUQ2YXBwNFBlY1o1RXpkZ2lROTVtaU9H?=
 =?utf-8?B?R3BVMGx3NXFBc2JVRG8vRTd6QStjOTJseGMvdWJLMGxYczFZaXkwOFQyT0ty?=
 =?utf-8?B?eU45Y0VTNEZGaFpWZFF1WXdwT0pRbGZrN2ZyMTI3dFJvQ3RFQlNaWmFSWjRR?=
 =?utf-8?Q?gPQSnv4EGS2OgleUhvR0GYgNV?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15370f9e-63ef-41b4-5150-08dd03033133
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 10:17:20.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JhAtY/UeiHZQyfDNb7iTJuQ/XopHX0F2z5qMEBaYolf8jIdXv+DpM+0hnRPj1m+6PSAVoC/vFYW6plOy1ZiNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8587


On 11/12/2024 5:01 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Mon 11 Nov 2024 at 17:37, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> When setting the rate of a clock using clk_regmap_divider_ro_ops, the
>> rate of its children may be tampered with.
>>
>> Fixes: 84af914404db ("clk: meson: a1: add Amlogic A1 Peripherals clock controller driver")
>> Fixes: 87173557d2f6 ("clk: meson: clk-pll: remove od parameters")
>> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
>> Fixes: 64aa7008e957 ("clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller")
>> Fixes: 57b55c76aaf1 ("clk: meson: S4: add support for Amlogic S4 SoC peripheral clock controller")
>> Fixes: e787c9c55eda ("clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver")
> Think about stable trying to pick up this ...
>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>> Background: During the execution of clk_set_rate(), the function
>> clk_core_round_rate_nolock() is called to calculate the matching rate
>> and save it to 'core->new_rate'. At the same time, it recalculates and
>> updates its 'child->newrate'. Finally, clk_change_rate() is called to
>> set all 'new_rates'.
>>
>> In clk_regmap_divider_ro_ops, there is an implementation of
>> 'determine_rate'. If a clock (name as 'ro_divider') that references
>> clk_regmap_divider_ro_ops is not configured with CLK_DIVIDER_READ_ONLY,
>> it will result in the calculation of an incorrect core->new_rate and
>> potentially tamper with child->newrate, ultimately leading to the
>> corruption of the rate for 'ro_divider's' children.
> A slitghtly more simple way to put it, is that ro_ops have the regular
> determine_rate function, so it can actually alter the rate.
>
> That should be in the commit description, not where it will be dropped.
>
> Requiring the flag in addition to ro_ops in redundant.
> Plus, it is not the platform that should be fixed but the divider
> driver.
>
> Just put the content of the CLK_DIVIDER_READ_ONLY if clause into a
> function, clk_regmap_div_ro_determine_rate(), and use it
> - directly for ro_ops
> - under if clause for regular ops.

The approach of adding clk_regmap_div_ro_determine_rate() will be
inconsistent with the style in clk-divider.c in CCF, and
CLK_DIVIDER_READ_ONLY will also become meaningless for our driver.
Do we need to maintain the style of clk-divider.c in CCF?

>
>> ---
>>   drivers/clk/meson/a1-peripherals.c |  2 ++
>>   drivers/clk/meson/axg.c            |  5 +++--
>>   drivers/clk/meson/g12a.c           | 23 ++++++++++++++---------
>>   drivers/clk/meson/gxbb.c           | 18 ++++++++++--------
>>   drivers/clk/meson/meson8-ddr.c     |  2 +-
>>   drivers/clk/meson/meson8b.c        |  4 +++-
>>   drivers/clk/meson/s4-peripherals.c |  2 ++
>>   drivers/clk/meson/s4-pll.c         |  2 +-
>>   8 files changed, 36 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
>> index 7aa6abb2eb1f..eedf7c2bf970 100644
>> --- a/drivers/clk/meson/a1-peripherals.c
>> +++ b/drivers/clk/meson/a1-peripherals.c
>> @@ -266,6 +266,7 @@ static struct clk_regmap sys_b_div = {
>>                .offset = SYS_CLK_CTRL0,
>>                .shift = 16,
>>                .width = 10,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "sys_b_div",
>> @@ -314,6 +315,7 @@ static struct clk_regmap sys_a_div = {
>>                .offset = SYS_CLK_CTRL0,
>>                .shift = 0,
>>                .width = 10,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "sys_a_div",
>> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
>> index 1b08daf579b2..eb86c4d10046 100644
>> --- a/drivers/clk/meson/axg.c
>> +++ b/drivers/clk/meson/axg.c
>> @@ -71,7 +71,7 @@ static struct clk_regmap axg_fixed_pll = {
>>                .offset = HHI_MPLL_CNTL,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "fixed_pll",
>> @@ -130,7 +130,7 @@ static struct clk_regmap axg_sys_pll = {
>>                .offset = HHI_SYS_PLL_CNTL,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "sys_pll",
>> @@ -471,6 +471,7 @@ static struct clk_regmap axg_mpll_prediv = {
>>                .offset = HHI_MPLL_CNTL5,
>>                .shift = 12,
>>                .width = 1,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "mpll_prediv",
>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> index d3539fe9f7af..c7c9fdfd021f 100644
>> --- a/drivers/clk/meson/g12a.c
>> +++ b/drivers/clk/meson/g12a.c
>> @@ -76,7 +76,7 @@ static struct clk_regmap g12a_fixed_pll = {
>>                .offset = HHI_FIX_PLL_CNTL0,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "fixed_pll",
>> @@ -443,6 +443,7 @@ static struct clk_regmap g12a_cpu_clk_mux1_div = {
>>                .offset = HHI_SYS_CPU_CLK_CNTL0,
>>                .shift = 20,
>>                .width = 6,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "cpu_clk_dyn1_div",
>> @@ -627,6 +628,7 @@ static struct clk_regmap g12b_cpub_clk_mux1_div = {
>>                .offset = HHI_SYS_CPUB_CLK_CNTL,
>>                .shift = 20,
>>                .width = 6,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "cpub_clk_dyn1_div",
>> @@ -746,6 +748,7 @@ static struct clk_regmap sm1_dsu_clk_mux0_div = {
>>                .offset = HHI_SYS_CPU_CLK_CNTL5,
>>                .shift = 4,
>>                .width = 6,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "dsu_clk_dyn0_div",
>> @@ -781,6 +784,7 @@ static struct clk_regmap sm1_dsu_clk_mux1_div = {
>>                .offset = HHI_SYS_CPU_CLK_CNTL5,
>>                .shift = 20,
>>                .width = 6,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "dsu_clk_dyn1_div",
>> @@ -1198,7 +1202,7 @@ static struct clk_regmap g12a_cpu_clk_apb_div = {
>>                .offset = HHI_SYS_CPU_CLK_CNTL1,
>>                .shift = 3,
>>                .width = 3,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "cpu_clk_apb_div",
>> @@ -1232,7 +1236,7 @@ static struct clk_regmap g12a_cpu_clk_atb_div = {
>>                .offset = HHI_SYS_CPU_CLK_CNTL1,
>>                .shift = 6,
>>                .width = 3,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "cpu_clk_atb_div",
>> @@ -1266,7 +1270,7 @@ static struct clk_regmap g12a_cpu_clk_axi_div = {
>>                .offset = HHI_SYS_CPU_CLK_CNTL1,
>>                .shift = 9,
>>                .width = 3,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "cpu_clk_axi_div",
>> @@ -1300,7 +1304,7 @@ static struct clk_regmap g12a_cpu_clk_trace_div = {
>>                .offset = HHI_SYS_CPU_CLK_CNTL1,
>>                .shift = 20,
>>                .width = 3,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "cpu_clk_trace_div",
>> @@ -1736,7 +1740,7 @@ static struct clk_regmap sm1_gp1_pll = {
>>                .shift = 16,
>>                .width = 3,
>>                .flags = (CLK_DIVIDER_POWER_OF_TWO |
>> -                       CLK_DIVIDER_ROUND_CLOSEST),
>> +                       CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_READ_ONLY),
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "gp1_pll",
>> @@ -1999,7 +2003,7 @@ static struct clk_regmap g12a_hdmi_pll_od = {
>>                .offset = HHI_HDMI_PLL_CNTL0,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll_od",
>> @@ -2017,7 +2021,7 @@ static struct clk_regmap g12a_hdmi_pll_od2 = {
>>                .offset = HHI_HDMI_PLL_CNTL0,
>>                .shift = 18,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll_od2",
>> @@ -2035,7 +2039,7 @@ static struct clk_regmap g12a_hdmi_pll = {
>>                .offset = HHI_HDMI_PLL_CNTL0,
>>                .shift = 20,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll",
>> @@ -4048,6 +4052,7 @@ static struct clk_regmap g12a_ts_div = {
>>                .offset = HHI_TS_CLK_CNTL,
>>                .shift = 0,
>>                .width = 8,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "ts_div",
>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>> index 262c318edbd5..e2b419100e0c 100644
>> --- a/drivers/clk/meson/gxbb.c
>> +++ b/drivers/clk/meson/gxbb.c
>> @@ -131,7 +131,7 @@ static struct clk_regmap gxbb_fixed_pll = {
>>                .offset = HHI_MPLL_CNTL,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "fixed_pll",
>> @@ -267,7 +267,7 @@ static struct clk_regmap gxbb_hdmi_pll_od = {
>>                .offset = HHI_HDMI_PLL_CNTL2,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll_od",
>> @@ -285,7 +285,7 @@ static struct clk_regmap gxbb_hdmi_pll_od2 = {
>>                .offset = HHI_HDMI_PLL_CNTL2,
>>                .shift = 22,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll_od2",
>> @@ -303,7 +303,7 @@ static struct clk_regmap gxbb_hdmi_pll = {
>>                .offset = HHI_HDMI_PLL_CNTL2,
>>                .shift = 18,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll",
>> @@ -321,7 +321,7 @@ static struct clk_regmap gxl_hdmi_pll_od = {
>>                .offset = HHI_HDMI_PLL_CNTL + 8,
>>                .shift = 21,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll_od",
>> @@ -339,7 +339,7 @@ static struct clk_regmap gxl_hdmi_pll_od2 = {
>>                .offset = HHI_HDMI_PLL_CNTL + 8,
>>                .shift = 23,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll_od2",
>> @@ -357,7 +357,7 @@ static struct clk_regmap gxl_hdmi_pll = {
>>                .offset = HHI_HDMI_PLL_CNTL + 8,
>>                .shift = 19,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hdmi_pll",
>> @@ -413,7 +413,7 @@ static struct clk_regmap gxbb_sys_pll = {
>>                .offset = HHI_SYS_PLL_CNTL,
>>                .shift = 10,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "sys_pll",
>> @@ -703,6 +703,7 @@ static struct clk_regmap gxbb_mpll_prediv = {
>>                .offset = HHI_MPLL_CNTL5,
>>                .shift = 12,
>>                .width = 1,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "mpll_prediv",
>> @@ -911,6 +912,7 @@ static struct clk_regmap gxbb_mpeg_clk_div = {
>>                .offset = HHI_MPEG_CLK_CNTL,
>>                .shift = 0,
>>                .width = 7,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "mpeg_clk_div",
>> diff --git a/drivers/clk/meson/meson8-ddr.c b/drivers/clk/meson/meson8-ddr.c
>> index 4b73ea244b63..950f323072fb 100644
>> --- a/drivers/clk/meson/meson8-ddr.c
>> +++ b/drivers/clk/meson/meson8-ddr.c
>> @@ -65,7 +65,7 @@ static struct clk_regmap meson8_ddr_pll = {
>>                .offset = AM_DDR_PLL_CNTL,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "ddr_pll",
>> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
>> index e4b474c5f86c..4dba11c0ab7e 100644
>> --- a/drivers/clk/meson/meson8b.c
>> +++ b/drivers/clk/meson/meson8b.c
>> @@ -104,7 +104,7 @@ static struct clk_regmap meson8b_fixed_pll = {
>>                .offset = HHI_MPLL_CNTL,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "fixed_pll",
>> @@ -457,6 +457,7 @@ static struct clk_regmap meson8b_mpll_prediv = {
>>                .offset = HHI_MPLL_CNTL5,
>>                .shift = 12,
>>                .width = 1,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "mpll_prediv",
>> @@ -635,6 +636,7 @@ static struct clk_regmap meson8b_mpeg_clk_div = {
>>                .offset = HHI_MPEG_CLK_CNTL,
>>                .shift = 0,
>>                .width = 7,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "mpeg_clk_div",
>> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
>> index c930cf0614a0..470431355e25 100644
>> --- a/drivers/clk/meson/s4-peripherals.c
>> +++ b/drivers/clk/meson/s4-peripherals.c
>> @@ -175,6 +175,7 @@ static struct clk_regmap s4_sysclk_b_div = {
>>                .offset = CLKCTRL_SYS_CLK_CTRL0,
>>                .shift = 16,
>>                .width = 10,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "sysclk_b_div",
>> @@ -221,6 +222,7 @@ static struct clk_regmap s4_sysclk_a_div = {
>>                .offset = CLKCTRL_SYS_CLK_CTRL0,
>>                .shift = 0,
>>                .width = 10,
>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "sysclk_a_div",
>> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
>> index d8e621e79428..5dc051afc06a 100644
>> --- a/drivers/clk/meson/s4-pll.c
>> +++ b/drivers/clk/meson/s4-pll.c
>> @@ -72,7 +72,7 @@ static struct clk_regmap s4_fixed_pll = {
>>                .offset = ANACTRL_FIXPLL_CTRL0,
>>                .shift = 16,
>>                .width = 2,
>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "fixed_pll",
>>
>> ---
>> base-commit: 664988eb47dd2d6ae1d9e4188ec91832562f8f26
>> change-id: 20241111-fix_childclk_of_roclk_has_been_tampered_with-61dbcc623746
>>
>> Best regards,
> --
> Jerome

