Return-Path: <linux-kernel+bounces-206616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0EC900C13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563FD1F23035
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDAF148FF8;
	Fri,  7 Jun 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IRczB/Ya";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fnL7zQLN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7413E8BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786404; cv=fail; b=e32y0bEjPXwnmHo9X78PVraeTyStFsjsu9dDWNd0R8/B949hKUJ5kdriPzB3eVbP3u0YCAfEprx74ojTqPZDxGZ1QHbbRn/4UZR1GoMDWc6MoGblhKZf36Iv0qZ45EBtLrIuo7X2of9AsKl54qPD6ufd8HnwPngIYjLmmyfoO28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786404; c=relaxed/simple;
	bh=lDABn5SjPNrxUvSQc3A2HvzKzQmvC0N4sLlSBKKZ130=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ex/QwRWXcARY7F3s+9G9UolxFaj1twUWhlxvIwAZ9KC0dHZbrtquLLCJpUPxhfvJKzEX9MHulkI8tfwyTRapa9U6PRt1M9donJ4sNATeK94XqDG88yvMB2mwCSQMyN7eNsEUD7wrrCq5mg1mo+5PbmTkRo0bUIRYRz8pFKh7p4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IRczB/Ya; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fnL7zQLN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuWo9020011;
	Fri, 7 Jun 2024 18:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=LbRUqzQTGgReNrj5x/34j4uZL7gNsaS8wJAQGdq1eJ8=;
 b=IRczB/Ya9ZM+uXRzxNER434FqHxwFs76qofFTZb0cNvZ75Yk1uZ7Cwlg0OHxr6by7o8+
 9xzfiYFKTwLkfwK+7MQVUJa3dwsi44Vkp1RtWBoflx44aBgwKF/IsaJTE9T8DB0L3JkT
 T1lIU6MSTrH8FVBDVRq5EM5Yy+1QPZE4PChqA0N+eCQM9sHjPTuQxfo7JLGl43F//lKf
 sPutDnIEO+HdwenR0oFWAnIcw5hSsxJ2P/1H/azxdRK+OWzgsWv/PuQsBQ/p9IrSMLDW
 IqSBP9U6v4CUgY5KHIMnJlrKNkAXCgYmMdSgW3RY+JBYv+NvjqaWDFS6EgA5Y464HpCQ zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsye9bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457I2CcO015604;
	Fri, 7 Jun 2024 18:53:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjh0dx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqwOvHwXjrD4uLQUWd0ocCSZg5xVEi8Bv2BO14URL+mJ21VwcjFl825+sgSUxGeP1oJGcEALsuhPd8jeHfA2HkQJ66/n4rTBRniEBan8A0oeJ3uMXas+kjGv39I1PWPHMvCZJD/Q8oVG0I0os7Fg5uv1Kn3h9RRJ0hWlh3u3i8kzXXlZUZ2ZW0lZaolMaesW3yvdNdE8XrDytG+nNjiNjmyqvpZYosZKsASabSxkKwYJfN9kyUmuPAeuGxAgulQRFgedakkPjo+QBx+eJxM902NhPSSlxec7lxICni4O5YQ6bwYV6LiGL5rFg1P5h8jcinm4gjZd8RwkpgNCEwPSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbRUqzQTGgReNrj5x/34j4uZL7gNsaS8wJAQGdq1eJ8=;
 b=RIgLfl5wnL41jb17iyTvIN3jYfYz5BWwvOy7B0jmrGnfuvo7tz0Nh23x4CdV/s54aahUjUUh30z38gBID06nZW8olfY1yuGNuAPeovCuu78StCwGHLnt65zmBbIK6VQuFQxbpmL3Gu28iYW6wR8FAl6AA/LjLUgTGRa+7IER/ez+sLPv3gtdBTug1b0xJnHcplLVzuyM+o/F2c8ajIZi7lcf/pJgIGobEugQAMOyufMA8BcgWIsVw2tW3+hMOtqgOg4hSYnbVU9mxWejTQ60Ed/mD3tFa15VfhIlVay0jtfK0ETeRvGmTks4jK1mnkl9Zj4ZBMKeIKYKeoANflUFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbRUqzQTGgReNrj5x/34j4uZL7gNsaS8wJAQGdq1eJ8=;
 b=fnL7zQLN8XifaGc9UWzjg1BgEAb5hANHiIcIXatWRgbAzeBZ/M/i3KLvTiVPLloay2Ryu1GFHzwT0QFp1BLctmrSBjZhID9dqkWozLe74OtmO2L8FIq1ZHODSAAkoUe03ODoxlrx1c6Iy8AZJ60/L3GisQFxaUHbkYs/RKUUwYU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:05 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:05 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 01/16] maple_tree: introduce store_type enum
Date: Fri,  7 Jun 2024 11:52:42 -0700
Message-ID: <20240607185257.963768-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:207:3d::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce4634e-dea9-4af3-944d-08dc87231095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?M4veIoouNrwZt65Cs/RQRWiDLqSGpoynm+7xBylhw7kEeHJdS8cYvaJOjjQ+?=
 =?us-ascii?Q?IboRyJ3XXhxS6+qS15vB22FbXd+GSkZ0XIYEyJGe1fdBt03fnb7cGbSyj+9v?=
 =?us-ascii?Q?F/19GXIY40bYsZ3k1MRNSuPWkvJ1++qwUr8KjxfbW05i24W8HqK5+MF6p0SU?=
 =?us-ascii?Q?L8V/2NkvuP0v89uFuHVzhQorRsD5t3hdOvgSsPNW5gHwouCAIN4dC1XXAoCh?=
 =?us-ascii?Q?UXG56DX781W8q2EcVZUA7Zmt0VN9rTDWpTbjOio4LPiuvh6umZ+Z3jmHEpcV?=
 =?us-ascii?Q?SwfSLT7aE4QKgQ+z1EJxW40t1re3hfcWOJeqv0tKmenyq/oI+rPzkCUvbxhr?=
 =?us-ascii?Q?iWGbqpAFb78lfp97Sbx7CGsChHjVw5Y71FeL3pj70wiJukmjmHxn9n3jDy5l?=
 =?us-ascii?Q?QP9DvGv3PWllvEZkSu4pyrArXnYhlY9oGA/IhqXzV3XJRo7v3y5pBqG1yxiu?=
 =?us-ascii?Q?wXXkaL79pj8IvobAvrGSDwyGLWS2oQsEQw828AB18COxuufljzJeCU+KdGzq?=
 =?us-ascii?Q?woTaO+xvdLHmV8ad70L+zsC8CTaWxWjkwU9lJ1ECFQR9nAX2tLNZEEbuDP0J?=
 =?us-ascii?Q?7/uPMZnvOZfbEEu3gfzUWbLC9HdnaBGwJvEM3V8gemVwFhwbi6PMHdk5ull6?=
 =?us-ascii?Q?h/+ZHSNn2fKk+YqDHfrccwqRCO8vJcrD5gqkARvTyulIyXAfG2SLId9HdPEb?=
 =?us-ascii?Q?OnLWr2zCOMjNUfuSpLRd6xdNO574t5wn8o399KFQAjBeIyg583j3huZmmLoI?=
 =?us-ascii?Q?NEUlygpMB0gV5yuE22mz92nX2wgobkPzJRd1JCfjpleYc5k9snJHzJrZ+o4I?=
 =?us-ascii?Q?ikuwnrzfm0DhJ7kSRjn+bY9psYXYM1FFt1oMjR9vtEdidd8HOSdnYLxNIa8G?=
 =?us-ascii?Q?yXqURvzpMaXaVkbdWFATozonZ3BFS9ohSZm5paVFivdGbS0iFKlv0DyLZqpI?=
 =?us-ascii?Q?J1LZ1eN36vSegmFNeOtimkKfkpcfr3O1sRgLjrVloD+aCZYMPBcen7yAoYlT?=
 =?us-ascii?Q?ngHPRu9Y0dsIfWoOcEiR7kpVP/sUdyz44ov/pei0HHMjo4uqTrcvwm36kf7f?=
 =?us-ascii?Q?vffEV9o4JM9uxP9XikZkhavlXduM2SLb4LZhOgHmGlwiTeoVbR6NXCmGp0BD?=
 =?us-ascii?Q?8Jm9MgZ60GOw7cbeHLbyuRlRDhGYsRjnTY/LgaTdueIpP70rh9NgUdHKTPl8?=
 =?us-ascii?Q?aemkHyxapbolZM+g3UzoIdXKPjJNfJ8UaBB7uAi6R5RRHzpD0+GWd5B6MT37?=
 =?us-ascii?Q?YyDclbJeK0FrxswjDP4m5DGN+1a3WZgr4w4PETcwkR45I72HgMhIiIcf6S2H?=
 =?us-ascii?Q?BvfJSA8kAzvXLjH6VxzFl9lu?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MrhQ2n5ydVqXd3V3eLkeMGLU6LoQ76EKKsdyvtQgRSlSgZNi/e5DqVeB5MoC?=
 =?us-ascii?Q?2mbJn/ZiJfkenFFZ00rnyo9a5jGIOWiTwvLljRLOUW4qW6OxoRphRIxKQS3N?=
 =?us-ascii?Q?erJs8zZk3oKHyGK0l1Nr+O91K2G0fhggn8ueUJdK3DrLZ/uPbyC3mB1zuOyi?=
 =?us-ascii?Q?exRviGGQOWFNc/6IYeThEZeES7j79qdezjdWirMfwdg9VZQSqc1+L54vfGh8?=
 =?us-ascii?Q?Ijo5tDr3BSI0o6gMhgX9vvvZq3ZkIWG49CQ74zPaKCdEQydb30wB7u0BLT7b?=
 =?us-ascii?Q?Aq4q2t2KXzMKcvBaOr6YNxevHPR+CHEnVkjC9+dzzTjQ3RMsfdoMqKBB2Bq7?=
 =?us-ascii?Q?z9li3I5ccJJKek32yPO+phh6mfE/RX5+knLImUADH8VUx0E8Y2e+2n30TDYL?=
 =?us-ascii?Q?XsZTYToopyeX8WDZDSyhNlmWHNkDeIVv3X7tICYn91hd+CpU6eIsZKVhPXvU?=
 =?us-ascii?Q?rBz1+V888tJuFkujp9gaF4LcSQ6+z7WRM846c64EDGPZiJ1AKm265ZI/C2BG?=
 =?us-ascii?Q?/tv162MSUMnPxIrCTv/VfvNV3YiQtZra5MYsMGWbKYb/qMIw3kvBBL/Mj1/e?=
 =?us-ascii?Q?SYGtZN/e/tyLNgJlvkxZ5bpJHyJUs4Qt4qCeoVGuID21c+WS3isY5XfBUAKa?=
 =?us-ascii?Q?Q7Vu+8MOX2d73FkQiHpYDqXhl/RoZs9W+5lDmH0/cTPy3h9RQGzQvfFeTtge?=
 =?us-ascii?Q?zZSLceqIqQkpAlWfAdz/Wr9Dp03QJD5MbxPPpywChRYjpH8TlZIAHvQcdcjD?=
 =?us-ascii?Q?8cHRRhMk/AlvZBAAYEu1h912Y2amiOd4xqD5iS47cnf3WE0+kTQj/4v25gni?=
 =?us-ascii?Q?/tI0XvuSoJ+VWz/rrqlul+RXEFb80jSwTZc7d0HzIJq4WjuFm4gLKbyzj3mN?=
 =?us-ascii?Q?qWOdIfInVflbhD284mB1yqx7Zg8gFW2q4QDwA6UzsP1FUqYURW6dLd5Jtv1P?=
 =?us-ascii?Q?9YjOjHucBoWOKs818lNXFnQFQGOdJ7msUdDcVMB5B/P2cZ0uQ8A6BXdT6Gat?=
 =?us-ascii?Q?hU3djEwCEDAWOJD97rDXWwKj/5j5t8hWyQZDQzEJ/KueGYxFvTjpYp1W9MRM?=
 =?us-ascii?Q?51KEpxV5XP8IuFh4GRcgbr1kCmUbYI2tCupeaIXt98BlzA6aqxwJzmQQhvWb?=
 =?us-ascii?Q?k0DIdyrHUgFXTXudpN9J4aBECMOMx3mLFExz8TKlnjE3KwPwCHrTKHscI0PB?=
 =?us-ascii?Q?RhqZUjAflez7XVS+wiUf0XEkdidrZmlmVE1cUnX1GLaj0AD/VfsGgio1YUBI?=
 =?us-ascii?Q?vldznvWnbNPutMr6PVgohakN96gSXjCgW6q+Rgab5EY+kwjsbVed2s9i6KQe?=
 =?us-ascii?Q?GRdsdPPTiUDhASh7ZINMZpdB/cQZQg4WXSalJKvl3c2lhOykV90NWeU8iBa2?=
 =?us-ascii?Q?BmVMsYpF1szrwlAKAgXM0kssW7rmHj+Ya3WSuuLqtP6AeyikmVi4K48WXlOa?=
 =?us-ascii?Q?qbMJvz1mkt4DIi9db5Lqf9be3SrHIKRGXLI7QBcJDL/yStq0aDaj2W/CRkGZ?=
 =?us-ascii?Q?aM7RFa/IzYYMCo6TJLhqNb462W95hKZfuUn3nPkGiRO2V67SuUnuOT/mk45I?=
 =?us-ascii?Q?l3VyKC778DW2Nss/O6VgaFO3S4/hTJJqZC4ai4l2mpOQLjAt0/y/R5ZIrtbC?=
 =?us-ascii?Q?gsw3oEPrFRy/0u5lpocMilY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1t2Ce0c2UI4WczZQOsfKkFMntp5cBwO9NZY/iFsqF3rtJyfE2Gt5aV6BHmtMW/sKvfDPy1c6kCzNPS6vnmSxmwmCFf0r5RAgSpj2dqTyyzbhEmHjGZ09eOi7nFL9zwoLHJdg/43I7aOv3WlAcscV6sVPO8rzywyEquV3N0NK3n8sMX5XS0jQYEWWTKh4khWz2gLamnpksFvRctxXR92mUE7pQrODl7d7xu5CeJRxLr2lsAIjsAJAlxvahfI58++5YN/H62TC+pgXgeCzzy8DYU5fl4tfBA0NdzzH8By5xj9Z8TimGGkMhVUSE5iarYRc9h4Adb3ON2Ang/YO5snqeZ6etK4nOh4QZtXIVwqqK6z1BiZzbkbMAIaedc1Y3YIMfC6Wj/nxBQaczuolXDCeJblsGxGBPDN/6KLfc5g3cTwbCYPsmfNkPKntTvf/w5e061mjhgcMG+lcsQx1AvbOat9woTb+Ns478MZXMuX5GynZz9S74hUjyfWmXL1Dzvai5Tcj7XMCtghOZndJaDwUJne64voFKfmHwWEGrJeUJciP5seXZ/Qij/EWa3yqj+QqRk2i4otGLQmOHhy0MOTiP+kocfGRng2hEb4lEJc/RSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce4634e-dea9-4af3-944d-08dc87231095
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:05.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C5QC7q7PC7G1BATfw2UUpNzE7uYTJQnVeVFZgXvKQmG5nUhH7HeMNUqUOkJ08hTFPxXAeIgybdsc8N/AMYl7sP73KEz7B36YWAVHE6GAts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070137
X-Proofpoint-GUID: hIZLWV9gHGRM7VKUA9tebrIbWu-7Ccgt
X-Proofpoint-ORIG-GUID: hIZLWV9gHGRM7VKUA9tebrIbWu-7Ccgt

Add a store_type enum that is stored in ma_state. This will be used to
keep track of partial walks of the tree so that subsequent walks can
pick up where a previous walk left off.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/maple_tree.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a53ad4dabd7e..2a2abda9eb32 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -148,6 +148,19 @@ enum maple_type {
 	maple_arange_64,
 };
 
+enum store_type {
+	wr_invalid,
+	wr_new_root,
+	wr_store_root,
+	wr_exact_fit,
+	wr_spanning_store,
+	wr_split_store,
+	wr_rebalance,
+	wr_append,
+	wr_node_store,
+	wr_slot_store,
+	wr_bnode
+};
 
 /**
  * DOC: Maple tree flags
@@ -436,6 +449,7 @@ struct ma_state {
 	unsigned char offset;
 	unsigned char mas_flags;
 	unsigned char end;		/* The end of the node */
+	enum store_type store_type;	/* The type of store needed for this operation */
 };
 
 struct ma_wr_state {
@@ -477,6 +491,7 @@ struct ma_wr_state {
 		.max = ULONG_MAX,					\
 		.alloc = NULL,						\
 		.mas_flags = 0,						\
+		.store_type = wr_invalid,				\
 	}
 
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
-- 
2.45.2


