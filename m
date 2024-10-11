Return-Path: <linux-kernel+bounces-359080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908399872C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D291F24ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5571C9B9F;
	Thu, 10 Oct 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V8bdCEgH"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557361C7B78;
	Thu, 10 Oct 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565702; cv=fail; b=U6YWC5A4FdGfgP2K2eX12+8EcE2/AYKldvDcJqqtawcprnYNDLU6skSfqZ1LNCDFwAHVWNzgPjHJRYjT+/dWpcoVqrB4unxBQv9XSq0RQaE35moV4eNNdyFWOEys+HB7zUL6oU9GRQL6eB0mNU8ARBclVvd7Js/hcoSX3Wso6tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565702; c=relaxed/simple;
	bh=iYBK78a+Veha2jT8f1uZSmVDomwWOBR1U1jhCHLjars=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqS3o1DxvKv7U/XSUFZMECFrVEL3CHrqZVLcQW7HHTa+c10sJxBldU9oHkRCGOd4WZHT8opqjt9dMBaUBXUsUsmcDZoBPvF6e3VOTPb8AQF+sFtn0AiQyiiIG9erF9gLvu6+vBz9aDNwRZeHB3Q0hwUC+8s+GHE8YwrlaaQMpfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V8bdCEgH; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhy91HLSWrxJIOgvQvLD3uOp2bjuPPAa9jA1KYd6xsw57bS4FE9avWyKbNS2oEyZ1DeCaE6Vq8Pq2idMIADrwtB+MBS+7nPvqvTkCucLsjE07TcXLVE8b/Q8iZP+mivdwhxyzkrT/KJY6dUZ6lbu1n+JxsfblENW7GmHVdRkdDsrW2KXFwUSMegz45IRM6v4jJYksbXMPOQanX0gr933uHEt5u7W7WAh1fHxTxYqc3jOG5kwVnIc9483OM8U+9AOaY47Yu2NOox7KfY+Og1chZY25Jyrxd4DVW8qDNRPmPIlIUa6PSZ+UdqfILxRcGFywjZ+hd8R7YrC0FtvGXqJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zji7s8K+Teg4OxfNj1MVznN+HT4AZg2VTOahJVV0FbM=;
 b=xg+o336XPBaEEaeQh4bQHKPwUl+xxzOjHi0xQa8OvzECsR1hpGwV0D8n4QBcKyxx7ZsUCVEc+IgtM6n3MObil2Abj9NIhDYvycuJjBp6DCbvkGt/SZlowDCXmbDEAzUlOCMMwXCRd+ixFD5SICDRE/aMlzf3uvGv8FK/zbZr1gouaB6dhtw6dWK6iD9nC/zEODJny3B+h/UA9+os8tVf/+BcbO+dZnijuK/wfyg3ajAcUWkxZ1de/3L+2SlrfK2lmVoUBqASvDtpfeFuOoQLfaMw7JYY5qaTtTLJe9S1KFTAZ2ZpKlRDAZEHj3UDVnn2ByGB+m7L1AlWKDeMqpeKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zji7s8K+Teg4OxfNj1MVznN+HT4AZg2VTOahJVV0FbM=;
 b=V8bdCEgHva3UfvRv0uMyKJrcqDnQSMnh/AaNVtPb0/P6OS2XakJNprClata+9rHxOg/2DcvvdIV4+c7DKYo6Ts7bqXteXQtDYVibRa57ixKjAZf3uJ3lFMKmmMhC8PpcXCszQSHLQYa7+nL4o8HLroslNp4a0QSjE/KSUdlO9HrEGcqNKYG0s5YZFp93Y6uu5aI9zpD5/Hz9lZMNiheYMkDS84aF30lYUVRMxmRwwzhSviKUgTU5ES3ExByI8ZlpxhPETc8yawN5kUaXN6TwirMmbQWB+B1JiSeQcRopX4POzxG0xVUgiYIltX4WQbyWlVjYBH9pOQ+N5ycDM/mdAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 13:08:16 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 13:08:16 +0000
Date: Thu, 10 Oct 2024 22:10:31 -0700
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Message-ID: <ZwizR5YkT1Q9jKzf@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <20240627082426.394937-2-pengfei.li_1@nxp.com>
 <ZwZuTWspV54Pn0GN@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZuTWspV54Pn0GN@linaro.org>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ca7d6a-2fc1-4039-8e4a-08dce92c9ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yf14fKgec9xR1f1tfWz73HW0aBnSu8yC8zgTKp+O1sD0NPBQ3ayxBYex4qVx?=
 =?us-ascii?Q?JQu5UxwXp/4jGyclEuM5M5xojvNB4QSD5AOO0HOWpmR/Lg07DsSzP2mdOpJz?=
 =?us-ascii?Q?KVvj/Mfya+e5aEj6fq6Xzdpy/2WpEdYjj25qPWyl2TIyKDZ3dzc7T7OE4SFl?=
 =?us-ascii?Q?xKv0qgi5E/ZafjXseDlZm80t4h8pjuedf62PyopJstDBZEezlpULi3iU4Fe0?=
 =?us-ascii?Q?W+hMdOVdQn6wCdyj64TwBK56bSnaZNpDMC/QHnZvZAPGg5OHqbEHLcRv/4zN?=
 =?us-ascii?Q?f8l4KbwfB6dGNJLDrxOuUlXeU5CXKmzquGiaCdKWW2ZlcwiIJBvG6x3PN7iU?=
 =?us-ascii?Q?eb4bI4MaYo53r/k9PPtAV1GXxctQ4an6zNI7bCUTGp+HHyqrG5itHlBJ9kzz?=
 =?us-ascii?Q?2eNJ4ddo1c09oZ0sXiU9SgvDG3t358Z9tEbJaWkpqPR7mwgHUtadxCHAp8wm?=
 =?us-ascii?Q?GPyjxgZfGiPpQlZeNS6NKEhq0LL9FHBZHmYnW+C9c/v37/NXrbnraqOsxe9X?=
 =?us-ascii?Q?jzzFXGW7FTyHO6KCFBVk7Jh9yzMVvbf2hDvcamV/Zdt0k7xR2V83L9gL0o1u?=
 =?us-ascii?Q?3eYEHMuPgM4eaXLDVyxXEG9/oyDAxH76i25vKw18jJwK5ZagOaRifas7WgON?=
 =?us-ascii?Q?eyA2YR1LoN4nNOu4ZF3Jl2SA0UBzND/RpsGeMjdfxOzAYQqaGhVY5JT0lE+X?=
 =?us-ascii?Q?XgJFHL+eyLYSzRycWKDDPVDCEZmad7J4kzTs/DtUoVDvmqTa2n+QWz4KUf6I?=
 =?us-ascii?Q?7aaYwjAfsWwUGC78/g0kS7ajInEoNT6frB5GDtT8Wrxd5zDOk1UndiIxvdZ4?=
 =?us-ascii?Q?FaDereIWqj6xtFvlaXR+SGq8exx6Hbi94/kliNRHkZ92M29JAa3hIZk1A+oZ?=
 =?us-ascii?Q?vOryZCg7TfCPMCTu7f89a9v7wKtQZ7I4Bocb207k6V6PedM7twOAahX24X+3?=
 =?us-ascii?Q?GY0LncPTQTTAD2j8Wzy6DNyWKPh+ke8pSjZxUC4Jk/JAEQTq+arjuExusqpL?=
 =?us-ascii?Q?XWg5eK7h5sEqqraMp1N4pL/+pV7LtKt7wqfROJ/wfhqGrAAYOFtnWxPyTfvk?=
 =?us-ascii?Q?jNzBQc8erh25qe3PZUYQ2kkXikXSDRsj276ehCmFLk3rhOEfxiGh7Ip1O8r1?=
 =?us-ascii?Q?AsPwypBA7bBLw3Bnp5LypTEUPm9JktiTtZQqmEEdDvw54rnn/mFIChNLWySW?=
 =?us-ascii?Q?Qeai4XPi3XZTb4Or0xoZ66Ka1xDVRH0vItUMT7nX2PzSp7BFqwVemfLtPfo7?=
 =?us-ascii?Q?AdecpoYzue26B8lo1AmhHCTiihjRAnElCv2fv9MVnL39Y8oVRxv1WYdDcMOj?=
 =?us-ascii?Q?oOeXwtFcZKI8RsIPuzuDc3LD4/R4SbySK4QnQR/uVgbzpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NayqYjdntLYpthd2vZEkihF6iG65x1AJBer0nZEwLyDk5NCwGGkmNPUyybqz?=
 =?us-ascii?Q?duGWIIyAwIpSxEFFJecQH5OAQAaJbUpd0JCbwRh94jG4D/byPpk/r1cfYyQY?=
 =?us-ascii?Q?08Y3P3l8NOn39LyAvmw3kTdgLjn89dCeGD13Kgv6YYsQmlOttdWFWPgUDJyh?=
 =?us-ascii?Q?ffZS/wu8VwhmGFMp2hXbn7A7Nr4aF66l7GhMPBHiz+0k8kOhqo95W7GoNeqw?=
 =?us-ascii?Q?D2Cc5mo7RDmMcVDaibGNATSD5iPRHtmi6AjqEs1paarnjiCCctjbDSO1iO5J?=
 =?us-ascii?Q?T+92k1uBWPE77WBmZKbgmMHesLB591wI7grqPJ5YWHyTlmH/2R4xgL6AVcsv?=
 =?us-ascii?Q?FwlORn/Vyf0M3GuZC2ElilOryguSvE3KrLKFAoy03H8NBnjp81/r++Fs8jUo?=
 =?us-ascii?Q?iruBlQgbhI4yo3j9cp7rtc4UMxgZ3FVeBp1tzxtv403PQNXRJpWfjaIS/F0D?=
 =?us-ascii?Q?YhC79CEoI1OLimpG03JzlCzweIO4OWdFp+Ihn+OkzrZzOx+igdxOLxBmeGDj?=
 =?us-ascii?Q?jTO/UTMX1u8zcOUTgUvCUYYWZrvFa8Q/buwN7pWdVEWReZiBzZQ6h3Umslx7?=
 =?us-ascii?Q?8iXJMB9ro9ddlb8xRq8ceLVxRoFN/HLfdK1h53cuWG8DHpuYmOsTVwPemlTv?=
 =?us-ascii?Q?cYYoSMvnX0Ft+VRLK29kPYpAlrjwLtGeoIw6NnbYakNLjSgNelX/+VTz0zYL?=
 =?us-ascii?Q?fO3HueiXpVFk1n4UBpOTL7Dw9ekrf+ie+Pjd7EFuycCy4CaIeTOqnSOKnxtB?=
 =?us-ascii?Q?KD7mz4WET7Ek7Y79m3LtKAnPrHN76RqnLyqye+DKYrmT6pDoG/hHchLfEMiT?=
 =?us-ascii?Q?jOhy66pHsqUb2FKaO3TXVJSvs56v0QFxPygyTTa6vlmEd3QB/e4O3Q6BrJgF?=
 =?us-ascii?Q?4wYlY4h/rkYgkEAjASvg5j+wNzjKH93jMCnEzIaG7Y0GHGTP12zXduuLyiwh?=
 =?us-ascii?Q?Yx9PNxRZnVibxHeIX/1tUTPvOZjX3pd7+tqWXqO5FGG97MJQXIPYSFW8MOwv?=
 =?us-ascii?Q?AHs+0NmxdolAbgEo3+FlPujNKlU7zjqa4MoFRUWqEHnAP0ogzb7r2bQVWZhl?=
 =?us-ascii?Q?noRk0PLv0LRgRL0CHEbG1cZvErZg+v+ovpgBgxCvHXP7qHRgSiINfa8iqSsd?=
 =?us-ascii?Q?PJd4C4gqO5rGofh4XxcLeU1i5D6Lp8/5mtg8W4gglPQFc/2mP+vookQlDDqM?=
 =?us-ascii?Q?8anNiCny8Ou+lVBVt75ky6k35K2YQFsFJS1CE6/KiNJZpSk+yqe84tk1mVUM?=
 =?us-ascii?Q?tYKPHfnEJZQV+FkbU+8NNxG9Hmx8srU1gVO6zqW8GIC3gnp083QjLzi2vV2q?=
 =?us-ascii?Q?40eNNCrYVoY7wnXTfxBG9ZnZsuCOPidOG6AFUYXNL4foDLZtLGSScuupvana?=
 =?us-ascii?Q?om10nCJpZwhmXnYkcT5AVHs6ITllC4nfzevTj7UT/yu55iYJwa1JOBSAG8HW?=
 =?us-ascii?Q?7a26Wy+JM/uoLFqLWKWzZKsOm+ciEXFTLN+OaBOkLi6wlBifwJghMbYy3srX?=
 =?us-ascii?Q?HoYE+diOjokUPIAskgxxQ5D7WCtxUIzdSmE43j8MAnahAGQOU9x18Rkjo0au?=
 =?us-ascii?Q?ugpNE4NAYXKDknkU9AjgT+We/9UHjZaFG8F0JEs+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ca7d6a-2fc1-4039-8e4a-08dce92c9ab6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 13:08:16.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+d25rw1ozovLDkle5SZq0mDXyaToPOzSpT68LTHIW+Xmz3BiHv5clbfzYCiNv1TW6COuvUlY18R3NWzl4at6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950

On Wed, Oct 09, 2024 at 02:51:41PM +0300, Abel Vesa wrote:
> On 24-06-27 16:24:25, Pengfei Li wrote:
> > IMX93_CLK_END was previously defined in imx93-clock.h to indicate
> > the number of clocks, but it is not part of the ABI, so it should
> > be moved to clk driver.
> > 
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > ---
> > 
> > Notes:
> >     Change for v2:
> >     - Use pre-processor define to simplify code.
> > 
> >  drivers/clk/imx/clk-imx93.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> > index c6a9bc8ecc1f..c8b65146e76e 100644
> > --- a/drivers/clk/imx/clk-imx93.c
> > +++ b/drivers/clk/imx/clk-imx93.c
> > @@ -15,6 +15,8 @@
> >  
> >  #include "clk.h"
> >  
> > +#define IMX93_CLK_END 202
> > +
> 
> TBH, I don't like this. And I still don't understand the reason.
> 
> Where are the clocks you want to add ?

Hi Abel,

I re-sent a new version of the patch set which includes changes to add the new clocks:
https://lore.kernel.org/all/20241011045736.308338-1-pengfei.li_1@nxp.com/

> 
> And why wouldn't it be OK to just keep this in the bindings header even
> if you need to add more clocks ?

Krzysztof has help explained this:
https://lore.kernel.org/all/a07828a4-8040-42cb-8c62-8939cac4d9de@kernel.org/.

> 
> For the moment, I don't see the value of this change.
> 
> Sorry, but NACK.
> 
> >  enum clk_sel {
> >  	LOW_SPEED_IO_SEL,
> >  	NON_IO_SEL,
> > -- 
> > 2.34.1
> > 
> 

