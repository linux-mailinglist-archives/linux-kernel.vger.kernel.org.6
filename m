Return-Path: <linux-kernel+bounces-322750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E96A972D42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8481F261CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C861862B8;
	Tue, 10 Sep 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CStVcJs7";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CStVcJs7"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BEB12B143
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959833; cv=fail; b=mQYoPWHTlfFsRBKdwg16WqlIibociBAWX0N7rPNDY8NuCVvh2y7wKR4ZQzBSgsjtLeZbUADZUsDI+kVMd1y4Zb1vFKaQTkk4ZGUitTsg5npxpsbdo908uketF2KaXGHCj0J0qylkKFouZLkmTqse1hUoErTpfmNJzUfGoNR6hYU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959833; c=relaxed/simple;
	bh=PPlxts+Uzy+ne5fS11KpcUNXU7Uu7z22N9rj2dn/tUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dn9QP6STV8+6cw2jy50sPpzmqX6voZm/DkhWVi2E4r90H85zqXMR7bLd5iwm45HjXR3wtH0BViZLt9Wapt6Xqd83ywIlNUc+kc/7cvScjIBlqpSeQrdVp6drocnCg9vQQm9AzyTt5J2j3k4puxo6GK353egNvzkGBYxucC1DRmw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CStVcJs7; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CStVcJs7; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QbxCMAH08ESAHyxgCXgd6SSTzd6cPct6L4udywZBh+88O+JLj17fDDj09WSGrXFqoM9KNIItb/0+Flmox32UG7BZ7UwFkutqGqGDEdKCZZekudQYRIA+CmzRMmfzoUWi+8lPVk6ejUOORtawvFVjvBeLMUKruaZKN8BU5XEcCLUctLdk96JSp3yXiCeVZs/Uehv6ZpwdEelHRIqpMMSFJsUAP4cMJ74lNCJ1u/eOT4B+4Ir8dytXP7i7nSoy3qpA/ovqeeC/HNBqaPTXk64MeYrbfRUE8v3D9sX9JxQdXs3v6a8WOsaMMmNDowWeJD/Yjf/QCwLtaY30Nkm5qHbgzw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOHYovSq+tCFI33yohpOHIqjWjCk6SJy9xFwle6l8QE=;
 b=Jwt31PPg7YZbXeIe5E1595aK7OtgVM1WRcIT5q6geFj55dL2EF+wRRXxWzmnDhLf64CxbXVlmRCOT/LtG6LZ6XRtyfxwHPT3aE+8yjQN+8xbeMNX34/IC3NUWb42Ccd9vZ6Gws+8NxktYNlhinbuTEP8EwMAVKnsbp2hqF9sKZRpA76oQ5GSNsPCN+ABtLKquPCYXt/U2XEalkGhcx6fP5pbk1Lau0UqrRC3D6Xb4zhCdUmLXKuggqqXtCAn1XVnjmla4HqA8lFp3WKqNuBF0RKo92Yz3NlvDJU4tfPYKPUBkzE2oAQT7qex8zlhyZrfzVlEbssKDPO5F4VLM/YNnw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOHYovSq+tCFI33yohpOHIqjWjCk6SJy9xFwle6l8QE=;
 b=CStVcJs7LrKdTva904IXaLQyS1EX7xJaIKWFyDBQzIyjJ+T9/QWq7fSVLU/ZWNmAC7DPgTlvZqTDEQOVIVBupxkEtCUJ+Bg0o1Dy+xqpsLpixCvtT8Iw31JwP3WmYy8JEbGiQTO/0HrwExd6/ddX4i/FWmVlYfLHEvj9t65HHfw=
Received: from AM0PR02CA0190.eurprd02.prod.outlook.com (2603:10a6:20b:28e::27)
 by DB4PR08MB8175.eurprd08.prod.outlook.com (2603:10a6:10:381::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 09:16:59 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::6f) by AM0PR02CA0190.outlook.office365.com
 (2603:10a6:20b:28e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Tue, 10 Sep 2024 09:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 10 Sep 2024 09:16:59 +0000
Received: ("Tessian outbound e4724f7f9992:v441"); Tue, 10 Sep 2024 09:16:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f1d705a6b7cfa0b1
X-CR-MTA-TID: 64aa7808
Received: from L4289199c4432.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6719B9E0-15DF-4E3E-8964-2164FE0DC197.1;
	Tue, 10 Sep 2024 09:16:52 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L4289199c4432.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Sep 2024 09:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C63LlULF48AhrlwpOiwE393R8++Lzz1AfUQROQnYRC4LvG4/LMFLfiZhE7eN42OKIGpWN9ZPHMx3DjM4tAZTyFA3djnv0E2iptVJkIvLP88DlczBNzCjde50Nl64HH7l1VRIyhxLf5q3O2G/cYIFvvwikukxuOq6ZxYvwHkvCyXD9UtOKTdh0OIHqqB3Ybj/sT/CiY0x6IxOm6zC5oBoFYp7UEM4XxZeHb4eRxrLe7DgIHJ7HatqiUIl1DDu/dBhDnoA36Jx/kvkr+I5B22q71ARpC9e1n4LN4xLsWCOUnLbja4Nj3RsR0iVl9uSDFTNyKAT4fIvaVyzbbfpQQGAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOHYovSq+tCFI33yohpOHIqjWjCk6SJy9xFwle6l8QE=;
 b=CJB5p6wBuSzbJpJN35IrhYrOCQQjA+JobfcgQjWYT/cx5DMT3qtmZdNwdbFXwcGIBnei2HLc7UQpPkWjAe26UqacJQkQU98dwzAa6aLdPJr+U2s52m04szvvr44IsWz72zvjiC8QCneAzkpDOA/g03Uf46ZWrsF6yGy52OP9AQoc4lIWo6xEvcfLEr+VZyIp+uxw86pKDj4PKIzsvsALrCYYfQhC2X4OIY+AEtd5zyPkfBg1dLTfoEXSrTnJKffynfReFRdlD6Zkm8LYiMh5DssqPKgd66TxHvwzXCrZd7tlMCvFlcAf6CstL0BCpy9vcGnnrwpfJhpi1Y2o0Lyxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOHYovSq+tCFI33yohpOHIqjWjCk6SJy9xFwle6l8QE=;
 b=CStVcJs7LrKdTva904IXaLQyS1EX7xJaIKWFyDBQzIyjJ+T9/QWq7fSVLU/ZWNmAC7DPgTlvZqTDEQOVIVBupxkEtCUJ+Bg0o1Dy+xqpsLpixCvtT8Iw31JwP3WmYy8JEbGiQTO/0HrwExd6/ddX4i/FWmVlYfLHEvj9t65HHfw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by GV2PR08MB8051.eurprd08.prod.outlook.com (2603:10a6:150:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Tue, 10 Sep
 2024 09:16:42 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 09:16:42 +0000
Message-ID: <ee0badcb-e507-4e22-abb1-ff6c88ef8899@arm.com>
Date: Tue, 10 Sep 2024 10:16:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] sched/fair: Prepare pick_next_task() for delayed
 dequeue
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105029.747330118@infradead.org>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240727105029.747330118@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::9) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|GV2PR08MB8051:EE_|AM4PEPF00027A6C:EE_|DB4PR08MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 97417cfd-e41b-480a-a30d-08dcd1795304
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cmNjbTdHVzE2dDNBNmFHZnRrMFVEeGFZYmJQOFdzV1hVQk9kbTBqYllqMzNB?=
 =?utf-8?B?UEFFSjNybnpybzQySSs3K05BdVpvMUZMTVhPdG5DYnJrbkpQZTQrTTAvM3VU?=
 =?utf-8?B?YXV5MmpPMjNjT1J0anBza0lya0V1Zm1hVk1Xa3hHUDlldlhhQTVlcmVva3dO?=
 =?utf-8?B?bWV0WWIxQkFmWTYvQ2NhcFUxTHoreDdvMjk5Wng0RzdOcExLNWkzcnBDd3N6?=
 =?utf-8?B?UWk0M1ZBcG4zcWdFSlhIL0RldmJUeTRaWXNETlVsMHQ5bHlIUjdmaDBZZzdo?=
 =?utf-8?B?VXlVeUtwTXg1Q1BGTzNISEdMZURhVWRkRkZGbTVuNjQ1c1MwSlp3SVlPTUl5?=
 =?utf-8?B?VmovdzBZTmNROXNZVFZFRE4zMkxVK1Blc01mVVJON3R3bGF4TTUyRFNIY1pN?=
 =?utf-8?B?RURiS04rV3YreHZGc3dzbmtyQVdCNW9tdW9WVlowRDNXTGNVSndJOGprN08v?=
 =?utf-8?B?U3Y3WithNGVFL3BJQjVJT2dCbkc2THRERUFWby9LZUtPZ2o4Q0NoVkNTMGk5?=
 =?utf-8?B?OFVCUXllUjIxM1BLL2w1bHJGV2hzSWRvZXdaZ1M1K3p6R3hXaHdHdUR1VDgr?=
 =?utf-8?B?azZIYlZqSFhBb3NMdkRCWG12Zmg1Uk04aHE0VXdXQzJTMVdlSXQveHJoKytx?=
 =?utf-8?B?T2Nqb014Tmk3Skw0aFJwOFBTZUt0bUh2aHVkbWJIZTFZeVlqdCtpTHY4N2Ja?=
 =?utf-8?B?OFEzN0o5WmxEVzJGMG1QSnNMOFpkM2k0Y2xDTHRZRUhFM2xkKzYvQzR1WlYz?=
 =?utf-8?B?bU5VOGljN1FmWXhJcEcrb1FQOWRRcjVtSGVoWGZ0QWJLRkwydUFWQkV1Nksy?=
 =?utf-8?B?UHRQQUdRTFFjaFgwN2NUM0NFYit3ZCswNElrL2U3akdscWhSaFRMb1Z6Z1hW?=
 =?utf-8?B?cVZUaG9uQlpJcHRFWU0yRHhEMmhRb1hSQ2lFZ2xGLzZyYmV5VXMxeGZkVFdj?=
 =?utf-8?B?VFQ0YWtJd29ZeDBhbVFSR25YTnNTWFI4RTRoYWlXaEdBSFFHdUNUZG1nWTZk?=
 =?utf-8?B?L2owNzhZS3FyZ201ZzdsSVA5QTc3UG5ZeXVpa2pmQXdHL2RNaTZtVWJORFpa?=
 =?utf-8?B?bldHOXlBVUQwQ3cvMXppZ0g0MmhOWFpMOXVsa2xvVVVRM0FXcHN6SUVkTUZR?=
 =?utf-8?B?WVVHUEd5SFQ0Y1IxQWh1VjJ1RGMzK3ZVcWJJS1gvdzI0cjBVdFJ6WkNndjdS?=
 =?utf-8?B?anRUT21VOWE5Y1k4T1N1YmR3ZzZ6eUxnc1RveTYwMDIwMWI5MVp6ZVl6ZDNK?=
 =?utf-8?B?UXlHakdLT1IwWFpIK3hoQzAyWlRJcm5KcFgwcmpEa3JUaGNJR1UxN3ZzekQx?=
 =?utf-8?B?a1MrRGpLMllDOEtSekVRTXQwOFk0Yk9GQnlEbndqZHg2NFBWNnBOUysxYWQ5?=
 =?utf-8?B?SHVpSExpU0ZPa05rZG04MkMva0JDeENPN1ZoeUJUM1l1cTdoNzdRZWhaa2Vj?=
 =?utf-8?B?MTFlMGtuN0pibWRSbGU3c3hiY3NDeThGdFQzU2hlZkl5dEgxNnl5U3p6NCs3?=
 =?utf-8?B?bkQzaWIrOVBhYzNEQmhPQnRHcWpvUytpVnBKWEdocDNHQ2Z4SVNQUklERDNQ?=
 =?utf-8?B?aFRqSDJaZGRCaHRZT2hwc1VDNG5mbFdIOURYcU5SQ0xFbitlVUVsbUpEd0Rs?=
 =?utf-8?B?dXB6SGZwYXloRVg0bjk0VWtPa0dibWExOUFGc1Z6QlpqY3B2aWVsSkl4NVIx?=
 =?utf-8?B?Zlp0SGdNS25LTzRrZGNtL0c3SW9FY2FwTTBMRWhNcFUvK0tLRjgvSVlSSVRL?=
 =?utf-8?B?aWdScFBkZ1NNMU5Qb0k0dHdyMTJoQ2lIanNwcGdBQjFsU3pHZU5lM0poSjFq?=
 =?utf-8?B?UnFTVDhKYVZNYnZDRG12TW00SU1ndjA3RDY3bjRlZHpodml4M1ZoSUxVNUZP?=
 =?utf-8?Q?G5GI1XAP393ex?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8051
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1b8b692d-1296-44e2-c431-08dcd179488c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTROa2dlOERMOXZXQyttaEwyT0ZHWCs2L1lEcmd1eE9LQjVEWEU2cEt3UUN3?=
 =?utf-8?B?UTZMZ0JqSmNnNnhWN1V2UXEwOGp0b1VqL3dzc1I4YmYwWVRESU5UZDZCWncw?=
 =?utf-8?B?T1FmWlo3d0NSQlhobEpVZjhadE1ENWZCRmNia2R0UGhlVTZDZUJxYVEyQ1Yz?=
 =?utf-8?B?bFJtbTFBOHk1N1ZqblVNeW91UE10SUQ2YUlxY0VJWTdnRWFCWnQ5eGU0cldM?=
 =?utf-8?B?Zk43Vk8rd214QlBQMXJQTWd6NDBDbGdKS1BYT0VjUDFVTUVtUHFIRzZsa1k2?=
 =?utf-8?B?UXltcGovZ1lTNXk3UlJDY2dGcExIU3hWZDA2WTQyUmIrdThNTldIOUFLc0l1?=
 =?utf-8?B?bUM3TDhNcGJCNlBremRGZHUwTTJuVFBSa3JYZkRRTUx0Rk9ERTlnVmFRT3ls?=
 =?utf-8?B?VlZNM2VkcGxLdHlQeVg1SWh3Uk40Q25VenJybEp4VFBpRlk5bnBmMGdLWTFI?=
 =?utf-8?B?WDZwOUk1dHYvYXVVL2JvMXRXN0NFN1haMkN6Nkc2eFdGa2xMM1dIVi8yL05s?=
 =?utf-8?B?Q2szZFM0VFZBUEx3ajFIdVRkMjYxZ0JtL3VqdFFpdUl2eWFjRDIyVzFkRkFQ?=
 =?utf-8?B?ZWNNenZXOC9lWE1iZEJ5ZzRwTXM3WFdVUW5zREdIem0wUWEzY1N1NXFmelQ0?=
 =?utf-8?B?VzAzdXlqUjhnb1p2aUZkSXlkQkFsQWF5VWozQjJ6VWRMQXYxMjlUaVVFa0JX?=
 =?utf-8?B?TUFOQnN4ZXFFY0Fja1pZeXJja2kyWmlNUHZObExxVENkcjJ5Qll5dm1JYVVX?=
 =?utf-8?B?QTNteUF0WWtNN2VLc2ZDblZPMWlUQlRCRlhjdDdnSjFYdXJESEpQY2tLYVRD?=
 =?utf-8?B?Y2ZKYWxRVG9GQmNhSFVidElyRGlFQjBYT3ZsaXBOMGhuYlYxSHczaXRwcllp?=
 =?utf-8?B?Zm0yK2JxeHRIRGZmNlU3RmxwcThkZGdBUU8yU045QnRrc21RbFhkY1ZPT0ZW?=
 =?utf-8?B?QWRGTldINXpnQk1LUkQ4Z1RsbEtnWWZWZkZoaElZcXZpQWRvcDFHRFY5bGVS?=
 =?utf-8?B?Z1ZPdHBibzlQMDVZZUlodHNKVjVTTFdMZ2hBZ0FzWG5zM3NubWRQZVNGVEpS?=
 =?utf-8?B?ZG1GSmEwM09IWjdnNWI3YTZQQTN3QTllTUNjRXVydWxZRUtRU0dOenN0cm9F?=
 =?utf-8?B?YUJCZ3RnY2ZjR3BOeEpPQU1ZdGdPUW1qWmFxb0owWnhOcnlDcUR0bGtjelhz?=
 =?utf-8?B?N0FSNjN4eXpZZVhDSGppeGV1WVRvdHRhM2daY3Q0TlhEbSs5U3BGVDA5TmRX?=
 =?utf-8?B?Wm9IMktVMVF4UWpRMjFGbWczOTJ6RTdJTG1PSkdXc3dzMWF1TUtGaWZ1dVdF?=
 =?utf-8?B?WDZaWEEzUnVqYUZJM3JPZS9raUNEbTV0dEtNb0dENXFSZWdORzJwREN0OXZE?=
 =?utf-8?B?akc1T04zTndaTXZhT1JyZDBPZE1Pa1czeE9oVmVSbGk1ajRRRlVmYWUzclVV?=
 =?utf-8?B?Nnp4L3Rkd0pFalpOTlJzTWVycWtuY1NCWXZSenlWUXNITGlsdkNieVV0Mzhh?=
 =?utf-8?B?M2tJazg2K0o2a1VxblJzSlo5YXowK09LS1U5Yk9xeTBsbzhWb1ZaRDJsdXdE?=
 =?utf-8?B?di8vUHRvbXpHZHBKVkFhV1pMakZxbW14d3g0TlRFUlR3VGtmMnk3SUlDN0pO?=
 =?utf-8?B?MWROR0t5c3ZsdnYrLzZmdDFyRjkxdTZFTTNRUEk5cE5PUjIxbU5TQkZZdkNM?=
 =?utf-8?B?bWxYRW0rSmd3QkpBdlpGVkYyMjdQYXhLMVZHTW9aM0tUTTE4dUl1TmxDL01Y?=
 =?utf-8?B?TnhIUzYzVGRQZDU4N3p4WXZtaDZiVVBNMHNUZit5OHo2WG5jczgxclhLdVcv?=
 =?utf-8?B?QUhKaG1qQURGcndlZkJLMVF3V2daMUZHQjMxblR3b0QyU2RCK1VTK0tpUWVY?=
 =?utf-8?B?aTIzby9OSnhqQlc2NlRRMXdBMTFaRWZNSElJZFNCMTM3L0tZOG1qaFFiOS91?=
 =?utf-8?B?SnRoeEdPLy9PWDhLM0NBbkh3TW1NQitUWGNGSlk2TTl5RVVXV1V6Z1J2NUpF?=
 =?utf-8?B?MlZhSndLcFhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:16:59.3203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97417cfd-e41b-480a-a30d-08dcd1795304
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8175

Hi Peter,

On 7/27/24 11:27, Peter Zijlstra wrote:
> Delayed dequeue's natural end is when it gets picked again. Ensure
> pick_next_task() knows what to do with delayed tasks.
> 
> Note, this relies on the earlier patch that made pick_next_task()
> state invariant -- it will restart the pick on dequeue, because
> obviously the just dequeued task is no longer eligible.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5453,6 +5453,8 @@ set_next_entity(struct cfs_rq *cfs_rq, s
>  	se->prev_sum_exec_runtime = se->sum_exec_runtime;
>  }
>  
> +static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
> +
>  /*
>   * Pick the next process, keeping these things in mind, in this order:
>   * 1) keep things fair between processes/task groups
> @@ -5461,16 +5463,27 @@ set_next_entity(struct cfs_rq *cfs_rq, s
>   * 4) do not run the "skip" process, if something else is available
>   */
>  static struct sched_entity *
> -pick_next_entity(struct cfs_rq *cfs_rq)
> +pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>  {
>  	/*
>  	 * Enabling NEXT_BUDDY will affect latency but not fairness.
>  	 */
>  	if (sched_feat(NEXT_BUDDY) &&
> -	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
> +	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
> +		/* ->next will never be delayed */
> +		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
>  		return cfs_rq->next;
> +	}
> +
> +	struct sched_entity *se = pick_eevdf(cfs_rq);
> +	if (se->sched_delayed) {
> +		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> +		SCHED_WARN_ON(se->sched_delayed);
> +		SCHED_WARN_ON(se->on_rq);

While exercising the h_nr_delayed changes on Android/Pixel 6 (6.8-based), I ran into
a situation where pick_eevdf seems to be returning NULL, and then we proceed to try to
dereference it and crash during boot.

I can fix it by guarding against a NULL se after the call to pick_eevdf, and then the code
runs OK from there as pick_task_fair will have another go at trying to pick the next entity.

I haven't checked exactly why we return NULL from pick_eevdf, but I recall seeing similar
reports of pick_eevdf sometimes failing to pick any task. Anyway, I thought I'd point this
out in case others see a similar situation.

Back to testing the h_nr_delayed changes.

