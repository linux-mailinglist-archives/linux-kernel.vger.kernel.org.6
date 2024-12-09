Return-Path: <linux-kernel+bounces-438439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A09EA157
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DEB1649DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9109119D082;
	Mon,  9 Dec 2024 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PHVUQI55"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A246B8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780548; cv=fail; b=ipCrOOlhIJE753RJSn/iENT+M2Vpyhr3y7Jj4ORTckcxQgL1DSo/y2EajpdUemXCCS2H+JYbOP68m6FcY8csyutfCX+xN3s+1AszqUZVMWNUui1IxMkl6e3v8w3n1j1fS2GPRlJGZTIWTp8om/UTxp4K9lG90GJm/ogYBT0yrHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780548; c=relaxed/simple;
	bh=5ezNXyixhJ13qqOSUNXUolMmRvSgvZ3ievIjiehGDOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbBegHRsxOo5NVxJaXDbyu+qM3wzRKS/6u2UJJZim0COJyzbyCT8AgepoCXZmIUKjs+GKv9iEHgLGdUwTdY5amaJIzIvpgwV9c5VdF7w0hiXgTkaW9xP95IhJrhk3W5XIpAL+gdbh9ebmUUP5nNB5XSrhQD8fdvbINRNETfpocE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PHVUQI55; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADtwjZLs3DoUNUuF+Oijc66TvFz1W3pmKiQWEV++/zaqbpF0Y9ZfAqqxjiucP1KYriujflvGD8rIZ3ZMdxoPETJ6W1dFgaXV8eHsCO83BaPZvASgg96MW6L7/A7oCuNMFUnlCRVTxNRQMOnHzoBt9WZJKJwbepbN7//7NJP6WIEaCrFWaoRHtr/W0O3/mNB9pov6dVGrrPqTAyc4ChGdAgnyWEN+GW5Mgv8yRgFb6CSYaD6vlnHwcKMgFhtiulAq7cMAA9Zc42E5UqijWFeR0tG+0nwr2uFvpbpwEB77aJHfKJB9HeXdEFq3iyYga15ijtxrZXRUbj4qb8BhPMkN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjRkupsTDMLhwCjuI8R16WiDgrVIM+xfy/2moaxXIaA=;
 b=qy1nrBYPnXOQHM2jIzNTy8T2iJ1KX1V7ykqtyU9VQB2GfefBWZhqTr2xKGoBVDbLNfzGX/5CfDMLHJI2AGD7kcP8eMA9WwSHaeUVqdxAJgA+FSMlP8df1mITqLuIFxnjdA4V3/BvcMMJqlKiA1YiV5iR+M4j6/+/aLufUcmW/hh+nWDB/dm3LMlB3kaiPQiWaoBubfu+pXUQc4UBKIo6jMZLWk6BGyohGtYuoAOcHGG/pRSbrL4vN+wxEbSpvQVR7KumCj3Yf6qCkEVmVKL+yvTzrkl7ktucF8nu8K3GEExJpJe1flaRwdF83h2qkNgJTxBb9L0e0a75jRNJR9ufAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjRkupsTDMLhwCjuI8R16WiDgrVIM+xfy/2moaxXIaA=;
 b=PHVUQI55zg8LQpSYbXubPtaPipfipkoBjDYLG1uXtp5sb/XstvL+wljkozREZCUNs1n0NL6PQe1EFlaaZJNnWZn/HggBeGiCyjJDjRyvRnSfb/2HQFiutMy1VsNxpzyPlEqjootqPi0RRqCFfwVQTnoLygql42Laveo5uK3uAM3daaXp9PXxz587PyNP8jokIFIBUG1U8PK9scDmC+EqUiaCQTYgtP7rqz/jzKesYhlVVFVXtC6k3M7aXNkaYC21A5bPsH3FMApPbACDzXmTvbTIwmixnac1ARldek1NNt6EmS8IYa0WanM9093B8zT+wDOKpEYcG+07oPKp6J4FCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Mon, 9 Dec 2024 21:42:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 21:42:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
Date: Mon, 09 Dec 2024 16:42:21 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <0162E372-2B68-494D-8DFA-F3AF0EC6F5E8@nvidia.com>
In-Reply-To: <db1815b1-fd24-4b8f-ab64-32b0c4df6cd6@redhat.com>
References: <20241206095951.98007-1-david@redhat.com>
 <20241206095951.98007-2-david@redhat.com>
 <e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz>
 <37B7A92E-B58F-442D-8501-B07A507F0451@nvidia.com>
 <db1815b1-fd24-4b8f-ab64-32b0c4df6cd6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:408:ea::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 75613d71-1451-4a43-152b-08dd189a5da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDBaWFdCeklhdnk1WkVJQkxSSXZZdWVOWkhwalBtUUQyU3BIY0JJdHBtYkl4?=
 =?utf-8?B?ejYzeUhBcHdoVzBGMTJ5R0hITnkvQUtLVWtyQzVBeEM5K29SNEJ3YWx1TnNr?=
 =?utf-8?B?SGZlMUpKMmdCcndEczlHQnRBSUlwWkNJWHU1RUtaQ0lxb0QyZ0FpditYWENt?=
 =?utf-8?B?NXpGUHhGeXNTT3l5dzU0Tll4czFpUWhlV1FDK3JhcGY1bFVORUtDWW9VZ0l5?=
 =?utf-8?B?a1BJUCtrenFTa3NyQXlRdnRSdjBHN0ZGY0RmUVVtazdSZ1laYVRoYjVtaUxv?=
 =?utf-8?B?OXd6bTE5andyUDJuWHBKVjNUK3A5eTNJZ2hJWHEwcjBwVjRvcDVLMWFXaHlJ?=
 =?utf-8?B?b2tHSEdPbWN5OVlHVEtlZDVPVzR2ZmVCOE5xOWRlU0QrZHRBOVIyR3QyNnhu?=
 =?utf-8?B?ZVFXWW02WHlCWEhDZEQzNTIrL2NCc1c5NHBrRU44YXNaVHc2THNlL25tSFp4?=
 =?utf-8?B?aHRpbHdTZFFZU2ZjV3cya0tMQks4VWZUZWtzcUFleU5USmhBMTdZY0I3SHVB?=
 =?utf-8?B?Wm9LYUJRczExZjlaLzQvSHZQcW0vVlljNjUxOVFiVVFReFEyZ0xMTWM4RGVu?=
 =?utf-8?B?YktTZUlPY29FTkllTHZpT00wVHEwWkJja0pnb25nVnBYRVh6MDRtblFSMnV5?=
 =?utf-8?B?MXV4UFJRUEhKT2xCQUlsSktnOFpGSFdsdkorbkt3Y2tXRVdPYVE5WC92bWFU?=
 =?utf-8?B?VVV2b2hKM0xZbkZoT0dzcHBPL0dzMUR5MnFvYXdIZnFuTnBoLzZqVHliZXo0?=
 =?utf-8?B?cGQ5dit2dlFsYWpONThzWWFyRFdLdXYzcmx2YW9NdHBTdnNQbEdrOC83VU8v?=
 =?utf-8?B?a3dSVUU2Ri9zRnp3enFjMnZZelcxbTA1V3VhSVd6bm5EWUlFQnY2T1EwZXRR?=
 =?utf-8?B?clYwelpZZVZXWmNjMDFHSDFzVzFick55dnJFc2lsdldrK2cwd2lNSjl5ZzRj?=
 =?utf-8?B?dkN2WFdhWnRPS1A2Zk9UNzY0WXpaT2U0TE9ja0hKa3V6cXhhU3J0a1hCc1kx?=
 =?utf-8?B?eDcyaWVVS1dqOUpicWE2TjU3dWN1MUNTZWVqaHBBeGRxZFJjaFpvZjNybTNh?=
 =?utf-8?B?UE9qdzY5SG45aDVMSVpwcVNIbWRyZDh3ZG1pRHJ3WnJHVWRjd0I4akdsby9H?=
 =?utf-8?B?eUJ4WUlib00rT055Q1dJam5RZlRoQnNqMCtoVE9iSjMyam9XcTdaZW5XeDI1?=
 =?utf-8?B?U2hDbFB2enpuU2dZd3NwK3cwdkZTbTBwaXNoY243VUs4MW03UVFSdmswMjNu?=
 =?utf-8?B?Y25hekxMRTdCMnZjbDBBRElkT0tNUWsyYkpodnR2Qi9XTnhpWE45dDFCeEdl?=
 =?utf-8?B?MC81aVo4L3BTTVd3dk5vY21nRjhWcWNrRTFKSW5DYllqcVltNk5RcTIxalor?=
 =?utf-8?B?bjJ3UGtnVVYxLzI1bnBtWDkzZGxkamJCcUpGOU5CdkI2NGRydjV5N2N0UTdF?=
 =?utf-8?B?QVl4WFBCMHZLK0F4bDdlY3hIbjN4WnIwckpqNUFEUzhCVlBOd3NEclpQdXo5?=
 =?utf-8?B?Z1RvOFZkWkl3R1VoSDhWVEZuNHBzL0dxUUg0TTBpSTY4akNIYjg0V0h2M0NE?=
 =?utf-8?B?Vlk2OTl2ajdSTnlDYzJTcUd3Q28zcU10ejFoWnZ1eS9LbDRjdjJOa243UWIy?=
 =?utf-8?B?SHhnSi9YNWJaQ1hRbTh0T0hQUXJMR1dCUzVRT2ZNSFJjUDExMWJjTVh6bE1h?=
 =?utf-8?B?NTZ4UDQrdVhOcFBsVTlhaVRtVzUvbkZzTXBUTUlicFg1UE9OalliVTE2WXJy?=
 =?utf-8?B?QTVmZFJnbi9ZNWNXdnhFWHJkTHdPOE9XeUkwd1IvdWwyYzkyZXRTTjRmWkJm?=
 =?utf-8?B?LytnVGF1alMyalVvaU1iZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHg0QjRBSnZQS28xWTQrYzd2NXBkQVlia3FZOHpJQk1ON0Zkb2lkZ0JQUHlQ?=
 =?utf-8?B?ZVRFekVoWkZYQzFwQmhUbmFVYXRFTCtzTUlVbkFyZ0oyUlVPK2c0REFhMmZi?=
 =?utf-8?B?NWJ2M0U2RFFGU3ZrMkFyd3BEZ3BCNUc4bTB6TXBTc2hCcjhJVS8zMWhaYUl4?=
 =?utf-8?B?ZU01UFhrZzBNRmZ4dFlnMjZTL2JpQVV6YmJ5ZnVQVCttRTdoL0JJZVkzTzFH?=
 =?utf-8?B?aUJhTWd6eGMzMHFmRW9sbTNVYWlSaXBJbktMRUFCUmZRV0dtOUJiYUx4N1NP?=
 =?utf-8?B?NjZQREJrb1BIQm83WVFZZWloem5mTGVjVXo0SlEzRXdYL2JOaW1hSUlnUmV2?=
 =?utf-8?B?RWRHZE5zdmhuUm56VG9mOVgyTUJYNnlVZWRKUU9NcEZ4Uy82MFRVVVh6dm56?=
 =?utf-8?B?QThNc3haOTg4ckVOVGlPK1NldkFrcksxd2xhbG5hVlhJTTNHMGFBM2ZFMGVU?=
 =?utf-8?B?QzJhRndNZWFyK010MmZtNFh3dU1qSkxHS05BMzVwODlhUmZqYjZpMzlsNThG?=
 =?utf-8?B?VHhGZW5CUUN5ekdUMGdDeVZpZnllRVdIS3pWc0FBSmpjWWJsWVVDc2IwZ2FM?=
 =?utf-8?B?RnpPVXRnbDV3MlF1VmtUQnVGb0JzME10aWVLckFONi9uNkFMbHBHTlMxWUpI?=
 =?utf-8?B?WHpSYVNpREdFcXFvSGplOWV4a2x3NXlvRFhoTCsxWHFtRGwydnl3UzJIbkJK?=
 =?utf-8?B?azIvTSs4dm9FNEtmTE5rKzdlNzFsU0xnNTNlM2tkMkowb0FqUTJ5Vk5vUWhO?=
 =?utf-8?B?RVUwK0ZCRWtaM3FzQWdldHBFSFRXZDJyTHQ5ajkzK1o5VUNNUWVCdlVZSDRH?=
 =?utf-8?B?U0VCMjR1QXc5dXpQWlBudnFKQm1nMzlBanVrdjI4bWFDTUxia2M3VHNQME1z?=
 =?utf-8?B?aUlFVVpqWUJiMnN6QlY5aUo1di9QUDh0MStrREpYOVBwOFIyMm0wV0kvVmQ1?=
 =?utf-8?B?aU9IM2xwZHpHVmRrMEJzeERwZ0lER1hsV2Q3NnMvczh0clpQTzYwQXBoS0lV?=
 =?utf-8?B?NkFRZCtrUUFzeEpjWDA2VlhvYmZld3J0Z2VGZWJqaVNraCtwVnI0T0dGZm9i?=
 =?utf-8?B?YU42S2IwckJVMlZ4LzI4MzZvaHVXN1R2bjhzK1g5b0JldHVoRm81SUZSZ1VC?=
 =?utf-8?B?Z2tqeHRsUTl1RzladUZCT2lFYmV2ekd5K1duVUM3dnRSYjZPakVKYm9IcHVo?=
 =?utf-8?B?c3lhbHBxUExiMXBpTGsvU21LQjRCUXF2VEdoNFUvTFpQK1NIZTg4bHVCU05K?=
 =?utf-8?B?ZksxTkJibjQyU3UxbDk0Mm1aQm9lcEF5dFNhUk92cXJDYXhucCsxMkNTbnFF?=
 =?utf-8?B?SkhmeHZCSXoyUWZ6N1owdFZoWDVtaWZCWXUrY0Nrd0NaQkZOSnVwb2tHK0M4?=
 =?utf-8?B?UG0zNlVLRUUvYnBkM1RVWTBGbGkyQUNHWFpKN09wd3pSZDlGcVV5Wnd0QmVy?=
 =?utf-8?B?VlN5R2dRRlNWU3ZUN0N5L2hyR1N6Ylloek9QUEFKL3hmZ29udFBDOHdVK3F2?=
 =?utf-8?B?cTJWRzJWclJiR0xQTGkwK2NTbmhVQVRnelIwTTRzaEliNjVDZW1DMjBSS0pM?=
 =?utf-8?B?V0d6b2tremtSMlNxNWpFMFlBenFLUDQ2a2dhUDdLeFZxWVB0WTZqbzkzQzk5?=
 =?utf-8?B?WTBYNHJyMDREZEZuaWdwTVhPY2lRcSt3UVo4Y0kwQ2R3OTNQcWpQaWx4U0VZ?=
 =?utf-8?B?ZDBJMmN1RFFnYjRCR284Nmlra3E3cUdoSUVxOElTcTVEajJ3WmlPbmtCelZP?=
 =?utf-8?B?WVhpTW5SclFrUDk2dHB6TlZDN0poTE4wOGNHQm9Uc3VtVlRGRHBzQmkvUEpu?=
 =?utf-8?B?OVg0bzFTVU5hZG83WlZIc1ZwWEJoSldSR1M1aXh1VGszZEExY2JGV3h2bnJw?=
 =?utf-8?B?VitmRjA5dWdCbVdjOHdBSXhQcTlyQVpTL2xVREs0NzdOUXFJOGhyaXdCdmRn?=
 =?utf-8?B?Q3c1aDJCYXZMUVdMTW9HTDhyUElnd280Y3ErM1prQk0xZnloOEdoOThMcVVO?=
 =?utf-8?B?aHBPVVd1OUZoNzBjL1Q3RXUvSU1OVFo2TWxZT01KVDFDS21pOWFzRExLR0l1?=
 =?utf-8?B?RFNUbWZ2dmRYOFA4M3Z5bnNNRWFOejN4aG9yTUxBRUpqRXdVOTh4b29aQWsz?=
 =?utf-8?Q?Eds8HPlEazZR3uXdauoKk3vgl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75613d71-1451-4a43-152b-08dd189a5da5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:42:23.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUYaLv3wmao43b+xbpUdh9LSvK/lre2B9J5a0vCpwJqLwgHUwnXSXO3SAnqvg3Sz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On 9 Dec 2024, at 16:35, David Hildenbrand wrote:

> On 09.12.24 20:23, Zi Yan wrote:
>> On 9 Dec 2024, at 14:01, Vlastimil Babka wrote:
>>
>>> On 12/6/24 10:59, David Hildenbrand wrote:
>>>> Let's special-case for the common scenarios that:
>>>>
>>>> (a) We are freeing pages <=3D pageblock_order
>>>> (b) We are freeing a page <=3D MAX_PAGE_ORDER and all pageblocks match
>>>>      (especially, no mixture of isolated and non-isolated pageblocks)
>>>
>>> Well in many of those cases we could also just adjust the pageblocks...=
 But
>>> perhaps they indeed shouldn't differ in the first place, unless there's=
 an
>>> isolation attempt.
>>>
>>>> When we encounter a > MAX_PAGE_ORDER page, it can only come from
>>>> alloc_contig_range(), and we can process MAX_PAGE_ORDER chunks.
>>>>
>>>> When we encounter a >pageblock_order <=3D MAX_PAGE_ORDER page,
>>>> check whether all pageblocks match, and if so (common case), don't
>>>> split them up just for the buddy to merge them back.
>>>>
>>>> This makes sure that when we free MAX_PAGE_ORDER chunks to the buddy,
>>>> for example during system startups, memory onlining, or when isolating
>>>> consecutive pageblocks via alloc_contig_range()/memory offlining, that
>>>> we don't unnecessarily split up what we'll immediately merge again,
>>>> because the migratetypes match.
>>>>
>>>> Rename split_large_buddy() to __free_one_page_maybe_split(), to make i=
t
>>>> clearer what's happening, and handle in it only natural buddy orders,
>>>> not the alloc_contig_range(__GFP_COMP) special case: handle that in
>>>> free_one_page() only.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz
>>>
>>> Hm but noticed something:
>>>
>>>> +static void __free_one_page_maybe_split(struct zone *zone, struct pag=
e *page,
>>>> +		unsigned long pfn, int order, fpi_t fpi_flags)
>>>> +{
>>>> +	const unsigned long end_pfn =3D pfn + (1 << order);
>>>> +	int mt =3D get_pfnblock_migratetype(page, pfn);
>>>> +
>>>> +	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
>>>>   	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>>>   	/* Caller removed page from freelist, buddy info cleared! */
>>>>   	VM_WARN_ON_ONCE(PageBuddy(page));
>>>>
>>>> -	if (order > pageblock_order)
>>>> -		order =3D pageblock_order;
>>>> -
>>>> -	while (pfn !=3D end) {
>>>> -		int mt =3D get_pfnblock_migratetype(page, pfn);
>>>> +	/*
>>>> +	 * With CONFIG_MEMORY_ISOLATION, we might be freeing MAX_ORDER_NR_PA=
GES
>>>> +	 * pages that cover pageblocks with different migratetypes; for exam=
ple
>>>> +	 * only some migratetypes might be MIGRATE_ISOLATE. In that (unlikel=
y)
>>>> +	 * case, fallback to freeing individual pageblocks so they get put
>>>> +	 * onto the right lists.
>>>> +	 */
>>>> +	if (!IS_ENABLED(CONFIG_MEMORY_ISOLATION) ||
>>>> +	    likely(order <=3D pageblock_order) ||
>>>> +	    pfnblock_migratetype_equal(pfn + pageblock_nr_pages, end_pfn, mt=
)) {
>>>> +		__free_one_page(page, pfn, zone, order, mt, fpi_flags);
>>>> +		return;
>>>> +	}
>>>>
>>>> -		__free_one_page(page, pfn, zone, order, mt, fpi);
>>>> -		pfn +=3D 1 << order;
>>>> +	while (pfn !=3D end_pfn) {
>>>> +		mt =3D get_pfnblock_migratetype(page, pfn);
>>>> +		__free_one_page(page, pfn, zone, pageblock_order, mt, fpi_flags);
>>>> +		pfn +=3D pageblock_nr_pages;
>>>>   		page =3D pfn_to_page(pfn);
>>>
>>> This predates your patch, but seems potentially dangerous to attempt
>>> pfn_to_page(end_pfn) with SPARSEMEM and no vmemmap and the end_pfn perh=
aps
>>> being just outside of the valid range? Should we change that?
>>>
>>> But seems this code was initially introduced as part of Johannes'
>>> migratetype hygiene series.
>>
>> It starts as split_free_page() from commit b2c9e2fbba32 ("mm: make
>> alloc_contig_range work at pageblock granularity=E2=80=9D), but harmless=
 since
>> it is only used to split a buddy page. Then commit fd919a85cd55 ("mm:
>> page_isolation: prepare for hygienic freelists") refactored it, which
>> should be fine, since it is still used for the same purpose in page
>> isolation. Then commit e98337d11bbd ("mm/contig_alloc: support __GFP_COM=
P")
>> used it for gigantic hugetlb.
>>
>> For SPARSEMEM && !SPARSEMEM_VMEMMAP, PFNs are contiguous, vmemmap might =
not
>> be. The code above using pfn in the loop might be fine. And since order
>> is provided, unless the caller is providing a falsely large order, pfn
>> should be valid. Or am I missing anything?
>
> I think the question is, what happens when we call pfn_to_page() on a PFN=
 that falls into a memory section that is either offline, doesn't have a me=
mmap, or does not exist.
>
> With CONFIG_SPARSEMEM, we do a
>
> struct mem_section *__sec =3D __pfn_to_section(__pfn)
> __section_mem_map_addr(__sec) + __pfn;
>
> __pfn_to_section() can return NULL, in which case __section_mem_map_addr(=
) would dereference NULL.
>
> I assume it ould happen in corner cases, if we'd exceed NR_SECTION_ROOTS.=
 (IOW, large memory, and we free a page that is at the very end of physical=
 memory).
>
> Likely, we should do the pfn_to_page() before the __free_one_page() call.

Got it. Both you and Vlastimil gave the same corner case issue.
I agree that doing pfn_to_page() before the __free_one_page() could get rid=
 of
the concern.

Thank you both.


Best Regards,
Yan, Zi

