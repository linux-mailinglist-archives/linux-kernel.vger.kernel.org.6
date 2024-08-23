Return-Path: <linux-kernel+bounces-299600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755195D760
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E36A1C221F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B132195803;
	Fri, 23 Aug 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lj4lnF3R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M5PWar0k"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3E194139
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443660; cv=fail; b=OXp9y5KlI7L3HcM33cTJqAm1AArYoNdArmsEQ5BOnn2N0WtqQXT1MZpZClLtAj15YoHq8k8038EHpoC/nAbIF74yfdbcr1PbltmV8aNaTxxG8HQ+7CIySW6YsZwnIqpGxZzb9bny1cp6q1vwZfYwZgIsxhEjI9J/eV7nKAMr9d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443660; c=relaxed/simple;
	bh=rqCeALNMmdLdR3nZ4jbpfbpEy1gKnn76I/YSv9Q6NUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iWNQcNcGszmIU4VINnoPg+cXOZg52+/FMeQ48WszdbdhemJtEoIj3IJz4iVQg2zrUvESttBUb8sJto5wUkoqDTJXT18GXc6UGzZbcVhALGb9GUkbsvlPGIxC2YJbA1pyS5nu2mzgizbc9A3kiyIdoAjBrMGKDoXuBGdSPq0kz4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lj4lnF3R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M5PWar0k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0XEK025165;
	Fri, 23 Aug 2024 20:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=UPxqbNoDBYP8B7VVZMhyOT3/5hYZyNmGe2+94P6u69A=; b=
	Lj4lnF3RRXO1ErMBCgFPrcU41k60+gC+xSm8/LmetjLHI/8+R3PeHU0avDBKvH3X
	kUBTenHvLFKLyQen6xbzaRXVYiy3pyTWi+NlIfV9iNedBcJ8pW8My0ab15+m8q50
	E9+9hKdBebtYpCq6DRIUYZFeJo7W8N0UH6n3qvht9ptuVaL7wF+Z0TS7+W4mimb5
	amEcvHvNqaMkvhS0R6UlX8F747M+3DDZOm5annW91qvj3xlC6+iZqus2NczycKd6
	jJSA5M7HbN+KTM6uIzx1vcxPOYk7nFZtY/f0gT8mePE3fnQWrg4VF+YIFr0tXZU2
	XaIukzrF2mGRooHIckR64A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45n6bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdFFd007123;
	Fri, 23 Aug 2024 20:07:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4170s610wk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CB5l0TUi6nzVNfNKD4WzpL8wbcS3znKCbNn1cm1bt62IXNMgbAKr0Gy/Icy8Xh7ZrsJFswoMXfacZ31cr2oqJsWNDWEZI/5pZ4dc0iY8Y7oX11chWOE5orM57KIFZWWTi0TOuKzRlpnyMeD1dT8LHXl1fgg3K0KsC9mgULUuOaxzoBXE4Nl+p+A7aUMuZVWZHsdza/UhIcxmGxWccfnklCebAmnZp3K7jqpkjbueVhTnZJevyREWYdV+LP8k926ybfTp6as1w3XDcNJ31qDvIW8I4omz2Qbgoj0786OSBwjP44g4e1pFChTkgG1OaIZhKtw44ZxNrQ6aqlOXHV+qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPxqbNoDBYP8B7VVZMhyOT3/5hYZyNmGe2+94P6u69A=;
 b=s2vJVSj/OOboQimsHINWFtBh09sPB7uObr2Y+GYLBbnQWHCJn6Q0k/16mH5ovbhj8tJy85ZL5LjsbTVvg5FZ67tu5S0HIL33e0bILIHvSA0kWnWg/m3fMqbXReN2ZnMtndJTlTnEpIdBpxF2IRotE9u3OZgZnbsXa5HWlnnqqJVM1MsTQBsbYMxJAQdZ7QV9rmIXxK7L6DojkLzJeb4NOutOTsBdaJYfyrOhRPRj7bQSrf9Y5GqFnv2heHdhIrE65WrDnwatvptVc97xjhdSOtlZsonFA81SOEHesjlOGCYgd+ypJ6UeLd6Z6Z4iTkuywif4ftAoFxFhr9V5GFfdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPxqbNoDBYP8B7VVZMhyOT3/5hYZyNmGe2+94P6u69A=;
 b=M5PWar0kDc39sF3/N6YYfMpLiKvwRk6LVrkCTo9Of8oScv0m/j4zG4wmDn1mgjree1ZtWH2GjnbHNLBPtXzEPsWbd07OCg6TI9EiD3VxD4ebXVBiNg5mtYGdo7RsoY/S/CnM84Or6Ew5texIk9O09qPvkvOSMYk8HDwk5LPTD2A=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:14 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 02/10] tools: add VMA merge tests
Date: Fri, 23 Aug 2024 21:06:57 +0100
Message-ID: <0ba339d826857ec8d7a37412464d23af84578d38.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 74668c1b-eef4-4298-4f79-08dcc3af2e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x1aAZmFJmfXbCSNxE+h6vB2qm/Zh98B8psOoQang1mVjwZHDlTldtqM8tebu?=
 =?us-ascii?Q?XMfVsIeAHAYPtSeQfH0++LraqSHWaWNqvsK9cNQiBm+vdefrDuvqtzxcxTiR?=
 =?us-ascii?Q?Lbp2GcT0qLI1hinV5nrMwNcqt81w4j5EdePrnNYQMtujyBDX8f15N4bLrY3A?=
 =?us-ascii?Q?svRDuCb6ttPG7pECUofT2jHqGd8i0Jttj6qyVLadGKfbq2GN8I2DPh4aLAOE?=
 =?us-ascii?Q?Des8INtyINyfmmAGW0DYFDszVdIPc3blCwvj78RdotY2H5+rAP7Em++qR69a?=
 =?us-ascii?Q?PtwhKKRwKM5KuAoJBXbf1dxXoBmyg039Xk/c6PlFstMhoqz0SdZedoERMQvM?=
 =?us-ascii?Q?1WfUF5Txch3G6brT0RECK19xBPcsZ0zQ0D9MEIHDeuKm4CCMPD2ef9guvxIh?=
 =?us-ascii?Q?B8SBSp52u/CZe9EXckGVl2KRw8QhI51tPVW31Au1u4sKa4r/xBbXQpGs71tA?=
 =?us-ascii?Q?vWpQRicameuGFSp4SiQhB64YC62mIjtBGjpCyyWI2eHCtn7oHf0OlyU0eMVj?=
 =?us-ascii?Q?aX5LaroTS1OQ2fOf9Ma+MYgWUpJr1oAQaSeaqf4/Dmr7xVDvPiLqrR35FmM7?=
 =?us-ascii?Q?sr8Hwsy1Be3MYyK1bl706r4Klj0X3tU6+3EMj1f+oFlca2d4s02TfTq3UC78?=
 =?us-ascii?Q?7eSMKUbv6p5CmnizmfqNyM3JE+N/FheRZ8xPFU1eDnj10KcdyV7SY8bXiTXU?=
 =?us-ascii?Q?Sl/OYLF6aeFwlK9Tpe0JknaG7V4KiZr6zmYKnqn3X/20qsriGUDD7E3Q9mt2?=
 =?us-ascii?Q?aYje9vzpoD0t1l8zmX/Tx5fcmaIGx6BXzR8Pwmu6y57dHrWAUvSijpO1YgiY?=
 =?us-ascii?Q?/2eJf7c/4nQDpOBV5+qF0OSrqK8/q/w0wSeeO1YBcAeZ4y3lsjyrNgfV7S4p?=
 =?us-ascii?Q?qMDEdj8vBnuaH8pIYzA8xzxJkd4+g2gX6hRyiq8UIRBgrD1hUhsvP1E1pldu?=
 =?us-ascii?Q?piSJHdFlzZF34+k/+0a3dnJUpdgcSnWCzLusFGCWDfumr5eb6UyxCWuf7oLE?=
 =?us-ascii?Q?S2AhOPq2hprE+/TI/J/colTbc0erUZ/j/d6p/8FIpSQoTB41iiNQYL/JNml7?=
 =?us-ascii?Q?qXkYVQhCvOG63+NBqeazYlBXcz4aGgYY2g4i9YX1kI6YGfdiJCTjuiZ1D9Jp?=
 =?us-ascii?Q?BnBHVF5VCRc1P7oNLy6rW1GB0HyPDoVjVcOEk573DWuxIdHuUOCrSWCPEPL5?=
 =?us-ascii?Q?VGRuuObVIHOHXPneLiSUtd97vA11xUuwUly5sxg0AODPU23mGneKAQiucRQ9?=
 =?us-ascii?Q?ScYNOawLapi9HX2zKKJTrm0608grN48BgR0zlHWMGI+a0lvixsDgk0E7C6jt?=
 =?us-ascii?Q?uYP5HTNYjk1I9ZSV/OQ4G3ucd49tnBrFPN1RxlxbtihjNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I2M24vtyT7ZPHBsvPjJDZLXYIpEHAeqqEHg+3g/OtH3r/c1ALxAsc8NN4vxW?=
 =?us-ascii?Q?6dFewNtYwLe1UMN87Oab9Zhycy0gQjFO3Mk+MXzxoVS3W9Fu1tqtRvkDFBfr?=
 =?us-ascii?Q?+xlyOgFTI1gvdrszWuwscqVQfXVYj4iXpNbWMOIu/LqTqjHIfbE3q6TdTAIL?=
 =?us-ascii?Q?lugboJ1HLC3Q2uchy4z35n8zeNGvJIoG40W2c0IHKyO4zBCK69Kj1L6pFlBW?=
 =?us-ascii?Q?df4LXypDAwB4mktX5Wu3bh9Zg11yGzrnb/0Wu6g/MD2k6InYPGFaEzBPsaFT?=
 =?us-ascii?Q?QdVx6GrnoXaVi9kk6JvjpGrKLQi5gtgOEE3kVLAzQ9gmFZvsn4ylPwx7/1XL?=
 =?us-ascii?Q?WhTT4TMFaTUxkFM4avioNzQE1D/0OUQwTICOCtu/zssCpvNXyTZpGhgrF3hY?=
 =?us-ascii?Q?1Ti0ppZkzlTMr54kqnUBgMir50LSi6271QdUCkytJf8EE6rRflRfnYseCfkE?=
 =?us-ascii?Q?u6AuRCTIfXI6GG46EsURpHBBgewRCPMn497VL1i2x3OsmmPEt6v2cOYmIkSz?=
 =?us-ascii?Q?e7B2Imjib4b2X+LKX93gPyvF9qEkVp72h4RdolL1HoN84lnAgd/fRAYGxw1w?=
 =?us-ascii?Q?ZP6cU4Y29pZ7OCEHheeY1iqjvNuj7QA6GJUlJUfFjoQcB9M2+4uc0/P9KVMK?=
 =?us-ascii?Q?0TW01kCYGq1O+iPHGeS7K96lKMaMTSY/ugokzCdaRFQtqrEY0hOrrh+Tz1NS?=
 =?us-ascii?Q?WKJqjL/rWunmFGJK4XMr+RPHg6A8m44l7axYvCfRpSJGA1PykxtVqbovluL5?=
 =?us-ascii?Q?8Wn+P1WnJzaiIQ0G/zxQ5JYGZshFRrln6n8QNPKBArOv+cvtEUKgGYYtFenJ?=
 =?us-ascii?Q?K+6wzK4wIYEDXQEzPo5JJzOrIb6XHY/ccbc+Eq2NLtj133riIr3ZfMgFl0Or?=
 =?us-ascii?Q?TXspfPIuUont5aUZibMqbPQGaXDdzUsa6edJXrt/Yy2J+4pkY9iAR48Tya6l?=
 =?us-ascii?Q?7To0Ou+KAPqRUMKH9KbRI2ohx86diAgt8DR1B2Is6fJyO2A8nJl4eyL363p9?=
 =?us-ascii?Q?lCoROfSkdWlkehxfD3EL/8aZaPvECr3zbt525PduA2UVdWyi9pX70jLqRxEL?=
 =?us-ascii?Q?OWV/XVHRKO+ntf7qv/gc72Wb+OLI84sxDEGF3uj5HxI0MKn9yoLzVcUJOvh7?=
 =?us-ascii?Q?9J4MdUxu6usWW4x2yaM2NpMQqbG2Y7US83iFWaPKKpSdP7ziY954LrZb4DgS?=
 =?us-ascii?Q?9EnjOuLAqsDgSJgTLCNmsojjTyrpPhoFVOLIVRu1fVp5looF1dulue9PSvhW?=
 =?us-ascii?Q?QidH+izJ5ZZrwsoENXJKPpnl7xZmmSzNKQu9paTxy2CowBT8uxRIGxRVZM7E?=
 =?us-ascii?Q?g+JbBxIRdW5eKl+HuaZrdpLZDtDvjki1VzSDbD3tnoVDkfMc12x/vDggvqCT?=
 =?us-ascii?Q?UwrqX2Qb5sLl2PHVJM0SJnZQg/Zcz+aNCxOIkB9g1DkSueMoKXHGFKZRod1w?=
 =?us-ascii?Q?GWr8Z6n9PgvUYEXlkxhI0mYxnlQjA+JM4y7HHH343xmQgwGw0WKuzg1Zt7D8?=
 =?us-ascii?Q?7aLl00wLqwS9Rx9fWPlg8q5WLf9la2X2aAYlg5cNd+hLpGowdetKqHNZz9sR?=
 =?us-ascii?Q?QQ9Dp4HCoHHQmDgIRysC3/xS8Csjyj2vUr4Q+jWsJr4CoYUTzM37OzjTIVTG?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CZOCidT1nra/80217vKOTFW2a4wxcVwi5Fm58MbbRpHkOFNc4IpaAc2D1XOyo8cAIJxdYWny7aSqeXIBw51xDyU4k5nbASdXI+Z3gMZbvmekMNBabGj+3CuM/+5gdy4cHodCz7nRIYzxGH3EKyTw+Nd1ScievDcHyFZBbX53vg9I15JbfblFKjsuyWrXBqZeazV6oWXCwbzusqe3r9nb/sakUgVFZwUS0emxjdphg1V8VmBVYk0Lhn4n1XMYJJSSg1IPCZtreOBi6OaM68tGbrNqWIWN1XZkYAP64ZgEJ+aVsiHXmQYFDQlpkrYNR4KyCNoE1iOqSBLgIntFCi/x8ZMPucbU8keg4+Y8McTOCFmBq0FaJ9Fl04gS9mBy0HGFyVptwbpKZLkq607svVrp8wZzHqsRaE02C4iCN9QRJlXvpXBaHQemAvU6gL2QOqm5cxmh+tzaBnw83seKMYKDBK31oCmGJkfiTw2ozue0KgqPCA1lwGp/Yvdm1Q0cmLFfUISKTZIvsvxM02Hza7vwDGmYBYook+5VRXJ2P3KvwPtdWRx/IYQiz6XdeOP43u/wAs/ej0/e5G3av+gkIF3zT3lVVO4yCpl8mWmT3wXniQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74668c1b-eef4-4298-4f79-08dcc3af2e19
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:14.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf5ChWfGjlh/SjNTMNyV30Gmqs6r7b7uTnBTtN76DHaKJzwAG0gQmSCQCMu5ILdkvfOmOsIF3J+u2ad62Y77uxiNjSH6ph61Rv8xrY/Amik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: _XzE_fJCueE1U9GG637N4dIcIRxX6VG8
X-Proofpoint-GUID: _XzE_fJCueE1U9GG637N4dIcIRxX6VG8

Add a variety of VMA merge unit tests to assert that the behaviour of VMA
merge is correct at an abstract level and VMAs are merged or not merged as
expected.

These are intentionally added _before_ we start refactoring vma_merge() in
order that we can continually assert correctness throughout the rest of the
series.

In order to reduce churn going forward, we backport the vma_merge_struct
data type to the test code which we introduce and use in a future commit,
and add wrappers around the merge new and existing VMA cases.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma.c          | 1218 +++++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h |   45 +-
 2 files changed, 1253 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 48e033c60d87..9b272633ca9e 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -7,13 +7,43 @@
 #include "maple-shared.h"
 #include "vma_internal.h"
 
+/* Include so header guard set. */
+#include "../../../mm/vma.h"
+
+static bool fail_prealloc;
+
+/* Then override vma_iter_prealloc() so we can choose to fail it. */
+#define vma_iter_prealloc(vmi, vma)					\
+	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
+
 /*
  * Directly import the VMA implementation here. Our vma_internal.h wrapper
  * provides userland-equivalent functionality for everything vma.c uses.
  */
 #include "../../../mm/vma.c"
 
+/*
+ * Temporarily forward-ported from a future in which vmg's are used for merging.
+ */
+struct vma_merge_struct {
+	struct mm_struct *mm;
+	struct vma_iterator *vmi;
+	pgoff_t pgoff;
+	struct vm_area_struct *prev;
+	struct vm_area_struct *next; /* Modified by vma_merge(). */
+	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
+	unsigned long start;
+	unsigned long end;
+	unsigned long flags;
+	struct file *file;
+	struct anon_vma *anon_vma;
+	struct mempolicy *policy;
+	struct vm_userfaultfd_ctx uffd_ctx;
+	struct anon_vma_name *anon_name;
+};
+
 const struct vm_operations_struct vma_dummy_vm_ops;
+static struct anon_vma dummy_anon_vma;
 
 #define ASSERT_TRUE(_expr)						\
 	do {								\
@@ -28,6 +58,14 @@ const struct vm_operations_struct vma_dummy_vm_ops;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+static struct task_struct __current;
+
+struct task_struct *get_current(void)
+{
+	return &__current;
+}
+
+/* Helper function to simply allocate a VMA. */
 static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 					unsigned long start,
 					unsigned long end,
@@ -47,22 +85,201 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 	return ret;
 }
 
+/* Helper function to allocate a VMA and link it to the tree. */
+static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
+						 unsigned long start,
+						 unsigned long end,
+						 pgoff_t pgoff,
+						 vm_flags_t flags)
+{
+	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, flags);
+
+	if (vma == NULL)
+		return NULL;
+
+	if (vma_link(mm, vma)) {
+		vm_area_free(vma);
+		return NULL;
+	}
+
+	/*
+	 * Reset this counter which we use to track whether writes have
+	 * begun. Linking to the tree will have caused this to be incremented,
+	 * which means we will get a false positive otherwise.
+	 */
+	vma->vm_lock_seq = -1;
+
+	return vma;
+}
+
+/* Helper function which provides a wrapper around a merge new VMA operation. */
+static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
+{
+	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
+	struct vm_area_struct dummy = {
+		.vm_mm = vmg->mm,
+		.vm_flags = vmg->flags,
+		.anon_vma = vmg->anon_vma,
+		.vm_file = vmg->file,
+	};
+
+	/*
+	 * For convenience, get prev and next VMAs. Which the new VMA operation
+	 * requires.
+	 */
+	vmg->next = vma_next(vmg->vmi);
+	vmg->prev = vma_prev(vmg->vmi);
+
+	vma_iter_set(vmg->vmi, vmg->start);
+	return vma_merge_new_vma(vmg->vmi, vmg->prev, &dummy, vmg->start,
+				 vmg->end, vmg->pgoff);
+}
+
+/*
+ * Helper function which provides a wrapper around a merge existing VMA
+ * operation.
+ */
+static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
+{
+	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
+	struct vm_area_struct dummy = {
+		.vm_mm = vmg->mm,
+		.vm_flags = vmg->flags,
+		.anon_vma = vmg->anon_vma,
+		.vm_file = vmg->file,
+	};
+
+	return vma_merge(vmg->vmi, vmg->prev, &dummy, vmg->start, vmg->end,
+			 vmg->flags, vmg->pgoff, vmg->policy, vmg->uffd_ctx,
+			 vmg->anon_name);
+}
+
+/*
+ * Helper function which provides a wrapper around the expansion of an existing
+ * VMA.
+ */
+static int expand_existing(struct vma_merge_struct *vmg)
+{
+	return vma_expand(vmg->vmi, vmg->vma, vmg->start, vmg->end, vmg->pgoff,
+			  vmg->next);
+}
+
+/*
+ * Helper function to reset merge state the associated VMA iterator to a
+ * specified new range.
+ */
+static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
+			  unsigned long end, pgoff_t pgoff, vm_flags_t flags)
+{
+	vma_iter_set(vmg->vmi, start);
+
+	vmg->prev = NULL;
+	vmg->next = NULL;
+	vmg->vma = NULL;
+
+	vmg->start = start;
+	vmg->end = end;
+	vmg->pgoff = pgoff;
+	vmg->flags = flags;
+}
+
+/*
+ * Helper function to try to merge a new VMA.
+ *
+ * Update vmg and the iterator for it and try to merge, otherwise allocate a new
+ * VMA, link it to the maple tree and return it.
+ */
+static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
+						struct vma_merge_struct *vmg,
+						unsigned long start, unsigned long end,
+						pgoff_t pgoff, vm_flags_t flags,
+						bool *was_merged)
+{
+	struct vm_area_struct *merged;
+
+	vmg_set_range(vmg, start, end, pgoff, flags);
+
+	merged = merge_new(vmg);
+	if (merged) {
+		*was_merged = true;
+		return merged;
+	}
+
+	*was_merged = false;
+	return alloc_and_link_vma(mm, start, end, pgoff, flags);
+}
+
+/*
+ * Helper function to reset the dummy anon_vma to indicate it has not been
+ * duplicated.
+ */
+static void reset_dummy_anon_vma(void)
+{
+	dummy_anon_vma.was_cloned = false;
+	dummy_anon_vma.was_unlinked = false;
+}
+
+/*
+ * Helper function to remove all VMAs and destroy the maple tree associated with
+ * a virtual address space. Returns a count of VMAs in the tree.
+ */
+static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
+{
+	struct vm_area_struct *vma;
+	int count = 0;
+
+	fail_prealloc = false;
+	reset_dummy_anon_vma();
+
+	vma_iter_set(vmi, 0);
+	for_each_vma(*vmi, vma) {
+		vm_area_free(vma);
+		count++;
+	}
+
+	mtree_destroy(&mm->mm_mt);
+	mm->map_count = 0;
+	return count;
+}
+
+/* Helper function to determine if VMA has had vma_start_write() performed. */
+static bool vma_write_started(struct vm_area_struct *vma)
+{
+	int seq = vma->vm_lock_seq;
+
+	/* We reset after each check. */
+	vma->vm_lock_seq = -1;
+
+	/* The vma_start_write() stub simply increments this value. */
+	return seq > -1;
+}
+
+/* Helper function providing a dummy vm_ops->close() method.*/
+static void dummy_close(struct vm_area_struct *)
+{
+}
+
 static bool test_simple_merge(void)
 {
 	struct vm_area_struct *vma;
 	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
-	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
 	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
 	VMA_ITERATOR(vmi, &mm, 0x1000);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+		.start = 0x1000,
+		.end = 0x2000,
+		.flags = flags,
+		.pgoff = 1,
+	};
 
 	ASSERT_FALSE(vma_link(&mm, vma_left));
-	ASSERT_FALSE(vma_link(&mm, vma_middle));
 	ASSERT_FALSE(vma_link(&mm, vma_right));
 
-	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
-				0x2000, 1);
+	vma = merge_new(&vmg);
 	ASSERT_NE(vma, NULL);
 
 	ASSERT_EQ(vma->vm_start, 0);
@@ -142,10 +359,17 @@ static bool test_simple_expand(void)
 	struct mm_struct mm = {};
 	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
 	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+		.vma = vma,
+		.start = 0,
+		.end = 0x3000,
+		.pgoff = 0,
+	};
 
 	ASSERT_FALSE(vma_link(&mm, vma));
 
-	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
+	ASSERT_FALSE(expand_existing(&vmg));
 
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x3000);
@@ -178,6 +402,980 @@ static bool test_simple_shrink(void)
 	return true;
 }
 
+static bool test_merge_new(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain_a = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain_b = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain_c = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain_d = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	int count;
+	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
+	bool merged;
+
+	/*
+	 * 0123456789abc
+	 * AA B       CC
+	 */
+	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
+	ASSERT_NE(vma_a, NULL);
+	/* We give each VMA a single avc so we can test anon_vma duplication. */
+	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
+
+	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
+	ASSERT_NE(vma_b, NULL);
+	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
+
+	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, flags);
+	ASSERT_NE(vma_c, NULL);
+	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
+
+	/*
+	 * NO merge.
+	 *
+	 * 0123456789abc
+	 * AA B   **  CC
+	 */
+	vma_d = try_merge_new_vma(&mm, &vmg, 0x7000, 0x9000, 7, flags, &merged);
+	ASSERT_NE(vma_d, NULL);
+	INIT_LIST_HEAD(&vma_d->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain_d.same_vma, &vma_d->anon_vma_chain);
+	ASSERT_FALSE(merged);
+	ASSERT_EQ(mm.map_count, 4);
+
+	/*
+	 * Merge BOTH sides.
+	 *
+	 * 0123456789abc
+	 * AA*B   DD  CC
+	 */
+	vma_b->anon_vma = &dummy_anon_vma;
+	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
+	ASSERT_EQ(vma, vma_a);
+	/* Merge with A, delete B. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x4000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 3);
+
+	/*
+	 * Merge to PREVIOUS VMA.
+	 *
+	 * 0123456789abc
+	 * AAAA*  DD  CC
+	 */
+	vma = try_merge_new_vma(&mm, &vmg, 0x4000, 0x5000, 4, flags, &merged);
+	ASSERT_EQ(vma, vma_a);
+	/* Extend A. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x5000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 3);
+
+	/*
+	 * Merge to NEXT VMA.
+	 *
+	 * 0123456789abc
+	 * AAAAA *DD  CC
+	 */
+	vma_d->anon_vma = &dummy_anon_vma;
+	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
+	ASSERT_EQ(vma, vma_d);
+	/* Prepend. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0x6000);
+	ASSERT_EQ(vma->vm_end, 0x9000);
+	ASSERT_EQ(vma->vm_pgoff, 6);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 3);
+
+	/*
+	 * Merge BOTH sides.
+	 *
+	 * 0123456789abc
+	 * AAAAA*DDD  CC
+	 */
+	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
+	ASSERT_EQ(vma, vma_a);
+	/* Merge with A, delete D. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x9000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 2);
+
+	/*
+	 * Merge to NEXT VMA.
+	 *
+	 * 0123456789abc
+	 * AAAAAAAAA *CC
+	 */
+	vma_c->anon_vma = &dummy_anon_vma;
+	vma = try_merge_new_vma(&mm, &vmg, 0xa000, 0xb000, 0xa, flags, &merged);
+	ASSERT_EQ(vma, vma_c);
+	/* Prepend C. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0xa000);
+	ASSERT_EQ(vma->vm_end, 0xc000);
+	ASSERT_EQ(vma->vm_pgoff, 0xa);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 2);
+
+	/*
+	 * Merge BOTH sides.
+	 *
+	 * 0123456789abc
+	 * AAAAAAAAA*CCC
+	 */
+	vma = try_merge_new_vma(&mm, &vmg, 0x9000, 0xa000, 0x9, flags, &merged);
+	ASSERT_EQ(vma, vma_a);
+	/* Extend A and delete C. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0xc000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 1);
+
+	/*
+	 * Final state.
+	 *
+	 * 0123456789abc
+	 * AAAAAAAAAAAAA
+	 */
+
+	count = 0;
+	vma_iter_set(&vmi, 0);
+	for_each_vma(vmi, vma) {
+		ASSERT_NE(vma, NULL);
+		ASSERT_EQ(vma->vm_start, 0);
+		ASSERT_EQ(vma->vm_end, 0xc000);
+		ASSERT_EQ(vma->vm_pgoff, 0);
+		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+
+		vm_area_free(vma);
+		count++;
+	}
+
+	/* Should only have one VMA left (though freed) after all is done.*/
+	ASSERT_EQ(count, 1);
+
+	mtree_destroy(&mm.mm_mt);
+	return true;
+}
+
+static bool test_vma_merge_special_flags(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	vm_flags_t special_flags[] = { VM_IO, VM_DONTEXPAND, VM_PFNMAP, VM_MIXEDMAP };
+	vm_flags_t all_special_flags = 0;
+	int i;
+	struct vm_area_struct *vma_left, *vma;
+
+	/* Make sure there aren't new VM_SPECIAL flags. */
+	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
+		all_special_flags |= special_flags[i];
+	}
+	ASSERT_EQ(all_special_flags, VM_SPECIAL);
+
+	/*
+	 * 01234
+	 * AAA
+	 */
+	vma_left = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	ASSERT_NE(vma_left, NULL);
+
+	/* 1. Set up new VMA with special flag that would otherwise merge. */
+
+	/*
+	 * 01234
+	 * AAA*
+	 *
+	 * This should merge if not for the VM_SPECIAL flag.
+	 */
+	vmg_set_range(&vmg, 0x3000, 0x4000, 3, flags);
+	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
+		vm_flags_t special_flag = special_flags[i];
+
+		vma_left->__vm_flags = flags | special_flag;
+		vmg.flags = flags | special_flag;
+		vma = merge_new(&vmg);
+		ASSERT_EQ(vma, NULL);
+	}
+
+	/* 2. Modify VMA with special flag that would otherwise merge. */
+
+	/*
+	 * 01234
+	 * AAAB
+	 *
+	 * Create a VMA to modify.
+	 */
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
+	ASSERT_NE(vma, NULL);
+	vmg.vma = vma;
+
+	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
+		vm_flags_t special_flag = special_flags[i];
+
+		vma_left->__vm_flags = flags | special_flag;
+		vmg.flags = flags | special_flag;
+		vma = merge_existing(&vmg);
+		ASSERT_EQ(vma, NULL);
+	}
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_vma_merge_with_close(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
+	struct vm_area_struct *vma_next =
+		alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, flags);
+	struct vm_area_struct *vma;
+
+	/*
+	 * When we merge VMAs we sometimes have to delete others as part of the
+	 * operation.
+	 *
+	 * Considering the two possible adjacent VMAs to which a VMA can be
+	 * merged:
+	 *
+	 * [ prev ][ vma ][ next ]
+	 *
+	 * In no case will we need to delete prev. If the operation is
+	 * mergeable, then prev will be extended with one or both of vma and
+	 * next deleted.
+	 *
+	 * As a result, during initial mergeability checks, only
+	 * can_vma_merge_before() (which implies the VMA being merged with is
+	 * 'next' as shown above) bothers to check to see whether the next VMA
+	 * has a vm_ops->close() callback that will need to be called when
+	 * removed.
+	 *
+	 * If it does, then we cannot merge as the resources that the close()
+	 * operation potentially clears down are tied only to the existing VMA
+	 * range and we have no way of extending those to the nearly merged one.
+	 *
+	 * We must consider two scenarios:
+	 *
+	 * A.
+	 *
+	 * vm_ops->close:     -       -    !NULL
+	 *                 [ prev ][ vma ][ next ]
+	 *
+	 * Where prev may or may not be present/mergeable.
+	 *
+	 * This is picked up by a specific check in can_vma_merge_before().
+	 *
+	 * B.
+	 *
+	 * vm_ops->close:     -     !NULL
+	 *                 [ prev ][ vma ]
+	 *
+	 * Where prev and vma are present and mergeable.
+	 *
+	 * This is picked up by a specific check in the modified VMA merge.
+	 *
+	 * IMPORTANT NOTE: We make the assumption that the following case:
+	 *
+	 *    -     !NULL   NULL
+	 * [ prev ][ vma ][ next ]
+	 *
+	 * Cannot occur, because vma->vm_ops being the same implies the same
+	 * vma->vm_file, and therefore this would mean that next->vm_ops->close
+	 * would be set too, and thus scenario A would pick this up.
+	 */
+
+	ASSERT_NE(vma_next, NULL);
+
+	/*
+	 * SCENARIO A
+	 *
+	 * 0123
+	 *  *N
+	 */
+
+	/* Make the next VMA have a close() callback. */
+	vma_next->vm_ops = &vm_ops;
+
+	/* Our proposed VMA has characteristics that would otherwise be merged. */
+	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+
+	/* The next VMA having a close() operator should cause the merge to fail.*/
+	ASSERT_EQ(merge_new(&vmg), NULL);
+
+	/* Now create the VMA so we can merge via modified flags */
+	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, flags);
+	vmg.vma = vma;
+
+	/*
+	 * The VMA being modified in a way that would otherwise merge should
+	 * also fail.
+	 */
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	/* SCENARIO B
+	 *
+	 * 0123
+	 * P*
+	 *
+	 * In order for this scenario to trigger, the VMA currently being
+	 * modified must also have a .close().
+	 */
+
+	/* Reset VMG state. */
+	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+	/*
+	 * Make next unmergeable, and don't let the scenario A check pick this
+	 * up, we want to reproduce scenario B only.
+	 */
+	vma_next->vm_ops = NULL;
+	vma_next->__vm_flags &= ~VM_MAYWRITE;
+	/* Allocate prev. */
+	vmg.prev = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
+	/* Assign a vm_ops->close() function to VMA explicitly. */
+	vma->vm_ops = &vm_ops;
+	vmg.vma = vma;
+	/* Make sure merge does not occur. */
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_vma_merge_new_with_close(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	struct vm_area_struct *vma_prev = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
+	struct vm_area_struct *vma_next = alloc_and_link_vma(&mm, 0x5000, 0x7000, 5, flags);
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
+	struct vm_area_struct *vma;
+
+	/*
+	 * We should allow the partial merge of a proposed new VMA if the
+	 * surrounding VMAs have vm_ops->close() hooks (but are otherwise
+	 * compatible), e.g.:
+	 *
+	 *        New VMA
+	 *    A  v-------v  B
+	 * |-----|       |-----|
+	 *  close         close
+	 *
+	 * Since the rule is to not DELETE a VMA with a close operation, this
+	 * should be permitted, only rather than expanding A and deleting B, we
+	 * should simply expand A and leave B intact, e.g.:
+	 *
+	 *        New VMA
+	 *       A          B
+	 * |------------||-----|
+	 *  close         close
+	 */
+
+	/* Have prev and next have a vm_ops->close() hook. */
+	vma_prev->vm_ops = &vm_ops;
+	vma_next->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x2000, 0x5000, 2, flags);
+	vma = merge_new(&vmg);
+	ASSERT_NE(vma, NULL);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x5000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->vm_ops, &vm_ops);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 2);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_merge_existing(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_prev, *vma_next;
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+
+	/*
+	 * Merge right case - partial span.
+	 *
+	 *    <->
+	 * 0123456789
+	 *   VVVVNNN
+	 *            ->
+	 * 0123456789
+	 *   VNNNNNN
+	 */
+	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
+	vmg.vma = vma;
+	vmg.prev = vma;
+	vma->anon_vma = &dummy_anon_vma;
+	ASSERT_EQ(merge_existing(&vmg), vma_next);
+	ASSERT_EQ(vma_next->vm_start, 0x3000);
+	ASSERT_EQ(vma_next->vm_end, 0x9000);
+	ASSERT_EQ(vma_next->vm_pgoff, 3);
+	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma->vm_start, 0x2000);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 2);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_TRUE(vma_write_started(vma_next));
+	ASSERT_EQ(mm.map_count, 2);
+
+	/* Clear down and reset. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Merge right case - full span.
+	 *
+	 *   <-->
+	 * 0123456789
+	 *   VVVVNNN
+	 *            ->
+	 * 0123456789
+	 *   NNNNNNN
+	 */
+	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
+	vmg.vma = vma;
+	vma->anon_vma = &dummy_anon_vma;
+	ASSERT_EQ(merge_existing(&vmg), vma_next);
+	ASSERT_EQ(vma_next->vm_start, 0x2000);
+	ASSERT_EQ(vma_next->vm_end, 0x9000);
+	ASSERT_EQ(vma_next->vm_pgoff, 2);
+	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma_next));
+	ASSERT_EQ(mm.map_count, 1);
+
+	/* Clear down and reset. We should have deleted vma. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
+
+	/*
+	 * Merge left case - partial span.
+	 *
+	 *    <->
+	 * 0123456789
+	 * PPPVVVV
+	 *            ->
+	 * 0123456789
+	 * PPPPPPV
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+	vma->anon_vma = &dummy_anon_vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x6000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma->vm_start, 0x6000);
+	ASSERT_EQ(vma->vm_end, 0x7000);
+	ASSERT_EQ(vma->vm_pgoff, 6);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 2);
+
+	/* Clear down and reset. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Merge left case - full span.
+	 *
+	 *    <-->
+	 * 0123456789
+	 * PPPVVVV
+	 *            ->
+	 * 0123456789
+	 * PPPPPPP
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+	vma->anon_vma = &dummy_anon_vma;
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x7000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_EQ(mm.map_count, 1);
+
+	/* Clear down and reset. We should have deleted vma. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
+
+	/*
+	 * Merge both case.
+	 *
+	 *    <-->
+	 * 0123456789
+	 * PPPVVVVNNN
+	 *             ->
+	 * 0123456789
+	 * PPPPPPPPPP
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
+	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+	vma->anon_vma = &dummy_anon_vma;
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x9000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_EQ(mm.map_count, 1);
+
+	/* Clear down and reset. We should have deleted prev and next. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
+
+	/*
+	 * Non-merge ranges. the modified VMA merge operation assumes that the
+	 * caller always specifies ranges within the input VMA so we need only
+	 * examine these cases.
+	 *
+	 *     -
+	 *      -
+	 *       -
+	 *     <->
+	 *     <>
+	 *      <>
+	 * 0123456789a
+	 * PPPVVVVVNNN
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, flags);
+
+	vmg_set_range(&vmg, 0x4000, 0x5000, 4, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x6000, 0x7000, 6, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x4000, 0x7000, 4, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x4000, 0x6000, 4, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
+
+	return true;
+}
+
+static bool test_anon_vma_non_mergeable(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_prev, *vma_next;
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain1 = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain2 = {
+		.anon_vma = &dummy_anon_vma,
+	};
+
+	/*
+	 * In the case of modified VMA merge, merging both left and right VMAs
+	 * but where prev and next have incompatible anon_vma objects, we revert
+	 * to a merge of prev and VMA:
+	 *
+	 *    <-->
+	 * 0123456789
+	 * PPPVVVVNNN
+	 *            ->
+	 * 0123456789
+	 * PPPPPPPNNN
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
+
+	/*
+	 * Give both prev and next single anon_vma_chain fields, so they will
+	 * merge with the NULL vmg->anon_vma.
+	 *
+	 * However, when prev is compared to next, the merge should fail.
+	 */
+
+	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
+	ASSERT_TRUE(list_is_singular(&vma_prev->anon_vma_chain));
+	vma_prev->anon_vma = &dummy_anon_vma;
+	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_prev->anon_vma, vma_prev));
+
+	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
+	ASSERT_TRUE(list_is_singular(&vma_next->anon_vma_chain));
+	vma_next->anon_vma = (struct anon_vma *)2;
+	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_next->anon_vma, vma_next));
+
+	ASSERT_FALSE(is_mergeable_anon_vma(vma_prev->anon_vma, vma_next->anon_vma, NULL));
+
+	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x7000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_FALSE(vma_write_started(vma_next));
+
+	/* Clear down and reset. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Now consider the new VMA case. This is equivalent, only adding a new
+	 * VMA in a gap between prev and next.
+	 *
+	 *    <-->
+	 * 0123456789
+	 * PPP****NNN
+	 *            ->
+	 * 0123456789
+	 * PPPPPPPNNN
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
+
+	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
+	vma_prev->anon_vma = (struct anon_vma *)1;
+
+	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
+	vma_next->anon_vma = (struct anon_vma *)2;
+
+	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg.prev = vma_prev;
+
+	ASSERT_EQ(merge_new(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x7000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_FALSE(vma_write_started(vma_next));
+
+	/* Final cleanup. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	return true;
+}
+
+static bool test_dup_anon_vma(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct vm_area_struct *vma_prev, *vma_next, *vma;
+
+	reset_dummy_anon_vma();
+
+	/*
+	 * Expanding a VMA delete the next one duplicates next's anon_vma and
+	 * assigns it to the expanded VMA.
+	 *
+	 * This covers new VMA merging, as these operations amount to a VMA
+	 * expand.
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next->anon_vma = &dummy_anon_vma;
+
+	vmg_set_range(&vmg, 0, 0x5000, 0, flags);
+	vmg.vma = vma_prev;
+	vmg.next = vma_next;
+
+	ASSERT_EQ(expand_existing(&vmg), 0);
+
+	/* Will have been cloned. */
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+
+	/* Cleanup ready for next run. */
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * next has anon_vma, we assign to prev.
+	 *
+	 *         |<----->|
+	 * |-------*********-------|
+	 *   prev     vma     next
+	 *  extend   delete  delete
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+
+	/* Initialise avc so mergeability check passes. */
+	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain.same_vma, &vma_next->anon_vma_chain);
+
+	vma_next->anon_vma = &dummy_anon_vma;
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x8000);
+
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * vma has anon_vma, we assign to prev.
+	 *
+	 *         |<----->|
+	 * |-------*********-------|
+	 *   prev     vma     next
+	 *  extend   delete  delete
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+
+	vma->anon_vma = &dummy_anon_vma;
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x8000);
+
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * vma has anon_vma, we assign to prev.
+	 *
+	 *         |<----->|
+	 * |-------*************
+	 *   prev       vma
+	 *  extend shrink/delete
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
+
+	vma->anon_vma = &dummy_anon_vma;
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x5000);
+
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * vma has anon_vma, we assign to next.
+	 *
+	 *     |<----->|
+	 * *************-------|
+	 *      vma       next
+	 * shrink/delete extend
+	 */
+
+	vma = alloc_and_link_vma(&mm, 0, 0x5000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+
+	vma->anon_vma = &dummy_anon_vma;
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_next);
+
+	ASSERT_EQ(vma_next->vm_start, 0x3000);
+	ASSERT_EQ(vma_next->vm_end, 0x8000);
+
+	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_next->anon_vma->was_cloned);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_vmi_prealloc_fail(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	struct vm_area_struct *vma_prev, *vma;
+
+	/*
+	 * We are merging vma into prev, with vma possessing an anon_vma, which
+	 * will be duplicated. We cause the vmi preallocation to fail and assert
+	 * the duplicated anon_vma is unlinked.
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma->anon_vma = &dummy_anon_vma;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	fail_prealloc = true;
+
+	/* This will cause the merge to fail. */
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+	/* We will already have assigned the anon_vma. */
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	/* And it was both cloned and unlinked. */
+	ASSERT_TRUE(dummy_anon_vma.was_cloned);
+	ASSERT_TRUE(dummy_anon_vma.was_unlinked);
+
+	cleanup_mm(&mm, &vmi); /* Resets fail_prealloc too. */
+
+	/*
+	 * We repeat the same operation for expanding a VMA, which is what new
+	 * VMA merging ultimately uses too. This asserts that unlinking is
+	 * performed in this case too.
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma->anon_vma = &dummy_anon_vma;
+
+	vmg_set_range(&vmg, 0, 0x5000, 3, flags);
+	vmg.vma = vma_prev;
+	vmg.next = vma;
+
+	fail_prealloc = true;
+	ASSERT_EQ(expand_existing(&vmg), -ENOMEM);
+
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(dummy_anon_vma.was_cloned);
+	ASSERT_TRUE(dummy_anon_vma.was_unlinked);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
 int main(void)
 {
 	int num_tests = 0, num_fail = 0;
@@ -193,11 +1391,21 @@ int main(void)
 		}							\
 	} while (0)
 
+	/* Very simple tests to kick the tyres. */
 	TEST(simple_merge);
 	TEST(simple_modify);
 	TEST(simple_expand);
 	TEST(simple_shrink);
 
+	TEST(merge_new);
+	TEST(vma_merge_special_flags);
+	TEST(vma_merge_with_close);
+	TEST(vma_merge_new_with_close);
+	TEST(merge_existing);
+	TEST(anon_vma_non_mergeable);
+	TEST(dup_anon_vma);
+	TEST(vmi_prealloc_fail);
+
 #undef TEST
 
 	printf("%d tests run, %d passed, %d failed.\n",
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 093560e5b2ac..a3c262c6eb73 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -81,8 +81,6 @@
 
 #define AS_MM_ALL_LOCKS 2
 
-#define current NULL
-
 /* We hardcode this for now. */
 #define sysctl_max_map_count 0x1000000UL
 
@@ -92,6 +90,12 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 typedef unsigned long vm_flags_t;
 typedef __bitwise unsigned int vm_fault_t;
 
+/*
+ * The shared stubs do not implement this, it amounts to an fprintf(STDERR,...)
+ * either way :)
+ */
+#define pr_warn_once pr_err
+
 typedef struct refcount_struct {
 	atomic_t refs;
 } refcount_t;
@@ -100,9 +104,30 @@ struct kref {
 	refcount_t refcount;
 };
 
+/*
+ * Define the task command name length as enum, then it can be visible to
+ * BPF programs.
+ */
+enum {
+	TASK_COMM_LEN = 16,
+};
+
+struct task_struct {
+	char comm[TASK_COMM_LEN];
+	pid_t pid;
+	struct mm_struct *mm;
+};
+
+struct task_struct *get_current(void);
+#define current get_current()
+
 struct anon_vma {
 	struct anon_vma *root;
 	struct rb_root_cached rb_root;
+
+	/* Test fields. */
+	bool was_cloned;
+	bool was_unlinked;
 };
 
 struct anon_vma_chain {
@@ -682,13 +707,21 @@ static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct
 	return 0;
 }
 
-static inline int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *)
+static inline int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 {
+	/* For testing purposes. We indicate that an anon_vma has been cloned. */
+	if (src->anon_vma != NULL) {
+		dst->anon_vma = src->anon_vma;
+		dst->anon_vma->was_cloned = true;
+	}
+
 	return 0;
 }
 
-static inline void vma_start_write(struct vm_area_struct *)
+static inline void vma_start_write(struct vm_area_struct *vma)
 {
+	/* Used to indicate to tests that a write operation has begun. */
+	vma->vm_lock_seq++;
 }
 
 static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
@@ -759,8 +792,10 @@ static inline void vma_assert_write_locked(struct vm_area_struct *)
 {
 }
 
-static inline void unlink_anon_vmas(struct vm_area_struct *)
+static inline void unlink_anon_vmas(struct vm_area_struct *vma)
 {
+	/* For testing purposes, indicate that the anon_vma was unlinked. */
+	vma->anon_vma->was_unlinked = true;
 }
 
 static inline void anon_vma_unlock_write(struct anon_vma *)
-- 
2.46.0


