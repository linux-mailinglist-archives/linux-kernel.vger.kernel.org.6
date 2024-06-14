Return-Path: <linux-kernel+bounces-215117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18C908E50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D065E28B4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81451A2C2D;
	Fri, 14 Jun 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MmQqfNj+"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27F1A2544;
	Fri, 14 Jun 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377635; cv=fail; b=pMSScQT2ohtKfG37fBrVdxOOl/f5RdAH+KyQsZyaXLYORlRtPNli1Xlsso80y6dIcs6FJUrWLn1JRufZVOV4xv79Sijai3l3OWYx1w8S8nbTqHoaNT60p0Hxxkbx07UJDzaq51liPMZPR3EafWSFyI+htOnXOUUVEQeqRye0ats=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377635; c=relaxed/simple;
	bh=IzehZz/tcy+OhZEkvv5yDy+VxEZsjK9N9TUy6La0efE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PEx+VDW4qw1/vyETDFMG50kKi/liPgWSRSIPJ/8PSWZKrXjXWTB8SUyP3e4MZealCrqMXtRCcN4kSXS2GKQ3umcnUqxx95o835MDUa/kNjOaOJgVZ20iU6djexQ5k9rD/+SyrorJootXWR7VT+fFCkqGZaLpWpwsRD2Azg1pSs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MmQqfNj+; arc=fail smtp.client-ip=40.107.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCrwc2dYePDj6xb28a6n4uXrB0Fnapjt9+8NgbtKUgnP+a02863One7s0RAvqYUZ0mtIdKCkYMtFIlYZCClfWcP1VVu06BOBmjfnvvETcL2GegRva5447i7FGouMKihNfwDquc/Eq5WR33c3WrUPC4jZbc94YX39oJpMe65jaUJrQNurepPWxeWimeE4BwPxfY7GkavRgoUOPedLAbzxRHMZVss08CjotraqY1YmvLZU1Q2RtBn+c/y59y3KPKndtdcY2Qvd7c7x3ukiDuEXJlIEikrUMNFH41y038RRsJ0gVWCVJHW98QuufpSr11c+c6BM34XjSD+0qHMlgvYPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haeK8I07Q7QcIqVN+q6IdsLyvhH9JoPZFR3uZWs4m+w=;
 b=FsnIkLSC5RQfSBt9W8bgAyWwhmJ5/+IqWofqjDimgpWNhmkLAVyPOAl3/k7GKErlTsv/v8da/huySaHuGFDthZfz19ob+oZfMCXbII43+cfhtuu3l0yXQ+EoIjzVYlWRH4tDzfFeOdIcLJ48JZHr6jzy7seh8FweCa8QkDZj9YibzznxKQnrLD6EoI8BycRvZ4XTTYV9VXPdQG65y1hqL85Ul/6gZ49PTsMbB4T+ZvbZXpco2DmjC4wUzwZFsWEUO2AnAK23RUax1PcF8HfE2Icc9/r1J1BjWHp3t/xmdtUU+rZA6FEdssXzz75XHxNiQzpbv1UFQXpeSxoZfrV7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haeK8I07Q7QcIqVN+q6IdsLyvhH9JoPZFR3uZWs4m+w=;
 b=MmQqfNj+xbSL3dvmtcBmCjKYnzIxExpvCszcyu1LCxYfuW8Osw59yu2jG0qcyZ38NKk+3jGmWF+loYluBw2R+iQDorpLLAiH20WTy0ahPXfnOmUp52qKzqG85CnklE3Kfm8DA8hOjIsdVsvvHxRgGu1y/LFtXKiauN4poh6Gq1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:07:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:07:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:31 -0400
Subject: [PATCH v3 7/9] arm64: dts: imx8qm-mek: add i2c in mipi[0,1]
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-7-8ecc30678e1c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=1699;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IzehZz/tcy+OhZEkvv5yDy+VxEZsjK9N9TUy6La0efE=;
 b=K9UZTEKe6THELrDvKzOXS/82/j7ugGwgJmP1ZGKLkqi+BerBNISE/pHxOXgT/GufubKLQV9yn
 Mq8JEa9t7IZDt70cfpIBRdfMFP8RCSXAA9fMmB0hCgk/7a3+fQaNjL4
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
X-MS-Office365-Filtering-Correlation-Id: b5d855be-dde4-4700-e6fa-08dc8c83ab75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEhWQTZSU2lORi9MVTBFRHFEcTlTdUUxc0FYRXRPU2Y3ZVdHWlFqQmI1cU5p?=
 =?utf-8?B?RGdhdHVDODBXOE56K0U0aGk5TDBTVTJDQ000TDVrV084alVQVDBVOWNVcmlr?=
 =?utf-8?B?Rk5UYWE1WGpnUFJnOXoyVG1IS1dRTzV5aUo3K1dBdVRwRWo1QWhydzB0UTBj?=
 =?utf-8?B?UEs0MTZ6dUU1dEV6bW0rQmVGSGt0VmRiYmFFSzFmTlBJenhFckR6L2ZDQml3?=
 =?utf-8?B?U3JmODhuMDRid0E3akxOaHpxSzNXK2k0d1hyTnBObXdQeXdXUWpGY2Z5K0do?=
 =?utf-8?B?VDBDL0gwTkxKb2xlRU44NU5TOVR6dUgwZmQyT2krbHljUmswajYxaUtMbjZo?=
 =?utf-8?B?ZC9QMEtzSmV6QlJDY3duT0xDc2JGeEorbkhvM2owQ0JZMUVFUTUrblZjYUdO?=
 =?utf-8?B?WWVzaEQ5azBPa0krcUdsdTcwZ1Z5UC9CZjZSRzhrRVRiQnViN0tWK1JyZFFJ?=
 =?utf-8?B?NGxlRlBYVmpMY0g0bStNMUNIZDFMZFJvMUkxSmVQdXF0N1UrS0liKzJ5TStN?=
 =?utf-8?B?QWVRYXM1TCtObWFHQ1hPTEt1UTgwOWMySVB2Sy9FbTcwK2Nxb2tpelB0TUp6?=
 =?utf-8?B?MVJGRHphRFNtaUwwVHJjVU0rTkpJc3Rxc2s4UkdPdmRmSFZ6Unk1aHN0bElk?=
 =?utf-8?B?K0lSRGFvL1FFT2ZvZlNLR1BPSlF2T3NYR05rTnppczVWVXhXcEdITldGT3NH?=
 =?utf-8?B?TE9jOFpTY2tkamdJa3dJc1BCVGcyZ01LRSthN1loRDdzeHh0NkxFc2pEZWhB?=
 =?utf-8?B?a0hPa2c3bHJyK3pFeXBZRUJHZkNxQjJzbVVrN3lKQnp5UlMyVUp6YkhxMk13?=
 =?utf-8?B?eEZjMlQ2Q085M0tNdU92T3RWOFZiYlRXeGtMeGFmanR2MklIQlYwMUlqVjRy?=
 =?utf-8?B?SVBZZ0htWlltc3lhZDNTczZJSksrSGpMdzl0b1pMSGpoeVdTQkRGbU5kSE8r?=
 =?utf-8?B?SEszWjdOUVo4b3RSdUh0MmwzdzRnSzhGUUtXbTNBdDhqbkEvMmkxQkcvK1lw?=
 =?utf-8?B?T3dac3QxQ093cXhhRk9zUW8yMUZ6Qm5rK0JwbndVc3NyMFhWTE95YjZJeG1y?=
 =?utf-8?B?NjdhTU5lc0M1Nnp5QmlDRTZDKzNiNTEvc0dLYk53M2ZTaWw2UDNGQnE1akJM?=
 =?utf-8?B?dHVEK3d4V2ZWbkNTV2tNbkVySURVTXpxTDg2aXBaT0I5SnJBN0wwKzQ3dW1M?=
 =?utf-8?B?d0hSZ1hNN05WS2pId2xGWVlNNnBhcXp4alIzT3RLYnU4bjNTeTREL3BCMVRT?=
 =?utf-8?B?dndsZHhzdWJJdXd3eU5WaGE2YnJPVDExUUJWV3pMbFpzclRFbUduQUNkaGlV?=
 =?utf-8?B?TGNqNmtsM1BaN2NJUSsrSFk0WXRyS2NoN1FkT1g5eXhGT0t5aWtYZitrOXI3?=
 =?utf-8?B?T2NYUzU0ek02M1JiZC9UelRZUnhWd1BDWWRxSzRRdUhXQ2h6OUxNM05wQU1V?=
 =?utf-8?B?UGhhcFh3MmF4RG5iWmd6NGtTbTZ6aUVuYjFyNU50MW9XWURuM1lMQ05ocTdB?=
 =?utf-8?B?T21vUjBvY2dKL2pLTDVsK3dIOGVmMmhsOFJTMmpRQ28rV3V2RFgwR0JVTm96?=
 =?utf-8?B?N2l2QWFQZ2ZoZHIrTnBwcjY1MEpkYnVTZ3NhTkxEQ25za1cwY1NNUSt1YVhy?=
 =?utf-8?B?dndOcXArNTNHRzhHNGdEcEJ1dStiRW84QVYrTnF3SlZWNDFha0FhaEtlbERk?=
 =?utf-8?B?aDhiUWJTbWx0WFJPelJ3SWJ0Q1hiUzNPOEVneWtjR3pJMjhYVXo3UWYrNmZj?=
 =?utf-8?B?MlB1cnhtNDkxQkhNQ0dzQndqNmI1dWJ0TWdZRldKM3FzdFZWbHA5Ujh0OVUx?=
 =?utf-8?Q?OJ7W8smXkENWDL838mU5bRG/PSL//65KObBPA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDI0T1ZRV3poUkd6YXRWV0pFcnpnbVdXenh5bFlBRDNGRXVWQXhGL2xyd3lz?=
 =?utf-8?B?bjV5a013cFVZY1lrd3Y1TlV1MHlQZE03SG9SQVdLWk5FRTBuSG1FR3IxRUpO?=
 =?utf-8?B?ejVndzRYK3dPakhPL2lyNllVenVxUWdRS2ZGVEdxSG4xVkViREI3MXJSTlZU?=
 =?utf-8?B?d0JjekM4cXRrdjJPdjBUY0QwN0FLVExVaVlZT2JiaC92d21tUTI2Unp2Rlh2?=
 =?utf-8?B?QVB6MWhFNlFYVllxYitLWjF5R29sUVJVK1Z0MlZaTkZ4QTl5RG5lSmtxdGo2?=
 =?utf-8?B?UmphbFd2NDMzVUd1NWpQdkw4b1ZaK0kxMUZaYldrSWZXdGVyMHlqK3c0Y0tz?=
 =?utf-8?B?Y240WWxNbGVrc2pxTHM2amtsa1g3U0lMMmdmTG10VXpnZjdyV3lCdEM2RXBl?=
 =?utf-8?B?WFlHNVBKMWRRdjE5ck5ZajNIbkNuc1p1Q0w4V1UvVGZKQ0V2R0hQTXZ4SVR3?=
 =?utf-8?B?Y2hKWEhzanZaUWRvWTdnbXBUZlJWUGRBQWx1Z1lPZllrdU85TVlsZThjcmt1?=
 =?utf-8?B?dER1NDRHNStpNi96UzhLcGZtbXdyWkV4TlRoU2JZeEtFTEl1WEN2N2VteVY3?=
 =?utf-8?B?VlZVb1JjKzJoSk1rZW54Z0YrSVhwQXVzSE1zRWlDNWJidEZmTmVNTVZOSGIv?=
 =?utf-8?B?c2d4d2wrS3p3WWx5Q2lxaUtCV3A0eGd4bkJqRVRFNzZRcmNFWmd0bHlrOTQ2?=
 =?utf-8?B?MjlScStrNU5xRjFaeWJNWDlUZ3l4NkpXWHNyNU1nL1BPN3NsQkhiM2d1STVY?=
 =?utf-8?B?cEhTNm42ZVNQUWI1ajFFZllUaEdIYTNzMjRJcVRHTlNUZWkyMk56aEpMNzdT?=
 =?utf-8?B?OWZydEdhczhieVNGazNtLzM2N3lsMVVDYThTd2VlSkxaM2hlam5ubTAzNlFi?=
 =?utf-8?B?eldiODg1WEI2QWFXZW1qT2duRThhZUExNVpUNUNGTWUybnZXdExQVEtjWW9J?=
 =?utf-8?B?Wjh2U0d5VzZYdG1XZ3pUbXZybVVwTmx3T2Z6RE9SMEhmNEwwWDAvSmRRTXkx?=
 =?utf-8?B?L3FaNzI5dElWaUcyQUtRenNTVjhWaHAzZEc3RDQvRmRURU1mazhFdXFkRmJI?=
 =?utf-8?B?TWQwYXNNQiswRFFUQnJPQk5YV3R3WUlnOGFmck5EMGVTZEwvTk1yKytsNkIy?=
 =?utf-8?B?QkZJaDJzcjRYTHlXQjMwaUJMdU5ONkttWmIzWkQyYmtQNTVjSTd1RWllUkFY?=
 =?utf-8?B?U3BGTnNQMG5vbUNLdVJyWng4SEN3bC9CalJja2FPOHJQZXVKUStSNzR3eFZQ?=
 =?utf-8?B?RUtnQXVVaGd0QUU4L3J2L1FZdFArdy9qTFRnc2pmOFh6Z2dqdUlsajNFQlhI?=
 =?utf-8?B?ZmxQZEpLSjJ4cXh6VGhrajc0YkNxVUVmZkp6aExXeTl0eUZwRmhHOHBpL1ZW?=
 =?utf-8?B?M056S0ZBU1RYTlh1RkU1N01GMW1FRGlXQW9kSHJkU2RjWkM5UUJaSVlWNHQ3?=
 =?utf-8?B?a2d0TUtHK29VNHBYOERUTGVPM0MzcFRZTW1TYlE5QjdDdHlJTVR6aWNodSt4?=
 =?utf-8?B?NE9kTW1GMlVEQTlCQ29NWXcvZUxTUy93SmNmODJYTVd3dlRUMnowemFpdDNZ?=
 =?utf-8?B?WEFGK1NuVlY0SW5yZEJyK0FYRlRwL1ovMnRXSGRCS3dCcVRIUFZGRTRjK05N?=
 =?utf-8?B?Z0YwR3BDaGNESDRDeDBadllNSzRnM2J2OGc1MituQldrQzVhaVZXZUlRTXFK?=
 =?utf-8?B?NzQ4eENRZkI2b056bDkyTnQ1SzkxTDRiQTNCamI5QWM2enR4ekJSSVNRRjBx?=
 =?utf-8?B?a1dTTHl4Nzh1NWcwbkN2ZUFRRlRvbC8weEVseWVUbVh6OFZrRDZHbzNOY3pN?=
 =?utf-8?B?dlc5MFpwb1pvWVBkQnE4Q1E2aW1vNk5WckxqcmluVmh3ZGxNdUYxZzlJNjNS?=
 =?utf-8?B?cW5hUEx0UUNHZnlYc0lzcUNnWUlTcURRQzFnU0VpZnZBbG5vMGpPRWdUQ05i?=
 =?utf-8?B?U3FlUUhUdHhkRzNnUStxWFdtZEVVdFFWRlloQW1leFk3d1lBWWtQa004NTdu?=
 =?utf-8?B?OXFPSUN6SHR6cm5RRFFmL3pzOGRHN2dUd2l3OWg4Yyt5R0xML3B6a0gzdmVi?=
 =?utf-8?B?NEJSSnlPRURVUG1rZElmWnhBOHh2R2NRRDduSE5FMytHNFpEZyt1NnBvdkFR?=
 =?utf-8?Q?UjdloRXfHuPz5Gunw/v3pEUBM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d855be-dde4-4700-e6fa-08dc8c83ab75
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:07:12.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twNQ5ehOoWuAz2OIl75/tm00PILJTY7C7rULSolCex0LteuP9CAYjEk+pkDYCZcGdJEO3vdaJbjJPeDaQlPOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

Add i2c node in mipi[0,1] subystem for imx8qm-mek.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 3cf39c868e752..e3a653be7dacc 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -364,6 +364,20 @@ &i2c1_lvds1 {
 	status = "okay";
 };
 
+&i2c0_mipi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mipi0_lpi2c0>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c0_mipi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mipi1_lpi2c0>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
@@ -636,6 +650,22 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
 		>;
 	};
 
+	pinctrl_mipi0_lpi2c0: mipi0_lpi2c0grp {
+		fsl,pins = <
+			IMX8QM_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL      0xc6000020
+			IMX8QM_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA      0xc6000020
+			IMX8QM_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO19         0x00000020
+		>;
+	};
+
+	pinctrl_mipi1_lpi2c0: mipi1_lpi2c0grp {
+		fsl,pins = <
+			IMX8QM_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL      0xc6000020
+			IMX8QM_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA      0xc6000020
+			IMX8QM_MIPI_DSI1_GPIO0_01_LSIO_GPIO1_IO23         0x00000020
+		>;
+	};
+
 	pinctrl_flexspi0: flexspi0grp {
 		fsl,pins = <
 			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021

-- 
2.34.1


