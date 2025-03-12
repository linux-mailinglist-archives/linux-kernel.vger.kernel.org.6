Return-Path: <linux-kernel+bounces-557160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDFCA5D458
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B9B189C090
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED315539A;
	Wed, 12 Mar 2025 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sD2i57SN"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6038FA3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746237; cv=fail; b=tUIynT9ie3/QLyf1gZB44hO1UxqsBoCo+eNtX2tUsA0oStssyMbuyw5NtzM27pSkjIbNS2flXOZTtKYASQ6IXobZuvE7VIRuBEoJ7siEofvcRLc0fYJqPRTaLWgPXSldXMnCW46G6b0zduON8AJRKizMaBj6id5EbK0SdCPKvLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746237; c=relaxed/simple;
	bh=fUCHoC3xPJ6f3mWy2q9ia4Er67rFxU5cnt6jbk16I+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o589PzdxGu3QMjoFEZqs3QzSJcM+f4MVgVBcCUPGbYxKE3wjgOKPwS0Pa+uTkJh1aVj/ntn6AOVKmzuGvbqeOxP8ItwL8uX9BT5yLHgWRyLoBkK+HJTlOunmyqGrcbOdECA8HTHluJOrjUL2nB4CUo6+pzY2+Fu9duo1NF5stQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sD2i57SN; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDwtm7Ggc3T4mIhnmSlexNRw33dN3uo7YcgFvdqxbTPxZy8jXCa9gvMd4Gv4BYuGx8qdvtXL6TJoZL+RBfYF+Wh5ot2QOMDgqLZv4576g/ySRn8buB2kj6XzaRvVPlZX0Wg4zS1eHbbL8qp4D1OLclnpOE9gZz52xXMyPQJXQO69Ph3N4FMP/pFCUkVQUFQuwEvJnqsUfhi7h1VB7cXsujRLlb43BWC6y6E67p/Oofg+787bIv9XzbugzrhDbnRt1J825sGIpqsiGuzpE3fGlb0PRRMwhuIv2R70Qa7Y8XORC6oKfSvKhODjODooDxU4RvRkBHHhTA42+Jjw0474+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrjMfB9G1YbUjhmME9CDGfUijWVvD2KdVLo1B9wn1gw=;
 b=vqTXK5kYtDPd0ZSTndi5PjR90g6+EC7drkgPB6NaN5dUvIEeZC8vwVvAN5+Xb6u8nhdQpYECNoiVs7sW4lkut7dqafTfwzMoB0gcHM6Mb/KWqgcjRlR64ivywO11NAGB18d3lkEf/jZBb8v4gZwJb5OWRuFSZhhrRVvNJL0dKjs99x+napAzYaV84XIIxt39N5XhUtKAMgD6wEcVrvOsvBr9rYrslRHzP4hIXIHR0f0mmcC9ZpB6mXk/SzJDkadcnGcqtd+YuPHBRnr1/HvDQM6/I1FilabDSgrfHv11Tp9LkoMt4N+E3x7xuFINfXbqrKhItpixOTpQIHo9dnTHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrjMfB9G1YbUjhmME9CDGfUijWVvD2KdVLo1B9wn1gw=;
 b=sD2i57SNF8ZVDS5jI/W54VzaxrxQm/mMPytieIfa560aLuakWmh6+EjB+mKijQUYerCsdq6p13LAgcNuuoqDp+7FSB6XsEMp7Hp2QgEonC3WeM5rxk7m+Y3TOIBfDm601A6Yr7aBK7hI2a/TjZYARKs3fHRCalydB5lG7ttuqG5rDhz+J/1x85MiOZxfnj3vqJ0+nTeK0ELwiyUiWsk+1XqMZG9GOd+ALZaRkdgCOimraCTn2RoRqHTPCyxcARVyRLJTDlCgUdZEGyadScg7v5Uak1zMJ/3nquhP81clde4l43RKz06SeFQXTlF0RVUAT+qCo/6Ht3totZNdOM4e5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:23:51 +0000
Received: from MW4PR12MB7286.namprd12.prod.outlook.com
 ([fe80::8beb:2d90:7572:13a3]) by MW4PR12MB7286.namprd12.prod.outlook.com
 ([fe80::8beb:2d90:7572:13a3%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:23:51 +0000
Message-ID: <ddc0181a-7580-427b-b1e2-c3b1a3d48ff1@nvidia.com>
Date: Wed, 12 Mar 2025 13:23:47 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <cc1c59bba5b4e8b8afef14690f6c974e8bd814a3.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <cc1c59bba5b4e8b8afef14690f6c974e8bd814a3.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To MW4PR12MB7286.namprd12.prod.outlook.com
 (2603:10b6:303:22f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7286:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6f3c3e-3d12-4a57-adf8-08dd610cedc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VW43QUQrR28wZk55blNpdkdQNFNLM2FCcjJFTGJjaldxTkNDQjVUa0c0R1k3?=
 =?utf-8?B?TU8rSFIvSmVHRElvNUEyK29FWUxpRWxwNVhROFo0Q0JLenB0dzQyenl1QnlJ?=
 =?utf-8?B?UEpXUFZENnhEZmM3UFZwS1RJeGlxUUpaZ3J1eTZnWG52Q1IyVERERlBjWURM?=
 =?utf-8?B?WDluNm94cTExMFdmeDAwUEhZaGpYWDZDUEorZUVRTVhXeWl6M2xoTWpacXJk?=
 =?utf-8?B?cVVRQjdicHg5Rk05RDVlTy9UWFN6bGtvQTZ0MEc4QkxDdWhZN011aitnUzJu?=
 =?utf-8?B?V2F4bHErWUc3eUhaSEVWUXVuUWg3c1VuMjRKWXAzYWpVdTRJRU9PYmREYW9S?=
 =?utf-8?B?YTZBRVdvdi9aUDc5Y1Z6NzcrTUh4emk1WG9TUWRXZzFkbzhvSGhsaC9qSmFo?=
 =?utf-8?B?dnNjKzBLclovQXFnRDhjeHVHM0hVQVFlM2QvVmUrZ1JEYndIanVMbFZCMjIz?=
 =?utf-8?B?TGtoKzdaR09UZE5mNElXQ0drQVBDMVhNZXNZMGZSenkvQ2h6c0lDbC9QclFl?=
 =?utf-8?B?OVJvNmo2cUE4SnlaaEZvUy9oRVpmdWYzVkhDWkg3b0owcEFhSjFyT0tOcS8w?=
 =?utf-8?B?YlVQclpVN0RpYmJqZG0wOVRFbkNEU2QrZWllL0o5ZS9QWjR4ZjN5dnR2Y0xJ?=
 =?utf-8?B?VWpINHJWVkcyTGNOa3dEUmZSa3lKdGNsQjBrT3duUzVoMDFYMFNhU3p6QVla?=
 =?utf-8?B?cHArNFk2Yys3Zk9wOVVYUVlvaXAyR2lTaXhzUUlncndQaVk5RWowYlFaVnI5?=
 =?utf-8?B?TXB3T0RIb0ErQXpudnFMY1Zmb2FkUFZyZmZVVjhrZ0x6MGduUDZ1YUpmVVZ5?=
 =?utf-8?B?WXlRVHVJVUlsbnJETHVEL1gyTnFVRUxza3ZBOWtMZXc4VjdNZDAxTmk0MHls?=
 =?utf-8?B?OTZGMmtnaWFzQ1ZKcjlKamVKT0hmVjhTM0Q0aFdIZGcwcWluZlFEZGRCcndo?=
 =?utf-8?B?Z3NTWkhlYVBEQ3VKeFNOQnJYQlNtMEx4Unc1NTFNT0JCQmpjTy80SDBZQWtE?=
 =?utf-8?B?eXdmY01SVEdQTWxZY0JHa3hqNitFam1qeFNTTUZ0WFZkOS92L3NkYVVNTnNS?=
 =?utf-8?B?OVAxWkNIU1pqc2pLRGdsQm1NWmR6L2oxSE1Rd0NEQ3B0eEFMb3BxUWtWTmZV?=
 =?utf-8?B?amVpd0pIdndjL3Jhb0o1Nno5UVNoYldzcDA4elNGaGV3NWdTY1FUODg4SmRN?=
 =?utf-8?B?Wm4wWXhKOU10ZWRvcmRvUHNFNWxlTDdsdHdRYngwMndVRURyNnRDSVJDeHo5?=
 =?utf-8?B?TjZzR2dncmlDVFk4VXVHUURuMnpWZ0V3c0l0TGVBK1RBU1kwcXV3UU1LMXdv?=
 =?utf-8?B?eE9DdnhGQWVsZmhZOU5JVDYxMlpEb2plSTZSMU5FemtLNFF0cHA2WHVmeHlm?=
 =?utf-8?B?Wnl1U2FrVHR0aDVGSE91QWFiWWhtb1NJalkvbTFJN09qenUxN21kTlJkZEJZ?=
 =?utf-8?B?YnMvZnR6UHVUNzZFUWVuOWFTVzBldmlML3d0OTlVSC9oK3JCWmFYYnhCSFR4?=
 =?utf-8?B?Ui9iSXRPK25IVG9rckx3dUVHOC8wYXA2cjM5OFBBbDMvSEJoWjJJVWdieWdO?=
 =?utf-8?B?RGpNL2RXazRFRnoyQkNCVWpTeC8wSnowU1BvMG1QdzFtbmp6VFV5MTE4MEE1?=
 =?utf-8?B?YjBUc1l0ODhMd0VvdjBZT1c3U2dCcTArM2pUc1UzM1VQdG84cEtzYU1FZkRJ?=
 =?utf-8?B?bVNaQlFpUkxCcnZCZlNVUklBaitOTEphSitYaVV4NzI4UGhuL1ZXaFlrOWU4?=
 =?utf-8?B?RGpvUXU4TUFFRTAvZ3RJanNnRlZqdHJxVWpUeXU4Yk0xYXR5eFFNbTVkaGJZ?=
 =?utf-8?B?RnNsZ012QWxkWkJBQUhpZjRsK0N2Zzkzc3RhTzhGRyt0WWMyM21ueWtNZnlS?=
 =?utf-8?Q?VWV1RrBanOuSp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEFhb3dmbm5keHBWandSbHFoT0ZNempLdFl3czJ5N2xGQ2VwMnkwQlJ0WE4x?=
 =?utf-8?B?V25jWmI1RzdWVTVtYnpFTDV6K21NZkU0RFRzTG02c200d3RPb3pVdnUvY0Qw?=
 =?utf-8?B?QklSSzVTK09ueGhFZkdDbHRTRTEvam5nb1dhZmRVbU9IZVZzdXRFL2V3eHFZ?=
 =?utf-8?B?TnA4UTArMkNCZjdhTGxHN2NpMC84Skc4K2p6SmwrVHhyald6a0p6cGVzTWhN?=
 =?utf-8?B?RmJrejJvSmwwNzNha2dlT3crS21NSmc5a1EzVDBhNTJMOEJJb2IyUWwvTVdo?=
 =?utf-8?B?NFhVYmZyYTZ5eVJFR2hpb1BScmY3cEVzSzVpQnRidGFzWWYvS0tZMEhia0dN?=
 =?utf-8?B?T1B3L1pCV1d2VVN1TzRQN0JzQXVQWUpqYWpaamxmUDZBMXUwQWtDbmp4OTJB?=
 =?utf-8?B?M3d2SjdQMmIrTGpCYUwxWldwNTFLa0ZHcm1pT2RINm1uSmtqUktFQkR3Sjk5?=
 =?utf-8?B?NGNOMUpOQnkrbXRlMGJwdWJGNlRXeEVPU0tSaHY3SEpnWHNXdnBtdyt3N3dm?=
 =?utf-8?B?cFJDRW04Q3FudTVaNXRsTVE2c01rZTBwUGIwTXpJeEZaN3E2L0Q5cE43TFQ2?=
 =?utf-8?B?WGlkSlhOVDVtNm1oSUtJTm02TE5HYWdQcUIrRTNVK281WGhHOTkzSUtJNTRX?=
 =?utf-8?B?Z3laaDVYVmdDQzk1SzBia1JWRUowMkorMEQzWVNhUEFKT3hDZENNS2UxM0dp?=
 =?utf-8?B?aHh1Zk9BVGFjTzg5cEo5R1pHY05WRzF4eFRBcTBOcTVsV3k0UTN6YVlLdHpw?=
 =?utf-8?B?RFU2TWdybjlvUXlIRGJCc0ZCZC81R01wYjZnNVlBQUZJeDloT1NKaFJQc3Zq?=
 =?utf-8?B?emowS25TU2VyRU5LQUFUV3M0NVBaRXkzMUZybjNkbkNJTWZ2d0pCY240QUJG?=
 =?utf-8?B?bDF2UWN1WXFOcmtRek9jN3FISTAvclg4NllOYzMzNkZnVnBJa0RHS20yczVT?=
 =?utf-8?B?WlB4K0cya1lEUjNwYkxGSWtOaktmNUxWZzZJcU8yK1YycllmdURoWkdSWmpG?=
 =?utf-8?B?a2FaQ1BkZ1MzOGQwaXRXbHMxZ2NXdnJSand5OWszcDNQNzg4dUpkYy9XbEQy?=
 =?utf-8?B?RUNQRGVUUURBc25aY0dpem9QN1ZzQmVwOVpIMzRNYXg3aDNBNzJMNkVlYXNm?=
 =?utf-8?B?Mjkxc3hrbTBnZUdrOGdBYUxDSEFCMlBhL3YwVW1lZFNlRzNNR3ZSK2tvNWc5?=
 =?utf-8?B?TlM2RGt4VVcvMVlaS3JmcXFnZ043Rm9aTmovS3JuL0lhVEZhazJjbXdJcHVt?=
 =?utf-8?B?MUlnNGNoRlVabVo3aGF0ek5seGoxZUFwRjUrb0ZObmR1Unk2MUtUb2h2b1BO?=
 =?utf-8?B?ZzBPUEJaSGJsMmZqN0V6RkFzSlh6ZjEzazZJVzJZUFhVWm5KYXZUTkRBN3lC?=
 =?utf-8?B?djZZRkNRNDhLTjR3OXcwV2EwR1htbmFGRnBHWlc0dDNLcFJSZFExSWEwbzc1?=
 =?utf-8?B?TnZLOStqRk9jY3FqYUs5TDVxNEJSdFk1cUtIT2drMmxNTXFMNks0bG5YeXQ3?=
 =?utf-8?B?L2RHQnYyWHhrM2V1aHByN1dISjg4a2k2OE5nYjNWS0hpYTI3UWk2ZWVYQWNH?=
 =?utf-8?B?SmNJVGxZWUFSWDRyV0NzeVlDd1pzdzJBaFZsdlZVRkJKSzM5Rno4Wjl0eThE?=
 =?utf-8?B?ZWQ2WlBwK0Fla0Y5b0U0ZnZkTzkrZ1ZyQlBCKzFkQ0oyWHRxRHdUbTZoVXRC?=
 =?utf-8?B?bWV6L012ZUJ1cXhCOWR2Uk1wNmVTeVcrRHcxMHUwYnhaUFcwL3piYUd1Q2ls?=
 =?utf-8?B?UmNHYk1kcW5KWXdwa01ialFjbXdKUSs1am5LTkFvQUs2NW9CNW43Z2dqcnov?=
 =?utf-8?B?czhlQVZRbkppRHphNTVhSWV5d0F3WitKZ2hiMzVCY3huQ2d2R204N3d5MHc3?=
 =?utf-8?B?NTIzNU9nUjdYVTFEUE1ZbEN0eTl1djZOVHRPbW0zeDFlblcxOGhwWGlKL3BV?=
 =?utf-8?B?N0hGVnk1QjRCQytxWTRqUzJwaCttcExxQ3hTaHB2K3BiYzI3SHQ5cGZnRGcv?=
 =?utf-8?B?SEJ5VWVsVzVBdlZ6ZEhBVjVwdTlCL2pLcTcxMU8rWENYM3hFK0s0RlNuYjZJ?=
 =?utf-8?B?WE54bG9zMzNDZ0tWQkJvR21GREdIQUR0T0pnbXZXQy9SbEN2Z3o1Nk5uWEo5?=
 =?utf-8?Q?dL+mpBrIinBAAy4mr3T2oCTHQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6f3c3e-3d12-4a57-adf8-08dd610cedc7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:23:51.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGBwZHDqRx2UFX0Xo49odBb0MI2e9aq9tihT1a0kDIk+JdK22cTGs9Ls4fTOHMhI2rmuD2dDoF9C807gaJNbDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611

On 3/12/25 11:26, Bert Karwatzki wrote:
> The combination
> 
> CONFIG_RANDOMIZE_BASE=y
> # CONFIG_RANDOMIZE_MEMORY is not set
> # CONFIG_PCI_P2PDMA is not set
> 
> also shows the laggy input when running stellaris
> 

Hmm.. my changes do not get compiled when
CONFIG_RANDOMIZE_MEMORY is not set

It sounds like there is an issue on the system which KASLR
was hiding by bringing the region to 0xafe0..

With this patch CONFIG_PCI_P2PDMA exposes the system to the
full direct map and that seems broken on your system.

Please see below

<snip>

> The diff to the other case
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_RANDOMIZE_MEMORY=y
> # CONFIG_PCI_P2PDMA is not set
> is
> 
> # diff -u proc_iomme_6.14.0-rc6-norandmemnop2p.txt proc_iomme_6.14.0-rc6-
> nop2pdma.txt
> --- proc_iomme_6.14.0-rc6-norandmemnop2p.txt	2025-03-12 01:18:33.022790613
> +0100
> +++ proc_iomme_6.14.0-rc6-nop2pdma.txt	2025-03-12 01:19:36.000325778 +0100
> @@ -85,10 +85,10 @@
>  fee00000-fee00fff : pnp 00:04
>  ff000000-ffffffff : pnp 00:04
>  100000000-fee2fffff : System RAM
> -  3a7e00000-3a89d2f56 : Kernel code
> -  3a8a00000-3a8e31fff : Kernel rodata
> -  3a9000000-3a912a5ff : Kernel data
> -  3a969c000-3a97fffff : Kernel bss
> +  d32200000-d32dd0f56 : Kernel code
> +  d32e00000-d33231fff : Kernel rodata
> +  d33400000-d3352a5ff : Kernel data
> +  d33a9c000-d33bfffff : Kernel bss
>  fee300000-100fffffff : Reserved
>  1010000000-ffffffffff : PCI Bus 0000:00
>    fc00000000-fe0fffffff : PCI Bus 0000:01
> @@ -104,4 +104,4 @@
>        fe30300000-fe303fffff : 0000:04:00.0
>      fe30400000-fe30403fff : 0000:04:00.0
>      fe30404000-fe30404fff : 0000:04:00.0
> -3ffe00000000-3fffffffffff : 0000:03:00.0
> +afe00000000-affffffffff : 0000:03:00.0
> 

So this is the interesting bit 0000:03:00.0

I assume you'd see the card at 0x3ffe00000000 in the output when
CONFIG_RANDOMIZE_BASE = n

Basically the change is moving the BAR region from
0xafe0... to 0x3ffe0.. and the game does not seem to like that
change. It sounds like everything else is working fine?
Any chance you can try another game to see if there are
issues with just one game?

1. Can you please also share the full lscpu output?
  - I am particularly interested in the address bits (physical and virtual)
2. Can you please share the full dmesg in both cases?

Thanks,
Balbir

