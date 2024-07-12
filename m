Return-Path: <linux-kernel+bounces-250861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D522E92FDBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550B21F21D74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE5174EED;
	Fri, 12 Jul 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RKHh1nqM"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C61741C7;
	Fri, 12 Jul 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798858; cv=fail; b=fy7ijR6C0EvFmilqlmxFYZ86wFiEH+YoQtl8WMlCL99D0g+EDYM/CEWSU7OSxjC6D1QOL834ay8DlMcd47if+3PSfg6JqW3ruj8qFHDpPKKjJvIpIv1mWuC0SfdB8lrdaRRI9dHXIchI4+ShxSoYhQzhBzokDfuNDmu0wNcQ/3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798858; c=relaxed/simple;
	bh=OPMEgo/PPVAH3sDsMsvf6tFyCZJh0Wh9SpXjFlyjVQQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TN7E7GfitDtjS6MIg90OtWN2A3DzfV5iZgwzYvCMiPxQnKdrhw0r7pkk3IaLcWNRS/hwZaV4I4hacSwj44DnqkKi5Tcr8+BJhJpXV7jYGvyC/hTu+GCk9vlrFKa72uDpanSVPoqvE3SKRKKu+9LA3Gz3LgvQ0jxBiG1uITnkONo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RKHh1nqM; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=to1FKDS5KTJDs3gxeR5/zcwzbcuUV8vYVxz0bcFVFrji3kxn6Pkm5vr0dqZxh0oIkEEsaymDgbzQhCGYbDKhI9lvBgtlA5lpJlhxTnNabteBoXhE9GA7ZyrYnF5bgVviIk2mA0IqneGhMEsTv2l/fXc19XpMN1hZxB71LEkoWH586IhlkP+gnoxZOuI23p60YE8jxvopNMXz7BWX2qhREFJGgHicxrE6yQzbhTa1RlpExZUTFLs1LBUGgAPfKev73APH+la+f9a1DPQVRtjUt5+odVH5MzSXQx3x15oQH7Nz8OVj8FwZIkKzuoF9XLKqBeCVOCi7Nr34+v0FAeulrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FGgaU9IlyBHq49XF9k5+aS5ZI1cv/6PvMPvqC36+xQ=;
 b=XA0jKdaOOhdNA/IooFFmpBBXG0M2/69AeZEotKUKLKMSpmlxI/8BMivG0ogIoGXnLCZ2oCXxORtsdob85sVIKXimZqfsHA6ejBxjxwg+Tv7EjJotslZ4EKdl46j9iOXQqSxyeXzm6cXH6lbxaVcOPzt9F4mQd98BmLYbAz85N/5tnALrYTRrGZ8dB1ghwa20iUoq1o3HKuBO7fGDZGwI/HKIYquZxL3TOzVZhzaX271xRCAF5M6HQC42wGH2VZtCH/jHjSVMftU51t0HC6B23uLIWj7CWE6M4E5Fo2cNXeUNE9bwMCWwbJ8WDgZMPuL0MgmRghW6fgJLpJoCHVEqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FGgaU9IlyBHq49XF9k5+aS5ZI1cv/6PvMPvqC36+xQ=;
 b=RKHh1nqM5se5d0jTzhvlheP7nJOnnVYLzKhODUyeR1rENIR3ldQ4MRcIhn4RKKbiGrtvO3iuSMkJK04NhTvk6432CWwfTl+UzzfI9ASv33UyVVTj4Ni/jyAfbypq78wkHmP3bQ3bcwPDiMQy/05VRZ6o6+uqHNMq+x36vGABiHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9803.eurprd04.prod.outlook.com (2603:10a6:150:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 15:40:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 15:40:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Jul 2024 11:40:27 -0400
Subject: [PATCH 1/4] usb: host: xhci-plat: Parse xhci-missing_cas_quirk and
 apply quirk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-dwc-mp-v1-1-295e5c4e3ec9@nxp.com>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
In-Reply-To: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720798845; l=1035;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OPMEgo/PPVAH3sDsMsvf6tFyCZJh0Wh9SpXjFlyjVQQ=;
 b=79kQ5gU3I2Wiqp8CjL+FmnXYIuNnY9o/3nwzGtu3pavtkPJTO8rBSBzRnWEa3bk5RbM33/nKp
 9VDJBUZqjxUDZ9tmKV5LNKVDZRERRTlEU3k/lx5nNMXQ2XjdYmvPtxl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 250b3e2b-b990-4c24-a2f7-08dca28902db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFlFOTYyNkh1cVNqZk50YlJvc3ZUaWx0c1NXTVhvS09FN2xsMkEvQ1Zwa24r?=
 =?utf-8?B?UGd1eHZxODhzdlVhZGwzZWcwblpPT250Wm13TVhPd3l2dmJYK0ZqZHQ1YTFH?=
 =?utf-8?B?Ykh3dFNuU0FENzhLK05qRnpMV3VkSmVNNlhUYTI4a21QTEpxbDh3V3FuMkpo?=
 =?utf-8?B?V2FpOXNOSEJsT0VqRk00LzF6K00vcHpTZjdZL0FmbXZBbkpGbnB3SWJLNkhs?=
 =?utf-8?B?Nnh2MU84ZU00bFNWWFQ3aXgxc24rQzBnYi9HZTBZWTBwcjhVdlh0cWFYcGxm?=
 =?utf-8?B?L2ZkSmxFUWVPZlUyeUFNYjMxSzZVcUdaWnlCNnBEQUtoNG9NUCtyL2RtWkk3?=
 =?utf-8?B?UElBYkhLSElIVndMem1DejJvSHJNRlBTdTNLZHh5VDVPSnRsa2ZFbGxrMFVQ?=
 =?utf-8?B?ZzFwMWxNajhENzV2YmVJYW1YSXhIZFVVSEl0Q2QxWnkxazJNcFVoTmFPVzQ3?=
 =?utf-8?B?MHozcjlOQ25lbm5KZSs1a3I3L2lCMjNPV0hSdVJoT2xObDZNYXo3ajJtZmtC?=
 =?utf-8?B?OTRZSGY2ZkpxZmRRRG84alVKbEV6STdmeG8xMlVUVGxYUzA2MVBZUnljaU5I?=
 =?utf-8?B?bmVWTWRiQ25NQnRGSnFIQWdzL0FYMUs2NlhQY3hlVk04Y0hNc1ZidUdMS3Jk?=
 =?utf-8?B?amJlN2RPaEE0RWNKekZydE83R0EwZDg5dENXQkhwWGkrZC8xYlRGTFNCNGR0?=
 =?utf-8?B?VTVmNjJBbVF6WXNKbnVyVXFCY0lsL01GOWgzWU8vVkNTYUl3bWRwdlloUFRj?=
 =?utf-8?B?dS9CODh5MWZWaldwNklDL0d1UU9ucFFhaWd5aWltQlgxRTQ4aDR2Q3Z6U085?=
 =?utf-8?B?dlFSdHVMVEZoSXVFWXZHRlBhUUkzM3N6eGF6RVREQVhma2c4UU5vMEpOaTdU?=
 =?utf-8?B?eE5LMWptbFF3MXpoWVE4NTJkbFY5ZTZLdXdtT1JDNGlXc1htTHRhTm1kb0ky?=
 =?utf-8?B?SHRyb25rSU41WVZuK0JvWC93R3lrN0EwNkZNempuNVRvRnVRUTFoSmJEb3BC?=
 =?utf-8?B?UjJIaU85clcvU0REK2tvZUE1TjdIbTNZL2RlWGhOcElHQXFEa3o3WGZvUHZn?=
 =?utf-8?B?cXRZa3dvUkYvQU5KVjNuKys1MVBTMWJuZTd0cHNsK3d6RDl3SC9mSm5FZWJu?=
 =?utf-8?B?akQwMjUydDRXc21yRWkwQ3NKd3VZekZmU2RMdHFlZ0RvcW9SUEVRWCtXNHA0?=
 =?utf-8?B?QlNGSnVuZnh2QlhrM2N1ZitqK255Wnh6K2RGOWFndjlUdjdMRmFpdk9PM2R2?=
 =?utf-8?B?eitLeXp2MWpMa1ZPNEoreS9PR2NyU1dSaENLWGZiNXBDSkRwRmNqTnFDeWhz?=
 =?utf-8?B?Z0RKK1NwQjhQOVNlOXBkelBVRE16cWZ5N280VUQ4YU1HVTlZUDFNekhFczB0?=
 =?utf-8?B?Y1FvYnZHTHlaWFlnbmZZclhDYXN4am1oa25laDZMSlM2L3huSHlYU084NUI5?=
 =?utf-8?B?YUZWZjdvMmsyQ2w1a0ZWTmZBMXVSSStqd0J2OXhiRHBvUURpVjlxT3VzWVQv?=
 =?utf-8?B?b3dJdVdBNEg3eVhRZHlhN3hPeUNiUDFpY3pCRG5LbnJjaUlESzh2L29rTy9G?=
 =?utf-8?B?cXNaRUpuaDNJdUlaZEhEWDY5WjJ6N08xVXMyN3JqTFgwRkNhMUZjSTF4Z29v?=
 =?utf-8?B?ZlE1Q01wNUZseWwzemJveVR2Mm9NRHYvS0FCZGkzalM1UlI2N2NBZVBhSjdG?=
 =?utf-8?B?c2crSElLYkJyRlhQcnE3eVFCNWxITUkvM09nQXVCU1lMejZaMmVpQ04vaG9a?=
 =?utf-8?B?bGpuY3hmVkl0WUZIVHZXNlM4YlBOVCtBNEZGU2hJU3pQd1ZWSGJhanpnRlJS?=
 =?utf-8?B?UGY0WWJQeDF1WFo3cTJVcFFOc3krbCt6RUhFM0JLM2tsNUFFdWdkQTNCdjBi?=
 =?utf-8?B?eFVKTVByVjg4NEVYc0kxdjBjQ29xNEdsVllGUVo2UVI2SEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVhUFliQXE1UURIazd5NlFleDdUaDlkKzhaZmVtSGZjcVhEdkh3SCtsNmMv?=
 =?utf-8?B?NFdnbnk5NUtpY3U4OHVjcDA0WXkvQVBFK0Y2azJjNi9FQVpFVytuN254VWdP?=
 =?utf-8?B?Mld5QWFoeTluZjNqS3JxVVFJTlp5Z041eHdEZTRVS0hjMDBqbWdzbTlpdmlB?=
 =?utf-8?B?L0hIZDV1bjFxMjR4dXZpMUZVSmdyZkhWWGxYa1FtTDF1MkpYbTFBTHdXVTJx?=
 =?utf-8?B?emVPdUM4eWljV0VTSHpnOC9kTVlHbXNCVy9GQWtQZFlnNUpvc213WFl4NUZV?=
 =?utf-8?B?N2tYTWF4VUtyZk1nNGJMeEFuRnF1dFozbFc2QVRseUZoUGVEcnIvbzhSY1J2?=
 =?utf-8?B?TlFyZU5PdzBPOXJKSVVPMXlHV002SkJqYytKZ3h2NWJLdzVRaklNOCtRY2NT?=
 =?utf-8?B?bHJ0L3o5eC92aXZpdXVwdTFPcjkrT3V5UFNDcDgvU082Z1ZUSVJwSWtMQmdu?=
 =?utf-8?B?ZngyTWo2c3NPdElwWFpDUFpGakVGRUgra3I3RmtNSCs0RU9lUDNiTmdNOXZ4?=
 =?utf-8?B?UURscEJYOWppd1NaYzdlZ3d1UENPdTl3VzVWMGtRem1jUXJuL0hwcVlMOEV4?=
 =?utf-8?B?cjVVdVM5UWVKYUdmRVhPbXBjRVIwblpNMXRDVnlCZmN5K3QvSnFYTlR3dDk1?=
 =?utf-8?B?WkV3blczWDVRbFBteXlwNkxkSnBSemx0cTRyTVMrYlE2dnduVWI0eU5FcVk3?=
 =?utf-8?B?YjFibUY2b1M0czY3d2pPTnBQS1ZXQzc2OTlUV1kwRU1NRTNvVEVNUUF2aUFZ?=
 =?utf-8?B?THVEMjlMSGJwY3NEeUhvUjE3WURKRWlUQXUrZTRTNWxieUhrSkZUY0VRMmNT?=
 =?utf-8?B?dC9naTR2WlFlYzdMMGRrVWh1NjZjNG1Fa3BLTHloVnlSb1R1d2JTbzR2TEl4?=
 =?utf-8?B?QXhzWUhOS3FhY3pJZWM2bEpNeVpxUjc5bS9Sd2ZhZGN4SGZTSDVlUGt4MEFp?=
 =?utf-8?B?N2Q5VTBZTzV5eG1yRVdaNmRGVW14bUJLZDBxMmNkWHZyaXVhNnRBK0F6WUVl?=
 =?utf-8?B?SzlnT0hRSFByU2IybGlnRTdrSDkrOXppbnB2WlhnZ0gwcGkyWHROanN4OWxO?=
 =?utf-8?B?QUd2RnJsZlAvRmRMRXdJSFIxMFh3VUpWQWhZSU9ZbkpZTDZwdGt1Q01yYktv?=
 =?utf-8?B?TmlQS09yQWNJNTdSNjBHM21aU2c4dWxTZDBQbXhWTWtzd05EQmMxWU9XWTI5?=
 =?utf-8?B?NW9qaCtxaS9nbWxaMFhrMUVMYTlGMFU5M3BkcnI3ZVEyZEZydVRPUkMvOHZC?=
 =?utf-8?B?blFwWjdIN1JOVkpmdHJSUlR5eEttL2NSVU9YSmVnSm1TdUpPY2xLVDBMQ2pE?=
 =?utf-8?B?WEduekJEQkk4UlZyNnlZa1FMbWRIckZvblJKMGdVL0VLaEs0V2dNc2hhMmds?=
 =?utf-8?B?eHhTR0pzeExLdm9TYVV6TTYwTnJZRVVQakw3Mm1zR2tPY2FTUDRaUjY0QnBF?=
 =?utf-8?B?Y1d5WkJhZktQUkh4MHRwdEM5ZGY2cWJQamNUUUtnQnJ1a2xBQVU3OEJFMzhB?=
 =?utf-8?B?MU03VEhqUHd4N1J4OGVReWV2T3NIZk9WSDZYU3p1QllwMXV6MHNTbStEMDNH?=
 =?utf-8?B?SHpPL2ZKLzVyckNmNnNURlpMY2tFVHkyZWdFeDZWWDVxY1ZrUzdIaVlFbjFl?=
 =?utf-8?B?UzV0eGc5OHJyWExNSW9TSThMZWVHbjBnYnptWUlGSy9ZdjBreTRic2FCcFpB?=
 =?utf-8?B?SFA4VnNpdXBnK0RyMVpscTRNRllEL3hYNUtQL0MrVGxxZVJNd08rSDg2U05H?=
 =?utf-8?B?dkZlbG43QWlDRjREV2VFaGYrVjFQTFY4b3hMZlJaRXkyZ3R4aWFTb1U4Y3hB?=
 =?utf-8?B?TVIzRCtPQjRuaE9WckJnZnpYd2MwbDdxY1pkYWhqVWFOYnR0Q3g4aEJxeDVH?=
 =?utf-8?B?YlJVbGVnQVdITHJjMHJuVmthajN6WlFpT3ZFaG1HS2FJYU14SnlHZjhlbU5N?=
 =?utf-8?B?em5mY0g1ZVRscm5JMHJLSnZyUUJXRDE0UTdFMmVDR1hSRDlQTXAxelhKWllE?=
 =?utf-8?B?aGhtNVBTdDNvT01EN2xlZG1odE9XWFlyRnNpVEFrWXdGQ3lUbjc1bzF2K1JY?=
 =?utf-8?B?Y3RmdzE4bUNLOS9VazZsbWdZa2k5cFNXSGNkVXdBeS9wdTEwSllxc1h1dnJS?=
 =?utf-8?Q?Xg1zRIWYMlUX5s6hUn78Ig0h9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250b3e2b-b990-4c24-a2f7-08dca28902db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:40:52.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kkJ7rmX6Q97+7fWvl6oByOXjPFh/vvmZRz90i4le3Z1NJOFdr9v2p5ftKK6fs6/XGm+7gtU8Pl765DaQjlucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9803

Parse software managed property 'xhci-skip-phy-init-quirk' and
'xhci-skip-phy-init-quirk' to apply related quirk. It allows usb glue layer
driver apply these quirk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
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


