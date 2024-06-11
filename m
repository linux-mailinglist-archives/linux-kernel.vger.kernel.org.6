Return-Path: <linux-kernel+bounces-210392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B83904314
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E7B1F249E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A374079;
	Tue, 11 Jun 2024 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NATksjLr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jWdPaTi9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71456770F2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128957; cv=fail; b=GHuTYPQmeWMz5mWW5dFn+jBoX1ecMypqk8eA7MXVjJljUzKG5nhSpC6eodlxXxUxOwNawHygK1B+tdYi70pIIlrFHhH+UDUVINeHXqVlW1zb6JHrVVzaOs6+9iCVVMO6lN+1z/m+b/gYGiwx31B+Ha/BLLYWHdnFFfKuQQt2pew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128957; c=relaxed/simple;
	bh=Msuz/RCBmvisxvjydI29R313HReBp+Wriic62eaj4dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FmNIHFD20LWnZcuBXW2hc4qgaDIZ1augO825IV2pvppJsLvenC66AagZFcLKjLMh+PBfFkw5Bo5O/EXpaBbqTbZE93eYrMsiM8e/u7xSyGo5GuOKKPF3bMajJcBE2iYcZwFNWkqrUo5miYTflJ5QIg156FAllJ+TqThc7waWN3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NATksjLr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jWdPaTi9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFo9Oq006260;
	Tue, 11 Jun 2024 18:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=KBA8tGw7rl5jw3L0KdGMb/amy720aBsEvlEZjXfGWp4=; b=
	NATksjLrfLoLYpQUrr1Q/gx5/DyDtR5vlIWnJj0jwg7L1dyEFk/0mgdnSb+XSNKf
	hM6mZgyGGrSNxaei1hmcI816WHhWraAonYyiBVgE+TpPan9AB+Kq4uO+1OHa1Ue7
	ZWac3AQCM8+z06Uk2kMfvato7HoMKGoIEgwH1BRUaZWbGxz7rLpLEeItijYcJhyJ
	jO2NgD3/YCPwdQuB48XbQ47HUPMfnLAc41NqBCi82NuIjlYYU1Ki+YMnO1ZhmGgU
	lMIKNzvvj230CNZ827GYZyDAUMmGBo5nCkwGl45MxgXys7bHrwNVjEjA+Dzm5GgK
	RvioMQsLD8GjCDV4bZHUiA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3p5ecv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BGjHfH019928;
	Tue, 11 Jun 2024 18:02:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8xjusx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gowg9d3noO3ZtNOMw0vltVwUS6hjiMcqflzqAQ0rJRUQeQozerhkJ8AvsD6kjNvaIwO3EqiqtOgOwXHRqeJfrA19n65yrA5rmJ/s0Irl3upFGUn75vkjjITBJ6mwljvvkjXdJHYTg0p74ceihx451ncsST5PxUHW7ayFql1O+PP8UHj5KOJR958Wi93qdwZKDw2i4o4uTVAiC+GXqW9GyPqbCqUXgq4QFnaFftxd8NmcqjNJphGQXnbpxT6zklwhLRpP11ml4/0OzXXd49C03OB8jsBZ0EfW/OGn9zwnBVAnUDrKttXGiJ7RoRsdH7HZDnjSDrXfTIEl29vfQAZcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBA8tGw7rl5jw3L0KdGMb/amy720aBsEvlEZjXfGWp4=;
 b=ZET3uc2QCOB6Dul29KJZFgQPY+3uy947SQYAm7uyCnRqro5Brz10DUqq2afW1QfiZZhXS6IISGvoUrVydrS3zM5NWVkRXscSuiJzz0TNuULsc838S4twXOQ3lnAtulti7dgxlPR6WEMJKMogsLRaqpqXmxMUI2cfC7lo/SY7z3pxsYXEMwXnlSFCX8AM2Bd2+GI+uXj22nrbBs7uugkuXrwImZP6YWqmemp/jQ1N8UNORS7U8EgrXVUK+gvXUkviWz0lJHbDa+675+LMVv7X1yv53mOljGxiPKc6wfzP8J659qv9C07w65+udcJaTsR8g8Cksj/MYm5PxqPDfrTtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBA8tGw7rl5jw3L0KdGMb/amy720aBsEvlEZjXfGWp4=;
 b=jWdPaTi9Js6tCs0xITIkrCcfoWFiLQwX8YfbcPwNzQJMLVldYCHAvaKwDmzQ3tICDk0dmDJpbIiy6UL/9atylie7b2N68MaWh6d1u1ehukhA0KCcESU29CKxFYlC9VjQLM0sMX4rPSoGLsqn2rvqOtJ7sTYVMr8sJay1JIC4DWA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:02:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:21 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 5/8] mm/mmap: Introduce vma_munmap_struct for use in munmap operations
Date: Tue, 11 Jun 2024 14:01:57 -0400
Message-ID: <20240611180200.711239-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611180200.711239-1-Liam.Howlett@oracle.com>
References: <20240611180200.711239-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c350ef5-baa7-4aaf-968f-08dc8a40a3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Eifz2AK6w1pnEwJ0i40szH3ifhIlJ5CLf3OJjiw42mbKC8LutphhbwI9LktR?=
 =?us-ascii?Q?EFNViaFH4PuQh60XehMly9JSXUsyxHsZ8JVcPNZSMADt0iX8w2vOj3Wo+o2p?=
 =?us-ascii?Q?atFacXyj06pCG40hCmhLK6cecuxDMONpnjmhvbxYExNC5LrlkSzJaG53yU9m?=
 =?us-ascii?Q?M1erto5ecmdvZGBihW7b4K9dp2xWUq2/FtD1eo9gMgml9BQD0ySQcCGC31q4?=
 =?us-ascii?Q?+OSrc3ssw0ihgWgy2pGajJdnNGPFI+b2cPE6j6MIg8HJNOVh1AsQpNHDcIlJ?=
 =?us-ascii?Q?ZxUqPjem5o3wyWhSsDBySjMVvJOV34GaZ/HNcwviIJLH+CWo9jM8OOY+wbWh?=
 =?us-ascii?Q?k2xdai3cszV6FE1or7WA58koWrVi0vRUxvGVhIYeW9QyxtHeawL0ZouiPSTV?=
 =?us-ascii?Q?XaqktVXqkteaW+tF2Pc6JzUVh2Sc2dTNMfWQZS3vSiKGyD+ZVZydbzGc7VsY?=
 =?us-ascii?Q?v/vqS6svHZm/rUgZQcxEpu0JRoXYn2jFJ5hZ03WBdikeiGr9wfcQrmlBRPWI?=
 =?us-ascii?Q?EGNaEFA4uAVDnhsWk7BRzKoHrMzAoDbg9tB4zKex4kF5K9lPYSHqHYmijdFE?=
 =?us-ascii?Q?bCfABO2dZmKyoF8fB5E2674AyYXUxZcFH3HuCsHA2hGLbMoRg28uCJc27w+B?=
 =?us-ascii?Q?xIFs7woLdUeh9aA9gDiY3ecCUVckwTGSBbDMIYI4RPIlRQyqoh+WhaHG/lat?=
 =?us-ascii?Q?DIoRgf2lCL+GvWK8YZx1hmn+alokinqyUmXsx5Q/DwSpm1OGZEcoyY771rid?=
 =?us-ascii?Q?gbj6Q/q2pOLLJcAE++VjCVFPN8p01DjbCkR5G36SR4VYd0Wu/J833PuoUcWg?=
 =?us-ascii?Q?RThPrR8+OGzqwcFgxC2AkQ/xRNwtQ2dulp4ur0IztO0esppfPNhJS0lMs9cu?=
 =?us-ascii?Q?7YQWwsRhz0j/7iARoAgnJe/z5F9NSCGKq5Pozb8y+Moi1oURlqJHZdF2K53Z?=
 =?us-ascii?Q?MrqrzTQX3StBp0zA+vRm16ErxH91FaV0gK+XqnK/hlZF9XszlpzWYrHLMFqg?=
 =?us-ascii?Q?wbUsoA4L8djKUffzftWr1h8d0THxvQHatA1FX2FY4Z65W24v297crtnZjjbG?=
 =?us-ascii?Q?KWRQ8jcGE0tUQsb6Br0QHAZvWRKORyemIKIkj11y/dLhN/y5Jcu5ff7yqlW1?=
 =?us-ascii?Q?UN/XOUcga3kiucOHc6G5ymzL/TYS0XU4G3vMHYWJV8VXORaEJ2cTLStbcmgQ?=
 =?us-ascii?Q?8nglHgGIXAA7w08Ix4GqiiSHlygy2/RtEE1aCB8Whh3Z7CzZLcDRckVXuV4v?=
 =?us-ascii?Q?WRJUopa4wVu3hGfw4EzJ1NL0vghyq/wFAMTWVR7WilW6OH1e+uqJJ98C6CZK?=
 =?us-ascii?Q?bYGoNfORtTfUz0R7q1VGo4lX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2IzT7YiMFhS8OGjrVvbDe8KRZ1njORfCBCYdzWYQ+QtHAm/c+XkxKGy80Df0?=
 =?us-ascii?Q?p/jhlbpTnbwbabNsY31qisrFrO1cPxPNWaPaNqE2dmMIZnrCk4q7fYLP5u0h?=
 =?us-ascii?Q?0cZGVsSlazZFwn2AwFGqkgjoYYmvAzJCvGLmLHNtnF8IgJRFIW9RVVTpPC0s?=
 =?us-ascii?Q?y/bu0Y+Ww/Hiv9ROeoCwvdRw8138o+V0Zbd0rXlKzZKf33AY5JL5HajAODeL?=
 =?us-ascii?Q?i2fOcx3odZYdNIeBnmxNJKeUKSXbLOc3fw45S6nu3yqrrepKF2A8S/hLoEkn?=
 =?us-ascii?Q?XiPd9eV32VxrQHyO7SfYzit0VitPxJmkJ7YqStIOJsDXcIWqrCFSVfXd9K5q?=
 =?us-ascii?Q?/E4b0dLsX24yjHmWwdqn1C4N5oCLkbIWjWqzygQot25VDvqASdtKbU1ZHC3P?=
 =?us-ascii?Q?leysbichIcUUhQgVa5E5EPkACYaGtS7QTLB7oQEkEgE2+ObNuSi8ufExbK/e?=
 =?us-ascii?Q?cYlNKPGr09P3S7nPUN81VHZGCGquO6Z7yTd5bAB32h00mAzO4IuS1yizc/Ng?=
 =?us-ascii?Q?ypu5rvCbybWYlY1ucJ153hRjkgucs6yMIohZZkLkOHQwhOq0ei/6a9d0w8n3?=
 =?us-ascii?Q?Sz1vJCkefW0ywdALFfdhqjp9bSp9Xs/grJD0GDIufI9Q/U+fwvyS4AHApt5r?=
 =?us-ascii?Q?MAV6JPiMf46DqR79DDUJp/SVBwu1SH19f57MftALJf7d0fXEVQVvZm7fZWd+?=
 =?us-ascii?Q?SHXnXXWXdTZYKOcwvyAcZgApZk7nKyvLFcLpEaOwtDt0kKaPrRCWtdEgt48n?=
 =?us-ascii?Q?fVkzuRzDOjMJwx0WpHfyX23Kdn2ErY8NgLuIGUo/Wqhtf8a/e7DPuskvDLpG?=
 =?us-ascii?Q?Bm7z5My8bWFm1rqGgJ+JQhfsamifOpwZoUvCWDy1CcPbXoUk7bc7y4KMiQdj?=
 =?us-ascii?Q?sPApTGpN1fLJRryaNOQzGmeaLRTe5jWpyFPbmvR+O5ZCp7OGIFw0Rgr9SfBj?=
 =?us-ascii?Q?CZukjTOxaWy3xaBBLqdZxUU1KtOTR2uCMNCPh/Ns2rSK3Kmi65bUb9iEcuvy?=
 =?us-ascii?Q?Z2xIhRm9IuxM6vBvdYzQIFueFQ6vVtLYF7T5za+15nAI86DMubNIECk0+EyC?=
 =?us-ascii?Q?bxi5h0txczDY865YAAD7aI5uEYY0o+MH8hmf0emF1VmpCHa1YdEQkWGLaIj7?=
 =?us-ascii?Q?2adAyCC18nx9RB3NX0SPb4X6e5Ho98XNNUQ/aGyD6bA4N4fVvjLz7qHtxrEu?=
 =?us-ascii?Q?PsjV1ceNBF8pul16TvLaJ6ZTWWu5FI+EzJZsPZkqDKcYWviuECgyzphNLX9c?=
 =?us-ascii?Q?sRDvow84KRUq8OXXnpFSpQq/NaONWnGJkC76PD6ik73SfgjcQ8g4TlrRMs8C?=
 =?us-ascii?Q?rK5bde80lsy9Nw9eQGhw7XLpZ5k/USJZmQtT1rV+pkB162kj00l4QcuCKBXv?=
 =?us-ascii?Q?4aM1Em+kQXZetfw60NW2xGSRQkGc3NwXoRUu5LLTXz4tF/oZhAfQ7aAKkLMm?=
 =?us-ascii?Q?lsZj8WpCdbltQqZnJBSzLLAsdIunHmXqZPiXEM3HUc48LrZ2c/BPjmcwxTZ5?=
 =?us-ascii?Q?fYRVLXfgfrIJhNeDllZwYAyaSxOefSvs9dFa5raG2eLaRuVWmJAWjiWGveWF?=
 =?us-ascii?Q?QFH/dUeEqqrofnZvbC+5WTCbEIOt5pZmOWdAsPKp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p1+K1sGG374JkDHRuu9pWQcZQsY/sPevC5xdax3F6vvhnLlqd5YFuqtiXIpsfVtemMPe1wtXUP/NUIm4/7P2gidD5zXbstX+uyzknU0e/IxKzHXH9gN+UiIag3vp92G1lLYJCbs1xdckz8GYTOKQOZScArs6LTxztyJP7YTeECSmZOQ5cs/qFQknhf/hfCDijQ7Y4fusfKaBrWB/X3r2sh4XCyJf6PGX6FFEn4euG9OaJQgAqDWCfACUbZV6hHwivSMF8gyK/6wVwNWxFEkZ4hB1QYVudg7Hz28wBG29GFGdojOdWwOpADOYUDmlUeC0ntuIEDp9lzIMrL2OiytjxkWHT2tC/NVVdj6wx5d6iy6QwXrDOx9ZtDVaN26ZH+51YXF765KPmT+n5TCgcUzDjVpsbYp1palLrCHNTK9zZZxfpBuAOJdXBmzTwENtW04ROLdsLqtRpJEAJXANZjDGQ227GaF2pW1Foo6hFyYyL/YTsoQ1sYiP6mP+gLxDf4UHPSdOCBD2enmox6Sf+emy9Q+jmKaeXG+lc9LuGhq9Deg920K9AUrNK29vSjdBtEyFmh3GOg0GIZ/9+aMZ6WlmmEDoidimlIoZ+wkciZ81P/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c350ef5-baa7-4aaf-968f-08dc8a40a3ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:21.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4xqKB+RvJPlZoOv8HRg/wjRZCwEv+sZqoUvCnzXuoljDUydxds4Y4Q4LldB8+h9s4WN69k+Yw9hHGo7xloWkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110123
X-Proofpoint-GUID: UniNJZxVF_UX5RQbU53Tvvbu4bB0hwWI
X-Proofpoint-ORIG-GUID: UniNJZxVF_UX5RQbU53Tvvbu4bB0hwWI

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/internal.h |  16 ++++++
 mm/mmap.c     | 137 ++++++++++++++++++++++++++------------------------
 2 files changed, 88 insertions(+), 65 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..6ebf77853d68 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1428,6 +1428,22 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct list_head *uf;		/* Userfaultfd list_head */
+	unsigned long start;		/* Aligned start addr */
+	unsigned long end;		/* Aligned end addr */
+	int vma_count;			/* Number of vmas that will be removed */
+	unsigned long nr_pages;		/* Number of pages being removed */
+	unsigned long locked_vm;	/* Number of locked pages */
+	bool unlock;			/* Unlock after the munmap */
+};
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index fbd36a8cb031..374cf89f0c30 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -459,6 +459,31 @@ static inline void init_vma_prep(struct vma_prepare *vp,
 	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = 0;
+}
 
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
@@ -2565,78 +2590,59 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
- *
- * This function updates the mm_struct, unmaps the region, frees the resources
- * used for the munmap() and may downgrade the lock - if requested.  Everything
- * needed to be done once the vma maple tree is updated.
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start,
-		unsigned long end, bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;
 
-	count = mas_detach->index + 1;
-	mm->map_count -= count;
-	mm->locked_vm -= locked_vm;
-	if (unlock)
+	mm = vms->mm;
+	mm->map_count -= vms->vma_count;
+	mm->locked_vm -= vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
+	prev = vma_iter_prev_range(vms->vmi);
+	next = vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);
 
 	__mt_destroy(mas_detach->tree);
 }
 
 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
-	int count = 0;
 	int error = -ENOMEM;
 
 	/*
@@ -2648,17 +2654,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 
 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {
 
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -2667,24 +2674,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -2694,16 +2701,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+			error = userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);
 
 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2712,21 +2720,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test = mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, count - 1);
+			vma_test = mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count != test_count);
+		BUG_ON(vms->vma_count != test_count);
 	}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);
 
 	return 0;
 
@@ -2762,11 +2770,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm = 0;
 
-	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
 
@@ -2775,8 +2783,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


