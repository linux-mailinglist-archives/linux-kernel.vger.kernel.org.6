Return-Path: <linux-kernel+bounces-292453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA846956FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923C9284870
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3E187873;
	Mon, 19 Aug 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fZJg5PRY"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9817BED0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083348; cv=fail; b=NdxlKXzFBEX4Jyl0jiOoUxTbLX07UkD7edw4Omqvl5JSXKIw/9JvNEGRNv7TlPshJrIXDIezw9VVphBFBSQK81bU5xX9XgmslpieLOLGWK348mG3cB7kadtAJQQzReEseOLQstNzHDhuCWJcms7uxKYwOyxKWm9hpZbRpOcYzYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083348; c=relaxed/simple;
	bh=An63rdNKf8siEFmhpUTOtrd2drbSwaCzp/D7qZONW80=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h0iUyXG4t/Yttb09z+KTIPJxFF6JEp+ecRtlfuh9U4/CRucmoF/EWGm4vbx6KKPmq2mkePa2yskUaodGwN7pncNPZNt/vKCV2f4dilrzacGahgmStSAOBGBzt8Z0bXy3Db5zcea5pPrR+5L8FrW+pzhVrGWKjcmz119exISZhF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fZJg5PRY; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsReliGiUowy30l+4RgCrLFb99vT0cnfktYBq9iJF7hLoj28msq0gA3nUXXfos3JzyOX/s8rrWRd8ZAuLRx6y8sRcd3i6cVbHrOB9uhqcLsHpFUU7aj56BGjMoAOMsyuyPW38OKyI8YvWF3gu2hHnoTvrTwALP2ddpFpv+EmlsVHYGbX0ddtUuZ+RY1sWFVh+S4Bj41td+QVnJd+C12i144oPdeNf9jTP9nHIxRc+6oNTl4nJaTdetDmVnDnH4t4iLpM2F4ERimCEHl0iOiVHwdbE9YKxuIhTMvXSqXFkmL0V+FiDhtx3HKfDywXuacXrwL33SNy7ft2Vn11nuZbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDbmmbFgBxhKaOhHOUp/UpYi2/c+KPJaw5dvLjPdxrI=;
 b=psJ88Gb4FD4lUAbUg/9rOviAsw1/2Fd63jvBW3I/fwpQZhXcInQV/VLiBHZkQgpokk3ZjcocedZtxntSIBE5BlgSlAUMs4fc/Ci6oPnoSf8HjJVGeqqXfFh9CfHJRqUdfr6lZJY5NVKLoA8Fy/pujOpQC0aTObE1cMOYrGpeKAThT0RI5PP656WwRy9aaK08RD8mgKumRFzqufRscw8zLmgvv4xVlPhTdiW+nJIvDVKpMwxZEnrGNBYsWEFVD7nyqyUxoCtr4Ee2lPh614A19Ousk8SKRaze0tsa8MImui1xNj2zFnIluHyel11XbFj2LjH7JARbXRcaZVmbHlHDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDbmmbFgBxhKaOhHOUp/UpYi2/c+KPJaw5dvLjPdxrI=;
 b=fZJg5PRYWkOiN2bC8h3UYozQjeW2SY57hVHkcsaoCOOBSr2tuTLjBQmZO2hLoUqrst33OBZ/DCsIN86hqbAaxMqm4HGP9Oibq1rtLUIWbVyXTizYVRlNouD/Z1+U901fvH90C5P8xFvUQyodR2Q4377GmI2PP9Yav3FWXwP2qNJewjFinRk77II35eiTIZ8j2iv9/fDE/xuXd7fqM2//tqCbT8LngC/i/YyzipPdS2PfBzIxYM6Q36LUEhU+POXcTxdjQQRw1yv/gZrxIA3UJUy2H8w/Tj9tQneTSI4ze5jqiNWSJLfAxuIp1gCLNj4lI1tYXW3p6/rs6/6tFw5llg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:02:00 -0400
Subject: [PATCH v3 06/11] i3c: master: svc: use repeat start when IBI WIN
 happens
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-6-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=3542;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=An63rdNKf8siEFmhpUTOtrd2drbSwaCzp/D7qZONW80=;
 b=U2Nu86+MwI/9suQLnHtXPMrp2ou+GnLcJelxmoeibsrAu75XESa3qrNRY2K5Aj4Bq3gim7jEy
 FWMd0ltnxafDYH4Q4K6WvxdtSjen2bIeELbiCZsIz1O6heU1WUCmFhR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1fa9b3-01fc-4168-9ba5-08dcc0684f7c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MU8vSmRlcjFyVk8zQ3REa3FBQ1pub1BHQWs2azM1YjNkd3JBNEx3TnZFejBk?=
 =?utf-8?B?Q3dlUC9hMGZ4VkdxclZyd005NUN5eU56MFoydVF3Qy9nbzNoR2pFK3VQdm0w?=
 =?utf-8?B?eEtGc0g4eCtrQmFRV3ljRko3UGFBWTNvSU9qWTFlQXZySzhuOEtmcHNJZVhq?=
 =?utf-8?B?bkVLZCt1S3dkZktjK2swVDlZdEU1RllNZm9QTnUzcDVhWHJwNnlURE9vZzlU?=
 =?utf-8?B?SU8ySXhwM3o3MmlGcHFiZG9kdCs5MHNiVzNudXpPVzVBbG1DQ0R0K1lhY3pT?=
 =?utf-8?B?SlNUcEhCckxFUkVyT0FYY0ZHbU55NHJRT09FNDJKQXd5RkdXeitkU3RBcCtq?=
 =?utf-8?B?dkJ3ZFRnSG9HVmE0YStJTXFBWnpxcGR2SEM0aUVoek1uTGdLRE9NZ0hDMHVk?=
 =?utf-8?B?d0dVNXVxWVNOTGZiNUdxZDR1cE1GTVdzempsSyt2UEYyemZJQ3hIbGQzSmVi?=
 =?utf-8?B?TnZrNGgvSkhOZStwQXArb3doQXF4M0ZwQW9hOHM2UUtkK0FzMzdhYVo4YmVF?=
 =?utf-8?B?Nnc0UkJ5WVdqUURkditvMFc5SEhEeDZCSStGcjcvYVNHallvUFF6VUNSc3J6?=
 =?utf-8?B?TlNtUjFsb1dnMWM4MXByTEhPNjQ2UmF3M3FOakxmS1UwM2RDZXJrOUt1QmVi?=
 =?utf-8?B?YUk5WTZFdFh2WEpzdnAwNUN0bUhkQ1Zsc1hhMXUyT21BN01wNVZuZG14QU5i?=
 =?utf-8?B?Z05nUXFvUWNhTmRYOUx2eTJBTWwwcFF2Y3AxOThycjJMUElkSkRvaFlKczNy?=
 =?utf-8?B?OVNNREJ1UWI2ZWJXaDdNRWc3d205bU95WFFkUWNXWWhyeFFRSDdmZWx0Vnpp?=
 =?utf-8?B?S01LWGlCMTJDdXdCWFNPc0pzLzhZK05jSk1Xb0ROZldNTzdzV0pEUTZPbHlE?=
 =?utf-8?B?MFJkY0FFaTJnWVVLdWlLVUQ2TFJ0NGRKK01adEswTUEyRU1HQ0Y5YklNWnpB?=
 =?utf-8?B?bm9mWll0M2hhTDVJWUcxUEE3bmFuRWdSUEk3azFYdStKYndoRjQzZ1hZNHNs?=
 =?utf-8?B?VWQ5eHRxMTJBRUxKQ0dldTVxMlpVVUNuZHNyVkhOaStPelBjUGJQcXc2bU43?=
 =?utf-8?B?MkJ0dHFlbGFxUUlHQXc3WFdWQllUenlEYmlFVTZIN0s1L3FHTjNvUENkVTR6?=
 =?utf-8?B?MDU3Z2tyQU1QTjc4QXF2WUNYZDd0RTVsb3ZjN2FTaEp0MS95a3VWNHdhbHdO?=
 =?utf-8?B?OFY0MXF0YWhiVnF4MnJjMm9wNVd2dk8weUtYS0lUS0NrN0lPSHEzOWdxRDE4?=
 =?utf-8?B?UGcxVmo5eCtzMi8yQXVlY1VLR01jbGlPbmZUNkh4ZjBSU2lCb3dRTE5jd0Vs?=
 =?utf-8?B?S0haemcxcE1LeXV3UVlTOE1OcnlMdkg1TWhrV0VwdDdMY3NCbjQ4N2NqWjl3?=
 =?utf-8?B?am40SjFONEVyeVErNHduWmZlN2lYaG9HV09PV1JCVWV5d25oMWp2R3VyeVJW?=
 =?utf-8?B?ZXArRzljWEc1TFovclVoM3BleVRnZDh3T2RBeE9uMVBVTmpwVTNvQUc3T1ZO?=
 =?utf-8?B?MUVLaXNZcVE1ZUdyNERQelplMXZ3T1Vob29Hbkd4NkVRZGlOWStMU012RFk1?=
 =?utf-8?B?YjkzdWtLREZNOUNQR1Y1Szl2ZVRkeDV0eXVaQkROS096anlRdEY0U2hhaUdN?=
 =?utf-8?B?R2hFUDhiWVR3eklSYW96dlg0QU91REVMa0tReFlxU0V3VXcwamxPbFAxcEhY?=
 =?utf-8?B?S01rZytrUEl5dUFBSXQ5RmF4NVp1bHNXSmlZZzJDc2ZjcERCN3piTk1yNHE2?=
 =?utf-8?B?b1FEM3FpREpGN21VS3dNMzh3WnhCSWR4dFJHOW9ucjFnTVlLa3hwU2VXNWR0?=
 =?utf-8?B?TDg4UzZLVWp1S2k3bWFtemVzWWZQRDZNMlVzUzdSRUZENjQrSWJadWwwT3E4?=
 =?utf-8?B?NzFYK0JNaUE1UVdocE5scXI2L1NKcVBEWmFmK211YjRybVE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dE5reFBhVmRNS0NUMkw5dWM0UjNlVll5NDVDNWtxQXJLdEREaE9MMXhtR2VG?=
 =?utf-8?B?ZlBvNmRZOTVTYlZ2azd0NHNXdWNvd1hPYm5tMmJJL0JtK0tzOCsyeWZrcXhG?=
 =?utf-8?B?UVgzSXpIN3RnODRldXM0bkY0S2lpVnZJZVF5dTMzTDVZNFRBaDRBMHFjdm5t?=
 =?utf-8?B?ZUtNaGZlNG9nd0tZSXMydnUrWW5tRjJFMzdvbDZTdTFGYldTdE1MVTBNQnNG?=
 =?utf-8?B?bUVRQmlrdmNxMEdXdjN2WUZpc0hHQ1orZnVSeWVJNjAxUHkxK0tVM1lBd3A0?=
 =?utf-8?B?a1B2dTJsMlQ2N2hRbnNodS9scGhHU1NaTTJVOG90bi83dGZFaDVTYzZXZzRy?=
 =?utf-8?B?VG80K1lmKzQvR0JrSkp1ZnpxVFJ3djR3K0Y0NFk1aXI4RktKUFExME14Q2xK?=
 =?utf-8?B?emxhcWV4bzQvMHN3UU1KWXgxajhqazRDNUlSRStrM2MzS2JLV2Y4aGlGbjV0?=
 =?utf-8?B?aGhnRXpIMllPTEkxaW9xdWdIV3pRQXpXM01yYVEyaHhubWdZd0NzMUNUNE9L?=
 =?utf-8?B?TWpSUDA3Q3BwM2xuc0Nna1JaaFRCcENkaGlWZnFDUVliMEZZREFldnRFMVNV?=
 =?utf-8?B?RWlZWHZqWVdONWNWYXU0T3I3NjN2aDVqaTBMb2txbFJyQ1IwZ0c5ekErbk4w?=
 =?utf-8?B?QXkxRVFhWXI5QWtoOU5ZdTU2RFBTK1lTRG92dmpEdThHbVpZUTlsMURsNzBD?=
 =?utf-8?B?ZlBxb3pJOHVxNzQxZ2ZXVTliUHlqSXNZeDcwS3d2cEZhZ1luU1VyYTNTNHpk?=
 =?utf-8?B?cEQvWVEvb0c1TmRheW1yc09OUUQ2MmlKRWlwK0tiWThiNVRqU2YveFEyajFH?=
 =?utf-8?B?bWE4a0d5YlJKcnR4Wk5Oa0U4aldoTm4zMklyYVRtdktwemxaaDJTeWk3Qm5l?=
 =?utf-8?B?YXpudi9PRmZYYXA2ZXJoSWhpREY4ajU0T25YOUkwWE52bklJWEJ5dVhMeG5v?=
 =?utf-8?B?YkRJR1NydktORFdCNStqdjU1NmNrZXdEY2NROS9saHI1L2JBWTZaNzIySW1x?=
 =?utf-8?B?c3dMZ3FkNCthWWdKM2d4VXdEa3VQNGk3STdndnlXbXljK3JadU9HVmZZZ3Vo?=
 =?utf-8?B?cTNVclFWWkZnTVRkVEJYUThqd0JVQ3ZycW1vYlpGSkJhM0pQZjVqdk9QUEQw?=
 =?utf-8?B?UndQZ0taOWpxSGZMMXJsTWdscjJRaFBtR2tHWDRhc0thY3N2WVBsWC9UWjFm?=
 =?utf-8?B?YU50VHQ3cEgwR3pWd1Q3ODRKYU13SjJkWVZkT0lacHBkM1NHNFlJSVJGYUpw?=
 =?utf-8?B?cFUrcktiUmxEUEE4RGRPUVNhY1RhODhnSy9ieVBYUUhRWkhEY2ZBbmRKUi9r?=
 =?utf-8?B?VWFUM2h5VEp6KzdGbkozUTJyblJDLzg4VFFoMy95UEx4akQ4NHhoTkhENU1h?=
 =?utf-8?B?Z1lpWEl2cmRqWm1yTW1HcG5jdEp5R2JBc1QxZU03K0lpb0RENnFiNW9UaElw?=
 =?utf-8?B?OXlFRWZhTFNjeHpJbFhwWFpWelFqWXZkVjl4Vmt3VnlzaUpsUWVxWnloL05t?=
 =?utf-8?B?eWpsQlN3R1ZQaVdpcTNoNk5Na1hQQ3VNalY3RW5OL1pPZHNxMS8ycVlkV09V?=
 =?utf-8?B?QkZxVS9yU1F6TUljRlJ2UVZQbWRtOSt2K2pna2FUL2MxRDBOWUQ1YnhoZXhM?=
 =?utf-8?B?ZTZCZzlqbWcrSUt5RXJzUWRzS1Rnc3VnamV2cmJLN25oanFsYVJZT1p3ZnZW?=
 =?utf-8?B?RFpua2FQbmo3YUVzZ0FIZ1FBdFM2NmJaaGJuUlpFTFZSdHFIeG92RVEwQ2tr?=
 =?utf-8?B?Zy9sdndTckhja2FxMUZkY1dLeU52OVBnWm5WZGZWR1hxNTdyVVZRSWF4Rmc3?=
 =?utf-8?B?c1JVRjNISk1vc254SHA0eUI4TnBBNEptdVdONXNGcFV1dDFOQ1VnWkdpR2FF?=
 =?utf-8?B?aTNYOUVTSk1oQnpKOTUrMUJzYVpIUzlheCt1MGtJd1YzaDZrdlUxaEprbG1q?=
 =?utf-8?B?LzdTMXlFZC9QdHlVVXdkMXN0UVl1d29KWjl2enNtbDRqVS9yVTJFZnFoQ2Na?=
 =?utf-8?B?cXMrYlFFbXBoUjN2eWNDeW44MU5lbzVnZTNjUFlJSlcyZHZyejc3Q0JNY3BF?=
 =?utf-8?B?dENoNlZZamJBOTBhcHlaOVZTNDQrUEVaTkw5TVR2OCtncysxYVEzSnVWZVR6?=
 =?utf-8?Q?adQDgbApGeC3Q3BTLXJbyBOna?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1fa9b3-01fc-4168-9ba5-08dcc0684f7c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:22.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/+C04wQwhAf+mLzruQKVhqnAFKq5HFl5CGvkKy1EhBhauxBwLMY07EHPzsKZIdqrj1QE9COpHQRAnVckUWd2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

There is a possibility of an IBI WIN occurring when addressing issues, even
when sending CCC commands. Most of the time, returning -EAGAIN is
acceptable, but the case below becomes highly complex.

When a Hotjoin event occurs:
- i3c_master_do_daa()
  - i3c_master_add_i3c_dev_locked()
    - A dynamic address (e.g., 0x9) is already set during DAA.
    - i3c_master_getpid_locked()
      - Another device issues HJ or IBI here. Returning -EAGAIN causes
        failure in adding the new device. However, the dynamic address(0x9)
        has already been assigned to this device. If another device issues
        HJ, it will get this address 0x9 again, causing two devices on the
        bus to use the same dynamic address 0x9.
      - Attempting to send RSTDAA when the first device fails at
        i3c_master_getpid_locked() could also fail when sending RSTDAA for
        the same reason.

According to the I3C spec, address arbitration only happens at START, never
at REPEAT start. Using repeat start when an IBI WIN occurs simplifies this
case, as i3c_master_getpid_locked() will not return an error when another
device tries to send HJ or IBI.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e80c002991f75..5d19251238ff8 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1099,6 +1099,24 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		if (ret)
 			goto emit_stop;
 
+		/*
+		 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a
+		 * Frame with I3C Target Address.
+		 *
+		 * The I3C Controller normally should start a Frame, the Address may be arbitrated,
+		 * and so the Controller shall monitor to see whether an In-Band Interrupt request,
+		 * a Controller Role Request (i.e., Secondary Controller requests to become the
+		 * Active Controller), or a Hot-Join Request has been made.
+		 *
+		 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, issue
+		 * repeat start. Address arbitrate only happen at START, never happen at REPEAT
+		 * start.
+		 */
+		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+			continue;
+		}
+
 		if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 			/*
 			 * According to I3C Spec 1.1.1, 11-Jun-2021, section: 5.1.2.2.3.
@@ -1132,24 +1150,6 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		}
 	}
 
-	/*
-	 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a Frame
-	 * with I3C Target Address.
-	 *
-	 * The I3C Controller normally should start a Frame, the Address may be arbitrated, and so
-	 * the Controller shall monitor to see whether an In-Band Interrupt request, a Controller
-	 * Role Request (i.e., Secondary Controller requests to become the Active Controller), or
-	 * a Hot-Join Request has been made.
-	 *
-	 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, return failure
-	 * and yield the above events handler.
-	 */
-	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-		ret = -EAGAIN;
-		*actual_len = 0;
-		goto emit_stop;
-	}
-
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else

-- 
2.34.1


