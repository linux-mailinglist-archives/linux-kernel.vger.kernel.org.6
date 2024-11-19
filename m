Return-Path: <linux-kernel+bounces-414484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F39D28DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B600B2C2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1731CF5DA;
	Tue, 19 Nov 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NZ2TpZcX"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4D1CF2AD;
	Tue, 19 Nov 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028424; cv=fail; b=R4wzXir3ejbq6t0w1zmFEQUCEPFD2Lq3dNZatbPEBzxYUODQKQl7drCwT0fEgZRGC3xj0yolzYNozMu+fbRzIpYIrUwtuSTbEa86P6bCG0Symlda0fBXFhL+LM1dOx13V5HNyebbMcG/lrGpZX60mIxFqhTBq1XBhCG6iyw8QVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028424; c=relaxed/simple;
	bh=6gFoRaDvLtXvWwFF0ELbm3KTY7JnvsazHk+pMKM1Ws8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Enc21ju7CERlrSviRZ2ie7pmCQxLOegKKvOJ+SllZd08OE1Lr571SbQ/zQbFxmdjaghiwcGs4otcVK6yvhf9ZEY9AoG4S55wv2GXf15ZsrNMcV0XyMeT2TMdr0dkNoLNsxi/Dbggeytj0514HyMs1cxsaf7mI1aUj7A0Wgp1kG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NZ2TpZcX; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aontxy5sPSgg1UBjyhGbhmjVRzBbyqn0B8oU22gX/Jh4MlLvMXZj/XXVNbSQCLmsnJOtj+4Th+QckwSPWNrPB+ZiSuJa7g+4+WPRh6zCT3sWVk+uGg/y+pGvJZyH5Mmzwfk48FemXK5qMI7Qdg3ww6AXhfrnyb03owKPA2kuoNhtDofwBvhLSkemZxCMBS4SgXrSXs3dQLMap1s1a81TG/VECu/8nrq8uLZgm2p9zvVvyDTLPhqXuVeC86OPvGxeH4taxNhkn4gD3I6aAIh/qpxDSvUePug6Qhn1JNzMY8N0CP46piVY3Y7b98pRsXNAqyHyWOa+cW/7nmzE4efHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l7ms/eiOGpWld/l6j358m3TnRCvQ7rJMqDZSfaQTPo=;
 b=QIgBCnaTbvfAmyhLfScBHIsZBpY8S316t6wNIo2rA747ngU2bgFxFlsFL2JkWbfqlAkx6JpvdD9S7nhwz+UUTJyRrPrwU1jCVp5sIYpoFOuy4WcY81DNjmqRqrq++B064unYYKfQYkYFDoGb5n7LCYEisuzpDzLkF1qMpUte7ZOMQEw0B/Pz5jkFY7OFBEAo2/Kq2P3rm+a9VHR8gar+fAY+M3lmUdppCbbzYLEh0kMyc4B4oWW5JtOg6wjqmvqHE75kWFcRelSJd+7yew/B+zqrv4QvqquOFvdox4Oe6bsFWnWhS44yu5wkTKr73sjDe2YGR2llJizDz4RKKzchPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l7ms/eiOGpWld/l6j358m3TnRCvQ7rJMqDZSfaQTPo=;
 b=NZ2TpZcX9DjV6wYU+x6wr+qWvLZ9nOaSsAyhV3G3c8BWKb3CvEaJqLdQicyzig9izYVlpIPPrfikv6WLdbKnGe8xjpq6gL8A+SjTgZVxAcmHdz8Qw8bFNJ8siLQmEN/Qxg/7e9FLDWTgotffziO3BwM0NparBGoJrIcH6MYjbOdys4Pkwp/rXd2measPMSyxly0o+wugXCFukEndjmhM3ZEp6MPQj3MztErobNkkFsSk9REGCIXAzJGI3/nTgEqk8ZDi9O4sk9wLNRuUDNWJ+ckLuAUsPoym6E1zUgzBnFS6vtHRHPptXGIvCmM73j2lB58sI10y9vQQaRFweHuy7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 15:00:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 15:00:18 +0000
Date: Tue, 19 Nov 2024 10:00:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, robh@kernel.org,
	krzk+dt@kernel.org, kernel@pengutronix.de, daniel.baluta@gmail.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
	peng.fan@nxp.com, iuliana.prodan@nxp.com,
	laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com
Subject: Re: [RFC PATCH] soc: imx: Add AHB to IP Bridge configuration driver
Message-ID: <Zzyn+i4khAqWBSjS@lizhi-Precision-Tower-5810>
References: <20241119130726.2761726-1-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119130726.2761726-1-daniel.baluta@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b54bd40-916f-4366-0b6c-08dd08aae1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Hn3d+1QslfPBYAti6iL44MwsX32dKd+PkHJ2X8vGVPojwwbSryTAoispdTj?=
 =?us-ascii?Q?EwS0ZC0cApQd4wLqYnBUSXqXzwQNFTmzUpYV1JhkRuJydP+vm2oqgqqs/5kj?=
 =?us-ascii?Q?ZTH5Y+yuuxQPpbRrufVlCpmANGo6vppgDvXIMkaHgQVHKJf2T/HSj/txcJR1?=
 =?us-ascii?Q?zOtLEPEPeOcUv+gSmCWklgVy/rOxBy2A6uyPikIYMAH//qgUNHA/wd642izZ?=
 =?us-ascii?Q?2PswtE1K2OjcUHZaioYHPX5vwtU6hRNug/fULm7u4ONBGE5gO5CYqbYQ9Vb1?=
 =?us-ascii?Q?aPyyz2QccXaPlnSqG9riwtQ6ecw57SXc7a/NEe/Tbeo9qfogrkv10swVfDCY?=
 =?us-ascii?Q?1Rp5wEncnsQRlzO37KYLalWA9TOX2p6NeRGIiB4TzVIF5PR+QZdVNeqL1hfJ?=
 =?us-ascii?Q?GCkqAC6+wEB56OafTXawnMKYl075/9YxHYIxS3m/lNzXVpKz+R1+YzMuv7N4?=
 =?us-ascii?Q?M44CiUaPnkfvfcvvFxxUl9xLWOm0KT84trkMIU4fu8J+eO6NAthooNfCb6wk?=
 =?us-ascii?Q?N6X1l5Zt55M3gCravPSfiDbfKMPPx2TNJV8AmGedq8STooQK+qoqMmRhu6yM?=
 =?us-ascii?Q?rTE0pMCDLjo5LdZ8j+flAWSucxlXzlwUIqe1cViEdPBIDd7tzXLkPuxw8470?=
 =?us-ascii?Q?ZiePQBOTtleUXUr2s8GbEVmatNXZyM3AEF9ParbC3FKk2jZ5Rr4HISo1ruOx?=
 =?us-ascii?Q?3pczkKIAlk9+P4zxzUFTTk9c1AQS+qYOBqtaKc67HDigXY+NpoYdelY+2xJY?=
 =?us-ascii?Q?3fqwVNinxuLJH8cOdFZbzw8b+plnTjQwrahcDfeeXe1z1eKnvuXZD+nFq+Ly?=
 =?us-ascii?Q?M8VRUwpkL2/2SpWKHJFJ7YSw8oFgMXFsHSaHdkiGCvcJNhbY2wmzn3+hPtvB?=
 =?us-ascii?Q?N7KcGBscaw+0nKJOlQeu2fOKLOtYTqAWaW1aKfrkRkIE2RiBmuJsBEyoIQ9x?=
 =?us-ascii?Q?TkB+OiRgNDUf4kschbEvgoBw0Dx0yDevhayOiBRwVKPhhrSSWc2TStjxaRqT?=
 =?us-ascii?Q?a1TeAncvnaliyAFr0O5QAMI9v3qpYxvzxvC1aRjbIJGv5DUC4YxjPeWYitnk?=
 =?us-ascii?Q?Ss658l5vTv82FDMINOHIPsfBZgUdk9IB+mpENvfn300VjbCdZ2n4FqJ6MYgE?=
 =?us-ascii?Q?XvNkkg+8chVyH1/2CsZJUIPSOngW6p80/szjRayIqCQ20XOamFz1ueZpFqNw?=
 =?us-ascii?Q?Q9IEuAi3VAHS+mZauwMXI/P4262t1UltWPndrNHJ+WNtjNiHivaHLu5CxweX?=
 =?us-ascii?Q?v2UBuvI+dBB0+WhoYozVs1wuWZxPVJ+CPqIgAGYo+iygfp0qEGmDema07p1w?=
 =?us-ascii?Q?u27POQ9myiMVAqBLrfNcgL1VJGxkAoHnXXMD4Wv0Nbz1mPqNZdfDOkcIDJeY?=
 =?us-ascii?Q?q5WYWiM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMQOTDdOpsNFn57C89nEOWQC3Q8i3+4j03WaqWzCmVWFt0j8kPvePOyww9Au?=
 =?us-ascii?Q?tzteupjAPDVbBzNlkT/5ppKhwGwXay1erDqIHzHWnLnKEzhhjzeBVMcGOE0d?=
 =?us-ascii?Q?XimpON43YO5rw9TQ4WoWrJAZEMSBr36JyJHiti/OvHJjvnJfI0byTYQyLULi?=
 =?us-ascii?Q?kWe73dFXmle5D7QbpREtL5j0FRPsQ2SPt6ILpKrBblRk7rv3xN3L5Sy0Q9QM?=
 =?us-ascii?Q?Jt+lHS1e2b/vI2+xvdDpi7r22hU2DkzFCScymeLWZm+Mgp14sbin9PlJOldY?=
 =?us-ascii?Q?+gXep8YXdQevW9gc6I1zJ6nlBTWxf15Gkn2hWgzup8aXka8H6lIWs4YvECbD?=
 =?us-ascii?Q?vYctnrcmpNpbWTWYSw/hdKl6twEMtIwfJwDt7F6OWn3jIYQnjP4mgOOFbXTu?=
 =?us-ascii?Q?gv/lrR0a3ygpKT+yEIkrOZwRQN8fnpqmhd69Aij3ahsSVYxL9GR7sNQnHKEI?=
 =?us-ascii?Q?SXdOGVHQlEBDk5ifcwZ6tSZjhgsQPVkTk/HNuOt5NQQTccGtta+MRgeZXWCn?=
 =?us-ascii?Q?2omYj6jte7y7QGoT28X9ZZSGs2dEHeX7opXgFrQAHFxm0IubXG5rAIM2ryXu?=
 =?us-ascii?Q?PV+OKmF1RoxNmRNxwiOeAkzLegO9SXgJJ2UwiO1+V/nOt08oBwAWwBTe0Q8W?=
 =?us-ascii?Q?KwI2npp1JRKjtSo1HnmqHEd76OPRR+0CirUUQX9MkUYJ0SW6LNQrYsxOY1UN?=
 =?us-ascii?Q?NCUecDvrXXB2zetiWu+HzUtGDvHf0P7oKqKtP6aRM/WFFwGng3bNsFFrexYx?=
 =?us-ascii?Q?6h2C4o7DuyoFBRiyIab0/MFNrS7E38dUXaAr78CMGl7OgehZxRvpObNAfxWr?=
 =?us-ascii?Q?36mkA8wxkXE5Ulhufy62qRaKDyfVwkZJVDmjsuNvt3ObnICz/cd9fu+esIVd?=
 =?us-ascii?Q?iaRf+uoHypJF/74zafLvItl9cnm5NPtptOG+9CKwMgUSOcvLKkGs3X9eIn2o?=
 =?us-ascii?Q?mqD548niZBtzRAK4xsTl5pZX5tdUYNAW+qT5AJCRSCqxDt8mU7NTezWu/feY?=
 =?us-ascii?Q?LpFdJoeIQkzqTEs5dAXge5ngIIN2+PNMtY9Hi5NzaVq+kwa+Hs4Kvad9cSey?=
 =?us-ascii?Q?wNvcbP2hHZU+AwkMCYMuwL851R0mLW95viuYzJ22bCqV6PkH2Q4VR/IZtoK+?=
 =?us-ascii?Q?yuRMf3yUqD+nMSiuqPbFJHeKj5kJ5Jl+Ud+hwe77otVMjhKsvd3ARcFuDX38?=
 =?us-ascii?Q?FkCQqbdLWYmCfpEWI10DqOl4fdX9rIyB4RqJh38r3EyS0vjLl+Ve/EaDOze5?=
 =?us-ascii?Q?3juzN+YbWKCltgQVipMYNp8RfVOk/pBJhj2YhFyVQXfdyvjVohnYZFu07sv3?=
 =?us-ascii?Q?TSf8KXD6QWs75gZmlrWd3zdkpTahJb/yPz8Eji1S+mOuEpW958c44zKtRHFa?=
 =?us-ascii?Q?JbjFBdKc9YNz6V4/s70QjJuzHo8I1uFNJ50VW8kiC1pLCII4maUlZd8s5X8A?=
 =?us-ascii?Q?mb/ibKcgCIzo1+bU7hUJaePUj2mTFGgn2xOMCl6NDyP1Z3cfR6wqxRQLhyG2?=
 =?us-ascii?Q?yJ5tXy1LgqFPZkVSd0sqadAN5BO9Gbzzt2utV1hrcogpuGTte0lpSlOFoGqz?=
 =?us-ascii?Q?BeQj5jevTt2uc2o/BaU58SuM7XjXdLgm6pMh5aPQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b54bd40-916f-4366-0b6c-08dd08aae1ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:00:18.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwsmC+wgtR23zPhvnA0BsFV2Vb6OLNSqVl4KoOY2ut51tQuAIhUDm1R+cwUh22mC6+i32YJBRscJMbO7W4yYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997

On Tue, Nov 19, 2024 at 03:07:26PM +0200, Daniel Baluta wrote:
> This is a RFC patch in order to allow AHB to IP Bridge (AIPSTZ)
> configuration to be restored after a suspend/resume operation.
>
> This is particularly useful for aips5 bus where the aipstz
> configuration is lost at suspend.
>
> In order to configure aipstz bridge we register a platform driver
> that will set default configuration permission at probe.
>
> Because AIPS configuration is lost at suspend/resume time we register
> a power notifier callback that will take care of re-initializing the
> configuration at resume.

why not use suspend/resume callback? what's happen if devices under AIPS
suspend/resume before AIPS resume function.


>
> More details about AHB to IP Bridge:
>
> This peripheral is designated as the bridge between AHB bus and
> peripherals with the lower bandwidth IP Slave (IPS) buses.
>
> The bridge is responsible  for indicating to IPS peripherals if
> an access is in supervisor or user mode. It may block user mode
> accesses to certain IPS peripherals or it may allow the individual
> IPS peripherals to determine if user mode accesses are allowed.
>
> The bridge supports the notion of "trusted" masters for security
> purposes. Masters may be individually designated as trusted for
> reads, writes or both.
>
> Even more details (including register description) can be found
> in Chapter 4.7 AHB to IP Bridge (AIPSTZ)
> of i.MX8M Plus Application Processor Reference Manual.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>
> This RFC patch is to get your opinion on the direction on how should
> we proceed with handling configuration registers for this kind of
> device.
>
> It registers itself as a platform driver at boot time and then is probed
> once the dts node is discovered.
>
> TBD:
> - device tree binding file
> - enhance error checking
> - is this the correct way to handle this kind of "peripheral".
>
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi |   7 ++
>  drivers/soc/imx/aipstz.c                  | 114 ++++++++++++++++++++++
>  2 files changed, 121 insertions(+)
>  create mode 100644 drivers/soc/imx/aipstz.c
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index e0d3b8cba221..7775f5f58036 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1406,6 +1406,13 @@ aips5: bus@30c00000 {
>  			#size-cells = <1>;
>  			ranges;
>
> +			aipstz5: bridge@30df0000 {
> +				compatible = "fsl,imx8mp-aipstz";
> +				reg = <0x30df0000 0x10000>;
> +				power-domains = <&pgc_audio>;
> +				status = "okay";
> +			};

supposed
	bridge@30df0000 {
		...
		some child node {
		}

		so child node's devies suspend/resume will after bidged's
suspend resume.

	}

> +
>  			spba-bus@30c00000 {
>  				compatible = "fsl,spba-bus", "simple-bus";
>  				reg = <0x30c00000 0x100000>;
> diff --git a/drivers/soc/imx/aipstz.c b/drivers/soc/imx/aipstz.c
> new file mode 100644
> index 000000000000..49a619f17dda
> --- /dev/null
> +++ b/drivers/soc/imx/aipstz.c
> @@ -0,0 +1,114 @@
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/pm_domain.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#define DRV_NAME "aips-bridge"
> +
> +#define AIPSTZ_MPR0		0x0
> +#define AIPSTZ_MPR1		0x4
> +
> +#define AIPSTZ_OPACR_NUM	(0x5)
> +#define OPACR_OFFSET(i)		((i) * 4 + 0x40)
> +
> +struct aipstz_drv {
> +	void __iomem *base;
> +	struct notifier_block power_nb;
> +	struct aipstz_cfg *cfg;
> +};
> +
> +struct aipstz_cfg {
> +	uint32_t mpr0;
> +	uint32_t mpr1;
> +	uint32_t opacr[AIPSTZ_OPACR_NUM];
> +};
> +
> +static struct aipstz_cfg aipstz5 = {
> +	0x77777777,
> +	0x77777777,
> +	.opacr = {0x0, 0x0, 0x0, 0x0, 0x0}
> +};
> +
> +static void imx_aipstz_config_init(const struct aipstz_drv *drv)
> +
> +{
> +	const struct aipstz_cfg *aipstz = drv->cfg;
> +
> +	writel(aipstz->mpr0, drv->base + AIPSTZ_MPR0);
> +	writel(aipstz->mpr1, drv->base + AIPSTZ_MPR1);
> +
> +	for (int i = 0; i < AIPSTZ_OPACR_NUM; i++)
> +		writel(aipstz->opacr[i], drv->base + OPACR_OFFSET(i));
> +}
> +
> +static int aipstz_power_notifier(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct aipstz_drv *drv = container_of(nb, struct aipstz_drv, power_nb);
> +
> +	if (action != GENPD_NOTIFY_ON)
> +		return NOTIFY_OK;
> +
> +	imx_aipstz_config_init(drv);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int aipstz_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct aipstz_drv *drv;
> +
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->base = of_iomap(pdev->dev.of_node, 0);
> +	drv->power_nb.notifier_call = aipstz_power_notifier;
> +	drv->cfg = &aipstz5;
> +
> +	imx_aipstz_config_init(drv);
> +
> +	if (dev->pm_domain)
> +		dev_pm_genpd_add_notifier(dev, &drv->power_nb);
> +
> +	dev_set_drvdata(dev, drv);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aipstz_of_match[] = {
> +	{.compatible = "fsl,imx8mp-aipstz", },
> +	{}
> +};
> +
> +static struct platform_driver aipstz_driver = {
> +	.probe =  aipstz_probe,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = of_match_ptr(aipstz_of_match),
> +	},
> +};
> +
> +static int __init aipstz_driver_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&aipstz_driver);
> +	if (ret) {
> +		pr_err("Failed to register aipstz platform driver\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +device_initcall(aipstz_driver_init);
> +
> +MODULE_DESCRIPTION("i.MX8 AIPS bus configuration driver");
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRV_NAME);
> --
> 2.43.0
>

