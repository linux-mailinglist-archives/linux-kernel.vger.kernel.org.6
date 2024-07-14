Return-Path: <linux-kernel+bounces-251864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD4930ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5A51F21B40
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1B13B59C;
	Sun, 14 Jul 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="m+lVMn3g"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2187.outbound.protection.outlook.com [40.92.63.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134081D688;
	Sun, 14 Jul 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.187
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974732; cv=fail; b=ow2yg5RWEwFWeTLePsgarLno/b64MoNnBmJ6Jw2PYlZmjH7j6wZVX4LxQ0NgSBwJrE0112RpKtbTaBw6xYCVINV5YajIwnHfyhylQT48+doEhGlXMJ1bxNAdu+epfZqCrFrOYdYDEUnBt/193xMLGjwhJ7IFchtWQXOCNzWkQe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974732; c=relaxed/simple;
	bh=nGuk2IQpwH2ULoXw4X0KBJ0O21yqoWfZ2coSP4EWO3I=;
	h=Date:From:Subject:To:Cc:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ayr273Wsg1zaWNL8cAUn/ZUiNkmJQWwpk13m1aUPkad8GcixoYU/fXq8jV9d1YrXHeELjlos1uH/x97AOGEbuwndsWzrl1EwvJIthADZ6C1yRiLsJTuBqPoEKpuA8x5ABuQPn7QdBdFXzjHgSR9tToxfsyfTgI3JlaUBCI2sOBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=m+lVMn3g; arc=fail smtp.client-ip=40.92.63.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StGwwLMT1DdQhthzcHUnYp0xdUNL8Ibq+Rtn5nsbfdINuftxggMSUQqUBiq/ki7HzHiLS1aCTnX2mPiCzx58VFlunB2PDzlLt8VUkFbjSrpu1dcddZA23wa6U9P5siLgOf2WNzz/2xqCicIPebParV45JIW8ppwe/3ppK9Ej8Ml7eQw7YFM2WfDZTKqesUFKfzqBWpuuqMwFMC15cip1wFES1zcTYIJFsvS9whsKp94q/7Bbc/gIKaNphlHzquEc1hNG/S0Vh2LIMMMdD5GKhyFTa8Mo5DXPxF502ZFUL6YVkIP5pLYwOvGKxbqbOakqE0o/GySyThCp3XZNvzKbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9ZWI/nAdv+I4jAXBgZ59TYsZkCthmBPTYWkQyBFbsY=;
 b=rkyb7IYHw2RbD1QWdRNOHcCzpIxBkMlHCWDH4s4M8wK61IVOzYFHNQfYYfIZblNA0QyS4RALOZPany7YE8/lD3OyZ5ek9cJItjv31a18H6pOI7CxPQYdXXHgP231mPpFx9RWIf92VREPEUJp2rH1bzyB9XPx+1zv80fh3rw4ubor6leI508MGtdlQ1FJko30Bq6UCKzerMaWnPA1Js/md4+fcUlYIF0q8T8olfGLQzqA6XIXfcO0AUZSeBSKgIroNsKj9tXFoEaDgrOBbgnIsYhAn8j9yiOsuXpMQ0N0DOmYFLlpODVc/m4J5dsY33POPrF3mQJdlc09NqUr59xCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9ZWI/nAdv+I4jAXBgZ59TYsZkCthmBPTYWkQyBFbsY=;
 b=m+lVMn3gBXeZ7dlpr4fCLZJ63hosHCjCpmBB8JBaltuANT6/O2hOLCikwTedGwOlt7wRU+Oj3JkX2pUYxCnkvHrSY7E16MjriTzPIrYCO3/9Y0awrUEW1UdnW/qvvg0aFyMcO4UOe5IIBe3H3FOYwtZ70sphkufNrJLhpV3RR5mkY9DePIqbAutB6UtGGvS/ZHgr1nNauR7ZILhVUzEWBkUqrhIuesjHrA4q9sn0RQRFo+kSnzMxmfVKOWtonnuj/n9VrmnsYBaL0MPVmMtr4hZcDYzdkb8VJNrKKi/KcEt9pfVBm5n6fCBr/RokoNp+dBFMCUaGU2KV9Wp0JZCKXQ==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 MEYP282MB1752.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Sun, 14 Jul 2024 16:32:05 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 16:32:05 +0000
Date: Mon, 15 Jul 2024 00:04:14 +0800
From: Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
To: Inochi Amaoto <inochiama@outlook.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, unicorn_wang@outlook.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Message-ID:
 <SYBP282MB2238F4DEC90ABC939C4D0043C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To:
 <IA1PR20MB4953CE25C805EB66EFFDC36DBBCE2@IA1PR20MB4953.namprd20.prod.outlook.c
	om>
References:
 <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<IA1PR20MB4953CE25C805EB66EFFDC36DBBCE2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: geary/0.12.4
Content-Type: text/plain; charset=us-ascii; format=flowed
X-TMN: [YFx0FO8p4MnEhLlzAIsq9KJwxFLhP4Ci9yHC0tBYCIg=]
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <1720973054.10748.2@smtp-mail.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|MEYP282MB1752:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dd4ed4-0a1f-46b0-8117-08dca4227f3a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	5KXJoKNlMuE4t9dMGtQEYf7kG18Yjj1leJNX8Ka3t3p39qP8qBxWyHhQhLrmhKLS/TBJQ1VCU14jQCYj0vfb8zE9MYdm+zQML+0rFwiQx99KfxohVQL36jfg6HtyUcCY50OkzypEZWn0qQ9bK0hXAbigVHXJfozA/4WVV+OLmwo9lQkuooLcC0gTckyeAKDypWeSHbJZbhPRAwUPXx/hDCU6L3YcrpbtTZixYQotxRFT5TasUeB0aLgzm4vLVyVgFJ8ClFVNNLzOHyLE+oSPJRTNIDbkdPlnI7pvUbLqNOLU1MqWR4esqOJmbFjvSKVmXSYQnIhQ/SdfF2PMr9icUQKHgfTnlUsp7TIHkhL4KssgHMkBMrF/yzANdnVPVjPij9KxIxFI7RCYu+URkv28pHwcRQj2EF0cNRx3BM1219zK9slpCoPorHI2jYfUyvhBv9vnEpmnWA42uMi3mU1Cgenq/yDii8rBVD3MgoXnhfKroRxZ4I9YDBJ5Ab9MuHQsBaca8lkoUdS+J/QBphrdw+J1PjNjDlTGGCgQRrvdfkVoHJBbTz8zBmS9yMjUZYvRdlxH+IUVoCFfDs8EdWFL5HndIUnmsE1HXluz2WE6gLa2i6jojxQAJ0rm63l93VcGVXU/6sIj8utrLn6HJFO1xwFFLWIAq2cWsCt1yYy2pg4Hxp/IqqPSuvMp9/3EMD2xLwqeMNfsjkf43REaGuvNofVUqD4HuJ4CcV4KbcXSbqqOREL5wd5dSZVV2j2uYsmm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sfpMWPItzxXNngF+agvjYm1vcD2JJlwlkw9UoBUg9MUK4uwOYgkliJD89W5Y?=
 =?us-ascii?Q?KOvGunMfh/eYois2m6pwV0cNx5v+vrmI8toG1T0rIIgXL7CdpzQpR8amtz41?=
 =?us-ascii?Q?yPgwuvwlbntZi1OfriGLMI4PXd6HY40OFUaT4nMXWNHlpX5qmTn6fdyY+gVB?=
 =?us-ascii?Q?ApkgQzsoLvmDitAWaUs4XwLqbo7++IFXm/svEiTn1tm3zEVlHkM5IziPciq0?=
 =?us-ascii?Q?WaSPwilU+2KkGuG30W6Z5oGACunEbq93quudvBAl4jquEfvxn3aeI90+0GZn?=
 =?us-ascii?Q?N72okYJLLhPvLj5GD9XaO3Rv01EAhqBGT6/MM3RA0EYBTJU4AgCCcJZtFCqw?=
 =?us-ascii?Q?uhxza/5jmT2bTWlOKJ8kE8N8q3wA9FyVmsC1PY4wLB/DdwDydhJPL5PGPh7h?=
 =?us-ascii?Q?ZswDDIuNMWnmcSGamMqyy3KIvwtefvS3QH0qmwQZAUncAwyoHQeUlEdncCCK?=
 =?us-ascii?Q?R/L+aorDciv9lYX1y8VdDjLxj2o6ceEZ3XqaKrP1cXhrFmsxNDDxW5rBEHsn?=
 =?us-ascii?Q?a13eOvCxQS5/XyXfqi/sjbFkHnTVO+dofjJqYTTcrmfxj0GjP6UrGHcWbQij?=
 =?us-ascii?Q?xcNBHJFrAe3yzDWjl79KcAm6sjDPvzrN4EzKSc6RBLvlLF2XP48U1U1LXHUy?=
 =?us-ascii?Q?cyILieANisxfFYTeFmVz95+iwFuAj/MGpaLN3xO2YIx3S2KniWtTb+0eaxL9?=
 =?us-ascii?Q?q3fgY9aTQMuYJWUHlfO9wkUcyeadvJFW7SrT5ybmaKbUgCndTO75gnCYCnSy?=
 =?us-ascii?Q?9TGODkUDdjuufDWjcdp6sY1pudIrYrVOsQGWpi8cdHxX7fY/osg7TsB88b3u?=
 =?us-ascii?Q?xj43+MMeALgBXjIqeW5GiVThBWOwFFCEmETSXqebzTAmGqrWYLpR3LEYwnX0?=
 =?us-ascii?Q?VWTJXimpe2UJ0BUeV7f7ZX6jmxTPpKgSPvcGEd7Rwx8ykeuzNrkdpsJkbR3d?=
 =?us-ascii?Q?WCf5A1BPA59j1heQSWteoUdpWYCXd2b7jLAWVjYjgJFCQZ/MmMbETI8ZJUiB?=
 =?us-ascii?Q?1Mb1XeqGq4kw4fVn0z/lCFlj8rFXnPbxKfTeU37ZJpWIo0aWLYpTeDef2CuL?=
 =?us-ascii?Q?XuR8+FSx5m4o/LlcnWz2LcWd8pZG/Wylvi4gRiRbO0oBlz5mKXjEjCc10Cc1?=
 =?us-ascii?Q?PQF76sAf4cotljeE0JWIwbNM8IyplCIDvayAHnYCnklrzS00TEoICWp3HFVl?=
 =?us-ascii?Q?zYQApMFUS/mp2x1bnrOUbvzIbtnkrWMDHN0j0EZWS3/rInD5hrsTCO8WcmE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dd4ed4-0a1f-46b0-8117-08dca4227f3a
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 16:32:05.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1752

Hi Inochi,

Sorry for replying late, I have been waiting for the vendor to make 
their mailbox document public, but they haven't done it yet.

On Wed, Jun 19, 2024 at 6:45 AM, Inochi Amaoto <inochiama@outlook.com> 
wrote:
> On Tue, Jun 18, 2024 at 11:12:33PM GMT, Yuntao Dai wrote:
>>  Add devicetree bindings documentation for Sophgo cv18x SoCs mailbox
>> 
>>  Signed-off-by: Yuntao Dai <d1581209858@live.com>
>>  ---
>>   .../mailbox/sophgo,cv1800b-mailbox.yaml       | 75 
>> +++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml 
>> b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml
>>  new file mode 100644
>>  index 000000000..e1868aaf2
>>  --- /dev/null
>>  +++ 
>> b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml
>>  @@ -0,0 +1,75 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: 
>> http://devicetree.org/schemas/mailbox/sophgo,cv1800b-mailbox.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Sophgo cv1800b mailbox controller
>>  +
>>  +maintainers:
>>  +  - Yuntao Dai <d1581209858@live.com>
>>  +
>>  +description:
>>  +  The Sophgo cv18x SoCs mailbox has 8 channels and 8 bytes per 
>> channel for
>>  +  different processors. Any processer can write data in a channel, 
>> and
>>  +  set co-responding register to raise interrupt to notice another 
>> processor,
>>  +  and it is allowed to send data to itself.
>>  +  Sophgo cv18x SoCs has 3 processors and numbered as
>>  +  <1> C906L
>>  +  <2> C906B
>>  +  <3> 8051
> 
> Are you sure the 8051 use the same mailbox layout?
> IIRC, only the small core use this mailbox.

Yes, I am sure of this, and cv18xx SoCs and sg200x SoCs share the same 
mailbox IP

>>  +
>>  +properties:
>>  +  compatible:
>>  +    enum:
>>  +      - sophgo,cv1800b-mailbox
>>  +
>>  +  reg:
>>  +    maxItems: 1
>>  +
>>  +  interrupts:
>>  +    maxItems: 1
>>  +
>>  +  interrupt-names:
>>  +    const: mailbox
>>  +
>>  +  recvid:
>>  +    maxItems: 1
>>  +    description:
>>  +      This cell indicates the mailbox controller is running on 
>> which processor
>>  +
>>  +  sendto:
>>  +    maxItems: 1
>>  +    description:
>>  +      This cell indicates the message sends to which processor
>>  +
>>  +
>>  +  "#mbox-cells":
>>  +    const: 1
>>  +    description:
>>  +      This cell indicates which channel is used
>>  +
>>  +required:
>>  +  - compatible
>>  +  - reg
>>  +  - interrupts
>>  +  - recvid
>>  +  - sendto
>>  +  - "#mbox-cells"
>>  +
>>  +additionalProperties: false
>>  +
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/interrupt-controller/irq.h>
>>  +
>>  +    mailbox: mailbox@1900000 {
>>  +        compatible = "sophgo,cv1800b-mailbox";
>>  +        reg = <0x01900000 0x1000>;
>>  +        interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
>>  +        interrupt-names = "mailbox";
>>  +        interrupt-parent = <&plic>;
>>  +        recvid = <1>;
>>  +        sendto = <2>;
>>  +        #mbox-cells = <1>;
>>  +    };
>>  --
>>  2.17.1
>> 


