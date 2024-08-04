Return-Path: <linux-kernel+bounces-273824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B1946E9B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE141C20B94
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431F3F9D5;
	Sun,  4 Aug 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Iec7IqmI"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308CA3A8C0;
	Sun,  4 Aug 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774251; cv=fail; b=PnFHa/TWNFduldF9k+sUay3hdUsuyyOBgbw710HoJx1ZsYYYSdS/PoNw+yXZQuOOqi2kCUiMa9FSVtWc52KP5pPruVZLSNw8DPxqbVc7VeLuIgeQ74UeCHNKBKcwBDCZJLo2LL/XCpfatxdPPchTtsSm7QXrHkMZdld7WLDJL1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774251; c=relaxed/simple;
	bh=5exL70/tt30kfB6mb7RZ8VICYJtENbMxLVAUET0ul1w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pcsRvzME+lVxHXSh0hsguRFihA7fHxD+GZILyw9Yh1VzB0nbC0EHcdiaA03j1ASV6lH30b/obWs7doNTFkXa1aM7IGhSFkF9B2G0xi3a6JhpsjIuESKdrCuqhJdN8711Q5urFVeamVGKJmmSfufglxGBIdoWOQob9MO2wuWglVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Iec7IqmI; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1SfQ5oJdmGAeMAcOYC5fM1ueRE3thsfwNMIIfRqp/frcfQYGgJmEdFQdYWu3yOIqGpl3pdng/VgitKs+wrSn8j5M+BfAj3fkviojyuXVTdQd1vtfhghIFKWoU3pL1w7Pzhuus+AZGNzoPK2tnmexvxDkfSkrGQnJzxwygPy6XGIQQTdG5QHODdKZ0qZdWcx9MkaY4qP9t9fj0P3drPZS8HqrmjyoiULFi6fIvlrLtMMg1lTegGptii+r8XQxz2nE8dc9yS9TPGxLnZjx+RRBbmslkRJTi3Ll256FLCBJ2lX+eWnUOqQYtbHmSK5omaEJ+XF6yYuY9/X6EAx6qCEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzFf2gUbL6hQAqWlaxlv6WSxMOsq3cWITirJyGx/LUM=;
 b=VDbXDfNle3Htuu9ovw+u9sAE8FYQqZXWNAOoUu03Sfadsi4XFo9gy6knCv7Y1ICzUrXQbolJemMxdKgTwYaFaM6K6uwKJZpHvX8ws4FBlBXUXe9ihxJCo9NZ0O4Ufot30Nq+rGnPFhhqsSUhUb/O9zc3JfEje4oA+e+Q8qC9sZt0foGi093gSTVyuGTVt2/naFRFjy7Yuo2v35AJiSp7hSb0NnMW1dRalgQn64IK7cfRvXCHV2/I4MksAORCHOSvZ/HYB/uhs65m64ICjc9MRE2pJNvCvPuxO1//diQvEwJODYGJT2P6bijY1PuGgYvPZ97I0DlhAznVtbLyf92+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzFf2gUbL6hQAqWlaxlv6WSxMOsq3cWITirJyGx/LUM=;
 b=Iec7IqmInshXlvrGwTj6uppXB0rKBvbWP68nI6PpVVQmxUA8yC+q7wdA3ZX4floZvOdCCoVM1gzC657r+9nXnMDMJLnQHaU8qxFwQeF47lOztDD+qx6FBy/Gpg4SwESZYdlIK8VYNd0BeJikEHnreaJTltoUI6oXfG6T0Twm/Hu3EOBdPfDu4kb5USPUOv7WzaM32jZ/rdnaABqDQH473iibw9Piku+OcdyLHklKxGd2zUnMepo7zl0tmCHT6IFl1iaX92pPQWmC55zIloJtyDziTzxzKt3Ns+44K76wAtXrrLQ6r8ENPSRBSTqu0XlIVW6NhBJulWqG76w5P9nU2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7413.eurprd04.prod.outlook.com (2603:10a6:10:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 12:24:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Sun, 4 Aug 2024
 12:24:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 04 Aug 2024 20:32:56 +0800
Subject: [PATCH v4 2/2] clk: clk-conf: support assigned-clock-rates-u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-clk-u64-v4-2-8e55569f39a4@nxp.com>
References: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com>
In-Reply-To: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722774785; l=2430;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7TVlq1qnZb1qUyp9XqfulwMtIztiW668BVycfgkxiRE=;
 b=VV2hfupZcsiddnFcgCrzrancGaCyalRkERTYwf60cn2iUpE205o9ngWwz8hovZe5cmKcnZ0M7
 YT0GVHYKyUXAViZAQsSZRnhCwR0q+7lwu1oU26/FpOpqlh5uLCZJOqI
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c2044b-d512-4128-13ff-08dcb48054fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T01abnU4TDM3NnMyaTErWmMvOHo1TzhOUjVtUU52TlQxSjBJcVM3a1NxSnJs?=
 =?utf-8?B?YnMvMElRRzVpS2IycUdEbVdybFNGaEE4SXZBWG5OcXZPRzU0eWd2ZGJBWmty?=
 =?utf-8?B?cnhDcXlvTlRnMFBpd0NlR2ovZ01UM0EyV3VvQlFMS2E0aGNjWHErb3RvZ3VB?=
 =?utf-8?B?eU9TSy9nOVJuTjcxTmlsNFRZcjhRLzNCYUlWVCtnSTFYdm5rMzJDQXdXVm16?=
 =?utf-8?B?T3BpVkh0TjRuMUx3aVFCMnJ0aWpNVVVHdUh2TFpRMFlRNXEvLzFZM3QrTXBJ?=
 =?utf-8?B?M2xIQStJZStZNnFVT250Ujg2OXErdFk0dUNVWWxrMW5CeEFBTkxMMnk3NXdB?=
 =?utf-8?B?Tm5KYmxraFRhMjVWak55K2g4dElLaEZnMjRYa3VheDh4c1JHbW9PdTkxRDgx?=
 =?utf-8?B?emdRVXNwWTNVSWl3V3FpVDdNSkt5WjhramNUR3Z6NkJrMTZycGxxdzQ5STBn?=
 =?utf-8?B?MGcwcU1YT0FqcGlRblZhWkMveWwrRTYycGZ6VERzT1NYRDUrVW1Tc1JCZDl4?=
 =?utf-8?B?Q0svZ3Y0Q3lheFltcUdwaXhaZS8vTzBRWmRHTTVrTnRGb0RKZGt1Q09DYzZq?=
 =?utf-8?B?YkM4SUtscmNCYndJam1sbE5HaEZNcTF1V0xnTWdRY1FYV2NQd2dZTmxKYlQy?=
 =?utf-8?B?VEhsdE5aYUpXSVB2OFFneS9HaHRxSDBXa1lvVVVtVjZNNHB4RFByazZmTUU2?=
 =?utf-8?B?dkJDSFR5NWlUaEluNjhwUEdjd1dtdVVpbDFNdGtPMHM3UnBZYkZMZ0NUcTRr?=
 =?utf-8?B?UmhKelpoeTV1SVpoWXF6Mm1HZWdZTlIrbklyd1hUdDlyVFBLSkJ3MlNIRThN?=
 =?utf-8?B?SU93bW1JR1NXemZ5NWVEdlZBOUZjSlZZZXNRRjI1NmliZ2gyWFFGQU9Ba0Yv?=
 =?utf-8?B?REdmTllIdHI3OVlHVU1hRXlHa3dLQVFRRXJTVmNmZUVNdEp3cFVrYTZta2xH?=
 =?utf-8?B?Y25GTFdzWkU4TW1Jb2d6T3RJQUYwSi9NeEppdzhVM2Z4V1h3SDg5SVVNMmxa?=
 =?utf-8?B?WmdLY0xRVElIbUxYMDZrNVpOcTJhVjFOSG04cjdVYnpvNnRXNEFMSG5raDZ0?=
 =?utf-8?B?eUt2WWNVZ2oxQk5PMUN5ZDhHN28zcFF3cHViMUR2Qi9yQXlLd2FOclM2d1dk?=
 =?utf-8?B?T3VVY090eDZGeHh4L2RTdkM4NEphQktpNlM1engxYmxBQzNyczMxUWwyRC9h?=
 =?utf-8?B?Y1FxY2ZrMVUxanZ0bnRweHNjTXgrNnJBaGlXbEpXeDZ4a0lhOGh4UjFLSC9n?=
 =?utf-8?B?T1JTS1hqU3dxTWdacHFmdVZFWWQ4MUNIUlo2Sk4ybGxXWHhkNjZpcnZacDFC?=
 =?utf-8?B?NEw0cFVTQnE2YkFGUHRDcVFKU0N5TFQzQ1doUVBVNjJ4REhLN1dBZDY5Wmc4?=
 =?utf-8?B?anN0enBQSEx2bWVlOGZNcG5uTDN1eGVmSVpTbnFBeE1NRk5Qei9UMUJmMjR1?=
 =?utf-8?B?d0xTZWlFNmg4SkFqbWVnRG1ZRzFUZTFBMXpsTzlaWXY2OW0vSENUSVgremMr?=
 =?utf-8?B?ZjViYS9wc1RGYlpja0VVcWZLemlKZWFYOHZyVTNuRjk0akFtakE4WkhUT2NM?=
 =?utf-8?B?WnRrN0UwMGZKZkFvRVU0VUNHcjQramw1bjdFaXU0WWQwOUVIdUswazd1Rkhy?=
 =?utf-8?B?T2tIMnBGRjQxN0FTa3hhMktjSCs1cnBOR1gxTnRzK0JTRkdLQTJCd1FmWDNv?=
 =?utf-8?B?U1RSTzJ6SS9rclBzV1Y5NVUyQ0J2MmdKN1N6d01EWjJwOTNETzhCNWpROTNX?=
 =?utf-8?B?Mkcwd0txMVdzNXdTRFA2N0oxSGZiS29vQzN0MUIybjAwRVRTQkN0Y2R5ZmlP?=
 =?utf-8?B?Q1VXZlBORWMvNTJsWmdqRm5icVJpYWFrS2FWMnZkc0RublNBUUJRcmoyczFZ?=
 =?utf-8?B?YmNkTTNENU9vS3NyUGw0OW5scnhLM1JYSlJzMng2alVVWWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXBicXI4ZHQxeWZQM09nUXNOWi8xejdrT3M0ZHF6QTlXektZNHhMTWZwZlc4?=
 =?utf-8?B?MkVVR2Q1dDdDbW5uM2xnKzdDM2lvcStCcDhIRmNaNm1ZRHZ3SVo1ODNIYk9v?=
 =?utf-8?B?S0VLNW5Jb2xKREFNbXhGbmdhTk1icDB4YW1RYUxmNlhXbm1GS3hvZkRaMnFL?=
 =?utf-8?B?WkZLNzNMTVZxekEwL2VNckt4bUx6VnBnMHZaUGZuL0NTWWpxYkM0SUNWeWRz?=
 =?utf-8?B?RHIrQ0laSERxUHo2UVdJSlZmczhuZ1pxdk9DQ0JCZHF5MkNFdkhuL21EVllI?=
 =?utf-8?B?OUdDTXVnZCtCdHR5aU9zc3htaTd4R3VjWllkOWR3M1I0N0dhRVlXaHhvZHNE?=
 =?utf-8?B?SEwxblB5K2ZRME9CZ2E4MEt6d2xGd1o5OWNLQi9YSjlGYVZWaE5uZlZYOVhL?=
 =?utf-8?B?aE9KR1Q4ek14WThRdUhaNFQvTFlBWlMxdENPRDdHbmk0NWtoRTNHYmJWaHov?=
 =?utf-8?B?d3VONWl5QXN0UVFidmtTTWtTbmc0R2VMdWhwMlFnbHVFWGYxZDBjUThzTlQy?=
 =?utf-8?B?SHNwOWJRS2gzNlV5bGFSZEd6RUc3VHVnNnE2elU0THEzbVJXLzFxRjFXWmlD?=
 =?utf-8?B?UXV0dW9scFU2Uk5yZUY1MUZMSlppUjlFYnVBQ1hySStrOUtjNnZTK0h2a0t0?=
 =?utf-8?B?RVYvZUJQUXc2dFhuMVY0ODFrUURHaXZSVEszWTBCeE5NMTlwYnlQYXRpdVc4?=
 =?utf-8?B?djk1eWhtQlBMcWJKL2gydU9TajZRVzVVQll6YllVTGhpY0tZVk1oanAyODNM?=
 =?utf-8?B?OFh2cklZNjNJQ0JrSG8xVDl3bUxhVG92L3hqTllMbExFdUpkWllwaEdLMTVv?=
 =?utf-8?B?UFpRamQyQmpHSHNrVXFwZ2luR1pidkNRemxsYkROT3luSjhValNWOXNCK2JV?=
 =?utf-8?B?RTZiM0k2aWVkaWF1N3dtZ1JjYVYrbkFHbVVzd3EvRnlHa2xoa2lESi9LK01k?=
 =?utf-8?B?MzNKQkZSUWtXWEhpTHVqeVpZbzYxMkxHNmFDbWUzWlQzZm1FMEZGSGRvTENZ?=
 =?utf-8?B?U1BsMjdIaysyRVVnVGFZK0dvV0tFdDFHR1R1dFpnQ3piamtLMFcvdDdNc1Ir?=
 =?utf-8?B?V2w4ZDBsVWlXOFQrV0tDN1l0RGJZYTlsdFhacFJOMEFZejM2cFpDUTlQSVpJ?=
 =?utf-8?B?b0lvV1NGSzVUUW8wVVVsb01OMDBiR1JXYlhkL1NuZndsSVNQNzRDYjArS1Bn?=
 =?utf-8?B?WmFtZ1BXOStIRVAxZmRCeXRjdlBjb3g1Z3lOOVhYYXpJc0F0dzh3eXBBbXdy?=
 =?utf-8?B?ZHVXQ3ZWZWo0M25JYksyUTB2MkVWSzI0eE9WUDdjWXJLQk9CSEpJYzY3VlY5?=
 =?utf-8?B?SHFjb3Y4VHBtcHhUU09JaFg3U2FPZUlwbmg5TVJkYmdOQ1N3YWpLeTRiOVpT?=
 =?utf-8?B?cVRUWncyeHJOQzQyYytUclJteklTUVRkOEFjWG5EMmdXdEpzYWV3Q0lEWUF4?=
 =?utf-8?B?TzZRelhTeTNlVzVHby92a0FvVEFXYXY1amczZDJVT0VkS2lPUStZemw0SzVI?=
 =?utf-8?B?WEh3blgwLy80RXdDS3k5TVp2K0tDaDJmOWxKTXExK1lwWW5CZGZZL0FjcUhZ?=
 =?utf-8?B?U3hkMyttemdPY1RTOEhBMnkvU1dZMmgyWWdrUExoTnltaHZFN3dwc1krY2s5?=
 =?utf-8?B?NW9PNlAxelE5czhqVXdaaFFqUUxtajhFNzZZb00zK3o1NWx3Z3dWeXBNN3Vj?=
 =?utf-8?B?emZLV0UrRmltRGlhQUdjTkxDZUxmdHNiRGNEc3NSR2JKZCs1WDJ3azA4enQ4?=
 =?utf-8?B?UlRUeU4xa2Vzb29KNXdoZUtzN2pCczM4aXMxdGlNYmMvU1hLaUQzYThjN0RH?=
 =?utf-8?B?MmkxaFFHYlAra3dlVmdjT1Z6RFQzamV3Tm83ZTZNd21PeUJaZzR3UUhJY0Jh?=
 =?utf-8?B?MmtmcVlyOGRGclB5UnZDTVlHZWNBTkU1ek1CNGJ0TTBVVktlQVZSSEtXdVh0?=
 =?utf-8?B?QXVIMlp2Y2ptYTlyL05VMHFDYW1HTGpxSHl2M3BMWUhyOG5qdjRrN0FoWmJz?=
 =?utf-8?B?bTNuTWdzOGc5QlY5NWErZUd3SmVXRDNJUlkyTnJEZzczMm8wd085SU9JaWM0?=
 =?utf-8?B?RkMwaGZlNEtQczZtckFIT0MrUVZDSVdiZklGbjVrUlFCMFZ5TitZemtxUXY2?=
 =?utf-8?Q?wlC4uRmnqDbe4Yh0cH+itOm6d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c2044b-d512-4128-13ff-08dcb48054fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 12:24:05.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j22dPgNLCjrV29CDScZRnBA41IRx2vTpiPRWdAAPu133MYCIV1YJazOZquiszLX8yjO7dkMVMoMEgRj7ODVqeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7413

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Management Control Firmware(SCMI) manages the clock
function, it exposes PLL VCO which could support up to 5GHz rate that
exceeds UINT32_MAX. So add assigned-clock-rates-u64 support
to set rate that exceeds UINT32_MAX.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 058420562020..51f994366d73 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -81,11 +81,44 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 {
 	struct of_phandle_args clkspec;
-	int rc, index = 0;
+	int rc, count, count_64, index;
 	struct clk *clk;
-	u32 rate;
+	u64 *rates_64 __free(kfree) = NULL;
+	u32 *rates __free(kfree) = NULL;
+
+	count = of_property_count_u32_elems(node, "assigned-clock-rates");
+	count_64 = of_property_count_u64_elems(node, "assigned-clock-rates-u64");
+	if (count_64 > 0) {
+		count = count_64;
+		rates_64 = kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
+		if (!rates_64)
+			return -ENOMEM;
+
+		rc = of_property_read_u64_array(node,
+						"assigned-clock-rates-u64",
+						rates_64, count);
+	} else if (count > 0) {
+		rates = kcalloc(count, sizeof(*rates), GFP_KERNEL);
+		if (!rates)
+			return -ENOMEM;
+
+		rc = of_property_read_u32_array(node, "assigned-clock-rates",
+						rates, count);
+	} else {
+		return 0;
+	}
+
+	if (rc)
+		return rc;
+
+	for (index = 0; index < count; index++) {
+		unsigned long rate;
+
+		if (rates_64)
+			rate = rates_64[index];
+		else
+			rate = rates[index];
 
-	of_property_for_each_u32(node, "assigned-clock-rates", rate) {
 		if (rate) {
 			rc = of_parse_phandle_with_args(node, "assigned-clocks",
 					"#clock-cells",	index, &clkspec);
@@ -112,12 +145,11 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 
 			rc = clk_set_rate(clk, rate);
 			if (rc < 0)
-				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n",
+				pr_err("clk: couldn't set %s clk rate to %lu (%d), current rate: %lu\n",
 				       __clk_get_name(clk), rate, rc,
 				       clk_get_rate(clk));
 			clk_put(clk);
 		}
-		index++;
 	}
 	return 0;
 }

-- 
2.37.1


