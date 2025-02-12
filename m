Return-Path: <linux-kernel+bounces-511475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C765A32B82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F1F7A2F91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289D21504D;
	Wed, 12 Feb 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fb3/alNL"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F420B7F7;
	Wed, 12 Feb 2025 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377410; cv=fail; b=BnUCiw9d/TxQS6Kvi3OHv0nQKeeUpNXmEdDFid8m+v4m4wE0B9eMZKaiF83L1V2VdBj8eX85SLwzBkyLU6FLSoogc1a8N2SQzxi/TcEkq+7hSLwuWSrVT/Da5qNghOiTHG24RT6CzH/XH6mR9huRvsQZyXogBRTNF4iGvyrUb8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377410; c=relaxed/simple;
	bh=ueZ4erMMelzw3IzjBcuNC5ZauEhaVasA0AdzLuv/eLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pIfiKiYj3NuI97Gbj1cRWnye2g16xaWBsgs3Lumt1RkA/EPb3+NcGpIjBq0pdp7YgrL2q43b8s8QbfSpFkY9eYSVYgjcdCZmi21cD2Nn348Q5zxt9FvzK5MaNhKw8aP3moNWhss0Ly/V815LjwHSJ8DTTrpNyhlf+kcv/k0jr+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fb3/alNL; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsdacM/rzNhyzTcnn6vlqL665jqB2hNKue+yk0MIlAV0shOHPbQUSLMvCNGUQNEiLpAhfo1e5nWA2ROeGrzRUupdJokZWRvipGXHK0vmIeGCO5sFst6CXKB7hlI3GbcG1JNHjJjtCav+/7mLTxWV+5I/aQ+/nqQ3gR7VJM0qlYitGiLHZsdQu0tmELBGFDqKbSrVnWW3Qgb1xzSRLABsoiLrU7yCAv+ZbSrKSbaOVevMP0196JUTrdlWvRIdtpG/M2WzXDG/3vIesI8y+mmZ6qXkCK3cI1CF1xpHBJqcxh6R4sSA9enzhOEGVR8lvA87obV4PvxlmYo14u9AdOfKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2kdO3Eut2k/SsL1CrET/SsX+1sBrbBeTM8GGQcsf6M=;
 b=mosNAMFSQWyTruhAWtWAWWaUlHa7wP9oCxrJYswY62FmRbTJuTtPvrU5C/EaEyNWLdqmdOAsDg1uI1ggjhw1BIxvNhGTA2Ss9RH7+9rmY6TlCV5/ydI5zkwcr3JvjfAzv8moNAwJsmoWBDj8Hbw+5ImOeSywTJzbbHXYS4F8ENXtR04oimgUL5QlX87RRmwxrFiqXN+F3e5EfpVlbI7gtAnTatgFYHuwKhd50LuZ55WsVvLbiqrjajKbtsuXYFsoOfw7zzi6+oBW2Oc/AEAhm8E7h4r8AFGW7E3cTq7bRW2r3Ji7szjQpF9OLbH+rz57TwTrF4waoT4CYfxQZ69Tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2kdO3Eut2k/SsL1CrET/SsX+1sBrbBeTM8GGQcsf6M=;
 b=fb3/alNLmwT5eEtdaVcotHvgrSnLJiKF/pmMrFNCR5Bggi57vzEsELABhLiIM6xoxTNCq5JX+LINu4WuFIhFQH9I/JODg0BGatLqNDw+1acuybpMukKgMvva7KfT5Y1RtMOSxDFsISw+4BIFdY1ccMs+muYV2319zEwVtrq15UYex9CanVmTcYhu/mnCFABg/GjxivI+e+tciafHD3Tdkd9G8lRhKxEMAlOFn8p322uK14PfU+Ybh1G7vmdVRh0YDuZBTymtVhKuQE++If0185bZnzTId2bgJn3kSda5IwJ4NvhfKMwILjmAadNA4Y9qRc1fHq+1DZVsRATcWeaM+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU6PR04MB11232.eurprd04.prod.outlook.com (2603:10a6:10:5c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 12 Feb
 2025 16:23:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 16:23:24 +0000
Date: Wed, 12 Feb 2025 11:23:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: i3c: Add NXP P3H2x4x i3c-hub support
Message-ID: <Z6zK9Eo56RMoPFD0@lizhi-Precision-Tower-5810>
References: <20250212132227.1348374-1-aman.kumarpandey@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212132227.1348374-1-aman.kumarpandey@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU6PR04MB11232:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d34dabd-177c-4e42-c749-08dd4b81929a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QGrBrN57OekCZtCOhifgHahB67BB72TJKz/hOd6d87sr3eLfkRjhbXPNhsCE?=
 =?us-ascii?Q?6kKpIJFvgxAKWVZC9I07rV+GsrC9YSxBKiU/KOjnWfAUlRlS8NmUGn1kce/P?=
 =?us-ascii?Q?SE8hy51D8PjaSENkDgda5x0W8grhF5ahrATx4AMGkyf7kjF0Ut31JJq8dyzV?=
 =?us-ascii?Q?lzQNMfNzQZ5NMrSOtEXcCKnM6xUfCZgoKsJYpUnFgSUCpDncpQnFVjXSfu8X?=
 =?us-ascii?Q?kTQJx2UfIsfSyX0FzDiaI8fZfynhogsz98SiLJeecCKGtzxbvCdvUdAb67aC?=
 =?us-ascii?Q?/AXr9ll71/MH6hibnqf/Syu716voKAG114cKBOTzXxv4YkecQOfMCcUDJ/64?=
 =?us-ascii?Q?GMQmYlJxOsRwKKOE+URM+WIexEz8rYz3cvpb+WsnXOFIaFfuyRkL3rb3uunn?=
 =?us-ascii?Q?46v9eWt0WJWBcRWrdRoY86fYqrtxeNhCutYaorU43cmBGVxItOzgw/H7dbWd?=
 =?us-ascii?Q?QP7rslE/wr6x9SqgqSrTPZoYb8xj3LIx3EFHwW2LkbpPrW01n5QeLXoFJOVK?=
 =?us-ascii?Q?ZkRtAyCleLq5cZ64gj/UHvYJC1K1x7RblndBn/ej0lImEzkw4HYg8XO33tst?=
 =?us-ascii?Q?2eY4v/VIt4ShONsXWMB/Wi2dNToOeKlnogXZz7cKMEK/yX3uXbR1ZNGucLOU?=
 =?us-ascii?Q?83OKe0OQXhwcADr4XhH/6iB6Q/u6MP0WA7lRQZ3dNVFpI/QcMqMphfpGYt6U?=
 =?us-ascii?Q?Octn0UxeKJU1+1FCWRQKxmlrFuQAmzmlIaWH/G7ujei4pK7qHjhcqLuBcwdg?=
 =?us-ascii?Q?wVfbOiitvBcjUZKfXBX4PcwYVcwwRBH34kImgtdSBpdswKbaQooCEMNQg2mz?=
 =?us-ascii?Q?vY0oT3mk8P6q4+B9ghZfuYYIIeeEA713qNEBmLzM1BKlea8SYiudK7aPsXoP?=
 =?us-ascii?Q?hGF+12w0C+BFQiiZIiBA4CThAcjF4e5JygqQ1FQVnIULkZwjFjPN5wzr7+F4?=
 =?us-ascii?Q?aVeyqyHi8+w79qr1klEYAY/Igv61sGS6Kulxkw1g4MuBYUfc3EByoxOxB7EE?=
 =?us-ascii?Q?+P4CKtiob+EcSQjoiIARBexn/hpOFJH/dOnDwxn5DlWhzkYwIsh0i+iAC8s1?=
 =?us-ascii?Q?zVxDB6D+p+Mv+NQuIIcIBmBWNW0nuXeQ2ZZAbGJjPmS2vT8dMEoEItt5b+XS?=
 =?us-ascii?Q?GhcpRX81fdLNXxZ75FoUOzc3YOtZMYlmOrhGREc4cCbF9VBTMhh0BpawT+Sf?=
 =?us-ascii?Q?vv8P8lhRqWwb+s7bOD53scsOsWIRHN36zyjf/QHpZPhjZXjppSq3K323iskx?=
 =?us-ascii?Q?ACK++AK1GwLzOR3+AadUEPK9xgdknzPY8uf/z5kRWIUeCVL3Oc/ldfeBrGMA?=
 =?us-ascii?Q?MIqMDBBnK9hKNJE1Hx2gFwjb0WbA5V4qgP4f1K8VAJHhYRaf851dvNvHPdBc?=
 =?us-ascii?Q?lGhVmJZLbSbWuOE7/fONnScdTMrP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2gLQomL7bKL+AhGC8k5IL2i+jTmV3MqU+GSVnn7AyAugLEK3SR6sIrzNVof?=
 =?us-ascii?Q?tL8kEZmyE96DW89kaf1SqH59tMvNYmWS/FcFpbzJVJbU53W0UeiaIeNd6LIJ?=
 =?us-ascii?Q?KnErtEsIOw8mxLad3bGhzsNzCTBcFLCa6tyibCeehuRc/8vU5jKQzNKj0f/x?=
 =?us-ascii?Q?VYGEhbRGfjbSJxSdgByxgW/8UuN8xsDbUBj+N3+yLrV0CV8/xWssqJtwH8Lf?=
 =?us-ascii?Q?zTabKpIiWpGmboZoZe9A3zpk+xu9AwDBP4xAwenTc7NCP861nkApkYynKJeE?=
 =?us-ascii?Q?SP2X5ATHz42howBDfsmj1KXytkbpeXOH1oZ26loEHQespwM/uSI0bNHlzXKn?=
 =?us-ascii?Q?GjQyHH5NHpfzRKvKfYYKiNaRGxS78EB2SDVo/FHrypeSoygH8umWteyrVZxz?=
 =?us-ascii?Q?hlA3/uy3aCZSacLogB8NEblAO0atssn0fuuljfPDSaV9vZ8rGt7qz+cJniOM?=
 =?us-ascii?Q?slX7vYm5yTHC4pLyJDO8Yh1zf2GWEMQ9PXDYrpBhHJjjMVz9A8/YDS0V1qT5?=
 =?us-ascii?Q?T2WQ2Z1xFaIxQbnAcROX4tarFtnOVmTfzgYXJ3qQpzixNW70pEv9acqHVhMu?=
 =?us-ascii?Q?RGOW7pw/5sE/RKTRQbwlaU91dgfpkl79Ff+Vo+bj6Qwn3386MKjixnM2L9fF?=
 =?us-ascii?Q?BTyC4zsfXmb0mhwOTflsFA8uqHrwQFz3rwPrleHmYT2cfXcWuJBU79lyxPcp?=
 =?us-ascii?Q?Nek9OZnt7rwtPgrCzcL6+jw3uiGCmEqvWCgvBQxrxnaCXL+D5XO9DYvwRBDt?=
 =?us-ascii?Q?43lLPzxAZate2UL2cK0tJnTYHDlowwTrO8Z1Bbt+hKDqKVVGjqI6FmNNYRQq?=
 =?us-ascii?Q?l3nxRgzcl3rlfIXisJJuRc/HHLSEe0NeyYWfgLaIyNdT7Zc+376KLgbIQD14?=
 =?us-ascii?Q?ox02Vwq10gA2m81l1onzrqtEpJun9ChBS72BvFBInL3QYFk9nJ3oso8CL8EN?=
 =?us-ascii?Q?L719EWRF2WWpqCuYMfIJOK260/AQ83okdz54+2YTJC1NGaObqR11zXinVV7Q?=
 =?us-ascii?Q?nQDoLoY45K0d2YN/lAOi/mXZeN5sa9veeiYCSgCqpzzSKXTPE9rxGpxjWYxh?=
 =?us-ascii?Q?w27PcMtqIuDtrpw9HBNtCNAxO3zklnkoyM6wmpQh9UaLDYOj2xUWGHJzNYUx?=
 =?us-ascii?Q?DexGO+0m8Iw42ozQ38m7BkdVcOob0VDiXewwB0cPPdeSsblrteXlq9iU0vyq?=
 =?us-ascii?Q?zt7qjOtFrUKaH/34N+4nRBNGSSImzkAnxJ2rdr6OLxnhC6Tf46hwlhrGvDuP?=
 =?us-ascii?Q?5z9zH01qCMjE3ZqKnVDLW/tryXQ4vCAjWaf3Ydg3nbVWX/8irRldyZjEAve1?=
 =?us-ascii?Q?/5Pzr5jOR/kMjL89Y1XhjfCrRnlKDVNX0wAiRJnOspxWMTODSETSyws9je9q?=
 =?us-ascii?Q?GtS1psnSVGk9hfPCN3rs01wfhqir9YC9vJj3ktgE+vArc0tYQmG7PLrWprLK?=
 =?us-ascii?Q?Gn9oLpLQtJYJDhpHCVMB5a0LjASCjbYAc3HnURCPhTXIkMGTFrFMZuyDqT0/?=
 =?us-ascii?Q?zNCvg1CWT/6jwYbomzi+HUy0tyZkd+o9dd0tWRMrRafyO0RftPK/eSIaAtzP?=
 =?us-ascii?Q?mkZ2HK2NQokbDne4LCZwlMNb5Jff3qhGaF7nMWmB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d34dabd-177c-4e42-c749-08dd4b81929a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:23:24.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd9u1Gpb8Sk7kaV/updqq5rls8U0LbgtH4YhT/pTavOd7zbLGm8jIHUK6s4YFMNtDJtFCsbzn4CTkRqgeRZRPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11232

On Wed, Feb 12, 2025 at 03:22:26PM +0200, Aman Kumar Pandey wrote:
> P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841) is multiport I3C hub
> device which connects to a host CPU via I3C/I2C/SMBus bus on one
> side and to multiple peripheral devices on the other side.
>
> Signed-off-by: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
> Signed-off-by: Vikash Bansal <vikash.bansal@nxp.com>
> ---

You need run before post

make dt_binding_check DT_SCHEMA_FILES=p3h2x4x_i3c_hub.yaml

I just go through it.

>  .../bindings/i3c/p3h2x4x_i3c_hub.yaml         | 404 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 411 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
>
> diff --git a/Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml b/Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
> new file mode 100644
> index 000000000000..33ea524e5432
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
> @@ -0,0 +1,404 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024-2025 NXP
> +
> +%YAML 1.2
> +
> +$id: http://devicetree.org/schemas/i3c/p3h2x4x_i3c_hub.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: P3H2X4X I3C HUB
> +
> +maintainers:
> +  - Vikash Bansal <vikash.bansal@nxp.com>
> +  - Aman Kumar Pandey <aman.kumarpandey@nxp.com>
> +
> +description: |
> +	P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841) are multiport I3C hub devices
> +  that connect to:-
> +  1. A host CPU via I3C/I2C/SMBus bus on one side and connect to multiple
> +     peripheral devices on the other side.
> +  2. Have two Controller Ports which can support either
> +     I2C/SMBus or I3C buses and connect to a CPU, BMC or SOC.
> +  3. P3H2840/ P3H2841 are 8 port I3C hub devices with eight I3C/I2C Target Port.
> +  4. P3H2440/ P3H2441 are 4 port I3C hub devices with four I3C/I2C Target Port.
> +     Target ports can be configured as I2C/SMBus, I3C or GPIO and connect to
> +     peripherals.
> +
> +  Device tree node can be used for following configurations:-
> +  1. Controller Port can be configured via dt entry to support
> +  2. I2C/SMBus mode or I3C buses.
> +  3. Enabling voltage compatibility across I3C Controller and
> +     Target devices.
> +  4. Up to eight target devices and their modes(I3C/I2C/SMbus modes).
> +  5. To support MCTP device
> +  6. To support In-band interrupts
> +
> +  Controller Port can be configured via dt entry to support I2C/SMBus mode or
> +  I3C buses.
> +
> +  For I2C devices, use below format:
> +      DT node: hub@static_address
> +      reg: encodes the static I2C address.
> +
> +  For I3C devices, use below format:
> +      DT node: hub@static_address,PID
> +      reg: encodes the static I2C address (0 if the device does not have one), and the
> +      Provisioned ID (PID) used to uniquely identify a device on a bus.
> +      This PID contains information about the vendor, the part, and an instance ID so
> +      that several devices of the same type can be connected on the same bus.
> +      assigned-address: represents the dynamic address to be assigned to this device.
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +properties:
> +

missed compatible string?

> +  cp0-ldo-en:
> +    enum:
> +      - disabled
> +      - enabled

vendor specic property should be start with vendor name.
nxp,cp0-ldo-en

bool property, simple use flag.
$ref: /schemas/types.yaml#/definitions/flag

The same as below other properties

> +    description: |

Needn't "|", if not format below context.

> +      I3C HUB Controller Port 0 LDO setting for turning on and off. If enabled, the dedicated
> +      pin will provide the voltage generated by the on-die LDO. It is an optional property,
> +      the configuration remains default if it is not supplied.
> +
> +  cp1-ldo-en:
> +    enum:
> +      - disabled
> +      - enabled
> +
> +    description: |
> +      I3C HUB Controller Port 0 LDO setting for turning on and off. If enabled, the dedicated
> +      pin will provide the voltage generated by the on-die LDO. It is an optional property,
> +      the configuration remains default if it is not supplied.
> +
> +  tp0145-ldo-en:
> +    enum:
> +      - disabled
> +      - enabled
> +
> +    description: |
> +      I3C HUB Target Ports 0/1/4/5 LDO setting for turning on and off. If enabled, the dedicated
> +      pin will provide the voltage generated by the on-die LDO. It is an optional property,
> +      the configuration remains default if it is not supplied.
> +
> +  tp2367-ldo-en:
> +    enum:
> +      - disabled
> +      - enabled
> +
> +    description: |
> +      I3C HUB Target Ports 2/3/6/7 LDO setting for turning on and off. If enabled, the dedicated
> +      pin will provide the voltage generated by the on-die LDO. It is an optional property,
> +      the configuration remains default if it is not supplied.
> +
> +  cp0-ldo-volt:
> +    enum:
> +      - 1.0V
> +      - 1.1V
> +      - 1.2V
> +      - 1.8V
> +
> +    description: |
> +      Controller Port 0 voltage level is controlled by the I3C HUB Controller Port 0
> +      LDO setting.
> +      Since this parameter is optional, the configuration remains default if it is not supplied.
> +
> +  cp1-ldo-volt:
> +    enum:
> +      - 1.0V
> +      - 1.1V
> +      - 1.2V
> +      - 1.8V
> +
> +    description: |
> +    Controller Port 1 voltage level is controlled by the I3C HUB Controller Port 1
> +    LDO setting.
> +    Since this parameter is optional, the configuration remains default if it is not supplied.
> +
> +  tp0145-ldo-volt:
> +    enum:
> +      - 1.0V
> +      - 1.1V
> +      - 1.2V
> +      - 1.8V
> +
> +    description: |
> +      Target Port 0/1/4/5 voltage level is controlled by the I3C HUB Target Port 0/1/4/5
> +      LDO setting.
> +      Since this parameter is optional, the configuration remains default if it is not supplied.
> +
> +  tp2367-ldo-volt:
> +    enum:
> +      - 1.0V
> +      - 1.1V
> +      - 1.2V
> +      - 1.8V
> +
> +    description: |
> +      Target Port 2/3/6/7 voltage level is controlled by the I3C HUB Target Port 2/3/6/7
> +      LDO setting.
> +      Since this parameter is optional, the configuration remains default if it is not supplied.
> +
> +  tp0145-pullup:
> +    enum:
> +      - 250R
> +      - 500R
> +      - 1000R
> +      - 2000R
> +
> +    description: |
> +      Target Port 0/1/4/5 pull up setting is controlled by the I3C HUB Target Port 0/1/4/5
> +      pull up resistance level.
> +      Since this parameter is optional, the configuration remains default if it is not supplied.
> +
> +  tp2367-pullup:
> +    enum:
> +      - 250R
> +      - 500R
> +      - 1000R
> +      - 2000R
> +
> +    description: |
> +      Target Port 2/3/6/7 pull up setting is controlled by the I3C HUB Target Port 2/3/6/7
> +      pull up resistance level.
> +      Since this parameter is optional, the configuration remains default if it is not supplied.
> +
> +  cp0-io-strength:
> +    enum:
> +      - 20Ohms
> +      - 30Ohms
> +      - 40Ohms
> +      - 50Ohms
> +
> +    description: |
> +      To regulate the output driver strength at Controller Port 0, use the I3C HUB Controller
> +      Port 0 IO strength setting.
> +      It is an optional property, the configuration remains default if it is not supplied.
> +
> +  cp1-io-strength:
> +    enum:
> +      - 20Ohms
> +      - 30Ohms
> +      - 40Ohms
> +      - 50Ohms
> +    description: |
> +      To regulate the output driver strength at Controller Port 1, use the I3C HUB Controller
> +      Port 1 IO strength setting.
> +      It is an optional property, the configuration remains default if it is not supplied.
> +
> +  tp0145-io-strength:
> +    enum:
> +      - 20Ohms
> +      - 30Ohms
> +      - 40Ohms
> +      - 50Ohms
> +
> +    description: |
> +      To regulate the output driver strength at Target port 0/1/4/5, use the I3C HUB Target
> +      port 0/1/4/5 IO strength setting.
> +      It is an optional property, the configuration remains default if it is not supplied.
> +
> +  tp2367-io-strength:
> +    enum:
> +      - 20Ohms
> +      - 30Ohms
> +      - 40Ohms
> +      - 50Ohms
> +
> +    description: |
> +      To regulate the output driver strength at Target port 2/3/6/7, use the I3C HUB Target
> +      port 2/3/6/7 IO strength setting.
> +      It is an optional property, the configuration remains default if it is not supplied.
> +
> +patternProperties:
> +  "@[0-7]$":
> +    type: object
> +    description: |
> +      I3C HUB Target Port child, should be named: target-port@<target-port-id>
> +
> +    properties:
> +      mode:
> +        enum:
> +          - i3c
> +          - smbus
> +          - i2c
> +          - gpio
> +
> +        description: |
> +          I3C HUB Target Port mode setting to control Target Port functionality.
> +          As per now it is oly supporting SMBus, i2c and i3c( i2c mode will work
> +          with hub network).
> +
> +      pullup:
> +        enum:
> +          - disabled
> +          - enabled
> +        description: |
> +          I3C HUB Target Port pull-up setting to disable/enable Target Port pull-up.
> +          It is an optional property, the configuration remains default if it is not supplied.
> +
> +      ibi_en:
> +        enum:
> +          - disabled
> +          - enabled
> +        description: |
> +          I3C HUB Target Port IBI setting to disable/enable IBI for Target Port.
> +          This property is optional. If not provided, Target Port IBI will disabled.
> +
> +      local_dev:
> +        description: |
> +          SMBus Target Agent can discard transactions of downstream device and not generate an IBI to upstream I3C Hub
> +          Controller Port. Up to 8 device (addresses) can be configured as local Devices.
> +
> +          This property is optional. If not provided, local device list will empty.
> +
> +      always-enable:
> +        description: |
> +          Add this field to enable hub network(Controller port -> target port).
> +
> +          This property is optional. If not provided, by default hub network will disabled for respective port.
> +
> +    patternProperties:
> +      "@slave-address,pid$":
> +        type: object
> +        description: |
> +          Adding this node to install the downstream devices.
> +
> +        properties:
> +          compatible:
> +            description:
> +              Compatible of the I2C/SMBus downstream device.
> +
> +          reg:
> +            description:
> +              Downstream device addresses which are connected to target port.
> +
> +          I3c HUB driver supports standerd i2c/i3c DT entry as it passes DT node to respective driver for
> +          downstream device.
> +
> +additionalProperties: true

should be false
unevaluatedProperties: false


> +
> +examples:
> +  - |
> +      i3c_hub: hub@70,236153000c2{
> +          reg = <0x70 0x236 0x3000c2>;
> +          assigned-address = <0x50>;
> +          dcr = <0xC2>;
> +
> +          cp0-ldo-en = "disabled";
> +          cp1-ldo-en = "disabled";
> +          cp0-ldo-volt = "1.8V";
> +          cp1-ldo-volt = "1.8V";
> +          tp0145-ldo-en = "disabled";
> +          tp2367-ldo-en = "disabled";
> +          tp0145-ldo-volt = "1.8V";
> +          tp2367-ldo-volt = "1.8V";
> +          tp0145-pullup= "1000R";
> +          tp2367-pullup = "1000R";
> +          tp0145-io-strength = "20Ohms";
> +          tp2367-io-strength = "20Ohms";
> +          cp0-io-strength = "20Ohms";
> +          cp1-io-strength = "20Ohms";
> +          target-port@0 {
> +            #address-cells = <1>;
> +                #size-cells = <0>;
> +            mode = "smbus";
> +            pullup_en = "enabled";
> +            ibi_en = "enabled";
> +            local_dev = <0x30>, <0x40>, <0x50>;
> +            backend@4c{
> +              compatible = "i3c-hub";
> +              reg = <0x4c>;
> +            };
> +            rtc@68 {
> +              compatible = "dallas,ds3232";
> +              reg = <0x68>;
> +              interrupt-parent = <&gpio2>;
> +              interrupts = <20 0>;
> +              trickle-resistor-ohms = <250>;
> +            };
> +
> +            eeprom@57 {
> +              compatible = "atmel,24c32";
> +              reg = <0x57>;
> +              pagesize = <32>;
> +              wp-gpios = <&gpio2 2 0>;
> +              num-addresses = <8>;
> +            };
> +          };
> +          target-port@1 {
> +            #address-cells = <1>;
> +                #size-cells = <0>;
> +            mode = "smbus";
> +            pullup_en = "enabled";
> +            ibi_en = "enabled";
> +              local_dev = <0x35>, <0x45>, <0x55>;
> +          };
> +          target-port@2 {
> +            #address-cells = <1>;
> +                #size-cells = <0>;
> +            mode = "i3c";
> +            pullup_en = "enabled";
> +            hub-test@4c,25400000000{
> +              reg = <0x4c 0x254 0x0000>;
> +              assigned-address = <0x50>;
> +            };
> +          };
> +          target-port@3 {
> +            #address-cells = <1>;
> +                #size-cells = <0>;
> +            mode = "i3c";
> +            pullup_en = "enabled";
> +            always-enable;
> +          };
> +      };
> +
> +      i3c_hub: hub@70 {
> +          compatible = "nxp,p3h2x4x";
> +          reg = <0x70>;
> +
> +          cp0-ldo-en = "disabled";
> +          cp1-ldo-en = "disabled";
> +          cp0-ldo-volt = "1.8V";
> +          cp1-ldo-volt = "1.8V";
> +          tp0145-ldo-en = "disabled";
> +          tp2367-ldo-en = "disabled";
> +          tp0145-ldo-volt = "1.8V";
> +          tp2367-ldo-volt = "1.8V";
> +          tp0145-pullup= "1000R";
> +          tp2367-pullup = "1000R";
> +          tp0145-io-strength = "20Ohms";
> +          tp2367-io-strength = "20Ohms";
> +          cp0-io-strength = "20Ohms";
> +          cp1-io-strength = "20Ohms";
> +          target-port@0 {
> +            #address-cells = <1>;
> +                #size-cells = <0>;

align to 4 spaces

> +            mode = "smbus";
> +            pullup_en = "enabled";
> +            ibi_en = "enabled";
> +            local_dev = <0x30>, <0x40>, <0x50>;
> +
> +            backend@4c{
> +              compatible = "test-dvr";
> +              reg = <0x4c>;
> +            };

Need space line here

> +            rtc@68 {
> +              compatible = "dallas,ds3232";
> +              reg = <0x68>;
> +              interrupt-parent = <&gpio2>;
> +              interrupts = <20 0>;
> +              trickle-resistor-ohms = <250>;
> +            };
> +
> +            eeprom@57 {
> +              compatible = "atmel,24c32";
> +              reg = <0x57>;
> +              pagesize = <32>;
> +              wp-gpios = <&gpio2 2 0>;
> +              num-addresses = <8>;
> +            };
> +          };
> +	    };
> +-  |
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af686e0bb6d7..20aa3e987ac5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17167,6 +17167,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
>  F:	sound/soc/codecs/tfa989x.c
>
> +NXP P3H2X4X I3C-HUB DRIVER
> +M:	Vikash Bansal <vikash.bansal@nxp.com>
> +M:	Aman Kumar Pandey <aman.kumarpandey@nxp.com>
> +L:	linux-kernel@vger.kernel.org

Need I3C and imx maillist.

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
> +
>  NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
>  M:	Jonas Malaco <jonas@protocubo.io>
>  L:	linux-hwmon@vger.kernel.org
> --
> 2.25.1
>

