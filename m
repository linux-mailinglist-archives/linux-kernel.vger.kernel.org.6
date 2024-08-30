Return-Path: <linux-kernel+bounces-309278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551B4966873
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0291F23E92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C813314E2E9;
	Fri, 30 Aug 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DE5e6dY7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k2R/7F7p"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B41B5813;
	Fri, 30 Aug 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040506; cv=fail; b=W5XpxG64Rp2Oxon6McOU3UN0oyD/i8UCSvMnlLFTUrgo6wtb++v97759IV3p6H7dRwzc1biEGCLS8lJKA/nb3OI5etGGiEaNTyPNVMPhF+rU2y7hfEildrBEyBRzsJTSUGb3oe8PU3YFNQfwMh3hC01ZR2hUWv0gnq35xIxr8MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040506; c=relaxed/simple;
	bh=HvMJbyclTdiHrBRVQBLZ9ws/xs03NXOpmtqliyKCJgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=g83Oy6QQsiALjiwVT3+qMc8VqlTzLJSiiY3WKLHmp9TdUCcU+yPb9uNLR/YB7fojU2FK3pCurykQ6z0nuWk92Lfw71DChQP5qhMOcRb1D1sleeVVmKHyDBbq/1cGdtAEvv4QMiH/3mN7en++r4KLBDO1JiC5Ph1MbvA9rPdpO1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DE5e6dY7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k2R/7F7p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHfXcO009515;
	Fri, 30 Aug 2024 17:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=z+/ZOOHUCXR0n+
	7Bte3thMiUYOSTidpW+YT36gzG8A0=; b=DE5e6dY7KWPkVFoSjRY32XZJ8tgqZR
	uC97P/iqDY+tMOTlorUaQ8v1e2yj/bWm+5hPiPuCLDA+E94Py8gQT2/YH2rcsWjA
	Cc7aVAiVoYZ33zMePo0sMPDFNzMSi5w93pVu0mo0M6zsRyJ4YCp1Rls+OlImCnXg
	dkmwe+6LVMPitDZwJIyssINVGTA3Vj5unAYE5XBOhi+kIDAfNNs7l6yiVw/ggOYW
	Q02JaIMsIrJRWmCBSrr0Qe6pExx3Jg7dv6o4XOQNgAugkfnuODtwL0hxggs/DS7M
	ycawhm5wR3IvIuOVUfhZWaUwRzDtFCyFYxmX4629UBdomTzgzBs0/cYg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfgj8fyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:54:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UG8GFt031831;
	Fri, 30 Aug 2024 17:54:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0ybu3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THyqbniomX9GmWunM9TI7ME/IM+I4PRL7qzaGAyk9eyDWCDqVDHNcpkKpEOWGh7J6XZItwgaCVAH1sC2DpKfBRefE8/XEzSlj89nyJBzw35YpDGA1z7NuenBdaE9U0gOj7oO+A7i3XsI97q4Hw41kR4X17SnRYL1ubzu+jMskKiHKZjPD+aaTOhV2PwB8O43Suga/DoYDyEYZjd6u5FXdv0n0ympRG2GbGCrPkQurEPWbp5PXeYBzdTb9cqlqeT2S86/0RFMRH4RS1PUWzvJjm/r6oxZd6sx9GlA+kJUdRvh3B1bcxo4lnQrzIpZ5YLIBZIRfPA1RaWNVwWlw64zlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+/ZOOHUCXR0n+7Bte3thMiUYOSTidpW+YT36gzG8A0=;
 b=YG48akq3NRidNHy5XZ/YpMhdCGfgGINNNOOrU4RJuEnv8UGOuhkvrJrX7I4oBVgbkpxPdOrXXl6oiQE42B7jsg9KBoiQNbHM9OthjITaLUShUKyZf0fa47T4+q4GuFUGy71oFvoVD9oNUyIiPlhdz978ZbZdkQi6ipIVVU8233Q0eeXHEVbumT3tot2TItBGjsjGlieu4pPYxdpLTVKd1qdKEa7citwvMdEYTLta10xeMFIElo72ErTwoaLos/gw0AyXMri9BF8ctaKCLo+/gPTMpE07kScMrb5UmY1MMwZPgDCdGBRiFrB+LxbZS9HNlC5Y9xeYKMHTdRK4M5gq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+/ZOOHUCXR0n+7Bte3thMiUYOSTidpW+YT36gzG8A0=;
 b=k2R/7F7pfYI1ktGMiUxXNtRNt2Qm35Vk4I1uNibieH4qCj9GkX0tjegs5uylYN0I7IXXdjetKhHrP+KbgTEc1DkIsc0Y5Oahq2mpEEerp61D3Wpwh6/taH5UVe68xRxJeDbd13fOItKRNdMFkkMqmMpU9yz56NZ395vex+x5TUY=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA6PR10MB8184.namprd10.prod.outlook.com (2603:10b6:806:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 17:54:06 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7918.018; Fri, 30 Aug 2024
 17:54:06 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        hbathini@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        ashish.kalra@amd.com, michael.roth@amd.com, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>
Subject: Re: [PATCH] powerpc/fadump, x86/sev: Inform about unconditionally
 enabling crash_kexec_post_notifiers
In-Reply-To: <20240830141752.460173-1-gpiccoli@igalia.com>
References: <20240830141752.460173-1-gpiccoli@igalia.com>
Date: Fri, 30 Aug 2024 10:54:05 -0700
Message-ID: <87bk19rj5u.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::20) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA6PR10MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: b287e088-6aff-473f-1628-08dcc91cbe28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ebtxeDKb9g6s8Mdfdx7mH4sj//BYxHohhFr4NKjIQRj6VIUUhxzCjW0yU6C?=
 =?us-ascii?Q?k78ANHiGZF9BMSr8wii1u6Dv2X9DijIAUgoV5URKFqdns1DbMECvDLdqyIKZ?=
 =?us-ascii?Q?G16P/dI2mzyhJAJlyrh57aFU0b6tA0wzAmkTCqFscYrlgPhIxQ/Og+V+qyHa?=
 =?us-ascii?Q?St0n7u9YGiFHMHorNxOONBqkwFFSIoh6mWuD/NlnItKVH90rT+KBPefwQ1pW?=
 =?us-ascii?Q?SBSEF77BDzbfKyOpYLijKE3m5oTJHuMDsyrAU/NuWDsfIehhdg5uJFRejEW1?=
 =?us-ascii?Q?bk+v+ZvGcV03AJst8bI2mbtfYkfNxvxEM5odFNJd63UmI+BrytIfQFeZFyRi?=
 =?us-ascii?Q?drfc613NNReT+gHnT0g8YeRcp+LI/M2zUpyw2XDu5cwOtcs0yFZbYmQP/NM4?=
 =?us-ascii?Q?nI8p7Z/LXZMiLJLhKMhfe4GiEBI1TUczWd7tROX6hBXuHZlPa1kexvwBHMlC?=
 =?us-ascii?Q?LXxpNlo+gDkiOQIwRRdgeRm3NFjfgzwNcS2yKILpjo0vMfuq4W+JK8eCgGdq?=
 =?us-ascii?Q?/AZib01h5NXTqt8R/99QZf0NMnKPwG0kJchV3zRDmd3kgeWvmyWafBco0IjZ?=
 =?us-ascii?Q?jo5jkKFv4J2zfsuStFJTOM4OdpHK2ZafM1MwXc7exiodIilxHTuZpwlccwSB?=
 =?us-ascii?Q?oJpg6Q7Ze5GLoR1ActY+YtFDccY8XDQcVBtNvPT55XYY4bkFW0qJHXAOZ+yg?=
 =?us-ascii?Q?0l2aLhoP/nrGdofXjA8xgZCGKUWp3uu5ZoZIC8i6zzQatLQ/RrhnIVQAHvy5?=
 =?us-ascii?Q?J94qpdYygoBOI0BHRFcFd4ixB9uOQrCDFInzjc0KXao0mK1CilZ1H00kl9v6?=
 =?us-ascii?Q?dK4KRjOh9aagaVKvLPdBRVH4Wh/QWLiHgesCFlg9y3F+a96M3w6xq9U0jdR/?=
 =?us-ascii?Q?lQv26rYjKC6EkT9KQGCj6ImM6RCG3zeISCRUC9n+zuLBzGDBFGs1a/mocJFR?=
 =?us-ascii?Q?ABObjkQX8lCKsorx18rpbkr7hwWaI++h0ShecWQ8VwVHu1T9dkaPpR1t/pYs?=
 =?us-ascii?Q?Z+myD0rM4GlU2VHNghDUQsFccgqbolZ4BPxwGQe8TZVwlCTUK37OUtK0brW6?=
 =?us-ascii?Q?Egv/6xJiNozRziPp5g+hOpL2g05j0kVaKLTgiDPnsGbfXIWWIbOgdpAvvAPj?=
 =?us-ascii?Q?FvnSNpZus9kbfrDaIEIKJSsC3/mZZzdZ7K/U4OD0wBHYL8FY06R4JxCmDsew?=
 =?us-ascii?Q?2l8dvLJ3DeMiVnZd4WMr8bE2QIiKsKh1ANN/dIeVmyjaxmJ0MMspVV/+XpFn?=
 =?us-ascii?Q?//UO8uUKPbD84rtTiIy9t7OCltZF+XCutSuwy33ShFJxcSuHUBEMba6CuYBj?=
 =?us-ascii?Q?hHTziQ6nPcrau5wZN67qUCoSn9DH6STVAxfaDxkqdWKWyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eAmJxAqYTDj3zFXIf1DpVIiDJeBDkO/rHLY20k7AWsDuxUHD4asIXtJMtmvp?=
 =?us-ascii?Q?6i35pdodb27AuZsi2O3vk6zah/dofoy9Eth93upkifxJn8bpj6J9jL1wL1cV?=
 =?us-ascii?Q?OXayz9NT7z8N4BJPcCvwirQoCybD1HJ984ov8M9MqwdH4GVqKAnZ4X+LwDEr?=
 =?us-ascii?Q?0687OY72j9D39XEj57d9dG9g6CEneVgjc+x3ESWw8hnxWWSOeLCdECoCu6mo?=
 =?us-ascii?Q?l85gIoHQ+jSiGmk4SwGY/PoWx/LftHuqhy6Q+to5Eny7Qx235eeqLxu4iMKe?=
 =?us-ascii?Q?zQoEVRN7BczJq8fqY/QRP8GQitcJwPhcYbU4CHiymh9MeS4VqHIyUSS2PELR?=
 =?us-ascii?Q?Hff5EKiuaDCGzRISqgTxUzZNNBqDoFUNqgT9NyK+mgwAdHUZgXxLWgAW7+r+?=
 =?us-ascii?Q?Ry6kp9fmehPAnkfQ81EgV9fpe7AjnEqAmEcRoaN9kg6u3S+gXuwaUAFl+ilZ?=
 =?us-ascii?Q?gPpgBsdwX0JGjzu4PYi5KIF1AVLz7gDdNy/d/bmHwdRd/rDOIgeyC6pb9obM?=
 =?us-ascii?Q?LIdJAwuc7vJSXTqHfCJ0OK6czcaYeuoUV3V3XByvi4N8mwjYBQckZzM+HTdk?=
 =?us-ascii?Q?HsfZplVIWGRXEwHJVhFM9ySODOuTetwWtna4hMv/FJj3Ju8YZfRD0UhhKeTP?=
 =?us-ascii?Q?96visNJrBOn7EkkUgN9i3ZgwlYOdYfw9xXepQFksH6485a1OesmGLq7YiP0d?=
 =?us-ascii?Q?yiKyf5uYBQHrfu9+rnsnFZXjbbJJL1jquLu0t4ShJ+sJgevaIGkfGUMNSPrj?=
 =?us-ascii?Q?kXUk/rBtBDrh1sM6hZlZw6oQkw62qC1OspeEHdS7sbnq665PlVIxm370/Olj?=
 =?us-ascii?Q?ldNKL9rkLrMXlF7KvT8TMahe/hAWikaDpP5SujYXpIOBxbLpueOqtX5ZiyP3?=
 =?us-ascii?Q?iVnQMHeRqnb60QRQiuniGktwTK+oBE+RvIq4O0MzNLQdIl17QLdF7G/jjkTB?=
 =?us-ascii?Q?u58QK1jaNAu/QlmM3WCSsPmWQQda/QNWZ32xbOJIjW50ZeK60LqwNrOHxoQH?=
 =?us-ascii?Q?5b2Ts8bMpGCxvw6vCMFeRne28v2P9hYRYl+JGOubSeO4osSdeR0xI96CZ4yI?=
 =?us-ascii?Q?B4gaO8V5oGp9s2DS7YPeYYjTrksAty7+ts5If10Vc6sNHOPXQA9mjqHY3fSe?=
 =?us-ascii?Q?lag3/wlw21lgsusYGihO/r9TrzswgszOH129kyy9sSyGlZ/MYiDqHX30heJc?=
 =?us-ascii?Q?/xWVLVu35Ek4EVDm9/u3gZlLZD7JK6KW8o3mStwvF7qCK/IBH3QMh7Ordzi3?=
 =?us-ascii?Q?TZnfxGAlCDB3bMUX8hAaJS/1xq2F1z8yrqCirnDmqoKJ8mfozjU9v6WBPiHl?=
 =?us-ascii?Q?DK9o3HAUXjx/IIcphqKWSsWGmWDfvUarB+dO7cCe2eqTp137MYCQHuIJsU8t?=
 =?us-ascii?Q?VTTjcKWNLC3fnDRRfNNGuKfqM3ysSiYNSVEPLXKM60tUKBCZ9VFoS1Cq7zRN?=
 =?us-ascii?Q?PtXFG2ERwzJ1PIC8fb9Raue+8GYTFyjjL4SwLfFf/qApBhCFQ0k1eJvI18C6?=
 =?us-ascii?Q?CJXDoK+YlU1wkLeOhhPKcRz8PKyzaTjJr5Qz1p+3cfttfbFV8ioZ2zr7ccNQ?=
 =?us-ascii?Q?9vUH2wIvUgceVO3LkDL+8zP1TwZnmaCVlDrfAdNgsBubg8+fu84B/uE9Njya?=
 =?us-ascii?Q?maN29lPTo+XIWITrONDHXwU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bvBkoezyzm1Vk00LHMhNdcH8KG9Tb6qiMXOpiNw6CNbc94pDSO8o36LcGHW9TNYMXQYxZR9d3angUaZJBTxURJ0xQmzAC+zAP61pgh3dlNcHWvU/WddTxK6HTKjvDc5eJcIa+aAgsN0tlKRZSyozkKjkuChxWJ7UQEdOTSdjXFnsfix/S7yMyShjdd1Xo9BoGYvqmUbRCyhrHK5SukGkr8A35oZyKiJ0mOJYiVSdb2fPmZN5peXFrGjybVRKXR66IsLGiNsx2a7YxGsuHvRt3yQwAJ2UR9KsRUNP/Cc5H+DcbKCZ8LPprwRTbkuQsihGs06Wvkn0PF/3ddKsqKjKsB+Xn1EjrvxNLNPOLK4B5kbYIdGxfxZLMOK1PCzE7r3Ygpxjv+bk+gVGNbK/oDd6F0W9tAWgWdP9qfLvXT8L6f+Q8IORjOdkLvYJFPdG2OpfvyukZ5cLB9OP4leV9+KOVYTWk1QVJQuyUuM7pMyx58aQC2OjDtyPed9oKi1y82PK/XKs2U39p5aDzOBn0BU2vOSpPqTFq7vS1KlAKl7aR//OjMENpvYJqNpYdkBA0oUqPGfWKNmuuhdrfDQXO+Ul8yH9rwe60hZNk9LihVUPCiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b287e088-6aff-473f-1628-08dcc91cbe28
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 17:54:06.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxVUHty0aa8RhGS9/uLkcmWkzixOWek7WVZC/gvcyW8Jh5+JMLUAQMr+DiIqUDckIuipK23OfbVgfCUUQcMLhlBR97fspPYsZEM/nbQie5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300136
X-Proofpoint-ORIG-GUID: 8biCDv4jBTiigYQ8tiBG8hKoWPDQVM2S
X-Proofpoint-GUID: 8biCDv4jBTiigYQ8tiBG8hKoWPDQVM2S

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> Inspired by commit d57d6fe5bf34 ("drivers: hv: log when enabling crash_kexec_post_notifiers"),
> a good idea is to signal on dmesg about unconditionally enabling the kernel
> parameter crash_kexec_post_notifiers, which affects how kdump works.
>
> By checking the source code, found 2 more cases besides Hyper-V, so let's
> print that on dmesg for them as well.

This is a great catch! One of those was already there when I sent the
original patch, but the other is new.

Could we maybe go further than this, and delete the public declarations
of crash_kexec_post_notifiers in "include/linux"? (I see two). We could
replace the users that set it to true with a function that logs the
change so that it's impossible for new code to set it directly without
notifying the user. Something like this? Compile tested only for x86.

commit da8691a25d7b0c2f914720bc054dd1d9dbe4b373
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Fri Aug 30 10:49:24 2024 -0700

    panic: make crash_kexec_post_notifiers private
    
    This requires that any in-kernel user setting it directly must log the
    reason so that users are aware their panic behavior may be different
    from their configuration.
    
    Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a612e7513a4f8..9966f29409599 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1818,7 +1818,7 @@ int __init setup_fadump(void)
 	 * lets panic() function take crash friendly path before panic
 	 * notifiers are invoked.
 	 */
-	crash_kexec_post_notifiers = true;
+	enable_crash_kexec_post_notifiers("PPC/fadump");
 
 	return 1;
 }
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ce17766c0e52..6e9f5f8d13cc5 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -256,7 +256,7 @@ static int __init snp_rmptable_init(void)
 	 * Setting crash_kexec_post_notifiers to 'true' to ensure that SNP panic
 	 * notifier is invoked to do SNP IOMMU shutdown before kdump.
 	 */
-	crash_kexec_post_notifiers = true;
+	enable_crash_kexec_post_notifiers("AMD/SEV");
 
 	return 0;
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9c452bfbd5719..fa3bbb66235de 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -303,8 +303,7 @@ int __init hv_common_init(void)
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		u64 hyperv_crash_ctl;
 
-		crash_kexec_post_notifiers = true;
-		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
+		enable_crash_kexec_post_notifiers("Hyper-V");
 
 		/*
 		 * Panic message recording (sysctl_record_panic_msg)
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 54d90b6c5f47b..697184664c6f4 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -31,8 +31,6 @@ extern int sysctl_panic_on_rcu_stall;
 extern int sysctl_max_rcu_stall_to_panic;
 extern int sysctl_panic_on_stackoverflow;
 
-extern bool crash_kexec_post_notifiers;
-
 extern void __stack_chk_fail(void);
 void abort(void);
 
diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 41e32483d7a7b..97c31cf5c2fdb 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -7,6 +7,6 @@
 
 extern struct atomic_notifier_head panic_notifier_list;
 
-extern bool crash_kexec_post_notifiers;
+void enable_crash_kexec_post_notifiers(const char *reason);
 
 #endif	/* _LINUX_PANIC_NOTIFIERS_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6eb..634c6b99717c5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -33,6 +33,9 @@
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
+/* Defined in kernel/panic.c and needed here, but not intended to be public. */
+extern bool crash_kexec_post_notifiers;
+
 #ifdef CONFIG_CRASH_DUMP
 
 int kimage_crash_copy_vmcoreinfo(struct kimage *image)
diff --git a/kernel/panic.c b/kernel/panic.c
index 2a0449144f82e..f4ae3abbea7ed 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -137,6 +137,12 @@ static long no_blink(int state)
 	return 0;
 }
 
+void enable_crash_kexec_post_notifiers(const char *reason)
+{
+	crash_kexec_post_notifiers = true;
+	pr_info("%s: enabling crash_kexec_post_notifiers\n", reason);
+}
+
 /* Returns how long it waited in ms */
 long (*panic_blink)(int state);
 EXPORT_SYMBOL(panic_blink);

