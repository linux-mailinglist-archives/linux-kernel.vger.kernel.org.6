Return-Path: <linux-kernel+bounces-310459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5411967D59
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578802816F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA51946F;
	Mon,  2 Sep 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="My8TMQIC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2026.outbound.protection.outlook.com [40.92.19.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E61388;
	Mon,  2 Sep 2024 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240517; cv=fail; b=lUkEtSXEuG7xgiT3qo7jepXKL5OQMevSBVtrSbbIf+FSX3229zLazM33b2SqEEA4mazq8/RsbUBHc9tDTj8TW2FLudKN1VeSooOMgBRxMt/yBRLscZXSnGhZ468rX0R2Lxhbm9hfQCIAG+TdGuJgZlFlklmBvZRKv8ByM9UOQqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240517; c=relaxed/simple;
	bh=80aydYGPTeyyKC4j6d1JrRSUPm1VzSbJm7IEzFbpBSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KPyiIB2szyzAmo1+9zhhORRQxaWge8FK9gJVHerT8N6A+MwURqfEbtaCoDsA1gk/dhUvcjjJxEpkKjMXocZLk89JNAva2aOIR5ZmSaC633M56DdwENJxLuYUC/bp6WZvAZ2DMQJVu+ZNmvxgKn4WMimievD4cmgH6imYl9P+e80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=My8TMQIC; arc=fail smtp.client-ip=40.92.19.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLSvmRcX4YaZls7N2MqmK/LVix7Q3WVt1K5h6N0YHC/eE0Efi9okbW4yeiv5g2mloo8wgtFW5MO61MLauL2CpdHmHjLfE0Yu70iAN+EkF53LJQEY841tdSTsF7qVEa53X+8BjTcMIieMhMK0ER/JGwtdElEhTjRoxTodiCoRhSt5WY2vL2+ywHwymmq7B6iMpmmrEkhiUJd9q9tTuwS7eq9Sht5UlYcELsomBrs4O6G3pEQZS79aslXOnUs5VoVE//WJ5sN3B7hSTc4v+vD8D5bmJ6tCQuXD7xNKyomlWxvCdoXYsuXN9wo7aQwYu18f4cugSXI9m9u4AnfV+hzbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5kufUGUBX86JZ64D8OwixebvoZ1+PqsPdvY31mcKek=;
 b=H8TDkhzVaVcsHGh8dwpoCdkpmVLbSB4iqv0+a0dmisH7T569OfhDxZaf8QgaRghnTfGMYiT4/eX5HhZWFr7Vb6pf5nzb5s1SC7F2J4nRE36tPbv3TeMManIMKuAQ60PlYhGXkAiL5eK4r9hhajTEjaazURBssPpaMC44psvFl+82J2wP85a1GhXhcO8K4MEZCqNM4Yra+jnRqLO+LnQKrDJc/df9x0v8r/SEaseq89jZJ6tTC5QIvahJQOzAoqP0A9TvSqbpnypMcgugIAmdlHpyMnYiE+WLrSfI3vyAAS8sO9+mRSsUIzKV09NirMsA58dWsij+JCS4DmZqo+9A2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5kufUGUBX86JZ64D8OwixebvoZ1+PqsPdvY31mcKek=;
 b=My8TMQICtJLN7RVp9ZwpLK1M9RW+abRStXOkaXhlRNSr0MvW0zLelWhqFbn0sAfGyrLWBts+jiWlWAQloUPuo/GJlaP2xCwIgJlxmdaH7Ptg+vvSATk1Z2UNLG9WUlFxCae7Dj79HpqHPnjNMfDYnk522T6dFOvfhggtBA4rLZmGd1Jj88oXUiXjlD/MobjD/4gpOe2sCN+aSJb8i5VEtLKBoSV85W472YJAqGbbPtTiyU3cEF9/CcBa2QnDCi1M61A90Sp8c6L91k9fEXeKECqgglm6lh/oYaSWDW9J/6vlVFXXLnXFujzvcziJzht92zeayrvWEaM/uvZHG5/pdQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB7247.namprd20.prod.outlook.com (2603:10b6:806:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 01:28:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 01:28:32 +0000
Date: Mon, 2 Sep 2024 09:27:26 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Haylen Chu <heylenay@outlook.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: spacemit: Add clock controlers
 of Spacemit K1 SoC
Message-ID:
 <IA1PR20MB495313BAF0905B4BE5840804BB922@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-TMN: [X0KWLZembCJ74gM5I/FqaIuO+L8jPnEDBDkk0lW4JyE=]
X-ClientProxiedBy: PU1PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:803:2a::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <c4l7ivczuyvdfvyjb6pf5tauygpmj3s3jugoox5sowzkh4cwle@b6q37xq75p7g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 687d345f-c2dc-4846-658e-08dccaee8e46
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|19110799003|8060799006|461199028|5072599009|1602099012|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	Vn2HWielU+IxVIGrmcFq/Bz5yAGpJVQlBmn2kE6hd2LnQr4ivH/Ceme77IYZt4miDT0xTT/DZ4DoqPn83zm64PUYIF1xcKCthwHWRDeOediPCuNXywzgNbH4tWU8UNfUE4B69PqBZhR3zw0qZIW0LWAjvVXzuGCEmTM2+03wAKLNymFXcKWDweCo+ZP5j+ZjhYB7K111zwUF+pwbpAhQNcJlpzdYi9nmoH6DtjXzngijYottUuPQOzf/OMqnwR9keTsELQTuZTgZeRXsW8CJZJp+csgus6M9Kh5IZA+cOTPAScF+kHUFgeFjGd4hTiteiX1tvr87/7Kpj5UeHvSU2cl5wQeVMPsKJqlEE2v7tCS3mvFQOzWHPR2tBON6w44RZB/mvdeHYVFr5+C2oZ6a+UlVh33qqvBf7ivfuI3yWTHAVT8uBe0c+NiNr6db0BDq8NbWjRiU5ahhdLIDYAlbItW5dSovKV1vHOxfokR66jV7JVAJyKAf9q9yvvyrkN1u0p/mxT5kGINsh6x74VoTyMEHCj9QZlF6VHlCF3qSCKfO/M1qG7tCnyhg09P4E4FtgGPr/LjTKhcaTauGtEJInxSDmE5HDujC3djRVN/B6lfcP8lXAfvdNRmg9mK6EludkIPJrakmUqg2wqOXNlbT148I5Zr9t9TWf5BPyxkheJ2+D8aqB+GtwpJ1un1y9CegV+27jb+C4bmlCGrYCIGZhwPpDx+7rlMLk8B8+/1yFwT9SBRhhCrVAJU7e8lwHCE/A1YkYS007npk6EZfKW0yz9TAYtaHzPhApUNqRdd0WIuz8sJZyIu5FYe0f3bgT1KE4skj4awRf9wtGnwtyTBtrItoyef1I47vUtkLUXZzawM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/lSeAC1cYQjnq2GNEct11iPwtYgLB/nnCuC3EiYwY9ef/WvG4lZ+pl4WXm4p?=
 =?us-ascii?Q?UooDdLer7Z17/go14AMq3tdRva2iiAdYPIX0FHGlNlVPd44zFMiMgd3ObfOL?=
 =?us-ascii?Q?TV+FPXAE/WY7FkVWlfhK+wX4LX4yasJWDd3CVazK3ZgB6HBYm4VS8GkDJqlM?=
 =?us-ascii?Q?Y6matKIh5I5q9kqYAUNQoWFkQPf/FfNEi3EdVJa5ImC2oTKmtBv/zOcuVRUZ?=
 =?us-ascii?Q?SM7AO/p/bOg/oYi7dugMzYPHLW3cePehGqLfh/U0vvG4ZHusKRYIURJIMeGE?=
 =?us-ascii?Q?+m91Us4usw6WNp2H7rgN5AMzphe6yXRhGzyTiCzNCLoix3DQeNG6CBYwk27q?=
 =?us-ascii?Q?bjxKaGKCk4nt3n+1zp0Pm4Muyectq6H1oY2Mh1ivvf/puQGX3Oc6XYOjF+xr?=
 =?us-ascii?Q?H8gIwwXHpmffU12LbyKB2gCTNAo16aki8PeCrvVdbKeAEIfjvIufb/hT9Wjl?=
 =?us-ascii?Q?Lr42CeZP2/XKTcaHdRPCXFjjL9pczORpku3fqTDkUL3IvbDDLcPHqLF5JcRk?=
 =?us-ascii?Q?528Sy1/TNI6uWyho9u124iVvjq+Ikhc/VY8ccyc9g9Y4UHFDb+51RMu3wRQb?=
 =?us-ascii?Q?/a5rM53dj0YAoe1KB4XD2x5WYwnLDwRZ3ufVo1v0DhYxKcly+DYJky6XScb9?=
 =?us-ascii?Q?b8BdjyUuarCXBxZAPBGkDLmDJ4UCQW5tpO1FUAwM/g/CdlwtTl0A8H6y1RGS?=
 =?us-ascii?Q?jFNk3QKzgCuSPbrImhiXpmbVYGxQut380TlPWj9qZ6Opq918R/tuHHPs3Jl3?=
 =?us-ascii?Q?KhZ9wxbI8XYVkDDqSAchQpsYUVM9d30ge1ITPm07DB6gWt1m/M64lMfYnKw4?=
 =?us-ascii?Q?12TNcONbmS2FdzMS8FF5LPcE2c/GQNNMxH3fFci36KSuBV25fy9uIcGyMnZx?=
 =?us-ascii?Q?3+3zCzpIYwAV4FQQyJfch/Kbz7cL+TKFsJTd1crPy921cuqg8VTByAp4PZzd?=
 =?us-ascii?Q?O4lFsRZSzlzSH/9SIgS2ETLLn0x9GEY1EtNYZRh3O/5zfLtWgw8ci14hmgt1?=
 =?us-ascii?Q?zzjCUuaBwiDGhxH69JjCuet7T2pVUBgbGgrPKs8/f1JS0En3DyxiI66aUO8R?=
 =?us-ascii?Q?F3bI1XTmVT4T6C59vVGBaQkbFf4/Sksa9aMrn1aVDJ2UWFAY266drBkJbEYe?=
 =?us-ascii?Q?qZF7Lb3wKCVPI8Vuh0T3n3zcupfkOooz3rIn4WkPgpBFHbEq8fhuclWa2Lwf?=
 =?us-ascii?Q?W9SzngpXXMmC50M9YKIe9u29hyu4eczlPK7eUqEy7jkYKLx8U2zVOF4ZwZQQ?=
 =?us-ascii?Q?mtpcm1uYqkwfkfdc18hV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687d345f-c2dc-4846-658e-08dccaee8e46
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 01:28:31.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7247

On Sat, Aug 31, 2024 at 03:47:12PM GMT, Haylen Chu wrote:
> Add definition for the clock controllers of Spacemit K1 SoC. The clock
> tree is managed by several SoC parts, thus different compatible strings
> are added for each.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  .../bindings/clock/spacemit,ccu.yaml          | 116 +++++++++++
>  include/dt-bindings/clock/spacemit,ccu.h      | 197 ++++++++++++++++++
>  2 files changed, 313 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
>  create mode 100644 include/dt-bindings/clock/spacemit,ccu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> new file mode 100644
> index 000000000000..90ddfc5e2a2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/spacemit,ccu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spacemit SoC Clock Controller
> +
> +maintainers:
> +  - Haylen Chu <heylenay@outlook.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - spacemit,ccu-apbs
> +      - spacemit,ccu-mpmu
> +      - spacemit,ccu-apbc
> +      - spacemit,ccu-apmu
> +

Add K1 prefix.

> +  clocks: true
> +
> +  clock-names: true
> +
> +  spacemit,mpmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing "Main PMU (MPMU)" registers
> +
> +  "#clock-cells":
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/spacemit,ccu.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +


> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,ccu-apbs
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          const: pll1_2457p6_vco
> +
> +      required:
> +        - compatible
> +        - clocks
> +        - clock-names
> +        - "#clock-cells"
> +        - spacemit,mpmu
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,ccu-apbc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +
> +        clock-names:
> +          items:
> +            - const: clk_32k
> +            - const: vctcxo_1
> +            - const: vctcxo_24
> +            - const: vctcxo_3
> +
> +      required:
> +        - compatible
> +        - clocks
> +        - clock-names
> +        - "#clock-cells"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,ccu-apmu
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          const: vctcxo_24
> +
> +      required:
> +        - compatible
> +        - clocks
> +        - clock-names
> +        - "#clock-cells"
> +

Do not use this weird allOf, split this binding into multiple ones.
This also apply to the binding header if necessary.

> +examples:
> +  - |
> +    syscon_apbs: system-control@d4090000 {
> +        compatible = "spacemit,mpmu-syscon", "syscon",
> +        "simple-mfd";

syscon also needs binding.

> +        reg = <0x0 0xd4090000 0x0 0x1000>;
> +
> +        clk_apbs: clock-controller {
> +            compatible = "spacemit,ccu-apbs";
> +            clocks = <&pll1_2457p6_vco>;
> +            clock-names = "pll1_2457p6_vco";
> +            #clock-cells = <1>;
> +            spacemit,mpmu = <&syscon_mpmu>;
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/spacemit,ccu.h b/include/dt-bindings/clock/spacemit,ccu.h
> new file mode 100644
> index 000000000000..ce84690684ff
> --- /dev/null
> +++ b/include/dt-bindings/clock/spacemit,ccu.h
> @@ -0,0 +1,197 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#ifndef _DT_BINDINGS_SPACEMIT_CCU_H_
> +#define _DT_BINDINGS_SPACEMIT_CCU_H_
> +
> +/*	APBS clocks	*/
> +#define CLK_PLL2		0
> +#define CLK_PLL3		1
> +#define CLK_PLL1_D2		2
> +#define CLK_PLL1_D3		3
> +#define CLK_PLL1_D4		4
> +#define CLK_PLL1_D5		5
> +#define CLK_PLL1_D6		6
> +#define CLK_PLL1_D7		7
> +#define CLK_PLL1_D8		8
> +#define CLK_PLL1_D11		9
> +#define CLK_PLL1_D13		10
> +#define CLK_PLL1_D23		11
> +#define CLK_PLL1_D64		12
> +#define CLK_PLL1_D10_AUD	13
> +#define CLK_PLL1_D100_AUD	14
> +#define CLK_PLL2_D1		15
> +#define CLK_PLL2_D2		16
> +#define CLK_PLL2_D3		17
> +#define CLK_PLL2_D4		18
> +#define CLK_PLL2_D5		19
> +#define CLK_PLL2_D6		20
> +#define CLK_PLL2_D7		21
> +#define CLK_PLL2_D8		22
> +#define CLK_PLL3_D1		23
> +#define CLK_PLL3_D2		24
> +#define CLK_PLL3_D3		25
> +#define CLK_PLL3_D4		26
> +#define CLK_PLL3_D5		27
> +#define CLK_PLL3_D6		28
> +#define CLK_PLL3_D7		29
> +#define CLK_PLL3_D8		30
> +#define CLK_PLL3_80		31
> +#define CLK_PLL3_40		32
> +#define CLK_PLL3_20		33
> +#define CLK_APBS_NUM		34
> +
> +/*	MPMU clocks	*/
> +#define CLK_PLL1_307P2		0
> +#define CLK_PLL1_76P8		1
> +#define CLK_PLL1_61P44		2
> +#define CLK_PLL1_153P6		3
> +#define CLK_PLL1_102P4		4
> +#define CLK_PLL1_51P2		5
> +#define CLK_PLL1_51P2_AP	6
> +#define CLK_PLL1_57P6		7
> +#define CLK_PLL1_25P6		8
> +#define CLK_PLL1_12P8		9
> +#define CLK_PLL1_12P8_WDT	10
> +#define CLK_PLL1_6P4		11
> +#define CLK_PLL1_3P2		12
> +#define CLK_PLL1_1P6		13
> +#define CLK_PLL1_0P8		14
> +#define CLK_PLL1_351		15
> +#define CLK_PLL1_409P6		16
> +#define CLK_PLL1_204P8		17
> +#define CLK_PLL1_491		18
> +#define CLK_PLL1_245P76		19
> +#define CLK_PLL1_614		20
> +#define CLK_PLL1_47P26		21
> +#define CLK_PLL1_31P5		22
> +#define CLK_PLL1_819		23
> +#define CLK_PLL1_1228		24
> +#define CLK_SLOW_UART		25
> +#define CLK_SLOW_UART1		26
> +#define CLK_SLOW_UART2		27
> +#define CLK_WDT			28
> +#define CLK_RIPC		29
> +#define CLK_I2S_SySCLK		30
> +#define CLK_I2S_BCLK		31
> +#define CLK_APB			32
> +#define CLK_MPMU_NUM		33
> +
> +/*	APBC clocks	*/
> +#define CLK_UART0		0
> +#define CLK_UART2		1
> +#define CLK_UART3		2
> +#define CLK_UART4		3
> +#define CLK_UART5		4
> +#define CLK_UART6		5
> +#define CLK_UART7		6
> +#define CLK_UART8		7
> +#define CLK_UART9		8
> +#define CLK_GPIO		9
> +#define CLK_PWM0		10
> +#define CLK_PWM1		11
> +#define CLK_PWM2		12
> +#define CLK_PWM3		13
> +#define CLK_PWM4		14
> +#define CLK_PWM5		15
> +#define CLK_PWM6		16
> +#define CLK_PWM7		17
> +#define CLK_PWM8		18
> +#define CLK_PWM9		19
> +#define CLK_PWM10		20
> +#define CLK_PWM11		21
> +#define CLK_PWM12		22
> +#define CLK_PWM13		23
> +#define CLK_PWM14		24
> +#define CLK_PWM15		25
> +#define CLK_PWM16		26
> +#define CLK_PWM17		27
> +#define CLK_PWM18		28
> +#define CLK_PWM19		29
> +#define CLK_SSP3		30
> +#define CLK_RTC			31
> +#define CLK_TWSI0		32
> +#define CLK_TWSI1		33
> +#define CLK_TWSI2		34
> +#define CLK_TWSI4		35
> +#define CLK_TWSI5		36
> +#define CLK_TWSI6		37
> +#define CLK_TWSI7		38
> +#define CLK_TWSI8		39
> +#define CLK_TIMERS1		40
> +#define CLK_TIMERS2		41
> +#define CLK_AIB			42
> +#define CLK_ONEWIRE		43
> +#define CLK_SSPA0		44
> +#define CLK_SSPA1		45
> +#define CLK_DRO			46
> +#define CLK_IR			47
> +#define CLK_TSEN		48
> +#define CLK_IPC_AP2AUD		49
> +#define CLK_CAN0		50
> +#define CLK_CAN0_BUS		51
> +#define CLK_APBC_NUM		52
> +
> +/*	APMU clocks	*/
> +#define CLK_CCI550		0
> +#define CLK_CPU_C0_HI		1
> +#define CLK_CPU_C0_CORE		2
> +#define CLK_CPU_C0_ACE		3
> +#define CLK_CPU_C0_TCM		4
> +#define CLK_CPU_C1_HI		5
> +#define CLK_CPU_C1_CORE		6
> +#define CLK_CPU_C1_ACE		7
> +#define CLK_CCIC_4X		8
> +#define CLK_CCIC1PHY		9
> +#define CLK_SDH_AXI		10
> +#define CLK_SDH0		11
> +#define CLK_SDH1		12
> +#define CLK_SDH2		13
> +#define CLK_USB_P1		14
> +#define CLK_USB_AXI		15
> +#define CLK_USB30		16
> +#define CLK_QSPI		17
> +#define CLK_QSPI_BUS		18
> +#define CLK_DMA			19
> +#define CLK_AES			20
> +#define CLK_VPU			21
> +#define CLK_GPU			22
> +#define CLK_EMMC		23
> +#define CLK_EMMC_X		24
> +#define CLK_AUDIO		25
> +#define CLK_HDMI		26
> +#define CLK_PMUA_ACLK		27
> +#define CLK_PCIE0		28
> +#define CLK_PCIE1		29
> +#define CLK_PCIE2		30
> +#define CLK_EMAC0_BUS		31
> +#define CLK_EMAC0_PTP		32
> +#define CLK_EMAC1_BUS		33
> +#define CLK_EMAC1_PTP		34
> +#define CLK_JPG			35
> +#define CLK_JPF_4KAFBC		36
> +#define CLK_JPF_2KAFBC		37
> +#define CLK_CCIC2PHY		38
> +#define CLK_CCIC3PHY		39
> +#define CLK_CSI			40
> +#define CLK_CAMM0		41
> +#define CLK_CAMM1		42
> +#define CLK_CAMM2		43
> +#define CLK_ISP_CPP		44
> +#define CLK_ISP_BUS		45
> +#define CLK_ISP			46
> +#define CLK_DPU_MCL		47
> +#define CLK_DPU_ESC		48
> +#define CLK_DPU_BIT		49
> +#define CLK_DPU_PXCLK		50
> +#define CLK_DPU_HCLK		51
> +#define CLK_DPU_SPI		52
> +#define CLK_DPU_SPI_HBUS	53
> +#define CLK_DPU_SPIBUS		54
> +#define CLK_DPU_SPI_ACLK	55
> +#define CLK_V2D			56
> +#define CLK_APMU_NUM		57
> +
> +#endif /* _DT_BINDINGS_SPACEMIT_CCU_H_ */
> -- 
> 2.46.0
> 

