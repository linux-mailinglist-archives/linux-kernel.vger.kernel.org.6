Return-Path: <linux-kernel+bounces-292455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755A8956FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA136B27FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E28171E5A;
	Mon, 19 Aug 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UiwMAunf"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2E184114
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083352; cv=fail; b=mCiwnginHvDyV3LVbimycsVUHW3L8jMtLtNtW/ciIkcdrkwtNak/rcPU8bQ5WcIFn9Xs/+C+4Xb+n7o70Op+J2lHVt2zm4uahObZ9JxnqkN0AI0PRHDeX/g3t1QYwR/kszJHABIAH8hxG1BL363TgYwGifAW2EACxkOD8f81sCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083352; c=relaxed/simple;
	bh=L9feF7xb9MUyRMKZRWW6AUoqHkDTiS9UlH84igh2U64=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AFJfi+AGHtyhyYH6dtuidBwH4lXRrqtI4FK1MpWBnBAvFK3uITjKW1+EWNi5xpg+lhnmHgxyC8kXS7iVGs9xiEAkxgukD5tN4+tAiB3Zv+psinNq/IXkfgFZfmGXI84Z2tVkzlIDEGOrbE9AMk1qOBuy8ApaA9HlKumGmDfl5EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UiwMAunf; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVrr6rVXnlBgso55g6ojoEBnbe+eEY7UlJjllAS8bJjkrii9AruCMp6ourRjXxo7ccFNu+/CScJ9CBqdbXXRswoYCxeEBYf1zPXsTQa2vI7SWFFDGjmUN6ywZXgcBYOLV699FfyWoVXfnpy3tZehkF78dTgPbFlq0YHWdJto3LaNp9q7Gr2IC9sL04Gxiq/Q7ILTOcNnXJ5wQTkIjEgY/c/UnNPrusedlVI/VdXXKG5+YyRfSmWhKU92T6u5fzFAG6fDEfUBwadOE0nah5Y0uwWkEzc21mQl8Pgi+J17gqd0MtvICSXH83KpikBYnBc+WPra+nKcChuUfeXDiAziZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=360E7KWnJTn4U5WkC5jXkR+B4Fj8KMcaMAGe2L9lXhU=;
 b=yDy/dUv9FyJj+6p85G0SsYlFT5cn2B/mFqgAldrwPDxv+KN0KwqFhd+8si3p01hEGzFut8RmLdZvlM3ZvQl5rD9weMA03/1k7JzIOS5cBAUjybw5c37b5OQ9V7sBIlHK8qXnvJt/vhw/qX7qGBRLdyvMfKRzmlFqh6fr0kEVe6Q4KrXK3RaSrrM5NnN4Wedr2fUHvxx9opviNn76TRlfOgzP2UDyH5/KTvJSszOzP6AUoKtEYOJXEtOy6/aphF/20WpZADUf3TdGZdGhdxiJjLB/v7ST+nHZv/AQPDKuEzrIIEKkohXhjSOUcFesjMG7FMaFWUQLU/9WB2qIpJb6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=360E7KWnJTn4U5WkC5jXkR+B4Fj8KMcaMAGe2L9lXhU=;
 b=UiwMAunflKxAOMckuQqfk8BlFUvg9QF9GLDtSOMAuyK4Ld9MIS7vGyglaS3wDBWWtJg2nBVcPLAc8CPxmjr1GVX99/hICxTHl4l/MSPezeKalwalVDDhuSQDJQAwBr27BzcCnIsqBl++mLXeVZmOxUnAKO/BOk2q1uDklMPnSmWF9VLEWefacHOvc6Ex3ieX5xYZKwCjNp8fwhtBvL1xf2Klv3Ptn6tLKRXholWI4t7WdfKxBTa5JpTYV2sDwJUFN+jwnRPX6Xz5ag1HeAUqaO2RUwZGoi5W33Hhjh+74XBHdYIqFnJZDOY/rjYLmgtGbXC3BGdiw7laSppFsBhYAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:02:02 -0400
Subject: [PATCH v3 08/11] i3c: master: svc: need check IBIWON for dynamtica
 address assign
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-8-7d69f7b0a05e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=1408;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=L9feF7xb9MUyRMKZRWW6AUoqHkDTiS9UlH84igh2U64=;
 b=V5wVjA9A5Pw5QgHVhN87C1yDWHaMPIw8UeE69020BkTxQkBUnqy34E22gr8GofUX03Nde90gc
 DetFztsgca3Cwx5KvSaq7jncg6T3DOSP6TvXhNYJL3twPEcgkwl+WVO
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
X-MS-Office365-Filtering-Correlation-Id: 1ca094b9-bff0-42c9-4ff2-08dcc068521b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bFRUMDJqT0VOZXhHdU1yK1UvRm5XQlUyOWlZTE56V3NudUpsNjZpckJGWFhC?=
 =?utf-8?B?dVZuSFFmd1lVL3V5YWJ6YlVGNXIxYW0ra3ROSVU3QlRVK2hqdVRTYmlTNXRH?=
 =?utf-8?B?SndMUVpqMU1hMk9ZRE9wY0k0L052N0xkckdpNzdKR3NxYXNIcmN5eE00YllV?=
 =?utf-8?B?OUdPWldVWnN2NmxRNmFHZ25PazJ5d2pTMERkTUZMdkVCTnJTakg5Wk54Znhm?=
 =?utf-8?B?T0dRTHJ2WWFnZTB1OEtpT0NlUGpYRWNFOEIrTEZBbFFCMGEzamw0Z0pDMUJr?=
 =?utf-8?B?aU1LM3hVNFZBOStMd1ZMdEtrb0RBakU5SlpLYU40bGVZcFh3cHUwbVZuQkJv?=
 =?utf-8?B?cWRFR1Zvdk1INlFxejhiTHRIZUJOQlcwOFBOa1hKQTkxcUpaT1F4Rlhkc2c0?=
 =?utf-8?B?ZzNYbXJndUdxNmc5NXl3MzRrOXdWdklZcllyMDl6Q2M1eEpCL3VHeTcvWEg3?=
 =?utf-8?B?MzVaTXZNR0o4a0VXS09DejZRVnY1clJYWWJOb0phNGRzVDV6WUlYNTdOWlNV?=
 =?utf-8?B?ZDJSMDlkVThPMEtiMThpZTdING1UcHFuQWtGb0R4WG94OXdhd1FZUDVPZ2tj?=
 =?utf-8?B?MnBFUzFHaWM3c043SW5SRVNlTTBqTktkVGtXb0gvdXZkcWkyNXJVZS81eXdW?=
 =?utf-8?B?L2lXRy9zWlZBelg5MkJvVVJxam9DNmladXZGS1lDbHp4U2tUTm1NQTdKL05p?=
 =?utf-8?B?SzJWRzRCM0ZEenRDMUJaSEMrUE8zRHJXaTZPSmh2WGhzbS9OYUpPY3dBcU1l?=
 =?utf-8?B?SjlYazdSaHNLaXduaVhwd1RpSURNNUxncXUyN0xVMmkrTG9ISm8vbDZ3ZktE?=
 =?utf-8?B?eU5GNDJ3aEZGSUJ3UEt4Wkxvc0NCVUJLV21vUC96V1hlRU9taStXY1RoWUlz?=
 =?utf-8?B?dEcxY2R5aElUZnhpNUVuUEVPZ1orUmo4ZGZsbE02eWwwRkNvbFZpR2NIckJP?=
 =?utf-8?B?anZZWVV1cHBrSFpzZy83OXhpVXdueE9HbzhKVEJuYU5aM0liRTdWTUNtdDVN?=
 =?utf-8?B?cEZhaFo0WlFvUnJqc0tSTWZzOFNydEdoVHV6Y2ZpLzZkSm00OVpmNmRIc0h0?=
 =?utf-8?B?OU1MQ2Z3YW1UOWxnc0NWclM5c1dyaDBUcjR1WkhBRWp4Qk9ZeGs3OEJtSklT?=
 =?utf-8?B?M3ZwQXRld1VNc2dlVU5vNVJtMDFlMlF1a0krSTVwYmtuUTJJRDNzM1MxSERw?=
 =?utf-8?B?ZmtzTENJU0xKb2Z2clRLVWNNVFQrWUFsb01wc2Y4U1BKZVJnZFNkWjJ6UFc3?=
 =?utf-8?B?Tm1nZXhtRFUrSU0vTUl1aTdkZFczaWdYejZ0RTFwZFlpeDg1L1VrUWprVDNa?=
 =?utf-8?B?N253dndKRkJwbzZ6Qy95MSs2Rjd5T0pmdG51bUpVWXBGNzJEcE1jV1NzdW5D?=
 =?utf-8?B?bmttR3FFVzNnY3pveGtjcFZha1p4dUhMbXVrdG1memV5K2YzSi9oRWl0YWNp?=
 =?utf-8?B?Sm9ZblFiSlFQOVZlWVI3OFFFa0ZOWFJLbXZXMG12TjVEQ3haa2VNenRxdFpu?=
 =?utf-8?B?REVjQUpTbE5DVDhoSzY4aGVIVzJjblRVeC9VazZUYlBtc0pYVElyMnowejZm?=
 =?utf-8?B?WlVzNGZIdk5HUERVU3UvRUtQQjRvcFBxSDBtak51Z2N0NENUSEx2amxEZFNO?=
 =?utf-8?B?SFZMMDRSek1HMndpek5KaThMNzFXRC9sVHlKRTA5ZHJ0b3R4MDR1aXEydkxh?=
 =?utf-8?B?VWdoSkRJTW5aa2huT005VFVUOWQ1QURSSTd0dGc0ZmxsZVNjSWVoTm90UDVi?=
 =?utf-8?B?a3RYWndYcC8xNFozWDlvNDA2WE9uZ3gvQUVWc1BsclN2dXB1V25hdFRBRXdM?=
 =?utf-8?B?V3M2VEw3QkFQTUs5cVl5UXg0VEEyU3NMZFRYSzU3N3FaVzlQRVRONHFCSk5q?=
 =?utf-8?B?Y2w5clJIOXJUQTlLcHZsbE1aMVU1OWZPK3c1OHlHSnV1NVE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dkJyRS96SkpnelE2M1VRb3B5NG0vM2hobGRsSVNZRmxwTW1lc2U0Rnlacyt6?=
 =?utf-8?B?bmNHSnJZbk1OaU05Uk9mbEQrVnRheS8yV1VYSmpDeWNBY1RhZlRhZEdURWhs?=
 =?utf-8?B?Q3hqbU4rbnF4bVRPb2tSV0ZuQ21PN1Z4ZE5JeEk2Z2I5b1FjaG52UEh5Mm9M?=
 =?utf-8?B?OFNNMzRnVS9EejcxQ2NyY2cvMFh4VzNWREp3SmcraVNXU1RPclZRRm1UaVls?=
 =?utf-8?B?SlU0V0wvK0FBSkhBRmQ3ZkxBWEpQT0JvQVNrc3BIbHJxQ0YvcmxSc0tEamRQ?=
 =?utf-8?B?NDRWTmV1OVBpSkZDcUVlc2JqL0t1SjFPaVozRTczUDgrMHU0QU9vSzc3OHlo?=
 =?utf-8?B?dFZPNUZ5K3ZQZ2tiZWxOQ0dFVVlqVk1aeUY2MFd6VURhTmxnNVpFR2dYM1Fk?=
 =?utf-8?B?NTgrYzRjTnBEYUhzb2ZwUURaa2NpZkl2aE1JLzVQWlY5SjVxdU94bWlrY013?=
 =?utf-8?B?UVVpYmxzY1FkUG5kOVpFNVNNY2dCVjh2ekJPN3B6Nm5VTjQ5SlVLVFQvdVFV?=
 =?utf-8?B?eFdYVURHMDhxaUFXY0pqSlo3V3RFK2FMSjJXYkt0ckQ2WFkzRjVhc042eURP?=
 =?utf-8?B?dlNyb3c2QUllOTZVc1oxNXBPcllXVjR5SWl1Q2l3YVA3cVhBWjFxQ2Q4SkRM?=
 =?utf-8?B?eDR3TTVNTzFXUmU1NTBDUTViVUpkaEF3TU9SNGE4S0F1eDN6M0w5MXRjaWpp?=
 =?utf-8?B?c202b3oyOTE1cjhkdGVKM3AycGpLRmRmSDlab0RVcVhvc0NGWkZXSTYweTND?=
 =?utf-8?B?UVJIVlRST2xxVWlWWEN6d21iSmRaSEFGTEpGSEZLdUV5NDhXUGNkU1ZENDZx?=
 =?utf-8?B?NmowdWRYdkxUZzZCaHZWWVdtNG8yV2lNaXpMYUp0cUFGMUE5aUZqQlVFRXVQ?=
 =?utf-8?B?SDR1WThsaGg1RW15ODAzYmowN0d2R0Y5bnhhcUJDVUpvS1VoUS8xVkdSZ3BX?=
 =?utf-8?B?TTBSaFRPUFVaVTArT1BEME1vZG1qeFpVYmE4SjllbzF3UkY0SUZXZlBiejdi?=
 =?utf-8?B?QWtIY2VRZVd5VkVBcnBDc2VrNk5QMVVjdExCKy9LOC9HNUZzUjdYeGU4VkFI?=
 =?utf-8?B?Y2s3VG9ldUZrU2p0akcxbUZVakFRdWhNWGxmYTZlYkxvZ2pDOERQdWpNK056?=
 =?utf-8?B?TVhIS1p1bjNtalVOTjRldU9yay9VN2Zxc1R1TTNvZTVhYitmbHhkTlJHVURT?=
 =?utf-8?B?eHpnUnF6VDF4ZDRnV2hqb0NiQzhNdWhMSFdvbnoyNS9PMC9pakU3NzRqaEZH?=
 =?utf-8?B?eVBGQm1tRE5zR0Frcmh3Y0ZWMDQyNW8xYjF2b0lQWFNwbUJuMzlpak1xODBT?=
 =?utf-8?B?MzNoU3R5c0FaeU9UbnRYSlJ0ZERtQ21rMjdzci9CY3pwZGtmUXVhL1BNR29z?=
 =?utf-8?B?Q2luNGtJU1dWRkZHMEhXdzlURk5tOXI1aDF0Q0FicVlzM2pZRlp3QzZJOWt2?=
 =?utf-8?B?eUcyek8zNEw3V3ZEVFN0VzU3TnJGK1ZaaVFXZE80ZllyYlhXTHBXZFRNSE45?=
 =?utf-8?B?SnVScXlkM3hyZk9Ec25RR0xsOGluY2c1UHdjdXRXSWhrbGlNTklLVE5ONWdF?=
 =?utf-8?B?RWVDN2RXZW1QUDlYNytPOXF3UzI0NkczSjlzU1ZzM1VRQ1Q3UXNIYVpmUGww?=
 =?utf-8?B?UHJzMHJ4WEVtRnpaa2U4cVZYa2hKcVNpUUxZeklScUFVTzIxK0EybTkxRXBZ?=
 =?utf-8?B?T1o3MC9SRDkyOE1FY3lQcTcrWGFaU0twTFo0YXBlSFBqRWc0M0JjYkxOS3Mz?=
 =?utf-8?B?RnhDS1E1aWJDNlJva0o0RWdpakRCdGwySTFMWGpwQWVGd1pxOEgrR0M0Q1lR?=
 =?utf-8?B?ZDJjR3YrWGZnOEtWbnl2Qkg5WGR1L2Exa29DSmw3SCtwbGNKNyswVXNMTU9a?=
 =?utf-8?B?UjAxVlh3MWw1M0JUVDFhMTZKY1FWWUtFZVFvRVByd1NkeXMwZzNQT1NOQ09t?=
 =?utf-8?B?R2o3NE10NUFFb244NWJBdGdBMkkwWmcrUTY0bGwyckh6YXNmTW83Q1ZZeGZv?=
 =?utf-8?B?OXFUT3VaU0dEMEFCSU5HMzY0eDVkQ1Joc3VUVlJqNmdVZERyeDFueWY0UXFK?=
 =?utf-8?B?a2FSZk5PMjFxWEZpY3FGcEZFZTlLTnJnTVFLTk9WREI0K3JkdUJUeGgrOXpL?=
 =?utf-8?Q?x7RZr3vRx8ox2+1yO9eNN5p87?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca094b9-bff0-42c9-4ff2-08dcc068521b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:26.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRs9wuOD4rpvSLYQS3ylIXALAfddWAQE+oFAwjhOW/hzKlRAyneCiG3/JLlLimvgQuf4w+WrBHBbDjXackMRsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

When sending REQUEST_PROC_DAA, emit START and address 7E. Address
arbitration may occur at this time if other devices trigger HJ, IBI, or
CR events.

When IBIWON happen at REQUEST_PROC_DAA, nack IBI request then use repeat
start to continue current dynamtica address assign.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d665639523e3c..161ccd824443b 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -808,6 +808,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	int ret, i;
 
 	while (true) {
+		/* clean SVC_I3C_MINT_IBIWON w1c bits */
+		writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 		/* SVC_I3C_MCTRL_REQUEST_PROC_DAA have two mode, ENTER DAA or PROCESS DAA.
 		 *
 		 * ENTER DAA:
@@ -859,6 +862,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			ret = svc_i3c_master_readb(master, data, 2);
 			if (ret)
 				break;
+		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			svc_i3c_master_handle_ibi_won(master, reg);
+			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
 			    SVC_I3C_MSTATUS_COMPLETE(reg)) {

-- 
2.34.1


