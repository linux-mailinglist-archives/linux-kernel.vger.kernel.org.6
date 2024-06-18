Return-Path: <linux-kernel+bounces-220179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6039890DDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D01D1C22F81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C261779A4;
	Tue, 18 Jun 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FG6k9Uwa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XbG9BM5B"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322C16CD09
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743758; cv=fail; b=ZtRC6MFWCsVFxqyJoOju9bHpbF7zmMeccYeP1Uo/aNdHEGM/sE1tZ4chUAPifGaljj+YwCZxY55n+uMLWTo+S0PC74ofT8kvcqcEaosnOna3nlBpMXV6d+i2NblUSYFcYY3obvGnb4yLzOT5cSiGQVmgRnMzf/ocXyMUf8wGQ8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743758; c=relaxed/simple;
	bh=ST7RjA1757oP3mnWVaqzIsyW+k2ojnxrn3YJexLpQHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YU1f0IBaEXhQuRg4C4sDwnA9ghrKZ4pLa8ALgWWYFp1VG0p71fymiy0i0ufgQ9ZsvXdfAC5uVxWUl0AvnBJNsMLAiLYs/49KjokvA5rD6Du+/Jdq9Vya1POavoZyIB2SIQZaPyAxYyCziF2ocNK2aWsj9u/tPzOahlxYyIj+1Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FG6k9Uwa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XbG9BM5B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUo8t005340;
	Tue, 18 Jun 2024 20:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=el5ueonE5eHDyr6MvVbtDd9ySKkILxBK0XuP/xFLbgs=; b=
	FG6k9Uwaf9kB7QlVt+n/jSuMSh5mG9AWKE3KCk2N+wNXzoElNCuLvn9TBaHEe/v3
	JLkNMuT5hY31qPKnePxoGhsb1zgA24uZids+AHfVdqSrmpPS6W8x1zSg+C4TG/zR
	4350a89XaYncLWT5pxjey6Fj5pDmtblD5OT8nK/qJPBlsVnzlI98JBwmJBeMoy8w
	fpBQe6Pu25KRcpSWbKrmvW7RyAOfP5t6MBVvNG0NHC2OJzCvEODOBRj9Hvzdsnjx
	9z26XxEVckYP6xY/uflF9fH9FaQ33y4zZx0UzC/KOXp468a2W+xa79K9cnI7/t63
	qj0GsRA6uG6BUYZRmsFq0g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1j05xak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIP034656;
	Tue, 18 Jun 2024 20:48:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTJ8c347CSxsDONkfWIAoCRhVS5VzDMmbuszDzI4B32JDff3gYJQQUR8dzyHgt5wkT/vfeNFMdLJctCuzjO6VJp4HTlQW5TgPLaH72CInZRe440/plug/x2TP2BiTSKfqo6LxAYZaJiYQXH1ZLlraKSgm4x3OpqDxPeeMrzyCUpZNVCqhb4yLYSTCDXa5YL28YhWOpwx0c5AHvEb1aJTitto7Ln+RrMsGchuarnugYDkvccWw1QPd0k/jnerOBeVrmDzQpQ1/o4j/lnA7hNntIgR+V1Nd+w++wgyHrXyAfcSq1hYZDAQiKoJ2YylXlm2qe1RpotWZShUSpRNN89X0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=el5ueonE5eHDyr6MvVbtDd9ySKkILxBK0XuP/xFLbgs=;
 b=hECkrkAujLcth/arq35Q2asOlQf3BXTNdJARRWvkbtsaW01vlQnuEhxn7u561nPyy/la9FN9BtaY25tMfT+udmF7QDc0lkKkkAXRU0vYzAGL1RhXz+EU+ZkklNnWEoqGM+fA/Am8iE/ou2lIQ4x4E1TZZ5ofpgZ0agwlvsVTH/IWFMHO0n69/V5MU4ZHMPHBgNIMoHhgrjPYHwaKUnLMOMA+J4NZY9aTHteO9kwF8Oy2OvsgVS10gAoiLUgH1jTiQEQrPSA0ZOzW71qT9AM1FSaXPGZJafXsl/geZAdxRJJtz+97dnO1B7NkCn6XYsVYy0HQjQJeIyCEgwSsATBmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el5ueonE5eHDyr6MvVbtDd9ySKkILxBK0XuP/xFLbgs=;
 b=XbG9BM5BoeUph/j98JcN44xVx7RhEZIXzPRPHl1NQzwhPtYVx4YtnMFVa1d2uqTu9mykqZtPYvlADR+UhXwvXz8fsqsSmOSyRdlJrGwPE2U6pZb/QJrGP6x2h0Zkk/9M2M0n2yXEYqFTkvJSclhH8+rSYOV2/jRM0vUkIgXCAYM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:14 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:13 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 07/16] maple_tree: use mas_store_gfp() in mtree_store_range()
Date: Tue, 18 Jun 2024 13:47:41 -0700
Message-ID: <20240618204750.79512-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0132.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b66b9c-744b-42b0-a391-08dc8fd7f8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?++nzijU9/ef7KT0K7xWVvTYV78MsXFNebwyQiXC4f85R9MRTH1YISNUFYjN4?=
 =?us-ascii?Q?ja/B1xxDQDrZmJjjz5E3gyuH4GHIE/oLVlWRgRGifCXGksk1W1oBbjDs6mkz?=
 =?us-ascii?Q?S487zCtyIuzsqjXim7YhSy0+s7/nGVuXx1oMfAU1z+whnXDE5jI6PfzNhJ9o?=
 =?us-ascii?Q?VQlP0VHBOY6xYE5dTXR4VDV6EXnS/tUujsbzwUZ56LXasXtG02T1U7IVoY2t?=
 =?us-ascii?Q?rmVaBMT781JwA0LqYhxwfnQaGosmBEvOg5EE1FNwrjE5Q5sPhD7MHiHf5j9e?=
 =?us-ascii?Q?1RX/g9cTnRU92RZH8pjfJeA7q+n1I9MMXB24AEMt1NrNyGzeRD73NG7KkZ8a?=
 =?us-ascii?Q?/sf/d9I2C3+HBQmIqmJILko+Cg/eSlfBEMZGG/n030qT7wNcmK5HI+sCAVNw?=
 =?us-ascii?Q?gHRQNSUxVi5B/RO75cit4RslZvA1t8YIyS+y7NEfCO2yytUDN9UPCvmXjESd?=
 =?us-ascii?Q?xxmtIcsiCVBFUH0d7PlRSBbTtu3IYWO4OrHB5nIqssrr76xxD9K3psKoOwtC?=
 =?us-ascii?Q?Qw+b/4nCrvmJSbBCVTxyUitwVotj4vd4rKYPxIVDaRVmS1vszYHjM+j+9m+Q?=
 =?us-ascii?Q?qNd03kFaZKRwlcRBLraGgO8QqS4qX+V/Yw4tHjzjn6yqV8KPKVUaeQOqzSFq?=
 =?us-ascii?Q?z9xR91gLoEYq033aZzXCBB5cSIHQq76rLfLQ3WQhOCR55tkA2x70Mfr+dkK4?=
 =?us-ascii?Q?AWUvcOzlxMzOLz/Nhw2jIS68AMKr+ns00NiXZrpDFk83GVxnjUB6uAWqSUC6?=
 =?us-ascii?Q?j+H/gV7BN8xB1NQaQRsVRiWGjBuFoRtEOihjdgO8YjjCp5BujVM9NWd6rxbE?=
 =?us-ascii?Q?ICDG8IksiuMyq+IoQEii8aT3bfMuSmMzzMpg7PyvxjPWmQJqWiavadrc8xl4?=
 =?us-ascii?Q?fpCfFoTjwiIyVJgJmQDNIezebcVDQ/zC2KkDBCY8TFR/cgmIJxEjBJLC+YuZ?=
 =?us-ascii?Q?z+rRAHTq4Z94a8CqPvinzFqREQSUcT7ySHFJj/M/7tBqFPJERbT6hg4P/efU?=
 =?us-ascii?Q?vwxYFlkPIAifOAGb3rsuWsGgVv3kY9b+O/yVzy+ArVVWfDSpnXrYEa+8AMbX?=
 =?us-ascii?Q?2whZVhzz94Tbrc7FWMEyPJiKSFDmV0mi3LEYDV5aHvUxRlYwybgDIB7alnNe?=
 =?us-ascii?Q?pFs2/V/DNkNEIjk2PVnQuzDV96vljkFPNOitFk4WMIGx4JPGedrJWv7eve7Q?=
 =?us-ascii?Q?h4G0kmxrB6FLyBU7jEtXfGAsqO2W3BhL/L2oNoKN84Ii0CAwfbMG0ET6pSKL?=
 =?us-ascii?Q?4pU6sX+fdyvYrVUQjlk34fJAR5PAKNsl3LOH18xN2ssIJMmznY3TjNqpfz4m?=
 =?us-ascii?Q?wzOiU71iziI0JvX3PGtpf7tn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vn78TyD7l7VM6d2p2TYJPsLLv2STDYw3XNs/KggDeFLBJra1L2K4Y4fs2f2c?=
 =?us-ascii?Q?+hF/bCNhXUyvU4brn8PgavEq0jRnof+BulhM9q1HTqZFbqg24kAgC3B9SOge?=
 =?us-ascii?Q?YPy+pW5J8ItnBqAMO4dyTmAeJXFoRk1SolNOBkDE3D3P6pf6esMLACOqWHmQ?=
 =?us-ascii?Q?3tb+lxRbWAmNZbWK6X8NW9IGlC7vlNeABZ1KzoYhdqbfFJ6P4IUHLWC3vvMd?=
 =?us-ascii?Q?uQS7Xz9qTzwuhdZOi+hRZXlgNQ98rSALk85GDHGFoy56mSu7coZ/gELoJ51u?=
 =?us-ascii?Q?54VSVrygtZvMlBR6nI3rkoS25PYz1xzmST/HKN8ihMwLjCI3baIus+AsW2UE?=
 =?us-ascii?Q?pUMAqOytglk8/Icg8Y8pi2O4w7ZiCg/KULkBA+rz82XpDoY+VYRsGU5uuoiC?=
 =?us-ascii?Q?wDgaEBw3YBZhXZDYAJJ6TNv5vUXmMfZecdc835UCmAhFemaNnM8kQ7HkUN02?=
 =?us-ascii?Q?r2f9gK6EzuhLe2Zf3yxhfsKBWxpUe286C5KeS5xw1Qym7xoTPDCh+f05w85j?=
 =?us-ascii?Q?Tn1Aia118kVzUqEZ1hw/VsQQX8QxgTqDzNQZe1POecXOVYxQeBOvfrbkm1w9?=
 =?us-ascii?Q?fd0Bmjb9gdzM3h4RQk3pELnhtuakTdhuf430/tpAJpb6OH6WI8aqltUKJ2bU?=
 =?us-ascii?Q?0qdOnfBWWW+nbV5kPq8nW3oR1kBAUPsmeQxyp1vVR+ihXnBHXeyRwohWU/Ec?=
 =?us-ascii?Q?iTLg9PG3izJ1euStUOEIgxuYgvRxSIvieQ0XfEsQDO8NOeZCuNV46v2JqQ2x?=
 =?us-ascii?Q?BajHrOx2V/MxIllPOBVC7RgxWkfYLGPKkcQ+pdhlveQEbyeI8GpC4CAz0ZSD?=
 =?us-ascii?Q?3nvv8ltzan+RWiNmASTtIDE9h5wzOEdzyzBW2EGmUVZUlxb4gH6Y0piwrJhE?=
 =?us-ascii?Q?5ww2XU1e/40B9DcvzfGLzomcd/88maUJKtrMvIbl6Dfp5JlTHIw0endSn2IP?=
 =?us-ascii?Q?h1LDmGH5UNOZOmGmOO86xtpPjDlspCZPnM0EAAs2VmuyJce+QtHU7uhHAdEC?=
 =?us-ascii?Q?h/SRstuwhIDAF7wkETh9prYD/3QBgtEa7nWfEdcEL9xQd+9ZG+Y5WCWZpen5?=
 =?us-ascii?Q?1TpN4lBMnd7AVxVBnNGmovZzvDgKuoSNNTtSh0OeppRsw3YLMBQzxm414DA0?=
 =?us-ascii?Q?Wek40aSZR6Nq8d33VBB9C+fI5TD40hQ1/ZAkoSLqX9zZpCILFDOXrMRPaoRa?=
 =?us-ascii?Q?M4hGDRkRSjyVeT/R8DD5aqo4NpsPWuSxfKOqAPUThsFERaMB2XqNTdPxaEL6?=
 =?us-ascii?Q?eLqRkn8DbFbTkwXRfHEMVr6Il9QhEnv/HG6S2lJxM4ql8qn2oJ6kT472aWTl?=
 =?us-ascii?Q?ReoUTfo4lSqn48rysn8rd3JB8PAv4pjdhkUnW7ETInIYrJM1KusQm0ZtCaKk?=
 =?us-ascii?Q?bi9NdBNuEl0FUHiPj0iSQOvw3l1UlJTFw9JmBugWkcaZh6HYAfX4MriC74JH?=
 =?us-ascii?Q?BH2NMeVhj/vOYFCz6DkBbDSSg3KGzC44f3kGvJkx7fcnuB44+ngIHn4H/PdA?=
 =?us-ascii?Q?/DE/ghx7x0odXkVkpPxSplZ3/GUKIvcbmK8TeBZrAFa9S59QbNseocgDD1O7?=
 =?us-ascii?Q?olWarxFZ9Gy2OLjDq7qAqurl+EeETMdq1EUHvsnHZTi3NLPB6z727iKpXDEv?=
 =?us-ascii?Q?qv1pXiNru3FXY4lKSeLFmnE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nLRystwl25DznRMfp1bsG1oR9JoILRXXTCeVsoN4poOxf/TT1bPoTk2izDV4Emh2W7xxMHpNdb4EStfEoCYQHf+zOJV/E79OuMHhEEw/iQyO7km1E7mnJ9zs8FVJrIWZfWeBUIPw/HVep4F3BYxs3B/3W+pVh6BtAj01n3iMYsHg3iBUmo+I1EY8bZQZmsyEfA4Ao0z4mQMaom5iWDeFI66dkieBgoBdcFPNLaOnrkK2RbnYLwsT8NLkgIswBoOMZBI1VGafFxN7czqVbsFSDFcFa+tnx34CGslS7xwh6SRlZw/yP91rFGMcIjcD989r+vPPYbaGMK5Kit3MBSNzjKtjKbBESWCHIL89DbmIbwwbB5l8Ni7Aj5c5AkV6fLysFnkZIA6s9EGQzyvaAYtSaSN+qMn9MGWe2GwadUgAagd5UkRcM4LiCLYxhG2vFQxdcaDBXRIw4hJ5HPAbkOMnXN6hv6JTaK5zIvOFP3THh2Cy0aCMYAXqrc75uMWU69mEzon7/U1YueX2Hsm+q3mN0ou879pnAEJLD0XrGYpMRAeKNNup/07xaYrcXf1S1TCnJoZwzHRAd/q/zatGKq6FCXuJgDf9ix1huBRreYDpfSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b66b9c-744b-42b0-a391-08dc8fd7f8f3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:13.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6OUUu+P2lbqrgyJ3+FN9HorGK4daOPD1Q/eG4SfdGn+c/ImG7P6jf7htI8LGnH95YnMfhM2yPgnHmNgXLHG/giJd44nZqkRJ4mWj2nzvjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-GUID: A_wM7bQ-vCXsnCjLCHn3GjLEpQx3arRe
X-Proofpoint-ORIG-GUID: A_wM7bQ-vCXsnCjLCHn3GjLEpQx3arRe

Refactor mtree_store_range() to use mas_store_gfp() which will abstract
the store, memory allocation, and error handling.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 892e864d4c9f..ffff36e8b140 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6456,7 +6456,6 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		unsigned long last, void *entry, gfp_t gfp)
 {
 	MA_STATE(mas, mt, index, last);
-	MA_WR_STATE(wr_mas, &mas, entry);
 	int ret = 0;
 
 	trace_ma_write(__func__, &mas, 0, entry);
@@ -6467,17 +6466,10 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		return -EINVAL;
 
 	mtree_lock(mt);
-retry:
-	mas_wr_store_entry(&wr_mas);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
+	ret = mas_store_gfp(&mas, entry, gfp);
+	MT_BUG_ON(mas.tree, mas.store_type == wr_invalid);
 	mtree_unlock(mt);
 
-	if (mas_is_err(&mas))
-		ret = xa_err(mas.node);
-
-	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_store_range);
-- 
2.45.2


