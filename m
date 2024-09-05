Return-Path: <linux-kernel+bounces-317774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE8896E3A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74D6B215FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD6B19307F;
	Thu,  5 Sep 2024 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1lPkZA9"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013055.outbound.protection.outlook.com [52.101.67.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FD3D6D;
	Thu,  5 Sep 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566799; cv=fail; b=NEr2BXWaX3zWAwwokosEDN3Gr1Kje1OEGphDPmqPmTukvYChdRp9Dd2hgn3rDDJvD++RN543lg2LsA2lZCSYaqcDNvhRT3hH4AR4CzUV81s9zoFPpXFRZT0CenSpX+DkuY5VIfUkbzjf6faUyJMEYE5TiwV/Kq2Rq+56gn2/+w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566799; c=relaxed/simple;
	bh=/OavMWLX7l88fbxJ3viXlld87bMoMI9DZw4+2I94Kcs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=AyaFf36zTPDgdYgTk91wTpHMjfwUkKKfBiv89AAbFut+2xqMcRwI6X9n9C9jwm0SeVIz9Z3RAUbGXiH9PjUBAfzzkEjJbWn94t15Ef5fnWZiqAb6nL3MPW6Y0ga8Is5aMkDrghNBRNTaOV1geu8+mOOTCbp/k3lHhjljZo2Ak50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1lPkZA9; arc=fail smtp.client-ip=52.101.67.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJlsVVCHx6rbdVkiyWe91ONkl4qGORq+A8akHGSJwd1T3iXCIHBwhQJABccIiciY/flzzdixLX3yrB98dQJXVWRmwGRSzPxtSZBUNRqjS4DBLAETD8DpEbbawYK21nWY7W5oPszv2klSCyMhwlAJLRCCw6P/UyR2sNduireidr5e5UM12dvmnRL5KHEBi/NtCY5rV9TuTDxIbAmDqF0V5FrkOmF0dVQ68hcm8uGX2pXZtpaGltaLsL/K6D7lFlkXzlmjRLD1AtQEHUqZIwRHlqYSRBGTkcqvHjQSxvHfTOR7nZTl/AsEViPSPjPa3iFmZrUV6tBZVPqGmYPNnW64rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBoVh2cW9Np/RSbDQMFx6DinRYhxgLCE6VsqhDryzLs=;
 b=ZkPR8otX7tMgqenMP/Sn2nabnBc1/FzQkg7yDLFYKLf1bVZB2CAYNRgjBVXPKy9pEdxHgUAM3dVG5ntGmju5GkUtUdg7LdYzwWkBZZ9OmzIHutyRK+UMYX2bNzaVxQEVkJ1uCRQBC+k2vkcWdNMec5LBdVEn7mHhRxm0+fZERHc969+nFenNIouvJEmmr/WbYZz3VMwaTMFzeZh/I5yMfO2sCWRubQZM8zwjga5ivPa/UpWsT2mem4SO2SCoAOrUPHyTdVd443e9DpOS24DdF81n4xyEuBGKZ2Pk46WdLEZJq7t9qSA7x6StFzWi+iO3ECen+cOvEj4Rb99D4qsnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBoVh2cW9Np/RSbDQMFx6DinRYhxgLCE6VsqhDryzLs=;
 b=M1lPkZA9GQS7j10ChuTS/x638dNyRL04OxbgClL8FZQyb9azupCsV8Ybn5bCx8Kucc6fP4F4FeOJEN0hH/kTlCPyL017n0JMydBUHhknSannWVI8i7wfGlzWxEECNgkWnLxV/hHXoaMiRaN36nnWCLHT2/a3dLRgsjlenFJgdh5B20cPznITf3o5PwevgNlxmMq8bBfwX7NnfMl0ZVFW5HMgUGEguz4/SCOhuT5JfTShQXqjwTvzrb7DtOE7BQn8Bi5rUgDYrBAifgHLBxvfzZYQqDcMWzYkIlgwJvl56GhUAjrkMG5c62DpNjhf6EXxouY2GtCOOkxw2IJrHo6C/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 20:06:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:06:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/3] usb: imx8mp: collect some improvement
Date: Thu, 05 Sep 2024 16:06:18 -0400
Message-Id: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADoP2mYC/1XNTQ6DIBCG4as0rEsDA2jpqvdoutBxrCz8CTTUx
 nj3oomaLr8Jz8vEAnlHgd1OE/MUXXB9l4Y+nxg2Rfci7qq0GQjQIpeSVx/k7cAraTJNhCYvJUu
 PB0+1G9fQ45l248K799+1G+Vy3RKwJaLkgoM1ZFCTIrT3bhwu2LdsCUQ40BX2fyMsqABbZoVBq
 PU/UgeyQu9IJaSktTrPVUYoDjTP8w+7TwfsBAEAAA==
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725566789; l=1558;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/OavMWLX7l88fbxJ3viXlld87bMoMI9DZw4+2I94Kcs=;
 b=BthTsnJ9EI4PDlS/T5pPNQII9fHOf+c33yA2VBQuRRtjHdm7T0ffhScWrs+64bg/uehIRDoEs
 lwIjbhgFr3pDtb41LC2ttpl5NofOigMor8K3d4xNYpxgVXORrOtLChI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 847f8a62-bb05-4b6b-0812-08dccde63d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE9RSGJXMHB1RndrTnQ3TE1DMlB6YjhPdEQ2THpVV3I0T05sOFFkQUdSWS8v?=
 =?utf-8?B?a1l4R0FlMjdITFVrVGpOdGdqb0MyMjFxaXZRYXhjR1lxdlVmYjZMNGpMZzBY?=
 =?utf-8?B?enJ4YVNxeWs4VGY1b0JaU09YSWNtYzl3NDVWQUF6aGRIVFN1dE95U2xTU0F5?=
 =?utf-8?B?cGZwd1VLYWRDOGdzZjNSRjVKRnZsWFY2b1dtWFJ4bThkaEJUdnRyVEdja3RM?=
 =?utf-8?B?eUJQUmJjeG5pSlJWVWNkUmhSRkdweFNHMEtFR1BtOVlDekR4MDE3S2NTNHlq?=
 =?utf-8?B?d05sbit4WVpkeWltaWYzZmZIVVFBQStYMU1WYURRZlpkR1YrYjBGWjRHTklJ?=
 =?utf-8?B?VS9HbE9Sd2tSbTI0NFZ6bkVXcU94OTgyeGFtNDY0YkYxcHBiQkdGRjltdVhD?=
 =?utf-8?B?aEJORXVIalMxMFhiME4wTTVKYmlzWHdBdlgrcmY5VFpGaWJFREg3ZjVxM2xw?=
 =?utf-8?B?SnJXYmt2bEpmbWViTEl5UnJPRWpqVEFHRUkxbHlUOE5Jdk9yZ0pqd3kvNDY4?=
 =?utf-8?B?bi93RzE4ZnJEOTFoVjFaUTBHb0RnU0hzTWs5MEY1SHZYSWZJTWVPMUZWSGRm?=
 =?utf-8?B?eWtvOVByZ1hrYmp3Umg0TEtLZHZhR2VrcGNrSGdKLzFEV1B6V2FSWEFoRlk4?=
 =?utf-8?B?dm5PZmlQVm03WlVkMmxQdWo3SmNrdU5lNFQrZFJBbkhjS3pJeEo3ODdHNkFr?=
 =?utf-8?B?bC9QS2pIMnJzUHM5cTZ2NjRac05OQXJlbUdXNlh2aEw2WmxHTVlQRzhyZERs?=
 =?utf-8?B?ZVROaFJ4eU8zbi94aUZZN3V5WmRnU2EwY3RSYUIybWZsbk11N0FLdm9FSkFC?=
 =?utf-8?B?Sk16YXdsSUtvWUQ4WmZQdHlQazVhRFoyNXRVd2xOdkxxSmIvbGZDV0NDQmxy?=
 =?utf-8?B?Zmk2clJGMnkzQWlkaDIwZGJTK01hS0FzTEVtWVRhaGpGS0tJSlJsM1E4UU5W?=
 =?utf-8?B?MlNkZytBdVBZSld3SExwbTBDdDhYR0dzR083bW40Wm54a0p3Zlo5dlhLRFJG?=
 =?utf-8?B?TDdQWUVqZDRVQ2I4ZDBOcG1IMWp0N1JZZFpsU2NXV01EQTI0Sk1VVnU3NjdW?=
 =?utf-8?B?bUdYOUFZaVlicjZieTZHbkNyRkEwWCtmTThoYUx5TDRxWFhTL2ZpQ1pwN0tL?=
 =?utf-8?B?U3FyT251MldNbTR2VEs2YUZnWU5zVHRKaGQ5NktGWWM0SS9sQlF5bzV3WTVp?=
 =?utf-8?B?UDBCNks5Rk9la3gwMm05VGhwN0h3OUdvcFYzdCtYa2FEbzhBak9KNGRVajBI?=
 =?utf-8?B?UjVOaitUTGlzeGsxYjdFc1hWVUQ2NG5PYnZlTXoxWDhua0VHbnF3bHlHOEo5?=
 =?utf-8?B?TEYrTFNtY2FYS0NobTFGeXMrbXRCWllSaUprdkpxdVNoVkJPZlNuS3prV3hW?=
 =?utf-8?B?VFQ5NzJ4bk9MV0VmTFQvU0lkVjRiaitCbTZpWjd3V2V4RmRnQk1Ra2lJMkty?=
 =?utf-8?B?d2tiTEpDUFlEbWNFQWk4RUp0YjFsNVZOazkzMXNvZnhua3VBRi9NMFQzUW1Z?=
 =?utf-8?B?SkloU1VQTkhDanV3TFIzcEV5eWtRRVdsTDRucnFtN1ZhUE5ObnFSZkUzOFpF?=
 =?utf-8?B?aFRGeTBSQ2k2OGUxWktGQWd5TUVMVzEyV20wdEhXanZTRm9vMTY4SExtbUsy?=
 =?utf-8?B?VFJzUXdKZWlXL0N5SG4rdkgrelNVdmRqa3JiSFlFcW9jZEk2SE1CcXlzdlhU?=
 =?utf-8?B?TmFBSUhMRWNZZEx2WnZvZEV0RWJVMmdrT21wUmRqMVJrWmtKSlRVNFNoUjZo?=
 =?utf-8?B?djd0L2NBTmtzcjhJZ3BQWjNvTkRjbWx6Z0JiWUJKR2tTS3ZkWU5mZEZVcVAx?=
 =?utf-8?B?cWVzRWxuaXFMenhOTDd6WEphUUpsb09TVzNzaERpTm5PR1htWTFma0JzQjRQ?=
 =?utf-8?B?ZVJ4VzB6SGNUc1VEWDJUKzJlemhKbUpTM1AxRlcxNWhDOFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1ZQSS90V2VERkowckZnWThqRnhwNnk5dzRTNDBGNzZ2OE43M3RqZ1JIUktQ?=
 =?utf-8?B?SlE0SmdFMWRVWEVRbk9lVmVYdzdQQm5pMHZnREFkN01wQkpYR09Cck10Rk5U?=
 =?utf-8?B?dmdMMGhMbHNSbzVRWHZXQUJkV0NTVnpMWGVHalVtK25mVDZMSmZCNXpZT1kz?=
 =?utf-8?B?alN2aTBNcmVFM1NhSEYxZUoyWXN6NXB2NkxsWjA2eVV4c1BmdTlzMXdRdXpX?=
 =?utf-8?B?Y1dBSm1VMWNZcHBxWGk3bE5lS25uWDhJenoyak42Z0dQbEQzbkhtTUk0S25P?=
 =?utf-8?B?blhKZHQ0emFjdFlQS2I1QTBhZy9lWWJUQjRuSHArRUcyVTNKRG8zREFKbGNa?=
 =?utf-8?B?aEdTbnFxQ3BwNDNWOXVSRGdHVm51Z2FKRmJFM1VJNFNEMzhuRm9ncUxJYmdW?=
 =?utf-8?B?RkpwZ093SythczZPd3h4TXhzVjJua0szZVN6K2JEK1Q2WTEya1E1dlNRN0Jm?=
 =?utf-8?B?c2ZrZnlvSFNVYWtpVEhrZEQ1dkM1SW8xbHduengwaWdoLzVZTkJLU1YvZlRV?=
 =?utf-8?B?MVV0djYxeW8vTDNGSmZlQ2ZLdHZYdUFtWTlCWVFqSXZ0aFZzTnNqSHRsV1F4?=
 =?utf-8?B?V3ZhS2dFZFpKN1VxTkQxN0Z2R2NKU3B4R0hlYk5LckxiNk5ISXBTSmRWdHpm?=
 =?utf-8?B?NjhyUDUvM29EN0ZYMjMxRFJyYXBaa2JMQU5BWmVMNFNQYitKSUsyUC8rYzN3?=
 =?utf-8?B?WjVWcExWaGo1TERsK25FYVFZWnRhTlgrL3hrRDR6L2NIMk9qanhoTDFuY2tO?=
 =?utf-8?B?UFZrNUM1MFNGNmhrdVdhK0dwb2FhWWlzT0Y0Y2VnVDB3YldJdTF6QnpRUFlS?=
 =?utf-8?B?bWlLQU9sbzVKTUQ4dno4RVp0SlJTd1N2aGJHcWk2L0JiRDMwOE96cW9YNzJo?=
 =?utf-8?B?T0tla2lVaklROWlWTzFKYm9waU9qcCtPeno2bU45SmU4aGRjNVY0TnZEUU1M?=
 =?utf-8?B?aStZdWJSdWxob01qMWVScUZkc1hPVitWc09qaUU4bFM3QXh4dEZFTzM1dHJj?=
 =?utf-8?B?S0cweUFiR1B3eE5BZGNpaCthWlBCWWI1SWtEUnpXeTlHK2NXcEhuWmN4SGVs?=
 =?utf-8?B?SFY3UzR6MHpIZ0ZrMHJyREE3ck1YejNYOWNXa2dObnBaMkhUblBVY3BjRU5W?=
 =?utf-8?B?NTdLVmpWRE10N3doN2hOQ3gyZzBTQUtJZy8wbFd0T1BmY2VRdkNITW9EYjZC?=
 =?utf-8?B?WCtRTGxMTWFhSWJTbjdJY1plZXVNRk0yNk5SWHUzY0F4aUovTmI3ZnUydkha?=
 =?utf-8?B?bk94RVcxUHlFZGhMMC91bVFienJzZFpjSkZ3bXg2MFJGOENIb0VrY1VlcGtL?=
 =?utf-8?B?R1RRZTczUU5oOUpaK3Jwd2g1cmlmZFR0Y0lMcUdQMDJRZjRjcmNhOWNRQ3BE?=
 =?utf-8?B?dUZQQVhiVG45NzFIRWwyYVB6OGkxOXRjR2Y1SkFUUVozVlJMUWZZVllnMmJH?=
 =?utf-8?B?UllYNUMvdVE3MW1YMmZwdjJmQkJDd0haWnVYMEdyT3dyM0ZVUnpoR3RVUFRC?=
 =?utf-8?B?SXE5akhCaUIyR0p0RHRMZUFpbEVVOWhZS2c1SWZhNm9VNjZyclJhenlOMG1i?=
 =?utf-8?B?djV2SE5iZDQ1ek1mQ0pBL29ubEZqQ0ZYTkVJWis0REloRGR3eC82bjJVTU8v?=
 =?utf-8?B?QTlzWE0vN3kyQjNCUnFqa0xlY29hcEgza3hGU201RVpBT0tkQ0RkUFhwTEg3?=
 =?utf-8?B?MDA2cW0rSTlCQkpjYjJjRmtGcnFiQ2lLVk1qeVdXRWtDRWFuYnYxSHNzMWdj?=
 =?utf-8?B?T3h4aEdkZGM1T3dZbk1nMmJueGlxN0hMWk5id28zMGxXYzFIUUZTS2M3L0dK?=
 =?utf-8?B?d0VxcjRQQmxMN2JvSVpVeVRXUnkrSnU4S01KbjlCcHVlYk0xSGlMd3RsZzYw?=
 =?utf-8?B?dGlBTDNwWEhhTUVOSU5MOFo4dzd3U3JLb2JOdWVYc0pqQ2w4M2xOVURsYnBS?=
 =?utf-8?B?WDNHdnNtekhSVVhGeVF0aCtLMXBrbHdrMlpqeVlVNjAvM1Ivald0eVR5SHdB?=
 =?utf-8?B?SXlDNkt3c21XN1NoVkI2UEl1RnZLcUxDd1FONEs1UWZTeWhBMHlvK3FWSE1l?=
 =?utf-8?B?MXp3Tno2ZmY5ZjN5bWtaRDMrek81TWdpY3IzTDVIL0t0QlB2b1NTL0dZeWNQ?=
 =?utf-8?Q?VvDWP47uWejFtOMr80df8/NWL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847f8a62-bb05-4b6b-0812-08dccde63d35
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:06:33.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSkcnZcT+nwIGfAaD0O0k5a/LiMiwWMOsClgGS5bKTV2xzbSZlzHf8RjdrKjUurEtij1mDYgS9IfTW869oSfYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423

Apply two quirk for imx8mp dwc3 host controller:
 usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
 usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Runtime pm and wakeup:
  usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Rebase to usb-test
- Link to v3: https://lore.kernel.org/r/20240904-dwc-mp-v3-0-319947736ec0@nxp.com

Changes in v3:
- see each patch
- Link to v2: https://lore.kernel.org/r/20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com

Changes in v2:
- Remove patch dwc3: core: add a core init flag for device mode resume
The problem can't reproduce in latest kernel. pm_runtime_get() in irq
handle return false because run time pm already disabled at
device_suspend_late(). So runtime_resume will not happen before system
resume.
- Link to v1: https://lore.kernel.org/r/20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com

---
Frank Li (2):
      usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
      usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Li Jun (1):
      usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

 drivers/usb/dwc3/dwc3-imx8mp.c | 40 ++++++++++++++++++++++++++++++++++------
 drivers/usb/host/xhci-plat.c   |  6 ++++++
 2 files changed, 40 insertions(+), 6 deletions(-)
---
base-commit: 9c0c11bb87b09a8b7cdc21ca1090e7b36abe9d09
change-id: 20240711-dwc-mp-d1564eec57b1

Best regards,
---
Frank Li <Frank.Li@nxp.com>


