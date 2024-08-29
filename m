Return-Path: <linux-kernel+bounces-306024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D74963828
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E91F285586
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514D2A8C1;
	Thu, 29 Aug 2024 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="mHzZco8Q"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020081.outbound.protection.outlook.com [52.101.61.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1143D3B3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898318; cv=fail; b=HhKzh+2bllw1EO+7AMstyCI1/kbKkGMXFqpFKbHXkksuT4YusmHhHQEjzVgKq7dCRz4iWPAnypU7m7kWlaayleBi9dj+0odkgmMTHxO7ABgH+2ddT7Ebu37BH2rGCIGOObTv+ULqSRla4lOMdbHAYz4TsM/4D6kqj7pzZaOiUfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898318; c=relaxed/simple;
	bh=TSC7Rfqd43rGMhr3QIRZKk1dIFzI9HQ0tEopt05YihI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1aB6rcH2PmQDzX+9Nz5zKwhuv+PNqn752w31NR+d88s6/1KTZdVZSA1DBligSz+B+HeXoQIgKAcxBydgoWMk5TJR+gF6B+jgw04NYbrL8u6JhZdMfW1jz39MSui2MThbbkPzQeS9fccaCje6eRwqOrE0DQ5FO494DMeVR2J9Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=mHzZco8Q reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.61.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frog7wGdPjRLKsGFfmAEVdGIJQc/L0yIDhuEYAIVnNLr0ET/GKyxx3EvCNVpxTTIape3V4V6mcaswPZMokDPy7bxCSIZn5mxqDKj+xkhs6588tV7GBH4FlMEjsg3GA1zfoYQ0ny6Wzcn2vYmR846wo8I8zHv0tI6uOZ2hpzwBpVz/FAmex07HulsU369hz49XG33jDq6S0boj9tlyR/hKM8YoU9jpuL9AYw4VdiKSRugR+PKovRtSqKRkijjRN8qpWgtioEYD8QXeMwmvybdBeK/up2pRp8ALm0BfgcGeNANDl1jhNexvPZO+ol2CnitwjE7aqopvNtbOT2I3R5IrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSC7Rfqd43rGMhr3QIRZKk1dIFzI9HQ0tEopt05YihI=;
 b=zCo7S7SqHYPPM0CZxk/TIl8n5nRJ049dATEly8DisqwyW3yI+V/kAPt80EWtTN6bvFFyxm7EmMrqxndya1xqAKm8VOG+PD/XDhSjczcmvQxYLRE/LoFueob6MjOSfACUGrJCVoC2komefMNutVvR9zDcLnTv085jB9mzqBd8gm2jswF0eqpw3DVxnIlYz1B8QmEN4xjct2wCWFe0cYxOPYWPrvEnjs/p7zPcW2W25lqHWKNoxYuoWngQsP8GzF4OFIPEqF0VeY/x+QQ9wIg47o/xFRxH6hHGiMs4VIIh0ttgeVehhxHsRu1WVcxdaCOSv+PdHhZ5TuPm2WUYXsttcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSC7Rfqd43rGMhr3QIRZKk1dIFzI9HQ0tEopt05YihI=;
 b=mHzZco8QE0oDfJrQk2ShXLGKjgReP+DmnN2/jYcaLhbLu19tzWn25MHbfsOmBQocLYsALl3HuLkXpiqtY9IxP2TkPPRgkhBF1v0tsqAxCKvPe73onq4OCelSOfaOFkwUmEN7vL3FhK9YpZ20ijx77WggLAUuW0jf3b4A0e0pjxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CH3PR01MB8444.prod.exchangelabs.com (2603:10b6:610:1a6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Thu, 29 Aug 2024 02:25:05 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%5]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 02:25:04 +0000
Message-ID: <c070a780-c287-4349-8391-d8752b1a0815@amperemail.onmicrosoft.com>
Date: Thu, 29 Aug 2024 10:24:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/deadline: fix the hang in dl_task_of
To: Juri Lelli <juri.lelli@redhat.com>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, patches@amperecomputing.com, peterz@infradead.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 vineeth@bitbyteword.org, bristot@kernel.org, linux-kernel@vger.kernel.org
References: <20240828091141.12043-1-shijie@os.amperecomputing.com>
 <Zs8ad6eQiKpIaKIo@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <Zs8ad6eQiKpIaKIo@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CH3PR01MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 04084e28-fc5f-459f-6c61-08dcc7d1cae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlZEWFk4NGhGOWw4Wm9VN1lwMEFPcWl5K2lNSXJLS2R5T3NsNkVYd1VHRkdy?=
 =?utf-8?B?bjZEZmFiMmFnbFNHaGNTZ2dQOUtwZG9iWityd2paSXRTK2VTZmhRTU1ldnI2?=
 =?utf-8?B?SGZNV0xGemRuWFZyQ3JOUDhwcG9ra1dhWS9CeGN3N092UjdvSzRqSTFQVW4r?=
 =?utf-8?B?U2NBckZvalFpVXJYMVc0S0hkTk16bU1KNE1WSG9mcE9YazJXU3daREtaeGRE?=
 =?utf-8?B?RkxxQkNxTm5hUENBZ3kyb096ckhJZndqY2s2bzIyZDkySWVoVE5NM3Yxb2s0?=
 =?utf-8?B?c0sxaHRlTnNDK0FsVFBSZVpETTg3K0NqY2RTUGkvN2NId2c3eDZTQlI3OXdm?=
 =?utf-8?B?YmlaMnBpT3hBdnMzWmhUdmhxTVFxVUxDSkhlZmRqTWRhcElhVUxCQUgrWktn?=
 =?utf-8?B?RFVGZzVEN2VpYzBhMTdtdWZPYkcwR2ZENkQrc3d5MUZ5T0U5WGRPNVdhMkNV?=
 =?utf-8?B?MFhyeVVIK09xejduSDFFcDd2MkN5dzJJTmlLNktVQm9rZGFBbGNNalRtcHhh?=
 =?utf-8?B?OGNBTUxMRjNvdEw1c2VRSmJnQ1c4QmJnVnZMSVBvYXI0UmlmUEZ6N2g2R3kz?=
 =?utf-8?B?NkwvWFRIUnpCemxBdlluQWhQUG5FSTQ1S3BrSkZYQWl1N3I5MlFqYTVPOW5m?=
 =?utf-8?B?Yk8yNEFYbEdnUHJIWUI5R0NtQWZwYmljSWdpclNSb21kRHJqL0FBdGpuRGpp?=
 =?utf-8?B?c2YyZnZOWm5nRlJLbnVKUmJQclBhNzNsVXNMbFlOY3BVcExjSlFCZEpXaVdi?=
 =?utf-8?B?RENwZnY0UkxjWjZnNTlEMkM1TktCUDZXcXpSQUgrM0g3eU1hWU40NXpKdVQ0?=
 =?utf-8?B?SXYyaEN5Z1RLSW5JQk5pK0pZOVQ5eHBKT3NnZUJnWFhpREY2akFnaENtTlp6?=
 =?utf-8?B?ZzMxVzQxNmwwakwvbXZZRG9hdlhiWC9OU1hYMFBmWnhqUjJtN0YrOVJRR25u?=
 =?utf-8?B?WGN0ZnZ0WkhSRlZBcGprdTlXZ2RjcC9FejBxMWFxbHFEZ3VwQ2JzVDJvTC9G?=
 =?utf-8?B?ZkYrY3lEelNjNGhMU0Z1RHZtK2JCdDFKTytwQklMa0M2SVNDY2NsSU9JN2J3?=
 =?utf-8?B?UGh3T1AwYVVnd0Q1b0N4STh5SDllSlc5VFlIVG1GNk9OWDdUUXVhSjZmdzJj?=
 =?utf-8?B?d281VU44MHJCTlJ2dTlBcTR3azBBVWtUdHVFdE12cjRPUFJ4MHBhYVUrYWZR?=
 =?utf-8?B?Vi93M3dOeGltTFBveUVjcUZabENXSHY4Y0Y3YjhBb1JQU1pPVXdiNk53Z1Vw?=
 =?utf-8?B?S1RObk5CYjNidS8vTE1wSlZmK2V2d00yOW4vWTUrU1lZYTR1RWplbDNNM1Mr?=
 =?utf-8?B?Uy90aGhhcUU4TXkwOCt0NHFlbVRyQkNkenFXOFpGTXdRcGdmb2RzMVF3Z3R5?=
 =?utf-8?B?OXQyTXdSQnZXU1hGaDRRTnJVZVR4dDRONENNbUtpRXM5cmduNURiSmJTdDlX?=
 =?utf-8?B?clY0VU5HTmZaa0ljY2F6T0cyZjlYYVlxdFpyTld2eW5sSzlneWtxUlE4WW9W?=
 =?utf-8?B?WkNVemp3QmpVMThxMzI3TXhPMGhHQkQrRFpKWmwxcXlYMXQvaXJyNDBqaUJx?=
 =?utf-8?B?Tjdlb1BRWkwrbU1DT3hNV3NvV0J5YmdiZVIrQjFBQmVPNEJ5ZzU2Y3B0YzBi?=
 =?utf-8?B?Z3BoWUs0YkwxaFFuMm13OS9hR2tmVlRzK2d3NURHdkptaHR3eURNRDRyUGlk?=
 =?utf-8?B?Z0xqMVVXQ1JPWUFtcFR4M2hjWWZucWRhZGYxVW9Ga3RvbnprMVBlQnlzMWY4?=
 =?utf-8?B?UHVTakF4WEltQ3dNNHFTUXZ5UERlT0tiRHBJeTVrQk9tZHM0N2gvYTZnaUJS?=
 =?utf-8?B?S01oamFLcERsWnRZY0Nhdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0MzbG5PcXNwbCtqU041d0hVVFM4SWdJZGNkd0krTmJmR05Zc0V1a3RNWjk4?=
 =?utf-8?B?MkcveTlIQUdobWJVWjdLeHZYVXJDUEQwRlRIQ1g1MEF3bmZaVzNrV1NBdjNX?=
 =?utf-8?B?N3dYeDY4Ny9IeldiMHJ2ZlU0UXVHU05ucUpFU0IzL0d4NHlPbGkxa3pnbmxB?=
 =?utf-8?B?dldYQTlpUHhRSlAxSXdydlY5NVJSTlZMc2NzM3FOZG9OZ2FBK2VJSGFhMVd3?=
 =?utf-8?B?a0k2Wnc2bnFISU9BL2pCRGEvaTlCTWd1SjJxYktkUnp4SjRicUR4SkVmdjZJ?=
 =?utf-8?B?QXdFRkV3NGRMZmtES0FSaVBSb0xQMkRZZEw5WlNnZXVmdDJ5aXd4c0JvMHRa?=
 =?utf-8?B?MmZ0RXI3aWtzM1laZnJMcXhKeXhwNWxaL0xlWldTRWdRZDdLdTgvK3drc0JC?=
 =?utf-8?B?SE9ZRzJyYkF5TWdCNmo3ZzNTSmVOejFzNXozaUtGaXRKU25hY2RMK2pyeDNp?=
 =?utf-8?B?eXQ1N09xNWQ1d0h6dWZEZWNwRjkwSDY3eU5aSXVlWnVsWmRxNk1aSlU1dm9x?=
 =?utf-8?B?U0VVd2wyRGwzRDFxRlU4Zm5ZLzc5alhsRnk5V3dabURIZWZBaWlpTkM3NkpY?=
 =?utf-8?B?ODNoN21pek16NjZzbXlNY2M3N0hhbytpM2dSNU5idmt4bnZDT3dvR21MYVYx?=
 =?utf-8?B?M3FSUkNnUkZsSEhKdHhLMDBCZzhNeStNNzU4ME0yTEdrajV0dkw1eGtjNU1M?=
 =?utf-8?B?b0FpNG9TQWVkeG1VUE53MnVrTytIQjVUQnI3UllNN1ZYSW5EaFVyWEoza2VL?=
 =?utf-8?B?M1hrazV0K0Rqejc0Wk5NUGQvWGg0VzJoVnVJSGxzVDRCV2VUaGJ3eU5xSUta?=
 =?utf-8?B?dTZ4WWFETld1QWlTTjJqU2UrR2tFb0JLM0xIMTZKR29NdVV1YW90WmxEZGVD?=
 =?utf-8?B?QVJXZnQ5NVZkbzJIUklJN3NGbVNXbVhFYU9XalV0STNkL2hOTm9lMmdxVkxo?=
 =?utf-8?B?bnlQaXgyK0lRTUhTdE1hWXVpUEk4RnhETFhTYkpQN0ZubElqOHJyb0dtSm9W?=
 =?utf-8?B?cHA2ckc2WjB2SStOTGNlUDVqTmpSNlcwMVliNTQwK1prdFR3UURrL1I3WENY?=
 =?utf-8?B?VkdPOFUxVnRwZGRFVk9LQVhTaEUrT0Rsc1R1M3F0UnRDTVFJUVpSV1Q4SFA5?=
 =?utf-8?B?dHdpVWVCejNnYkF1NGFyYXVGeXRuUHpkMXVBZE1iQlVzYlRhdHNwTUJFT29E?=
 =?utf-8?B?QVVEVEFKSUl5Q0FLUndzazFob2NRZlVGTTlJbHB1bnB4UHRXZXB2bVcrZDhU?=
 =?utf-8?B?Q1pGZVFVWGNlMVVndjRQOW12SVVjWGx4Z2UvZU1TMVd3Tm9pU00vUmpQeW9Z?=
 =?utf-8?B?clhpVzQrM296dnlHT2NDM1lMOXp1LzE4OVZZNFJ4VXl1dDZhVm1oSVIxQ0xM?=
 =?utf-8?B?RTJQdlBiWnRBbno5encyeWVtT3dKZVRwV0ZjbkJJSlpNck9aWU9wUDQxeWxJ?=
 =?utf-8?B?N0tCdmwvVk93NnU3S2lZR0Z3U0NpaWMzaEUxRGdWRHBUY2JyV2FYMktibzdV?=
 =?utf-8?B?dTA2RHRNb2t4WG5HUjhrQzFYY0UvSEg2bWJBY2p6c3V2RThrVWFqVmQwakUv?=
 =?utf-8?B?VkN0dUFNcTVwQmtUUno1dzB4VlBCM3BaaXNveHlxajNQMmRrZENkeTZob3po?=
 =?utf-8?B?ZzF5TklPOHpZT3JCNzlKYkNZeW5Fc2pVRDJSMldEUnFYaERTUWo1cVZCQzBT?=
 =?utf-8?B?MEJLcWljWkQ4SVFVZk1aMEFNNTd4OGlxQlJjU1hkRXFQWXRrYmdKeHB5UWcw?=
 =?utf-8?B?QXh6YkJtbmJSUVF4ZzM5aVgvc1crZFF0VVNXWWg5VEtRS1FUQ3dERkpwU2s1?=
 =?utf-8?B?THBpbWRURk0xMGUxcy9nVFdManA2bE1FT3dqZFV5K3pkakdXeWxBUmJNM2w2?=
 =?utf-8?B?dWxrUVplWkkzMEFTcEgwL3JjUjlPNlRGV1hGcWxmdFlXV3d5bzJNS3dPK2g5?=
 =?utf-8?B?Wm50dVBlSEpmb1l6S0l0OFRmcGVPVXBzOTcyUUJWZ0RBSjhKOXAza1cxUGJD?=
 =?utf-8?B?aDRKVTVCOVVEdTh6SGswWmJGQ1YvVFRWMGhOaHQycWhjOU1KcEF5cFlDa0tW?=
 =?utf-8?B?TllMS0FnbjNOSE4xWGxwQXkwUWZpMWdkcW5aeFRSY0poSHI0MmdmTFdmYmda?=
 =?utf-8?B?aEFOM1IxY1FveGh6MUJITElXa0dtUnZPR3JGdTkxdEEvNFJ3eXV5U3JxNndE?=
 =?utf-8?Q?xtAY+8JxBH4p7ZPZJ1+yI7I=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04084e28-fc5f-459f-6c61-08dcc7d1cae4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 02:25:04.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buiVdKeh96zntwpb8yZOEudvTAg4O8M3amcleXR0fRUq82V5XO062ParSRexA4pZKcuOmrrzlsnS6JwxkmZGSgrRW+q74CgnnvCwFJmsWEX2+x729Dqkc5bNGI2BmHBt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8444


On 2024/8/28 20:39, Juri Lelli wrote:
> OK, but I think we want to avoid all potentially problematic paths
> eventually calling __schedstat_from_dl_se() for dl_server dl_se(s)?
>
> Maybe we should return early from within update_stats_*_dl() functions,
> I'm thinking.

Okay, I will do it in v3.


Thanks

Huang Shijie


