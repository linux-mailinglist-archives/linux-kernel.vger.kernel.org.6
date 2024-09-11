Return-Path: <linux-kernel+bounces-325254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDD39756F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637831C2311E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDC1AB6EF;
	Wed, 11 Sep 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FKkQ0ltC"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0F1AB6D2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068308; cv=fail; b=R/XaCEiMMGi4rq+wlwmR5L6DTj1//ZqBVALSwoXWK3wGkIx8nGki1jF01ZKWmibZZtRAuie/6Bk3jni/lGgstlUHDOnqOYud3iYMoI1sWKZbRP34XK89sE+K1qCuWrme7Dhprw6uS1KfA6NaHV4rHVeHxdm2mq/RN/r2UjpASVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068308; c=relaxed/simple;
	bh=XAy4pwJ7sRTuhoiN1k0s9fjPdkXAFqnL/sNC/hetbqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pil6lRO014tf6Lk7EDweGWduPFtI2JR3D7sl4T0Pr+SiWLfUHQA0VzJSfe331eQbFW9qXGV2wTxXlUux6WiepH5WYbcfo5hcgDjbZnA1dMqTF2Bn6lZmOcUgt0F0zE2LaALCtAwCO42ub2izrdKklWgRqUNnHnez5K2/QibBbjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FKkQ0ltC reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKkA4r+M5xodbg21qaxJRj6A+PeKT890Bh3XhnMQmOFkO8oSFK9J59DM3ma3BiLrTnj/j0lrjuKHrPHXeJxn2B9rp2K10fBlSerhEauxKjliTTb2vuF1wlvGmdlOjKdm6AUiit+hD0ODvCACUEOFf/toyiGia8/dtoyGURJ+KeMuRoqIDPtblAfQ2RbOsSqn0hp78q3o4OMbA2fRvRAksJMEyPJ9JoSyU83Q7ksOtkM/b48qaV7zKlPROl5/XbgyYOqN5mfwatpQ1aUv7xa7P0ifffUUn383oXSMQ9uDfQp3aBST9LJZhH9OAnkjb7ujilziVUcThT3u1TrDjBNxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wof34fuUh42vfEghS5X83kk8tnwIXzzv0v7uxhlARIM=;
 b=DbUWUSC6ilAeq5lrvfnZ5QgzextF908BRWlYJQ+T0RYPUK6vlu05FuckBjYD8kyOqmbLZH0ii+ozVYXIS3l8oQYCSvHHFbCMa9uVlizcxThctZIKPSOmoZuwIl8M9uurpSj+fLGQNc8zygrD/ntW2qw91T490n6SFynjFxg3vjY5rF5t2tOwresPNea/+jXyvQf7XKhtEA66+mktUtZiH3Kqt8g84Nxg3qQljOeZX795+NbemjpDWYo/Wa95U3BULbuVeQcTkGZ/Gwg2HyfKz7CjBI7HIFl8B2+vxW9JhSqnLxvJxdflL60JXwoRLPzVQkX/h/EoERGORK/a8WmU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wof34fuUh42vfEghS5X83kk8tnwIXzzv0v7uxhlARIM=;
 b=FKkQ0ltCm9KhdJVgTga5UI/m6pvNG20ats6KEQjMXJ+AR1Bv/AkbCbtm/NXWwDBjlD4Kyj/0D2rblPeaOABNxRNo4xtbvVaM6IKwk5hgMI/nnKtADcqgKsmh8S3aUpEhVRQthFkc/H4I2Wa/FfV+7tBadMBvy5KJ0gpgSypc0/jOcrDzfezh08w0Bhpf3pB/R6MUtVCNgLF61FXJIRHMKZSmfndRPOfbEcGc2ZhGBZVG1kd0fdEg7+EaXSZLSedyLWJ/OHMPYUUVV9upbaup2CWECUlbvDEWUBrnYxpHC4BJDsfuZcgDirnbIlJQU1vGwXD1jdEfrAta5kWcixNoBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10798.eurprd04.prod.outlook.com (2603:10a6:150:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Wed, 11 Sep
 2024 15:25:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 15:25:04 +0000
Date: Wed, 11 Sep 2024 11:24:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: miquel.raynal@bootlin.com, 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn, conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: Fix use after free vulnerability in
 svc_i3c_master Driver Due to Race Condition
Message-ID: <ZuG2SbsHEU5BU9mX@lizhi-Precision-Tower-5810>
References: <20240911150135.839946-1-kxwang23@m.fudan.edu.cn>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911150135.839946-1-kxwang23@m.fudan.edu.cn>
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10798:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7985c2-02f7-4daa-7bc9-08dcd275e8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?FN3TeN3VIjHqQOPdGslHKBkktWuL1noqcvP/qI9R+a+/gnfDnCMX5+CjbC?=
 =?iso-8859-1?Q?N/5g7iF6nHuE73DTqrXIX4FWGOvn26fW80vOWs2ZHsxeNcp4BkR6D0/ksG?=
 =?iso-8859-1?Q?tGAR7vFubFI5AQNGUoZ97xpKHnC5P+rsANxaiUQrVrZWvTLanTHUVi1Xqn?=
 =?iso-8859-1?Q?9eWHkveGYzNPVqIChDCkhHy/X4/YOPwQF9JJL7GBHFhqupIcKVvA083atR?=
 =?iso-8859-1?Q?N5gpq2CRwQn0kCE4beSU7nadUeSXjWN3ylzB/9Axt7Qf8/9xJ3aR/2p7bH?=
 =?iso-8859-1?Q?lb54z18EEjpTLy11BEizHw1tjfyQTnO+C14JbRofGuEuIvCDIGh72sNbIf?=
 =?iso-8859-1?Q?wn2w9mIDIPRBC/cikBsPaCXqpAZhV2ZYLzwFsq/UXrJlcxheSR4bptUnoQ?=
 =?iso-8859-1?Q?SoYgJ0U3HQ9Ds/iLcEcy3J1EbhWwWg1qaIut85pf6fv9rvWkQI6bV9h0h8?=
 =?iso-8859-1?Q?hk8OFDr5nsrEUmw/YmrenCyOBWAs8t0K6pCcNyfnecRqNuI0lN0pJVPs/W?=
 =?iso-8859-1?Q?1Ua8eLWsYcZa9pKu0CLvVVoJ4uXEQVmJ+1MtTMMll2qgu4iV/Rgj12Tocu?=
 =?iso-8859-1?Q?wHTv3aLYOnahiIy3DflK1ojS/91c+kx3ieyYzo3MDTJbOB9L+r9iLsY7nX?=
 =?iso-8859-1?Q?Lhf0sPetD3F5WQ3ybywtkvFDO4/h/KlZS1bf+W7vguaC+Lbhi0AZEPxI/D?=
 =?iso-8859-1?Q?Y6qjR8AvncdQ7xLBqcKwNj21/OhyUdPY8tc2uJZTKatb/MHI4KCEo4YTiu?=
 =?iso-8859-1?Q?qrW2PR/Pygg7+okdoJ5I2+aJ/rsIGS9f/lztBUSTzrynH0aHLpqfbjeIZz?=
 =?iso-8859-1?Q?nPSC87BoBXnzoqX6VCN4hoODMQK9UolpYnwHhkIw78GoaRoNXX+Hq9iM49?=
 =?iso-8859-1?Q?rBkRFaKx14E1xtRc7UCSoYP5rIDMPIaqw2h23E0AUmlA6Uwocf9O7MW7Ol?=
 =?iso-8859-1?Q?B/VGLYNa36bDJyEjQ0TsuxGS7XIOwf8d+xrickpB5F6LWZvxEn+iwfzIzM?=
 =?iso-8859-1?Q?s1gDHCLdBmxsy3UeJBSvCva/ZlRZKZ6spBlVL9MilCsR7idtIuqceOVCYt?=
 =?iso-8859-1?Q?3mCNgm/2bJF/wS5ECtFv5nofx7m+uZfpavRk5MM4I1p020SVkPS/1DMQrO?=
 =?iso-8859-1?Q?DezihJ3Y6kEvizY8VJAaf/0TaTmdh66075d9mDeAsridK2omNKTTT9v/y1?=
 =?iso-8859-1?Q?OquxnfiFxfDVl5NOqSOeybagyyd0NiM3cx4KiW3IIUJoGanF89b9iqfYIe?=
 =?iso-8859-1?Q?vLWaO97BJT1jD3qumvK9HW1PFY71aCOf7QIwTghCb/rhFVlMDS772z8mXb?=
 =?iso-8859-1?Q?oj9jI2MHqAwO00dFb6xa2mO+/54xoo11KJSxzMK4vh7HDIYKtsPR34B9Dr?=
 =?iso-8859-1?Q?C4MBo8rKj3cdoPd1DBtrRk4W+V+QKojXnn5ffkjYVcv6AmnOB1qXmldAEN?=
 =?iso-8859-1?Q?hJGcuAmp4GgqM9CZn1E473VS+1tEqP4hWDQ10g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?mWXvHJ5dCXQVTrsac0dE2es+l5yIahdesiKm6ValGMVzNXlopn9TOmOs5y?=
 =?iso-8859-1?Q?cTNzYa7lX+sWqz1Ktqsn8eO6itXEWlaVty+MsywOZ+819f0nPA8OkWfCAC?=
 =?iso-8859-1?Q?l245ASiMNmgYuu9PC1JadScd+LQI8dcgvlOdj7KrDzpR431WxNsJsHQw1d?=
 =?iso-8859-1?Q?FhCA1HQHMjB0eaMkHIAin+kzQzytxV8kQqotrnSK40pq7KutgMQVtrZ/Aa?=
 =?iso-8859-1?Q?5x8GnR7BVhKwqf5mmDPoas0tS3XleB55kB1+hUFC9N8oRKvsy0BXXvWZ/g?=
 =?iso-8859-1?Q?Emw0T3VK8LBKmpf1Q6L4e/RO+xkCJ7RTd6KkFh6NugZ9pfGa5KwYYQM8xx?=
 =?iso-8859-1?Q?9qrOC/0z8Wc3iKIVO9hyrWjRe5WYBNrd7ofCFTp4i9vrANuebZEJRIThMN?=
 =?iso-8859-1?Q?yMw/VleKK3PszsPHXknFCeY28wOOoHVhOTGQJK0Eh37SrMLkstPZRkQIky?=
 =?iso-8859-1?Q?Qk3/iU0kVNs+t0zpAu6RhGu9xIsLjt0lR6xnpPIQlYHVZtyw0HOt4US6eD?=
 =?iso-8859-1?Q?d6F26bGjyW7wW9wx/Mw6Sio5rYmXw5N7wQxnYavAwtDO6PQdWnA2nn0tGR?=
 =?iso-8859-1?Q?IByfo2JpxsFVTDUzNuVV5c5O37f6zT3RdwPQosNwyuBbaHQ/WpPgKN6FWY?=
 =?iso-8859-1?Q?VQHIQfO/oGQovmsH9rnP8MSjXCtIbpL8wLx4Ssx+lezRt2kyZiepoQkatC?=
 =?iso-8859-1?Q?gksVHVkb/BgTO/6rHo3CDUWTBcPn4tlp7JHBPEW+vieZBjH8bVMh57p0Tn?=
 =?iso-8859-1?Q?WVniZMqvV6DzRH6AjZl3mQOlH6lKM7K70d7sgw+5W/3iDjiQj7CsqSfoQC?=
 =?iso-8859-1?Q?pgFGr/vMjlV9M7Bewdw7hBaJ2OweJqLlgoW979f0IX33QL7fxEMOMcaU0+?=
 =?iso-8859-1?Q?C7IzQII7PPZjcfFJclCNZ2w5FC3c1tiZT83pYg3eMlchRnShNdf1rR932m?=
 =?iso-8859-1?Q?0GCw4eplx3TJdX8k9c27hukwr/2GHEUXmEFAD7J8VPqbVXDbsnQKhrQSD+?=
 =?iso-8859-1?Q?rFaJe5F03MfyRnj0yd7eVjW6FTD2MRBcR6MI96rDAXkbHf2lYAMSxksgg6?=
 =?iso-8859-1?Q?TgT9I7OMmVeNnaQ7ijCX2NzDXGf/d/rX3sC5Q3lzIOkVA/EP1k5Y4opxKd?=
 =?iso-8859-1?Q?6Rg9A0mosiOStKY5/B3RZvGVRmwTUGs5fh2xeqyL5uGFTijvnzNcHjzstE?=
 =?iso-8859-1?Q?aKinKQTefN81wDyTcn4399w9+3QmjkF91bVUCQiv75c04ddNXIUph3lCGl?=
 =?iso-8859-1?Q?K5JaX1/ZzxTe9sBdzKL9DIRHUSrCsohsnQHbjK0bk3GQUmRcEnmfvhA84O?=
 =?iso-8859-1?Q?mSwWa3f4MDBxW6xcq+ydcGsqoAc6nrMCdgc5blt9o8+aQqAL5/6+OCgvqa?=
 =?iso-8859-1?Q?WHcn9PdNUhtbzf/obsCpKr6aGd7AdwuYHzwWLw9XeKAzQH8zl1ogVj7JEV?=
 =?iso-8859-1?Q?+WIHK3VLBlr0zYU4f2oNb4SudEzQmu3mMQoECER/N07/+SLQiJLfnltQsy?=
 =?iso-8859-1?Q?iZB2Y/v03hyAywtBkV8LyHLtkEU2mdjhKpcHpo17KXMhA0QsJjFb34R5f0?=
 =?iso-8859-1?Q?mDCclEZcu7poSqTQuCVL1HjYqjZsXLWHfyoGSsr/hL8bGC+1qyDA0rIKxn?=
 =?iso-8859-1?Q?4d3I8riHbZUu8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7985c2-02f7-4daa-7bc9-08dcd275e8d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:25:03.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzmBzCOaXZ/g0lgIP23+9XKaaFsHdGm+6Rgk3OCzCxqjenQdtGYl+lIV/Nl3sLZqinDRI7FLPmyo8BxG9UJQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10798

On Wed, Sep 11, 2024 at 11:01:35PM +0800, Kaixin Wang wrote:
> In the svc_i3c_master_probe function, &master->hj_work is bound with
> svc_i3c_master_hj_work, &master->ibi_work is bound with
> svc_i3c_master_ibi_work. And svc_i3c_master_ibi_work  can start the
> hj_work, svc_i3c_master_irq_handler can start the ibi_work.
>
> If we remove the module which will call svc_i3c_master_remove to
> make cleanup, it will free master->base through i3c_master_unregister
> while the work mentioned above will be used. The sequence of operations
> that may lead to a UAF bug is as follows:
>
> CPU0                                         CPU1
>
>                                     | svc_i3c_master_hj_work
> svc_i3c_master_remove               |
> i3c_master_unregister(&master->base)|
> device_unregister(&master->dev)     |
> device_release                      |
> //free master->base                 |
>                                     | i3c_master_do_daa(&master->base)
>                                     | //use master->base
>
> Fix it by ensuring that the work is canceled before proceeding with the
> cleanup in svc_i3c_master_remove.
>
> Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
> ---

Please add fixes tag and cc stable.

Frank


>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 0a68fd1b81d4..e084ba648b4a 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1775,6 +1775,7 @@ static void svc_i3c_master_remove(struct platform_device *pdev)
>  {
>  	struct svc_i3c_master *master = platform_get_drvdata(pdev);
>
> +	cancel_work_sync(&master->hj_work);
>  	i3c_master_unregister(&master->base);
>
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> --
> 2.25.1
>

