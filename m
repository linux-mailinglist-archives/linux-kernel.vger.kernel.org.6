Return-Path: <linux-kernel+bounces-240332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7BB926C48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957E8284E33
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F0194AC2;
	Wed,  3 Jul 2024 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OH3nMtqY"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8E1DA313;
	Wed,  3 Jul 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048035; cv=fail; b=a61p1O/zx1SNLHFRJiquc2RF9MeikElDU92WuZ5JSszTNQaWIjH3IBVue7E2g59cNotrrcSBKFxXTXQB6IKxngj3TyVkYV1EB31NRlu650TXJoWoxYulD1GuCwAM0/1Vn2IEeY41pQbDRdGwaSlfW6MVtq7icQazEMRZN+7iw6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048035; c=relaxed/simple;
	bh=UEwIi6PG2Ortvh0ehIWDp33CtLYDrZbyvTUJLpOuJ6I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=l2yhf//hP40R1r3Zt04N5c2plqsgb1yr5jcQvyjK5ajh/+XsU0Di5CU1gtGa3pGrM+Q6vBZItc5h7dw72TMFEJ8D0bGj4kccj9xDsQ/pEV2d2h370cqughoQi0o43PoDWrHrXDOmtljMZsRqVVrRSMN79IjPwb/nuvSrGMKPEe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OH3nMtqY; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D65oZgHVeOdAmfzz6GX0bap8li73MvJrU9AOTY1ZbirmPxlhcsuClADJopXmbjLg89JLpF62L7V8Fgc0f4k9DbY8N9dWx9kcbwSbk9c1hWJXunHl4KZ3cP+9QkvheTUAj5GiHCmA0hlQeAkG1FPolavIixi8z6Vcm9k46vBM9qwTBUcfZ4GysrTgxm3Ob1NpXGho042zYbYUYHscIjJ4zG5P0VDLDSldM8GKS4MFGeDKFg1acRol37oHx9SDxW8uzLWt8imuX0OB+YXUmPYSRkUCjSXWMypnKRTuKo1yL/sahOLm7aKGkcVqJU1dK1XYHu9HtFLk9fUzH7vgpzzkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ummwOsFF89Ina+kHn0dNj3ckyMftyrH2ufVOlkq9puU=;
 b=FAB5IjRgDkbVkUXcLIsTxUG0WRfIL3HB6iWIqxwXxrIDcU20iVntdL1c6Vtu2hfmoQp1zPV477ahhKtPbQzLV+J4U8RU2IrDORdqjCaFyFYituaKKSz+UUm4VEDUC4Tf2fWsdp/rcATVhJU3VzOWZL2Put0OqrBQ48E3gQh9hpe384Iy+mN+r92M8bUX/4H364LyZH0rCDQok/f9JxnomLBt/JgC/K1VE4r/HSFulPSBlpd9gzcUEs0+jlPV0l+xPjt5D9jQ/hqnbvJvaiZWCuFSWuNQuM92cuTuMR/+bdVfQEQAw/adLCo4+PF91l4USk11/WRiAiq3bt/sh0nEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ummwOsFF89Ina+kHn0dNj3ckyMftyrH2ufVOlkq9puU=;
 b=OH3nMtqYoxXg4JBbJONeAgO0kiX3Il4T05gcbYjKCZjLaRl5RdGqdwZJnm1k2AUdTqreE8q6f5g0/5jPGMfDZnwk1DCrCfYboiUKKq0kQEwOew910eCT+SUBu0OMXjqMHMe+pd4H25rP88RdYCrB8/WBav5HkeFwUXWMsmiKdc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7242.eurprd04.prod.outlook.com (2603:10a6:102:91::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Wed, 3 Jul
 2024 23:07:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 23:07:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] usb: dwc3: Add cache type configuration support for
 freescale layerscape
Date: Wed, 03 Jul 2024 19:06:53 -0400
Message-Id: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3ZhWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNj3ZTyZF3TpFTjVGNzi5SUpFQloMqCotS0zAqwKdGxtbUALoPY+lU
 AAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ran Wang <ran.wang_1@nxp.com>, 
 Jun Li <jun.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720048027; l=1375;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UEwIi6PG2Ortvh0ehIWDp33CtLYDrZbyvTUJLpOuJ6I=;
 b=jARtpgxtmKpXW1wesdq1PKSuF25vX8ltBhZExZA+dT2I2aKAQmrj2m6L+MU2EMptzBWEFw8ss
 jBay/v9y+e5B/4GU7erO0hqZLSiH2g/XP8csyzex28KzkmFRgig46sx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: a16d7ce6-eab3-4692-278c-08dc9bb4de0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE0zQUxpdytWTmQxT2tGcFJMZTFZeTNqc3ZlM0QyNEhvZFhLVndZaEdsQUZU?=
 =?utf-8?B?dEJlVXhJSHl1M01GSzhpZjlUNytiVHN1bEU5Y0hram12b1Axajh2eXNteWo5?=
 =?utf-8?B?ZVlrN0Y2ZkU0Tmt0WEpTRWJZdiszQm1KbHQ1cUlzMnE0Y25qRmtUTkNTU3lE?=
 =?utf-8?B?UmpFMEhIM0tLQlAyYkRwUnN1NHJodEp0T0pOVTR1WmtlaGkyT3FhdlVWdFBW?=
 =?utf-8?B?a1pEa2ZFUkU5eE4yOU1pcnNTRXF4YmQ1WDc5eVV2MUh3VVJmK3ozVzl4Q0J0?=
 =?utf-8?B?ekl0WSsvSVNuT0dBVU41Mjl2cVlrOG9RN1FhSTdOT3d2RHU1OWV3NkdZbGFW?=
 =?utf-8?B?QTM5UkowMzYxUkVJdEx0TmRSZUs1SE51U0dLWVo0ZjZrbTRNWlFncWpmOVl6?=
 =?utf-8?B?eGxhSlNGV1ZaTGdvRU9lalUvQXhJQ0FWYWVRREE0MWljSndrUDJKZ2xaVng4?=
 =?utf-8?B?Q1VKbkZxRkZPUk52MEZRcnhTU05BV3JIKzlSWG5seFVaTmc0RjhtUVJ2RTVL?=
 =?utf-8?B?MWZ2Ty96T0dVR1daUVFSMi9teE5qTlVaR2hQYWVWRTNDWTNHQlB0MzAvMVow?=
 =?utf-8?B?UDNwa2lJRnFvbWkzNjlYQklIanJKUDhCcUpoaXhZcnNZTFI1OXQrcElqQnFo?=
 =?utf-8?B?N2t4WDl6dzlMdTk4QzJtK3lNSzRJdWNRU1dHSFNxM1R6MDVhdzFXZWg5OWVn?=
 =?utf-8?B?aVkzcHNRNnQ2ZUc4QlZaaFJIZjVkNFI5VUpZSEFnVmxUVjBjUHlET1hxbVQy?=
 =?utf-8?B?dFZrd3E5b3M4SUlYcGxlcjZ6cEZSNUE2cmwyY0tnUW5jUjFsL09tREJhbjcv?=
 =?utf-8?B?OFJjTThVRDBaOEJteFJ6MkRlcUhRZXFhRDVrR0IxWEEweEFySGNOZ3ZwMnZV?=
 =?utf-8?B?TGZNb2IzK2tmU3V0em5nOGFKdlJaaTl0SVRrZ05WZzhYWVZ5alJwNWJNa1pB?=
 =?utf-8?B?bXdESXI2YjFNOHR0eTV3YkNGK2pjNkVlYXVqVExFa0Y4eTFxOUtQcHNFVHUz?=
 =?utf-8?B?d3hoNTNVUXc3MGc0MUkwWUxhS3NVcU1UUDhzVU44UmduOXcxQkFqMVR6WXdF?=
 =?utf-8?B?SmZ2N1UzcmVFTU9peHd5ZHdQRDhxL0xCSllrU0xqSmVJcW1kL1hYZUpKUUNL?=
 =?utf-8?B?VGJKYXFxanhGRWo4MWtuVjhEYnY1c3FJcnFESHoza2x3STlwRGdyZFlpcnQ4?=
 =?utf-8?B?R0NQcHZGb05sZ2RGR0NGZHlFaUpVYzhNVktTc09EWElrWE9FcndNREJIaVBP?=
 =?utf-8?B?dTRUaWtYR0xsNnUyTGVoeDV1eVUvQnphOFFJZWFKMFgxaTFkWUg3anVDM0VK?=
 =?utf-8?B?R0U2bzVpaXIyTW8rUlFQTDN3cTNSZnBoY3R1Vk1vWDZmcU9SYkF3bHpwV09t?=
 =?utf-8?B?cStXdmllNU5KSjNaSXFvQUxnNkVwWWFnVEttYUxGcTRnTXlhNDhLUWdaY015?=
 =?utf-8?B?VFVpRWl0QktxRmJDaHdHUkoxTHdoK2tzQzg4SEV6R1JtTmp6dHhSOEJaVGRr?=
 =?utf-8?B?ZExqRHduNXpPSFBnWi93cUdNeWNDZnZnREpoQ3hXMXVDcHlJR0wxNzQxQzZQ?=
 =?utf-8?B?U1RtUkh5Yit1WFFHQTc1RjlrcmhIVjgwdC9Pdi96VmFPOFQySmZkWTZ6R2pN?=
 =?utf-8?B?VnpEOFp5UW9sT0tNUzNKN2J2UGt6czdxd0o5YkVnUm1PaEhQWi9reHRlekpD?=
 =?utf-8?B?K083blJFVzFjR3NabHkxQ3NoL1dQeXBPWmgrZlJvdCtUUjdEVGppb1Vnemd0?=
 =?utf-8?B?QUVXOUY1RUp0ODhlRGsrcEhmR21mSEU4YzVpZWJ6K0FUcVZEQ2lJS2xYQXVK?=
 =?utf-8?Q?EdIidrQD/51IMLazJ/5sxW3+HNIN8PY3aU4tI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWdSQmJUSHQvelY4UDZTVGJQUS95MmZtMnZnbG43T3JRN3dLN2EwUEZ1QnQ1?=
 =?utf-8?B?R2tyc0JqVS9qME5DOVkxcGFVNTg2Mjd5R1NITGxqdThhajQ4TFJ0MDRvMUlu?=
 =?utf-8?B?OWNzVWgxYjUyVGtRZjhiWmFLTmtVOVIyY0h1TTNCc3FQeXF0R3BHMGVUZ1ZS?=
 =?utf-8?B?VFlhS1BKRzRISS9HN0orKy83L01MVE5NTDVPRG55ZUhNK3dvRHZPWlVSbGE1?=
 =?utf-8?B?bThNbzhqWlAvQnkzSktFak5iZnJrd0QxcndkUzUrRGRCejc5SGtYUkxWWDNQ?=
 =?utf-8?B?M0M0V1JSN2YwTWNRdU0vbDVhQk1KQWxIdEhzeURkNndkS0M4WG5SN0VDMGN3?=
 =?utf-8?B?N0Yyb29venZkYUxJQ0dONkFQaUtENnF4SjlWWFNvdDYvWld1YlRoNnFERmZs?=
 =?utf-8?B?M0VaU0lCYlJzL2x2MnJ1T2tmeU85UmpMYmpYQ3U5R1Jhc2lLNDhJV2l3eXM3?=
 =?utf-8?B?aTVFd1ZiS295MWxLZnpWb0RjQTJ4STM3T2FIeitkaUlBS0V6SXJqVHJjS0w4?=
 =?utf-8?B?Zmx3djByM3h2aHA3YktPVFhIUjVZeU1rNk1udzg0U0NESDZwenJIcUZmeVNG?=
 =?utf-8?B?UEgxT2g1RWhaK0tSeU15bHlmN3lnNHJHcWp4RUMvdnpUTkkzVnBUbDEwL0N0?=
 =?utf-8?B?b28rMEx5c0RBdm1GSXFiMHR2YXNEbHBXSTNueTAzS0Y2SzJMcElsQUJZdHRK?=
 =?utf-8?B?a0hsY0NtVnVhS21sMVc3VDNGc09LS3NGeTFIK3A3eXdoQnNCaUZjdlNUWkNv?=
 =?utf-8?B?S1RnckhqR3J6L0Y5VldnMjF1TjFtMERRR2dlSDlIVXdTd0xxb2NoOGEwZ0w4?=
 =?utf-8?B?UnVVTUtCZ0tKVWQ5QVpXeTdSdTBtOUM4b3ZiOElpVFJjcUhoOEVlN0pVaXVX?=
 =?utf-8?B?SzRnNVRXT0VUdzJEeHM4aGhvTXVpRlVmQ3kvUDUzakt3aGRsVXJKa2RuMzlz?=
 =?utf-8?B?WDljVmVjbWtiWkpTdDZ4ZGlpQ29xN2h0UE1TdXUzc2RUb2lXSzBtZmhXbUQy?=
 =?utf-8?B?eUNrS3ROWHhKZjhXNWQ1a0hLWEFnWTROWnFVN0ZVNC83SkxsOE5jNUZTQmc4?=
 =?utf-8?B?cEJRLzB3YWI2aytFNW5CNS9vUGNRS0RHbTRKWGd2S3pBZzdFVVZ0OGo1ZkZS?=
 =?utf-8?B?ZkhVSkZ0WXNPSTFVT1VreUNaRWxUbmdjNS9ZTnhUaEUyejNYQS9iZFVTVkxD?=
 =?utf-8?B?L0dBTjlRcTJIbHZtTHo2TUxvN0s0MGZUNTIzbkU2eXZwZkJUc2g2bEpQSTQ4?=
 =?utf-8?B?bUZzUmhDeFoxNko1UlR4WVpBK0pOKzRTMFg4MVJHcmJ2UFJsVFpWMVlPN1M1?=
 =?utf-8?B?WmNHVk5JQWNtZ3NMRS9DWXo2Z25VV2o3TXh3bnVscVYrTjVRR0t3Yk5EQU9G?=
 =?utf-8?B?NjFpaEJwdjRQL016TXl4RC9BYTdhd2VmeDE1YXFxTGhnWGhQbE1LZVU3MU0v?=
 =?utf-8?B?NERpV2lZY3c0Wmc2Y2VJczJGV0RBRkxuWWdMQURoZHhsWDV3WWdBdGtkVGRt?=
 =?utf-8?B?a2NZL1ZCZEFZOXM5MTZCZDVucDFqaFdvbUJLTEd1bDNXWkprUm5HVjQ2b3k0?=
 =?utf-8?B?QVE5bzNLYWx1cmhkUXREYlh6OVBRdmIxQXQrQTMwR2RiSjY3b3M2Y1l4Z2hS?=
 =?utf-8?B?UkM5M2JrY0pHS2wyYjgzU3ZIYzU2WHY2VXFUZ3kzcWpWakF5QVVZWkNJOHAz?=
 =?utf-8?B?bXB3eDlwbjg4WkdnZWNYdmxWb050cXY4bTJ6cEtCd0U2SExiT1BhTGQxTUxu?=
 =?utf-8?B?aVkvM3RoTW94R2FZWFVPQUlQc1VwbDN0MWozYkE5QkFnOFQ5YzJrNjAySFlj?=
 =?utf-8?B?VCtmSUFZa3crOXoyMStJcGJzcHhPSmI3SHZBUC9NVHV1czNpSUdxOHhUWHNt?=
 =?utf-8?B?TzY1VHVmK2duNmlhb1hLZUpxTjVlMU5qWGl2eUdMQXJTV2ExeGhkRm9lbWtX?=
 =?utf-8?B?OU9jQ2tDWmd6QXZXWUJYdjZTRmNXZXlaRm1FMjZhRlNHSkZUcndxY0t6cHZl?=
 =?utf-8?B?K3M1eklMSEdZbFVXQzdhdUw2d1VwcjA0eW0rR1dvUmNMdmU3T05wVkFza1pR?=
 =?utf-8?B?Z1hXYndodXhlNFFWSG1QQXJpZ0x2SDZTS3lUWngzS2d4cnlxcXhSQlVhNmk3?=
 =?utf-8?Q?5c9c0GO8Jy5g5Y4+kGOPIUv9N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16d7ce6-eab3-4692-278c-08dc9bb4de0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 23:07:10.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTHbSMLTFew8uQvEt72TB164dXMO1MeInvIDmodM8/wvlYYqV+m4o6KU3eMbzMu00WRq0lghW3rRHdlv2q/NLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7242

There are several attempt to upstream this code in past year.

The first attempt:
https://lore.kernel.org/linux-usb/20191121095356.GB7503@b29397-desktop/

cache type is dwc core setting, not glue layer. So It'd better change in
dwc core instead of glue layer code.

The second attempt:
https://lore.kernel.org/linux-usb/20240123170206.3702413-1-Frank.Li@nxp.com/#t

DT team think there are not variable for property 'snps,dat-wr-reqinfo'.
And suggest use vendor compatible string.

This is third attempt:
Compared with first attempt:
- reduce compatible string to one 'fsl,ls-dwc3' because all setting are the
same.
- move update burst type code into dwc3_set_incr_burst_type(). and check
compatible string 'fsl,ls-dwc3'.
- Using bit field help macro.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Ran Wang (2):
      dt-bindings: usb: Add chip-specific compatible string 'fsl,ls-dwc3'
      usb: dwc3: Set cache type to 'snoop' for freescale layerscape chip

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml |  1 +
 drivers/usb/dwc3/core.c                              | 12 ++++++++++++
 drivers/usb/dwc3/core.h                              |  4 ++++
 3 files changed, 17 insertions(+)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240703-dwc-5be3e378ddbe

Best regards,
---
Frank Li <Frank.Li@nxp.com>


