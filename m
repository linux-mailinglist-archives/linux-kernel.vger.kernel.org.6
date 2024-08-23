Return-Path: <linux-kernel+bounces-299599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1535D95D75E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE83282849
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A22D1946D0;
	Fri, 23 Aug 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jrnGDUv7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PoNUPfaj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96513634A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443659; cv=fail; b=C7U8ZuLhMxx/bd3qtXlfX7ln7x5dNstbPAzmN95lgHRVOCDNg91reexAnMzJZ+2Oc72YMgJpgF3wiC8ffgJM6UWMn0rLV1VVJpWK1iqERKqjnUbKluF7ycakd9xb916K/xwZ+08kvBMS0a79XxQ8NDrLdSW+KZyw+SivtDU9B80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443659; c=relaxed/simple;
	bh=Agt8mZ2ZnZ79NdCoqInxzYDHkOlUvkGb7zXpwXqscLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVcBAKKFKRHydUlrkVY7kNRu34lJz1yCcU8hV2PsRAa4tViaXPPbCfMVhlpPLHZb1enrzZ7zJm+5XWztgwkIL2SKuHvSJYwKTMejlJxhUy1xh0sH9sM+iNLnwYGYHLSDqzsTslZloPjzDvrO+1l56SYvhJ6MibPRf96zBX8qI5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jrnGDUv7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PoNUPfaj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0ZT3002378;
	Fri, 23 Aug 2024 20:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=G07yRBnF8m4u5HMCec6mYo3CU3xKGFgZoQ+zxPgkK9Y=; b=
	jrnGDUv7lvxCO/3oERWGgJjWdpJs7pSVOaJ2CsxTgB3FsrLAMnITPa6vDK1d6v23
	dffvowAhvw8+y/yxpupEcNsM/Ro2+lKXXUjCYtDytCihOtNAW9AQunKZvKpPqmSp
	+VvAtrbj3NgbMYWLNdSl9hVODPrrbHvdF8LFYWJJ8INBdLxpWapW3ALBfK1z4Civ
	bECvn1Nfewf7ZPNN2kPnR0mLdODvtTUBRA9AlVQamAg9PHtbDlFH9qurNsLgx2su
	omw+/xKkVoUkBIzN81yWFWfjUodx5r0njuQc54Z396l1dCVhbQz4U7E3gBWn/yCk
	3xUM8xSa6h/XLnGDljhK6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67n1fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdFFe007123;
	Fri, 23 Aug 2024 20:07:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4170s610wk-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0Zkq+3UN/PeavXRWJAkdy7ihJvhR7/KB+C7ER0NSPpelVC1iHLRbcr3VI27Iq4yJ6D7waJuOFeeNnq/aAupmyyrP7fNIFjn7P0JWrThg2RVSkk+jH2pgPL/o+3yvNieUeTnHj1HoNQs1MWVRAwPuv02wVIMVQZ+x7F64lJ6okwjEG87fDZ4rz0riihDJeDoup3QeUeh1NhgCXFPFJ0DKy7Q08IrosEDBSU5GMNfzcF2LKqcUQ1Q70IRZTIpAo4tD8yXo93k96/mzMo68WwwZKOM/ALMkd/ucBqB16/eU3yoemb6iSWMG9rxbpLunY2bRE5tPs5RdhaALVdbufG0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G07yRBnF8m4u5HMCec6mYo3CU3xKGFgZoQ+zxPgkK9Y=;
 b=iQjkSBnSVaM41JWEPiVqXuCEuiET3Qe7/hFIVcpfIYxR/oLBYVrgVMmsKZhFFrMnr4o2YQQRljo9g51C8S8BsRaMP6lCeL/8EpdQnXTtyyYZlr1B+2y71iMagHrqkEEgVsq7eP/8ckmytbncDVxmUdJg+CUTQLe/FN9he++bDWxE4JOSRV+0fzMeYeJASNeG18WdeRDIpI3pbLa3uHGLiJJloV8E0XwHSrJkMcTTxlqgkDgROxrbRdsDCn1L8MigRexW+43unlMVZaJ1WOY3ZsHxSI6ppp+IYZpdFT7S7aaAZ2K9Uk7Qy7aYRo9MirdOQvz7TA7nfBxC/tMIFPdxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G07yRBnF8m4u5HMCec6mYo3CU3xKGFgZoQ+zxPgkK9Y=;
 b=PoNUPfajOpunC5UC36nhNqmfxZ9JILemOq0gnL9JDW2euVN5e8sPyXScSLZ03utaD5chLK8p3YH8DpL5YIjv2XuT5eqAWeD/IUd21WoQmIWPvid2rZ2ELHWFxJfl87CcRBQhlOe+As5YXPr1P+aDYqoZ7JCQnuitoTy7DmPs9ak=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 03/10] mm: introduce vma_merge_struct and abstract vma_merge(),vma_modify()
Date: Fri, 23 Aug 2024 21:06:58 +0100
Message-ID: <ecce1383916a978fba6b75dcbb74132d8bb1eaa6.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0035.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 590ed16f-5b68-45ec-ef13-08dcc3af2fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1sT1/jYKE92IQBvea+QopDA8R+s9TWN26exX0wtd/fTqUxH21OAfX6ms8kS3?=
 =?us-ascii?Q?U/K2xgCuqQk0JB+M1gvRh3lHSLURvUgrUry7d0WxbrhpQrMuneb8OunTx+ZG?=
 =?us-ascii?Q?8S5EiPdKhmINrGNW+NwJxKj3E4irCttLb+0WjALbN/NQ6QNMpbquPDA23lqo?=
 =?us-ascii?Q?ru3to8a32YiCq4v8Z4C6R7az24Lmee9CyNyV4iK+je1zLEh7u9wGEDHozRHO?=
 =?us-ascii?Q?fqZpAKFat0bVD8QczYRItTSlIWzRwvoeK9xiuCkXxjs/F8zn9kNrDHW73ixF?=
 =?us-ascii?Q?CY0+dLf/N3n+DUeKal9ggN2cCuF/j2sk0v+UA5ePqrc5456cL2mAJV6/+EgL?=
 =?us-ascii?Q?aFEYu7qy0Bm6tQ4c2IBHYbxvPkV1qboQTKh3fkCQlux7f0ew1i7yye8QhBd9?=
 =?us-ascii?Q?tGZ0mdYXDbMk1L6QhrBM1hP2XP0PAyMXFuJBiE8z19QhLzJmPgeOGKPg76bg?=
 =?us-ascii?Q?DMPz4kxQSzXiplUUKHh2gVdykoH7OCwDslUGW4IlDopfZAENZx3FEYRwSbvy?=
 =?us-ascii?Q?auzBYJ36GN2f18/KE4Q/FRh96u4fkWi1Y/vNWAadpbFvfXE6yI/suumfEjix?=
 =?us-ascii?Q?XWpYHlpLbmHuifnyxske9GA4Y86kl6cAzLcdi881POOlMLiFdm466HIwoaQQ?=
 =?us-ascii?Q?EHblq8jqNrJpHxVLaAVEoC7vqhEQ3ZvLGSL75oEAUTklRHlYarmfhyDHgooe?=
 =?us-ascii?Q?msGJDUPB3NfuZvR7Hd95qG8IVVJ6Xl/CkAqjs/kaJ85jdl/DvxbCI7kDUML4?=
 =?us-ascii?Q?e7zZ0n7vC7ErjeziMOBL0MkzaRvkmSGEi2Zh8OlhVSKluaSGE4OyRD+j2AVJ?=
 =?us-ascii?Q?dax2xdPPEge6kd0TJokJJCYI5CCc7xDVW/4lq84gwTTNAqZATzBpXPEIvkFd?=
 =?us-ascii?Q?14t0On0XlFjsXzaMqW4yKkk2H5OdrUx6mDuH784LLYpwnnyVdkFg41VuRryd?=
 =?us-ascii?Q?I/igVGSGAUhNw18lcjt/BGg6mm2DJA/j17YA06gmuvwQoIcF9VCeAJkDb5l/?=
 =?us-ascii?Q?jpaUOcuopBjFwjHOCSsW6+VE4E8qoqSV+t5T5/KXl/+1Kn7A1A6qKXPuzrWL?=
 =?us-ascii?Q?PzJ4zDNN83q3sFZI7zSGSMsQTKTDIQEbN+DVfTGgoa0G1bP1jh2ROvhHRUbA?=
 =?us-ascii?Q?pS6uMWGB+7gnY9jLZObAHs6tpkMpSaOmdBqB990S3uWz/2QEjM1tWSfxEp2V?=
 =?us-ascii?Q?6I+AOoDsq/V5S+5O7a2qvmQQuTh7tJJ0yNdC8RGstHRQGvMxQt6iVPM6U8Zl?=
 =?us-ascii?Q?GKVG8/mVn80L4faPKJ6w3/JKILWvaHOkA9Iv9x3AuX0h8lfQIb6uXx6cETru?=
 =?us-ascii?Q?S/B0G2Rg9WPqeQAOmdtw3Hl5PMC/wpudpmeo858O26k9HQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2B4fnb6HaRBoytIJ4aKxOboAphO6UAGsoIi9j1H02WQ8y1jLaL/vB8lXiUPk?=
 =?us-ascii?Q?qs+FGq1EwDLJaJY9WLIRyE22HsjdNWVswdyIrVZvUWqkPNhayor2JFfdB9bn?=
 =?us-ascii?Q?0QzJB/UuP72tM8t1mnxXGn4SDiHx0pfW1s9nB8NHn6w36PBnpJc+0IjvXEFO?=
 =?us-ascii?Q?sxQdDXC117DG7grA3keQtFvoOAV6cnBRsC2CyDwpZIknbreJwJCfYrX6BDvZ?=
 =?us-ascii?Q?PHXvsPnkAGENRumIvXLoT5N/Gfxykj473ymqQrlhO/z+fx9AW9A40OCBV7VX?=
 =?us-ascii?Q?pJNWGfnIw9StzhhfFPfWJu6H7gEmx6atknpMWSzkK+Pgql5Q8UiabhfOdAea?=
 =?us-ascii?Q?+v9bVoCRRZ5Bpu3wIhKgSWgQvcoVUDwiAEtJf9GKGk9ywesikeZDgEcVgLn1?=
 =?us-ascii?Q?zYyIPEn32/bFU0maVmySbkFM+9ZqDhrVhtPKr9NQyauqdN/XaEOqLeN69uV5?=
 =?us-ascii?Q?kjTVsWReJ9x3YcI7v6sTVMY3N1UycMw5NcUxUGbYl44DUFIf8n7/4INV5zAP?=
 =?us-ascii?Q?K83p5xDysoewSF54xSjbt0BfMKCJBpLIMTIKazlRjMFIKeNgafIFPWq305t6?=
 =?us-ascii?Q?YDg1pIIG3bHbZH8t5CCvo3u5n7/6Tzd80gIPscKoJsLjnhAW8MPSGPmhtPeO?=
 =?us-ascii?Q?TtsESghZxoyMLSdEma/bese8cZHOWKduCGQDHSnb2X5DWr511Y2TIlHXdyDp?=
 =?us-ascii?Q?oP6ZzVOhV2pMxw6DH9ExBazjtncskJ7/oviZ3K3/wo6xPUp2J7aTkRfd4sd3?=
 =?us-ascii?Q?bEs6metHbr728PibiSRrMqNxVEUvu/jakNVfdMyLhgrsqYTI961dycdTWLDF?=
 =?us-ascii?Q?nIdCj7Erqx7yM092VkMWgfD6RO7xCy8e4cPXhrO+BMy81MxA4+jwRCu8piEq?=
 =?us-ascii?Q?CksYXGJj4NZj+nnLE+MdgPs1N++Fo9LeFJEW14Jy6v/nD++buvz7URge9/GF?=
 =?us-ascii?Q?tkPiFNko6C71SfX9fYZI3YUPgowMciPE2VfJ2flgpe7ct/WVmUnA4kPyS0N6?=
 =?us-ascii?Q?QbZBorGQ3eBuMBeOiaNaR5tboqTVG8mhFaXKbsM9NipJyI2JwtcPDBImNdXe?=
 =?us-ascii?Q?F17UUFGJuTRqqRlC+fZtzgS89g5sBSf4fwvIS+99Ixrlmc8wo0saqhlsEy0o?=
 =?us-ascii?Q?2WC1ZgSdw+Av9SoWwkdN5wQgQeDCbxvkJD2D/6wOY0NgWahEfGk+9Pg6TXMD?=
 =?us-ascii?Q?6EoX2h5lvaxe4+3jHcVPL6NDhMb9EOLyBoKY12pxfSk+XqTATmK1K3bN8Zvd?=
 =?us-ascii?Q?OnXXY1q1AKMrajjwizP9VEq/BJBakN4QzmcsgHuQ18W1U9OdTJP+V0HExtDd?=
 =?us-ascii?Q?6sAUePZlFp3w1nf072L+lH4paP+1b3ZG1iiol6MPD/RPxb53CL9yVJy/bwzk?=
 =?us-ascii?Q?hWngzCRFt09fIcaVn72DSQqoMwjzZwjOjcxAbAyd11wskYV9D4ozj7LmWCcd?=
 =?us-ascii?Q?vcpD2Q0aTx+DLYES4oc2s5irHuleFpBKITIEYNoeLhOljOgy+dTp8Ijz1cG6?=
 =?us-ascii?Q?XNlhsLwsm7s4ds74ChvbXE5baPqwBmfeBQgdEfj1l38Dy0schnQ3LEQusObQ?=
 =?us-ascii?Q?cVTxqwOrCMZJR6iE+ixIziFOO/Hal/r+BUESQy+DNeDLUMvcVOph3CJ+3cfd?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cnh/bU2T1/dTQISYUniDFjXCErGQdhjgGh7ueZqMmK/LcB0fQLWa01vrRzadLkbRyljNh0QTzjs7uQ82cgSmLBJhYuySQJBPzxZitWIrND1Wcc6sH19GmmERlrmShwcxJmOK6Bty+NeEAFv1VLJMRJFKDp3TK0OJKgOa3KLJVebzVFaekc6KCb8W3nYblzkeBzmY8wvL8Ke5UJnsXUcX74AB5U87m9ifNvlFSJDmmQjWnyw3C3LVsFbj19cKvY50uuuM7XgjY6PR6YJMa+MoKdm/bia3rgIINurPSr1jSpl1qPloaYfR2fMr/DFXtMDdi3+pDCkv9X1QkdnoxUZWqe6ClqDv0ATC5LNKld3Nd7SjEKjsqLjHyBElxUp5cRYtcrWGOX56RerqI/I9tQYh7wnrlDFgjtYW9mXLlcbxLXI+RdwXGoFfUgaBf83vJSD/fcfl5S3rPmYHEgQ3CMu1bJc42lrBoMZDVbtP7IB+kh6qkzqU4yCyVzpzTlPzyJocC8NkdYzv2V5hSLKtNdw3KIzQqo85LSICquU9V42cNdt8W5jfaaGOo3BFI5gSoaCJ78CGvsw3Wkg6wJUllMSMe5GUeDX4t1gEgDs2/4ZD1Cg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590ed16f-5b68-45ec-ef13-08dcc3af2fc7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:17.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7fAPnbjyVCuQ2g/qKOK5OKNPw8mNflzDGwvQGQ0ii5LBCjNCR8jEDzUJdbpNR1fkT1ESJALkUmSpJNw+HVNkgGgH0GSSqoMMexPIyMbtbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: DTvZHalHgEm-LcBIPmqYOwpR_F6ytObf
X-Proofpoint-GUID: DTvZHalHgEm-LcBIPmqYOwpR_F6ytObf

Rather than passing around huge numbers of parameters to numerous helper
functions, abstract them into a single struct that we thread through the
operation, the vma_merge_struct ('vmg').

Adjust vma_merge() and vma_modify() to accept this parameter, as well as
predicate functions can_vma_merge_before(), can_vma_merge_after(), and the
vma_modify_...() helper functions.

Also introduce VMG_STATE() and VMG_VMA_STATE() helper macros to allow for
easy vmg declaration.

We additionally remove the requirement that vma_merge() is passed a VMA
object representing the candidate new VMA. Previously it used this to
obtain the mm_struct, file and anon_vma properties of the proposed range (a
rather confusing state of affairs), which are now provided by the vmg
directly.

We also remove the pgoff calculation previously performed vma_modify(), and
instead calculate this in VMG_VMA_STATE() via the vma_pgoff_offset()
helper.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c               |  77 ++++++++-------
 mm/vma.c                | 209 ++++++++++++++++++++++++----------------
 mm/vma.h                | 128 ++++++++++++++----------
 tools/testing/vma/vma.c |  43 +--------
 4 files changed, 249 insertions(+), 208 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e495b0381265..4066c0444495 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1373,9 +1373,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
-	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
+
+	vmg.file = file;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1388,12 +1390,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
 
-		next = vms.next;
-		prev = vms.prev;
+		next = vmg.next = vms.next;
+		prev = vmg.prev = vms.prev;
 		vma = NULL;
 	} else {
-		next = vma_next(&vmi);
-		prev = vma_prev(&vmi);
+		next = vmg.next = vma_next(&vmi);
+		prev = vmg.prev = vma_prev(&vmi);
 		if (prev)
 			vma_iter_next_range(&vmi);
 	}
@@ -1413,6 +1415,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
+		vmg.flags = vm_flags;
 	}
 
 	if (vm_flags & VM_SPECIAL)
@@ -1421,28 +1424,31 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Attempt to expand an old mapping */
 	/* Check next */
 	if (next && next->vm_start == end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
+	    can_vma_merge_before(&vmg)) {
 		merge_end = next->vm_end;
 		vma = next;
-		vm_pgoff = next->vm_pgoff - pglen;
+		vmg.pgoff = next->vm_pgoff - pglen;
+		/*
+		 * We set this here so if we will merge with the previous VMA in
+		 * the code below, can_vma_merge_after() ensures anon_vma
+		 * compatibility between prev and next.
+		 */
+		vmg.anon_vma = vma->anon_vma;
+		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
 	}
 
 	/* Check prev */
 	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX, NULL))) {
+	    can_vma_merge_after(&vmg)) {
 		merge_start = prev->vm_start;
 		vma = prev;
-		vm_pgoff = prev->vm_pgoff;
+		vmg.pgoff = prev->vm_pgoff;
 		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
 	if (vma) {
 		/* Actually expand, if possible */
-		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
 			khugepaged_enter_vma(vma, vm_flags);
 			goto expanded;
 		}
@@ -1772,26 +1778,29 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
-	    can_vma_merge_after(vma, flags, NULL, NULL,
-				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		vma_iter_config(vmi, vma->vm_start, addr + len);
-		if (vma_iter_prealloc(vmi, vma))
-			goto unacct_fail;
-
-		vma_start_write(vma);
-
-		init_vma_prep(&vp, vma);
-		vma_prepare(&vp);
-		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-		vma->vm_end = addr + len;
-		vm_flags_set(vma, VM_SOFTDIRTY);
-		vma_iter_store(vmi, vma);
-
-		vma_complete(&vp, vmi, mm);
-		validate_mm(mm);
-		khugepaged_enter_vma(vma, flags);
-		goto out;
+	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
+		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
+
+		vmg.prev = vma;
+		if (can_vma_merge_after(&vmg)) {
+			vma_iter_config(vmi, vma->vm_start, addr + len);
+			if (vma_iter_prealloc(vmi, vma))
+				goto unacct_fail;
+
+			vma_start_write(vma);
+
+			init_vma_prep(&vp, vma);
+			vma_prepare(&vp);
+			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
+			vma->vm_end = addr + len;
+			vm_flags_set(vma, VM_SOFTDIRTY);
+			vma_iter_store(vmi, vma);
+
+			vma_complete(&vp, vmi, mm);
+			validate_mm(mm);
+			khugepaged_enter_vma(vma, flags);
+			goto out;
+		}
 	}
 
 	if (vma)
diff --git a/mm/vma.c b/mm/vma.c
index e5a5e418c7cb..74c627ff0313 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -7,16 +7,18 @@
 #include "vma_internal.h"
 #include "vma.h"
 
-/*
- * If the vma has a ->close operation then the driver probably needs to release
- * per-vma resources, so we don't attempt to merge those if the caller indicates
- * the current vma may be removed as part of the merge.
- */
-static inline bool is_mergeable_vma(struct vm_area_struct *vma,
-		struct file *file, unsigned long vm_flags,
-		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name, bool may_remove_vma)
+static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
+	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
+	/*
+	 * If the vma has a ->close operation then the driver probably needs to
+	 * release per-vma resources, so we don't attempt to merge those if the
+	 * caller indicates the current vma may be removed as part of the merge,
+	 * which is the case if we are attempting to merge the next VMA into
+	 * this one.
+	 */
+	bool may_remove_vma = merge_next;
+
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
 	 * match the flags but dirty bit -- the caller should mark
@@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 	 * the kernel to generate new VMAs when old one could be
 	 * extended instead.
 	 */
-	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
+	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
 		return false;
-	if (vma->vm_file != file)
+	if (vma->vm_file != vmg->file)
 		return false;
 	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
 		return false;
-	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
+	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
 		return false;
-	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
+	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
 		return false;
 	return true;
 }
@@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
  * We assume the vma may be removed as part of the merge.
  */
 bool
-can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+can_vma_merge_before(struct vma_merge_struct *vmg)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
-		if (vma->vm_pgoff == vm_pgoff)
+	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
+
+	if (is_mergeable_vma(vmg, true) &&
+	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
+		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
 			return true;
 	}
+
 	return false;
 }
 
@@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
  *
  * We assume that vma is not removed as part of the merge.
  */
-bool
-can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
-		pgoff_t vm_pglen;
-
-		vm_pglen = vma_pages(vma);
-		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
+	if (is_mergeable_vma(vmg, false) &&
+	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
+		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
 			return true;
 	}
 	return false;
@@ -1022,16 +1017,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
  * **** is not represented - it will be merged and the vma containing the
  *      area is returned, or the function will return NULL
  */
-static struct vm_area_struct
-*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
-	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
-	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
-	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-	   struct anon_vma_name *anon_name)
+static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 {
-	struct mm_struct *mm = src->vm_mm;
-	struct anon_vma *anon_vma = src->anon_vma;
-	struct file *file = src->vm_file;
+	struct mm_struct *mm = vmg->mm;
+	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	struct vm_area_struct *anon_dup = NULL;
@@ -1041,16 +1030,18 @@ static struct vm_area_struct
 	bool merge_prev = false;
 	bool merge_next = false;
 	bool vma_expanded = false;
+	unsigned long addr = vmg->start;
+	unsigned long end = vmg->end;
 	unsigned long vma_start = addr;
 	unsigned long vma_end = end;
-	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(end - addr);
 	long adj_start = 0;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
 	 */
-	if (vm_flags & VM_SPECIAL)
+	if (vmg->flags & VM_SPECIAL)
 		return NULL;
 
 	/* Does the input range span an existing VMA? (cases 5 - 8) */
@@ -1058,27 +1049,26 @@ static struct vm_area_struct
 
 	if (!curr ||			/* cases 1 - 4 */
 	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vma_lookup(mm, end);
+		next = vmg->next = vma_lookup(mm, end);
 	else
-		next = NULL;		/* case 5 */
+		next = vmg->next = NULL;	/* case 5 */
 
 	if (prev) {
 		vma_start = prev->vm_start;
 		vma_pgoff = prev->vm_pgoff;
 
 		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
-		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
-					   pgoff, vm_userfaultfd_ctx, anon_name)) {
+		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
+		    && can_vma_merge_after(vmg)) {
+
 			merge_prev = true;
-			vma_prev(vmi);
+			vma_prev(vmg->vmi);
 		}
 	}
 
 	/* Can we merge the successor? */
-	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
+	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
+	    can_vma_merge_before(vmg)) {
 		merge_next = true;
 	}
 
@@ -1129,7 +1119,7 @@ static struct vm_area_struct
 				remove = curr;
 			} else {			/* case 5 */
 				adjust = curr;
-				adj_start = (end - curr->vm_start);
+				adj_start = end - curr->vm_start;
 			}
 			if (!err)
 				err = dup_anon_vma(prev, curr, &anon_dup);
@@ -1169,13 +1159,13 @@ static struct vm_area_struct
 		vma_expanded = true;
 
 	if (vma_expanded) {
-		vma_iter_config(vmi, vma_start, vma_end);
+		vma_iter_config(vmg->vmi, vma_start, vma_end);
 	} else {
-		vma_iter_config(vmi, adjust->vm_start + adj_start,
+		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
 				adjust->vm_end);
 	}
 
-	if (vma_iter_prealloc(vmi, vma))
+	if (vma_iter_prealloc(vmg->vmi, vma))
 		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
@@ -1187,20 +1177,20 @@ static struct vm_area_struct
 	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
 
 	if (vma_expanded)
-		vma_iter_store(vmi, vma);
+		vma_iter_store(vmg->vmi, vma);
 
 	if (adj_start) {
 		adjust->vm_start += adj_start;
 		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
 		if (adj_start < 0) {
 			WARN_ON(vma_expanded);
-			vma_iter_store(vmi, next);
+			vma_iter_store(vmg->vmi, next);
 		}
 	}
 
-	vma_complete(&vp, vmi, mm);
+	vma_complete(&vp, vmg->vmi, mm);
 	validate_mm(mm);
-	khugepaged_enter_vma(res, vm_flags);
+	khugepaged_enter_vma(res, vmg->flags);
 	return res;
 
 prealloc_fail:
@@ -1208,8 +1198,8 @@ static struct vm_area_struct
 		unlink_anon_vmas(anon_dup);
 
 anon_vma_fail:
-	vma_iter_set(vmi, addr);
-	vma_iter_load(vmi);
+	vma_iter_set(vmg->vmi, addr);
+	vma_iter_load(vmg->vmi);
 	return NULL;
 }
 
@@ -1226,32 +1216,27 @@ static struct vm_area_struct
  * The function returns either the merged VMA, the original VMA if a split was
  * required instead, or an error if the split failed.
  */
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name)
+static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 {
-	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	struct vm_area_struct *vma = vmg->vma;
 	struct vm_area_struct *merged;
 
-	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
-			   pgoff, policy, uffd_ctx, anon_name);
+	/* First, try to merge. */
+	merged = vma_merge(vmg);
 	if (merged)
 		return merged;
 
-	if (vma->vm_start < start) {
-		int err = split_vma(vmi, vma, start, 1);
+	/* Split any preceding portion of the VMA. */
+	if (vma->vm_start < vmg->start) {
+		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
 
 		if (err)
 			return ERR_PTR(err);
 	}
 
-	if (vma->vm_end > end) {
-		int err = split_vma(vmi, vma, end, 0);
+	/* Split any trailing portion of the VMA. */
+	if (vma->vm_end > vmg->end) {
+		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
 
 		if (err)
 			return ERR_PTR(err);
@@ -1260,6 +1245,65 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 	return vma;
 }
 
+struct vm_area_struct *vma_modify_flags(
+	struct vma_iterator *vmi, struct vm_area_struct *prev,
+	struct vm_area_struct *vma, unsigned long start, unsigned long end,
+	unsigned long new_flags)
+{
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.flags = new_flags;
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.flags = new_flags;
+	vmg.anon_name = new_name;
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.policy = new_pol;
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.flags = new_flags;
+	vmg.uffd_ctx = new_ctx;
+
+	return vma_modify(&vmg);
+}
+
 /*
  * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
  * must ensure that [start, end) does not overlap any existing VMA.
@@ -1269,8 +1313,11 @@ struct vm_area_struct
 		   struct vm_area_struct *vma, unsigned long start,
 		   unsigned long end, pgoff_t pgoff)
 {
-	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
-			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.pgoff = pgoff;
+
+	return vma_merge(&vmg);
 }
 
 /*
@@ -1281,12 +1328,10 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta)
 {
-	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
+	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
 
 	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
-			 vma->vm_flags, pgoff, vma_policy(vma),
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	return vma_merge(&vmg);
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
diff --git a/mm/vma.h b/mm/vma.h
index c774642697a0..9060a1a1edfa 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -52,6 +52,59 @@ struct vma_munmap_struct {
 	unsigned long data_vm;
 };
 
+/* Represents a VMA merge operation. */
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
+/* Assumes addr >= vma->vm_start. */
+static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
+				       unsigned long addr)
+{
+	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
+}
+
+#define VMG_STATE(name, mm_, vmi_, start_, end_, flags_, pgoff_)	\
+	struct vma_merge_struct name = {				\
+		.mm = mm_,						\
+		.vmi = vmi_,						\
+		.start = start_,					\
+		.end = end_,						\
+		.flags = flags_,					\
+		.pgoff = pgoff_,					\
+	}
+
+#define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
+	struct vma_merge_struct name = {			\
+		.mm = vma_->vm_mm,				\
+		.vmi = vmi_,					\
+		.prev = prev_,					\
+		.next = NULL,					\
+		.vma = vma_,					\
+		.start = start_,				\
+		.end = end_,					\
+		.flags = vma_->vm_flags,			\
+		.pgoff = vma_pgoff_offset(vma_, start_),	\
+		.file = vma_->vm_file,				\
+		.anon_vma = vma_->anon_vma,			\
+		.policy = vma_policy(vma_),			\
+		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
+		.anon_name = anon_vma_name(vma_),		\
+	}
+
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 void validate_mm(struct mm_struct *mm);
 #else
@@ -208,80 +261,53 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
 
-/* Required by mmap_region(). */
-bool
-can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name);
-
-/* Required by mmap_region() and do_brk_flags(). */
-bool
-can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name);
-
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
+/*
+ * Can we merge the VMA described by vmg into the following VMA vmg->next?
+ *
+ * Required by mmap_region().
+ */
+bool can_vma_merge_before(struct vma_merge_struct *vmg);
+
+/*
+ * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
+ *
+ * Required by mmap_region() and do_brk_flags().
+ */
+bool can_vma_merge_after(struct vma_merge_struct *vmg);
 
 /* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
+struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+					struct vm_area_struct *prev,
+					struct vm_area_struct *vma,
+					unsigned long start, unsigned long end,
+					unsigned long new_flags);
 
 /* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_flags_name(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
+		       struct anon_vma_name *new_name);
 
 /* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_policy(struct vma_iterator *vmi,
 		   struct vm_area_struct *prev,
 		   struct vm_area_struct *vma,
 		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
+		   struct mempolicy *new_pol);
 
 /* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_flags_uffd(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
 		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}
+		       struct vm_userfaultfd_ctx new_ctx);
 
 struct vm_area_struct
 *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 9b272633ca9e..b12f72979478 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -22,26 +22,6 @@ static bool fail_prealloc;
  */
 #include "../../../mm/vma.c"
 
-/*
- * Temporarily forward-ported from a future in which vmg's are used for merging.
- */
-struct vma_merge_struct {
-	struct mm_struct *mm;
-	struct vma_iterator *vmi;
-	pgoff_t pgoff;
-	struct vm_area_struct *prev;
-	struct vm_area_struct *next; /* Modified by vma_merge(). */
-	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
-	unsigned long start;
-	unsigned long end;
-	unsigned long flags;
-	struct file *file;
-	struct anon_vma *anon_vma;
-	struct mempolicy *policy;
-	struct vm_userfaultfd_ctx uffd_ctx;
-	struct anon_vma_name *anon_name;
-};
-
 const struct vm_operations_struct vma_dummy_vm_ops;
 static struct anon_vma dummy_anon_vma;
 
@@ -115,14 +95,6 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 /* Helper function which provides a wrapper around a merge new VMA operation. */
 static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 {
-	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
-	struct vm_area_struct dummy = {
-		.vm_mm = vmg->mm,
-		.vm_flags = vmg->flags,
-		.anon_vma = vmg->anon_vma,
-		.vm_file = vmg->file,
-	};
-
 	/*
 	 * For convenience, get prev and next VMAs. Which the new VMA operation
 	 * requires.
@@ -131,8 +103,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 	vmg->prev = vma_prev(vmg->vmi);
 
 	vma_iter_set(vmg->vmi, vmg->start);
-	return vma_merge_new_vma(vmg->vmi, vmg->prev, &dummy, vmg->start,
-				 vmg->end, vmg->pgoff);
+	return vma_merge(vmg);
 }
 
 /*
@@ -141,17 +112,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
  */
 static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
 {
-	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
-	struct vm_area_struct dummy = {
-		.vm_mm = vmg->mm,
-		.vm_flags = vmg->flags,
-		.anon_vma = vmg->anon_vma,
-		.vm_file = vmg->file,
-	};
-
-	return vma_merge(vmg->vmi, vmg->prev, &dummy, vmg->start, vmg->end,
-			 vmg->flags, vmg->pgoff, vmg->policy, vmg->uffd_ctx,
-			 vmg->anon_name);
+	return vma_merge(vmg);
 }
 
 /*
-- 
2.46.0


