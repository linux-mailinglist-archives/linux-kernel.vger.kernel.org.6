Return-Path: <linux-kernel+bounces-559986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C659EA5FC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32843B38C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BC826A0E7;
	Thu, 13 Mar 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kWdQBQv6"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBA26A09A;
	Thu, 13 Mar 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884004; cv=fail; b=bbP48SVLiuzRNExL/afcb46AS1ZaYob0dRdWs4oV68dUE0L6xfig3hof0wBvGSc6uygliG4S+Ssij+kwceSog+WjkVxrfLPPEwpfVcrtGN2m3Qcu9PEPKGzscQOhPl6+4aRyEO+jHZdVmLYP/j1mOlvHvep+vdX2nUSvc9crAeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884004; c=relaxed/simple;
	bh=d60Y6MteTD/4sp4irprRuda8epxYwG9B0YmwqkVU67E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KvHgL8ITUybqQRbS71Of0yA3JsOAyZnkXagdOyNiUuVpeciqmVW2EAtOhjwbSDiZVoCb6cQLwczXn1lMevgLclbB/4FRdbncBpjFtsBeuIajj4T3D4IQx35EXjIulV9gVL53AspMjKoNqeaSz6vIUZa2E2XJFCGRfaNQrYszTyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kWdQBQv6; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrywrlyiX0YyY7QtB49IOC877I+GGjgALtc48GaqVeRHMthHhasZpLQSGedmWXBtvt0qXERcC6yaGQRptpO5pzWDK0J7FKyZjtidwJHzhU4NpzSEhmVD6FuXUioVrCERFoXrsV+hFnLUQm70sAGfaYXDAuidk1V6aQhtIv/ze3mtNl4mysE2pm1u1y3SPMRfrHsCm67RKuWXjTwBxi9mwkeG9HyCNftgzaU2S2rfXU+MZDNjDqCONSc7I1qI5v8PzuM7OF1QON8da3H9aoFMr8TV11fxDTv0EjfQXTh71+9m6bAEbKeZQ9AtZQo5+++dN+0oybz9eX/Zf7QJFFgUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiATwUEVUGE2micnLxAuIsSa5nkNr0llEfjBx0LIP+w=;
 b=DOMyyttRa5DBNylKskapveFq+e5s8C6a8pvnPbq1UZrmeU38GrdodViBu3uuata9pcZ1vEksJ0jnytp+1vMm8c+VJZZKqnUTrE2Ku9+s8mOU4iEaLVfCh6IGf2PqH2Xz7hpMNK3DXRz++efL31JvFhrCYJS591ry6TYHTwHwxlDNlb/d9QEiWXcFkaYMHDyvfgvpRFz5vioClyNHn/tVwdHaE2+HJP+WIVqvWHlGz2QjdkWkH3dx+oHsmYa2kSkWtElkKD3F69nVy/F1l4LD0QBKpJVWz4t6VmJJB161Rdy3BR5mk/FR0LVDJ3seSMQrPHJulQ1tBivgXxD3IFFtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiATwUEVUGE2micnLxAuIsSa5nkNr0llEfjBx0LIP+w=;
 b=kWdQBQv6tBc+Csa9uNI771mb3UmqI/UV1sMTyQj0mQuo3U8qCzc6gQE6qcGptwDavJSURGKOP3Rtt9FtkoexefyiO1HW8jvSFTmqh3E9x4syu9uB8l/nbkgmUZZcxKx24oBhsN8YgOO7LD8rcIvVJUGSk3F9aSvaflIoJlcwMtFZ75jnilfRnkrIWQ/S2DgrHQVwSq17GlYptU0C5fFENYkTU9x82yFZFmMCdcYVQgErLBuRBba9MIwaswedj9JPQknGeFRe9gkdCHDo+GGTKJ4ChtWWx86B9oepPrCHMy1VC1Ti7gC1qu3ZaixVfhN+zf04WsF9gLppVG2+VmwdVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10268.eurprd04.prod.outlook.com (2603:10a6:800:21f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 16:39:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 16:39:58 +0000
Date: Thu, 13 Mar 2025 12:39:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Message-ID: <Z9MKVd8NeLKNIkd2@lizhi-Precision-Tower-5810>
References: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
 <20250313125746.2901904-2-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313125746.2901904-2-florin.leotescu@oss.nxp.com>
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10268:EE_
X-MS-Office365-Filtering-Correlation-Id: 87893e58-f2d5-4148-97a0-08dd624db106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AeJC0FmqSc56wHG+q+G4A3jC7/Blm8F+O/WwpvMKtreQOrBi+JhX5yxI92ub?=
 =?us-ascii?Q?7ZXYsoJhOAx6v3FN9P91zbWe888SnBjEy4f2iyo7jFXu2+ITeUDJROY/OB/g?=
 =?us-ascii?Q?UM4eym1PlQy5LQBf11DmhrthgRh8QYRHbnmVLOzFQP8i2x4jxM5pjuJmbTFG?=
 =?us-ascii?Q?JfBDHkmHUEOA8UjQCxw9+uY/+8aluv9aw9d0/AUCRAuko2cxJ3JAfQ6kb+3u?=
 =?us-ascii?Q?n25C2/6hyCqpK8N6mj3dQEOMNt5EQ+44SSVpQS3zuhS5Wt9m8Hm/lOOztpNn?=
 =?us-ascii?Q?sObicOKscwNkUhD/uolPwfNm/x322Fyrj6gkhyEpTQCTh1UW+wnJ2dhZG+uE?=
 =?us-ascii?Q?crAkYxuo7FXVSDYiyVVAEZEhFNj5Me4H3N0HciCovUKBY1AOUR2kMHdWERrt?=
 =?us-ascii?Q?wDUmWVf9PCfyzLi5tBorazadX2w/dk22+Imm3ISFsnwCjjVX9zQhOPFxRC9d?=
 =?us-ascii?Q?cdpvpl6Q+dZLXXrwrKHwPPN39uLYrGnQCCs2yFpHymEerHaIVOFO3rELoMex?=
 =?us-ascii?Q?kGMeTPeFHqbx9PQuaf7y0RJ8qbOU61rCS5dg2HaNzocKCxCdqD2mVnpRuI27?=
 =?us-ascii?Q?woijiQMAp/lbILY1NKr56rex3eIFLDRUWZ8QqfydAyn+v5mQizjeRSEOWype?=
 =?us-ascii?Q?zU/kxLcQsmsf3jV9MbL4/7BILlxrlXWUL9TD+7ccPlur5dmCt1rBapE2IEmL?=
 =?us-ascii?Q?j7VcAQmVm/aZs7fgD/tNTpiat/MGFJew1TFUfYAQW2/oruf8Pvz+HQbDbQOO?=
 =?us-ascii?Q?zwaBupgQKoJZry5WBnUPNiYqz2Yq4Ca7cUKHQA3Gahie6LYfT6/etEswkTX+?=
 =?us-ascii?Q?+urr4HidhNwLc585djt6k8GyMqgb1yJzIMx7zVfUlvG9cIrI6vVMJ9ovU6K6?=
 =?us-ascii?Q?7y2gBpKZiqZxbVH+nZF5oBiCPC6M9uhzrLCKvqrASFWIO+V3L3cOdIfFQ6e0?=
 =?us-ascii?Q?v8eWZU8fMjm/f++Ry/xLfYfDhQcQiaHQPnJtntKPSOVv2OJ3SiJQQPtkxM2+?=
 =?us-ascii?Q?4A18R9zkQUE6mxjUsMCGld+xp4iaB3ReJScXPKvOpBYH+2DiKghdVN4gZ8np?=
 =?us-ascii?Q?l42Y8mFY13hD+RrNsTq5WYoPKl47ZIEVnfynSdhTCitzkbMRBPKl8P3UTW0t?=
 =?us-ascii?Q?dMTZfgPju7HyuMbOJAuUYYB+vabAxi0GRnGrmbzOCvSGBbZ6V4AyCywgpb0a?=
 =?us-ascii?Q?4E5MOjAS60G8dUPfmSpxfidf6VftYh0JdVmYfWRhKNiAcnqsE+VXCYJT9Q8p?=
 =?us-ascii?Q?c2F9k/uQi+kKC4HK2fYqPdIkWGN6qB2mTz1vCrN+T/DkM3Dy/uCwBzVQch4v?=
 =?us-ascii?Q?/0LYxxrjalxCP5oVNuJ678uqtVMsAab5xzXcXtoeMEt2p+FbgkzoxlShAYGe?=
 =?us-ascii?Q?BUsZ3wdRnICrQ8qVxgVSTSdB5+3c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?igZV4FjiWD2hEyv/7aOunAVFhk49b6tIjbNvK2v//tgxA+Fo8ZaMG9aoSp+B?=
 =?us-ascii?Q?etbYE8coHWanpNC7Kl6apBfbS25PwyYKYRvxfsF5jBPVgCLyJdv4olPj7dfX?=
 =?us-ascii?Q?DSbp/v1YBIiu6KxeflIlRroHb+QjwcPvDaaWtkgYTq84pbpUi0Yvnbs6OEyo?=
 =?us-ascii?Q?4B1agtIMDSIdogD20Hwx9+paAINaDN/sNjIcTSImDMM8PrLC3lX2WO5fCkyq?=
 =?us-ascii?Q?f7mH0NppKFjZUD7LAcjGkvlg5J7/C1njCJPObH3zX3SMCKEJaOl1+lKDcYrK?=
 =?us-ascii?Q?47RFJC+f7W5c/as29ysXXvJax1/h5ZxQccKIe5/4NyOnj6sihlpHgNxNCYah?=
 =?us-ascii?Q?t/+FGQdzBn4YtH3uwF6EsFak2Wq19d/BXMWXrXZtdRle63fbyFHiXCr9QC3N?=
 =?us-ascii?Q?ozt3uK++aqOrV51V/WYAsWGMAkmikM161/1gqyE3TsM7fup1G4MR7mWAmBiJ?=
 =?us-ascii?Q?CtXygEHLjqEtNzgbkEaws/4pWolhIquudaIR/Z5h44/FLSZpo+pY+IO8CHC6?=
 =?us-ascii?Q?oIj4+pIpgo2vGVeApIrftCO51EAauqEvUzP50j4fE0OwO84nb6B7gZL9a2Ov?=
 =?us-ascii?Q?QayiocmDuREm+2xnj3dgTTttho1oSZNAULigV2FUp73IX6HGb2UewRoE5cDH?=
 =?us-ascii?Q?I65XXrWdMZLMOuncap0Kz6AWVYwDNSN1QkN60Y+4lTtsiEPAG2IdxgpBaERI?=
 =?us-ascii?Q?whwCMA6xOkJ+SIRj4g8DqynHOMphzm7iSOX9a/8OcHXvyOYLdQ44inrMtjtj?=
 =?us-ascii?Q?sBbnfGxJJ92xtG9LEE1k3qHAp2u/uRD1xZ0TOv0KPiERsNYb3s6eNauJdmHU?=
 =?us-ascii?Q?4fYOHpzQf75lVijY96aIii5IHFYlKxTkLZBNzKqOfVpeVi97fEKtIcbwDBDQ?=
 =?us-ascii?Q?qA7Ve+4B55IW1VAPk9sg9oDFWk6EgqaeMqUEfHyH30J4pNW049bApzfMTwUP?=
 =?us-ascii?Q?xLE/F1D1cIBL204w+uirwWXjgzM8mDnEyYucYiOI74/sF0kYu8e3j1Zf948u?=
 =?us-ascii?Q?gDvHk52/FtrFExWYSKdfPNRZ8mU+ofbK5cAHKpm/A8NXHLhgl6CsEz6WmiKw?=
 =?us-ascii?Q?vXhFHZbZKwGBcuZwZHXfWk4QYCYtuMHR33zG60JEMrEQVGwdwZs7xAoj6UrV?=
 =?us-ascii?Q?NcJLu7MCTyM6j8VTR2vn/rvBT+JK2fUxqozblwr73uv5vbWzucD8CulhC4ta?=
 =?us-ascii?Q?by6zcJS3bTU5KX+TLZMD5P7xF3czdRBiS7sHN38n1Itck08yKp60T3DBKr5x?=
 =?us-ascii?Q?M3TRSIWUvivCFUgwAMgtKjtnvzG+cPhr5W4rIcjyx6HSSR6xGt7xtvDuBqY7?=
 =?us-ascii?Q?CyPf+ktNpq/e+9PXXTazwYqCc8nrzg1FKpGiGCV8v7iDY3T1TUPCHTJVyMkU?=
 =?us-ascii?Q?rpZvBTaXYmeMme0GZrIrX8Rc+wCqBxbW0CE5PCaM/517BL3cMNPU4L7jPkoh?=
 =?us-ascii?Q?hGTMK4XH+KshngdF6q5PYaZ92dH9Y+flw+LOkBdbaRB7l7MVpylqgHC0SHrw?=
 =?us-ascii?Q?kmBtAOkb8SbIxtvbsUpAw5u8PmCQUCJyAnYD7Sam84MdZj7z5rFE+/1hZsGE?=
 =?us-ascii?Q?eGn73oe9fISejH/q8NoLAeWfx/2fFUvXDjIi0Efq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87893e58-f2d5-4148-97a0-08dd624db106
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:39:58.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDpF4xRpSFd0amcuIjxM98sGm1I1IjpmtTTC0ecIW15tqskf4Os8dFCB4fzE/eM97eKtCJVyv1RsRt0pK5X9tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10268

On Thu, Mar 13, 2025 at 02:57:44PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
>
> Introduce yaml schema for Microchip emc2305 pwm fan controller.
>
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> ---
>  .../bindings/hwmon/microchip,emc2305.yaml     | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
>
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> new file mode 100644
> index 000000000000..3107fcafcf6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip EMC2305 SMBus compliant PWM fan controller
> +
> +maintainers:
> +  - Michael Shych <michaelsh@nvidia.com>
> +
> +description:
> +  Microchip EMC2301/2/3/5 pwm controller which supports
> +  up to five programmable fan control circuits.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - microchip,emc2305
> +      - items:
> +          - enum:
> +              - microchip,emc2303
> +              - microchip,emc2302
> +              - microchip,emc2301
> +          - const: microchip,emc2305
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#pwm-cells':
> +    const: 2
> +
> +patternProperties:
> +  "^fan@[0-4]$":
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        description:
> +          The fan number.
> +
> +    required:
> +      - reg
> +      - pwms
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fan_controller: fan-controller@2f {
> +            compatible = "microchip,emc2305";
> +            reg = <0x2f>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #pwm-cells = <2>;
> +
> +            fan@0 {
> +                #cooling-cells = <2>;
> +                reg = <0x0>;
> +                pwms = <&fan_controller 1 1>;
> +            };
> +
> +            fan@1 {
> +                #cooling-cells = <2>;
> +                reg = <0x1>;
> +                pwms = <&fan_controller 1 1>;
> +            };
> +
> +            fan@2 {
> +                #cooling-cells = <2>;
> +                reg = <0x2>;
> +                pwms = <&fan_controller 1 1>;
> +            };
> +
> +            fan@3 {
> +                #cooling-cells = <2>;
> +                reg = <0x3>;
> +                pwms = <&fan_controller 1 1>;
> +            };
> +
> +            fan@4 {
> +                #cooling-cells = <2>;
> +                reg = <0x4>;
> +                pwms = <&fan_controller 1 1>;
> +            };

I think one child node should be enough for example.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +        };
> +    };
> +...
> --
> 2.34.1
>

