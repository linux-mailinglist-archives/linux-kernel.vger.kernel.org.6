Return-Path: <linux-kernel+bounces-216650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FC90A29E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA4B20FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C51917B4F7;
	Mon, 17 Jun 2024 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QWvSYx3f"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB957176ABF;
	Mon, 17 Jun 2024 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592478; cv=fail; b=n8LeNrC+MnfC1T/5/gLiNPtFBxURr/Fb4uEle89U4ArzGGw5UA3DU1eUFbf5jDMP/D0e+he5cLCiAvs/sJq4qc3IrGtOOMLF2t3TgSj9+tu/bVTOcB3I8Zco3xMq3USz0zOqxDgJMxnv7FUu875fCWyftyc2V78pQyvwlJndo4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592478; c=relaxed/simple;
	bh=nuMNhJhS5yAeIpGNq3NvYIQjto0pwR3sOqaspgP0/dw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=plP3gX8BkRYuZa23T92o7ePYcbwC+U5vjgdnJcG56XVWtjWe18To6z1HwMRI9iOFHr47Mf3h5rka5gOUuW4y1XzGO13CAOgdKf9RsFRs1c/QmPIX2RpLNR2mbdtOAD5Q/G442gzokBW0mNeP7eYDu323clPhC5nyq8TH/Yg55u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QWvSYx3f; arc=fail smtp.client-ip=40.107.6.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHtC3ZVFb6j8brQW3yAY1EsvnjzLNfDAfrc8XKt7cpjc4HCACddqjUVfNklhzBVLGMD12DWh2V4raiEsDcWr2D/PTYgRSMqgIJIhqvzJWla6ProBPepV1bLfhOO6X1YFjtrVzFjvmSmP5OZ9IvW1kBMWma8fRPg3gXcAbWgf2rB/DYk0QUyQbc1Jbl0NCRuLLR659cm0wM28sGb8mwmJrl5iBhcOiqYnbTPJL/82d4yseJ2x6bquIN6Neg6rIORX63UuobTqiwS5PVEB4OJJl5H/HMUxe2oQZz1eKLCsAeBbpSdwB4LUpWXUFMeQce6qx4nEBX95Xg3lkBlBjSrHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQuVCUdBYYKdzkK/T1aXJcPpKpZkh56sMZtWDuPTNNk=;
 b=bpoaAXPcfM50osyvvmpnWyIOM1rtNOAO4MphLj8wbFZirs00rSifEt8wp6ur85yaR6wNDNKOoyjEcuClJjK3XrBe9QClwjmHHKm9v7kzQcJRtT0EsBEsABl9yJ9eAG0TgnFcUglJZqkiyjsqES2MdXa6rpW6p3Fw9Ky/o9aAoArfTylQtYthNuJ1FroVGLOumfqX0d03Lu1mFJdlUbIjXE7liuTKEOE6Np1jqqCLVipT8zy2dtbRtdEiEpz4pVaW3MgMxIR7W7Bwuiw50evZKRiClck6RCrJ8Sitqgm3GVArXN3Nzn8Tnzew2H3uYKwT3h3Rd+Wy7tPKAgVFu9RBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQuVCUdBYYKdzkK/T1aXJcPpKpZkh56sMZtWDuPTNNk=;
 b=QWvSYx3fZ0L3ouqss/kDQFiXErI4MfdMdPp3so2EAM6DChrTZ35bDure3bXiP5VK1E6hu+oZcI2gl8F5mEdiapPb/IhTDRJowun1zWhZXqH3oLYv46nZ9GRz+kKnFzwzb4M4kjJ+7s5x/1wf71pekke1RaeaoDLKYNQdPi9filE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS4PR04MB9482.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 02:47:50 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 02:47:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 17 Jun 2024 10:56:37 +0800
Subject: [PATCH v7 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK minimal
 board dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-imx95-dts-v3-v7-3-488b52e10862@nxp.com>
References: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
In-Reply-To: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718593010; l=6852;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=qNOZYoKbm7lT0ZTcwCz4DiDeeaWryovvoN9zkXMx7WI=;
 b=nZHY+uWSLfRSYOZvRRnl0RS1X77XLXv8BRtrviEYa1q3KvFlJbTln80bgBkuAFlsQ9lWKThbf
 N/XWvWNo2y7AjjiZUKfCUC+vdYE17eg48sfSTJqVqHsl7rBwMwd7LBJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|AS4PR04MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 92647732-a3c6-4b81-aa0c-08dc8e77e0de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGI4MXlGTmZqakVpRk9EMHlINGs4azNSaWFjYUJSLytDbXErbUpBbkc4TlY5?=
 =?utf-8?B?Q3NGSXhWa24wbEJMWkEySk9ERUJGS3VHVnF0di9aUWVxV2J5alYya1FrRXVM?=
 =?utf-8?B?aUxQblZYeCs3cFRJODFEdm96UE1QLzZsYll4RWJwQ0tGWk9CTm90UHUrZUYz?=
 =?utf-8?B?T2t3dHFpTHdLTTFUMjdQN0prQTRXVG1XL2hHVGUremI0K3IzWG1HQWwvQklo?=
 =?utf-8?B?YzBocU1vVFZWUk5zak1nUVNjWmVBVHpDT21BWkt0QVZ0WFBYTUluNmpkbGtE?=
 =?utf-8?B?QzY3WHo1RjY3OGROUFhiVzVJeG1qclR0Z0NyN20rb2swT0tSU0N0QmlZTkMy?=
 =?utf-8?B?Rk80U3I0L0lHQW1CT3g3LzNJN2JObWpWeittS0tpclk1ejJHeWV1OGx4Yy9G?=
 =?utf-8?B?VHd6d2NiSGt4OVF0dzBKSFFrNzg0ZmhyU3hNVHduR1VqVElxNTBMSjgwTW1U?=
 =?utf-8?B?Qlo1NEZ4dERzb1MzTWRXTUIxRUtCRjl0K0JpMmc5YzJzL2NKaU1QRkNXNHJS?=
 =?utf-8?B?SUNxTGladTBFNHd3ejloYTJwSkxQL2svVVNWVytFWlRITTV5aVRpWVpManBr?=
 =?utf-8?B?K1l5NVBEeStDYUNhRXFNM3p4cCs3Rmc0MkM1TWQySFRtZWZOaHNnSmxDSXJs?=
 =?utf-8?B?QWxJUUd2U09OMlc1S2IrcU5QOEp6WFZqRkc3MWtiM0ZSZHhpRTd6dzJUSXZ4?=
 =?utf-8?B?bGZpYnNyVjBXdXZaSldLSmJRYnNQUWMxd2N0K3lvZU1RUkM0cWhwNkErSEY4?=
 =?utf-8?B?VXJFdXhvZjJtdW9QeUJpYXA4TEMyaHB0ekJna1ZyREpKUUc4QnhBZkNNOXhq?=
 =?utf-8?B?MkRkcGxzKzhwQTNuWGJnNkMzTlFnNHhnbTJ0VCszYjlwd1ZwdlgycFAyb3BI?=
 =?utf-8?B?VFpGbjVFbHVudTVnTW5heWdDUHYycldZS2QyRytGTjVNbTg1eE9vZHk4MWox?=
 =?utf-8?B?eUp3UG9VbjNITFppREVVUVdyaG15UitGUTV0a2VNMTNxdVVIUFpGUmVUWVZC?=
 =?utf-8?B?Mm53NHk0K0l1aEkxT2kyUHFxZnMzQ3E2WndIWEpWWWRMenh1WHNIdnZlU0RM?=
 =?utf-8?B?M2hQOGhCWEc5ek5UTE52SVRGUHBTWlBpUkhPRis4aFoxTVVlYjM3bnV0azJZ?=
 =?utf-8?B?YzNySEFQdThYWDhwcDM5bDRkVVdHY25UMGdDWE9wN3lXUlZ3K0FyZEl6OTdQ?=
 =?utf-8?B?QlpsZ090NTVtNVEzN1lld3FEVHdSOHFlTzZtVEVmaldQRWg0QnhCdW8vcEpU?=
 =?utf-8?B?bm5VNXpnWUxiZ0VqaHJWc3N0S2cyemkwcTB4dFFXSVVyRlZmTldNN1ZkSmJW?=
 =?utf-8?B?MzNZckI0NXNkS1ZGa3A4VWxpV3FrZWh5NlFaOTNBS3JkenpjMXJlU0sxWE5Z?=
 =?utf-8?B?TVg5WWJWSll4ZG00Z1orZnE1SngyYUlvNTU1WjZnYjlJMXBCVEVodG5sTG1j?=
 =?utf-8?B?ZVM3L0l1Y2MrYmRzTXhTNExIWUNTNEw3UmtQWE1SdzlKcWg4d3YrQlYwUksy?=
 =?utf-8?B?ZUU0bWtwY1JqeXdGOWxhZkxMKzlOaGFMNld1TGJtZGJaaFBhTy9pbkQyK0NT?=
 =?utf-8?B?dnl1YU5uc1pXQ3hVK2JWemthemdCRnRRZTVYZUFDWTAyUWFIYkM5T2Z1SGsz?=
 =?utf-8?B?UGV4eDlORGNzSTA4QXBVeWM2R1laTjYwMTdkNkJRamJ4eUtSL2ErUDh0bzVB?=
 =?utf-8?B?QXVBVXc5VkR5dnM2N1laWFkvbHRxSkxyU3BNVmhoRThBbnd1RnVNeE9VSHZJ?=
 =?utf-8?B?ZHhTcnBDSjA3SHAwaWUrR3VibE9CaGE1dkZQd3JJRlNENWxXZDdMQmZReDZM?=
 =?utf-8?Q?vqUXzpUXrc8biIwUpKqvgkl9Z9e5BlWlYdVD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmJQd3hrWXl1am9Cam5QSThHOXYvQUVYekwvTy8wWStyMGxjMU5vVWRKOFhB?=
 =?utf-8?B?WjZUN0paNGNaM1hoN1g0bkNLRklqNTQzV01vb1c1Mzgvb014QnJQMmtwVmZB?=
 =?utf-8?B?cGlsK2tERWNMSUZKYkdZaWtFL0wyVWVQUVJSL2s5ZlpETXF0V3dNaVE3L2lN?=
 =?utf-8?B?NzJsSURQZjU3NjdkYms5dlpKMVh3MElhVUc0Y0RBTHVKK0lYQnRFZUozdnc5?=
 =?utf-8?B?cnUrQU05cFpyK0xYV1llYmJCWDZTUnljaStSYkg5NFFUaWVIQ2h2aVJwcnJm?=
 =?utf-8?B?OTBwSEJBd3N6RnhVbmJjVTZOU1BENVd6WUVwOWhJaDFZRjNpc09adzBpYkl5?=
 =?utf-8?B?MDBGMDBiQ21heHNyY0cwMVl6VCtpUGVTdjV0UklRa0tMVTJLdUNOc1lCNEN6?=
 =?utf-8?B?NklpbHFDTDh4cXNEbjE2cHUraUZmZHZ6bFZockJhY0NSVHBoc3BET2o2U1lX?=
 =?utf-8?B?SnhNVjF6MHlkZlEwYm9kWStTOWN4T05OUDdEM1V3U29IdlZ2QzZ6V3JhZEhT?=
 =?utf-8?B?U3ZFZ3E4MmZtUkZwelc0bitqZGpJZk1WeDd2UEFWZVgwbFJaeXU2THNvU2cx?=
 =?utf-8?B?Wnp2WEF3S2ZjTHZwRVdoUHFXVmxwZUpRbitQazFiSlhVYWw4allUMDNlTlZK?=
 =?utf-8?B?ZnU1a090YTVqNFl3bUpyMnMwaVR5cFNrMHNTZ2xUenVtcEtzcXNRaEQ4NDdx?=
 =?utf-8?B?Skdod2t4M0IwT1hyRG9DY2hlSkx3bFY2Y0k0d1VkVkFKclg1Mk9CYmFIYTB1?=
 =?utf-8?B?eldFVE5zTng1NHNCdTVrK2tOdkJPNEF5bFFRejdPeU02RXgrNThGb0tHem0y?=
 =?utf-8?B?NUdCVlhLQlpFMUhZQW1GVUpWS1BucndIaHNBQWF3SXAzdkEyV1AwODNoeVRQ?=
 =?utf-8?B?aVFqdzM3R3h2NzlYelJwSXBZaWp5YkFEZ1phSkNJK21mODdRWEpNdUpDV0dn?=
 =?utf-8?B?QjRENVpiY0tZRG9UaDdPT1hqZTZ0MFMvcDE1TXNDd21nSFdkWTBmT1FhZ3ov?=
 =?utf-8?B?Y3F0NlZuang3UUhqOXF5SG12M1haS0RWQk1velBMN1dOVHdRQ0JtSVU2M2Er?=
 =?utf-8?B?aURMMU5FZ3dsck92UzhXTW1pUDdoYVdZNTMzbHNQcDB3Vm15bDdIZVc0VXJs?=
 =?utf-8?B?QnhWSzJsUHYya0VsVkdiL3lDY0U2V3FwMTRYYXFOVVlGWmhaK3RCb0tCTXkr?=
 =?utf-8?B?WktHN3VlMWRUdE9EUDdOSS9iNjVoS3ZCbERkTG1IclhSYVg0Y3hwbkZzelF1?=
 =?utf-8?B?L0llVGJUbTk2dUk0ZjQydi9FbS9mSjN2b3VEcjlpT0liMWdmMVhlSkhxY0k3?=
 =?utf-8?B?NTltdWljbThvRFFON29UM3BxckN2NXZ5c3R0ODFnTExERzRmZVZCdGVqUktE?=
 =?utf-8?B?anVBUmpmM2lHclRPcnpYRjF0ZVY4UTB4Ykdwd0htVmV2Y0x2WC9Ic3czRTk5?=
 =?utf-8?B?R1JHempaOGN6eEdVeWFxTWVIdFBXNGg1VTNkZFoydE1zOHBhaXZsREJQSDJm?=
 =?utf-8?B?TmhDUG9DVk9CamE1RTlzbkE0dXRFMlhMaXJNTEJ5MFVVQ2kzZFFNUG5sdU4z?=
 =?utf-8?B?OVYxdUticUdEejJMMitYVkQvQUFYMVRtRk4zQVlSUVVBMWNXbml4Yk4xL2Iw?=
 =?utf-8?B?VzZ4Q3VJL0RscFUwWE9yc1g0N1F6RThKWWo4aStNTUdjMmhuQTd5bTlVeFVP?=
 =?utf-8?B?c29oSi8rVnI0VFRyZDN2YW9rWDFkVWNiZmVmbkRUWllVTnJYU012ZGNQVU1S?=
 =?utf-8?B?OFE1MmVLaWNLOVZkdGlTZHZ0VlZFNHV5ayswT21IUExjRHZKNkN5MDF3R1Nq?=
 =?utf-8?B?SWxtZFJMWmRnTGEwNnArZEhrN3dONHY2VkFzdkZqS2pGM1U0eTN4UjRhSFJR?=
 =?utf-8?B?SlRiMmNndnJvZCtscE5QM1RVUFpOYUVUckF3bXFoOENKRHo5MG9GRUYwUm12?=
 =?utf-8?B?SnZyNDFDQUdYN3FGNXdWTktURGZueEpCYUdTSi9kcWpkRWFqZlJGUTJGOFl2?=
 =?utf-8?B?WlZqN2IxRUNFbnpIaTZuV3E2RngvTUtRMTQ0cHFrc3ZBTFVTTWhQOExMMU5x?=
 =?utf-8?B?REhMV2ViV3hucm94UHk2WXBxMWQ2TWZlblVoZ0FjTVB5OWx1K3VrWkN4MnRs?=
 =?utf-8?Q?GnrxNgYPIFR1W2dupLbvblHPR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92647732-a3c6-4b81-aa0c-08dc8e77e0de
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 02:47:50.5511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Bt9hb0xOtiVzpGzwELgEA8LZ+XqZeTQnhDffdAEUkFw2U80Y/ucZG2GA/yPiXp4Txip+Nb3+izRhS/7ZQ425g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9482

From: Peng Fan <peng.fan@nxp.com>

Add a minimal dts for i.MX95 19x19 EVK board:
 - lpuart1 as console
 - sdhc1/2 as storage

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 200 ++++++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 1b1e4db02071..c3fef4e4d8dd 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -239,6 +239,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
new file mode 100644
index 000000000000..675abb70aa18
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -0,0 +1,200 @@
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
+			alloc-ranges = <0 0x80000000 0 0x7f000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VDD_SD2_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <12000>;
+	};
+};
+
+&lpuart1 {
+	/* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
+			IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX      0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e
+			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e
+			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x15fe
+			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x13fe
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x13fe
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x13fe
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x13fe
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x13fe
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x13fe
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x13fe
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x13fe
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x13fe
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x15fe
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e
+			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e
+			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x15fe
+			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x13fe
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
+		>;
+	};
+};

-- 
2.37.1


