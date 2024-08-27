Return-Path: <linux-kernel+bounces-303807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9087B96154B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18EEB21398
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7321CE703;
	Tue, 27 Aug 2024 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DsyRYqGo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uJ6QKKge"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CE1BFE02
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779069; cv=fail; b=m4tT+1X5vIArVyQl+U5b4Z39h9XkRI9bdOBnOVsCYag6Oysro8mPtuHN1H8vnceLT1aMsKGUDdb/fwS45hTO8SKiErd2Ec5gMkJbcZs+8kV3zY+Yku1Zx55E7rajvmvvOecYY1MgJSEqE/PIKfwysrRpEN8bMhl0ZStmJUInnt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779069; c=relaxed/simple;
	bh=UdDpp1t+TR6zRAsPJ4q7rZ9Z/ErUuyeebuIHhQnoi9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOCB1KpqXGLP3Ce9hFn3F5zNaeKgzf9Ew0lSieJnYvQ9LAC4mIfAH6o+MaK4fLrzDn53zD2ihsm1ZeH1BJlrAhb0THiMILTMRIBc8sBJ8MWqC6BoF7Uj6KLGJzHPizGKLUPm3olN+1nRZccOVSJVEnb3M6Wq3hG7vmnw/ah7x5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DsyRYqGo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uJ6QKKge; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RGiTRd012383;
	Tue, 27 Aug 2024 17:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1JzOPOcQIWMiXrR0IXPSoekk1cUkQlxXayMIVlzK4LQ=; b=
	DsyRYqGoAoTksoQyHdi5syQL14eZ59196LxHB8Cngz9suNzRB7B85FfFpC3lU3zB
	+ZGEIwlq+S8iiG4cee6mleHw9o/aNSqZdm0Sitw+ZtHJjpmV2PVv1uapIsRjWsCS
	s0MFa2wg0uA9CT8qRm72ugG/Cpxoo05HYzgajK+XLskzG7ZMFtDbAW7Bu8QByecF
	HXRe3LJj+rfH6dAuCqSsBf6QczMctoYgBMNIHpxHzlcUwzEJtSgh/hAMR56+8mfp
	tjsuRoNx593coDiTPSZD36VuyWJiECbpQEwin2MspSZdVtBMpUpYI/LiAk92AR6U
	Cx/IfbgJv81koq1XJdGLOg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n465vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 17:15:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RGpiir010650;
	Tue, 27 Aug 2024 17:15:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894n8r6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 17:15:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKBDP/GOAn0fLfO+42T5rg1712Vm6alLFIDpjr69zYAGMmGq5UzT/1JBuodOXDH1pnNY6w3Rd0uAU0ryXzQJ8wvjBUGUL6UsaHYh3p3ZJK2I8oYo4OBMkadyNxeN/PcCeN8thkbxlaRqvCfDvskQOQejKFiFTgveWPDnkxIiHlRJSkMCRjfVD3ccByDp7gc24/3rXsuVj7Gqo27T40ahT6ie2O3EFFbwv6WtErtQXwhXAdApsKkOSyhuDT/oDTssFaG2/jGmat6jRoBYH+ainbHK7GE/OXEYnaqz6suXLvSOIZw3ZF5mBM2ZIG3RuNypZgGMHxolm/PcGALyuv5vAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JzOPOcQIWMiXrR0IXPSoekk1cUkQlxXayMIVlzK4LQ=;
 b=yUbc8P8I/1gpVvh6/Qo+MGWEvfUKWu+DOEJeWtOnhT4jHTAERs2ShGSiHirTG7nCCQAcSjWsmP+/rNOUmxm2RvdAPWEoHPjs7UunFBXfO6HqA9iQlWXVO1RcFAhZrxd+/+gb7Lau/Z6m5O1vVwmb+b8M334tixhTi0DEnRp4qRjjhC8OzzBa+OnZBfBUJdu00WHAuHLNCXqjuuRV8gF1hMLH3+wHozBpBvTpJs1qI70G7jTk6uqskM+LpQhq7IbhzHTx3Ao+P73SSW80mtjRxdjHyVvMa/XKWNqN5MmVH8N7+UilAy6dTIp40ACHp7xoMlUKAyOdQemtMksghdqFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JzOPOcQIWMiXrR0IXPSoekk1cUkQlxXayMIVlzK4LQ=;
 b=uJ6QKKge/NF4qzuEVpvkWr8j82pEQ3YIJQTR37DLw/OdBXSIifL4xJQ0bpQuS3zOKMl5kwCRRhh/H/UQDFNgV6nPiQeOsCqLcgT8Azy6Bj1JafT6f26I8P1/7UZVqepg0GxQ9Z33d6aTpIGE1uMs2fhjWKILLl0Njx+gnEuoV0M=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4782.namprd10.prod.outlook.com (2603:10b6:a03:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Tue, 27 Aug
 2024 17:15:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Tue, 27 Aug 2024
 17:15:53 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] mm/vma: Fix null pointer dereference in vms_abort_munmap_vmas()
Date: Tue, 27 Aug 2024 13:15:49 -0400
Message-ID: <20240827171549.273063-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-16-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-16-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: 299eb8cb-54ec-44fa-c95c-08dcc6bbe82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uNZl5YjP48OQVfgIu4w/RaTEUZfwhXtPW33w699MWXHP85dwtvXQS/+DB36v?=
 =?us-ascii?Q?B6nQPOFY6Nh1QyppYzjRkSFwmaGV2vkUXM5ju/4J4S88ejeUalb4KXy5B6SG?=
 =?us-ascii?Q?S85uV8+MH8KDaN7suT13qhHm8GNCpvsPkbkVMMNmduTEJUCUoFWU801DMPGb?=
 =?us-ascii?Q?2icjanfeaXb7hsQEaXO7JCQ/X5OPL7STHsN2DJcTsO95Phya50WpqbCs1xRp?=
 =?us-ascii?Q?C3FbGFX2y/JMkZ+qh8gGwjyc+YRd9IQGTjeuGh4i43b0X/Wae1WHAekltheU?=
 =?us-ascii?Q?NI5ZaBXyyMRJQP0i7M+NfHxJOJ5NwU29HtjK81J4SMlcJu/P0frYcBwNds/c?=
 =?us-ascii?Q?mssUcaeGFD6AIbM9ADgKYBR9WBWbWa7wCx9Y++ByYwwcVrHOsaEJ6pP3dM5x?=
 =?us-ascii?Q?DCMJaEsBtgIkm/ZgYVLack1S9k32p2ASpRKf4Kh0PDfjnDwjSW5TkGGM7URh?=
 =?us-ascii?Q?jsJgUdePgjfVYul409Kuo/b9IfLSKZYCeapvbSOYVsjs7ThfRKbZqb/tAJPa?=
 =?us-ascii?Q?UdiVcyAKgdZpeJuOEr60BqRBn+BSnhYQZsbH/hnyqMyv+ZxQDhheLCCA2STY?=
 =?us-ascii?Q?fLKaXvjjNA7YHq246QfDy8n/x+F4szL447HdX7Qmn2SD+HTc6OEqhHjOJJWn?=
 =?us-ascii?Q?axVoQpuqb4L27Sx9msvivEpHRkQXpjJUh8WJ4tsBEdIFsxHL2VwBL8W9FRMu?=
 =?us-ascii?Q?+ljM3XkwsEK3V70XjLZzsy0StbxwQcpi/F82XAjeUALJ9a5lTX+XIpF7eg0j?=
 =?us-ascii?Q?V03TdK2YFn6t2+aN783IcopsasPbDlspm7Hhn0tAmd2mRZg7E/peNWIrAv1T?=
 =?us-ascii?Q?BDB0ti1xzW/V6lR/SEKNQ57mcyoQzE/TgxpEhranCUOzqC9Rj8FIbtycekVf?=
 =?us-ascii?Q?tnJg8efV3BaS2tKRdVBep5/m8slZNIL6p8QC+FzAOExohNEQbF1IHfEMweUv?=
 =?us-ascii?Q?u8SI7+8l+25tnnwWv3rDb7CLmHgu0ZPLIs5nqhVQFy9ZpDs5pxW3u4FqXiRm?=
 =?us-ascii?Q?G5ge/hSSwOhFzxB2MscLACjSNjf43bArJcMVdzviHFRNt5kwt/EA28b7Ik5D?=
 =?us-ascii?Q?xtunRagCC9F03yAnr019c5jSp6DlDyi4Ki7sAnaYOpzoSqrSkPL/XtC40EYJ?=
 =?us-ascii?Q?H2fDtX/odK/wJHFres+oSjd5PtUb+ewa5QcEd/gL5H+kjWe18tvijgaBprOG?=
 =?us-ascii?Q?qBWdtQkkIDm7AQzm5Ana88wW0mOc0Y1BbGJ5IKCXxUIomRZRYDFtKCwt9SJf?=
 =?us-ascii?Q?RPRawgQa6g1yFZLXVUXbuWHM235ip3xcv+C/t8HsG2IDC6dfbkMZZrj+kZzr?=
 =?us-ascii?Q?TSQUJZBAGKY30l2n50loNiqqVf6FUEu3fcRoJ9ZNI6BwqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eq28FLjrtrujqmKzO849kmv7HhlTMnjx1yEhC9hqIkPJy/XS6iTIUSX3NrW+?=
 =?us-ascii?Q?KSVUY3FQQMWKnTlc1Rrqg48Bycpv+9yu8sk0l1p2KBxpt25EulrMBV3fwLl7?=
 =?us-ascii?Q?1vG3urYjqfDMmsc93K0n3r3OnJOd6CRnIMGm6UgqAtBSq6N+Q0MlEIgFBuOd?=
 =?us-ascii?Q?TI3oYVS84Nle+kCwfz/bLgM5BVFJQEehCaXxgJl4DHJgowl043Ps17XCsZSz?=
 =?us-ascii?Q?fKhYUjdUsl8Pyx/xX+v3yDI6xLJggA1yaWsEGpI2PnrnszZ7SsMFcYLpUA5/?=
 =?us-ascii?Q?psZ0HhIb2JesI7gP/ngMpSMT8pTKUg1ve3foMBlI2Vxqi0ndJAcL6GhsFZfs?=
 =?us-ascii?Q?SkTVefFSzR40l0ufH3owoMYvjC7CRemEn7J6vZkAmwRNymFjjhEkUgVKodKM?=
 =?us-ascii?Q?VrlmWRTmRBE59T06UErn4bA7qSL8f7646atfzQWXHaOIRIiZu6CG5mdAK6go?=
 =?us-ascii?Q?tvSLZu3SXXQqv50Xp8PaMwAxt0IN9CQyjDVdNATBUCabyOXfeSetozYVsF0m?=
 =?us-ascii?Q?gfByGc+/XmhsNviA9YZnovWDgfUgOmxhGq+EO8pHVp4zg4V2HQpyNOoYCYNQ?=
 =?us-ascii?Q?H7GOqt9ewK8DlBQb6X0yansxt20JmiBcnVxJtvsFrvSpPpAipriFO7v+DoHy?=
 =?us-ascii?Q?UquLguaH6i230LnHg36MmMxSfBEhwfBup+nuBqZ9jWZtQrKIEtrDxJusxkuH?=
 =?us-ascii?Q?U1VwGah00i+/ld9R9nOZc3XC10EiXxHqlmgzoprh+ikIGVo65zTAYSZTlOvd?=
 =?us-ascii?Q?3VHBj2CK0jItiJolV+JLvGcAqnMh4T3LMhk3fxrn685X5QSoY5DG6yh/d/wd?=
 =?us-ascii?Q?/vvZHoNAqq3rXqs2pHMffXnexe+MpeSz7pFUipTUetSh57N1Og6rxE01SoaE?=
 =?us-ascii?Q?TSizHFNc8ySRSyVzoWaYYhP8XZVJtcBsFhe/sBi3aCwbGpCtjLY56u3EgD3A?=
 =?us-ascii?Q?Vq4piTlxETUBjg59psPXhmqIWW4X5MCAneZH/Gp/rALyA5eBqXIrV5Y7Rxn1?=
 =?us-ascii?Q?Hr7nQyzEm6j6zIO8hsl/a4/bQXYGCkfP7YpkHzWJP9dLBl6YVe8uLWhtw/S0?=
 =?us-ascii?Q?SpHMSQqAABnUKmfhQGwcv2RResmj6cQ82D/XJAwkkkIUc8WZ9Kc+t545Js3s?=
 =?us-ascii?Q?XznO09Aji2i77sivsmOCI5Ie7K0PdlZGv9GoKBfiEooNLNiiMGWlVcR+ajjV?=
 =?us-ascii?Q?F7CJbKlfk67CL5qVzlejFj74xSO61TpEXfLSjZwpmXoaDrrFcbj/vGpDyHy/?=
 =?us-ascii?Q?5vSN1Fyy8mXtIiX/oex71i96Fd5BfwkuONYK4pzu3BzpezhzpFOrBXfRGjjF?=
 =?us-ascii?Q?cF+9ba6lqfXW0wksVKsJS63NWLxZ4Umu3l28otHoYyaKNiQYBSNjhNgvJcH/?=
 =?us-ascii?Q?ykmfWePGzjFNlfOIfnkfnqQDUmhVldpAxsI14bpfjAGd2M5O/2TRU0raK9de?=
 =?us-ascii?Q?fosUqhE/fpgOQSDUsJ70s5PuOitG/ybeafShKAv/N2wr+jORxu7SHhaBJCqw?=
 =?us-ascii?Q?nBUXiGDmIXs64//UylN59qD2CpASKnkXaFMVIOzeMJYPFLcW/mm+0tfbPs2R?=
 =?us-ascii?Q?fPp0L2srQXqSWWst3Hkr7hYRr3eHuFDnTsLMbpFJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c07SWp9Z/49NhjeySYeQRhaqHZm89kBhzbeNF6B3aAWUBGA1LwZK0HvezO7pOEyKJ5Xgxw93d0aPiIC+TPjy/Lgpp4SceG0hEOGiQl1qx5iifTAvD/Z2SVYJ6KZhsJb9/77giI/NzJ+v7m6XyD51aDGu5hGfH+D7NcujBFRUNAFBUIfacVF2zvVmXNn8sn3G50HQd3K2NgR9IUiHCblL5rBiYuB9pLgkyck5rJ1VX77lXR50wfH3HumYGC8YrjK1JA4IARewNvBjAapNd1amQiox5Jcbqd2oVTwex9pwunGEOSunsIQhu/Z3Cmp9YG4s2DjXqP9IwqNwfzvI5YU28AMiQxrQ1ZPgomsdWqskS91kOswWc4Op22uHt6+1K8pl8fv4MuZkJvNhBTMcLMdb5UHQcZIRdB92CjL624zlDLedlYIuFRSk6d4sNjbHvP/JJy2cy+vc9M0Ep3n9kY9QbICrOJFvGTLBZovzP80r9bV0VZovamT9vCBjQHM6uc7iR77kBQsIC4nBMifCIS64XDZ8KunoKLZeR/Sod7hqrzNP1NGFJNmynDhUs4DvcPv/wbrtmFHT/a8VIMg0VmS7uR/KIvpA9sseLYR92fjuRsw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299eb8cb-54ec-44fa-c95c-08dcc6bbe82a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:15:53.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8XsRLbkuGHhG1FMlAIbMlznYAg1DNJE8Wagu+kmtUX31ireAbTa/s3gZvYSuOkxhk5ytWPHNxbYe34YPP6gYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270129
X-Proofpoint-GUID: iKFpJCRVF_nUn38Mi9Jh7wqRkr97bBSB
X-Proofpoint-ORIG-GUID: iKFpJCRVF_nUn38Mi9Jh7wqRkr97bBSB

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Don't pass a NULL vma to the vma_iter_store(), instead set up the maple
state for the store and do it manually.  vma_iter_clear() cannot be used
as it needs preallocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 mm/vma.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vma.h b/mm/vma.h
index f710812482a1..5f525d723390 100644

Andrew,

Please squash this into Commit 131e4ef350fa ("mm: change failure of
MAP_FIXED to restoring the gap on failure")

--- a/mm/vma.h
+++ b/mm/vma.h
@@ -173,6 +173,7 @@ static inline void reattach_vmas(struct ma_state *mas_detach)
 static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
+	struct ma_state *mas = &vms->vmi->mas;
 	if (!vms->nr_pages)
 		return;
 
@@ -184,13 +185,14 @@ static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
 	 * not symmetrical and state data has been lost.  Resort to the old
 	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
 	 */
-	if (unlikely(vma_iter_store_gfp(vms->vmi, NULL, GFP_KERNEL))) {
+	mas_set_range(mas, vms->start, vms->end);
+	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
 		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
 			     current->comm, current->pid);
 		/* Leaving vmas detached and in-tree may hamper recovery */
 		reattach_vmas(mas_detach);
 	} else {
-		/* Clean up the insertion of unfortunate the gap */
+		/* Clean up the insertion of the unfortunate gap */
 		vms_complete_munmap_vmas(vms, mas_detach);
 	}
 }
-- 
2.43.0


