Return-Path: <linux-kernel+bounces-398173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B19BE6CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2323B23A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D81DF249;
	Wed,  6 Nov 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BYeH97s1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BYeH97s1"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B451DF24E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894834; cv=fail; b=b3d6UdZeSkZIhyits08NBdq5uVi+Xmr9gdTdtLD0qior5d2kpZJY/wn7ckqxoPCLl4C9Byp/syF707qxBp2JXRV3th39/ejoUPZn3Zz5O006zH/fRyziGc9dlxlPeo1tCXH3M0qcXLn5nvn00cPXTTDWPYpSp99Vqiv2i+dUQjU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894834; c=relaxed/simple;
	bh=DOxS8/hihfYc3U8Z08eHC6G2O11umDrjltOYcmHkIc0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QCWz8HJVPoGtXgEdV2eu2c+YBj8P0lHfaFgi0f/eI8/+phS6zDwor9gyFJSEsigRF+L6/mP+xQFliEhI4SvphuciEZ7m9Dwbbrg2zrySF+N1GDj95NKC7PPCxUL4Pr9INN4+Lk4FuFTEIJ/M6Da+jCh5KPEgyGHkOrjGVpMmuvU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BYeH97s1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BYeH97s1; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pMw4CS/OMzYZboMZd3OVvbUaZAJQZ4VoYQZ3fRjOEcs/OhXcHisU12pCMbRb0vr38A3tiiQFrtwcOrqXN6BahJI+P1EobhHKFFhS/rJn2VZ+L5m7paYrY3cyXHOWus2SahRGzSK6kSwuC/H0ZW5+pQ7BigoljPLQNm/2xIa1hBCVEjHQOH4xNXcWm1uqIA5z3vTBs5thfokgGYOxweDBmAylNfSGw+p/GVGISmodvYG+ZFMT/ZaXl3HxPYU5he9dVlUgHhi4lbDYgvcXhiDTAzwthP4Eypfe9yLl+6st7sJ81tVRGMY3zM91DNe6Kq6By5bhY9oQLnxv6oJmRcaMHw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc2uYVUkEyi0Rgq2HqZ8K/dEcsgUxRdQxJK9ao7qYR0=;
 b=Xd6yH8bxRJBaQVvXCDjzXAmx8hwE2Jtp/Ztsv4gbZ4Aq9bU5kSu3t8jMyY34+/iUFigHW92+Di9yesQqRLBsz5NqCoHgVFk1XphrP9W+YlUfcil6o2sNROHkhX/0rvT0VngvCH3REOkv3bpQomy4kfdtQVZWcHXpNc5/79sdF6hKvkUmNotQcQL/k07Xe8bR2yDhlQbz5RRqJ3EdYhCBeSK5GyVw6j+YlJ0aLGbf1EeYYK3P/K7A9jl8uQOxzcU4np0yN1RnAE6XklDAwesVFmXsu3wL93hD5Q72Ubtuzxv0QGkLbD1eL6NLURUg66IsZQqXycr2VVlS97RcHEDncA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc2uYVUkEyi0Rgq2HqZ8K/dEcsgUxRdQxJK9ao7qYR0=;
 b=BYeH97s1pPyW8qad27TOBdyCrk0AtT7DxeV587yR9UZvJYjRhcNgaFFfkk04j0LrNsVpg4j/jCwoYC74xOrqnTOQDS7QUr8nK6hCL/ErxqUvH62oQXv6+7J5OqTU+bFT62XrwVw5Dkiu6d+sbHeGfdtwP2Q/MFK8phcPxwn8Zzk=
Received: from DU7P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::25)
 by DB9PR08MB6329.eurprd08.prod.outlook.com (2603:10a6:10:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 12:07:04 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::e) by DU7P191CA0017.outlook.office365.com
 (2603:10a6:10:54e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Wed, 6 Nov 2024 12:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17 via
 Frontend Transport; Wed, 6 Nov 2024 12:07:03 +0000
Received: ("Tessian outbound 0fe1877cedb7:v490"); Wed, 06 Nov 2024 12:07:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1597bf17246da1a9
X-TessianGatewayMetadata: 5xRCm+PKI+S1DfMBc/zJrJzT6Sd2OpTLmqwSmASFQZB9Q6hMKFI2jE3OPvtaqNG1Zg8XmJHm/i9Ya0PDjcfN+MKqUAJrUUep447vVKCwosxlo6OUVmFwNkk7NyLXDvuI82eLRFGPrCTrMXxj0HfjNM6h4x1Gfm6sI92dh0ACzKg=
X-CR-MTA-TID: 64aa7808
Received: from L9f4ab5a714c7.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 77D054E7-EE16-4BB1-B9D5-11E12EB651F5.1;
	Wed, 06 Nov 2024 12:06:52 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L9f4ab5a714c7.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 06 Nov 2024 12:06:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRho2jDd17iCiN1jzHedna2eFZOJY+oQUs/v17D+WNRPyKThPypvlajrZfGjbiCpPrzV07q4MlcgV1dNKUbWlrgeXO8yR8VhsCISw6oZMsBRRH46YpSS/dLRWA+VBuoFbPUDEJ1LxxnkFNIcxH7OsYj320Bn5tylOnAzetbw8kPa7M0S8lfeV4ggI3tQTf1lxfdhH+bG6FSzIj62E2ggTznGsPEG3UBdv7s498cKwccRrVMLAJc+BVpnkrcl/p6Shl0AjF2g3hBeoDyNUoVICoaSeggc8EyJOkLf9bQW72xdCavpqkS1KAKndnDkhufDIOXKsUQXVBmCD8n5Ii/KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc2uYVUkEyi0Rgq2HqZ8K/dEcsgUxRdQxJK9ao7qYR0=;
 b=CTiBi/+rUbJbbww8mi/Y+Jp+vKecNxXxWTvjoaliCcdktNvn6JAbQiHKdTdK1Fo/aA8quS4ZfPPBojqzfIszw9hw6YnGGBY82vWc1ABRm2Dwg8C1oq68u6tqzYiK3Q4JMehxohuWnmp64yrsCW8Cw6K7E/U3WGjHk85xna6KhtwSKyi/4HVpam/cA1uahZ3Qovj2OWy+xC6f/tHtzNhLUJ+NVH45b+zRY5M84hAlXOC0B0UKL7ihEWxz9BZowaOd4tA1qEF5pI2rr86aiMHCwFkFgNMSRR2Vc6C+rJiRwGYYV8MXh0eQWHSEjJ9tffjG7JglosrOqmuZwpEzUmsC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc2uYVUkEyi0Rgq2HqZ8K/dEcsgUxRdQxJK9ao7qYR0=;
 b=BYeH97s1pPyW8qad27TOBdyCrk0AtT7DxeV587yR9UZvJYjRhcNgaFFfkk04j0LrNsVpg4j/jCwoYC74xOrqnTOQDS7QUr8nK6hCL/ErxqUvH62oQXv6+7J5OqTU+bFT62XrwVw5Dkiu6d+sbHeGfdtwP2Q/MFK8phcPxwn8Zzk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DU0PR08MB8561.eurprd08.prod.outlook.com (2603:10a6:10:406::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 12:06:47 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%6]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 12:06:47 +0000
Message-ID: <345dfc04-753b-4411-be2d-e4f604c1c4b1@arm.com>
Date: Wed, 6 Nov 2024 12:06:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] Complete EEVDF
To: Peter Zijlstra <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Saravana Kannan <saravanak@google.com>, Samuel Wu <wusamuel@google.com>,
 David Dai <davidai@google.com>, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de,
 Android Kernel Team <kernel-team@android.com>,
 Qais Yousef <qyousef@google.com>, Vincent Palomares <paillon@google.com>,
 John Stultz <jstultz@google.com>
References: <20240727102732.960974693@infradead.org>
 <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
 <4a3dac53-69e5-d3cd-8bc0-3549af4932b3@amd.com>
 <20241106110925.GK24862@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20241106110925.GK24862@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0327.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::8) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DU0PR08MB8561:EE_|DU2PEPF0001E9C0:EE_|DB9PR08MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac1f15c-4455-4b94-44b2-08dcfe5b8671
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UzJZVUx4NHRpZ0d2alVFektPeERGTUNJdW8vVlhrQWcyWk5hRytITG84clU1?=
 =?utf-8?B?VW9PMmhTVU1ZNVFEZFJuMzM3UFpTMUpTRnpmUm0wWGFEOG1ZdlZuWUZGL1E2?=
 =?utf-8?B?YnExYnl1QUpLVThhYlFaWTk1VnUvTmNVUnQ2UFc1RkNOT09wOUlzQVYwODNK?=
 =?utf-8?B?T0dIVTlzc05tdEhValBuczlvUW4vUHZRbXQ4Y1ovUlFlK01xSXNzV0VhZjJX?=
 =?utf-8?B?NDRSNFFOVG55SDNoV3paSHpiSTRuTFViUHJrbDUvekRDdDVXV1dSV3JDTUZn?=
 =?utf-8?B?d3pWd1FJaUhNS2lPeFdsMkkzWG9XcTErN29XSjZDMElXTXBkZUFheExUdDky?=
 =?utf-8?B?dVlJV3J3a0VXazdXR3Jib2lQUWFsZktqRWV6QkN1TzFSTGZ5OVdHOVdGaHdY?=
 =?utf-8?B?aUJBR2dHMjQ4VzJTUEhJZFBweWo1WEMwYnZwc1pBSVdkemVadnlpR2ZxN2dD?=
 =?utf-8?B?ZUt0Ky9Nb2MwaHo5WkxWeTFudG1PL0Npc012V2V0Wk5VME8wOE1SSjhPLzVn?=
 =?utf-8?B?Qlk2elBaSHZtNjdaN0syY0xodXJiSHBRWVRzZ2JmdEYrUEMyV2YzbGJ0dlZt?=
 =?utf-8?B?UGxsUzZVRUdEUGxpUUpDQ1JYZ0JQUDlVWnNZTXgyNUZ6S1NxV0haaTJaNS9p?=
 =?utf-8?B?U0dsVWZ2aHVENTNhaDFjcjlQbVhxcWJTTDdMaURGb3RSa1F0aDFtMi9vV0tn?=
 =?utf-8?B?bDBXTDdCMnF6Tk9GMlprUjd3MTEwdUxRMDR5MlVaSkJTQlBkamdQN3lLN05q?=
 =?utf-8?B?U3dIWTR4WU1zMGFNMnZXSmJ1TUY2SkxLRTFSV3F3SmNFcHhPNTFkdlBueVdr?=
 =?utf-8?B?bXFIZVhjeEphS2RRcmc2YmZySjlManRDN2ZtalZXeDJ3Z3NRcERLSnhFc2Jm?=
 =?utf-8?B?UlU4aldUQVhQUEhOc1J2NHErOGNWcmVuQU1NK3hNdEVkM1ZZdjIzczlOT0Nm?=
 =?utf-8?B?OHNlTnh0R2ZxRkNESjhmRHNFeTJxTDNQM3drQytjTExHK01RMU85M1E3dmZq?=
 =?utf-8?B?OUxtSlZzYTAxenp3SFpQc0lLSGpQMXE2dE5WY09kdUpEclg1V0NaeVBsV09o?=
 =?utf-8?B?Z2Q2K1ZDQ1hqak1ESjZpaXFnb0RJMzZKd3dwUHFocVRBa25ZV3hncjVsWCs4?=
 =?utf-8?B?K2JwMUU4a1pRWVl5QUdMbjlNTGF2NzF2RzBtVmh1aHJzUGljSWkwekdYTkl3?=
 =?utf-8?B?end2M2l1UmJJRk84ckE0MTN5ZmcrQUZMeGtKRjdtT3RNUk5FTURxRUcxdkJl?=
 =?utf-8?B?eGhlWm0vRCs2QWxlcG9hUmpTRzk5ejNybXF3NmpOUUpVc1V1cjhpZmN3OG1w?=
 =?utf-8?B?enZiNkpXYjRTT3BHRHZHQ0dsWUhUcGloTU1pTTNMZFd3ekUzcHMxNVZtM0dx?=
 =?utf-8?B?WnVyZ1RSUDJJaS9sMUdKaGROWjJyL3FqS1M4eEpyTG9yWjFsREMrdWhoTHZT?=
 =?utf-8?B?YS8vUFlxQlZ3bmx2a1BVMWkyajM3dkxaWmFXc1Ixd2ZPMUZwTnhwTmNrQzJL?=
 =?utf-8?B?MDByaEpaNERPRVg2eklYWWxhS1VPQ21DVnJTVUczRWRaL2Q2TnJ2YUI5L2Fx?=
 =?utf-8?B?STNCMVV6YlRJZjBqdWN3NUpOS1dzWmhwUkRkSkxKSWg5bSszbjB6dVcwZnVm?=
 =?utf-8?B?ZG9sVGcwRlZtcU95bGU5MU9HODNtSWUxYnlNVVU0QWVXRk1ib3R1Yjg1ZGJR?=
 =?utf-8?B?V2wyRTNubnRITGZmTHRUc0hmOC9ub3RqWmVQOURrYzlGdUZzQ1psdXhHb0tp?=
 =?utf-8?Q?P7hx8xvcz1mBJpQiQXaeoJ/EupN7xmoPNgebm9F?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8561
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	270d7010-110e-41cc-d49d-08dcfe5b7d12
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlgvaEpOd1NUQVBvckZhOS9nL0JTVThLbTU3dVpVU0liUllmTFhZUy9iL3Zs?=
 =?utf-8?B?a2ZwN2FhV0VlaXYxNjcrS2djVFFtOE5qbkhURW9GNUJwMm9tUWs3WXhRcVhL?=
 =?utf-8?B?Q2xlRjZ5VE9RRVo4bkJPdEFhcEcvb2dsMkdkUFdidllCM0FXZWlkMzIrUFlM?=
 =?utf-8?B?SC80SHoxblFVWVYrL0J3ZlpVWmROUDNxQXBqSlBxU2hCa3gwaEFUM1o4U2tz?=
 =?utf-8?B?dUYzZVlvWEFVMlVsRXR6ZmxEMjZMNTc2TkJTKytqYVlHdlFWRDE2ZUFOUFpk?=
 =?utf-8?B?RGtzVE1vZWk3dUY3clg0ZWZ1QUg5L25vRDRxbXdwZWdUajFTbW01YVFXQ0p3?=
 =?utf-8?B?Q3BJUnM3cWgxbnRLc3oveGpnc1M2V3U1aVdLY3VMSGgyRkNYT2FOeUlsT3ZO?=
 =?utf-8?B?dzIwajRkWjNFTG5IR0FlazZqRlpyOHRKRFh3S2ZKOHF3TXVMOEFObDRWR1hP?=
 =?utf-8?B?V2xkbVVmSHRzc0NGY1VEVnp6R3p5bVJlcFN0NXVMU2tyVjl1a21EbVM5ZEpR?=
 =?utf-8?B?eDdNWk5oaVFURUVoZmVDNEoyZTBMeSs4V0xiTWcxNENxeS9NK05qUjRCRW1D?=
 =?utf-8?B?L0JKU3MzYzQwM3BzSzVoUzc1MjNPY0pmbmlpdTZTbWJYejVRaUtsYjJiMUR4?=
 =?utf-8?B?SmQ0TzExNS9CcTFYcUZlZkdzWjc4dFN6enI3UllSamVoVXM0SUpmT09jOWZD?=
 =?utf-8?B?NUFGSEF4NU5GUDd5ZXlLaitPdzh2ejY2QXI5WEVDUlcvYzkwWTVBaUpBcWgx?=
 =?utf-8?B?aEk4bHdDRnAzbUowMXhLakxxdXZOVDNXNUtJMTFUejVWY3VZMGYxL3BxMWgw?=
 =?utf-8?B?a3BNZFZOVnp1VFppeEhyWHR5ZkVPRDhQT2oySEMzUEJxNFNTc2RPK0VlUDZr?=
 =?utf-8?B?Mlp0QWRHR2F5RDhTRUlGa0xSWlkvQ3RnZ3U1NjhJN2JlYUFIMy9uSXFTNU5Q?=
 =?utf-8?B?dVlGcXFKbTFCeitmS3R6K1N2dXFaV3dlMG9XOFlQTkwrZG1pYjlVai80VVNE?=
 =?utf-8?B?WWJRdTVTSzI0OHIvSlFkdTBuTEszam44SDQzd1lPVURjbmFiRmFVOUxMSDE5?=
 =?utf-8?B?OUMrazV2eXg2eVkxVmNuOWk3NGhPMmovbGxvQmxmSWxFT01MenFhNityODcy?=
 =?utf-8?B?K1QzUmt2RXAva2xhRVE1cU1LTTMzS0tkQ0dmVkFBRmprNGh3YlJTUWE4eU9x?=
 =?utf-8?B?aFBiNW9YdGExaGc3QlRMYlZUdjdvMGlFUGRxNGpRVkJtdm5YZ0gxQktzVXBF?=
 =?utf-8?B?Vi9IMDBYcjdWNjMrTVgyMHlvUTVKVHovb0RGN2x4eVdKYktHWTVvajJTR0ky?=
 =?utf-8?B?TENPU09TYTlneGxJdFpIQzkyVnJMSUg2ZC9VV0gzejJZTHN6VmZCUFlhSStG?=
 =?utf-8?B?YjhXcFVYelR3WUVwaXpqQzhPdVVGZ1dJbU4zayt2bTBQSmYwcXJBWDRyU0hr?=
 =?utf-8?B?TlA5MS8rZHRoNFNPQUUreXhMUDJBaEhqR01aWWdFU1JJRTBlRDArZUREOFg4?=
 =?utf-8?B?a1YrUGo5QzEvRDd5aWIremVxVjN3RXlzNnVwYk8wTDRpTmNLc3g1eTRvQ2Nw?=
 =?utf-8?B?N3BuNVB1L1pPeElQbGUwMzNPRm0xVkZTU0FvVzhKM0FvK0k3UUxDNWhUV1lL?=
 =?utf-8?B?ZXJ1akc4dTVLa0Y4Ym92RStxcGJjTjFuc3loVFVQSHNlL2NMbnJJb3VZVURQ?=
 =?utf-8?B?WFVBSGxrNWR1MnUvV0JxZ1c5WW5WdmdFc040eW11ak9KcERhSjlMbVhRYzR6?=
 =?utf-8?B?Uk1jcmZ6VDFmYUxpQXVJMm5kd2dEVk9LR1lTbmplOC9pVXpWTEZLRkJ6ZlpS?=
 =?utf-8?B?bGRSTVROM3hna0Vod2hJelJLd1ZVQUxVNTdJdStMRE5IWVFXS0lPeXh0Nllm?=
 =?utf-8?B?RytFNTRwSWNadlpsMnNzSUVySm9EeUxJVHJ1ckhubHFJOWNWZnBjckw1ZE1V?=
 =?utf-8?Q?O3oAXWps0C8=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 12:07:03.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac1f15c-4455-4b94-44b2-08dcfe5b8671
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6329

Hi,

On 11/6/24 11:09, Peter Zijlstra wrote:
> On Wed, Nov 06, 2024 at 11:49:00AM +0530, K Prateek Nayak wrote:
> 
>> Since delayed entities are still on the runqueue, they can affect PELT
>> calculation. Vincent and Dietmar have both noted this and Peter posted
>> https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.tip-bot2@tip-bot2/
>> in response but it was pulled out since Luis reported observing -ve
>> values for h_nr_delayed on his setup. A lot has been fixed around
>> delayed dequeue since and I wonder if now would be the right time to
>> re-attempt h_nr_delayed tracking.
> 
> Yeah, it's something I meant to get back to. I think the patch as posted
> was actually right and it didn't work for Luis because of some other,
> since fixed issue.
> 
> But I might be misremembering things. I'll get to it eventually :/

Sorry for the late reply, I got sidetracked on something else.

There have been a few power regressions (based on our Pixel6-based testing) due
to the delayed-dequeue series.

The main one drove the frequencies up due to an imbalance in the uclamp inc/dec
handling. That has since been fixed by "[PATCH 10/24] sched/uclamg: Handle delayed dequeue". [1]

The bug also made it so disabling DELAY_DEQUEUE at runtime didn't fix things, because the
imbalance/stale state would be perpetuated. Disabling DELAY_DEQUEUE before boot did fix things.

So power use was brought down by the above fix, but some issues still remained, like the
accounting issues with h_nr_running and not taking sched_delayed tasks into account.

Dietmar addressed some of it with "kernel/sched: Fix util_est accounting for DELAY_DEQUEUE". [2]

Peter sent another patch to add accounting for sched_delayed tasks [3]. Though the patch was
mostly correct, under some circumstances [4] we spotted imbalances in the sched_delayed
accounting that slowly drove frequencies up again.

If I recall correctly, Peter has pulled that particular patch from the tree, but we should
definitely revisit it with a proper fix for the imbalance. Suggestion in [5].

[1] https://lore.kernel.org/lkml/20240727105029.315205425@infradead.org/
[2] https://lore.kernel.org/lkml/c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com/
[3] https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.tip-bot2@tip-bot2/
[4] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com/
[5] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com/

