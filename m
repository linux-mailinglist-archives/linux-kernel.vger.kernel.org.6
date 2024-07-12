Return-Path: <linux-kernel+bounces-250860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D192FDBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0297B21A49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30451741ED;
	Fri, 12 Jul 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FRXfMW+d"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506D1DFD8;
	Fri, 12 Jul 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798855; cv=fail; b=lRiPKZpJGZ9IIi1Yhn19P3RL28OuHkE6vGnGH+h81uo31zg2/n8uAM7dRbr72cJMXjJnzX3cnO15cBaMgTklhOci+ZsEKRfUAuKt9e5laU2gGF/zxfq3cbRuaCGaxdJa7Ai/xDTB42aUwyswL3EfMJpao8TTu6m+3a7DCZbRpwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798855; c=relaxed/simple;
	bh=2Z59xORJjSi11OzpyQySPlyZk8dogxbyugpxi5ieRpM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ceCMue7PLmiqtt32M45RQiqPVnrIOxlr/naHKgKa6DKQ4MONAtjoCJvCGRPs9i7FZ2P5xGkNiIT0Ql5UcQzDgdQUb7fNrJvSEgpaaIYupkZdEA6veYn/gahPSRK+GxEar0rnDroQk8z9DtMlZNTTUjBDj8wjfHPm8PYSCG3M6ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FRXfMW+d; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACHnVnw/klLTJRuB9Mj+12O6a6yJzQfNWpDY1/J/ZiRRXIo7JydPXxUKa221ycidYDZRA3PYfm2JpxVFu8esiPZqNC1utzmXFlT01OqOmwhwblhpxDYcv8VJGstKHOEJ9EjBt1uOiksnmqnXa/7SSK7a4CCRfXu3l3SAq3z1qNIYBff9nDazVNDNVvao0vmj7cWA30IRh1f6S+uq7Wwvpr12RvN/0KioUIETj0KCslHWV7x/DQrv/X9P/SdeSXHDyTzDJzDqF5ipCYVFgJTvnCzy9+USECq1dcc5WDalz0Ui4RsEylLGzpZgk1Kl/sioFVIK2EkV3RPYUrEaJNw1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA7Iq9cmeDT92mh5xG8YtUGaDToQ1ZSzpYRq3Bg8shQ=;
 b=ph9IjMkM3+o6Z9FRPn8YihYUfbQUNzJujCyDsHGxaxT4msnaetKNuHFa6wUVTuu15NdQN6tm25VbIVRjShCxFsf+vnK3GKMW9h9HIUkW/LVHBinekTQiuNqf3lOacVqJR8mz6pN7XthJAsz/6aqEQK/BMtlq0UYvAyDPjLmTP+tUtL7i763eL9H7J5Bt5BZwx/IQ1aLdYvSwALjbs8yyagKs0oWNgTm8gulBjHon+eVXu1mC3WJRMjhmyOVyMTt8YMsVIjcqnF/5gQ2B0o+fE9noQMiPFLQtS9O33vUI6x3Aqxet16PctHDCUJwWXDyijqCpAISt43ErWmKUqXx4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA7Iq9cmeDT92mh5xG8YtUGaDToQ1ZSzpYRq3Bg8shQ=;
 b=FRXfMW+dKdIxijMqjA93NYQAvdu1k2W4/AFQSIcAeCiNLmsc8WsZ6beHnBr+97QEjKwsxo6qBqyoYxOjDdBQlwHvdcMLSUYNL6Ztjm1hr7Co1H+/sXzwwfKFI1iw84ludPSUDt8cUzWJIoQv8Zg9F1H5ffBERyRwFIWqo2LgVIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9803.eurprd04.prod.outlook.com (2603:10a6:150:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 15:40:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 15:40:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] usb: imx8mp: collect some improvement
Date: Fri, 12 Jul 2024 11:40:26 -0400
Message-Id: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpOkWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0ND3ZTyZN3cAt0UQ1Mzk9TUZFPzJEMloOKCotS0zAqwQdGxtbUAEOx
 w0VgAAAA=
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720798845; l=1137;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2Z59xORJjSi11OzpyQySPlyZk8dogxbyugpxi5ieRpM=;
 b=kzf/EQqkvfpAQOutkIqLsyxLQ0BPBSshUdjHzzaWEaj3jdGSdX8KK6WWst00DSCsx5QXPHErT
 +ztZS9vEgaAA8u50fY9FkzVO61ORML0WhgnrjsFeJV6dzEczD/mfmzh
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
X-MS-Office365-Filtering-Correlation-Id: b3588973-29c6-4dc0-bdd6-08dca28900e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b21RZ2xXZHNiNWx3OTlMZUdlMEhSV3MyN0M4cEJEUzU3UEFvNDJOVmRWdHQv?=
 =?utf-8?B?VGp3ZVI2QnZCYWJHeUpOeWR5bEpGRUdkS05uUGpGdkZpZk15VnFZOGx3Z3Ew?=
 =?utf-8?B?Q3FMYW9CS2QxL2JUUmVnT0tTSkxBQklZRjBaNmtaaEJjZmtGTTExT044aTNI?=
 =?utf-8?B?MHRDRGN6c1pKVGVFTE45SitDc3RFZFZPbmVrZnlaa2ZNNmV1SzQvbjJTUkp4?=
 =?utf-8?B?U1JLZjhQRlp5MjM4SHFtRGZtbGN1UUFhdE0rNlNrMjVuc24vUGtYUjNWcyt1?=
 =?utf-8?B?Q3U5K0tJSU5pc2tuZnhyblp3S0UzeFZoUEl4RFc5UHc3M2ZLR2RwbDhxUWph?=
 =?utf-8?B?aUNVcEd1YVZ4dUkzVlFxTG1LdUlXaXBDbEZmclJNdm9mQkdXRy94Y0x4aFJt?=
 =?utf-8?B?L05QK3RHaFl0U0VMVUFjKy9uTDJFbU5WWFg4ZnpMYThOT0tmbVFHOHpZQ3VM?=
 =?utf-8?B?QXlXeWVyOU9KQldNUDFmV1VJT2E0eml5bjF3MjM5SzBIcjM1WHJhNTIxeFRR?=
 =?utf-8?B?U3VhZHhWYmZKWEIzZEF6aW5IZjhzMG5YMmNjRHJPRGxRVlQrMVd4K2ZGNHJs?=
 =?utf-8?B?RExXTEl2UzM4WmlPbXZKdUw1T3E4SEU0TVBBeWp5MkxwYy9ETjJWOFhsZ1hT?=
 =?utf-8?B?bFRGMnorL1QwQXFja1h3N0c4V2t3T091NCtOK0RqOVdHTWpQMEllY3o1bXFV?=
 =?utf-8?B?R2FyL1lzaTl3TEIzM0Y2NlpyTURZaTZwY2wrUTlPTzhDWUgyUXl1MDUwdGxw?=
 =?utf-8?B?TGg4OE1XV0JUTTd0Q1NwZHMyNWJMVHJRL1pCWVZ2dEI2byt0MmtUaFdXWDFB?=
 =?utf-8?B?aThtWjJvZVZPVE12SDJnNEUxMVNmbGZqSDZVU0JSSFRWVUpCRTJ6dWhNbEY5?=
 =?utf-8?B?RjJnaklUV1NJYndPQjVScUdaUHVJbjRiSENoNUE5U3lYZ05INHNCTXNmaHdI?=
 =?utf-8?B?S0NMTkpCWithOEtONWJrYm1OOG5zVkdkdlV2N1lnVXBFUll5UnJpcFFBU0pM?=
 =?utf-8?B?UGRhLzFFOHZGUUxmT1R6dnFzVkgrN3NiczJsTzM3ZUpTdWNPc1d0NVBKSW51?=
 =?utf-8?B?c3VPU09iYUoxeVZSTklSOWs2MUVybEFoQUd1MTR1NG5uSEx4SW8yTklhUHYy?=
 =?utf-8?B?RlFnRWFHS1FBVlhXa0dKcGIyWEFzSzY4VzUyQzdKUWZuSUthNmdzZTZ3a1or?=
 =?utf-8?B?TFY0WDZLOWR5NGdnQ1RVb3BHaVQ3UmFlR3dlNjlzV25iYWNiWVBXWGs4eTVk?=
 =?utf-8?B?MEh5UWZNVTdmMU9LZU1ibk8rRGNZbDBIOWpFNUlhcFRpa3pHK3J6dWlQRWdt?=
 =?utf-8?B?NG90ZS9nQTJKYXJDQXd1LzJTY3pyZDl5cmlYVHR6azVOK1pNeDdvVDdVcHIx?=
 =?utf-8?B?SDZHOStDbVl0ZDhiOUZ3U0FuZndCL015dXlKdCtvUFJWNmVjdWpEVmtSTVVD?=
 =?utf-8?B?V3JLeko5cVhQY0hGVDc2Qk1UajF4MExVZXJWREkzRUYzSEVJK3dJSU9sZXdl?=
 =?utf-8?B?bWFlc29aSVZSSE9GWWRqN2ZGVXgyT2diWkp6MjMyakpvNVpaNnQ3czVqUFR6?=
 =?utf-8?B?a2lnQUVnVDRMVlIyeWRmUWVPMXBTdFA0NHdrdGtkNnI2c2lkZC9zdCs2Kzky?=
 =?utf-8?B?SE1MekQydjMrOXdxMmJjSHk2d3NwS085aVEwRFEvL0RIYnRtT2tKb1J5eEM0?=
 =?utf-8?B?S3c4MlJYWUR3Ulp3NTZNOUNoR2dRUzNTMXhCUTg5SHR0RjhTc3B1bEJFbmlP?=
 =?utf-8?B?WC82dXpuQ2hMNUxSZWhLN01OMURIT1o2N1RZcXJLd2VBU0lzN0FmbzFNaUR3?=
 =?utf-8?B?UmxlYTJic1FNVTVkV3Zxb0ZWR3VPbEdHNXZmTWkxdzdHQ0QxS0E4bEhYd215?=
 =?utf-8?B?ekgxODNsRkZBd2h4TVhQQ1RtbTBEa08ydFZ5V1M4Nkl3MFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmNtS3FWYldwWTFabzZIM2F0OTNWZmYrMWw3SFhpT1pJSnlSYnNES01QaUdY?=
 =?utf-8?B?LzVlV0FmVC8wWFhkektpT1h6TmtLd2xiSEp1U3Z5S0RWN1ZQdXdvbCs0Z21s?=
 =?utf-8?B?OWpzZ2FkS2cxQXRVL1lVTm1YYXBOaERudXFCd3oxWlRqR1QxOEhTc1YyeXg3?=
 =?utf-8?B?MVJMME1Cd2h5OHhmeG1Od1NCb0gvajRHWVZtdHB3QStRSVBFaDVvZGZPSEhQ?=
 =?utf-8?B?WDFWUUNkQ2FjU1ZKdWdBZkUzYm5uVkowZmJtSTJqZWdBaE5GOUJlYlhNdWF2?=
 =?utf-8?B?VXJWaUovWERBbW9DaWNXR3BTU0hlcmZPN25HVTNlSCtTNTVBbWFNQkVId0Zr?=
 =?utf-8?B?SmRydVR5aEZTbkFac3lWOWx2VVliRjVjVzcrcFZtMlhvT3N0UWlnTEJKdFFy?=
 =?utf-8?B?bDhMZXhsTUZTUTBmNkJtSXg4b0NHNWlWUThMUGl1U0h4bytZaWpoaUdabG9H?=
 =?utf-8?B?YUxMRTA5RWpCRnMzTHM3TlFrVGI1aWl1UTlkRzNndkozM0YzM3hvZHZ5VXhC?=
 =?utf-8?B?dU9iSkR4MEZZY1hNVlFHWW1sK2s4c3hxUVMyZ0dpYmxrRmZNelVra1c0S3pK?=
 =?utf-8?B?VE8wOURXbWZNRTlyK0Z3dmw1OEZZRmMySUJ6OWRiQ1RuS0dCZGVMaS9IOW92?=
 =?utf-8?B?ZzRnVHMySFdxRlcrTGQ1TXpGRHduTkRDVU01RFpvTTVid00wc2twcVR3bFRt?=
 =?utf-8?B?c1dESWFtOW9QbTl5K1Z3SVVCS3A0NzFVdVZYUUhjaHhvZ0t5cnEzSGROVjc5?=
 =?utf-8?B?blBldHhWc2ZxOEdNNk1rUFcxQjlibmE3SXlNM3B0ZDNXTE4weW1lSlBJZWFv?=
 =?utf-8?B?RlVDZHlZVS9yTkU1T25ZNlVmVzQ5VFE4WjV6Z25PTklUL096eU5KMmttclJY?=
 =?utf-8?B?VkwxTGdKL202RTZmc0xCZ251ZENKSTBtRys0NWZ2ZzU2NXhmSVpsemtsRUlV?=
 =?utf-8?B?bnRDSEhTZGwxNmRaNFJLWk8wb0hYOEhoQktabzEwb1hRZGJOTHNESDJZVXho?=
 =?utf-8?B?VUhrQ3BPeSt4VWEyTTlUUUJBM2piaS9lSTd2NGVUMDA3T0dNN2tpK2ZhOUh1?=
 =?utf-8?B?TjRrcFkvQk9XdUFqQ2pCVEZ2ZlFXUmpkMVlMYkZ0ZlBvY2hDRXVSOFF2VVVy?=
 =?utf-8?B?Z1luTmYrNEVoWVROT0crZkVnblpPQUNwMDF2empTWWFydW10REZzVlhjRDB3?=
 =?utf-8?B?RHZySkVtU2JuN2s5V0J1Y3RLQ0NlbDZrVFVjZWlNSlpleWpiVklYU2NGbkND?=
 =?utf-8?B?OS9BVWZzNml5Q1NIdGhoSkp1SXJjZU1RTlVYVWlqQ3dsSUFBTkZPaUwwL3ZV?=
 =?utf-8?B?YVYyRWdlV0RJYVFlRUtjVWZNbWsxUklhemNicmt4NHNKNHp4VkdZRzg2UExm?=
 =?utf-8?B?ZzJpcVRHUVd2TGZtRXRtYk45T3A3Z2ZUZzhLNTBnLzh3UCsza3VIdlRSU1dF?=
 =?utf-8?B?ZkNSdXJzSjhEUVhoay9Xc0hpTFJEM1B2V3c5aFlJaHVPYlZ0L2NrOWFqSUZm?=
 =?utf-8?B?azdrOHpyTUx1V0hRNldYelZ4ZURxOXBaQWp4SEJzTTR4RkhQR1JYZzRCY05x?=
 =?utf-8?B?ZjRpRFJMNVJYQVMwMFAxTTc1dzNUY3M1MVZ4WGFnMzMrVGNHZGtPeXBGQVp4?=
 =?utf-8?B?QXpVMUZBV1RrOURzTE9EZzBFN3ZzcDFtRFlCRWV0cmUvODQ4VzBmMDd6cEZV?=
 =?utf-8?B?a3BicmpEbm5CdCtEYXEvT3dnY2Q1Y3RyTEhCRUlnY3lFZjM5SVpLVncxamlQ?=
 =?utf-8?B?ZXlCcjFJOHJHMWNGOVlSR21xSXBhYWR6WGVSZS9TZEczTXhYVWdNZXV3ZXdE?=
 =?utf-8?B?WXpkcXZuY2loRmxhMGlBREJpczhXV1IxRnhoQWhUcXVzQ0tmcEh5cnpmYTA1?=
 =?utf-8?B?cTU1clZ4L0hQQ2FxcCs4Y3ZmeVJLTi9LM0dzbTRKTUdmdTVxL0lRc0ZFbnlo?=
 =?utf-8?B?NDA3ck5KSWRObzNiTGZhSTgvenQyc1VQM0R1bW0zRVNGU2R2YmVORHNPL1Ux?=
 =?utf-8?B?UC93MmRXdmd1Wms5RXYyQWJZWXAvTGJDWktSUmJsNFBuckdwYXlTUWtlZEtm?=
 =?utf-8?B?a045MW1RWUJKbW55QkR2QkNmYVRTRGF4TWdJZ0xtMHg5MEhrT0lSV0pXMDNB?=
 =?utf-8?Q?2LOAX/chMhAgMnBW8J4D9EcHq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3588973-29c6-4dc0-bdd6-08dca28900e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:40:49.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qLnPq4tK/2PLrx84SR737DqBJYKXSM7IFyBGU2O7+rVtcF5pq/UsyLA55/6dfJTcJWiP35g3+DhRsph7ulzrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9803

Apply two quirk for imx8mp dwc3 host controller:
 usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
 usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Runtime pm and wakeup:
  usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep
  dwc3: core: add a core init flag for device mode resume

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
      usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Li Jun (2):
      usb: dwc3: core: add a core init flag for device mode resume
      usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

 drivers/usb/dwc3/core.c        | 13 +++++++++++++
 drivers/usb/dwc3/core.h        |  1 +
 drivers/usb/dwc3/dwc3-imx8mp.c | 33 +++++++++++++++++++++++++++------
 drivers/usb/host/xhci-plat.c   |  6 ++++++
 4 files changed, 47 insertions(+), 6 deletions(-)
---
base-commit: e60284b63245b84c3ae352427ed5ff8b79266b91
change-id: 20240711-dwc-mp-d1564eec57b1

Best regards,
---
Frank Li <Frank.Li@nxp.com>


