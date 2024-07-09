Return-Path: <linux-kernel+bounces-246613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C834892C451
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF5B217B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DFC185611;
	Tue,  9 Jul 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lQGhtty6"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0817B02B;
	Tue,  9 Jul 2024 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555654; cv=fail; b=LuBsDl+cEh9JS1seQZ/HYG9Inql6BQjLXigqof4nNBisd7E4lXdWEC/rL2oh/NIe9OML2UVYCE+WhvGwoVM7fXIXH53QqBiRcSfZKUuzrFXwgHQEL8X8UuuJd5kpeuR3T22KYna8TctYOm7BIzOzzCxbvVueElX2PSuciF5bauk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555654; c=relaxed/simple;
	bh=X3WeZxT/C1FfjBYnj10KAlslgaTAJGWVXBTxoQXV014=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TFMrgXD+PI5yBYQCtKxIfpmTqkXIyaweAarhTMijClQL9YKuRwacc2xejaUIOFxG8ZIkY5RK3i3jXYrXtsFXZo1IqXrzxWtTXqoWrIiC3fp51VikdggvJy8VEWsxyeHu4CoTKEQUz7se9tTelmNksJ6YaCUNhgVo2KrA1C+GlOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lQGhtty6; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng6c28akdCFXjWVcXTr5XkvCp5hiih3cZEOgznoAjrTkO62TEHUjUKSpmQIN4/F+y3egyIgTlrEYUsMILWqjIJvMDpQuNuaZXdaDydleIPIUdL1q/coZH3mmh87Csg545isvz+m2Wc95n5zR1IbjxO0yNgbZbJryBSCtbyVNK7E/+JdiTIyYWJ7Xb8+aYfW2aZByq7DafOuz/AFiRnqpkszktJK79CWSZ1IPdpgrI+0NCya8dcTu5awpUnmOKcOh/a7VFQJor9IZ60KQ4MmuTwo1VTDRV+Fjg6Vp7wg4F7ZUJ/q1icF2nr5X/VcLr4rVyyBLKJHXOF8kPkKODw0Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENPgg11//1AN/z9y87D6odIfpt42dpJM9pyqwMvK+uw=;
 b=AftmdDSKwX9AJYIG+jShKuH6OU2wiTy9D6k+Typb0e4p2g2Qk/5e7oZFDD20mS/TXOJ30HIv0lwZEYLm5+BfrJfSKV/Yhw1UnASHV5EHjCMBOM5ExgLaFzYe+vjphUmSh99PzZnBaz83eVn8UbxaU6+sraa6+xISAZHtsuGS9D4JAroD3AT95zrk0BoExzAAuJb8xthfME+rt+CK3O/X911mdzPvPKvrtyUm7LFURGXh1adT9A0aZ8FWUASD5cO9I8lcnHKYXcuBUeGrIHJbUC0tS1VmYmk7TvnLmnWsgK+kDOg8xTZrBfUyIyKFAU/faeOWueDlqN7oONAmVFZoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENPgg11//1AN/z9y87D6odIfpt42dpJM9pyqwMvK+uw=;
 b=lQGhtty6Efph0HyvY9/DEbSH76VegCj9L7AwnzMWzNWd7P0QYynVx+6+L6wG4lnISYhoWRwde8c6wfszPX+mVdOzWHWqC0CR4yVLZECK5tz9yQxZAz3IUbZYqyneqE7sDoFnTch2J0O7wnsY6xW9iFGyZMV3roT9KcDfQbKQnD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:07:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:07:28 +0000
Date: Tue, 9 Jul 2024 16:07:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	michal.simek@amd.com, krzysztof.kozlowski@linaro.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH v5] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Message-ID: <Zo2YeE+HTfWKq8jW@lizhi-Precision-Tower-5810>
References: <1720548651-726412-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720548651-726412-1-git-send-email-radhey.shyam.pandey@amd.com>
X-ClientProxiedBy: BYAPR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:a03:60::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: aa95b375-8716-4ad6-0f10-08dca052c23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F8NHfT/i754/UrukpiwtTc/o2pJ/TE272GqHeWE/jRDf6+uj1bbDwrq708Vw?=
 =?us-ascii?Q?WhuqDIGjekwKoGrfd26pc5H6/mZmAobzRHrAXRouuHplwNsHZrUl6CYPaglQ?=
 =?us-ascii?Q?lAvRpgb5kLqvyS6s1iXUI/VuC01/5Tf+HOnRFUQSJXUi23bzdKkS488uNPuA?=
 =?us-ascii?Q?O5+Pc7kTGj8xvSETBNoBHx5pg5Q88JfUgUT0WBao/9ZyddCiSNlmnC4ywV51?=
 =?us-ascii?Q?I/LQFGvM/e8ilJ/oicVqzxIiygZLNnnUtdw2h/CIsSPDfhu/IB3vvQ6zVHrW?=
 =?us-ascii?Q?z11DvopAAplIxbsR/AURsJDra/YYQnXmInGNsFshQMGdbwUiojywGnXKAuIF?=
 =?us-ascii?Q?WYCBGb0xBEo7U2tr7GZUEoqDzHshd5zs1IC+TwHqj0cUkca3P/xCQ/Ujk8tM?=
 =?us-ascii?Q?IrDJEqS8Igb0qePVPaEgxeMXCu3do33jYypcuFB20mfs6ZCmGx/fV1BMypuo?=
 =?us-ascii?Q?LhBy0vOb57A77GR8prPzi0QglnOml6sy0Wi+u+nqb26kULICj54nBxLM3TSI?=
 =?us-ascii?Q?RsNtL09taeyAVoH5zNwU4J1Gms/D3YR5EkSrR7TxBytblig4jn6bUNiFKoED?=
 =?us-ascii?Q?naMwcKMLp+VfG3aI/BCBm7AdAii6eblLpbQybbhUdIks0mWOzjW0ltKOwJze?=
 =?us-ascii?Q?UgDzyKYL1ISrZGTTCm5bl9Ql3pyY4WfSXobx1PV6Yt5uqK0RbrbgmzYMzwCd?=
 =?us-ascii?Q?4DMfIKIIUNnenkJ6h97CD7Cw+kWy0CaMPDbnxLVHF6CklQWToB9roofUxyrq?=
 =?us-ascii?Q?d7Ifdh64cCoZyWO0ECxFIbuPpc/B86TLNpmANnMSX6Lg6t1VrHfDgYKQFIUp?=
 =?us-ascii?Q?W8rTVLmTHTjxwDtT7HVqRdRvthgVhOrg+CgC02n+l6sr1e3S6cEUTUtCooMS?=
 =?us-ascii?Q?3ogoiqG2jSBg5jwekCg+0Bi1wgTYOJuGGS+WuHkGj8Zh/VMhDnVuDC4jp9Uy?=
 =?us-ascii?Q?5WdYT5rn3eTtzd/iCsie99fWQt6uBj3BGMJ3vEBYvbp+1iZ3JANh3yVnVMIj?=
 =?us-ascii?Q?dfKfMR6kVbrCmlTTZdZ61TUHWFsv7PPwR0cBIa32/JoLzLJhwIF68H4GY3el?=
 =?us-ascii?Q?KmoeMlr/oHkXCp4pT0K+ptf1GKgqB++XIYuaJHdQ7YHqQInWzr0vNT3ZJoV9?=
 =?us-ascii?Q?XNqlMYaV6N2VwUpOzVTrDUTFcb/XyS/bkjRI/hsu0+Y8LIRz0lZKRObc4bxh?=
 =?us-ascii?Q?hwUgcXq0u5LYDuNZcco/pvOOAbDmPzG/MDrgTK05VT1LdWjFM7muu5iicqWZ?=
 =?us-ascii?Q?p7fGuKbTV+W7CZtBp+uwLyWSkzlemIjU9GOMBl89Fz/aEAT2YUSYuCetkpTw?=
 =?us-ascii?Q?oo8La1VJv9L6bx+IiL9Sl3GAUZyFYXqJTc2myo5Euh06TI+vTBb6CbnaMfxL?=
 =?us-ascii?Q?gIjmjzo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Zy3vTyYsEev+MBNQj4gvdVFo5eYwieX0XplDxhczlJJ5MOLU9kLKdHusEFC?=
 =?us-ascii?Q?Qgcqg+r1vpFIlVErLFixUx8Yr0qmbH+DqWU4rqoIEmaNSdfIWo4WiKioTfdq?=
 =?us-ascii?Q?lKofcArv/fzeN45tYAFUQUCxxP7pLyDFPqzMhJl1WX2+BZP4Lw0wij3MCN5O?=
 =?us-ascii?Q?l7Kv0lJUkMt1YHTXFzLfA9c4v0rBMyxm1Hf8R/ISYVOzhSD5aWCz4mTCpmds?=
 =?us-ascii?Q?lsj6Wp5y3JLfLcFY33INMRhw6BGwxj8RqrNkH9P3fwKbVLs/1pT+YR4qphog?=
 =?us-ascii?Q?cKeRvJBsJdDMYzZS4JrYb+HcNGY95fjpI5ATmhe7a341/DBcF4HboNJjaZiT?=
 =?us-ascii?Q?h3szhNxl3NX1lCDnPcS0jyHhbc/08WEGLyVNiRA9m7s/R11Qh83q1DXW95gm?=
 =?us-ascii?Q?RwQvobn/5ovBfC8ZtZViuCRw0JMO+DXwuHYbP6gdxBrPlKBrDrnPNB4AlZI8?=
 =?us-ascii?Q?ZLRE58/c9+yrJGLo0fPRlBeZT6nTY/rfPnsNvbxEvZqCuVJ3nsXfmAiD+JpR?=
 =?us-ascii?Q?0uCYtIZZy81smPVA5E9Dk1AwNj96rbbrm08LIsl3WEIY+83Aab1vRKzeadEy?=
 =?us-ascii?Q?yhzDgshrFEdLVtf6TcFf+/Gz+LPpqfCh5JK8fjQxguHAJx8PHmPJqJQz8J9c?=
 =?us-ascii?Q?hmJV8XeUqcqtxtNrA+nevI5IvErgJ56VeGiAuoHPwIkUHh9lFlKWd/gx9140?=
 =?us-ascii?Q?sOPvr63dcN2AQkHNaC39adxlMEYRRq2PyXExEDU225J549CfCN5yHP9S8BSc?=
 =?us-ascii?Q?PvCuoKieFpO1npIKS9kcPAr16PaG5aNTvCYnxi1Dh4ls1pqe8oWre00m7u27?=
 =?us-ascii?Q?c8wDbwJx6iZYLzmcJBgg+cdei26/Ql2OdIBvN9p0ginI9duKQb47h2jMZqhu?=
 =?us-ascii?Q?5EwkPCuZ+Ogaw6oTSke/eK/TqtVQU1Jx4cFW7feJQ86LFUKnFQiiwbXFz56G?=
 =?us-ascii?Q?y0DbCV2raePiWAO18+ZnRUPLlVqizWXzHTAdaJD9IV02BFCbDMT+99D3INI4?=
 =?us-ascii?Q?jrVUmoxn5B1l5DeVP/XB3ulOtbVAUlZlv8Q8Ae00i3nhpRFeaQFym7AfE13t?=
 =?us-ascii?Q?F1/RBEMv23IxJ1v7QEh0uzNj31YLstqfpNpWlSY6cp+Mj5V4tB9C87huaHHe?=
 =?us-ascii?Q?EeW8G0HcIc0Iir0xHB2mxFEYO8pYn3hIhLWp3TDQ5+mOHHlEBZsoHM0i239I?=
 =?us-ascii?Q?ijNP2lp3+SA6X95iD1OTIm9sPy3wVUTcDE3oyJdsTYS7hbLZI8Qio3iKJ8H8?=
 =?us-ascii?Q?Cvc7Nljod6Ta0TU2ThlNGKAhRU3hCxTKiyyc+cbSmOFx9p1lHzorgqSnst0M?=
 =?us-ascii?Q?fvl8fgIS9Wpgey+9V7S8qScyT4jpZABmsXLJnAdbFbUbug7xacd/06tiZw/T?=
 =?us-ascii?Q?8PxIfkXAP8HtdiyahDRUJs3l1YtI3ONgJSTapxowuNV/u3FdLNuN2lfqMKQT?=
 =?us-ascii?Q?LSt9D4R6zyqf+FAGYsH5vE1ZyB0N/T9ixnVrUWzErz0JZyKNX2wPYXFqKi2t?=
 =?us-ascii?Q?mOEssp8qdIXL1XsuxAF1CkJSMW87j2x4sFj0u2yFWGeioiNgJB5s8T/6WbFK?=
 =?us-ascii?Q?6od3/xcq8nNQfwqOuIqHfkc+9k8o7yMJNuHO93Wb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa95b375-8716-4ad6-0f10-08dca052c23f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:07:28.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pMdRBQFzoevb1rrnrr0J4WvsLwc2SJahsWk6sb+tlXQjlqtOkTC1fEmv1BpXqnr5wltVU00MUqYAAmHG7ZinA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

On Tue, Jul 09, 2024 at 11:40:51PM +0530, Radhey Shyam Pandey wrote:
> The GSBUSCFG0 register bits [31:16] are used to configure the cache type
> settings of the descriptor and data write/read transfers (Cacheable,
> Bufferable/Posted). When CCI is enabled in the design, DWC3 core GSBUSCFG0
> cache bits must be updated to support CCI enabled transfers in USB.
> 
> To program GSBUSCFG0 cache bits create a software node property
> in AMD-xilinx dwc3 glue driver and pass it to dwc3 core. The core
> then reads this property value and configures it in dwc3_core_init()
> sequence.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes for v5:
> - Remove linux/of_address.h include from core.c
> - Move dwc3_get_properties() implementation above dwc3_get_properties().
> - Rename DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED.
> 
> Changes for v4:
> - Pass swnode GSBUSCFG0 cache property from glue driver based on
>   dma-coherent flag.
> - Introduce function dwc3_get_software_properties().
> - Rename DWC3_GSBUSCFG0_REQINFO_MASK.
> - Use DWC3_GSBUSCFG0_REQINFO(n) and get rid of mask shift define.
> - Rename dwc3 member gsbuscfg0_reqinfo and change it type to u32
>   and define 0xffffffff as unspecified.
> - In comment dwc3_get_software_properties() description also mention
>   "non-DT (non-ABI) properties".
> 
> Changes for v3:
> - In v2 review as suggested by Thinh Nguyen, switch to swnode
>   implementation for passing GSBUSCFG0 cache bits from AMD-xilinx
>   dwc3 glue driver to core driver.
> 
> Changes for v2:
> - Make GSBUSCFG0 configuration specific to AMD-xilinx platform.
>   Taken reference from existing commit ec5eb43813a4 ("usb: dwc3: core:
>   add support for realtek SoCs custom's global register start address")
> 
> v1 link:
>   https://lore.kernel.org/all/20231013053448.11056-1-piyush.mehta@amd.com
> ---
>  drivers/usb/dwc3/core.c        | 37 ++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h        |  8 ++++++++
>  drivers/usb/dwc3/dwc3-xilinx.c | 29 ++++++++++++++++++++++++++
>  3 files changed, 74 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index cb82557678dd..ebb3f6eb191f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -599,6 +599,18 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
>  		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
>  }
>  
> +static void dwc3_config_soc_bus(struct dwc3 *dwc)
> +{
> +	if (dwc->gsbuscfg0_reqinfo != DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED) {
> +		u32 reg;
> +
> +		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
> +		reg &= ~DWC3_GSBUSCFG0_REQINFO(~0);
> +		reg |= DWC3_GSBUSCFG0_REQINFO(dwc->gsbuscfg0_reqinfo);
> +		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
> +	}
> +}
> +
>  static int dwc3_core_ulpi_init(struct dwc3 *dwc)
>  {
>  	int intf;
> @@ -1338,6 +1350,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  
>  	dwc3_set_incr_burst_type(dwc);
>  
> +	dwc3_config_soc_bus(dwc);
> +
>  	ret = dwc3_phy_power_on(dwc);
>  	if (ret)
>  		goto err_exit_phy;
> @@ -1576,6 +1590,27 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
>  	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  }
>  
> +static void dwc3_get_software_properties(struct dwc3 *dwc)
> +{
> +	struct device *tmpdev;
> +	u16 gsbuscfg0_reqinfo;
> +	int ret;
> +
> +	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
> +
> +	/*
> +	 * Iterate over all parent nodes for finding swnode properties
> +	 * and non-DT (non-ABI) properties.
> +	 */
> +	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
> +		ret = device_property_read_u16(tmpdev,
> +					       "snps,gsbuscfg0-reqinfo",
> +					       &gsbuscfg0_reqinfo);
> +		if (!ret)
> +			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
> +	}
> +}
> +
>  static void dwc3_get_properties(struct dwc3 *dwc)
>  {
>  	struct device		*dev = dwc->dev;
> @@ -2090,6 +2125,8 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	dwc3_get_properties(dwc);
>  
> +	dwc3_get_software_properties(dwc);
> +
>  	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
>  	if (IS_ERR(dwc->reset)) {
>  		ret = PTR_ERR(dwc->reset);
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 3781c736c1a1..1e561fd8b86e 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -194,6 +194,10 @@
>  #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
>  #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
>  
> +/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
> +#define DWC3_GSBUSCFG0_REQINFO(n)	(((n) & 0xffff) << 16)
> +#define DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED	0xffffffff
> +
>  /* Global Debug LSP MUX Select */
>  #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
>  #define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
> @@ -1153,6 +1157,9 @@ struct dwc3_scratchpad_array {
>   * @num_ep_resized: carries the current number endpoints which have had its tx
>   *		    fifo resized.
>   * @debug_root: root debugfs directory for this device to put its files in.
> + * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
> + *		       DATWRREQINFO, and DESWRREQINFO value passed from
> + *		       glue driver.
>   */
>  struct dwc3 {
>  	struct work_struct	drd_work;
> @@ -1380,6 +1387,7 @@ struct dwc3 {
>  	int			last_fifo_depth;
>  	int			num_ep_resized;
>  	struct dentry		*debug_root;
> +	u32			gsbuscfg0_reqinfo;
>  };
>  
>  #define INCRX_BURST_MODE 0
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
> index 6095f4dee6ce..bb4d894c16e9 100644
> --- a/drivers/usb/dwc3/dwc3-xilinx.c
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -246,6 +246,31 @@ static const struct of_device_id dwc3_xlnx_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
>  
> +static int dwc3_set_swnode(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node, *dwc3_np;
> +	struct property_entry props[2];
> +	int prop_idx = 0, ret = 0;
> +
> +	dwc3_np = of_get_compatible_child(np, "snps,dwc3");
> +	if (!dwc3_np) {
> +		ret = -ENODEV;
> +		dev_err(dev, "failed to find dwc3 core child\n");
> +		return ret;
> +	}
> +
> +	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
> +	if (of_dma_is_coherent(dwc3_np))
> +		props[prop_idx++] = PROPERTY_ENTRY_U16("snps,gsbuscfg0-reqinfo",
> +						       0xffff);
> +	of_node_put(dwc3_np);
> +
> +	if (prop_idx)
> +		ret = device_create_managed_software_node(dev, props, NULL);
> +
> +	return ret;
> +}
> +
>  static int dwc3_xlnx_probe(struct platform_device *pdev)
>  {
>  	struct dwc3_xlnx		*priv_data;
> @@ -288,6 +313,10 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_clk_put;
>  
> +	ret = dwc3_set_swnode(dev);
> +	if (ret)
> +		goto err_clk_put;
> +
>  	ret = of_platform_populate(np, NULL, NULL, dev);
>  	if (ret)
>  		goto err_clk_put;
> 
> base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
> -- 
> 2.34.1
> 

