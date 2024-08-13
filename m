Return-Path: <linux-kernel+bounces-285052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700C9508B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F7FB222A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B11A01C9;
	Tue, 13 Aug 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mgh+NriZ"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8151A0731
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562138; cv=fail; b=EZj5bcycwD4kWwODtm0nTWIZhNbGCRp33wxgYGdL/84bWYmXfiLhgeyzk3RUDXneQajizd5Mm6EQ88xBQtLoootocHjuzi7xkKXun+WDYgvHy/gnsbJv0dqEwHV56WgNcRBrH4Io6LHz4Nab0AXxtjTTLIUKR/6LKOSguX/Lq4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562138; c=relaxed/simple;
	bh=phlwJ/9jw9NpeTB7NJPyHYpdTuYWHApnsz953oBcxmA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qrhOOWE2DFoDOO8IByq23deIeMPnPunmpC7RTWIYgrC8P7oVQrGKKQfGH5lYvUI5vtwSWd0moCMbxjw/sief6nIxwLEc54SBtv04sPoqyiGe7OEMXkeHu6XPswS7FH2hJrmSz2ywsfQxPjwY/lDdg7U6ZGpfVTdYKqt5XFr0pC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mgh+NriZ; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxXzihG7ID8i63Qb4T2n53zqrcIuZcuhjCzPv7akcMRxpNK/RKpRjQCAVp0HF+DnNy4hsvnpswzlYOlBnmE7Nplh8qzq1k31RyE1IN266aQmDiUl+jk1x9I9zzSmjFVAps1CI2rBT/UZh1n9cbPUuc+DtXkFFdLb6UR2j+feei3M2bkR1R9ti1Y9sQLBzVkvbBJiKG8DSXc2nyeuobmpbSwOTzs353rUus5Yxcp2pKtOgRPD7RdRtlVA+dwwORr8L5KXuaQHQveZFSto6SYKuMt494YCMICyx4p1qwXyHE5MDlVhwXzP8ARA/pLA9uXkSe2OIxwvOmftE+4r/r+s7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khB9K849nl/MU67dxO7G2LRxt5J+Bs0EnkTKFa+J0gI=;
 b=VK3PEGAJYXvtRbUb4mRXwD7T6ZwsMgyCFnaMo7HKAVVs+D5b2tRC4Qjau4C/0v7UZbMr7Lui1Up6duHBoZCz8SkjZUnx1Uf8n5btmV0EBsz6Zwp+Y2Mkuc7APcNCQDCWgIO8ev5ZsPOUSRiMJ2f4J7e3Ypv2w5S4YJFbrl1ZfrSiT7kC5S7bN0wmSc1SIBQidfGIH5uAw7fVwoG6ZWQuhxBg4YMoBSS1HUpMvnrv/kNSCQmuB7iHdRQBsKNzfBQZMrWwUhcyO8blEZIuosLOmrId3kRkpxaqtyafnjgt1hbKKOLD1syUJuXYus/Ku63Xk5D3FqmKlSUg/Nsn+J87EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khB9K849nl/MU67dxO7G2LRxt5J+Bs0EnkTKFa+J0gI=;
 b=mgh+NriZdhkdWQGVszXiFQVjz4gCazZiavTrgqF8zmhkCexMxSIPm5k91DUeJx0pPHwTVLuTi2lj/JR8WsHBxX+IfsRDQU2Csr923Li9WxMkM/DAAyfWuSbwGdBOcHVmEX7ycp6yGibAVY9aHX9bKdrd0TSszN2QMweF/iXK6G/mWSCY2ElqIja0A74GDs+FCMZs+nqqpDQZRwShKPZoZ6IIqDHVvgXYMNRBcmij0nJeUHq3HYryeZQmharMBr3Ctkot9HSaxLHhBitAm7buPz0bckRpqngN3/+8pX8zZaAecB51UpEe7EXB2617ufVz1Oc5o7GZ0W9aFGTZH1Nf7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:02 -0400
Subject: [PATCH v2 04/11] i3c: master: Fix dynamic address leak when
 'assigned-address' is present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-4-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=3637;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=phlwJ/9jw9NpeTB7NJPyHYpdTuYWHApnsz953oBcxmA=;
 b=XkorDuHTQIQc2YaB/J76du/s/4YMDMHc9QxrNWTnndZq4FUTVLhRQHnMxHi9vJrPd+WCNwetc
 KRTC4kuH2UNAXmVZkFNSDUSYYCEbRPXXFN8Cl6yvWtOmOIFBKYvYXTg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: d19db243-70db-488c-5e14-08dcbbaac663
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bU5GTExIVGttS3JjZys0em55RlpacDMzSWdVeG00aTVwaWRpbEVrZGV4WFhW?=
 =?utf-8?B?cEJTdGFhdE91VVBIc3lmdk81U1czVzBCZ3pQTHJram9ZZGY3NXI1a0laUUZV?=
 =?utf-8?B?czBzMXU0bXdPSkFpd1NtbExQZi9CKzVvWXk0RndpbGtlZy84WEJnMjB1aE5v?=
 =?utf-8?B?VVAvelV0eHRYRDNNSGx6ajQwcnpvR2Z5a0c2eEY2YzIxVjJjM01FQXI3cHky?=
 =?utf-8?B?OUdXZ3EvcXIycEdXbHlVU2hOMDljbmxHenhuWGYxNUFaempNdU5ONk0zWVpW?=
 =?utf-8?B?K3hnekFQMVMyN05WS3lnWmxKMFRHSW1zL3JkWDVLbjllR204Z2hESytxL3Mr?=
 =?utf-8?B?KzIrVmtzamNVZzhJR2doN3dZMHhEYjdwQU5QRVlzUk51cXFGa24rRGYxbmJs?=
 =?utf-8?B?MzZZTCtMb1VJUEVUVGM0US9iQ2RjNWJPS3JpbWFqa2FQanNOUnFlQmtUOUow?=
 =?utf-8?B?U1BiS2dtVWl2RFRBZ1dLQXJsVmZxV2d0RHo2RUZES1ZJblpBcTVyNk9vMXpq?=
 =?utf-8?B?d3hqTVFqTm5JU1ZudXRLWGMxNllkUXFkaDBMbkg3U21MbjRPME1laWtPaFdx?=
 =?utf-8?B?WkZxV1E3UHdJSy9oWTVvOTQ4d0lYS0VSa2ZZcjFBN3drVzB3SjMyWnVkT2lV?=
 =?utf-8?B?T0hTV0VkbDUrdlVhaS91ZktycUVyRk5kb2YxTDA2cHpLUXAzNDNmYlQ0ZGV5?=
 =?utf-8?B?MFJBZ00ycis5MzZpSnRrd0FFbDk4UHZ5N1pyTFhLeis0SXM5Tmt5MnVVdW14?=
 =?utf-8?B?OHVCclJySkovcjFSck94QWR5TDlmV0YvSmozMzFHbWFnbDY4dC9vQVlxNDk2?=
 =?utf-8?B?bzJkdHl1VHllMW81U1YzbDd3MUtoOGl2cmloa2Y5Nm1ZVjJMVEd5Q250T3ph?=
 =?utf-8?B?bE1mNWxybXJzTWNVZkN0a0JhK0xnN0lJa3pDWWdsa3RZZUlLSzFzVlFnejFK?=
 =?utf-8?B?S0hOYkZjUjZSQXgrWUd2ZnhxWUhKNEtIc1ZqWTBHSmlWdUNMcmlTKzJTeXhi?=
 =?utf-8?B?RFROcG5rVWlxZkJQN0RFVFpDeDJ0NjVwZUxsWXlDdEc4Z3NmUFRIdFVRVXhK?=
 =?utf-8?B?b3pPK3FSZWdXUWZvbzVGeGZqeW9VK2xkcDBuUC9OOTc5Skg4NUpFbnV6cTJX?=
 =?utf-8?B?UkdhenZTdzdUK3EyODFMY2JWUmIyQy9HMjRsc0ZnQ05rM2hscGVFQnBWZEU4?=
 =?utf-8?B?VFFkaWx6ckwvVWhqc3E0cjR1Q3BKZzh5UXBCS2hoZitoSWMxeVBrcDZMK0ha?=
 =?utf-8?B?Z0dVd2VYVTFqU0w2WUg5NHRVbHA4YVRMV2pQOGZYblZPZWpKS0FqUkVrWURR?=
 =?utf-8?B?ZlltRDBjU0E5dy9INVFpWWNPMUhSU016a0wxZ1FiZGNSVGVvYzFZWDBaMWI0?=
 =?utf-8?B?ay9TWDROYk5XT3h1OW4xakNhTmpTeHpuYUZDOUhrT1pIMi9LOHZEN3o0bVEv?=
 =?utf-8?B?T0cxMmd0Um9SS3ZVbG5TQXMxZTBHVGVIazc1Ulc4T2xQL0x6VFcvdzFKY290?=
 =?utf-8?B?ZktiY0RhRHZaSDVzbmxsSUtiY0xMS0lYT0ZuN0htazd6WE9qa1lsMTRndzlI?=
 =?utf-8?B?ZlpQVk1GQXY5N3dXN2NncWxkZ0FUTWRjbSs1cVJscE1uOExsdnJkcFZLWmlw?=
 =?utf-8?B?YkF6T2w0c0t0aW53Ujd2WTNnVkc1U0FlbFZlMUthanYxakZ6cWd5SSs2MzFw?=
 =?utf-8?B?NitsbzRwQXU4QmVUaUo1OHFMcXNzczNuYmJtVWhIS0RGeGZXOEhQQ1ZYM2Jj?=
 =?utf-8?B?Q1pYWnVqOVU4OXhlQ1VQcEFKcG5mWklSeGo4R0txL3RSOUw5OEcxSSs5SVFu?=
 =?utf-8?B?TFJsMUc2eFZnZzRHWkF1RE1HZlUvaGIyUDY5S1k1MisyTWVHUVp6STBxTXFj?=
 =?utf-8?B?QUhNeEQvU0J2M2pXOGZpMVJMV1pJR2hnTUxLYk1CQ0Q3L2c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bWRYaytLbnhPOWV6ZFo2NGs5eUZKSXU2Sk8yNW1aaWNhTUNVWU1wblgvTm5W?=
 =?utf-8?B?MlMxdmljdG5XUXBjd3Z6cDBCTHdQVTZuS1ZoMytickdvZWIxOWd3ZXJ0bmhx?=
 =?utf-8?B?MEptTGRzL0pvNlA0bjJKVU1jYzY0RGdUWFhlTk1SNTY2ZStKM2NreU13aE9S?=
 =?utf-8?B?U29pbVI1cGwxWmFNcUNTTjJueStkYVBsS2M2MW1JY25pQ01GY1NuRTFQdzBH?=
 =?utf-8?B?cnJBU1o3SXZocmRVMlN3RkF1UWtzenM3TFNLQ0FXdTk5RGhOVjdUK3hDVDFO?=
 =?utf-8?B?MW5ZMjAzWkJtOERZMFdOb0h0K3RjSmVJRDhGR1AvUm9hSkdtYkEzbVp5ZExq?=
 =?utf-8?B?K0dzMVE4UmsrN3FEZmZLcGdqQjBoQ0hMczlXVVduOWdiU2ZFdE1FL0hiVnZZ?=
 =?utf-8?B?U0lXZDU1aVhPSFdQSkJXalBoMzFoeStDZlBRdmk1QzZheWU1cmhnTmN4R3ZY?=
 =?utf-8?B?b2QwK2hDczBSK3Zqdkt2WlFqMTBkdG0xNDU4R0xjK0JrZU8ycFRrd2oyTzd5?=
 =?utf-8?B?aGJ3UGUyangxM3BwRktGTXpOSTI0dW1Nd3pNT21qSWZoakdadVJRQ1lucFky?=
 =?utf-8?B?bHFBREdSZUR3ZCt3Yng0MnExYXkycWNJNFlVMFpvY1JkQjc0UXBYcDBSMHBa?=
 =?utf-8?B?azZrZ2FlcUQ5eDRhU25FVjBZR0VQT1piMDdnaVJIa05za01iSmlDVU52bENQ?=
 =?utf-8?B?c1phV0FaQklCNHc5NlJyanZVeUVZZ3ozWDZ6RWkvaTB3V1hGN3BFYkF6a3E5?=
 =?utf-8?B?TnNuQ2E1eVhmUXRWWDhRMlQ4c2sreUZqRm5nc09URTJyU253dlBoQUtTMjQ4?=
 =?utf-8?B?Y0ozOXdZcFBheFVmZ0NvelFvWDhkN1JlNnBXb2xJNkZJNTMwL1NMWkdUeXg3?=
 =?utf-8?B?bHh5ZnVBYW5ObHpIczJPd1NRUkVHQTh1c0V5VXpESzhxYWRVSnhDK25SQVI0?=
 =?utf-8?B?WXNjRjFGckswNDZ5d3ZLZ0Qzd1FBZUpMYjN4MFdBMitBMkRTNW9pcVNwSnpi?=
 =?utf-8?B?WHMraDk1WlpVaEhvZEVST0JhSGpXYzBwOEVhdWtLaDUrdjcvOStzYVViVzJS?=
 =?utf-8?B?ajJQbzhlMU5DbStCN3hqTUVqSXVZWUQrWk0vUnJXRTRzSEpFWnJHbFAvYU1i?=
 =?utf-8?B?aFl0ZE1rV3A5a0RjMXdKcG83QTZldElKR0kvclJaYlJNZzdTNk1leGM5YlBT?=
 =?utf-8?B?WlFxdDRuL3BvN2UyNXRrNUd0aTdXaFoxWCt0aTI4UVRCV09aWldYVzc4Wmp6?=
 =?utf-8?B?YW9LSWRsODdneXBLYlltVU1zWENwbFlvcWxwU2o1NU5Rc2RWWTZNRjR4dU9I?=
 =?utf-8?B?QXVuUDJHZHJYSWZwanBqNjU2VTZ1NkhPSXpaejhmSHFoaHNSbnhXSng2RGU0?=
 =?utf-8?B?T1gyM0h5L2dPNGRmUy9HOVRFTWVEOGNPQThBY2lZclVES1BaemFFb3h2b1U4?=
 =?utf-8?B?bHRPNDU1aGt5MjlxMzlIZTRaUzNKVXAxdUlmQ0M1dVIxeEkyUHdLYzBkNHFX?=
 =?utf-8?B?VXdOdUFEb0IrS3M4R2wvc2doUWRoY3pReXNCTjJnZVlETzhaUm0xaVp1TlVu?=
 =?utf-8?B?OCsxZVZCU25HN051UDhmYlZBZHlXTkpOZUdBNUFXNE9rMkQyMWZSamd1b1JX?=
 =?utf-8?B?Qnl5WmlwTFNSaU1zcE1kcWNPTEdlOFJZUzZ0b25JdWRndG9rRUVsWW5zWjBx?=
 =?utf-8?B?cFZTclpNSmdaRm9RVythYzlvT2FjaWpGMEdEbXFORVJWWks2bHYxQysxWmt3?=
 =?utf-8?B?aWp2empBSW5XcUNhQmNiTTJtU0IyVTVDaG9oQjZCVWk5RVE3clVRUSttS0Jm?=
 =?utf-8?B?eVZUZ3hJZUlWaHFhYUpTNUNpcm5tVEV5d29UYlVOeGw2cFZHUEFzRjFUd1BR?=
 =?utf-8?B?Y1p6QmcvWDYwc2lrMDB4Q2Y2WHpDczZtZ0VRQWpoREJWVTRCc1BsSUFUZStS?=
 =?utf-8?B?bkIzL3ZIaVVBUkxNMW5Ma0JKaUg1dXBlU2dCQWZST1lpTWE2OVJiWkRrR0lD?=
 =?utf-8?B?aktvc2V3c0xKaWw3cXJlb0hJS2ZITXEzS25jUmU1RzliMjdBRTlGUmpIYW5y?=
 =?utf-8?B?MjVsR1ZibU5kS0N5eWRmdHgrSmZDQzRkSjlSUk90NmhrR09zdnR5eHlMdFpn?=
 =?utf-8?Q?mEBE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19db243-70db-488c-5e14-08dcbbaac663
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:32.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5T3FpzSUd4eWub+nl7NzZ3fkMawjLN9iDKILNeFp9n4A90Rdx/+x4AG0u0ZX1FZfJsj0s2wvyJBcsEjoSDDoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

If the DTS contains 'assigned-address', a dynamic address leak occurs
during hotjoin events.

Assume a device have assigned-address 0xb.
  - Device issue Hotjoin
  - Call i3c_master_do_daa()
  - Call driver xxx_do_daa()
  - Call i3c_master_get_free_addr() to get dynamic address 0x9
  - i3c_master_add_i3c_dev_locked(0x9)
  -     expected_dyn_addr  = newdev->boardinfo->init_dyn_addr (0xb);
  -     i3c_master_reattach_i3c_dev(newdev(0xb), old_dyn_addr(0x9));
  -         if (dev->info.dyn_addr != old_dyn_addr &&
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 0xb != 0x9 -> TRUE
                (!dev->boardinfo ||
                 ^^^^^^^^^^^^^^^ ->  FALSE
                 dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 0xb != 0xb      ->  FALSE
                 ...
                 i3c_bus_set_addr_slot_status(&master->bus, old_dyn_addr,
                                                     I3C_ADDR_SLOT_FREE);
		 ^^^
                 This will be skipped. So old_dyn_addr never free
            }

  - i3c_master_get_free_addr() will return increased sequence number.

Remove dev->info.dyn_addr != dev->boardinfo->init_dyn_addr condition check.
dev->info.dyn_addr should be checked before calling this function because
i3c_master_setnewda_locked() has already been called and the target device
has already accepted dyn_addr. It is too late to check if dyn_addr is free
in i3c_master_reattach_i3c_dev().

Add check to ensure expected_dyn_addr is free before
i3c_master_setnewda_locked().

Fixes: cc3a392d69b6 ("i3c: master: fix for SETDASA and DAA process")
Cc: stable@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 4281f673e08d8..c8eaeada54781 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1531,16 +1531,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 				       u8 old_dyn_addr)
 {
 	struct i3c_master_controller *master = i3c_dev_get_master(dev);
-	enum i3c_addr_slot_status status;
 	int ret;
 
-	if (dev->info.dyn_addr != old_dyn_addr &&
-	    (!dev->boardinfo ||
-	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
-		status = i3c_bus_get_addr_slot_status(&master->bus,
-						      dev->info.dyn_addr);
-		if (status != I3C_ADDR_SLOT_FREE)
-			return -EBUSY;
+	if (dev->info.dyn_addr != old_dyn_addr) {
 		i3c_bus_set_addr_slot_status(&master->bus,
 					     dev->info.dyn_addr,
 					     I3C_ADDR_SLOT_I3C_DEV);
@@ -1931,9 +1924,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
+		/* Not mark as occupied until real device exist in bus */
 		i3c_bus_set_addr_slot_status_ext(&master->bus,
 						 i3cboardinfo->init_dyn_addr,
-						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
+						 I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
@@ -2094,7 +2088,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	else
 		expected_dyn_addr = newdev->info.dyn_addr;
 
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (newdev->info.dyn_addr != expected_dyn_addr &&
+	    i3c_bus_get_addr_slot_status(&master->bus, expected_dyn_addr) == I3C_ADDR_SLOT_FREE) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.

-- 
2.34.1


