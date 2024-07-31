Return-Path: <linux-kernel+bounces-269506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BBA94339B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68161C21D25
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9CF1BD018;
	Wed, 31 Jul 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="hAqBz+ZH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="jGoAXE+E"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8551AD9CF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440714; cv=fail; b=csilZVqBVdP1ay6bl8i0JeISUEh30To/NoWzoUMmTwOHOdXrIBL/uxiIhkxbRw0eS5LJ0Fk6pmOug2kEvbB+4P4LD3KfoDdqg+Z9J8QrEDN8Ljs7ivf9ETZJJnkmSub5VjG6FYjHZLgR9CKtryIHJ2KCVJrLT0XtLqWcRxQwkfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440714; c=relaxed/simple;
	bh=OP5HnrUAFmyTF2AOpffIpYr8ZTfrDgVU6PcCcVPBxVM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DdatfNJv1OMAbBjET36JpGkDdJqYISOyz7Mgn3jckRcIPwxxieHEh7pBdK+Fpuv8aAtY21kLyLA0NWndRZLqvpLEtV2NcOSoxO+BeYzC2HMQo7UN2g6GNZc3D74DWV9VErRoxaCmQrSC8XxBN/hdGOVEf9wfj3t8xB2I6wH7rW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=hAqBz+ZH; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=jGoAXE+E reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 719762F82F7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1722440330;
	bh=OP5HnrUAFmyTF2AOpffIpYr8ZTfrDgVU6PcCcVPBxVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hAqBz+ZHXAFRGuYTbLieL3CUjmak8TLZD8cLMRzJ6SonH8IR7pQ7D+4p7jEvr5i4B
	 e+kYUYkuXDW19TMUmFogx/CjZ5pBOA/baCRYsvg3sDaVGaNHN4avbBDUr34SLypdyj
	 MG0cNSxEU4R4Ntp/H8eoZcar+ARF5tUHNAL98e40=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 41F3D2F85EF; Wed, 31 Jul 2024 17:38:50 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011027.outbound.protection.outlook.com
 [40.93.76.27]) by fx302.security-mail.net (Postfix) with ESMTPS id
 A09E52F80D3; Wed, 31 Jul 2024 17:38:49 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PASP264MB4979.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 15:38:46 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7828.016; Wed, 31 Jul
 2024 15:38:46 +0000
X-Secumail-id: <14861.66aa5a89.9e70f.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMZHdc/OuQ7uWzGwwinImO6vdzbmJYpOv7gWzFYcMorgHjgy+s7epp09UuMaFONwpIag7AYlgTagN59BZSsKk27tWA+36TCzoFAWmweFtKu2bFvOYxM5TRU8Y07c4eE2XsrOezpXiLhWXWILph1JTb91LcHuhNpLNbUxW6XqJcWP0O1dBnxJNPEvPGZL8sopN8OJq1o2q/f5zzS7/AgSk8Gszs3bn5cHlYNtgBTMEWo3NdgN7rAkIahBcj4mdQk7fC8L7Zn2tuzi0hGPdBja38fv/Om+vIj8xb2TwxN0tvUsatR+cAhlNZ8NeTOVg2KEslDZ9wP4vI8cSvfQtxQatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc61yfRQFgd/qK/OPzW6cTVV/ugRpXGiNFkykQVTjNo=;
 b=WJUh32T9qcYLsf5EfxXqe70+ar2C7VEy037RFydKpjtYhkj/oFzCOq4arx15109GU7FTMmvhrVYjLKCIpskPT1zXLz10sKO2KjGeYtXxTO+VfD4rLrvVJ7aomTQyzuwv5iBjWe0HqtO4FKwWKFgYnz86h64em+YI6qEANTvUcUgnS0Pa2D4b1vN9L2xDCj1JroUXAsMT+yxuqtyehuoqgC8oD3TNHckrBqM+wK33RjiIRzj9U47aDbvY3y2RFkKsJFLxwe+oRm2HCUgaLDlNklCy0+ZK2Lp2n0HBVi3ylzOk0eiTDp/tyGIZVgii/t2rU2H89WQ042C0INFn6QuDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc61yfRQFgd/qK/OPzW6cTVV/ugRpXGiNFkykQVTjNo=;
 b=jGoAXE+E7/xRU18QqxjCnDd/TPLR5rzmkim6TV3Vy2lbDUBC8HnoiI/c788diLoVATnky/a+2v2g16xqx66eaBC0/KVcy9w2Wt8HI3HhV1+0Bk5iUcUS4lACqhh/sz9xU+n1TxTSaLkFCTXA1g0x75Qj99nYbM80YMxqMBYkfQTPTLXMbnXQZgcMwTwEwFQvdi08BoBs4S9wA4QILtgnbVBmFdYAOHlxJbx7FrFmRqkzLFmWAC8t6R0w0OW1q5Z1aH+6B08k3uFANz3f7vi6yXmRFXUKcGST94qTzNyi8N8yZUiZ6rt07GB2cZH7KQ6X4qUcrC9J4TPHnoqtzzBQdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <434c5199-613e-4765-af44-d7404a4554dc@kalrayinc.com>
Date: Wed, 31 Jul 2024 17:38:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 36/37] kvx: dts: DeviceTree for qemu emulated
 Coolidge SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, devicetree@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-37-ysionneau@kalrayinc.com>
 <d93f93fa-bbc8-4b89-9abc-767486bc443c@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <d93f93fa-bbc8-4b89-9abc-767486bc443c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::8) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PASP264MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 609f42f2-37bf-4d52-829b-08dcb176ddea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: vjrVJpPE2m7s0sEEi5h7NdWWb74F1nPiFRTYDYQrjmGi1/IXVO22X8Qet/GupKFmNRxDJYtsGxgy/6L0CYVB6jQ3Wsu784nVqNLIRG++lzL0Vu38t8+Q3jCI/yIa//U/kzD/diwvqLmu7FJyq64X7x8ALn0reHA4qhWgNUMaHDArLj1RfuA1rhbLSqfIttpo0JDyuPcN8QPS/CQTRA9HUWGb7UnRbKM2oLn5VbT2ZWXOa02KonUgwaHynJlxgKDy7GkjeXo+W2YY92jWzdU0Zc4Hu3mhQbmmsmg3j/CtuWaOjtMFxDd2WFkVp1DjLFhgJsvRBLyFTf0XYFaNMfBtWPe1of3dr9NCZBhZ4xD2P86Shf+2BEqq7Fc1MmYyybIS9z7OHXDxMPbeUwT3ULCQ/qnU6R/OE21+PcVRQU7ZvevuHgeZi3g1vOeC51rQ6HVslE1FwYRo14aFb617IaGaxE2o4gBD8848I2lvjWGQ1n4FP6eivDRj5KXIBkJe2Bo6Jz1OZI39eoFEL2adaGG9F9xV6DOwRGLqquLaf+q+nV78MHDcIDFOI8MAndgYdQPZMFYlcMgO8qpOUdjkp9JRnej+uVkIU1TofJUIFOEvNpOuAcpnIh5fjfIlFsYYnaOAEuyhjdTUbwODKBFtq6dXoA5B+rz28KWNypVwSqg2L+JsGaoIRNOOM2TJp4tKAUtml9R9/XVxE/u/xdYuPP424QBXWZYbhRq1u29om/VN5HtBfwt4VulwZBjr6h7Vr3VlyLCgB9fdCBDuTf8wt7Lfbi1w8hz/8JM31rCiivEb1iqH0eDF76mIVN988nRUr2dmo8fWPjrKftzPyi2w+YZ9LLO//Mwd1UdtxzuHuT6TZIz+yRD2H7RvZ2P5rKCG+3692I2wQf16eqTbKmMBRnh8AVQIKxDDUG56R6CAWhVW/OEOHB8Jovj21E83nKxaedcnH71
 ElJE4qvVLDpwJsJLv2j1ZOyfZqveDj2bFxkdwOAQsmRlt5QqFdHUQn7N06ZYsW/EZ8BnHNbGPy0TuoUEbYuc3lQGWDY4ziVD977BK5cwE1trhAm/amnDHKcH05TBKFJRZz4b3aANNXwWy4E0lp/aB/iljS4UGxlpBcccbuaPRHPSsoXCfudRwai04FEY11czaIehsAOSJPftOfok8UK0xFBQRqn3U30A6IBib1oI82Vq8cG8I76VmWEZWGtEJFUKU0tcnr04+nG5zpcqd8Dgi2sJ4CDYhDsYXzS3MTk+5AZDOSewzDnoQaGkePkb/nx6m98UNu/6LnOItAIBICLPyh5JuvMEyvIM26UIBpxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jH5SNLPorN9ttRmUOreWLfAPsDB7HrvtfudLHhdMZ2cwlhl+y97zm7hkWQdynkinZswiMLGXXCvlGuKaIleqmwYds0eeWbsg0eO9U6IofXNUZbnUbRUpKYyo8f4gqAOHXaq1OouflJVFLC+iYEIDacFvDmiW7dNWhWqRcsB4yEmyn8tzzeYMs/q0bTa/euyNF2twel/gRTTBY4uvDOkkgF9qgWFUkgpA3LuCmTqbWtRW3z7cHnQdjx8dzXu6OBlh/7ysFIj94wW7T/8IbWJfRDryhCm96OxYqDkXjSHwC+dD43PDpAdDdivQmnwWbQLAG6PlBojeMRclFmWw6/uDAsb94ZEN+jEifFG+0KLzXT9EknBX4+pbzUe/Z5JwXmQYDHFcMzctD4FtNsb2k5iaPZXBVmRJSEJwYRDFOm0X00/T3NwikfU7cMCCcMe8i8ssX4RfyYbF462G72ndr5I5kd3a05OI3ihnRkkwJYv1UNaR3wuBpOkAjqcP02bZZJyNFegPdBa1UotwOMVM/14Jaa6sb6kNmzj4yP3t68oTsICNPQ53+WBsdtjqw/wLTgj9cmAvf5fm81b0Mc+TE6HC80rFW/h/NM/KjqjMb851DvD9+8gn7bgwe8T2X+7rIBjEo6Y2qb/dGtNnqssqKmkuBOSchvfDy4WXDQ3mWbTrcbpilPBr3Eh58ajXuGk69zijLBQ16jzw8g108Cblrwp82PLkT80/JEpwriQhIgBCjB2qXjKgEP6P9Dt0HjclhypefWs7CBhEwR8nvA5I7LIP9aLfSTwZtbU69fyYhuUfDtObT/dNNGrZ3d7/o6s/qY1MpTW5GRo+ElyIhiHLkVoFuv1gbWRidug7t/tBUcshU+LJtkVsJxaneVkjhMlkD0GYZ/pGsW7RmdvC8v+sgR50QroSCY/FnhnVqGeLpWwugzjAE/pOZdopq2yIuhDAXEwj
 cW32LEdBsP4E40372hfTxBgbnXQQU+xoVwTHnZQKMOMvTFhfnETLWuRein/gzYDmfUVvcQxW8cghp7flgeIB1Yt8G4Ft/9bPLWe+Nutrqz8u595/mySDyNj09Zj0ExqX5b7NdtSTqcDVZcyT82q7iDOszRyg4YvZ7P1nPiOTItqaC5kCeShfoLLUxnThRZiBgBCQX7vPBxfZcBF9ia1QslicZObox0C+j3zwJXVYw5Mm+2Iw8+7HGc9xRijf2VWmGFBg6W3cCgjZXPFYJAh+PeC6z/7msgcK9QAfbL1lvxYDa5GNMEiibPzpFpv+chNnLC2hN34G+cx9IXbM+ErQVquBTivbLyFzwwI6ArxC6TAjaQ+KwaF+lBEsfy4MgXCTKVjCBT5sP4JVV54mmQ7CSIl6gYnU49Fcfxalj6+nB6bUH6wRBRocOGVjltGJ4lMT935YFdy1OFiHEGdZZHly4hbUVk0PMAamUIdjiCl60rUAvjqfJU12iao3qOxaXaVq0QU6XoMU+v8WB223DKHCk03ndd/sbZOx4iJPgXyVH/0G+CP5KvvRjr0vBVdWbh/3PHmNHerHzwWMun94JLNIBxhwGjM6rBxp7KHPZ8Gb8tdpOgUm/hp90hcF4EmEZWmMLI4LHgmx6/a6FzH/tO4YHpkNeOkj//jnSBMfmCBYI2vVrCnGCdQ0oY6P9SrSWowrPgb1Yorz+gDWSsZkhVMX4g==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609f42f2-37bf-4d52-829b-08dcb176ddea
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:38:46.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRzUqiRfgLD2j0lDJn+R+O2n5l8q5XWwWYhaPaOX+2dl9fUR5u1+EIi/uBJDioDf7EKeVKNGR+JO1nT2r7ZZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4979
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 11:55, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> Add device tree for QEMU that emulates a Coolidge V1 SoC.
>>
>> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
>> ---
>>
>> Notes:
>>
>> V2 -> V3: New patch
>> ---
>>  arch/kvx/boot/dts/Makefile          |   1 +
>>  arch/kvx/boot/dts/coolidge-qemu.dts | 444 ++++++++++++++++++++++++++++
>>  2 files changed, 445 insertions(+)
>>  create mode 100644 arch/kvx/boot/dts/Makefile
>>  create mode 100644 arch/kvx/boot/dts/coolidge-qemu.dts
>>
>> diff --git a/arch/kvx/boot/dts/Makefile b/arch/kvx/boot/dts/Makefile
>> new file mode 100644
>> index 0000000000000..cd27ceb7a6cce
>> --- /dev/null
>> +++ b/arch/kvx/boot/dts/Makefile
>> @@ -0,0 +1 @@
>> +dtb-y += coolidge-qemu.dtb
>> diff --git a/arch/kvx/boot/dts/coolidge-qemu.dts b/arch/kvx/boot/dts/coolidge-qemu.dts
>> new file mode 100644
>> index 0000000000000..1d5af0d2e687d
>> --- /dev/null
>> +++ b/arch/kvx/boot/dts/coolidge-qemu.dts
>> @@ -0,0 +1,444 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/dts-v1/;
>> +/*
>> + * Copyright (C) 2024, Kalray Inc.
>> + */
>> +
>> +/ {
>> +	model = "Kalray Coolidge processor (QEMU)";
>> +	compatible = "kalray,coolidge-qemu";
>> +	#address-cells = <0x02>;
> That's not a hex, so just <2>
Ack, I will fix this.
>
>> +	#size-cells = <0x02>;
>> +
>> +	chosen {
>> +		stdout-path = "/axi/serial@20210000";
> No, use phandle/label.
Ack, I will fix this. However can you point me to where this is documented? In https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt I can see a path is used as example and not a phandle/label.
>
>> +	};
>> +
>> +	memory@100000000 {
>> +		phandle = <0x40>;
>> +		reg = <0x01 0x00 0x00 0x8000000>;
>> +		device_type = "memory";
>> +	};
>> +
>> +	axi {
>> +		compatible = "simple-bus";
>> +		#address-cells = <0x02>;
> Same problem.
Ack.
>
>
>> +		#size-cells = <0x02>;
>> +		ranges;
>> +
>> +		virtio-mmio@30003c00 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

I fail to understand what I should put even after reading the link above. This node is kind of "generic" and could be used either for a virtio-block device or a virtio-net device.

Could you elaborate on this please?

>
>
>> +			compatible = "virtio,mmio";
>> +			reg = <0x00 0x30003c00 0x00 0x200>;
>> +			interrupt-parent = <&itgen0>;
>> +			interrupts = <0x9e 0x04>;
>> +		};
>> +
>> +		virtio-mmio@30003e00 {
>> +			compatible = "virtio,mmio";
>> +			reg = <0x00 0x30003e00 0x00 0x200>;
>> +			interrupt-parent = <&itgen0>;
>> +			interrupts = <0x9f 0x04>;
>> +		};
>> +
>> +		itgen0: itgen_soc_periph0@27000000 {
> Please follow DTS coding style.
Oops, ack, I will fix this and replace "_" with "-" in node/property names.
>
>> +			compatible = "kalray,coolidge-itgen";
>> +			reg = <0x00 0x27000000 0x00 0x1104>;
>> +			msi-parent = <&apic_mailbox>;
>> +			#interrupt-cells = <0x02>;
>> +			interrupt-controller;
>> +		};
>> +
>> +		serial@20210000 {
>> +			reg-shift = <0x02>;
>> +			reg-io-width = <0x04>;
> Sorry, but width and shift are rarely hex values. Make your code
> readable. Adhere to existing coding style.
Ack, I will fix this.
>
>
>> +			clocks = <&ref_clk>;
>> +			interrupts = <0x29 0x04>;
>> +			interrupt-parent = <&itgen0>;
>> +			reg = <0x00 0x20210000 0x00 0x100>;
>> +			compatible = "snps,dw-apb-uart";
> Follow DTS coding style - order the properties correctly.
Oops, ack, I will fix this.
>
>
>> +		};
>> +
>> +		serial@20211000 {
>> +			reg-shift = <0x02>;
>> +			reg-io-width = <0x04>;
>> +			phandle = <0x3c>;
>> +			clocks = <&ref_clk>;
>> +			interrupts = <0x2a 0x04>;
>> +			interrupt-parent = <&itgen0>;
>> +			reg = <0x00 0x20211000 0x00 0x100>;
>> +			compatible = "snps,dw-apb-uart";
>> +		};
>> +
>> +		serial@20212000 {
>> +			reg-shift = <0x02>;
>> +			reg-io-width = <0x04>;
>> +			phandle = <0x3b>;
>> +			clocks = <&ref_clk>;
>> +			interrupts = <0x2b 0x04>;
>> +			interrupt-parent = <&itgen0>;
>> +			reg = <0x00 0x20212000 0x00 0x100>;
>> +			compatible = "snps,dw-apb-uart";
>> +		};
>> +
>> +		serial@20213000 {
>> +			reg-shift = <0x02>;
>> +			reg-io-width = <0x04>;
>> +			phandle = <0x3a>;
>> +			clocks = <&ref_clk>;
>> +			interrupts = <0x2c 0x04>;
>> +			interrupt-parent = <&itgen0>;
>> +			reg = <0x00 0x20213000 0x00 0x100>;
>> +			compatible = "snps,dw-apb-uart";
>> +		};
>> +
>> +		serial@20214000 {
>> +			reg-shift = <0x02>;
>> +			reg-io-width = <0x04>;
>> +			phandle = <0x39>;
>> +			clocks = <&ref_clk>;
>> +			interrupts = <0x2d 0x04>;
>> +			interrupt-parent = <&itgen0>;
>> +			reg = <0x00 0x20214000 0x00 0x100>;
>> +			compatible = "snps,dw-apb-uart";
>> +		};
>> +
>> +		serial@20215000 {
>> +			reg-shift = <0x02>;
>> +			reg-io-width = <0x04>;
>> +			phandle = <0x38>;
>> +			clocks = <&ref_clk>;
>> +			interrupts = <0x2e 0x04>;
>> +			interrupt-parent = <&itgen0>;
>> +			reg = <0x00 0x20215000 0x00 0x100>;
>> +			compatible = "snps,dw-apb-uart";
>> +		};
>> +	};
>> +
>> +	memory@0 {
> Why memory is in multiple places?
I should put all memory nodes one after another? Ok I will do this.
>
>> +		device_type = "memory";
>> +		reg = <0x00 0x00 0x00 0x400000>;
>> +	};
>> +
>> +	apic_mailbox: apic_mailbox@a00000 {
> Why this is outside of SoC? Where is the SoC anyway?

Oops, I didn't know it was mandatory to put a soc { } in the DT, I've browsed the DT spec and the "soc" node is not formally described as something special. Maybe this needs to be documented somewhere?

I reckon it's a nice way to separate what's on the board (PCB) and what's in the SoC.

I'll add a `soc { [...] };` in the next patch iteration that will contain what's in the SoC.

>
>> +		compatible = "kalray,coolidge-apic-mailbox";
> Your compatibles are confusing. What is the soc name? In other binding
> you entirely omitted coolidge. See writing bindings (or any other recent
> DTS which passed review) - it has rationale behind it.

SoC name is "Coolidge" and the "APIC Mailbox" hw is in the SoC, it is memory mapped.

But I guess this point is now already more clear since my last emails answering the "core intc" reviews.

>
>> +		reg = <0x00 0xa00000 0x00 0xea00>;
>> +		#interrupt-cells = <0x00>;
>> +		#address-cells = <0>;
> And this is not <0x0>? It's like random coding style.
Oops, I will clean this up for next iteration.
>
> I stopped reviewing here. Rest of the DTS does not look better.

I'm sorry if it looks like a mess here, I am new to submitting DT upstream and it looks like I failed to apply all the rules.

I thank you for taking the time to review it nonetheless and I hope my next patch iterations will be better and easier to review.

Regards,

-- 

Yann






