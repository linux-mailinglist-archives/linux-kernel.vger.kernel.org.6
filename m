Return-Path: <linux-kernel+bounces-312534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21A9697D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DEB1C23219
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A61C7661;
	Tue,  3 Sep 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gJw8Ag49"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2053.outbound.protection.outlook.com [40.92.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410219F407;
	Tue,  3 Sep 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353471; cv=fail; b=scVIy2CtgP87YYiS4/M3aGaPlGB4Gdvv8GnTrtPNY1IxoZpviLl65qikgpw0yp4fRZcgQbdsewbNEjGg9do3MRrADLpSh0GBX9v9qe9Jg+RtoANa5g9j1gxWVJRWzkJcYidqzFxIyFA4K4y1cMEZpy+t8ZmLgI1CQa3ryD+otZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353471; c=relaxed/simple;
	bh=mmAG4FuItucZ9ueU/JkXCQbIQ1PDUtznzgEHGrq+ISk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mlhMaCbOhVVtpYJhqnRH08Cflv7yVEzwxfUE6vEUBycKrVn414hoMixpfnjvsgx2EfXPdWCIxwytGczdUKpIooy7lqO8gvqM0kdHdc65GT/vEjYxkclxmQpkZyO0qs4HGeDV2OifWjKHApYPxQiLCPLbc6mMDQINqwzOVoc8WOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gJw8Ag49; arc=fail smtp.client-ip=40.92.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrE3Ln7OfJEuKjPzx79YvCLhZTz3LGKhOxn7PGzo38mdyvPFMt+250og4h/xNZYjkNM7gTV2WnZOkmx+ZKFyr1oZJaxKv7h5NfKnDqGlWHDLoh/efr19ZTgU6i86hPD2388PYZpOocpVSnFDyBQkCkAaN8NPH9tHzEvvxcHkNBcmOTNncetvqNlU90+6PT4lgxMkfjOd7BritMd0e8Me324567ZDyF4sqF0CJ7HVR3gRA602SshMTLPUG7QthZNxwUWkekfsiGOzvhza5UjyqfYT7+kCkagWg1x5nQSThIqoTBMrfPX5GL0iI+MituVjmIssYT4sLSwi7vPbCFiUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEHpUKcNYwHowym5fiiCJfGuFbN+hQx6rjo03FRHnmQ=;
 b=mMLye34Ua0El2V0zxHt78oZflLZ28AmLuTxB02BRSMjgTCVfzsfIbz7ecWu7G/TxMe2HdRGl9SGEJIDrS8GCsPxEFK7YYdHy3wZLQGusWTxN29qjtyPqW/wpQH95BX4bo50Crx+dK5IDFekuGoVFzWC74Y6N5kEQIzEo4D1LWp/9a9mAKB+MMQGGwbkY5UBixd5kPP3xBb4sxmTb5jX/Exb8axO82pcxprh1TaaCPpXdLhHJmkBby/nATaQr8gfNutbmv3u5RRh1vMHqesNAfVU0DrWNFS2MkLTfxFTqtBzIDR7Ivzq5i8DcvLUxcxGe9Oeav1V1QgvYTBA8rcsEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEHpUKcNYwHowym5fiiCJfGuFbN+hQx6rjo03FRHnmQ=;
 b=gJw8Ag49Y2Evog5J7TFj1Rhb6L9T88ywQLKVdcAhE1ODjzPyfc4X+Rw6BwOIbY+3ymlqwBwgP9AD47DwP+aVwe12tTIO47lL6oBgH0ZLUfim7gYwzhwIbqBngBakCHLxgzj3Oiye23Uv9lTT/IzNo9LZz9I67Tw3Zcc6zvpgWzG7GPOQGjUdreYgnXPAoXsa2sDXsJyFNqQm0YyWzEuipa/o37Oqm1rl/h3S/qNLb4ywW642ixFuxxQQ9LG2TcWUXU1rNBvVBAkpCHBfk7zyqe5f1Zs8d+gxcDiC4kkDwCcD5tCODAPxZjUjb5oQrHDXASj5xtOyXBMmWNec8ZuXog==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEYPR01MB5742.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1a6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 08:51:03 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:51:03 +0000
Date: Tue, 3 Sep 2024 08:50:56 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: spacemit: Add clock controlers
 of Spacemit K1 SoC
Message-ID:
 <SEYPR01MB42213A1B4824D594D857A3BDD7932@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <w4alphet2d56ojfpm5ibgxdkleb54uvvfsrw5iktzph7xsg3zj@ybofz6uo7qd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w4alphet2d56ojfpm5ibgxdkleb54uvvfsrw5iktzph7xsg3zj@ybofz6uo7qd4>
X-TMN: [xrgxYBLmofmmd5kBKXP2ukGGOq395Se5]
X-ClientProxiedBy: TY2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:404:e2::27) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZtbN8MIttTuQHP_J@ketchup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEYPR01MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5b2e88-0747-47d4-10e3-08dccbf58a33
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|5072599009|19110799003|6090799003|15080799006|440099028|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	UH5gGKHkDql+ctZh2RJu4pBAT3Xbntz/+65o8Sa/715Ek2rFR2vy+iY/PDUqgA6O42b9294D4DQCQYSSLOB71PlD433vYSfk7doVJVhZCf+wHY3TcVzrs4sWQHnJgpW/0TCdesyCPaYOiMGLHAn/VK+DjwH7Uriwbq0/V4lmfjk4r8T3vARwIPobV0yHiy1W9cGho1MSAif9zcI71ecPQ+tq5dDhXoq4IHitiQzAXgsTU7qyZliHq5+c9xfsJ7ciChLJv99pRcpr0ZGPmk06UC5em6XtsILwKg7qAPkyuRobpoJvM5U81EW4F1hVbbU/wDCc3qOptzceef0J8FjF8LtY0w/5ukobuj003qzNx/dEJpZ3CrcH1S/zZHP4SH38dawh+T05ULqW2LumAbeyT7//Md6nb/QIR4Jyi2ELNuQRfK2p8uZdU5H94kK1jW2x39FdpAzM6N6CdF+Nv7aQTpWlUAFyW5IzBf+Ul4+1Ko49BXvBX9OCcMMnjTz02kyVLRXQvO4xorq+IeeN69uVYHe1YP1kdvdoab/wYco/iHR49HWtmjRb9A0X4linECi84rvrr6ACR3lqrAuR8Rr8vcVGXg4941ROemn4tv47uxF+eikky6U6PDtt2ho3kuTHBEepkN0tXLnpZpnf+/02oh6gkRZY0eZFIiOr9Mj8dVhzhNYRhuap5QMfXMrAkZUtRbeAzTwx74HfWEE37LTRHwrPCPtJY1oORuStxV1bFrKpn7ab3BqUQkYf3tYV5v6JcUv7UpSyg33aMWxnpJA7FP75d+vi5FboGDhPQR9g/ceLpbTTQMPwO1cKkCxD7kV3HqixDg+dllSJwjY/tVY3shttnXvijvh6gVVVgLdgU1k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLjqpTS9NTH/a6TemlqfouLS7cuRHYfnG9mnc2Div5NwN1Z/XK1zLfijITAi?=
 =?us-ascii?Q?N7yano+ry0dvEplIRvThsSVV3lK7KpOeKcbc7BoOFqTfWkNGLikGkSlnK/vr?=
 =?us-ascii?Q?wj2Y/AShcxW320d9KFUhv6vcsJJOB7Tpj0oMbp686z6EOhfVyAGDAub11cja?=
 =?us-ascii?Q?4Hgd5m6/sC8zlmMcmWWCSssgC+hbsXLvlh6Daj0Q2tqeY1k2wv/kc42bXAuM?=
 =?us-ascii?Q?aqwYPEOv8586LFzmxEF7SnHZhpN7AS2vUJYyDs+Ps+b+toICfvV+fSc0gaCA?=
 =?us-ascii?Q?BJS/UuI4VwpeyKuovWTWT9x66QH7ORUbnjLU+t+iShP8B9jVHnc/mZZYQ4zb?=
 =?us-ascii?Q?1C3H27H722fGBulRGAWqrRyheCiDozcEWQk1nmsaOPVoXoWru9gW0XVfOnkL?=
 =?us-ascii?Q?sVRbkk4SP1CFdXsnvnVo05PZCLc/iUvDBRcQV/GKbLtssfVu8lcnaTOfU6Fz?=
 =?us-ascii?Q?4ZNURo1JI+Siga7wVyo82fO6XhsUHIZ2ChE4u0vDENKIL6YybJZX+QfZZGqK?=
 =?us-ascii?Q?i2Be8+Qhx+8nYMgXMxQpZYurEgtopC7Aj6X00j7bTsXQ7EPucStrLwy/x8HZ?=
 =?us-ascii?Q?SU9kznff1DwPuZttBYM6NzquEPsaA9c4LNKQOtAFM2LKOD+wdOfTTQJoTYqD?=
 =?us-ascii?Q?M2BIf1a3M7vBfzBqo7ZeUEUONM38gMY0EJGS4kYfzBbX/30t+9CeC22z80EG?=
 =?us-ascii?Q?LKlBfr2cm/VPrpg94xRZ1ve/2IuPqHLZhESXfkujbokwJXf6UkqWVB+6PjcU?=
 =?us-ascii?Q?LKcYUd+XidOMRT4hQYDOr6nViI5PffXZu79dX2ANTBknrgDy1zapMSU0miYl?=
 =?us-ascii?Q?upDTrMYVVx311FSwoMi6HP15R5jaTN2U2k2QJxbYQldS4JQnFMg37H0UAqOe?=
 =?us-ascii?Q?xzhcQYcxBtFFaLAf0NikeAvy6MPvudhUwIAjOk9swU6Y1vDyA8XXbTAnHHS7?=
 =?us-ascii?Q?vCbJ+zBrjLPI9a8kIqMmdfTjv2lk4ZGoxuZ/YRR6zqbyw6lN43vz2MRSRgE5?=
 =?us-ascii?Q?qwEpJyLCHT9F3dJ45HCiTUIiJmY38x0+Wo1VQyI82o9PB1pCUJ0k4GUI7m+0?=
 =?us-ascii?Q?Q68zpApa8xbdxecLGWpNkTAf2ZytodJZKKTE7jECCXqk5+DF2ktOlk05C6bM?=
 =?us-ascii?Q?zvYhNmetv0ZYeHwErwREOt2FX+ynHACzF3VTGKGUNaKcO23tcucWSMbaDfP1?=
 =?us-ascii?Q?Drt6mA1tsT9m/82oV0Q2Jb3AUNXkkhB0/GGMEeV0boaL2e3MPBSfj6NJCCY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5b2e88-0747-47d4-10e3-08dccbf58a33
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:51:02.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5742

On Sun, Sep 01, 2024 at 12:55:21PM +0200, Krzysztof Kozlowski wrote:
> On Sat, Aug 31, 2024 at 03:47:12PM +0000, Haylen Chu wrote:
> > Add definition for the clock controllers of Spacemit K1 SoC. The clock
> > tree is managed by several SoC parts, thus different compatible strings
> > are added for each.
> > 
> > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > ---
> 
> This wasn't ever tested...
> 
> >  .../bindings/clock/spacemit,ccu.yaml          | 116 +++++++++++
> >  include/dt-bindings/clock/spacemit,ccu.h      | 197 ++++++++++++++++++
> >  2 files changed, 313 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> >  create mode 100644 include/dt-bindings/clock/spacemit,ccu.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> > new file mode 100644
> > index 000000000000..90ddfc5e2a2f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/spacemit,ccu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Spacemit SoC Clock Controller
> 
> What's the SoC name?
> 
> > +
> > +maintainers:
> > +  - Haylen Chu <heylenay@outlook.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - spacemit,ccu-apbs
> > +      - spacemit,ccu-mpmu
> > +      - spacemit,ccu-apbc
> > +      - spacemit,ccu-apmu
> > +
> > +  clocks: true
> 
> No, this must be specific. min/maxItems
> 
> > +
> > +  clock-names: true
> 
> No, this must be specific. min/maxItems
> 
> > +
> > +  spacemit,mpmu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon managing "Main PMU (MPMU)" registers
> 
> Explain what for.
> 
> > +
> > +  "#clock-cells":
> > +    const: 1
> > +    description:
> > +      See <dt-bindings/clock/spacemit,ccu.h> for valid indices.
> > +
> > +required:
> > +  - compatible
> > +  - "#clock-cells"
> > +
> > +additionalProperties: false
> 
> This goes after allOf block.
> 
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: spacemit,ccu-apbs
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +
> > +        clock-names:
> > +          const: pll1_2457p6_vco
> 
> Don't use some weird, fake names. That's pll or vco or whatever the
> input is called.
> 
> > +
> > +      required:
> > +        - compatible
> > +        - clocks
> > +        - clock-names
> > +        - "#clock-cells"
> > +        - spacemit,mpmu
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: spacemit,ccu-apbc
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 4
> > +
> > +        clock-names:
> > +          items:
> > +            - const: clk_32k
> > +            - const: vctcxo_1
> > +            - const: vctcxo_24
> > +            - const: vctcxo_3
> > +
> > +      required:
> > +        - compatible
> > +        - clocks
> > +        - clock-names
> > +        - "#clock-cells"
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: spacemit,ccu-apmu
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +
> > +        clock-names:
> > +          const: vctcxo_24
> > +
> > +      required:
> > +        - compatible
> > +        - clocks
> > +        - clock-names
> > +        - "#clock-cells"
> > +
> > +examples:
> > +  - |
> > +    syscon_apbs: system-control@d4090000 {
> > +        compatible = "spacemit,mpmu-syscon", "syscon",
> > +        "simple-mfd";
> 
> Messed indentation.
> 
> Anyway, parent device nodes should have complete example.
> 
> > +        reg = <0x0 0xd4090000 0x0 0x1000>;
> > +
> > +        clk_apbs: clock-controller {
> > +            compatible = "spacemit,ccu-apbs";
> > +            clocks = <&pll1_2457p6_vco>;
> > +            clock-names = "pll1_2457p6_vco";
> > +            #clock-cells = <1>;
> > +            spacemit,mpmu = <&syscon_mpmu>;
> > +        };
> > +    };
> > diff --git a/include/dt-bindings/clock/spacemit,ccu.h b/include/dt-bindings/clock/spacemit,ccu.h
> > new file mode 100644
> > index 000000000000..ce84690684ff
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/spacemit,ccu.h
> > @@ -0,0 +1,197 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> 
> Use the same license. (one pointed out by checkpatch)
> 
> Best regards,
> Krzysztof
> 

Thansk for your time and review, I realized it is better to split out
multiple bindings instead of writing these messy "allOf" block. Will
also adapt your suggestions in v2.

Best regards,
Haylen Chu

