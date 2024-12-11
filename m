Return-Path: <linux-kernel+bounces-441698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDB9ED2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706F71882C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178841DED5F;
	Wed, 11 Dec 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c544+nLq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c544+nLq"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A91DE884
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935885; cv=fail; b=Hyyj49e2l03O+dMR/ewiSflzihMxF/45hriidhU0wndYnOA+UzaxUIkgd2NeNjUNKF70KC6uPEm6eEP1yKAeysnB5sUn8aq3/ni7w30k2pZYYh9d0nD51qdU2Nn6eHs7BwE+oGckUmJar2rZ6tqyY20aW8HKLiFI9WrjD+0AT80=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935885; c=relaxed/simple;
	bh=Zn4RCl/AIGzC7PJ9cB3X4Z1HxysGGmtlJ6WvvSrXrXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bgr+z5P8X9YziJebmMd6iJyabCjcZYt5VSIGe6YM8bi6wiJ4VFsUMzw3Zwl63NB5Hiz6nYEUfchBm7EPa0N4oZn8wbprR8Pd6gZAAet+2Pky52mS+jBdaanJNusvhjf4MxTjBN+fs93skCT8oNwjlq1fhoFjWbv/V6ib5dT27rw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c544+nLq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c544+nLq; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cI3PpuuNFt9cRZDBfpCbX1BZhaHdn4KU9Ydrx7CMaAFGBAf5JHuozOjpmCdafLKD1KjVGluvMx4miGeyREnu4HBW+LAPUkXGnXqc0hS8w89VV6KKgMWe84p784p1qa7V7slEyDk9PfnWKjUnfjo2/9lFDHSW5+THR+j8g/sM1LFfJeDJy26g3XzB0drfoG3YEcnq392eBd4Uv40hnrXwWf2nVYli+9HVi5hn+YNOWHAErxfhat6ONm57+MT2EJ5+lyBhwxDSVwR/ivHnncK2m/GwFWm/fFtP6yU9Hsms5hFQITtGQQUanps8g3injg6ODxiATCHxFCJye//JTa7RrA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah54vksIAL1XBn9oTvm0ntr07MfGjKJQMzj3zX/uYF8=;
 b=epLDHZoABz3E+Hx9vB0NBKQ2Q8Qnt4lGE5LgUJBiFk77fDvsORO8jCsq0Fn2mrcJTVvfgVhjq3VC83taQtVvXcim2aAVibiABRNcSgP6mlamTvmGakXTO0rWcmiguQMHjMmHY/22YZi5N2igU7iX/JFiAIKaaTPlPaDjsJkIvz9Zvntftm1+s4eBkDEqhtKkQLwYQBwgoqC9AA0vvFIxYpyi6HyvJexkd4VZa7EYlRpcHlHkJH37V+TiczixVpjtBGlMmkjP99qPT1NSe+MhDxufHORkFIqJDSHm4P0wq0dG6Yn5PBZXeMMhi+MTCUXE0GZF9vaOFY1Dlws+kYEwiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah54vksIAL1XBn9oTvm0ntr07MfGjKJQMzj3zX/uYF8=;
 b=c544+nLqQdNQRuBgKSvafcV/FzYJa/mPg6CJAKhOrBTQLVYg4S7ELKX4aADWQ5QW1EnUti1gU34pf3dgyAImpFY73pvgPilAJXQWsdcDuzVPI9M5e2ue0d2PFgNmWjown+/wrT5SzfIAyM2qq4S0MFxRfqylOFTDguzZmIQRTHo=
Received: from PA7P264CA0271.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:373::13)
 by AS8PR08MB5976.eurprd08.prod.outlook.com (2603:10a6:20b:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:51:16 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:102:373:cafe::57) by PA7P264CA0271.outlook.office365.com
 (2603:10a6:102:373::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 16:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 11 Dec 2024 16:51:16 +0000
Received: ("Tessian outbound 20d64b55c711:v524"); Wed, 11 Dec 2024 16:51:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: acce7723b911880f
X-TessianGatewayMetadata: gHELJN3cN6pU0hGP3jWmJfHP7jS32iiWXC7SQbWHErBrkbyhDQUaAxNG+ObV0k+E5VGSBtnD3dx+TRk/eJr0lbMbtoC21D2A9Aiyjyj9wQke1gDNHQi83KbNWkB+xWngwjgEmefBu5C7FkV5o7qkaph6CAygRawItYSvCjebde8=
X-CR-MTA-TID: 64aa7808
Received: from Lf4c2a157c311.3
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 16F5E391-AB5C-4C79-90BB-E28DF4A0E328.1;
	Wed, 11 Dec 2024 16:51:08 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf4c2a157c311.3
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 11 Dec 2024 16:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va+LKlxVo3A8doHLFCSpQHiFfpReW/9y/m8p+f0mGiADR0C1menkgqjE2eIL2o2td9gBfmLu7zLb7D4GPmDXt+UqQuB6f4/CancC9NZCxOWh/MgZrRNf+DsB10LLXkyzE7ignBhGPVjvFePymHrzApwSgKGG6ToRbeggMKIpeoj2BFz4aAKr7v3VJT9YIFt1+JCYkKMte7JGl411Sd6f7uZDq/pIipR4MeypJvNesC3JiLGiubn6opm0bmasWCb94qIehk3VZ939wmxGXYOMRpbJG1tlrsa65YiIsMWrq4j4tdqkelDbd3fIwwVZ13LGB/AOBcu/K5GLtFw287XDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah54vksIAL1XBn9oTvm0ntr07MfGjKJQMzj3zX/uYF8=;
 b=kv42CKYaH7yNRZBAepTwVMQqH4L3swOk1JEQwun6wNCNl4ZXy54K4F1GX7U9NoZ4KcaHbd2Njlbz2bTke7eysUmSc71/R+l/MAZZzY54/YjpXuN4MnNe38IrTqr5kpylq+QahGL3lJZ4idr3eGYTv1pQW4SyXI3zGyH+nVEQV88+wsMyc/UCorSG9Uh5vQghQ0huOL/ZkxJBkX6Ay7csqPsqX9dl1do03tlTFa0u0oqQsdSpAFNe8uKh5Z4LGZ6VZHcyP01qduleAbv3VjHugiGaq/pKOK9RuOXPSJlSRuEz1aLbNM+uCqPTigWCLtp7Kat2igTaxTvBwyS/6U54aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah54vksIAL1XBn9oTvm0ntr07MfGjKJQMzj3zX/uYF8=;
 b=c544+nLqQdNQRuBgKSvafcV/FzYJa/mPg6CJAKhOrBTQLVYg4S7ELKX4aADWQ5QW1EnUti1gU34pf3dgyAImpFY73pvgPilAJXQWsdcDuzVPI9M5e2ue0d2PFgNmWjown+/wrT5SzfIAyM2qq4S0MFxRfqylOFTDguzZmIQRTHo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com (2603:10a6:209:42::28)
 by DU0PR08MB8493.eurprd08.prod.outlook.com (2603:10a6:10:406::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Wed, 11 Dec
 2024 16:51:06 +0000
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897]) by AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897%7]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 16:51:06 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mihail Atanassov <mihail.atanassov@arm.com>,
	nd@arm.com,
	Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: [RFC v2 8/8] drm/panthor: Expose the panthor perf ioctls
Date: Wed, 11 Dec 2024 16:50:24 +0000
Message-Id: <20241211165024.490748-9-lukas.zapolskas@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211165024.490748-1-lukas.zapolskas@arm.com>
References: <20241211165024.490748-1-lukas.zapolskas@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::18) To AM6PR08MB3317.eurprd08.prod.outlook.com
 (2603:10a6:209:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3317:EE_|DU0PR08MB8493:EE_|AMS1EPF0000004A:EE_|AS8PR08MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e16346-55e6-41f7-14cc-08dd1a040774
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?2bMmBzCdjC4e/Gtqup0QtTlUnqdJve+Y5D0hUmlfJTITQYD8DIlgN93Ik70N?=
 =?us-ascii?Q?aFAfnq/er5Tw7NVem+FXS//AeZbQpoSKbcTyI9wJE8/bZmi25FL4pQML5f+f?=
 =?us-ascii?Q?BS0LsX2770tlFVKM0xCeUNUL/syaHKqHfUVKXTtiWsUyZa/Upjawsv8KQ/Br?=
 =?us-ascii?Q?gDBObnGc6UCPJt1un4RDJAFTDmmqQRpY8mQ4EP2YDC4zVfu1pYl+RNwu3Wdn?=
 =?us-ascii?Q?6OBmW6D9vQdb6bCbZreY9VXXpWft/4xDAzNXbtHTDrlkN03aygw2v8BSqb2X?=
 =?us-ascii?Q?1S7l4tkgxxOjvRAeUSDwkewW4h/5uJLflN3L/oTydb8CluGH0QfpVgRQ9hhx?=
 =?us-ascii?Q?2665Xj/XMpfjyIcfR5D/7dkQeRECbP96IRyon/9JpdpevyL6CNXOPMAjEMDj?=
 =?us-ascii?Q?2KPemz9SiES3mNiLBXbFJvCTKdbfj8zQ8Tzw0+PsVNCdIeLvCPukfUqhHQB+?=
 =?us-ascii?Q?NBwKSNHRSGJfNzVHzjub53biRgTQBdip/86z+7/dwzXcg5XnD/av07SzjnlO?=
 =?us-ascii?Q?K2By0VGeAAOO6VCIBRH51ZxoWdWmJghSm/uwsa5OfyMH+dCv2wB2gpf1cDrj?=
 =?us-ascii?Q?BQMbBrS5152/tvufnhOf/22vQ48scXLjxDEOkcw88b9kN+OkCz72WkkRVirt?=
 =?us-ascii?Q?2Vq7o76g4oEVeyX7xSFuvgB75Km7ZBe6oMnPYkBqyjqkHXaa2dLVX5cirCAa?=
 =?us-ascii?Q?QNc2jBW7knjjrakodRALw1b1gvWpqpD/deNQK2YGsLHRMbfstuCnmB3qtHcx?=
 =?us-ascii?Q?R2t94OhJQNlveweJLpFwhk9aHEzw2XNuJBr0BsTkHfwnlLMAghfXsMFhyNnl?=
 =?us-ascii?Q?PcTcUgZ16c9TS6+gsTaPbLq71saY4OUMoJKKeDZBzb3ZEFbZn4FjXXsBF705?=
 =?us-ascii?Q?cQE+PP+6tsZq+t7V1U4OGfkrrbFZh3A7usSJdhjS+E7hyuygt47NmEfQi85G?=
 =?us-ascii?Q?835KRyA4EifMpih3pPTblbhu2Ies8k8afo/gtzLPByaCl21O8LW8TL4T8By7?=
 =?us-ascii?Q?8WAoi/LQc4cvOKnOzrNihvy9BqrqbWd7sH6BW9Soc8RlhumWFTb5Lans+A6/?=
 =?us-ascii?Q?Y30UxBQFS7Xo4YI2EvuWmpL3j7GrgSm5YlLbkwdW56w7CcRP6J2UaCPRyjLs?=
 =?us-ascii?Q?UODMy7WCJ9f0aZTSz6kI6UQ88y+LpN9cIy4p8zn/jY8bXKl8sEgscNxBSXAn?=
 =?us-ascii?Q?KbqQZWBXVbB9NHJjNVofyhoMmBHA6gON+pE4HFnLg/kTIfzuMf6qicUh58bh?=
 =?us-ascii?Q?XfGPpTg7OSfDWrtlsRar7EJO9QMJYYqKIeeVBkaGKIgadfYWHKFCzKU38dwW?=
 =?us-ascii?Q?Y9zybyOhCxW2DK0pLXkA5qFGOlaaEodHMox6UgzTRXi8kQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3317.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8493
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:209:42::28];domain=AM6PR08MB3317.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	24195952-0700-41d8-e43c-08dd1a040165
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|35042699022|1800799024|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmsPMh3iS3iLgpPLnJnEM8Cc4s14HuEmR/ZEUMecQHtTSK9QLxwD/9/mXhJv?=
 =?us-ascii?Q?mbSkdryxBtTI/BfamROQmMJqWxk1I2Q+q8ofDrVeUtQqhjoNEdQH2U6pL0tf?=
 =?us-ascii?Q?YDe84W4drW1YafdhqQV2QuW1dpdiwIFPurkme+kIVFOvKPLzi/8de9FPtR2V?=
 =?us-ascii?Q?8g3186NgCf7eIUqmqoPK2ZyXtlorLCsDj7ka1XBaHDwK0ouyw8XKb0l3Yy7E?=
 =?us-ascii?Q?FUBU9Irxej2p/0v8CVPr3u36NdlyQPi9Oq3G+AD7wtB12hNvGJaQvr3TuOcZ?=
 =?us-ascii?Q?UQFKhpFyyHH3O70VkR/5nkRsEkaHzJCbFvhUPcQc6++Pv9mDXrxeMQuMZp4c?=
 =?us-ascii?Q?VeKYg1+yxw9hz9XFo9FFK0kDGTqd4hwicAvaJI3XNA0q1W9Q0/a+wwtqsjvk?=
 =?us-ascii?Q?oHOxpQAtfgwpvvGgODSZt19LA/SbrBAt32eAiZJmCgqjjV2U8iGeiYBnpasO?=
 =?us-ascii?Q?cUMYcqX2Toj3xDdH1UifY7SDxlHHFQK2R5PXgjzQwlbLVoeuYYmbcnnTbA2E?=
 =?us-ascii?Q?/Ri2TMD4y/g3TBzEo9LF3MsKJVFFzVSmRxXsFAbhyCZsc3WEwtdCPQPfKPpm?=
 =?us-ascii?Q?xgoxAKd6SQEcHlTTWWt3BEFJT9M8crTCqXMQq22gIzivJnHa9lGUB3mVpYy4?=
 =?us-ascii?Q?S/2ATlAuUyp6E+ydze0lCnR7apljkpyWD6Kl+f+TmVyeEy/caXQfw6cMz6rY?=
 =?us-ascii?Q?yyFzybFsL7y4kwDdSUUlRm6IsJK0/oGZXE/Df15JpWpyKkc04szEUH+2mT6l?=
 =?us-ascii?Q?gxJzrNpZoLnEqJ69c7CI/pPR4PLlE5wWNS3OG6HH6uiI6FzYSl6BkBHZ6DI4?=
 =?us-ascii?Q?Vq0m/agr7x4LMab0O7hhsAmKFFHk9Uz2NQEyy9Gs6VIArTZ2M7Gihpz+9Loa?=
 =?us-ascii?Q?WrFc5sZU+SL9cxRoJfQ/KGjt44M4U0svKsaFempV8/XENlmxZrx2cACvYdlw?=
 =?us-ascii?Q?WTTeU0tjiyiScIQmVFxH22qDMqKrXGpHIw/cEQaLbii2XxnUjnaTAfXL+c0m?=
 =?us-ascii?Q?2J55U3VH2mggUGaCzbjSdUqqHss/cTqLgwz7/4nBD6VfQKHjhrKeQNJ4p3zS?=
 =?us-ascii?Q?7uYM3P62rhjb42qNiec3SJCmad9a0sN6Z9mcP4DoNiXQVXDPgavnKN5qp7TS?=
 =?us-ascii?Q?J2EHSqkygY6rw80yhUBJ3DpW2JRWGhuhbtSr5ppiWCtHexNezidvqF8SX4/7?=
 =?us-ascii?Q?ifX0iNwZet5I+192HVosn+tSGZIU2Lw3Nqy0eUb7OqF3t8GgxBId2+0zYCw3?=
 =?us-ascii?Q?7QNsZ1KCGCGD3VPm+ASs0TyggB03PQaHldAoeentK24R9g/HK0qgRan2B3T4?=
 =?us-ascii?Q?K4VNOrMgyjwvW15TXFAygmwTfFhAXJYUXMkugWZMrCEfKaO5rfPf2fh5csmA?=
 =?us-ascii?Q?5G8Pa+agZ+eXyG+Ff6e1nwz+4Nf6lqRYgNd7iTyD8hJM9DGFKzVEwbN98p4t?=
 =?us-ascii?Q?yiPQrf5K1F/6/xIW/8dyNV3nC6HPNdumXcYmm1GF8qdA/2xI0GjTiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(35042699022)(1800799024)(14060799003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:51:16.2624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e16346-55e6-41f7-14cc-08dd1a040774
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5976

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 2848ab442d10..ef081a383fa9 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1654,6 +1654,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.1 - adds DEV_QUERY_TIMESTAMP_INFO query
  * - 1.2 - adds DEV_QUERY_GROUP_PRIORITIES_INFO query
  *       - adds PANTHOR_GROUP_PRIORITY_REALTIME priority
+ * - 1.3 - adds DEV_QUERY_PERF_INFO query
+ *         adds PERF_CONTROL ioctl
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1667,7 +1669,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 2,
+	.minor = 3,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
-- 
2.25.1


