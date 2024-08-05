Return-Path: <linux-kernel+bounces-274952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B8947EAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694E22877A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7115D5B6;
	Mon,  5 Aug 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UxCokKKT"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5E15C158;
	Mon,  5 Aug 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873030; cv=fail; b=hjV85UMbhU1ThgthDz2VZtM9+z9zh9zLw+LEWe3R/+gY4EYqf3WuZdcRtNMAErwVYUXBQtD0tDk6DqdJRSBy/hnoaRXbBym68EMzbn9W/mB3bEmAkBP9eUIHNIc1qtD9RI3kDc0x3urapMifja6z10NuGhHP+cX/5O0lYp4l7w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873030; c=relaxed/simple;
	bh=JA/3aG8ydzYCJW3Yce5BBRP5gGWTaVVe56npSGJKmho=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WiGqc2Cdm7MlV/tV6b+HUhgpVQoiOSKAGPsRFkl4+SZBEi6pfioy6n7HxPS2W16WXny4n19UhmtRsNKTwSbTVbEwylhinRA9VZ8Jv6pAL548daNhtILkq4MjZbqbm6eLraWyb6pD3GDU4b+KaDa+hb70MGuOub78lwllmEQA2xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UxCokKKT; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqMR1N4JswNBhf5U8AUtNe53yOAJU4UMbRSVJSjqeQ3Vg2Dn5TOqRIjCCW7ga0EjPOozzSVjvL+SHXZnY+ocJv9NMAJfRrWgGFK6RiIpwFvKZAMfhYYCWxPwkWyep698kncttoS7TMlL4uNMBEJP8shAmeDY3QmZfXT6KS5wfLlCfGpo2uzInTPUqWkSxToLckagm5wupSsq0LDsAbvdSy1In0jfoXYS3p59wJU9TaunyQ5ZDVMwKGMVhv3REUTwF0nwvc6XBwYEt9Z0xXka/UkvGWwgSYXojRksdX9jfixENtZcx+uPj5vHFmjWeXki1surlvIy2d/08hE0sJ1rjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a1yi5ibilPM8OZYY0G9sZi2InebYQLCneJp8lJjO/0=;
 b=h0kY8X3Ef+vQsF3ipX2mU8vDMTpjvYLb9lJ0Yhiem0Afdt6VTuCwibD8GYA+aeUf05Q+8yM3Dz1jICKKgduV4mO6+jY2N17OK0K32JEkMr0/W8PxkPLdrxn7LH8qA9YaFG+vH7gWAlZIIlCce4xvCKUSESoGfGlNehy2gXFWhzbyrdNngdsIUbgM88qdPKf2kh3nVkKmcFILpJBjYBzZlNu41ltS6EdUt747DTRAWSVT4ehBdrobYJSSAmepbDUFk+9ubTyGAGYi9WTcKtmFQ+v9O0Kbg3i94qqixjPA4GBkOACnrSdqA/iEZ2Z+84Hj4lLWKm2+iuOZbZHt1KSgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a1yi5ibilPM8OZYY0G9sZi2InebYQLCneJp8lJjO/0=;
 b=UxCokKKT3TkQTTEOkSsJwZXYvW1xGcZp4+6dhRyGuQ/B+rxqXgFxWTCORdfs/RAPCPIp96i3mdTGz7xkSB33/J3iaYticWoV/X3tbOpHGqvqEnIcgLzYQjzYZrGhqbhPAiNb+oYYIOVk0BcorS+S6SUg7CyG/VlV+CVuyCG8n587mahdbDhKlC0CvIB58enBH75o3raYmjyDz/YBzAIl59izalhCkvaQZO4gyQ5Z0VnDHWfkksx65PFQzL2UIA6kS9E/RsM7Zky39lLc5mBLuoxcvgpLYoueY0+NjIcQv1s+ac81GjDhilkcXlJ4V0jf4uWjzTd2QjHpwIy7B4pfmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:45 -0400
Subject: [PATCH 3/9] arm64: dts: fsl-ls208xa: move reboot node under syscon
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-3-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873010; l=1208;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JA/3aG8ydzYCJW3Yce5BBRP5gGWTaVVe56npSGJKmho=;
 b=wYltUE0wEPGNLEX+fd8wlQl+eF0acr0ew/jUdXI49uFcdeMroj/8P6S9TP06keN922kfasLUG
 CgEtHcXBSNYB6SQmRjEsU5R1MFeXshvNsTa9YgKFaIDt6/ONIkyzagN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dff17be-6fee-403e-af12-08dcb5664eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkhIUUZQOStmbCtSUThwa0w1UitXY2k2S2ZRTHBTS01wWE1sdmVTRlptZDBa?=
 =?utf-8?B?VzlpbXNaMkY0YUthdUxXaEZOMHVacklldkFhcmd4NjAzZVpjbmltQUgxbHdK?=
 =?utf-8?B?QWxQTUxSWVF1TEgyQWNGK1lMWTRBVStzWTlwcVpSTWZYSGlBam96VXBBK1ZJ?=
 =?utf-8?B?OWkrTVJ4ZkJ1US9QK2VrQ2ZVZzBUcHJWY3p0NnNYYm5SQWdUazJSTDFnQXIz?=
 =?utf-8?B?N0VqLzVVUGEzQ2dJSTFEdlVqL2NKNHhKdjFraFFBemtYOTRldUoyMWkrcUxw?=
 =?utf-8?B?NlIwa0tUaHI3U20xMFAzaEN1VjN4UDdNc0tWZ2NrMlB2T2lsSzlGSS9zQTVu?=
 =?utf-8?B?Z0MxZHdISVcxVjZjNDI4U2ZIVjA1VzRnc2NEVktTZ21ONS9ZZDcrZUc4cngx?=
 =?utf-8?B?SDV3MEpzYjROQXdRWlUwQUQycVNQMFpHbUp3SXQwcW92WGZWbDNXMFBCMEJI?=
 =?utf-8?B?MGtmYlYvNFNHYWFnR2R4WElLUklCOXZ6N3RJWWFXa1pUMmZMRG8wY1pZTjF4?=
 =?utf-8?B?eGUyYWsxeTJucmRZQkFPeEcxZXYvM1ZmUDFTcnNBU2NXdEhzcjBkeGpQaU0w?=
 =?utf-8?B?Vm10cGtmU2UrVDdVRHRCVXIrSTZOamdaTnV6LzB0SEdpTDVobyt0N203bWpq?=
 =?utf-8?B?dDlIZnlMUEZDUVk2QmtSU2FPOGU4SHNWZVZBOEFDSVJaL01Uenl2emRqMjVs?=
 =?utf-8?B?eDhzUW9xK3pvblhHWjZYT2loR0pyMzBndjNPUG9PKzErejJHYWRqN1NvbnVN?=
 =?utf-8?B?T3VRQTVTbmd2V0IyNjlqSUJ4MWNwdVlaTHE4NmFia1pvYURST0xpTk1CRGt1?=
 =?utf-8?B?VGtCNWx1WWN4OXI3T2E1OWM3bUR6YUl4S2pOUGpwZkxXY2g5L3VUOEIvRERX?=
 =?utf-8?B?cFJtdkFEUkNXbWJGdC9YcGxIVnVwSjg3ZUdKRDVibEgrNzhFTnBqcmNWYzBD?=
 =?utf-8?B?SzZ2TE9DUlJRRitNMmZhSFdSaGxLVTh2K0lSNHVPYVlReEpQMGs4YUw0VXBW?=
 =?utf-8?B?OG5pdkFIbTNIeTdQTnU3T3dKM3VjQ0Q0VXdwcytPSml4T1VDcCsvbFVNdGR3?=
 =?utf-8?B?ZUdUbWhUVDVCRWZOVmxtRWN2N3pyMERJUm5VYmZZaGhqSURBcWQyTUc0VS9P?=
 =?utf-8?B?bEY5WVAvSzJqcnZPbndhQkVqazh0L0VSVVpJeEdDeHhrdXd5TkZvUFIyampy?=
 =?utf-8?B?emR4SzFQVHZHOVdFZDRRMXVtQjhxcmdRZWZrY0h5MGdRTEphRUF5bHU5V0px?=
 =?utf-8?B?ZnI1dFFiOWRPampTWm5CdlVZaXg0ZjQ0TGpMSVVqUlBnZUdLbGpGdVVna2NQ?=
 =?utf-8?B?MW40cDVWNHgxZXNxWXdmV2dYSUlZYlFZeWpzQzhHVDUyb3owQURRNUlrdldQ?=
 =?utf-8?B?ZG9tY21NRG9tVHl0YWFtOXJmWVk2VFVlQkdnU29mb1g1S0VaYlNrUVB4azZw?=
 =?utf-8?B?OGM5d3JEUDBuclZLQWZ0SjlHenhrdEc4WStsejczOE1LTEtSNDl1YzhCekN4?=
 =?utf-8?B?c2ZZdDI2dDdKS3ovOVZnK2lqSkt0R2NBcjU0aDVhTnU1V2xNR25La2l1WjRx?=
 =?utf-8?B?SVJzK1hpdXFTTktMU09xZzg1YVVzNEEwbDdOU3ZtZ25jR0JUQkI3Q1BOSnBN?=
 =?utf-8?B?Z2FIVmN6bkE3Wm1idVhtQ2VSQThaWlc2aml6dCsxZmR0akdGSzBnTUVEeUNE?=
 =?utf-8?B?ZTFZQTMvVkZodGQ1bkNqMGRTcUxUWjFBd0xNMlJpd29jZi9sMmdaTjl1KzR2?=
 =?utf-8?B?Nk9abE5SRXE2SzdyRXVoaHY3WWhVcmR3eXFhdlAvdjBvQ0hHR1RIVFFQSVo0?=
 =?utf-8?B?VHc2S2NOTVQzYXhzak04REJDSlFqQkdwa0hYQ2t5bG1ZemFjWURBNUYyNFVl?=
 =?utf-8?B?aHlUMVdMU3hXdFh2UzN0NDh3TEZ2U0xxbDN5SklOV1VwM0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXNwZzRzcUZPRHNLeGZudHcvejR2OWZWSzFoenVBbkNBVElGdjg5VGRSTWJQ?=
 =?utf-8?B?bW5pZE41bUIwbjBtNlF0U1RMS01EZG5hazdXcVpFZ253b0lvSExCcnZGbXk3?=
 =?utf-8?B?SFpiUWs4Lzdjejk0RTBTb3FBa0YzRHRKZnJabU9QN0ljTkw0bzNjSnZpZnN1?=
 =?utf-8?B?VE5EbnRNcy83M2VnMVVKV1BLK2xiODAySEgzc1hOYW5WM09BaW1jNGFrNDAy?=
 =?utf-8?B?U1lDQ1pJbEhOZnRRRXFMa2pLRVhIQnBsS081M2JqNG9KaWdJK1RlSkRZOXZC?=
 =?utf-8?B?cmVwZ2Q5MWcvYkpDNGovd0Q0TUxwNUVaM3BBYjVIOW5NcitUSENMRld1bklK?=
 =?utf-8?B?ZWQ3NjdSVHBjUmZ1OVlLamR3MlRKLzlORUpFdDlEZWhCZ254dlNPb1ZQQm4x?=
 =?utf-8?B?S1E5bVBKUHVDYjBnWG4rbVpxNUFlSHhmMVNWdDFOSmhVc3YwbmJNUFZwTFpj?=
 =?utf-8?B?ZWxBbVpZdHJMYmtIa3VmNDhnY3ExbzM5MGNMdXBCZ0xOWDJZcjNGSnFNVzdC?=
 =?utf-8?B?UHNYdC9GTDhRM2l2aXQ5SzNrVUIyUjNEM2xHRCtCQkJZNGlzU2o4dy8zc3dV?=
 =?utf-8?B?aWVCdTBzVTJtTThoRkRkckFHWElvamdzejNacUZhVk9WNmZ0TmpDWHpkcTBO?=
 =?utf-8?B?cWhkdWZ5R1l3c2RKeDZWSFpzMjhMdXJzTjVRK1NhRnVrQUtHNnU3T0FhS2R0?=
 =?utf-8?B?dko3Q1ZkNXBVWXBIQkpXMDQ5MDZkaWh3cG9KUVNNRkNNSmJDQXYxd1pkeXc0?=
 =?utf-8?B?QUdTNE9wem03T0liazBKampMNjlqZWNKWVFhajN4VXB4enBQd0ZxZE5JTWY5?=
 =?utf-8?B?RldwblVocVJ0Y3IybHc4bUxpT2o2d09LMC84MDk2VmNNR08xVlFRU29sYUZm?=
 =?utf-8?B?bGxhWXI4STZwOGJzbnQwUmpJRTk3d2krSE1QQVlmcGJ5dXFHUlVkSVluRDYr?=
 =?utf-8?B?MUkrakxHOTdNQitIUytkVklrUnJWMmx3TElFYUVJMUFscDN3Ky9LMVM4dHJ0?=
 =?utf-8?B?czduV1dYeWJRVmwzQml1NytjdzVHQlEvL2oxaE9FeUVNcGZ1THdWck9UTU9N?=
 =?utf-8?B?SGpvNEI5QWh5VzdEMHp3NFEzaU5qS2lyZkhDTG9yMEJZSHo2a2hmMmxDSE1w?=
 =?utf-8?B?VGFtYlNKN1k0d0c3QmNhUG5jNGJvUCtDb0dvZHE2WG9TVHlzcW41NXJCOU5L?=
 =?utf-8?B?cUdsMXI5YU1jOHZqSC9ubFRlWWJybFI3UWlXU2hHRWlHWTZseWpEcGJMMWh1?=
 =?utf-8?B?b3E4U0pSenJ6NG1ZQi81L2dkVWxWN2JmVWR4K0x2Skpyb1QwMzV1RjVRR0Yr?=
 =?utf-8?B?M053S0ZtTjFZUkUzNGg2Qmx6bjczOUszZDg5OE9qWlZ6Vzh6bU1aVG5FR3ZC?=
 =?utf-8?B?ayszdW5GaHdpTmhja1h5cWVFYkRzSjBhZEJ5SWNJdDhXTk1NNFI3WnBjaS9t?=
 =?utf-8?B?MVd5OG1YZkVWTmR0TUxWdm5hc0xRQmJFeXJqUnR5ZzNKQnZTSk9qVGd1cmRG?=
 =?utf-8?B?MldlVzBuTElUM1RRem93ZjlxdENWZjVEaEtRNmJCeHI3cW43R1JrWHFTUkdm?=
 =?utf-8?B?QTdLYVFtWjVPR2diRXZkUjVOMzVBODhIY3lLN0luSkNLSVR4Yk1icnh0RUJQ?=
 =?utf-8?B?aUlsNkNZaDBlQ2tQcERxQVZoamhaOHF1TkUzamdDa1NrSWFnSGpsWmRSM3NZ?=
 =?utf-8?B?VHVyRlpLdno5VWRsZzg1SXV3SHd5WnZDVndINExWZGprNStDc080OGpvU1pM?=
 =?utf-8?B?eHRhNWw4UVJRUkZnNjRWRnhQT3dWeVBDYXhaV1R5WndmUVFVRWRRWkw0d2w1?=
 =?utf-8?B?SHR3bldKU0F0eWZORzVRd2pjeE5iSkJ1K0NhaG5MZDl2Q2daaGZZdXByNDdp?=
 =?utf-8?B?SjRsUFI4Uk5rWEtBR2JyWVJRWGVHT3VqYzQ3VW5EdkJYbTk4TzBON0FvQ1Rr?=
 =?utf-8?B?UXFyTVl0RW5JdnhNNmp6eVFVSXJwZ0N5dEYrVzFBdTZHY0ZiYlNpR3VGVEdt?=
 =?utf-8?B?LzJvWmJQbjI3Z1Iybk5MT0pFSTZ3WmFXZEJuRUFxSldKZWNCV0IxcXM5WkxT?=
 =?utf-8?B?UDBRcGFxcnN6d2d0M1M4VVpKL25BTVVUMzZEWDBlTjE2NnlJL1E2b1hmdWEz?=
 =?utf-8?Q?LMGJNSA1jO8Gip77BMqF6wbAS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dff17be-6fee-403e-af12-08dcb5664eec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:19.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5VagPfzitVRwMTF3bjjZtCRJTIiVEamwAUywCIJnTDBZ8pvorRHPIwJZos3uto0gbaAlXFejCA6ZZW5ZSTzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Move reboot node under syscon and change compatible string to
fsl,ls1028a-rstcr because it is exactly same as ls1028a.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb:
 /syscon@1e60000: failed to match any schema with compatible: ['fsl,ls2080a-rstcr', 'syscon']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 2e4dfad637bd9..d7d519a4e5ead 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -68,15 +68,14 @@ its: msi-controller@6020000 {
 	};
 
 	rstcr: syscon@1e60000 {
-		compatible = "fsl,ls2080a-rstcr", "syscon";
+		compatible = "fsl,ls1028a-reset", "syscon", "simple-mfd";
 		reg = <0x0 0x1e60000 0x0 0x4>;
-	};
 
-	reboot {
-		compatible = "syscon-reboot";
-		regmap = <&rstcr>;
-		offset = <0x0>;
-		mask = <0x2>;
+		reboot {
+			compatible = "syscon-reboot";
+			offset = <0x0>;
+			mask = <0x2>;
+		};
 	};
 
 	thermal-zones {

-- 
2.34.1


