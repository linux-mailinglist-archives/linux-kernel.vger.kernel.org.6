Return-Path: <linux-kernel+bounces-213620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5FB9077D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28886281DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823012FB2F;
	Thu, 13 Jun 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WBmiuDLq"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2051.outbound.protection.outlook.com [40.107.15.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C712E1C2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294811; cv=fail; b=uYLF/4ZaGWVdwyZE9o8rs3j5DiQDYllrzPSnEFCvuAgrG8xXsFlhU9WOU9N6cfnssOwrkmMbhdya3kFfnNq8MtuKr3TL092EZ3OuyFywlvCWdbBntNzquff5v+o9qhIkIySaF1BcN3eJ2m4BvJaHlB1QbOrOtDwyfidI3GDRA9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294811; c=relaxed/simple;
	bh=1/TA131bKTHje2ETIR65IjNOtqGhZGkLStBJaozxXEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A5el5CHr7228gz9KABcM9XYgcBs6YUmOiHSiUHlOekJLb3FuiNkTYVh/6wYfg1g4AEmfH3lDMxsvPLu0fw+fXBcSYJcH1LDTLEi5FlZYQHFrH7NpmG1KRof3mYTVUA5VJ4c4wEPSJ9qOA9yyLqp88JcaimJ9b9Rl+ZtIaELf8i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WBmiuDLq reason="signature verification failed"; arc=fail smtp.client-ip=40.107.15.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdMpStm+zBvhGmv2XPs+ZFxwxF3a9fajOTkK+3CoZxX/hmonO8ww0cwtv5uPImrShA8uUIYVbsVrc/OJg+bcTuz4Ekd/MV8kcgOoNoXtMmGVdQWOjCx6/UzqYW/d7RKhUcicmf7JVEVcITS60XFHRwh2bhu7MF+IfFhG2YddPGzgSOVIAUaZycXEo+xJze4KNw4UFi+5/75+DHzggsxhhPL4KCk1yukxylDy5Mqe1V3YyDiS+VKn5NsXEstv6qczZZDW/imIiniT5a0iDKmYNLmsRcqYuGAN+ny+DR9TUA8T2xLLTX+7lq6EB86oG0oQocG5CSsAjPTPdfjcRtFTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3zgztUIByQpM8Bju+MXWFL0POd4NsQyw9gOXPkWTN4=;
 b=Ja3a8YuLKpIZ7h65iDUJcJxrjWEcrs3jUGVibwK1RLONBAZFzBdu9d8Ip9esBbt8DQDJURzSg6M4jDv4GUrHA7cOYv5jgQpOWZE1P2VANO07hCA+OHVaMl8scOXhmLShJ0wp5yLl6cZOINa32NsS1zh3ZEFEfhgTV2eBPfRNPH6RZBDp6YG8q6nOWX8JeoZt/SmjllCC4gdZnTeMRzp9FDnBmzLJ3Nhlo8zsUiO8GbqIm3n4PtK5hi4Dch6nerp82ud40bQXG4VoqE0dx0Nx2AxR39MyukoMTdwwdYqlHNdNyIyBQWn1qs7Ty/csvW+lK1bDVckobaPY1pEQLM9a8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3zgztUIByQpM8Bju+MXWFL0POd4NsQyw9gOXPkWTN4=;
 b=WBmiuDLqwlckSce448AajDtlLXKrvCif9Rbn9PD+ATnIVHq2E+NGHorZm1TaISDsY8XIATlrZU6Kqy72cVF/mqbQhrmB2KXDEYDCfm6LWlxbDXTw5ZLTT9XQXmbrrkb5vTyb0z9jWR83QW/hJoyfJEXepD9TCUSADgNLQIkvsq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10234.eurprd04.prod.outlook.com (2603:10a6:150:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 16:06:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 16:06:46 +0000
Date: Thu, 13 Jun 2024 12:06:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	imx@lists.linux.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i3c: master: svc: fix IBIWON not set if IBI
 follow a hot join
Message-ID: <ZmsZDpl1eOonPYL6@lizhi-Precision-Tower-5810>
References: <20240603151527.52235-1-Frank.Li@nxp.com>
 <20240603171919.02c70327@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603171919.02c70327@xps-13>
X-ClientProxiedBy: BY5PR17CA0048.namprd17.prod.outlook.com
 (2603:10b6:a03:167::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10234:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de426bc-2f73-49a5-1c78-08dc8bc2d30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?X/djIT3FRyuoOLinGXG26RjAkuJaLEhO6EGMgWb0fsGjSbKEQUjsSLVIXv?=
 =?iso-8859-1?Q?JZJ3TsYaTVoPtNyIq2jTF5/Z+53jyKoD+ZZGomkoHHntQAPplIbump8SpE?=
 =?iso-8859-1?Q?YJHOuFoIZTLNMqjKR8rfb+K4ihP9TH1JmwwsrP+wEeSO4sMW6Tpiwi0wnr?=
 =?iso-8859-1?Q?4m6saPnxoJ7ukXfKVjYfhBabSBUiu2l09EnQxOZTxPHBBGLOwM8KM6QFL2?=
 =?iso-8859-1?Q?rlwKxvfmcBAyQjsmRIBdEFCiY4gvB/lJ1IQ+pbr00b9r+yKrloQjLcqpzU?=
 =?iso-8859-1?Q?xc0Zq5SkjWrmJaNdHRgsQhp+IQX/FWUQ82QgTyEbNBJUXGx6jDSauEPuqG?=
 =?iso-8859-1?Q?rufLWgHXsGW0I5u1TQnUG8DHhzR+GQ+rZTNt+uBMchG/jtu+3J4vESXjZr?=
 =?iso-8859-1?Q?CA2SJNTJTWthtvLSPtB+VXIKjgkPU7rDnBUnJOQBJX+PKo+moYq5nc8wfp?=
 =?iso-8859-1?Q?hJVuDMwM+z6Cntax5g9cIpLEOV+LLKcLBofJHt5dPoPaELh6uZPUIyWaLM?=
 =?iso-8859-1?Q?v7jW3jIbZfK0KMQnoU3LzaHVr/1smBCILr2YgcUM0Ye5quwNLkc6Tyxizn?=
 =?iso-8859-1?Q?PNSx3AUWZSOfqncrLmmDQ/TnCwFI1gPuWhlQfZT9oNncixjhmjAlNHJRTO?=
 =?iso-8859-1?Q?2OXBI1bMlTsb181A0lGZt7HZ+IWYVGoB2HoOfDIaZ0wQGz36VmcNOVZPsQ?=
 =?iso-8859-1?Q?jhtYEwZQWP82ewwfGyb/QLHXm4w2BstVUYjCoZKl5Ptq8/eAbKLn5vdhKD?=
 =?iso-8859-1?Q?Z5n5ZvLQtuMPbYjrtXEGGqp2AyUoNnYqxybuJNj/oeEP6kA2zyqFmjJrhS?=
 =?iso-8859-1?Q?Mtom8zZillNk/ZUHXmxb3dWN0EbfHAVVcw8OpEwbmpRvKpTyaOPzEQW72G?=
 =?iso-8859-1?Q?SQKl2IKbCoMX6K23TJ5tEblfqRZZayCKU3lMlACYC2R2xO9G+eAr/UiRRN?=
 =?iso-8859-1?Q?BSiFatVBv4dg6KBxPngOiOtlIzHeBhE3QO1JVn3VbJeOZyIDJnoSjI6lQw?=
 =?iso-8859-1?Q?H1eut1VB/dLgHp7Yp9w2Enx21rZD0DNXhyXFCRKxCVO/dYeccbxACI6ZfW?=
 =?iso-8859-1?Q?oEJZg66FccCZTp+zPsBSCHcnlr2it0V6trCCAMU8m9JkMdwo9ZvkgzkhXa?=
 =?iso-8859-1?Q?ahD9aFpFuNMxAqnNFjieE4TatKx8TeOdG9Rozs99egamznp9QxsS/NP9dS?=
 =?iso-8859-1?Q?cNVwHa2vw6XOAGpQkBTwD6Bmv/RSGzCClzaKoZuGUStEOfubXUrKjmsmnl?=
 =?iso-8859-1?Q?5OYeD9KqQOs9O2HqU1iMsXcpZvhqsXDaX1H/FsWvevnCE/XYHy6EmUKLNT?=
 =?iso-8859-1?Q?meS/Hhd92/dbPL0+bniWJt8VR8cSUBcXaiCmi7A/evPC3azXeaYlMdvcc1?=
 =?iso-8859-1?Q?9UCceoZ/p0UzhFeHs6ysVOJ+wvSwSFltkGMwZtTWeBwW7YSN6PGzE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?eLzEJoPrRfhyuUwr2tz52KFCBXeuHPrAlQ0VMoYhmU8jJxiudxjlHhjah6?=
 =?iso-8859-1?Q?7ikgu6aTsKrNVnXVz/TC3u/SxDXzZGKH8xN1ViEtv3DUT7JESrnalFT/6U?=
 =?iso-8859-1?Q?pmqmfJ2Ely2bJKq0wS5SPqkzgcsDdPHahmSLRT02cfEz7xmnMl9SWbf3AQ?=
 =?iso-8859-1?Q?9AHNsTv54OC6+DmjpBDVymjAgVIVvlTL3fbCv9JSh6O2+QpVJ7QHwtAFbn?=
 =?iso-8859-1?Q?EYY7iJNW6duUN34DkZ5Ay++LaPTjyAVP09HD0hIKvdxs8n2h9Dq3lVPx5d?=
 =?iso-8859-1?Q?kX7dKrlExTJTidunRsdAMB/8aglQS0qFJhmsv+V1mXm9SRdWird8xZ4oMT?=
 =?iso-8859-1?Q?QIMwCjItWzpmUzCiTWkgiuqfDKg0CYI3xvq26IYaPn86KI/DiAyYkWo+wJ?=
 =?iso-8859-1?Q?4FmlwvEzr8lxLvoS85CdjALjjGRF5oD/8gJXWEnbGq6TW94YCQXVZo8GXo?=
 =?iso-8859-1?Q?JPMuIlBsjvVMAWCcxpqgJenG0WDMIo1B0v6wLiiEzaS/wtij+ajFJV+RHx?=
 =?iso-8859-1?Q?Q6XeePKH/tvCGdfj0g0j4q5jpWRffeKfrDTwFeJUZjhjv5jrxeHq44LyNn?=
 =?iso-8859-1?Q?1BZT30J0y9AqGsj3eQ0r1uaOJOmFbWT1QtM2f5U6g+FvA8BUgrttl4RWF6?=
 =?iso-8859-1?Q?BRigYkjlbqFYxaWwjxhlBSFGqCXofDjMrijAgHfcnX4NWY/GCiEOjgHLre?=
 =?iso-8859-1?Q?fOd3uKObVsNE6nWRf4jxBPluqVsqBqoueK3+qbXqNOgO8TnHWT8B3q4p8w?=
 =?iso-8859-1?Q?005Dnvw5G1J4jKuVqFGH0/HkKDWRO4DP1QCniGDc1/9QO/4X0V+yLXP1V6?=
 =?iso-8859-1?Q?AbPI0iLzBDUMft82NanOl9GCfaR/76ta4UTvDlgDkKOHCJ8sSV4M7RnPOM?=
 =?iso-8859-1?Q?wBypKrIEejTsNXcCpd6PYRKDtHeKklbdd/Vbn3Rq1Gx9CwtId640Y4I/98?=
 =?iso-8859-1?Q?cwrtFlE0MxOuR///+zG5U8P5tVaMYHLooZrATsX3c+S0fPogjwgpW8XXrW?=
 =?iso-8859-1?Q?RiUmU8q1dYZO4ZiplmBM/fpTIy5Q3PwWIo+DdrnDd5uRy6lbiTEhqEHGR0?=
 =?iso-8859-1?Q?DCvT3OZNp/zP/dnpdoB4ZIGYh0GHBCnfTacax2XFs5fYkphOhpW2qodK8T?=
 =?iso-8859-1?Q?PqjIWJaUegbgGzjuCqLBK+XqTmeUfEiX2SGJUGW1X3OJsLTHiBkYp1t2To?=
 =?iso-8859-1?Q?2vF58yllqRjqC1kttmP0CcT1qVIDbDVAMWZHT7C3kT8RBWsv1U/dkYuNTB?=
 =?iso-8859-1?Q?1vZLIVbUmHhOTz4fYVPQmPiNAxb/GfiKVk5pUhEhd393QqfV5OayBcSUQK?=
 =?iso-8859-1?Q?49CC0Bt2vKgR3jPXz1hgfPhpGn2VLhqm6uXpFHMdcMbnhK/dSkgECdR8hz?=
 =?iso-8859-1?Q?kwiUlpDf4HwSaGi2389Gkw1GbQPauLX6gcD4hSE6rV8PDjrTZXewjCjfjj?=
 =?iso-8859-1?Q?vpNd7TmC56QXc6nj6r4ZPOpEiFkXZse5S9lmzMi79TP0kCWGXe1ifXT7oA?=
 =?iso-8859-1?Q?7tGRoULGPO1KD+yOlqenxizyv42LKQTYyhClG6XyrNvRKWjSjC8jE4FcaQ?=
 =?iso-8859-1?Q?NrDf2TcNNdXUYa4C7VpH/TzdVRLQtL3WTE3o2P0i8pLCYBZyoXyyN2asLM?=
 =?iso-8859-1?Q?KQYYzokn0BTDE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de426bc-2f73-49a5-1c78-08dc8bc2d30a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:06:46.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCf65cq/NJGhngW/ELJ2/DKGPiFd9B/SmuSnL58s16/GZi87gRLbqQikdD5GORtbyHivSUsc1RF1DxSUXV2olA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10234

On Mon, Jun 03, 2024 at 05:19:19PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Mon,  3 Jun 2024 11:15:26 -0400:
> 
> > When an In-Band Interrupt(IBI) occurs after svc_i3c_master_do_daa_locked(),
> > typically triggered during a Hot Join (HJ) event, the IBIWON flag fails to
> > be set when issuing an auto IBI command.
> > 
> > The issue stems from the omission of emitting STOP upon successful
> > execution of svc_i3c_master_do_daa_locked(). Consequently, the controller
> > interprets it as a repeat start when emitting the auto IBI command. Per the
> > I3C specification, an IBI should never occur during a repeat start, thus
> > preventing the IBIWON flag from being set.
> > 
> > Emit STOP regardless of the success or failure of
> > svc_i3c_master_do_daa_locked() to match I3C spec requirement.
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: 05b26c31a485 ("i3c: master: svc: add hot join support")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Please hold on this patch. Hardware can emit stop automatically. It need
better fix.  Let me work on new version for this one.

> 
> Thanks,
> Miquèl

