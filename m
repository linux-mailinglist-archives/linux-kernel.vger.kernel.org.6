Return-Path: <linux-kernel+bounces-319212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A34BF96F959
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C59B21F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7811D4617;
	Fri,  6 Sep 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OTQlKcYZ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013045.outbound.protection.outlook.com [52.101.67.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898E1D3638;
	Fri,  6 Sep 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640258; cv=fail; b=A7oZfs1/7sLQO3HqQLJyCwp05XLmEOWusq/U7tL+VFalSqdUc0v2uQBw2N8h6ALvgt2NLropDyDcC53stlnzDosEACe0w+ExocT2E5NJmgDdC8N6mGXt3F41XdGWaprexAB/lTvfx1Wu5s1plB0rAcvxMs3K+q/GYDHUB1Uebas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640258; c=relaxed/simple;
	bh=NubeVKC2JY+Edf4txeZQvlzij+Dl1DAys0Z7etoxmSs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QrJEe5VPd3Z2DH7ngQ6Fsgl5Rfu1TyIsrVAlLjmvhX1teLBefNA8zgPhGDkbyEU27TH3UgGztdAsJ4SVUdE/K3mzg/wxbDTtqLTft1Kv+WRXeTzJSehyDGkOSTKch0OBODs9QRcf5w0z4Qk1w+3CdBrohD/qtbs6uTaDP6BXSc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OTQlKcYZ; arc=fail smtp.client-ip=52.101.67.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzIVIhGaMio4iGzqAK890uQ2E6gQgRzKvTBcuo3CyvywsWIQsIYQILEnGJGoFu8RDXaXiixxWdN8WH0eIr34/grEdnSaawfGSsKABEKdn0vhJLLJr6Hml3HVL131HmkeXlMcRgZNA1K/8CD8aO7q/5ArDvlxy+OZZXfzXtpXWSuzanT9alMw2WLRaeAqjaZNCSr4ZkQYAg3PgN4j2GbXFEM2pizcmdWnnV6hqJwdajqewi/osbFkWYF2dqZDwAq40+vJXT9blTwgrFYNUeU8VXhDCYRDJkXd8yPtqYl3V7+DaTEbb6qsEnThPUuroaqUp2RQpTJWPuG7zJWDi5eB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzoMalRqkFItVzURXs+rS2zgBOQ+B6Nns8zGt7uifXA=;
 b=I8e8TXOr8YzsRXlpt5xJ3quRphnWOhveXz0nncq2kqLK1HMpzqnoYYfbV7v+vCtNSiW6zXnRK6YejbCLc2mfjuERlaW67t7RZVXsb43abkvOvXmW9OQFyl+wkAXw1wHq1t4kV4njzN3zanBIezu6cKCPFvcVF7d9MrbP5pUA+8n6x/QjRNMZh/boD9ZtOMN+GboI2fEJfLFssb/3tg/T4XOffm9YweNK0LV89+Sc/iflYYQ8sQdRvm+mciqiDqAZctodRSq4cyI54xN7KDyDJpwvGGn8dltSxmw1XYNH4vfbbeF38/6kz6R84VVd+tfqYgDmnwxBSd6J/Kq6Gk87Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzoMalRqkFItVzURXs+rS2zgBOQ+B6Nns8zGt7uifXA=;
 b=OTQlKcYZ0Ur9imHV2U+Vzh8vLVG3F9UwZ0BYITLxbHEUExyyHBnZ9gsAs2o+4hE00p7qpd3SxrRmrxLUHHzNC97O2xE+W+MGFHWOgmWV3q9Qwo8xasaDOG9pKiXh3pzwGskwbtjLgPhMxoQ+IpDIDMfpMSwvqmLU/Q1DVqKKp4m6WyLqRuFaojaMlWapYlEwyUgdIw0GTwIy07s63YmYPEODwPgL/7jgOPUXvzPh79ojPPHu7DVcIpncKRNwNjp7PVI6Q27VzR3Y2YtUAnR6zl2Zyoi/0ofQ7EKWEZ+g4W6JeLFnppfNhc095lm3d9pgVFI/UH5Ratj7Kp5t2HSG3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 16:30:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 16:30:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 06 Sep 2024 12:30:37 -0400
Subject: [PATCH v5 1/3] usb: host: xhci-plat: Parse xhci-missing_cas_quirk
 and apply quirk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-dwc-mp-v5-1-ea8ec6774e7b@nxp.com>
References: <20240906-dwc-mp-v5-0-ea8ec6774e7b@nxp.com>
In-Reply-To: <20240906-dwc-mp-v5-0-ea8ec6774e7b@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725640246; l=1070;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NubeVKC2JY+Edf4txeZQvlzij+Dl1DAys0Z7etoxmSs=;
 b=qN/04TfyCco+wt8mwN+joQFtEjr37HCYbV15R/2lrou0j8Y9CzA7CphWiZSyPQC2rrukGiVXO
 49LePCHk6RSBEDN7TdPaRNyk40UzL3nsrurimTazol/I/ACJiB7620u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d37fc07-287c-45c5-3eb2-08dcce914777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnNIeFpXbENQMmRzUzVRTWtWcTFTMy9QcHByWnlGUFRFQnVQVGtzaXBLcVhm?=
 =?utf-8?B?V3JlVHR4amkwcHZrSXpGUVJZRGcxQndvYng3eVQ5WTZIRDRpYlpONURadWFW?=
 =?utf-8?B?akF6cjduMjdqRkZQMFRTckdZQ2JZRS9ZRE5PVjV1ODJzQ1lzMWRPbHBwVXAv?=
 =?utf-8?B?aTRtU3FOMHVNcHl0ei9yVEQ3cE1CeFYzR3VQWms1TzlkRVMyN3ltNEprUjJR?=
 =?utf-8?B?eFBMVXZrbU9sUkN2TVA0OGVyMzI1TVJPNCs0TjZuTmVMb2d6WmRnNXJ0cTEv?=
 =?utf-8?B?dHpqcGRjRGFGUlgyMlpOUm1vdTgwYjc0WExKa3I1TVJoU1BLVHFyVTRhejBm?=
 =?utf-8?B?TjZRSTNZR2JhY2pnbXpHV1dReitxd3FNQkxmc0M2aFNwVW5jaTBqNGdCZWE4?=
 =?utf-8?B?MWt4SWU3L05UNFpWa1Z5MWRqTU9XcFg2S2NnVFJEVy9rRDJZelcwdHV1TVJt?=
 =?utf-8?B?MjRJeWVORXhrdktWYnlpVEdva3FVbUNVNi9QVi8vMmoyYkdWRmhaSy9WWUVU?=
 =?utf-8?B?RVdUNHY2TnlyeFFTOWZnbCtxU1g4NHRWblU1eVdMRE9iS0hkQjVldTFMK1l2?=
 =?utf-8?B?aWNSbUt0Y1pMQTdtWjUrMFJTZ0NJUHY4SnpERURLakU2U0pWOS9TQ04zRWN5?=
 =?utf-8?B?bFpvZEk3ZDdxQnBDRFlWdlVqNEJSZGdkMWpIc2dyNWNOMkZGY1llaUhTRjgy?=
 =?utf-8?B?Vkk2RlBvVzBYRUZwSTRCM2ovWThaY3RSU2tzWDBQMHVtT3c5dUpjd21rY2lw?=
 =?utf-8?B?Sk5KMCtlUVo5OEl0QmFJbGF1WjdsWS9GZDk3VzRaSDh5SEtoVGN2MlV2NmEv?=
 =?utf-8?B?VDhPVk96aU1ta25BeFVtV3VINTZRVmlUM1ZGRnR0UVBqMEhoOUc3aTRtaGxT?=
 =?utf-8?B?VzJEKzgrRSszSWJraEZiOTQvemJVOUdGUUxtbllxUUNIL1d6bU11a2E4anA5?=
 =?utf-8?B?M1lGU05KemR1QStVNDE2Szgvd0RnSG0xdnhlYnA3ZjN1SDcwOUZ4MVpibWlK?=
 =?utf-8?B?NHVhTTIrZnJCVHV3TzUvVDZ2YkF2dDJFMEZWUkhTc1RBSWsvZnBXRHU3RThC?=
 =?utf-8?B?MDdwR3JIOFlqT3dqWHN2NHVtNDEvZWFwdEh3aGJSeW0yR2RNaC9VR1lzcU5w?=
 =?utf-8?B?SXpseVp6Y01PcURuY2ZGQW1HUnlQd29HTy9QT3paeldGalF4WDZQUHFsRkxq?=
 =?utf-8?B?RmZKbzI3b3A4Q055WkJUUGk5eEowOGhqa0NJUTBsR05rS29kNldsbFdPa1JE?=
 =?utf-8?B?OW10Tm5VS2ZmRWg1RlpoQkZ2VjJyeDRKOG9mSnRiR1lHTEdBRytxL0IyNkY1?=
 =?utf-8?B?MGszK2tPNWJJYXpCYkdBcmNEdkZVV29nelZuY1I1Zm9RZ1FIUFlGYkFKYVl3?=
 =?utf-8?B?YmhxRmF0bWErUnEvTFVoVnFwdXJTSEVjVGd6RnFZVXJ6RHB1NTdQM2l3R0Nq?=
 =?utf-8?B?NEt2MFFsMk9wWC9xbFVhS0JFc2JxWWEyS1FIV2Yxd1pxdnJNcXI0S2JJRUpw?=
 =?utf-8?B?TDhRNHR6MmUraGpOWW9GYlJqWXNxQWF2V1JsRm5UaW9CL1B4d2tUbjhqUEp2?=
 =?utf-8?B?R3FVU0Ruc200L3lXOTFqRWViQlo0cE8rdWdiY3h6YUFTUFRhc2hINVF4SER0?=
 =?utf-8?B?ZDA3eUpMdnl1Z0FDdEF5ZDlqTXdxb2g1RTdFSGFPNjdaQWpGamtPb01BRWw0?=
 =?utf-8?B?NzVpeGNyV2pwU2Q4ZExJeVhIeTREQ1prMG11Sk15T3d6bGh4Um1MUHJjNDlr?=
 =?utf-8?B?VDN1RGdrRW1ybUp3ejZKTjBvdjZJTHJDTyt3VVRPUndOUkcyYzhJVXhjT3Fl?=
 =?utf-8?B?RHJXWGFNL01lZzBwQWw0KzZwWmQ0TVNSM0h0QkpQOVdNM2xmaWlGcXVkbkxB?=
 =?utf-8?B?WVB4WHBNQ2VKcnR0MjFtUUlhRUhEYnNiVUR6UDZPNHV0RGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXM2eVNSWG1CdXBOYWFlUXVPckNpNlQycitjZTl3VmZRZWhROHJObnBDV3or?=
 =?utf-8?B?TG5HbWNNV3diekJaZU5KMWtKekNkOCtJUnNzWVdaVmFHckgrNWVmK28xc1Yr?=
 =?utf-8?B?TGZTeUg4ZmJZZEp6VysxREMxYWtEVm11aWF6UGpGd3NaUW9uMmNtNEZUWXZv?=
 =?utf-8?B?allqU1JBcnpIT1lNT21USEQwYlQ0bFlEdnk4alN1ZEd4VnpIV1FML1VUa3B4?=
 =?utf-8?B?c2k1ekJ3ZTRYOXp3K3EvZkZPZVdodmhJUXpLS1lTZ3FOTG5iU0NtMFdtZnVH?=
 =?utf-8?B?OGJBTTJIWjFGTVFzZmZ2WFJCb3N6NFR4UWdMUy8yTkJpL0NEc2t0cHFXOWRN?=
 =?utf-8?B?UUpGWlpHT2NFOW9ESndXb2FNTDJxNlY0ZzZ1V0xwZlN1dk1oQnVuVlMzTi9h?=
 =?utf-8?B?bDQydGtiV2NpVjhYSXA5REFOdWM4ZTRZa1gyd0M4R0l3Z2I3K2FEVFluK1RT?=
 =?utf-8?B?N3Q1UHFJRHEyM1BWTHZBaGdEZkVaNXlQZkJmK1ZIZW5JNW1FT2JNZldSR2R4?=
 =?utf-8?B?eDcwQ09qZzBWNWVkQ1BHZE5mQnJoRVlZNWZRWGNGL1B6L1ZiMlRsd29ESlVF?=
 =?utf-8?B?bEFJODByY1RiYS9YL2lPYWtEWUc4Z3BtZjVNM240d2QxZmxiT09lOHoyMXJ2?=
 =?utf-8?B?UlFJZ21XeThWTXVZWDY4ZU8waVBEekJqR1JDR2UzazUxQ2pKODRpVU5nK0lz?=
 =?utf-8?B?ZUtlVEdXbUgzd1FvU1ZSRWN5Ny9xa01ZbFozYmZvWlhKZzFjbE1rczdDeGZp?=
 =?utf-8?B?M2ZYU0pkRXZlSWRhNGNFYXNYdFUyY2J2M0RYeEg0Y0xkMk42ME9uZEVWSDU4?=
 =?utf-8?B?WGNyU0Iyb29WQ0M5RXk5bFFDZkY3bEhKcVpUeXJKSThpRHVodFR0RFZEOGhC?=
 =?utf-8?B?K2Y0UXN5aThQblArRzVCZlc5ZGNQVExvcEEvUzhLcHNrTjFyMmo2RjBDSWpP?=
 =?utf-8?B?eUlmTGpLNTBibnVoVXVDaU10cXJxZWorWnUwY2VBZXM5VERjc0JQM1JOV2or?=
 =?utf-8?B?RzBCRks3OWJWV1E1TmNKTytlcVlNYUlSMU1rSVJEZU8wUGFxUmlHYkNKN21n?=
 =?utf-8?B?bEUzU3ZxeUh2b0pyZHRFY1F0eFBUeHNteEJ0Vm9EYkkwTW5BanRobVAvOEtU?=
 =?utf-8?B?ZVYrSEFlTXkzNEpYTWkzR2d0U1R5U1hJUnc3MXF3TzRDN2wvcG9ya2FEYm5L?=
 =?utf-8?B?bnNjWndsQ21ha0Y0WE5helZLb2haUXFOK2hmdXpzNG9SeTM3dXd6c2I2L3Q1?=
 =?utf-8?B?SFd0WVF0anh2TTVZRWhURnJ1ajZkVVFrR3V2Z0VLcUZTNVBha1YrOHBjWS9q?=
 =?utf-8?B?VENFeXFRejBTcmIxNkRLOXFXd1VXTlMvRUtpNTYwdzBIZlRrMWFGVnB5MXow?=
 =?utf-8?B?YTRYWHdvWklVV2h4Zld3QzRtSkdxaEZ6UENtTHZ4azRJeEZDdjE4SEx2YTU5?=
 =?utf-8?B?MzUvWm9OVTFlWkJpalN5Y1VvbjVZLy9zNk1kcmxpTUttT3haUDNaV1FYMkF1?=
 =?utf-8?B?T21BdmJwcXJSUFFVd21OWDRac0paaS9OWE1pYTNWR1Ywc2s4NXdISnNuVENC?=
 =?utf-8?B?a3ZFSHRNczFoSDEyc3lZUDkxaEhTUXFQSi9mQXZJSVNOMzhrMVBObXhDK2tN?=
 =?utf-8?B?NkVNaTExY0JqSENJcFJ4dk9tSnhJZlpjeERGdk9xbXlmYlY2Qk1pOGJBRENK?=
 =?utf-8?B?T1ZvMjVqSzIwYTdnR0JrVTJuUDNib1B4ZGgvaHBuZGpENHNubnhJOU9Udm5o?=
 =?utf-8?B?LzBVSVRHZkdrM0hxc1NiYzdZZUNNdkphblpjYUQxcFljTnZocEdXUCtFeTNL?=
 =?utf-8?B?ejd2cDdZK1BGVjEvWlZwUUZhT1ZmT0dNeUo1VlcvQ1ZEUTJSb1ZSN0hPL0sx?=
 =?utf-8?B?L05JUFl5WE1YcmkydTFpMWVKejNQYU16RG9GSDFvZXhZbGRNS1RGa3VHdVZC?=
 =?utf-8?B?R25WNWlNRFRSR29SMWFPeFJ0ajFJWnZhZHBOMDNKbHN4VjNvUXpoVmdvMnpI?=
 =?utf-8?B?WTRMQkpQaXRIMEdnc2JzY3k5RkVVdTFrZU9XK01nY0kxMWNPV3dOcHFuSjF5?=
 =?utf-8?B?RWhkWEp4bGxtbGtDK0tTL0tWSEloUUpCQndNS0hYOU9MUDVkSGtKMWRjUkVv?=
 =?utf-8?Q?cS1Pv2erqO+Qo/7n93PRZYHGO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d37fc07-287c-45c5-3eb2-08dcce914777
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:30:54.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5AWNFP6sm/kK8Zz6SBcPDECS8GhTb7iHCoDWyT9TeJwofK4zqLRp4YYrOWCqKhDDe5DHb3K5o1163jTwBegrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405

Parse software managed property 'xhci-skip-phy-init-quirk' and
'xhci-skip-phy-init-quirk' to apply related quirk. It allows usb glue layer
driver apply these quirk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v5
- none
---
 drivers/usb/host/xhci-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 31bdfa52eeb25..ecaa75718e592 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -259,6 +259,12 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
 			xhci->quirks |= XHCI_WRITE_64_HI_LO;
 
+		if (device_property_read_bool(tmpdev, "xhci-missing-cas-quirk"))
+			xhci->quirks |= XHCI_MISSING_CAS;
+
+		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
+			xhci->quirks |= XHCI_SKIP_PHY_INIT;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}

-- 
2.34.1


