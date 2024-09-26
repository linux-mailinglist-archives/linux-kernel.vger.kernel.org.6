Return-Path: <linux-kernel+bounces-340951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE59198796A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7996C288E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA9171E5F;
	Thu, 26 Sep 2024 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ZYW7I6w"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90C17799F;
	Thu, 26 Sep 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376528; cv=fail; b=haqQHo8yMGZf8ljqX4Txim/DuLHBwWEr5TTAGrq0/ixmE6hVvw3ZYOtJ0E0cPSV7i9ltALHvXBObF0+EqkeJWGtFpKXMOBlXdVf0RhKA2Ygl5fxcOmmMY9w1dt50D3ElGY9lyLuj2HkO1Nv0APj+oNAu22LBdAJWidc7qtYKPEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376528; c=relaxed/simple;
	bh=p9Q080MF3Z5p/4LD+XfY3Fym/udYLn/i58f3Y30+74c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EGlD5rCR2fBXKfP8IxQ8DoI0750oCcfH0iWa/86RhUlxzBwt3Tnlp1rGhMAFHhQZZ/TzSultp3IRiJw+6gCbRv5l8wOXuFa1yNuZf0uRgR482pf/ahPj8dzNO9j5mNUhpssMc/n+ZG/CbPFruU4S2vVqK7ncksTVikZz+EMrOr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ZYW7I6w; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npA06AumeOvuUTyUvZp3zNwiUfJu2EbJi7jiHXd4W14vW0XLRopp59251NQrVLILQNXcXLKH61F0RzQlrQsJGKVZTGRdawDkcf6O58Es9uSkp6vTiTIM1Coq9aA+jKJ1zDOLooy4A8KKR20oI7dUq/wDHNaaLMMd00ZCd8QOJ9rfE1mRMBRNKRUIbL/bVikII73B3UdTKTUtqPd7Kc2ZNyLhrXexiT7OOjGStQXIaNyeIODDNPLfZJBzEf75nmH62levWmqBf+W5nyCxFv47kgIAwv548DeGLNdFj4W56+2kT5wUpzzUJ93CgSjFRCbJSrhSdgMImEC0JNGflOAg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyxe79iXkXqtI1BX25BVfLuZvFLRTXNhHofiMpbw5c4=;
 b=O7DiYY1YLiHSyLTEJw+YV2dO0WEDY32gLJ9GftC4FmxB2b/qNpRYPgETS0g5I7+xQywu3FQxUb0azmnXFkbrrdaiQqz+sQgf/GjEBhLyvtYluAl1CAWJgNrFFvCl3pL7kNQRmxhjFdXBmX4kuKlKNsVItkKwUNhyoVrhwH00rKgfRI3QFseMpaQrKZYYmpMjbfX7LqhcUJzVACeYA5xW9b9resYLXoMhX3R3k2ixzAK/FFAvy3PRNfbr09587ZNz1YzOyRlz9YDRk1bZLwnsfLksSYgVYomJeLZ2knp0TnThbFlB1arQyIgSuaUkWRNYO9/avO1RwGPVOXrroiaIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyxe79iXkXqtI1BX25BVfLuZvFLRTXNhHofiMpbw5c4=;
 b=4ZYW7I6whSCQHH/AeI5/np6nKcUxr5ydEgkbNkssmLAeihuBIi4C0EfhkOzRE71gY+edpo0/LVXrgj3h6VXbG+SkWMk7kkXQ5vHP1onYPpU/8qIJEiTqP6suxmu82XjGqP16LCH+TrWn1tPKQzuAmytF5/KoSIiLvJIA61TK1bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Thu, 26 Sep
 2024 18:48:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8005.020; Thu, 26 Sep 2024
 18:48:43 +0000
Message-ID: <296ce13a-cc00-4853-b5ee-a1e09215bed5@amd.com>
Date: Thu, 26 Sep 2024 13:48:39 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 18/24] x86/resctrl: Auto Assign/unassign counters when
 mbm_cntr_assign is enabled
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1725488488.git.babu.moger@amd.com>
 <5b02b069cfd7fc3ca30b1e17644d0ec73df7cef1.1725488488.git.babu.moger@amd.com>
 <1bd79a64-f482-4a0b-86d9-4a3328e5928a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1bd79a64-f482-4a0b-86d9-4a3328e5928a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7e52ef-bf7d-437c-1dbe-08dcde5bd840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmpNalh1RVoyKyt2eHNvRVdrQkhhMU1kRzg3eXNnRTFrZjg3MjNiRjdMcnFj?=
 =?utf-8?B?dGJYM0NDNDZNYm9vUHVjRTdneTRiM0hUMEpoSGppTVkxb2ltNU5zdXFzVkJh?=
 =?utf-8?B?d2dUWDRoK0xLZHowV0Y2NDhiUVF1QUVBUU5NL2pyYkpSNWxPQS9OUGkwMnY5?=
 =?utf-8?B?UVo0TkhGemErYWxwZUpJSEo0WFN6R3MvSWlYSEVmTmRZVkNja2FRWmI2Rzhr?=
 =?utf-8?B?L2E1d1Q0Qk0wa0FNVHFySmJ1eVA5bFlOQ1h4VjBxSTlrbXJSZUwvYUVJTVFq?=
 =?utf-8?B?RHBETVN0cXlzeUdpK3hCOVNQLzh0THQ4b3hWK2RDL3l0RUJiV3VTb1l6aG45?=
 =?utf-8?B?RE9WTnFGakJuWXJNdGhZaTd4NkRHbVUyN0xVKzZyMnFZR29qaEdYbmNKQlY3?=
 =?utf-8?B?VVE4c0U0K0RVcW9JYmdvYWVVeUxwTUIyN1VxU1R2akRrREJKVlJnZXdCdUU1?=
 =?utf-8?B?WHR6WHJTd091TnJXaVZZRE5acVM4bkJ6VUVhRGkrSHJ0aHMrdGJneWpGWStC?=
 =?utf-8?B?eUkxMjFOTTZHRGFrcW5ZVW05ajVrK3N1QzU4Sk9vQmJBYXRLWjB0dkl3MThZ?=
 =?utf-8?B?dGJIQ3NCcjhJSDZjK2JNQUJqWWNLZnAyVzYydTM1Mm9QbmloYTZxUkg4Wita?=
 =?utf-8?B?WDRzUXJlamw4Z0tXbkhYNjdJMnNUSy9BbVM0T2k2K2NPREIyanpBcTFsbitj?=
 =?utf-8?B?UlQrYW1mNVQxU3g4SlNXZUVJQVFvSW9vcktVM0lhZThYQ0FLVjN5ajNHbVNv?=
 =?utf-8?B?MFRVK250dldzaW5zNlMrRlVsNzJYck5SVkFXdUFDYzVTRjU1SGV0SFFtQW9i?=
 =?utf-8?B?UlU2YVd5UzhjLzl6NUUyVHRnMXEvdVlxUDRZbERieDJ1TmtsZzgzOE15YUJr?=
 =?utf-8?B?N2E2VlNERjl2N3pENm9NeEt0SlNEK0RNSmRVeExqbDZ0bTNtbDM0ekxXMG50?=
 =?utf-8?B?NVh0M21xNjRBVU9GUGNLUnhLYlFGRjc0QlJycUlTTmZRc1VkOU5RSGFva3Vh?=
 =?utf-8?B?Ti92L3M5WU9LWDNBME5VbHlvcnJwSy9mbE5qeWtSSWZiNTMydElnU1l4bzJD?=
 =?utf-8?B?bml5RnRmQ0Vpa0Y3cU9DZ1d5NzFoaXlVZGRnV3BOZCtZNTNVb1JZaWpnNTBN?=
 =?utf-8?B?MWV4ZERIMURrR2tlT1FURDJGdTZYSDRRUWxadDdPcWRHUWVxdGx5Sk4xbmd1?=
 =?utf-8?B?N1BpMXBKQmZFM1laZ3VqRGFQL0diS0p1dGg4TlJCV1AreWplYk5lZnN0anR3?=
 =?utf-8?B?a3VqSzBZeFl5eE03NHlzNDdKNml6TWhwN3g2Y2JTQkJ5Zjc4eTNaL1lHZSs4?=
 =?utf-8?B?V1RXQUhUUEdvS0hJM3BVMHR6My9rOWgrUml3dmFESEk5OUt5TEpHVm0ySVVS?=
 =?utf-8?B?WVZPK0dYUUlBN1QzcXZmNWkrbEJmMkpnVVR6eng1UnNuUmlZZkJTUGxjMGpO?=
 =?utf-8?B?YVRpbUttaWlDOFozTDhjNVNpUWh2UEF1dy9GM1o0N2JtbUJxakp1VFBhSWpj?=
 =?utf-8?B?RUZBL3FLdk9NSGtmRldUeExHLzVvWGpoY0JpcEpFdUEzTmxOcGJ5endkbVVw?=
 =?utf-8?B?cGlNbExDeENudmRPUmdRcmJYdDk5WmdBNXZRY3pZZi9uWi9ISWhhNURBOWxG?=
 =?utf-8?B?eXZKS0J0bDNwRXJob251Wk1HWllnWmY4VUNmM2QyMVNTNDBpTmlRbkZkbzBM?=
 =?utf-8?B?MTlPeWdUb25oajdmOFBLTm5SM1FPY1lOTE81OXBvUncwT2lpWjhLLy85aFFj?=
 =?utf-8?B?aTM4Rzc3c1h2NjErSENkR0krWWNKb25DOHA4NGJNR1p4RG9HN1hwRHNLeVVE?=
 =?utf-8?B?bko0a0VqTXJTbWxPR1BjZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RldVeFd5dzN2MmZuaU1ZYlRPNnZkZUFpTzMvK0NqMkQrdUJOai9iWVc3MzVK?=
 =?utf-8?B?MnEvM0JrVlg5MEZxdHM4d09ra0w1cFRZZ0JJd1dwbWduYTZaV0NleXVYU2cr?=
 =?utf-8?B?dlZqOWNCSUsvZlN6UFIrcjdXOU1nK0l4VmNsZGJNUTJ0a21hOURqMG1YdkxW?=
 =?utf-8?B?RStpd2xqL1drMDhUNjVTKzliRzYzaDU0NXUrMlNwUnZaRjBGQTlmQlNEQ1dQ?=
 =?utf-8?B?Y250MkZyaVY5Nk1UeDMxSHJnbHpBdm9DbFBEZ0VLT0U4QjhMY1NhZkRpTjM4?=
 =?utf-8?B?R09KanZUejVBTVFFUUpVL0RycUJYNHZra3B1cmxwVUNrMkI3OVRqSUpHb3Fz?=
 =?utf-8?B?QWNTQmJ1MzYwTG9VbGFERGNlUEVxcE4zRTNROW9ndXVzaWxLNWVkeWJ5ZHNV?=
 =?utf-8?B?U291cFFmcHRIZGdSSXJLT2xMdjVCdUVWOEVoM0xZZGNHdk0wWG94SFBrWnZi?=
 =?utf-8?B?SjdVRmVLUlpEaG9heUtrVkhiVldUZWNEb2wwU1BUdGFzdHVhMWV6MFdjR2FY?=
 =?utf-8?B?ZE92ejJrbkhqeFk3K25yazdDdEk2aCtrZmRvL3RNYUxQU0x0ZnVmUXB1U3VM?=
 =?utf-8?B?TE9MNW5seXZZU1drQVpFYUFPL21IUWxtSHI0RnA4MXlhbkJ6UjN0VzdmVFJn?=
 =?utf-8?B?alZKeVFHRWxhM2dCaDJkSUxpMjg5RkR0Z1F4Wk4zZFl3V1JlMUlvZW5SVk5y?=
 =?utf-8?B?dFN2TmY5MjFiN2tEZ0V5Qis0Y3VzMVBDS0h5UVpUdEc5alQ3T0FPdmxkbFcy?=
 =?utf-8?B?SDM4RVhIdTdMN0VJSWNvTTdqSFNGM2duL3dHRnE1ZGVQekhaMDVpWVd5U0JJ?=
 =?utf-8?B?SW9pUGJDaDFsbzZkOXorVVdDMzFPTUpHeCtqR0REVEh2WGVtekw4dWNaSXpT?=
 =?utf-8?B?RGdQS245NWZaZThHUDBxY1d5NWRacDBXV2gvYUgyakZsSGdzaFNQMWNmYnF4?=
 =?utf-8?B?a2l0Y2lyV3oydnJQWXgyZ0Qvd25zcElMWmhoSVp6Ym5JczJUSm03cXhtZTgz?=
 =?utf-8?B?T1l4bjBjR2hlSW1CVFNUaU9ETjhqUXp6aHZHZ1NwTDRvZWRNb2pLd0tiR2dH?=
 =?utf-8?B?cEEvdENZcGx6SWxMVzYwcVdGMEpmNVhydHFMZzlyWTUyVTBNQkFhTjlISmJQ?=
 =?utf-8?B?emwwQlVNYVUyQjlicjdENUNwTE9CSk84QXM5Y3NlaC9lNTB4Sjc1MVNQNUNp?=
 =?utf-8?B?eFRGQUZtWGxuWUtwc29scldiYURPbm5QRGVCRlFwQkZnZ00rZWgxTTFpMkh4?=
 =?utf-8?B?dkFVTm92Vi9hdHpUY0VUSWk0dGZqQmVqTkhKYSsyVisyQXQ2bDdOalFaN29R?=
 =?utf-8?B?bkpEQWJVdmtScUdtTTZDeFh1c1lVVDhqRGREWGdyUE9NVXpUSko3T2pWQWts?=
 =?utf-8?B?N01yM3R4cDNkT0pCdmlka0NjQ3V0bnk4blBNdFRyeXFSUGxXMFVDU2xJQjVo?=
 =?utf-8?B?T3NFSnJDQ3lBaGg2SU1VNmw5RFd1N3RKRllvZ0xNUDhUTGxjY0V2bTIyL0xx?=
 =?utf-8?B?cW11ZmVZT0Y2dEE4R081M0xuT2I0SEF3Rk9CK2x6RFlFTEhQYVUzZEw4Yk9J?=
 =?utf-8?B?cTY5NmpGZHd4UjRZNEtSWno1YUpNSlRqT2EyeHRld3puUTZ4czd5Q1dOalVU?=
 =?utf-8?B?OFd2SWhYbDl5OWtRSC9oVlFMZVJlVmxKRklxZzdoeE44K2ZzVS9LRmcydzly?=
 =?utf-8?B?TVNtd20wM0grSlpKVWRvRUZFamxkb1U0T1hsZ3d5NDduRnYzRkNpdWdUZW1Z?=
 =?utf-8?B?NmpyVitaS2FBaUQzVzF2NldrZWFnUVVFK2pDOFFML0pjZnp2VFhEQnhQWGo5?=
 =?utf-8?B?TUk0cHVBczd3d3kxa3lwRVhnQVE1V3M1Zk9LS3poa3dwYnJyeURUN1VvY2xt?=
 =?utf-8?B?U1JtbzlLNzF6NUxrSjNtVi8wQldISTJFTkVCcjB0KzRYdlgzZ08yV1hjOUU4?=
 =?utf-8?B?UGk4R1Bqd2VGMEp6M2FlRjRCZ2RNUGdtR0k0VEEwQ2FhZURjaWhUdnkwa2lo?=
 =?utf-8?B?dUlSa1VpSmM3cXlMdTdEcC9tUG1HNWxBUTFXNzJrV0cvaXdod0hta24vWjBo?=
 =?utf-8?B?VmJBbUN2NmxMTUJpZlZHSU44SGY0NXhLUWd3dVgxeWZlYmgxRGc1dVA0L0t0?=
 =?utf-8?Q?nPio=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7e52ef-bf7d-437c-1dbe-08dcde5bd840
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 18:48:43.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZW2kh9LTz54QyidrB7zqcGL79aZ3DjLbDARbVbUxUs5JVWcyw2ZgMEsPIT0aVAw7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

Hi Reinette,

On 9/19/24 12:29, Reinette Chatre wrote:
> Hi Babu,
> 
> Subject: "Assign" -> "assign"

Sure.
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
> 
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 21b9ca4ce493..bf94e4e05540 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2866,6 +2866,52 @@ static void schemata_list_destroy(void)
>>  	}
>>  }
>>  
>> +/*
>> + * Called when a new group is created. If `mbm_cntr_assign` mode is enabled,
>> + * counters are automatically assigned. Each group requires two counters:
>> + * one for the total event and one for the local event. Due to the limited
>> + * number of counters, assignments may fail in some cases. However, it is
>> + * not necessary to fail the group creation. Users have the option to
>> + * modify the assignments after the group has been created.
>> + */
>> +static int rdtgroup_assign_grp(struct rdtgroup *rdtgrp)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	int ret = 0;
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +		return 0;
>> +
>> +	if (is_mbm_total_enabled())
>> +		ret = rdtgroup_assign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +	if (!ret && is_mbm_local_enabled())
>> +		ret = rdtgroup_assign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Called when a group is deleted. Counters are unassigned if it was in
>> + * assigned state.
>> + */
>> +static int rdtgroup_unassign_grp(struct rdtgroup *rdtgrp)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	int ret = 0;
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +		return 0;
>> +
>> +	if (is_mbm_total_enabled())
>> +		ret = rdtgroup_unassign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +	if (!ret && is_mbm_local_enabled())
>> +		ret = rdtgroup_unassign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +
>> +	return ret;
>> +}
>> +
>>  static int rdt_get_tree(struct fs_context *fc)
>>  {
>>  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
>> @@ -2925,6 +2971,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>  		if (ret < 0)
>>  			goto out_mongrp;
>>  		rdtgroup_default.mon.mon_data_kn = kn_mondata;
>> +
>> +		rdtgroup_assign_grp(&rdtgroup_default);
>>  	}
>>  
>>  	ret = rdt_pseudo_lock_init();
>> @@ -2955,6 +3003,7 @@ static int rdt_get_tree(struct fs_context *fc)
>>  out_psl:
>>  	rdt_pseudo_lock_release();
>>  out_mondata:
>> +	rdtgroup_unassign_grp(&rdtgroup_default);
>>  	if (resctrl_arch_mon_capable())
>>  		kernfs_remove(kn_mondata);
>>  out_mongrp:
>> @@ -3214,6 +3263,8 @@ static void rdt_kill_sb(struct super_block *sb)
>>  		resctrl_arch_disable_alloc();
>>  	if (resctrl_arch_mon_capable())
>>  		resctrl_arch_disable_mon();
>> +
>> +	rdtgroup_unassign_grp(&rdtgroup_default);
>>  	resctrl_mounted = false;
>>  	kernfs_kill_sb(sb);
>>  	mutex_unlock(&rdtgroup_mutex);
>> @@ -3805,6 +3856,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>>  		goto out_unlock;
>>  	}
>>  
>> +	rdtgroup_assign_grp(rdtgrp);
>> +
>>  	kernfs_activate(rdtgrp->kn);
>>  
>>  	/*
>> @@ -3849,6 +3902,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>  	if (ret)
>>  		goto out_closid_free;
>>  
>> +	rdtgroup_assign_grp(rdtgrp);
>> +
>>  	kernfs_activate(rdtgrp->kn);
>>  
>>  	ret = rdtgroup_init_alloc(rdtgrp);
>> @@ -3874,6 +3929,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>  out_del_list:
>>  	list_del(&rdtgrp->rdtgroup_list);
>>  out_rmid_free:
>> +	rdtgroup_unassign_grp(rdtgrp);
>>  	mkdir_rdt_prepare_rmid_free(rdtgrp);
>>  out_closid_free:
>>  	closid_free(closid);
>> @@ -3944,6 +4000,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>  	update_closid_rmid(tmpmask, NULL);
>>  
>>  	rdtgrp->flags = RDT_DELETED;
>> +
>> +	rdtgroup_unassign_grp(rdtgrp);
>> +
>>  	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>  
>>  	/*
>> @@ -3990,6 +4049,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>  	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>  	update_closid_rmid(tmpmask, NULL);
>>  
>> +	rdtgroup_unassign_grp(rdtgrp);
>> +
>>  	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>  	closid_free(rdtgrp->closid);
>>  
> 
> Apart from earlier comment about rdtgroup_assign_grp()/rdtgroup_unassign_grp() naming, please also
> take care about how these functions are integrated since it seems to be inconsistent wrt whether it is called
> on mon capable resource. Also, I can see how the counter is removed when CTRL_MON group and MON group are
> explicitly removed but it is not clear to me how when a user removes a CTRL_MON group how the counters
> assigned to its child MON groups are unassigned.

I think we have a problem here while removing. The child MON grou counters
may remain assigned when CTRL_MON is removed. Will fix it. Thanks for
pointing out.
-- 
Thanks
Babu Moger

