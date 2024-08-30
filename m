Return-Path: <linux-kernel+bounces-308720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEB9660DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E429B2281D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559C199933;
	Fri, 30 Aug 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZGJ6VYGR"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607718F2DA;
	Fri, 30 Aug 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017642; cv=fail; b=OZ+kjmBxEzHsD3CEPg01Yn0u2cCHJ7yiWl1Rqh4Uzy81QYojHTbjm4O2qxCI+hNSEd3QFybIfXB9wA8jyqsaBmWCk/C0joHT5yhkrGI45uvH22ZQPs8hQBd3JR4xpEI/ws6anNOcUnEJ1wVNF1kYTg8INkVBQAM0UxEQhPDlpEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017642; c=relaxed/simple;
	bh=k2scHyf6OSuMxh5CzZ/MP7k6s8cxb53ZLbVQlE+byVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lj/5H7iv8B7CVhK7kSxsD6RqzpbsSqfmUcCFuEhOw4QDIy4jbexPo203kxZ+s+fUIiOkAlcXwFSR4M1/rzDbQp0vRqcZnnRdyoXuH6VyTH0TcdtjkVC4pB9xQwAFvrdcBl1v1RuYdTGelLCYlnatIZtPD8e2HGTcbaGUmKdT5j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZGJ6VYGR; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1yzJVPJaE8HCTBBihN7/JTV/N9/7hJ+xJbByX7cxIVygmPtZljwcT5/n5UBkTq48wVg72OC2RxIxcrBnWBQPWprkj5+toqJ9XsVKaYbr9/eiaA2qV8sw3UxrvSTDYySdlstc3k01+fap7QL0mV+lk0G3yv0MXS6gNfkfJqghyCZbuZWhJ1Bp11Cqy9+R8RCn979wyVICZwhmQnbnk/BaXAb8sw0HoEP3nvINKEjZoVXDcgIqZU5ErX16vVPjIUOFNxSVpCaccERF9mmfltzqUUhA8QBolvslf7Pfe7W8XAR2P4SmICE6DNAzEXtrBA6WbgGUhqFzYsdc7zBtbw17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqO1yM02EPVE/MRqZEDoEpructK2fSSxMXpHFhTn5Pk=;
 b=KVkvksB2c5vxvsPXUTsmkk7j+2BWpL8hSxp2/iJkRCFLy59I0/gxxadvhZZnlBgZd8I1qz5lheDhDLvSmqIuSIosBStolPTJtbMEm10jQIwo3kNmW/4T2ZsA5sFDdcHwoHR8lSJYv0ztlypSiVVDTr8zvlz6jD/HUIubnAcJgKP1X4e1zbjOuWOCr4/FDv3ko5NCHCVXpi9tLo8zHjJRF9G9xfbpBVtiEkvWEHwRQG/Bhw+x07yENBOOIiorEesHtIf0BKXJ+h1QgFZWaaH8ZFLu66QFAh4/MvF7p9j1CIpfewc/9rncRkhUmWCCYV70kAtIGQsJaGQopV2NjI+gsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqO1yM02EPVE/MRqZEDoEpructK2fSSxMXpHFhTn5Pk=;
 b=ZGJ6VYGR/pTyd6ibMbgybpLJePyox8zjkIE+phhCVUeHtrrIzKeW92aN9SgHk8exzzSdMuiGYM8VkbHrMVixbLUDXFVJlNoCk2rTZz8JG/ByMN3pBXi9IYyGzwSvOYpdS/9GNkW7eDW8bV+xfBecd8rTFslouCdEdPSIQlnFeCOEtP7tzxHOa7XFxcX9sC3u1ZBShIMRacL0i2owi1iCSuhkd4tAMxNGAA7Y/gBjA39CLNVQPSu1S8oed7pAH1s++TDWETETRwtUIyXgdjIOMAxEZJa85jRZqmuCVrwH1hrYsTSBYrXDhXpNe6zR2c1bEah9Adp0qfGywZeSZuL0cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 11:33:54 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 11:33:54 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Radu Pirea <radu-nicolae.pirea@nxp.com>
Subject: [PATCH v2 1/2] arm64: dts: s32g: Add S32G2/S32G3 uSDHC pinmux
Date: Fri, 30 Aug 2024 14:33:46 +0300
Message-ID: <20240830113347.4048370-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830113347.4048370-1-ciprianmarian.costea@oss.nxp.com>
References: <20240830113347.4048370-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::35) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 350342ae-3518-4deb-f4a2-08dcc8e7a0f0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aERvYnlRR05uRWhodkpuTjMxU3IwNWNUSzBGSHpoZlRzK3FCOW9GaDZ3RWRT?=
 =?utf-8?B?cXUvaHlpdG5qKzAyM2x4djNiYitlNUMvNkE0VW9qa0QxbzcvL2NkaTM5UlNa?=
 =?utf-8?B?S2ZZY3NsZ2xzdDhnazdzVzNoN3k2aFRtT0VuTVhKZTdLd3N6Y0VUanhpZVVs?=
 =?utf-8?B?bng0SktsNTdra0lBZDhNUFdIaENkUkFnN05rUzg4OExUcEtKUitYMXpkTVVQ?=
 =?utf-8?B?RmtWcDF3TE1xbmxjMGlUNlZiOFBHakJzbVQ2L0FLTzVjWnArVDhZR1M5ckpK?=
 =?utf-8?B?SS9DeGlObmVPbGVPOEQxSXhDWmZNbVUxQy9UaVozRUU0ZXdGRUNMNTR0dWhB?=
 =?utf-8?B?QjZYa2IrNmZwSCtacWJsNS9OaVVINitNejY5TUlnUkUwYUExNU5MYUtBOFN0?=
 =?utf-8?B?ak85dTJ2VFkrYW55dzBEYWxhUTRRRlVKME1yeE43ZHNNaUVZWFlSdTkwOC9P?=
 =?utf-8?B?ZnRSQUZEN1JNWExNQmkxWWNWdlF5YVhFMGRSR2N6d3c5N0xhMkpGRWZ5RFlP?=
 =?utf-8?B?MVNGWHpvbFZZd1ZWVGR5ek50bUdqTG9qNnltNGJ2SG1ZMlRZZ0QwZUw2Tytj?=
 =?utf-8?B?VmQraDR0b093cy8xNEk0amYzQnQwMUsrTUFjTlAyTW5LbWRxSG9vMFRTUEx5?=
 =?utf-8?B?Tzl1N0l6VURxZC9pQkU0UThzVFNJNVVHV0o1YXNXa0NjRDIycGtHdU83ZGdZ?=
 =?utf-8?B?akVzSUM2RWtDM3FDb25PU25tNC9BQ2UzUUNJMHdXbjVicktEOGxxS3d2em01?=
 =?utf-8?B?NU84bk81VUlFK2JTZ0dMZHdVVVJyNFYzSURZWjR3KzV4b0c5N1lSVlEvc0lj?=
 =?utf-8?B?WjBMaGhqcHdWQnpnUW1yY1YzTFdsSFk2b1lBTUxVeTNQOVhiTGJINlNBSTVT?=
 =?utf-8?B?cmJVM3pQM2FOTUNucFYzTnhMY3o1cEs4TTd5WEdMdXUyWEZiMVlKTHBON2o3?=
 =?utf-8?B?ZWx0VDlGMjdyYTRtUWdSdU10RHpnWmFrMFlrUTAzanRXdDg1dGh4RkNDTjE5?=
 =?utf-8?B?ZFR6VVRQV1RjdWZtazlaRTFPd1Y3aU9ObGIxbVhDWU1YZzJ6RXVLTzdkZDZM?=
 =?utf-8?B?SGVwdm5oaWFXUGhpY0NTWVlQMlJYcFV0Mk9FVWZhRzBuM3ZFSUVMeXFsdUVo?=
 =?utf-8?B?ZDA0U1p6czFNSFROb1NrTHJhVUFSNmozK21aU1NjVGluTHBBSiticVJBMGpa?=
 =?utf-8?B?V3RsR2NPNlFkSmZCanpBY3grY3J2V2IwdytrYUN5RnErUVhJU3pmNW5pbHVB?=
 =?utf-8?B?QlptTklFQ2NpQ1hTVUFpQlQvZTNCZGJXbi96Y3lpaStVZXNKWUR2NXdiL2Js?=
 =?utf-8?B?cmhBTEhadTA1ZmdmZ3RVR3JwUWswS2s2VzdaUmpLdHp5S3NMRjVtc1h6U0xu?=
 =?utf-8?B?RC81d3NaVklyTEpaVE90cEZ4dmxRMGdWMVJBMmQ5R3BKMXBYdTRSK1d3UXVQ?=
 =?utf-8?B?MDA5QTYwcThjSkNoYWowbWI3RnQrYlJSU0w0N3dNZzRZWk1KVndSY1Y3OWUx?=
 =?utf-8?B?UFV6UjhxeDNaL3NXWTBScFE0VHlPbTc1aWFEeG03SkpNRzQ3dmRwRytHNWIz?=
 =?utf-8?B?RFBjcENOSENnWXhaZ3V4Y3NYanFRRDArR0EydlF0c25JQUhLd1FFb0RKc01y?=
 =?utf-8?B?WFl4RVhkMHBIMU0vVDlGL2xmUitUY1pCRVBGV1ZpM2ZUTlh1WUQzYkdieTh6?=
 =?utf-8?B?aU9jVnZBV1NwcTh2aktlajFsam0yTDVJL09JbmY5cnJBNWh3NUtpTG0rYWNN?=
 =?utf-8?B?UVBVQ1BZd2F0ZGJiU2ZRTEI1UW5DeTNndHFNbUVUOWJxbnM1U0FFbGhmSGNT?=
 =?utf-8?B?L0lvMGtXMlpwb2FUYnhOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3J4R29uUHdpSnJQRUFQS1ZLY3ltb1ZyOWtJdm9aMUF2TDFMUk9panpzVGJK?=
 =?utf-8?B?RUgxWVJLQU96WHB6alRoTTRMSTM0VHlNNGVWRW8ySlUzUlpVS1lQTThGR05n?=
 =?utf-8?B?aHVab2xIeDAxRjlUSm53bm1vMTRlNndHcnZ1R3A1WitJWmR3QVNiaGV6RnZZ?=
 =?utf-8?B?akdqSTlmc3JoTDF4dys3d1RBN3NiQ2xyNFVESSt0eUtmODhrSnlRMm11M3U2?=
 =?utf-8?B?QjdmSEYveGdUWGNieXBhWkZ5cW8wRytKVjI5QWJhVWswWUxZMzl4UGJIN0pU?=
 =?utf-8?B?WmQ4a2xWZmZFYmp3ZXRKYldENEhPMFpCbkZEdFVodHpzU3ZLUnNOVzdKUVFw?=
 =?utf-8?B?RE9oOWJSTG85MUdYdjNHLy85TjA2K2hFZTZUTWpjZHM3OXBWNk8yVnFwM3JO?=
 =?utf-8?B?U1phTFMxUEk2SWtVM3JtUndXcU9WaVJwNDBjSDJXVWpjVytzcUZjRi9MSHZJ?=
 =?utf-8?B?WnNYSDQxNjZjemNRUFpBTlNhVmZtTXd2VFNZVlp6RnlYdC9OVE9iRnlSUGVv?=
 =?utf-8?B?WkE1MHJvRExEbkRkNjhEQ3dyRkRIZ1ozUExEWmhpVVdtczAvYlBKcEl3ZFhm?=
 =?utf-8?B?VmhIZzZLd1k0MUpRdkpIYXp4TERKMFp6UGRoYVhCUlBLUlZPYkc1TUdiOFVa?=
 =?utf-8?B?Z2hCb3FxK2NPaHBybVZQd21QWHZWMm04NzdvN1BBNnNwNkpyWGNCcmdQVlFJ?=
 =?utf-8?B?b0h1YW43TVk1eGhib0tpSGlHSVVwNFpXbytRL3gzbTJ6QWJlTmEwWUpCdFFo?=
 =?utf-8?B?RkswVDVOTEdDWHpPTDdML0RvcXM2NGZKdllhekVBazhVV3JuSUI2MkgyN3FD?=
 =?utf-8?B?MWZxU2xqbmV6UWlZNXV3UGhoOG43QkVvaVl6a285YUNpT0R1Y0FhcFZoQTZ4?=
 =?utf-8?B?bVlRL2ppUDBEUXJZclJuTjVadEF0ckpPbzA1QnFWS3Z4T1pPNFkxWG15Rjg1?=
 =?utf-8?B?QktuREVCR3ArK0dBNGJXMG43VjMvMGoxQTFlK3R2QTc3UCs2Z1FDeTc3WEpU?=
 =?utf-8?B?eWJyT3RrWEUzUldmaEFRbzl1TWZpUzlqUWhhSklMZHIrUWJxL24wV2hZcjli?=
 =?utf-8?B?OW00Nmk0Y3AzUCtYUnc0WWU1OG1iY0pvTWlFVGh5TkhyUUpJQ042WXl0Nkpk?=
 =?utf-8?B?YTNuVmVHWWdhb3MrQWtwU0VxWjZGK1V0NlBEV0gvK2Jsc0F6WnYrT3U4TmZF?=
 =?utf-8?B?YUxOVlpOV0x5YmxCMFBFMUJmbTM5cUdvUjdsRGpnVFRPNWtjemRJczBlRm1m?=
 =?utf-8?B?OG8zQmpUYyt3SVpSOUNhci9NbTVza2RrenlMbDlPWHVaRExlaVIyRERBcmRm?=
 =?utf-8?B?TU8veFdtOWNwaVlrQ3l3ZE9SZTRSc0VpUmdvSDhTcUsyeklINzhPcm5NYVpL?=
 =?utf-8?B?ZTlNRFkwNTA1blpNYVhhRmVIaXgyWlczYVNmVkNjUlFpU2Jkazlwd1Ezc0c1?=
 =?utf-8?B?aVNJckh2QnpuVXlHeFdzVlNJRUs1WkEwLzZjZFdJNk5oaW13YXV3WlhlZm8x?=
 =?utf-8?B?TitoR1NvVW56VDEwclc4aUVhalJBS09QQ05rVmJqZXFRdmJxY1F4NnByK0Qy?=
 =?utf-8?B?dUx1MFRmYk9INU1EMWM4d085aFdyd2ppMjlYYlduSER1ZDZJM2VDSkY1eWlV?=
 =?utf-8?B?VE5QRmQzUmU0QWp2RmwvMGVqNGN4LzJCQWNqbVBzSHU1SHl2ampIUVZxNUJB?=
 =?utf-8?B?ek95UVl4QjlrVnJDWG13czdkcEcvcVBvUmVTM2tnbHZhRzIrVWxuQWNna0R5?=
 =?utf-8?B?d0ZPbWVMN0Jsa0xjb0kxcnVrTUs1RTRTZkJOYjBlK0p1d0s3elo1NnE4TlRL?=
 =?utf-8?B?NmdRR0hsZjA5YkZNMFFuTWlQdy85a2V4d3hRUW5BK0plVTIwRUlkMmE2YnZz?=
 =?utf-8?B?YW80YzlwVG9xajFIZHFqN21kQ21WaXRVVW1SMjhmRzdybS9FaWl3cFNDSlA2?=
 =?utf-8?B?WW5XdnBiRWl2cm9DMzNtb3RNL29BY3o5WlJ1RFFrVHduc0tybHBZaThYOHhw?=
 =?utf-8?B?Y1JUNWJ6M1RQYnJkM0NKbnVKM1hHNk5ZbmJyb3BaZ2FuNWdxUVE1RzVMaFRX?=
 =?utf-8?B?d0xad05hektlQUdzWGZJMk1YRk5MZ2VmZWhETUU0TUU4MllnRUhnU3lZalJv?=
 =?utf-8?B?amxNOGhZMGhqUUtpK1RlZUdYRTR2bVVEc1RHdnBFNjQyVmpUS3BSZnIzOG1Q?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350342ae-3518-4deb-f4a2-08dcc8e7a0f0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:33:54.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFfN0BXvgfTX+WbNeYmAgxiqs7uqTTU+lfc1JSM3/sktoZgEP4tyXPNFil7NLtB7EPXl47tpIaq+6kCdEHCc382sbtzxx0l1fNJrmNlWsw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Adding 100mhz & 200mhz pinmux support for uSDHC helps to enable
higher speed modes for SD (SDR50, DDR50, SDR104) and
eMMC (such as HS200, HS400/HS400ES).

Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 153 ++++++++++++++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |   4 +
 .../boot/dts/freescale/s32g274a-rdb2.dts      |   4 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 153 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |   4 +
 5 files changed, 318 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index fa054bfe7d5c..7be430b78c83 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -162,6 +162,159 @@ jtag-grp4 {
 					slew-rate = <166>;
 				};
 			};
+
+			pinctrl_usdhc0: usdhc0grp-pins {
+				usdhc0-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
+
+			pinctrl_usdhc0_100mhz: usdhc0-100mhzgrp-pins {
+				usdhc0-100mhz-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
+
+			pinctrl_usdhc0_200mhz: usdhc0-200mhzgrp-pins {
+				usdhc0-200mhz-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
 		};
 
 		uart0: serial@401c8000 {
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index dbe498798bd9..7ab917f547ef 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -34,6 +34,10 @@ &uart0 {
 };
 
 &usdhc0 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc0>;
+	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
 	disable-wp;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index ab1e5caaeae7..8739f63771bc 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -40,6 +40,10 @@ &uart1 {
 };
 
 &usdhc0 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc0>;
+	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
 	disable-wp;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index b4226a9143c8..6c572ffe37ca 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -219,6 +219,159 @@ jtag-grp4 {
 					slew-rate = <166>;
 				};
 			};
+
+			pinctrl_usdhc0: usdhc0grp-pins {
+				usdhc0-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
+
+			pinctrl_usdhc0_100mhz: usdhc0-100mhzgrp-pins {
+				usdhc0-100mhz-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
+
+			pinctrl_usdhc0_200mhz: usdhc0-200mhzgrp-pins {
+				usdhc0-200mhz-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
 		};
 
 		uart0: serial@401c8000 {
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 176e5af191c8..828e353455b5 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -40,6 +40,10 @@ &uart1 {
 };
 
 &usdhc0 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc0>;
+	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
 	bus-width = <8>;
 	disable-wp;
 	status = "okay";
-- 
2.45.2


