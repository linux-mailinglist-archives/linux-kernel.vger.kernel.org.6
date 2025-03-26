Return-Path: <linux-kernel+bounces-576589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF5A71177
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82ED188B349
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAFD19D892;
	Wed, 26 Mar 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lwyNyr6u";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lwyNyr6u"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013027.outbound.protection.outlook.com [52.101.67.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F43145B3F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.27
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974510; cv=fail; b=RFMABQpItHX0VuUl/ggLT6tln8HbslGZzoKw0tp2cxLeNBJs/djXk96t6YDle39Xzsr3/7JfWWCP68xLfdEGetKLubPr3Rv/dsndmcdGckVccqkuyEk9UggelnzhBTphFCke7qqG0jxfAm+wefsQG8LS/LYavrRWsAaAcNuzqhg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974510; c=relaxed/simple;
	bh=nBlKdsT5It+jNJYfti54Jukz85IcxHj8bypRq7FhWwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqNrGJYq6ptAXCA7GswQyhxWFbKD3IxlzirOXIB/wkSjR8zahn7yGbzT4yjSgDwsYySnFR3LuaRqfM4sT/owoUNsFkquvDUUqILN1oK9KLF8jn0g30dvdgyZ3hb0sPrwnWHUVhGslgjuhTSCiM69zKTEzDLKLWdAXVnTUjCHoBQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lwyNyr6u; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lwyNyr6u; arc=fail smtp.client-ip=52.101.67.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YOAT4sLsF9Osvhz0CXfzUp5DlgkUKW23ftiZlvzDZgTPTrJMtNt34WyVTfMo898mgfpR4sc/0mQFcA2RThqKcFRHcXysAGKkEldY1ZCJ/qO34XgxRxONpqENc2x/Y1940ZFJJFqOLeUo4xL2LMZtpPNZiFiPekICHcsPwHYFDyp0+0RW3tc1/jFIBc+TOMkWd+cdfp/KwRW2ZlmfNeGhXk6smZEaSkOEsNBwe6nDuhFK/t+1lEIhSUuLaNK4oFPoZrtYV1m8u1F3dYysV2t2o88kxaCqaCaL/DZs4fySSKhYWMxpaqHPDCfmA9dAHi6SAlXr81YQ/8zBKKFVKix4dw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Smo1yMClG7Apyr2ivxqXNn2f/uPP4ibWkB5ZBKy+5o=;
 b=qW0tIQq8bAS+BLoZmz0oHveu6Z2nd5P8cL+u2bSRzdrzRwEz6BWfbPFpzGqi+0/qJXKFgLoCxWXr+siranWrz3AkumcfeG68TxcTFU+JxbVlOZqAek3kSio7p3CQl3SJgqgEREPBJv1dupfLqnNaLeJbLoBUSJ/8d22317A6ogcHT5jgLwXF2YF0CM6R7xBkFKH+o+Pfaap66W2r4DQjJo6tMF1oHOedCUZOCHYvkhg90xdoSiwWQwRodDQFQiUjcKNoZgEDRLG5AfN0CDvwfxF5SM6138+6YhXn8sxjvDxMYdmG/tS69PF5PErbfq8Zwcvo9I3yuWqF8Nwh11IkEQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Smo1yMClG7Apyr2ivxqXNn2f/uPP4ibWkB5ZBKy+5o=;
 b=lwyNyr6upHgUI88v9PgCqZtnvd2qZwCqbjGKb+0THUPkKPBATUuBakSC2RbGNJmKU5hEDtIHMzDN7MOw2891Tg2bYI8AFEurJhsjnSAkIgzR2NCPZL/WC5C3Yu4Lb5cenyoqdLp5af6slq0pLAQqpYG3ipcqvDj1KobT0GLiHs0=
Received: from AS8PR04CA0121.eurprd04.prod.outlook.com (2603:10a6:20b:127::6)
 by GV2PR08MB8342.eurprd08.prod.outlook.com (2603:10a6:150:bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 07:35:01 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:127:cafe::7e) by AS8PR04CA0121.outlook.office365.com
 (2603:10a6:20b:127::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 07:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Wed, 26 Mar 2025 07:35:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUunF5QkcLZn8qfi4Gr+Yl+HcgW1EQIrMdAPDmgZT+VpPAGjYTc09hVxO/abr63jHvu13BuKjVtHOVVnpfj95PggwjW0rqHtSxE2D+TW7kk+YwUd4He5DU1wyhgb//Mx4D3qRBNku/YLJ8HTZ4MFjmx2lZrYxuGbC5/jYcp3ruj3WFe4QPXcegjMX6KENfDnuTwMjgA2LPY4H2YXS7wAplpupfqAaClpcFA/mspEb6UaflRguO+XRx5YkDpLwmCKkNRsfqjoi0aFSLdfeX2TeFHhX4gmlxXimXp0T7omB8Bx4NG7gc995UvuYlzDU5DjCL7AVWNY6Bhg2q9/iID8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Smo1yMClG7Apyr2ivxqXNn2f/uPP4ibWkB5ZBKy+5o=;
 b=xbobiEumr+qKDKWHVss7eQiHArBg2HXUMQ3K6KUDVhr+SlZmkKHExwhfSIbWIxa88ob/a3ec4IKH7OeTwqdHQlwepaW7NFl5NvbAIKTUauAjVcM89gMTI7bnjJvDw/C4DjrWi3XBRW/Mhrevb/s2rCSMm3LBXSUdaHk5ahovStLLe79kDAhOkmt10gR5Wzs/hF41AmxDzyWPl2Wyo/2wLsJCiJ4IisU0YhKvZ79DM7XkA4ArtrVSS9fAezPO4OgkccmVxh6qhwM7HZ6m4kOhR4bOWXE5SmpXeBEEtNTEQ3Rh0aOr7/+y33ZEvs5PqqtxWNxWNApR8AkLqxXjBPlYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Smo1yMClG7Apyr2ivxqXNn2f/uPP4ibWkB5ZBKy+5o=;
 b=lwyNyr6upHgUI88v9PgCqZtnvd2qZwCqbjGKb+0THUPkKPBATUuBakSC2RbGNJmKU5hEDtIHMzDN7MOw2891Tg2bYI8AFEurJhsjnSAkIgzR2NCPZL/WC5C3Yu4Lb5cenyoqdLp5af6slq0pLAQqpYG3ipcqvDj1KobT0GLiHs0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB10953.eurprd08.prod.outlook.com
 (2603:10a6:150:1f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 07:34:28 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 07:34:28 +0000
Date: Wed, 26 Mar 2025 07:34:25 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: suzuki.poulose@arm.com, mike.leach@linaro.org, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coresight: prevent deactivate active config while
 enabling the config
Message-ID: <Z+OuATAe31GbcKZ2@e129823.arm.com>
References: <20250324191740.64964-1-yeoreum.yun@arm.com>
 <20250325151803.GD604566@e132581.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325151803.GD604566@e132581.arm.com>
X-ClientProxiedBy: LO4P302CA0034.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB10953:EE_|AM1PEPF000252DB:EE_|GV2PR08MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7e3e03-2b9e-45d0-d146-08dd6c38b764
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?xGY2+yYXBeBL8ZwwTr1BBdr6DjbgTHa/X6zf8EUwe2nC707waiNGgqDWrTig?=
 =?us-ascii?Q?xfMrNteHmfqa0skDgGjlhTXwvkvgS/olyDFjv/0j8EAKejjTv88hgptS4ntZ?=
 =?us-ascii?Q?w1Qud8sMMBk6EoBBNUIVi6RrC/YqMeRtzNp5kO7BFTLrHzo3dcSBU/PHdBd3?=
 =?us-ascii?Q?IHfYz3JO+LwNqg4byqeuuzf0V301bshcpWx+hgng8z+y/R0qIj7L88PaarbC?=
 =?us-ascii?Q?Jvs/xWOHfWqLZXrciCruQ+2bLwfjTzTsCHIKZcUd3ClirmMM/e6Rsxt4mCSh?=
 =?us-ascii?Q?h7ve9ZgHpNKEt/jOR815ll7WwctOGzOpxoJAcooLERgEL/XhtUCzpqT/U3l7?=
 =?us-ascii?Q?ukqBGNQIQ4PU5U/3hNbwaFbglAEl+6/R36nXFvG4xfNanI5QhcH5Ycfg/X1g?=
 =?us-ascii?Q?sxPzFNLxXOfdV2V+egwco9GV+nKTQ5zmF9mI9BqDuV8zhxnpol/06WjiAMtM?=
 =?us-ascii?Q?gQdCIABEXgpwUinJCV03KbDpH2eGAtNQH+/+gaU1ff8g7FSjgI7wlQXXEzeM?=
 =?us-ascii?Q?BLGls6WcpO7ytorUK2mMeRuwWPX2daXdq5vNpmygiSY/4l4zFHhXhDuhZMNp?=
 =?us-ascii?Q?eTdeFwR0OV6XT4J1nz+qFJkO4wvaRGk+o+z0QKZplzDeTn0l/kKz+9EZg8YK?=
 =?us-ascii?Q?luTEdSoguJvoUratthHckpPBF5zXyt4Tj06W4bjsfCxvpT93VFYpxsx/fjC2?=
 =?us-ascii?Q?q9qwE3MGldQdvSkgaJi6mhkap+RZdi3R3ud1o7GADapDlWbJAZdm3wFpv0Pm?=
 =?us-ascii?Q?nCNYMA9iXbeRqDhjKCa17COPhCtU77Jym49ET+N0tlZwWAOQe8OWckLTzxq4?=
 =?us-ascii?Q?yLoA/Rgn3yTuNxA7bVHWVH9KwtQIE00TBN1zZU2SN02uRN5qPZGzBxfOItSp?=
 =?us-ascii?Q?b6W0xHScUye+lftUXpqZJBusPo2ZtQE4o54OEJ0I3BQZrg5cmpQc9qsgKD2T?=
 =?us-ascii?Q?flF/0CnFnMxLWhcjBkfgMdcsr4rjjH6fcHsIKn9FjVfpNneCi1dDBwyhWejH?=
 =?us-ascii?Q?jFq9F4wTuRR0ST3qlXsTOh3259ks/mpXmVwM57FtNxS5gYLVbT7w5rmU9uBw?=
 =?us-ascii?Q?q74xDv9Ozu67MjOKR+ktWtwxXHGLsIPukzvxwlPt+offy4k7oHQAeThq1yi3?=
 =?us-ascii?Q?h2HRqlkA1gNV59GWoyud3OcwZlO75w1nfYxMkRAvYmFFDXd78GJeie0rWJiE?=
 =?us-ascii?Q?BMP833YQOCtOJwYsk07okvHA47xoTaRFp4898H6C0PqNw5jag3WrUssZ8/vt?=
 =?us-ascii?Q?JrnnCZN/oN3fixZgr9fU7BHityYzxDIkqsfAF6temM+2QlbtD5kIwEOIrGSs?=
 =?us-ascii?Q?YoOdiTpgUiZe4zjrPz2PU7maOZ23ILTeAp3bkBsoQxHEZY59E2c7kG0azOar?=
 =?us-ascii?Q?NTVsjVRiSw6bo60c0+zJYxAsmxwZ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10953
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b8ebcc5c-eb50-49ae-1b8c-08dd6c38a410
NoDisclaimer: true
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0oQP7B2lyOHSr7AeCFC05m+xbVCqCEu3S0psgCYy9brl6rfTuQPkmLWyhYl2?=
 =?us-ascii?Q?14in5U4c82D1LT+Z5J4UshSSp4yv6vSQLEkUqWDqbZbQIBQSuPONjCv3idzm?=
 =?us-ascii?Q?hpVh2JrS/pJWqI8CcSXgkuob5Ij/aVJvWoEVPvgeNY7LuPxDj/DA8qm7k9SE?=
 =?us-ascii?Q?z3apWooxpPllkqPYha7bqjCLcGfTR+FJl3XWnOm1w3vSKFbmQaYkVnaNRiJr?=
 =?us-ascii?Q?tvdUcYLnRhf32jV/6t6YX5MhOOopkp41Z8MrmZ0UxHRXQFO+14c1HIkzrhgM?=
 =?us-ascii?Q?s3QrnEPDx/G8mBgCNu5yiKXuZs35GFb6Df9sfzpMU3s/u2WwWbQhYimDnhha?=
 =?us-ascii?Q?GZ9CRcbr1wBWaBI1aBDJGIKZOluBSQKZhnJKU8V8PrkQ08euEcl0xWvaARFL?=
 =?us-ascii?Q?DBVsDczUVTi9/JNEj4s+bAK/EtQlD6Hhn+hDUYsGWc6K4V6y+Pg5c70y4uJ/?=
 =?us-ascii?Q?KX1JXszs4uCgppi8shkUnEaQP20eMI2XwymspJ11k6DJFVRrLZ9GMJRs7iyY?=
 =?us-ascii?Q?2zGdYcwRAAKmaXP/JQHD7kcXLEWl+sVV1inSsPjoKQ0Oy9N47zpKiny7qbIY?=
 =?us-ascii?Q?JZO97hSAlXK0tJN4hWD5vISU0TxACDQ56EI+5vRFREhYgPk+D5y3lC8hmkGk?=
 =?us-ascii?Q?WHu94PVvGdm9+qL355Sxvn8TFm0KGbzapzJ+HYcpZZrgo7MQy4SgW1Q1AGZa?=
 =?us-ascii?Q?U/3VaVdqhKHiITlIMHgJtZ1BtJ+bVPyNy5q7WVqVyxgRuWDRWMalAbsqQhQf?=
 =?us-ascii?Q?HEBPiUUd2cWNYgsJBO5QT0whhUwqHzZPe7n51qiDKCqs2d8NVffkSZu86PmX?=
 =?us-ascii?Q?E8PplEb4SfJYAZdMbA9QR/1LVC5mxYeqL2G/GcbnS1x9zynCg/DrjjZ69NrP?=
 =?us-ascii?Q?S/DEqHUYouiaBf5dd4/5ksQfvdw9xiDrM/Du2uxpBuc18Lt5sdWJKnz0SFt+?=
 =?us-ascii?Q?L1+TZK4oagLd8zSJnMWDuAc8w4FFYbxg+6y/JM4k1ho8/PdsX59CBFUsr8rf?=
 =?us-ascii?Q?beFOsditaNFTVQY5ZAFzfnjAOj+9xG5NFOfnB7xvrrPpFnRll3hVMdgP5Ybm?=
 =?us-ascii?Q?2POJXEUgaAeCMmDbh4RP+gmgs7aSJ9skLE/AH+CxTpPZmviFhN9fo/4UBlCV?=
 =?us-ascii?Q?T6R0hYMpbyyzObDbiWSjvPjO+ObnmY54ZqxKfP6NFN8RaJkCbmf/yLCJuq64?=
 =?us-ascii?Q?uVTgk0VfCr5AKZ8XbaBB4+A9r8/2eQuGYSA057y9efh+mrHOjCrrJSIRGZ5T?=
 =?us-ascii?Q?dc70yyycjcqnthkSMzV6aNio5/+k7OpqvGmyCy1+s9obuK71cLcJSk59rIag?=
 =?us-ascii?Q?pDSWiOrk+d8UUL8aGWz5S1BT/ZqiVbi7NhrV6PvpgQT+m0cNCaKR3GjZZLrG?=
 =?us-ascii?Q?h9ymFTrNbMH5R3FqeQJN8CRVkjwbgpCKFUG5Dkka3JOL9Dwy1pH5xyY4ObB6?=
 =?us-ascii?Q?/eGnZWkm/v5a9j4CdK1aHfpO0+x85d76Z4FX24TUzlk84eBGNJaFfJQG3M1C?=
 =?us-ascii?Q?p/U3MHT3VPczjDg=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 07:35:00.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7e3e03-2b9e-45d0-d146-08dd6c38b764
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8342

Hi Leo,

> > While enable active config via cscfg_csdev_enable_active_config(),
> > active config could be deactivated via configfs' sysfs interface.
> > This could make UAF issue in below scenario:
> >
> > CPU0                                          CPU1
> > (sysfs enable)                                load module
> >                                               cscfg_load_config_sets()
> >                                               activate config. // sysfs
> >                                               (sys_active_cnt == 1)
> > ...
> > cscfg_csdev_enable_active_config()
> >   lock(csdev->cscfg_csdev_lock)
> >   // here load config activate by CPU1
> >   unlock(csdev->cscfg_csdev_lock)
> >
> >                                               deactivate config // sysfs
> >                                               (sys_activec_cnt == 0)
> >                                               cscfg_unload_config_sets()
> >                                               unload module
> >
> >   // access to config_desc which freed
> >   // while unloading module.
> >   cfs_csdev_enable_config
>
> I am not sure if this flow can happen.  CoreSight configfs feature is
> integrated into the CoreSight core layer, and the other CoreSight
> modules are dependent on it.
>
> For example, if the ETM4x module is not removed, the kernel module
> management will natually prevent the CoreSight core module from being
> removed.
>

No. Suppose some user writes custom config module for etm4x using
cscfg_load_config_sets() cscfg_unload_config_sets() in init/exit of
module function.

Although it's rare case but it can happen while  above 2 interfaces are
EXPORTED.

> > To address this, use cscfg_config_desc's active_cnt as a reference count
> > which will be holded when
> >     - activate the config.
> >     - enable the activated config.
> > and put the module reference when config_active_cnt == 0.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> > Since v3:
> >   - Remove enable arguments in cscfg_config_desc_get() (from Mike).
> >   - https://lore.kernel.org/all/20250109171956.3535294-1-yeoreum.yun@arm.com/
> > ---
> >  .../hwtracing/coresight/coresight-config.h    |  2 +-
> >  .../coresight/coresight-etm4x-core.c          |  3 ++
> >  .../hwtracing/coresight/coresight-syscfg.c    | 52 +++++++++++++------
> >  3 files changed, 41 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > index b9ebc9fcfb7f..90fd937d3bd8 100644
> > --- a/drivers/hwtracing/coresight/coresight-config.h
> > +++ b/drivers/hwtracing/coresight/coresight-config.h
> > @@ -228,7 +228,7 @@ struct cscfg_feature_csdev {
> >   * @feats_csdev:references to the device features to enable.
> >   */
> >  struct cscfg_config_csdev {
> > -	const struct cscfg_config_desc *config_desc;
> > +	struct cscfg_config_desc *config_desc;
> >  	struct coresight_device *csdev;
> >  	bool enabled;
> >  	struct list_head node;
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index e5972f16abff..ef96028fa56b 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1020,6 +1020,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
> >  	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
> >
> >  	raw_spin_unlock(&drvdata->spinlock);
> > +
> > +	cscfg_csdev_disable_active_config(csdev);
> > +
>
> In general, we need to split changes into several patches if each
> addresses a different issue.  From my understanding, the change above is
> to fix missing to disable config when disable Sysfs mode.
>
> If so, could we use a seperate patch for this change?
>

It's not a differnt issue. Without this line, the active count wouldn't
decrese and it raise another issue -- unloadable moudle for active_cnt :(
So I think it should be included in this patch.

> >  	cpus_read_unlock();
> >
> >  	/*
> > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> > index a70c1454b410..6d8c212ad434 100644
> > --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> > +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> > @@ -391,14 +391,17 @@ static void cscfg_owner_put(struct cscfg_load_owner_info *owner_info)
> >  static void cscfg_remove_owned_csdev_configs(struct coresight_device *csdev, void *load_owner)
> >  {
> >  	struct cscfg_config_csdev *config_csdev, *tmp;
> > +	unsigned long flags;
> >
> >  	if (list_empty(&csdev->config_csdev_list))
> >  		return;
> >
> > +	raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>
> I think we should use spinlock to guard the condition checking
> list_empty().
>
> Here the race condition is the 'config_csdev_list' list and
> configurations on the list.  For atomicity, we should use lock to
> protect any operations on the list (read, add, delete, etc).

Interesting... Would you let me know which race it is?
here to check list_empty(), it already guarded with "cscfg_mutex".
However list_del() is special case because iterating config_csdev_list
can be done without cscfg_mutex -- see
cscfg_csdev_enable_active_config().
This gurad with spinlock purpose to guard race unloading and
get the config in cscfg_csdev_enable_active_config()
(Please see my response below...).

the emptiness of config_csdev_list is guarded with cscfg_mutex.
therefore, It seems enough to guard iterating part with spinlock :)

> A side topic, as here it adds locks for protecting 'config_csdev_list',
> I am wandering why we do not do the same thing for
> 'feature_csdev_list' (See cscfg_remove_owned_csdev_features() and
> cscfg_get_feat_csdev()).

In case of feature, It's okay since it couldn't be accessed when it
gets failed to get related config.

When we see cscfg_csdev_enable_active_config(), the config could be
accessed without cscfg_mutex lock. so the config need to be guarded with
spin_lock otherwise it could be acquired while unload module
(after get active_cnt in search logic cscfg_csdev_enable_active_config()
and other running unloading process)

But feature list is depends on config, If config is safe from
load/unload, this is not an issue so we don't need it.

Thanks for your review!

> >  	list_for_each_entry_safe(config_csdev, tmp, &csdev->config_csdev_list, node) {
> >  		if (config_csdev->config_desc->load_owner == load_owner)
> >  			list_del(&config_csdev->node);
> >  	}
> > +	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> >  }
> >
> >  static void cscfg_remove_owned_csdev_features(struct coresight_device *csdev, void *load_owner)
> > @@ -867,6 +870,25 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> >  }
> >  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> >
> > +static bool cscfg_config_desc_get(struct cscfg_config_desc *config_desc)
> > +{
> > +	if (!atomic_fetch_inc(&config_desc->active_cnt)) {
> > +		/* must ensure that config cannot be unloaded in use */
> > +		if (unlikely(cscfg_owner_get(config_desc->load_owner))) {
> > +			atomic_dec(&config_desc->active_cnt);
> > +			return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static void cscfg_config_desc_put(struct cscfg_config_desc *config_desc)
> > +{
> > +	if (!atomic_dec_return(&config_desc->active_cnt))
> > +		cscfg_owner_put(config_desc->load_owner);
> > +}
> > +
> >  /*
> >   * This activate configuration for either perf or sysfs. Perf can have multiple
> >   * active configs, selected per event, sysfs is limited to one.
> > @@ -890,22 +912,17 @@ static int _cscfg_activate_config(unsigned long cfg_hash)
> >  			if (config_desc->available == false)
> >  				return -EBUSY;
> >
> > -			/* must ensure that config cannot be unloaded in use */
> > -			err = cscfg_owner_get(config_desc->load_owner);
> > -			if (err)
> > +			if (!cscfg_config_desc_get(config_desc)) {
> > +				err = -EINVAL;
> >  				break;
> > +			}
> > +
> >  			/*
> >  			 * increment the global active count - control changes to
> >  			 * active configurations
> >  			 */
> >  			atomic_inc(&cscfg_mgr->sys_active_cnt);
>
> Seems to me, it is more reasonable to use 'sys_active_cnt' to acquire
> the module reference instead of 'config_desc->active_cnt'.  The reason
> is 'sys_active_cnt' is a global counter.
>
> > -			/*
> > -			 * mark the descriptor as active so enable config on a
> > -			 * device instance will use it
> > -			 */
> > -			atomic_inc(&config_desc->active_cnt);
> > -
> >  			err = 0;
> >  			dev_dbg(cscfg_device(), "Activate config %s.\n", config_desc->name);
> >  			break;
> > @@ -920,9 +937,8 @@ static void _cscfg_deactivate_config(unsigned long cfg_hash)
> >
> >  	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> >  		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> > -			atomic_dec(&config_desc->active_cnt);
> >  			atomic_dec(&cscfg_mgr->sys_active_cnt);
> > -			cscfg_owner_put(config_desc->load_owner);
> > +			cscfg_config_desc_put(config_desc);
> >  			dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
> >  			break;
> >  		}
> > @@ -1047,7 +1063,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> >  				     unsigned long cfg_hash, int preset)
> >  {
> >  	struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> > -	const struct cscfg_config_desc *config_desc;
> > +	struct cscfg_config_desc *config_desc;
> >  	unsigned long flags;
> >  	int err = 0;
> >
> > @@ -1062,8 +1078,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> >  	raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> >  	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> >  		config_desc = config_csdev_item->config_desc;
> > -		if ((atomic_read(&config_desc->active_cnt)) &&
> > -		    ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> > +		if (((unsigned long)config_desc->event_ea->var == cfg_hash) &&
> > +				cscfg_config_desc_get(config_desc)) {
>
> This seems to me not right.  Why a config descriptor is get in multiple
> places?  One time getting a config descriptor is in
> _cscfg_activate_config(), another is at here.
>
> To be honest, I am not clear what is the difference between 'activate'
> config and 'enable active' config.  Literally, I think we only need to
> acquire the config at its creating phase (maybe match to activate
> config?).
>
> >  			config_csdev_active = config_csdev_item;
> >  			csdev->active_cscfg_ctxt = (void *)config_csdev_active;
> >  			break;
> > @@ -1097,7 +1113,11 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> >  				err = -EBUSY;
> >  			raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> >  		}
> > +
> > +		if (err)
> > +			cscfg_config_desc_put(config_desc);
> >  	}
> > +
> >  	return err;
> >  }
> >  EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> > @@ -1136,8 +1156,10 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> >  	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> >
> >  	/* true if there was an enabled active config */
> > -	if (config_csdev)
> > +	if (config_csdev) {
> >  		cscfg_csdev_disable_config(config_csdev);
> > +		cscfg_config_desc_put(config_csdev->config_desc);
> > +	}
> >  }
> >  EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> >
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >

