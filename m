Return-Path: <linux-kernel+bounces-169173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E78BC474
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C36428121E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B713777C;
	Sun,  5 May 2024 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q9p1Zk2y"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557E136E3C;
	Sun,  5 May 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714947314; cv=fail; b=DK0KUQDFh8sPBTaKfdzXUzCgPVIJPhDpqepYjhGavXDpFRD0DK14Rf4wB0xf+j28lX6n/AC3mmTc//79PYFPIgaujxsXcjvjro5vl/gaA+wx80b8P5fUUqJH9obvRxSxwZ6/GhrV4MiO97ZYAuvSDbYk36XyERNKf76M0IXXado=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714947314; c=relaxed/simple;
	bh=2kWmQQHThPh5GdBVqYSvbSB2oh03GaGH7UvMiDygKo4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VpM4/33BH5qBJ+b5mKBGrg5IyOKPVL68xCDsPp4woVJUe2Ygn8pqirNm2Z+eV4bFxHZahKJLcQ8Z0SK5mUS95KDHWrJh8b+tlbNRURZ5DfZevzdtzMErKObwL3sHRkEE2rbYrOrre3cPIWcRTQm7CcGiOtMB/o+0AEu8+4mvYrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q9p1Zk2y; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqscDCl4+v/Ph9Ol64pvWm/SHVtFszPrTu46/T19pt6rAIBs2F79SY49hsZ6vN/0ZwpBkSz5+dnl7EobwLL9raxk0Rxn6Nta6JIOocTlpA0VStCyyx53BFHByFk+PeR2+EjpjKZp3/eAwvjUsolFnhxY5swZzblxM6X8clJ5i09xVuVO0R5TWtPYsL/CFUvpY9lQkgESN1zoveREPQPTT45E0vzQAA/YzSZY8uTpUQpW4pxTccd+RfuNdmNclP5nAcCkCdLeZWKlbs6dfMXV5z4PV5miE6RPfXv9FSksOMr9HKrzWaY9GYKwNZ+Q7tLOW8SPLSFQtLn/B+C7Yase8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBDX7Gl3BW6R0tKb6yUK7tQGpXqcbfV7Q3BpzH/i9IA=;
 b=LpUjoEXvGk3tSsyAZr3chwvyOK5V849w/5y9t6gpaMfX9MIZDpbnDfTY2/ca10pyiNQSjh/YWlVG9aBd1o5ggetz1R+Lw+up6YhDhmewYyTk92P1DpNedPWqhJV5rIJ21XLFc1T8YbH8XEryxfgoHXQgi/znuYJqVeZLax6XJsB7Ns4w3KmU24e2cgfTdXj+XMwwKiQQ4ongbJElTCXkf3Q+jd8Tph/DSbbm4NCfRildMBA3XpG0AL+QAOqyMtBbFHWaoYnW7uucnNOc8MZW+1RMeLLDUkcL4TWC0FUH+Z+AHZdvePuEPnydIA3pq/NbKulQE+oYBD1qfVzDpp0wyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBDX7Gl3BW6R0tKb6yUK7tQGpXqcbfV7Q3BpzH/i9IA=;
 b=Q9p1Zk2yQAwclJopY9t19/OPoNOvaxdKfmAgEGb4krPO1JuEZIOfFRKhBsDznPgGLPrd/b2VrjytIl+IHO1IBTEHmX+MLPSljAW7r1VLi4c5ANMn52O2z9eDIgGyWNbYQ+9WIpzAUoQcKUGVj5qsU4BZezDL+CzveaoQqv+bFLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 22:15:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 22:15:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 06 May 2024 06:22:45 +0800
Subject: [PATCH v5 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK minimal
 board dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-imx95-dts-v3-v5-3-5ec9b99cfb2f@nxp.com>
References: <20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com>
In-Reply-To: <20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714947780; l=2506;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=PQ7/G7yY0H53FP3CCdrwQBSGsFle18NDE1LaQVkOtRY=;
 b=4ZXy4mY3vf3Px7V22I2nOSLpDk6V0ae6w1tLicKQmrnyy6uQnR7/m5LJ9tunzD4wyQEmZ8+90
 4OpngbNrar1BGBXB5O9hgTM5ZyMSFnRjPlWVcRK4GqNZQ/9Y882YJh1
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: a4778d19-90e9-4ad2-6ad3-08dc6d50d197
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTRGeVloQm1JVVFsUkMvcytKTDlUaFBGYjJwaFAxSmlkTDRwV3lTZlpzWEZZ?=
 =?utf-8?B?eXAzWWNOVEpaNVlBOGc3MGg2bVFGQmwzVEQ4SmtkNW5SVVBic1Y2WlVjMTVr?=
 =?utf-8?B?dGU2clRMNVFmdGpFNmVISERKb0pweURZejBSdWNiR1F3WFZSdmFnT2tXc3oy?=
 =?utf-8?B?bVpmUkhPSlQ4RGdTelpMOGxxeUVTSG5BMCtROVh5Uk1BSXA1Q3ZQOEdXVE1G?=
 =?utf-8?B?cW85aDQyaWt1WGFNNXJ0MnNmNk5zQTlZcXBXN0lmTTdRMS95RERKUS9mNngr?=
 =?utf-8?B?RnRGK3JkUjlQMkkxWDlHUU1KbFdLdVl0My9MOU5Zb2JreStqbG5xMW9qQTBN?=
 =?utf-8?B?TXpjNUJFL2tGWHNFeWpubElnV0plZklTOFM1UWNWczg1NmFuVExjcmxFUDRj?=
 =?utf-8?B?UjJDREVVM3QzYUJlYy9TOWdDMXJxSWx5UXY5cWxNYVJ1eHJ1a3ZzYTB4c2sv?=
 =?utf-8?B?dGhrWTUxaThXOFlUazEwQ2YyL0FVZGsrWExyNUo1b2tJbXh3UGhpYlNmbmNl?=
 =?utf-8?B?QTdSTE1nd2JyU1R2SlJJWHMzTFU0M2JWeTFYbjJETE8vZ1B2Nk01WWJZUWVM?=
 =?utf-8?B?UE1mZm04NnpLSVlqTGQ5dHJ6Y0tYVmtJMlVMNmw5dm56STFyU2VhaEljeFRL?=
 =?utf-8?B?L1ZOWkVjVDlaaDJVNktyVzJ0V3Z3ODVCZHlZV1RTZG9YT1lHbXlObWl3N0VK?=
 =?utf-8?B?aUVLazVOWkxvK2FxRlQ4c3RZZktrQlhJUHllaTZ3dmVOc21Jd1R3cUllbmdG?=
 =?utf-8?B?bnJPL0tXVytyL3lLN3hkMFZvVDFiVTRjWDgvay9FaUlnUGhHcS9HSUVBRlht?=
 =?utf-8?B?TmZsWGhkMXNJeDA0bHl5cWRWNGdaaUpUSm5Kc0lzVXJRa25MaDB5RDFUQ0Q1?=
 =?utf-8?B?cTRlQ2U0T1JuNjU4VGc4dUZQSFpSVXBCS3A1emVWVWVhZEFBVFAzVk1jd0I0?=
 =?utf-8?B?aFdSYzJZMG80bjUzY1ZGUzFINHNWdmpKR1QzakFMVHl2d21lUnBFbWxFWHJr?=
 =?utf-8?B?dkFxZlZrSWtHZTM4MUlHRWtCZ0p3VXBGTE5mYnNKd0ZJWG1QWFZWNThkeHJK?=
 =?utf-8?B?enZmc2RDMThPUk5laTE1ZzhPT25iRWN5eWtQOGpQdHg5RUE2OStmbk8vRVFo?=
 =?utf-8?B?TG1KZXM0ZDFWUVM5RE83WWdTVWc2ZzZsZVE2RVpaRGlOVUc0OXZjYzBxeDl1?=
 =?utf-8?B?ZCttYjY1YXd5Nk12MkdaNm8xUWt4eTdiYTRtekpjMC9SVUdlS1J5N0NTZ3d3?=
 =?utf-8?B?ZjR3Y2ZUbU4xOWZGZFZaeCtWUGJ3OVh5RlF4VGhSMFNEbG8wbHFjbUFzWU05?=
 =?utf-8?B?ODk4RzczK1oyTkJBMGJFallOVEV5ZmVzVzFiZ1VibmxGOGROY1k5VUJBb0V5?=
 =?utf-8?B?VGc1V0x4eW8ySGl0QndWWVA0RVFwWnZzVy9ZWE9SQnVBclZiQ1d0cnFsOEd3?=
 =?utf-8?B?alpMN2dOQWR6Qy8zTUI0RTQ4REc5MitDZDBOcGJRa29WYlg3RUV1b3R5RVBo?=
 =?utf-8?B?TW00ZExLOFV4QlRFOVBoQXVCTVdwb1NYclRyQnFwZllnemx2NnRWWDhJbW9l?=
 =?utf-8?B?dGVKQkhiSzNRdS9CTTVvQjU0eEZDU21EdE5VbDBzczRkekhQcjFvYXJ5VWtI?=
 =?utf-8?B?cGZZRWJuR1V0YVhpNFYrdGwrbU5MNXZ0YmFEaVM5eXlnVGdScVN3YzBTSFU5?=
 =?utf-8?B?cGVsYW1vVlVLcStjZTcyWlEvYlZWSm5iWi9YZEwwMmJma2RKQzdHb1lUcjJw?=
 =?utf-8?B?Sm9lM0FRdGg5WGRrZUoyc2JUV0V0WXlBQ3NEME1Qb1dwNHpMdGRrWlBVdVlT?=
 =?utf-8?B?L0syd1VmVFdLbHlMRXRWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajdDSWRYMHFKQ0JjTEJIZG1GbDU0UTd4aXZORUV5ZXJZbElBemxNSlgyYmc4?=
 =?utf-8?B?MGwwUCt6RzRneU03VWZOTmlRb2RzTnVRajdZNExIZVQxUEVQU1pBdTRHZTlY?=
 =?utf-8?B?TVhoZnh5Y3BQSjQvN3RtVHBJeHBRTVZtU0NUcHpKQno5eGthcytzb0pWQWJI?=
 =?utf-8?B?YWNaM3dWcEdGcG85WXBxSFRiMUEzRGlaT09GWnRpQ3FWTW16ZVFOdkdoZUVH?=
 =?utf-8?B?Z2EzZ0tER3dVVjlKY1VOekoxazNGNEdYM0h2ZS8rdTdQNTNsR2RtNGV6TjI5?=
 =?utf-8?B?SnlxL1ZoMDhQeDRyMEFKRmgySjlpR1dsdE92eHlYWTVyRUpPZi9oaUUzR1I3?=
 =?utf-8?B?S2pKNFBZOUxUSEUySDFNS3Q4MTZ3OUxQL2NOOXJYeHg3Zmx4RW1tTDFRa0NH?=
 =?utf-8?B?S0JLZFhWNnpoS0c1T2N6dzVlL2RWWGduRVl1cmdWMXZvc1VUSFB0OWw2R1VC?=
 =?utf-8?B?WTNnQ2pjdGlHTjJzc3I3OGJsQWtxRi9zU3hMc1hlazdrbCtjcHZ5bUZPeWRI?=
 =?utf-8?B?MCtRQlRzNVh3cXAvYlowdEdVYnZncnJNYVhqNkpHclE4QlJQZS9ma2cwYmpH?=
 =?utf-8?B?eGVMbFlqc3BETHRheGh3ckVDREQzK2tWS2hBVk9zYU1XSVNmRnpTTHJDZjhI?=
 =?utf-8?B?d1FVOVJWK1FsWDl0bE1sMXhTVnZybFhyWHB0NDdlWlpRVW1zcWRSaVFOcmN5?=
 =?utf-8?B?M2tPMEVxMnZ4Z1haSlNHYkhSVC94dnU1YmpEK29FUFBhdFhXQVRaVXhHT0NN?=
 =?utf-8?B?aUxHSW56SDV6dmhtR1dUaWN0bkhiTjVZbCtsbS9odFc0TUNzWDAxeG43SGNV?=
 =?utf-8?B?TnR6bk8wYW9RVDZhdWRWOWJ2SFQrOE5iaUduYXhTd3UvclFqL280QmgveXFy?=
 =?utf-8?B?SXV1K215bThRVTc5U3o1VW42S2ZhZDlXRjROUG5UM2pmTEtMSFlJRnhuMHVr?=
 =?utf-8?B?UnJpZ0djT3p3NWpDS0UvanEzZm5HZVRCWUZjNkxTejRWNFdFYlBTcWZhVkRR?=
 =?utf-8?B?MWsxNCsvajBkNERZUUkrR0lqWE1waXhsQUx4bkFVUFhIeFloQ2hFaGw2UFk5?=
 =?utf-8?B?WVB0Rlo4UkpBZjNTZlVqcFBGdGRjSEVlK0lvRktBTFdBYXJOWEVRTUVlUzV3?=
 =?utf-8?B?MHY2dEluYU1aWXVSSlZXbUVWVkRJbllnZHN0ZmluUXNaLzFFZ1Uzam5zTEx1?=
 =?utf-8?B?cnJWUmxML054TUh0eU5pZHF0aFM1UmNCNHo4aUFIN3h1TjIwdjF4TmovUDgx?=
 =?utf-8?B?WkFRRW9oVVBYd3E5dmFpTktyL2NhMzd1WENYNEsvTmNQVG1yak13VVhhQ1du?=
 =?utf-8?B?TWZ3bFpJRW4yL0NhMzYzMVlTSEJTYnV2NlN1SnltSERNVVN3NjBXN0JIS3JT?=
 =?utf-8?B?UlAyVlkyTHFnZ0NvV0NFNUorNDdVRVJORHdmSHp6dlI4U1BHRW9TRVNVRmpJ?=
 =?utf-8?B?U0QzRWIxRThCVzlZV25UN3ZwMHZxNzRHd1U0eEF4R2tUVmh0d0M5OEJPS042?=
 =?utf-8?B?eDVHemdZWUU3dFFIaEp4a0ZESWJkY05IZFhOTXh4cGZFRllBSi80VVVlYTc0?=
 =?utf-8?B?SFJHQjFUL0JDbG0xekFyODhtYzY0aUV4MEV4V1d3WU9yTyttSDdac3FWclM1?=
 =?utf-8?B?MWVvOExSTHRPd0ZQSkhTMzBLT21EZ0lwZGkrNksrUm8wSUdRLzJNWUx5ODl2?=
 =?utf-8?B?TlJCMUl1alV6NCtzUHB0bnJmdUtnbDNMc3N6VHRWUUlIcGlDRjhHeVJZK1hM?=
 =?utf-8?B?TUdJWTVsY09icStxV1Irb2RVT2VTOFpQdVdLcytRa0hGSlFqRjE0MndFeTVZ?=
 =?utf-8?B?dmVTek8vbnJsdkk0MnJmRkkxWnJYdjNmS0VFK1l1T3J5K1MvbkU0WjRETHk0?=
 =?utf-8?B?Tk9OZitLaFB2eGVBdGJrL3hGbFovY0xDNEtnV2JkWVhSVjllUkJBQWpDb2V1?=
 =?utf-8?B?OUNnT1ZCZ01RU2h0RHg4Z3ZyRm1aQzRld0xrT3QrWnpkNnN0MS8xQmRmVHox?=
 =?utf-8?B?cGMxSWM2bWhKUmJzT0RxRVgvTGJtS3NidnJMR0g0NVFXaXRQKy84LzloQjVD?=
 =?utf-8?B?WVZZT093NDBoZ1pEM05tejdneHdYc1RNenh4SElNamw5TTVDSjZCMWlHR24z?=
 =?utf-8?Q?2GemGBXigrffGKCwtXdnLkI4G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4778d19-90e9-4ad2-6ad3-08dc6d50d197
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 22:15:06.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjM7Jir5W4DptwG8Z1M5tnZCi/VRVmoOY0lbjuvipoukJHqQG3npEHO+312iLbxzqKQFjjNGuUnXQgMFW6yNhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818

From: Peng Fan <peng.fan@nxp.com>

Add a minimal dts for i.MX95 19x19 EVK board:
 - lpuart1 as console
 - sdhc1/2 as storage

As of now, because scmi pinctrl support not ready, so count on
bootloader to set the pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |  1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 70 +++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a4..057e23fde780 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -236,6 +236,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
new file mode 100644
index 000000000000..ce91b7c12467
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include "imx95.dtsi"
+
+/ {
+	model = "NXP i.MX95 19X19 board";
+	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
+
+	aliases {
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+};
+
+&lpuart1 {
+	/* console */
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};

-- 
2.37.1


