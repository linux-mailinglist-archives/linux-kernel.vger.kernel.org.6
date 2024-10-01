Return-Path: <linux-kernel+bounces-345994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B898BDFB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE93A28266D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BC1BFE02;
	Tue,  1 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iwQiDFpm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y1fPgMgK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567523D7A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789871; cv=fail; b=OZL/3QR042I+SQVGujGMD4Ec0XNPv4s95+O0hh+w+eW9u0Ly1o3kDAtZYfzdfwVJ9PbvMbAGpPFHY6bmVfnb2TzP8ENQvh2RsWmU9keyxwyIPBLw6/RzVLZWR27i4O7CjCdULd7xMvzZJq2jcauR3Ghbcv/6gZHkrcvNY/4Wkbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789871; c=relaxed/simple;
	bh=a4v8fIidXJK83iNxDTtoPBik5rPUjWZLkjt1tABFAQA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rtApGpOFiufbuUL0FFFNiicFzFORnr+fkInvfqUEnYr0nKWLUyxK8Bf4eP5kJVbuiGcBkV3PHmH+nCf3Sa8cBOa+lWYDIEHMF/jrq23DJZE77oDqSrkZGDh+9jn8mI79lBRgz4eE8K+yiqpBTWXqLkcucOW1PPPp1ym2ysu8Hcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iwQiDFpm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y1fPgMgK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491D5h2t005035;
	Tue, 1 Oct 2024 13:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=U1/vGkXlgOGKbP
	Yp3tL4VkmnOe2QGuXxDJOJuyDJr1o=; b=iwQiDFpm5A6D3tgn4L3hUDbMkhTG5W
	DdekMf/wU+9RPYNOLpk9pSPJisfiRSuiA4tnV9zELNCicR+1QLpu6DNQrs/E/SdN
	gtKYopk6+Xx+AtRyqLMspPn32wc1SVCJvqJIwQAXWwy1Q9n6XX19Fg4UROAj4pMo
	Tu3Wqd6QifGSl2iPB3LiEkiaK1ge2XVGnk/RhyOfC2hozr85Bsu22NadS93TdLn+
	QvObi7XFYfBRmF/hYciwvqp3bgze/u8pqtqXaY/INFGgO2e8XMdxCtw6Bmf3Ex1x
	n7MMAS3rX3dCh7zwBIN+Hr2x8Qac7gcBgUSaiDZleGu2FLWokJyu+OaQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb68ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 13:37:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491CCGJi028604;
	Tue, 1 Oct 2024 13:37:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887s2gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 13:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isIzH948e0+48w88V7je+4b9cXlu2Og04BVrCuuYFvQDgPVMYnjOvOQiCGNR6BFuw8KPnF1q2dkONWNTXaAMsYdo0W6Q3tboPtF5Q06MZiUiYivJjnpkyKeD9lzfjfSW+1zUw2SmWmiW4w2tYLfAJ0/mNOBvmMJOMJtDy8++hSJ7LWEXr/vaauAz8w0f1iobu5NFCsaz2b2l5eTmKVHbAaPh5AToeXkz0fNeRkQEu0XWmmBAZuNEFJnc5R/YiRTMl7OMm4cS4CY45aQxOmlbN8zjxFaaQMiLtajXVomhIR5cc91CHgtCu1BYFQ5TNUDMh4tIMqSE/99/fJ1L5PriLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1/vGkXlgOGKbPYp3tL4VkmnOe2QGuXxDJOJuyDJr1o=;
 b=N9yYeju7pW+hnQEwFYC+B7rhqYbMrz3HTwEipNkwtLGarb00LiZSIXTZ6z1JCGPSFedFc97IIFtigQdv+/w71emTmRk+HMJM0MEQ5XqRbkm5d3QknK/KjZBVlDFlr9uYIQvhjloe9V2Un918SNd5C8aYos79mydzg6BqnhbKK8TH8MV97fr6pDuLRZEMYsKcIBIaQtQM2uPIcY0LDNPqdZEwYl9sWbjr1gd9h1Dy3R7VI1RfR9iR8FeuwdANPiPb9YVfPrC8+F4i0uaTUtqHGg2ezuIeMe2RoBgGJ3EL3WnPkZupMtdVFD0YOEe/F2a4lFXxoW+igEiKDyotPtad2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1/vGkXlgOGKbPYp3tL4VkmnOe2QGuXxDJOJuyDJr1o=;
 b=Y1fPgMgKvzpsYDvxk6FJLJs1M1O7E8lWwsm0uuYTSZ1S5n//j5sOTiq7gkkriuTHblGd+DgLuH/gUwL3irENFCmHorJmKVfEbNgmwp9ZFOV+Af2N/QZwkZPmoO85NCRvSIFYEE5lBAfhLqK7QUlnwI5kLvUIJfptvhtlCNOPmK0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH2PR10MB4389.namprd10.prod.outlook.com (2603:10b6:610:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 13:37:37 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 13:37:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH hotfix 6.12] mm/mmap: correct error handling in mmap_region()
Date: Tue,  1 Oct 2024 14:37:26 +0100
Message-ID: <20241001133726.160275-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH2PR10MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac1a984-d3dc-4c43-c150-08dce21e36bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXjC1kQRdVpZsHBL5L+8hLAYo/ORipcPSRBooSD+iWc8DP3Lmg6cI1s5cPvV?=
 =?us-ascii?Q?t3lGw84k5Trbm/WOL33ZikNhKMuSKv/43gCMoeUzI8QZouRfRdmieolA96g7?=
 =?us-ascii?Q?9QgxrkHkEkQGNTEG2Bw9YYH6HIdbjig6XFRPBzmdQJC+/Kl0Eim8vzEg7MrS?=
 =?us-ascii?Q?59gPH5O5tjZJjqB9jdr1s9LVCW0wtSqYpHaekCxIHSHHksW9MoQC2TJ1wKYz?=
 =?us-ascii?Q?bTAyS4JPebLId+hThRwUB/x1ZHYNSw0IufDl8RV6oZbR18cT/7JYLNziivmg?=
 =?us-ascii?Q?7ayfVvPnZUCSkx+N9b7+xWzPFYsBOoyPmYmlrajdTJEmjD/7rAQ503ynJH4o?=
 =?us-ascii?Q?y1waJUUFCpvZ61zyIvgKWgXxEw8FgHA/881C/TYemex74KEu+fJnh21oFW5e?=
 =?us-ascii?Q?Rzf4RXZzXACKaFC34Sm1xsDyVpW0uinvz76xSafYJOOZATJY4dNpos3bbqcn?=
 =?us-ascii?Q?7Wj0RS+zJRVvQNMcOBS1OR8TEFEJhqdqY4hDXcK/EwfCseRvRjiZr8gXL7bN?=
 =?us-ascii?Q?oR/UjsOngSDT0RJJBDRmHb2FeVCsi4eJA/wqnRHkQ78XORopH/yDMZzSIJ0q?=
 =?us-ascii?Q?7iwSFuRvexFvzUoCoy/TIm7dyJlM422lEYHoabiGRAgpprRARXKaOaPMkr7e?=
 =?us-ascii?Q?E1MR1HOEwI6QtZeMNtLMwuBD/5Vk22Sx1iyVHllJ/o3OPA4ZKGvLB1PkxAin?=
 =?us-ascii?Q?EYH2d+rNENAyeFvzEebFL0c+f8ZptpBBgH29Q22f/qzAgjrLiU0nT9cY2E9R?=
 =?us-ascii?Q?U3NN5XhkB1RuO42zQ7Br0zg4tbrKSQjcgqoyIndtPewVl0dG0GLNhgD1D9he?=
 =?us-ascii?Q?/iZIKDtJVe2vdSJzHkR2iWVxwx0hjcKSrl0LDkqbqxDojh9LWQsPS9MMwdHa?=
 =?us-ascii?Q?cxBMFcVh7jD7hhUGX8lv5PxpBCkdP7weBrFa2tRzDjDVMsz9Ul5y133PiLOT?=
 =?us-ascii?Q?i+hUeupL0Co+nkFZ2cML1XQ3Spt5zLud8c5HNf8c3OFPYrYhtxrXMYNWZxq8?=
 =?us-ascii?Q?vhspHCm/vOFNPj2aSchPiCx+LT9CuiPS9VL68n8SXv6TMYrnowXFPnlEbkeH?=
 =?us-ascii?Q?PoYAkRlEoyK7gLobMvnvlD6fAQri3GmwXd/MGAtMBu1lmRvEflxvg7G0k/zZ?=
 =?us-ascii?Q?lD8YOoqCsK3eo1WHIGYP2h6c97Cjpaci8R0k/EEDZAc+LIuFm0HXEDKVooSY?=
 =?us-ascii?Q?5ULxE5k1NpmffWe/1TBmVTis2v2vR97xRUSnqmH9jP0EC+9T9Vwzxho5LL5A?=
 =?us-ascii?Q?OtVVmeq96/PBRRL31xKwYfn/6WrnLbr0+mLNfpkDaMD5Lxv+OlrIz+92+vBL?=
 =?us-ascii?Q?+VkP7uqkKTwBUl2fm6F7zqoEyNjb+kUMPNrIGZneSzWUJkGqaS+lfm3Rrib0?=
 =?us-ascii?Q?jq1cH7w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvx8aF2qSBNMYnxMA9ooYUsPoKEjji5j6z8D/CqeepckIk2acAHohx0eNbD/?=
 =?us-ascii?Q?njyegnNDLRUhq3CqBa23rRn1tEK4tLxc47mdGPhzWd+Xiba+5q5pChmfdMa4?=
 =?us-ascii?Q?em2JGhe5sJUJtcSrnOOjScIfLn1u1tn2iruYEnsmtqbx21K1MbE2SKQK4bzA?=
 =?us-ascii?Q?emaU8Iu/pAMwINSxzIlI9SFlWPqbfGXzAmHUBxQz2fYT42PGOXgox5NJ8P0u?=
 =?us-ascii?Q?TYuTN6ujlBc+a2IOSwv3cAoQgLqJjEkC2CvMWdHUdc0ikKbxMiJQlocjk4HO?=
 =?us-ascii?Q?XKUfjt6yzJuR+i4o9gTM9FSSVm7IiamxPOdMCkoihAqqedC436Sngf3uc51u?=
 =?us-ascii?Q?hNN2ihqLYFij9hb3+s0SxpvNCqE9BzU5je7/Q3PfcZBQBIJqchKMCqWVV06s?=
 =?us-ascii?Q?H3oxR//coEmKEThAbCD6mHFfvXlI8icTLnGuSr4H3P712IildmOK4+XHtMgK?=
 =?us-ascii?Q?yPtEdP7mKq+mfo0ifO623LC9U1kRxSPm7xqnROZ3yoH3dxR0/QV6jvYxA810?=
 =?us-ascii?Q?TBPTlFW9OCjS/j6VQZKZZQdLcFbproZ6TeVi8YLUXQXdClJ3s223YaKOR7GU?=
 =?us-ascii?Q?GoB6hUoiYbamiblMl8ZIcAOlfOgjcTmgCMJEMTUNLfU/TkgwsNdCQA6P5SRf?=
 =?us-ascii?Q?u6OMP63refYPoDHH1DEwZ94LhJX/8Qnre3xcaoj0Ch5qV3ImYTpIV1CWpxUx?=
 =?us-ascii?Q?pCDTqAR4/16WU7ZD5p4eXlIgtaocg3VU87xWtZoziDIEUterLlYpkrUb6rHC?=
 =?us-ascii?Q?G6PvqwrXLwDOy/w952d7iy3Oz9dt6WspQ5/enfoiN2n+fgKqEDHJWYuDFxSR?=
 =?us-ascii?Q?QjQeFYww6IvJFQpTs5UGngBjyVcmDK17PfiU6K29fTduH0+nzAJTZ4UsVJsm?=
 =?us-ascii?Q?Y8wUZGtXHESnKUB8rk6r7xJr9s6OfyiqUj9bJsewcE3LRKe7eah6BAEdM99M?=
 =?us-ascii?Q?945VvpSdvPHKD4meP5XV05WFllbtKIZdov2e9R/Ks53ayqSDC5VV+WIRUXCV?=
 =?us-ascii?Q?HcpzdnC5ALOZ8uixLbmwG3Irf2qGEVAPU3gYCLJ9WYJmZbipxyPMxGzU0fWT?=
 =?us-ascii?Q?rdqCjxE3zpUjfZrhVrcN7cDgW5Wg1PWtztEsvxEmogSdnMo+ZPvjtBrpabKA?=
 =?us-ascii?Q?Jm9iuHdLFRZyCeZF8yswSe0T8W3JyxRfWhCTdviPkgZbm5sRr5IXG8EgexRK?=
 =?us-ascii?Q?wf4VNasS/bfPd/88lkcqSaMiTwNpYE/M84ox8ARvPs5XvVVDPc6ZLmYSeNtH?=
 =?us-ascii?Q?oP6MphpsCv1WNHscSk46dE8UZS3EJP0jfdZdxbefpAXsEW4ee9palsb+4Y6m?=
 =?us-ascii?Q?WqSQnX/8kY5tX9OLh2nefmb2EmZrXooDCZcL/6qUoTyzYqqZAC4Cd+e4myjQ?=
 =?us-ascii?Q?AooBgfN3AHjR7EgZYfi6h05gyJ1rrl8Mi/nLlSNTZET8a3UO46O+HKXwsOuZ?=
 =?us-ascii?Q?n4LCLGpPC1CXNq19JTaXw/oWhvxuUQt1i6vyjH5r7FzQnYjJ8kzOh45TA6EX?=
 =?us-ascii?Q?Dcj7oqBGDPlTaJSuOrgRASDmgLQ+O3n1a01RM05UbAsXAmNAlZhjB73jCJVd?=
 =?us-ascii?Q?rtfeQlDywPzbsxY+5z2l6BV9TWSfKfomMER+62i+kZnSrXCMQHyhYgsFbjFv?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r35TrYqasi5M145zLO5xHJl6KZDvDHmnxLgSipqOVDng+OA8uW0Sz7rADgoa1cHqN6HnC4Jn2ryv7VO4ywTBu5WS5EA4t+Jg04OjL5FzX2jkK+TxDAlPXEx8JqH4pA2kgqwJVNxlDRV+ZS2PWT/pNihv33hP5wVmVSbK6daO8ZGTzelW61DogMi9HclNXQT7seKPyBr+ZfOKtwCKTp+0Ixjg3gJYu2t+bSOucyk0/otWR9yEv37scQsjFS1mkV4sjaxePUsKNtPydCumHmxWaHNLGSzRNVXj6hPdlWMgxz9EXkGNf7iUqvcc5mRXoTqtiUFkp58YPvMo43J8I8VUhMK10zxOeUQ2vqK0s2DZJZhjkAvqefX6f2KsRC95qU8U6v1keC6DH2qZEHKeWQVAUKLy4TQzOXPPrpOZi5yY15A8/uJqOTK5jAAB9agHU1VdSiJMkD7V3DbkcPdNKRVDOG9gH+JWp8bTZMkGjREG47Id7r+hBCIjwuETalOkDjF+mpKlb8OxPmbXrU3N5y+hxn6QhiDq1ynn+/GqauJh0UbWaKhqugHAkMjCcdc/91ikPIfNqUCsRuEVNyvBycQrPrKOcV8MpswuyIrwEaUhawg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac1a984-d3dc-4c43-c150-08dce21e36bd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:37:37.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0gC4UNf+EuagmcB2/u83vZmFshBIhMA0PDgIbPV6rpsL18udmXrugszyN8r/Q/0gOGdUPjjiHuCNVQ+b5qQf3q9/xpUL6nBivTHlMkQ4CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010087
X-Proofpoint-GUID: Q5ZOy8a_XriOIiXAzE9RciXyapb0PHS0
X-Proofpoint-ORIG-GUID: Q5ZOy8a_XriOIiXAzE9RciXyapb0PHS0

Commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
changed how error handling is performed in mmap_region().

The error value defaults to -ENOMEM, but then gets reassigned immediately
to the result of vms_gather_munmap_vmas() if we are performing a MAP_FIXED
mapping over existing VMAs (and thus unmapping them).

This overwrites the error value, potentially clearing it.

After this, we invoke may_expand_vm() and possibly vm_area_alloc(), and
check to see if they failed. If they do so, then we perform error-handling
logic, but importantly, we do NOT update the error code.

This means that, if vms_gather_munmap_vmas() succeeds, but one of these
calls does not, the function will return indicating no error, but rather an
address value of zero, which is entirely incorrect.

Correct this and avoid future confusion by strictly setting error on each
and every occasion we jump to the error handling logic, and set the error
code immediately prior to doing so.

This way we can see at a glance that the error code is always correct.

Many thanks to Vegard Nossum who spotted this issue in discussion around
this problem.

Reported-by: Bert Karwatzki <spasswolf@web.de>
Link: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..9c0fb43064b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1371,7 +1371,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	bool writable_file_mapping = false;
-	int error = -ENOMEM;
+	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

@@ -1396,8 +1396,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}

 	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
+		error = -ENOMEM;
 		goto abort_munmap;
+	}

 	/*
 	 * Private writable mapping: check memory availability
@@ -1405,8 +1407,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (accountable_mapping(file, vm_flags)) {
 		charged = pglen;
 		charged -= vms.nr_accounted;
-		if (charged && security_vm_enough_memory_mm(mm, charged))
-			goto abort_munmap;
+		if (charged) {
+			error = security_vm_enough_memory_mm(mm, charged);
+			if (error)
+				goto abort_munmap;
+		}

 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
@@ -1422,8 +1427,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma)
+	if (!vma) {
+		error = -ENOMEM;
 		goto unacct_error;
+	}

 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -1453,9 +1460,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
 		 */
-		error = -EINVAL;
-		if (WARN_ON((addr != vma->vm_start)))
+		if (WARN_ON((addr != vma->vm_start))) {
+			error = -EINVAL;
 			goto close_and_free_vma;
+		}

 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -1500,13 +1508,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}

 	/* Allow architectures to sanity-check the vm_flags */
-	error = -EINVAL;
-	if (!arch_validate_flags(vma->vm_flags))
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error = -EINVAL;
 		goto close_and_free_vma;
+	}

-	error = -ENOMEM;
-	if (vma_iter_prealloc(&vmi, vma))
+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
 		goto close_and_free_vma;
+	}

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
--
2.46.2

