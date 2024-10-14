Return-Path: <linux-kernel+bounces-363600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308599C49E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CD2B29958
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400BC1514F8;
	Mon, 14 Oct 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kB4BmWMN"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778271BC58;
	Mon, 14 Oct 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896570; cv=fail; b=KfRbh2YjSBhenWUmKKY0hSpL3GQXFQdIwCjyBxMCiWPyLiZ7Q8tdVuNYWD7u+ySgOk4KrZGkSwt91Ri4QACpKRwFH/8hFfiwj5J8rlqC/aDUfVQMp0xKm3Vx31ZaUzASfznwwPH/D5uwb/znPAsbXfd22UraCzQ19NNvJ7qiIEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896570; c=relaxed/simple;
	bh=WM8axHdOS1DBj6+db7+nso3rTnKFePd1vJt4i2cOUQc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=N8iIbSXsdmtAN+xLjNYYK/VWZq2GxdaseB+GwnkdfIaN5kAhByeyPDXBPV1Fgp00n2b2eI8k4Zw2pKkFGVTStJa/sO1dhUNKZ6IBwGB2eZ1TixJfjvBKVZ/qEuudoXTWtDpYm99cx0xGzrErptz+XELCrtq5Mt+wlQhstKGC6d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kB4BmWMN; arc=fail smtp.client-ip=40.107.249.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZDd1lgU9Dhf7/kLBGtamGITe7vXYddDWrO/JwEzfPR/LxNkhWUMhKxKKGYufknG0Oebkx5X9m6xppZ+3yb3aa3/xvnF2fcz4HbSNfHBlC2D/Nc2H3Rs94G9IUehQYJC2agwv0yL0mo5XjemC/Sxq41vABnTmzb350A5hyhoxflRhvHszwgAb+fwvydfeYFaOA2+GOZvC44oyy+d3RvL4VMLW/zzhVEnsg+KCm9mCA5UurzHtdPhS98GroSI6oK0LENU4TDumJh4h2400l9UZjBSFN2zGzD4VzUdI0znRFBGNu1vVxxwlU++p6HaIS5HFKWTa9UmVx9PbEBfqKlK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDkmhGeybqNEMRaGnhMNWAstwq7bP5WMezEInvaPZCk=;
 b=aUQy5smYnoBKIvi2FUvkZIqVNG+WY2nIh8n869wCPyx9Oz5yVej21BoqpcgCG0mEewRUgfxMBaoZ5qB/VH1YpkQLkoH0btnLCElaTovNPlS8atX4oRZJbZblDu2CcWZ60uhzqvFpBg10wwiVOey1VnddLBU+5jBuF697CpUi+yABBG/DQo6zhpQVKO987f5YDkO94oeDzE33LrWY8bSFkZpzKnZLLGHGc7U9PCmnFlEAQOoY4sGT7o4nO68zdxzPKjG/jvma6s36wNYToe3JmUZj90MGX5Fpl9bV8u3iZXhsGVsLyMY2cpchZEN5JRpFeM5KVLRY98RzWGRFUtByHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDkmhGeybqNEMRaGnhMNWAstwq7bP5WMezEInvaPZCk=;
 b=kB4BmWMNp+4SaQ8RXAChuKvqSmT7rIPJawacD7bp4y6q0+hjmSEnrKuL2vJBIsshU8Om3dgXJr8jAXmYZyS6XEOITaPD/YM7xIxvr4K+6fzaXY9a4rC4BveHrd2qT9XHmhCMrfPRYY2So1C5t7wA9K0DNdE5sT88WwBPQnCpXpqQxdrxqKWmknOICU5mhH5F+n2G7VAIdhmhA4CgHPcN86QH/oAPxT5jzio8Qxu3cIq26xAj8IPHM+6UDXG3Be3sxkadYB3fcKxK9YwIb0QscmYpPWaUwQ+wJT7hkVfNoRA3ApskKJf3n2uC0MR36YX8bBBA2bi8bd44lRFRAHgSgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:02:45 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:02:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/4] clk: imx: scu and fracn pll update
Date: Mon, 14 Oct 2024 17:11:21 +0800
Message-Id: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADngDGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MT3czcCt3knGzdMkNdI5NkI7PktETDFHNLJaCGgqLUtMwKsGHRsbW
 1ABIAyttcAAAA
X-Change-ID: 20241014-imx-clk-v1-24c26cfa1d79
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728897092; l=1025;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WM8axHdOS1DBj6+db7+nso3rTnKFePd1vJt4i2cOUQc=;
 b=T57IHB8lgG1d3+3Y2FUqZQgBaZRxtjA0R+ofh3gJ92tQ4FfjLtXKaws6AWVWe5VFPKd5Z5Qzf
 QMpoKBQtcKeDVOw2lG4+7PgaPejtgeVIravpemV0lqJ/cfKhloF4CeT
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
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: a6643872-6c47-4994-9831-08dcec2ef7a8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3lCSUpBUmdXb0w4Ykg1N0ljVUpjbldKdmMwemxUTXlvWm9rTjhPMVVMS0py?=
 =?utf-8?B?NXNLeGFDMndWN3drMi9iaVVsR1pWK1pTM1Y3cjZCdG5WMTQxZVQ2eW11WFVR?=
 =?utf-8?B?S0phQW0zZHZMbmRZRnpaM0Y5UFRUOWxaQ1pTR0FwQzFZcVh5OHdBeXo2UXhp?=
 =?utf-8?B?NnQ4MTg5RkZMS0ZSUkZYcUV1WjBjTHAza0xZek5JRHE5RWNpUFM4V1NOelF0?=
 =?utf-8?B?Mm1mWDcySzdQRUtsTHd5NFcrSm96a2JHS0FLdy9SakQwQmJvaFZ4UFZWclB4?=
 =?utf-8?B?U21mM0o2WStXVHBvNmxXbmRWc3g4a1EvcURBVUFRekh0K3VXcG5hU3VIOStI?=
 =?utf-8?B?bWZxSVV0ZEsxRy9FV1M4dTRCejZxUlFtOW9lSWtyekRpd0J2WmlNUVlUd0FM?=
 =?utf-8?B?aG1Wb2VqWjRmc2tRd0VPMjBuQlpHSDRFRmFxclpLcy9icGJ4aUNmaDRpR3g3?=
 =?utf-8?B?YllPTTc0eFdpbXN4WEU5enp3YWhFVXRwNUUwSHZHUks0T3lFNk5iY3AwazlI?=
 =?utf-8?B?ZGZlSU9KSlVYcFIvRWdXWlA5bTVld3BIbGhmOHZZTW1RQlcrWk51YWFlODd4?=
 =?utf-8?B?cTd2L2JUOG9Yam9JcEsvNmdQOEJMZzdHQjJaWE9jMnN2MHhNMU03WS9icVN1?=
 =?utf-8?B?QTR2UWpEY1IxYzA2WlRYN0pWV1QyT3Rqa2k2RVNNdEFjODlOaE5yL2xxeGFQ?=
 =?utf-8?B?RExYNU1XMHdHMWo5aEJXT1QyZVEyS3BaNkp0cExjVFZnZHBxK3J2em9BKzFV?=
 =?utf-8?B?eUpKb1I4dm0wVkVNdFRlcjZXaDBialI5UEpSN0xhM1huajM1bWdzcUNmQlk1?=
 =?utf-8?B?cW9uQXhzanNPWmo3MllqWDBLdzZ4aDdIMHI5bWdONUQ0dEFIU2FDSjU0OUtx?=
 =?utf-8?B?R0RMK2RXcnp2R1ZZbiswa095Zzg4Wk9FaEkwMW5ablhOM20wYXlLYXB3SnZF?=
 =?utf-8?B?REFwVkNlLzZpSUM2TnRZdHJqc1NVaitTdG1JMjdXUzM0dUF0S0Q2cmd3QU5F?=
 =?utf-8?B?QjRPS2lqMm93cEdJbXNJREVlUlN0WjR5cnJRQzI5aXdOQms5TXBzampQZVZs?=
 =?utf-8?B?ZzZWTHkzOFBKZHcvVGJWNVQ2MmlxK3JycGx6YWV3T05LMnllanN4aTlsN2JX?=
 =?utf-8?B?b3lTTjJrTjk0SEQ3K21iQTFSdlVWODNlUUJEVnVTV2J0SkYrWk5Zc1dvR3hY?=
 =?utf-8?B?WWw3Q3NOQmpLNUdRcU84ZVQxSVFsby9acTM5R2p5Z0hIa2ZmcTlVQTl0QXlR?=
 =?utf-8?B?Q1dZSzFhc1hVbnE5TEFsallSRHdFMkJFR0I1ZXBBclN4R1k3WG1jSG0relVj?=
 =?utf-8?B?LzF0RmljWUZqSHlDWmRoNE9EM1FvMEs2MklMWEV4WllIUEVYZzdoVCtyODdM?=
 =?utf-8?B?SS9FYzNIQ3hKNDVGeHNLOFVrYnkxRjd6Nlc5SUZXOXRveExDalZ6MDZHa0d1?=
 =?utf-8?B?d3doNjJkOXpZaWJ5dk8zMVhkTzcxS3hjaEtZNlN1M1BSS2ZJZWZPR2NtcmJz?=
 =?utf-8?B?dkl1ckhjZFYyTnpZRkVISzdKRG9RWTBhMWRGNmY1UnlUN3hsdS9VeW5Wck1m?=
 =?utf-8?B?OVg0elZBRGhKWjhydGlVNWZKZ1VER0ZOa2ZscjFtVHl6L1MwU3I4ZmI3SGNS?=
 =?utf-8?B?aFhnY21DV2pjMlhvUjNvMWtZN2V0TDh0R3BsekpQVldOUTFBQmNPb0FveUlP?=
 =?utf-8?B?WjFuZGMybTBENEk5WmRxRnJlM1ZpOFE2ZEpiMW9jWjE0T3A2bDkzT2VrY2pz?=
 =?utf-8?B?YVBMSk45RXovcVNpSHN1TmFsODBrTTlMdEdwcW9VelYzT0Nma2JaNm9FdERX?=
 =?utf-8?B?dytRcnJnU3IxMU1ObEtIZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWVjb0Y2MjRnZGJVcWdtMkNKeUpJRGN6dkZ0SUtqbnJJSUI4WThMenJBbTRv?=
 =?utf-8?B?YUZNdWRhTjdBNUc5TXAzbC9rL2J2YWZieWxEVE5BcDlqMlVHWDVUU3ZzN0JK?=
 =?utf-8?B?YmdWZnFwa255NUNDUDVucm9wMDJCU3FFZ0FYNzhBQlkra3NvZy95aGRJV3RQ?=
 =?utf-8?B?ZzNRUEFBUDlGVHJPckt0MThsQzAwaGhkUEF1eWFldXoySFBPVkd3MVh4ZVNH?=
 =?utf-8?B?VU5kZU82Qm1rU3pzYjZES25QakZJRS9OY0tJcTNxbUQ5N1RnUXpWTjBKNms2?=
 =?utf-8?B?K0pvWmFmSXVFcUgyNXFJZmZ4NUVTYXJtVU04ZTVTa3VIVFdKWEFaTXZDdFM3?=
 =?utf-8?B?YTBnaDJYbWN4UWtzQk9YelFVUlUzM0Vsb21LbXg3UEkvdGVFeXFFRVdtY1RI?=
 =?utf-8?B?NlQzWWt1VWxTZ1NsVmNFeHFhNWlnSHVVemxiOHlJTXQxUU1SMXhON1Rvdlgr?=
 =?utf-8?B?cWsrd0hSSTJNdFdiRGlkSy9BdkhFUDQ2N3pDejVwb1lQaHFPamJtbThHWXRG?=
 =?utf-8?B?RVZGcWZIN2xyUno3QWgyZFAzczZjN1NjaFhGNHRwZGZYYjNab3FPVStPZUln?=
 =?utf-8?B?aUd2TVlwTUpLeTB4dVdBNHZWUGV4T3pYbFdpTCtBbThNcTNTcFZGaDMxMGpQ?=
 =?utf-8?B?TFdDbnBUNWdDalNVMUhWTzVjeW4yZUVRZFNXWk1taEJ1MU5PWElrRTAyZ29J?=
 =?utf-8?B?UmpxTjlrS1pIUkQ3L3hNT2ZVQ3hpdFRzVUc4amVNcWJJNFhjTWo2RUhwMU1J?=
 =?utf-8?B?SjZ6TmFPaG9yTk1zNGw4Q3d6U2hmMEpQZHppTEtHM0wwODBFcXp1amNUVXhQ?=
 =?utf-8?B?TTZwc1B6QjE3c0ttZ2hKTHNLS1VZN2I2dEVybG4yT3hHN3NCU2ZBc0c3eE5j?=
 =?utf-8?B?ZFZPT3g2TlRuSzlnRlh4OEozZ281MXRLbnZUS3QwS0JIWGNoYmNYdEJEN21z?=
 =?utf-8?B?VzF4emx6aUZIRFdybG9qNEFUdS85UUgwNzBMRGFPSnhmKytZbWhZd2Z2WEFx?=
 =?utf-8?B?QUtrVXVPRnF3YzhmdjNMY21MSXBpOFlGcTJ6djN3dDViZWNOa2QwbkVWUThX?=
 =?utf-8?B?dVZpUlpYTDNsWTlhNk1POHpXS0hQbzZCWG1tek9XYzhGSkhLczdQMXQ5VGpU?=
 =?utf-8?B?ZWJ3M3FLVFFHQnI0czluUjRrbExJWnVyUjFlQTlGZCtIalNnNzJGb3NuS2Jr?=
 =?utf-8?B?MW43MmRnb0pCcm5RbUd3SmdiODN4V3krL2d0dVJDT3J4VU05QlhyNnVWYTcx?=
 =?utf-8?B?ZUVwVU9XK1J6dWRTVm1HZlpicjlUYTNVSCs2Vi9abkdqMDZYV1I3b1JxTzdu?=
 =?utf-8?B?eWZYY1JZa1ZXSkdTakF3NVlrRG45SllUaVk4VndkMzJqZ3daNXVCaERNWWFB?=
 =?utf-8?B?cEVuQ1M4WXhWWGl1eGZUWHZrcnNXMXNHdTkrTFYzdTArZ2FRelV3TjFpKzE4?=
 =?utf-8?B?UnBkRHJtNlVuZnhIOXh2eS9ieTRUMVpUNzFSb1lRVXFJUUJOREUybVlpUEgw?=
 =?utf-8?B?QkQ3L2lEZzk2bk5ybWpxMktOSk1wOVcxL3ZkUisvdlFBM1Noc3BaRE9pNEdO?=
 =?utf-8?B?cEx4RVF4SlV5c01DK2dmeEdJRldjRVFOOVdHd050OVpGS2lvdkR4ZkxTMDVq?=
 =?utf-8?B?anh6TThVbzAxL01YbE1tYlZqZHdZQ0VpM1lsWEN0N2hVczhkVkp5UGVZOFcz?=
 =?utf-8?B?THpGS3d2M2JDeTE0WTI5dEJYaENjNTRSYVVySVVmL0JtQUtwYUJqVkR6VXp2?=
 =?utf-8?B?eGZxUjk1UTdSZDFGTWJ6d3RMQy91NXp1QWtxM21Pd3Q2aEsvOGJCY2pQYlBy?=
 =?utf-8?B?SjVNTTgzcEZLY1AxZ0pOZ0ZiR21CbkdSV0JEU0laZVJBMW9mVDRKSUJGdGE2?=
 =?utf-8?B?eGJtT05wSUM3TlNtN2w2SlBVNTdSNlRsVGwzM3BFYnZ3bERrQndkckRVUmRv?=
 =?utf-8?B?QS9Ud0Jsb1JDcGZsT0J1TDN1RmNjbHdKZjN1SXFFM3VxV29PS2hoV2JLWW91?=
 =?utf-8?B?Z0xsaGg2elo5TnpWVFlLWGNCL25tRkxpZDlVa0V4Q21WZjJmNzRYdEJRb2Np?=
 =?utf-8?B?eHY3REw1SFpGdSt0R3lMZlljdEdSMEdWbExrKysveWZmYlVKcTU2Skc4bVNy?=
 =?utf-8?Q?33ylW2X4uUgfD/EQSb71Xqr03?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6643872-6c47-4994-9831-08dcec2ef7a8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:02:44.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOYOBxLLPcCix3bDudF3E/JLt9WnR/hVcFzY6bTYq8HzFyBVbj+SHDMOYf7hDOh2FC6JxiJlXqgXQ73mzJwRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765

Patch 1 is to resubmit [1] with comments addressed.
Patch 2 is for hdmi. Fix tag not needed.
Patch 3 and Patch 4 are for i.MX93 Fracn PLL fix.
In Patch 4:
fence_write is reusing the idea of fence_udelay in drivers/clk/tegra/clk.h

Detailed information is in commit log of each patch.

[1] https://lore.kernel.org/lkml/20240228082649.1633083-1-peng.fan@oss.nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      clk: imx: lpcg-scu: SW workaround for errata (e10858)
      clk: imx: lpcg-scu: Skip HDMI LPCG clock save/restore
      clk: imx: fracn-gppll: correct PLL initialization flow
      clk: imx: fracn-gppll: fix pll power up

 drivers/clk/imx/clk-fracn-gppll.c | 20 +++++++++++++-------
 drivers/clk/imx/clk-lpcg-scu.c    | 40 +++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 11 deletions(-)
---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241014-imx-clk-v1-24c26cfa1d79

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


