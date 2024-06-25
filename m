Return-Path: <linux-kernel+bounces-228271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDDB915D84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0AF2838F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D25913C672;
	Tue, 25 Jun 2024 03:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LB+uHG0c"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2067.outbound.protection.outlook.com [40.107.113.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27B13A89C;
	Tue, 25 Jun 2024 03:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719287754; cv=fail; b=hlOkBL/KNQi3nXHBNxgHKXq6fRtODI7tE3Z4iAJqDANhlEnAusoLC8XdhylH+o2EtQBmaxeesdYwisFZvL5UC8cni9ou8+vxxcz5ATp8TnPCTAtvRhiLbBgJa4Cv1oQS/MEirXZT/1o/AYBgwu4Glym1fHmlbtnuDmgeKs+B+Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719287754; c=relaxed/simple;
	bh=10IWYxxT0C76Hu2fzE+TTvgcvMRgV2N07xpEp09iwxQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hlGH7GvIOedWbMHKN+c/R/otDrw/BKmwlaBPWln02M3/zqgA7WOJ8mXfNBlFTCj5FTvb5sjKDbzoreIxLbhev0IsscaxIn4T/fip2C9LbqLlLRnmC46ldabls/seEDChmKCt5w41GVMCZgbqKquCptIdlef/zp/kfqxjZdaPoM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LB+uHG0c; arc=fail smtp.client-ip=40.107.113.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POfz7y7Dhik+rhuc/RWp3xPIgqAxyoyjV6v/akSqXAgUNXDRwCEqlq1w2a7SyQeQWRAjG+77847jyg+l4Qw0xw+A+U3wrLOd9Jk0awNwlr3bpPUw0g2u+kPa9vlTWVT/RYbRAiSP7BOZssXQBw7oooOJrToM7PrC2y9cZyzN0SF0xaU1185ND5COktkHGtYqMWuVIeDaVBxL5++hEmYOh2wfn/YH04pPMXqXqdSpumfXnubRnSew6cymFrbsJXE/NrgsifY2A+Gm8BQoxoaoQ7O4v7BvhCdTlSMxW2hJ++YOvBBkhp7/9mpnwNbw7nwAhygOlW5nfmeS63MQkgJTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKmULAhXtqVL6XzYT5ciHw3zud/ibIhTlsHlXZvzQ8U=;
 b=SR6K4hx5gAfcW5Px0b3qMkG6Q0RSFhgdy8M7l9h3J0VBx06/Porj5mo3gC+7RR9B/+rKaA/1IJwz+ftIZiAOXmJr+ZpBe/XETChERtJMuaajbqWolST3CrhxYc2b2pQn3IYC8tegq5eqixKBb8Iir9/t0woB+Tk4h1XwstNlwVrDNQ92U2XEXIi/HszrezryXmbrim3u+5S9izPANdit4CM3M2i0zu7TcNECl0IjV5brnjDx7Y/2Du8SQC+W3w52xMXHHb4yBFA1H6e4xKDH4xru4J+wKtF7XwznUikWElr7eeBQ1672s2YD4VUaax4yX/ihRS/blTxIHOrRaFICqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKmULAhXtqVL6XzYT5ciHw3zud/ibIhTlsHlXZvzQ8U=;
 b=LB+uHG0c+v3FA2ymys8/V4O4pZ8uMx6s30DIolIrGgtkDRaKKZWbcu7kkheRhXCDh1Bfn+2g4RB50twpAPjOIdIEdvCQx+vte6V0Elyqo2MdwXHoznlTXK/mx8ySmxboPGQwiB42fSI3ZSHXXsvxUCpZ82TOrxAhUROBqmX9Q1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS7PR01MB11602.jpnprd01.prod.outlook.com
 (2603:1096:604:246::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 03:55:48 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 03:55:48 +0000
Message-ID: <87pls5k75o.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entries after adding vendor prefix in sound dtbs
In-Reply-To: <20240625033419.149775-1-lukas.bulwahn@redhat.com>
References: <20240625033419.149775-1-lukas.bulwahn@redhat.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 25 Jun 2024 03:55:48 +0000
X-ClientProxiedBy: TYAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:15::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS7PR01MB11602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a08e7a8-8be3-4947-b978-08dc94cab2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|1800799021|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7sX8K9WHOILaClVlhHfeuC+Ls2x3+8Puv7h5+F/0212xO8xbOmoAfe49hjEX?=
 =?us-ascii?Q?suirsj8CnY535yDK0PozYJdsLMzvOfiFj52//OvBGjXkb6FEB3Y/0bPfTJHC?=
 =?us-ascii?Q?86jyb9lXTqcPS3/Oe2AZtjB/L0riaV6KYQChALZEIq+lDxDwPG+JfPkG3ae6?=
 =?us-ascii?Q?+Db2/jT28RXeLiuB86Zu8UWTlQtmA2vBLyx7joprwtr9iNcBXXHB1PiCTpSE?=
 =?us-ascii?Q?AjBV8wRFgy8fyvi4el9bWjg7JOF/IQulgrNgpoZspTnZaPN3gpx/1ZZfuCsp?=
 =?us-ascii?Q?xuaBQhWsesacTK8kt9gQTRqGKN9Iqd1R5eX1IS/vRuvoHn9nf3Db+RiFw2+r?=
 =?us-ascii?Q?qZPLICPHtBNTH7ymTW6IZYsHkDWLMQEMT4a1nacqH9+8oBZi9zn2iuzf11Vz?=
 =?us-ascii?Q?kVbc6lk9iG7CUQGrx1maUtekvaBBF7R6fZEXJRKEnzjcMPDBQRPTKxAuoJUe?=
 =?us-ascii?Q?K9do5ZAyTlOsn3ucw03W0tETxf5fJT9IfDN9w9QyPy1Hwy7wWtozgY8Q4Usi?=
 =?us-ascii?Q?pr9rn1ImL4ydzGS10oAeyIT5Ytm3O30DDmn9pKaBznuFoWv5NYe3+K7tWF4b?=
 =?us-ascii?Q?INwjaCYQkFss/BeanwFZZYC7poLkz6xToG7qEld8HKTChX8xkvqLAYSmaK/O?=
 =?us-ascii?Q?3gs/cM2LQt/SvsnUQEVLQyYjgVtF3idDjMKehXRS/4HdG8w++yd1fKBKzB67?=
 =?us-ascii?Q?iJTHMb3YF85Uvhcw873I3ALTqlvsXLrW8ZhNZaQylrCrx8XgTFD9mRL9nyHL?=
 =?us-ascii?Q?iXo05BPhlx906HFxKZee6YqsiVusyfO3dfPJNihywgIzbR+lIMa2gmxefXPE?=
 =?us-ascii?Q?2ROeOVxTZQ6Zqj/9zfAadAimI2G1qq7FazJge0uQC0txw9JVOOlJKjW7FVxm?=
 =?us-ascii?Q?CKPhTlPRHYKfMvRV/cV6fx8TVp94EzfK5JQw6nILSLFh6S0CpVROzgGlp37P?=
 =?us-ascii?Q?n3LOXgJTE+mw8BTH4jRjDbj3JBllhq3vnC8hJddgSMt+l5/y7iLYHE2tAYGW?=
 =?us-ascii?Q?CVzo3hjeCAuCIFN2pgJaYeeuPmzeSdKdBCAVioRcpodK2qT5DpuzTy1/vX7O?=
 =?us-ascii?Q?pf1C89SlIdSkVHz4OFkxN+2rUaUMkvPqAakE4Co6+Rr188ca6BtcE2LTT9PV?=
 =?us-ascii?Q?/p+bvCirjtxIoERfK+6+KyGSoSUFAjzYEWa+lOb1FVCMKiyppe97TF7nZBOb?=
 =?us-ascii?Q?DbN9tdFaIF1YmVJ3LEKdb3kET3Jor6NYva3nRR/dMDAk8xPjLqParMU6/0KU?=
 =?us-ascii?Q?+7EE+DylgS/EZiIOr4XFLUO/c3WPjIUf1F63RDTh1ZRdB+JdiFh+DlxIf3Ky?=
 =?us-ascii?Q?VeYH6LcpopWvle5HhglxO2lCq9JDRB//7D3n/QlrWmbk42g9+A+hxz4UIHSV?=
 =?us-ascii?Q?D+hIOXE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ry4PzerITTklRQpRxDP8k7BNxMYgi9vGh6bBngLMhSKymbPsFuCuz3qPqGhd?=
 =?us-ascii?Q?fsN2hyVrTu9+WfV9QLGzQnQZjlnMOr2SHChxZ2O5crZIldxKAAmY/PCsxnOR?=
 =?us-ascii?Q?LoOhh95EJaNNkDx8q95NIwd0I5HdR4T6y3pkb8s8gXW5gwtYwl7weRMmcP7t?=
 =?us-ascii?Q?oS+IHpWsY7pT7uENFI/akcPNU3UirLkWxtP+3+VKeEV28TiFQRRO7lEIB7wp?=
 =?us-ascii?Q?xZE98kQtAQu+ybgXNcxaeolDu5/ZpGExG47yrofjw1B3W5gfj4cMFF7KGuVi?=
 =?us-ascii?Q?e4jvwNo7hLFv98kXzzXVksysQSHpGEP5GVYjN2a4y2OB+WJzayZZ2WL62vOI?=
 =?us-ascii?Q?CJree6Vh6tT0H1LDhOwxrtUAjfip6EQjT8nUz2ThhFmcCumGYRb1HTFJ8fRm?=
 =?us-ascii?Q?bBhmullQood3/qrw/EiOeBuSE4+EAfsCHEQhdVHDivGcw3thGfPxJrzAP698?=
 =?us-ascii?Q?efjSzmie2z7+n/kXEK6bMSgb8bCoC3URpuLXfHwS/ugTOVzohkOiHLg/YtQR?=
 =?us-ascii?Q?Cd0+6zl9WTTfYdTJ5YTLnEhT3q8aW2hJpMcfJ2nwiTujFXePiXdLJ9zirq61?=
 =?us-ascii?Q?MwacVRl7d7/VNZGARR2c1SjS2+hN1+LSlqZKHLk11T4DZum0S+NSaGXYZHvH?=
 =?us-ascii?Q?6vo/UicBTeBHe1BgnvqOCpw4uPWilQfH0w70NHpE/Sn0ISrJ0Qk7Sn+U0tnF?=
 =?us-ascii?Q?s1hUPBH2Ba0D6wbNbzP7P+xMGa9fqFGdOR/kiJCO1/FoKkeMe39ugn2ymEwD?=
 =?us-ascii?Q?7O8BgmE1Na3y6IONlRbWXiJoSowwgHBgl9bKqRYg7uWs8c5fjEZo9ARPF4cv?=
 =?us-ascii?Q?7Wqp97itCPlYHqj/dYvZp5kXVWsS+rlFkCKRhbak542UXnf/Yl3cHw6tB46Y?=
 =?us-ascii?Q?6Y2O0zVJma2WYJdpK0o9THsPNRtn/x8SqZ/5i/XA7ifB7v6bUTDdAMqO0bvc?=
 =?us-ascii?Q?2xWS8bNUrPfGDVn5dbXjhAmgPW3D/G70I45dxQe+0CvAIFZ1GnZ6IZliZ0jo?=
 =?us-ascii?Q?gRECv6Gx/xNH64os80Zx4E1cSc2elxIdiOSTh4WmSTaAXuD60saWI7BSpSgi?=
 =?us-ascii?Q?NZQpCcaMGdlcgR9ZPzjwTOcpf+sMZFrOxJM3wrhiBYFNtX/vT0vGLdfLyQyZ?=
 =?us-ascii?Q?pSaCt81Et95sqEvblUQUEj+M4+Y3qs2z+IIv6XIf0HuL011PfshxyK3BttLP?=
 =?us-ascii?Q?gE+dPcnyhlIKFcy63qlyVE7z4RXI0eHeGy8AmoUgU+Gohdxn2DUs/XBbbG9P?=
 =?us-ascii?Q?Dp9F4aw1G2iL5se1zV4824R4mlXOFR2WLjYxjvHqw+2L+x9gTEz3DUSppVI7?=
 =?us-ascii?Q?RlJE5sqAi7bmyKWSagoFUKbwN1R6ksJx95ofM/Qxpw0K9boqjN4g9MrNsYGf?=
 =?us-ascii?Q?vIMteNm9O8YyiLqcH9JwtByeH4PQ+ViEkxK7O8AFqPsuYKEnT+mYTchYosK9?=
 =?us-ascii?Q?s4NIbZS4YAC5tFI8ES0FiWrLBq606RMVcG1KKTHbWWUJH5XLRNnJLwiWYv9r?=
 =?us-ascii?Q?PRHXTJYjomMVxr9/wTr+YZUKLmLSwiu2o1euhZSAv7PBOpdTzQlmHrz8nTPe?=
 =?us-ascii?Q?li7yTnOvqM7UBLzKeHlSbCf1ToD4uKS0vGMe4X5lEWJwFvxCAJw6p8wPbmeF?=
 =?us-ascii?Q?7nEo75312QhHYgshhI3Jd4M=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a08e7a8-8be3-4947-b978-08dc94cab2a5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 03:55:48.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCJ8iXJgcueyb6XLUIfZBJwOZvPJ4w6lGC8+cihUCOcZTN5atku4SHQLHvK+T/0BWC7ttgOobjh7KyP0WMirKcytj1hQTRpzmlwc8QK4ToLa/P7W1+ieH0CXczeavS2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11602


Hi Lukas

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit ae8fc2948b48 ("ASoC: dt-bindings: add missing vender prefix on
> filename") renames a few files in Documentation/devicetree/bindings/sound/,
> but misses to adjust the file entries pointing to those files in
> MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
> 
> Adjust the file entries in NXP SGTL5000 DRIVER and TEXAS INSTRUMENTS AUDIO
> (ASoC/HDA) DRIVERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---

Yes, indeed. Thank you for the fixup

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Thank you for your help !!

Best regards
---
Kuninori Morimoto

