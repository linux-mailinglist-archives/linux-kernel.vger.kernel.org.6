Return-Path: <linux-kernel+bounces-215115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A8908E66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B369FB27743
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E61A01DB;
	Fri, 14 Jun 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBDWorS8"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8619EEBB;
	Fri, 14 Jun 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377628; cv=fail; b=LSvyB233omwjfMbi5l613nfa4Q2+tDO1Q8PLfvWbdoERaPyXRdbRSfvNQR/EvYRzu4vgIq4i80BQdHBrbroTjskjzDQG4a1fBSJ3MktXOGM2zBG/hZWADtv//ltlFm+tIyMYW5pnMF8MgRi7IEY1618EmAbMSSY4F/z/rc9L5Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377628; c=relaxed/simple;
	bh=dCwtPi/8EJVcD5gh2DMUVEwQe5fEGO87oefK9gHe6mU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rANd8pZNYjq5mnp2fh489T1VYDue9DjlCPb5h/8CsSkRyjAXCeUN16eZuYN0QHKO9fWGMZP/YsNeRWuJbXkTeoniV0/n0qa6u+kuDg0sYcBGSZrDXB5R14zjK6IHKUQ0XHj7CS5CCQA8ZKDqg+HlTVutLN1/RzZpM54SHwWgjFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kBDWorS8; arc=fail smtp.client-ip=40.107.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHtzuKVStif5ME0zk3eTPV2X/HXCzeCX/clz27Si7MX8n3/wv4/LXgvXxpnCIIoR3PRn8gvw1Nh7lEGqac0qypoFOVMsidy92Z2XiIfrcAandyNobK4LLT18RPWPIT4JHo1Gt78Uqodgvrl8x0xT+pix++h/shLi/yIXjGDuAK0UK88DDlKN/OApaXWySt1UCeyMXqB/48tpZjWjFlF60YftBYH4tlWHRmd5u5j78IkUKdwLF4K3bvOcCnhQfjUrw5uvKBqr8ANFOsc/qVv1Ibky0DR4Mx8hfsmhiNMXxorc0TXt6QDOx/8Fp1KZe1lK8IiTwYRIP4IiA+50p7tLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8G5qpoFp5Q8onqriaQOrAEkvT0GxrBUnT872PX/0Qk=;
 b=IyV5wbCR6o96zOwZ2YzpVx5cDUyq7hEVSbmCWkQDiVUkDGZXifnREiB5uhjJ4ZKQHT8x2aFzDGAPBKt4yCynILYEJ8ASoVWyPXk01k6ZvzZMGbb9AkVC0ERKjiUsEPOzcCYoMV7K9Hepz4ZSe0ZWFXwaJgz8/ob5vgPB/BCAbuwqs0/r29Y0+qNt6z6JqH93AULbWRw5l22xI5EUdX/g4Neb6QX6OYhs7uc8lCQmH9yXd3qK2P/AJmI7pj9HfQmAfqwWJjojjQ1NIf4xOdHTOURgkSwN5fFu9linjNTRUXGelikc0Iv2lvP3lKzPUpHQs5T3ZfkPoshfoB7K5QVdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8G5qpoFp5Q8onqriaQOrAEkvT0GxrBUnT872PX/0Qk=;
 b=kBDWorS8ZqFlqG9Bt3R/6U9zHduFNeSHlAf5bW/IxrnfUs9L2iaUNmpUUKQWazcVI6RIUwJfbcBbheBNbcm7o7R+ICkTlQoK4WMQtnxHbbZRZCcyrKrHhH9aSd7RpHoUcwtoRslHBhJnNuzi6PIf9BaFQ24fbhYYWhi5+2FKT/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:07:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:07:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:29 -0400
Subject: [PATCH v3 5/9] arm64: dts: imx8qm-mek: add cm4 remote-proc and
 related memory region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-5-8ecc30678e1c@nxp.com>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
In-Reply-To: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=2953;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dCwtPi/8EJVcD5gh2DMUVEwQe5fEGO87oefK9gHe6mU=;
 b=bMXBCJfWj0e171jC5lbiyLy3HbXM0XnGOO3ifGgSPET9UzXr08WIK6M5uLnHMM3APgIF4V/r+
 LpV33FPI0RDA7MuGC9naty2ksI6+RG/+fMMBVMnz7nc1Gn8bannFLL2
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
X-MS-Office365-Filtering-Correlation-Id: fab67cfb-92b1-4868-5a54-08dc8c83a6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVNBMTQ0MGlvWjF4MDFPOFFBR08yTEdOTjh4Rk91VzNUYXcrNEtvbnF1eENE?=
 =?utf-8?B?RXl2TFNKeU5Pa3EyK3Y5UWk4RjcrRkFtWlc4K1AzMXE1bHF4elJtblpGbG9o?=
 =?utf-8?B?NVdMSmw0V1Z1cHphTDVrVUxhTUx2eEZDalp0K1RFS0RGSjlYdFVnMHpUVENq?=
 =?utf-8?B?NkhRS3hsdW84OHMwSU4wVWVhTitwclJBS0NJVGVGWmE4NE5nTDlGODBacldI?=
 =?utf-8?B?SlF0b1U3b2lwLzc1QkxDeUdRbzR0VTlrU2RrOVlMczllcjNXV1phRTRBNDlJ?=
 =?utf-8?B?dHdxbVhYOU9NR05vdEdOdXdiTGEzMFEwTmlqSDM2MFBLMFZ3aG1oQVpOdWdX?=
 =?utf-8?B?L3ArZWI2TjFubFJEZCtxS2U0c3dNSVowRXk0emxQbHdqeHFwK3drWmdNWlUw?=
 =?utf-8?B?ekdrOEFvU2x1OGlCSEgwUENKOHpGeUR1Zm9Ob29EMkFwS3dhNlM0VkZCYlZv?=
 =?utf-8?B?STYyQXFSNGIwcDZSMHNaTVpWZWJWUGhUa29TRzRRNjcyNXVDVCtnWVdsNkw4?=
 =?utf-8?B?d3ZOZkxRVUFiM1hiczRhQzJ3ZGdrRDVUWE51RkV5L0x5NEF0QXhuNkt6dzNX?=
 =?utf-8?B?MkhsSVhBOXdyNHA4VjdUeDBXZm5FUitkNVJZT3ZuZVd6dHRiUjlkUTlPc21i?=
 =?utf-8?B?YTFlWVNab2pDYWVJaXdKcFoyZjVUZlcybi9HQlBhMG5Xc2RibVdNNHlJNG5t?=
 =?utf-8?B?dHp0eHM4S0t4OUliam1QejI2OTBMUE1vZW5zcjM3SENna0F4MEtSVWcrbE9K?=
 =?utf-8?B?aGxmUUV0Tmd1OVMyVzlGaEsrdFFVSHhFNzluTUtTZE5MZnJXUzBLczQ3K1Rj?=
 =?utf-8?B?Z2RmMk56YlloOEVqUjJLVUMzUFVzdDJQTjBZS2lYUXUrNW53WTBYWFNWSkZB?=
 =?utf-8?B?VUNiaUxwMnNCR1BLbWhvdm9tOUh5aTFxN2NNL2FzamI2MHFvVGdaZDB4c0tu?=
 =?utf-8?B?ckZBMC9Ib1IrMVdWd09JVmYzMjc5cTVoSDVqbnF6ck5rczJaNDhsanROTnZq?=
 =?utf-8?B?aUtZNVRFNmsyRXJiTkJIcUhNMVJpbmJSblhXSnMxa2dmSTFhWC9PaytyaGJu?=
 =?utf-8?B?REhLcFc5QlloVWdYWTViVVpueEVtbEYwdXhxRFV3N2tzRGlha09KZlVuR0Zn?=
 =?utf-8?B?ZkF0TTMxNnhFelpkZG50UGZ6U0ZPcGcxVkM1M01jaEthODIyNkVzYk9iZG1O?=
 =?utf-8?B?Wi83bVJ1SUZaOVkrNFNDTVFYdjZBZ1Y3YU5WSGFnb2R6ODdrNUFXQjBQUFVj?=
 =?utf-8?B?L2xIMEw5d0w5cFQ2Um8vUGtTTUl0NTloZm9JZVpXcWx6S1U2dGJwUXQ1blFm?=
 =?utf-8?B?Snhmbi9kSThlME1mOGpwbnU2SWxsRnBsbEhXdFRHV3N1dG5WRDg0aUJSaUpT?=
 =?utf-8?B?SjQyNXc5MHM1WUhDeWVsOVhLMFdaTXJKNnNkcHgxOS9zMy9tVzFJb3pjTTda?=
 =?utf-8?B?UjVYOGZyMjRBbzNERHQ4SkpyRnNFRGVtWU9hY2p0QlF3M2RLbkVpVzN4dTM1?=
 =?utf-8?B?cEJkSHQxYUQ3S2wxcGc4cnFMdjZwRDRzODFBUFBJckk1cUxYSCtWZ1BQSk5V?=
 =?utf-8?B?eW85cGxGeUtWWjFXUVhQcWptc2lKNzZKOENGbUhQZFVtRDlwcklWM2VuVTVE?=
 =?utf-8?B?blR0dU5Kemh5UEd6R2RUTWRnb0FEbzNVM3lUS0lFdWlCMmhscEg1Y01UV2dW?=
 =?utf-8?B?RnV1d0ZHZzI1WFVSckIxazVXbm9MNWlFUEZ5N3NrZW00aWNjZ1JVTm9KaC9t?=
 =?utf-8?B?eGFYUnBYanJocFVIY2o4ZVZQdjV6SHNacEFBdWMxTHI5bk5PK3lTYnowK1BO?=
 =?utf-8?Q?xkhyPiaQB5sQaXDwMs39h+afYK5krPVEyLgHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEZOZzVhZ2c4QVRYQXpoUDgxRTVTdmtOMTUyU1hsSmEyQXNud0hoSzc4Nysw?=
 =?utf-8?B?eXJFK3ozUkplV2RvcTJPSlFtSWV0QldoYlFOTExybnlHV0xDUklMZmo2RnVN?=
 =?utf-8?B?N2ZuUlFkVEY3b0JjSXBKalBmZ3NERzdkSWJ3UFJMdkk2dTA4L2xkcG1XelhS?=
 =?utf-8?B?Smg4WGtOUnFNTkpGdjZkTXRHSU5SamJlOUpnV2hxTm93eW9hdWJVYnBXeEVk?=
 =?utf-8?B?VFZLRVhGeG95ZHJNTWQ2eTZOM1ZOSE9mUDZJS01kZ3FUNEpJeWkzYTh1SXgz?=
 =?utf-8?B?aGdqVEJ1OEthMzBINVdIVjJTd0ZxOFFYa2k1bHlPZ2t5Y2ZSZXh1WFErUTBj?=
 =?utf-8?B?c2hmaGVKcDhTMmoyYytnZlE3ZzRHclZSMytuam5sUW1sQWt4bUZHM2FtTjVz?=
 =?utf-8?B?TWdJMm5lenpoQllhR2szVm0zR0kzbGNET0U1V0Fpa3UwVTVjWEZnN1ZVRUxa?=
 =?utf-8?B?V1JQRUVXYmRFU2sxVkd5OEpKU2VZRXdlNnZyeGNSc1Y0Z0VqcXdhWEtFSG8w?=
 =?utf-8?B?Q1B4Sy9iWllwUElITHlLOTZ5SFlnYzRXOWMvaVduK3ovZzZNMG5XbXNaUTVN?=
 =?utf-8?B?ZUlrUCtPM1NaeEliREdyU0srUDh4UU96cjBRMUExY0dFSXc2S2Z1a1N5bktK?=
 =?utf-8?B?N2xRTDhOYkFobURmU256L1dJRFJacEVqY1N2TTBHYk1CODlNNXg5eUNBZHY5?=
 =?utf-8?B?a05OSWRpVVl5czgwUmJmL092N1dvanRlSExpa0Jid3MrTzNZSk9vRVJHdHh2?=
 =?utf-8?B?RFpnWmdOR0xydWVEcER2bFpPZ3FLaUM4bTJuZ3dac2hCN25RQjI1akxkWFNV?=
 =?utf-8?B?enV1N0NzS1lCM0R4UDdXaFJscnFESlNyZ25OZmROMFRvY1BUUzNUcVdneGlx?=
 =?utf-8?B?NXdTMWxMKzlHN0ZLUjk5MWNNaEplNHB3WHFEZ1d5anM0bzBQMnNEODNlbmZU?=
 =?utf-8?B?d0kxSzNBTDZsa0VGUmJYZEtuR01iMmJDSlNidVphMnE2bVJYR04zdUpKRmpM?=
 =?utf-8?B?Z3NOSjk3eDB1MkZ5UVc4RGpEVUhtZWJxblFqaHd1ckRrWXZGZnlETUtKMUsw?=
 =?utf-8?B?bFFqdGVFUkFTRGVNcHlXYzdxYjVOMEZJSm9kdnYyVktDc043dXlOTXVkaWE1?=
 =?utf-8?B?WnNJMnlMQTNyQkRLb0FqdHlpSjFSS04rZURyMmVNOUFuTkFQaDM4Vkx0U0I1?=
 =?utf-8?B?cVQydUMrQVdHcGdvRFFndmxNc0NMb203d0tpRG9kQVcvUDVsZ1hnbDduMjNu?=
 =?utf-8?B?MU4wSm0zTy9uNjVPM0ZraGIvTWlLZkNhM1dyMlVrQlJ5UUx2YlVmVVU1b2FV?=
 =?utf-8?B?eGlaZVNFMXFGMW1TRU9hL3Q2VVZSKzBLL0s4MkRHV2I3RUZSa3JQakFQQ2Zo?=
 =?utf-8?B?NTluZWtNYnRsY2tLVWpWNTB1TDRDV3hLbmFKZnFrVG5hb1FZbll1cHlLY000?=
 =?utf-8?B?VnFXT01kSVBQWU11MHFXbE9wYWpwSFBjUWRiNWE5YTExeE9lbGFwTGpya3JB?=
 =?utf-8?B?cEJDbktJRFE4QVg4UHJRcTE0c1lYZHUrTHB0NGI2OStWQnBhYW1ocm9RR0gy?=
 =?utf-8?B?enlldTdaaXp5akFic2pIVC9QZkJFQmxsVTVOcmF0ZDR0NGc4YkVHYm1Na0pZ?=
 =?utf-8?B?Q0NyaWU1N2V1bVZrejRQd2NvREU3YVdsNHF6N0MwZndySWViUjVBWG1EOGlT?=
 =?utf-8?B?OXRwVk5QcWxRTExoRTMxWmdMYkJ2c1UrM2tOdFp0QlIvZ1UzeUpGTERyc1dh?=
 =?utf-8?B?b25PQjlpd1U1Y013cW52VVhqd2dMQXROM1hJQmFnbW5zN0JGQlNsNXVuTDRL?=
 =?utf-8?B?Vi9WOFBGblZxNHRJRkw3R0hObWJPQlFEWHdDUnJlVzVpSm5yVzBId2VhRXZE?=
 =?utf-8?B?dkFpcE1oU0F5TmVTUCtJK1ZUZ3ErMWZaMEFwMzAwdTZzUjYrRDRPNFhaVzZV?=
 =?utf-8?B?ZmU0MVVVVW1renNZbk8yQlNQTk40SXlBT3VvWnNaa2dDVUlEckQyYm1UZ0E0?=
 =?utf-8?B?dkhQbkRFWTNZc1pOMWltSTh3dWNTTUJqWmd4eFMxYmhlVEV0MTFCUnl4L0xW?=
 =?utf-8?B?R0JhUWx3VTdCNlVMR25rVTVYb3MwbGE5VVBkVjVwRGEwcVg0NFZ4Z0xKVEVX?=
 =?utf-8?Q?ghn99vuAIwcZnfiabHynq/vN3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab67cfb-92b1-4868-5a54-08dc8c83a6e8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:07:04.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ii9PcjMKFhW2500OShYcNFNIG/5xIqK/CC3mEteEphCsiB9S/x2oRs5PGYFqniExtisWMp+JKzsmOttpNUpgOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

Add two cm4 remote-proc and related memory regions.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index c024be33fbcce..dbd478af2e474 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -31,6 +31,68 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		vdev0vring0: memory@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table0: memory@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+
+		vdev2vring0: memory@90100000 {
+			reg = <0 0x90100000 0 0x8000>;
+			no-map;
+		};
+
+		vdev2vring1: memory@90108000 {
+			reg = <0 0x90108000 0 0x8000>;
+			no-map;
+		};
+
+		vdev3vring0: memory@90110000 {
+			reg = <0 0x90110000 0 0x8000>;
+			no-map;
+		};
+
+		vdev3vring1: memory@90118000 {
+			reg = <0 0x90118000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table1: memory@901ff000 {
+			reg = <0 0x901ff000 0 0x1000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -133,6 +195,37 @@ sound-wm8960 {
 				"LINPUT1", "Mic Jack",
 				"Mic Jack", "MICB";
 	};
+
+	imx8qm-cm4-0 {
+		compatible = "fsl,imx8qm-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1
+			  &lsio_mu5 1 1
+			  &lsio_mu5 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table0>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
+
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+		fsl,entry-address = <0x34fe0000>;
+	};
+
+	imx8qm-cm4-1 {
+		compatible = "fsl,imx8qm-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu6 0 1
+			  &lsio_mu6 1 1
+			  &lsio_mu6 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev2vring0>, <&vdev2vring1>,
+				<&vdev3vring0>, <&vdev3vring1>, <&rsc_table1>;
+		power-domains = <&pd IMX_SC_R_M4_1_PID0>, <&pd IMX_SC_R_M4_1_MU_1A>;
+
+		fsl,resource-id = <IMX_SC_R_M4_1_PID0>;
+		fsl,entry-address = <0x38fe0000>;
+	};
+
 };
 
 &adc0 {

-- 
2.34.1


