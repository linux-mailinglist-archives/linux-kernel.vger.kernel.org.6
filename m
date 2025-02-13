Return-Path: <linux-kernel+bounces-513617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16565A34C80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A706816B0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D823A9B5;
	Thu, 13 Feb 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="jcZ8IuZg";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="T/Nnzfhp"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899023A9B0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469316; cv=fail; b=B5uH7I8jliNy/1HLT3cHSZ2SjX9xM+N1nrq9fx0oLwlYRD38AFVKDdzyGLagmN/MIfu2vurE6pdFmypsbFx2Fhwrc2/Sw5CN5ACtEEk05eeIqYjQSBdKHSdL5SUgieae0GhjkkDypRoZprxM9gCLaDMmGX28lX3Q/+JYWqEP3tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469316; c=relaxed/simple;
	bh=lgic/6Bgzqu1abGcs8lVlCw6zW8BnRu/XPGkTPKh9a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEuie4B/Di5yUpA0XEUz//Ey/ncXttqbVwkSa2SKb+dKJxsx7Uysles4WefX34qIEQQn37dLIl1MDoSOqzg2+pitz1qvKRuD9hCl2DTL13GPA4o5gaAjxLMaKxB9Q/xOJR0Cf+D4gy/SPJOiElXmR6uNwEWdAVrYbWyL000Hw64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=jcZ8IuZg; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=T/Nnzfhp; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGqbuo020236;
	Thu, 13 Feb 2025 09:54:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=CLR3gg/ZwbBRCYKEAoIxsHwmv6qigIpzYCDLNPxuG
	a8=; b=jcZ8IuZgVIiJsPji5sb6dvyGvUD18iJ7wI+oVSOeG2re5/TvRKUmmHkYQ
	UM8TyYsModFmxoXvY1HuOxeqGN4zYt9t2q2U96xXamXmEg5hr1xdcXS36IG5Gsf3
	MPZ02XKRFZQMcFORslWPQFJVw2PeyOs+0B3dM5nzPP+/E2aCittcomoPwX6dsw7S
	qD7BIq/rOfbJmOv0557FKmdFt9AFEoGu/ZE/n9WqhewKxfRz71RNoIUSrpTRQ3vW
	vJ1rtslMn75BXkgckPucO65QO23WqPidAWE19/HXDJ00/AZ78NskBv9IB+p6wvh7
	as0Vi9N+pps1WsAxylXlEQ/lNRI2A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44p7ukch99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 09:54:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYTr3DsDLjmBGuyThDypWLZWN0qe8tOqhZSG/CWdi4pKLMQdiVjVxe7a33U+7Y7n5dzbl7Ppy0TvHl5UvCsxiu0qDpl7ela0COvqQHMPn1bpXSpn7FdI0gfa0pM2/4WNemLuNyN6zTYbfibhNWQyvSLJOigQWLT+XANU31pPcn6ntI+8xjl+mDU0LBEECJerow4riDLqim8aP7oF4QeLLPf0R8i6ZI8cvQI6CBhWlIURMO5Lz7i0dHz+QPDdEYzBdEcMHrcoNUjGp8wPXKRm9kf4qKCOUhK/4Qz2wRg7AQ9pnpJjWntcsjeqx6pD+XK19cVW1QAzo9lp33oxcYS8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLR3gg/ZwbBRCYKEAoIxsHwmv6qigIpzYCDLNPxuGa8=;
 b=eQFWVczeXO39QD87CPswcr/f8p94QdexUx6OXkip9D+Nx8BVYBPg6rINjWUFu5bxBWni+PVQU+NG0sf+Z1ywqwpSq59e5/dAmwgHLF36CUWbPtMK/fP8YaekWdDdfw/BxqVMLIWa/Ya7oBqplwxnqtpp2D40eKw8j9Vtum7oYE7s03KhcpuKIBG7vyHzyl6rkq62q6ATvRO3DXFl+4LCn/axN5kPPVJhJdud4lEgI0nbwI5xZKPt9VKC23eBkxJ5H8U42OY2a3LuCgZyQOEk5PDNcFvgfh5x0oLDZ05ABUr7+u7HUAVHov6wl4b4fu4JHX5xWcb97dgCHb3O9rv3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLR3gg/ZwbBRCYKEAoIxsHwmv6qigIpzYCDLNPxuGa8=;
 b=T/Nnzfhpu8oZ7rl9/1vHPA1GDg0GVXU28mv1XeM/uXVpIXzM3kLvkwqKRe45AyZ05UQ1h60zuqR/XrF3z3b6Ats8QmYWwl8aSah8/zYdtU2psQ4liHUT61jXmMVdqRkdgQyuFVOFmo2imYLJkH8N/WKScVifVd+q6grlxcwhQz7zju9iPmkeK2SyrtT+pTic6oEZOdqkqs11raByGP0qyfDORkSbhkJ+YtjrPVgmuhgb8GdsjzIxU8QxQBg/85fCfY5EKDXjiNb8yD+CjOEs1TeC/wItu8L3jajgBoIFIj5Sm2fei5FwjdpGPYlYm7X6/ZnthvGkO3+Cx5zYT68j/w==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by IA1PR02MB9253.namprd02.prod.outlook.com (2603:10b6:208:427::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 17:54:48 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 17:54:48 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Harshit Agarwal <harshit@nutanix.com>, Jon Kohler <jon@nutanix.com>,
        Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul Chunduru <rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>
Subject: [PATCH v2] sched/rt: Fix race in push_rt_task
Date: Thu, 13 Feb 2025 17:54:34 +0000
Message-Id: <20250213175435.114441-1-harshit@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <9C390C10-8741-4992-8E29-303C907C8C00@nutanix.com>
References: <9C390C10-8741-4992-8E29-303C907C8C00@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:332::18) To SJ0PR02MB8861.namprd02.prod.outlook.com
 (2603:10b6:a03:3f4::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8861:EE_|IA1PR02MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: f6324600-fe67-430b-2616-08dd4c5781c5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE0vUTU1ZURKUVBjYXRsMGhnTEZzS1Uza0pwai9WeDZVZnViWk94RG5zZ0lw?=
 =?utf-8?B?N3ltNmp4SnNZYU1tWXdicTcyV3U3WDhpUkZCbXN5UDJpZTR5ZEtaU0lpay9p?=
 =?utf-8?B?LzQ2amlmTTA1b2JFbC9SY2N1REQxekhkWEMwRWxQRFAyTnhxempOWUY2OG1j?=
 =?utf-8?B?Vmk3UHU5K3hWMVA4TE9MYW4wbmJVRHlYSzVuNSs2aVZoNk44R29wd3poMmVB?=
 =?utf-8?B?WWpXak1Nb3BrVHlodE0rMnh3RHh1aHFHbzU3TEkvSzNRa1JDeWtTVERBRWd0?=
 =?utf-8?B?UmZQWHhiRXZhZHJ5L0pJcW9WNGM2Q0I5TEpPNDRiVHBNV0Jhd3NlZFFacEM3?=
 =?utf-8?B?Nk5IVkRORGdtclF2TDZmMmJpcHlpQWxGQkJPTnN4M013NWdScVFqUEZENzVa?=
 =?utf-8?B?RitKRkRMRnFlUzVGUzIveisyV0ZrMEpxUm5SQVJUVnhMNGJUclY1cWE5a0xK?=
 =?utf-8?B?czMwRVJXQ01Mc20zZ2hVcG0yR0xlMzNnT0FTSU9zNC9wYTlESHErckQ3VGVw?=
 =?utf-8?B?WG1odEF6cFpkN2dPdlVBQkVibmlleWltc1QvcU5rMHk0YXFzSEN3RzVXa1ln?=
 =?utf-8?B?SktFR1E4aG1qTnhMdjBVRFJ2ZGZvS2laZXpQTWh4cVdEZWpjN0dNd0E4NkZk?=
 =?utf-8?B?dDZBdEl5OWlCeW1valZWRGo0cnUwWHZOdEZrbmdKSHVlWWxlN0kvNVdRM3BU?=
 =?utf-8?B?ZHF0dDJjMXdWaG9vM3lXVndvRVZUbzdzVnVxU2FVZGgyMlcxSHlTT0V4UDVV?=
 =?utf-8?B?SytMSVVVRTJXSjhscmFOVlNIbERlL2I1ZGJWMWliWitUb2dDcGZueUpmcmYr?=
 =?utf-8?B?ODk1c2xxb3VXZ1VTU2VyeklPaC9oRnNmZzZwWVF2UTYza01aRUhHTGRRZitH?=
 =?utf-8?B?dnZDL0JZK2orL0RmOUlpUGFWMjZQbTIvUndGNFJFVldjMytkY0ZTYkRTZkx5?=
 =?utf-8?B?OGMybm9wY044ajlmWlVBQ29HMTN0WDN4Wm9DUkt4ZjUzWnkvMjd1K01YZWsz?=
 =?utf-8?B?RXFKazh4NXdwY2sxWVdUOGprcHNocE11bWF2ZC9qa0xKVHd1cE5KOWRKU3pi?=
 =?utf-8?B?b0VOM3B1RHdMUmxYTFBZaEI2UEI4Z1VxOFgxV2FOWlVCSU9xbzZoV08za2ZM?=
 =?utf-8?B?eFRjSjVja2srQVdBdDcyb0lIczh6VWtPNVpNYzdVUmR3L2hsUytUUnpJemJn?=
 =?utf-8?B?eU5NYi9FUGR2RGNYb1FLNHlIUWd6clI5a1VBUzIxVE1wZncySUZkZlNHMGJG?=
 =?utf-8?B?dGJnY1Z1Y1hjQUhjNFRiMFM2aWlxWXdyYXhqSXVaeXRsdVVDV1kvQjdNSHZQ?=
 =?utf-8?B?Z1Bka2RPK3lDOFNDMkRZLzJiNWNWd3hJUEswQTFMaDU2NWNiWTFmYVhPUHVp?=
 =?utf-8?B?Z3BtYzhabXd1R3ZPVHdKL3VnM3FESFgyTGI5UjN0L05kaTFld3h0Q1VQZEpr?=
 =?utf-8?B?SStrcEJHdStrR0QrY1lUckFzZEJCYWp3bUMwN01HMkxYLzQrVFBuRzhoZFhx?=
 =?utf-8?B?Y0djaTN0bVZnQVl0YlUyS0VNV2hMcHNRS3JNVmNieWI4aXo5UERsbDNUbzVl?=
 =?utf-8?B?VVpZRUtZMWphSEdrZHJtWTJGelNtWDg5U3pkYUZNelhpaTRnanBmRllkb1hP?=
 =?utf-8?B?OVhFZDhvWHBoZEtjUTdWa0JLYXdaMzRVMlVYeWNIdmJDa0t4dVlzbmlzN0RF?=
 =?utf-8?B?K0FVVmZ3ejh3TWRpVnpWVzZDdkRJRXBJc2ZQc1h0OHp6WlZudWIwS2laeURU?=
 =?utf-8?B?dnpCclV3NllSWkNNSlJZcGwzb1c2TE82c1RRb1libHhBdEQ1NFEzRmNkUlJy?=
 =?utf-8?B?WUgzdnZhdEZya3BReU9WdjJzY0tLRjlGUXVRTU9HNjVQY1I3UzhpVzVId3lE?=
 =?utf-8?B?REluUkpRMmxvMndENVlyc1YyNmlId1BlNEJZSTNUSlhqcE9FTWltd01jTERS?=
 =?utf-8?B?WVVXMFJoVWFkeElFZGdlV2Z4WVJSbm9HZGF3RVd0YzZzc0xFZTJLZWlOc2gw?=
 =?utf-8?B?T3FIQm8yQjR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGVmSXlIdFl3RE5hVVBObWVwNnErcHV0RnRRYmJRdHcyQys4dVJYZ1ErMllY?=
 =?utf-8?B?RUZBNWR3d1ZDTWV1V1N1aXBycXNHUlZNenVOaCsyTWduVnN4elNyQ3Z4Z0hB?=
 =?utf-8?B?R1FEbWtkS0tzMHR0NE12aXhaM0pMZ1JYRGpuZWJFaFZVYVh6b3lmR2VweGtB?=
 =?utf-8?B?WUNVRUJOVExtZFNMODRxLys3WkR2SUJjUXFNMW51cm51VmtjbG5jMFVhb3ph?=
 =?utf-8?B?UzFFb2k4TzlsVXZGZWdlaUYwd2Vnemt2UEpUcFNicXgzUVk1VmN5WGJnbFJq?=
 =?utf-8?B?N25XZ09mckdiMDRQR2psVm5KVEdWaTNBTnJ6eFZGUVArZjRVdHNpc0o2ZytQ?=
 =?utf-8?B?cit6Q0JWLzRsOG5uM1pOdjh3ZloxcElpcXFyU05yQmhOZnduMlA1VXltcXdC?=
 =?utf-8?B?ZTZWZUIzSDVUYTZtbE9mWkNsOXJKdFgxc0JVVzE1ck1JT1RqUHdzcjdsTTVJ?=
 =?utf-8?B?S1lFUmNNKzhsQW5PUWkvRk1lb1pRN2N6UXI1NEhFUVJxbFRjUWgxMVovdXRq?=
 =?utf-8?B?K05TbHVvRW52dGlHelJtcW8yNVVEQnpRUVN1VUpTSE5Rc0NQOGw0cEZzeHhL?=
 =?utf-8?B?cXh6VkNxeVpJZjNFclBENTNxRUNld1VuQjQwWjJRSHA2VmNVcTREWm5vbGJ6?=
 =?utf-8?B?a3JEYjZhYWJrYWVnL0ZlbU92WWVKZm5lVkMvWTc4MnJUclNVUTErSTB6bW5Y?=
 =?utf-8?B?eVZzbGpqK2lCRnhibm43elNpU2E1WVdZdnlYS2E4SjlUM1hBSkJTL25EMWIw?=
 =?utf-8?B?cUpZNGJEQnVyUHFlbnlyTXI4S3BrakQxanIzbnliL3JlZ1VOUHM2djFodW41?=
 =?utf-8?B?UDNRUjhleUtOVUZ2c05hYkx4TjJ6aWNuRjNlRkJNSzhDVG91R1FPcmVHTjQ2?=
 =?utf-8?B?ZVJFRk5QLy8wejlYQ1hSZElxMGNudGZkdm0xMnJkeUNVakFUcnQ4MzdydW1J?=
 =?utf-8?B?a29hd0dtVm9oY0RnSGUrdTRFQ2dJYkNjaHZna2hhMzd3SDZZM0Z6aGVhd0hz?=
 =?utf-8?B?UjE1S09NWlgwVm1pVmgxbXlWR2lhQ0JrY2QrQ1pzMnV5Y0loaGJUdUdGMHlp?=
 =?utf-8?B?NzZkeitJU3hsUTJVY1ZLSXB4bjEzZHFudGJjVTBvUUNuemw1STVDbXdwUHRp?=
 =?utf-8?B?empUY2l0WVJpelFGUnRHVE01T29XdWxibmt2aElQczdPaUMreHB0cHQ5WVhY?=
 =?utf-8?B?bVBlM2tkeERnRU0rSW43eEwyYTI0NmV6NXhoYU10UnVwUDJtSlhIUXBVNmZG?=
 =?utf-8?B?YWwwbmdCQUxTRE5ZQWdzWWVsYkhjbEk4SzRnWVB4K1ZVN1ViaUl2RzVWcVdY?=
 =?utf-8?B?bzBkUnR0dXkrTUY1c2dwMWIvT1JJSkN1bFlXc08zeGI0OGwxRkZQc09lendx?=
 =?utf-8?B?S1dTelVOSUVMU2JPcXkyMFpWS0JHdzl2a2t0OTNwNng0MVdTeTBuWjJyS1d3?=
 =?utf-8?B?ZnNNUnl2ak8ySHVLUEpGdSttWE1FTVI3VXgzZFpvbnN3SzBKdzNpdXpZK01r?=
 =?utf-8?B?QnNidFUvYi9MdEd1VGNsTTFGQ3ZHWXJrakl3U2hzUDlzaEp1aTZwR3QyMDRN?=
 =?utf-8?B?MWpmN1Z1bXI3Tlkvdkg4Qmg0MzRYVkpmR0p2OWNaMEZhc0Y0Q24wNXFrNWtV?=
 =?utf-8?B?T3ZXNkllQ2pTK25pTitkZGRLRmRRREFOZGFYY05RMWlmczJ0NzhKZUY5Z1Zv?=
 =?utf-8?B?QlpyOEY0N2VEc01DUnpzUHFSWlZPUkswL2w0UG9TUGo3ZlVWWEswR3JpaTZt?=
 =?utf-8?B?VTdRVFhkMmpONGtqM2p6L2NDVUhTdysyUGZ0Wk1vbnYwZnNwbGpROVU0Vk1Y?=
 =?utf-8?B?OVE5UVQrbGc3Qi9mL1RtaXdGMGVPc0VRbE94MEsvbERyOTgzUzEzNmc4VHZp?=
 =?utf-8?B?dVBQTENDbzl4MkJkTXZVdVgrVUhsdmhialg4OTlzcElYaTJuMUJYdmdKUXhv?=
 =?utf-8?B?MTFkd3M1VlFxaVowVHhjQWpQQzBDdDJtVTNVL0R0bVNEM3FTY1lXQnprS0RI?=
 =?utf-8?B?RkJQMjQvWnNBdmwyVUhyT0ozMnIraG90RzZwcFl0ZTY0a1ZrUkVmRUFDNjRa?=
 =?utf-8?B?MStXcXRUVG1IWDdVU0FRcVlTdFRZWGo0NVpTTFZyMXVnYytpNEVXUk91SnVM?=
 =?utf-8?B?MFVLbGxHU0d6R3ByK0tSRUtTMS8zdzc2bzhuOGMxcVNjV0dGZkt1ZnJpNjQy?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6324600-fe67-430b-2616-08dd4c5781c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:54:48.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIpKw3Cep8nARh2C+RjhpuC9HSPchI4HMMa2eoVGpKvNy3u0uNn0gOSgTJkgAij1O5xEoHQuVoaFXMLsHBU3qcZSME/1h+m/BGHJ4quSTA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9253
X-Authority-Analysis: v=2.4 cv=HKs5Fptv c=1 sm=1 tr=0 ts=67ae31ea cx=c_pps a=zbudaZmfUx0dwwhLSrpPog==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=Z03Q_keH1iIUxzbuzPYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: HGKtuFwe4TPPOvs0-vjfq6EiTwwkXvuK
X-Proofpoint-ORIG-GUID: HGKtuFwe4TPPOvs0-vjfq6EiTwwkXvuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

Overview
========
When a CPU chooses to call push_rt_task and picks a task to push to
another CPU's runqueue then it will call find_lock_lowest_rq method
which would take a double lock on both CPUs' runqueues. If one of the
locks aren't readily available, it may lead to dropping the current
runqueue lock and reacquiring both the locks at once. During this window
it is possible that the task is already migrated and is running on some
other CPU. These cases are already handled. However, if the task is
migrated and has already been executed and another CPU is now trying to
wake it up (ttwu) such that it is queued again on the runqeue
(on_rq is 1) and also if the task was run by the same CPU, then the
current checks will pass even though the task was migrated out and is no
longer in the pushable tasks list.

Crashes
=======
This bug resulted in quite a few flavors of crashes triggering kernel
panics with various crash signatures such as assert failures, page
faults, null pointer dereferences, and queue corruption errors all
coming from scheduler itself.

Some of the crashes:
-> kernel BUG at kernel/sched/rt.c:1616! BUG_ON(idx >= MAX_RT_PRIO)
   Call Trace:
   ? __die_body+0x1a/0x60
   ? die+0x2a/0x50
   ? do_trap+0x85/0x100
   ? pick_next_task_rt+0x6e/0x1d0
   ? do_error_trap+0x64/0xa0
   ? pick_next_task_rt+0x6e/0x1d0
   ? exc_invalid_op+0x4c/0x60
   ? pick_next_task_rt+0x6e/0x1d0
   ? asm_exc_invalid_op+0x12/0x20
   ? pick_next_task_rt+0x6e/0x1d0
   __schedule+0x5cb/0x790
   ? update_ts_time_stats+0x55/0x70
   schedule_idle+0x1e/0x40
   do_idle+0x15e/0x200
   cpu_startup_entry+0x19/0x20
   start_secondary+0x117/0x160
   secondary_startup_64_no_verify+0xb0/0xbb

-> BUG: kernel NULL pointer dereference, address: 00000000000000c0
   Call Trace:
   ? __die_body+0x1a/0x60
   ? no_context+0x183/0x350
   ? __warn+0x8a/0xe0
   ? exc_page_fault+0x3d6/0x520
   ? asm_exc_page_fault+0x1e/0x30
   ? pick_next_task_rt+0xb5/0x1d0
   ? pick_next_task_rt+0x8c/0x1d0
   __schedule+0x583/0x7e0
   ? update_ts_time_stats+0x55/0x70
   schedule_idle+0x1e/0x40
   do_idle+0x15e/0x200
   cpu_startup_entry+0x19/0x20
   start_secondary+0x117/0x160
   secondary_startup_64_no_verify+0xb0/0xbb

-> BUG: unable to handle page fault for address: ffff9464daea5900
   kernel BUG at kernel/sched/rt.c:1861! BUG_ON(rq->cpu != task_cpu(p))

-> kernel BUG at kernel/sched/rt.c:1055! BUG_ON(!rq->nr_running)
   Call Trace:
   ? __die_body+0x1a/0x60
   ? die+0x2a/0x50
   ? do_trap+0x85/0x100
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? do_error_trap+0x64/0xa0
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? exc_invalid_op+0x4c/0x60
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? asm_exc_invalid_op+0x12/0x20
   ? dequeue_top_rt_rq+0xa2/0xb0
   dequeue_rt_entity+0x1f/0x70
   dequeue_task_rt+0x2d/0x70
   __schedule+0x1a8/0x7e0
   ? blk_finish_plug+0x25/0x40
   schedule+0x3c/0xb0
   futex_wait_queue_me+0xb6/0x120
   futex_wait+0xd9/0x240
   do_futex+0x344/0xa90
   ? get_mm_exe_file+0x30/0x60
   ? audit_exe_compare+0x58/0x70
   ? audit_filter_rules.constprop.26+0x65e/0x1220
   __x64_sys_futex+0x148/0x1f0
   do_syscall_64+0x30/0x80
   entry_SYSCALL_64_after_hwframe+0x62/0xc7

-> BUG: unable to handle page fault for address: ffff8cf3608bc2c0
   Call Trace:
   ? __die_body+0x1a/0x60
   ? no_context+0x183/0x350
   ? spurious_kernel_fault+0x171/0x1c0
   ? exc_page_fault+0x3b6/0x520
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? asm_exc_page_fault+0x1e/0x30
   ? _cond_resched+0x15/0x30
   ? futex_wait_queue_me+0xc8/0x120
   ? futex_wait+0xd9/0x240
   ? try_to_wake_up+0x1b8/0x490
   ? futex_wake+0x78/0x160
   ? do_futex+0xcd/0xa90
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? plist_del+0x6a/0xd0
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? dequeue_pushable_task+0x20/0x70
   ? __schedule+0x382/0x7e0
   ? asm_sysvec_reschedule_ipi+0xa/0x20
   ? schedule+0x3c/0xb0
   ? exit_to_user_mode_prepare+0x9e/0x150
   ? irqentry_exit_to_user_mode+0x5/0x30
   ? asm_sysvec_reschedule_ipi+0x12/0x20

Above are some of the common examples of the crashes that were observed
due to this issue.

Details
=======
Let's look at the following scenario to understand this race.

1) CPU A enters push_rt_task
  a) CPU A has chosen next_task = task p.
  b) CPU A calls find_lock_lowest_rq(Task p, CPU Z’s rq).
  c) CPU A identifies CPU X as a destination CPU (X < Z).
  d) CPU A enters double_lock_balance(CPU Z’s rq, CPU X’s rq).
  e) Since X is lower than Z, CPU A unlocks CPU Z’s rq. Someone else has
     locked CPU X’s rq, and thus, CPU A must wait.

2) At CPU Z
  a) Previous task has completed execution and thus, CPU Z enters
     schedule, locks its own rq after CPU A releases it.
  b) CPU Z dequeues previous task and begins executing task p.
  c) CPU Z unlocks its rq.
  d) Task p yields the CPU (ex. by doing IO or waiting to acquire a
     lock) which triggers the schedule function on CPU Z.
  e) CPU Z enters schedule again, locks its own rq, and dequeues task p.
  f) As part of dequeue, it sets p.on_rq = 0 and unlocks its rq.

3) At CPU B
  a) CPU B enters try_to_wake_up with input task p.
  b) Since CPU Z dequeued task p, p.on_rq = 0, and CPU B updates
     B.state = WAKING.
  c) CPU B via select_task_rq determines CPU Y as the target CPU.

4) The race
  a) CPU A acquires CPU X’s lock and relocks CPU Z.
  b) CPU A reads task p.cpu = Z and incorrectly concludes task p is
     still on CPU Z.
  c) CPU A failed to notice task p had been dequeued from CPU Z while
     CPU A was waiting for locks in double_lock_balance. If CPU A knew
     that task p had been dequeued, it would return NULL forcing
     push_rt_task to give up the task p's migration.
  d) CPU B updates task p.cpu = Y and calls ttwu_queue.
  e) CPU B locks Ys rq. CPU B enqueues task p onto Y and sets task
     p.on_rq = 1.
  f) CPU B unlocks CPU Y, triggering memory synchronization.
  g) CPU A reads task p.on_rq = 1, cementing its assumption that task p
     has not migrated.
  h) CPU A decides to migrate p to CPU X.

This leads to A dequeuing p from Y's queue and various crashes down the
line.

Solution
========
The solution here is fairly simple. After obtaining the lock (at 4a),
the check is enhanced to make sure that the task is still at the head of
the pushable tasks list. If not, then it is anyway not suitable for
being pushed out. The fix also removes any conditions that are no longer
needed.

Testing
=======
The fix is tested on a cluster of 3 nodes, where the panics due to this
are hit every couple of days. A fix similar to this was deployed on such
cluster and was stable for more than 30 days.

Co-developed-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Tested-by: Will Ton <william.ton@nutanix.com>
---
 kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..4762dd3f50c5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1885,6 +1885,27 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->rt.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	BUG_ON(rq->cpu != task_cpu(p));
+	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_donor(rq, p));
+	BUG_ON(p->nr_cpus_allowed <= 1);
+
+	BUG_ON(!task_on_rq_queued(p));
+	BUG_ON(!rt_task(p));
+
+	return p;
+}
+
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
@@ -1915,18 +1936,16 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
-			 * migrated already or had its affinity changed.
-			 * Also make sure that it wasn't scheduled on its rq.
+			 * migrated already or had its affinity changed,
+			 * therefore check if the task is still at the
+			 * head of the pushable tasks list.
 			 * It is possible the task was scheduled, set
 			 * "migrate_disabled" and then got preempted, so we must
 			 * check the task migration disable flag here too.
 			 */
-			if (unlikely(task_rq(task) != rq ||
+			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !rt_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+				     task != pick_next_pushable_task(rq))) {
 
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
@@ -1946,27 +1965,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 	return lowest_rq;
 }
 
-static struct task_struct *pick_next_pushable_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_tasks(rq))
-		return NULL;
-
-	p = plist_first_entry(&rq->rt.pushable_tasks,
-			      struct task_struct, pushable_tasks);
-
-	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
-	BUG_ON(task_current_donor(rq, p));
-	BUG_ON(p->nr_cpus_allowed <= 1);
-
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!rt_task(p));
-
-	return p;
-}
-
 /*
  * If the current CPU has more than one RT task, see if the non
  * running task can migrate over to a CPU that is running a task
-- 
2.22.3


