Return-Path: <linux-kernel+bounces-381830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028169B050E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259521C222B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1F01B6D17;
	Fri, 25 Oct 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YsnlApLS"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0E13AA2D;
	Fri, 25 Oct 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865169; cv=fail; b=SzmH91OHtvIlUpXoKOUN8sOmMGPCQ0llFTLhY1MHuqgReHQI/rSn9LtfL/TD5WiKFVSmEdL7a8kc5x0VRhoZOMTmc6TF3CsOFrWXEx5TZEXLpdkjuyX+QqaQKRWEoA6nNrBX0f+kJ5iF1ANwWf6eaIz6/+3vfwsFGsGa6ad86Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865169; c=relaxed/simple;
	bh=3w6b8R9Wg4w7lftSMhJexRzHQJo7dTH5/sLkpTQkfP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=baguWA0Ik+96Sh5P/DPq8rV+/llwYc2JVzkzrmBnE+9eC+e442/u+Do9kYau3QXcq9WTor63i2BVvvxTT6XKwqA2c4bElRaevBBJqrNXcwe4E/R/odZ89rIBU1KQC/tNqf8rkAYsihLr9+3s4vpRuKU66yBwioPt6fCTxBXFCSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YsnlApLS; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG5jErbWZUCt/lCDK8jolGanCzaRTefPeNlqjj2z8Ba5Rmd6kZ2NOgKuqEcKYFoOnqXxNrs9hE1M+APCZmNB57j9+WVvSvBiDWNuQrr6duofNOTIy2rEgaT4M8P4ztNgyJMMfB6WehdogZcA519lUAapj8kwdQy1wju5MJgpAO1koP1wcfiqzztDW5NXNqjjCpHcI5UfX+/1H3v9UQtcoX2HbfdN2Be6onH8+m+cqRUe3J0yhUEGGYRBWA/fufPm20fgH+XtkhKFzlbSbeGnYQ0h6upNFZ3b5vlXeNAG2BPMFtzn7OtqFf+S797kV1qiAL38A0cPKfoslxEBXHRHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPe+m81D9qHE8jRKM583PkGJD8NJm/bGsAFNeQpFLc0=;
 b=dJCcovvMGjOZVYBhZzOln2rZzu2U1VE5EW3AraBgXeGvdNoJXDIYjkEM+UWMhhcW36ujNLEKImtB4Ar1Nca4gzpCeMPvMenS74ulSJlKIkm3RqjnmErlDU3KE1XZVlsehCwrWzLQYI31cJ0MMR+LAh/fX5r5xBq3KArR7QgHe3YhH3fO5CKpHQzV/cekD6kCQTUgVcSd9ttBqUOR8aGfui0OamuyYnQgYEKPyhEMtfAZHGRVoEYe46kGbj4czXL+tFcpRODN47sIBsNHPpu1fIE0q6Ai3HvAyYxL8uIVyr4xHpjL0Uoi1inHP4CN/QYSiAcrzECJs44E9cXtaOhn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPe+m81D9qHE8jRKM583PkGJD8NJm/bGsAFNeQpFLc0=;
 b=YsnlApLSgGLDj6Y8ey2n5GCtaflvAoG+ATFw+cRLgtqy/o8h+3Vua/VvMgJ3oRnJb3dott4Iy5ZRieW35S3zfpn7UOOKWyTLeY8KrXKHdr7b+T6pBZHI79SaqCUepHJ165OJKPeM5I3LqkS3CDaSQnCb4niHPOXJJ1s0VpcCNhXWsZaIQudL7fRidPACozUw/EB9U91rnfL2hW9YaQXw2xw/ajsaBu3jUdyV2YX61QRk0a0rB9TI3rTpQ/6zG7e4A7Ho9zr7uWTgiZvi8Gl7+z8xPuyhiQsy6TftpkNKHZ84k8PJ/Rm9RfyGZQg9yZ1+KXCFk8jQ7ier0Ys/ujI/Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VE1PR04MB7327.eurprd04.prod.outlook.com (2603:10a6:800:1ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 14:06:02 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Fri, 25 Oct 2024
 14:06:02 +0000
Date: Fri, 25 Oct 2024 10:05:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	"open list:TQ SYSTEMS BOARD & DRIVER SUPPORT" <linux@ew.tq-group.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mn-tqma8mqnl-mba8mx-usbot: fix
 coexistence of output-low and output-high in GPIO
Message-ID: <ZxulwvE3amILaFRT@lizhi-Precision-Tower-5810>
References: <20241023210313.1390767-1-Frank.Li@nxp.com>
 <CAMuHMdW-tXFYSfTerb-eYmmbJHYN9xNyiGMPoeGArmDnAajUmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW-tXFYSfTerb-eYmmbJHYN9xNyiGMPoeGArmDnAajUmg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VE1PR04MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: c522e243-4b9b-4637-9eed-08dcf4fe28aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2JFbitqOGdGSUJEZE5tV0pmQnVtbFNka1BJNjA0ci83b09ReGpBSXduWjNW?=
 =?utf-8?B?dnozNmFJVGNyYkNCZ25aNlh2Q0gxdVFhUFZCZGV5SklCWjNUaWFUSGthRzVF?=
 =?utf-8?B?cTNNRTNYUDZLQXhaM254Zit0R2JqeUl6M2NoZUZ1QmIzOE5sUkZQT01tZTdr?=
 =?utf-8?B?VDAvbm1qNW1CVHJPZEZvWktmU2pic3VsTkpNanNBazBVY2hiZFBRRDZTYjZk?=
 =?utf-8?B?ZkVRTVp1aTZSaHVpemdIRHJ2V3R5Uk41RnJ1YWlLNHRxVzJEMWdLN0wyQW1k?=
 =?utf-8?B?RHg0QWhmMU9wOEYyRE9FQ25SV0c3eFBGN1VsYnlSbkVwTnV4bDNwa0N1aWxV?=
 =?utf-8?B?dVAxU2Ira3ZkWEVCbWtUSXNxTlh3K1o2UWxHazdBQjAvbVEzOXJINEFJTjZz?=
 =?utf-8?B?Uy83OENkUXQrMmRmTHk3SHlPUldpbDh5L3VoeFgzT0NXaVlLKy8zUGhIT1lU?=
 =?utf-8?B?RHdqSnMvQzRnN0liRFNwckdVVXM1cWNIVWE1NTRZMWZsVGR4WHFaL0IyNExn?=
 =?utf-8?B?T2hySE1tczhLVlFUVzRSaXBJSCtEaGpGcnNQYWNjVmJxcjJQb0RCbm8vZUpm?=
 =?utf-8?B?ZkN0Y1ZObnJySDNUS0hMN0sxTmhJandXZmNac2c4OGhKbEIyYUVpTXpxWWZB?=
 =?utf-8?B?Uno3Uis0bStpSFB3ZE01Q1VMT1BLV21xMUZyeStwaENnUFRCQkZyNFpzbmJ2?=
 =?utf-8?B?SXgvamhSVUNNNkZWUmtRRHhVbUMwblU4b282UXUwVEdYYmVSOHpzL0gzd29q?=
 =?utf-8?B?cUFvQmJUcWJtT2xpUFZvOGxOejdPRXlkaitaMTdxblNHU2M0ejJRR3ltRzZJ?=
 =?utf-8?B?TklxbXBkN2ZNbzBPTkdZMW1LWkxTT01WVVVCdmVxQ0dJOTZoOCtHMXR1UENL?=
 =?utf-8?B?WERuWi83dWkvZG50ZThrVGQ2eGpmblFtSUV0SWZuSzVLYzM4RTF6aTBJYU83?=
 =?utf-8?B?cEI0OGhMTjFreHJUcnZaSjJueHB1b2NNRHNZRkpxTHVpK24xaWg0WXQ0SXB5?=
 =?utf-8?B?eDFMeHAyaTg5eGxPOTY5aWhWR2FiVVZ2emtxTEo1OEVOdFJ1d3BFcnFkOXJR?=
 =?utf-8?B?SWt6RzdBKzExNWxvWEpyRWVEa1BKTC9xa2hRSWh1bVZQTTlPZUdnb2c3bWRw?=
 =?utf-8?B?ZGhuUkV4MDZMSFdiWVFnR09nL1ZEY29xYXNmQUcvbStDbUJtRWNOWW9sc1F6?=
 =?utf-8?B?VUswUnozbi9ydDl1Q2xJVDhwNVhsVGprSmc4S0RzUXBOWjFiejd1bGR0MUFq?=
 =?utf-8?B?SFl4a1lONE52SDZWSUtyWEtXR0xYZCsyQzU1NUJORU1KYjFGNVB3dzFHQkVS?=
 =?utf-8?B?bXFLdUl5S050eG1ockNpdGYzS3ZiQ1V4R3E1ei9EOWRpdTZFeG9vU3k1MW9i?=
 =?utf-8?B?M2NWVEJzcTRURHoxY2pZY3Z1czRBQUpKamEzUWFSTXdjcERQY1E3UDZtZEFx?=
 =?utf-8?B?VnNDeWJZT1drTzBsREludE1HZk15M3VhSURXN1Axc3VDK1NuWkpFN2p6WTAx?=
 =?utf-8?B?Vlg1bWRxZjFLTkRITWIxandHbGtkY3BDYUI4U3NQVW5rcGUyZjJzRmp2bEti?=
 =?utf-8?B?N0x6cTRsdEo5cHNkbGU2d0VMaHJuV0xucmM4aHZhMnpocTdJOWJmcmZBN3ZO?=
 =?utf-8?B?azl5ZXg2R1JYaE9KQUhBVHdIcVNyWERaT2xOWUMyM1IzdDlVL1FtSUE4WjM5?=
 =?utf-8?B?a2Q4L0plendxS3Q1OUJsVEExZnRsUkQwUGFBeTRzb1lnakFGN0I0MjBvaW5T?=
 =?utf-8?B?cHVMcXJ2Y3Fqa0JJb3JrK0xGd3kwcURMR2RkMHZrVUtVamdHNmg4OEVHMWJr?=
 =?utf-8?Q?ulLtA9zfrEM0aNZKT9I+tMwwoxVRFAZeFOLHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3lmcTVFVFhoYUNWRXNtdUFncnFhdnE1UXUzVnF6MFh0czV6Q3hjSFFvVXhH?=
 =?utf-8?B?ZnF1QXo0TjZ0VGM5NitiSFBRWHd0V3EwbVQxeU1EZnZ4RnRubWdVbVI3U29x?=
 =?utf-8?B?dzhLSit4amx6ZEpscjNRbk0vMkhaNTBzQkdmMC9ZcnloalVBR0pHdWFTcjYv?=
 =?utf-8?B?TlJTNGI1R09sZTFqaUc5c2hoUW83ZSs4TFQvMzdBRS9rQ3doNUE0RHRtZGxy?=
 =?utf-8?B?UEt1cGU5dlQzYXZaN0V6NWxZL29oQzlWc3VlR0wwZDBRNlNPRkc5Z0lzRVNL?=
 =?utf-8?B?aUp5Zk41UGZlY3gwL3kzMjRDTS84eW9ER0gvRklrZjI2dWhML0M1UUw2WjMy?=
 =?utf-8?B?ZnZhcTR2Q0x5TElSYXd6MStwLzB5cStmbU5Kd3p6a1pwZWZ4WEtMZ045eEp5?=
 =?utf-8?B?Wm51RXFhRG85Y3ZxUCtBeHdNRXdwYUtqOVl6SSs3Y3NxbldaejhudlpNeE02?=
 =?utf-8?B?SGdxS2I0YjdYYnJKd0lrM01rZHFXRklvUVZiSEo4VFhHK0FIdUxjL0QzbkMr?=
 =?utf-8?B?V3I2SXJ5MENFZ3c1SXBzV2ZzTHlkbkdkMW9oNmtKbVJGSXEyZUFIL0ovakRr?=
 =?utf-8?B?L0habFB0N3QxaW9jcGVDa2t1b1FnQmZibENvK1VJN2RBWWZkQVpYUE9YNHlt?=
 =?utf-8?B?N0JoYk9CN1R4clhTdUtnWHUvZ25pYnJpa0p6S0c0RjZ2V0RFNHVDQzYvVzVx?=
 =?utf-8?B?ZWdMYkh0WjFtVTA1RnJSakhzNkpkUWU5NTBBTW1RL2o5ekFaek1CK0cvZnJh?=
 =?utf-8?B?K1lWbTVFOTVwRGhZc0d6RE12QytZMVRTaTExdXNhZkVDQUVtSHBYdWF1UXpK?=
 =?utf-8?B?UHVIK3hmRkh1NWYxb05UN01ZY2dQekF1d1F0SFhRWmFRdEl5c2JFeWQwclM3?=
 =?utf-8?B?VXlFNkF2SHVTRURYL0QrbGxqSkErUHNhbVRFT3R0L1EwRGc4UWtkdWc4L2xH?=
 =?utf-8?B?MlluOWhjU0UrRTdId1VNeW5iVXo5ZkZSNnZob2QzSXRncHh5cm55QUNrUFcy?=
 =?utf-8?B?V2pTdTFBenFFWmdQWGhFWnpTbVNTczR4N3ozcmRlMDJadWord2dqRFg1aDIz?=
 =?utf-8?B?c2IyS3R2TkFkV2VETi92cXo0SWk5U1Y0OFZYQU1IWnAwdkJLcjh0NnNJZExv?=
 =?utf-8?B?MGt2UFhnV0RKU0VEbXRXaHppS2pCd3E1MmlMYjc5UWFGRnlmc2E5ZEhuUFB6?=
 =?utf-8?B?MDV3cUhhdHNxclg5dUhXMkp3SU51azZGbXcvMEkyWENmMkR6dkNGYkFHSkcz?=
 =?utf-8?B?RTlZUVA2QktnMXlvWHNlS1N1ZnBEQ3I1dUZsTlJXNlV5ZDU0SDJSaTUxYW1r?=
 =?utf-8?B?aE5sNWw1VGhGQjQxTjVYRHllYTFBeHV4K1BjdFZLclRZT25GbjJuenV3VjRX?=
 =?utf-8?B?MDBDM0tNRHpUbTlwZGNqbzN4OUZyajdoeXgyd1Ziem84V2tvYU5XN2RjR0Zp?=
 =?utf-8?B?UWg4OEg5ZzZLN2Z1eHgyUk1QVGdRMHVhWWdac2pVWFIxZlVlMlQ3bDR1Rmsv?=
 =?utf-8?B?NlBEWkhoSEhINGhablcyZWJjSUhxK29XMGRkZ0orTXhBUWhRaklxS1dYUkIv?=
 =?utf-8?B?czNteTY5c1dSdGVUWUxxTDlkRi84Z0loT3BYOHNNM3JobFlGcDV6eXBEZFU5?=
 =?utf-8?B?bU1rQXdDc1NLY2Zvc2xPZ0dNaGdjcFN5R29vdEZCV1ltckx2bXJKVzdoU0xZ?=
 =?utf-8?B?QldUbGdYdVBUWExkZ0xJWU1TbU41ZHNTdG83dUw4LzBHdmFwWm5FRVhVclFU?=
 =?utf-8?B?ZWhXQ3RRZGdZdjZScVMwTkhFRkVMUlN0T2c0bDY2MlZEK0dSWTBQN0tWZFhq?=
 =?utf-8?B?NFJkODZxNjFXYmJxZDJ5ZU1Gc3k5M090Y1drS0tMdFZqYzJ5K3NJbWEzZlFy?=
 =?utf-8?B?ZEVkTjFJdTVqSjBZYTh0dkVDVlRWSC9MTktDTlRXak9sZU5vRmM3d1g1a2NY?=
 =?utf-8?B?ZzZwR21iN1ZnYTUwNEd0N25hSzV1Yzc4Sk1yOEM1d3VJMGFSR1E1bzVQcFhC?=
 =?utf-8?B?TDcvL2ZsSDZ6L0xYRWFIM1pkMkt6OTlqT0RaWEhqNzk2SFhDUDZTVlplcyta?=
 =?utf-8?B?bW95b3Y4OEFHeTBqSFlhR3NURjRPWFhzRFlpOUJCSWdLamxqaVY5alYwa0lX?=
 =?utf-8?Q?4/EkT/VqZT9a1Zaf/uZ+5obC2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c522e243-4b9b-4637-9eed-08dcf4fe28aa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:06:02.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8q0OGNehJJ0igO1/lFbEtWFhxohNKyIK9753VC4D4xUAKt6kXdQ6mXXOFW70UQJTk0RNo7u4FpPHkhESXiPyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7327

On Fri, Oct 25, 2024 at 03:52:58PM +0200, Geert Uytterhoeven wrote:
> Hi Frank,
>
> On Wed, Oct 23, 2024 at 11:07 PM Frank Li <Frank.Li@nxp.com> wrote:
> > Fix the issue where both 'output-low' and 'output-high' exist under GPIO
> > hog nodes  (rst_usb_hub_hog and sel_usb_hub_hog) when applying device
> > tree overlays. Since /delete-property/ is not supported in the overlays,
> > setting 'output-low' results in both properties being present. The
> > workaround is to disable these hogs and create new ones with 'output-low'
> > as needed.
> >
> > Fix below CHECK_DTBS warning:
> > arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtb: sel-usb-hub-hog:
> >    {'output-low': True, 'gpio-hog': True, 'gpios': [[1, 0]], 'output-high': True, 'phandle': 108, '$nodename': ['sel-usb-hub-hog']}
> >        is valid under each of {'required': ['output-low']}, {'required': ['output-high']
> >
> > Fixes: 3f6fc30abebc ("arm64: dts: imx8mn: tqma8mqnl-mba8mx: Add USB DR overlay")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Alex:
> >         I have not hardware to run it. I check dtb output is correct.
> > ---
> >  .../imx8mn-tqma8mqnl-mba8mx-usbotg.dtso       | 29 +++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> > index 96db07fc9bece..1f2a0fe70a0a2 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> > @@ -29,12 +29,37 @@ usb_dr_connector: endpoint {
> >         };
> >  };
> >
> > +/*
> > + * rst_usb_hub_hog and sel_usb_hub_hog have property 'output-high',
> > + * dt overlay don't support /delete-property/. Both 'output-low' and
> > + * 'output-high' will be exist under hog nodes if overlay file set
> > + * 'output-low'. Workaround is disable these hog and create new hog with
> > + * 'output-low'.
> > + */
> > +
> >  &rst_usb_hub_hog {
> > -       output-low;
> > +       status = "disabled";
> > +};
> > +
> > +&expander0 {
> > +       rst-usb-low-hub-hog {
> > +               gpio-hog;
> > +               gpios = <13 0>;
> > +               output-low;
> > +               line-name = "RST_USB_HUB#";
> > +       };
> >  };
> >
> >  &sel_usb_hub_hog {
> > -       output-low;
> > +       status = "disabled";
> > +};
> > +
> > +&gpio2 {
> > +       sel-usb-low-hub-hog {
> > +               gpio-hog;
> > +               gpios = <1 GPIO_ACTIVE_HIGH>;
> > +               output-low;
> > +       };
> >  };
> >
> >  &usbotg1 {
>
> Note that after this, there is still
>
>     /delete-property/ disable-over-current;
>
> left, which does not actually remove the property.
>
> Gr{oetje,eeting}s,

Yes, but it should not impact much. I hope Alex or other tq-group's
engineer can fix it. I have not hardware to test it.

Frank

>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

