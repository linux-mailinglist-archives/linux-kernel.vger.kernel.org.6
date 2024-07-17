Return-Path: <linux-kernel+bounces-255624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2529342F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B51C2160A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51B618F2F6;
	Wed, 17 Jul 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AlfLpGFu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RbNIVLfl"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4118E775
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246877; cv=fail; b=YvDfhXq5lAXLjFzOxHYvNXBRJ/MqtQM0ZtpP6olbxKHMS9IFX5tV9YD6QeySTvepeKzDtykVTviMwBVgS5i4l47VhhEyJHYc3FM27LJIP2qAg9w+oHszgi51NrKvfJltDlC1Bm7QGLOOUcieu024NqTRJnwwGnyW6UhuwWw7Eh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246877; c=relaxed/simple;
	bh=xJxmN5x115knj8YHBsl8g4MkGD2sqZ/v96rW0dQ1rD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2ZgC1kfzG41g4FwUI728vyk3wpGoR50wEQFDvC+B0u9h13oivI7OsTmkZxnVXBLdJ7WTlT75iHoz/qKe/xpOijjHN8bpay740S6nbbcSbeNI7Bsm2KlmzT+zF5aqa1n2aJKA0awwL0X6wQT8JA5FS1KAB3+3E0dq9L1gQ7T6Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AlfLpGFu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RbNIVLfl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJuBtC031509;
	Wed, 17 Jul 2024 20:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=3Bj8KrJIkrFa0UxRm7NqOhO5QapamAHPGNHPLG+zTDo=; b=
	AlfLpGFuj7ftMkzRgbhvi8lL5wS/JOJ5PpPDMm4fKjOvQl7++v3nL9xkmN9vF6wx
	yvcR13NLAhUMDGwnB0NyahpGuMbbW9cnNXzMGNcCZnQ/OdZ239mB4dtoxQIsKKeS
	NlwfJ/ziBQeNbKW72MWUamFTUA/M1FzG8EXEN5d8yXJsSZfCJtWOQY3uOoyAUn7q
	Nf8jJrErkHfStSV5Om21o6obi6uJBGQ98DGLWNGMa0SKOBfNMrZ3fg2JdqSbz9D/
	48643/+RaBKGHHVJmqqbnT490RZQZ4PhOsJyvTyKD7d2ycmMv2VgZyan5MG6hjIv
	cH1jtL5nSOJ8QzocIN7QMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emhq80r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIn9iR039514;
	Wed, 17 Jul 2024 20:07:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevgj72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtA++rpKwTYlNQtVQRN6wOWsNGGEIhfWnYAU7DNpmD2ZVLyF4/orZ78ftMzQxoNOnAqlnnUpSFUJCarXbZaMbNZo8inDXzEwm5X62xjzqvxyvU4l6sT88cvD867WIisINoZvQTHZeOMisGOG6MhFCsQHAR0qm4KVH0oWT8asnyYJBCg/Efv4dwIRkpnAAY3bDbTBpFuUEsQ9cZQmTubHlK40ZT5gQJQ4sbDpk1mnvKOtBSGkthPC5p2rSB6VFA/Sk9GkIVwcea+yJNWrwGZvFdQWALK8+nOrLkRuuiHmiKVY3+GuXr8fGQVOtGS+Zd29XEo9ockc8wH/zXevzJVqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bj8KrJIkrFa0UxRm7NqOhO5QapamAHPGNHPLG+zTDo=;
 b=Xrvujn+wZSH3jL95JxXKJv9dUBfIeuWlpBgl90woJHGEnf/rVnRHFnVV4F6VrbYBZfPdJe53gjeBqodJMx8G/IfaMCpk9ebuacOAz/gQFstglX2OzG5KPWJYgwI/TQIpNzAmwj5V3FHrMbq3IcIA8h67a9wbLqDl1B04DDqmXggTG/GIQBHaGroom2luV/IjvjhS3hE52Lde5mIzHYu6CDs0QMRG8DusqEBE1B27J6sciJwuyADXPrFzXlPB6PpsT1VJEpEpD8H+meBNOOJlu6lkoA7NYtrhc833vbE2LHrYXsQs9ttRuMrbTZPi4S5XQqpR2RwNKObAQWqW134nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bj8KrJIkrFa0UxRm7NqOhO5QapamAHPGNHPLG+zTDo=;
 b=RbNIVLflJo3qWh0SwBNjXcHX1E633/r3cK3YrpB3qsXssN6VYzkXuRlWI0L6BSh9miskgX4nrZWsx154jZSHOwHLQrp/9ChCsP3IeGzlrADtuJn63iGuYEb3G+RjqNzk8vtuEtDzDPBe83WasCTgHLFnIhfBfPaDrBBgyooc6W8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:07:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:37 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 11/21] mm/mmap: Reposition vma iterator in mmap_region()
Date: Wed, 17 Jul 2024 16:06:59 -0400
Message-ID: <20240717200709.1552558-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b92855-87ee-46d2-6b68-08dca69c1acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?D5Ab+TmP5AjB0RNJEnE/B4aEE7a/AIsdfNZx2Ci+yirYtHcIrbzpzNRfN5tQ?=
 =?us-ascii?Q?JWEH2BmVyXbfi/DUeM0ST2RkpvYFqjao4Nh/z9KWdIGlOxNt1C1So9wMJLG5?=
 =?us-ascii?Q?BuB35xb8wWC4wXL1AbDxdC3u8j56u/M8o5WHCmRzqDtcDK2fLPH/DAFRxrZ3?=
 =?us-ascii?Q?x87WMaxQs9J73eBgB6IP5tJS2+DLDFePhO2x9jfezrrWMKJfh0deR68LQ8y7?=
 =?us-ascii?Q?C2joo49+W7IHvqZNRJjgaKCfAVHfhmq0FxtkK7+AzXctcMftAjMOO9tDgiZB?=
 =?us-ascii?Q?lRBJ0I6CnX5dmhWruPXDWjm95mtQqz0Bzs3SnYTTFMWhHB41vWrqy6MQQAtd?=
 =?us-ascii?Q?2pcDAR6eYk+8+BRsVAJfFQgr7kcWKw41Z/c5Ydep0ME7yZ4Hqka/hVW9Af3Q?=
 =?us-ascii?Q?w8A9H1BYbT+W0ls5srsdRSYEZSvOz3JXmu3i7XKJ1l8mokAxlw5jVpb3ERd2?=
 =?us-ascii?Q?CbLtJoU226acCayJdlOLRZWcKYgkp4WLzjhcn3Nt7x4UmA1Hv24quLR8uToy?=
 =?us-ascii?Q?LudBeSP40rrmGyiHQrudbaElnVMsUl1hGMxO+vzsslOUijEGnD3X+ecJfrPi?=
 =?us-ascii?Q?l7XHKPxIZX3oPsaxw2hcvc6BSCg8KBfIOuPo5xqnDVab0Cd2VQBTps6nMUX/?=
 =?us-ascii?Q?USi3vDkCmFRQBIgr95+wm8Y9nWRREpJsxSd0n3aAs2Jsb2Nt3sYCsLP710C5?=
 =?us-ascii?Q?H8pLk6K5mJley/JPF/2jFU0Jg82N0PcDWvxZroaNOBux6GtV1HpAiMTwIIXG?=
 =?us-ascii?Q?IMx/DHHnuYdAdmBKlEkzpJcQ0lkinSxCqYzf0qPvJp7MWMgFZ9b7yTTRegJG?=
 =?us-ascii?Q?9bHQSgXnnyD8muxwGbtijGNmBqORH9HBa5FKkVb4Y57zGAX/x0+/QhxsupYn?=
 =?us-ascii?Q?vUjZKIuEUykfZ9ivgZn4Zd7FmDKxfzOMxkdo5WNor2uEE6mEOgL5xI05ykhm?=
 =?us-ascii?Q?Mc5otlH4FbUjFuRmoaSYurJIaTkBr/B4QxEGQ1M/SrVChtyZ/FI0mg+ujXV/?=
 =?us-ascii?Q?7W14fi+L06/dajeWppooWzPrAQRH8V4LzdUNIyfYUCGQSygY5SWB+uf5O/lk?=
 =?us-ascii?Q?9tgfC+dggSUR9J787DNjI5a0BCyJzYhf3JVg5e32pvy8r4fdlERcaS3BGSVa?=
 =?us-ascii?Q?5ok/6o4T/coRmkeJEczasilpPWZ1qcn+jsevxW182hMSwFbXwakQPeAj6G/z?=
 =?us-ascii?Q?vH50oN+Y5CRkez88NpFg9zrUo9Wsrs5I2Ra94rqLlMopz9mZR6Al1wRxA4iR?=
 =?us-ascii?Q?ORCWmLtq6ULsHwqkH7t/FiFC+bIh7a3V7xpsjMwckHiC1H7ETj2HqKQgLojR?=
 =?us-ascii?Q?V8M9RV32ik3nZMmuol8zcqvrQi58uTHDdNCJjSn8pjKqOQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j4KMEPnmblXQVNTpBmkw+nm+TK0F42zdB19M2oqaw2Bi5e13eLifRJMRnZBn?=
 =?us-ascii?Q?sVMziuY4KxBTqF8gz48l7BUUKrCsiaK4Zl/EUrlIZBZmk3faOLi5OmRJnLIQ?=
 =?us-ascii?Q?eIuDmDgJ9ui2vVJF8nIxu9XuJHQHjJpjYcVONl/pTCC6FErKN+tnlvisGloW?=
 =?us-ascii?Q?+rgLEwvhl3tPfdjq+3ZOvwAtCaX+lKb5cgzkUCQxOv7PijjghkDWenM+D81/?=
 =?us-ascii?Q?8dcE7gk2qWmxBLkr9u0t9m04Ot5m4LrWY0ytpUrUBMVsPhn8k4VmRynt/ACO?=
 =?us-ascii?Q?ITFdFy8cjhao9wbDRUBWYDPiw9jSFjqzsguL/ZLYU+a6WV9wBzQ5qFel4t11?=
 =?us-ascii?Q?h9oYrTfovADCBDgZyIGL72vsUs+t0ur9icdJ/YjZAQfl6BCyeGinnIeryFre?=
 =?us-ascii?Q?znw9VxWWxXgN+gp+2I6JHKpunBk52O+yqaChge6KeqXFx73rKhHvRJg0Y4S9?=
 =?us-ascii?Q?yd8to8DfMV3tXddm91gM6x2Ime9WDlQS7ToYYIIEBY+C/govjeyzcSuKRc9m?=
 =?us-ascii?Q?Wuf/2jlxj3HSV3+mLo2kGxi/ZSbgI2+RhGMKQ+eUkA+CtyKwB3s5JPJmV7Yn?=
 =?us-ascii?Q?5rDtdx1sEGZMhj7vhnx6D8IH0Qsx8RqqJ17i5ZsmkHoyFi1FmEXGAVPCpqOd?=
 =?us-ascii?Q?9G5RYhrhdyy99WqDWarq4AB8i+xSsuRkC2CSm0gkOkq3LFCjVfoYArB/uy66?=
 =?us-ascii?Q?G6YGECVtviuFjT3z1dibHlWy0lmFBZqPrbpI9a3JcMUVvn3D2RGU1Q223HP9?=
 =?us-ascii?Q?feaSp6zWVWeJLCbp8zHVsNxIoE89vD/3zJ+yA2xHL4rqQP/FPLYuozh/GkbH?=
 =?us-ascii?Q?H5cO5SWyzxW1iIDlrA7YOYm/zKUDpMuNpofGf+Chn5OQ6UqFP1m0iFLNaxyg?=
 =?us-ascii?Q?OKTDaFCmYnsta2aGQcI96ph0XxShcEYwpKtcuG2xyCFbvAdRLR6gRplFv3nZ?=
 =?us-ascii?Q?PKfCkyNDKMqKduXSsrZa8DohVv8wVXd/ONDguewGZmSARBakHlOXZCaq7SAv?=
 =?us-ascii?Q?xAA8mvD86fWAUakCcoB5FBM23wrlbsG8YDBWZFlsgIKoNNlSEDgZAEOcuKWp?=
 =?us-ascii?Q?TuOxoMcMV8dE25KXY1FjexlSZkTWZ9pSx2/eZTMaxI9oFF8d95On9gTrX5cs?=
 =?us-ascii?Q?othxcxYFrYYhY69YA4owENLk5En8doVi/kJJZ2epWWJt/SRsJGKJhQHTkNeM?=
 =?us-ascii?Q?ugLLSs5uKPGgJqnjAlOTdoWmULC6aH0VuLg9FMXyaGZ4woCs7nycoyO93U2p?=
 =?us-ascii?Q?LCiJOdVtV0TTZ06e/3NORixor0/mnBB3cV80dsbFi5A2W/ch7jPSAk5+VXFr?=
 =?us-ascii?Q?jPIdn90Fg5To4222WlO9OMRKAWn1Hr0dNI0ckxOhPdUfXB/p3SggK34j9JHb?=
 =?us-ascii?Q?k6jTx6YNQ2TQX2tObnjKlAgvdfZGxS0VlnFbELfq4Jg4dKPb3wcBakr2Ie0G?=
 =?us-ascii?Q?LaNsw1XxEwSOKJMsiXrl9aIftzzss8Tq7/S9XZwJGGVUqz0P1zSsd2VpUdom?=
 =?us-ascii?Q?oBux23pffkrsKWUn6sU5lZXV2sAmxo8X9WdxcBILv7CyhI2qk5ioBDef2UCK?=
 =?us-ascii?Q?JpJkeUjBKW2K0GMQFwc50fVVuqi0uH3j5wqkYZLcE/ZFPUBx9L3yAH71trMv?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sQFCqefS3syRGKl+6bXWl6OCD/VuV21RJ0m5/k6JxudReUHKDBwI2Qjfgb6TIwdHBezpN1ERKTDBvD9SdAJSbCAfLQ+ZPllb9IodHgSeqR14lEAQZJ5sDV0UwgHq8e+98XX3KzNmexWDi0aRd/V3iYNZ231a7XVpV+PA+4JVn7P2uqK039ydPl7WrjWZtNgzRg7fdT8/L6D281f2F0gvgbkp1ljLh90idH0DNqsBdrau2WfkRIpigQ3vV5WgfdJFqFoyv6md8EbtHMZULEQVF1lmf3nHcX/eMHlUfsoorDw51EAAHfLLE6EyKsqVSPi9TM/ooFV2336x5bFqCaj4AU2LdRFAJVGUt8I9kSTOd9WL6V02g0CIagqIfskipV0Cpq8KiXjrsfIFwHE3YHmyghDptc+S5/u+2vuz2fen+fMN+qSLe5bJm8BwQ09+fr3IjU6YgH3GgFLBeylnSvEdf3wW9c0xCBLZO6/4rx+hFPysDBeTMx0C1hxOAI8DDW6c29dbTcTHyiDsoE5h/F/p5B2TRCB2mZWeIgw0ooH58S2ivDPwhlBwwV0eUTdLgRwhdkX2pt+DX79bdnhb1d4RL0uln8XVb6tHJLrRyxmroP4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b92855-87ee-46d2-6b68-08dca69c1acf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:37.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykEWXC3jiiCmiO7ZOkcCvBBKW0EenzlUZLc/cNt9XNUit25qLDs8KavWyIA/H+wNdJEeUhDkiBO7qhJ30mmbwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170152
X-Proofpoint-GUID: qw8n4dVjJkGOWYA9FfT-AVfppFXzQndA
X-Proofpoint-ORIG-GUID: qw8n4dVjJkGOWYA9FfT-AVfppFXzQndA

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of moving (or leaving) the vma iterator pointing at the previous
vma, leave it pointing at the insert location.  Pointing the vma
iterator at the insert location allows for a cleaner walk of the vma
tree for MAP_FIXED and the no expansion cases.

The vma_prev() call in the case of merging the previous vma is
equivalent to vma_iter_prev_range(), since the vma iterator will be
pointing to the location just before the previous vma.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 722bcced0499..b940de8c6df8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2962,21 +2962,22 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			return -ENOMEM;
+			goto gather_failed;
 
 		/* Remove any existing mappings from the vma tree */
 		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			return -ENOMEM;
+			goto clear_tree_failed;
 
 		/* Unmap any existing mapping in the area */
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
-		vma_prev(&vmi);
 		vma = NULL;
 	} else {
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
+		if (prev)
+			vma_iter_next_range(&vmi);
 	}
 
 	/*
@@ -2989,11 +2990,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -3014,19 +3012,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
+		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
+	if (vma) {
+		/* Actually expand, if possible */
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+			khugepaged_enter_vma(vma, vm_flags);
+			goto expanded;
+		}
+
+		/* If the expand fails, then reposition the vma iterator */
+		if (unlikely(vma == prev))
+			vma_iter_set(&vmi, addr);
 	}
 
-	if (vma == prev)
-		vma_iter_set(&vmi, addr);
 cannot_expand:
 
 	/*
@@ -3187,6 +3187,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_unacct_memory(charged);
 	validate_mm(mm);
 	return error;
+
+clear_tree_failed:
+	abort_munmap_vmas(&mas_detach);
+gather_failed:
+	validate_mm(mm);
+	return -ENOMEM;
 }
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
-- 
2.43.0


