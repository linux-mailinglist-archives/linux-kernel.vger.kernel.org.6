Return-Path: <linux-kernel+bounces-325956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01065976032
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30930B23B45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA5918890C;
	Thu, 12 Sep 2024 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Gdv3EY7t"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1880B;
	Thu, 12 Sep 2024 05:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726117332; cv=fail; b=KOlZgX+0vfaRiuHfi7G0Kc8JS7LfqsmnCsD5cf6C/ZuH61lfB+qkCJg5kUmndcGF1FoH0MxRx+PHYX8cmgfGXENw+r4Kbgb57xsoB5pwaD5kZuTqQI2Gwmb1wrc7+4m8LwKTosoIQWRc9v1/vctGYsCYUGvT4cQbNXRb25lvDug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726117332; c=relaxed/simple;
	bh=cASWZ4OI9PVTj5UonPtIj3K4HNLGpCJ4++xwwm9hcB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NTkhZOtEG5VRwR9eZPqbNVEvZo6Dr9JFZdkHhbh0UB1+FPxiJ5QxaBmVTVazWFkBvaW6hZz7QvOEY4U7nWYQBUi6wymYseXpeU91F0ttPxzyf27qQS35tJQGv0ppxo6yDxqu2/vIzWCOkYCMAMCwjMnZtf+lZdYL/9LkKTfpH/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Gdv3EY7t; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7Ob+6pq/0G8tf11W2caSkju7Ry5ywmutyuUJNJAUhD78bHqM6l22bcU1FKQQqgGwCPMaRkw33rYD81yJRiHjRQ/MsADXcUWVJgANZioYNv/3MXvnXQA8NMhJwWXrUI8Xfj6YhA1syAx0++2RN/qgagIkaESt9V0zhgZIIRsXzqkZsDoGMru45YsNIrgkOQij1qKJPL62K/gzGl4WCJNLpBfZXnEprL5M2kKIlHlW2h966Ys3upzAmMMlaBsXMViEREnj5TLMc/B3IP+nox3twpbM6X6JGLa+Uiwjv4uOhv6pQelvvryJDmlOzr1se4ZodkQwLVM+GN11ciPb7BNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnQhrj6RPHOBLtI0F22qLfeM05bY2pIUO8LgulMdylU=;
 b=FjGT0tEPmfGYN98QrWMgziqUDedhs3wrjka1mzvUkVZoXvk6MsiAJ3b6mrpPTVJ0iyd0BBrNwu7lqFBp6Y18258HE0Q23dl9JG3coPTOK8s/qqJkZcdVh4DrWO7Pb6+Eiuz3mKdVaBqmY9lzRB7ycKj6/Ti5uF2xHV1PY3epGHQ2XAX11PkQnj5hN+ft16kQKXBTDm0RQbe4MlcGrhUP2c1s9p/yR7GYuBF97jRs0hqWpjaKTk7zcNxYMHUK4YejuQfvx7wt8fdx8tl4DLyeKKQAFcekVarTitA9b/iw0yLR1XjdtHUzVMMAk52vU0StxMgaJJ/RkvH7uyryKo1QAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnQhrj6RPHOBLtI0F22qLfeM05bY2pIUO8LgulMdylU=;
 b=Gdv3EY7tifkW3h7DO4xD3RkqgojH+vAsrOxeyuodKK07cmwCe9HL56YOCC2+8PE5VhIhmlcRvEOD3pJIQHaWXa1nIssIwOosGQ9OoB1plQugE6Z31++UmulAwcm3kFSMWOEq+EU2uxCylDgBcNKk9o5jreLchQ74GZ0zXx1Us/fdPyt9nIYUrEpj5hXSNJd+gijBCEFjBMaTACO0GoY+XawadjyO/xnjpudhKAQj4zTbVqgZ57bbZY4PHxq1/rhXVavbUJlMHmyphxS6BzJ2DNCLgU1Ef3yyZvsTmWsdtQCFS6HuEEjkJOTvvkg5ZqcUsAaANAwi7N6fwyXuyZUx6A==
Received: from AM6P193CA0116.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::21)
 by GVXPR10MB8630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 05:02:04 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:209:85:cafe::e9) by AM6P193CA0116.outlook.office365.com
 (2603:10a6:209:85::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 05:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 05:02:04 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Sep
 2024 07:01:48 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 07:01:50 +0200
Message-ID: <a47252d8-2833-49e3-9e8c-588a4979cbd3@de.bosch.com>
Date: Thu, 12 Sep 2024 07:01:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-docs: Add new section for Rust learning materials
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, <corbet@lwn.net>,
	<ojeda@kernel.org>
CC: <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<benno.lossin@proton.me>, <a.hindborg@samsung.com>, <aliceryhl@google.com>,
	<workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<bilbao@vt.edu>
References: <20240911185931.16971-1-carlos.bilbao.osdev@gmail.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240911185931.16971-1-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|GVXPR10MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf8d3d7-8e02-42ca-1ab1-08dcd2e80b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGthSndiSEtPckNRK2tLbHA0QlRNZm4yTzRPS3ZKeXYvMkViRW85dUk3c29O?=
 =?utf-8?B?Y1BUNWtML08wWWE1bDluY05sMmpGS1pLRXo4QVAvOGxqMXptR0pLZ0dsS0lG?=
 =?utf-8?B?TW44VWt5dngxOVpnOEdjUVdSVzRRREx4MGhVbWNzTHFodTI4UXg0S1JzbDFC?=
 =?utf-8?B?UjdSNzJhaXpGNE1PeUlCTHJOZDJRMHRrY0gvZFpRQmEyS2tnbWlPdzR6VlBG?=
 =?utf-8?B?ajhHM1BJNDAxcndGUVNCZ1FMblBBWkxWam5COXd0MjFhVWFJTXprQUdjalpO?=
 =?utf-8?B?QUE5UFVsWDRzdm9TQXJpTFNPVG9Pekd4WlZwOU5CeXRuc3hlWDNZY3FsclJ4?=
 =?utf-8?B?SHFSQ0VLdlNyWkJzRVJUbzZTa3RvWC8wVWY3UFFNU0hrbzRTSll2bDJNdXMw?=
 =?utf-8?B?YzBwM254TWcyVHg0MVRHK1dGUVJJTzdKU1diUEJlMmRvOERtYXJmOEE0VGdR?=
 =?utf-8?B?bjd2WnV3dEJzT2ZtSDN1YUdwUEM2SW9NSVBXMUlhWFZuVDAyMkYrcXdDUnBI?=
 =?utf-8?B?WldIRko2QUQ4UW9IWkdmL0p3QW54UXlNak13M1Z4MWJMb2FSR3JKaldQZjVu?=
 =?utf-8?B?M1cvS2IvWXRSOXVSUVM5UTBZalJ5UVRydlBMTXM4Q1RUN1JobXFjdmZ0RkFB?=
 =?utf-8?B?azhJU2tDd3J5Y1NTK01USEp5ckJkT29ERTUzaDdBdVZmc1crVzNLSXFkWDk0?=
 =?utf-8?B?c0pCN1lUTTAzUDAvaU1BOTNIaVZNS1pzT2dPUG90amtaY3cxblBtVE5HbFkx?=
 =?utf-8?B?dDQ0dUNSQ0lDWFp1SGJJWHBQNzYwQ0hzNzh4d2hBclRuSEp2THFpWXFoYy9z?=
 =?utf-8?B?M2FIeDBQeW9CM3pvam5SMlB3RkVPcHBJZ1VSTWtoVlFtZmlOaUpoQ0ZuU2hZ?=
 =?utf-8?B?VDVpSEtObC8rSVJnT25xdWtIcUczb2dtSWIxNXNkOUhkYnlVUGJ3ZDF2QXhk?=
 =?utf-8?B?R0h3blVXdHYrZDhkeEg2VWg1V0NPQlJZbGY4ayttcGtSOTJ6TWJzT1ZBY2dB?=
 =?utf-8?B?b1R6bytsRVBTRDIrbDU0dzlQN1lVTlZUazI1VFd0aW5hMStjcktWZFBtNlN6?=
 =?utf-8?B?VWFKQVFJaHJTV2g4VWs0N0NnQllWaHJzUk9jYk5XaTlyR3BlSWVrQW1uQW9C?=
 =?utf-8?B?NW8vSEk1UzVjdFRqWFB5SDNEaU5MK1NRQVVlYWhyZzhlU2NOUzE0Vi9jYUpB?=
 =?utf-8?B?VUg0MXJLTnI2UDRFeTFBdktINjVXbFhYSy92ZHJaSTVLaXpBZUpiLzhWTUZx?=
 =?utf-8?B?RXpiSXFIc2R2aWl0TVNtK0JiU1lXOUV1dmx5ZGlBZSs5MnJMNU01dFkwQ1Fv?=
 =?utf-8?B?MU1adTBxK3N1Q0VQbCtZR3FtemROQTEyMk52N056VXVQZmNtQ052ODZMbDB6?=
 =?utf-8?B?WjRpbU0vSWRWSUIrcHlxVXpEdS9kUXYyWGVrMC9HNFpWMGZMRk1PbmYzYzhX?=
 =?utf-8?B?aE1YQWF6bU96dVdoeCtCaGk0Y2d3LzFrSjU3Q1ZISlBMZmtGckFycDBRdGVo?=
 =?utf-8?B?dWVnNHE1R2RWNkRHRFpBVmFxZ2dUVGxxaU9POUMyYjJ4ZThNemRlNGIybWhD?=
 =?utf-8?B?ZFJMbTVvWjhMSDlweUdpWGUrMnlaNStudVJNOEdiN2lLaTEzWG00b291L3Vz?=
 =?utf-8?B?ajBIWmY2RmJISDRZVkkwMU5UQytZSHo5eTZ0YXdiNy81ZC9WdTNOYnZOdS81?=
 =?utf-8?B?VVJVdmZCSnhXSFZHU0dGUW5KRjVLSTVjd1lHbDhyUjdEcms1eHNaMXNmZHF4?=
 =?utf-8?B?VTJnVTJ0RjczNFVNQ0JRRm8xQWFzNFR0SXl0NjNRMkJ2L2RkRGlSVTdWNzJy?=
 =?utf-8?B?R1czd01WWWdzc29Pd0xXZWV5TnNZVUZoNnd1enVKUlVqTDFSc3J2K2RVa3hK?=
 =?utf-8?Q?GO1W2Yek83bUp?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 05:02:04.6560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf8d3d7-8e02-42ca-1ab1-08dcd2e80b8d
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8630

On 11.09.2024 20:59, Carlos Bilbao wrote:
> Include a new section in the Index of Further Kernel Documentation with
> resources to learn Rust. Reference it in the Rust index.

Many thanks for creating the patch! Looks nice :)

Whats about adding

https://google.github.io/comprehensive-rust/

https://docs.rust-embedded.org/book/

additionally?

Best regards

Dirk


> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>   Documentation/process/kernel-docs.rst | 111 +++++++++++++++++++++++---
>   Documentation/rust/index.rst          |   3 +
>   2 files changed, 103 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 55552ec4b043..d917accd7fc3 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -72,17 +72,6 @@ On-line docs
>           programming. Lots of examples. Currently the new version is being
>           actively maintained at https://github.com/sysprog21/lkmpg.
>   
> -    * Title: **Rust for Linux**
> -
> -      :Author: various
> -      :URL: https://rust-for-linux.com/
> -      :Date: rolling version
> -      :Keywords: glossary, terms, linux-kernel.
> -      :Description: From the website: "Rust for Linux is the project adding
> -        support for the Rust language to the Linux kernel. This website is
> -        intended as a hub of links, documentation and resources related to
> -        the project".
> -
>   Published books
>   ---------------
>   
> @@ -220,6 +209,106 @@ Miscellaneous
>           other original research and content related to Linux and software
>           development.
>   
> +Rust
> +----
> +
> +    * Title: **Rust for Linux**
> +
> +      :Author: various
> +      :URL: https://rust-for-linux.com/
> +      :Date: rolling version
> +      :Keywords: glossary, terms, linux-kernel, rust.
> +      :Description: From the website: "Rust for Linux is the project adding
> +        support for the Rust language to the Linux kernel. This website is
> +        intended as a hub of links, documentation and resources related to
> +        the project".
> +
> +    * Title: **Learning Rust the Dangerous Way**
> +
> +      :Author: Cliff L. Biffle
> +      :URL: https://cliffle.com/p/dangerust/
> +      :Date: Accessed Sep 11 2024
> +      :Keywords: rust, blog.
> +      :Description: From the website: "LRtDW is a series of articles
> +        putting Rust features in context for low-level C programmers who
> +        maybe don’t have a formal CS background — the sort of people who
> +        work on firmware, game engines, OS kernels, and the like.
> +        Basically, people like me.". It illustrates line-by-line
> +        conversions from C to Rust.
> +
> +    * Title: **The Rust Book**
> +
> +      :Author: Steve Klabnik and Carol Nichols, with contributions from the
> +        Rust community
> +      :URL: https://doc.rust-lang.org/book/
> +      :Date: Accessed Sep 11 2024
> +      :Keywords: rust, book.
> +      :Description: From the website: "This book fully embraces the
> +        potential of Rust to empower its users. It’s a friendly and
> +        approachable text intended to help you level up not just your
> +        knowledge of Rust, but also your reach and confidence as a
> +        programmer in general. So dive in, get ready to learn—and welcome
> +        to the Rust community!".
> +
> +    * Title: **Rust for the Polyglot Programmer**
> +
> +      :Author: Ian Jackson
> +      :URL: https://www.chiark.greenend.org.uk/~ianmdlvl/rust-polyglot/index.html
> +      :Date: December 2022
> +      :Keywords: rust, blog, tooling.
> +      :Description: From the website: "There are many guides and
> +        introductions to Rust. This one is something different: it is
> +        intended for the experienced programmer who already knows many
> +        other programming languages. I try to be comprehensive enough to be
> +        a starting point for any area of Rust, but to avoid going into too
> +        much detail except where things are not as you might expect. Also
> +        this guide is not entirely free of opinion, including
> +        recommendations of libraries (crates), tooling, etc.".
> +
> +    * Title: **Fasterthanli.me**
> +
> +      :Author: Amos Wenger
> +      :URL: https://fasterthanli.me/
> +      :Date: Accessed Sep 11 2024
> +      :Keywords: rust, blog, news.
> +      :Description: From the website: "I make articles and videos about how
> +        computers work. My content is long-form, didactic and exploratory
> +        — and often an excuse to teach Rust!".
> +
> +    * Title: **You Can't Spell Trust Without Rust**
> +
> +      :Author: Alexis Beingessner
> +      :URL: https://repository.library.carleton.ca/downloads/1j92g820w?locale=en
> +      :Date: 2015
> +      :Keywords: rust, master, thesis.
> +      :Description: This thesis focuses on Rust's ownership system, which
> +        ensures memory safety by controlling data manipulation and
> +        lifetime, while also highlighting its limitations and comparing it
> +        to similar systems in Cyclone and C++.
> +
> +    * Name: **Linux Plumbers (LPC) Rust presentations**
> +
> +      :Title: Rust microconference
> +      :URL: https://lpc.events/event/18/sessions/186/#20240918
> +      :Title: Rust for Linux
> +      :URL: https://lpc.events/event/18/contributions/1912/
> +      :Title: Journey of a C kernel engineer starting a Rust driver project
> +      :URL: https://lpc.events/event/18/contributions/1911/
> +      :Title: Crafting a Linux kernel scheduler that runs in user-space
> +        using Rust
> +      :URL: https://lpc.events/event/18/contributions/1723/
> +      :Title: openHCL: A Linux and Rust based paravisor
> +      :URL: https://lpc.events/event/18/contributions/1956/
> +      :Keywords: rust, lpc, presentations.
> +      :Description: A number of LPC talks related to Rust.
> +
> +    * Name: **The Rustacean Station Podcast**
> +
> +      :URL: https://rustacean-station.org/
> +      :Keywords: rust, podcasts.
> +      :Description: A community project for creating podcast content for
> +        the Rust programming language.
> +
>   -------
>   
>   This document was originally based on:
> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
> index 46d35bd395cf..01f09216c229 100644
> --- a/Documentation/rust/index.rst
> +++ b/Documentation/rust/index.rst
> @@ -42,6 +42,9 @@ configurations.
>       arch-support
>       testing
>   
> +You can also find learning materials for Rust in its section in
> +:doc:`../process/kernel-docs`.
> +
>   .. only::  subproject and html
>   
>      Indices

-- 
======================================================================
Dirk Behme                      Robert Bosch Car Multimedia GmbH
                                 CM/ESO2
Phone: +49 5121 49-3274         Dirk Behme
Fax:   +49 711 811 5053274      PO Box 77 77 77
mailto:dirk.behme@de.bosch.com  D-31132 Hildesheim - Germany

Bosch Group, Car Multimedia (CM)
              Engineering SW Operating Systems 2 (ESO2)

Robert Bosch Car Multimedia GmbH - Ein Unternehmen der Bosch Gruppe
Sitz: Hildesheim
Registergericht: Amtsgericht Hildesheim HRB 201334
Aufsichtsratsvorsitzender: Dr. Dirk Hoheisel
Geschäftsführung: Dr. Steffen Berns;
                   Dr. Sven Ost, Jörg Pollak, Dr. Walter Schirm
======================================================================


