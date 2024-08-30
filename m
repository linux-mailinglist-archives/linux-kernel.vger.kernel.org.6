Return-Path: <linux-kernel+bounces-308011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6396561C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE822885F9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132F1531D3;
	Fri, 30 Aug 2024 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aJ48e43W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g/lJOcu0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEDD14A624
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990505; cv=fail; b=HhgHFkEIOcDbon8J5xfccxXgx28rmvC/7uJaSVcnC1Dv9y2CowgADZPxcihO4dlVH+d4pcRs3b5Gl3+GMqaPMX1ZdMZrTIpG8Bm+Z3ae2WjC3eLtFPqS+DhCr2VoUx2QRG1E0qZZrLkHEViZc/0XsqbZNlC5ZPv48NN2Il4KGow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990505; c=relaxed/simple;
	bh=3jNw5LRLVXz906MXLx8C/Y6dAwFMEEfCUHjLOn0D5bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+H+rh6dWVeKGNrX4eGeWjx+knOrPLD5RbLbHWlKJtk9d7vHjk/pXTd8i29yx2EL7B80CH5oWgmJ0Vxzz4dUus4n9R9JI8LCg7P+cCuvXYtTkcTef4ySwGCFRnq4dRWTfDuD5KeGuInLjGYk3xVquKMNWStpABLJhv8BphSc+WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aJ48e43W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g/lJOcu0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fVNw022839;
	Fri, 30 Aug 2024 04:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Lu6AtId3bBP2dooEzmFt7N2rgO4+X+ZJGjHwi2y0j+A=; b=
	aJ48e43WBfbdc9S7ChqawcjC1oOPRRsWYWI1suN4NpKPslbHNf9gK1HP735Ue2Wh
	5xotbR/2UeAXXeTbugJaZPbuV8ND3+aM9bj4RTwuG72tmmyr9pMDuJ2UocdE/o7P
	Tq3f2eeGOWsB7tM+04kRxZfm7C94NJhwtGB1Pr1VkshFO+faudfx6h+KId99RzHD
	jb2dz0rwk2+jQocgo3VLUytlMYAk1DspfcQ9RjA6fQhvI7pC4Kvj1TEl0qLQjh4h
	VJ7zYuDZkE+dl7ay84J6FEJgKDVMZNo9+/nGVHEtvtsyf6IfuaAM7wgIbOeN1/Nv
	bcdpQtH+cGOufGxsw8pung==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b28508ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3jJaM036502;
	Fri, 30 Aug 2024 04:01:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2swm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERTfAd5OD4ZjXTg/2oTC/Yedei2Law/mkdb/TTx3lAyVrhgQVNYlB+vENXiDyr+2KdatmNVY3zoyQ039lY4j6sP5pvJJfIHFyj0kCyQZgO7Lu0LNL5tvq298C8GzBwoGGncdHknJ3FEawfVHU5tN4bGMaPR0FgoM/FerKlZTq0k/4FFJ1xOuEznFARoeefbaPbbVSwg9Vva4yE6CP3mgFcbpuPQjaIuLqQyBLJDmZLPKubA5fc3aZluqGPwlSpLHSz5CKxF6hkiw4ALA+OfcQdpFo0EaHaf0gJzztqy3Ah3Nxju7eeZs/njCaFEOVQA1Z+9VsS4pR7og0DdxMvf4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu6AtId3bBP2dooEzmFt7N2rgO4+X+ZJGjHwi2y0j+A=;
 b=nniIUiTEk4Ma2VQ+684FvVLsMHYvYRHxlcPtVLDJUXZ0NqBXPnt2byapqhqO5t02nneUnJtHcsOZaDJ2LchtB1dzRw4TJPVfXv72BUse4ArDNm5GVEiBV3WCNatdw5taATOWnpXUwY4yDN8ExHYlyUprAer7t5gLvSZcFuFKTkVWV29MGHIgYKHbsLpgYTZWSGFnYqv951+g9AvydqthEG6Dy50er+9o9JD8rHfwjb5xanm5nm2O+R0/KCUpyngVPQHnGBAjf8cp28RIAvc4f2Pzp8vkpysZzsZcpYOTbFF+Prn7TdNe+RNPqO4TKs2xNb7VEB0KbOSIfBzZ6bvKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu6AtId3bBP2dooEzmFt7N2rgO4+X+ZJGjHwi2y0j+A=;
 b=g/lJOcu0edZeGzEzW9LmDW6Iu0cyTo9fvIhoU+n43/LixiEbqx8DMg+ZyTVscNa2OrVDAmtGtIO/GwutJhlGh1Nx2wgiHHcQV/Zt1ixZsXr8hqI8N6c4olgoETey38CCQHVYIBjOzzdl53NxsWh8cNJv2/XmfSPgg0Y69h7GMiM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:20 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v8 06/21] mm/vma: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Fri, 30 Aug 2024 00:00:46 -0400
Message-ID: <20240830040101.822209-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 575e3351-636a-4be0-b1ce-08dcc8a867cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IpQjrzZWD/pgrLcHjNFdaP0J546FcdRDD/ETHYq2zpKsV+lGXNQt5oeduQzW?=
 =?us-ascii?Q?fN196xxxa38sjKGgB9KKMKwFStVKYbDg+ZuRINrL2nU8Io5fhJBL/q4481rs?=
 =?us-ascii?Q?ClLpkwIxuwk6YWERB3FdOf/l+3nAjSrz/wg72dWKTPwmp8fGu939SWJMPISC?=
 =?us-ascii?Q?0s6Uf6sUJcu5TfyOiDujHrIA0w/dyQ97iCborF4fxga2FctQCDJcfv6BYHgi?=
 =?us-ascii?Q?fXsLK6U+/JQyyWYLRdu2tsp3ZEViWxobVe4FlisOSEaySKZE8HJkdrSoVKaf?=
 =?us-ascii?Q?R73KCXW5PHXMLQFyodong4P0djpciXcUyUoan6DClJoFFGMos1BwnyUVVkSK?=
 =?us-ascii?Q?JpYiGBfYaNa2+vzojEuusA9cJkyFTUwGh40q9KXn3+g9DJYOKtBUKvQHAzDm?=
 =?us-ascii?Q?nB2x7yAA2mN9dieBswcFxSTUoI8KGRv6fCGTCtelxerImm7lnMxE8+2QyPl2?=
 =?us-ascii?Q?VS8gK38MQg/z7UMFbHxwbGxu9niZ9xEljpp6Nqicf5uowH9NHTntl6rN916N?=
 =?us-ascii?Q?KfvSPnIHG5xSXwMYOxl68EH1LiTIhRuh92OKJFI5OfC5/yB3rBA8vv+iF/KY?=
 =?us-ascii?Q?5TSd7irQrX2w0gaNYAqmJhd9tW4XY1bKdfJ1w5ERc3u0khWE3gAXEzmSP/ar?=
 =?us-ascii?Q?IWYEH5Fe8e3136qO8ET4FRrmTyTrZQuQzXX99287jHXNX8W6/ldfVSLOhcS7?=
 =?us-ascii?Q?/IhVSgRvUGMCoiKrvPieOT3QJnIRiCtEKifyBPTAgxU8kBE8dU7tE6CetGlo?=
 =?us-ascii?Q?VgDfAJcDtA+wjhUJtG5tZ4HMxB5nWP5gaSt1ckmVWujbAJmTunphNT98hvX7?=
 =?us-ascii?Q?SYMPyfF6H9vtOgrpeNWbOjNVzABvFNYDl/Lza6Z4WSCWwsirLtW4hNHgdlaE?=
 =?us-ascii?Q?uhLfLfJwGju4akvuYsA/C2/cYvmAAROiY+xcuQTKKnqbTV8mGiZhNEFzpKl2?=
 =?us-ascii?Q?VY8t/Om5+ROowEqO4WuHi2va920PzOg2ky0NszEM+kUKL8d5kv9HEo0cmd60?=
 =?us-ascii?Q?ptQVP5WzTtF6uT8Dh0BwheUNL/gIxIfBDzWakearjpHmNH2yD3tDp+eovQ+A?=
 =?us-ascii?Q?JXRNN8aw9OrXdlz6i/JjOInlvxK1bEBeOuvu0eiBKyyZWMQ3BOdVIM0IZ4Sp?=
 =?us-ascii?Q?ms0jFgdUI3cA6ZeLFg1tiZjXith8oef4YGmh8Y4iJOOeNHTKiOszxgvEat+3?=
 =?us-ascii?Q?8KI7XuW66CkMgeng2oYy3W2MVEexwDJp7cWc+UQjikPB2SiKHCMzJybMHIMX?=
 =?us-ascii?Q?cDaqhwhJmQr8Cr5Zg8sA9BHzipNkVbjya9orvBBi6FsnD76cp//01tUWxm7T?=
 =?us-ascii?Q?j5FMl3HBqUdqXMSW6CTCRA6INM6tu5FXlOg6aFlkZdrS6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lIROTDVWHlJxRkEDAkcSFkqBBnQ4wJK11wBAAsdISKIqzuLlFHL/tC7vSio+?=
 =?us-ascii?Q?DcZbsnEoL/nc2MM9UdkDHzJ+gZuGMOG1jk5EhqNyshcbeE4YdIs5wA2Cr1ND?=
 =?us-ascii?Q?JXA7e+izulKUS52G0mFpa8X5t6JBFl7fKecy351Rv8ittvf0c7AkmGaf5ypx?=
 =?us-ascii?Q?NT6MLlQd5KBIvRnYXYs4SSFBnsmAEmP4uZfEPzLtYSfkM2sOoj6d+cvBIiuh?=
 =?us-ascii?Q?rSPw6AiGnhhliH/wojue56jsbJePwIoKYdAIPJQk71X2XqPYVBcSA8xxKCWd?=
 =?us-ascii?Q?XZQFHN/qv2Qc8FITjc0vreERDjtCY5i01/QZnBdHrrtRKmxY/y1wRV8koLMC?=
 =?us-ascii?Q?Rxyf9WgDVmSGqB1L0iRgkk0Qvyy1AFrCLc11T6ob3kR6HulIU0nR5c+w6fR2?=
 =?us-ascii?Q?NLtgo0uaxMCf2Q76EDYT/nA4enifrPEKnZ2O2ovwRL35mQ6Uj6rmMwKC4RBQ?=
 =?us-ascii?Q?tHyPVWMH6Lv50R1i742Ok2MXdeOTHmWkINVjGJTLenk9gFR1I1EiCJWhXVkY?=
 =?us-ascii?Q?VkchC1Ryeux554Q2vOs0YZlUxiauboFd6h54gLeh+k28aQmCGE/XIBeNhGoS?=
 =?us-ascii?Q?AxKu0HijgoHfGH2Mb6MdoJgwTxZ37b9uN1h6haPvvEClviwbFJZUq1aH8C8/?=
 =?us-ascii?Q?rRreqTSIvBE9s36w49uc0+6ehzO857wRL35WugaeouHBc8Y3K0ZmE3/vE6Xj?=
 =?us-ascii?Q?jRBH/4nkHcIdI+/MaXutPS3GVYgDluWUsPK4gbo3K+HSg9BG7zJYjsMzUW6w?=
 =?us-ascii?Q?exS7mmEIA4YJE6fKk2VnKyH+33xqhjae9s9HMljmY/LsAiGeemtUpoQGW3uJ?=
 =?us-ascii?Q?Vw4roe2hd+XYU2ylDR3IerOleAdPClu0m+V+iUZsrD/NSfGoixrXEvt2Vh8J?=
 =?us-ascii?Q?LOlnIemXeaxXePyfIc1xOY05wDtZ6ic2PsuAgzBPdTpy97tgKmw7Lbijjmp7?=
 =?us-ascii?Q?61ipfDsLNj9N6HBjJFHC5/VMxYzCu5U3XXsa5k0WKt+zs8kpO2gm2JffTIHX?=
 =?us-ascii?Q?XK4rnYweZ5xuB/xGt9jumDg1hkIKSwNQOgg0mH3o3PgmgDfBjaz8bmrvp7w+?=
 =?us-ascii?Q?xvT76gnhje6QzRQwEIHhTbT/v+4hIZGuATJSCHjEhB6ZWebNYspZOaGMZaNq?=
 =?us-ascii?Q?nO/M9XMCpq7EZdH0sZyLw/1Oq+oiFtqNQJWX8mz4ykaSyrCT1INQodpXkhk3?=
 =?us-ascii?Q?sPB43oJYue+4PGl75fMsGQEYMHsbDPOU4zZMyDTgHTRcXQw2OGGVsntSuo7N?=
 =?us-ascii?Q?Az+ygzmkpGVZf8GxnNvU1O7liw7pWV5kjch8dLNCriQk/v8bUFBuKuOQ/Cbu?=
 =?us-ascii?Q?nQe49hrXL3ndjwJ58nvuCnbXec3Mc7iES+3XMF0EXfPPYgB420vktCIZILtL?=
 =?us-ascii?Q?j5Dx2RtzX1tidnWu+wpN4/R49cyWlrJwvCwEAY4bjlLSHvJNSOEtVfL2bX1b?=
 =?us-ascii?Q?spCjs4WUm2ofy+CupYvjbfVj18lInY91NL65qteo8mGfC9Pw6GGVgflSLqOZ?=
 =?us-ascii?Q?YaFSXvMt6R99fiYkOGcL8m19WzEQqYuJc5zxuGE6wADA/uKmF/yRg9bnLfkt?=
 =?us-ascii?Q?/CglGUN69K0dUtS7ioqfU6XbSUU6IOVX/Gc4RpQG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xcehb3/PNlst7lu6wYejJJlG6X8LOpZl+8VgvrjkFQs3vvJkQnPPf6PnDDrabuqwiNaxerr08nU51bkMTQCQzeAqNJxXFKHOJloL7Tyjg/FrBOxgefIZxhtYeF9VQRXqsEL/yqWc4vNlBCoqiqx/SnxRILJ5YkKQu0d3JdBxHzDYvOh8e6fCGYPm6KQ0dJlwmQknPYnHzHgSoR1vIZBzNtN6ZjIZfAaBg4mNE+qatd+Jb31bYoL60MuPM4kwJk6abWdXtXhaX3CSi631dij+7zJCWtmJsbvn0oU1hfKB8HuAAxsZFe39GNOyVsM5TkT8fW+W1Q4yI8tYOqpg9jzW701X55BIs5xsZ4tpTrD5BoJHyfWDsCC3tXnHD97iQKdmzNxzwciqzFgUSFrfNOEnP4LCY/ZsWZTJiWKb5kLOPhDV5d9re9YMwCm5cIHqDZS3RIR/K+2m/QT7zZx3TcnXcMSlUPqoCsWji7bBUyEzwE4JIWrpQczcR7M3dBWTgPwrvxzbZfEVzLfsbSb+yidNHcs1XcElhNBCQ8g+8vrkxfEtfcnbOTvccUuYC/isLXZ8ZL/2b8W+cdLFz+W8zs4iO5Ed/xvT4MvLb0K3ks5CguY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575e3351-636a-4be0-b1ce-08dcc8a867cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:20.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSK2wP88qjL2baUazf1rBfe+V7YPObaUATZ48KooU7SQ3e3kLAoBBjo25z+k8sT2SKxMcAnGw6JL679cEP0kvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: s1TuJUxGpeLi_9DLnqI84Qp9tEc4UvrV
X-Proofpoint-ORIG-GUID: s1TuJUxGpeLi_9DLnqI84Qp9tEc4UvrV

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduced to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 83 +++++++++++++++++++++++++++++---------------------------
 mm/vma.h |  6 ++++
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index f24b52a87458..6d042cd46cdb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -103,7 +103,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -299,30 +300,6 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * init_vma_prep() - Initializer wrapper for vma_prepare struct
  * @vp: The vma_prepare struct
@@ -722,7 +699,7 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -731,21 +708,31 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vms->vmi);
-	next = vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	/* Stat accounting */
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	/* Paranoid bookkeeping */
+	VM_WARN_ON(vms->exec_vm > mm->exec_vm);
+	VM_WARN_ON(vms->stack_vm > mm->stack_vm);
+	VM_WARN_ON(vms->data_vm > mm->data_vm);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
+
+	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -798,18 +785,19 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
 			goto start_split_failed;
 	}
+	vms->prev = vma_prev(vms->vmi);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
+
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
-
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			if (__split_vma(vms->vmi, next, vms->end, 0))
@@ -821,8 +809,21 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
 		if (next->vm_flags & VM_LOCKED)
-			vms->locked_vm += vma_pages(next);
+			vms->locked_vm += nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted += nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm += nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm += nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm += nrpages;
 
 		if (unlikely(vms->uf)) {
 			/*
@@ -842,7 +843,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
diff --git a/mm/vma.h b/mm/vma.h
index cb67acf59012..cbf55e0e0c4f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -33,12 +33,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;     /* The first vma to munmap */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
+	struct vm_area_struct *next;    /* vma after the munmap area */
 	struct list_head *uf;           /* Userfaultfd list_head */
 	unsigned long start;            /* Aligned start addr (inclusive) */
 	unsigned long end;              /* Aligned end addr (exclusive) */
 	int vma_count;                  /* Number of vmas that will be removed */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
+	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;                    /* Unlock after the munmap */
 };
 
-- 
2.43.0


