Return-Path: <linux-kernel+bounces-429623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74759E1EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECF516292F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F01F1F426E;
	Tue,  3 Dec 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cHbpvNj5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cHbpvNj5"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2A1E531
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235009; cv=fail; b=jBf3NyDMed1LpKuQgP4iQO6igPMULmMwjQ8iESSZuNWa4LQt30CS7ctgrNiEvc+k2omvlZbfSRksa15pPcWrahXVqOVRE54FkM306E4dl2xw/5ZtSv+oUJOB39ihPTKPkKYOtbzNzeFJR7lKBaHUcCvCXZa3R086M98SqEm/d3A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235009; c=relaxed/simple;
	bh=aYjo4HilWN2HhpgHJMJtOQMJZMhF9N8xou0swGY28hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c4DpzvsZA/1NR6zScexxWXGlzDBcxrlCSdj+M2r0Nvz+aQep6WWf/ds4LG5TkFNA8giR2IBMgUkhG/o7ZMTKS+eTFoVpiiQMV+LRTVDLlKjbvY29nqvlKQJF8C+Am8FyWc25E87sTXZRDArVfqXrvxT8QrBMpsO/qquGbtZg/40=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cHbpvNj5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cHbpvNj5; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=r9IzdER1O3T+YqgV8ayqUYvlAIgpZBB6dSE2rp6nIqVFUhw3lTsYobhw8BQQaOg64x6ucgxwKI9BBkdDY5yJ4h66B+LccrLXknh8GdulvqZaNb5Pl0xUghnutB1ul176w+ZH3ppacnaYm2V0gWPPyBdoEXqBm3VQm9Ws9UJciqmt8UjTyM1u7mhIjnHZyIcx/357DhLwAiAjvDarAjSVlmod2JtCAezJWtrr5sJ60hotvEWvjQNIzNSE5MYK2TKSUpEdhTpPA79BeShkhS/JI2izhtrA3Hz2F14FAu4I3UMQR6fEBPfd3GeoiRosdif4eCKef8WwLjOAgO+eRXoMtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VNFYVSgVDd9mjyatkakVUcOtEEpmLIjDEcLk1xbAyI=;
 b=zKwcuLyt6zK2DKed2PC6DduqJn6u0w+hdlRLgWAx/FqESsAkZ9vzMTARFW/x1NSJtkVDP+liYSiUdoX9rhSpHCE8KEVJZR2fKxJZSbvjgz7trFN5OdN13r+R3Htz5uBoPRk6uEdARH9yUPaf9R7GlkGyKrLVtI5BdNkWxdeyIIDBl9xT7N/I5YsClObLVXMfvzNQ86g/r5n1A8CS0OBI3uqZAsaTqOJSetxQ9X5GfFyKkNAgNaqldm8sDpoMVY54nC22SbgKWxbBznnMPKNj3h4SowCdoryDLjAKy+NUxQ06Bgfj1fE1Sfo5HOSWwNMd3NrI/LcY1O4lMOSqM96Srw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VNFYVSgVDd9mjyatkakVUcOtEEpmLIjDEcLk1xbAyI=;
 b=cHbpvNj5NUwmiGOV8mvLsV72TZwyrLRy42F8aJg4+0xvakTHyA+vXNA4QYees3tn6TjKj03Wqc2tS++okP6anh68U0HEi5bExQ7CMtdH8bW7IAgXEZ1cFS78xQmrrANVY5Jkqp5n0W+qgC8k39dOm+6q1OYl9c0oVKcrrDWNkto=
Received: from DU2P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::9) by
 AM8PR08MB5617.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:10:02 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::e3) by DU2P250CA0004.outlook.office365.com
 (2603:10a6:10:231::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 3 Dec 2024 14:10:02 +0000
Received: ("Tessian outbound 033f0ff3ba29:v514"); Tue, 03 Dec 2024 14:10:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 850ecd7c49e837b7
X-TessianGatewayMetadata: glV0GJuaiET8eOfiKbcmOmHTyZ7MCrfK4EzltL7E04zYjcdmNepZD7+dFU5IkXmYEf2ozFjcbtKVzL2pgxSwTGKccw/2I/YTcOvwRu+/C1yv1b85W0d72fJqV7YPiMgAueYQ90xwd815b7raJhDCfQ==
X-CR-MTA-TID: 64aa7808
Received: from Lb19954a1a342.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6A15091A-ED84-46F5-8FBB-74B632EEEA85.1;
	Tue, 03 Dec 2024 14:09:55 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb19954a1a342.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 03 Dec 2024 14:09:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj9pPhLchHR+ewR6XI71vMN/4FJ771PDs5PvFpNxtvfli0j3Vn2i2P7st8tVODZdTHCYxVUOYU18z1RYaiQdxrKHPofnf1mIgl1NLEY0GunZpeFuNUMWaogKmaqx01WJkDaVa3gRBFel2uW6NQ++RMggd7ADCe9o0D6IhpPxFA9WL8KhkVBKLUChrr7npOTpOILuY7Wszv71Y7MNqYhAheLlVOVcnfAbuC9WyjxKS+EBk9NyXIpJBkSEG24b722WNvOzAgVgHGTr3RJ4p9MZWAVPNKsFxAkCJyF85SHfvXQPHsU00gRES740wPyUqxlIBncVKpgP9lRxh+bzVHbGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VNFYVSgVDd9mjyatkakVUcOtEEpmLIjDEcLk1xbAyI=;
 b=GdQ3ixZM0VkbM7aOMlY9bQguLw4uliRnMehKUKueQ6J2FK3Q1Qik1LxGjg4tjn+J9VQvvPsP/VPCTcNs58a4zFIVNMU8LGq/tNixQFO0OIV1npL/lbyico3firXnmr4LoM2BvchPbdXQXmHnFxch+bU+1qubfscrAtqUfKCsIOxnF8YUhcUImzj8GC++k953WZD9j0RTWMtuCqbnzactd6xlITX5teJ9xp18pTx3lvxGkV+iTEiYlBOZrTUNxeQwyV1jHI1pErrY4k7PGd5dvYJU0TWxJugGGrsNgTEcpi5/24L1UXTLX6VqhObELIcxCMMZLI2mPcUtwj4faltEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VNFYVSgVDd9mjyatkakVUcOtEEpmLIjDEcLk1xbAyI=;
 b=cHbpvNj5NUwmiGOV8mvLsV72TZwyrLRy42F8aJg4+0xvakTHyA+vXNA4QYees3tn6TjKj03Wqc2tS++okP6anh68U0HEi5bExQ7CMtdH8bW7IAgXEZ1cFS78xQmrrANVY5Jkqp5n0W+qgC8k39dOm+6q1OYl9c0oVKcrrDWNkto=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB9020.eurprd08.prod.outlook.com
 (2603:10a6:20b:5c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 14:09:50 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:09:49 +0000
Date: Tue, 3 Dec 2024 14:09:47 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] firmware/arm_ffa: change ffa_device_register()'s
 parameters and return
Message-ID: <Z08RK7JWG6ko1yvt@e129823.arm.com>
References: <20241125095251.366866-1-yeoreum.yun@arm.com>
 <20241125095251.366866-2-yeoreum.yun@arm.com>
 <Z072CGn6fhnT0hED@bogus>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z072CGn6fhnT0hED@bogus>
X-ClientProxiedBy: LO2P265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::28) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB9020:EE_|DU2PEPF00028D05:EE_|AM8PR08MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f20bde-b5ee-4cd4-ccbb-08dd13a42dcd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?J1w0WMi17KLa6igI+eLTajVjek0e5SZfadDQrOEdlkG67Ab+5000JwBifVF/?=
 =?us-ascii?Q?5tYF+bE4ZTqJu5hhYxQgSILavekhlgh4SauiCuIMgVImUovK/kfokipxZeDt?=
 =?us-ascii?Q?giDYoX8zt1zhqsr3opg99AKFgq8yXcYGSS9q5TfcJZJQZwy38PCIMl8e/VYc?=
 =?us-ascii?Q?vDMU/m+bnWvCfiAhgkag7JkbGTXZSpjXfZwSit8hfs3lOyfxJ332iDdXYSsd?=
 =?us-ascii?Q?h/z/OHzpMaDPd06A6y1aOMJIkjAr6ZAVkLPvW/LbMvG4Azyeoap+pYH+geLy?=
 =?us-ascii?Q?/aLqcQT37oEVQD4KYW9WgrRvuY9cjPxix4AFwC/jJi5QuZCt3msOPgUesKnj?=
 =?us-ascii?Q?NMwgAJD2l9KJS72+1x52ylWlwEv4c0wLplLqhmEw5ERJLsd1hIudVKk8GfUS?=
 =?us-ascii?Q?Jc3/wQgHqKWKFzfIJt5yzhl1F8rcZgLuxjV1/0fQs7BCx2lVa71NN+AJPy9u?=
 =?us-ascii?Q?QJ/d1c+nvSyLR444TIzYDLuzjNUh/+5k1i+7lzoF79o2JMRlvH/vEun5f2kP?=
 =?us-ascii?Q?1uq81lEknhyxJmFdQ4OCsjgUwuHtN5XGMZRZK6UyJ1thpaYGMq69wlQzpp87?=
 =?us-ascii?Q?eF0237u57RmOD+dxF5NyplzVmFwFQzBpbVFPZZb7A8+/csHCv8HJsktdEZu/?=
 =?us-ascii?Q?a1G42rXQonaOwpIxgLax//2rtKsGZXfuy2P1IhRPqEQdcEvLEQ4D5IARUKsg?=
 =?us-ascii?Q?N1+8PFGAU8IW8Ebk5VQgOetLcBv5A2MZLr1kRdHAZ4RbtwgUV2qhVC0WKlbJ?=
 =?us-ascii?Q?LHGDYCkFfz/MrajfyhylPwH+iguXRQ72eJJPLWQRsqGFx40D5TozQ5RTXZwB?=
 =?us-ascii?Q?B70f4K/PzWKU1W7vOO4HQn9w9SBI5G8q9O+4bobx1zb/21k4qEn1CqBMHT5y?=
 =?us-ascii?Q?bs1Xcd3r9DAG04sHx3ee05wwuuEfLPXHESJbp+NauTHPcdCsAPNlII2YXxnx?=
 =?us-ascii?Q?pZa+uOGFLNYdOGYJu6IeM6Q5JeK1CJYDhoGU56srgTVnbhshglTnaisFMt+p?=
 =?us-ascii?Q?uexmdeJNJoPf1ibee75iOZ5BPleNb79K+fVgBWcokBrn0SqcHjFx9i5+qKPc?=
 =?us-ascii?Q?mEdMHgbbV8TqPjfPC1OiHIaipjhuFjC2jEE9OaMntjJYS2uThP76VkQlKTCP?=
 =?us-ascii?Q?ZApykxRAuFN5QaUgTBJq5dMkVSfdJBXubsxX+pYRrjEVbR20VXd2IZFsteO9?=
 =?us-ascii?Q?451swTaiLCxDF+pm3hX2xLJRhjT/vPgB1dsdbjbrDYOHuw3ZpdHl21vcBDlj?=
 =?us-ascii?Q?+tIa0HIkg8fzl6PMB37ObbAltOIPTsmWWUKuevsjI+mn0FL/KLHVD8UMuKPP?=
 =?us-ascii?Q?G6ytso0VUQWIxXKvf1g7FzC47ziDkIEVh8YYT4TIbUjh7g=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9020
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	39baef3e-5b32-41b6-9737-08dd13a42675
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|14060799003|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?do7SrwDXykUNminDba+EKtCQ7ZUoZq7hj4sZpe+A/SCBB+ZmX3WwG4AsQPEv?=
 =?us-ascii?Q?t3C7+tlLnrAR4+liryxuaXhuDQjm92q13zH3l61SOXI5EjQXDvZ2e1jhMIw1?=
 =?us-ascii?Q?d1hxPEO2n46vYyL7kmAnCpeWiXxuGrpzfUy5U1ZveefI/ZjWG59BnYOWo4uW?=
 =?us-ascii?Q?toC4JkxqNxlq+njS3TmmTWWgJwU26ZLlrT4gH29cOplqrECBVWG0qsSdZdYk?=
 =?us-ascii?Q?NASyht65BSdu0hJCW7F6+UNargFeVgrAXesjBw46A71/1hNlhwXQJM+ktRJ/?=
 =?us-ascii?Q?hOKXk1b8H8pjR93NPP50cZFkm3yQrLkveyk906puPb5xp2z11Ih5NFkUEcs6?=
 =?us-ascii?Q?5mEUA3toxCCiNtH6bh5rpIbl5Y1BpyZktbtZQQJU9DjC3CDiihmt7QhDEdeL?=
 =?us-ascii?Q?vWiRmpIqYtPEhb9R5AY7ZYIEmxhknxIU4NkE0+btrF1iqK4HAA7pwLlzrCxX?=
 =?us-ascii?Q?FS3usbpypErIKge2OngyR2GFxvQugppQ13LZpfWxObd/LB2TG5QtroJ2v60h?=
 =?us-ascii?Q?xMWAS3YdZyIDmwYcb2KKw+imsAvJr08so1aiJmPZyavVIV/WueN4qY/vNJzF?=
 =?us-ascii?Q?PwprHAeIDvOotwT5IuECSSctUf0fm5Bk1nEr6NzMF36HUXyn/uCsks2VQ/SJ?=
 =?us-ascii?Q?yaZ6+aJ+iUkDzvtF17EA6g5Q1kyTiHNxGPtr04puu/GxW6AMN9fJ4VocjHlE?=
 =?us-ascii?Q?YjIsv7NfuTHXINWdccC+1sBDtJhV/1bG3XTLoxroquG3ZobRj7AlchK4spwy?=
 =?us-ascii?Q?GRnMUXw8jAw2C18/IniDFnxgnzIknNsGUaHjTZCrVl0ruIUnMckn4rdqfXDa?=
 =?us-ascii?Q?GOpAnO/2v3EoNg+P3IIKVUHJ3VNpshLdmo9+1XROeCUtpf29d+8FfJEr0+fR?=
 =?us-ascii?Q?kqG7rmHhYUgb7TWP+hJsu3/FbnUt+ru51tuejsd6h79fGDcHRR9b1pZbkyt7?=
 =?us-ascii?Q?DlyrCfrXRQuQRLDLVKS578JlddTxEmyypKmcUlf/W4KtjTy5CTgZk5m1GCaU?=
 =?us-ascii?Q?LYwqT7+YR2k4w/irHSLAPbKpM3j1OeMQk0KjaGnVcU2vor69SE7Nwf0ENdwg?=
 =?us-ascii?Q?Hie56zE1TbpIa0VT2kaWskYhH5gLRezQHOMNhHqzYwCyxIZyVgABBG+D4EiN?=
 =?us-ascii?Q?89wfHQ1OTjFMOcvK2Ubxk0Y+DL7f1v06HJRken4pqeL3v6Vy3zNPP/RU34jS?=
 =?us-ascii?Q?36uT2ulLNlyEmQkz01NDMRkezY0CqfMB+ANrSTFfaGiaZp6YqLylIuDf81vF?=
 =?us-ascii?Q?hc51oDh+HTY5EbZEVZmH4rfJd0PgsxKcAWspkepFExqvptfUXNrVYTTrtTlx?=
 =?us-ascii?Q?MgRlSKp65x/CjohMzlmfy98UOO4p6NRIKRx7qWxgn9IJFKq4pYPrKtkzCriD?=
 =?us-ascii?Q?oKyO965UI26OqVQPzyq1T5qeSq6A0nvLrj5N8hiP3PYbByCQzEve14sDTVdB?=
 =?us-ascii?Q?SO1nV9nF0JEZ76E3zP3xWkdaX8yv9OIr?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(14060799003)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:10:02.0192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f20bde-b5ee-4cd4-ccbb-08dd13a42dcd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5617

Hi Sudeep.

> >  	ffa_dev = kzalloc(sizeof(*ffa_dev), GFP_KERNEL);
> >  	if (!ffa_dev) {
> >  		ida_free(&ffa_bus_id, id);
> > -		return NULL;
> > +		return ERR_PTR(-ENOMEM);
>
> I am not keen on changing the error from NULL here. -ENOMEM has its own
> logging. ida_alloc failing is very unlikely unless you have so many
> partitions in the system.
>

Okay I'll restore.

> >  	}
> >
> >  	dev = &ffa_dev->dev;
> > @@ -210,16 +216,18 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
> >  	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
> >
> >  	ffa_dev->id = id;
> > -	ffa_dev->vm_id = vm_id;
> > +	ffa_dev->vm_id = part_info->id;
> > +	ffa_dev->properties = part_info->properties;
> >  	ffa_dev->ops = ops;
> > -	uuid_copy(&ffa_dev->uuid, uuid);
> > +	import_uuid(&uuid, (u8 *)part_info->uuid);
> > +	uuid_copy(&ffa_dev->uuid, &uuid);
> >
> >  	ret = device_register(&ffa_dev->dev);
> >  	if (ret) {
> >  		dev_err(dev, "unable to register device %s err=%d\n",
> >  			dev_name(dev), ret);
>
> This error log will give the information you are adding in driver.c, so
> it is again not needed to change that.
>
> >  		put_device(dev);
> > -		return NULL;
> > +		return ERR_PTR(ret);
> >  	}
> >
> >  	return ffa_dev;
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index b14cbdae94e8..a3a9cdec7389 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -1406,23 +1406,19 @@ static int ffa_setup_partitions(void)
> >
> >  	xa_init(&drv_info->partition_info);
> >  	for (idx = 0, tpbuf = pbuf; idx < count; idx++, tpbuf++) {
> > -		import_uuid(&uuid, (u8 *)tpbuf->uuid);
> > -
> >  		/* Note that if the UUID will be uuid_null, that will require
> >  		 * ffa_bus_notifier() to find the UUID of this partition id
> >  		 * with help of ffa_device_match_uuid(). FF-A v1.1 and above
> >  		 * provides UUID here for each partition as part of the
> >  		 * discovery API and the same is passed.
> >  		 */
> > -		ffa_dev = ffa_device_register(&uuid, tpbuf->id, &ffa_drv_ops);
> > -		if (!ffa_dev) {
> > -			pr_err("%s: failed to register partition ID 0x%x\n",
> > -			       __func__, tpbuf->id);
> > +		ffa_dev = ffa_device_register(tpbuf, &ffa_drv_ops);
> > +		if (IS_ERR_OR_NULL(ffa_dev)) {
> > +			pr_err("%s: failed to register partition ID 0x%x, error %ld\n",
> > +			       __func__, tpbuf->id, PTR_ERR(ffa_dev));
>
> Drop this additional error info you are adding as bus.c will provide it.

Okay. Thanks!

