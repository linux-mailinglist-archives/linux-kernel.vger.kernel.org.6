Return-Path: <linux-kernel+bounces-231033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3139918536
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500E61F2767E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFA71891BB;
	Wed, 26 Jun 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AEYnIc8W"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C7185E52;
	Wed, 26 Jun 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414280; cv=fail; b=sgdGafiAYhW4je6nDWWbgVi9x/gzGDzHlP9a5LIQ/o2V5sXyuwPZoCSvRyqqnUjrDt3n8fpeROdzvf2Jj+yDNzKAFkDY7P9Pwb0naYP63X8ajJdjaimgDXHiiKjzImIM67KZ8hpzUnjW1gc4Q18q83aFOCpbPopd9q4uqR7sQ4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414280; c=relaxed/simple;
	bh=rFE3r+rHjppeyXPy/kxk51EavHxdLpG1+T39CchoJE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oEsH8PxBaMzwnlOU02a9YhzqwCbb0xi3yzG2Pd7Nc/XFyY0AR1uAe2UAY3dgjDCiTTwPAYAax4iq6C/Y0VBY2xXU+HMZk3Fw/ixoTSGx8y8FW5xef88VuivFLNZaNPHwQLGwbZhibMZ88rFtIt7SLUbl6fNFnvpGX19vDAhq97A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AEYnIc8W; arc=fail smtp.client-ip=40.107.241.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGEstg0R+eXVgDamplldWQ5KIfyvU33F15G8EWZm7neW75sZoJd82VArK8are+U2iwjizR2UKzHKlWT0e/Ibq46xrswvIbkkdi16cNE677uKAxM0vN6Kf1ORy6qOF6bBph8/U4+I5X4fzFx0hjoCMyLl5XN/hiold+5JA26NqxZCZ1ULMnzq1RJxrcq8AJhmj7eJHHPBngzCMrFcFcPa3B+ZxLLmQCdNNQYhJsOYnDnm+cGU01B+rlHJE5oDm2youCaUg1L58CJ6NM6n9q0jbv2VeDQRI7ynah6X56w6Lc93l5+qBq4CFTdWcU85RGNdO8NY3XMyo0x39fRDgb8o3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUyGOJxm7fFKK8bUKAbMyoTPJwMHu1nDFGng9Z/2EPk=;
 b=Q9B2jmdd0oS5C5jBXmwdlO7TQJ+u6E031NHlFnUBgFIih/PW56X+ZL2GKCS+5rDBy/OhlIjjtdDMl5MwiM11QFl/lPUCHV5U/eEjlo0YCOeDDqP7vT+d7jKpB3lTdO/EkAIR9j0YB4PWiqX8ddmmW8ewrXwpBgujt2zhJUs5A+YRSpu7qK8TF4bybpW8BKiadgzfw0Bgfv/PBv1eB63FFEBAh+/95qNRtM6LE+4nHPLB5Su4dEi/1IdUg3px4M3gBKEIXgOsQimCyPnIJWKLwuljS00QiXHztKwBEUhcvBFNHUJ9aw6EDR1MeGhAFGgD2UO0eIjb0kOjp8ZKVvp5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUyGOJxm7fFKK8bUKAbMyoTPJwMHu1nDFGng9Z/2EPk=;
 b=AEYnIc8WMtj2ufH0Z7VCFsf1LhYJjHqCdAKUzQluGOPs+CIaJ2Vsm+Opr1XOHhOdAn9s8/qOEP4mAPfnMXSpzAxsFheIb0mglyf020m1UpFTjOSoMAv3vojNK3upEEzfzZApVr1+0NOryG1vPtiwvu/5nvz/BRXCGAjewtxNwR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10200.eurprd04.prod.outlook.com (2603:10a6:150:1ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:04:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:04:35 +0000
Date: Wed, 26 Jun 2024 11:04:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: usb: Convert fsl-usb to yaml
Message-ID: <Znwt+vZZ0chXQp+Q@lizhi-Precision-Tower-5810>
References: <20240625022541.2007010-1-Frank.Li@nxp.com>
 <b354d11e-9031-47f1-8a23-bbd14ea3d5dd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b354d11e-9031-47f1-8a23-bbd14ea3d5dd@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c880a5-557e-47cb-e046-08dc95f14a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJQIkdS4EQyQyV0V00jMBEI2e0v92KV+hGvC9kJpCRwQ0Z4s4Pciax7yHbMF?=
 =?us-ascii?Q?Dtqgnzr+dW0f1vgea/2qgNXDyJGv0P3kZ/kTdRyYI18Ljoknsbto/PYXADwM?=
 =?us-ascii?Q?qySIUyccuPMXKSFZAa/kyV02Kw81VQ7Leas2LGbqigCZ1bl7HUCdLKTbB9TL?=
 =?us-ascii?Q?pbqaaFJe15BzDJs5F0zaQbHLdxtmVSs1aIop8S0C8XJCd0fEpaBAwQzDSiFv?=
 =?us-ascii?Q?868tBSkR0mnVRr0atGIwxWIJMq+jP/K96Q2KW2qNB5EH9w+nTrdKYNODMR5B?=
 =?us-ascii?Q?9DeiU8ucNfnmboInljbVPdrsjsy0vBeBS7FdHWHhxAgC+NUGfrasUAtRu6LY?=
 =?us-ascii?Q?qDK6IPosNPx2bnlT8Vo/DbSGVXpsPcKPvcFj+gIIxm7FcrM++wow6yX/rj5x?=
 =?us-ascii?Q?Co/6kAfApfvk3nL0kRlhRf3zNUa79Ii9DTJ3vfDqfM0c6mhMBrexKMhlRyMI?=
 =?us-ascii?Q?b3CPOyShYxR6LRQqrKjAdsUjzGIz54J7g+EaYzOfFkhbrV7K6rd6YO/m4Ozj?=
 =?us-ascii?Q?nfRtjkWqwRjifRJbNdnkjvt5jP1H+LnNFNVZ//zkFWknf9DJQolg3ayavqzP?=
 =?us-ascii?Q?G4Fg+EYYLtIq/Glpg60/PTcqCuut2WCnEDns2RnmjAxAFXIV3b1S19NjSj7j?=
 =?us-ascii?Q?ZtP1JZuT1MRVo/ZfUentSAX0s1gL4H2rz0dgSIRTnhBlqmOG75pQ2Dcj7BV/?=
 =?us-ascii?Q?yr2rWC6Kg6+OKKJFUBHi0+bES+BhENBtHzobcmWvZR1cOxs033Nhdj0U/C8X?=
 =?us-ascii?Q?vxlxY76AVVMv24v7SBYucJniCZFcX1B25utS/6RYcGER5xxxs15mFhsn5Jzf?=
 =?us-ascii?Q?fgvXPJuvapt0Ljkz4qMnV5EXSduQnBbg7uHHpFzPU7U78wFLd5AA6S1M+wU+?=
 =?us-ascii?Q?K5kzkjgL3fT0evHvqxAhebZ913AYvd6XLJX2ky5fTEADmN5PPq6chDYG9CBw?=
 =?us-ascii?Q?jB+NV5tA414n6eoWZLQU4dd2XdLGARSVIwFQBp46pSiA50Mcg36n6yTsI+Xr?=
 =?us-ascii?Q?jFqtiGZbVj9OkepqNdENYcXzmHOnPdRw+pYmRHg2x/yWZ6r1jP8DKexG8QeE?=
 =?us-ascii?Q?ZNmjxTilnutPEKv+Eoy6gMp949nlgDk+lAH/tXSIeQRXrHlvcgEQ/PljQ/V4?=
 =?us-ascii?Q?jn91OeLHhORYB0xGZtBSLjT2g28wCT60yoG+ZIV50iM4ArU3BV/fVvjf2FpM?=
 =?us-ascii?Q?0ykyIGV0uTZ4MfrWfNmCSh/AfdSaIJEQJOscigOhk3lwallcNUCjnx/9zTTx?=
 =?us-ascii?Q?cwThoL9qsPoqq5uDtfZBaO8LYmX7/bruZCCiFeglLjtCXY782UMmblmozCTk?=
 =?us-ascii?Q?DBH1tUVYkE6z8McOHplM/qQvu8ph49mR89wPrzsWDjFLp+utAK0Uh7P9A6o2?=
 =?us-ascii?Q?7rRCcKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UzQ1O/5o7/7+fMotRqZltWoca2pBE4swTVJoBZgXvWgenBoiscalzFUdwJwB?=
 =?us-ascii?Q?6skXJxVXmwV7jFDiF49h890sQ3HKp+JS92VFLPRcJ2cCPe7U1MYziTKbfCCc?=
 =?us-ascii?Q?iHuF2S41Tm+upiag4lrpLSpPoPGjOIf8lI8/+oWbCpRONmr7eY//xTHYOx8m?=
 =?us-ascii?Q?UzcTyc6mBvqcIrwRrahLCF/AXcOeMewPBmGn3TkxGtxKEFJZpOU+y17p9O8f?=
 =?us-ascii?Q?UR+KhVYbIuM5I79QZIUM00LdtN3PtoFSsfO+pyDoxgZCfHlQwAoFKzYroZUy?=
 =?us-ascii?Q?J9vamh+IxMTS8epsoa2RyXNto4FV7BwGI9huqwxuK6HsO7iQpDy3XKJYvrWI?=
 =?us-ascii?Q?guAxHLBZQTITLBmWyUMjku+Elgs5UNFzY1EXRuVed9RrFrUKEmrDAOXkgztV?=
 =?us-ascii?Q?8bhuZS2aAwlGgu3fKA+J1OwIF1zMIBeJ5sJjv9w9Px6WFrReTChMnnmyctRh?=
 =?us-ascii?Q?AxYsOlR2a57ZDfq0xAeUue+yE47szVaSlgqmKsS82iaex4yy4Qo7iTRo7iPu?=
 =?us-ascii?Q?oE5SM5C7CpX8Pb023dghsRkQD+cLRlSDa3soRiDVj80/BAOEwnZXGcrgwy34?=
 =?us-ascii?Q?MywMDopCB3tZCNsdBAeK/oR9juQjULcU70XsoJyki6nydWZ6EWRi4LrwjpHt?=
 =?us-ascii?Q?ZWwxaihBUk71S7rlSoMJ8rL2njvMA7FlEQln8XD21oGRa0u6piF1zaf7gjxm?=
 =?us-ascii?Q?xlAgKM/RK8XMkFKQq7JsOvVaojADUwPJyn5vKe7ItbV77jl+3wsZTPln2MfW?=
 =?us-ascii?Q?2RhoL0eMr39Rgt6UYhqdjPVvo+mc+/1ydB9RDND0RJfSyAjtanbAaKRAjXbB?=
 =?us-ascii?Q?3DJmCtM7v4jL3nyOHMv4U2aIxJCR2AaIBPSkBm04ZzcE+XeEYaZFzgC9t0Py?=
 =?us-ascii?Q?WtetwpwIHgbjSrLkDPtmQ8urS6KPJuCuZW7Aakn1mGvF0HvS7VDiWOAJqqW5?=
 =?us-ascii?Q?q7u+LQo+SWVitkNICEXL7b1c4jWaorkzCdTyKUnv5RY5HYwo+shsEZ7bC/4N?=
 =?us-ascii?Q?7Roxx40se0U6G3vpXbDxL+a8mHSFC/jtzSbYJUj5isgO5I34vJchFPmEQsk0?=
 =?us-ascii?Q?BN9D2M0a0bpRI6/lDnN7heNXAp5pyKaZqtsYGToyEUWdybJQWNo3i+ahNNZo?=
 =?us-ascii?Q?tIn54BL1bb4Pu+Dz1Zqyi+p/spOI3PILbBtrYTlLvWPB4FUe0W21G3C9LKbd?=
 =?us-ascii?Q?Ll1pkDoGU1hizTio/WJUjUB466gGtA6SoolztGMziZDys1CFZT/L7hBU4rKE?=
 =?us-ascii?Q?zhS1GFNHKo5NtD8lsgS/PE4R2chdZdyF+xqeSt5/wSEMorFouTKRU3V/k1UG?=
 =?us-ascii?Q?G714TNjrd6OviWHakfy50X8v9j6s+IMX8cJsuAohfIvwIgXKLRayNLlBqS1k?=
 =?us-ascii?Q?j+/QlzKDJTGZ9VD3jSxONtpOxxfwFMcTx4CiD4bFSC0k0i8MeJFdQlCpPbLS?=
 =?us-ascii?Q?3UUyTk30b80iW8rYW96CUNPxzuyjsWScJ7TPyLyYY9wgtODQR50XljHeCtQR?=
 =?us-ascii?Q?wiJxPfxPSxpQM/Qkxp766tq6HHWl0GKmBudSVzPBAANOno7j3rYSkBgOIEiv?=
 =?us-ascii?Q?a+oDJJEnneUxnh7YjAEpMcmkmHAYvBvAn8PtmLW4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c880a5-557e-47cb-e046-08dc95f14a76
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:04:35.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwz6kjNQrXrIdM9WK8TCwAyxsG8Tn6CXha0KwWCtEasUViTzPZPxhxDn1Dlu1PMGMarj2VZCGCvZrwdwOXXefA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10200

On Wed, Jun 26, 2024 at 11:26:18AM +0200, Krzysztof Kozlowski wrote:
> On 25/06/2024 04:25, Frank Li wrote:
> > Convert fsl-usb binding doc to yaml format.
> > 
> > Additional change:
> 
> 
> > -	usb@4000 {
> > -		compatible = "fsl,mpc5121-usb2-dr";
> > -		reg = <0x4000 0x1000>;
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -		interrupt-parent = < &ipic >;
> > -		interrupts = <44 0x8>;
> > -		dr_mode = "otg";
> > -		phy_type = "utmi_wide";
> > -		fsl,invert-drvvbus;
> > -		fsl,invert-pwr-fault;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.yaml b/Documentation/devicetree/bindings/usb/fsl-usb.yaml
> > new file mode 100644
> > index 0000000000000..8b5724e213f09
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/fsl-usb.yaml
> 
> fsl,usb.yaml
> or: fsl,usb2.yaml
> 
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |
> 
> Do not need '|' unless you need to preserve formatting.

dt_binding_check report error without '|'
fsl,usb2.yaml:15:11: [error] syntax error: mapping values are not allowed here (syntax)

"Practice:" impact yaml parse.

> 
> > +  The device node for a USB controller that is part of a Freescale
> > +  SOC is as described in the document "Open Firmware Recommended
> > +  Practice: Universal Serial Bus" with the following modifications
> > +  and additions.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - fsl-usb2-mph
> > +          - fsl-usb2-dr
> > +          - fsl-usb2-dr-v2.2
> 
> It cannot be standalone and not-standalone. Cannot be both. Choose one.
> 
> > +      - items:
> > +          - enum:
> > +              - fsl-usb2-dr-v2.2
> > +              - fsl-usb2-dr-v2.5
> > +          - const: fsl-usb2-dr
> > +
> > +  phy_type:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ulpi, serial, utmi, utmi_wide]
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  port0:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates port0 is connected for fsl-usb2-mph compatible controllers.
> > +
> > +  port1:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates port1 is connected for "fsl-usb2-mph" compatible controllers.
> > +
> > +  fsl,invert-drvvbus:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      for MPC5121 USB0 only. Indicates the
> > +      port power polarity of internal PHY signal DRVVBUS is inverted.
> > +
> > +  fsl,invert-pwr-fault:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      for MPC5121 USB0 only. Indicates
> > +      the PWR_FAULT signal polarity is inverted.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - phy_type
> 
> Keep the same order as in "properties:". Preferably this order, so
> adjust "properties:" to match "required:".
> 
> > +
> > +allOf:
> > +  - $ref: usb-drd.yaml#
> > +
> 
> 
> Best regards,
> Krzysztof
> 

