Return-Path: <linux-kernel+bounces-527612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2300DA40D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61137AC52E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491A41FC111;
	Sun, 23 Feb 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q5BIonN3"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1021C84C8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740297034; cv=fail; b=fq3tHbDq/U8C5bcWOEqJrJ8QUX9/DuRzzsVWvt2PhZERGE6g5TEyOKZv1NSuESTwdA5rt+BaknDY8jWqkY1W+bDhc6DsNQ2xBxMi5pJ/9sph0eTb3es1kLoyZe9ypKa1PnLmVdCLsoL1tsuSGhGr54ut7PUp1gJboU7To51HBjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740297034; c=relaxed/simple;
	bh=3tnreYlnJmurzlt2HZWx/tXQyMSjg3iKnYvToA8oHWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RT72z8bOqbd5r20YqsVjQ9RSXCK925tli2KW2zEgQuFIYVJCcE8Aza8Yy3w7lLNJypo5p32UHSTY5QJUcVRYaKA3PvjwWPpE6ftqftT8CENnmIkjHhu17pjHr7fpkxYtWoJN30uFP73fiX1JQjXwtRvbNBgFlzrA991ily+YMus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q5BIonN3; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuoD/v5ROHeERSBz1VZUZuRmMICktiIkz+J0w8miS5ydco5BdbYlecNCz+St6ROpJdmeZqPuKzhhR9Nxjbe88l5NFmcB/8MAyUAbZmobAdifwNSrrZyVOOTlrnZwkaU56fiZSuE4GJ42BKEL5P0xKQd12KxhzhGjEeU3C58GmtUc18C/G2vDXI4dyAjYFYKcAPz0wDGG02iCq1A2C+ZsSVtGmysuZM028kD0A+buhqmHlUFxKK0fLI3V8y0LnED0TCzyF1gi4hnsH7VxBYlFaI3C2HEK+85qmYLn2+FYp4JCZWAuur1dU3ccTw7S3ihbPX18qNMrVXnBpP2AyN81oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR599w1Y3BjSCZqEondhZZEicM1S4k8aD5E3OApuEa4=;
 b=Bc8fEU8NJLeP+R7H0qI3PVT97wUNBAjyBWNTbkdpeVJjqge3uTbso52+pZuNtg6ciNwLa70f2S6Sa/CKa0ceLkjWRSeCUgz58mb6gPqUUeOxwau7UUZfDFCmsefp6FCKQvCIjnQssLsR5mu9WaIfoPu4foMZgfJWi1aMAQ/nbOlIkBh8aYPzbZ2qtyeiKz7DdvLWejaBfZEpOkT5gCJ75W0OlNAvb9YGcCNzZc/C4rghZbkTS/M3Zz0BI44WJurenMe6BfTN7Oct2JMIKN1mlXow/S5DK0cxmLK/KK4/FG892SBDfDVQUkFH/kQzDMzH/GeIaQB0pdJyn4ru9I3oXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR599w1Y3BjSCZqEondhZZEicM1S4k8aD5E3OApuEa4=;
 b=Q5BIonN33cXgrf0faYkX3nfUbVo9Xpjg5TWKcl9J0YwIl++y2rNBOS8eWamL1rVPUq9aeBYZt9K/Pn/flCv1p+i+HKV0jCrcyrtvqBNN2TcgLDjV/mk9tHvbmDpbyO2Ml0PCS+heYc3fMQ0dP527zByvP74WvFYWoy9bQ118KSEY3YPzkh8fgkdMekMRi2kJCj02CadozSaUupnSGIwf3eMK9DthwGJEGy4z0tLA8qQNU54zyPd0TqydAYPDCjPln0aFUSuU1HV6RTeU8nQZzjKPDHO0o0vOtbV19PDZNrm2mC5Hogc/cyER0xSR+O1q6neua5YJgNvY2pQt+KWvFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 07:50:21 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 07:50:19 +0000
Date: Sun, 23 Feb 2025 08:50:15 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <Z7rTNxHcXWizV3lq@gpd3>
References: <20250210001915.123424-1-qyousef@layalina.io>
 <20250212145054.GA1965539@joelnvbox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212145054.GA1965539@joelnvbox>
X-ClientProxiedBy: LO0P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: c61b7687-ea7f-4bf9-421b-08dd53deb818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1Y1FljLey+LPS2pzuBUs5hEWkawlZTnUtyQ4rBYylQ7cFI9lM5+EOeCy2D5?=
 =?us-ascii?Q?HGNZ61iMHrpZIL2RobZgtAiToyhr6rZS4fi8Ky6v7Ip63lHt5P5EUSYrdhss?=
 =?us-ascii?Q?yMNqtZw7xs6kCjoaCysmDkSbEq0YPRL4EMpESqurL/FpsvdDhXR5gBTefj6I?=
 =?us-ascii?Q?WslR6PkLKzitLwFFVZYhkltXNLckl6ouWbD1QbKgt/NZoZgGCO73Kpbjz8vg?=
 =?us-ascii?Q?8Z7MhaB/EFLaf01oE82fxM315Y+qYieOBbIDa4qIXnP14SGEiKllauqLLZmN?=
 =?us-ascii?Q?G+sQ8WMgyP2fI8BQr+rSBjPBdUFLxvbSnKs4HUvKHqrji7S3FgCMKGOOs+aX?=
 =?us-ascii?Q?/Hh6Moh/i928k5qR0eZHZ5dClsNNA/VoUQsuP55pp8XByLm8WDAzqONsXjsI?=
 =?us-ascii?Q?ChJqPslaCQStRp4yxrTjy6U4fxNTUYZ5i7PwsjCrCy26LAI17H3sZV6yg6CU?=
 =?us-ascii?Q?1juS19wqMXnQQzRaUox/fMuPmi+VkLvLyvt3JYlMSdb7jBTLHaNuY89POGsq?=
 =?us-ascii?Q?kOQmQnw4wLIg1U8UPvazNChiG8983EY9IzO3v84XoY8g2+uIwXjAXQ6/CizB?=
 =?us-ascii?Q?rdnAOboI/KIXENjE0rS0a8pzkvKzkZn9rltpsAb9q9HW1qaQGYGCAwirHLVc?=
 =?us-ascii?Q?zydLuWgY7Sv5L/ALVRpTqJnUs5mPK2SP0p5lOYGeuK5VxmwrVFR+MebnEvLl?=
 =?us-ascii?Q?Y1M4/x8DEaG0kkZIDMJVMCSw1oryxS+yuX291da8X9Y1g1Mb5CzRxLutNXpn?=
 =?us-ascii?Q?OcCO+dZdsuPYK68usqiW9Wjbjl/RilCz2n8kIDphMMLVLqjIUdHRpTxBjrkI?=
 =?us-ascii?Q?RoVAN5YFE6ewfS2r0c3r+mP66BHNXNhoXePbNKvJ8/Cwl0HdeWLfuTKongcM?=
 =?us-ascii?Q?ql4U3tuwIanfhvEfcWktzedj6CKTB9KYTaYeRiT8I+K4k8aKT1bmgKqpL0j+?=
 =?us-ascii?Q?nS+15/d95Xj9kCnjNHcPBnivPgcKO7fsWuRIpq33+0nJjI/zJ2h7scjA2Plg?=
 =?us-ascii?Q?tYi2XzMQKVqRt7HXkR3q3Z2Rx/Utub4r6RrA56XgYX0OSpZqBulKIwvCPT4X?=
 =?us-ascii?Q?opaGjMCyZvPtd9mjZfKjgeZ2ek3voEYddn4rcav1EIeU7gyLbu7rjVjBSEou?=
 =?us-ascii?Q?CYZ438ZY+cTWT/FmpbUx+FIrvi2rII1tqR7SbFxyPAGsGWyQJARhN+smrPBH?=
 =?us-ascii?Q?99RkHVyrbb08FMzXc9kZarQgZ7E3sHkaRZkY8uIIUaazIpVGgiBJ0xrExTU5?=
 =?us-ascii?Q?1n6H6KaCT5tfypl7LfchzoRXmdJQpNxwDVv+89cRr+4Po6uIkkDBpkNKMeTh?=
 =?us-ascii?Q?76C0xDT7Sji1ScIe1s+H6H0a0MNriQk0JOEKojEFffPBysekgMAHemxGQC05?=
 =?us-ascii?Q?Rsp4/nCRIMT5OMBISK61FGiTacKC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8EROcBPv/oD2XbgEi9uSbPSNmeQAbCLQ8jJbQB6Zuoh5KaLn7N/CUPOhgx4Y?=
 =?us-ascii?Q?OrcpJ9sSu6o9uQgZf+iXAvnL/BtQq1Z3QwO77Xs/idX5JkeUSH9PhoyfFBVV?=
 =?us-ascii?Q?LNb7I997rQzDSy5ZGRw8FQBE/LBSbYC7wvZ9F8emI1pHVVTZBot87fG1NY4u?=
 =?us-ascii?Q?ZdMUvbPywpZuYJ5+90cZ4cBYrZNstw59XLyujl57R73kwsntTHJDxG275UW3?=
 =?us-ascii?Q?ifrMmqVRwMvQeRZqS/5GMcbJ2IkD4fPQahIxErB8vOCR/sT3Nl2HFAPnWSHy?=
 =?us-ascii?Q?9jpNTyttG5t8EUD+2ymfE4o+CIV1dQY12GqMk+JPU2yPmAhH9tY8dzqZbGz1?=
 =?us-ascii?Q?gaz6XRl1rWiMBHOdRGLoCEBhf6FNS1JNErnj2IIYEIzDpyyNgejC6zuH9vLH?=
 =?us-ascii?Q?wWblDLXdNOBa0HNlAEJKj9KT3RPekMo1LY782aau0l8cD3npnu2S8tTSSHkR?=
 =?us-ascii?Q?hwO6kSzPCDz5B+UIQ6cmHe/LFArJ/LfF2Is8ggwnDepTKrktKMCsewjP/R63?=
 =?us-ascii?Q?4kboAimrqn6vtg4F9m4GCEEjWth9pi8jPEXOPAPbgVKesXRQUKnCF+tKtN5S?=
 =?us-ascii?Q?c5R9OzfYAwLOLfYPHZMC6ELWDkFPGejHiN8laI553u3fmSicFtvzShnVk6B3?=
 =?us-ascii?Q?joMlDGcPdYmxFWhjHsByw0f+KjPq5Ipjqp7p07OfniQv6F8F6IXLquOZEqZm?=
 =?us-ascii?Q?nSE4QG0RTmEHpyxK3jIPUBKmCeAaRwsbKzA/zGfjH9fgmNoCiQxjpz5EUOsW?=
 =?us-ascii?Q?E+7j3nZ1UvHAe8P5a3XT3OCTT5+JIWv1Qn8D2ayOcXXnxUaPLU1aaWEkKpIn?=
 =?us-ascii?Q?PoYVn85rflx0PtZi9HRfQ9jboGmrr4H7/+i7O00oMSO/ySy2Dsp5pp86dxY5?=
 =?us-ascii?Q?MDEzwDPRgs1TmEN/UjK/b2+QJ3qWtHt6vGbhvS5L8YT4uzlGF0p1h0UDjC07?=
 =?us-ascii?Q?O45EykpT/4y8wSEoaD5RLeAd4+buiOV4gc2iKpc0iD1vPTAZoq8hs9pC2fdD?=
 =?us-ascii?Q?VJisfUixctUN2d0wdNg8tgV9btCcUJs2MRkIF2fc5oqY8dBgW3/bY8BqTET1?=
 =?us-ascii?Q?HW61sWg1+GqZ84/Flfir3CsJYkkDDNP+8nxX2kikcuxJqwhvC/yXsZJawG78?=
 =?us-ascii?Q?bKizCGC/j06OP4FpaBwNuoSC9WRfpayMca9EfCyALmp7tscpNS9PWSWTFSsQ?=
 =?us-ascii?Q?EJilBJtG1pEfgQxE4a8hH1N6feo4tLaCY9jAj7BRU4qVB1+WtfODeByGKfmA?=
 =?us-ascii?Q?mBB5mNUIbpJwDiGrMdmBJAHRKalYAvTqssEHbdab063eGaG/OhWHXZZ5LT65?=
 =?us-ascii?Q?Q+838BzeHUKnIkyprWZG/VVx4u/KxfdYoHjfBOrtVk+r2RxFGVtzm5ZGwYFL?=
 =?us-ascii?Q?bgUpTVzb0Q1w4XB0kXzN0GTe13V1s4Nw/E63nruPASE0CxbelP2e9H3EP/D6?=
 =?us-ascii?Q?LEIsyQHtix2rOs17h3ufYaOQhbFWC8heG3ORwoVXD1zs7UiuLiOnfIAaEJtK?=
 =?us-ascii?Q?qjiCi6pQjEkU7bGJCbihrk1olgG24ALszlxPjvgXA/hXXDh0yGN6VtPJfImm?=
 =?us-ascii?Q?nszUN3bmoksAanQ7TlxhfaPpgS4EiikwkO5TjZlh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61b7687-ea7f-4bf9-421b-08dd53deb818
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 07:50:19.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7VPlcOchzl1cU+HcF34IA89zDS9ZjyCxp9kEfW7XbKTEohjopCS501bBGr6dO8Mlv06gfzqRWql+Tisc6l+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091

On Wed, Feb 12, 2025 at 09:50:54AM -0500, Joel Fernandes wrote:
> On Mon, Feb 10, 2025 at 12:19:15AM +0000, Qais Yousef wrote:
...
> > I believe HZ_250 was the default as a trade-off for battery power
> > devices that might not be happy with frequent TICKS potentially draining
> > the battery unnecessarily. But to my understanding the current state of
> 
> Actually, on x86, me and Steve did some debug on Chromebooks and we found
> that HZ_250 actually increased power versus higher HZ. This was because
> cpuidle governor changes C states on the tick, and by making it less
> frequent, the CPU could be in a shallow C state for longer.

FWIW, I found the same about power consumption when we decided to switch to
CONFIG_HZ=1000 in the Ubuntu kernel:
https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255

-Andrea

