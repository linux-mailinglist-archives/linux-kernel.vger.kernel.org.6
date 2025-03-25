Return-Path: <linux-kernel+bounces-576304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BBFA70DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272267A3BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15508266B64;
	Tue, 25 Mar 2025 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NiC4UbPi"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826623FF1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946216; cv=fail; b=C5088cJ+8Uq1U0NDw1A/tTtMKCpqzA2p3WnRFIXzJYZXjFOPQs5z3mUIDRVe53C0+VY46WvglM7Qfov1H0VuF/HBnYH+YEvFMpr/AYPZoSM0qLhSGp4ZurVybeoDjCzuV/gA3qX+MfkXqJ55X1iuwA7ndNU31RI9WRloLaPc7bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946216; c=relaxed/simple;
	bh=EP6wyULSTPKdXnVXDuvM6l2KO/nc6j1qCfdKgoolPZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usliIfAKTvQzh/Q4LpOeEwWI+YUYHVDnP1gaWutG19Q7Qg0MpoMIJdXxQcP6nkqaHjv4nkMULtlZiWXxy5GmEaEIhAJwih0mqIzhGANKcSd+CbLR2w3Zn/O417xfLDYci4SKS5T9wGSGbu9cYiM0+LunYuAgNMiH1oipyTrVI4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NiC4UbPi; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/tybzPpa7jfoTTziAtl61KlfIeAMTe9LMICcAW4UvtKeSfSyKNXLPrk48w37rkKou1a9AWpHv2CDD4RZURY/9EJKf5ESFotyeEcnuMU9DQR2UmzaMaKfYw/uM2u8iP2e27tsCQyx15hVKAPotDxXQZmQlCT0KjSjU1bYwCkGzzuVlv0OP9nPleLAFP8Cz3NwNf3BeAV9LpTaAHf8SohhqJ+TQFivFkNcHvPHwXZQM7hWbzCgP5hg7rPoQ5p/qaM85badAWqM/Ex/xhxEeB6tetPJMkxti3+v4mweuZqnarICWGxMmfpC7rg4MtKTU+jyMtE0z6ZhzSF1tKEqJ4BvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekzg7zv8Aqa8w0/w9d8Ll1aDCAECd0Z12gzwIbLsjcg=;
 b=gqt26FsCxLJynWUVdt6OW4+/sGmvuL3zE7HJOFLXqrykOZzcWARSYgx7kCjbUL+lXnkSPZeIWkt2LmPysLeQB6jto1DivVYirH0Fiq5JrmOZc+zuKRdIZcf4OB132EwZC4XnGAXxfNNoM3Vk7yrxEhZFE+J2XV8MB0k+1PnSJAo6MoCE7ojqLCGYoHeIH3IdInxWIcv/8HR4BNB91WPyLq4rTj4Hpky8C1bHNH4bcJiqDkKQPQBX0eReDKkOWpXqrA5sU9lfqatqoIrarCYgEaOY6uITgF4gklNIcEhSd/j3vtGOejGvCI+T1edhvTzrqiHeroQKpFamMMulTBf8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekzg7zv8Aqa8w0/w9d8Ll1aDCAECd0Z12gzwIbLsjcg=;
 b=NiC4UbPi/m2l0YJ06s8F6saH9if3/DYv45c61ScnjvedMrV3P8bMAPXS12DpWa84rR7C3kY8Xw8CguciuCrKllSDZ41VZj4VMtP3CHbLlEnbAz0Jbjp+MIIe5JriZ96LhgNyE1c4VVi6M5TYgv2jtFzmuMJiwALQj2AR8FdYNCqo05Ri5rEPqipQvM6KpfcMRz0ctux/jrWCnC46mXGM6IxXGo8xAGm0euH/EGz/1SZ2cRlXE18OmIx1xWyWrjHMMLn308/YF7T3Lq5Z/7YAiivg7nhcRGkrNN1aZiFaJHZxeAMl4Wv1uHfgXobtz6tYDPU4HqjZiMCe6ZuUiqzQSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 23:43:31 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Tue, 25 Mar 2025
 23:43:31 +0000
Message-ID: <76672910-423c-4664-a1bd-da5c1d7d6afd@nvidia.com>
Date: Wed, 26 Mar 2025 10:43:27 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
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
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <eb041c610719c8275d321c4c420c0b006d31d9f4.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a78721-0ed2-4468-273d-08dd6bf6d9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmpJdUFaRFNDYVFXaVhiNXE3MmsySWVLRXVYb3NUZythVHFpT3VINGJURVJB?=
 =?utf-8?B?RkRtVVgwOTEySUFhZGkvTlhzRkRuTjVZdlRML2ZKbTBCdjFZNlFtanp6YkRp?=
 =?utf-8?B?UlBIbmlBWG84bTRhSm5GM3FxUkxmY0NXb1djSVhwc3Y0U3lqejFsanAzd2dK?=
 =?utf-8?B?bEhjOXJsNkxCMUZCTnZOcy9DdjV0ZmticUF4QUlKNDRNcTRyeUVJOXBNV2hX?=
 =?utf-8?B?UldURkQ2V0JwL1IyVFZPMmhWNTJNemI0VTZ0NXRDQ3NFM1U0NlhNeURGOHlm?=
 =?utf-8?B?emVDdDVHRXFHcm5YZUN0Smo4c1BiOERVZXp1KytUUkZWMzRUK3JIYXZEK2N2?=
 =?utf-8?B?TGNCUWE2ZFRBcUl3S1NidFRBVkV5WGhoeW83NnhtNURGVkZJTWw5bWlxRXJL?=
 =?utf-8?B?K1l2QUtoYVlsand4cHRoU0hBNUxRWnJXeUczR282Z1ZRSTNtM2NzODRLTFRt?=
 =?utf-8?B?ZmFYNllEMWZDbEJMMXpOc0JNNWdQWXMwWHpISDU3RVdmOGJGMmV3QVhVaDFy?=
 =?utf-8?B?dCtzcmZSZ0hLSDk3MnVHSkFjM3ErbkpHaFZaVjcrUDFzRTRhMGFWUFdHVk1C?=
 =?utf-8?B?cFJkYlRlVzdCSmlJQmZET0RrZ1RHNXpIRzlxdWt4T3hDY29jcE5pWitId1Fi?=
 =?utf-8?B?MXRvSXZjbytJSENDODRON3hrQVpJRjgwMnJQd01JMjVHUzBKakRvYk5FQmM5?=
 =?utf-8?B?ZTUrUkZyeXFFWXNlOUZaUGNNSzh1VUlYaWdiQVhkWXBQQlJubU5rTCtVMVB0?=
 =?utf-8?B?ZGRCbjFyOXhxdVc5M09pY3VOK2FWbXlJbGk4aGxKbTVoVWh0Wi8wdTJRaFNG?=
 =?utf-8?B?Vit3ZGR6eHJMejhXUGllVWxEODljRDV3RFNWSG1QWXNhTGM5MDBWVFFDclpi?=
 =?utf-8?B?UEh2N1h1aVRuK2MvY2FXNDd2RHhtVjgrTGllSjNKaUx6WHhyNTl1eUJwRlJo?=
 =?utf-8?B?d0RrU20waG9DYUl4aDVHS1pETHVWNzZyTzFmWEg5aVNjUWVpYndzMjM4eVI2?=
 =?utf-8?B?Tlp3dko2T2NoaVU2eTE0a1hud0J3YThpSmEzc2lCdXVXMVJVN1pjL3hZR043?=
 =?utf-8?B?VDk5c0tpMHZQVFNCV2J1VTFhQ2k4UWRyc0tlNVVYMi8yVU9IN3UzeGNOVXB4?=
 =?utf-8?B?blEySWwveXE1Wkx6ZjViNkl0VFFrY3lac2gycmpRSzlXOWROV2IrdUQ3ckVC?=
 =?utf-8?B?WWNMSVdOdjBEMDlvd1U3S25vLzRFQzNrU3NmbGFxMDdNbGY4RlhxWVJoMHNt?=
 =?utf-8?B?c0MvOFdWcjZOK2lKQVNXQVFOMUdyK2YzczJNUXpjMnFjemZCWG1SSWdtMVUr?=
 =?utf-8?B?M21jNG9MUHBHV05URGNWeC9pZlM0emtyeEs5KytTZVU3STZaOVJJUUUycGxv?=
 =?utf-8?B?YUx2THFvVkUrQzI2MTlnTFJBR1FJU2dqbXp6UHJnem5vY0xya0VNOUo1VkhO?=
 =?utf-8?B?MXFSYXA5eTNlZHppa2Y3RGVvbFdPL0pMYi8zYUsxc2YvR2k3d3VDZ1UxSEE2?=
 =?utf-8?B?Z2dLVmFBYmJ1MXJJbTNaSDU1ZXRZK3hoUUlmSGdYQjNpVnoxbHJRSmZBZlNX?=
 =?utf-8?B?d3B5ZGZackFxbFBQbjhCWjNQOW5QeW9IaUJHdUlRTDJZMTBCeERkWk51MktU?=
 =?utf-8?B?M0xJQ2xrVDBFNlNGdWpqaDlOTmFhUHZtcHU0SVF2VVRRdFZ3ZXR5MVZkaWR2?=
 =?utf-8?B?STU5a3NvSGV5TTRaK0Q5UTB6TWFRcHB5TVZaNVdRVFNTcnpRcFJlQStCbEtQ?=
 =?utf-8?B?d3ZaUWhkcE5VWFluNERqdFM3TE1USEtGenRVUUFMQnRiUkh0ek90SHVhL2gz?=
 =?utf-8?B?clhtQWVxanJrOHN1RkNNdHVIZzBzSmNBcG4zaHQ0SjMrdVJheGNlakxlcGNU?=
 =?utf-8?Q?F1xOCs61RJmfB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTNRMFQ1T1BteWtlWXFnRmVyRzlNMXI3Q0xSTmZOTHpQTGhsUWYycy9xa0Nt?=
 =?utf-8?B?UURSa1RxZ2xiV3FESzh5MWtmT3lMcmpLK2NtQ2VNMmpYSElINGN2VWdGODFj?=
 =?utf-8?B?R3V3UmtTUXZEOFRTaURUaXd6bFpYU3Ivb0NIL2FCaW5iYTFJZlBpRGlhakpD?=
 =?utf-8?B?NHJ4ZVBraGxycWV6cHMwanQyLzZHK1V2R21hL08zcWwwWXZDOXl0SDdLT1o3?=
 =?utf-8?B?WjZkZy8ybmI4K2tndlJyRlpWYkY5WFVmUk1reGtvQloxZnZwNnVFRnNRMUJB?=
 =?utf-8?B?YmdpSERMWmd0NHRiVjNYVGYrOG9FbUFsdkpRTVVnM3NiQ2xaTUN4blpjYUxV?=
 =?utf-8?B?a3JTdUtVTXpFS3V5aUZmUlNrZklYT2szTS9wSVRkY1dGbkRwVmtRaG5zMytG?=
 =?utf-8?B?ZUtHdzFTSFNoTmtMUmNrMHNVV04rUTBKS2xudi8yNVc4NVFOVm5BU1BhSkRF?=
 =?utf-8?B?ZjVwVERXK3dWVWhNZWJhTjkzSmVRTVJEQmIweGg2RmZScVE0RG9IM3U3TWEy?=
 =?utf-8?B?c1NGRE5ac0szdStCOWxMSEFlMEpxazJ4YnBCRUI2cklZeWtsaHRRN1Y1NjVo?=
 =?utf-8?B?VUwzYXdzS3BBWHlyQk1jRTJwT3lzVGtWdHVjYXUyWFp6WitVT1dYYlh5Q2V2?=
 =?utf-8?B?a3VDelBOdmM2SWc5a1ZFSXFSQzJnL2JiT1E5Sm5MQnlxYTJndzMwNndBVlU5?=
 =?utf-8?B?amt4eVQwbWNtQWxqRWo5RlViSlJUd0tXbHJEemJpRjBFTlQ3WjE3RnpBanVZ?=
 =?utf-8?B?c2dUQk9ueXlraHMzVkZsMjZTVndKNXdQNVl5VXloMTVTdlE1U21Kc1Y5Rm1D?=
 =?utf-8?B?V25FZ3ZmUHFyYVVLUDY1cG5LczF2Y2dqdjZNQlVWbVQzWUdKQTc5VVNsOUZS?=
 =?utf-8?B?WE5FQ1pLVHVrVnQ4Mzh6RGVla2pWdnUxRmNMeEkyL3dzQTdwaTh6YS84dEx4?=
 =?utf-8?B?alllZlZVQW1FNzY3TkFNZ1EzRnRjR0NVZzFsemNFOENLSm9TYkRrYTVVaGdN?=
 =?utf-8?B?cFJpUFRwUk9DZE50Ym0zQUlhWUR3d0tXWHJ3STdCMldSR3BuNE5nd3NnRDZZ?=
 =?utf-8?B?UVgyMDNhZDM4RkNQZXRSaWNOcXg0SUZzeDNSWXQ5VHNkaGZFTWZqQXFTSDFD?=
 =?utf-8?B?R21jY0N5T1RSS3d3WEFydWtRbWZlcWh1b2IwWVhEbzMvNm1VRTJ5eUZOZHZ6?=
 =?utf-8?B?Y1gyMEFyR0M1SzhzRG1nYVBmUHRCbkdFL0JDK2tRVE1ZaFUzeWpSZGw3U2dp?=
 =?utf-8?B?MExURXArTW1rYXdPYTJ0SjROVDl1QlZqVGJBbGxEa2EwWnNxc1UwbDhhUlox?=
 =?utf-8?B?bWIzQU9Ka0lNdzZtdkl6a3NLL2tQdXdFejhNKzFGV2xwVkZsT2pnZ21nQWxX?=
 =?utf-8?B?MG44Z0FZMTlCN3NFUVBpeHdGOHNodUd0Z2RkQVZzcXRmWlRLdG1ERHVSNDIv?=
 =?utf-8?B?VlRmdHhLOVVEK0w2SHNtVTl0NDN2MDROT0pPYlN1Yk5tZm9iNEVnTEUzU3dR?=
 =?utf-8?B?UEV4TnRHWW1DRVkzakVxUGIwcmNhLzRYOEdMSzVjcUNqcE91bW5yQ0szVk1z?=
 =?utf-8?B?ZWZWSUErSFY1UktyR3k4Kzk3TTVCRWFJZkU2QUxtaUJlcWFka05zTnYxRTZ3?=
 =?utf-8?B?SmNXd0RoVGJzZGVHM3pCSUE1UHFpS1VpZ0t4MkpqZTFxSGxGWVhRWUYveHc0?=
 =?utf-8?B?V2VQdWhTZkNDVHdQVHlkZFU3OFJUSmNuMHovblhkbDNlZExmNDBrSTRmNG4w?=
 =?utf-8?B?dWVVVkkwd1VDWHVOdm44SnFEZHNTL0ZpR0txRTd3bWZFS2JMK3N4OGdVVktF?=
 =?utf-8?B?TXNyWVVwSXBlVVFLWlBjYjM0ZmVEcWlrbkt1d0REMkF1MnpGZUR0NFl2YjJN?=
 =?utf-8?B?dVNyZWtjWGMzbGVNMWV3Y1hHZTJLeFJqWG5LRnJBdlZDZ1hzdWU3UHFVQ3ZH?=
 =?utf-8?B?ZzVia3Zad0xXYTIzYWtpSjAxL1YvY1VxQ1FMUlQwUllFVnNObkFGU3JkRkEv?=
 =?utf-8?B?cS8yRm43R1ZUL1hmZVFZendTekFvdWZBTlZrZGJGOEhVREZiK0lTczFwdzBU?=
 =?utf-8?B?S25yMmVrTDlRTytMLzllS0NzMllJejBUQUZwMzFmdEtXWThrN0ZsVTh4MTZa?=
 =?utf-8?Q?sOZtcLGAxYx3nocdkIMyStg4K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a78721-0ed2-4468-273d-08dd6bf6d9c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 23:43:31.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VObId9wlCROlrlD7NNCcvKVPJ2oxEz/r/vMqPzCKRcDla12LKIWfND+K432uEAt/LDC7hZTuMt5VWKFKiqkbDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

On 3/26/25 10:21, Bert Karwatzki wrote:
> Am Mittwoch, dem 26.03.2025 um 09:45 +1100 schrieb Balbir Singh:
>>
>>
>> The second region seems to be additional, I suspect that is HMM mapping from kgd2kfd_init_zone_device()
>>
>> Balbir Singh
>>
> Good guess! I inserted a printk into kgd2kfd_init_zone_device():
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d05d199b5e44..201220e2ac42 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1049,6 +1049,8 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>                 pgmap->range.end = res->end;
>                 pgmap->type = MEMORY_DEVICE_PRIVATE;
>         }
> +       dev_info(adev->dev, "%s: range.start = 0x%llx ranges.end = 0x%llx\n",
> +                       __func__, pgmap->range.start, pgmap->range.end);
> 
>         pgmap->nr_range = 1;
>         pgmap->ops = &svm_migrate_pgmap_ops;
> 
> 
> and get this in the case without nokaslr:
> 
> [    T367] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_device:
> range.start = 0xafe00000000 ranges.end = 0xaffffffffff
> 
> and this in the case with nokaslr:
> 
> [    T365] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_device:
> range.start = 0x3ffe00000000 ranges.end = 0x3fffffffffff
> 

So we should ignore the second region then for the purposes of this issue.

I think this now boils down to

Why is the dma_get_required_mask set to all of addressable memory (46 bits)
when we have nokaslr

Can you add some debug around that.

Thanks
Balbir



