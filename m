Return-Path: <linux-kernel+bounces-261206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D793B41E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D130B241E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60CC15EFBF;
	Wed, 24 Jul 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BLTB+QqF"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77815ECF2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835988; cv=fail; b=HS8njK6Eh4LURRh6OJrQeUbdL/sUaZt0cK3U6EwvOOgkgMcNOJfG2nnyL89ht4CJZFSEH60AdtIGaD98HOE01C9lZe6CGdj2ZGtg2rNJ+siapu5OxFCXslbXGIM5++rHdbHcbdw6VAJAAA46JnpnemHp65gin5Ohcs90WtT6mg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835988; c=relaxed/simple;
	bh=An63rdNKf8siEFmhpUTOtrd2drbSwaCzp/D7qZONW80=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TyxIg/cpr3SnEjm6zbID34KVO67OEth6kUhOP7IsIKigKRzPLBGHPmbxzcvBKzIZjZtbPKN+gpKhZxxIZ0TGHppXP+QG2/Jf7mfWUR8X4fxs7TO+C+sV6oD4pxqg12iCceRCdAFAMOx9eUq/j0Jf7FsIH3uIqkZ+ravOrIrYB1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BLTB+QqF; arc=fail smtp.client-ip=40.107.104.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQm7r6eKPIpox7k2nk9B2vXKDz7HSXNGHcvBFZ32VNXgzZeD+lylIFqDwthvdG5uQAql65GRbHWQ/HYQt1HEWDXLMjgBRlZJCPxKoRYGVovJqEKB4eki4Ub5sjK+gDAcjhh6uHi44bnnEqNBKfa6OsT56HsDInJWEtLBPsx3B5tuvVjWgqUPE+FcfGXgXmldZ+uifafqBoxSuIeNWEPjEBEJjxgBjainBAdmD9gJox9r6gPpbleq1SkpogBNNEflg/dzO/eaIT5HR3nfgwyWtp4e4BWkK/xswFrlYXmFBLxcAbaafA63U/f8mvQk+Iow1kXQRaGoIY4jUXuk6hSKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDbmmbFgBxhKaOhHOUp/UpYi2/c+KPJaw5dvLjPdxrI=;
 b=CaPmVxcuYXaI0yv1EFbWMD2BvkLx075DQxb5diQ/AopRhexHWbTTs0lgPG/kThiDefCjtUXm6Oz7oJJHkk6TjDFuH4wUYgkbxB+EmaWub4QHoKMiC3RUOsrSKhx4xQAZnab3bmnTZ4qMOrww48YN86fefwMCAU3W1Sh5+4bxI9Ibt8vpC+aGWYf5lAt+7zs9Vt0WRVTSwa0y/P0Zs5WSW2pdJoE1LIhA1ABmiWvbjvYS7O0cTPO2OrgdCd95XcII1Ucj69gVvg7dyHUvkUmfZlF4Njc9IpApR/KZ7WSmV3QCWmk0oNpdO0gP5LhS1a5fzI/ZMhkS5VXEWN6gLHyEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDbmmbFgBxhKaOhHOUp/UpYi2/c+KPJaw5dvLjPdxrI=;
 b=BLTB+QqFIHV0LUuhH6wpcv7WXYqjiAohNhfnUBJO+ZKBTMmA/04/S2TMfR6gkYvg0tPWh+qN4stOcmHUYq1lSRUZqzbkiUrk9fTIIM3cdETwc1eKXb3jOcpc4JGx0eQG7xufI/Edq9KMG7q4k1R8Lbf/bhq7RjcRpiq2pwwXXT8IW72u6bDfYbtkjudymdxS+QWMajHCEOTEAFG7GYX8UgD46fxousDpWj+cZvG5ez/l0SLvCOz4wpA9l2cr7OJ5N8+RhWejKSteQepowrA59zZRjhlrf5ZyE/q84UYgY/XVidQuKAEoX85c3BMbqr8HqPOHPl/7qLvTpRGMPMB1fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 15:46:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 15:46:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Jul 2024 11:45:51 -0400
Subject: [PATCH 6/7] i3c: master: svc: use repeat start when IBI WIN
 happens
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-i3c_fix-v1-6-bfa500b023d6@nxp.com>
References: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
In-Reply-To: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721835962; l=3542;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=An63rdNKf8siEFmhpUTOtrd2drbSwaCzp/D7qZONW80=;
 b=2Ij2pePKr9oQIJVOK5bWSO3K/6+4NSzl+qUlw/3b+/5QPy6mx2HNAT9qefo7Huai9Z6dpS96z
 yXLEdc5qfmjAD9ku9AtHVx79TYOWb7bV+FPm6JHnWihNV4y/447WGzP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e7f5f4-906c-4875-9be9-08dcabf7c5af
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bnp3TWwxL0JkbnJWMElYZWp3VkpWKytReEgzSVp2ampGVlM3QURMM1lCWmNC?=
 =?utf-8?B?WmZnQU9QZWs1dmNkSDB2VDZPRm1oZEQvbllvWTZXSGJaaWxNUUl1ejczazl2?=
 =?utf-8?B?UXdOLzhWZ2FmZVptUCtleXpoMjhDV25GWXRuOHFJNlAxRVJJazhWcHJzamJ5?=
 =?utf-8?B?L0NvdlRSblp6OENFM2dMZlVmK1dMakk1aEQ4SzhvSXkyZ1VVUWI2L1B3TzJD?=
 =?utf-8?B?T0h6ZXc1eXhFYnduNU9kZldTWEhLTFFFRWFDSmlyNkloYlJYSU1vM1Q0Rmpa?=
 =?utf-8?B?blpwYmxuY0pDK0tLVE5EbmJMM1lSb1pVbThuY3dEY21uNS93NW5mdXM1Rmgz?=
 =?utf-8?B?ajNrNEVFYnRBNHZJbHF4QlNKVERtNHFqZ0ZOa2lDaVFmeFpzcU9YOHdLaDNk?=
 =?utf-8?B?b0FHZU9JREt5czMycXFvS0ZJZVdTVVB4V3pKL05iWWRncjJpWWJVQlFHcG9W?=
 =?utf-8?B?NFlDS3VGWlpxbmx5anhEL2k4WTFBbHBMcEViNEFyQTVsemNyWlIzeVdFQzNz?=
 =?utf-8?B?SUl6TU9SRTJKT1dTUTVTMjA5NS9FMDhocnRlQUJhdSs0T09HdlZqcm16MGN0?=
 =?utf-8?B?TEV1ZE1Ia1FqTEpPaHdsYTlyTHBUUjg4ZXYrTVJEU29BaGlta2F3dWRsa3FL?=
 =?utf-8?B?RzVDbEM0aVkwQnJaSUdWcURpUEpJNHRWYWhiUEFOdXpNdjBLd1h0QlhFcFZh?=
 =?utf-8?B?VjlHQWhhUjROZlR5c0ZXVXZpbEYxOEt5NzJNOEhNMTVxOE5FeGUvTnIyZUYr?=
 =?utf-8?B?UVBiQWNJTFJaRUJsbEQ4WW1nOXN2bWZ2aFNGTllxQmdJd1lqeXB6elMyNkhw?=
 =?utf-8?B?YU5vMnJYSnlqc29acVJlWk1iWW5sU2p1TkpoTnBPZkpxY3F3YmNEWXhjVm9i?=
 =?utf-8?B?NW1ldzBua0swUTBmMXBkQmU3dFpHVGpoeHpkQUhjb0VKa1phWGJ6WDE2UllF?=
 =?utf-8?B?WGJUM2k5U2hSdVJGaTFsaThWVkw0NVZRdzBFZHVlRkhYME1yYzduYzhaL0dP?=
 =?utf-8?B?TnJSZmJZWDM2cnZKRXVqa2Y3V21VcEpwSWhxeURLeE9RVERyaG1mTEQ0ZHQ4?=
 =?utf-8?B?dkI1bnpHcVhqV0VZWUVsSTlJUEg5bk1iRHdNenFSa3VyUjJOcVhtMms1V0dD?=
 =?utf-8?B?SStZbHRTN0loK3pGdU1LUXh1ZjdCUFV0Rlc3dTV1clAwRVZ5blVQdEs3M1dG?=
 =?utf-8?B?R0xTcjVCWGYvQzkraHM0SHYrZThwUkpIc3IyTU5xMnJNN0pFWDhocHpMRE5v?=
 =?utf-8?B?YWxRR0h3TlN0cjZ3dXFrMWtWRU9BUkNHRytVYTRGZ2lqZkZGQktvdXFRdjk1?=
 =?utf-8?B?Tm1LdEV5THJYdGNianEvZlpPdmFDNUxpQmlrT1hDNVpVWWlCNnNkMzZybmo2?=
 =?utf-8?B?NGJJK3ptR0xOZXFRMXlLdWF2S0VwcUFqdDhkWW1OenR3Nkx0WG54Nnd2NjdW?=
 =?utf-8?B?VDFmalU2THhaZU1TNGhoK2w1UGVoVWx5alRtdjJLMFpXd3dwUHRKRThpb2Fp?=
 =?utf-8?B?a2VoWFhrWERLVDFITy9ZRGoxOGFhTElkWEZ0VEh3a3NxelhXemVSQlJzTmF3?=
 =?utf-8?B?YXN6MHFJTnVxT0JUdVBDdnVTUmpCMDRkdVBINXpxRitER0JJZEZmRjAxTGV6?=
 =?utf-8?B?S1ZVSGs4QTZ2K1F0ZVpXN0QvaXpKaXVSb1h0QzZKWlh1VXVaYSsyV2JMU1N1?=
 =?utf-8?B?M0puYmZQbk9zZnpYeVY1VjA3MjhsZ2I3ZFZVdlhOUEFzWVRzNWozN3Z6RUp6?=
 =?utf-8?B?WFVISXcySm5PcVlaMlN1ZGlRNWx6T2MzSVZaOVVqNFJudnVWMW5zZlVGWHlr?=
 =?utf-8?B?Mld0UjVXNE1sblZZQlBodjZYQnVaUHZ2bVpKdWd0V0IyblhZOEJ3MzRicXpJ?=
 =?utf-8?B?QnNjNVhocGJMak1rdjNXcGZ0S0krUkI4OU81VWZLZWZ0bWc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QXRwbHhCWTl1ZDM1eDdFYklNbGNtdVdHK0lQQzlWY01pNUVZOEtWeXpCclYr?=
 =?utf-8?B?ZlhjTkxYY2RsMytqZkdoUVhYV2VVbmViOXJwVWtuV0I0cm01ZWozRVlxRTQy?=
 =?utf-8?B?b2RYTURSV1hiYUZPdkhkeDBrZWNSNGhSTmNFM0RUNm8xaFMyNVdjcFdMdEhx?=
 =?utf-8?B?YVJlSE52S2NIUEZLV0padmRDR0ZTeUlSSmR3M2NxZjVDamlVQndXd3BXMi9T?=
 =?utf-8?B?ejBQRHIwYU1taXhzcVFKTlVURFJSVXIwcHcrNy9UempjS0dDSGhNcnBQbkF4?=
 =?utf-8?B?NjVJYktjbGx3QXR6d2tSdXczYnFlc0g1VTZqVERZR0hJOWRLdHJoNXMvSlVi?=
 =?utf-8?B?MDlTU1lYZll4emtzSjZoSFFsUWYxVlNya2FSRDM1c2YvREFFMFFrWXdwenNl?=
 =?utf-8?B?SVJZdzduMkhXUi9Qd3o4Q1g4NjdnTm9JejhoZjdNaUp2R09weWtqenFVU3Qx?=
 =?utf-8?B?TFVOMU4wQjFCUFhxRkFsd3F4ZWlZOFFMWFlSNlNUSjNHaVdaSmNhQ3RXVFha?=
 =?utf-8?B?VVhCTGxTSlY1ZENKSTkrSjkwYlFzV1Q3d0V3UEo4MHVreFplL05uN1R3bmJ3?=
 =?utf-8?B?bkcwd25PczRTQU96SWxRRzI4SWlWSXBvQXlUNEhRek90bllLTXJuUDB5N0ha?=
 =?utf-8?B?S2VxM21XUjJuaWYwTGp5VEVKZHVEUHlxdVVab3RRcElNZXRBV1pESSs2V05M?=
 =?utf-8?B?aHUreE9lUy9BNnFzRnlaaDNSNHUvbVpRTFJUZkkxWHYwbFRyRFpIaUpRcUt5?=
 =?utf-8?B?LytQTmFYZHF6TUZreHVzM0RzYnRiQ1M0L1FNL0M2T0RRcjM4VHgyZHdFUkZC?=
 =?utf-8?B?NkVIMUVqZFJYSzBHcUtEbDBVa2M2STY2YjZueE9Eckc2MmVHTDU1YW55ZGRU?=
 =?utf-8?B?WDkvQ3hsUFcwTGZ1MFdlYmc0VWRzNmw0ZlpSQ1cxS3NGYnJmYWZEWHo0WSt0?=
 =?utf-8?B?SjRGWFZmaEtJYzA0QXE2NVVQNFlXV2FtajJxdU1UMTB0K3JuSUd5Q0VrTWFi?=
 =?utf-8?B?SThMeXJaaWtRc0NhQ05ObytmMEZzSG5oby93UDFaMUxwUUY3YTZiTHdhdHNM?=
 =?utf-8?B?T3FBN1FkZ0VYYzVha2xiajJ3NHB6cEliblhFT3JyNjNGZm9VNE9Uekp4QWdT?=
 =?utf-8?B?RnpUVHFtU3l3eHhuR1p6MnZ5TWVobUFHcWZRT0F2MzBKaDdhR3JRMFpSQm1a?=
 =?utf-8?B?MUJ0NWI3VkM1S1NEYmhETGFSNUZrbm5LNGVWNUppOC9NUlcybFpmRHNNUjds?=
 =?utf-8?B?QTJ4RG5sYzJBMEZ3UmxZYTlkQkhWQzdtZVJoRFMwSlRydXRBWmVqUy85TzhX?=
 =?utf-8?B?MmM0dVArbDk5NDJzMEFNVGNFRjNUOVNIVXZLS1Fqcjl6V1lLcmFmWWVPaU9W?=
 =?utf-8?B?c1hiYUpEOFdKTm9tL090eGNzekF5dER6cGlrK0dzT3RlT1hQOWpoak4yeUZq?=
 =?utf-8?B?ZkNTcktrYjNDK0NTZmpaVjlra0FMWjM2MERMOFdiZkorVjg1YkNiajhoS0Jv?=
 =?utf-8?B?Ukl6THNMaEF5UkVqaGJRbWppS21ETW1CT2ZHVDhTelNabWZHOGpHU3lBRS9s?=
 =?utf-8?B?N1VvVjRYRDNLQVRkT3J4ejFzaEx0R2J0eVVKQytDa0lkM2NvY1dPVEZ0Tm9Z?=
 =?utf-8?B?R1BUWTl0ZHlYTnd4SGpjYys1d2d3ZHduSW13akF2NXVKbm9jR2NNOGlURCth?=
 =?utf-8?B?dXNPakJlWWl1c3lVeTRaZDZhVk5kb0JLb0xxcllBS3grTVFmZm5YaGJjMmho?=
 =?utf-8?B?THQwN3l0QmZOQWdmYUhtNUpubHgwU3VMZFQvRFgrT1FtV1JjL0FPRnZIRzFV?=
 =?utf-8?B?T3pHM0I2QzNpWEpFeVpkaXVLeTlsbFRYRStOUTgvdzQ2MWxqNTk5Uk5oN3Y2?=
 =?utf-8?B?K2NIajdIM2ZDVElXUE5MTXZTU0F2dHB0eTNieUZTcFZOY0VnTWRxY2RKU3do?=
 =?utf-8?B?elY0aW5raFRSNXcvL3J5M2F1TEtyOUhRdW5rbGtTazE4RlozdGlkSzFkY1kw?=
 =?utf-8?B?aWYycEFJZEw3Zm5SdTloTGE0SWU4L2pBYW5zVkoxSERwV1BLUUdSclNmU0Jl?=
 =?utf-8?B?a2xETEorN3QrMzl5OSt4ek0zMld2L0RaQmJIaitzSEl6Zllxd0xjcm5jVUhw?=
 =?utf-8?Q?V9HrB6ZaZ7kjhWjgzuSCBO8Z8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e7f5f4-906c-4875-9be9-08dcabf7c5af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:46:24.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lY0tAXpsv75WymS0eLrDwuv4sUQHtTHvTGtmzO5idElAlJeh2Htli3fM+jSsMS4/ZDITZyqG9TP21kw7XAJpkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963

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


