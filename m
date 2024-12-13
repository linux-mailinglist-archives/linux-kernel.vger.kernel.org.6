Return-Path: <linux-kernel+bounces-445541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D39F1791
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F1C162A12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEDA193086;
	Fri, 13 Dec 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DLLsnw3p"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE61922FC;
	Fri, 13 Dec 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122792; cv=fail; b=hut/yw4ygc0OXnerIHopJ+s8oagr/d5PYa3sehAoFjTRoV62YjWE+bj7myChe8AKhLvULvCut0NK3K2UrAP3ztrx4/fzTGggm34G9VBUjusfMtN6Rm2tvozhalNre4vt4JfkJeB1ctP1oalfEd7jv9kdFTd8brWnwOl27vB0VxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122792; c=relaxed/simple;
	bh=rQu3OB2UaSGo+eBuH2bdg+tovHb99yess6zFavmST1k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DeuAOlsqXOtaHIRhhd/BuHBPmAkFUBZpZJ1X+6KRyLYiktMbxRCac76ZkN53tHH10CeBeXFGqYZ6Fb22CpByACM6g6WjeRBOQ1c7CTJLGRVgQleNrv/B+nDyxqgl0s/wq6M/F9//12CFqyud4nYUeihxZ36+fzhJUrgBOgGhQ0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DLLsnw3p; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk17x50jUrg3T8KL6MX04Lr4Bg9iII+INWlkPsV4vp63IAkzGDSa3SgrpsOgWkl4Wvy1dLJeTEg+JoA2CKkTHGvhVQZvvI9uZAzS8//I7M4A37mYZkiZ8eQLNI/LQ39RrD8tVQY/W9sBHVPDZBudWiuZpzc0KMXXdrvMOgZkgsOrvcBbQiFHOUzRyEBwS/KsF0xHQ+obw1RPMYZy+cDXHWa5mNlVhE3c0w6YykepiFgVymwVu6GYXpo9kXhJ/ahSSeGyD1WP61JDkaJAMZFEbfI8dSSR9Dh0dn6H4yPmxMp7qixhLIW6okW82pUjEiROYz474ZcgYek915GNye6+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwrROa6X6LZv40iAXcu9I+7QPEp4nEJHQrOEkIs69tE=;
 b=wF9XX0aYM6LHkeF7oFKU2q0+HkRnwH5lurRfPol/jFFMzGp64XeCCNa1SDUq8c0bgR6O+5G1VR0HjJFEsRcw6zMLhF3wj6yN2kuxl3u9o02ccCbC/fhwUJJbY+3KSbIfh1YKuoIdOwfL6e2ZFsQPor7rJiKQArNk3ZayWJU5U8nLReU5BiVeaYQ9BJinaXnhXpZIAQBjjJ+lstrqK1b7CLYyxpAxIgwhN+RYd4qpLFczfH5wIBBcygzep3wi3dVbjSPt9B4T4ecSrwA6nRdPDt5Q+zvXJ+hlKF2IDzxeWLXDEhVFgHMvNDHot+rbLg3Rg4EVg4QeeuDvTicyxIkGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwrROa6X6LZv40iAXcu9I+7QPEp4nEJHQrOEkIs69tE=;
 b=DLLsnw3pSEg8wVxY2MYIduKQtgOAZ2cS8B0Y8HKrpeIY/BkzeqsuhPBa1wIN0faRsN/Z/KQ49llIeLdRyPIX4EeG38yD08j1T3xWsekMcbYB3NRB7kPHOXM8XrcTCV73WG4TI5YubCu6EItYvpp4lAqu8G63pIGqlB8rc3c1MjCyyWRnyWgh8URqYjcJyt2nl2fDKP0hp0dB05EG8YD1/ZvFn3ExWJLEvRRgbBwU0zz3qgZd6NgZ2xCjL4+uoTVUQ4Q8IfGGJPpY74sHYZ7nTKEK8fAyMcs8IiJaAyQCSDRDIsmunirrnJqtFAH8ji8iEC4c/jSdR1A1TchaE4NG9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:46:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 20:46:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 13 Dec 2024 15:46:09 -0500
Subject: [PATCH v3 2/2] regulator: pf9453: add PMIC PF9453 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pf9453-v3-2-5587c1693155@nxp.com>
References: <20241213-pf9453-v3-0-5587c1693155@nxp.com>
In-Reply-To: <20241213-pf9453-v3-0-5587c1693155@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734122778; l=27725;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=npZSU6cGPsQC42aRjhU8ZTUi9YHHOzqUf94XJ6cpDfQ=;
 b=qe2MwI8oGklJL4G8wAH0B5rYaA8fgVI8H6ThKwGbmXstXHvaluknwBFurF9HvTWZXCEIF0I5i
 RwUkwNYH6TsCLK51wRaCNivMdIyz/2motW6teqA6thbc2V9IQ5hIkiQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: 28772d80-723e-48ee-4a48-08dd1bb7371a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUp4aFNKZGNBWmRTckphQldDWTZ0TkxrQU5TMDB3OFF4SGxPdklXM2JwVTdv?=
 =?utf-8?B?N3FMRnRRdXlCYUdxdUI5USthbzFqVXVCeUJWdWpyeUtrWm1SSnBVRnZkSm9Q?=
 =?utf-8?B?M3FaUDFMTThSdU13Vk9RSjBYbTVKZXBkMm1LQU1ZcEgyNTJCSDV6SWtRdXE0?=
 =?utf-8?B?N25lME5KWTRiVUQvTVRJREtDWm9ZUDZRbE1wWnpCT2lDdkdsVFdwVFlsV1RD?=
 =?utf-8?B?R2h5dUdOTnFKdHBtNmhEOFBxRlFXNFQxWThFbndweWJWZjhsczU1SThWYndy?=
 =?utf-8?B?cUpiQTJpQThXaDMrdWVlaU5xSEZMSjhFZStHTE1zc1k4UzVmMnk5NWVsZE5r?=
 =?utf-8?B?TGMxV2tPSmMxZVJxcjNLZGRnU0JKSE9nWEErdnpRL1pyZDkxZStwZklBSy9y?=
 =?utf-8?B?UGJuUlRKKzIxSTB6aXhGMjFtY2tob2gxa20vc1NWUTl5dmlYM2J3WEo0QjB2?=
 =?utf-8?B?VmxkRnhvZmZaY1lTZGIwRXNIYTF0Njk0QWhKZkszTnNPdVBSL3VuandaSk03?=
 =?utf-8?B?YVdXRXNlV3Y2SFNsby96M2w4d1VVOXo3ajBFeTJYRFAvcUVIM1A2cHBqaCtK?=
 =?utf-8?B?K1JYdERrQXJKZy9wTDdGaytFVkx0VlA5RDVpME8rMGlZTEM2Sm5UQmxLU0Y1?=
 =?utf-8?B?UThIYzQ4UjU3UE5vQjRmWVYyWkltYVNEaGVTZHQ5dHpLL0xRb0JYWlhhOFJK?=
 =?utf-8?B?V1NJcitidEFNdngzcDJwMnlSTC9MUEdKdUNsSWI0M1lwSWMrQmpnNlJLUVNB?=
 =?utf-8?B?cFFkVUoxNHVUa2syZ3gwZjAyWGRWeHNCa0hWQVgyWGJpdEZKTFBXaWhRN3dN?=
 =?utf-8?B?eXpPU0s2VGtrRERmQzBGdVNiTm9CNDhhWWRpbkxCTVRJVFU0am92eUh4anBP?=
 =?utf-8?B?RU1oSUpybU1OVExhd29MRVJvWCtOSFJ2UWh1TWVkcEFLaVFKYng1enlrVDdC?=
 =?utf-8?B?VHoxUkRoVWw4M1ZtKzNlaHY4c0hpRC9jTEZhT0lIZnFyMXdNVGNTdTdyYThS?=
 =?utf-8?B?RTVDTUM1aDNHR09JbDlkTnFuaGtEWlJLaWFtV1RPME9scWNqYWVVRW5IYmRx?=
 =?utf-8?B?YUx2QUY1NTZKUGZDQ1k5NWNpU0FsNFRUZ211MXBvcTBaZEZ6dnp4WmpibVBl?=
 =?utf-8?B?RmM4S2s2di9PSW8yS0xBeUtFZ1VQMnhRaHI3VFl5blk2ZUdUa0JBN3plQUxu?=
 =?utf-8?B?ZjJDYnlBS3VOU3diUm9wd0l4bG9hMk8vaHNKNWdnMlJSZkZuRzRodC9sMDdq?=
 =?utf-8?B?anZMVDZXZW5aY0ozWUprVkJCa2ZlVGFGbkpoM1pxRnFIam1vcUQ0b2ZWK0hN?=
 =?utf-8?B?amNuSkRxdW4vZEdjZVBCUFpXQ2VCZnpXWkpjcDNjTlloUFVHUXlmUEtoVW9Q?=
 =?utf-8?B?dUFSV2RCSkZiQmk2dkZoZzhLSmU3b1hwS3V3WTlIQzI4Ulk1OVQvbmZjUkFO?=
 =?utf-8?B?RTY5OU5ndzAyRHQ4VmdSb25vOEl2WStXbE1ZcDd4djh6Z3oxSS8rMGk0aFAr?=
 =?utf-8?B?QUM1ZnlYS1hvZHZnYVZobktYYkJXUjVMOTNMdkVpZk5ZcEdmQm5NWElQdlpt?=
 =?utf-8?B?YkQzNitVb1ZFdkdkT2xjTjZGUmpNakM2WmVNYXFBaU44K1JvVnZWNXBVV1pB?=
 =?utf-8?B?cE5RYmxSczlCV1M1RGtLcFU5Nm03UEJRNUtaOXExOUNEZjIySjJMd3U0dXNH?=
 =?utf-8?B?OWM5QUlWUEMvZllVQ0VacmpTL096QU10Z2ExSzRKMEJRS1hVa2orbWlvT2VN?=
 =?utf-8?B?VTNSY0txdWpFOWs3cnV4OEFCQ1ZVRDBvS2tYazlGOTNKeTVPa0pVZmJpNkJD?=
 =?utf-8?B?ckJxYWRHUkt3a0h6MkdrVXZYMysxYWowTkd4WUhGb2lNV1hMUG9yMmlUVUFC?=
 =?utf-8?B?R01RZmtkTlROWVRQQURiYm12Vk5kLzhaakNobHFqbkxUaUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm04UzR0VFVOTlUvVTZCRGQ2eVlUNFBTYUhsNFlCWmtSanIxR3cxQXFnYU9p?=
 =?utf-8?B?Sm1PbHdoMTA1RnFNR2dhd05oY0FWaGUvMmhmZjFUandvQkNiUWx6SXBLQlJC?=
 =?utf-8?B?R2NuTzZncTBJRzk0NWxSQmRod2J5MzFqOGNyNG5HSm95YTQzWWtZTGtOekxi?=
 =?utf-8?B?UUZQK1JRUHp0V29ic3FFKzdRaFZRUTA4UUsxb2FLbFBaaUFSNE91MUp0alVI?=
 =?utf-8?B?eVdYeUxTbis2b1hqSUw5cUgveWhNOHUzZnkxVmp1QWlFMkdsenNOQjBqZkh5?=
 =?utf-8?B?RXlBOHlLVDVYdjAxM0c1Zkd2TDBJNzhUWTJ6NGNRREYrZ1F2a2hwRUhPVzNP?=
 =?utf-8?B?TEI0SXBhQno5MFRHNVQwT1d1OWliU2pCVCtFNVEydDdwQ1N1ajBmeHZhVUhq?=
 =?utf-8?B?bUlqZjV0aytBckYvYXBxYlFlQzJHZUg1YUpzeFdIZjltQ0FlWmtmdVJzSjRm?=
 =?utf-8?B?VXFOZTRXbTVpeUdFZWFhd3J4Y0NQVmRod2Y1Vm9LakxhS3pWZmgvUndMQUhT?=
 =?utf-8?B?aXBwKzZpY0dCd0twSFVWdjVaTXA3SWlzaDVCUEFiWlhlVWN3cVRQR1RUS0Na?=
 =?utf-8?B?YTFpL2dCMTZvU2Q4bnp6YWd6ZlAvZnRweGQ0Ukp3WFdCaEVVZ2N5M0JrVm1a?=
 =?utf-8?B?MndiZmc2QW1haTlDVVd6clJ5dEtiMGhGd2Z0eVNvTGwvSXNxdGl4eG1NcURi?=
 =?utf-8?B?dE1iem5FdC9HOEpVa1RvZkF1QzAzVkFFZ0FyVittYnF6S2dGbSt1N3dmaEtp?=
 =?utf-8?B?WlRXWnlSTnN1bXBIRTBpQlVIOGJ2dVNLRlJJK0ZRR1pvVm9VYjdwK2FaanJI?=
 =?utf-8?B?U0hOamtpL08vcUNjY3I3VFN0WUxBN09UOWM3TlQxY1VtSkJWalZpZmI3U3VX?=
 =?utf-8?B?bncwMElxVW1kNUZmdGpNS0ZHOEdoT2tSSnVHOHVCQUdPODliUHlWL25jSDBp?=
 =?utf-8?B?dTFvejB4NSt4Rm84RXd6QzBqejB1MHQzREZSakNOVC9DMXROZENLeldwTi9Z?=
 =?utf-8?B?S1lzZnd6OHUyMlE1NENnLzZoZXZGajlUam1sYVMrSmk5Skd0NjduZHI0ZlZu?=
 =?utf-8?B?RDZzWjd1ZDdZMUxqVHlzVklNdGhBVWJBTXBML0FVb29LaGNXMVQxQ2lTa2dK?=
 =?utf-8?B?NHpidDVXMnFSUzJ1cm00ZUtGRDRpNVM0SGg0cjAvSlpob2xRd2lwaG0weGxV?=
 =?utf-8?B?Mm9QS0tFdkJ4YlZSZlB0MCtZbGlHcjBqbUNVSlZEck1rUTZ6cGhhQkhiWDJq?=
 =?utf-8?B?Q3RVdUVSaGhpV2FLNzU2d3l5c3dNWXU3RzFMRWcrb0FDL3hPNXRHTmtDR2lh?=
 =?utf-8?B?U3U2cTdscHkvWHQ5Z0JGakV0eDkvK1U5YzdobUhSRDRDbkgwWVQ0cmhwL3lU?=
 =?utf-8?B?eWpWK3JHaTg0bWJqdHZNOGlHNlEyMUg3WnlGeHJJT1FDN3dNN0ZIdTE1aDcr?=
 =?utf-8?B?SDRrOTI1WVppVldVMW1CbVp3c2c0SGcxK2MrcXcxTnZkR0YzWktDLzJ4U3RQ?=
 =?utf-8?B?SHViSVE3eWJTek4xV1VtT3JFOXJwOG13UGEvQ1Fxdnl1VE13Wk1iekpnME15?=
 =?utf-8?B?VnlXMExGRCtUQjk4MllKNlh3R0p2amJ6SWtwbzZOUWpBWEVFZk1VR2xaQzcr?=
 =?utf-8?B?VGJyb1oxejRWV0xpWGhEVVBhY0pvcmJRNVJKcjEzSVYyOU5Ya1BaNTBVa2s1?=
 =?utf-8?B?RlFZQ3IxRmRiUGRWbk1xZnNpYUdIc0M5TjJtSlUyN0pqT3F5enovVEpiamJX?=
 =?utf-8?B?c3Z3QXp0emtzcDNCNVJZMWRwNllkVVppWVhPbzI4bHcxMThWQXJFMURXeEdZ?=
 =?utf-8?B?OC9SYU5wNFpWc2VobmtjVVduY1JxQUtOODJCOWY4OUNBbjNjWG5MOThwTExs?=
 =?utf-8?B?NUVjdG85emMra1NLUzVGcWZ0TFpaUmxnTkM0eWFNeFNSZnhrQlc3WnJ4Q2hE?=
 =?utf-8?B?eVVVczBOYVJVU0h3VmZVSHRDT0tPUWlGcWxoOFo4WERjdE1WR0wzSGdZa0tl?=
 =?utf-8?B?MmtIdUxjNnNpb0IzOUZBNGVTQkcvOHoxTzlRVWdkSDdDdU5XbUJaMVJxbEdL?=
 =?utf-8?B?R0VPZFZmWDQzekJ5TmJUU1FVdTd6Rk50ZGllL0lES3BpQUFRZE5kMklSU1Ux?=
 =?utf-8?Q?phD+VmqaYzNTH+sACn1+DBdf5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28772d80-723e-48ee-4a48-08dd1bb7371a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:46:27.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6RiuOjs/V1FGThvmDhdBtJGyHxWJ2wEP3NiPgnwe9Ge4MQUWGh0RTZ4VP4bhyEIQpI7zQetxQTp157aYxBvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

From: Joy Zou <joy.zou@nxp.com>

Support new PMIC PF9453, which is totally difference with PCA9450. So
create new file for it.

The PF9453 is a single chip Power Management IC (PMIC) specifically
designed for i.MX 91 processor. It provides power supply solutions for IoT
(Internet of Things), smart appliance, and portable applications where size
and efficiency are critical. The device provides four high efficiency
step-down regulators, three LDOs, one 400 mA load switch and 32.768 kHz
crystal oscillator driver.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
- remove pf9453.h
- remove double space
- use low case hex value
- remove , after terminate
- use GEMASK
- change to LDO-SNVS
---
 drivers/regulator/Kconfig            |   7 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf9453-regulator.c | 879 +++++++++++++++++++++++++++++++++++
 3 files changed, 887 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d81771..74d11ca2d9bee 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -981,6 +981,13 @@ config REGULATOR_PCA9450
 	  Say y here to support the NXP PCA9450A/PCA9450B/PCA9450C PMIC
 	  regulator driver.
 
+config REGULATOR_PF9453
+	tristate "NXP PF9453 regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say y here to support the NXP PF9453 PMIC regulator driver.
+
 config REGULATOR_PCAP
 	tristate "Motorola PCAP2 regulator driver"
 	depends on EZX_PCAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a0..5192f24796636 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
+obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
new file mode 100644
index 0000000000000..6bcdeee48dd79
--- /dev/null
+++ b/drivers/regulator/pf9453-regulator.c
@@ -0,0 +1,879 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ * NXP PF9453 pmic driver
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+struct pf9453_dvs_config {
+	unsigned int run_reg; /* dvs0 */
+	unsigned int run_mask;
+	unsigned int standby_reg; /* dvs1 */
+	unsigned int standby_mask;
+};
+
+struct pf9453_regulator_desc {
+	struct regulator_desc desc;
+	const struct pf9453_dvs_config dvs;
+};
+
+struct pf9453 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *sd_vsel_gpio;
+	int irq;
+};
+
+enum {
+	PF9453_BUCK1 = 0,
+	PF9453_BUCK2,
+	PF9453_BUCK3,
+	PF9453_BUCK4,
+	PF9453_LDO1,
+	PF9453_LDO2,
+	PF9453_LDOSNVS,
+	PF9453_REGULATOR_CNT
+};
+
+enum {
+	PF9453_DVS_LEVEL_RUN = 0,
+	PF9453_DVS_LEVEL_STANDBY,
+	PF9453_DVS_LEVEL_DPSTANDBY,
+	PF9453_DVS_LEVEL_MAX
+};
+
+#define PF9453_BUCK1_VOLTAGE_NUM	0x80
+#define PF9453_BUCK2_VOLTAGE_NUM	0x80
+#define PF9453_BUCK3_VOLTAGE_NUM	0x80
+#define PF9453_BUCK4_VOLTAGE_NUM	0x80
+
+#define PF9453_LDO1_VOLTAGE_NUM		0x65
+#define PF9453_LDO2_VOLTAGE_NUM		0x3b
+#define PF9453_LDOSNVS_VOLTAGE_NUM	0x59
+
+enum {
+	PF9453_REG_DEV_ID		= 0x00,
+	PF9453_REG_OTP_VER		= 0x01,
+	PF9453_REG_INT1			= 0x02,
+	PF9453_REG_INT1_MASK		= 0x03,
+	PF9453_REG_INT1_STATUS		= 0x04,
+	PF9453_REG_VRFLT1_INT		= 0x05,
+	PF9453_REG_VRFLT1_MASK		= 0x06,
+	PF9453_REG_PWRON_STAT		= 0x07,
+	PF9453_REG_RESET_CTRL		= 0x08,
+	PF9453_REG_SW_RST		= 0x09,
+	PF9453_REG_PWR_CTRL		= 0x0a,
+	PF9453_REG_CONFIG1		= 0x0b,
+	PF9453_REG_CONFIG2		= 0x0c,
+	PF9453_REG_32K_CONFIG		= 0x0d,
+	PF9453_REG_BUCK1CTRL		= 0x10,
+	PF9453_REG_BUCK1OUT		= 0x11,
+	PF9453_REG_BUCK2CTRL		= 0x14,
+	PF9453_REG_BUCK2OUT		= 0x15,
+	PF9453_REG_BUCK2OUT_STBY	= 0x1d,
+	PF9453_REG_BUCK2OUT_MAX_LIMIT	= 0x1f,
+	PF9453_REG_BUCK2OUT_MIN_LIMIT	= 0x20,
+	PF9453_REG_BUCK3CTRL		= 0x21,
+	PF9453_REG_BUCK3OUT		= 0x22,
+	PF9453_REG_BUCK4CTRL		= 0x2e,
+	PF9453_REG_BUCK4OUT		= 0x2f,
+	PF9453_REG_LDO1OUT_L		= 0x36,
+	PF9453_REG_LDO1CFG		= 0x37,
+	PF9453_REG_LDO1OUT_H		= 0x38,
+	PF9453_REG_LDOSNVS_CFG1		= 0x39,
+	PF9453_REG_LDOSNVS_CFG2		= 0x3a,
+	PF9453_REG_LDO2CFG		= 0x3b,
+	PF9453_REG_LDO2OUT		= 0x3c,
+	PF9453_REG_BUCK_POK		= 0x3d,
+	PF9453_REG_LSW_CTRL1		= 0x40,
+	PF9453_REG_LSW_CTRL2		= 0x41,
+	PF9453_REG_LOCK			= 0x4e,
+	PF9453_MAX_REG
+};
+
+#define PF9453_UNLOCK_KEY		0x5c
+#define PF9453_LOCK_KEY			0x0
+
+/* PF9453 BUCK ENMODE bits */
+#define BUCK_ENMODE_OFF			0x00
+#define BUCK_ENMODE_ONREQ		0x01
+#define BUCK_ENMODE_ONREQ_STBY		0x02
+#define BUCK_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453 BUCK ENMODE bits */
+#define LDO_ENMODE_OFF			0x00
+#define LDO_ENMODE_ONREQ		0x01
+#define LDO_ENMODE_ONREQ_STBY		0x02
+#define LDO_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453_REG_BUCK1_CTRL bits */
+#define BUCK1_LPMODE			0x30
+#define BUCK1_AD			0x08
+#define BUCK1_FPWM			0x04
+#define BUCK1_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK2_CTRL bits */
+#define BUCK2_RAMP_MASK			GENMASK(7, 4)
+#define BUCK2_RAMP_25MV			0x0
+#define BUCK2_RAMP_12P5MV		0x1
+#define BUCK2_RAMP_6P25MV		0x2
+#define BUCK2_RAMP_3P125MV		0x3
+#define BUCK2_LPMODE			0x30
+#define BUCK2_AD			0x08
+#define BUCK2_FPWM			0x04
+#define BUCK2_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK3_CTRL bits */
+#define BUCK3_LPMODE			0x30
+#define BUCK3_AD			0x08
+#define BUCK3_FPWM			0x04
+#define BUCK3_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK4_CTRL bits */
+#define BUCK4_LPMODE			0x30
+#define BUCK4_AD			0x08
+#define BUCK4_FPWM			0x04
+#define BUCK4_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK123_PRESET_EN bit */
+#define BUCK123_PRESET_EN		0x80
+
+/* PF9453_BUCK1OUT bits */
+#define BUCK1OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_BUCK2OUT bits */
+#define BUCK2OUT_MASK			GENMASK(6, 0)
+#define BUCK2OUT_STBY_MASK		GENMASK(6, 0)
+
+/* PF9453_REG_BUCK3OUT bits */
+#define BUCK3OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_BUCK4OUT bits */
+#define BUCK4OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDO1_VOLT bits */
+#define LDO1_EN_MASK			GENMASK(1, 0)
+#define LDO1OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDO2_VOLT bits */
+#define LDO2_EN_MASK			GENMASK(1, 0)
+#define LDO2OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDOSNVS_VOLT bits */
+#define LDOSNVS_EN_MASK			0x1
+#define LDOSNVSCFG1_MASK		GENMASK(6, 0)
+
+/* PF9453_REG_IRQ bits */
+#define IRQ_RSVD			0x80
+#define IRQ_RSTB			0x40
+#define IRQ_ONKEY			0x20
+#define IRQ_RESETKEY			0x10
+#define IRQ_VR_FLT1			0x08
+#define IRQ_LOWVSYS			0x04
+#define IRQ_THERM_100			0x02
+#define IRQ_THERM_80			0x01
+
+/* PF9453_REG_RESET_CTRL bits */
+#define WDOG_B_CFG_MASK			GENMASK(7, 4)
+#define WDOG_B_CFG_NONE			0x00
+#define WDOG_B_CFG_WARM			0x40
+#define WDOG_B_CFG_COLD			0x80
+
+/* PF9453_REG_CONFIG2 bits */
+#define I2C_LT_MASK			GENMASK(1, 0)
+#define I2C_LT_FORCE_DISABLE		0x00
+#define I2C_LT_ON_STANDBY_RUN		0x01
+#define I2C_LT_ON_RUN			0x02
+#define I2C_LT_FORCE_ENABLE		0x03
+
+static const struct regmap_range pf9453_status_range = {
+	.range_min = PF9453_REG_INT1,
+	.range_max = PF9453_REG_PWRON_STAT,
+};
+
+static const struct regmap_access_table pf9453_volatile_regs = {
+	.yes_ranges = &pf9453_status_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config pf9453_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &pf9453_volatile_regs,
+	.max_register = PF9453_MAX_REG - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/*
+ * BUCK2
+ * BUCK2RAM[1:0] BUCK2 DVS ramp rate setting
+ * 00: 25mV/1usec
+ * 01: 25mV/2usec
+ * 10: 25mV/4usec
+ * 11: 25mV/8usec
+ */
+static const unsigned int pf9453_dvs_buck_ramp_table[] = {
+	25000, 12500, 6250, 3125
+};
+
+static bool is_reg_protect(uint reg)
+{
+	switch (reg) {
+	case PF9453_REG_BUCK1OUT:
+	case PF9453_REG_BUCK2OUT:
+	case PF9453_REG_BUCK3OUT:
+	case PF9453_REG_BUCK4OUT:
+	case PF9453_REG_LDO1OUT_L:
+	case PF9453_REG_LDO1OUT_H:
+	case PF9453_REG_LDO2OUT:
+	case PF9453_REG_LDOSNVS_CFG1:
+	case PF9453_REG_BUCK2OUT_MAX_LIMIT:
+	case PF9453_REG_BUCK2OUT_MIN_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int pf9453_pmic_write(struct pf9453 *pf9453, unsigned int reg, u8 mask, unsigned int val)
+{
+	int ret = -EINVAL;
+	u8 data, key;
+	u32 rxBuf;
+
+	/* If not updating entire register, perform a read-mod-write */
+	data = val;
+	key = PF9453_UNLOCK_KEY;
+
+	if (mask != 0xffU) {
+		/* Read data */
+		ret = regmap_read(pf9453->regmap, reg, &rxBuf);
+		if (ret) {
+			dev_err(pf9453->dev, "Read reg=%0x error!\n", reg);
+			return ret;
+		}
+		data = (val & mask) | (rxBuf & (~mask));
+	}
+
+	if (reg < PF9453_MAX_REG) {
+		if (is_reg_protect(reg)) {
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			key = PF9453_LOCK_KEY;
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		} else {
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * pf9453_regulator_enable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their enable() operation, saving some code.
+ */
+static int pf9453_regulator_enable_regmap(struct regulator_dev *rdev)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int val;
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->disable_val;
+	} else {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_disable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their disable() operation, saving some code.
+ */
+static int pf9453_regulator_disable_regmap(struct regulator_dev *rdev)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int val;
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	} else {
+		val = rdev->desc->disable_val;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_set_voltage_sel_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ * @sel: Selector to set
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * vsel_reg and vsel_mask fields in their descriptor and then use this
+ * as their set_voltage_vsel operation, saving some code.
+ */
+static int pf9453_regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	int ret;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+	ret = pf9453_pmic_write(pf9453, rdev->desc->vsel_reg, rdev->desc->vsel_mask, sel);
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = pf9453_pmic_write(pf9453, rdev->desc->apply_reg,
+					rdev->desc->apply_bit, rdev->desc->apply_bit);
+	return ret;
+}
+
+static int find_closest_bigger(unsigned int target, const unsigned int *table,
+			       unsigned int num_sel, unsigned int *sel)
+{
+	unsigned int s, tmp, max, maxsel = 0;
+	bool found = false;
+
+	max = table[0];
+
+	for (s = 0; s < num_sel; s++) {
+		if (table[s] > max) {
+			max = table[s];
+			maxsel = s;
+		}
+		if (table[s] >= target) {
+			if (!found || table[s] - target < tmp - target) {
+				tmp = table[s];
+				*sel = s;
+				found = true;
+				if (tmp == target)
+					break;
+			}
+		}
+	}
+
+	if (!found) {
+		*sel = maxsel;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pf9453_regulator_set_ramp_delay_regmap
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the ramp_reg
+ * and ramp_mask fields in their descriptor and then use this as their
+ * set_ramp_delay operation, saving some code.
+ */
+static int pf9453_regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int sel;
+	int ret;
+
+	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table))
+		return -EINVAL;
+
+	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+				  rdev->desc->n_ramp_values, &sel);
+
+	if (ret) {
+		dev_warn(rdev_get_dev(rdev),
+			 "Can't set ramp-delay %u, setting %u\n", ramp_delay,
+			 rdev->desc->ramp_delay_table[sel]);
+	}
+
+	sel <<= ffs(rdev->desc->ramp_mask) - 1;
+
+	return pf9453_pmic_write(pf9453, rdev->desc->ramp_reg,
+				 rdev->desc->ramp_mask, sel);
+}
+
+static const struct regulator_ops pf9453_dvs_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay	= pf9453_regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops pf9453_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops pf9453_ldo_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+/*
+ * BUCK1/3/4
+ * 0.60 to 3.775V (25mV step)
+ */
+static const struct linear_range pf9453_buck134_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 25000),
+};
+
+/*
+ * BUCK2
+ * 0.60 to 2.1875V (12.5mV step)
+ */
+static const struct linear_range pf9453_buck2_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
+};
+
+/*
+ * LDO1
+ * 0.8 to 3.3V (25mV step)
+ */
+static const struct linear_range pf9453_ldo1_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x64, 25000),
+};
+
+/*
+ * LDO2
+ * 0.5 to 1.95V (25mV step)
+ */
+static const struct linear_range pf9453_ldo2_volts[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x3A, 25000),
+};
+
+/*
+ * LDOSNVS
+ * 1.2 to 3.4V (25mV step)
+ */
+static const struct linear_range pf9453_ldosnvs_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x58, 25000),
+};
+
+static int buck_set_dvs(const struct regulator_desc *desc,
+			struct device_node *np, struct pf9453 *pf9453,
+			char *prop, unsigned int reg, unsigned int mask)
+{
+	int ret, i;
+	u32 uv;
+
+	ret = of_property_read_u32(np, prop, &uv);
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
+		return ret;
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = pf9453_pmic_write(pf9453, reg, mask, i);
+			break;
+		}
+	}
+
+	if (ret == 0) {
+		struct pf9453_regulator_desc *regulator = container_of(desc,
+					struct pf9453_regulator_desc, desc);
+
+		/* Enable DVS control through PMIC_STBY_REQ for this BUCK */
+		ret = pf9453_pmic_write(pf9453, regulator->desc.enable_reg,
+					BUCK2_LPMODE, BUCK2_LPMODE);
+	}
+	return ret;
+}
+
+static int pf9453_set_dvs_levels(struct device_node *np, const struct regulator_desc *desc,
+				 struct regulator_config *cfg)
+{
+	struct pf9453_regulator_desc *data = container_of(desc, struct pf9453_regulator_desc, desc);
+	struct pf9453 *pf9453 = dev_get_drvdata(cfg->dev);
+	const struct pf9453_dvs_config *dvs = &data->dvs;
+	unsigned int reg, mask;
+	int i, ret = 0;
+	char *prop;
+
+	for (i = 0; i < PF9453_DVS_LEVEL_MAX; i++) {
+		switch (i) {
+		case PF9453_DVS_LEVEL_RUN:
+			prop = "nxp,dvs-run-voltage";
+			reg = dvs->run_reg;
+			mask = dvs->run_mask;
+			break;
+		case PF9453_DVS_LEVEL_DPSTANDBY:
+		case PF9453_DVS_LEVEL_STANDBY:
+			prop = "nxp,dvs-standby-voltage";
+			reg = dvs->standby_reg;
+			mask = dvs->standby_mask;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = buck_set_dvs(desc, np, pf9453, prop, reg, mask);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static const struct pf9453_regulator_desc pf9453_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK1,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK1OUT,
+			.vsel_mask = BUCK1OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK2,
+			.ops = &pf9453_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck2_volts),
+			.vsel_reg = PF9453_REG_BUCK2OUT,
+			.vsel_mask = BUCK2OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK2CTRL,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_reg = PF9453_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pf9453_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf9453_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf9453_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF9453_REG_BUCK2OUT,
+			.run_mask = BUCK2OUT_MASK,
+			.standby_reg = PF9453_REG_BUCK2OUT_STBY,
+			.standby_mask = BUCK2OUT_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck3",
+			.of_match = of_match_ptr("BUCK3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK3,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK3_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK3OUT,
+			.vsel_mask = BUCK3OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK3CTRL,
+			.enable_mask = BUCK3_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK4,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO1,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo1_volts),
+			.vsel_reg = PF9453_REG_LDO1OUT_H,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PF9453_REG_LDO1CFG,
+			.enable_mask = LDO1_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("LDO2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO2,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo2_volts),
+			.vsel_reg = PF9453_REG_LDO2OUT,
+			.vsel_mask = LDO2OUT_MASK,
+			.enable_reg = PF9453_REG_LDO2CFG,
+			.enable_mask = LDO2_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldosnvs",
+			.of_match = of_match_ptr("LDO-SNVS"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDOSNVS,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDOSNVS_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldosnvs_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldosnvs_volts),
+			.vsel_reg = PF9453_REG_LDOSNVS_CFG1,
+			.vsel_mask = LDOSNVSCFG1_MASK,
+			.enable_reg = PF9453_REG_LDOSNVS_CFG2,
+			.enable_mask = LDOSNVS_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{ }
+};
+
+static irqreturn_t pf9453_irq_handler(int irq, void *data)
+{
+	struct pf9453 *pf9453 = data;
+	struct regmap *regmap = pf9453->regmap;
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(regmap, PF9453_REG_INT1, &status);
+	if (ret < 0) {
+		dev_err(pf9453->dev, "Failed to read INT1(%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (status & IRQ_RSTB)
+		dev_warn(pf9453->dev, "IRQ_RSTB interrupt.\n");
+
+	if (status & IRQ_ONKEY)
+		dev_warn(pf9453->dev, "IRQ_ONKEY interrupt.\n");
+
+	if (status & IRQ_VR_FLT1)
+		dev_warn(pf9453->dev, "VRFLT1 interrupt.\n");
+
+	if (status & IRQ_RESETKEY)
+		dev_warn(pf9453->dev, "IRQ_RESETKEY interrupt.\n");
+
+	if (status & IRQ_LOWVSYS)
+		dev_warn(pf9453->dev, "LOWVSYS interrupt.\n");
+
+	if (status & IRQ_THERM_100)
+		dev_warn(pf9453->dev, "IRQ_THERM_100 interrupt.\n");
+
+	if (status & IRQ_THERM_80)
+		dev_warn(pf9453->dev, "IRQ_THERM_80 interrupt.\n");
+
+	return IRQ_HANDLED;
+}
+
+static int pf9453_i2c_probe(struct i2c_client *i2c)
+{
+	const struct pf9453_regulator_desc *regulator_desc = of_device_get_match_data(&i2c->dev);
+	struct regulator_config config = { };
+	unsigned int reset_ctrl;
+	unsigned int device_id;
+	struct pf9453 *pf9453;
+	int ret;
+
+	if (!i2c->irq)
+		return dev_err_probe(&i2c->dev, -EINVAL, "No IRQ configured?\n");
+
+	pf9453 = devm_kzalloc(&i2c->dev, sizeof(struct pf9453), GFP_KERNEL);
+	if (!pf9453)
+		return -ENOMEM;
+
+	pf9453->regmap = devm_regmap_init_i2c(i2c, &pf9453_regmap_config);
+	if (IS_ERR(pf9453->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->regmap),
+				     "regmap initialization failed\n");
+
+	pf9453->irq = i2c->irq;
+	pf9453->dev = &i2c->dev;
+
+	dev_set_drvdata(&i2c->dev, pf9453);
+
+	ret = regmap_read(pf9453->regmap, PF9453_REG_DEV_ID, &device_id);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device id error\n");
+
+	/* Check your board and dts for match the right pmic */
+	if ((device_id >> 4) != 0xb)
+		return dev_err_probe(&i2c->dev, -EINVAL, "Device id(%x) mismatched\n",
+				     device_id >> 4);
+
+	while (regulator_desc->desc.name) {
+		const struct regulator_desc *desc;
+		struct regulator_dev *rdev;
+
+		desc = &regulator_desc->desc;
+
+		config.regmap = pf9453->regmap;
+		config.dev = pf9453->dev;
+
+		rdev = devm_regulator_register(pf9453->dev, desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(pf9453->dev, PTR_ERR(rdev),
+					     "Failed to register regulator(%s)\n", desc->name);
+
+		regulator_desc++;
+	}
+
+	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL, pf9453_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pf9453-irq", pf9453);
+	if (ret)
+		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
+
+	/* Unmask all interrupt except PWRON/WDOG/RSVD */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_INT1_MASK,
+				IRQ_ONKEY | IRQ_RESETKEY | IRQ_RSTB | IRQ_VR_FLT1
+				| IRQ_LOWVSYS | IRQ_THERM_100 | IRQ_THERM_80, IRQ_RSVD);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
+		reset_ctrl = WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = WDOG_B_CFG_COLD;
+
+	/* Set reset behavior on assertion of WDOG_B signal */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_RESET_CTRL, WDOG_B_CFG_MASK, reset_ctrl);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to set WDOG_B reset behavior\n");
+
+	/*
+	 * The driver uses the LDO1OUT_H register to control the LDO1 regulator.
+	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
+	 * check if the pin is available as GPIO and set it to high.
+	 */
+	pf9453->sd_vsel_gpio = gpiod_get_optional(pf9453->dev, "sd-vsel", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(pf9453->sd_vsel_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->sd_vsel_gpio),
+				     "Failed to get SD_VSEL GPIO\n");
+
+	return 0;
+}
+
+static const struct of_device_id pf9453_of_match[] = {
+	{
+		.compatible = "nxp,pf9453",
+		.data = pf9453_regulators,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pf9453_of_match);
+
+static struct i2c_driver pf9453_i2c_driver = {
+	.driver = {
+		.name = "nxp-pf9453",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = pf9453_of_match,
+	},
+	.probe = pf9453_i2c_probe,
+};
+
+module_i2c_driver(pf9453_i2c_driver);
+
+MODULE_AUTHOR("Joy Zou <joy.zou@nxp.com>");
+MODULE_DESCRIPTION("NXP PF9453 Power Management IC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


