Return-Path: <linux-kernel+bounces-444010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2B9EFF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D15188F0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AD91DE3C2;
	Thu, 12 Dec 2024 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nKtt80Dv"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAE1CD205;
	Thu, 12 Dec 2024 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042408; cv=fail; b=Jb6HZ/sby91TtmipVXfacWK5bwH+0zVG0TCRkEXFYQnJl7JpYVBvWEMhXN766fXUUxSusi4RX3OBM2MObGWHaNn+JluKqmSRe0bE5NMLDM8RSFLSYMIFUrn5dx3JSfbD53ZgFA0tbQHHFVfrZfMnlb+FtfkS+HQkJiJolG0+zmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042408; c=relaxed/simple;
	bh=zOnpVfjm7/x6VsX4z9T0KILBUQufTXIZ3lcmgyXmUbk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=D3/SC6vDVseEZ3rGafStrks74SKipRI6bhqvGFvAaN9gOKKa6LsHTyIeY4M1ryNrHIG/nSextZEPr/1EVuSjHQTw5MUHmKMtGe0SPIhYV5EoVg1aNUFP53Tza4YPQhuRMv8+AEVUJHLU8WAeUBS5Ajs0Tbtgm3DgGcPrtKzJVss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nKtt80Dv; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gi9uk13aLjYb3gCC6sG6ufeWyyvQ5NZ4rTV6zS6//PxwWPfJpgG6C9iyEqL97wa1GRWnKQu0OxLZ0GPwH1hj3KbNDycFCG93JeEWdqjW16AP/ns8ZMg6GkXXhESCg/Wu5VrhlMeasDnYuqIW7uRU3TyosBZ1Q7gsYa9JxZlolFRI1PU6XbV16QCGB+Fhu4B4VQiHb8+aIIaN5Vd1BDanDQHeZNsJwwTmRlTdi89o6sWnuH+xX4dHwv4ANSr5aS0nMNNNHDPT4QTPKkdLFvtuZUQ3pCXLSDfqFDm6TurlSAl7r+iqk4A5fNeItQ96cjWeZ9uY4h7Re2/4kOY+lqiAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT2WwkuqRe+GP3HGPlQKR1a87iW6WhIUDYhcQPMO1Zk=;
 b=O/pIcejdeQo4La4B1X7KAXr+HOX2zyFJukf7gLOly1QE7h14JsYqF4KRy9ucjPuwNxOj4vXApFqlbTn2wRYPNDVZINr3XMgz6fTVmt8AS9xMOuWSkNHoVXIl+TZnaWFecRhicdCKuzrY1wV3YjiC6dne9OfHQx1R2lzmiEjBcyMbqDoKlBd2dyKV/hsMfw4Zpj/Q9aPwwSCd3yLWCj6CEtMEKnrZXoOYs1MMdl4LoeQDkffZdcbZsokiplGfNFiMMizG/5INUMEIDqvUBZSMgbVDGPzkGkwoc0hCXQuoZpjIG+GYO0ANMDiNViX4bk6KlSARippmnGN0/0QAg3vRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT2WwkuqRe+GP3HGPlQKR1a87iW6WhIUDYhcQPMO1Zk=;
 b=nKtt80Dvzab6u45ADtQ6FVCDT1Z5qJ3U1cmPuVbt9edg+oSz0t0yRmDWUeAmyf1aA7j7i5jL5Yx19lZ77xOO7ND3kJjWIyYDcoPfnc3xxDUu85zrydJcBhoxv1dGeW7FVemwgKUMjoUUMS748lgbF01KSVuVpumSDwb9YerqxBZeX4Y/fKMs5fVe9JOxpxm/U7fAv79aMRwhfbHCXg+w/F4Rp4PxIRY0bRT6wX1Hhi1707jZJN3kjCsrLEx//wXUfvPzRCopS0vsR/mqBQWWxCNzdM5DrFaa3DDOmWaRphrXToW1976nbvDD8shg5+SUXdfatH71/tplzYYOfzRe5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:26:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 22:26:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/2] regulator: add new PMIC PF9453 support
Date: Thu, 12 Dec 2024 17:26:23 -0500
Message-Id: <20241212-pf9453-v2-0-f59d2c096356@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA9jW2cC/zXMQQ7CIBCF4as0sxbDIGDrynuYLrBMLQuBgCE1D
 XcXm3T5v7x8G2RKjjLcug0SFZdd8C3EqYNpMf5FzNnWILiQKLhicR6kurCBU2+f1igtDLRzTDS
 7dYceY+vF5U9I390t+F8PQh9EQcYZktS9QpTiine/xvMU3jDWWn+1nHcVmgAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734042396; l=1081;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zOnpVfjm7/x6VsX4z9T0KILBUQufTXIZ3lcmgyXmUbk=;
 b=C3wytEmnECK2ji7ONcs2D7qpzATC4+NuoD3ptI+Hdn0eOL9Yq6eirtIJIottWhnQrU04jO2FR
 nfsUD3vNio+CgrQn/iyTBcuqlUfXdinq9WjdBMyotufwhybAvt28/LE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa46f57-84de-485e-6356-08dd1afc0c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|52116014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUtRRjNPK2laNWlCUkpUWSt1VGpyam16eE5TQWxKQzVvR0FIQlFjQklQUDlY?=
 =?utf-8?B?OHJvbnhYdHk4d2djc2NPYmdBbW1kRiswd2F2VVdVOUd3dzh3ZnhZbEMvSnVH?=
 =?utf-8?B?RDE3NUFMQjcyVGxjeEIzTWhGdDRPaTBrejJiWVh4VjNwQVdPTEgwaVNadDVk?=
 =?utf-8?B?cFlVQk9zRjNnekQwY3hoQkNRZ3VObExKUU5hS1ZYNHV4K3I2UTd2aXRHR3d3?=
 =?utf-8?B?bFdwVUpLRGdRYyt6aDZRSDRLbHJuOUxxRWhYbkdGcFphWUsrcGRxcytSa25x?=
 =?utf-8?B?d3lFY1BIMm9iR2l2dk90RmxDNU1ySWFTTEVSR240UzVIZ2ozYUhoU2lVMnR6?=
 =?utf-8?B?akM3OHZwcE9ZUkI4YU01MGgvVlFZU0tDTFJ1WEh5TTVKQlp5RUg3RktIRFc1?=
 =?utf-8?B?ZjdlOUlocnBpUWZrNzBsSHVVcFpyclk5aDZYQ1hMREhNUnp6T1VwVzErUmlW?=
 =?utf-8?B?dDN6aEVoSXhEWTE5QU5RS0hNcUZjVStzOTZOM2NSZDdyRXhvcmtMaDBVdDJS?=
 =?utf-8?B?a0o2MDVzVUpmRTJ4ZkJaNTB3VU9ESnNJYVNHZm5qNTNyMkJzY1gwY0gva2tG?=
 =?utf-8?B?cDJyM0tIaGZIajViYUhSKzI5U09EajRxNnNhRTdTU1FMT3daK0RrdHZ2YlhQ?=
 =?utf-8?B?U0VJTUVQekNZaVNISm1hZi95RTR0ZlRYand4cFZBMExLVVZLQ3Y2WjVUdFdy?=
 =?utf-8?B?Zmk5OEFXeVdNVHFSR2luQjQyeU9KZ0tSWXpVSjZVVWZycmlNZVY2Znl4alNZ?=
 =?utf-8?B?WU1KcG1nWEk5NzZtTFVrRjZYWWhJKzQ1WmxLcVB6bHREREFRVncxMFFyazgw?=
 =?utf-8?B?eXFNTEFpSHd3UE1VNVFscVVkc2YyQytabHdSTjU5b3VuQXg2MGx5RnVXK25v?=
 =?utf-8?B?S3RkRUFqZUFvVi90K1ZqZEpyNzNZK0pDZ1JPMFREbitYQ3h1SUUvMnFFQkds?=
 =?utf-8?B?QWE4VEJUV1NDQjkvM0JTVDBtbURlTFZvbEJJYkZxOWpCd3A5T3c0VUJlWTBV?=
 =?utf-8?B?eFBkS0E3cEMybjdmZyt0UXBXd1hicWdFNUM0OXlBMk45cHI4K1h5SThLc0Vx?=
 =?utf-8?B?SWp6Y0RPV25xSksxTDl4bzBYQld4YmhocFNUemtaSExrUmRtbDJEQnFPZ2tl?=
 =?utf-8?B?THdJajJVd1V0YkVTQ003UWY0UFM2Z29sTE9uRGtZWVpLc01ibGcrN2lFdHFV?=
 =?utf-8?B?TzZ4elB5U3JNQStUamhidmpFcVdYWitOcU9hTWlMbjNDek5Fa1JidW1xRU1t?=
 =?utf-8?B?cmNoQ0U3aitmaFl5ZERDMWZSeFZMZVR1bXJtN2Y4M0VsYTNnN3VGYW13L2Fl?=
 =?utf-8?B?a1pvMWVlcGdCNnRPSTlGQ2NoN2V2QkZkQi8wQzY3OS9ZQlJUTVFQRTYrTmJ4?=
 =?utf-8?B?cEFabG02cExvZW02RzRZdU5rYkEySkRlMWlGM0NFZXIxUUJ6TWo0NDI3eTN3?=
 =?utf-8?B?NHNzSlZXV0FoR0hJZVhjRWVGSnBtTU9BYmVOdE5nMG0ydTZNVXp2Y2NuQTNN?=
 =?utf-8?B?c0taOXpBTmFUbmhsN25ZYmJ4MUhXemZoNEpqdWJEaCtzWnJXRExtN2FTWjM1?=
 =?utf-8?B?WG9ISVI3ZmxXZ0J3eGNYU1dNalJyMG1mTWY0VlM1UDFsdEhqV1JPeHdjQW5J?=
 =?utf-8?B?T1RvL0JOdmpTWkZ2RmEyQU1OckYwSEk0Y0lYQmhPbjdhbXZ5VXdRY011UWNY?=
 =?utf-8?B?NW9ubFlWTDRqSTRoOGxDQzNQSzJiL3A0ckd1OXRyV2ZXak00VjBWRG50eDdQ?=
 =?utf-8?B?czJhZnd2dzR5Vy9JWHdQQlQzUXdCQ2gwMk1UZzMrK3IyYXFVdDZXcklRcm02?=
 =?utf-8?Q?A1daGove5cgSgapAWpsXoRhzlWovByKL+wQ5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(52116014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmlPM1JWamk5N2JxMTRjZUxSakVvMWMwa2tyUXR6ZUJqaUZxL1kxL0prd0RV?=
 =?utf-8?B?ekpiVEhwOWxJRllDK045QXVualViNzZEYlJ2eHpnRXV5VDBla21wZ2o3RjVh?=
 =?utf-8?B?bnhrUWp4bG9tZC83MFZmbk1WaXZlNDFZWTNmUE9OMGwxQ0R3ejFPY2p6UjBF?=
 =?utf-8?B?eWl0THh0U3J6cGRqazc5S3ZHQUFPcUZJYmFVOUtadG9wVzB1TXhLSHg5K204?=
 =?utf-8?B?WEp4SUtVWmNYaElSWTBpSXRzM0VmTjFvN3RPRVAyYU9oa1l2VFZiQk1YWEND?=
 =?utf-8?B?bm56UWp3NCt1ZWJXeE9SenV6YVAwRWlYY1RwTnZ0STdsbVE0Um9oaDlJRmNP?=
 =?utf-8?B?eEpGQzJJTGRLS1ZWcGNlTThVcDJjaTREYVNrbTBrWG13TVl1Wk0yUGdXWHFy?=
 =?utf-8?B?bGlLck9WcHErY1lpNnNNV202WHB2YjJpa3BvQUduREEvdXgzd2tuUnhTbU9Q?=
 =?utf-8?B?cjFzbFZNTE9lbHd0bEs5aWNTU1RwTnhDVTc5andNd0kxYVVtN0JLcUMxUTMr?=
 =?utf-8?B?S3lZaVZRWHljSFhXdWhVd01PK3VmRVl3NEFSWVVRTk93QXc3R2VwRlN1RmJE?=
 =?utf-8?B?YU9CM0RyOWkyR2ppeVBzMGYyV012bTJ6MGd3b0l1K1VFcEMySkoydUZqMjNO?=
 =?utf-8?B?SS9jcUNHVWk5VitSN29aL00wUkRCdkhLcmFySGlBMkdKekJ5Nm1QRHB3d0JD?=
 =?utf-8?B?dEZDeER5Y2lKTHhocWpmN0plWnpHU3l0Tm5NckFHRGorbW0vM1RNb3ZidW1L?=
 =?utf-8?B?cys2UjJoRnRQZDQrTkJ4cTJrMVBKWmZ6T2tYczY0Zk83ZmtxeG1VSEoxTHds?=
 =?utf-8?B?bnB6azVRQktjdnJUL0dUbHQzWXlEOXpSQ2M3ZjkwZ3BDbnVzem42ZEVzM1ZL?=
 =?utf-8?B?Y0NLZUUwR0FJRHdlSVMwNVJ4Q0NxNzl5QzNMMHpFU1dESWt1NjV0WlFJNG1U?=
 =?utf-8?B?SFR1clE3ZHcxQ1A0bHdXUTY5ZlJ4eVVDQlJGQ2pXRU0rNDZzUmNzWTVvSnNY?=
 =?utf-8?B?M2x1Wis1Q3lPdW53M3dCMHpZditrdzR4dFlTbVFKWEo2QTFJbXJ3M1hUaDdq?=
 =?utf-8?B?LzRaeHVBYUJLYkFqTEU3cGtRZUJ5VmVCRm14b3ZNaVJHbkVyUU5lU3VxOFdR?=
 =?utf-8?B?eGNOWklyQTRBVTYrWWhtekJwTHdOUmZXdFNLSTFPbXRNamRKbE1GMEtuT0pW?=
 =?utf-8?B?bVk5ZHB1dEcxYUhiSFh1YjFKUDNtaURmRXVyQVFkNTh2L0M0L3NSMEJobFNr?=
 =?utf-8?B?Q0Rqc2tJMjA0OVJEaXRBVC9XNzBIY2JWc0llM1lLWGVNWFN3RkFDTExCTGI1?=
 =?utf-8?B?S1pZVWRvVkJqYnRlNlZtaDA5UFptNFltNHM3UVJXM2ZvVWRKNWt0aGptRzlw?=
 =?utf-8?B?ZmVVRUlMaERYUjhFaWtkVUpLa2s1NldYSXZvK0FvKzN0eHpYVFk2Nlk5K25D?=
 =?utf-8?B?ZTdKWjRxZjJvd0diTkE2eVMxZjJMMTZudE14VXZWcGxMVlBIV2poaGhDaXl3?=
 =?utf-8?B?b0FlY1IwaWhIYWwvbG52elo5R3dmdTByZFJQZTdwYzNGd0VLamMxVWVoUjk4?=
 =?utf-8?B?eFo0WGZEODdkRGVwSW95Wm5NMDRMWHdWcnIwbkN4NDNDeWNvK2txUjdZRDRi?=
 =?utf-8?B?WnVCYXFDZzJGM3ljSUNkcE1BSWFIY1UwWDhXbWZTYlZyM3B4bGw0Ni8wYkdM?=
 =?utf-8?B?cEkwMTBCVExQS2pleXlLNUE5cmNXcDdMR0FnK0tjMTBiOS8zL2FBZ1RDQWZl?=
 =?utf-8?B?SThseGVLa3M5eUQ0dXFSMDFHQnlqaStkaGZuY2dKQXhTYUM2VnNXYjUrSytt?=
 =?utf-8?B?akZJZ1dJOGIrMXpldDNtdnFDSDhSS1NuREQ2dGJvam1KdDh5d3lDZlBRd1ZL?=
 =?utf-8?B?bFJBeEc5bUVZQzFNWmV5aVhUZURaNDFXTXJ1MHFYaFdRYXpTRXpMeW9GTGlH?=
 =?utf-8?B?TjdaVEs2eWZsWjdWTUVCajhtQ1hBMFBEZ0lMRmtQOXBMNzVZd0c2THpZVjRF?=
 =?utf-8?B?VGlnVVhkVks4ZVE0MWI1VGhoVnBVTy9TVmxmS3IyN1JjTXB1VVdaT29Rd1pT?=
 =?utf-8?B?YUY1RUhYZnJ1emNUN0NSajBsaTZITTc0T1AyYzVRK21XVGs1NDBxTHFvekFy?=
 =?utf-8?B?V0pqbysydEpXeUdlbW1QTXVLTTZhMkJQTmF6NUR2RHZGaTFLbmJXUzdRdmF5?=
 =?utf-8?Q?58fiq/nQB70oU86B5kZQbOE8eX6OpBbgaizlWg1YeaRd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa46f57-84de-485e-6356-08dd1afc0c17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:26:39.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slFSo+/aT7mkAZBDgZJcLnKysG2F2WEK4XHwV4r1GpfHqfGlzSI1tsTZDIIRNFM+vlS5ilDuChyRBqZO3HKVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061

Add binding doc and driver.

DTS part wait for
https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Reuse nxp,pca9450-regulator.yaml. Add nxp,pf9453 in nxp,pca9450-regulator.yaml
instead of create new one.
- Link to v1: https://lore.kernel.org/r/20241206-pf9453-v1-0-1e4685114271@nxp.com

---
Frank Li (1):
      regulator: dt-bindings: pca9450: Add nxp,pf9453 compatible string

Joy Zou (1):
      regulator: pf9453: add PMIC PF9453 support

 .../bindings/regulator/nxp,pca9450-regulator.yaml  |  24 +-
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf9453-regulator.c               | 723 +++++++++++++++++++++
 drivers/regulator/pf9453.h                         | 171 +++++
 5 files changed, 925 insertions(+), 1 deletion(-)
---
base-commit: 0768222687cbdbe7c300c4428f0c0c6b153386e3
change-id: 20241205-pf9453-90e8dbda562a

Best regards,
---
Frank Li <Frank.Li@nxp.com>


