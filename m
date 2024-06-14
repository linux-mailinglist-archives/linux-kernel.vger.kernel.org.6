Return-Path: <linux-kernel+bounces-215112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659F908E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF19AB2AE38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F3F19DF6D;
	Fri, 14 Jun 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qTS9r47k"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095719B59D;
	Fri, 14 Jun 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377622; cv=fail; b=pnbc3DxrAuXqY4DeYiBex8qEwDSAkNGC7r3lyvfp9RyRsQUbJij3Oq6Ix0MA5E3G+AG/qRWHSxN0cAv6owgqs+yGpLfU+qoFLCOucG7JP63GwbNAJkgN3AA0CSPnAjfhcB/uU3Tqvy4boSy4Ulr9HtrPo8IA5W/UWZkK4Z7GnSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377622; c=relaxed/simple;
	bh=fw3MksJyhAw68VsBYYaJc4HIrPQE9U5fFN5w0fbrnD0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HlKNBW7sFlHH/yVIVu7FXfTe2BX9PDMfDnJBpCX1B+oP/N2illrROzM1e7XNCL/a2fo3p1YJMpz52GPI+cXcnaxvpTfdWH9zlv4LGCL5eV9oyxLA8VS3WkW0CtDh6XtWP3k9TM8LE7dZNotrWG4HxMY2GtioVeNPUzFo6oFmX/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qTS9r47k; arc=fail smtp.client-ip=40.107.6.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiKf6SKqEgjMiJvC3JcNGnpIR4Bf+/UjPDFFIf2iOurNb/vFSm3qvhdv5KMVV+kffAg5Mxm4CZ9mGOVZE3dLAAX75pWYn6PBbbhPxHlLk1A5WFFBB6zlzVWu4+GYXVVfNVJYmsacFti8wjZrrG405e98NJqjneFUPGbu40GV8fW/kd/fac7I/0oXqI0ogMITIWIdcEzX5mb3HkGpM/543/GosKvd9h64Z77UOjoX5C6oPXyh7nxLBGh8JaBkR+jejW8O9J1CiHiJIfR5T82yInWQcuWbVWF90EEuCP8m0XN7relE1qN+HnUUGBj18pO9RdwhR1y9xU8CzLlGTEXxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25zwrmqAnqe6n4EfLpGkvyNw1oS186ZzdjMTpqcd9/0=;
 b=RhnMLBluNyMagqoNbpO/OIsRL+e7CxDNvjdss3s98c8V2+SUMuCH46NKk7vjI8RZzkwg9+JEc5oAh6axnSWkmZhaHbjgOJcKcobeDqcAz1aFkuwzquXBRvZZPpm6OW3HXLourn0WAhYDwXqwCDmlV+h/1iJxUfxWH6UyobO/44wOCkM2hKGMnLww0bghlH73fS5d2ydo/il5W1O1rxPftk/gXjj9KHXEtToaDEMmnzTFjCmspDvItSYhCwQjyoIBazYpBJ2wlmCy0BlFQtbxPk4M0tPYodNCFlOlHcotlMF8a7/GIXvFbZAIe2yaE3bOiQMj9BrJWUQXBWhjpcGkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25zwrmqAnqe6n4EfLpGkvyNw1oS186ZzdjMTpqcd9/0=;
 b=qTS9r47kl6sF/NAk/wH8Ssx6Q41gswSSL4ByuGTqRkSbBNCpCthmYcmzPBgs//XpvmNL7S7ywpdCV0zzc0tGSGQDvis3jQBgZY+2G4i/FFJuCs2Iazz3LE7HS/i52RUEy07dYxpo8L6ADYzwlbIVrNUN+HOBDNLshgu7+MZA21g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:06:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:06:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:27 -0400
Subject: [PATCH v3 3/9] arm64: dts: imx8: add basic mipi subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-3-8ecc30678e1c@nxp.com>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
In-Reply-To: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=9484;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fw3MksJyhAw68VsBYYaJc4HIrPQE9U5fFN5w0fbrnD0=;
 b=G/iSunc3Ab28vLau8AsiwZnRfhpfObDdzTrt9+cqzdJgtzHIAJiqmzpoCeqK1lg2IRIU1Hx3i
 ZdqGdrS8q3bAJX3XkA0+eEa7aO/7oaTJxZoOhBq9scp3WJTzwIlngXr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 445ea270-2f6c-446d-4697-08dc8c83a2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHZmUHJhV3V6WEZtVTM3VGN6K2g3M0l0V3ZRWUdCVUY4RG5OcktmL1AyT1c2?=
 =?utf-8?B?Q1RiZmdaS0tLTDM4bElOYjljM1BMYVdoTG5nOEs2MldRNENRem1mQ2F0bEUw?=
 =?utf-8?B?enRWTmRjaGlCRHpDZlFiQmtkQVBhUTU1bUVDNERoWGRaNk9NV3hhY0MyK3RQ?=
 =?utf-8?B?bUd0L2xOREUwaHVFRkY2UHB0UWFRQis3dDRpWTZpL3RLb3ZKam0yV2M2WEpt?=
 =?utf-8?B?bnI4YUxxRWtnZ05odFJSSE1nSzRYNWNrMDI5Yk9IWTcycEFSSFIrb29WcmJH?=
 =?utf-8?B?SEdUeGUvN0hMQjhqR1RkODFzYXVFdUlsdlRFR1FrendmQ3p3MVZ5RGFJVFUy?=
 =?utf-8?B?VUJtNTUzN0grSEFpeFo4ZVlpd2w2WHZ0S25rS2l5amRnaTByeUZ4RExqRlRJ?=
 =?utf-8?B?OFhrK29sSHNkcU52WGRqRHg0aWREY0haRzBwWE93SWtyQnFscU1rYlhOdDFG?=
 =?utf-8?B?aEgvRHc3TVhIeHM3VHQ0TUFGWmo1dHNFbTB6TEFrSkQwNW1KcmlZZVJyekZy?=
 =?utf-8?B?SmZsOFhZNzJSMkE2OWRCZ25FUkRFdiswL09QODVVQXk2ZFBBMVIzbXh6ZUJu?=
 =?utf-8?B?RXdtSXVCdlA1MWQzZXUwazNQSGV6cEhRTllMdVcxRWdFdDlVRFp6S3U4ZDB3?=
 =?utf-8?B?c2dDd2kwOFB3TE0zem9sZ1NrQVMwK2Y4Q3FyNk5BVGwzLzlGM2RsNWtibXhJ?=
 =?utf-8?B?SisrK3dsWUNHbzFvT2JHTjFXSWsrYXppTEU0U1hMeTQvS3Y1RTg0UncrVUlX?=
 =?utf-8?B?Sk9qMFU1R1V4UVBuT21EVzNCb1hPbEQ3a0NmQ3ZGUlBaVysxRmhCd0kyeisy?=
 =?utf-8?B?YUNxZloybHFqRWQrdDY2VXRwSjhVWkpTQVBsZWRyOE9MSXRkQ1gvTTRDWTFt?=
 =?utf-8?B?MzdiNnNXR3JKWEw3N2NzOHh3R1BlQmlBcDl6dk9uUml0clR5U0s1RnFLVnk4?=
 =?utf-8?B?aHhNaUlpV1dxMVo3V2FuRVYwVDRsTjFjcHBKV3E3MWxqazRsdEtrTWhCRHFY?=
 =?utf-8?B?dGROTFVOTlQ5YnovRkJwRk80cFRua29HcjNQaHE0U2hhOVUyeFQ4aStPVVNO?=
 =?utf-8?B?bVMrMmNxVnhOL29pa2R1cmp1VXZSUUVUSENVTzRiRW1tVFdBazRIYUU1c3pJ?=
 =?utf-8?B?WkVIVkRDUmRCVlN3VDZTRTNFZTVya0N3MVpsV3pDTnNmZzNDUU4zdy8zMDZQ?=
 =?utf-8?B?OCszZlZRR3BnK05UL2pNOHVDU2NXbEdONVZVL0J5aEVNQU54OWYvdVcxNmxa?=
 =?utf-8?B?K3plcGxhdnU5V2FqVElpWW5WaUNVOUZnZWNaSlhXZHBZYTlTaUMxby83V281?=
 =?utf-8?B?SXF6SlNyVEgrZS94RWtPQ3VHSVI2anNxRGF5c2hqV1c3anY1UzBLUWRjRVNk?=
 =?utf-8?B?WlRVMjh6K2lKOUxISWM3SGx3RVU1bDVDMWRYZXEvNGdub0dVU0RQaXp1WHFm?=
 =?utf-8?B?RUJVRFBKSDQ2aGFZMFQ0Q25SeGtzMHUzQ2h1T0VxYWRIVDNtK0Y1YjNzMW9x?=
 =?utf-8?B?T2U5RE9LS2QzcEV1LzkweU55UWpiMXgzVVNoMlhMSTA0OTlwcmxmeGFVQ0NF?=
 =?utf-8?B?QU5yWVlEaVE4Z3BPMGU0SWNjZXBSUG45OEtQaGtjV2gwYXd0L1dBeTJybm5r?=
 =?utf-8?B?OW9MclZjQStZemh3bjJkOGJkSkN0UFFGWFB4QmZoS0dWYk1zOVRaNlc5K214?=
 =?utf-8?B?dVhyUWU3Sm1pTC9PM3BBS0lmZkFMVkgzOWt1Mkt2V3NUbWt6M1FSamk1dTRy?=
 =?utf-8?B?SHFUT2pSSGdtN3lPNm5yaXQ2MkJIVi9KMklRYmhZY253S0toU3JpTVlHblhS?=
 =?utf-8?Q?BZDaPtDR4NVFo9OtZ1gx5rRCoUxZLkLKuIiv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE1pYk5WaWhRckVOV3MrekE4YVBJNi91WkxLYzd2Ny8rSTNzQzF4Z1AxRW9B?=
 =?utf-8?B?SjV5a0gwdEJsK0dZUmdaRURVL1pMUklCdm5nZFhsVnJucWQyWDlxM0FReFVG?=
 =?utf-8?B?V0xiQWR5ZjJWSDljeWJYWUJMdlphdUoyV1ZzSGdQbFpsbDU1cGxPZStxVEsw?=
 =?utf-8?B?cWhtUmwyZ1NGRFExQWVwaUdQZ0ZORDVSbkRTbm14N2tEdHNmRTRhZzBlNXRh?=
 =?utf-8?B?SVBVUzVGRFhGUzhFQ2MwTzNaWW1WK2xZYUFrd2JVckN5dWkxWXBOUG1qc2Iz?=
 =?utf-8?B?cksreTd1TWFGY2RwSlNIOXA1cjNtR2lWcXJDUkVIaHUrZ2xCQ08xYjFIcHFk?=
 =?utf-8?B?K0Y2TUNKclFGaW9TY09FNXBvZjhDVGFDdFIwWnllM1dUMDd3NHFZWExydzc4?=
 =?utf-8?B?M0huenNEcGRxUlcwUW13UHNkaFRKS1pwLzNOVlNCUEhmVUR4ckNBbGFsV2k2?=
 =?utf-8?B?WFBOYUtHSHl0ZGovZGgwSmtDVFpJWDhMSWk0MHlDZ1RMajJjZGllUi82L2sy?=
 =?utf-8?B?YmJwdnN4WEJ5QUgrQ3hGbmVCZzROT2haTlZ2WllQYm9EN2hKRG9XK3NzUFdE?=
 =?utf-8?B?OWNnVmsxR0RiK1ppbVowNkpGNkt1RHVjSG9qdU01aUpmZFo0VUpycWpHVHpx?=
 =?utf-8?B?aURmNGVUQ283U2FiSVJMZjRLSVlMcEh0VXc2NndQZjF6R0djNTFWNXVMUWtm?=
 =?utf-8?B?a1RJazRUSnF5eHdZenlTaFZrWEJWcmRqaldvaGFZbXZ3L1lFemFGaFRnU0U3?=
 =?utf-8?B?ZHRJNW9aaFFzZTJ5eFV0bzhSeWV5MEY5RTlmbDBMc2Z4SXJhbWl5QWFVVnJZ?=
 =?utf-8?B?cTJaeUMyYWJnd2NCZjV5T2lJTm5mTndUYkxCdDRud2V0M0FJak9XKzl6MnBq?=
 =?utf-8?B?SEZjRWJNYW8rK2tsQUR5eEFyYW85aloxbDhFOTZSV1I2UmdWV3l1cXdrTEdW?=
 =?utf-8?B?NlNpdlhFeGppUmRrNVFTbFRJMk5WeWFNUldxZCs3Wk1qemVsYmdWYzUrc0Za?=
 =?utf-8?B?Vlp4aGNFZktkSk5aMHZvdjVmYmp1VW5STWJCN1ZxZHJoMnpPL0U0QWM0S2pj?=
 =?utf-8?B?SjgzbFdiYU9ZSnREeGJMOWVlaU9lcDBOUlFuMmlPTGpTbnZpUzVXMWVyVUFZ?=
 =?utf-8?B?MzVhV2J5OTlmRHVvRjZtWWR1bFEzVjZ3ZzZWQ2k2d09GUGpMTFY5M2RHZjNi?=
 =?utf-8?B?RmxvYzM4UXJabGNuaUF1RGN2M3NqOHhicUJDRW53ZFFNU2NnUTc0SzJQNGFT?=
 =?utf-8?B?ZFpDcG9ocFlLS1VGS1o3Nkc1enVXSE5GUTgrRTlvcEtHQlVKQ3VSMy9rbWhn?=
 =?utf-8?B?am55OTljcXlENThMLzFCRTY0eFYxNGQ4VzVWM0c3Qk5HRkZkNWR1dzBCV1hJ?=
 =?utf-8?B?dStrS01JU1g5UW5tVUo4YmV3NG5udCthR2Z0K3NkeTJwcGN1YVpTY3E5RWJ6?=
 =?utf-8?B?TWRIZStyWVhONmFjZEI2citoSHpSNDlyQ0VYUnpSNkMyRitBa3JQQVgwQ0k0?=
 =?utf-8?B?VFlPL3pYc3NpYmRuaHQ0UGZ6UkVIeVZNSHhvK1N2VUM5OU5ZdnE1eG5EV0Zh?=
 =?utf-8?B?RGxKV3dRQytzTFJqSUZpaXN4Z29wRUlKM2k2aGZ5MEFsaFZsSlZNS3gwWk1R?=
 =?utf-8?B?Q3d4LytTVEcxQ2Vrbng4ME5QeFdRUm1UWlNVdWVhcFYwTjhBVjI1WGN4L2Jy?=
 =?utf-8?B?SFRyYWE2SUtnTW5DYkNTa3Mvelhvclk3RFZWdFdoaHQ2OG5UbCtzcmJlTGo3?=
 =?utf-8?B?bHVNb09YTlVtTUxUTzJjb0phS0szajRaYWQxVXpFdEV6aE55bHRETDFSeFhM?=
 =?utf-8?B?MGNxYW9xc3J2V3ZKb3FqUU9CYjZ4ZUNzajVCNjIyaVR5Y3hYNWRSUE13dnVo?=
 =?utf-8?B?Zk5Oa2pudEQvMlZUeWJDNTlXYmY4ZElSR0FSV2JpQ1BVdlFJLzVlSkVyQi9s?=
 =?utf-8?B?eHFMbXY4Y3JGeGpVN2p4eUJZMnN0UFlBeFJOb2VnZFhEdHVvQWNZTHh0dVk5?=
 =?utf-8?B?d200ZlZKWGZSWlBlZkRPQ0FJOE1xaGlTNUk3alhjRnljcHZneWFnekxmcFZn?=
 =?utf-8?B?VzgxNFlOQlpnUTZpQVJYWXladFFJQmpiaVYzeGU5MnJER3B6U001My95bGls?=
 =?utf-8?Q?EjnDcBAoePJErUFtHeQnXKF00?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445ea270-2f6c-446d-4697-08dc8c83a2a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:06:57.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5ONGlLljjfqisQyKiVECJ2d3Cx3CGFm7Pme4snCVIjhHr5lticHP9jeEym5NU8/ozHQ9O9BDXfIKiukfNsYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

Add basic mipi subsystem for imx8qm and imx8qxp.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi | 130 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi | 138 +++++++++++++++++++++++
 2 files changed, 268 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
new file mode 100644
index 0000000000000..834c0472a8901
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+mipi0_subsys: bus@56220000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_mipi0>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x56220000 0x0 0x56220000 0x10000>;
+
+	irqsteer_mipi0: interrupt-controller@56220000 {
+		compatible = "fsl,imx8qxp-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x56220000 0x1000>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&mipi0_lis_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_MIPI_0>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	mipi0_lis_lpcg: clock-controller@56223000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223000 0x4>;
+		#clock-cells = <1>;
+		power-domains = <&pd IMX_SC_R_MIPI_0>;
+	};
+
+	mipi0_pwm_lpcg: clock-controller@5622300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622300c 0x4>;
+		#clock-cells = <1>;
+		power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+	};
+
+	mipi0_i2c0_lpcg_ipg_clk: clock-controller@56223014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi0_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c0_lpcg_ipg_s_clk: clock-controller@56223018 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223018 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c0_lpcg_clk: clock-controller@5622301c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622301c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c1_lpcg_ipg_clk: clock-controller@56223024 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223024 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi0_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	mipi0_i2c1_lpcg_ipg_s_clk: clock-controller@56223028 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223028 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	mipi0_i2c1_lpcg_clk: clock-controller@5622302c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622302c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_0_I2C_1 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	pwm_mipi0: pwm@56224000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x56224000 0x1000>;
+		clocks = <&mipi0_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&mipi0_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_mipi0: i2c@56226000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56226000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
+			 <&mipi0_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+		status = "disabled";
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi
new file mode 100644
index 0000000000000..5b1f08e412b24
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+mipi1_subsys: bus@57220000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_mipi1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x57220000 0x0 0x57220000 0x10000>;
+
+	irqsteer_mipi1: interrupt-controller@57220000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x57220000 0x1000>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&mipi1_lis_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	mipi1_lis_lpcg: clock-controller@57223000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+	};
+
+	mipi1_pwm_lpcg: clock-controller@5722300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "mipi1_pwm_lpcg_clk",
+				     "mipi1_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+	};
+
+	mipi1_i2c0_lpcg_clk: clock-controller@5722301c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722301c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c0_lpcg_ipg_clk: clock-controller@57223014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi1_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c0_lpcg_ipg_s_clk: clock-controller@57223018 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223018 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c1_lpcg_ipg_clk: clock-controller@57223024 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223024 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi1_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	mipi1_i2c1_lpcg_ipg_s_clk: clock-controller@57223028 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223028 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	mipi1_i2c1_lpcg_clk: clock-controller@5722302c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722302c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_I2C_1 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	pwm_mipi1: pwm@57224000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x57224000 0x1000>;
+		clocks = <&mipi1_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&mipi1_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_mipi1: i2c@57226000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57226000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		interrupt-parent = <&irqsteer_mipi1>;
+		clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
+			 <&mipi1_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		status = "disabled";
+	};
+};

-- 
2.34.1


