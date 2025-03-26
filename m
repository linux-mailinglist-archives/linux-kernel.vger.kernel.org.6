Return-Path: <linux-kernel+bounces-576392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18C6A70EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5588E1731B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977817E4;
	Wed, 26 Mar 2025 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uADXrfOD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F12E403
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953821; cv=fail; b=BtJVrgCtUg1aNvoVgIIYKS4EVaXdXaNYvQ9i1d202dCrgu8cUKWHVzOinLBOTcoloVSMQvyHnJLZG/SX52BZiZBQeb/bsn+ES/Zs3COBqPaTUdyDP99JUVZR+cPsbBzXIHoXn+sgVrNxsUuxVX4Ma0ZssSuFENMgZgoijwbT+g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953821; c=relaxed/simple;
	bh=Oh1k5B4BkGgv2WRU7C+pyuefJ/Vv7pOKpIcg56tdAAA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIw2bmgOYrHwbdUELn4N8jug7UNztZCcn70OQcqbeBf7yigbcd43L1hLBKd7xLnkNu94+3pVf08NwCvjJIAfn6pvmBqw7MK1e9XJ7wlvAz0zHuMUailtDo/xMRps+QEn6cQ9VIxIoxDf6YJuX2Ho9u52NErlAXEWQdWpmw+2oxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uADXrfOD; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loottW/IYyulzcj9WB3oIM+xJpvbfQ55hp3Ik5ZBjx/fcPgWrtBKbKXu6VX9jIdroMw3B4eR4yE2dNhKTP66q/VNZUIuhXwc+PfgeBVHOHt9K/le9VBxSID4p5EkFtF5L93Eq4Vz3WgkGVQND1r9iOhLaZhPirVrg/81WnLJzjKaD+J3CTykFVfdghKmJX23gS6RsYVcOyZGZDFnMgV9oodeHuctUE5S4kowT/xPrwn5AEPaI6mI3th6G3n9dkielEBIIW/jTvO2wgm2Hm1CZ3WIK8ctyB9vdHbxFbX8C1E++Rw4gzJXR2FabBVvGwqFjE2sSiEJCVR3R2j9eqwIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWiwOoV+FPdYQaliSN6U28Dx9OS3ELx/ng/32j70HD8=;
 b=uW+Yo954EP0eLB/asnwf3IuB8aVk/admMoXs8Xulhjdti5jSkvB9c3UpViKI3NuLO8G3o5UYlFgUE2k1YNIjFpx9TfgauVdZC14xylP0+O8qwLZBS5tlz0H/xIo0BhAx3fXbrA/PQCMcg4JPbJbnasykNkfZnyqK3F2eBc411/2BWozRqFF6YNbIboMDKQK3rIFRa5mJ1pZc2hcXTt0E+0EJlCD9+CeSntHXAhI+uinPceM2tSwbzbUrz7jjGjUaiItOBWHE2DweRYq+Hjko+L2JtLvKxuQZAqWuuZDK5RM+w5aDlO21kq6G0Us37aBA5IjqaGsSA6CsUpXNPOMvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWiwOoV+FPdYQaliSN6U28Dx9OS3ELx/ng/32j70HD8=;
 b=uADXrfODxmAVEku4JkfiWxu/lpLuw96KqEAb8UxlaU6hCsE/R5XhQF2kCOzkQnVzsSz69fzHbP1/7ndUW1Qrz6uaNCAumRwIAWy7AxevhtcLPJ+dFGHvZHoeuk73c8Wq4FTyDgmiiEXZNS0CeTK7Qlzb8O6e6FK/g0fTO62bISg0HJsfBUWvchMpRHzxQrZSUY6L7Vr42temKBdsvEouZYZmOGgCvLuZROazhSCby36V6aIQCAr0jZ/xNQIyC6kCpxOA2NJJQUl1rxTD+OxwXE5ITRF3TdF/25GGVmy7f8VDTSF29TMGGizlZx2m3+szObwXnliz9UOqIcLbEXYhqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 01:50:16 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Wed, 26 Mar 2025
 01:50:16 +0000
Message-ID: <a9f37e3b-2192-42d2-8d5d-c38c0d3fe509@nvidia.com>
Date: Wed, 26 Mar 2025 12:50:11 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Balbir Singh <balbirs@nvidia.com>
To: Bert Karwatzki <spasswolf@web.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250322122351.3268-1-spasswolf@web.de>
 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
 <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
 <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
 <261e7069-9f65-4a89-95cb-25c224ff04f1@nvidia.com>
 <eb041c610719c8275d321c4c420c0b006d31d9f4.camel@web.de>
 <76672910-423c-4664-a1bd-da5c1d7d6afd@nvidia.com>
Content-Language: en-US
In-Reply-To: <76672910-423c-4664-a1bd-da5c1d7d6afd@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: f50fb9a2-4fd8-4e3e-0412-08dd6c088e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmhWVjF0VThMZVFtS0lmeTJpWk5GVXFqTm1icVZUWmNIN2xvcjhPejM2akVW?=
 =?utf-8?B?UkhQSklqa2NFVEVjUlczcHcyeE1XZzhsWlNkSTkyNHJTK0Q2OU5WbmVxZ2hZ?=
 =?utf-8?B?bmhaVmxOSWMybW1IZmFEK0w4WGVTSmdyZlFTOENjdUVEdGR0blhqYmFWWW9M?=
 =?utf-8?B?MmhjMWZwamZPTWplWlhwcXVEdlhZOXBpOE5lcThaYWhaSmgxRDJ6bjhQdjFX?=
 =?utf-8?B?bCt3eXQ5U2h1K0lLdFljWDEyQVVnQXE4SGdjalR4MFZVNDMxSjVkUi9rdlps?=
 =?utf-8?B?YTlwV1l1RHVSSlJrR2kvR1NpVkFOUEl6M0g1MTBHVHhxVUdxaDNzZ2dVVG0z?=
 =?utf-8?B?TXJOK1ZPcVA3YjNDWjgybWFTWnJTd09MRVF5U1Y5UmpNN0pWK1ZMSGFnTHdB?=
 =?utf-8?B?VS9PeDUyNzQyVFVRSk5lUTFBdnZJbVVzVUlrTS9hT1VCRXY5d3VaMDQxYlFY?=
 =?utf-8?B?ZElES0VwZGQ3M3dYbFpZU3ZmZlNOVmR5ZmhMWHd3bU1WcmdMV1RXUm40QU9s?=
 =?utf-8?B?bGlidGVsVHorUy9kYzM3aEU5clR2WC9oS3ZPdVU1cy9UTXJwNnhXTEhVYUZt?=
 =?utf-8?B?TjJvMDJwakVCUThNaHlwUFB0RUdEOWFMN1cxaElodVZHbWlDTSt4SDg1ekN4?=
 =?utf-8?B?Wkk4VDlMYU13Y3NqRDBxMVlZY282dXV6cmRJWlhvY1p2dFdHdVU1My9CdFg0?=
 =?utf-8?B?RG9ib3BJZW5YVE8rT2l1NzVvMUNaMDE3MWRublM2MGc4OE42ZXJKV2lKWWhT?=
 =?utf-8?B?OXdWWENUOU0rSnpvYWIvV0xlL3hrOFZHSEN6ekdqcmJxWjdsSkppNWFWQkxI?=
 =?utf-8?B?STJMd1F6aVY4bVJnVGZBYXZGSFByQ21TNFRSR1M2eWp1VVB1SGRpVnpUNXl5?=
 =?utf-8?B?c0V1dk81U0RJblZjNXhGdmRFZzZIcDh5eDlQdG5ydW5JbCt2VzRMNktISzZi?=
 =?utf-8?B?OFpaWGptY0R2Q3paQWF3TG1tUkpUc082QUYwT1l1T2VIK0dRdmRFRlNBQXQ2?=
 =?utf-8?B?c3c4SllNNzVDYzlsK0o1OE83NmdESWpmdFVLcHplM2JRZzV0a0dycEhOSFVk?=
 =?utf-8?B?VlN1bjFxZEoyZHV4ajhVeitiSHh0TFFUYk9rZy9oK216czVvczZDKzJmNWhI?=
 =?utf-8?B?Y00wUmVlTkRWNzltOWxCNllvWEkrMG1CeTlpZlg4RE0zOWovRUpjeGRMWmNh?=
 =?utf-8?B?VkllNzB3SU11M3laa00yTnl2QUZDSDgrNllwR2gwNUtsTDNjcks1MnZXc3NG?=
 =?utf-8?B?aEtzRHQwOFdiUllRS0FSYi9GaTNDb2xQVjIwWXZVM1NPUW9JL0VGRENKYVpy?=
 =?utf-8?B?NEJqVFB5cTFxWjJ4U2ZXb3J6dlBNUTZEWERZSVUyeERRWEQwM29sQmRCQ2pn?=
 =?utf-8?B?ZW0rYmVUSnNoWmYyVXlWWjZoeDV3NjJLUHMzaVIrZ2JCU0dGam52Z3g2U3V3?=
 =?utf-8?B?Z1V4V3dxQ3FaQWhhMkVQcFBEUXFBSVZmY2ppK2h4NDQyUmJJWGpPMXdYenpT?=
 =?utf-8?B?ZThMTThDYUtFUTVFSktDc3VXcmxyY2dkT3BRWWVLOUsvSHJ6WGhGWnU4YThC?=
 =?utf-8?B?aVZ4Sm1jd2h6SjZRTzlWVVhQYm9sQTgxRm5UUEs3dGxHeXhJSUJBVzFtUE9V?=
 =?utf-8?B?ejh2UVNUQVZaNGN2SlJEanhvUzRLQ1lnRTZ2aGhvMTZDTEEweC9uTmxDV1pS?=
 =?utf-8?B?MDRYU3pIOVByalhkWXZobS9ZbTNLV3NvdDVLTklybkpSZjFodlNrRnVUN1NW?=
 =?utf-8?B?QXdsK29jUm9VRSs0OEZCQ1VwWDlLUFNRUjZIeTJVcVhlVS8rd0d1SlhIdEkr?=
 =?utf-8?B?MUlHc2JUcTMyd0dNYkhXY1U3S2diQWVYWUhOQWlkbVlnd0FHd0VzQ1pNVkhS?=
 =?utf-8?Q?0cJQ5ZHweeSPp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9hRE9Ea0pqTEwyMEg2cVAxNVY4YjloandnQVIyYkpyWkQwY3dEOUNIdkkz?=
 =?utf-8?B?Z1BobElQNmZyaHJ1SXMzSFZTdFdhMEJJWVRUMmVMclAwcmRzaHBvQWs4WVBX?=
 =?utf-8?B?ZngrRGJMSFEzb1pGU01Uak1wYktOQW9FbENLUDRYWGdBVmVSOUlhY0k4QXBW?=
 =?utf-8?B?and3ZlpyZ1N5bHFzSE5xeFdJMXBiMHBCNWdOaGZlZHF1aHNDR0ZzOXZtYkJw?=
 =?utf-8?B?ZWZRZnlTNUFVMDZnU2F2bWVnSzAwQzVwZG52TWJKdUtMTGRJRWlINFlrWnZK?=
 =?utf-8?B?OFdxM3BxcUtUeXcxSjZlVnNJV3YxdTRCV0V2YjBXUkJ5NkRzckRNKy9GaTZR?=
 =?utf-8?B?RlBCdS9nQ0x0OXJpTW9zT25iSXh4VWxaL20vRTZCU2lPU2N5d2UzN29rY0lo?=
 =?utf-8?B?bGVQK1djckl0ekdTdjdxam9HN1dDcjBITzBjUXZhbzZSODhMekxiMWQxWDVq?=
 =?utf-8?B?aW4wY0NiNzdyQVZLVW5vOWJlWi9lRS9GTTExUjVKanZXcEYvSXRYWUV4WjFi?=
 =?utf-8?B?THByanQvZHYwWFkxODFCcG5CRUZYV3Y4bHFYRXVKeGtWZUplNjhYQ01nZXZw?=
 =?utf-8?B?azcwSG1jKzFkQ0NITCt2R3NVQXhmUmR1YkJtaGR1eUVCRHhBbDArSThSOFha?=
 =?utf-8?B?ZXpMRVQzREFIR2FRL0h6NEJUQXZLY3lPL1VGMnNFdTlFWmtDMktZVEZRQmpk?=
 =?utf-8?B?aUlxNmhFU1FwbTdyZWlmdlN0UHQ2dCt6R041enhXbUR5TlpjbDNLUzhBTG9x?=
 =?utf-8?B?eHh6M3ZzOVkwakk4SVUzVzlzQ1ZpTjRkYUp3b2dvcm9tS29MbkFPMUJMUEps?=
 =?utf-8?B?NjVEOHBDVlJBbTgrR1BrNzgvZnp6R09HYzlXaTN0WFpMNnVFUGcvUUZQUmNX?=
 =?utf-8?B?d1ZhQ05jV0ZlNmdLcldZaTNnK0J1WXZDcGMyTlhmcVJxYjdaK3pNSlpLWmZu?=
 =?utf-8?B?aE8vYUdLSW5MSFJOR2E2VW5WR2RYNU9JTkJ0VUJkR3FnT1dob0hVaWF2VWxk?=
 =?utf-8?B?eXVORFRCS0dqL20rOUVFUXYxbmg5ZHNMYUQya0tYaVN0azd1NkNGdG1NTHFL?=
 =?utf-8?B?NXA0dUxNT1J3aXhKRmtrMWZOdlV4TjQ0ZWNWMG52QmdBc3I1MWd1QWdhWkVW?=
 =?utf-8?B?NFFRcGNRSll6Tk0xb0RZQTNQTDNSdjJDa0szQTdZakM2U0tFcStDcitscy9v?=
 =?utf-8?B?MlkycHZiU1IxY1BuMHZvYnJTOXkxSS8xVXIvQU55eWRNblIyaWVPQURvek9l?=
 =?utf-8?B?eTV4Y1liYUpScUptU29sdWZ4Zm40L3RveGNmRkIwdHY1ZGVJZzFFWkt5VkE4?=
 =?utf-8?B?cnJDU3kwVUFxR25tMU9PNjhXV091WjlQbmpVK0xwQnNtSlh5RmMvZHFuQTBS?=
 =?utf-8?B?OEFValkvT1ZYeHdXVWIvQm9tMnQ5OXNiSktRcjl0VnU2MXZJZE5DaWlYOHVH?=
 =?utf-8?B?TkFnVHlzMlhuWU1XNjJFZmhYRktZOHhDSlk5cnV6U1l5K2YrNkthRUFaS1lz?=
 =?utf-8?B?bnhsQmprYnIwWW11ZWFSS3hKL0hZbXFXYWJiYVNOclE0RllQbXRnY0l4OU4x?=
 =?utf-8?B?cnRQaS9KZ2FMdGk3M1BGN1plRDRGR09Bc0VEeVZBV1dXVjFhTDNKK3pYNmVO?=
 =?utf-8?B?M0Q0M3hlOWNTT1ZTcWZVZnlvQ1JSVzNwKzdvVU00dWVMQnZ0Sjk5NEI4bGFC?=
 =?utf-8?B?ZWtnZnVwdnFpUkhMRGQydHcxNHJRcitnQ092TkMzeklLQjBlK3NrS3RoamNP?=
 =?utf-8?B?dXhzRFlGL0dwRVh4aWFNNlpmL2FlOWNTQUE5cjBHaHM3TTFmZHFqVzl1RTNv?=
 =?utf-8?B?U05KOUdvRjVmSnRWcXRjM3ZKbXNjYWNBSG1US2hSVjE1MUhiVExGaWVKMnFM?=
 =?utf-8?B?c0hrNElMczVzTThHbjZ5UVEvcFpRK3FVcnFUajJ0NVRCS0pRSFJUbldiSjRP?=
 =?utf-8?B?czhBSkNCZHh0RmUwcjVMMmVKUkh6Qmdkcm9paFg4c1RZYlc4eEQ3OEJRSUIv?=
 =?utf-8?B?aStmL2hhMEZLOGM2cTkraHJIanRqSnp3akVwT0lrN1BkRzN0dUtvaVMwUWZy?=
 =?utf-8?B?T1J3QTVaZGoxZmFCMGtIcW0xcWkrcVpXanVuMGlYcWVyUmdhalhRNDU4Z3NV?=
 =?utf-8?Q?WC+k+wskoJoeChQEhniccv8si?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50fb9a2-4fd8-4e3e-0412-08dd6c088e97
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:50:16.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qo8//fb/+R/cXLVkoH7gS+DNKDtMVwXHxwkz4pZRO6Q0ybjt1H0MSDEEBTiGbkvb0LIXdX2lZl1cqWeIEPeFNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996

On 3/26/25 10:43, Balbir Singh wrote:
> On 3/26/25 10:21, Bert Karwatzki wrote:
>> Am Mittwoch, dem 26.03.2025 um 09:45 +1100 schrieb Balbir Singh:
>>>
>>>
>>> The second region seems to be additional, I suspect that is HMM mapping from kgd2kfd_init_zone_device()
>>>
>>> Balbir Singh
>>>
>> Good guess! I inserted a printk into kgd2kfd_init_zone_device():
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index d05d199b5e44..201220e2ac42 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -1049,6 +1049,8 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>>                 pgmap->range.end = res->end;
>>                 pgmap->type = MEMORY_DEVICE_PRIVATE;
>>         }
>> +       dev_info(adev->dev, "%s: range.start = 0x%llx ranges.end = 0x%llx\n",
>> +                       __func__, pgmap->range.start, pgmap->range.end);
>>
>>         pgmap->nr_range = 1;
>>         pgmap->ops = &svm_migrate_pgmap_ops;
>>
>>
>> and get this in the case without nokaslr:
>>
>> [    T367] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_device:
>> range.start = 0xafe00000000 ranges.end = 0xaffffffffff
>>
>> and this in the case with nokaslr:
>>
>> [    T365] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_device:
>> range.start = 0x3ffe00000000 ranges.end = 0x3fffffffffff
>>
> 
> So we should ignore the second region then for the purposes of this issue.
> 
> I think this now boils down to
> 
> Why is the dma_get_required_mask set to all of addressable memory (46 bits)
> when we have nokaslr
> 

I think I know the root cause of the required_mask going up and hence the
use of DMA32

1. HMM calls add_pages()
2. add_pages calls update_end_of_memory_vars()
3. This updates max_pfn and that causes required_mask to go up to 46 bits

Do you have CONFIG_HSA_AMD_SVM enabled? Does turning it off, fix the issue?

The actual issue is the update of max_pfn.

Balbir Singh



