Return-Path: <linux-kernel+bounces-192550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121978D1F05
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1891F23561
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBB317082C;
	Tue, 28 May 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aRKXY8SW"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE016FF4D;
	Tue, 28 May 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907161; cv=fail; b=KLEbrjPypfHcpnmIRkNp79m0n9siTwLYpkL4/4aSVDUd005GhNNtZjrLNfZ3ODlAe862COpLQ07Cnj64ImDh8vX3TE1HxjnD7HyNw4ZLXw9lKQ8NTJHV815Ne8n7kpKjuOOkt1Z8T578Gx+ino7LPn4h501TlRtLtjK3zx1G2r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907161; c=relaxed/simple;
	bh=xCCkZj4E8rRA74hj2Hd0ShHoenCHuPpN6Q3PyVT+UMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YDjStLOxgH4kbqcwc0yUZhrrLmmmdDbf9mIv32+RHp5HLjIVaYNI7muI4vGxz2bZM74/rxFwbWrBefd6YUiv6ztg+fu/QPddhuoNyouHYw2R1bdB08+HAHs6NC4KQZNU3ksnZivr7ujnmdYcT+lwwhN4gglGJb9jvn+mFO+T7P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aRKXY8SW; arc=fail smtp.client-ip=40.107.15.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLl+8nAlCHoW6N2zozSTibZaWOKKF2pWVlQzKnkTQpEe0Aq9rVi1+6/kzJOoTflWVtiG9Mh6efXEYeCZy+oe13/6tJ8nidLO3qy32/3hMS3UPwEYQKzSLZdoJcOBaIGm2J4axQxe4TSBEpRlhPfn0YIY5qaFXcNBh/t7RGiXrV1mCKlhRSfMeTZLlQhkiH6ATuB0zY9nRoEqwxHEButLx65axmdqPXSJ7Rgmb26LIs6rF5T9Q+0vedESHqEUvb22mxOF1/IjNVf1oC6tqY5/vEaQM1gJ14QGkku8OTBPtf+CV6bPx11qEn2eh7Kgl08ZLWJG2DDF69yXRqQLXg/PJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwehUeaLAWCuAwxZ5P6xrMQNOjFvLrVclsQyxf6KSJw=;
 b=Y4n/faieuct0scxySH1CfQcpbDHCICUywcTBUoVZazYp5C2fPCN6Zi++L53/pNC142TtRj44HYjU0eN462+LhTh6OndTT4pCtJQGmzfUGKKoAydXgm+PRAHd4iD59mnOqbDK0sYHR4ohVLkwgPtdL6qkAdOKWbG5jnmT88iO4ob3BtHGXQkMmlsu4dVDDRlAIhNhG4l+zAeBH+rJofe9zY5617TICtqAIX6Z+xfjvsNbmbgUJPVikZ30S4kTLPMQLHgHmktwZ+obfWsfgil2QDUyu9PeeX23i/rIucw21HQxbfdvyLFw3w3cqCbu/NQWlK9Vz5gYllP+UhNtyhzLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwehUeaLAWCuAwxZ5P6xrMQNOjFvLrVclsQyxf6KSJw=;
 b=aRKXY8SWluQi1Ny3eDAH9VfScui7jx8iSNBunlaR0qwJcxqYCSDEJgeW0miTrTh3VZs/CGxRXls6KNi6KCPqThoBP0HAJoDFI6FZSrJXAyqsnBS0FctqKbPLrfcer4plKQiZV3cSHVGL9rcNhG7yeDgZ2f9++2nel23KXt5lmnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10405.eurprd04.prod.outlook.com (2603:10a6:150:1d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:39:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 14:39:16 +0000
Date: Tue, 28 May 2024 10:39:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: conor@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <ZlXsi8IFMyDjSJnk@lizhi-Precision-Tower-5810>
References: <1716865154-25044-1-git-send-email-hongxing.zhu@nxp.com>
 <1716865154-25044-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716865154-25044-2-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10405:EE_
X-MS-Office365-Filtering-Correlation-Id: 4556e5cd-db86-4ecf-ff14-08dc7f23f33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|7416005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vLLPRh1BE6Es7nUCF5o59dgaoA/YCMrmXQipo5TXvA7Md0Zk4KLhJCBLb9JU?=
 =?us-ascii?Q?IyXGj24XReg/52xUBUkBf6MMpt37E8w0Iyf4puODvv+jYJI9xTIAOLLnbjye?=
 =?us-ascii?Q?BunN9UtYykgkF42yy7lJdz953e3Jre0MOf8hH5i0NwkWiQWLoWjHolzDlQ2O?=
 =?us-ascii?Q?oFZHBsSuesx66L+d8EwHuIXTOSbYVOJd5W+UGQZZBojmGCpeDcFvaewthIn7?=
 =?us-ascii?Q?ZoOocBCLcVj9KLuPEU7P6Ao63+0AcYxR6WQeHgeN8qUTYEDPzrZ7LP3+Jkrb?=
 =?us-ascii?Q?3J7HPZw1mIIYHi2uxaDJCo7jH569UhB55jVZGPp/47xPlVobY+GtO0B20Fs/?=
 =?us-ascii?Q?c4MzunMuIBiurecfYoGLWgySM8tbbrpygn53a2M6TYYqw+jyQNsLSQ3KGNln?=
 =?us-ascii?Q?PT5yl/JuAVqciLRHgocCFPcqdgb7oE0HFMqDfGA+FtETNkaXhOc/yln1HU3i?=
 =?us-ascii?Q?D/seG5w1FSJFBjoy3q3CzoA7Dik+CoQc7s10Iwc1y0yJnZ9g6oucNXZP+lds?=
 =?us-ascii?Q?g3nlFxKZZv/YUtJY3A7IHo9+aRfk4FpVcu1d/yKjog2sEMmvLAxNhf+f60D2?=
 =?us-ascii?Q?+1LOfarN0KhC+7UpzGeGGFomUgRbFMh4gwHYQCjziNPayJ/5Rby6X0waJsJC?=
 =?us-ascii?Q?c4K8gSxMcgHVQvwzJOufgKrs6kJJsAhYulqghbS/9E5RuGvcFcUOTlWPKPoK?=
 =?us-ascii?Q?mpfHOtaPNQ1QXzIlL9TVgxDS+or9KFTIJ15zbNaUP71b452RuaXaSBSJxKdk?=
 =?us-ascii?Q?WSOMzP1mMz0rZfJuDIZp7joukfqPFHwEmNQhmZ7mYf61RubeHHg2k+rZ1ylJ?=
 =?us-ascii?Q?Vzk50glbc4I/XhxhgwatOW4AdUqcHNcPz0TgA+ttnE690D0uynUQSifNH6oM?=
 =?us-ascii?Q?MDZ/vScH7lZz2D05ewHv+KBqcW2bUxiTGaup1k/WQJ42bxU9csS1jmGTSB9Y?=
 =?us-ascii?Q?+IM4ehscviGAAn5FV6GSfg+yVX1SXwowqLKs/hytD+caRes9DZbWV3cFz5mL?=
 =?us-ascii?Q?iJrJl8arz8LjICcVS1kZoY0qj8LXaxDAc2HTuHlpPEZ7sNS2Krh90T3tvY2q?=
 =?us-ascii?Q?/Wqfe/3qHCAJjIPs8W4A2k1vxZi2RyUzFG+1TW1/Pw/O9do+GogFQ4Fo9X7B?=
 =?us-ascii?Q?l4PtTbbNGiqith+cWZgozBX1hkbfFtICUcEMZZiXQQJLEQoLLPDYBCyO+kQj?=
 =?us-ascii?Q?JLrGy4oBWvt7HpO0NiSY6y+P+LE+rUHfqMsYLjS3Z8qHlFNzAzgN+x+RwLCy?=
 =?us-ascii?Q?0/CTyrBjPkGvhRejvOs5WrFbjdnUJwxUepSDXryx8BGb19BKm99cd35yrHoj?=
 =?us-ascii?Q?q8k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17DmoyAv+XbeZyto2fgne2dDeVCJD7YNB/hhvp0e02ntZgESZfy09Mj53egn?=
 =?us-ascii?Q?64dafCEF/81Me+ncKZDR58fkDAd7ADZ9sjMUfULaYlCwXXxKvn7+NbqnyGgO?=
 =?us-ascii?Q?xoYR7Qivs9yAdv7dR8c1PTWAinWM3UFbeXGEMkhhUsCA+hVJ5oFwJmn9GFIg?=
 =?us-ascii?Q?hqFT34l00RyxwppGUfYfT1xLppyLEoAqID3XfyzGDATZnOEILe8/wMooxHvf?=
 =?us-ascii?Q?DjaJpLGsudiDx5nnGNI+QTzo5AP3O+LseX7q+LebO5rw2vd9cKnkDGMoa4va?=
 =?us-ascii?Q?gY8uX+OkW4VxPTJzPEi9tO7Mr0NFS6myM+e+lb7ipQZ578iuhTviGqye8lAQ?=
 =?us-ascii?Q?SMUPhQuTnUijhxGxDfNfIpPU75jp9a6V6ZjnAgHPuCQJ/9/OIn8TavtW4q8M?=
 =?us-ascii?Q?2tbjARVeR6B/yxzblWdGpIPKoEHQoBfmjAiA/nnDibEbbS+bC8TTKuv99OWj?=
 =?us-ascii?Q?2PtGph3bf8ynvE5/YAt5XoAMnK95zDmbA9zbv8JMJQYM0bVRgB/Rfm0q/cJL?=
 =?us-ascii?Q?6j+DZoW6p41nRQPgu/yohYJLe+8ivNFg4h641efmb2PJfnvtUfAzrPBdHPey?=
 =?us-ascii?Q?OFR2fLczA1wf1mxnwvVAkzWsW5OE9aOO9YMF0PAj1APR9TwRm97uOCkYzioK?=
 =?us-ascii?Q?O4UQsO7tvWkMYvK5PsaVTt61feXBAY80HXioWLJHb0hmmojKufAbAC8TtoSV?=
 =?us-ascii?Q?pCvWbSfHqmJbDjYM/lHLhLFqqeRakux3bHChsx8+ufXUo6jQqtOge+++9now?=
 =?us-ascii?Q?jmUJrlQQRs+sOy8RLikPmjnJp/AuE7Cwahwu9CthpCJ9n6XWk7oBL8gpAu7h?=
 =?us-ascii?Q?X0O59XC8m+McxCkKmlb2VZuNtjL49LDV53zY902WW5NT2ue2oy1QlTVEWpQE?=
 =?us-ascii?Q?JgwZG/RtunvRHH8/wafCyQJHzNi1Rri3j7wAay4zk2oMu+h4vlFUWchjt4fI?=
 =?us-ascii?Q?iy02DgcyZDWAg9R2FY4UQyn3S75nHKTunMhf4bHFe984z/npfbXonjIK4Jrm?=
 =?us-ascii?Q?PoeoU509Bipyi7UxLHk19cEnK5YLBXsd/TokhE4xW7fR4epq8egfIbPNg2uj?=
 =?us-ascii?Q?NhTXCrjxLz8ApvQvyit6HzsT5xiGFgr0CpPt3LQL/2KbmA5eqEKaO3XYjmoa?=
 =?us-ascii?Q?vPnZ6r2gofywHga1QBnSTm0YPnBWx6sdKk8wpmANb+MRsVbmEVBcy6PMhVU3?=
 =?us-ascii?Q?tt+bcrr5MxSkRbQOkp1x2Ud9NWA6LgMrJGOnoMmyJNp2aQHlBaKaBV8sPVDh?=
 =?us-ascii?Q?2kCfHZucFsjdq9mfKyFESTiMVAmVp0N3/r5Ee+pYBt0IGfxMdXds1aaOvgW2?=
 =?us-ascii?Q?bUVXtBUJ68vEkQpk+MJU+bjfItg72EX+PpfP+uNCBPkwLuSdYI4VfHA3VK67?=
 =?us-ascii?Q?H56z9aOLjKZP+Evi6vtK02SImx0XAb/0b+bRgd9IQiogc5kL2avBz/AVLuOt?=
 =?us-ascii?Q?xB3nvDeY0S9x8fnLg06tyQF4QeMCYTs3VW5jYiMKFmbUSWl8bfdxYQM+aZ20?=
 =?us-ascii?Q?jdU0hkKd4ekwjWwmZsXy2rkNv9PBDn4/krDNfmg+ZEHTBhXciHROA81KItFX?=
 =?us-ascii?Q?KAxPtjpaPrAq/ceVhyICGjG9d8YmGpfNY9jicTLb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4556e5cd-db86-4ecf-ff14-08dc7f23f33e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:39:16.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae+vPYEpV7DPxaZsj9MYqZ53M3vqpmD28zL9BDp4Yi0X47OyepkWLm7VRIeDUXq94VWIPUFSfRgYmMvwdtlB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10405

On Tue, May 28, 2024 at 10:59:13AM +0800, Richard Zhu wrote:
> Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> Introduce one HSIO configuration 'fsl,hsio-cfg', which need be set at
> initialization according to board design.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8qm-hsio.yaml         | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> new file mode 100644
> index 000000000000..8af342ef3be3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8qm-hsio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8QM SoC series High Speed IO(HSIO) SERDES PHY
> +
> +maintainers:
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qm-hsio
> +      - fsl,imx8qxp-hsio
> +  reg:
> +    items:
> +      - description: Base address and length of the PHY block
> +      - description: HSIO control and status registers(CSR) of the PHY
> +      - description: HSIO CSR of the controller bound to the PHY
> +      - description: HSIO CSR for MISC
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: phy
> +      - const: ctrl
> +      - const: misc
> +
> +  "#phy-cells":
> +    const: 3
> +    description:
> +      The first defines lane index.
> +      The second defines the type of the PHY refer to the include phy.h.
> +      The third defines the controller index, indicated which controller
> +      is bound to the lane.
> +
> +  clocks:
> +    minItems: 5
> +    maxItems: 14
> +
> +  clock-names:
> +    minItems: 5
> +    maxItems: 14
> +
> +  fsl,hsio-cfg:
> +    description:

Here need "|" because you want keep format for below table.


> +      Specifies the use case of the HSIO module in the hardware design.
> +      Regarding the design of i.MX8QM HSIO subsystem, HSIO module can be
> +      confiured as following three use cases.
> +      +-------------------------------------+
> +      |                | i.MX8QM            |
> +      |----------------|--------------------|
> +      |                | Lane0| Lane1| Lane2|
> +      |----------------|------|------|------|
> +      | pcieax2sata    | PCIEA| PCIEA| SATA |
> +      |----------------|------|------|------|
> +      | pcieax2pcieb   | PCIEA| PCIEA| PCIEB|
> +      |----------------|------|------|------|
> +      | pcieapciebsata | PCIEA| PCIEB| SATA |
> +      +-------------------------------------+
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ pcieax2sata, pcieax2pcieb, pcieapciebsata]

how about:
	pciea-x2-sata, pciea-x2-pcieb, pciea-pcieb-sata

> +    default: pcieapciebsata
> +
> +  fsl,refclk-pad-mode:
> +    description:
> +      Specifies the mode of the refclk pad used. INPUT(PHY refclock is
> +      provided externally via the refclk pad) or OUTPUT(PHY refclock is
> +      derived from SoC internal source and provided on the refclk pad).
> +      This property not exists means unused(PHY refclock is derived from
> +      SoC internal source).
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ input, output, unused ]
> +    default: unused
> +
> +  power-domains:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - fsl,hsio-cfg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qxp-hsio
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pclk0
> +            - const: apb_pclk0
> +            - const: phy0_crr
> +            - const: ctl0_crr
> +            - const: misc_crr
> +        power-domains:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-hsio
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pclk0
> +            - const: pclk1
> +            - const: apb_pclk0
> +            - const: apb_pclk1
> +            - const: pclk2
> +            - const: epcs_tx
> +            - const: epcs_rx
> +            - const: apb_pclk2
> +            - const: phy0_crr
> +            - const: phy1_crr
> +            - const: ctl0_crr
> +            - const: ctl1_crr
> +            - const: ctl2_crr
> +            - const: misc_crr
> +        power-domains:
> +          minItems: 2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-clock.h>
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +    phy@5f1a0000 {
> +        compatible = "fsl,imx8qxp-hsio";
> +        reg = <0x5f1a0000 0x10000>,
> +              <0x5f120000 0x10000>,
> +              <0x5f140000 0x10000>,
> +              <0x5f160000 0x10000>;
> +        reg-names = "reg", "phy", "ctrl", "misc";
> +        clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
> +                 <&phyx1_lpcg IMX_LPCG_CLK_4>,
> +                 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
> +                 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
> +                 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
> +        clock-names = "pclk0", "apb_pclk0", "phy0_crr", "ctl0_crr", "misc_crr";
> +        power-domains = <&pd IMX_SC_R_SERDES_1>;
> +        #phy-cells = <3>;
> +        fsl,hsio-cfg = "pcieapciebsata";
> +        fsl,refclk-pad-mode = "input";
> +    };
> +...
> -- 
> 2.37.1
> 

