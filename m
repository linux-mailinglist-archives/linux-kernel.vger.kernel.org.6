Return-Path: <linux-kernel+bounces-312311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3E9694D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC79B22923
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323341D6C71;
	Tue,  3 Sep 2024 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="COxLMKyb"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F420FA8C;
	Tue,  3 Sep 2024 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347370; cv=fail; b=TAMFV11nV8ZBp/nH9y0Bce+2uk9arK3gREAPDfXPUcA38K5gV8GWSHh4e9+uBbc/ksamjH3hTgvRWV9Y1/mj3TFVSl+49PWbYUGDggd/452F4s0whLVQ7RK4xlanxUoJ3rXA8tBokZ+C3g2kDr4voVV6kVGgkzpZdOv3Y9XkR8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347370; c=relaxed/simple;
	bh=JEZVtXWijAymBPxcczgG9m9MNv48yaSd5yLdY4NGkfY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C6Pry4XI3n8EsQz6+rU/yV65+zEwyWPTyCG7tEn85GlpKjlHUm1xsWlecof+Y13FsGGbdc3v9ju/Fd0eJo9Qf+1eoNDhAVdOi5WPGP0OjfOPS97Fk29It0gO/csUQ6wuFFD74PAQoM7EfydZvM2uJN0miDNpphjwtfUccLPscPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=COxLMKyb; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLJ/5sPU2mfkBEAKVoEM/q8D9dFS9F7sQUTE8NOiPpo4SkxFYkoFyCN4CzKyiRU8zBqqU8rTGcPPKdDfIH5HtjMO688CuephFoCrHO9aRsXGaNpda7Mvu19EKrVgGwESuu13Bq9aapTSyi4WD0MUVb99qvwHGXMhB1OMu/+9XXDacpAP9NPGvnPyB5ZVdhWE1YFSJmyErPKQAbrHB0dpQ8LP1oUUcq+igCHxrz7VoVlDM3LCX6ynRoNE3MAF0gBWBbUIpCaorJsFLIE1qDMF38s+HOp6T5B/2L7PuYj4mQyk8LuW4jk8NL/frS1GJY0/1heLJc2OxB+snpw+LcJp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AsO78cTWS48ED+b24ZiH5/t4RvUFW8uzvN6PRkMQOk=;
 b=Rr/gLF7AYUJ77r/YFDP8jEwYcKTlptY8Xfn+KzYClXddnXZaYKREw3aNVDQQq/cl9LFmK27+U3olq2xY2CHU4OeuXm9dHjLZzRArI6xmduG6NpR7sqLnPNzzzYTSAstOWCD98N6D/7kysrsJXok40mu/g7DKytLnYqcjT54Y/R0zxXXTjsT+u/J0WVS7Amddgk1JePnABWA8q9nNVNbzWs3QHsBoOydnwyKoB5IOZwuCMEvKc9Sv5AWJGGPWoTYqwvbgBjHXpITguybXKqT1XfO6Y9j5Rikp8JpCpS6m+W+G7t1t7hPsa68BBY3iety1of8TR6l9Ii48geyujCTzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AsO78cTWS48ED+b24ZiH5/t4RvUFW8uzvN6PRkMQOk=;
 b=COxLMKybEKFFogymjXVwZ9nG8ZrAT7v7LNB9clVyWQb9CK0XnQ1G8jxmyqKj9Gaia9ep6//Zij+3z6Um50XpeikvtLOwgb9xgNqepg8h1mqNaEownzKefWsPk9/gLVnUwXMNkjtykFbo8tNoAuNMM4oMipRNNrzV6g3UDyeYj4MW37tiH945ufy1DmuL8Do+Qs1SyoSZhI9eZ4xZVBVNGeK/RtNUPrkzobEEgehC1E3L/fqPbVUy/KKunKGafnOan30bCvrBBcMgukUE/Ype1B70CDAmkifzB+ljGTYTgf8qWcfzUAPoNlfmRGSazsTOq/aeHGcFk+yeStP6Hx288Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:09:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:09:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Sep 2024 15:17:52 +0800
Subject: [PATCH v2 7/7] arm64: dts: freescale: imx95-19x19-evk: add
 lpi2c[5,6] and sub-nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-imx95-dts-new-v2-7-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
In-Reply-To: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725347874; l=2743;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VGWk7Je4HaTt46/hJ5bmxS1en0yCkMeCG7N7BkeTAEs=;
 b=8oexyum4B6kc+47nen2b4GrIRjhA0qP6H5cZAGFwAOX46hqCB6b8XokoIDiUvx1dWzdRhsWAt
 YdAJg4iZtwPD5GGFZd7iDCjQV3mdsiRQmiOD2zRkTgnSPkh1b/dLTD2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c065fd-eb30-473d-7569-08dccbe75657
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFp3V3NVNXFBVXhIWTZrU2h0TWtQQkVwZXRuYnJQYnZwVDVTaTdaS3ZzR3RX?=
 =?utf-8?B?T2lYQVNzZ0owRjFUS1lsazB4b0UyNFNDVjl5cEQ4WW10dHpLYWZBZkdFN2NC?=
 =?utf-8?B?VVk3cWFBTWZhZUh1Y1I5eUxjSEhoV3A5NU1uSnhYUGQxdzdqUmtadDJPRGZX?=
 =?utf-8?B?and5dEU0RUJCamtGS2tKUXRqN0JTZG0xWWpXTmhUdVc3QXVudWd3MjhKUFpu?=
 =?utf-8?B?OGJKOXUxdkRpL0lVWmRKQ1JaR1FlVEQ2amlobDdYeFdtRzR3c1djTi94c2pN?=
 =?utf-8?B?OWJPZUs1dHpjazNIL3h5OUsvbUVtVHh1Qi9wbE1PakZWMHlPSUpIMzVRZG5w?=
 =?utf-8?B?WE5CaDg0cU1EYnF0Q3pMTUxUSzVMUVBVbkxHNUFKclR0ZTZ5ZGE0bzdsajl1?=
 =?utf-8?B?UUt2RXpOSjNRVFhLTkZNYnNqOE0vQ29BRmU2K2ErcXFNYk9zQzFBdWh0KzBn?=
 =?utf-8?B?L3ZFUmYvZFRUUkdNNEE3MURITWxqTHluamk4cjM2MzVrZXdmUisvVG5rbmZh?=
 =?utf-8?B?Njl2SVZxZ1hFK3JIMkdVWXlpbmY2cFN4dkNXZjlSazhWUk90ZnYyeEFRS1cx?=
 =?utf-8?B?YjdVaTF0TjA1Z2ZQSzZoVWRINmp4QnpnMVN3NkNOWW9vZnk5dGdzdm9FcVZU?=
 =?utf-8?B?ZlE0b2F1RnVGYjNKOVRBLzhZTlByOEZvZnlHYVFFcFRST042OTl3dkdwbFZl?=
 =?utf-8?B?Y2tNV1dVbjhLZ3lQNEFwNlg4YlE4Zzg5QUZRYU9iQ1FlSW1Hdkt3TjZqUnN3?=
 =?utf-8?B?N084dzNVL1JDRCtKZjFEWVJPdGNSa3VyZ1l3VEk2VUsrWENaRGlhMnhwNXNR?=
 =?utf-8?B?OGt1NUhwaEU3WjVuRnJBVWZVdWVyZy9tSHFaV2lwSXlyYjU3Yy9SUmFjSFpu?=
 =?utf-8?B?T09vRWJ1OTR0ZUJRUUNIM0pTYk4yOG1zcWkwcWlnaGRGcllmUmd5YkdWdENl?=
 =?utf-8?B?VlkzT3J2Q3JsbWh2UzVodlQ1RTg0eFluOTI1VnVXMllGMWxDY1IvTTYxTGJ5?=
 =?utf-8?B?c2d5ekZkU1ZNMms1V3pCUng0MCtVREF1aGFiakxGSzNJbStRcEVvclBHZWZp?=
 =?utf-8?B?akIwTk90cUxmMzVoQWMrNmNlMzVOWnpUS3psSWkzbjlPeFFLZERKWWdPTzZs?=
 =?utf-8?B?OFZtS2hVTWovU3FORVdCMElIM0c3QjhWaEMvYU0vR3RWZTAvc3FUWnArN2lq?=
 =?utf-8?B?QkgxRHB0Qm5YaWtCTWpiUEZCa1ZlUVlQZDNnZDZRMW5mSmd3ZFFuZzQxT0tx?=
 =?utf-8?B?OWtqZS9RL2tIekNDNHREcnVnVzR4OWt4QzZLWWkwQ3YyQ1V5UVhuWEtlTlJU?=
 =?utf-8?B?bkRnV0tpWWNiRlFNMmUvbjNBZ2wyQTBTSmpmYVlDaU9pNnZOemlTM1hZdWF5?=
 =?utf-8?B?ODZ1OG56SE5adDBiOTBJU3dzNzBaVFNFbTdOcC9tbVZoUkV0UUN0SU5FMC9E?=
 =?utf-8?B?Z2UzWENTcEpGeFlhVUFMRzdEeXgxckI2RGR1dnd4eDFUcWRVM2V2UWV2YUVO?=
 =?utf-8?B?ckx0NUR3eEpaYkZjcFYyVEZQRjJmT3JtODVMYmcyM05ZY0dabVNob2s3Si9x?=
 =?utf-8?B?TTNwbDh5QVZWdjgrWGZGWWpId0hraTZWaEpHQ0h3N2xQQ1MxU0pxUTEya2pO?=
 =?utf-8?B?Y2NXSllMUkx0d0UwbXJ1eFFXVmRWSHdFUGZXK0VWdm9PMlZmZW8vdklOQ3dj?=
 =?utf-8?B?NjBzOW9sa0ZjUGgxWTRHTE4rOXZMWlgzUGxIeUd5ZkN4Q09jbmhxMTdnaUlq?=
 =?utf-8?B?bldiWG5yK3RBVG9hWnhoVlZqZ1c4aXpEODlncjVoWUZDMXRjL3o5YTFxcThB?=
 =?utf-8?B?OCt1ZUZJcUFGaTlkblc2QjRPamErNFhEZ25sWjI0UkFNTnZHRXNrOTFBdzNm?=
 =?utf-8?B?cGRrR3VRQmRiQ1BLM3p4ZmVTelUra0JDVVRqRjVVTXM4Tnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWdSTmF6SEZGUlZjZ1FSNVcvbkluZTFzeUZQeGNvRDFKKytPUUlEdnA1MmJV?=
 =?utf-8?B?Y2htTXFEOEpad1JidkZQV3pzSmxxaWJUZWVab3Q5V09LNzNWM3BGdkIvZFJ5?=
 =?utf-8?B?Z2tLY1dXQ3RWdk4rTWMzQWtvYzFnQ0pONFV6U3hzcUFDZWRFSGpFc0xYenZh?=
 =?utf-8?B?a0hJR2FpbkhIYUJ6VmJpdTRtcFNYRE5LVTlYMWZlNmJGK0M4QVFvTm13SW5D?=
 =?utf-8?B?VzZJMjJEaFNVZXB2VUlpSmNYSVdXNzR3bW1OdGsrUmZ6blBaeGNDTEt6L28z?=
 =?utf-8?B?R21DK1U0QVhtM3JBQlppTlF3cmZ2K3BJRXh3b2dXVElkaXk3M21ianJVSDNK?=
 =?utf-8?B?Qko4MXpwdHdsSENYTmF6cXhVSGFpZEFHQUNMa2RvK2llaEo1cDFkVEphb2JS?=
 =?utf-8?B?MFlhbWVScVJjL2FYaWY5OHdQZkZMWEhOU0M1aGpyOFl4cEM4ZnNMVktTL3Fo?=
 =?utf-8?B?d2VoZFpYZFA3ZW9GQ2JvVUxDamhqOE1aSmdvaUoxRkE5V2VoK1VBVTVOeE9n?=
 =?utf-8?B?NWlvbHgzeFZvaFpXaUhaa1R3bTI0TDI5dURlQlkvOEd1cHVTZVVyWldGTzlB?=
 =?utf-8?B?cE96bmo3RnhNWTQ3YjBsWXdrdEZQVnRsdWV3ZFpGdm9mbDlpUmUzL0tCZmtF?=
 =?utf-8?B?aGxBYnlKM1BzS0dNTDRvSGxMaEU2Q3lUTzE3M1UvRzUwbGJpYmtzS21jUEtY?=
 =?utf-8?B?djVoakVuWGpVdS9uQ1Bia2tUNmlXbCs2NndNbE9BcnZWWjBCYnAyd2daeWEy?=
 =?utf-8?B?NmpuLy8yV05YSnlHMTYrWEYzUFlQekthQW55VDZRdU96Y2ExNjQwVldvaVlX?=
 =?utf-8?B?dnRDd0wrNnpkTkg3a2c5TFBFMXU0OU1ZeGhsTm9MS3hZdTlWbEhRQ3F5M1pC?=
 =?utf-8?B?eE4zcGREQlU3ZXgvTzFtMEpJcFF2QkVOVlpmY2l0VHNIdlg1aHdTZUZsZGo3?=
 =?utf-8?B?RjFoR05aMUJZb3JZaHNaK0lhK3F6RE9VS1NZbTFGYlFMSjJOSHcxaUxHV1I4?=
 =?utf-8?B?bjlaN09OWHMxWDRRUzVMV1JaOVoyNkNwNTh1R3lzZDZzb2swZ3l1dWR5bXNL?=
 =?utf-8?B?c28xRGZ6Ykc3NllweXlha1o4alBGTEhJNHc3QUJHRlVaR1N2UGIyUDMybjQ4?=
 =?utf-8?B?a3VEQzJ2Y1VhTUl2eGJhb1hmZVlVMHFweEt3RUc1c2diZTFyUkVXaEFMQlly?=
 =?utf-8?B?R3Ftd0lsZkdEcEh6aE1rSXlCRlorcE5BVzhTbk41VURQR2dhWCt2aXFrWTRN?=
 =?utf-8?B?ZzNyb3lOWXdNa3BPMERHR1p0Z2FhNGhjSmllYTJ4M3VQbVlPN2ZCcS9XUE0y?=
 =?utf-8?B?MG1PMVd2Tkx2S21aa052YmxsZkcxcWNtRXlQYWZkNVlqMC9XWUdVRUtuSWNi?=
 =?utf-8?B?QVhocEhyMk9lUSs1STBzbGtKREl5RUFoeUdXSjBwWWpPYzFCbmpLWEcwdlFo?=
 =?utf-8?B?dXJuSzh4M1JCYUhJRkJuU3NRNzl3aXY5T3VnVnJUWW11VklYY2hpdDdlQmp5?=
 =?utf-8?B?Z2pyT3NJQTBQZ3lSMFovRjhmYzFEaUo5cFZPZUFQY1BjcnVzRlZaRmtldGc0?=
 =?utf-8?B?YlVVNmdabW13NDNOY2dGMTVlMysrTjNGSXhzZFoyQ0FXK0dhRExDS2ZWSktO?=
 =?utf-8?B?ZFlPcysra01xZDVHWVdCVjZQQWJBM2FoZngrckJVV0xhbk5oOHpFVXZzTkdI?=
 =?utf-8?B?UGRuS1pTN3RvZGJaUXJGdkZERDEzcmJJbUFLZS9SRmRua2RQNGRXczdXeHk2?=
 =?utf-8?B?Y2ZXNWdIaytSNE5nWm4rREFUTFZId0lJU1FZYVlTa1RTNXpNbmZJMi84VTRU?=
 =?utf-8?B?VEgwcDVvc1NQQkJSNi93Tzh6ZkE3YmZ0MDVqckxHVndMVEdicmMvZkgyM0J3?=
 =?utf-8?B?VkljRXBoTTliODR4VkdOREVvSWVPaUdsSDN1UzY4ZXpkdE9uMGtwQUx1cVNx?=
 =?utf-8?B?ODRDZ3dSYUxlSS9iOC9YSWRJSlhLbmQvQnFEWDUyMGg4QW5XODFBemQ3ZHNy?=
 =?utf-8?B?dnpJVWUvTndvMnM4a2lpTXljRVkyeEFZUVBHYTZ2a1ZQZXpaNFBMR2RORFIr?=
 =?utf-8?B?NllEdXNhZ0V2TE0zR28yVjc5SFBPY2NhdGZldDhnNHdjdG45ZXFiSzJzWC9U?=
 =?utf-8?Q?LnI/sgnSmNkI66K+rw/PYjizJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c065fd-eb30-473d-7569-08dccbe75657
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:09:22.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBLniETb93BDisrmLepVnJ8dDP9Nim1yk4GnoXgwnqdUN9lS0WszOV1AQTAYajW+SU/qycIyTME0OW/5pow77g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

From: Peng Fan <peng.fan@nxp.com>

Add LPI2C[5,6] and the gpio expander subnodes.
Since we are at here, also add the alias for all lpi2c and gpio nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 69 +++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 5101cd171e09..6086cb7fa5a0 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -22,6 +22,19 @@ / {
 	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
 
 	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		serial0 = &lpuart1;
@@ -241,6 +254,42 @@ i2c4_gpio_expander_21: gpio@21 {
 	};
 };
 
+&lpi2c5 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	status = "okay";
+
+	i2c5_pcal6408: gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
+&lpi2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c6>;
+	status = "okay";
+
+	i2c6_pcal6416: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6416>;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
 &lpi2c7 {
 	clock-frequency = <1000000>;
 	pinctrl-names = "default";
@@ -427,6 +476,20 @@ IMX95_PAD_GPIO_IO31__LPI2C4_SCL			0x40000b9e
 		>;
 	};
 
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c6: lpi2c6grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO02__LPI2C6_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO03__LPI2C6_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_lpi2c7: lpi2c7grp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO08__LPI2C7_SDA			0x40000b9e
@@ -446,6 +509,12 @@ IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4000031e
 		>;
 	};
 
+	pinctrl_pcal6416: pcal6416grp {
+		fsl,pins = <
+			IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28			0x31e
+		>;
+	};
+
 	pinctrl_pdm: pdmgrp {
 		fsl,pins = <
 			IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e

-- 
2.37.1


