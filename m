Return-Path: <linux-kernel+bounces-216676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC98C90A2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332D41F22103
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88817D364;
	Mon, 17 Jun 2024 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fQtr/QF5"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2062.outbound.protection.outlook.com [40.92.19.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA32BD18;
	Mon, 17 Jun 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718595202; cv=fail; b=kmjBUFNv0NUgiBZ2FGkib51iLc5jYnUsMKWiNSkLsaqScC1Zlsoy/heEgvwWRHIs2k8Et0T7sNBWzsYFbEoQqmY+JAgCQ1HVJtcbHya0W+FUqeVMizw4Vsy3o9/WaL8i19FgMOi9IYjbDQJD7aQujkYKoH1GEkj5Sswgd75/k/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718595202; c=relaxed/simple;
	bh=OB/3ac7f/fPOqfz3w/xrRH2k07r1rZWfOcySZX0n7cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SIe7IWTI+XqOOAnf8++pwTyaPkPof2fDhde2GO2oqyYn0EptkuW1w6jTISVS7v1j9Pq3rTRuVk6aqs7ggaqNjFnAaA5XpjkIPxNbrh5jVbbm8lZSiuBZy1eJq+nEyRUEvRP7F+6A3kzh/Nwjn3Yk2nx0TmBUsAFjt2SNWK020O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fQtr/QF5; arc=fail smtp.client-ip=40.92.19.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCMM0bxYoDDZ5iV5DsZ1KeGnSjgpieEnNyXD12WpFL86qztQHpGLhE7RIQaKEtHcVobcEImAOPF5XkMae9RtxlOqibiPfMpKZfuYYBQtvmXsyefYsRM+t+iw2dXri+Salx8eYfixD00EmgZI7qwXch4UQrzfCauUaBfwzIpFMXZjcScxkAfFnkt6kev81QOVGC0M9utjlpkDtms5IPXvLNgWtkcGMBKPJpbY5rlEY5vbCDqQhza+I5QtdnEtHMPM5wp1ASK9gCa5lYcnqVKT6rBKk/ERGLZzrt1o7JT94U4tZ+AlMJ7fFYCEHkhNt/P+I0rICo9T5ugU4cKRHw/myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unD+jZ3Brll3hDI8HrTsPXOsFOK/XAV7qCNfLVBovmg=;
 b=M8Lr2IAmZyYDhVj0rmdSFCO+nsMVoTDDVYgbFCbw5hQPi6cP4R3FdzzXCbTcF5y6ot6sNzaPt76Ab9SO1JCJirpq70huAg6GJxRWmZxsINaL/iU4P2HYMYrr85b7d4dDNvzG/3e6hd+M49wxNnDu9HkGFxLVcG84vbew2aZAT5JnmpP0td67/XjIGyjm1DgdsbK/0ZdYaB4x1rbs8ckewGE0QYoobN5hlPjEAFDK4r+0+XzbOcGYVR3ETT/yGRCoUI77xjvvKPmaRo7SY2k4Svb7Imz/05T1irP7CoPF73E+Lwsm/D7rQiEyionJOaeTHSrlWJbH3oSfD4+MxQufIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unD+jZ3Brll3hDI8HrTsPXOsFOK/XAV7qCNfLVBovmg=;
 b=fQtr/QF5ARWqUWzTKz/em44hQ+T8z05+UpX43CZzlllNYT4+vQ0uEWtbtQ+vEMjWMNoYfvz2+HzfNYhFEl3oRaN6FFdAl9t0wPeibHfe68NndNnF/7ESDGnsCK8VVhymzEgHDN7NWXJpuMIK5UcaY8IMF6Hnz9O7crT3e2bFFQmnIes77qDOSkBM6+USsaSEQGuBJm8v9F3RpO9nPBnTib2pF3qg8y5K4Kn778DIi30XxTyYHXdUlMB2PISxJuSWoM3j6TdPQBwLSfM+GdZ4Nc6pdRWagETMUmzqckYf8aKaqPWvAAn2Vt8Wp4WrKgX40MJRyvyvvHjdj7EbdOow1A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB6366.namprd20.prod.outlook.com (2603:10b6:510:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:33:17 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 03:33:16 +0000
Date: Mon, 17 Jun 2024 11:33:00 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Yixun Lan <dlan@gentoo.org>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Chao Wei <chao.wei@sophgo.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller: Add SOPHGO SG2002
 plic
Message-ID:
 <IA1PR20MB4953B2253043C304760A2D12BBCD2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-1-1b6cb38ce8f4@bootlin.com>
 <20240617003627.GA4008871@ofsar>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617003627.GA4008871@ofsar>
X-TMN: [oY71pu0eBeNwB6DARkjIxZ/BwRjgLy6O9UT73pV/6Ws=]
X-ClientProxiedBy: TY2PR0101CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <xxiaawfhp2y7kmiuvcm32ylir2zp33zapichp7u2rkfkgfijot@q5bladed3om5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: a77ba724-c9fe-4c56-37ee-08dc8e7e3972
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	314wdEbSI9zZjsrNYcTaYgjYpch1zFIsxak2t/Ug2R8TD/fyMv6Xtii77SUtU2NwPzAuWq/jO/dW5154/VqUlzXyNQ3wgZ8jQoorLerAuXG1DHl6PaFWp4IYXDBiS5aAW7xGuHXid9O1anR6F/MUKYwirPYoA6ROSM/ZkAUvDDynFiBoqEGf4VawCclx1x2k7VXhbKGu632ckuF3V965h4k4Zsa7iyc51zBYyUnS5PKroAByMb56S7Vk8OvYQFma+qc5GrDYtnVfOpU6572OG3GRfdnXm0J83q24sJXZUGu+qmBg+43GGFewC3A/lfAaybK8vtqjlnquuMGbwWa30bvtxSphajdazZzfaM5DpWpqbW3xSdfJpYtNUho+DbzaXHlVAbk1TteHmIaIFyzPQSH6EwZCfCQpJPpZDuUkoksGL24bt/Y5903lyLz59HhtIMcHb3m3PtpCzQuImt/djAKqtghh4P4oZvIHXxFZkRzk1DjwCyNuqKD2nY07MqRf0yqOcubrs0O5+cikRLf0FP0BuP9fQ6bkRAQMiWCy5jPUJANkSJ33HnvsXPaAt2UdzUbkKBNSCrBHuRjOfE/rx8BgB2MS1GP9QSZCg5Dz8L9q9RgbiSB+RgyuGQToYIdz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJcv8azP2Fi1cCrSYNJMz5SQio6L7td2iPkDNwnQyMCrKsMyuVXPVmvKk5W2?=
 =?us-ascii?Q?k/2fZWibLH6uAMGirKbKjLFR0oGnG+fOq33NOwWcsl08w1woiW7x3JhrJYgv?=
 =?us-ascii?Q?21/vr7aezIWf2igxWWdZT7kQWABZNRs1o96uYPXnwA/A6cjKiLM3Le0Zx0nZ?=
 =?us-ascii?Q?8sNWc6muePRPx8sB9YLNvYn1WBt2xB+ZoWFC4Hz6Y8FoskNNrE6puD76jjLL?=
 =?us-ascii?Q?wjiMbqmFB36AMrNLNVEVcRYKxhXZju8zoa1qVpO+/FFznKHrLLWcCK0ZGyrZ?=
 =?us-ascii?Q?zyQ+T3w5tniXDABfg7PJGstz7ywPbYAMaaJqkPGl9pWSic8u/GS9z4jUuaTn?=
 =?us-ascii?Q?OAihQPn9nkw4CznCZwNuqT6NUhBEvEWsz8lmZiqTWrbwEmDB0WgTQWnE7vI0?=
 =?us-ascii?Q?om/x0gza9XzSk0AYBIz0v6H1KP2gmJZt3w1KnrPKrx/ZiLFth4je/bx9t6iy?=
 =?us-ascii?Q?YKZaWlajty9wRilCgJf8sMRLwTnPUzHEk8H4tvsvGppiMoVzdmC56n7H4+mw?=
 =?us-ascii?Q?sXO2LWcJqEcw1FOs+JmXpQ4LBby2ybWt75u+ATPI0JwzEUa2ImSo4O0wH5GP?=
 =?us-ascii?Q?jz66mV6U50LN4d2gXh8dcsz8M6ZvG3QpUUBqWxNqLe+tKOrdq99OFw88qqpT?=
 =?us-ascii?Q?dyIF8W7dRUPg+mj9j2+nF9+JeyOlM9ux07Zp9w1V3d3ShmTvs/SEGtRDF4LF?=
 =?us-ascii?Q?XKJAOqfknj8xcH49j9ihpCNyYYdSHrTENAnUPNrKV3qh47ywbBD20wr+1yZe?=
 =?us-ascii?Q?xJyxQeIJg29mpyr5DXLEga/2MH65KbXbsc4jhzfgs41EoJVTDMpZaeQDbrTO?=
 =?us-ascii?Q?nCpI5SQvXQI/8yIGt7mFutJPqWlhLagDFDQNNIvcxhcbcHbREW3fDpoWB1+I?=
 =?us-ascii?Q?D13bL4hDdahYu1P9XsHA1FiN5vVRA2GQ9/VHK4TI2PoZvOIjs4V5l+ro8lQ0?=
 =?us-ascii?Q?KHpmibOXpIFU1jFd6RJKy+cSvsu9mct3NVPCKF/15Up/9N4Jd1xkg7n5bCrJ?=
 =?us-ascii?Q?2lX5tcLdxqTbJOPsYwn24ErhLvuL5oJ8Lk0g9y+kuyGBT/mF3q1cW9rsl/mI?=
 =?us-ascii?Q?JsU0+uFxN1sw6ZGPX+MRgfjYJuqT0FpmNgbQivdOxlex5xft+dBNPn8KI4D1?=
 =?us-ascii?Q?qiwqrVehaWIoEtFcCSmb+plKaE0EOW+xDjJUFjUeR/vNqm3qKyU+QwtwVYLQ?=
 =?us-ascii?Q?06pFPCyRiqNPICXufyx/aDpH70zd16LuhKmzvQx1dTIafpBHKkRCqjRg7/3l?=
 =?us-ascii?Q?Sv1w/VXBJ80+H0JvoKoz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77ba724-c9fe-4c56-37ee-08dc8e7e3972
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:33:16.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB6366

On Mon, Jun 17, 2024 at 12:36:27AM GMT, Yixun Lan wrote:
> hi Thomas:
> 
> On 12:28 Mon 27 May     , Thomas Bonnefille wrote:
> > Add compatible string for SOPHGO SG2002 Platform-Level Interruter
> > Controller.
> > 
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > ---
> >  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index 709b2211276b..7e1451f9786a 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > @@ -67,6 +67,7 @@ properties:
> >                - allwinner,sun20i-d1-plic
> >                - sophgo,cv1800b-plic
> >                - sophgo,cv1812h-plic
> > +              - sophgo,sg2002-plic
> 
> it's not necessary to introduce a new compatible name, as sg2002 use same plic IP as cv1800b
> I feel it's wrong to introduce sophgo,cv1812h-plic at first place, but that we can't revert?
> 
> same reason also apply to clint in patch 2/5 ..
> 

You are right, it is historical reasons. For hardware, they have the same risc-v cores
across the whole series.

It could be better to use something just like "cv1800-plic".

> >                - sophgo,sg2042-plic
> >                - thead,th1520-plic
> >            - const: thead,c900-plic
> > 
> > -- 
> > 2.45.1
> > 
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55

