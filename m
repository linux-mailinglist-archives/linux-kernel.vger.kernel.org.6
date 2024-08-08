Return-Path: <linux-kernel+bounces-278823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A694B556
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CA81C21AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390224317B;
	Thu,  8 Aug 2024 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fPe3SvtU"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013048.outbound.protection.outlook.com [52.101.67.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F226AF7;
	Thu,  8 Aug 2024 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086528; cv=fail; b=H30+/9G8BzbYltqudUE6hvaWKVlMuDzHzKjXCXSo4hg6H2Myad7gl+j63FUSOpABHLCeBLOidVWTqodgxj4dwvdXpi7P/orY61iNMeAnN4bLuhFo4B+7MZBKSfAf6jTmHWrafJGgZgTuUQU53ECjXBVMatDJz80UT1bd1NKMF98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086528; c=relaxed/simple;
	bh=IjsV/iPh9WaPCaHKt4+36IGaGIF9GLvDPbpma9rMqdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=deH/glHMBWBJJnap0ZSwVvvtEq+YYXDBkrMrA9fHlxO+JIk17+DXWYrQBqPIK8IPWJc8C5YtOBo9UPOZXuvfbdV1VFFALR/l1ge4ldAPUi0UybS+Dcc5IVaZM6QQDjxfZ9o+5opZDpnCDmfzVP3L2evUc7zz1FZ7YGzuwd056Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fPe3SvtU; arc=fail smtp.client-ip=52.101.67.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWRuoDd3U/nruZrsl738U6DhHogquJQktKrnytTrhLhuYU7xXNwoIVPqk94kaWZlp75dnuF1mp5vUqNgdR+CPZOKAUwqPd/fbFB6pfA1ts8HwvZmHk+Ia9oyjTiTc6YzaqkIVBYIC1eGWUFAXmvqH9kiOVJVyq8AJMiPI8KwTJXt2pk3v+DrO1lt0c6w5+q9PxoiF92VIWa6w4Rw6oz2aSya+2hFGbOZkEcMKiuRr+u7Wfkj4SMzd+qKhWin21MvDmT4VNv73DXHJunBGvyDJmEUU9+C0AtAIxi0Msa/IdV8TheFH2T+J/fjl54nPqwIeGW87cUMJGKjMX1bpuEcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjsV/iPh9WaPCaHKt4+36IGaGIF9GLvDPbpma9rMqdM=;
 b=SFlptgvfsO4hd2/qra2LH8WBbuBgfniKSum1WK89bsF8kfE5o7Xt2PlBjgBdMIcX3gJMLSbFE4mVAojAHM/ecmGYXfr2mMb2AQnbx7SPOv3h+KyZarH1WjR3eVO9iyhmu7S86nD2oxsED1lX8dUbSE+k2BFA9foV9oxyUJTX4zt+r/0I35MrgeeaWh5Nyy/bMTaVDAGoUOdkS8a+TqipBLFc/89bCWZVosw4MJ2KHE4l0K2UsoYYPzdAWfu7dcgfpg7WsB34/wgKFGYWKieJAu4nSc6lwORwcNWlkrua/t/Lv2JKwP1ryRak17D+UURxM8vppsT9ROw5vjZVmPVQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjsV/iPh9WaPCaHKt4+36IGaGIF9GLvDPbpma9rMqdM=;
 b=fPe3SvtUD3JXzDomymKo8RiNlxqjBhRa/jhcnV0E1gz+Nxvz+akPYsRp/16XjyZLmB/Bja+5ywnhyOrxZilX7ep1XuHz/sh8TdWnxTGZNfppuyf+x4H0iPmsUbRYie41BiC0yOPtaAcm1gNaCeiKtmLNlERfGEMTzyKGlYW24A1S5cZwFzWuCHIggIwSk3cw7/xBPTVjX+e0q3we2kxlfW20jN4nmmcxDgyw346weg/e95bI+1tJItrPT3XfUnJDdKxn3wVg67plDctY9M/gVLkSA+kzJvHKZXzyY5ZmwXMIZugcMkPyRRlv0DGdA8fzo+9Up0ST/m7Heyd04xAVUg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10994.eurprd04.prod.outlook.com (2603:10a6:150:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 03:08:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 03:08:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Chester
 Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, "Ghennadi
 Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-S32 <S32@nxp.com>, "Ciprian Marian Costea
 (OSS)" <ciprianmarian.costea@oss.nxp.com>
Subject: RE: [PATCH v2 RESEND] arm64: dts: s32g: Disable usdhc write-protect
Thread-Topic: [PATCH v2 RESEND] arm64: dts: s32g: Disable usdhc write-protect
Thread-Index: AQHa5x3aHX1oA5y+sEGsIYpUXutNo7Icsbng
Date: Thu, 8 Aug 2024 03:08:41 +0000
Message-ID:
 <PAXPR04MB84591D018FDFE0BA1902213488B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240805095642.91606-1-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240805095642.91606-1-ciprianmarian.costea@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10994:EE_
x-ms-office365-filtering-correlation-id: 3884c563-39a0-4922-584a-08dcb75767fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDBOcjFibGQ2Ym5XSVNpZnNyVzgvcmxDd01RV1c3VFNRZnQrUnFJdjB4ZUx1?=
 =?utf-8?B?UmsvOW1sOUlKWkc1SmtZaVJFYitKY3FYTVpVRUJhRStQY0tkR0FpMVhIMXdJ?=
 =?utf-8?B?TjBFby8waW02c0J6Skp2RUtVcDZNVkRrLzYyOFBrbG9DSnE1RnB2TzdyYkND?=
 =?utf-8?B?UXFOYlU2Y1JqOVFGUEtOUEF2RDEwT1U1OFZIcGNCVVJmcDhlZjBZN0RTWXls?=
 =?utf-8?B?RjQwSU1kUFJlUkNYcExOSFlteDVqeFZ1aG43bXl5bUpQRE5DMlR1U08zWTVt?=
 =?utf-8?B?S3BXb21MVkg4TG9zZzYwNVFqUUN4U1NxcXp0MTgxMW8ydTFtNE5YaUxRZ0Nl?=
 =?utf-8?B?OEFUVGJOTjB5OTd5T1l0NzZrUCtXR05ZWmdya28xUklVUUNocU9OMGtSV2Jw?=
 =?utf-8?B?RnUrMFRETHFJWW4vMUJpYytDYncyYTR2VzhFLy9wOFpjT1RReFZjNzZZYU5N?=
 =?utf-8?B?dlV5b002dHl2d1BOL0t1bnRlOFZrWnE5eHhxbHVTWHdmV2xtKzQ2ekdhV0Ew?=
 =?utf-8?B?MFNGcFFET0s4YURNd09nZWc5VEhuQnRJZ3daRFNJR1RONGZpVXJFNmxta1Qx?=
 =?utf-8?B?bVppWHZMN2p6eGN3WXhKaGdDdElnSnBPTzljUTF3NiszQnFqdTNLNldRZ3Fr?=
 =?utf-8?B?aW93MXRnWTZSZytDNkszbWZ5VjFEMmxFSy9mbFJxem5hSytoL0JGWW9MYVdM?=
 =?utf-8?B?T00yRjV6bnRRNGhaVVMwSnJnU04xWGJUMmhLd25NcVFpT0FjMURUTEdVU2xT?=
 =?utf-8?B?c2FEMEVlWDI5UHBRU0hRZWwwNnpRTkR0d2NaRGJoRTNVK3RkU0VXaTFueUQ5?=
 =?utf-8?B?SVAvZ1ZqaExqeXNqcE9WM2VLMVNoTU96c2JTbkJqUUI2R1hFTW5pYTlNQ0Jk?=
 =?utf-8?B?eTZHT295a0liTFRuMFpEbHdWVms1ZW1hclBTR3dYQTFncGJzQzRBUkZ1ZG83?=
 =?utf-8?B?Tzg5L2xlTU5zaG80VjY4dEhLVVFOckZNUUg3OTVKMUdYdjZvaWsyNVZLdVJ3?=
 =?utf-8?B?bVJJZjY2aWRqeWFuakRMSEgxWklxajhkMlJuTWlibUJmK1NzZTk2WGZQMTN6?=
 =?utf-8?B?Ym1lTmJYRFJua0pJV0RQQm9uUk1sSnBWcFU0c3ZoQ3dqTlJ1Qm1PMVF2Rjlv?=
 =?utf-8?B?YWpLT2JaQ3VWWFRpRjFscWZRTTNuUHpZRVpNeDJyMGdvYzNjVkRVbjRrWUlH?=
 =?utf-8?B?cXgyZytvNEV2VTl5U2NtQUlwQnVCWm8vVHZXN3BRTDdwZTRQMXRucXdOWFhP?=
 =?utf-8?B?RDBEb3BDeFl1SHkwN2lRSTcvRHVUUENnUHFPMVFxd3ZnZ2xkSUNoUElqQnk0?=
 =?utf-8?B?dVFwME50ajZ6RnZrTzRzV2VBWW13UDVDWTJ3NndMalgyL0pVcXZaVVhOQU1T?=
 =?utf-8?B?eUlnaXpBUktRQlNSeXNGYlVXRjdzUUZiOGM5azlRcXluUUVITk01bTFFU2tp?=
 =?utf-8?B?dW50am9wcmltSlc2NDJ6NjdvSVFBVmJ5WENjMkVJbWpDRnlKekRuZENBVTlY?=
 =?utf-8?B?TUZBcm1ZZUNzMWRDTWp3cTc0TGlmYi95WGdnSkRIWTRaV2hia2FhSnh1Nkdi?=
 =?utf-8?B?M3BKRlYwTHJjb3FJbE5tRElhdFR1WlVqblVLdDJ3QUU5U3BQdGhtcWxWQ1ZC?=
 =?utf-8?B?K0o3aDhCdFlyMXFwSGxLUlE2QjNCTkdpMnhheS9tME04Z1ZUSzBlRzhmVlVi?=
 =?utf-8?B?MTBkMmVtUnBRMUlMbjM3Vy9mWWJWdjFseTRPM1NKdVBWOXhCSUlUeitCZDdL?=
 =?utf-8?B?SG5CeGxWak53d0lHYkpHMW9RZ2l0SStuQ0lJend3Qk8zYWkwUlJVUVV3Z0Rn?=
 =?utf-8?B?bWs3WFFNalFReVdGek1XUXJlTE1sczk3NjlBb3JJcUo4ZDlxbG5Kb0U3Y3I3?=
 =?utf-8?B?S2w5YXRvWEdwb2VKbTVxb0VXY2NwS2psMVlPWUFkOGN6WHNHWW5rRzg4Si9O?=
 =?utf-8?Q?2o2V88bq9AY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3NENzR0R2xYQmlOTzA2eGNkWk8vQVo0WC9sWEFzejd0ZU12SDVROFk1MzVC?=
 =?utf-8?B?c28vQmxIR2xnNFpxRDhFSThMcjd5OXk3NC9KdkdST0h6aTl5R0YxNG0xVjBp?=
 =?utf-8?B?Znp4NXAzS29OTnlVYU1LZDFYcE1VYmtVbTY4NytDU2V3eWp1cU45OSt1QUp6?=
 =?utf-8?B?VFhDbUhTNzJWSDBtL2FUeWh3Mk9vanhERGdVcG81ZjRYNHQvUXFKaUQ5ZHgy?=
 =?utf-8?B?eHI0amNHeitiQ21hbTJ1b3NYOUxEWG1MNVMvYW1CYzVPUXhkQ082MVN5WWZl?=
 =?utf-8?B?T3RZWTB5THYwTjlYb01TL1RFTnFFWmFxZVZiUTg5SFROUFBteGQ1empyYjlS?=
 =?utf-8?B?QkNFcEpwRHJ6MmpSSTBTUzgwejh2d3g1NkRreVpITk42MG9BbXd5UU5uTWRk?=
 =?utf-8?B?YXZwaTBVaDY0bTJLaFc4bDFLSGhoZlFYaG1FV3g1blExRFFoRVJSQWdCeTJK?=
 =?utf-8?B?YjZLY29FV0ZYVTFWR1BpVWc4eFhrV2I3Ky9lVjVHRkgyNlhBbEZOOE5NTDdP?=
 =?utf-8?B?OVdqR0RzT0tyZzFudjhZcnZucEgySU9tTTJNZzBIeFcyK3FkM040VzBHMllU?=
 =?utf-8?B?MnRidU9ENWM2TXVPaC9JK2xLa096SWdoWlJCZ25zcDdWZFlTa2wraFp6RmRi?=
 =?utf-8?B?VkhaNzN5dmpvUWlpekZHQXFKdnY1QVVnbVRBM25lSkZDc3lzQTE5Nk8vZzVB?=
 =?utf-8?B?dkN0RFFsNngwTDMxQjQvTjIxU1lZbHVjNXp2WXN4bnVHbFVHRWsvTXRDb0RV?=
 =?utf-8?B?L2g4UkxXeGhwczVSWWtTb01jamNyTnhSays0NFdBL3JNT051YmlkNkxRWFpC?=
 =?utf-8?B?bk0yM3RKY0NOT0NDTWJlRlZ4ZE92Z0lQWUxKUTFyME5SVWRWc1R3R2FQQnly?=
 =?utf-8?B?SUFQQ1FzcU1PaExhTVRHSjNFWmFkOUZmMENUZzlWUkN5dFg0Z2RSdlFKNHdl?=
 =?utf-8?B?bVNCYWV2TDl1Y0V3RVZmN3RtN1ZkdEtpNC9VdGdUblRKNm9ZU09RVHQrVGc2?=
 =?utf-8?B?T1NUZ3VJREtBWDFJUXp1RW5VRU9rR29obmNkSm42bEE4RW5jd2VEU0Z3ZGox?=
 =?utf-8?B?REFnei90RGlraW5XRDhXSFlKVTE1R09POHloK0s5Ymd4MlRIWVhPSFRjTWhx?=
 =?utf-8?B?bWFLdnJPNTB5SjdSejlwZk4xMjhrYW1nYjBqaUpwMFV5akwxMEcxeWlkcnly?=
 =?utf-8?B?Vk9xZ0dERlkxSkJWQVp3Ylp6VDRZQ2RSaEVLTHdYSGtnWUNMMDBhSTZGU0d5?=
 =?utf-8?B?QzVreGxpRFN3bTNJbXFnRHRkTjR6bThtbkhxQ3NtNUoyZjA2SjNPa2FrT3JK?=
 =?utf-8?B?OE5KaThxaVJZelcxcHNjYkFlNGE1bVVadkZHUTdzajZuY0tlUFE2K202L3B0?=
 =?utf-8?B?THFRWjNpZm1USGRFRG8rbGovbVpFbFlmdjNadWdKcWFuNWcrWXh0SUMvK3hV?=
 =?utf-8?B?VDJORGVOYmdSem9aMnlXSkFNK3M0SzV4WU1mMS8yeU9OTUl6Yk14NmtVL0Fa?=
 =?utf-8?B?dzRjdDdCaUQxZ1h6SWNqMVRUb3ZLUVlrWkV0Tkd6d3RLUEtNNjhpT3dUODVR?=
 =?utf-8?B?aFVLMk1oSGUvcjlLUTV3TTBRUisvazV5bEZQNHAyS1NlZ1d2bkxEK0RvQVZy?=
 =?utf-8?B?bGN6SDdqTHYrQTh1Sk1lTEsyckl1Vk5OcE5jNHZkT1hpOEhsYmlQTmgrMjYv?=
 =?utf-8?B?Z0IwdGliaVpqWFFFUm9SMXNCQnJaZmlHdFU3UUNUeXBQK2xicVdTeFc0L0dx?=
 =?utf-8?B?S1NvVFB4WXlkVlBoMHJXSEc4b2EzRUQ0MTVDNHBGTXFaTzhjK3ZGbVRLYmhn?=
 =?utf-8?B?M3hnZXFMcldwWEZraUtDSVp3YlU5QnhpWmVEa1hCSUNGZWRISnpiYWxVT1NI?=
 =?utf-8?B?elFTZ2JYOG9VOG9sa1JVY2tJTHVlMUM5YmZ6SWZnUnhEUmJYK21sL1pncEND?=
 =?utf-8?B?bGVRRWR0eUlLcG1Sa2dPVnZsbWRnZCtyNVY4aUdvaGpGR281UnJVUU9BWC96?=
 =?utf-8?B?MlMwekdFMW15dkNmNzlsSWc0YVNTeGpnSGZxUGQrem82V29jNVc5ZnI0bHRU?=
 =?utf-8?B?QWdnbHdrdTZXOVJrVGFablJhSUhPS1ZiOE0zc21uTDVDSDhmMXhEWnpaYWpG?=
 =?utf-8?Q?XA90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3884c563-39a0-4922-584a-08dcb75767fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 03:08:41.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hqeUlXuqtjh9F4y6FsYiUTdQPOh0wfhR1qV/qVqB1pU5IuVGrqAbMjIuTZUodlHb7um/pqdccTpWggINqfgJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10994

PiBTdWJqZWN0OiBbUEFUQ0ggdjIgUkVTRU5EXSBhcm02NDogZHRzOiBzMzJnOiBEaXNhYmxlIHVz
ZGhjIHdyaXRlLQ0KPiBwcm90ZWN0DQo+IA0KPiBTREhDSSBjb250cm9sbGVyIGZvdW5kIG9uIE5Y
UCBTMzJHIGJhc2VkIHBsYXRmb3JtcyBkbyBub3QgZGVmaW5lIGENCj4gcGluIGZvciBTRC1DYXJk
IHdyaXRlIHByb3RlY3Rpb24uDQo+IA0KPiBSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8
bWJydWdnZXJAc3VzZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENpcHJpYW4gQ29zdGVhIDxjaXBy
aWFubWFyaWFuLmNvc3RlYUBvc3MubnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0K

