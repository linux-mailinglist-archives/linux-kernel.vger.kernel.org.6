Return-Path: <linux-kernel+bounces-564259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA1CA65154
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190861639C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3551819D07A;
	Mon, 17 Mar 2025 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UA8MHxZr"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B423F42A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218594; cv=fail; b=hAKBXX1MHV7Ro1xihlEl5V8NCR3MalfeP+Cgd1AyF48KoxMJFchlLMiVukBRJQlDTBJRDfpsS0aTaGil5G6LQLVstl69UqGQp7I28LO01bOX+kLLXpZKq57CH9uBgzzVRhRYDCkSUefmvO/M70/2tRJPupMDxuUqku4e5BKWLGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218594; c=relaxed/simple;
	bh=exKgfZXqB57r8rCpoBH2riVG1WAbPNeQo6qtTP6sZfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JSvmRwHQBLplZmHCgp/AD02ELz6JRiY73CaZ1MYH56xMz8is8H4kIfuGzuseNYvj4J2kqIUf9+9HQYflncR/pgf0w8gRnr275kd45Pa0D5Aaw/gq1W2SO7CnBQPcrSgRCuf0pATTsvSIVYZAiDfZXyZ0KW2ZtWll39XQs84DueY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UA8MHxZr; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl1yOAbsDfyRCXiDpuaqbZMX9NUYX13Jc/8qcJMqz1QRaBbvRt9SidA/66+DlRYNX/mUanDF986MA5nY8zggLE1qplC/uHT4ElgScPcV/68nsax5LEgcy7+toe7FJC/FY+Lxjo9dMuIfs74Yv9qlmyCUof0hhcsivP9s1cXSnXxgudlQDOYMnC7TwHPP8Qtdo17rZPAt+2rO/64M5yEAvXOIwNYjpdy3j9d9MhJ3dudyI9dWT4hfDY+XvllaReT7GpZ8GWWdpOIPLhrAFoinIbPm2DH+pNnmA1x6cFg+xX+KUDvaz+xCQydBQrtzHauPNhKq+qgWUsTMUwCidxRxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMiJ3WmAFL0qniSawnPzrNtL6xyke4JvEiTsRgcgvOw=;
 b=J1Kp+qhGetTsnt/fd6ipStlvv83t+e+W+Tg/qPYWqNdyI+NWO+Qx0v3TxqdQZ7lRlXSECLKZh1QjdNgK/mU+1EncnIjfFhBuXfo/d5KSV038/2UmLPYJMMNgll8XEYPUVKqYtoVa04aRoDl3E+DyHco2m6oCmyiJtmNTuCaRMV7glCVBLo0M4Urv8lsTYZnw8k+/SLd0+b2F6kwFBPvZoCW1dJyZ5CKeUv86HeEKF/EUxssJp4EASDL7xhv3gEAJ2dHz107jncaNcWMkmYaZmzWH4pJoLQ0/4mI79tyObOMcHl1Vdv/LcC6E/YAakVVtW5IjsfzsrZjGLATEN6DqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMiJ3WmAFL0qniSawnPzrNtL6xyke4JvEiTsRgcgvOw=;
 b=UA8MHxZrysoYUNNf16wzF0XjnkrCL58KCw5/Qyvsla7ZuiPXQKSnRjLJccHAE6VP/l26F1IoL9+wYAy48nOPmmssHBBFyhK+kmhepsk9+zGLCzee91DMSACUaKVSF0QEdXs+TYEAtjq645IgpvDJ2CX0sAbMF32vV4+aoHoW6oj0i2TDHYOGsOBB+GEkB3qt1wGeSdNZeM5WTL/cq8MTlV9OHqYW53MPEY9D/aQX6obZy7t5jpLVxPggXIg9dzgeNN/GTPdO6OoqgkSDtWoF0Ns77+6Df5J16GPxvEpakLtL8GRIqCpfXqnxumUZ2fFdThCpy08PbsAl4htajVSctw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:36:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:36:28 +0000
Date: Mon, 17 Mar 2025 09:36:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 1/3] i3c: master: svc: Fix missing the IBI rules
Message-ID: <Z9glVBnpdwXuLwD7@lizhi-Precision-Tower-5810>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
 <20250317051951.3065011-2-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317051951.3065011-2-yschu@nuvoton.com>
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6ad1f2-5a91-4115-934c-08dd6558b85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+oCbd0SBvNiNVHTX6sNyJbvk4Saq1M6KztZQpdwHO6R6CGAguOUcgd28HL69?=
 =?us-ascii?Q?RnBIewWHxJ3rhvSv7d39kMDGd2hlfTJnErdq7mg+7wEvkJofnMZoERXwNBCB?=
 =?us-ascii?Q?sfmt+LxNO3as5zFPE/gcyYNgJXGJDKI5Eic3YRUdZYNLtSfqgqQXc5MfxSn2?=
 =?us-ascii?Q?uQb+BRlug+Ua253HejAANtJKumnbT/Sob6yiAa/r8YrGlrRZO9elYpye/ZhD?=
 =?us-ascii?Q?+pLcHWbSErmuJaj3HU4+0u+0nY/AeOE6JZDz0HicDAAAYMBaJD4eHTbqWC4k?=
 =?us-ascii?Q?n4g4bsJlBUWuEhjmfbDNJONJJfsJYEJAbG/1KjwGLlK4mTGqYLXzVxI0epJ+?=
 =?us-ascii?Q?61HIhCQEKsyi1HzC0JmNs4ejwcL0czmGskEaDBcMbrAtssD6oA73PWhWcoxO?=
 =?us-ascii?Q?vGg2pjelIXEMWyUZ3DQT8MJD94bCimDNwCl2bzFSrPFLBxAhGrVOpixB3pCo?=
 =?us-ascii?Q?iNOFpXNSY+IdbuVB7usB8qTV4x3lWpG3oAlwjr1GpoCXycwMjQlhO+QBujrQ?=
 =?us-ascii?Q?BGQ5uT1HZobm6/uMwq1SR33eK4oju3Uzx0PEohob6zhMkVDvqruC9URXxIUs?=
 =?us-ascii?Q?oaL6or3G3m9Gv/IyAv3aG9W3lSXI2vxfnRI0FZ7bOCMSAbionei02ZYH9oL4?=
 =?us-ascii?Q?9gf8zThyR98FOi9oSqPk9T57kJJeqgzDBFxbOFCjA6axB/SUJY95rPMcJE2M?=
 =?us-ascii?Q?RgShdP2BQ0jHl3xwNutn0SGhGkhldmCO+HYj7gU31E3see+QmYjoUPy6ddK6?=
 =?us-ascii?Q?6unVXdpXsryHVXO026E5S7ym7Y2NlRtJNeHLTRTAktG2rtcCbZCOy4XeubR6?=
 =?us-ascii?Q?I3MRLckCHzmm/K+6ZPJPOVfNVim1j5Kr446MzIMZs2kuDKZI0FdneM+ychGm?=
 =?us-ascii?Q?f5L9C073SrxcuMyEdnlhMcWJISxovQvNSpVitQ9bGnHQTYqgKsRkOgaNp8xu?=
 =?us-ascii?Q?Jfd1VtSJggMAEFQLxnRYIVwlzTobAWSAEJ60MeAgt59UZrtO2E1G+ro9rrDh?=
 =?us-ascii?Q?oNHKJap5ZEoiHXNX23oyWjo08aTcT7o6CjWEvJaOxhOyv/o2+sEWgj7U8jsL?=
 =?us-ascii?Q?+Br8fuavI+ne4hQBSdjSFefu+eqro5ZUNvWdWz8LSE5GclpSbugkUqSLuwBa?=
 =?us-ascii?Q?tAtrNRuhDp1ym+NjHQjnEbwpDwokedMlrjM85KF2bGY1vCXP2bumHTt4nYGl?=
 =?us-ascii?Q?xRiUOGr3LijLtGsdAFihkSy0miXTj7Dmwa5ofKQpi7bISRvx/lHPoCqC5zJr?=
 =?us-ascii?Q?srQO0COvYrNv8wCmWKccW6U2NgR2orFS/CjnijerZ1j4AJGuVhyUGchmtu+l?=
 =?us-ascii?Q?0CYnDUtcjHd7XLL5fHHFGPE/FOUvfpK+ZyN7I8mPXtWmaCQGp2eIh9E5hLmQ?=
 =?us-ascii?Q?FZX76KIsjSKjMekVVJx9/o7fnh1piIqUMgYdeWrR7A4vg3D4tTID/3LswWZo?=
 =?us-ascii?Q?jPi0G8f1jdvEPsbBU+qbVSpc2RwG1Yvo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y8J58WA7PJMzc80rLwTwA3Lv+Dv+BfZBNPWxMZL17+L/ROQIOPiv1YgNpoYg?=
 =?us-ascii?Q?R241Gj6I3X5m68z1RG+JeUdk15gnxeDf0wYnwso4hgUCtvN5ILXjuoPg0U3/?=
 =?us-ascii?Q?RPFohLGwbvRn8eMgCG/vMewMh57jHyZg8IWF8P7mgbwoDcxs5DeYJCVgjj6Z?=
 =?us-ascii?Q?DbyHpp5fsIfVrlAwXnMV8iEpZbUGYcMxuS8/buU+TMiF0LLa701v6GAOg9i+?=
 =?us-ascii?Q?WicCP11c8CsjWX9G0wsdBrv3FPdfGSdCCYIwWqEh98S9ni0xJSMmWHeMzcUo?=
 =?us-ascii?Q?yXrSl6c9Gb3yXu62gFf9G9ppjiVpoQ2MHqZtLhLZx7ZH8Ppb5EKezfKVi9+h?=
 =?us-ascii?Q?lvNuJ2I+Y9tUPrh+eLkr34FA7Uh9aFcPBXWiWY+b/15M3gxzjLa+PMEQ3DqT?=
 =?us-ascii?Q?6WksneYYwGzqbvDOzQ4x3DHRtzUN+XK3UKuD20+6n6dEEUyZ5LTDPP/+sydE?=
 =?us-ascii?Q?Nn9zLI6VboW2vuI0m5VLZO1wzGRPUNgBfBuusoXnHh5BrHc9/ECV8QvWC/UX?=
 =?us-ascii?Q?eEBHcppdlxSHhEi9fXZ5Mu+8J939hE9dDB2t7/HIuUvYqSsKK+YXkvc/a36a?=
 =?us-ascii?Q?cCZ8V7xPIe2hdOkBMlPm6dZMS/vwZ2k6zPhhh3i08VDUbmCxnqfw0WWAuGV7?=
 =?us-ascii?Q?akU7f74AdH3eGCddT8QjNMt+/jN0ZN+b3ijfM+IUmAmVDwMoBFFbJQE/kqgl?=
 =?us-ascii?Q?dHZICg12cNROz6t2+uV481dwkKI9y4EDRi/Cr21xclDuKRPYLlaqBvtSO+FS?=
 =?us-ascii?Q?u+GmmY3dH3sfj8cwrIsrvVldjGWBJ/5Tn6fHVkrNvHPL8YpL48LZp/XUVbQ2?=
 =?us-ascii?Q?q3ZRgDv2iNWGx/LJ2emNW7I1jQX1UbwWMbn2n3brMCEDwdOPxJ5+YtD8M84Y?=
 =?us-ascii?Q?JixyqTUTvPjZDx2m1vwFZSHrBsSSKT6MTZ7+Cqwt4s9k2ziwNYbEnjve7hRT?=
 =?us-ascii?Q?qiTcPQ7oYqTF1ftpeiPJEcaBNHGevyjfeQqQkZhi9oLtUZdTj69Tvr87KZJc?=
 =?us-ascii?Q?/6uBG4Xxh2O1TzAduijaRkOp/l3sE43P+2GlgNo/eNK2T4KGKMpiOs0AdT0D?=
 =?us-ascii?Q?IH/Kn3nUcsvqXvQPeE/2CeN8MfcgVbzeeGkodUQPXJ1iJTK8E9QdAsLZjnoX?=
 =?us-ascii?Q?cWmPaQR0w3OMowaHNDYRb+DdK758LJokaJNwUaX7TZtBW2VYVD6g9r7HzCSX?=
 =?us-ascii?Q?kG/rMNUbBMbFndOMPjIM612DP7sZpT3JtyzsKtv3QCp8+Vu3PiqiYXtF+sE7?=
 =?us-ascii?Q?sbs5ROiPnHnwfOZFMFdBT22oHNKBQCBuR+ES+n357gyTJrN3oqwbefrxYY+7?=
 =?us-ascii?Q?wxPr7RNkrUWXtRLFx4bm5fpeM1oqABi+qVxL128QTBPEwcmzXuey8v5Deksx?=
 =?us-ascii?Q?UsFz+cGsQuPvJu2qbtPI/9dWVHEJfKNHSDWekYXBUGkJaEgXmPd1ZjEhT8N5?=
 =?us-ascii?Q?VTtvaK4IZ/eIJoqPkJbnHCG09YAFSUfq48RKTbqnIwm6QfqP0AcaN7hoJuri?=
 =?us-ascii?Q?CYqrQNoR80kP01qJwKM3e/oC18FGOAmF9OERRnm9SlUoRy3XTF6nX0P3/Ew/?=
 =?us-ascii?Q?VVwTDEevaIpv+rR5FHg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6ad1f2-5a91-4115-934c-08dd6558b85f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:36:28.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxLrTpGrZbuIfY/0y0L6bo4KwS7Rbb/l9KGhfqodRW/KVMurbcoG9LkTnJblKhs67MBXR6KF0jwXmGwVXdn2PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515

On Mon, Mar 17, 2025 at 01:19:49PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> The code does not add IBI rules for devices with controller capability.
> However, some target devices, such as secondary controller, also have
                ^^ dual rule devices

OR

However, the second controller have the controller capablity and work at
target devices mode when the device probe. So add IBI rules for such
devices.


> the controller capability.
> Modify the code to add rules for devices capable of sending IBI requests.
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

