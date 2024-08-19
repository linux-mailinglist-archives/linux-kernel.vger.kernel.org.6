Return-Path: <linux-kernel+bounces-292587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F09571B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581FBB2ABB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C454B18A6C2;
	Mon, 19 Aug 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jC9CLZ/m"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F818A6B7;
	Mon, 19 Aug 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087028; cv=fail; b=iq5qbd6lmppwGbN6avXQDpFrUx6tF30GntuU3zK6Lt4V/skezb3d/AnDqEB24PwH5GA8/F99NXsFEZk+E267N6R0Jl3yEbHPzikK9qNTL9e1rZTz5sL4vSw9uW4Cp1geprUj/h50tMW9ka0JJc0R3i8r2OmQaxQTThzAJ6U5ATA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087028; c=relaxed/simple;
	bh=5qc6Vg/FR1MsaUlU2OGzHiiQzfmsmavrNRemLvounGo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OfC+LFgrtLaapaCfuQJfcWzYoEJYd/ZB4pidwEmAcb67iCHkezq/d0LKdCgNw6MiM8fcJ7oWFBNiarX4mcm0NbtebJ4LIG82PdAOb8E8rqNvSS2OT3NMATM81kzExewi+vCBI/pYrDHzdGGLI5VSAcwAYl7JVAYICtHXu2NL4II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jC9CLZ/m; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v13IqR8GqDSvg0ol9Q4CHobgqSxpb3dXZ3Cai2rIMR8b6DzwNfoFcNxhsome96ywnbJQHK8MKCa2//oAy+cWYdaw04DUQ3Tomv9jy6wVkbb+VshmUqospUtF0xNqryokcMQP6sfmaa/0m+XvideB4zFmdWfghkCg/lS/uryShKylh14XXUB/usX4mIw6BGl+ZsYhi8/m8JEFonsxeSLKeB9P9utGWtMnfDZjwVE5VpCFK4Y2IbEC2NjuQKFqOWBvX2+dBBjURBRtK5StTCV5ul09q6+mt0f34/lMxANA+grS8sMKCXR8wWVM2bxsEu4pPRmr95XS9ljI0fg2muM1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYlM/NVRbKl8k+/0zED1nHAy/Yz9DXW8VfuFXRjiehM=;
 b=LpZivny8sAWnbtdimx/Ut9QEG5dCTZSKVNsC7Q8jl/vvNEBooc6zaMuh3H4x8IXuoID0fmrpZWY053ELCKOKc0vgKIsUE72D0iiAo6edXMRityfgmQWbQJt2wS3ciIcUdrgTFeIKmYhoHPnUlc74o7Uj/p0atFiA/pbWLiJt3GAo4930ncBn0Jok6Ho1fJ2boAh5t1XzwmBxXCSoYfC0GSNEaB25xbedfHvgH/CfZ+ChAo+gnyFyCy8+5mjz0VODo0Gt89G1KQBN75L5JUllLSaUC4hW4FT+ujdx3Zi/KrwN0TUijo9xQaeMtzaZ7xDVvtXvQzDb4dgB1QqQjWzkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYlM/NVRbKl8k+/0zED1nHAy/Yz9DXW8VfuFXRjiehM=;
 b=jC9CLZ/mIJ3Pxqsfp1Npm2FscnABXsFzrtog4laoPEFGPwIYqK6h2z6vMWuwJebJee8sFS/5CUkUJVJb24h1k+B6JRTer+JhlH7SYIUfZy2yzSYYepUMtjyvITFakdHjbwaI4Ri7FrcGfGxeLqyJu3sHXpr3cN0twlg7TvOJQhXIHVXQAZdMwf7wYL7TiuGmFxZJ49hEes6nCeQhq0tV8X9Rs8mc9PZ3fhhNdXSn/yZYPBwXdSbX6IStQ4YK2v6kWoNx/W0UxbU0S0yguRo1ZbZ1F5tZsa7A3evpK2B4Wh5cVEx9W5zf963qdtU1PCBIgiWlU9Jc0LUY8vA8oyhXYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:19 -0400
Subject: [PATCH v2 10/12] arm64: dts: fsl-ls1088a-ten64: change to low case
 hex value
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-10-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=926;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5qc6Vg/FR1MsaUlU2OGzHiiQzfmsmavrNRemLvounGo=;
 b=4NTnQd8IRWHWFPA9LhueQgsupkSreE0fYKDm9Q5a6tHuUUJcoDzIwboTfBTouGYBkCN+SeZuR
 vrO+WJIJMslBhLKHG2sEW4pBB00EfEXgcp3Ai7iwKR7YzxybU3p6BYk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a61685-dca5-450d-568e-08dcc070e1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZS9sNkVIUTBUdEpFUk03cjI5MWVCVnVNM0d0ZkdWU3krdnUwTjVPcjZKOXJY?=
 =?utf-8?B?bHJ5T1h0Rm1CdGQ2ZEh0KzgvcjUySGtBSFZYRzRJcytzNUVRVGptNEY4ZTRi?=
 =?utf-8?B?V2lON2JHVVhtWHRiME85WlZDdU9STjB4MXh6MU5tWTRFaTh0K2xBVG1XYVU2?=
 =?utf-8?B?U2N5TE1tMlZMajU5Y3pqVGUzMFVpLzFXeWJLQzRjVEVPTUk0MTlRcXZYSm5E?=
 =?utf-8?B?d0UyQ0ttMk9CcEJueEdzVWMvNGtoREZHK2trbE1DUldHVXcrdmVwRTdJdTFy?=
 =?utf-8?B?MGVTT2h4c1pxaTE5ZGRLWlN6TzJBVmZrMHFmNGhQYUZtRzVORFRNQXZ6dlBK?=
 =?utf-8?B?VHdUSlIrTERQOXgrczMrdW1BK0RTYzZ3VGpwcWliQnZuOWpYRm9wQVlDQWFE?=
 =?utf-8?B?L3lNVEhEQThzSEQ0V2tIMGUwS0FSM3Y4TE96aUF6NjkveXVwcXM2Wm9RVGZa?=
 =?utf-8?B?b0tjenl6ZUoxUEpTLzlkZ1B3cnM0WGp2aDlLRVR0QmRoVVUwL1FDNzA5a1ZL?=
 =?utf-8?B?WEU1U2pWTjFUUFd2ZTNOWFVFR29OYU95NWR4d0NnK3RXeUI2cStEMHNtZGJr?=
 =?utf-8?B?MzhGa3FtOEVSRnlZL01FUndaVXFrbFA0c294OVRZdzdtRnNjeWRHeEptQ0ZP?=
 =?utf-8?B?Ym5jMGRFWURQNVZBaUxCcGY0NytBS2tDaURhV0g5aEpzMm5YcHQ4d0xhcUdy?=
 =?utf-8?B?aTJGWEdRL1I4NWlDcUxKK2NiTVk0NDBwUlkrb1hoRjVtYTNQTTNGdzZtKzRO?=
 =?utf-8?B?bGFrN3pVaHhPUnEvVk1jSk5KSmZYWE83QUpLUUZLdjhVUkpzWmRoNDlGZUZV?=
 =?utf-8?B?UTBpRlBCa3V6VzZSenpQajFOOGMxMG4vMUlGU1dyN08zejJvUVRCYlZpSlpE?=
 =?utf-8?B?azVKZVlsN1AyYmM0VkdPc0IwMW1wclpubnFtSlM1dWtjRHpWRnBvcUpwVzE0?=
 =?utf-8?B?cnZONUJMekFkYkZDZVlPOGRPMC8rWlhhMzA2QlB0OGdWeExZUWlKZ3AzMTdz?=
 =?utf-8?B?T2ZwQVdGVkVkTUErRmp2VkZ2RWk5c2tEc3VGV2ZTTEN0VVhhbnRMUkJ6R2M1?=
 =?utf-8?B?dEJTV0RHcDQxdGc4bEFyalpkakd3NG4vR3pmSWpsNTlLUWQxaGtIMnpwTGVv?=
 =?utf-8?B?cVkvdWRlODV6M0M3Tm5ORXR3NlZKMlBjNjB6L2J1VC9ZQi8zYWQvWDUyajls?=
 =?utf-8?B?dEFmWG83K2EwQyt2THlOeURSOG9HZm4wRlJkMWFrRm11TVVXc1VpbjU1SHd0?=
 =?utf-8?B?ZTRzR2tPOEdWdVFhTHRVckxIa3VhOHNTcDdaWmJ5VHYvRHRLL1Jzcm0rQTZB?=
 =?utf-8?B?elpFeEpFSksyTVBONHBZQVJqRGhkQks1d29CMnZFTnJmcU5YaSszblh1TGpY?=
 =?utf-8?B?dlJMK1dxQ1JiZ3RGVEpkeXJYYnNLTm9FK295MUtVSlhacEVmM3h2eUZtc1BP?=
 =?utf-8?B?MjQvNmsyR28vT1hXS1dGMmVRRWhVaXEyNVNRek5oaXcyMHFQbUIrYk1MWEk0?=
 =?utf-8?B?LzZiejg3enI4S0diNkpBK1NsZ2xmV1BGeGZaS3Vhdm5BTEpuckx2RVZUeXRo?=
 =?utf-8?B?TWVNS2E2T0J2OGR0cEhnUGlFVXFKaWl5eHdWVHdLdC8wRjNsRHdINkt1TURw?=
 =?utf-8?B?RkVOa2lyTjZxWmwxODZyNmd5eXBxVkk5ZndwaG5jMVFXTHFuc1Z4SnhMZlY0?=
 =?utf-8?B?UldlY0MxWU1sQkdWdEJEYlV0bmpvNkV6R2FEdjFnWUVFYjJpc3ZvSXFLMEpU?=
 =?utf-8?B?bFVkVXI4bW1RenEwZXVXcWtaRGYxektTSHViV09JNEJ4MTBBaVp5bFdHZWFk?=
 =?utf-8?B?MTg1VnJ0MG1UNjhpaTgrZWFyNGl4UFhQVmlITWZOWkx0cVBvWXJ5NE5oTU1s?=
 =?utf-8?B?Y0xEOEF2d09vckVmcHl2L1hTMS9HMXhabmR5dmlLVzRWK2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWRzSHFiNGgvZFR3anZTei9NVDQ2Ymo2L3N2cVFIeENoQ1Y4SUpvV21FYWVE?=
 =?utf-8?B?aitkWHUxbVVvNXpTQzVDdURrRmRmYkNDRkNXcWFQK3FRWFFFVHA5ampDcC9J?=
 =?utf-8?B?VGZ0R01EUmVDQmlnc0xJdTQyWHBNOS9FTnpUZzF2UVFKc0V3RmNzVUFnM2c1?=
 =?utf-8?B?aGE5ZkJKUEVvSUl5K0IxT0FqYzV6QXNsV3ZFOG5pdzVmUkpZRGhwV1VpV0VU?=
 =?utf-8?B?VWFmQ0NldEg2WmQzVmtrSDNXOURtdkU4cDQ4UndlM2U4bDNqWldxdkdJL3VQ?=
 =?utf-8?B?OHNTc0tXQk1ON29uQmhLL3cxVW8vM0FsYVJON0h5Nm9sUUlROW5Ray9CSlVK?=
 =?utf-8?B?Y3l6UkZFSU9remtWVVBBWTRUTnVuak04MzRFMTREYmcwUTU3aGpybUVVcnRU?=
 =?utf-8?B?L3Q0dm82aWZDYXFkSEFWcDV2cUJRMk1taSsyWmFoQTY5WVQ4UkRJWXdWT2wx?=
 =?utf-8?B?dkl6TnBUSy9vbkdnZ2RTNWREc05vNzJEd0JMMzNldDVEb1VrMWEyZDlXRDFP?=
 =?utf-8?B?SUJ2SDBoeGZMdWtxekhLd2JUUWRqRGN1dXA1T3cybU1RTkN3bklUSzFxcmRI?=
 =?utf-8?B?TTgrc0V1ZktpUDRWd0pUaXhhS3dEWkpMWnNNWUYxWUo5Q3NGRW5Fbmw5dy9I?=
 =?utf-8?B?V2luKytvT21rcjVkMnk1U3NmZU8xbHZYSlZsZ2V5blBrcTFBOTBqeWRiUXdP?=
 =?utf-8?B?MCtMT2tjWURYRkk5K2VRUDdjZHY4Q1RvVzRINFRSNHhmbWtVWHB2Qy8yYkZO?=
 =?utf-8?B?d0h5UTZWV0hoWFIwbGxBTGpYdmVkRGp4UGRwWjd5QlZLQmo2UldRTVFsQ2RD?=
 =?utf-8?B?TGxFNzRDSW03SnVSbk5XL2piazBEUm1Gci9iQzM0RFQ5b0UrUng2alVrcEJF?=
 =?utf-8?B?SkdMbk03dWJoN0pocUpMVisvdzJYVklLaUxaZmh3d3UxWHZUMWRKTHRycHlZ?=
 =?utf-8?B?ZnZhRUs5MHFaZW05RUFkUi9LaDROd05ybWZMWVRzc0dobVVhK2FubkRBVUtO?=
 =?utf-8?B?TXVPRkpyM3ZyaXlPU1U3NXVjYUxVVCtRT00xUEx2QWJDRHJEamJvUEhMU0JI?=
 =?utf-8?B?K3dkaFExbWZtUEY4Y2h2dTBhR1NKb1J5WjZ3M0RvUk5zWm5BS2JIT2dwQmht?=
 =?utf-8?B?VWdkT2pCenhJbzRqY0lDWXNwelpXNE45NUZvT0Qrdjd5bUhaR3BWcndtdlBV?=
 =?utf-8?B?WmtLQ3dVN2YxSHRPNEcxcVhhZXdGcHRkTkdvL3RWWDlBbVBhYW9ieXlCWlhn?=
 =?utf-8?B?c2pudkNvZmJlZGVudVAvaEhnNE1PVTUxZXRlNzQybXhFKzlUT21IUEE1d0NV?=
 =?utf-8?B?RFo3bThBWGplM1MwblQ4Uy9sQWxLQitJNitaVUw2VnpCV2h4RXFqTDdpTGVr?=
 =?utf-8?B?dmF4OThzZXp5KzNQZzI3WHdqQ2o1dElJL05uL2xrR2p4VkFNbmluN3IrMVdD?=
 =?utf-8?B?ZVcrSGJUTGNUbnRFQ3VjRVRxbHZEOHJUNXh2cDRWcG52MUo2RVI3NFQ3cmlr?=
 =?utf-8?B?Tk5SbWRyYlhReGxTclZjdklUOXAydlJKWk5nZ2lpY2h3SDVaaVV1NWtzVklK?=
 =?utf-8?B?eXdyVFdHaXdlTzVpY1RybDlhZE1jSWw0NktVOTNiT0I4U0N3ekN3M3BEM21N?=
 =?utf-8?B?dk9jSTJNZVpzRnN6MHVUTytEenZhUEJJUmhCWlV0bGhPa1pPZmMrYmQ5U1Y0?=
 =?utf-8?B?bmZnYXByVDVmTzE5V2U0NE9XUldsRHljUy9HVG9BWG5YUmZQWkZlMTdkei93?=
 =?utf-8?B?MnN0ZVIrU1hUWEtNcmlnT2swWW1iSXdBMnF5SHZqLzRzYXVocXR1Z0pwYmlW?=
 =?utf-8?B?akZycDNQVnU1cDF5Q2ZLcUd6V0ZqOURjc1gzVUxZOUxheGgwQ0wrVmIvalls?=
 =?utf-8?B?YUVaNlQyU0xvNjc3bHV4SlNLWXhBbmxQaW8yMkVWQVZDWmttTHZUVDc3WTBG?=
 =?utf-8?B?aU0wOE5VUzEvKzVtQUhNNndaQ0N6WWhRa3FJam9Sa3RGWHd1eUVZendRS1Zx?=
 =?utf-8?B?QnQwQlgxMmM0dWJMVnpYUjZIL2JKSGE1UWI1Y0RnYUU3WkhlVzE5Tkl2UDN1?=
 =?utf-8?B?c3BIZjFWU0h2L3RRcjZ1UEc5L0JHeEtZYjdvUElmSGhySitDTHpWZjBZZ3Iy?=
 =?utf-8?Q?IyZElRriJ9APqv2G9edmrGoM3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a61685-dca5-450d-568e-08dcc070e1c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:43.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pb4bU+xPflhPT9arvMEOhqt43pNsC653kgNV4d+J3844R+KXGezjsSMkx0wNYoviO9Dv/9N7yEKR/8qK2tUwRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

Change to low case for hex value to fix below warning:

arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: flash@0:
    partitions: Unevaluated properties are not allowed ('partition@5C0000' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index 57f2082143c8a..bc0d89427fbe5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -323,9 +323,9 @@ partition@580000 {
 				reg = <0x580000 0x40000>;
 			};
 
-			partition@5C0000 {
+			partition@5c0000 {
 				label = "dpc";
-				reg = <0x5C0000 0x40000>;
+				reg = <0x5c0000 0x40000>;
 			};
 
 			partition@600000 {

-- 
2.34.1


