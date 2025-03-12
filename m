Return-Path: <linux-kernel+bounces-557132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D47A5D402
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A56A173038
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC581AC8;
	Wed, 12 Mar 2025 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R8iNwaSv"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD35661
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742664; cv=fail; b=c7T+EUkVgag88q47vh5yXBKjR0kWSJ/pkPRdF3sshaQt65Xg3ekBPkgLz+FJzbSQP95qYcUNjomCniiXprD0aEGtyebS2xZHe4NITF3bS35DjD6Q5B+0D5rhqy6h5+wv/byP86PbX4LSCUtdoSoiIqSiF1J+6ziNPl4YMirN4I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742664; c=relaxed/simple;
	bh=+coGhuKRsK3ZKJmPiHMfW0DwFyxQPXr6U1yiFT6CY1w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YYf/rYfU2FwNY4Pugr212tYap22s7f+ULkehuVF/G/XPhH2xD59Z5RpOMxC4NSbGJYJv726H9w2T0/FXbAoduxfSK1YqNcSI7VjjyPFQxtwKfIMd3hPSB7966Pis/IhtalMJmxa9vZL889xplhDRJP9iy8vRLA1NxH5WYd/9raM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R8iNwaSv; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTBnE8dSl1nOEXsBpjbj8HTmkc8OaybHSJfI7vqX9V4Pv8Nlqmm7NDt8fU/jIQYPUTY0HhTR/d/yN8AbmWPeTIQgHeZBJ0orcjDr9Eo43EQX72qgI+afhEBkFvIQdIWNrVVXTwHhbvZjVBZ0GgZAT8b8PNoQZBMgo5Dc6lOmnkIlA/tTdkIQ0IqQ2b4BAFClvLV36ibzM3xIDXTDah2COkR1nm7H/WHxe9329F+pr8gZNWlcBUt75JKHcHpORsjipwmYR1Xqusj8rQD/zPyibEl4UPg8tgR5Jvf4URYnLevxIC25+SOo4hel1TjkH9abdOg+L0L7XZ6VnQgQP6mCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL2mRdYGwN/HZhFXbxTadqbEXzPf+JHu+d4m2QQGGCU=;
 b=Lc6uHkLhKxmVr5hqjrxCT7NhnupcKFgxLAITKihUhtZ47wA4olqm0RBBEdLsGgqYCu/v5FbQG6wAPslcAIvNAL/UcelOVcDZehBAb1j18YC2rmyHtu396oTA8qMjvWFgHEJTmzn3QJRWyLvEtvGDQ3DFlcZpYqARKk8EU1ArTmp7V5wLEkrYI1PYK2rirj51Ia5oztbyH4pNxHbplWv2sQay5jO1Z8lamvKr1mV0IoqXoALERjF9DW06VucyMTuGpVackU11ooICIOlEs9b2S/8hNJpvQb0/vOSJ21NyWDsOoz5yiGmF1/YGT3Hm4bF8sbEW8aG8SShK8OsMgSO80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL2mRdYGwN/HZhFXbxTadqbEXzPf+JHu+d4m2QQGGCU=;
 b=R8iNwaSvXpSE5P0jBAAEUafJPYPFNgPwH9nfP8V699Fo7r1Qkwqd+ezLsdtFiGZRR3BqXkAmLv6YsvuNF0uIkGuJoe5l7maPzxvRvOL2ugLk2Xw+jmHn4PFkGtPdyYhVpxSYYdUv4duDeL5GdusUqhxmlHjL+mtWjLWyfW5X9gVSmjyQcRpn47oOFfrDki1w5in8Y0j0pLOnLxxDIgx3cC2LBT7kTaVQXACdhq155cmJo8fU0rZmqYBcse91v5/xY5cOs7ROkzHfL3AnZQ6nmMVYrpZJqMJ+OsiePHC9Txn7PGmgA/ySevcx0q+r/DCnQUiUXMKToEeyjWzV6btLfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 01:24:19 +0000
Received: from MW4PR12MB7286.namprd12.prod.outlook.com
 ([fe80::8beb:2d90:7572:13a3]) by MW4PR12MB7286.namprd12.prod.outlook.com
 ([fe80::8beb:2d90:7572:13a3%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 01:24:19 +0000
Message-ID: <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
Date: Wed, 12 Mar 2025 12:24:15 +1100
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
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::47) To MW4PR12MB7286.namprd12.prod.outlook.com
 (2603:10b6:303:22f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7286:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: aacc090c-e123-448b-cf79-08dd61049cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THhUUTR5T0M5M3NDYjBCamtsVFFOTUVYeWlmS2s1M2VESXhSTXYwWG5FRW1M?=
 =?utf-8?B?NlcxWlVHMnZFbk5HSmpkY1dDbGtHY0tBRzJsQ0RnYVRXaTUwMEwxZFpyZTN5?=
 =?utf-8?B?NDBIdU1VcVNXZi9LNFNkZlIrOCtEbksraC9tOFZ6d0dlT0xVMkl6NjVsVFdM?=
 =?utf-8?B?RnBkVzQ3UW9seVFxUFQwZUxmMGhET2pCQTFQVENCYXFSbDhTUGNFblpGNXdv?=
 =?utf-8?B?ZEJoWDlaNWNZazUyc1phWUlKYldIWmVjVmhxaEUwQkFQdHl1VjVRNEIvWHdM?=
 =?utf-8?B?RXcrYVg4dzlxck1lamlJblQ3anlSMkZ0VG1SZTBhcCthQ2pzVnErUFJoNGFw?=
 =?utf-8?B?VE41THU2NVVYZHhaVjl2MG1hZ0NPd1lmY2xzaGVJZG9OY3dXcTRYOFduaEt0?=
 =?utf-8?B?bjgrUDQ3NmNzZEhsZGFBbmlQQWMxNjdUU1NzTmgwemg0WkVqU2tWbnNXVTFK?=
 =?utf-8?B?SklHVTVnT3FjQ2hlTnpMSjJ2VXgvOS9LLzZDUTdFSzRCTkRLaTNOclBhSlJy?=
 =?utf-8?B?NFdITzVGVGpyUDMwS2pWUUZrSW5YQVV5ZUdWNWx6TXBzeExZRGNJTzlXY082?=
 =?utf-8?B?NjFHelF6NUJjRWdNRUlmQUlwUDRNQWFDeWhTU0RWWmFSVFhwclJLaU4rVTA2?=
 =?utf-8?B?aFVsenRZR3hpYW84bENtMFh3b2FrTFlhdXE5MjlEWlYxckVJczZKMThpcHRs?=
 =?utf-8?B?cWllVjM0ME5qWlBmaW1reXFOMlptOHhiTXREaDl5c0ZMQmpLenU3VjJtV1o0?=
 =?utf-8?B?Q3IzNTM2YXlGN0pvRFhvcCtLamdKMlVtSC9RSlgwSjhDZ1NQUVNuN0kyQTFt?=
 =?utf-8?B?VUNIUG5SQktFNkFpOU1hTW5DUWQ1V0lZYWtHUkxDaU1PZCs2QjRmUDBpV0FF?=
 =?utf-8?B?cUE2SzdEengwckZTSHpRbXVIVGs3cisyTmlVOUNQYkc2S0xPY0kzdnE5TzNQ?=
 =?utf-8?B?TXNWUVgxOHphR3NFVUw4RXc0YVdGVUNnUzdwbml1aWwvaWQ4NWRwTWxtR3dI?=
 =?utf-8?B?cFhLMmxXMlZrdXB1d1ZCVGlOLzY5RTlyM0Z6TFJwQ3ZjdFFRUlpuQ1YzeThZ?=
 =?utf-8?B?UDg5eXVGWWY4YXRsRjVEOWtVU21kYUcwSVpLOTFLNVdLT1pVRUJibXhTcnIr?=
 =?utf-8?B?T21KWWVlSjlOcEdPMWx1RlBiZyswdHBvUlhvOWdwODZ5WldMMFYzZkdEbUdk?=
 =?utf-8?B?ODRvNGZjRW9sRC9QT2NjY2VNZ2tsSlRBbDRJWWptMGZwRlBCZE1hYWthVFhx?=
 =?utf-8?B?M1NpOWxjT3VoZjQ1aUI4MGEzQnhqTnV5czRER01scXM0MjF1SkJKaEhRemVx?=
 =?utf-8?B?dUl5ZGk5VXd6RnZYQ1N3N0NaYmFLK2IreUVxZm5zanduLzQ3TEhxdWpiNnpz?=
 =?utf-8?B?a0RmdEw0dXF2cDk5MUhIVENicm80bVQwb2lYdE5YRStCNzlqZ1ZrT01BaGVM?=
 =?utf-8?B?NEd2QmswTGJoK3pXd3lnRytTcXFOcUx4dkFvTFJWdmx2dE9wcFp6b0FPN2hZ?=
 =?utf-8?B?YXVwRHhkOWpNWTdaWTVoVGU2d0tPakpjdjNkTytzK0E5ZjJob1BtWDRvMkdG?=
 =?utf-8?B?bURGbkZmTkZxb0ZyUmhIVVlaKzczZjZoeGY4cjYvNTNveER0cmIxT0FqTE40?=
 =?utf-8?B?QlhLbTFmaThOUVlmUEdNTnBaQjd4WnpoYmNjM05TVHlmN1ZvcEh2M0NXcEFC?=
 =?utf-8?B?bjZHU2pCSnh4Wjc1QjV5b3BROHdYV2dPVWRzRVJUN3NjRndIUEFrZThZZlB2?=
 =?utf-8?B?QUZZMlBQTnQ0WGNlSUNaTTdSVW15YUJqZGwxTy95ZlA0eEJJZjIxeDl3c2hn?=
 =?utf-8?B?bEVTeGIvbXdoVmFxcFY2NVB4YnhERVlYQ3hFYy9GVkY2ZUVoRFZpQXVCVjIx?=
 =?utf-8?Q?EEZLfZMGFVnHO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1FPTG1pV0xoREwyaVlMaXkwWjYvUmFwVEJVNXR6elVLdUJjcEw3eG8zREJG?=
 =?utf-8?B?WXEwWHJoVkFETWI3RWZFcVlFdEZML1BGZ1A2VDZnRGpxei8rSlNGUFFBVlJq?=
 =?utf-8?B?K2RxZTZjdlVxTmljQzd3S0d6NCtZbDJYYU9tN1NTNTlvc0RENllRY2s4SVpk?=
 =?utf-8?B?VjZwd3BrZGhmT3YyTHVQMU1aYlZFOEhITldsci9aRzh6TVVmUHYzbXFveGZw?=
 =?utf-8?B?TnhxT0NZdVgvT2kyd2tTSW9uTkR5dmZnUXcyRVRqUUJ2NHdudHJieGdNc0E5?=
 =?utf-8?B?QjhlRTdlRnA4YTFTaVE4ZXRpNURVY004ZDVLRG1PQmg5WERwMWxLR2x6QnlS?=
 =?utf-8?B?ZGtLNzQyMnhKK3pEc3VSdkxiZEV0Z09FM2RIL3M5WDRsMTJBTnp2YXE5M1NX?=
 =?utf-8?B?K2pwYVBzOXNsQlVDTEE2UnA3elA3TStwZHFMRkR3RzNneTBYVEllRkNqYkln?=
 =?utf-8?B?SHkxZ1ZEMXQxUktyQ09Idy9UN2Z3TnNUUkkrRHVzbUk0ODIvZWJHOENjOE9T?=
 =?utf-8?B?QStrODNPNjRaRjQrV1VKRUk2RGg5NGs2S0M2N2hXYjZUaDFHeEttYlF0TGRj?=
 =?utf-8?B?RWxlaUwwN25VZis2TnBQUWIwajZpTEVwUzYyd1RldnRtUnZkRWRlWDZlcmp6?=
 =?utf-8?B?L3Jqei8yNCtxc3NMNlB4V1RaUis4VDZYMVErU1BPMTAxaGMvbVNOZ3hpQ0hw?=
 =?utf-8?B?S2hqTUR2ZXhqL2hqclVRZTE3dE1UUk1mNlFsRmZPN1Q5VHlhNUtFcVR1aGFl?=
 =?utf-8?B?VUcrOHp1enMrMDdsUDJhMFpDMnlFVFE3a2FvcUpmR3hvVzN1UDNsVUVxZ0Ji?=
 =?utf-8?B?NkQyU29ZK2FCSUYzekxNUDJ4Y25RbnI3cUdJMngxbmI2YzhvOXpJZTI5WGZ5?=
 =?utf-8?B?TVdwUXJVTnpMRTl2WkdLWHhlZnkvN2F4S1VQT0o1Q3JnaGEwb0Ezb3pjVlQ0?=
 =?utf-8?B?QnV3WElWQXhFcDlPeDNSdCtwRkFsSjBaSHFyUzlORm5lWENpd25XV1VQOEpG?=
 =?utf-8?B?TjYxYUdSUzVLZUdIQVk3dGloV1lidVpsVlRCU3crNXhpVDhDNUx0RWhCYkpt?=
 =?utf-8?B?MksxN1ZQQzlLbWlReU1CaDhITjJhYW9zSmFabTl2LzNMOTlhbmVlNlp3NDla?=
 =?utf-8?B?YUIwS2ZxckkvNTRiVjMyTCttRk9EWnU3Q0hXWHpPVnkvWGNnem1pZFhlTjZE?=
 =?utf-8?B?SjFYaTB2d2liTkFKU2NTZXFyQm9HTG4ybFNJanRFMlVWdzlmU0lqQzgrUURS?=
 =?utf-8?B?VmxHNWJoZjYvRW5qbUVYOFdBZVJkdWVOYXZRNmpnOGFLZnNScUE2RVFxK0k4?=
 =?utf-8?B?WUdzTlJwMGxCN00xZzRZRG5renh0K2lOR29SdStvdXJpaHBLOXVoZTBTc284?=
 =?utf-8?B?a3FKYWRmV0JicUJjSzIvUW9vbm5GY2J6dmhmTnMzelFFdyt2OUVBQXh5cGVR?=
 =?utf-8?B?V0JwNTM4WnZKOHRuZGpkdzhVOGc5VDVIbUxMMHVNU0J0NXkzVG1hUC9IcHRE?=
 =?utf-8?B?Mkt1YzhrRDQ2NzFnclRrOUxjc25MbXBxU2pBL0FGMVVnYnFld2RIY1JjOTMx?=
 =?utf-8?B?enRqWkdMczQzSzdldjdZcFFXaGRYczJybGlhSndLc0dJNG42aTczSWtuN3NS?=
 =?utf-8?B?RS9XNkNXNkNrUUZRZHBkTUhkSVB4U0ZHUXM4RW8xTys5YTNlYjZjNUxqZHIz?=
 =?utf-8?B?OTh1VThFaVJKZzV0b2dWbDY5Mk9HVHpoaDFiQ1JNbW5EZDJaelRtbGVhelFh?=
 =?utf-8?B?REhzRnhzWlJsbThJMWlMTjNyKy9jMHhVM1ZwK2ZhM0pzSzVnZzJNQTJMWFpw?=
 =?utf-8?B?UGxwc0c1K3cxTzg2MVpxNER1aDljTkdQMDlWY3hicGpMR1hraFhmU05CdExD?=
 =?utf-8?B?L0xGMkM4OGt3WStzZTBLalZmc1ZpbklvYkRJYWRHM25GZXl4ek1MN01YQllC?=
 =?utf-8?B?bHh3enc2Mm5rRFVha0I5L0phcytOU0ZCaGRaMVhrR2NlaGcvWXhncUVIVFNM?=
 =?utf-8?B?TWE5ZUxNYjNCaGhVajE3YjVLa0JwRVMvUjNkM1U1Vk84MEVITThydkhpNGlh?=
 =?utf-8?B?eTdsSWsxTTdKSDV0cEJMeHpxMzRldHU4QXhDV0RRSDROR3lsK24vcHhqRXRn?=
 =?utf-8?Q?gDDyg/bTtMYhOBrK0DgUh/+ue?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc090c-e123-448b-cf79-08dd61049cb6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 01:24:19.4971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBf0PYuIt8pYtylnpkv0Lc526tAHD1B1UsTzpkupeaA6LCxZl/5ZoTPVjUrQzuplOq+ltGV8BTVhc/HMmFwxMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

On 3/12/25 10:09, Bert Karwatzki wrote:
> Am Mittwoch, dem 12.03.2025 um 09:10 +1100 schrieb Balbir Singh:
>>
>>
>> Thanks, so the issue is specific to the game and running it?
>>
>>>> 3. For some weird reason my kernel does not recongnize the nokaslr cmdline
>>>> parameter, so I build a kernel without CONFIG_RANDOMIZE_BASE and this does NOT
>>>> fix the issue.
>>
>> Can you clarify if you're booting with the compressed image bzImage/vmlinuz or
>> with vmlinux?
> 
> I'm booting vmlinuz images (the kernel is compile via make -j16 bindeb-pkg which
> gives debian packages which I install with dpkg).

Thanks

> 
>>>> 4. Most surprisingly removing CONFIG_PCI_P2PDMA also does NOT fix the issue.
>>>>
>>
>>
>>>
>>> I've done more experimenting regarding 4.:
>>> next-20250307 with "CONFIG_RANDOMIZE_BASE=y" AND "CONFIG_PCI_P2PDMA is not set"
>>> works as expected (i.e. no input lag when stellaris is running)
>>>
>>> next-20250307 with "CONFIG_RANDOMIZE_BASE is not set" AND "CONFIG_PCI_P2PDMA is
>>> not set" also shows the buggy behaviour (i.e. input lag when stellaris is
>>> running) (this was the configuration I tested before)
>>
>> This is an interesting experiment, I am beginning to wonder if the system relies
>> on a reduced direct map for the game to work correctly. Can you also check in this
>> scenario if CONFIG_RANDOMIZE_MEMORY is disabled?
>>
> I'm on it.
> 
>> Can you please share the dmesg
>> 1. output before and after the changes?
>> 2. Do you see any warnings/errors in journalctl or game specific log files?
>> 3. lspci -vvv output before and after the changes?
>>
> 
> My dmesg shows a warning, but this is seems to be unrelated (it's present in
> both the working and non-working case and also in 6.12.17). I have not bisected
> this, yet. I also tried CONFIG_LOCKDEP=y in next-20250307 (with and without the
> revert) and got a warning about a possible deadlock in Networkmanager in both
> cases (also not bisected, yet)
> 
> [ 11.241282] [ T1751] WARNING: CPU: 14 PID: 1751 at mm/util.c:674
> __kvmalloc_node_noprof+0xa2/0xb0
> [   11.241289] [   T1751] Modules linked in: snd_seq_dummy snd_hrtimer
> snd_seq_midi snd_seq_midi_event snd_seq rfcomm bnep nls_ascii nls_cp437 vfat fat
> snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component
> btusb snd_hda_codec_hdmi btrtl btintel btbcm btmtk snd_hda_intel snd_usb_audio
> snd_intel_dspcfg uvcvideo snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn
> snd_usbmidi_lib snd_hda_codec videobuf2_vmalloc snd_ump videobuf2_memops uvc
> bluetooth snd_soc_core videobuf2_v4l2 snd_hwdep snd_hda_core snd_rawmidi
> videodev snd_seq_device snd_pcm_oss snd_mixer_oss snd_rn_pci_acp3x snd_pcm
> snd_acp_config videobuf2_common msi_wmi snd_soc_acpi ecdh_generic ecc mc
> sparse_keymap edac_mce_amd snd_timer wmi_bmof k10temp snd snd_pci_acp3x ccp
> soundcore ac battery button joydev hid_sensor_als hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_trigger
> amd_pmc industrialio_triggered_buffer kfifo_buf industrialio evdev
> hid_sensor_iio_common mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76
> [   11.241354] [   T1751]  mac80211 libarc4 cfg80211 rfkill msr fuse
> nvme_fabrics efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 amdgpu
> usbhid amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched
> xhci_pci drm_suballoc_helper drm_panel_backlight_quirks xhci_hcd cec
> hid_sensor_hub hid_multitouch mfd_core drm_buddy hid_generic drm_display_helper
> usbcore i2c_hid_acpi psmouse nvme amd_sfh i2c_hid drm_kms_helper serio_raw hid
> nvme_core r8169 i2c_piix4 usb_common i2c_smbus crc16 i2c_designware_platform
> i2c_designware_core
> [   11.241391] [   T1751] CPU: 14 UID: 1000 PID: 1751 Comm: gst-plugin-scan Not
> tainted 6.14.0-rc6-nop2pdma #559
> [   11.241394] [   T1751] Hardware name: Micro-Star International Co., Ltd.
> Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
> [   11.241396] [   T1751] RIP: 0010:__kvmalloc_node_noprof+0xa2/0xb0
> [   11.241400] [   T1751] Code: 00 49 b9 63 01 00 00 00 00 00 80 68 00 04 00 00
> 4c 23 0d 79 0d ea 00 48 01 d1 e8 c9 af 03 00 48 83 c4 18 eb 9a 80 e7 20 75 95
> <0f> 0b eb 91 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> [   11.241402] [   T1751] RSP: 0018:ffffa32dc63abcc0 EFLAGS: 00010246
> [   11.241403] [   T1751] RAX: 0000000000000000 RBX: 00000000000000c0 RCX:
> 0000000000000000
> [   11.241405] [   T1751] RDX: 0000000000000000 RSI: 0000000000000017 RDI:
> 0000000000052cc0
> [   11.241406] [   T1751] RBP: 00000005c2980d00 R08: ffffa32dc63abe00 R09:
> ffffa32dc63abe10
> [   11.241407] [   T1751] R10: 0000000000000018 R11: 0000000000000000 R12:
> 00000000ffffffff
> [   11.241408] [   T1751] R13: ffff8c7e8d480010 R14: 00000005c2980d00 R15:
> ffffa32dc63abd28
> [   11.241410] [   T1751] FS:  00007fc1f34ed680(0000) GS:ffff8c8d2e780000(0000)
> knlGS:0000000000000000
> [   11.241412] [   T1751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.241413] [   T1751] CR2: 00007fc1e0e2850b CR3: 00000002a28b8000 CR4:
> 0000000000750ef0
> [   11.241414] [   T1751] PKRU: 55555554
> [   11.241415] [   T1751] Call Trace:
> [   11.241417] [   T1751]  <TASK>
> [   11.241419] [   T1751]  ? __warn.cold+0x90/0x9e
> [   11.241423] [   T1751]  ? __kvmalloc_node_noprof+0xa2/0xb0
> [   11.241426] [   T1751]  ? report_bug+0xfa/0x140
> [   11.241430] [   T1751]  ? handle_bug+0x53/0x90
> [   11.241432] [   T1751]  ? exc_invalid_op+0x17/0x70
> [   11.241435] [   T1751]  ? asm_exc_invalid_op+0x1a/0x20
> [   11.241438] [   T1751]  ? __kvmalloc_node_noprof+0xa2/0xb0
> [   11.241442] [   T1751]  amdgpu_bo_create_list_entry_array+0x38/0x150 [amdgpu]
> [   11.241810] [   T1751]  ? rt_spin_unlock+0x12/0x40
> [   11.241815] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   11.241821] [   T1751]  amdgpu_bo_list_ioctl+0x47/0x340 [amdgpu]
> [   11.242282] [   T1751]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
> [   11.242622] [   T1751]  drm_ioctl_kernel+0xa3/0xf0
> [   11.242627] [   T1751]  drm_ioctl+0x25e/0x4e0
> [   11.242630] [   T1751]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
> [   11.242930] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   11.242934] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   11.242936] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   11.242938] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   11.242941] [   T1751]  amdgpu_drm_ioctl+0x46/0x80 [amdgpu]
> [   11.243238] [   T1751]  __x64_sys_ioctl+0x92/0xc0
> [   11.243244] [   T1751]  do_syscall_64+0x5f/0x1a0
> [   11.243249] [   T1751]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   11.243253] [   T1751] RIP: 0033:0x7fc1f381c8db
> [   11.243255] [   T1751] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05
> <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [   11.243257] [   T1751] RSP: 002b:00007ffcb8530080 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [   11.243260] [   T1751] RAX: ffffffffffffffda RBX: 0000564fd56bc7a0 RCX:
> 00007fc1f381c8db
> [   11.243261] [   T1751] RDX: 00007ffcb8530130 RSI: 00000000c0106443 RDI:
> 0000000000000006
> [   11.243262] [   T1751] RBP: 00007ffcb8530130 R08: 0000000000000000 R09:
> 0000000000000000
> [   11.243263] [   T1751] R10: 000000000000002b R11: 0000000000000246 R12:
> 00000000c0106443
> [   11.243265] [   T1751] R13: 0000000000000006 R14: 00007ffcb85301a0 R15:
> 0000564fd56bc7b8
> [   11.243269] [   T1751]  </TASK>
> [   11.243270] [   T1751] ---[ end trace 0000000000000000 ]---
> 
> 

This warning indicates that a kvmalloc() was requested with a size > INT_MAX and
failed (NULL was returned)

>>
>>>
>>> As a sidenote, I've tested several kernel with nokaslr as command line parameter
>>> (6.1.128, 6.8.12, 6.12.17 (the debian sid distributional kernel)) and nokaslr is
>>> not recognized as a command line parameter in any of them
>>>
>>
>> Please see my comment above about booting. How did you check if nokaslr is being
>> recognized, is it via looking up dmesg?
>>
> When I boot with nokaslr I get the following messages in dmesg
> [    T0] Unknown kernel command line parameters "nokaslr
> BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc5-next-20250307-master", will be passed to
> user space.
> 
> This also happens when I use the debian kernel with standard .config

That is quite strange, I can see nokaslr handling in choose_random_location() in
arch/x86/boot/compressed/kaslr.c (which depends on CONFIG_RANDOMIZE_BASE)

Thanks,
Balbir

