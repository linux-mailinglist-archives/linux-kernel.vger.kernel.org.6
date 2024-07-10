Return-Path: <linux-kernel+bounces-248372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2619392DC49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A883A1F216BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85815DBB2;
	Wed, 10 Jul 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CZLZGW3I"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62F15699E;
	Wed, 10 Jul 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652576; cv=fail; b=lxtVdxI24vxq3Ul1NP9vywkZ1IoC2hc521bP7AHwZf6+kuiSorpONkajKa1KYZ/3p4pFbirsCE95cver3lmZDZul+boOOHenqfK/XN2KOGgPV874IzzryC3iTsuUtPJO+Egt50oF1yh3m7sfeZgoH7GOTeJDjJ4q56wSfBq8kTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652576; c=relaxed/simple;
	bh=KIaR4KiuqLQ+BWXn1FoPuKby62dlXYXgqiFj7UAupHY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Fu8c1YQs/uztZJEwArthGhFeSUH4IEYf3iYwtQ/uINNn35WQm/i/1LRu+ETSpi4+bhs0vaO9O0sqWraKWidpB6s8c/O4hiVin7PqeSXWFbv5rKED4bfN0UayOAjVrZ6yrINsBA8hX5BsxW/jU95Xj+POQljPfraH0xDPwgKz4lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CZLZGW3I; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI/cIuBkZVS5uLKeA+xzKu91gPXEj0NzX36Tzwnyx7CejMjBeeiorOqtrpqejybyVBc6M28IqkrR/gU2t8nOfHf0uvDLpZL5YPuQJBSl9WNkgfesNIg2LTcIYFrADD47vtI5yKy5oNg0R/MLWKv4Hg/+Xw7cuUHBvYpiEBRC/LddSeL+rA449dRf7e1Q28pBMA+MxnwJEWpECo61bbx0mS81fV9PjLulYOF1PDyEu+aZzhyGDBe70SY3FRsZ49q+e62f1W0XBMU7f4G6pP7umkHmxNJK6iIfFw9X7hMO5XEsifjZTjuMZsvjaSI62XaMEkakc9QkhlxkF5hMNEdf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2OWyG6x4PTBJIKOHvsthpRWkAtMo3y1ItAo0YN6Dgc=;
 b=jLUv9q1el6kGmA0E3h7ffDkxAaeacCzB2Sb2hm6DJZA0SMbR+ox+2IsjullQVbwyKl3XK/LYdkitl3rNr6eAw0E4mcr7I6iPnuTR1AUfzICQcKd2Wwvlu+p+JQOeGPKrkDLRTtl+NEuWhiiT3K1Y+cVpLki+nWEt2ixqMcut26yxDU5OvlamyGggIZBm2fvNlsSHIsgGjX8IVb+uUGxO5tyeU+uPgs9SfubUPZxFaV5Taq3M1av6eLgwB2SCy/oyzGi2eNbNOOFiMQyumGQvjsRt2CPwhihJ+83U5gKj034hSfE8bMQnKAbLFc0Hyw302daLU1ssChqilGmkyWW3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2OWyG6x4PTBJIKOHvsthpRWkAtMo3y1ItAo0YN6Dgc=;
 b=CZLZGW3I8v6p0DAt7FQ4OEZm/sUvZrvCWplLt4Dtklx9K9IZtLX25k6tt46NvdbD8oyX+md1l6+PndUx98l2bGethC3poPHgoUEt31HM+NHhnCOYxt9gpRYymCHiovhBJMLCbNIA5R6bhyHI7AjZNI1tfYU9IDVF1qjQohCMNZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10751.eurprd04.prod.outlook.com (2603:10a6:150:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 23:02:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 23:02:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 10 Jul 2024 19:02:24 -0400
Subject: [PATCH 3/3] arm64: dts: layerscape: move dwc3 usb under glue layer
 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-ls-dwc-v1-3-62f8cbed31d7@nxp.com>
References: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
In-Reply-To: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720652559; l=2194;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KIaR4KiuqLQ+BWXn1FoPuKby62dlXYXgqiFj7UAupHY=;
 b=zuB4jrZEFslV5TtndQ0K23pgygpf57RZdg2Nu4KbFIC2w37t5B1+Z6HxyYDbwE2A6Al61X4b1
 ohoXcT8mvw1AE8xzrjznaX/jwzMyrKAC249ZYxTQm1zsu8jLwXbPEtr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10751:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e98d81-c276-4b19-5758-08dca1346d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFpscm80KzZvUGRJMnRUdnl6WXNscW53UzluMEVnWW0vbGNKcGdDS3RLNUJM?=
 =?utf-8?B?VVVMcHdjQ1FuRG5FbkhyU0R1aEU1b3pKd0lpVTc5VExsY3B2ZFRyVUxmYzZ6?=
 =?utf-8?B?ZW5QTlNLMHBVNUtDek5WcmJlRTBHaG9HSk50dHJNTmdGcldNTjlDeFRZVHJ1?=
 =?utf-8?B?aThqNjRWRnpZcU1sczdhUjVOT0JocnI1WlZSVzFzdy9xMlhyNXVqMFVRZWN3?=
 =?utf-8?B?bWRyTUxpQjhEZzNldjhaS1JEekV5dWZyeFVrUGpyRDZpSlYvejdORzd6NTc5?=
 =?utf-8?B?V0ZXWW5kT2VJMlJ0VExVL1FBVi9KdUxWRzZxKzE2SDU4ZkhYVG5WbmxIclhG?=
 =?utf-8?B?OXgyQnpEQUxSdVNuSWxFTDZSNjRFWGZZR1hlWU16NU42ZnoxeGJ6R1J1d3VD?=
 =?utf-8?B?MWZ1QVZCNmgwdDJGVnFsdUJZYXR5M0h1UzV4cDFCUXVXUXRUVHY2b0xueEE3?=
 =?utf-8?B?ckdvSUM5bXlpRHN3TTJvdXdoM1RxNGRLMktoWnQwRlk0UldnTmdlMHBGa3dJ?=
 =?utf-8?B?K2lHU1QvSDBVSTEvUytUS0NvNHpucEhDdFZHajFYSkZwM0RqckZFZmhiNFc1?=
 =?utf-8?B?b1piZEtLQ0RNM3g0RGY2NnBrdG1PZWxmZzlDbi93b2JFL3JnbjFRVFVReVAr?=
 =?utf-8?B?bUJWRWMzQzU5T0g3ZVdqRjJBalQrTDhGeTZhTENIajcwUmxDNlpzRVhmSGln?=
 =?utf-8?B?eld1cVcxdjhsYVA4eDR2T2dBZ2pKNnpUNjVCRHhUYTExSUhWSzNXTGJnMzQ0?=
 =?utf-8?B?anNqMGplbnVRNHlHUjRoWGdlNlo3Q1pZb0NjaW5nM2N1OHpSMWovVTlIMGFz?=
 =?utf-8?B?bUJwbjMzcFpyeVlEREJEZnJtU205LzEzVGgzS0pmTzdHTXQyUTltc0tQdDVj?=
 =?utf-8?B?K1Iwc2g2TGhIeW1nSWpqSlAzWUtWdDhid2NRbDExbGsyQVZGVzlGRno0ZHZt?=
 =?utf-8?B?ekhBNmNoeE5vTm41UXhEQ3NHdVIyQnA0UVlXZFBZR3JxbVFaVUNTeG9aM0lU?=
 =?utf-8?B?L1NyTXd1Y0VQY04vVmJ2akRUOC9rS3QzNzU0WnBKeC9yMjIrZlJHbXAxNHZB?=
 =?utf-8?B?TlRETnRiOWFDclJBWElYTlVYNW5pQTdFKzV5RFh4L2xJNmhBRVRrZDAzbkZB?=
 =?utf-8?B?MDhlcVFIU3cyWXBWMWxaenJIOVZyMHBKdG93U0huMmJ6aEJsbThGUUVqVTBj?=
 =?utf-8?B?TEZub054QnhUbjU5bEwzRHpnVnI3alh1OEFhUXJnZEtXZXpjWjVnY2VqWmV1?=
 =?utf-8?B?Z0NtdHRsVm5NQlJ2R2ZiUFd6TzVDYzY3ZkZtQ1U0SXFVSjhoeFYvMmpJZkhI?=
 =?utf-8?B?R3gwbEFEWUI0d1NPbWVGeHpnd3JibjlBWHQvNm5wTEtObHBmYUxBTnkrUTl6?=
 =?utf-8?B?djRnUjZnK0VSZmJVOTlvdlVCNjN2ZXZaT3ptRDlBN2NnZVJqbDM0TitKcHU0?=
 =?utf-8?B?S3V4TlhBekpBbHltdkFaYVBLMXdmcDM2SjYwRnhNTVJNeUE3emJsQzlDeHpU?=
 =?utf-8?B?bzFKQzFoMythOWNZRE1OWTFWQjZKSC9kVy9XWUgzQi84bFBaMklaYlUxN0xD?=
 =?utf-8?B?dlM4TGI3TU9ZRHgyZlhWSEEvQkVPUVRHR01TSEppQjN6QVVYWmdGckJzcW5T?=
 =?utf-8?B?ZWJ3eWJGQ2xKalZKbmNyN25JazVscTJmeldqWFY1Y2RrSEduU056NStyRU5k?=
 =?utf-8?B?UDk2TEF5ZEZ2amNWRDJ5T3BDbzkyMm05SExpNmt3cythM3hrK01Ma2pvRllL?=
 =?utf-8?B?MWRld3g3K3hUUTJtTXlld2dmUUh3TmUreXJyVytPSThXNTk4alJUQ0l1dC9t?=
 =?utf-8?B?d0FrTnFDOGQyZFF5K0RCcFhnemlEWEUzRE9mMmJ1azdyRXVwb2NjWGRCYmJx?=
 =?utf-8?B?SlozTjN1N05wYTEvUDVkay83ajZUMlN1MWpaK2NxeXhwR3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVhqS1RMWlg0a05vRFhNNTJmMnhqOVY5Y3U0eFBDaGJQdUFBV3lUSG1JSDdu?=
 =?utf-8?B?Z1gxMElUWGhWUWFmYUZWMUZQSjhXbWpOUTJFdjM3OU4wUjRXaC9pNnB5aFhh?=
 =?utf-8?B?WFlYTVhFUzl6TEp6Q2htbkQ5QkhmKzN0ZUlSZWxWV0JHVE93TW1abUJQR1Bo?=
 =?utf-8?B?RmtNejUwdWs2T0JwMUx5RTFsV21wdDRFUGowUGpKR1lRL2JWWWJ4YnFvQytN?=
 =?utf-8?B?U3czS0dtUWtsMkUxZnEvbkpLY3lyZ3pmTGhKUVBubWhBNDJ6MnFEVG1mZzlt?=
 =?utf-8?B?WFFITmVOblg3UDMrRFRBa0Q0Uy9TOXVhUlpLKzNOVXhZclh6NlJHdGMxbC9u?=
 =?utf-8?B?NFh2Q1l3YmlINmtmZHhYQXRaQUVEYnd5b1lZSndSZitGY1BvUXozcDBCUlE2?=
 =?utf-8?B?Y0hXcjJZRGNPTmFiZmVtMXRnakVXUkpkdXg3NXc1cjNWV1BlV1ZtNEFNZVZZ?=
 =?utf-8?B?aERlblE2eFFPdTdLQzcyUXdyNkpjRzFQNkt5a2NudGhFQXlMSlBYcmh5TUlh?=
 =?utf-8?B?RW5LeC9aQktPYjZ2ZWpUNUQ4cVJUMmM3bjhaMldiNkg1L2l4K0hHRGJIZk92?=
 =?utf-8?B?RmdrUE81ektUK3lhNWtwT0Nac1BuUzF0MkI0YnZjeEIrVVVwNzZBa1dsV3Fl?=
 =?utf-8?B?eTNLSmVWdjJ4VlRVeVZtMU5yczN4aFlSdmFYcWhhUEZJU1U3WDg1N09teVhu?=
 =?utf-8?B?T1QreTBmelZHa1dvazRPM3pZTWp1WEJ1VDBFSjZmUG1IdFJPdlcraTJRcFZu?=
 =?utf-8?B?Qk9jdFNLc25rcjE0ZzM2b3pxa1N3bDJaNUl5dGNuUGlYUE5KQm5UTVdPS3Rt?=
 =?utf-8?B?NzdndWp4c0JOaEU1OE1pc3BtUGZUdjZYY2t3QzZReVk1Wm12bHo2L21KVm9Q?=
 =?utf-8?B?ZE0wREFUNGlsY09jc24wd2VDdE80VUdPWDl4WXhGdTlGWmlocWlIb0ovTGNv?=
 =?utf-8?B?Y0ZxT0FGdDY4b2NleEJGSTF5ODlkZlVVZzJkbDNEQWVuU3htcm9SWG80UUhR?=
 =?utf-8?B?VnlmMU9WdHh4aVFqZ0dOZFlWWHA3R0FQdkxxVEoyOUVCbXRORmlOd2JubzF3?=
 =?utf-8?B?YkhWNThWOWtpTmxJSzdaNmxoMFBLUTRlQkZkNXFwcnY4MDV4NmxNL0gzWSs0?=
 =?utf-8?B?VWhYNHVDQ1gyd1lMbEFIYXBCNlJ3ZEQ2SnEya2x2K3Q0WHJNWlpDOGxGNUJ3?=
 =?utf-8?B?SHJZL0lpTWFoUTE5bE5kWk1uTnViODArSnJURFI3UWJNTGxaRGx2TXhGaC9o?=
 =?utf-8?B?a1M2RXVkd2xIOWRIc2ZYbThXME9zMERpOHA4K2dvR1k0ZUk3ajcrNnh1UlpL?=
 =?utf-8?B?ZHdMa1FlTkNiZ0lnR0E3OGVrdjlubHorMmtHK2c4SG1oZmVQTmI1YkQ5aUo0?=
 =?utf-8?B?Yk1rUW9oR3Q5dXFGbjcyZkxEOEdJUG1VR1NQamIrbE1QR1RtZFh5Z1BqS3lS?=
 =?utf-8?B?dDVYcWdGUFBDUGIrbVhQSjJEWlNLTm9HdUFoemNyaVovQXdldUhEVFlpY2Fo?=
 =?utf-8?B?OVUrNU93OE9uZS84U3VnWTU5dWhGV0xreXZxUkc3NExqQ2VsbXpRTGpLRjFp?=
 =?utf-8?B?RFJUVHlKTlM1UDBZamMyL3dNeW1SVVBqTlF5VGRJM3dVbXR0MlU3S0NpOFBt?=
 =?utf-8?B?cjBSdzlYZjlTRE5TR2xURlVUNHlaMTFZa1d3V0dXdGlmK3dnMHkvS1Y0NTlP?=
 =?utf-8?B?UXRQVm9kTUlIVmlvOHY3UElQNWk2ZkZJUmYzcWlJTXdTSGwwbVZhYkJtRk12?=
 =?utf-8?B?dnJMNGdqcjV0VFFYbnRDZldOdDV4czE1Z3R2MTcvSGFtSFRsQUxTRHdNSTdm?=
 =?utf-8?B?L2NwdGQxRWFMVGhLRHMrbVdYNHR3Q1pTQ1J1OWFkRVdlRzV4SzVtMlFNWVVX?=
 =?utf-8?B?Ti9EQ1h2NzZML3ZtSm16RXBRQ294L0hCckk3d3d0bDJSUVJFZTVra0w4eUxi?=
 =?utf-8?B?bVFQZVJQVXRzNm81UXZOckJzcThDeUNCeGx3M2lsTXY3V0xlZnJMZkMwa0FM?=
 =?utf-8?B?MVVxQ0Zxa0h0QkRwUnZSelJOTEwzNEZXd012T1QvUThrK3ROeGNuRCtQcTVi?=
 =?utf-8?B?amJhNmsvbEF2dDJrcnVRWTFVajVVTVBLeXExOGxGWStZUVVjOVJxQzhHZ0Fn?=
 =?utf-8?Q?Av8h0zp9r2SGKnX8oXq9GUz3T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e98d81-c276-4b19-5758-08dca1346d6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:02:52.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjgVK90WC8YhtxOa85si1zAGGtVT6CXQyGDbwA2aKG2wNU88JxHp7sFAv/1O5CTG8t2ZCZGkJGDmr9glAjV08w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10751

New usb glue layer driver support enable dma-coherent. So put dwc3 usb node
under glue layer node and enable dma-coherent.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 43 ++++++++++++++++----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 70b8731029c4e..24b937032480f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -615,24 +615,33 @@ gpio3: gpio@2320000 {
 			little-endian;
 		};
 
-		usb0: usb@3100000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			status = "disabled";
-		};
+		usb {
+			compatible = "fsl,ls1028a-dwc3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			usb0: usb@3100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+				dma-coherent;
+				snps,dis_rxdet_inp3_quirk;
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 
-		usb1: usb@3110000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
-			reg = <0x0 0x3110000 0x0 0x10000>;
-			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			status = "disabled";
+			usb1: usb@3110000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3110000 0x0 0x10000>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				dma-coherent;
+				snps,dis_rxdet_inp3_quirk;
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 		};
 
 		sata: sata@3200000 {

-- 
2.34.1


