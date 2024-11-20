Return-Path: <linux-kernel+bounces-415657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5789D396E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D099280FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE9A19D89E;
	Wed, 20 Nov 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DkaQyci+";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DkaQyci+"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CEB4C74
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101799; cv=fail; b=eJNfIROdHCowLNK2u5Y/AMoFXWFJbIEdUpo/uztyVVv66mqsJRdtpR21PPmwJhEhLIGfEriTM/ctXgUZSUv0Oh3IDeTsUnHEVI8HLHvpo02gmJdE0utG723VhqRW2eN3b4omRBvzp8X3k6tbJJocsT9szpY9oTbmKySBJX5Lqc4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101799; c=relaxed/simple;
	bh=0A+L1dYIPxX81CfnOEG0jFGWE1RsOa4acVUyIPLccvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xjl5aZFZ5LhuywLiwA4BXokOY1X4QpsX2S5/OKFnFHxORpxm3TQyQ8StytPdVSOiGlpuvTYTwX/EVeJRYkhJji5U/6Fb52mYnD+ubgaihToy2b0neEZnb8x6lPza9m/PXn/LugKazR9XCAaQwhm+sEQADV6fG0g8cgvpbE8QmWM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DkaQyci+; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DkaQyci+; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EA59wLCWDv+fk3k1qluMtHo5oHprbVLbz3Ait1YY7sftEfM2zLKcZ3JJyco7l6pbOmvozt4xoHrs6HPIHirwEfxe+9LRpVktVJRZ+d/Lr66Ok5Qn3PPHgS1z7DKUWbEVcoSWCdAmrja1Q3vvbk7BsuikvEP9dC87WNrJv2Z06DwWehhzBaZnoVnj3jDWsjDZ0b/V0vc3UL8k9nHNgZF/t+w3V5zUUINeZK9cS1FJ82ZhO09KGgvCHJw0SNM5Xjwj4VHvqtkXBUEViNka+w/zAPy2f8BEAvB7hiISj/IuNr+k8sxeikQeN1IRTslCpozdQ1L+EA1Sh+DKH4U0y3UlDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke+mfr97YmD1E1c7FQ6fCCt8eEZjEtEbNjVb4kTJlvw=;
 b=qkLUt4u4GDp8/KnkBECg/6/Ntl0U2exHO3Qd0MYl5xamZm3H85dJ75z/47RG+t/XjqoNaTcWBKHVJrFHMMTU+Y9P53FpuKyglxM+fOUfphL0HGz4aZg8zSRjq36HKhwY4ImO9X2JtwG21I7i/+CrGVQN2Rcr6460pt0oFlo38vEO1LgoqYXHqQMZhhNWWhuom3icAKR6VespIdIvrcCxmAuGWG/TDqeWYrhbX23f8P6I78T/R4/XM1iksBkNHwKyfNd6yIx5m3s2zgCBif/11gPo4C022HKDecE72zJb8T4MRjXhY23HEcHv+iTqhEsfD2VOFWV2SdftEGNtEuV4dA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke+mfr97YmD1E1c7FQ6fCCt8eEZjEtEbNjVb4kTJlvw=;
 b=DkaQyci+cGzXLx3TL+f9FGfZyyufTQt0k/HWrDroO8rIdmrvHG3q4EvILAxOMxiKMEM52xyiSiIn22bLOYNAV5U5JFjEviP2ojZ+9IODSfBoLYpI7Yfp3YGxRk4rXGpr5Klc+NHVbRAGe6YMkraFomTeQQV9nErWxQMifw/UWEE=
Received: from AM0PR02CA0184.eurprd02.prod.outlook.com (2603:10a6:20b:28e::21)
 by DB9PR08MB9491.eurprd08.prod.outlook.com (2603:10a6:10:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 11:23:09 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::8c) by AM0PR02CA0184.outlook.office365.com
 (2603:10a6:20b:28e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.26 via Frontend
 Transport; Wed, 20 Nov 2024 11:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Wed, 20 Nov 2024 11:23:08 +0000
Received: ("Tessian outbound 6970ca6dd121:v490"); Wed, 20 Nov 2024 11:23:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f9def58c0244f5bf
X-TessianGatewayMetadata: XJOBd50BIYHP83qmktWp0QKBx/WZCefHJjGMlIA6GP1++voeEQD/RqRJIGUUYkSYb6mVcf70dbIXNZwGqC5BG3VPMlzZmtUqzTO3B3oOSLOqJkRfouLQ1YUm/3zSmWYAotdqqFm33GvxhBSPKdyytILCUEawiqMImBrDWQQZIUw=
X-CR-MTA-TID: 64aa7808
Received: from L42aa07a32a1f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5BCE0A17-2007-4494-8393-2A0759B9521E.1;
	Wed, 20 Nov 2024 11:22:58 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L42aa07a32a1f.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 20 Nov 2024 11:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z70YnR+XyQxMuFkrKroWHiihTzzCfhrxVKvIxf1B+Avo7NzFIS4j+ylRsPydXUF472C19O3zNzbXQ2xaC5hO8iI78WdIm47z9O4oRdeI1Bihz+0CG0HobQR9m3EJxaRvJaqOUjbVv7FsrhynZPlTraM63npcezsvXDExQEdjRBHaqfcYsQic1USjwpIU7ilzKXtCRYoJhQQfl5N82k1ViZx852isfB+POy0voApQqeULdBaazCV2n/78tR3wp9n0sivZhWG9irA/I4Y1WxvoQn8Sn9yeS4JG5d6KuPsdZxxeCVpnImKwPsGBUCwsCyG3uenWT1evDvo7u87YtNHNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke+mfr97YmD1E1c7FQ6fCCt8eEZjEtEbNjVb4kTJlvw=;
 b=cIJroGr54LPIiHg57dT2EpLySjJf6QFr010OlkBTE1ladfulrO5TIsqD4/Hy+JciJzTeELrLLsG0FVRy6AJek1mLYM52+PJmV9oavIREjtb+EJg1nbQWcdcQiV4j/Cas1ldnTTzG9o8+fK+xX9oo1JHF3/dJfHX1EWBMDD6cnpHvYeXsZt8y2NMCZxi14+AIgOAJUkM0SM2OaDryiYfzjxMk/YZStLONbOo2PNMXjAb3hBxAkW7jAQH/pmLSVAlCnN1XsOMNwG+dh5HEULfT/e38Z9defMlWPPDjv0fA96qpa2qc/6rDdEP2OkR9UWn2oiZwpgVbLQPLMxxLBhyDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke+mfr97YmD1E1c7FQ6fCCt8eEZjEtEbNjVb4kTJlvw=;
 b=DkaQyci+cGzXLx3TL+f9FGfZyyufTQt0k/HWrDroO8rIdmrvHG3q4EvILAxOMxiKMEM52xyiSiIn22bLOYNAV5U5JFjEviP2ojZ+9IODSfBoLYpI7Yfp3YGxRk4rXGpr5Klc+NHVbRAGe6YMkraFomTeQQV9nErWxQMifw/UWEE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GVXPR08MB7799.eurprd08.prod.outlook.com
 (2603:10a6:150:3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Wed, 20 Nov
 2024 11:22:52 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%3]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 11:22:52 +0000
Date: Wed, 20 Nov 2024 11:22:50 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Fix compilation failure on panthor_fw.c
Message-ID: <Zz3GioHsrcGG8LNC@e124541.cambridge.arm.com>
References: <20241119164455.572771-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119164455.572771-1-liviu.dudau@arm.com>
X-ClientProxiedBy: LO2P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::30) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|GVXPR08MB7799:EE_|AM2PEPF0001C70B:EE_|DB9PR08MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d9c2c3-9550-492b-0b89-08dd0955b600
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?NehzvnrPyBvqAhIY8bKjjGPf5WR6GQQUiyvsH9rk0RHEY6MDEiNUdHgpZOGZ?=
 =?us-ascii?Q?z/mBLOs+FWOpr4hw2EKIBSDb1ea39s3twalxiT1D1PXVto4BlIwevLPQg1qs?=
 =?us-ascii?Q?q3OqKtw+3Y2DUc4B/0FsrU9mwLP+Bn1MOFAQb8RzUPwibwRcysFdZv2b0IJz?=
 =?us-ascii?Q?uCcXuuqM7o1ZrFIszkO+CcZB4IJyiRAhmVSxnhTYC5nvABd1TQbUAuu0yC2h?=
 =?us-ascii?Q?DQNv/2qt+GyMjwvQquco1LXZYi60CtwPOzEYNMgnnyEGZfP1iGq6oOjyyl3H?=
 =?us-ascii?Q?fvVBa0CsT9XRpQb/KNabG3yPBhZS4kC7Gbk6DIliMFJjl0xQ6sJeRt9U+Zau?=
 =?us-ascii?Q?JfJgw1kSu6GDVXZpS5NqQni7VVZCl0okQVTw/Y/0HV7pWVoSibaMj11TJbUi?=
 =?us-ascii?Q?ck1NK3TGfUi/lEFTv3ebgDwRB48ZoeOFwfXnk1ZE57eZvj3WmZD3YXn+eFVs?=
 =?us-ascii?Q?LCjYtMfEle9qX+G+9Ms7eTWGbvA6a6S+eWmq1JGia0dM9lVWPbQJL3iOEqp5?=
 =?us-ascii?Q?qVIuHGfHx0MNLPRFyeQo0BdezfJQmi05Ehz/NqhhBXwNk78lz55ELcya1zZ0?=
 =?us-ascii?Q?pXGsOO1DIEoOknyX1oNUtFfFRK1TGVA4GJNER/p+fPVOoO5Qv3MaBtoR9N6Z?=
 =?us-ascii?Q?eimz8GiF2iMhvjuwUnXYnFxMtgiDg3sLv4XJ+auuFgWdI9xP/ZSHMRvx2VJn?=
 =?us-ascii?Q?j1vVh3yeNhsS/es/yeShqXUkaJHWkqnTrYEZXEefSckm1CuQdZlXBbG4Ni/E?=
 =?us-ascii?Q?jUAJMHDzkuBIuj/HAewIBWOfH5dRYwexRzBxS/oNrErH0oZjaDXM8FYoInLR?=
 =?us-ascii?Q?WFz2Gy5xTGMR75kB8/VO3IBtaSeru41YAFYMl1Xokc0CXxrT6MbYGB3nEM6W?=
 =?us-ascii?Q?XpLDUT1ySEg1M//3cE1D1LRTT3LhbapSjZU3LqWRhuBGEyAeXOdlj/CgwCeL?=
 =?us-ascii?Q?kWsEqurjCal0UeVLbtjDuU+IENKgWfQbH+Zm3ONy0CnGWt/IFDdtFQLA5STm?=
 =?us-ascii?Q?VqB3SXz6A14NOXq+qpRidql1GVNJ9auP/zFa57wzHGuzuHSQciGVJ0AYzzMg?=
 =?us-ascii?Q?wItnxzV+GA70ZLWsyL5aU/BiWbN4JT/0Yyc3oxX8aB4bzEC2gHPwGy/avSPU?=
 =?us-ascii?Q?JquVoGWNROqaMPiQRdJD851jJp1Evd76L4+XhL9oGMOLC1LbbgOq4cNdO46X?=
 =?us-ascii?Q?Dua506lKAW+nKH8CDlIt+ulKeJUhP9yBB+k4QZl3q6sAa4sjJIi4F9cCpvnN?=
 =?us-ascii?Q?dTnJ7lTS26aG3nem2kl12ZwCiCkpk0eVi+JhlHRUGZAVXUZDCcfQMAK+aIOY?=
 =?us-ascii?Q?Map45ZbVvlyKC7LVo7myJ9gc?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7799
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ecb8ea3f-6909-470f-d5dd-08dd0955ac0e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|36860700013|376014|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bsh5XzceKgGUBQHmzD+ji/jEULVWF9oceeoQczPb46QVxcP+/WBhRAWAYHpU?=
 =?us-ascii?Q?MJilzWH6t/wDP+VYsn4SWcsNQuPQ0oThtn23x+BKPNDBOHDzS2+4oVLJ2Icj?=
 =?us-ascii?Q?k1jtih07DSJQXs46GxkKHVSzNnjO1Nw01anrH3O6X/qaVEi+HCHH4gniItkD?=
 =?us-ascii?Q?RaC6gLe4nhgXYFjXwZMSMa2md2rzGB4+qfvYcHgpKSe5DW+8VfJUd7qeG9wr?=
 =?us-ascii?Q?8jfUT+UgEgFSbIObhDnQDLpMMef/l9E9f3uqgKZZxX/qLHbybQl9n5DDNUBw?=
 =?us-ascii?Q?z7C1FTcUisg5fXVtDxL0yn7U4vxdLb8gwihIjQg33sbUiTdswzsgpVGdss9f?=
 =?us-ascii?Q?JUHKr/Pccg+OgYGNMApiuW0R/Apviou0hsRT0mLdFzj5GaeVYSAcQ78VkZLa?=
 =?us-ascii?Q?UF7M/TiDERQgQLogX4i7999rOKnzDO3LaUYvaT88t5XbiYWxa+sxn8m9MpNu?=
 =?us-ascii?Q?jJUF6gXRVAc/Gpxw1XBj0FnSXAB2gHzWmOXF7g/sWrs2GHrY0p4j8VEazMNx?=
 =?us-ascii?Q?SDFDUJsiyIyYZLSY6fssg5Xxlw8tjNKMtZJAFmibPNENw2FxVlsowy1HFJFr?=
 =?us-ascii?Q?yoxAPDtB04M3S7M6y3a0LOZt2KI3z8/ZHayBmkg0apcu/KuhW5beHXEh9b59?=
 =?us-ascii?Q?xD0wrBtD7ioxqiOg34c0d2sezA/FTQQAzx7VY4BLgUiO1r9ZWipI0dMxhU4e?=
 =?us-ascii?Q?RXYIt8jz2cAnu/Y6/vQrp/t2/61bO+hB7Nybb5byD9srIP4dyc1HEwT1c5Lw?=
 =?us-ascii?Q?hyvvml/i7IKibKWbR4CpGM8hyy5ZMVwok1y2OzfC1PNcsqN+gzfzJ6gwkkV/?=
 =?us-ascii?Q?hZ7Ul5ZxZhDKKwcsU7sXjtgp+7oi6eiQL2SbR3SuCvvpBaD4Fw9PVJ1OVGEB?=
 =?us-ascii?Q?CP1QeGcTMKMBNaMrM40iZDUT5MGprxLVpK21Xlpf3nT1qpwHV+4DO4rSqgtl?=
 =?us-ascii?Q?McXW/B19LVEKtUebcBX+p6v6jvF3P/tM+DmoY5IA9Ip4iTuMGI0hDhaQnvI4?=
 =?us-ascii?Q?KDVb77hmsNmu9Afq3GqH6SVnBPwQys8Ma/vaWtOhDgVpU/qvfL42OecBg218?=
 =?us-ascii?Q?805k1/GJpBprSRgAkULITtA+xD+v0P2Nuc4OTDgriin+qu1GcMKcfxv8o42z?=
 =?us-ascii?Q?iIqQtbZO57NZqkk+OfFGE0qkooDHQCY6ZrxiOAwCpm1xR8PL7SsCcuU1d37l?=
 =?us-ascii?Q?QMMPLIsxWm3iWksFM00YphbJ6jNFs+G/V9FssxokuQTNxDXJ4vYJE47gSKFJ?=
 =?us-ascii?Q?ld2Ux5VH1wIlz5bhxt1hviGmb9WT4AJnTa37TmEHQHDIsNc7NOOQ6aV10Bx9?=
 =?us-ascii?Q?9zKHhmaZsY6h9qCQYND0trpfo6vd1qAVqdn6V+VWpWpD9wQjyCFQbzLfl3yE?=
 =?us-ascii?Q?MEJcceg9BBsR/8IVN0y0dZiPz1e7j4yVtS9/t80R9LSdfdwFDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(36860700013)(376014)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 11:23:08.6336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d9c2c3-9550-492b-0b89-08dd0955b600
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9491

On Tue, Nov 19, 2024 at 04:44:55PM +0000, Liviu Dudau wrote:
> Commit 498893bd596e ("drm/panthor: Simplify FW fast reset path") forgot
> to copy the definition of glb_iface when it move one line of code.
> 
> Fixes: Commit 498893bd596e ("drm/panthor: Simplify FW fast reset path")
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: Karunika Choo <karunika.choo@arm.com>

Looks good to me. Build-tested locally. Thanks for catching the mistake
in my previous patch.

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 4bc52b1b1a286..c807b6ce71bd4 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1133,6 +1133,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  		 * This is not needed on a slow reset because FW sections are
>  		 * re-initialized.
>  		 */
> +		struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
>  		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
>  
>  		ret = panthor_fw_start(ptdev);
> -- 
> 2.47.0
> 

