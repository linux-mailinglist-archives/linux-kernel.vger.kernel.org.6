Return-Path: <linux-kernel+bounces-200809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1678FB52B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337541F25D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED112D203;
	Tue,  4 Jun 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ffTk1S3L";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ffTk1S3L"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029412B145
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511047; cv=fail; b=iidWl5Wy+2u7NJQrc4C8PyXj0CPhGRtoag13wKvgyd4Zm8gcYxhUH4B/YgD92b6D27+rV8+OKU1xHraC9JfRQvHtstH4yRfjtWMH4pmr+IaEOaprPcZ6wq+v3NY8+/Q9xk6A9VACcA4BWDIe77fCg/hvdaWStnYmkhJ5VK3r+3o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511047; c=relaxed/simple;
	bh=3TJKfYJgnJ3Aq4ctesDZ8Ikm7feKsj1XoWkcHrG5JIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcMXOHksFXsZKnsb/HUjnNQxiOIpjEXKvn2dxNqpVvXr0eFLG28qpNQeklDbkk+bZ83sC/h5jPD/wr0n5Sink6hl45Ev2X6tgMR4qU+of/8gmCLloXTHowAVj0DuCGu5rsJMVlWtRU/oo5qg2xUXN3MCmouCG2lNs1rPk0XiUpk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ffTk1S3L; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ffTk1S3L; arc=fail smtp.client-ip=40.107.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=RLm3TepBIYWYf2k3JR3Q9FpCeJrlROPdopqu2cYsf64zxoywk6rGW663fF9ERWwfvnxc2Zhq0RgNSUrfLAsZreetBhddG0L1yrFXKw8AFskzd795f1Ko7OJmrLDsNC0PpcdqsP4dXAWec8zYTUhIerftOHRJWDrI/wbZeEHr8V5qFJFXP4jFBe/0IzQ6R6T+1YvSuyui1u51VviuS552eERx0/QjqW2Zp2ixqGg96lfx4TWiyVXJsMvzBQK+YzUg6QIAvYyJM6v8ephDM15/ar9jKbddt1vZzyTQVufbF4f1SUInqOk2ZMYkY1oKL5TdGLCzYUwm9quOs1hPAelK1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9IFuoepYxY8qPs0Y/7v3UBKKSplNv6OLe+dg9GDADk=;
 b=RnmvpRgxhnCrKQ8j4YZl730nhonl3gYI8TmyVbk/bX4IZ3MX1y2xD7EqbVsEQyL0rbTxR6LWI1dQi3S98q7gCA5JD6NSb7FrsUlVwEW7P62V2aonZKBhtD77v6jfBrx1c+fN1U4jbxFSMMgScaozBv6Oe0TyH9X5C67Z5PsIy5hgQ8B0RtNecQ7PRLKOgDcjrP//W2lFWjUFnxO2XKCpimfsuH9AJoSaoHzVwjuZxNDnHNt3fTiL04jWzmwVN+a2BOIXOjrLr2pkqs7jWklpeG54gxA2v4a0XCLyBuPp9S7IuCq+cYpKJkQFHQYar+/M1nHAsyPssy7UholQRAZIFA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9IFuoepYxY8qPs0Y/7v3UBKKSplNv6OLe+dg9GDADk=;
 b=ffTk1S3LCg6xazkxMPfMwBxUHehreCzNlVkRi2HCF/dyX4w8W7WjVIxh8q1C+GRCw+1Qx1Ls5zgf6oUhMcYIu5CJloMiHeTmSl12iagaTEVfMHUVPgX+J27rlCtIWYpuuQucgJR4CakFl3UAJ6a5zsJOvA32aFLPCRpz/9DcDLA=
Received: from AM7PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:20b:110::36)
 by AS4PR08MB8144.eurprd08.prod.outlook.com (2603:10a6:20b:58f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 14:24:01 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:110:cafe::c4) by AM7PR04CA0026.outlook.office365.com
 (2603:10a6:20b:110::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 14:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Tue, 4 Jun 2024 14:24:01 +0000
Received: ("Tessian outbound 3fb86adce702:v327"); Tue, 04 Jun 2024 14:24:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0b58f2469197a9ea
X-CR-MTA-TID: 64aa7808
Received: from 4b53e8da1b06.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7094DB93-85EC-4B39-BBBD-C9B2D038400C.1;
	Tue, 04 Jun 2024 14:23:49 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4b53e8da1b06.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 04 Jun 2024 14:23:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTKa+YPwCRrBicv2WJKR9WY1xyerN96IlSocB8l3yR0MX/KeUDV3h5w2k5lg/q0AE8Wb7NrVcII581GXFxA3QS578OZqrOptREpuNaLkKjTgXj3D+mNAcqjV9oMQURJtYhlPLqdhkVttDdgVb8PouYNQIJvR5F+cW7bjTAk+PgvALx24sIIJDT/iNGAusWS0KZuUS4X4yR9PrXgpcZsEuzaturfshPj8vQjm3p8mwPuXRZEFwkvsmQGMHqKkzFyHoZ6B5EhK7P0jwL/LUskATMdxEvN6bcTwVnFjT3tlaf6BX/IkRXdnRa7Q9ZgnKWo6AklJ5kLZ0lS91oKTQOnv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9IFuoepYxY8qPs0Y/7v3UBKKSplNv6OLe+dg9GDADk=;
 b=lEt8DYazwQdNEgUrNJRwJdioXFg3xgD0QTb+mnchnQadbYKO1pWr8420xWiU1zYaLuvIKqQ4VKXCv5qDfNCCcXlDVxb2TBklObiSi/eJFSkhKSFQsk8AdtaMIY2ORDKLp4gR4m9gpLFv/YdtbF5Gv0x17+yxnGPCd3Wy4r75qAo4S/hIbYXm/2Drvayl9BTkspqPGd+8V28/nptthDh+bj6iK7/IlUvkcLP6DFncW48Nj2FKITXwV8muA6TRFUSizJubt1z37xtLfbgX8JWZGUa6J1FsjT65v9DE6ISSFcYC2e5M16VbtXdH+AqTRRVb5sRKT8zK1iQ7PwzOfrWpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9IFuoepYxY8qPs0Y/7v3UBKKSplNv6OLe+dg9GDADk=;
 b=ffTk1S3LCg6xazkxMPfMwBxUHehreCzNlVkRi2HCF/dyX4w8W7WjVIxh8q1C+GRCw+1Qx1Ls5zgf6oUhMcYIu5CJloMiHeTmSl12iagaTEVfMHUVPgX+J27rlCtIWYpuuQucgJR4CakFl3UAJ6a5zsJOvA32aFLPCRpz/9DcDLA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by PA4PR08MB6303.eurprd08.prod.outlook.com (2603:10a6:102:e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:23:46 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:23:46 +0000
Message-ID: <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>
Date: Tue, 4 Jun 2024 15:23:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
 <20240604101107.GO26599@noisy.programming.kicks-ass.net>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240604101107.GO26599@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|PA4PR08MB6303:EE_|AMS1EPF00000046:EE_|AS4PR08MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b972a5-10c9-4b9b-54c6-08dc84a1fad0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dHJYRWNtQ1I5eWpaaDFhUE5xLy9oK0dsWW1FY0kvZEhUckxNRUdaQmhtTSs2?=
 =?utf-8?B?TnV1RDViNU80aU0vVlBRaEoybGpxZEVJTUZSbklqRktRSkJqVnROME9Gemlx?=
 =?utf-8?B?dThKS214RG1KcHVzMkZrYllBMitESHloR1Q2YnM4TjdYckFqWXRuSllRTUdu?=
 =?utf-8?B?emJvS1o5eGg0OG5adGtueGxIS3VER0pIeTZkT2pLMS9sNVMxemx2UHFyTHRD?=
 =?utf-8?B?NGFKSGRUSWRMM2pDYmY1cnBERktvNXNOS2VSN2ZOWnlCMjgwR0ZyaGhRT0ww?=
 =?utf-8?B?L0JrYjJscndRZFo1ZWVuMHErcDZkbFlSYWZyUGt4SkxjK29TbmJ2Y0tuYUdS?=
 =?utf-8?B?NlZkVmxnNzJYc0krU0RqNFNkN1Zxd2ZZR3NqcDRUOTR1MHp1Y25sVkM2TDZU?=
 =?utf-8?B?aW9EQUpXbENXZTVZWjA4Z09KYUxKWHFITHZKRTh4ZktRcTJkT25pVzBCQkVu?=
 =?utf-8?B?aVhaZkVrNmhEak9QVWZ1cjhLaVhTWURkMDlrZnlManhtQ2tORlYzM0pvZVd5?=
 =?utf-8?B?MVE5dmgzbDEwZ3lpRUNpWHNQN1BseXdoUkRLRnltVEVQWVQ1UU04UWF3MzEv?=
 =?utf-8?B?MEVNSEVkc25zQTJpWXFoUHpYakFRTUNmdmJLYmhrT05yb2sycDhxaXBBV0FC?=
 =?utf-8?B?ZE5BNjBxWjY3N0J6ZlBkeHBsTFMraWsvT1NhOUpMMFMxL1lDVnZ3YlFZN0RC?=
 =?utf-8?B?ZkdPYzRzUFIwcjI2eSt2em8wMVpjcnVTWTQrQWtqb3dJSkJMak1aUmZhWUpQ?=
 =?utf-8?B?enFkUkFnZjVtekE0MUNoK0hEMVVBNG1RM1RQRjJoRnZFSUNDdVNpNVlua0dT?=
 =?utf-8?B?bjhDOWd5MHlOOUZZazE4dURMV2k1ZC9yZVNFNTJObWI1RlpnS2tsci8za2dT?=
 =?utf-8?B?aWlKQ2g5aE9ZcEgrelpJS2NCZ2lxNHoxemc0WWM0OU41eithT3NVZ3o3M3dy?=
 =?utf-8?B?WHUrbmx6c0RVUm9XMnhyMFlUSzQ4SjVKYUMvd3NTR09pUUlKVWkwdExPY0I3?=
 =?utf-8?B?RUNxQzJPNHpXS0FtcFZMNjlXVGxsakhORFBScklCOUU5ZmIwa2JpV2RITUFC?=
 =?utf-8?B?NHJnOVFLNC9BSE9mdmlTN2hzcHFZVjVMTktFLzJRWlVJWjhhTVIwd29UeFJR?=
 =?utf-8?B?d0JTNlM2cGRVWGxRT25FbGtPQlEvRDRWZEtvWCtORVVVSGptaUxxSjhINkVi?=
 =?utf-8?B?NUIyZUUxTXhsL0pmLytwUHpDZUpXL0JHZTUxeVlYTTdVNi9HdXovOFVqYVVU?=
 =?utf-8?B?d0x2Q3VzTWlHWUY0Umhia0YzMXgvWnMwMU9DTnVaR3FCNk9SR2MzVlBoRENK?=
 =?utf-8?B?NThRMzBrSXYrc0thMmNTZ2thRGJqVXBmSVc5WHZieG5aWmcvelo2RkhBN0pl?=
 =?utf-8?B?N1c0ekhaMUwyKzMrMGdrUzdRZkRPVC9VQjRybENjY0phcWMrU0hYRk1JdDJR?=
 =?utf-8?B?cW5ZekZoQWhpQ0RDOXhzMUtIbFhPTytuR0FRckpwL1ZWekRkTkQ2SFZhNyt1?=
 =?utf-8?B?S3IyY1cvM3M3V3kyM3VHT1NjVjEvbnV6RDBVdXYreFF3RVFVaEYrRkpVdUhy?=
 =?utf-8?B?aGdzTWgrMHVFWWtYQVlxaTFxTmtjdkQ4bUpGdlpxdjg5S25ybVJZMGNBV1NG?=
 =?utf-8?B?K09VTE1HVmlSV0NFNFdaMDJFMWhnVFVXWEJqV3Y1eE9OS3V0Q0diY2tOOXRm?=
 =?utf-8?B?L1ZFVGI5US9jWDA5UmdEN09lMm9ldytPN1RXdm9vYkRUeVRBR0d0VEdBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6303
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6eb604d9-10a6-4b12-bf84-08dc84a1f18d
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|35042699013|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K25WU1JUcGdTVEdjRTNxb290ZUNKQlozQnc0cHE5RjFMNFE5TnphZ0wyNzht?=
 =?utf-8?B?b0NTRjZ0NmIwOXY3Q2g1T1h2dEVPQWxCakVJSzJ2eUNaSTY5Um5jNlZWRjZZ?=
 =?utf-8?B?Q04rajgzd2hGMHY3c2RoNHBVeFlKNHF3Zm5KN2VRWEJwNnhaSCtRUzl2SE5i?=
 =?utf-8?B?cTE5bHFCZi9GNWl1elloc1ozS2Zra3FoT1ptVEhUVDZ1MTFJK1N1RjZEaFEz?=
 =?utf-8?B?eG80U0R0enhlZlNhemdTZTlVTkIwQk5xcmV4NDhwZWdZQ05vZGRhYnVUaVBp?=
 =?utf-8?B?d1hoZlV4VFBVeWpIYkJtc0ZLZEFVZTk2dnpFaUdYb3ZJUnVsUWlFWjVrMW5E?=
 =?utf-8?B?NjF0R1hlNFBzZ0ZxaWdaYmJOU2RqemtMVjFxYXBnY0RZKzBKa3YvdWFIa1l6?=
 =?utf-8?B?VGdHTjBHYUVSMEQ4RXhmc1lGOTlFODlwTm84SHZwN0xjZW9mdmlpK1U0Q3Yz?=
 =?utf-8?B?bmFpck1rckRhaXpKby9tSVZvY3VSeWtpSzNLdGJaN1Y3bzg5cCtodU1XSit0?=
 =?utf-8?B?RDRaNEIzVjkxRDA0RzE2ZDE3clRTcnZhL2FLUDJ3LzlGR1F2bXJKRE84d0dE?=
 =?utf-8?B?empQb0RyY3pRZXk4b0MyUksxM3luV3ovK25oVGlTTmZxWTRRcGZDeGN2ZUFV?=
 =?utf-8?B?Mi91SWhjSUtCbEdtNm1aWVNZSHNDb1JuTnVZcEZzNEFrYXloYUU5U1B1anBH?=
 =?utf-8?B?UDZuTGQxSnQ4MjRtN3FnbHhVYUNkcHgrRlkvdGVIMkI0ZWh5UlNUY1FSQ1VY?=
 =?utf-8?B?blNZanphd2hTM21vcEYzak92eFN6OWFLUUR5b3dlK3E4S2pKd3h1elRmVXZD?=
 =?utf-8?B?akRMRmFIcHNxM2xJdTlIQ3F4eVRXK29kaTZiYmxvRmp4c3lhZ3VkZ2ozd2RK?=
 =?utf-8?B?eWM0ZG5aQ1daZnc5MTVadUhubGNyQU9IUWUwRlJ5c2FJM0haeEdZNFExMHFh?=
 =?utf-8?B?b0M5WDlHWEFaNVhxZzJZaHFrbVMybnBad3VIdmVVZERnWmszU250djQvdEJz?=
 =?utf-8?B?dFpjOHBtdU1DUlNObVM4SVVxZzRVa2gzNG9tVmlaakdNZzRzOGdtWWRWdnZr?=
 =?utf-8?B?ZWtEditWSzJmL0phbnVuN2cyeVZPSXJ0aGcwSEhxYVI4WmV0NHJDVjY1enBD?=
 =?utf-8?B?b2lRd1ozRmtDSklzdmhzU2swbUNERDltS2pKMWhHM1E4T0EySCtuR25ucVp0?=
 =?utf-8?B?R21QRFRRMEhSdlhJVWZHa3o4T2NVbGQ3N3dZdHQyeFlWVjZyZE9KR2p3UWZW?=
 =?utf-8?B?QlpxRVFUL051OVM2L1kzemUyendITkQyNjVQc29qRVFjWC81N3pwdmxodGVx?=
 =?utf-8?B?MXpXNU9CSHJjUVRoRlEwQXpBYmVuaERxVjhDZTc1M2d4eXUyVGhwekRxODFB?=
 =?utf-8?B?YTRNbTEydzJRQThobHNaVGR3dy93ME1sVUY1b1docFQxbEdCTVZCcnhrMVVJ?=
 =?utf-8?B?d0trdVZKQXF3UHJDU0FzdWZXTGxwcmF0VFVtZWVjcmVmeVRDdXNKOHplbXFq?=
 =?utf-8?B?OVhOd1J3RmJKbm1tVzVEMWNHZnVhajYvR2lwS1FselRMSlRhYUpoaFNpcDda?=
 =?utf-8?B?UUlXb2hra25wSHhlTlcrdk4yK1BrQTByWjhmR0Y1bkxUSE84OG53WHFSLzk2?=
 =?utf-8?B?aUNsQ2l3R1pyemlGclFkeWM3UVZnZ0xXbTJiNU55WjlWcWFrT2JhYlFXQ3NH?=
 =?utf-8?B?cldCQlMveW00SlFOd0hIQjl5TXpDS3ZrWVl4aFNVVlVIZ0R1eFVUck9LUEJ6?=
 =?utf-8?B?WTdWdmFaRGJYaDlNUFNlQUkxVFFaSHJtMUVqdnZ0WklXMkhkWHFad1A2cGZx?=
 =?utf-8?B?WndwMUEvS3pLRnV0a1oxVDlON0ZBYUcvaVEvV0luNWc2a1kzMTRFejVhR2lj?=
 =?utf-8?B?ZmUrVlBrV0xVZnVEb2JIUnNKRVdFV1FmaUZZUTlJVlNOUFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(35042699013)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:24:01.1701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b972a5-10c9-4b9b-54c6-08dc84a1fad0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8144

On 6/4/24 11:11, Peter Zijlstra wrote:
> On Mon, Jun 03, 2024 at 08:30:43PM +0100, Luis Machado wrote:
> 
>> Exchanging some information with Hongyan today, he was a bit suspicious of the uclamp
>> behavior with the eevdf complete series applied.
>>
>> Checking the uclamp code, I see we have some refcounting tied to enqueuing/dequeuing
>> of tasks, and the uclamp values are organized in buckets.
>>
>> Just for fun I added a few trace_printk's in uclamp_eff_value, uclamp_rq_inc_id and
>> uclamp_rq_dec_id.
>>
>> Booting up the system with delayed_dequeue disabled and running the benchmark, I 
>> see the uclamp bucket management pretty stable. Tasks get added to the uclamp
>> buckets but then get removed. At the end of the benchmark, the uclamp buckets
>> are (almost always) clean of tasks.
>>
>> Enabling delayed dequeue, I can see the uclamp buckets slowly filling up with
>> tasks. At the end of the benchmark, I see uclamp buckets with 30, 40 or 50
>> tasks still. If I do another run, I can see 80, 100 tasks still.
>>
>> I suspect refcounting might be going wrong somewhere due to delayed dequeue
>> tasks, but that's more of a guess right now. Hopefully that is useful
>> information. I'll resume investigation tomorrow.
> 
> Thank you both!!
> 
> Does the below help?
> 
> Note how dequeue_task() does uclamp_rq_dec() unconditionally, which is
> then not balanced in the case below.
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3664,6 +3664,7 @@ static int ttwu_runnable(struct task_str
>  			/* mustn't run a delayed task */
>  			SCHED_WARN_ON(task_on_cpu(rq, p));
>  			enqueue_task(rq, p, ENQUEUE_DELAYED);
> +			uclamp_rq_inc(rq, p);
>  		}
>  		if (!task_on_cpu(rq, p)) {
>  			/*

As Hongyan pointed out in a separate message, the above makes things
worse, as we end up with even more leftover tasks in the uclamp
buckets.

I'm trying a fix in kernel/sched/core.c:enqueue_task that only
calls uclamp_rq_inc if the task is not sched_delayed, so:

-       uclamp_rq_inc(rq, p);
+       if (!p->se.sched_delayed)
+         uclamp_rq_inc(rq, p);

I'm not entirely sure it is correct, but it seems to fix things,
but I'm still running some tests.

With the current code, given uclamp_rq_inc and uclamp_rq_dec get
called in enqueue_task and dequeue_task, the additional enqueue_task
call from ttwu_runnable for a delayed_dequeue task may do an additional
unconditional call to uclamp_rq_inc, no?

