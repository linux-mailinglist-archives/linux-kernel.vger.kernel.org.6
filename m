Return-Path: <linux-kernel+bounces-206617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F9900C14
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B8BB22E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECF149007;
	Fri,  7 Jun 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owxwT6wl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U183rfFW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FD13F440
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786404; cv=fail; b=e2VMVo9sRy4Syib8xJgvLV77s6sg3EOMgvsBCpeV9/djcDILQQN7+7E2NwwzN8pkMtctORe+EXbQw1rHXhkHV0QeRbdgumtoHOd3DY53U7lFd/ggX0FoYi5r4jpZpbBec+Gixq0qV9df3NwY06e2MlFCSdDKd9zA6Q1gsxVaeuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786404; c=relaxed/simple;
	bh=8uCo6uaPPdH4sErGevcHVFm7crE/BBQflOaO7uhKO54=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TKAhzs1jdYbvGrbAmwGsEyzObFMxO3EYrsKHBBVuP8wmb2pyi81cdn6gJXPVJcohT3hqTFj+wLQBSVTwXqtpYJmq52xI7daC1eSO0IGb8HGknArr9j2Xn168NuAtwCYydSZthdXlRvDa6AnlvLiyDTG4mNRMB4qiLm06gSwlzTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=owxwT6wl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U183rfFW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cucpd029337;
	Fri, 7 Jun 2024 18:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=corp-2023-11-20;
 bh=Z+HD7i8xazxOpsmURMe+Ys6AfybggCp6HFH5F90p23A=;
 b=owxwT6wlANZTcc+fG8xGiqfUMcRlKBwsPyUiNi+PshOehtxWUm+a95UGV4v9Z+zEmde1
 LyNxpujbEmuLP8IUZavPXrnSUFNokZV2ONbzOvvEWlIBDB2gIzqmOagrDY3FwLascy41
 Y02oGXOYfQymGLthBsYtswyKUhCOnpMAL9n7HlUxMX37aHXdE06XtMpzPYyjhUJzAIcj
 OaPApeq0AJdtcn1SRcbHUgAfBLMtyw2SnIXMMLrbWb/Qf9OKPPZv1kCYvO3dYViQ26zp
 jdUUMKpwpyCsjeK8CGPaZXFKSAgojDV9MplRwsuEYUlAD1a4DSSB5Bo9WOam/6y86orx 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbusx8a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457Hm0NN020548;
	Fri, 7 Jun 2024 18:53:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj6xy6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM8/e5Np8mIYMsbNIYbocC709bgAztmiJbgupiUso8aKdxveq/PLc0iM0fqLIHVziSAQDxHtw/7ygr27t7oGYNiy/nPaJtM+L7CVoSrFlHP+lSMJxl3+IhyXLzWTLCJRhtSFRqA1L6kpjcQDfrPnYh1NEZ16dWJ88vDTXnXx4iOdflaCbmlEGdZOGiuTJEjk3I1E99efviIEnq2Ol0iGypM8JobfUj+P0EFHGjUi0MaXMjwkBYLmCeWskfxOAbkwUq/vH9J7NYszGWI2SVZ85pSwffnR0wJiaA4wLJjCvezWNUu27mU6PvUImCwdtj3oaZzUSLFkp2LHnoR+gG8nOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+HD7i8xazxOpsmURMe+Ys6AfybggCp6HFH5F90p23A=;
 b=gAnkb76QIs6yPU9ejFxvcAwGvnmasyHa9FRpaf5Bkcpv/04PP0f29u86mOfqRU5WBIdjYrV8LtOERqdD4PaKwQha4v7Dk0d/oDcqcBUMaE4wewE3dp+oTv6UqVomAiQGfvJ4GAAW9uqadiiIxp2e5C+ZXEfZNfRWA4fH9o2I0gIlD7enTTS27TxKIxnpVSAKAzPeS3iYvPnTjq/bz3LfjcvWjQQxBveAH7MS8/1KmwYRtaw3lZsse9JJA3/rXZMfqzHZ71iB+eWf0PubxugL4WFrTGIMwDM3RynYiRBFGD0Ws6gW4fd71wFLn77dfh4YqL8GQ6CWtTXHkppVLoPn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+HD7i8xazxOpsmURMe+Ys6AfybggCp6HFH5F90p23A=;
 b=U183rfFWUTgxO/OvHqBhjgEnjlEEGRVkPqjmwuFBtf/ewHDVxsontIu6ZAr66Iy9IeWK1D1FSxyQH4J5j7TLLDqEQeL4dLJAB2H1Wmgn+dE4NLNB1qFtDuKV0IgFkuidQajlV19BF1dNvjmIVhGo7aOf5lwbWTNJvvZbPhmNNE8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:03 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 00/16] Introduce a store type enum for the Maple tree
Date: Fri,  7 Jun 2024 11:52:41 -0700
Message-ID: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b76629a-342b-4a33-73d5-08dc87230f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?v0s89TN7Q1Ni/Xsj9ovU0hV24p9oznan0BN4U2NSi5Timb6zwlhbFebgK5/F?=
 =?us-ascii?Q?gSbxC3ZNGJf+nohjp+vCEZ9q91ex/PaHNWqIrgzfoUkbZJW5WCqbVnq/Jvef?=
 =?us-ascii?Q?8RC5blf0nH3bjvBYRRuf8gIjn5lAGEa2gU5/0/P7UAIoBmlMWVZqvtdUI1j9?=
 =?us-ascii?Q?hP8MkFb0vdu6h1SaTj1u0wlV0CiDkbS1rwxYWiYUeId4rbT9aLRJjuPqrxCS?=
 =?us-ascii?Q?E99fJ8ocaHQIY9FD1uq6Tbt9Ju880rkHW23dqN00XVpcr6N2+SjwHThIE16G?=
 =?us-ascii?Q?zyFuDydl+DyqQBPxM0zV/BdlYwwexzBdS2AHFCEariinY/St1nX2c8qP10NX?=
 =?us-ascii?Q?XkfQVz2N4gNIQdh3/OPdR7vwByD2DJsUPTc9SZNBwwWbjKtB3O38qnSlVsTn?=
 =?us-ascii?Q?PFD6MldbcZ2IamEkc6OLDK3WbmoOW4DUNhkrEA+6qWkZas+rBShncdiPDeio?=
 =?us-ascii?Q?i1bLbU32QdoB/1+vOlMrgHrcWGfrxjKF8JYLz8WDtPV1A4/OUNlx94mWt+sR?=
 =?us-ascii?Q?8eFVEV4PvETdMUOEglhUxprixMPnOPXvODiU0LCWtgSqDs8GtjOW1Nacshn1?=
 =?us-ascii?Q?duMO+V0l4d+YZwT4Zc06x4ous3YwS3grNECP7kfNCZ4ZIcPt38ETL+KsIsd6?=
 =?us-ascii?Q?0boEpF5g4UjzXbxZ22HiRcEhjWylAl0F6QLtZPzHTGQmUezjqdwMi6iIclCE?=
 =?us-ascii?Q?sYtxH3ZI/QChYAA8fBeIBlH3UVTadxXfWe0StRA/wV6Hp4iP5tZfbG2EzxrX?=
 =?us-ascii?Q?3aJnUGcaUAT/PMyB+RjFQWLb3VpMet4sdx87FPj50geKX3K7/f3NJOzeeyup?=
 =?us-ascii?Q?tX9V7ratNDPYFeR3o/+h8C8XL0/lUlgIyU59Oez9WCIumIbduIXwCrOB2O6A?=
 =?us-ascii?Q?HlZk7T6+F0WLie879SXc4yuNjIhBooF3KFkVkkuVOwN/6FxilUDN+6uok5cx?=
 =?us-ascii?Q?HHA8WReas0tfnf+NB/VKl8XAhbLkK1kS/j9Te7+6bNaewhKV3HpUF9LkjJYm?=
 =?us-ascii?Q?BjqqTv7gE0aDn+XdXhCEN4Ci2xrhy+QlpOCqtykRl6APKvZleK+Xa69r+Hat?=
 =?us-ascii?Q?bxjliNynHSgkSha4M3zdXSMj9nYVwNFDynv5/OnhAwNPV/FA+cu52cS+CZw+?=
 =?us-ascii?Q?SnRAOPYQhRnXywhDcHcdDn2F1bXREq5OX7ZmUYFqGSgkpayjoy++xsS8FdSf?=
 =?us-ascii?Q?/DOh8VSgEocH6isPtnb/v7G2SV+EdwzvpCpbosZYk+fePA+eqgGChmLEVRwC?=
 =?us-ascii?Q?6jmQ78+itk+Q5AH0uBeNatj0ZLyM1EV8K7LdN5fUw/52dx6iShGFyqHCK795?=
 =?us-ascii?Q?tQEBLy6isxiQQByGzoJAqExs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ee5jLYKxSY/Ha3t6I2pu+cvwxAWmTZg19XkZIpI1/nsZsuI6gzA86+rbOerU?=
 =?us-ascii?Q?sdjzoUkNP+8e+Mf80ewSUDrz/c++NvvjJaZzbxLUtKIRGZm612TSXVLy5CFi?=
 =?us-ascii?Q?FdTUJ7CV8TqQFBug2h/CQyWKjCfIWBVSutC4vduSM6s0mVR4NgWhmjNUlfcU?=
 =?us-ascii?Q?Ak57AEEtw4oOxRGuE1mTSyk/ZFNEGKfXzovlDL/0OhMkmI4/Qmi6dU6bLzQJ?=
 =?us-ascii?Q?oBLhuMIxLHRZzOYPhvboTmDi7CfWt9yFkxNOGpRuKb2Woy7OyTsGbx8vpmeq?=
 =?us-ascii?Q?9XNO2+0Xaeu+aS//xmAfob/X/yiEsUxJ90zSuzP6HE984ufAmGfCHf22USOQ?=
 =?us-ascii?Q?o6U7ftyNizI9sltowNmgIgu+fFe8mNc2FCps+whEOxwn6vvHf4KjDZ8w/ICM?=
 =?us-ascii?Q?tHVjT9V0q9VfI9p7HmycejbEBVpNw6Wj5RTDSSATQ05rXMZKH5tmKv7jK3XQ?=
 =?us-ascii?Q?BuQ5aXb3nNAvE3yoraubbur4jfxI4mhahFpP/OxmHbIENmOF6Osr6bxcVCQa?=
 =?us-ascii?Q?rYgKAF4wEMWmKHtn4y8owvudLlrGpM7Tff6issDTH0HPqg05Y9Q3++zad/qy?=
 =?us-ascii?Q?EY0kJlQU1ZTrAxXUx0hkoEWhsWijDvXBOVvyuOUuvhHtdI/OWpb65HcDwCyh?=
 =?us-ascii?Q?RlqoD4nidBucECl2bxrQ2vump2E2fBhdpln5A78Li1dK9klz+8xNlTWTzauh?=
 =?us-ascii?Q?1hzZsCmaPGGj1/YLyr0wxr0J5v7REIFag6nKrbd2h/g6nE4hu3HG25qWr/nc?=
 =?us-ascii?Q?aIdVba2Ce8MWrtFLA5dWlvmFaGa8Ys93IE+kVVoTVNxn3EmUfVYZfopsbSJX?=
 =?us-ascii?Q?sfapbKuC4n/cF/YfYRpbu4W7qBMqEgAf0yK8HPYUDzLk47lZGta24u0NmCIn?=
 =?us-ascii?Q?vZ2iboXxlJk4HKn8jyUXsYydhF/nxJXtZZvAx2u55JhTCuBlIQCwTsoLRWkp?=
 =?us-ascii?Q?f1eyKlMjxC9G6aNniMTVz3P3bKPymJFBna5dCry9wNtg3aJXIb1jFpWsErjK?=
 =?us-ascii?Q?dn729Yq5PjeeBIKy3UvukKbgPa/1YOJzFQBFkEAvZYj7sy2xwrJB4FmTdE2X?=
 =?us-ascii?Q?4TW4Iw25fRyIFdP02z4hoi2VZeHp3oMqwC98RQMsHelXc3eYlcMbaAZrm4vL?=
 =?us-ascii?Q?yqd4ak005GFKEejnRyxsIeGQyH/M+icfvQ6b0/fXYwckZskjPPEuGhm23unk?=
 =?us-ascii?Q?MFa/FMbcd3rioHE05SjgQqg/y+QI1C4EiiIsnZRsJQhGkZF5QBauS58D5oVV?=
 =?us-ascii?Q?yB3ZyyKYL7/mTz13YChj9463ftqX3XY3+MBHAK+mTq99ef7AXEn2+9at0mtm?=
 =?us-ascii?Q?T7wuOkUdsy9G65swhPYs4NrCHh+Qjx/L+ejN2uOSd/HeWy65JGPqrUgbCGOU?=
 =?us-ascii?Q?+q1zfrRr5kZYgPPSISwirUzRcbEryLPrRS81MSUCMWfpabNfpWkTwP2DpEoL?=
 =?us-ascii?Q?qp/ke98HGc1OPr+CmIxAZ2Qar+0wwpk+aJA0BSpfJgLOr3MS2DghF62ByUgV?=
 =?us-ascii?Q?rgPPqJHH18L+oCfCbYOmrApYmgjlAZWL7YzaapdVDmV9p0MWSzLBYvh0EN0L?=
 =?us-ascii?Q?0tSJhjh5NB6CfNnFbN83qk3wLkvA2zfusntqkZR+IOVGoJdsoLuJud3VDcPY?=
 =?us-ascii?Q?NQPQfEWghuc/5cgj50gItDA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HOgCqxBFECKJgJXizh+obu6YlbRdvw32wpwJH/JdFIPFCNIOeGu769WFbOlUejwoOftHQ8+M1Kq9R/iUfrIPdYZfHFzwE0UZJBku39AMSs1UIEm7SVq2idhYVCh1EopTKfnvby6iCY29Ofr2A9Jhqd9RA0ksrV+su29qaQN2co4QJJe/8OKIfbl9nd6yCO2JQWXpqcrSH3hz81cXw35yh2mbtrInzrpkGDNT+h2xIqLgwNid8F7Nnj3hzpDK3Dg3R4HFdB+IQznas+TdMI9+ym4pDfsjgbl3fylxLurVWKXox24ZbjIgpezKD3rlX8ezatcE3VLRwqflL6z5eyqeKr+k9momNKG2BaCuCwj3qHXmMng9riPvch778zuTCFXOgTlYqpy4dQgjz4TE9Uf/IKXQOs2O21iNSIJMKxDBAn9lCglsa4XdH37aOt2hQlcMLl8iCGXooj9ocPakUiHgUw1bnx6JNOi7kR4dwU4yLwK/V6MEV2/HE6KbCsb1JXPZFdhR4v9wMoaUy5ddAnrQKUGR3JkThlXBjt5w02+EXh8Ow9uEJxNTTs28bW1V9V8qBrq/UKvP/Z+/hTnbReO9/8QL2ZRBnG7scyxZCGWSquc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b76629a-342b-4a33-73d5-08dc87230f52
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:03.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA93iCrnpHb72JWjwjT7wW6h06eu1Sa7FEsdor2eenBacB6UQMRQ1g7mmj6887Uhope64wQp5FRG5GQZ5EUddaPClhg1iL1nV5cpE54utbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=1
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070137
X-Proofpoint-ORIG-GUID: iBY1OArsR8U9P5neFHn9gDL9TsIW8Iom
X-Proofpoint-GUID: iBY1OArsR8U9P5neFHn9gDL9TsIW8Iom

v1[1] -> v2:
  - previous results were noisy, replaced with stress-ng-mmap config of
    mmtests
  
  - document function parameter 'entry'in 'mas_prealloc_calc per Intel
    Test Robot
  
  - explain why mas_reset() was dropeed in patch 4

  - add locking and mas_destroy() to testcase in patch 4
  
  - squash "set write store type" vs "set store type" into the
    mas_wr_store_entry() modification

  - only set ret to xa_err() in the err case in mas_store_gfp()

  - move MT_BUG_ON() inside lock in patch 7

  - noinline mas_wr_spanning store to reduce stack usage in
    mas_wr_store_type() in patch 11 per Intel Test Robot

  - document function parameter gfp in mas_insert() per Intel
    test robot.

  - further simplify the local variables in patch 11



================================ OVERVIEW ================================

This series implements two work items[2]: "aligning mas_store_gfp() with
mas_preallocate()" and "enum for store type". 

mas_store_gfp() is modified to preallocate nodes. This simplies many of
the write helper functions by allowing them to use mas_store_gfp() rather
than open coding node allocation and error handling.

The enum defines the following store types:

enum store_type {
	wr_invalid,
	wr_new_root,
	wr_store_root,
	wr_exact_fit,
	wr_spanning_store,
	wr_split_store,
	wr_rebalance,
	wr_append,
	wr_node_store,
	wr_slot_store,
	wr_bnode
};

In the current maple tree code, a walk down the tree is done in
mas_preallocate() to determine the number of nodes needed for this write.
After node allocation, mas_wr_store_entry() will perform another walk to
determine which write helper function to use to complete the write.

Rather than performing the second walk, we can store the type of write
in the maple write state during node allocation and read this field to
complete the write.

================================ RESULTS =================================

                  v6.10_mmap     v6.10_mmap_store_type
Duration User           9.80        8.69
Duration System      2295.94     2243.85
Duration Elapsed     1010.50     1009.44

================================ TESTING =================================

Testing was done with the maple tree test suite. A new test case is also
added to validate the order in which we test for and assign the store type.


[1]: https://lore.kernel.org/linux-mm/20240604174145.563900-1-sidhartha.kumar@oracle.com/
[2]: https://lists.infradead.org/pipermail/maple-tree/2023-December/003098.html


Sidhartha Kumar (16):
  maple_tree: introduce store_type enum
  maple_tree: introduce mas_wr_prealloc_setup()
  maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
  maple_tree: introduce mas_wr_store_type()
  maple_tree: remove mas_destroy() from mas_nomem()
  maple_tree: use mas_store_gfp() in mas_erase()
  maple_tree: use mas_store_gfp() in mtree_store_range()
  maple_tree: print store type in mas_dump()
  maple_tree: use store type in mas_wr_store_entry()
  maple_tree: convert mas_insert() to preallocate nodes
  maple_tree: simplify mas_commit_b_node()
  maple_tree: remove mas_wr_modify()
  maple_tree: have mas_store() allocate nodes if needed
  maple_tree: remove node allocations from various write helper
    functions
  maple_tree: remove repeated sanity checks from mas_wr_append()
  maple_tree: remove unneeded mas_wr_walk() in mas_store_prealloc()

 include/linux/maple_tree.h       |  15 +
 lib/maple_tree.c                 | 579 ++++++++++++++++++-------------
 tools/testing/radix-tree/maple.c |  48 ++-
 3 files changed, 401 insertions(+), 241 deletions(-)

-- 
2.45.2


