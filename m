Return-Path: <linux-kernel+bounces-206631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B0B900C22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8983B23CF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A762C16A39F;
	Fri,  7 Jun 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHrlq8kZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wWKRoBXq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F041667EF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786479; cv=fail; b=ixVAVwg0MMvE4RN1hG+JpL+G/jjz+/psQSMqvFX8jc+v2CQScZM9l2aZJXTdy5ojnYLMxIiyGxcGHvkmgA6FbWYWBbff1fcthock91VGotWDU9eq9IjHAVF/UUhYP6n23hLoUX0n+CCbTZPHf3wWanqrt7e6bMvMw/8sT+/qoaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786479; c=relaxed/simple;
	bh=DPb2SZTAaw2v388KHNC082K38CH7Mq6Dl18EIiLow6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgLC4oiVpv3+4hvZD0W4LST3QfvHK+bKORYLWszNYFEAiwJrbsIMQmOT1C4Z7Zl0Z6mt0bQA/Kt4XYS/gQ30LtS1Ni9if1XiHcvd6XCGVmUYnUkHv28kdyjLJ9tCaHUV+LwFiRHkYyTLMxXG7b+ZY+9/0kgdMwa91pZN4vEFO08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MHrlq8kZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wWKRoBXq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuVi8023604;
	Fri, 7 Jun 2024 18:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=tFwzT4b7TDN8LupwfhTxyMGZTb5M4uMCFAvDfp7nMBc=;
 b=MHrlq8kZ4mlfKiCX6SQYeRN7RZFKeUlLf3iFZB7FKUx7GYSxpOd6YLl8B00M6qjGBMNB
 se/R2SBcwVhM34nzUEp90PyyMRo98YPRKQ7u8XWK5fyFvgnSdP7jWTA1zGSb5YvB5dNJ
 5X0ZjITvdUo0x9wFBKZ0mMtUeZpbpA+rXXAvt3Ry7U3q1tqyHZO4uODM7LINSAtGgYJo
 FMt6jpCYYD3Lyq5Md/lLerusiGkwmphYXLFsElFcX8HXPoK6HgsRudzVldFF5w1fGg+y
 pS3RefKynBtCGr9ga1hTValpcL0Ix3dWekIDcCeJ7vPRMzSrI7VMfM7ti6EnBsKs0WDN oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrse5mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457HKoA5016160;
	Fri, 7 Jun 2024 18:54:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrseudmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O56hIkUdAA0GLLxTLFoUehIW4laKjHx/RMGrgNvvJgQaBeZnvkTw35pUZBNVMxynl2vcEljZDSjal4bVNPE9KnNQUFd2gezCWLs2Zuk8s73u56fLA6ZBtrsU3VNNzxqwd6FnCgew027PTjefWWOjCvBZEcBMAf3foX6QBa2C1jhAKaEc+9iJ7IIDr2Cegr5/URq0FDpbFQN3acJYARvktBTFBwohMIZn4GteKIrtgQbegJHTtKXphW0CzzxocQBcpwt4vsBADs5Anaa7xskwPD7OC8HUyJBXFPOe+hIocZrb+u3gvvnhdOU8GEuFpr6frEBfsSeVHrLtl5NDn2E+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFwzT4b7TDN8LupwfhTxyMGZTb5M4uMCFAvDfp7nMBc=;
 b=R2KiCHrArWo296Hv4+E1zIpwuVITu1mjPHtXSUQ/NaHJ52vevCvEntXMf7JFNSoSuBslApumUefMU2yO00UwXTTK87T3NGLwxFq2sqsM3MxzBQocO0bWNaThpGIxJQ7R8+9f1ltGBmLd7JTvbRGjN33bFML00piccPfWS7a8RTbOb33B3e5LjTNlJxHMkOFSipN5IZtEB4tSb3qbevPBGp5n//UH5IDrEiOjBUUsHATHCiAZwT4o0e28QXb8XlmqZlMalaueFfNuU/YXv8pYabTGIxWZvy71t1zA0xZAyEkTJBnwxccMnxV7cIlWTKvXZ79P7SI1LtusLma+bniy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFwzT4b7TDN8LupwfhTxyMGZTb5M4uMCFAvDfp7nMBc=;
 b=wWKRoBXqdalL4CQtdLCH2OZyTXh4UiRtBtQ+nEMM/4loXm3NsusoFmLvJ2HKaBbQBqtfrzXaUohUXid6P7QnSGTzr9tzF7mdHMyA7cq+l64Pcatd72BxSTrBGPLOh5ka5Yft5mnKdidBtHOc+4v/BdYg3TEct/nOd/AgwyBn2iY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 18:53:44 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:43 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 13/16] maple_tree: have mas_store() allocate nodes if needed
Date: Fri,  7 Jun 2024 11:52:54 -0700
Message-ID: <20240607185257.963768-14-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5fd1d0-3b0e-46ff-0e86-08dc87232671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?R3jJnELtoj6iyAPX1kl5kpii/V95z6McDsyztJVlAGJ+x+fQa0hmDOnEO8of?=
 =?us-ascii?Q?KrVn1V1EWnETtRrAVjLOXFAdhoacfv9tpfwNPXhGKX7E72X3ngBc0cjoOYJb?=
 =?us-ascii?Q?6fY8EWwl7WyGU0Sc7sZxHbA2TmK7XUPunBe2iTI3YvShsqLkbON44G6uFRMG?=
 =?us-ascii?Q?vMH1Ytw76El/w9rOuqFmpNv8gz1qrGzJzdhsALrfzRM9hV4CXWocOHFBpq7o?=
 =?us-ascii?Q?UPos98TUpXe/d1Y/J1ff7DmjRDYrOtfLOUZEqtSWWE5JGF0jlcsrqNzWamGz?=
 =?us-ascii?Q?uJEfXrHI5NiwGI/n473EtK+QpeyvAfQEaTHJXfDDZVhJjw22H37MVARuiqkk?=
 =?us-ascii?Q?S2P+DwC3SQvC+U0u5btcbZw6OF6LyFZULkyIhIdsSgLFrRcS1xpEPd98mLoY?=
 =?us-ascii?Q?wbXJ7JVAuISLAWY5IWESSI896bLGYvWyHoctEDZnazTMRuJX4wt6Pj/4mBsu?=
 =?us-ascii?Q?+yYEnupSjT/sEnc9cwmL5zXRViFQdYV7Gg7fga+LQXvzZjArgi/lhgZ2jfQ3?=
 =?us-ascii?Q?4W15v7GpYLzaRZgCfNAs2XzL8k40akDOYLYeWXcY3UzbKISQQJxHdjITBK7d?=
 =?us-ascii?Q?fCln60kMhZA5ADf6rvMIFiagKY2e+8dF4ZAzS2RSN/shVoTBaoTLTpF6b7EU?=
 =?us-ascii?Q?dHvVQ627PI9n7AwlZ11Jurj/93MshgQJGmtAe+VNwQuGKe4XDpqs9II51wPM?=
 =?us-ascii?Q?SL5NBCByA7QGYawj0rWgMhaiGKjzBZt3sNdEYC4tx4/LwGszUYZgQr78tJ6H?=
 =?us-ascii?Q?pWNAeKIZWqbJFRPg1tj5I0GREF2CaHxhLQ0bK+D2I5/3C4m7FxLbN9ka44uS?=
 =?us-ascii?Q?9X5XXd4V4q/htxg1tk3hbqVfOv0Zn9YFHSuBnJ1tD3C2TkjrZ2ccVqD+Q5Ja?=
 =?us-ascii?Q?XpEV1mLnVLtF4ayUOtKHTzx4bzpdaSdlDH5NnIn5Hq1X5tWrCez5ey/LkZM0?=
 =?us-ascii?Q?82SGyFHA2wbdU47h8TLtfzBmPUPpZ0yECkWaoqWT2vFrBa7BOAlJVS1EwLtx?=
 =?us-ascii?Q?tVMWoH+7LQ7N1QbpyJh7X1p1Fyj87jWEwMTwsThMgKlDCBEZi7rzObUIe7JE?=
 =?us-ascii?Q?mhE3cxCMpL0CEoYAIiN7de6F24e+hXxu418SB7ofSWR9VWZd6qbrO4Pd4kf8?=
 =?us-ascii?Q?fEEXhZLFBa70VFOrG3qtr54NG30122u31E3LWIcNaMqVAW4Ml+L2bNKQ0SV3?=
 =?us-ascii?Q?lPbbwxTZplJ6B0bz0pC5NA7D0ATtht9p1siZyJiABRYU36aw+r1jab5B1xJJ?=
 =?us-ascii?Q?tMRjEOEXvgQz/yaMMJtNzpMZ+lKUVHoJW/JbZn0OADsQ1AKj6xklkvugA62P?=
 =?us-ascii?Q?7+Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UAkL086aNNkJBVJ6KNlYuk7wJPuOLFlzsEkiqUKJrhmDC5qFy+Owabgn6Nt7?=
 =?us-ascii?Q?619FAvy3gslew2Am9dQ74jUWUY4dnX1YPnSs9AZF+0Ui6DIpDdGY1vtIvSQF?=
 =?us-ascii?Q?OMRE2jDyD2sXtML8jmn9iGDxuuLDMakWJsTw97nC3plVjy3Wu3U5/DdW6zv4?=
 =?us-ascii?Q?WLwvvX0hWS/dpH1if7/RUs52AhU/hBg/ThdqLO0AUDvOwu3DrBX66ZMenRSx?=
 =?us-ascii?Q?17SF1CZi3q8C8KYNMHOiwP7XWWt2q4obeNkHZIrcKR9x6qrBHdrXa9Nvk/QR?=
 =?us-ascii?Q?V9mfW5Xr3t2Qbo/X13QWnm5Xj+4URogKrbd6Y93WcvVV//ocG81sWYwRmW8m?=
 =?us-ascii?Q?FxSXJE9S52kqS11ZXlhk2bkDko/dYjmzP+tIBMn8P2o+dJnxGv8VSFoy94rV?=
 =?us-ascii?Q?547h1+GhIZwnm0zQ0Hukm6DWAnrxHL5ywBtrXGtkLfWQ01SpGv/rv/RYnXTv?=
 =?us-ascii?Q?itLG6VvQJKFKx3aEhP6VQqvWSr9awqnjOqux/rrPggXo9Km5ws37M8ah7Qvk?=
 =?us-ascii?Q?FgAsCGhR+8C4lZqbaE9VcPZ5Y0QXY5DiHASAI/9R9mlebZeJrplMsBRiOIL3?=
 =?us-ascii?Q?bCLT89LBrc39gAxNY0Jf+MhbD3IrPWowc1W1PI/2Dt2/V5+Je4+Ab7eAOKU6?=
 =?us-ascii?Q?9g9mo94LMS7iOKzIWNngzez8+HU4XEYtIsnt6snaDQ57ZPNVnFYY2Z85QJIG?=
 =?us-ascii?Q?XH7Z8ujyvoGot7QXXcYKnfGgrvPGu9HxDlo5kuDvqIGv/ujtA0JR+9nWlYRY?=
 =?us-ascii?Q?8C/cuBTy9Cmfs4eUXMMO7nzxx2SSIKFI8KJVjJLOS+aJYlaVlPVulirMt1Wb?=
 =?us-ascii?Q?xwLsHFy5uVrMgCVxcr0JQhKq6SqLyq7bToz4c2n17Fq7IAublKpCJVKCa3Sv?=
 =?us-ascii?Q?euQ/VDPZhoVn05hhRdNOTIOqn06Cf/EzMLqw6PWb9eWySTczAD/loHTrhU3e?=
 =?us-ascii?Q?wlnl0pheX2IR/rOnQJbUdFes9+Ip0VGKq3EAXn3cx66l7rKQ26fzF9ipppvB?=
 =?us-ascii?Q?uRWh6cp/IytLSLbuoCqoyEloYkK13qG9WRYt3p7/RBj0Fh3VriLCBRGzBVCt?=
 =?us-ascii?Q?lrsYoq0EKddWmUQLTnxfXJrdbIQbCKq0ezqol2KQS8nKwU+lkGfSSCv9d90Q?=
 =?us-ascii?Q?6kmgJ/bRoLFavOSCU5n12bfvcbR1ef0SrDNqc/o90Kq8Z7zlFhk7LrmX/jm5?=
 =?us-ascii?Q?lfg/Ox8CnvkPKQsnHJwO14OQZHbmFJcToccdW9065n4WLJE8ovRDuuLix5Vg?=
 =?us-ascii?Q?PRD0ccJ2NmFIXIkw6aSEZ6pTfoahQHrL8euxhScspR/d2o6Ly93zGWP5+nf+?=
 =?us-ascii?Q?zp8bqI2J4PxPbb1LcF35n/o0cfqWQPSgMiNz28xoBYELILmwR/JYXFhTS1sK?=
 =?us-ascii?Q?EAGKKDrEytvwb+kpbRfrtm/0ztgtassE9A9FWlhoxVtBQqWJqnehfHrW+A19?=
 =?us-ascii?Q?gPR9Q7GTZIRV8JrVYuyFGOWFgeK76rL+0xd53hozd1AB7D5IwSajTdzJoEuG?=
 =?us-ascii?Q?3xjbh6+PF2YzpiQsr+3vWPnhzGMfb7WebPS8YBuwG5kTCwNPTJM+eNsV9CSf?=
 =?us-ascii?Q?1/oizU6W9/XJOVgSP1Yzrznmig/WxGv8fcEMaBnI6v4FZe/qJJ4gdLSt2ZFQ?=
 =?us-ascii?Q?KgGbdJJAdeipltV2ghrk2i8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TxWphX6prQRgD2Eigb06bq5OSzoICFgHJ3bjLdaWD7Nfl7MSmH1Zx4SNn9F2c6DX9eIc4uL6AKnvINQSVKKNoPZez3gwKczIz4Ltx4Bv7tZsiKDsNWHD3qDiy7HrDxD5tu+qUZLsatBTRbO8c5eTGcWJjy93m5LBniQSMLNqyBkATgQDR+OOrurQCfLDL69NM1ukU9gIuT080Y36QIUxwMgH5/SIYpe79N7PS+ZuHXR89hOVb0dy32J7+Oqrfxgl250snQM+7HSIeBxN1B+OK0YO6BwqFeWKRrdXUgntiIaSMg9KxNRJsIZ8hMNEWSXI6yXADUgOBxd4K1wSWwYOZhmHwqTejmgo5aP+u+dzmPKssO6J9MMl6uldLUIIR58GvoUPglxxRPOtI7z75r1MSUDf0see+N55WYEapDEqYEjjNpbbYicO4uKIx12W01IGUrErMYPVfs3PSshgGRQNe743VdES3Wfwstg6DJeYmWdWzXUfnhncltACWw+EqLzkrQK/03VmHVClnWPITmZRLPYG+OBIxJK8veYgodXaBNvAAHs9Gq4SkhbUCmfVvQ/tPff/uwAdM4waPx9eURxftDMhxSj3uGvzQkcReXhijPY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5fd1d0-3b0e-46ff-0e86-08dc87232671
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:43.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KuC6v8vzSoxfQ8bqyafBMwx4z8AK2/RhbGypHyxSmgmImQxv5vbWefcCYoS/8WDuSG4PGEjS0JeTg3cZE/QxcnEZ4ToOgJciiFRrQR0Q/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-ORIG-GUID: kMzbxoZGb6okFKYZ3_q_lPtin-gZ5thz
X-Proofpoint-GUID: kMzbxoZGb6okFKYZ3_q_lPtin-gZ5thz

Not all users of mas_store() enter with nodes already preallocated.
Check for the MA_STATE_PREALLOC flag to decide whether to preallocate nodes
within mas_store() rather than relying on future write helper functions
to perform the allocations. This allows the write helper functions to be
simplified as they do not have to do checks to make sure there are
enough allocated nodes to perform the write.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8b17768db5f2..92f133ea5f00 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5528,6 +5528,20 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 		mt_destroy_walk(enode, mt, true);
 	}
 }
+
+static inline void mas_wr_store_prealloc(struct ma_wr_state *wr_mas, void *entry)
+{
+	struct ma_state *mas = wr_mas->mas;
+	int request;
+
+	mas_wr_prealloc_setup(wr_mas);
+	mas_wr_store_type(wr_mas);
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		return;
+
+	mas_node_count(mas, request);
+}
 /* Interface */
 
 /**
@@ -5536,8 +5550,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
  * @entry: The entry to store.
  *
  * The @mas->index and @mas->last is used to set the range for the @entry.
- * Note: The @mas should have pre-allocated entries to ensure there is memory to
- * store the entry.  Please see mas_expected_entries()/mas_destroy() for more details.
  *
  * Return: the first entry between mas->index and mas->last or %NULL.
  */
@@ -5563,9 +5575,21 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 * want to examine what happens if a single store operation was to
 	 * overwrite multiple entries within a self-balancing B-Tree.
 	 */
-	mas_wr_prealloc_setup(&wr_mas);
-	mas_wr_store_type(&wr_mas);
+	if (mas->mas_flags & MA_STATE_PREALLOC) {
+		mas_wr_prealloc_setup(&wr_mas);
+		mas_wr_store_type(&wr_mas);
+		mas_wr_store_entry(&wr_mas);
+		MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
+		return wr_mas.content;
+	}
+
+	mas_wr_store_prealloc(&wr_mas, entry);
+	WARN_ON_ONCE(mas->store_type == wr_invalid);
+	if (mas_is_err(mas))
+		return NULL;
+
 	mas_wr_store_entry(&wr_mas);
+	mas_destroy(mas);
 	return wr_mas.content;
 }
 EXPORT_SYMBOL_GPL(mas_store);
-- 
2.45.2


