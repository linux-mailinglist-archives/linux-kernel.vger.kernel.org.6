Return-Path: <linux-kernel+bounces-216841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3290A740
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D8F289210
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC619047F;
	Mon, 17 Jun 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E9UEj0r7"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E618C349;
	Mon, 17 Jun 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609583; cv=fail; b=mICANQ2lLpwxiHN/Mr3IEJb0GEDP1QE2g4AbbrDHceGMvPfWPxg1d/pxPat1zjt2pW0rT0QHcNq+VQPREZ1Q6ysWryJn4Dgswh45ozeOyT5CgqRiwMdpaGL/nV15C58txzeLzrVHbhv4HE+zuUI8qF0mx9lgJaluorQp1e3SZ1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609583; c=relaxed/simple;
	bh=qNa2B52l6St4yutINkZkBNVmd0HXujgcJZ6+WyHd8Hg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q7UJ3K8ziABnIoId0986GnsxiZEmilX4F6vJ0ojzUM89b3qC1GW+si3C3QyyITcVfY6pUpUGV2FAgfYweaD+2mwcRI3q/RD7zk+O74L0a6vQfVyn+AVFzQgLW5XamKB3NSLSiWbjYJo1Zus28K84G2EHHYjI9IXk18IFq/NoF2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E9UEj0r7; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aufwyn+3Pmxn8wLCtkd93iHVNvMnSa6kYldR6lzGRctER7+NOxxUe2bwNQ3m0+rUEu3qWTRZhuB7gG6sapSBpn42hxOeBWZiRcdMM7ZQHXNLdYUZSEYFRwpOcC/9FsSZwg6FE6hEgZhPCXXh0mdsqDsSfC2RAMbbfgV0Zo/nKGQ8biBoCFSyx2KuFdtR6t4ILPj2CfgNjzWPP0JmjEC2WKYLK+PpC2LcrrgZ5CQV/jhYcoR9gpCfN6UU03HTI5HjhaSAs/FJX6sjnzlYLTnnaP3kgoGTorjPSiMsRf1dJxlYH0XL2KxU14+LkHd3ctQAePjd6NWJoyXgyMdmrlnsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/7rU3b65eGWOyoHACt+HN50Cf+PhTufCPbNLsYNqyQ=;
 b=QGnBlr07jWjHxLS5vUljRy6qg7zE/jkqRdnU42hEyZGL6aSvXTEf/9itUzQoAyGmn2+1j8ghFvidLjgq8e6FpiosgDbRs4FPlBoM8WW7uS3Kr1930rijNB7fIbMIOhy4uGvR3ZUe48kpmDAc/n9tNv1DqauiWCOJOcNSvJ8GJEF7xYe5ngcc7eGvv3FYP14wT6wKQFFrqtJEKDY/qo6Cae/79EQYdEzEpVehyvG4Iiy4fBwezNR1Ugp6mNKgIuEH7h4D9ke8PEBk2SDaZjGwTChNIC6/T8npwIyZCeovfotB6t+RsTfiCPBjNFzyG6QLQPXb661rV+3X6Ob5l+OLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/7rU3b65eGWOyoHACt+HN50Cf+PhTufCPbNLsYNqyQ=;
 b=E9UEj0r7GY01fC22bj5fbG6w+wQZnSNc8R23zZ/KngQiQD4i4lQxthmbO5zhrsbUkq3qHRS0TyYS2Hgq+SHTtdMS8Hc33rLE2GLmQeiq/O4vv/RC46hQcMMiv+xMeitDqLDbG+ErxVW+l18mYgbrBmhLhupW0pV7/hY0CXwCZg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:32:58 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:32:58 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 17 Jun 2024 12:59:40 +0530
Subject: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
In-Reply-To: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718609402; l=5282;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=qNa2B52l6St4yutINkZkBNVmd0HXujgcJZ6+WyHd8Hg=;
 b=YWo0UvpYaqGJSaLsdWRoa40XmVt62ET2cUBvnm8cAemgJafIhbSjFg/8VfHL14NVeZmxZEJ71
 O6KMx7M3XU7B8DMTedHgjUc/3+5baEA4jizCQDkt2DLAhlj9hFyFoY0
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ccbd48-3e38-4e62-2769-08dc8e9fb5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uzk0elFQaXlNTnB0L2tlb2dYQlM3eHR3VEJFb0NsenVnMHk1NGdaQXcyWGIx?=
 =?utf-8?B?UmYzV3ROcXVNbWpSMVQ5cVFIVnVEbDEwZmVmMmRrVWppblcrNHc1S0ZHT2R6?=
 =?utf-8?B?M2JFRU1sakJzc3ZBcmhXSHdwNFVKcUFnSnppZFM3OWVYQUNGUGRmQUlXRmhr?=
 =?utf-8?B?YkU5bVBFdmJYSU5qanZCQjd6bXQzNFl1N0xVcEhlQ2ErdmVJd0dqQmRRcUtO?=
 =?utf-8?B?N0hkaE9SR1Z6SnRtbDNnOWJFS3YrR0Fjc1ZhcDdiNFJaUG53Zkx6YWc5QVZE?=
 =?utf-8?B?OWVzdFNrQTJUQmZCQ1crZ0ZRQnd0NUlINENhT1NmdzhjZDJ2NnNnYlVNUlZI?=
 =?utf-8?B?NGNKVTZ0VE5SQWZwTnJYdmJwSUVDdnd0ZHlsUW9QSDNLU0Mzekcva2kzVm42?=
 =?utf-8?B?SDVoTFJTMWgyZlBKZEU4T1dIZjhZZmhXSFFibHMydFMzb0wxTnRQSHAxaFhq?=
 =?utf-8?B?M3NMQ2F5cEtTZnBYa0RqR24rd1crVFBOblFxMThWM29EM09lNXRNUXVoRkZB?=
 =?utf-8?B?aHdkTUZIWUFPTzZxbGNZdXJQbU1ock5naGRWaTVuN2F3Qk1rLzM2c3A2azZU?=
 =?utf-8?B?bzBucnNwOFpWUmU4NkMvdGtOMEFSdXNnQ29wWXhtU3k3UnlQSng2dnJXMU1T?=
 =?utf-8?B?c05kT3lJRm1yQ1FhSi9Ydk9pcENoTE9IMWNVMzNSMjlDYXplTnNJT0haZkNr?=
 =?utf-8?B?dmJMSnh3c3NCMjEzU3FjUnRsSE5MaFRiNUJhM0dNVXYrRXZjMzcyNE4ycllo?=
 =?utf-8?B?TnFIWm90NDFxd1NUcERCWWY2eVBqR2hLZldBOEduZHJoY2hsR2VTNll2Z0dW?=
 =?utf-8?B?dnNLSTN6OUczaU1WckdqTEdJVlo2cVR6SWYyZUZTNVdiaGt6QzV4aW5FTE44?=
 =?utf-8?B?L0VmUjZEWWx2SzVoUUpnNUk5M0x2T0lSSVZrdWxuTjgxakhDZDkyZUd1Ujlv?=
 =?utf-8?B?dW5aZnQxVmRNZUo0dGFZMEQvY0czZUprdlVQaUx1RWxiL3hTb1IrcGN1bTRI?=
 =?utf-8?B?Z1drL3NBNVg0MW1CZnJQMkJhc0dXWmVOMVVzUFhzNzluby90MnA2MVhFNEhn?=
 =?utf-8?B?UEdsN295VGpjeUplbHI0ZnJXS1NFTHlIWkNUcnZ1Z0FxYm93NGI3Y09vYzJR?=
 =?utf-8?B?V3h5d0ovNUF0MEVBeGFaeWVhRTZYSVZBK3RaMG9oTVNJYWkwNjNTTGorWVpP?=
 =?utf-8?B?em1scVJ0UVhCSVVlVDZEajlyT2RDWmFTMzc5ZXF3bENxMWZVWnNlM0RoS1VY?=
 =?utf-8?B?S2FIS1VCSGZ2NzJDalFzWDRocjZQdlZEYWxyWE5VWTdVTlptSlJVRGhQQVNq?=
 =?utf-8?B?KzBQb1dFZ1lYZy8xalFRYVhlOTViK3NsYzg5aW94MUJVRFkzV2JOcHdRNSsy?=
 =?utf-8?B?WHFld3QxSUZIL2lBQ1ExY1l2ZFB1Q2M4TnlHRnpmbm0xWFNvM1dyWFBjbkhl?=
 =?utf-8?B?Qlo1Mk83YmFtWWcwNUx4VDdMaHhYdFpXN1g1RncvZENaTGdJczlaWEtnNXcz?=
 =?utf-8?B?M3lOK2YzdXlKWElPb0U0TGxLVTVBUGVuR3p4ZU8wVnRFUWd5R3hENTE5SWxI?=
 =?utf-8?B?TUZteThsYS9wZFMrYVQyZFZoMnJwdmtaK2pFM0hwWlBRcFZBNTllZXVuR1Fz?=
 =?utf-8?B?WXRlYVJtYjZ3Rk1BbS9qNHQ4ZmprcXBNNlgxb3MxOWdZcUpmUDhVeXUvQzlX?=
 =?utf-8?B?bmV6Mzh0VVVSaTU3cFF4L3ZGOVRSellPdURzZHdFNXlseWNtVndTcENrN3ZR?=
 =?utf-8?B?WWQxaCtMSEZURnRjU3kwS25WTlNkcjY5WDljeWo4eGZoaWNIQ3JPZGlGb0d0?=
 =?utf-8?B?c3BiR09sOFFPN2I3VjFZZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VklZME5GQnRwNFdwdko0Nk1La0czNWdGZW51S2Eyd2txMXlKUVZZcUhCNVIz?=
 =?utf-8?B?WFZTREVvZHloRFVjWVh1U2FQNXBRT2NJVlZhdlUrUFc0NnlQNU9mcTc3cndk?=
 =?utf-8?B?TEhrMFlQRjRPZTNKL05VUE9XYWhESlJhdlZGUXliWnBNUkZ4QTBIVDA4Y1dT?=
 =?utf-8?B?RlU0OWVZSFpFeisyS1J1NFh2dzJjZjVjRGRTQklRNGJSRFRQYmRlRHBQQVRR?=
 =?utf-8?B?cDErd3Q4SHd5dGhORUVtdjJKWThGM2QxZnk3Q3J0UHpWZTFGanduWmNiME1H?=
 =?utf-8?B?N3g5RG1WTDZoeFVHN0hiT2Eydzk1QzlOTUpTTmVVeUVDM0lKbGp3V2ZZb3Jy?=
 =?utf-8?B?NktrelRxRFVnWWJKMzN5M3FEMHZyaE9WNzlsaVhjT2QrTUJzWDczaWM1K2No?=
 =?utf-8?B?THhhYW1ZemJlSXBCYnd4bXRZU2dBOFlxSURiQ21NdVZ2WnNEdXptdE5ZSTdl?=
 =?utf-8?B?UzZOZHhQRU5wVjB1NmpKdUxLVGVoeGFzcTlFNzhwTnAzdTQzR0ZVb1V1aE5I?=
 =?utf-8?B?V0REZ1FoVHVGOTY0V3pqV0c5WjQ1aXExd1NJM3B3dDNxTmpzcHc3MHhTSm9H?=
 =?utf-8?B?T1dVUDZ0TzViU3dseDBOamI5bGRabmtYcW8zd1lLTjJKWnNpOXdsbUNNS3U3?=
 =?utf-8?B?eXlmSTczRW50QURxb2tyNlQwUnh5bkY1TFowY0xobmlQWFhWcVdLYmRZVkdV?=
 =?utf-8?B?aE00YjlDWG0rNTFZeW9adnFzdVAvMjZSSjlLQ0NJOEVlZlgvTFNNWjdwRXl3?=
 =?utf-8?B?TVRkeHVLNXhid2g4dmdydmVUcGNUNDJUNGF4UzVoSWY3UmpUQzEzUjd4VXd1?=
 =?utf-8?B?SkF5dHBXaTJyUEhxYlArQkFDSjcrT3RmSmFkbkZ3c0xsQ0FXTGR4TlZiQU1z?=
 =?utf-8?B?N25CTkJhRUFvUE9kREtxSEZQK0VwTVpIb3dFYmVvTnJwWmdzdVlwa1drZTMr?=
 =?utf-8?B?V3d2TG85Rm43Q3lHQjNGSTRINkhwMGRLWWdwcExGVExLMHpRbDF2Zm5DSzFH?=
 =?utf-8?B?K0oweVNFNGkrTDVyQXVyRGdzeXFUOHFIMUsxZWlWaXlIRExubmZ6VWhxR213?=
 =?utf-8?B?cjN6QldmV3JYalBOc2tqbGVZU2tUQldYNVNNcFVtOS9Qb1dGME5Uczlmb0c4?=
 =?utf-8?B?eHNXeXBNQVdDZ2FLUENjdGNub2E2UDh4OG9PWWk0SjhPaUsvR1lBT28rZzl4?=
 =?utf-8?B?VW1yeHh3dVlvTy9BUVR5b0NWelErNXZnbFc3dk1LeWxFK0FDbGZQQ3lXNUl4?=
 =?utf-8?B?dndIOHJnM1pLU0diUC9yRS9xUCtzRzhsckF2R3ZGZnBrSFE3NU9tL1dTTktX?=
 =?utf-8?B?R1dQS3hEQ3ZWRDlCREQ3N2M4WGR3ekFOWlBMMHFJVExpbXJUL0xVN2lBRGNk?=
 =?utf-8?B?UDFZemJ1c2ZLdElXTmJUaG8rR3F4bHRyMWxHbnZZYXR5N3IxMkRlbzdtNXFU?=
 =?utf-8?B?dCtOZGlyNmxjV1h2YjRpTEJ1TjhFUVdMQURlMXRUR0hpd3J2dDR4SnBkNzRa?=
 =?utf-8?B?dlR6OVVMaDJlcHdoNnh0V1lRSFo0N3FYUXB1ZDd1RVNQRDdCMEtVYkhvSkJs?=
 =?utf-8?B?YVVDZ2FEalA2TTU4bDB0c1pUWi9ZSWtZMDAvdmx0UWxWZytVbGdqYndQWFNU?=
 =?utf-8?B?eW9QZm00azI2NnNsZEFLMENHaXZIUFJhVVJod2ZpVjBUVVFzeU41SXlkWFcr?=
 =?utf-8?B?SThGdlFMa1FQWGp1U0xkREZKQitvd1FyN3VScHIySEVkVm13NGFRNHpSRWI5?=
 =?utf-8?B?bkcvZko2V1dFMUNWVlFTM2hQcytUN1g5VTkzNVBHRWplbmZpZFlLSXlNa0Ry?=
 =?utf-8?B?aXZ5MlhPSjVkVGZlSHVZYW55Z29lRlZiOFY4aGlYd1cvUFYxTERVWGV1bTJZ?=
 =?utf-8?B?ZnRLRm42eDR3T1hKQlhBbHgzSSt6NmI3dW5vZWtOTjFrRTRkQXJGN1V1cXBW?=
 =?utf-8?B?ZVg4SE5lZmhDdTJydGRpWndJbk9JTzg0eG1jbEErU3lGWjJmVnRSNXZRY1JK?=
 =?utf-8?B?dG81YWpKVFB4WEl5UGZxNzZ3VWozbndsMmd4elY0RXhqREdZcGNJbXo2dHBJ?=
 =?utf-8?B?UlA0QU1NMDdqWko4MmVlYlhCY1Z4aGNEQVJVeWJWWnpYT2ZNaFZ5MXRvamdM?=
 =?utf-8?Q?E7MEbgp/2ojvN0bWa1t9EcTf5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ccbd48-3e38-4e62-2769-08dc8e9fb5ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:32:58.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3G1QzvVNI14uYAiHNHeKM5Wpl0jZL9pUoM/+uoOoXeXocpgigTIAD50p3rL2oplZ7PE/1lJEyAWJZu/G3Sz2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7982

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 160 +++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..60ad1c4a3dfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves is based on the
+  messaging unit(s).
+
+properties:
+  $nodename:
+    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - fsl,imx8ulp-se
+      - fsl,imx93-se
+      - fsl,imx95-se
+
+  reg:
+    maxItems: 1
+    description: Identifier of the communication interface to secure-enclave.
+
+  mboxes:
+    description: contain a list of phandles to mailboxes.
+    items:
+      - description: Specify the mailbox used to send message to se firmware
+      - description: Specify the mailbox used to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+      - const: txdb
+      - const: rxdb
+    minItems: 2
+
+  memory-region:
+    description: contains a list of phandles to reserved external memory.
+    items:
+      - description: It is used by secure-enclave firmware. It is an optional
+          property based on compatible and identifier to communication interface.
+          (see bindings/reserved-memory/reserved-memory.txt)
+
+  sram:
+    description: contains a list of phandles to sram.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to the device SRAM. It is an optional property
+          based on compatible and identifier to communication interface.
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+              - fsl,imx93-se
+    then:
+      required:
+        - memory-region
+    else:
+      not:
+        required:
+          - memory-region
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+    then:
+      required:
+        - sram
+    else:
+      not:
+        required:
+          - sram
+
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ele-if@0 {
+        compatible = "fsl,imx8ulp-se";
+        reg = <0x0>;
+        mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+        mbox-names = "tx", "rx";
+        sram = <&sram0>;
+        memory-region = <&ele_reserved>;
+      };
+    };
+  - |
+    firmware {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ele-if@0 {
+        compatible = "fsl,imx93-se";
+        reg = <0x0>;
+        mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+        mbox-names = "tx", "rx";
+        memory-region = <&ele_reserved>;
+      };
+    };
+  - |
+    firmware {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ele-if@0 {
+        compatible = "fsl,imx95-se";
+        reg = <0x0>;
+        mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+        mbox-names = "tx", "rx";
+      };
+      v2x-if@3 {
+        compatible = "fsl,imx95-se";
+        reg = <0x3>;
+        mboxes = <&v2x_mu 0 0>, <&v2x_mu 1 0>;
+        mbox-names = "tx", "rx";
+      };
+      v2x-if@4 {
+        compatible = "fsl,imx95-se";
+        reg = <0x4>;
+        mboxes = <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
+        mbox-names = "tx", "rx";
+      };
+      v2x-if@5 {
+        compatible = "fsl,imx95-se";
+        reg = <0x5>;
+        mboxes = <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
+        mbox-names = "tx", "rx";
+      };
+    };
+...

-- 
2.34.1


