Return-Path: <linux-kernel+bounces-274951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF0947EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56741F21E8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EF715C15D;
	Mon,  5 Aug 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i9N1huCx"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42DA15B554;
	Mon,  5 Aug 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873028; cv=fail; b=cxT3fWXYsRGTVBmlukBsmmhxHogddbbECw9FGEsIw720fXBYmBYYU2NDfGPWRQepIulYo7Gkes67IYxTsLb1gng7ecO+y/whpIpmf/e2/dpLD+PoRTAZukSclIF9JryMKPEaOPavBthDc/2TwlW5BLPLFU5OeL9M5iSfbyBqGa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873028; c=relaxed/simple;
	bh=8+ailBZ6Z5P8TCx4Ql+HCIrm45YEEO3eHc0iD6e6DFw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tQLwTR6t1bHGXgVs2gd3mcFERLnE4VIbJ3uN3YdOlCrcJJ0KDFgpzcrXSWXHhALhMboc95NW4MMF9KN2UscwzZkPF5a9pCT8VGqlQKhGzln0OmUX1x4MlQc9ekk4Aoh9itluP2x8TdKTUgUDPFBUgaWrz7xNAoY+RMW+9tbQe1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i9N1huCx; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8t1PNJtSUoFYXrOQ2XfAjB2z7ALfeTH2kt10tZREkQruRFcuD/xKHZGbUb9oiY+1HPUNNite2oO8Bpn6FK+ais8ApE/Ht4Z2VQAoj93Aj7lhXKArpzQBKT/PxHytIIA1Ph2eMPHhzA90EdnCr9qhMh9wxLCYbt1+OWZYF3B3pqBS45qJzE1r5QoVb1e9dKk9RoY7yWltNlo2PPn321zVnB4SoKN6ze7k/kaEDqD2KyQF1hbrJOhiDiq+kpcZM7V7D+WHOq4WtH30uX5Uaz3CIDv8lzIB873di0AlwE2ZKeJv9zbjmGK9Ps5v617aI2CMzvTJus/WS8KXXye/pGvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sgpIYN4kFL/vciQ7DWOjEdgyxjRLS0dvftmfP+vbqI=;
 b=VbVkamdhNN2twvYN4EAtbTM8U52yxASSKUYxBdmCpODoamJC4rjNvALwBRUu6JROQO+VRNEQONn1ldNWD8cRFoJLXaAREPZIjs/YSDv49A+fkBoToYddi8GtC8IVMlr2vc3rx0QMiZMBhQAyFpJ8oSJyajt6AFd4giG+KbApjS3oqSgvguauWscIr91D/n4DUkPAb6hc+GJuRWUG2LfQrg7bltbwKhrvGjUzKloevxl3vqEtL3VdVGybCuUyGXpmPMDH4PJpH2yhvrCDBP0PP5zLd9K/PnQO3mP77sSj6VVtDmom3w7C5eQ6uheBsTmzGMarhlPhuGJ+g9Au23v57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sgpIYN4kFL/vciQ7DWOjEdgyxjRLS0dvftmfP+vbqI=;
 b=i9N1huCxg29+zViQuEiEXIy7GW7ubZzLSUzaE+uF5Q8p2UwGdtFkJhUBHeXgJXBBL3hP1hPTcUji2G60L/OQr5THsiCLFAW7UqXv+8KOm7COntnHsec4rJOcdjdR4/IB3RABh3rEAK/y625y5aTxWNlqFqwCN63Fc7npAoo4dEh/u4VXCnYoW7Reb+ZXdxza3a9TEUpZzBma/FMRFeSs43lS5/1Pp7zm5Io/dOvj9PmHG46q339+6v6i/NTV/1iNJ5HewLjBy4pFNo712Xci03GA+iFWbT1Rg0P4cJTxh/b/2gFIgQ0Z9JsLd1EhFYYHwkRmD5rFePYcogGjS5R9Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:46 -0400
Subject: [PATCH 4/9] arm64: dts: imx: add fallback compatible string
 fsl,imx8mm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-4-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873010; l=3783;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8+ailBZ6Z5P8TCx4Ql+HCIrm45YEEO3eHc0iD6e6DFw=;
 b=jcWROecQUec5NcQkS7UfkfKCit6Q9MQP178jIdrKpoKjHPGJ0425ZZtn9azob/QJg8XuQIg0N
 CN8hEUSQVO8BRgJsE/Q4ArQy9ajlVBQh/oZ9Olb4l7P+2Su6SJGvPTH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 07342769-7e24-4c7d-5897-08dcb5665034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG5pUkxiODBZVytHYmxwZHpIaThQSk5kNGQ4U0Z0dlNpVVhjTDR0T3hTTnJ4?=
 =?utf-8?B?TTZvYUFNRHpQYUd2YmphZk5Ocy9DVGk0TlMwNDY0UVMvUUkwRlg0em43MjdC?=
 =?utf-8?B?d3BpelJtZkhmL2xkVmJSeTFVRFhkUVpud2JxY0tVMTFTTUpnN2JRU0xPNEp0?=
 =?utf-8?B?OHJXdzk1dTN4bU1XMFpjWDRDZTJpMnQ3QUlTQWxTalRoVmJqUzNYQW9Td0Ra?=
 =?utf-8?B?R2FHQnU4QkhNNUhYRG5wdzBzU2xLTEpwblhLUFd4bGNYSjljYUluZE1heS8r?=
 =?utf-8?B?aGdwS2ZsNkpyclVvTW5XYUlBWFlWaFlvaU9TRnVMS0xkSkVxV2NTVEdoOVhK?=
 =?utf-8?B?K1RNWVlyVjdWV2QvYVA2bkRXQm5ZVjFhcmdMSm1ycUZaejZxcFk3aEdhc0Qy?=
 =?utf-8?B?SThJWnUrK2toMTU3bWNnWGp6aU1Yb01lWmhmcGNjNmhSWVI5UTlhQmoyQWU0?=
 =?utf-8?B?Q1ZWYlE5Z1ZaaG0wWDdteTV0Vk84OTlJNW1GTXZTQ1R2WHU4UXBjYUc5T0wr?=
 =?utf-8?B?WnBIazZmMHExV0FzeHBWTUF3bjZhdGtMMVdLd0N1aGlqcFZDTjB0UXIwdUp1?=
 =?utf-8?B?NkZBcXB6WktGWWZBd1FOdklUaGwzUkxXRnozLy9YZnRlbEtPSWMwYjhaUlVC?=
 =?utf-8?B?Sms3T2Exc3NIK1FSNVM0dWxPR3M2U3RqWEtNOVNXNkdPNUhVbWpoWUFiVlp0?=
 =?utf-8?B?RXZWbmhEZUdka3czb3ltTndEU2xRTTJydkkwRVQ5TWdkdnd2cmZGc3RzaExE?=
 =?utf-8?B?bTFBdEw1UzBFajhPYkVuUFE0dlZzcGhZNUZTT25pcDRMcFlqYkJPSCthWVF1?=
 =?utf-8?B?MmxSbTVKanYzSWdPdnU0ZXhzWFg3Vm9lTmkvR3E2QXhiRk5zdmNjN1FuTGJM?=
 =?utf-8?B?cU1KTGZDb043MmxFVzF0MFJUcXZHdFJJM3NJT09NR0VGc2I0cDdjek5CMjYr?=
 =?utf-8?B?cS9WRC81T0pKUkpOZnlONEFTMmhxdDg2Mk15MWxJQWJjeVBySTFZcXp0RTVI?=
 =?utf-8?B?L2h3KytvK010YVgrZHlKYnp1RCtDZFNXSFNySTZZSmJsT3Z6R2xXQXVUUjZF?=
 =?utf-8?B?YU1TcHFjS2R0eGdiRlNKc0FJTGhIWjlaS1k4cDVuaE9SMzA5NlIvU2dnN3dq?=
 =?utf-8?B?WUhzZnRrK0pXMCsvRjJZVzhtUmsrRWJYcnZ6WVM0N2xkNVFTWWV3Qy9yTzN6?=
 =?utf-8?B?ZGNlYlYzMDMybGZrZVB5UTZyUy9tbG0rb0xnSkEyaXRaSWVvZElQMERGSWgy?=
 =?utf-8?B?aHRaQjN3VlQwMVVFZWlNeWZRYkxEV1dIb3N3ZzUzOVlRTWd5Zk5aUFpOaXM4?=
 =?utf-8?B?bzEzRFFXZ3RodWExcThSaUhmcG5ZbDZ4emZjR0Y4ZlQzZmZyKzU5OHlrR1JP?=
 =?utf-8?B?R2FZQ0FvUGlreDdCQ25XM1UzTklSUmRwS3MyWGVRTEFHQ0RPWVp4c0EwUUdo?=
 =?utf-8?B?bjZOdmxtc2UrdkRDRUpRcit6SGZhcmQxL2JMcXNDL0UrbkQyR0dYbnY5WExh?=
 =?utf-8?B?bStkTW9jS09PT3pBTUgvWmRjaVBaTzA4UWp4bkVDKzllMVlHY0lZSTNSZTFL?=
 =?utf-8?B?Qlk0WmdzY0ZZNmNzN3R5K2pzcG85QUpJZ3ZZL2hIZFBPUm83QTJrYzJSSWJy?=
 =?utf-8?B?SW5xY0N2QWFMa05xbTBhY0NDNjlkditmQlBHUnBzYXRET3lMQlJFbDFKYlNQ?=
 =?utf-8?B?Z0Qyei9XRW1QK3JTV0plb3ppSUVFSFNod3pVK0h6WEtudEkwa0pLbU1JSUMx?=
 =?utf-8?B?NFNhZEc3Q08rUm9mSWlMOFRDOUpYT0lSYkRqeVN2Q0J1Y1hkODVOWlBsUDA1?=
 =?utf-8?B?Y3I2RElLUzBOTm5xcm9pakhnVUVrOHN3a1IyMENPSjh5cmE3U0llWGJOa1Ur?=
 =?utf-8?B?dkZ4U3pBREJWb1J2UGdid3FsazhsRlo5b3RQcnhsbTRoSmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWJoZjJEbVBwd3JCZUJrVUloK0V4OXRXNThIRU1CNkFlbEEwanhteFRhME9p?=
 =?utf-8?B?eTdVa3V5R0FQcE9QTGhrZkRJNUNsRGZvWnNSRDdlS2pRK0tVbWNLcnpSSzFo?=
 =?utf-8?B?QlA4eGVrVVp1NHIxYS8veW1QT016aGZzL2ZzVWFKRDNodi9LSjRRS0N0K2o5?=
 =?utf-8?B?WExZNHV1M2E1Q1JVTlo2NFBpTmhId2ZGZFFNR1pwcjRrS2RMdXBiSWtsWmdL?=
 =?utf-8?B?cSttekN2VUM4LzVzNTFRSUprZXZmTFpWSi83cHcwL0lRb055ckZ5djFPK2FZ?=
 =?utf-8?B?MkFrVmNUeXJkZFpMVFJKdlFiVWFoUGRmQ0pFQkFrSWh4VDRHUysxU2lHWkRh?=
 =?utf-8?B?U0RLOFJETS9iNDRHOU5GUjhndkMxM2Y2OG0xMW5GTFllQUg4TUVmczNGOFF3?=
 =?utf-8?B?d3NsR0dUaEdpNThTWDZkbnZRd2ZkY2dRUUducS90NzNGWFdUKzV6dkY1L3hh?=
 =?utf-8?B?MlhYN2lCQkFGUzhSeU44cStiQVdJWEp3RUhGM1dNNkY1YTRFMW0xTS9YajBw?=
 =?utf-8?B?Rm40aXRzdjJpbmxEMGFUaG40ZDJ3eTdGUHlvcURheEJqUEIrejc5ZklCekQ2?=
 =?utf-8?B?WjJxOWZkVStTQnJabjFSNUF6Tm51SHVqVkdDVDgyZ2tNeTdGcGpzVU9mM2ZZ?=
 =?utf-8?B?Wk1BWTUvUVNkNmhDT1lwMUZLWHIvMW9CbGRLY2M3di9wQ3VnRS8zS0RzalNT?=
 =?utf-8?B?Ykw0cXFLcUdnSFdaYWZVRGdzRjNkRklmeXI0bHBKZkZhTjJSYjREMU9KNmZp?=
 =?utf-8?B?VFBqM1ZNRU05VGpmdXlVMnMrL2w0b2duY2lMaERacTVTdDdVaFU2ckVlRzlx?=
 =?utf-8?B?UmVLNXNZKzM3RjVDNkgyd3JQREx3MklWTjU1bk5wN2xKN1NmV3VzR1FFellr?=
 =?utf-8?B?WlNoSjgwUEJwajc0OFBQTHlaeVFvVjFOdGQ0R3ZnUFVKdlVWR2dOZE9WdUFl?=
 =?utf-8?B?cXFhbnBwSnVndmNBNFIrVFhONVNTNnR3NTdTM1RnWG9tMldaYUozUVZadytw?=
 =?utf-8?B?SlRBREt2dmFXR3oyanlGQjNEZk9kQkpLOXlvc0x6eFlkVEFmb2ZFdGpnVmU4?=
 =?utf-8?B?dkRSeWs1d3FXQ3dMVkdJT0xXS3Vzb0twTXZVNnorek13V0RKV1ROL0JHN1lM?=
 =?utf-8?B?WTdjWTdUdnNheFVQMWdVZ1N2U1BSVE1MY256aXo4Tm1lc3NtUE5YdXNJN2dx?=
 =?utf-8?B?VE10WjlBVjlHYzRBUUp0SUdDMkgwMTByajNjb0VaMU5jQWZHQyt0YWtQN1RO?=
 =?utf-8?B?VnMwdlcvRGlOdHYveTZha3hoK25LSnh6azZNci9mT0cwdTN3OTZqS2ZxNGZV?=
 =?utf-8?B?UFA3OXBUV2FidzRYclV1aitmYTkyckMzbTlWeHVmaCsyZ0s0dnl4UFIxUk9h?=
 =?utf-8?B?Z1N0dzRMQ08zTkpLdTc0SHJuWWhBaGVhK3g5MVBveDZZUUIvTC9odkRmUDM5?=
 =?utf-8?B?UmdWY3A1RG9ieXdadC85SjZEQ0FqaVgyQ0l2dlRtUnNRcnNxd3dsZ0VqMkpZ?=
 =?utf-8?B?S2FVRlRaTGVxaGFsYjJEVk9XSnc1bVBPZzlwNTQ3bDdTa3FFMFdnaUNXOE56?=
 =?utf-8?B?ZXVKdzd3RFUyNDNTVk4ySzF1SFFVcHo4bE81YkNyVGFDay9ML0pWRktKSFpx?=
 =?utf-8?B?SzJ5bVcwMk1ETktWS2s0TGRtWnRTSGpXY2NBbmpkeGgrclV0ZnlhbVFVWlBT?=
 =?utf-8?B?cTZmelRTdktxWUJsZ01yMjVTcndYWFQrbmkrd0JUL3M3V1dNeGMzam4wMTEr?=
 =?utf-8?B?TGoyV2M0ZURBSHRIZklnYTRIVGIyaG1oM1hUZVJ1SVZMY1ZDOGxmempidHNs?=
 =?utf-8?B?SU1Lajc2VnUzZk5rZUVjT1c5WG54RmVBcFB4cGQ2S0c0aG5nb1VDR2RoMGpp?=
 =?utf-8?B?Q1VybnJ2RkJHZFFqU0IrL2h0aWhaSXZCd3Jsc24wVy9wUEFNanhxMVJqY0Rj?=
 =?utf-8?B?c1UzbGR4MDZBTU0ydFBvNUpNckZyRldNVEpnNThCRU1rWnB4QWxuemZPcWpm?=
 =?utf-8?B?K0JhNkIyeFZ0a25RSnhjdjRMTTJTcmlSWHdsK1g0c2hMUHpzQXZ6anZGcklH?=
 =?utf-8?B?ODZHUnhlSWRaY1RqZ0NYSVcwaDArYytOZnZrM0d3cFZYeDczM2tWRFFtQ3ZG?=
 =?utf-8?Q?oBVCq7/txR80cyyJC34retyNU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07342769-7e24-4c7d-5897-08dcb5665034
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:21.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFdz3WTJ7z8eXLWwywR8zELYUluJyP+4e0saSgWDxxlOFs1Co1CCrsQ1tI5LXYnIeodtS4Jck+3DXNH99YFezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Add fallback compatible string fsl,imx8mm to fix below warning
arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
        ['gw,imx8mm-gw72xx-0x'] is too short

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
index f6ad1a4b8b665..6930b2786afc2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
@@ -16,7 +16,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "gw,imx8mm-gw72xx-0x";
+	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
 };
 
 &gpio4 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
index c3cd9f2b0db34..a2d338ec714c3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
@@ -19,7 +19,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "gw,imx8mm-gw72xx-0x";
+	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
 };
 
 &gpio4 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
index cc0a287226ab8..19fff8473970c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
@@ -19,7 +19,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "gw,imx8mm-gw72xx-0x";
+	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
 };
 
 &gpio4 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
index 1f8ea20dfafcb..6092d37e0069e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
@@ -16,7 +16,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "gw,imx8mm-gw73xx-0x";
+	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
 };
 
 &gpio4 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
index 3e6404340d529..5e7b2d639bff3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
@@ -19,7 +19,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "gw,imx8mm-gw73xx-0x";
+	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
 };
 
 &gpio4 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
index 2c71ab9854cb3..a1f0e4e85fd7d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
@@ -19,7 +19,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "gw,imx8mm-gw73xx-0x";
+	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
 };
 
 &gpio4 {

-- 
2.34.1


