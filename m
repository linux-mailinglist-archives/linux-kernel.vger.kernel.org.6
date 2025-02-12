Return-Path: <linux-kernel+bounces-510661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCB1A3201C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB671888EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625112046AF;
	Wed, 12 Feb 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n/6mClhR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A59204694;
	Wed, 12 Feb 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346093; cv=fail; b=iuF0OtjE+DWOlThXAXfDyIwpF4yTtDXykUiwzp1Nf37GP+CHOoccm2OhFF4LMpUH3v6hJKV3PmnhxMvwlvbmQF7EWeg1cLrA0XgjLP9rTW3ecV3RW/sOXWa2fPFFVV4yH24CIUx5NAWq8V2Pd0uawsBaEBKxWqMfXKklyUUZiJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346093; c=relaxed/simple;
	bh=JAX+K1gJmkbIUF8y8Aq9c3HQ9mg9JAmApPAIWDOvx64=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lZdOlXZTTXHzHEcXE081+xsCZvfOaUvU4K2zapLxDbMMI4a2NoFZE/sDht0jkSz/6oNoPv6rEalwLgS9SGVbwyfBKRwz1epmNI3ARHMpRTdT8aZDbjSKcGJq6O2JOCHFT3d8E4A+4QKf9BTs4ixAe9wChnuf/VwS7HozTajW4X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=n/6mClhR; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4lm9ANlUbTkFtZfH3KY3MZJPLxg2/zATHhsMeCHh05vSbtp+nwVrJe1TkXNZkyO5gAtnNGOhlooCjNCliIf7v5YXE0l/2ETSCY46azX4x2xsTP4eTkCZBMSTj58BWONYx8p8fEXHDImbkR0GMQjt+kpnSH+nNRnGFV3zJykB+K3LLU+XoyVs6HGTLaM3L4EJmc3Io0+keA16gyUYf9wGwa5lckFl4e1+KpwzFduufsmhT36wftbZMdbGLd819WgSSu/ZT3Wb0oq/n4NyZ2PT3w4gxE1hPlXQRzBvG7+drKX5YORIgqgcm1z4NtdbrsThHx8bDKp0WmJzHveAH6Aag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCeOWA9UN/RDDhAp+34wqyPk+qOXDn/GjVSVBkqyfjc=;
 b=tsKWrBOypanvNuVgV2lgDMaiSHfWvQ+3o/NZ4Qt1S975vgAUpz/zavYqM4ziIdM68AksrGzRNAMDIsY1SwL+SD+OQxzQj1AKYlJ5RPyz9c58k8zZEaSnlDSDoJdFJC4aVRxS6gnYpsZkoDH+5vzFeUbyQpsHWBLnO0/xxQ/24LPUNMmRUpffPgHTXkwLIKEtiX9LPQflNJFqlQMCRS/5Loifm2JFRoOimrFUDbxAr0saoUjHoRa4u1hqsn7T3ymcAGVxY3vvcSZRp5YTLIc18sw8YBeUsNkKR6Ge3WF4dtrQixkpiEsxJSNfo8EEf2E1LFsi4d0wna66m07nUCPudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCeOWA9UN/RDDhAp+34wqyPk+qOXDn/GjVSVBkqyfjc=;
 b=n/6mClhREGN9A0+XvbpAAlp5sRic3GTmppca7sn3kJl2H5qeCMBzKOOzTdcPPY96VvHhVpo5qJIeCMVpdON7tr+S6aUf0M/uQh92L7YjdoAa7LsF6tiF2WM1nb61QevD/2hVgvHYQpXnJ/Ix65YBaHYsgpDYOCAMs2CYA4q1LyR0gaQp8tbt8bNhlgzOc2la8ycKsRS5+7IfjKEaOz6Omvd/Y3p4zdsmIW+FjmsOlZQG0AJZ36VRxEcSmuispYgG8TVP08i+qYzHOXJ9/Kq79oAnWqPQgZh4tmQ/W+7KdAprjlSDEUeveMX6LEKti5Dd2PQjQ0EQRpjZrqwQV1W1Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 07:41:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 07:41:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 12 Feb 2025 15:40:24 +0800
Subject: [PATCH v2 2/7] dt-bindings: firmware: Add i.MX95 SCMI LMM and CPU
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-imx-lmm-cpu-v2-2-3aee005968c1@nxp.com>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
In-Reply-To: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346036; l=1729;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1ThZFhQdOmfZO/coVtUZEj/sQTi7Nxb7EXJHWilriCM=;
 b=HpJ22rh4ZipXRqo2mJhm8qeO26ZwWdMZ5tegvfHuorl25nXEv3Ny+TiQrD3JkrRs8t8kvseoH
 CwM/AETMLtqA9SG2U9blqfRVEcPTVqntYQQbRgKC9cgXKDnkcTyquh/
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bff43ab-910f-4719-74c6-08dd4b38a95e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHlwUk1Hdjc5OGNMejAvNUdseFVHcUJmMEFWanRyM1ZzNjFkMWtCWHF6Z3BE?=
 =?utf-8?B?eS9HZ3UrMS9wcGpLaGd1cCtodEE2d3JkbEQrc0FGTDJ1ODBDaXR0RWNrRkwv?=
 =?utf-8?B?dzM3Y0ZzcU0zK3NtR3N2OVUzZVIxWTVGM3d3L1c5QnNtZkNGSEtNdXZtRms5?=
 =?utf-8?B?QklBRFdNNWY4TkVoWVNNZkJLMThpQzUxUGN0bG50eitBQlBOZEptOWhhZWJO?=
 =?utf-8?B?SFVyZU5HRko4clNMSHFiajljekJGWFh5OXkxTmZraGc3bENXMWNUSXFhR2V0?=
 =?utf-8?B?UUVCcnlKRG81VGNEbHJRS3VNMVBFL0NNV3JwcGlVL3dCNnhST1dFdC90QWhL?=
 =?utf-8?B?UlBVZ3Vub29raE9LbCtpRlFSRngvUXRtL0hnQkhFM1dDNVgvaDFNN2hsSVNG?=
 =?utf-8?B?TmNlWUNXL3hlOHRxcWVYK3hGYkVkU3FkQTJoYy9EbkpCclRxZHB5L2FLV1Vj?=
 =?utf-8?B?Y1dqMHlkM2lGb0xlRFA1a3hEN2VaZ1gwbkVxenBSQlRFNk90eEpld285eGl4?=
 =?utf-8?B?RjV5U21GKzNjL2NhT1FqMVI1NmxMeFR1eXNrbDhnYUZ3RlRGWUFFVERwYjZj?=
 =?utf-8?B?QVF2WXFyMW9WZXl1WGl2TlVJYTQ4QTdMbTdsR3JhUUJUc3BJNUlDVlhlWmRY?=
 =?utf-8?B?LzAyRm9LNXU0VGhCenVSajVWQVN5NDF3RFZYUEJYeFVOdTBPSUM3ejJJMXJk?=
 =?utf-8?B?Y0FBT1A3SU95MDdyaGtKT0I3ajFjWG1iUlAySDFOUDRkaXZiSmVXc3ZqRmQr?=
 =?utf-8?B?RFB0Tm9jWEM0VEpScy9tdGNja3o4dGc0N2dZSEZhZ092dVF3cDBCUzhzVFNy?=
 =?utf-8?B?REVOdk4vZlQ5cDVjeXZuK2pya3dremFTRjZ2Sm9VZEoyUGJtK2QvS0d2THNj?=
 =?utf-8?B?Rm05UlNuaXZWSm5rNWxlbXFPR2VhQ3VEOXAvQURrN3RuWDJCZHkydWc2aFQ2?=
 =?utf-8?B?aFBhV3Rpc0cyWHBFay83MWRUWXFYaGd5c2RUN0doYlFRTlhXdnNNMjgvRXZz?=
 =?utf-8?B?UHB5ZmhpWm9LQ1RNOW4vQnA3aFNJOWwyMjFwNlAzRjFqZk1ORForWlNYczBE?=
 =?utf-8?B?R1R1ejN3djVyVHRUOWNITWxkNHFsTEh5NkVMSTYvVno3NEpDM3JTbWhLY3pL?=
 =?utf-8?B?L25Kc2VuSWZhb1dLemhMazlKM1NxdWxUeGRJL3A5cVhvRXFMZEJCZEJDL1l6?=
 =?utf-8?B?WWNxc0YyOUowNlVjM1lXcWlueGxIUk0wdmhhcGpYS2cwTUVtZ1dEbHk2Um1i?=
 =?utf-8?B?VnN3VGp0Y01RZVd3WDdDL1l4ZnBTUVdxWjNBeFl1aUFFTW55Q1Aydy8vLy9S?=
 =?utf-8?B?Q056bU1hbTlrV2RRQy9TOWdvd0tZbkxkQmVNcFpzZWY1RmhMMW4xaWIrdm9Z?=
 =?utf-8?B?VVNkV0hUZldFdkxuNEppbXcxTzFmK2txM3dhdGh2dFJxelJyOUNNNnZ5N0lp?=
 =?utf-8?B?NFQ3aC9YdDBWOVkxSjF2dzUzUmxTeUJSUFpiODhKeWcyWWZOT0VtRVFjcHJU?=
 =?utf-8?B?N2xhZFBrbUpQRjJ5Ujl2MXpObmgrd1JWRzdYeGJtdTBYd1g3K3NpUjYyQXps?=
 =?utf-8?B?Z2xlMEJyMWw4Rk5CVTl6bVVqYnpSV0pMR0dYR1FOVlF2QjlCN1Rmb1R2alIw?=
 =?utf-8?B?SlhZa2tVTGQ5ZGlYUndxMGt1VUtyYTBJbVFTUGo2M3h4T0RNa2wwNFFWUFlE?=
 =?utf-8?B?dGNKM0NIaSsxemtUMWpRWGFERU8xR2dJaDhzazJBZTE4bm8zN3IzcEJwMWwy?=
 =?utf-8?B?TWdaaHhzOGdmVEprSXF4MmJ2RXJ0dFV1dGJmM3JMWWdsQnUrenFaZXJpSHFu?=
 =?utf-8?B?QU9RM0QwWjRBRnBqT2xVVk9GenFMVEJoTytiZmNnMXVDeXZic1ZRblJzR3Z1?=
 =?utf-8?B?TTRDb3VpdU04bkpzekxLTXlkSWp2TGJwdzBSWHh6N3lSOS9HQW1pcWVWTlhP?=
 =?utf-8?Q?5RSI69fgX0UrImw6FXGHQg1RFfzxSnPP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkhlUEdSbE5LRXk3RnhJSUdUR3ZzYS9wL3V0YnBWeTNCaW9FSDBtNUxwd0VS?=
 =?utf-8?B?TStONkFnUnMraUxWUmhRdE1nL2JvUDQwVk5obWlnTUhYUlB5UEY4Sy9maTRm?=
 =?utf-8?B?dDBKNUtDLzZNZFl2Z2dIK29EVmFlcXQ5MWI2WjVNMlgzNmpNWTdrc3lXYzNo?=
 =?utf-8?B?REJwYkxJcWdmSkRNQWxScWxYMUZmSWFORDJlY0QzSmlDd1JJZStBb25HTVA2?=
 =?utf-8?B?Mmw0Z0t1SStrWjBrNkVvWExUZTdUSkFxanlMd1FBYmVCM3pWL0Y3MWZlWTVp?=
 =?utf-8?B?cTk5eUEzajEvcDNsUUhZSlJBY083VElLU1ZsWTBQOEg5bXMyNFZiYllpSWlr?=
 =?utf-8?B?WWJ6djBlUDJGcTlWMzlGTGU2bXNWWmpMWTlzVVluYnZNWnU0eEIyZUVEa1BC?=
 =?utf-8?B?N0FScnRMNGgwMDFPdm4zODNGWVIrRTJ4b1lpRUVEeDQzSTVvenhlMzAyNUZh?=
 =?utf-8?B?M1BEOThRKzJoWTBMUXV2SXdQK2FoT1Z5d0RaM2hqdmc2alcrZzNWc1Nvd1Fn?=
 =?utf-8?B?UjZWZU9xRHlFR0hiaWs2dEVXUE1vL082akZHQmJvQ00yRWNRdkhVY2hZd3Az?=
 =?utf-8?B?NTZvQVA0NHpKeWd6dHM2Y2U2SkQzaUorSUkzbjNidm4zZFZXS0NwWWg2MXJz?=
 =?utf-8?B?TVpGRHZORU9seFpCanlJVFJhdTFDVEcrWUZrNmdBK3ZWRi9sVzZjSzFSK1Mz?=
 =?utf-8?B?RnhyTllncm0rV2t0QlcrYUcrNEFoYmk3c3NUeHd2a1FCYitweWJFZHFQZmtO?=
 =?utf-8?B?a2lEZWh3MG50TkF3eXlTeGFPN2JxVkFrcGtJV1p0Qmh6S1l0cHVURlhjK1RU?=
 =?utf-8?B?QWJmZ1VmMGV0bDVoaUMzdzdGM3ZYZUZIWlN3ek1qc3NMOEFVSiticWlxT0wz?=
 =?utf-8?B?aUpqVEZEUXpjcGYwaFo3V3E4SmtjWldWVGJjbHFxU1FYS0F1RGVwNU1Ick1v?=
 =?utf-8?B?VzJRK2tGUmlrUGVESTN4Wjc2dWZ0ODZuSGQ0bGFCcXY3QlFxRUtIc0Irck93?=
 =?utf-8?B?U2lENTRRbzhaV2Ixa0dwbzJSMWV1YzJDcWpTdldKOEFnd3Ewend5aFJmcUJ6?=
 =?utf-8?B?SWJTSlRSQVpQTkMyN0NYa2tVaUFNOGhMeEhQRk05UkRQZlpPeS9pY0JsRHhB?=
 =?utf-8?B?MDR2MWZ3QkJ3M3htY05Gd2lYQm9weDJEK0tSU1RycFJaWkwrV3g2ay9qeEl4?=
 =?utf-8?B?KzY3dk1uNW9TNlVFU1ZkQnNEV3pvU0xrTXhIckd0QjhqNW9RVDV1TUZCcXFk?=
 =?utf-8?B?NUJiOUgwTndEbVgrUEgzK0pBNjNKK0szckVkcG1RQStpZFFScDlyQWJMOXFT?=
 =?utf-8?B?T0tHNCsyY0ZSeDZKTnlyTWh2WEVQY2VYU2lNc3VBNFNpdUZXVHdpQkZGT0hO?=
 =?utf-8?B?aC80RWdZelcxMnR2UU03azZScUVmanZKUDFNOHNCZG1wYTZSdXZXNE9mdWVw?=
 =?utf-8?B?dmVTNVhLOTF1SnhwUjlLTktOQ2tkNlNuTThlbEZBWG9KaWp4cW4yazlIeXBI?=
 =?utf-8?B?SmhmNDF4MVNIUFpnOGNBTmRkSlBOdlBkaVlCN2NqdHdBblRrQWhGUi9vSUJL?=
 =?utf-8?B?VDQrdXJSYXcrM2JOYVp1RDhtU0xXaHM0eU54WGdMbmdrNy8zVHBicmlXVWdI?=
 =?utf-8?B?c2JvUHowRGFqeHVaaUNLS0xMYVRENy91OWJhUFUzeTg2TjNKVTZrR292cnhL?=
 =?utf-8?B?NG9NYTdsYVRYS1BnRkJ6NzNQendRbTZnN01seWNOTU1hUUNFSi9nNUhXSTJR?=
 =?utf-8?B?aUdxdUNEVXBIdHZORVdjcXBiV2VSS1VYRy9DMlBLTmVNL1plNk9TL2JCVG1Y?=
 =?utf-8?B?VWNkM3JIWnRubjZ3TVpod1FLSzFRUUZnb0V6Ulp5ZkRZNmJJN1BmSTZWVHdP?=
 =?utf-8?B?UllBRk5xVWh4UHozL2ZOcVNyUkNlLzdldGZ6dXVoSkQxM1VHNWl4amVKdXRr?=
 =?utf-8?B?N20wblhqNjYwbngyak9qNksvNnRNdnR1SWlNUDVzRm01eXdWT1BPbHJEQWxo?=
 =?utf-8?B?OFU4K3RmUFlWenZJTDNPSGFtby9oV2xvWE1CeHVGRE5MVDVBa0l2MStLS2xy?=
 =?utf-8?B?MVhQYWNTTDl1eERvazVaQVdIUkM5SlB0bkNKaXh4RmUxYStQOGVkZGYrbmM0?=
 =?utf-8?Q?ys0jdEyF4wPRCtJC9oxcMiSMz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bff43ab-910f-4719-74c6-08dd4b38a95e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:41:29.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JA1rp9SzUgM6x3obZjSYnWBBmpk9p/f0CN/guxL2k0CL8W1ZeAJ5oJU5oidw51kMzxLsx/9H1BHisaMbeElXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

From: Peng Fan <peng.fan@nxp.com>

Add i.MX SCMI Extension protocols bindings for:
- Logic Machine Management(LMM) Protocol
  intended for boot, shutdown, and reset of other logical machines (LM).
  It is usually used to allow one LM to manager another used as an offload
  or accelerator engine..
- CPU Protocol.
  allows an agent to start or stop a CPU. It is used to manage auxiliary
  CPUs in an LM (e.g. additional cores in an AP cluster).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
index 1a95010a546b14b1d3d97aa990c0305a551f2620..75f63819285b191a815dc4287e34d299983b1c40 100644
--- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
@@ -11,6 +11,14 @@ maintainers:
   - Peng Fan <peng.fan@nxp.com>
 
 properties:
+  protocol@80:
+    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x80
+
   protocol@81:
     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
     unevaluatedProperties: false
@@ -19,6 +27,14 @@ properties:
       reg:
         const: 0x81
 
+  protocol@82:
+    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x82
+
   protocol@84:
     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
     unevaluatedProperties: false

-- 
2.37.1


