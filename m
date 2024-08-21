Return-Path: <linux-kernel+bounces-295302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA19959979
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BB428415C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB91CEAC3;
	Wed, 21 Aug 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sl4XoJav";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yVR69Z6b"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817261C6883
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234422; cv=fail; b=C/z7Na04PUDQoGWyzcK7NWzPBWZDr7gHxtzTEDYEVs+i6t2quwEKP9gFiqNaBd4423nnO65bUSm88yRR57CJrK7emenaN24i7AyOr820s/ZInv0pTd2PD6ee3nYI+kVtep6Tqd6MWOYM7lfs3sZafo9jATdon7Zt5mrTzw/u/Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234422; c=relaxed/simple;
	bh=QyMnAFyiIIFYKKlhMVqqxJyREVrvG8iuOumAj5W9Z5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PeOBYw0Xl5eLFpUXuZUY+MvP2e5tOfVzR0tIF5bFzhJJr8gwZDfsGyVu0yf4bEuwb9w/abZBVhAEh+zdUJBDPl0Ff+4ms5obVlffPUK7hc6Ql71mWvj1y8AQVE/jI25YUFuSI2amhcAIQkCcF7GxloWbHec+lKWNLmXrpBvcB7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sl4XoJav; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yVR69Z6b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L7tUGN006145;
	Wed, 21 Aug 2024 09:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ON6oljlX4aL1O2y
	N5ay515KnKuo9gPbUPQi3pvQS9s0=; b=Sl4XoJavmCkDH0GTAnO/6nDGzrhPFXm
	9KnQog+YKiKkc+DWNV1ojEkT7whFCE//gvUJEBEufL1tDSXzfnh5fLwzX8oQHD1F
	SRcSzz+VExddUQbYrazGkpvj1XOPu1cJzKPWxmRGt4jnB7zkj4rt+2Vq4FxPihFO
	U9Qmmr19lK1uHKPkrKNwayW05zb37jiX3LVgi9rDBaI5hpTtDyqDvzyClF2ftdAM
	Zp6ZcBewYY3CBmFeS33esJYys2+aou/G4CAp8SA9x+/61RqC/Q205L4fNBuZhHHj
	ZfueUAD6TQ0can7cFvwM3D2yek5NVX/I5Xbvl/OcN0GSh2i256GYZvw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gf68y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 09:59:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47L9Y61r040218;
	Wed, 21 Aug 2024 09:59:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415dqj8pdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 09:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hphpaFItMdwZF8q4JF7dozYR9nz5IMiYlQXPf8TQ4woY+cdyQisBlPJi4C10TrID67y8g+otz3RZSuV7lBAKPR6pSiaR0LXw3t1+a/QawM0Yl8o3SAagBIuszw8C3xIa4vbR8ydSIAeXIYVmIB4WxYRS/ZlaPOubqv3TqiDqq84TbWlC1Pe+UEdtyxAXZYpha9yicUg0XBY6cqBKNa4LHlA7m0gEy0hftKbgNBuoDWhIBR/95iABgPjGK7uNCugP+A+4PYUpobTan7cYgJ7tZdjEIdexAcaVkb+wN0toZ8bRMuNL7wMqJRgq+yNXqfLNWH6M9I6lJGfbNacrVvu+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON6oljlX4aL1O2yN5ay515KnKuo9gPbUPQi3pvQS9s0=;
 b=puXKmdcB/BORmah1pQt22gf9xbERcD/NA3eZRvHM5vLDvKRkT9h+3L3Ux6FcsMEawgLmzUkf/Lydq28I+gj4kWvJ+K4DBWadgXv7P1nCrqJGHXXT0yF4OExSV2gLANoqkuGkxBgkQdyrbDxgnwPVcg6nuLXQI1f9vIaQRVgFpNaGzUhtnxEgIQgpp6DrIN+9/S0MEZdytx7Z9VYg0AcwCYnvvGpKKQg8cmHkWk1rwzMVEYrFaMeBUSl2ZbBBYcEc8dtLXSRFprNen/RQb4MFeCAjkp9rvWen2yLoAfc4sQ+1Bgk2QtVqU/omwRyoz4drNdI1KZK+lJvQ9W0Rb6n+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON6oljlX4aL1O2yN5ay515KnKuo9gPbUPQi3pvQS9s0=;
 b=yVR69Z6bQJBzICDZAIOUh6uyGtxaR1wQzxIhtC4/WVYcAOxS7czhkc9rnud3eU5BYWJkABj+/Xin9WUM/pGEUAIVpv1uYjGrbJxpnhI006wY6TXX0wNDWzrmYFHhfZJNRvOVgQ9yeQglzHmmR0dWfgP7cR2d+0zU0u345nU714k=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6150.namprd10.prod.outlook.com (2603:10b6:8:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Wed, 21 Aug
 2024 09:59:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 09:59:54 +0000
Date: Wed, 21 Aug 2024 10:59:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 06/20] mm/vma: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
Message-ID: <29bfe4bc-b60b-4d5d-a915-bc835312c989@lucifer.local>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-7-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820235730.2852400-7-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3a3842-7e35-460e-7c4f-08dcc1c80194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rooZYPeQoLhKzfV7fd4KMObbvOBuucBm9i23FsxPfot1LBIDkjYAy7bN0BY0?=
 =?us-ascii?Q?MadavQlQ66GY0L26kfu1rNQt698HVlkWh6iK0OondfwYmne2BX5Y5rC7xrMN?=
 =?us-ascii?Q?dfN9udLUYewxfq7nEWOngvDUaqoOAUp+akJuVjFxBFCdZbTWggs04EdNnTs2?=
 =?us-ascii?Q?LmkVTP6greZ676LsI+hOi8PDRo8ean3Zl1fQ7x50iZjEcVjqAvtEOJ1qIOja?=
 =?us-ascii?Q?xrqYwYbf9LBlBKpNcxQH1NbCYXrb2m1IHULmWSR0+zHYPDi+gGI0qG0R8A1N?=
 =?us-ascii?Q?atnz0KiYWJKcdzDX+DRVMso02hzGJtMqafpXGI9v38eHaYV7Tfx4VrWb5vkl?=
 =?us-ascii?Q?mElqnJMn6S7HfzCpxOoHhaKGt4Iq3fvTzXSxTcwnVKlA25wcsR7hTF1clFMp?=
 =?us-ascii?Q?vIG8uvUM0SpjkOxEk5X7mPxZ02j8zTQzPAkB/gs6LcaDAjFu88Li8Mtpz8po?=
 =?us-ascii?Q?wr+Zw5OsQzoBYx8WMvtJJwo07QIoynoJc2KQiqJBKrHhynZdXpbfald41Cl2?=
 =?us-ascii?Q?LjH+hFdbw+tXqOhoyrxvD+JTcJs0Pxpn4gLY99iM1Ihcxmh3K+KlgAST8xZy?=
 =?us-ascii?Q?dW6mcoVd0ZZ0nKjaFm9A//UxZPN5lhiUmFvriIPTxtdcB//gvUjshPEgXXSb?=
 =?us-ascii?Q?M/nWud9clLfYIzNpKNGhKmjk7RIUXITBJj/mwaTebz34VOKgczD/EVoS9vSn?=
 =?us-ascii?Q?2IR0VpjUpBBcyykpBLQ7Q7YPKwd810/z9fw4Vx4Dynj1Q40/cbvxtqdo6bQp?=
 =?us-ascii?Q?wetb9m29GiF92r8n/2D/MW7t7Ulvq/+q40z9NoB5g4pjLu5kIkpnS9bTHzBw?=
 =?us-ascii?Q?fLaPymP9RheDZC6shfCgBNUzxg7uYBjFERqsQ4VakMqs170ev8br5/IdL7cr?=
 =?us-ascii?Q?nkZ1ikuFVERIRwlpY7gjnLGOzZgom7anBAKOY5E6nQhPRJa0i+JpklT55J07?=
 =?us-ascii?Q?p3qnVUxX88wBrkMrjB7tDSwiduJDJuaMq0cgF9CiOsHjD54D1uCrLfXmAUIT?=
 =?us-ascii?Q?3T3sFzp+1QbKzc27OtVLiL/BXONJWTjrPSyWHdg423nM5/ghHqjGrARNhQoQ?=
 =?us-ascii?Q?O8ZtD0ranBNAVJ5vw1OT0jZYY7xGBvzcJwq/nuJ3hBT4aR+KYcNlXAfmHfdH?=
 =?us-ascii?Q?IpeO3XMUXQSN+NFXm/3nt7AoZsc1+rUXJwZCvGVwgQO2k7F4YrMkbWuLpzx8?=
 =?us-ascii?Q?3eAVTJ8RSHk3Ae2h/wx+2dkKir0lW9A58D9iiXf0zco9EHRBopeVY8E8o+9k?=
 =?us-ascii?Q?G9SliVfmhwC40Iwew2dE3WRmTAM9RKERDvrIQ7NFrNu7h3UW9QtIErnl47rW?=
 =?us-ascii?Q?YwzHMs6hLSmWY9TFljkEuWkEKRZvUX+wxV4LHyQzEgvagw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vhjDdZGLC9wBojTpXz+LjUdgBS4cM9su3YMc16XlG3ax/kgiNcSsB+vtt7Vz?=
 =?us-ascii?Q?xW3qChdFyz9vzNfQjeUmVgjG27EujysPZrKEvEaEM9E+cyVeqO0eNh9TOEmh?=
 =?us-ascii?Q?SkcZLuTUks3hv72Ld4E0ukDrw61+HJKTl/5RuQKDFZAu8BWQ3SIN5UPBG/Cs?=
 =?us-ascii?Q?dFaWec3tDjGR++1ulLgCdiXbo7oxyYBkaUYSH9l3YOzvxomUR6gH4odwdCAd?=
 =?us-ascii?Q?povSaKg6r76ASK2/fsxibL0RKgM0uzEckERo8CNIuragHZZ5eFY7LxovBPtN?=
 =?us-ascii?Q?juOgxykhdBcRBx8kCjT+qGSiv43ua0svw7kgvofEL/fvDCm+W/wlsUtvL7KD?=
 =?us-ascii?Q?S/1302AQ1cl93JaaBemi2TGEcaygJyr5yujVLmtcIA4JoNSYu6WtDjiqR9zF?=
 =?us-ascii?Q?ItsBgqhzhOrwEc3K+qIxxQ7h0HyzjQa39pUaS6vLRA+17esSw24Qq7B64hOt?=
 =?us-ascii?Q?TGFqftVnTQh62OY5mm5m49FMNUYOP2eogjmjwZmzooMQlx6OwktxgvQ0rsq9?=
 =?us-ascii?Q?OOV3JNbYlDuhd9Ca65EezVszZ9BsopfP496b0dnxg/JMa4la0iTIyFQoMzkM?=
 =?us-ascii?Q?tB5c70wO35Ub74RWqbxAm5Yk6HPlwztvKy9IZPs6PRJTuTDxHcoY5m7JAOHp?=
 =?us-ascii?Q?m6CYO7Ze2uUXnFy0OS9h6TNC0qjNYedoZyINOMKSGfGwSxeWI1tbIdsEGbkb?=
 =?us-ascii?Q?uKO4SqokroXPWfpZly/9NlH5NsXckD5AeXyZlAWYELFTIAVqdVno7Dn3PbLF?=
 =?us-ascii?Q?oG1uY13Pa+oupBlgFsbUk0VADUeyUQwNOWxqb4Ae3UubJbxAz9njDDQwVvGn?=
 =?us-ascii?Q?ZwtzWbbxf2CQsLD8mxA1wc09jOrt9faf27Te8ZAe21mNYp+VkBJsTTfujftA?=
 =?us-ascii?Q?GzMnnfD4kqgRVrA8zdfQ25Tk/nproec8wqAmKLs/MRYqUcFGF7DvOY1ZDROl?=
 =?us-ascii?Q?2AjE9uf9h9JxxdGTFolx61YPNQc3XAkjZOr7i4wkv+9hVu6ADU315avZvTrf?=
 =?us-ascii?Q?mf4nkqt4Pzav2I1wDMXDBLlcBEfpWmIKgWecC9MWnUoKDWQDHUBa3NS0cZ18?=
 =?us-ascii?Q?guflPbMwZxb4r+VVUBAJR+7G9YVlWv4hSa6YxSy+C50HciVs/2XMBflmmiHn?=
 =?us-ascii?Q?0rwwDki+uXK6iMzQeSpne0V8ikKfQ207yIgm/vaKEIKH247z6xm0cBZHcxdr?=
 =?us-ascii?Q?Ftn/9uP/xxTLAAMDHZtHLnKqdQngvtzduzlc0pjswjDQy6TvagqUryhqUT97?=
 =?us-ascii?Q?kwJTrcwW1eYSK95uwkPH9PkbG5gWWKa0gzMVe1xQ2TtXA9GvZXJWk8z1evjZ?=
 =?us-ascii?Q?lck/9/zY7oHxhpV2Oqp1IBM8DU/DxPC/R2I13t3MKMDmIm7rC2XTMT13vZkW?=
 =?us-ascii?Q?Ete/tu8VpDnsnf/kRqehBdiGJec64luiM0yA5a/rmpdE7MZkvAj5B5xTbdcH?=
 =?us-ascii?Q?O/KYffjYsWDgv8r7UsJkTuL+NakjEpbYSELNuipoRU1EuR7eXfBw67eIM4my?=
 =?us-ascii?Q?YM5fRVpPIl9j/B0E62Udo84kUu1b0VPBH5YgtLbUIe7X9pXND8QvNjHJNkR3?=
 =?us-ascii?Q?OuPKe5DVwkD7CylXT3rjZ8GkZG/uYWowi1txjy9ca23ATUj9pSoE+fiSZ6Gi?=
 =?us-ascii?Q?iBuzM1HaBsv4IJ9mSx73l6v4n3E99M9fhavGqFstU1ynrqZpeRqrfVmZPXuF?=
 =?us-ascii?Q?g5EUTA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Mx6rx3mZxOVHAausVTIoqrbkG1iGGyTlx08MZTSpP/KuWyaPOZ04veGAeWCpm1fYkC+iuDA9oJAAcRvaep02oIc1eFSAW5Say8KO+CBwhC0yzOuTBlZrDGUAoaNXYVfDZ/tY3OuX0Rfaum9o6xnybsdJwpY3UqkMWyOCzh7xp5DFew6xEGXIH34oMW52TOmMjRbICudP52RKdu+S4Jj2in4hb9T8yC5YGQSGAUKLuYyobKzt7zR/Pq9nrCOEfxRM7zo5CibXfmycTyZriYAikZwBlKblPNne2/farLYXi+xgf+0r9Dhfezz4WmCyoqoEZMxFNx3UfX+ZnsQi0xcLmkHxSyqfmnl/7I5Iult4ckn2utrCKUq6nhGqFilP3giFlxdhaqgKx0AC0nWPOUEHbQpOWh+rzL+2KLe6bcwJYoNGEo1A/vSkD6pZvdSpE1HvMOG6CwnieE4SAF/aQVnmwKQ3zHVjATmYIPxU3yO9VTWdivRYuP5et5+ZSczgpALySMSS87OfcSuODhA/sw3EGg7QMLxzc2SxDj8ACDHUGbGLjpPvilI5duQ6N4GM2bLVD69WT1FIr37+4EsfbzOlfRH9QkE2KhZ4zWkD/yU5DM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3a3842-7e35-460e-7c4f-08dcc1c80194
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:59:54.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvZs2Yb7e3XWMFw7iKPYa6gd2m+PfbNQbRKZaA6ycnLUjyasiRaC6uvwOzBzXnRbrEQnXQwDqq75zHGsyRQrv4Nvbu9f/TzOycHh7UzKb50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210072
X-Proofpoint-ORIG-GUID: cgkPE667988EjWE740pt3jbBke2EziZF
X-Proofpoint-GUID: cgkPE667988EjWE740pt3jbBke2EziZF

On Tue, Aug 20, 2024 at 07:57:15PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Clean up the code by changing the munmap operation to use a structure
> for the accounting and munmap variables.
>
> Since remove_mt() is only called in one location and the contents will
> be reduced to almost nothing.  The remains of the function can be added
> to vms_complete_munmap_vmas().
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/vma.c | 79 ++++++++++++++++++++++++++++----------------------------
>  mm/vma.h |  6 +++++
>  2 files changed, 46 insertions(+), 39 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index e1aee43a3dc4..7b8b8b983399 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c

[snip]

>  	mm = vms->mm;
> @@ -731,21 +708,26 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	prev = vma_iter_prev_range(vms->vmi);
> -	next = vma_next(vms->vmi);
> -	if (next)
> -		vma_iter_prev_range(vms->vmi);
> -
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMAs
>  	 * were isolated before we downgraded mmap_lock.
>  	 */
>  	mas_set(mas_detach, 1);
> -	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
> -		     vms->vma_count, !vms->unlock);
> -	/* Statistics and freeing VMAs */
> +	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> +		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> +	/* Update high watermark before we lower total_vm */
> +	update_hiwater_vm(mm);
> +	/* Stat accounting */
> +	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
> +	mm->exec_vm -= vms->exec_vm;
> +	mm->stack_vm -= vms->stack_vm;
> +	mm->data_vm -= vms->data_vm;

See below, but I bisected a bug to this patch that manifested because of
miscalculated accounting. So I wonder whether it'd be a good idea to take
this opportunity, when updating mm->... stats to add some:

VM_WARN_ON(vms->exec_vm > mm->exec_vm);

etc. for each of the fields updated. This would help catch any accounting
issues like this with CONFIG_DEBUG_VM switched on.

[snip]

> @@ -824,6 +807,22 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  			goto munmap_gather_failed;
>
>  		vma_mark_detached(next, true);
> +		nrpages = vma_pages(next);
> +
> +		vms->nr_pages += nrpages;
> +		if (next->vm_flags & VM_LOCKED)
> +			vms->locked_vm += nrpages;

So I bisected a self-test failure, memfd_secret specifically, to this
commit. This is because you are double-counting VM_LOCKED...

> +
> +		if (next->vm_flags & VM_ACCOUNT)
> +			vms->nr_accounted += nrpages;
> +
> +		if (is_exec_mapping(next->vm_flags))
> +			vms->exec_vm += nrpages;
> +		else if (is_stack_mapping(next->vm_flags))
> +			vms->stack_vm += nrpages;
> +		else if (is_data_mapping(next->vm_flags))
> +			vms->data_vm += nrpages;
> +
>  		if (next->vm_flags & VM_LOCKED)
>  			vms->locked_vm += vma_pages(next);

...the double counting being right here :) so I think we should drop the
above couple lines.

>
> @@ -847,7 +846,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		BUG_ON(next->vm_start < vms->start);
>  		BUG_ON(next->vm_start > vms->end);
>  #endif
> -	} for_each_vma_range(*(vms->vmi), next, vms->end);
> +	}
> +
> +	vms->next = vma_next(vms->vmi);
>
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  	/* Make sure no VMAs are about to be lost. */
> diff --git a/mm/vma.h b/mm/vma.h
> index cb67acf59012..cbf55e0e0c4f 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -33,12 +33,18 @@ struct vma_munmap_struct {
>  	struct vma_iterator *vmi;
>  	struct mm_struct *mm;
>  	struct vm_area_struct *vma;     /* The first vma to munmap */
> +	struct vm_area_struct *prev;    /* vma before the munmap area */
> +	struct vm_area_struct *next;    /* vma after the munmap area */
>  	struct list_head *uf;           /* Userfaultfd list_head */
>  	unsigned long start;            /* Aligned start addr (inclusive) */
>  	unsigned long end;              /* Aligned end addr (exclusive) */
>  	int vma_count;                  /* Number of vmas that will be removed */
>  	unsigned long nr_pages;         /* Number of pages being removed */
>  	unsigned long locked_vm;        /* Number of locked pages */
> +	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
> +	unsigned long exec_vm;
> +	unsigned long stack_vm;
> +	unsigned long data_vm;
>  	bool unlock;                    /* Unlock after the munmap */
>  };
>
> --
> 2.43.0
>

