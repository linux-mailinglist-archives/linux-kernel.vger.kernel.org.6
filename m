Return-Path: <linux-kernel+bounces-577003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1704A7172F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663B4170964
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C621EB1A0;
	Wed, 26 Mar 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FDXZn6P2"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84301E832F;
	Wed, 26 Mar 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994900; cv=fail; b=D59H8xMnWLTTUZMA7iuyH4ZzH/I7tODOqmVj9Gs5CQk0fmGg9E1NeJ7xBVm4RAP69MQKOC67S5askoi/uES05ZpaX+QOzkgTb1AoXrL0VQ1FH+LI/0x9cTAC2R4so63O85pOXDWpC+Di8micop72ajT14NjJYcK3P819C4STM1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994900; c=relaxed/simple;
	bh=8QvSWd4rmn+G1ZEKi8f+TGc8yN5T+yIQA/mdWdtzwO0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ccyOU67ETwQhnqxLVjsFJ0UlR44eLG/T6V9p4w+fJVv0E21XSK3ip0dWoEOV6i/D3VHzuq35YRsvyV991yLFV48jACJePlC7u5Gq9SSU9Jjg96BrVHIk8CarOzME53SYxF7sUYas5RL1rfMtXZyWdTggPduC60Urei25RyBJiAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FDXZn6P2; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8t3O6DEVHM7vRKhCiJV97fsl4hI5gnaOC7uo8OpptzwYgQnjwAowiYXMK+Xv5uNge89zHDGX4D4Cyoc7cEM/wATblfagJuLi1iOhxg3WfPseDh/7GySmeQVBts5mepOivc9z6J7yLtSl9DeYdkeTqn1Im7rFZIRmWJhTmumOPYimSsifKLasw5hOfODeT1GQPFOQZak5dNAyS2dRbVa9YyVZpjy331Y3PR+rvqJhnHdYSWs+LHbQU1I0U2chYA5ghOfJNgMV0VA6c2G2+JPKM4lLznq9m4SWQmYeJgsgzrh418MnlEi0UHRnb/x+z/VArV1TPhwFUxvwFEgXnYtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+o55FPMa7m6VVea9dp3slj5OALcBnoJzyUth39j3Gk=;
 b=eWwH0pB0G+7kOtMS8J+o9id0jwuL1sEFvE+hguRePvCkcUbIzj22QrZStqya+ytOf8wCCYfxhrsAxA8afEViqhpewRbVlOCzIPcoRsE0DGaQS4R7JpqjVGP83TmxnO6J3ipb6bZGYrgg98E8KthsSFADNZLx2xf+npa4AAjcgUHeUpaK+ZHRs/rHjvi9pQ3qgtSXBbOyMERj1s+zr4eXNpndiwMBSm3gpyDSB9hxP07GnZLdJ1EecmUoBOWRp3s09SwVA8rY4PSRExWfztySJW1g6CaHES8E4uvSdPmwLXqJ9cYiBAbMAMuEESuCG5SLIcZadmaBSLqPGwRE+we24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+o55FPMa7m6VVea9dp3slj5OALcBnoJzyUth39j3Gk=;
 b=FDXZn6P2qVNQ8l0DKHKHvKuXEoruQbe0PzPs5QIFwZDbu56BZd4iw/qGS0tWz66B01Pk6Z6rxCMFZjA6s32jreI4zeOWMwvGYTuGMc+UbRNvhZq5Zjyx3CGeIj66kr2QoZEvgdStxiUJxjfQjO1G+Z/HBIapzTeWhGdpGbP04NZcdthKlFPxxnlljFiktrclwqyyql8JrH/Wi/PPktNtHH9u5XbYTAN0EBQ23D0a5fHQCQ0hQbXwOY4iM8NSaSYqt4DuRfamD8Xumiw9F7Sn9KgD7UAUdwTg+4xALcJ88j4VnVOouZmojIeqw5+kD44yLsWWMfwkntJTmhqTKwp9qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8855.eurprd04.prod.outlook.com (2603:10a6:10:2e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:14:54 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:14:54 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 27 Mar 2025 00:07:57 +0530
Subject: [PATCH v14 1/6] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-imx-se-if-v14-1-2219448932e4@nxp.com>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
In-Reply-To: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743014302; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=8QvSWd4rmn+G1ZEKi8f+TGc8yN5T+yIQA/mdWdtzwO0=;
 b=wEzEAc0lC8pgrT5zIn34aePYb4YGUGCmdpAwsOolJcjt00CykYMpaLbaoBlFeL/NOIBCnFmaI
 /tQoWHPxOcJCRTDT4a6OtHkz+n5HWWqU5v2VxXcOZg1G8NVNO4/TxjH
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: a12936d9-b40d-4ae6-40cf-08dd6c683311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1dXblJrT21qaC9TQlFGcUx0Y2hvUUc1bzZqcFpQL1dQZFlJVXJsWElKZStG?=
 =?utf-8?B?Z1dTWkp5NDJUb0dZUHBaMVFPekpJRXQ4cmdtNHRUK21oZnUwa0p2ZHV3T0FT?=
 =?utf-8?B?MDYwN3gwZjBmZHVZZ0x4bW10Q0NDc0pFQUxHUkpVYkhDRlF2M21RQm0vb3Ur?=
 =?utf-8?B?RTZFS2VLSEhXelMya2tLNkMrUHVnZ0xPd28rNHc2bjhqU1VrYTZRT1RZa0l4?=
 =?utf-8?B?ZmhtcmVUVmJWY09iWVlRU2dFQ0lZeXRGTlJoQnlZdGRJUnl1SlFZTytOcTBG?=
 =?utf-8?B?aCtWR3BZYVJiOElwR0VqM0J1MHplTHp4ZmpEZTJoTG1tTStUeXBGSDdERzYv?=
 =?utf-8?B?TVpybmtNM2N3NEpjbm0xb01TbEVOL0JNTGRKaWVqU0JRWG5peElRQk91RkJR?=
 =?utf-8?B?ejBUUmI1MEJqOTNhOFJlcDV3ZmJnL1EyUWRKSnVwd3BqWXY4R1Z2WGptbFRM?=
 =?utf-8?B?VFpRbVJ3WFV0RFhnOEN6ZExyWjRzeGE0akhKaVE3c0YzNmMvZ2s3TE8xZ2Iy?=
 =?utf-8?B?NmVqYTMzdm84VlgrODU2Q21NQVRSRUZjNUUxMXFFSDgrMlIwcEN2MFhMeWE2?=
 =?utf-8?B?YjBBWVl2enFaMUxadngvOXZXa3pPYjBLMGRsRVhIaXgyWnkyMmRhWHp6NE1s?=
 =?utf-8?B?NTcreHNZMUQyTjVWc2c0RkNtdnJGWVFWd3QwUlFmKzNnZ0xjN1ltajJZdTJ6?=
 =?utf-8?B?QklPWTNUSi80WEcyaUZGYy9UcmdCL042N01QcVF5Z05MTUkzakJUaDZxNVFZ?=
 =?utf-8?B?L1pGYkhIVlg4YlgrZ2tQSVFMSzBNR3VtcjRXelRlTkpVTkowNWJlclVpOERq?=
 =?utf-8?B?bkVQZDlSWnJpdDdjVjlxQTdYUHZjL0g0bTJBMmJDS2tjNG5UeGZndllBSFlF?=
 =?utf-8?B?OFFSUlg1N2Z3UUlQUkk2WEszdnJKUlBxVDY1a0tZSnc4QTYyZ3J0c3N4UXVK?=
 =?utf-8?B?TlBCckt5RFprZmJzZEhpRnNnMDJ5RjZnQnlaNlBTUTJJVVE0WHNFVGtXWjJx?=
 =?utf-8?B?emJMVW9rWTdUaGV5S3lVNC8yWEZ1ZExHN05rWVJNWFRqR2hEazZtVHdLM2NL?=
 =?utf-8?B?RmY2MFdvZVo4T2pya0xrdldINm1CMWFzWUg5Y1pvd0l4eXFWT25jajV3eDNG?=
 =?utf-8?B?NzhUcld1U21seVFKejZ0ejRuL1BGbkJOYytCdGtVL3Z2d2dCckJCU1RUc1ds?=
 =?utf-8?B?azNDV21GQ1YzRlhXem1DaG5ITnpGMWRlZjAzbDBPTW0welFDbFhIVUkvd2pF?=
 =?utf-8?B?MjRGL01uVlNUQ1ZzWHBZV3lKdWxGamhHdmRWN0Zqd3pOY2RsQkVtOUtiaXFk?=
 =?utf-8?B?WlM1dlNoVVNaYzRaWVk5WHE4aURBeXQrTmxSQWdIOG1rVm5YMDRuUlpNWmRs?=
 =?utf-8?B?V2ZjY3ZhaG83VlFBeHVjNE9kYWlVYytGNFNLWGNTaG5PdExzblhCeVZac3JE?=
 =?utf-8?B?MXNubTdxcVJoZStHVXNQKzVXODhRUUNjK044bXMzZ3VhNm84aXVJTzJrMEhq?=
 =?utf-8?B?dHlFNHQ1YnlKMFkwVnhxdm4wMUMzdldoc1J0Yk4xTE04S0xlWVUrbGdGNlNI?=
 =?utf-8?B?ZktmYmg2OFFQVi9GWjV2dmQzRHp0cWtKa2ZPQjZsRUZKSDdNNWRjSTFvdGlm?=
 =?utf-8?B?Y1hhdHRtWWtnNEovQWM5OFY0dkFsVjJXbW9HOGd4c1FpTE5KQXg2dVZra0Qz?=
 =?utf-8?B?VWprZFFOazZLbzR3SFR3UEVHR3dHTkJoUTZpcVd2RERLTktTdWpMQjNMRjlY?=
 =?utf-8?B?Vnl5bE0zQ2JMVjJ2QzY0czdhakV3UmRVTXJTa3dibXl3RzZiR2JTM0l6S0lU?=
 =?utf-8?B?cStkUlFhSGpyMVFjSkc5cDgwWWFXSDZNSkJhT1owMUw5NmJkMzVqcXArUk51?=
 =?utf-8?B?UG9wOE5qNDk5TUd2aDFQRDVoeWl1cGdOMlpJL1grOUgyMTFTTXphcDZjc05Q?=
 =?utf-8?B?MFRlbXhCaEtxQ2xGaXRpNzc5QzRrNGRjWFVReFlmS0g4TEZVZUM1d3Z1LzZ4?=
 =?utf-8?B?VHkxVklFSEZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0tFRWJZdzE5RmZFSGVZd0hNR29zak9NbldGS1JjV1MrOC9WQ0FhMFNpT0Jq?=
 =?utf-8?B?WG1YdGtidFJOc3RtK1Vxc3YzTzA2dWVjTk5LTEpUVFJ3bE10VVBvQ1drK1d6?=
 =?utf-8?B?azNSK1VNeThFRjAwSG9EU1llTUhzc1NQcXlSWW9XNUJVNUx1eE5wY0lGaXRv?=
 =?utf-8?B?NFlHbTBKZlppWmUyUHF1WTJLVThBNlEyK0NMRVZaVmNyZkdNVmwxSHlEWlBH?=
 =?utf-8?B?aDBBbU9JQkZVYUVWc1BsaEhOSllZQzRGa0pya2tZcFJHc21MVkNTcUc2bVB1?=
 =?utf-8?B?Rllzd2lVdHhNaERybzVodjBhMm83ZW9BNEZ4MUZKNUM2emRxVC9wckJncEla?=
 =?utf-8?B?K05vK3A1M1RhVElFcDV5TjljWGhONDYzN1hMRVplOVovSDgyWTJmQ2dCUUR1?=
 =?utf-8?B?bHAxdzh5NEo1Z2VSVUlYL1ZvYnZHZmZmajlwYW5iYXZ5MUtWc1R3cmxSZElr?=
 =?utf-8?B?UjBVM21yNEt2UTM4dkFhWDJHcWhCNkJwRVRMTHlNNDU0SmVGeWtvbjdPYzFE?=
 =?utf-8?B?VHVReW5vQnlaYnVUb21iN2FOM0JmVUt2ZkdSNzl0MXcxSzhlcjJtRkJzcFdV?=
 =?utf-8?B?SVRTVXQ1R09waC9RNlJNd3hlUFd4d3E0VTc0cTA2UW1YZlJrRVNPaG85SGNl?=
 =?utf-8?B?UTBsY0Z2b05kRzQ3cko1Q0NrcEVQREIrRDJtb1NlakdPSWdaSTNGUytiWVRs?=
 =?utf-8?B?UHZKVnVBUE01bmY5YS8zUGU0ekJMNGJZbk1yY0hlc09lbVgxVG1nZkE4Zzg0?=
 =?utf-8?B?L3p5TVdKcTVJc3VqWWZzTFhBZEVqNjZGZG1UekgrVG5kdkl0VDcydWFVcXVT?=
 =?utf-8?B?SEdvVERzMnQwekRwUXRSUXQvRm9jdkdqcE8xc3VnTW15QWY0aXZoWTJyM0xz?=
 =?utf-8?B?QTRxeE5SRy9zQXBRYkh4K2llcDFKR2VzOEZnN2JaNUFQV3E2aGZXODVkZ0dG?=
 =?utf-8?B?WnAyYW1hZXZHaGxyWHBScFVySVVuU2c1ajZPNDlkdVhNQXh6VnlkdVdTOUp6?=
 =?utf-8?B?UTRYNmx6c08wWDJuQStuNk9GQmVGTDBxbTFQWDVuNlBKR3FoWXEzSjBSMVo1?=
 =?utf-8?B?ZmxzcDhCWGpKUjRoNGxwMzRhY3NkSDlhVHpDdUhXNitvclUvTTB3cThKeUli?=
 =?utf-8?B?cVZNRUJ4S0hhN2VTSnUwRFppM1NnbFludmFjOWFyd2pHMHF0KzF6d2l2N05G?=
 =?utf-8?B?T1BwWlQ3cDV2MDFTY3Q0S2RSa1doNDh3T0RxQlF6RG1jWEVLbWJNSHZmZVpE?=
 =?utf-8?B?QjdwU29aeHZCMGxYUUJPUHQyaXUvU2U4dUN6THBieFMza3dpd09HeHFielNs?=
 =?utf-8?B?R25jK3BWRnVYWHhSYzhiUVBJRGFhZEsxYUk2U2J3TFd6N1grSUhoREp0d2N6?=
 =?utf-8?B?LzZuNFd0YkF1b1JUTXZob0N6ZmN0RlF5SndHRzV6YU9ZQjM2MUFDdFBWQWRD?=
 =?utf-8?B?SU1MZFNoODNuWDJqVGx1ZlE5L0JSbE9iZ1ptamNET3BkTlU5V3dtZi96dkhq?=
 =?utf-8?B?N3VqOWtGU1k3c3FuYlNBd2RHamF6SDFnQkhoczlENzhrSUJMTEJGcFlRZjk3?=
 =?utf-8?B?dWZUQ1BUNGlVaWU3NnUxc2ZJVm4ycUVlOEpISitjc2pVVCtXSmdjQjcwU0NU?=
 =?utf-8?B?aFNqZW5XUW5YWjl1a1dhSmgwMTFUK09iMW5jWE9GTVY3WG5lYVoyNXI4ak1u?=
 =?utf-8?B?S2ZKUlRRYkJRYUo3OXdyaEI2MjhzZ2U3dmJXSzMzbWRPQnVKNDJFUE1wWE04?=
 =?utf-8?B?MDdEaldWNjRkeEYyekl6OGF6SUNtRG03a0NVRTNYbm02RXJnTlpadjVOZHN6?=
 =?utf-8?B?ampNVkFjV1o1SnQ4a2ZiN1NLU2ZoYWZkajhDbmdqdE1UZ1BwWGltakthVUs3?=
 =?utf-8?B?TGNsRTRjT0IrRWlVYTdVR0xGclppdFA4eGZyeTczTWdwR3NzTjlmMUt5ZWRu?=
 =?utf-8?B?Y0RhRUxzSnA5VUhIeG1mcCtvMUpUUEE2REM3eTRjdXppa1lBcWtTQk1TMGtw?=
 =?utf-8?B?UnE1LzczVGRNYm9nVEU0YmVzR0hhRFVFaVZVYkpkUnJUYis5MFVkU3RaRjds?=
 =?utf-8?B?L0ZETEhFRWVpYlZBMHIzN2cydnlPdDFaMWpHaUwrVVJhVlprMU5vOWZzS1Av?=
 =?utf-8?Q?0J9mvu68s5+i92vwPirNu6Z22?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12936d9-b40d-4ae6-40cf-08dd6c683311
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:14:54.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWXlX4C1l/+er2LUwuzFwpl4+3rJjIHpAPLwkNRC+oP4yZFPpDxrA9yCmN5y26h4BkiQDP9rMzAi4EWkFh8K4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8855

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..a3a95b54a174 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,124 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exist.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
+
+Each 'se-if' comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over Linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.43.0


