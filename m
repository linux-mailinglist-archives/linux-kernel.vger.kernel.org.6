Return-Path: <linux-kernel+bounces-560904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069CDA60AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D21516B93C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34071194137;
	Fri, 14 Mar 2025 08:10:06 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BF191F66
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939805; cv=fail; b=Y/+AiRUECUw9NQNbqCbnzXQLjruTOjy8URgZPVBTKkBm2aKE4SWHUL0cNbqaX2Ez8QYhIKk0UF2I9nvPJypA9lBoEY1BMkHMHYxidMYfl//WwmUzWkIizyK2c2fUkah4c6DW7QKSZGdUi856EW++tquZDztcRqcA54QulRBmPBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939805; c=relaxed/simple;
	bh=xNttmloVA0okbSyxwd0FhM6COB2u5kj/11ivt4Fqazg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMS/oDlT/b49cKSPaQu8Zv2UnfcG6WuQXpuw9AKH3u+uxlQ2zp54riTlviIJNn1cgmC8+ufUEZSgfYfffU/3S6LIHuVShL3Epxo1F5JZ2GaEA/RsNAuBNiE2u9YbwUJU3fXPU7jRtp8K08GsGT/1yRN0Hv7xBt5E8GYi/6HQBf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHdSD13ohWAODeHSkRrx+ARHn8hrfU9vmFtAe1QEMrbQwSxK5QQdi79OYn4KPNCWpmP4W5ieGSDAvpz+jSoIdSMWwN1fK/gdXmQ+8FdoTF96N5YrR0Tv5tqVn0GEzOiNxEra5iGfbHEF6/tA+c1jt0Z4nyflGmyT4db9Qt0fzwyfbLY1l/6g9D3+KjcObVo6Z6OT0W+H9KGdKT9VtVlpQA8F1ykamJHvm6kJKYpmAq0GHy8En8BB1TOxWm/O0VSI/LM8EBkyA1Ez623vpVyxPykhdcSVT8IdVE1XkLx2b5pEljTFlJpjCmUwN4lqPOc/9Cwbqv0PxiA37VTLAw/6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd/VyJvfPXsswC8jf5SuY0zNF9TrzTU825fNh4DA+64=;
 b=yYhe1tAoTLyWqg3K/Kc76h5NSA6+ZIXSh8nZRrWVGGsNaaeqH48PTrcEQfLBtJWjJ2t0EfbIyrxdvq6t7VKbxuWIAkvHV/bmRDZSgP8S3Yr/mdEFhNYvxN1Z6BUK3sNSZBf798DNED1IvZeBwaeHEgT8X9G/DHuLeu4jPOy8dET0/b7PqADwCCfTXHl1ZHQnxgjtc2Fh0bpIZ+iTzW/gb95DF+DjYksYKyIaaB9KYf8tdLZC8OyKXuZpbnDvkEc4Iqugw8nsln7EM4q3KnS0alTm9hFQ/On84PWdbWJKoOzkCU812dlE4TydwsQhy0dhLK7hix1/UezUFOAH/HnE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) by TYZPR06MB7040.apcprd06.prod.outlook.com
 (2603:1096:405:3e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 08:09:58 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:192:cafe::f8) by SI2PR01CA0029.outlook.office365.com
 (2603:1096:4:192::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Fri,
 14 Mar 2025 08:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 08:09:57 +0000
Received: from gchen (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 17FEA4160CA0;
	Fri, 14 Mar 2025 16:09:57 +0800 (CST)
Date: Fri, 14 Mar 2025 08:09:55 +0000
From: Guomin chen <guomin.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	Peter Chen <peter.chen@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: cix: add device tree binding
 documentation.
Message-ID: <Z9PkUxlQ1t5zZxuf@gchen>
References: <20250313132405.742360-1-guomin.chen@cixtech.com>
 <27cf6dab-da29-458a-b376-4013c05434ab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27cf6dab-da29-458a-b376-4013c05434ab@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TYZPR06MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b134b17-63f7-407c-7fc6-08dd62cf9c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEtnY0NIbSthaXR2M3BOQ2lSaVVTNGZOdkR1YmU2QjlDNkp4M2N6eFVpYUhG?=
 =?utf-8?B?N01NVE9jMlZnc1V1d3pVVHVVeUhTVHlCUzFUZVhLMzZwNVZ3eWxqMldmMzFO?=
 =?utf-8?B?T2lJNmZ4Zk14cEJxbDd2SElDRUhzYWk5UjUxNlRQNWI4WHgwbzRobExONU1T?=
 =?utf-8?B?ZnB5dUVnUDdaZzRZQnViM0RWOS9xVXVsVVVNM3BIMmlmMTh2ejN0SnZsR1RX?=
 =?utf-8?B?SjJLNDhUZGRRZG5EQkxOcEZ4a2tWRVd5SzN0ajVvVG15d2V4bko0amc5bm4z?=
 =?utf-8?B?bDIybGw5YlphNGVPMEdSdlV0bm5tOU1xNmJZNXJuekp4ak0xMzJrdklDRS94?=
 =?utf-8?B?TE5vdE1zQ05IWWFUakZhVklwbE1YNWhWUEZyTUJyTUtWeVNSY1lOTGFhamla?=
 =?utf-8?B?L0xoMmIyY3VIditmbS81ODNIcTBkR1BxL3hGL2JBUVBLRld5UnRWd2lnZXhC?=
 =?utf-8?B?ZDlLMmo5ZnZEK3hOdVduaG04TlE4bEdCYVhrT2NZTXdNckY0L25Sb1ZMcnpN?=
 =?utf-8?B?UG5ENkZKQlpxaU16b2hGOE96am0vaklPY05KaWJ2TGpoSFNHb1pPU2MzWGh5?=
 =?utf-8?B?eDFOUk5oY0pWYU5tc3pZSUdkZjRYQmY0OEs5UXllc0puWDBYSW1ZWFBvRkVT?=
 =?utf-8?B?cGphT3NHUmw2bVI3RkJtRHdVUGZpeC85ZE8rZGQ0b09GWGh4b201YXlQd3g3?=
 =?utf-8?B?MlJadFJlak5sZ0w5eitiYXYyTllscmVweWxYdllEdHJOeFlVRmh6RGpxU2ph?=
 =?utf-8?B?MytNTHNqTTBLWmRibFFoMUNPTk1tQmcwdGRiVG1GdHNMREpaRlZYeEJmUWNJ?=
 =?utf-8?B?dWlrRmZNM1l6T3dqU1U0cGdNZkU3QkdITHJEZTFlNEgySm1uZ0tmLzJ2eFll?=
 =?utf-8?B?QTVSQnNiSzJuQVIxWVpoT2dzZnFuZy82VisyT2FYTkZ0dFJ0ZHdBbDU3dzFx?=
 =?utf-8?B?YlkybEZ3bFZpRWR2OWFvMEhSanQ4S0RNZ2l2N1FGdHhHSkEwNklwOEZuTDk1?=
 =?utf-8?B?S1BFWDNGQjNtSmdzbVZIZ3VmRzNOdUlZQk82ZEJoZVN2NVhNU3YrZUswaXRQ?=
 =?utf-8?B?QTI5MmpWNFVtSlp0ek4yOFpqdnB1NDdxRHdlVUFtd0QxNlptMTJQK3hnVm53?=
 =?utf-8?B?eTA0akllOEYzZXF5VVd3dFFVK2VVL3FuN2ZzUXRoZUtrY0VIQ0xZblNORWtl?=
 =?utf-8?B?aFFrT0NLRkowYzJUcktkSUVkK01McXZqTzNzZURyTFU2S0c4aVdRTG1hKzNr?=
 =?utf-8?B?QmxBcHcvcTRYZThseEdmTzk2WExzMHg2emw2Qitta1ZWSTlJOWFBVTNWUU5s?=
 =?utf-8?B?akVBTmd5TTJRZGF0ZUIzYmxMSXZheDE5ZDFzZWRkdkNzREJQaWhGaE40aWsx?=
 =?utf-8?B?WGZnSUE4SC9qQUtFckxQYnM3T1p2ZE00M2xBbmcvRVZQYmdTQjNVYjNzc1NC?=
 =?utf-8?B?MGpFM0VBNGpUTU5jeFgzRFc0N0c4WkFpbGhsYlhQNUkycEhFdlRRZjZSc01F?=
 =?utf-8?B?Mk04VEp5TGphVWNPaVBPTWNYRWVwVUg5dExFVkNCaVlOUGhTekhCWllORHhQ?=
 =?utf-8?B?cWZ6STI0MktNNUNjZjFZNldMdkM2OTN0cTYwQWsvS3FEZ3ZBdXVVK3Rvbk94?=
 =?utf-8?B?aHNCQVVRcENldnVIbldOU0YxUU9xdWZocGtJSldtS0s3bFBla0g4cDM0eHB2?=
 =?utf-8?B?ZlQ1SWxUMHp0eFZWS2wxUnZVNkNHcGlTY0h4TE5JZDNsblVVUWNka1kwYnlU?=
 =?utf-8?B?NE5YYklYcVJvZGYrRGc0VkdWVWNKSi9kOW4ya0N5UENydnBrUUw1ZUFLT2Vl?=
 =?utf-8?B?dUN4bjZia1lDUFQ0RVFWeHVNMDFIeVA0R3NxY0U5cTduZHFiZmEzQW9MYnQ1?=
 =?utf-8?B?d2FXV2RFSUhpU0pCVWZucE9sRmVuUjNMeHBMMzU5N2tLRE1yVWhGM2wvQ0dV?=
 =?utf-8?Q?+RAbUpTQqs+cPmXbecz3WsC7rI9Pmsk/?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:09:57.9010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b134b17-63f7-407c-7fc6-08dd62cf9c9b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7040

On Thu, Mar 13, 2025 at 02:28:36PM +0100, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 13/03/2025 14:24, Guomin Chen wrote:
> > From: Guomin Chen <Guomin.Chen@cixtech.com>
> >
> > This patch adds device tree binding for mailbox from Cixtech.
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> A nit, subject: drop second/last, redundant "device tree binding
> documentation.". The "dt-bindings" prefix is already stating that these
> are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> Also, no full stop in the subject.
>
hi Krzysztof
  Thank you for your careful review. I will address the issues you mentioned in the next version.

> >
> > Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> > Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
> > Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> > ---
> >  .../bindings/mailbox/cix-mailbox.yaml         | 74 +++++++++++++++++++
> 
> Filename matching compatible.
> 
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml
> > new file mode 100644
> > index 000000000000..85cb54ae2e79
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/cix-mailbox.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cix mailbox controller
> > +
> > +maintainers:
> > +  - Lihua Liu <Lihua.Liu@cixtech.com>
> > +
> > +description:
> > +  CIX mailbox controller is used to exchange message within
> > +  multiple processors, such as AP, AUDIO DSP, SensorHub MCU,
> > +  etc. It supports 10 mailbox channels with different operating
> > +  mode and every channel is unidirectional.
> 
> uni but configurable or each channel has specific direction?
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: cix,sky1-mbox
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#mbox-cells":
> > +    description: |
> > +      <&phandle channel>
> > +      phandle   : Label name of controller
> > +      channel   : Channel number
> 
> Drop above and explain what the cell argument is.
> 
> > +
> > +      This controller supports three types of unidirectional channels, they are
> > +      1 register based channel, 1 fifo based channel and 8 fast channels.
> > +      A total of 10 channels for each controller. Following types are
> > +      supported:
> > +      channel 0_7 - Fast channel with 32bit transmit register and IRQ support.
> > +      channel 8   - Reg based channel with 32*32bit transsmit register and
> > +                    Doorbell+transmit acknowledgment IRQ support
> > +      channel 9   - Fifo based channel with 32*32bit depth fifo and IRQ support.
> > +    const: 1
> > +
> > +  cix,mbox-dir:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Direction of the mailbox (0:TX or 1:RX)
> > +    enum: [0, 1]
> 
> I don't understand why do you need it. By not sending us driver patch,
> you are not making it easier. Why would provider care how consumers use
> the mbox channel? Maybe consumer should choose the direction?
> 

As for the mbox-dir property, my driver code has already been submitted. 
On the Cixtech Soc platform, although each mbox is unidirectional, 
there are multiple mboxes—some for reading and some for writing. 
Therefore, the mbox controller has added the mbox-dir property. 

Consumers only need to reference the corresponding mbox controller node, 
and whether it is for reading or writing is already determined by the mbox controller, 
without needing to further understand the mbox-dir property.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#mbox-cells"
> > +  - cix,mbox-dir
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        mbox0: mailbox@30000000 {
> > +            compatible = "cix,sky1-mbox";
> > +            reg = <0 0x30000000 0 0x10000>;
> > +            interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH 0>;
> > +            #mbox-cells = <1>;
> > +            cix,mbox-dir = <0>;
> > +            status = "okay";
> 
> Drop
> 
> > +        };
> > +    };
> 
> 
> Best regards,
> Krzysztof
Best regards
Guomin Chen

