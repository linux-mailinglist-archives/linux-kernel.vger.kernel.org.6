Return-Path: <linux-kernel+bounces-208870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E630902A17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928771F227DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E094DA0E;
	Mon, 10 Jun 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ExuttuLk"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0C6F303;
	Mon, 10 Jun 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052407; cv=fail; b=C0iPnj4wh4ic57CnkGMide1s1UOzQyr8k84u48CIi7Gk5hZsNdzUvYpKc5j5LMmi5d4v9wHbIKlHDxwiGzaBp4MoL2tU+8Q2ijXlefWAJFs2Tz7tqfOBJ59ihLTOfmBa2iPS6w6IygCWjhxRSo7bitMbxb+H/HjDFhEzixKEacE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052407; c=relaxed/simple;
	bh=XCUDXz6P6qoQoUmf7K0bLTg1SJKxzmluB5QhvEptooE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=joZ6YdGuRDByaLNdeYpqkpqfyjDyBM3Ej5OVaJ7tjTQ/W072Lw15LByY5Mv8KpOpxs8nABkgd9MCzotEdNBwFl9MG63Nj9M1gghHuGS1R7KyuF722EazhV15STZhOGm9YNBnbZICjM/0SCi50KyLAQJQyVaFBte3ertIGO3F9c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ExuttuLk; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiUfo0MiFgAhpGVFLTGZjS1JGDhQhb7NRqMFfchua4/j11RFLhOTVnLOp2l3K+v46QiNTqzQzKVNvma7I+H+ivMHuQqsjG47QqMntHcyvem5Z6E54ldQkvcbL+mhWM0HyvugS7qQMF50IBjPyZUSMGweg8rJcCrvho/15hVumv09w4pLpxuFBKA2S1nuhTge5d+7KIzeKQ+LThIpJDYUlr0LMqeub/x4DohbGeAYf9gAi4iLXuvP4NueC+qKU7theGicqDbtVi14FCjOQuM5fuFRMtw3N193/1g8Mnl4o575cgkyZyN61q1+sZSMgR6yy1R8sZFyUWuYkrQFTSU+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ/gvaWHQBm6sY2AeA8959U2nGfe75xQ7uoNYRMEoK4=;
 b=fdFhtHRUIFSDPcFIFN6D9aFsHssZS5yZ/KSC5ezkixvRafiWCct93rtfqMimBDPp7KzIrXVeBjiFU5AoR4bkUKnsAbgnmah+xKsvvjgHP+ncMq2fBH2IRH7lk29gLjK7i9e0bL6zo6z9Q8+0fhyWORC7R66WLpVs8TyIzuejeX/m8ZLO3UErAdj5UUu7j0YuNJMTerIWuCtEVqKbaruMTVW7ZjiZwnzN2JYq9Lo+sh2xrm9EQruDpyS85p/vdXozlM9y6/7j5D3gIcbmbE7xgJuxXDroKKmLm47zDmJZBr5PtbFIaiPIk4pOkTmsaNIKXAoRmDtxh8By6OlEXCcqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ/gvaWHQBm6sY2AeA8959U2nGfe75xQ7uoNYRMEoK4=;
 b=ExuttuLk3l6c96qvSsQRCZGQIKCNAnpe2m3lT4jmd4zDc+SNusJzUDTLW7tLN2kAZMrFu4Y/dDLK6v0A+5ObCYBTcj8eW8wj3lQ4N37QwXgtjZFs5ZMDz6cg3h4lzPCj+FkNPJmejtQuuahBd7tinGPCZYe/BlF194Qv5J1tUqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:46:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:46:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:19 -0400
Subject: [PATCH v2 2/9] arm64: dts: imx8qm: add lvds subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-2-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=3746;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XCUDXz6P6qoQoUmf7K0bLTg1SJKxzmluB5QhvEptooE=;
 b=zsz2KXlfR1We3l9tc+8I4B95PvTh10GYuNjKglUkmeCFrR9FGySp9a54QZ7xtAefuMQTDhu5W
 WhnXijyOoqWD/4l65LWmHqH2M+DdGhRj26bf/luZhW+eDw3DuIykLha
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe8ae9d-c335-4680-8d44-08dc898e6ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkQwa0FmMzdPRFljRWVtY3MrNGZiK1BPa1BLNWczVmFzNW16ZzB4MDhkWnN6?=
 =?utf-8?B?M0JuUnpYVXJCb1NBMDg0Yy9oejIzTFM1TTRZd0Y3eHNNSWRqd3c4aCtEd3Ro?=
 =?utf-8?B?Y29rckJsNm9EeVJmMFB3elhqT010dXR3Sjl1TUdCOXN0WmNYeFFJTXRWdkZN?=
 =?utf-8?B?R213WkcwRm9DdnJSWUJ2MXN4VmdyTXNFdFBVY2RKUU5wQzJId2RZcnZrSUI1?=
 =?utf-8?B?c0YxZFo5YWNhdVFvaUVsVGVhNGhDWnVLaTNKU1VGNTI3blZIY01yTFpFZmRI?=
 =?utf-8?B?eEo0T3hZREtUeFZuQk1tdWdEQnVzWEdzMmQwdHhMd3dnNFhmTGRKa1ZiSmN1?=
 =?utf-8?B?K0RYZ3hQWGQ4UUw0QkVrQStEWjZvVU9vS3RscGo5YUs1VDhXbFFleE5td2FQ?=
 =?utf-8?B?Y3d1ZS9DS1h5MUZZUHF6ditQR1ZCc0toalFlaUl6TG1WNDNYU0ZtZTFmazZx?=
 =?utf-8?B?WXZQdHZuNlVvYk55Y0VXRXZjVm05T0dVSGhSdjAwbVlsNDZ5VUlFdCtDTnY2?=
 =?utf-8?B?UThhcGRYUGhac0hhOGFyYlArWmxRVDFhQ1JiSHFuUytRR3d1Q0U0NHMxZzQ3?=
 =?utf-8?B?MXRPOFNOWGxUL3JOYTVoM3htamZRVDU3UUd6WGVWQk9qYk5mUmxJelJnZkoy?=
 =?utf-8?B?czliakVDR29lelh0K0ZhNGlGUHA1ZG80Uk5FVE02Tmt2TjJ2S2k3ZWZUQ3Vw?=
 =?utf-8?B?d1RWb1dSZHRxR3NWK0VTVFlTNUpPV2hESEg4U0tDSm1hWkxIMlQrTzcxdGVl?=
 =?utf-8?B?Tytib2JCT1F1WW1ZNitnMlcwaFN3WUF2bXdpeDVLbko2TVlWVTdHZlpzYkha?=
 =?utf-8?B?cmxJbEI2MS85dkVtWVFYV0YxL2hVUTRQanpYbEZ5SXMyNldiTzlKdm1KUVhx?=
 =?utf-8?B?V0VkaEVWNFgyWVpKNkE1Y1o5dG5HV0EvaDNiWUt3TGpyS3MrOWVwdzg1bEQv?=
 =?utf-8?B?WDd1ek5TYkdsSUxFU1hZOGtoeitRZVUwdHRVQldhTWRGK0ZET2k4bHFYNzA1?=
 =?utf-8?B?d2Z4SnpSNFlWYUlqdi9uZy9jOEJ0NlRSZ0RzRTAwZmdZT0N5MGo3cGdXRGJB?=
 =?utf-8?B?Qm1JbGhzbHAveUtIemRwb3RGOWlmaTZrUVdLUnB2YTVjU2EyZDN0dlFrMjdi?=
 =?utf-8?B?R0hEdlY0TmNxYlFIRnFUc0lGMSszRjVaQ3NOTkd6VEFLZmRGU0U3aGhhaWxh?=
 =?utf-8?B?TkZZc0h1K2NxY21qMmZMUWFUbjBpQ2RRamwwYlhtS20yMFZCU0Z1aWRTV2px?=
 =?utf-8?B?TWllSTFab2MwVThwT0tCVkRuZEY3VDk2WlJ2TWl4Y0p5QWFQeFlDQ3N0RmRl?=
 =?utf-8?B?YjIzWGFkVm12bTdaY1V2Zm5LZk9ZWFBrTXRyajJaeEZ4dVp5dktJc3c4QlRo?=
 =?utf-8?B?N080Z3VlZmpiVGZ6S3hEWXZPVTg2eXRQbnY5N3FoMmxnb0YycXNMR2x2TDNB?=
 =?utf-8?B?QUcvcWxtQ0RUUHh2UHJtc0JVMmhqbjZDQW9vL3IvLy8vUE1za1RXMFpsdC9o?=
 =?utf-8?B?ZGttYkl3T3dhMGkwaFN3Wk9NTGFHN2hOSEFkSEtGSVhvRXc4czZURmNaMy93?=
 =?utf-8?B?VmswMkhzeG9NUXF0MmRwcVQxSnpNenhDemNRN2dndGZmSjE3TkdBdzFmWXVK?=
 =?utf-8?B?WnAwQlFkMlI4ai91eFROK3JYZVRJQk1KRlBSVDN0cHZJbXJ3NmtJSHlLSU10?=
 =?utf-8?B?SnFuNTg1UnEzbGpnaE5pNnBsckVXTXlDRnJKdnA4M0NpTG51SGZQRTZOc3c3?=
 =?utf-8?B?NFp1b051dnUxRGxLZ3hPeWR5cjVGbHVGRFFJNUlmaDExVFgrMnBaem4yZisx?=
 =?utf-8?Q?fus99J1xV10lP3DErLTmBKGD3YU2QjBhvs8V8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUVCbHViYWJUM3dBcU1oUEE4R2MxckpORkoyNW91UTV4RkhsU3cxZWY2WVZ4?=
 =?utf-8?B?blM1TXIrOUMzbjRGQjdXZzJwYnYxNDNnYTRKTE1tZjFNdS9YaFFpL0JvYmxn?=
 =?utf-8?B?RGFHUG5aZlhiWUttQTNNZUNVYnFKL2lnUVhyU0hRakdrSWkyYmFraXAxZkJI?=
 =?utf-8?B?dmRHcWVsYjEzNzI3RWEwMk1tWUcxOExZTFgwN1N4V1kxa21CemVmY3NRcFlG?=
 =?utf-8?B?M0M3ZXl6ZFd2RFdteUVvQkxOdCtwc1BXTUFSNFU5RCtpeFhON0NUeGNSaXNl?=
 =?utf-8?B?Y1NwU3MwRWxnTTdiQ2FKZlBlTzZRcGFsbXUzVERTVmR5aitvUzdWSVBDUERI?=
 =?utf-8?B?MFV4TXExSG1uNFVhZHUyNHJBblAza0V2cXAyTFI3WFZneWZQTXRnbWI3WHd2?=
 =?utf-8?B?S1d6dEp3czg0bkxWWkZtekM1U0tKTVdVSzZZSVRJWlJ3L0hzT0NhVWlhd3FS?=
 =?utf-8?B?bXlTMnJYQlhQbkRBVCtodytyVHYwUFFrNlVPVTVxQXpmMjkzdC9vc2h1Q3JE?=
 =?utf-8?B?bVdpS0RnRXJVRG9GQzBNZnI4NWZydTBldi9XeXJGbmhzMkhNKzNPNjA1VzFh?=
 =?utf-8?B?ckxiaVFYNUkyTEgyRHEzTFBGdmpOU09vK2JxNHNSZGNBN0F5YWZUOHJlOEhQ?=
 =?utf-8?B?UEhoVlRqcHFzQnJiL2Y5TUtYNFZ0NFJrUklJZ3VzMlNoWnZTVVNmd0k5eHhR?=
 =?utf-8?B?ckdOZ0ZYZlVicDAvdjVaWjZKVXVGZUxVallDZDNVbGw1bWJIWlhGWkdLbHEv?=
 =?utf-8?B?Rm42MC9oMTJSWUc3UC9ZWlhhWGxTNFcrUkxTWWNyaVNzQkJTTzZSa29Xdmkv?=
 =?utf-8?B?N1NSRjRScmpSS0daeGhKektFQ3NOUS9CYytkS1YvQk1jemhidWduaFdZT3lS?=
 =?utf-8?B?TlN0Y1VkMDJjR09peklOOFdWUWN3ZWU3TDFZYnFHenVjd0RNS1ZXdVpIOE1W?=
 =?utf-8?B?dU41MXBpeDBrbTM0aGRuSFFmR21OWWZTZ1ptaHB2bmJCNHpyTnJxS0szZzl4?=
 =?utf-8?B?SUNsTHBkbkIyUDEreFdOUk40eHRaQXhMNDR2Q01ObjhvRGlKODJBV1J1TVRi?=
 =?utf-8?B?NDh5R3ovVEU0RGZBWCtjNlJqcC9ERnc4SVE2R1YzL1oxTjlKRDRmWDRyRFFZ?=
 =?utf-8?B?MVljaThKa1lxM0ZpcVBURWlBd3NocFZ2eUlYMkowTFVQUE5ra0I4SDZMRlUw?=
 =?utf-8?B?blY2S2dIaFQyZGw4Q1BSUWlVSDR4TEdrWkhBTk1KcEN6Z2lidVh4bTVPUTYy?=
 =?utf-8?B?cng2QWhWMWx1ZVFqSHJYb3ZJK1ZqbzRWcUduZ0RZeHB0TWpWQ2dTelJZV0pn?=
 =?utf-8?B?L05KelUvbU8rR1EyOHJSQkRBNHBpeFdLSjhOeFlhajFGVXR1c2ZhYytxL0Ry?=
 =?utf-8?B?alNLWkt3ZmdzOVdTdDVvV2xrWHV3dU5NUG9oajhUc2Vib2JBSFJXaEtkbXZk?=
 =?utf-8?B?cWxOWHMrekwzZURvTklOMzZRN2NUQXFnUHdMUVJ4cUh1azZvZHBraUplUWYw?=
 =?utf-8?B?bTVhaXVNWDdWRUJjWnluUTdVdGJLSzUvWGF5WThrWmZSaHdtV0xuZERXWmFV?=
 =?utf-8?B?c0htSEJRelZ6NjBpQ1RmYWFBS0Y2SnY3VXgzRDFzWFFuWFBZN3JoYmNBKzFa?=
 =?utf-8?B?aXZtRkU0WmVTSDdwU242N3lxMU5kc1JBTG9aclMwclBaa2VNb3hSZ25sc2hx?=
 =?utf-8?B?emIvamJTMFVJZmE2c0RJOHZ3Q01hL21iTFNzQ3FZNThtd21xeVR2UlAxd3Bx?=
 =?utf-8?B?b2pLSktNWXdmYm5CZzNtMjVNMXNML1dKN0Q0RG9MLzVvWXNIZG90Vlo1U1NM?=
 =?utf-8?B?QWJjaTdsMDNGWEtCOCs5TjRreDZrM0MvalA5OHQ2bVhvTWtVMFNhYzdRTFZS?=
 =?utf-8?B?V0RIV0ZramQ5M3RwYitCbUZpZVpzZjQ5SHo2UlZZTVZJVlF0ZXIvL0ZLUlFI?=
 =?utf-8?B?NWFUQmR0bnI0YmxwMndZS1dXTEFvS2YydWt0Q3lDOG95Qk9lNWI2YlU4MUs5?=
 =?utf-8?B?ZGkzT3dRSXVvTTlNNUJwZkdrWCtOejRuVDJpODQySmJMQUFMNHBsVStESjZa?=
 =?utf-8?B?ejkyRS92SmhEak43UXJsREZOWGJLMFd2MlYybDNFZ3FxaUJJK0wrRXZyM3k2?=
 =?utf-8?Q?NDNM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe8ae9d-c335-4680-8d44-08dc898e6ee6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:46:41.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDXrEgws774Of8coSTwKT6IKZuQ0wq4oC6ELt3fEdWGmD54NKICOKXTJCHVx9tJ8ZiyzhlPhmR2QPNS37Tk7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

Add irqsteer, pwm and i2c in lvds subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 77 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         | 10 +++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
new file mode 100644
index 0000000000000..1da3934847057
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2024 NXP
+ */
+
+&qm_lvds0_lis_lpcg {
+	clocks = <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_4>;
+};
+
+&qm_lvds0_pwm_lpcg {
+	clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
+		 <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+};
+
+&qm_lvds0_i2c0_lpcg {
+	clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
+		 <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+};
+
+&qm_pwm_lvds0 {
+	clocks = <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_4>,
+		 <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_0>;
+};
+
+&qm_i2c0_lvds0 {
+	clocks = <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_0>,
+		 <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_4>;
+};
+
+&lvds0_subsys {
+	interrupt-parent = <&irqsteer_lvds0>;
+
+	irqsteer_lvds0: interrupt-controller@56240000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x56240000 0x1000>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&qm_lvds0_lis_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_LVDS_0>;
+
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	lvds0_i2c1_lpcg: clock-controller@56243014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds0_i2c1_lpcg_clk",
+				     "lvds0_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+	};
+
+	i2c1_lvds0: i2c@56247000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56247000 0x1000>;
+		interrupts = <9>;
+		clocks = <&lvds0_i2c1_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds0_i2c1_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+		status = "disabled";
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 61986e0639e53..1e8511e8d8577 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -560,11 +560,20 @@ clk_spdif1_rx: clock-spdif1-rx {
 		clock-output-names = "spdif1_rx";
 	};
 
+	lvds_ipg_clk: clock-controller-lvds-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "lvds0_ipg_clk";
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-gpu0.dtsi"
+	#include "imx8-ss-lvds0.dtsi"
+	#include "imx8-ss-lvds1.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
@@ -576,3 +585,4 @@ clk_spdif1_rx: clock-spdif1-rx {
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
 #include "imx8qm-ss-audio.dtsi"
+#include "imx8qm-ss-lvds.dtsi"

-- 
2.34.1


