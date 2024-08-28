Return-Path: <linux-kernel+bounces-304895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B6896265D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D99D1C20401
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA71C175D38;
	Wed, 28 Aug 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="g4nq0lHx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="g4nq0lHx"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6871155352
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845862; cv=fail; b=PCLlNUbvgp9zuPsbKNS6iIZFcEaDX7kpNLGzoCr6HtksUmMMoQit/6kTQ1rEq/vTvLHr9ZQyD+jaM8liLf9le62kLOfSh2fDMRvPqKIdQoFkKrJtxYrpjP8VuLdn1VfXOrA9WMVQNj4xEQzalMAX+SxeXoD5WAJwYWMrLEowdRs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845862; c=relaxed/simple;
	bh=vCSr4iZDeMSJ/M1meaexiqJjVAl8ONzflxXnun/HWhQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3EUM/26tw/udM5n/K4ZRSzS13WmnemGLRDPxgXzvVKZZNfGub0stsjtZkyNGctJy+tOyUaOfO1UqjmuCDWJP7LrVpwaeNzyElKlSbJI5pmstRMIhA+PcxmCqRHNbk8j0X8ujg8SXYaaNsYF1tAguHqMj/u6hEAxaJG2wtuyV9w=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=g4nq0lHx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=g4nq0lHx; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DzM+D9ZNvMGS9uT6NdXomP0RlbQx3tw8zZVXofoerkZVWGwADMqQPpdLylNylzencHVvMFBODrgAoklrwZJh92z6OrruMlaiO4CE76YwHyIP9feJj6LNy84RbYnfvn5XIgIFvVT82+XXVacmKrML2om0OmhR367Sxz3mf7pNkv0V9BRIKwjS7QHVF+FWSSyrivm8GmV3DdAEJICyBh9WLpo9cdmK2NDEQ4mMn8r3Q6ahIAHqhB6QsxqW9FJ23+CdkQYzlI9FCW7KxL+taCjMjPTK0Q6va8u2rf14YClMSCa55v2dcLjIDq8OjsfjthqmgvkodN9RvnDiFozKiQRyHA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxrUs/5E/QobLjcEurY4bLabW4bcaN36q8hYEqVGdxQ=;
 b=sxTActSXxKJHvv6W234ICm8ECFuQgfx4QqHwvrCPJCDhJVl2XajtJ/BIzxK/rQ66PEOfGMzcVSeg6eU46tFCZM92iIlPN41L1xnIZmr5FbgqgRKFVI6vg1nKwaiokhsAkMAXkcHdqPWREdlnuZhZLUP/RxTbbZAl4Z17A7VWt58s80FupJw2QUmfQXsQv9/HtN837mHAMJgfoaf7m578ltvxdk6fZFFJi6VcvIFezBOMCHyMAPOZ2+U40QGdGT87mVUB/xN+6ycyy8zrXTRWis2aZIIu+WVud0UZUsFtunwwc4JiNY3mMhjJ/chAeBDZVfKPolH2VjO0NNDjV6YzFw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxrUs/5E/QobLjcEurY4bLabW4bcaN36q8hYEqVGdxQ=;
 b=g4nq0lHxpHLPDlqwQo1UfATx8F0RWX64EL/R1trncCfohDUznmyc4Y6c1G+uz0agKAAQ+TmMaT1tfsAe8Ze3rS34y/iyRMyWQj1nXD0bkNysBG901v5xzosqMQpOpTT0De3lFYymklvboXp0c4t/5AP8ol+WZF0FceBily0/xGI=
Received: from DB8PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:10:100::21)
 by PA6PR08MB10568.eurprd08.prod.outlook.com (2603:10a6:102:3ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 11:50:51 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::d3) by DB8PR06CA0008.outlook.office365.com
 (2603:10a6:10:100::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 11:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13 via
 Frontend Transport; Wed, 28 Aug 2024 11:50:50 +0000
Received: ("Tessian outbound 8e666bd17457:v403"); Wed, 28 Aug 2024 11:50:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d47d644ecabaaf3a
X-CR-MTA-TID: 64aa7808
Received: from L3a06678c8dab.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 71C472BB-51C4-4872-A931-EB0ACABE24F6.1;
	Wed, 28 Aug 2024 11:50:42 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L3a06678c8dab.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 11:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPn2EBkGcuBa7V6Ihfg0pAbxcDQ04TO5H0Uv7GOB9ISp63vaZ51DRApJaRQpSfRakESkp1iaIKsVVdLPG8lP5+Pir3A8o5CzCB9SQpxhnQlziUxdNmp2EOjqFNyKnh8UuQwKknGCxCi8TV+k/38AHqDQ2oHhuWvsl/SG4XzqDeUUeEg6kdHrO2TkSiQGrEU5CWtzYOcnfWm+TtbVPKjXAHTkpWQ7hJHFo8P3NP2srnq6PyBabivMAel1iGwbWrFTviZ2uBw9KaQrTRTHRU1ybfUgkOVBAvp7sKxfqpnyxA8lV1TAASvQkD3DIuiHBdcFaDhv9GvjcJXN9cCaXKDggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxrUs/5E/QobLjcEurY4bLabW4bcaN36q8hYEqVGdxQ=;
 b=wB1whIiGvSCwcYyG6SIaANyMCRq1e3e1lJdfDzhRn3bvfUjemA51oySNzCZ66T33yyObB2Uf6K/Ara0d1UU6JgZP/huApbDqbSFlR4huhKq6kYYy77MHTqOUoY5zzbxq0LVSaq4MCYWGQYpu8sLfhMQw70FW++w70YpbrIjllFQPJANqnCeQOVxha3pdvU2ND4P4KnNEdRCXGPk+O+tZzZneW4iLYttOz3Y3YqT9/rMqITCGjaOBEf/elAg+/54zeMBW/BI7UzUnaaNLQi3AHdHIMA13bn8EbNpTlZiDk9xcsDv0y1zBg1yBAQUPo0TjO76nYGViI2vDPXSrLHBu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxrUs/5E/QobLjcEurY4bLabW4bcaN36q8hYEqVGdxQ=;
 b=g4nq0lHxpHLPDlqwQo1UfATx8F0RWX64EL/R1trncCfohDUznmyc4Y6c1G+uz0agKAAQ+TmMaT1tfsAe8Ze3rS34y/iyRMyWQj1nXD0bkNysBG901v5xzosqMQpOpTT0De3lFYymklvboXp0c4t/5AP8ol+WZF0FceBily0/xGI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS2PR08MB8286.eurprd08.prod.outlook.com (2603:10a6:20b:555::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Wed, 28 Aug
 2024 11:50:41 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 11:50:41 +0000
Message-ID: <b3522d39-89c9-44cc-b5cf-0c31c1b30e00@arm.com>
Date: Wed, 28 Aug 2024 12:50:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Mary Guillemard <mary.guillemard@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
 Christopher Healy <healych@amazon.com>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20240819112508.67988-2-mary.guillemard@collabora.com>
 <20240828133042.4b731826@collabora.com>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <20240828133042.4b731826@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0033.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::21)
 To AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS2PR08MB8286:EE_|DU2PEPF0001E9C3:EE_|PA6PR08MB10568:EE_
X-MS-Office365-Filtering-Correlation-Id: 9143a5d3-9f85-42e5-08ab-08dcc757a9d0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YjczSS9sWmJ4QXU1OWFMVlV0TDNvSFpOTWNad3daUzRFTW1LeDM1RGhiOWNF?=
 =?utf-8?B?VzhGRGdweVhHYkZSUU1mS2VYTmEvM084TGw2Y1FvQkdsNnR1eC91SmFrK2Jp?=
 =?utf-8?B?Tklpc0t5ZkQvNno3TjBsVmtMMFd4a3lnSTg1U0JrQWc0QitVN1ZHS2FEVzVy?=
 =?utf-8?B?ZHVqVEsxcEoyT2lQK2NnaUVuSVRTNzdmVXo3cEZYUnNCWUVXeEhPeitRQnJh?=
 =?utf-8?B?WHpOcDFkSDlodHQ1WmVXYW1CYlVVTERlUHlGZTNQTGVjUmZ0dEhPMGZsT3pM?=
 =?utf-8?B?V0tFSVA5THl0elNUQTlNM0w1V3hPOEoxUmVmMTkrQWY4VnA2Q0ZFeGxOZkJ1?=
 =?utf-8?B?dW00UHdCaTJGZkVuYkRMUWRWTGNPejgraUFvZUtadEh5UG1zZ083bytVUUdX?=
 =?utf-8?B?eDIrcjNWeE1YUE4vT2MvcFdDOFBMdTZINVd5b0JIK2l3N0lDVVYrVFJEYzdh?=
 =?utf-8?B?VVBlV3dNTnowT1c2ajZFNWtDWFlyMGZYcEhza0tzVFVXNjh4SkVXVTYzaW5V?=
 =?utf-8?B?MXQ4eVk5dHNLZGgwanpDSDBkQlU1eEtxTXVaT2c2cmlCWGdqME9UNFZqK0x1?=
 =?utf-8?B?bkZsRENPRkV0aitxTzhLQXN3VVlBVkpEV3VIVktSbjk5MGhBWTN6Nlg4bGNI?=
 =?utf-8?B?b256MnIwUkwvWWVzK3Z6b3lRdUNnUzQvK1JPQkJtZVZpV0JwaXZxNVlMaCtp?=
 =?utf-8?B?Z2FZaUROaEFETThTVkVVNUF2bVNsQkVpbEk4SlVUVUZvYmxQYk1reXQ2ZS9r?=
 =?utf-8?B?b3FEZ0RLVFB3ZHBkcFhLTmlXTktIS0ZyV0RYejdvdUx2R0FjTTZGNDcxNzFG?=
 =?utf-8?B?NVg1a0kvbnBtSVF6N3dEczlDMk1GS2hpNjZJM0lFTTZIdm1rQ1JBWEFEd0NV?=
 =?utf-8?B?NlJ0ZHcxQmg3bGU0Wkd5S2ZSK3FINnVLRVpTK2lobHBXejJJRFlKR3RqTTJV?=
 =?utf-8?B?dHNSaGp0c1dnTWZjV013bHVrQjlRYlAxbDNaZkhKSUZLSVdZQUYramxKZkxF?=
 =?utf-8?B?ZTNpcFZkR3RJQWpOcFB5L3daclNPbTBKSjFETTQzamRLNllnVFE4Y0ZTd0hD?=
 =?utf-8?B?Ry9iVDZOQ2RQWTdiZEhOSmw2eG1xZVhheFQvci9IS09MM2pYUFBzcGtJYzdO?=
 =?utf-8?B?SmdaekN5OTdic0FKc0QreFpwZ2FxNU1zWVkxS1BzeUl2UGpEZ1ZiZ3RLeGVk?=
 =?utf-8?B?U2Nac1VpQlFQVkVITHk0UzJybFpEMk5vVEZyMXZ1eVNWTVo3dFg1c242M0Zr?=
 =?utf-8?B?Mk0zZmpySjJrOTVPVFFRSThWUHArODVERnJvMGdtTFpqN2R4RG84dlh2NXQ2?=
 =?utf-8?B?RFF1VUErVVhOVTBZWTZ5eUtpYVBBbSsrRWl0dzYyZEhoZURPcjM1RSs5bHR5?=
 =?utf-8?B?NTdrak8wMVhBU0JPWjhJR2FVUUF1QVRMb1dmM0FDSG4zeEdWUU9qQVpYNDF0?=
 =?utf-8?B?RVNIOFl3ZU1acHp6Y2NKR0pQS3k4dzFsUlJZbUdraTZndTNjNGgrdmpsNzln?=
 =?utf-8?B?SmQzNDNSYXZnNHRVUlZjZmNhRGF1V1FyS2syWXgwOEFzOENBbnkxY0U5K1lL?=
 =?utf-8?B?WlA5RHF1b1ZzU0djaVZtT3lKbEF2Z1M0QjIvQjV0VUE4REJXdjBycG15NG5M?=
 =?utf-8?B?dzk1S2ZubmpVcDJ3NElhN28yaEU3TGNOR3F2OUJheG9vNEJ3WlJ6MjRWS21C?=
 =?utf-8?B?Q2M1UWRWTWxUMlY0akdmMUQ3bkYweTJJcFNIdWszeUpKLzZLYjlZNFZoM2tX?=
 =?utf-8?B?VVpITnkyU2dIMlRGcGxGK01FNklVQjRYU0dFQ0pCNmp6TTNmVnByNnFPbE9M?=
 =?utf-8?B?Tk5VSURuRVBJZm9nc3lIdz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8286
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3eba8f0e-38c9-42dc-03a9-08dcc757a410
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1JOdGtmVWxoUkxpem92WnVmL2w5UTFCeSs5L2M5a3RmdkUrYTRZWkdEall0?=
 =?utf-8?B?WUkvbzRRTk1tVjNuLzl4VDlyTTgxRC9sQTZHejJjWmhrZk5YTDQ2b0VTTExE?=
 =?utf-8?B?NDVEQkdYY21aY3A0VWxFZjhHSVFBWXJoSEpoUnEvRjFDdThPbEwxcGtxTmN3?=
 =?utf-8?B?K2s2QnJydjNqWUFpc0ZWb01xbnpPUTdpUmx4R1FMUzU4cGYwVXhSeTRCSG5J?=
 =?utf-8?B?VTlFQUxZeENYVXcrVzl2ZWgxNXBXbHV5Z0hwMmI3bG1YVzRIVUR0YVkzRm5D?=
 =?utf-8?B?bTJkbFcyWFFaM0RoV3g0eVNRREhBaGVKM0JNY1VTR3ZXcDBTUHJhTVFncU5O?=
 =?utf-8?B?OW9KcXpPdm1lcHRJRGdveTNYOXdQSFFlb2NpR2JJZ3FuL08wNHJIL1oydEUx?=
 =?utf-8?B?N2ZmQXFoSXlVOFVZZnN1UU9OOXFQMWZaZnpjL0EyRitFMEUwMVdzSWNwVVlU?=
 =?utf-8?B?WG45R3hjbDNsTkdTa1poYjhuRWw0b09wUU14TDdadWdSMWRVMHFJL1c5OFNP?=
 =?utf-8?B?OFlaS0VRdVJnMWFGVW9mVEZrTzJUUUNiZ3BnR3JXeGZSd1lhcFMzbzVoUmRz?=
 =?utf-8?B?VTFDaWg3RjArUHV3aE5WV2ZBSkVLNjRtUjI0NnoxeDI5S1VYN2U5ZFEwdnlJ?=
 =?utf-8?B?ZVpWZjNEQVJLYlMvWGdHOXE3Ny9URGlwQ3QxcWI0amdnOVhrL21VcGdhS0x0?=
 =?utf-8?B?T3B0OVhqZWRJZUVEa2o0b01teEkrbTg3VkErclhPRm0wWVBEdk9BODNLelh2?=
 =?utf-8?B?b1Z0ajN5aGxlcm5vMVJLZkR3VXVReFpYbk9zRDU0NE9lRW1EV1pOVGxJZWNP?=
 =?utf-8?B?blpaRVVKVGF1YkxmcnVhUXY1QmFpSW94VXNUdlQ0ZGlGVHoxaThCOVpQZDkw?=
 =?utf-8?B?RDd0djJYdDdYeThxSGU2Smt2eURGWWYveVVQcEQxTFp4aVkzWEVVME9xUUkv?=
 =?utf-8?B?eEowdkVnclI0aXRXQWNGVjRiZ0VyeUtLcUp4ekd6MGtPejRGMUllUUorT3li?=
 =?utf-8?B?TUtRMmIvemwrWGltS2lTNXRHNGQ5NEhZTlpDSldsc3dvRjVCeVNZb2ZIN0xU?=
 =?utf-8?B?czBUSjBObnpJRmxxTFlKUDc1UWZPT2ZsRHdTaUU3Z2NhR1R0MnZhY1E0SG14?=
 =?utf-8?B?cTJ6dzh6TEVjN1NRTFBZRWRYZ3VYQXBORkQ4SWoyR0UxcFF1THFscVBRZStO?=
 =?utf-8?B?OWV3N2oyMUhHd2s4VGdrVTNSYklMT0VSeCtmSjF5anBYK3E3TncxTWtlOW43?=
 =?utf-8?B?eGZvcVNwMjNwOGxwdld4UUVhRW1USUpPWmV4bWR0VFNwM2pzT1A0QUJ5UmVz?=
 =?utf-8?B?Y01MZmdDWjVzR3VIa2E4ZnJ3RHFNOUF6WExWK0JCMmJLUUVmTGJsaXNzemRq?=
 =?utf-8?B?Uk5LZzBobHNDSWxEMmRRUUphWFMybE5pMnBsbkRnZ1p0bGtoRit3dzBVSDdK?=
 =?utf-8?B?cTl4aVlzWitDMXp6a3VBRXBvalVYZWR5VnZVc0Q4ZWZzeUZDUW1WQ01NV041?=
 =?utf-8?B?a3ljNUp0MFRvYVQ0NzF5SGgvTVhPNFJvUDJPUTZ1SkhzRExCTmtOb2d2ZENE?=
 =?utf-8?B?RGxRM01SMy9pN1N4NzBDTGV2NFYxK0I2L0NndzIxS2dkVTBlSXVpNG9YMzZP?=
 =?utf-8?B?WEVmL1hZNC84b1RMY1VSQW9Jb0xJSGJWRXZSMHQ5WTgrdGcxenhoZUFCaGln?=
 =?utf-8?B?V0pGUUJWeWpMZ2hlZ0xISzI0SlI1TmNiRk1FRFQvMTgyQnBnQmx2WVplNmVC?=
 =?utf-8?B?KzVxMlFicUFIcllsUDBjb25LcnRRUjJxY204VUVrNWY2MUZYRzI1aDg1Y1Ew?=
 =?utf-8?B?VC8xTEVWaGIwV0ZrekFUSVhma3RPWE9pYW1TS0ZuaVZCaWpKN2JFL2E1SlZm?=
 =?utf-8?B?bWRMbDNqRnd6ZjVFUHN0NkQxQzBGOWdUZkpnQUlSVmZWM0tMYXBTTTlLamNl?=
 =?utf-8?Q?oWJGtJRPt0Q+Dq3KHPIrlL9KY/4l9smp?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:50:50.4520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9143a5d3-9f85-42e5-08ab-08dcc757a9d0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10568



On 28/08/2024 12:30, Boris Brezillon wrote:
> On Mon, 19 Aug 2024 13:25:08 +0200
> Mary Guillemard <mary.guillemard@collabora.com> wrote:
> 
>> +/**
>> + * struct drm_panthor_timestamp_info - Timestamp information
>> + *
>> + * Structure grouping all queryable information relating to the GPU timestamp.
>> + */
>> +struct drm_panthor_timestamp_info {
>> +	/** @timestamp_frequency: The frequency of the timestamp timer. */
>> +	__u64 timestamp_frequency;
>> +
>> +	/** @current_timestamp: The current timestamp. */
>> +	__u64 current_timestamp;
>> +
>> +	/** @timestamp_offset: The offset of the timestamp timer. */
>> +	__u64 timestamp_offset;
> 
> I'm not sure we should expose the offset to be honest. It looks like
> something that's related to suspend/resume which only the kernel needs
> to know.

Just for some context: it's necessary information to verify that the GPU 
timestamp correlates well with the CPU timestamp. It's untestable (in 
userspace) without the offset.

The struct can be extended later if really needed, so while I'd like to 
have the field stay, I'm not going to argue very hard against removing it.

> 
>> +};

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


