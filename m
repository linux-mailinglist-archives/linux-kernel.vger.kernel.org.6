Return-Path: <linux-kernel+bounces-303989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103E961814
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E8E1C22AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E76F148FE5;
	Tue, 27 Aug 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GgicDoBK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q2sUzF+W"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333111C6F56
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787504; cv=fail; b=QrHVxQLE/ZAumttWdaL17TgOmKIXYBusFMHThmy2nqpjR7ZLKWAsWSaO8z8WXftqEQ1YYsF7nZzWaYc1nXBD6SEqTqVOQjwsWEBvAmEh1RSaJkgIm9E7FRJvPgkg6pj4DPTtVqQMZdTU4QCxgn7HZxBTl4yJ1dab5K50h/DlDrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787504; c=relaxed/simple;
	bh=AA+bQ5rfGEw2Y9ct7T4TysDoQpbsz11DbcVCgJ4r/jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kU/MVdPrQtQpe0M5YNQjC3oQ4UKYWkeBpzkzvYgB8E6sC5RKKdjiav4y/nxos6bDYo9x8G3rK3uoEb+C54IFOugWXRDBHe99X9VWf0ZB1HR80gzWDdlan0CWStxwVfACYv8bGbiJoIOPeY4o01ujIwM7xWfbmCVaKf8Ol3Fo8K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GgicDoBK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q2sUzF+W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RJXUOS026744;
	Tue, 27 Aug 2024 19:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=5pbZCvnxvpb8C6u
	iZqRGh5pf+YmhbJdwXZedtWAfu00=; b=GgicDoBKWsNdbRw6H8MhGk+Ys0t0d5c
	XTJFrhbY6hF9iS0C824UeqyA71qfJJg1SmURNmi/rwN8d60yHjPWwC8IuC6UrRFZ
	Wxpu/i/Ju8XJg2ljAgqLdH8lSLJuRwRDZCOv6bYn9GwaFNOkgf6dW+L9oAshXeWu
	56hyV/bOGcVX1wB6AN+dcIUa7pap7eDW1y3Ytyj5PkQCjnqidUH6chCH8C0Sq08h
	W0gA0ugU0CaiJUAFFbiSVUM3ru8GSDxKUVtuXrqF1tRvJwi/6fd69ZcpxOocLawu
	1on37kUtfFl0PQkBMawNcUCiTfqoNjlMubiVsGh2Xzvd4CZR6yza9Iw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177naegje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 19:38:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RI2vWS031876;
	Tue, 27 Aug 2024 19:38:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0ucfj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 19:38:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmZuzLu8yt9KBDyeRGpGfZaIxlTpnNg6HEIUMVYmu+xZ1Yglc68zTIs8WtT8JYP7J09Ys8npjEL+ZGAVlDopzBorhwJQepfi0Z4HSV3CINiSTH6yEO7S/TVLJWHz65GBTScyZSmvKx/EPy4KicC6zIV08qDabBPiA1L51a1MlwPcALyfAzsXA+d5ogF9pbAUEW56VZP/CnrT/PCh3phGCq+HVgf3zvhPNyPneQxXCJXOy6zX2zv3mJZ62jmhVUncso+a/mLr0NYz5FQVE3fgY3ys8DbBtA0wwhVPiUsUuwTxxuSzV1pubPROwlfAgBi/oBiXwigGQaTotTBCICwBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pbZCvnxvpb8C6uiZqRGh5pf+YmhbJdwXZedtWAfu00=;
 b=COVhlf9ymipA5b4aZ4xDrg6Et6vyhJYnOuMeipQmEK+auVBpyp56a/6qpTdRYWE6WzdOwEoJFConodzhC7nygj+Do8q+FhI8SONVJOMqctY6b+ooVH+Jdz+ElSi9pfeNd1AtzT24342SciefpHXDSAIv6iKpolKBtrB35mDQCVO3+HimeCOScqxTbgEZKsjkwPeb2ufuQ/6I6KyMyo8Tu8zHQk2MbU/1R9jTqSzNfiB0Gl552giwOcrfMD+JLZG31UzlUFqLaZ5S9hE6RllqYFppejDL4NnlpD/hoC5xJwR61z7ijdb0GT1Y6oRkHZbBj8A47o/IYKNQB3hjrXmk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pbZCvnxvpb8C6uiZqRGh5pf+YmhbJdwXZedtWAfu00=;
 b=q2sUzF+W+L7WMi/iOuKwYtEAweNxqkPz+OuqQYJ+WLEMLZ8OgNPvFGkUv8fMe47iLRs9R/sqezCCLpRgKX6REmrgU8sZs53QMZ7dyXWZO5SnFc1HsImV9eOIFPJAO75A7CLHIjz3JNKZBZMsrWXWliz5gOHo3CqHGk9rUfs9pu4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Tue, 27 Aug
 2024 19:38:02 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Tue, 27 Aug 2024
 19:38:02 +0000
Date: Tue, 27 Aug 2024 15:38:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 mmap_region
Message-ID: <ifjwqijv5lpttrcpgckfvmc6koxzsqpghgfyb4umtsrpwshsgq@fxit3gumqhld>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
References: <000000000000ec6b3f0620ad9124@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ec6b3f0620ad9124@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0324.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 44428a68-83c9-4a6f-8f4b-08dcc6cfc3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Bgtq+TWRmP0h6GzX9K7zWpHjDL+Fn+JD/NNPewtzOYNIMSSwSvYXyWnRVqO?=
 =?us-ascii?Q?5pq7XJI4bdVVVNDLhOUBlU8mWJnwsCQMX/KD/YCAR675eY2NwViLu6RqXNuN?=
 =?us-ascii?Q?slZrmai9FS9Unl6ZKv7/msKqRSTcesPo2ExQZqxAqIDHLicWdWWSYs0G5Dv6?=
 =?us-ascii?Q?lAiJE+exsB/zEVIUeWlX7zokTAyPM1nRCUK/xba3Wk4SfZbfII5mjYH75b/6?=
 =?us-ascii?Q?TUHQrBkNxgUO82tBB0eA2rNXVHDrA8zlgLeJnpvedJzx1syXzauZ5ElrDz+W?=
 =?us-ascii?Q?ZDiQM/IDF6mEjR7JfUMm9qpfVB5BweRWrU0oCUATBqkSl5BZFx10lEo50UdJ?=
 =?us-ascii?Q?NlFCETrITnxUuRcovvvVJ6F6nDnm6Tr4NVhBMXD73r0b3PJDbcawYz+bTIxI?=
 =?us-ascii?Q?JYvPZ44JhEmzin68H1+/OtTOWdkHk77tWWKjxqByRSMZ+KxyWrkI4vvUDp12?=
 =?us-ascii?Q?LjdWfDhjQR5UHpkP+U8+CV1cNvo++F3kAE7PRHPPCqvM4ecMKMoxPDqtgZTL?=
 =?us-ascii?Q?wW5aLYizFE4Lvo7y/gBnp8NeIjFmvKaVKXjKxv2Q5sAwQD7nFvmku6JmMXDW?=
 =?us-ascii?Q?ZY8VWvLR4gDO32aMOa9dmxZu7Qi+ZNQr9hiod0ETAstYLSLvUzahExeJTt54?=
 =?us-ascii?Q?Ax1dIK0ZZaZVRMqnXLfZtMkzk0gi33b5/4IOjGNxWTyLjo77HCylxtLf3FhV?=
 =?us-ascii?Q?6Wa5UqRZNzm+kkZL4IhRGG9fY78ub/RwleieJpLqXXlNW877BcBbWvc/dsow?=
 =?us-ascii?Q?sgcM/D9ILQH2aedQYqUQM2V//I2K1ZfUorA0UPqGqs8Zlwx7323VdIoOCG1d?=
 =?us-ascii?Q?h+FvGshps6nrtivXHB0MyaSFF2ZiEQ5MrtAE0EwDKNQHYyrVaZXWNOEO7qpQ?=
 =?us-ascii?Q?Iu/WHCnrjwKKAN454TR/d8NDUQUqfpB0Z10bBEflPFAZKRVJjSPVOK2TU+yo?=
 =?us-ascii?Q?iMAmcy29onEU0RfYa3xsarlk9XKjl2Cki9sLpg99Ilpb7qc7boi1OI/hZ6NZ?=
 =?us-ascii?Q?EhPYayhY14UMrZyM+Yc2zJF750zGJepho6KVibPNyyfTH90NS1FF9eZxEr26?=
 =?us-ascii?Q?3GvNCXVhAtBBvPXB889EzaoXD9OowpG/o7T73G/OKm7dmOIOiXQCgd7sVWnf?=
 =?us-ascii?Q?caHPhlhhxt/NqIQQC+ZUit6OFbsBEoh+E3FePWPNmsf7AnGfnU/hHggm/rRe?=
 =?us-ascii?Q?JhaJ25jwe/M+Y/LZGCAw3iqDcLGsz7bH6odhbG0BhKdptvh52jOcXTdbJSst?=
 =?us-ascii?Q?fWBj+opEJ8nXUH3qsSxqFyDeH025YjvbnRsQaEtDBW1qKGro1ZREBWO9e8kO?=
 =?us-ascii?Q?wEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBbnPK/IJtEllG29F4/DhARfnthrP071hFaDHu7pVQuVdFXKM2Exu+CFG1Ez?=
 =?us-ascii?Q?HprZPYCVi5TDJLguuyGedQAdJ8Mhw/p+j3hJXvZsU0sQFzgL/VKU0m9G2cdY?=
 =?us-ascii?Q?XpK+SAF0PqGV8UdKH585GCHjJAySSQJL1VBifv/Lw3F/Ccd3U/3ZbA3WX6D4?=
 =?us-ascii?Q?kHx3geVAEHOA3yM/uMYvzE0gvfayDXepfMArOqQTBByHLBXXrte8FLWGUfCg?=
 =?us-ascii?Q?OZpMqUcZGZKPIO26hBNBPbG8yElTd5uVH7q7PBYf84UgRBi84Ysurq1j/N6M?=
 =?us-ascii?Q?gXZypUSL+ru2fGkiAuZokaXXbFAE6lonmsGbigx/EzlkNizWfghddTTD9OTk?=
 =?us-ascii?Q?VJcqjzmeQ4R6VQK+lv/OpyBXu61eVBe2+I9Yfp1jOVi1uN7XVvRz944bdV6H?=
 =?us-ascii?Q?pgU6pm3c7e7nDt+U2r/+J6DmeBjZ/qXwcA3dp0/VCVRU0oxAaYAQL0JsvTu+?=
 =?us-ascii?Q?x7165DZv/GaomUZ+pChPuKYmZipWwQ/A8+7uhwn4374XpqThmcEjXYz6Zbm7?=
 =?us-ascii?Q?efqpbM/CGUljtkxSTpxB5D6xiuV/DrFe+RKwdSTqWZitEak1xB++ti4fUYTY?=
 =?us-ascii?Q?h9hi0DIPJ3JBjDO0vbIE7oblRDd8a6rX0PrCyl/eB/ATtVDZgpqrPuZn/Pn3?=
 =?us-ascii?Q?wu6m+b0qOb+2hQiLeuk1a29YghcFtwRJOd5PCFCiIw7eWm3A5l+/Lr08XeyW?=
 =?us-ascii?Q?+5oVFuuq7/UhgRfQvriExaEEJ9Hx8aY4j94d/j17mMcLoaqzqQPHJSdlTQ0P?=
 =?us-ascii?Q?BjWxTwepiq1t98ua7QnSTobD7P+Edi3KOA+hZBOsswkHhJQZheHN3RfTbMdK?=
 =?us-ascii?Q?Nyo2H7AjF5FheA/ta8PBvWVbuUqUkiq8S1b/52wMjcrvH6VHgvf0c+PCxi8R?=
 =?us-ascii?Q?ui3jKF9/HayTjEFi0wwhy0YB0PArpeXc7YeI1x+BoCb53r0Ykf4hhD5LuKuN?=
 =?us-ascii?Q?m9xCBb8myhfez/XHHzG6jschhO4O1SgegkhBIHw0Z4yEbb/7WoBk/5C3ALxX?=
 =?us-ascii?Q?AXwq/w2zPadN+vnNIAdNU/0Qf5FvLVCBv4PBImeH5ccsPc3i+evnkjCghrzL?=
 =?us-ascii?Q?XjKrovzKvW67SbENvAjOkNvhtmgRF6qTY0TeR7r0sPb9AklQgRqlVJ7AKJMc?=
 =?us-ascii?Q?8nu52Z+T0K5c/pXj5xpN5cnttzwzf68gMc1w6sgq/rl9LKOH7m5WxIKhOM/a?=
 =?us-ascii?Q?pdW4ZKUxPfh6HC5MSDm+CLRD9AgD7j0XXf8kSeJanGlUuSYYsEa6sI6HzbjA?=
 =?us-ascii?Q?vw8bdFP+TaCvNlAYWlIpxFvZDCEepzAjRXN1tmyF2cayW45mCSn3cMI29RVQ?=
 =?us-ascii?Q?427Pq5e026wHXABFxCh4hIDelIPyB2xCbRBX8qmZHgXq1q1bgKMq/XSZbnQD?=
 =?us-ascii?Q?t4ZqnJ3Ioq4gYoyU1O4Re7Ytxt2CKKPF+JrpK6gC2jHUc6PhwDa/96iJRZu3?=
 =?us-ascii?Q?j0H5O7eu/hL1beZqVft1ElpCG5GQfofOdcofAJyStNmULe+0X93Iz8+iGWTR?=
 =?us-ascii?Q?XsNtyh1MfaBSMtW1Hy+SfHPtKXcFtXuk3nb/Aw90b4xsXxwPkhRsZvo3Thqp?=
 =?us-ascii?Q?3HZBL7shYwjwQeLdr55tmMiIUpRHokF3eLgCDYEo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R97MTTaZl+RtF6hcUIT9wS4NFucOT5ZeANjNX61WGgm64mvN+eGV0SNCNaSvyswA2YjuCGmMzp/C8FVwuMdAKjFTBt6b9Ye0b0nbz4eoo050+PCmWfNSwpUW8ZaOWFp5veXXmwL71sotRvjJLeZ+1bj54fk9OevdV0HfoPhA9H04m4YEYTAkKGb2dJzcTb2a5mMxsI1zL27hIpHf79m3iiRBjOKpDAHqaRsPmHtjBdnGO916KiBUX22tI3LOUjNC9BWtKnrp305kpBsU+sMvA20l1chUWmVDbpJSlwjOmq/jkwkTVgad12CfZMgU+OIjDsrNiHx3OED2VtqoP487cBqCzSyldsDJ3jzi9l0Tjf7RBmpu8FWZoveB3z0c/jssyS+SISifSKXh6CeghgcvbgsgmbH8GLsok8dRSMdNKiLE37GU5iB957NleH7WYrRRxwZU777rqGlKt/dYpz4a6DpTXc27T/U5uckjLB6nxrxxtjglUrSXM3iGYQiOPe5U5cWpNo/GZcmygZeGcY+b7YFKiFKgvr781+/Oqyt7wmbPG/YZCLbOeDC2VgaeW034/ujUk5CyyJ3ECcvdQUmnmsJAZEjw2itvbjgTgJuCaO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44428a68-83c9-4a6f-8f4b-08dcc6cfc3c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 19:38:02.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScfLCG/8yeLeh175LfQ2NQmuliM6s102JqgXmnDK7tYTjG+R5uW6RBRoKB2jEo9AEhwZPfZgfT/jUlZxaFf5kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270147
X-Proofpoint-GUID: hClR3_qL_RsdncZF75NCGFa1Omoz-_Jv
X-Proofpoint-ORIG-GUID: hClR3_qL_RsdncZF75NCGFa1Omoz-_Jv

* syzbot <syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com> [240827 13:28]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    94ede2a3e913 profiling: remove stale percpu flip buffer va..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=122f6d9d980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3bca0d9eb36e75bc36ed
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e10dde6d5041/disk-94ede2a3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3bda8d01811d/vmlinux-94ede2a3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/653dc61d9ae6/bzImage-94ede2a3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com
> 
> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> BUG: unable to handle page fault for address: ffffea000169a5c0
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0011) - permissions violation
> PGD 13fff7067 P4D 13fff7067 PUD 13fff6067 PMD 800000013d4001e3 
> Oops: Oops: 0011 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 6910 Comm: syz.0.357 Not tainted 6.11.0-rc1-syzkaller-00043-g94ede2a3e913 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> RIP: 0010:0xffffea000169a5c0
> Code: ad de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 24 00 24 00 00 00 00 00 ff ff ff fd 01 00 00 00 01 e8 e4 2c 80 88 ff ff <00> 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00 22 01 00 00 00 00
> RSP: 0018:ffffc90002e0f8f8 EFLAGS: 00010286
> RAX: 1ffff1100be13426 RBX: ffff88805f09a130 RCX: dffffc0000000000
> RDX: ffff88807f842600 RSI: 0000000000000002 RDI: ffff88805f09a120
> RBP: ffffc90002e0fa30 R08: ffff88802b3aecc7 R09: 1ffff11005675d98
> R10: dffffc0000000000 R11: ffffea000169a5c0 R12: ffff88807f842600
> R13: ffff88805f09a120 R14: ffff88802b3aed50 R15: ffff88802b3aecb8
> FS:  00007f32016ce6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffea000169a5c0 CR3: 000000005af9c000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  mmap_region+0x1891/0x2090 mm/mmap.c:3058
>  do_mmap+0x8f9/0x1010 mm/mmap.c:1468
>  vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
>  ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f3200977299
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f32016ce048 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007f3200b06058 RCX: 00007f3200977299
> RDX: 0000000000000001 RSI: 0000000000003000 RDI: 0000000020000000
> RBP: 00007f32009e48e6 R08: 0000000000000012 R09: 0000000000000000
> R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007f3200b06058 R15: 00007ffebfee75d8
>  </TASK>
> Modules linked in:
> CR2: ffffea000169a5c0
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:0xffffea000169a5c0
> Code: ad de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 24 00 24 00 00 00 00 00 ff ff ff fd 01 00 00 00 01 e8 e4 2c 80 88 ff ff <00> 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00 22 01 00 00 00 00
> RSP: 0018:ffffc90002e0f8f8 EFLAGS: 00010286
> RAX: 1ffff1100be13426 RBX: ffff88805f09a130 RCX: dffffc0000000000
> RDX: ffff88807f842600 RSI: 0000000000000002 RDI: ffff88805f09a120
> RBP: ffffc90002e0fa30 R08: ffff88802b3aecc7 R09: 1ffff11005675d98
> R10: dffffc0000000000 R11: ffffea000169a5c0 R12: ffff88807f842600
> R13: ffff88805f09a120 R14: ffff88802b3aed50 R15: ffff88802b3aecb8
> FS:  00007f32016ce6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffea000169a5c0 CR3: 000000005af9c000 CR4: 0000000000350ef0
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz test: git://git.infradead.org/users/jedix/linux-maple.git 71e79d60d610967946f5b5a9fe12dd239216ac39

> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

