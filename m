Return-Path: <linux-kernel+bounces-398182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CF39BE77B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7881C23595
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE3E1DF74E;
	Wed,  6 Nov 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YgBiT3BA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YgBiT3BA"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905D1DF25D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895280; cv=fail; b=I9sse9EjN0Iuv2+kE1Ate/xMLeBJrGaT/T7Rl8d7cVx2F+Z6/8duHX4mZcg0yEF9xTizWS9m/rsxwmoDyISWQHVovqmqi25MU35P/BpGo/DuYKd6ZGz6YQd+Dat0xZXkiPu7ZbzxCh4cJljdH18isdI4LP4X/p7FF6FV01VgNlU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895280; c=relaxed/simple;
	bh=wzBf4HdVw/8Cb+TNiSJDouBrxnxf9tHpxq0BFty6YQQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cghdCM33X2HZS5g4UD7Fi9ArpK2QmNt4kR1fkN4mg8i/bUV9STt/agrrt2cODFQTe9jpn38MzV4ar4AS3aZK0NXtN8CiWFUS6uWwbHWyJlv+s/OOlDdcTK6xX6+eRyPBBN/cqfPaBA7ediLvuYRQnd9pNGhFmq8QtVvh/LyV3JA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YgBiT3BA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YgBiT3BA; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wbmX8QfZIZ7CO9SrCpIZs6fmmjRSTO0FWObV9mKkUojMrXq8eFYIYvN09aPE5NhMwxePl5gFMkk75J8FAeEy6nw/yoBvVR5zBxkP4JX2pAq1a3O2nJrQLOtIIR55u3w2lerkSV4bF/6/sE698y1N3bH1XsOKehjGoR50tBGnjbnhEwGRWvuV4l7vxFupTu4QiCUmBSmNg5za2IiU9Fk0lSs1RRSbzs3nWZkVmRNHJ9iNZsIhuC4rpDm+Wr6SEHufD9ad3bIXOE8eorTDrzqe/OaW6z38ch8NhgBjkhUdO2oVSAq9ORqUJOIQYMLTJOM22gX/RPxl2TODzaHHLsE5xA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha8HrlRc04RmffUIGqK9g3Ea50Sq/28GoA6kDm6wh+o=;
 b=qoB0tnDY0hCuX7sl4MAS18peFCVnncd0l3KDS7izA9EvLFA21Zu5bBee+tVRmNlLKvEQAi4bmnb52KZZ+x8YEiGhEm27RftiKb0vOD+sUpYR41/nfHFFFbkHHoRxW/q/XewRgYSq90HiKRG+elW06Zx2TNmhwxWLVQHbinnHXCveLDgiUZONY8vET8VYff1Tc5WodP01dzpUObzXIaBeFHq/c6+EnmfFCH9zb+hlMQtHx7BaV3mx9lQwwcA8YgTDIYy3WSElNxt5Ha3dINBwwnCDQU1Bf+U3vXSvWIMBUlTT5VH/bkL0pVgqyyq33SXdJlgnSe+cZz5F8cIOWw5GKg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha8HrlRc04RmffUIGqK9g3Ea50Sq/28GoA6kDm6wh+o=;
 b=YgBiT3BAzEKcmslYpMtf6I/ip2UGcySdtw51yasg9RTmGyPsKt+rTx0g8IwN2hJGJ/cIIONXtN5OU52kwSFhTw3SEiJsCdRGTg/n6OZB6D5L4ls+STQi3RUsJ0ohemsuRTmXhRqRxcv0NkL5rqLCjsJnpJwaXLKBVsm0lwQ05SM=
Received: from DU2PR04CA0255.eurprd04.prod.outlook.com (2603:10a6:10:28e::20)
 by PAVPR08MB9436.eurprd08.prod.outlook.com (2603:10a6:102:316::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 6 Nov
 2024 12:14:33 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::5b) by DU2PR04CA0255.outlook.office365.com
 (2603:10a6:10:28e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Wed, 6 Nov 2024 12:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Wed, 6 Nov 2024 12:14:31 +0000
Received: ("Tessian outbound 57fa7becdebd:v490"); Wed, 06 Nov 2024 12:14:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 17274f690bc471ca
X-TessianGatewayMetadata: 0y17ttSe/3rrwj+LpPuj8U5WRy5rYs4nHEAPnqdNS9duN80s9XUk1/fEFdt+JcXD7VnADNOSU6hJYFThgXYbHexpzX2bZ8q2hQUW7qFwN0m6jNVyvReF6Mj2wLnTBigcxFefSGFA4ClXnL4kGStbavn+hD7CiBpfZxiNYb31Lx8=
X-CR-MTA-TID: 64aa7808
Received: from La8df48f73af7.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C341866D-D418-4566-BA48-47E9E4D987F6.1;
	Wed, 06 Nov 2024 12:14:20 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id La8df48f73af7.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 06 Nov 2024 12:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIAAhbuj19Q0ziTbXntXnyPXumN4hcyesHm9MkPI7fwBLSfM8nwIjawGyZjt/D5r6aAMDsYTP2SuqNCbJMumWCrQslWm6NmhXVr8OjS+NI1eBowAlBuMoH5SsM8ivaw7+xY4QE5jZyx8J2G9XcKwbweZMHC29MC+XYflge/x3T9kGjdq2rL8nJIPQMN0viS3Zik28M0SuyH3s1OH+SNGL+XQBl9nnOcuF8r+ILALnnR45Jdm+p+stVGJal/GhGJ03O5diEKYl00GbWiQ75eszVwC6HT8xz+rH/I9Ro1j8vc30s/ct+6j3ljY60uWUkjhlXEN75zEdm/MCdZGS2HeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha8HrlRc04RmffUIGqK9g3Ea50Sq/28GoA6kDm6wh+o=;
 b=D6u76Su6onTLUy6Z6HZaTMzzMQ2Rp2OOE6Rrl3siKLhvOwqC7NeZdollUytDc+7XlU+lWpmfP+GmhE8Q6P4XqvtT2h5IkO86nRMPV99HmKc4lExntlKrnyYI9ZTLLQx72GxQdRGMogkAsz0n+E9pDRk1PV0hPz+nZOk00aV7a/rIKkzD/V9Yt0eQQMlZA1hYW83uoXTHhoohTSDSiE2H11pNchJO/mWblnr50xEEk6y+4hXr/g1UxRD7/WDQoa5NPUx86GTfp4WUiTjoDV6XqpLGKPq4q36Qal5CWdmXyEIFgdTMe60C8VIAQtURSHjpRs1v74LweKDNe3ZEacAoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha8HrlRc04RmffUIGqK9g3Ea50Sq/28GoA6kDm6wh+o=;
 b=YgBiT3BAzEKcmslYpMtf6I/ip2UGcySdtw51yasg9RTmGyPsKt+rTx0g8IwN2hJGJ/cIIONXtN5OU52kwSFhTw3SEiJsCdRGTg/n6OZB6D5L4ls+STQi3RUsJ0ohemsuRTmXhRqRxcv0NkL5rqLCjsJnpJwaXLKBVsm0lwQ05SM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by PAXPR08MB6448.eurprd08.prod.outlook.com (2603:10a6:102:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Wed, 6 Nov
 2024 12:14:15 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%3]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 12:14:14 +0000
Message-ID: <4e7bc9e6-f3d8-4e21-94d9-414ff0857553@arm.com>
Date: Wed, 6 Nov 2024 12:14:13 +0000
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Lock XArray when getting entries for heap
 and VM
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
References: <20241106120748.290697-1-liviu.dudau@arm.com>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <20241106120748.290697-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0219.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::8) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|PAXPR08MB6448:EE_|DB5PEPF00014B9A:EE_|PAVPR08MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3a78bd-6eea-43f4-c7ea-08dcfe5c91d2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?T1pwaHo2SEVDNzU1U0wvcU1ncXh0aFhqS1VveUR6RnllUWtmbHgxNFZ0WUk4?=
 =?utf-8?B?b1p4OXZjQWtRRFN4SnR6QzhOSk1VNVdNUGpIem44LzVOenVMSnQ2Vjk5THRw?=
 =?utf-8?B?TFpOSmNkNCtlbG5xZ1dJbExMazd2SFBxMGlEWlc2T2w2SHhGWnRmNkVzM2xF?=
 =?utf-8?B?NVF3RXI5RGhqNkJmUmRIRjh3ZGNQM0VRMnY4TDBKUitIQ2FOSUw0dS8wVDNF?=
 =?utf-8?B?cjFTc1MzVmlCZXFsUE5BUmUrYTRWN3lCWWZRd0R4QXBTUmxTY2FxNUo2ZXJN?=
 =?utf-8?B?bnJPZFBlWFlKZXdwUGZCMS9RckxzUHlEV1lGUFRJcTBvV21hd080dENYeWdI?=
 =?utf-8?B?dS9yanVuTGR4RVdpUDZ3a1EyWnV5cHFQVDJQNE53eFB5a0Zya290ZlVCcXh1?=
 =?utf-8?B?bFlpMktHSHZsWE9KdkxQUHV2bU9nOXc5dUNCTytRRjZra1dFbVB6SEIxL3JP?=
 =?utf-8?B?V2hkelkvYTcrc3lKc2h1VzVRbUFEb1EraEtia1UzcEpDeUVCL0RlQnJ6SXdp?=
 =?utf-8?B?YndBeUhmWG9maDQ4amkyN1d5QjQ0UE56aU54N3VkdjdRdis2TGN5eWZVY21B?=
 =?utf-8?B?TVF0TUhLRXR5eVR3YTdmV2l1bFN2V2NBdFFnRG5oK3JvKzhYTm9KUHRrREpV?=
 =?utf-8?B?MUdxeC9IM2d5eU93OHBoRm5uUkhQdXVENUZaRXpuZiszbU4xeW03ejkxbGJI?=
 =?utf-8?B?S1JmZ2pNQ2c2aThLWk50alU0MlBFOEs0akVWNDlMZDNWQVVvYTRFSUd1Q0la?=
 =?utf-8?B?bkoyYUppQUgvb0p4YlF4UVJ6U0ROV2RaRU5JK2tsdTU0b3ZQaFJUMzJ5M25n?=
 =?utf-8?B?Y0E1Y21JdTZib1FZcEg2eDBKNXlQU0xDWktLclpNdFEzWENEV3VXMXFWSlN1?=
 =?utf-8?B?Q0pMUE11bE9VRUlGY1dndDhZUnVQZ1h5UkRKbEpsMHV5RDYyeUlmNnBwMDAr?=
 =?utf-8?B?R1RMQ2tKTmF6azBJZVE1ZnR0R2tjeFJ6eGdQb3BnSmhYZ3g5amRMSDlObERu?=
 =?utf-8?B?VkhOQ1BZdnI1ZExaOGtPdkcxdC90STQ1ZjlHYWliNi8vbXk2TXJ4OW4rcFlh?=
 =?utf-8?B?NmJkRWJEeUdrTmdidWJlaHFJcmJWUnpXSW8ybjVJbmxITTNYRXlLc2M1Q2Vo?=
 =?utf-8?B?WkhUTXNNUGY5M3RVeDBQOUdYWjcyd2E5cUZ5V2p4ZmZIeGl0QzZMd1VuNHcv?=
 =?utf-8?B?L2p5N0J6S0tSKytBVGVkeERHNjg5UkZINkpGNGFSd1Jqcm95dWY3cnlvMDYw?=
 =?utf-8?B?cVJYa1JsQ3lTeWF3eDZKd2FFT2JWaFJTRUY1dTY2d2tkTE10QkM4NmJsbEJv?=
 =?utf-8?B?YjVWemorMFp0d2RLR0R2ZU9mY0RYUG0waTYrS0tuRnk3UUdZNFk5OHVybjM0?=
 =?utf-8?B?UThlYkQrdTk2d3Z3UktiR2dOU0l6VGVjMWxUQ2w2b0hQUVIraVpHeWtvekRZ?=
 =?utf-8?B?MUxjQWdrbkxKQ3lRNGh0ODNJRnBwWEpBZWdETndBM1QrMkRmQUJUVjBBTXdi?=
 =?utf-8?B?U2pMbittT25weC80L3JscklaLzRVbEhFQWwvakt1UXRSUm1hY0hLZUwxRGUy?=
 =?utf-8?B?QnhTeEZFdjNQYTZvQUJGUjNKRWxEbkZPSHc4MVpDSmZRYzIyZENrN2tnbjJs?=
 =?utf-8?B?SE9FQmRUNkg5RjArU2ZOYXFHMlh1VmRzQTE5RWJEaEIyNzNtd0Nhcy81bG1C?=
 =?utf-8?B?Sm1WQ25hM2lHV0trbWM3dXd0cWpjOVVCMGtmNDhTVktmS2h6V2FnNlBhWmt4?=
 =?utf-8?Q?NwXhCeE1nNwVQdkTBzQO0xvGD91b/5szgpKfQMs?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6448
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a9ad4ac1-c0fc-42cc-85e0-08dcfe5c87a1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|36860700013|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTNQVmVrUzNicDg3RC91MUs0L3RQb3U4TFNRZ29pTGNLb0JlaExZc0F2NGtJ?=
 =?utf-8?B?VlAyeFRkRzAxN3Jodzg4ZzZQWVFIN3I3bERaVkx3dmJURllQZnpzQk9vb1hM?=
 =?utf-8?B?RHlKSjJPYTVKbHRaWGp0eTZTenRJbmpvVG4yQndFaGVJQUUrLzB1U1E5UHlk?=
 =?utf-8?B?OGk5Z1VQNHB6YStuOFBwMzVHSkVFR1NNV2RkeXo2VjEyTG9GaXpKMUptNFYw?=
 =?utf-8?B?c1o2dWROZGFuZE1lelN2UjZ4VEYycmtLenN3M3BWeWR3UmpmY0c4bWwzNFhr?=
 =?utf-8?B?a1UzNjFOWlZ1NHlRaGYva3lSdmZZdTFhcVBtVUNOYTl4eGFNam9Tc0FPVHhC?=
 =?utf-8?B?dERRRnhCaHNBcDJ6TC91TEhJZFZrc2t2T0lpY2NVcnVnZEx0LytucTZ4eTdl?=
 =?utf-8?B?SEJ4MndkeFlZc2ZNY2tvZ3ZsMWNsN2VhTnlqSCtqU2FCaVlBYlhiSzI0NkUx?=
 =?utf-8?B?SnZuZkRGVEFvVmdMV21Db1dYT3FleVA5V3MwVjNnbnVkZkNvNngxNTNYeVZJ?=
 =?utf-8?B?TXRmRzBNT2VhREhoWktiU2huYUZtOW1GWmUwa0czanpVN3VmQXQxdlhwKzRH?=
 =?utf-8?B?N2QrbmliTDUxaUdVVEJwY0Y4b01WeTlQdGtFV29jSDdCMzQzUDZwNE00Uzlj?=
 =?utf-8?B?cGVFUnV6SUVXYXQ0d1drcXhxWDFneUo3OW1wK3JIdTFqK3F5am1QRHZweHg5?=
 =?utf-8?B?cXV5OEFqR1AzM2w5N2lZNEl1d0sydDZXaWw0OUZLTDdUM2pmY2FpdnBvRVJw?=
 =?utf-8?B?c0ZDQ3oyVkpDOTFjMUxOdnIyUDhCOWJoUHdQYlM2a1pWTlpjdU40RnNlQWdD?=
 =?utf-8?B?eURwbllGbG9HMFZRVnBScFl2cDBPcGJHZmkrYTlEdVhtQWFzblZYU25JQURq?=
 =?utf-8?B?RGY1Q213TllQSWppaUJQMW51QVk2U0hoRTEzU2c3VDNUOVd4bkRXWEY2WTcx?=
 =?utf-8?B?TC9SaU5TVnd5dEQ5UXRPclBlSnh1akwyN3p3RzlBc05jakx1blpBd1FGTXZE?=
 =?utf-8?B?VnZCNE5NR1IwV3AyZy9GcmRsdk8vYzhPVUZrZnFMSkpkZG92UnhhdldzdUVi?=
 =?utf-8?B?RHZpRDR4cGhHb1FMVzRLR0tMenNsa1NOL1hLQmdKd2lVS1lPU09ZaXFKRHJL?=
 =?utf-8?B?NmpRcTB0VWh3ME1PL3FxYTdkVTZQcXpiL1pBL0cya3orTTdNZU51QkpQSG1C?=
 =?utf-8?B?OU10L3hLNzljc3VDN3BDNnF0UldoQ3BpRjN0UWNHZERFa3VyTVRrRE9JdFdk?=
 =?utf-8?B?bXV5UTRrT1QvZ1ZqeURzT2Q4dlN4MVBHMkt6K1Z2dTg1bnkxdHlpTmNqZnVz?=
 =?utf-8?B?cHBkRlVCRlFEUGxSWnJSWFFpdk5lZlZpelM3dzRZMjNTNmJteXhzUGdFVjZs?=
 =?utf-8?B?MGYvOEhSSSs0VzF1TVk1eG5GM0lZdVYvSDQ1WXdDNWs4ZThKQmc4R0RrUGMy?=
 =?utf-8?B?KzhjR0NVaTAwY3AzSEhrY0hua2VCa1dVeWdiR0pGeFpQTm5xVjZVc2liUExZ?=
 =?utf-8?B?RHF1VnNyRytmZE5SYzBlSTNmNFpEVWFmZThRemdlQ0JyVHpld25CSndmUnBO?=
 =?utf-8?B?NjgxK0hYR2dxOUFlQjAwN0xwMWc0aitoMEJudE1hWDlmQ25ZYThta0JmeDRj?=
 =?utf-8?B?Qm5Gb2dxekpwTHR3bk4remdHYTlKT1l0ZzlIRzVDUmFabHJtcXlVWGwzRDE3?=
 =?utf-8?B?Mis5VGkzdXRuSG1WYWFrS0FYU3ZpNDJpbFM4TlIvVkl6RWEzckFvYTBkSk5p?=
 =?utf-8?B?OFBWYWcyUUc0WXJZZ0d3OWpxSHlaZ2VlNWFnc2p6YkFsV2NmWUowSDN3dkw3?=
 =?utf-8?B?dVFLTGtqdHE0dXN6T0FwRU4vNlZ2VWFQYVNoTGJjaDc3TGpBZTZiY2tiMUVQ?=
 =?utf-8?B?OFc5Vm13RnI0NEpsSDN5VlBRNDRSWGY5Zk1PNXpGd3E2NWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 12:14:31.6099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3a78bd-6eea-43f4-c7ea-08dcfe5c91d2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9436

Hi Liviu,

On 06/11/2024 12:07, Liviu Dudau wrote:
> Similar to cac075706f29 ("drm/panthor: Fix race when converting
> group handle to group object") we need to use the XArray's internal
> locking when retrieving a pointer from there for heap and vm.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>   drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++--
>   drivers/gpu/drm/panthor/panthor_mmu.c  |  2 ++
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 3796a9eb22af2..fe0bcb6837f74 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -351,6 +351,17 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
>   	return ret;
>   }
>   
> +static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
> +{
> +	struct panthor_heap *heap;
> +
> +	xa_lock(&pool->xa);
> +	heap = xa_load(&pool->xa, id);
> +	xa_unlock(&pool->va);
> +
> +	return heap;
> +}
> +
>   /**
>    * panthor_heap_return_chunk() - Return an unused heap chunk
>    * @pool: The pool this heap belongs to.
> @@ -375,7 +386,7 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
>   		return -EINVAL;
>   
>   	down_read(&pool->lock);
> -	heap = xa_load(&pool->xa, heap_id);
> +	heap = panthor_heap_from_id(pool, heap_id);
>   	if (!heap) {
>   		ret = -EINVAL;
>   		goto out_unlock;
> @@ -438,7 +449,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>   		return -EINVAL;
>   
>   	down_read(&pool->lock);
> -	heap = xa_load(&pool->xa, heap_id);
> +	heap = panthor_heap_from_id(pool, heap_id);
>   	if (!heap) {
>   		ret = -EINVAL;
>   		goto out_unlock;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 8ca85526491e6..8b5cda9d21768 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
>   {
>   	struct panthor_vm *vm;
>   
> +	xa_lock(&pool->xa);
>   	vm = panthor_vm_get(xa_load(&pool->xa, handle));
> +	xa_unlock(&pool->va);
>   
>   	return vm;
>   }

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


