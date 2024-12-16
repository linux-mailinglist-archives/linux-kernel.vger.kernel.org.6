Return-Path: <linux-kernel+bounces-447684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4329F3603
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AAB1880A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3EC2063F4;
	Mon, 16 Dec 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MVprC4s/"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08E206285;
	Mon, 16 Dec 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366434; cv=fail; b=NgPDPdNTBcvH05bjDdxo6SzI4DAGRaU+Pk7mXK9GCOo81YZ0CVc9YyhRUmT/YzSs/Bj+P5n2m7FU6Xia6WA4WYzccdtveJQ+NPsSn8vJAquclcMpQmPzND0X5RUAet9HiPHKAwwch5HLqltWaIMzvALZmBJAHhQ1Zj9H9nhjs0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366434; c=relaxed/simple;
	bh=WhtktAtS99L+V1rkmU7C06dAn3GC6bXa/fCsNf/aMek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ChSejUX7GQFDDJ3b4+qW7dFX4zgd7sGLNSx8XOMBp7NP7YMD6sxeRphP0JC0fVy3l41cgz2IyZDtTjVR8oKHHvqJeiggZdRKTs06c9DdglphIzJNLr/IHzTS8OUsQbgNtPNBcBpF5z+6HQVYwhj+Y2qLqZNZ59SCoT87PT9Ylck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MVprC4s/ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnrzDpyE5rPaFWfoxYoVRuHTHV7ccwtovYQftylNE3k+OecWYrpVASBkkeiZxGs/RuUvFsScKQXyvwqoD2qR48jd2HKdvUe6ohpRkoBS0GzwWYs2buPWvXOUBu1DSYhf9XNaqGTE0xHry4lrXhmBjf9uyMkc8cSuFFlm7g6490FI+oBYmoOnv6neOu7pKammF+KedtRm2qn4Hmk1+5Qkk3C4yPxx1WHXTkilHwFL5RpFT5j+uhGYanuEERxoxIuj5rX5jxiIKZmmnUxDJIEEBUyP0+VU8cvuLwjPaoD/uGFYMMhjXqn1gW5JZ3fhM18op1g/knSj2VszpppTvpfNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxdxWjNsKz6h7IIkV/aGNV0SlUAqj2pN5LFGrvXRrQE=;
 b=gFxwi2ly2flQRCkvh5qasv40aJylKuM3LNUdsnwu1zZ0Ul/RhlSqpHDz5a93JcYUrevAkRTKiYaojdlswQ4rScYF2s0Ex+v+w4/U7iPiWx36C5y1eovQgxbndGKpPbgtgsbwpGqco+NHSCoOUJOnFolgrW2c6TI01XZYbLTS3DT0hVuSpj3Pr2DNCrXIDnwjIyeUUvJxs1JVBFjqPFgCx0zp7hQa0cvHeAEfpYj0QMPw0qTq65HYxddL3iNECkNrEaqyZpHGP5ca+snGkGLVvSOopSNJpchNhNWJuUDQ8spfcPR5uqfCFQUbr3xbiSinb0akGScxrjcFP5XISM8gxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxdxWjNsKz6h7IIkV/aGNV0SlUAqj2pN5LFGrvXRrQE=;
 b=MVprC4s/+rhOcH4/gj1EDOveAhIgxdz506wC1+2bjGpVgyd1esgu+bxt4mN7jzRI5GvtSthiiqLGTyjF7bI1CdnnV0bHoBlB/+XfdLTqh99JMNZ1rnYcrlGeVoSbk88xlBBym9kvpOK+XtY+MW6o5PkUOUewaGUhaO8KqxaVxHrle4RkdM81amupSIQd+C6YRMs2VgQFD/G2GIUY0qU2HwUhemZ9jv5oOOviaRQ9xNuAnaPR6X2QouhrABuKOIktBZew4z/H3bFobfHgqR94z/YIlOHUHLnixXXDrlLFYKzdFfarTPVHGCf/X3M9EzZ2ABFEUD/c+ZkCuEALkV/frg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Mon, 16 Dec
 2024 16:27:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:27:10 +0000
Date: Mon, 16 Dec 2024 11:27:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v3 2/2] regulator: pf9453: add PMIC PF9453 support
Message-ID: <Z2BU1itPMjVQRMkW@lizhi-Precision-Tower-5810>
References: <20241213-pf9453-v3-0-5587c1693155@nxp.com>
 <20241213-pf9453-v3-2-5587c1693155@nxp.com>
 <689b1095-0dfe-4204-843d-5a7c23213aad@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689b1095-0dfe-4204-843d-5a7c23213aad@wanadoo.fr>
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e2d6e4-7759-4509-3a9e-08dd1dee7d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?EK56gFmlvdIMDqtXxNOQgwSn72yWpGO/Sil5PhP3Hwk6jxz8HjFySePeqV?=
 =?iso-8859-1?Q?hOXvK/xjOtXP3N+KvHaOZuSHkdDC3Muchosos+V2sUip4QPCUm6QQi7Cfp?=
 =?iso-8859-1?Q?0PPyXQxvTOeUQtSopXz3ujhG3cWhdQMTLr+gf9/v/2Fks6LaZYyaawZH6t?=
 =?iso-8859-1?Q?LpDJ119GdDd8uP/pdPuwNlNaeWG6q+s0Vi82LTgTCKgj04eExDDtjuDu9A?=
 =?iso-8859-1?Q?xdVp81kjUQDVBTa5vEk4G+YyViF3IvTQZRbXanTyv2W5G0fi6/H4pD2D4W?=
 =?iso-8859-1?Q?D/X9HK+ym/F5r+meyVXpLZk3LN4MHUX5upLWvFD8g9gXsGA/+lThjdEWfn?=
 =?iso-8859-1?Q?dsKtfOmNuS0pCwepvC7Bk9LVHABPWkoTqozsyB1AmTpMj0MDROWSDP+WZm?=
 =?iso-8859-1?Q?I4mGvHWG77mXc80/xiyk8HbWwelgrgzPMGPIhZwtmEZlf8ca4PwPTt/HDm?=
 =?iso-8859-1?Q?pyC7lZs2Gajm/AVN9xaB4a8fTRbzz5fnKjVk877KxoNNZVmYvM7I8DvDVG?=
 =?iso-8859-1?Q?9SfJGJtBZzo/yY/qeVt2cTQnMLHwcVoriX1iItGjEYCFW0E0ZiwhlgDTv0?=
 =?iso-8859-1?Q?xD9Zcd5o1xnJl7nCxoAwo84yjsVGE598xYgyV9i4KrpZFiXMhHt2F/QEeU?=
 =?iso-8859-1?Q?QK12aBen8eqwcsDShjQpWX/vZl3RgBC796dyu0Gs0rhjw1y9Pg60L3N1aq?=
 =?iso-8859-1?Q?AEqnMh3ab/FEADn6OJIe2NXn1Ggy1BEVTC1b30sSz+Uwa7NqwI6ayCzlDc?=
 =?iso-8859-1?Q?oi8aiFjcpTs+5weTR8hUasdD3FGoe8IcOxPNSAvv6tvDAD4fH4I90Y9gXU?=
 =?iso-8859-1?Q?uUPR7ts+jhbUhY8z2QRbA+J00HjjOe1oktFbYGUwpESRaGO72LkZ3i66Z2?=
 =?iso-8859-1?Q?G0WxxZQHF7WrjJsSpCHE00kPbRbnTg/RdxBfOlaGH1hkQ9besYRXTq5u9D?=
 =?iso-8859-1?Q?SGg5BLbAkAKLuYpcaOoZZX7zQan0MzgZREQCdhyQ7K6g7le2K7ERB3U2Go?=
 =?iso-8859-1?Q?xk8cMzkSynCzNcb5YoeGpkU49fEDzZsD2Snd6Z7nloNDTBD3UHAUM3p+a7?=
 =?iso-8859-1?Q?4uS3QxecTU71ECETLdN0WSefP6zIyS7Dgo9prMbV7Mre76RdokyqHylixg?=
 =?iso-8859-1?Q?VHL7gbHIG5FDrFQ6azvZ2RTueYl8+fPewrLZOleK88JXTEMzWZ2o4rQtjc?=
 =?iso-8859-1?Q?lLSIfYiVNez/SP5bpdeGaNN54ntu6SZy7ecIHUH/dV6r1f7OHJ4aYEuyrF?=
 =?iso-8859-1?Q?FzUqLPz9VT+e2PszQfyYhjh9kHCUZcqsdEqnQnv5n5csZzFwJjfevT2Gtb?=
 =?iso-8859-1?Q?t8m7V+OfEJMoAYpLlWC/EuAfE/7lB9m+1Cx1OgyrVOJRLaDGaMQdgiMUos?=
 =?iso-8859-1?Q?Ypyb624BqyLDeVyCKoh548od+My2PEs7JUDutFI3Cyz57a68yqGL795gBo?=
 =?iso-8859-1?Q?RlmVm5ZKiwabIq7rsWOjNoMrVW9X2/lWdp2rHbWU6SO/DoUrsRf7omyfZU?=
 =?iso-8859-1?Q?tzc1vfhalNSQgF6isnfmin?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?UKkqY2XQiYLPyumlQ2ohq3oumRsLdCpngjEnUHtbcn2wiO5tHvxlUTpzGW?=
 =?iso-8859-1?Q?F/5Ua2Yv6MeKXpIH5ekg/kc2tIl2IoADLwRKK9XvC8GoWBh8Gvj2juA6B/?=
 =?iso-8859-1?Q?YOwKYvydUyt07sxYGQo93RZmkTZACwf4ysa8bWRskMhqRb0zCIPibj7QBg?=
 =?iso-8859-1?Q?Q2YIyF+NSJ65lLB1WSoBvji0g+JFpW4a2sIs8FoQE8eNyFXZZR7bn6Nhtt?=
 =?iso-8859-1?Q?+/PndiiKp34Wyqaw1ouwK0blKKs2AF8OHKTN4lKIKRelTjlQhkEfxuIO/P?=
 =?iso-8859-1?Q?jUlWY/RmSlU/VR/SfcoRg6kXeKYAVBkHFzyrDw2gW6c/9AnzHTP+sEYYT+?=
 =?iso-8859-1?Q?rfEa4eIUKvKfpy6RCyNCWzrJgtmaCp7Oeg/k/3sUBaLdY/Novwy9OkmIz3?=
 =?iso-8859-1?Q?mtHDlO+HVYkwr1gq/u6bDsIQMo50PatfadC6vGQO4ZKBXq6M+eaSbr7M98?=
 =?iso-8859-1?Q?vRwgw51n1tLAAmk67OSasULwcAmu1XATEMzjY0Lazn/P8BLZrIEzz/ngbG?=
 =?iso-8859-1?Q?r5so+pDSp3mfCdH2HwyRh6yq1IN3NBTrHMUVasVhs0Z8/vCkdhWTWtHbGk?=
 =?iso-8859-1?Q?gWfEVDt3Hg4/P6crsSMgi3byTaFtzmiCIHVkufqiwH0m1uD/5+JjqXjjiT?=
 =?iso-8859-1?Q?YkzimOe6Fc2BKnJNgu4AZGAYqENqDG5R80e6AFLJlmLTddsTni6/5UM2io?=
 =?iso-8859-1?Q?2rlAvcxoR5ceABhTOs8FpojdJ/dnysxLFvjEneHHwBVPN8bTRBz5XMTE6E?=
 =?iso-8859-1?Q?d3feRi7JfDflxabfq4KeHURJ+AdaUChihMC7RYKj2p4eLQQF0Gs9JOdFCz?=
 =?iso-8859-1?Q?OMhe2y5qGlQbuEcwokccMCIxFgs9HHcJRWPzW+Yg9pWcHsFFEXOOKAlcwg?=
 =?iso-8859-1?Q?xj19HJ57NP7RW90u+TEz0rL6gsjAMSh6pVVmDsAm7Qo21VdtJT5/0tgUm5?=
 =?iso-8859-1?Q?TRtE8h/yt4uvdBDsg0PXetzIURGE7YTIjldxPdScWlWnuJgcfYrDuYPHH+?=
 =?iso-8859-1?Q?ssIuV54ZICM/ABpuPJbb7GV2+iVkTLEwG5AXCdWqeuQbo7Elsr9NYIpZD6?=
 =?iso-8859-1?Q?tkubw/9t35TIB8IYsDhDMpNd7vGbw9NiL8bJOtxAwS9coSUXLwELPPpaGc?=
 =?iso-8859-1?Q?ZA3Iq009m2vU4NMQ1pAYisTf9wzhsCZg2XKf6dJr44RreVprIEh5KeEF/p?=
 =?iso-8859-1?Q?lzHqYLY2jTzLRCnad1WNOjg4CPnocLjnYeBzLRsQBYefcnPOHMp9+nBRjf?=
 =?iso-8859-1?Q?Iq8C6h9piKxGVUiVg+lnFfMsPrVLplAfUZKvOhphAclMOI+B9rYndzEJu3?=
 =?iso-8859-1?Q?ZfIviBSJT9rMw3Djd7vaXDHfH0Rswa9NhbZSqg6E0U5wrYTTi0Cdq30ZtN?=
 =?iso-8859-1?Q?VkDrGOW7GC9XSyz7C0QYXVLhb24M7EJi5ap2eGY9qVpID+V/FJ7lfeO2a0?=
 =?iso-8859-1?Q?+AzgRMxq7nwpaPxYG184bF+S7NLDueoc0MvRqZeWn7DPn+iMZw9xs0FHNy?=
 =?iso-8859-1?Q?hzF5zxApZrp4FK5Ujv6i4mll6ILe1BhxeA85gNS2l4/w19mvbc7Q/b44Jn?=
 =?iso-8859-1?Q?irRVzoqsRmZ+BBeR+8yof2swRdaVUoFJMV7hr78vvUW6evcOC4IXnp5uzB?=
 =?iso-8859-1?Q?1p/mp9kBh1Xfo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e2d6e4-7759-4509-3a9e-08dd1dee7d58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:27:10.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyHM8udqfsV9yqSjr/9C6GII5bjioB8ByX4FKhXNduRLIyQkuQJ8DWWofdJGLCaCVOkntTJBpgeC1gRqgBoa6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9287

On Sat, Dec 14, 2024 at 11:57:59AM +0100, Christophe JAILLET wrote:
> Le 13/12/2024 à 21:46, Frank Li a écrit :
> > From: Joy Zou <joy.zou-3arQi8VN3Tc@public.gmane.org>
> >
> > Support new PMIC PF9453, which is totally difference with PCA9450. So
> > create new file for it.
> >
> > The PF9453 is a single chip Power Management IC (PMIC) specifically
> > designed for i.MX 91 processor. It provides power supply solutions for IoT
> > (Internet of Things), smart appliance, and portable applications where size
> > and efficiency are critical. The device provides four high efficiency
> > step-down regulators, three LDOs, one 400 mA load switch and 32.768 kHz
> > crystal oscillator driver.
>
> ...
>
> > +/* PF9453_REG_BUCK2_CTRL bits */
> > +#define BUCK2_RAMP_MASK			GENMASK(7, 4)
>
> This was 0xC0 in previous patch, so GENMASK(7, 6) if I'm correct.
> Which one is the good one?
>
> (the datasheet I've found does not give any details, so I can't check)

Good capture! It should be GENMASK(7, 6)

Frank

>
> > +#define BUCK2_RAMP_25MV			0x0
> > +#define BUCK2_RAMP_12P5MV		0x1
> > +#define BUCK2_RAMP_6P25MV		0x2
> > +#define BUCK2_RAMP_3P125MV		0x3
>
> ...
>
> > +/* PF9453_REG_LDO2_VOLT bits */
> > +#define LDO2_EN_MASK			GENMASK(1, 0)
> > +#define LDO2OUT_MASK			GENMASK(6, 0)
> > +
> > +/* PF9453_REG_LDOSNVS_VOLT bits */
> > +#define LDOSNVS_EN_MASK			0x1
>
> GENMASK(0, 0) to be consistent?
>
> > +#define LDOSNVSCFG1_MASK		GENMASK(6, 0)
> > +
> > +/* PF9453_REG_IRQ bits */
> > +#define IRQ_RSVD			0x80
> > +#define IRQ_RSTB			0x40
> > +#define IRQ_ONKEY			0x20
> > +#define IRQ_RESETKEY			0x10
> > +#define IRQ_VR_FLT1			0x08
> > +#define IRQ_LOWVSYS			0x04
> > +#define IRQ_THERM_100			0x02
> > +#define IRQ_THERM_80			0x01
> > +
> > +/* PF9453_REG_RESET_CTRL bits */
> > +#define WDOG_B_CFG_MASK			GENMASK(7, 4)
>
> This was 0xC0 in previous patch, so GENMASK(7, 6) if I'm correct.
> Which one is the good one?
>
> > +#define WDOG_B_CFG_NONE			0x00
> > +#define WDOG_B_CFG_WARM			0x40
> > +#define WDOG_B_CFG_COLD			0x80
>
> ...
>
> CJ

