Return-Path: <linux-kernel+bounces-395123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D299BB8D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222411C2085D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994401BFE06;
	Mon,  4 Nov 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i5d1dk2r"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7421BC07E;
	Mon,  4 Nov 2024 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733815; cv=fail; b=A355FrcNprChZ0iup7/fB4twHL3O3RspGF7dP5sfPt16m3m7HknGemaTYPryzpCAZ1EiMYjtUgYdrVW9d5NgxcRLIWwbU/G1uSOUL/uoaEckG91ttY0UgieQZJeHYzL6aTMBw/ha7fPqWU7UhB6WYKmoHJqOHcXaj0DzM5iTeGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733815; c=relaxed/simple;
	bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fZTib6G+9ABHWa3g1RI6BT/aLeehRs5zDMlxs77IcZxHnscoAhzAN+V8Yb7eWe2QNTDqbsIupbermZHbbPQqVdJv0SeBvaKRpGnJ1VZrSMskE9RNuccJe6EBCyoepCJmbnGlpHLa6YagoIG2qBsKewdZTYrcEPokbcpgS38Zo1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i5d1dk2r; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g15BxkRBBPJUL4L639dwWGBN81H4nuqhc1kKME1XfUIHOq9XPIxqpoxk3FChvAPOuuiiJuARa+KvlcxxxWIQRyZjvG6LwZwTdwlt0Ki1OSRRsoM61SblhsZCZjXZGwCUDj7mXuwm7toGQy3T0Wfe3bjTx7Z9ENEu6d2jWPCnIu88OQLefjjXYq0brF14YlTlEZJgU+DMRe7WsJurV5RjM+AHeHFV5ORwtY7RuXDGDjR5iuDUoOkP+fq+bn2moaRhlfmhwUacaNXHJyF1OyBl/FSct4adf5wymASyZlIFcTkwzDVjkNn6csi+sc3Wi3LCjTn9eLn5uMRk2gclfZBJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=pSUqXrZ7kuXOerLJmVl14Har7ugommCZHvclbzVKWfgSKnPxBP1ZRSWdRp2If/Jf3+P6rg3kSzX8y3BFo0iLLMc81pfIPc4t7r3qd6o0Yrk3nbhm95+Lzpe9+Zf5QLm0LDsi3eZ7n9HLuLqgD4MP+gl/DGGZu6YHWRxvyQJPAajkOwLWWqoA3N2h4gYVT+I40lSw121el4jts9rE8VoH+ffk7klVdFei3YyPuJXQli6i8jD+OrwshpRKBVSQMBy34Us+DA3rPelfxQ3QK7eF+rFKJoypo2d+oMQO754kXzNOIsai9fEoFngF4WIM/GVWWT+RVKbRMNIWLF2RqwtIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=i5d1dk2rZoWbdiIZv9DipcfTuWdsnfP9+vNhzUQi8vODKaBT45fJWPHhmOtjqOBrLJlPGTwmiVJ5/MTQuweZlg+dw0GMhU81GXK+pqoDsDEMff/o2o3O/a4CF5+9lPacKtefEfO7SdrzyuKOOM+CGj9UpzgbMr8wKAuQeQPUhnoNzv5GtFDESUBZRxACcSpHVWIQYpZL9u7bhSlnmkHldTG0x0s53KMGD/X76GmVtGlaadab/Iivsto3JCw8T38IQQQifEPX6b0tovw+QEVjFBFjXhgVac85oMYQWSoNRp8gED/K5ZWk+61K/hXmJF19rhomYqlsUg2hE8fK0E5UYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS1PR04MB9430.eurprd04.prod.outlook.com (2603:10a6:20b:4da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 15:23:29 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:23:29 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 04 Nov 2024 20:48:38 +0530
Subject: [PATCH v10 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-imx-se-if-v10-1-bf06083cc97f@nxp.com>
References: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
In-Reply-To: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730733536; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
 b=3v/+tY8ZVygqHWLdcxoA2FYVuq8WcUkXj+eUuBkKs+mvVMKrpLotbVvzaJHASWdLdiEJGmTZ1
 4IBDRuzDYt7CV+b3crjb7jcv0kq0y9cDiUxnYpqysLXmIp9RaOEKw4z
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS1PR04MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 384e878a-3d13-4182-4b24-08dcfce4a2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFF6UWNTeEJocW43NmM2N2h1c3pBSVVML0VMalBSdTBmTVI3THhReXo5YzRE?=
 =?utf-8?B?a3gvayt3YjkrNlB1WURQRmIwMDNydjhnSEZkNjJCR0hpSzd0NTlLQXRBMmsw?=
 =?utf-8?B?Q1FJZ25KdXlhQ3NXUkpoM1FoVElEcUJKdWNpSUoxMWVYNEJxVWpqZnZLaHZh?=
 =?utf-8?B?eFBxNEY1WURZTGRici9tbjdBMmkwbFpEQWhWQVZEQVdoK29IcG50ZjdUQnMv?=
 =?utf-8?B?NTJlSHNON09sVW1MNUF0d1Q1ajhEcU9SVEEwYVFNVTNuOWtCOElRcWRvZU9L?=
 =?utf-8?B?ZGVybW5EZW52T1FZZnRybEdickRWcGt3Tk1adVJ6eEx1cVhIWlZmMFVMMC9H?=
 =?utf-8?B?a2dkT3dWb3N6aFJBaTdYRUFlM0Via1N3cnZSamVNWDZtbmxQeXBJYVlMdGhO?=
 =?utf-8?B?Ty9JSXlHQzFnUVp3VzVSUkprcFZaNUVZNUVMeUhCRHErOWVsN0p0dVhDSTZr?=
 =?utf-8?B?NU9JcjNVb2xRbkhDTmlGMnpROXo5aU4zYTdhcFRKTTJ1SHIzTVMzN2lGT3ho?=
 =?utf-8?B?OU9vYkNnUTd3L0hmcnV1UHlmdGEvdDNEQk9PZW0wM1A1MzlLSjB5KzVkTCtS?=
 =?utf-8?B?ZHY4dml6TFBscFdyc2txak1YWlpEc2ZQR3pOVVpWYnNpR2dNaUdldHFVM3hR?=
 =?utf-8?B?RHNqR3g4SzFrbUVrR2M5NjlRd2VwMTIwYlVxRWVTc2crNUppNU9EajJsazVO?=
 =?utf-8?B?ZXFBSVNBcFhvbEZIbEpheUVyTC9tYzFrSlQ1UzllODVodGg2cWZHais1K1Zy?=
 =?utf-8?B?Nk5MUHU3RmVxM3Bya1FhSnIrUCtQbFhKcGJQZkRmaUhONnlOQ2FvaGppWE9D?=
 =?utf-8?B?eWpYVWZHVDF0NGRkOC8rUWNPbTRlek00RjJXTDJybkYwK01xY1dkaXF1Uy9j?=
 =?utf-8?B?dVNkc2djbE9DUDBudVdrMlRDQUdPc1Q5VDBDdE9lMDJtVXMrbTY2dnNBTE8w?=
 =?utf-8?B?VXlwRW56SWhEZ2NvUHJ0c216V1FNaG9ZdjUrcjZyZDYwdmJSd0Z0Vm82VGlo?=
 =?utf-8?B?dENOcUdrY25MaUZhSWJaTlZteXNianFGTTBNb1R6ODAzYldYeHh2cTQ0eXYx?=
 =?utf-8?B?YTEyTHdra3laaHJoSVkzeGdDSEJvUEF1RTkyRTg0RFgrRjREdndZM2ZxQmpk?=
 =?utf-8?B?WVhKdkw4b21JbE81Tnh1akVjWjV3cFZTUlBoYU4zQit1Q3BTNGo5YzdIUmtm?=
 =?utf-8?B?dDE5ak9UKzk0VGtqTjYvRjJNaFNlQ2tUeFRSdWR5cTluRWNody9uR2I3elF6?=
 =?utf-8?B?REQrTnNxeFNvc3grdFlMdnBOWjV3cHdmY04zeHBSQXk2RExMd2YwL05GV3Rm?=
 =?utf-8?B?b2lybXZrVk53SVdINWU3ekI5amNmeVdKdmJiQm5MSVZqdUI1UHFmRENDTmkx?=
 =?utf-8?B?Z3JZdGgvYVhDQW0xM0FLcHpGQUpBaFcrbmQwVjN0d2VvMEJ1VlpHOW5XVHY5?=
 =?utf-8?B?d2pkSWNNdWZEaFpDTG5YYUxUdzRZVzlVMFAvVXZJU2xLTk5NUmtFTm9kWWF0?=
 =?utf-8?B?SmR5Mk1WZHhDb0g5a0FORmswYTRQOXF0cWozVjZSOFBqVGN0aUc2Umh1dkt1?=
 =?utf-8?B?VjdRQndZTkV3Q2Q0NC8yRzBZcWdleWJNRGJ0VCs4Qk90aHk3VHgwUWxXSkd1?=
 =?utf-8?B?UW5POS9FbmIwTnkrUHNvWVZWU3M0WldmVHp1Zm83ZzFIcUwvd3ZSWWpqOG1l?=
 =?utf-8?B?MDBaSEw5RW12cDVLdmVlNTZ0OWtCZlFjWEhlWDdybVdYRG03Z1BKUFBWTlJV?=
 =?utf-8?B?NldTTk5tcFFXZkVnTWgwOEVTemRQK0x0aVhTQjNETHRzZ0JtNWpabVNuckhu?=
 =?utf-8?Q?DM8ZOxbz4nHZd7prOTMGkB4rwhq7g056rI5GM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ZxVmgzSmVsclJnMU02Wk5DVkw5b1FvNzk2Y29SdDlvL1NBbzVZSGJiWDBq?=
 =?utf-8?B?YVJSM05IY1RMWFU3VndWUjA2ZXlXeGY0cXh4TzcweUdYNkYxd0huQ2NZQWtn?=
 =?utf-8?B?T0xKc0tibUMxdFhKQ2lhZmVyVDdkeEpGdkRwWENSZlQrZ2dseHRnSFdWbFhw?=
 =?utf-8?B?RThtKzZZOVZWUmxiajFkVm9aZW85Q1FjMWpCWnpMSStzREhneU03dHRjQTBr?=
 =?utf-8?B?VnV5azNCdzhVSmZLbXd3WnA0WmJKTkRwL0ovSjRFeXpxUVZGcGRMcmFTNHVN?=
 =?utf-8?B?Vk40a2toeTdQN0JOYXhSVElJNUR5VFZQNWpKRmdyamRCbnR0UzB2MGZXNWF5?=
 =?utf-8?B?dys0VkZNY2REV2xLaVBmRC9SNnIxZStmeFpRMWFFYmxRSmYrTXlmZU94bUNP?=
 =?utf-8?B?cVpqZ1AybVhjWlZzL0lzK3Y2Znh6cVExNm5UZkhsQ09EYlRjdkdpR0t1WFhK?=
 =?utf-8?B?cjlJYlJBanE1Y0dEZ3lRYzBDWlF0V21FN1F6dEdvRmovMnh3RnlFbnZnZFFv?=
 =?utf-8?B?a3RnK25hdWVadVdNbGVJQ1RTSUt6YzIrcDVoaVYrZE5MYXp3US95S3dOMzZK?=
 =?utf-8?B?OUc1Uy9pZk9MbGFnWHh4d283U0ZiczQ1K09WcDR6MVpjV0g4cm42OUw5M2Ur?=
 =?utf-8?B?bzJYcWJEbGs4NWhTWXdNLzFINU1RbWdOZlZsaUhtUDdXTDJBSXdSUmt1Ym5o?=
 =?utf-8?B?UnlrNUt5bG1YZ1hFV05zNTkrcVdpRy9UZmR3dmFnc3pseGdGN2t4R1p2NXFa?=
 =?utf-8?B?Zmtuck12N1FEV1BCRTFkeHg5VitMUG1LTCtzd2xaRmJlOXMxTTRFT0lRcnhC?=
 =?utf-8?B?R0k5VmV5emdZRnR4bmdVNjlSOXp4ZVF6aGdVMU9FQVBIYnNmR3A0NlBGOHZV?=
 =?utf-8?B?WjRFU3RYNDFtcFdnVk5hN1A2T2dCMk9KbHFVTEpUTzhVdHFybndycklKVEJB?=
 =?utf-8?B?Y1BOOFZIejdNdEdyU3dxd2liRnNpdTFuMGc5L1RwamVaUUVNU3VncUtBNENr?=
 =?utf-8?B?U3Y3UE9TTHZLYXZyOXlUMVgrNGNuWWliMHNSODVjNjVDamhYenhKYW5jYUV3?=
 =?utf-8?B?SVFrSDdwQmdXUlJKUXRkZENGZ29VTjBpc1o5MDdSWGdjc2FscDlSa1pXMEZ3?=
 =?utf-8?B?Zm5QVzFGd3VjUVZQS2Ivb3RjZjlsSmMyczUralJyR2RnQXhVd3JuaXNWS3NQ?=
 =?utf-8?B?czdVdzE4S3hHTWJwam8zMzQ1TFdqdXdoeFVsTlVCTmt1OThwMjRtOUVLTXlh?=
 =?utf-8?B?T2w1VUlPKzZRbkc3NHp4YnY4SGRHdmUyMmdXM0FDSVNpUzZMVHR3SnkxMktO?=
 =?utf-8?B?S1cyc1lEbVdiZXZjRlc5Uk9NcTBJZHJzT3BSdHVUYmZjSDEwYVo2WktLVVJ6?=
 =?utf-8?B?a0swL20zVFVRSUR5a2NZVUFvSGFEWXhBaVlNQkJtaExhWG1XM2NteTNyOWJ2?=
 =?utf-8?B?RndoblZQT3pXclZSbEcweHI3M1NSaGhSci9kR0lic3dETlBRMFRwQVJmZVd4?=
 =?utf-8?B?UXp5YUlncjRQcFNybFNGSGhKUGZXZWVCZVROT0J5MFRtNWJaWXNSME8zQ3N1?=
 =?utf-8?B?WXBTa0h0a0YzZ0JvUUI5MWM1SHpDWDYyNW1zVDhCZ2crcUhxVm1CV2d0SVJw?=
 =?utf-8?B?WVpGK1hVelM1THM1YzR2d3pTcElWRExGVElXY3VGMGRabnNuWjlMeWlzYkhQ?=
 =?utf-8?B?WXZUNXMrUS9zZFpTeUNOQ0FJOXh2YllzSm05akFucEYrcFJ2Yjd1UjFKeUFR?=
 =?utf-8?B?M2JVUitscFpPM3dhR0NZRXVETENFUU5HSHVoNTdYMU9OQmtkZEsyK3Y1eEV3?=
 =?utf-8?B?N2hONi9lQ3VJR0tKcU5uZmR6TXR5S2o3bGdUWEd2SWtWVXNVektMY2IwWjYv?=
 =?utf-8?B?d3EwbVJHcXpIdC9FUUZ2cU0rV1ZtNDRXUzJJM3czZERoVjNVaHBRVThtdmp3?=
 =?utf-8?B?TFpCY2FUaGdTOWR0SUNWREJiQjI2bStWZmcwTTlTQ2FTREV5OEFGVUdKVnlL?=
 =?utf-8?B?RnVUMDQxb0ttRlJ1bjlreitWL0FVNTRGdGpGcU5wRER5RldKSHZBT3dEMU5W?=
 =?utf-8?B?MCtwbUlqY0dzRURiRDYzQWZSWUxzSXd2emN3NGpZTHhzZXJaWkJyUVV5aXhx?=
 =?utf-8?Q?dJRm3KfJhYxTH0X6s+Io5RKfN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384e878a-3d13-4182-4b24-08dcfce4a2ea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:23:29.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDNlRXGyrU9CGG0YB8f2Td4EOGZecsaEm1VvpZ9d3LLJUDPbleUPdyerroQ40+S3NjAgvQyBnSa3HpcsD52uKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9430

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
2.34.1


