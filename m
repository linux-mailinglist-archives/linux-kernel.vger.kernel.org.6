Return-Path: <linux-kernel+bounces-349534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3144598F7EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1CF1F22C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6EE7E0FF;
	Thu,  3 Oct 2024 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X0FUVkdo"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013041.outbound.protection.outlook.com [52.101.67.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B12149C41
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986489; cv=fail; b=DGp2P9nRCchbdWK4JjNFBXsliAYul1b7yrDh+NOQ32onzEDVPhJfI0kdX6YFmhvzvI4afOvwcXD1KrmjxMgktodpcmsmqbudQrTeF0OtyYP2OKBvFtZ7lii00qfiFSGOzG8OWySDofxmHnK0smEOF1iFQG6dgxuhnHD+UfsQxJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986489; c=relaxed/simple;
	bh=1vXOLZgsQFMbuKD3plBcCWtNrrRzSd/JO0oImYMerAQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Z2biSFpV7VF8h/+h9S7+CdbV6S973ngR2KGTKgLM+Na+LFZgey2EZbyzUX12HLenCNZmr2uteATzR9UoJGY0/pwWaO8jG68uzpA2GPHXysk9tZAtva7Eb2KhjqVTEPAH+N+WqbcOnWZSdkZqyfy5P6I7lVxFKdPiE7kWp7GNJPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X0FUVkdo; arc=fail smtp.client-ip=52.101.67.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjyKE2ucAaBhMvkKuz6mxnLCf7JhROHITIZnvDiY/ezHTTqkH8Di4269II6zEsWs2/ckzI+GiKqV1G2YFKomdTiPBMrgil+fu5O5fZzV9YiKbzF/1e82kGKZZM/E6PM/D3FpVkX0K+LsAR9HhcpTTioBsYXrZFpWmNP9U93sbNAu91Xza/dJ1dyHrejI5IXTC5NpTyFkqiL1tcLO6bC9AaUTu8531HdRAVzxabFUkfvuYMyMFaVbZOiDFe5h4/9IxiYuCGtVZEZIbGui8iXY1bbOS3n5oW4Y9+gjf5JmIvZQT0xrZqfS7/jKuAXVpabO9xCBloouYBf/n+Vm7mspTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/u6Y9ZMfX/Q1R8ZZt0lGNOvoJ+yV3wXF+hGur9mRoI=;
 b=hycc2sexGHQIbq27etK4eqcjO/a/VF34NE+osJpu7TBkAcubTnh1hZ2ff9sJZ7MoSsVfGqhHi3pG/hiaOy/hSohQI8n6c/B+tBTbx0HZxh5/OnFKhU4cjblHGUBMfcTHEzhjl/t/0K1tKAM3W6o402un4R6YsRJwpgch8BeJ8eQBAZb1Qx1+ay7wyvpiLWDJW2R349xjheaWnqe5S3lkSY38gvPZdolXp/+/snZ8LRJw1HqQq3Fcp1N6HDDtPE9/TGBmjyXadV4TFyrH5h5RWkUxgZEPnIY8lMjG3J+qktVj76tdO/EZXRKckVgvdXfqlPqAi3+ABPv9mePUn37ZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/u6Y9ZMfX/Q1R8ZZt0lGNOvoJ+yV3wXF+hGur9mRoI=;
 b=X0FUVkdod8Kcvk3MgvIphLPjeAeTzIUi4PwGoQFmhkDujQVzcAHrLIUSZPX3ItiB6e4fAS/dM70Aayu5VNzYLD14QSTLt17pbEwsBZvY7dPY2wmSpiHUKK/7ccKUzAvKgcEexp3psI/WXKk7iKpIrCnh7JZnYhrjoFdyLBELLGbGot/QAO4X0zDePUGHT7PK7WCDlKZ2KLERbcg4e0Wjd1rlH1ZEXYzptT6iomT1UbVCQx4QKUzlLxCZIih0EAl3RdxyGFAR4jetqRSasz9EiKmSIiYvbntnXEkHgpHNVgk1I4DbsmRq6pn1sHDpgGUPyv60gvKRhuiNuLJj2IFwLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9291.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 20:14:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 20:14:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 03 Oct 2024 16:14:19 -0400
Subject: [PATCH v6 1/3] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_STATUS_BITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-i3c_dts_assign-v6-1-eae2569c92ca@nxp.com>
References: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
In-Reply-To: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727986479; l=2146;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1vXOLZgsQFMbuKD3plBcCWtNrrRzSd/JO0oImYMerAQ=;
 b=YI/N+PJitl8UKnhClq8Ufr2kkVTjpnW1S7QpbfEUQsQlC0/gAnDnquQVjzIxnif+qFlZiNOUO
 MJuNXkbBgXMCmeqUCRVs+dMFNdZGB2qelW3O0lZVVD4ySVoxFlToHTN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 965ea561-7185-4716-dd25-08dce3e8063f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SmY3WlhyNEd2UnBGLzZNYnUrelIxOElwWHozRUdaZVpXd3JtL2NYVy9PY3p0?=
 =?utf-8?B?TUh2K2NDY1B6YTN5MnpSNkZhTEhWbWI1ZnlBTUF6YnorVnFXV3M2K2JOQXRN?=
 =?utf-8?B?TWpDRk0veTljUkx0UEpISXdmZERUdE9Kd2dZMFZDN1BlTy9wZjdsVFFjK3ZV?=
 =?utf-8?B?Y3B1TzhoQ0d6ZU1WUDVFaGJrUVozRUllazhOK2xpd2ZFWStGbUpmV3puWDVx?=
 =?utf-8?B?bS8vcTNtV3hCZ0RMNWJiMTAvczFRVEJhZHcrMlF2LzkvSWtWRWMwOXBCVFZI?=
 =?utf-8?B?N25qbEpRemZpZk5jdTlOVitJZXUrVTRpeERvSGxqSVV3SXVPUHhLd0RiZy9F?=
 =?utf-8?B?SUtQZHk1bWxSZUFFZXF0OHAxTEhSNU9DZ3JJeWpJK3plekJPKy9NK2x4Z1hV?=
 =?utf-8?B?M0k3WXpNdy9hbHdLOFFxOGxkK1JubXdDaUpQT0FaYkMxbGJmSEMrTXRCQUZp?=
 =?utf-8?B?UHU0VTFvTVZsK0VjL05ieFpDVXZwMDVKQlhPM0NZb29qR1E5SVVyanhrakM2?=
 =?utf-8?B?MksrNTIwMndNbEtKMG43UDJLRytzMTFYcmNiV1VObG9zcThwelRrQjdtYWQ4?=
 =?utf-8?B?aEh1Vzc0ME5CMHgySFZ4MXZQOGxGV3dETVZMMXp4UmZmUW1IS0JuS3h0NG4w?=
 =?utf-8?B?UXJOQVVZc3pUVzI2ZldDUmhSVEtJWE5GY3R6ckFVM0JaVHVNSUxGaUVadjJ1?=
 =?utf-8?B?QXAvRGk4SzQyRnNHVHRFTW9aWTlZOEQxbVhxR1J2OG04bnpQUThodmJmVVVs?=
 =?utf-8?B?WmFjVjRsRklaMmVnSnk2d3ZPdnpIQTlJSnhjb1Z5Z0xYNWU4QmlnUkJocmhF?=
 =?utf-8?B?bW41RjB2S2dwQnVOcE5nQzFQMWFLTVhxZkNPOENEMitaN1NGZnJ4VXFwQ2Nk?=
 =?utf-8?B?a1ZnSWI3ZFJ3Wnd1S0RhUzZHa05GOFV3QTRFSkRrM0twRHFBV0hKUFJ6UlNs?=
 =?utf-8?B?U3NMMFJoMjc5M3RvcjN5dFFaYWpFeHZZWmZndkR3OWVwWUNyVk1sbXl3VGpH?=
 =?utf-8?B?RmRRcXRaeGRyb1BqSHI1VXdXZndadWxWV1VsdCtRSThPUE5DclFuZE9XTlV0?=
 =?utf-8?B?MHUzL1lmSzdTNllvMXR0ZEUwcjg4cDJxM2xVa3FhOW5ESlpmQjFUTEZxYWtK?=
 =?utf-8?B?RmJwV2lxZ2NNblBIQm5zQzZkemtFME85NjhybFFkUTdMdmlNR25WOUd4MytC?=
 =?utf-8?B?SjlERVFORjIyUW9GVEx1ejFHaW9FZW5YcU5nd2poUTBPWkJoWXJIRjB6OWN2?=
 =?utf-8?B?WDJ1V2h6TUtTR2xkZ3paWEk4eHgxSHhhUW9sb3I2eGVxVTlQMExIVDFXaWdV?=
 =?utf-8?B?Rk1XSDV4TUdhMThvL0ZQUHV6bVRYWXlzWGEvckJlUE04cTR1b2dlNy9Idlhj?=
 =?utf-8?B?ZkFWL1lweW4yWVpHWEtSR3JRcGlsMjJ3UU5YbllzV2JZbk5qMXNIaWNZeE9x?=
 =?utf-8?B?RC82VWFQeVloRzExTXhIeFNnVlQ2c0lhNTUvL2lBRVZrb2ZVYVhDQzF5dmQ2?=
 =?utf-8?B?ZTNKTklOY0xFMWluTjcxdTVqSnhzYkM2Q3E5dXM3QVlRLzdXNDV3MHR2cEN0?=
 =?utf-8?B?N1BqTWRwYWVXN1ZqTHg5Z0lyb1pPNkVjVmE0RnRFVXNZWDVCV3BRSXE4aGFQ?=
 =?utf-8?B?VzVycmJxcStOZ0JkSmpSN1J0am1pZURxQnRaNEdlSnE5VVp2QlcvVjRKY2ta?=
 =?utf-8?B?aDZHVkVuSFV3Q3RwOXNZRjh3S2hTNUNjZ0JXbXYwM0xQT3lOOXFkT0F1VytR?=
 =?utf-8?B?QmV4bVZzNGhpbFp5ZllWT1Q4ZmMyVnZibDQvcEhtN3p6bk9lRG9rTmk0QS9R?=
 =?utf-8?B?U2pDWDcrRVZiaVd3Yzkydz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U2FPbUo3R3hPTUxoUFNKUi8ybEZWWDErZVpsQnpMUUw0RVB2TGR4b3pTd3c4?=
 =?utf-8?B?dkgrVEcvR21BZkpZTEY0QzlhaXVwblY4c01EWGJuc0pGY1dWZUsxQTNucWgz?=
 =?utf-8?B?R0w0NmVsQTIyZWdvUlIyNXJDeUJpdys1YTkyazNCck1EU2R1VU9uc3JxT09N?=
 =?utf-8?B?OGNvblExYnNTN0dOeXY3SVRBOHhsNFQycERMVXRQekZZMHJZYVJ2eDlzZHFN?=
 =?utf-8?B?ZjMyZWQ2SWxyUHU2NFFtdkUxTHR1MFp5S2ZxNFp0VVNDMEJqT016U1hUeGZr?=
 =?utf-8?B?aFNpcHdZVXVZei9MUEtxKzlWcnlQamFScCtvUVRGbU1DR1J4SjJlaHpwYTZF?=
 =?utf-8?B?UXREUTZ4dG9CRXRIK2RSeVZqWUg5elU1aEtrbjZRZ25JeXdNOTRpbDBMLzVE?=
 =?utf-8?B?NXFMQjRjM0VpV1U3a0U5L05NdUpVR0pKSytXVGNnODBrYnQ3RERObjZ4Sll1?=
 =?utf-8?B?a3I1N0FaWlFLNUpkS1hYSVU1L3Y1eFZCejZTQ3F3WW5KZGt0VEtWM2tuWHRK?=
 =?utf-8?B?dGZuTGhtMkVYZjcwWWlzajBTUTM2ajFZVHlrWDNWS3BJZUR2VHlDQ0pyS2Ju?=
 =?utf-8?B?V3dtYUh1cTcyeEJyRDNBRGUyWHdlMndtSWZ6U25UUmdIWjlEN1dqMFNRZDM0?=
 =?utf-8?B?eVFHTWxBLzhrMXBFaVV5QUdWcHFFdHhhVW5OTmJ4bFJ2UEZCam4wNnh1NlRJ?=
 =?utf-8?B?WktLWnJURGdrWUtBL0lQTEI0MTFSTGp3bThBa2JDWDg3TWJ5aFJmdzhiTnF4?=
 =?utf-8?B?YU53MWdrUG9VU3c1S1phL1gwUlMweVpod0hNanIvWEhqT2FxY1RsVS9wWTVS?=
 =?utf-8?B?NzFvTEVZck4zd3hMWU9SaUFoc0RwV3I4Z0ZlVjMxU2ZEVG04QTl0STc4QzVF?=
 =?utf-8?B?TW1XUUY2RVdZZ1pwcDZVOFBsWjB6RmhaSjAzeFRMMkd6MG1BQzFKeXltT1Zz?=
 =?utf-8?B?RU8xMUczMEJ4aGVBMVg1VlorTU9qWHZkbjBMcTBvd2psdFBoWTZDVXA1Wktj?=
 =?utf-8?B?SUtpTEF1a0liRjgzWDRNcHVKNDdVK1FSeSswU1J6TXFxWmNiL2h4NC9TYnVU?=
 =?utf-8?B?YmYxV0N4OGo5b1oyZDhINUNVY3haRVpKTURzd2ZJUzZnRndZVkJGY2E2OG1x?=
 =?utf-8?B?UXN4NFRqcHNRNW4xSXFEbTN2TnVYRmFtZG8wSEZ4RmtnQkhGM0E3Rkc0VG90?=
 =?utf-8?B?MGlkNmJDWjRoNE9ZK1pXOVI0ano4UG1iVjY4OG1XTEtEVHNOdGdFOXdOb3pJ?=
 =?utf-8?B?WkJBemt3bEl5blF5MStxTVd1d01CU3hDTnV6OGFnVGFoVnF2WG5GL3h0YUtZ?=
 =?utf-8?B?dVEvV1I3bGF0OTNiSm5VVkV0SDBmalFHRGd1WTBHRTlPeStPdGdSSnFXZnBQ?=
 =?utf-8?B?K041UFFzS0VJTFJyNFdENXRYU0ljQkVhaEc1MDdhWlBML3ZJOXRMQ3lhSk9T?=
 =?utf-8?B?N3Z4eldONDhRTm45MFQrY2U4RVp5STYzNUxodzJlY25UTVl6UXlkTEMwSTFI?=
 =?utf-8?B?YXhvb25MWUxLTnFyV014ck5sazFHRzEwQ1RXbWtXL3IxRkcvRFg3eWtHZWhG?=
 =?utf-8?B?b3NXTGtZQVBkSVhqNVQvQStBb2Uva2VWbXNDdWx6UkZoT3VBRnhIRU9WbFpu?=
 =?utf-8?B?QXVqNjVnb2I2eVFqcG5xdTNNVWhOL0Zva3RQZXdVRU9Wb0x2WG9qSEgvQXFh?=
 =?utf-8?B?d1lSZ01YenJLY1FiQTlkM0hYblQ0Q0hNeHBpT2t2eDlrQmZhQUNtMUMwUS9h?=
 =?utf-8?B?MlJnS2NkeStqSnVIakRqd01Dbit4eUhLRVZ2U3M4WnhLNDh3bWRRMytzUVNC?=
 =?utf-8?B?T2VxNFZoRmJPait2QVBsV3Q5SDVQQWxPNk1OVDhhUFBWUmk2QmZCcW93cWt3?=
 =?utf-8?B?Q09HLzc3K3RQNjVWOFBMcHV3d00zYmVwc05TOUREOGVkQ2p0TUpMamZKY2hD?=
 =?utf-8?B?Lzlndm1BeGQxSmlzUGFuVjFTQUZrUkdQeFRCa1pwbXRZL2NSeG1vQ1ZMUFBi?=
 =?utf-8?B?b1NiVlQ3R3lWK0h4ZnVWNGtyaGlHMlBpUG9KZmhrdXBaenIrYjJKbkY1dGRq?=
 =?utf-8?B?UDhWREJvWGd1U3BZdTdzSzVnaHJlQjM5eUJSY3BRbjZabXJaKzh2RG9JZTk3?=
 =?utf-8?Q?MZqg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965ea561-7185-4716-dd25-08dce3e8063f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:14:45.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNI/bvNpyY7bgdA9XRMEpw6wfGOCUHVGEP2O9wue/srrDssCgmRSgvo6A2qtZ/QSeKtpl1PI7n9MG7sSn8EW7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9291

Replace the hardcoded value 2, which indicates 2 bits for I3C address
status, with the predefined macro I3C_ADDR_SLOT_STATUS_BITS.

Improve maintainability and extensibility of the code.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- fix version, should start from v5
- add Miquel's review tag

Change from v3 to v4
- rename to I3C_ADDR_SLOT_STATUS_BITS
---
 drivers/i3c/master.c       | 4 ++--
 include/linux/i3c/master.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6f3eb710a75d6..dcf8d23c5941a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -348,7 +348,7 @@ static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 
 	if (addr > I2C_MAX_ADDR)
 		return I3C_ADDR_SLOT_RSVD;
@@ -362,7 +362,7 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 					 enum i3c_addr_slot_status status)
 {
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
 
 	if (addr > I2C_MAX_ADDR)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2a1ed05d5782a..2100547b2d8d2 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -313,6 +313,8 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
 };
 
+#define I3C_ADDR_SLOT_STATUS_BITS 2
+
 /**
  * struct i3c_bus - I3C bus object
  * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
@@ -354,7 +356,7 @@ enum i3c_addr_slot_status {
 struct i3c_bus {
 	struct i3c_dev_desc *cur_master;
 	int id;
-	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * I3C_ADDR_SLOT_STATUS_BITS) / BITS_PER_LONG];
 	enum i3c_bus_mode mode;
 	struct {
 		unsigned long i3c;

-- 
2.34.1


