Return-Path: <linux-kernel+bounces-299447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E10995D4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1031F231AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E28318D64F;
	Fri, 23 Aug 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fcssoHQN"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DDF19047C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435730; cv=fail; b=un4HZGh39wsXUYPSsFGNm/THW9X6DLR3UIbUAjdN/sxkOthoho/p+5jXmuH1q6JcDO8gJA28i5JhPdXDDV/MS4FUAQvq5CRxtdK3UQnNU2fBCufGWBdlmk2pt0PAW322R3tDvFpyRMJpKaern5ONJmDBtS/7YFfnyCpi+Q2pqf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435730; c=relaxed/simple;
	bh=uHFQCZx+HsNJZl3ir8aZC0WYRo/CjAZKAKvDOyGcZi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IGgZqzIu+hL+xLxjlJdX7U5FCFHz5QebtOojv8rHPkpvGkS1rykBwI4iDbxW11496J5SCh8zPYTJZQqvT637pj7T8B/nO8MshjSl0Q9A2CqB00blvpbVMeUXsGDn791HwD1gZN7Oe6/LFaCmx8vIMQ0JoRe8rADHP11o6QehsPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fcssoHQN reason="signature verification failed"; arc=fail smtp.client-ip=40.107.104.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvcYTsUtWvYQkuC2twTEXXcTXli0AWxoYC8mHiBYE+GeZTsVfpZrrBO/QDnP+OfO7mWm+3FRLuMcYlqhn3npW8W8QHUwEqp2kbVu5VGbOwKVp6rAye0gQb0hsUdKhRVkRamH4pbz/eOqgA1D+k8/iLurF5avG+nQpH6DvWAmYBStCyk17FJOjJ0+9Rs0Rlp8EqmR7cPmExFWvPzHTafql1NBLUsiz14E3TEV1m2bxlfxFd9saxqPteuWiYQWFIE1aMN8DItI+NN2so5oYboLNSu7uLj6Df9LQYsCnMxLMBbuclV9BYyUf6MP8bx1iQvKZmE94qx1SI9Z8AkpfSfZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hklHQZtPSPNpJ42GGt3CN2zyKbQzab51teaz5hs5suY=;
 b=Qeaf03dUTwZ8wYF3UVJNGJ9qP5hps+eZh4AjOtVnK/L6ieHbG6BGpf7coNuw3b9atxfkKiBVE6GOBxWrDZGkvyub+N8b6BL6y68Q54UGR0XNYiLgZt8ZvRpkLxXChh53OsCP8gaMb0QUqimjgb+edIMCPU81kIlv753EAC5gVuJjAal1HqoxPTyTjIYwit8A9G0ryIlyncdN8xxWWmYARGCsmkQqDmEuaQe07tv1nPs5AxV5NI0eIeVkUhjGVP325JFzY/K/ctFaGjpwgn/fMMaQZ1TTIJCtTfK3SO6WldR+Biq6CDz9eQgDTQQ+FVH9Twqe9nKM4qNPJM4ZR4oYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hklHQZtPSPNpJ42GGt3CN2zyKbQzab51teaz5hs5suY=;
 b=fcssoHQN2xhGsN1YmEuy2+0gEwtJH20S1gpIDC+1oCU6CzaAH0Q8IwYXfmQogaxLnw1IN3kjgT13UCmLNLl6ud4STBU2zNgNDcSIinoxaw5+BoJ1P1TsWEQW/qlI+UgrwnNVsoOjbs9n5LdH9mrRdwyW3JZ4xf1yvg3UfbrBDqD5tmkUMDtDGdfBvQSbvRzgZ/n2v26zAW6ZsF+5lL9o4osCZ4d0pY0DgKDqYq/JCMNUPAaixpdCrLJ36GEwkLaa/em7Njo118KQDUeLKBW+4axUWWx6oUj8Ut6dV182lyLwHVnWhslIJpaDrlRIClfmhyYugAcI8DKaAhiwUsrXtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7869.eurprd04.prod.outlook.com (2603:10a6:102:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 17:55:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 17:55:23 +0000
Date: Fri, 23 Aug 2024 13:55:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 03/11] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_INIT
Message-ID: <ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
 <20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
 <20240823180426.056ac093@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823180426.056ac093@xps-13>
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a3dc3d-dd5e-4ea6-4f14-08dcc39cc2f2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?TzaOH2oEA3UJAP0Ru9mEuizgFTiBk6d0Umrv1p32JhTTh/DXdWYVNjlb1j?=
 =?iso-8859-1?Q?sLuTdYVk+/JvTdS3W82MO7eOLBGK038vc8XHoVYuf0S5qVVj4nU2DvsQiX?=
 =?iso-8859-1?Q?dJpt8HtgaeGf5ApWnd8SmuSVnWmkZnD5LKyOgMxLmO2x8BdEWss0t+P6In?=
 =?iso-8859-1?Q?e1FuC8lx0XF6oW390XcnS2YQbTgcFnpqIqJdDSzbSkM7Zjs1WKx5v+y1/L?=
 =?iso-8859-1?Q?FDCX/39VUaQrSw8Mfadi235JKF+vuMjAHYiXOhEmk07ZtjXtMK7bWhV7zL?=
 =?iso-8859-1?Q?mznT2ylD/xUaUD7cgTNI6nERmkBegI6eEjfFC+aaoNd/dZDHQhEkQ0lOEE?=
 =?iso-8859-1?Q?5ktaEB1tj5/mTjffw2kzJO2JChA054AG1pKUUL7LjO5GpzeLNNofNc7CVs?=
 =?iso-8859-1?Q?9MMFIq47MJrBpU85bFpdxIrI4f9VZeqHQUAXVTdB9a7GZp1D3iPhaCT1VY?=
 =?iso-8859-1?Q?JmwOW8tNvtUgt2c9/vrYKaXEnmfIkcsGtlAksZIgH/CNZz+OkvLSfmCrx4?=
 =?iso-8859-1?Q?zHqYtL+j5u3E90xwaPyaKtkLTdOB80wcNkEOWLs0yZlsuErMxmNGeO1soK?=
 =?iso-8859-1?Q?Lv4ktoAfORNaMMMi9CU1hNgUp16KDa5McvlG1sGBvltMUAZl9k7RA/A1C9?=
 =?iso-8859-1?Q?PgzIAs6T7j+mMAPMplvJZAOrG6dTGHlFTbgQjhyBCXs50EzJRMjtAQw2aN?=
 =?iso-8859-1?Q?e/SELQctd5OqeDoZ0w9g0udbtUt2oEZRNjGrxnxJwUoqwfUZzLitmOK1zh?=
 =?iso-8859-1?Q?21yPI4toaWCnpg8B4z22wY/KHh1ymZDALJQbzqEx+DtgI0qgQ7LiNPkjFk?=
 =?iso-8859-1?Q?YUjmzBSrInOYm854TNii6i3XcgxvjHeK7iC5Vi2RDcDwJs6AHoExce7t4k?=
 =?iso-8859-1?Q?+AvMfJk87Gn4RUZ/wd05Js609HBRgF0yzZl01u9Dg29QOIdOrrooXnPOFG?=
 =?iso-8859-1?Q?0HWU7yXh4or1dKUlEVO5l67UnEeUCS60SLVzZAxxoPp7Dtzv76KubV77VF?=
 =?iso-8859-1?Q?7APOi07FZIKO/vj5pdPTAV9it6noZDYzwS4VzKxoWcRNODAJnfqUBW5nqy?=
 =?iso-8859-1?Q?1lscfhYw3cRxDcHQffmRFChbtHJmbdYCKQ5p8LK4z9qhHOBhqsgm6iTnpA?=
 =?iso-8859-1?Q?WNa3k4kDGNqGqweLjpRde8A0X6JdSwkt/AfvO/0r1ozYQBSNPma5CPwstw?=
 =?iso-8859-1?Q?GsquPJwUKiuxrlQWB2q0lZjNLZPsbqaqwiOm0pzImATA6UnyT85AKLdEXO?=
 =?iso-8859-1?Q?FsgQh6Z7RrWjeKC5cj1TQHTlFYv+GwmeuC8J6oW98yXFH4sH7GeC6x9yI/?=
 =?iso-8859-1?Q?nE1aIlTysgl1RFgF2wvv1Jb8nZsNb8TAHLiBLQNEj/P4TOdn9zIgcHVJ5w?=
 =?iso-8859-1?Q?ucJws7Yfqu/L48mPoTB4+ssIK6SvwMpB5YudDxbCJcyA4zVOmvIeZOXurU?=
 =?iso-8859-1?Q?ikRpfv0JZMyO8tSTjuU6jHMwye1kpCNUHX7V3w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?bVdDU8kRlweCgSl8ULpMyrDuIIcE5omy5Bx3aFd4huOYAEMHpKvIp1W8bG?=
 =?iso-8859-1?Q?WdRf5npLSJUJ8r7dzTSfq/jWU31nr5JMWiwnO2t1VovG69THTyljtNSHjO?=
 =?iso-8859-1?Q?Zqw7Tjdvxkd9I1UhMoSqyW3eR24QSjiQFI+p1o+lRVEgLs4M9RWu5YBilh?=
 =?iso-8859-1?Q?q9oOObczW+RzqacXKhmBEmqxFQmRSalhrHS0tiEoaZfvRm95hTB2qrtV0C?=
 =?iso-8859-1?Q?CW82RCkM344c2uqFIJmNYYQMdNSYqYrDn75s6vu3OLtrDSzoWioPa9iudN?=
 =?iso-8859-1?Q?RFoxdgArnlDRWPHuDiReSuElJUXnAkj6eEmI7zRcqdgK+pFJjBpv0qsfgX?=
 =?iso-8859-1?Q?+KzbhC10udDtVVVs0ns4zKmxd4tA4UNWYjZQX/EDOuUTW05bpWkaDUk6uR?=
 =?iso-8859-1?Q?fne4IGPiyeeCebpboxb4r2tnH8uQqD2ebOS6ICe4A/Ks89AEudL12pLdmp?=
 =?iso-8859-1?Q?HZ5KoBzeEQRrm8BYyCReSKeZ44a56kguog6aQJFhF5seuKilA0heCx6LFD?=
 =?iso-8859-1?Q?2mVR0RPz0E+0T1fFcXRZefMefGMeZJbq0kp+hGtSftShUp9xm+sftudPBU?=
 =?iso-8859-1?Q?cCFaV8Cbl8C8KZ7VNJ4rj8vFhdImqr+/z+gBVJ6KLcAexhu0mSYIWhRg4i?=
 =?iso-8859-1?Q?liaBh4B61voGDZ4VkQ1nbuHKOyIcZxaJWZ6zqJ1VyS1JF474Nj9QqiZ8Sj?=
 =?iso-8859-1?Q?UIkx/M3EPKQstSRiS4cdV4D6z5XDkYs3+F1G90jUxLaAfM+/AuQw5+zpK+?=
 =?iso-8859-1?Q?TPjbhwri3pXIMZm5anQFtTUhYqouIj04jDF93Ej8X0LQM83pbw1ePBI+w1?=
 =?iso-8859-1?Q?72DhLiPjKb8KY+iz22Sei5lPd97i5y4qgVaptWQT1qu9fGK3XKXqSf0d3D?=
 =?iso-8859-1?Q?tsKxr6C5R2G2NyaMHXsfOw11gh9RQDnb2e66ASaqM43wR4tXp4s9MrZLHg?=
 =?iso-8859-1?Q?kWguk5z0XSrr0xO+n1jzllMRwshjNeaOIhTsY8tNR+dfatk19W9eb+qPQm?=
 =?iso-8859-1?Q?Blq5CEFIZQYZcsq2u9AWjNzn4vlmnX7oMv5wxiXL4AVhjW7SPFL2lZg5+D?=
 =?iso-8859-1?Q?yBnqXu4UQqUwKVnqs4e6lIoCm8u20PfK1lk6dlHbAuNUnKiVCOIoNCd4mj?=
 =?iso-8859-1?Q?zW6W4LtsLdXYQieslYJ0MnGxeuCthIUJEcpCZZiVPTLrDp3tiFYKtvQW3X?=
 =?iso-8859-1?Q?UGYBSfyKFcDHJJ7+ysPOdDcXloqbQen+jcxYgi8aiInNqGw8IGGN5AUBnY?=
 =?iso-8859-1?Q?7dJ4hZ0B1oRkmcf08gSr2Lkig5ui4qiO/9X0cSaGjpt02jhsq2OTglvaVZ?=
 =?iso-8859-1?Q?2qPkMLl/LCCpXMxVs9M75gA/Xokgtlrs2LD1+YmZKwkQtSK62/EgnEJmT5?=
 =?iso-8859-1?Q?6Zn0vXVZMRcJDuQE5FbpaR2zaWTbH7bC6GA90iLqQ8Cm2dP5z1yOFI1EK4?=
 =?iso-8859-1?Q?9hvhlA8X0mM/CA+KisSFz1FUYxDYEAB6IkzQPtGNQW3No0C7iYLWpzFucd?=
 =?iso-8859-1?Q?CjZyAHLVqzUhNjovUTJ5iG1LQEikuO77LOXtDfoQ50/KPDkBPQlre2pv1i?=
 =?iso-8859-1?Q?W1aU9cFz/Nv1LZ5LyxcHf8iENzOesGFbHiXgjtrwC1LR7HfHJzB8pLEq2l?=
 =?iso-8859-1?Q?ajmxeWB++GS20=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a3dc3d-dd5e-4ea6-4f14-08dcc39cc2f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 17:55:23.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Vib10h3sANJuq84TbZLv4dDVWvl+JGimLHc0EW2jGcH4WpzYEPwTxl8rRrDK7zp3p1ospZT7RKX0dP19A+xdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7869

On Fri, Aug 23, 2024 at 06:04:26PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
>
> >  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> >  {
> >  	enum i3c_addr_slot_status status;
> > @@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
> >  	enum i3c_addr_slot_status status;
> >  	u8 addr;
> >
> > +	/* try find an address, which have not pre-allocated by assigned-address */
>
> 	Try	to find			has   been
>
> pre-allocated?
>
> > +	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> > +		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
> > +		if (status == I3C_ADDR_SLOT_FREE)
> > +			return addr;
> > +	}
> > +
> > +	/* use pre-allocoated by assigned-address because such device was removed at bus*/
>
> 	  Use      allocated
>
> pre-allocated or assigned?
>
> I guess the logic should be:
> - try the assigned-address
> - look for a free slot
> - look for an already in use slot that must concern a disconnected
>   device
>
> But the comments are not precise enough IMHO. Can you rephrase them?

How about:

Follow the steps below to obtain the I3C dynamic address:

1. Retrieve the assigned-address from the device tree (DT).
2. Look for an available slot address.
3. Look for an address that is pre-reserved by another device with
assigned-address in DT, but where the device is currently offline.

>
> >  	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> >  		status = i3c_bus_get_addr_slot_status(bus, addr);
> >  		if (status == I3C_ADDR_SLOT_FREE)
> > @@ -1906,9 +1931,9 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> >  			goto err_rstdaa;
> >  		}
> >
> > -		i3c_bus_set_addr_slot_status(&master->bus,
> > -					     i3cboardinfo->init_dyn_addr,
> > -					     I3C_ADDR_SLOT_I3C_DEV);
> > +		i3c_bus_set_addr_slot_status_ext(&master->bus,
> > +						 i3cboardinfo->init_dyn_addr,
> > +						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
> >
> >  		/*
> >  		 * Only try to create/attach devices that have a static
> > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > index 4601b6957f799..c923b76bbc321 100644
> > --- a/include/linux/i3c/master.h
> > +++ b/include/linux/i3c/master.h
> > @@ -284,6 +284,8 @@ enum i3c_bus_mode {
> >   * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
> >   * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
> >   * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> > + * @I3C_ADDR_SLOT_EXT_INIT: the bit mask display of addresses is preferred by some devices,
>
> I'm sorry, but I don't understand what "bit mask display of addresses"
> means.
>
> > + *			    such as the "assigned-address" in device tree source (dts).
> >   *
> >   * On an I3C bus, addresses are assigned dynamically, and we need to know which
> >   * addresses are free to use and which ones are already assigned.
> > @@ -297,9 +299,11 @@ enum i3c_addr_slot_status {
> >  	I3C_ADDR_SLOT_I2C_DEV,
> >  	I3C_ADDR_SLOT_I3C_DEV,
> >  	I3C_ADDR_SLOT_STATUS_MASK = 3,
> > +	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
> > +	I3C_ADDR_SLOT_EXT_INIT = BIT(2),
> >  };
> >
> > -#define I3C_ADDR_SLOT_BITS 2
> > +#define I3C_ADDR_SLOT_BITS 4
> >
> >  /**
> >   * struct i3c_bus - I3C bus object
> >
>
>
> Thanks,
> Miquèl

