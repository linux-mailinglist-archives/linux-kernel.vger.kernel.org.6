Return-Path: <linux-kernel+bounces-536899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C2A485B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517671889A41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E111CAA6A;
	Thu, 27 Feb 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J0QpI1Dw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000711B0403;
	Thu, 27 Feb 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674750; cv=fail; b=jiTw/19qPGaCS+Agv9QfeVXzqynoYcPwhmLbYeHAR+SN8kl0fPohu80UxTispwtHdPLISpaiVW1R5rP/BOkx5tQhTBkA/ojj50BSWAH9eU/eO49x0kApwl7y57sWJn5qKYfJk9l18H91K3D8s/Hsod/znvv4ceyjT2Ahju/MzSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674750; c=relaxed/simple;
	bh=AmYbZ3xS+RT0CsKMo05QIrTRFNlfadr/7e5KeXZrguU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fQkD1jhAPBhQr9LWxoyy/HuERB80wI22sEzvBgDGtXppK87XndaYGnjXPWZSu50L6YH3uD6mcv5kITz4wL6Azxg463MtYz1e3tGaebF2w7O1dXcPnzrH1wXjUvwMQgQyJeUNIEWxEaq5C7Zvvp8eApY/55N9VxiMX4LOFiZxzL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J0QpI1Dw reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBfNnUR8iLJiWaqj3ktwO3bIbbGtebQiAc7m5KpK1/ZT6jNxyALWlzHums5guwAXAMPFufCvbR7yjsryDkg9EM/cXGX8JovjuoG7rnPMq1m0n6cKKxx+VFE3f65lTYlfq7mgeDUNRkCnt3Zviw2EIkkt1zRh4mARFfgFU85/8KxtC3gRtiYqyDj6IHj9Qsco0K5QJ0aGxwubs+MAcxJyfrbHLiKBYkfqvVDzd+zlEBRR85/72XSnkKJzoRPhF3ul/Nmk/RxFbNkcouqbCCdC7jYrq9uje3AojlFLQmqIeKlzrnPc7c7MYysFE2t1PHGqhg18q+jIyAgQ9FuHhTAtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bU5LG1awZ2t6P33t73KPoncFUJCkh/aWTqFXBsDv1c=;
 b=Wv3tJ7cK4IXEjiKr0hQCvfMeAH6zIhRpMf9DQsQiAZMLwDtzxLkqPEwyWGL4VEJQdQzayIiNGF/+ReLMb/gKrDrvN/Arru4nCq7dQ68hVMJP2tWdaWmiD/LAdhLdwXDAQ+iw7vvl3C81Q1C5dA+v/qLT7LfFD6yNRRCebGDHrEeBc+oKrIQrMroqQ1r9WQmqCSuj7j4HFS+KzJPBIJs8YGk34tMlQYkwzHy+Mmf3PpcNg2sHZeo9ug1DF1tnf6QLHsY25Sros5yTAq2Gp/uVX/krH09Me8Poc9ltId4W0Kcp2/zs6iSorq+AADpvgCTHYzLw2V5Kl8fpPey3Sv70Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bU5LG1awZ2t6P33t73KPoncFUJCkh/aWTqFXBsDv1c=;
 b=J0QpI1DwZghQxyCW8u6XEm1jYI2MT8IxL0I3CpXx6u7OJOFjfWFfFUzTCbB34+Y4bqopFwepNXe3BtrlldNWMHWdjieth/oqwnv5ltdQkZssPZxuoPMB37V3KOUda/nQXO5JX4spku08VDww5L06bHlPCwneKGOLG7C1vLY93c8zFW60vP64zf+0x6sa1xDQ0WvbEXq5NN8n8jglRdGekz0HlNhRaoCJGUbbM0WJE6G1LGq2PtjfLN0UgsunGGyL8hBFeWhzrAXUkn/MpTknYdJjirivFgOuHhB4AZJQS7pLaeCmq7RbX+Ljzx+C4G6P+nYfTePMAtQ6uCgwQPN3nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:45:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 16:45:44 +0000
Date: Thu, 27 Feb 2025 11:45:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Message-ID: <Z8CWsI/DKZtDBkzE@lizhi-Precision-Tower-5810>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-5-laurentiumihalcea111@gmail.com>
 <Z7jahtO3bxjkMfnc@lizhi-Precision-Tower-5810>
 <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
 <20250227-monumental-whale-of-security-b1c84e-mkl@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227-monumental-whale-of-security-b1c84e-mkl@pengutronix.de>
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: b7706c86-b96c-4153-fa9d-08dd574e2dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?x3khY5PB9fui2UJ14kZdQs+IuDcEYtgV/vOl/StXAxuk/1QRsLFTm3MXlH?=
 =?iso-8859-1?Q?4rS4ff/0+oKFlzq/m1+wxp76+1I8Y1HFHXIQwNxwjFrWMWV2hKRRnn2V0x?=
 =?iso-8859-1?Q?QKHe3f4kAyf2toOaKl+ktqDIy9A/ss8SxPtl1UTfGpHe9h6Q+VqhCFKi+U?=
 =?iso-8859-1?Q?SMgL9ziskAz29V4JiVYyOZQDQgsP8wGKPD4o+/9chy1wYdvaEXphVh5x6d?=
 =?iso-8859-1?Q?tUnorGje4mMoAQwuuDjX2hhdqsLJeo4TFPLmiMQRUDIG/3PgRw2eEAg1dN?=
 =?iso-8859-1?Q?Tjq83Gv3PAoif8x29QkMJ9pLrqml+f8jojShbFXHipigosBbfCcCzRgj4Z?=
 =?iso-8859-1?Q?UAl2kJUpFNbyULhCI1gxfoNWEmEXckKquAtJEZahaZb7dD67HBAzO4u9LV?=
 =?iso-8859-1?Q?Nxz/RfbpFsrGlBZS5hYgjq+kWkH+xIgSGO2AeXJtQmzgdDhaXUvtD58pGD?=
 =?iso-8859-1?Q?qA5L5pv4pqGro4FyTQB26xNyW5S121wlqk0YBQtLutvMm59EXCPyYxM54T?=
 =?iso-8859-1?Q?i0U1aiS8nNHJrQKP1g7A2h7tHVnA1FsAkloEmu4mrvqyNPtInJqgsXHbIl?=
 =?iso-8859-1?Q?doTb7ZHBOv7DXi621g837aMRCjVBpZhmYlPM4RSjj73ggxQM//XxpkaZxG?=
 =?iso-8859-1?Q?VFIzQK/CXyoMnf23dWQ2ksUANRN9FOR/88F9YKdFUxt03OnMCJaURq+3+3?=
 =?iso-8859-1?Q?TXf7pqPajNQ97OCGgmh6luFBZnOUm4h86hHNIS27yB17LLvcCC/GLvr4mr?=
 =?iso-8859-1?Q?VLx0GdJ5IKCavIFGksXNndjSvWDCbfT7qpBIJNdu2yUN1Hy1QkJQ1nu9vQ?=
 =?iso-8859-1?Q?u1C9piXw1NVn/7v05ZccI36w0l0o1FWr81qEB4Daoro8wSMb3JQsz4607G?=
 =?iso-8859-1?Q?3vwaE03UkdWUktm3QBBQ5PZFJmb52dweG3+UhIEKnPFLzJ++/DWG6vmn0v?=
 =?iso-8859-1?Q?7k6hrqtHkXTnh/8Po5cjZ1+ekPO3GiMJx7O5j+14wxHt9tjiA1NVW2ikLx?=
 =?iso-8859-1?Q?imaCYjd7ut0+/VprIUT1RdSLJv9KGKadd9mODXsL4m+w+bbXtQxjmlnvC6?=
 =?iso-8859-1?Q?vAW0RU8h0fz99y9VdHOslgGtP4FhP9SFO38klwUHfBUxsVdNLxsT80VLUj?=
 =?iso-8859-1?Q?AE1Xdv2ioPtyim4PQ9pkMEscDp17cs6uWVLhsG0xKk3rl2GFBLzBBtORL4?=
 =?iso-8859-1?Q?I3Xzus3ltNA3f4maNWPBN4RTe5+mOs7IgauGN2UbnxvGzBU/034OLNs/VG?=
 =?iso-8859-1?Q?SIpYYpI2kySUDRdTr33sdYEWrW8LsBsgb/l8e/gUgJoZQZvJPKxjVS0suJ?=
 =?iso-8859-1?Q?6HM838sM4b/5j+Zd7bHy+DLTIwk+Cr0jvoRsQOR+mC7X1i0JrqAalrXxXs?=
 =?iso-8859-1?Q?wTXe5V1FbKuXyLTdMM+0J/No0o46cTXjzn8d46kPgRstcN5R10q0hyUVfH?=
 =?iso-8859-1?Q?YNupu/Qw8sfw7Oro?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?b2SBroQVhnUaqvPEMLkk5m82W93GiLGNIMs3bUpmSAYTcyjwD3exsmMhjO?=
 =?iso-8859-1?Q?3PmbQ3e1EUA+d2/HGaMJ9DV99fQhi0tuTwantztGFy9o9TiKnzUKSzifzH?=
 =?iso-8859-1?Q?J3DFPQjSh3TGleYMT72ulLTXcP7hrkUyjPP/kH9uvKjlDxZd2o/8DBqHxt?=
 =?iso-8859-1?Q?G79S9ZTV1qQV1X8EB5UsnNvoO0irEqm47ODeU/3LbEt+kQ/8wXBZpurb23?=
 =?iso-8859-1?Q?MD30S+7eOlvWI4K9k6E3AVD6j97OycrXHHSXQRD0G0qlbbQ0DrhFUVBpGe?=
 =?iso-8859-1?Q?6Bl/1gXr6wo9uP9Zp2b2gUgHrfOUyIk0B6TO9fZP7tn0UqEVN3uNAgL4AH?=
 =?iso-8859-1?Q?QwwxO6JN/nPMruIY+Z8MaZRORPEI/1Wdo6lxHPzspHarH84UbSPeRivmLq?=
 =?iso-8859-1?Q?JPnQNllvGm38U/O2z3vUx59y6noIdp78nMYJpJMbR7rJnD/o3znnhibFv1?=
 =?iso-8859-1?Q?desofF6Myy9ASsSOvXDdqgS69Ze8YgXIhHJilUj6P5jRleAqjS6UbO2jWl?=
 =?iso-8859-1?Q?3/aWSzperRajto8F/XK82vGBp9DDXoAAU/iWEbGQsI7cLUGmxvFQlVpoYR?=
 =?iso-8859-1?Q?hFLDlq/3MRCS0OjTU/VggEfkfUA0ZXdRZCs5IWDpy/mnmhaniXHOkZ29Gg?=
 =?iso-8859-1?Q?Vqb9Dwm6XEpqb1+W8d3+U7Cy4klLJ4gR5wiUFuntE2pLOXXzkkw0vosLZU?=
 =?iso-8859-1?Q?6bZpvRci3rBZ8k46F+OsZImyXOoshKJfe5q5A0+I4EuxIZrtl7Zhx/m4ww?=
 =?iso-8859-1?Q?3ppklf9fdhx+1LaFqKWtmDOD6Y0HBkjbc6sQ1TfKOCwGBUVckMfv/nJJGl?=
 =?iso-8859-1?Q?rYgbXSjQR0n3iMLqHKMVYrojeC4KY+FWJrLFzOQNVw4XYQYzyn12spzkQW?=
 =?iso-8859-1?Q?x1lKpbeYN6o0XXATwV6UaEeqCsxY1/noSn39wFG/qwIbVhWLNh/Hk4XXOY?=
 =?iso-8859-1?Q?VTfdR2SJzkh1jGiiMHD9LbUSyMm5KavBS2DCQh11sUU08P51XgxdpXLEMx?=
 =?iso-8859-1?Q?XiRJaYucyH9OjxjVTqtIjvfqjcELMK4oJqBWzk7S6sxlitp1tF5EHkLk1V?=
 =?iso-8859-1?Q?pAtOZr/XBHqPe/xVYw1ipzuwMCfg6VbWeDsZIaYzr5606i06HQtd9A9zLb?=
 =?iso-8859-1?Q?BRaErP6wKxfyh3OvMwA3gpbCh/MRI+mzP5+eq+L7yU+vqyH8MJ41xVEHwe?=
 =?iso-8859-1?Q?9bZ0nbjPwbbJ0OpnRCaeGML1YtA5uf37+K/JmsuiiBbrInt/7l2GgaVsNZ?=
 =?iso-8859-1?Q?MVouSLLfHl4CnnE1CxtKJcITIKoGD4nD3LspmJbkInVzXN4j46a9mIxmAK?=
 =?iso-8859-1?Q?GdDH07URpAhWk6CCiZ6n2OCufE7hUW5MVmyN820RsrqAr/egaNrKn4fgZR?=
 =?iso-8859-1?Q?Vbt649XquMMScdtcdg4ukh0Wk5Bol7dEmyEYcV3EoruGdyHiDmrR0fUPw7?=
 =?iso-8859-1?Q?xNcu3GY7itRTxlznMDoHs5YmZVuc1InpPD+rkdgvXPINeQL8Wx2beBfWfW?=
 =?iso-8859-1?Q?3RTu5oOEQ2as1PkNX5uZMRyf1B/fC+OA87QIkPqZjdNtt47oXZk12otO4a?=
 =?iso-8859-1?Q?wWg/x/JeETtBuJUjuYu9vRVavcfiIzltq/GlZZTGRmAzZF1e0rxS2dfjBH?=
 =?iso-8859-1?Q?bQPgM54H96IbI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7706c86-b96c-4153-fa9d-08dd574e2dd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:45:44.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mto6TW+1RTVN1Zv9ImnNd7yuo1yvtDxv5mN7Kke9hFcy4XqVd8yyIx2uZ5rPApXD04Rl02cTG2/5zU0Uq/b39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423

On Thu, Feb 27, 2025 at 11:57:54AM +0100, Marc Kleine-Budde wrote:
> On 25.02.2025 16:14:34, Mihalcea Laurentiu wrote:
> >
> > On 21.02.2025 21:56, Frank Li wrote:
> > > On Fri, Feb 21, 2025 at 02:19:08PM -0500, Laurentiu Mihalcea wrote:
> > >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > >>
> > >> AIPS5 is actually AIPSTZ5 as it offers some security-related
> > >> configurations. Since these configurations need to be applied before
> > >> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
> > >> be their parent instead of keeping AIPS5 and adding a child node for
> > >> AIPSTZ5. Also, because of the security configurations, the address space
> > >> of the bus has to be changed to that of the configuration registers.
> > > The orginal 0x30c0_0000..0x31200000 include 0x30df0000, why not map only
> > > config address part in your drivers.
> > >
> > > Frank
> >
> >
> > Any concerns/anything wrong with current approach?
> >
> >
> > I find it a bit awkward to have the whole bus address space
> > in the DT given that we're only interested in using the access
> > controller register space.
> >
> >
> > I'm fine with the approach you suggested but I don't see a
> > reason for using it?
>
> Looking at the "AIPS5 Memory Map" (page 34/35 in i.MX 8M Plus
> Applications Processor Reference Manual, Rev. 3, 08/2024), the
> AIPS5_Configuration is part of the AIPS5 bus. IMHO the bus is something
> different than the bus configuration. Why not model it as part of the
> bus?
>
> > >> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > >> index e0d3b8cba221..a1d9b834d2da 100644
> > >> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > >> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > >> @@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
> > >>  			};
> > >>  		};
> > >>
> > >> -		aips5: bus@30c00000 {
> > >> -			compatible = "fsl,aips-bus", "simple-bus";
> > >> -			reg = <0x30c00000 0x400000>;
> > >> +		aips5: bus@30df0000 {
>                        ^^^^^^^^^^^^
> > >> +			compatible = "fsl,imx8mp-aipstz", "simple-bus";
> > >> +			reg = <0x30df0000 0x10000>;
> > >> +			power-domains = <&pgc_audio>;
> > >>  			#address-cells = <1>;
> > >>  			#size-cells = <1>;
> > >> +			#access-controller-cells = <0>;
> > >>  			ranges;
> > >>
> > >>  			spba-bus@30c00000 {
>                         ^^^^^^^^^^^^^^^^^
>
> This looks very strange: The aips5 bus starts at 0x30df0000 and has a
> child bus starting at 0x30c00000?

@30df0000 should match controller reg's address.

subnode address 0x30c00000,  should be descript in "ranges", which 1:1 map.

So it should be reasonable. another example:
i2c@1000 {

	device@1c <- which use difference address space.
}

The similar case also happen at pcie.

Frank

>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



