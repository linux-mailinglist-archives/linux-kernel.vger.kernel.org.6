Return-Path: <linux-kernel+bounces-208872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8D902A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17901C21A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979214E2E2;
	Mon, 10 Jun 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bkWKXzsy"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5F142915;
	Mon, 10 Jun 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052411; cv=fail; b=RiyNFyJIlJ1oqYOXDyts2XAJtDfsefCMvyjn+bFRr1l0wcXyCpbrtzwtfIQ/c95HaHkYK6SQZmpHIpVbvZL4M5cBe+IpgzzyETOhsWQOEvXP0Kf7WkwdMX/8VmowEW3syoxfNsmd/YRHxVG/FMUt9Z1C57mXRKK5I9CDjfhhxgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052411; c=relaxed/simple;
	bh=D/HTT6VW4dZrgZh+cZoXZPTksLJC7/kUCZRgOV8vPgw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pT7ikE/m8HRBKuPVIULMn9b/12ozNfiDj1BiXh37AdeoQsr1JsT9HX5Yryfi8BOay/EwgEmgfTwFlpCnFaUcKbRfoz0HzU7nH9AGxi1GuuZUENsvGNOtMtwqyRX5P1UHFOwHElrqBv0vcZKuPcfXuUX9cZaB8coJKo22D7uMOrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bkWKXzsy; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOiwLbQ07RcIDKHa0TmQQcywXjFdXsgRoGVgcdktjCGSjwL7i4h6aPJ1HBpI4t6ncHSp8d9LVV/f/1fYxTyzt5MDr/yst2+VTOicUjlbNfZXco9i0CAL0ysA6x1Uv0HPVSHMAsa5sXxrtt1Q36FfQ5YUqhTCEP9q5ViDUeU/l8Q7gSi3swO8kDukqrtWdXdbMB6tBF0bSTTjTbgJy7Kx1mMfYXKX/lEl0ib/nWbwBQN3cj3qX3ilgpo0bONgbH+xdA/FiMCDmgrnrBtex3IvC2k3WZf2PSm9XQS4aundknaaDNfFxduEJE4KbfiZpmGT7GckV/a0OpM7RT6WIN0WRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/sFqS5TSMYymvaoiJr8Kn/tPsOokn9bvjnnZsuXyJM=;
 b=HV0Ji3G+fL6H6e11vJdvOrYASFkmf1aN6lqDGgrP8qZDkBVZsgfLGQS8mmW9OEIEWsgclF7LrbmFYav8+ckUYxo56CtRhkzq0FmwdBJ2GpeKJwgz3x1UHDSFHIwyWgSJJ6l4xhTtTHGA2fcVlyXMmGCiljyou3CUV35RTkr8jCgtFRf9XDG7PX/EfjJ51IaOEFtwjra2jZaEZegKD7yvqwBua2XqVgx4VV/dIhDQwZ6YX+DAhcr6Qi+KERFwjsYY0zrOQw6Rfzcp9Zm5ww+BzPboA096UULWwbmK0uOh/SItrqi/CJc7/Fd2MALhpSQ+12HsV0LlPEwR8zCBRUOnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/sFqS5TSMYymvaoiJr8Kn/tPsOokn9bvjnnZsuXyJM=;
 b=bkWKXzsyMElL2TwcYeGEZO1lg4p/xBc+cqIE5+0hkreUJquV9qOBUcZkq1V9xrCMPwF8cW9cQGrksvyhrpYXlqxfTToTSSecXkS3CdleiJSkxNwhd6hz9rrhTGKBsdzWi3uDiVDp/NW0IcJFd4kjy545dZI6VXO9/z3yXFy/wnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:46:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:46:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:21 -0400
Subject: [PATCH v2 4/9] arm64: dts: imx8qm: add mipi subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-4-788417116fb1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=1586;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=D/HTT6VW4dZrgZh+cZoXZPTksLJC7/kUCZRgOV8vPgw=;
 b=V2akUPTI++au/ry9HksCaX9XRH6ogbzbZi/bdGPIlwJ9BN6e1xguWm9CEc4n7QqyxMphWBGP+
 uQQ83ik+9zPDtsXiDSHnz7yko6hBXSBLvqSRj4Np8OAj8VVTXY1kYhD
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
X-MS-Office365-Filtering-Correlation-Id: 85457aaa-b2c3-42af-cd0a-08dc898e72cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3ZGUzd1THc0OHZLQ1cxL0NsbFBkcGh0QkdOdk1vRnphWjdjcXlWeDhGU3E0?=
 =?utf-8?B?eURzYmJZVndXSUdYZkh0MU81QmFZYlpIRjVyR2RrUFMxWjRJQVRrMWwxRXlh?=
 =?utf-8?B?eGRNRDVmVHlPQWZmL1E0cDYxNFN2R2tyTWVXMWZudHNrOXFYYUZMWlRRNng3?=
 =?utf-8?B?TmVyeFhFVVdhQUFSUEJON1BralFoQjJUMUVSTzJpbGxJT0JESDJZcHhWOVo3?=
 =?utf-8?B?M2NLNnJxVmM4cTR6ZVlqYnBkNGUxSXFhU0xZWjBTWG0ramFRcG13d3pnajZy?=
 =?utf-8?B?VW8wRVVBdmRWWTJ6K1FJL2QveE1xRmkrWlltU0VaYWh5Qk1CMTFsN2czZVNj?=
 =?utf-8?B?NTlsSEpyVG5sS1lhR3lXbkpCSGIwT2FQdXVyVVNvaGFCRW13Y25sMWQxc1Yv?=
 =?utf-8?B?Rlk3VzNQVVNDRmUxN0ZkMm02djRQYnBwS3BEMWhOTTBNSzdBV20yaUZyN0U5?=
 =?utf-8?B?aFJkQUdudDRDMXE5UUpsdWpnV0NwdStzRkRRQ1doeWtvZ2dUU3FFcHpoNkMy?=
 =?utf-8?B?Z2MraUFTQUI4OFZjLzdTcmVVMjNHQXFrajZOZDdnWk1XbHdxUjdpTGsxUm9N?=
 =?utf-8?B?TitzcnI2c0g0Wi9mNWpIRTJiYXhiMlJCNjBFWUV5N0FiczlOUkhXU2crTGdU?=
 =?utf-8?B?dTA1UGNyNEZjc1RaaDBjK0Z5TkZWL0Vwbnp1VmdQWEJLVm54MjJaRUN0MEZH?=
 =?utf-8?B?SE5CM1NFMkFsT1JKKzZEWmFnV0cyakhPTldJdXRmT2dZUFpObzlVV1ZCRHdj?=
 =?utf-8?B?R2cyV3l5QzAraGIxK0h1S3QrdG5yMk1MRHNORkJid0Y1RkhNQ00wMlFjTFJp?=
 =?utf-8?B?WVV3eHhlWTdlZnRRK3ZxL2grSVFpd0kvdzUvRDArNmlQNXczeWtCSWR1YzFL?=
 =?utf-8?B?MHFtR3N2RDNMRlQvVHI4eEZuWEQ3QzJQKzA1VlBhR1pwMkUxSjdiMGpJbzZL?=
 =?utf-8?B?K3ZuOTFaUVF6a2h4TytacFBmaXlJeDdtRGRuWjZhYnJvQkp5RWZhOXo2UmFB?=
 =?utf-8?B?TDMwbkltYmlCUW4vWWhkV082bHBOZHNUQ1AxT29tSXZaNWpMWVJyTHFFYlp1?=
 =?utf-8?B?T09HNEp0UkI3cXZpTDY5L2VsdEdXQzhtTmloOWdiMU9TUmpqT2h6M2huZ3Nl?=
 =?utf-8?B?UUttMTIwSUhDTGpDQ04xcVVkSkhnd1dpRG0zTnBZNnYvSXBpUitPbURGaGlS?=
 =?utf-8?B?dElTbURUc3RoR3FEZU85b3N1V1dqek1Ka3FLV1RkVFVxMnNPOFZkYmVybjJ4?=
 =?utf-8?B?VUdXeUR4YnFPUTRRVmJiREU0T1JFSHlCQXo5dkZRbmtnNk1iU3NHMHZZMnpX?=
 =?utf-8?B?TVBCVU5PQzVEMFBoemlJSHhFMVg4SUc1dklxOWh4dGhLM1RoMkdIaEpDUklY?=
 =?utf-8?B?cVY1M3JqdS93YXhBOVNVMUk3TVhkRTJoMzJjeVEzQmUwaVhrSkIrVU5CRklO?=
 =?utf-8?B?dGFPbjBORS8yMHZnSjEyTTRWN2kxSG1JYUhkajBhTWlqWHBqb2s3VVhzNkhD?=
 =?utf-8?B?MFhmemgrb3B4RGxPZWY1YTBzNHdOOXVXTSsrUTRrZTl3djVPdnNpMDJmV1ow?=
 =?utf-8?B?eHN0VGZXOXFRdzZ4RVdSeDd5cUMyZUV0d1Y4eGs2aFZkLzJiMXljSjNlVjhr?=
 =?utf-8?B?WGlhMlc3MXY2QlJqdnN1N3E3TXdhak8rOTg2a3Q5RVJ3bVZYYkwzalYvUktB?=
 =?utf-8?B?V1pWZFMzdWZORzE3eUhkcVl1SHlZNGZnRjFYZDFOcXdXTUVFMEs2SVJ2M1J2?=
 =?utf-8?B?RE1UdnhWUUpKb1ZKbG4zRUJBWVBnUFVmNjA1d3JuYytocVFTMUlZc0h4dDZk?=
 =?utf-8?Q?EA4E0PEDd6iy8Drxnx4ImAuiYGFx2o6CAi0e4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9zQWQra0VLTFQrSXY1L0RBbHN5RlRwVitwUEdaeHV0S1NhMTlTdXA2K0Vz?=
 =?utf-8?B?RU9Hd0VCK24yeCtTajE2RldiZGpqL25QTmh0V2VJK1I1RWdaTHdRb0NET1J0?=
 =?utf-8?B?MWc3djhtSnc2d1FucTFvTS9KN1lxeEQrQ2o0a3VJam9WejRsM011OG02NDBy?=
 =?utf-8?B?VG13RDc3UHo0aUdNelM4YlhTUnI2UmlVcjZBbkpVZm12K3dNS3dyMGRSd1E3?=
 =?utf-8?B?bnZVZWY3SG01aW4zWkFxN0UxdzhIYVFUaEVyUjVTTXNQdk4zMGVIN0hlUFQv?=
 =?utf-8?B?MW9DbHRseS83WEZ4RVMxSTZoeUdMeHRuSkxzOEpucVZELytpbEgvR1FPOFJN?=
 =?utf-8?B?SWJtL1pSTjljL2MzVEQ3eEVROHRmZndMUlZ0SW5qM1BMd2NML3lhRmxNNi9V?=
 =?utf-8?B?UmpheFY5WDFvVkpwbHdpOVVYeEcxZWxPWWVTTFJnRDY1dTd4K21VUTloU3ZK?=
 =?utf-8?B?dTRtSW1ycW1ESERQMDBSVU8vOEFta3FqR0pzRU9ZdXJXWlVMZWgxR2xGSldt?=
 =?utf-8?B?TGdIZXI1RGp2ZFhNeVRKZWFPWUxiYlI1NWFKQ0U3Rjh3WlFicVZ4WVIxVVp2?=
 =?utf-8?B?RStDeTR3elI0OER4K29ScnhJSmFRUTV1cHJGaEtlZFBBS3l5ZGU5a2kvYXZ1?=
 =?utf-8?B?WGozcGFYdVF5elk1NmkzUXo0a3dHVVhlZlFRYXkrd3dpQmh4MFlkdHZkWlhy?=
 =?utf-8?B?bEdxRzlZaXV1TFVFZEdkbHBzM0x6U0cwVzdWek9pR2JKQ1lnVDV6VVR6Q25F?=
 =?utf-8?B?aUdGM3dVdUVkbmtVaXZBMXhNRnpFaDJuTkJJWUlWWlUrY1V0cnhCRzNkd3Rr?=
 =?utf-8?B?QzdMUVBVaHpRT1ZxZFBXQzdxbUJXdkNFRUc1emVzejBPNzlKRG1wMDNUTDdF?=
 =?utf-8?B?VHFERlpzM2lza1E5UEg3OW5aTmYwWjE5cDlkMjF2WTJxTlROeERGTS9oWEda?=
 =?utf-8?B?UkRibGxibHpCTlp6czI2bmJLdkg4dWhuQmgyZmNXbmZ2NTJIbUFVNHVwYVVj?=
 =?utf-8?B?NWUybW0rWDJzK2UwK2hRRGdYUDNYV1VHQzZvQWtpWENRUktuSjY1Z0lldjZN?=
 =?utf-8?B?QTJMSGtFMlB4OXpKT0lrWVFnZ1VkNXgzaTlSTGFzbVp1TDNxWVkyTzFlczdO?=
 =?utf-8?B?czhmNlJKTWw0UGtZamVqV1NOVHVSNWJxQ29LZXhWbFlkTnkwMVFIRTBXdVJB?=
 =?utf-8?B?bUJJRmJGZGpqcFpGS20yLzErUmpHTUJYR2VxMGw3enVzRWtSb2YzdEJHbnRP?=
 =?utf-8?B?WnNJdmVYbitrYU1WSUxyOXZuTVp4N3N6dlRKTEVUVHE1WUdQMk1uWU9YSktT?=
 =?utf-8?B?bnpDMGsxcmQzMGV0WDNFaldFcGFaT2NjRU1HY2c2R0gvbittQk9SSlZUVE5P?=
 =?utf-8?B?Z1dnYlZwQWNuaEpwcHBxOUc4VTNOa2RCelhqNnIxc040ckk2a1ZXWFYzSElV?=
 =?utf-8?B?OEFHNVVpWVJ2YkhtZ3lYeGxVNDAxN3lWTmJReStPNGhtYmFoQTh1S0w4Ym5R?=
 =?utf-8?B?SW9ydExnTUhMVm1GQ3dMMm82bFlaV0szQmk2UWl6Njg4TEhLendNZDRTUUNo?=
 =?utf-8?B?UXJKZkhPakdieVp3ckh2SVUzNGlXZExCODdEV1Znd2c2eVNlTkt0amZ1L3M1?=
 =?utf-8?B?bS9tNUlkelpRMmdiVWNxMFo4RzdhZ1d0aTArdnZML0dYV0dSVVRWT0ZGMGQy?=
 =?utf-8?B?blk1TkdwRmdiT2JZWG5YYnZPbkxvS3lvT3hzMnV3WE9yZnJwc3VDNUR6SS9I?=
 =?utf-8?B?N0FYMkp4eEo5R0FCTG9XVmdqeUZyUDFPM1hmTmVpZUJOMVJRUFBVUVpCSENu?=
 =?utf-8?B?T2hSRllEdlFHTkVjNmcxdkhUMk9WTnhIbW5LdTZmdGVlTWNhL3l3Z0RoYWdm?=
 =?utf-8?B?emZLdFU3ZkZqV3BXV0cza3BsRmExaDg4eVVqSHYwQ25NYzIwNFNrZGRaRkJ5?=
 =?utf-8?B?V3NrcG1BY0lRMWFZR2E1bUZ1MUpUajNwdE1QbkZnZFVWZjR6bExzUkFqTWhG?=
 =?utf-8?B?T1FkU0JvTm5YQUduTHBkWk1LOFJvakUxYW9SWFp0M3NmTnBPNTM0Wm9GeCsw?=
 =?utf-8?B?S1NBY2djeXF0SWk4S29jUGRYVnpLanc2cWJmMzZsejhaQTZlVGpybkpqSk5j?=
 =?utf-8?Q?9e/k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85457aaa-b2c3-42af-cd0a-08dc898e72cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:46:48.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ot2GiTE9xpAo+HhIfyRz82uAZKjRW0AGM0Tg0Qo/rvro1PJ/kPyNtIjbQoLCx8CkdPPcL8L7BZLFZWSkyXTEtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

Include common imx8-ss-mipi.dtsi and imx8-ss-mipi2.dtsi.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 1e8511e8d8577..9554e60228dab 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -567,6 +567,20 @@ lvds_ipg_clk: clock-controller-lvds-ipg {
 		clock-output-names = "lvds0_ipg_clk";
 	};
 
+	dsi_ipg_clk: clock-controller-dsi-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "dsi_ipg_clk";
+	};
+
+	mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <432000000>;
+		clock-output-names = "mipi_pll_div2_clk";
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
@@ -574,6 +588,8 @@ lvds_ipg_clk: clock-controller-lvds-ipg {
 	#include "imx8-ss-gpu0.dtsi"
 	#include "imx8-ss-lvds0.dtsi"
 	#include "imx8-ss-lvds1.dtsi"
+	#include "imx8-ss-mipi0.dtsi"
+	#include "imx8-ss-mipi1.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
@@ -586,3 +602,4 @@ lvds_ipg_clk: clock-controller-lvds-ipg {
 #include "imx8qm-ss-lsio.dtsi"
 #include "imx8qm-ss-audio.dtsi"
 #include "imx8qm-ss-lvds.dtsi"
+#include "imx8qm-ss-mipi.dtsi"

-- 
2.34.1


