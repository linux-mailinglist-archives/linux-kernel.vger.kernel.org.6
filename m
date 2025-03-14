Return-Path: <linux-kernel+bounces-560744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507FA608FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716D73A90D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D01149DF4;
	Fri, 14 Mar 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPE5Q0EH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4D2F4A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932849; cv=fail; b=Pg5hFFt5oQ1HI67dZ3EJyxAMH9pLM5mRo+3iJRTRZOQReTouSnBd4pKytjOejjG17qJlb1aZiutIGwJTITI2d04IVZ1vksJ7TPUvFghKO0HwyrUruJXmdwMpQW+rhIiqi5UOfUu+x/ZiTeDE5zkysaJQRUFmAaH6bFl3xGGejtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932849; c=relaxed/simple;
	bh=nYQ3058Q8cIsAwIpnjMq7W/PQs77ZfJ6Dz7T7R6pKx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVuK353VioH1kCApZfUWOHcAu/SfJU4uM64Zkj3JgRtlJEjq7amCRZ0Y5Ml6DfQMUUNdN0AMYZrD98Ou4KCpTCyhYrvuqCupQ54uHOZQIrxv/xeQBqNee6VQ4JT673DpBTB45p9s33bAR+MBrhCoIxH1HXIbgAUqfG6RBEKOdV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPE5Q0EH; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgheWbHxhNB5IB/lqbu7ovlwP0wvjTk/PkzAmHIsBFa84JfyOji2hx3bxUJ1NecDmAPWkr9CRyj+oIuxQaPKi54hZd0+enLnXEgc8szSEcYHDpWpHgUUfzb42NVCbVliCW6I//BaDGoJHn4bwiJK3IfFe+dQi7I0lFMU5nFfY741R8iHW/E60ZAgB9Xv+NLW7TLHv938205DU84sGCfg7/+N/bbdl2l2PK9x7M751w961TumDlfMZLkgue+774poMHZBoX0+z7f/4ajy7L+LWMiao/IZ+PMuGvRc/D8yMz4tki/HF856K1Q+RXvq0cbe+ULeD5YrnD8qTjlhlBNhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1MxpbC3yAI3lTR6pU5qVWRpizBBbyim5Ir9JiXWpPA=;
 b=Hrutx6QMgISmkeYRnkQq37Qeqg3TgzxPuQ6vekBuQdZmW1mA8Im5ShdSCpY9QT6DjF7UzhyCKljiSlMDuN4BRozCVMYLsp+ph1wCW+/k3bCKBE4Rey8JfI8xxuGivusumWmRt58K1+JbTlOBBUs+LIjEtRA6YE+1sdYxtfSon8s0yaxrQ/DuvdH/lym4QxsCv7o1Kv5tBpW9DNRK8U/viRsFy1bw3U9ZYbr6vYX8mxNKDcgSQ34Uxha9fNiynMjeHYUUBmcc/96JVAufuwj2Fw9VpVUOuOq5v5R1oaUjfbiHnDj+TwCABm6CVlUD793dCZaGu7mjvq0VtQPQzQUu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1MxpbC3yAI3lTR6pU5qVWRpizBBbyim5Ir9JiXWpPA=;
 b=YPE5Q0EHWjeLOektD6zSHtO+v6jaNVhEdSDbYLsYNOAvK/tbpCUQMn4Hxp02Nw2TAYLz7D/C012xCaL1kWKEpEFuEXAkfupcubajz8ftvNMMq7MAAEpyLCYVuMdjKfc9jT93bkQdlGvW96SXGn3YjCuI+yQlLqZnzOcYQn6MB98lHyXwC288kPFX0NAfPrEaJxFLv0DHLIA9gW3jICMehbwdfW516FxhHh0Nc8onmgP4u3MnLUhDDp1pBt+8uqs9q3mlDbBR180QANagUeHAE1P8ib/XNUlW0U5lehgEm1rnd8WVUhQEn41h/nfRkL7DghWm9bst0RtQzFpUykFr/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 06:14:05 +0000
Received: from MW4PR12MB7286.namprd12.prod.outlook.com
 ([fe80::8beb:2d90:7572:13a3]) by MW4PR12MB7286.namprd12.prod.outlook.com
 ([fe80::8beb:2d90:7572:13a3%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 06:14:05 +0000
Message-ID: <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
Date: Fri, 14 Mar 2025 17:14:00 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:a03:100::48) To MW4PR12MB7286.namprd12.prod.outlook.com
 (2603:10b6:303:22f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7286:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: edf1147f-7c3a-4c8f-6722-08dd62bf6c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ei9nUEs4SGJMYWlzd2ZYa0h0TERZclV5Y29vUGM0enNpTE9mZUwweWdQQXgz?=
 =?utf-8?B?R2UxOVp5b29ob081aUVuR2RJNDZ1N2VheHk3c3FabWh1SitlRlhlQXJZaEhY?=
 =?utf-8?B?b0UySHJlQjVlcDJlc0JlZmNRQkZ3R1lmR1VXZjZkQktpdE4wVlZhZ05sUkZn?=
 =?utf-8?B?N0F5MzhkNzhlbWc1WjE4Tldzb3Bkb29Ja2xoNVBUYVp6OW5DUHh1SW8yR3Bi?=
 =?utf-8?B?QnNpMmMrTUFRNWxTdEp5bkRjNHBUUGgrRTZSNXN3RE9hQ3ZUczB1WkNaeWhT?=
 =?utf-8?B?LzZEclJtdExtYXpKdzhxdmo0WGVhbUdhU0VHT2o1TFpTQVltVWpoNWtlOEpJ?=
 =?utf-8?B?WkdncnV1RkpTMVBuUVVPSFRpaEZCUC9COXFXOTgyY2x0czNNQk1WZTc0cGRX?=
 =?utf-8?B?RHIzYmRkbGt4UVBhNmFueE1LZ0lwQXZteVZPNW1uY2pBWHdPWFgzTmVzSUFS?=
 =?utf-8?B?cjdGU05YYUpUTVRLa28zZ1JhamZ4NWpIaG1vSUNGZVR3WTRHL2hha2NiYTcx?=
 =?utf-8?B?WU5KQUdrUWhLME5ESXczNVFSL2llU3U3bUttVDlhSWNrblM1Z2R0YW10NFhC?=
 =?utf-8?B?MGRrQnhuMjhhVnZRUDVFcG80bEdXRXM5c2x6Q2VONzdOaUpYeWZYQUFnK0w3?=
 =?utf-8?B?d3B1Q1FiQTU3cmEzSTlWZ2lLc2lHb045MEQvS0dDNVo1RVJJSUdNd3VhbUNl?=
 =?utf-8?B?N2dERVdxZ3hDWjlpcytKZ0lIYkdKSFRXQW80ZDAxYXBOOFpIWjRtREZmOEx3?=
 =?utf-8?B?ekNaZ3RnZnE3eFkwZkRld0R0RzRTOG5CWkZBaVcwakJVRDBBbUVsczBDSzlB?=
 =?utf-8?B?dzlSVVE1OTl1c2FrY3VFamRiTUEvcWJIMzZiMFlFMG5zbDVxeCtMQmk3NmV1?=
 =?utf-8?B?NWJzTGVMbXo0Sjh2dGRnTUJPczdPNTJWaHd6T1RmcWhjM1I5WlBuUzNCdjdB?=
 =?utf-8?B?R2h3b2srRWRScXRRK1gvTkdIY2xqMmFVNXBNZkpJVXFOSWNZUHRPSlQ3V1Fj?=
 =?utf-8?B?V2VYaHh6WVlJT1lNSEwrRjV2YStIZU5va0lmWjNEMGwrNkF0NVhXTWJ1cGs4?=
 =?utf-8?B?d1krMTdSVWV4dUJPVEpuSkNTRHp4SXlKLzA1V3FyWDNxNys2VjJMbEFjSVdM?=
 =?utf-8?B?Y3YvNU1EanVwYW1pbHpMamY0RXA0b010SDdIbzQ0a3pGOU5IK3h5K0xVK1Vy?=
 =?utf-8?B?UU0yV1llMXB2QmZEcXdwYmRQdmpabVFOTHg2NHhqUTV2NWpaaC8wT3Nqelkx?=
 =?utf-8?B?TlB2MGpSbHVLMnY3eG9TSFE5U29tM1c3MzE1TGJZb2pLU3NQY0pmcXB3SHVL?=
 =?utf-8?B?OGhLaTJFZFVFb0hBNDRnNXIxdXYrZXE4Y0djRTNBcWZidEZ0Y1hBVTdDUzh0?=
 =?utf-8?B?a1AvWXkwN2ZRSC9ka2R4SUtxS1ZzR2srK3ZTVDFyQlpodnFDRTF4VmtFUlht?=
 =?utf-8?B?bXpNdnpMY04zQkc0OGlaTzRtZ2dzalZIekVXWnNhMHcvUGxlYVRtUzZwSGpF?=
 =?utf-8?B?ZDVRTnp5QTJ6aWc1M1QyUDdXbmFYaDZHZGZhbElxVDhJZERyT2N5TG5lNmVE?=
 =?utf-8?B?MGJaU0NIRDZSZU5xNG9IUTdqbDloL01YSEl5Njg4WlNGZFdaTStaZm1CMzk2?=
 =?utf-8?B?M0Y4bkRpcnhtdldkdmt1TGZEVlo5YldzYngyMGJXODVkdVFKdk9hVVpYOWJ1?=
 =?utf-8?B?T0lmQlhFWllENi9EbmpBUi9XMjZSb0VWb0dsWFlRaVhib1VneGNQNHo4dmFR?=
 =?utf-8?B?a0hlTFIvR0s2eUpndDJaVk4rWTRJT2pMaDIvcVRBeGxoRUJVOU9Kdk9EeUR6?=
 =?utf-8?B?WnVFOU1lVjd5Tm01MGdpVjRNTEM3WklUTUxVakgveEFXYWpHOUpKQk5DSzg2?=
 =?utf-8?Q?LL35Oug1v2p/5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3RvdDNzS291UDhCYWhLOWtsSnBXWGFxTmFpdkllVEdYUHdwY0x6SEJrQS94?=
 =?utf-8?B?ZzVnYytPL1lKL29LaElJbnJEem5QaDluR2pYVVIvK1R6T0dhY09ocVhRVGhr?=
 =?utf-8?B?ZFNXODllRndXM2hkMXBHbmkwR0NjQU90RHpFOG40NXROWG82VWluc2hNeTdN?=
 =?utf-8?B?VzZHOXZaSEZvai9LenBFNE9YdFdwcVltZTdYYTNDUnBCSzJsR2tObHAxMW5Q?=
 =?utf-8?B?bXBaWnFlcmpnK1ZyWUdhZWNtN1NyK0wyU2ZVL2h5amRQL3VSd0N3cDFPZ1RY?=
 =?utf-8?B?RzVwQzV3R3VtVExSaEVwMldQbFFLNmNnRTVXWVhEZ3R5aXJ4NVVvS0pJR2NZ?=
 =?utf-8?B?dlh5eVdmcncxVXc2bGVQZmFNM21wdGdhK2ZWM3U3OVord3RwNFJodFU2dVlo?=
 =?utf-8?B?c0ZjQTMrQTVaYmFlU3BEZkV2QS9ZSGtOeUpsMUFsRzM5cFZMNXlwNlF0Zkpr?=
 =?utf-8?B?MWdLTXB1NXlURnh1ZWY3WXFsNDMySVh5TGRYeU8yNElJbUFlNC9wMDR0TlIz?=
 =?utf-8?B?b0l0R2h4R1RidHZBU1Y1dG5wcUZwTGE5ekxLa1h5UzNFME1qNzJ3TVBGZDFq?=
 =?utf-8?B?dkNiQmJlUnZHREU0REQvcEUxUWhUVWdVWnR5MVpNQWlnL3hoOENOdWtXaTlF?=
 =?utf-8?B?aUsrVy9QMDdKUUJ0SUYxREdaR3FIenZCNjJyT05QSCtqODBwYk9teGVnM3d1?=
 =?utf-8?B?djJPTXNINWdtbmNJTEhJOHFIOEYzR2NPOG50RzNjT2s4TzdqOTg1YnQrOHBr?=
 =?utf-8?B?c2k0WTJEZDFRSXdCUWRvTzZkQWROY3plL1M0YkY4UGlMSGVidUdDdUVaeFM5?=
 =?utf-8?B?eHdUQUl2QSszQ3QyVjhseUM1d0pGcHpOajRwY05EQlZSMzZ5YW5zZ0hUbUtv?=
 =?utf-8?B?b29VUERieWcxempZeCt6eDVxN0tRK0xrRDN5c1dhMkVISlNkYlhWUUR4Q0Vv?=
 =?utf-8?B?OEFRT3BNWExtdHdmRWdTU1V6MWxwV1dSTFZTbWd4QStGTlNZdFRtRjdXQ1Zk?=
 =?utf-8?B?Wkh6YUNZcW85OHZvMm5mTDhneENMb0dSN25TYkxCZWk5SVUxelNOOW1CNFYw?=
 =?utf-8?B?YVpHKzFFbFBuaDZZRXZ6Q1JWSFgvNTloYTVmR1RrcWE2TDNaMS8wd2NRTTF6?=
 =?utf-8?B?YVlnUG5FcGxFQ2hMelVDdjUvTXRjZDB2U2JWcFMrUDZCOENNMFJTeDRHTWQx?=
 =?utf-8?B?NVJIcktHTDduMFp2VjZXWThTVzJBM3R6c1N4NmF4dnZaTlNPMzVVaTcyTkFu?=
 =?utf-8?B?dzV4V2YvMXJ1eTVXaVNYRDM5Nk9JNmdTNWVkeHFmMVNGOUl6Um9BMUs1SHB3?=
 =?utf-8?B?c0dhQnV1V2ZsSHM3U001UVN1dDV1aTVzUDdjWE1MdHNBZGY3bExwMHN4QjVG?=
 =?utf-8?B?blpyYUNUdWV6aUs2RkgvU2s4aXdmZUtkSlArOFNBd3QrTHU2QmhKeDJPVmNP?=
 =?utf-8?B?MTYxb28xU2lhenZHQjdNQlpDTm1KZEcvRUY0ZHo4bkNyb1hObFVRV0h4UmtQ?=
 =?utf-8?B?UnFzNUxOVXN6VTRUaitnYzNodWtrVGF0UVNDL2NNckUyUjBkbVhoSEwzem5O?=
 =?utf-8?B?RHoycll3TTJqQVE2U0VNUk5URVczaW1SU1lwUFNSSzZRK3AyMWl3ZzgyRFFp?=
 =?utf-8?B?ZjRGQ1JNYXMzd3ZvUEp1ckpCeExlRkJ0V0VtOXZnYnN1TElWd2VWcklMbWtS?=
 =?utf-8?B?c2J1bUhSUzlzUzJ6MHBaZnRmTTNIc3hSMkE3ZEtnMFRudnc0YWR6K1Z3dCtQ?=
 =?utf-8?B?SUcxaytiTGR2UFYzVkdvd1ZTMGo2cTVaK25ITVhrbW1kVzF5cTBmVGFTZGIz?=
 =?utf-8?B?bG5RNUdVK2syZjRMUUh1YkRFZjZJNVdMbk9PY3BXL1RjOUZ6VjBNV0E0L1V6?=
 =?utf-8?B?RHNzNjEvL0dsN1lkNHFtUXdEcUg4ZnJXQ2d0U1BycWN0aW9KSjNtQWNSNisz?=
 =?utf-8?B?bEZ1ampmU3ZPQlpBOXZFS2k5ZHZPN1BiSGxUb0NmNHNQQXlEc3Exb3JRTDZJ?=
 =?utf-8?B?Q3lTNnFPY1pNdnNJd2JGNzNSWDNKNmZSU3FNZ2w3aUUva1pzN3pCcmJSeUNX?=
 =?utf-8?B?YWRPUGdlUU1pdTFOWCtjSDRqL2tYL2VuS2wrU0ozWjhmaEhkZk1TSE5jcDFI?=
 =?utf-8?Q?woHVucrZJwydWlTZPgUqnZfGv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf1147f-7c3a-4c8f-6722-08dd62bf6c06
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 06:14:04.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fExL7NmSV28aBLHLCXSdhymlR+UO4CQyldS/aTFiQPAaghvA5eSm3tXqhPgayPJJJTy346ezBBAuUBQEfC936g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On 3/14/25 09:22, Bert Karwatzki wrote:
> Am Freitag, dem 14.03.2025 um 08:54 +1100 schrieb Balbir Singh:
>> On 3/14/25 05:12, Bert Karwatzki wrote:
>>> Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
>>>>
>>>>
>>>> Anyway, I think the nokaslr result is interesting, it seems like with nokaslr
>>>> even the older kernels have problems with the game
>>>>
>>>> Could you confirm if with nokaslr
>>>>
>>> Now I've tested kernel 6.8.12 with nokaslr
>>>
>>>> 1. Only one single game stellaris is not working?
>>>> 2. The entire laptop does not work?
>>>> 3. Laptop works and other games work? Just one game is not working as
>>> expected?
>>>
>>>
>>> Stellaris is showing the input lag and the entire graphical user interface shows
>>> the same input lag as long as stellaris is running.
>>> Civilization 6 shows the same input lag as stellaris, probably even worse.
>>> Magic the Gathering: Arena (with wine) works normally.
>>> Valheim also works normally.
>>> Crusader Kings 2 works normally
>>> Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
>>> Baldur's Gate I & II and Icewind Dale work normally.
>>>
>>> Also the input lag is only in the GUI, if I switch to a text console (ctrl + alt
>>> + Fn), input works normally even while the affected games are running.
>>>
>>> Games aside everything else (e.g. compiling kernels) seems to work with nokaslr.
>>>
>>
>> Would it be fair to assume that anything Xorg/Wayland is working fine
>> when the game is not running, even with nokaslr?
>>
> Yes, Xorg (I'm normally using xfce4 as desktop) works fine. I also tested with
> gnome using Xwayland, here the buggy behaviour also exists, with the addtion
> that mouse position is off, i.e. to click a button in the game you have to click
> somewhat above it.

So the issue is narrowed down to just the games you've mentioned with nokaslr/patch?

> 
>> +amd-gfx@lists.freedesktop.org to see if there are known issues with
>> nokaslr and the games you mentioned.
>>
>>
>> Balbir Singh
>>
>> PS: I came across an interesting link
>> https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-addressing-limit/
>>
>> I think SLIST_HEADER is used by wine as well for user space and I am not sure
>> if in this situation the game is hitting this scenario, but surprisingly the other
>> games are not. This is assuming the game uses wine. I am not sure it's related,
>> but the 44 bits caught my attention.
> 
> Stellaris is a native linux game (x86_64), the one game (MTGA) I tested with
> wine worked fine.
> 

Thanks for the update! I wonder if there are any game logs. If you can look for any
warnings/errors it might be interesting to see where the difference is coming from?

> By the way, the warning
> [ T8562] WARNING: CPU: 14 PID: 8562 at mm/slub.c:5028
> __kvmalloc_node_noprof+0x2fd/0x360
> that appeared in the dmesg I sent you is caused by the upgrade of mesa from
> 25.0.0 to 25.0.1. (I'm still bisecting ...)
> 

Thanks!
Balbir


