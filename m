Return-Path: <linux-kernel+bounces-572449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96176A6CA69
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E171B613C0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C091F8EEE;
	Sat, 22 Mar 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mP5W1oGw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mP5W1oGw"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4517405A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742651679; cv=fail; b=MCqDUJEXaTOA4+wTd1OmyX7HXWDWCpO2dg8kVYNmBOuQQsqe1/tZnf5f2ckc8TURzZQ+WUZ6ruNXgutLqeIg+PF3Vm6jSugcalCFXXn0RT/WLOCachaQPZFr9cNpzZPVmAjpL+JqkrMLAQuyN1+a+mRbgWEdKOOERWpCzsxU+fQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742651679; c=relaxed/simple;
	bh=cLqANp4ef6QYH2nVJ/MdJHoobmsJVSv2KjmPtdMWdds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OH5qRP8uN9A+S/IlVhuWA9kiHbUtC+B0E0Xs8wunqJkyO+vEWoTNEMCiUosrALITn863vg13lyKLjKgwtfFh8JIyX28O2vxYE4ABQwtWvt9nBbgIvJl4mcagH/3enX7DWfrNrlv9BGUzjqnU8yS2IxGh9CVclGYDZOHsht9mgQE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mP5W1oGw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mP5W1oGw; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jitbPmy1TJE3hxz0UMkqdSFi3rkFqbweAsRQG2rynDMmWtop+tBUSwtbiD8dS+3XfVEUlJ9m5emR5KLKrc9Z8nP4GETKCPulFMgJKbXFhLlymyxLWZvyV3pVbyF3OaD6WdWdlEpAyKmfnGvfs8Tuk+orpxqqcysIoNNWy4LxXv/OXHjWE5W/woDpZ833OVP0hUa+2EV/1WR1F5KwjJds24v2YBCiEGelYOkiTn3godWPnkN+F/aI6tX2b3vfcXDD9iVlguNy9hrzeYD7TRb1gfw70TFa0ZOt/sJEAyFddIfF5GBsX8aLFETJa+XT135dC9QDqW0FgmxExfpt7IHnGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLqANp4ef6QYH2nVJ/MdJHoobmsJVSv2KjmPtdMWdds=;
 b=eMlDASUlqrIm2WdbNjjBUq8FCm2aXHCNxhzTUIYzhBtS3fCxDWKwF/cMkEqCAyXORWoSIgaawTdrtumYZktFOifN2zjl/LcuX58oTGlpgInkbOqJ9Q14rsV5CQNyOaKQlklgcNp4nW2ysKnz280VZhCMwi8etiIg0ygkr7w/f5/v8fTWTPvERxanRyHdC+A5ii/W8Wdp+1TwT5M4CU0nk62vJImPcAI50A77Ls93l4WSNO04VJ5y8pOysA+2rQG4+uzh5o8X2bPqlvPhAdMi/9v2JnAp7BRu8KQQxQ3vBxLzQd6OyxRQoR3Rb1Q8H+g2NNRX0G2vcQTKb9u13hHzBQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLqANp4ef6QYH2nVJ/MdJHoobmsJVSv2KjmPtdMWdds=;
 b=mP5W1oGwZN2j5XDG6QXGaApH1e2bykyPGX9XbMrFAk6XNB8NyZi4sh5PfjKpV+X2KiuUpGqSn02o0pS5BbrzQcx+F1OGMGkIbxtgdWk5jPzsMR0YtUzlHx9Era6Q1P/+GLRQ/SpvtWTndmCiAKnwGtfS9teg8mo6yu4mhdHa+Rg=
Received: from AM0PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:208:1::14)
 by DB8PR08MB5484.eurprd08.prod.outlook.com (2603:10a6:10:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.38; Sat, 22 Mar
 2025 13:54:30 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:208:1:cafe::77) by AM0PR04CA0037.outlook.office365.com
 (2603:10a6:208:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Sat,
 22 Mar 2025 13:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Sat, 22 Mar 2025 13:54:29 +0000
Received: ("Tessian outbound 79edf4140b33:v597"); Sat, 22 Mar 2025 13:54:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f197257e67d43246
X-TessianGatewayMetadata: FQimT0uNdnrxc3SEn67aUEzPihdgyH0tCWnmK0jbQojZDKYKBf61BC3GrpraIdRM8JI98LQAiGvzN6BX9TXl4sz1s8ikwvcS/6zU+kqjxNePTEZ1gYFXPV2RdcLKMP0qd0IkXq1fVsbplOT9RBWXJ0Mw24ubCzwWAudpmRtjn3MoEd7XJUPrOoiaLP/benosr/CR4LAc3OO7BdZMXHDpCg==
X-CR-MTA-TID: 64aa7808
Received: from L2e4e36ce01ff.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 259975D4-04E2-460A-A360-D6761CA52D46.1;
	Sat, 22 Mar 2025 13:54:21 +0000
Received: from AS8PR04CU009.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2e4e36ce01ff.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Sat, 22 Mar 2025 13:54:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1m+kzWl3H6I8pRtsqeyOKWC4fmQJhxr9QsWqD5/uUgrVXewo3V4htoZohBabuOkpZNvoCFyhswaKpD4d+x/kO7azDO6x3Geb5OyY7PO1LLzbnSIcNZYNO11dafnWC6qWWzgHSYz/iARDKa3zXxJv97znq8be0FvHQRMtxI3feG2QKtEkiy3hJpwXus0QjdtGdDfCbUAwUNxoYJleODYqrZIX7YjjCG7FPTqzk3iKERdbLVFHEdsrc5O814/2DEFOYLV7RZpX08RlGYtO2yI3A8sUirN0embL6yDi4qzWOqbZNVAWplAZQLI6Oo6Okx4oNUqgl9HLPVweIlNpcy9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLqANp4ef6QYH2nVJ/MdJHoobmsJVSv2KjmPtdMWdds=;
 b=rVi1E3A727wcsBP1paL6kUid6yW7bbE7wn+qZ+KKQQLZYzyj8H2UyX4k/L6+UQcmzRwupVY//Yiq70wpOGlgSx7O42P8odML5pnMq9/bgRbi32lUS4C1ng/TfOptwbIKDPvXSUd4FwC0OZgLOb4i7YwW1zqOwUfI1/Kt2l2PzIAwtauO7/aOFBXUvfOHr8e/BE4XMOYKAU777jIdSH8NoDLsV+ENDYbQD5Hy+gEJKV7SQQ6gv7UwqEmNNfnxp17oXIU4Ue/kFJ2MeXuxYW2seEi/z6aKk5oBdVKQROV7HKzBplo+kHRiEnCfmu+vLnDLD7ls7kuDFtHZGkBylQbSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLqANp4ef6QYH2nVJ/MdJHoobmsJVSv2KjmPtdMWdds=;
 b=mP5W1oGwZN2j5XDG6QXGaApH1e2bykyPGX9XbMrFAk6XNB8NyZi4sh5PfjKpV+X2KiuUpGqSn02o0pS5BbrzQcx+F1OGMGkIbxtgdWk5jPzsMR0YtUzlHx9Era6Q1P/+GLRQ/SpvtWTndmCiAKnwGtfS9teg8mo6yu4mhdHa+Rg=
Received: from GV2PR08MB9206.eurprd08.prod.outlook.com (2603:10a6:150:d5::6)
 by PAWPR08MB9121.eurprd08.prod.outlook.com (2603:10a6:102:331::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.40; Sat, 22 Mar
 2025 13:54:19 +0000
Received: from GV2PR08MB9206.eurprd08.prod.outlook.com
 ([fe80::d431:f1c3:a2b9:5162]) by GV2PR08MB9206.eurprd08.prod.outlook.com
 ([fe80::d431:f1c3:a2b9:5162%5]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 13:54:18 +0000
From: Justin He <Justin.He@arm.com>
To: Marc Zyngier <maz@kernel.org>
CC: Oliver Upton <oliver.upton@linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, Colton Lewis
	<coltonlewis@google.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, Zenghui Yu
	<yuzenghui@huawei.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will
 Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: arm64: pmu: Avoid initializing KVM PMU when KVM is
 not initialised
Thread-Topic: [PATCH] KVM: arm64: pmu: Avoid initializing KVM PMU when KVM is
 not initialised
Thread-Index: AQHbmt23+1t6e59BE0a5Mo9Hw6bOt7N+7sYAgAA5YWA=
Date: Sat, 22 Mar 2025 13:54:17 +0000
Message-ID:
 <GV2PR08MB920679CA30617D465B69D79DF7DA2@GV2PR08MB9206.eurprd08.prod.outlook.com>
References: <20250322035115.118048-1-justin.he@arm.com>
 <867c4hml8v.wl-maz@kernel.org>
In-Reply-To: <867c4hml8v.wl-maz@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV2PR08MB9206:EE_|PAWPR08MB9121:EE_|AM4PEPF00027A61:EE_|DB8PR08MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: eded9361-d964-4ff2-338b-08dd69491140
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YVFCbFRIWW5LVmtQVFlyRDFrT242ZTBVd0lZUlBVTWFpb3oremlQUmh2bzFI?=
 =?utf-8?B?S2h4bldTVVNtTTVYYS9yRklCZllPcXlnc20rd3RJbTdxQkg3djlwMVljUmdO?=
 =?utf-8?B?WTBYMkQwTmxqRXZ5ekFMQkxNQlJlR0hEa0FqVVVJUEhucldXa1JySDRlaU9M?=
 =?utf-8?B?ZDZKVDVCZWhvekQ4TU4rNlpiYW5lcytuZXJYVEs5SlFuNlkzcnZYY2wwdnI1?=
 =?utf-8?B?TTB3c1lObzlRaXJDSEVvaU9nZCtiWUpwZlBMbUpuQ1dRY1JENEthdWVRbzdp?=
 =?utf-8?B?a05jT3NpRHZsblFrZC9rM0NKeUpHTlBWUWNLY3oyVWh2Z0RVeHU0bW4zZkE0?=
 =?utf-8?B?TjBoZThpOEo5T1lFSVhQdDNrQWRKRzA0ak1kM01SeDRqUDRGamppdXc2eXgz?=
 =?utf-8?B?YTFPV3ZidUZJVGFXaXFyR2FiM1Q0ck11WVkwUmpLaFUydnRuVmxrUUtGc1VW?=
 =?utf-8?B?OTl3RzZ4QVNoNVk5QnUyRVVoNHYyOVRQR1p6d0FuSzM5WXZza0xSUnRxRXRp?=
 =?utf-8?B?S1F0UE5HSHR4ZWpiMlZ4S2NWNXpXV3FLekp4dGtlQU1YcCtCb3M5YTBHcEN1?=
 =?utf-8?B?SVloYlZkWUZlYlh1MnE2Q2VMNy9Ub0VRbWlaRWwvOVZLc2FqYmtYYys3OUIy?=
 =?utf-8?B?c0dwajdFTFNjckZIdDFtelN4T2xtL1lzdEVHcGVrcjgrb3B4OXpXb3Vuak1y?=
 =?utf-8?B?WWZYTE5KZ1FoYUFuRTc2S3hWWnBuSC94K25KWHF6em9uOEloZDhqUmd0WFg4?=
 =?utf-8?B?UitLeFhSbGh4ejdKalBmYVpqOVNHWEgxNDY5Uis2WlFldmpHRW5hbFEyUmp0?=
 =?utf-8?B?ZXdwVFlXdWZiRmRWdnRiTzFnTDJxcUFWV2ExaUYrSHJuZmJtVDN2dG00bWxi?=
 =?utf-8?B?cjBPak9ZL3pONkVSalY4OTVmd1ZnVlp1c00rSVZnYk52MDB0MEJLVmJNTk12?=
 =?utf-8?B?MDMreU5yT2JwdGJTWDhuWW9FNndUUExSQzhkZ3BCYUtRaDhjc0ZadlJITmdQ?=
 =?utf-8?B?T1JxQnlHcC8ybDczU1hJWEhXUG0vWkJzTmxqS1lzQjhkMmNuWVpDR3BjTEs1?=
 =?utf-8?B?d3dqL1piMjNSZlpHVkdUQldZUVNIc21VVkgvNnZOaFpSM3RaeTg0VWdNUllr?=
 =?utf-8?B?STQrRVpFb2FldDdGREZaaWZXTUdETzBwak9BNWQ1V3pkcTBvK2pNdmFRdExD?=
 =?utf-8?B?d3RrZWdzeGJZYXYwOGhnbGx1Ym84OWRYeHNVclNhMVdIZXhSbzZ0dUpOYlVB?=
 =?utf-8?B?bzB0VFFsTmc3RHZXZXlNQlZmM0dXSnlJS2pUQ2srbFBTUVZiZndNSjhlRTJq?=
 =?utf-8?B?S2I0VDNNWHhWc2EycmwveEFteFE3RjU3MmpaazFHSExYenhLMGVqdTl1TmpI?=
 =?utf-8?B?Ym5LZi84R3pIUzkxSnZzUU80WTBxckdNSXZ0RmRZL01tOUwrOVNHajJMSE1M?=
 =?utf-8?B?THVKOVh3TnJ1cjJmUFJKbXJqT1ZuUVhSaGM4RUhCYStYZDhkVlVJbjJRdmdr?=
 =?utf-8?B?SVpUd2FMcmVYSzB2WWhtVy9oY3hPd2VUTnhqOSswSk5HVGxVWFdrRXZaWG11?=
 =?utf-8?B?SEFoMzMyYlB4Zm5zSDgxaG4rRDNUdVE4MkJCWXRsdE5oamhCaEpPNWNacndO?=
 =?utf-8?B?amVOYzJZbVltVHVibnIvdGdZcktqamlOazRSbmFVWE5sM0ZXaTY1MFNxczNV?=
 =?utf-8?B?bEt0ZU1FU3VVUGFvYm9QcVlmYzJWNjY0YWhwcThOQUlYQ0NuSmJVWVNacFo1?=
 =?utf-8?B?b29NL1M2QUVOMzJ4ZXVUMmFFUFNXVTQxUURXU3VjUk5lNkZubnBjdk9tQ1V0?=
 =?utf-8?B?Qm5rTStMNDA3SThWTWNKVDlISWJ0c3ViamJDcjA2cVlLRXVxc2hpWjhueWl1?=
 =?utf-8?B?aUpvek15L3N2cnN2U3BiOEtUc294dVErVkFSNlhDS2g4ajhTa2E3MjNzYi9y?=
 =?utf-8?Q?mWNr57KhrO/znRDx0f4saCm79wgeOgFX?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB9206.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9121
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:d5::6];domain=GV2PR08MB9206.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	89e5ac36-7c5e-4eb3-7f16-08dd694909f5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|14060799003|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmY1dVFaZmdybGhyTm55Ti9iYTJJU2MxanFKbUlGcFVITGoyaFRLYllwdHJ3?=
 =?utf-8?B?WmtyalJqVlVrNHZWWS90VG5RRUswY2tPNHBZR2JLNWxZOER6RnpYaXJxM2Ey?=
 =?utf-8?B?elpsaVNoTUpaRjc4eUZleFUxR1Y2RmJqTG5RbUNjbldIWTJCRlVraXNkaGxU?=
 =?utf-8?B?dnBiOGtybEUyVVBZQTJISFZ2OWFBNWQyU283SG9kZUtZNWd5OXJ1T1crTDRh?=
 =?utf-8?B?THcyWjI4RWgvcVh2bU5IU1MyUnQyMnhLMm1jRnVES1l2OHNJYVZuTWhpNzAv?=
 =?utf-8?B?U0tFNEhaSm9QSEN0YXZ5clYzT0tPczdzVW1zNVhwUGwrZFdhTUpoR1l5dVJY?=
 =?utf-8?B?TXdKclBySE55NkNFMFkyNEU1SEs0RW90K2hnQ0ZITDVrZjAwV3ZtRXB1Uklo?=
 =?utf-8?B?N1pFczRqaWVEUXBFcVpSZHNubHdYZWhqaE8zSlFCUEZsY3d3dFVBWlQ3MzVU?=
 =?utf-8?B?SkVjNVhDN0s3Y2w0QU9sd3BzazhHVXczc252VUlCWEFsS2Y2MFZ0b3QySllm?=
 =?utf-8?B?ekdWUGxPQUUwUFR1QThmSzNXWFdMakpZcTNRdXhZZENrKzN4aEl0bWk4YUc4?=
 =?utf-8?B?dzZqbnB1Nnpzb2N5emtobVJNa0ZFRUVLdzlPNW9qL1BLVFdRZUZKTzVCM1pN?=
 =?utf-8?B?Q3QvaXdDeFFJZ3loQ0lPOWhvTVR0Ym43UnhqSUo0bWRXVTI3V2EvK2xseDht?=
 =?utf-8?B?blJXTTFyczEzdHdJSXdoYk9PWHUwZ3lIU05Ua3RhK1pidVoxeWV3RjJsNDBx?=
 =?utf-8?B?bmcvcFg2M21adS9zUGhiUSthU2hxNytIQ213RkhwaEFhTFhzeklvWnFYelJE?=
 =?utf-8?B?dHhyZjNqcTQxYW9RVldDSmVFMERrTGg3eHRoUVdwQUVwOU9RS09nN3loTFZ0?=
 =?utf-8?B?eG05MTkreFF2T0ZxQmRTVHQydk5RdzZRMXNwVU9EN3hDYmxTeTY5KzA0Szhx?=
 =?utf-8?B?WXl1cVRQQTYvY29kRm1QMmsxQ2xBRVE2Y1BLS1NmSTZhVmhtY0FFL3l2SWo4?=
 =?utf-8?B?Ymp3M2NuckIvL2VUL2NaUjFZRm9LQ29QVGdGcjY1MVRPY2VjMzhLR0JSZFVm?=
 =?utf-8?B?MlBva0JDUzZkb2tzR3dsSWtJcW9LZDhjOUh1YmtjUjRMWGQrVWFKWEdoLzFJ?=
 =?utf-8?B?c3FKTWF6dll6YXlIUlJ0WUdkcWYxQ2ZxbUdpSWhyTjUvMS9GTDk0RGZYeVNH?=
 =?utf-8?B?bFBRaUtZczBFcWFKYnN5TUdGWUZvcGtIZ2FId2h5N3JDQ0Vjd0Q4MzdsYmtu?=
 =?utf-8?B?V2pMRXdZa3gzbXF6cjh5eUhtcnRrM0hzajR5ZHNUZFVsbE0zdGxxc044TVpN?=
 =?utf-8?B?dE1INnV3UmJvWWxLdVZadGpQRW9JV05OMis3QkdtSXVQd1JLK3I3RTF2dHRz?=
 =?utf-8?B?MTRCTzJ6cU9xQUpXNFlpSTVMNUVtWGFhY1E1bDc3TU9ka1I1TjlNZmNZRzRO?=
 =?utf-8?B?MGpPc2ZyMGZTdndqUGVOWWJhb2NRQk1LS0JtcmRMUDNHVlptZ3VBalhRaStp?=
 =?utf-8?B?THlqRHFIdjdmR3ZSeHg0UHh0akdLQVNGUURlTktoYXJ1ZERqQ3VTQmJ0UE1k?=
 =?utf-8?B?aVlMRW1lazZ3dzlQVnJrdVFwdng2T0pRMlVTTW40Z1VlNXp6OEN4YXFUUmxs?=
 =?utf-8?B?T0tsb2FIdXdobU5qcm1CV0dZSHR3YllzRUo3Uk5sekMyblB3NytDVzNad1Zm?=
 =?utf-8?B?UU0vWWpZZ0VIdjgvOXJZOWZOdjUvbUR0b08wSFNZOHo2bjJXdFkwcTNjMU93?=
 =?utf-8?B?Y2dnS2Nua3NDbDJpUWg5eUpSaFVWSGdFMmNmQW9lQjd1L3RHbHJuaHYvRzNs?=
 =?utf-8?B?OEc4Qm1RaEJyd0tOWTdWT3NCT2FON2tHZHlBMHNRZFhWendQZ3owbm9wNUFx?=
 =?utf-8?B?czN3L3pxdDBGRVRqb1dIZm5rWDRjeWpycnYrYUEvR21KbXZyL2E1ZDFCSkhv?=
 =?utf-8?B?NlkyTmxZdkdTVDI5akg4QjVGSUNLdWorRHg0czlLbTZsN09SRm9ubjZMNTlZ?=
 =?utf-8?Q?4dmUq3k6vgSwAKgv98f5SMA3Povrz4=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(14060799003)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 13:54:29.8802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eded9361-d964-4ff2-338b-08dd69491140
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5484

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIFp5
bmdpZXIgPG1hekBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMjIsIDIwMjUg
NjowOCBQTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6IE9saXZl
ciBVcHRvbiA8b2xpdmVyLnVwdG9uQGxpbnV4LmRldj47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGt2bWFybUBsaXN0cy5saW51eC5kZXY7IEpvZXkgR291bHkNCj4g
PEpvZXkuR291bHlAYXJtLmNvbT47IFN1enVraSBQb3Vsb3NlIDxTdXp1a2kuUG91bG9zZUBhcm0u
Y29tPjsNCj4gWmVuZ2h1aSBZdSA8eXV6ZW5naHVpQGh1YXdlaS5jb20+OyBDYXRhbGluIE1hcmlu
YXMNCj4gPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVs
Lm9yZz47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIEtWTTogYXJtNjQ6IHBtdTogQXZvaWQgaW5pdGlhbGl6aW5nIEtWTSBQTVUgd2hlbg0K
PiBLVk0gaXMgbm90IGluaXRpYWxpc2VkDQo+IA0KPiBPbiBTYXQsIDIyIE1hciAyMDI1IDAzOjUx
OjE1ICswMDAwLA0KPiBKaWEgSGUgPGp1c3Rpbi5oZUBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+
IEN1cnJlbnRseSwgYGt2bV9ob3N0X3BtdV9pbml0KClgIGRvZXMgbm90IGNoZWNrIGlmIEtWTSBo
YXMgYmVlbg0KPiA+IHN1Y2Nlc3NmdWxseSBpbml0aWFsaXplZCBiZWZvcmUgcHJvY2VlZGluZy4g
VGhpcyBjYW4gbGVhZCB0bw0KPiA+IHVuaW50ZW5kZWQgYmVoYXZpb3IgaWYgdGhlIGZ1bmN0aW9u
IGlzIGNhbGxlZCBpbiBhbiBlbnZpcm9ubWVudCB3aGVyZQ0KPiA+IEtWTSBpcyBub3QNCj4gDQo+
IFdoaWNoIHVuaW50ZW5kZWQgYmVoYXZpb3VyPyBPdGhlciB0aGFuIHRoZSBwb2ludGxlc3MgYWxs
b2NhdGlvbiBvZiBhIHRpbnkNCj4gYW1vdW50IG9mIG1lbW9yeT8gRG9lcyBhbnl0aGluZyByZWFs
bHkgZ28gd3Jvbmc/DQo+IA0KU29ycnkgZm9yIHRoZSBjb25mdXNpb24gLS0tIEkgc2hvdWxkIGV4
cGxhaW4gbW9yZSBjbGVhcmx5Lg0KSSBub3RpY2VkIHRoZSB1c2FnZSBvZiBob3N0X2RhdGFfcHRy
IGluIENvbHRvbiBMZXdpcydzIFJGQyBwYXRjaCBbMV0uIEFmdGVyDQphcHBseWluZyB0aGUgcGF0
Y2gsIHRoZSBndWVzdCBWTSBmYWlscyB0byBib290LlVwb24gaW52ZXN0aWdhdGluZyB0aGUgcm9v
dA0KY2F1c2UsIEkgZm91bmQgdGhhdCBob3N0X2RhdGFfcHRyIGNhbiB0cmlnZ2VyIGEga2VybmVs
IHBhbmljIGlmIEtWTSBpcyBub3QNCmluaXRpYWxpemVkLg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2t2bS9wYXRjaC8yMDI1MDIxMzE4MDMxNy4zMjA1Mjg1LTYt
Y29sdG9ubGV3aXNAZ29vZ2xlLmNvbS8NCj4gPiBhdmFpbGFibGUsIGUuZy4sIGtlcm5lbCBpcyBs
YW5kZWQgaW4gRUwxLg0KPiANCj4gcy9sYW5kZWQgaW4vYm9vdGVkIGZyb20vDQo+IA0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogSmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gPiAtLS0NCj4g
PiAgYXJjaC9hcm02NC9rdm0vcG11LmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva3ZtL3Bt
dS5jIGIvYXJjaC9hcm02NC9rdm0vcG11LmMgaW5kZXgNCj4gPiA3MTY5YzFhMjRkZDYuLmUzOWM0
OGQxMmI4MSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2t2bS9wbXUuYw0KPiA+ICsrKyBi
L2FyY2gvYXJtNjQva3ZtL3BtdS5jDQo+ID4gQEAgLTIyNyw2ICsyMjcsMTMgQEAgdm9pZCBrdm1f
aG9zdF9wbXVfaW5pdChzdHJ1Y3QgYXJtX3BtdSAqcG11KQ0KPiANCj4gSHVoOg0KPiANCj4gbWF6
QHZhbGxleS1naXJsOn4vaG90LXBvb3AvYXJtLXBsYXRmb3JtcyQgZ2l0IGdyZXAgLWwga3ZtX2hv
c3RfcG11X2luaXQNCj4gYXJjaC9hcm02NC9rdm0vcG11LWVtdWwuYyBkcml2ZXJzL3BlcmYvYXJt
X3BtdS5jDQo+IGluY2x1ZGUvbGludXgvcGVyZi9hcm1fcG11LmgNCj4gDQo+IEFtdXNpbmdseSwg
YXJjaC9hcm02NC9rdm0vcG11LmMgaXMgbm93aGVyZSB0byBiZSBzZWVuIGluIHRoaXMgbGlzdC4N
Cj4gSSBoYXZlIG5vIGlkZWEgd2hhdCB0aGlzIHBhdGNoIGFwcGxpZXMgdG8sIGJ1dCB0aGF0J3Mg
bmVpdGhlciA2LjEzLCB0aGUgY3VycmVudA0KPiB1cHN0cmVhbSwgbm9yIGt2bWFybS9uZXh0Lg0K
U29ycnkgZm9yIHRoZSBtaXN0YWtlLCB0aGUgcGF0Y2ggaXMgYmFzZWQgb24gQ29sdG9uIExld2lz
J3Mgc2VyaWVzLg0KSeKAmWxsIG5lZWQgdG8gcmVzcGluIGl0IGlmIHlvdSdyZSBpbnRlcmVzdGVk
IGluIHRoZSBmaXgg8J+Yig0KDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBhcm1fcG11X2VudHJ5ICpl
bnRyeTsNCj4gPg0KPiA+ICsJLyoNCj4gPiArCSAqIFByZXZlbnQgdW5pbnRlbmRlZCBiZWhhdmlv
ciB3aGVyZSBLVk0gaXMgbm90IGF2YWlsYWJsZSBvciBub3QNCj4gPiArCSAqIHN1Y2Nlc3NmdWxs
eSBpbml0aWFsaXNlZCwgZS5nLiwga2VybmVsIGlzIGxhbmRlZCBpbiBFTDEuDQo+IA0KPiBTYW1l
IGNvbW1lbnQgaGVyZS4NCj4gDQo+ID4gKwkgKi8NCj4gPiArCWlmICghaXNfa3ZtX2FybV9pbml0
aWFsaXNlZCgpKQ0KPiANCj4gVGhpcyBpcyBkZWZpbml0ZWx5IHRoZSB3cm9uZyB0aGluZyB0byBj
aGVjayBmb3IsIGFzIGl0IHJlbGllcyBvbiB0aGUgcHJvYmUNCj4gb3JkZXJpbmcgYmV0d2VlbiB0
aGUgUE1VIGRyaXZlcnMgYW5kIEtWTS4gUmVseWluZyBvbiB0aGF0IGlzIG5vdA0KPiBhY2NlcHRh
YmxlLg0KPiANCkluZGVlZCwgd291bGQgaXNfaHlwX21vZGVfYXZhaWxhYmxlKCkgYmUgYSBwcm9w
ZXIgcmVwbGFjZW1lbnQgZm9yDQppc19rdm1fYXJtX2luaXRpYWxpc2VkKCkgaGVyZT8NCk9yIHNo
b3VsZCB3ZSBhZGQgYSBwcmV2ZW50aW9uIGNvbmRpdGlvbiBpbiBob3N0X2RhdGFfcHRyIGluc3Rl
YWQ/DQoNCj4gSWYgeW91J3JlIHdvcnJpZWQgYWJvdXQgYSBrZXJuZWwgYm9vdGVkIGF0IEVMMSwg
dGhlbiBjaGVjayBmb3IgdGhhdC4NCj4gDQoNCi0tLSANCkNoZWVycywNCkp1c3RpbiBIZShKaWEg
SGUpDQoNCg0K

