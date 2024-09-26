Return-Path: <linux-kernel+bounces-340598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3209875B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A05DB27674
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E08145B3F;
	Thu, 26 Sep 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J3Vntj7S";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J3Vntj7S"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A714831C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361147; cv=fail; b=g+DgKZeuDB3gZqd+Ml7QofXkC/RfLtMpJeAHRjXilUi2CgVsM733UB8a+9y4whEcHgWLluLfoDheagFSF74L8eeuawfaXzFP2AxS4Puav2u7YIPwUGv3nqgpIHZ9HtrjLNQ22NRATRpb4EZcs1djEG8ZA9z/Tfd9EfBl9lAIwME=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361147; c=relaxed/simple;
	bh=faqKlErYs/+NemZYafOlspTx8jSp6NfuYTpMUcOa73w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RORzJhM1ZQ5pJyN/i62rSimGy9j+5CqI8W07szoUpXozRteV4C4RBpxwCMPcO1dLMyVe3gGO+GtT3tpNinOJFfHzUmMh0RGyEEuBKEOpRcCursjMfMJIP9X0x2X/xX1rHlUve2Fr4fWGj0y1p11jh0ve+B5ijvWpxmEaPjvory0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J3Vntj7S; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J3Vntj7S; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Hchy6UnN2+3WUzRqScIY5ioOwND0LeqEUFtnGE7ftQqJ2DKk6JeNaly44Ya8AJ3sb+tnvlnFnDYTJNRAKMq9UdGGXBOegZdxWozSuFO9wDoSTuJW2yg0o6CZUgjiVD+d/SKZaeDnSEpl+wGE5cc40AhL+kjZt1Df8HV9eglr4fqb9jHCQTz/diRbZcDH08ehEcqfH6vTG19p/kpgjRKWd4Z1hZ3PabH74FkY1tnaL4M52LRchlQXxgy3c1s4WhH/gTY7hUiQa/HRKxOnUIYU5BbxFHtyHOF0fQEDmqACp1xf11KTLF/rBLOvGjf87FEMaYbXOy9pHB7th0QEdCZK4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HggrlZsQ/k5VqayvzF839fRvQA3qyoUuY4kRQxKvXhw=;
 b=I759/j5+DvoDGS9dLL2q/iaNeVz6iSi6+ROQmVwJduoSw7OaDlO7R5Ju7EOuhKVfO6HyVYUrGMzsiJzAdn8LMfF6eKDDHG3ByHc7U/7cCtpolnZJ0DJqIWGuj8X/QHttKw4+M2CFKWQMP2Rt/JraQH4eo09JsP47+X2ab26CPQzWVnydVq+i8gjhkBBBkoNZRwByOQLH4iRI9o6tiz8VVvNOYH6+YpwHlsQO0yXktjWa8pUiam99+w4xv5TebSb6hpt4lgcanxrRMUTf/YcZVnzw+/vAJ+R2hjjtIm1UmfYOJay+FQSTdCX7kz2RPbzL7LZYec0OGniravp+NfkCUQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HggrlZsQ/k5VqayvzF839fRvQA3qyoUuY4kRQxKvXhw=;
 b=J3Vntj7SutLYgWqAE2lfQCCrnqNLxDoGbbiBgWcgOJWdmuAjmgI0oPVfMBK36NIg3AkxtBs2weH3Adrmtth0caCvCTaFTrbb1ZD9vMmQN4hL75l44x4ESUwdsty3WrcgKys9ZSSMCdlVIQdS+N5bocJ8Xpz3HKtpPXxlBvxdJ9E=
Received: from AM0PR04CA0059.eurprd04.prod.outlook.com (2603:10a6:208:1::36)
 by GV2PR08MB8343.eurprd08.prod.outlook.com (2603:10a6:150:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Thu, 26 Sep
 2024 14:32:10 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:208:1:cafe::eb) by AM0PR04CA0059.outlook.office365.com
 (2603:10a6:208:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.16 via Frontend
 Transport; Thu, 26 Sep 2024 14:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8005.15
 via Frontend Transport; Thu, 26 Sep 2024 14:32:09 +0000
Received: ("Tessian outbound f9d5b330f2e0:v465"); Thu, 26 Sep 2024 14:32:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ddc694533015f409
X-TessianGatewayMetadata: 47x02Gx8mFQ0Tl3xXuKxbl1l03D1kdOj2CpZlFSO344w7aBjW74cElXBICYdpI7m6z2BVbMmbv39P1SeL90+dgCfiNuuUwYywliAT/7PE3xSAD6kc4Pr/2s9ppsLj4bptJ1jWYmp/eVw881Crg3cdwZ1HkjdwpU4fnHHuQpZn+U=
X-CR-MTA-TID: 64aa7808
Received: from Le06ea4ce1e77.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id DA5A138C-2EA8-4D1B-AA7E-446F991B9B7D.1;
	Thu, 26 Sep 2024 14:32:01 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le06ea4ce1e77.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Sep 2024 14:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiHbQrE+ZI8TYz8QMGzGtyUe/UWCWyjwQb6hK/trivatW1XYkZWLIAeTgsDLfPJ7YPXlAQpZA/eAavXQvqTNiafPAbDQcfA9a3Zd8SkqLOh4iZNrsX6ofkHav23OqIOtS9el1qbuczbfcApIG7x7MG4vzQCFngjRUQIRdrpUqtG6BSbN8Ur/HocmPGbrqIEwiq9bJBU8z1wd4a2kf5rU1EwwuD8c+TWe4iiifqsL73Jleta4/Dw0QAa3r6AkH4L2pEPH6jKTSgRc8orEOTsKXFYcNUjaW6PZXNxqYwzoJBF4ceBsArBioxXYHs0DlBaODSH8DtOSqcRSrecmOH1zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HggrlZsQ/k5VqayvzF839fRvQA3qyoUuY4kRQxKvXhw=;
 b=v4YaFAcfpCFTVq1SDHEk1uciWoxIMycZFQqAggcUlsX39BryRpNZy4MeXIXtoX6+LWwoOFsl8/gUMF0fMBDNZW1sM7ZlOnFKlhLZx+kvTyEdWsb9CETXl5LcVWyqGA0c/6zv7/A2dlcWbqZ4aCdtqMEXOO3/FKrTobEmxvurdCMH0uxcsbBAxQxs+5t1wNooUE0CVu1c2J0a7d7BG//wiYeqTB3lm9D4bxop5Cw5z35+G/TDDu/hFr+P3W+81/e5wXUOPs1LQTc4i5HpFNNrTRuIS9O0fHSQmxA6SvLpBHFFaV4zycIaN7MvBHvtgdyFaVAxQwUpA+IQNLUNiff6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HggrlZsQ/k5VqayvzF839fRvQA3qyoUuY4kRQxKvXhw=;
 b=J3Vntj7SutLYgWqAE2lfQCCrnqNLxDoGbbiBgWcgOJWdmuAjmgI0oPVfMBK36NIg3AkxtBs2weH3Adrmtth0caCvCTaFTrbb1ZD9vMmQN4hL75l44x4ESUwdsty3WrcgKys9ZSSMCdlVIQdS+N5bocJ8Xpz3HKtpPXxlBvxdJ9E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by GV2PR08MB9399.eurprd08.prod.outlook.com (2603:10a6:150:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8; Thu, 26 Sep
 2024 14:31:51 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Thu, 26 Sep 2024
 14:31:51 +0000
Message-ID: <941ddfc5-da9e-4f09-8025-b1e4c25de406@arm.com>
Date: Thu, 26 Sep 2024 15:31:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: sched/fair: Kernel panics in pick_next_entity
To: Vishal Chourasia <vishalc@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Mike Galbraith <efault@gmx.de>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <ZvVWq3WM6zVza_mD@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::23) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|GV2PR08MB9399:EE_|AM3PEPF00009B9D:EE_|GV2PR08MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 02134bca-be00-4fee-8170-08dcde380103
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NHN4czhlT1ZnRXpQNVpqalcwMlBZbWN0dlNBa0JHUFVlNU9EU1VxUC94L0JO?=
 =?utf-8?B?eGgzdXJObDBNejhYd2pTZVgyM0RPcEJ0dWdXRi9FQU9JNXE3Q1BDdGdkUEl5?=
 =?utf-8?B?YXUrNlh2MGlBSDUrWXcxZC80SXloay9qZFdRWERCaVFrV2NYTC81WjJNQkYv?=
 =?utf-8?B?V2JyRHNvZVA2NUVRaGZwM2MxRkxDTTEzazNZTGpka3N5OVhiSzFMYWJDKzJK?=
 =?utf-8?B?VDc0emNHQkQ1eUFiUFZpYWpBc0VlNUpMZW4wK1VGWVhTVG1LN04vUm5zbWZM?=
 =?utf-8?B?V3VMYmlRR3haUUdicWUyNlo2VG1jNUZISmpsNVpvMGZMUDVnTU01RHh4R3pT?=
 =?utf-8?B?eit4ZE9BcnlpUjZKSGtlUFNCUHVzbE9WcTNLZjFTTk1yenlqMld0Unhrb09v?=
 =?utf-8?B?UGxiSHVheWJST1NiMVVndVRsNW9hVFVtdjlOZlFDSmg5TXN5alZNdWVRNUJU?=
 =?utf-8?B?MElXWjlpcTJ0MVY1QlZkVjVIV1BNZHFyNWJRUVVjSjd3NXp6VGc5bGtsaVhv?=
 =?utf-8?B?cTltcHR2ZjVubTB3S1FQcVlXZ2YwSUJNcUJXUjhTMzVXaXJnNUZ3N1ltZnhD?=
 =?utf-8?B?NzNzUTRBNUtiT2xSSGFCOTFlcFhHN1R1bk1obGYxeEFsZWF4dFhpZzR0MFRR?=
 =?utf-8?B?RUVNTnV6bnJTa1RsOFBnLzgwbzR6UlRVcnRhRWVEanp6Y05DTW42YmRPbFQ1?=
 =?utf-8?B?dytUVWhxU2EwRlNxR0xlSlkwZU1hMlJiRDZTam1EWkJkbUV6bkVYbVo4TWJ5?=
 =?utf-8?B?ZXExcEVETG9Hb0owTGhHZG96NDZGbjh2R3FtVFcyMFZUUjFOcmtaSldUbzZW?=
 =?utf-8?B?b3Y0Q2RTWlZlRFRtZi94Y1gyNlcwQkkzaUpqcWdzQ3RUZnpDVXRhcWlyTDY2?=
 =?utf-8?B?VVVGZXNSWFJKa0xYTHY4ZVVWeE0zZmVwVCtFaXpQQlo0OW5oK2psL2IxeWVD?=
 =?utf-8?B?OGVPY3NpTFNKM3gyTVZGc0IxVU1OdXhobUZzUkdpMW5QYjM0ZXBJbXRFZmF1?=
 =?utf-8?B?TWd6VlBvNGV4QUF5RWVKbWdiQ0ZwS3o5d0hFZzdjdXYvQ2VTeEtGM2R5cWl6?=
 =?utf-8?B?dzFkVWdOTWdMeG8vWWhybm5KL3NFbkFaZHRCSGVDTzRPM2lmNEhGaVBvWVhK?=
 =?utf-8?B?N2FLdVJFRGFHU1hDMDdpZmhjVWlOWXFtVnUxNzQxSGNoeHlWZ29NTGJvSTVW?=
 =?utf-8?B?dHhJUUFMV2h3bk95TVU4ckM3VlFnUjdFbldFMSsrWDdESlE2bWhBUjViUGlq?=
 =?utf-8?B?QWZYekViQ2t6eVVzamRqYzVzeS9UdjA4MFJydWYrUnlnS0thbGJiQk5SSUFN?=
 =?utf-8?B?VlV4aWw0QUdTeFczSlV0SnZ1R1VzT2xvald4QmxuekRRa0tybEhvT2VJTE5v?=
 =?utf-8?B?bW94OGx4RmJWbXZMWFJsQzl4RjBwTWJKa2FxSGQ5VmgzV1ZBWE1HV1RYNU8w?=
 =?utf-8?B?QUZYRXZnMnQ5SkIvLzA1Z25qeE10VFNqUDB3TmcvVlVPbnlOZ2N6dEtZUWs0?=
 =?utf-8?B?THJLUkZHWm45amRta2FoK05Hb2FPZ2FraXZROXZ0SllsVCtZNms2OWFZL1pa?=
 =?utf-8?B?UjNqc2dTNTVRU2JzZzR4QjkvZHdqZ2cwbzJ1M0N6aDY5czFML2dGdUMva01w?=
 =?utf-8?B?cUxtU2NPT0QrMUdpdE9MdDJtRDFaOVBYSCtZSGNyZEhMNGw2ci9LendwOFIy?=
 =?utf-8?B?c2JVNHVabi9FeWx0dy9TTzVsZXFwRTA2Z3lqVUVMMW1OVmx3a2NBUHRoNlRx?=
 =?utf-8?Q?2gzanIFfBC20Y/2Arg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9399
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f8f95125-8d7b-4fb2-2a09-08dcde37f62b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0lNVS9QWjFlSm1vQitwUVJjYTJTcWlPdXdvWHhlWEk3TE9YMndnM2RTakZl?=
 =?utf-8?B?WENiZWN3SHBZNlk0cUIwd01nbk9INzhmdGd1bkRrWEl1SVJvZFBMdjlXeGpj?=
 =?utf-8?B?WHY1MEFRdzRHandWVnVaeXdCSmIxY0FPVDU3WncyVmxZKzVCTWtFQk1wTW1D?=
 =?utf-8?B?K2NBUm5vRUdwbHFwOGd3ZHNoSndVUHZFR2tqeXZicHJVSDVOVmp3TjR0VE5Z?=
 =?utf-8?B?QnNWYVdGeFR2akU3TVNndzRBbXZpOTV2TjFUNzFNWlliYXlaS2RqTVk0aU5x?=
 =?utf-8?B?TVprVGc4STFUNFRIbkk4eWw2aHh3ZW1jRDZiVUZlb2FhZWtYeFJqeCs3WSsy?=
 =?utf-8?B?eGFVU0VUWndKT1JkbEcrWHVQOVUzRDlXd2lpSGZKQWpRN1hDS3d1dE93N2Fi?=
 =?utf-8?B?TUZwQWFvTUFXK3dZQTRhNVFBenhFMlYwejZ5N0RZZXhmSzVzMHJLQ2JvdFM5?=
 =?utf-8?B?bGVjZVYvVGp4TDlnd3Y5WFZRWjZaWnl1YTg4M1JQZmkyckdnQ3drYTh2T2xZ?=
 =?utf-8?B?TE9Hd2JyNkJ5WitLQThCejF0a2FhT2paZ3FCOVVUMFhueldQZ29IRkI2ZDZL?=
 =?utf-8?B?Q1JyRmlWWkk1NEd2OEZPTnZaaFB4cDVUcHVPQkpxVHhWbnJNN0tRRkI0MUph?=
 =?utf-8?B?WGFLOUk2SXMwQVR4bytqT2paT0xjK1ZrV1dWeGluenVzWmxmYk9pc0NWbUVi?=
 =?utf-8?B?OEp5QjlQK1l3SlY5bDNwM3NVR1U1akNDN3BwREk5TzdRcjRvcWRKWEx1cWNp?=
 =?utf-8?B?ZWxXQlIzVXFSY1lEVDM3cnB1ekV0NzRGM3JadE1Eb2lhNUdENE1ZdWt1ZTRE?=
 =?utf-8?B?Tm5CeVBqMTUzQXVxUXRqaEJtZnZPL0JUbXpoMnZBY09uNE9MV1Y0TC9jMkZW?=
 =?utf-8?B?WjV4Zis0UDhlTzR6RzYvVHA5VkRTaWQ0RHZTRWpqQ2I5SGdDelhzZnJLVVF6?=
 =?utf-8?B?aXMwNE9VdmpLZmlYaXhFVHBhK1BheU5TcERJV1ZhWFd4Si9mNHFlSVB1SGFk?=
 =?utf-8?B?ZXZ2SjlkRWM1TGdzaDJLbGY5d09YU1dDREhVMFdFZk5XZkd2eWJJcDJ4Y2oy?=
 =?utf-8?B?WGR0VzJZbS9IajNJazBUNWUxdVc3dlMvdnd6akZaNW9YaEwxbjIwN0dwQ3Np?=
 =?utf-8?B?Uk9ZQWlVSkl5R2UzSkd6ZWRZcnFrR0I5QXJrVVJWWjNKTnpHaCtCMWVkTG1t?=
 =?utf-8?B?UVhHb0lLbGUxeHowQktKU3JsOE9Qck8weU5ubGtGb0lYbExBdEhEb1FEeGsz?=
 =?utf-8?B?VTFjZDJqWHg1TSs2c3Vscjl3S013Zm9OeGxJaUU5ZDdtamRPV1lvT3NjN0x5?=
 =?utf-8?B?emJHUzJlaEtiZU1sbkxkaXRwMm84RUp4T010RjMxRGRVbVl2Q3hzV0xKbVpS?=
 =?utf-8?B?aU16YzdlM3U3MTdwNC9BOFlLd0RZdHA5QlNJcU4rQWI0aVc0RFA2WDg3M0dU?=
 =?utf-8?B?YkxhYkRLU2hqT0t0UHg0bkFqSHpCNzRsZEcrM1dkcWZyaDhGVXM1dC9uVkpN?=
 =?utf-8?B?dS9iUC9WU0NoZ2lyNDB2eTc4ZkVyV0paa1RvK1kzbk9yZkp2SWVKR0ZWeXFZ?=
 =?utf-8?B?dDJDcXlJeWU1MEtGT0U4ekhUN0kybm5hZ1UrdHk1M291bTBaMlNsSTlIYzlp?=
 =?utf-8?B?aFJjdk5jcTBSZHpwZS9aajNwSE5uakM1djNTNG8vazNiYTViNEp0bU9QVERr?=
 =?utf-8?B?aERDNklpaUxsRHoxVThYaFA3d0FsZ1o4OGlYT0N4OEx0dU9iZCtSTEloTXNk?=
 =?utf-8?B?cEdHMEZXZlhySmRubjlMWkdndWJhSWNCZjE4dk5SUDIyRkdlYW4rakpEUC9T?=
 =?utf-8?B?cVNMRkFjaTB4d2UzNEJxU0Vwc1c0RjQ1dFRlK3lsMU9tY3B2eHJ3UzNRa3Rp?=
 =?utf-8?Q?lQ6aI8k+guiKD?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:32:09.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02134bca-be00-4fee-8170-08dcde380103
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8343

On 9/26/24 13:42, Vishal Chourasia wrote:
> I've noticed a kernel panic consistently occurring on the mainline v6.11
> kernel (see attached dmesg log below). 
> 
> The panic occurs almost every time I build the Linux kernel from source.
> 
> Steps to Reproduce:
> 
> make clean
> ./scripts/config -e LOCALVERSION_AUTO
> ./scripts/config --set-str LOCALVERSION -master-with-print
> make localmodconfig
> make -j8 -s vmlinux modules
> 
>>From my investigation, it seems that the function pick_eevdf() can return NULL.
> Commit f12e1488 ("sched/fair: Prepare pick_next_task() for delayed dequeue") 
> introduces an access on the return value of pick_eevdf(). If 'se' was NULL, 
> it can lead to a null pointer dereference. 
> 
> # objdump -S vmlinux | grep -C 5 c0000000001cfebc
> c0000000001cfeb0:       00 00 00 60     nop
>         struct sched_entity *se = pick_eevdf(cfs_rq);
> c0000000001cfeb4:       78 f3 c3 7f     mr      r3,r30
> c0000000001cfeb8:       01 46 ff 4b     bl      c0000000001c44b8 <pick_eevdf+0x8>
>         if (se->sched_delayed) {
> c0000000001cfebc:       51 00 23 89     lbz     r9,81(r3)  <<<<<<
>         struct sched_entity *se = pick_eevdf(cfs_rq);
> c0000000001cfec0:       78 1b 7f 7c     mr      r31,r3
>         if (se->sched_delayed) {
> c0000000001cfec4:       00 00 09 2c     cmpwi   r9,0
> c0000000001cfec8:       98 00 82 40     bne     c0000000001cff60 <pick_next_entity+0xe0>
> 
> r3 is NULL which can be verified from the register context shared in the
> dmesg logs
> 
> Here is the state of my git repository:
> # git log --oneline
> 684a64bf32b6 (HEAD -> master, origin/master, origin/HEAD) Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
> f7fccaa77271 Merge tag 'fuse-update-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
> 4165cee7ecb1 Merge tag 'exfat-for-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
> 79952bdcbcea Merge tag 'f2fs-for-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
> fa8380a06bd0 Merge tag 'bpf-next-6.12-struct-fd' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
> 68e5c7d4cefb Merge tag 'kbuild-v6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> 7f8de2bf0725 Merge tag 'linux-cpupower-6.12-rc1-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux
> cd3d64772981 Merge tag 'i3c/for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux
> 
> 
> To determine why pick_eevdf() would return NULL, I added a few printk statements
> Based on one of the printk logs in the shared dmesg log, it appears that if
> pick_eevdf() is called for a 'cfs_rq' whose 'cfs_rq->curr' is NULL and there
> are no eligible entities on that 'cfs_rq', it will return NULL. 
> 
> # git diff
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 225b31aaee55..8c5b96f1cd49 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -48,6 +48,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/task_work.h>
>  #include <linux/rbtree_augmented.h>
> +#include <linux/delay.h>
> 
>  #include <asm/switch_to.h>
> 
> @@ -907,16 +908,25 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>  static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>  {
>         struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
> +       struct rb_node *tmpnode = node;
>         struct sched_entity *se = __pick_first_entity(cfs_rq);
> +       struct sched_entity *tmpse = se;
>         struct sched_entity *curr = cfs_rq->curr;
> +       struct sched_entity *tmpcurr = curr;
>         struct sched_entity *best = NULL;
> -
> +       struct sched_entity *tmp = NULL;
>         /*
>          * We can safely skip eligibility check if there is only one entity
>          * in this cfs_rq, saving some cycles.
>          */
> -       if (cfs_rq->nr_running == 1)
> -               return curr && curr->on_rq ? curr : se;
> +       if (cfs_rq->nr_running == 1) {
> +               tmp = curr && curr->on_rq ? curr : se;
> +               if (!tmp) {
> +                       printk(KERN_INFO "pick_eevdf curr: %p, se: %p\n", curr, se);
> +                       mdelay(10);
> +               }
> +               return tmp;
> +       }
> 
>         if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>                 curr = NULL;
> @@ -966,6 +976,11 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>         if (!best || (curr && entity_before(curr, best)))
>                 best = curr;
> 
> +       if (!best) {
> +               printk(KERN_INFO "best=%p, curr=%p, se=%p, node=%p ocrr=%p, ose=%p, onode=%p\n", best, curr, se, node, tmpcurr, tmpse, tmpnode);
> +               mdelay(10);
> +       }
> +
>         return best;
>  }
> 
>>From the logs below:
> [ 1355.763494] best=0000000000000000, curr=0000000000000000, se=00000000be02c573, node=0000000000000000 ocrr=0000000000000000, ose=00000000b1d4c4d5, onode=0000000023eb8c00
> 
> I have not been able to think of a quick reproducer to trigger a panic
> https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/for this case. Hoping if someone can guide me on this.
> 
> Note: The following dmesg log also contains a warning reported too. Panic
> happens later.
> 
> ------------[ cut here ]------------
> !se->on_rq
> WARNING: CPU: 1 PID: 92333 at kernel/sched/fair.c:705 update_entity_lag+0xcc/0xf0
> Modules linked in: binfmt_misc bonding tls rfkill ibmveth pseries_rng vmx_crypto nd_pmem nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
> CPU: 1 UID: 0 PID: 92333 Comm: genksyms Tainted: G        W          6.11.0-master-with-print-10547-g684a64bf32b6-dirty #64
> Tainted: [W]=WARN
> Hardware name: IBM,9080-HEX POWER10 (architected) hv:phyp pSeries
> NIP:  c0000000001cdfcc LR: c0000000001cdfc8 CTR: 0000000000000000
> REGS: c00000005c62ee50 TRAP: 0700   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
> MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER: 00000005
> CFAR: c000000000156a10 IRQMASK: 1
> GPR00: c0000000001cdfc8 c00000005c62f0f0 c000000001b57400 000000000000000a
> GPR04: 00000000ffff7fff c00000005c62eee0 c00000005c62eed8 00000007fb050000
> GPR08: 0000000000000027 0000000000000000 0000000000000000 c000000002758de0
> GPR12: c000000002a18d88 c0000007fffef480 0000000000000000 0000000000000000
> GPR16: c000000002c56d40 0000000000000000 c00000005c62f5b4 0000000000000000
> GPR20: fffffffffffffdef 0000000000000000 0000000000000002 c000000003cd7300
> GPR24: 0000000000000000 0000000000000008 c0000007fd1d3f80 0000000000000000
> GPR28: 0000000000000001 0000000000000009 c0000007fd1d4080 c0000000656a0000
> NIP [c0000000001cdfcc] update_entity_lag+0xcc/0xf0
> LR [c0000000001cdfc8] update_entity_lag+0xc8/0xf0
> Call Trace:
> [c00000005c62f0f0] [c0000000001cdfc8] update_entity_lag+0xc8/0xf0 (unreliable)
> [c00000005c62f160] [c0000000001cea80] dequeue_entity+0xb0/0x6d0
> [c00000005c62f1f0] [c0000000001cf8b0] dequeue_entities+0x150/0x600
> [c00000005c62f2c0] [c0000000001d02a8] dequeue_task_fair+0x158/0x2e0
> [c00000005c62f300] [c0000000001b5ea4] dequeue_task+0x64/0x200
> [c00000005c62f380] [c0000000001cc950] detach_tasks+0x140/0x420
> [c00000005c62f3f0] [c0000000001d6044] sched_balance_rq+0x214/0x7c0
> [c00000005c62f550] [c0000000001d6830] sched_balance_newidle+0x240/0x630
> [c00000005c62f640] [c0000000001d6d0c] pick_next_task_fair+0x7c/0x4a0
> [c00000005c62f6d0] [c0000000001afc50] __pick_next_task+0x60/0x2d0
> [c00000005c62f730] [c0000000010e8ce8] __schedule+0x198/0x840
> [c00000005c62f810] [c0000000010e93d0] schedule+0x40/0x110
> [c00000005c62f880] [c00000000064c574] pipe_read+0x424/0x6a0
> [c00000005c62f960] [c00000000063a0fc] vfs_read+0x30c/0x3d0
> [c00000005c62fa10] [c00000000063adf4] ksys_read+0x104/0x160
> [c00000005c62fa60] [c000000000031678] system_call_exception+0x138/0x2d0
> [c00000005c62fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
> --- interrupt: 3000 at 0x7fffb8f4a0c4
> NIP:  00007fffb8f4a0c4 LR: 00007fffb8f4a0c4 CTR: 0000000000000000
> REGS: c00000005c62fe80 TRAP: 3000   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
> MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48004222  XER: 00000000
> IRQMASK: 0
> GPR00: 0000000000000003 00007fffe27ca2d0 00007fffb9067100 0000000000000000
> GPR04: 000000003076051b 0000000000002000 00007fffb9060b50 0000000000000000
> GPR08: 000000000000006f 0000000000000000 0000000000000000 0000000000000000
> GPR12: 0000000000000000 00007fffb917a560 000000000000000b 0000000000000000
> GPR16: 00007fffb9173570 0000000000002000 000000000000000c 000000000000000b
> GPR20: 00000000307604c0 0000000030762509 00000000100484e8 0000000030762515
> GPR24: 0000000010022b80 0000000000000000 0000000000000005 0000000000002000
> GPR28: 000000003076051b 0000000000002000 00007fffb905e508 00007fffb9060b50
> NIP [00007fffb8f4a0c4] 0x7fffb8f4a0c4
> LR [00007fffb8f4a0c4] 0x7fffb8f4a0c4
> --- interrupt: 3000
> Code: 4e800020 3d220104 89297c19 2c090000 4082ff8c 3c62ff99 39200001 3d420104 38632d90 992a7c19 4bf88965 60000000 <0fe00000> 4bffff68 60000000 60000000
> ---[ end trace 0000000000000000 ]---
> best=0000000000000000, curr=0000000000000000, se=00000000be02c573, node=0000000000000000 ocrr=0000000000000000, ose=00000000b1d4c4d5, onode=0000000023eb8c00
> Kernel attempted to read user page (51) - exploit attempt? (uid: 0)
> BUG: Kernel NULL pointer dereference on read at 0x00000051
> Faulting instruction address: 0xc0000000001cfebc
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> Modules linked in: binfmt_misc bonding tls rfkill ibmveth pseries_rng vmx_crypto nd_pmem nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.11.0-master-with-print-10547-g684a64bf32b6-dirty #64
> Tainted: [W]=WARN
> Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
> NIP:  c0000000001cfebc LR: c0000000001cfebc CTR: 0000000000000000
> REGS: c000000002c13950 TRAP: 0300   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
> MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44022282  XER: 0000000d
> CFAR: c0000000001c4758 DAR: 0000000000000051 DSISR: 40000000 IRQMASK: 1
> GPR00: c0000000001cfebc c000000002c13bf0 c000000001b57400 0000000000000000
> GPR04: c0000007fd147108 c0000007fd1cd600 c000000002c13968 00000007fafb0000
> GPR08: 0000000000000027 00000000004e2002 0000896cdac1f9a0 0000000000002000
> GPR12: c000000002a18d88 c000000002f10000 0000000000000000 00000007fffe0000
> GPR16: 00000007fffd0000 0000000000000000 00000007fffe0114 0000000000000000
> GPR20: 0000000000000000 0000000000000000 c0000000010e95ec c000000002bd6380
> GPR24: c000000002bd6da8 c000000002c524e8 0000000000000000 c000000002bd6380
> GPR28: c000000002bd6380 c0000007fd1d3f80 c0000007fd1d4080 c0000007fd1d3f80
> NIP [c0000000001cfebc] pick_next_entity+0x3c/0x180
> LR [c0000000001cfebc] pick_next_entity+0x3c/0x180
> Call Trace:
> [c000000002c13bf0] [c0000000001cfebc] pick_next_entity+0x3c/0x180 (unreliable)
> [c000000002c13c70] [c0000000001d0064] pick_task_fair+0x64/0x130
> [c000000002c13cb0] [c0000000001d6cd8] pick_next_task_fair+0x48/0x4a0
> [c000000002c13d40] [c0000000001afc50] __pick_next_task+0x60/0x2d0
> [c000000002c13da0] [c0000000010e8ce8] __schedule+0x198/0x840
> [c000000002c13e80] [c0000000010e95ec] schedule_idle+0x3c/0x70
> [c000000002c13eb0] [c0000000001eb1d0] do_idle+0x160/0x1b0
> [c000000002c13f00] [c0000000001eb4d0] cpu_startup_entry+0x50/0x60
> [c000000002c13f30] [c0000000000110e8] rest_init+0xf0/0xf4
> [c000000002c13f60] [c0000000020053a4] do_initcalls+0x0/0x190
> [c000000002c13fe0] [c00000000000e788] start_here_common+0x1c/0x20
> Code: 60000000 7c0802a6 fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 7c9e2378 f8010010 f821ff81 60000000 7fc3f378 4bff4601 <89230051> 7c7f1b78 2c090000 40820098
> ---[ end trace 0000000000000000 ]---
> pstore: backend (nvram) writing error (-1)
> 
> Kernel panic - not syncing: Fatal exception
> Rebooting in 10 seconds..
> 
> 

I have a feeling this might be what is described in this thread: https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/

Likely a result of an overflow for vruntime. And we come out of pick_eevdf without a valid entity.

