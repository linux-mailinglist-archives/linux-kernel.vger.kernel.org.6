Return-Path: <linux-kernel+bounces-446446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871809F2466
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2422165879
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AFC18FC81;
	Sun, 15 Dec 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EDsB8Vbm"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020126.outbound.protection.outlook.com [52.101.191.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A6154449
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734273571; cv=fail; b=VlF6iVemMMVp8uh1XqSn7kxNDz5GKk4dhojPbWxRQggFum8RdT850aBP4lH3G08jNcl/8xubUhAYJzVlU8Iu1vYeZXxYq3TP5SPQ4bLieN8hMDDvLp+pODUR2Vifrga8UqyVAw/AzCKVVta3sqrkGwUo4Yywfi71/mTYYyHII64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734273571; c=relaxed/simple;
	bh=zmyyRZpoX8xzI/W9XoIjgKsYKO2LjwA5Qity2YYBk6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=av+eXuJN/aDKWqxEssh8Q8Ca4KWgM+WYBry/mZsTsOKhhLehwRwFsG/Kz5DgttywpBbmne20BA8z6r4zCEciz0PuT5KC2n7rVdSWf1P06DB+g1EyagrMDoewK3FdD8HXNIjTMKhr8hu1r+C+Ru659o7D1Pg5hC4pR/uoHsYER7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EDsB8Vbm; arc=fail smtp.client-ip=52.101.191.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooRQ/PONLg9eKr/3Kz68Cny1BXAfs7cDlIBGKlrDvfHMmOFnE4inkrlPdjIjxZgn1hyifsu4W88uZBjMf4EycqUOTYtA90dMjB88nTVCVxTRW44JXfyzuCSpHhEpIQuuS9l7GyNa0i3WHTcmO0BVriVzIsXCCQk5CQrBkYo6ADhI9r3M54yvLANShVObN0qfVMMhMKxfALOAdV5NKnlSuO0JOW3Bj+c1QUmAddPHuUmAV+rcnB/kEP8g5pGEovYBUB9buLACnpnKOQUyDZj0zOV0iSdEL/yhYvlXl34PsGagug+27po3NbS1GeS8m/Ka011mfoj0Io+9PGbz+1mnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfSFiqu+QxcNs7DlpPljfU627JifHfbFi4CiPTvxNS8=;
 b=Qbx/2InSELM7rm6TqKYYCOVUvOO7oSp72j/RPUUka+O2+JMKYoC8ryO/wY2VKyhuQhx81pV+4IpjCG4IuZo85Vujgb4KmPxaoLOCB35LVNdrvD/62audQX4ivU2rnMjQmMwwDyuXCq8NEJVQk5vY2xOeUhMfMxpM7+zf8/eia6cGsu2WFa/M9omQE0gsoCgC66qZOil5NCUpUUu2tQ102n2pZgghuv1w9xsmw5QzRz73LfoGBX/msKMdv/sP4cGiFGt7Es65kXLX9u3s6oHLAK7FKq4XTTFOn/pmjIiS9KBOhNf4df9lt9IWjs+646q1dNyp6r4PCfq8d5r0qMBmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfSFiqu+QxcNs7DlpPljfU627JifHfbFi4CiPTvxNS8=;
 b=EDsB8Vbm1XUM88ZVzK/hYUrBZipBVrNZIqXDWpTIRbuMlVsLBAmw92TcQpp2d2VQFGXz0uRdNcHLIxtlsjrylX340IZFcArNjkOADbJbSJn9ByCgTvtI7dnnuJ5yaDmeSIpwE2aymKkmZkjoRG+GCQg+/oC+sock76cj8KBwNQ2w7dCpVDFoXnGOiI27SparShJXUO747OqPjEaRrcFspfFd107z+ERV0jhSvbXSPoMlQPJ0kCjkbDzKWvC0t7dP7I0LZuWrW7XSE6Yi1GJzgNseuIaZtoKh6w1/kgW+WGdkfffXpRM1RLTcAxwr6+/jAF7hR9WMei8kIutVsFA3sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT1PR01MB9081.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Sun, 15 Dec
 2024 14:39:26 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%4]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 14:39:26 +0000
Message-ID: <e1ccc82d-6939-4a0f-8911-11ae674cfd8a@efficios.com>
Date: Sun, 15 Dec 2024 09:39:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Michal Simek <monstr@monstr.eu>
References: <20241214182138.4e7984a2@batman.local.home>
 <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home>
 <20241214221212.38cc22c3@gandalf.local.home>
 <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
 <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
 <20241214233855.46ad80e0@gandalf.local.home>
 <CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
 <20241215050517.050e9d83@gandalf.local.home>
 <69db591d-08b0-47e7-a8cc-bdaf3e9d4678@efficios.com>
 <20241215084709.42ab04c3@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241215084709.42ab04c3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::25) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT1PR01MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a92d27-6b2c-4414-07b3-08dd1d164639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekRMODc0SmpXMWVkMno4T0J1VUptMEpleHZpL0F0LzEwMUJrRmhIYmZuTk5i?=
 =?utf-8?B?em1HNXpKZ3dndVBLZE03K01BczFRekFuRkNzczIxR3h6ei9DTVJ6M25VK2xm?=
 =?utf-8?B?QjExRGt2eklNU01rR0txdGlRQUJ3a1UwMmp2ZEpQSGxvbnV2QVRtckl5am9T?=
 =?utf-8?B?SFBkVGJkandoUUh2dUZ0UTloWmZrTG9IdFJBUThCek1XN1hZdlhPbFN4MWRq?=
 =?utf-8?B?dlRQSFk5Z3FTenFTNHBlTElpc3ZNR05DS1hWVzkrMEZvRFVhSkxlQk5UeThI?=
 =?utf-8?B?OGZuREM4WStkUUNoVitjOHhrTUJKWTQ2TWQyV21WdUJTM1hrNUZKQzJ0SlFy?=
 =?utf-8?B?a0k2c045ZXEzUnlHL1YzbnE1NTVBREZQN0ZRdkFLejZqclcwODZVOHAxMk9i?=
 =?utf-8?B?bjMxZTFiZVdwekVMYUJkVzF6cCtsUitVQ0JXZ2lieWpRSHplNk1VMFIvT1l4?=
 =?utf-8?B?NTgrS0w3VVFqc2o1UXVRM2h0NmVlM3AybDJpZU84Y2RDelp0S1owbDVTNXpU?=
 =?utf-8?B?dXkwUWN0SU1DV2N5NnY0aHhMUWZXeWhXVjFBeWlhTVUzWDBvTU9ITFFRUXBO?=
 =?utf-8?B?QWVRLzlSOGFqbDBwZStqVjVRQnJzM29xcmFKelN0ZUxlVk8zSzU2b3RoaGh6?=
 =?utf-8?B?MmRHdFhuNEhxakY4YXdMZXRvT1FrclBwMDVUMGRRTC9oWllvRmxOZ3JWU2Qx?=
 =?utf-8?B?RU11aklJNnpWUHByc1pSMzROYXg1azlUbXFhK2RRNEZxSStNQWJUUEUyTmsx?=
 =?utf-8?B?QzRFSE8wSGMzckkrbnJnU3orbXVwaGZXeXJMVmJaSlpjS0FjUG1uakZjZG4r?=
 =?utf-8?B?QTh0V2hTMEd6SmdvOTVXb1lPbVJXcEhyVzlSU1dqK1RwUHJOK2xnS0xwa0NL?=
 =?utf-8?B?alhhbnUzdGFYN1VSSTM4VGJSamx3bW4wbUhCTzErVnh1RitsYlJTN0pOck1P?=
 =?utf-8?B?dUFHOEg3UGFFL2dEbkJPTkhOa2J5KzdTZVYzeHZTTzNXTzFmcWlENWlGaENZ?=
 =?utf-8?B?RkY3TVpEWWhyZUIzeVQwUnR2L0NZejU5V0g1eW5oL1Rrd2pvMmxEdVNhOE9G?=
 =?utf-8?B?YUFUWENTTEFmN0s0UFh1a3JCL2NRNVNraHBTdWw2dGE5dmVSZ2hZdExyYW1l?=
 =?utf-8?B?bTRLa0Rmd1RtU2REdXRnRG1LTUJOM04yNFRoUWpNZjdqYisvTGxZYXF1bmR1?=
 =?utf-8?B?Z3lwdERUOGJRREJIT2lMNldhZjM1d3JSanUwcStoRWZwUG5ta2tneXJQdDZ4?=
 =?utf-8?B?czRRRHJxNi9EaXNUbnVYby9wRDNobG91QkNodEVMTXBkVkZxd0pRa00venFH?=
 =?utf-8?B?UXAzK3BLdzFLVlhzYTF3eks2c1Q0THZvVzl6YkJBNnVvQTJEOXNMdDJ0RDhX?=
 =?utf-8?B?Rm9VZlVCYzZMN0gzamlXa3lUU05DSzIxT0tiYXRZcHNSb2tlWk9LMlVuc2lB?=
 =?utf-8?B?OHBkZ2NOSzVWTVJ6OGRYVlhFZ0N1d3YrWkhSRnMvN285bjJtN0ovSVlCYnB1?=
 =?utf-8?B?cjNmNVUrbUhZczQvaTFRQVUyUFJIQ0Q2NG5jdmpsUDVybDVQMXNiS05hRktQ?=
 =?utf-8?B?d21kSHl6dHl6RlhHRFErd0lkTm5XdG9zMC9PMkNLR1ZqUlllai8xc0x2Rjg1?=
 =?utf-8?B?NWJ5NXZQZUtnWDF2U2Z5ZXFJY3FXVzcyd1lrbDZLam5Hbmx6dWRXMkhaMlpX?=
 =?utf-8?B?SXpudjFKc2NMdDJtd3BONE1mcXlrMkJDWUZMV2NYTm0wOUZXcGdpekNNaGlk?=
 =?utf-8?Q?VapB4kAJWEpYAoh64Bm9KqBiMxSCf9nk/AZydnu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1dvSTFHaHlUWkF2YlVqRk41eWs1cFlyWmxoUnVyWFhrM0pGTk56K3lxQzFL?=
 =?utf-8?B?Vk9zQVdWbDdBMWJmNThpakcvNWR0eHdJdWlNREFBaUFlTVc4SmRBdEl5NmQy?=
 =?utf-8?B?VUdNbDlDZFkveTZjdlFqaGExSkxpUXVMMFlTTUZRbDV6bTMxNEFxeE4vL1Np?=
 =?utf-8?B?aEhmNmsvQVRGUkppMGFOSDlDMVY4anhyWWJpVmt0OS9LcVVmTVI0Q3RDMWRy?=
 =?utf-8?B?SkQ3aWlEL3piUno5Q0MwMTJRRUYvS3N5ck5XazRUaWR1WEZCZVJFeWtPdFlu?=
 =?utf-8?B?a2VhdVp6OEh2TEg4RnEzU1FPSDZMSUcrRkc5YXZSSEJmc2xoV1pzQ1lLYWF3?=
 =?utf-8?B?cUViMk94bGk0VVFNNWtPWlp5d1Y0UTBRbjI3Ykc3MkYvQlZHeEtJWTRlMjlt?=
 =?utf-8?B?WDNFMmFnc1E1YjAxYk1yN2licjFTMU8rTFF2M2NBRGVMSjR3QWJEMU1YZXk4?=
 =?utf-8?B?eTFFOXBKZWs0b3BxSGhnZ3N4QUxGMjZWY1VZd3dEb3NDaVhaQU5rekRHcEcv?=
 =?utf-8?B?WG9nRXlkNHAraFF5ZmZHZkttbExOeUZxdEVtVWVDWWRKVVpNU0FUY2VGVXRs?=
 =?utf-8?B?SGlpL2gwN1Z1dlFQeXdNdFNMRGdvOW4wMU5QM2c2ZG1NLzBCZXhnR2t0cUVZ?=
 =?utf-8?B?Q3lzM3d3MzZUdlhyczluRGl0ejcvSnk4SXkwVm5NbWVXOTlELzVuVlNkWVZr?=
 =?utf-8?B?eEtyN0dEVTVua2xEVU1HVzdKdmZGbG9oYk5oSzlpOGZlZEdJNW9OSUNPQlJ2?=
 =?utf-8?B?Sk1WSENFaCtlZ3U4QjBDelZoMVlrMGRiVy91ejFOKzhOUWllMm95TWkwaTBi?=
 =?utf-8?B?Y1huS0xWNTk4cEFoUGY2TzhNekJENjQ3NmQweWZpMW56VnJSa0JmK3d5b212?=
 =?utf-8?B?VitLZk9ITGsrb0Z3S05CTkFyZmFrTUtyamVUMjY5T2VPNklwOEhLcEg4K3NO?=
 =?utf-8?B?bVJWUVlqOTd1TzdzdU9ESE1ORFZFbXBYa2FHaW5iY3BoQlFoTmI0emZzZldU?=
 =?utf-8?B?cUtoaFFINVVTbzZTLzlEenZya3l4Zjh1ZGp4VVlxMlpuQlVTVjZLZGRhdHU2?=
 =?utf-8?B?d0ttVlRtWWRNWHp0T0tMTlVmTHUrbHpocWp0UXQzMk1lK1ljWXhHc0tISWtH?=
 =?utf-8?B?eEVQVVQ0TGZnd05LdkVOMXJIMGRUa00zSEk1TGZiTHlGc0M4eWxnUitabUJy?=
 =?utf-8?B?MGZZUXRJUTEvYVY0WG9uOXFYWUdLSGVoNmxNZkgzZW5DM0FSUnphRE41bGJs?=
 =?utf-8?B?OXhVQ2I5WTR5Q01VQXoxL3BzZUJDRmErZThGb0s5VWNKajNvYm45RHZFdllp?=
 =?utf-8?B?YzE4c3BrMzI5QTl6eGVBWFFjVVFseHU5L2I3WmpKL2tKWDh6dG4xSzNRN29z?=
 =?utf-8?B?THF6Sy8yQ2Fid2ZpMVJhZ2JqbW5FajVXR0dIdmZTQlhFZ3ZnaFF4YmpLTm1D?=
 =?utf-8?B?NUE4ZWhLdGJPbHA3ODFhVnYvUEhpemtpMDR4M0FPUmhpMDdJNHdsd0lYRkc0?=
 =?utf-8?B?ZGYwSDdKZ3J6a3o3SUErc3BiQkpnczYvNmZVemMwdXVKUk1CMXZXYmgxUWdo?=
 =?utf-8?B?TmlydzlPanlRODMwRXpuQUdFanRvRCt3ZmtJOE1ZOUllVWRuKzB2eTN2dHBC?=
 =?utf-8?B?bmk1MFNvRVpyZktKTEJGMTYvQ1JhaUtRamNhZzdhakZ4Si9ZZHplU0NvTDN5?=
 =?utf-8?B?eUJkendOd1FONUVpQzV4a011TEF4Vm5NVXZJUjFHSnRJa3lxYU5QeDRoYzhv?=
 =?utf-8?B?M0pzNjNqdUFneGJxcjdpOGp6czBoOHU1dmdoNUxMMmRmeERxcXBvT3hveHVj?=
 =?utf-8?B?TU1OSXpmUy9lS2F6K1FJNlcvdVd5QTcvbnRJL0VhaGdlYnY2UnhFWm9TWGlm?=
 =?utf-8?B?RThRZzZCS1VuWjhWUXlqWm1waEorY2kzTWJyNzJTUkNvQndEL2VkU2Q4ME5R?=
 =?utf-8?B?T2VFNjQxbi9ndGlVNGY2N3NoYkJURElOb1FOTlpiUjRpZG10V2VuWGdSRW1s?=
 =?utf-8?B?WjF6OWE5VHlyaE1hd2g1b2lKZjRJWnBHZmhmYnVrRGZOamlVMDVmRkU4S1hw?=
 =?utf-8?B?TDhVVDFiWW9mblpoV21JR3FSWnJsdE5DclNFdjh3M1NUTFN0cXZ5ekp0VVVB?=
 =?utf-8?B?UnAxUmFYYmRTVCs0TE5JRk9RblRodTRoWXRtMzNNNmVTT3EvL1NPQ2Q1aVBp?=
 =?utf-8?B?RXo1OEttYk4vdWVGc0UvV2s4dmRJREpGczFiZnBqQjdOMXUyR09yOHNzSllW?=
 =?utf-8?Q?OvBP9UIe5NUs1imRgrzVLcuLjOQLygJsmJYuFyXZkw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a92d27-6b2c-4414-07b3-08dd1d164639
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 14:39:26.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uy6xFOQWu/dwGSpjFta1e8Z7/A6OeHWJa3BMmVJwYGpqwLhKt/VpSpMzeHcB4mT1q/ML22GwpKZNAxQb9YrSFyG1A3hdtSN9EWeGL8eFN/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9081

On 2024-12-15 08:47, Steven Rostedt wrote:
> On Sun, 15 Dec 2024 07:42:35 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-12-15 05:05, Steven Rostedt wrote:
>>> On Sat, 14 Dec 2024 21:19:01 -0800
>>> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> [...]
>>
>>>>
>>>> Just disable it unconditionally.
>>>>   
>>>
>>> I can do that, but I'm not looking forward to seeing random crashes in the
>>> trace event code again :-(
>>>
>>> Honestly, I did not like this code when I wrote it, but I have no idea how
>>> to stop the "%s" bug from happening before it gets out to production. This
>>> worked. Do you have any suggestions for alternatives?
>>
>> IMHO, deferred execution of TP_printk() code in kernel context is
>> a fundamental mistake causing all those problems. This opens the
>> door to store pointers to strings (or anything else really)
>> that sit in kernel modules which can be unloaded between
> 
> Module unloading will clear out the ring buffers to prevent issues.

As a side-effect issues caused by module unloading won't be
observable with tracing.

> 
>> tracing and TP_printk() execution, or as we are seeing here
>> pointers to data which can be mapped at different addresses
>> across kernel reboot, into the ring buffer.
>>
>> If TP_printk() don't have access to load data from random kernel
>> memory in the first place, and can only read from the buffer, we
>> would not be having those misuses, and there would be nothing to
>> work-around as the strings/data would all be serialized into the
>> ring buffer.
>>
>> In LTTng we've taken the approach to only read the trace data
>> at post-processing from user-space (we don't have the equivalent
>> of TP_printk(), and that's on purpose).
>>
>> I wonder if we could keep the ftrace trace_pipe pretty-printing
>> behavior, while isolating the TP_printk() execution into a
>> userspace process which would only map the ring buffer ? This way,
> 
> That would change the entire use of tracefs, especially in the embedded
> world. Note, this hasn't been a major issue since the test/check logic was
> put in place. It catches pretty much all issues with the delayed printing.

This is not at all what I have in mind, so let me rephrase.

What I am saying is: is there a way we could execute TP_printk()
in userspace mode _while preserving the trace_pipe tracefs ABI_ ?

I suspect that inserting this small userspace program into the
kernel image with objcopy would be a start. Then adapting the
usermode helper code to run a program from a preexisting
in-kernel copy could be a second step. Then modifying trace_pipe
so it blocks and communicates with this helper program to
consume the formatted output would come last.

Thanks,

Mathieu

> 
> -- Steve
> 
> 
>> users trying to misuse TP_printk() would get immediate feedback
>> about their mistake because they cannot print the trace. We could
>> print a dmesg warning about crash of a usermode helper program,
>> for instance.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


