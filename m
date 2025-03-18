Return-Path: <linux-kernel+bounces-566230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C1A67538
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDAA3BB7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8120C006;
	Tue, 18 Mar 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FnGuD+UN"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C03207E0B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304823; cv=fail; b=XpaO/kkkrJK11i8YHc8oppwU4UmEVo9K0aaUae97uaDTucS29qbPTUimPBA7l5xpH2Ec4rn9iPfoHdnJquQcGs2JOrkPKI/IaH3eE2abrAPWNa/BsBW75d1DyIbiHn+umNU5F8s4R23SrWLh1FkdFpXDt5a9EJmtcSm52PcQMFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304823; c=relaxed/simple;
	bh=enmEER8zokhoprpQbHHUqYFkALk2NsY8UDa2JvGXgx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TqZ0c30KKXRnfXMLNPvH+7qEPhNb9as1HhtjTgcDIFBzHqgpojoqrhfRNKapo1MeJUBpZw2zocvkeipvUrd1+TzL5r8CkCW3lQEVbHGuGMXO12Z6PikzDmL8i7s7iTUUwTU1HKvvME7Gke1k6kyJHRqVSCTZpXhQXt64m2T3Iis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FnGuD+UN; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR+/DKUPzhAnBLcoamBcG4jchkpj3Dcx00AaRyqZzTo/Vn/lBpi6Od71ZwefoVmIkwB/yg8cL5UHj8ro1wiw4Iczy8wfF8r+CsbV7+uoThT/JRmnWhhqAcr9m5skhi0L66iHQWR/QSaxtWHBIMmky2N/H3QIRsO4lTBkNbaSsXbLW8xQo5/TMudzagZMugyzdH+wwROB/A4Kkd1t8G7rKn1NFKpYOpSToa0c8zy80l75VteUfYpbkCcj/2yIJZ3uhQuk+By+4bTV9bL8DuV5v1OoJua9xz62BmWaTEnfRDjH2xd5Y1nCmPMwG/LIrWy09aWkuLLDSJPt2wE55h5nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QC4Y45/qlBRYRwcG1Fo2qih70pA/3X8+tBbzOEyltQ=;
 b=JuU61H6sF/QLrwCw2j9eclU+NSXr7HZrrK7nyT6ak63rTvu7vueXAztyI54yt3Y+eDIC84s8+0ACSPxl6wnJzp943/KryMrDEAU6Y8TRx+bTNlJnc+4NyK033VbVuARURHQq+7BMvGB+AWJ+6UTY+xF0JRKTSwOBmDNpV1NHt1zd7Pzfe0Si8TK9+dxchlv43Ub16LjlrN75B/fh8gzS4bKzDhCIUXUKg00j+gLEASCHTOX81XRQH+6B8jvsr8X86clfE1nTVpCIREgssFIfDpi43ufUntuxST+VOO20mLInnaJgotkudLu2s9mAdYI/q+1NZB60J0jxW5TJod1FMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QC4Y45/qlBRYRwcG1Fo2qih70pA/3X8+tBbzOEyltQ=;
 b=FnGuD+UNoYZDXSPNyTqj+cRL9dQQ6kD/61VCkVseWNk5VPIKO+OzYUczfONm0PXarnLBz40Cg4Y1+joCcD1CZbSQT/2/2ZUPGVf8hy5YWSIvXACHOCSjxkLiVGxQw20oUsPfQZHuDi+H6bsCNJKi0qX+wNEESaDv8Ke15/jcET25UQE8Sd+vm1tH1fTwh7j2n/iydXHG1Svgtg9c09vaW3oIx6ZXjxSpq/FIdXMYhWJy5LfoKNam2vEI/iiAInBhBLPyOTQgwbXyeOBQOb5TmDJdyUyodSXyK2duFQFCXv1mrFNco+gXpfAa4SJamIsc8JrLl9ywS42oNKcS+avLfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10314.eurprd04.prod.outlook.com (2603:10a6:10:566::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:33:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:33:33 +0000
Date: Tue, 18 Mar 2025 09:33:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 1/3] i3c: master: svc: Fix missing the IBI rules
Message-ID: <Z9l2JqcvxvtlRdBe@lizhi-Precision-Tower-5810>
References: <20250318053606.3087121-1-yschu@nuvoton.com>
 <20250318053606.3087121-2-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318053606.3087121-2-yschu@nuvoton.com>
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9012e8a7-6e4e-4eb1-69d5-08dd66217a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qBFrBKkOD/6PPzLiPvDFZNNBCfF2CAZ3KHi0RaMF7r5uzwtlk7taYWt7oBKF?=
 =?us-ascii?Q?TfRlu8nRnbDFVOLWadLKW+Aj3IntgWhG1PTWuI8psUZ8dpmAQbk4QgX445PP?=
 =?us-ascii?Q?mUWJQDCrc3nCzmLEBi6T78uyULlyeaxZuWqu8vUD8qDN1XcwO7786cwdWP9p?=
 =?us-ascii?Q?2nkXkLjhQFsZm062m8dN8i1lrOWdNcG7QdcHHbc2akEPVJCobGuuVt+vqWyv?=
 =?us-ascii?Q?BEM+mTLMNxstsfwf4A3iTA007+6dPHyenjKxL+Qf7h/AtnMrytiEqOtxmGJD?=
 =?us-ascii?Q?KD8mqi2R83FNZnF9lpH1YgsDsKUUcx6CoyB9SbXa6eNM3BH28TGanAnPWJbr?=
 =?us-ascii?Q?LEun4XuTsfOlqkSoa/p6MkFOTj1h2aNZ8nMNrJmYLOLEgrnIywPjGLwx6HTG?=
 =?us-ascii?Q?aUSiqL8p72xMflk7XoGJrVOWbB8QbdAUquoObH+FreInAonoOA14W/hmRFLN?=
 =?us-ascii?Q?gaHqAMS0hzF/TPWZQL/TbcB0reTzhFhLtJc+yGrusTTPM/Y6r/KOhBPa291G?=
 =?us-ascii?Q?VRdSZuL3CoyB1suj1HyR5bkSsVjtqLRtppV644wXDSNAgVRzKRvcAe34HVL8?=
 =?us-ascii?Q?oqu4LIuUylq0b16zm4aHDwSlkLUDwCpULE541NrchCDBS6poYDNlhl0ZzZR4?=
 =?us-ascii?Q?QCCeTRIbKH5ca06/xbS+dDUvYjBIEPOzrrInoR3H6F0s5RkaMWqBySjHEVpU?=
 =?us-ascii?Q?tXQrK9tg/I/qzW/Ub4gGBIiQZTLYU21HPbDhmlRn/98upONpCdWgxE9Qshpc?=
 =?us-ascii?Q?F3B7d/1Hl41Wk1qLZ8m1U+QzH6S97hvy/p7dp4koQTktmk+JURRTGUmwIpy+?=
 =?us-ascii?Q?kZnjQzW2dUWOq4mr/4aGWdq0u9OkFJoDxChTQA22uEXCE/EIwcI2IlNeiXS8?=
 =?us-ascii?Q?/r1aJYPtF/3E8cU0uksYwEblcjU/pIcbrqtP6lnlRJ4QeXcaOw9M8m6fPgto?=
 =?us-ascii?Q?YdH5uJyfJdnH/jRltsai7ZzgsofGMwghrmzKz8ct5irkRz7ZUQN5vX6LftUu?=
 =?us-ascii?Q?MpTA4pHVbOF4f8YkvchNXNmwO/IlZ4Eroipqva2Jj3HRLSX6/ikoWfSNImF/?=
 =?us-ascii?Q?RuiVz7EsaMgMjWGlMumGB+5Vuh/IsQJ0215nWQlQE2FQTlivX1hIC0oM1SqZ?=
 =?us-ascii?Q?rlMkdSHQUw18Urf24h8uz+iSXyVFTM5nTjlfC/ptI5SnchijEPTMTN8oUeFt?=
 =?us-ascii?Q?+sP9hrkaJpzCL7VvB20p+JcdlKFiMR63dW2m9ts6u7/6d8N19Tr05Oxe3855?=
 =?us-ascii?Q?5qHJmKxPf0iIRbWCChQB/AZXo9mWMV7+h44urjyb7t1ARZ832uprku72/tw1?=
 =?us-ascii?Q?5B6NUcgYAPH4l1YwEgioNcmNYVkpX5jOnENbglQLNjjPhIsRunUubXQ41oFr?=
 =?us-ascii?Q?t2qlUNRcDEBf/Wdpho6XPU3ZMADdWGZUpalAuF0J18Bl/jvWE0jXIoqfz/WC?=
 =?us-ascii?Q?v33uD81YNUYgYdcKPMObDM+yU1ljkzBm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdgjybgGzF1kR0SG7d+LmVFtMYkMY+rfq53oUu5s/0xQ1LwdD9j0Zu3giqmA?=
 =?us-ascii?Q?Lg8ltGNN4634aOd6/a7G9CGN6Wl4F5FdoOn5Biw4CCIRcMFKNkDBrRGx6fAB?=
 =?us-ascii?Q?driiUphjTDFXnjLQYTCCZpnMxTrbpfIgPazdRKcehfn8ZsK6v/XUrvZI3GEm?=
 =?us-ascii?Q?LcVnzPhagDGzCPwlyHKho0u3N1XbPe+y39CSmRw14MKziHp40N5+YP7qYVfl?=
 =?us-ascii?Q?4RSKAm0mURHWEH51R+CI/v4lInSiz3jsGlG34C1y+moesOlzSHGqgR3Zw0PN?=
 =?us-ascii?Q?2BShj1xO1WGFhhX1Z7RhTFbZGCntfH/YXseDubNr5PLYPcHt49Q6o7vuC02C?=
 =?us-ascii?Q?JiNOoelMn+YgacjYao3MjkOU0I3EXyNxzs0OgAcHK4FaW+5LLuZJLK7AYbgO?=
 =?us-ascii?Q?j0vDJzgXB1/mOnpgIZsa7SuKXAa2K74vfARfip+7hoKzzdY3jFPnwuhoFiMP?=
 =?us-ascii?Q?YvheOQgNAVWiNCXdkduqOjLN5frqqQ6ZWocjfyUYhooqxjca05CVfJHt/NWD?=
 =?us-ascii?Q?1J1CL7uUIWUEiINvedkagBLbs1EVnP+CeuV1s6bmRccUPvVe3tXuLYGf5LYE?=
 =?us-ascii?Q?l/586tmPdByzb5vwGO+sLTQFbNJz3VCj5fd6SxDHoTvLNBedTppeRPsr5eLx?=
 =?us-ascii?Q?NRkCdx/7U3oBhEJEZ144VQCvGfBWdKDsNH/3WND3HMziQAzVHhYf3BJXyJYM?=
 =?us-ascii?Q?XqY2BgiZrW0go+jV/yZ1yp38Ho6MMfHO+kiKlCxB+feOZwbF6KMEAu69R9WM?=
 =?us-ascii?Q?tkzFFgWNcWPpN1VT7OsENqJNUmAvRlxDxU+j/21fSdGwgJX0LJs7uCw77c4p?=
 =?us-ascii?Q?o2W5GkHkkkbBJRXyqHtOFdlsM2OTEUXh6uR0/sxLV9VsC7CQDwm//3as5nRb?=
 =?us-ascii?Q?ozmA/bsvKppgE32yv2Ai2gZoueDNm4nNBoyzl6Yzdukgypj7d4NWmSpF9EQd?=
 =?us-ascii?Q?2FommFy6+mIWBNB7NAHhpKuDMVR5KFEQHHMRUffBeU9vAN+MhpOb8OoNMh2u?=
 =?us-ascii?Q?YTgkFheB07toIKHgn/VqS3TKwJaVsoeUbQgLZkTe5wGAJIJhFRwulm4FojTW?=
 =?us-ascii?Q?uz7+R4KcyZD7zlGnE33/XaE4WQrIIWtpGB0aV5Xu2kduy04LzMPz01x2Bvvd?=
 =?us-ascii?Q?G8wtyf4WturfaYOHQOccX1QhDYulrWUeHAePE41WOaGlPzhsS9CP0r+11rLs?=
 =?us-ascii?Q?8laO5lLrRC+YsFzisLaUqNlPJwtIIVVqzjbJeHCpY0XTRJpKGbXCKwS9DBo+?=
 =?us-ascii?Q?waKYrt7sEUTMV7aR/3K1a03Z2g7RstHkNK7RONKM+CKI7Td8Agu3gTt3b03b?=
 =?us-ascii?Q?g/xRWSioS9MoUMIwzsJUQLPiLvvZ61RAXuJS6O+Ay3/J2gpYA1mRuWkuEtdT?=
 =?us-ascii?Q?vIrxp/j23/0pIxTOE0/a3txYyoNKElzf7Iea7Xn6q5Wn+wx78e/Qikw96rIg?=
 =?us-ascii?Q?NLJdvR0LeCRHcXvGedSEwNpnlOA58FjCK7cN+VaciEJFNY6HpFYL4qgdDzhP?=
 =?us-ascii?Q?rFhKexTWokTeVjdmEmBbDHnUFpmKrv8zruntaivqIS7+uWsPDqiAo53TT1Z9?=
 =?us-ascii?Q?TS5Eudic6QQ9DlJ7yWg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9012e8a7-6e4e-4eb1-69d5-08dd66217a5c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:33:33.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kna38rUeHFNVcRcB0dEkuwrKd8R8BescKOA8sJaN2suJxBK3OnMIhPJYrGV227+fdMyjz7/k4AbSoN8sewT7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10314

On Tue, Mar 18, 2025 at 01:36:04PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> The code does not add IBI rules for devices with controller capability.
> However, the secondary controller has the controller capability and works
> at target mode when the device is probed. Therefore, add IBI rules for
> such devices.
>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 1d1f351b9a85..a72ba5a7edd4 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1106,7 +1106,7 @@ static int svc_i3c_update_ibirules(struct svc_i3c_master *master)
>
>  	/* Create the IBIRULES register for both cases */
>  	i3c_bus_for_each_i3cdev(&master->base.bus, dev) {
> -		if (I3C_BCR_DEVICE_ROLE(dev->info.bcr) == I3C_BCR_I3C_MASTER)
> +		if (!(dev->info.bcr & I3C_BCR_IBI_REQ_CAP))
>  			continue;
>
>  		if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD) {
> --
> 2.34.1
>

