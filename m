Return-Path: <linux-kernel+bounces-330386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C7979DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8247C281329
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A86148302;
	Mon, 16 Sep 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qHlYloSm"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2020.outbound.protection.outlook.com [40.92.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D241A28C;
	Mon, 16 Sep 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477229; cv=fail; b=fiSz0Z7dr0jORO6j2iahJGxBpDzQHZRbxfbyNCZFePcQfFAKN6ewoYj4QJ0XR24Rl5YElxTLYL1qmydeCbdYpKfo8dIRha7ZGMkBlDP6UBBbKgHtdrZ4Yu83cvYse1jl4frVU+2IHJHAdDkWUAsrYB63hto9+QhiwG8iAyT1Mo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477229; c=relaxed/simple;
	bh=Or/poj/8YXatiQXfPFES0kSkb+UiS33KnjK5HBDBu7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jr1tFr4ymsoNgH5vVhQjicOccOToiQeT6Sa0PRWZm2fiLZ6jNEoaLoyZ9DH/LvtfHWf7qW30TVe9L9og1xMaQCRKhYbZr/qE2tPhG9TF29Y7t5uTH729Bt1rjkFnS/IWvdOsYUeSOvAwjO3qXPWrqtsZrKHFoEp086anTBYssV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qHlYloSm; arc=fail smtp.client-ip=40.92.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shU+WLGf6XYISU81B/NvqTnhxhyIm6nQgPn7qzm3mCLqaVEpqArOK5UWB/wbHoX0SxESJa7sqw3mGT9CBHCIvDyB57YC6hDAigNetD/Aen0JLdD1MXTC1Os3hZeZEaBSONSkwjSZD3qj78BtLhxMoc3JpvaaIesCN4mdlKZEghLzcQ/u2FxK4wGmqHhy66fum+R2nElOK4oVExqWlBDOT9LxkaOAHWjfW1sSjdAGSDVaIPBYAWe03Govj7WHJ9PPgf/35L4tC2s180k3pBlL2Sb7h+S0sNULwLUJdi4xk7UtUtcwdI6/MSMJe8YXZJ2Fjyka9Jbb5CAU0Lv7LZ3TCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7u6FTVx6uNmqYsA63GYH/zM9fXfsl8IFHOpsY1j300=;
 b=b/c0Zcf/vB8mxTRJ1y+1vfyLyWGqhlnLwu5SU1S+eacYoacgfNfHuDmw6dbqD7oIvexNDU4liJnwIy+f2sRPGH3hDd6tXo76+BAZqzmjbwLs8p8PUaX8OCd7aznUCqnj4TqvLHneXk93rmnfTRiaCZOs6cMmWaZt5ee7wJh/AmoQSRKqP96XKTKMVON+NxiI6+csRdbeAv5bVLRq9M2qYf6bghuJqfJbJPUZFIH6MoN1/OybXWOOMqReCiQwQMG3F91arKbmxuqd8Un/D46YpJ5IdOvGb7/ULRS82qLpD+HPLL8LAql06y6dDjdq5FwSqAd/173hwm1UVKQV2U+N2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7u6FTVx6uNmqYsA63GYH/zM9fXfsl8IFHOpsY1j300=;
 b=qHlYloSmAJfJBsZjbhuzceKtO1sS/9njO1ZyWZTdnI+vovQhw8INr8m23joT8nrRrVkwLRvZthk1sXplZthhlwFV0DMPhqThABHwQSzRJOvMjIjYjhODRwaYDFPfHftPb3gU3mGk7N46hOQcWAaI9YswsCM19pid9SYb9TmD4VtKwqCVnBWTlAJEc7xwRspwiZeFwq1SbI58k2U9BXQP6DDZnybqW+artyzticxKsAh9jkZH5BkGRvoxwf+PKOcPPh94TjtVtPPoGUimrj2iUrX48h3IXWuYyvoMGc6ImbFXQj0m9uSba5TG977iv0+3fyIEsaZG5/Vv3BqAfWs3KA==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4764.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 09:00:19 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 09:00:19 +0000
Date: Mon, 16 Sep 2024 09:00:14 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Chen Wang <unicornxdotw@foxmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: spacemit: Add clock controlers
 of Spacemit K1 SoC
Message-ID:
 <SEYPR01MB4221797DA56316CEF3966E65D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <tencent_443CD854D495576C1821D5843AAC5FCC5808@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_443CD854D495576C1821D5843AAC5FCC5808@qq.com>
X-ClientProxiedBy: TYAPR01CA0215.jpnprd01.prod.outlook.com
 (2603:1096:404:29::35) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZufzntqU2rBBEFrG@ketchup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 35499a84-02fb-456d-f517-08dcd62dfd89
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|37102599003|15080799006|8060799006|19110799003|5072599009|461199028|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	8/TwyJOZzIqoohYZz9T8AojAUAdQJkBrHUFWHw8lxieyDu7APHQaVBiWyHp42EtFnkUX2zqw+axsTQrv7D87Y5yLKc0ar1OZFsiClrETmgGn3iOY6MkvV45WnsU/LsYGdXviAfPp1AwdNBXkSEKLHIBYZ/r95JOEH8AhjVZPFnsUieDsoAlDh73AfxDtDzGPqO8mHON9WEujsTCRG9lLRTMxzIdfjcMrUfhGATLJxdft5wSYiRwu8kYq0b2mymrDM7rC9AhXzuTb0XkutTO7KOo/cAHv5mrAS59wDqWdAIOBDOuNC8rT3ampTX51gm4KKNoj73r+6UjdBz6iQw0k2skjpLWKjvZcJDJFtb1lYE+gKweGv7hxPaACCq8MCRzGjOvURRrDgGK07dW/byr/LexE+YAwRhpveuwbLBIhE8k7yT1xESAoednzgJmIroP32DeJ5DQ5uGDSmy1PNTHqYWt0c6770DZfrzubyVk7ZBnrenoSm15u3St3W4RDNZYJWIDZwsOC4ziCtNUVc++DU0zxX2+mMYsR2A1YHZiJ5YZigDWSRpgT81nps8mCXaekWytpLeQ64S7a7Zb+FWZUi+SlVU7ElzPHYg2URGLCyBUa8F3a4KI2QuPrQot5omkj3Fp9D85RBhyOTeRY1Po4SNALHMlO0Swx6FgiXFp/oaL8UgHjBcDQDgWHY7WC71SaTNTSEY7v5dciYWxHv9Y6GY5UaBllxNd9uPfNZgczlKbcJgJ1cBtI+IWPxEMPkdYPEx01419ehxWU3ti3ke/uCUkIs2NHRJMtCWCgitN6utXAK6DrovdNYraVnDIHbEWmn9neHHog7d7Fuon72DV2XDqb0irDMSzDtiCS5E4pCj8mlu9EjNS4wbHg77diiCOw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nV6WscXf4JhBDFxYgQb/wUKFQn9VpkHWqs0QOjuwzHUQ3eVjU6cVYY3t0t+w?=
 =?us-ascii?Q?AK7YQvqnx7jLhsI6Gi65rJ5WPTfCkIWCLK9C050PZzBA7VChnB7UM+92hyjV?=
 =?us-ascii?Q?VlakfVbArNL9Zxon9UvAc3LOxIAEVEnLeghIe8/jFD6kADMXRA0Fg7ENUAKH?=
 =?us-ascii?Q?Xjn8rXvP1Ut6/lM25Hy2XP9Lz6/GCaZWLMmz11JPrkVy/TGsqY4uocIQPrIP?=
 =?us-ascii?Q?HOuFdoAP3uDIEw09qCgav75xY6bluiZf/fssmcj+p68rYnw//ZYMTo3BDGLL?=
 =?us-ascii?Q?V0wEUd9J+T4y6iXlWlo2uVCorcG4ugtRD1QaRLzImc0o0fm+LGEzWNKsa4wu?=
 =?us-ascii?Q?7uyP8p0rECwoqYz5HVkKbmpY+jUJqyQLHvsHLleSVpddUprojFdDc0mcUYgA?=
 =?us-ascii?Q?ryKdX0G4FI/bXJpcy+d8onp6adwR2H9tKA3glcCCZHQBsXUDD/1DryZF8KCD?=
 =?us-ascii?Q?TWiSF3iXThBUO31efL/A6y2gDvytqU9Tz6yrOnd+a4feKfL9Fi/OjkQRyb7X?=
 =?us-ascii?Q?PPMMoufk7RLINNBsfUjBLd6Ey968ZE6lLwojGT4Ug3bXvCL/GiaPap3vWU0Q?=
 =?us-ascii?Q?FM9n6jzzaxw1DrsRKO6TzzkC9pCfmBA31l+7WjgfUSkALgQuQjK1X2YJf23d?=
 =?us-ascii?Q?TqDMPLwlVHI2sU9Ek8auEGuOYMeqoPq9gC4+0HoGJkHNbLQ6Fv5R8RV7jiHZ?=
 =?us-ascii?Q?tN8W2pzLytBOw4WmwoRNL77uSFgjKJmt3x2viTd12e+4XfZOTp0bd6qbc/Q5?=
 =?us-ascii?Q?F+68XJIZ+cjyQMRaqLYte3+i9mzRUZ3AXE48aBNVyYGNFDJnepyKYrWi5Hwv?=
 =?us-ascii?Q?AF0xp7LM1UZS3EwPDRXRdtywrWjjUTQms+9e7dAPglPUzJCCNIvu51ak9eta?=
 =?us-ascii?Q?QaCdKJ5qhi3kwYQKTocyCOyIT3Ek7x8NyT3B4DMJAeVw8JMMYL0peb96wN9D?=
 =?us-ascii?Q?E6mU5E8WRKRnnFnSapyRbvMBUIEuJAE4xjK5PXmRacli+ktrDsHnwuJZ+GQz?=
 =?us-ascii?Q?am/LHU6VzOz+S8gpoFAalRMLZTx+GumpaHVf6jC/duWD1zdwnkND0yzZb3RE?=
 =?us-ascii?Q?NEy+lLLN8VVf0WwwaooCCciE602KqWV/E174K1k2SKbxSsGHTRPvYHdenGFy?=
 =?us-ascii?Q?IZ9PFg0ZXPU8tm0TU55tQuCmhX5AfeulU+38Vy9sU4y48VxZfNJC7YtRmCdy?=
 =?us-ascii?Q?cmyXsjngL6mhoNJ2aY0urgQDj+fAQ4P7D+1NFaJ//Z71TiDFxRX+A5Z/fqk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35499a84-02fb-456d-f517-08dcd62dfd89
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:00:19.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4764

On Fri, Sep 06, 2024 at 05:51:44PM +0800, Chen Wang wrote:
> 
> On 2024/8/31 23:47, Haylen Chu wrote:
> > Add definition for the clock controllers of Spacemit K1 SoC. The clock
> > tree is managed by several SoC parts, thus different compatible strings
> > are added for each.
> > 
> > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > ---
> >   .../bindings/clock/spacemit,ccu.yaml          | 116 +++++++++++
> >   include/dt-bindings/clock/spacemit,ccu.h      | 197 ++++++++++++++++++
> >   2 files changed, 313 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> >   create mode 100644 include/dt-bindings/clock/spacemit,ccu.h
> 
> Suggest to use format: <vendor name>,<soc name>-<clk name>, look at the
> files under Documentation/devicetree/bindings/clock
> 
> For example:
> 
> starfive,jh7110-pll
> 
> For your case:
> 
> spacemit,k1-xxx

Thanks for your advice.

> BTW, What's "CCU"?

The name is taken from vendor code and I think it should be "clock
control unit".

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
> 
> Same as filename, compatible string should contain soc codename to differ
> from other soc of spacemit.

