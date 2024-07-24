Return-Path: <linux-kernel+bounces-261204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631DD93B41C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC87B239DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E06A15B963;
	Wed, 24 Jul 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CxXCMnv0"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311015E5CC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835982; cv=fail; b=jJm/w7YxF+xyy1XZc0cYIJBfA/I1h9e9DVap13P01S0D6+8YaRvZ6yJxP62jKtCLTKg/VhnjSiuIT9M9ZOnoo52gJUzw4DjtYJhLzbG32rtJhWBRbfaB+DtC2wufSQeqe752H6L1Gbr19yqEaI+s/pFbME2lD+JsJhYtJUcVnBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835982; c=relaxed/simple;
	bh=phlwJ/9jw9NpeTB7NJPyHYpdTuYWHApnsz953oBcxmA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D9iGTNigg7Gzxsr5J1I8x0b7LKyqcU6xveg8NfDxN1rYqFqUSe0vJVzJR9WlSfa1dxN9FVXpxcJsy7kccf3lFz2zJW1kuziJ3gl2N0WJPgJtMFaC5+RHYKwk0eItNkQ2bjbzDQjYiLGlbrk3NYXWomdowdgxiK3vH28t1rVK8ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CxXCMnv0; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuS6vfRobAMe7ErioX4SAqCZG4KGuoRDl4R1hj5/BjaO6qCBXDhFRgJSqH6xLuY7m2mfX280EqHDhB9Vx8Yp6blxevTypxPD+ETrzuxdV5jdl7UB3+Ttu5reKOJbbrd671jF7C0gPoT0K7naZThJ2Uu+5oMgawg2nKMLHCtQGYvrdLgcAaeF6ysUyjn2jEYRstmtJvKSXhYE6ORNtoAAgf3ENzeSe7Fj4vTyM8F2eXT9y35WpskVRVlO6ldDJgGGTf+NbJKaBEmg17AA44xsRTvAbVoLDLQ/OF9PdqryGhREjPhpj3JE55Y82X2zDkedxyHkGsFK2RIJvSkyli4L5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khB9K849nl/MU67dxO7G2LRxt5J+Bs0EnkTKFa+J0gI=;
 b=GguIrD33wfZVOlWx0Wf6FlX4el4py3JlynM2di3srKwKfhhGRd81u5DG3/DdmWvPe6lWU9kgpd0dnKnNHX9CCAuh/AymJE5JBgef/bDtKVZebTRHM5C6rzSYR+vnH/n4mnCOdpK/ZdgubulUSF5XQ9yVVGyh8DdJiK1PVkLoJosgf4iUITOT26iHVwtoaRxKrUPOucRE0CzdKQIeZ5VSM43zsZYiuWFfq7WWOjM0sBQ/OHOMyQFEJSLpR3dHYL5eA7coxSvaHymkKXnfHQCh7+YvuoKr/+n83Va/2fhGGNWhm4LmZaUqZmOmVjvhRrlzrSUqduxP3uXOKS+hA/AO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khB9K849nl/MU67dxO7G2LRxt5J+Bs0EnkTKFa+J0gI=;
 b=CxXCMnv03TqgWktSBg1A+7x3Wf8DNLctSeAjyfiLm3O1R2YBwysXjXw9Jyf3D3CY5Mci6AigIqvvg8qQonyfM9P8FkRN9hIrLD09a3wvtXiHu31NjBNY56kKIf4IAPgtmIG1GCEaje93rAfTaSUPO8q4/isxGca55ndfTQforAunaY0yDgZg48R2xEiqgaH1wP0iSG5HTA1e8hb3a7fXdSRNq5o+k/5wACrTjF45qxKd5jQa6jyI/4AdS6xQ/V8rjcbWFatX94OqK45Qa5p/+Oq52RbqDVXg3CPvAu06+8NRLSvNj0FawlqQ4JoRWk8SBw/5QTsXN+4z3ZPR7QqSMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 15:46:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 15:46:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Jul 2024 11:45:49 -0400
Subject: [PATCH 4/7] i3c: master: Fix dynamic address leak when
 'assigned-address' is present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-i3c_fix-v1-4-bfa500b023d6@nxp.com>
References: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
In-Reply-To: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721835962; l=3637;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=phlwJ/9jw9NpeTB7NJPyHYpdTuYWHApnsz953oBcxmA=;
 b=bFam1yY7BeGLoVc3lylUfnBvI0dojbpBk9GROZZaVWtnPAY0urR9VS5sJ0CzXLcUYp/FN6Z6r
 AqzW7pFiOXCApRF9lwBMPP7wBPBbgsfPv6QoV3bH0gT1OdPR21aEPW5
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 245238aa-7814-4c7f-1404-08dcabf7c1fe
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d0FuVkgzNE5lUlNsOGxNRFBWMU5sMm5lQ1dra2RrM1d3dnlUVkxTM2VBRVAy?=
 =?utf-8?B?UnMyL0dabHlvTHhPakJVVVZBcG4ya1NDd2ViSTFkeElTT1R4UDZwUE9NelBv?=
 =?utf-8?B?SDZSVWVhU1d1cmwwL1N3d0xJMVhYWElOVUxKeVlHcEdyNnNVSEJsVmpsVWU2?=
 =?utf-8?B?T0VGc01sdHJGTVlBZ2VvZ2ZrUTYrNW9mb1dIZ1BWWSt1ZU1peTJSKzBkOVJt?=
 =?utf-8?B?VmpIMnFyZDhSVmFwNzNYTC9CQ1R1eEd6NmU2Z2FaWUNSUko5NEdJbU5hVVlV?=
 =?utf-8?B?Z09qSlpvZjVuQWN4STYwdFlPcklUM0NLN2lUbUdMSkxORzR0a3NNeCs2dExl?=
 =?utf-8?B?QjN2VWVFT1U5amVZeEg4Qk5jWTZnTG1BZ25POXB6U2JuQ3BIdVAxWlJzR0VO?=
 =?utf-8?B?S3BjVVJvY2hKdXZEVWFVa1VEK3FpeUtLVXVGRyt4LzFwSkFadFJSalJZNThS?=
 =?utf-8?B?NG0weDBkT1ZzQUdHRXRyUmJ1SG9rNExIQWhYejZOMzIvdXVkVmlwUlc4L1Fv?=
 =?utf-8?B?WmVaWHhuNk8vSGNxenBzRnA0NjlpR2NaTTFwUSttaGJTUkZPeGJoTE5JZ0pa?=
 =?utf-8?B?NGY5Q1NlRm5uVWNpd3RTM3I1QnlMWDVFa3d6MnpjT3ZyalJhZ0l5NHZCT0Fk?=
 =?utf-8?B?NFRrMXRjT2VVZUpkYWlIVjJ6RURONXhrbHhIdjJ6R3Z3VkVXNFluN21naU1H?=
 =?utf-8?B?ejA3eXNkdWlvMmJnV2ZTdFdvMzhNYnF6d0cvbGhQTEFPNXdLN1J2UUFyMXNC?=
 =?utf-8?B?R1lrT1NpV2hYdU51U015K0REL2w1K2pWVUZPbHZJV1RVdGRGQ3dncWxCZFF4?=
 =?utf-8?B?L3pIZC9HMnhjWm5OV3EzY0x1TU01U1Nzc3MxYXRJOFZ0MUVnSWRHUkZkMExT?=
 =?utf-8?B?NC8vKzdKVHRXZ2kwMVlya2hpd0wvV3BFdXQyNDZOWjN3ZkRGbkdLSkZDNnBQ?=
 =?utf-8?B?Mnp3elljQVBiVE1EcnJUWVZERW5jb0FuYU9wemNNSTBQODl4NE5zN1lobkFz?=
 =?utf-8?B?U0NZNVlUY1pYanJyOU52YktYbDVRalNjMEpBK3RMVnVnbGhDRTVYY0FpdlI1?=
 =?utf-8?B?Q1pQcEs4aWNNRTF5UmJJdjFDcnBuUUNFNWphR2tSUU1tWnRhelNZK01Za0R2?=
 =?utf-8?B?eDRDUEdMQytFdzhjRWpJK0RkakM4anJ5NmNpcmhBcHZ2em5Wd0tZNTl3OWdj?=
 =?utf-8?B?MWsyZWhCNExaR29rWnhQZjJYSHg5c0RUbCthMDJYMWdBK1dwaEJyN1lWSVhw?=
 =?utf-8?B?blhnbHQwRURDd3p5WVZ0dDNhbFAwQmVMY1N2aGhOODZIeUd1TWNvY1J1eWda?=
 =?utf-8?B?eTdiVXMvQ3llMjZNcXVIZHNtY085aDd0c1g0SGIxM1g3c2tKdUU1NjBsQjFC?=
 =?utf-8?B?eGFBWXNESWgyd0hOeEt0VVdRTWFtQkdPSlJLdWNuZDhhRE5COXBEb2xXZUR5?=
 =?utf-8?B?MmNhYVl0eWp3VGF3WjduUjN6eUJTUnlVRXk4YXNhc1FLeDRsNHl4UUFvWFB4?=
 =?utf-8?B?THhMdStCTE1wcmQ3UzNMWDUxZmRQNzM1NlYyOGJPK1ZVQ2FNZm1uWXdGblRT?=
 =?utf-8?B?dFJVNDErYm53UTVRV1lncUpJRnFhNFduU0N3aER4Q2ZYcEJEWXhDd0NvTXRs?=
 =?utf-8?B?aEF0bTM4bHRzMmVSNnFhMUd6S1RBRlkzR1NnRi9iZHRKWnpJa3hDNkJOcjBO?=
 =?utf-8?B?ejRXMXdpUTVtUEF2ZVRRVzZvZ1pVWExnSjA3amNCT3FDVlVYSzhPcU5MaVhE?=
 =?utf-8?B?ZmQwU09CM2VvWUpXdWZoVkR5MnZoQy9VWnd5VjRwMHZLN2tXbkxOdEtHbFYr?=
 =?utf-8?B?aFdMazk0bTNOeHZVZytJZzg3SUJZbnBKVXA5a2lTbEczYVVYWURtM1RYYlZM?=
 =?utf-8?B?ZzE3MnV2RC82UHdsdTFrVXlEbU1DSnN0bXp1YkI2YlVETXc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cWlQc1VjK1dLVE1EZ3YrWFJSUUh2YWtUM1hZTjVSYk1GdVI2bStuWjRBZm5E?=
 =?utf-8?B?NEEyNXlPRDB5MUJ2dFlCNTVuMXJBR1MrU2o5Y0EvS01LcklUNHIxcjlvcGpB?=
 =?utf-8?B?NWxUdkYyWVNxY1QwTmJxMTNqTEVhQUI0bGo0QW14VmlYUVUvMDF4cGRrK29I?=
 =?utf-8?B?MC8zSXlRL0JLSjBqTnVRN0d6VjZmOGlrSFA3SHF5cHkybjJYR0hscUhrZGx0?=
 =?utf-8?B?NEs4a1p1RVAxekNtelVLOXJPaGU1RDE3RHhlait4RnA4TzhqWmNtd1NsVXZB?=
 =?utf-8?B?U2hWTlBWb29MMDk3Smw5YlM0ZDI3QndncDV3SGxDRXNOdk5La2JEQnR1ZzZH?=
 =?utf-8?B?VENtZi9XN2Q1WHRud0JDS0JUckRCZllHSUlqU0xHN29ROUF0dE40OGN0QlJX?=
 =?utf-8?B?c280bnhkRVY4RFNRRnl3U3ZDbmx6Wm4zZ0tUd2VXSFR5WWEwd1JzV0c0NG9p?=
 =?utf-8?B?ZnRLWjA5MVgrOHV5WVdwekZVcE1oREFLYVFrZXFxL1UzZThmVE1rRUFTL2V2?=
 =?utf-8?B?ZzJacEVhTFpJdFZZblRJSEF2M2wrQlp0VUUraWMwbHNiUHFZV09uV01GdVBz?=
 =?utf-8?B?M1J0Mk1pS1cyQ1BCNU1ZQ1M4eFlETDdqUXBqWHEyeXJjM2U3ZEpGcUcrdEQ1?=
 =?utf-8?B?V0piZlFnWjdlK2RPQ2M4ejd1d2JtODRjeXF0Q1J5N0NwYk41UkFMSUhvY2tV?=
 =?utf-8?B?MktjU2t0bE82bWlPK1hOT3ZkbnhVczhYWDdhaXZRTUZwMnFBVGxORGNkQjM1?=
 =?utf-8?B?ZXFMZUp6VVFHOEdFQnNTYmlsZFZSSVpocXZ0eklNeGd1Z0hqNUNBQWFQU0x1?=
 =?utf-8?B?UmFFeVhlc0l3eW9xN1JTV056KzMvSU1sbkQyMlp0Z0J5ditFcVNrOXFOc2pC?=
 =?utf-8?B?bmJBU051a3JRRHNRMGxyclhBaEVUYTB0RmVlUFlJZ20yWFNkQ1pwMldKdUs3?=
 =?utf-8?B?aDVpeTF2YW1OR0poaUxPMVloREtvVkdWd1RpeWE3aEFSeHpBVEEycVdWSllJ?=
 =?utf-8?B?QUxYc05pVktlR3FiaExDR0pSM1JGWnp1NUtjbjRHaHp4dC9ZdVk4Y0V4ekcy?=
 =?utf-8?B?UCtIUm5tSGU1NHByTUdGTjdHUmZPMjFmRWFpbkpKL0NoeFkzVk5tUDJOV09I?=
 =?utf-8?B?N0g5ZGI0cU52cm8rZlBIaVNjNUdjem1NZ2laazloLzRwRjFOczBNR0hLaklV?=
 =?utf-8?B?TDRBbGl1M3hoVUZGTEptMDczZlJiNWw2SXRQaENpT01nWmVQQkQrYXpLZTh1?=
 =?utf-8?B?SzFQbVNERkU5ODJBdlArNmNxS2lZd0V1d3BWc2Y2V1gzWHRLUWNCRXFVc2d6?=
 =?utf-8?B?cGh3aXFzdWRSNXRRalREQXdxcVRwMEhnT1JFbFRZT3BvVDRxN2NaK2Qrd3dp?=
 =?utf-8?B?SGZyVU5vUG5WWlQ5Vm9ENGlyWldtb1lSUFhRZXRLN3VXaktSRmdKUCswRlVv?=
 =?utf-8?B?RUxxWDR4RG44NkdBb1QybDEwNnlsM0ZQcDNZNFNqUGZ6dkJjdHo0V2poaEt5?=
 =?utf-8?B?M29mTUZsM2hSUnJpWXczajVnNVZkcXNTNCtmb0RyYWQzdVgrYy9DQmlaSFRE?=
 =?utf-8?B?OVFhMldFNUtMZkI0akc1NU1QY2tpMDFEZmZMeFAvVlZFSEtjNktTZDIyY1A0?=
 =?utf-8?B?OUN2RDhycUhtSkRNSGVuZ1pwU1duT2F5WDNpT2NFUjB1Mk9vV0JyZ2RIdk9T?=
 =?utf-8?B?SmpHQWNEMUw1N3BEbTRxV0d6Y3QwQVg4WmtLcmFuU0dFSnF3bmV3eWtxTzd3?=
 =?utf-8?B?elRxZVRsOCtUSkduOURHQjRkdTFQdThTSlFLcm1PdDZmNENpaU40NXF6SzhC?=
 =?utf-8?B?cW11MFhKK2IxV1dkOUdXTFNSM2dQTGdmRWt3ak9nNklLK0JFSlczRnBVcnBW?=
 =?utf-8?B?dUFxazI1SXoxRWpHcUdoaDUvdkNZUjRMSUR5Rm5WQWVoeDNFNU1tWlgxNnhw?=
 =?utf-8?B?bnFwaEFGNVJmejJzSWtJczFNdm96cUZRV3VqamVabDg0Qk5abEx5WDArZ3lO?=
 =?utf-8?B?alNpd3NSUzM5bG1paUNoVGNvY3ovTDhybDcxd2Z5OEZoNVlvb2xxOWd3Y3Ix?=
 =?utf-8?B?bGI4VW5kVU04TGNrVFhMalJNVlIwZ1ErdExQV05aZkJ6NW5XL1U1RVpiK2pE?=
 =?utf-8?Q?n3eHau2X76pdmy6KG1SvaGj0O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245238aa-7814-4c7f-1404-08dcabf7c1fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:46:18.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZ8Dms9LO55cyO0YVZc/zaLhzO8f71rYPTmRbm2bnPIRWOjEFB03YV/gPYqjyWkz7McShbdfTM4x/Fy5VLk7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599

If the DTS contains 'assigned-address', a dynamic address leak occurs
during hotjoin events.

Assume a device have assigned-address 0xb.
  - Device issue Hotjoin
  - Call i3c_master_do_daa()
  - Call driver xxx_do_daa()
  - Call i3c_master_get_free_addr() to get dynamic address 0x9
  - i3c_master_add_i3c_dev_locked(0x9)
  -     expected_dyn_addr  = newdev->boardinfo->init_dyn_addr (0xb);
  -     i3c_master_reattach_i3c_dev(newdev(0xb), old_dyn_addr(0x9));
  -         if (dev->info.dyn_addr != old_dyn_addr &&
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 0xb != 0x9 -> TRUE
                (!dev->boardinfo ||
                 ^^^^^^^^^^^^^^^ ->  FALSE
                 dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 0xb != 0xb      ->  FALSE
                 ...
                 i3c_bus_set_addr_slot_status(&master->bus, old_dyn_addr,
                                                     I3C_ADDR_SLOT_FREE);
		 ^^^
                 This will be skipped. So old_dyn_addr never free
            }

  - i3c_master_get_free_addr() will return increased sequence number.

Remove dev->info.dyn_addr != dev->boardinfo->init_dyn_addr condition check.
dev->info.dyn_addr should be checked before calling this function because
i3c_master_setnewda_locked() has already been called and the target device
has already accepted dyn_addr. It is too late to check if dyn_addr is free
in i3c_master_reattach_i3c_dev().

Add check to ensure expected_dyn_addr is free before
i3c_master_setnewda_locked().

Fixes: cc3a392d69b6 ("i3c: master: fix for SETDASA and DAA process")
Cc: stable@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 4281f673e08d8..c8eaeada54781 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1531,16 +1531,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 				       u8 old_dyn_addr)
 {
 	struct i3c_master_controller *master = i3c_dev_get_master(dev);
-	enum i3c_addr_slot_status status;
 	int ret;
 
-	if (dev->info.dyn_addr != old_dyn_addr &&
-	    (!dev->boardinfo ||
-	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
-		status = i3c_bus_get_addr_slot_status(&master->bus,
-						      dev->info.dyn_addr);
-		if (status != I3C_ADDR_SLOT_FREE)
-			return -EBUSY;
+	if (dev->info.dyn_addr != old_dyn_addr) {
 		i3c_bus_set_addr_slot_status(&master->bus,
 					     dev->info.dyn_addr,
 					     I3C_ADDR_SLOT_I3C_DEV);
@@ -1931,9 +1924,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
+		/* Not mark as occupied until real device exist in bus */
 		i3c_bus_set_addr_slot_status_ext(&master->bus,
 						 i3cboardinfo->init_dyn_addr,
-						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
+						 I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
@@ -2094,7 +2088,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	else
 		expected_dyn_addr = newdev->info.dyn_addr;
 
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (newdev->info.dyn_addr != expected_dyn_addr &&
+	    i3c_bus_get_addr_slot_status(&master->bus, expected_dyn_addr) == I3C_ADDR_SLOT_FREE) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.

-- 
2.34.1


