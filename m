Return-Path: <linux-kernel+bounces-396780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BC79BD1D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E3C1C22F99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12032166307;
	Tue,  5 Nov 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6TnZcCn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sKx63C4r"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF815CD78
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823128; cv=fail; b=D/AvJw+v+6OQevUiVmOawUkNZy5MbH0Y8OmBPJh2VCKFSNNZgEe0q1ZUW3IWVjSUcOIFa+ouqN/Dsyn+NSKDG1SCRPQWUSW7d8dIbsRYH254wXE5jSHeXamZNDSht95U/lRBgW4k/esczGT2Wkird5XYg7/tKlvYAVByMS0hKu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823128; c=relaxed/simple;
	bh=bJgL/3pTIslHTjBhwpsEBqj0gTogcgrVWi0DK87ILnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vy7qRhUrjYAAUxUavlUGqRMoKBWDe4VufKXNH7DSQ0i5eGu/VbPGPUq+kjkOURONrXfhDTORLyGrjUiJ4+ZbaG1GzeT8Qocx9FmbWS1T4Ft/K3TCXBSw7Nj2kvikuGRVoc7zd4Bb5CBvTww++zDsf5LTWARMhqKi+nYrPdpTQEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6TnZcCn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sKx63C4r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiZfN030965;
	Tue, 5 Nov 2024 16:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=bJgL/3pTIslHTjBhwp
	sEBqj0gTogcgrVWi0DK87ILnI=; b=f6TnZcCn+bFTyAwE5YYjSrwBE0PvTZN/3e
	0jIIPfyQ1o1bM0ldxN2mo5Dj6d6KPq8J6rza2B8gtgg2eAtifTrZf4meqAnyKvRk
	LkZPezzYUyGgsKwvr1S0LNHBKmmjDITFrY5OUq3KEKVGEPhzlaUz1rzP+sgRr+Ry
	xIKvhyiVC0w5kVuz9vPe49PBG5UJKkMGGwSZELmWfw2gd04cbvpKOE1Db+hJLn5o
	jHp/MILxENZyZMttiXG+WHhofl/B1xqvQr6lGu7ykJaEgAYhpPCfdgcrKCG20dLj
	swuG5KlwmRlqtRpK/rlZXckuFxzhAHOLstdj8l8GxkG2HwNJhR+g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsnrv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 16:11:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5Flq6k031559;
	Tue, 5 Nov 2024 16:11:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah72rh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 16:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNZOlYFe050KGUJqjDUr8rtNm/UOv21l5Rs6S+VBdHYEvLkHy33hE5SBv8GUZi8SyHPI6jyzS5Htrpn/wCw98s1qCW23180H+FMh2dh5mdLycGAIROB0iZlrxNAsUu29HFrQ1g0QfAK0VKdXazJj2HVYnbXErWkxk8TnzLnXSmgHbMu6U1tXABybAvyNd+s2hllqOleCntYauaxrk4Hz4iRIM4zRr7tBPFBhuazMjK8CaQkcQs+wdChFv+ZkWvtvRaI+e6LDFFrsg0Hpw5IpKn3uqGNn7WgSOYF1WO6ThdT8SttLVYHpawe5fds4WW8UU/U/lP3teC0fF0BSFGRSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJgL/3pTIslHTjBhwpsEBqj0gTogcgrVWi0DK87ILnI=;
 b=UGwcPXpfyivJtzxMw9GkN2N+//nDIUREBgeiYW8jQZDWH3h3e+XlEkNctPI41jYR3RFzTfJVbjvgFSjcCF2uCoIWk0CKMRtFOlbLUxPk4atgcqd21W5Z67oyG86vsElcJGGKZHZH3hQrCTPFn89+l2UuRsvXkAB5wDuKFIYjeCs84EYyjLkqb4pHaXii+eV2OIlcC9r7+O4MKsPKWh2mF4e2wBGrJ/pe6tOWPfWaOX5TRLTxdK9mu5sL3G5Za85wCqhDRI6OvTy7B/VH5h7cQ1L7sk3kA7g+AQVbhpp48z95tL2ATaO2mBpOUe/rvmpe8ahM/AmjqzgaMqLrC9EmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJgL/3pTIslHTjBhwpsEBqj0gTogcgrVWi0DK87ILnI=;
 b=sKx63C4rWumlEz3+TVdkz6ptaX9+Cqw/hI15Uy73GbAesD8fEAjJp+lxAdFVkpXl5mCq38jKnMirNlqPpoNriq6JoK9xOES3ny4iNfLdd6Cpn7zfV+ZF8gP0PljBKjyr3agLaWWuapgpE1cTyKtgMRGSF4wzEyqHiLtKNDpGcWQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 16:11:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 16:11:42 +0000
Date: Tue, 5 Nov 2024 16:11:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <645ad352-5eff-4ad1-997c-ad249b2cd9a1@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAJuCfpEo2RyBLpariVgKBjQrZxdHuhMCgOGYfESZsYOPMD5vBw@mail.gmail.com>
 <03cc76df-8814-4d0a-83a6-447212ef2370@lucifer.local>
 <CAJuCfpGtxMmzG6SswnonFcyaF9LJOot6NR8kh2Re3FxWebWfug@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGtxMmzG6SswnonFcyaF9LJOot6NR8kh2Re3FxWebWfug@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0454.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::34) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 89944942-23f1-4f5a-ddc7-08dcfdb489d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r8gN60D6epEp5rjh9aGtr1U3No5vG+JPv4+IrPsCeL4jPSAjdndGIm/mj2kX?=
 =?us-ascii?Q?oxGfH7DevSXKhFb8qt3MB1np+WyvKr1FPWiiqO8q2J/k8y0xJ+22SrI/+u5q?=
 =?us-ascii?Q?rxoL4YTBp2IVZRTG36/IqYVNzKl9nVNbKL/TvZA2pZ/ii6NiWqorRBle207o?=
 =?us-ascii?Q?3V4m53AaPaD3F1PqZAEvhW1xNcqJ0sgxghjHrQmaPKux6bbEkMWcz7kcUL4E?=
 =?us-ascii?Q?fkNfq/SUdRAv6mBfmJEtsedocniwJYPEy+bcrxrErDriYQ8q23/zW4s5EPKB?=
 =?us-ascii?Q?Mic9zTjkKCJLpYiqBk904ZRp1wtFcFWXfEkc3JpGjbUJyILJpXwmP8NiNyK6?=
 =?us-ascii?Q?orG0fhB1ILTpg/Z8JnQwOl6RrsyZ2glcy5RGPdmOEOU3j+rulrSYfQJd80N5?=
 =?us-ascii?Q?bTkSt78RM7vsELh51qvtQpEBBU/8e0SSofZpyPeJs9pyQXP2a5yfsHHemAIu?=
 =?us-ascii?Q?fQEVgti2+W8vYX09aakl906WuS5nQe+Uqq4MGKS8fwRpGvRBd+kU+8jXEdSq?=
 =?us-ascii?Q?smN2IrjRj4EAU4XcK71+zRwuD120Q7LPx5y+zwyBtE7BWwf0BeigusS0c3kJ?=
 =?us-ascii?Q?3X2zsQRrgKLKyyJRO6FPJ35SwxbXuevTx9uWGwSczzsoeQvTsx/J5LE1GU0C?=
 =?us-ascii?Q?syBqj+u6qoFfTCKsvST8dawX3x4GgWNnd+FPwKdaLwDMBvnQoUjCAlxt2tot?=
 =?us-ascii?Q?KXSqrBiVsC7NlLDwGUL32bPclIAzHep4gqMRn4iQh2iTu1sJuJUDPSskf2JZ?=
 =?us-ascii?Q?B2sh/KbG8jMsMPr944+c0YCzIQRAwK4XUuvzWPk1JgxSJffedn+LTduCStZ8?=
 =?us-ascii?Q?Od+K8Y90ZVcSr9IvSSEVBIBxIRK4ZrECVsgFgGS7VI0Nmcb2tivT7nivngW1?=
 =?us-ascii?Q?rUzCnGfcJ/Ke9O/fwRt3tDBtRaWn+pGZ9laGJbdv3KAF1krQxL+l3jpDcc+r?=
 =?us-ascii?Q?0e7qdP4CHON1TVd7ki4N4gDlxDyJGMSfFAg8UKv71PC65iVTsqXNCQOGhI3H?=
 =?us-ascii?Q?2iotEudlr2Lw/c3CoZ742exwxFzFefvRGSXlxb+BtnBznra0uL6XUH82XD/t?=
 =?us-ascii?Q?8NN1qQ/gSeDEE89YeoOPoBo7Z+IHQXMEcZGlNb9knlmNFtqiDsIlaPcJUOXf?=
 =?us-ascii?Q?0Y4i0f5cevy6yBbubcAeFzUIC1Jr/2EiNMFhO3XJ7mWzQeMX1XVVa5idcMTA?=
 =?us-ascii?Q?TjCT92c0bPEv6BLU5y2xUxRiFbg7lOCjuHmCrCcOHyAIhrNraW+f8DC59DNz?=
 =?us-ascii?Q?ZFIcl8n/cKqpk+OtqdekKJEREKJC9JNjMV8M4KNBghVsmhPsv7BMuybCFxA0?=
 =?us-ascii?Q?Vgszt0h2t74AsCHEm//cx7Z0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/DT9gE3E31Bf964QS39Rlm/LqaaCe0CX5jvmTTh+LlEP83HycAtbHituflt?=
 =?us-ascii?Q?iA2hcQ7N+UtbcwzCFWwLdSnp5nzf2I0fEB5zXB9ohvOtboZv+j1yW0jX35Gs?=
 =?us-ascii?Q?0YYLfOEIuBY8L/s+nXW8QhynWmlAz317t/d9wo9Q/nUrKVmbJTCdhMtxe55M?=
 =?us-ascii?Q?LBfmM2JpEZ2/nMfOE7YwIf7O/+Y9A6vmy/itGI8X0dF+TJo3EWinWVKLNlJ2?=
 =?us-ascii?Q?mT6RK2E/7iEcBW+ajjaiKqaI41uhLEas16TyezDbRjVqpL9pfwVN8liDH/IT?=
 =?us-ascii?Q?zgpCT9/PfW2BK9NMClVQCfydnkWirT9Z/3D3QecJ+QPhhd+ocNSM7SjT8r6x?=
 =?us-ascii?Q?h69tI+cjvjcFeMunyVz3qFkjHBmxM0r7n8siKJXNpq+z10WvSg1nIkOF0mBU?=
 =?us-ascii?Q?8vLghp5M0lUI4Eua6Z+0e//5OkUSJzf8ZzJhQZyWRVrhcgkOJOigBLAYrFEY?=
 =?us-ascii?Q?xBUFSes+bQpFl5kJ72/6jsa4+L4iI29R2HmOHgTeVsW3cFda3OsURhua+mb+?=
 =?us-ascii?Q?LkxsW4A90uFb78s9h4/BMO0+HVi2fRH+A/QzXQMyTtNM1Ak5+Uz7F6LdEvtS?=
 =?us-ascii?Q?lg+ApHICCoWJY6JFmA6i3GAOjSPQ7Uyj8yMIJjrSemDR4I3RBAeZXMh8hBMJ?=
 =?us-ascii?Q?oW0mmDuPzOJtvo3yEWVchB1OMd2x1muLcWKsC0BWN6GH/vFMfFv5LzdykJFm?=
 =?us-ascii?Q?mN7CL0LsXvSYLiGuDQY1CLELO5pTGYGAP1ASfmkBfDQbmq/ZYgqofp1DIMQV?=
 =?us-ascii?Q?v3saR+982Nvp5VUqRhorLUuhbxiMyZSuF0n0JAg7Q34oaSh0dPP2uJQpfITO?=
 =?us-ascii?Q?ZwiSTRwc1cyzg6bC/6WX565r+CZgztUs/u6Utdi2gJCX6h6Vbkq95wXzMd5x?=
 =?us-ascii?Q?AlbdnhhM45+aLmp3kF2AJtj9UyBQWmZsMXOyblOi7D9d5EV4ifKhiJHHf9Zg?=
 =?us-ascii?Q?Rk3pUYtRhFq3sdW9/8hYJ8bKBz5iJYPRjzIJ8wHXkhyevJdJb0WXBJ+YEwgz?=
 =?us-ascii?Q?O0d9k0gTEhFF4px4E+RWnlkbgTxRwWzAZmmnDg6sDX2ucLPBT+RPiyL+Kqzb?=
 =?us-ascii?Q?YNzlTCunMB9F83vHFIiO3SHNwox1v3IrS+bfYqqxFjvlfqM3ylWZzsnzOco6?=
 =?us-ascii?Q?hAxr0UkrS8VH+z/n3cEdKkqDNPM5A+ElLF0pC8ArKvMppLkK6RbtwN+Bvwj8?=
 =?us-ascii?Q?RGgjvY3kE4PHiLNhEbzZuGKko33uIiwTtkW9uTwjJqLLHKGulisJIIV6BZFp?=
 =?us-ascii?Q?aBSpvq6LKaqdeESJiHxhRMp3CigpH55XE/cKVJ/PWLoWxg+IYSQOwd7hC0t4?=
 =?us-ascii?Q?vhczV3cKjXcK54DeijhSbsjadrD9fc3vklGikkr6P7TgVj+hVa0QEA4zcyEb?=
 =?us-ascii?Q?rnENfFyjDMVqXzrevKfifFzyN1Ul4jG4Mq1oMVjI9d74p0uBEu3G2AqkKNhS?=
 =?us-ascii?Q?QZbEG40Vqq3Ebm8mVAHV6yJhGjx50CEy5lRAfWqpVp0sUjN11pMjZ95sQtJi?=
 =?us-ascii?Q?LuwW3pWMhMxaPFUWD5DPNDqdJQ+zwsv4pwwB4Zon4Ncly3MFqgzvLsOcG7qr?=
 =?us-ascii?Q?dYsdygmC/dv5B5/LSEYZJ5dgwk3Fpk+eYT8Gg+ZzE5kM0DURGfif31SKM08k?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	knoQ61rCj7e8Kr6KySznWgowz+ZZ7DHCuz/QC9mZ8gtkVByLxDdsLrFiSuIBeVFlXwjuSO9V+SYdR3pz2w6I+26lHLgwpWSXVyXGj4lrJQh9bGVxk8wh6kfnmxdHxo8VMXCRGUxVXBt5t1ttOd9gCbFdGKyK9dxy7jLjjpEAkjZQw57M/DuQuxCluygASs19L93pV4GRd+X/RPVQenvtjiu3Um62DSLjzuyP+sEyk24/qbgFHomAOjdtFhYcSSNcTOWoQMT/SCYQpPOA3JhDWt0PaeCgFN5P3DBb7AJH2dCTKTNeunZDGnrpSoZJlkaOkhiwLcB23GtJlqCD9BmOnLYD/Ww72Fc+zaiSfS6djs/7sjgUxDl8vFfH0PdJwiws8bNco70oKf5l4lzHM8aLpPSxzljB/AdRekyOFzDdK8XQAfiZQRT85PMrNd+VTamMo+h2iCxDzUPFnEBmi03FmzcmzU4JB3BcPcHrSncQ0upHcjM+cxaGdtsXpouI62UN366g7t14Bumnq7C2rAQy141sOQnqVWT9UE33Ta990Fct8rsDk/5AoJdxe9xzVOnyFbaSBqrlqMTOcxEdJGMeqwIeVh4UDb+IQ7eIl7Pv3Dw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89944942-23f1-4f5a-ddc7-08dcfdb489d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:11:42.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqgm2tpjFHWTfgFmgzZBUmPQBniEGd6Tz+7rVd20BKObLUJMAVQezkq7SVH/sbOA7oR5YhOZKpq4UuB9qqaGMrVFJoDCudhi33YT+ARTeMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050125
X-Proofpoint-ORIG-GUID: 5e-L1_ThDLdKKV7l1XbLp3mFBXByxUeu
X-Proofpoint-GUID: 5e-L1_ThDLdKKV7l1XbLp3mFBXByxUeu

On Mon, Nov 04, 2024 at 01:20:14PM -0800, Suren Baghdasaryan wrote:
[snip]
> Sounds good! I think it would be good to separate design decisions (mm
> should be write-locked before any VMA can be write-locked, all
> write-locked VMAs and automatically unlocked once mm is
> write-unlocked, etc) vs implementation details (lock_vma_under_rcu(),
> vma->vm_lock_seq, mm->mm_lock_seq, etc). Easily said than done :)

Yeah, was saying the same to Jann - probably best to have an explicit separate
section for implementation details with the rest providing readable + pertinent
details for _users_ of these interfaces.

