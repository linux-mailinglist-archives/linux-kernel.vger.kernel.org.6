Return-Path: <linux-kernel+bounces-565068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C4A6604A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C35B18975BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4AE1FA85A;
	Mon, 17 Mar 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hegaMBj2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZieSJ+BG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E21F416E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246158; cv=fail; b=rctD6kPBw45Gt3QPCQzwexVfu9WRV0RtWCbp7Na4KfC92lby+6o6YdSBG9ooJHC0Gx2BCwusFikKcl4deQPJeLJd0E9uKlKtjZtDjikgvP9qofJLwfvcnFQSIthvRdxNTVNCHpVnM5518aQOc1ZAp0o/QKwkgi4jiQPcY+2O9D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246158; c=relaxed/simple;
	bh=FqdBCfADt+oykrzT/HMZgHyrd14dhwGJvSOLTz2KFrw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YzqfrBA6QFcj7n5OoTFcMl945N2BDL4007zmKEfgwFvdf6fSoKx2z0ywDmFhSDKCEuNaZxC+3y5iLTniM1pOhyuCbxwJ87HE8zA9Yt7+Oiix4XeQQL/DeB7ZO8O8as4XoKWEBmXQn7ebVoQZauddNNWtvqVhtrAts/INuOLLRP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hegaMBj2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZieSJ+BG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKxT1L014880;
	Mon, 17 Mar 2025 21:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=6umxsCGfZk59c/SY
	4uSYmwZN5TVej+kNuNbhlwrvYrw=; b=hegaMBj2M52qep4IyZHnTHP8neJbUg5S
	ErwaOgXU8QwnWFXnocSqGDqN+FfXDpDuTgD1rtfIlXaRVCSjhTls1059xX1cpVGm
	6qO8ktzPyas8J5K6MF9JPYyHfzsw6AfCUTEW6DJlWEOf1zILNLEX3bgTBXJshutX
	OWbxy7/rS/YIWOKBVA31+GPNHqItpuXok/NoyfrmioWec/xtgplV/QFAUrm+iKcl
	LHF6D178fBqwFwWH3IgXA7WMp2NCo/NKcRMTaGmtah0gIsQHRJdwB83jSOb7clje
	0CM3DiL0gbd8XSFzlT2zebuC8hS1peMyd0lsmTUTWR81l/EyokXSJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3kwq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 21:15:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HJPoXp027927;
	Mon, 17 Mar 2025 21:15:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdcgg5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 21:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=savNiw6xJ2qq2I7G/GcLv/8nTUo0fce6cdKKdjZpEqmfOcc6xTLNkFdQlw0RhAbV7DqArOsB3QzABPsnVzXS0QeKpBj2J4m3OG/PL8kI6gRXYTnG5wCbqmJc/YVD3I4A8bGr0lQZK/aQjxXKokpMky4vAtlGlF5d2EPmBd961aI4xbgwXt0kQdAdzRb1l/RlBZ7iAvFux/xAb5A38UcDD9FWI0c521OIkBtGKgcIC2SLV/4rMhApUc9i58OHq/8GJHzFXam8W1/lY/1KWh0oDrfcL/l5AAbTiE+GIh8l6Ftpr42A3+i/mLOP7yl1XYIN0wsn985lbBGwI2MqR6kytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6umxsCGfZk59c/SY4uSYmwZN5TVej+kNuNbhlwrvYrw=;
 b=pY7Rzzoas9BQ5VmbV7Sl/inQvSHU5iFyP7vyOvkKHRnOcf+M3Hylj0P8+MdalfKJAQl1bDWoQlOy3XKjFS+ChOgKqL1oUcSVT5sigX1H0nx9CJLOhS3kVA0xPyGccqD/ET4FlqUkVdSe8ZAb4jCjzsnywC5TlwgbWlERJGBgjTAYN/lURxuPoQfitxYHyP630UFiYdLlyrPXsk3v10j8B1oSuUv7lR5O8w0yQwCLLzyvtyG4+EpeNV7lT8nlgO/IVL/w9EG5Z76JyIceHDgqkZKESuFJK918uKyYI94iWi8gTKeGUoZ1VqHhvSo8f3vGjLnXpESiBL+jUoe5uyEF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6umxsCGfZk59c/SY4uSYmwZN5TVej+kNuNbhlwrvYrw=;
 b=ZieSJ+BG0VII33CpOuuMZaLYTX6e1tq3ZKh6/+unS1lO+kynjbtoNY1Eu5cK/XRvYry+H/bGYNo4PsyHrokwEL5OflKrJ//kop016JJ0oq4KIMvJX4kiyb0FEX5y/zI0hCW8+9Htk2bWZG8x9XPN4aElVLk4bTUDqDNRSSZtViE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:15:20 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:15:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fix incorrectly disallowed anonymous VMA merges
Date: Mon, 17 Mar 2025 21:15:02 +0000
Message-ID: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::23) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH7PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9efd47-0b98-4921-ec15-08dd6598d2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AiwZZW0p6fdHPGcJQtJeaPAcUHQqtH+rsjbq86raL7/GGCzDe/PHHjhO4jNE?=
 =?us-ascii?Q?NrHjt6WrRyd5rYjz+m2E3/HD5jsFjrfpzdLnZKP7qOdcpv0lvSmkW3Dlt3Az?=
 =?us-ascii?Q?PTFIe4Hk+xLKA2/8Mat00HH6rZKr585Dz/LfF9HNu1ztzqOBkFUQaB9VNjhx?=
 =?us-ascii?Q?+2tzq4mPPj6SFbYOfXwwSYAN0bJ/d+78tHyxs+YDvbFy5W7fnYNYSLQz1nex?=
 =?us-ascii?Q?fraQLCk1E6fkXFb12Z1r9JyEF+UrsariY+ubU8GzUj+AR/y35k23xG9OzuqX?=
 =?us-ascii?Q?b0WSa5o75hohCepYNqrbMydI8JRb+13OeUq2Om6wSIYT2ad5t/B8GRVjiKoy?=
 =?us-ascii?Q?0C/PRnaagspk7LCjyeewVKrqwLghIL75skjiZyddg8LJoGppVt8ovg6V8uuR?=
 =?us-ascii?Q?WPQ29o4KdU1uoELKvY4nOSDrDDzrzEFWpME7qYmNe5566BAkXBKMISqv0msU?=
 =?us-ascii?Q?uAnh7XxVH6fxrCTyYTBRdknaKnVcGMJQSHUVNV1d97fYV+6CzVs547M0KMAK?=
 =?us-ascii?Q?xjAwJtX3sc8vVTjIWIbc9ymohnmjcbyL3FQEv5Kh3FXjNDM3nzqTWlL2FuE7?=
 =?us-ascii?Q?Fi4OAyIGpz1oyL1mUJhpu/eIFZI+8a5liGrK2vpP6wpAyHEjJntOP4MVZe63?=
 =?us-ascii?Q?SGQukbvW1zlPXEpP4ErPhBF+ID5rY7wcbxyRzRnx/2VugiBzc1/en2sJz8M1?=
 =?us-ascii?Q?uQLoJHCAw14cqJKyIAw6qWxRge2ZgIKm1VaqUXWuOoubgE21DgbHQnpYlwmb?=
 =?us-ascii?Q?xMbb8fAQBqXjr39PosAswxbeSUw0Y4+sCp8un4aculhCeIr18LVZCAm+0+RX?=
 =?us-ascii?Q?5dzS4g04NNyTsdb6kX7q6oE3YxL/Gn5qoWN/nzqR0IKLnaPc0MluLfpVTYdt?=
 =?us-ascii?Q?nML825f9FcNd70rszq+QyOy7FqbvtLcgX5e14aiWzW2GnVBip+Lsc7eGTICG?=
 =?us-ascii?Q?UCxXHyNPCwGSFvmtYNTW3Q6thUIr9B5IT9995IupAcRix+PE7HxByfbUsTWn?=
 =?us-ascii?Q?+ByD3Bq5P/jxWnteEwxdpNtNjuDjK3lVAS/qM3XVrULcuIHnEIO7710nti7U?=
 =?us-ascii?Q?+SIRv2fWiBo8/P6as7f2ywBea0bXAv12+Uoq0R5vrL2NMFnuKhcjOMjsSk5F?=
 =?us-ascii?Q?IA2VH9PKiijNt/2lxk3m0ZSrkoLeFByoZDKt2ZHxiLlrVvYVWsyOaEaNT1Dd?=
 =?us-ascii?Q?sP1C9uj1+fatnB9vgQ6NVhIMmKPp6i55K7RcxV66EowS88ecPQm+F37GCTtq?=
 =?us-ascii?Q?88NAWbuKxnxSSmAu5rgIMOGBG+HR49fSY3emZd3ucCktqJd3KXqFq3zXQKcm?=
 =?us-ascii?Q?xIbNJWmgqZ1crwAxgYLQPS2qrmHTr+rsG14/+yRl/nnSggWzgeqSMB66aaLN?=
 =?us-ascii?Q?r5NhinQeYUYL6Tj/bUhCMeFnDuVJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPw6TficYkscGXizbqxDFvVTKJrdHbNZJIvXxkohUZ4zEPThEGVD8TDsTEiE?=
 =?us-ascii?Q?HWMJ7t4QEBnPEFhF/Jg7iptF7VDxCWEgEWyL0ww/2qD1yCAAYnXyyXBMTKge?=
 =?us-ascii?Q?sU0rHDo7d8NbOiJ3pdtc3A3v+xOjzDwIrbbaOXGYO+5AMiMKkhZvA56XdHMc?=
 =?us-ascii?Q?0SxDs7ks/8V2O9wYYygj+uO93tQrxAINqzMiWDzUU7v815Zc8Uv/DkcppU7r?=
 =?us-ascii?Q?9bONCWWrHy6ITTIEYUKFKfSbVTEaCIoIvCyJZ9FzEqSNfy07MA8rMMUf1MJu?=
 =?us-ascii?Q?pEhSE30kMhlzztZq69j9aFv7T95/YoX+Pp4kzQnRTNIT5qEFUVG/8VolJwpZ?=
 =?us-ascii?Q?QjiVxTkiD/HSwuWshVnKbm7+JGXPaYrmRe/nntw8sKaypICnSLlVB9Rq6C+W?=
 =?us-ascii?Q?1jCuGeW58ruVuAlA35Jwx8tqeiXpH9K4EM4qdqpNG0qVXqkuLyR8TwDCA8MH?=
 =?us-ascii?Q?pNsosjbldMJc6jWLZsS82oT5Aenr4vjr8b9EaJLi5XNQ9Dx82CSGxDwz06qZ?=
 =?us-ascii?Q?NEppNjAvn5zweBDjXbKw/ZK8of+P1W5rhHnzVawJMFWUpXbHlQBaDqvSVnx6?=
 =?us-ascii?Q?VmV5NoI/CKB22DBBhNn1K7xw87k63lkVe6MnDytITzOmYnvGgVVmvYD8eGRI?=
 =?us-ascii?Q?WM3i/ttIF03jdhpwY77THxV1vGah8Y6MgPSpAmXu2kzFIt11U6WufwUHhY3J?=
 =?us-ascii?Q?+553aT7Icm5j6qVFHCNqMWPfHlgOf511OiBzlA/7DIum4IHddfdrjD+vlgqM?=
 =?us-ascii?Q?IVmiOdfiKvGHlqq0qjPJ+1n33JzWq8iv3K0+AfSyIiIef1B0jVOSHzIWTcWh?=
 =?us-ascii?Q?j9tjbc8iBmwIym0xqxoi/vdJRpUb0HAHWj9zo1SQhRQ5hHvS3Hl6mdvEipum?=
 =?us-ascii?Q?eI5BbM0dzjfSuL6C3fLFcdHrRwFGlK+8qbX92JMKtdyqiSC5h/t3fB3jL8Y8?=
 =?us-ascii?Q?mw/nCWQi3r2ED1D8Zsw7QllFlYJfJZA5Yr1jLrl7xv+MxoJqvDkFKHpPbE9o?=
 =?us-ascii?Q?/svsl/veO39X0h/j1uWYVuxmBlmd0HnvukgxGb3lscpgZEu3KeUmOhOS3FXh?=
 =?us-ascii?Q?/gjFMnOGr280Hmjo6TzwtBCrK020eu8H4aqD4m2qQOg6izbv7fcN1n7nioVt?=
 =?us-ascii?Q?515EXvxqT6iHMNkE5cweDl4Dlqxl7ManMB/LUIrPGfDkmG3PGM02GWsEWWtN?=
 =?us-ascii?Q?CJ6Nw1ohL6hPAN4XtXDv50uz7En2vtzmssBPQSFrhWJjzDhtRVg+zCBAmVEu?=
 =?us-ascii?Q?bynKiyrs2L8Q9grwLNDg1cweZi0gf3/xjl6t3y1Y6LAluRImdyUb8A2Al0FB?=
 =?us-ascii?Q?ddDziyAfbWXaqObkSsxHmY3nwVBO/7FA4enUywkd3QstIWFXuJJRbAvFKS8u?=
 =?us-ascii?Q?QVOWEiRH+HbzF5waVv0dOUujI3QTNvxddaBT1/DiZZx/HpqUL6cOF2BojvUt?=
 =?us-ascii?Q?otjBCaWyPrAxhCUvgiSOccXNcKthX40urz//QcF+C8gJXDATi9yiEfUX1ydJ?=
 =?us-ascii?Q?jRPWFZrUGBMp7p5sJa95h7w36u3sbjwOgwRhDuOd7Yzz6pAUoCu2S6zdSBud?=
 =?us-ascii?Q?FKpfoouJC6VStP/0lAwIgjhZ+FQQucdQJAZkHoPyWvLWJruMZcmjOAk7cpF0?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QQfLVXAZWshu7qQUZHuHTRhTq0ge2eBaAAztOwbW5/ns6Tk9OjcSgFQGXQmx006s8RazsTLvjLT4hGX0/XLuPUGMMf5Fn/Gg9XzbFT2vhtr3H5bP/zoF+OOqpROCjGH/YNbyrJkRCLRQkGW7EUCYpGsuRPn+Lv2DYlT45JfXKEnAfn/1vSAZp+AVzwT66WtqkNDkzc6HRgSr+bSEHpxXjRvrX5Y9b1k1ti5k3VSOZruaYlHcTjq2LNMzwWp+MocvobMxyXKIuETMKjteQcaoD2G51S1Y3bACw/VWee5CVsQlb897nIpe9gDOUuUBQtULtlhdCnPAawzOpXwj0Kp+DUaOeJkMlZWFadc1f/skK0SViItPezdyJBusd5RqKMuv5//CCaJtmrp7OzVwTHM58I4JvAyx0Bpx82A35I26tdEZLnooFkuEstcGdliOnnlZnY1Vi4yTTTE7ROU7pic9yqh7UzgFhilXkvT/BIAaYrdz3v/eV2YMIdtKbEdviiry+OXpI7kYJFp0hJVCQ1WqP67xK/LnSnSst7aWwHkEhdZW9KHWwt21iNWfibsj/FgpBJb0XqP8u1h8syJLPkSk1A4epfuS4us1h5AyoTdDuYk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9efd47-0b98-4921-ec15-08dd6598d2b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:15:20.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqIrp3bw4xAcBx6QJf6iPA+vQMzmNklMCsc+hc4ba+45tCBTQ+oGAkHU6rzdL1/2k0NcqlSjhR+pua3c7WaXH5GxwGQWgClyNsBOS4SKrZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170153
X-Proofpoint-ORIG-GUID: BPq97quhAIifcbY9ImjiEEP3Dj7_OGbJ
X-Proofpoint-GUID: BPq97quhAIifcbY9ImjiEEP3Dj7_OGbJ

It appears that we have been incorrectly rejecting merge cases for 15
years, apparently by mistake.

Imagine a range of anonymous mapped momemory divided into two VMAs like
this, with incompatible protection bits:

              RW         RWX
	  unfaulted    faulted
	|-----------|-----------|
	|    prev   |    vma    |
	|-----------|-----------|
	             mprotect(RW)

Now imagine mprotect()'ing vma so it is RW. This appears as if it should
merge, it does not.

Neither does this case, again mprotect()'ing vma RW:

              RWX        RW
	   faulted    unfaulted
	|-----------|-----------|
	|    vma    |   next    |
	|-----------|-----------|
	 mprotect(RW)

Nor:

              RW         RWX          RW
	  unfaulted    faulted    unfaulted
	|-----------|-----------|-----------|
	|    prev   |    vma    |    next   |
	|-----------|-----------|-----------|
	             mprotect(RW)

What's going on here?

In commit 5beb49305251 ("mm: change anon_vma linking to fix multi-process
server scalability issue"), from 2010, Rik von Riel took careful care to
account for these cases - commenting that '[this is] easily overlooked:
when mprotect shifts the boundary, make sure the expanding vma has anon_vma
set if the shrinking vma had, to cover any anon pages imported.'

However, commit 965f55dea0e3 ("mmap: avoid merging cloned VMAs") introduced
a little over a year later, appears to have accidentally disallowed this.

By adjusting the is_mergeable_anon_vma() function to avoid lock contention
across large trees of forked anon_vma's, this commit wrongly assumed the
VMA being checked (the ostensible merge 'target') should be faulted, that
is, have an anon_vma, and thus an anon_vma_chain list established, but only
of length 1.

This appears to have been unintentional, as disallowing empty target VMAs
like this across the board makes no sense.

We already have logic that accounts for this case, the same logic Rik
introduced in 2010, now via dup_anon_vma() (and ultimately
anon_vma_clone()), so there is no problem permitting this.

This series fixes this mistake and also ensures that scalability concerns
remain addressed by explicitly checking that whatever VMA is being merged
has not been forked.

A full set of self tests which reproduce the issue are provided, as well as
updating userland VMA tests to assert this behaviour.

The self tests additionally assert scalability concerns are addressed.


Lorenzo Stoakes (3):
  mm/vma: fix incorrectly disallowed anonymous VMA merges
  tools/testing: add PROCMAP_QUERY helper functions in mm self tests
  tools/testing/selftests: assert that anon merge cases behave as
    expected

 mm/vma.c                                  |  81 ++--
 tools/testing/selftests/mm/.gitignore     |   1 +
 tools/testing/selftests/mm/Makefile       |   1 +
 tools/testing/selftests/mm/merge.c        | 454 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   2 +
 tools/testing/selftests/mm/vm_util.c      |  62 +++
 tools/testing/selftests/mm/vm_util.h      |  21 +
 tools/testing/vma/vma.c                   | 100 ++---
 8 files changed, 652 insertions(+), 70 deletions(-)
 create mode 100644 tools/testing/selftests/mm/merge.c

--
2.48.1

