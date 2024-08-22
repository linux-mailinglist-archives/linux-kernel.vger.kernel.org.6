Return-Path: <linux-kernel+bounces-297049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A921F95B242
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB991C23A54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C2C17F389;
	Thu, 22 Aug 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L4IaYNbi"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2041.outbound.protection.outlook.com [40.107.117.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3617E011
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319908; cv=fail; b=LZxajLorUFCmILHQmKMjPGbJNeeT1y8m8pQw/0c1CCEMNaUndiaED4fOzsW2KP8gLXLBLzKdLsp3e5i6socUtwgkx3qBF01Y62ZZNaoX6RYFlcqL/6E/zZ8b0BPZxRcipvMYoc4Fa4aL/deOJiHo1amWi+MLkGI6qQbJ6/dnnXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319908; c=relaxed/simple;
	bh=6/ixPnD4Siqn+XjxQc5iRyPtt3eo7b2yyl7/+OSXEck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bOF6A7ckM10WTX/sjpxE2g/JdqwihK4xacuGfSZ8lUZE/93jBKI7goqYyo6C6W2AVR9E5PMjclyGGwqPKov7Vl4YKAScDgq3MoMUrKsn0evQ9UZ0PdL01t3vdpsT6Gjzxc07X8VIr7OMpn3ECHlGIWsbJ2dVzRONI3hC75mVoXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L4IaYNbi; arc=fail smtp.client-ip=40.107.117.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVYq2106sfO51OhT8bEYR6+8AeOqykAOmMr1RGmAgIzvbuBOXqLGrHXgy4LteCDdxbThUjkAjQDZZLgE5pNgENm98T8GbagYZZaO5TZEtnhOgf8RYAsNYsLMcaA1oRsK4kfQpF127NRut1u3uK6ZmHT1VPL9ZALiZ4uE+/hh9eDBrGgTxb1KU+QzhxDwVZQMBEe/jVR0o+h2hrCg8odokWTHNSzMa7TRSath7T/+tDhZ6VMsE2WFPy/TH4UBfU6czHGPc6WEbOzBMsMxpOUQzeKIQY7uXDEpMtg4M7pGZktSdnr3zTy31PBnfCzjqU/ZX9xYl2DyZf55GA4ZUYscpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/ixPnD4Siqn+XjxQc5iRyPtt3eo7b2yyl7/+OSXEck=;
 b=ffTNI5G5jR2iJgcbYmE9s5XbSP1uBp7Pe1p4P8oEMW/Zf711wzWFhcKM658HyUm6IlEoI5RmydhNWqbKicC8d6PaHsAMw4JjY0BOIFcF6TGyIYBgV+6YlKe9z81GwVGZX8JXwiqvvannL+PjWO3jnWXSjAfX9KYeaM+gcVSlo4HD5GhlFOLeVVwTL+yR/4z8tznqRptN+B7fGKrEXdCeufNCil1d8g6OII1nMCxsezOKQ7ihGjIQcsEe8Az3cJ9jfS5AeDOdlychnISmK47zqldRflA3WBnPfNY5jdk9DPLlZI7ta+ZMvPLsJtR0YJOTzkehKa8x2RYQw8M47XzR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/ixPnD4Siqn+XjxQc5iRyPtt3eo7b2yyl7/+OSXEck=;
 b=L4IaYNbiQfoqMN3JQ1WR3NcDg7W/PfKeE3iXFWXmvSnEv565VunuIGIIUw+XWCFPQwgEVzBBYatCFx0IB8AkpT7M7tHC8q2tD95/P/BNWiXFZqGYTvHdGVfjhB44c8J04Ffcfa2IouY670MbbRoxpzH0f776ULgXFapImsCOM4XXoBoheYKMw6S4GDLagOZIAdL0q2LR5hH87+VGN2QIdoRGbMtjYVUCdXJdAJQwl27STdvfNcLeB97dVwr+/po48ajVsezOfN47errUP3+QQh+XMhUP1jdsEwtHJBNp69vWBtrULHiP8kCJr3CXMY/f5I+bvjLKKSrar6Gd9+30iQ==
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TY0PR06MB5031.apcprd06.prod.outlook.com (2603:1096:400:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 09:45:01 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 09:45:01 +0000
From: =?utf-8?B?5LqO5L286Imv?= <yujiaoliang@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Hamza
 Mahfooz <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Dillon Varone
	<dillon.varone@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1 0/6] drm/amd/display: Use max/min macro
Thread-Topic: [PATCH v1 0/6] drm/amd/display: Use max/min macro
Thread-Index: AQHa9GCSzBgsXcN4JEGEvKCINREXabIzBycA
Date: Thu, 22 Aug 2024 09:45:01 +0000
Message-ID: <a1a63f30-6d85-4eee-a5da-033aeccdc5ae@vivo.com>
References: <20240822065723.1336181-1-yujiaoliang@vivo.com>
In-Reply-To: <20240822065723.1336181-1-yujiaoliang@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4461:EE_|TY0PR06MB5031:EE_
x-ms-office365-filtering-correlation-id: 8b9e2f15-0101-4263-18c5-08dcc28f17c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmxFSjAvL0lRQzJOa3YxVzVCeVBqd3p0eGxXdzQxUVBva0dJbDE2QWJNYUlx?=
 =?utf-8?B?RzczeTdNVEIwcS91U2ZLT0pqSE1mQS9CYXRnbWQySk15YWJnTkNlWHJTRS9p?=
 =?utf-8?B?dVcvbEJMYUtqUTJpMnlMdTRta0EvWU4zZTM5dkV0YUNCdWdmUFYwWVlmU2xq?=
 =?utf-8?B?VCtQanVnUTZjVkYyMmprR0JCVGE1NUdoNEU0b3VXbEJhZ2w0VFc4a25GRDRR?=
 =?utf-8?B?NTFIUlVoeUt5M1VrVHhBZVlFVGxqVmFkRFNWUndveWxJeDZuUGo1UERkWS9P?=
 =?utf-8?B?aHBNSlg0V1RNNC82cnkrc0drbFhkWnJFRW1qZUNpRkJDR29SaHFnV05qRVQz?=
 =?utf-8?B?L0M4ektTMjc5MmVpdSs4emJ5SjY4R1JpTjZrY1JQdENGeENZT3NZNWZPci9t?=
 =?utf-8?B?TS95VERPZmNjdEI0TjdiVmFFYktYODRoSjlzeU1PZkk3aDBVbjhHblRIU1pL?=
 =?utf-8?B?OW1LZndSanNjYkhhZ25ISjJtTFpCV3NxTWlzeFMrNDhRekRQSlVBUU1jOWNa?=
 =?utf-8?B?NThxUXA2NFFJREF3OXpSWm1TUi9PTjhJcDJnMmNFZTh6dkNJOEpwendUVDlX?=
 =?utf-8?B?VDZHek5iM0gvY3l2cVcvamphUHdBUUI3MkZpUEhGVGVoMjlZV01TdkMyWWVE?=
 =?utf-8?B?SzdRdXN5SzZBUzgvT0Q3Mk80cDJ4QWpvMFlCVFBNaFowb09HOHhXK3dmeGxp?=
 =?utf-8?B?Ky9lcWthemFkMi8wYzZWUDBmUTlMWmdTVUNaVDFEV042R2FuN3Zyb1FQNHBs?=
 =?utf-8?B?UEx4bU1sV1dtdE9kOFVEMUpGQVIvWE9USnZJRmJkYTQ2WG1hYmI5UlRReWFX?=
 =?utf-8?B?TjV1YnJzT3FaQ3RKSWY0YjJoMGgwNmpsSHpOR3pEcGxxSHdUQm96czlnd1di?=
 =?utf-8?B?ZkNnZ2h4ZEQ3OFRQUUg4UnRRUFVzVFU3ZEwxWXYxSTIwM1lTSW15aklyMTZw?=
 =?utf-8?B?Yk9yZWUvYlp4bktrSEdReXZaYTNHSCttc08reG54bDlaYTU5b09QOXRjUG96?=
 =?utf-8?B?ZS96ak9nYjg1aXJrc0kvOVY2aGx1RjhLZXZzaERTMWNFSXhXa1BIOGdHRG1z?=
 =?utf-8?B?ZUFiSzNuemlUalR6QktXd2U3MU10b0YxRVNLNFNBWkhRUUF3aEhGeUd3Y292?=
 =?utf-8?B?RHdnRHF0QWVrcUJpQVJMd000eE1MY0w3YW5LZUtpUTZmOWNGSHVMTFdXNjZT?=
 =?utf-8?B?SllvNlJwTEdVRDZRd2NyM3ptNDJTVi85VXRQTDI0ZzQxYmtEOU45RnZvc1VT?=
 =?utf-8?B?L2tCWlFYUXFpczBpUDZwclBHWUdXL25laEloR25DMVJEdlNTQmRxaVdNZDdk?=
 =?utf-8?B?WEFLZW9zcllnZGVWU0t6K2FIRkpHcXlTb1gzc1NCYTB3emQ5U3FJU3lWd2FY?=
 =?utf-8?B?WkZSZEVlNlV2dnlKaDg3eWRXTzlDSmQxU1NkbkhhUkNXWCtCL0l6YlozYkt1?=
 =?utf-8?B?UHhRMUU5T1dsR3ZEUUFpUGlEcHdubHFPSGcyanJTVElLMzcrMXdoYklsL2d3?=
 =?utf-8?B?ZkYrQmg0NGd4aWZxaWthNGhEWEVGcjRvUDJhdUlzOFoxNW9NWENCaXhGaDhw?=
 =?utf-8?B?VW9TZk9zZlhCclFNaTZQQmJkNVI1ME1yWkM1SFQ3czdEMkNEV3EvM2FXSy9m?=
 =?utf-8?B?c3Jaa3BaQ0xMYisxWGtCNVFaZUpXVlRLblNxd0l3YUpQcGdRTkJHbHFGdDJm?=
 =?utf-8?B?b000Yks0RFdHYksyVDRhaEoyTFlmL0VqSW1BNzM5MkJJSjJ0d3Q5REcyYk1u?=
 =?utf-8?B?OENvUHUzOGZyQk9JNWN3YU40Sks1RGkwZ3JLY3BtSlVtREFsQWhzYlV0eUg1?=
 =?utf-8?B?V1V3d3AxRXFldkNGOStBV2ZqY2RnMXBNcUZzVEROSUpmOWl6bjFwZncxVXBZ?=
 =?utf-8?B?TzhqMHA5bUhDZU9nMHR1bkZGRitpMUxVaThBa1ZOOEw2clE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDJ6Zm81QzVleXFaSWhKQkJ2RTVZUUh6SXNwRzhvNEdoRjhwOFhrTmdPbWJ6?=
 =?utf-8?B?WjBLWDRHblBmbTN0U3dnRGliRUhKQXhCaFFiZjJvT1BkZEtiTlpsbUNZVHVC?=
 =?utf-8?B?RXMyUHRKNXNrOVU4RHlsaS9kQlBnTU1nUUROYis4TmRqdzg3UlVxdlZHaHh5?=
 =?utf-8?B?MitXaE51b3VscnF2R3RCKzVzTWJ0RlN0V1ozUmM1cEJicEFBZmNTWnE1dEVT?=
 =?utf-8?B?eG9DRmRBd1lEZ0lHL3k5cGJyUEhZNlJieDg3czljTXQrSG1iM2pBV05KWUdS?=
 =?utf-8?B?UmswbDZVZ1o1ZDlLZG9sUTFoN2ZKZEkvajgvOUlJZjhCQUdscTZxU1lqUTZB?=
 =?utf-8?B?T0Z1SXRrMk94aDNhYUU0bVJjK2ZNK3pnL2FZK25BRmZxTkYrVkVoeEVrcExz?=
 =?utf-8?B?NUxjRmpOTW1Wa2VRa2tNeDJhcUN6RVZ1SGZNTVNmQzg1ZDRBd3h1THlsc0py?=
 =?utf-8?B?b0pLRFl6aXFTOGw1K1c4eTFXRjdFcy9YWmZqazlIWUFLVXBkM3lRWVJ6NVVC?=
 =?utf-8?B?ZTNxWXBDNEIrMWdrTDRuejI2cHZWOFR6elE5NWJQUFRPT3NveWk1V25ja0pH?=
 =?utf-8?B?V1dqKzlZZGlmeTcwWm5FdXBPVCtodFpsVTQ1MmUwK1IxNmF4VkZ5TVlHV3ZJ?=
 =?utf-8?B?aXFxU2pUOGkrazNLU05vNXRoVUY3QzBucDlqQy8rNVhzK1RHK1RVMG02MTEz?=
 =?utf-8?B?R0NxU1RuYms0dW1oZTc3dU9zbU9DdDBOUk1rbEdubVkwQzJDbGZHU1hEclRQ?=
 =?utf-8?B?WXdSYWNlakZHUlZUeFV5TGFHemdnQjQyeEVKSndJS1NkalhZaXIxMlIxWlc2?=
 =?utf-8?B?L2RlbXdzMDgyN0xleUhUOUNXZ3g2UFMydy95RjZHOWZsZXl2RTFSdWZsWko5?=
 =?utf-8?B?Mk5VVkxmZVdjK0s2SlAwMEZPMWhvTnJGYnZMVFdOdzFhR3JnVjhmc0l0VXpi?=
 =?utf-8?B?Vkh0Sm5XNkVQcWZCTFBhZXlMMmlYeGU2RjJzam0xS0xLdGUwbUJUUngzY1NI?=
 =?utf-8?B?bnVVdGtIZkY0MGpoaDdjM2xGWkhiOGViUGltZ01FTFkyRTU2WE9XTWlyUHlU?=
 =?utf-8?B?YVFNTlJ1SzFCem9rTnp5QSsxZDFOZEd1SXFSRWF5amJiTmZoS28zQzgwMVFy?=
 =?utf-8?B?MzF2Uk1Mc0N6d2IrdE9MT0xqaTlleW5EeTdDTUNjanB2aWJTbWlZZVE5T2JN?=
 =?utf-8?B?R3VXTWRnVzhRWlZQT2d6UmprTHB2dWd4VTFpbklmaGttL0dDU1VLd2J5aGJK?=
 =?utf-8?B?VWlNdUlLWXNpenl6UjR2Qi9XejhwZzd2Q2Y0ZG9sQ1AzZDBjM0xmUExYLytz?=
 =?utf-8?B?N09rV2RPSWNpYXhPU3J6N0tqaXRmTFYwSXFtWnErVXlJZk1qUUtLd0ZEOXd1?=
 =?utf-8?B?SkMxNDMyRGJvY0phMm9PY09UK1lGTFBvUUVHRSt5YWhVbGJSdEZqayswZWJ5?=
 =?utf-8?B?dnliMnFwOGtsK0FUVU9TZnFVbWVGVXY0dERVeTl5eVdDWFpwYTg2MVNrc0Zn?=
 =?utf-8?B?b3kwSnRrbDJGVGtMS1NHSk5VbVhSd04vS29nT2JuZnhRUTQ5T2t5RHNvcU5M?=
 =?utf-8?B?WG4yR1RNZFh6UmNsOVVkWFh2NENjVVlOVW9ZdTZPT3Jhb0lBSmd4TjZnTWpw?=
 =?utf-8?B?UGhVNU1ES2RzRTdDSDR0THBwQXFpQVJaYUl1cm9VSU5xQXE5Z29pMVVpMnVD?=
 =?utf-8?B?bUp4ZTVNb3RERTdua0FCa3hiajcxQ1JCU1F6S3RtM1NVVFlwVThxbXJaMEhJ?=
 =?utf-8?B?bkdoclRMYzVFeUdJS3lWUUE3MnVBUElkVVhaaFpudEljTEM0U3lDYWpQZ3U3?=
 =?utf-8?B?Y0thR3ZrRHhVQnpzNDl3dkVEbEZMUGZOamFpTHRjL1Vrb3ZRbll3dXQxV093?=
 =?utf-8?B?MjVzemxMRGhPTkNLOGxKUGhuMmdhZDdvWFhDQzExTlBqQURQMzBtb1g2b2t2?=
 =?utf-8?B?elV1eklvWCtjZzVYRVBFWVlqRkZMYk9HTFJZbms3b1l0RUZwbVVkaWVaSmJC?=
 =?utf-8?B?N2hsUGpUN0R0eUZwNklMWU0ySWpHNlMzTWJtQUh0akRjR0FCUUhOcWExSTIr?=
 =?utf-8?B?cnZuVVY1b0Zjd0tPeGo5Tkh5cFZ1NytKa0kvNHM5WXlaYXI3M0dqMitPc1lH?=
 =?utf-8?Q?19Vs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41E6AD772780B247A0FF59FB2D3114C2@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9e2f15-0101-4263-18c5-08dcc28f17c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 09:45:01.4550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUrDpiLCAPV5g1jn22Znco7J8MHR68Enr91GUQOzINph99jhx+dv4eBK2GA5M1O5PsAwXmf+C3Z6hl5lEZMDTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5031

5ZyoIDIwMjQvOC8yMiAxNDo1NywgWXUgSmlhb2xpYW5nIOWGmemBkzoNCj4gKioqIEJMVVJCIEhF
UkUgKioqDQo+DQo+IFl1IEppYW9saWFuZyAoNik6DQo+ICAgIGRybS9hbWQvZGlzcGxheTogVXNl
IG1heC9taW4gbWFjcm8NCj4gICAgZHJtL2FtZC9kaXNwbGF5OiBVc2UgbWF4L21pbiBtYWNybw0K
PiAgICBkcm0vYW1kL2Rpc3BsYXk6IFVzZSBtYXgvbWluIG1hY3JvDQo+ICAgIGRybS9hbWQvZGlz
cGxheTogVXNlIG1heC9taW4gbWFjcm8NCj4gICAgZHJtL2FtZC9kaXNwbGF5OiBVc2UgbWF4L21p
biBtYWNybw0KPiAgICBkcm0vYW1kL2Rpc3BsYXk6IFVzZSBtYXgvbWluIG1hY3JvDQo+DQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIuYyAgICAgICAg
ICAgIHwgNCArKy0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3Iv
ZGNuMjAvZGNuMjBfY2xrX21nci5jIHwgNCArKystDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYyAgICAgICAgICAgIHwgNCArKy0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMgICAgICAgICAgICAgICAg
IHwgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9zcGwvZGNfc3BsLmMg
ICAgICAgICAgICAgICAgICB8IDQgKystLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMgICAgICB8IDQgKystLQ0KPiAgIDYgZmlsZXMg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+DQpTb3JyeSwgcGxl
YXNlIGlnbm9yZSB0aGlzIHBhdGNoIGZvciBub3cuIEFzIHRoZSBjb3JyZXNwb25kaW5nIGhlYWRl
ciANCmZpbGUgaXMgbm90IGluY2x1ZGVkLCBjb21waWxhdGlvbiBlcnJvcnMgbWF5IG9jY3VyLiBU
aGlzIHBhdGNoIHdpbGwgYmUgDQp1cGRhdGVkIGxhdGVyLg0KDQpCciwNCg0KWXUNCg0K

