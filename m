Return-Path: <linux-kernel+bounces-350596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B399074D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284EE1F224E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DB1AA795;
	Fri,  4 Oct 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XW1yGI2/"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D11581F2
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055263; cv=fail; b=k4r1EJBzTs2teA1Ps4X1JvxiNR3w8NfM8LzrjgQIvP/wwZ3FYQBB3Cc+mh17JpO9fa9vkIxDszpoRUruioH5qIgj0nnloTYPw2dWX/fn3PAbbLvWyHBiL8ysEdDHIG8WtajO9VivMKmIpTA79QlWfthIX/MX1sZSraOx5rAhaqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055263; c=relaxed/simple;
	bh=r7dMCrol065X8lwOV53cBRtvWu/66dL8VMUPn/GkGzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jvPfvhWlhCIaFKUmKd4fJ39S+7gMlfWBitDQgE7RLjMk2EiK4eSGZBSZovM0foI/xwxAZDPnWcY76YB4hb2OaHMp2Ditac0SDYPCCMJ1iXTcM4mMeSXkZTuwGBS6bSnuNKGXdNJHLWfmVzmsCA/XeR3zig0aodrYB9qgFt0XRhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XW1yGI2/ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmhLsCNa+IznleEj8pdZNrvlS+f4icpTaHou54uEmkcg35kZry1fG48HR3EOgIn/9Or4PGUcJpAKC3AFMqjSQ/O8sbLToGcN64PWnvo9CG4LkBeUpEgAbnQAIBk3mTSYpzJ/UCm2xS/em7UbBU3aQ9ps6qviezat0vWpi5kPqK2YRzCI25b5BNfDRH2+Buq85jbPHbIS6hW44MofHE+RY/cDCwx6cnA08NBoGhecHhxKa6F3aaF7gJHdzl4u+HauPV81y68A/hDqS0j1y6f7X0jC5NR73uO8TXIaXEq7uGjt2KYMAB8qGaL83g+7Ic3NKPgaXC3Pz8gjsdy18nX7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttLLlnKOdZi7gcHp4GujMMw/Qauz+5R4gWF5xFiFIDk=;
 b=Rpop5ymk81D+g1yOkQrbm0ShjUUI5apg84rQO39lHwsp9dogZy4VlOpakmwUDcGQCu4lkrv4Nlcb9K/D1UIrKRJhyxkZrnq8rBiac1gno7nsdwrFYDSj9tr1EVuANlb33aQzbOGD6G7vtYzo10uCveelNWscQkL0Z0Pj5lLS7HlBW9hwsjgWompxIXZCfKIN4bAyg2XkbPzy47gmYsfxLxvQpJXAeDNBeNWmQZ9WDv3tODT5zhVRvBFf0KvulZxhPg4Tektae6KZnEFEFEQ6cUKblQ0DlgDDfkecKyuqq1eG/jz9DrqOWsd61g5PmuY/Dk3Prr8+e1MlEietkVQV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttLLlnKOdZi7gcHp4GujMMw/Qauz+5R4gWF5xFiFIDk=;
 b=XW1yGI2/vt0GAT4ALaMcC0RKzvSAth0G4P9KfvEQF6GpnMJEJ/YdrTeikrhe54ALWuYsfCT6OBY+1dL1+RGQIsZ+tIvbNMW3BXJWNvPUwFsZyZosxw3KlMSMNse8BrUZCPr5QJNqnBj2V5LaoE2iXG/rDxW8G9yCBDh/iIoXvVDEQOUILrB6VqqbQRUGsdxFPxzxaq9iyh8iydXuJEgYqMe1mITMaxtyc2TrqBKDTP2m3HQoGN0nFAxnuxPEC5WlpbEF47I7BNKEhbuzGlAZlzHwy+KSodmepseYYrd2Tgm9sxlgbW55MESFr/Yj4D6Bmff/l8Yx7x79oz2eFDXQ7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8615.eurprd04.prod.outlook.com (2603:10a6:10:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 4 Oct
 2024 15:20:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 15:20:56 +0000
Date: Fri, 4 Oct 2024 11:20:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, pthombar@cadence.com,
	ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH v6 2/3] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_DESIRED
Message-ID: <ZwAHziElHUR7ZdKS@lizhi-Precision-Tower-5810>
References: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
 <20241003-i3c_dts_assign-v6-2-eae2569c92ca@nxp.com>
 <20241004092914.42701e56@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004092914.42701e56@xps-13>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU2PR04MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: a200bfe1-05b3-472e-a67d-08dce488247c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?SS099furOBHZpdS0cdJ9cuASzFpFRVVTe6QhZdK9tcX62GMOKGibfXJeeU?=
 =?iso-8859-1?Q?+qQToSDStEumQ+Z5lgVT0BBCiOsYw58bBzol3qVsvKfNGw8qQD1YXKFPxW?=
 =?iso-8859-1?Q?iXq6VvyhtEnpeNY6rPMGK08ffuzWwtI1x42vebrS6FQ6m2GUA/7Ct7/sGd?=
 =?iso-8859-1?Q?quA6+WP5pB8MIfuP/4vRP02E6ur7plB0LHgxujlgbvuZONw+RCOEt7YWb4?=
 =?iso-8859-1?Q?eN+1zTdggjl/ROfWbCvDV28Mv6Sa/dSQeN7dVOtjdMpHYJIFKveOtyQeuG?=
 =?iso-8859-1?Q?N0L3eum5YMGLzckAZBfe+cOFR3ZSczaF1K4v9BNwFTCeJwqNzHLyPZK2HO?=
 =?iso-8859-1?Q?b0f74c7X/zAdCk9goM4IMPoV7Jotq+NcWcxlwiaSjqS6ak4gdbSzBjrEr9?=
 =?iso-8859-1?Q?Bh4TlemqUsVGvZ55uFv+kqux0i1EpKpLxVGbfwT+o7D86TVRkRvoqppKwf?=
 =?iso-8859-1?Q?vySOpfbyfk+sCdKzpXYyZP4C1suO5uLPk5GElgrDVHAZWn3+d30podipbe?=
 =?iso-8859-1?Q?53mfw8yimOsISvZGo6C4b6OyM14u8S9NS6MYxdA5mg2EwALV3k3JDzvJX9?=
 =?iso-8859-1?Q?Qa1iDiMHmIIuMXcH0i9LZy/0sz22dY01WgAxI0i20vbHSf6f8A8R8I9dVI?=
 =?iso-8859-1?Q?T4QrwD3+m9T2kjw5eg75M9kggnNprxs2GxrGI9kGjpltFb54CA7vq/Ci7f?=
 =?iso-8859-1?Q?uejv7gD2/zWBJyqPFA9WkfrYGvNfw2fpOB++6E45zEdohSJDtHvJawPMd8?=
 =?iso-8859-1?Q?cyRudrUbNYGOR3fPevmr+R2AEaQ6R1y9UcG8sqxQbDcDKw/BqjDkt7DU/m?=
 =?iso-8859-1?Q?H2CxbwXW4fiujZd6EqXGFmngH2w2YmqRkdNhwj2cOlOc/kJ1bgarJ7rXV8?=
 =?iso-8859-1?Q?lry390lZtLc5S2Nr42ii7dPTq2x21IHjxKFlxbyQ1CB1JWTv7m7s6ucNSs?=
 =?iso-8859-1?Q?J+l+YyNzrmCZ7fd6Sg/f6X0GVcDplWk66tihRKmQykwM7xJz9Lea7CcjCr?=
 =?iso-8859-1?Q?ozEw1aFlNDQDUd0RkJ69S1H5+wo8A3CJLkQZl6yQat7bh3FlwO2BJ9tdcK?=
 =?iso-8859-1?Q?CNojeJeFxR5CIU/Madhli658uA5G+cCzjA/wQLXAegc0+hwMGNdQn71oCQ?=
 =?iso-8859-1?Q?1g5dORlC+tBjWnL8kiCblEJNG4JEoyXuGADAc5caohrIninWVvBkEywaWP?=
 =?iso-8859-1?Q?kuataEFIJbm6FnQ+rKt9bO685IjhztKQnTGbR74MaEeeeDEZLnMlUGcQDO?=
 =?iso-8859-1?Q?sQ1Al9XSiP6gORnnBu4dWs2OkYxZuD7O4Zh9jDNc02sqkiUWriJKUQGf3s?=
 =?iso-8859-1?Q?7ks57YN9+dQ3Xnr6phAbJ0Akzq4G+F8cvPan5rClHhEA+xALsgIZEbOnUC?=
 =?iso-8859-1?Q?+1hV9CXmpTr6KufA+eVYSDhAfniQ5hZQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?/FOCy7uHug3LUvFYWUJnzXbcQPIPlXwCz117qLgPDU+JDbbGRweJZHinwk?=
 =?iso-8859-1?Q?LvIKbiGTzsgYBwBQ+uJKZWe5bDMk6I3jv57of+tyiYgqP1Sz695MbWfTM4?=
 =?iso-8859-1?Q?KgH/+EamzE+a/1wNYbVe+exQEfTL+aQaQ50/ouF9+o9MIvLd28rwTInc6M?=
 =?iso-8859-1?Q?lr3xlsQZ2Aem69VQNISiHiRdyX05/0WYLyYZRL+6p//At0FNJN5a8yp208?=
 =?iso-8859-1?Q?1lMhiqDFWeQws96sdq9XbLoDlrEUD1WkXbEmldFpjOFfwg8xsmAv7fiNih?=
 =?iso-8859-1?Q?TkrOyEs/f+7Vhn03eLnwsW5nvonlOlepFFK9/WasI8vAp4krVVgJLUU4+O?=
 =?iso-8859-1?Q?zPtVR7vPtQSHRfEKrRe9BOMAEoNkZ4/cE729uC1bfg45wkhorZZpDYkpUY?=
 =?iso-8859-1?Q?joTl71P6S+AncAL6kEDTbNrT2/WBD2xbRr3daJ5CadABrr06VzxsqKuN5D?=
 =?iso-8859-1?Q?9CBUVHIzSCdCHDco9Q168M7xZCSR16a2LFmRA3idSEK3sJe2i04f8n0swb?=
 =?iso-8859-1?Q?vJ7sxvAZCmkFvpfYdlJT6p2H+TR8UVlxzGzamavNocnDgUxWoZRrTe+s+T?=
 =?iso-8859-1?Q?5kuuN9Kdg6jqbQYETW4USYiVCAPO2ginst96D6GVM6XMBqyTCa7S1wnT+1?=
 =?iso-8859-1?Q?e0PIVC1TB4ZBzcL3TmAFyBaQ3sCvlkxqQwQ5SPoFlfAL6BJXkT547ts0HO?=
 =?iso-8859-1?Q?khxYURx3bG2Ym7IXf99VSlwThJMmzBiTUU8LozaqkZsSzcyRR7M/C7Ks7a?=
 =?iso-8859-1?Q?Vh30vk4K9IPou3ltCfXFvnfgMT8U+CUj97849tmBRbmad5/BV8k5rjaGNR?=
 =?iso-8859-1?Q?8cYn0nSxZadM8GJNspunIUSlpS2cKtp2tyegSiu4emIicSQBWlqeFBkkXj?=
 =?iso-8859-1?Q?AXictdtTsYytvmT9mQDmvAHwJ85dyzy/My3yZzFYlGfQCgCoaLKD+wuu3m?=
 =?iso-8859-1?Q?s5ww/q8qyPeFJBCx0lBcQIlHXS8vZsu0Wo5lz2mMTdhaY9d1cFKJgRia7B?=
 =?iso-8859-1?Q?vBzbgtJnzD0ayhijy12gea7OGIx8JBtnTY7XhOpNStle6B5WYql53tGFff?=
 =?iso-8859-1?Q?SX3yAbzPObJVGnC14F/KNmXsel9EGOuHWH2nax54hr19c8nQM4wkrOS3xN?=
 =?iso-8859-1?Q?WE2V1GiUgqyjP+VO0uIcGH9PY3ug4i8afu2QAzm0i5/yBqzzURywhLprW5?=
 =?iso-8859-1?Q?Ctny8x+VZx/AForpTjK08UAZ62n3i8NyShrsMJon1srzau+P1WsBKFPZ3o?=
 =?iso-8859-1?Q?BCerVytfD6iexUJWFbocw8QSrDttJlqu2eRjntBOGQ5HbHNMkqhf6X+RC+?=
 =?iso-8859-1?Q?k8U3LffMpQ4xOUP5J7BSki2hVw7vbw1M+RuYfCJHkoRzedvhWme5xnmG4h?=
 =?iso-8859-1?Q?Aqalq999lUv9sFNCltRJp+H0WR+7DjvNAaEJ48Uen0y69iZOlSyyporLJN?=
 =?iso-8859-1?Q?idIArYYyviQdX0TvM6Jth2rkjrqym1aSZ7CSjzRs7XM9Pbp5qbqMWQqoIj?=
 =?iso-8859-1?Q?LYV/R63VZ3HdBId+qbBSRslifAA+UA5WeUsOMhzLKFe6tTjMJC9nLhyKg2?=
 =?iso-8859-1?Q?Bd933hPy78kOv5Pq3NB2ZZmhiq6tLgDk9SPaw19wLjAB6wO0rZjtKPVyXc?=
 =?iso-8859-1?Q?fpcBH5RvyZsLnwMA3GBCKDV6qbItf3NUWk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a200bfe1-05b3-472e-a67d-08dce488247c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:20:56.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaI7YW9nvrd0LVniI65ptsRwMAwdDf9eVImWN26h3bsYTQwNtnUmQb2voqnFneKuOrQJZOAqFoGwwKTG+Ug3cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8615

On Fri, Oct 04, 2024 at 09:29:14AM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> > + * However, some I3C targets may request specific addresses (called as "init_dyn_addr"), which is
> > + * typically specified by the DT-'s assigned-address property. Lower addresses having higher IBI
> > + * priority. If it is available, i3c_bus_get_free_addr() preferably return a free address that is
> > + * not in the list of desired addresses (called as "init_dyn_addr"). This allows the device with
> > + * the "init_dyn_addr" to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
> > + * if the "init_dyn_addr" is already in use by another I3C device, the target device will not be
> > + * able to switch to its desired address.
> > + *
> > + * If the previous step fails, fallback returning one of the remaining unassigned address,
> > + * regardless of its state in the desired list.
> > + */
> >  static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
> >  {
> >  	enum i3c_addr_slot_status status;
> >  	u8 addr;
> >
> > +	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> > +		status = i3c_bus_get_addr_slot_status_mask(bus, addr,
> > +							   I3C_ADDR_SLOT_EXT_STATUS_MASK);
> > +		if (status == I3C_ADDR_SLOT_FREE)
> > +			return addr;
> > +	}
> > +
> >  	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> >  		status = i3c_bus_get_addr_slot_status(bus, addr);
>
> Maybe here we could also use the same status_mask() with the other mask,
> just to clarify the difference.

Make sense.

>
> >  		if (status == I3C_ADDR_SLOT_FREE)
> > @@ -1918,9 +1959,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> >  			goto err_rstdaa;
> >  		}
> >
> > -		i3c_bus_set_addr_slot_status(&master->bus,
> > -					     i3cboardinfo->init_dyn_addr,
> > -					     I3C_ADDR_SLOT_I3C_DEV);
> > +		i3c_bus_set_addr_slot_status_mask(&master->bus,
> > +						 i3cboardinfo->init_dyn_addr,
> > +						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
> > +						 I3C_ADDR_SLOT_EXT_STATUS_MASK);
>
> However I'm not sure I understand the use of the
> set_addr_slot_status_mask() function. Can't we just use the normal
> function and just extend the mask in the fist place?

The major purpose of set_addr_slot_status_mask() is that reduce code
change. There are already address alloc/free by using I3C_ADDR_SLOT_FREE.

we don't want i3c_bus_set_addr_slot_status() touch bit
I3C_ADDR_SLOT_EXT_DESIRED since it was init at scan dts.

There are 18 place, using i3c_bus_set_addr_slot_status(), but we only need
touch I3C_ADDR_SLOT_EXT_DESIRED bit when scan dts.

Frank

>
> >  		/*
> >  		 * Only try to create/attach devices that have a static
> > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > index 2100547b2d8d2..6e5328c6c6afd 100644
> > --- a/include/linux/i3c/master.h
> > +++ b/include/linux/i3c/master.h
> > @@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
> >   * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
> >   * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
> >   * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> > - *
> > + * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are preferred by some devices,
> > + *			       such as the "assigned-address" property in a device tree source.
> >   * On an I3C bus, addresses are assigned dynamically, and we need to know which
> >   * addresses are free to use and which ones are already assigned.
> >   *
> > @@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
> >  	I3C_ADDR_SLOT_I2C_DEV,
> >  	I3C_ADDR_SLOT_I3C_DEV,
> >  	I3C_ADDR_SLOT_STATUS_MASK = 3,
> > +	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
> > +	I3C_ADDR_SLOT_EXT_DESIRED = BIT(2),
> >  };
> >
> > -#define I3C_ADDR_SLOT_STATUS_BITS 2
> > +#define I3C_ADDR_SLOT_STATUS_BITS 4
> >
> >  /**
> >   * struct i3c_bus - I3C bus object
> >
>
> Otherwise lgtm.
>
> Thanks,
> Miquèl
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

