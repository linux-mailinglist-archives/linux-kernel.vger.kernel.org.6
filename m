Return-Path: <linux-kernel+bounces-255475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3393412F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BB31F22511
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1081182A41;
	Wed, 17 Jul 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oiU7ZPEv"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2187.outbound.protection.outlook.com [40.92.63.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE97470;
	Wed, 17 Jul 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.187
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236234; cv=fail; b=GYF+eBOlpMZKwnMmtoj00LtUR0KA4jkXmjZywHyVjxX745bx5LA2KfVG0LGpSbN/G5nPF4ihDyf5iEXZYSNhwgl7Kgf7fznd5qdXm/Cemf+bA0me0yjCral9gGpWxqNKIs3xQFXWA4LRFU/pyR/QYPJQGviys0ASweSvbMyC3KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236234; c=relaxed/simple;
	bh=RcTrl1wh6ETyollYV2/BhzTtoUesuGPAanMLOw9yfws=;
	h=Date:From:Subject:To:Cc:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gG0plsduL21UpVxSt6hTL0CO4QxOsFhASr+W/NwWTE/bs752gTrS2pp2BCKmAt4m4vCMDcmBI3UOUMHI8/yUjUOg5SrzdiI3W/dAfW8zVIKR35AFjNlg3GYRVaQ42C+VeFOds5iXb3O726lI1hvN6XdSGUDA83/KJgf70epNMXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oiU7ZPEv; arc=fail smtp.client-ip=40.92.63.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vn63NowniiKpYtj3nN3S7mvB7qzvsRLbilkZ78C5hSuwkrHAaT1f8DVqobNrAjwJjB3PpTRe6sSwrdm5yKqYyALMb4yr2ZZcWyxifJ3h0dVduFK1KPSvWe50Jpdac3HFllc5vJx2goSEPCqPHbW5zXffv5K+CKZNL6Nh36p372DasRye1b5CDoTPl1woRkjb5nBEOlsiu5LNC2pUutKLLYc8t8bHGnyno/tsyeoaEka98LiWc3sArh2nqXStlhtg/cOAcuRhT3GBi4AjC08OLQfG4sk6eqAemW+xs3OcrNvOps/zCzktRdaXbFk0ShX6f20vCdLpCpZ4sIT2yNTvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTZais8hsE/d6dt2OUCwODXeq6YeCJyA2+w3hkl/4OA=;
 b=CquYcIAlBQ0Z2e0M77v3ymTlRN6Ui3kb+ZCwKNZ/8ZGZBBwGce7a+MKoU7CuCFItMFjFohOH4vkb1Cgp78ZrnG9+5b6SX5Kp2Ymxh2q/RZ4qp/PosAbIO+rEXtpMYXVBZuHXXvw5BcAZvoLSAnY0sw333nawPsBuGYtCV7AocrKlQDsFDPwV2SDRT+41HCf/jA7HWlBUqvTFuEGL1BTz/covM75x8OEJGp48+zXW3Kj0ShWKhByTK9UNOonrPAWbw+mnV1WxPA3q+jgdwAVqC4PxmjCR6uUjNEKYbZllow4jeLS6r4QJza+ee/bdYDN5M1YtieXxTPuT5sXy7n57pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTZais8hsE/d6dt2OUCwODXeq6YeCJyA2+w3hkl/4OA=;
 b=oiU7ZPEvNELYu9+kORtDYp3n5PvitYQzym8EaDTVEPBTG6WuAw8KZikJWIK1aTu6TwxUAO8H8EHLDnqEBDrZ/4T123rn5zRZSTGN5Tf11Q34bdxajVXDhUroQm9c2ppDInsDUEBN9bApYobuO7NVPmU8w0Fokz68y5ueMN104e+s+DltUunyk75I2Bgps3WLF7lU0cpDmPYBHktWUX7SgscDLEq0GNT1i/Clm+9p3jSa5jFlzT3Ds1HPBZVHW4aPnqy83M9rRkyGRxg4YV/Ov/Z7HZUj13eUbPlrEH9S2gpUh42cs+ep4jipl3D3lkcbwbIkqo8W/sb9B6OyFiahBw==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SY7P282MB3740.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Wed, 17 Jul 2024 17:10:26 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 17:10:26 +0000
Date: Thu, 18 Jul 2024 01:06:46 +0800
From: Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs
 mailbox
To: Conor Dooley <conor@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Message-ID:
 <SYBP282MB2238C5F2D4B10061FA241CCFC4A32@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <20240715-upriver-grumbly-e8f6172f6a72@spud>
References:
 <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<SYBP282MB22382E1C032FDE2D36E6B58DC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<IA1PR20MB49537F9F04E601413EA1C86FBBA12@IA1PR20MB4953.namprd20.prod.outlook.com>
	<20240715-upriver-grumbly-e8f6172f6a72@spud>
X-Mailer: geary/0.12.4
Content-Type: text/plain; charset=us-ascii; format=flowed
X-TMN: [sQUMIRbSqCfoZhAMpsSoY9G+L3cBI1tVaCx+g1dXzqw=]
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <1721236006.4845.1@smtp-mail.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SY7P282MB3740:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b218be2-8153-4876-ffdc-08dca6835a4b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|1602099012|3412199025|440099028|4302099013;
X-Microsoft-Antispam-Message-Info:
	V5zJAMpAgmMPD3OJSphb8xUG6VwIsUg5yy0uUPaVP6vHmdXfcHZ0raJUrMMDcqnnh6i4iPRrCqV//PgenQjy5hHSgRWKUm/kDZulHpdZuAZGlxSMi/iorQyEeHRznPOc/lONDUwGTSsyIiGL5HW+I9J5RX/N7lFwWXkW3tDEkYOLadsr74amHcmzG1NrLGOFHaxRQMcJ9IvxfIrpRH8+pZ83jy/4qpc/fvI2D7ABFiIUtn4XAWriTOCbBmCR0I32psnMjdhOpEvm/b/o83cApPCMyNaqqs5hZjftPyJu4thxI2Arffz+cUYYHV9v6xDyd6/pNV1zuVtPLud68tZEDR5hVPditjYY4MH7jnTHRnIBB84oM4MVCxPl5Lbs3w49VNR0CHTtFnu/WqaHSD1gkOTUEz09fUzFsm+zBse8AHmYQ0sVHBbcrPwucMCdrcsX/nmKVpvp456KLZS7pjR1tzui0xUQVdrbKAVKTJbNQeDE6Rp+JckXvOA/XWOVu2uYdRbD0PBXoFLKXpdmwJn7yTK0UJz2LL48aE9/siN4hVdUqcuCwVynPcLGHRczgGD5nMiBSOyUN9l559N2bDY7scehb6APtmlePqe8hqzLN+vbyDVDBFZkdWBF2IqCqtQDSWvGqDpaqtS2fiwZNFG2J0VGJnloLNkW66V74IdyXxaMEB0y3QKH9nhYmy+91MSJ9KpD+Z77PFuixHFbc61X2ZRo1z7SxX5ZcOsWCvsgyILa+vzwWdE2cxL8150xqCs8ztfZh2FRus5p9wiYLeSu4A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OYGepTSel9xr5FcENLNEkchmf/agENA7Yv17RnNg3Ze3a401fSWO57vsfND3?=
 =?us-ascii?Q?0cx7LOb8mfxe2wT8ScWTecztcaS4Rex9pSmGm6/WTkd1JRLOg2ITHGoO+wOB?=
 =?us-ascii?Q?hN/JaXFihnLgyz13tG+JmMRQzkUMGZWadCnIBwRQ3o0NMeSN1huPQv6GaHG3?=
 =?us-ascii?Q?T5VFDC8DYlkce/4LoNr3Qs05hHmF4XwenSDVh+5nttvAi4DJ/2MhffEcmJsU?=
 =?us-ascii?Q?pyqjoPOyDoYyC8SW5xciuMzay6AGN0uFYH3zGeS/zh4CSzmiHqIiX/QiVEMZ?=
 =?us-ascii?Q?w4cE0GBpYQMMQWtzW5hzR6mSO54Oa7oFbRj8fFQaZjCWP//Vd39OLWUTBFkc?=
 =?us-ascii?Q?E/ygZuUPuNhJTMz9dCHaMrsSH9zVemptituS/mfEeLbX1jWFoHedWtddQUPv?=
 =?us-ascii?Q?XdA7gTrTOdoUCi1zm/0d9SBC1UkhTeUiqgZXekjZpG8LzCBxTChRP83e5rTH?=
 =?us-ascii?Q?TMepaiS4dnLncnAOHS9oNQepebD+XF1z6X6pmeJVRfkT7xJf/pGH/ZJ+rvoU?=
 =?us-ascii?Q?ve6tc1f8GetfnjtlWjNxEqAJyjI3udrdOO+sqe9cIoHprRzShtxf5oWkRWGS?=
 =?us-ascii?Q?wepWnNpMPaUjjrScK9f4Ez8WnIGXdlhfxAUJkZV/uuBCD4aJYyTz8airKDdP?=
 =?us-ascii?Q?1KFRB07QaeS7GfzS72WfUs7JxzUPb9P2Kb4PRvWuMO/L4wAGxz0me4+vpB4e?=
 =?us-ascii?Q?tePpubnrpmDVOfrg1jbb0rJu8LOi5seJ6uPZy+0y/rEIID7I2Vs5GixJRJcS?=
 =?us-ascii?Q?RJ2Oo3MrtmQiwZ2vYZv6jm8DpBoM3/u0J+MN4EwP8ITFLsIRNV83bw7LK3tJ?=
 =?us-ascii?Q?LIn+EV9C9MRMHAnUuRCT4S3dGUE1lWbi8EBxNUuLpmP5EoLDRi636tfFwmEw?=
 =?us-ascii?Q?geR+Ob7gCHWe/B5T3x774mNT5DTd/Tl6Kt1VMZrWpfnVkjVKJ++FuxR2AOUA?=
 =?us-ascii?Q?74Cof4L9/NH24XCFVjKNzZsyT9nFxAC1B+F15HZ2xQfr/2lBD2GcIwRk0nvt?=
 =?us-ascii?Q?MGBN8rNsmb5z53EjaGiCjr4DRNl9ARPc0eG8d19+GZkXYzgl8jAyxTP4BqFW?=
 =?us-ascii?Q?cuctfI0/dABdf1nIESiJwD90hlL4vMYeFkC6AQe6MBtM/RleXM4jPOQxCeK6?=
 =?us-ascii?Q?r1QTqH7enX0oI5H0r52M9PgzF882sYnWceI/La9zThL4VgfGM0e2jccE8OJ6?=
 =?us-ascii?Q?bJBNs4akv2wfYJGzAosuGnc1Hc92FHjvj6Uk21Xmt8gPZe3IcBAMOntDNVA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b218be2-8153-4876-ffdc-08dca6835a4b
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:10:26.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB3740



On Tue, Jul 16, 2024 at 12:15 AM, Conor Dooley <conor@kernel.org> wrote:
> On Mon, Jul 15, 2024 at 10:56:38AM +0800, Inochi Amaoto wrote:
>>  On Mon, Jul 15, 2024 at 12:36:45AM GMT, Yuntao Dai wrote:
>>  > Add devicetree bindings documentation for Sophgo cv18x SoCs 
>> mailbox
>>  >
>>  > Signed-off-by: Yuntao Dai <d1581209858@live.com>
>>  > ---
>>  >  .../mailbox/sophgo,cv1800-mailbox.yaml        | 61 
>> +++++++++++++++++++
>>  >  1 file changed, 61 insertions(+)
>>  >  create mode 100644 
>> Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
>>  >
>>  > diff --git 
>> a/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml 
>> b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
>>  > new file mode 100644
>>  > index 000000000..05099d819
>>  > --- /dev/null
>>  > +++ 
>> b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
>>  > @@ -0,0 +1,61 @@
>>  > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  > +%YAML 1.2
>>  > +---
>>  > +$id: 
>> http://devicetree.org/schemas/mailbox/sophgo,cv1800-mailbox.yaml#
>>  > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  > +
>>  > +title: Sophgo cv1800 mailbox controller
>>  > +
>>  > +maintainers:
>>  > +  - Yuntao Dai <d1581209858@live.com>
>>  > +
>>  > +description:
>>  > +  The Sophgo cv18x SoCs mailbox has 8 channels and 8 bytes per 
>> channel for
>>  > +  different processors. Any processer can write data in a 
>> channel, and
>>  > +  set co-responding register to raise interrupt to notice 
>> another processor,
>>  > +  and it is allowed to send data to itself.
>>  > +  Sophgo cv18x SoCs has 3 processors and numbered as
>>  > +  <1> C906L
>>  > +  <2> C906B
>>  > +  <3> 8051
>>  > +
>> 
>>  Unify the "cv18x" (at least it should be cv18xx) and cv1800 in your 
>> binding.
>> 
>>  > +properties:
>>  > +  compatible:
>>  > +    enum:
>>  > +      - sophgo,cv1800-mailbox
>>  > +
>>  > +  reg:
>>  > +    maxItems: 1
>>  > +
>>  > +  interrupts:
>>  > +    maxItems: 1
>>  > +
>>  > +  interrupt-names:
>>  > +    const: mailbox
>> 
>>  I think this is not necessary, there is only one interrupt.
>> 
>>  > +
>>  > +  "#mbox-cells":
>>  > +    const: 2
>>  > +    description:
>>  > +      The first cell indicates which channel is used, the second 
>> cell indicates
>>  > +      sending to which processor
>>  > +
>>  > +required:
>>  > +  - compatible
>>  > +  - reg
>>  > +  - interrupts
>>  > +  - "#mbox-cells"
>>  > +
>>  > +additionalProperties: false
>>  > +
>>  > +examples:
>>  > +  - |
>>  > +    #include <dt-bindings/interrupt-controller/irq.h>
>>  > +
>>  > +    mailbox: mailbox@1900000 {
> 
> And while you're fixing the things Inochi pointed out, drop the
> "mailbox:" label, you've got no references to it.
> 

Yes, in this patch there is no references to it, but mailbox client 
node will need it.
I tested this patch using mailbox-test as the client, like:
"
mailbox-test {
	compatible = "mailbox-test";
	mbox-names = "rx", "tx";
	mboxes = <&mailbox 0 1 &mailbox 1 2>;
};
"

If you think it is better to drop the label in this patch, I will drop 
it.

>>  > +        compatible = "sophgo,cv1800-mailbox";
>>  > +        reg = <0x01900000 0x1000>;
>>  > +        interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
>>  > +        interrupt-names = "mailbox";
>>  > +        interrupt-parent = <&plic>;
>> 
>>  Remove "interrupt-parent".
>> 
>>  > +        #mbox-cells = <2>;
>>  > +    };
>>  > --
>>  > 2.17.1
>>  >


