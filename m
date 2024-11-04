Return-Path: <linux-kernel+bounces-395126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0369BB8DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49488282C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E561C07C3;
	Mon,  4 Nov 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UvLoQjD2"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6F1C2301;
	Mon,  4 Nov 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733829; cv=fail; b=RxxF0lkO+hmV6e1Qb+XABvhMd4XRA13y8zcJ4ZaYBH6C+pjfczd2/kORj2K6vGtFu9iG5R/lT+oJ4rAeMz9cnCNVIaiEFgLYGukk2ac7eJog95gu8dbfKV4zvekfqABNJ3JWwbcyXmuVM9vnmH21Ld0DNo6Pyur+0mYxLbPlIrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733829; c=relaxed/simple;
	bh=EpQSowENmv2+76MaNuhYEIyM0LGtLX4F0BAw4YtV4+0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CrIKgPycbXP3ogqJrNVL4kwxp2O985swNiLN10ZzAAPjeZiFlOnCyQxx4RUnC1QZoukYuKx23Jii8DYCL3hxa92Au30iOoVbBUGvJJ6RcK++Kxpy5sVh8a+gSKOKd06D39kph34e5MDsDSMkVNh0AL13FYVx1SZPACiSel3mJ6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UvLoQjD2; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL0Vy58+LViZYpGRGU6UotxP9JU2qkhSW9szh1QrfALMqA9sLkboOl1JpNM48XjJX0rjPaTD3T+1OvGBWBGBSyNAusI/5OmJN1NWMpDLEgRkv0GBFL6Zbrifwc3tOgOIqdjTHGFK4WoCpYDKj4a3fQ48RgbAy6F0VSGOUGhPk7qXlu3qP1vRxCE9fZdSQ18QSw2MESHLHyNjDzf5UwkJVAiPVGdHjJ1A+xC//G3ps+zdzaXdpGmJh5aP+9ZLrJuTUrKagLqi5FW3U9Z1XOJlSxq1/KlPLVLawME6h78CMKlUcnfyTO7fpEWJUitVFYwUD3yf0nipyamUjOdE54pT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llS7Hd4F08G34AzdOg3c2PFe2GXVhj9lg3S7I4WmT3o=;
 b=mGwl32UXX7v9oxoINbw2fnL7MqkGiPRMIBdOfUindyC3cjOJbqfVALb9lmOOMVt3hOjSUSW6VmmdYAHdf2CWCWv1dJY1LtpENSh9kcsi99B9gbg0vPf33IjUlm7VASJ+xR+EtkrhtmVAvqPZPofIzktbZe0+n65GsMqSgZ/elrC7CxXb3kX3QJ25Hz+kb36NfWthZfN80WG/9o6+PlKSVoyT33Rm+aXSdqPNIVUaWOeNpdR/ot3KTr9xNi32ZYcF4wZ8TMRkI1j8Z/qAtnZk4b4w7imC7x7f4aKSCveYrp7WizCl2NDZoCK7spFWEAlDtGIRxoFJNWbNAaCpXQQoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llS7Hd4F08G34AzdOg3c2PFe2GXVhj9lg3S7I4WmT3o=;
 b=UvLoQjD2xc0DlyeYcBvcQVOVIRAYzuu8bpoeJ9rZ4beIRTWzr7KUg+gERQYzFv3dRWCMtLuxfXyXOgXSyyEBlaPj1lc64j0d6qwTJNl5i+gBi7GTQVopy9HjFmPflVMQAn7uxviUA7gSHIkaaJ61C1djT3cajatvVot7Vr6SwjDMoAY9jNqpu4V17Ny/d90BHoOYzwd+ZdirB7O7x0J7xddQpztWTVi61AJwu3riDWvzUjj08FYcE22XLVtFc8SHxJ8qa4OptaqKWtHfK2kG4HHPLf7CVlJtpcFmw5ZJ1Bt9X+sHr45lTy109TpqvHrp2Le3QV4y8ftHL8MhNRmoZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 15:23:43 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:23:43 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 04 Nov 2024 20:48:41 +0530
Subject: [PATCH v10 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-imx-se-if-v10-4-bf06083cc97f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730733536; l=39201;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=EpQSowENmv2+76MaNuhYEIyM0LGtLX4F0BAw4YtV4+0=;
 b=9cqXy4I++8pfK+LqffwWOZbaBLEN7tzCQPQe+ZU2OesjoLoXL2Z6pmIUsfvLnrKVYxRJiHvpO
 2eIA9d++2odDo30FkxVBYh4wmbni7BeatsMaaz4bzm7t0DYAbx6bjj5
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: d0379564-1a34-4c0b-e062-08dcfce4aacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUltaFRwVXBOL0F5d0Vzakl4QXhIdG84bjRLbkJxNDZ6Rzd5L0lkc0ZzS3Jw?=
 =?utf-8?B?UHJOaEd6NWFwYXlBRW9kMEE3VnVEaXhQUUdvUWNyRHduN2FLdW04VWh3aVVS?=
 =?utf-8?B?bVdHalJ0UkIzK3E2LytRbFYzUUFmeCtnL3ZBOFNWNmpQSStmK0ZKbTdMQmY2?=
 =?utf-8?B?UjRWVDNSK0tHVUttWTdySi9rbXl4UDZOZkZ3Zy9PelQrVXd1VGFlekVhV1d5?=
 =?utf-8?B?R3I3ZkdMVURwRGljMnRxWlAwZ0s2V0MzN0hIU3cyT1dwTGdKVjFodThPdEQr?=
 =?utf-8?B?RG9kaXJPT3dTYlBCak9QYWMrckQ1T2Y5T1Fzb0tYeUtydDRKTXExSWhMYkhF?=
 =?utf-8?B?bDJkQ2JQRU5qa3lNRWdQUXZtYUNHZGpZZVJ5eCthQWRvMzg4Q1JFSlViVk9T?=
 =?utf-8?B?TkVKVXdLa3Z4M2lGNzhzWUhveVFja2lFV1d5MFNsVjV5aGNLSEh6eGlaRXph?=
 =?utf-8?B?UlhDYXFOb2NUTWk4VTBqN0VJMEh0UzJ6V2FXVDB0SWw3dzRpeTJTSzdCWTBL?=
 =?utf-8?B?eHE4M3JFQW1ZMXRHSlhoQk0va24wanV0VFZqaDR3cGNSREVtZ25keGJ2T3FJ?=
 =?utf-8?B?dFM5MWpnbWlmcXJRcEpjTFBUTGdnZU5GRFlPMExXYXhObURhdXFTelFNZ3VW?=
 =?utf-8?B?azY0TURCU3lkMHNkUWN5R0dDMno2UlV5MGpGZGk1ak1keUZBQnFpVmNPTGpi?=
 =?utf-8?B?QTYrWGF1RTRWOTZuUk1veTBpaHQzVXZrc3lISzBlTFp4MHZtTlduWUFQQ1d4?=
 =?utf-8?B?Y09pQmdJZGVlU3FJb0hSVlpTc3MxenpoT1d2VFdaMTJ5Vkx6cUdhTjRWbkZY?=
 =?utf-8?B?SjFGU2dBUXBwODdLeERobkQzZ1hXTUQvZXJRbGYwczBoeTU3cGhoOVhBVGcr?=
 =?utf-8?B?a3owbGc4SWg3ZGh5dXl6bXM1NVNlalliU3JjcHlRSlRhWDFRSHJLNlZZVVRD?=
 =?utf-8?B?YUx2V2l4aTVhdVI4bC83ODkveXBUZkZrYlpIaWgzODI4dWhjdXZMY1VPUGtr?=
 =?utf-8?B?OEEycXZEVHlzM1hxOTVabFl4MmppejZHUU5OaCt3UWFOL0NsK01JbGcyekhM?=
 =?utf-8?B?VUNlbHcvRzgvN2pIeFk2Q3BPbW0zY0pCc3ZBdzMvOE1iTkRDNWp5NG1zZG9k?=
 =?utf-8?B?c0ZpZGptdG8vWWF2TVFpRkFiN3lwZ09aMDlFb0ZBU0VTSlNKNnlaWmJlZWhW?=
 =?utf-8?B?KzgycFJyaHE5WkJaK0E3RlBpbC8zUEMyTUw5UktIa3dsU1NEeUQzTnYyTFRN?=
 =?utf-8?B?dVV4NUI2dmo2RkhBT3RnMzZLcUtUZzBDUVkxdmNLVkNyM2VmMy9kTlpFWUVG?=
 =?utf-8?B?N3hhVHlsN2NxNlE3RXAyWWZkbTI5UXM0UGhIY2NKdUtva25YdHIrQjcyam16?=
 =?utf-8?B?YzVnWjVCT1B4N3lBNFNYZitzZHdTelQ3aVV1Y1FGcjFqNUtyeGRWMHQ1STM4?=
 =?utf-8?B?MGxzblhqejhkYUtvU1JVd0RIcUlBWitwdnNHZFZldWtDWFhGZHdNd0h5eUZ0?=
 =?utf-8?B?OWdHWG9JN2doeFB0dndKQVhmSWVRS1BKSFlDdFR5ZlA3TlVpUVgyM1VnMGN6?=
 =?utf-8?B?T3FmUUtZUGpUY2s2MGNaSEFZTTF2VWQvVkZ4OFY5S2RlOWJNNXVwU3c2blpi?=
 =?utf-8?B?b3cvRm9JZjJiQ01sSjR2V3ljMkpLc1ZWYTRkUCt3R1g3dGM3dTA2TUhtNWJJ?=
 =?utf-8?B?N09DbUFRMkx2R1FBL0tjMEpQT1dFSmNicTlYWEY5SzhJaTVBVFZSK0lnYXNa?=
 =?utf-8?B?emNmTXVCWG01MHVhL2haaG45Y1FWQUFOMndsc0FMM0FhUkRWUUhzYTJBRDE3?=
 =?utf-8?Q?7smoFnk4Tt69j0scCBs1NJA36ICg5QgyQtMEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QklhM1JZQ3hwK25OWXJEQUJWdyticGpBd3F2VWFoVTErL2c3NDRRNXRvVkhE?=
 =?utf-8?B?N1JHSDErN2Z3aktqTEFUU3l2NnAvRHZUZ1RHQjJmZ0kxRFNMcFRxVEVLTUJ5?=
 =?utf-8?B?VldwanFWd01DeWhxdndiZEVUL3BYLzFDbXVJREMxWi9hN1JBYTM3ZWtWS1FP?=
 =?utf-8?B?bU9oZ1BrejMyZjYxRTI1bGVmbkpmMmFXQnc0bFF4bU9pcyt5RlNEa1duUkor?=
 =?utf-8?B?Nm5TV25pdEF6WVZTVHZ0OWhrUFM2bzdCTTZsbGxjcWV4QktmdUhOd2Y4aHR1?=
 =?utf-8?B?OUY2WTYvUDF1eTBCSUJVZUFFdEdiZVRaVTFCK1ZWSE1BbmtVR0lYUTY4QlVM?=
 =?utf-8?B?N0xIKzFvRUtpOFdLTjV5VFdKdC9FNFZacHZmZmRBK3p2L0tkekpTalhST0pB?=
 =?utf-8?B?dXJ6NTk3dkcxdWFET0M4emQ0eDUzRUZtS3JHOE1JNjlCYmhBUG90T2w0TnAr?=
 =?utf-8?B?L1RBMlJUbWhlbTN4UkhrUkJqVmdFTTY4Z3NTekJDTTVHcU9taVdIT2FONDZq?=
 =?utf-8?B?MFJQMzZISUpUV0JqNzBGTmFsQWFVbldhMWI5Mm9zeVlWMzhraldkbTZ1OXE1?=
 =?utf-8?B?NTZKS3ZnSUdqblptMFlXaFIxdmpMMlpTZXNaSGxVS1NvSzRHSG91TG9ZeWdV?=
 =?utf-8?B?UlI4bUlOWW9odEtQcUczaTdQaEMrYlB6NkUreVJ1ZzNadVdhcU9tWmlDV2Fj?=
 =?utf-8?B?cmhBRmJORjNzVHlsaEpLbVpUcllLZjV4TFQwZE9xODFzam9UbUo2K2JQdHBX?=
 =?utf-8?B?V3JPazdpdXAvdUxINDA2Z3NYWEtrNnQ1Z2IrbzNoM3M2dFpUdGtMNm95cVcz?=
 =?utf-8?B?Umo4RHNML29UVFQ1eXJUckNOb2RkMm1MTU45L3pmQXAzRENEK1Y1RmV1M3lI?=
 =?utf-8?B?UkNuS0pEWVZvcExCMTE3c2QwNmRpTVBKTEpnRzJTaHV0NWhWUUNqUzNxQTUz?=
 =?utf-8?B?VFNzSkt5dTIvaDBXOWxWRHpGb1R1QTFuR0VJUFBXMEkzc1FSdHBqNVdBTXlS?=
 =?utf-8?B?QVBnYnVUWGpVcjRMYzBDNndhSXBCcm5DNFdFb2FYUXNUV0lrR2V3MnZqeUhn?=
 =?utf-8?B?anlVaU1BbFNRdUVhVmdkWTlmU05vRXAvdFA1SkJWRkxuZ0FsRDYvUVlOSjRX?=
 =?utf-8?B?UTlVWnNXcUpobEF5eG8vNEtEZkZDWlhLdmljVkdXOWNPUDE0K2FlZmg5c0U1?=
 =?utf-8?B?OXhhQURjUTBkdU5senQ5Zk15S2k3OVMvY0RWb1FMZEx4a3RYYzhSWUllNnE4?=
 =?utf-8?B?QlhSNmFVeEtaV0xMZmFlUkNRank1blcwMlZ4R3ZnaUM1MDN4RklBZzhRdmww?=
 =?utf-8?B?UlJJSU1pWXhnRWUyZkhUUml2TUJGS2t6SHhyTENpcmdhc3MrNllackpDZU9N?=
 =?utf-8?B?NmdYU3E1N3FUSzUzbkZkWThLZ2M4TjhodVQrSHFXTHlZVzJUeGpOMlZWM3Zw?=
 =?utf-8?B?WmkzdHd3Z1BKem10NitwVHFwMTNyNEJra3MvWjZ5TkR3ZGJEL3IwMXNYOGk2?=
 =?utf-8?B?K3ZpVHF1Y3VpMzBHYmdieVdyUDdiZUdOWGkrY0JYMCtsRncrQ1Vub1ZwN1hn?=
 =?utf-8?B?M2w2RkdVK3JlQ3dDREVvL3RGSjFnZjBuZWxlNFFwVTVacHRZd1ZTYWRYdGJF?=
 =?utf-8?B?TXdhblRIbks4S2dUSzgzci80UjVBdzBIeVZYVHgvdDJYWXBOSlhKT3Izc0tN?=
 =?utf-8?B?Uk84ZFVZblZPSVBDYXFqQTh0enR4bGY4TVZrKzV6eFJBZDBZOWJtTjEyTHBE?=
 =?utf-8?B?M3JBTXZhVEczV3ZwZlVRemZYclZFSkIwUmRlK3BrNCsyNk1HSkgzM2N0d0k4?=
 =?utf-8?B?RUJYSWFQVnBZTjMzekhMczlJR1hCTDBXbC9XZEZ2cVFjdUkzbHhkN1FoeE5r?=
 =?utf-8?B?OFFMT1dMZDMyc3ZxQ3U4TlJxc3I5a0lGMlJUWFlNcjlHWmdlM1N6NFZOUG01?=
 =?utf-8?B?b1JPMzVDVXBoOWRTdXMwQmp0MWdvUGZ6R0xGSHV0b1ptNGNpektFZkhuWlZK?=
 =?utf-8?B?RUIxTHhidGxucVhtb3ZBemdUYmMySzJ1Rit5Ujc5amZCU3lsbU94WjFBOUFi?=
 =?utf-8?B?OXZjQ2FnamVvMlpDMGZZVVE1dHJXSS9uZ3FlZEtkTmlhdEp2RGhPcmdRVTcy?=
 =?utf-8?Q?rzieVFMsckeIvVgoZNgY1vaOX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0379564-1a34-4c0b-e062-08dcfce4aacf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:23:42.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96Ar3wpUTefqBtroLTSjtt87qDsXJvtkxc7R0rTkYCKPq3lU8GC68amP6Ib96KZdy/X2VG7kYgOJb8hDQqsK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451

NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
are embedded in the SoC to support the features like HSM, SHE & V2X,
using message based communication interface.

The secure enclave FW communicates on a dedicated messaging unit(MU)
based interface(s) with application core, where kernel is running.
It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.

This patch adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
Enclave (ELE) from Kernel-space, used by kernel management layers like
- DM-Crypt.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Kconfig        |  13 +
 drivers/firmware/imx/Makefile       |   2 +
 drivers/firmware/imx/ele_base_msg.c | 279 ++++++++++++++++++
 drivers/firmware/imx/ele_base_msg.h |  94 ++++++
 drivers/firmware/imx/ele_common.c   | 320 +++++++++++++++++++++
 drivers/firmware/imx/ele_common.h   |  51 ++++
 drivers/firmware/imx/se_ctrl.c      | 552 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  94 ++++++
 include/linux/firmware/imx/se_api.h |  14 +
 9 files changed, 1419 insertions(+)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 477d3f32d99a..ccd9f9e0652e 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -33,3 +33,16 @@ config IMX_SCMI_MISC_DRV
 	  core that could provide misc functions such as board control.
 
 	  This driver can also be built as a module.
+
+config IMX_SEC_ENCLAVE
+	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
+	depends on IMX_MBOX && ARCH_MXC && ARM64
+	select FW_LOADER
+	default m if ARCH_MXC
+
+	help
+	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
+	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
+	    like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
+	    Unit. This driver exposes these interfaces via a set of file descriptors
+	    allowing to configure shared memory, send and receive messages.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be8..4e1d2706535d 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
+sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
+obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
new file mode 100644
index 000000000000..53c83eddd52a
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/types.h>
+
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	dma_addr_t get_info_addr = 0;
+	u32 *get_info_data = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		return ret;
+	}
+
+	memset(s_info, 0x0, sizeof(*s_info));
+
+	if (priv->mem_pool)
+		get_info_data = gen_pool_dma_alloc(priv->mem_pool,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr);
+	else
+		get_info_data = dma_alloc_coherent(priv->dev,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr,
+						   GFP_KERNEL);
+	if (!get_info_data) {
+		ret = -ENOMEM;
+		dev_dbg(priv->dev,
+			"%s: Failed to allocate get_info_addr.\n",
+			__func__);
+		return ret;
+	}
+
+	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_GET_INFO_REQ,
+				      ELE_GET_INFO_REQ_MSG_SZ,
+				      true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[0] = upper_32_bits(get_info_addr);
+	tx_msg->data[1] = lower_32_bits(get_info_addr);
+	tx_msg->data[2] = sizeof(*s_info);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_GET_INFO_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_GET_INFO_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_GET_INFO_REQ,
+				      ELE_GET_INFO_RSP_MSG_SZ,
+				      true);
+
+	memcpy(s_info, get_info_data, sizeof(*s_info));
+
+exit:
+	if (priv->mem_pool)
+		gen_pool_free(priv->mem_pool,
+			      (u64) get_info_data,
+			      ELE_GET_INFO_BUFF_SZ);
+	else
+		dma_free_coherent(priv->dev,
+				  ELE_GET_INFO_BUFF_SZ,
+				  get_info_data,
+				  get_info_addr);
+
+	return ret;
+}
+
+int ele_fetch_soc_info(struct se_if_priv *priv, u16 *soc_rev, u64 *serial_num)
+{
+	struct ele_dev_info s_info = {0};
+	int err;
+
+	err = ele_get_info(priv, &s_info);
+	if (err < 0)
+		return err;
+
+	if (soc_rev)
+		*soc_rev = s_info.d_info.soc_rev;
+	if (serial_num)
+		*serial_num = GET_SERIAL_NUM_FROM_UID(s_info.d_info.uid, MAX_UID_SIZE >> 2);
+
+	return err;
+}
+
+int ele_ping(struct se_if_priv *priv)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_PING_REQ, ELE_PING_REQ_SZ, true);
+	if (ret) {
+		dev_err(priv->dev, "Error: se_fill_cmd_msg_hdr failed.\n");
+		goto exit;
+	}
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_PING_REQ_SZ,
+			       rx_msg,
+			       ELE_PING_RSP_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_PING_REQ,
+				      ELE_PING_RSP_SZ,
+				      true);
+exit:
+	return ret;
+}
+
+int ele_service_swap(struct se_if_priv *priv,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_SERVICE_SWAP_REQ,
+				      ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[0] = flag;
+	tx_msg->data[1] = addr_size;
+	tx_msg->data[2] = ELE_NONE_VAL;
+	tx_msg->data[3] = lower_32_bits(addr);
+	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
+						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_SERVICE_SWAP_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_SERVICE_SWAP_REQ,
+				      ELE_SERVICE_SWAP_RSP_MSG_SZ,
+				      true);
+	if (ret)
+		goto exit;
+
+	if (flag == ELE_IMEM_EXPORT)
+		ret = rx_msg->data[1];
+	else
+		ret = 0;
+
+exit:
+
+	return ret;
+}
+
+int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_FW_AUTH_REQ,
+				  ELE_FW_AUTH_REQ_SZ,
+				  true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[1] = upper_32_bits(addr);
+	tx_msg->data[0] = lower_32_bits(addr);
+	tx_msg->data[2] = addr;
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_FW_AUTH_REQ_SZ,
+			       rx_msg,
+			       ELE_FW_AUTH_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_FW_AUTH_REQ,
+				      ELE_FW_AUTH_RSP_MSG_SZ,
+				      true);
+exit:
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
new file mode 100644
index 000000000000..e390d35fc787
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ *
+ * Header file for the EdgeLock Enclave Base API(s).
+ */
+
+#ifndef ELE_BASE_MSG_H
+#define ELE_BASE_MSG_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include "se_ctrl.h"
+
+#define ELE_NONE_VAL			0x0
+
+#define ELE_GET_INFO_REQ		0xDA
+#define ELE_GET_INFO_REQ_MSG_SZ		0x10
+#define ELE_GET_INFO_RSP_MSG_SZ		0x08
+
+#define SOC_ID_MASK			0x0000FFFF
+
+#define MAX_UID_SIZE                     (16)
+#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
+#define DEV_GETINFO_FW_SHA_SZ            (32)
+#define DEV_GETINFO_OEM_SRKH_SZ          (64)
+#define DEV_GETINFO_MIN_VER_MASK	0xFF
+#define DEV_GETINFO_MAJ_VER_MASK	0xFF00
+#define ELE_DEV_INFO_EXTRA_SZ		0x60
+
+struct dev_info {
+	uint8_t  cmd;
+	uint8_t  ver;
+	uint16_t length;
+	uint16_t soc_id;
+	uint16_t soc_rev;
+	uint16_t lmda_val;
+	uint8_t  ssm_state;
+	uint8_t  dev_atts_api_ver;
+	uint8_t  uid[MAX_UID_SIZE];
+	uint8_t  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
+	uint8_t  sha_fw[DEV_GETINFO_FW_SHA_SZ];
+};
+
+struct dev_addn_info {
+	uint8_t  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
+	uint8_t  trng_state;
+	uint8_t  csal_state;
+	uint8_t  imem_state;
+	uint8_t  reserved2;
+};
+
+struct ele_dev_info {
+	struct dev_info d_info;
+	struct dev_addn_info d_addn_info;
+};
+
+#define ELE_GET_INFO_BUFF_SZ		(sizeof(struct ele_dev_info) \
+						+ ELE_DEV_INFO_EXTRA_SZ)
+
+#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
+	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
+
+#define ELE_DEBUG_DUMP_REQ		0x21
+#define ELE_DEBUG_DUMP_RSP_SZ		0x14
+
+#define ELE_PING_REQ			0x01
+#define ELE_PING_REQ_SZ			0x04
+#define ELE_PING_RSP_SZ			0x08
+
+#define ELE_SERVICE_SWAP_REQ		0xDF
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
+#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
+#define ELE_IMEM_SIZE			0x10000
+#define ELE_IMEM_STATE_OK		0xCA
+#define ELE_IMEM_STATE_BAD		0xFE
+#define ELE_IMEM_STATE_WORD		0x27
+#define ELE_IMEM_STATE_MASK		0x00ff0000
+#define ELE_IMEM_EXPORT			0x1
+#define ELE_IMEM_IMPORT			0x2
+
+#define ELE_FW_AUTH_REQ			0x02
+#define ELE_FW_AUTH_REQ_SZ		0x10
+#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
+
+int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info);
+int ele_fetch_soc_info(struct se_if_priv *priv, u16 *soc_rev, u64 *serial_num);
+int ele_ping(struct se_if_priv *priv);
+int ele_service_swap(struct se_if_priv *priv,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag);
+int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr);
+#endif
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
new file mode 100644
index 000000000000..f7c760bbc7a3
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+u32 se_add_msg_crc(u32 *msg, u32 msg_len)
+{
+	u32 nb_words = msg_len / (u32)sizeof(u32);
+	u32 crc = 0;
+	u32 i;
+
+	for (i = 0; i < nb_words - 1; i++)
+		crc ^= *(msg + i);
+
+	return crc;
+}
+
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl)
+{
+	int err = 0;
+
+	do {
+		/* If callback is executed before entrying to wait state,
+		 * it will immediately come out after entering the wait state,
+		 * but completion_done(&se_clbk_hdl->done), will return false
+		 * after exiting the wait state, with err = 0.
+		 */
+		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
+		if (err == -ERESTARTSYS) {
+			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
+				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
+				continue;
+			}
+			dev_err(priv->dev,
+				"Err[0x%x]:Interrupted by signal.\n",
+				err);
+			err = -EINTR;
+			break;
+		}
+	} while (err != 0);
+
+	return err ? err : se_clbk_hdl->rx_msg_sz;
+}
+
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz)
+{
+	struct se_msg_hdr *header;
+	int err;
+
+	header = tx_msg;
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	if (header->size << 2 != tx_msg_sz) {
+		err = -EINVAL;
+		dev_err(priv->dev,
+			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			*(u32 *)header,
+			header->size << 2, tx_msg_sz);
+		goto exit;
+	}
+
+	err = mbox_send_message(priv->tx_chan, tx_msg);
+	if (err < 0) {
+		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		return err;
+	}
+	err = tx_msg_sz;
+
+exit:
+	return err;
+}
+
+/* API used for send/receive blocking call. */
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz)
+{
+	int err;
+
+	guard(mutex)(&priv->se_if_cmd_lock);
+
+	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
+	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
+
+	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	if (err < 0)
+		goto exit;
+
+	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+
+	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
+		err = -EINTR;
+		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
+	}
+
+exit:
+	return err;
+}
+
+static bool exception_for_size(struct se_if_priv *priv,
+				struct se_msg_hdr *header)
+{
+	/* List of API(s) that can be accepte variable length
+	 * response buffer.
+	 */
+	if (header->command == ELE_DEBUG_DUMP_REQ &&
+		header->ver == priv->if_defs->base_api_ver &&
+		header->size >= 0 &&
+		header->size <= ELE_DEBUG_DUMP_RSP_SZ)
+		return true;
+
+	return false;
+}
+
+/*
+ * Callback called by mailbox FW, when data is received.
+ */
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
+{
+	struct se_clbk_handle *se_clbk_hdl;
+	struct device *dev = mbox_cl->dev;
+	struct se_msg_hdr *header;
+	struct se_if_priv *priv;
+	u32 rx_msg_sz;
+
+	priv = dev_get_drvdata(dev);
+
+	/* The function can be called with NULL msg */
+	if (!msg) {
+		dev_err(dev, "Message is invalid\n");
+		return;
+	}
+
+	header = msg;
+	rx_msg_sz = header->size << 2;
+
+	/* Incoming command: wake up the receiver if any. */
+	if (header->tag == priv->if_defs->cmd_tag) {
+		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting cmd receiver for mesg header:0x%x.",
+			*(u32 *) header);
+
+		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
+		 * as the NVM command are initiated by FW.
+		 * Size is revealed as part of this call function.
+		 */
+		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
+			dev_err(dev,
+				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *) header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = MAX_NVM_MSG_LEN;
+		}
+		se_clbk_hdl->rx_msg_sz = rx_msg_sz;
+
+	} else if (header->tag == priv->if_defs->rsp_tag) {
+		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting resp waiter for mesg header:0x%x.",
+			*(u32 *) header);
+
+		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz
+				&& !exception_for_size(priv, header)) {
+			dev_err(dev,
+				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *) header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = min(rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+		}
+	} else {
+		dev_err(dev, "Failed to select a device for message: %.8x\n",
+			*((u32 *) header));
+		return;
+	}
+
+	memcpy(se_clbk_hdl->rx_msg, msg, se_clbk_hdl->rx_msg_sz);
+
+	/* Allow user to read */
+	complete(&se_clbk_hdl->done);
+}
+
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    uint8_t msg_id,
+			    uint8_t sz,
+			    bool is_base_api)
+{
+	u32 status;
+	struct se_msg_hdr *header = &msg->header;
+
+	if (header->tag != priv->if_defs->rsp_tag) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
+			msg_id, header->tag, priv->if_defs->rsp_tag);
+		return -EINVAL;
+	}
+
+	if (header->command != msg_id) {
+		dev_err(priv->dev,
+			"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
+			header->command, msg_id);
+		return -EINVAL;
+	}
+
+	if (header->size != (sz >> 2)) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
+			msg_id, header->size, (sz >> 2));
+		return -EINVAL;
+	}
+
+	if (is_base_api && (header->ver != priv->if_defs->base_api_ver)) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->if_defs->base_api_ver);
+		return -EINVAL;
+	} else if (!is_base_api && header->ver != priv->if_defs->fw_api_ver) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->if_defs->fw_api_ver);
+		return -EINVAL;
+	}
+
+	status = RES_STATUS(msg->data[0]);
+	if (status != priv->if_defs->success_tag) {
+		dev_err(priv->dev, "Command Id[%d], Response Failure = 0x%x",
+			header->command, status);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
+{
+	int ret;
+
+	/* EXPORT command will save encrypted IMEM to given address,
+	 * so later in resume, IMEM can be restored from the given
+	 * address.
+	 *
+	 * Size must be at least 64 kB.
+	 */
+	ret = ele_service_swap(priv,
+			       imem->phyaddr,
+			       ELE_IMEM_SIZE,
+			       ELE_IMEM_EXPORT);
+	if (ret < 0)
+		dev_err(priv->dev, "Failed to export IMEM\n");
+	else
+		dev_info(priv->dev,
+			 "Exported %d bytes of encrypted IMEM\n",
+			 ret);
+
+	return ret;
+}
+
+int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
+{
+	struct ele_dev_info s_info;
+	int ret;
+
+	/* get info from ELE */
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		return ret;
+	}
+	imem->state = s_info.d_addn_info.imem_state;
+
+	/* Get IMEM state, if 0xFE then import IMEM */
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD) {
+		/* IMPORT command will restore IMEM from the given
+		 * address, here size is the actual size returned by ELE
+		 * during the export operation
+		 */
+		ret = ele_service_swap(priv,
+				       imem->phyaddr,
+				       imem->size,
+				       ELE_IMEM_IMPORT);
+		if (ret) {
+			dev_err(priv->dev, "Failed to import IMEM\n");
+			goto exit;
+		}
+	} else
+		goto exit;
+
+	/* After importing IMEM, check if IMEM state is equal to 0xCA
+	 * to ensure IMEM is fully loaded and
+	 * ELE functionality can be used.
+	 */
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		goto exit;
+	}
+	imem->state = s_info.d_addn_info.imem_state;
+
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_OK)
+		dev_info(priv->dev, "Successfully restored IMEM\n");
+	else
+		dev_err(priv->dev, "Failed to restore IMEM\n");
+
+exit:
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
new file mode 100644
index 000000000000..3d8b6f83fb9d
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+
+#ifndef __ELE_COMMON_H__
+#define __ELE_COMMON_H__
+
+#include "se_ctrl.h"
+
+#define ELE_SUCCESS_IND			0xD6
+
+#define IMX_ELE_FW_DIR                 "imx/ele/"
+
+uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl);
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz);
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz);
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    uint8_t msg_id,
+			    uint8_t sz,
+			    bool is_base_api);
+
+/* Fill a command message header with a given command ID and length in bytes. */
+static inline int se_fill_cmd_msg_hdr(struct se_if_priv *priv,
+				      struct se_msg_hdr *hdr,
+				      u8 cmd, u32 len,
+				      bool is_base_api)
+{
+	hdr->tag = priv->if_defs->cmd_tag;
+	hdr->ver = (is_base_api) ? priv->if_defs->base_api_ver : priv->if_defs->fw_api_ver;
+	hdr->command = cmd;
+	hdr->size = len >> 2;
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
+int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
+
+#endif /*__ELE_COMMON_H__ */
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
new file mode 100644
index 000000000000..40d815d0ac9b
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/firmware.h>
+#include <linux/firmware/imx/se_api.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+#include "se_ctrl.h"
+
+#define MBOX_TX_NAME			"tx"
+#define MBOX_RX_NAME			"rx"
+#define SE_TYPE_HSM			"hsm"
+
+struct se_fw_load_info {
+	const u8 *prim_fw_nm_in_rfs;
+	const u8 *seco_fw_nm_in_rfs;
+	struct mutex se_fw_load;
+	bool is_fw_loaded;
+	bool handle_susp_resm;
+	struct se_imem_buf imem;
+};
+
+struct se_if_node_info {
+	u8 se_if_id;
+	u8 se_if_did;
+	struct se_if_defines if_defs;
+	u8 *se_name;
+	u8 *pool_name;
+	bool soc_register;
+	bool reserved_dma_ranges;
+	int (*se_fetch_soc_info)(struct se_if_priv *priv, u16 *soc_rev, u64 *serial_num);
+};
+
+struct se_if_node_info_list {
+	const u8 num_mu;
+	const u16 soc_id;
+	struct se_fw_load_info load_hsm_fw;
+	const struct se_if_node_info info[];
+};
+
+static u16 se_soc_rev;
+static struct se_if_node_info_list imx8ulp_info = {
+	.num_mu = 1,
+	.soc_id = SOC_ID_OF_IMX8ULP,
+	.load_hsm_fw = {
+		.prim_fw_nm_in_rfs = IMX_ELE_FW_DIR
+			"mx8ulpa2-ahab-container.img",
+		.seco_fw_nm_in_rfs = IMX_ELE_FW_DIR
+			"mx8ulpa2ext-ahab-container.img",
+		.is_fw_loaded = false,
+		.handle_susp_resm = true,
+		.imem = {
+			.state = ELE_IMEM_STATE_OK,
+		},
+	},
+	.info = {
+			{
+			.se_if_id = 0,
+			.se_if_did = 7,
+			.if_defs = {
+				.cmd_tag = 0x17,
+				.rsp_tag = 0xe1,
+				.success_tag = ELE_SUCCESS_IND,
+				.base_api_ver = MESSAGING_VERSION_6,
+				.fw_api_ver = MESSAGING_VERSION_7,
+			},
+			.se_name = SE_TYPE_HSM"1",
+			.pool_name = "sram",
+			.soc_register = true,
+			.reserved_dma_ranges = true,
+			.se_fetch_soc_info = ele_fetch_soc_info,
+			},
+	},
+};
+
+static struct se_if_node_info_list imx93_info = {
+	.num_mu = 1,
+	.soc_id = SOC_ID_OF_IMX93,
+	.load_hsm_fw = {
+		.prim_fw_nm_in_rfs = NULL,
+		.seco_fw_nm_in_rfs = NULL,
+		.is_fw_loaded = true,
+		.handle_susp_resm = false,
+	},
+	.info = {
+			{
+			.se_if_id = 2,
+			.se_if_did = 3,
+			.if_defs = {
+				.cmd_tag = 0x17,
+				.rsp_tag = 0xe1,
+				.success_tag = ELE_SUCCESS_IND,
+				.base_api_ver = MESSAGING_VERSION_6,
+				.fw_api_ver = MESSAGING_VERSION_7,
+			},
+			.se_name = SE_TYPE_HSM"1",
+			.reserved_dma_ranges = true,
+			.soc_register = true,
+			},
+	},
+};
+
+static const struct of_device_id se_match[] = {
+	{ .compatible = "fsl,imx8ulp-se", .data = (void *)&imx8ulp_info},
+	{ .compatible = "fsl,imx93-se", .data = (void *)&imx93_info},
+	{},
+};
+
+static const struct se_if_node_info
+	*get_se_if_node_info(const struct se_if_node_info_list *info_list,
+			     const u32 idx)
+{
+	return &info_list->info[idx];
+}
+
+static int se_soc_info(struct se_if_priv *priv)
+{
+	const struct se_if_node_info *info;
+	struct se_if_node_info_list *info_list;
+	struct soc_device_attribute *attr;
+	struct soc_device *sdev;
+	u64 serial_num;
+	int err = 0;
+
+	info = container_of(priv->if_defs,
+			typeof(*info),
+			if_defs);
+	info_list = container_of(info,
+			typeof(*info_list),
+			info[info->se_if_id]);
+
+	/* This function should be called once.
+	 * Check if the se_soc_rev is zero to continue.
+	 */
+	if (se_soc_rev)
+		return err;
+
+	if (info->se_fetch_soc_info) {
+		err = info->se_fetch_soc_info(priv, &se_soc_rev, &serial_num);
+		if (err < 0) {
+			dev_err(priv->dev, "Failed to fetch SoC Info.");
+			return err;
+		}
+	} else {
+		dev_err(priv->dev, "Failed to fetch SoC revision.");
+		if (info->soc_register)
+			dev_err(priv->dev, "Failed to do SoC registration.");
+		err = -EINVAL;
+		return err;
+	}
+
+	if (!info->soc_register)
+		return 0;
+
+	attr = devm_kzalloc(priv->dev, sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, se_soc_rev))
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x.%x",
+						FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
+							  se_soc_rev),
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  se_soc_rev));
+	else
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x",
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  se_soc_rev));
+
+	switch (info_list->soc_id) {
+	case SOC_ID_OF_IMX8ULP:
+		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
+					      "i.MX8ULP");
+		break;
+	case SOC_ID_OF_IMX93:
+		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
+					      "i.MX93");
+		break;
+	}
+
+	err = of_property_read_string(of_root, "model",
+				      &attr->machine);
+	if (err)
+		return -EINVAL;
+
+	attr->family = devm_kasprintf(priv->dev, GFP_KERNEL, "Freescale i.MX");
+
+	attr->serial_number
+		= devm_kasprintf(priv->dev, GFP_KERNEL, "%016llX", serial_num);
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev))
+		return PTR_ERR(sdev);
+
+	return 0;
+}
+
+static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
+{
+	const struct se_if_node_info *info = container_of(priv->if_defs,
+							typeof(*info),
+							if_defs);
+	struct se_if_node_info_list *info_list;
+	struct se_fw_load_info *load_fw = NULL;
+
+	info_list = container_of(info,
+			typeof(*info_list),
+			info[info->se_if_id]);
+
+	if (!memcmp(SE_TYPE_HSM, info->se_name, strlen(SE_TYPE_HSM)))
+		load_fw = &info_list->load_hsm_fw;
+	else
+		dev_err(priv->dev, "Invalid load fw configuration.");
+
+	return load_fw;
+}
+
+static int se_load_firmware(struct se_if_priv *priv)
+{
+	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
+	const struct firmware *fw;
+	phys_addr_t se_fw_phyaddr;
+	const u8 *se_img_file_to_load;
+	u8 *se_fw_buf;
+	int ret;
+
+	guard(mutex)(&load_fw->se_fw_load);
+	if (load_fw->is_fw_loaded)
+		return 0;
+
+	se_img_file_to_load = load_fw->seco_fw_nm_in_rfs;
+	if (load_fw->prim_fw_nm_in_rfs) {
+		/* allocate buffer where SE store encrypted IMEM */
+		load_fw->imem.buf = dmam_alloc_coherent(priv->dev, ELE_IMEM_SIZE,
+							&load_fw->imem.phyaddr,
+							GFP_KERNEL);
+		if (!load_fw->imem.buf) {
+			dev_err(priv->dev,
+				"dmam-alloc-failed: To store encr-IMEM.\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+		if (load_fw->imem.state == ELE_IMEM_STATE_BAD)
+			se_img_file_to_load
+					= load_fw->prim_fw_nm_in_rfs;
+	}
+
+	do {
+		ret = request_firmware(&fw, se_img_file_to_load, priv->dev);
+		if (ret)
+			goto exit;
+
+		dev_info(priv->dev, "loading firmware %s\n", se_img_file_to_load);
+
+		/* allocate buffer to store the SE FW */
+		se_fw_buf = dma_alloc_coherent(priv->dev, fw->size,
+				&se_fw_phyaddr, GFP_KERNEL);
+		if (!se_fw_buf) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		memcpy(se_fw_buf, fw->data, fw->size);
+		ret = ele_fw_authenticate(priv, se_fw_phyaddr);
+		if (ret < 0) {
+			dev_err(priv->dev,
+					"Error %pe: Authenticate & load SE firmware %s.\n",
+					ERR_PTR(ret),
+					se_img_file_to_load);
+			ret = -EPERM;
+		}
+
+		dma_free_coherent(priv->dev,
+				  fw->size,
+				  se_fw_buf,
+				  se_fw_phyaddr);
+
+		release_firmware(fw);
+
+		if (!ret && load_fw->imem.state == ELE_IMEM_STATE_BAD &&
+				se_img_file_to_load == load_fw->prim_fw_nm_in_rfs)
+			se_img_file_to_load = load_fw->seco_fw_nm_in_rfs;
+		else
+			se_img_file_to_load = NULL;
+
+	} while (se_img_file_to_load);
+
+	if (!ret)
+		load_fw->is_fw_loaded = true;
+
+exit:
+	return ret;
+}
+
+/* interface for managed res to free a mailbox channel */
+static void if_mbox_free_channel(void *mbox_chan)
+{
+	mbox_free_channel(mbox_chan);
+}
+
+static int se_if_request_channel(struct device *dev,
+				 struct mbox_chan **chan,
+				 struct mbox_client *cl,
+				 const char *name)
+{
+	struct mbox_chan *t_chan;
+	int ret = 0;
+
+	t_chan = mbox_request_channel_byname(cl, name);
+	if (IS_ERR(t_chan)) {
+		ret = PTR_ERR(t_chan);
+		return dev_err_probe(dev, ret,
+				     "Failed to request %s channel.", name);
+	}
+
+	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
+	if (ret) {
+		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
+		goto exit;
+	}
+
+	*chan = t_chan;
+
+exit:
+	return ret;
+}
+
+static void se_if_probe_cleanup(void *plat_dev)
+{
+	struct platform_device *pdev = plat_dev;
+	struct device *dev = &pdev->dev;
+	struct se_fw_load_info *load_fw;
+	struct se_if_priv *priv;
+
+	priv = dev_get_drvdata(dev);
+	load_fw = get_load_fw_instance(priv);
+
+	/* In se_if_request_channel(), passed the clean-up functional
+	 * pointer reference as action to devm_add_action().
+	 * No need to free the mbox channels here.
+	 */
+
+	/* free the buffer in se remove, previously allocated
+	 * in se probe to store encrypted IMEM
+	 */
+	if (load_fw && load_fw->imem.buf) {
+		dmam_free_coherent(dev,
+				   ELE_IMEM_SIZE,
+				   load_fw->imem.buf,
+				   load_fw->imem.phyaddr);
+		load_fw->imem.buf = NULL;
+	}
+
+	/* No need to check, if reserved memory is allocated
+	 * before calling for its release. Or clearing the
+	 * un-set bit.
+	 */
+	of_reserved_mem_device_release(dev);
+}
+
+static int se_if_probe(struct platform_device *pdev)
+{
+	const struct se_if_node_info_list *info_list;
+	const struct se_if_node_info *info;
+	struct device *dev = &pdev->dev;
+	struct se_fw_load_info *load_fw;
+	struct se_if_priv *priv;
+	u32 idx;
+	int ret;
+
+	idx = GET_IDX_FROM_DEV_NODE_NAME(dev->of_node);
+	info_list = device_get_match_data(dev);
+	if (idx >= info_list->num_mu) {
+		dev_err(dev,
+			"Incorrect node name :%s\n",
+			dev->of_node->full_name);
+		dev_err(dev,
+			"%s-<index>, acceptable index range is 0..%d\n",
+			dev->of_node->name,
+			info_list->num_mu - 1);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	info = get_se_if_node_info(info_list, idx);
+	if (!info) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	priv->dev = dev;
+	priv->if_defs = &info->if_defs;
+	dev_set_drvdata(dev, priv);
+
+	ret = devm_add_action(dev, se_if_probe_cleanup, pdev);
+	if (ret)
+		goto exit;
+
+
+	/* Mailbox client configuration */
+	priv->se_mb_cl.dev		= dev;
+	priv->se_mb_cl.tx_block		= false;
+	priv->se_mb_cl.knows_txdone	= true;
+	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
+
+	ret = se_if_request_channel(dev, &priv->tx_chan,
+			&priv->se_mb_cl, MBOX_TX_NAME);
+	if (ret)
+		goto exit;
+
+	ret = se_if_request_channel(dev, &priv->rx_chan,
+			&priv->se_mb_cl, MBOX_RX_NAME);
+	if (ret)
+		goto exit;
+
+	mutex_init(&priv->se_if_cmd_lock);
+
+	init_completion(&priv->waiting_rsp_clbk_hdl.done);
+	init_completion(&priv->cmd_receiver_clbk_hdl.done);
+
+	if (info->pool_name) {
+		priv->mem_pool = of_gen_pool_get(dev->of_node,
+							 info->pool_name, 0);
+		if (!priv->mem_pool) {
+			dev_err(dev,
+				"Unable to get sram pool = %s\n",
+				info->pool_name);
+			goto exit;
+		}
+	}
+
+	if (info->reserved_dma_ranges) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret) {
+			dev_err(dev,
+				"failed to init reserved memory region %d\n",
+				ret);
+			goto exit;
+		}
+	}
+
+	ret = se_soc_info(priv);
+	if (ret) {
+		dev_err(dev,
+			"failed[%pe] to fetch SoC Info\n", ERR_PTR(ret));
+		goto exit;
+	}
+
+	load_fw = get_load_fw_instance(priv);
+	/* By default, there is no pending FW to be loaded.*/
+	if (load_fw->is_fw_loaded) {
+		mutex_init(&load_fw->se_fw_load);
+		ret = se_load_firmware(priv);
+		if (ret)
+			dev_warn(dev, "Failed to load firmware.");
+		ret = 0;
+	}
+	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
+		 info->se_name);
+	return ret;
+
+exit:
+	/* if execution control reaches here, if probe fails.
+	 */
+	return dev_err_probe(dev, ret, "%s: Probe failed.", __func__);
+
+	return ret;
+}
+
+static void se_if_remove(struct platform_device *pdev)
+{
+	se_if_probe_cleanup(pdev);
+}
+
+static int se_suspend(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_fw_load_info *load_fw;
+	int ret = 0;
+
+	load_fw = get_load_fw_instance(priv);
+
+	if (load_fw->handle_susp_resm) {
+		ret = se_save_imem_state(priv, &load_fw->imem);
+		if (ret < 0)
+			goto exit;
+		load_fw->imem.size = ret;
+	}
+exit:
+	return ret;
+}
+
+static int se_resume(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_fw_load_info *load_fw;
+
+	load_fw = get_load_fw_instance(priv);
+
+	if (load_fw->handle_susp_resm)
+		se_restore_imem_state(priv, &load_fw->imem);
+
+	return 0;
+}
+
+static const struct dev_pm_ops se_pm = {
+	RUNTIME_PM_OPS(se_suspend, se_resume, NULL)
+};
+
+static struct platform_driver se_driver = {
+	.driver = {
+		.name = "fsl-se-fw",
+		.of_match_table = se_match,
+		.pm = &se_pm,
+	},
+	.probe = se_if_probe,
+	.remove = se_if_remove,
+};
+MODULE_DEVICE_TABLE(of, se_match);
+
+module_platform_driver(se_driver);
+MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
+MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
new file mode 100644
index 000000000000..de0d4a1bcb9e
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef SE_MU_H
+#define SE_MU_H
+
+#include <linux/miscdevice.h>
+#include <linux/semaphore.h>
+#include <linux/mailbox_client.h>
+
+#define MAX_FW_LOAD_RETRIES		50
+
+#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_NVM_MSG_LEN			(256)
+#define MESSAGING_VERSION_6		0x6
+#define MESSAGING_VERSION_7		0x7
+#define NODE_NAME			"secure-enclave"
+
+#define GET_ASCII_TO_U8(diff, tens_chr, ones_chr) \
+		((diff > 2) ? (((tens_chr - '0') * 10) + (ones_chr - '0')) :\
+		(tens_chr - '0'))
+
+#define GET_IDX_FROM_DEV_NODE_NAME(dev_of_node) \
+		((strlen(dev_of_node->full_name) > strlen(NODE_NAME)) ?\
+		GET_ASCII_TO_U8((strlen(dev_of_node->full_name) - strlen(NODE_NAME)),\
+				dev_of_node->full_name[strlen(NODE_NAME) + 1], \
+				dev_of_node->full_name[strlen(NODE_NAME) + 2]) : 0)
+
+struct se_clbk_handle {
+	struct completion done;
+	bool signal_rcvd;
+	atomic_t pending_hdr;
+	u32 rx_msg_sz;
+	/* Assignment of the rx_msg buffer to held till the
+	 * received content as part callback function, is copied.
+	 */
+	struct se_api_msg *rx_msg;
+};
+
+struct se_imem_buf {
+	u8 *buf;
+	phys_addr_t phyaddr;
+	u32 size;
+	u32 state;
+};
+
+/* Header of the messages exchange with the EdgeLock Enclave */
+struct se_msg_hdr {
+	u8 ver;
+	u8 size;
+	u8 command;
+	u8 tag;
+}  __packed;
+
+#define SE_MU_HDR_SZ	4
+
+struct se_api_msg {
+	struct se_msg_hdr header;
+	u32 data[];
+};
+
+struct se_if_defines {
+	const void *info;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+};
+
+struct se_if_priv {
+	struct device *dev;
+
+	struct se_clbk_handle cmd_receiver_clbk_hdl;
+	/* Update to the waiting_rsp_dev, to be protected
+	 * under se_if_cmd_lock.
+	 */
+	struct se_clbk_handle waiting_rsp_clbk_hdl;
+	/*
+	 * prevent new command to be sent on the se interface while previous
+	 * command is still processing. (response is awaited)
+	 */
+	struct mutex se_if_cmd_lock;
+
+	struct mbox_client se_mb_cl;
+	struct mbox_chan *tx_chan, *rx_chan;
+
+	struct gen_pool *mem_pool;
+	const struct se_if_defines *if_defs;
+};
+
+#endif
diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
new file mode 100644
index 000000000000..c47f84906837
--- /dev/null
+++ b/include/linux/firmware/imx/se_api.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __SE_API_H__
+#define __SE_API_H__
+
+#include <linux/types.h>
+
+#define SOC_ID_OF_IMX8ULP		0x084D
+#define SOC_ID_OF_IMX93			0x9300
+
+#endif /* __SE_API_H__ */

-- 
2.34.1


