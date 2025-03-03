Return-Path: <linux-kernel+bounces-540904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287DA4B64B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EC3188E3BE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1381A5BA9;
	Mon,  3 Mar 2025 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oYG2dans"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012038.outbound.protection.outlook.com [52.101.71.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E87083C;
	Mon,  3 Mar 2025 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970469; cv=fail; b=HiqyzZ4xnsCk+yLb6pWmb63jxYJUEzhpgSMhrCIRJhQN7hxqoBQrwURCEBPYV/0tchr5TCfkRKzU8huTb7/pnsrOJwdEp4h+wAvcPVb+UiSR1puOvRnz2/kJ0bOEcsCMoipIwrgJKLHQsY5C/vjZscabf9raCAbEDCpONehBoRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970469; c=relaxed/simple;
	bh=syg4LCLn97gLVqoUKEYXaFNrxkosnkgaOQz3yIhjy34=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=VQPJ7eH0g7lZvW33plDdOD8xTa8y6+fKdb/DDyhbTWW+tOFWzIclg5IxltRshzB0HV1TFsXI7WEHcZl3lN4zG7qLxzdbYotgZCgPBQa5K8g1ZknSh/kXgSNGx/fXVU8HlZ8aJPaIP8nDLNBF76s6bg8V0xRkEfEnBMYE2Q/AwNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oYG2dans; arc=fail smtp.client-ip=52.101.71.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX2OYuNxF8xJcQVqC7IR29htyjIMzqrJvC4RHgPYGNKvB8dBeaUQp5uc1CalB4rEnfRqTCMWTxmk7fI+gSPhuPIwWyXOnh6V1LcD1F7pu8wiaLgyKtpE1RNVO3Ugf/ktnzTzBG2HIgq5w6oxaXg5QtBZbfEQ407TAzH4iVh2sg/nTQ0HK8rnAHu11SOSuPPIDmyKP0P/VlxCLt63fs0B5Eb9/wBrPfHOZpHY3GaOwJuQFKYtplnruu8DYM9oUvFJYpC6oVy/HtOyktiUWND7K+QSfJkowG+3wbcpxsakT5+cSzUxqINuYU/C6C/iosc462+ZEsK01KLdUVr4+ABrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSyhIi5RlXWAa6cIScIHZ+ZMrHgmxSf7xK3hGL+OJbs=;
 b=qCNoYFA9uC/izVy9HIBmT5d3l4fGZoM93KC0vKISfk1Af+f1wFlaOwSflnx9cnhPl2Zm0xk5wcwX4lC1aWiCpubf2BnM6TAylJhVnViJf/9Es3cVNAZQ912vkWCLjF3ZC0Ir+EY0YKcPOR9L35sW8npI8az1OieZl2iKA2RYTObojrfIkF1orT1c/XZJePqy6uTRuVP0C6J7TNm8OH6PCgrB/upuYL/aAAiBoqng1Qq8QbtoNzYS3FvfV7a1Jw7Qe2m9pEhdS1W3PsQ2Q3AgxW4tfmvFBzYgx78G0rA+9GFffQaxDVd2SeLATOzqZnk+Mp3e9d02jqQbeQH4e33v/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSyhIi5RlXWAa6cIScIHZ+ZMrHgmxSf7xK3hGL+OJbs=;
 b=oYG2dansP2Pw5rSR20drVE/bJeS1stBdGQzFIRXpCj1HsVaWg7zGYkf0jGzsISvI3ampoyclUkBcrloZE0p3PXtctjLOWPCaSA/Wp4HsuPvaH/k7TZxumkJHvX3qYNF9z0HCFGs9pLf7wVMI89Ga7qgF8W9/HqcnfeEabxprdMqrtAhZj1VrOWfyKYQyp3ryN3f3gs4rC50ajRVsUt1rI4kprqgy3HmHfc9jbikPLYGqcBb5Fg/gtVbkcYvJ2+V3B/tzb1zSYIzGW/fJoiUEwj67GpYXsr+3asu1ipek2LJGdTEMeLRJxBmEQxAsG6/qN0yq3szsXjUeXHuA1+ScTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10850.eurprd04.prod.outlook.com (2603:10a6:150:216::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:54:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:54:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/7] firmware: scmi/imx: Add i.MX95 LMM/CPU Protocol
Date: Mon, 03 Mar 2025 10:53:21 +0800
Message-Id: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKEZxWcC/1XMQQ6CMBCF4auYrh0zHUDQlfcwLmoZZRILpNUGQ
 7i7hcQQlu8l/zeqwF44qPNuVJ6jBOnaNLL9TtnGtE8GqdNWhFSgJgRxA7ycA9t/INdVbYyhomR
 Sqeg9P2RYtOst7UbCu/PfBY96fv+O3jhRAwKyuZeMZcY5X9qhP9jOqVmJtJakaVtSKjPDjFicj
 pXVazlN0w+J8vMU3gAAAA==
X-Change-ID: 20250120-imx-lmm-cpu-418daaa257e2
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740970413; l=3817;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=syg4LCLn97gLVqoUKEYXaFNrxkosnkgaOQz3yIhjy34=;
 b=iKSb25vWxq02PbDZ7O95wV7WbEOFYls6CahoQNI1NQmLAYpHW2VxjDCY19NHNl0XiCxGx8yjj
 M/quNET85Y4BoQvEpuZei1rZIL9TiCR7D7Q8EFm7Ld18EN94GKkESLz
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d61255-7cbe-41af-052f-08dd59feb3d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emVDcHJBaXkrUHI0VDQrVmUwckM4V3lIK09rLytXQUd5UFpmQWh2czJNcmVl?=
 =?utf-8?B?QWx2c2tNNUFOVFdndHR5SjVPYXNZTHdxSElTVHEwZnlkSWVybnNxM3NkcXJ2?=
 =?utf-8?B?eWVFSDhwTTQwRUFHeUxISm1hemF6K00zc0tJN1dJVzFjWDAyNUVyMm1LNCtI?=
 =?utf-8?B?bnFDR3loUFRCRE5PSXUrSE1rNzdEUHdubldURHh6SnBPMU5tb3dhcnlCWGIy?=
 =?utf-8?B?cVhTUXBlYis0UEYrSHh3YlZISm92VzFYaGtDak4yQ08wMHlwNGFGOWVweWtw?=
 =?utf-8?B?bkJza0lTalRvM1dUbHhEenFWdFc0U0VKVWJYLzV0dUFsV2swUVE2bUVSa1NU?=
 =?utf-8?B?NFJTWjlaa0hzcXB2WHBvSDJvNXN4bVl5ZVBMQzcwTHd6TUlqSHZxTEQyYlFy?=
 =?utf-8?B?TUMvT21wbnpzOTZWRit6aGJIaXpVS1JpVWxTdlR5aU9UTzdab3IrUW5YeC9X?=
 =?utf-8?B?aGxUTnYvNHNVb0R6Uzk5aWVzT1JnRWh5V095dW5NWTBlR2lwRG9hN3M5MHZx?=
 =?utf-8?B?M1pEa2NtU1FuWGFiaERER2VqQzZMSTdsRFBnRyttTFVMTEQrSmZMdXN1NTZs?=
 =?utf-8?B?TklhVE1rZlUyRDlsbE5qUnBDcTUzNFN5RDJKcWIyUGxTeGMydkRORTJGSWU4?=
 =?utf-8?B?VWJQUmxPNGNycnErQ2xqaUdZd21JSWZFRnQxRjh4OVZDKzFYNG1uOGcwYXJ0?=
 =?utf-8?B?ZVVxUXV6NkVFbDdNY01RUmcyU2QrV1hrdVFJNWh3WGRnNG8vbGZHNU1lMUJQ?=
 =?utf-8?B?SFc0OTFzLzZGOFNxZEhxcXlGaCtZSzErcFZRL2pxTzlaclZKRlkvZlloWUI4?=
 =?utf-8?B?dFcrcHZJeDZNVE9rRzRJNlRDRWlyeGdPQVA0QzdtT2tDV1JBeTd1cEpEaVM3?=
 =?utf-8?B?T1pDdFdmTDQ5aXFrTmZwN0xaaHFSbEc2VjFZYlppa3hSSkdQOWFxQlY2SFI1?=
 =?utf-8?B?TjB3ai8wMFNTYVZhakg0SDY0RDhtMTVwZHUwQm00Zm5kY3dhQ29DK09RME5F?=
 =?utf-8?B?UnZ5ZWN2UkJ0UE1ETkF0UXF5Q20zcnhaY1BDYkxqTUx4cE9SWnVwdzBQNG1I?=
 =?utf-8?B?Y25Td3R4WWtUODRiVjE5K1RpYURxYm9DajZQQWJyY1pFdzdjMUhldDk4Ry9t?=
 =?utf-8?B?ak1WWGNPeW9lU0VLZ2J0UXlucjFpQ0FBYjJNY1dYcElzMkxMU0U5aVVUWmxP?=
 =?utf-8?B?cm5JdVVNL1N2aEhOSHp2Rzc2bUQyQVVCOWJvNXd5ZXNkeWFuM2s0T0Z2TFA1?=
 =?utf-8?B?SmxVSlozMVhDZWIzSkliV2FsbTdOSjJZWUdoRnphaFhFdzVQUHo2OUEyeWVH?=
 =?utf-8?B?bTl5SzdIaWw5bDExTnN1MmhpU2VEY3NEY2hWeEI4Nno0YXdEcGNWYit2UFFv?=
 =?utf-8?B?My8vcVQ0L24rS215ZE5nWkMxKzFmZWZ6QzNCZ3RYNmx6R1ZWMTFhRkZzMVd4?=
 =?utf-8?B?aVpBWTVPNk9wcjJPdytUYUNFeC9YODNuWFc1eEdWTUoyOFBpd2owYytZbmIv?=
 =?utf-8?B?dzN3MHdtNEl1SGlLSHBFYWFqeEVWSTBrWDEzcVQyWTNBb1pXRDdNK3p1MWZ5?=
 =?utf-8?B?Z09yY0JvYmdHL0ZZQlRFNWU3R0tjWkJIaDJrUW9Scmp6bEN2djZXcTFuTmI3?=
 =?utf-8?B?YzZiOXpSemxtSmt2VTBYdEc1Q3QwSEFKWEVTclp5dHVzM2ZwVE0wWmlHTWdE?=
 =?utf-8?B?NUNuUitFUy93K21jaHIvZFVlYjk4U3cxbDZHZ1J5bDE4ZWF6R3UveUJ5Nmtu?=
 =?utf-8?B?WkQ1dXhGb1MvT0pkcFlqUnVzQUgyT0FrVitvODhKRVJMNW1ZRENveCtGZVFS?=
 =?utf-8?B?cVNHZW1LenMrSEFuM2pNWmhzQWdKaC9keGE2bUdmblhReHhPQlliQVpDdTRF?=
 =?utf-8?B?NkhUd05xRDE5bER4V3FuNmI4ZE5zRjkzUWQ3blhmMW5XZ0JzTHdsckpReG9u?=
 =?utf-8?Q?letJQ6mclMrYMYTWRfLlAKI1JyF0qjaJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmsxOEgwQ3AreDJNSXBFWW5KMHNvc1pmTjZ1UThVWExaSEIyOTdDMkZBdDNJ?=
 =?utf-8?B?cGF5RkNCZldwQXowTkdJZ0xRZjlxWmNFTkNBb0crUUdva3craDNBOU1nM3Nq?=
 =?utf-8?B?RjVvbHE0bnRJNm9sQWkrSUtNMm5RYUluYnM2K0p2VkZrRFRHU2V1Z0NNdUYx?=
 =?utf-8?B?NVdSTkhvNW4yeDZ0TXlaT3VuZ2lJZlhSMFRRZjlzYUx3c21GU3plVG8xSHdH?=
 =?utf-8?B?cU9UM0lDeVQzaC9uV3h4SnVkVWMwL3RwYk40YjBRRGlKTXUrTFVHcW1JeFpi?=
 =?utf-8?B?Z3VTYnNBbGZoSTlyL1F1STNrM1ZQOWdoNm1vNTJCNkE2Z1greWFUemtUMlZT?=
 =?utf-8?B?NXUyKy9JSGNIbXd5YjExRlBRdHMxR00xZzc5NGxzWnJMazNFTWFRc2dwRUxa?=
 =?utf-8?B?TURad2dHU3J0SEU5bFF0SVpxVXd0eEYwUGNyNWZQcnZuM0pWWTQrY2QraG1S?=
 =?utf-8?B?UHAzSkpPeVhFOVNSZlppc2hIQmw5Mlp1NnJxc215SHZ1eFVqTnlsWGJYSmpH?=
 =?utf-8?B?OWdDWHZvRlRqbHNXMDdNODNCUzg2N0FVcG8vTHlBNWdLeExPNUc3aEhrVzdN?=
 =?utf-8?B?d0JMWWJMVmxJN3gxSXoydGU5bEhMUnBUUy9OWnNaMDJpbzJTVUJDMHpia3Vk?=
 =?utf-8?B?NDd4VkdXT0hsMmFUN0dJbTRIUDhKSFpCLzJ4M3pCT3RlaG9MT1JISHFWSkdO?=
 =?utf-8?B?TktxTWZJSTMzZ3djTkM0VHRVN1YrWlFTcm9RYnQyWllESEZ1Zjh6K2NOK0M2?=
 =?utf-8?B?QTlHTzgwbXNHYitBMzI2UHpIZ04yb01wWnU4aXFXOUJyUS91WE10NzRwL1VJ?=
 =?utf-8?B?Mi9ZaFRKYTUzTy9EcHU0c0lXa3R1ZWJSOWFtK2ZoZnRXbFBldFI2QU1BYVcy?=
 =?utf-8?B?VDdDTEh0Y3h0c05ieUQrNU4zbG0veU13SlVzcmVLTHU3QmpoNG83dWMvV0xa?=
 =?utf-8?B?L0ZzZnJtbnJRT21nSVM2YVNic0Jac3dnWXJodTZMNnF5bFUwU3kvdVVNNnJu?=
 =?utf-8?B?c3dFcUZUdTFEMldpTTU5alZpekVXOGdIajM3WVdkTkRwOVZKd1ZmUVV5ZVBN?=
 =?utf-8?B?cUJxTzl3bWJrVnVadnZtOWVDQkQwSmV1NXp3T09WeHNFVm5MNHBnRjhmeU5E?=
 =?utf-8?B?bjhJM0ZMbjN1RUx0NU1MMWZCdjlkTVExc2phQzJKUmFudDdobExtamZOd0JD?=
 =?utf-8?B?TjcxUkRoZ250Q2ZFazNZbFdBQWhhYlNjV0JMUDRvRnlXMjNSbGovSktGQTRG?=
 =?utf-8?B?OWVEaGc4WlBVajNPb0Z4Qm5MMUMzVDhlOHE3QzRKVEdZbHB3M2N2MStJblBF?=
 =?utf-8?B?ZVo1aVA5YWZBRUhGU0ZQc0Z4RStqME05RUZsTjlkSGVKVmRzQ1Y3aDJjaTUx?=
 =?utf-8?B?Y1hOdGE3eXg4Q0Jua0ZlQ2NDdEJrdldhcFd3YkVMUGFOUHM0Qk0rTGxnbGd4?=
 =?utf-8?B?MFRNd29LQ2UxUlpMRVlUR0RFMW1Ma2pLdjhtU0VWTUgwZDhlSkxFemphZVA4?=
 =?utf-8?B?MmdxbDZwZkt3Z2lxSzRHSlpZUE9PT0ZzRzZ2S1U2bzhBbGQxWC9wNW5TTStB?=
 =?utf-8?B?bEI5QjJ5VWh3dFJCVUF3WTBsY00zR0M5MlprZ2tJaGN0c1pIR0V6YTM4cFlT?=
 =?utf-8?B?c3JKTGlMZ3FlNzU4Q3d1VXJ5N0FtNE9CR1R5akYxbWpCc1p6Ly82d1BhaFBQ?=
 =?utf-8?B?OHlxWWNVaUVoSHVFVk8xaXlGMVhPNEVCSzhqRmF2Z051OXgyeW51QWxkZ2Ns?=
 =?utf-8?B?Vnd0ZkU1a0NPR01VUE9mWHNqQ2l3eThPeUorRkN0RlRFK250eTUxSEk1RDJs?=
 =?utf-8?B?T01Lb1AwMnNjOUNLcitNSGdNdytLOEx2M0c1MDN4dXJFb1JMSU1UR1BnWFVM?=
 =?utf-8?B?RmNXNVhoUzhzYzMyVkhUamJNaW1VME5rREZVTGU5OXl5c0ZhVlUxekZmQXZ0?=
 =?utf-8?B?R3M4a2F2Q3A4Tm9nMllzT0ZVVUpFVVRxT3lHNnMrMkU0V0I0MUJqR2JDQzhk?=
 =?utf-8?B?Rkw5RnVxcW81ZUJnZERadHZqRDNwWUkzZ3FRaStUZ3NzalI5djNFT2NJVnFt?=
 =?utf-8?B?VFp1QTZXYmhzRE1TaFUzWnFRZnIyT0pHSFRndnZyTE5mMEJ5akRSODFFNGRH?=
 =?utf-8?Q?AYQtMDhzOdakEffvZsLzwlHc/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d61255-7cbe-41af-052f-08dd59feb3d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:54:23.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXOlpwYIEZZRs6Zam2bh6BLPlhfHf0R1Zqk2WgUd9/VaKR2zMav4nDoC2NxMfxWmOCuLvL1+tJuuzPb0nQcfVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10850

i.MX95 System Manager(SM) implements Logical Machine Management(LMM) and
CPU protocol to manage Logical Machine(LM) and CPUs(eg, M7).

To manage M7 in a separate LM or in same LM as Linux itself. LMM APIs
and CPU APIs are needed.

When M7 is in LM 'lm-m7', and this LM is managable by 'linux-lm',
linux could use LMM_BOOT, LMM_SHUTDOWN and etc to manage 'lm-m7'.

If in same LM, use CPU_START, CPU_STOP, CPU_RESET_VECTOR_SET and etc to
manage M7.

Both LMM/CPU APIs will be used by remoteproc driver. The remoteproc
patchset will be posted out after this patchset gets reviewed or in
good shape per Maitainer's view.

Build pass with COMPILE_TEST
Tested with remoteproc on i.MX95

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
Patch 1: Correct LMM_ATTRIBUTE return values
        Update the return status of LM_BOOT/RESET/SHUTDOWN/WAKE
        clarify sync/async in the Introduction chapter of LMM
        Update the Origin entry in LMM_RESET_REASON
        Clarify CPU run/sleep mode
        Add note for CPU protocol to indicate AP using PSCI, non-AP use OS.
        Specify mandatory for each command in LMM/CPU per firmware owner.
        For BBM/MISC which have optional command, I will update doc in separate patch later
Patch 2: Add description in binding doc
Patch 3: Unify scmi_imx_lmm_[boot,power_on], Use le32_get_bits
Patch 4: Unify scmi_imx_cpu_[start,stop], Use le32_encode_bits
	 Add pointer check in scmi_imx_cpu_started
	 correct nr_cpus calculation
Patch 5: Unify lmm shutdown,boot/power_on, update kconfig to avoid build bot issue
         Add R-b
Patch 6: Unity cpu start/stop, update Kconfig to avoid build bot issue.
         Add R-b

Ran smatch as below, no issue found.
~/smatch/smatch_scripts/kchecker drivers/firmware/arm_scmi/vendors/imx/
~/smatch/smatch_scripts/kchecker drivers/firmware/imx/

- Link to v2: https://lore.kernel.org/r/20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com

Changes in v2:
- Add dt-bindings patch 2
- Add a maintainer entry with patch 7
- Update doc to address various questions and make it clear
- Use strscpy to use scmi server returned string
- Drop extra blank line
- Shrink scmi_imx_cpu_attributes_get function args.
- Typo fixes
- Add LMM_RESET_VECTOR_SET
- Link to v1: https://lore.kernel.org/r/20250121-imx-lmm-cpu-v1-0-0eab7e073e4e@nxp.com

---
Peng Fan (7):
      firmware: arm_scmi: imx: Add LMM and CPU documentation
      dt-bindings: firmware: Add i.MX95 SCMI LMM and CPU protocol
      firmware: arm_scmi: imx: Add i.MX95 LMM protocol
      firmware: arm_scmi: imx: Add i.MX95 CPU Protocol
      firmware: imx: Add i.MX95 SCMI LMM driver
      firmware: imx: Add i.MX95 SCMI CPU driver
      MAINTAINERS: add entry for i.MX SCMI extensions

 .../bindings/firmware/nxp,imx95-scmi.yaml          |  23 +
 MAINTAINERS                                        |   9 +
 drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  24 +
 drivers/firmware/arm_scmi/vendors/imx/Makefile     |   2 +
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c | 276 +++++++
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c | 257 +++++++
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst    | 801 +++++++++++++++++++++
 drivers/firmware/imx/Kconfig                       |  22 +
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/sm-cpu.c                      |  85 +++
 drivers/firmware/imx/sm-lmm.c                      |  91 +++
 include/linux/firmware/imx/sm.h                    |  19 +
 include/linux/scmi_imx_protocol.h                  |  42 ++
 13 files changed, 1653 insertions(+)
---
base-commit: fb2b3e3bd74b8a3f742eaade06f6565323cf4bdf
change-id: 20250120-imx-lmm-cpu-418daaa257e2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


