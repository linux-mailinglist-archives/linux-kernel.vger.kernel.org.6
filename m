Return-Path: <linux-kernel+bounces-206621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1655900C17
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9191F22ED9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C132514A0A5;
	Fri,  7 Jun 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kbGSX4FZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o95bq1hH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56113EFE0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786431; cv=fail; b=hR7uXvTqQxblR/3B3X28KHLDAlTynBTZPbHYulVT2PP7JGcyjMCjNpdfYZ7RR+lPJLTtm/UWnyH2trTb8Gu1UzYLiihcSVIpes28xrgpMry7pKFlZOVP5F8rKdkO5iJb94yHgj4RwMRZKeLL8ai/6XsKhRH0laGmXBznJK3Km4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786431; c=relaxed/simple;
	bh=Tz4g+fwqCahmY4lWj0Uxs4YEqiNDJTYlgFRStoiHIiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkJu7VPAj/GPz5g8g7yKeO5MjHEnHOIoq95eJ2zraMM8Wql79xahbMohh8bZFlj9T4jwNNojFVpzfHjg1aJLeaWU9dQjgI/5Hp0BVT2ZPs1Qy/SqeyeRO1rmYkvHeVp/Mj89tjIf7MzgWyNtjdqCCXvoHpNbJ8V0GYlrNcDxlM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kbGSX4FZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o95bq1hH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cup2a021557;
	Fri, 7 Jun 2024 18:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=D4ZA8OWgwj5vBfXfTEiiu2poxtY0VzIKWAMaeLisH6E=;
 b=kbGSX4FZog4XkT/zrXbp8ofpaQFuw9ao6eP1A5asLhXyzi0dt21IFKFq3P4G5AUBFjQp
 AZJ6EqTTNLqOYrxDGcEylQF3hGMCqCgOlFosXuhTTSClTvrLhOySW7mEj4i5VhmWWC88
 CNTcuycSPQNJbYBVolQjrKdlT0sbJekczdbvdU4ozTXWRNtNLJD1erxH/Ou4yl173Pxi
 jLfVn6YeCprsSj0GvEYbYmahgO4vGjIiPwjekfnhrg8dpQ/Dgkp8CFZxc0bgrbFIXxCx
 pOQdhibralD5g1UVDE/mVLsVbBkEpSVyTrHKPO8vKZLQxdu1ZqGfhmNE3ZejWLPiIpex Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhea40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR4K023938;
	Fri, 7 Jun 2024 18:53:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0rr6NYAxqKqQ7ILMvbo46UU/d4NA0vKBTKHldljGo+7lOgoztGbbBaqQlekLuP1R36szcnUc8FcORH4T/Yk+40rHBMSprd+j7hv2/3XmShAcMjDHRbgqhYrR3Vz2Y4wP6crtoeEEK6lac+G/bYJZjbIc/+wO6Rsdq7IgrTCKBkF8ADoUeAZsSxW+Nz6g1TJ7pHrHlc6zT2PX+6dPxoz1sAgac0EeX+EftlOZTt69bWjjEgrYQk0C4be2BThqMcMn+GmuYp1a7liTQ/EhLmXQPTTUUNxfvwymGOtBu6LCokZ+aMKit2o19m7LTDNVWv5dNqaUDSEJLp527wRqUU/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4ZA8OWgwj5vBfXfTEiiu2poxtY0VzIKWAMaeLisH6E=;
 b=jKStKMg2lyIcjR5gXSW9KLXjgL/Xe10IpdN14PeH/qZMgmcpyLeGX43p8cljaNyaWt8tpXcYJOzyfLrj81vAyoqP1Zs36Dmh9COn7v4mxZDonmXvLVOssa2v6sYgvMUZrUgVfQbfN4HCzwP+R9f8OvHSMF6fzwlmMd6IzJeYrE+wGVOkf6SvQZKvKkj3UW/YXyGLq3Joc82DeDEFnYrGm5wGzzjBMzGvgV44l9INzOaeyKMuuYCZ6EqM/p/iTFCrxejWEsAY1Bv8+j2DQ++H5/YWdry6ff32Fy4igw54uo0BC3T7TfD7U7P2rzl6lNya0q+3uRh7vhvfEy/uYZwnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4ZA8OWgwj5vBfXfTEiiu2poxtY0VzIKWAMaeLisH6E=;
 b=o95bq1hH/7Ow/csxOmHTX7YdpdCpMSDalhnJo3Ao8cVHxqc6CNvzeM8j/2mF8Qg+VkibWS9994Js8+olYKgmDwkV6AYMascsLveNQ5I8jFiFNiR3zUY1c1JO676Fu0UZB1NmltcbL5vs7SyypM0Sqxod6Wy95KWJO/T+fcccY7s=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:33 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:33 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 12/16] maple_tree: remove mas_wr_modify()
Date: Fri,  7 Jun 2024 11:52:53 -0700
Message-ID: <20240607185257.963768-13-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 8357b1d3-8502-4778-c28d-08dc8723214f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S1ZcMMYZBxXxDsBUSZufeFZ0uu/r93hhr90liHL5e3Q15kuYEW9kYpB4gLb5?=
 =?us-ascii?Q?1ATBubdUIJ9Vdhw1OssxNZUr1gLuY71go9Eqo8bnXqc36PFVrTtge8stJoLY?=
 =?us-ascii?Q?59hZFG47GhGqon9HGnQdylMvESVso4najS8IQpoXfu+Ypcsd21+3y8XP8+cm?=
 =?us-ascii?Q?0M/MumpgK4+bfmt5JSjZOA1gImBzjEpHaD7VwCcicTxHYHIyZtg/TlEqSWfu?=
 =?us-ascii?Q?yOy/B0I27SQn+EPBn2HI2KeUdImVVWE+NBcd1AFX1F656TV4C4QricsutE+L?=
 =?us-ascii?Q?axwhn11EVCUn525l32JERMCPUmTwJ3Fb2+tvmcdpXXJeXVNKOW1d5tAbmldb?=
 =?us-ascii?Q?eqBqC5wVJIW/KaczkQKgKpqMo5/nbBofOvfe4mecOkfP8uX0XceGO+tUbIdP?=
 =?us-ascii?Q?0Xwa7cgdU5Ymb0Xhzg/nElL78Vs58YRrJ3pmlCLW1B/zVFjfyYxRoN7a6KP4?=
 =?us-ascii?Q?z5/kiVFHHmTF1/lFsiumWW2iwQQt80l5+CsmAiHZnT9j/wq0rNjsZu6P1bYY?=
 =?us-ascii?Q?VUHs+riXYt4nkkUL8iY0rc3m8Lh6lmkBUV4SkM1EboYWHfbSGXWpi+RiG380?=
 =?us-ascii?Q?mDeKA0olGSyuzJJT1oPgDCTpfNdCzIh3GNNV4o5Bg8By7zrW50Q+dOUtjN6H?=
 =?us-ascii?Q?aMp+nnabJFm2qYyyB1L2WcBMOxm3/IFxxlzTgwms2RTSExqlgpBW38C8rxTW?=
 =?us-ascii?Q?uv5tDJSbRJ1P509agQ99/pkeP9ogjKWa3B55pjStYPP50zaFB7tzIxwRoH5y?=
 =?us-ascii?Q?LDIyU07H94DHc4aYNZWin/btnuzrfdWsQrxiDxnNVtFuREnNuJUm/ciF4TT1?=
 =?us-ascii?Q?cxe6MbfUhY5xnePCn9hWI+wYxNc+f6k0CbBKn1toUlF5DCNJRzJRugcmYHHE?=
 =?us-ascii?Q?S+uPHx8NisaNhlNBSeB+xhr/YFRkNGUjPXYPAz/MKZQBU047scwLO4mjJGMt?=
 =?us-ascii?Q?V72fGx1nqkONQKpXm/mynuUHpsciBcrJiJy2ILOgslJcT+tpg78qdxyt9xZf?=
 =?us-ascii?Q?z4rQPd9rI8AiYKLlxWJ93kGtwo+FFdsEvJXn6hdYXJy3ZQLIoNMdnmidsFOZ?=
 =?us-ascii?Q?O0hoMtlqFo+oEGfvisUAUBCXgJp4HeZvJRP1/eLXq2YLbuuAegPDlkxHuo+V?=
 =?us-ascii?Q?tIuQO/1p4umLLgNa1v0Z2L5CzYDV68qBnapPNyDWEuNh+V/FkeFTW89asdvy?=
 =?us-ascii?Q?8MIYaAs22LZPV5VbwA8n8CwMcfa+QP+c9KDmd2GSF4aCxK4Z5UTKXRX195qd?=
 =?us-ascii?Q?RAjr4ifnRk/7XqYhkX+p+XS7g5WXmDhmsqKvf2o4DTuKhcPqar8tzEyvENw9?=
 =?us-ascii?Q?RAA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0GHCaV0GKcQKQ+AQMcUR7t2JZU2LDjMRUXvWQXnMEzxOU8Ah5pGHDAd7KI54?=
 =?us-ascii?Q?AxnG5siY3D9wEUQIpu/9nUC+iR0dmnpEq2pbXi2KIg4DI17h9us9UD3NO+3N?=
 =?us-ascii?Q?Kc2yYGr2XJzKiBItw8vumpnGB+ypzIbocFHH3K8EhBUjaH9P/FAAMcixULBk?=
 =?us-ascii?Q?KfpAOx3m7gR603ishWDaBNXK7Ed0YKFsaCMt1WA36CVooc49nveetY/LFiSP?=
 =?us-ascii?Q?j8Z0WZ1bXPKuKhanAAoIzmUbJkLTs+7+wTl5MKGAMH35HEpHF2xrwff7fV/R?=
 =?us-ascii?Q?nWvmHl7Uv8OYcjXsMUWYV3dtSax7RohkD/TM0gXkV7i2BM82cF3jukT3mfA5?=
 =?us-ascii?Q?PzGxeRS5BVx/SMFz0hQQr4G+H2uvOPzKGE3mgQ1AbEMg6HMgqDlcbWsOa5xr?=
 =?us-ascii?Q?ZUQdRB6MfafsJuPLJQGMNkO+U2TbQ8paP1jgSlWz1KK2tkRSkgjKR9ch/mAO?=
 =?us-ascii?Q?FVExbv8ECUdUWsHweXaBfpPKJB1vqNm2nDMKtCEY1bn8LTz5ZzaHtCEPAqvv?=
 =?us-ascii?Q?aS5UYJa4MRP72cNP0m2cjXmLyUwAUSbeqwzn1rIPr3jpsrjhYG/J3eu9AHsl?=
 =?us-ascii?Q?SGD2Ou5Z6FW5eViZse12bWVJp0yFjyOX7R8VDo8S1zKu7MeWHTMzlSn3ldFa?=
 =?us-ascii?Q?5gMHh3iulvlV1xQyo7r4OstAA3T2PVByzC2bjTJk2j+i5jdKj2U0qE9N6g0p?=
 =?us-ascii?Q?golWfm27wQDuC0DUU9FBvSPGXpN9ytlhsB/IrVjuBKhWFm0qAfn9Ir9vEssT?=
 =?us-ascii?Q?N0Zd5Gqd0XAf4U1wjbIp6/PQn5dQ8mUsuHuyAieJyLjlJ5xrYANVTHY9yC4G?=
 =?us-ascii?Q?Lv/4MhKFZrDm9gPMtIi28e7/0XPx8SOR2o3CbKxGvsHIoSGMp4oEE7ob0T6O?=
 =?us-ascii?Q?UKmrjqXMhtjRgrkuJsi7Dg1Vo9gcF/qyRdZHlKa6VY+sGVJef+gJEcVxE7Yq?=
 =?us-ascii?Q?WuOfWDej39TrLVBc3EHFf9V37/+e/yydsdZHGUG5z1pB8cYPIQovfhBI24Xt?=
 =?us-ascii?Q?KS/n8DkhU+RYgSS0z2OhCrDI1AvibAo1NtULrVl3HWgyUPBAAr2+4FckV4Qv?=
 =?us-ascii?Q?KL+HIXRcLzHUBdTJ5nK+qvwsZbCaRA1tKxn/u/BgF8SSXsyd3WUOt0q5iMqL?=
 =?us-ascii?Q?t59R8QfP275Tac3EkRO05pTS343idCXOy+UxHFiiJ8jaKASTZHsjUmXjGv1c?=
 =?us-ascii?Q?hktf2nWZtoO5MMSBbN/02SleDn8zF3/KiHeCIXOHztSTdtUta4tNL/AfkgKP?=
 =?us-ascii?Q?nWn/j0RC1GpdD8Go3xUgaHx3iWeb2WK2GHMC0/fGxRujbIEwGXEpRePAD4U5?=
 =?us-ascii?Q?jTysdSZS32/GR1m56t788IbsFV5zkKE8YaUH7LZdUmhDIemv7oUmB7hsw+oZ?=
 =?us-ascii?Q?xCksOI3u9EMDzy06OQBFymRjAaEZibkIZtrrjy1gOl2UJE0wEnwye3FAsouF?=
 =?us-ascii?Q?b5/LXaDqyY5VyWSZXPn96xWzDOv34TVEyy0K0MNwyxjb6KpGXU2bNDnJDUzq?=
 =?us-ascii?Q?GozSOJj5nsBtjgE0l5t+OHaA7hGYYme6z4p7ebxD7N/ShLuXHCcmRAf5OhYR?=
 =?us-ascii?Q?bxs7sajiAF0dSOIt4qBiabzGD+zufOLwfmCbu+ThFmOiZG8F341cMTKGy5Pj?=
 =?us-ascii?Q?fPbhdgVL4ORomTyMt4FWxg4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vg+nPWoVa17rbnDt5EZKzd65T1F7L259RQtqzlwyazokdnodVewfyjDJTbgrtSJU2iU/+2ld5A6CfDsBtWIz2grccwyjYLzFksAl7HqDg9v6j/S0MplVuN1iAB3GXMNan0WF55tgcD+0UX/FOiX7hi4VTjewjhDhZ89Jkyj01q0CWJTdWIpJd4zY7CctxGMhCOE7XMCTLMfaT/LWdsMuYYJk4rDnnuFEJobcoFnchMRpEA5Ndr/1tX0h8eQJ8T0p9m9+JsTBU5tCrX/agcaSKvpKt1vQu+vJ208jZax3nu9lLDTJJ+YT08wfmgk8o8Ewx5X1WC2CDYZgRvRRfWKpRzwORK/g8CnkOeqE2+wxk5VdYq3GD99O2N82135nhXrBIHHxaHUN1nx6DfC2oFSc5IKX21FrSC6d7lzg6Er2CEIRqnegz36a9WwNSb6FsRWeUXMNwMk7D31IWktE2gcPD4OKpDPpFI1/ObGdMUPigDVauXXcr8d1MOzAta/gOJUKJqIpgHiAtPA/RmkrnBw8+6XSA3gWQsSLqZtQ44LaRMv3tXd6rNwqgLLoD2jKdU10TuWy2kRYIsukYEpexdhbO3gDIICw0KxVo8Czrm8cYv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8357b1d3-8502-4778-c28d-08dc8723214f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:33.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf80W484NFh7Zus8hD7NT1q8XRVWqSb9HO6XNcZCLKVSHGN02OjxLM9/uLMj0Zxo99oPXJIxb8b3CIduKcGPs65UY4pXzW7XRPcujTAKRJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-GUID: 5BCk5MsOgFS1Liu5RzmPKhdq8kvXqCZ8
X-Proofpoint-ORIG-GUID: 5BCk5MsOgFS1Liu5RzmPKhdq8kvXqCZ8

There are no more users of the function, safely remove it.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 743de734ba0c..8b17768db5f2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4155,44 +4155,6 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 	mas_commit_b_node(wr_mas, &b_node, wr_mas->mas->end);
 }
 
-static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-	unsigned char new_end;
-
-	/* Direct replacement */
-	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
-		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
-		if (!!wr_mas->entry ^ !!wr_mas->content)
-			mas_update_gap(mas);
-		return;
-	}
-
-	/*
-	 * new_end exceeds the size of the maple node and cannot enter the fast
-	 * path.
-	 */
-	new_end = mas_wr_new_end(wr_mas);
-	if (new_end >= mt_slots[wr_mas->type])
-		goto slow_path;
-
-	/* Attempt to append */
-	if (mas_wr_append(wr_mas, new_end))
-		return;
-
-	if (new_end == mas->end && mas_wr_slot_store(wr_mas))
-		return;
-
-	if (mas_wr_node_store(wr_mas, new_end))
-		return;
-
-	if (mas_is_err(mas))
-		return;
-
-slow_path:
-	mas_wr_bnode(wr_mas);
-}
-
 /*
  * mas_wr_store_entry() - Internal call to store a value
  * @mas: The maple state
-- 
2.45.2


