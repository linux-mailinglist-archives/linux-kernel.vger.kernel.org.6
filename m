Return-Path: <linux-kernel+bounces-246901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3A092C8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9212845E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7062B171CC;
	Wed, 10 Jul 2024 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="c6pi77qc"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE0063A5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579307; cv=fail; b=HJRw54skBtaEDeQWkpS6ZvK/+QnL1gudENhFjpd0XLQmxfkvETt4lKOOLCDjJZkMficItsMrn3hXWF6Vt3T39xmmkFUHR9QwT0wUjTRLa5lGGDVf7fYH2U/ELawOZ3FawLklMFGXup7xcVomB+Sduoe8efI4uZLBXpEmawOnPxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579307; c=relaxed/simple;
	bh=kbQjvJwGiN5iAH9WNBIWmwa2ZNs/qihW0Om253Oa5mI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tJqYa02am4VJwVpiXyRXSqkh/wdLFZxbEEqCOkWMT3BabzrDHaGCYRmLh9g8YPPnPTv4DdoWRGYrXiu7opPNpgckpbjbc32TmExcvsd79/yZse7AOpHrLs4qbSlFS3V2Uy3oty+ZhVeIcfUjsPNa9HsNKqpKM6njajgJXXr6PP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=c6pi77qc; arc=fail smtp.client-ip=40.107.255.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDOnbm50aaqOxmn8IG0zYSW5hslI9c8kEHsHCUA12uzZYra/9dJBft3irvfj9Z/ehIzrlgVWo14LyQ3wpyR6Mwyy3WNv87rf5k5BOeD/zJT9muDrsGYuIhkyrPxg+xm2+iOqavIUFN0Bf+cOQRHrNvc/Y+yoIRWi2XfKXHwtjdlEmxquKF33r5RGUyPE1urond2nPQjmZMt5/AoyGzWm06X1LVB2jrboD345ZMRPLyE6gv9duupbflCkR5q6MJ8oQFL8Ykw65nuNY9E6TjHh5AkoiPstQdJcADpPxdcDGeRgGg5T1pacgJ7mG1qKRvviumNTfrrJkxXbkO3yu63qBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63q49AVRVz6J08eA/L7f1YXsafakfH9qJdMOUN3P/1o=;
 b=KBk8FZdTKAznn3hprtetOZoQ04TCVqjloK2tgjyz4f2hknLtaWzk/YslfF6EOFvgGxNOudBelMzheltbqY/0Nw1USZ9GnuAkxlt9Uxc9BuRbtF1eZDHB77uyseT/mPP3I2ff0PlYBGHrsgvCvVjC8FznooaiCgCHm0xJbyIekmIi63uIvLBjtWQy6TrKmRr7wbEQsHBSPTtLJcu72c++eYBv7lsmSBaHs2oHS5pekdhvF7dtzGwy9S2C6nfE69bBKc5dX7nUd+moeYzfpUql3JFT+bv/6vs8ydadrTC1/QRuOrbMg/0SLwmQtzbfS7hclzfIb7UN7HHugksWe73/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63q49AVRVz6J08eA/L7f1YXsafakfH9qJdMOUN3P/1o=;
 b=c6pi77qcD8kxRSz3j5uiqJZABAkmB5JAgN4M9+HkpVheio1AxCl75s2b0F8dtM1v/nVUTxlTCMlTKHVJ9qAuEmdi1s8SLGMjkYYFVn/kyr8emq0VmF7Cy7ICMIAaEvzp4PNDiAKLrv6draoP+98FYaKgF9POJ/anVegHTXMvFC9BKxMsSkar+7LWcdSr9OaDthDGQoo9gJXXwaGgI9a+LlZQqw/ceWBLfiKzTG7wnw+zQerFblMezvLOJJwBax050bV+Js5WDVOh1OG6Wf5kEewvWGtm//j9FLxJY8MA+gf5eQcHAd+s+/umwn9dRTeU8kLmWE4ItnOD1IQVQSpR/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYSPR06MB7305.apcprd06.prod.outlook.com (2603:1096:405:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:41:41 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:41:41 +0000
Message-ID: <20bb4c80-730b-47d9-bb28-9bbb51479799@vivo.com>
Date: Wed, 10 Jul 2024 10:41:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
References: <20240709123115.117-1-justinjiang@vivo.com>
 <CAGsJ_4zXUg30Pm-ixmGvnNEBB7AOBesSPBjqe3pU81FmnHAZqA@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4zXUg30Pm-ixmGvnNEBB7AOBesSPBjqe3pU81FmnHAZqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYSPR06MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b24c38a-6263-4548-3f35-08dca089d46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWlJa1d0d0p1WGJlMTR3OEFSOHVncnVtdVdQekJ2a0dWL3FBTzRiUGlpYmpK?=
 =?utf-8?B?OC9pWVJZb0FyTmpYMmZ1SE9icC9LR0Rwb21jYkorVFRSSWhkRXBtdGhUcVNw?=
 =?utf-8?B?KytLcVpGUy8vUHRmRXpEckNyTnBxMHVIWDBqbWF5UnFXb0JEajZqVGFnR1Fm?=
 =?utf-8?B?emdNR3p2bEtOUE41OWZSYklTWXJPemZBWWdLdXVmWk0vTjBTMWFFL05KTjdi?=
 =?utf-8?B?SEQxR0xWMVRnWW5aejNMNmNKZy9XWGZXSEpuMmdiV2lDTElGVVYwZmswSTVU?=
 =?utf-8?B?M2RwZy9mZFpZcmRoNHZONit1cGRjQWhJV3hYUDhENXI1NC8rT1lLeXU1dytw?=
 =?utf-8?B?T2FaekRCbUhIVU1aVHJ4RFA4U3Yrb05tNGk5TW9FTnlMYWJOVnpuMVNmKzJp?=
 =?utf-8?B?aVdrMjJpb1NUN25vN1B5bDFmVmNFVmFBbERlamRlVFpTdm9BSVZLek41d3k2?=
 =?utf-8?B?R3BrN0pLdWhrN1Zwd2llN3NQUHlscW93SmtSYVQ2TGJ4OW1uY2FRSDBCSVh0?=
 =?utf-8?B?TmhXdHNXUFpCbWtZWXJIVkVIRjVmeXUxL0ozMnpVOGtmTXpESUR3R2FpS0hw?=
 =?utf-8?B?ZGplZ00vMmcxaGlKMVNGZjZpM0txQU9wZWdtYmQ5SXQ4ekJhTHl6V2lqc2hB?=
 =?utf-8?B?OW1rYzJHcXNQVXBHWjBkamVVYjllYkJEK0g5NFQya3diUm9xemhqendxb2lK?=
 =?utf-8?B?WDlMcFJWRmZKM1hPR0x3dkJLTkxlVTFhME1qR0d6NVFUNGNEUkhVL2xtOUsx?=
 =?utf-8?B?ZHRVeDFURnJjMGY3L2RpeVMyQWpGVTgvLzFFazhoYVM2NkFVMnZkRVhRV3RX?=
 =?utf-8?B?UEtaYkJpc0xNUi92MDVadHR4MVBYR0JlSk5CVTI0bnlHakxTZ1Y0UEFlWU8w?=
 =?utf-8?B?UFpmNnpmaHJwMitxK2Vka3dOOE5ablVsd1RWNHVXckJFK013TGpxL0YzT1lu?=
 =?utf-8?B?RUpGV2JNaGpiK29HZnkvVGg0bDRDeFNLZmp6L0NwU0YrUzF0cjVaUmdyOFNU?=
 =?utf-8?B?TVpkcHFOVmp6TEEzNTVlL01yK1hlZVdsMnF6YjUvZnVJeUN4dWl6VXA3dVlS?=
 =?utf-8?B?cng2VUh5TVBGaVBuWmlaQXZOUHJYTHBidEptYW9MZVVOTWt2QWZSdEFYSmdx?=
 =?utf-8?B?b01Ea2cwL2UvNWJ6VlhDQlFwOWlIRnlMYXpINlpsNVRYTStYTjhqVFBqRGNC?=
 =?utf-8?B?MkttWThBZmJGNzkzNnkrWHd0dWhkay9wSFBJSDdyejBMTTQyTk1ScnpOa2ZE?=
 =?utf-8?B?MkZnT2FzbDM4VVdUWm1SSWw3Zlh0d2MwNkZ6dkhITExReS8xc1JESmozN2JL?=
 =?utf-8?B?OXllNFZjeXlYakxXWWdRTTJlbjIwa0xFLzl0S3Y1dCtLZGswTnFidHVENEll?=
 =?utf-8?B?eXlGRDZIYm4vbmJvUm4xaVkxSWVYYzVBb3Vsd0EzcENlR0xINWErcnBETC8r?=
 =?utf-8?B?bU9GVUswVE50YXdVZnlvZjRqRnpVcWFxVG5UZnJlZkIybkQrQ1F6eUtxZUcz?=
 =?utf-8?B?d1NybTlGbXl0RkZicEYrWVNXR0tpbVU2TUN0MnN1eHRZdnhkMm01eUUvbnQ4?=
 =?utf-8?B?WExCTFptSXdHenkzcXVhU05SeDN4M1VLSWN6Y2pmTmhmS1lrbXNSVW1kWmds?=
 =?utf-8?B?RnMyWVJBMENMVGsydjVpREpnY2pZN0h1K0JibWZJWUtZUFV1WkRCNEZZUjRq?=
 =?utf-8?B?TW04eGpCaTBhdFc0T2hSaDNIamJ2UDBqcHlqalE4eEoxU0xhay85WHUzQjZI?=
 =?utf-8?B?Z3NLb1EwcUduU2JTb0gxb3VqeGNnS1NNTEdDMk0rbVJzbkhOSVFKcTd1QVl4?=
 =?utf-8?B?cllqV2FnTWk3djZwejhsNmNlQmZpRytmRjh0VHZqNmxCQ0F1RmRjV3AzRzl2?=
 =?utf-8?Q?hlE775jKF3j8M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czJVRHJBcHppQUZhVGR3MzFwNG1pQUZZT1lhUVBxWHZ0SDVvWGVwSkFRS1Qw?=
 =?utf-8?B?NkZHSDlpOVUzREZUcHhWNHF4WTRHMWV3aUxtN0hxaXlVUC9LMW04YnFvWHl3?=
 =?utf-8?B?N2VIeWs2L0lid2VOY3h0K21UQzJKUEd4OUdJWHNHSGJRQkVRN2lkTWkveXhM?=
 =?utf-8?B?Q1gxTytmdUJjZWtzbkdQUzhNNW9KeVVBcDJnWlF0aUZJNlM5WTg0VjNIMGx6?=
 =?utf-8?B?bXZhQjdoZUlMTUhWRnJiR2pqdURyclMxSzMzQksvY2dnREVlZ3NqUDNSSHNE?=
 =?utf-8?B?WjdhRlEvZU5CZWdESTZCb0JkeW9yNWtwVlpkVWp3NFhkZUVvVjRpR3dSUzVR?=
 =?utf-8?B?UGhaUTM0NDJYTVk0TDdMeU1yOHhZU1RkSzBNVWlUWGhVa1ovM1RDRnNyNXZ0?=
 =?utf-8?B?dWpNN3FYTHdwalRVYU1LVUtDWnFNTXZ0ZTJrRmJDS2dmMkJGWnI2Q2hGM2pK?=
 =?utf-8?B?YnNEckR4dVpNckpnb1hxWTU2dHkycXl0amFhM1FNMlYzMS9SUWxsVU5ZalVL?=
 =?utf-8?B?ejk5RkxzdW9VUTBtS2wzTEN1Vm9FckMrd2YveGM0WEJBQkpXVnhkS0FqZWlS?=
 =?utf-8?B?L29waDV4a2l0YVVveTg2TVBKVk8yQWxYR2NXOHBYRjc0WnlqVmFoR09NNUk5?=
 =?utf-8?B?d0NJdk5pbXlrY3dlY2huV2pqRVV1NWlPa2tZdVdPWGhMekR5WGFTeWNkMmpC?=
 =?utf-8?B?aUZoYVowNHFoVU1ucmxvSklVZmdGNGFmcXVFblFzRExrSWJDSjMwUi9NdjlV?=
 =?utf-8?B?d3RRdDVBZXhSS1VBZmdjY0NHb2FkY3VSL1oxUXZycy92NWdZTEF3c29ERWQ4?=
 =?utf-8?B?aFMwMFFVc0IrTmE5VVlaTzNOV0Y4Rk1obUJBazU3NnBZU3NuU1FmRXIySTZC?=
 =?utf-8?B?WGpkZzNqelZpZGZ3NlJMSW84SlNpR3kvTXRhRFIzSkdGKzMwcnV0TnZMMmk3?=
 =?utf-8?B?TGJUWHY0MXdTL2hOSkdobGVmVGp5UkFzNlJ1eElLWmlhSThGamJXV1RBT2VS?=
 =?utf-8?B?TGdDcHNBZkdpMSt0TlNZTG5IbGxwdEx4ZVc0NGdkdTFGeWZpb1NMckNiQzFt?=
 =?utf-8?B?aDYxNjlKVUlEczF4ZW5IaXdxb3ErT1luWWxVWVFVRDhsbHFFMFlBWlFlejBF?=
 =?utf-8?B?dkxpa2lWcVdxWW8zZmsxRjM2WW5jYTl0S3llVFdlOSs2aEovdStOQ2lkV1dK?=
 =?utf-8?B?cXoyZEV5Rk5OSWVCbjdCSlgvWHlzK041ZjgyakhUUUZNZDQyNmxacU96S0lJ?=
 =?utf-8?B?RitlYlcxOTRyeStaSVZneXN5d1kxN0E3bDRGTkcxbmRmdXVXaUpkMzFJODk3?=
 =?utf-8?B?QXh0c3hVVzhQSEx2UzFITGthVHFDSFI2M1d6WlJtVVRLK3lndWg3cWVUd0JQ?=
 =?utf-8?B?dTdCQmhIYXRzYWREMFFCTU4vWThPbXgzdUhGdXZKbi8vM0pEMXN1UXF4WVA2?=
 =?utf-8?B?VVVDQjNrWEt1VTUxdmIzZHlBcUxnQmx6ZVZ6cUNDN0VCRWJ4cnd3bmxYOHdx?=
 =?utf-8?B?b2M0U2xheHBtaVorRldFZ0NNYW93dUJ5Tmo0VWE0eE9GNFNHVXZXa1Yyemls?=
 =?utf-8?B?R3dWVmtRM3BXMUgvU3RLaGxXT04zNDh4VkdrcnhqRWM0RWZRekozUFNSRE42?=
 =?utf-8?B?eFZQK1ZabkNJaVVlbWpXMWdRb1ZZVVdGbnFUNm90V24ySzErWks5YjlmaG9j?=
 =?utf-8?B?UTBaWGtNMGFmd3dXS2I0dE1CbnVtYkZhMFhmMFpEcldUZTJhRjdZeFYzU2dH?=
 =?utf-8?B?VFU4SHExSGZjODIzRlhjTXp4NzVFNzhiS2wrWExoNHVNV3BzTTZIMnc5VnZh?=
 =?utf-8?B?THh6clJNRGF5SU8vdDVVRGUyaDRmaUc3RXdmL0ZmNTBOZThzOTVCM1cyakQ5?=
 =?utf-8?B?NzQveG56WmZ3MW42UyszVWJKeCsvajBvZll0VFczM0lQWjM5d2V2TlZlNzRn?=
 =?utf-8?B?SGFpZnhVb1JsSzJha1UvOENvbi9TMWxMY3d5aFVqNU8xelZheFpVYmpWZ05O?=
 =?utf-8?B?aXFCclMvMVNQN0lPNjNWb0Z6Ny9aSngrQ3RGSlBZLy9YM0xTeFBLQW9HNk52?=
 =?utf-8?B?Ykp3b1pRN2dIMDNkcjlGYjAvUlFid05hdU11WVJMTzRucnlvOGI3WGRXaGhm?=
 =?utf-8?Q?+NkEMfq1ycgSKd2aqFJjrD5wE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b24c38a-6263-4548-3f35-08dca089d46f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 02:41:41.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PENwaexpZbu4DiVTUOdJlxLWEKapYjAM0Ice20mO3uVqMpXYltv6Tmf3nUMFANSMydD1/iWMkRehFBAih6xF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7305



在 2024/7/10 10:12, Barry Song 写道:
> On Wed, Jul 10, 2024 at 12:31 AM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>> The releasing process of the non-shared anonymous folio mapped solely by
>> an exiting process may go through two flows: 1) the anonymous folio is
>> firstly is swaped-out into swapspace and transformed into a swp_entry
>> in shrink_folio_list; 2) then the swp_entry is released in the process
>> exiting flow. This will result in the high cpu load of releasing a
>> non-shared anonymous folio mapped solely by an exiting process.
>>
>> When the low system memory and the exiting process exist at the same
>> time, it will be likely to happen, because the non-shared anonymous
>> folio mapped solely by an exiting process may be reclaimed by
>> shrink_folio_list.
>>
>> This patch is that shrink skips the non-shared anonymous folio solely
>> mapped by an exting process and this folio is only released directly in
>> the process exiting flow, which will save swap-out time and alleviate
>> the load of the process exiting.
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>
>> Change log:
>> v6->v7:
>> 1.Modify tab indentation to space indentation of the continuation
>> lines of the condition.
>> v5->v6:
>> 1.Move folio_likely_mapped_shared() under the PTL.
>> 2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
>> 3.Remove folio_test_anon(folio).
>> v4->v5:
>> 1.Further modify to skip non-shared anonymous folio only.
>> 2.Update comments for pra->referenced = -1.
>> v3->v4:
>> 1.Modify to skip only the non-shared anonymous folio mapped solely
>> by an exiting process.
>> v2->v3:
>> Nothing.
>> v1->v2:
>> 1.The VM_EXITING added in v1 patch is removed, because it will fail
>> to compile in 32-bit system.
>>
>>
>> Comments from participants and my responses:
>> [v6->v7]:
>> 1.Matthew Wilcox <willy@infradead.org>
>> You told me you'd fix the indentation.  You cannot indent both the
>> continuation lines of the condition and the body of the if by one tab
>> each!
>> -->
>> Modify tab indentation to space indentation of the continuation
>> lines of the condition.
>>
>> [v5->v6]:
>> 1.David Hildenbrand <david@redhat.com>
>> I'm currently working on moving all folio_likely_mapped_shared() under
>> the PTL, where we are then sure that the folio is actually mapped by
>> this process (e.g., no concurrent unmapping poisslbe). Can we do the
>> same here directly?
>> -->
>> You are right. we might use page_vma_mapped_walk_done() to bail out.
>> (Barry Song)
>>
>> 2.Barry Song <baohua@kernel.org>
>> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
>> &vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
>> automatically has MMF_OOM_SKIP. What is the purpose of this check?
>> Is there a better way to determine if a process is an OOM target?
>> What about check_stable_address_space() ?
>> -->
>> Sorry, I overlook the situation with if (is_global_init(p)),
>> MMF_OOM_SKIP is indeed not suitable. It seems feasible for
>> check_stable_address_space() replacing MMF_OOM_SKIP.
>> check_stable_address_space() can indicate oom kill, and
>> !atomic_read(&vma->vm_mm->mm_users) can indicate the normal
>> process exiting.
>>
>> I also think we actually can remove "folio_test_anon(folio)".
>> -->
>> Yes, update in patch v6.
>>
>> [v4->v5]:
>> 1.Barry Song <baohua@kernel.org>
>> I don't think this is correct. folio_likely_mapped_shared() is almost
>> "correct" but not always.
>> Please explain why you set  pra->referenced =  -1. Please address all
>> comments before you send a new version.
>> -->
>> Update in patch v5.
>>
>> 2.Matthew Wilcox <willy@infradead.org>
>> How is the file folio similar?  File folios are never written to swap,
>> and they'll be written back from the page cache whenever the filesystem
>> decides it's a good time to do so.
>> -->
>> What do you mean is that the file folio will not have any relevant
>> identifier left in memory after it is reclamed in the shrink flow,
>> and it will not be released again during an exiting process? If that's
>> the case, I think we only need the anon folio is skipped here.
>>
>> [v3->v4]:
>> 1.Barry Song <baohua@kernel.org>
>> This is clearly version 3, as you previously sent version 2, correct?
>> -->
>> Yes.
>>
>> Could you please describe the specific impact on users, including user
>> experience and power consumption? How serious is this problem?
>> -->
>> At present, I do not have a suitable method to accurately measure the
>> optimization benefit datas of this modifications, but I believe it
>> theoretically has some benefits.
>> Launching large memory app (for example, starting the camera) in multiple
>> backend scenes may result in the high cpu load of the exiting processes.
>>
>> Applications?
>> -->
>> Yes, when system is low memory, it more likely to occur.
>>
>> I'm not completely convinced this patch is correct, but it appears to be
>> heading in the right direction. Therefore, I expect to see new versions
>> rather than it being dead.
>> You changed the file mode to 755, which is incorrect.
>> -->
>> Solved.
>>
>> Why use -1? Is this meant to simulate lock contention to keep the folio
>> without activating it? Please do have some comments to explain why.
>> I'm not convinced this change is appropriate for shared folios. It seems
>> more suitable for exclusive folios used solely by the exiting process.
>> -->
>> The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
>> the folios will be freed soon in the exiting process flow.
>> Yes, the shared folios can not be simply skipped. I have made relevant
>> modifications in patch v4 and please help to further review.
>> https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/
>>
>> 2.David Hildenbrand <david@redhat.com>
>> but what if it is shared among multiple processes and only one of them
>> is exiting?
>> -->
>> Modify to skip only the non-shared anonymous folio mapped solely
>> by an exiting process in next version v4.
>>
>> [v2->v3:]
>> Nothing.
>>
>> [v1->v2]:
>> 1.Matthew Wilcox <willy@infradead.org>
>> What testing have you done of this patch?  How often does it happen?
>> Are there particular workloads that benefit from this?  (I'm not sure
>> what "mutil backed-applications" are?)
>> And I do mean specifically of this patch, because to my eyes it
>> shouldn't even compile. Except on 32-bit where it'll say "warning:
>> integer constant out of range".
>> -->
>> Yes, I have tested. When the low system memory and the exiting process
>> exist at the same time, it will happen. This modification can alleviate
>> the load of the exiting process.
>> "mutil backed-applications" means that there are a large number of
>> the backend applications in the system.
>> The VM_EXITING added in v1 patch is removed, because it will fail
>> to compile in 32-bit system.
>>
>>   mm/rmap.c   | 14 ++++++++++++++
>>   mm/vmscan.c |  7 ++++++-
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 88156deb46a6..bb9954773cce 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -877,6 +877,20 @@ static bool folio_referenced_one(struct folio *folio,
>>                          continue;
>>                  }
>>
>> +               /*
>> +                * Skip the non-shared swapbacked folio mapped solely by
>> +                * the exiting or OOM-reaped process. This avoids redundant
>> +                * swap-out followed by an immediate unmap.
>> +                */
>> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
>> +                   check_stable_address_space(vma->vm_mm)) &&
> You didn't even pass the compilation stage because you're missing 'linux/oom.h'.
> It's quite disappointing because I believe in your idea, but you
> didn't even build it
> before sending.
>
> @@ -75,6 +75,7 @@
>   #include <linux/memremap.h>
>   #include <linux/userfaultfd_k.h>
>   #include <linux/mm_inline.h>
> +#include <linux/oom.h>
Sorry, I overlooked the compilation of folio_likely_mapped_shared() added
in patch v5. Compiled and Updated have been compeleted in patch v8.

Thanks
Zhiguo
>
>> +                   folio_test_swapbacked(folio) &&
>> +                   !folio_likely_mapped_shared(folio)) {
>> +                       pra->referenced = -1;
>> +                       page_vma_mapped_walk_done(&pvmw);
>> +                       return false;
>> +               }
>> +
>>                  if (pvmw.pte) {
>>                          if (lru_gen_enabled() &&
>>                              pte_young(ptep_get(pvmw.pte))) {
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 80f9a486cf27..1d5f78a3dbeb 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
>>          if (vm_flags & VM_LOCKED)
>>                  return FOLIOREF_ACTIVATE;
>>
>> -       /* rmap lock contention: rotate */
>> +       /*
>> +        * There are two cases to consider.
>> +        * 1) Rmap lock contention: rotate.
>> +        * 2) Skip the non-shared swapbacked folio mapped solely by
>> +        *    the exiting or OOM-reaped process.
>> +        */
>>          if (referenced_ptes == -1)
>>                  return FOLIOREF_KEEP;
>>
>> --
>> 2.39.0
>>


