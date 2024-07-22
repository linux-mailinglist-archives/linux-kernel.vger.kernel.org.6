Return-Path: <linux-kernel+bounces-258460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DAE938826
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B67628136C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF884182B2;
	Mon, 22 Jul 2024 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TPJgPxzO"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013069.outbound.protection.outlook.com [52.101.67.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DF17BCA;
	Mon, 22 Jul 2024 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721624114; cv=fail; b=SAWG6+7p0K5QIgW2At3Tsdn8YlDEkMHeb8GC2Ub8IORTnjlg7iFiqHm4urT6nz0H+sxTfrmEc6Vk0zKbM65lqKHV49sHxOPHIwxfsoNenTdCeb0wb9fiNe4TPnJQQQ4IV7s6vbiNIDXm3jevRqzC5L7EXTMLXSds/mFb+elaYYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721624114; c=relaxed/simple;
	bh=F5PBU6HEJnLOEw22QrtmChLOyWD4RzexFLy5JsDgR3o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BAmfy78cyofNSzMT2Lv79SoO+4HKGt/jY36t2W5sHSpnYnMStFyiq8OjUrJJ/RlAbdte8m/+IQqzSIQK+NAawQkI9PAJvxXUvgHJIYKGq7HEUP97HWjP9l3ZZyn5VZYt9hLwVSmKZAQEfjgfwoJ7PCRQImdNUVT/He/BnHNa1wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TPJgPxzO; arc=fail smtp.client-ip=52.101.67.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5MXTH2kZbznGB8bymNqGEtBcEoDbglKdnakkWRI5ThG13xvRnuxb6Mx3MtHqcXPL4b+Ci21/lyi87uTKY6nzcSczJ2rUPjuAWGRE5SS8D/cL6SwpFSeYCsmbPhoZCzIzv1sGaAx7q7MEJXlRHx26Sj0hf5Y95OBmIMptuy+gASNdAgMa3fzUg4mfs6kzFerLv/k3aIjTa4cwlY+rP5GacLaS7PLhfVFxUp9plDMGO/XwuVdoaksnClEGObwVLuuzYFpW/bHrDYd5amQjt38CXYr2AVLtKNRc772DRJCgN5w9oooaqst340EueAHVsbg5ijSujHZOgs9RZ0qwNZ23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PDXRfFJa6d8pASsCQxQPxLFvyuEHEecmuzO3dViUIs=;
 b=oOkR5N3D4dZJ2/Egdgw7WKMKgfFTXazoP8c1jZ6AC2+lrYFQVfNHzw2w10wOUTq311X5XOoyNYm53kz3kvseEaaUKX93GV9sasZY+isP/nn3rmQl8T2ciT/7EHYE1reewLRxWEWkm2rgKCg4b4KhB5uiU6IWg4oM3YAKOtpTcMgHf4imqCm5tqfGJ5XJoemBklcWEV77O+ZPEec3o59Z8DrIlkN3LIvrauV+FY+dWDx0PGWNHN7ED0Q5DlqESShmUMkBA8S+lIX4HumTDs3pPZZkTkmJrm+d7wNBu2Re+Xu5K+bT2PvDgqNV+oGS6QGe3dtwv+wRO2zYZ3tsWpqjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PDXRfFJa6d8pASsCQxQPxLFvyuEHEecmuzO3dViUIs=;
 b=TPJgPxzOAC9qU/HuQO2asyn3DjlMWH4c+cXA4KLCttpB/3LWGC6o6W8fWpwiwF4ZDKV5erM/xBaBJ8SsUzIiWqX9Btes+yAC/F6ygfcKD8nV5Op4XHYGkjP8SCydaOFCwo6knqBK9vpDudTPSmRdoXtKtkIjE0GgAlX0Jg4+TqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 04:55:10 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 04:55:10 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 22 Jul 2024 10:21:37 +0530
Subject: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
In-Reply-To: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721623911; l=3098;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=F5PBU6HEJnLOEw22QrtmChLOyWD4RzexFLy5JsDgR3o=;
 b=H5QLDzdsOa8D3Uqmr0MiV4dbok85T4I3nq2GPZOGsDYh6RJFYPd54fLgjHTMVbUXzWxqQ5rlK
 qpJ0tocWvGJBieoGyyZklTjJ5/wiFDEdCBvunNfDUm2fNj9AVr6bjP/
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA1PR04MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: acd3c2f9-6d13-4309-ae42-08dcaa0a76c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEhsK0hjYnNuekJySjhXanNUN0U2MEE3QndLR1JyVm5MU3lLclQwY0dsMmc5?=
 =?utf-8?B?M3Z0TjRvSXY3aWdVSld1Y2NGYk9mMzRnRUpOd2h5TUZ6WU9EeWpGQlg0REtW?=
 =?utf-8?B?elBnOVZzZmdzb0FZZVNlNjNXZlh0bmJpalVBM2dxUVpwTTFSZTBaQk5DSnlX?=
 =?utf-8?B?TkswcllwYm9JN2NrVE1SaU5yTWpEeHd2SDViTFY2V240dUE1U2ZxWG1kZEJO?=
 =?utf-8?B?UmVsa1c1cWhxZkRkUkY3RnAyOU9oVTYrRHhYT3J1VjJEU2t2YnZ5eXkyS1dr?=
 =?utf-8?B?SlNiSDB1TXBXanlkYUVpbTV5NDdjdjdDN1A0VG5GaWFNVUpKRHNHckQzSllS?=
 =?utf-8?B?QWRJRnNzRkdYR3Z3bVVrTit4RXkvMTJzemR0ejhtamhtczJ6SUErRUlueGp5?=
 =?utf-8?B?cXR6Qzl1M0NpRXJIWGgxTVVTZExOZlFxRlkyZ2pHWVlvV0FPd2hmcUkxZk03?=
 =?utf-8?B?TEx0eGxGYzlXQ3QrUDNFMG1HWFJONkx5bzdUY1FweUhEaCtGZkxlRUpNak91?=
 =?utf-8?B?NnlvNVFxWEx1a3lHam4vOVhtMkFEZ1FXQWY0RHlXSTVUNWpRVzdOS28xSmVJ?=
 =?utf-8?B?WjlFQy9Pc3QvdHJHMjMrZmI0RnBBUUVYME5MaDdNMEd0RGdwNVVlTlZnOGRR?=
 =?utf-8?B?VlFaREdhMm9VeVRiQ3RsNnplQjdQSTZBNFNoYkc5WHBzd056MEd0eEZwUlF0?=
 =?utf-8?B?WktBVVpYTUpJZzlqOThPWWVsZlM1YjMyN3RFakZEbk90VFNneGNxc2FzdGdu?=
 =?utf-8?B?VzJnNkhRa2hjdEJ2NmlLTldBZUNRQitpdWZVQlNRaGFGc2lURWZaRTFmb2Fs?=
 =?utf-8?B?UHdSTzhSU3RvRkFMY3F2N24wcno0TmFxTmpmVlpac1NVSnNPOEpvYzBMT2lJ?=
 =?utf-8?B?dHRtZUZMNFIycTZTR1NmMTZxTXpuOWFwSlRKek5iWDZ5dStja2tmR3JMQnc3?=
 =?utf-8?B?VmlyR1g0RGdkcVpOVk1jRzFHbWhkSUVJK0QyaFFhTGZkVTZ2bE9iZFh2am9R?=
 =?utf-8?B?UkVvVnJNQXJMbTJGOXdES2hhMDJNUWtOdjZVWjZVNFJoQmEzb2I1MVRmbjNU?=
 =?utf-8?B?VkRmd0lDalBLdHF5QlZyNDdTcTlvTFFnOUltNmZzRExrVlRvQUdmQWFPcnBX?=
 =?utf-8?B?eHkraVhIaWpUM1VVQ1hRQTJiS1diaU1sb3RBaDZRR1lRb3ExcmhhRlNBcVU3?=
 =?utf-8?B?U0MzWmp0UnU0WUs0Tk9TTXREMnlMT3c3OXkrQ2FkQmZHdTF2OEV0MHVyaEpS?=
 =?utf-8?B?NkhMaHdoWXFHUXZ1VThZbnFzWEVxam02TEtYYUROdG13QWFJc0FsNS9CNm5B?=
 =?utf-8?B?OGtQK2Zkd0xNTXNVR0ZrbEZjSi9MTEx4NFY1UVNmQy82QXYzNURvN2VpWVRX?=
 =?utf-8?B?Mk5qdjUyWTREWGE1R3cya2hVL1dIYzRVQjRvNTdhb0k5U09hZm5OZXBRbGls?=
 =?utf-8?B?YWtVMkljN1pTMWhDWnZHL3VMcXRibXlnK05IZVFkZmUrOXRVMzBxak5ybnds?=
 =?utf-8?B?MTBzN1VrSjE0U2RRSi9OQlJYcjAzWUpJTEEyK09rZzBmMDRlZytFbUczaEhO?=
 =?utf-8?B?Q0MxL3pNQkllUDFjMzE3ZEpiNWVoWktZYnBtVU9VWHhFcUpXSFRsMGg5a3oz?=
 =?utf-8?B?ZVVMZ1JIL2dxN0w0QVBERzQvVysxTUlacDNpdWJXQjZFY3YwL1VnVjg0U3Jk?=
 =?utf-8?B?RVJIVDRuaUxzNjZtaURvenBUMUxaSXNpQ09XYkRKTU5rRVhNUlR2aVVxUnJI?=
 =?utf-8?B?OGR2NVhuK3NDMXovSEt0U2dxcUEwaGZHUW1iUEZFcml6TFZKTnZYNDRNMDdF?=
 =?utf-8?Q?mnHXU9Vi03FLQHQEh9jmjidFctO9Ed6O6amhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1VqN3h2dW5yeVJzTnZVVzJjbWw2YkxDbUhiQnIxVGk3eTVITnlaYkZFelJY?=
 =?utf-8?B?RUZvaGx6SkZ2NUZ5RUtXdUE2ZVNZL0hnaWd4aW5TWTNLTlpaLzJpWHdleXJZ?=
 =?utf-8?B?emU1ZVhQaVNOb3pkTlU2VFgrc2FJdjE4L0pCOEFRTE5GQzNSYUx1ai9RUEc3?=
 =?utf-8?B?WUhkWExldVVxTFpsSzlydS9tSEczQlM2Q0hCL3MxR1FrQ0RZVXlMbjFlSXFL?=
 =?utf-8?B?NnBOb0x1UTd5SVV3UDF3Y1prSXkxc0tiejZaWFAxeTJMY0FCZjZObXVETmZ6?=
 =?utf-8?B?ZGpjWXdrN1JaYjFodVQ4UC93dVFieS9BN3dXQXFia2JnWGNWZ1NCL3FpUGVY?=
 =?utf-8?B?Q1pTWWM3OUJDNUxZVlJiYWwzUml2M3VxRXdGdTJib29ZeFpGdWJNRnpHRE1v?=
 =?utf-8?B?NW15NXJFbkNwSURBZ3hEZVlTMTJnY0kyVmdwWm1ZQ0xvWFo1UVQ4Nmw0b01Y?=
 =?utf-8?B?WEZDN01wV1J6OC96enhIQkh3bFZYVmw5RkkvdmNQUlNnNkl3REkwdGtsM1Zh?=
 =?utf-8?B?SFJWVlZMRTFGTHB3VzJ4cGF6QldhS3N1RFliMFl0WUhVMUEzQmd6dVBkSWdY?=
 =?utf-8?B?T1ZvY1JmNlhPREtxOG1WRnp1QmlxbHUybTZqRzk5dXhseWd5RVU5VUk5WTRs?=
 =?utf-8?B?ZkNmcmg1V3VPS2JIb3dZOUEvZkpDMWltSXBxbDZibzRnRnhWUGpnbVRZbjBq?=
 =?utf-8?B?R1RGUHEwdnR0cjI5Z25GWFR3ZnN2VkROU2tNcDdHU0EweHNqdXozdENoaXp0?=
 =?utf-8?B?KzhKcHFpc3NkK2ZpdFdhRmdOOTlBSFZqdmtlQnBzTy91S0tqd2tuNkpzSmFN?=
 =?utf-8?B?Smc2QklheXRmK3RnelpyOUdBL0dSNnhQR0ZBL2N1M0lLbVUxTWdJdzlDZDFu?=
 =?utf-8?B?R3BvRW8rL2dJc0VSWDM2enNMclRabnVBZkxjREpRVHVPeUYzWU82bEZZT1pE?=
 =?utf-8?B?MHlmR1AwM1VpaVBRV1dBZ21kZFNnRXR0OXZTeTZEQ1ZXa2pobUszbkN4SGFZ?=
 =?utf-8?B?NWp1ODlIdWpZV3VYQkMrOUhJZ2tkOTJ4VjZsd0FDaTQ1WFJmY29hS09veU1P?=
 =?utf-8?B?QWhlN1ZSTUVKeGFuNG1tT3loVVlGUU4yTjJ0UGxBUkJERTJjRjRUTDVsQ1ky?=
 =?utf-8?B?clBpYWxTd0llQ0p5OWV3SUZtZ2kyaGdXRVJtektQWXovSVBnSE9uNW9meWlV?=
 =?utf-8?B?OFhqWW95aVZISjhOamFXSGxNbnZGRU8yRVhNSTRnVGtmTUxtcEpKTzVlejhP?=
 =?utf-8?B?bHJQOEMxQ04zVDFsR0tBN25IYml0b3hlSTZ0QURkWlVMT2hzMHZCeW1UaFRl?=
 =?utf-8?B?elVuZlZQKytCREY3WWd0ZjRIMFo4K3VDOGd4UStWTm9jTTcvY0pzVkNzckFG?=
 =?utf-8?B?RDZkZDNxUTlyL1BoaVc3MWtSQ01EMnJnZFhLN242ekVjNjAwY1kwL0pLdEVi?=
 =?utf-8?B?ODlFS20zSE1LbTFFaUw2dUR3d1dDNk0wR1V1N2hxNFZadmk0WS9vRkJrRk44?=
 =?utf-8?B?ZGRaZ1lwMm1maTAwUkp3QUZTQVRWQWlZS2gzblJWTnBZOTZTem9xSnRjb1Vw?=
 =?utf-8?B?aUtYZ2g5ZnIwdVBiSjNpM3Y4ZkxROTJZQSs3MGIvQmhXY2RtcEtHclhvaStU?=
 =?utf-8?B?a1dYSDJiRnJ1SUFKNkNyMVJBQytKYm9tbHdOeTM3cnZkbkdsajl5R1duanpW?=
 =?utf-8?B?SGdhQjBwbyttRzNKMXNZTXBiT2YxaXBFOEJaWDUxZkJ6QXJrSjVzSHhvZG80?=
 =?utf-8?B?SUJXdGVKM1l4cXA0ZU1LdDM4aCtSSmZQR1p2bTRQZ2pRSTFIZ0I5bnRCdEJI?=
 =?utf-8?B?RUQ0d0pjQ251NFRCNGRyeWFMeFZ2djZtSzVBUDlPSnBjWkhrbTdCcVRYSGsx?=
 =?utf-8?B?OFBYc0ExczFueE53ZWE0ZEtlZzJMWEg1NHFPVVg5YjlnSEd6TTN6NXE3c3lk?=
 =?utf-8?B?dXRUa1FpempJYVFrd0JDYy9yemd1S3QvdlhvdTJZSEo2Rm1ua1VjN0d0dExw?=
 =?utf-8?B?VURBbXJUUTRacmZpRU5mdGNEZEdDeGVLdGVDN05XekdkeU9MN2l1ME5Gem13?=
 =?utf-8?B?QmdqS0Qvbnd6cy8zT1VhMERhd0lDOXhMclRJNVRFWFNHV3h2NTcrV3F2R1Q3?=
 =?utf-8?Q?ut4vLj9wQ+caLY2q072z5Esnk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd3c2f9-6d13-4309-ae42-08dcaa0a76c7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 04:55:09.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IF29kStf89zmuSqqHG+aN3gDbnXO/FuI79+SlooZTDMEJDJIeTJ9JDHaOoupW47k8CQG96GlKzNPZR1CuiQLcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441

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
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..7511d0e9cf98
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,91 @@
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
+  Communication interface to the secure-enclaves(se) is based on the
+  messaging unit(s).
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se
+      - fsl,imx93-se
+      - fsl,imx95-se
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+
+  sram:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
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
+      properties:
+        memory-region: false
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
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    senclave-firmware {
+      compatible = "fsl,imx95-se";
+      mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+      mbox-names = "tx", "rx";
+    };
+...

-- 
2.34.1


