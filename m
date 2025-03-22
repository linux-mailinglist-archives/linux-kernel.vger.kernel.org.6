Return-Path: <linux-kernel+bounces-572299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDFEA6C8D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BD13BEA11
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145531EFF9F;
	Sat, 22 Mar 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngxlh5LW"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07741EFFA7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742636456; cv=fail; b=K5r36FJaJZQ6Qam52Ax5fLW9hvRAEAT9n14dNlbP8tflp4yiVTAc0/2nk+yEhDI/qaqJlDniE1ECbutGo/GE9Izqk6YA+UJqbbsQpEg8QwKW0qNvJ7bHCCOjeOcAvwcOI1a8L1gKw/87DB/OOIYe+76ke8lc756kWiEMbQUME+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742636456; c=relaxed/simple;
	bh=dLMfqHRGTFfkqSXNhm0ykyqbu3v1sNPKygmAsKHQntc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IzOMKLBHwyfxg4PkvdKabbGY5iQ9VnrhYVJpESE440RbvwzMfC4g+Q++JRrNKYl7+W0FKXo6FNlRegc0h57KOicQL2fVRH++52ZG+9dKNbq6YEM0U5VedT4EVIRfU7JI38aQSswjoMxURe3Jsn/PL/oo9hoGSD0ZInBGk9lBkE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngxlh5LW; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcsBnozWDpxEUs5j103OsTroPSCKydc8gpQnnHUZGbsA3kQ1mASTYvTUCokwecHSELCMqe5MEKwSWK+5gT3X4lrT1EzC5Q2B1cn5slkoX07MFDxauG8IgldNWMKG6SZOvuW4l7IZgTL6IyPecgaw2LjrCRdVBHVS2jagPVWVc5ksuJWsd0/gUX+4ZEcumCA2EmHbLYZ2Z7zPYdJawEuxPb+eXhbgK/FKTbaT/qeeTMrN/WBbP62nABISvXAD4+7Y2q5RS9s8SvcfXggkIi2xz7tJjQSWqMPlYFKbqdQePSNehdFzI2AfMvPMKtxOtYYFB7rvQ5GNlwTFd6EzZCbIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBoiOA9nN13LijUSMbEblDkYI4Di9VugkttDny5BJxc=;
 b=qsH11iTuCG9/Zp/DN0ra+WU8HfhTn1JKi3Y6EED/5PGH5zkNp+wYoldo3C8ZOEEaDK3wMaI0YG407OYp+AighGziIoff/IWvOFyae5/rbUGCXMQGgbGUKZe/y+0GeGaZYh/6jkQCqpBBhEAUfDTlOQs0HHt/gEl4gvEWCg2oL3u8Okm4FIHJ0VxM74YMxeO8HT6VGsWbq9EF9fCKVy+w0FO0V7PvLh3YPsan5O9+Wyp2MDCJB0LlUyMggVmNDCYM6O85FMUo1W+hytMK2KM3VuqPKKAh9qIX/eVUJwG/wQC0PKVZtVMGvEr5rY644GHzbHygxvh+9xUNSG3/vuAtrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBoiOA9nN13LijUSMbEblDkYI4Di9VugkttDny5BJxc=;
 b=ngxlh5LWSdBwyA+/nZVK0qVA25+aQpK9u1zql9weDu9+F99qMt1tfMNJY/Arsy8+6DzNLA2zcFH1gI4etnNvecxIfBIgTsiCjXW9jfTVy9RAAfXNtqD7p9rUbOJZS7F4s2MJ1vGfMMQtU1r43syGDtRklygeh/6zXTK1LAhztRio5ZdBRIrmYP/XQvbbxu/fpKHq07rqYIcgAkx2ynipcekQ1VicCcRjo8t5dbBVCil1CU9qgZ9XFqL/tN3E/vo2DO5OmDc3zY5ap0N3eldLWVBH4s0CkPKCfAP0X1h/SSNQbR46u46h66EovnV7B/cAcIcNIhK+bwIYuZiSoHTv/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 09:40:50 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Sat, 22 Mar 2025
 09:40:50 +0000
Message-ID: <3525a85e-2890-4447-bffe-b7c2f4f2fa2f@nvidia.com>
Date: Sat, 22 Mar 2025 20:40:45 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Ingo Molnar <mingo@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <Z9vZYIbXOz2wF59j@gmail.com>
 <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>
 <Z90-VOyC5oanCC8z@gmail.com>
 <01414c31-82c8-4de7-920f-87020610580b@nvidia.com>
 <Z95vAzzNOlXvZeJH@gmail.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <Z95vAzzNOlXvZeJH@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c75bad-e090-46e7-286a-08dd6925a182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzhoQWpJYzBpOUpnVHF4S2htWGpob05HbDJpSVNMZ04vQTh3Nm5xcEhXVXh5?=
 =?utf-8?B?ZTRWOU8zS0ZtQitlRC9VejVROUpkNEE1QnMxQ1prUDZqNTNOL0FGSjZOSURV?=
 =?utf-8?B?TEFOWCtvVzkwL0Zxd2VrZWlxdlZiOE15TmVCSTBiTGxpeTY1MU1pMUY1WWk1?=
 =?utf-8?B?MWEydGtCWWtjRUZCUy95ajBrcmxLVlA3OVk1VERvQmhHRTI1NENuYjNMa01n?=
 =?utf-8?B?c0NJcVViVXQrYXRWdHNVQzgrb1dKOHFnVkYwcHlwR3JGejBFUVhZKzhMSTd1?=
 =?utf-8?B?SnZHNUQ2WGV2dXhTaDdnK3BudWRhUDRJL2pWYUVxckwxS0VPR0ZHNkZwVXdi?=
 =?utf-8?B?dStEbS9TYzBUanM3OEg0VGtRZXA1Y0gza1YyaTJGTnVFb1pIQWRSVjVMQXQr?=
 =?utf-8?B?L3NOUzY1NDJNVlYwM3E3ejBtY3lkVlZyL2FlQjd3eVZNQXRjbktyVVhXSjUv?=
 =?utf-8?B?YjRHZm5aeGNmcEZld2J2L3c4Vm5UWTBsTW9BRHpHd0RpU1ZKWkpKcjcvNElB?=
 =?utf-8?B?Ym1uRWg2b2hWMWRqeG5iOU1FSzdIYTI5cVNCdEJ3NzRtbVVhZnVwa1RmVWYw?=
 =?utf-8?B?Y2xSWnM4dEd1cGpqQ2NYMlBxUU16UGJmbDRzeVRST3JueVEvdndGNXAxZEpJ?=
 =?utf-8?B?SSt1Y2RrT0pPR1Z4ZzdoSW1uMVFnODdYSXgyK1VyL2RqZVlVSmlFd0xTdG5q?=
 =?utf-8?B?dXFsNGFHdXFpQjdtbUJJUE1hNi82WEdjSS82cFRvSTJTelhoamYxWGFyQ0ls?=
 =?utf-8?B?RGdveDNUQ1laREFhcWVUbkdtTmFHYS9qYldEUkdhWDU3SXh1a3BLRjZKV2F5?=
 =?utf-8?B?djhGSU5WQ09Za3YvTTF6SGFGYVF5SEVtOWQ5MndaVTlmUDVvMkFhc3BWR0xM?=
 =?utf-8?B?dkl5RnRpS3hVajROYlZ5cEx0RzJwVFQwallSWHNjQ05DU3d6RjIxYjJDRTlO?=
 =?utf-8?B?WlJEMU1GSGpuc2svbGZVaGhwamdJenJqaGcvN2RNMS9KNXI2WStVOXFGZmZR?=
 =?utf-8?B?MkU1Z0t5dGhkaldMblNjQnFIR3l2aFpIbyt0NFNkQWtPYnFEQjYrVS9qYzZS?=
 =?utf-8?B?QTNCOWdRT1F0RWVmU3VVR0FCWnlrVVpmR0YzWXNXdU9oWFFVTk1tcm5SWFo5?=
 =?utf-8?B?Q3VRMkJpcWc2YkpLaHJNVjVib0o4bEhaUEhMNlQ4MW5leWN4VlkvYi9GYjBq?=
 =?utf-8?B?SXhrVDBkZGc0TEMweTlNaEt1TXFDWDhNUnlxU1NQa0k3UGk1eEJZYURkenJL?=
 =?utf-8?B?WFYrUmV0blNxOE1qMU1QS1lxd0hQWngvMzhhWFY0bjRidW9NTjgwWjRwUWNo?=
 =?utf-8?B?VU1iNS9jcHVJQ0FvOVdDQTVZUnlFdHVWYkllOUJTWWFzK3ZYV2xPaEhHd29R?=
 =?utf-8?B?SlU4b1N4eXNyM3dmaFdkTGs2VVFZdjg5V0RMU1RRZmVLNmkxTUYyanZZNGpp?=
 =?utf-8?B?VHFOaXg4dVQzZjZYNzkwV2RFSTlwbUlZZmlndXdkVE1Cc3NxdFJoSTI3Y1FR?=
 =?utf-8?B?Z2tIcDYxbGVlMW0zOGREOUVnRHE4aStEVmFESFBmSDVsN0ZqVG9IbzJFSzd6?=
 =?utf-8?B?QnNqeDBkalEzUkFqY0ZHZDNlZ3pmOW1Zdk9yL3NpQkY2TzA5YWZ2TFFlb0RT?=
 =?utf-8?B?NDBYWWpnQUhYWU5lajFYSlJQV1FwZ2NjaDI3MGMzekdKTnV6VURLcUFsN21T?=
 =?utf-8?B?RnQwNmt3NDBvU1lscmxkMWZ5bWVnWHFnUVZ2aUI0TXVRbG5keVozK3ozNUxj?=
 =?utf-8?B?ajBVUVNvTndMMDJDazczQWJlaXNPb1B2Q3Q3b3R6Q29OUkwvMmxJZUpWYUd3?=
 =?utf-8?B?cTZzNkNmZndHZnNmdkJQc09YRXV4NzQ1QTExdlE1UHh5NlpvQXh0eE1Ec0gx?=
 =?utf-8?B?dVBtaEpKSG5UVTFzeVgwa2VoR2RhOVhXVWtxVnE4SU1LNmU3Skd0WHZKWnR3?=
 =?utf-8?Q?F3HHF319Hzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFZJRkJZa3BKR3hGeFJMZlVuVXg0T2FXNkdsZ1VxRzVUUTZscG1aU1J6bXpE?=
 =?utf-8?B?YjhFbzhQN3lQT1VkaFk5QUZobDBYNHlYTWhvdytkRW9kQWxOei9EekNpSnlP?=
 =?utf-8?B?aDJOWUc0NkpKQkxMd1J3cm4yUlUxRUZxM1lyUkpldzQyYTE5azhoZkxvdEsy?=
 =?utf-8?B?bXJGa2RCdFV3U3pPM0ZSa0hZVWV0aFNxSWZ0dGNSTjVRcHFZMEtpOHc1YXNT?=
 =?utf-8?B?c0xPVGJZNGhwQmR3aVpzZk1BRHh3eWJnMitsTGdjcElDRk5jcS96SEsyeWd5?=
 =?utf-8?B?M1F5RUtZdG1od0hCS3cxelVtcWJ2b01LOThVZDd3VlVwNDErYVRTdEcrd243?=
 =?utf-8?B?a1I2TlZqWlNOQ2lBd2JyYXNWcHVGMm9vcVhKODRRQ3NMeEpCUGZSUUNJYTEv?=
 =?utf-8?B?TVJ5L01NYlo2NkljVTJNZVZjMFJ1SDFwQ0U4MWwyWElZc0tjYUdHb0xpTFJl?=
 =?utf-8?B?QlZqbW9LVENHQVBNb2diSXdXeEJoWEVQVWdXZ25SbXlNYVFxcFRkL0ppaENj?=
 =?utf-8?B?NGQ4NUJZbnNRTnBkc0lDRGpYSis2dTNML0NNWm9qelhncjY3d05NRzFNbDhm?=
 =?utf-8?B?RzBxUVVsOGVzZlZxcjczcGJLc2FkcGhzaDk3V2dnRXFJM1Zld1gxL3hvb1Bs?=
 =?utf-8?B?YlJydHRBaS9udGdYYkhTNzVxYW5hVVczakJ1V1BpK1RjNDlJamdLU3hPU083?=
 =?utf-8?B?aWhsb25Id3RuRmRFVGFreEFKdXd1SHNXRmltTkJTamYwKzN5bU02Tno2T0Fq?=
 =?utf-8?B?TFdheGltK2VzL2FydEhvRTg2WnY4NSswb2F6Y0hiLzh6cldVdUVtWktIMUVk?=
 =?utf-8?B?TDJTa1h2VXF0cFppQ2s5TFhXUWVHSWVKNm5oQVZva3hCNUszdWhmbG1xTmM4?=
 =?utf-8?B?c294YzNOSnVocGtKblVzd2NZdWxQbXVuVFFYQ3VidlFpbGtYUVN5c0VqeW9B?=
 =?utf-8?B?ZWlaUWtQMm1WVEJTMkg4NHhmdHZCTmJUOTlTLzd0ZEhjdFVITnVnVmloOGNx?=
 =?utf-8?B?U1g1My9uMXRacHpvWUdJYW5xWjF0WjVnWDcvWmZqUE1QZ3I2OXRzdEcyVjhh?=
 =?utf-8?B?N2MzT3J1akI3cnF4Nnl0WkM5eWtWSWk0dmxYZ3NNRmNDWGVOWXBzUG81Wngw?=
 =?utf-8?B?ajROZHhjZWZadHJwbDgvb0M2WWh5TXdBSUhGYndvTjNsYnVkdy9NNGtpV2o2?=
 =?utf-8?B?ekp6TEMrYnJXZElhNmpUZDNRbm1LNGM2QnhseW91a0lodkpRNDY5cjNkeUJw?=
 =?utf-8?B?SHVXN1NndDlWOG1yTEZBdzlVeGtPNFQyQTNWRHBWNm1PSFlYMHZLQ2FBM282?=
 =?utf-8?B?UlAxamRpR0lyUktxcG1CYy9PQnZMRVVjSVB5WG0wVC9JM3F1ZUNCb0dCbnRn?=
 =?utf-8?B?V2dWaWZnYUNJNmN0bGg1NDE1cExxT0s4MVpBQTVMQ2F5ZmdMcnBYVERHRCtS?=
 =?utf-8?B?cTFjNFlLbWRDWCtPaUhRV0o4NjA3TGhSNi9rcDR2cHVBbWxybHVSSUxQVHpH?=
 =?utf-8?B?WTFFRkZNM3o2dWxNU0JBeXMrMEVMdlBuSUZjVktNbU1KOStUZ1cvbHpCQWZp?=
 =?utf-8?B?Vk9pQm45YlFLRXlYalVHcVp6cVNldVcxMUIxWVZwVlREdTNPbHprMUYyQWZ4?=
 =?utf-8?B?b3Y5L1QxWFNjdUwyMVV4NEllNFE0bWk5WTlsaVdBVTcxbndOWDlKTmgwUU5O?=
 =?utf-8?B?dk9aMEZBd1AxZVVLUHVCdFd5YXNaUGgzV0M5SjE2TmUwOFdjSkF3RzY3Y1V1?=
 =?utf-8?B?RHNBV1l6YzM2V004R1JGTGRnc1M0dXRYSlNVb0h0NzNSSk9UdlJrY2gyMFBT?=
 =?utf-8?B?UEY5MzlMb0M0YjRuUzYwVzJqVnU2WHlFR0V6WDBXMFFtOEsvQ1hPTWVlSDA3?=
 =?utf-8?B?cHFCbmN3dllRSHE3clR0WGNJY1ViZFdSeHBuaUJiV0lsZHVxemVOZCt6MXph?=
 =?utf-8?B?UDkvQVlERzYxV3FFVFY2UWZCTzZEM2wvVUVKVUV4aUFXM0xYYW9wZHdEWm94?=
 =?utf-8?B?dlJLVzNtWXdmODljZzA4UWt1cVZZSXM1OGZ1dVBGaWVIT2MwZDFTdXFmdTVs?=
 =?utf-8?B?VHJxYW9EY0w0ajNFNXB0YzJTT3g4U1I5b1RrY2dKS1NDM3JqS1FTZmE4RC9m?=
 =?utf-8?Q?d7dPEZ231p9N0Yu8EIO66dCiV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c75bad-e090-46e7-286a-08dd6925a182
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 09:40:50.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDbaC78IFCIQuk/jFT6de+ZDFpNSOgtkNqNnpuSWW+WTlKQFXWN1UpvocbBmst0XdDka/qifdt7xWBrGal3IQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

On 3/22/25 19:04, Ingo Molnar wrote:
> 
> * Balbir Singh <balbirs@nvidia.com> wrote:
> 
>>> How frequently does this happen and what is the impact to users if 
>>> this happens?
>>
>> It happens a 100% of the time when the BAR space lies beyond the 
>> 10TiB region.
> 
> And how frequently is the BAR space beyond the 10TiB region, on modern 
> systems?
> 

In my case a 100% of the time on the system(s) I used to have
access to. 

Balbir Singh

