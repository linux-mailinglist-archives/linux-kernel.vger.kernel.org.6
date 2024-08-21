Return-Path: <linux-kernel+bounces-295571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAAA959E71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147781F225DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95CF19ABDA;
	Wed, 21 Aug 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n1G+Yla/"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B42199FD8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246139; cv=fail; b=bqHyiV9A4Di+bOuLHQ0ouwxDe4FmkPk6YswtcFtFbvXe9jfYCUzmGMkItBYNiaRGSA5MOF4WOcZeI9MwrincQqJP9DZ9BN0Tl7MJ1WFwqVqug2NAlqR5DqlEqaiFmKWZlCpaYMjJHzda20eii9k3pne5bkLSvpnW6/EVVxtD3uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246139; c=relaxed/simple;
	bh=kOUTJFXSVRQYNeD95Ok9fTS8osRwbzlzH9KlugclZzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mMIOZLBR41nib8NV4Ckv38JDw/eCM+5YaV0oyGd+/RnKnEoN1ru7rCEBCllLcSd1to78azqNY4PmzNx2hnlbp7r19tNwhzLIKTyou/LEP2O0tbWWGFueUMxrzQH4x1ganp0wKzbVwK+uhQPAabr6HACWBsIvpCIIQ/x7zbYkLDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n1G+Yla/; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxJpa/6W2pLXAiOmvjCNBiSXr2rcLuB+4EfJhRUyB8MMHglAsfKR9LX4oxtxapyqZrvWigXBYzUXWJYw5fXdZ0elNST4i6NpNF8fU508MGHbOUTaY8+a3vKPkhzxvyh/DtknZWroUv+656jXoH72krFwya/rh5TwjdsBt99MPswDpArO9WCZ7N90karCep846yCG7+/jUbrQs8pUCcfh63gMXKilcU872pKP3P0k23kq3clpH7LbTMEMRyWecQxzVJ22mKUMPWh01UczjbEbUBePh6nC/GFLxbQ7o4DvutmdGPGYtV3zckxocbWciG7lFKvUDC3JYPjWSaXajqFMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxZ5vEXmWf7f7+s6alJLna0PGe82RLP9RQrOQm93IQs=;
 b=aKeTey8tf1oF4UqSqiybQYg9P63Ri+kohwHUTfrwU9F//AMD5aNPKhzrn6YJw02OkZb+v6quIO0Hno+J+2yOKil3YiYoulfieHEkPmU2cPDu3enTckfWwIdVfELf7aZyml+0LXVVo0Lo+fBD6psonvQP+h9SUy4Kz98KHuX4qvmYMCyLycWUM1VsTGrJT4/JRbI5FAw0CrFYFmv2lIwChvx9naanWUoB/xsZd67HBnCUynd1sTPbMfcnwV3f4gX0OIo1uDb+oSPR2ohddMM2ojEm8L6Mey1AMHEEEw3nVAtT7ySZSl2n+mdXujMKShPoXPFeMuqRi7nyHBTsh9iIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxZ5vEXmWf7f7+s6alJLna0PGe82RLP9RQrOQm93IQs=;
 b=n1G+Yla/k1/RkFbGN10E+obZHho8NCNZN2E9+WiJT01CGRxBHsp99jkT3z8dPMHVdvTx3J+qg+albozfb3Juwp/zbpWygaU9Zfg1K+UYEzWc53AZdTmO28mw9Uea+jT5beohUUvnD9lWbavXlzTEL0p2yScqoBE033CZMAOqudk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 13:15:35 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 13:15:34 +0000
Date: Wed, 21 Aug 2024 09:15:31 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Richard Gong <richard.gong@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	Shyam-sundar.S-k@amd.com, muralidhara.mk@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Add new PCI IDs for AMD family 1Ah model
 60h-70h
Message-ID: <20240821131531.GB1062@yaz-khff2.amd.com>
References: <20240819123041.915734-1-richard.gong@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819123041.915734-1-richard.gong@amd.com>
X-ClientProxiedBy: BN9PR03CA0760.namprd03.prod.outlook.com
 (2603:10b6:408:13a::15) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c83441-f9ac-4a5d-9fe2-08dcc1e35759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kh4dHBOPWdP4PP9SCLcQNxf3fM7hRnyccEciBA47O26V+vojpF7ikBsAhL5c?=
 =?us-ascii?Q?JSZrSyDfWcILVkQj3XHgaUD1lr/2mixZfL7WUMB0t6JxwdwAhJjjNMeCSLZu?=
 =?us-ascii?Q?HkCT0kQ/eCM6wc3qQKWe4+W3Amu4ls3tvqYEcxFFRFFw57Iikloq8p81hJjY?=
 =?us-ascii?Q?QNg24intOcCcINcj+2zmnVOgDoLPxmvaPTJ5+wxKOGCGn675qTRYEjq7r8g2?=
 =?us-ascii?Q?lRCF30RZ71LpmXRzZiWUQrokRy87ZBvecMVXd5hBhoAXanY4Cqiclou7/bJq?=
 =?us-ascii?Q?L1FQYQ3om44y0oYjtgVPUWrVsV1ok2DO/6xzEVX45sB218CaCcbz2z8SOqyv?=
 =?us-ascii?Q?xB65bTb920yE+gn6TMsPVAoSctqdgNgG+Mc32WjEnyBXogdRcOiFHmRLyrHK?=
 =?us-ascii?Q?swu+EMeAwraR3g7Ng7TP9h7sbuRV5JlWB4M6eDGRX87PJsfYEerUBwLBzLq6?=
 =?us-ascii?Q?+yU9HeQI70D+FSBVmJpSSP0OcADZjzfn9CuW62R/c4n/myJIJ4Dd8+PeUTjN?=
 =?us-ascii?Q?dxwkL7PEHvjafTzujQ8XmMId6PHNBriLQTxrPtAnLGp8Cv42N5yUG/VM+Nd7?=
 =?us-ascii?Q?pV5Gd30u/ZlguHGud3WjH6D6i9Yux/jLKDn4pToUr6vrO1f5/c63VtgYzBgi?=
 =?us-ascii?Q?KGSZkaXAd4sOKwngO7Y+7nxN6qAM7Gcq+W2aL+z7/x67OPkpa0f45kbbHHVa?=
 =?us-ascii?Q?Yk+/UpO0B7/eqwm86lC68omWXDEbxeJuOyojl8PB9N771H3cD19L6oy/GCwu?=
 =?us-ascii?Q?jega9yTzxhf6bxnajegnENsYX9BPGX7SxXqY/VTOJg+G2gLr00Z+iJi4fSat?=
 =?us-ascii?Q?HlGQorY130P3AfCa43rXxbC2czpb6lbGthCQplhOFujld5TL005DaLVWimvn?=
 =?us-ascii?Q?aLJXHmGlE7oMRwjO1QFa0YrCA4Lh4TuQYPs5ECm0d/8AfRE6rcsLyM3VgbHj?=
 =?us-ascii?Q?mqU2xFIZjOH7dtxud9rtEdcOnW9tGYrRNOsO5de1boRI7vZ/6VwZjATG2zPx?=
 =?us-ascii?Q?+LOLXsGfwday5dt8m1UwGzYNpBc2OqzeTlYwfotPGjD9JGObgpRCkzAeEhsT?=
 =?us-ascii?Q?XRzrZsP7uZPM1O6m+guwxnZd/pAdGoN5X+SMOyMWx+yeu5sXdcr8yav+kvnm?=
 =?us-ascii?Q?z3eahN+Z4GlEOK0W9tW2SbYO7MZokPdObt5U6d4Mc7Zh/q6y7HfWLDLO3l8q?=
 =?us-ascii?Q?eqCGyH3LVwd+cU+OeApq0xwOAlbKVsXMsxYlVcuu1oQSdR2zZ2NVnmWgM1mD?=
 =?us-ascii?Q?EdH56vDhkJlGdH8rSuZFtfplpUBEbUdVE/TyiKk46bHibbBVq4NbP/U5Mmrf?=
 =?us-ascii?Q?IbZkLEW6qQeaQ6Kjsuok8v2Kbx36JCg+3E0fyts1nYv6pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbzgROzMQbSkynbjGQdhiLQ3GoLs6UKOvojo57cK1jOwrfgB80i9RFb+G2Mv?=
 =?us-ascii?Q?/QwZ7KydryxcC99sX7Zh12ptVvrkWNdzXGY3olfvOmCzD9Decl6KH7Fiagf8?=
 =?us-ascii?Q?/faon4KTNmff9pRa+xwiAX4VThL3tUNXn6ahrX1TkizGiWx8IKbspXm2BKqx?=
 =?us-ascii?Q?zUZIVBDvbokOY61Qa9XJ0KiH1pb3FpjOsk4bjqbQdYz48vgDT4KmLE0QBz+a?=
 =?us-ascii?Q?ADjokrr6CW9Q2AwEjCeUDalkhk4vGMnSoZjRDSdo5nsXgV8AAd2XIwGBZpSo?=
 =?us-ascii?Q?mszWJ57eX2Gm8tvT6SGNQXvDFG4LUWUkDIq1aKb/YFD4hsxoYUTxlnaqsbJz?=
 =?us-ascii?Q?Yh9mjn2YXh484iNiNtFpw/Z+T444yYuODIFb5vk70ORMPmA3gmWx/xmZ5XVV?=
 =?us-ascii?Q?nvbYUmjhmbBYWM9LhGq7KVH1SSb0fLLniohk9lJKpsYSAUuUMR05FY9u7+50?=
 =?us-ascii?Q?R8tXEnMhHRKPwguZixH3wDP5Iz8QJXzz5vPaWJiNNrulh5yLMsxSjtVoJP/e?=
 =?us-ascii?Q?dgwjcLlwkOfutehgORwGi1UenUpn+4TzUu57rv0T69U56eNalpfg9Y/n3IAD?=
 =?us-ascii?Q?aV9vG02eBnkqgHzKuKNR0O+FalRdRuN5L2ImgBO0E42yL0vjAi/IBEhN8mGW?=
 =?us-ascii?Q?Rugur+kAOap0tdAl1JOpc/kNb/2ww1xaGYLl6uLYKoL/O6x35oE7hk4b7EMP?=
 =?us-ascii?Q?y44FOEgONCtV5i9ZWWY6ev92dzLX2aGkT/WUT7JfixSPjznR8PB4kcRFnQmS?=
 =?us-ascii?Q?MZFPtHL8Tw/SRL9n0PsonQo4bwumJUoNp+wdjiI3GZOQ9XJIatomwmM559wr?=
 =?us-ascii?Q?K+GWAbxKa2id/8c6HOwv5YPZi9iZvGdWrgMDT/pfncBitTTLsgn1UAATqIpr?=
 =?us-ascii?Q?T3sypWYvr9bnSXYL3M6P7fxI5WgjeDm+UrXJRpQJ/K3xqHZzW1LxkuB7glPI?=
 =?us-ascii?Q?yg176+W1rATgWcA+2TR4EoeKkMwyaJbw99knk12S8HMB42de/mCpAnOSg75s?=
 =?us-ascii?Q?pQpqFVXQW7NlS8d/zfyJYpqUjfZj8PiOkTE6g4vgCsjFAW5c6zyMjpPeYFS5?=
 =?us-ascii?Q?wQ4gN85CDayUhmb6mgA9Fvg3KBWFmzeDC4F4L7d2xPVkZGS/i91klDbifS/b?=
 =?us-ascii?Q?KbFFg4Mejbkq2Nq6CIodqDEzam/kTV1OXrYLgHFUYt6ZBuA1iU0ygeXgq1x1?=
 =?us-ascii?Q?GPJB1OdHP4Y/1bMO+kh5FdoiLmYlY0xVtvwol2+ahoMdg3VqxFlsgc0ZCrO/?=
 =?us-ascii?Q?S+j1kCpEXTS3ETf0nxnXFQhAGzMCMNjURuEolusJN4029mzU9uHdGsulooPX?=
 =?us-ascii?Q?nbRF/zDMGqMKWYhHdyg/o04ngJCDjrYcKm4/lYbAbxz4+LAL0nu38HjDiBnd?=
 =?us-ascii?Q?7dYXngtqlkd2Fp3QBiC8SyCddCrC+BFw9RmROxtYzP2/l9oKtylhUHULa7TB?=
 =?us-ascii?Q?6USsDEg1fsHvulAwYNT24JQoqdOJRrLkd504GfP8yp0RAuM5BLhasvXj9mH+?=
 =?us-ascii?Q?soyZBIaROfzkMtbpMOBQNLTVDW7HYs5BXE1wzuKKJw6Ho2/nOlJIYas4zUUV?=
 =?us-ascii?Q?0RBzocLHS+I+fCKKofRA23K4FT5iXOMgjsc9gVr9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c83441-f9ac-4a5d-9fe2-08dcc1e35759
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:15:34.7934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE/dkD3Em1FNv+70PuDu9IKYqSSM2tyb+iVStD+SIoyl2gXs6sPNSvcI90r4wsNv3okBQGcstIxTsR+7PR/l2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

On Mon, Aug 19, 2024 at 07:30:41AM -0500, Richard Gong wrote:
> Add new PCI IDs for Device 18h and Function 4.
> 
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

