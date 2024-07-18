Return-Path: <linux-kernel+bounces-256656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD84F9351A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296451F21AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE74914535F;
	Thu, 18 Jul 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pQI2uGAT"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5321E535;
	Thu, 18 Jul 2024 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327854; cv=fail; b=YtyrlgECwG6q83/Ht1OHw/C/lG78caHsrmWq7huNoeQmuZPQprp7g2eaTVSB5Bp2bmeDWVwIg/tO5K++pXnPd4TwxNzNSj5TOBtd4CyAyLS6JDrxF1/B7OlIRrCAMjbJCJGaP74XKtmLlMTM/8eJERRRC9iPTEHJYDDSUm40krI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327854; c=relaxed/simple;
	bh=DyEDQDUGJmikAhOBTMSpXUl13X4vsKjX706ODF/+YHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/5+iMKOBO6SY18N958bK/81+zs2Darc8wQNvzL00bjds3Z3ej9AaKf31N22NjsTaM36nz2SbzQSUlKwjNG3WLU6DEB3NYhBgjT6sPRM/1brJNFfJDLlIXxDsqkb1jqzIWNktgYyoLxm4OiOKwRt7WfuPEAFO0AXmkF9Ig7jKT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pQI2uGAT; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVaR9Vj5zIqY+Oxuval7G6iIc5V0aAreIojc0EX5ZPox6e7y+nxHlf2zdLkp8BmL3OCksWg27J4BjiWQvnYMqDTZifPxIxqnNjRnE62lu+/tSVknis/WgNR+msMhX9gg0XYsUxR3Mbs7zwO2QwgflHevX4nsa0kqeKYnImVqkLf7ykNn+nVD80kAMd6hJILtGGT1YnGJY22na4rVyZc7XPLMZ+Dd/a0Qtc/LK/HZ4f/5lT4r5aAjBnvtqPem76deEqz5H+KtYcHrwkCIlJXfU6Fi0QYxfns+szU5lGsZGjwK98J4uHsQhaDqjSAKH2R5xyQjgYv0eKZSjfIzGQMs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z76cjEX1xgmlUKy7NieUt9uA4ZlB9pfKdUN/P9iB9U=;
 b=BVUlqZnl03JeUZuL/kEnhWAzs43PiM9yqvONegJUqiIj/S0hehHzI55o5ujl9sRnot5mjAtn6aUryRXMweNdmNtuPyyY21DAQHnHP/+rZGseclj92GNWsd6chc29NN99epfFOfxsTXK36nk3p6oZmpSuArhzjM5WhaQg67cdxaw30DKlxjdzcpWT4Q2SrWFZHwSoqcnKoj35TbaWD567GkGOEMDGRfTDWP7oEWb0Fgce3SDfXo56ndpJ95FLDP9IAUNdnItfZALpJQYJ/zCNoW8ZbdSyVFz2BLBsoSZTeWjmdQCjs2PWP+XRUobtNlzCyLWjSSyogYxZ+9DVfhtFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z76cjEX1xgmlUKy7NieUt9uA4ZlB9pfKdUN/P9iB9U=;
 b=pQI2uGATv3dxCVCWgRqmDZdBbxPG2OeyC3nDWg82iVu0V4mTXvGfcWvlaS197Dw9Z7qz1rz1jCYZBpd80mN3xFatQ1baOlMZCBYreCYJgsi6Tb1CrqlHFHeaP5rYMCArSrJCgjKJTmNUt1zIV2QrBdoQz7CO5mYwGsWmtlUjOXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9726.eurprd04.prod.outlook.com (2603:10a6:10:4e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 18:37:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 18:37:30 +0000
Date: Thu, 18 Jul 2024 14:37:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: Fix error code in
 svc_i3c_master_do_daa_locked()
Message-ID: <Zplg4heiWF9G0ACq@lizhi-Precision-Tower-5810>
References: <e017edfc-da64-496b-8516-958bec27cd9a@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e017edfc-da64-496b-8516-958bec27cd9a@stanley.mountain>
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: 094c3639-a7e8-4f6d-f873-08dca758ae23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmgQtqOPDaaOlTn93R8Gn2UpHAbv5M4BcTjHqbQynlyLC3ZgqHG+JX7kA9hf?=
 =?us-ascii?Q?2ZHT3QTvHFr7/Xv2q7hg6NGpQuCQ1tGA1dIau7ea8gj7QjPln2wHuc7mA3g8?=
 =?us-ascii?Q?Nfu528OWZmJ36gMeLXDdoOOPfxqX1bmU3UrWeQyFmr2IViWM0uPl5DpGWNux?=
 =?us-ascii?Q?DvaiSGOHf3K+NRY1QmVbSAX7mMji1aFRfiA4B1M6c6Lm397rQgv97X069fFv?=
 =?us-ascii?Q?ajKOrFASzLyHZWpChK241Xy0/kh63Pl/8b6aEkqSXuyPiaJrFixnPdo+lp6M?=
 =?us-ascii?Q?daU6y1nZxTsGor/AExC37vtSkr1r3MWPVHnJ23D81QkZx1d3tZ4C7hkE9PmV?=
 =?us-ascii?Q?HNxPRb57HpDKe43RZQ5wAMdaXbQlItFEyzDHB39HT4EjyqgwsYSQ2PpzbFx5?=
 =?us-ascii?Q?4IdXeTGEriXUPxfGQfcBZqExPrIZXlZ7R/RctIQKt67ob2RvCVnDsbdWCsEC?=
 =?us-ascii?Q?HmcaRV9u4BYjcQ233jJeclBDBDKknpEEGB1CyTJl5yAuUK0IRHN1WIsQjnCd?=
 =?us-ascii?Q?rEoQYJY/Y8/VAti3TEJ3UJycP64PIILXvckNfOPwr2s6noWJagV4WH/PsuzI?=
 =?us-ascii?Q?8WznRghHxJip+cpbB8H2nN0iUR1Iuh/3oh2M6k2AHSJgDCWdTgmPly33018J?=
 =?us-ascii?Q?78qpCIe2wjIXCivkOxTQoMdkccgpMVKjMieliIK5/Y8MWoBNvJoPiR4DLJWj?=
 =?us-ascii?Q?KSwhhbs6u9ltjzeQYlBgwAR5Fe3xt2Z0GIwLLBcw8IuErgUUO19aWeEOWcPc?=
 =?us-ascii?Q?E0c4NLu9YvBBe78tTZjwY4L2GuSxqDYuVHC/yHIzt7uAGy0Gbw2Yd1KEQ0GO?=
 =?us-ascii?Q?7nXIKB53oSISzAzgvId/iUXTWD1SjANqdKrCBtpQBTTfPWStEP0SZRw+MKC0?=
 =?us-ascii?Q?8xY4s8y7g2XqHWU9OLQ74cpjou52CqUlxZjSSZhnyJLfsvFMsGTT2/JCYn+V?=
 =?us-ascii?Q?RgT5qA6P0jbn0OGYEp8M91lF2cUswylSvzOMkI4xt/y2B1F8R49drHMChsTE?=
 =?us-ascii?Q?HhrHxzh0rdHtRkTrucWCMHtY9fdTBnFgM0Haadq+Yz8cXGOv6N191EOrrOCU?=
 =?us-ascii?Q?2Qc3zkjPo5/JKlgQwwH+zPxVpOnE8Eniol8cDdYLslPA8aoGZSDDCGI65JSa?=
 =?us-ascii?Q?R3eNczxR252Pmx8M5A5eEkIV/7hBVhtUUQJr8phyd9ABQ0EckBmQpzwi/14r?=
 =?us-ascii?Q?340SWptleu3H5I9CF4djsug874YV7kvdbN8/IZVZTJy0X8IWMIeacpYRlrMm?=
 =?us-ascii?Q?+UAzvOqkoU/dgRssEcLsG/LPFBvDJEiBNVdzTXfWmwX1a4leqsDgkjiDrbOY?=
 =?us-ascii?Q?YDr1/1LOUXG1RM4Nbd+BWYEwZMc8LScW8dDxyt009OHLjlz73CYFLcsy8rKn?=
 =?us-ascii?Q?p7uQKP92FIL0fPTjcXbJNQOxuG7SXB7vgtiJruSoRxYA/7RT9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQ7lvC7I26ejUgF3d6MUMvDRaztrexJhcaUObYgX15ag3PGoG3ANHGM5BbTn?=
 =?us-ascii?Q?TqBGpyUnUJOynBZCwgRN8aantf+xJ2pAflpYdHVSBf0i9Bt96KjLPCQ4nSvA?=
 =?us-ascii?Q?Bt2QU5sjgUl1VswkP/FFyv9G53RXQoxkKbVUUfk4HM8mO+dttimHV3LkFBxo?=
 =?us-ascii?Q?rEdZvQIZoCfgsjzRblXAsj4XDszNdS3PWogmJm99KZ1isDGlz7fQmbGOiYfA?=
 =?us-ascii?Q?ETldVYW8e2MPbW4CTplcfDIovIpTvxqHhQurgFxQDBwpkNX6yyVxW0BCrN6O?=
 =?us-ascii?Q?pog2ynKEmy77BoHluvJlxxyJ9+WkkF40AkvPVkaqP0CciU5xYX5V4bsBgSdn?=
 =?us-ascii?Q?irVck0TkyM0kafOewSBQ3G5fE159Id6WRWq1iypnnuJ8wlg7ENl0yOjFwaar?=
 =?us-ascii?Q?DM6SHPZDuWXgeJN336CDwZOBGWXeZbr5Z2om11OFTYMxK6s9L0nbtxxn189I?=
 =?us-ascii?Q?betoEIG5Lkp3Tpzc8pi7avUTPmuqkqWTGNPoWFupHZqfnsB6JGftTx0pU7Ld?=
 =?us-ascii?Q?fyWB5cE13ofB5KjL3c/kmU7n27bZu3rXB24o2EzJEYpyFirxZ6F98b+0D+Ds?=
 =?us-ascii?Q?uzi4Y/vQQTyR1DeCEtAf5l+mU2O6aj17WS/1zJ2czFVpnEztLCmQa4RGE/7H?=
 =?us-ascii?Q?k7DjNze9N6gDgSluHf4rqniaJYa2Fk0epG9FLmjluI5elIFz5EZznmtpsBiu?=
 =?us-ascii?Q?7dHB1ESPE6LbMz5SUswUWjWVLki1ge5FptROPCCR/fVO0EYCeETCTUrTMfVD?=
 =?us-ascii?Q?XhpBoXdgf1tznOJq3zVEMUMS5BtZBkLLiS05Q3H480yLtU2ghRLPVsu3otqy?=
 =?us-ascii?Q?jr6/JtzuM4zKr/ucKhupbPqZQfSVQvluoGNzyyTGXWuHSquzXJFFY3sqbT8W?=
 =?us-ascii?Q?NHseZ6e5slHDhHxQ4R9FNy6YV1kjr52voW/Zhko2let5cz0+TfMTHvdK5XLC?=
 =?us-ascii?Q?jUcx8QJxg9YmgbZkeZu/N9rbtOE4HOA10E6NS2kag96WRv68e3/J7onyZ1PA?=
 =?us-ascii?Q?l3/CmGCw9QKr/FDdmw0wJHAw577avD6nVfaR5sx3LN00qqQvTSNBjFiKlM/z?=
 =?us-ascii?Q?kK3FzgQuBh7qqlaKjNVHa+9vqUjBVnhEwoTkkA9LNglZsSWD3A0fEaG0++Rt?=
 =?us-ascii?Q?QtUNkDCzt7mG9cN2sdDL+7/v8Wmy7UoIuqzJQ/hjLrXwzd0/ieflwvQIxF1B?=
 =?us-ascii?Q?gCmKBN4n3irnIhWmpNEu3uUhpWtgVBtGwLWPMUqaFCkKRxqJPLoOV2fyPHdK?=
 =?us-ascii?Q?s+jlSIRK52dTcL24lUmXtImOUeQuyacDbD6/bsMF6hgLagsM6bZfFEjFJnoy?=
 =?us-ascii?Q?Yz2VpNvKWIU0edTUurGCQEzrXJZohzVFR/iE26VDDPcCzxgfO7XmjRNvemfD?=
 =?us-ascii?Q?aPpF7T7yJX6QrGVduqLT/QFY15LZ20SUK72ZFZ18lgkS3PQMuIoj4xpHMOLP?=
 =?us-ascii?Q?FK7s2uRMItyoGbiTk6R9sOJt1cp4h18nLZ1tu9cHLc22NeeD81+o1ggufHI6?=
 =?us-ascii?Q?1BIJG7C9kBWGeSG/cdZysMh4rUMdh0CFjkT+WrbseE0uLKP2jl7zjQQDLOsC?=
 =?us-ascii?Q?flBfZftYaIkkqDs+HUU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094c3639-a7e8-4f6d-f873-08dca758ae23
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 18:37:30.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSSzwo+Bd4SHs1YlnPn4WJYEB3WEN1FLGGe1ZFwCutFTNFJSuhJuM8QEs9p0SEGg8YC/NTraArNzPlwIYUW68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9726

On Thu, Jul 18, 2024 at 01:30:22PM -0500, Dan Carpenter wrote:
> This code has a typo so it returns positive EIO instead of negative -EIO.  Fix
> it!
> 
> Fixes: a7809cb368b9 ("i3c: master: svc: Improve DAA STOP handle code logic")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index e80c002991f7..0a68fd1b81d4 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -874,7 +874,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  				 * address this time.
>  				 */
>  				if (prov_id[dev_nb] == nacking_prov_id) {
> -					ret = EIO;
> +					ret = -EIO;
>  					break;
>  				}
>  
> -- 
> 2.43.0
> 

