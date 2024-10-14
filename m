Return-Path: <linux-kernel+bounces-363605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A17999C49C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891CA1F2151E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A61586CF;
	Mon, 14 Oct 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S1KD4wRk"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2510F158548;
	Mon, 14 Oct 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896587; cv=fail; b=gzzHMVQ+XIoCOP54pYsvioalJZ6TBl1Tb30zie58qRGwUUp2Hh7LwSz34AdT+iBCmy42fdJe4IOXwQNk8J/epV44acBUoPEvg3SyC0LZTBvM6niY0p7aqAwCv70XfxtmfbAG8DW5caO58FM6lMACQvQ/4JLqa3hy9SId6n5hE5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896587; c=relaxed/simple;
	bh=NMaixJesrwjgxBT4NT5looPIkUt0ihb+TNQ2+BNtgIw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WKMjIpzGNVJU9yUBwxNL7r1nsgoE0rEvF8eA2BK9KZr9x7O5E/K08OvPQTjRgZoBtW6caQPkJuI1WSjWU2MXc4nW/zekJ1kd6LcYG99B8sAd6PzMDQ/wfRp4cJxTGrEZuj9Az+HoJESC/tsynpVVOQSALhizKpaHiJRcakH4FaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S1KD4wRk; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMrCnwgRSiwplz/dcLLVYrtVzhyX4m66vvCLXIo+CbK4tKUkHjsAgb7QjEDIy/63/0bqfAKzRjtuE8Z73iBAmJLzu/IF9GhCBPopYFFMmUGlKLu1F2aumS40MK69Yq+GFnkG8yxQRHO1wxyYXnN6whmmjDDpUlLCWNwPXuq6Gvq4DBS8uJ9WodfZ7dGwQNQ0KxEKO3ATUhS8ph6FKvZ7zeS/xWkzVy3k3vZp48Ik7SBmgJV0bQzclVZFuqGxvNOAUljWX5njzy2YCYuyan3pwpTMHQJQPfyxZXWziv37VhhhYLesWF7G3HA5XDoINhZIJgvpiBNJrY9p4n/TpuUBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2X07okjtdl9vOjnNmLbOm2lrZztvIEIJlDlOPNZ4ds=;
 b=rlpJ2HLOeS/KFRIKjxm7QtrtuwiCJrkMsWseds+d9aa1GFaEJFFxMk7yoaAwW+G4SK4jCQDVX8h0zFPine4NMRGPID7nsmqFfQ1d68TDFSur4ki3pLsjX6FbIUPX/oih8ab2lBmyJSA5IVML/KnMxzfNR0eIheSQg0YsxPpUgNjguS68StOg9c86Id/9K/++otYOj+pAq9/ZpjymhG7nwXOZaHD6ZzrZyVowZL83Xf6WbvtDHiZsJBRoch9Yy694ow1BseDHuG4jhaNFt12FVXhCNkmoFIqCiw3ib4wfZAfLUbR1HiA2PayHblShPxsuYuCLos4W11L91RsEhvlkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2X07okjtdl9vOjnNmLbOm2lrZztvIEIJlDlOPNZ4ds=;
 b=S1KD4wRkDU6UTXdvnfJrWWbNWneNvOuDZBLmdO5R8jFiNiXaaSmtKi2qpk0hyC/PMWPs/B3mcQqw/zwxJwilrzdx5bTv4v9FtBtfWm0u2BVGAMsC5unNiOlprmVonEWyXYnzWwxhPWg7/HTsPq50NFc1DIylGb7oHodwsYs7UIditm0R0wf7F6Cp31isFE5REAu35t51T4t96JwcElHjL1K4bcueAyev91PCNXx9ANmMPqWcDnbniLpLU+k3xFR08jeXRHG3/57yfNqbfDJpOZ8DWInPTYyPwvfDCVKkwmnlDSQ7Dx7caCSewT+HWYS4rb0WEYv51ev2G2v2YFNsNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM9PR04MB8292.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:03:02 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:03:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 14 Oct 2024 17:11:25 +0800
Subject: [PATCH 4/4] clk: imx: fracn-gppll: fix pll power up
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-imx-clk-v1-v1-4-ee75876d3102@nxp.com>
References: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com>
In-Reply-To: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728897092; l=3465;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=0FRtVJRoldZWhrjsnYMTTv4H4lNFEH+cZfZjwCflnCg=;
 b=8NTWCY5GXXjje1CkaoW6y/mFO1bx+tz2QgAgzl7GsiW3xX6ovzrYy+mMu0oUsXnSMEZ/O29R6
 YrXBlhmXuYKA3h+FU2nsAxCb4vuPpegjyLNUzG6wGlbJXiHAL6msu32
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM9PR04MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 406ee9bb-5e03-440e-920b-08dcec2f01dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlA1TkxqSkpoOWdkYk9NY1VnMERuQXZUR1o2NGlzRDlvMGIydnh1S25zNVhF?=
 =?utf-8?B?UjFoWUEyY2ZLWnk1T0lzZDViTEFZQkZJQ1laRm1LRWRQYzdKYkd5K0ptR3h1?=
 =?utf-8?B?WndDOVlHSFo3VEwzNmR3aS9HU21uS3ViRm9vd0tqd2t1TURWVmpTUHh1eC9S?=
 =?utf-8?B?K0VWMGIva0lQQzhyMWVZaXV4UllyalhxZ2I3dVJQblBhSlRCMld0RVl1S29z?=
 =?utf-8?B?SjQ4d3oyWGNZbGJ2ZjhGa1p2T3V2TE1KZTlWYjk1ckxjWlQrSWFPS1gzdWtj?=
 =?utf-8?B?amNlRHRaSS8rUlVEaXNUSGlCNmtLWWRSWktxQzh5WTljZmc2OUhlVUVKSEZ3?=
 =?utf-8?B?djc0QlYyQ01lM0ZGdnhWNEZIakMzT2R5dFZTYU85dU1uRXJtbXNRaCtEWUtr?=
 =?utf-8?B?cThIbXpKUFBoWUFjak5XR3Jyc1pTc2lVWlhZbFE0ZmhIMGE1Q2VOR3BWUUU5?=
 =?utf-8?B?Umw5U0RpY2ZpOGJSWXd2aXFJS3hUdEFzam1OS3RwYVZJemxCaENmdFEvQXph?=
 =?utf-8?B?blpyci84UE9ZcXNUVTVNRGc5WnlvQnkwUnFHQ2d3ZU5Tb1lkOURoYU9OTUJq?=
 =?utf-8?B?Y2lZZUpuSHBkTDNLcjNLaWwxbmYyWmtzZTBRSGx1eGlmaGNCc1BZZlg2WVRq?=
 =?utf-8?B?M0o1d2dNSC9qZkVoTWRVTkRUQVlqUVk3b2RiajdnVlV2dnorUWxaVjBZa0Zh?=
 =?utf-8?B?VlpJMHl0NjdFOXNqcEVzL0xweWdBRS96N3R2eVVrcUhSRlh4MHQ3V0Z2R2Va?=
 =?utf-8?B?eFNrYXhVRXJ3Q1d3WnVRTGl4blRLL1JoM2o3SmhGM0ZkSTJWNGdacTZwekRD?=
 =?utf-8?B?d2Q1cG16MklrdS9SOUNzK01aTmJCajZ1WGRPT1lIWUNwQUp2eUdtUjdmem8w?=
 =?utf-8?B?dmx3NTVGb0dacUMwc3kxR0p4U1FOa2JPYWkrbk8xT0VJaTlzOGxFeUFPZStz?=
 =?utf-8?B?cWlsOXNHUklOaU1jZFpOYzhYVllEVDVmM0hkRVY2Tzh4VkpCeVIwZlg4dWt2?=
 =?utf-8?B?ZU1mTE5UVUFpaGRpSjhBbDY1MU95ekYzWG1SOUIrOVE0bDllYStpR1NrNFVB?=
 =?utf-8?B?Z3Q2ZlN0Wi9TZTNOS3RmdFF6QXVuSDFiUVRBeFZJOGg3NXA5cVBHZGJhUXRi?=
 =?utf-8?B?bFdPOUxodnRxcGxsOThlRVBBRXZrTnh2Tkl5VmZ5RERtcSt3b3ptaVJnd2xN?=
 =?utf-8?B?cUxyU2hCTllXMFNvZGJuZGZjazgzMHExQm9EcUFXY1l3SXhxbkZ6aUlJVURU?=
 =?utf-8?B?VitxUFhRSzF0aE5xSUJVL2pUOGFqT2xSSHNXOFhoRmlVYW9Qd1R0NGhFbzZi?=
 =?utf-8?B?dDlyY2Y0QTk5dHp1MlplUUNjMFZSZTlZQ2dLdDU1eW5ZUVdHblVnRWQ1djg4?=
 =?utf-8?B?YWZWOXJxN1Zsa2xueGlrSzdxdWVzc3F2TVBNOExvZWJhYlV5aG9CZFNqMWd5?=
 =?utf-8?B?Q283eEJMYkxZL1RCK3ZUaTdnNjQ5SUcvOWY5cjI5ZXpBOWZUWkNIOGRtK2JI?=
 =?utf-8?B?ZUxLdVd3UnZzUG1JU2RqQXNIZmxGcG9sTUsvK3pyWmZFbFh0UjZQbVlmYlY4?=
 =?utf-8?B?MWJZcVBCZ2R2RFA5R3ExUFMzU2htOSs3SG9sOEw5NXdvN3VpSWU5MHg1VHpl?=
 =?utf-8?B?SHlacGJRNzQyQk1OL1dOVENUMkI4S3dzKzRSaTJUaTFMaFNha2JjRGhxckx3?=
 =?utf-8?B?V1lMUnBRa0EvNUJ5andFekVtbTdaWlZVL2thS2hPWnprZEtoZXdSR05FSCt4?=
 =?utf-8?B?NHdoeXZVelJqL2taVzBrQUFxVkNHVVdBMk5qc0cwYzBIUldEVVVtMDBnMUVT?=
 =?utf-8?B?eWIwMXpKL3IzVU5ISFRXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUZFUDhiRmJzTmd4SmJHZlVXNUMvS1d2UjZyT1FMRlYwdEhHdThTVmFIOS92?=
 =?utf-8?B?dlhNNE02VTRjbnVRZ0ZRSVlTQjFIZlFCVUcrS0JCL3FrNEJ0ckRWM01ONTNx?=
 =?utf-8?B?Y29IOU12dEEySHRzaEV2VjNNTHBNWSs0RXlKM09qSk5qWFV5N2l3dEhtYVpY?=
 =?utf-8?B?dFFWaVI3bGFER0JQSm1HNHJBRUVjUTZ3SHdzZHBtQ2tJZWxkSy81aEZ4QUtU?=
 =?utf-8?B?bUNsaHBUQndtWGYwTXMrTGRTWkcvVTlJUGY0YnQyVGtiS2xvQVFEcmE0R21k?=
 =?utf-8?B?UHAzQ0VIODhDcXd6Q0dUWFZNR2lDNW8yS2h4bGdXY3BWOFdsbEJac2FpVGNG?=
 =?utf-8?B?ODhGcEVsT092bUtHN3dKSy9RUU1sY2kxMDZnNFNGa3IwbnczemJISCsxdW56?=
 =?utf-8?B?Y3ZsZnQySmhDV25iY01YeE9va1c1V2JPUkh4ZDRFOHJMS0w0djhHWTBJWU56?=
 =?utf-8?B?RWNqNEVEQVpKQU5hWGhpMVM2R3k3NzlhbTZVek1ESkdNR2N3M1p2SlROVzJw?=
 =?utf-8?B?R2d1WWs5L3ZxLzVKOG9lOWdmbHNoem9pd3puckY2YlZiemZrUUQ0anY0dmo1?=
 =?utf-8?B?V3V5azJZeUY4dk5VQ1h2ZHlKZ2ZkUUpFT2xnelQ1Y0NWYnNybktpRmpvU3hN?=
 =?utf-8?B?UlhXRUdtWk5DSDJ3RUZESzFtRDUvNjN5alNuOWg2OUJnZTQ0TlRhdHdCREJP?=
 =?utf-8?B?NHMyQ3d2Qm9LMThoVzRmaGswSFgrMUJqZ1pLbmgrQmx5NlphVVJ3bTY2QTNE?=
 =?utf-8?B?R2tLSmJPK0pSbWJZY3dFeC9wQTdOYXY5U292cXFwcGdORmEvdkRGNHRhVjZP?=
 =?utf-8?B?d3lsWG9GQ2QxRkFmVGk3bkhTMHo2N09URW1hM2NEVVBqWVBpVFRTK2MwS2dK?=
 =?utf-8?B?K2hZMzNFTFlvaHJqTGs0d040eFNaRno0bXh2YzAyQTBXL01sWWNoSW9xNnVI?=
 =?utf-8?B?cTEwdEdKcXdkWlZsZDk4MUpwWVl3QkZiVDFuTE8rT2FSSTRNb09oZXlSQXVG?=
 =?utf-8?B?cFh3S0EzWjNpVDNiWUt6WHJGRUoxYnhOaHdDeTlMUytaL2NIV1VrcHBNY05G?=
 =?utf-8?B?ZWtlTXFMM0JYdXlwYXFKeWx4OHI2cy9MN01XZlltRXlFWTJKaHVZZW1TU2hX?=
 =?utf-8?B?ZXVDSWRQU2ZWODFiY2ZxTDFGUWphUitZdU9MOWVQUm4yc2ZVNE8rRWNrWmlJ?=
 =?utf-8?B?NllkTjZVcHQ3L01xYzJkMmpCZ1l4QUV3bFNDeGJVUXh5Ylpsc2VOUWhNM3F6?=
 =?utf-8?B?Y3plcTYzT3VGa3FTdWp2YWtrbE5kVlk3OXJrUXQzd1lwYmtCOUpBTDIxZGhQ?=
 =?utf-8?B?ZWJBdWwxbk9uRjJEVElHOVNOek4vemxUeUFWQ1JNVUE5VlgvQ3Z3YWgxOWxY?=
 =?utf-8?B?Yjd2aGJsaVhDaFg3Y09KRFh4R29ZL1hzRHgxa3NjNEZDZ3RhTm93dWRkam15?=
 =?utf-8?B?UkNSVXEyNW4yYlZwNmppcGFoQTM4cTg3SFBTTWtXeTNzWmhuaXB4ZTRCREFC?=
 =?utf-8?B?T0hTSVEzdTFNNnNhY1N2aGdKRlB6VWc5ZjRoNWd1cEh6ZVhjN3FFbUV1WGZ0?=
 =?utf-8?B?L2g5T090M2ozZlJ6NWo3dnd1N2Q1ejMyamI1T3d4UjdjMFgrVGdTWXBQenkr?=
 =?utf-8?B?OVBKQVIwUEQ0aU1TbkZ5MHM0NCtTMTh1OVBMTW1oYklKSFVJYXZsWHdnblBV?=
 =?utf-8?B?Z3BQRERzOW9neWFoZGtOZS9KOW1RUEhpamRxVkpKM0VUZC9YNDVSNm9tRnRX?=
 =?utf-8?B?dUpPbnp3cE5xdk4yOTBQNFV5TTRndXE3aDZxVEhYclFMN09HSDVDZjY1V0tO?=
 =?utf-8?B?Z08rK0c3QmNEUmJJbWFoV3JadkZWUTNBMlRpU3A3a0lyS0JDeDJqY01SazNq?=
 =?utf-8?B?VTgrckY5ajRMZFZuSjh1azhjZU5aWlNQQ0ZvbjR1cnhoTjIzWUZrZ2o5WEZO?=
 =?utf-8?B?RlNtOFA1MXUzNEF6WFAvYUJDbUJOM1FwTnk3UFhnMVhlMFVMeHY2czZRN2pz?=
 =?utf-8?B?SFJRczRic1NSd2ZOZzloTy9xQktWUURwSU81bDVFb3QxZ00xQ0pGcnllZ0tm?=
 =?utf-8?B?bk03amJOMjN4UEFSTnBzTmhzck1CY2k0MU5FWmduY2JiWHdqSzBCUDBWaExR?=
 =?utf-8?Q?al6dUtOGgrua6CAusqshx85gQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406ee9bb-5e03-440e-920b-08dcec2f01dc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:03:01.9321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei540PbxXxQN/EWN6gjYUk/jjqlVrkCOc0OgriF+Xo3+dSvh/sUlKUsJbY4yfqlZRtqs1ptY6a+n0wn8wNxiYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8292

From: Peng Fan <peng.fan@nxp.com>

To i.MX93 which features dual Cortex-A55 cores and DSU, when using
writel_relaxed to write value to PLL registers, the value might be
buffered. To make sure the value has been written into the hardware,
using readl to read back the register could make sure the value
written into hardware.

current PLL power up flow can be simplified as below:
  1. writel_relaxed to set the PLL POWERUP bit;
  2. readl_poll_timeout to check the PLL lock bit:
     a). timeout = ktime_add_us(ktime_get(), timeout_us);
     b). readl the pll the lock reg;
     c). check if the pll lock bit ready
     d). check if timeout

But in some corner cases, both the write in step 1 and read in
step 2 will be blocked by other bus transaction in the SoC for a
long time, saying the value into real hardware is just before step b).
That means the timeout counting has begins for quite sometime since
step a), but value still not written into real hardware until bus
released just at a point before step b).

Then there maybe chances that the pll lock bit is not ready
when readl done but the timeout happens. readl_poll_timeout will
err return due to timeout. To avoid such unexpected failure,
read back the reg to make sure the write has been done in HW
reg.

Introduce fence_write for this purpose.

Since we are here, to avoid udelay to run before writel_relaxed, use
fence_write before udelay.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Co-developed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 4749c3e0b7051cf53876664808aa28742f6861f7..6a4b3745d3d9aa1b583c9bd390c884bcb689e4c7 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -63,6 +63,12 @@
 		.odiv	=	(_odiv),			\
 	}
 
+#define fence_write(val, reg)			\
+	do {					\
+		writel_relaxed(val, reg);	\
+		readl(reg);			\
+	} while (0)
+
 struct clk_fracn_gppll {
 	struct clk_hw			hw;
 	void __iomem			*base;
@@ -253,10 +259,10 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
 		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
-	writel_relaxed(pll_div, pll->base + PLL_DIV);
+	fence_write(pll_div, pll->base + PLL_DIV);
 	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
 		writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
-		writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
+		fence_write(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
 	}
 
 	/* Wait for 5us according to fracn mode pll doc */
@@ -264,7 +270,7 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	/* Enable Powerup */
 	tmp |= POWERUP_MASK;
-	writel_relaxed(tmp, pll->base + PLL_CTRL);
+	fence_write(tmp, pll->base + PLL_CTRL);
 
 	/* Wait Lock */
 	ret = clk_fracn_gppll_wait_lock(pll);
@@ -301,7 +307,7 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	writel_relaxed(val, pll->base + PLL_CTRL);
 
 	val |= POWERUP_MASK;
-	writel_relaxed(val, pll->base + PLL_CTRL);
+	fence_write(val, pll->base + PLL_CTRL);
 
 	ret = clk_fracn_gppll_wait_lock(pll);
 	if (ret)

-- 
2.37.1


