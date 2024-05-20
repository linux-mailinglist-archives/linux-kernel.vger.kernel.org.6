Return-Path: <linux-kernel+bounces-184166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639DB8CA376
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B621C215DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214FE139D09;
	Mon, 20 May 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lw0zs6bi"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F425139598;
	Mon, 20 May 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237714; cv=fail; b=U7gF6FnK+z8nXR6I/KgLr5et23ZHc2SW/cOX1lXmiN0gu9hLckDan+S8LvpcIEEoA1Ml+mHDrstsL2t4xr9tTd5zWMYAo1pDto+LXkJsq/ATPu99jJYiY2u1cjjQajcl6mt8XJz1+z35XSV+PTmn9Q6/tiHsp/b1doZQghnpkmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237714; c=relaxed/simple;
	bh=JwGx697XmhyOEReJYlxNAXPC76ESUuBCrCFS3Eb91Uc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NSY5kIThN/WaLIy5bdAn3p31zeF4oIkd0OU8hL8LGq7CIZSinlkMQgd986Bsvaw8vZ1roUAOAbVGSatGD+PkbzU8Uk44X3ec3C494tKxXFPk5GgAKUK3WlylOemfKn/QGmejf37C7HoE6UhAFU0rOt7Nd5lbrxShmYCk36QCZJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lw0zs6bi; arc=fail smtp.client-ip=40.107.7.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcfGl9odiKIl46fcVo5AIwoV+dycBQ4rF+AMXviFdZFpVS1rOn9ko7H7n8KYNCCmLcCNfjfmW9v+ivurqzotziYwzmPTzMBaNHV9Uo44UhWoCpYIfIWAfDyae52c/jFElT7u66/a5vahRPbRngbJrCuE9w0XQceSYisoS6Liz96ecJDc4KxQIA2W3uI6wFLAHQ9jC2PgsNbqwlDQ2YZeMj9V6LUgrBH8stlRZrhGZ60Yup5BQPPiOK4gRpBwaB9rD1Ys2tpQ7+UiOMmJQiQnlhKQ/x5hzkbT7NSyEFLMrtznXOW+ulxnZyZDcdnrSMR2weXI+N2lP9wWsioPQ+Dnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFgpGlCRVbXsHuwYnawnK7CfTnCbNyuoZCDUMYwnSsQ=;
 b=GSkcrnwpIIulQv0z2EuGkjbNrsBjRenjeDiXFagwMzygjhySGzkXSkzmN5UPZBpPZXUTRIvSloAFiSgjfsfcpm8iPjkAA3HXqOzp92oNIYIG521OPrRsY6sXlk6mieHpfsDPgMP2RDe8pu/W0cVFkSPAx9bA/zmjWJm9QJEp4yUx40XfUJSPMwUiMX3mP0eyCcxXpWg1koJSYSp3RbgO2JQhLEGON/vSLbdpOGtfoyJqt/it1xRMwF0Y4ydXOEdaqNbwpz+szOYU4DWjPGuEC+UP30KyZztSgw8ZTDKDXOA9FfE79CZKOYbP03Whs1hr5MPATClMZSLRSQoRGu6Bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFgpGlCRVbXsHuwYnawnK7CfTnCbNyuoZCDUMYwnSsQ=;
 b=Lw0zs6bi8PB69KFwViuJ4A+updsyCi1/tvCxl9wtnCmBk8Aa8BAC3j0Obiwrl+sTfP8GHpsHkrbjase6/LablmKoNPCsF5WyBGv6LI2a8ecDnpfOQYTeGpbpk5iK6hD4tTEjYGgipT9wgtmmBr7Pg4okp15A/zgY2HGaMxqW3Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 20:41:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 20:41:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 May 2024 16:41:31 -0400
Subject: [PATCH 1/2] arm64: dts: freescale: ls1028a: Remove undocumented
 'fsl,ls-pcie-ep'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-ls_warning-v1-1-6851155356c6@nxp.com>
References: <20240520-ls_warning-v1-0-6851155356c6@nxp.com>
In-Reply-To: <20240520-ls_warning-v1-0-6851155356c6@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716237705; l=1411;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JwGx697XmhyOEReJYlxNAXPC76ESUuBCrCFS3Eb91Uc=;
 b=Ysoygs5kU89/Sj+ytEHUejqmyct3AOzvf4FhDC8S/feHL0o+uTkowXjchA38MStuibSAVnd1f
 RLyoC4vxF5mDrsERhj10jg4dlGC2Khij09p9vPNA6Hu5LpEr0YoetgA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8a0c8c-6f46-4bda-520d-08dc790d462d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NklobURhR0NaZkZHV3Z6d0g0Ky92MmJwREEybTBJS0dhTzdoZ0ZOSUVFeFFl?=
 =?utf-8?B?dGF1ZnFNbjBnRWs3MHg4MmVuaW5id1Z6T3JGbldPNHBSNmcyUnpqcjVHNFIw?=
 =?utf-8?B?WDZwZlpQVUdVSTVDNDJQTTBvZEpXTDIxVW5PZGJXemNLVUh5Z3lMaE9obUNN?=
 =?utf-8?B?elRBL1l1dmgxZm1Vdm8xblc2T2NvRzQwZ2RoWlA5QlczL25raGxXSHBWaHV5?=
 =?utf-8?B?NUdvSnlxUk9hVXcvTC9IWExrQVIvSjhSRGN0K0NlZUo4OXVnQitvL0NYRXJS?=
 =?utf-8?B?VXhLaExKTUZUYTlJZlpaajgxa1JpZm1LQlo5alNWSjhpWUhPQWQvQng2eGFw?=
 =?utf-8?B?WldlTUwwSHRGbVlXZzl5c1EyN2NVdlE3eThCR2t2cklvbHJBaXZkdnY0UGhl?=
 =?utf-8?B?akF6NDNuU3pkZ1RMdXFqTVQ5UTR5WFFZR2RNQ1pJWmh0WGdOK3luNE1ZU3FL?=
 =?utf-8?B?dkFma2x6Z0RydGk0WGFTWWxIclhrc0V1YzVxZ01Za1BtNnpIaVJ1UHEraDdB?=
 =?utf-8?B?VzdEeDJPMVFmRk91ZTNHWmUvZmZYRkdwV0pFaEd6dWhhUTVwMzZXOTZGL0FJ?=
 =?utf-8?B?QmtCcG44ckZWTTBHWXdBZk5vM01mNGJzckhVc1pyemRYNWNxYTdTeGY1YndB?=
 =?utf-8?B?Qm4zd2JybkVSWjNwS0Y3WHVNLzNFdTIxNmZwY1RvRkNJM2F6SWQ1TDU4ZGp3?=
 =?utf-8?B?cDB1MTc4Y09WaUs4bUlEaEpMRHQwT1pXNlNYV0RDa3VZb2I2Ry9oQU96dmZ5?=
 =?utf-8?B?UlNVODNtd0JuMFVkanUyWStDSHpodVZHb1hSR281VFBHM2wwbG1NSGNndzdD?=
 =?utf-8?B?VWpwYkFxN2NLaTkwMUZ2eDJoOUt1dU9LMm5lZXY2cWt3N2RWbnlRbi9JVVJm?=
 =?utf-8?B?VXQ3cWRHanpaWTZmRmtxQUVkVml4dldQQjd0RGRubWpTc3ExTkt4aVhRT0h6?=
 =?utf-8?B?bzJPWW5UeTFocG5NNUhzaWNBcFgrTDkyNlNjcHl3cGRXUW40aUdXbG1jY3Yy?=
 =?utf-8?B?cENPdTBhNHpaTUJMazIvQ1psL3JpQ2J3TElqMDY3eVJrVm1CYnF1cWNaeUU1?=
 =?utf-8?B?bkUydFZEblFjS29IcXF5clZJK00xWW1PSWlZQXk0c3R1REt4cE1FVWx2VDk1?=
 =?utf-8?B?cVcwY1hyWThwaFBDdm5Ub2kzbDNIanIySVNQWHVvUXN6aCtuT21GZVYvTEhN?=
 =?utf-8?B?ZWwxRG11eVp5OTZtM3RrY0w4SkcxWmc3NlF0VEVpSWd1ZTdmZVN0S0NWak5u?=
 =?utf-8?B?TUdaZ1pwblV6SFhVRGI2ZVNUOE9tVFlhdE9zS1RDMC90ZWJyM2QwWCtzNmxP?=
 =?utf-8?B?KzRGS3lzbllSVXFNbHY5SC9vSythSDQ3Q0Q4K2tGbmxZeWVKTWIwVHRMbndp?=
 =?utf-8?B?aUp4aC90WnVPK0VaTE5BeC8vdjRIK01KV3VqN1FFMXgzNEoyam5mb3MvMlhB?=
 =?utf-8?B?ZTRiVmpKR3h4MFpFSVBnMkpKbDlrQS9HbW9YM21UTGJPZFp1bHFRVWZnaGpm?=
 =?utf-8?B?YmNtd2lGS3lJVHkrZmdZSTdBM3Q4OGhhQU9Rc0xWWFpvZmpUUzBORUMyL3N3?=
 =?utf-8?B?MDVGRFllc2J3QkVvMThrMzV2ZFhBbFNRMnFvMFlQTG80OThuZmZrZjZ2ekpJ?=
 =?utf-8?B?MmY1L0I5ZUYreUcrTFk2cFpBdXhrMXFLajY5MERnK3VVMnBVTVRqcW52U2FE?=
 =?utf-8?B?Sk0vSm9vbDBkajFGNUZ1WmNZRjF3MzVIMTV3SE9FY3c1VXBNS1piTWVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUR1a3NVU05zRm9GcXh1eHovK2dhY3RhRkxDTHRvdUVhdzhGaXdyc1dSRGJN?=
 =?utf-8?B?bmxtL1FRbXoyRStTc3BBQThjSThFVUNXUDhnUnFaWEptRzVuQlkwdFhicmlM?=
 =?utf-8?B?cEg0em9GQyt2SFBwMk96R1B1T1ZyY1F1Y3kveWs4QXhLcXB5bzMyaEdISTFV?=
 =?utf-8?B?SWFvelpxbm1QWi92NW5GeVRZZ0xkdHdKUm1ZaFRzWFVReHRHQUVBWnhQdGt4?=
 =?utf-8?B?Z0tFcFNKaXVhN3E2TDlVUGx2Wkk3bCtyTGdTVXdiMS96Y3NYYWFkc2xJbTB1?=
 =?utf-8?B?SFBoMTFXTkZVRjhmYlUrZFBqU25PT3JNeGtFcUJDd3JrUWVEVGIveE56dVNz?=
 =?utf-8?B?aXlVMmNSa0w1RXhLVk5zWlhUZWxrNUFBZWRJTEdubDFuVWdYeXJlalZUYzMy?=
 =?utf-8?B?UVIzcnFrMk1aT2VNeWwrb0hMZTdmUTRLb1N0YVBpTkJmWkFNUFpiaE0yR2dt?=
 =?utf-8?B?dlo0OFlUR042aUpvSkhYem8xNitmUU02a1hzQzRFTjQ5bzhKemRWNzVrL1Av?=
 =?utf-8?B?Q2l4M2VtUS9ybW5OUmNYazZxd2lxVENkSEVGMDlneDVncEdlVmFVa2ZvRHpv?=
 =?utf-8?B?V3VRVEtOMFI2TUNvL2tXbHpPOTU1aXViR1ZwN1lFN1ZnRHpQQkFveGFyNXdV?=
 =?utf-8?B?RHZYQmpZeTR5QjMyTFRJK0NrSjVqWnhYNU82M2RzMG1wOTF1czFvSGJqU0RN?=
 =?utf-8?B?aGwwdWJ5UmpObFZNL0krdUY3bVhGWFpET0QrYzIwKzZLWlN0WVVqUFU1a0N0?=
 =?utf-8?B?dXA3U2dHM0lBSlVKY1NFalJXdi9xQUZuYlJNNEtlKytRZ1pMWFFYNnZLL2Y3?=
 =?utf-8?B?cUM5NnFsRFgzTnRQS21VclZ4dTRta0hNTllvUGt5L01JTEx3U1BKKys1YUMy?=
 =?utf-8?B?UFpTd2dSWnJ4dis5Z0lwOThJam9WWnJmTFdReTV1WDM0THA5dzNvTEFPYVpF?=
 =?utf-8?B?bk9xV2tKVmExK0g5ZEM4VXA5UUxPVldLcG9Tck1GK0oyUFprMDhsUEVOanlw?=
 =?utf-8?B?TUxtMHJlUkZTWW1sSTdCZzNuRXQxWW1kUlBjeTFyUlh6dmFEOEpQMW44RTZ6?=
 =?utf-8?B?aFJBK3dodGJKdFRlMXRVQ0ZHQlZLUmlNbDZvYkV2RGxvUGZ1OHVkUDFrREFK?=
 =?utf-8?B?QjN4azVuRy9Rei9FVHoyVEtZYmd5NGFkTFBFNEE2RWJIRHJ6OHhvemcvZTRG?=
 =?utf-8?B?Y0VHeG5sNnNNNWZrWGNIR3Fnd3ZBTG1ZanZkeDBta0xUeWVaa1JBNk44U28r?=
 =?utf-8?B?eW00QzFIdVpsU0o4cUxqM281OGhueHFXaTQwYXcvOHczWit1NGFrK1p3SDVx?=
 =?utf-8?B?VW14WGdOY1YzdXFzV3hQUG9SeUd0MlQ3QUZ2U1lQSGhYd201ckQ5OG11MXRP?=
 =?utf-8?B?bTgzcWJNQjFkeGpYejN0bXc2cnRnQXM4QksxR2p3SEthOWdZY0NOb25iZUdu?=
 =?utf-8?B?SC9CbmVJdXJweEVsOWdJeGM1ZzkwY3lzbXNMdkpKaE1PTkZjUXUvUlhrUHY0?=
 =?utf-8?B?SnlKT2JXREY1dUMvTjM5SmNJa2cxSzE0SHNOa1A0aFBwS3A2dm5YbHc1ZFha?=
 =?utf-8?B?c2pJSzJNUldNUy9PdDE4MjZGQmZ1SFl6M3V1Yyt6UXJvYkpqRHlsQ2lsejFQ?=
 =?utf-8?B?b0ZwNkY3MzVIeElOUm1WUld0Uyt3bGx0cEVFSmI3QXdnNk1VdXRFdnkySm56?=
 =?utf-8?B?aWt4akJzaUR0azRrK0lETGU5TjMrMGgvQzJkK0RNazVuZllKaHlBSm5sWGFy?=
 =?utf-8?B?SGlNR0MzRWJKS0V0TC9IWXJ3ODdEZFV1TjM4QmFPNDArSXUxczA4ZnVISmN3?=
 =?utf-8?B?TUMwS2Z1Z1o4T3NTcERZMGd0YlZEL3FGMlM2MkVrM0MxTDdvVThPQW9TVlpv?=
 =?utf-8?B?QVpVVjNSRE1Zc0RQVVZ1KzdnQ2R6WWJVU3lNaHhuOVZYeXlaUTdPVE81UkZu?=
 =?utf-8?B?TjBxeEJuYk1JdUhUdjdleElVbVBzVXZZRGNzZ2tVS2tERUcwMHB0cy80am00?=
 =?utf-8?B?ZEJ4UmNTaXVTODhaTHFpY3dxV3Fud1VTVHRJYzlDSllsaE8zYVAxREdwQVJO?=
 =?utf-8?B?dm8rZjdyZkxFdUdIRURPNUZtM1dWT0U1b0ZMdUVUVXBoUmJmbFloTFV6RDdJ?=
 =?utf-8?Q?/b2ZMl6g+kwfRhJdd4ZPhWbta?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8a0c8c-6f46-4bda-520d-08dc790d462d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 20:41:49.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/J3NGI/W5KHhS8Oz/A6bbBUOMWe9j9W4A01pbwo28+88Sd4wEdmG4MKqPzOyJL5l6Cr5KxnJCK/Zj1xfhR9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385

Remove the undocumented compatible string 'fsl,ls-pcie-ep' property from
the ls1028a device tree source to fix DTB_CHECK warnings.

arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: pcie-ep@3400000: compatible: ['fsl,ls1028a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 83d19d040bdd4..f8b19b54e2afa 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -674,7 +674,7 @@ pcie1: pcie@3400000 {
 		};
 
 		pcie_ep1: pcie-ep@3400000 {
-			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
+			compatible = "fsl,ls1028a-pcie-ep";
 			reg = <0x00 0x03400000 0x0 0x00100000
 			       0x80 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -713,7 +713,7 @@ pcie2: pcie@3500000 {
 		};
 
 		pcie_ep2: pcie-ep@3500000 {
-			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
+			compatible = "fsl,ls1028a-pcie-ep";
 			reg = <0x00 0x03500000 0x0 0x00100000
 			       0x88 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";

-- 
2.34.1


