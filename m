Return-Path: <linux-kernel+bounces-242880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABF8928E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0ADB22455
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B113C90B;
	Fri,  5 Jul 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQKU8iiZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jsNY2xZP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CC1F61C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211803; cv=fail; b=qgQGHPshNuANQWRTTriGG2DMMniW+FU916armSOof/BYbkJk0Q+eUdbCuoXVAZZMurNLu1MK9e/C0zrEAyX/PqS493GetME6Rl5QC/Io3RzqpoZuOxVa1zWxprcL1AGQjFAczw7LHdvXBz2eUOdmqhpB5PJgW2AgbNveGbnF7D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211803; c=relaxed/simple;
	bh=EhTNUODG0VTSmlcY0DlC0WBvFm0BKrHAabHMjpIGGME=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p18lMBCFgbrfR1rhtNRYITp9cUyV4RsBU87sSy4GpouX+BKMv7X8DvyuZkVd2ZJ4riJY2U5B9QssmWaqhs0M/kqyU3zh/h5RGjrRbITd9FmeBwJaG1weag1UMC5WnDbb9HqW7QoEsu7ysA17/yc8K13EhuUUpT77ONQk9I7iC1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQKU8iiZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jsNY2xZP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465K7Vxp024118;
	Fri, 5 Jul 2024 20:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4Y2wIkDNa3WyJlB
	c40+84lzmLnuGUgtnbAexXz1P2As=; b=jQKU8iiZxjLZSmlMePhFOr0+6hNIfCv
	1qhY0LFLHrM/g9B21HJxqtTs1oG9N8ZH3qrusaphiq+9BpHUlEhP7/ff+huCddKW
	7l94eEtK5AA8NU1VPAE1w0/G1hVlg+jbT72VDSPOaXha6DWqs9b/F51Avc02n7+w
	M6shvsA4z/V1/axRJQ549ffB/vqwxIpmxNqJVDZvLgK3gnqXXzs76T0EQW4ONCLO
	BSkjmkQ2ouh7P6/BMmbJ2ZxIAdk6QKQXFL4cpWYxyZMRa8uze3nq5ApmnJ6NV/iP
	mkNMO0kjXfP27mZ69HvEZl0Z/CsrsQfexhS8U9RRA4v9UQ5CIGRcdzg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacmmrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:36:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465HQ5PW010963;
	Fri, 5 Jul 2024 20:36:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbr697-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG9R8OyzgTomvwYMDWjwDBBkJglEUoY6y7BxnT/ef9Mayz/uJ20rd5+8+ocWqqqKuS98Qo85vZVIn9pnMhJB6IMviWC7iWelNaxDQFy36AHwuaEAAFqf/ShvhtzEhjG92alI05Nw5HlYkUA59NXwTt5lJKmP195vdmDZMgA/XiUQOExWma1YarsMENcubh3RWpHmdviO2FJYoi8heSqIY91/km6/gsGlh+4tijAJD1LuXVhkVUvmm9ih0rk4MPd3VIJDPPcjHOTaeeE3ZwK5x2iTGYe+NyMA5ZMWACdu6H1KxIgz6MT0BnjBzP0A5EPjc1BOIlBZgZLx7POnbqDfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y2wIkDNa3WyJlBc40+84lzmLnuGUgtnbAexXz1P2As=;
 b=C/F3n9naUvB9jP7wQ69KThAhtPY6oMrR+KB9tBQVWft8E2GvSTkagDyUBRAYgwbuajY9GSVL9H/dqRq23AfogxIuSO0HmBS6H3gzBwfA3eUf4VPxKEh8LVGGBQBkBHEF9A3EA5UmXUdChFxIAEGL+mt+In+16S0YVl0zgvYpzpgzod2mI0Lr4d8z1rXZRx1T9qQ9Bm4/r8PNzUZ3m6jWqNVhq+luSQ2VnVi8M/2eG6mIggbUp2cFvREg1HNlwqbKOAsIR8LC1aqPaI4+j1E2tuQt4rNEh+ujIuVSI6urVa98mSh2uoXKMTDkK65HfW3hs96ORiwp4LmU9uxMxA+IrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y2wIkDNa3WyJlBc40+84lzmLnuGUgtnbAexXz1P2As=;
 b=jsNY2xZPrx6BKdap67zWyYnWCyb86k4egB7+T2CqKcjAHlruv8fkUjpyW0Ts6SI4pLt4Qf8TFabK2QKa3RlZUDDquu0G2I/WyILpJ2ahEX+umBhEuPzcp7Byher3QOeuL9SDLP52vsUF/1CjJPQgLIk0J8HsW4ARvSvIGRSX+QM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 20:36:21 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 20:36:21 +0000
Date: Fri, 5 Jul 2024 21:36:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 09/16] mm/mmap: Expand mmap_region() munmap call
Message-ID: <b18c9a27-9bb8-41ec-8808-9a146d162202@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-10-Liam.Howlett@oracle.com>
 <b283fae7-fe72-4bdf-a7d9-7508c3f93293@lucifer.local>
 <pnnhq7ok3uhm7a3va2gdnpjvywziqvicxrzp64a5dhfbmydjv3@x52pq3vq7zdv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pnnhq7ok3uhm7a3va2gdnpjvywziqvicxrzp64a5dhfbmydjv3@x52pq3vq7zdv>
X-ClientProxiedBy: LO4P123CA0152.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5d0e88-e836-4687-b3b0-08dc9d3220ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1TFKbYiDWPZCt41XLEdYLsjE6r9yGnCDxHJ1nUgI10j4da+L3weHxNbsYz8x?=
 =?us-ascii?Q?QtMpfNzV9OwwTHybdlPWFbDIPSMATn4M5Zue+bnDHrLrWUDAcpbAuKnCTiU/?=
 =?us-ascii?Q?l8PVwacMbP0BtO0VMW+DVJ1tdalrExiu/N5UbqgVcdH9VffHsDXFtGUYgVt+?=
 =?us-ascii?Q?XrX1DliMUlCr4yAZR5MGsMfM8HKRue57M13mpssQk0urtdZir7+KCJ6Rr3CW?=
 =?us-ascii?Q?EjyYueaBcV+7ZteWA6DdHyihzFzW16pyvp2HyQOIPGf128DuPtRCGYPbEY3n?=
 =?us-ascii?Q?mXrc5xIyqpr0O/wVjppY2cgRFuLTsOqMBPIM8tZg6UcJM2MzrbyCi4OCz3UN?=
 =?us-ascii?Q?coA1XFavXVf+eJlB0UCGL3zom//xoDtfuSJDYzXmkYJqlziyENO+VEom/Vw5?=
 =?us-ascii?Q?8TUpNoTWfbuLBsBaofUL27lW++izTtHndi/jymx03zglr8f6vWlBDCYOx5cU?=
 =?us-ascii?Q?w5trkjpm2sMKlD6BLr9MZG/FGbyb0/9JdrCSnvnsS4LWpAmaS3CVM7FuotJH?=
 =?us-ascii?Q?UC2hhDAxLQqA4bukT8xVeqEixLvC7QIAi9VIwddAk1+vs81MzWNteVEAyy2l?=
 =?us-ascii?Q?8nFPkxgWeDUUmeoIRhJIi9gbUmFOCNgHaAWXK0FTtRYE8487oFgM/BwnMN1S?=
 =?us-ascii?Q?+eWd5OwOyL5pgfuvt451ZTNug+8Rr+NxBfpP7GYXpPGLYte+s2RyAh9kKZBP?=
 =?us-ascii?Q?/Kd3ij5pYSigro6n2X3MP3clcY5KJLDU3ir1CPYyP7z+Tq9SdIab/XULH8us?=
 =?us-ascii?Q?t2gQ0ZPFmwGNLBslK4XJWBs2YTnFB+3OIUX1OOqavWq6BlEZX9FVqGyodGrk?=
 =?us-ascii?Q?76h4JrIA6gWCcxJ9641wklusmCUTUK84pOF0OKIXsyxPBEwXMac9ZXjOdSyJ?=
 =?us-ascii?Q?4P7R7lcE9S9dCNTtXbnKWJRT1jeyeoZEk8db4IW+Wi3TZNqwcPYUnzFYz7Ep?=
 =?us-ascii?Q?IFGkgeyNweEUhlGIg8Vuh8H1b+s2v/DwWp6j/cA8tqeBDWBQvz6MTQz94Gh3?=
 =?us-ascii?Q?YI7NNuYPat/Sm0fh7vM1RCFnNgsyFxF6d0xvgfz8T9oX10bLSj2/f4u+LE0C?=
 =?us-ascii?Q?gL6SNG1CGst8RWFNPQNntfyowm6wswfcmDMT2T87nggTrZwY95ucs6x1OCxz?=
 =?us-ascii?Q?X+mva4Ayl7O6RAmQTCiCD1OtKJE8FJi2qiwKdpculVYunL73SHSbstm7fBAF?=
 =?us-ascii?Q?8t5wSawTGlClmBAfUuGzu/LHn5Ubklw4e265RnqLMJRGIH7CA6zSsD9fXyo5?=
 =?us-ascii?Q?1RiOjfwuTixqdngr/c7xAswQsm7z40HMlOeTqo7V2Fdje4nXtgazo70l7rCf?=
 =?us-ascii?Q?OCWehvZl3nIBn73ve4YZ0NHHnIo1rr2Z65cv5X5R40kvpcSPtCP1wAVgehYO?=
 =?us-ascii?Q?OQ4dFQmAIdrk+hk9Lddu6Pt2qHPh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5W8IvkVCK6heeQF4W48vThxaxYKtKeWfdQ0mJIxz0QRzz1jVMGFmxcguzAjt?=
 =?us-ascii?Q?/l7Z9gfPx+rsTEZXFi7fcq+IQ7bBllg1btDz8qSa+bjJSbfNDnJX/EFN7rtJ?=
 =?us-ascii?Q?eJpP6yGJ73TJs7iPNz2T8E6FAtMNLhFmjXIto4kPN0MGa0DFeJfHba+J4oq4?=
 =?us-ascii?Q?3c1AZS+/RlQeSfj77Eyps1lrSuO/kF0kR8O6uXTEAfwqf69imxliIZ3Wsfh6?=
 =?us-ascii?Q?Q+BuGYnwST6F0C+oAf14w/gJY1DZJe+UFzPzBPL1oZRKHmoRBv73N7Lr4upf?=
 =?us-ascii?Q?mbBdnd4BuB4ZBie7C7m+mH1/n5CNcD2rmpA2VfajcYw0prGuTjHhF3AwKKsx?=
 =?us-ascii?Q?EI99E4YUDvVvwsR2qw1kLGPazQMDVayMO5p1xec8dBt0GTHa6rHxVjAonlIG?=
 =?us-ascii?Q?pB/6RpGHXlbCbJ22sxwb1y12bfH8aaqEMsJV40mdS3tTe4Eym0y0i9+ls0pn?=
 =?us-ascii?Q?xuU4p8Sk/9LABHmEPBC+oGxLuvf2alP9EOgF6Hwd8W/YDNuBX35T+SCFP2ik?=
 =?us-ascii?Q?RxsxgTwypxsjlNOSsuxFVu0wDy3oSMGlehG0NokSXozjOR5a97hQo0vnxyWF?=
 =?us-ascii?Q?3s17BMdxwTJZErwChFEfOnaCWPjsIlaWK2WGNUyPegbmY71ec/xQ4b1vBmHk?=
 =?us-ascii?Q?gcFe4HZt7fIX4nz8xbpLSq0sBamyHQGBLt5L4UlsmpONkS5a3dKY7oujuEdh?=
 =?us-ascii?Q?01MwKuLYzzJcklxahCDN9jgCbsatdKLEtw7v4yWfo4CDhRXnlhyB5ACehbxB?=
 =?us-ascii?Q?FE79y/ehPvlHNmOI1O9TBngNBGZ1uRPCAbN4LMWkyauxAFgMGWULOMlA0rDp?=
 =?us-ascii?Q?2k8Nu0hTkMAe8v55czJH7PHue/AYoBvpfviyUFgFsF47wVErnPcONV6spAEY?=
 =?us-ascii?Q?i3rSy8Qim9kiDCAj2+wjlzp0cQdOTSFC2Y3mZsfMhqKFHZNLQY+CvA2S0I02?=
 =?us-ascii?Q?5UzbIEIVPy3p3vR5m9PaSlxHjsqOWsMtSTY4NtUOM4GAhHd/0uexwYNtp+S/?=
 =?us-ascii?Q?/tu1E2c9l0ogA9S3X1eeXSpXoNTNRMesgrt+MKpiIROhtpIQ6D2NEiz3oi6J?=
 =?us-ascii?Q?h7a0EsMLIkQiT/ZwDkyjzaxSxz5UQD2K5GL8yiuQEBqc+lf9gP9BtNAqvAVl?=
 =?us-ascii?Q?gKVq0vr/NxQBkMa1l+oMNORdeCYb0TbvyM6EeUjX/daQLoHFqE0CQPaD9ptU?=
 =?us-ascii?Q?0pzBKhOTsjVSJTybkA5+Wi4mYvv0NjRpcyfcjZgqlGFigf+q1g+OhjrlYLrH?=
 =?us-ascii?Q?iYNcBs6/xUG/mK7OdYfEu1POKB7ujcX29o+ELUN5r1UhOgJ2Myu7yoVjYVmk?=
 =?us-ascii?Q?1t2LjbH7QDAoDlpBTekPO3/jy5Ds6IBQSlFl1SskebLMWegU25eLIqgEPztR?=
 =?us-ascii?Q?r6CIdtmdh2sUQ6Tc4gjbxkSrs0wtUGUUQvZ9kJSs0ICtz8eQp6BCk21I+TSo?=
 =?us-ascii?Q?dR1QLn9EEqogxWXCSCL4qhwjBK8uQhZM+kkREawXHdPs1RGz0FX2kNoQVZ1e?=
 =?us-ascii?Q?iPSrTXIQQEAZE/uaXXlMauJc0Rh642A6Ur8fr1kB1ME6HIGoIdS2zim13IBO?=
 =?us-ascii?Q?HrjGptzVw0oZVYgujzTUR+KQ6xdIsCoka6GT3X/38+QMNWde0lLlFGvur6Cc?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XDEkH3WyP2IUhfLgV6dD+l0BmybZ0YdQPjS8elzqm/UoK7+Q7WWWCWQ9EgWJkaPkhu5PHiizRidB9e9HwsXkyVYUHSxrD15X+dzW+1efr4xMZXRCV1G6FZ3xfDYqkEAYv4PPHTcUD5i4Js+sxDAI6A1nJ6TgdzXQxHdzYkvkUJs5OfVL7+8jpA+IzyaIH2i0b8wJXg8ZoFH1QWI2g3TibL1J7ipHZGKNQv6PVCShwFYQyRSIla+j4w6moxy9QriQb0JY6oBbJC5lkQ9kfjD4gjllr6qCjRbXJiVZz5y69xU519wibD7vWtLNqmJJj7CUJcSan/CXKgua/vkdWFX25GKri/E2E4k1NzrhuZDwiucd1x8etNTS5tR2WWzKUT39aL2ikC2Y/ordzOZt/Z3fZa7kR7ErOku5p2mIyNIlHi/djsaTMHTY0Nw0QenjLcY1jkMLmcVhvLU+OqJzj723dhK7p1bmErZ5tRV/jniBg/Ou5h5VpZapicUXe5rc3XcDmC2Dx6rN+wr5UyZ8+AfhpjpJFHuWWkJLrKM6qdDVNXpR1W5PQu31vDcpGqr5dtEGxkPzvnLpMLLa/RGOpFZJOCUiQuMOAFszCb6WqHaI4pI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5d0e88-e836-4687-b3b0-08dc9d3220ff
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:36:20.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wshNEj4dFpl/yghRcPHJd5eV1sDflM8lwZGVHbPRAQ7rEjUMXmFSHMTHH72qAV2yW2+wX/+0oLdm+p1r/WtTHxGOatEvCkdfMa/lHQW5YOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050150
X-Proofpoint-GUID: r9TyY2iQv8nOJXm4xg2Ck48fvPAFNe87
X-Proofpoint-ORIG-GUID: r9TyY2iQv8nOJXm4xg2Ck48fvPAFNe87

On Fri, Jul 05, 2024 at 04:30:46PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 16:06]:
> > On Thu, Jul 04, 2024 at 02:27:11PM GMT, Liam R. Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >
> > > Open code the do_vmi_align_munmap() call so that it can be broken up
> > > later in the series.
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > ---
> > >  mm/mmap.c | 22 +++++++++++++++++++---
> > >  1 file changed, 19 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index e9858ca8bbd4..f5b33de4e717 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2915,6 +2915,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	struct vm_area_struct *next, *prev, *merge;
> > >  	pgoff_t pglen = len >> PAGE_SHIFT;
> > >  	unsigned long charged = 0;
> > > +	struct vma_munmap_struct vms;
> > > +	struct ma_state mas_detach;
> > > +	struct maple_tree mt_detach;
> > >  	unsigned long end = addr + len;
> > >  	unsigned long merge_start = addr, merge_end = end;
> > >  	bool writable_file_mapping = false;
> > > @@ -2947,9 +2950,24 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	/* Find the first overlapping VMA */
> > >  	vma = vma_find(&vmi, end);
> > >  	if (vma) {
> > > -		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
> > > +		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > > +		mt_on_stack(mt_detach);
> > > +		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> >
> > I'm guessing this is exactly equivalent (or equivalent enough for our purposes
> > here) to the MA_STATE() call in do_vmi_align_munmap()?
>
> Yes, what we are doing is inlining the function call so that it can be
> split to parts.  So for reviewing, I just made it in-line.
>
> >
> > Checking the two against each other it seems that it is indeed.
> >
> > > +		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> > > +		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > > +			return -ENOMEM;
> >
> > In do_vmi_align_munmap() we also invoke vmalidate_mm(), why aren't we doing that
> > here?
>
> I don't see the validate_mm() call in do_vmi_align_munmap, it is called
> in the vms_complete_munmap_vmas() function  though.

In do_vmi_align_munmap() you have:

	error = vms_gather_munmap_vmas(&vms, &mas_detach);
	if (error)
		goto gather_failed;

	...

gather_failed:
	validate_mm(mm);
	return error;

>
> >
> > > +
> > > +		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> > >  			return -ENOMEM;
> >
> > Same here.
>
> It would fail here, our count would be wrong.

Right, but in do_vmi_align_munmap() you have:

	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
	if (error)
		goto clear_tree_failed;

	...

clear_tree_failed:
	abort_munmap_vmas(&mas_detach);
gather_failed:
	validate_mm(mm);


>
> >
> > > +
> > > +		vms_complete_munmap_vmas(&vms, &mas_detach);
> > > +		next = vms.next;
> > > +		prev = vms.prev;
> > > +		vma_prev(&vmi);
> >
> > I'm sure this is correct, but just to double-check - we want to set the VMI to
> > prev here right?
>
> Yes.  In the current function, the vmi points to prev when we are done
> this dance - so I put it there.
> >
> > It might be worth adding a small cmoment saying '/* vmi now points at prev */'
> > or similar, I've found it can get quite hard to follow where the iterator is at
> > sometimes.
>
> So this is about to change..

Yeah, I saw :)

>
> >
> > >  		vma = NULL;
> > > +	} else {
> > > +		next = vma_next(&vmi);
> > > +		prev = vma_prev(&vmi);
> >
> > But here we move forward to the next VMA and set this to next, then go back to
> > the _original_ one and this is prev?
> >
> > Actually I guess if vma == NULL, next gets you to the next, and prev jumps back
> > to prev, with nothing between, and so that makes sense.
>
> Yes, this is what I'm doing.
>
> >
> >
> > >  	}
> > >
> > >  	/*
> > > @@ -2962,8 +2980,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  		vm_flags |= VM_ACCOUNT;
> > >  	}
> > >
> > > -	next = vma_next(&vmi);
> > > -	prev = vma_prev(&vmi);
> > >  	if (vm_flags & VM_SPECIAL) {
> > >  		if (prev)
> > >  			vma_iter_next_range(&vmi);
> > > --
> > > 2.43.0
> > >
> > >

