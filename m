Return-Path: <linux-kernel+bounces-212961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0F89068F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102991C23FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79E14036E;
	Thu, 13 Jun 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Nb3aPnAE"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2089.outbound.protection.outlook.com [40.92.103.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F5142634;
	Thu, 13 Jun 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271263; cv=fail; b=h6FH8ytq42Jy7VfgxG+wkRnXvbmZulPfuCFa1Y5Ie6uIaMWhkwlA5xPXnW6dAmGiFkPRze7OrhEkasKDE8e5kVWllqRIgtmtMqk5d67RkGMXoBg3rrZNhqJy99pfyARLu2o6PjQx9byfIc731RuHK2xT8a3zCm7Jg2SRHrAqdDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271263; c=relaxed/simple;
	bh=OgbIIMbidyEiQzHatmkS4gqCHi+NohyHoZRnNKb3b5c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lagkx+QvhDmau42TC9iPvUV+FwuTJp2lBudDJcet06qKagogpr5aWqHDyfRiuhxqnfy9bQGFJeP/+I0WwptJYJZ7g+fgS0ORLQTGHLVR1WYrFkJ/szogyYjJ8cLp60tuNrPavrioObPpeitlVsDbq7l7xc67TeFL2LE9nDpaPzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Nb3aPnAE; arc=fail smtp.client-ip=40.92.103.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my450PxXyaWzYjJmlcTgsHhmDvIRS1oTte4h0G0FnA9g57rX1f4r0Rmj5lJyWcu+WM1iUuHO/fvTcQ0xWpRWq8g4pTRUlUaPijAqlEG4gvfCHdN+Dao5v+fA3tYLWwKEvvSt/uvS1FFAmmU1OF36wpLivZy7vWl87vrFiG4sRAJFkcNyUKlYSC7hZoKaM+zFgcWVBTw8pPyIdvqngiYbGogNwlLNQOyRF8xy/v5/27TWXboYb99XtKGQDqufiThsurT34fkVjcOW8PDVM7IX03ozmKgy3ah5Ue9V+CoGEgylZlPIO4oN9FdoGiha85/XwLfY97hQxGiMw8mfJak4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7j4iN24a9TmTi8PbbvM//28khpVHVD82znnheY1h3c=;
 b=MNVmyZQIAiOt02phKHh2mGDwTOnQ4iX1YKUqpvEdHHxbRiJMCjVYVoAd7sIYcYdu2jdUbxsBwwj8y6ofpWtqqjpwU/TIUASLIrtFCESEJ76nrluEOgZ31XRCszP9iSpM27o6z/0aZzHOjNjcL8lSKZJHZFyPnCnytAagE0fSCOZzPVGp+nCWR0WwxINoU7DCBFOqZfJFT2vQ8kLcv9wN6GAE0JfQ1FYf/Rl5vosh1g10bh+Gcjlrz4EYBlICrgVd0bDiTwiMxaBycYukPsPZJQXlKPJQ78R8NHrSDcXan4+G7imcHw9H2O/FWhKEYKpZw67NIp1LUZuwIW5phTYhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7j4iN24a9TmTi8PbbvM//28khpVHVD82znnheY1h3c=;
 b=Nb3aPnAEoJM1fkbSeU3DCF0sil53ej2ESNwYocLbKEvkA6ft8wSTn8d83nGXNOty5g9K8+5/EllP02F3ubHLhs27IXM3FHDwf27hjrZpdvrm+/ucvJUOX98oW/L2OTgtOinYZfFzBc7kWmrQdjeJq6GYn6UknOSw95CWWBtxMNYFGV4uWDlqfQHwdM2aQ9nO/zuJ4zSBlM+gImClyOvZcHEU7WpjuyE2vWvH+5gnZp7falFLzuxisN/RZiCG9abfuWNivBlptQSoiBSStvhujAYfQYNio4xaaTm6ks9npCS31cqea3ViUBQkju7/wH068urkgr50EDsDImupLGo9TA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0413.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 09:34:12 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 09:34:12 +0000
Message-ID:
 <MA0P287MB2822B36985A6EC138C2A97CAFEC12@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 13 Jun 2024 17:34:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/5] riscv: sophgo: add clock support for sg2042
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1717661798.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1717661798.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [3n2cyEh/y1iWbitfZaaUoGl/C4sG9rY+]
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <d891f987-a83b-461d-8b1b-ac61dcc1e7e0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0413:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f86177e-b9c4-46dc-6063-08dc8b8bfb37
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199022|1602099006|3412199019|440099022|4302099007;
X-Microsoft-Antispam-Message-Info:
	BEpA5/t+iLNhZpM0hjg5D0ZJwCuRDzuuLBRfJUDCNkERV5udRteRVi4YUWjl43/Ufp9vR4OjoYlJidntMJP2+2idk/gPAp4Uk07bxeO6lPPnwdaJuJcy8CLdOe1M+xq/YtSNnY8xHHj8GsX9e8rjuofrHJNrKuMlVTa9ZezGVoPxoNSIjmUwsCsJdDDvdnDrV+HReMsCf2GFLHCbv6+4faxcgR8YpvAMDPOVaHv6hTAi6YkrCe05IopYVftgjBAAoE4FNX7umkDznERrAyRad8uMstICy7biYbvs4MSEaX7XyMMfz5tkrkRRaetJ/2MLgq1cF0R7NsMuaDuq70roO8WN3saJFhKxhGicXVP00OeTCWMx7xJ4so1mgAz7fI9Q4APEU/OZd0tbzKKCyj8d8ZwjfUDnDdeyoXyE7Varms+GqfgOlbDdJ8Ea9t+gpZq0PwRzKNcxleUr60HHmgtDc7ZzWe+KscWSq6xV9g/io+6deg4bfGngosYJZ6Afa2bT74pYD0UOG6HA2gJb+Zy6nICNwJC89DEYQPvRq8EE+NYZqRxnrjykRSD0ml5z8n28fV/6oCBg3nS2kaQwcYVpccr7fqN719or6mQH6asx1ql5mOExUQaeVIkKz7c8PakhXYzNFiDGEJXbqxGYLWh4z2amnaGVr4MttCa3xT5HtWopyZDa+jGdNp8aklKiz23Nixmi7KD1eNaGBTohXapnIH0tueC4Mnm9U14F0FnGJ8IzIE7n3S6egyrtOeTBbzGF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUN0dEE1VjBrVDlYSWpTaUtIck0yL2x4R2ZTcUNvRWxaWVR4dkY1aHlrY1dZ?=
 =?utf-8?B?SnozeWE5NDhmN0IzR1diakFKU2kwL3Y0Z0Ntb1pZb1Z6aG5sTjE3U3NwcEQy?=
 =?utf-8?B?WmZYNE55WEZJR0s2Sk0yb1lYZW5LMW5Na0NkTWpHcFBJMTB6YktwZDdFaU5m?=
 =?utf-8?B?Y2tEbFRSMGIyNFQvOXhXR3BGSXJHT1ZpckViaHp0ZVh1SFlnMEJQZVB0a0Vm?=
 =?utf-8?B?bDIzRHV5b2RHdkxnYVNGWGN2YjgzNHpZVUJiSlZHZmQ5STloSDJzY08vb3R0?=
 =?utf-8?B?aHc2VEJDKzdjaGYzUGF1eUZJQlA0WWwxK2RjWmp2OU5oZFlhM0c1WURwYTJP?=
 =?utf-8?B?VjNsMWNEOWowTVpIMHovazFHYjFEZUFlK0d2UjVNTDdFSm9UcEliWHpQcXBW?=
 =?utf-8?B?Q0p3M080dkNOZkNnZlh4c0NtNUxwZTlTelQyL25BS241V2ZFbmUzNmdablhm?=
 =?utf-8?B?eHdGSTNZTlpXbFh5SVVwR0RtWDQrbGJiZXpPbExvTDZQT25XMHFxZ05KMjRo?=
 =?utf-8?B?bXRkNzVkQTFyNFdPMzBFWWJ4R0RCMXEwKzBjajh5Q3cwalY1ald1ZitIbGsz?=
 =?utf-8?B?RWp5L2ZXSTlVNyt2cDk2RHRCcGdiZzJtdjdYU2lnZmg1cGNBUkJXZjBnellS?=
 =?utf-8?B?VWlOaFFhM3VGQzdrNTRyV0ppbG5vVzc3a1BFRUhSakVnK2VqRjNVVTVpVXZa?=
 =?utf-8?B?MXZiZitvWXp4d2VNM2VYSmVqd0xORjlXeFNZSHNCY3dpRTRTeVRnWk5JTVlz?=
 =?utf-8?B?YVlaMjN0cDBKNk5QWUtXRGpvbFExSjF4bGs0eUhJd0ZnbkljSk83UXZNc3lT?=
 =?utf-8?B?MmNOOXZCUXM0RFdScmpTV1FTZ0w4VldvM3I5aytkRGdmRXcwUVRVUlpLa2FN?=
 =?utf-8?B?WFhaZ0RscXFjSXErZktFcFB0QTZYUUszajZjT0ZxTjYzYlJPcGJvQVBkZjZ0?=
 =?utf-8?B?bkpoMlQ1WmI2aThrTXVKUHRRc2FwRHNZamNoYUc5YUJZQTdneHpkbzZRL2l2?=
 =?utf-8?B?aWI3Zk1JbUg5QklTVUdOMXpRTmlad1RKNnlFbWEzUkZ1ZXJRUzdXQTVwbjEy?=
 =?utf-8?B?L0dLMS9OWXVJR0Irb0FCaEdnRk5LaEkrcUN1YUdJamlFZGZ5TW1aRVM2blpj?=
 =?utf-8?B?WllEcmtNaXpzUHpFR3JGRW8wVFhrZTQ4VHUrL0Frb1dPVGR0Z1RoTkUvQ2pX?=
 =?utf-8?B?VUpENXl5K2RPQW8yNVFCZU84bjliaytwdGFQeXY1dHVmdlIva0N4N1ZNZVdX?=
 =?utf-8?B?UGZsK1VxdzlMMWxGeFc1N3ZxanQvRkhiLzhYOU91dC9mMGxYd1lGMExqN0ln?=
 =?utf-8?B?bFJMWkdDZEhoZlhvaUFTUVBQSUQ5TXJrSkI3b29lUVZrU2cxOGFwNmtMenhR?=
 =?utf-8?B?ZldhM0svQjNhWU5RZHZqUi84L2xjLzg1SkQyRXFMaU9UaG9wL0FoeFVVWm1q?=
 =?utf-8?B?R0szTkZhSlRsWnU0N3gvcDQrdEtCSnNuakR6dkc2VlFOcXprRllYRjlIT3lm?=
 =?utf-8?B?RWJIVy9QRWlIbmVhb2Ywd1QxWjgzL2gxeDk0UTFqWGVpN1NLd2Z5amlVb2Nm?=
 =?utf-8?B?VWlTaEZsd2hqZ0xYNlNyT05NL3U4UVZIUFcrc2MvYm1FZm5nWXNBM3daYUh6?=
 =?utf-8?B?MnJpSzc2SEs0M3BMSmJtU0hETFoyK1VhVGh4UlkxSThSQXFLdlJKbHF1L2Mz?=
 =?utf-8?Q?rSk5uKiJofNsUmYE10tJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f86177e-b9c4-46dc-6063-08dc8b8bfb37
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 09:34:12.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0413

ping ~~~

On 2024/6/6 16:36, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> This series adds clock controller support for sophgo sg2042.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v16:
>
>    The patch series is based on v6.10-rc1.
>
>    Improved the dirvier code as per comments from Emil Renner Berthing.
>    - Split driver source file into three and change from built-in to module.
>    - Directly use status/enable pll register, no need to store them.
>    - Use FIELD_PREP/FIELD_GET to simplify the code.
>    - Some misc code improvements, such as for macro and local variables.
>
> Changes in v15:
>
>    The patch series is based on v6.9-rc5. You can simply review or test the
>    patches at the link [16].
>
>    Improved the dirvier code as per 3rd review comments from Stephen Boyd.
>    - Converted all parents described by strings to use clk_parent_data or
>      clk_hw directly.
>    - Just use struct clk_init_data::parent_hws when only have a clk_hw.
>    - Removed extra cleanup when use devm.
>    - Some misc code improvements.
>
> Changes in v14:
>
>    The patch series is based on v6.9-rc1. You can simply review or test the
>    patches at the link [15].
>
>    Improved the dirvier code as per 2nd review comments from Stephen Boyd.
>    - Inline the header file into source file.
>    - Use devm_xxx functions for pll/div/gate registeration.
>    - Use clk_parent_data for mux clocks initialization.
>    - Use u32 for registers readl/writel.
>    - Use devm_platform_ioremap_resource instead of devm_of_iomap.
>    - Cleanup some dead code and add definitions for some magic numbers.
>    - Add include files missed.
>    - Use kernel-doc to improve comments for some structure and functions.
>    - Other misc code cleanup work as per input from reviewers.
>
> Changes in v13:
>
>    The patch series is based on v6.9-rc1. You can simply review or test the
>    patches at the link [14].
>
>    Just added a minor fix for clk driver which was missed in v12.
>
> Changes in v12:
>
>    The patch series is based on v6.9-rc1. You can simply review or test the
>    patches at the link [13].
>
>    Improved the dirvier code as per review comments from Stephen Boyd.
>    - Remove default y for CLK_SOPHGO_SG2042.
>    - Optimize sg2042_pll_get_postdiv_1_2, move postdiv1_2 to the function.
>      scope and add more explaniation.
>    - Optimize sg2042_get_pll_ctl_setting.
>    - Switch to platform driver.
>    - Use clk_hw for initialization of struct clks.
>    - Don't use ignore_unused when using critical.
>    - Other code cleanup as per input form the reviewers.
>
> Changes in v11:
>
>    The patch series is based on v6.8-rc5. You can simply review or test the
>    patches at the link [12].
>
>    Quick fixed some dt_binding_check errors reported by Rob.
>
> Changes in v10:
>
>    The patch series is based on v6.8-rc4. You can simply review or test the
>    patches at the link [11].
>
>    Add input clocks for rpgate & clkgen.
>
> Changes in v9:
>    The patch series is based on v6.8-rc2. You can simply review or test the
>    patches at the link [10].
>
>    From this version, drop the system-controller node due to there is no actual
>    device corresponding to it in IC design. SYS_CTRL is just a registers segment
>    defined on TRM for misc functions. Now three clock-controllers are defined for
>    SG2042, the control registers of the three clock-controllers are scattered in
>    different memory address spaces:
>    - the first one is for pll clocks;
>    - the second one is for gate clocks for RP subsystem;
>    - the third one is for div/mux, and gate clocks working for other subsystem
>      than RP subsystem.
>
> Changes in v8:
>    The patch series is based on v6.7. You can simply review or test the
>    patches at the link [9].
>    
>    In this version, the main change is to split one clock provider into two.
>    Strictly follow the hardware instructions, in the memoymap, the control
>    registers of some clocks are defined in the SYS_CTRL segment, and the
>    control registers of other clocks are defined in the CLOCK segment.
>    Therefore, the new design defines two clock controllers, one as a child
>    node of the system control and the other as an independent clock controller
>    node.
>
>    This modification involves a major modification to the binding files, so
>    the reviewed-by tags has been deleted.
>
> Changes in v7:
>    The patch series is based on v6.7. You can simply review or test the
>    patches at the link [8].
>    - fixed initval issue.
>    - fixed pll clk crash issue.
>    - fixed warning reported by <lkp@intel.com>
>    - code optimization as per review comments.
>    - code cleanup and style improvements as per review comments and checkpatch
>      with "--strict"
>
> Changes in v6:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [7].
>    - fixed some warnings/errors reported by kernel test robot <lkp@intel.com>.
>
> Changes in v5:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [6].
>    - dt-bindings: improved yaml, such as:
>      - add vendor prefix for system-ctrl property for clock generator.
>      - Add explanation for system-ctrl property.
>    - move sophgo,sg2042-clkgen.yaml to directly under clock folder.
>    - fixed bugs for driver Makefile/Kconfig
>    - continue cleaning-up debug print for driver code.
>
> Changes in v4:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [5].
>    - dt-bindings: fixed a dt_binding_check error.
>
> Changes in v3:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [3].
>    - DTS: don't use syscon but define sg2042 specific system control node. More
>      background info can read [4].
>    - Updating minor issues in dt-bindings as per input from reviews.
>
> Changes in v2:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [2].
>    - Squashed the patch adding clock definitions with the patch adding the
>      binding for the clock controller.
>    - Updating dt-binding for syscon, remove oneOf for property compatible;
>      define clock controller as child of syscon.
>    - DTS changes: merge sg2042-clock.dtsi into sg2042.dtsi; move clock-frequency
>      property of osc to board devicethree due to the oscillator is outside the
>      SoC.
>    - Fixed some bugs in driver code during testing, including removing warnings
>      for rv32_defconfig.
>    - Updated MAINTAINERS info.
>
> Changes in v1:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/cover.1699879741.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/cover.1701044106.git.unicorn_wang@outlook.com/ [2]
> Link: https://lore.kernel.org/linux-riscv/cover.1701691923.git.unicorn_wang@outlook.com/ [3]
> Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
> Link: https://lore.kernel.org/linux-riscv/cover.1701734442.git.unicorn_wang@outlook.com/ [5]
> Link: https://lore.kernel.org/linux-riscv/cover.1701938395.git.unicorn_wang@outlook.com/ [6]
> Link: https://lore.kernel.org/linux-riscv/cover.1701997033.git.unicorn_wang@outlook.com/ [7]
> Link: https://lore.kernel.org/linux-riscv/cover.1704694903.git.unicorn_wang@outlook.com/ [8]
> Link: https://lore.kernel.org/linux-riscv/cover.1705388518.git.unicorn_wang@outlook.com/ [9]
> Link: https://lore.kernel.org/linux-riscv/cover.1706854074.git.unicorn_wang@outlook.com/ [10]
> Link: https://lore.kernel.org/linux-riscv/cover.1708223519.git.unicorn_wang@outlook.com/ [11]
> Link: https://lore.kernel.org/linux-riscv/cover.1708397315.git.unicorn_wang@outlook.com/ [12]
> Link: https://lore.kernel.org/linux-riscv/cover.1711527932.git.unicorn_wang@outlook.com/ [13]
> Link: https://lore.kernel.org/linux-riscv/cover.1711692169.git.unicorn_wang@outlook.com/ [14]
> Link: https://lore.kernel.org/linux-riscv/cover.1713164546.git.unicorn_wang@outlook.com/ [15]
> Link: https://lore.kernel.org/linux-riscv/cover.1714101547.git.unicorn_wang@outlook.com/ [16]
>
> ---
>
> Chen Wang (5):
>    dt-bindings: clock: sophgo: add pll clocks for SG2042
>    dt-bindings: clock: sophgo: add RP gate clocks for SG2042
>    dt-bindings: clock: sophgo: add clkgen for SG2042
>    clk: sophgo: Add SG2042 clock driver
>    riscv: dts: add clock generator for Sophgo SG2042 SoC
>
>   .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   61 +
>   .../bindings/clock/sophgo,sg2042-pll.yaml     |   53 +
>   .../bindings/clock/sophgo,sg2042-rpgate.yaml  |   49 +
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   12 +
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   55 +-
>   drivers/clk/sophgo/Kconfig                    |   28 +
>   drivers/clk/sophgo/Makefile                   |    4 +
>   drivers/clk/sophgo/clk-sg2042-clkgen.c        | 1152 +++++++++++++++++
>   drivers/clk/sophgo/clk-sg2042-pll.c           |  570 ++++++++
>   drivers/clk/sophgo/clk-sg2042-rpgate.c        |  291 +++++
>   drivers/clk/sophgo/clk-sg2042.h               |   18 +
>   .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 ++
>   include/dt-bindings/clock/sophgo,sg2042-pll.h |   14 +
>   .../dt-bindings/clock/sophgo,sg2042-rpgate.h  |   58 +
>   14 files changed, 2475 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>   create mode 100644 drivers/clk/sophgo/clk-sg2042-clkgen.c
>   create mode 100644 drivers/clk/sophgo/clk-sg2042-pll.c
>   create mode 100644 drivers/clk/sophgo/clk-sg2042-rpgate.c
>   create mode 100644 drivers/clk/sophgo/clk-sg2042.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
>
>
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

