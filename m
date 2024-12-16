Return-Path: <linux-kernel+bounces-448048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A84B9F3A63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741C816A7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC43B1CCEDB;
	Mon, 16 Dec 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IKqikK4Y"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF0339A8;
	Mon, 16 Dec 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379399; cv=fail; b=ofzTU53BT5cVR8pKS3z8luRANyWBEwOkuy/kcbY3zXPyWo+jfkm5qVtIM+2w1BmPgYW2lGov6NuMz2jr+ZGLCp94iLm0YXGuMqT+Z6kU0OWQXx9vsca6w1aOWKm8jXE9JNDonb4sUFHsCxVhUoJG0iYuTOYZZkjqIIBZ00+5jTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379399; c=relaxed/simple;
	bh=M47Ti3GEs9j4rCdS7/tN6uBaPqyOYk1f/2DW/gTSyC4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WzmYjw0H6RnaCPgQlBeerH2CUKUuAmg/itvjLE4zt4dBxamXcA8ISI92az+5s6vZcOhh1dWaD74w4Mjw213Ha3Ps+93ACFeNHAoMliRLP/gkheLfdbvELepLom6BZ8VYLYUAJIdK1Vt3OX3Qtfu35p3xLr5yDNza5I1xWSB9vfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IKqikK4Y; arc=fail smtp.client-ip=40.107.104.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV9OvO0j+PIO7ltYuotxcnVnMJTEfKD6Oxk+8HQpEObcR0xEpD27jiWLI6TjJbtv278mc0XxeyegHFf7LAdLgnWzemGzecEFygrYx9AGgCeftAm4zw+AraDYyG8E+rbP6gGVD0xvEZPLq0qSoQdKjhM5KDOwk3MOOYb3eqCwt0xRSK7+ZI1f3d/1o2h2GbfFIbO2d5igxpv6TZf2ZsckKuJaa1l+KFKqJWFhMyWCOgVssIXgxnDjj3r3xmHXDTtG6bJj6pi5ninsbt74PEexQJlX+3EwJAGdjfkm06gaW5l3JM6gHbBR91ENr6xwDH0Y2VCkGEgeikSWYdyMx37xXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFS+fA5n8gs7/sPtMxPvMZqneXHKq+CKPOjpYXNmKcU=;
 b=oFHZcQiJJiqvDrnqpvBwUajO+Hvpmpy3R8m7ohra2D8nYk/NDSOuZs0LsPK2l4IQAnl6rK9FoFr1zhoui1IVN5iqxJBow0+2T+pIQPfIqRmD+xVlycjP1h5GOAIlvGoZyEBIqW/kuRRjyMVCQLLeXkv6v2KQqTk3oldBPDwJPZsR3M3Ip3L4En5L8svrEcacS7d0HrqMbPCK3a3suSAkGvJouLx/1zYPAiEJUxQsqbnYAeBKwj2YcAvoQ8zTWDo3L6FnIqZX6MMbwY3dc5e9Ny9MHM9fAEvlXyGCg626h4OnskZNUXN83vQ+JMh1fjWiO/MHu8H3oZyDNNiTgNH18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFS+fA5n8gs7/sPtMxPvMZqneXHKq+CKPOjpYXNmKcU=;
 b=IKqikK4YHzNGq9/CZJfxBTVSQrgjdzzFf5AduNipP8mvpTn3DgUAs1oUsOTPsUclUwaRObF86ffohQk2hJqSq9lTaXOVygjcJg4hqBHX69zvlzOigD/sCdBHEhxt6p5CQ6/fdVz0mL6G/F6Q8bMbuxv/wy5AsMMF/wGTIpaBETtDZ24R8eAEGAuy7yM118wYyrosAxvMLUoey3cDVnQKvo+RicNB4GPouFM84BgoRlzEoaB0qnDHfrorgi+lpu4VV69H80eg5vUljKRAKfX4wONn2/myHTU7UsFEvc+8FnC/5Niq0TgLAxdyIPtzVe8eE//WNfvDHMMhALivxUrS6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7501.eurprd04.prod.outlook.com (2603:10a6:102:ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 20:03:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 20:03:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/2] regulator: add new PMIC PF9453 support
Date: Mon, 16 Dec 2024 15:03:04 -0500
Message-Id: <20241216-pf9453-v4-0-a9fc8f0a0098@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiHYGcC/1XMQQ6CMBCF4auQrq3pTDuFuvIexgXSIl0IpJgGQ
 7i7hQTE5ZvM909scMG7gV2yiQUX/eC7Ng11yljVlO3TcW/TZihQAQrifW0USW6EK+zDlqSxZOm
 5D6724xq63dNu/PDuwmftRliuW0JviQhccHBKFwSgMIdrO/bnqnuxJRDxgAB3hAnVZCxWwmhJ+
 h/JI5I7kgkRFXkF2kgg+qF5nr9Htp/SBAEAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734379392; l=1470;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=M47Ti3GEs9j4rCdS7/tN6uBaPqyOYk1f/2DW/gTSyC4=;
 b=DcNEVJnjHUuhz3j6rWg3lkOlOKy7QvJKeFzkaWc7nZ3lyhU2tlULwiOvlPPiz78ijlc2cO/cK
 j2f+mP4IGIEB5xY7l+ri8kOrwJjZzUeaqK3GCA9Y0+Ze/ajrfpJnefZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e16ebf9-b101-4e11-75de-08dd1e0cad38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEtXMU9hRktrRThSbDRHOU9BK0ZrUHRTZG1ucTdpdWRQTnhTZmR2RXNsbXBL?=
 =?utf-8?B?SElLVWFaSzZDSllMalJBT05nUkphUGZPMVcrdFlRTXJCckc3aG1GcGtrMjlY?=
 =?utf-8?B?L21rMldKUGx2K2JHaUV0eXJoY0Z4TGJMc21KbXpPaTBMTFZ3WHJYR0NGV0oz?=
 =?utf-8?B?bitQL0xFNTRTcDBwanBXN2xRTXhHT0tFaElQMkhDaWFrcjR0VzQzYWxtVVJW?=
 =?utf-8?B?VC9uajFESUxKbHpBbGtPWXVqVEhaM0MyMmpjKzFGcnY5ZTRxcDY4WXJGTm52?=
 =?utf-8?B?Wm9hOGp4S05ERmlsYTNyVEo0bDFBM2NHWXZUL3pIdzVpdllmT3dCOUFlOVQw?=
 =?utf-8?B?NDhscmJBeUc3YkJUa2RIR1B0V3RHV0o5NmpJS3NuWDJFUitlaEpSd3hxMS94?=
 =?utf-8?B?bUc1UEw4a0syMDZyelFBZG9MaFFPTFlrVU1RZndjaUNVTkJrRG85anRCdUVa?=
 =?utf-8?B?dzE4OU8wMDhoaUw4cmU2RURLb3AvbEhrQ3psUnhodVF2TmJUWG1NRUE4MHNl?=
 =?utf-8?B?ODdhdjNGeUgvSmpoQmRqNUlrdGwxeURRV2o1S2cxbWNUQ0ViaWtmTkZNZFIr?=
 =?utf-8?B?R21iYkdYa1ZaemZlVjRQVFFPQTdrV1B0ZWZ1TFllS0tkUlNUdUoyNlVrbS9t?=
 =?utf-8?B?K0hxUFU3ZlRRRFZPc2l5Rmx4YnRvVHZhanhJUm5VU00vWmVvRDJMM011aEJQ?=
 =?utf-8?B?NEJnNmZiUW90SSszVWtlVmdCKzNMMVFnVWFGRy9QNWJCNXZKRTJPMFRWcDZ4?=
 =?utf-8?B?WC9PK0s2THVxRkdPdkJNekdHRDRCRDEvYzlTd3k1SW5qalZwZkFUNmtzTHhY?=
 =?utf-8?B?Uk5xUHlCa2R4ZW5qMTVCVDl5cEg5ZG4xTnNFN0VnMGUvUFRLdTlBTmo1c1pT?=
 =?utf-8?B?R250VEUwdHBrM1hWRGV5c3FaZW53UFVYcEh5MW9aNVJpYyszTGp4ZkdLYVZ3?=
 =?utf-8?B?TG1rZXphbGp1Q3MyZ3hMZk1ZK0pzRGVGeHNza0N0eDBOdTlsWjg4Y0dFbmtT?=
 =?utf-8?B?QkY2MzdRbWJmdlh6VG1UbW51Q0VVUG11TllrbUh2NGZMK0FFVlQ0OXFEY1lC?=
 =?utf-8?B?MmN0RzUva0ZXdjlFMzRRYXRGdzJEbGZOc2ErT2FLSU0wa2tGN2dmYXRVL2dY?=
 =?utf-8?B?T3hsdUQ5bFlJSEF5TGpJb01PWEdDbWtZbXdGaUJ0aDNhalY0RjdPUUtTTjky?=
 =?utf-8?B?SlRnUUIvU1FOVmRxb3l1bE1nRURQTnpVeGNzY3JVRS81MGFjNFkyWlhDci9t?=
 =?utf-8?B?akZ5ZXJuRDdFWXhQWlo0eHFSeGNQcHlnNEF6VGdUUEt1QklDVDk2ZUsvalBI?=
 =?utf-8?B?cWEyWHFTMzZEWm5oa01LNWdkWUcyUzQ0YXIyRVpoRlRUdUFRdXdac1hjZGFy?=
 =?utf-8?B?bzg1d2VZMHdZZUVNVndtNE5TM2hzVEpyQWhMSHJHT3RyOWllUXRUait4aU91?=
 =?utf-8?B?c21vY09xeDZDUEZKVXBmc3d4cVE0NmlBNEZhY1d5OHQvc21GbHFJSkdLbnB5?=
 =?utf-8?B?WXptQ09kTUMzbVZkY1VHbnRLemVEVDc1cHNkY3FsQ1ZuR3ZVaEwvell6RGRB?=
 =?utf-8?B?YXNOWnpVOUozaStteGNlLzhiV0hGSVdtaU9LYU1wOWFRQVV5SllXZ2d0aHpG?=
 =?utf-8?B?eFV6R1F4K1pEN2JncGZBK0t4ZzRpaitXU1BmZ08yT1BBenhTM1dSN2NBV3dv?=
 =?utf-8?B?UEIzLzZRL1pRbi9WQVhaejkxZlJ3SDI1OVRTb1VYZmwrOFAxL0pyc1YwdmdU?=
 =?utf-8?B?K2VQbkNNZ3l3blc0TlNWVjJHRUQ3dTBOT2kveitsMEFCVzl6cGZpOWNYUm9R?=
 =?utf-8?B?K1pORURONm83amxXU0tZYWlPeFEzQ0VsN0RYREdEYlpzblZYV1pOOXVLU211?=
 =?utf-8?B?VnhUa0t2TXpHcTNrR3dCNEdaVHFNcTltOFlEQlhyeHVyU1NmamM3TDhMZmtC?=
 =?utf-8?B?WGRWb0dDYy95S2pOSU52RnNXcXdqOFhjMnFJNHQwZlQxN0Q4d2w1eHZYWms1?=
 =?utf-8?B?OTFZZm5PbDNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEpOOEd3a3RTL3FDaHBLWXMvaUJHSlFFdnZJem04Z3FiSDkyZS8za2krVStM?=
 =?utf-8?B?TmsrRE1wNXdvK1BvdnlYNXM2Q0MrOGx3STJqM2s2SzhWekp2T2pEQjdhQU5T?=
 =?utf-8?B?b09NZ3FhdHV1dkhPUVplYk0xUC9BUkMxSEJvZHlvRUs1VU50NFlFM1JyY2tD?=
 =?utf-8?B?cHBKY1Q1dWtNdEs2WjFwZlRGN0dWczExMFZKY0FOemdPWGVsYUtTRVFjTXFI?=
 =?utf-8?B?eFc5L043MkRpRDlvUk1hZHZqWkNJc1FjakxLVFYzNjl2dDNCdTBIUVFqdEVM?=
 =?utf-8?B?WGV0OUJjWFRvcDNoUkFieXhBVlFjc0FOaUNsYmVyUzArRWdsOWp2aklzdFdP?=
 =?utf-8?B?WDBJQ0dGTndSaGl5clZDNDRhZkNlMmJBSXJIYTg1Zjl4SG1HNkVVOHdPMFp5?=
 =?utf-8?B?Z3ZKRjJva2VhRjdnUFJpVTRrQjBpMG5BUUtxZzEwaGZJZ0VYcmR5WDV0L0lG?=
 =?utf-8?B?MXFuT0xWQjZMOGVSOER0b3NHcUJaUDR6ZnFVOWRyd0pNUExxYll0eDFDK0NX?=
 =?utf-8?B?cVlvTU1UOWdwby84a2s2UlNjWDVJOE1HMWxwanhVY1ZTT1Jnb1JpM2xscURr?=
 =?utf-8?B?SEdOTWErTDZxenpZeGt2dnhPNUpJRGdIK0E3Wm5WZ1p6YUk2ckhkMmQwQ21i?=
 =?utf-8?B?WENNakg3R2xJWkdlUk9SMjNRL2VFcmdrV3ppYTFFVkJ1ZXIwSGM2cDA2N2ho?=
 =?utf-8?B?UGVYcEtjNHNjUE4rUUI4SGtQNU0vc3M4Qjh0a1ZFRUlqbnJ0U3dZWVVyb3dE?=
 =?utf-8?B?elNmbzFzR1d0ekNqenZicHNHbHc1K0tVM2t0QjdSTGhxWFRYVmVzZEN1bVov?=
 =?utf-8?B?WTQ1UHBkWVNrYWFYVlNvL0NibUVDbTJTVFdVSjlUOTZRNlRMZHk2ZGlCZ3Fh?=
 =?utf-8?B?QmNyUElKVXR1N3Y0REFXSHhrUjkzZURXc29IUnA5MVV4MlZjK0pUTUF6RG9q?=
 =?utf-8?B?UHNON1ExQ2w0RG9qdzNXRVF5ckFzbXJwMzZZQ2tHZFJEUGlqcGR0Y1l1Qzg2?=
 =?utf-8?B?TE95blV4REp0cEI2cnBxZkRJUDhRL1RacHNXMDBkN1dUaWphaUN3d3NoYUQw?=
 =?utf-8?B?R2k3MDVBaloycVN3bHpsNDBOOWpZbUFrWTI2ZEJ6Z2tXQXYvSDNIeXVqM1Y4?=
 =?utf-8?B?ajE0dlE4ZUNTeEVwNWtuR3BRVzdNWlZOSnExWkM4c0h0bVZ5V092Y0poZHRv?=
 =?utf-8?B?Z2NZNllETlJSWnA2UEp4dXAvbnhqYzJVL2NDVjNiWnR4dEdadHBIM2FnaVNm?=
 =?utf-8?B?RmJDMmN3OGtBVWp0aDhwaW9tOVZIdERZNEVWWHVNQ0ZGdGVISlcrWDZSdGpG?=
 =?utf-8?B?YWx5RTRGTy9rL3N4RmdBSS9Oc0NkY1hkU0ltUEx1cHVLdmY0d1J1Ny93aURj?=
 =?utf-8?B?RDdJUHlKTkJWeVVRcEplNVFpcWsrREFZR0lMdFYxbW1zRVovays3ZHFadUxj?=
 =?utf-8?B?ZzdGbHMrTFM1dW8vU2FXaHN1VDF4eENuVjRnaVJZVC9YdGluZHRLeUJGSzhJ?=
 =?utf-8?B?S2pSd211VkQzY3MrQXVqbHV2SHcvbll4ci9WbEhwSElESklPYnlaVFBrV3Nw?=
 =?utf-8?B?WkdoTElDcXFRUlZGZnUwVlQ1WEZxaG9kVWtLVU1scWc5Q2FZMytXTHNOUEx5?=
 =?utf-8?B?dTN5SUViZGFhVVFBTFRTSUxEK2FMRk5JRWY1RVRQZ3BjZHkzYk93SFc3eWsz?=
 =?utf-8?B?disyNy93RStJSWRERWNTYjhYNkVTeW83RlNjY2ZCb2dJaGJoaTN5enFTekpM?=
 =?utf-8?B?TVNxSWZLbStxNWYxamQrcWd6NkR4NGFXR0d5aHFxczJrOVhyem5wVXBOc3FP?=
 =?utf-8?B?bW5tSkNxMXdPVCtqTmRJYlhNc3FYaUl3SStSbWZ1bjczakh1cndLRGJrbUVv?=
 =?utf-8?B?TnlHenVzMkFGb2lWcGIzSkh2Lzk5c1VtVHF3UHRHTHc3bmFyN21pVzhwM3gz?=
 =?utf-8?B?NlpEQU5EaW5HWkpYaDh6ZmlWSlJ2TWFUbUZSR3U1QXl4b0d1NWV0bXFzM05a?=
 =?utf-8?B?THU4SFhyVUM5ODIvek5YOE55dDRET25zN2xFTWZPTVFlVVh3eG5UVTcvMi9Z?=
 =?utf-8?B?aGxVdnVHUVVteWZtWUlIVFhwSU85OVBrWEJ5a0piR0ZWU0xKRzllRUl2RVdO?=
 =?utf-8?Q?F9bP019/GEcJVlq0ADFHYS6sX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e16ebf9-b101-4e11-75de-08dd1e0cad38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 20:03:15.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szvK5l3YUMk4qiqvANdjV4Qufr/Hh1/Icz43MLcaY6KUhNPoAoKVLF8C5vfleU3bxkGeUuQLAvaQ5v65WLhqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7501

Add binding doc and driver.

DTS part wait for
https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Add Krzy's review tag
- fix GENMASK(7,4) problem
- Link to v3: https://lore.kernel.org/r/20241213-pf9453-v3-0-5587c1693155@nxp.com

Changes in v3:

binding part
- Change to LDO-SNVS from LDO_SNVS

driver part
- remove pf9453.h
- remove double space
- use low case hex value
- remove , after terminate
- use GEMASK
- change to LDO-SNVS
- Link to v2: https://lore.kernel.org/r/20241212-pf9453-v2-0-f59d2c096356@nxp.com

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
 drivers/regulator/pf9453-regulator.c               | 879 +++++++++++++++++++++
 4 files changed, 910 insertions(+), 1 deletion(-)
---
base-commit: 0768222687cbdbe7c300c4428f0c0c6b153386e3
change-id: 20241205-pf9453-90e8dbda562a

Best regards,
---
Frank Li <Frank.Li@nxp.com>


