Return-Path: <linux-kernel+bounces-187367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F88CD0C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF2B1C22CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E6A14532E;
	Thu, 23 May 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EkKEKLfG"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF96144D13;
	Thu, 23 May 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461583; cv=fail; b=Dc2sAYiLUYst2j2cF8/W7HxmUmZPpsSWP51gW0+tSbYTIwJoLfj95XG0r9Oz/crCwsmC14eAVZ00/zn1JkJ9BgPWC24t93kg9sDnYcD2N7szEdsaTUVSFXij5jzhzCmY7hoRJr66VihpJNLJ26uT4zwzH8DBPDx8tw1Xb0mr04U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461583; c=relaxed/simple;
	bh=nNtsekLbSKS/7Kw8xz32XubYeLBMrFRe9/7nwmSYOnw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XpuOPVrCyawIEqgcxkSYaQ3umnr10TQTwybtVsNp8EpgLgZwwcLQ6BC5j/hRwhamiIP/HTv7AwmuKsTR//xldtkplTxQDRhA0bqknKzc595s9PJrcERIDZfPqZJ/BhJnmxBqI44/v7aDCh3ujahI8g1me/x5i6EDnsCqpAJ0iPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EkKEKLfG; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG6OR4qPhrmQB9oBnDYU67w19CqHDqmy1xhTCO4mgA2hog3eCgueprYwkmB+bVsXdGhqjKrjyMnitomFK4d4UvFpVeO9JZegiXuHifai/skTIwKwXK6MQWUyIhfLnQGVeR88xHRH5RlvtMpiUK82MioMp4KCbQEl3of8ACR0RqyssfTh2ohwXpncr/l74KZS4m1gBfusU/xADcOdhS/GMBdOrNVzu7oVWPl5fkzvG2voTiEMb5cyI/1S94Xdt7kqsauRVYGPEnwZoBMiz/bhodXHn6B1lXcyczl5+Rb+Xk5BmblOjwcbyBW7LqBdeO/L6IL0Jk1GJri5jBOTSpkeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSxrDooHWmjfxrZsMyO/CQuz0Lp7EtU6XeR8zO+LvxE=;
 b=dq4rWLUsEAdnZngnVFuxWAn1HwWKMJUW5PW7QvlzpZ1R5Bho7yVY1eGBnoDgS91RqzPZt+pIp0wac5c0Rn3hIQYIDNq/2mtM7x8fBySpHlbZwjqBjKj4S55RSpCeZar1CMlxfNZdBPa55Vp0f5ohwf85kUcbZ36PRf+gpaKDW4ID+1vG85SyHfRqwSrn5EJHjK47Xy5uqgWX/tLwwSPq3XBKgAtD8ATL1cyfPIyK2DCRm+ZWa74gkGEoRO9uSZvJjOTN0MYB8w7LrF/51gD3pq7i8ftvsAFT06DLuIcQFe48qtMqWBQl6TlMCwj4ZUrXem3AZMJyfzGCS0Kbqe7mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSxrDooHWmjfxrZsMyO/CQuz0Lp7EtU6XeR8zO+LvxE=;
 b=EkKEKLfGXtP/RfWM99Q5ZZsON7jC5530JowoPaLVrz92TwGABxRsAz5ifvldZZL068TU/yMPEdXHYctZ3fskC03+RcMvsHQ1Rr2tiynuFtjuXkLi1nvwIGyARyO9RdrplgIBHfH6UCJp5qRVg1MeA2IBWH+qvyfOb7+sa18+Kjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Thu, 23 May
 2024 10:52:55 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 10:52:55 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 23 May 2024 16:19:36 +0530
Subject: [PATCH v2 5/5] firmware: imx: adds miscdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
In-Reply-To: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716461396; l=30764;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=nNtsekLbSKS/7Kw8xz32XubYeLBMrFRe9/7nwmSYOnw=;
 b=/jgKs1XN3HnTs29hDs3OM20uF53JuV8iKb1z3ZRqz7izSeMcN5F2E5QDE0S6H5BhohwLRLkR5
 c/o8LD2kEYBCyTbvhIeZiy4mRHvYLvR82nw456SBEHz0/PYAo4nz9gL
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PAXPR04MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: bbda1a89-f28c-4dff-fed5-08dc7b168095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|7416005|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWRJSGhNbnlpUU12ZmhFZGFXRXBGNDRpZE45Rmg0TEhNK0JmKzl0NnoyNWJZ?=
 =?utf-8?B?NCt6d1lEem0xdnphbWF3MWxlZHhXTGd0bGl5ZkZ1WTNobGxoZDJ2L3pxZWJt?=
 =?utf-8?B?K1YxNUZFUTFzU21PSHdZV3VITnA1dGNYM2hCc3VVQ3lMRjFkaUJrNFlXSHkz?=
 =?utf-8?B?eDloRmN4Nm5NL2VGYUtlOENoYU5RSWg3dUhUSGI2U0V0ZUE1MUliKzkyN0cr?=
 =?utf-8?B?Z2kzUUxVUFNXc3BNUHZsSmx0S0lQeVBwcVpSTkEyNnQ2UDR5YkxaK3J3Y3Z5?=
 =?utf-8?B?R3p3TStyVDdhZzk3d0syVlQra25wTzNrQm0yRTF6enhwWkEyWlRQL2JxNjNE?=
 =?utf-8?B?RVJPdXRFUFRKdGRSVGwxVkdLRWtzeWc4eS82VkZlMFJudjMwSzZiS2dFOTJC?=
 =?utf-8?B?YXFMYXcxNW5FcUZ6cjh3MStKSGZGTS8reUlIRHZLSS9qMVNmVlZJZklSbVAv?=
 =?utf-8?B?amNaV3pUOWdXaFlCeTloZ3NsMXpLcDRsRzFrd2hNQWN0SzVJK2JyWnNldGZE?=
 =?utf-8?B?UkJxSXRETzNQeEJsZnhsem01RHQ1V2xTMDZYVlFMQWdWbUNKWFVhTDdKM01s?=
 =?utf-8?B?SmxWRDVkanlMTndHazhjTXdOUTdnN2hLNWlVVnM3UW5PRWhBUFY3eW5ROWRH?=
 =?utf-8?B?aUF0ckU0aCtxSS9EOWw3ajVCVFZkbkx1K2JDS2pxMVF2QTVxU3d0a1hBbElH?=
 =?utf-8?B?ZWxzdVlORG4xL3J6ZjBSaEp0SW1taVNwdTZCeTh2U1dTNFhzR01NQnlPb2cv?=
 =?utf-8?B?aWtIWXF6L1RpZTJLOGF0cTFmZnhYdk9DeVJ5V0UxWUk5M25VRzRkUVMzWWRQ?=
 =?utf-8?B?bCswYWlxQ3M2akY0d1R1dWRIMDVWTFUxRmo3SUhFeTFSNFl2cG80WFVFc0RU?=
 =?utf-8?B?SjdsSW5EZ1lxWHpCTXRzd1lHeGZ5Y3I0UmtRb3ZsRkJGZlNiSmlyeHUzOTdp?=
 =?utf-8?B?VWFKZDN0VUVmelNKd29WUWFWaDFzUFM2Q251dkdFR2MyTkRQN2l6YzBSN1ZK?=
 =?utf-8?B?SHRicVVSREp6cGIxMDB0ZDhzbjFMWkxQMTdOaGtOYmFtQWZBUTczamQ3VkF1?=
 =?utf-8?B?R0I4blpnMWdQRXhoZVdaYW1WMXloNExaMGRBWW4vcWtGZFI4MEVGYTgxd2JC?=
 =?utf-8?B?c3hOMnBVZlhRVXFkU3NoNExpeHExLzN6dTdVVTkxQ0h6NnV6RElWK29jVGpu?=
 =?utf-8?B?R2xHdFZ3d1pFaFRrUXA5RTBlWVB4b2dhN3h5MDFTVzVobmpaZEtIRjRSN1lO?=
 =?utf-8?B?WnlRbkxkM2ZXYUE2eUVPZW5mVmZjV3AvOUE0QlhueWpYV1dlaU11VmNXRnlX?=
 =?utf-8?B?WktWc0xkTVVRaTF5Q0xRVGZRcmptMk5SQzBjMXVZU014MkEwakZIL1phYXFz?=
 =?utf-8?B?K3hFVTk4czdINURMV2tOQXlaMC9wbWE1bEdsa3V2bkRGNW1lc0tSUzJTeVlH?=
 =?utf-8?B?Y05ES2N2alJ1dnF3Y285citOTlovTlgwdUV3czloUXVsZkE1RnJjZVlwTDVD?=
 =?utf-8?B?azNmaU1qazMvSlB6VDczQytzdGxyUUFERHZNUE9ubEdNTk1IT2hUUGJXVEJy?=
 =?utf-8?B?c2U4WnJtOGxUNGpURUVSUkNZK2svSEhWSkJrcHRWZnJsYzQwT0ZyM2M1R2JV?=
 =?utf-8?B?Zlgza1d2NkREdW9leXlTYTliU0hjeXhNeFVOZVVkY0lVbFJ2cERSTFJjTDIz?=
 =?utf-8?B?MzZDeVlqYTFmZDNudTBPeUpWd2lnbERPdFduUXFTblN1MlRsOVBPTlFWNTN1?=
 =?utf-8?Q?2eqIHCpx59FFdR2W0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWlUd0NRL3RGeWZJaGtodklBUXRNVGliOCtmMmhNb21BK2FFNHlucDhXMW9x?=
 =?utf-8?B?RzRUa3kxdDJENjdxaXViOC84RXFxeUR0NDNYNTJ2WFU1YjlpdjIrTnVOZzl2?=
 =?utf-8?B?amJoM284RC9ZeVoxckZiL0FRVVBiKzhlcUNhbDQ4R0NSRXhvUzREbjljMXBo?=
 =?utf-8?B?bHVDTlZmY3ZpeU1jaTBVc3l0dEt6MU1QeC9TUUx2d3ZzeFM3RkNndHg4RTh3?=
 =?utf-8?B?dnV3dW9yTzgrZCs5WlJoaXFuRnJGVU5sWkk1UTVEUmJOdzVuWUZBRWdoN0NQ?=
 =?utf-8?B?T2kxVkRXRm9tUVZGajU2TFNJMGhDTEhaaHBhWHBZM3pxeTk3Z3pSZStQWVdB?=
 =?utf-8?B?VnlFWDhCR3ViZzl0ejlzWXFMdDNsdFJZYTd2OU5DR0pEN3RVUGxuSm9MOXJN?=
 =?utf-8?B?ZWlOQVNRdDg0SUtKby8wWDJkcm1PSStFZVl1U0lqYUUyWE1kVFVoY3Z6bVBh?=
 =?utf-8?B?N3BCVUVUc2dWOWNweVRWZXhUY0ZNeFovV1Y5Y01VbGhZM0UxRWFBaGdmM2lY?=
 =?utf-8?B?YUFIVHJIWEU4dXlaWGZHUGQ5YytVaFErQThpekxJZVk3NUdUSVlkRlZ4bnhp?=
 =?utf-8?B?QkF5ZkdmMkR2Y1ZiUmVFN05TRDN1OGpXNjNwYUU5ZUVQY3gwRmcvd3phNkIy?=
 =?utf-8?B?S05OanhCQk5RUi9zeDJpcmk0WWVWWk0rbU53OS9zRnRpS3RUU3V4NzRlZ0FG?=
 =?utf-8?B?MFh2VDJRVjdzdFdJMjU0OEl1TXkrdEttR28rMkFmSC9ZZWg5SDVsUG5iR3N2?=
 =?utf-8?B?T0NYMzlwK1FxK3JaWkYwSFB0bFdFSGxIakprWEZLRGpndTdCZG5ITEN1dW10?=
 =?utf-8?B?bFBUSEFYbHJJQ00vWmNuVHpHMVNCWCtGUTgrdzFqM1JiUmxMMEZNT2I3MDZr?=
 =?utf-8?B?QkRjdTlJSWFwaHhucVZhSitncDVUME1hcUwvbWxvdVRiRGpKQzF3Vk9ZVnRx?=
 =?utf-8?B?cytNRTVKWFVmd1I1TFhYVTkrbW80OXZzZHM2aFZsUWU5cjU5NTJ4NkM3N3hO?=
 =?utf-8?B?L01zMUpDN1NjVWg1SENPdHJGcXBvWUVpMDByUUVDQVJpRkx4eHdwV1ZhbXU0?=
 =?utf-8?B?c0J3aGR3cjNOSjFUbEFJdzZzajlOdFRkdnU2VjdEUWlIczRyVklKM053dENN?=
 =?utf-8?B?MjRTbHF5YXJXM0hzaUdOZXM4bFNXUjJ3MDZGSXFaT052bUEvSWorTjhpVEx3?=
 =?utf-8?B?VHkrWFBqams4WXRXZ2NyNnBLWU0zOXNJMTZ5dzk5OG1BWmtHc0VQY3VRQUxw?=
 =?utf-8?B?a2ErOTNzV2Q4RmdIOHBtTTMwdzh1Q2hPR1VSTVVvbHZZTytvQkNwV2MyUUJt?=
 =?utf-8?B?NGIxejZqa1lnS2Zpd2RjR2hvRW45ajM4d0QwM0FHVVVLM29BMnBUdmIwcHNN?=
 =?utf-8?B?YXRiUk4xejl4dmptalpxaDNOd0s4dUJYMElHSk95bXhIWTVMTVNadWk1WWZi?=
 =?utf-8?B?a2hYVXRwSVlxalpTWU1pRUd5L3B1dXlPVFlyU3BjK3B2ZFlPY3RLQ0NwUUY1?=
 =?utf-8?B?RzQwMlEvOHI4aEtORjgxczdyUElQakZkS1BkN1UwU2FiUWRPWGt1Zm5SODJJ?=
 =?utf-8?B?ZGNySmJ2d3BVbDFjN1JrcUd0SHkydXo4RlZNT09Ja0g5ZDVSUHgrSHpoazJN?=
 =?utf-8?B?ZjZCTkxFQndPV0QrTy85R2pldllER05CRERVdVVNNFdIcjJqbThyZGxDdFla?=
 =?utf-8?B?RitoK3JIeEF6UTBZcnJHeGlVSmZOTkhMOUk4UG1rbktjWlZsTFJQaTlndkpL?=
 =?utf-8?B?RTN5bE5wcGdES1BLRHN4NS9nYTdROHpudllJZklCTXNJbVlSNFYreWc3T1o4?=
 =?utf-8?B?UUQ0a0g1dWhyTGRITmxRVkkxV3lOT0xyTVFJR1F2SGRxbG5QTnpXVTE2ZGc1?=
 =?utf-8?B?cU5EZUdVR1VpclEzUHhmcC8xbENJVkhuWEdURktIU29tTCtKMkJZRk1RVGVS?=
 =?utf-8?B?RVJHcDdKa2prMEs4bHJ1cmFYMDRhVEhmRGtKUG1LcTRoYlpCM0FRR2dTdzVM?=
 =?utf-8?B?aUxWL2JtQStTU294b0xTTnYrdFdYYW16QjhISEx3ZWs2NHlNLzJOSWdlT0lB?=
 =?utf-8?B?a0J1YlNNZ1VBMnNZK0lNU3doZWl1NGpJS1dReHRpa0NwcWRPeUJueUQ3Mk9Y?=
 =?utf-8?Q?oAjk+mhXp1K9h89YDfJFApCgm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbda1a89-f28c-4dff-fed5-08dc7b168095
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:52:55.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+k7O3DP1He+IV0qMV9bR4KdLAg7DeihJSzkRYJQYKuv5DfnE+xIzABmtcHSLUAPsQFsdoe6VuK7qZtqsV7Qbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9571

Adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like
EdgeLock Enclave from:
- User-Space Applications via character driver.

ABI documentation for the NXP secure-enclave driver.

User-space library using this driver:
- i.MX Secure Enclave library:
  -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
- i.MX Secure Middle-Ware:
  -- URL: https://github.com/nxp-imx/imx-smw.git

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 Documentation/ABI/testing/se-cdev |  42 +++
 drivers/firmware/imx/ele_common.c | 108 +++++-
 drivers/firmware/imx/ele_common.h |   3 +
 drivers/firmware/imx/se_ctrl.c    | 689 ++++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h    |  46 +++
 include/uapi/linux/se_ioctl.h     |  88 +++++
 6 files changed, 974 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..699525af6b86
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,42 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		May 2024
+KernelVersion:	6.8
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for  secure-enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file-descriptors
+		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-
+		enclave shared-library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>
+		 ioctl(s) are used primarily for:
+			- shared memory management
+			- allocation of I/O buffers
+			- get mu info
+			- setting a dev-ctx as receiver that is slave to fw
+			- get SoC info
+
+		The following file operations are supported:
+
+		open(2)
+		  Currently the only useful flags are O_RDWR.
+
+		read(2)
+		  Every read() from the opened character device context is waiting on
+		  wakeup_intruptible, that gets set by the registered mailbox callback
+		  function; indicating a message received from the firmware on message-
+		  unit.
+
+		write(2)
+		  Every write() to the opened character device context needs to acquire
+		  mailbox_lock, before sending message on to the message unit.
+
+		close(2)
+		  Stops and free up the I/O contexts that was associated
+		  with the file descriptor.
+
+Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
+		https://github.com/nxp-imx/imx-smw.git
+		crypto/skcipher,
+		drivers/nvmem/imx-ocotp-ele.c
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index c286c3d84d82..15fabc369b21 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -78,12 +78,98 @@ int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg)
 	return err;
 }
 
+int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_msg_hdr *header = {0};
+	int err;
+
+	if (dev_ctx->priv->waiting_rsp_dev == dev_ctx)
+		lockdep_assert_held(&dev_ctx->priv->se_if_cmd_lock);
+
+	err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
+	if (err)
+		dev_err(dev_ctx->dev,
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+			dev_ctx->miscdev.name, err);
+
+	header = (struct se_msg_hdr *) dev_ctx->temp_resp;
+
+	if (header->tag == dev_ctx->priv->rsp_tag) {
+		if (dev_ctx->priv->waiting_rsp_dev != dev_ctx)
+			dev_warn(dev_ctx->dev,
+			"%s: Device context waiting for response mismatch.\n",
+			dev_ctx->miscdev.name);
+		else
+			dev_ctx->priv->waiting_rsp_dev = NULL;
+
+		mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
+	}
+
+	return err;
+}
+
+int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
+			     void *tx_msg, int tx_msg_sz)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_msg_hdr *header;
+	int err;
+
+	header = (struct se_msg_hdr *) tx_msg;
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	err = header->size << 2;
+
+	if (err != tx_msg_sz) {
+		err = -EINVAL;
+		dev_err(priv->dev,
+			"%s: User buffer too small\n",
+				dev_ctx->miscdev.name);
+		goto exit;
+	}
+	/* Check the message is valid according to tags */
+	if (header->tag == priv->cmd_tag) {
+		mutex_lock(&priv->se_if_cmd_lock);
+		priv->waiting_rsp_dev = dev_ctx;
+	} else if (header->tag == priv->rsp_tag) {
+		/* Check the device context can send the command */
+		if (dev_ctx != priv->cmd_receiver_dev) {
+			dev_err(priv->dev,
+				"%s: Channel not configured to send resp to FW.",
+				dev_ctx->miscdev.name);
+			err = -EPERM;
+			goto exit;
+		}
+	} else {
+		dev_err(priv->dev,
+			"%s: The message does not have a valid TAG\n",
+				dev_ctx->miscdev.name);
+		err = -EINVAL;
+		goto exit;
+	}
+	err = imx_ele_msg_send(priv, tx_msg);
+	if (err < 0) {
+		if (header->tag == priv->cmd_tag) {
+			priv->waiting_rsp_dev = NULL;
+			mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
+		}
+	} else
+		err = header->size << 2;
+exit:
+	return err;
+}
+
 /*
  * Callback called by mailbox FW, when data is received.
  */
 void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 {
 	struct device *dev = mbox_cl->dev;
+	struct se_if_device_ctx *dev_ctx;
+	struct se_api_msg *rx_msg;
 	struct se_if_priv *priv;
 	struct se_msg_hdr *header;
 
@@ -97,8 +183,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 
 	header = (struct se_msg_hdr *) msg;
 
-	if (header->tag == priv->rsp_tag) {
-		if (!priv->waiting_rsp_dev) {
+	/* Incoming command: wake up the receiver if any. */
+	if (header->tag == priv->cmd_tag) {
+		dev_dbg(dev, "Selecting cmd receiver\n");
+		dev_ctx = priv->cmd_receiver_dev;
+	} else if (header->tag == priv->rsp_tag) {
+		if (priv->waiting_rsp_dev) {
+			dev_dbg(dev, "Selecting rsp waiter\n");
+			dev_ctx = priv->waiting_rsp_dev;
+		} else {
 			/*
 			 * Reading the EdgeLock Enclave response
 			 * to the command, sent by other
@@ -116,6 +209,17 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 				*((u32 *) header));
 		return;
 	}
+	/* Init reception */
+	rx_msg = kzalloc(header->size << 2, GFP_KERNEL);
+	if (rx_msg)
+		memcpy(rx_msg, msg, header->size << 2);
+
+	dev_ctx->temp_resp = (u32 *)rx_msg;
+	dev_ctx->temp_resp_size = header->size;
+
+	/* Allow user to read */
+	dev_ctx->pending_hdr = 1;
+	wake_up_interruptible(&dev_ctx->wq);
 }
 
 int validate_rsp_hdr(struct se_if_priv *priv,
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 76777ac629d6..11b9b36d4fda 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -12,6 +12,9 @@
 #define IMX_ELE_FW_DIR                 "imx/ele/"
 
 uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len);
+int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *priv);
+int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
+			     void *tx_msg, int tx_msg_sz);
 int imx_ele_msg_rcv(struct se_if_priv *priv);
 int imx_ele_msg_send(struct se_if_priv *priv, void *tx_msg);
 int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg);
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index 0642d349b3d3..3acaecd8f3bc 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <uapi/linux/se_ioctl.h>
 
 #include "ele_base_msg.h"
 #include "ele_common.h"
@@ -232,6 +233,590 @@ static int imx_fetch_se_soc_info(struct device *dev)
 	return 0;
 }
 
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
+				size_t size, loff_t *ppos)
+{
+	struct se_api_msg *tx_msg __free(kfree);
+	struct se_if_device_ctx *dev_ctx;
+	struct se_if_priv *priv;
+	int err;
+
+	dev_ctx = container_of(fp->private_data,
+			       struct se_if_device_ctx,
+			       miscdev);
+	priv = dev_ctx->priv;
+	dev_dbg(priv->dev,
+		"%s: write from buf (%p)%zu, ppos=%lld\n",
+			dev_ctx->miscdev.name,
+			buf, size, ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != SE_IF_CTX_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (size < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%zu < %d)\n",
+				dev_ctx->miscdev.name,
+				size, SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+	tx_msg = memdup_user(buf, size);
+	if (!tx_msg) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     tx_msg, size, false);
+
+	err = imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
+			       size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx;
+	struct se_buf_desc *b_desc;
+	struct se_if_priv *priv;
+	u32 size_to_copy;
+	int err;
+
+	dev_ctx = container_of(fp->private_data,
+			       struct se_if_device_ctx,
+			       miscdev);
+	priv = dev_ctx->priv;
+	dev_dbg(priv->dev,
+		"%s: read to buf %p(%zu), ppos=%lld\n",
+			dev_ctx->miscdev.name,
+			buf, size, ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != SE_IF_CTX_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = imx_ele_miscdev_msg_rcv(dev_ctx);
+	if (err)
+		goto exit;
+
+	/* Buffer containing the message from FW, is
+	 * allocated in callback function.
+	 * Check if buffer allocation failed.
+	 */
+	if (!dev_ctx->temp_resp) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	dev_dbg(priv->dev,
+			"%s: %s %s\n",
+			dev_ctx->miscdev.name,
+			__func__,
+			"message received, start transmit to user");
+
+	/*
+	 * Check that the size passed as argument is larger than
+	 * the one carried in the message.
+	 */
+	size_to_copy = dev_ctx->temp_resp_size << 2;
+	if (size_to_copy > size) {
+		dev_dbg(priv->dev,
+			"%s: User buffer too small (%zu < %d)\n",
+				dev_ctx->miscdev.name,
+				size, size_to_copy);
+		size_to_copy = size;
+	}
+
+	/*
+	 * We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	while (!list_empty(&dev_ctx->pending_out)) {
+		b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
+						  struct se_buf_desc,
+						  link);
+		if (!b_desc)
+			continue;
+
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
+
+			dev_dbg(priv->dev,
+				"%s: Copy output data to user\n",
+				dev_ctx->miscdev.name);
+			if (copy_to_user(b_desc->usr_buf_ptr,
+					 b_desc->shared_buf_ptr,
+					 b_desc->size)) {
+				dev_err(priv->dev,
+					"%s: Failure copying output data to user.",
+					dev_ctx->miscdev.name);
+				err = -EFAULT;
+				goto exit;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		__list_del_entry(&b_desc->link);
+		kfree(b_desc);
+	}
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     dev_ctx->temp_resp, size_to_copy, false);
+	if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
+		dev_err(priv->dev,
+			"%s: Failed to copy to user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	err = size_to_copy;
+	kfree(dev_ctx->temp_resp);
+
+	/* free memory allocated on the shared buffers. */
+	dev_ctx->secure_mem.pos = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+
+	dev_ctx->pending_hdr = 0;
+
+exit:
+	/*
+	 * Clean the used Shared Memory space,
+	 * whether its Input Data copied from user buffers, or
+	 * Data received from FW.
+	 */
+	while (!list_empty(&dev_ctx->pending_in) ||
+	       !list_empty(&dev_ctx->pending_out)) {
+		if (!list_empty(&dev_ctx->pending_in))
+			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
+							  struct se_buf_desc,
+							  link);
+		else
+			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
+							  struct se_buf_desc,
+							  link);
+
+		if (!b_desc)
+			continue;
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		__list_del_entry(&b_desc->link);
+		kfree(b_desc);
+	}
+
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
+				u64 arg)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
+	struct imx_se_node_info *if_node_info;
+	struct se_ioctl_get_if_info info;
+	int err = 0;
+
+	if_node_info = (struct imx_se_node_info *)priv->info;
+
+	info.se_if_id = if_node_info->se_if_id;
+	info.interrupt_idx = 0;
+	info.tz = 0;
+	info.did = if_node_info->se_if_did;
+	info.cmd_tag = if_node_info->cmd_tag;
+	info.rsp_tag = if_node_info->rsp_tag;
+	info.success_tag = if_node_info->success_tag;
+	info.base_api_ver = if_node_info->base_api_ver;
+	info.fw_api_ver = if_node_info->fw_api_ver;
+
+	dev_dbg(priv->dev,
+		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
+			dev_ctx->miscdev.name,
+			info.se_if_id, info.interrupt_idx, info.tz, info.did);
+
+	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy mu info to user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/*
+ * Copy a buffer of data to/from the user and return the address to use in
+ * messages
+ */
+static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_shared_mem *shared_mem = NULL;
+	struct se_ioctl_setup_iobuf io = {0};
+	struct se_buf_desc *b_desc = NULL;
+	int err = 0;
+	u32 pos;
+
+	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed copy iobuf config from user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	dev_dbg(dev_ctx->priv->dev,
+			"%s: io [buf: %p(%d) flag: %x]\n",
+			dev_ctx->miscdev.name,
+			io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* Select the shared memory to be used for this buffer. */
+	if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
+		/* App requires to use secure memory for this buffer.*/
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocate SEC MEM memory\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	} else {
+		/* No specific requirement for this buffer. */
+		shared_mem = &dev_ctx->non_secure_mem;
+	}
+
+	/* Check there is enough space in the shared memory. */
+	if (shared_mem->size < shared_mem->pos
+			|| io.length >= shared_mem->size - shared_mem->pos) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Not enough space in shared memory\n",
+				dev_ctx->miscdev.name);
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
+	    !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
+		/*Add base address to get full address.*/
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocate SEC MEM memory\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	memset(shared_mem->ptr + pos, 0, io.length);
+	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
+	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
+				   io.length)) {
+			dev_err(dev_ctx->priv->dev,
+				"%s: Failed copy data to shared memory\n",
+				dev_ctx->miscdev.name);
+			err = -EFAULT;
+			goto exit;
+		}
+	}
+
+	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy iobuff setup to user\n",
+				dev_ctx->miscdev.name);
+		kfree(b_desc);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (b_desc) {
+		b_desc->shared_buf_ptr = shared_mem->ptr + pos;
+		b_desc->usr_buf_ptr = io.user_buf;
+		b_desc->size = io.length;
+
+		if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
+			/*
+			 * buffer is input:
+			 * add an entry in the "pending input buffers" list so
+			 * that copied data can be cleaned from shared memory
+			 * later.
+			 */
+			list_add_tail(&b_desc->link, &dev_ctx->pending_in);
+		} else {
+			/*
+			 * buffer is output:
+			 * add an entry in the "pending out buffers" list so data
+			 * can be copied to user space when receiving Secure-Enclave
+			 * response.
+			 */
+			list_add_tail(&b_desc->link, &dev_ctx->pending_out);
+		}
+	}
+
+exit:
+	return err;
+}
+
+/* IOCTL to provide SoC information */
+static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
+					     u64 arg)
+{
+	struct imx_se_node_info_list *info_list;
+	struct se_ioctl_get_soc_info soc_info;
+	int err = -EINVAL;
+
+	info_list = (struct imx_se_node_info_list *)
+			device_get_match_data(dev_ctx->priv->dev);
+	if (!info_list)
+		goto exit;
+
+	soc_info.soc_id = info_list->soc_id;
+	soc_info.soc_rev = dev_ctx->priv->soc_rev;
+
+	err = (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_info));
+	if (err) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy soc info to user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/* Open a character device. */
+static int se_if_fops_open(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
+	int err = 0;
+
+	/* Avoid race if opened at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* Authorize only 1 instance. */
+	if (dev_ctx->status != SE_IF_CTX_FREE) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
+					MAX_DATA_SIZE_PER_USER,
+					&dev_ctx->non_secure_mem.dma_addr,
+					GFP_KERNEL);
+	if (!dev_ctx->non_secure_mem.ptr) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	dev_ctx->non_secure_mem.pos = 0;
+	dev_ctx->status = SE_IF_CTX_OPENED;
+
+	dev_ctx->pending_hdr = 0;
+
+	goto exit;
+
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a character device. */
+static int se_if_fops_close(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_buf_desc *b_desc;
+
+	/* Avoid race if closed at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* The device context has not been opened */
+	if (dev_ctx->status != SE_IF_CTX_OPENED)
+		goto exit;
+
+	/* check if this device was registered as command receiver. */
+	if (priv->cmd_receiver_dev == dev_ctx)
+		priv->cmd_receiver_dev = NULL;
+
+	/* check if this device was registered as waiting response. */
+	if (priv->waiting_rsp_dev == dev_ctx) {
+		priv->waiting_rsp_dev = NULL;
+		mutex_unlock(&priv->se_if_cmd_lock);
+	}
+
+	/* Unmap secure memory shared buffer. */
+	if (dev_ctx->secure_mem.ptr)
+		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
+
+	dev_ctx->secure_mem.ptr = NULL;
+	dev_ctx->secure_mem.dma_addr = 0;
+	dev_ctx->secure_mem.size = 0;
+	dev_ctx->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+	dev_ctx->non_secure_mem.ptr = NULL;
+	dev_ctx->non_secure_mem.dma_addr = 0;
+	dev_ctx->non_secure_mem.size = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+
+	while (!list_empty(&dev_ctx->pending_in) ||
+	       !list_empty(&dev_ctx->pending_out)) {
+		if (!list_empty(&dev_ctx->pending_in))
+			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
+							  struct se_buf_desc,
+							  link);
+		else
+			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
+							  struct se_buf_desc,
+							  link);
+
+		if (!b_desc)
+			continue;
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		__list_del_entry(&b_desc->link);
+		kfree(b_desc);
+	}
+
+	dev_ctx->status = SE_IF_CTX_FREE;
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return 0;
+}
+
+/* IOCTL entry point of a character device */
+static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
+	struct se_if_priv *se_if_priv = dev_ctx->priv;
+	int err = -EINVAL;
+
+	/* Prevent race during change of device context */
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SE_IOCTL_ENABLE_CMD_RCV:
+		if (!se_if_priv->cmd_receiver_dev) {
+			se_if_priv->cmd_receiver_dev = dev_ctx;
+			err = 0;
+		}
+		break;
+	case SE_IOCTL_GET_MU_INFO:
+		err = se_ioctl_get_mu_info(dev_ctx, arg);
+		break;
+	case SE_IOCTL_SETUP_IOBUF:
+		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_GET_SOC_INFO:
+		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
+		break;
+
+	default:
+		err = -EINVAL;
+		dev_dbg(se_if_priv->dev,
+			"%s: IOCTL %.8x not supported\n",
+				dev_ctx->miscdev.name,
+				cmd);
+	}
+
+	up(&dev_ctx->fops_lock);
+	return (long)err;
+}
+
+/* Char driver setup */
+static const struct file_operations se_if_fops = {
+	.open		= se_if_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= se_if_fops_close,
+	.unlocked_ioctl = se_ioctl,
+	.read		= se_if_fops_read,
+	.write		= se_if_fops_write,
+};
+
+/* interface for managed res to unregister a character device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -270,6 +855,7 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct se_if_priv *priv;
 	int ret = 0;
+	int i;
 
 	priv = dev_get_drvdata(dev);
 	if (!priv) {
@@ -294,6 +880,17 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
 		priv->imem.buf = NULL;
 	}
 
+	if (priv->ctxs) {
+		for (i = 0; i < priv->max_dev_ctx; i++) {
+			if (priv->ctxs[i]) {
+				devm_remove_action(dev,
+						   if_misc_deregister,
+						   &priv->ctxs[i]->miscdev);
+				misc_deregister(&priv->ctxs[i]->miscdev);
+			}
+		}
+	}
+
 	if (priv->flags & RESERVED_DMA_POOL) {
 		of_reserved_mem_device_release(dev);
 		priv->flags &= (~RESERVED_DMA_POOL);
@@ -302,6 +899,84 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
 	return ret;
 }
 
+static int init_device_context(struct device *dev)
+{
+	const struct imx_se_node_info *info;
+	struct se_if_device_ctx *dev_ctx;
+	struct se_if_priv *priv;
+	u8 *devname;
+	int ret = 0;
+	int i;
+
+	priv = dev_get_drvdata(dev);
+
+	if (!priv) {
+		ret = -EINVAL;
+		dev_err(dev, "Invalid SE-MU Priv data");
+		return ret;
+	}
+	info = priv->info;
+
+	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
+				  GFP_KERNEL);
+
+	if (!priv->ctxs) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	/* Create users */
+	for (i = 0; i < priv->max_dev_ctx; i++) {
+		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
+		if (!dev_ctx) {
+			ret = -ENOMEM;
+			return ret;
+		}
+
+		dev_ctx->dev = dev;
+		dev_ctx->status = SE_IF_CTX_FREE;
+		dev_ctx->priv = priv;
+
+		priv->ctxs[i] = dev_ctx;
+
+		/* Default value invalid for an header. */
+		init_waitqueue_head(&dev_ctx->wq);
+
+		INIT_LIST_HEAD(&dev_ctx->pending_out);
+		INIT_LIST_HEAD(&dev_ctx->pending_in);
+		sema_init(&dev_ctx->fops_lock, 1);
+
+		devname = devm_kasprintf(dev, GFP_KERNEL, "%s_ch%d",
+					 info->se_name, i);
+		if (!devname) {
+			ret = -ENOMEM;
+			return ret;
+		}
+
+		dev_ctx->miscdev.name = devname;
+		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
+		dev_ctx->miscdev.fops = &se_if_fops;
+		dev_ctx->miscdev.parent = dev;
+		ret = misc_register(&dev_ctx->miscdev);
+		if (ret) {
+			dev_err(dev, "failed to register misc device %d\n",
+				ret);
+			return ret;
+		}
+
+		ret = devm_add_action(dev, if_misc_deregister,
+				      &dev_ctx->miscdev);
+		if (ret) {
+			dev_err(dev,
+				"failed[%d] to add action to the misc-dev\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static void se_load_firmware(const struct firmware *fw, void *context)
 {
 	struct se_if_priv *priv = (struct se_if_priv *) context;
@@ -461,6 +1136,16 @@ static int se_if_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (info->max_dev_ctx) {
+		ret = init_device_context(dev);
+		if (ret) {
+			dev_err(dev,
+				"Failed[0x%x] to create device contexts.\n",
+				ret);
+			goto exit;
+		}
+	}
+
 	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
 		 info->se_name);
 	return devm_of_platform_populate(dev);
@@ -502,6 +1187,10 @@ static int se_resume(struct device *dev)
 	struct se_if_priv *priv = dev_get_drvdata(dev);
 	const struct imx_se_node_info *info
 					= priv->info;
+	int i;
+
+	for (i = 0; i < priv->max_dev_ctx; i++)
+		wake_up_interruptible(&priv->ctxs[i]->wq);
 
 	if (info && info->imem_mgmt)
 		se_restore_imem_state(dev);
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index 7d4f439a6158..41d9cedb05d7 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -13,15 +13,61 @@
 #define MAX_FW_LOAD_RETRIES		50
 
 #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
 #define MESSAGING_VERSION_6		0x6
 #define MESSAGING_VERSION_7		0x7
 
+#define SE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
+
 struct se_imem_buf {
 	u8 *buf;
 	phys_addr_t phyaddr;
 	u32 size;
 };
 
+struct se_buf_desc {
+	u8 *shared_buf_ptr;
+	u8 *usr_buf_ptr;
+	u32 size;
+	struct list_head link;
+};
+
+/* Status of a char device */
+enum se_if_dev_ctx_status_t {
+	SE_IF_CTX_FREE,
+	SE_IF_CTX_OPENED
+};
+
+struct se_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct device *dev;
+	struct se_if_priv *priv;
+	struct miscdevice miscdev;
+
+	enum se_if_dev_ctx_status_t status;
+	wait_queue_head_t wq;
+	struct semaphore fops_lock;
+
+	u32 pending_hdr;
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct se_shared_mem secure_mem;
+	struct se_shared_mem non_secure_mem;
+
+	u32 *temp_resp;
+	u32 temp_resp_size;
+	struct notifier_block se_notify;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
new file mode 100644
index 000000000000..f68a36e9da2c
--- /dev/null
+++ b/include/uapi/linux/se_ioctl.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef SE_IOCTL_H
+#define SE_IOCTL_H
+
+/* IOCTL definitions. */
+
+struct se_ioctl_setup_iobuf {
+	u8 *user_buf;
+	u32 length;
+	u32 flags;
+	u64 ele_addr;
+};
+
+struct se_ioctl_shared_mem_cfg {
+	u32 base_offset;
+	u32 size;
+};
+
+struct se_ioctl_get_if_info {
+	u8 se_if_id;
+	u8 interrupt_idx;
+	u8 tz;
+	u8 did;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+};
+
+struct se_ioctl_signed_message {
+	u8 *message;
+	u32 msg_size;
+	u32 error_code;
+};
+
+struct se_ioctl_get_soc_info {
+	u16 soc_id;
+	u16 soc_rev;
+};
+
+/* IO Buffer Flags */
+#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
+#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
+#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
+
+/* IOCTLS */
+#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
+
+/*
+ * ioctl to designated the current fd as logical-reciever.
+ * This is ioctl is send when the nvm-daemon, a slave to the
+ * firmware is started by the user.
+ */
+#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
+
+/*
+ * ioctl to get the buffer allocated from the memory, which is shared
+ * between kernel and FW.
+ * Post allocation, the kernel tagged the allocated memory with:
+ *  Output
+ *  Input
+ *  Input-Output
+ *  Short address
+ *  Secure-memory
+ */
+#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
+					struct se_ioctl_setup_iobuf)
+
+/*
+ * ioctl to get the mu information, that is used to exchange message
+ * with FW, from user-spaced.
+ */
+#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
+					struct se_ioctl_get_if_info)
+/*
+ * ioctl to get SoC Info from user-space.
+ */
+#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
+					struct se_ioctl_get_soc_info)
+
+#endif

-- 
2.34.1


