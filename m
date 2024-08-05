Return-Path: <linux-kernel+bounces-274953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C97D947EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434F72879D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA015E5C1;
	Mon,  5 Aug 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k0jKA4Cf"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791215B11E;
	Mon,  5 Aug 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873033; cv=fail; b=GOwVrKtN5C0Nta4SDRGM8zAtlJJ9OCLtuzJ2JU7AtktbJvyo2Dr2HYCQ7IswKTDLT0Fh4I6I3tS1ur8KYAUKn4XQpE2Qd77WQOX6HGPEg76Om4SoJ1F4gC5hI3QaMzCrhA2HoCO3EM/bfyiVgMIeJN1gzEtC00MRDcKt/+w5eYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873033; c=relaxed/simple;
	bh=t26D5FxNKUeLY2GiQWuD5vpCmsOI7BpKRPFrc/fHvJA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZtWjyfh3Rk+ryVlQiDEITsuBdJpeJ1jq8k/WGvKEQv0n6NtbMMFDNp2qXHJcWfQXfhMmZ6F2Y4A17zejGBmLfCyKF28UC/ARm7ReUB0i56xzRsg5f/1ycwzoM9GtFDEE8e5bkhzdKX03ql0Dz5ydZRlYLuulS6X+mX/ZnolmccQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k0jKA4Cf; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHxB5RU/yNg2hOnpM26eJ5k/JDJ7KX+/S8XbfBjp5pia8vipelqhUagjIq2Be4551Wzhc1SLEv+fFe5jthwgPuqVUsW1eRnoi5LRGbN2+gASzz3cmdxkZSkvKAZxx+I+7lDR6fdAFQpmDApFENBeUTWGtar7g7w0WOgUEojMTk4XAWY5wfBO/imCjnWLoZT3l9ZGjnO0onpSvlrSPw2SVQ96ghl0Nr6RHpoxAlnkwo4jMkPFERmrpugFsoNOtMcUrJcx0Jx+tzkjby4YaiSUWyIimRidLs6H85xHfzvn1EeD/8x1FDvRCWrq/YZHWrPS/PaxMoxISmR6XiHu+5quew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+zGh/vm70Fk6PNdCaATgb9/6m3Ca15+tXVYWs0gZAM=;
 b=IEVy0XKkUqKGseF85+k3U/io25nmSJUkVb+EvHBdgDqppMNa57e1o54LpMgF8tfFcGAW7DXYHoxZU6nYagzQyZHVFGqVVBpRo+tuJ2rxNtfVF9l7UwuXN8IACY1ZGJ5YSRyzOu/TK40wTLjSLcQL3AET7jvjWT9KHACLEcHrF8Nbsl7Bi60I4/Rn7gAiC1LnA62WBk/d/J0p6sapMaMcLTQy5kgcMYJUTdTLUNks2zMM41tazNq6GK5GrUl66Go3q6iXPsORvwbVDaGtmxbTKP9KvxCXsKaHDMEnzGuhO7CvxoT+100K6gFPY84pvvpEpTq4Hbaj62iyXAqtcobTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+zGh/vm70Fk6PNdCaATgb9/6m3Ca15+tXVYWs0gZAM=;
 b=k0jKA4CfwQrB8gXQ282XMK52Vl8fNbgk8JSqRGHu6rm4fIByi9CVz7xlddU9RZtH+gnhYAVM4xa90chwjFRya44OKtz+hpK6r6LbT1dzCdwBDYtaAiM1A4DAS2XpO+8vNFuSQIoRhLh+/MAngOzG7t8Td3Q3Dx9L+B5MwK8cPVmPl8dl/Y1mMevNXmgA2AMTe9I06G96Q+P60ym1LRWxQwgcJ85nuIi1M553p3mTX0AFCf1ro17yUOSJunMaD3uZYAsCK8Vwm2oij34n6pAPJ7LSUB60jpC+SgbjbvZFcUpSNZic1miVw+3qATrV29oL/JwdzkwequXmRluxhjkoHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:47 -0400
Subject: [PATCH 5/9] arm64: dts: imx8mm-venice-gw7901: add
 #address(size)-cells for gsc@20
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-5-055653dd5c96@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873011; l=860;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=t26D5FxNKUeLY2GiQWuD5vpCmsOI7BpKRPFrc/fHvJA=;
 b=qLgqzcDZoBRjMUpUlxAZVBi3HpiDr5YMj00M+dheX7tvxtD4s/Eicow3vPqoUQHRj2h/xytyd
 ja17PtPV+xkCPtcxlYwnvHWKIZgkubBdq5bNiYUHXmuOOeI+zeRvHIn
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
X-MS-Office365-Filtering-Correlation-Id: e5ec5646-bb2e-4aa8-38ab-08dcb566517c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWhhUkpCaDhiaEVEakR6K1R4OXRCRzZLMENybmJZb3NpRHg0cGNVY1ZaZ0Yz?=
 =?utf-8?B?WXB4bXhjakEvSW8xWVhUNDlKb2lQSzIzMk9DUkRNRjhxZ210SEV1aks5M1dv?=
 =?utf-8?B?ck5TeGh3R2QxSUhXZEpXbnN6cWJ2YkoxSzVaY1I2QmF0eWtEcEtWbDNBdDMv?=
 =?utf-8?B?MGRSeWw0UEZXZ3h6bmUwbFoxQ3NQTUpVQlhMbXkyR3VUZ3BLUzVMTzFYYTBv?=
 =?utf-8?B?WElZVWRKc3dxaWJsUFc5Z0pLS29meld2b0xPUm00NmxyYWJEUkd5VE1qVnI1?=
 =?utf-8?B?bzR0VzhwT0lzUVU2eHpQd09lSGYzbUdoeS9JcWhyM1R0NnV4NUVTckt1T3FM?=
 =?utf-8?B?czRFc2Y5L1kwL0JQdG1uejl3VWxUUlRZUDFSc2QzRW8rZWk3K1U3OTFwMDVr?=
 =?utf-8?B?dGI1N3J2Rm51a3NkQnV0OURobGV2aEhUcFVrQkNobm5kTnMzaXJEOXVrVzdx?=
 =?utf-8?B?ODNJdG94dE1HSXJOc2V1YS91SU1xNzNmRTFGNmphWDIxbWxTQlZxTGRZSTZr?=
 =?utf-8?B?ZE1kU1F5NDlreWJhSFNZMFdRbkFmMm9Ec3BrVmNNV0VVMGQ3T2dkZmM3L1pT?=
 =?utf-8?B?b1luQ2RxVEp3dWJBc2tjRGRKdHFqOE9ZRFhJdXNoSzZnSllUanV3YUlmZHRH?=
 =?utf-8?B?ZkNObUNUajRkMncyU3AxeFJmdXJTSE9hMHNQR0NGVlZHU25Tc2crR0FFMWZw?=
 =?utf-8?B?bFJPdkRQQlRsbURhS1V1L1gvdnczTmI4TUtPQ0tNRFMyS2NBRXdVT3FPRzN6?=
 =?utf-8?B?ZFNKeXBMMzVaTHlCcmlkVUJpWjFhVTlwWmR3LzNwSGNaYjJCR3R0bklHUU9r?=
 =?utf-8?B?eElHNzQrd0M3TTZNMWVtWThMVk9KWW5YWlNmL1lxYUY3dlhZOXNROWt2enVm?=
 =?utf-8?B?emRYRUJkdzkyU1VrWE0zcldwNDNmY1RiajVSSFVQSkExRGZVaVBwZnVpSGho?=
 =?utf-8?B?LzVFVFNSb1NJaWdDNkZna1ZoSk5neXhuTlJkZDNhTXBsVTRSN2hmQUNhVTMx?=
 =?utf-8?B?QzZLejB0Ui9OTm9nbUlFdnNxWnpjS3NBRjkrT09LbDJaeUZVSHp1R3FpSHRM?=
 =?utf-8?B?bWRWMVRMYjJySkliVGczRVEvSk5NejdRdUdqaTRxRWdVRk4yd01DT1BETll2?=
 =?utf-8?B?RTAwS09GTWZqNElLdWc2YitFSXU0YW5pRUlOcmNoU1h5aXRJWThZU2tDUTFq?=
 =?utf-8?B?ODdYMmlQNk1BbWlGNHA4MEJiMkY5Q1dncGJFWjkyQnZ2Ynd3S25hR2ttUkRq?=
 =?utf-8?B?dGF5UjlnMGUzeVhIckhCeW5KSkUvNjA3aFBqanJRa3BaZEhNemJ0M1dVelAw?=
 =?utf-8?B?OXcvZGp5SnE0dlVraHo3NmhtUVBia0FoZ0szczQzbWdYTnBVdG9Dc0tESVY3?=
 =?utf-8?B?NUpVN0d6RGV2c0EzNS9HUkFqb3RWTkxrb3VGNVV2bHhla1ZVYjcraFhBYllZ?=
 =?utf-8?B?SDJQV0xTUkZ6LzJOOUsxb3BJZTB0czRyYzNmdUYwRTFxdERnYjFSeDNoL1pF?=
 =?utf-8?B?QmxzSXhnbzFSSS9MZTZ2cXUzbDhNRG1mQlJvRVRwZ3loNU51SFhsbEhrS0Zz?=
 =?utf-8?B?R3E2RmdUOFlXYTJITWVvWlBnTzhIbWxyT1VrMlFadCtvSERMUHVXV2wxVXZw?=
 =?utf-8?B?eVRDbHVoZmE4RzlaSUlJT29OejB4cFR1cW5ob0luRG1jUjJjYlJuc3dGNTZI?=
 =?utf-8?B?N3dScktUSVlEd0tTV0R5TW1UaysrN3UxVTF3cWpYaWRpOTA4SERZRGFCL3d4?=
 =?utf-8?B?RW50eU0xUDRvelY5TUQ5LzliMUZmMSs5QVA0QWpYanpsSjlTbjN0MUJYcCtV?=
 =?utf-8?B?R3VJZjdPZjRDT2lNZzBrYm54UHlXMVNzbkorN3BaNEVTOUZyNm9jK0NOd0Fk?=
 =?utf-8?B?eitZYmtxNkJITUowbjU4TWVUWHNHZWR1UjlWc3pPc01kYVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akN2SWZjaTNwNERmZXdHVTFBdk9RZjdLb0hQYUgremF0RzlPN2FhdHo2eWFL?=
 =?utf-8?B?U2xJTzlLUG15WkEva0J4UkVsTGVJbTZ5WFhrRXoxMlpmSHgwRXpOQWJVcU9G?=
 =?utf-8?B?TThONkNmNExrNUt0TGc2a2ZaTG5jVm9NaXNIWGNTbzJMMmlxM0d1WVdtNFVj?=
 =?utf-8?B?ZTE1ZnpSK3VUOHNlQTZWL0VsRmp0T2JvNzkvUUVlOW9zb2FCWHBFbndvQ1RK?=
 =?utf-8?B?dXdya2hCc3JRVm9lQ2ppWExLMDdvbWJrOVlldTlIcVZzU2hOQk5jQ3JISTVR?=
 =?utf-8?B?SThYMXc0V2JWN1V1RC9TTFRzSi8rdENSaXVLVU1CUGpEMytqMW9xYnZUU2tC?=
 =?utf-8?B?K2VkbjQ4NzhwZEg0VFhhVkRieWpOOFBObzZWMERhYzNmWWs5YjZzLzEvTnpL?=
 =?utf-8?B?UTllQXZsTlhmc1QzZ1FxdUV4dGlkbG5qbWlPM1ZwLzduYXY5OVRCNVhaRWVo?=
 =?utf-8?B?bEN0NS9kU1dycklRbDlBQTdPZ3o0VHREU2FzOXEyeFZEWG95Y3FublV5Uk14?=
 =?utf-8?B?cHhKbmdTTVZGSEJIc3pwbnhkT3NXSkpPNkxqQXIyZ3JmYWIzWkpvQmxKWHpN?=
 =?utf-8?B?a2VZdGVHYjRicVQ2VzVHTmRKYmtHSDZMR0tkUVBqT2taSkpBOTBTVmVPRVk2?=
 =?utf-8?B?SHA0L3NqZGNjOE9DY1BzTmdMMEovQzdsYnNESXdBdlhoTGVNcjVSaE5VSVpM?=
 =?utf-8?B?MU52MGlNazlidEpxS1M4aGZmSTBsZzF4M3pVbkt4Zm5NU25DaWdXTlo3T0hH?=
 =?utf-8?B?RTYwWHFvTnQzQ3p1czZlRTdNMTVVL0k5eGZXT1NZL3E3RE9kSlhVdnNNYVVK?=
 =?utf-8?B?NDdET1NJN1dvSmtDTEwzdVdzTGdzckNtc2Jxa3RFV0NNdWhoazVEZ3NObCsz?=
 =?utf-8?B?ZlVKY0lGbVN1TGNBbjdMdlhsd0s2UFBGYnNQQStZeURkb3ZsSlpHeTVhZ1Z5?=
 =?utf-8?B?SUZTZXBBZmluWUNPdVFablpPN3czTGxkUFVmV2ZvSVNFemVBdWhJb3I4L3Ev?=
 =?utf-8?B?UmtMd1hYZ0k0c0ZSWGp3anBFR2ZTc3dMSHp6K3p0dGpuc1BISDl3NnNES1VU?=
 =?utf-8?B?YXlWSm15cE5aY3pqSERGZEtXSW1ha3ZLMzVuV2RHV0hEUmw1SzRTY1BkVDBY?=
 =?utf-8?B?b0NUcU5qcXlnVTFvRG02bkd3OXUxUzlMeDZLZXZFNUFSQzRCMDg5RlJqSXpS?=
 =?utf-8?B?ZEZPVzZYdnBTMDZsU1QxRUdiUFZxSjU5Wld1V0d2YUVOUXEyakhoK2VMUkFh?=
 =?utf-8?B?Tm8ySkFNb2I3bWhNclN3eDN1NGdNVUwxUjRJOWs4T3g0T05GTklzei9aOE5q?=
 =?utf-8?B?aGlhQnQ2YjVJLzUyb3FxZ3hDc1E2cU54NnQ1c0JhTGNIcnk3bWM2RG5STnhm?=
 =?utf-8?B?YUcvYXNTbE5TRXhoYXd6SlliMUR2UWdWZ1F1dmY4aWExS2d6SzY3Q2krRFJk?=
 =?utf-8?B?R0trMEYzR2ZqTit4alhwdWxySTdMWlFHeWhQR3BhRE5adTFPNXRWNU5CVCtu?=
 =?utf-8?B?NWtzc3YrSU92VndBdWV6Y28vOEw3aTZXd2VPRk1nQ1hmZkU3YXQ5TkdEU2xy?=
 =?utf-8?B?RGJyWkVjQU44OS90OVNqVG5rdm50UVlTaDFtVWhacjAxeXh5TW5GSFVUNlFW?=
 =?utf-8?B?Y1hpR29nMFVBYThqNlkvRFRFNjllUVNIVXVoTDdycEhtK3RXMmRCM3ErTW9i?=
 =?utf-8?B?VEFkQjFoTXZBVWQ5MXpaeHVOaGZzWThSdHFqOEQxK2JPMW80NUozSFZFNHVZ?=
 =?utf-8?B?Tit2dlEwTy9SUWtZaTFmQXlUeEh4ZEN4WGJYTENUU284TWpxemhobVpYVDE5?=
 =?utf-8?B?SFNoUmpmOFNocE1pbkdEbVAzSTJPWUxSSUI0V0RrWXpHUFN4YUc0bW52VlYz?=
 =?utf-8?B?SmowZkdRSnFKWDl5N2V3ci84Nm1uYk9sZThXSkZtaHdNY2FCTUZ3UGwyUDMz?=
 =?utf-8?B?MGRtUmxoL3pQSlYyT1U5QnFhNnl3VTNGZlh2UFZDOUx4cmM1aHNZNld1N3l5?=
 =?utf-8?B?eDJ1R2VhV0QrVUVXYUJFQ25iY1I2cm82WXNNUWU2NmUrcERkZ3ZZNy84OWkx?=
 =?utf-8?B?ME5HVVRpSjJMYUlNTlhVRld0RUdLaEk3SXJGL0oray9Vd215SnRwMnFpdklz?=
 =?utf-8?Q?HeHzTrRgk4bZx3ZrCwPel0vJv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ec5646-bb2e-4aa8-38ab-08dcb566517c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:23.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asuC4F6H8U1olOr4+MePEhD4ztb4oao9/4PntwhuApwCM3kVQQBuGAN1DQhISRAC2N+eAoTfD7eXXv0H0oLR5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Add #address-cells and #size-cells for gsc@20 to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb: gsc@20: '#address-cells' is a required propert

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 136cb30df03a6..35ae0faa815bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -364,6 +364,8 @@ gsc: gsc@20 {
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";

-- 
2.34.1


