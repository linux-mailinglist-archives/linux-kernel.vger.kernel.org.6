Return-Path: <linux-kernel+bounces-255456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C579340E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA53E1C214B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E891822DA;
	Wed, 17 Jul 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="E9wF/+J7"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2187.outbound.protection.outlook.com [40.92.63.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36621CA9F;
	Wed, 17 Jul 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.187
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235743; cv=fail; b=iudQ+bVLXhX+bSv6C+ZOBQ36OjzdPv4LXcO3zQf+2OV46cKPKiR5tLZ6y4YFreme3kF++VAXf2xl5/iK8wB8gJ4mV0cjRKdirKcvN/bgE1qSZdSKqEbbF32VPkPjZ04MY8CwpyXhmw+1gBp6X7lmYbDyYPxMYICiYfPBVAF80TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235743; c=relaxed/simple;
	bh=pTBHW9EKU/jpCkog/LDGYvJOzxxVA7Q64gD2OX9bJSw=;
	h=Date:From:Subject:To:Cc:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zc/CpZ+vPMJvK3o8NTNIL/j0RSsV2olJrxjVr6nOG+werS4gbOatCmsKAa4ZouuzLshmi2MHBC+FmVbhJu20bjpZvJOD9TEPSYDfhAJWb4mxRE73WRwOgrv1PZ4S2Hpk+gcu0cuJCsyVnfBUsrLxpabRYYV1AN06sJoQJB88bTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=E9wF/+J7; arc=fail smtp.client-ip=40.92.63.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGzCI8mBh7BC9CAFszuXNvadq6h748gwrvN+RwakPblKfgRXJDkQfX7GNLjDoT4rPvGQa5vAmFlqGs7yKcUubht0XoGx2QFkXzqo0ZB2uKfwNmLVOc9/LfRbCDK839VSpTgEPdpUXLuBNZRB6Zvg/ZodU+hSM9rOsKZnKjkGG9eTbELSLSfDpjsMzlqnKGJu6rvtaDFud9jzFstZ4RJ/a2Gm1f+1pCJl1zBREfQC86xobhlAXG0jqoq3HM/skOlDzpjUPnA16hRfowc0D85UtHXZLdSEpyWXhZ/xjRwfG3aw0NQg3aL/ugZ5Zx4OtQa+FhVEw6l+fqrLPTok/R5KIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Mns46nkxLR3i9bpdSEQAuztw1GXcVh55vIiXsyJz4E=;
 b=EH184N0Ab8ii0h2KUP4Uuf8wjn5l/l7fJOd2marQF/g5UhPNqgJ9+7rn+6+PzltCgKKw5dj2ksp+voxZEjJxqlgctX50CWElhhBgb6JXYf/QhF4XncQs6pFfm6WhZnKDDk1WEN2ODRnc1ToCHowsDi3efGNzGu+HD/fZrdl6Aj+KnmCrT5b4H0LWSC6DDts1fNutjKxDbul1Q4MH6Ma4NGrAIXd4w+XSvZklbiILUbUgiIxeJ0XYxAjipdN8MtLnOimJv+9jsp1YGbN2cqsjN/FWwh0AQ2XzJnCtnqHv8+YsTNcm+F/FE2mIIJxW1nD3Oneh5YNpaKDZxeINcmjE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Mns46nkxLR3i9bpdSEQAuztw1GXcVh55vIiXsyJz4E=;
 b=E9wF/+J7Nvb92QOpMHCzEn6DL81bCVKdMc4wUjyfLNpUv+DU0wBc7MWXGnzS1785wCmqIyPHB5hA6Lxqrqd7IU3jAo+R4iVhu4HbdINRrdaWo1ty3l3UuBrA9P2Wu/1VTiyoh0vuHviFjnWAlZEyOhp4R1YeHwXh7foB0RYblECmacMSsMkpc4UCK7gWihSpoAB0YpskHZm8lwZMjzV40D+pwNHkd+oSimldH3itKy1/ed26ruX67LxdWzILR8xhTi7iXMgK8dfqkuGWXUQioquiI6ML7HEA+PH/3sWVDiASENIst1cjVx6dghQmr0rv3ucMzD/7bTOgme7xoaPkig==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SYYP282MB1341.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:76::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Wed, 17 Jul 2024 17:02:16 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 17:02:16 +0000
Date: Thu, 18 Jul 2024 01:02:01 +0800
From: Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs
 mailbox
To: Inochi Amaoto <inochiama@outlook.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, unicorn_wang@outlook.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Message-ID:
 <SYBP282MB22380B670D61592C914133BCC4A32@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To:
 <IA1PR20MB49537F9F04E601413EA1C86FBBA12@IA1PR20MB4953.namprd20.prod.outlook.c
	om>
References:
 <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<SYBP282MB22382E1C032FDE2D36E6B58DC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<IA1PR20MB49537F9F04E601413EA1C86FBBA12@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: geary/0.12.4
Content-Type: text/plain; charset=us-ascii; format=flowed
X-TMN: [cVgamVFsnrpypNSbR8FVLl9TtTIjfW8joPZwGvDjJmo=]
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <1721235721.4845.0@smtp-mail.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SYYP282MB1341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3deafbec-35b7-4afe-d323-08dca682341a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	U52jYy2gS+3cCFJKh3pNHdoqfAFEagiAkEdaipBp7PvrOXoTI15wYn7ladQqS6zs87xHlQL/FreBWC+evVmx9WRUEYmb1m4c6AUyDfC0gPJ0pft4sFtut/5oUr1SHkweF2g6VYLop+4rtyOUyllHU9U6p6+/8CBCTTirJ8N/BzECi7KA/3+N3JbpoFF9XQxrGaxc5BlSxRoniIB7SciDWQOan5TDeR9wbRdEMwPwUHEqZbntchVBt6HYhu5bedDw1NECEj0FSgSLUZZU2Ioy56n245t8/fHoZjTvQjxEK+MGIx27mg00gAyfVIoLnxV1bFbZjlqAjatvvWyhy+El2SL1A837RwFU7yNyZA5uEPVWGYJOwXLA1dJkQi0gN13fo9wmHuQDTh5SEJde2kz9PUxe5T1TTpSWGDDrIEDlysg7FOwbaGKSVHAIgWvehYw4XOq1sKHiOpmRNkaLxYN6W0ZHKis1xeDeVRne3yTVH09BVecOB9gFg36NEhztC+J172O4vWPy0sfov3VHYr2mV/MEqptJgnHs8q7nAvLtL1k6zzhjs5Y3VG0lfAI6X03dhKgIEoiUpUyg0iLQJXNFYJ0kqGwqY2BLr/bdAqhruGyaQff7c25D9M1NaWx0aPeDJDh/l3Tz9gJReScAs/P8KvZTpje11xA5ikUEyd4hr+br1veEPLAdB4sFe1LJYp8Z1DCJfYtr2RLA6DrzTqZpztK1+7NFnTZo2wSHRmlJj0IQ99ghfSCZo5hFxH9r/fZcAG0d+VF+P1vBTo1ZJj4khg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9jqo7sM0XcWTftmjvDX8sQ6i7LirTkr4pfHLJuXEAdCiLMfoGeZ64t9XgmX?=
 =?us-ascii?Q?8D0n4UI/DN0RdiOFDXKJJgsHpnMe7LjTJNyORsNM12J0GzYHiG8u5PNNrfWy?=
 =?us-ascii?Q?/EvU9abuoQ0sQJI4l5QdmXD7EoC8csOLuE1nk1p2Csole3P3EUMbbXMtwWo2?=
 =?us-ascii?Q?R5NREnhB47MFTb4knMTFUWbwPw2n6LFPFsNh401PjJ3h+ni6KCbrDaYQth7O?=
 =?us-ascii?Q?Biwwwwn4r0Je0jRE8QIm/9znzSJ/zcABZkK8ugm9yhmrUqpaEOdifTpiH1PN?=
 =?us-ascii?Q?PS7hWOxdkufXUoTk2NTk4iGNHdl4DAQD68wf7Gl0EYfuSaN/m5MoHe+c1od+?=
 =?us-ascii?Q?JOnkAgTNj9efxoUwaUVXtM3JWfQ4/crJ/zTPYxG5LbdWm181zzEl+3IObUQ/?=
 =?us-ascii?Q?IB6hIdD2NK1j23zrrHxXXCLONWOEFepuq/oV8rjo91ADuav5LIrV6IVGzopX?=
 =?us-ascii?Q?1DIt/bx1OdyLab+5Cci48c+OLrulY1mBUdLw0ELTgyPE/Jr3nr9UrpJqSaSh?=
 =?us-ascii?Q?B3cvCiivvuJLvZ2hUP5ofwgNdyoLPdDEzYE7+z7xnlw9E0kvbUpPAptL/qbH?=
 =?us-ascii?Q?soZErBDROH9fMFf7Mqsu16QDOFhoQZ9uQRHpIh+uirLBMnwqm4EieN12mkCs?=
 =?us-ascii?Q?ttW9IkLt29iINct0jZbLe5QgEfTNqHaZqd9qBoFxzQENOHJdgl8EYUN+4Qla?=
 =?us-ascii?Q?G4V+YE11EiQxlfA68kaNhe2/JhdsHeMRSb1BixyL9EdABvlZPbweS+Ova4k3?=
 =?us-ascii?Q?lHZ1wivwPkYg9wDjSJB4mH6PtaWdyOLo1UMtIw/7XNxnonYsiylFcKMyBbjv?=
 =?us-ascii?Q?VAE/z4cCFQVbck8s5PirnxfQ8GbjepGDG3flb+BR1GDxyw75+f/56h0OZC4E?=
 =?us-ascii?Q?7AU4narhAoTVGcvj8OIemLwyU/Ugvdh4RI3eqM3s5sklrHBMQdMpFULqyh1P?=
 =?us-ascii?Q?DU1RtvMwrVpZCllk9mXnB4iP6deT/422jyQawlJdbtQeVdMXHLHcpfQBg5sR?=
 =?us-ascii?Q?g8IH9iJBUkomC1C8UpkIGxchE/CDXkzJEdcY938pygNXAAcCEJrAG+iwCAVv?=
 =?us-ascii?Q?hmuyNkCjaBjuq26LrSx4RvcqGCHT2K7RyheKijbSuHZ3FwUEtqpv668QxnwG?=
 =?us-ascii?Q?fNrwgow0EFqQESofwMdwESllpO8E9O1Y9AHFe7KS0zU3y7kcMX0F5DXeCQad?=
 =?us-ascii?Q?hG3t5Utn+wv2Be2UBBgNOmtLnN9e1QDzMUw3xLRBCSxjxWtS5TbCpkiqPEg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3deafbec-35b7-4afe-d323-08dca682341a
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:02:14.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1341



On Mon, Jul 15, 2024 at 10:56 AM, Inochi Amaoto <inochiama@outlook.com> 
wrote:
> On Mon, Jul 15, 2024 at 12:36:45AM GMT, Yuntao Dai wrote:
>>  Add devicetree bindings documentation for Sophgo cv18x SoCs mailbox
>> 
>>  Signed-off-by: Yuntao Dai <d1581209858@live.com>
>>  ---
>>   .../mailbox/sophgo,cv1800-mailbox.yaml        | 61 
>> +++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml 
>> b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
>>  new file mode 100644
>>  index 000000000..05099d819
>>  --- /dev/null
>>  +++ 
>> b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
>>  @@ -0,0 +1,61 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: 
>> http://devicetree.org/schemas/mailbox/sophgo,cv1800-mailbox.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Sophgo cv1800 mailbox controller
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
>>  +
> 
> Unify the "cv18x" (at least it should be cv18xx) and cv1800 in your 
> binding.
> 

sg200x SoCs and cv18xx SoCs share the same mailbox IP, so I use 
'cv18xx' in descriptions,
while cv1800 having these three cores, sg200x and cv1812 have one more 
Arm core. I use
'cv1800-mailbox' in compatible because this driver only tested on 
cv1800. What do you think
is more appropriate to do?

I want to support the sg200x after vendor provides an example that can 
enable linux on the
Arm core. However, I haven't found a way to do this yet. Maybe I can do 
this in next patch,
update bindings, driver implemtation and add another compatible string 
for sg200x?

>>  +properties:
>>  +  compatible:
>>  +    enum:
>>  +      - sophgo,cv1800-mailbox
>>  +
>>  +  reg:
>>  +    maxItems: 1
>>  +
>>  +  interrupts:
>>  +    maxItems: 1
>>  +
>>  +  interrupt-names:
>>  +    const: mailbox
> 
> I think this is not necessary, there is only one interrupt.
> 

I will fix it

>>  +
>>  +  "#mbox-cells":
>>  +    const: 2
>>  +    description:
>>  +      The first cell indicates which channel is used, the second 
>> cell indicates
>>  +      sending to which processor
>>  +
>>  +required:
>>  +  - compatible
>>  +  - reg
>>  +  - interrupts
>>  +  - "#mbox-cells"
>>  +
>>  +additionalProperties: false
>>  +
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/interrupt-controller/irq.h>
>>  +
>>  +    mailbox: mailbox@1900000 {
>>  +        compatible = "sophgo,cv1800-mailbox";
>>  +        reg = <0x01900000 0x1000>;
>>  +        interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
>>  +        interrupt-names = "mailbox";
>>  +        interrupt-parent = <&plic>;
> 
> Remove "interrupt-parent".

I will fix it

> 
>>  +        #mbox-cells = <2>;
>>  +    };
>>  --
>>  2.17.1
>> 


