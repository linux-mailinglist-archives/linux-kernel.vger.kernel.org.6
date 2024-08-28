Return-Path: <linux-kernel+bounces-304167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1B961B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A87B22ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6C11A28C;
	Wed, 28 Aug 2024 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="o1nqzO9z"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603E1BDE6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807690; cv=fail; b=Dts3kU/1E63zHi+wWz8cod4oh8txNuO/Ve21sTRy6DjBu9fJVIqboJZLGrQ6IeRl1TCcQxNvWzi+EhJUZzvqZFhPbl9jOiRtiGzFrG+sntDnEaUGwhbkom+gyaSrJJwB1BlA9woKJfDYC3LNDNTnHSMcMBzDJvjeFv8GtV+7svs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807690; c=relaxed/simple;
	bh=Bj3pYboXImg5iJu/zKkAmwOsHNyohlZDlUswUdXglpk=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=CGN95pxv+5yuzZjCgQyb/kBjqS/f4SvSj8LYAMcV0qtWSm/aalmv37DFo+YWmbzVupU9r2uFYHRCEd2fAdPmCDfjxOLFkOUcirxmbKZeJqyFUBi0a1pOMGFTviVe0Ak+rpvihW7J1wSNDPXbBiH/94dNSX9WbQ4XHcC1OgLA0A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=o1nqzO9z; arc=fail smtp.client-ip=40.107.117.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6UImk57yYJPHfnWGsJINja8YGy1ea29ZYZRdfLOAfosDx70NOTvIny//aO8bigxhYZIzrgFJIyHvgp4d77L61NMn5+v328mfPF2CUqc6SRueIwjoHke9PhrZ4JNhWNRMpiPXvP6gcr7I0EUHW7l1ZCgEZMiPZUhRqI6V/AFr6ag2S6IjXOUAUZAX6BlXgN1eeYXqni1nVPXjaMmSudyiNss2p/qoJoPp1KHhLtIeoOeNI2tIjZZkRYIZybCppTSrgPbqM35sn4UF7sgXMzB+9KY/nOEogrk96cXJwqmj3Z7yikzTryKSQ2a8QmIOdRZBzivcogZH05JwrcByaoEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2KwntANRGYovWi9qd/ieN0dN1Poj5lcwe9X6YfangE=;
 b=vmZBU+d8m2TVylnn/tYTYvuCoSUHBkLSHWvE40OQlFi4S8P5hKpYbybhALRggLcxa/ckfcoch6fRcVI43grO2aWoIAWTOFPk0J/6JhGEWG7qhD+kABKdMaGGgNyOldjtUdxRpnGClxFipU1CbLtfTTNTjUJtGy56PPuna9opmMGRWlCXVRZ8GYtsva9rxT41/ETIB6tdPTQg3SnnAUd7edg95fHwA2ZpXtl99QLVUGN5Lj0yNF+Y0eDS+Goh3K0i6oAB28eNBBRjQs6mFm4jLs1OKJc1uslyp0SLxUfTawQuobldC+uAjNvmxxVQL9O8hTWAejVFUIYqVGGgKnqyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2KwntANRGYovWi9qd/ieN0dN1Poj5lcwe9X6YfangE=;
 b=o1nqzO9zexbB+EHsZ5siqi+XiMmqD7ixxhyQLasWe6LJ7ZRyRXJS4D9LmNA6+aRX9l2CskcJoB0F7M7eTJ9VB3X9PZ5WyrbQtfrPpsKHT4n5iPFCtHecXXUyFbqgpViLVx3Qe6zM5hg38F63gmbRN7jt2FlPz09dJM6stJfVN6UXz+1epSZCQCzxReu78tjzzHVYnzOP5H8gc9IzQGowZFOo7xjJ4Q8F2xv0KU3Nn0SqDibas+c7CZFgajZljSyuU/Mgw3YQ9vbaq3b6IyVbh3pOoDDkZFbl4RvZH+bU+bm4rEqOy1OUSu/m0HqDWpV11XFzhgqBPyIP4UH4zBUd+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB5202.apcprd06.prod.outlook.com (2603:1096:400:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 01:14:43 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 01:14:43 +0000
Content-Type: multipart/mixed; boundary="------------QHgCnH5se002z00Gnxm2tBw5"
Message-ID: <5b56e76b-cf73-4cfd-b4c5-03fdece234fd@vivo.com>
Date: Wed, 28 Aug 2024 09:14:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, oliver.sang@intel.com
Cc: opensource.kernel@vivo.com
References: <20240823140139.263-1-justinjiang@vivo.com>
 <2f19c2ff-66b2-4860-a870-a1bffe73320c@redhat.com>
 <d7978429-7875-423e-8c95-f81137a4e6cd@vivo.com>
 <1e95a6e4-9993-40ae-b563-44b7024da25c@redhat.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <1e95a6e4-9993-40ae-b563-44b7024da25c@redhat.com>
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c076a23-0b53-43ec-4f1b-08dcc6fecc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWlETG9ZS1hOVXh0Z1M0VkNGL2ZRY0NVdnpONndSRDUrd0FMZ0ZDT3YzdUww?=
 =?utf-8?B?Y0VrOURXREFrOXFOSnpRUEV0NlI4R3RqYmQxdExnZTI3TlhkbGlyUHp2cXc2?=
 =?utf-8?B?SDZvYUdQT1d1R29lYVdwSGNqb3NWWXpEcXBsT0h1UHpqbGxWZ2hSeXpzRmFl?=
 =?utf-8?B?ZVFadlpxZUl1aGlRdWQvUlNzdm5kdnVqK1JnZkxFQzNqL0tKWXlKenE2WEJy?=
 =?utf-8?B?UmpLbVFzUFJDL1krbHlSZVFQaGRCU0w4a0ljNzZTcFNXNUVvbXNNeUwxVEov?=
 =?utf-8?B?TnZUazFnMHlUVCt5VHMwdElKbTNoVm1pYjBZMEh1R1FOeklFSStxWWY1RFN6?=
 =?utf-8?B?ZWhWNVdNNnB0SGRDNGtrQUszbWttbVBYYUNQazRKQjRxK1ZYdnc3YWU3U085?=
 =?utf-8?B?NFQ2dFM0Rk9pU1M0eS8zaHRwcFhlSjd5M0M5ZDFiQjh2aElsRmliQU1uRGJ3?=
 =?utf-8?B?N3hZMU9HdUFLVWVEa0VUdjA0Sk40Z0Z2YS9LOUtFd3YyK21jTlBXdTJNR3Qy?=
 =?utf-8?B?YzJnVEdyaTJ5WS90aEZkbG1mTFB3cms1aDk2b0pNd1JwYmpBbi9idEd6eTg0?=
 =?utf-8?B?NVZoMEhTRkMzVjM4TExkM3JISTRlV25mZ2JzRDJrQjViZnNvVlhmUS95cW1B?=
 =?utf-8?B?bFBwM251RUpxRmlxOHJnU2IrcDY5TVdwT1ltK28xTGlpQlVJd2hLWXVzdmtO?=
 =?utf-8?B?REh6a09UTHp4c0RyZVBOMEpXUWVLNjUwdWxHQVUyOUZ0cTJhOGhjZWxLUjQ2?=
 =?utf-8?B?dndGNWNVYTA3Z1JMNWVQY0YrYnV5SUVKRkN6N0cwdGdVbjVVVjI1VWtVWFBQ?=
 =?utf-8?B?dU5ocDZqc01jc0pzdGtIMTFVclBFT2ZBMG9PWXNKcldlWlBPTkF6N0tybFBH?=
 =?utf-8?B?eDkwaGgzdUZwaVhkWVVWZlNSSS84d3ZlNTE3TUJ2cTk0aDNhbHR4V2ZNK2p5?=
 =?utf-8?B?RFFyQTZmMUpWT2RSUEp3aFVRaituMFNpOTJldDY4c3RtUFFDQmFOYmZLY0Vn?=
 =?utf-8?B?ODcvOGh4R2xuWWlsYkYwbStkamx0TmxWS0tCNjl2ZEkybVh6YjVaMUlQb3Jo?=
 =?utf-8?B?a2YxNGZjZ1p2dzZ5dndTNTBkUzdVdHdGSmkzbVJidG4yVm45anVSTThKNXp5?=
 =?utf-8?B?eDFubVVRQ1lXc2ZhdFZ3U05nQitRWDVGWEltdjFyNWYrTWRXR3VZVDRkK2FM?=
 =?utf-8?B?aEpyTU8rZ0FGVVlHcEJDOG5melhIdVBXeEhJNkEyK3RTM2cwRVRHWk1Ra2h5?=
 =?utf-8?B?VmRCRy8rZFUrR3VvTHBMNW45SG5aWkVBdExlcGd0K2xYbEFDSzNBZ003NTVV?=
 =?utf-8?B?dzQ2TDlSK09sUXNoTU9NcVZiUG1ZcnJ5cVZneFAwbHBYWkg5UTFZM0hISzZi?=
 =?utf-8?B?ZUIyV3AzcVVvMHRiMzhNNHZOY2laYUhvUTJnRmdsQ2ZyWEM0OGtLNTJIcEV6?=
 =?utf-8?B?bkdxVnlScktFNElYL3pEZGxzVUtkWitmQUFYQy9JcmtFT2JvZkNCRE5ERElF?=
 =?utf-8?B?Zm9OT3kxbWw0MzFjRFU3Z2hKSEpSZ3hDRDBuRkhMUG5CMkdHNHVvN24rTE1T?=
 =?utf-8?B?UmRXTnQwSWFzbjg3a0I3UWZUcHJHaUkxMzN0bDF1WGxSckFmbmk2NUwvdkgz?=
 =?utf-8?B?Nkg1NnFtaDVXOERnQ29pcWs4M1ZHcDVISkxWNzhGd1BweDBZOWk0c0dWRGhD?=
 =?utf-8?B?NnFnS2ovNmRtOFc4QWlhVTRNOGovKzVwMzF1NjQ0ekJsR2hLODZyNzJXZkRt?=
 =?utf-8?B?V0l1c092WDVpb0l4L2d6eWpDclhXT1o0eVphSjljcWo1WEpMa2p3N3I0Nkk0?=
 =?utf-8?Q?4a3ZR/Vc4RqOS8rlYJytq9ARdh1bjmAM7/luY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWVNOUZKYldQQVJ3clY0M2RkcHo3b3dDeGFzSmYvUXRJM1JZY1N4WTBOVnRK?=
 =?utf-8?B?RTI4a1kyTU94eHJEcmN0bzhjOWRzSmZuakN2VkxMWm42OWtwVVVWemJZRDll?=
 =?utf-8?B?MDY1aDErUVNYcXArQjh1Z1lGSk53ZG5rM3B5aFdqYkZ1VnJhYUxwWTNVTmNN?=
 =?utf-8?B?LzJyUEJIL0hOZG5lT09XZDdDaFJialhzSnk1L1l5cXdoVExsL2hsRlEwRFo2?=
 =?utf-8?B?TWJJaC9nY3lWMG1FZ21hNE5ZcG93MjZzTk80T1dkVFM5SUwrMGxDb2VhOUNM?=
 =?utf-8?B?T2swM29rRTVlaEZhL3YyUm81dzQ1cC9icSthNk5hcDQ0TlFSQks0NnJqcVVX?=
 =?utf-8?B?eWMzai9RYllzZ3JoL1lCMDlvSXFuQnVyVnlwMGcrejYyMG1OM0NoZnZnMzc1?=
 =?utf-8?B?RThldVgrZjRwc0hNdmhvczAzNm0wejliRjdEMGxJb0JKZjhPYlM3bmpSMDRz?=
 =?utf-8?B?bUkzVS8vR0E0aWM0dFV0c2xPMXNoN1NqeHRHbDJUZ050dWVsN280UEF6OTd6?=
 =?utf-8?B?SDNKT1AxaXBRRk9IRCtuS2o5bFl5RGFYSWlsWFVSN0RodWJoZiszV1JwVU9M?=
 =?utf-8?B?QjJ1S0RKMTRpb1ZjZ0M0TzRmWlRmUUloTWlXUFpZdnptbmlOeVpMeEtheWRW?=
 =?utf-8?B?YndXdVhSMTEvekRzR202bUZxVW9MUWt4OHFIVWtpSklxYm9TV2JtcHA0Qm55?=
 =?utf-8?B?bnQyZDBIUDVPTFBwaVlIWXNGMVdTVlgydGdTVzB5bE4zbzEzSis0TDFua1hW?=
 =?utf-8?B?MDU3VTFXeEZ4RlVDQnlmZFRzL2tNSUJmckNpaERURXJQNlF6RjFPYVpiTTBM?=
 =?utf-8?B?T2UzTGIzR2lJbDIzTE1WR3d2TlYzQ2FJZ2pzZ2ZaWXZOQ3NVTnRmc21SZFBE?=
 =?utf-8?B?bEtadVVBcWNMUzk5MDZSZjhqTmtMNGI2Q1RyMlpWRVVLcGhKNEZQblJyL0t5?=
 =?utf-8?B?RFRNdVE4NDhhNE4wZTZ3NWNDNDh3MW1CMEFOSUl4bnQ2Q29hWHduUTdxcThl?=
 =?utf-8?B?WlVCYUY1Z1dYTzlhaUYwZFFnYzRoZUlPWGVVaXJXRWpYL2l6R2I1c050cHQ1?=
 =?utf-8?B?R2llU0ZtM0ZEcUhLQmduSzRVeXN5ZWVVUjN0TkFteXJzWTVFZm5hbWdFcDVG?=
 =?utf-8?B?MmZkMGQyUm9kdE5DWFhhVDd0VU9vU01nM2pYcWpTd0F5K2szR1kvMFRkbm1E?=
 =?utf-8?B?WVlCVW9nWHJKdnh3cVJmTWtDbVdoNm14RFRJa2Z2dEhZcGFGN1pvcFRQU01V?=
 =?utf-8?B?SjE3SzlVeEo0Z0Y0cGRRYm5HOWVpVFQ4K09xVWZqYjJteG5oYjR4Nm1wcHhG?=
 =?utf-8?B?WEZ3N283K3loTVAzN3VJMEwyTnVDQjhqVElnM0EzYnN4ejduSXBQTUlMcC9K?=
 =?utf-8?B?dHFITkZ6djlxQm5iYXBRVndPRnZySEVJLzdSenFsa3lFMklLdGdaVkpaRkMw?=
 =?utf-8?B?QmQydVN0RWI5cG4vWUNQMThlUUdUMG5IbTBUVEY2YUZvRDlIa0M2ZCt1WHNs?=
 =?utf-8?B?ckhYWHYvaWJmUkpJRFVuWWUxcjBuTUJEYmJxcC85UEZyVCs0Sm92MlNZd09T?=
 =?utf-8?B?SWlSdzRFanhzR05VZVcwWHg2OHBJbDl2OVFIK2NmcHlvM3FpTktoVVJFcWV2?=
 =?utf-8?B?SWk5MUJ4TlpPSUJubUlmM2lqNENjMzZZZlZrRjVXbisyY2p0Zjk1MHdKc0tx?=
 =?utf-8?B?cVJFNncva1VLT3M1M2pCVHczVU4zUDI5cVRhTmhjZmhYS09jRFhFSXR1SWZv?=
 =?utf-8?B?d09tUWZSQlBiSFR3WDdyTzF0aUlHNyt3dFE2T0VHV1JneTdtSkpyemUxRXZ0?=
 =?utf-8?B?QkRqcEcwNVhSYnN5amJwd0hIWGZCREd2dXN0SHdiZUJ2YjZNcld0aE1lN0Vy?=
 =?utf-8?B?cG1XZis5VC9nUEF0cFJRN3ZmK0Y4bk4vTXo2MDlaVWNDUUNBRFhDSnBXc0RP?=
 =?utf-8?B?QXd1aHJ0d1ZMblJJbTJNM1phTzlDL0xCeXBnRnh0WjFYNlVrLzFKNHNZSzhO?=
 =?utf-8?B?ai9LZTY5cGw2N2ZwSnZvYjBBaEhLZHdUT0ljUTBVNDBrL0NOYW5xTWNIZ3ho?=
 =?utf-8?B?UHd1bnplMHRUOWZaQ21HQkV1NWlZUHRhOFlJZHRyN0NobnJtWGxBek4vOEVJ?=
 =?utf-8?Q?j5RN1hhg511XKPUCP52QR/Wja?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c076a23-0b53-43ec-4f1b-08dcc6fecc37
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:14:43.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AO3r7fwKaBNDbXISM3Wy0W/EjkYyxwnCkEdFfd3FjROTZelKeoEEKPqbOPJX38ce3+/XOv1tYXi2uJOf8gSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5202

--------------QHgCnH5se002z00Gnxm2tBw5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/28 1:35, David Hildenbrand 写道:
> On 27.08.24 03:50, zhiguojiang wrote:
>>
>>
>> 在 2024/8/27 1:24, David Hildenbrand 写道:
>>> On 23.08.24 16:01, Zhiguo Jiang wrote:
>>>> After CoWed by do_wp_page, the vma established a new mapping
>>>> relationship
>>>> with the CoWed folio instead of the non-CoWed folio. However, 
>>>> regarding
>>>> the situation where vma->anon_vma and the non-CoWed folio's 
>>>> anon_vma are
>>>> not same, the avc binding relationship between them will no longer be
>>>> needed, so it is issue for the avc binding relationship still existing
>>>> between them.
>>>>
>>>> This patch will remove the avc binding relationship between vma and 
>>>> the
>>>> non-CoWed folio's anon_vma, which each has their own independent
>>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>>>
>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>> ---
>>>> -v2:
>>>>    * Solve the kernel test robot noticed "WARNING"
>>>>      Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>      Closes:
>>>> https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com 
>>>>
>>>>    * Update comments to more accurately describe this patch.
>>>>
>>>> -v1:
>>>> https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/ 
>>>>
>>>>
>>>>    include/linux/rmap.h |  1 +
>>>>    mm/memory.c          |  8 +++++++
>>>>    mm/rmap.c            | 53 
>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 62 insertions(+)
>>>>
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index 91b5935e8485..8607d28a3146
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *,
>>>> struct page *, int nr_pages,
>>>>        folio_remove_rmap_ptes(folio, page, 1, vma)
>>>>    void folio_remove_rmap_pmd(struct folio *, struct page *,
>>>>            struct vm_area_struct *);
>>>> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
>>>>      void hugetlb_add_anon_rmap(struct folio *, struct 
>>>> vm_area_struct *,
>>>>            unsigned long address, rmap_t flags);
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 93c0c25433d0..4c89cb1cb73e
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault
>>>> *vmf)
>>>>                 * old page will be flushed before it can be reused.
>>>>                 */
>>>>                folio_remove_rmap_pte(old_folio, vmf->page, vma);
>>>> +
>>>> +            /*
>>>> +             * If the new_folio's anon_vma is different from the
>>>> +             * old_folio's anon_vma, the avc binding relationship
>>>> +             * between vma and the old_folio's anon_vma is removed,
>>>> +             * avoiding rmap redundant overhead.
>>>> +             */
>>>> +            folio_remove_anon_avc(old_folio, vma);
>>>
>>> ... by increasing write fault latency, introducing an RMAP walk (!)? 
>>> Hmm?
>>>
>>> On the reuse path, we do a folio_move_anon_rmap(), to optimize that.
>>>
>> Thanks for your comments. This may not be a good fixup patch. The
>> resue patch folio_move_anon_rmap() seems to be exclusive or
>> _refcount = 1 folios. The fork() path seems to clear exclusive flag
>> in copy_page_range() --> ... --> __folio_try_dup_anon_rmap(). However,
>> I observed lots of orphan avcs by the above debug trace logs in
>> wp_page_copy(). But they may be not removed by discussing with Mika.
>
> Was this patch ever tested? I cannot even boot a simple VM without an 
> endless stream of
>
> [    5.804598] ------------[ cut here ]------------
> [    5.805494] WARNING: CPU: 11 PID: 595 at mm/rmap.c:443 
> unlink_anon_vmas+0x19b/0x1d0
> [    5.806962] Modules linked in: qemu_fw_cfg
> [    5.807762] CPU: 11 UID: 0 PID: 595 Comm: dracut-rootfs-g Tainted: 
> G        W          6.11.0-rc4+ #72
> [    5.809546] Tainted: [W]=WARN
> [    5.810127] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), 
> BIOS 1.16.3-2.fc40 04/01/2014
> [    5.811753] RIP: 0010:unlink_anon_vmas+0x19b/0x1d0
> [    5.812680] Code: b0 00 00 00 00 75 1f f0 ff 8f a0 00 00 00 75 a2 
> e8 8a fd ff ff eb 9b 5b 5d 41 5c 41 5d 41 5e 41 5f e9 d4 82 d0 00 0f 
> 0b eb dd <0f> 0b eb cf 0f 0b 48 83 c7 08 e8 16 40 d7 ff e9 ea fe ff ff 
> 48 8b
> [    5.816247] RSP: 0018:ffffa19f43bb78d0 EFLAGS: 00010286
> [    5.817258] RAX: ffff8a71c1bdd2d0 RBX: ffff8a71c1bdd2c0 RCX: 
> ffff8a71c27a86c8
> [    5.818624] RDX: 0000000000000001 RSI: ffff8a71c2771b28 RDI: 
> ffff8a71c27a9e60
> [    5.820011] RBP: dead000000000122 R08: 0000000000000000 R09: 
> 0000000000000001
> [    5.821380] R10: 0000000000000200 R11: 0000000000000001 R12: 
> ffff8a71c2771b28
> [    5.822748] R13: dead000000000100 R14: ffff8a71c2771b18 R15: 
> ffff8a71c27a9e60
> [    5.824122] FS:  0000000000000000(0000) GS:ffff8a7337980000(0000) 
> knlGS:0000000000000000
> [    5.825665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.826775] CR2: 00007fca7f70ac58 CR3: 00000001027b2004 CR4: 
> 0000000000770ef0
> [    5.828146] PKRU: 55555554
> [    5.828686] Call Trace:
> [    5.829169]  <TASK>
> [    5.829594]  ? __warn.cold+0xb1/0x13e
> [    5.830312]  ? unlink_anon_vmas+0x19b/0x1d0
> [    5.831118]  ? report_bug+0xff/0x140
> [    5.831840]  ? handle_bug+0x3c/0x80
> [    5.832524]  ? exc_invalid_op+0x17/0x70
> [    5.833262]  ? asm_exc_invalid_op+0x1a/0x20
> [    5.834086]  ? unlink_anon_vmas+0x19b/0x1d0
> [    5.834908]  free_pgtables+0x130/0x290
> [    5.835661]  exit_mmap+0x19a/0x460
> [    5.836351]  __mmput+0x4b/0x120
> [    5.836965]  do_exit+0x2e1/0xac0
> [    5.837601]  ? lock_release+0xd5/0x2c0
> [    5.838343]  do_group_exit+0x36/0xa0
> [    5.839035]  __x64_sys_exit_group+0x18/0x20
> [    5.839866]  x64_sys_call+0x14b4/0x14c0
Arm64 machine tested it and no crashes detected. You may try the
attachment modifition provided by Lorenzo Stoakes. Can you please
check if there are any opportunities for further improvement?
>
>
> Andrew, please remove this from mm-unstable.

Thanks
Zhiguo
--------------QHgCnH5se002z00Gnxm2tBw5
Content-Type: text/plain; charset=UTF-8;
 name="0001-mm-fixup-orphan-avc-cleanup-logic.patch"
Content-Disposition: attachment;
 filename="0001-mm-fixup-orphan-avc-cleanup-logic.patch"
Content-Transfer-Encoding: base64

RnJvbSA5NzNjZTVmMGFlYTc4MTk2MDg4Y2Q1Mjc5MDVjYzBmYWQ0MGVkYjI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogTG9yZW56byBTdG9ha2VzIDxsb3JlbnpvLnN0b2FrZXNAb3Jh
Y2xlLmNvbT4NCkRhdGU6IFNhdCwgMjQgQXVnIDIwMjQgMTg6NTU6MzEgKzAxMDANClN1YmplY3Q6
IFtSRkMgUEFUQ0hdIG1tOiBmaXh1cCBvcnBoYW4gYXZjIGNsZWFudXAgbG9naWMNCg0KRXhpc3Rp
bmcgbG9naWMgZmFpbGVkIHRvIHJlcGFyZW50IHRoZSBhbm9uX3ZtYSB3aG9zZSBhdmMgd2FzIHJl
bW92ZWQgd2hpY2gNCnJlc3VsdGVkIGluIGFzc2VydGlvbiBmYWlsdXJlcy4NCg0KVGhpcyBwYXRj
aCBjb3JyZWN0cyB0aGlzLCBmaXhlcyB1cCBzb21lIGNvbW1lbnRzLCBhbmQgZG9lcyBzb21lIG90
aGVyDQpjbGVhbnVwcy4NCg0KV2UgYWxzbyBkbyBub3QgZG8gYW55dGhpbmcgcmVsYXRpbmcgdG8g
YW5vbl92bWEtPnBhcmVudCBtYW5pcHVsYXRpb24gaWYgbm8NCm9ycGhhbmVkIEFWQyBpcyBmb3Vu
ZC4NCg0KSSBzdGlsbCBmZWVsIHRoaXMgbG9naWMgaXMgaGlnaGx5IGR1YmlvdXMsIGJ1dCB0aGlz
IGRvZXMgZml4IHRoZSBpc3N1ZSB3aXRoDQphbm9uX3ZtYS0+bnVtX2NoaWxkcmVuIGFjY291bnRp
bmcuDQoNClRoaXMgZG9lc24ndCBjb3JyZWN0bHkgaGFuZGxlIGxvY2tpbmcgb2YgdGhlIHJlcGFy
ZW50ZWQgYW5vbl92bWEuDQoNClNpZ25lZC1vZmYtYnk6IExvcmVuem8gU3RvYWtlcyA8bG9yZW56
by5zdG9ha2VzQG9yYWNsZS5jb20+DQotLS0NCiBpbmNsdWRlL2xpbnV4L3JtYXAuaCB8ICAgMiAr
LQ0KIG1tL21lbW9yeS5jICAgICAgICAgIHwgICAyICstDQogbW0vcm1hcC5jICAgICAgICAgICAg
fCAxMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KIDMgZmls
ZXMgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3JtYXAuaCBiL2luY2x1ZGUvbGludXgvcm1hcC5oDQppbmRleCA4
NjA3ZDI4YTMxNDYuLmYxYTgzNWY1NDA2NCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvcm1h
cC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3JtYXAuaA0KQEAgLTI1Nyw3ICsyNTcsNyBAQCB2b2lk
IGZvbGlvX3JlbW92ZV9ybWFwX3B0ZXMoc3RydWN0IGZvbGlvICosIHN0cnVjdCBwYWdlICosIGlu
dCBucl9wYWdlcywNCiAJZm9saW9fcmVtb3ZlX3JtYXBfcHRlcyhmb2xpbywgcGFnZSwgMSwgdm1h
KQ0KIHZvaWQgZm9saW9fcmVtb3ZlX3JtYXBfcG1kKHN0cnVjdCBmb2xpbyAqLCBzdHJ1Y3QgcGFn
ZSAqLA0KIAkJc3RydWN0IHZtX2FyZWFfc3RydWN0ICopOw0KLXZvaWQgZm9saW9fcmVtb3ZlX2Fu
b25fYXZjKHN0cnVjdCBmb2xpbyAqLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKik7DQordm9pZCBj
bGVhbnVwX29ycGhhbl9hdmMoc3RydWN0IGZvbGlvICosIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
KTsNCiANCiB2b2lkIGh1Z2V0bGJfYWRkX2Fub25fcm1hcChzdHJ1Y3QgZm9saW8gKiwgc3RydWN0
IHZtX2FyZWFfc3RydWN0ICosDQogCQl1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHJtYXBfdCBmbGFn
cyk7DQpkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1vcnkuYw0KaW5kZXggNGM4OWNi
MWNiNzNlLi45ODliMDc4ZGQ4NjAgMTAwNjQ0DQotLS0gYS9tbS9tZW1vcnkuYw0KKysrIGIvbW0v
bWVtb3J5LmMNCkBAIC0zNDM1LDcgKzM0MzUsNyBAQCBzdGF0aWMgdm1fZmF1bHRfdCB3cF9wYWdl
X2NvcHkoc3RydWN0IHZtX2ZhdWx0ICp2bWYpDQogCQkJICogYmV0d2VlbiB2bWEgYW5kIHRoZSBv
bGRfZm9saW8ncyBhbm9uX3ZtYSBpcyByZW1vdmVkLA0KIAkJCSAqIGF2b2lkaW5nIHJtYXAgcmVk
dW5kYW50IG92ZXJoZWFkLg0KIAkJCSAqLw0KLQkJCWZvbGlvX3JlbW92ZV9hbm9uX2F2YyhvbGRf
Zm9saW8sIHZtYSk7DQorCQkJY2xlYW51cF9vcnBoYW5fYXZjKG9sZF9mb2xpbywgdm1hKTsNCiAJ
CX0NCiANCiAJCS8qIEZyZWUgdGhlIG9sZCBwYWdlLi4gKi8NCmRpZmYgLS1naXQgYS9tbS9ybWFw
LmMgYi9tbS9ybWFwLmMNCmluZGV4IDU2ZmMxNmZjZjJhOS4uM2FjMjY0OTYyOTE3IDEwMDY0NA0K
LS0tIGEvbW0vcm1hcC5jDQorKysgYi9tbS9ybWFwLmMNCkBAIC0xNTIzLDU2ICsxNTIzLDg3IEBA
IHZvaWQgZm9saW9fYWRkX2ZpbGVfcm1hcF9wbWQoc3RydWN0IGZvbGlvICpmb2xpbywgc3RydWN0
IHBhZ2UgKnBhZ2UsDQogfQ0KIA0KIC8qKg0KLSAqIGZvbGlvX3JlbW92ZV9hbm9uX2F2YyAtIHJl
bW92ZSB0aGUgYXZjIGJpbmRpbmcgcmVsYXRpb25zaGlwIGJldHdlZW4NCi0gKiBmb2xpbyBhbmQg
dm1hIHdpdGggZGlmZmVyZW50IGFub25fdm1hcy4NCi0gKiBAZm9saW86CVRoZSBmb2xpbyB3aXRo
IGFub25fdm1hIHRvIHJlbW92ZSB0aGUgYmluZGVkIGF2YyBmcm9tDQotICogQHZtYToJVGhlIHZt
IGFyZWEgdG8gcmVtb3ZlIHRoZSBiaW5kZWQgYXZjIHdpdGggZm9saW8ncyBhbm9uX3ZtYQ0KKyAq
IGNsZWFudXBfb3JwaGFuX2F2YyAtIHJlbW92ZSB0aGUgYXZjIGJpbmRpbmcgcmVsYXRpb25zaGlw
IGJldHdlZW4gYSBwYXJlbnQNCisgKiBmb2xpbyBhbmQgY2hpbGQgdm1hIHdpdGggZGlmZmVyZW50
IGFub25fdm1hcyB3aGljaCwgZHVlIHRvIGFuIG9wZXJhdGlvbiBzdWNoDQorICogYXMgQ29XJ2lu
ZyBhIGZvbGlvLCBpcyBubyBsb25nZXIgbWVhbmluZ2Z1bC4NCiAgKg0KLSAqIFRoZSBjYWxsZXIg
aXMgY3VycmVudGx5IHVzZWQgZm9yIENvV2VkIHNjZW5lLg0KKyAqIChpbnNlcnQgQVNDSUkgZGlh
Z3JhbXMgYW5kIGV4cGxhbmF0aW9uIGhlcmUuLi4pDQorICoNCisgKiBAb2xkX2ZvbGlvOiAgVGhl
IGZvbGlvIHdoaWNoIGNvbnRhaW5zIHRoZSBwYXJlbnQgYW5vbl92bWEgd2hpY2ggaGFzIGFuIHVu
bmVlZGVkDQorICogICAgICAgICAgICAgIGF2YyBiaW5kaW5nLg0KKyAqIEBuZXdfdm1hOglUaGUg
Vk1BIHdoaWNoIGlzIHVubmVjZXNzYXJpbHkgYm91bmQgdG8gZm9saW8uDQogICovDQotdm9pZCBm
b2xpb19yZW1vdmVfYW5vbl9hdmMoc3RydWN0IGZvbGlvICpmb2xpbywNCi0JCXN0cnVjdCB2bV9h
cmVhX3N0cnVjdCAqdm1hKQ0KK3ZvaWQgY2xlYW51cF9vcnBoYW5fYXZjKHN0cnVjdCBmb2xpbyAq
b2xkX2ZvbGlvLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKm5ld192bWEpDQogew0KLQlzdHJ1Y3Qg
YW5vbl92bWEgKmFub25fdm1hID0gZm9saW9fYW5vbl92bWEoZm9saW8pOw0KKwlzdHJ1Y3QgYW5v
bl92bWEgKnBhcmVudF9hbm9uX3ZtYSA9IGZvbGlvX2Fub25fdm1hKG9sZF9mb2xpbyk7DQorCXN0
cnVjdCBhbm9uX3ZtYSAqY2hpbGRfYW5vbl92bWEgPSBuZXdfdm1hLT5hbm9uX3ZtYTsNCiAJcGdv
ZmZfdCBwZ29mZl9zdGFydCwgcGdvZmZfZW5kOw0KIAlzdHJ1Y3QgYW5vbl92bWFfY2hhaW4gKmF2
YzsNCisJYm9vbCByZW1vdmVkID0gZmFsc2U7DQogDQogCS8qDQotCSAqIEVuc3VyZSB0aGF0IHRo
ZSB2bWEncyBhbm9uX3ZtYSBhbmQgdGhlIGZvbGlvJ3MNCi0JICogYW5vbl92bWEgZXhpc3QgYW5k
IGFyZSBub3Qgc2FtZS4NCisJICogSWYgdGhpcyBmb2xpbyB3ZXJlIG5vdCBhbm9ueW1vdXMsIGZv
bGlvX2Fub25fdm1hKCkgd291bGQgaGF2ZQ0KKwkgKiByZXR1cm5lZCBOVUxMLiBFcXVhbGx5LCBp
ZiB0aGUgcGFyZW50IGFuZCBjaGlsZCBhbm9uX3ZtYSBvYmplY3RzIGFyZQ0KKwkgKiB0aGUgc2Ft
ZSwgdGhlbiB3ZSBoYXZlIG5vdGhpbmcgdG8gZG8gaGVyZS4NCiAJICovDQotCWlmICghZm9saW9f
dGVzdF9hbm9uKGZvbGlvKSB8fCB1bmxpa2VseSghYW5vbl92bWEpIHx8DQotCSAgICBhbm9uX3Zt
YSA9PSB2bWEtPmFub25fdm1hKQ0KKwlpZiAoIXBhcmVudF9hbm9uX3ZtYSB8fCBwYXJlbnRfYW5v
bl92bWEgPT0gY2hpbGRfYW5vbl92bWEpDQogCQlyZXR1cm47DQogDQotCXBnb2ZmX3N0YXJ0ID0g
Zm9saW9fcGdvZmYoZm9saW8pOw0KLQlwZ29mZl9lbmQgPSBwZ29mZl9zdGFydCArIGZvbGlvX25y
X3BhZ2VzKGZvbGlvKSAtIDE7DQorCXBnb2ZmX3N0YXJ0ID0gZm9saW9fcGdvZmYob2xkX2ZvbGlv
KTsNCisJcGdvZmZfZW5kID0gcGdvZmZfc3RhcnQgKyBmb2xpb19ucl9wYWdlcyhvbGRfZm9saW8p
IC0gMTsNCiANCi0JaWYgKCFhbm9uX3ZtYV90cnlsb2NrX3dyaXRlKGFub25fdm1hKSkNCisJLyog
VGhpcyBpcyBhbiBvcHRpbWlzdGljIGF0dGVtcHQuICovDQorCWlmICghYW5vbl92bWFfdHJ5bG9j
a193cml0ZShwYXJlbnRfYW5vbl92bWEpKQ0KIAkJcmV0dXJuOw0KIA0KLQlhbm9uX3ZtYV9pbnRl
cnZhbF90cmVlX2ZvcmVhY2goYXZjLCAmYW5vbl92bWEtPnJiX3Jvb3QsDQotCQkJcGdvZmZfc3Rh
cnQsIHBnb2ZmX2VuZCkgew0KLQkJLyoNCi0JCSAqIEZpbmQgdGhlIGF2YyBhc3NvY2lhdGVkIHdp
dGggdm1hIGZyb20gdGhlIGZvbGlvJ3MNCi0JCSAqIGFub25fdm1hIGFuZCByZW1vdmUgaXQuDQot
CQkgKi8NCi0JCWlmIChhdmMtPnZtYSA9PSB2bWEpIHsNCi0JCQlhbm9uX3ZtYV9pbnRlcnZhbF90
cmVlX3JlbW92ZShhdmMsICZhbm9uX3ZtYS0+cmJfcm9vdCk7DQotCQkJLyoNCi0JCQkgKiBXaGVu
IHJlbW92aW5nIHRoZSBhdmMgd2l0aCBhbm9uX3ZtYSB0aGF0IGlzDQotCQkJICogZGlmZmVyZW50
IGZyb20gdGhlIHBhcmVudCBhbm9uX3ZtYSBmcm9tIHBhcmVudA0KLQkJCSAqIGFub25fdm1hLT5y
Yl9yb290LCB0aGUgcGFyZW50IG51bV9jaGlsZHJlbg0KLQkJCSAqIGNvdW50IHZhbHVlIGlzIG5l
ZWRlZCB0byByZWR1Y2Ugb25lLg0KLQkJCSAqLw0KLQkJCWFub25fdm1hLT5udW1fY2hpbGRyZW4t
LTsNCisJLyoNCisJICogSXRlcmF0ZSB0aHJvdWdoIGFsbCBBVkMncyB0aWVkIHRvIHRoZSBvbGQg
Zm9saW8sIGxvb2tpbmcgZm9yIHRoZQ0KKwkgKiByZWR1bmRhbnQgb25lIHBvaW50aW5nIGF0IHRo
ZSBuZXcgVk1BLg0KKwkgKi8NCisJYW5vbl92bWFfaW50ZXJ2YWxfdHJlZV9mb3JlYWNoKGF2Yywg
JnBhcmVudF9hbm9uX3ZtYS0+cmJfcm9vdCwNCisJCQkJICAgICAgIHBnb2ZmX3N0YXJ0LCBwZ29m
Zl9lbmQpIHsNCisJCWlmIChhdmMtPnZtYSAhPSBuZXdfdm1hKQ0KKwkJCWNvbnRpbnVlOw0KIA0K
LQkJCWxpc3RfZGVsKCZhdmMtPnNhbWVfdm1hKTsNCi0JCQlhbm9uX3ZtYV9jaGFpbl9mcmVlKGF2
Yyk7DQotCQkJYnJlYWs7DQotCQl9DQorCQkvKiBSZW1vdmUgdGhlIHVubmVlZGVkIGF2Yy4gKi8N
CisJCWFub25fdm1hX2ludGVydmFsX3RyZWVfcmVtb3ZlKGF2YywgJnBhcmVudF9hbm9uX3ZtYS0+
cmJfcm9vdCk7DQorCQlsaXN0X2RlbCgmYXZjLT5zYW1lX3ZtYSk7DQorCQlhbm9uX3ZtYV9jaGFp
bl9mcmVlKGF2Yyk7DQorDQorCQlyZW1vdmVkID0gdHJ1ZTsNCisJCWJyZWFrOw0KIAl9DQotCWFu
b25fdm1hX3VubG9ja193cml0ZShhbm9uX3ZtYSk7DQorDQorCWlmICghcmVtb3ZlZCkNCisJCWdv
dG8gdW5sb2NrOw0KKw0KKwkvKg0KKwkgKiBSZW1vdmluZyBhbiBhdmMgaW1wbGllcyB0aGF0IHRo
ZSBhc3NvY2lhdGVkIGF2YyBNQVkgbm8gbG9uZ2VyIG5lZWQNCisJICogdG8gcG9pbnQgdG8gaXRz
IHBhcmVudCwgYW5kIHdlIG5lZWQgdG8gcmVwYXJlbnQgaXQuDQorCSAqLw0KKw0KKwkvKg0KKwkg
KiBJZiBzb21laG93IHdlIGFyZW4ndCBhbHJlYWR5IHRoZSBjaGlsZCBvZiB0aGUgcGFyZW50IGFu
b25fdm1hLCB3ZQ0KKwkgKiBoYXZlIG5vdGhpbmcgdG8gZG8gaGVyZS4NCisJICovDQorCWlmIChj
aGlsZF9hbm9uX3ZtYS0+cGFyZW50ICE9IHBhcmVudF9hbm9uX3ZtYSkNCisJCWdvdG8gdW5sb2Nr
Ow0KKw0KKwkvKiBPSywgd2UgYWJhbmRvbiBvdXIgcGFyZW50LCBhbmQgcmVwYXJlbnQgdG8gb3Vy
c2VsdmVzLiAqLw0KKw0KKwlwYXJlbnRfYW5vbl92bWEtPm51bV9jaGlsZHJlbi0tOw0KKw0KKwlj
aGlsZF9hbm9uX3ZtYS0+cGFyZW50ID0gY2hpbGRfYW5vbl92bWE7DQorCWNoaWxkX2Fub25fdm1h
LT5udW1fY2hpbGRyZW4rKzsNCisNCisJLyoNCisJICogSGVyZSB3ZSBzaG91bGQgcHJvYmFibHkg
cmVzZXQgdGhlIGFub25fdm1hLT5yb290LCBhcyBwZXINCisJICogYW5vbl92bWFfY3RvcigpIGJ1
dCB0aGlzIGZlZWxzIGlja3kgYW5kIGhvcnJpYmxlLiBCaXQgd2VpcmQgdG8gc2hhcmUNCisJICog
YSBsb2NrIHdpdGggdGhlIG9sZCBwYXJlbnQncyByb290Lg0KKwkgKi8NCisNCit1bmxvY2s6DQor
CWFub25fdm1hX3VubG9ja193cml0ZShwYXJlbnRfYW5vbl92bWEpOw0KIH0NCiANCiBzdGF0aWMg
X19hbHdheXNfaW5saW5lIHZvaWQgX19mb2xpb19yZW1vdmVfcm1hcChzdHJ1Y3QgZm9saW8gKmZv
bGlvLA0KLS0gDQoyLjQ2LjANCg0K

--------------QHgCnH5se002z00Gnxm2tBw5--

