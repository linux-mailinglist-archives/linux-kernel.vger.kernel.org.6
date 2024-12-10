Return-Path: <linux-kernel+bounces-439227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5929EAC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42ED8163D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3C2080C5;
	Tue, 10 Dec 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NhLzQdFA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NhLzQdFA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F33DABE4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823373; cv=fail; b=olBQN13GsZyBCwR9AHbhaWEtsgLhL+KBeM6gY4gheraM2amAbeUb6PID9i45UuKD4daEdxPZ0IBoylEV/w+7oxpJqfx5qlmHvapQoYVqYnlkYFs5wcisruTpdoYmLl0PP4hZn5IBjj/rGQTrYsmklsXwcLJzY1jmBozFp6q3Mqs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823373; c=relaxed/simple;
	bh=2erOzXLa8cMFU5PpKLOP8HDodQKPqRnEqBUkMRfjjEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GlNOylGz6xIPnq8TgiG9pmNgACzJwgKV40/adUnQUZkJGpcTsSgDMI6KaodNHbVUYDdL5IYh9ndRmJkXsS1SyD+8xEhWFAPEFhwsLAjOeUbBHB+bNSoiyZoV/q2oU+62//KLl7SBm4g9uGA9Kq/pKBHiPtuVXW0kVeKdRDLNtwk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NhLzQdFA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NhLzQdFA; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aoq77uo3Zdxn0FuQpdRWqASlkwlktjDeF21ed45SGpHZtA+vIGrkN3g6j5jSYkKT729CFB8ZChZuUST8HMbvg0gfPMf3YVOZd+GWCpkYR87BW9U1/A3lzgR9fWzrl2+L8mWoLMj2BxYFY4ozOpbuw5eGchgNgfriI/H2AL9nl9s0WIuPBShpQfZ4KVlOagczgJh3Smf8AfzHC73RvXPu+Z3ZaH5l88UqC26rRRvMIXOwUn6ir7bbcNf7yZ2DBq7BgzB6Hh5XUp1y+zoATzw6H0T97WPGtPdUUMKbDrGJ1CAVQvs8tpJOk7De7NlNwCQaZlsTXoxwLisafYKfQieZVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W5YPbOuWNXK/WgaN0UD4jtjjMRT8CarJqibKLKKgAE=;
 b=c6VSzcoO+thqT+IVHC1KbalfxNn7lcj+wPhxnn3hsvsVZ0Rgh3uGVzweiga9w1WErCBjZBPrLPcLykWDqwVEqQw9mbjEmmIQdpik4tKvXbApHP18FoPHHuwUrgH4nqSKoQYtYK9gkSSlHRiXY+QWMvyp3JyrUXOQSbnuccuONUU2t1nP7lPxyMHF6rwBliB7gNuI71Jy6zxA7cWN1nq926VzW6+aAfcW9UpBI0der+6zoQSgyvXcqdNOOvfAlGUIdMWagHaDQSt8CFJFRCPf081IlM8SOmxT2L3pXhzGCx0EI3AFNl7v6g05xk3gGVyGcfeCQuLlT1+XfEebg4EYZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W5YPbOuWNXK/WgaN0UD4jtjjMRT8CarJqibKLKKgAE=;
 b=NhLzQdFA27PcimDNXOTiS3yXzc/W0QzIvGHpgsbU7G5oKUg5y1xUfsvTTbfF4PReDsN0f4m6KI5qMhtSgFLn+brwcz3egsQR2iYwooTdWbDOINu91AQ1q8TDIl0TkJ6uHa1npzynDU4VUMbyPrw0k19FpFFwgGp83bZjp6Ovhac=
Received: from AS9PR06CA0202.eurprd06.prod.outlook.com (2603:10a6:20b:45d::32)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 09:36:04 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:45d:cafe::da) by AS9PR06CA0202.outlook.office365.com
 (2603:10a6:20b:45d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 09:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 10 Dec 2024 09:36:03 +0000
Received: ("Tessian outbound 3df7a8fbf509:v524"); Tue, 10 Dec 2024 09:36:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ae228c32c5c3d83a
X-TessianGatewayMetadata: kngRs6acfCVUfj6D8d/+PJrtW9gXhpe8cw2j5KfRAwI9SG10gNwGVeMfM4/dQNpY+/7pQg3EfK2rrfEWeNKHXNjgKSZeHNV9WWzrizY/vSRXyAYijddvwVu5yS/vaUreL9fj+b/bfTMxiRBZWltmTb6Vrvwp8BR1PW4/hYM+bmQ=
X-CR-MTA-TID: 64aa7808
Received: from Ldad54e930cfa.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E018F170-03DB-4819-AFC5-8DC0D7562EE7.1;
	Tue, 10 Dec 2024 09:35:57 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ldad54e930cfa.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 10 Dec 2024 09:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJwAh9K7MWgxM7esRILoBmnOvM4g+5w/OUyg/5etCq/xUYKVtx41FT+rZP5mwW/ExviWZX6ckfrGz0399Wyl/l4c5Gw4wJmJmEJkSzQjhSuTnIiGvdxDbilulaNN7fzXurIwDMLv0c95kLJ5jh8VfkDrDjqygyxXDPbhAN6JBFnXeuiclvzLVSkZdomo34vDld+AVfgCN3Z9bTE44wZInHLBXFw9Xoxh/KklI30+CWDh8YOYUitViRmpE5VfT/gJ3LTFFTK6D1Tn3rijmj3iUMIV9avEoEpopKAL9ddZrJqMQ8v754PaT8tljvHMyu76bioazv39b+EfRFmaxGe9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W5YPbOuWNXK/WgaN0UD4jtjjMRT8CarJqibKLKKgAE=;
 b=Tyi0xWB7CKYqZunjSX99ZGhsaJfhO8tNXJ3x10L42kMXPfBAnoopcdJ4XivBi4W3I1VBAHjDn5Cd7UITQ8q/9sUsYxR3oGWfmGyjm5T2yp0yZYq2Ws5tkbJPVP5m9TDGCsbTjSumSPvGxs1XYgBB/fMEfA1Xax/LdC4RfxnO75JqiixjWIVftnbtgdRMpcayJb/hRZqW8TjvNnloTsRYxVoJ7FKyadxpOy8iCw4lT3Axbr/DwqKECztxkx9+7TvVKkIAIz/izGnTJcXe4HT9SY1JiH3HF0DaQMegoRnpTEAjS/jVqbxMU/ecmazcYlLD+unNfK2AamsUPqZ5ar50mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W5YPbOuWNXK/WgaN0UD4jtjjMRT8CarJqibKLKKgAE=;
 b=NhLzQdFA27PcimDNXOTiS3yXzc/W0QzIvGHpgsbU7G5oKUg5y1xUfsvTTbfF4PReDsN0f4m6KI5qMhtSgFLn+brwcz3egsQR2iYwooTdWbDOINu91AQ1q8TDIl0TkJ6uHa1npzynDU4VUMbyPrw0k19FpFFwgGp83bZjp6Ovhac=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by GV2PR08MB9926.eurprd08.prod.outlook.com (2603:10a6:150:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 09:35:53 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 09:35:53 +0000
Message-ID: <7e62661d-03bb-43c9-b15a-fda0a379497a@arm.com>
Date: Tue, 10 Dec 2024 09:35:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64/sme: Reenable SME
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
 <20241204-arm64-sme-reenable-v2-5-bae87728251d@kernel.org>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20241204-arm64-sme-reenable-v2-5-bae87728251d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0427.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::31) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|GV2PR08MB9926:EE_|AMS0EPF00000198:EE_|VI0PR08MB10427:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e29d10-5dca-4c8c-a9b8-08dd18fe10de
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SjJkRXhvUjRhM1h4bllYYlhGNEFtWGZnZ0p5T1k1WDJiQVhZNzB3K0VkRjZP?=
 =?utf-8?B?WnFBN2NDenlYbTdjNUV1UzYxRGJwVFo3b203NEtTbCswM2pBaXJkSGZhQy9W?=
 =?utf-8?B?NmdHSXhuR2NSK1lzQkN5b1hDcnZwNW5ZMS9uc0t6NEk5bEJyUHZKYTJlbjJW?=
 =?utf-8?B?QjI4OEdUY3kyVlk2Q2hmeUxjYU1OdHJEdXArRXVHcmRsVjVxdCtJRnNUZW5O?=
 =?utf-8?B?YWNtb1lyeXNhd29CaC9ORmJBRFViRW9IK2c4Z1ZOY1AyNEVrQ2JDT0ZheWxX?=
 =?utf-8?B?c2VoVkdlWnNMdDJsY0dkbnJLcVQxT0RDb0JiT3hFUkUvQzkxd29qMUx3a0F6?=
 =?utf-8?B?MEZDRk51alBDQi9HeVlCenhvemdqdXI5Ym5zUlZ1UGI3M0tuZnFoMFJsRkJx?=
 =?utf-8?B?SWpUU3NDWHM4ZVdtaG5idCtLbXA1czdhTXRTTENUSVlOM2psZVIxMXVXZGhP?=
 =?utf-8?B?RWhJcjNvSlN0dGNEdWcrUENDNndxWlZQMFFjNmhiMDJsMUlIQmtuZWJRNkZH?=
 =?utf-8?B?SEIvRmdrdytqS0xZZGRSRzJkQW1CM3BYMUp0Qjk4OVlVNXFBSis2a2MxblFl?=
 =?utf-8?B?T1MzWlFPWVhtRlZ1T3VmNnFjTjJTQ1lzSHBVTzVBRmN2OFpKeUFDa0Z1QnlW?=
 =?utf-8?B?ODBoMkwrejkwS3lYcVVyKzlVTmlGdUVLZHFHRmt1azRsM2xZWHlsV3VjMTNy?=
 =?utf-8?B?a2REUVBaUHRpMWhocnVEZVhLdWZQSzY5ZGVSeDVmN3paMGpUNCsreTRhTVBz?=
 =?utf-8?B?VVdSVHA1TmRkNWFKWU9xREhLYTZvRVZ2a1I3UHEyUWV6RGRuVUl0cUpCcmZQ?=
 =?utf-8?B?TThDdFJiQUp0QjVTc0JpQnI0NmhRVUVvVVFReEd5TE5RZ1NwelM2ZmVVN1BU?=
 =?utf-8?B?d01EZWhlZ1U5Q29CTEgrZ2h2ams2a1NqVXk5RUNZQVBQYjVpSmtVU2ZTdmxL?=
 =?utf-8?B?SGxoZkZVSkFqV2NNSThxWXRmRFY1ZnpsNCs4TGhob3dDYWdoK2txSXBSQU9E?=
 =?utf-8?B?aVROS0Uva2ZtSTc3SlZyQ1BPZThWU3dJVTk3aGlZSndnRVZHdExlM2t2SXFE?=
 =?utf-8?B?UHJYZEVFelVVMU9aRUxvNVRNQWdRLzZKenhJK2w5TlVhVlRqSFM2aUx5N0tY?=
 =?utf-8?B?cGNNRXYwclFBbEVuQk85UVFCcjUyWU1UcWVGYUxKRkNQMnF1bnNwUnB1eHRH?=
 =?utf-8?B?OFI3VGkwYjA0dW1aSnp2T3gvVXN2YVVQaGNhczVDci9uczhaSDMyYnZFMndi?=
 =?utf-8?B?d3h4QnA2U2FnOGxUVWFwV3pnKzhtTFlqakR1VlpwaXBRZGxLRGF6U2RkTjcz?=
 =?utf-8?B?V0Qwdm9menZjRjlkZ0dOa3cyZlI5TUZ2M3hsMy9KTVBPWExhYis4MnRpbnh0?=
 =?utf-8?B?SGwxVm9idy9mSnVzVlVhSkMzcjlXMHcyS0dISWdUSHMyTHNEelY1Wis4RFJs?=
 =?utf-8?B?OEhHeHZVSkNNLzliMFpCZW0zL1B2LzVhT210WUhPa1M4YUxJQS9jMWJBK28x?=
 =?utf-8?B?WHlGMmZ3a0lQM3kxK2xqQyswampJVWxqQzJnWGNCRW9yTjJHUjZuWHhiaXhl?=
 =?utf-8?B?dlRmWWZBWVZzSjNPUlJQeGgwQ1dTbEs0MlFydXVUZUp2ZWJYRndoUGRwM0Ra?=
 =?utf-8?B?T2tjQTVKN0t6ZzhhVnV5bkZObHNTM3ZBSnVMMVBOaDZqbHdwQXBDemQ3eEdT?=
 =?utf-8?B?bjYxejdJdHRZRmJQVVc5akJ6YndmSWN2OXd3UlNwVTlNamlrT0NyT2lua0Uz?=
 =?utf-8?B?bTZ4V0JLTmkrTGhKcWhCWlpMS2lINGZ5cjUvKytNTTZBdzhvSUcxQVRNV1Ax?=
 =?utf-8?B?RVVJOE1UTEN3RE53bm1GZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9926
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	05c9ab2a-570a-415e-fd2f-08dd18fe0a63
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUJoUUxFa1d6TlZvbjNRdE5iR1dqQnlpdTZsam1qN3h3VHpwcFBsUlRZN1g2?=
 =?utf-8?B?bktMVkdmOGdrdEJnVE1kNkUxWlZPTlhKTi9pTVhDQnFuaTVWK3d4NzBkd0xv?=
 =?utf-8?B?cWo5NFZkUFpNZnhtcnB3a2tUZDZJUEQxM2hNNmdQOVZLY2ZNb1kwRzJHNU0w?=
 =?utf-8?B?UlZFZHNuVXVoOFVsbkd3eTQrUkxJQnpNeVVYNlVodDROejRsTEREYmQrb3BW?=
 =?utf-8?B?dmtVUE13VWp0MEVRRlI4RXNjSXMwWmhyQkR2NEFLMlNMTWhnaEFxVWVFOGFQ?=
 =?utf-8?B?aUhTQVljWUdId3QvNG1oYzhqVTByWUNvZzZ0WEgrZVI5QURGRVhWZ0xTdi91?=
 =?utf-8?B?anczeFNEYjd0eWV5QTNBeU5JWk0zbGN6VEpCNkk5NFkwZGZubVdxWlR5TFow?=
 =?utf-8?B?Z1pCemVxQXVLcDRHeE9KblFTK1FMUHNoUjBmMGw3UWhZS0VUWHRiZ0h2R0tC?=
 =?utf-8?B?V1dIdXg2Vmd6U2J3TW91UXQ1VGhJOE5xSzVYMXBLVWZmbFcrcW5ucFpSQlhO?=
 =?utf-8?B?RjVYY2c0U0dVcmhWT0FwVFdNdXBkeEpwM3F0aDA5bjhJR2VrWWNVdWhIWTlK?=
 =?utf-8?B?NDBOQmVTdGZkSnM3dFJFUXRIVUpLSUdVc0dFb3c4eEhGZDIvT2U1ZHB0REQ1?=
 =?utf-8?B?Z1RXRTRPMkZ1YlhMYVNDNVhuQnk2VW40RnpQZWdNdG1OZVMzenBFWFhlZEs0?=
 =?utf-8?B?WTg1T2RTamdQcU5pS1FESmZrbGhhTzBCWFI3eUZ6ZVhhMzVaRndQRU5WNE1B?=
 =?utf-8?B?ZGZmVW1WQ29xMzdKK1ltVnBDcTFRWVA3dVVQTWJqQWliVklXcTlqZjBwY1VU?=
 =?utf-8?B?SUJnbXBsN0V2djVBUTVPUy95cnB1cVBqTTdZVW4xT2VmOVNMemc2Y3IxRFY5?=
 =?utf-8?B?dGhPVG92d2pyVFd4cGUxZnlEL21Lai81QjQ0akxrVU9iQWxDeFgyQmh2a2xo?=
 =?utf-8?B?UUZlZE9ZdHdDb2hhUkNQenY4QnhXSFlBYVNkOVVNUHRmejlGZzl0bStWQUZr?=
 =?utf-8?B?QytPMlAyeGZqME83UkZoNVVVUDJZNDRvVmdiWDBBSUtGUlhSLzhBY2d2THZl?=
 =?utf-8?B?NWlRTHVHZVg3eENXSXYvQ3pBUHZkUVgxR2pzVUtzVElONWFqMnJjRFJIOXp5?=
 =?utf-8?B?NWI1TThqbEpMenlIWmJRdlZhVnA1L2xZcmJOOXYwWTdKdjNqWkNLWEV2dlpK?=
 =?utf-8?B?bTNFallnTzFCUzVOSmd0V0lZRzRwL0VDNzAweVNyUjBiMjk5UG1kUUVmUHpT?=
 =?utf-8?B?dE5NajdoV0F3OGI3ZjA1T3lzejBrQUhheEhqMGFzVUJOOUx0TTZSeGNHTlVL?=
 =?utf-8?B?Q25jamd1bkVabWVGSzhsdG5iVmM0OWVYZ0xCN2ZwOFJqK0ZSMzhLS0VvSElu?=
 =?utf-8?B?MTBvakVEcitZZTU3REppTU1URFBjQWo3QWhMcnZrMnZhT0c1bWNkeUc5RWI2?=
 =?utf-8?B?c0VNVzFsRU9PcmZjclVUb2cya3VkUmk0MFEwV3dWaUlETDk4R2xoQ3VLSTAw?=
 =?utf-8?B?cG1XbWtQNkM0RGtCejFFSXh5bDY3WldOd0pCVkxxSUF2YUVSZC9Lb1haNFE3?=
 =?utf-8?B?ZFVlN29meDV3OGFWUm8xTFFGZTFNMitMYnhJTmE1aXJlVlkwVmNKUkVRZ0Js?=
 =?utf-8?B?UmJxdjhtVUJ3WEtLNjJCMUF5R0NpN1Mvb1dZeU9kblJTeWRTNkdvd0ZhaWZw?=
 =?utf-8?B?STBlMnhscHhvbTJMcEJybXZ2bWhOMkNRQ2lqNVk0L3ZKcHdNS1h0OFF4cEJq?=
 =?utf-8?B?NGM2YmJMTkJmWjJyL3o4bndHdXk4cUxtQ3NUU2RuYlFSTzRlZ3laMzNLcG5Q?=
 =?utf-8?B?NFo4cFZ3cDJwMmxZdHhENWUvYU9KbnlGM1Y4OTdxRFljTCtQMEJVVzRzRFU4?=
 =?utf-8?B?Sy9KSzdxbXZlOFdEU2dndWVyaFdNRDE2OHgvK3VvSThWcnpDZlZkZXc0NnFJ?=
 =?utf-8?B?S3JGOEk5WHRQTjdUSjg2bjgwZ2xNNkRYQkhyV09GSjZ5SkY1N0J0Wmw2bGhU?=
 =?utf-8?B?ajJWclRwaG5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(376014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:36:03.9797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e29d10-5dca-4c8c-a9b8-08dd18fe10de
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10427

On 12/4/24 15:20, Mark Brown wrote:
> Now that fixes for all the known issues with SME have been applied
> remove the BROKEN dependency from it so it's generally available again.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 100570a048c5e8892c0112704f9ca74c4fc55b27..7e3182dd6fa0dadd961c352f88484cff0e520eaa 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2270,7 +2270,6 @@ config ARM64_SME
>  	bool "ARM Scalable Matrix Extension support"
>  	default y
>  	depends on ARM64_SVE
> -	depends on BROKEN
>  	help
>  	  The Scalable Matrix Extension (SME) is an extension to the AArch64
>  	  execution state which utilises a substantial subset of the SVE
> 

FYI, I gave this series a try with the emulator and GDB's SME/SVE testsuite and
it still looks good from userspace's perspective.

Tested-By: Luis Machado <luis.machado@arm.com>

