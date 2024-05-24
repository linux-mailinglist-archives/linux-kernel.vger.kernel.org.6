Return-Path: <linux-kernel+bounces-188484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD98CE291
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF781C211B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB3129A7C;
	Fri, 24 May 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KzdTG+pA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B012A176;
	Fri, 24 May 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540507; cv=fail; b=rnKxMP04RgYUzywhOZ2S0sCukRf/v2hVjy+HGHv21NHngvYNGsy9ZDEtOeo1CLLjKuPjf6YAPTYVOR9UE8Yn68GITCGFcO3FVyP05e1cwe/B7blPiF42NxAd/+qk/+n4CiczMMzu2XeyEfbuN0tKCxr74t4VmvnRQ36Hysl2l8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540507; c=relaxed/simple;
	bh=MEud/jukDNDaiaakMQ+1r0kfKdmTqAFBAZV3mz01IPA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oAwX7RJ0nOaZzx/+HPHTsiroLUPtbQftZhqAFeaCtnMAPXM0E5zoBF/udBvNwLesaODgHZVLU0zCxwzK87rTxGcIlF9jwTyHMZvAIvteGvwkk+cSDfSqVf1KAYGiT0SaeE7vjVTsfQv1HC6IDygKJdrr1T/uL8lUCWh4SuZGero=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KzdTG+pA; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrHUW5zWNhIg/h0B4MKOeB9CNSF/qvyFkhoWOO6jJ7a0IkerP3KUUlkZmS/gymoB+3ut1Ti492wTfUihsrxxJ1K6Z9daL3KR/WnSPAVgHHkli20VH2TQgEl1KL26FON5BMMUlbsVzp0l6jpzVo2yljnjtPoCgKScocOlkPtf/ganzgG4FewU7Flp5VaRQJb2aMX/Tdg39jikJQ/aEb+aTPqcVlc3k7hNnJJ3rq6zpXm2b98UFsafDiWNwxuFns4jsWScOvYCSyJLfai9lXaSzLYw7QoOr9zUCmjxUAw3ei0G5kwQ9EsrUv/zr5Djp4im4yF1d7lKEcXf5a5FHwdtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPfFM7ZrUtBRpsaZ8VSlqrA7EfNXSeEdu6+Tokdv9sE=;
 b=V89WwUfg3Xg7gTfAXGr8gpWBZXTqU1hRvHAjHs9DMrq6POmcT6TLgWG4lhA2++nZm/7nFZbT3tVWzqgRQe1YuERppAypG1dHJppdhpA4d43yJeMiOxIUlFl2asm2ZsGN6HPut8tSjJ9jaERs2s1z5WzOh9l3Q8tLVSPrZgiAtGPqQtUuQwsV4Rwx9okA2gtX9rjai5LnV4Lny3CRVEXlKTIk7wAXIILKQ7kVNwPUMybN55N8lb1F1CM3U6O9mB9F8hAND8Ist7xoMBovBHB1AVXCD5nOKXW7eemvELKxmGKIuDhUcBAOxajvNTsadQ4XmYMrYDbkHOmu5OZa7m77uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPfFM7ZrUtBRpsaZ8VSlqrA7EfNXSeEdu6+Tokdv9sE=;
 b=KzdTG+pA+MYp/9IYZ7tR2rW917B9gMgSfXcACju5IIXlpTmNajMo5AJa5sjzkCBtZqwQHEfXn1Q1Nu7K5ScjlRSITqorrmZ1E6y+MpOHzLKkCQPp5j4AbcCXUvOawXbo1SLClfLuUpdXEVRVkdMwrsn8IZ5tqx8Y43CN+DEutvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7149.eurprd04.prod.outlook.com (2603:10a6:800:12e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:48:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:48:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 24 May 2024 16:56:46 +0800
Subject: [PATCH v4 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-imx95-bbm-misc-v2-v4-4-dc456995d590@nxp.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541024; l=11208;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=mW0EcuWJNi1Ev4S8xK4NKzhmyrrY3JZf9et/+B66yzk=;
 b=wJI9m9wiFMtXnsAD5ZHpVEDhFarIMTV/mwG4r0/YkRUnJnitjRdohxbotxrLX9OYEfuYRI3gw
 gbRsWlNHZNdAFArv9KPS8M+mjCKgP231nmcwNN256wYKlMvv134L+Kk
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 831be702-e657-496a-3cd7-08dc7bce4285
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|7416005|52116005|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk5zREVPV3hPZHpGSVV0YWZGc0hudndxdFM0Ni8yUlJHaXYyN1dIaXRrNXZH?=
 =?utf-8?B?cjRuVTVma2tMK0J4UXc4a0FsR0N4bmxhRlBVMVc3eTlnME9DUmdFOXdhZzhY?=
 =?utf-8?B?QnJ6U0tnUjB0Rkt3U002OHMvVGQxZExXb1MwNHNyUDhCcjFGUFBIYS9SaThV?=
 =?utf-8?B?aTY4YkpySFg0WXBiVUhPcmtUdmU0c3RnMkJZbWFnY1RFWHNFSUVkbE5lZFk0?=
 =?utf-8?B?MjRQamJWSFVJRzZLMHR3VU0vdW8rSFFmS3NBa2RzSlJjQy9WYmp2M21vVDhV?=
 =?utf-8?B?ZDBFTG1jRW84ODBZQy9QY2RCYktMWlorMFhJeTE2Q3VrVWNmdDl1MUFxOExZ?=
 =?utf-8?B?MUlzZTFMZ3c4dWlETnNYSTVET0lZNC9tck4wL2dKQW9ySXZOS096OWZDa0ti?=
 =?utf-8?B?aVFJMk9IRmpwbTBIcjFQVVFmVHBxLzdna2lVTENBWFlUMmg0UE1lNXZnT0Ey?=
 =?utf-8?B?UXRDQUhIVEF0UG5WWnNnVWRKOU5SUDBpUkJHa2Zib2xCNUR0eGxPYVpTazQ2?=
 =?utf-8?B?WHVUSXpRRUdRVG1hOWlQbjdic1FNamJvYXZwUTF4QU1jdzY0a3FOcDRQMmlC?=
 =?utf-8?B?blVFRVRwdWF3a0dNaXZzaFFJNUgwYytiam51Q3BkRkJZS0U2a2JFMUowTU1v?=
 =?utf-8?B?KzFGZCsvWGxLZHZpZWQzaDMrenlTSDZDaWNYcFV6OFNoODRyWDd6MUc2alJa?=
 =?utf-8?B?b1RLeEFjWDJxSXBvd1RpeVRQd2VqTkpnSUpWTGFKcmNOWVhYRk9UbDh3eFg0?=
 =?utf-8?B?cllpY0xPK2I5Q1UvZWNicXpEcTN1L1lweEFDL24xY3RacDM3QitZYzMzUVgw?=
 =?utf-8?B?L1huQ1RpdnZ6SFhLa3VwenRCOVAyWFhtbk4waG9SSitpUjJZcWRqWDdrWEpq?=
 =?utf-8?B?a01tcTlhd2JxNlN1MUwvRlJCd0pkRTdYajE1Q2pqVEVqZE5KRFpFY1VFMTk4?=
 =?utf-8?B?bVBUTUdiSVNlbWw4Q2srSkx4b1pkS3NXNS9IcnlQcG1RVm1LZTVBeGlBZ3lG?=
 =?utf-8?B?akdXeDNVbW9OUEhUaEpCMTFoSXVsQ2wzbG9XMVU5QVQ2ZE9qRVlzbnk1bTN6?=
 =?utf-8?B?cnhoNzJFZ0dWUElWb1Bvd1ZZRW55QmpES2xrdXoxclhFdVJDZk1pSGVCOHpN?=
 =?utf-8?B?TDlHWUVNL05uV1h5V1NaQnRuSHJkSndxdXY4WWxadnovZlphYWdZNXZlWFcz?=
 =?utf-8?B?L2VFR2VPYXhERVpabUc5dzFvTnByZmd3bXBlM0VXOTJFbVRPNng0ZS94c2Zp?=
 =?utf-8?B?OGRYaGJzc3QvMkVaS0RSU3BaU0kxRFBTSXpwZkxwTndEQVZIRVdaSEN4b0pT?=
 =?utf-8?B?THduVm13OWo2UW94STIxeDc5d0pDWHRRa1R0RzRubitMTHZKMlYvcFIydWtH?=
 =?utf-8?B?TllnYWtkUVZSQlpNb3I4SjF0MU93WWxEZk9QNnZHblQ2Z21xTmNBcnBrWVBv?=
 =?utf-8?B?cTFNKzZINi94Z3IzbDdjeXNUNzN5aEcrQW1Ua2VFSU1Qb05Qckw4eVRJSU91?=
 =?utf-8?B?eWEreDJLYXZVbnZkT3E0QzdSWTEyN3BPYWJKZHZzbG9QOFQxNW5KYld4MnNB?=
 =?utf-8?B?VDgwT2RXUmtWRjkwZlV2am5qLy80SHpOQTdIUm9qbXQzVjJmTGVNZ1dGeWVH?=
 =?utf-8?B?Q2xJZ3ZReFZna01iRW9QUHNHeE1IQll1QW9xVXRjSjVlWDYwZTNYRkVQbWtw?=
 =?utf-8?B?d2pFdjFyS0lVNU1zS2tDRG5wU3YyNG5JdGU4dkROd2tNOHJkcVFEUldlUEpL?=
 =?utf-8?B?WFE2TUxGU1BwdDVWZURIekplYUtMd1BmZHNpcnEyT3E4bVlwbkhSdnFKM0Vv?=
 =?utf-8?Q?PlPBylfxhV1w4VV1QAtrkWXWGBBXp+v1335eo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RStaNkpNN0c4M0tVMzNqMEJKUXlSckVnZFMxcHh1QThucVRVRElseEdIb0Vz?=
 =?utf-8?B?aWpHaXl0Y09rSllRWDhyQk1hZWU0RXRrQTBGN1huRW9hODRVN3RiNnBUUW8x?=
 =?utf-8?B?RXBQTitVT3NJc3YweWN5V2pXNkYwRWQzTjhkdWtUMVU2M1JsdE5Ma1dUMjhM?=
 =?utf-8?B?TUdvN1lyMFk4YmUyOXN4UUVITmdyQzkzRUQ2ak5ZVE9qU0ZqdUF4bFo2Rmha?=
 =?utf-8?B?U2FrbXZnVy9mQVI2TUpKWWlBMGE3UFBjRnllMGtJQ3dLQjFsRUgyWmNvZlJl?=
 =?utf-8?B?V2hNMkZRN2JQLzFDbTAxWUErT0pFOVpicThPOEFXVVhuWEdZaUkzMXhsTHl6?=
 =?utf-8?B?cmlqemJFV1FWR1UvNFh2TDFwVmxtdHJjS3lPb2JkMlVXUzBCVEgrUmZLSldz?=
 =?utf-8?B?d3haQ0xjQmxWS0xCbW1NYVI4SHlmZUdHUmpmMGNkQnkrbFkxYjZyRmpGay9B?=
 =?utf-8?B?Skl5YlNBRURZc200OGd3Y3Y2dTNmT2NnbUkzWldwZ2c2YlVoZWZsQW9nZDN2?=
 =?utf-8?B?dG9mbDlZcjkrYUhWcE9OZkVIRWdLM204d0d2ME5Ba29qTUZmR1IyRTVGSENK?=
 =?utf-8?B?UnUrVnZzaGhjdnF6M3UyZGtoV2F1Z2NoQmpuSXNPdFNEL1FjRHdJNWRzN0p2?=
 =?utf-8?B?SmVINTcrSEI1RG0wcVhZVk05UTRxQ3Y1dDU2bkhKb284SGVGaFZvQ2ltTUY5?=
 =?utf-8?B?N3VkTkpic1h4RkNkaG1DK2Rnd3VGMjc0VHFoVXZlWmRGeTdXWnRVTmRYK2wy?=
 =?utf-8?B?UnYxd01SdDVnelpJa0RFZkxwS2p1ZVZOek5vb1ZoSWxDeFJ0RUVXV0x0dkh0?=
 =?utf-8?B?T3dsWnlnQXl0dlJaR2JyR2QvZ21kN25PaWxRaFIzNDFiNGUxcFM4ajZRWEor?=
 =?utf-8?B?dXhUV0EvUTFKZSs4Ynd5US9jYXduTGFETlRFUTVyaDUrSjRuSW1OSjdkOE5L?=
 =?utf-8?B?N0ZPMTNDT0dQNmp1eW93bzdUTGU1OU5vY3htSnhEV2J5SzgrcUVnZU5TbVRv?=
 =?utf-8?B?bG5KZWduVkR1Y3hJZGRYc2RpNmIySXVWVEZVNEx4RXpLWXJwUTlTaG9MQnAw?=
 =?utf-8?B?Y0ZUdmQzUmRYczAwbU9tMDNadmZ4ZmV1UDUwY3RSZERxTlJIZUJIQzBoZUpt?=
 =?utf-8?B?N2lMMVg0Y3dFQ1p1SUN2dk1KYkVldHBrKzR0VkgzdXMwWlI4cDlaRFN0OWxN?=
 =?utf-8?B?RHltRDA0MjJGbndqT0JYeng0c0drVlZjMGNRRVRkSE95SVIzakY5anRqOEl0?=
 =?utf-8?B?a08veVBYcnc1RFRUZXprQkd1SjhnMzlMQ3ZGNVE0ZzZLMGx4dVprVmxQcDZ0?=
 =?utf-8?B?K2UrbFFRelJMVnFKT05yNWRUc2MyREhta2JTYVdMdEZvblp4dVhJdkplZVdo?=
 =?utf-8?B?WHZ1Tk9YK2RZb2I2czdhb0RENmE4Wk5pZnhEQW1TdENzanJHK0ZaaEZ4Vmlj?=
 =?utf-8?B?Q0pWaWc2WlkvMDJUNjRJelNuWU1BbTRZR3NkUVhBNW5tRGlqUmxDVEFmL0Jv?=
 =?utf-8?B?eDBRVk8yUGlTalBjc1l3TEx5c0FrVGtJWmM0N3pBZktQZ3dxOXBTb3FkUGJr?=
 =?utf-8?B?Nm16a1BHQWRseEJNbGhZVUFHdFJRVDZXcm43a2ZVZE5GeUdHV3BFRzBJYzE2?=
 =?utf-8?B?eGFqaDAzcGN3UkVFR294UkpGN1QxcGhRMGdveUhZNUJnRW9qdTBuRStDWVJ5?=
 =?utf-8?B?ckhzNG5uT1lYRzY0VGEyTXJPbkNiWW55L2cyWS81clpTNTVodGUwSyt0Z0Vk?=
 =?utf-8?B?aDBOTWtITUJ5czc1N1IvL1QzeVhiVU5hN1l0aWo3ZkJuM0hDYmVBbjk3NERG?=
 =?utf-8?B?ZzB3UzhTVzVvckVQNjZ3eG9Meko4a0RjRmZYakFxYzhOS3hEREhEZ2pScThU?=
 =?utf-8?B?MTBSeWhyQUpwbDd4eFVXSnEvR2VnM2dBYTQxLzlUSi9OamZ5R3hTK3hONDhJ?=
 =?utf-8?B?RG5DU0YzNWJaeHd3SGFnVklHUHZXN2xnN3FxS1o5cTUzYTBYQmVOYkFzSDhD?=
 =?utf-8?B?T3dVSjNaSWNyL21oU0t2RVJ0NWtxa3ZZYjBtd29VcnhJeXlDdm9veWF6YytE?=
 =?utf-8?B?cnNhNGpQOHhKU3BuWjRvbmI3S0hUdEhscld2UlhQcVF4QUZhR0ZsaysvcCtq?=
 =?utf-8?Q?2kNGBPcCUpT3QtNL8W2KnAUmF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831be702-e657-496a-3cd7-08dc7bce4285
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:48:18.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuFi7CmE+p2/phoJpzPtat328gv+T0F4PJP3bt+ZdeVKEQkAwak8+7J9ulpqEC0E7Gl2Mf8k/SH0O0810nSSFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7149

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager(SM) firmware includes a SCMI vendor protocol, SCMI
MISC protocol which includes controls that are misc settings/actions that
must be exposed from the SM to agents. They are device specific and are
usually define to access bit fields in various mix block control modules,
IOMUX_GPR, and other General Purpose registers, Control Status Registers
owned by the SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/imx/Kconfig       |   9 +
 drivers/firmware/arm_scmi/imx/Makefile      |   1 +
 drivers/firmware/arm_scmi/imx/imx-sm-misc.c | 303 ++++++++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h           |  22 ++
 4 files changed, 335 insertions(+)

diff --git a/drivers/firmware/arm_scmi/imx/Kconfig b/drivers/firmware/arm_scmi/imx/Kconfig
index 4b6ac7febe8f..e9d015859eaa 100644
--- a/drivers/firmware/arm_scmi/imx/Kconfig
+++ b/drivers/firmware/arm_scmi/imx/Kconfig
@@ -11,4 +11,13 @@ config IMX_SCMI_BBM_EXT
 
 	  This driver can also be built as a module.
 
+config IMX_SCMI_MISC_EXT
+	tristate "i.MX SCMI MISC EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System MISC control logic such as gpio expander
+	  wakeup
+
+	  This driver can also be built as a module.
 endmenu
diff --git a/drivers/firmware/arm_scmi/imx/Makefile b/drivers/firmware/arm_scmi/imx/Makefile
index a7dbdd20dbb9..d3ee6d544924 100644
--- a/drivers/firmware/arm_scmi/imx/Makefile
+++ b/drivers/firmware/arm_scmi/imx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
+obj-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
diff --git a/drivers/firmware/arm_scmi/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/imx/imx-sm-misc.c
new file mode 100644
index 000000000000..9d0063299310
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx/imx-sm-misc.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System control and Management Interface (SCMI) NXP MISC Protocol
+ *
+ * Copyright 2024 NXP
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "../protocols.h"
+#include "../notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_misc_protocol_cmd {
+	SCMI_IMX_MISC_CTRL_SET	= 0x3,
+	SCMI_IMX_MISC_CTRL_GET	= 0x4,
+	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
+};
+
+struct scmi_imx_misc_info {
+	u32 version;
+	u32 nr_dev_ctrl;
+	u32 nr_brd_ctrl;
+	u32 nr_reason;
+};
+
+struct scmi_msg_imx_misc_protocol_attributes {
+	__le32 attributes;
+};
+
+#define GET_BRD_CTRLS_NR(x)	le32_get_bits((x), GENMASK(31, 24))
+#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
+#define GET_DEV_CTRLS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+#define BRD_CTRL_START_ID	BIT(15)
+
+struct scmi_imx_misc_ctrl_set_in {
+	__le32 id;
+	__le32 num;
+	__le32 value[MISC_MAX_VAL];
+};
+
+struct scmi_imx_misc_ctrl_notify_in {
+	__le32 ctrl_id;
+	__le32 flags;
+};
+
+struct scmi_imx_misc_ctrl_notify_payld {
+	__le32 ctrl_id;
+	__le32 flags;
+};
+
+struct scmi_imx_misc_ctrl_get_out {
+	__le32 num;
+	__le32 val[MISC_MAX_VAL];
+};
+
+static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
+					struct scmi_imx_misc_info *mi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_misc_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		mi->nr_dev_ctrl = GET_DEV_CTRLS_NR(attr->attributes);
+		mi->nr_brd_ctrl = GET_BRD_CTRLS_NR(attr->attributes);
+		mi->nr_reason = GET_REASONS_NR(attr->attributes);
+		dev_info(ph->dev, "i.MX MISC NUM DEV CTRL: %d, NUM BRD CTRL: %d,NUM Reason: %d\n",
+			 mi->nr_dev_ctrl, mi->nr_brd_ctrl, mi->nr_reason);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_validate_id(const struct scmi_protocol_handle *ph,
+					  u32 ctrl_id)
+{
+	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
+
+	if ((ctrl_id < BRD_CTRL_START_ID) && (ctrl_id > mi->nr_dev_ctrl))
+		return -EINVAL;
+	if (ctrl_id >= BRD_CTRL_START_ID + mi->nr_brd_ctrl)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_imx_misc_ctrl_notify(const struct scmi_protocol_handle *ph,
+				     u32 ctrl_id, u32 evt_id, u32 flags)
+{
+	struct scmi_imx_misc_ctrl_notify_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
+				      sizeof(*in), 0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->ctrl_id = cpu_to_le32(ctrl_id);
+	in->flags = cpu_to_le32(flags);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int
+scmi_imx_misc_ctrl_set_notify_enabled(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	/* misc_ctrl_req_notify is for enablement */
+	if (enable)
+		return 0;
+
+	ret = scmi_imx_misc_ctrl_notify(ph, src_id, evt_id, 0);
+	if (ret)
+		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] - ret:%d\n",
+			evt_id, src_id, ret);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_get_num_sources(const struct scmi_protocol_handle *ph)
+{
+	return GENMASK(15, 0);
+}
+
+static void *
+scmi_imx_misc_ctrl_fill_custom_report(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, ktime_t timestamp,
+				      const void *payld, size_t payld_sz,
+				      void *report, u32 *src_id)
+{
+	const struct scmi_imx_misc_ctrl_notify_payld *p = payld;
+	struct scmi_imx_misc_ctrl_notify_report *r = report;
+
+	if (sizeof(*p) != payld_sz)
+		return NULL;
+
+	r->timestamp = timestamp;
+	r->ctrl_id = p->ctrl_id;
+	r->flags = p->flags;
+	if (src_id)
+		*src_id = r->ctrl_id;
+	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__,
+		r->ctrl_id, r->flags);
+
+	return r;
+}
+
+static const struct scmi_event_ops scmi_imx_misc_event_ops = {
+	.get_num_sources = scmi_imx_misc_ctrl_get_num_sources,
+	.set_notify_enabled = scmi_imx_misc_ctrl_set_notify_enabled,
+	.fill_custom_report = scmi_imx_misc_ctrl_fill_custom_report,
+};
+
+static const struct scmi_event scmi_imx_misc_events[] = {
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	},
+};
+
+static struct scmi_protocol_events scmi_imx_misc_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &scmi_imx_misc_event_ops,
+	.evts = scmi_imx_misc_events,
+	.num_events = ARRAY_SIZE(scmi_imx_misc_events),
+};
+
+static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_info *minfo;
+	u32 version;
+	int ret;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	minfo = devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
+	if (!minfo)
+		return -ENOMEM;
+
+	ret = scmi_imx_misc_attributes_get(ph, minfo);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, minfo, version);
+}
+
+static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle *ph,
+				  u32 ctrl_id, u32 *num, u32 *val)
+{
+	struct scmi_imx_misc_ctrl_get_out *out;
+	struct scmi_xfer *t;
+	int ret, i;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(ctrl_id, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		*num = le32_to_cpu(out->num);
+		for (i = 0; i < *num && i < MISC_MAX_VAL; i++)
+			val[i] = le32_to_cpu(out->val[i]);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
+				  u32 ctrl_id, u32 num, u32 *val)
+{
+	struct scmi_imx_misc_ctrl_set_in *in;
+	struct scmi_xfer *t;
+	int ret, i;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	if (num > MISC_MAX_VAL)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->id = cpu_to_le32(ctrl_id);
+	in->num = cpu_to_le32(num);
+	for (i = 0; i < num; i++)
+		in->value[i] = cpu_to_le32(val[i]);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
+	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
+	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
+	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
+};
+
+static const struct scmi_protocol scmi_imx_misc = {
+	.id = SCMI_PROTOCOL_IMX_MISC,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_misc_protocol_init,
+	.ops = &scmi_imx_misc_proto_ops,
+	.events = &scmi_imx_misc_protocol_events,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+	.vendor_id = "NXP",
+	.sub_vendor_id = "i.MX95 EVK",
+};
+module_scmi_protocol(scmi_imx_misc);
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index e59aedaa4aec..e9285abfc191 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -13,8 +13,14 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
+#define SCMI_PAYLOAD_LEN	100
+
+#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
+#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
+
 enum scmi_nxp_protocol {
 	SCMI_PROTOCOL_IMX_BBM = 0x81,
+	SCMI_PROTOCOL_IMX_MISC = 0x84,
 };
 
 struct scmi_imx_bbm_proto_ops {
@@ -30,6 +36,7 @@ struct scmi_imx_bbm_proto_ops {
 enum scmi_nxp_notification_events {
 	SCMI_EVENT_IMX_BBM_RTC = 0x0,
 	SCMI_EVENT_IMX_BBM_BUTTON = 0x1,
+	SCMI_EVENT_IMX_MISC_CONTROL = 0x0,
 };
 
 struct scmi_imx_bbm_notif_report {
@@ -39,4 +46,19 @@ struct scmi_imx_bbm_notif_report {
 	unsigned int		rtc_id;
 	unsigned int		rtc_evt;
 };
+
+struct scmi_imx_misc_ctrl_notify_report {
+	ktime_t			timestamp;
+	unsigned int		ctrl_id;
+	unsigned int		flags;
+};
+
+struct scmi_imx_misc_proto_ops {
+	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id,
+			     u32 num, u32 *val);
+	int (*misc_ctrl_get)(const struct scmi_protocol_handle *ph, u32 id,
+			     u32 *num, u32 *val);
+	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
+				    u32 ctrl_id, u32 evt_id, u32 flags);
+};
 #endif

-- 
2.37.1


