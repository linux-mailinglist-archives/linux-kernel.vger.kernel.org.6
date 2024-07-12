Return-Path: <linux-kernel+bounces-250864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B71392FDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B290EB23753
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653451741EA;
	Fri, 12 Jul 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HIbO/uNk"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298D1741EB;
	Fri, 12 Jul 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798868; cv=fail; b=q75A6BRz7cjlwGrZOsWJCLsA0uDsd8sCom8+5kotlc2TeJ0NDEM3j2sdY6YuRq1gyqFojoZqIwLU1dBj8/l+fRjGHcVypTE98y3e8NWGHT4fVnk+o5jEhOLgh4rCzgOG3fO2LrRHvrfV6Rbx5bSrnholFRC+oUxY6fBVeXYP1ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798868; c=relaxed/simple;
	bh=KZVlfOTIefgB6kiTQwKkq6g+Kg893MkWvMwdF+odVUo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FTSPNCuIS8aZ7JVaVhP8IqWFqw7Ln9ksaIRF7NVBwYvxwGZzKtdXCxJSUwztV4Oef5DhopYdOlop+1ahf5n/8Bwpx5HaQ87WoDbRUremmS/a4cyd/xckOh15iwekTbqdaq0hr4HA04Tm0znyF9tsISyCwkFev7UKWl6ihmOUN2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HIbO/uNk; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWntMa057cvfi1L6BFtVHpxmL4y2us7uVUL6gLReCn+Mm0T/3N1UOoz053OEBNXzK0pkHVxv89yCFZ0/HAuzeoyl+s+QuRyYyRbIcc9Je6ViObYD3dKpZHPTO7Pie9+xnZVCKhcl1m7xNoO6bnjP3HUI5DMxR2qPBfQsejq53+jk5TWkmcF1KrW9iA+mJlrM/e7yN8I5Qr3m1rpG41k0kv704tCjTdXdkEqXw5BEYz2PeetoVZ/Cm6/aRjBmX4Fzp4DD2RIztjvIY2rUOc/tsgV5ZPWe9MyPTJjRSxYLXqxq9C0e6PZ5ZvCpLRhg4MQEv4as9GrF8i8EZ2wENF7Psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e03HWMjyVXsG8PkNe0yFHYiSkt4HxQVPGWPZkD0srTU=;
 b=jcSAU84lwbzSWK/C4ygNeNa+ADZI3JFS6gAyYk6wfn7wdenCLW5aWtAJLHEX5HMpAbKt3YdQwwqnaV5H/CsIZmCaT89d0OYzHcBOl/y+cKIfcKmoEKZ+KBNAJnRbjrXEBsDBR5tIOhDO/xlEJicswG9y1fa3wN2FyyOOUfpPj32JBljqAPlo01EB/ZMUYHAOfjNS0fjqE22S4MiVWUvKhZMQDOuimY0uGVG2K3whDNqyYiPJ82j5L0WPS39ElPklyli3V3EQHhDMZhmLQ1fLcNdr/wmx72mYtljJOllveiDx9tAvsHLGd6FV52I8VC8SEGFHHjdf8HgAlmMe2a+H3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e03HWMjyVXsG8PkNe0yFHYiSkt4HxQVPGWPZkD0srTU=;
 b=HIbO/uNk0qX6SsudA+f8d3ule37OC+nLmp6u68rqZzPPnxfenlXb+EibaFrIwmsJX+4+B0IZn8hT5vPv41xSJ29f5jaYi/e5BvDFlYbfNJzr7mGMkfK8EigEBxAUkJmDakdCwi37Vr59Bj+17fXguWZ6OkDwwr8o3Sqh1Z/aZlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9803.eurprd04.prod.outlook.com (2603:10a6:150:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 15:41:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 15:41:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Jul 2024 11:40:30 -0400
Subject: [PATCH 4/4] usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for
 system sleep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-dwc-mp-v1-4-295e5c4e3ec9@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720798845; l=2073;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VbRag4/639rtFHwlkO1MlheNQd7FvEZ1sV+cuNpxmC4=;
 b=aXc6+SKCt/4bwS6Zek2nqH4bdndGgx9KXOmBz1W71z9gwBV6qag3PRIX/QItCzi2m9plPeidC
 3+EXNN1SP0XCi8Gvt8xUt9ETK1Eu2ykXgJFvffpU6x0nUSd9TH+LqxF
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
X-MS-Office365-Filtering-Correlation-Id: 4f439cca-63cc-4e5c-2116-08dca2890920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0ZYZVdQQy9HV2ZXVS9rUmhnVnZKdGlhVmhCOE1XeHhvWUhnZVdxT3diRndt?=
 =?utf-8?B?ZHZWWm1TZDQ0eHNtWXNmM0xlM1VPWWlLWXJFdGlXTGNNaDJENXJoZGM0T0hj?=
 =?utf-8?B?REowREt2Y2xFaWRWUlRFN3BVc3lOUlNiTUh4RE1RNU9pYTJXVGlHUGo0RWRP?=
 =?utf-8?B?a2JmWTNKM2h1a0VmT1RybStvUkNQUDZENnhwR1o1YVNteFQ4YW0xQnVJbFBs?=
 =?utf-8?B?RlNsOEdkeGViNWQvVllWc2tuTDdwbytnUVNKYk1FZnZzVzZhMEkyK2p1RFNY?=
 =?utf-8?B?TGplcWlBR0VtRUt0U1ZwU3gvQU9SbENBaSsyMHVyVGxIMEFCOEZ2SHlZUXA1?=
 =?utf-8?B?NjI2WDJFaXozT0tHQ3BhUU9md0p2dWhGWm5CcVlwOERmU01CbEtvcUg5V2JJ?=
 =?utf-8?B?RkJrZnVVY0h4MWdhdkxUbEZNRWZiaVRHZFhKbVdYUHA5a1I3R3lTMmhCQWVB?=
 =?utf-8?B?a3JrV01uU1d6M0c4Y0ZQZWNpLzFFY1lwVVprKzhtQ3Biamk1UW03RmhGV2Nu?=
 =?utf-8?B?TVlpWmFqb0hpUzZPdFQ4OXF2ZTFoSzMxZjVXNEV4SWRUYVN2TjF2cDkxZHhh?=
 =?utf-8?B?Z0ZneEJzK3hxWm5HanVjaW5wdVV1UTcxMGx3QTBJcUNDS01LNTNORmZKdWNx?=
 =?utf-8?B?OWUyUVpWMytGTk9QYVdMUFBDUXhzNHNEZXpoR3h4eVM2a09laEZlS2R2bXd2?=
 =?utf-8?B?MUY2UXhNUkYxSGpaMVRnYnhPT1dEcGlNZjhucXI2TG9GV2xoMGRCVGR3NjdI?=
 =?utf-8?B?SGEyWUZwd0liaFlMS1JMK0FoaDlDclNjR3AxSXJsNmNOTUV2aHVTZUV3M0dQ?=
 =?utf-8?B?WDl0YWg5NnVwMHBlUEp5cVl3RTlZTkUyQXZaaU02QWdoaUNBeVZRV0N6dEZz?=
 =?utf-8?B?cjJVUnlsNzdJdzdKM21Ic0tmTUZRUWxzcXZYVjJJKzBVZ01hTDVRbmpmemtm?=
 =?utf-8?B?bGxuSE8xa1lNK2JZVit4aFZoZEVqQTUxUzV4bHA1alNoZWlweGxMYVYxUlNq?=
 =?utf-8?B?UWJKS0pTdFJ3TDBiZnV0cFJyWnpXdnZRY0RGc2JBOURCVmxLMFIrU1dPc0pj?=
 =?utf-8?B?aXU0NlMzZGJPSk5kM0ZCU3BQOXZLRWg1YytJN2x3d3dFVEJEUWNXdHpPWEtt?=
 =?utf-8?B?Z0h6bHlURXU1Z0NaZ2h6OTRJVW80V3dqZnduOXJvOTROU2t2enBmOXdQMmZP?=
 =?utf-8?B?ZEdnTTE4UUNnLzBSZzNrcG41T241NkpwS2lwUDRIM0RiVTlScFhZaGJ5QWlC?=
 =?utf-8?B?akNqVk1jdmpzVTU3QmpkME5qVlA0N0t6bVFmNDJkMTdYNldHV2pHMFdIblpp?=
 =?utf-8?B?Y2oyWnNDMFo0WC9Lcy9nYWRCSzNEVXUyZE9JcGZ3aWtrUHdoMWQra3cxeHlw?=
 =?utf-8?B?djF1ZHRybkJjOURaa3hUWk1ibTYyWUtGeExwc1FyL1dPWlhvUHVScDloOFJN?=
 =?utf-8?B?WGNBSFY1UWNqaXp2T2dsZWxmQVd3Z21xQnAwTFNnVlZtK3dqQlBFMExvYnQ0?=
 =?utf-8?B?S3VVOHJLMklPeGFraGcyaEVLaTZsRndoSGxxSWxSaDVhRVB5THNMclEvWFI2?=
 =?utf-8?B?aXl5NUF6S2JiMVZoalhxM3ZKbGdtZGUrUHBGOE1INW1udEZZRVRYc2xLVkJX?=
 =?utf-8?B?a28yeThXU210RGRCMGdIRUwveGNSWHlYbzV6OGRoSUxyV1hoeVRPdjRhSmhW?=
 =?utf-8?B?NlUrM3RjQ2NFSDE1bURXUHA3akxIWUt1TFdJRTZ3c3huS0Y1eW81NXRoUG1l?=
 =?utf-8?B?alVJMklnSXk2OG5XSkJyTld1NXdzQzFZWU5vYTEvMkFKU0YzV0cyWXJraFRP?=
 =?utf-8?B?ZnA1aGhuYkJmTkVrMkVXRHBmL3YxMkVYN3gxVVNTRFRlN0xrMERrM0NDazBT?=
 =?utf-8?B?bXphbGNDUkxOT3hQRkFXanVYTTkwZUN4dDgyQTdCRzkvWmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3QvVzRYbVZpTEdOTEQxVGMzRytUc0V3R2IvQTVGWWM1YjdqZDhZTEViOEc2?=
 =?utf-8?B?M2txQzdUNkxMN2drZndQaGFMMGdUQ2JsRE9Va2dzd2hEZmVJY0xqZ2gzTDdW?=
 =?utf-8?B?cjEwdW1JOXNGVlhsTjNjR3EyRVNNYjNlNk45UGxQRkcxUTlkaUZNdXRXQjVn?=
 =?utf-8?B?aE8rTllvdnUzYUI3VXV4V3NmbjZ2YVFHdXh5YTNxRnZtWmI2UTJQOG5ISXFz?=
 =?utf-8?B?Z2xXQ0ZLT1haYlZRRGxkelRyVlZLaDUyNjkxLzcyOVhSWThRUnNUMWN2NmFn?=
 =?utf-8?B?UkpFbnRzOU5yYnVBYmwwUUp6NFNnMWJkUnV4UVVEV0VUb0pRck1EVFErYUF0?=
 =?utf-8?B?Y1VOMGpBbnRDd3F1SXhGLzQvV1VjRnFobWhsenNlZHJ3SHFIaURWREJENkNM?=
 =?utf-8?B?ZGp2bzdmRWMrOTFYa3JURG1Db0Rwb1Nybi9FRzVXVkV5azViRWxTZm1yRmRm?=
 =?utf-8?B?TFYydFZlY015anUvZ1ZhZlhtZWRVY01BbDJGN1JVY2JnYk1xSy80NUhGQmFh?=
 =?utf-8?B?aitzWkt5a0NkQWpneDVnVU41VnJHcURjRkZOQkx2c3pxOFJzbU8xWTFnMnRO?=
 =?utf-8?B?K0l4VjA5a2p6a1pIMkJVMzN0TG51S091dGllWFlxa2RvUTFqbXowa2YyRU96?=
 =?utf-8?B?T3VrVjVlR0gvb2NQa1pFRFR0cGVQeXk3NWQ3YlBtRFBtZk8ybEExOUlrQmhm?=
 =?utf-8?B?V2ZGL2Q4MlY4SG1NaTRkdk1lSnFLNkJXTGtweDBwUnVPUW0vUnJySVRubzhJ?=
 =?utf-8?B?T2dkSkJkZlo1cFNwVnJkNmtUTWIrSXF1Vml2Y0NVRjlxZ3V4TW5vNGI5RkFF?=
 =?utf-8?B?RzEyU3ppYUkzZExmN3NpZEx5dDR5WlVFbUFZQ2xlM2l4U28rK3lEenR6RlA5?=
 =?utf-8?B?VkZTdkdnQ1RPTTgwbmZnUXdlYklWaG9uelM5ZWxUMlZZYnJwWG5EVEtlQTN3?=
 =?utf-8?B?VDh2Um5KQmgxbW1qVEdXMVhaK0lnQzg2OFFPQ2tKQjBDejFlYUMyam1vNVBn?=
 =?utf-8?B?TVZuQ2hXK3o0dTBMRmtqWFdvWnB4eE5PbCtxRjZBUDdGSjY5MFpoaUpQUHVx?=
 =?utf-8?B?VnF4YVRySzlKeVg0VFA3N1RIRnk1MmxxY1RidjV6cnBMa1M0SEtxQmlldm1o?=
 =?utf-8?B?cnBTd0hDSjEyeHZqR2ZveGRUcENyalZvY1VjbnJoWFp6TW1OeWF0eXI1dU5H?=
 =?utf-8?B?ZDAyN0xlVm1XcWlzbzZhUGxqMW5OMUNRb1VhNkdKV2I4QTlZZUtQaG9Hckgx?=
 =?utf-8?B?ZjczZkl6UHh1KzdYeWRwOElKdEtOTEtUUDd5MkVuaDVyK3pCQklMNlZad05S?=
 =?utf-8?B?WjZESVdxWmRjbDFtUFR3Z29JeTl4OTZLdmZBalBVaUFsNEc1YWhxVUFSclRJ?=
 =?utf-8?B?QlFvZnowSzFkN3hBUVlnZkRuekF0UGZrUFdJUlZmVlJDNTBHWEhOTTNtVzRI?=
 =?utf-8?B?RnBMT0wwUnlFRC9PQ0hPdFVmYlB4clRqUDZTUlR5aGJtMDQ5bHZxTWh3Yllr?=
 =?utf-8?B?dmczWXBMK2hHZHNpUFh3QUlGK2VKbDcvYlRMbUxnUXArcUF4ejI4bGFuazdB?=
 =?utf-8?B?Tmx6MFQ5UFM3Y2VjeXgzZlhKQUI3QUhCYzY4Mi9mcTN3c2hHb1lqVktic3NS?=
 =?utf-8?B?MnVXb2laQmlVSWxqamVTMFowUFVQTUs2Z2NPS0hJcE1KK0h3RGhPTjd5cVVO?=
 =?utf-8?B?dFBUVk43WCtsS0tBNUVURmIrYnZ6RkxtOGwvSGJCR1hTTCs2aUc3My9DSWk2?=
 =?utf-8?B?MUpiSUhPT0ZKQ1hPOFlHUk84eE9sWlQyRlBhazMyOFVLdGxUSzYrd3pDSk9h?=
 =?utf-8?B?dlA5VDlFdEQ2RHE4M2hEWFJLNHVWOVV0TFBpUEF6WFgvcG52aVNXSU55eDZq?=
 =?utf-8?B?S0hEc2Nmb1g2blYvK3U2VGM4MWJNcERYUzZoZVFtQWtlaHZ2WE8wdlRaQTdO?=
 =?utf-8?B?N2JpTzljOHlvaitFYTJHdm52MzFJSVpBdG9UVmV4QURjYlk1Sy9GM1l2dmRW?=
 =?utf-8?B?NTV4MExvQjhqUE1mN3hwMnNocGFUdDRRSTVic2gyOVFLbzVqYnUzUUJ3N24y?=
 =?utf-8?B?aGo1MG1WUStiZDZ6blhKWllwM3ZjK3pBTHVBdFZ1RW02NTljZzNGeTNyVWVZ?=
 =?utf-8?Q?Vv8E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f439cca-63cc-4e5c-2116-08dca2890920
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:41:02.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXpT3S7RNDPMPwxtYFX0CeAB6gAO/hL+m1lZ2mmDn4ck+H7QJrIcpHMu+Cg9Cq2aKnKmGsK/5VuTCV5MT890oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9803

From: Li Jun <jun.li@nxp.com>

SS_CON and U3 wakeup need 'ref_clk' on. iMX8MP turn off it while system
sleep, So disable these wakeup source and only enable DP/DM wakeup source
for host mode.

Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 5794bb75f7604..9f8c34d09a8e9 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -96,7 +96,8 @@ static void imx8mp_configure_glue(struct dwc3_imx8mp *dwc3_imx)
 	writel(value, dwc3_imx->glue_base + USB_CTRL1);
 }
 
-static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
+static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx,
+				      pm_message_t msg)
 {
 	struct dwc3	*dwc3 = platform_get_drvdata(dwc3_imx->dwc3);
 	u32		val;
@@ -106,12 +107,14 @@ static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
 
 	val = readl(dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 
-	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci)
-		val |= USB_WAKEUP_EN | USB_WAKEUP_SS_CONN |
-		       USB_WAKEUP_U3_EN | USB_WAKEUP_DPDM_EN;
-	else if (dwc3->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE)
+	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci) {
+		val |= USB_WAKEUP_EN | USB_WAKEUP_DPDM_EN;
+		if (PMSG_IS_AUTO(msg))
+			val |= USB_WAKEUP_SS_CONN | USB_WAKEUP_U3_EN;
+	} else {
 		val |= USB_WAKEUP_EN | USB_WAKEUP_VBUS_EN |
 		       USB_WAKEUP_VBUS_SRC_SESS_VAL;
+	}
 
 	writel(val, dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 }
@@ -308,7 +311,7 @@ static int __maybe_unused dwc3_imx8mp_suspend(struct dwc3_imx8mp *dwc3_imx,
 
 	/* Wakeup enable */
 	if (PMSG_IS_AUTO(msg) || device_may_wakeup(dwc3_imx->dev))
-		dwc3_imx8mp_wakeup_enable(dwc3_imx);
+		dwc3_imx8mp_wakeup_enable(dwc3_imx, msg);
 
 	dwc3_imx->pm_suspended = true;
 

-- 
2.34.1


