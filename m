Return-Path: <linux-kernel+bounces-542682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78FA4CC60
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D317A6ADA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B3215040;
	Mon,  3 Mar 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cLLDJfzR"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020092.outbound.protection.outlook.com [52.101.189.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DF1DDA3C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032103; cv=fail; b=NT31zfKZXi37sHLRyAdsMPmp073pvnzlVviGlZ+3VO8CXAEcqiGOruFI/lIDIJlAlWOuhZSwEk7h9++TAYrcEmpZTIUJKtx32vlZA4QjIMJkMNksdkI6ZaF/3AzL0yQ36mI3pUIrPSymZUwwhGdRCX4aW28hEAjZyxD2uOG4Ax8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032103; c=relaxed/simple;
	bh=73OJBYUHxRLDu72rtiwT6CDFKtBdpQH0AG8wwtWZywc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WPk44xlLoNalDeHQZKEOtajZsfYyT67cwVvFGQOLJI0llwjl89SFmfdZjS3SaOZXazwMfm7einT5gRMpyXD53w1wr40g44YnKiEUvnIcb71Cdt91oHwNz5qPLdgzjpe00VfaAhpifgmXHoAViZFG2mvrZFgRaXMPwQFbiu8rDDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cLLDJfzR; arc=fail smtp.client-ip=52.101.189.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diqVRI6dame7obgb3qco1atwofTXIZ9ggwk/CmhiC+boe9qJH6Dy3zlZ7t28XC2mZ/kM3x7ZssZHhrUxxPg7NzHrjK4bAwl1zPAYbxQj+FaOl/guFnLb0UpA0PRvJ32pv7LmhsKZzMqhvzuC6h+P24frsg2rzun1Q+MZatyaVJNGcJJFDXMCxN+hV0HlF9Y2U4JqGFoP/c1yXSJuRjtuypx+DirddkVzSFQTggp5uL2EFwx2lx/3fkRrfs3IFrH+c2VO8mFlkHbbBIpPRdKPrrq3+aaQ9gawjJNBauEoqkF2cUJWNUMG+HkkHyMODD6JcTG2qRkB//s6qaPXckVPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8T8FI7QLcP638NME+CebIdTbzuaiiCRM+EtJyKYxR4=;
 b=iNrzqWTtFszRqzvxDIrj+huya5YtsRlX+z0Xb4L6UTtkcDJrN2BgCzvkTulZjzq8S0jMvX9398f6WxQbIVeIgk60vWRcEDQT3YGZxfiwj1Bqqhi7A8Tjzz8gSTihCuV1R438j+K+2QF3qqD7p1EED7RPRY/dubbCalQHPsR9sQ7F3tKmOimM8J+hxWJzfvfcqZ2nhq1SQk/bo45CEEASOBWEyhswojcJzr/QjX/gCmqlMqjJxKuUDNxpjPltnRIzlw7BWTEYZRFNVyZS0XqRDeZ6eJd82qotfcyMoQ62+xxMioBUuH9Od9BSb0pRlSX6LQbR8a4dJWKeuznxGmNRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8T8FI7QLcP638NME+CebIdTbzuaiiCRM+EtJyKYxR4=;
 b=cLLDJfzRHg1zQTT/Bwv47Lod+1GtTj4kecR+AN4pToYzwE1fIGpeOAhwtqCzArMxW+pHMjTr5ILRlrWp0jGxU/mWXrVUXnqetTOSvRQR73UOs6WwtcCjDRHRRhj/A6P2SsD+13TGUiVqOGhkKJ1AGmZcfmAvR1h+66oNssAe6hrNRdtaTke8CMAeeTSLaYGiBtPFsa9fHEi0hFtHAh+3yJWTwLrqTpWA7ELXw03r6vOJJjksmPGTpcnN3v+VnVFm/UHy6wkFrulS33qA/XNn0KjsTsKEZvZ2R+IzDkbbmo3NS9uiJ2O6HZmailuv6ps1LW/R9kg+plWwy1Eyd9uAaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFCDDFAB0A7.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::589) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 20:01:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 20:01:39 +0000
Message-ID: <72810548-b917-49b7-b7ef-043c6b395d31@efficios.com>
Date: Mon, 3 Mar 2025 15:01:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Peter Xu <peterx@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
 <60f148db-7586-4154-a909-d433bad39794@efficios.com>
 <Z8I5iU6y_nVmCZk6@x1.local>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Z8I5iU6y_nVmCZk6@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFCDDFAB0A7:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1d4eaa-fb92-433e-d52b-08dd5a8e35c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEJnNTJtRjR3YkNFK2RhUm5LWVpsblRVU1Jyd1NsQnRFaTVSeldYei9vd2ov?=
 =?utf-8?B?SlVwOEk3UjM4ODBab2lVR3pnUzBXR0hvMlAweERJTlZpRXE0V2ZsRG5xODcw?=
 =?utf-8?B?STJQV1pxZ1UrenhvZXI2MWpNQ3IrMnNOLzUxQWlySFkyR2xyZHNkUUVmWWxV?=
 =?utf-8?B?YWl3V3JvVDBxNGsraXZiN2ZWTUc5OGdsT1RWUVZBME5LMzc0M2FzcDZ4UFVx?=
 =?utf-8?B?Y1RhZTk0QmZWeUZnemcwR0ZndVJCRGUyUmRvNkswRWZ1YWs3ajljUk93SXlL?=
 =?utf-8?B?WW5CaUhZTnAyKzdLSVQ4d3c3a2FVZFFuejZEV1ZENk9SZVFoVUlVRHJuc0tw?=
 =?utf-8?B?OENEM2dXM0pyUUt5bXFkSXlsUXhTeGVjYTQxWmtZTjE5eGZtWnJKejF5MTJs?=
 =?utf-8?B?amFJVUtYWCsyK01uejVHcU1iTDRKZTJ1WHYzTHE3UkNHUUlOV1p1a0Z2V3hn?=
 =?utf-8?B?ZlJra25rZWVGOXdDMFNPbHdVQlBZM0t0amJBWWYrblZKc2ZvQUgzL1Rmd20y?=
 =?utf-8?B?cTNMbkw4bmxsOER1Z1p3TFFHL3lMS1VqNWlWd2xKVXkralFqZHV3UkVGUjFz?=
 =?utf-8?B?dCtrbFkyU2dGVzhEZmJwam5ZRHRiV1RldUhoUENHcStqc0xiWFJUZHJESUo0?=
 =?utf-8?B?L0JCV1Q3dE5aWWJrb3Y5b2orVHRiZ0xBbVUvbGx2eDdBTC8wYWROdVRCK3lC?=
 =?utf-8?B?VThEeTR2Wk9xcVBsSnl1bFpwd0N4V1p4Mm1ON2ZmMHFpV3ZpVGlkVU1WVkhp?=
 =?utf-8?B?dVduS0RWOFVOdE80VW56OURHMXR5RUljWnkrUHZkbUlvNlhLSFQreElXcnFW?=
 =?utf-8?B?ZTNaQ055NzNrQUcwNHVSUlNSMnFhNmRKTXZkN0IxWTJJazhBc0JKaGUvMnZK?=
 =?utf-8?B?SmNaSVhJM0FwZGR6YUpTb0MvajNDd0lxdUNnREZCTVlLeGhFWm5sOUJFMUtI?=
 =?utf-8?B?UWlNZkdrNWp0ZkVHSzlTS3A0WU9WclNEdDB1R2FtZVZkY2dzVmRZV2VOMCta?=
 =?utf-8?B?bUNzbHpXNXQzWkpCME9NNldBNTNHbGhlS1JuZmhFQ1dWNURvckxaNmozTFVu?=
 =?utf-8?B?UFVFWGNkZGdqN1dKQXJ5Ync4ZUY2elhUaUZmZHVqK3Erc2VmTnB2QWF2Wklt?=
 =?utf-8?B?UFlrWGpjdjdTSUhlVUdodS9LSk9BQnNnTmhZaEdsUXkrdEs5L1ZDaEtUVU5k?=
 =?utf-8?B?NEp0U2pFS2tBalR5eUpVUjArZUlXZWdqNXhlK3YvL04vNXNkMFVMK1JRaFM1?=
 =?utf-8?B?RXB1Tk9wNVh0VFBMUmJTNVdlTExXK3hJVkpyM2VxUm1Yd05KYzkrZk1NaGZh?=
 =?utf-8?B?Sis1QXArWlpRQ0s4cFJORkZYeXFoMUFlVlIyRk42T0ZYZTdTQzlwUFVpeGVL?=
 =?utf-8?B?b3I0c09jc1RGL3FrTVQxZjZhZk9rK09CZStXZkJ6TUh2NitKU2hGWHMxYUdq?=
 =?utf-8?B?RFhxdHRwcG45Y0dWTWxyN1VuMElhZFFUTDVLZG1xZDR6SWU3MkI1ekVNVVFw?=
 =?utf-8?B?Z2tWZ3JDakdsazBQSzlod0JrTGV4UCtlbGtHZ0JnbDgvTlgrUmZaY1ppT2RD?=
 =?utf-8?B?ai83N1JuQnA3SUNuY1pRVW9FaE5PSUtZZkQvZWp1VW9vbExpQUVMeDk5VDZ0?=
 =?utf-8?B?elEyR2M0L3RTYnhUZGJQS2FZdFRKZXJ3N3ZQM01SNnIwcTBnZ0gzNHhoK1Zo?=
 =?utf-8?B?RmdoY1ZRVEJkMjN3R2pNNUZjellKZyszaWNWejZWWitKRy9YNEdJMGxLZ1Az?=
 =?utf-8?Q?6z8x9IWBSb9FsMSM7eD+/Up6PUiap+Fdtgmcaf0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFAyYnFTOHI1alZhZy95ZlpqMnZqZDc4dUJWZHk2WStWZnlxU3hIdW1qbUE1?=
 =?utf-8?B?Tng5Wk8zejRiR1drYk1EQU1KOEw0NnBVc0dOdHNjU0U2QlErZmZkWlFIRmlx?=
 =?utf-8?B?ZW4yTk9DRTJpdVdZMmpZTEYvdTdHSGV6d2NrNlRBczBQOFVZam5lSUlyQnZ1?=
 =?utf-8?B?TDRkTktMUlNFYmgyYTlpSUs3VVh2bTZJcVVSdW9uRE5CV3NZTXVVUy9KcnNM?=
 =?utf-8?B?WkN1dk1kclArSkg3UTRnYlUxTklvcEtycFVvUDJLR3ZrcldvUGpwcFdDNGt6?=
 =?utf-8?B?UFpoOVpOL0htQ05XenpEV3RkM0M2UW9kMDJGRnBsSy82WTV0YnJhVVJiWDBY?=
 =?utf-8?B?eEZPL01ybk93aFc4NEViZHRGTVdBTVR6T05NOFVKVi94UGk1czlVTlJBQWVG?=
 =?utf-8?B?bGRnNUJ3bGRwZzRubVpIK0FXYWE2c21JL01XTDhVZElvcmtlZm9NeC9JanUz?=
 =?utf-8?B?VlZ1dTljY3NlOGw2eDF1QTJ4d3M5VVBEbVRJOGZjWndTRzNrOHkyZ3dST2Fu?=
 =?utf-8?B?N2NyUldLSm9DVjBXcll3dGhzR3p1TER5Vjhpc2NONVF6ekRRdzBCZk1UaE5U?=
 =?utf-8?B?WmZMc1RBb2RvcFd6VWlmZ1QvdEdSMTZ4T1FQeDNaQkxjOXV1K1VEYm9VWEhD?=
 =?utf-8?B?NmYzbTVjWFhPYjl3ajMwamkxNDB3TmZTa0dhL1JhVkc5d1dlOTRCUGE4L0ZX?=
 =?utf-8?B?YW83UVIxZkp1b296Ymx0T2cxbU0yNXd5SGxqNFVYbEF3NGl3ZnU0M1Y3S3lK?=
 =?utf-8?B?bmsza0czQUJFU3o2b3g5SXRIVnRtelYySDhkUXdPQWlveTEvak9uMkNDY2hJ?=
 =?utf-8?B?aDVtcVpxMkNzUk5oZXBmcHhpclMrQ0VyeE1LdVNtVlpnMFlmdldwcGhhZitW?=
 =?utf-8?B?T0hhamQ0QkZhUFE4Q3lpd2w4WWJ5WmhVWkRBYlZzZWorYXNibVcxZVhDVkdS?=
 =?utf-8?B?a0dMMDFUV3JNL21TMVZVTGIrUlJTMHMzbzk5L3V0TDVZSDA4d0tTdzBEQjVX?=
 =?utf-8?B?cHhVemZzcGtUbC9rRVZQVDN4UVZWeFpUK3ZicElraGR4WmNJTGxDSS8vUlRu?=
 =?utf-8?B?djQ3aUNLNm1vNUlmaS85TlFJSHRBbkp2SUpibkNraHRCYUpja1AwWmRHS0FC?=
 =?utf-8?B?MWlheDJES0lFaWxEa3ZaN1k3b1pxWWFYMzlsdmNPQVhvYWQvQ3RKZ1VVWitp?=
 =?utf-8?B?ZktxZVQ0MUVCQkliMmpTZm5rMGQ0anRudEtQdll3WldjdDRaLzVWZHovWkIy?=
 =?utf-8?B?eGJaNmJFREUrbEY5QmZCbUZGWDdUZy9tSEU4Vi9aN09XNWtJQTFzWTRSQXUz?=
 =?utf-8?B?QXVZSEwvK3dGTzVDSkpyR2pkVTR5blYyU3c3Qi9BTi8zZFFLbm1vdjFDbjV1?=
 =?utf-8?B?bzBLWXdmREw0ZUd1N3JvcWc5c2tUSlhVeUd6YmdieC9FRDFaa2lHYnd4bGJD?=
 =?utf-8?B?aC9ZcFQ2aXZCanBwSjNZZWcvZUsvNTREUHlLMSttVUJBa2I0eE9UK1Z3Z0s2?=
 =?utf-8?B?SlQxdGpHNGRYV2E0MTgvQmh1UUx0M0cyRFVrb2dOc1dsdnAzMmVqdVN0bEt0?=
 =?utf-8?B?T0oybEllQ0VpdTJYRDcwdEQ2RmM0WHZHMG5Qa1EyMUtLZWRzOFJEbnVpZm5M?=
 =?utf-8?B?cVJNQkdzcU9Fd3QzSXhLYzl5dXI1cWQ4b01JY3RISWxYWUtUazZVMnVNSWJ4?=
 =?utf-8?B?eXB0TDE2N2NhME5pczdqTFJrTjZEclNNMHdYNTFHODlRRzJUd242M29TK0FL?=
 =?utf-8?B?bWhXazJSbVI4aTZudVNIQjlUZHNMdC96RXRPYkhTNWQ3QU5sUTVFenZJbzdC?=
 =?utf-8?B?eEphT0JweGl2czZUNlJCeVc2OXEyOE9yZWFIMHl2UlJFZ0JzbVljNnpFdGdY?=
 =?utf-8?B?K2NQMG81c1lScHB6QW1EU0o5ek5qdkU1aEFNUHZkSU9XTkdQOGt4am1RVkVI?=
 =?utf-8?B?TzNZNWZhYjBaUXZzci9DcnZvR0c2RVBDVVI5TUZ4V2ZqMjFpV29XcVVQN0ho?=
 =?utf-8?B?bnY0UTRsRFNJK0o1UjBrUVpjTGZaTWFiWnA1WnFSZjVzMTgrRHY2ZSttS2Z5?=
 =?utf-8?B?U0RYVDlGeGtyYkUvTEg0Y1hUQ3VueXJmazIvdW5XdmtkdTBBdG4vbjVWRDlE?=
 =?utf-8?B?RUs1REdsbXhUZXZQbVF1NHhaRmlLeWMvNXV5TkRpVXFKaWJBQSthQmIwYld1?=
 =?utf-8?Q?lKESI45IvXzNeub5uobAFcc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1d4eaa-fb92-433e-d52b-08dd5a8e35c5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:01:39.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtIYg1fNjE/+GnIFksnprGUEj173vangqzBYu3/TWQ8JRw82pqCO4r8/tDoY5dIRHXholQE0TqiY2cme/N8+99ZYzqb3B6pgGo0fpfkphEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFCDDFAB0A7

On 2025-02-28 17:32, Peter Xu wrote:
> On Fri, Feb 28, 2025 at 12:53:02PM -0500, Mathieu Desnoyers wrote:
>> On 2025-02-28 11:32, Peter Xu wrote:
>>> On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
>>>> For the VM use-case, I wonder if we could just add a userfaultfd
>>>> "COW" event that would notify userspace when a COW happens ?
>>>
>>> I don't know what's the best for KSM and how well this will work, but we
>>> have such event for years..  See UFFDIO_REGISTER_MODE_WP:
>>>
>>> https://man7.org/linux/man-pages/man2/userfaultfd.2.html
>>
>> userfaultfd UFFDIO_REGISTER only seems to work if I pass an address
>> resulting from a mmap mapping, but returns EINVAL if I pass a
>> page-aligned address which sits within a private file mapping
>> (e.g. executable data).
> 
> Yes, so far sync traps only supports RAM-based file systems, or anonymous.
> Generic private file mappings (that stores executables and libraries) are
> not yet supported.
> 
>>
>> Also, I notice that do_wp_page() only calls handle_userfault
>> VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
>> set.
> 
> AFAICT that's expected, unshare should only be set on reads, never writes.
> So uffd-wp shouldn't trap any of those.
> 
>>
>> AFAIU, as it stands now userfaultfd would not help tracking COW faults
>> caused by stores to private file mappings. Am I missing something ?
> 
> I think you're right.  So we have UFFD_FEATURE_WP_ASYNC that should work on
> most mappings.  That one is async, though, so more like soft-dirty.  It
> might be doable to try making it sync too without a lot of changes based on
> how async tracking works.

I'm looking more closely at admin-guide/mm/pagemap.rst and it appears to
be a good fit. Here is what I have in mind to replace the ksmd scanning
thread for the VM use-case by a purely user-space driven scanning:

Within qemu or similar user-space process:

1) Track guest memory with the userfaultfd UFFD_FEATURE_WP_ASYNC feature and
    UFFDIO_REGISTER_MODE_WP mode.

2) Protect user-space memory with the PAGEMAP_SCAN ioctl PM_SCAN_WP_MATCHING flag
    to detect memory which stays invariant for a long time.

3) Use the PAGEMAP_SCAN ioctl with PAGE_IS_WRITTEN to detect which pages are written to.
    Keep track of memory which is frequently modified, so it can be left alone and
    not write-protected nor merged anymore.

4) Whenever pages stay invariant for a given lapse of time, merge them with the new
    madvise(2) KSM_MERGE behavior.

Let me know if that makes sense.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

